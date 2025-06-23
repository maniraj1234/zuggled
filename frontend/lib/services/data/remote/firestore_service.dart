import 'package:cloud_firestore/cloud_firestore.dart';
// import 'firestore_exception.dart';

/// Abstract class for universal Firestore service.
/// This call will handle the direct interaction with FirebaseFirestore.
/// This service operates on raw Map&lt;String, dynamic&gt; and DocumentSnapshot data.
abstract class IFirestoreService {
  /// Sets or updates a document in a specified collzzection.
  /// If [docId] is null or empty, Firestore generates one.
  /// [merge] determines if new data is merged with existing or overwrites.
  /// Returns the ID of the document.
  Future<String> setDocument({
    required String collectionPath,
    String? docId,
    required Map<String, dynamic> data,
    bool merge, // Marked as required for clarity in implementation
  });

  /// Retrieves a single document by its ID from a specified collection.
  /// Returns null if the document does not exist.
  Future<DocumentSnapshot?> getDocument({
    required String collectionPath,
    required String docId,
  });

  /// Retrieves a list of documents from a collection, optionally with queries, ordering, and limit.
  /// [queries] is a list of maps, e.g., [{'field': 'callerId', 'op': '==', 'value': 'userA'}]
  /// [orderBy] is a list of maps, e.g., [{'field': 'timestamp', 'descending': true}]
  /// [startAfterDocument] for pagination.
  Future<List<DocumentSnapshot>> getDocuments({
    required String collectionPath,
    List<Map<String, dynamic>>? queries,
    List<Map<String, dynamic>>? orderBy,
    int? limit,
    DocumentSnapshot? startAfterDocument,
  });

  /// Retrieves a stream of documents from a collection, optionally with queries, ordering, and limit.
  Stream<List<DocumentSnapshot>> streamDocuments({
    required String collectionPath,
    List<Map<String, dynamic>>? queries,
    List<Map<String, dynamic>>? orderBy,
    int? limit,
    DocumentSnapshot? startAfterDocument,
  });

  /// Updates specific fields of an existing document.
  /// Throws an error if the document does not exist.
  Future<void> updateDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> dataToUpdate,
  });

  /// Deletes a document from a specified collection.
  Future<void> deleteDocument({
    required String collectionPath,
    required String docId,
  });
}
