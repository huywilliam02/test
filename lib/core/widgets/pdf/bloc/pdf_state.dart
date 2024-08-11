import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
part 'pdf_state.g.dart';
@CopyWith()
class PdfViewerState {
  final String? filePath;
  final Uint8List? fileBytes;
  final PdfViewerController? controller;
  final double zoomLevel;
  final int currentPage;
  final int maxPage;
  final bool isLoading;
  final PlatformFile? filePickerResult;
  final DateTime? createdAt;
  final String? profileType;
  final String? signatory;
  final bool? scannedDocument;
  final double? currentZoom;
  final int rotation;

  const PdfViewerState({
    this.isLoading = false,
    this.filePickerResult,
    this.createdAt,
    this.profileType,
    this.signatory,
    this.scannedDocument = false,
    this.currentZoom,
    this.filePath,
    this.fileBytes,
    this.controller,
    this.zoomLevel = 1.0,
    this.currentPage = 1,
    this.maxPage = 0,
    this.rotation = 0,
  });
}
