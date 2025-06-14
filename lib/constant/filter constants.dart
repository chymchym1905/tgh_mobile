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
  '5.5',
  '5.6 A'
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

const ASSET_MAPPING = {
  'Domain': 'assets/icons/Domain.png',
  'Event': 'assets/icons/Icon_Events.webp',
  'Overworld': 'assets/icons/Icon_Monster_Pin.webp',
  'Abyss': 'assets/icons/spiral abyss.png',
  'Reputation Bounty': 'assets/icons/UI_NPCTopIcon_Reputation.webp',
  'Weekly Boss': 'assets/icons/Trouce_Domain.png',
  'World Boss': 'assets/icons/UI_OnmyoMaze_Icon_Boss.webp'
};

const RESTRICTED_DPS_CATEGORY_ORDER = [
  'Weekly Boss',
  'Overworld',
  'World Boss',
  'Reputation Bounty',
  'Abyss',
  'Event',
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

const SUBMITABLE_EVENTS = [
  // 'The Chasm Call - F2P',
  // 'The Chasm Call - Unrestricted',
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
  'normal_attack': 'normal_attack_talent',
  'charged_attack': 'normal_attack_talent',
  'plunge_attack': 'normal_attack_talent',
  'elemental_skill': 'elemental_skill_talent',
  'elemental_burst': 'elemental_burst_talent',
  'a1_talent': 'a1_talent',
  'a4_talent': 'a4_talent',
  'other': 'other'
};

const ABYSS_FLOORS = [
  '12-3-2',
  '12-3-1',
  '12-2-2',
  '12-2-1',
  '12-1-2',
  '12-1-1',
  '11-3-2',
  '11-3-1',
  '11-2-2',
  '11-2-1',
  '11-1-2',
  '11-1-1',
  '10-3-2',
  '10-3-1',
  '10-2-2',
  '10-2-1',
  '10-1-2',
  '10-1-1',
  '9-3-2',
  '9-3-1',
  '9-2-2',
  '9-2-1',
  '9-1-2',
  '9-1-1',
  '8-3-2',
  '8-3-1',
  '8-2-2',
  '8-2-1',
  '8-1-2',
  '8-1-1',
  '7-3-2',
  '7-3-1',
  '7-2-2',
  '7-2-1',
  '7-1-2',
  '7-1-1',
  '6-3-2',
  '6-3-1',
  '6-2-2',
  '6-2-1',
  '6-1-2',
  '6-1-1',
  '5-3-2',
  '5-3-1',
  '5-2-2',
  '5-2-1',
  '5-1-2',
  '5-1-1',
  '4-3',
  '4-2',
  '4-1',
  '3-3',
  '3-2',
  '3-1',
  '2-3',
  '2-2',
  '2-1',
  '1-3',
  '1-2',
  '1-1'
];
