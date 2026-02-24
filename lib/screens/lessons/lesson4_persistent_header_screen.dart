import 'package:flutter/material.dart';

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
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Sticky Headers',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: _CustomHeaderDelegate(
              minHeight: 60,
              maxHeight: 150,
              title: 'Section 1 (Pinned)',
              color: Colors.blueAccent,
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return ListTile(title: Text('Item $index in Section 1'));
            }, childCount: 10),
          ),

          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: _CustomHeaderDelegate(
              minHeight: 60,
              maxHeight: 120,
              title: 'Section 2 (Floating)',
              color: Colors.greenAccent,
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return ListTile(title: Text('Item $index in Section 2'));
            }, childCount: 20),
          ),
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

  _CustomHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.title,
    required this.color,
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
    // Calculate how much it's shrunk from 0.0 to 1.0
    final diff = maxHeight - minHeight;
    final progress = diff == 0 ? 0.0 : (shrinkOffset / diff).clamp(0.0, 1.0);

    return Container(
      color: color,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background that fades out as you scroll
          Opacity(
            opacity: 1 - progress,
            child: const Center(
              child: Icon(Icons.image, size: 80, color: Colors.white54),
            ),
          ),
          // Title that moves based on scroll progress
          Positioned(
            left: 16.0,
            bottom: 16.0 + (progress * 20), // Moves up slightly as it shrinks
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0 - (progress * 6), // Gets smaller
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_CustomHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        title != oldDelegate.title ||
        color != oldDelegate.color;
  }
}
