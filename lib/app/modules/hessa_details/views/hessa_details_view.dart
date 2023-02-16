import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/modules/hessa_details/widgets/one_hessa_widget.dart';
import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/constants.dart';
import '../controllers/hessa_details_controller.dart';
import '../widgets/studying_package_widget.dart';

class HessaDetailsView extends GetView<HessaDetailsController> {
  const HessaDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.hessa_details.tr,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorManager.fontColor,
              size: 20,
            ),
          ),
        ),
        action: const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<HessaDetailsController>(
              builder: (HessaDetailsController controller) {
            if (controller.hessaType == HessaType.oneHessa) {
              return const OneHessaWidget();
            } else {
              // HessaType.studyingPackage
              return const StudyingPackageWidget();
            }
          }),
        ),
      ),
    );
  }
}
