import 'package:flutter/material.dart';

import 'number_paginator.dart';

class DisplayTable extends StatefulWidget {
  const DisplayTable({
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
  //
  final void Function(int) onLimitChange;
  final void Function(int) onPageChange;

  @override
  State<DisplayTable> createState() => _DisplayTableState();
}

class _DisplayTableState extends State<DisplayTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width - widget.padding * 2,
            child: SingleChildScrollView(
              child: DataTable(
                border: TableBorder(
                  top: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  right: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  left: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  horizontalInside: const BorderSide(color: Color(0xFFB3E5FC)),
                  verticalInside: const BorderSide(color: Colors.white),
                ),
                headingRowColor: WidgetStateProperty.resolveWith(
                    (states) => const Color(0xFFB3E5FC).withOpacity(0.5)),
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF47535D),
                ),
                headingRowHeight: 48,
                columns: widget.dataHeader
                    .map(
                      (e) => DataColumn(
                        label: Expanded(
                          child: Center(
                            child: Text(
                              e,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
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
