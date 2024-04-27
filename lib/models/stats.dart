mixin Stats {
  int _health = 10;
  int _attack = 10;
  int _defense = 10;
  int _skill = 10;
  int _points = 10;

  // getters
  int get points => _points;

  Map<String, int> get statsAsMap => {
        "health": _health,
        "attack": _attack,
        "defense": _defense,
        "skill": _skill,
      };

  List<Map<String, String>> get statsAsFormattedList => [
        {"title": "health", "value": _health.toString()},
        {"title": "attack", "value": _attack.toString()},
        {"title": "defense", "value": _defense.toString()},
        {"title": "skill", "value": _skill.toString()},
      ];

  void increaseStat(String stat) {
    if (_points > 0) {
      if (stat == 'health') {
        _health++;
				_points--;
      }
      if (stat == 'attack') {
        _attack++;
				_points--;
      }
      if (stat == 'defense') {
        _defense++;
				_points--;
      }
      if (stat == 'skill') {
        _skill++;
				_points--;
      }
    }
  }

  void decreaseStat(String stat) {
    if (stat == 'health' && _health > 5) {
      _health--;
      _points++;
    }
    if (stat == 'attack' && _attack > 5) {
      _attack--;
      _points++;
    }
    if (stat == 'defense' && _defense > 5) {
      _defense--;
      _points++;
    }
    if (stat == 'skill' && _skill > 5) {
      _skill--;
      _points++;
    }
  }

	void setStats({required int points, required Map<String, dynamic> stats}) {
		_points = points;
		_health = stats['health'];
		_attack = stats['attack'];
		_defense = stats['defense'];
		_skill = stats['skill'];
	}
}
