-- FUNCTION: public.add_movie(character varying, character varying, genre[], character varying, integer, quality, character varying)

-- DROP FUNCTION IF EXISTS public.add_movie(character varying, character varying, genre[], character varying, integer, quality, character varying);

CREATE OR REPLACE FUNCTION public.add_movie(
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
    if (original_title = '') or (russian_title = '') or (file_path = '')
    then raise exception 'Insufficient args';
    end if;

    if (select count(*) from public."MOVIES_LIST" as tableA
        where tableA.original_title = $1 and (
                (tableA.year is not null and tableA.year = $5)
                or
                (tableA.russian_title is not null and tableA.russian_title <> '' and tableA.russian_title = $2)
            )
       ) <> 0

    then raise exception 'This movie was added already';
    end if;

    insert into public."MOVIES_LIST" as tableA
    (original_title, russian_title, genre, imdb_id, year, quality, file_path)
    values ($1, $2, $3, $4, $5, $6, $7)
    returning * into movie_data;

    result = row_to_json(movie_data);

    return result;
end;
$BODY$;

ALTER FUNCTION public.add_movie(character varying, character varying, genre[], character varying, integer, quality, character varying)
    OWNER TO postgres;
