// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/Business%20Logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:flutter_maps/Constants/strings.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider<PhoneAuthCubit>(
        create: (context) => phoneAuthCubit,
        child: ElevatedButton(
          onPressed: () async {
            await phoneAuthCubit.logOut();
            Navigator.of(context).pushReplacementNamed(loginScreen);
          },
          child: const Text(
            'LogOut',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 50),
              primary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              )),
        ),
      ),
    );
  }
}
