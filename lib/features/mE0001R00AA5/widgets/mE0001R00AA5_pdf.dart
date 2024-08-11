import 'dart:io';


import 'package:account/core/constants/app_color.dart';
import 'package:account/core/models/item_base_model.dart';
import 'package:account/core/utils/color_resources.dart';
import 'package:account/core/utils/icons.dart';
import 'package:account/core/utils/spaces.dart';
import 'package:account/core/widgets/button/common_button.dart';
import 'package:account/core/widgets/check_box/common_checkBox.dart';
import 'package:account/core/widgets/pdf/bloc/pdf_cubit.dart';
import 'package:account/core/widgets/pdf/pdf_viewer_widget.dart';
import 'package:account/features/mE0001R00AA5/bloc/mE0001R00AA5_cubit.dart';
import 'package:account/features/mE0001R00AA5/bloc/mE0001R00AA5_state.dart';
import 'package:account/features/mE0001R00AA5/widgets/drop_down.dart';
import 'package:account/features/mE0001R00AA5/widgets/text_field_input.dart';
import 'package:account/mE0001R00AA5/validate_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ME0001R00AA5Pdf extends StatefulWidget {
  const ME0001R00AA5Pdf({super.key});

  @override
  State<ME0001R00AA5Pdf> createState() => _ME0001R00AA5PdfState();
}

class _ME0001R00AA5PdfState extends State<ME0001R00AA5Pdf> {
  final validateUsecase = ValidateUsecase();

  @override
  void initState() {
    super.initState();
    context.read<ME0001R00AA5Cubit>().init();
    context.read<PdfViewerCubit>().init();
  }

  @override
  void dispose() {
    context.read<ME0001R00AA5Cubit>().pdfViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ME0001R00AA5Cubit, ME0001R00AA5State>(
      builder: (context, state) {
        return Expanded(
          flex: 9,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 1.75,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColor.c_F8FAFC,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  spaceH10,
                  _buildButtonSave(),
                  spaceH10,
                  _buildPdfPicker(context, state),
                  spaceH30,
                  _buildProfileNameAndTypeDropdown(context, state),
                  spaceH20,
                  _buildDateAndSignatoryRow(context, state),
                  spaceH20,
                  _buildScannedDocumentsAndNotes(context, state),
                  spaceH24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildEditButon(context, state),
                      spaceW10,
                      _buildButtonUpload(context, state),
                    ],
                  ),
                  spaceH10,
                  Expanded(
                    child: PdfViewerWidget(
                      fileName: state.filePickerResult?.name ?? '',
                      maxPage: state.maxPage ?? 0,
                      file: state.filePickerResult != null && !kIsWeb
                          ? File(state.filePickerResult!.path!)
                          : null,
                      fileBytes: kIsWeb ? state.filePickerResult?.bytes : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPdfPicker(BuildContext context, ME0001R00AA5State state) {
    return GestureDetector(
      onTap: () {
        context.read<ME0001R00AA5Cubit>().pdfPicker();
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: AppColor.c_F8FAFC,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey, width: 2.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.network("assets/icons/pdf.svg"),
              Text(
                state.filePickerResult?.name ??
                    "Kéo thả hoặc bấm vào đây để tải tập tin lên",
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileNameAndTypeDropdown(
      BuildContext context, ME0001R00AA5State state) {
    return Row(
      children: [
        TextFieldPdf(
          controller: context.read<ME0001R00AA5Cubit>().fileNameController,
          title: "Tên file",
          textAlignEndTitle: true,
          isEnabled: true,
        ),
        const SizedBox(width: 15),
        SizedBox(
          width: 320,
          child: DropdownPdf(
            value: state.profileType,
            onChanged: (value) {
              context.read<ME0001R00AA5Cubit>().selectProfileType(value);
            },
            items: [
              ItemBaseModel(id: 0, name: 'Nhân Sự'),
              ItemBaseModel(id: 1, name: 'Kế toán'),
              ItemBaseModel(id: 2, name: 'CNTT'),
              ItemBaseModel(id: 3, name: 'Marketing'),
            ],
            title: 'Loại hồ sơ',
          ),
        ),
      ],
    );
  }

  Widget _buildDateAndSignatoryRow(
      BuildContext context, ME0001R00AA5State state) {
    return Row(
      children: [
        const SizedBox(width: 18),
        SizedBox(
          width: 302,
          child: GestureDetector(
            onTap: () async {
              final time = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(3099),
                currentDate: DateTime.now(),
                useRootNavigator: false,
              );
              context
                  .read<ME0001R00AA5Cubit>()
                  .onSelectDateTime(time ?? DateTime.now());
            },
            child: TextFieldPdf(
              title: "Ngày",
              controller: context.read<ME0001R00AA5Cubit>().dateController,
              textAlignEndTitle: true,
              isEnabled: false,
              suffixAssetUrl: IconsApp.calendar,
              isShowSuffixIcon: true,
              onChanged: (p0) {},
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: DropdownPdf(
            value: state.signatory,
            onChanged: (value) {
              context.read<ME0001R00AA5Cubit>().selectSignatory(value);
            },
            items: [
              ItemBaseModel(id: 1, name: 'Nguyễn Văn A'),
              ItemBaseModel(id: 2, name: 'Lê B'),
              ItemBaseModel(id: 3, name: 'Trần A'),
            ],
            title: 'Người ký ',
          ),
        ),
      ],
    );
  }

  Widget _buildScannedDocumentsAndNotes(
      BuildContext context, ME0001R00AA5State state) {
    return Row(
      children: [
        CommonCheckBox(
          title: 'Chứng từ scan',
          value: state.scannedDocument!,
          onChanged: (value) {
            context.read<ME0001R00AA5Cubit>().scannedDocumentOnCheck(value);
          },
        ),
        spaceW40,
        TextFieldPdf(
          controller: context.read<ME0001R00AA5Cubit>().noteController,
          title: "Ghi chú",
          textAlignEndTitle: true,
          isEnabled: true,
        ),
      ],
    );
  }

  Widget _buildButtonSave() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 128,
          child: CommonButton(
            onTap: () {
              context.read<ME0001R00AA5Cubit>().saveAndSubmitAllFile();
            },
            backgroundColor: ColorResources.buttonSave,
            textName: "Lưu",
          ),
        ),
      ],
    );
  }

  Widget _buildButtonUpload(BuildContext context, ME0001R00AA5State state) {
    return SizedBox(
      width: 128,
      child: CommonButton(
        onTap: () {
          context.read<ME0001R00AA5Cubit>().onSubmitPdfFile();
        },
        backgroundColor: ColorResources.buttonSave,
        textName: "Tải lên",
      ),
    );
  }

  Widget _buildEditButon(BuildContext context, ME0001R00AA5State state) {
    return SizedBox(
      width: 128,
      child: CommonButton(
        onTap: () {
          context.read<ME0001R00AA5Cubit>().onSubmitPdfFile();
        },
        backgroundColor: ColorResources.buttonSave,
        textName: "Chỉnh sửa",
      ),
    );
  }
}
