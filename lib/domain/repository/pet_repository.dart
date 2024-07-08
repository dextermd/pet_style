
import 'dart:io';

import 'package:pet_style/data/model/pet/pet.dart';

abstract interface class PetRepository {
  Future<void> createPet(Pet pet, File photo);
  Future<Pet> getPetById(String petId);
  Future<List<String>> loadBreeds(String fileName);
}
