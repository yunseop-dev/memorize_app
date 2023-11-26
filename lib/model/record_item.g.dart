// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_item.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recordItemListHash() => r'8bb676ac238db2aa704c0c9da83340c3b049cae2';

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

/// See also [recordItemList].
@ProviderFor(recordItemList)
const recordItemListProvider = RecordItemListFamily();

/// See also [recordItemList].
class RecordItemListFamily extends Family<AsyncValue<List<RecordItem>>> {
  /// See also [recordItemList].
  const RecordItemListFamily();

  /// See also [recordItemList].
  RecordItemListProvider call(
    String memoryCardId,
  ) {
    return RecordItemListProvider(
      memoryCardId,
    );
  }

  @override
  RecordItemListProvider getProviderOverride(
    covariant RecordItemListProvider provider,
  ) {
    return call(
      provider.memoryCardId,
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
  String? get name => r'recordItemListProvider';
}

/// See also [recordItemList].
class RecordItemListProvider
    extends AutoDisposeFutureProvider<List<RecordItem>> {
  /// See also [recordItemList].
  RecordItemListProvider(
    String memoryCardId,
  ) : this._internal(
          (ref) => recordItemList(
            ref as RecordItemListRef,
            memoryCardId,
          ),
          from: recordItemListProvider,
          name: r'recordItemListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recordItemListHash,
          dependencies: RecordItemListFamily._dependencies,
          allTransitiveDependencies:
              RecordItemListFamily._allTransitiveDependencies,
          memoryCardId: memoryCardId,
        );

  RecordItemListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.memoryCardId,
  }) : super.internal();

  final String memoryCardId;

  @override
  Override overrideWith(
    FutureOr<List<RecordItem>> Function(RecordItemListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecordItemListProvider._internal(
        (ref) => create(ref as RecordItemListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        memoryCardId: memoryCardId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<RecordItem>> createElement() {
    return _RecordItemListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecordItemListProvider &&
        other.memoryCardId == memoryCardId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, memoryCardId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RecordItemListRef on AutoDisposeFutureProviderRef<List<RecordItem>> {
  /// The parameter `memoryCardId` of this provider.
  String get memoryCardId;
}

class _RecordItemListProviderElement
    extends AutoDisposeFutureProviderElement<List<RecordItem>>
    with RecordItemListRef {
  _RecordItemListProviderElement(super.provider);

  @override
  String get memoryCardId => (origin as RecordItemListProvider).memoryCardId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
