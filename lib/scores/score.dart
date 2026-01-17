class Score {
  DateTime date;
  int period;
  String status;
  String? time;
  Team homeTeam;
  Team visitorTeam;
  int homeTeamScore;
  int visitorTeamScore;

  Score({
    required this.date,
    required this.period,
    required this.status,
    required this.time,
    required this.homeTeam,
    required this.visitorTeam,
    required this.homeTeamScore,
    required this.visitorTeamScore,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      date: DateTime.parse(json['date']).toLocal(),
      period: json['period'],
      status: json['status'],
      time: json['time'],
      homeTeam: Team.fromJson(json['home_team']),
      visitorTeam: Team.fromJson(json['visitor_team']),
      homeTeamScore: json['home_team_score'],
      visitorTeamScore: json['visitor_team_score'],
    );
  }
}

class Team {
  String city;
  String name;
  String fullName;
  String abbreviation;

  Team({
    required this.city,
    required this.name,
    required this.fullName,
    required this.abbreviation,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      city: json['city'],
      name: json['name'],
      fullName: json['full_name'],
      abbreviation: json['abbreviation'],
    );
  }
}
