package com.markstart.rainforest.dao;

import com.markstart.rainforest.model.Point;
import com.markstart.rainforest.model.Track;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

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
            int track_id = resultSet.getInt("track_id");
            String track_name = resultSet.getString("track_name");
            String track_description = resultSet.getString("track_description");
            return new Track( track_id, track_name, track_description);
        });
    }

    @Override
    public List<Point> selectAllPoints(int tracks_id) {
        final String sql = "SELECT * FROM points " +
               "WHERE track_id = " + tracks_id;
        return jdbcTemplate.query(sql, (resultSet, i) -> {
            int point_id = resultSet.getInt("point_id");
            int track_id = resultSet.getInt("track_id");
            float gps_latitude = resultSet.getFloat("gps_latitude");
            float gps_longitude = resultSet.getFloat("gps_longitude");
            Timestamp point_timestamp = resultSet.getTimestamp("point_timestamp");

            float point_humidity = getPointHumidity( point_id );
            float point_temperature = getPointTemperature( point_id);

            return new Point(point_id, track_id, gps_latitude, gps_longitude, point_timestamp, point_humidity, point_temperature);
        });

    }




    private float getPointHumidity( int point_id ) {
        final String sql = "SELECT sensor_reading FROM point_sensor_readings WHERE point_id = " + point_id + " AND sensor_name LIKE 'Humidity'";
        return jdbcTemplate.queryForObject(sql, Float.class);
    }

    private float getPointTemperature( int point_id ) {
        final String sql = "SELECT sensor_reading FROM point_sensor_readings WHERE point_id = " + point_id + " AND sensor_name LIKE 'Temperature'";
        return jdbcTemplate.queryForObject(sql, Float.class);
    }







    //    @Override
//    public void insertPointToDB(int point_id, int track_id, float gps_latitude, float gps_longitude, Timestamp point_timestamp) {
//        jdbcTemplate.update(
//        "INSERT INTO points VALUES ( ?, ?, ?, ?, ?)",
//                point_id, track_id, gps_latitude, gps_longitude, point_timestamp
//        );
//    }

}


















