import 'package:website/models/match_model.dart';
import 'package:website/models/team_model.dart';

class PointsTableRowData {
  const PointsTableRowData({
    required this.team,
    required this.played,
    required this.wins,
    required this.losses,
    required this.netRunRate,
    required this.points,
  });

  final String team;
  final int played;
  final int wins;
  final int losses;
  final double netRunRate;
  final int points;
}

class AppData {
  const AppData._();

  static const List<TeamModel> teams = [
    TeamModel(
      id: 'Avengers',
      name: 'Ajay Avengers',
      captain: 'Ajay Samanth',
      logoText: 'AA',
      primaryHexColor: 0xFF0A84FF,
      secondaryHexColor: 0xFF003B73,
    ),
    TeamModel(
      id: 'Soldiers',
      name: 'Shiva Soldiers',
      captain: 'Shiva Dhanish',
      logoText: 'SS',
      primaryHexColor: 0xFFFFB200,
      secondaryHexColor: 0xFF7A4A00,
    ),
    TeamModel(
      id: 'Vintagers',
      name: 'Vinith Vintagers',
      captain: 'Vinith Dale',
      logoText: 'VV',
      primaryHexColor: 0xFF00A896,
      secondaryHexColor: 0xFF004D43,
    ),
    TeamModel(
      id: 'Masters',
      name: 'Maneesh Masters',
      captain: 'Maneesh',
      logoText: 'MM',
      primaryHexColor: 0xFFE63946,
      secondaryHexColor: 0xFF7A0D1A,
    ),
    TeamModel(
      id: 'Strikers',
      name: 'Nikhil Strikers',
      captain: 'Nikhil',
      logoText: 'NS',
      primaryHexColor: 0xFF9D4EDD,
      secondaryHexColor: 0xFF47126B,
    ),
    TeamModel(
      id: 'Noice Makers',
      name: 'Navneet Noice Makers',
      captain: 'Navaneeth',
      logoText: 'NNM',
      primaryHexColor: 0xFF2D3142,
      secondaryHexColor: 0xFF111827,
    ),
  ];

  static final List<MatchModel> matches = [
    MatchModel(
      teamA: 'Ajay Avengers',
      teamB: 'Nikhil Strikers',
      dateTime: DateTime(2026, 3, 12, 18, 30),
      venue: 'Himaithnagar Cricket Club, Hyderabad',
      status: MatchStatus.completed,
    ),
    MatchModel(
      teamA: 'Nikhil Strikers',
      teamB: 'Shiva Soldiers',
      dateTime: DateTime(2026, 3, 13, 19, 0),
      venue: 'Riverside Cricket Ground',
      status: MatchStatus.completed,
    ),
    MatchModel(
      teamA: 'Vinith Vintagers',
      teamB: 'Shiva Soldiers',
      dateTime: DateTime(2026, 3, 14, 16, 0),
      venue: 'OU CricketStadium',
      status: MatchStatus.upcoming,
    ),
    MatchModel(
      teamA: 'Ajay Avengers',
      teamB: 'Maneesh Masters',
      dateTime: DateTime(2026, 3, 15, 18, 0),
      venue: 'Ramanthapur Cricket Ground, Hyderabad',
      status: MatchStatus.upcoming,
    ),
    MatchModel(
      teamA: 'Nikhil Strikers',
      teamB: 'Navneet Noice Makers',
      dateTime: DateTime(2026, 3, 16, 18, 30),
      venue: 'Amberpet Cricket Ground',
      status: MatchStatus.upcoming,
    ),
  ];

  static const List<PointsTableRowData> pointsTableRows = [
    PointsTableRowData(
      team: 'Nikhil Strikers',
      played: 4,
      wins: 3,
      losses: 1,
      netRunRate: 1.22,
      points: 6,
    ),
    PointsTableRowData(
      team: 'Navneet Noice Makers',
      played: 4,
      wins: 3,
      losses: 1,
      netRunRate: 0.88,
      points: 6,
    ),
    PointsTableRowData(
      team: 'Ajay Avengers',
      played: 4,
      wins: 2,
      losses: 2,
      netRunRate: 0.34,
      points: 4,
    ),
    PointsTableRowData(
      team: 'Maneesh Masters',
      played: 4,
      wins: 4,
      losses: 0,
      netRunRate: 10,
      points: 10,
    ),
    PointsTableRowData(
      team: 'Vinith Vintagers',
      played: 4,
      wins: 1,
      losses: 3,
      netRunRate: -0.73,
      points: 2,
    ),
    PointsTableRowData(
      team: 'Shiva Soldiers',
      played: 4,
      wins: 1,
      losses: 3,
      netRunRate: -1.12,
      points: 2,
    ),
  ];

  static const List<String> heroImages = [
    'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1600&q=80',
    'https://images.unsplash.com/photo-1531415074968-036ba1b575da?auto=format&fit=crop&w=1600&q=80',
    'https://images.unsplash.com/photo-1514302240736-b1fee5985889?auto=format&fit=crop&w=1600&q=80',
    'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=1600&q=80',
  ];

  static const List<String> galleryImages = [
    'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1531415074968-036ba1b575da?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1512719994953-eabf50895df7?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1514302240736-b1fee5985889?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1531415074968-036ba1b575da?auto=format&fit=crop&w=1200&q=80',
  ];

  static const List<String> sponsors = [
    'Sachdev Sports',
    'Neelkamal Sports Wear',
    'Red Bull Energy Drinks',
    'Rear Gear',
    'Gatrode',
  ];
}
