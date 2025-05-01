import 'package:bloc/bloc.dart';
import 'package:cek/features/keranjang/data/models/keranjang_model.dart';
import 'package:cek/features/keranjang/domain/entities/keranjang.dart';
import 'package:cek/features/keranjang/domain/usecases/keranjang_usecase.dart';
import 'package:equatable/equatable.dart';

part 'keranjang_event.dart';
part 'keranjang_state.dart';

class KeranjangBloc extends Bloc<KeranjangEvent, KeranjangState> {
  final KeranjangUsecasesAddKeranjang keranjangUsecasesAdd;
  final KeranjangUsecasesEditKeranjang keranjangUsecasesEditKeranjang;
  final KeranjangUsecasesDeleteKeranjang keranjangUsecasesDeleteKeranjang;
  final KeranjangUsecasesGetAll keranjangUsecasesGetAll;
  final KeranjangUsecasesGetById keranjangUsecasesGetById;
  KeranjangBloc(
      {required this.keranjangUsecasesAdd,
      required this.keranjangUsecasesEditKeranjang,
      required this.keranjangUsecasesDeleteKeranjang,
      required this.keranjangUsecasesGetAll,
      required this.keranjangUsecasesGetById})
      : super(KeranjangInitial()) {
    on<KeranjangEventAdd>((event, emit) async {
      emit(KeranjangStateLoading());
      final data =
          await keranjangUsecasesAdd.execute(keranjang: event.keranjangModel);
      data.fold(
        (l) {
          emit(KeranjangStateError(message: l.toString()));
        },
        (r) {
          emit(KeranjangStateSuccess());

          add(KeranjangEventGetAll());
        },
      );
    });
    on<KeranjangEventEdit>((event, emit) async {
      emit(KeranjangStateLoading());
      final data = await keranjangUsecasesEditKeranjang.execute(
          keranjang: event.keranjangModel);
      data.fold(
        (l) {
          emit(KeranjangStateError(message: l.toString()));
        },
        (r) {
          emit(KeranjangStateSuccess());

          add(KeranjangEventGetAll());
        },
      );
    });
    on<KeranjangEventDelete>((event, emit) async {
      emit(KeranjangStateLoading());
      final data = await keranjangUsecasesDeleteKeranjang.execute(id: event.id);
      data.fold(
        (l) {
          emit(KeranjangStateError(message: l.toString()));
        },
        (r) {
          emit(KeranjangStateSuccess());

          add(KeranjangEventGetAll());
        },
      );
    });
    on<KeranjangEventGetAll>((event, emit) async {
      emit(KeranjangStateLoading());
      final data = await keranjangUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(KeranjangStateError(message: l.toString()));
        },
        (r) {
          emit(KeranjangStateLoadedAll(keranjangs: r));
        },
      );
    });
    on<KeranjangEventGetById>((event, emit) async {
      emit(KeranjangStateLoading());
      final data = await keranjangUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(KeranjangStateError(message: l.toString()));
        },
        (r) {
          emit(KeranjangStateLoaded(keranjang: r));
        },
      );
    });
  }
}
