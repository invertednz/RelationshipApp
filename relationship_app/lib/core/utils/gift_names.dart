import 'dart:math';

class GiftNames {
  static final Random _random = Random();

  static const List<String> femaleNames = [
    'Emma', 'Olivia', 'Ava', 'Isabella', 'Sophia',
    'Mia', 'Charlotte', 'Amelia', 'Harper', 'Evelyn',
    'Abigail', 'Emily', 'Elizabeth', 'Mila', 'Ella',
    'Avery', 'Sofia', 'Camila', 'Aria', 'Scarlett',
    'Victoria', 'Madison', 'Luna', 'Grace', 'Chloe',
    'Penelope', 'Layla', 'Riley', 'Zoey', 'Nora',
    'Lily', 'Eleanor', 'Hannah', 'Lillian', 'Addison',
    'Aubrey', 'Ellie', 'Stella', 'Natalie', 'Zoe',
    'Leah', 'Hazel', 'Violet', 'Aurora', 'Savannah',
    'Audrey', 'Brooklyn', 'Bella', 'Claire', 'Skylar',
    'Lucy', 'Paisley', 'Everly', 'Anna', 'Caroline',
    'Nova', 'Genesis', 'Emilia', 'Kennedy', 'Samantha',
    'Maya', 'Willow', 'Kinsley', 'Naomi', 'Aaliyah',
    'Elena', 'Sarah', 'Ariana', 'Allison', 'Gabriella',
  ];

  static const List<String> maleNames = [
    'Liam', 'Noah', 'Oliver', 'Elijah', 'James',
    'William', 'Benjamin', 'Lucas', 'Henry', 'Alexander',
    'Mason', 'Michael', 'Ethan', 'Daniel', 'Jacob',
    'Logan', 'Jackson', 'Levi', 'Sebastian', 'Mateo',
    'Jack', 'Owen', 'Theodore', 'Aiden', 'Samuel',
    'Joseph', 'John', 'David', 'Wyatt', 'Matthew',
  ];

  static String getRandomName() {
    // 70% chance of female name, 30% chance of male name
    final isFemale = _random.nextInt(100) < 70;
    
    if (isFemale) {
      return femaleNames[_random.nextInt(femaleNames.length)];
    } else {
      return maleNames[_random.nextInt(maleNames.length)];
    }
  }

  static String getRandomLocation() {
    const locations = [
      'San Francisco, CA',
      'Austin, TX',
      'Portland, OR',
      'Seattle, WA',
      'Denver, CO',
      'Boston, MA',
      'Nashville, TN',
      'Chicago, IL',
      'New York, NY',
      'Los Angeles, CA',
      'Miami, FL',
      'Phoenix, AZ',
      'Philadelphia, PA',
      'San Diego, CA',
      'Minneapolis, MN',
    ];
    return locations[_random.nextInt(locations.length)];
  }
}
