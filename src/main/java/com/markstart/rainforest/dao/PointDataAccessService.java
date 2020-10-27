package com.markstart.rainforest.dao;

import com.markstart.rainforest.model.Point;
import com.markstart.rainforest.model.Track;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;


@Repository("postgres")
public class PointDataAccessService implements PointDao {
    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public PointDataAccessService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Track> selectAllTracks() {
        final String sql = "SELECT track_id, track_name, track_description " +
                "FROM tracks";
        return jdbcTemplate.query(sql, (resultSet, i) -> {
            UUID track_id = (java.util.UUID) resultSet.getObject("track_id");
            String track_name = resultSet.getString("track_name");
            String track_description = resultSet.getString("track_description");
            return new Track(track_id, track_name, track_description);
        });
    }

    @Override
    public List<Point> selectAllPoints(UUID track_id) {
        final String sql = "SELECT * FROM points " +
                "WHERE track_id = '" + track_id + "' ";
        return jdbcTemplate.query(sql, (resultSet, i) -> {
            UUID point_id = (java.util.UUID) resultSet.getObject("point_id");
            UUID tracks_id = (java.util.UUID) resultSet.getObject("track_id");
            float gps_latitude = resultSet.getFloat("gps_latitude");
            float gps_longitude = resultSet.getFloat("gps_longitude");
            Timestamp point_timestamp = resultSet.getTimestamp("point_timestamp");

            float point_humidity = getPointHumidity(point_id);
            float point_temperature = getPointTemperature(point_id);

            return new Point(point_id, track_id, gps_latitude, gps_longitude, point_timestamp, point_humidity, point_temperature);
        });

    }

    private float getPointHumidity(UUID point_id) {
        final String sql = "SELECT sensor_reading FROM point_sensor_readings WHERE point_id = '" + point_id + "' AND sensor_name LIKE 'Humidity'";
        return jdbcTemplate.queryForObject(sql, Float.class);
    }

    private float getPointTemperature(UUID point_id) {
        final String sql = "SELECT sensor_reading FROM point_sensor_readings WHERE point_id = '" + point_id + "' AND sensor_name LIKE 'Temperature'";
        return jdbcTemplate.queryForObject(sql, Float.class);
    }

    private boolean trackInDB(UUID track_id) {
        final String sql = "SELECT EXISTS( SELECT 1 FROM tracks WHERE track_id = '" + track_id + "')";
        boolean exists = jdbcTemplate.queryForObject(sql, Boolean.class);

        return ( exists );
    }

    private boolean pointInDB(UUID point_id ) {
        final String sql = "SELECT EXISTS ( SELECT 1 FROM points WHERE point_id = '" + point_id + "')";
        boolean exists = jdbcTemplate.queryForObject(sql, Boolean.class);

        return ( exists );
    }

    @Override
    public void insertPointToDB(UUID point_id, UUID track_id, float gps_latitude, float gps_longitude, Timestamp point_timestamp, float point_humidity, float point_temperature) {
        String humidity = "Humidity";
        String temperature = "Temperature";
        boolean wasAdded = false;

        try {
            if (trackInDB(track_id) == false) {
                jdbcTemplate.update(
                        "INSERT INTO tracks (track_id) VALUES ( ? )",
                        track_id
                );
            }
        } catch (org.springframework.dao.DuplicateKeyException e) {
            System.out.println("caught dulpicate track key ");
        }

        try {
            if (pointInDB(point_id) == false) {
                jdbcTemplate.update(
                        "INSERT INTO points VALUES ( ?, ?, ?, ?, ?)",
                        point_id, track_id, gps_latitude, gps_longitude, point_timestamp
                );

                jdbcTemplate.update(

                        "INSERT INTO point_sensor_readings VALUES ( ?, ?, ?)",
                        point_id, humidity, point_humidity
                );

                jdbcTemplate.update(
                        "INSERT INTO point_sensor_readings VALUES ( ?, ?, ?)",
                        point_id, temperature, point_temperature
                );

                wasAdded = true;

            }

        } catch (org.springframework.dao.DuplicateKeyException e) {
            System.out.println("caught dulpicate point key ");
        }

    }


}




















