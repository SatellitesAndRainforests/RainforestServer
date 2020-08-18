package com.markstart.rainforest.api;


import com.markstart.rainforest.model.Point;
import com.markstart.rainforest.model.Track;
import com.markstart.rainforest.service.PointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/tracks")
@RestController
public class PointController {
    private final PointService pointService;

    @Autowired
    public PointController( PointService pointService) {
        this.pointService = pointService;
    }




    @GetMapping
    public List<Track> getAllTracks() {
        return pointService.getAllTracks();
    }


    @GetMapping( path = "/{track_id}")
    public List<Point> getAllPoints(@PathVariable("track_id") int track_id) {
        return pointService.getAllPoints(track_id);
    }






//    @RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
//    public void addPoint(@RequestBody Point point) {
//        pointService.addPoint(point);
//    }
}
