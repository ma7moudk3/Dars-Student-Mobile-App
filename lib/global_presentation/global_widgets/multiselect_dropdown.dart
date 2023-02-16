// Multi Select widget
// This widget is reusable

import '../../app/constants/exports.dart';

class MultiSelect extends StatefulWidget {
  const MultiSelect({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.title,
    required this.submitButtonText,
    required this.cancelButtonText,
  }) : super(key: key);

  final List<String> selectedItems;
  final List<String> items;
  final String title, submitButtonText, cancelButtonText;

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        widget.selectedItems.add(itemValue);
      } else {
        widget.selectedItems.remove(itemValue);
      }
    });
  }

  @override
  void initState() {
    // _selectedItems = widget.selectedItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        contentTextStyle: const TextStyle(
          fontFamily: FontConstants.fontFamily,
        ),
        title: PrimaryText(
          widget.title,
          fontWeight: FontWeightManager.light,
          fontSize: 16,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: widget.items
                .map((String item) => CheckboxListTile(
                      side: BorderSide(
                        color: ColorManager.borderColor2,
                        width: 2,
                      ),
                      value: widget.selectedItems.contains(item),
                      title: PrimaryText(
                        item,
                        fontWeight: FontWeightManager.softLight,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: ColorManager.primary,
                      selectedTileColor: ColorManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      dense: true,
                      contentPadding: const EdgeInsets.all(0),
                      checkboxShape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: ColorManager.primary,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onChanged: (bool? isChecked) =>
                          _itemChange(item, isChecked!),
                    ))
                .toList(),
          ),
        ),
        actions: [
          // GlobalButton(
          //   width: 80.w,
          //   height: 40.h,
          //   onTap: () => Get.back(),
          //   borderRadius: BorderRadius.circular(15.h),
          //   title: widget.cancelButtonText,
          // ),
          PrimaryButton(
            width: 200.w,
            height: 50.h,
            onPressed: () => Get.back(result: widget.selectedItems),
            title: widget.submitButtonText,
          ),
        ],
      ),
    );
  }
}
