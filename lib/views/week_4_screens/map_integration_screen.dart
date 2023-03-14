import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as prefix;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

class MapItegrationScreen extends StatefulWidget {
  const MapItegrationScreen({Key? key}) : super(key: key);

  @override
  State<MapItegrationScreen> createState() => _MapItegrationScreenState();
}

class _MapItegrationScreenState extends State<MapItegrationScreen> {
  var kGoogleApiKey = "AIzaSyDU8ixiHp9IPRMVAMmndBMEXzZOmxKwYtw";
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  final List<LatLng> _polyLinesPoints = [];
  late MapType _currentMapType = MapType.normal;
  TextEditingController startPointController = TextEditingController();
  TextEditingController endPointController = TextEditingController();

  // LatLng lastMapPosition = const LatLng(21.3874937, 72.8636058457404);

  double firstLat = 0;
  double firstLng = 0;
  double lastLat = 0;
  double lastLng = 0;

  Future<void> markerAdd(
      {required double firstLat,
      required double firstLng,
      required double lastLat,
      required double lastLng,
      required String title}) async {
    _markers.clear();

    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(LatLng(firstLat, firstLng).toString()),
      position: LatLng(firstLat, firstLng),
      infoWindow: InfoWindow(
        title: title,
        // snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ));

    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(LatLng(lastLat, lastLng).toString()),
      position: LatLng(lastLat, lastLng),
      infoWindow: InfoWindow(
        title: title,
        // snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    setState(() {});
  }

  Future<void> polylineAdd(
      {required double firstLat, required double firstLng, required double lastLat, required double lastLng}) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        kGoogleApiKey, PointLatLng(firstLat, firstLng), PointLatLng(lastLat, lastLng));
    // print(result.points);

    if (result.points.isNotEmpty) {
      _polyLinesPoints.clear();

      result.points.forEach((PointLatLng point) {
        _polyLinesPoints.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    setState(() {});
  }

  getInitialPosition() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position initPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      firstLat = initPosition.latitude;
      firstLng = initPosition.longitude;
    });

    markerAdd(firstLat: firstLat, firstLng: firstLng, lastLat: lastLat, lastLng: lastLng, title: "");

    _controller
        ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(firstLat, firstLng), zoom: 10)));

    List<Placemark> placemarks = await placemarkFromCoordinates(firstLat, firstLng);

    Placemark place = placemarks[0];

    startPointController.text = '${place.subLocality}, ${place.locality}-${place.postalCode}, ${place.country}';
  }

  @override
  void initState() {
    // TODO: implement initState
    getInitialPosition();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (val) async {
              setState(() {
                lastLat = val.latitude;
                lastLng = val.longitude;
              });

              markerAdd(firstLat: firstLat, firstLng: firstLng, lastLat: lastLat, lastLng: lastLng, title: "");

              polylineAdd(firstLat: firstLat, firstLng: firstLng, lastLat: lastLat, lastLng: lastLng);

              _controller?.animateCamera(
                  CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lastLat, lastLng), zoom: 10)));

              List<Placemark> placemarks = await placemarkFromCoordinates(lastLat, lastLng);

              Placemark place = placemarks[0];

              endPointController.text = '${place.subLocality}, ${place.locality}-${place.postalCode}, ${place.country}';
            },
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              setState(() {});
            },
            polylines: {
              Polyline(polylineId: const PolylineId("val"), points: _polyLinesPoints, width: 4, color: Colors.indigo),
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(21.233885388787453, 72.8636058457404),
              zoom: 12,
            ),
            mapType: _currentMapType,
            markers: _markers,
          ),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                color: CupertinoColors.darkBackgroundGray.withOpacity(0.7),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Places",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        TextField(
                          controller: startPointController,
                          onTap: () async {
                            prefix.Prediction? prediction = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: kGoogleApiKey,
                                mode: Mode.overlay,
                                language: "en",
                                types: [],
                                strictbounds: false,
                                components: [prefix.Component(prefix.Component.country, "ind")]);

                            print(prediction!.description);

                            setState(() {
                              startPointController.text = prediction.description as String;
                            });

                            List<Location> locations = await locationFromAddress(startPointController.text);

                            setState(() {
                              firstLat = locations[0].latitude;
                              firstLng = locations[0].longitude;
                            });

                            markerAdd(
                                firstLat: firstLat,
                                firstLng: firstLng,
                                lastLat: lastLat,
                                lastLng: lastLng,
                                title: prediction.description.toString());

                            polylineAdd(firstLat: firstLat, firstLng: firstLng, lastLat: lastLat, lastLng: lastLng);

                            _controller?.animateCamera(CameraUpdate.newCameraPosition(
                                CameraPosition(target: LatLng(firstLat, firstLng), zoom: 10)));
                          },
                          decoration: InputDecoration(
                            label: const Text(
                              "Choose start point",
                              // style: TextStyle(color: Colors.grey),
                            ),
                            prefixIcon: const Icon(Icons.search, color: Colors.grey),
                            filled: true,
                            fillColor: CupertinoColors.darkBackgroundGray.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          readOnly: true,
                        ),
                        TextField(
                          controller: endPointController,
                          onTap: () async {
                            prefix.Prediction? prediction = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: kGoogleApiKey,
                                mode: Mode.overlay,
                                language: "en",
                                types: [],
                                strictbounds: false,
                                components: [prefix.Component(prefix.Component.country, "ind")]);

                            print(prediction);

                            setState(() {
                              endPointController.text = prediction!.description as String;
                            });

                            List<Location> locations = await locationFromAddress(endPointController.text);

                            setState(() {
                              lastLat = locations[0].latitude;
                              lastLng = locations[0].longitude;
                            });

                            markerAdd(
                                firstLat: firstLat,
                                firstLng: firstLng,
                                lastLat: lastLat,
                                lastLng: lastLng,
                                title: prediction!.description.toString());

                            polylineAdd(firstLat: firstLat, firstLng: firstLng, lastLat: lastLat, lastLng: lastLng);

                            _controller?.animateCamera(CameraUpdate.newCameraPosition(
                                CameraPosition(target: LatLng(lastLat, lastLng), zoom: 10)));
                          },
                          decoration: InputDecoration(
                            label: const Text(
                              "Choose end point",
                              // style: TextStyle(color: Colors.grey),
                            ),
                            prefixIcon: const Icon(Icons.search, color: Colors.grey),
                            filled: true,
                            fillColor: CupertinoColors.darkBackgroundGray.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
                          });
                        },
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.map, size: 36.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
