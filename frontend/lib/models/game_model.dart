class GameItem {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String coverUrl;
  final double rating;
  final int ratingCount;
  final String releaseYear;
  final String developer;
  final String publisher;
  final List<String> genres;
  final List<String> platforms;
  final List<String> tags;
  final bool isCrossplay;
  final bool isCoop;
  final String minMaxPlayers;
  final List<String> screenshots;

  const GameItem({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.coverUrl,
    required this.rating,
    required this.ratingCount,
    required this.releaseYear,
    required this.developer,
    required this.publisher,
    required this.genres,
    required this.platforms,
    required this.tags,
    this.isCrossplay = true,
    this.isCoop = true,
    this.minMaxPlayers = '1 - 4 Players',
    this.screenshots = const [],
  });

  // Mock sample games aligned with GameScout design
  static List<GameItem> get mockGames => [
    const GameItem(
      id: '1',
      title: 'Cyberpunk 2077: Phantom Liberty',
      slug: 'cyberpunk-2077-phantom-liberty',
      description:
          'A spy-thriller expansion for the open-world action-adventure RPG. As cyber-enhanced mercenary V, join secret agent Solomon Reed to untangle a web of shattered loyalties.',
      coverUrl:
          'https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&w=1000&q=80',
      rating: 4.8,
      ratingCount: 14820,
      releaseYear: '2023',
      developer: 'CD PROJEKT RED',
      publisher: 'CD PROJEKT',
      genres: ['Action RPG', 'Open World', 'Sci-Fi'],
      platforms: ['PC', 'PS5', 'Xbox Series X'],
      tags: ['Cyberpunk', 'Story Rich', 'First-Person', 'Atmospheric'],
      isCrossplay: false,
      isCoop: false,
      minMaxPlayers: 'Single-player',
      screenshots: [
        'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&w=1000&q=80',
      ],
    ),
    const GameItem(
      id: '2',
      title: 'Helldivers 2',
      slug: 'helldivers-2',
      description:
          'Join the Helldivers and fight for freedom across a hostile galaxy in a fast, frantic, and ferocious third-person co-op shooter.',
      coverUrl:
          'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&w=1000&q=80',
      rating: 4.9,
      ratingCount: 32410,
      releaseYear: '2024',
      developer: 'Arrowhead Game Studios',
      publisher: 'PlayStation Publishing',
      genres: ['Co-op Shooter', 'Action', 'Sci-Fi'],
      platforms: ['PC', 'PS5'],
      tags: ['Online Co-Op', 'PvE', 'Crossplay', 'Tactical'],
      isCrossplay: true,
      isCoop: true,
      minMaxPlayers: '1 - 4 Players',
      screenshots: [
        'https://images.unsplash.com/photo-1538481199705-c710c4e965fc?auto=format&fit=crop&w=1000&q=80',
      ],
    ),
    const GameItem(
      id: '3',
      title: 'Elden Ring: Shadow of the Erdtree',
      slug: 'elden-ring-shadow-of-the-erdtree',
      description:
          'Guided by Empyrean Miquella, players are beckoned to the Land of Shadow, a place obscured by the Erdtree where the goddess Marika first set foot.',
      coverUrl:
          'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&w=1000&q=80',
      rating: 4.9,
      ratingCount: 52100,
      releaseYear: '2024',
      developer: 'FromSoftware',
      publisher: 'Bandai Namco',
      genres: ['Action RPG', 'Souls-like', 'Dark Fantasy'],
      platforms: ['PC', 'PS5', 'Xbox Series X'],
      tags: ['Difficult', 'Open World', 'Atmospheric', 'Lore-Rich'],
      isCrossplay: false,
      isCoop: true,
      minMaxPlayers: '1 - 3 Players (Co-op)',
      screenshots: [
        'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?auto=format&fit=crop&w=1000&q=80',
      ],
    ),
    const GameItem(
      id: '4',
      title: 'Hades II',
      slug: 'hades-2',
      description:
          'Battle beyond the Underworld using dark sorcery to take on the Titan of Time in this bewitching sequel to the award-winning rogue-like dungeon crawler.',
      coverUrl:
          'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?auto=format&fit=crop&w=1000&q=80',
      rating: 4.9,
      ratingCount: 18900,
      releaseYear: '2024',
      developer: 'Supergiant Games',
      publisher: 'Supergiant Games',
      genres: ['Roguelike', 'Action', 'Indie'],
      platforms: ['PC', 'Steam Deck'],
      tags: ['Mythology', 'Hack and Slash', 'Great Soundtrack'],
      isCrossplay: false,
      isCoop: false,
      minMaxPlayers: 'Single-player',
      screenshots: [],
    ),
  ];
}
