import 'package:flutter/cupertino.dart';
import '../../app/constants/exports.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CupertinoActivityIndicator(
      radius: 16.h,
      animating: true,
    ));
  }
}
