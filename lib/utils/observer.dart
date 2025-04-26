import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgh_mobile/utils/extension.dart';

class Observers extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final value = newValue is AsyncValue ? (newValue).toShortString() : newValue.toString();
    log('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$value"
}''');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    log('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "disposed"
}''');
    super.didDisposeProvider(provider, container);
  }
}

class GoRouterObserver extends NavigatorObserver {
  void _log(String message, Map<String, dynamic> data) {
    log(message, name: 'Navigation');
    log(data.toString(), name: 'Navigation');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('New route pushed', {
      'current_route': route.settings.name,
      'previous_route': previousRoute?.settings.name,
      'arguments': route.settings.arguments,
    });
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('Route popped', {
      'popped_route': route.settings.name,
      'returning_to': previousRoute?.settings.name,
    });
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('Route removed', {
      'removed_route': route.settings.name,
      'new_top_route': previousRoute?.settings.name,
    });
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _log('Route replaced', {
      'old_route': oldRoute?.settings.name,
      'new_route': newRoute?.settings.name,
      'arguments': newRoute?.settings.arguments,
    });
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('User gesture started', {
      'current_route': route.settings.name,
      'target_route': previousRoute?.settings.name,
    });
  }

  @override
  void didStopUserGesture() {
    _log('User gesture stopped', {});
  }
}
