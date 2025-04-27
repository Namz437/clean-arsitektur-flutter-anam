import 'package:equatable/equatable.dart';

class Gudang extends Equatable{
  final String id;
  final String kodeGudang;
  final String namaGudang;
  final String kota;
  final String kapasitas;
  final String? suplierUid;


  const Gudang(
      {required this.id,
      required this.kodeGudang,
      required this.namaGudang,
      required this.kota,
      required this.kapasitas,
      this.suplierUid
      });
      
        @override
        List<Object?> get props => [id, kodeGudang, namaGudang, kota, kapasitas, suplierUid];
}
