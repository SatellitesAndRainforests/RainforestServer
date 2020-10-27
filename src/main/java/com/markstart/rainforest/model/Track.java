package com.markstart.rainforest.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.UUID;

public class Track {

    private UUID track_id;
    private String track_name;
    private String track_description;

    public Track(@JsonProperty("track_id") UUID track_id, String track_name, String track_description) {

        this.track_id = track_id;
        this.track_name = track_name;
        this.track_description = track_description;
    }

    public UUID getTrack_id() {
        return track_id;
    }

    public void setTrack_id(UUID track_id) {
        this.track_id = track_id;
    }

    public String getTrack_name() {
        return track_name;
    }

    public void setTrack_name(String track_name) {
        this.track_name = track_name;
    }

    public String getTrack_description() {
        return track_description;
    }

    public void setTrack_description(String track_description) {
        this.track_description = track_description;
    }


}
