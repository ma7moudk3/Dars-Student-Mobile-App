import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_information_controller.dart';

class ProfileInformationView extends GetView<ProfileInformationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileInformationView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ProfileInformationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
