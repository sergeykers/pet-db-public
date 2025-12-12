-- FUNCTION: public.get_access()

-- DROP FUNCTION IF EXISTS public.get_access();

CREATE OR REPLACE FUNCTION public.get_access(
)
    RETURNS character varying[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
    result varchar[];

begin
    select enum_range(NULL::access) into result;
    return result;
end;
$BODY$;

ALTER FUNCTION public.get_access()
    OWNER TO postgres;
