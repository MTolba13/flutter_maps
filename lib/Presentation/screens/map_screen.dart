// ignore_for_file: avoid_unnecessary_containers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/Business%20Logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:flutter_maps/Constants/colors.dart';
import 'package:flutter_maps/Constants/strings.dart';
import 'package:flutter_maps/Helpers/location_helper.dart';
import 'package:flutter_maps/Presentation/widgets/my_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  FloatingSearchBarController controller = FloatingSearchBarController();

  Completer<GoogleMapController> mapController = Completer();

  static Position? position;

  static final CameraPosition myCurrentLocationCameraPosion = CameraPosition(
    bearing: 0.0,
    target: LatLng(
      position!.latitude,
      position!.longitude,
    ),
    zoom: 17,
  );

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getMyCurrentLocation();
  }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        mapController.complete(controller);
      },
      initialCameraPosition: myCurrentLocationCameraPosion,
    );
  }

  Future<void> goToMyCurrentLocation() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(myCurrentLocationCameraPosion),
    );
  }

  Widget buildFloatingSearchbar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
        controller: controller,
        elevation: 8,
        hintStyle: const TextStyle(fontSize: 18),
        queryStyle: const TextStyle(fontSize: 18),
        hint: 'Find a Place...',
        border: const BorderSide(
          style: BorderStyle.none,
        ),
        margins: const EdgeInsets.fromLTRB(20, 70, 20, 0),
        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        height: 52,
        iconColor: MyColors.blue,
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(microseconds: 600),
        transitionCurve: Curves.bounceOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0 : -1,
        openAxisAlignment: 0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(microseconds: 500),
        onQueryChanged: (query) {},
        onFocusChanged: (_) {},
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
                icon: Icon(
                  Icons.place_outlined,
                  color: Colors.black.withOpacity(0.6),
                ),
                onPressed: () {}),
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: Colors.accents.map((color) {
                  return Container(height: 112, color: color);
                }).toList(),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          position != null
              ? buildMap()
              : Center(
                  child: Container(
                    child: const CircularProgressIndicator(
                      color: MyColors.blue,
                    ),
                  ),
                ),
          buildFloatingSearchbar(),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 8, 30),
        child: FloatingActionButton(
          child: const Icon(
            Icons.place_outlined,
            color: Colors.white,
          ),
          backgroundColor: MyColors.blue,
          onPressed: goToMyCurrentLocation,
        ),
      ),
    );
  }
}
