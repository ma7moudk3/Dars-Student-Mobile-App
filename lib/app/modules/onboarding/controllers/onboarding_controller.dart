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
      "title": """ابدأ بتقديم دروس مساندة لطلاب المدارس
و تعليم مهارات لهم""",
      "desc":
          """نمنحك تجربة عمل حر , مرن , يبني مهاراتك وقدراتك من خلال تجربة تعليم وجاهي وافتراضي"""
    },
    {
      "curve": "assets/svg/curve2.svg",
      "image": "assets/images/intro2.png",
      "title": """ابدأ بتقديم دروس مساندة لطلاب المدارس
و تعليم مهارات لهم""",
      "desc":
          """يمكنك اختيار الاوقات الانسب لك لتعليم طلاب المدراس , يمكنك الحصول على دخل مالي مجدي"""
    },
    {
      "curve": "assets/svg/curve3.svg",
      "image": "assets/images/intro3.png",
      "title": """ابدأ بتقديم دروس مساندة لطلاب المدارس
و تعليم مهارات لهم""",
      "desc":
          """حصة , يمكن من خلالها أن تكتسب شبكة علاقات جديدة في منطقتك , و تكتسب خبرة عملية في مجال العمل"""
    },
    {
      "curve": "assets/svg/curve4.svg",
      "image": "assets/images/intro4.png",
      "title": """ابدأ بتقديم دروس مساندة لطلاب المدارس
و تعليم مهارات لهم""",
      "desc":
          """حصة , يمكن من خلالها أن تكتسب شبكة علاقات جديدة في منطقتك , و تكتسب خبرة عملية في مجال العمل"""
    },
  ];
}
