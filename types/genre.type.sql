-- Type: genre

-- DROP TYPE IF EXISTS public.genre;

CREATE TYPE public.genre AS ENUM
    ('comedy', 'action', 'thriller', 'horror', 'drama', 'dorama', 'anime', 'cartoon', '3D-animation', 'tragedy', 'catastrophe', 'series', 'detective', 'suspence', 'documentary', 'nature', 'biography', 'sports', 'sci-fi', 'fantasy', 'adventure');

ALTER TYPE public.genre
    OWNER TO postgres;
