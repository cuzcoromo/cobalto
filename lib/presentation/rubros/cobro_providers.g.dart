// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cobro_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todosFilteredHash() => r'ad80e5517823798217c99b10eb91f8ff27e69efa';

/// See also [todosFiltered].
@ProviderFor(todosFiltered)
final todosFilteredProvider = Provider<List<Todo>>.internal(
  todosFiltered,
  name: r'todosFilteredProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todosFilteredHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodosFilteredRef = ProviderRef<List<Todo>>;
String _$todoCurrentFilterHash() => r'b4673c59c9d054b84aa764d9be25492fb0e73fa1';

/// See also [TodoCurrentFilter].
@ProviderFor(TodoCurrentFilter)
final todoCurrentFilterProvider =
    NotifierProvider<TodoCurrentFilter, FilterType>.internal(
      TodoCurrentFilter.new,
      name: r'todoCurrentFilterProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$todoCurrentFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TodoCurrentFilter = Notifier<FilterType>;
String _$todosHash() => r'c58f54dd74e4a3e7f8cab47cfc6b8e032f4dd539';

/// See also [Todos].
@ProviderFor(Todos)
final todosProvider = NotifierProvider<Todos, List<Todo>>.internal(
  Todos.new,
  name: r'todosProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Todos = Notifier<List<Todo>>;
String _$filterOpcionPagoHash() => r'3cd9fa88d7d74f5de33c7b9d61f326996074d7d4';

/// See also [FilterOpcionPago].
@ProviderFor(FilterOpcionPago)
final filterOpcionPagoProvider =
    NotifierProvider<FilterOpcionPago, FilterPago>.internal(
      FilterOpcionPago.new,
      name: r'filterOpcionPagoProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$filterOpcionPagoHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FilterOpcionPago = Notifier<FilterPago>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
