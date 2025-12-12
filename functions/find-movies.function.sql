-- FUNCTION: public.find_movies(character varying, character varying, genre[], character varying, integer, quality)

-- DROP FUNCTION IF EXISTS public.find_movies(character varying, character varying, genre[], character varying, integer, quality);

CREATE OR REPLACE FUNCTION public.find_movies(
    original_title character varying DEFAULT NULL::character varying,
    russian_title character varying DEFAULT NULL::character varying,
    genre genre[] DEFAULT NULL::genre[],
    imdb_id character varying DEFAULT NULL::character varying,
    year integer DEFAULT NULL::integer,
    quality quality DEFAULT NULL::quality)
    RETURNS jsonb
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
    result jsonb;
    request varchar(255);
    search_options varchar(255);
begin
    request = 'SELECT json_agg(row_to_json(tableA)) FROM public."MOVIES_LIST" as tableA';

    if ($1 <> '' AND $1 IS NOT NULL) then
        search_options = CONCAT(' tableA.original_title LIKE ''%', $1, '%'' ');
    end if;

    if ($2 <> '' AND $2 IS NOT NULL) then
        if (LENGTH(search_options) <> 0) then
            search_options = CONCAT(search_options, ' AND tableA.russian_title LIKE ''%', $2, '%'' ');
        else
            search_options = CONCAT(' tableA.russian_title LIKE ''%', $2, '%'' ');
        end if;
    end if;

    if ($3 IS NOT NULL) then
        if (LENGTH(search_options) <> 0) then
            search_options = CONCAT(search_options, ' AND tableA.genre @> ''', $3, '''' );
        else
            search_options = CONCAT(' tableA.genre @> ''', $3, '''');
        end if;
    end if;

    if ($4 <> '' AND $4 IS NOT NULL) then
        if (LENGTH(search_options) <> 0) then
            search_options = CONCAT(search_options, ' AND tableA.imdb_id LIKE ''%', $4, '%'' ');
        else
            search_options = CONCAT(' tableA.imdb_id LIKE ''%', $4, '%'' ');
        end if;
    end if;

    if ($5 IS NOT NULL) then
        if (LENGTH(search_options) <> 0) then
            search_options = CONCAT(search_options, ' AND tableA.year = $5 ');
        else
            search_options = CONCAT(' tableA.year = ', $5);
        end if;
    end if;

    if ($6 IS NOT NULL) then
        if (LENGTH(search_options) <> 0) then
            search_options = CONCAT(search_options, ' AND tableA.quality::text = ''', $6::text, '''');
        else
            search_options = CONCAT(' tableA.quality::text = ''', $6::text, '''');
        end if;
    end if;

    if (LENGTH(search_options) <> 0) then
        request = CONCAT(request, ' WHERE ', search_options);
    end if;

    EXECUTE request INTO result;

    return result;
end;
$BODY$;

ALTER FUNCTION public.find_movies(character varying, character varying, genre[], character varying, integer, quality)
    OWNER TO postgres;
