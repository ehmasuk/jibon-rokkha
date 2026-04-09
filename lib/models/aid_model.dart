class AidStep {
  final int step;
  final String title;
  final String description;

  const AidStep({
    required this.step,
    required this.title,
    required this.description,
  });

  factory AidStep.fromMap(Map<String, dynamic> map) {
    return AidStep(
      step: map['step'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'step': step,
      'title': title,
      'description': description,
    };
  }
}

class AidModel {
  final String id;
  final String category;
  final String title;
  final String subtitle;
  final String overview;
  final List<String> symptoms;
  final List<AidStep> steps;
  final List<String> dos;
  final List<String> donts;
  final List<String> whenToSeekHelp;

  const AidModel({
    required this.id,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.overview,
    required this.symptoms,
    required this.steps,
    required this.dos,
    required this.donts,
    required this.whenToSeekHelp,
  });

  factory AidModel.fromMap(Map<String, dynamic> map, String id) {
    return AidModel(
      id: id,
      category: map['category'] ?? '',
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      overview: map['overview'] ?? '',
      symptoms: List<String>.from(map['symptoms'] ?? []),
      steps: (map['steps'] as List?)?.map((x) => AidStep.fromMap(Map<String,dynamic>.from(x))).toList() ?? [],
      dos: List<String>.from(map['dos'] ?? []),
      donts: List<String>.from(map['donts'] ?? []),
      whenToSeekHelp: List<String>.from(map['when_to_seek_help'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'title': title,
      'subtitle': subtitle,
      'overview': overview,
      'symptoms': symptoms,
      'steps': steps.map((x) => x.toMap()).toList(),
      'dos': dos,
      'donts': donts,
      'when_to_seek_help': whenToSeekHelp,
    };
  }
}
