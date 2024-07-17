import 'package:account/core/common/button/common_button.dart';
import 'package:account/core/common/input/common_text_field.dart';
import 'package:account/core/common/input/drop_down_item_base.dart';
import 'package:account/core/common/table/display_table.dart';
import 'package:account/core/common/table/filter_table/filter_drop_down_table.dart';
import 'package:account/core/common/table/filter_table/filter_text_table.dart';
import 'package:account/utils/color_resources.dart';
import 'package:account/utils/icons.dart';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/e01S01001_bloc.dart';
import 'bloc/e01S01001_state.dart';

class E01S01001 extends StatefulWidget {
  const E01S01001({super.key});

  @override
  State<E01S01001> createState() => _E01S01001State();
}

class _E01S01001State extends State<E01S01001> {
  late E01S01001Bloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = E01S01001Bloc()..onStart();
  }

  @override
  Widget build(BuildContext context) {
    final dataHeader = [
      'STT',
      'Mã nhân viên',
      'Tên đăng nhập',
      'Tên người dùng',
      'Nhóm quyền',
      'Khoa/Phòng',
      'Sử dụng',
    ];

    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<E01S01001Bloc, E01S01001State>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 36),
                          const Text(
                            'Khoa phòng',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 12),
                          DropdownItemBase(
                            width: 180,
                            hintText: "Chọn khoa phòng",
                            items: state.departmentList,
                            value: state.departmentHeaderFilter,
                            onChanged: (value) {
                              // bloc.onDepartmentHeaderFilterChange(value);
                            },
                          ),
                          const SizedBox(width: 40),
                          const Text(
                            'Tên người dùng',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 12),
                          CommonTextField(
                            width: 200,
                            height: 36,
                            hintText: 'Nhập tên người dùng',
                            onChanged: (text) {
                              bloc.onAccountNameHeaderFilterChange(text);
                            },
                          ),
                          const SizedBox(width: 40),
                          const Text(
                            'Trạng thái',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 12),
                          DropdownItemBase(
                            key: ObjectKey(state.statusHeaderFilter),
                            width: 160,
                            hintText: "Chọn trạng thái",
                            items: state.statusList,
                            value: state.statusHeaderFilter,
                            onChanged: (value) {
                              // bloc.onStatusHeaderFilterChange(value);
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              bloc.onCheckSelect();
                            },
                            child: state.isCheckSelect
                                ? const Icon(
                                    Icons.check_box,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.check_box_outline_blank,
                                    color: Color(0xFFC6C6C6),
                                  ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Chọn',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 44),
                          SizedBox(
                            width: 68,
                            child: CommonButton(
                              onTap: () {
                                bloc.onFetch();
                              },
                              backgroundColor: ColorResources.buttonSave,
                              buttonIcon: IconsApp.search,
                              textName: "Lọc",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommonButton(
                      backgroundColor: ColorResources.buttonSave,
                      buttonIcon: IconsApp.view,
                      textName: "Xem",
                      width: 68,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    CommonButton(
                      backgroundColor: ColorResources.buttonSave,
                      buttonIcon: IconsApp.add,
                      textName: "Thêm",
                      width: 76,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    CommonButton(
                      backgroundColor: ColorResources.buttonSave,
                      buttonIcon: IconsApp.edit,
                      textName: "Sửa",
                      width: 68,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    CommonButton(
                      borderColor: ColorResources.redBoder,
                      isBorder: true,
                      buttonIcon: IconsApp.delete,
                      textName: "Xóa",
                      textColor: ColorResources.redBoder,
                      width: 68,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    CommonButton(
                      backgroundColor: ColorResources.buttonSave,
                      buttonIcon: IconsApp.view,
                      textName: "Xuất excel",
                      width: 108,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: DisplayTable(
                    key: ObjectKey(state.dataList),
                    dataHeader: dataHeader,
                    rowsData: [
                      DataRow(
                        cells: [
                          DataCell(
                            state.isCheckSelect
                                ? InkWell(
                                    onTap: () {
                                      bloc.onCheckAll(!state.isCheckAll);
                                    },
                                    child: Center(
                                      child: state.isCheckAll
                                          ? const Icon(
                                              Icons.check_box,
                                              color: Colors.grey,
                                            )
                                          : const Icon(
                                              Icons.check_box_outline_blank,
                                              color: Color(0xFFC6C6C6),
                                            ),
                                    ),
                                  )
                                : Container(),
                          ),
                          DataCell(
                            FilterTextTable(
                              initText: state.patientCodeFilter,
                              onChangeText: (text) {
                                bloc.onFetch(
                                  patientCodeFilterChange: text,
                                );
                              },
                            ),
                          ),
                          DataCell(
                            FilterTextTable(
                              initText: state.accountCodeFilter,
                              onChangeText: (text) {
                                bloc.onFetch(
                                  accountCodeFilterChange: text,
                                );
                              },
                            ),
                          ),
                          DataCell(
                            FilterTextTable(
                              initText: state.accountNameFilter,
                              onChangeText: (text) {
                                bloc.onFetch(
                                  accountNameFilterChange: text,
                                );
                              },
                            ),
                          ),
                          DataCell(
                            FilterTextTable(
                              initText: state.roleGroupFilter,
                              onChangeText: (text) {
                                bloc.onFetch(
                                  roleGroupFilterChange: text,
                                );
                              },
                            ),
                          ),
                          DataCell(
                            FilterDropdownTable(
                              items: state.departmentList,
                              value: state.departmentFilter,
                              onChanged: (value) {
                                // bloc.onFetch(departmentFilterChange: value);
                              },
                            ),
                          ),
                          DataCell(FilterDropdownTable(
                            items: state.statusList,
                            value: state.statusFilter,
                            onChanged: (value) {
                              // bloc.onFetch(statusFilterChange: value);
                            },
                          )),
                        ],
                      ),
                      ...(state.dataList ?? []).mapIndexed(
                        (index, e) => DataRow(
                          color: WidgetStateProperty.resolveWith((_) {
                            return index % 2 == 0
                                ? const Color(0xFFF0FAFE)
                                : null;
                          }),
                          cells: [
                            if (state.isCheckSelect) ...[
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
                            ] else ...[
                              DataCell(Center(
                                  child: Text((index +
                                          1 +
                                          (state.currentPage - 1) * state.limit)
                                      .toString())))
                            ],
                            DataCell(Center(child: Text(e.patientCode ?? ''))),
                            DataCell(Center(child: Text(e.accountCode ?? ''))),
                            DataCell(Text(e.accountName ?? '')),
                            DataCell(Text(e.roleGroup ?? '')),
                            DataCell(Center(child: Text(e.department ?? ''))),
                            DataCell(
                              Center(
                                child: (e.status == 1)
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
