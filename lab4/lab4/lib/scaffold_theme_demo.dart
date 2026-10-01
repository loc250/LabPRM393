import 'package:flutter/material.dart';

/// Exercise 4 – App Structure with Scaffold, AppBar, FAB & Theme
/// Full screen architecture utilizing Scaffold, custom ThemeData, and Dark Mode toggle.
class ScaffoldThemeDemo extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool>? onThemeChanged;

  const ScaffoldThemeDemo({
    super.key,
    this.isDarkMode = false,
    this.onThemeChanged,
  });

  @override
  State<ScaffoldThemeDemo> createState() => _ScaffoldThemeDemoState();
}

class _ScaffoldThemeDemoState extends State<ScaffoldThemeDemo> {
  late bool _isDark;
  int _tapCount = 0;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDarkMode;
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDark = value;
    });
    widget.onThemeChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    // Local theme definition for demonstration of ThemeData customization
    final ThemeData customTheme = _isDark
        ? ThemeData.dark(useMaterial3: true).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              elevation: 4,
            ),
          )
        : ThemeData.light(useMaterial3: true).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              elevation: 4,
            ),
          );

    return Theme(
      data: customTheme,
      child: Builder(
        builder: (context) {
          final isCurrentDark = Theme.of(context).brightness == Brightness.dark;
          return Scaffold(
            // 1. AppBar with Title and Theme toggle action
            appBar: AppBar(
              title: const Text('Exercise 4 - Scaffold & Theme'),
              actions: [
                IconButton(
                  tooltip: 'Toggle Theme',
                  icon: Icon(isCurrentDark ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () => _toggleDarkMode(!_isDark),
                ),
              ],
            ),

            // 2. Body with structure demonstration
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isCurrentDark
                                    ? Icons.nightlight_round
                                    : Icons.wb_sunny,
                                color: Theme.of(context).colorScheme.primary,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                isCurrentDark ? 'Dark Theme Active' : 'Light Theme Active',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'This screen demonstrates Scaffold components (AppBar, Body, FAB) '
                            'and dynamic ThemeData switching using ThemeMode.',
                          ),
                          const Divider(height: 24),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Enable Dark Mode'),
                            subtitle: const Text('Switches between light and dark ThemeData'),
                            value: _isDark,
                            onChanged: _toggleDarkMode,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FAB Interaction Counter',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'FAB clicked: $_tapCount time(s)',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 3. FloatingActionButton
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  _tapCount++;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('FAB pressed! Current count: $_tapCount'),
                    duration: const Duration(milliseconds: 1500),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Increment'),
              tooltip: 'FloatingActionButton Demo',
            ),
          );
        },
      ),
    );
  }
}
