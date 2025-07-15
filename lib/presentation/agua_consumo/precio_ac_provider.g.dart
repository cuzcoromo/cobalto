// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'precio_ac_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setPrecioHash() => r'709a9158e7a0d6dcde395d73e7f5f88c6f156e26';

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

/// See also [setPrecio].
@ProviderFor(setPrecio)
const setPrecioProvider = SetPrecioFamily();

/// See also [setPrecio].
class SetPrecioFamily extends Family<AsyncValue<void>> {
  /// See also [setPrecio].
  const SetPrecioFamily();

  /// See also [setPrecio].
  SetPrecioProvider call(Map<String, dynamic> data, String doc) {
    return SetPrecioProvider(data, doc);
  }

  @override
  SetPrecioProvider getProviderOverride(covariant SetPrecioProvider provider) {
    return call(provider.data, provider.doc);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'setPrecioProvider';
}

/// See also [setPrecio].
class SetPrecioProvider extends FutureProvider<void> {
  /// See also [setPrecio].
  SetPrecioProvider(Map<String, dynamic> data, String doc)
    : this._internal(
        (ref) => setPrecio(ref as SetPrecioRef, data, doc),
        from: setPrecioProvider,
        name: r'setPrecioProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$setPrecioHash,
        dependencies: SetPrecioFamily._dependencies,
        allTransitiveDependencies: SetPrecioFamily._allTransitiveDependencies,
        data: data,
        doc: doc,
      );

  SetPrecioProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.data,
    required this.doc,
  }) : super.internal();

  final Map<String, dynamic> data;
  final String doc;

  @override
  Override overrideWith(FutureOr<void> Function(SetPrecioRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: SetPrecioProvider._internal(
        (ref) => create(ref as SetPrecioRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        data: data,
        doc: doc,
      ),
    );
  }

  @override
  FutureProviderElement<void> createElement() {
    return _SetPrecioProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetPrecioProvider && other.data == data && other.doc == doc;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, data.hashCode);
    hash = _SystemHash.combine(hash, doc.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SetPrecioRef on FutureProviderRef<void> {
  /// The parameter `data` of this provider.
  Map<String, dynamic> get data;

  /// The parameter `doc` of this provider.
  String get doc;
}

class _SetPrecioProviderElement extends FutureProviderElement<void>
    with SetPrecioRef {
  _SetPrecioProviderElement(super.provider);

  @override
  Map<String, dynamic> get data => (origin as SetPrecioProvider).data;
  @override
  String get doc => (origin as SetPrecioProvider).doc;
}

String _$getPrecioHash() => r'191df173e815027b12135880f213156d065d46d2';

/// See also [getPrecio].
@ProviderFor(getPrecio)
final getPrecioProvider =
    AutoDisposeStreamProvider<Map<String, dynamic>>.internal(
      getPrecio,
      name: r'getPrecioProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$getPrecioHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetPrecioRef = AutoDisposeStreamProviderRef<Map<String, dynamic>>;
String _$medidorListHash() => r'8f6bdeaab8b77995ffc93f1c3fcc3a1c91eddef2';

/// See also [medidorList].
@ProviderFor(medidorList)
final medidorListProvider = StreamProvider<List<Medidor>>.internal(
  medidorList,
  name: r'medidorListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$medidorListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MedidorListRef = StreamProviderRef<List<Medidor>>;
String _$updateMedidorHash() => r'e9301c5716503bd91391495cb5ee6005389ae396';

/// See also [updateMedidor].
@ProviderFor(updateMedidor)
const updateMedidorProvider = UpdateMedidorFamily();

/// See also [updateMedidor].
class UpdateMedidorFamily extends Family<AsyncValue<void>> {
  /// See also [updateMedidor].
  const UpdateMedidorFamily();

  /// See also [updateMedidor].
  UpdateMedidorProvider call(Map<String, dynamic> data) {
    return UpdateMedidorProvider(data);
  }

  @override
  UpdateMedidorProvider getProviderOverride(
    covariant UpdateMedidorProvider provider,
  ) {
    return call(provider.data);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateMedidorProvider';
}

/// See also [updateMedidor].
class UpdateMedidorProvider extends FutureProvider<void> {
  /// See also [updateMedidor].
  UpdateMedidorProvider(Map<String, dynamic> data)
    : this._internal(
        (ref) => updateMedidor(ref as UpdateMedidorRef, data),
        from: updateMedidorProvider,
        name: r'updateMedidorProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$updateMedidorHash,
        dependencies: UpdateMedidorFamily._dependencies,
        allTransitiveDependencies:
            UpdateMedidorFamily._allTransitiveDependencies,
        data: data,
      );

  UpdateMedidorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.data,
  }) : super.internal();

  final Map<String, dynamic> data;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateMedidorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateMedidorProvider._internal(
        (ref) => create(ref as UpdateMedidorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        data: data,
      ),
    );
  }

  @override
  FutureProviderElement<void> createElement() {
    return _UpdateMedidorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateMedidorProvider && other.data == data;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, data.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateMedidorRef on FutureProviderRef<void> {
  /// The parameter `data` of this provider.
  Map<String, dynamic> get data;
}

class _UpdateMedidorProviderElement extends FutureProviderElement<void>
    with UpdateMedidorRef {
  _UpdateMedidorProviderElement(super.provider);

  @override
  Map<String, dynamic> get data => (origin as UpdateMedidorProvider).data;
}

String _$onRegisterHash() => r'3aa9af95b9eab1fb811b1d385ea7a64ae8f48e2d';

/// See also [OnRegister].
@ProviderFor(OnRegister)
final onRegisterProvider =
    AutoDisposeAsyncNotifierProvider<OnRegister, void>.internal(
      OnRegister.new,
      name: r'onRegisterProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$onRegisterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OnRegister = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
