import 'package:account/core/colors/colors.dart';
import 'package:account/core/common/button/common_button.dart';
import 'package:account/core/common/button/common_elevated_button.dart';
import 'package:account/core/common/input/common_dropdown.dart';
import 'package:account/core/common/input/common_text_field.dart';
import 'package:account/core/common/table/display_table.dart';
import 'package:account/core/common/table/display_table_medium.dart';
import 'package:account/core/common/text/label_with_field.dart';
import 'package:account/core/common/title_row.dart';
import 'package:account/features/e01/e01S01001/bloc/e01S01001_bloc.dart';
import 'package:account/features/e01/e01S01001/bloc/e01S01001_state.dart';
import 'package:account/utils/color_resources.dart';
import 'package:account/utils/dimensions.dart';
import 'package:account/utils/icons.dart';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class InformationAccountWidget extends StatefulWidget {
  const InformationAccountWidget({super.key});

  @override
  State<InformationAccountWidget> createState() =>
      _InformationAccountWidgetState();
}

class _InformationAccountWidgetState extends State<InformationAccountWidget> {
  late E01S01001Bloc bloc;

  DateTime _selectedDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();

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
  void initState() {
    super.initState();
    bloc = E01S01001Bloc()
      ..onFetch(
        limitChange: 10,
        currentPageChange: 1,
      );
  }

  void showDatePicker(
      DateTime selectedDate, void Function(DateTime) onDateChanged) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 300,
            child: SfDateRangePicker(
              initialSelectedDate: selectedDate,
              onSelectionChanged: (dateRangePickerSelection) {
                if (dateRangePickerSelection.value is DateTime) {
                  DateTime selectedDate = dateRangePickerSelection.value!;
                  onDateChanged(selectedDate);
                  Navigator.pop(context); // Close the dialog
                }
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataHeader = [
      '',
      'Quyền hạn',
      'Hiệu lực',
      'Hết hiệu lực',
      '',
    ];
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<E01S01001Bloc, E01S01001State>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              const TitleRow(
                nameTitle: "3. THÔNG TIN TÀI KHOẢN",
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
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelWithField(
                          label: "Tên đăng nhập",
                          requiredText: "*",
                          field: CommonTextField(
                            width: double.infinity,
                            hintText: "Mã tài khoản",
                          ),
                        ),
                        SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        LabelWithField(
                          label: "Mật khẩu",
                          requiredText: "*",
                          field: CommonTextField(
                            width: double.infinity,
                            hintText: "*********",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelWithField(
                          label: "Tên người dùng",
                          requiredText: "*",
                          field: CommonTextField(
                            width: double.infinity,
                            hintText: "Tên người dùng",
                          ),
                        ),
                        SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        LabelWithField(
                          label: "Nhập mật khẩu",
                          requiredText: "*",
                          field: CommonTextField(
                            width: double.infinity,
                            hintText: "*********",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const TitleRow(
                nameTitle: "4. Phân quyền",
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
              const SizedBox(
                height: Dimensions.paddingSizeSmall,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Row(
                    children: [
                      Text(
                        'Quyền hạn',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CommonDropdownField(
                        isPadding: false,
                        width: 190,
                        hintText: "Chọn quyền hạn",
                        items: [
                          'Tất cả',
                          '1',
                          '2',
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Hiệu lực',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 140,
                        child: CommonTextField(
                          width: double.infinity,
                          hintText: 'dd/mm/yy',
                          isIcon: true,
                          isShowSuffixIcon: true,
                          suffixAssetUrl: IconsApp.calendar,
                          isReadOnly: true,
                          // items: ['abc', 'xyz'],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 12),
                      SizedBox(
                        width: 140,
                        child: CommonTextField(
                          width: double.infinity,
                          hintText: 'dd/mm/yy',
                          isIcon: true,
                          isShowSuffixIcon: true,
                          suffixAssetUrl: IconsApp.calendar,
                          isReadOnly: true,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 48,
                        child: CommonElevatedButton(
                          buttonIcon: IconsApp.arrow_down,
                          backgroundColor: AppColors.foundation,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 48,
                        child: CommonElevatedButton(
                          borderColor: ColorResources.redBoder,
                          radius: 10.0,
                          isBorder: true,

                          buttonIcon: IconsApp.delete,
                          // textName: "Xóa",
                          textColor: ColorResources.redBoder,
                          hoverColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              DisplayTable(
                key: ObjectKey(state.dataList ?? []),
                dataHeader: dataHeader,
                rowsData: [
                  ...(state.dataList ?? []).mapIndexed(
                    (index, e) => DataRow(
                      color: WidgetStateProperty.resolveWith((_) {
                        return index % 2 == 0 ? const Color(0xFFF0FAFE) : null;
                      }),
                      cells: [
                        DataCell(
                          InkWell(
                            onTap: () {
                              bloc.onCheck(
                                patientCode: e.patientCode ?? '',
                                valueCheck: !(e.isCheck ?? false),
                              );
                            },
                            child: Center(
                              child: (e.isCheck ?? false)
                                  ? const Icon(
                                      Icons.check_box,
                                      color: Colors.grey,
                                    )
                                  : const Icon(
                                      Icons.check_box_outline_blank,
                                      color: Color(0xFFC6C6C6),
                                    ),
                            ),
                          ),
                        ),
                        DataCell(_filterDropdown(
                          list: ['Xem thông tin mã hoá', '1', '2'],
                          dropdownValue: 'Xem thông tin mã hoá',
                        )),
                        DataCell(_filterDateTime(
                          selectedDate: DateTime.now(),
                          onDateChanged: (value) {},
                        )),
                        DataCell(_filterDateTime(
                          selectedDate: DateTime.now(),
                          onDateChanged: (value) {},
                        )),
                        const DataCell(
                          Center(
                            child: SizedBox(
                              width: 40,
                              child: CommonElevatedButton(
                                buttonIcon: IconsApp.closeCircle,
                                backgroundColor: ColorResources.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                limit: state.limit,
                currentPage: state.currentPage,
                numberPages: state.numberPages ?? 1,
                onLimitChange: (limit) {
                  bloc.onFetch(
                    limitChange: limit,
                    currentPageChange: state.currentPage,
                  );
                },
                onPageChange: (page) {
                  bloc.onFetch(
                    limitChange: state.limit,
                    currentPageChange: page,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _filterDropdown({
    required List<String> list,
    required String dropdownValue,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropdownValue,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Colors.black,
        ),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        dropdownColor: Colors.white,
        focusColor: Colors.white,
        onChanged: (String? value) {
          // Implement onChange logic
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              textAlign: TextAlign.right,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _filterDateTime({
    required DateTime selectedDate,
    required void Function(DateTime) onDateChanged,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          showDatePicker(selectedDate, onDateChanged);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.calendar_today,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
