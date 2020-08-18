package com.markstart.rainforest.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.sql.Timestamp;

public class Point {

    private int point_id;
    private int track_id;
    private float gps_latitude;
    private float gps_longitude;
    private Timestamp point_timestamp;
    private float point_humidity;
    private float point_temperature;


    public Point(int point_id, int track_id, float gps_latitude, float gps_longitude, Timestamp point_timestamp, float point_humidity, float point_temperature) {
        this.point_id = point_id;
        this.track_id = track_id;
        this.gps_latitude = gps_latitude;
        this.gps_longitude = gps_longitude;
        this.point_timestamp = point_timestamp;
        this.point_humidity = point_humidity;
        this.point_temperature = point_temperature;
    }

    public int getPoint_id() {
        return point_id;
    }

    public void setPoint_id(int point_id) {
        this.point_id = point_id;
    }

    public int getTrack_id() {
        return track_id;
    }

    public void setTrack_id(int track_id) {
        this.track_id = track_id;
    }

    public float getGps_latitude() {
        return gps_latitude;
    }

    public void setGps_latitude(float gps_latitude) {
        this.gps_latitude = gps_latitude;
    }

    public float getGps_longitude() {
        return gps_longitude;
    }

    public void setGps_longitude(float gps_longitude) {
        this.gps_longitude = gps_longitude;
    }

    public Timestamp getPoint_timestamp() {
        return point_timestamp;
    }

    public void setPoint_timestamp(Timestamp point_timestamp) {
        this.point_timestamp = point_timestamp;
    }

    public float getPoint_humidity() {
        return point_humidity;
    }

    public void setPoint_humidity(float point_humidity) {
        this.point_humidity = point_humidity;
    }

    public float getPoint_temperature() {
        return point_temperature;
    }

    public void setPoint_temperature(float point_temperature) {
        this.point_temperature = point_temperature;
    }
}

