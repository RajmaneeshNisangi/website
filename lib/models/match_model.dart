enum MatchStatus {
  upcoming,
  completed,
}

class MatchModel {
  const MatchModel({
    required this.teamA,
    required this.teamB,
    required this.dateTime,
    required this.venue,
    required this.status,
  });

  final String teamA;
  final String teamB;
  final DateTime dateTime;
  final String venue;
  final MatchStatus status;
}
