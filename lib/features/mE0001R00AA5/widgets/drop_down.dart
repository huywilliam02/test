import 'package:account/core/models/item_base_model.dart';
import 'package:account/core/utils/spaces.dart';
import 'package:flutter/material.dart';

class DropdownPdf extends StatelessWidget {
  final String? title;
  final String? hintText;
  final List<ItemBaseModel> items;
  final String? value;
  final void Function(String?)? onChanged;
  final double? height;
  final double? width;

  const DropdownPdf({
    super.key,
    this.title,
    this.hintText,
    required this.items,
    this.value,
    this.onChanged,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveHeight = height ?? 36.0;
    final Color iconColor =
        value != null ? Colors.black : const Color(0xFF979797);

    return Row(
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          spaceW12,
        ],
        Expanded(
          child: SizedBox(
            height: effectiveHeight,
            width: width,
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              dropdownColor: Colors.white,
              value: value,
              items: items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item.name,
                      child: Text(
                        item.name ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
              hint: hintText != null
                  ? Text(
                      hintText!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF979797),
                      ),
                    )
                  : null,
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: iconColor),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color(0xFFCBD2D9),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color(0xFFCBD2D9),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color(0xFFCBD2D9),
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
