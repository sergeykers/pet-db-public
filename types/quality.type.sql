-- Type: quality

-- DROP TYPE IF EXISTS public.quality;

CREATE TYPE public.quality AS ENUM
    ('low', 'satisfying', 'good', 'excellent');

ALTER TYPE public.quality
    OWNER TO postgres;
