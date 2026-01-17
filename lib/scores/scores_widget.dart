import 'dart:async';

import 'package:alarm_clock/scores/scores_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ScoresWidget extends HookConsumerWidget {
  const ScoresWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoresState = ref.watch(scoresNotifierProvider);

    useEffect(() {
      final timer = Timer.periodic(Duration(seconds: 60), (timer) async {
        await ref.read(scoresNotifierProvider.notifier).refresh();
      });

      return () {
        timer.cancel();
      };
    }, []);

    if (!scoresState.hasValue) {
      return Container();
    }

    final scores = scoresState.requireValue;

    String getDateText(DateTime date) {
      final now = DateTime.now();
      final yesterday = now.subtract(Duration(days: 1));
      final tomorrow = now.add(Duration(days: 1));
      if (date.year == now.year && date.month == now.month && date.day == now.day) {
        return 'Today';
      } else if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
        return 'Yesterday';
      } else if (date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day) {
        return 'Tomorrow';
      } else {
        return DateFormat('MMM d').format(date);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 12.0),
      child: Row(
        spacing: 40.0,
        children: [
          for (final score in scores)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      spacing: 8.0,
                      children: [
                        Text(
                          score.visitorTeam.abbreviation,
                          style: TextStyle(
                            fontWeight: score.status.contains('Final')
                                ? (score.visitorTeamScore > score.homeTeamScore)
                                      ? FontWeight.bold
                                      : FontWeight.w500
                                : FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (!score.status.contains(':00Z'))
                          Text(
                            score.visitorTeamScore.toString(),
                            style: TextStyle(
                              fontWeight: score.status.contains('Final')
                                  ? (score.visitorTeamScore > score.homeTeamScore)
                                        ? FontWeight.bold
                                        : FontWeight.w500
                                  : FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                      ],
                    ),
                    Row(
                      spacing: 8.0,
                      children: [
                        Text(
                          score.homeTeam.abbreviation,
                          style: TextStyle(
                            fontWeight: score.status.contains('Final')
                                ? (score.visitorTeamScore < score.homeTeamScore)
                                      ? FontWeight.bold
                                      : FontWeight.w500
                                : FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (!score.status.contains(':00Z'))
                          Text(
                            score.homeTeamScore.toString(),
                            style: TextStyle(
                              fontWeight: score.status.contains('Final')
                                  ? (score.visitorTeamScore < score.homeTeamScore)
                                        ? FontWeight.bold
                                        : FontWeight.w500
                                  : FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 36,
                  child: VerticalDivider(width: 32.0),
                ),
                Column(
                  children: [
                    if (score.status.contains(':00Z')) ...[
                      Text(
                        getDateText(DateTime.parse(score.status).toLocal()),
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        DateFormat('h:mm a').format(DateTime.parse(score.status).toLocal()),
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ] else
                      Text(score.status),
                    if (score.status.contains('Qtr') && score.time != null) Text(score.time!),
                    if (score.status.contains('Final'))
                      Text(
                        getDateText(score.date),
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
