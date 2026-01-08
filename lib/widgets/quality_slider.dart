import 'package:flutter/material.dart';
import 'package:image_converter/l10n/app_localizations.dart';

class QualitySlider extends StatelessWidget {
  final int quality;
  final ValueChanged<int> onQualityChanged;
  final bool enabled;

  const QualitySlider({
    super.key,
    required this.quality,
    required this.onQualityChanged,
    this.enabled = true,
  });

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.high_quality_outlined,
                      size: 20,
                      color: enabled ? colorScheme.primary : colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.quality,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: enabled ? null : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: enabled 
                        ? colorScheme.primaryContainer 
                        : colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    l10n.qualityPercent(quality),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: enabled 
                          ? colorScheme.onPrimaryContainer 
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: enabled ? colorScheme.primary : colorScheme.surfaceContainerHighest,
                inactiveTrackColor: colorScheme.surfaceContainerHighest,
                thumbColor: enabled ? colorScheme.primary : colorScheme.onSurfaceVariant,
                overlayColor: colorScheme.primary.withValues(alpha: 0.12),
              ),
              child: Slider(
                value: quality.toDouble(),
                min: 10,
                max: 100,
                divisions: 9,
                onChanged: enabled 
                    ? (value) => onQualityChanged(value.round()) 
                    : null,
              ),
            ),
            if (!enabled)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'PNG format does not support quality adjustment',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
