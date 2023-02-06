import 'package:hessa_student/app/constants/exports.dart';

import '../controllers/verify_account_controller.dart';

class VerifyAccountView extends GetView<VerifyAccountController> {
  const VerifyAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VerifyAccountView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            PrimaryText(
              "Email Verification: ${Get.arguments != null ? Get.arguments["isEmailConfirmed"] : 'null'}",
            ),
            PrimaryText(
              "Phone Verification: ${Get.arguments != null ? Get.arguments["isPhoneNumberConfirmed"] : 'null'}",
            ),
          ],
        ),
      ),
    );
  }
}
