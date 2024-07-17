import 'package:dashboard/utils/color_resources.dart';
import 'package:flutter/material.dart';

class CustomTooltip extends StatefulWidget {
  final Widget child;
  final List<String> buttonNames;

  const CustomTooltip({
    required this.child,
    required this.buttonNames,
  });

  @override
  _CustomTooltipState createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<CustomTooltip> {
  OverlayEntry? _overlayEntry;
  bool _isHovering = false;
  bool _tooltipVisible = false;
  int _hoveredIndex = -1; // Track which button is being hovered over

  void _showTooltip(BuildContext context, Offset position) {
    if (_tooltipVisible) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy - 20,
        // left: position.dx,
        left: 100,
        child: MouseRegion(
          onEnter: (_) => _onTooltipHoverEnter(),
          onExit: (_) => _onTooltipHoverExit(),
          onHover: (event) {
            setState(() {
              _isHovering = true;
            });
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.buttonNames.length, (index) {
                  return MouseRegion(
                    onEnter: (_) => _onSubMenuHoverEnter(index),
                    // onExit: (_) => _onSubMenuHoverExit(index),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        color: _hoveredIndex == index
                            ? ColorResources.lightBlue
                            : ColorResources.transparent,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          widget.buttonNames[index],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
    setState(() {
      _tooltipVisible = true;
    });
  }

  void _onTooltipHoverEnter() {
    setState(() {
      _isHovering = true;
    });
  }

  void _onTooltipHoverExit() {
    setState(() {
      _isHovering = false;
      _delayedHideTooltip();
    });
  }

  void _hideTooltip() {
    setState(() {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _tooltipVisible = false;
    });
  }

  void _delayedHideTooltip() {
    Future.delayed(Duration(milliseconds: 0), () {
      if (!_isHovering) {
        _hideTooltip();
      }
    });
  }

  void _onChildHoverExit() {
    setState(() {
      _isHovering = false;
      _delayedHideTooltip();
    });
  }

  void _onSubMenuHoverEnter(int index) {
    setState(() {
      _hoveredIndex = index;
      print(index);
    });
  }

  void _onSubMenuHoverExit(int index) {
    setState(() {
      _hoveredIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        _isHovering = true;
        _showTooltip(context, event.position);
      },
      onExit: (_) => _onChildHoverExit(),
      child: Container(
        child: widget.child,
        color: _isHovering ? ColorResources.mainMenu : ColorResources.white,
      ),
    );
  }
}
