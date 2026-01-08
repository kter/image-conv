import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_converter/l10n/app_localizations.dart';

class CustomSizeInput extends StatefulWidget {
  final int? width;
  final int? height;
  final double? scalePercent;
  final bool maintainAspectRatio;
  final int? originalWidth;
  final int? originalHeight;
  final ValueChanged<int?> onWidthChanged;
  final ValueChanged<int?> onHeightChanged;
  final ValueChanged<double?> onScaleChanged;
  final ValueChanged<bool> onAspectRatioChanged;

  const CustomSizeInput({
    super.key,
    this.width,
    this.height,
    this.scalePercent,
    required this.maintainAspectRatio,
    this.originalWidth,
    this.originalHeight,
    required this.onWidthChanged,
    required this.onHeightChanged,
    required this.onScaleChanged,
    required this.onAspectRatioChanged,
  });

  @override
  State<CustomSizeInput> createState() => _CustomSizeInputState();
}

class _CustomSizeInputState extends State<CustomSizeInput> {
  late TextEditingController _widthController;
  late TextEditingController _heightController;
  late TextEditingController _scaleController;

  @override
  void initState() {
    super.initState();
    _widthController = TextEditingController(
      text: widget.width?.toString() ?? '',
    );
    _heightController = TextEditingController(
      text: widget.height?.toString() ?? '',
    );
    _scaleController = TextEditingController(
      text: widget.scalePercent?.toStringAsFixed(0) ?? '',
    );
  }

  @override
  void didUpdateWidget(CustomSizeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.width != oldWidget.width && widget.width != int.tryParse(_widthController.text)) {
      _widthController.text = widget.width?.toString() ?? '';
    }
    if (widget.height != oldWidget.height && widget.height != int.tryParse(_heightController.text)) {
      _heightController.text = widget.height?.toString() ?? '';
    }
    if (widget.scalePercent != oldWidget.scalePercent) {
      _scaleController.text = widget.scalePercent?.toStringAsFixed(0) ?? '';
    }
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _handleWidthChange(String value) {
    final width = int.tryParse(value);
    widget.onWidthChanged(width);
    
    if (widget.maintainAspectRatio && width != null && widget.originalWidth != null && widget.originalHeight != null) {
      final aspectRatio = widget.originalWidth! / widget.originalHeight!;
      final newHeight = (width / aspectRatio).round();
      _heightController.text = newHeight.toString();
      widget.onHeightChanged(newHeight);
    }
  }

  void _handleHeightChange(String value) {
    final height = int.tryParse(value);
    widget.onHeightChanged(height);
    
    if (widget.maintainAspectRatio && height != null && widget.originalWidth != null && widget.originalHeight != null) {
      final aspectRatio = widget.originalWidth! / widget.originalHeight!;
      final newWidth = (height * aspectRatio).round();
      _widthController.text = newWidth.toString();
      widget.onWidthChanged(newWidth);
    }
  }

  void _applyScale() {
    final scale = double.tryParse(_scaleController.text);
    if (scale != null && scale > 0 && scale <= 500) {
      widget.onScaleChanged(scale);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.photo_size_select_large,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.customSize,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Percentage scale
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _scaleController,
                    decoration: InputDecoration(
                      labelText: l10n.percentageScale,
                      suffixText: '%',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.tonal(
                  onPressed: _applyScale,
                  child: Text(l10n.apply),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Custom dimensions
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _widthController,
                    decoration: InputDecoration(
                      labelText: l10n.width,
                      suffixText: 'px',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5),
                    ],
                    onChanged: _handleWidthChange,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.close,
                  size: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _heightController,
                    decoration: InputDecoration(
                      labelText: l10n.height,
                      suffixText: 'px',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5),
                    ],
                    onChanged: _handleHeightChange,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Maintain aspect ratio checkbox
            Row(
              children: [
                Checkbox(
                  value: widget.maintainAspectRatio,
                  onChanged: (value) => widget.onAspectRatioChanged(value ?? true),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => widget.onAspectRatioChanged(!widget.maintainAspectRatio),
                    child: Text(
                      l10n.maintainAspectRatio,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
