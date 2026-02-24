import '../models/lesson.dart';

const List<Lesson> courseLessons = [
  Lesson(
    title: 'Lesson 1: Intro to Slivers',
    description: 'Learn the basics of CustomScrollView and SliverToBoxAdapter.',
    routeName: '/lesson1',
  ),
  Lesson(
    title: 'Lesson 2: SliverAppBar',
    description:
        'Explore pinning, floating, snapping, and stretching app bars.',
    routeName: '/lesson2',
  ),
  Lesson(
    title: 'Lesson 3: SliverList & SliverGrid',
    description: 'Efficiently scroll through large lists and grids of items.',
    routeName: '/lesson3',
  ),
  Lesson(
    title: 'Lesson 4: SliverPersistentHeader',
    description: 'Create custom sticky and floating section headers.',
    routeName: '/lesson4',
  ),
  Lesson(
    title: 'Lesson 5: SliverFillRemaining',
    description:
        'Pin content to the bottom of the screen — great for forms and empty states.',
    routeName: '/lesson5',
  ),
  Lesson(
    title: 'Lesson 6: SliverFillViewport',
    description:
        'Create full-viewport page-like slides that fill the entire screen.',
    routeName: '/lesson6',
  ),
  Lesson(
    title: 'Lesson 7: Capstone — Product Catalog',
    description:
        'A real-world catalog combining all slivers: AppBar, headers, grid, and fill.',
    routeName: '/lesson7',
  ),
];
