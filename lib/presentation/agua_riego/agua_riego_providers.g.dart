// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agua_riego_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPriceMtoHash() => r'7f0477b3c3e91ffe03083ee124139070a81c995e';

/// See also [getPriceMto].
@ProviderFor(getPriceMto)
final getPriceMtoProvider = StreamProvider<Map<String, dynamic>>.internal(
  getPriceMto,
  name: r'getPriceMtoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getPriceMtoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetPriceMtoRef = StreamProviderRef<Map<String, dynamic>>;
String _$getListUserAgRiHash() => r'633d10936361ed90db76bb0e1a6fe22226bab948';

/// See also [getListUserAgRi].
@ProviderFor(getListUserAgRi)
final getListUserAgRiProvider =
    AutoDisposeStreamProvider<List<Map<String, dynamic>>>.internal(
      getListUserAgRi,
      name: r'getListUserAgRiProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$getListUserAgRiHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetListUserAgRiRef =
    AutoDisposeStreamProviderRef<List<Map<String, dynamic>>>;
String _$deleteAgRieHash() => r'a665b0d19a8ec2e6328f98ac8da4bfc1ad4a46df';

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

/// See also [deleteAgRie].
@ProviderFor(deleteAgRie)
const deleteAgRieProvider = DeleteAgRieFamily();

/// See also [deleteAgRie].
class DeleteAgRieFamily extends Family<AsyncValue<void>> {
  /// See also [deleteAgRie].
  const DeleteAgRieFamily();

  /// See also [deleteAgRie].
  DeleteAgRieProvider call(String? id) {
    return DeleteAgRieProvider(id);
  }

  @override
  DeleteAgRieProvider getProviderOverride(
    covariant DeleteAgRieProvider provider,
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
  String? get name => r'deleteAgRieProvider';
}

/// See also [deleteAgRie].
class DeleteAgRieProvider extends AutoDisposeFutureProvider<void> {
  /// See also [deleteAgRie].
  DeleteAgRieProvider(String? id)
    : this._internal(
        (ref) => deleteAgRie(ref as DeleteAgRieRef, id),
        from: deleteAgRieProvider,
        name: r'deleteAgRieProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$deleteAgRieHash,
        dependencies: DeleteAgRieFamily._dependencies,
        allTransitiveDependencies: DeleteAgRieFamily._allTransitiveDependencies,
        id: id,
      );

  DeleteAgRieProvider._internal(
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
    FutureOr<void> Function(DeleteAgRieRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteAgRieProvider._internal(
        (ref) => create(ref as DeleteAgRieRef),
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
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DeleteAgRieProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteAgRieProvider && other.id == id;
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
mixin DeleteAgRieRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _DeleteAgRieProviderElement extends AutoDisposeFutureProviderElement<void>
    with DeleteAgRieRef {
  _DeleteAgRieProviderElement(super.provider);

  @override
  String? get id => (origin as DeleteAgRieProvider).id;
}

String _$getAgRieHash() => r'390e5f2e254604531aa0c12be13ac6db808977e9';

/// See also [getAgRie].
@ProviderFor(getAgRie)
const getAgRieProvider = GetAgRieFamily();

/// See also [getAgRie].
class GetAgRieFamily extends Family<Map<String, dynamic>> {
  /// See also [getAgRie].
  const GetAgRieFamily();

  /// See also [getAgRie].
  GetAgRieProvider call(String? id) {
    return GetAgRieProvider(id);
  }

  @override
  GetAgRieProvider getProviderOverride(covariant GetAgRieProvider provider) {
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
  String? get name => r'getAgRieProvider';
}

/// See also [getAgRie].
class GetAgRieProvider extends AutoDisposeProvider<Map<String, dynamic>> {
  /// See also [getAgRie].
  GetAgRieProvider(String? id)
    : this._internal(
        (ref) => getAgRie(ref as GetAgRieRef, id),
        from: getAgRieProvider,
        name: r'getAgRieProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$getAgRieHash,
        dependencies: GetAgRieFamily._dependencies,
        allTransitiveDependencies: GetAgRieFamily._allTransitiveDependencies,
        id: id,
      );

  GetAgRieProvider._internal(
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
    Map<String, dynamic> Function(GetAgRieRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAgRieProvider._internal(
        (ref) => create(ref as GetAgRieRef),
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
  AutoDisposeProviderElement<Map<String, dynamic>> createElement() {
    return _GetAgRieProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAgRieProvider && other.id == id;
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
mixin GetAgRieRef on AutoDisposeProviderRef<Map<String, dynamic>> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _GetAgRieProviderElement
    extends AutoDisposeProviderElement<Map<String, dynamic>>
    with GetAgRieRef {
  _GetAgRieProviderElement(super.provider);

  @override
  String? get id => (origin as GetAgRieProvider).id;
}

String _$riegoFormControlHash() => r'7f71a4660af00d5a20decf76511427f205ce68ea';

/// See also [RiegoFormControl].
@ProviderFor(RiegoFormControl)
final riegoFormControlProvider =
    AutoDisposeNotifierProvider<RiegoFormControl, AsyncValue<void>>.internal(
      RiegoFormControl.new,
      name: r'riegoFormControlProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$riegoFormControlHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$RiegoFormControl = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
