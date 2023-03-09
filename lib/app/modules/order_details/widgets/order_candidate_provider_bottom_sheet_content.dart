import 'package:cached_network_image/cached_network_image.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../constants/links.dart';
import '../controllers/order_details_controller.dart';

class OrderCandidateProviderWidget extends GetView<OrderDetailsController> {
  const OrderCandidateProviderWidget({
    super.key,
    required this.candidateProvider,
  });

  final dynamic candidateProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 26.w,
              height: 6.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorManager.borderColor3,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          StatefulBuilder(builder: (BuildContext context, setState) {
            String candidateProviderPicture = // provider = teacher
                "${Links.baseLink}${Links.profileImageById}?userid=${candidateProvider?["userId"] ?? -1}";
            return Container(
              width: 58.w,
              height: 65.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    candidateProviderPicture,
                    errorListener: () {
                      setState(() {
                        candidateProviderPicture =
                            "https://www.shareicon.net/data/2016/06/10/586098_guest_512x512.png";
                      });
                    },
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x19000000).withOpacity(0.07),
                    spreadRadius: 0,
                    offset: const Offset(0, 12),
                    blurRadius: 15,
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: 5.h),
          PrimaryText(
            candidateProvider?["userName"] ?? "",
            fontSize: 14,
            fontWeight: FontWeightManager.softLight,
          ),
          PrimaryText(
            'نابلس - القدس', // TODO: change to real data
            fontSize: 14,
            color: ColorManager.fontColor7,
            fontWeight: FontWeightManager.softLight,
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryButton(
                  width: 265.w,
                  onPressed: () async {
                    // await controller.approveCandidateProvider(
                    //   providerId: candidateProvider?["id"] ?? -1,
                    // );
                  },
                  title: LocaleKeys.approve_teacher.tr,
                ),
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                    width: 48.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: ColorManager.yellow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        ImagesManager.messagingIcon,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
