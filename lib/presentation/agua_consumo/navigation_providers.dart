

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_providers.g.dart';

@riverpod
class CurrentTabIndex extends _$CurrentTabIndex {
  @override
  int build() => 0;

  /// Llama a este método para cambiar la pestaña
  void setIndex(int index) {
    state = index;
  }
}

final selectedMedidorIdProvider = StateProvider<String?>((ref) => null);