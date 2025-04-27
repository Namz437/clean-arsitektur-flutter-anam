import 'package:cek/features/gudang/domain/entities/gudang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GudangModel extends Gudang {
  const GudangModel(
      {required super.id,
      required super.kodeGudang,
      required super.namaGudang,
      required super.kota,
      required super.kapasitas,
      required super.suplierUid});

  factory GudangModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GudangModel(
        id: doc.id,
        kodeGudang: data['kodeGudang'],
        namaGudang: data['namaGudang'],
        kota: data['kota'],
        kapasitas: data['kapasitas'],
        suplierUid: data['suplierUid']);
  }

  Map<String, dynamic> toFireStore() {
    return {
      'kodeGudang': kodeGudang,
      'namaGudang': namaGudang,
      'kota': kota,
      'kapasitas': kapasitas,
      if (suplierUid != null) 'suplierUid': suplierUid
    };
  }
}
