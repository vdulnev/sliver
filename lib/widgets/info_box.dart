import 'package:flutter/material.dart';

enum InfoBoxType { tip, info, warning, example }

class InfoBox extends StatelessWidget {
  final String title;
  final String body;
  final InfoBoxType type;

  const InfoBox({
    super.key,
    required this.title,
    required this.body,
    this.type = InfoBoxType.info,
  });

  @override
  Widget build(BuildContext context) {
    final (color, icon) = switch (type) {
      InfoBoxType.tip => (Colors.teal, Icons.tips_and_updates_rounded),
      InfoBoxType.info => (Colors.blueAccent, Icons.info_outline_rounded),
      InfoBoxType.warning => (Colors.orange, Icons.warning_amber_rounded),
      InfoBoxType.example => (Colors.purple, Icons.code_rounded),
    };

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(body, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A styled section title for use inside sliver-based lesson screens.
class LessonSectionTitle extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;

  const LessonSectionTitle(
    this.text, {
    super.key,
    this.padding = const EdgeInsets.fromLTRB(16, 24, 16, 8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// A styled code-snippet block.
class CodeBlock extends StatelessWidget {
  final String code;

  const CodeBlock(this.code, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: SelectableText(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.5,
          color: Color(0xFFBBDEFB),
          height: 1.6,
        ),
      ),
    );
  }
}
