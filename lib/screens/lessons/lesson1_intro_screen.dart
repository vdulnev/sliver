import 'package:flutter/material.dart';
import '../../widgets/info_box.dart';

class Lesson1IntroScreen extends StatelessWidget {
  const Lesson1IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Intro to Slivers')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'What are Slivers?',
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
                'A sliver is a portion of a scrollable area. Under the hood, all the scrollable widgets you use—like ListView and GridView—are implemented using slivers.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: InfoBox(
              type: InfoBoxType.info,
              title: 'Sliver Rendering Pipeline',
              body:
                  'Slivers communicate with the scroll system through the SliverConstraints → SliverGeometry protocol. This allows each sliver to report exactly how much space it occupies and how it should paint, enabling very efficient lazy rendering.',
            ),
          ),

          // SliverConstraints → SliverGeometry section
          SliverToBoxAdapter(
            child: LessonSectionTitle('SliverConstraints → SliverGeometry'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Every frame, the viewport calls performLayout() on each sliver and passes a SliverConstraints object. The sliver must respond by setting its geometry to a SliverGeometry object. This two-way handshake is the entire protocol.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: CodeBlock(
              '// Inside a RenderSliver subclass:\n'
              '@override\n'
              'void performLayout() {\n'
              '  final c = constraints; // SliverConstraints from the viewport\n'
              '\n'
              '  // ... compute your layout ...\n'
              '\n'
              '  geometry = SliverGeometry(  // tell the viewport what you need\n'
              '    scrollExtent:  myTotalHeight,\n'
              '    paintExtent:   clampDouble(myTotalHeight - c.scrollOffset,\n'
              '                              0, c.remainingPaintExtent),\n'
              '    maxPaintExtent: myTotalHeight,\n'
              '  );\n'
              '}',
            ),
          ),

          // SliverConstraints fields
          SliverToBoxAdapter(child: LessonSectionTitle('SliverConstraints')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'The viewport tells each sliver where it currently sits and how much room it has. Key fields:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'scrollOffset',
              type: 'double',
              description:
                  'How many logical pixels of this sliver have scrolled off the top (or left) of the viewport. Starts at 0, grows as the user scrolls past the sliver.',
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'overlap',
              type: 'double',
              description:
                  'Pixels by which preceding slivers (e.g. a pinned SliverAppBar) overlap the start of this sliver. Use it to shift your own content down so it is not hidden.',
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'remainingPaintExtent',
              type: 'double',
              description:
                  'Pixels of paint area still available below/after this sliver inside the viewport. Cap your paintExtent to this value.',
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'crossAxisExtent',
              type: 'double',
              description:
                  'Width of the viewport (for vertical scroll) or height (for horizontal scroll). Use this as the cross-axis size when laying out children.',
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'viewportMainAxisExtent',
              type: 'double',
              description:
                  'Full size of the viewport in the scroll direction. Useful for slivers like SliverFillViewport that need to know the total screen height.',
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'remainingCacheExtent',
              type: 'double',
              description:
                  'Extra pixels beyond the visible area in which children should still be built (pre-loading buffer). Always ≥ remainingPaintExtent.',
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'cacheOrigin',
              type: 'double',
              description:
                  'A negative offset (≤ 0) indicating how far before the visible area the cache starts. Build children from scrollOffset + cacheOrigin.',
            ),
          ),

          // SliverGeometry fields
          SliverToBoxAdapter(child: LessonSectionTitle('SliverGeometry')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'The sliver reports back to the viewport via SliverGeometry. Every field has a sensible default, so you only set what you need:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'scrollExtent',
              type: 'double',
              description:
                  'Total scroll height (or width) of this sliver — the amount the scroll position must advance to move past it entirely.',
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'paintExtent',
              type: 'double',
              description:
                  'How many pixels of the sliver are currently painted on screen. Must be ≤ remainingPaintExtent. The viewport advances its paint cursor by this amount.',
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'paintOrigin',
              type: 'double  (default 0)',
              description:
                  'Where painting starts relative to the sliver\'s layout position. A negative value lets a sliver paint into the overlap area (used by SliverAppBar stretch).',
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'layoutExtent',
              type: 'double  (default = paintExtent)',
              description:
                  'How much of remainingPaintExtent is consumed for layout purposes. Usually equals paintExtent; set it lower to let the sliver paint beyond its layout footprint (pinned headers use this).',
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'maxPaintExtent',
              type: 'double',
              description:
                  'The maximum paintExtent this sliver could ever have (i.e. its full height). Lets the viewport calculate the total scrollable range correctly.',
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'hitTestExtent',
              type: 'double  (default = paintExtent)',
              description:
                  'Depth of the hit-test region. Increase it if your sliver paints further than paintExtent (rare), decrease it to make part of the sliver ignore touches.',
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'visible',
              type: 'bool  (default: paintExtent > 0)',
              description:
                  'Whether the sliver should be included in the paint pass. Setting it to false skips painting entirely, which is a cheap culling mechanism.',
            ),
          ),
          const SliverToBoxAdapter(
            child: _ConstraintField(
              name: 'scrollOffsetCorrection',
              type: 'double?  (default null)',
              description:
                  'When non-null, tells the viewport to shift the scroll offset by this amount and redo layout. Used when content is inserted/removed above the current scroll position.',
            ),
          ),

          // Protocol flow diagram
          SliverToBoxAdapter(
            child: LessonSectionTitle('Protocol Flow'),
          ),
          const SliverToBoxAdapter(
            child: CodeBlock(
              'Viewport\n'
              '  │\n'
              '  │  SliverConstraints ──────────────────────────────►\n'
              '  │  { scrollOffset, overlap, remainingPaintExtent,\n'
              '  │    crossAxisExtent, viewportMainAxisExtent, ... }\n'
              '  │\n'
              '  │                                          RenderSliver\n'
              '  │                                     performLayout() {\n'
              '  │                                       // lay out children\n'
              '  │                                       // compute extents\n'
              '  │                                       geometry = SliverGeometry(...)\n'
              '  │                                     }\n'
              '  │\n'
              '  │  ◄─────────────────────────────── SliverGeometry\n'
              '  │  { scrollExtent, paintExtent,\n'
              '  │    layoutExtent, maxPaintExtent, ... }\n'
              '  │\n'
              '  │  Advance paint cursor by layoutExtent\n'
              '  │  Advance scroll cursor by scrollExtent\n'
              '  ▼\n'
              '  Next sliver',
            ),
          ),
          const SliverToBoxAdapter(
            child: InfoBox(
              type: InfoBoxType.warning,
              title: 'paintExtent ≤ remainingPaintExtent',
              body:
                  'Flutter asserts this in debug mode. If your sliver returns a paintExtent larger than remainingPaintExtent you will get a red-screen layout error. Always clamp: paintExtent = clampDouble(computed, 0, constraints.remainingPaintExtent).',
            ),
          ),
          const SliverToBoxAdapter(
            child: InfoBox(
              type: InfoBoxType.tip,
              title: 'SliverGeometry.zero',
              body:
                  'Return SliverGeometry.zero when a sliver is completely scrolled off screen and has no more content to show. All extents are 0 and visible is false — the cheapest possible geometry.',
            ),
          ),

          // CustomScrollView section
          SliverToBoxAdapter(child: LessonSectionTitle('CustomScrollView')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'To use slivers directly you need a CustomScrollView. It takes a list of slivers and scrolls them all together as one unified scroll area.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: CodeBlock(
              'CustomScrollView(\n'
              '  slivers: [\n'
              '    SliverAppBar(...),\n'
              '    SliverList(...),\n'
              '    SliverGrid(...),\n'
              '  ],\n'
              ')',
            ),
          ),

          // SliverToBoxAdapter section
          SliverToBoxAdapter(child: LessonSectionTitle('SliverToBoxAdapter')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Wraps a single normal (box) widget so it can live inside a CustomScrollView. Think of it as the bridge between the sliver world and the regular widget world.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: InfoBox(
              type: InfoBoxType.tip,
              title: 'Tip: Don\'t nest scrollables',
              body:
                  'Putting a ListView inside a SliverToBoxAdapter will cause layout errors unless you give the inner list a fixed height. Instead, convert it to a SliverList directly.',
            ),
          ),
          const SliverToBoxAdapter(
            child: CodeBlock(
              'SliverToBoxAdapter(\n'
              '  child: MyWidget(), // any regular widget\n'
              ')',
            ),
          ),

          // Live demo section
          SliverToBoxAdapter(
            child: LessonSectionTitle(
              'Live Demo — 3 widgets via SliverToBoxAdapter',
            ),
          ),

          _demoBox(
            context,
            label: 'Widget A',
            sublabel: 'SliverToBoxAdapter',
            height: 100,
            color: Colors.blueAccent,
            icon: Icons.widgets_outlined,
          ),
          _demoBox(
            context,
            label: 'Widget B',
            sublabel: 'SliverToBoxAdapter',
            height: 150,
            color: Colors.greenAccent,
            icon: Icons.dashboard_outlined,
          ),
          _demoBox(
            context,
            label: 'Widget C',
            sublabel: 'SliverToBoxAdapter',
            height: 180,
            color: Colors.orangeAccent,
            icon: Icons.image_outlined,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _demoBox(
    BuildContext context, {
    required String label,
    required String sublabel,
    required double height,
    required Color color,
    required IconData icon,
  }) {
    return SliverToBoxAdapter(
      child: Container(
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    sublabel,
                    style: TextStyle(
                      color: color.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single row in the SliverConstraints / SliverGeometry field reference.
class _ConstraintField extends StatelessWidget {
  final String name;
  final String type;
  final String description;

  const _ConstraintField({
    required this.name,
    required this.type,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF80CBC4),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                type,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: colorScheme.onSurface.withValues(alpha: 0.45),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(description, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
