import 'dart:developer';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_range/time_range.dart';
import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';

extension IsAtMaximumYears on DateTime {
  bool isAtMaximumYears(int years) {
    DateTime now = DateTime.now();
    DateTime boundaryDate = DateTime(now.year - years, now.month, now.day);
    DateTime thisDate = DateTime(year, month, day);
    return thisDate.compareTo(boundaryDate) >= 0;
  }
}

class OrderHessaController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int sessionWay = 0; // 0 face-to-face, 1 electronic, 2 both
  int teacherGender = 0; // 0 male, 1 female, 2 both
  int orderType = 0; // 0 one hessa, 1 school package
  late TextEditingController hessaDateController,
      hessaTimeController,
      locationController,
      teacherNameController,
      notesController;
  DateTime hessaDate = DateTime.now();
  Color? teacherNameErrorIconColor,
      hessaDateErrorIconColor,
      hessaTimeErrorIconColor;
  TimeRangeResult? hessaTimeRange;
  late DateRangePickerController hessaDateRangeController;
  FocusNode hessaDateFocusNode = FocusNode(), hessaTimeFocusNode = FocusNode();

  void changeHessaDate(DateRangePickerSelectionChangedArgs hessaDate) {
    log(hessaDate.value.toString());
    this.hessaDate = hessaDate.value;
    hessaDateController.text =
        DateFormat("dd MMMM yyyy", "ar_SA").format(hessaDate.value);
    update();
  }

  void changeLocation(String location) {
    locationController.text = location;
    update();
  }

  String? validateHessaDate(String? hessaDate) {
    if (hessaDate != null && hessaDate.isNotEmpty) {
      DateTime tempDateTime =
          DateFormat("dd MMMM yyyy", "ar_SA").parse(hessaDate);
      if (hessaDate.isEmpty) {
        hessaDateErrorIconColor = Colors.red;
        return LocaleKeys.please_enter_hessa_date.tr;
      } else if (!tempDateTime.isAtMaximumYears(1)) {
        hessaDateErrorIconColor = Colors.red;
        return LocaleKeys.check_hessa_date.tr;
      } else {
        hessaDateErrorIconColor = null;
      }
    } else {
      hessaDateErrorIconColor = Colors.red;
      return LocaleKeys.please_enter_hessa_date.tr;
    }
    update();
    return null;
  }

  String? validateHessaTime(String? hessaTime) {
    if (hessaTime != null && hessaTime.isNotEmpty) {
      hessaTimeErrorIconColor = null;
    } else {
      hessaTimeErrorIconColor = Colors.red;
      return LocaleKeys.please_enter_hessa_date.tr;
    }
    update();
    return null;
  }

  String? validateTeacherName(String? teacherName) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (teacherName == null || teacherName.isEmpty) {
      teacherNameErrorIconColor = Colors.red;
      return LocaleKeys.please_enter_teacher_name.tr;
      // } else if (!regExp.hasMatch(fullName)) {
      // if (!fullName.contains(" ")) {
      //   return LocaleKeys.should_have_space.tr;
      // } else {
      //   return null;
      // }
    } else if (regExp.hasMatch(teacherName)) {
      teacherNameErrorIconColor = Colors.red;
      return LocaleKeys.check_teacher_name.tr;
    } else {
      teacherNameErrorIconColor = null;
    }
    update();
    return null;
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
    hessaDateRangeController = DateRangePickerController();
    hessaTimeController = TextEditingController();
    locationController = TextEditingController();
    teacherNameController = TextEditingController();
    notesController = TextEditingController();
    await initializeDateFormatting("ar_SA", null);
    hessaDateFocusNode.addListener(() => update());
    hessaTimeFocusNode.addListener(() => update());
    super.onInit();
  }

  @override
  void dispose() {
    hessaDateController.dispose();
    hessaDateRangeController.dispose();
    hessaTimeController.dispose();
    locationController.dispose();
    teacherNameController.dispose();
    notesController.dispose();
    hessaDateFocusNode.dispose();
    hessaTimeFocusNode.dispose();
    super.dispose();
  }

  void changeSessionWay(int value) {
    sessionWay = value;
    update();
  }

  void changeTeacherGender(int value) {
    teacherGender = value;
    update();
  }

  void changeOrderType(int value) {
    orderType = value;
    update();
  }

  @override
  void onClose() {}
}
