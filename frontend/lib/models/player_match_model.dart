class PlayerMatch {
  final String id;
  final String username;
  final String handle;
  final String avatarUrl;
  final int matchPercentage;
  final String status;
  final bool isOnline;
  final List<String> sharedGames;
  final List<String> platforms;
  final String primaryRole;

  const PlayerMatch({
    required this.id,
    required this.username,
    required this.handle,
    required this.avatarUrl,
    required this.matchPercentage,
    required this.status,
    required this.isOnline,
    required this.sharedGames,
    required this.platforms,
    required this.primaryRole,
  });

  static List<PlayerMatch> get mockSquadMatches => [
    const PlayerMatch(
      id: '1',
      username: 'NeonValkyrie',
      handle: '@valkyrie_fps',
      avatarUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
      matchPercentage: 96,
      status: 'In Lobby: Helldivers 2',
      isOnline: true,
      sharedGames: ['Helldivers 2', 'Cyberpunk 2077', 'Apex Legends'],
      platforms: ['PC', 'PS5'],
      primaryRole: 'Tactical Support',
    ),
    const PlayerMatch(
      id: '2',
      username: 'ShadowRonin',
      handle: '@ronin_blade',
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
      matchPercentage: 91,
      status: 'Online • Looking for Squad',
      isOnline: true,
      sharedGames: ['Elden Ring', 'Monster Hunter: World'],
      platforms: ['PC', 'Xbox'],
      primaryRole: 'DPS / Melee',
    ),
    const PlayerMatch(
      id: '3',
      username: 'CyberGhost',
      handle: '@ghost_prime',
      avatarUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=200&q=80',
      matchPercentage: 88,
      status: 'Offline (2h ago)',
      isOnline: false,
      sharedGames: ['Hades II', 'Destiny 2'],
      platforms: ['PS5'],
      primaryRole: 'Sniper / Scout',
    ),
  ];
}
