-- FUNCTION: public.remove_app_setting(integer)

-- DROP FUNCTION IF EXISTS public.remove_app_setting(integer);

CREATE OR REPLACE FUNCTION public.remove_app_setting(
    id integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
    result integer;

begin
    delete from
        public."APP_SETTINGS" as tableA
    where tableA.id = $1
    returning tableA.id into result;

    if result is null
    then raise exception 'Key does not exist';
    end if;

    return result;
end;
$BODY$;

ALTER FUNCTION public.remove_app_setting(integer)
    OWNER TO postgres;
