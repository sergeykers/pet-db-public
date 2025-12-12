-- Type: access

-- DROP TYPE IF EXISTS public.access;

CREATE TYPE public.access AS ENUM
    ('login', 'view_movies_list', 'edit_movies_list');

ALTER TYPE public.access
    OWNER TO postgres;
