package com.markstart.rainforest.service;

import com.markstart.rainforest.dao.PointDao;
import com.markstart.rainforest.model.Point;
import com.markstart.rainforest.model.Track;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;


@Service
public class PointService {
    private final PointDao pointDao;


    @Autowired
    public PointService(@Qualifier("postgres") PointDao pointDao) {
        this.pointDao = pointDao;
    }

    public List<Track> getAllTracks() {
        return pointDao.selectAllTracks();
    }

    public List<Point> getAllPoints(UUID track_id) {
        return pointDao.selectAllPoints(track_id);
    }

  public void addPoint(Point point) {

        System.out.println("INSERT INTO tracks (track_id) VALUES ('"+ point.getTrack_id() +"');");

        System.out.println("INSERT INTO points VALUES ('"+ point.getPoint_id() + "','" + point.getTrack_id() +"',"+ point.getGps_latitude() + "," + point.getGps_longitude() + ",'"+point.getPoint_timestamp()+"');" );

        System.out.println("INSERT INTO point_sensor_readings VALUES ('" + point.getPoint_id() + "', 'Humidity', " + point.getPoint_humidity()+");");
        System.out.println("INSERT INTO point_sensor_readings VALUES ('" + point.getPoint_id() + "', 'Temperature', " + point.getPoint_temperature()+");");


      pointDao.insertPointToDB(point);
    }


}



