-- FUNCTION: public.get_quality()

-- DROP FUNCTION IF EXISTS public.get_quality();

CREATE OR REPLACE FUNCTION public.get_quality(
)
    RETURNS character varying[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
    result varchar[];

begin
    select enum_range(NULL::quality) into result;
    return result;
end;
$BODY$;

ALTER FUNCTION public.get_quality()
    OWNER TO postgres;
