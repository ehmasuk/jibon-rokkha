import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../models/aid_model.dart';

final aidRepositoryProvider = Provider((ref) => AidRepository());

class AidRepository {
  final _firestore = FirebaseFirestore.instance;
  final _uuid = const Uuid();

  Future<void> saveAid(AidModel aid) async {
    final data = aid.toMap();
    data['createdAt'] = FieldValue.serverTimestamp();
    await _firestore.collection('aids').doc(aid.id).set(data);
  }

  String generateId() => _uuid.v4();
}
