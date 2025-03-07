import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../data/models/machineForm.dart';
import '../../../data/repository/machineRepo.dart';

part 'machine_state.dart';

class MachineCubit extends Cubit<MachineState> {
  final MachineRepository machineRepository;

  MachineCubit(this.machineRepository) : super(MachineInitial());

  Future<void> sendMachineImage(String imageBase64) async {
    emit(MachinesLoading());
    try {
      final machine = await machineRepository.sendMachineImage(imageBase64);

      if (machine.machineForms != null && machine.machineForms!.isNotEmpty) {
        emit(MultiMachineSuccess(
          machineName: machine.machineName,
          machineForms: machine.machineForms!,
        ));
      } else if (machine.machineVideo != null && machine.machineVideo!.isNotEmpty) {
        emit(SingleMachineSuccess(
          machineName: machine.machineName,
          machineVideos: machine.machineVideo!,
        ));
      }
    } catch (e) {
      log(e.toString());
      emit(MachineFailure(e.toString()));
    }
  }
}