-- FUNCTION: public.connection_check()

-- DROP FUNCTION IF EXISTS public.connection_check();

CREATE OR REPLACE FUNCTION public.connection_check(
)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
    result json default json_object('{"result", true}');

begin
    return result;
end;
$BODY$;

ALTER FUNCTION public.connection_check()
    OWNER TO postgres;
