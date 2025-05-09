const ABYSS_VERSION_HISTORY = [
  '1.6',
  '2.0',
  '2.1',
  '2.2',
  '2.3',
  '2.4',
  '2.5',
  '2.6',
  '2.7',
  '2.8',
  '3.0',
  '3.1',
  '3.2',
  '3.3',
  '3.4',
  '3.5',
  '3.6',
  '3.7',
  '3.8',
  '4.0',
  '4.1',
  '4.2',
  '4.3',
  '4.4',
  '4.5',
  '4.6',
  '4.7',
  '4.8',
  '5.0',
  '5.1 A',
  '5.1 B',
  '5.2',
  '5.3',
  '5.4 A',
  '5.4 B',
  '5.5'
];

const SPEEDRUN_ABYSS_CHAMBERS = [
  '12-1-1',
  '12-1-2',
  '12-2-1',
  '12-2-2',
  '12-3-1',
  '12-3-2',
  '12-1',
  '12-2',
  '12-3',
  '12-top',
  '12-bot',
  '12-all'
];

const ABYSS_CHAMBER_CONTENT = {
  '12-1-1': ['12-1-1'],
  '12-1-2': ['12-1-2'],
  '12-2-1': ['12-2-1'],
  '12-2-2': ['12-2-2'],
  '12-3-1': ['12-3-1'],
  '12-3-2': ['12-3-2'],
  '12-1': ['12-1-1', '12-1-2'],
  '12-2': ['12-2-1', '12-2-2'],
  '12-3': ['12-3-1', '12-3-2'],
  '12-top': ['12-1-1', '12-2-1', '12-3-1'],
  '12-bot': ['12-1-2', '12-2-2', '12-3-2'],
  '12-all': ['12-1-1', '12-1-2', '12-2-1', '12-2-2', '12-3-1', '12-3-2']
};

const SPEEDRUN_CATEGORY_ORDER = [
  'Abyss',
  'Domain',
  'Event',
  'Weekly Boss',
  'World Boss',
];

const DPS_CATEGORY_ORDER = [
  'Overworld',
  'Weekly Boss',
  'Event',
  'World Boss',
  'Reputation Bounty',
  'Abyss',
  'Domain',
];

const REGIONS = [
  'America',
  'China',
  'Europe',
  'Asia',
  'TW/HK/MO',
];

const ARTIFACT_DOMAINS = [
  'Midsummer Courtyard',
  'Valley of Remembrance',
  'Domain of Guyun',
  'Hidden Palace of Zhou Formula',
  'Clear Pool and Mountain Cavern',
  'Peak of Vindagnyr',
  'Ridge Watch',
  'Momiji-Dyed Court',
  'Slumbering Court',
  'The Lost Valley',
  'Spire of Solitary Enlightenment',
  'City of Gold',
  'Molten Iron Fortress',
  'Denouement of Sin'
];

const WEAPON_ASCENSION_DOMAINS = [
  'Cecilia Garden',
  'Hidden Palace of Lianshan Formula',
  'Court of Flowing Sand',
  'Tower of Abject Pride',
  'Echoes of the Deep Tides'
];

const TALENT_ASCENSION_DOMAINS = [
  'Forsaken Rift',
  'Taishan Mansion',
  'Violet Court',
  'Steeple of Ignorance',
  'Pale Forgotten Glory'
];

const DOMAIN = [...ARTIFACT_DOMAINS, ...WEAPON_ASCENSION_DOMAINS, ...TALENT_ASCENSION_DOMAINS];

const SPEEDRUN_EVENTS = [
  'The Chasm Call - F2P',
  'The Chasm Call - Unrestricted',
  '2.4 A Study in Potions',
  '2.3 Energy Amplifier Fruition',
  '2.0 Phantom Flow',
  '1.6 Legend of the Vagabond Sword'
];

const DPS_EVENTS = [
  'A Study in Potions',
  'Energy Amplifier Fruition',
  'Theater Mechanicus',
  'Phantom Flow',
  'Fellflower',
  'Labyrinth Warriors',
  'Bantan Sango Case Files: The Warrior Dog',
  'Legend of the Vagabond Sword',
  'Second Blooming'
];

const ATTACK_TYPES = [
  'Normal Attack',
  'Charged Attack',
  'Plunge Attack',
  'Elemental Skill',
  'Elemental Burst',
  'A1 Talent',
  'A4 Talent',
  'Other'
];

const ATTACK_TYPES_MAP = {
  'normal_attack': 'Normal Attack',
  'charged_attack': 'Charged Attack',
  'plunge_attack': 'Plunge Attack',
  'elemental_skill': 'Elemental Skill',
  'elemental_burst': 'Elemental Burst',
  'a1_talent': 'A1 Talent',
  'a4_talent': 'A4 Talent',
  'Other': 'Other'
};
