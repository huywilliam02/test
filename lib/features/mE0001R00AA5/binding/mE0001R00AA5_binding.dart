import 'package:account/features/mE0001R00AA5/bloc/mE0001R00AA5_cubit.dart';
import 'package:flutter/material.dart';

class ME0001R00AA5Binding {
  static ME0001R00AA5Cubit generateBloc(BuildContext context) {
    return ME0001R00AA5Cubit(pdfPickerUsecase: PdfPickerUsecase());
  }
}
