import 'package:flutter/material.dart';
import 'movie.dart';
import 'movie_detail_screen.dart';
import 'sample_data.dart';

void main() {
  runApp(const MovieDetailApp());
}

/// Root widget of the application
class MovieDetailApp extends StatelessWidget {
  const MovieDetailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Explorer',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const MovieHomeScreen(),
    );
  }
}

/// Home Screen displaying a scrollable list of movies with search and favorites filter
class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({super.key});

  @override
  State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen> {
  // Static list loaded from sample_data.dart
  final List<Movie> _movies = sampleMovies;

  String _searchQuery = '';
  bool _showOnlyFavorites = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filtered movies based on user's search query and favorite filter
  List<Movie> get _filteredMovies {
    return _movies.where((movie) {
      final matchesSearch = movie.title
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          movie.genres
              .any((g) => g.toLowerCase().contains(_searchQuery.toLowerCase()));

      final matchesFavorite = !_showOnlyFavorites || movie.isFavorite;

      return matchesSearch && matchesFavorite;
    }).toList();
  }

  // Toggle favorite status from Home list or callback
  void _toggleFavorite(Movie movie) {
    setState(() {
      movie.isFavorite = !movie.isFavorite;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          movie.isFavorite
              ? 'Added "${movie.title}" to Favorites'
              : 'Removed "${movie.title}" from Favorites',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Navigate to Detail Screen using Navigator.push + MaterialPageRoute
  void _navigateToDetail(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(
          movie: movie,
          onFavoriteToggled: () {
            // Re-render home screen to reflect updated favorite status
            setState(() {});
          },
        ),
      ),
    ).then((_) {
      // Refresh state when coming back from detail screen
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredMovies;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.movie_creation_outlined, color: Colors.deepPurpleAccent),
            SizedBox(width: 8),
            Text('Movie Explorer'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              _showOnlyFavorites ? Icons.favorite : Icons.favorite_border,
              color: _showOnlyFavorites ? Colors.red : null,
            ),
            tooltip: _showOnlyFavorites ? 'Show all' : 'Show favorites only',
            onPressed: () {
              setState(() {
                _showOnlyFavorites = !_showOnlyFavorites;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by title or genre...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Favorite filter indicator
          if (_showOnlyFavorites)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.filter_alt, size: 16, color: Colors.red),
                  const SizedBox(width: 6),
                  Text(
                    'Showing favorites only (${filteredList.length})',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showOnlyFavorites = false;
                      });
                    },
                    child: const Text('Clear filter'),
                  ),
                ],
              ),
            ),

          // Movie List using ListView.builder
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _showOnlyFavorites
                              ? Icons.favorite_border
                              : Icons.movie_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _showOnlyFavorites
                              ? 'No favorite movies found'
                              : 'No movies match "$_searchQuery"',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final movie = filteredList[index];
                      return MovieCard(
                        movie: movie,
                        onTap: () => _navigateToDetail(movie),
                        onFavoriteTap: () => _toggleFavorite(movie),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// Custom Card widget displaying movie poster, title, rating and genres
class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Hero(
                tag: 'movie-poster-${movie.id}',
                child: Image.network(
                  movie.posterUrl,
                  width: 100,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 100,
                    height: 140,
                    color: Colors.grey[800],
                    child: const Icon(Icons.broken_image, color: Colors.white54),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Movie Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${movie.releaseYear}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.color
                                ?.withValues(alpha: 0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Genres tags
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: movie.genres.take(2).map((genre) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            genre,
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Favorite Button & Navigate indicator
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 4),
              child: IconButton(
                icon: Icon(
                  movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: movie.isFavorite ? Colors.red : null,
                ),
                tooltip: movie.isFavorite
                    ? 'Remove from favorites'
                    : 'Add to favorites',
                onPressed: onFavoriteTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
