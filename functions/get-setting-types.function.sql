-- FUNCTION: public.get_setting_types()

-- DROP FUNCTION IF EXISTS public.get_setting_types();

CREATE OR REPLACE FUNCTION public.get_setting_types(
)
    RETURNS character varying[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
    result varchar[];

begin
    select enum_range(NULL::setting_type) into result;
    return result;
end;
$BODY$;

ALTER FUNCTION public.get_setting_types()
    OWNER TO postgres;
