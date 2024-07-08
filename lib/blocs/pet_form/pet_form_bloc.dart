import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style/core/helpers/log_helper.dart';
import 'package:pet_style/data/model/pet/pet.dart';
import 'package:pet_style/domain/repository/pet_repository.dart';

part 'pet_form_event.dart';
part 'pet_form_state.dart';

class PetFormBloc extends Bloc<PetFormEvent, PetFormState> {
  final PetRepository petRepository;

  PetFormBloc(this.petRepository) : super(PetFormInitial()) {
    on<LoadBreeds>(
      (event, emit) async {
        emit(PetBreedsLoading());
        try {
          final dogBreeds = await petRepository.loadBreeds('dog_breeds.json');
          final catBreeds = await petRepository.loadBreeds('cat_breeds.json');
          PetFormState.dogBreedsL = dogBreeds;
          PetFormState.catBreedsL = catBreeds;
          emit(PetBreedsLoaded(dogBreeds: dogBreeds, catBreeds: catBreeds));
        } catch (e, st) {
          logHandle(e.toString(), st);
          emit(PetBreedsLoadError(message: e.toString()));
        }
      },
    );

    on<CreatePet>(
      (event, emit) async {
        emit(PetCreating());
        try {
          await petRepository.createPet(event.pet, event.photo);
          emit(PetCreated());
        } catch (e) {
          logDebug('CreatePet error: $e');
          emit(PetCreateError(message: e.toString()));
        }
      },
    );

    on<LoadPet>(
      (event, emit) async {
        emit(PetLoading());
        try {
          PetFormState.loadedPet = await petRepository.getPetById(event.id);
          emit(PetLoaded(PetFormState.loadedPet!));
        } catch (e) {
          logDebug('LoadPet error: $e');
          emit(PetLoadError(message: e.toString()));
        }
      },
    );
  }
}
