import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'number_paginator.dart';

class DisplayTableWithTreeView extends StatefulWidget {
  const DisplayTableWithTreeView({
    super.key,
    this.padding = 12,
    required this.dataHeader,
    required this.rowsData,
    required this.limit,
    required this.currentPage,
    required this.numberPages,
    required this.onLimitChange,
    required this.onPageChange,
    required this.sampleTree,
    this.showRootNode = true,
    this.expandChildrenOnReady = false,
    this.showSnackBar = false,
  });

  final double padding;
  final List<String> dataHeader;
  final List<DataRow> rowsData;
  final int limit;
  final int currentPage;
  final int numberPages;
  final void Function(int) onLimitChange;
  final void Function(int) onPageChange;
  final TreeNode sampleTree;
  final bool showRootNode;
  final bool expandChildrenOnReady;
  final bool showSnackBar;

  @override
  State<DisplayTableWithTreeView> createState() =>
      _DisplayTableWithTreeViewState();
}

class _DisplayTableWithTreeViewState extends State<DisplayTableWithTreeView> {
  late TreeViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(
          height: 12,
        ),
        Container(
          height: 200, // Adjust the height as needed
          child: TreeView.simple(
            tree: widget.sampleTree,
            showRootNode: widget.showRootNode,
            expansionIndicatorBuilder: (context, node) =>
                ChevronIndicator.rightDown(
              tree: node,
              color: Colors.blue[700],
              padding: const EdgeInsets.all(8),
            ),
            indentation: const Indentation(style: IndentStyle.squareJoint),
            onItemTap: (item) {
              if (kDebugMode) print("Item tapped: ${item.key}");

              if (widget.showSnackBar) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Item tapped: ${item.key}"),
                    duration: const Duration(milliseconds: 750),
                  ),
                );
              }
            },
            onTreeReady: (controller) {
              _controller = controller;
              if (widget.expandChildrenOnReady) {
                controller.expandAllChildren(widget.sampleTree);
              }
            },
            builder: (context, node) => Card(
              color: Colors.blue[50]!,
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Item ${node.level}-${node.key}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Level ${node.level}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    // Add more Expanded widgets here for additional columns
                  ],
                ),
                subtitle: Text('Node data: ${node.data}'),
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
