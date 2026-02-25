import 'package:flutter/material.dart';
import '../../widgets/info_box.dart';

class Lesson3ListGridScreen extends StatefulWidget {
  const Lesson3ListGridScreen({super.key});

  @override
  State<Lesson3ListGridScreen> createState() => _Lesson3ListGridScreenState();
}

class _Lesson3ListGridScreenState extends State<Lesson3ListGridScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SliverList & SliverGrid'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.list), text: 'List'),
            Tab(icon: Icon(Icons.grid_view), text: 'Grid'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildListTab(), _buildGridTab()],
      ),
    );
  }

  Widget _buildListTab() {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: LessonSectionTitle(
            'SliverList',
            padding: EdgeInsets.fromLTRB(16, 20, 16, 4),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'SliverList renders items lazily — only the items visible on screen are built. It uses a delegate to describe the items.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: InfoBox(
            type: InfoBoxType.tip,
            title: 'SliverChildBuilderDelegate vs SliverChildListDelegate',
            body:
                'Use Builder for large or infinite lists (lazy). Use List only for a small, known set of widgets (eager).',
          ),
        ),
        const SliverToBoxAdapter(
          child: CodeBlock(
            'SliverList(\n'
            '  delegate: SliverChildBuilderDelegate(\n'
            '    (context, index) => ListTile(...),\n'
            '    childCount: 100,\n'
            '  ),\n'
            ')',
          ),
        ),
        const SliverToBoxAdapter(
          child: LessonSectionTitle('Live Demo — 10 items'),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final colors = [
              Colors.deepPurple,
              Colors.indigo,
              Colors.blue,
              Colors.teal,
              Colors.green,
            ];
            final color = colors[index % colors.length];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.25),
                  child: Text('${index + 1}', style: TextStyle(color: color)),
                ),
                title: Text('List Item ${index + 1}'),
                subtitle: const Text('Built lazily with SliverList'),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            );
          }, childCount: 10),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }

  Widget _buildGridTab() {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: LessonSectionTitle(
            'SliverGrid',
            padding: EdgeInsets.fromLTRB(16, 20, 16, 4),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'SliverGrid uses a SliverGridDelegate to control the layout. Two built-in delegates cover most use cases.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: InfoBox(
            type: InfoBoxType.info,
            title: 'Two Grid Delegates',
            body:
                '• SliverGridDelegateWithFixedCrossAxisCount — fixed number of columns.\n'
                '• SliverGridDelegateWithMaxCrossAxisExtent — fixed max item width, auto-calculates columns.',
          ),
        ),
        // Fixed columns grid
        const SliverToBoxAdapter(
          child: LessonSectionTitle('Fixed columns (crossAxisCount: 3)'),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.1,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _gridCell(index, Colors.primaries),
              childCount: 9,
            ),
          ),
        ),
        // MaxCrossAxisExtent grid
        const SliverToBoxAdapter(
          child: LessonSectionTitle('Max extent (maxCrossAxisExtent: 160)'),
        ),
        const SliverToBoxAdapter(
          child: InfoBox(
            type: InfoBoxType.tip,
            title: 'Responsive by default',
            body:
                'MaxCrossAxisExtent automatically fits as many columns as possible within the given max width — great for responsive layouts.',
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.3,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _gridCell(index, Colors.accents),
              childCount: 20,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }

  Widget _gridCell(int index, List<Color> colorList) {
    final color = colorList[index % colorList.length];
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
