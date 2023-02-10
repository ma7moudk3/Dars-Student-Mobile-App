import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../controllers/preferred_teachers_controller.dart';

class PreferredTeachersView extends GetView<PreferredTeachersController> {
  const PreferredTeachersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.preferred_teachers,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorManager.fontColor,
            size: 20,
          ),
        ),
        action: const SizedBox.shrink(),
      ),
      body: const Center(
        child: Text(
          'PreferredTeachersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
