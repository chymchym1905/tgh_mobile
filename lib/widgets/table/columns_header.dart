import 'package:flutter/material.dart';
import 'package:tgh_mobile/utils/extension.dart';

import '../../constant/responsivewidth.dart';

Widget verifiedColumn(BuildContext context) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text('Verified',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget rankColumn(BuildContext context) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text('Rank',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget abyssVersionColumn(BuildContext context) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text('Abyss version',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget timeColumn(BuildContext context) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text('Time',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget chamberColumn(BuildContext context) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text('Chamber',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget teamColumn(BuildContext context) {
  return Expanded(
      flex: MediaQuery.of(context).size.width > kMaxWidthMobile ? 1 : 3,
      child: Center(
          child: Text('Team',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget team1or2Column(BuildContext context, int team) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text('Team $team',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget characterUsageColumn(BuildContext context) {
  return Expanded(
      flex: 4,
      child: Center(
          child: Text('Character Usage',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget optionsColumn(BuildContext context) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text('Options',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget domainColumn(BuildContext context) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text('Domain',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget eventColumn(BuildContext context) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text('Event',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget eventStageColumn(BuildContext context) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text('Stage',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget enemyColumn(BuildContext context) {
  return Expanded(
      flex: 2,
      child: Center(
          child: Text('Enemy',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget gameVersionColumn(BuildContext context) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text('Game version',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget nukerColumn(BuildContext context) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text('Nuker',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget supportsColumn(BuildContext context) {
  return Expanded(
      flex: 4,
      child: Center(
          child: Text('Supports',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget damageColumn(BuildContext context) {
  return Expanded(
      flex: 2,
      child: Center(
          child: Text('Damage',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}

Widget attackTypeColumn(BuildContext context) {
  return Expanded(
      flex: 1,
      child: Center(
          child: Text('Attack',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10.wr, fontWeight: FontWeight.bold))));
}
