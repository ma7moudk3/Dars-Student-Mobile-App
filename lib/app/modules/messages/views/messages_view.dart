import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../controllers/messages_controller.dart';
import '../widgets/message_widget.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(() => MessagesController());
    return Scaffold(
      appBar: const CustomAppBar(
        title: LocaleKeys.messages,
      ),
      body: Column(
        children: [
          SizedBox(height: 12.h),
          GetBuilder<MessagesController>(
            builder: (MessagesController controller) {
              return Expanded(
                child: Container(
                  width: Get.width.w,
                  padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1a000000),
                        offset: Offset(0, 1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: controller.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Message(
                        index: index,
                        isLastIndex: index == controller.length - 1,
                      );
                    },
                  ),
                ),
              );
            }
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
