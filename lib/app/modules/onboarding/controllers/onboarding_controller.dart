import '../../../constants/exports.dart';

class OnboardingController extends GetxController {
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> introList = [
    {
      "curve": "assets/svg/curve1.svg",
      "image": "assets/images/intro1.png",
      "title": "تعليم مساند برؤية جديدة",
      "desc":
          "من خلال تطبيق حصة يمكنك تقييم المعلم الخاص بأبنائك و جدولة الحصص الخاصة بهم بكل سهولة"
    },
    {
      "curve": "assets/svg/curve2.svg",
      "image": "assets/images/intro2.png",
      "title": "تعليم مساند برؤية جديدة",
      "desc":
          "من خلال تطبيق حصة يمكنك تقييم المعلم الخاص بأبنائك و جدولة الحصص الخاصة بهم بكل سهولة"
    },
    {
      "curve": "assets/svg/curve3.svg",
      "image": "assets/images/intro3.png",
      "title": "تعليم مساند برؤية جديدة",
      "desc": "حصة تقدم لك دروس مساندة بسرعة ، و سهولة و سعر أوفر"
    },
    {
      "curve": "assets/svg/curve4.svg",
      "image": "assets/images/intro4.png",
      "title": "تعليم مساند برؤية جديدة",
      "desc": "ساعد أبناءك في رفع تحصيلهم الاكاديمي و تطوير مهاراتهم"
    },
  ];
}
