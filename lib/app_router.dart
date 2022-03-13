import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/Business%20Logic/cubit/maps/maps_cubit.dart';
import 'package:flutter_maps/Data/repository/maps_repo.dart';
import 'package:flutter_maps/Data/webservices/placeswebservices.dart';

import 'Business%20Logic/cubit/phone_auth/cubit/phone_auth_cubit.dart';
import 'Constants/strings.dart';
import 'Presentation/screens/login_screen.dart';
import 'Presentation/screens/map_screen.dart';
import 'Presentation/screens/otp.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mapScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                MapsCubit(MapsRepository(PlacesWebservices())),
            child: const MapScreen(),
          ),
        );

      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: LoginScreen(),
          ),
        );

      case otpScreen:
        final phoneNumber = settings.arguments;

        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpScreen(
              phonNumber: phoneNumber,
            ),
          ),
        );
    }
  }
}
