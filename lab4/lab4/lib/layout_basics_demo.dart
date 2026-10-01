import 'package:flutter/material.dart';

/// Exercise 3 – Layout Basics: Column, Row, Padding, ListView
/// Sectioned Home Screen layout using core Flutter layout widgets and consistent spacing.
class LayoutBasicsDemo extends StatelessWidget {
  const LayoutBasicsDemo({super.key});

  final List<Map<String, String>> _movies = const [
    {
      'title': 'Inception',
      'genre': 'Sci-Fi / Action',
      'rating': '8.8',
      'year': '2010',
    },
    {
      'title': 'Interstellar',
      'genre': 'Sci-Fi / Adventure',
      'rating': '8.7',
      'year': '2014',
    },
    {
      'title': 'The Dark Knight',
      'genre': 'Action / Crime',
      'rating': '9.0',
      'year': '2008',
    },
    {
      'title': 'Avengers: Endgame',
      'genre': 'Action / Sci-Fi',
      'rating': '8.4',
      'year': '2019',
    },
    {
      'title': 'Parasite',
      'genre': 'Drama / Thriller',
      'rating': '8.5',
      'year': '2019',
    },
  ];

  final List<String> _categories = const [
    'All',
    'Action',
    'Comedy',
    'Drama',
    'Sci-Fi',
    'Horror',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 - Layout Basics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16), // Consistent 16px outer padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Welcome Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to CineStream',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Discover and track your favorite movies today.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16), // Consistent 16px vertical spacing

            // Section 2: Quick Stats Row
            Row(
              children: [
                _buildStatCard(context, 'Total Movies', '120+', Icons.movie_filter),
                const SizedBox(width: 12), // Consistent 12px horizontal spacing
                _buildStatCard(context, 'Watchlist', '15', Icons.bookmark),
                const SizedBox(width: 12),
                _buildStatCard(context, 'Favorites', '8', Icons.favorite),
              ],
            ),

            const SizedBox(height: 16),

            // Section 3: Categories Row (horizontal scrolling)
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = index == 0;
                  return Chip(
                    label: Text(_categories[index]),
                    backgroundColor: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceContainerHighest,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : null,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Section 4: Movie List Section (ListView.builder)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Featured Movies',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_movies.length} items',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // ListView.builder embedded inside Column
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      child: Text(
                        movie['rating']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    title: Text(
                      movie['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${movie['genre']} • ${movie['year']}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected: ${movie['title']}'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      BuildContext context, String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
