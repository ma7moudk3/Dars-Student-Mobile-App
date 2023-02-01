import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_payment_way_controller.dart';

class AddPaymentWayView extends GetView<AddPaymentWayController> {
  const AddPaymentWayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddPaymentWayView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddPaymentWayView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
