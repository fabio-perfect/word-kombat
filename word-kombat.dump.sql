SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

CREATE TABLE "Competitors" (
    "UserId" integer NOT NULL,
    "MatchId" integer NOT NULL
);

ALTER TABLE "Competitors" OWNER TO word_master;

CREATE TABLE "Dictionaries" (
    "UserId" integer NOT NULL,
    "WordId" integer NOT NULL
);

ALTER TABLE "Dictionaries" OWNER TO word_master;

CREATE TABLE "MatchScores" (
    id integer NOT NULL,
    score integer,
    "MatchId" integer,
    "UserId" integer,
    "WordId" integer
);

ALTER TABLE "MatchScores" OWNER TO word_master;

CREATE SEQUENCE "MatchScores_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "MatchScores_id_seq" OWNER TO word_master;

ALTER SEQUENCE "MatchScores_id_seq" OWNED BY "MatchScores".id;

CREATE TABLE "Matches" (
    id integer NOT NULL,
    "startTime" timestamp with time zone,
    "endTime" timestamp with time zone
);

ALTER TABLE "Matches" OWNER TO word_master;

CREATE SEQUENCE "Matches_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "Matches_id_seq" OWNER TO word_master;

ALTER SEQUENCE "Matches_id_seq" OWNED BY "Matches".id;

CREATE TABLE "Ranks" (
    id integer NOT NULL,
    name character varying(255),
    "minScore" integer,
    image character varying(255)
);

ALTER TABLE "Ranks" OWNER TO word_master;

CREATE SEQUENCE "Ranks_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "Ranks_id_seq" OWNER TO word_master;

ALTER SEQUENCE "Ranks_id_seq" OWNED BY "Ranks".id;

CREATE TABLE "Users" (
    id integer NOT NULL,
    email character varying(255),
    name character varying(255),
    password character varying(255),
    icon character varying(255),
    score integer,
    rank_id integer
);

ALTER TABLE "Users" OWNER TO word_master;

CREATE SEQUENCE "Users_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "Users_id_seq" OWNER TO word_master;

ALTER SEQUENCE "Users_id_seq" OWNED BY "Users".id;

CREATE TABLE "Words" (
    id integer NOT NULL,
    value character varying(255),
    image character varying(255),
    hint text
);

ALTER TABLE "Words" OWNER TO word_master;

CREATE SEQUENCE "Words_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Words_id_seq" OWNER TO word_master;

ALTER SEQUENCE "Words_id_seq" OWNED BY "Words".id;

ALTER TABLE ONLY "MatchScores" ALTER COLUMN id SET DEFAULT nextval('"MatchScores_id_seq"'::regclass);

ALTER TABLE ONLY "Matches" ALTER COLUMN id SET DEFAULT nextval('"Matches_id_seq"'::regclass);

ALTER TABLE ONLY "Ranks" ALTER COLUMN id SET DEFAULT nextval('"Ranks_id_seq"'::regclass);

ALTER TABLE ONLY "Users" ALTER COLUMN id SET DEFAULT nextval('"Users_id_seq"'::regclass);

ALTER TABLE ONLY "Words" ALTER COLUMN id SET DEFAULT nextval('"Words_id_seq"'::regclass);

SELECT pg_catalog.setval('"MatchScores_id_seq"', 1, false);

SELECT pg_catalog.setval('"Matches_id_seq"', 1, false);

COPY "Ranks" (id, name, "minScore", image) FROM stdin;
1	1	0	assets/images/ranks/1.png
2	2	100	assets/images/ranks/2.png
3	3	500	assets/images/ranks/3.png
4	4	2000	assets/images/ranks/4.png
5	5	10000	assets/images/ranks/5.png
6	6	50000	assets/images/ranks/6.png
\.


SELECT pg_catalog.setval('"Ranks_id_seq"', 1, false);

SELECT pg_catalog.setval('"Users_id_seq"', 1, true);

INSERT INTO "Words" VALUES(1, 'cat', 
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/cat.jpg', 
  'It''s a small, typically furry, animal');

INSERT INTO "Words" VALUES(2, 'dog', 
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/dog.jpg',
  'They have been bred by humans for a long time, and probably were the first animals ever to be domesticated');

INSERT INTO "Words" VALUES(3, 'bird',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/bird.jpg',
  'Their bodies are covered with feathers and they have wings');

INSERT INTO "Words" VALUES(4, 'wolf',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/wolf.jpg',
  'An ancestor of the domestic dog');

