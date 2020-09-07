package com.markstart.rainforest.dao;

import com.markstart.rainforest.model.Point;
import com.markstart.rainforest.model.Track;

import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;

public interface PointDao {


   void insertPointToDB(UUID point_id, UUID track_id, float gps_latitude, float gps_longitude, Timestamp point_timestamp, float point_humidity, float point_temperature);

   default void insertPointToDB ( Point point ) {
      UUID point_id = point.getPoint_id();
      UUID track_id = point.getTrack_id();
      float gps_latitude = point.getGps_latitude();
      float gps_longitude = point.getGps_longitude();
      Timestamp point_timestamp = point.getPoint_timestamp();
      float point_humidity = point.getPoint_humidity();
      float point_temperature = point.getPoint_temperature();
      insertPointToDB(point_id, track_id, gps_latitude, gps_longitude, point_timestamp, point_humidity, point_temperature);

      System.out.println("INSERT INTO tracks (track_id) VALUES ('" + track_id + "');");
      System.out.println("INSERT INTO points VALUES ('"+point_id+"','"+track_id+"',"+gps_latitude+","+gps_longitude+",'"+point_timestamp+"');" );
      System.out.println("INSERT INTO point_sensor_readings VALUES ('"+point_id+"', 'Humidity', "+point_humidity+");");
      System.out.println("INSERT INTO point_sensor_readings VALUES ('"+point_id+"', 'Temperature', "+point_temperature+");" );

   }


   List<Track> selectAllTracks();

   List<Point> selectAllPoints(UUID tracks_id);

}
