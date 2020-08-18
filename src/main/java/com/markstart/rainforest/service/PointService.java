package com.markstart.rainforest.service;

import com.markstart.rainforest.dao.PointDao;
import com.markstart.rainforest.model.Point;
import com.markstart.rainforest.model.Track;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PointService {

    private final PointDao pointDao;

    @Autowired
    public PointService(@Qualifier("postgres") PointDao pointDao) {
        this.pointDao = pointDao;
    }



    public List<Track> getAllTracks() { return pointDao.selectAllTracks();
    }

    public List<Point> getAllPoints(int track_id) {
        return pointDao.selectAllPoints(track_id);
    }



    //  public void addPoint(Point point) {
//       pointDao.insertPointToDB(point);
//    }
}
