// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/Business%20Logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:flutter_maps/Constants/colors.dart';
import 'package:flutter_maps/Constants/strings.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> phoneFormKey = GlobalKey();

  late String phoneNumber;

  Widget buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What is your Phone Number?',
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
          child: const Text(
            'Please Enter Your Phone Number to Verify Your Account.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }

  Widget buildPhoneFormField() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.lightGrey),
              borderRadius: const BorderRadius.all(
                Radius.circular(28),
              ),
            ),
            child: Text(
              generateCountryFlag() + ' +20',
              style: const TextStyle(
                fontSize: 18,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.blue),
              borderRadius: const BorderRadius.all(
                Radius.circular(28),
              ),
            ),
            child: TextFormField(
              autofocus: true,
              style: const TextStyle(
                fontSize: 18,
                letterSpacing: 2,
              ),
              decoration: const InputDecoration(border: InputBorder.none),
              cursorColor: Colors.black,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Youe Phone Number ';
                } else if (value.length < 11) {
                  return 'Too Short for a Phone Number!';
                }
                return null;
              },
              onSaved: (value) {
                phoneNumber = value!;
              },
            ),
          ),
        ),
      ],
    );
  }

  String generateCountryFlag() {
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  Future<void> register(BuildContext context) async {
    if (!phoneFormKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      phoneFormKey.currentState!.save();
      BlocProvider.of<PhoneAuthCubit>(context).sumbitPhoneNumber(phoneNumber);
    }
  }

  Widget buildNextButton(context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          showProgressIndicator(context);

          register(context);
        },
        child: const Text(
          'Next',
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

  void showProgressIndicator(context) {
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

  Widget buildPhoneNumberSubmittedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }
        if (state is PhoneNumberSumbitted) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(otpScreen, arguments: phoneNumber);
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
      body: Form(
        key: phoneFormKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildIntroTexts(),
              const SizedBox(
                height: 110,
              ),
              buildPhoneFormField(),
              const SizedBox(
                height: 60,
              ),
              buildNextButton(context),
              buildPhoneNumberSubmittedBloc(),
            ],
          ),
        ),
      ),
    ));
  }
}
