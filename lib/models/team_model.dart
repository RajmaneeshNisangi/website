class TeamModel {
  const TeamModel({
    required this.id,
    required this.name,
    required this.captain,
    required this.logoText,
    required this.primaryHexColor,
    required this.secondaryHexColor,
  });

  final String id;
  final String name;
  final String captain;
  final String logoText;
  final int primaryHexColor;
  final int secondaryHexColor;
}
