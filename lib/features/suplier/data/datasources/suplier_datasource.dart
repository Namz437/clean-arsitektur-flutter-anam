import 'package:cek/features/suplier/data/models/suplier_model.dart';
import 'package:cek/features/suplier/domain/entities/suplier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SuplierRemoteDataSource {
  Future<List<Suplier>> getAllSuplier();
  Future<Suplier> getSuplierById({required String id});
  // void tidak ada pengembalian
  Future<void> addSuplier({required SuplierModel suplier});
  Future<void> editSuplier({required SuplierModel suplier});
  Future<void> deleteSuplier({required String id});
}

class SuplierRemoteDataSourceImplementation implements SuplierRemoteDataSource {
  //menggunakan firebase fire store
  final FirebaseFirestore firebaseFirestore;

  SuplierRemoteDataSourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addSuplier({required SuplierModel suplier}) async {
    await firebaseFirestore.collection('supliers').add(suplier.toFireStore());
  }

  @override
  Future<void> deleteSuplier({required String id}) async {
    await firebaseFirestore.collection('supliers').doc(id).delete();
  }

  @override
  Future<void> editSuplier({required SuplierModel suplier}) async {
    await firebaseFirestore
        .collection('supliers')
        .doc(suplier.id)
        .update(suplier.toFireStore());
  }

  @override
  Future<List<Suplier>> getAllSuplier() async {
    final data = await firebaseFirestore.collection('supliers').get();
    return data.docs
        .map(
          (e) => SuplierModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Suplier> getSuplierById({required String id}) async {
    final data = await firebaseFirestore.collection('supliers').doc(id).get();
    return SuplierModel.fromFirestore(data);
  }
}