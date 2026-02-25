import 'package:flutter/material.dart';
import '../../widgets/info_box.dart';

class Lesson4PersistentHeaderScreen extends StatelessWidget {
  const Lesson4PersistentHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SliverPersistentHeader')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
              child: Text(
                'Sticky & Floating Headers',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'SliverPersistentHeader lets you insert a header between slivers that can be pinned or float as you scroll. It requires a custom delegate to define its min/max height and how it paints.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: InfoBox(
              type: InfoBoxType.info,
              title: 'pinned vs floating',
              body:
                  '• pinned: true → header always stays at the top of the viewport\n'
                  '• floating: true → header reappears immediately when scrolling up\n'
                  '• Both false → header scrolls away and stays gone',
            ),
          ),
          const SliverToBoxAdapter(
            child: CodeBlock(
              'SliverPersistentHeader(\n'
              '  pinned: true,\n'
              '  delegate: MyHeaderDelegate(\n'
              '    minHeight: 60, maxHeight: 150,\n'
              '  ),\n'
              ')',
            ),
          ),

          // Section 1 — Pinned
          const SliverToBoxAdapter(
            child: InfoBox(
              type: InfoBoxType.example,
              title: 'Section 1 — pinned: true',
              body:
                  'This header stays glued to the top of the screen as you scroll past it. Scroll down to see it in action.',
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _CustomHeaderDelegate(
              minHeight: 56,
              maxHeight: 160,
              title: 'Section 1 — Pinned',
              color: Colors.blue,
              icon: Icons.push_pin_rounded,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: const Icon(Icons.circle_outlined, size: 16),
                title: Text('Item ${index + 1} in Section 1'),
              ),
              childCount: 12,
            ),
          ),

          // Section 2 — Floating
          const SliverToBoxAdapter(
            child: InfoBox(
              type: InfoBoxType.example,
              title: 'Section 2 — floating: true',
              body:
                  'This header re-appears immediately when you start scrolling up, even if you\'re not at the top.\n\n'
                  'Key: its minHeight is 0. When Section 3 scrolls in, this header collapses completely instead of stacking.',
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: _CustomHeaderDelegate(
              minHeight: 56,
              maxHeight: 120,
              title: 'Section 2 — Floating',
              color: Colors.greenAccent,
              icon: Icons.unfold_more_double_rounded,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: const Icon(Icons.circle_outlined, size: 16),
                title: Text('Item ${index + 1} in Section 2'),
              ),
              childCount: 20,
            ),
          ),
          // Section 3 — Replacing
          const SliverToBoxAdapter(
            child: InfoBox(
              type: InfoBoxType.example,
              title: 'Section 3 — replacing behavior',
              body:
                  'Section 2\'s header had minHeight: 0, so it collapsed completely when this header '
                  'scrolled into view. Only one header occupies the pinned spot at a time.',
            ),
          ),
          const SliverToBoxAdapter(
            child: CodeBlock(
              '// Section that gets REPLACED:\n'
              '_CustomHeaderDelegate(\n'
              '  minHeight: 0,   // collapses → replaced\n'
              '  maxHeight: 120,\n'
              ')\n\n'
              '// Section that REPLACES it:\n'
              '_CustomHeaderDelegate(\n'
              '  minHeight: 56,  // stays visible when pinned\n'
              '  maxHeight: 140,\n'
              ')',
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _CustomHeaderDelegate(
              minHeight: 56,
              maxHeight: 140,
              title: 'Section 3 — Replacing',
              color: Colors.deepOrangeAccent,
              icon: Icons.swap_vert_circle_rounded,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: const Icon(Icons.circle_outlined, size: 16),
                title: Text('Item ${index + 1} in Section 3'),
              ),
              childCount: 15,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class _CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final String title;
  final Color color;
  final IconData icon;

  _CustomHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.title,
    required this.color,
    required this.icon,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final diff = maxHeight - minHeight;
    final progress = diff == 0 ? 0.0 : (shrinkOffset / diff).clamp(0.0, 1.0);

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: overlapsContent ? 4 : 0,
      shadowColor: color.withValues(alpha: 0.4),
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.25),
          border: Border(
            bottom: BorderSide(color: color.withValues(alpha: 0.5), width: 1.5),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background icon fades away as it shrinks
            Opacity(
              opacity: (1 - progress).clamp(0.0, 1.0),
              child: Center(
                child: Icon(
                  icon,
                  size: 64,
                  color: color.withValues(alpha: 0.4),
                ),
              ),
            ),
            // Title animates down-right to a toolbar-like position
            Positioned(
              left: 16,
              bottom: 12 + (progress * 4).clamp(0.0, 16.0),
              child: Row(
                children: [
                  Icon(icon, color: color, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 20.0 - (progress * 4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_CustomHeaderDelegate old) =>
      maxHeight != old.maxHeight ||
      minHeight != old.minHeight ||
      title != old.title ||
      color != old.color ||
      icon != old.icon;
}
