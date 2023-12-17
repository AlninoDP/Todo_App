import 'package:uuid/uuid.dart';

class UniqueId {
  final String value;

  // private constructor
  const UniqueId._(this.value);

  factory UniqueId() {
    return UniqueId._(const Uuid().v4());
  }

  factory UniqueId.fromUniqueString(String uniqueString) {
    return UniqueId._(uniqueString);
  }
}

class CollectionId extends UniqueId {
  // private constructor
  const CollectionId._(String value) : super._(value);

  factory CollectionId() {
    return CollectionId._(const Uuid().v4());
  }

  factory CollectionId.fromUniqueString(String uniqueString) {
    return CollectionId._(uniqueString);
  }
}

class EntryId extends UniqueId {
  // private constructor
  const EntryId._(String value) : super._(value);

  factory EntryId() {
    return EntryId._(const Uuid().v4());
  }

  factory EntryId.fromUniqueString(String uniqueString) {
    return EntryId._(uniqueString);
  }
}
