package com.markstart.rainforest.api;


import com.markstart.rainforest.model.Point;
import com.markstart.rainforest.model.Track;
import com.markstart.rainforest.service.PointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

// @CrossOrigin(origins = "http://domain2.com", maxAge = 3600)

@RequestMapping("/tracks")
@RestController
public class PointController {
    private final PointService pointService;

    @Autowired
    public PointController(PointService pointService) {
        this.pointService = pointService;
    }


    @CrossOrigin
    @GetMapping
    public List<Track> getAllTracks() {
        return pointService.getAllTracks();
    }

   @CrossOrigin
    @GetMapping(path = "/{track_id}")
    public List<Point> getAllPoints(@PathVariable("track_id") UUID track_id) {
        return pointService.getAllPoints(track_id);
    }


    @RequestMapping(method = RequestMethod.PUT, consumes = MediaType.APPLICATION_JSON_VALUE)
    public void addPoint(@RequestBody Point point) {
        System.out.println(point);
        pointService.addPoint(point);
    }
}
