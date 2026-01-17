// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$switchNotifierHash() => r'0919db141d6f284d4159412f5bd8ed1f278e8e6e';

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

abstract class _$SwitchNotifier extends BuildlessAsyncNotifier<SwitchState> {
  late final String ip;

  FutureOr<SwitchState> build(String ip);
}

/// See also [SwitchNotifier].
@ProviderFor(SwitchNotifier)
const switchNotifierProvider = SwitchNotifierFamily();

/// See also [SwitchNotifier].
class SwitchNotifierFamily extends Family<AsyncValue<SwitchState>> {
  /// See also [SwitchNotifier].
  const SwitchNotifierFamily();

  /// See also [SwitchNotifier].
  SwitchNotifierProvider call(String ip) {
    return SwitchNotifierProvider(ip);
  }

  @override
  SwitchNotifierProvider getProviderOverride(
    covariant SwitchNotifierProvider provider,
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
  String? get name => r'switchNotifierProvider';
}

/// See also [SwitchNotifier].
class SwitchNotifierProvider
    extends AsyncNotifierProviderImpl<SwitchNotifier, SwitchState> {
  /// See also [SwitchNotifier].
  SwitchNotifierProvider(String ip)
    : this._internal(
        () => SwitchNotifier()..ip = ip,
        from: switchNotifierProvider,
        name: r'switchNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$switchNotifierHash,
        dependencies: SwitchNotifierFamily._dependencies,
        allTransitiveDependencies:
            SwitchNotifierFamily._allTransitiveDependencies,
        ip: ip,
      );

  SwitchNotifierProvider._internal(
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
  FutureOr<SwitchState> runNotifierBuild(covariant SwitchNotifier notifier) {
    return notifier.build(ip);
  }

  @override
  Override overrideWith(SwitchNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SwitchNotifierProvider._internal(
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
  AsyncNotifierProviderElement<SwitchNotifier, SwitchState> createElement() {
    return _SwitchNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SwitchNotifierProvider && other.ip == ip;
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
mixin SwitchNotifierRef on AsyncNotifierProviderRef<SwitchState> {
  /// The parameter `ip` of this provider.
  String get ip;
}

class _SwitchNotifierProviderElement
    extends AsyncNotifierProviderElement<SwitchNotifier, SwitchState>
    with SwitchNotifierRef {
  _SwitchNotifierProviderElement(super.provider);

  @override
  String get ip => (origin as SwitchNotifierProvider).ip;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
