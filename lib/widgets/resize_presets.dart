import 'package:flutter/material.dart';
import 'package:image_converter/l10n/app_localizations.dart';
import '../models/resize_preset.dart';

class ResizePresets extends StatelessWidget {
  final String? selectedPresetId;
  final ValueChanged<ResizePreset> onPresetSelected;

  const ResizePresets({
    super.key,
    this.selectedPresetId,
    required this.onPresetSelected,
  });

  String _getLocalizedLabel(AppLocalizations l10n, String labelKey) {
    switch (labelKey) {
      case 'hd':
        return l10n.hd;
      case 'fullHd':
        return l10n.fullHd;
      case 'uhd4k':
        return l10n.uhd4k;
      case 'instagram':
        return l10n.instagram;
      case 'facebook':
        return l10n.facebook;
      case 'twitter':
        return l10n.twitter;
      case 'youtube':
        return l10n.youtube;
      case 'webSmall':
        return l10n.webSmall;
      default:
        return labelKey;
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
                  Icons.aspect_ratio,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.resizePresets,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ResizePreset.presets.map((preset) {
                final isSelected = preset.id == selectedPresetId;
                return FilterChip(
                  label: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_getLocalizedLabel(l10n, preset.labelKey)),
                      Text(
                        preset.displaySize,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isSelected 
                              ? colorScheme.onSecondaryContainer 
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  selected: isSelected,
                  onSelected: (_) => onPresetSelected(preset),
                  showCheckmark: false,
                  selectedColor: colorScheme.secondaryContainer,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
