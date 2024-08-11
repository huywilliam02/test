import 'package:account/features/mE0001R00AA5/widgets/mE0001R00AA5_data_table.dart';
import 'package:account/features/mE0001R00AA5/widgets/mE0001R00AA5_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class ME0001R00AA5Widget extends StatelessWidget {
  const ME0001R00AA5Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.large: SlotLayout.from(
          builder: (context) => const Row(
            children: [
              ME0001R00AA5DataTable(),
              SizedBox(width: 2.0),
              ME0001R00AA5Pdf(),
            ],
          ),
          key: const Key('Large'),
        ),
      }),
    );
  }
}
