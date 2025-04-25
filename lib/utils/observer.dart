import 'dart:developer';

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
