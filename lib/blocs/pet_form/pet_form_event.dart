// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pet_form_bloc.dart';

sealed class PetFormEvent extends Equatable {
  const PetFormEvent();

  @override
  List<Object> get props => [];
}

class LoadBreeds extends PetFormEvent {}

class CreatePet extends PetFormEvent {
  final Pet pet;
  final File photo;

  const CreatePet({
    required this.pet,
    required this.photo,
  });
}

class LoadPet extends PetFormEvent {
  final String id;

  const LoadPet(this.id);

  @override
  List<Object> get props => [id];
}