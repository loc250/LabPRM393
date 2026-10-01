import 'package:flutter/material.dart';
import 'core_widgets_demo.dart';
import 'input_controls_demo.dart';
import 'layout_basics_demo.dart';
import 'scaffold_theme_demo.dart';
import 'ui_errors_demo.dart';

void main() {
  runApp(const Lab4App());
}

class Lab4App extends StatefulWidget {
  const Lab4App({super.key});

  @override
  State<Lab4App> createState() => _Lab4AppState();
}

class _Lab4AppState extends State<Lab4App> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Flutter UI Fundamentals',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      home: Lab4HomeScreen(
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class Lab4HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onToggleTheme;

  const Lab4HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final exercises = [
      {
        'title': 'Exercise 1: Core Widgets',
        'subtitle': 'Text, Material Icon, Image.network, Card & ListTile',
        'icon': Icons.widgets_outlined,
        'color': Colors.blue,
        'screen': const CoreWidgetsDemo(),
      },
      {
        'title': 'Exercise 2: Input Controls',
        'subtitle': 'Slider, Switch, RadioListTile, and DatePicker',
        'icon': Icons.tune,
        'color': Colors.green,
        'screen': const InputControlsDemo(),
      },
      {
        'title': 'Exercise 3: Layout Basics',
        'subtitle': 'Column, Row, consistent Padding & ListView.builder',
        'icon': Icons.view_quilt_outlined,
        'color': Colors.orange,
        'screen': const LayoutBasicsDemo(),
      },
      {
        'title': 'Exercise 4: Scaffold & Theme',
        'subtitle': 'Scaffold structure, AppBar, FAB & Dark Mode toggle',
        'icon': Icons.palette_outlined,
        'color': Colors.purple,
        'screen': ScaffoldThemeDemo(
          isDarkMode: isDarkMode,
          onThemeChanged: onToggleTheme,
        ),
      },
      {
        'title': 'Exercise 5: Debug UI Errors',
        'subtitle': 'Fixing Unbounded Height, Overflows, setState, DatePicker',
        'icon': Icons.bug_report_outlined,
        'color': Colors.red,
        'screen': const UIErrorsDemo(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4: Flutter UI Fundamentals'),
        actions: [
          IconButton(
            tooltip: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => onToggleTheme(!isDarkMode),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final item = exercises[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                backgroundColor:
                    (item['color'] as Color).withValues(alpha: 0.15),
                child: Icon(
                  item['icon'] as IconData,
                  color: item['color'] as Color,
                ),
              ),
              title: Text(
                item['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(item['subtitle'] as String),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => item['screen'] as Widget,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
