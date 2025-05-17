import 'package:flutter/material.dart';
import 'package:frontend/core/navigation/error_screen.dart';
import 'package:go_router/go_router.dart';

/// **Navigator Error Handler**
///
/// This class handles navigation errors and undefined routes in the application.
/// It provides a method to display an error screen when navigation fails.
class NavErrorHandler {
  /// **Error Handler Method**
  ///
  /// This method is called when a navigation error occurs.
  /// It takes the current [BuildContext] and [GoRouterState] as parameters.
  /// It returns a [Widget] that displays an error message.
  static Widget navErrorHandler(BuildContext context, GoRouterState state) {
    /// Check if the error is a [GoError]
    if (state.error is GoError) {
      /// If the error is a [GoRouterError], display the error message through [ErrorScreen]
      return ErrorScreen(errorMessage: state.error.toString());
    }

    /// If the error is not a [GoError], display a generic error message through [ErrorScreen]
    return ErrorScreen(errorMessage: state.error.toString());
  }
}
