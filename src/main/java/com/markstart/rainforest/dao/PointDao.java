package com.markstart.rainforest.dao;

import com.markstart.rainforest.model.Point;
import com.markstart.rainforest.model.Track;

import java.util.List;

public interface PointDao {


/*   void insertPointToDB(int point_id, int track_id, float gps_latitude, float gps_longitude, Timestamp point_timestamp);

   default void insertPointToDB ( Point point ) {
      int point_id = point.getPoint_id();
      int track_id = point.getTrack_id();
      float gps_latitude = point.getGps_latitude();
      float gps_longitude = point.getGps_longitude();
      Timestamp point_timestamp = point.getPoint_timestamp();
      insertPointToDB(point_id, track_id, gps_latitude, gps_longitude, point_timestamp);
   }
*/

   List<Track> selectAllTracks();

   List<Point> selectAllPoints(int track_id);
}
