// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lightbulb_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lightbulbNotifierHash() => r'05cb73b298e81bb874e00f86ad9533fdbc0746bf';

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

abstract class _$LightbulbNotifier
    extends BuildlessAsyncNotifier<LightbulbState> {
  late final String ip;

  FutureOr<LightbulbState> build(String ip);
}

/// See also [LightbulbNotifier].
@ProviderFor(LightbulbNotifier)
const lightbulbNotifierProvider = LightbulbNotifierFamily();

/// See also [LightbulbNotifier].
class LightbulbNotifierFamily extends Family<AsyncValue<LightbulbState>> {
  /// See also [LightbulbNotifier].
  const LightbulbNotifierFamily();

  /// See also [LightbulbNotifier].
  LightbulbNotifierProvider call(String ip) {
    return LightbulbNotifierProvider(ip);
  }

  @override
  LightbulbNotifierProvider getProviderOverride(
    covariant LightbulbNotifierProvider provider,
  ) {
    return call(provider.ip);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'lightbulbNotifierProvider';
}

/// See also [LightbulbNotifier].
class LightbulbNotifierProvider
    extends AsyncNotifierProviderImpl<LightbulbNotifier, LightbulbState> {
  /// See also [LightbulbNotifier].
  LightbulbNotifierProvider(String ip)
    : this._internal(
        () => LightbulbNotifier()..ip = ip,
        from: lightbulbNotifierProvider,
        name: r'lightbulbNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$lightbulbNotifierHash,
        dependencies: LightbulbNotifierFamily._dependencies,
        allTransitiveDependencies:
            LightbulbNotifierFamily._allTransitiveDependencies,
        ip: ip,
      );

  LightbulbNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ip,
  }) : super.internal();

  final String ip;

  @override
  FutureOr<LightbulbState> runNotifierBuild(
    covariant LightbulbNotifier notifier,
  ) {
    return notifier.build(ip);
  }

  @override
  Override overrideWith(LightbulbNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: LightbulbNotifierProvider._internal(
        () => create()..ip = ip,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ip: ip,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<LightbulbNotifier, LightbulbState>
  createElement() {
    return _LightbulbNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LightbulbNotifierProvider && other.ip == ip;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ip.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LightbulbNotifierRef on AsyncNotifierProviderRef<LightbulbState> {
  /// The parameter `ip` of this provider.
  String get ip;
}

class _LightbulbNotifierProviderElement
    extends AsyncNotifierProviderElement<LightbulbNotifier, LightbulbState>
    with LightbulbNotifierRef {
  _LightbulbNotifierProviderElement(super.provider);

  @override
  String get ip => (origin as LightbulbNotifierProvider).ip;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
