import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:fluuter_boilerplate/app_setup/mapdata/map_data.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/extensions/functions.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  MapController mapController = MapController();
  double currentZoom = 16.0;
  LatLng currentCenter = LatLng(27.7172, 85.3240);
  LatLng currentLocation = LatLng(0, 0);
  bool isOpen = false;

  void _zoomOut() {
    if (currentZoom == 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You cannot zoom out any further'),
        ),
      );
    } else {
      currentZoom = currentZoom - 1;
      mapController.move(currentCenter, currentZoom);
    }
  }

  void _zoomIn() {
    if (currentZoom == 18) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You cannot zoom in any further'),
        ),
      );
    } else {
      currentZoom = currentZoom + 1;
      mapController.move(currentCenter, currentZoom);
    }
  }

  Future<LatLng> _animatedMoveForMap() async {
    Position locationData;

    locationData = await Geolocator.getCurrentPosition();

    // * A Tween is a linear interpolation between a beginning and ending value.
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: locationData.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: locationData.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: 16.0);

    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
      currentCenter =
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation));
      currentZoom = zoomTween.evaluate(animation);
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
    return LatLng(locationData.latitude, locationData.longitude);
  }

  @override
  void initState() {
    locationPermissionHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.map.translateTo(context)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _animatedMoveForMap().then((value) {
            setState(() {
              currentLocation = value;
            });
          });
        },
        child: const Icon(Icons.navigation),
      ),
      body: Stack(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                controller: mapController,
                center: currentCenter,
                zoom: currentZoom,
                enableScrollWheel: true,
                maxZoom: 18,
                minZoom: 6,
                onPositionChanged: (position, isGesture) {
                  if (isGesture) {
                    setState(() {
                      currentCenter = position.center ?? currentCenter;
                      currentZoom = position.zoom ?? currentZoom;
                    });
                  }
                },
              ),
              nonRotatedLayers: [
                TileLayerOptions(
                  urlTemplate: MapUrl.templteUrl,
                  additionalOptions: {
                    'accessToken': MapUrl.acceesToken,
                    'id': MapUrl.id,
                  },
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      point: currentLocation,
                      builder: (context) {
                        return const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 30,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _zoomIn();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    primary: const Color.fromARGB(255, 36, 34, 34),
                    shape: const CircleBorder(),
                    minimumSize: const Size(35, 35),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 15,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _zoomOut();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    primary: const Color.fromARGB(255, 36, 34, 34),
                    shape: const CircleBorder(),
                    minimumSize: const Size(35, 35),
                  ),
                  child: const Icon(
                    Icons.remove,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
