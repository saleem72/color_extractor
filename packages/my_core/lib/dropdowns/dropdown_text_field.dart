//

import 'package:flutter/material.dart';
import 'package:my_core/my_core.dart';

class DropdownTextField extends StatelessWidget {
  const DropdownTextField({
    super.key,
    required this.hint,
    required this.onSelection,
    required this.options,
    required this.controller,
    required this.dropdownStyle,
    required this.textfieldStyle,
  });
  final String hint;
  final Function(String) onSelection;
  final List<String> options;
  final TextEditingController controller;
  final TextStyle? dropdownStyle;
  final TextStyle? textfieldStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
      ),
      child: DropdownTextFieldWidget(
        controller: controller,
        hint: hint,
        onSelection: onSelection,
        options: options,
        dropdownStyle: dropdownStyle,
        textfieldStyle: textfieldStyle,
      ),
    );
  }
}

class DropdownTextFieldWidget extends StatefulWidget {
  const DropdownTextFieldWidget({
    super.key,
    required this.hint,
    required this.onSelection,
    required this.options,
    required this.controller,
    required this.dropdownStyle,
    required this.textfieldStyle,
  });
  final String hint;
  final Function(String) onSelection;
  final List<String> options;
  final TextEditingController controller;
  final TextStyle? dropdownStyle;
  final TextStyle? textfieldStyle;
  @override
  State<DropdownTextFieldWidget> createState() =>
      _DropdownTextFieldWidgetState();
}

class _DropdownTextFieldWidgetState extends State<DropdownTextFieldWidget> {
  final LayerLink layerLink = LayerLink();
  final FocusNode focusNode = FocusNode();

  OverlayEntry? entry;
  Size size = Size.zero;
  bool isEditing = false;
  String searchTerm = '';

  List<String> get filtered {
    return widget.controller.text.trim() == ''
        ? widget.options
        : widget.options
            .where((element) => element
                .toLowerCase()
                .contains(widget.controller.text.trim().toLowerCase()))
            .toList();
  }

  bool _valueExists() {
    final customers = widget.options
        .where((element) => element == widget.controller.text)
        .toList();
    return customers.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocusChange);
  }

  _handleFocusChange() {
    if (focusNode.hasFocus) {
      showOverlay();
      if (mounted) {
        setState(() {
          isEditing = true;
        });
      }
    } else {
      hideOverlay();
      if (!_valueExists()) {
        widget.controller.clear();
        widget.onSelection('');
        setState(() {
          isEditing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    hideOverlay();
    focusNode.removeListener(_handleFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  Widget _buildOverlay() {
    return Material(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: filtered.length,
        itemBuilder: (BuildContext context, int index) {
          final str = filtered[index];
          return ListTile(
            title: Text(
              str,
              style: widget.dropdownStyle,
            ),
            onTap: () async {
              widget.onSelection(str);
              if (mounted) {
                setState(() {
                  isEditing = false;
                });
              }
              widget.controller.text = str;
              hideOverlay();
              focusNode.unfocus();
            },
          );
        },
      ),
    );
  }

  _doSomething() {
    entry = OverlayEntry(
      builder: (context) => Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () {
              hideOverlay();
              // focusNode.unfocus();
              // context.focusScope.unfocus();
            },
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: Colors.black.withOpacity(0.001),
            ),
          ),
          Positioned(
            width: size.width,
            height: 165,
            child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 8),
              child: _buildOverlay(),
            ),
          ),
        ],
      ),
    );
  }

  showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    // final offset = renderBox.localToGlobal(Offset.zero);
    size = renderBox.size;
    entry?.remove();
    entry = null;
    _doSomething();
    overlay.insert(entry!);
  }

  hideOverlay() {
    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: focusNode,
              style: widget.textfieldStyle,
              onChanged: (value) {
                showOverlay();
                widget.onSelection(value);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: widget.textfieldStyle?.copyWith(
                  // fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          isEditing
              ? IconButton(
                  onPressed: () {
                    showOverlay();
                    widget.onSelection('');
                    widget.controller.clear();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.purple,
                    size: 20,
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
