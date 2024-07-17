
import 'package:account/features/e01S01003/widgets/data_table_e01S01003_widget.dart';
import 'package:account/features/e01S01003/widgets/permission_group_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class E01s01003 extends StatefulWidget {
  const E01s01003({super.key});

  @override
  State<E01s01003> createState() => _E01s01003State();
}

class _E01s01003State extends State<E01s01003> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.large: SlotLayout.from(
          builder: (context) => const Scaffold(
            body: Row(
              children: [
                DataTableE01S01003Widget(),
                // Expanded(flex: 7, child: PermissionGroupInformationWidget()),
              ],
            ),
          ),
          key: const Key('Large'),
        )
      }),
    );
  }
}
