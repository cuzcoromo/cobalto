// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalHistoryHash() => r'0a565164059021c7a0b00d95eb1e60ca3036c46e';

/// See also [totalHistory].
@ProviderFor(totalHistory)
final totalHistoryProvider = AutoDisposeFutureProvider<num>.internal(
  totalHistory,
  name: r'totalHistoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$totalHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalHistoryRef = AutoDisposeFutureProviderRef<num>;
String _$totalMesHash() => r'426f2605ce02ed8d38651eaecaf799b68989c3ba';

/// See also [totalMes].
@ProviderFor(totalMes)
final totalMesProvider = AutoDisposeFutureProvider<num>.internal(
  totalMes,
  name: r'totalMesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$totalMesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalMesRef = AutoDisposeFutureProviderRef<num>;
String _$listRegisterCobroHash() => r'71b07ee101536b8119847c3f75535ee2c7085b6e';

/// See also [listRegisterCobro].
@ProviderFor(listRegisterCobro)
final listRegisterCobroProvider =
    AutoDisposeFutureProvider<List<Map<String, dynamic>>>.internal(
      listRegisterCobro,
      name: r'listRegisterCobroProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$listRegisterCobroHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ListRegisterCobroRef =
    AutoDisposeFutureProviderRef<List<Map<String, dynamic>>>;
String _$deudaUserHash() => r'3905d76137ce16c7c5cb535e8751c8c50c9cbc28';

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

/// See also [deudaUser].
@ProviderFor(deudaUser)
const deudaUserProvider = DeudaUserFamily();

/// See also [deudaUser].
class DeudaUserFamily extends Family<AsyncValue<num>> {
  /// See also [deudaUser].
  const DeudaUserFamily();

  /// See also [deudaUser].
  DeudaUserProvider call(String? id) {
    return DeudaUserProvider(id);
  }

  @override
  DeudaUserProvider getProviderOverride(covariant DeudaUserProvider provider) {
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
  String? get name => r'deudaUserProvider';
}

/// See also [deudaUser].
class DeudaUserProvider extends AutoDisposeFutureProvider<num> {
  /// See also [deudaUser].
  DeudaUserProvider(String? id)
    : this._internal(
        (ref) => deudaUser(ref as DeudaUserRef, id),
        from: deudaUserProvider,
        name: r'deudaUserProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$deudaUserHash,
        dependencies: DeudaUserFamily._dependencies,
        allTransitiveDependencies: DeudaUserFamily._allTransitiveDependencies,
        id: id,
      );

  DeudaUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  Override overrideWith(FutureOr<num> Function(DeudaUserRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: DeudaUserProvider._internal(
        (ref) => create(ref as DeudaUserRef),
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
  AutoDisposeFutureProviderElement<num> createElement() {
    return _DeudaUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeudaUserProvider && other.id == id;
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
mixin DeudaUserRef on AutoDisposeFutureProviderRef<num> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _DeudaUserProviderElement extends AutoDisposeFutureProviderElement<num>
    with DeudaUserRef {
  _DeudaUserProviderElement(super.provider);

  @override
  String? get id => (origin as DeudaUserProvider).id;
}

String _$totalAporteHash() => r'111b25ab3cf4e43e2b0c3ed31dcda8179b5b1e82';

/// See also [totalAporte].
@ProviderFor(totalAporte)
const totalAporteProvider = TotalAporteFamily();

/// See also [totalAporte].
class TotalAporteFamily extends Family<AsyncValue<num>> {
  /// See also [totalAporte].
  const TotalAporteFamily();

  /// See also [totalAporte].
  TotalAporteProvider call(String? id) {
    return TotalAporteProvider(id);
  }

  @override
  TotalAporteProvider getProviderOverride(
    covariant TotalAporteProvider provider,
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
  String? get name => r'totalAporteProvider';
}

/// See also [totalAporte].
class TotalAporteProvider extends AutoDisposeFutureProvider<num> {
  /// See also [totalAporte].
  TotalAporteProvider(String? id)
    : this._internal(
        (ref) => totalAporte(ref as TotalAporteRef, id),
        from: totalAporteProvider,
        name: r'totalAporteProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$totalAporteHash,
        dependencies: TotalAporteFamily._dependencies,
        allTransitiveDependencies: TotalAporteFamily._allTransitiveDependencies,
        id: id,
      );

  TotalAporteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  Override overrideWith(
    FutureOr<num> Function(TotalAporteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TotalAporteProvider._internal(
        (ref) => create(ref as TotalAporteRef),
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
  AutoDisposeFutureProviderElement<num> createElement() {
    return _TotalAporteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TotalAporteProvider && other.id == id;
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
mixin TotalAporteRef on AutoDisposeFutureProviderRef<num> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _TotalAporteProviderElement extends AutoDisposeFutureProviderElement<num>
    with TotalAporteRef {
  _TotalAporteProviderElement(super.provider);

  @override
  String? get id => (origin as TotalAporteProvider).id;
}

String _$totaltCategoriaHash() => r'1aee64cd8ec7cf8fe51559f7937f09ff74365f45';

/// See also [totaltCategoria].
@ProviderFor(totaltCategoria)
final totaltCategoriaProvider = AutoDisposeFutureProvider<num>.internal(
  totaltCategoria,
  name: r'totaltCategoriaProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$totaltCategoriaHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotaltCategoriaRef = AutoDisposeFutureProviderRef<num>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
