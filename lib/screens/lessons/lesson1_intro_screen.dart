import 'package:flutter/material.dart';

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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What are Slivers?',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'A sliver is just a portion of a scrollable area. Under the hood, all of the scrollable views you use, like ListView and GridView, are actually implemented using slivers.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'CustomScrollView',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'To use slivers directly, you need a CustomScrollView. It takes a list of slivers and scrolls them together.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'SliverToBoxAdapter',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A sliver that contains a single box widget. It lets you put normal widgets (like a Container or Text) directly inside a CustomScrollView.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'Example Dashboard (Using SliverToBoxAdapter):',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Using SliverToBoxAdapter for individual components
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text('Normal Widget 1 inside Sliver To Box Adapter'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text('Normal Widget 2 inside Sliver To Box Adapter'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orangeAccent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text('Normal Widget 3 inside Sliver To Box Adapter'),
              ),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 40)),
        ],
      ),
    );
  }
}
