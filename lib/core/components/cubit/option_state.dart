part of 'option_cubit.dart';

sealed class OptionState extends Equatable {
  const OptionState();

  @override
  List<Object> get props => [];
}

final class OptionInitial extends OptionState {}
