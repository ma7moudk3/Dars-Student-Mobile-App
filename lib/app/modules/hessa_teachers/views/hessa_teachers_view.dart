import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hessa_teachers_controller.dart';

class HessaTeachersView extends GetView<HessaTeachersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HessaTeachersView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HessaTeachersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
