import 'package:cek/features/kurir/data/models/kurir_model.dart';
import 'package:cek/features/kurir/domain/entities/kurir.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class KurirRemoteDataSource {
  Future<List<Kurir>> getAllKurir();
  Future<Kurir> getKurirById({required String id});
  // void tidak ada pengembalian
  Future<void> addKurir({required KurirModel kurir});
  Future<void> editKurir({required KurirModel kurir});
  Future<void> deleteKurir({required String id});
}

class KurirRemoteDataSourceImplementation implements KurirRemoteDataSource {
  //menggunakan firebase fire store
  final FirebaseFirestore firebaseFirestore;

  KurirRemoteDataSourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addKurir({required KurirModel kurir}) async {
    await firebaseFirestore.collection('kurirs').add(kurir.toFireStore());
  }

  @override
  Future<void> deleteKurir({required String id}) async {
    await firebaseFirestore.collection('kurirs').doc(id).delete();
  }

  @override
  Future<void> editKurir({required KurirModel kurir}) async {
    await firebaseFirestore
        .collection('kurirs')
        .doc(kurir.id)
        .update(kurir.toFireStore());
  }

  @override
  Future<List<Kurir>> getAllKurir() async {
    final data = await firebaseFirestore.collection('kurirs').get();
    return data.docs
        .map(
          (e) => KurirModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Kurir> getKurirById({required String id}) async {
    final data = await firebaseFirestore.collection('kurirs').doc(id).get();
    return KurirModel.fromFirestore(data);
  }
}