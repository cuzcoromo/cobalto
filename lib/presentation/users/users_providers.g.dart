// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fireStoreHash() => r'bdf6789f5323591667b9f4359a3ce9d800b1e8fa';

/// See also [fireStore].
@ProviderFor(fireStore)
final fireStoreProvider = AutoDisposeProvider<FirebaseFirestore>.internal(
  fireStore,
  name: r'fireStoreProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fireStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FireStoreRef = AutoDisposeProviderRef<FirebaseFirestore>;
String _$usersHash() => r'910ebf70d50d92e8dee6cc1252e6444f55f3b9d4';

/// See also [users].
@ProviderFor(users)
final usersProvider = AutoDisposeStreamProvider<List<User>>.internal(
  users,
  name: r'usersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$usersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UsersRef = AutoDisposeStreamProviderRef<List<User>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
