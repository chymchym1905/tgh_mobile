// Helper function to flatten a map of lists into a single list.
List<T> _flatMap<T>(Map<dynamic, List<T>> map) {
  return map.values.expand((list) => list).toList();
}

// Helper function to omit specified keys from a map.
Map<K, V> _omit<K, V>(Map<K, V> map, List<K> keysToOmit) {
  final newMap = <K, V>{};
  map.forEach((key, value) {
    if (!keysToOmit.contains(key)) {
      newMap[key] = value;
    }
  });
  return newMap;
}

const MOB_LIST = {
  'Slimes': [
    'Pyro Slime',
    'Large Pyro Slime',
    'Cryo Slime',
    'Large Cryo Slime',
    'Hydro Slime',
    'Large Hydro Slime',
    'Electro Slime',
    'Large Electro Slime',
    'Geo Slime',
    'Large Geo Slime',
    'Dendro Slime',
    'Large Dendro Slime',
    'Anemo Slime',
    'Large Anemo Slime',
    'Mutant Electro Slime'
  ],
  'Hilichurls': [
    'Pyro Hilichurl Shooter',
    'Stonehide Lawachurl',
    'Rock Shield Hilichurl Guard',
    'Hilichurl Shooter',
    'Hilichurl Fighter',
    'Hilichurl Berserker',
    'Hilichurl Grenadier',
    'Cryo Hilichurl Shooter',
    'Wooden Shield Hilichurl Guard',
    'Electro Hilichurl Shooter',
    'Geo Samachurl',
    'Hydro Samachurl',
    'Dendro Samachurl',
    'Anemo Samachurl',
    'Blazing Axe Mitachurl',
    'Rock Shieldwall Mitachurl',
    'Wooden Shield Mitachurl',
    'Hilichurl Chieftain',
    'Unusual Hilichurl',
    'Frostarm Lawachurl',
    'Cryo Samachurl',
    'Ice Shield Hilichurl Guard',
    'Cryo Hilichurl Grenadier',
    'Ice Shieldwall Mitachurl',
    'Hilichurl',
    'Electro Hilichurl Grenadier',
    'Thunderhelm Lawachurl',
    'Electro Samachurl',
    'Crackling Axe Mitachurl',
    'Anemo Hilichurl Rogue',
    'Hydro Hilichurl Rogue'
  ],
  'The Abyss': [
    'Pyro Abyss Mage',
    'Cryo Abyss Mage',
    'Electro Abyss Mage',
    'Hydro Abyss Mage',
    'Abyss Herald: Wicked Torrents',
    'Abyss Lector: Violet Lightning',
    'Abyss Lector: Fathomless Flames'
  ],
  'Rifthounds': [
    'Rockfond Rifthound Whelp',
    'Rockfond Rifthound',
    'Thundercraven Rifthound Whelp',
    'Thundercraven Rifthound'
  ],
  'Black Serpent Knight and Shadowy Husks': [
    'Shadowy Husk: Standard Bearer',
    'Shadowy Husk: Line Breaker',
    'Shadowy Husk: Defender',
    'Black Serpent Knight: Windcutter'
  ],
  'Treasure Hoarders': [
    'Treasure Hoarders - Pyro Potioneer',
    'Treasure Hoarders - Seaman',
    'Treasure Hoarders - Marksman',
    'Treasure Hoarders - Handyman',
    'Treasure Hoarders - Hydro Potioneer',
    'Treasure Hoarders - Scout',
    'Treasure Hoarders - Gravedigger',
    'Treasure Hoarders - Cryo Potioneer',
    'Treasure Hoarders - Crusher',
    'Treasure Hoarders - Electro Potioneer',
    'Treasure Hoarders - Pugilist'
  ],
  'Nobushi': [
    'Kairagi: Dancing Thunder',
    'Kairagi: Fiery Might',
    'Nobushi: Kikouban',
    'Nobushi: Jintouban',
    'Nobushi: Hitsukeban'
  ],
  'Fatui': [
    'Fatui Pyro Agent',
    'Fatui Skirmisher (Cryo-Gunner Legionnaire)',
    'Fatui Skirmisher (Hydro-Gunner Legionnaire)',
    'Fatui Skirmisher (Electro-Hammer Vanguard)',
    'Fatui Skirmisher (Pyro-Slinger Bracer)',
    'Fatui Skirmisher (Anemoboxer Vanguard)',
    'Fatui Electro Cicin Mage',
    'Fatui Skirmisher (Geochanter Bracer)',
    'Fatui Cryo Cicin Mage',
    'Mirror Maiden'
  ],
  'Fungi': [
    'Floating Hydro Fungus',
    'Winged Cryoshroom',
    'Winged Dendroshroom',
    'Grounded Hydroshroom',
    'Stretchy Geo Fungus',
    'Stretchy Anemo Fungus',
    'Stretchy Pyro Fungus',
    'Whirling Cryo Fungus',
    'Whirling Electro Fungus',
    'Floating Dendro Fungus'
  ],
  'Eremites': [
    'Eremite - Daythunder',
    'Eremite - Desert Clearwater',
    'Eremite - Linebreaker',
    'Eremite - Ravenbeak Halberdier',
    'Eremite - Sunfrost',
    'Eremite - Sword Dancer',
    'Eremite - Crossbow',
    'Eremite - Axe Vanguard',
    'Eremite - Galehunter',
    'Eremite - Stone Enchanter'
  ],
  'Forged Sand': ['Forged Sand Interrogator', 'Forged Sand Shieldbreaker', 'Forged Sand Javelineer'],
  'Swiftstep': ['Swiftstep Seeker', 'Swiftstep Storm Scout', 'Swiftstep Armed Courier'],
  'Flowing Blade': ['Flowing Blade Skirmisher', 'Flowing Blade Grease-Saw', 'Flowing Blade Harpoon-Thrower'],
  'Natlan Warrior': [
    'Tepetlisaurus Warrior: Shard Striker',
    'Tepetlisaurus Warrior: Rockbreaker Blade',
    'Yumkasaurus Warrior: Whirling Leaves',
    'Yumkasaurus Warrior: Flowing Skyfire',
    'Koholasaurus Warrior: Waveshuttler',
    'Koholasaurus Warrior: Reefsplitter'
  ],
  'Automatons': [
    'Ruin Guard',
    'Ruin Hunter',
    'Ruin Grader',
    'Ruin Scout',
    'Ruin Defender',
    'Ruin Destroyer',
    'Ruin Cruiser',
    'Ruin Serpent',
    'Ruin Drake - Skywatch',
    'Ruin Drake - Earthguard'
  ],
  'Primal Constructs': ['Primal Construct - Repulsor', 'Primal Construct - Reshaper', 'Primal Construct Prospector'],
  'Mek': [
    'Annihilation Specialist Mek',
    'Area Alert Mek',
    'Assault Specialist Mek',
    'Arithmetic Enhancer Mek',
    'Construction Specialist Mek',
    'Deepwater Assault Mek',
    'Geological Survey Mek',
    'Nimble Harvester Mek',
    'Suppression Specialist Mek',
    'Recon Log Mek',
    'Underwater Patrol Mek',
    'Underwater Survey Mek'
  ],
  'Consecrated Beasts': [
    'Consecrated Flying Serpent',
    'Consecrated Scorpion',
    'Consecrated Red Vulture',
    'Consecrated Horned Crocodile',
    'Consecrated Fanged Beast'
  ],
  'Vishaps': [
    'Geovishap Hatchling',
    'Geovishap',
    'Bolteater Bathysmal Vishap',
    'Rimebiter Bathysmal Vishap',
    'Primordial Bathysmal Vishap'
  ],
  'Whopperflowers': ['Cryo Whopperflower', 'Pyro Whopperflower', 'Electro Whopperflower'],
  'Specters': [
    'Hydro Specter',
    'Geo Specter',
    'Anemo Specter',
    'Pyro Specter',
    'Cryo Specter',
    'Electro Specter',
    'Dendro Specter'
  ],
  'Cicins': ['Cryo Cicin', 'Hydro Cicin', 'Electro Cicin'],
  'Other Lifeforms': [
    'Eye of the Storm',
    'Hydro Mimic Boar',
    'Hydro Mimic Crab',
    'Hydro Mimic Crane',
    'Hydro Mimic Ferret',
    'Hydro Mimic Finch',
    'Hydro Mimic Frog',
    'Hydro Mimic Mallard',
    'Hydro Mimic Raptor',
    'Maguu Kenki - Galloping Frost',
    'Maguu Kenki - Lone Gale'
  ],
  'Local Legends': [
    'Ruler of the Chizhang Mountains',
    'Dobharcu, Lord of the Hidden',
    'Fading Veteran',
    'Fairy Knight Twin',
    'Sword of the Gorge',
    'Iron Viscount',
    'Ocean Circuit Judge',
    'Luachra the Brilliant',
    'Chassanion',
    'Mageblade Corrouge',
    'Ninianne of the Lake',
    'Vivianne of the Lake',
    'Yseut',
    'Deianeira of Snezhevna',
    'Automated Supercomputing Field Generator',
    'Liam',
    'Rocky Avildsen',
    'Cineas',
    '"He Never Dies"',
    '"Ichcahuipilli\'s Aegis"',
    '"Atlatl\'s Blessing"',
    'Cihuacoatl of Chimeric Bone',
    '"Tlatzacuilotl"',
    '"Chimalli\'s Shade"',
    '"Sappho Amidst the Waves"',
    'Cocijo',
    'Polychrome Tri-Stars',
    '"Balachko"'
  ],
  'Weekly Bosses': [
    'Stormterror Dvalin',
    'Lupus Boreas',
    'Childe',
    'Azhdaha',
    'La Signora',
    'Raiden Shogun',
    'Scaramouche Boss',
    "Guardian of Apep's Oasis",
    'All-Devouring Narwhal',
    'The Knave'
  ],
  'World Bosses': {
    'Mondstadt': ['Anemo Hypostasis', 'Cryo Hypostasis', 'Cryo Regisvine', 'Electro Hypostasis'],
    'Liyue': ['Geo Hypostasis', 'Oceanid', 'Primo Geovishap', 'Pyro Regisvine', 'Ruin Serpent'],
    'Inazuma': [
      'Bathysmal Vishap Herd',
      'Golden Wolflord',
      'Hydro Hypostasis',
      'Maguu Kenki',
      'Perpetual Mechanical Array',
      'Pyro Hypostasis',
      'Thunder Manifestation'
    ],
    'Sumeru': [
      'Aeonblight Drake',
      'Algorithm of Semi-Intransient Matrix of Overseer Network',
      'Dendro Hypostasis',
      'Electro Regisvine',
      'Iniquitous Baptist',
      'Jadeplume Terrorshroom',
      'Setekh Wenut'
    ],
    'Fontaine': [
      'Icewind Suite',
      'Emperor of Fire and Iron',
      'Millennial Pearl Seahorse',
      'Prototype Cal. Breguet',
      'Hydro Tulpa',
      '"Statue of Marble and Brass"'
    ],
    'Natlan': ['Holawaqa Ngoubou', 'Kongamato']
  }
};

final WEEKLY_BOSSES = MOB_LIST['Weekly Bosses'] as List<String>;

final Map<String, List<String>> _worldBossesMap = MOB_LIST['World Bosses'] as Map<String, List<String>>;
final List<String> WORLD_BOSSES = _flatMap(_worldBossesMap);

final Map<String, dynamic> _overworldMobsPreOmit = MOB_LIST;
final Map<String, dynamic> _overworldMobsOmitted = _omit(_overworldMobsPreOmit, ['Weekly Bosses', 'World Bosses']);
final Map<String, List<String>> _overworldMobsCasted =
    _overworldMobsOmitted.map((key, value) => MapEntry(key, value as List<String>));
final List<String> OVERWORLD_MOBS = _flatMap(_overworldMobsCasted);

final List<String> ALL_MOBS = [...WEEKLY_BOSSES, ...WORLD_BOSSES, ...OVERWORLD_MOBS];
