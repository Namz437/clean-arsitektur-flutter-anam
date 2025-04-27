import 'package:cek/features/keranjang/domain/entities/keranjang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KeranjangModel extends Keranjang {
  final bool isNew;
  const KeranjangModel({
    required super.id,
    super.produkUid,
    required super.jumlah,
    super.harga,
    super.createdAt,
    super.updatedAt,
    this.isNew = false,
  });

  factory KeranjangModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return KeranjangModel(
      id: doc.id,
      produkUid: data['produkUid,'] ?? '',
      jumlah: data['jumlah'],
      harga: data['harga'] != null ? data['harga']?.toDouble() : null, 
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
      'produkUid,': produkUid ?? '',
      'jumlah': jumlah,
      'harga': harga,
      'createdAt': isNew
          ? FieldValue.serverTimestamp()
          : (createdAt != null
              ? Timestamp.fromDate(createdAt!)
              : FieldValue.serverTimestamp()),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}