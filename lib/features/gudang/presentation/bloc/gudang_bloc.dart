import 'package:bloc/bloc.dart';
import 'package:cek/features/gudang/data/models/gudang_model.dart';
import 'package:cek/features/gudang/domain/entities/gudang.dart';
import 'package:cek/features/gudang/domain/usecases/gudang_usecase.dart';
import 'package:equatable/equatable.dart';

part 'gudang_event.dart';
part 'gudang_state.dart';

class GudangBloc extends Bloc<GudangEvent, GudangState> {
  final GudangUsecasesAddGudang gudangUsecasesAdd;
  final GudangUsecasesEditGudang gudangUsecasesEditGudang;
  final GudangUsecasesDeleteGudang gudangUsecasesDeleteGudang;
  final GudangUsecasesGetAll gudangUsecasesGetAll;
  final GudangUsecasesGetById gudangUsecasesGetById;
  GudangBloc(
      {required this.gudangUsecasesAdd,
      required this.gudangUsecasesEditGudang,
      required this.gudangUsecasesDeleteGudang,
      required this.gudangUsecasesGetAll,
      required this.gudangUsecasesGetById})
      : super(GudangInitial()) {
    on<GudangEventAdd>((event, emit) async {
      emit(GudangStateLoading());
      final data = await gudangUsecasesAdd.execute(gudang: event.gudangModel);
      data.fold(
        (l) {
          emit(GudangStateError(message: l.toString()));
        },
        (r) {
          emit(GudangStateSuccess());
        },
      );
    });
    on<GudangEventEdit>((event, emit) async {
      emit(GudangStateLoading());
      final data =
          await gudangUsecasesEditGudang.execute(gudang: event.gudangModel);
      data.fold(
        (l) {
          emit(GudangStateError(message: l.toString()));
        },
        (r) {
          emit(GudangStateSuccess());
        },
      );
    });
    on<GudangEventDelete>((event, emit) async {
      emit(GudangStateLoading());
      final data = await gudangUsecasesDeleteGudang.execute(id: event.id);
      data.fold(
        (l) {
          emit(GudangStateError(message: l.toString()));
        },
        (r) {
          emit(GudangStateSuccess());
        },
      );
    });
    on<GudangEventGetAll>((event, emit) async {
      emit(GudangStateLoading());
      final data = await gudangUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(GudangStateError(message: l.toString()));
        },
        (r) {
          emit(GudangStateLoadedAll(gudangs: r));
        },
      );
    });
    on<GudangEventGetById>((event, emit) async {
      emit(GudangStateLoading());
      final data = await gudangUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(GudangStateError(message: l.toString()));
        },
        (r) {
          emit(GudangStateLoaded(gudangs: r));
        },
      );
    });
  }
}



