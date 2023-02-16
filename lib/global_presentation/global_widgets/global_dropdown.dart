import '../../app/constants/exports.dart';

class PrimaryDropDown extends StatefulWidget {
  const PrimaryDropDown({
    Key? key,
    required this.items,
    required this.hint,
    required this.value,
    this.disabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.enabledBorder,
    this.focusNode,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.fontColor,
    this.isDisabled = false,
    this.onChanged,
  }) : super(key: key);

  final List<String> items;
  final String hint;
  final bool isDisabled;
  final String value;
  final InputBorder? disabledBorder;
  final FocusNode? focusNode;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final double? width, height;
  final Color? fontColor;
  final Widget? prefixIcon, suffixIcon;
  final Function(String value)? onChanged;
  @override
  State<PrimaryDropDown> createState() => _PrimaryDropDownState();
}

class _PrimaryDropDownState extends State<PrimaryDropDown> {
  String? dropDownValue;

  @override
  void initState() {
    dropDownValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        focusColor: ColorManager.primary,
        hintText: widget.hint,
        border: InputBorder.none,
        disabledBorder: widget.disabledBorder,
        enabledBorder: widget.enabledBorder,
        focusedBorder: widget.focusedBorder,
        errorBorder: widget.errorBorder,
        hintStyle: TextStyle(color: ColorManager.primary),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      ),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: widget.prefixIcon,
              prefixIconConstraints: BoxConstraints(
                minWidth: 30.w,
                minHeight: 30.h,
              ),
              suffixIcon: widget.suffixIcon,
              suffixIconConstraints: BoxConstraints(
                minWidth: 30.w,
                minHeight: 30.h,
              ),
            ),
            isExpanded: true,
            style: TextStyle(color: ColorManager.primary),
            hint: PrimaryText(
              widget.hint,
              color: ColorManager.fontColor,
              fontSize: 20,
            ),
            value: dropDownValue,
            borderRadius: BorderRadius.circular(8),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: ColorManager.grey2,
            ),
            items: widget.items.map((String itemValue) {
              return DropdownMenuItem(
                value: itemValue,
                child: PrimaryText(
                  itemValue,
                  color: widget.fontColor ?? ColorManager.fontColor7,
                ),
              );
            }).toList(),
            focusNode: widget.focusNode,
            onChanged: widget.isDisabled
                ? null
                : (String? value) {
                    setState(
                      () {
                        if (widget.onChanged != null) {
                          widget.onChanged!(value!);
                        }
                        dropDownValue = value!;
                      },
                    );
                  }),
      ),
    );
  }
}
