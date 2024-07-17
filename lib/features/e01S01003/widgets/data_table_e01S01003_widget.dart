import 'package:account/core/common/button/common_elevated_button.dart';
import 'package:account/core/common/table/display_table_small.dart';
import 'package:account/core/common/table/filter_table/filter_text_table.dart';
import 'package:account/features/e01/e01S01001/bloc/e01S01001_bloc.dart';
import 'package:account/features/e01/e01S01001/bloc/e01S01001_state.dart';
import 'package:account/utils/color_resources.dart';
import 'package:account/utils/dimensions.dart';
import 'package:account/utils/icons.dart';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataTableE01S01003Widget extends StatefulWidget {
  const DataTableE01S01003Widget({super.key});

  @override
  State<DataTableE01S01003Widget> createState() =>
      _DataTableE01S01003WidgetState();
}

class _DataTableE01S01003WidgetState extends State<DataTableE01S01003Widget> {
  late E01S01001Bloc bloc;
  bool isExpanded = true;

  @override
  void initState() {
    super.initState();
    bloc = E01S01001Bloc()
      ..onFetch(
        limitChange: 10,
        currentPageChange: 1,
      );
  }

  void toggleContainer() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataHeader = [
      'STT',
      'Mã nhóm quyền',
      'Tên nhóm quyền',
      'Sử dụng',
    ];

    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<E01S01001Bloc, E01S01001State>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 12),
              if (!isExpanded)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: toggleContainer,
                      child: Image.asset(IconsApp.buttonDistance),
                    ),
                  ],
                ),
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: Colors.white,
                  curve: Curves.fastOutSlowIn,
                  height: isExpanded ? MediaQuery.of(context).size.height : 0,
                  width:
                      isExpanded ? MediaQuery.of(context).size.width * 0.3 : 0,
                  child: isExpanded
                      ? Column(
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: toggleContainer,
                                  child:
                                      Image.asset(IconsApp.buttonDistance),
                                ),
                                SizedBox(
                                  width: 68,
                                  child: CommonElevatedButton(
                                    buttonIcon: IconsApp.xls,
                                    backgroundColor: ColorResources.buttonSave,
                                  ),
                                ),
                                SizedBox(
                                    width: Dimensions.paddingSizeExtraSmall),
                                SizedBox(
                                  width: 68,
                                  child: CommonElevatedButton(
                                    borderColor: ColorResources.redBoder,
                                    backgroundColor: ColorResources.white,
                                    radius: 12,
                                    isBorder: true,
                                    buttonIcon: IconsApp.delete,
                                    textColor: ColorResources.redBoder,
                                  ),
                                ),
                                SizedBox(
                                    width: Dimensions.paddingSizeExtraSmall),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_box_outline_blank,
                                      color: Color(0xFFC6C6C6),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Chọn',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: DisplayTableSmall(
                                key: ObjectKey(state.dataList),
                                dataHeader: dataHeader,
                                rowsData: [
                                  DataRow(
                                    cells: [
                                      DataCell(
                                        FilterTextTable(
                                          onChangeText: (text) {
                                            //
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        FilterTextTable(
                                          onChangeText: (text) {
                                            bloc.onFetch(
                                              limitChange: state.limit,
                                              currentPageChange:
                                                  state.currentPage,
                                            );
                                          },
                                        ),
                                      ),
                                      DataCell(_filterDropdown(
                                        list: ['Tất cả', '1', '2'],
                                        dropdownValue: 'Tất cả',
                                      )),
                                      DataCell(
                                        InkWell(
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
                                                    Icons
                                                        .check_box_outline_blank,
                                                    color: Color(0xFFC6C6C6),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ...(state.dataList ?? []).mapIndexed(
                                    (index, e) => DataRow(
                                      color:
                                          WidgetStateProperty.resolveWith((_) {
                                        return index % 2 == 0
                                            ? const Color.fromARGB(
                                                255, 139, 241, 163)
                                            : null;
                                      }),
                                      cells: [
                                        DataCell(
                                          InkWell(
                                            onTap: () {
                                            
                                            },
                                            child: Center(
                                              child: Text(
                                                (index + 1).toString(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(Center(
                                          child: Text(
                                            '',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )),
                                        DataCell(Center(
                                            child: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                                        const DataCell(
                                          Center(
                                            child: Icon(
                                              Icons.check_box,
                                              color: Colors.grey,
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
                        )
                      : Container(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _filterDropdown({
    required List<String> list,
    required dropdownValue,
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
          //
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
}
