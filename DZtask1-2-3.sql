
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








