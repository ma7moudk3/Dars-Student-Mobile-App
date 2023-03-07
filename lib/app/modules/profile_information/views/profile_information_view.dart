import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_information_controller.dart';

class ProfileInformationView extends GetView<ProfileInformationController> {
  const ProfileInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileInformationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfileInformationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
