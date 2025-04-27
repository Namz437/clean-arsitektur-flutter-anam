part of 'gudang_bloc.dart';

abstract class GudangState extends Equatable {}
class GudangInitial extends GudangState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GudangStateLoading extends GudangState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GudangStateError extends GudangState {
  final String message;

  GudangStateError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class GudangStateLoadedAll extends GudangState {
  final List<Gudang> gudangs;

  GudangStateLoadedAll({required this.gudangs});

  @override
  // TODO: implement props
  List<Object?> get props => [gudangs];
}

class GudangStateLoaded extends GudangState {
  final Gudang gudangs;

  GudangStateLoaded({required this.gudangs});

  @override
  // TODO: implement props
  List<Object?> get props => [gudangs];
}

class GudangStateSuccess extends GudangState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
