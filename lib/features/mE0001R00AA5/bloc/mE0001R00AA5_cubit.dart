import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ME0001R00AA5Cubit extends Cubit<ME0001R00AA5State> {
  final PdfPickerUsecase pdfPickerUsecase;
  final PdfViewerController pdfViewerController = PdfViewerController();
  final TextEditingController curentPageController = TextEditingController();
  final TextEditingController percentController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController fileNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  ME0001R00AA5Cubit({required this.pdfPickerUsecase})
      : super(ME0001R00AA5State());
}

extension HandleCubit on ME0001R00AA5Cubit {
  void init() {
    percentController.text = '100%';
  }

  Future<void> pdfPicker() async {
    emit(state.copyWith(isLoading: true));

    try {
      final filePickerResult = await pdfPickerUsecase.call();
      if (filePickerResult == null) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      final document = await OpenPdf.openPdfDocument(filePickerResult);
      final maxPage = document.pagesCount;

      curentPageController.text = '1';
      fileNameController.text = filePickerResult.name;

      dateController.text = DateTimeFormat.formatDateDDMMYY(DateTime.now());

      emit(state.copyWith(
        filePickerResult: filePickerResult,
        maxPage: maxPage,
        isLoading: false,
        createdAt: DateTime.now(),
      ));
    } catch (error) {
      emit(state.copyWith(isLoading: false));
      print('Error picking PDF file: $error');
    }
  }

  void rotate() {}

  void zoomIn() {
    final newZoomLevel = (pdfViewerController.zoomLevel + 0.2).clamp(1.0, 3.0);
    pdfViewerController.zoomLevel = newZoomLevel;
    final zoomPercentage = (newZoomLevel / 3.0) * 300;
    percentController.text = '${zoomPercentage.toStringAsFixed(0)}%';
    emit(state.copyWith(currentZoom: newZoomLevel));
  }

  void zoomOut() {
    final newZoomLevel = (pdfViewerController.zoomLevel - 0.2).clamp(1.0, 3.0);
    pdfViewerController.zoomLevel = newZoomLevel;
    final zoomPercentage = (newZoomLevel / 3.0) * 300;
    percentController.text = '${zoomPercentage.toStringAsFixed(0)}%';

    emit(state.copyWith(currentZoom: newZoomLevel));
  }

  void download() {}

  void printDocument() {}

  void updateCurrentPage(int pageNumber) async {
    pdfViewerController.jumpToPage(pageNumber);
  }

  void selectProfileType(String? profileType) {
    emit(state.copyWith(profileType: profileType));
  }

  void selectSignatory(String? signatory) {
    emit(state.copyWith(signatory: signatory));
  }

  void onSubmitPdfFile() {
    final filePickerResult = state.filePickerResult;
    if (filePickerResult == null) return;

    final PdfFileModel pdfFileModel = PdfFileModel(
      name: fileNameController.text,
      profileType: state.profileType,
      createdAt: state.createdAt,
      signatory: state.signatory,
      scannedDocument: state.scannedDocument,
      note: noteController.text,
      pdfFile: kIsWeb ? filePickerResult.bytes : null,
      pdfPath: kIsWeb ? '' : filePickerResult.path ?? '',
    );

    // Tạo danh sách mới và đảo ngược
    final updatedPdfFileModels = [
      ...?state.pdfFileModels,
      pdfFileModel,
    ].reversed.toList();

    // Cập nhật trạng thái mới với danh sách đã đảo ngược
    emit(
      state.copyWith(
        pdfFileModels: updatedPdfFileModels,
      ),
    );

    clearState();
  }

  void removePdfFile(String id) {
    final updatedPdfFileModels =
        state.pdfFileModels?.where((model) => model.id != id).toList() ?? [];
    emit(state.copyWith(pdfFileModels: updatedPdfFileModels));
  }

  Future<void> saveAndSubmitAllFile() async {
    //submit data lên api

    //........
    //clear data list
    emit(state.copyWith(pdfFileModels: []));
  }

  Future<void> onSelectDateTime(DateTime time) async {
    dateController.text = DateTimeFormat.formatDateDDMMYY(time);
    emit(state.copyWith(createdAt: time));
  }

  void scannedDocumentOnCheck(bool scanned) {
    emit(state.copyWith(scannedDocument: scanned));
  }

  void reviewDocument(PdfFileModel pdfFileModel) {
    fileNameController.text = pdfFileModel.name!;
    dateController.text =
        DateTimeFormat.formatDateDDMMYY(pdfFileModel.createdAt!);
    emit(state.copyWith(
      createdAt: pdfFileModel.createdAt,
      profileType: pdfFileModel.profileType,
      scannedDocument: pdfFileModel.scannedDocument,
      signatory: pdfFileModel.signatory,
    ));
  }

  void clearState() {
    noteController.clear();
    fileNameController.clear();
    curentPageController.clear();
    pdfViewerController.clearFormData();
    percentController.clear();
    dateController.clear();
    emit(state.copyWith(
      filePickerResult: null,
      profileType: null,
      createdAt: null,
      scannedDocument: false,
      signatory: null,
      currentPage: null,
      currentZoom: null,
      maxPage: null,
      pdfFileModel: null,
    ));
  }
}
