import 'package:alarm_clock/network.dart';
import 'package:alarm_clock/scores/score.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scores_notifier.g.dart';

@Riverpod(keepAlive: true)
class ScoresNotifier extends _$ScoresNotifier {
  @override
  FutureOr<List<Score>> build() async {
    final dates = [
      DateTime.now(),
      DateTime.now().subtract(Duration(days: 1)),
      DateTime.now().add(Duration(days: 1)),
      DateTime.now().add(Duration(days: 2)),
    ];
    final queryParams = {
      'dates[]': dates.map((d) => DateFormat('yyyy-MM-dd').format(d)).toList(),
      'team_ids[]': [29],
    };
    final response = await dio.get(
      'https://api.balldontlie.io/v1/games',
      queryParameters: queryParams,
      options: Options(
        headers: {
          'Authorization': 'cbe5a088-70d6-43c3-b984-fa0ff17faf2e',
        },
        validateStatus: (_) => true,
      )
    );

    final scores = List<dynamic>.from(response.data['data']).map((game) {
      return Score.fromJson(game);
    }).toList();

    final futureScores = scores.where((score) => score.status.contains(':00Z')).toList();
    final pastScores = scores.where((score) => score.status.contains('Final')).toList();
    final currentScores = scores.where((score) => !futureScores.contains(score) && !pastScores.contains(score)).toList();

    if (currentScores.isNotEmpty) {
      return currentScores;
    }

    return [
      ...pastScores.take(1),
      ...futureScores.take(1)
    ];
  }

  Future<void> refresh() async {
    state = AsyncValue.data(await build());
  }
}
