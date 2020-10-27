
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
insert into koppen_types values ('Am', 'Tropical Monsoon', ' With a mean temperature of above 18 C every month, with a wet "Af" season and a "Aw" dry season');
insert into koppen_types values ('Aw/ As', 'Tropical Savanna','With a "Aw" dry winter some "As" months of less than 60mm precipitation');




insert into regions values ('Africa', 30370000);
insert into regions values ('Asia',  44579000);
insert into regions values ('Europe', 10180000);
insert into regions values ('Central America', 201497);
insert into regions values ('The Caribbean', 2754000);
insert into regions values ('North America', 24709000);
insert into regions values ('Oceania', 8525989);
insert into regions values ('South America', 17840000);



insert into sub_regions values ('New Zealand', 268021, 'Oceania');
insert into sub_regions values ('Australia', 7692000, 'Oceania');


insert into sub_regions values ('Belize', 22966, 'Central America');
insert into sub_regions values ('Costa Rica', 51100, 'Central America');
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





INSERT INTO tracks (track_id) VALUES ('81b0eae3-e9b1-4c6b-95b7-88c99f630aa0');


INSERT INTO points VALUES ('76859c9e-db88-44f9-9756-b458792b5487','81b0eae3-e9b1-4c6b-95b7-88c99f630aa0',51.35739,0.4211113,'2020-08-16 08:08:50.318');
INSERT INTO points VALUES ('4564d42b-ec25-46c6-8978-c7480478d352','81b0eae3-e9b1-4c6b-95b7-88c99f630aa0',51.357464,0.4209414,'2020-08-16 05:38:17.87');
INSERT INTO points VALUES ('39a0d4f6-d768-43f6-8d1e-c6023d87a99d','81b0eae3-e9b1-4c6b-95b7-88c99f630aa0',51.351017,0.5035251,'2020-08-16 07:23:08.82');
INSERT INTO points VALUES ('0316a65b-a192-4db6-a3d1-82da94e595db','81b0eae3-e9b1-4c6b-95b7-88c99f630aa0',51.357597,0.4208168,'2020-08-16 05:53:18.884');
INSERT INTO points VALUES ('c24967af-c489-4972-a676-184bac702c07','81b0eae3-e9b1-4c6b-95b7-88c99f630aa0',51.375523,0.4587482,'2020-08-16 06:38:20.962');
INSERT INTO points VALUES ('5f28d18a-853a-44e8-a747-8b4ee4177afc','81b0eae3-e9b1-4c6b-95b7-88c99f630aa0',51.390102,0.485772,'2020-08-16 06:53:20.917');


INSERT INTO point_sensor_readings VALUES ('4564d42b-ec25-46c6-8978-c7480478d352', 'Humidity', 79.04221);
INSERT INTO point_sensor_readings VALUES ('4564d42b-ec25-46c6-8978-c7480478d352', 'Temperature', 13.599094);
INSERT INTO point_sensor_readings VALUES ('39a0d4f6-d768-43f6-8d1e-c6023d87a99d', 'Humidity', 89.64342);
INSERT INTO point_sensor_readings VALUES ('39a0d4f6-d768-43f6-8d1e-c6023d87a99d', 'Temperature', 14.234207);
INSERT INTO point_sensor_readings VALUES ('c24967af-c489-4972-a676-184bac702c07', 'Humidity', 76.518);
INSERT INTO point_sensor_readings VALUES ('c24967af-c489-4972-a676-184bac702c07', 'Temperature', 13.765026);
INSERT INTO point_sensor_readings VALUES ('5f28d18a-853a-44e8-a747-8b4ee4177afc', 'Humidity', 63.952595);
INSERT INTO point_sensor_readings VALUES ('5f28d18a-853a-44e8-a747-8b4ee4177afc', 'Temperature', 12.841706);
INSERT INTO point_sensor_readings VALUES ('76859c9e-db88-44f9-9756-b458792b5487', 'Humidity', 96.751396);
INSERT INTO point_sensor_readings VALUES ('76859c9e-db88-44f9-9756-b458792b5487', 'Temperature', 10.698968);
INSERT INTO point_sensor_readings VALUES ('0316a65b-a192-4db6-a3d1-82da94e595db', 'Humidity', 100.0);
INSERT INTO point_sensor_readings VALUES ('0316a65b-a192-4db6-a3d1-82da94e595db', 'Temperature', 10.93708);



INSERT INTO tracks (track_id) VALUES ('bc6307e7-1ef4-43df-8bfb-5d50735206d9');

INSERT INTO points VALUES ('5bff4138-d43f-4ebc-9399-702e3d02820f','bc6307e7-1ef4-43df-8bfb-5d50735206d9',51.502907,-0.3292215,'2020-10-27 11:48:46.686');
INSERT INTO points VALUES ('39487b4e-798a-4192-a264-5f3bc7ebec89','bc6307e7-1ef4-43df-8bfb-5d50735206d9',51.502907,-0.3292221,'2020-10-27 11:48:56.874');

INSERT INTO point_sensor_readings VALUES ('39487b4e-798a-4192-a264-5f3bc7ebec89', 'Humidity', 77.09276);
INSERT INTO point_sensor_readings VALUES ('39487b4e-798a-4192-a264-5f3bc7ebec89', 'Temperature', 17.921455);
INSERT INTO point_sensor_readings VALUES ('5bff4138-d43f-4ebc-9399-702e3d02820f', 'Humidity', 76.64701);
INSERT INTO point_sensor_readings VALUES ('5bff4138-d43f-4ebc-9399-702e3d02820f', 'Temperature', 18.098722);