-- FUNCTION: public.get_user(character varying, character varying)

-- DROP FUNCTION IF EXISTS public.get_user(character varying, character varying);

CREATE OR REPLACE FUNCTION public.get_user(name character varying, password character varying)
    RETURNS jsonb
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
    result jsonb;
    user_data record;

begin
    if ($1 IS NOT NULL and $1 <> '') and ($2 IS NOT NULL and $2 <> '')
    then
        select tableA.id, tableA.name, tableA.access from public."USERS" as tableA into user_data where tableA.name = $1 and tableA.password = MD5($2);
        result = row_to_json(user_data);

    else raise exception 'Insufficient args';
    end if;

    return result;
end;
$BODY$;

ALTER FUNCTION public.get_user(character varying, character varying)
    OWNER TO postgres;
