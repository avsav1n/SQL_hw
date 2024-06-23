create table if not exists Genres (
	genre_id serial primary key,
	genre_name varchar(60) not null
);

create table if not exists Artists (
	artist_id serial primary key,
	artist_name varchar(100) not null unique
);

create table if not exists Genres_Artists (
	genre_id int references Genres(genre_id),
	artist_id int references Artists(artist_id),
	primary key(genre_id, artist_id)
);

create table if not exists Albums (
	album_id serial primary key,
	album_name varchar(60) not null,
	album_year smallint not null
);

create table if not exists Albums_Artists (
	album_id int references Albums(album_id),
	artist_id int references Artists(artist_id),
	primary key(album_id, artist_id)
);

create table if not exists Tracks (
	track_id serial primary key,
	album_id int references Albums(album_id),
	track_name varchar(100) not null,
	track_duration int not null check(track_duration > 0) 
);

create table if not exists Digests (
	digest_id serial primary key,
	digest_name varchar(60) not null,
	digest_year smallint not null 
);

create table if not exists Tracks_Digests (
	track_id int references Tracks(track_id),
	digest_id int references Digests(digest_id),
	primary key(track_id, digest_id)
);