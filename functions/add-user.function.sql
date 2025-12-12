-- FUNCTION: public.add_user(character varying, character varying, access[])

-- DROP FUNCTION IF EXISTS public.add_user(character varying, character varying, access[]);

CREATE OR REPLACE FUNCTION public.add_user(
    name character varying,
    password character varying,
    access access[])
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
    result integer;
    test varchar;

begin
    if ($1 <> '') and ($2 <> '') and (array_length($3, 1) <> 0) and (select count(*) from public."USERS" as tableA where tableA.name = $1) = 0
    then
        insert into public."USERS" as tableA
        (name, password, access)
        VALUES ($1, MD5($2), $3)
        returning tableA.id into result;

    else raise exception 'User was not created, exists already or insufficient args';
    end if;

    return result;
end;
$BODY$;

ALTER FUNCTION public.add_user(character varying, character varying, access[])
    OWNER TO postgres;
