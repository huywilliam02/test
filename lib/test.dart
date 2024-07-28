import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:pdfx/pdfx.dart';


class PdfUploader extends StatefulWidget {
  @override
  _PdfUploaderState createState() => _PdfUploaderState();
}

class _PdfUploaderState extends State<PdfUploader> {
  Uint8List? _fileBytes;
  String? _fileName;
  PdfController? _pdfController;

  Future<void> _pickPdf() async {
    if (kIsWeb) {
      _pickPdfWeb();
    } else {
      _pickPdfMobileDesktop();
    }
  }

  void _pickPdfWeb() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.pdf';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isEmpty) return;
      final file = files[0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((e) {
        setState(() {
          _fileBytes = reader.result as Uint8List;
          _fileName = file.name;
          _pdfController = PdfController(
            document: PdfDocument.openData(_fileBytes!),
          );
        });
      });
      reader.readAsArrayBuffer(file);
    });
  }

  Future<void> _pickPdfMobileDesktop() async {
    file_picker.FilePickerResult? result = await file_picker.FilePicker.platform.pickFiles(
      type: file_picker.FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _fileBytes = result.files.single.bytes;
        _fileName = result.files.single.name;
        _pdfController = PdfController(
          document: PdfDocument.openData(_fileBytes!),
        );
      });
    } else {
      _showSnackBar('No file selected or path is null');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Uploader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_fileBytes == null)
              ElevatedButton(
                onPressed: _pickPdf,
                child: Text('Pick PDF'),
              )
            else
              Expanded(
                child: PdfView(
                  controller: _pdfController!,
                ),
              ),
            if (_fileName != null)
              Text('PDF Selected: $_fileName'),
          ],
        ),
      ),
    );
  }
}
