import 'package:Mevo/constants/padding_constants.dart';
import 'package:Mevo/constants/style_constants.dart';
import 'package:Mevo/home/discover/discover.dart';
import 'package:flutter/material.dart';

import 'profile/profilePage/profile.dart';

class Management extends StatelessWidget with PaddingConstants, StyleConstants {
  const Management({super.key});

  @override
  Widget build(BuildContext context) {
    return buildTabController(context);
  }

  DefaultTabController buildTabController(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: TabBar(
            tabs: <Widget>[
              Tab(icon: buildWrapHomeIcon(context)),
              Tab(icon: buildWrapPersonIcon(context)),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Discover(),
            Profile(),
          ],
        ),
      ),
    );
  }

  Wrap buildWrapPersonIcon(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            const Icon(Icons.person),
            Text('Profil', style: defaultTextStyle)
          ],
        ),
      ],
    );
  }

  Wrap buildWrapHomeIcon(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            const Icon(Icons.home),
            Text('Keşfet', style: defaultTextStyle)
          ],
        ),
      ],
    );
  }
}
