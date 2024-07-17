import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'number_paginator.dart';

class DisplayTableSmall extends StatefulWidget {
  const DisplayTableSmall({
    super.key,
    this.padding = 12,
    required this.dataHeader,
    required this.rowsData,
    required this.limit,
    required this.currentPage,
    required this.numberPages,
    required this.onLimitChange,
    required this.onPageChange,
  });

  final double padding;
  final List<String> dataHeader;
  final List<DataRow> rowsData;
  final int limit;
  final int currentPage;
  final int numberPages;
  final void Function(int) onLimitChange;
  final void Function(int) onPageChange;

  @override
  State<DisplayTableSmall> createState() => _DisplayTableSmallState();
}

class _DisplayTableSmallState extends State<DisplayTableSmall> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(widget.padding),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                },
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  clipBehavior: Clip.none,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      border: const TableBorder(
                        bottom: BorderSide(
                          color: Color(0xFFB3E5FC),
                          width: 1.5,
                        ),
                        horizontalInside: BorderSide(color: Color(0xFFB3E5FC)),
                        verticalInside: BorderSide(color: Colors.white),
                      ),
                      headingRowColor: MaterialStateProperty.resolveWith(
                        (states) =>
                            Color.fromARGB(255, 51, 203, 119).withOpacity(0.5),
                      ),
                      headingTextStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xFF47535D),
                      ),
                      headingRowHeight: 48,
                      columns: widget.dataHeader
                          .map(
                            (e) => DataColumn(
                              label: Center(
                                child: Text(
                                  e,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      rows: widget.rowsData,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NumberPaginator(
                  limit: widget.limit,
                  numberPages: widget.numberPages,
                  currentPage: widget.currentPage,
                  onLimitChange: (int limit) {
                    widget.onLimitChange.call(limit);
                  },
                  onPageChange: (int page) {
                    widget.onPageChange.call(page);
                  },
                ),
                const SizedBox(
                  width: 12,
                )
              ],
            ),
            const SizedBox(
              height: 12,
            )
          ],
        ),
      ],
    );
  }
}
