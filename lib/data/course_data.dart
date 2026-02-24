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
    description: 'Create custom sticky headers within your scroll views.',
    routeName: '/lesson4',
  ),
];
