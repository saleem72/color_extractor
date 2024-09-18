//

import 'package:flutter/material.dart';
import 'package:my_core/my_core.dart';

class DropdownText extends StatelessWidget {
  const DropdownText({
    super.key,
    required this.hint,
    required this.onSelection,
    required this.options,
  });

  final String hint;
  final Function(String) onSelection;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
      ),
      child: DropdownTextWidget(
        hint: hint,
        onSelection: onSelection,
        options: options,
      ),
    );
  }
}

class DropdownTextWidget extends StatefulWidget {
  const DropdownTextWidget({
    super.key,
    required this.hint,
    required this.onSelection,
    required this.options,
  });
  final String hint;
  final Function(String) onSelection;
  final List<String> options;
  @override
  State<DropdownTextWidget> createState() => _DropdownTextWidgetState();
}

class _DropdownTextWidgetState extends State<DropdownTextWidget> {
  // final TextEditingController _controller = TextEditingController();
  final LayerLink layerLink = LayerLink();

  OverlayEntry? entry;
  Size size = Size.zero;
  bool isEditing = false;
  String searchTerm = '';
  String? target;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    hideOverlay();
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
        itemCount: widget.options.length,
        itemBuilder: (BuildContext context, int index) {
          final str = widget.options[index];
          return ListTile(
            title: Text(
              str,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.purple,
              ),
            ),
            onTap: () async {
              widget.onSelection(str);
              if (mounted) {
                setState(() {
                  isEditing = false;
                });
              }
              target = str;
              hideOverlay();
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
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => showOverlay(),
        child: SizedBox(
          child: Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  width: double.maxFinite,
                  height: 44,
                  child: Row(
                    children: [
                      target == null
                          ? Text(
                              widget.hint,
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.grey,
                              ),
                            )
                          : Text(
                              target!,
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.purple,
                              ),
                            )
                    ],
                  ),
                ),
              ),
              isEditing
                  ? IconButton(
                      onPressed: () {
                        showOverlay();
                        widget.onSelection('');
                        if (mounted) {
                          setState(() {
                            target = null;
                          });
                        }
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
        ),
      ),
    );
  }
}
