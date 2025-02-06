--

CREATE TABLE IF NOT EXISTS Genre (
	id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Bands (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS GenreBand (
	Genre_id INTEGER REFERENCES Genre(id),
	Band_id INTEGER REFERENCES Bands(id),
	CONSTRAINT pk_GenreBand PRIMARY KEY (Genre_id, Band_id)
);


CREATE TABLE IF NOT EXISTS Albom (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) unique NOT NULL,
	year_of INTEGER check(year_of>1900)
);


CREATE TABLE IF NOT EXISTS BandsAlbom (
	Albom_id INTEGER REFERENCES Albom(id),
	Band_id INTEGER REFERENCES Bands(id),
	CONSTRAINT pk_BandAlbum PRIMARY KEY (Albom_id, Band_id)
);


CREATE TABLE IF NOT EXISTS Songs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	duration INTEGER,
	Albom_id INTEGER REFERENCES Albom(id)
);

CREATE TABLE IF NOT EXISTS Collection (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) unique NOT NULL,
	year_of INTEGER check(year_of>1900)
);

CREATE TABLE IF NOT EXISTS SongCollekyon (
	Song_id INTEGER REFERENCES Songs(id),
	Collection_id INTEGER REFERENCES Collection(id),
	CONSTRAINT pk_SongColletion PRIMARY KEY (Collection_id, Song_id)
);

INSERT into Genre (id, name)
values (1, 'pop'),
       (2, 'rock'),
       (3, 'rap'),
       (4, 'dance');

INSERT into Songs (id, name, duration, albom_id)
values (10, 'I d Love to Change the World', 2, 1),
       (20, 'Ветер дорог', 4, 2),
       (30, 'Быть Счастливой', 5, 3),
       (40, 'Перемены – это красиво', 3,4),
       (50, 'Жозефина Павловна', 6,5),
       (60, 'Фиеста', 8,6),
       (70, 'Everybody Knows', 1,7),
       (80, 'Без тебя',7,8);


INSERT into Albom (id, name, year_of)
values (1, 'INSPIRED BY LOVE', 2011 ),
       (2, 'Хроники трэпа vol. 1',2012 ),
       (3, 'Миллениум X', 2013),
       (4, 'Наизнанку', 2014),
       (5, 'Голод', 2015),
       (6, 'OFF THE FLOOR', 2016),
       (7, 'Sapphire Souls EP', 2017),
       (8, 'Весел и свеж', 2018);
update Albom set year_of = 2019 where id = 7;

INSERT into Bands (id, name)
values (1, 'ONEIL, KANVISE, SMOLA'),
       (2, 'Баста, Ольга Серябкина'),
       (3, 'Artik & Asti'),
       (4, 'MOT'),
       (5, 'Звери'),
       (6, 'ISVNBITOV, Alfredovich'),
       (7, 'DJ DimixeR, Dmitrii G'),
       (8, 'Кравц, Kamazz');

INSERT into BandsAlbom (Albom_id, Band_id)
values (1,1),
       (2,2),
       (3,3),
       (4,4),
       (5,5),
       (6,6),
       (7,7),
       (8,8);

INSERT into Collection (id, name, year_of)
values (1, 'Рокенрол', 2020),
       (2, 'репчик', 2021),
       (3, 'Попса', 2022),
       (4, 'иностранщина', 2023),
       (21, 'Рокенрол1', 2019),
       (22, 'репчик1', 2018),
       (23, 'Попса1', 2017),
       (24, 'иностранщина1', 2016);


INSERT into GenreBand (genre_id, band_id)
values (1, 2),
       (1, 3),
       (2, 5),
       (2, 6),
       (3, 4),
       (3, 8),
       (4, 1),
       (4, 7);


INSERT into SongCollekyon (song_id, collection_id)
values (10, 4),
       (20, 3),
       (30, 23),
       (40, 2),
       (50, 1),
       (60, 21),
       (70, 24),
       (80, 22);

--Название и продолжительность самого длительного трека.
select name, duration
from Songs
order by  duration desc 
limit 1;

--Название треков, продолжительность которых не менее 3,5 минут.
select name
from Songs
where duration > 3.5;

--Названия сборников, вышедших в период с 2018 по 2020 год включительно.
select name
from Collection
where year_of between 2018 and 2020

--Исполнители, чьё имя состоит из одного слова.
select  name
FROM Bands
where  name NOT LIKE '% %';

--Название треков, которые содержат слово «мой» или «my».
select  name
from  songs
where string_to_array(lower(name), ' ') && ARRAY['мой', 'мой %', '% мой', '%мой%', 'my', '% my', 'my %', '%my%'];

--Задание 3
--Количество исполнителей в каждом жанре.
select genre_id, COUNT(*) 
from  GenreBand
group by genre_id
order by COUNT(*);

--Количество треков, вошедших в альбомы 2019–2020 годов.
select a.name, COUNT(s.name) 
from albom a join songs s on s.albom_id = a.id
where a.year_of in (2019, 2020)
group by  a.name;

--Средняя продолжительность треков по каждому альбому.
select albom_id, AVG(duration) avg_dur
from songs s
group by albom_id
order by avg_dur;

--Все исполнители, которые не выпустили альбомы в 2020 году.
select distinct name
from bands
where name not in (
select distinct bands.name from  bands b
left join bandsalbom ba ON ba.band_id = b.id 
left join albom a ON ba.albom_id = a.id
where a.year_of = 2020)
order by name;

--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
select distinct c.name 
from collection c
left join songcollekyon sc on c.id = sc.collection_id 
left join songs s on sc.song_id = s.id 
left join albom a on s.albom_id = a.id
left join bandsalbom ba on ba.band_id = a.id 
left join bands b on ba.band_id = b.id 
where b.name like'%MOT%'
order by name;








