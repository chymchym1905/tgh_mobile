import 'package:flutter/gestures.dart';
import 'package:tgh_mobile/imports.dart';

Widget chamber12_1_1(BuildContext context, Breakdown breakdown) {
  final int? rank = breakdown.chamber12_1_1?.rank;
  final Color rankColor = rank != null
      ? rank <= 5
          ? Theme.of(context).extension<TextColors>()!.top5
          : rank <= 15
              ? Theme.of(context).extension<TextColors>()!.top15
              : Theme.of(context).extension<TextColors>()!.below15
      : Theme.of(context).extension<TextColors>()!.textSecondary;
  return Expanded(
    child: Center(
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '12-1-1: ',
            style: TextStyle(color: Theme.of(context).extension<TextColors>()!.text, fontSize: 10.wr)),
        TextSpan(
            text: breakdown.chamber12_1_1?.rank.toString() ?? 'NA',
            style: TextStyle(fontWeight: FontWeight.bold, color: rankColor, fontSize: 10.wr),
            recognizer: TapGestureRecognizer()..onTap = () {})
      ])),
    ),
  );
}

Widget chamber12_1_2(BuildContext context, Breakdown breakdown) {
  return Expanded(
    child: Center(
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '12-1-2: ',
            style: TextStyle(color: Theme.of(context).extension<TextColors>()!.text, fontSize: 10.wr)),
        TextSpan(
            text: breakdown.chamber12_1_2?.rank.toString() ?? 'NA',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.wr,
                color: breakdown.chamber12_1_2?.rank != null
                    ? breakdown.chamber12_1_2!.rank <= 5
                        ? Theme.of(context).extension<TextColors>()!.top5
                        : breakdown.chamber12_1_2!.rank <= 15
                            ? Theme.of(context).extension<TextColors>()!.top15
                            : Theme.of(context).extension<TextColors>()!.below15
                    : Theme.of(context).extension<TextColors>()!.textSecondary),
            recognizer: TapGestureRecognizer()..onTap = () {})
      ])),
    ),
  );
}

Widget chamber12_2_1(BuildContext context, Breakdown breakdown) {
  final int? rank = breakdown.chamber12_2_1?.rank;
  final Color rankColor = rank != null
      ? rank <= 5
          ? Theme.of(context).extension<TextColors>()!.top5
          : rank <= 15
              ? Theme.of(context).extension<TextColors>()!.top15
              : Theme.of(context).extension<TextColors>()!.below15
      : Theme.of(context).extension<TextColors>()!.textSecondary;
  return Expanded(
    child: Center(
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '12-2-1: ',
            style: TextStyle(color: Theme.of(context).extension<TextColors>()!.text, fontSize: 10.wr)),
        TextSpan(
            text: breakdown.chamber12_2_1?.rank.toString() ?? 'NA',
            style: TextStyle(fontWeight: FontWeight.bold, color: rankColor, fontSize: 10.wr),
            recognizer: TapGestureRecognizer()..onTap = () {})
      ])),
    ),
  );
}

Widget chamber12_2_2(BuildContext context, Breakdown breakdown) {
  final int? rank = breakdown.chamber12_2_2?.rank;
  final Color rankColor = rank != null
      ? rank <= 5
          ? Theme.of(context).extension<TextColors>()!.top5
          : rank <= 15
              ? Theme.of(context).extension<TextColors>()!.top15
              : Theme.of(context).extension<TextColors>()!.below15
      : Theme.of(context).extension<TextColors>()!.textSecondary;
  return Expanded(
    child: Center(
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '12-2-2: ',
            style: TextStyle(color: Theme.of(context).extension<TextColors>()!.text, fontSize: 10.wr)),
        TextSpan(
            text: breakdown.chamber12_2_2?.rank.toString() ?? 'NA',
            style: TextStyle(fontWeight: FontWeight.bold, color: rankColor, fontSize: 10.wr),
            recognizer: TapGestureRecognizer()..onTap = () {})
      ])),
    ),
  );
}

Widget chamber12_3_1(BuildContext context, Breakdown breakdown) {
  final int? rank = breakdown.chamber12_3_1?.rank;
  final Color rankColor = rank != null
      ? rank <= 5
          ? Theme.of(context).extension<TextColors>()!.top5
          : rank <= 15
              ? Theme.of(context).extension<TextColors>()!.top15
              : Theme.of(context).extension<TextColors>()!.below15
      : Theme.of(context).extension<TextColors>()!.textSecondary;
  return Expanded(
    child: Center(
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '12-3-1: ',
            style: TextStyle(color: Theme.of(context).extension<TextColors>()!.text, fontSize: 10.wr)),
        TextSpan(
            text: breakdown.chamber12_3_1?.rank.toString() ?? 'NA',
            style: TextStyle(fontWeight: FontWeight.bold, color: rankColor, fontSize: 10.wr),
            recognizer: TapGestureRecognizer()..onTap = () {})
      ])),
    ),
  );
}

Widget chamber12_3_2(BuildContext context, Breakdown breakdown) {
  final int? rank = breakdown.chamber12_3_2?.rank;
  final Color rankColor = rank != null
      ? rank <= 5
          ? Theme.of(context).extension<TextColors>()!.top5
          : rank <= 15
              ? Theme.of(context).extension<TextColors>()!.top15
              : Theme.of(context).extension<TextColors>()!.below15
      : Theme.of(context).extension<TextColors>()!.textSecondary;
  return Expanded(
    child: Center(
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '12-3-2: ',
            style: TextStyle(color: Theme.of(context).extension<TextColors>()!.text, fontSize: 10.wr)),
        TextSpan(
            text: breakdown.chamber12_3_2?.rank.toString() ?? 'NA',
            style: TextStyle(fontWeight: FontWeight.bold, color: rankColor, fontSize: 10.wr),
            recognizer: TapGestureRecognizer()..onTap = () {})
      ])),
    ),
  );
}
