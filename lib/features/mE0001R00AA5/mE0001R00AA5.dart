import 'package:account/core/widgets/pdf/bloc/pdf_cubit.dart';
import 'package:account/features/mE0001R00AA5/binding/mE0001R00AA5_binding.dart';
import 'package:account/features/mE0001R00AA5/widgets/mE0001R00AA5_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ME0001R00AA5 extends StatefulWidget {
  const ME0001R00AA5({
    super.key,
  });

  @override
  State<ME0001R00AA5> createState() => _ME0001R00AA5State();
}

class _ME0001R00AA5State extends State<ME0001R00AA5> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ME0001R00AA5Binding.generateBloc),
        BlocProvider(
          create: (context) => PdfViewerCubit(),
        ),
      ],
      child: ME0001R00AA5Widget(),
    );
  }
}
