
import 'package:account/core/common/button/common_button.dart';
import 'package:account/core/common/input/common_dropdown.dart';
import 'package:account/core/common/input/common_text_field.dart';
import 'package:account/core/common/title_row.dart';
import 'package:account/features/account/widgets/positon_department_widget.dart';
import 'package:account/utils/color_resources.dart';
import 'package:account/utils/dimensions.dart';
import 'package:account/utils/icons.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StaffInformationDetails extends StatefulWidget {
  const StaffInformationDetails({Key? key}) : super(key: key);

  @override
  _StaffInformationDetailsState createState() =>
      _StaffInformationDetailsState();
}

class _StaffInformationDetailsState extends State<StaffInformationDetails> {
  bool isExpanded = true;

  void toggleContainer() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SfDateRangePicker(
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              setState(() {
                _selectedDate = args.value;
                _dateController.text =
                    "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";
              });
              Navigator.pop(context); // Close the dialog after selection
            },
            selectionMode: DateRangePickerSelectionMode.single,
            initialSelectedDate: _selectedDate,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        if (!isExpanded)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: toggleContainer,
                child: Image.asset(IconsApp.buttonDistanceLeft),
              ),
            ],
          ),
        Expanded(
          child: AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 300),
            height: isExpanded ? MediaQuery.of(context).size.height : 0,
            width: isExpanded ? MediaQuery.of(context).size.width * 0.7 : 0,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 9, child: Container()),
                        const SizedBox(
                          width: 78,
                          child: CommonButton(
                            backgroundColor: ColorResources.buttonSave,
                            buttonIcon: IconsApp.add,
                            textName: "Thêm",
                          ),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        const SizedBox(
                          width: 68,
                          child: CommonButton(
                            backgroundColor: ColorResources.buttonSave,
                            buttonIcon: IconsApp.edit,
                            textName: "Sửa",
                          ),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        const SizedBox(
                          width: 68,
                          child: CommonButton(
                            backgroundColor: ColorResources.buttonSave,
                            buttonIcon: IconsApp.save,
                            textName: "Lưu",
                          ),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        const SizedBox(
                          width: 68,
                          child: CommonButton(
                            borderColor: ColorResources.blue,
                            backgroundColor: ColorResources.white,
                            isBorder: true,
                            buttonIcon: IconsApp.close,
                            textName: "Huỷ",
                            textColor: ColorResources.blue,
                          ),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        InkWell(
                          onTap: toggleContainer,
                          child: Image.asset(IconsApp.buttonDistance),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    const TitleRow(
                      nameTitle: "1. THÔNG TIN NHÂN VIÊN",
                      buttonSave: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CommonButton(
                            width: 70,
                            buttonIcon: IconsApp.save,
                            backgroundColor: ColorResources.buttonSave,
                            textName: "Lưu",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const LabelWithField(
                                label: "Nhân viên",
                                field: CommonTextField(
                                  width: double.infinity,
                                  hintText: "Mã nhân viên",
                                ),
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall),
                              LabelWithField(
                                label: "Ngày sinh",
                                field: CommonTextField(
                                  width: double.infinity,
                                  hintText: 'Chọn ngày sinh',
                                  isIcon: true,
                                  isShowSuffixIcon: true,
                                  suffixAssetUrl: IconsApp.calendar,
                                  isReadOnly: true,
                                  onTap: () => _showDatePicker(context),
                                ),
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall),
                              const LabelWithField(
                                label: "Số điện thoại",
                                field: CommonTextField(
                                  width: double.infinity,
                                  hintText: "Số điện thoại",
                                ),
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall),
                              const LabelWithField(
                                label: "Học hàm/Học vị",
                                field: CommonDropdownField(
                                  width: double.infinity,
                                  hintText: 'Học hàm/Học vị',
                                  items: ["Cử nhân", "Thạc sĩ", "Tiến sĩ"],
                                ),
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CommonTextField(
                                width: double.infinity,
                                hintText: "Họ và tên",
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall),
                              const LabelWithField(
                                label: "Giới tính",
                                field: CommonDropdownField(
                                  width: double.infinity,
                                  hintText: 'Chọn giới tính',
                                  items: ["Nam", "Nữ", "Khác"],
                                ),
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall),
                              const LabelWithField(
                                label: "Email",
                                field: CommonTextField(
                                  width: double.infinity,
                                  hintText: "Email",
                                ),
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall),
                              const LabelWithField(
                                label: "Mã người bệnh",
                                field: CommonTextField(
                                  width: double.infinity,
                                  hintText: "PID của bệnh nhân",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    const Row(
                      children: [
                        SizedBox(width: 80),
                        Text(
                          "Khoa/Phòng",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: ColorResources.subName,
                          ),
                        ),
                        SizedBox(width: 18),
                        Expanded(
                          child: CommonDropdownField(
                            hintText: 'Chọn khoa/ phòng',
                            items: ["Các khoa", "Khoa 1", "Khoa 2", "Khoa 3"],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    const Row(
                      children: [
                        Expanded(
                          child: LabelWithField(
                            label: "CCHN",
                            field: CommonTextField(
                              width: double.infinity,
                              hintText: "Số chứng chỉ hành nghề",
                            ),
                          ),
                        ),
                        Expanded(
                          child: LabelWithField(
                            label: "Mã đơn thuốc",
                            field: CommonTextField(
                              width: double.infinity,
                              hintText: "Mã đơn thuốc quốc gia",
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    const Row(
                      children: [
                        SizedBox(width: 125),
                        Text(
                          "Vai trò",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: ColorResources.subName,
                          ),
                        ),
                        SizedBox(width: 18),
                        Expanded(
                          child: CommonDropdownField(
                            hintText: 'Chọn vai trò',
                            items: ["Vai trò 1", "Vai trò 2", "Vai trò 3"],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    const PositonDepartmentWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LabelWithField extends StatelessWidget {
  final String label;
  final String? requiredText;
  final Widget field;

  const LabelWithField({
    Key? key,
    required this.label,
    required this.field,
    this.requiredText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: ColorResources.subName,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  requiredText ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: ColorResources.redBoder,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(flex: 6, child: field),
        ],
      ),
    );
  }
}
