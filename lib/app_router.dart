import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Business%20Logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'Constants/strings.dart';
import 'Presentation/screens/login_screen.dart';
import 'Presentation/screens/map_screen.dart';
import 'Presentation/screens/otp.dart';

class AppRouter {
  var phoneAuthCubit = PhoneAuthCubit();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit,
            child: LoginScreen(),
          ),
        );

      case otpScreen:
        final phoneNumber = settings.arguments;

        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit,
            child: OtpScreen(
              phonNumber: phoneNumber,
            ),
          ),
        );

      case mapScreen:
        return MaterialPageRoute(
          builder: (_) => const MapScreen(),
        );
    }
  }
}
