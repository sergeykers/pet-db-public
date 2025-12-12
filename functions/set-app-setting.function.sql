-- FUNCTION: public.set_app_setting(integer, character varying, character varying)

-- DROP FUNCTION IF EXISTS public.set_app_setting(integer, character varying, character varying);

CREATE OR REPLACE FUNCTION public.set_app_setting(
    id integer,
    key character varying,
    value character varying)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
    result integer;

begin
    if (trim($2) = '')
    then raise exception 'Key should be set';
    end if;

    if ($3 is not null) and (select count(*) from public."APP_SETTINGS" as tableA where tableA.id = $1) <> 0
    then update public."APP_SETTINGS" as tableA set key = $2, value = $3 where tableA.id = $1
         returning tableA.id into result;

    else raise exception 'No such record';
    end if;

    return result;
end;
$BODY$;

ALTER FUNCTION public.set_app_setting(integer, character varying, character varying)
    OWNER TO postgres;
