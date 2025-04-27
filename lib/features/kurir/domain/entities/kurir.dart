import 'package:equatable/equatable.dart';

class Kurir extends Equatable{
  final String id;
  final String namaKurir;
  final String email;
  final String noTelpon;
  final String? gudangUid;

  const Kurir(
      {required this.id,
      required this.namaKurir,
      required this.email,
      required this.noTelpon,
      this.gudangUid
      });
      
        @override
        List<Object?> get props => [id, namaKurir, email, noTelpon, gudangUid];
}
