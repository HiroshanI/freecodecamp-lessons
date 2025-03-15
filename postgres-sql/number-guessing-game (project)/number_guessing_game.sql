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

ALTER TABLE ONLY public.games DROP CONSTRAINT games_user_id_fkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.games DROP CONSTRAINT games_pkey;
ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
ALTER TABLE public.games ALTER COLUMN game_id DROP DEFAULT;
DROP SEQUENCE public.users_user_id_seq;
DROP TABLE public.users;
DROP SEQUENCE public.games_game_id_seq;
DROP TABLE public.games;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    user_id integer NOT NULL,
    n_guesses integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 1, 15);
INSERT INTO public.games VALUES (2, 1, 10);
INSERT INTO public.games VALUES (3, 1, 8);
INSERT INTO public.games VALUES (4, 2, 771);
INSERT INTO public.games VALUES (5, 2, 818);
INSERT INTO public.games VALUES (6, 3, 604);
INSERT INTO public.games VALUES (7, 3, 136);
INSERT INTO public.games VALUES (8, 2, 269);
INSERT INTO public.games VALUES (9, 2, 538);
INSERT INTO public.games VALUES (10, 2, 603);
INSERT INTO public.games VALUES (11, 4, 256);
INSERT INTO public.games VALUES (12, 4, 206);
INSERT INTO public.games VALUES (13, 5, 327);
INSERT INTO public.games VALUES (14, 5, 917);
INSERT INTO public.games VALUES (15, 4, 14);
INSERT INTO public.games VALUES (16, 4, 324);
INSERT INTO public.games VALUES (17, 4, 239);
INSERT INTO public.games VALUES (18, 6, 342);
INSERT INTO public.games VALUES (19, 6, 760);
INSERT INTO public.games VALUES (20, 7, 421);
INSERT INTO public.games VALUES (21, 7, 503);
INSERT INTO public.games VALUES (22, 6, 439);
INSERT INTO public.games VALUES (23, 6, 363);
INSERT INTO public.games VALUES (24, 6, 166);
INSERT INTO public.games VALUES (25, 8, 485);
INSERT INTO public.games VALUES (26, 8, 138);
INSERT INTO public.games VALUES (27, 9, 830);
INSERT INTO public.games VALUES (28, 9, 960);
INSERT INTO public.games VALUES (29, 8, 759);
INSERT INTO public.games VALUES (30, 8, 52);
INSERT INTO public.games VALUES (31, 8, 615);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'H');
INSERT INTO public.users VALUES (2, 'user_1742025144494');
INSERT INTO public.users VALUES (3, 'user_1742025144493');
INSERT INTO public.users VALUES (4, 'user_1742025227762');
INSERT INTO public.users VALUES (5, 'user_1742025227761');
INSERT INTO public.users VALUES (6, 'user_1742025285614');
INSERT INTO public.users VALUES (7, 'user_1742025285613');
INSERT INTO public.users VALUES (8, 'user_1742025306753');
INSERT INTO public.users VALUES (9, 'user_1742025306752');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 31, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 9, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

