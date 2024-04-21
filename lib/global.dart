List<Map<String, dynamic>> items = [];

void storeSymptoms({int? painLevel, int? fatigueLevel, String? mood}) {
  items.add({
    'painLevel': painLevel,
    'fatigueLevel': fatigueLevel,
    'mood': mood,
    'timestamp': DateTime.now(),
  });
}