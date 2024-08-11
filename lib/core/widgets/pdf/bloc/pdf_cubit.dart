import 'dart:io';
import 'dart:typed_data';
import 'package:account/core/widgets/pdf/bloc/pdf_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:universal_html/html.dart' as html;
import 'package:path_provider/path_provider.dart';

class PdfViewerCubit extends Cubit<PdfViewerState> {
  final PdfViewerController pdfViewerController = PdfViewerController();
  final TextEditingController curentPageController = TextEditingController();
  final TextEditingController percentController = TextEditingController();
  PdfViewerCubit() : super(const PdfViewerState());
}

extension Handler on PdfViewerCubit {
  void init() {
    pdfViewerController.jumpToPage(1);
    pdfViewerController.zoomLevel = 1.0;
    percentController.text = '100%';
    curentPageController.text = '1';
  }

  void loadPdf({String? filePath, Uint8List? fileBytes}) {
    emit(state.copyWith(filePath: filePath, fileBytes: fileBytes));
  }

  void updateCurrentPage(int pageNumber) async {
    pdfViewerController.jumpToPage(pageNumber);
    curentPageController.text = pageNumber.toString();
  }

  void onZoomIn() {
    final newZoomLevel = (pdfViewerController.zoomLevel + 0.2).clamp(0.1, 3.0);
    pdfViewerController.zoomLevel = newZoomLevel;
    final zoomPercentage = (newZoomLevel / 3.0) * 300;
    percentController.text = '${zoomPercentage.toStringAsFixed(0)}%';
    emit(state.copyWith(currentZoom: newZoomLevel));
  }

  void onZoomOut() {
    final newZoomLevel = (pdfViewerController.zoomLevel - 0.2).clamp(0.1, 3.0);
    pdfViewerController.zoomLevel = newZoomLevel;
    final zoomPercentage = (newZoomLevel / 3.0) * 300;
    percentController.text = '${zoomPercentage.toStringAsFixed(0)}%';
    emit(state.copyWith(currentZoom: newZoomLevel));
  }

  void onRotatePdf() {
    emit(state.copyWith(rotation: (state.rotation + 90) % 360));
  }

  Future<void> onDownloadPdf() async {
    if (state.fileBytes != null) {
      try {
        if (kIsWeb) {
          final blob = html.Blob([state.fileBytes!]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute('download', state.filePath ?? 'file.pdf')
            ..click();
          html.Url.revokeObjectUrl(url);
        } else {
          final dir = await getExternalStorageDirectory();
          final file = File('${dir!.path}/${state.filePath}');
          await file.writeAsBytes(state.fileBytes!, flush: true);
          print('File downloaded to ${file.path}');
        }
      } catch (e) {
        print('Error downloading file: $e');
      }
    } else {
      print('No file selected');
    }
  }

  void onPrintPdf() async {
    if (state.fileBytes != null) {
      try {
        await Printing.sharePdf(
          bytes: state.fileBytes!,
          filename: state.filePath ?? 'document.pdf',
        );
      } catch (e) {
        print('Error sharing file: $e');
      }
    } else {
      print('No file selected');
    }
  }
}
