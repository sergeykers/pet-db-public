-- FUNCTION: public.add_app_setting(character varying, character varying, setting_type)

-- DROP FUNCTION IF EXISTS public.add_app_setting(character varying, character varying, setting_type);

CREATE OR REPLACE FUNCTION public.add_app_setting(
    key character varying,
    value character varying,
    type setting_type)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
    result integer;
begin
    if ((trim($1) = '') or (trim($3) = '')) is true
    then raise exception 'Key and type should be set';
    end if;

    if (select count(*) from public."APP_SETTINGS" as tableA where tableA.key = $1 and tableA.type = $3) <> 0
    then raise exception 'This key exists already';
    end if;

    insert into
        public."APP_SETTINGS" (key, value, type)
    values ($1, $2, $3)
    returning id into result;

    return result;
end;
$BODY$;

ALTER FUNCTION public.add_app_setting(character varying, character varying, setting_type)
    OWNER TO postgres;
