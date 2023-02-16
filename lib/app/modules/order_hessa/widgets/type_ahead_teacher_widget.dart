import 'package:hessa_student/app/modules/order_hessa/data/models/teacher.dart';

import '../../../constants/exports.dart';
import '../controllers/order_hessa_controller.dart';

class TypeAheadTeacherWidget extends GetView<OrderHessaController> {
  const TypeAheadTeacherWidget({Key? key, required this.teacher})
      : super(key: key);
  final Teacher teacher;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(teacher.picture),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    width: 1,
                    color: ColorManager.primary,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PrimaryText(
                          teacher.name,
                          color: ColorManager.fontColor,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.star,
                              color: ColorManager.orange,
                              size: 14.sp,
                            ),
                            SizedBox(
                              width: 40.w,
                              child: PrimaryText(
                                "4.5",
                                color: ColorManager.fontColor,
                                fontSize: 12.sp,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PrimaryText(
                          teacher.subjects
                              .map((String subject) => subject.toString())
                              .join(", "),
                          color: ColorManager.primary,
                          fontWeight: FontWeightManager.softLight,
                          fontSize: 11.sp,
                        ),
                        const Spacer(),
                        PrimaryText(
                          teacher.address,
                          color: ColorManager.fontColor7,
                          fontSize: 12.sp,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Divider(
            color: ColorManager.borderColor3,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
