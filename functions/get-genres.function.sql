-- FUNCTION: public.get_genres()

-- DROP FUNCTION IF EXISTS public.get_genres();

CREATE OR REPLACE FUNCTION public.get_genres(
)
    RETURNS character varying[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
    result varchar[];

begin
    select enum_range(NULL::genre) into result;
    return result;
end;
$BODY$;

ALTER FUNCTION public.get_genres()
    OWNER TO postgres;
