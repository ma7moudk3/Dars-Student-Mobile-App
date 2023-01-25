import 'package:hessa_student/app/constants/exports.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/login_controller.dart';
import '../widgets/login_content.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagesManager.loginBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: ColorManager.black.withOpacity(0.60),
          ),
        ),
        Scaffold(
          backgroundColor: ColorManager.transparent,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: 16.w,
                  top: 99.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PrimaryText(
                        LocaleKeys.do_your_sign_in,
                        fontSize: 18.sp,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.white,
                      ),
                      SizedBox(height: 5.h),
                      PrimaryText(
                        LocaleKeys.welcome_in_hessa_we_missed_you,
                        fontSize: 14.sp,
                        fontWeight: FontWeightManager.softLight,
                        color: ColorManager.white,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 38.h,
                  left: 18.w,
                  right: 18.w,
                  child: const LoginContent(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
