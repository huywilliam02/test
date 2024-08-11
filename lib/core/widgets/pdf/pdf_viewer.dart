import 'dart:io';
import 'dart:typed_data';

import 'package:account/core/constants/app_color.dart';
import 'package:account/core/widgets/pdf/bloc/pdf_cubit.dart';
import 'package:account/core/widgets/pdf/bloc/pdf_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// Expanded(
//   child: PdfViewerWidget(
//     fileName: state.filePickerResult?.name ?? '',
//     maxPage: state.maxPage ?? 0,
//     curentPageController: context
//         .read<ME0001R00AA5Cubit>()
//         .curentPageController,
//     percentController:
//         context.read<ME0001R00AA5Cubit>().percentController,
//     onPageChanged: (value) {
//       context.read<ME0001R00AA5Cubit>().updateCurrentPage(
//             int.parse(value),
//           );
//     },
//     onZoomIn: () =>
//         context.read<ME0001R00AA5Cubit>().zoomIn(),
//     onZoomOut: () =>
//         context.read<ME0001R00AA5Cubit>().zoomOut(),
//     onRotate: () {},
//     onDownload: () {},
//     onPrint: () {},
//     file: state.filePickerResult != null && !kIsWeb
//         ? File(state.filePickerResult!.path!)
//         : null,
//     fileBytes: kIsWeb ? state.filePickerResult?.bytes : null,
//     pdfControllerFile:
//         context.read<ME0001R00AA5Cubit>().pdfViewerController,
//     pdfControllerMemory:
//         context.read<ME0001R00AA5Cubit>().pdfViewerController,
//   ),
// ),
class PdfViewerWidgetCubit extends StatelessWidget {
  final File? file;
  final Uint8List? fileBytes;
  final String fileName;
  final int maxPage;
  final TextEditingController? curentPageController;
  final TextEditingController? percentController;
  final void Function(String)? onPageChanged;
  final void Function()? onZoomIn;
  final void Function()? onZoomOut;
  final void Function()? onRotate;
  final void Function()? onDownload;
  final void Function()? onPrint;
  final PdfViewerController pdfControllerMemory;
  final PdfViewerController pdfControllerFile;

  const PdfViewerWidgetCubit({
    super.key,
    this.file,
    this.fileBytes,
    required this.fileName,
    required this.maxPage,
    this.curentPageController,
    this.percentController,
    this.onPageChanged,
    this.onZoomIn,
    this.onZoomOut,
    this.onRotate,
    required this.pdfControllerMemory,
    required this.pdfControllerFile,
    this.onDownload,
    this.onPrint,
  });

  @override
  Widget build(BuildContext context) {
    if (file == null && fileBytes == null) {
      return const Center(
        child: Text('No PDF selected'),
      );
    }

    return BlocBuilder<PdfViewerCubit, PdfViewerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              _buildControllerPdfViewer(
                fileName: fileName,
                onSubmitted: onPageChanged,
                curentPageController: curentPageController,
                percentController: percentController,
                maxPage: maxPage,
                onTapZoomIn: onZoomIn,
                onTapZoomOut: onZoomOut,
                onTapRotate: onRotate,
                onTapDownload: onDownload,
                onTapPrint: onPrint,
              ),
              Expanded(
                child: kIsWeb
                    ? fileBytes != null
                        ? Transform.rotate(
                            angle: state.rotation * 3.1415926535897932 / 180,
                            child: SfPdfViewer.memory(
                              fileBytes!,
                              controller: pdfControllerMemory,
                            ),
                          )
                        : const Center(child: Text('No PDF selected'))
                    : file != null
                        ? Transform.rotate(
                            angle: state.rotation * 3.1415926535897932 / 180,
                            child: SfPdfViewer.file(
                              file!,
                              controller: pdfControllerFile,
                            ),
                          )
                        : const Center(child: Text('No PDF selected')),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildControllerPdfViewer({
    required String fileName,
    TextEditingController? percentController,
    TextEditingController? curentPageController,
    required int maxPage,
    void Function()? onTapZoomOut,
    void Function()? onTapZoomIn,
    void Function()? onTapRotate,
    void Function()? onTapDownload,
    void Function()? onTapPrint,
    void Function(String)? onSubmitted,
  }) {
    return Container(
      height: 50.0,
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.menu, color: Colors.white, size: 30.0),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              overflow: TextOverflow.ellipsis,
              fileName,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          _buildInput(
              width: 30,
              onSubmitted: onSubmitted,
              controller: curentPageController),
          const SizedBox(width: 10),
          const Text('/',
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
          const SizedBox(width: 10),
          Text(
            maxPage.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          const SizedBox(width: 10),
          const VerticalDivider(
              width: 1, indent: 5, endIndent: 5, color: Colors.white),
          const SizedBox(width: 10),
          _buildButtonZoom(icon: Icons.remove, onTap: onTapZoomOut),
          _buildInput(width: 60, controller: percentController),
          _buildButtonZoom(icon: Icons.add, onTap: onTapZoomIn),
          const SizedBox(width: 10),
          const VerticalDivider(
            width: 1,
            indent: 5,
            endIndent: 5,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          _buildControllerIcon(
              icon: Icons.rotate_90_degrees_ccw_outlined, onTap: onTapRotate),
          _buildControllerIcon(icon: Icons.download, onTap: onTapDownload),
          const SizedBox(width: 10),
          _buildControllerIcon(icon: Icons.print, onTap: onTapPrint),
        ],
      ),
    );
  }

  Widget _buildInput(
      {TextEditingController? controller,
      double? width,
      void Function(String)? onSubmitted}) {
    return SizedBox(
      width: width,
      height: 30,
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        decoration: const InputDecoration(
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          filled: true,
          fillColor: AppColor.c_242220,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          isDense: true,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14, color: AppColor.c_FFFFFF),
      ),
    );
  }

  Widget _buildButtonZoom({
    required IconData icon,
    void Function()? onTap,
  }) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onTap,
    );
  }

  Widget _buildControllerIcon({
    required IconData icon,
    void Function()? onTap,
  }) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onTap,
    );
  }
}
