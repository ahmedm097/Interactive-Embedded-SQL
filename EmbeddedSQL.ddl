DROP SCHEMA IF EXISTS A2 CASCADE;
CREATE SCHEMA A2;
SET search_path TO A2;

DROP TABLE IF EXISTS country CASCADE;
DROP TABLE IF EXISTS language CASCADE;
DROP TABLE IF EXISTS religion CASCADE;
DROP TABLE IF EXISTS hdi CASCADE;
DROP TABLE IF EXISTS ocean CASCADE;
DROP TABLE IF EXISTS neighbour CASCADE;
DROP TABLE IF EXISTS oceanAccess CASCADE;
DROP TABLE IF EXISTS query1 CASCADE;
DROP TABLE IF EXISTS query2 CASCADE;
DROP TABLE IF EXISTS query3 CASCADE;
DROP TABLE IF EXISTS query4 CASCADE;
DROP TABLE IF EXISTS query5 CASCADE;
DROP TABLE IF EXISTS query6 CASCADE;
DROP TABLE IF EXISTS query7 CASCADE;
DROP TABLE IF EXISTS query8 CASCADE;
DROP TABLE IF EXISTS query9 CASCADE;
DROP TABLE IF EXISTS query10 CASCADE;


-- The country table contains all the countries in the world and their facts.
-- 'cid' is the id of the country.
-- 'cname' is the name of the country.
-- 'height' is the highest elevation point of the country.
-- 'population' is the population of the country.
CREATE TABLE country (
    cid 		INTEGER 	PRIMARY KEY,
    cname 		VARCHAR(20)	NOT NULL,
    height 		INTEGER 	NOT NULL,
    population	INTEGER 	NOT NULL);
    
-- The language table contains information about the languages and the percentage of the speakers of the language for each country.
-- 'cid' is the id of the country.
-- 'lid' is the id of the language.
-- 'lname' is the name of the language.
-- 'lpercentage' is the percentage of the population in the country who speak the language.
CREATE TABLE language (
    cid 		INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    lid 		INTEGER 	NOT NULL,
    lname 		VARCHAR(20) NOT NULL,
    lpercentage	REAL 		NOT NULL,
	PRIMARY KEY(cid, lid));

-- The religion table contains information about the religions and the percentage of the population in each country that follow the religion.
-- 'cid' is the id of the country.
-- 'rid' is the id of the religion.
-- 'rname' is the name of the religion.
-- 'rpercentage' is the percentage of the population in the country who follows the religion.
CREATE TABLE religion (
    cid 		INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    rid 		INTEGER 	NOT NULL,
    rname 		VARCHAR(20) NOT NULL,
    rpercentage	REAL 		NOT NULL,
	PRIMARY KEY(cid, rid));

