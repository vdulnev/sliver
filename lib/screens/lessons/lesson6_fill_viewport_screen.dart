import 'package:flutter/material.dart';
import '../../widgets/info_box.dart';

class Lesson6FillViewportScreen extends StatelessWidget {
  const Lesson6FillViewportScreen({super.key});

  static const _slides = [
    _SlideData(
      title: 'Slide the World',
      subtitle: 'Each child fills the entire viewport height',
      icon: Icons.view_carousel_outlined,
      colors: [Color(0xFF6A1B9A), Color(0xFF283593)],
    ),
    _SlideData(
      title: 'Like a PageView',
      subtitle:
          'SliverFillViewport creates a vertical pager inside CustomScrollView',
      icon: Icons.arrow_downward_rounded,
      colors: [Color(0xFF00695C), Color(0xFF004D40)],
    ),
    _SlideData(
      title: 'Mix & Match',
      subtitle: 'Combine with other slivers before and after',
      icon: Icons.layers_rounded,
      colors: [Color(0xFFAD1457), Color(0xFF880E4F)],
    ),
    _SlideData(
      title: 'viewport­Fraction',
      subtitle: 'Set viewportFraction < 1.0 to peek at adjacent slides',
      icon: Icons.compare_rounded,
      colors: [Color(0xFFE65100), Color(0xFFBF360C)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SliverFillViewport')),
      body: CustomScrollView(
        slivers: [
          // Explanation at the top
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
              child: Text(
                'SliverFillViewport',
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
                'Each child in a SliverFillViewport takes up exactly one full viewport height. Scroll down to reveal the next "page".',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: InfoBox(
              type: InfoBoxType.info,
              title: 'viewportFraction',
              body:
                  'The fraction of the viewport each child should occupy. Defaults to 1.0 (full screen). Set to 0.85 to see a peek of the next slide.',
            ),
          ),
          const SliverToBoxAdapter(
            child: CodeBlock(
              'SliverFillViewport(\n'
              '  viewportFraction: 1.0,\n'
              '  delegate: SliverChildBuilderDelegate(\n'
              '    (context, index) => MyPage(),\n'
              '    childCount: 4,\n'
              '  ),\n'
              ')',
            ),
          ),
          const SliverToBoxAdapter(
            child: InfoBox(
              type: InfoBoxType.tip,
              title: 'Scroll down to see the slides',
              body:
                  'The 4 slides below each fill 100% of the viewport. '
                  'Scroll past the explanation above to enter "page mode".',
            ),
          ),

          // The viewport-filling slides
          SliverFillViewport(
            delegate: SliverChildBuilderDelegate((context, index) {
              final slide = _slides[index];
              return _buildSlide(context, slide, index, _slides.length);
            }, childCount: _slides.length),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide(
    BuildContext context,
    _SlideData slide,
    int index,
    int total,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: slide.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Decorative circle
          Positioned(
            right: -60,
            top: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            left: -80,
            bottom: -40,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
          ),

          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(slide.icon, size: 80, color: Colors.white70),
                  const SizedBox(height: 32),
                  Text(
                    slide.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    slide.subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Page indicator dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(total, (i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: i == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == index
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideData {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;

  const _SlideData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
  });
}
