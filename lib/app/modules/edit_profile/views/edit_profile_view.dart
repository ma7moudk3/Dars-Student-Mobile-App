import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.personal_profile,
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
        action: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {},
          child: Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: ColorManager.primary,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: ColorManager.primary,
                size: 16,
              ),
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'EditProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
