// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, avoid_print, avoid_unnecessary_containers, prefer_typing_uninitialized_variables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/Business%20Logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:flutter_maps/Constants/colors.dart';
import 'package:flutter_maps/Constants/strings.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  final phonNumber;
  late String otpCode;

  OtpScreen({Key? key, required this.phonNumber}) : super(key: key);

  Widget buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify Your Phone Number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 2,
          ),
          child: RichText(
            text: TextSpan(
              text: 'Enter Your 6 digits code number sent to you at ',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: '$phonNumber',
                  style: const TextStyle(color: MyColors.blue),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildPinCodeFiels(context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(15),
          fieldHeight: 50,
          fieldWidth: 40,
          borderWidth: 1,
          activeFillColor: MyColors.lighBlue,
          inactiveFillColor: Colors.white,
          activeColor: MyColors.blue,
          inactiveColor: MyColors.blue,
          selectedColor: MyColors.blue,
          selectedFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        onCompleted: (submittedCode) {
          otpCode = submittedCode;
          print("Completed");
        },
        onChanged: (value) {},
      ),
    );
  }

  void login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).sumbitOTP(otpCode);
  }

  Widget buildVerifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          showProgressIndicator(context);
          login(context);
        },
        child: const Text(
          'Verify',
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
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 3,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  Widget buildPhoneVerificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }
        if (state is PhoneOtpVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(mapScreen);
        }
        if (state is ErrorOccurred) {
          Navigator.pop(context);
          String errorMsg = (state.errorMsg);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 3),
          ));
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 88,
          ),
          child: Column(
            children: [
              buildIntroTexts(),
              const SizedBox(
                height: 88,
              ),
              buildPinCodeFiels(context),
              const SizedBox(
                height: 60,
              ),
              buildVerifyButton(context),
              buildPhoneVerificationBloc(),
            ],
          ),
        ),
      ),
    );
  }
}
