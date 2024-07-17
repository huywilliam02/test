import 'package:dashboard/utils/color_resources.dart';
import 'package:dashboard/utils/dimensions.dart';
import 'package:flutter/material.dart';

class LabelWithField extends StatelessWidget {
  final String label;
  final Widget field;
  final String? requiredText;

  const LabelWithField({
    super.key,
    required this.label,
    required this.field,
    this.requiredText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: ColorResources.subName,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  requiredText ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: ColorResources.redBoder,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(flex: 6, child: field),
        ],
      ),
    );
  }
}
