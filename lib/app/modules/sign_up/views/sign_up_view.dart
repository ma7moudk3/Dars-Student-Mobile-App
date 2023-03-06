import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../controllers/sign_up_controller.dart';
import '../widgets/sign_up_content.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagesManager.signUpBackground),
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
              children: [
                Positioned(
                  right: 16.w,
                  top: Get.arguments != null &&
                          (Get.arguments['isFromLoginOrSignUp'] != null &&
                              Get.arguments['isFromLoginOrSignUp'] == true)
                      ? 80.h
                      : 75.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PrimaryText(
                        LocaleKeys.make_a_featured_account,
                        fontSize: 18.sp,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.white,
                      ),
                      SizedBox(height: 5.h),
                      PrimaryText(
                        LocaleKeys.welcome_in_dars,
                        fontSize: 14.sp,
                        fontWeight: FontWeightManager.softLight,
                        color: ColorManager.white,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Visibility(
                    visible: Get.arguments != null &&
                        (Get.arguments['isFromLoginOrSignUp'] != null &&
                            Get.arguments['isFromLoginOrSignUp'] == true),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: ColorManager.white,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15.h,
                  left: 18.w,
                  right: 18.w,
                  child: const SignUpContent(),
                ),
                // Positioned(
                //   bottom: 8.h,
                //   left: 110.w,
                //   right: 110.w,
                //   child: PrimaryText(
                //     "${LocaleKeys.contentRight.tr}${DateTime.now().year.toString()}",
                //     fontSize: 12.sp,
                //     fontWeight: FontWeightManager.light,
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
