import 'dart:developer';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:time_range/time_range.dart';
import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

class OrderHessaController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int sessionWay = 0; // 0 face-to-face, 1 electronic, 2 both
  int teacherGender = 0; // 0 male, 1 female, 2 both
  int orderType = 0; // 0 one hessa, 1 school package
  late TextEditingController hessaDateController,
      hessaTimeController,
      locationController,
      teacherNameController, notesController;
  DateTime hessaDate = DateTime.now();
  TimeRangeResult? hessaTimeRange;

  void changeHessaDate(DateTime hessaDate) {
    this.hessaDate = hessaDate;
    hessaDateController.text =
        DateFormat("dd MMMM yyyy", "ar_SA").format(hessaDate);
    update();
  }

  void changeLocation(String location) {
    locationController.text = location;
    update();
  }

  String? validateTeacherName(String? teacherName) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (teacherName == null || teacherName.isEmpty) {
      return LocaleKeys.please_enter_teacher_name.tr;
      // } else if (!regExp.hasMatch(fullName)) {
      // if (!fullName.contains(" ")) {
      //   return LocaleKeys.should_have_space.tr;
      // } else {
      //   return null;
      // }
    } else if (regExp.hasMatch(teacherName)) {
      return LocaleKeys.check_teacher_name.tr;
    } else {
      return null;
    }
  }

  void changeHessaTime(TimeRangeResult? rangeResult) {
    if (rangeResult == null) return;
    hessaTimeRange = rangeResult;
    DateTime now = DateTime.now();
    String formattedFromTime = DateFormat.jm('ar_SA').format(DateTime(now.year,
        now.month, now.day, rangeResult.start.hour, rangeResult.start.minute));
    String formattedToTime = DateFormat.jm('ar_SA').format(DateTime(now.year,
        now.month, now.day, rangeResult.end.hour, rangeResult.end.minute));
    hessaTimeController.text = "$formattedFromTime - $formattedToTime";
    update();
  }

  @override
  void onInit() async {
    hessaDateController = TextEditingController();
    hessaTimeController = TextEditingController();
    locationController = TextEditingController();
    teacherNameController = TextEditingController();
    notesController = TextEditingController();
    await initializeDateFormatting("ar_SA", null);
    super.onInit();
  }

  @override
  void dispose() {
    hessaDateController.dispose();
    hessaTimeController.dispose();
    locationController.dispose();
    teacherNameController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void changeSessionWay(int value) {
    sessionWay = value;
    log("Session Way: $sessionWay");
    update();
  }

  void changeTeacherGender(int value) {
    teacherGender = value;
    log("Teacher Gender $teacherGender");
    update();
  }

  void changeOrderType(int value) {
    orderType = value;
    log("Order Type $orderType");
    update();
  }

  @override
  void onClose() {}
}
