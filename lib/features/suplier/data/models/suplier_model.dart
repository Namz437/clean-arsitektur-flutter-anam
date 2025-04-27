import 'package:cek/features/suplier/domain/entities/suplier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuplierModel extends Suplier {
  const SuplierModel(
      {required super.id,
      required super.namaSuplier,
      required super.nomorTelpon,
      required super.alamat,
      });

  factory SuplierModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SuplierModel(
        id: doc.id,
        namaSuplier: data['namaSuplier'],
        nomorTelpon: data['nomorTelpon'],
        alamat: data['alamat'],
      );
  }

  Map<String, dynamic> toFireStore() {
    return {'namaSuplier': namaSuplier, 'nomorTelpon': nomorTelpon, 'alamat': alamat};
  }
}