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
	CONSTRAINT pk_SongColletion PRIMARY KEY (Collection_id, Songs_id)
);