-- Type: setting_type

-- DROP TYPE IF EXISTS public.setting_type;

CREATE TYPE public.setting_type AS ENUM
    ('server', 'client');

ALTER TYPE public.setting_type
    OWNER TO postgres;
