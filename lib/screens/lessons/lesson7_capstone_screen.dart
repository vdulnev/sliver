import 'package:flutter/material.dart';
import '../../widgets/info_box.dart';

// Sample product data model
class _Product {
  final String name;
  final String price;
  final String category;
  final IconData icon;
  final Color color;

  const _Product({
    required this.name,
    required this.price,
    required this.category,
    required this.icon,
    required this.color,
  });
}

const _categories = ['All', 'Audio', 'Photo', 'Wearables', 'Computing'];

const _products = [
  _Product(
    name: 'Wireless Headphones',
    price: '\$129',
    category: 'Audio',
    icon: Icons.headphones_rounded,
    color: Colors.deepPurple,
  ),
  _Product(
    name: 'Studio Speaker',
    price: '\$299',
    category: 'Audio',
    icon: Icons.speaker_rounded,
    color: Colors.indigo,
  ),
  _Product(
    name: 'Mirrorless Camera',
    price: '\$899',
    category: 'Photo',
    icon: Icons.camera_alt_rounded,
    color: Colors.teal,
  ),
  _Product(
    name: 'Prime Lens 50mm',
    price: '\$349',
    category: 'Photo',
    icon: Icons.lens_rounded,
    color: Colors.cyan,
  ),
  _Product(
    name: 'Smart Watch',
    price: '\$249',
    category: 'Wearables',
    icon: Icons.watch_rounded,
    color: Colors.orange,
  ),
  _Product(
    name: 'Fitness Band',
    price: '\$79',
    category: 'Wearables',
    icon: Icons.fitness_center_rounded,
    color: Colors.amber,
  ),
  _Product(
    name: 'Laptop Pro',
    price: '\$1499',
    category: 'Computing',
    icon: Icons.laptop_mac_rounded,
    color: Colors.blue,
  ),
  _Product(
    name: 'Mechanical Keyboard',
    price: '\$159',
    category: 'Computing',
    icon: Icons.keyboard_rounded,
    color: Colors.blueGrey,
  ),
  _Product(
    name: 'Noise Cancelling Buds',
    price: '\$199',
    category: 'Audio',
    icon: Icons.earbuds_rounded,
    color: Colors.pink,
  ),
  _Product(
    name: 'Action Camera',
    price: '\$449',
    category: 'Photo',
    icon: Icons.videocam_rounded,
    color: Colors.green,
  ),
  _Product(
    name: 'Smart Ring',
    price: '\$199',
    category: 'Wearables',
    icon: Icons.circle_outlined,
    color: Colors.red,
  ),
  _Product(
    name: 'Drawing Tablet',
    price: '\$389',
    category: 'Computing',
    icon: Icons.draw_rounded,
    color: Colors.purple,
  ),
];

class Lesson7CapstoneCatalogScreen extends StatefulWidget {
  const Lesson7CapstoneCatalogScreen({super.key});

  @override
  State<Lesson7CapstoneCatalogScreen> createState() =>
      _Lesson7CapstoneCatalogScreenState();
}

class _Lesson7CapstoneCatalogScreenState
    extends State<Lesson7CapstoneCatalogScreen> {
  String _selectedCategory = 'All';
  bool _showingInfo = true;

  List<_Product> get _filtered => _selectedCategory == 'All'
      ? _products
      : _products.where((p) => p.category == _selectedCategory).toList();

  // Group products by category for the sticky headers
  Map<String, List<_Product>> get _grouped {
    if (_selectedCategory != 'All') {
      return {_selectedCategory: _filtered};
    }
    final map = <String, List<_Product>>{};
    for (final p in _products) {
      map[p.category] = [...(map[p.category] ?? []), p];
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final grouped = _grouped;

    // Build a flat sliver list from the grouped map
    final slivers = <Widget>[
      // Collapsing hero app bar
      SliverAppBar(
        expandedHeight: 200,
        pinned: true,
        stretch: true,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
          title: const Text(
            'Tech Catalog',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -40,
                  top: -20,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.07),
                    ),
                  ),
                ),
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Icon(
                        Icons.storefront_rounded,
                        size: 60,
                        color: Colors.white60,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Capstone: All Slivers Combined',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          stretchModes: const [
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
          ],
        ),
      ),

      // Info panel toggle
      if (_showingInfo)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: InfoBox(
              type: InfoBoxType.example,
              title: 'Capstone: Slivers Used Here',
              body:
                  '• SliverAppBar (pinned + stretch)\n'
                  '• SliverPersistentHeader (sticky category headers)\n'
                  '• SliverGrid (product cards)\n'
                  '• SliverFillRemaining ("Load More" footer)',
            ),
          ),
        ),

      // Dismiss info button
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              if (_showingInfo)
                TextButton.icon(
                  onPressed: () => setState(() => _showingInfo = false),
                  icon: const Icon(Icons.close, size: 16),
                  label: const Text('Hide tips'),
                ),
              const Spacer(),
              Text(
                '${_filtered.length} products',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),

      // Category filter chips — SliverToBoxAdapter with horizontal scroll
      SliverToBoxAdapter(
        child: SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final cat = _categories[i];
              final isSelected = _selectedCategory == cat;
              return FilterChip(
                label: Text(cat),
                selected: isSelected,
                onSelected: (_) => setState(() => _selectedCategory = cat),
              );
            },
          ),
        ),
      ),
    ];

    // Add sticky header + SliverGrid for each category
    for (final entry in grouped.entries) {
      slivers.add(
        SliverPersistentHeader(
          pinned: true,
          delegate: _CategoryHeaderDelegate(
            category: entry.key,
            count: entry.value.length,
          ),
        ),
      );
      slivers.add(
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.85,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _ProductCard(product: entry.value[index]),
              childCount: entry.value.length,
            ),
          ),
        ),
      );
    }

    // SliverFillRemaining for the "Load More" footer
    slivers.add(
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_download_outlined,
                size: 40,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                'All products loaded!',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'This area is a SliverFillRemaining — it fills whatever space is left.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Refresh Catalog'),
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(body: CustomScrollView(slivers: slivers));
  }
}

class _CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String category;
  final int count;

  _CategoryHeaderDelegate({required this.category, required this.count});

  @override
  double get minExtent => 44;

  @override
  double get maxExtent => 44;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(
            category,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_CategoryHeaderDelegate old) =>
      category != old.category || count != old.count;
}

class _ProductCard extends StatelessWidget {
  final _Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon area
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: product.color.withValues(alpha: 0.15),
                ),
                child: Center(
                  child: Icon(product.icon, size: 44, color: product.color),
                ),
              ),
            ),
            // Info area
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      product.price,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: product.color,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
