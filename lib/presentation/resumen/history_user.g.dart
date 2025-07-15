// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$historyUserHash() => r'b00fa8306774020b67e9d07448bb86ddc0eaaefb';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [historyUser].
@ProviderFor(historyUser)
const historyUserProvider = HistoryUserFamily();

/// See also [historyUser].
class HistoryUserFamily extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [historyUser].
  const HistoryUserFamily();

  /// See also [historyUser].
  HistoryUserProvider call({required String ci, num? anio}) {
    return HistoryUserProvider(ci: ci, anio: anio);
  }

  @override
  HistoryUserProvider getProviderOverride(
    covariant HistoryUserProvider provider,
  ) {
    return call(ci: provider.ci, anio: provider.anio);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'historyUserProvider';
}

/// See also [historyUser].
class HistoryUserProvider
    extends AutoDisposeStreamProvider<List<Map<String, dynamic>>> {
  /// See also [historyUser].
  HistoryUserProvider({required String ci, num? anio})
    : this._internal(
        (ref) => historyUser(ref as HistoryUserRef, ci: ci, anio: anio),
        from: historyUserProvider,
        name: r'historyUserProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$historyUserHash,
        dependencies: HistoryUserFamily._dependencies,
        allTransitiveDependencies: HistoryUserFamily._allTransitiveDependencies,
        ci: ci,
        anio: anio,
      );

  HistoryUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ci,
    required this.anio,
  }) : super.internal();

  final String ci;
  final num? anio;

  @override
  Override overrideWith(
    Stream<List<Map<String, dynamic>>> Function(HistoryUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HistoryUserProvider._internal(
        (ref) => create(ref as HistoryUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ci: ci,
        anio: anio,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Map<String, dynamic>>> createElement() {
    return _HistoryUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HistoryUserProvider && other.ci == ci && other.anio == anio;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ci.hashCode);
    hash = _SystemHash.combine(hash, anio.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HistoryUserRef
    on AutoDisposeStreamProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `ci` of this provider.
  String get ci;

  /// The parameter `anio` of this provider.
  num? get anio;
}

class _HistoryUserProviderElement
    extends AutoDisposeStreamProviderElement<List<Map<String, dynamic>>>
    with HistoryUserRef {
  _HistoryUserProviderElement(super.provider);

  @override
  String get ci => (origin as HistoryUserProvider).ci;
  @override
  num? get anio => (origin as HistoryUserProvider).anio;
}

String _$updateHistoryUserHash() => r'c3709c4c3a0466f5c277b1e06f6e0a73979f5181';

/// See also [updateHistoryUser].
@ProviderFor(updateHistoryUser)
const updateHistoryUserProvider = UpdateHistoryUserFamily();

/// See also [updateHistoryUser].
class UpdateHistoryUserFamily extends Family<AsyncValue<bool>> {
  /// See also [updateHistoryUser].
  const UpdateHistoryUserFamily();

  /// See also [updateHistoryUser].
  UpdateHistoryUserProvider call(String id) {
    return UpdateHistoryUserProvider(id);
  }

  @override
  UpdateHistoryUserProvider getProviderOverride(
    covariant UpdateHistoryUserProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateHistoryUserProvider';
}

/// See also [updateHistoryUser].
class UpdateHistoryUserProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [updateHistoryUser].
  UpdateHistoryUserProvider(String id)
    : this._internal(
        (ref) => updateHistoryUser(ref as UpdateHistoryUserRef, id),
        from: updateHistoryUserProvider,
        name: r'updateHistoryUserProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$updateHistoryUserHash,
        dependencies: UpdateHistoryUserFamily._dependencies,
        allTransitiveDependencies:
            UpdateHistoryUserFamily._allTransitiveDependencies,
        id: id,
      );

  UpdateHistoryUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<bool> Function(UpdateHistoryUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateHistoryUserProvider._internal(
        (ref) => create(ref as UpdateHistoryUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _UpdateHistoryUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateHistoryUserProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateHistoryUserRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `id` of this provider.
  String get id;
}

class _UpdateHistoryUserProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with UpdateHistoryUserRef {
  _UpdateHistoryUserProviderElement(super.provider);

  @override
  String get id => (origin as UpdateHistoryUserProvider).id;
}

String _$filterListUserHash() => r'e9369784eadf50406b6657a22fda9638ae5f8b51';

/// See also [filterListUser].
@ProviderFor(filterListUser)
const filterListUserProvider = FilterListUserFamily();

/// See also [filterListUser].
class FilterListUserFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [filterListUser].
  const FilterListUserFamily();

  /// See also [filterListUser].
  FilterListUserProvider call({num? mes}) {
    return FilterListUserProvider(mes: mes);
  }

  @override
  FilterListUserProvider getProviderOverride(
    covariant FilterListUserProvider provider,
  ) {
    return call(mes: provider.mes);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filterListUserProvider';
}

/// See also [filterListUser].
class FilterListUserProvider
    extends AutoDisposeStreamProvider<List<Map<String, dynamic>>> {
  /// See also [filterListUser].
  FilterListUserProvider({num? mes})
    : this._internal(
        (ref) => filterListUser(ref as FilterListUserRef, mes: mes),
        from: filterListUserProvider,
        name: r'filterListUserProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$filterListUserHash,
        dependencies: FilterListUserFamily._dependencies,
        allTransitiveDependencies:
            FilterListUserFamily._allTransitiveDependencies,
        mes: mes,
      );

  FilterListUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mes,
  }) : super.internal();

  final num? mes;

  @override
  Override overrideWith(
    Stream<List<Map<String, dynamic>>> Function(FilterListUserRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilterListUserProvider._internal(
        (ref) => create(ref as FilterListUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mes: mes,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Map<String, dynamic>>> createElement() {
    return _FilterListUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilterListUserProvider && other.mes == mes;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mes.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FilterListUserRef
    on AutoDisposeStreamProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `mes` of this provider.
  num? get mes;
}

class _FilterListUserProviderElement
    extends AutoDisposeStreamProviderElement<List<Map<String, dynamic>>>
    with FilterListUserRef {
  _FilterListUserProviderElement(super.provider);

  @override
  num? get mes => (origin as FilterListUserProvider).mes;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
