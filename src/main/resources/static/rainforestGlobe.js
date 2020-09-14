


    var map;
    var animated = true;
    var before = null;
    var dontAllowTimeElapse;

    const URL = "http://localhost:8000/tracks";         //change url for internet



    function init() {
      map = WE.map('map', {
        center: [-13, -130],
        zoom: 2,
        unconstrainedRotation: true,
        sky: true,
        dragging: true,
        scrollWheelZoom: true
      });

      applySatelliteMap();
      performAnimation();

    }


     function applySatelliteMap() {

         WE.tileLayer('https://webglearth.github.io/webglearth2-offline/{z}/{x}/{y}.jpg', {
           tileSize: 256,
           bounds: [[-85, -180], [85, 180]],
           minZoom: 0,
           maxZoom: 16,
           attribution: 'WebGLEarth Satellite',
           tms: true
         }).addTo(map);

         document.getElementById("satelliteButton").disabled = true;
         document.getElementById("streetButton").disabled = false;

     }


      function applyStreetMap() {

          WE.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
          }).addTo(map);

        document.getElementById("satelliteButton").disabled = false;
        document.getElementById("streetButton").disabled = true;

      }



    // Animation method modified from webGLEarth tutorial and thanks to :    https://stackoverflow.com/questions/44347598/webgl-earth-restart-animation-at-current-location
    function performAnimation() {

      toggleFlights(true);

      requestAnimationFrame(function animate(now) {
        if (animated) {
          var c = map.getPosition();
          var elapsed = before ? now - before : 0;

          if (dontAllowTimeElapse) {
            elapsed = 0;
          }

          before = now;
          map.setCenter([c[0], c[1] + 0.1 * (elapsed / 30)]);
          dontAllowTimeElapse = false;
          requestAnimationFrame(animate);
        }
      });
    }


    function pauseAnimation() {
      if (animated) {
        animated = false;
        document.getElementById("animationButton").value = "Start Animation";
        toggleFlights(false);

      } else {
        dontAllowTimeElapse = true;
        animated = true;
        performAnimation();
        document.getElementById("animationButton").value = "Pause Animation";

      }
    }


    function toggleFlights(status) {
      document.getElementById("hawaiiButton").disabled = status;
      document.getElementById("otherSideButton").disabled = status;
    }


    function flyToOtherSide() {
      panTo(antipode(map.getCenter()));
    }


    // From webGLEarth tutorial for inverse cooridantes.
    function antipode(coord) {
      return [-1 * coord[0], coord[1] - 180];
    }

    function setZoom(zoom) {
       map.setZoom(zoom);
    }

    function panTo(coords) {
       map.panTo(coords);
    }

    function zoomInOne() {
       map.zoomIn();
    }

    function zoomOutOne() {
      map.zoomOut();
    }


    function getTrackData() {

        document.getElementById("getdata").disabled = true;

        fetch( URL , {
          method: 'get'
        }).then(function (response) {
           return response.json();
        }).then(function (obj) {
           displayTrackList(obj);
        }).catch(function (err) {
           console.log("error" + err);
        });

    }


    function displayTrackList(jsonTrackData) {

        var listContainer = document.createElement('div'),
            listElement = document.createElement('ul'),
            listReset = document.createElement('p'),
            numberOfListItems = jsonTrackData.length,
            listItem,
            trackId,
            i;

        listContainer.setAttribute("id", "trackList");
        listReset.innerHTML = '<input type="button" value="Reset List" id="resetButton" class="toggleButton" onclick="removeElement(trackList); reset()">';

        document.getElementById('trackdata').appendChild(listContainer);
        listContainer.appendChild(listElement);
        listContainer.appendChild(listReset);

        for (i = 0; i < numberOfListItems; i++) {
          trackId = jsonTrackData[i].track_id;
          listItem = document.createElement('li');
          listItem.innerHTML = '<input type="button" value="' + trackId + '" class="toggleButton" onclick="getPointsData(value)"><br>';
          listElement.appendChild(listItem);
        }

      }


      function removeElement(elementID) {
        document.getElementById('trackdata').removeChild(elementID);
      }

      function reset() {
        document.getElementById("getdata").disabled = false;
      }



    var trackJson;    // Makes data available for other methods. Best practice ? used in goToPoint()

    function getPointsData(trackId) {

        document.getElementById("getdata").disabled = true;
        removeElement(document.getElementById("trackList"));

        fetch( URL + "/" + trackId, {
            method: 'get'
        }).then(function (response) {
            return response.json();
        }).then(function (obj) {

            trackJson = obj;     // assignment to global variable ?

            displayPointsList(obj);
            displayPointsOnMap(obj);
        }).catch(function (err) {
            console.log("error" + err);
        });

    }


    function displayPointsList(jsonPointData) {

        var listContainer = document.createElement('div'),
            listElement = document.createElement('ul'),
            listReset = document.createElement('p'),
            numberOfListItems = jsonPointData.length,
            noPointsMessage = document.createElement('p'),
            listItem,
            PointId,
            i;


        listContainer.setAttribute("id", "pointList");
        listReset.innerHTML = '<input type="button" value="Reset List" id="resetButton" class="toggleButton" onclick="removeElement(pointList); reset()">';

        document.getElementById('trackdata').appendChild(listContainer);
        listContainer.appendChild(listElement);
        listContainer.appendChild(noPointsMessage);
        listContainer.appendChild(listReset);

        if (jsonPointData.status == 500) {
             noPointsMessage.innerHTML = '<p> This track has no point data </p>';
        } else {

            for (i = 0; i < numberOfListItems; i++) {

                jsonItem = jsonPointData[i];
                pointId = jsonItem.point_id;
                listItem = document.createElement('li');
                listItem.innerHTML = '<input type="button" value="Point: ' + [i+1] + '" class="toggleButton" onclick="goToPoint(value)" >';
                listElement.appendChild(listItem);

            }

        }

    }


      // use of global trackJson

      function goToPoint(buttonValue) {
        if (animated) {
          pauseAnimation();
        }
        var pointID = buttonValue.substr(buttonValue.length - 1) - 1;

        panTo( [ trackJson[pointID].gps_latitude, trackJson[pointID].gps_longitude ] );
      }



      function displayPointsOnMap(json) {

        for (var i = 0; i < json.length; i++) {

          var location = [json[i].gps_latitude, json[i].gps_longitude];
          var marker = WE.marker(location).addTo(map);
          var item = json[i];
          var options = { maxWidth: 120, maxHeight: 100, closeButton: true };
          var pointDateTime = json[i].point_timestamp.split('T');
          var instructions;

          if (i == 0) {

            marker.bindPopup("<span style='font-size:10px;color:black'>" +
              "<b>Start: </b>Click on other points for their point data.<br> Try zooming in if the points are close together.<br><br>" +
              "<b>Point: " + [i + 1] + "</b>" +
              "<br>Date : " + pointDateTime[0] +
              "<br>Time : " + pointDateTime[1].split('.', '1') +
              "<br>Latitude: " + item.gps_latitude +
              "<br>Longitude: " + item.gps_longitude +
              "<br> Humidity: " + item.point_humidity +
              "<br>Temperature: " + item.point_temperature +
              "</span>", options).openPopup();

          } else {

            marker.bindPopup("<span style='font-size:10px;color:black'>" +
              "<b>Point: " + [i + 1] + "</b>" +
              "<br>Date : " + pointDateTime[0] +
              "<br>Time : " + pointDateTime[1].split('.', '1') +
              "<br>Latitude: " + item.gps_latitude +
              "<br>Longitude: " + item.gps_longitude +
              "<br> Humidity: " + item.point_humidity +
              "<br>Temperature: " + item.point_temperature +
              "</span>", options);
          }

        }

        drawLinesBetweenPoints(json);

      }


      function drawLinesBetweenPoints(json) {

        var pollygonArray = new Array();

        for (var i = 0; i < json.length - 1; i++) {

          var pointArray = [2];
          pointArray[0] = json[i].gps_latitude;
          pointArray[1] = json[i].gps_longitude;
          pollygonArray.push(pointArray);

        }

        var line = WE.polygon(pollygonArray, {
          color: '#03f',
          opacity: 1,
          fillColor: '#ff0',
          fillOpacity: 0.00001,
          weight: 2
        }).addTo(map);

      }


