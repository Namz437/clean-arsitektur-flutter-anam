import 'package:cek/features/favorite/domain/entities/favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel extends Favorite {
  final bool isNew;
  const FavoriteModel({
    required super.id,
    super.produkId,
    super.createdAt,
    super.updatedAt,
    this.isNew = false,
  });

  factory FavoriteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteModel(
      id: doc.id,
      produkId: data['produkId'] ?? '', 
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      isNew: false,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'produkId': produkId ?? '', 
      'createdAt': isNew
          ? FieldValue.serverTimestamp()
          : (createdAt != null
              ? Timestamp.fromDate(createdAt!)
              : FieldValue.serverTimestamp()),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
