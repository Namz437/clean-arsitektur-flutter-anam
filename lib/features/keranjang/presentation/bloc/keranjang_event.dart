part of 'keranjang_bloc.dart';

abstract class KeranjangEvent extends Equatable {}

class KeranjangEventAdd extends KeranjangEvent {
  final KeranjangModel keranjangModel;

  KeranjangEventAdd({required this.keranjangModel});

  @override
  List<Object?> get props => [keranjangModel];
}

class KeranjangEventEdit extends KeranjangEvent {
  final KeranjangModel keranjangModel;

  KeranjangEventEdit({required this.keranjangModel});

  @override
  List<Object?> get props => [keranjangModel];
}

class KeranjangEventDelete extends KeranjangEvent {
  final String id;

  KeranjangEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class KeranjangEventGetAll extends KeranjangEvent {
  @override
  List<Object?> get props => [];
}

class KeranjangEventGetById extends KeranjangEvent {
  final String id;

  KeranjangEventGetById({required this.id});
  @override
  List<Object?> get props => [id];
}