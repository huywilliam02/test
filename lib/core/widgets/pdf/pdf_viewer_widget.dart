import 'dart:io';
import 'dart:typed_data';
import 'package:account/core/constants/app_color.dart';
import 'package:account/core/utils/spaces.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/services.dart';

class PdfViewerWidget extends StatefulWidget {
  final File? file;
  final Uint8List? fileBytes;
  final String fileName;
  final int maxPage;
  final PdfViewerController? pdfControllerMemory;
  final PdfViewerController? pdfControllerFile;

  const PdfViewerWidget({
    super.key,
    this.file,
    this.fileBytes,
    required this.fileName,
    required this.maxPage,
    this.pdfControllerMemory,
    this.pdfControllerFile,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PdfViewerWidgetState createState() => _PdfViewerWidgetState();
}

class _PdfViewerWidgetState extends State<PdfViewerWidget> {
  late PdfViewerController pdfViewerControllerFile;
  late PdfViewerController pdfViewerControllerMemory;
  late TextEditingController _currentPageController;
  late TextEditingController _percentController;
  double _zoomLevel = 1.0;
  int _rotation = 0;

  @override
  void initState() {
    super.initState();
    pdfViewerControllerFile = PdfViewerController();
    pdfViewerControllerMemory = PdfViewerController();
    _currentPageController = TextEditingController(text: '1');
    _percentController = TextEditingController(text: '100%');
  }

  @override
  void dispose() {
    pdfViewerControllerFile.dispose();
    pdfViewerControllerMemory.dispose();
    _currentPageController.dispose();
    _percentController.dispose();
    super.dispose();
  }

  void _onZoomIn() {
    setState(() {
      _zoomLevel = (_zoomLevel + 0.2).clamp(0.1, 3.0);
      pdfViewerControllerFile.zoomLevel = _zoomLevel;
      pdfViewerControllerMemory.zoomLevel = _zoomLevel;
      final zoomPercentage = (_zoomLevel / 3.0) * 300;
      _percentController.text = '${zoomPercentage.toStringAsFixed(0)}%';
    });
  }

  void _onZoomOut() {
    setState(() {
      _zoomLevel = (_zoomLevel - 0.2).clamp(0.1, 3.0);
      pdfViewerControllerFile.zoomLevel = _zoomLevel;
      pdfViewerControllerMemory.zoomLevel = _zoomLevel;
      final zoomPercentage = (_zoomLevel / 3.0) * 300;
      _percentController.text = '${zoomPercentage.toStringAsFixed(0)}%';
    });
  }

  void _onRotate() {
    setState(() {
      _rotation = (_rotation + 90) % 360;
    });
  }

  void _onDownload() async {
    if (widget.fileBytes != null) {
      try {
        if (kIsWeb) {
          final blob = html.Blob([widget.fileBytes!]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute('download', widget.fileName)
            ..click();
          html.Url.revokeObjectUrl(url);
        } else {
          final dir = await getExternalStorageDirectory();
          final file = File('${dir!.path}/${widget.fileName}');
          await file.writeAsBytes(widget.fileBytes!, flush: true);
          print('File downloaded to ${file.path}');
        }
      } catch (e) {
        print('Error downloading file: $e');
      }
    } else {
      print('No file selected');
    }
  }

  void _onPrint() async {
    if (widget.fileBytes != null) {
      try {
        await Printing.sharePdf(
          bytes: widget.fileBytes!,
          filename: widget.fileName,
        );
      } catch (e) {
        print('Error sharing file: $e');
      }
    } else {
      print('No file selected');
    }
  }

  void _goToPage(String pageNumber) {
    final int page = int.tryParse(pageNumber) ?? 1;
    if (page >= 1 && page <= widget.maxPage) {
      pdfViewerControllerFile.jumpToPage(page - 1);
      pdfViewerControllerMemory.jumpToPage(page - 1);
      setState(() {
        _currentPageController.text = page.toString();
      });
    } else {
      print('Invalid page number');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.file == null && widget.fileBytes == null) {
      return Column(
        children: [
          spaceH46,
          const Center(
            child: Text('Vui lòng thêm PDF!'),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          _buildControllerPdfViewer(),
          Expanded(
            child: kIsWeb
                ? widget.fileBytes != null
                    ? Transform.rotate(
                        angle: _rotation * 3.1415926535897932 / 180,
                        child: SfPdfViewer.memory(
                          widget.fileBytes!,
                          controller: pdfViewerControllerMemory,
                        ),
                      )
                    : const Center(child: Text('No PDF selected'))
                : widget.file != null
                    ? Transform.rotate(
                        angle: _rotation * 3.1415926535897932 / 180,
                        child: SfPdfViewer.file(
                          widget.file!,
                          controller: pdfViewerControllerFile,
                        ),
                      )
                    : const Center(child: Text('No PDF selected')),
          ),
        ],
      ),
    );
  }

  Widget _buildControllerPdfViewer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
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
              widget.fileName,
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
            controller: _currentPageController,
            onSubmitted: _goToPage,
          ),
          const SizedBox(width: 10),
          const Text('/',
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
          const SizedBox(width: 10),
          Text(
            widget.maxPage.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          const SizedBox(width: 10),
          const VerticalDivider(
              width: 1, indent: 5, endIndent: 5, color: Colors.white),
          const SizedBox(width: 10),
          _buildButtonZoom(icon: Icons.remove, onTap: _onZoomOut),
          _buildInput(width: 60, controller: _percentController),
          _buildButtonZoom(icon: Icons.add, onTap: _onZoomIn),
          const SizedBox(width: 10),
          const VerticalDivider(
            width: 1,
            indent: 5,
            endIndent: 5,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          _buildControllerIcon(
              icon: Icons.rotate_90_degrees_ccw_outlined, onTap: _onRotate),
          _buildControllerIcon(icon: Icons.download, onTap: _onDownload),
          const SizedBox(width: 10),
          _buildControllerIcon(icon: Icons.print, onTap: _onPrint),
        ],
      ),
    );
  }

  Widget _buildInput({
    TextEditingController? controller,
    double? width,
    void Function(String)? onSubmitted,
  }) {
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
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onTap,
    );
  }

  Widget _buildControllerIcon({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onTap,
    );
  }
}
