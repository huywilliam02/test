import 'package:dashboard/features/e01/e01S01001/models/item_base_model.dart';
import 'package:flutter/material.dart';

class DropdownItemBase extends StatefulWidget {
  final String? hintText;
  final List<ItemBaseModel> items;
  final ItemBaseModel? value;
  final Function(ItemBaseModel?)? onChanged;
  final double? width;
  final double? height;

  const DropdownItemBase({
    super.key,
    this.hintText,
    required this.items,
    this.value,
    this.onChanged,
    this.width,
    this.height,
  });

  @override
  _DropdownItemBaseState createState() => _DropdownItemBaseState();
}

class _DropdownItemBaseState extends State<DropdownItemBase> {
  ItemBaseModel? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    double effectiveWidth =
        widget.width ?? MediaQuery.of(context).size.width * 0.9;
    double effectiveHeight = widget.height ?? 36.0;

    return SizedBox(
      width: effectiveWidth,
      height: effectiveHeight,
      child: DropdownButtonFormField<ItemBaseModel>(
        isExpanded: true,
        dropdownColor: Colors.white,
        value: _selectedItem,
        items: widget.items
            .map(
              (item) => DropdownMenuItem<ItemBaseModel>(
                value: item,
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
        onChanged: (value) {
          setState(() {
            _selectedItem = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        hint: widget.hintText != null
            ? Text(
                widget.hintText!,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF979797)),
              )
            : null,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: widget.value != null ? Colors.black : const Color(0xFF979797),
        ),
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
    );
  }
}