-- The hdi table contains the human development index of each country per year. (http://en.wikipedia.org/wiki/Human_Development_Index)
-- 'cid' is the id of the country.
-- 'year' is the year when the hdi score has been estimated.
-- 'hdi_score' is the Human Development Index score of the country that year. It takes values [0, 1] with a larger number representing a higher HDI.
CREATE TABLE hdi (
    cid 		INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    year 		INTEGER 	NOT NULL,
    hdi_score 	REAL 		NOT NULL,
	PRIMARY KEY(cid, year));

-- The ocean table contains information about oceans on the earth.
-- 'oid' is the id of the ocean.
-- 'oname' is the name of the ocean.
-- 'depth' is the depth of the deepest part of the ocean
CREATE TABLE ocean (
    oid 		INTEGER 	PRIMARY KEY,
    oname 		VARCHAR(20) NOT NULL,
    depth 		INTEGER 	NOT NULL);

-- The neighbour table provides information about the countries and their neighbours.
-- 'country' refers to the cid of the first country.
-- 'neighbor' refers to the cid of a country that is neighbouring the first country.
-- 'length' is the length of the border between the two neighbouring countries.
CREATE TABLE neighbour (
    country 	INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    neighbor 	INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT, 
    length 		INTEGER 	NOT NULL,
	PRIMARY KEY(country, neighbor));

-- The oceanAccess table provides information about the countries which have a border with an ocean.
-- 'cid' refers to the cid of the country.
-- 'oid' refers to the oid of the ocean.
CREATE TABLE oceanAccess (
    cid 	INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    oid 	INTEGER 	REFERENCES ocean(oid) ON DELETE RESTRICT, 
    PRIMARY KEY(cid, oid));


-- The following tables will be used to store the results of your queries. 
-- Each of them should be populated by your last SQL statement that looks like:
-- “INSERT INTO queryX (SELECT … <complete your SQL query here> …)”

CREATE TABLE query1(
	c1id	INTEGER,
    c1name	VARCHAR(20),
	c2id	INTEGER,
    c2name	VARCHAR(20)
);

CREATE TABLE query2(
	cid		INTEGER,
    cname	VARCHAR(20)
);

CREATE TABLE query3(
	c1id	INTEGER,
    c1name	VARCHAR(20),
	c2id	INTEGER,
    c2name	VARCHAR(20)
);

CREATE TABLE query4(
	cname	VARCHAR(20),
    oname	VARCHAR(20)
);

CREATE TABLE query5(
	cid		INTEGER,
    cname	VARCHAR(20),
	avghdi	REAL
);

CREATE TABLE query6(
	cid		INTEGER,
    cname	VARCHAR(20)
);

CREATE TABLE query7(
	rid			INTEGER,
    rname		VARCHAR(20),
	followers	INTEGER
);

CREATE TABLE query8(
	c1name	VARCHAR(20),
    c2name	VARCHAR(20),
	lname	VARCHAR(20)
);

CREATE TABLE query9(
    cname		VARCHAR(20),
	totalspan	INTEGER
);

CREATE TABLE query10(
    cname			VARCHAR(20),
	borderslength	INTEGER
);



INSERT INTO country VALUES (1, 'Canada', 19551, 37742154);
INSERT INTO country VALUES (2, 'USA', 20310, 331002651);
INSERT INTO country VALUES (3, 'Mexico', 18491, 128932753);
INSERT INTO country VALUES (4, 'Guatemala', 13845, 17915568);
INSERT INTO country VALUES (5, 'Belize', 3688, 397628);
INSERT INTO country VALUES (6, 'Switzerland', 15203, 8654622);
INSERT INTO country VALUES (7, 'Austria', 12461, 9006398);
INSERT INTO country VALUES (8, 'Indonesia', 16024, 273523615);
INSERT INTO country VALUES (9, 'Papua New Guinea', 14793, 8947024);
INSERT INTO country VALUES (10, 'France', 15771, 66990000);
INSERT INTO country VALUES (11, 'Saudi Arabia', 9843, 34813871);
INSERT INTO country VALUES (12, 'Yemen', 12028, 29825964);

INSERT INTO neighbour VALUES (1, 2, 8893);
INSERT INTO neighbour VALUES (2, 1, 8893);
INSERT INTO neighbour VALUES (2, 3, 3141);
INSERT INTO neighbour VALUES (3, 2, 3141);
INSERT INTO neighbour VALUES (3, 4, 1212);
INSERT INTO neighbour VALUES (4, 3, 1212);
INSERT INTO neighbour VALUES (4, 5, 1687);
INSERT INTO neighbour VALUES (5, 4, 400);
INSERT INTO neighbour VALUES (5, 3, 116);
INSERT INTO neighbour VALUES (6, 7, 180);
INSERT INTO neighbour VALUES (7, 6, 180);
INSERT INTO neighbour VALUES (8, 9, 820);
INSERT INTO neighbour VALUES (9, 8, 820);
INSERT INTO neighbour VALUES (6, 10, 572);
INSERT INTO neighbour VALUES (10, 6, 572);
INSERT INTO neighbour VALUES (11, 12, 1307);
INSERT INTO neighbour VALUES (12, 11, 1307);

INSERT INTO ocean VALUES (1001, 'Atlantic', 28344);
INSERT INTO ocean VALUES (1002, 'Pacific', 36198);
INSERT INTO ocean VALUES (1003, 'Indian', 25344);
INSERT INTO ocean VALUES (1004, 'Southern', 23737);
INSERT INTO ocean VALUES (1005, 'Arctic', 17881);

INSERT INTO oceanAccess VALUES (1, 1001);
INSERT INTO oceanAccess VALUES (1, 1002);
INSERT INTO oceanAccess VALUES (2, 1001);
INSERT INTO oceanAccess VALUES (2, 1002);
INSERT INTO oceanAccess VALUES (3, 1001);
INSERT INTO oceanAccess VALUES (3, 1002);
INSERT INTO oceanAccess VALUES (4, 1001);
INSERT INTO oceanAccess VALUES (4, 1002);
INSERT INTO oceanAccess VALUES (5, 1001);
INSERT INTO oceanAccess VALUES (8, 1003);
INSERT INTO oceanAccess VALUES (8, 1001);
INSERT INTO oceanAccess VALUES (9, 1003);
INSERT INTO oceanAccess VALUES (10, 1001);
INSERT INTO oceanAccess VALUES (11, 1001);
INSERT INTO oceanAccess VALUES (12, 1001);

INSERT INTO hdi VALUES (1, 2009, 0.893);
INSERT INTO hdi VALUES (1, 2010, 0.895);
INSERT INTO hdi VALUES (1, 2011, 0.899);
INSERT INTO hdi VALUES (1, 2012, 0.906);
INSERT INTO hdi VALUES (1, 2013, 0.910);
INSERT INTO hdi VALUES (1, 2016, 0.920);
INSERT INTO hdi VALUES (1, 2017, 0.921);
INSERT INTO hdi VALUES (1, 2018, 0.922);
INSERT INTO hdi VALUES (2, 2009, 0.908);
INSERT INTO hdi VALUES (2, 2010, 0.911);
INSERT INTO hdi VALUES (2, 2011, 0.914);
INSERT INTO hdi VALUES (2, 2012, 0.916);
INSERT INTO hdi VALUES (2, 2013, 0.914);
INSERT INTO hdi VALUES (2, 2016, 0.919);
INSERT INTO hdi VALUES (2, 2017, 0.919);
INSERT INTO hdi VALUES (2, 2018, 0.920);
INSERT INTO hdi VALUES (3, 2009, 0.739);
INSERT INTO hdi VALUES (3, 2010, 0.739);
INSERT INTO hdi VALUES (3, 2011, 0.746);
INSERT INTO hdi VALUES (3, 2012, 0.752);
INSERT INTO hdi VALUES (3, 2013, 0.750);
INSERT INTO hdi VALUES (3, 2016, 0.764);
INSERT INTO hdi VALUES (3, 2017, 0.765);
INSERT INTO hdi VALUES (3, 2018, 0.767);
INSERT INTO hdi VALUES (4, 2009, 0.597);
INSERT INTO hdi VALUES (4, 2010, 0.602);
INSERT INTO hdi VALUES (4, 2011, 0.607);
INSERT INTO hdi VALUES (4, 2012, 0.613);
INSERT INTO hdi VALUES (4, 2013, 0.616);
INSERT INTO hdi VALUES (4, 2016, 0.648);
INSERT INTO hdi VALUES (4, 2017, 0.649);
INSERT INTO hdi VALUES (4, 2018, 0.651);
INSERT INTO hdi VALUES (6, 2009, 0.927);
INSERT INTO hdi VALUES (6, 2010, 0.932);
INSERT INTO hdi VALUES (6, 2011, 0.932);
INSERT INTO hdi VALUES (6, 2012, 0.935);
INSERT INTO hdi VALUES (6, 2013, 0.938);
INSERT INTO hdi VALUES (6, 2016, 0.943);
INSERT INTO hdi VALUES (6, 2017, 0.943);
INSERT INTO hdi VALUES (6, 2018, 0.946);
INSERT INTO hdi VALUES (5, 2009, 0.688);
INSERT INTO hdi VALUES (5, 2010, 0.693);
INSERT INTO hdi VALUES (5, 2011, 0.699);
INSERT INTO hdi VALUES (5, 2012, 0.706);
INSERT INTO hdi VALUES (5, 2013, 0.707);
INSERT INTO hdi VALUES (5, 2016, 0.722);
INSERT INTO hdi VALUES (5, 2017, 0.719);
INSERT INTO hdi VALUES (5, 2018, 0.720);
INSERT INTO hdi VALUES (7, 2009, 0.886);
INSERT INTO hdi VALUES (7, 2010, 0.895);
INSERT INTO hdi VALUES (7, 2011, 0.897);
INSERT INTO hdi VALUES (7, 2012, 0.899);
INSERT INTO hdi VALUES (7, 2013, 0.896);
INSERT INTO hdi VALUES (7, 2016, 0.919);
INSERT INTO hdi VALUES (7, 2017, 0.919);
INSERT INTO hdi VALUES (7, 2018, 0.920);
INSERT INTO hdi VALUES (8, 2009, 0.659);
INSERT INTO hdi VALUES (8, 2010, 0.666);
INSERT INTO hdi VALUES (8, 2011, 0.674);
INSERT INTO hdi VALUES (8, 2012, 0.682);
INSERT INTO hdi VALUES (8, 2013, 0.688);
INSERT INTO hdi VALUES (8, 2016, 0.700);
INSERT INTO hdi VALUES (8, 2017, 0.704);
INSERT INTO hdi VALUES (8, 2018, 0.707);
INSERT INTO hdi VALUES (9, 2009, 0.500);
INSERT INTO hdi VALUES (9, 2010, 0.510);
INSERT INTO hdi VALUES (9, 2011, 0.517);
INSERT INTO hdi VALUES (9, 2012, 0.508);
INSERT INTO hdi VALUES (9, 2013, 0.521);
INSERT INTO hdi VALUES (9, 2016, 0.541);
INSERT INTO hdi VALUES (9, 2017, 0.543);
INSERT INTO hdi VALUES (9, 2018, 0.543);
INSERT INTO hdi VALUES (10, 2009, 0.869);
INSERT INTO hdi VALUES (10, 2010, 0.872);
INSERT INTO hdi VALUES (10, 2011, 0.876);
INSERT INTO hdi VALUES (10, 2012, 0.878);
INSERT INTO hdi VALUES (10, 2013, 0.882);
INSERT INTO hdi VALUES (10, 2016, 0.887);
INSERT INTO hdi VALUES (10, 2017, 0.890);
INSERT INTO hdi VALUES (10, 2018, 0.891);
INSERT INTO hdi VALUES (11, 2009, 0.797);
INSERT INTO hdi VALUES (11, 2010, 0.810);
INSERT INTO hdi VALUES (11, 2011, 0.824);
INSERT INTO hdi VALUES (11, 2012, 0.837);
INSERT INTO hdi VALUES (11, 2013, 0.846);
INSERT INTO hdi VALUES (11, 2016, 0.857);
INSERT INTO hdi VALUES (11, 2017, 0.856);
INSERT INTO hdi VALUES (11, 2018, 0.857);
INSERT INTO hdi VALUES (12, 2009, 0.503);
INSERT INTO hdi VALUES (12, 2010, 0.499);
INSERT INTO hdi VALUES (12, 2011, 0.511);
INSERT INTO hdi VALUES (12, 2012, 0.501);
INSERT INTO hdi VALUES (12, 2013, 0.506);
INSERT INTO hdi VALUES (12, 2016, 0.477);
INSERT INTO hdi VALUES (12, 2017, 0.463);
INSERT INTO hdi VALUES (12, 2018, 0.463);

INSERT INTO religion VALUES (1, 501, 'religion_1', 15);
INSERT INTO religion VALUES (1, 502, 'religion_2', 9);
INSERT INTO religion VALUES (2, 501, 'religion_1', 30);
INSERT INTO religion VALUES (3, 502, 'religion_2', 42);
INSERT INTO religion VALUES (3, 503, 'religion_3', 42);
INSERT INTO religion VALUES (4, 501, 'religion_1', 23);
INSERT INTO religion VALUES (4, 503, 'religion_3', 49);
INSERT INTO religion VALUES (5, 502, 'religion_2', 9);
INSERT INTO religion VALUES (6, 504, 'religion_4', 65);
INSERT INTO religion VALUES (6, 503, 'religion_3', 11);
INSERT INTO religion VALUES (8, 501, 'religion_1', 5);
INSERT INTO religion VALUES (9, 505, 'religion_5', 45);
INSERT INTO religion VALUES (9, 501, 'religion_1', 17);

INSERT INTO language VALUES (1, 601, 'English', 77);
INSERT INTO language VALUES (1, 602, 'French', 51);
INSERT INTO language VALUES (1, 603, 'Spanish', 19);
INSERT INTO language VALUES (2, 601, 'English', 90);
INSERT INTO language VALUES (2, 602, 'French', 11);
INSERT INTO language VALUES (2, 603, 'Spanish', 35);
INSERT INTO language VALUES (3, 603, 'Spanish', 95);
INSERT INTO language VALUES (3, 601, 'English', 29);
INSERT INTO language VALUES (4, 603, 'Spanish', 95);
INSERT INTO language VALUES (5, 601, 'English', 91);
INSERT INTO language VALUES (6, 607, 'German', 64);
INSERT INTO language VALUES (6, 602, 'French', 20);
INSERT INTO language VALUES (6, 608, 'Italian', 7);
INSERT INTO language VALUES (7, 607, 'German', 75);
INSERT INTO language VALUES (7, 609, 'Slovene', 20);
INSERT INTO language VALUES (7, 610, 'Ctoatian', 7);
INSERT INTO language VALUES (8, 604, 'Bahasa Indonesia', 91);
INSERT INTO language VALUES (8, 601, 'English', 15);
INSERT INTO language VALUES (8, 605, 'Tok Pisin', 1);
INSERT INTO language VALUES (9, 605, 'Tok Pisin', 91);
INSERT INTO language VALUES (9, 601, 'English', 2);
INSERT INTO language VALUES (11, 606, 'Arabic', 99);
INSERT INTO language VALUES (12, 606, 'Arabic', 99);

