// web_pdf_viewer_stub.dart

import 'package:flutter/material.dart';

class WebPdfViewer extends StatelessWidget {
  final String pdfUrl;

  WebPdfViewer({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Web PDF viewer is not supported on this platform'),
    );
  }
}
