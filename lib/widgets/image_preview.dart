import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_converter/l10n/app_localizations.dart';
import '../services/image_processor_service.dart';

class ImagePreview extends StatelessWidget {
  final File? imageFile;
  final ConvertedImageInfo? imageInfo;
  final String labelKey;
  final bool isOriginal;

  const ImagePreview({
    super.key,
    required this.imageFile,
    required this.imageInfo,
    required this.labelKey,
    this.isOriginal = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isOriginal ? Icons.image : Icons.image_search,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  labelKey == 'original' ? l10n.originalImage : l10n.convertedImage,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (imageFile != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.file(
                    imageFile!,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: colorScheme.surfaceContainerHighest,
                        child: Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 48,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            else
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 48,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.noImageSelected,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (imageInfo != null) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.dimensions(imageInfo!.width, imageInfo!.height),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    l10n.fileSize(imageInfo!.formattedSize),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
