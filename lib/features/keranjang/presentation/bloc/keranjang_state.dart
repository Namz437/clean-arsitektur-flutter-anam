part of 'keranjang_bloc.dart';

abstract class KeranjangState extends Equatable {}

class KeranjangInitial extends KeranjangState {
  @override
  List<Object?> get props => [];
}

class KeranjangStateLoading extends KeranjangState {
  @override
  List<Object?> get props => [];
}

class KeranjangStateError extends KeranjangState {
  final String message;

  KeranjangStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class KeranjangStateLoadedAll extends KeranjangState {
  final List<Keranjang> keranjangs;

  KeranjangStateLoadedAll({required this.keranjangs});

  @override
  List<Object?> get props => [keranjangs];
}

class KeranjangStateLoaded extends KeranjangState {
  final Keranjang keranjang;

  KeranjangStateLoaded({required this.keranjang});

  @override
  List<Object?> get props => [keranjang];
}

class KeranjangStateSuccess extends KeranjangState {
  @override
  List<Object?> get props => [];
}