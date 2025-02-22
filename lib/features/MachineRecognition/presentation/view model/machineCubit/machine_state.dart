part of 'machine_cubit.dart';

abstract class MachineState {}

final class MachineInitial extends MachineState {}

final class MachinesLoading extends MachineState {}

final class SingleMachineSuccess extends MachineState {
  final String machineName;
  final List<String> machineVideos;

  SingleMachineSuccess({
    required this.machineName,
    required this.machineVideos,
  });
}

final class MultiMachineSuccess extends MachineState {
  final String machineName;
  final List<MachineForm> machineForms;

  MultiMachineSuccess({
    required this.machineName,
    required this.machineForms,
  });
}

final class MachineFailure extends MachineState {
  final String error;
  MachineFailure(this.error);
}