// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/Business%20Logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:flutter_maps/Constants/colors.dart';
import 'package:flutter_maps/Constants/strings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  Widget buildDrawerHeader(context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.blue[100],
            ),
            child: Image.asset(
              'assets/images/123456.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Text(
          'Mahmoud Tolba',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          '01008443844',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget buildDrawerListItem(
      {required IconData leadingIcon,
      required String title,
      Widget? trailing,
      Function()? onTap,
      Color? color}) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? MyColors.blue,
      ),
      title: Text(title),
      trailing: trailing ??= const Icon(
        Icons.arrow_right,
        color: MyColors.blue,
      ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemDivider() {
    return const Divider(
      height: 0,
      thickness: 1,
      endIndent: 24,
    );
  }

  void _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  Widget builIcon(IconData icon, String url) {
    return InkWell(
      onTap: () {
        _launchURL(url);
      },
      child: Icon(
        icon,
        color: MyColors.blue,
        size: 35,
      ),
    );
  }

  Widget buildSocialMediaIcons() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16),
      child: Row(
        children: [
          builIcon(
            FontAwesomeIcons.facebook,
            'https://www.facebook.com/mahmoud.abdelwahab.127',
          ),
          const SizedBox(
            width: 15,
          ),
          builIcon(
            FontAwesomeIcons.youtube,
            'https://www.youtube.com/channel/UC9-BZIlytt6sr-S2rUTYkzA',
          ),
          const SizedBox(
            width: 20,
          ),
          builIcon(
            FontAwesomeIcons.github,
            'https://github.com/MTolba13',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        Container(
          padding: EdgeInsets.zero,
          height: 200,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue[100],
            ),
            child: buildDrawerHeader(context),
          ),
        ),
        buildDrawerListItem(
            leadingIcon: FontAwesomeIcons.user, title: 'My Profile'),
        buildDrawerListItemDivider(),
        buildDrawerListItem(
            leadingIcon: FontAwesomeIcons.history,
            title: 'Places History',
            onTap: () {}),
        buildDrawerListItemDivider(),
        buildDrawerListItem(leadingIcon: Icons.settings, title: 'Setting'),
        buildDrawerListItemDivider(),
        buildDrawerListItem(leadingIcon: Icons.help, title: 'Help'),
        buildDrawerListItemDivider(),
        BlocProvider<PhoneAuthCubit>(
          create: (context) => phoneAuthCubit,
          child: buildDrawerListItem(
            leadingIcon: Icons.logout,
            title: 'LogOut',
            onTap: () async {
              await phoneAuthCubit.logOut();
              Navigator.of(context).pushReplacementNamed(loginScreen);
            },
            color: Colors.red,
            trailing: const SizedBox(),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        ListTile(
          leading: Text(
            'Follow us',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ),
        buildSocialMediaIcons(),
      ],
    ));
  }
}
