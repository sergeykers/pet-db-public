-- FUNCTION: public.set_movie(integer, character varying, character varying, genre[], character varying, integer, quality, character varying)

-- DROP FUNCTION IF EXISTS public.set_movie(integer, character varying, character varying, genre[], character varying, integer, quality, character varying);

CREATE OR REPLACE FUNCTION public.set_movie(
    id integer,
    original_title character varying,
    russian_title character varying,
    genre genre[],
    imdb_id character varying,
    year integer,
    quality quality,
    file_path character varying)
    RETURNS jsonb
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
    result jsonb;
    movie_data record;

begin
    if  (id is null) or (original_title = '') or (russian_title = '') or (file_path = '')
    then raise exception 'Insufficient args';
    end if;

    if (select count(*) from public."MOVIES_LIST" as tableA where tableA.id = $1) <> 0
    then update public."MOVIES_LIST" as tableA set
                                                   original_title = $2,
                                                   russian_title = $3,
                                                   genre = $4,
                                                   imdb_id = $5,
                                                   year = $6,
                                                   quality = $7,
                                                   file_path = $8
         where
                 tableA.id = $1
         returning * into movie_data;
    else raise exception 'Record not found';
    end if;

    result = row_to_json(movie_data);

    return result;
end;
$BODY$;

ALTER FUNCTION public.set_movie(integer, character varying, character varying, genre[], character varying, integer, quality, character varying)
    OWNER TO postgres;
