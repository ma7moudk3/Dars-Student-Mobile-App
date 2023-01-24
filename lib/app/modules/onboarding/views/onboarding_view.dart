import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/modules/login_or_sign_up/views/login_or_sign_up_view.dart';
import 'package:hessa_student/app/modules/onboarding/widgets/intro_slider.dart';
import 'package:hessa_student/app/modules/onboarding/widgets/intro_slider_item.dart';
import 'package:hessa_student/app/routes/app_pages.dart';
import 'package:hessa_student/generated/locales.g.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionSlider(
      pageController: controller.pageController,
      skip: Padding(
        padding: EdgeInsets.only(right: 16.w),
        child: SizedBox(
          width: 65.w,
          child: PrimaryText(
            LocaleKeys.skip,
            color: ColorManager.black,
            fontSize: 14,
          ),
        ),
      ),
      next: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: SizedBox(
          width: 77.w,
          height: 33.h,
          child: PrimaryButton(
            onPressed: () {
              controller.pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            title: LocaleKeys.next,
            color: Colors.transparent,
            fontColor: ColorManager.primary,
          ),
        ),
      ),
      done: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: SizedBox(
          width: 77.w,
          height: 33.h,
          child: PrimaryButton(
            onPressed: () async {
              await Get.toNamed(Routes.LOGIN_OR_SIGN_UP, arguments: {
                "isFromOnboarding": true,
              });
            },
            title: LocaleKeys.skip,
            color: Colors.transparent,
            fontColor: ColorManager.primary,
          ),
        ),
      ),
      onDone: const LoginOrSignUpView(),
      unselectedDotColor: ColorManager.grey.withOpacity(0.5),
      selectedDotColor: ColorManager.primary,
      //onDone: const HomeView(),
      items: List.generate(
        controller.introList.length,
        (index) {
          return IntroductionSliderItem(
            image: Stack(
              children: [
                ClipRRect(
                  //  borderRadius: BorderRadius.circular(20),
                  child: Stack(children: [
                    Image.asset(
                      controller.introList[index]["image"],
                      height: 386.h,
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 386.h,
                      width: Get.width,
                      color: ColorManager.primary.withOpacity(0.23),
                    ),
                  ]),
                ),
                Positioned(
                  bottom: -1,
                  child: SvgPicture.asset(
                    controller.introList[index]["curve"],
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            title: controller.introList[index]["title"],
            description: controller.introList[index]["desc"],
          );
        },
      ),
    ));
  }
}
