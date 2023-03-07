import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../controllers/teacher_details_controller.dart';

class DarsTeacherBrief extends GetView<TeacherDetailsController> {
  const DarsTeacherBrief({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(13.0, 14.0, 14.0, 14.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(ImagesManager.tagIcon),
              SizedBox(width: 8.w),
              PrimaryText(
                LocaleKeys.brief,
                fontSize: 14.sp,
                fontWeight: FontWeightManager.softLight,
                color: ColorManager.fontColor,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          moreDivider(),
          SizedBox(height: 10.h),
          StatefulBuilder(builder: (BuildContext context, setState) {
            return Linkify(
              onOpen: (LinkableElement link) async {
                if (extractLink(controller.darsTeacherDetails.result != null
                        ? controller.darsTeacherDetails.result!.providers !=
                                null
                            ? controller.darsTeacherDetails.result!.providers!
                                    .aboutMe ??
                                ""
                            : ""
                        : "") !=
                    null) {
                  final url = Uri.parse(extractLink(
                      controller.darsTeacherDetails.result != null
                          ? controller.darsTeacherDetails.result!.providers !=
                                  null
                              ? controller.darsTeacherDetails.result!
                                      .providers!.aboutMe ??
                                  ""
                              : ""
                          : "")!);
                  if (url.isAbsolute) {
                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      throw 'Could not launch $link';
                    }
                  }
                }
              },
              textDirection: detectLang(
                      text: controller.darsTeacherDetails.result != null
                          ? controller.darsTeacherDetails.result!.providers !=
                                  null
                              ? controller.darsTeacherDetails.result!
                                      .providers!.aboutMe ??
                                  ""
                              : ""
                          : "")
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              text: controller.darsTeacherDetails.result != null
                  ? controller.darsTeacherDetails.result!.providers != null
                      ? controller
                              .darsTeacherDetails.result!.providers!.aboutMe ??
                          ""
                      : ""
                  : "",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: ColorManager.grey5,
                fontSize: 14.sp,
                fontWeight: FontWeightManager.light,
                fontFamily: FontConstants.fontFamily,
              ),
            );
          }),
          // PrimaryText(
          //   controller.darsTeacherDetails.result != null
          //       ? controller.darsTeacherDetails.result!.providers != null
          //           ? controller
          //                   .darsTeacherDetails.result!.providers!.aboutMe ??
          //               ""
          //           : ""
          //       : "",
          //   textDirection: detectLang(
          //           text: controller.darsTeacherDetails.result != null
          //               ? controller.darsTeacherDetails.result!.providers !=
          //                       null
          //                   ? controller.darsTeacherDetails.result!.providers!
          //                           .aboutMe ??
          //                       ""
          //                   : ""
          //               : "")
          //       ? TextDirection.ltr
          //       : TextDirection.rtl,
          //   textAlign: TextAlign.start,
          //   color: ColorManager.grey5,
          //   fontSize: 14.sp,
          // ),
        ],
      ),
    );
  }
}
