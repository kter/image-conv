import 'package:flutter/material.dart';
import 'package:image_converter/l10n/app_localizations.dart';

class ActionButtons extends StatelessWidget {
  final bool hasOriginalImage;
  final bool hasConvertedImage;
  final bool isProcessing;
  final VoidCallback onConvert;
  final VoidCallback onSave;
  final VoidCallback onShare;

  const ActionButtons({
    super.key,
    required this.hasOriginalImage,
    required this.hasConvertedImage,
    required this.isProcessing,
    required this.onConvert,
    required this.onSave,
    required this.onShare,
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
          children: [
            // Convert button
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: hasOriginalImage && !isProcessing ? onConvert : null,
                icon: isProcessing 
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorScheme.onPrimary,
                        ),
                      )
                    : const Icon(Icons.transform),
                label: Text(isProcessing ? l10n.converting : l10n.convert),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Save and Share buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: hasConvertedImage && !isProcessing ? onSave : null,
                    icon: const Icon(Icons.save_alt),
                    label: Text(l10n.save),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: hasConvertedImage && !isProcessing ? onShare : null,
                    icon: const Icon(Icons.share),
                    label: Text(l10n.share),
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
