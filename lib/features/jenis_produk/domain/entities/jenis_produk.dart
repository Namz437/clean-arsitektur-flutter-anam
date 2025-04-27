import 'package:equatable/equatable.dart';

class JenisProduk extends Equatable{
  final String id;
  final String namaJenis;
  final String deskripsi;
  

  const JenisProduk(
      {required this.id,
      required this.namaJenis,
      required this.deskripsi,
      });
      
        @override
        List<Object?> get props => [id, namaJenis, deskripsi];
}
