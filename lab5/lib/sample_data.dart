import 'movie.dart';

final List<Movie> sampleMovies = [
  Movie(
    id: 'm1',
    title: 'Inception',
    releaseYear: 2010,
    rating: 8.8,
    posterUrl:
        'https://image.tmdb.org/t/p/w500/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg',
    backdropUrl:
        'https://image.tmdb.org/t/p/w1280/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg',
    genres: ['Action', 'Sci-Fi', 'Thriller'],
    overview:
        'Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets, is offered a chance to regain his old life as payment for a task considered to be impossible: "inception", the implantation of another person\'s idea into a target\'s subconscious.',
    trailers: const [
      Trailer(
        id: 't1',
        title: 'Official Teaser Trailer',
        duration: '1:02',
        youtubeKey: '8hP9D6kZseM',
      ),
      Trailer(
        id: 't2',
        title: 'Official Theatrical Trailer',
        duration: '2:31',
        youtubeKey: 'YoHD9XEInc0',
      ),
      Trailer(
        id: 't3',
        title: 'Characters & World Featurette',
        duration: '4:15',
        youtubeKey: 'd3A3-zSO60E',
      ),
    ],
  ),
  Movie(
    id: 'm2',
    title: 'Interstellar',
    releaseYear: 2014,
    rating: 8.7,
    posterUrl:
        'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
    backdropUrl:
        'https://image.tmdb.org/t/p/w1280/xJHokMbljvjADYDit5fK5VQsXEG.jpg',
    genres: ['Adventure', 'Drama', 'Sci-Fi'],
    overview:
        'The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.',
    trailers: const [
      Trailer(
        id: 't4',
        title: 'Official Trailer 1',
        duration: '2:24',
        youtubeKey: 'zSWdZVtXT7E',
      ),
      Trailer(
        id: 't5',
        title: 'Official Trailer 2 - Others Will Follow',
        duration: '2:35',
        youtubeKey: '0vxOhd4qlnA',
      ),
    ],
  ),
  Movie(
    id: 'm3',
    title: 'The Dark Knight',
    releaseYear: 2008,
    rating: 9.0,
    posterUrl:
        'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
    backdropUrl:
        'https://image.tmdb.org/t/p/w1280/dqK9Hag1054tghRQSqLSfrkvQnA.jpg',
    genres: ['Action', 'Crime', 'Drama'],
    overview:
        'Batman raises the stakes in his war on crime. With the help of allies Lt. Jim Gordon and DA Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.',
    trailers: const [
      Trailer(
        id: 't6',
        title: 'Official Trailer #1',
        duration: '2:17',
        youtubeKey: 'EXeTwQWrcwY',
      ),
      Trailer(
        id: 't7',
        title: 'Official Trailer #2',
        duration: '2:32',
        youtubeKey: 'kmJLuwP3MbY',
      ),
    ],
  ),
  Movie(
    id: 'm4',
    title: 'Spider-Man: Across the Spider-Verse',
    releaseYear: 2023,
    rating: 8.4,
    posterUrl:
        'https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg',
    backdropUrl:
        'https://image.tmdb.org/t/p/w1280/4HodYYKEIsGOdinkGi2Ucz6X9i0.jpg',
    genres: ['Animation', 'Action', 'Adventure'],
    overview:
        'After reuniting with Gwen Stacy, Brooklyn’s full-time, friendly neighborhood Spider-Man is catapulted across the Multiverse, where he encounters the Spider Society, a team of Spider-People charged with protecting the Multiverse’s very existence. But when the heroes clash on how to handle a new threat, Miles finds himself pitted against the other Spiders and must redefine what it means to be a hero so he can save the people he loves most.',
    trailers: const [
      Trailer(
        id: 't8',
        title: 'Official Teaser',
        duration: '2:27',
        youtubeKey: 'cqGjhVJWtEg',
      ),
      Trailer(
        id: 't9',
        title: 'Official Trailer 2',
        duration: '2:56',
        youtubeKey: 'shW9i6k8cB0',
      ),
    ],
  ),
];

