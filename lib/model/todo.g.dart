// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$memoryCardDetailHash() => r'a285fc51cedcf0751b2009d32d2c1c82fa13a406';

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

/// See also [memoryCardDetail].
@ProviderFor(memoryCardDetail)
const memoryCardDetailProvider = MemoryCardDetailFamily();

/// See also [memoryCardDetail].
class MemoryCardDetailFamily extends Family<AsyncValue<Todo>> {
  /// See also [memoryCardDetail].
  const MemoryCardDetailFamily();

  /// See also [memoryCardDetail].
  MemoryCardDetailProvider call(
    String id,
  ) {
    return MemoryCardDetailProvider(
      id,
    );
  }

  @override
  MemoryCardDetailProvider getProviderOverride(
    covariant MemoryCardDetailProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'memoryCardDetailProvider';
}

/// See also [memoryCardDetail].
class MemoryCardDetailProvider extends AutoDisposeFutureProvider<Todo> {
  /// See also [memoryCardDetail].
  MemoryCardDetailProvider(
    String id,
  ) : this._internal(
          (ref) => memoryCardDetail(
            ref as MemoryCardDetailRef,
            id,
          ),
          from: memoryCardDetailProvider,
          name: r'memoryCardDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$memoryCardDetailHash,
          dependencies: MemoryCardDetailFamily._dependencies,
          allTransitiveDependencies:
              MemoryCardDetailFamily._allTransitiveDependencies,
          id: id,
        );

  MemoryCardDetailProvider._internal(
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
    FutureOr<Todo> Function(MemoryCardDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MemoryCardDetailProvider._internal(
        (ref) => create(ref as MemoryCardDetailRef),
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
  AutoDisposeFutureProviderElement<Todo> createElement() {
    return _MemoryCardDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MemoryCardDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MemoryCardDetailRef on AutoDisposeFutureProviderRef<Todo> {
  /// The parameter `id` of this provider.
  String get id;
}

class _MemoryCardDetailProviderElement
    extends AutoDisposeFutureProviderElement<Todo> with MemoryCardDetailRef {
  _MemoryCardDetailProviderElement(super.provider);

  @override
  String get id => (origin as MemoryCardDetailProvider).id;
}

String _$todoListHash() => r'1b7d94d9e677000a1d7c4dccb894144d20655a9e';

/// See also [TodoList].
@ProviderFor(TodoList)
final todoListProvider =
    AutoDisposeAsyncNotifierProvider<TodoList, List<Todo>>.internal(
  TodoList.new,
  name: r'todoListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoList = AutoDisposeAsyncNotifier<List<Todo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
