

CREATE TABLE regions (
    region_name VARCHAR(100) NOT NULL PRIMARY KEY,
    area DECIMAL
);

CREATE TABLE sub_regions (
	sub_region_name VARCHAR(100) NOT NULL PRIMARY KEY,
    area DECIMAL,
    region_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (region_name) REFERENCES regions
        ON DELETE CASCADE
);

CREATE TABLE forests (
	forest_id SERIAL NOT NULL PRIMARY KEY,
	forest_name VARCHAR(100),
	area DECIMAL,
	forest_description VARCHAR(400)
);

CREATE TABLE forests_sub_regions (
    forest_id SERIAL NOT NULL,
    sub_region_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (forest_id, sub_region_name),
    FOREIGN KEY (forest_id) REFERENCES forests
        ON DELETE CASCADE,
    FOREIGN KEY (sub_region_name) REFERENCES sub_regions
        ON DELETE CASCADE
);

CREATE TABLE koppen_types (
    koppen_code VARCHAR(10) NOT NULL PRIMARY KEY,
    koppen_name VARCHAR(100),
    koppen_description VARCHAR(400)
);

CREATE TABLE forests_koppen_types (
    forest_id SERIAL NOT NULL,
    koppen_code VARCHAR(10) NOT NULL,
    PRIMARY KEY (forest_id, koppen_code),
    FOREIGN KEY (forest_id) REFERENCES forests
        ON DELETE CASCADE,
    FOREIGN KEY (koppen_code) REFERENCES koppen_types
        ON DELETE CASCADE
);

CREATE TABLE tracks (
    track_id SERIAL NOT NULL PRIMARY KEY,
    track_name VARCHAR(100),
    track_description VARCHAR(400)
);

CREATE TABLE tracks_forests(
    track_id SERIAL NOT NULL,
    forest_id SERIAL NOT NULL,
    PRIMARY KEY (track_id, forest_id),
    FOREIGN KEY (forest_id) REFERENCES forests
        ON DELETE CASCADE,
    FOREIGN KEY (track_id) REFERENCES tracks
        ON DELETE CASCADE
);

CREATE TABLE points (
    point_id SERIAL NOT NULL PRIMARY KEY,
    track_id SERIAL NOT NULL,
    gps_latitude DECIMAL(10, 7),
    gps_longitude DECIMAL(10, 7),
    point_timestamp TIMESTAMP NOT NULL,
    FOREIGN KEY (track_id) REFERENCES tracks
        ON DELETE CASCADE
);

CREATE TABLE sensors (
    sensor_name VARCHAR(100) NOT NULL PRIMARY KEY,
    sensor_description VARCHAR(400)
);

CREATE TABLE point_sensor_readings (
    point_id SERIAL NOT NULL,
    sensor_name VARCHAR(100) NOT NULL,
    sensor_reading DECIMAL(6,3),
    PRIMARY KEY (point_id, sensor_name),
    FOREIGN KEY (point_id) REFERENCES points
        ON DELETE CASCADE,
    FOREIGN KEY (sensor_name) REFERENCES sensors
        ON DELETE CASCADE
);


















insert into forests (forest_id, forest_name, area, forest_description) values (1, 'Callorhinus ursinus', '676', 'Fumariaceae');
insert into forests (forest_id, forest_name, area, forest_description) values (2, 'Rhea americana', '927', 'Fabaceae');
insert into forests (forest_id, forest_name, area, forest_description) values (3, 'Crocodylus niloticus', '712', 'Diapensiaceae');
insert into forests (forest_id, forest_name, area, forest_description) values (4, 'Motacilla aguimp', '956', 'Asteraceae');
insert into forests (forest_id, forest_name, area, forest_description) values (5, 'Neotis denhami', '076', 'Parmeliaceae');
insert into forests (forest_id, forest_name, area, forest_description) values (6, 'Phasianus colchicus', '575', 'Chenopodiaceae');
insert into forests (forest_id, forest_name, area, forest_description) values (7, 'Libellula quadrimaculata', '419', 'Violaceae');
insert into forests (forest_id, forest_name, area, forest_description) values (8, 'Procyon lotor', '562', 'Crassulaceae');
insert into forests (forest_id, forest_name, area, forest_description) values (9, 'Ourebia ourebi', '015', 'Leskeaceae');


