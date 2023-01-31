import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/teacher_details_controller.dart';

class TeacherDetailsView extends GetView<TeacherDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TeacherDetailsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TeacherDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
