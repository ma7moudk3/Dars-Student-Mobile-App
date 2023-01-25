import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/static_page_controller.dart';

class StaticPageView extends GetView<StaticPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StaticPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StaticPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
