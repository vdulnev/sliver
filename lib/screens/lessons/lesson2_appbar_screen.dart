import 'package:flutter/material.dart';

class Lesson2AppBarScreen extends StatefulWidget {
  const Lesson2AppBarScreen({super.key});

  @override
  State<Lesson2AppBarScreen> createState() => _Lesson2AppBarScreenState();
}

class _Lesson2AppBarScreenState extends State<Lesson2AppBarScreen> {
  bool _pinned = true;
  bool _floating = false;
  bool _snap = false;
  bool _stretch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics:
            const BouncingScrollPhysics(), // Allows stretch to work smoothly
        slivers: [
          SliverAppBar(
            pinned: _pinned,
            floating: _floating,
            snap: _snap,
            stretch: _stretch,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('SliverAppBar Demo'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.pinkAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.settings_overscan,
                    size: 80,
                    color: Colors.white54,
                  ),
                ),
              ),
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Interactive Toggles',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Pinned Toggle
                  SwitchListTile(
                    title: const Text('Pinned'),
                    subtitle: const Text(
                      'Keeps the app bar visible at the top even when scrolled down.',
                    ),
                    value: _pinned,
                    onChanged: (bool value) {
                      setState(() {
                        _pinned = value;
                      });
                    },
                  ),

                  // Floating Toggle
                  SwitchListTile(
                    title: const Text('Floating'),
                    subtitle: const Text(
                      'App bar becomes visible immediately when the user scrolls up, not waiting for the top.',
                    ),
                    value: _floating,
                    onChanged: (bool value) {
                      setState(() {
                        _floating = value;
                        // Snap only works if floating is true
                        if (!value) _snap = false;
                      });
                    },
                  ),

                  // Snap Toggle
                  SwitchListTile(
                    title: const Text('Snap'),
                    subtitle: const Text(
                      'If floating, the app bar fully snaps into view/out of view when the user stops scrolling.',
                    ),
                    value: _snap,
                    onChanged: _floating
                        ? (bool value) {
                            setState(() {
                              _snap = value;
                            });
                          }
                        : null,
                  ),

                  // Stretch Toggle
                  SwitchListTile(
                    title: const Text('Stretch'),
                    subtitle: const Text(
                      'Allows the flexible space to expand further when over-scrolling at the top.',
                    ),
                    value: _stretch,
                    onChanged: (bool value) {
                      setState(() {
                        _stretch = value;
                      });
                    },
                  ),

                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 16),

                  Text(
                    'Scroll down to see the behavior!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),

          // Generating some list items to allow scrolling
          SliverList(
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text('Dummy Item ${index + 1}'),
                subtitle: const Text('Just filling space to allow scrolling'),
              );
            }, childCount: 30),
          ),
        ],
      ),
    );
  }
}