INSERT INTO "Words" VALUES(5, 'fox',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/fox.jpg',
  'They hunt and eat live prey, mostly rabbits and rodents (rats and mice)');

INSERT INTO "Words" VALUES(6, 'lion',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/lion.jpg',
  'The king of the jungle');

INSERT INTO "Words" VALUES(7, 'tiger',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/tiger.jpg',
  'They are most recognisable for their pattern of dark vertical stripes on reddish-orange fur with a lighter underside');

INSERT INTO "Words" VALUES(8, 'hen',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/hen.jpg',
  'It is raised widely for its meat and eggs');

INSERT INTO "Words" VALUES(9, 'cow',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/cow.jpg',
  'Large grass-eating mammal');

INSERT INTO "Words" VALUES(10, 'bull',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/bull.jpg',
  'It''s an adult male of the cattle');

INSERT INTO "Words" VALUES(11, 'add',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/add.png',
  'Arithmetical operation');

INSERT INTO "Words" VALUES(12, 'subtract',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/subtract.png',
  'Arithmetical operation');

INSERT INTO "Words" VALUES(12, 'divide',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/divide.jpg',
  'Arithmetical operation');

INSERT INTO "Words" VALUES(13, 'multiply',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/multiply.png',
  'Arithmetical operation');

INSERT INTO "Words" VALUES(14, 'time',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/time.jpg',
  'It''s the indefinite continued progress of existence and events that occur in apparently irreversible succession from the past through the present to the future');

INSERT INTO "Words" VALUES(15, 'people',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/people.jpg',
  'It''s a plurality of persons considered as a whole');
  
INSERT INTO "Words" VALUES(16, 'way',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/way.jpg',
  'A road, route, path or pathway');

INSERT INTO "Words" VALUES(16, 'day',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/day.jpg',
  'A unit of time. In common usage, it is either an interval equal to 24 hours or the consecutive period of time during which the Sun is above the horizon');

INSERT INTO "Words" VALUES(17, 'world',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/world.jpg',
  'The planet Earth and all life upon it');

INSERT INTO "Words" VALUES(18, 'school',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/school.jpg',
  'An institution designed to provide learning spaces and learning environments for the teaching of students (or "pupils") under the direction of teachers');

INSERT INTO "Words" VALUES(19, 'hand',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/hand.jpg',
  'The part of the body at the end of the arm');

INSERT INTO "Words" VALUES(20, 'system',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/system.jpg',
  'A set of interacting or interdependent component parts forming a complex or intricate whole');

INSERT INTO "Words" VALUES(21, 'program',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/program.png',
  'A collection of instructions that performs a specific task when executed by a computer');

INSERT INTO "Words" VALUES(22, 'question',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/question.jpg',
  'A linguistic expression used to make a request for information');

INSERT INTO "Words" VALUES(23, 'work',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/work.jpg',
  'Physical or mental effort or activity directed toward the production or accomplishment of something');

INSERT INTO "Words" VALUES(24, 'number',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/number.jpg',
  'A mathematical object used to count, measure, and label');

INSERT INTO "Words" VALUES(25, 'night',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/night.jpg',
  'The period of time between the sunset and the sunrise when the Sun is below the horizon');

INSERT INTO "Words" VALUES(26, 'home',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/home.png',
  'A place used as a permanent residence for an individual or family');

INSERT INTO "Words" VALUES(27, 'water',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/water.jpg',
  'H20');

INSERT INTO "Words" VALUES(28, 'room',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/room.jpg',
  'Any distinguishable space within a structure');

INSERT INTO "Words" VALUES(29, 'area',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/area.png',
  'The quantity that expresses the extent of a two-dimensional figure or shape');

INSERT INTO "Words" VALUES(30, 'money',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/money.jpg',
  'It''s what people use to buy things and services');

INSERT INTO "Words" VALUES(31, 'story',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/story.jpg',
  'When we tell others about a thing that happened');

INSERT INTO "Words" VALUES(32, 'month',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/month.jpg',
  'An amount of time used with calendars. It is about one twelfth of a year');

INSERT INTO "Words" VALUES(33, 'study',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/study.jpg',
  'The activity or work of a student');

INSERT INTO "Words" VALUES(34, 'book',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/book.jpg',
  'A set of printed sheets of paper held together between two covers');

INSERT INTO "Words" VALUES(35, 'eye',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/eye.jpg',
  'An organ of the visual system');

INSERT INTO "Words" VALUES(36, 'house',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/house.jpg',
  'A building in which people live');

