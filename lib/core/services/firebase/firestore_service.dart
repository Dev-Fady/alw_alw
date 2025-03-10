import 'dart:developer';

import 'package:alw_alw/core/error/exceptions.dart';
import 'package:alw_alw/core/services/firebase/data_base_service_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService implements DataBaseServiceRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //~ Add a new document
  @override
  Future<void> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      if (documentId != null) {
        await _firestore.collection(collectionPath).doc(documentId).set(data);
      } else {
        await _firestore.collection(collectionPath).add(data);
      }
      log('Document added successfully');
    } catch (e) {
      log('Exception in addDocument: $e');
      throw CustomException(message: 'حدث خطأ أثناء إضافة البيانات.');
    }
  }

  //~ Get a single document by ID
  @override
  Future<Map<String, dynamic>?> getDocumentById({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      final docSnapshot =
          await _firestore.collection(collectionPath).doc(documentId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      log('Exception in getDocumentById: $e');
      throw CustomException(message: 'حدث خطأ أثناء جلب البيانات.');
    }
  }

  //~ Get all documents from a collection
  @override
  Future<List<Map<String, dynamic>>> getAllDocuments({
    required String collectionPath,
  }) async {
    try {
      final querySnapshot = await _firestore.collection(collectionPath).get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();
    } catch (e) {
      log('Exception in getAllDocuments: $e');
      throw CustomException(message: 'حدث خطأ أثناء جلب البيانات.');
    }
  }

  //~ Update a document
  @override
  Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).update(data);
      log('Document updated successfully');
    } catch (e) {
      log('Exception in updateDocument: $e');
      throw CustomException(message: 'حدث خطأ أثناء تحديث البيانات.');
    }
  }

  //~ Delete a document
  @override
  Future<void> deleteDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
      log('Document deleted successfully');
    } catch (e) {
      log('Exception in deleteDocument: $e');
      throw CustomException(message: 'حدث خطأ أثناء حذف البيانات.');
    }
  }

  //~ Check if a document exists
  @override
  Future<bool> checkIfDataExists(
      {required String path, required String documentId}) async {
    var data = await _firestore.collection(path).doc(documentId).get();
    return data.exists;
  }

  //~ Search documents by field
  @override
  Future<List<Map<String, dynamic>>> searchDocuments({
    required String collectionPath,
    required String field,
    required String value,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection(collectionPath)
          .where(field, isEqualTo: value)
          .get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();
    } catch (e) {
      log('Exception in searchDocuments: $e');
      throw CustomException(message: 'حدث خطأ أثناء البحث.');
    }
  }

  //~ Listen to a specific document changes
  @override
  Stream<Map<String, dynamic>?> listenToDocument({
    required String collectionPath,
    required String documentId,
  }) {
    try {
      return _firestore
          .collection(collectionPath)
          .doc(documentId)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          return snapshot.data() as Map<String, dynamic>;
        }
        return null;
      });
    } catch (e) {
      log('Exception in listenToDocument: $e');
      throw CustomException(message: 'حدث خطأ أثناء الاستماع للتغييرات.');
    }
  }

  //~ Listen to changes in a collection
  @override
  Stream<List<Map<String, dynamic>>> listenToCollection({
    required String collectionPath,
  }) {
    try {
      return _firestore
          .collection(collectionPath)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs
            .map((doc) => {'id': doc.id, ...doc.data()})
            .toList();
      });
    } catch (e) {
      log('Exception in listenToCollection: $e');
      throw CustomException(
          message: 'حدث خطأ أثناء الاستماع لتغييرات المجموعة.');
    }
  }

  //~ Advanced Query (Filtering and Sorting)
  @override
  Future<List<Map<String, dynamic>>> getDocumentsWithFilterAndSort({
    required String collectionPath,
    String? filterField,
    dynamic filterValue,
    String? sortField,
    bool descending = false,
  }) async {
    try {
      Query query = _firestore.collection(collectionPath);

      // Apply filter if provided
      if (filterField != null && filterValue != null) {
        query = query.where(
          filterField,
          // isEqualTo: filterValue,
          isGreaterThan: filterValue,
        );
      }

      // Apply sorting if provided
      if (sortField != null) {
        query = query.orderBy(sortField, descending: descending);
      }

      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      log('Exception in getDocumentsWithFilterAndSort: $e');
      throw CustomException(message: 'حدث خطأ أثناء جلب البيانات.');
    }
  }

  //~ Paginate through large collections
  @override
  Future<List<Map<String, dynamic>>> paginateDocuments({
    required String collectionPath,
    required String orderByField,
    int limit = 10,
    dynamic startAfterDocument,
  }) async {
    try {
      Query query = _firestore
          .collection(collectionPath)
          .orderBy(orderByField)
          .limit(limit);

      if (startAfterDocument != null) {
        query =
            query.startAfterDocument(startAfterDocument as DocumentSnapshot);
      }

      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      log('Exception in paginateDocuments: $e');
      throw CustomException(message: 'حدث خطأ أثناء جلب البيانات.');
    }
  }
}