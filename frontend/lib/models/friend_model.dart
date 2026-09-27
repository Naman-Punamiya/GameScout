enum FriendActivityType { currentlyPlaying, mutualWishlist, idle }

class FriendModel {
  final String id;
  final String name;
  final String username;
  final String avatarUrl;
  final int gamesInCommon;
  final bool isOnline;
  final FriendActivityType activityType;
  final String? activityHighlight;
  final String? activityGame;

  const FriendModel({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.gamesInCommon,
    required this.isOnline,
    this.activityType = FriendActivityType.idle,
    this.activityHighlight,
    this.activityGame,
  });

  static List<FriendModel> get mockFriends => [
    const FriendModel(
      id: '1',
      name: 'SarahJenkins',
      username: '@sarah_j',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
      gamesInCommon: 14,
      isOnline: true,
      activityType: FriendActivityType.currentlyPlaying,
      activityGame: 'Cyberpunk 2077',
    ),
    const FriendModel(
      id: '2',
      name: 'AlexRider99',
      username: '@alex_rider',
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
      gamesInCommon: 9,
      isOnline: true,
      activityType: FriendActivityType.mutualWishlist,
      activityHighlight: 'Hades II & Silksong',
    ),
    const FriendModel(
      id: '3',
      name: 'MayaGamer',
      username: '@maya_g',
      avatarUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
      gamesInCommon: 6,
      isOnline: false,
      activityType: FriendActivityType.idle,
    ),
    const FriendModel(
      id: '4',
      name: 'DaveVanguard',
      username: '@dave_v',
      avatarUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
      gamesInCommon: 11,
      isOnline: true,
      activityType: FriendActivityType.currentlyPlaying,
      activityGame: 'Helldivers 2',
    ),
  ];
}
