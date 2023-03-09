import 'package:cached_network_image/cached_network_image.dart';

import '../../app/constants/exports.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.title,
    required this.image,
    this.width = 110,
    this.height = 130,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String image;
  final double? width;
  final double? height;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width!.w,
        height: height!.h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: ColorManager.primary.withOpacity(0.12),
                ),
                width: width!.w,
                height: height!.h,
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      width: width!.w,
                      height: (height! / 1.4).h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0.h),
                    child: PrimaryText(
                      title,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
