import 'package:flutter/material.dart';
import 'package:image_converter/l10n/app_localizations.dart';
import '../models/image_format.dart';

class FormatSelector extends StatelessWidget {
  final ImageOutputFormat selectedFormat;
  final ValueChanged<ImageOutputFormat> onFormatChanged;

  const FormatSelector({
    super.key,
    required this.selectedFormat,
    required this.onFormatChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.file_copy_outlined,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.outputFormat,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SegmentedButton<ImageOutputFormat>(
              segments: ImageOutputFormat.values.map((format) {
                return ButtonSegment<ImageOutputFormat>(
                  value: format,
                  label: Text(format.displayName),
                );
              }).toList(),
              selected: {selectedFormat},
              onSelectionChanged: (selected) {
                onFormatChanged(selected.first);
              },
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: theme.colorScheme.primaryContainer,
                selectedForegroundColor: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
