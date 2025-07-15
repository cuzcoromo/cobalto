// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medidor_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMedidorHash() => r'dde5e83bde801c7d0e3937433f4f7127c2f8753b';

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

/// See also [getMedidor].
@ProviderFor(getMedidor)
const getMedidorProvider = GetMedidorFamily();

/// See also [getMedidor].
class GetMedidorFamily extends Family<AsyncValue<List<MedidorId>>> {
  /// See also [getMedidor].
  const GetMedidorFamily();

  /// See also [getMedidor].
  GetMedidorProvider call(dynamic medidorId) {
    return GetMedidorProvider(medidorId);
  }

  @override
  GetMedidorProvider getProviderOverride(
    covariant GetMedidorProvider provider,
  ) {
    return call(provider.medidorId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getMedidorProvider';
}

/// See also [getMedidor].
class GetMedidorProvider extends AutoDisposeStreamProvider<List<MedidorId>> {
  /// See also [getMedidor].
  GetMedidorProvider(dynamic medidorId)
    : this._internal(
        (ref) => getMedidor(ref as GetMedidorRef, medidorId),
        from: getMedidorProvider,
        name: r'getMedidorProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$getMedidorHash,
        dependencies: GetMedidorFamily._dependencies,
        allTransitiveDependencies: GetMedidorFamily._allTransitiveDependencies,
        medidorId: medidorId,
      );

  GetMedidorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.medidorId,
  }) : super.internal();

  final dynamic medidorId;

  @override
  Override overrideWith(
    Stream<List<MedidorId>> Function(GetMedidorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMedidorProvider._internal(
        (ref) => create(ref as GetMedidorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        medidorId: medidorId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<MedidorId>> createElement() {
    return _GetMedidorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMedidorProvider && other.medidorId == medidorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, medidorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetMedidorRef on AutoDisposeStreamProviderRef<List<MedidorId>> {
  /// The parameter `medidorId` of this provider.
  dynamic get medidorId;
}

class _GetMedidorProviderElement
    extends AutoDisposeStreamProviderElement<List<MedidorId>>
    with GetMedidorRef {
  _GetMedidorProviderElement(super.provider);

  @override
  dynamic get medidorId => (origin as GetMedidorProvider).medidorId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
