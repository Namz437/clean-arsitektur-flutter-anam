import 'package:cek/features/kurir/domain/entities/kurir.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KurirModel extends Kurir {
  const KurirModel({
    required super.id,
    required super.namaKurir,
    required super.email,
    required super.noTelpon,
    required super.gudangUid
    
  });

  factory KurirModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return KurirModel(
        id: doc.id,
        namaKurir: data['namaKurir'],
        email: data['email'],
        noTelpon: data['noTelpon'],
        gudangUid: data['gudangUid'] ?? '',
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'namaKurir': namaKurir,
      'email': email,
      'noTelpon': noTelpon,
       if (gudangUid != null) 'gudangUid': gudangUid
    };
  }
}
