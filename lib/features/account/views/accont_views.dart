import 'package:account/features/account/widgets/data_table_widget.dart';
import 'package:account/features/account/widgets/staff_information_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < 10; i++)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: const Color.fromARGB(255, 255, 201, 197),
            height: 400,
          ),
        )
    ];
    return AdaptiveLayout(
      body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.large: SlotLayout.from(
          builder: (context) => const Scaffold(
            body: Row(
              children: [
                DataTableWidgett(),
                Expanded(flex: 7, child: StaffInformationDetails()),
              ],
            ),
          ),
          key: const Key('Large'),
        )
      }),
    );
  }
}
