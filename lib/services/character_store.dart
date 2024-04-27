import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/services/firestore_services.dart';

class CharacterStore extends ChangeNotifier {

	final List<Character> _characters = [
	];

	get characters => _characters;

	// TODO: add character
	void addCharacter(Character character) {
		FirestoreService.addCharacter(character);

		_characters.add(character);
		notifyListeners();
	}

	// TODO: save (update) character
	Future<void> saveCharacter(Character character) async {
		await FirestoreService.updateCharacter(character);
		return;
	}

	// TODO: remove character
	void removeCharacter(Character character) async {
		await FirestoreService.deleteCharacter(character);

		_characters.remove(character);
		notifyListeners();	
	}


	// TODO: initially fetch character
	void fetchCharactersOnce() async {
		if (characters.length == 0) {
			final snapshot = await FirestoreService.getCharactersOnce();

			for (var doc in snapshot.docs) {
				_characters.add(doc.data());
			}
			notifyListeners();
		}
	}

}
