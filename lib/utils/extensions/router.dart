import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension VaranasiRouterExtension on BuildContext {
  /// shorthand for `GoRouterState.of(context)`
  /// ```
  /// IconButton(
  ///   tooltip: 'Find in playlist',
  ///   icon: const Icon(Icons.search),
  ///   onPressed: () {
  ///     final existingPath = context.routerState.path;
  ///     context.push(
  ///       '$existingPath/${AppRoutes.librarySearch.path}',
  ///       extra:
  ///           state.sortedMediaItems(context.read<ConfigCubit>().sortType),
  ///     );
  ///   },
  /// ),
  /// ```
  GoRouterState get routerState => GoRouterState.of(this);
}
