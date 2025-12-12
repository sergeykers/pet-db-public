-- Table: public.APP_SETTINGS

-- DROP TABLE IF EXISTS public."APP_SETTINGS";

CREATE TABLE IF NOT EXISTS public."APP_SETTINGS"
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    key character varying(32) COLLATE pg_catalog."default" NOT NULL,
    value character varying(255) COLLATE pg_catalog."default",
    type character varying(6) COLLATE pg_catalog."default",
    CONSTRAINT "APP_SETTINGS_pkey" PRIMARY KEY (id)
)

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."APP_SETTINGS"
    OWNER to postgres;
