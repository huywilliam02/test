import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdfx/pdfx.dart';
part 'mE0001R00AA5_state.g.dart';

@CopyWith()
class ME0001R00AA5State {
  final bool isLoading;
  final PdfFileModel? pdfFileModel;
  final PlatformFile? filePickerResult;
  final List<PdfFileModel>? pdfFileModels;
  final DateTime? createdAt;
  final String? profileType;
  final String? signatory;
  final bool? scannedDocument;
  final int? currentPage;
  final int? maxPage;
  final double? currentZoom;

  ME0001R00AA5State({
    this.isLoading = false,
    this.filePickerResult,
    this.pdfFileModel,
    this.pdfFileModels,
    this.createdAt,
    this.profileType,
    this.signatory,
    this.scannedDocument = false,
    this.currentPage,
    this.maxPage,
    this.currentZoom,
  });
}