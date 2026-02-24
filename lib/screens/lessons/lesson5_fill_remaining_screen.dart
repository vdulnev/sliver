import 'package:flutter/material.dart';
import '../../widgets/info_box.dart';

class Lesson5FillRemainingScreen extends StatefulWidget {
  const Lesson5FillRemainingScreen({super.key});

  @override
  State<Lesson5FillRemainingScreen> createState() =>
      _Lesson5FillRemainingScreenState();
}

class _Lesson5FillRemainingScreenState
    extends State<Lesson5FillRemainingScreen> {
  bool _hasScrollBody = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SliverFillRemaining'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                Text(
                  'hasScrollBody',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Switch(
                  value: _hasScrollBody,
                  onChanged: (v) => setState(() => _hasScrollBody = v),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Explanation section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SliverFillRemaining',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Makes the last sliver fill all remaining space in the viewport. Perfect for: empty states, sign-in pages, or any screen where content should anchor to the bottom.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const InfoBox(
                  type: InfoBoxType.info,
                  title: 'hasScrollBody',
                  body:
                      '• false (default): the content is sized to exactly fill the remaining space — it won\'t scroll.\n'
                      '• true: the child can scroll independently within the remaining space.',
                ),
                const CodeBlock(
                  'SliverFillRemaining(\n'
                  '  hasScrollBody: false, // child fills exact space\n'
                  '  child: MyWidget(),\n'
                  ')',
                ),
              ],
            ),
          ),

          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  'Live Demo — hasScrollBody: ',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  _hasScrollBody ? 'true' : 'false',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _hasScrollBody
                        ? colorScheme.primary
                        : colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),

          // The live demo
          Expanded(
            child: CustomScrollView(
              slivers: [
                // A short piece of content at the top
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          size: 48,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Sign in to continue',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                // SliverFillRemaining holds a sign-in form
                SliverFillRemaining(
                  hasScrollBody: _hasScrollBody,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Anchored to the bottom by spaceBetween
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.login_rounded),
                                label: const Text('Sign In'),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Create an account'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
