import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveMovieApp());
}

// ─── Movie Model ───────────────────────────────────────────────────────────────
class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

// ─── Sample Data ───────────────────────────────────────────────────────────────
const List<Movie> allMovies = [
  Movie(
    title: 'Inception',
    year: 2010,
    genres: ['Action', 'Sci-Fi', 'Thriller'],
    posterUrl: 'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
    rating: 8.8,
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Drama', 'Thriller'],
    posterUrl: 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
    rating: 9.0,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Adventure', 'Drama', 'Sci-Fi'],
    posterUrl: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
    rating: 8.6,
  ),
  Movie(
    title: 'The Avengers',
    year: 2012,
    genres: ['Action', 'Adventure', 'Sci-Fi'],
    posterUrl: 'https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg',
    rating: 8.0,
  ),
  Movie(
    title: 'Titanic',
    year: 1997,
    genres: ['Drama', 'Romance'],
    posterUrl: 'https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg',
    rating: 7.9,
  ),
  Movie(
    title: 'The Hangover',
    year: 2009,
    genres: ['Comedy'],
    posterUrl: 'https://image.tmdb.org/t/p/w500/uluhlXubGu1VxU63boQeRqkp8nP.jpg',
    rating: 7.7,
  ),
  Movie(
    title: 'Parasite',
    year: 2019,
    genres: ['Drama', 'Thriller'],
    posterUrl: 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
    rating: 8.5,
  ),
  Movie(
    title: 'Get Out',
    year: 2017,
    genres: ['Horror', 'Thriller'],
    posterUrl: 'https://image.tmdb.org/t/p/w500/tFXcEccSQMf3lfhfXKSU9iRBpa3.jpg',
    rating: 7.7,
  ),
];

// ─── App Root ──────────────────────────────────────────────────────────────────
class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Browser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const GenreScreen(),
    );
  }
}

// ─── Genre Screen (Stateful) ───────────────────────────────────────────────────
class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // All available genres extracted from movie data
  static const List<String> _allGenres = [
    'Action',
    'Adventure',
    'Comedy',
    'Drama',
    'Horror',
    'Romance',
    'Sci-Fi',
    'Thriller',
  ];

  // Sort options
  static const List<String> _sortOptions = ['A–Z', 'Z–A', 'Year', 'Rating'];

  String _searchQuery = '';
  final Set<String> _selectedGenres = {};
  String _selectedSort = 'A–Z';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ─── Filtering & Sorting Logic ─────────────────────────────────────────────
  List<Movie> get _visibleMovies {
    // 1. Filter by search query
    List<Movie> result = allMovies.where((movie) {
      final matchesSearch = _searchQuery.isEmpty ||
          movie.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();

    // 2. Filter by selected genres (show movie if it has at least one selected genre)
    if (_selectedGenres.isNotEmpty) {
      result = result.where((movie) {
        return movie.genres.any((g) => _selectedGenres.contains(g));
      }).toList();
    }

    // 3. Sort
    switch (_selectedSort) {
      case 'A–Z':
        result.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Z–A':
        result.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 'Year':
        result.sort((a, b) => b.year.compareTo(a.year));
        break;
      case 'Rating':
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }

    return result;
  }

  // ─── Toggle Genre ──────────────────────────────────────────────────────────
  void _toggleGenre(String genre) {
    setState(() {
      if (_selectedGenres.contains(genre)) {
        _selectedGenres.remove(genre);
      } else {
        _selectedGenres.add(genre);
      }
    });
  }

  // ─── Clear Filters ─────────────────────────────────────────────────────────
  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _selectedGenres.clear();
      _selectedSort = 'A–Z';
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleMovies = _visibleMovies;
    final bool hasActiveFilters =
        _searchQuery.isNotEmpty || _selectedGenres.isNotEmpty;

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Heading ──────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Find a Movie',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  if (hasActiveFilters)
                    TextButton.icon(
                      onPressed: _clearFilters,
                      icon: const Icon(Icons.clear_all, size: 18),
                      label: const Text('Clear filters'),
                      style: TextButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),

              // ── Search Bar ────────────────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search movies...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _searchQuery = '';
                                _searchController.clear();
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                  ),
                  onChanged: (val) => setState(() => _searchQuery = val),
                ),
              ),
              const SizedBox(height: 14),

              // ── Genre Chips Section ───────────────────────────────────────
              Row(
                children: [
                  Text(
                    'Genres',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  if (_selectedGenres.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    // Badge showing number of selected genres
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_selectedGenres.length}',
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              // Wrap auto-wraps chips to next line → responsive
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: _allGenres.map((genre) {
                  final isSelected = _selectedGenres.contains(genre);
                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (_) => _toggleGenre(genre),
                    selectedColor:
                        theme.colorScheme.primaryContainer,
                    checkmarkColor: theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              // ── Sort Dropdown ─────────────────────────────────────────────
              Row(
                children: [
                  Text(
                    'Sort by:',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.5)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSort,
                        items: _sortOptions
                            .map((opt) => DropdownMenuItem(
                                  value: opt,
                                  child: Text(opt),
                                ))
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedSort = val!),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Result count
                  Text(
                    '${visibleMovies.length} result${visibleMovies.length != 1 ? 's' : ''}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ── Movie List (Responsive via LayoutBuilder) ─────────────────
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Breakpoint: >= 800px → 2-column grid; else single list
                    if (constraints.maxWidth >= 800) {
                      return _buildGridView(visibleMovies, constraints);
                    } else {
                      return _buildListView(visibleMovies);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Single-column ListView (phone) ───────────────────────────────────────
  Widget _buildListView(List<Movie> movies) {
    if (movies.isEmpty) return _buildEmptyState();
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) =>
          MovieCard(movie: movies[index], isGrid: false),
    );
  }

  // ─── Two-column GridView (tablet / wide) ──────────────────────────────────
  Widget _buildGridView(List<Movie> movies, BoxConstraints constraints) {
    if (movies.isEmpty) return _buildEmptyState();
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3.2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: movies
          .map((m) => MovieCard(movie: m, isGrid: true))
          .toList(),
    );
  }

  // ─── Empty State ───────────────────────────────────────────────────────────
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.movie_filter_outlined,
              size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No movies found',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters.',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}

// ─── Movie Card Widget ─────────────────────────────────────────────────────────
class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isGrid;

  const MovieCard({super.key, required this.movie, required this.isGrid});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Use LayoutBuilder to adapt poster size within card
    return LayoutBuilder(
      builder: (context, constraints) {
        // Poster width scales with available card width
        final posterWidth = (constraints.maxWidth * 0.22).clamp(55.0, 90.0);
        final posterHeight = posterWidth * 1.5;

        return Card(
          margin: isGrid
              ? EdgeInsets.zero
              : const EdgeInsets.only(bottom: 10),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Poster ──────────────────────────────────────────────
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    movie.posterUrl,
                    width: posterWidth,
                    height: posterHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (_, e, s) => Container(
                      width: posterWidth,
                      height: posterHeight,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image,
                          color: Colors.grey),
                    ),
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: posterWidth,
                        height: posterHeight,
                        color: Colors.grey.shade200,
                        child: const Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2)),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),

                // ── Movie Info ───────────────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        movie.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${movie.year}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // ── Star Rating ───────────────────────────────────
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              color: Colors.amber, size: 16),
                          const SizedBox(width: 3),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(' / 10',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // ── Genre tags ────────────────────────────────────
                      Wrap(
                        spacing: 4,
                        runSpacing: 2,
                        children: movie.genres
                            .take(3)
                            .map((g) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primaryContainer
                                        .withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    g,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
