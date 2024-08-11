
import 'package:account/core/constants/app_color.dart';
import 'package:account/core/constants/app_style.dart';
import 'package:account/core/utils/color_resources.dart';
import 'package:account/core/utils/icons.dart';
import 'package:account/core/widgets/button/common_elevated_button.dart';
import 'package:account/core/widgets/table/number_paginator.dart';
import 'package:account/features/mE0001R00AA5/bloc/mE0001R00AA5_cubit.dart';
import 'package:account/features/mE0001R00AA5/bloc/mE0001R00AA5_state.dart';
import 'package:account/features/mE0001R00AA5/model/pdf_file_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ME0001R00AA5DataTable extends StatefulWidget {
  const ME0001R00AA5DataTable({super.key});

  @override
  State<ME0001R00AA5DataTable> createState() => _ME0001R00AA5DataTableState();
}

class _ME0001R00AA5DataTableState extends State<ME0001R00AA5DataTable> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.c_F8FAFC,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: BlocConsumer<ME0001R00AA5Cubit, ME0001R00AA5State>(
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  _buildLeftHeader(
                    onTapBack: () {},
                  ),
                  _buildTable(context,
                      dataRows: state.pdfFileModels ?? [], state: state),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      NumberPaginator(
                        limit: 10,
                        currentPage: 1,
                        numberPages: 10,
                        onLimitChange: (p0) {},
                        onPageChange: (p0) {},
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLeftHeader({
    required VoidCallback onTapBack,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTapBack,
            child: Image.asset(IconsApp.buttonDistanceLeft),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(BuildContext context,
      {required List<PdfFileModel> dataRows, required ME0001R00AA5State state}) {
    return Column(
      children: [
        Table(
          border: const TableBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(6.0),
            ),
          ),
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(3.0),
            2: FlexColumnWidth(3.5),
            3: FlexColumnWidth(3.5),
            4: FlexColumnWidth(2.0),
          },
          children: [
            _buildTableHeader(),
            for (int i = 0; i < dataRows.length; i++)
              _buildTableRow(
                dataRows[i],
                onTapRow: () {
                  context.read<ME0001R00AA5Cubit>().reviewDocument(dataRows[i]);
                },
                index: i,
                state: state,
              ),
          ],
        ),
      ],
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: const BoxDecoration(
        color: AppColor.c_B8E5FA,
      ),
      children: [
        _buildTableCell(text: 'STT', isHeader: true),
        _buildTableCell(text: 'Thời gian', isHeader: true),
        _buildTableCell(text: 'Loại hồ sơ', isHeader: true),
        _buildTableCell(text: 'Tên tập tin', isHeader: true),
        _buildTableCell(text: '', isHeader: true),
      ],
    );
  }

  TableRow _buildTableRow(PdfFileModel pdfFileModel,
      {required int index,
      required ME0001R00AA5State state,
      void Function()? onTapRow}) {
    final reversedIndex = (state.pdfFileModels?.length ?? 0) - index;
    return TableRow(
      decoration: BoxDecoration(
        color: index % 2 == 1 ? AppColor.c_F0FAFE : AppColor.c_F8FAFC,
      ),
      children: [
        _buildTableCell(text: reversedIndex.toString()),
        _buildTableCell(
            text: DateTimeFormat.formatDateDDMMYYHHMM(
                pdfFileModel.createdAt ?? DateTime.now()),
            onTap: onTapRow),
        _buildTableCell(text: pdfFileModel.profileType ?? '', onTap: onTapRow),
        _buildTableCell(text: pdfFileModel.name ?? '', onTap: onTapRow),
        _buildDeleteButton(
          onTap: () {
            context.read<ME0001R00AA5Cubit>().removePdfFile(pdfFileModel.id);
          },
        ),
      ],
    );
  }

  Widget _buildTableCell({
    required String text,
    bool? isHeader,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isHeader == true ? 48.0 : 40,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          border: Border.symmetric(
            vertical: BorderSide(
              color: AppColor.c_FFFFFF,
              width: 1,
            ),
          ),
        ),
        child: Text(
          text,
          style: isHeader == true
              ? const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColor.c_323F4B,
                )
              : AppStyle.tableRow,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildDeleteButton({void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: CommonElevatedButton(
              width: 45,
              buttonIcon: IconsApp.closeCircle,
              backgroundColor: ColorResources.buttonSave,
            ),
          )),
    );
  }
}