insert into koppen_types values ('Af','Tropical Rainforest',' Usually found within 10 to 15 degrees latitude of the equator, and has at least 60 mm of rainfall every month.');
insert into koppen_types values ('Am', 'Tropical Monsoon', ' With a mean tempreture of above 18 C every month, with a wet "Af" season and a "Aw" dry season');
insert into koppen_types values ('Aw/ As', 'Tropical Savanna','With a "Aw" dry winter some "As" months of less than 60mm precipitation');


 insert into forests_koppen_types values ( 1, 'Af');
 insert into forests_koppen_types values ( 1, 'Am');
 insert into forests_koppen_types values ( 1, 'Aw/ As');
 insert into forests_koppen_types values ( 2, 'Af');
 insert into forests_koppen_types values ( 2, 'Am');
 insert into forests_koppen_types values ( 3, 'Af');
 insert into forests_koppen_types values ( 4, 'Af');
 insert into forests_koppen_types values ( 5, 'Af');
 insert into forests_koppen_types values ( 5, 'Am');
 insert into forests_koppen_types values ( 6, 'Aw/ As');
 insert into forests_koppen_types values ( 7, 'Am');
 insert into forests_koppen_types values ( 8, 'Am');
 insert into forests_koppen_types values ( 9, 'Am');



insert into regions values ('Africa', 30370000);
insert into regions values ('Asia',  44579000);
insert into regions values ('Europe', 10180000);
insert into regions values ('Central America', 201497);
insert into regions values ('The Caribbean', 2754000);
insert into regions values ('North America', 24709000);
insert into regions values ('Oceania', 8525989);
insert into regions values ('South America', 17840000);



insert into sub_regions values ('New Zeland', 268021, 'Oceania');
insert into sub_regions values ('Australia', 7692000, 'Oceania');


insert into sub_regions values ('Belize', 22966, 'Central America');
insert into sub_regions values ('Cosa Rica', 51100, 'Central America');
insert into sub_regions values ('El Salvador', 21041, 'Central America');
insert into sub_regions values ('Guatemala', 108889, 'Central America');
insert into sub_regions values ('Honduras', 112492, 'Central America');
insert into sub_regions values ('Nicaragua', 130375, 'Central America');
insert into sub_regions values ('Panama', 75417, 'Central America');


insert into sub_regions values ('Mexico', 1972550, 'North America');

insert into sub_regions values ('Colombia', 1141748, 'South America');
insert into sub_regions values ('Brazil', 8515767, 'South America');
insert into sub_regions values ('Peru', 1285216, 'South America');
insert into sub_regions values ('Venezuela', 916445, 'South America');
insert into sub_regions values ('Ecuador', 283561, 'South America');
insert into sub_regions values ('Bolivia', 1098581, 'South America');
insert into sub_regions values ('Guyana', 214970, 'South America');
insert into sub_regions values ('Suriname', 163821, 'South America');
insert into sub_regions values ('French Guiana', 83534, 'South America');


insert into sub_regions values ('England', 130279,'Europe');
insert into sub_regions values ('Scotland', 77933,'Europe');
insert into sub_regions values ('Wales', 20779,'Europe');

insert into sub_regions values ('Japan', 377975, 'Asia');




insert into forests_sub_regions values ( 1, 'Colombia');
insert into forests_sub_regions values ( 1, 'Brazil');
insert into forests_sub_regions values ( 1, 'Peru');
insert into forests_sub_regions values ( 1, 'Venezuela');
insert into forests_sub_regions values ( 1, 'Ecuador');
insert into forests_sub_regions values ( 1, 'Bolivia');
insert into forests_sub_regions values ( 1, 'Guyana');
insert into forests_sub_regions values ( 1, 'Suriname');
insert into forests_sub_regions values ( 1, 'French Guiana');


insert into sensors (sensor_name) values ( 'Humidity');
insert into sensors (sensor_name) values ( 'Temperature');



insert into tracks values ( 1, 'Jaguar 1', 'Jaguar by river');



insert into points values ( 1, 1, 1, 1, '1999-01-08 04:05:07');
insert into points values ( 2, 1, 2, 2, '1999-01-08 04:05:08');
insert into points values ( 3, 1, 3, 3, '1999-01-08 04:05:09');


insert into point_sensor_readings values ( 1, 'Humidity', 70);
insert into point_sensor_readings values ( 1, 'Temperature', 25);
insert into point_sensor_readings values ( 2, 'Humidity', 71);
insert into point_sensor_readings values ( 2, 'Temperature', 26);
insert into point_sensor_readings values ( 3, 'Humidity', 72);
insert into point_sensor_readings values ( 3, 'Temperature', 27);







































