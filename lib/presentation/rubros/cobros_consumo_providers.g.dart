// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cobros_consumo_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listaCobroHash() => r'be6ddf8168bae35d230b4627eb34e5b60cf9e7ae';

/// See also [listaCobro].
@ProviderFor(listaCobro)
final listaCobroProvider = AutoDisposeStreamProvider<List<Cobro>>.internal(
  listaCobro,
  name: r'listaCobroProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$listaCobroHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ListaCobroRef = AutoDisposeStreamProviderRef<List<Cobro>>;
String _$todosFilteredListHash() => r'77af89ff32bc569df89bf5ea11504425087c6c9c';

/// See also [todosFilteredList].
@ProviderFor(todosFilteredList)
final todosFilteredListProvider = Provider<List<Cobro>>.internal(
  todosFilteredList,
  name: r'todosFilteredListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todosFilteredListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodosFilteredListRef = ProviderRef<List<Cobro>>;
String _$registerCobroListHash() => r'0442555f700dab30b56cacdba218113a939ae4c4';

/// See also [registerCobroList].
@ProviderFor(registerCobroList)
final registerCobroListProvider = AutoDisposeFutureProvider<String?>.internal(
  registerCobroList,
  name: r'registerCobroListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$registerCobroListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RegisterCobroListRef = AutoDisposeFutureProviderRef<String?>;
String _$isBloquedHash() => r'be540df16703eda8701523ddf647a2a1bebc6509';

/// See also [isBloqued].
@ProviderFor(isBloqued)
final isBloquedProvider = AutoDisposeFutureProvider<void>.internal(
  isBloqued,
  name: r'isBloquedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isBloquedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsBloquedRef = AutoDisposeFutureProviderRef<void>;
String _$getPrecioCobroHash() => r'2f86b36231bf821f2bcf2e13c21deefec2c41975';

/// See also [getPrecioCobro].
@ProviderFor(getPrecioCobro)
final getPrecioCobroProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
      getPrecioCobro,
      name: r'getPrecioCobroProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$getPrecioCobroHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetPrecioCobroRef = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$cobroSyncControllerHash() =>
    r'81aba808afd4c7116e7c2318fb909f937bc98892';

/// See also [CobroSyncController].
@ProviderFor(CobroSyncController)
final cobroSyncControllerProvider =
    NotifierProvider<CobroSyncController, void>.internal(
      CobroSyncController.new,
      name: r'cobroSyncControllerProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$cobroSyncControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CobroSyncController = Notifier<void>;
String _$listActiveHash() => r'f3c2d9f13a321162a9a1afe1d42fb92c5179fd44';

/// See also [ListActive].
@ProviderFor(ListActive)
final listActiveProvider = NotifierProvider<ListActive, List<Cobro>>.internal(
  ListActive.new,
  name: r'listActiveProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$listActiveHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ListActive = Notifier<List<Cobro>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
