// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_maps/Constants/colors.dart';
import 'package:flutter_maps/Data/models/place_directions.dart';

class DistanceAndTime extends StatelessWidget {
  final PlaceDirections placeDirections;
  final isTimeAndDistanceVisible;

  const DistanceAndTime(
      {Key? key,
      required this.placeDirections,
      required this.isTimeAndDistanceVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isTimeAndDistanceVisible,
      child: Positioned(
          top: 0,
          bottom: 570,
          left: 0,
          right: 0,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Card(
                  margin: const EdgeInsetsDirectional.fromSTEB(20, 50, 20, 0),
                  color: Colors.white,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    leading: const Icon(
                      Icons.access_time_filled_outlined,
                      color: MyColors.blue,
                      size: 30,
                    ),
                    title: Text(
                      placeDirections.toatalDuration,
                      style: const TextStyle(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Flexible(
                flex: 1,
                child: Card(
                  margin: const EdgeInsetsDirectional.fromSTEB(20, 50, 20, 0),
                  color: Colors.white,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    leading: const Icon(
                      Icons.directions_car_filled,
                      color: MyColors.blue,
                      size: 30,
                    ),
                    title: Text(
                      placeDirections.totalDistance,
                      style: const TextStyle(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
