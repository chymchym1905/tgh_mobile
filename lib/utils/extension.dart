import 'dart:math' as math;
import 'package:tgh_mobile/imports.dart';

import '../shared/exception.dart';

extension CancelTokenExtension on Ref {
  Future<CancelToken> cancelToken({Duration? duration}) async {
    var didDispose = false;
    onDispose(() => didDispose = true);
    await Future<void>.delayed(duration ?? const Duration(milliseconds: 500));
    if (didDispose) {
      throw AppException(message: 'Request debounced by user', code: '499');
    }
    final cancelToken = CancelToken();
    onDispose(cancelToken.cancel);
    return cancelToken;
  }
}

extension AsyncValueToString<T> on AsyncValue<T> {
  String toShortString() {
    return when(
      data: (data) => data.toString(),
      error: (err, stack) => 'Error: $err',
      loading: () => 'Loading',
    );
  }
}

extension ResponsiveSize on num {
  /// Returns a responsive size for ProfileScreen only
  double get wr {
    // Get the screen width
    final screenWidth = ScreenUtil().screenWidth;
    // Calculate the responsive size
    final responsiveSize = this * screenWidth / 375;
    // Cap it at the value when screen width is 512
    double bound = this * 512 / 375;
    // if (screenWidth < kMaxWidthTabletLandscape) {
    //   bound = this * 512 / 375;
    // } else {
    //   bound = this * kMaxWidthTablet / 375;
    // }
    return math.min(responsiveSize, bound);
  }
}

extension StringExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
