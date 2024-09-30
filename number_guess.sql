--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: players; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.players (
    player_id integer NOT NULL,
    name character varying(22) NOT NULL,
    games_played integer NOT NULL,
    best_game integer NOT NULL
);


ALTER TABLE public.players OWNER TO freecodecamp;

--
-- Name: players_player_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.players_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_player_id_seq OWNER TO freecodecamp;

--
-- Name: players_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.players_player_id_seq OWNED BY public.players.player_id;


--
-- Name: players player_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players ALTER COLUMN player_id SET DEFAULT nextval('public.players_player_id_seq'::regclass);


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.players VALUES (20, 'user_1727660494785', 2, 8);
INSERT INTO public.players VALUES (3, 'TEST', 4, 9);
INSERT INTO public.players VALUES (19, 'user_1727660494786', 5, 186);
INSERT INTO public.players VALUES (5, 'user_1727659137057', 2, 727);
INSERT INTO public.players VALUES (4, 'user_1727659137058', 5, 396);
INSERT INTO public.players VALUES (22, 'user_1727660529754', 2, 512);
INSERT INTO public.players VALUES (7, 'user_1727659227861', 2, 61);
INSERT INTO public.players VALUES (21, 'user_1727660529755', 5, 299);
INSERT INTO public.players VALUES (6, 'user_1727659227862', 5, 229);
INSERT INTO public.players VALUES (9, 'user_1727659389556', 2, 48);
INSERT INTO public.players VALUES (8, 'user_1727659389557', 5, 60);
INSERT INTO public.players VALUES (12, 'user_1727659622661', 2, 55);
INSERT INTO public.players VALUES (11, 'user_1727659622662', 5, 286);
INSERT INTO public.players VALUES (14, 'user_1727659726156', 2, 6);
INSERT INTO public.players VALUES (13, 'user_1727659726157', 5, 38);
INSERT INTO public.players VALUES (1, 'Jim', 3, 1);
INSERT INTO public.players VALUES (16, 'user_1727659935086', 2, 176);
INSERT INTO public.players VALUES (15, 'user_1727659935087', 5, 473);
INSERT INTO public.players VALUES (10, 'Mikey', 2, 10);
INSERT INTO public.players VALUES (18, 'user_1727660405736', 2, 720);
INSERT INTO public.players VALUES (17, 'user_1727660405737', 5, 50);


--
-- Name: players_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.players_player_id_seq', 22, true);


--
-- Name: players players_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_name_key UNIQUE (name);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (player_id);


--
-- PostgreSQL database dump complete
--

