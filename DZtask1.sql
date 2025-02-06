
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