INSERT INTO "Words" VALUES(37, 'power',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/power.jpg',
  'How fast energy can be changed into work');

INSERT INTO "Words" VALUES(38, 'game',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/game.png',
  'Something that people do for fun');

INSERT INTO "Words" VALUES(39, 'member',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/member.jpg',
  'A person who belongs to a group of people');

INSERT INTO "Words" VALUES(40, 'car',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/car.jpg',
  'A road vehicle used to carry passengers');

INSERT INTO "Words" VALUES(41, 'city',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/city.jpg',
  'A large and permanent human settlement');

INSERT INTO "Words" VALUES(42, 'team',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/team.jpg',
  'A group of people linked in a common purpose');

INSERT INTO "Words" VALUES(43, 'agree',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/agree.jpg',
  'To come to one opinion or mind');

INSERT INTO "Words" VALUES(44, 'approve',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/approve.jpg',
  'To consent or agree to');

INSERT INTO "Words" VALUES(45, 'break',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/break.jpg',
  'A daily social gathering for a snack and short downtime practiced by employees in business and industry');

INSERT INTO "Words" VALUES(46, 'calculate',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/calculate.jpg',
  'Transform one or more inputs into one or more results, with variable change');

INSERT INTO "Words" VALUES(47, 'celebrate',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/celebrate.jpg',
  'To perform publicly and with appropriate rites');

INSERT INTO "Words" VALUES(48, 'choose',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/choose.jpg',
  'To select freely');

INSERT INTO "Words" VALUES(49, 'different',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/different.jpg',
  'Partly or totally unlike in nature, form, or quality');

INSERT INTO "Words" VALUES(50, 'earn',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/earn.jpg',
  'To receive as return for effort and especially for work done');

INSERT INTO "Words" VALUES(51, 'enter',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/enter.jpg',
  'To go or come in');

INSERT INTO "Words" VALUES(52, 'many',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/many.jpg',
  'Consisting of or amounting to a large but indefinite number');

INSERT INTO "Words" VALUES(53, 'relax',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/relax.jpg',
  'To make less tense');

INSERT INTO "Words" VALUES(54, 'solve',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/solve.jpg',
  'To find an explanation or answer for something');

INSERT INTO "Words" VALUES(55, 'words',
  'http://res.cloudinary.com/mediastorage/image/upload/word-kombat/words/words.jpg',
  'Units of language, consisting of one or more spoken sounds or their written representation');

SELECT pg_catalog.setval('"Words_id_seq"', 1, false);


ALTER TABLE ONLY "Competitors"
    ADD CONSTRAINT "Competitors_pkey" PRIMARY KEY ("UserId", "MatchId");

ALTER TABLE ONLY "Dictionaries"
    ADD CONSTRAINT "Dictionaries_pkey" PRIMARY KEY ("UserId", "WordId");

ALTER TABLE ONLY "MatchScores"
    ADD CONSTRAINT "MatchScores_pkey" PRIMARY KEY (id);

ALTER TABLE ONLY "Matches"
    ADD CONSTRAINT "Matches_pkey" PRIMARY KEY (id);

ALTER TABLE ONLY "Ranks"
    ADD CONSTRAINT "Ranks_pkey" PRIMARY KEY (id);

ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);

ALTER TABLE ONLY "Words"
    ADD CONSTRAINT "Words_pkey" PRIMARY KEY (id);

ALTER TABLE ONLY "Competitors"
    ADD CONSTRAINT "Competitors_MatchId_fkey" FOREIGN KEY ("MatchId") REFERENCES "Matches"(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "Competitors"
    ADD CONSTRAINT "Competitors_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "Dictionaries"
    ADD CONSTRAINT "Dictionaries_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "Dictionaries"
    ADD CONSTRAINT "Dictionaries_WordId_fkey" FOREIGN KEY ("WordId") REFERENCES "Words"(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "MatchScores"
    ADD CONSTRAINT "MatchScores_MatchId_fkey" FOREIGN KEY ("MatchId") REFERENCES "Matches"(id) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE ONLY "MatchScores"
    ADD CONSTRAINT "MatchScores_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE ONLY "MatchScores"
    ADD CONSTRAINT "MatchScores_WordId_fkey" FOREIGN KEY ("WordId") REFERENCES "Words"(id) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "Users_rank_id_fkey" FOREIGN KEY (rank_id) REFERENCES "Ranks"(id) ON UPDATE CASCADE ON DELETE SET NULL;

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
