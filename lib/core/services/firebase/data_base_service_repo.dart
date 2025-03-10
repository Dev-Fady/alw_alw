abstract class DataBaseServiceRepo {
  /// Add a new document to the database
  Future<void> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? documentId,
  });

  /// Get a single document by its ID
  Future<Map<String, dynamic>?> getDocumentById({
    required String collectionPath,
    required String documentId,
  });

  /// Get all documents from a specific collection
  Future<List<Map<String, dynamic>>> getAllDocuments({
    required String collectionPath,
  });

  /// Update an existing document by its ID
  Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  });

  /// Delete a document by its ID
  Future<void> deleteDocument({
    required String collectionPath,
    required String documentId,
  });

  /// Check if a document exists in the database
  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  });

  /// Search documents by a specific field and value
  Future<List<Map<String, dynamic>>> searchDocuments({
    required String collectionPath,
    required String field,
    required String value,
  });

  /// Listen to changes in a specific document
  Stream<Map<String, dynamic>?> listenToDocument({
    required String collectionPath,
    required String documentId,
  });

  /// Listen to changes in a collection
  Stream<List<Map<String, dynamic>>> listenToCollection({
    required String collectionPath,
  });

  /// Get documents with filtering and sorting options
  Future<List<Map<String, dynamic>>> getDocumentsWithFilterAndSort({
    required String collectionPath,
    String? filterField,
    dynamic filterValue,
    String? sortField,
    bool descending = false,
  });

  /// Paginate through a large collection
  Future<List<Map<String, dynamic>>> paginateDocuments({
    required String collectionPath,
    required String orderByField,
    int limit = 10,
    // ignore: unnecessary_question_mark
    dynamic? startAfterDocument,
  });
}