

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
	forest_id UUID NOT NULL PRIMARY KEY,
	forest_name VARCHAR(100),
	area DECIMAL,
	forest_description VARCHAR(400)
);

CREATE TABLE forests_sub_regions (
    forest_id UUID NOT NULL,
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
    forest_id UUID NOT NULL,
    koppen_code VARCHAR(10) NOT NULL,
    PRIMARY KEY (forest_id, koppen_code),
    FOREIGN KEY (forest_id) REFERENCES forests
        ON DELETE CASCADE,
    FOREIGN KEY (koppen_code) REFERENCES koppen_types
        ON DELETE CASCADE
);

CREATE TABLE tracks (
    track_id UUID NOT NULL PRIMARY KEY,
    track_name VARCHAR(100),
    track_description VARCHAR(400)
);

CREATE TABLE tracks_forests(
    track_id UUID NOT NULL,
    forest_id UUID NOT NULL,
    PRIMARY KEY (track_id, forest_id),
    FOREIGN KEY (forest_id) REFERENCES forests
        ON DELETE CASCADE,
    FOREIGN KEY (track_id) REFERENCES tracks
        ON DELETE CASCADE
);

CREATE TABLE points (
    point_id UUID NOT NULL PRIMARY KEY,
    track_id UUID NOT NULL,
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
    point_id UUID NOT NULL,
    sensor_name VARCHAR(100) NOT NULL,
    sensor_reading DECIMAL(6,3),
    PRIMARY KEY (point_id, sensor_name),
    FOREIGN KEY (point_id) REFERENCES points
        ON DELETE CASCADE,
    FOREIGN KEY (sensor_name) REFERENCES sensors
        ON DELETE CASCADE
);















insert into koppen_types values ('Af','Tropical Rainforest',' Usually found within 10 to 15 degrees latitude of the equator, and has at least 60 mm of rainfall every month.');
insert into koppen_types values ('Am', 'Tropical Monsoon', ' With a mean tempreture of above 18 C every month, with a wet "Af" season and a "Aw" dry season');
insert into koppen_types values ('Aw/ As', 'Tropical Savanna','With a "Aw" dry winter some "As" months of less than 60mm precipitation');




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





insert into sensors (sensor_name) values ( 'Humidity');
insert into sensors (sensor_name) values ( 'Temperature');



































