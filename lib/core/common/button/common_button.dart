import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  final Function()? onTap;
  final String? buttonIcon;

  final String? textName;
  final bool isBorder;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? fontSize;
  final double? borderWidth;
  final Color? colorIcon;
  final double? height;
  final double? width;

  const CommonButton({
    super.key,
    this.onTap,
    required this.buttonIcon,
    this.isBorder = false,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.colorIcon,
    this.borderColor,
    this.borderWidth,
    this.height,
    this.width,
    this.textName,
  });

  @override
  _CommonButtonState createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double buttonHeight = widget.height ?? 32;
        double buttonWidth = widget.width ?? constraints.maxWidth * 99;

        return InkWell(
          onTap: widget.onTap,
          child: Container(
            height: buttonHeight,
            width: buttonWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: widget.isBorder
                  ? Border.all(
                      color:
                          widget.borderColor ?? Theme.of(context).primaryColor,
                      width: widget.borderWidth ?? 2,
                    )
                  : null,
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.buttonIcon ?? "",
                  height: 16,
                  width: 16,
                  color: widget.colorIcon,
                ),
                if (widget.textName != null) const SizedBox(width: 4),
                Text(
                  widget.textName ?? "",
                  style: TextStyle(
                    color: widget.textColor ?? Colors.white,
                    fontSize: widget.fontSize ?? 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
