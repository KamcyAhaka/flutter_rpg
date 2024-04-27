import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/models/stats.dart';
import 'package:flutter_rpg/models/vocation.dart';

class Character with Stats {
  // constructor
  Character({required this.name, required this.slogan, required this.vocation, required this.id});

  // fields
	final Set<Skill> skills = {};
	final Vocation vocation;
  final String name;
  final String slogan;
  final String id;

  bool _isFav = false;
  bool _isPublic = true;

  // getters
  bool get isFav => _isFav;

  // getters
  bool get isPublic => _isPublic;

  void toggleIsFav() {
    _isFav = !_isFav;
  }

  void toggleIsPublic() {
    _isPublic = !_isPublic;
  }

	void updateSkill(Skill skill) {
		skills.clear();
		skills.add(skill);
	}

	// make character firestore compliant (map)
	Map<String, dynamic> toFirestore() {
		return {
			"name": name,
			"slogan": slogan,
			"isFav": _isFav,
			"isPublic": _isPublic,
			"vocation": vocation.toString(),
			"skills": skills.map((skill) => skill.id).toList(),
			"stats": statsAsMap,
			"points": points,
		};
	}

	// convert firestore snapshot to character
	factory Character.fromFirestore(		DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
		final data = snapshot.data()!;

		// make character instance
		Character character = Character(
			name: data['name'],
			slogan: data['slogan'],
			id: snapshot.id,
			vocation: Vocation.values.firstWhere((value) => value.toString() == data['vocation']),
		);

		// update skill
		for (String id in data['skills']) {
			Skill skill = allSkills.firstWhere((element) => element.id == id);
			character.updateSkill(skill);
		}

		// set isFav
		if (data['isFav'] == true) {
			character.toggleIsFav();
		}

		// set isPublic
		if (data['isPublic'] == false) {
			character.toggleIsPublic();
		}

		// assign stats and points
		character.setStats(points: data['points'], stats: data['stats']);

		return character;
	}
}
