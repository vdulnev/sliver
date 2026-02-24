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
