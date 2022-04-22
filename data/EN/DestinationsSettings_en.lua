-------------------------------------------
-- English localization for Destinations --
-------------------------------------------
local strings = {

  --Map Filter Tags
  DEST_FILTER_UNKNOWN = "(Dest) Unknown POIs",
  DEST_FILTER_KNOWN = "(Dest) Known POIs",
  DEST_FILTER_OTHER = "(Dest) Other Achievements",
  DEST_FILTER_OTHER_DONE = "(Dest) Other Achievements Done",
  DEST_FILTER_MAIQ = "(Dest) " .. zo_strformat(GetAchievementInfo(872)),
  DEST_FILTER_MAIQ_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(872)) .. " Done",
  DEST_FILTER_PEACEMAKER = "(Dest) " .. zo_strformat(GetAchievementInfo(716)),
  DEST_FILTER_PEACEMAKER_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(716)) .. " Done",
  DEST_FILTER_NOSEDIVER = "(Dest) " .. zo_strformat(GetAchievementInfo(406)),
  DEST_FILTER_NOSEDIVER_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(406)) .. " Done",
  DEST_FILTER_EARTHLYPOS = "(Dest) " .. zo_strformat(GetAchievementInfo(1121)),
  DEST_FILTER_EARTHLYPOS_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1121)) .. " Done",
  DEST_FILTER_ON_ME = "(Dest) " .. zo_strformat(GetAchievementInfo(704)),
  DEST_FILTER_ON_ME_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(704)) .. " Done",
  DEST_FILTER_BRAWL = "(Dest) " .. zo_strformat(GetAchievementInfo(1247)),
  DEST_FILTER_BRAWL_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1247)) .. " Done",
  DEST_FILTER_PATRON = "(Dest) " .. zo_strformat(GetAchievementInfo(1316)),
  DEST_FILTER_PATRON_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1316)) .. " Done",
  DEST_FILTER_WROTHGAR_JUMPER = "(Dest) " .. zo_strformat(GetAchievementInfo(1331)),
  DEST_FILTER_WROTHGAR_JUMPER_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1331)) .. " Done",
  DEST_FILTER_RELIC_HUNTER = "(Dest) " .. zo_strformat(GetAchievementInfo(1250)),
  DEST_FILTER_RELIC_HUNTER_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1250)) .. " Done",
  DEST_FILTER_BREAKING_ENTERING = "(Dest) " .. zo_strformat(GetAchievementInfo(1349)),
  DEST_FILTER_BREAKING_ENTERING_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1349)) .. " Done",
  DEST_FILTER_CUTPURSE_ABOVE = "(Dest) " .. zo_strformat(GetAchievementInfo(1383)),
  DEST_FILTER_CUTPURSE_ABOVE_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1383)) .. " Done",

  DEST_FILTER_CHAMPION = "(Dest) Dungeon Champions",
  DEST_FILTER_CHAMPION_DONE = "(Dest) Dungeon Champions Done",

  DEST_FILTER_COLLECTIBLE = "(Dest) Collectibles Pins",
  DEST_FILTER_COLLECTIBLE_DONE = "(Dest) Collectibles Done",

  DEST_FILTER_FISHING = "(Dest) Fishing Pins",
  DEST_FILTER_FISHING_DONE = "(Dest) Fishing Done",

  DEST_FILTER_QUESTGIVER = "(Dest) Quest Giver Pins",
  DEST_FILTER_QUESTS_IN_PROGRESS = "(Dest) Quests in progress",
  DEST_FILTER_QUESTS_DONE = "(Dest) Quests Done",

  DEST_FILTER_AYLEID = "(Dest) Ayleid Wells",
  DEST_FILTER_DEADLANDS_ENTRANCE = "(Dest) Deadlands Entrance",
  DEST_FILTER_HIGHISLE_DRUIDICSHRINE = "(Dest) Druidic Shrine",
  DEST_FILTER_DWEMER = "(Dest) Dwemer Ruins",
  DEST_FILTER_BORDER = "(Dest) Craglorn Border Line",

  DEST_FILTER_WWVAMP = "(Dest) Werewolfs and Vampires",
  DEST_FILTER_VAMPIRE_ALTAR = "(Dest) Vampire Alters",
  DEST_FILTER_WEREWOLF_SHRINE = "(Dest) Werewolf Shrines",

  --Settings Menu
  DEST_SETTINGS_TITLE = "Destinations",

  DEST_SETTINGS_IMPROVEMENT_HEADER = "POI Improvement",
  DEST_SETTINGS_IMPROVEMENT_HEADER_TT = "Improve unknown and known POI",
  DEST_SETTINGS_POI_ENGLISH_TEXT_HEADER = "English text on Points of interest",
  DEST_SETTINGS_POI_SHOW_ENGLISH = "Show english POI names",
  DEST_SETTINGS_POI_SHOW_ENGLISH_TT = "Show english POI names at the top of the map",
  DEST_SETTINGS_POI_ENGLISH_COLOR = "Text color for English POI names",
  DEST_SETTINGS_POI_ENGLISH_COLOR_TT = "Set the text color for english translation of POI names",
  DEST_SETTINGS_POI_SHOW_ENGLISH_KEEPS = "Show english POI names for Keeps",
  DEST_SETTINGS_POI_SHOW_ENGLISH_KEEPS_TT = "Show english POI names on the keep tooltip",
  DEST_SETTINGS_POI_ENGLISH_KEEPS_COLOR = "Text color for English Keeps names",
  DEST_SETTINGS_POI_ENGLISH_KEEPS_COLOR_TT = "Set the text color for english translation of Keeps names",
  DEST_SETTINGS_POI_ENGLISH_KEEPS_HA = "Hide Alliance Name on Keeps Tooltips",
  DEST_SETTINGS_POI_ENGLISH_KEEPS_HA_TT = "Hide Alliance Name on Keeps Tooltips",
  DEST_SETTINGS_POI_ENGLISH_KEEPS_NL = "Add a new line on Keeps tooltips",
  DEST_SETTINGS_POI_ENGLISH_KEEPS_NL_TT = "Add a new line on Keeps tooltips for english name",
  DEST_SETTINGS_POI_IMPROVE_MUNDUS = "Improve Mundus POIs",
  DEST_SETTINGS_POI_IMPROVE_MUNDUS_TT = "Improve Mundus POIs by adding effect description on tooltip",
  DEST_SETTINGS_POI_IMPROVE_CRAFTING = "Improve Crafting POIs",
  DEST_SETTINGS_POI_IMPROVE_CRAFTING_TT = "Improve Crafting POIs by adding set description on tooltip",

  DEST_SETTINGS_USE_ACCOUNTWIDE = "Use accountwide settings",
  DEST_SETTINGS_USE_ACCOUNTWIDE_TT = "If on, then the settings will be the same for ALL characters.",
  DEST_SETTINGS_RELOAD_WARNING = "Changing this setting will force an instant /reloadui",
  DEST_SETTINGS_PER_CHAR_HEADER = "Settings marked with a yellow '*' only affects the current character.",
  DEST_SETTINGS_PER_CHAR = "*",
  DEST_SETTINGS_PER_CHAR_TOGGLE_TT = "This switch only affects current character.",
  DEST_SETTINGS_PER_CHAR_BUTTON_TT = "This button only affects current character.",

  DEST_SETTINGS_POI_HEADER = "Unknown Points of Interest",
  DEST_SETTINGS_POI_HEADER_TT = "This submenu covers Unknown Points of Interest",
  DEST_SETTINGS_POI_UNKOWN_SUBHEADER = "This may be unused",
  DEST_SETTINGS_POI_KNOWN_SUBHEADER = "This may be unused",
  DEST_SETTINGS_POIS_ENGLISH_TEXT_HEADER = "This may be unused",

  DEST_SETTINGS_UNKNOWN_PIN_TOGGLE = "Show unknown POIs",
  DEST_SETTINGS_UNKNOWN_PIN_STYLE = "Map pins for unknown POIs",
  DEST_SETTINGS_UNKNOWN_PIN_SIZE = "Pin size for unknown POIs",
  DEST_SETTINGS_UNKNOWN_PIN_LAYER = "Pin layer for unknown POIs",
  DEST_SETTINGS_UNKNOWN_COLOR = "Pin text color for Unknown POI's",
  DEST_SETTINGS_UNKNOWN_COLOR_TT = "Affects all unknown Points of Interest",
  DEST_SETTINGS_UNKNOWN_COLOR_EN = "Pin text color (english)",
  DEST_SETTINGS_UNKNOWN_COLOR_EN_TT = "Affects the english text for all unknown Points of Interest, if activated",
  DEST_SETTINGS_KNOWN_PIN_TOGGLE = "Show already known POIs",
  DEST_SETTINGS_KNOWN_PIN_STYLE = "Map pins for known POIs",
  DEST_SETTINGS_KNOWN_PIN_SIZE = "Pin size for known POIs",
  DEST_SETTINGS_KNOWN_PIN_LAYER = "Pin layer for known POIs",
  DEST_SETTINGS_KNOWN_COLOR = "Pin text color for Known POI's",
  DEST_SETTINGS_KNOWN_COLOR_TT = "Affects all known Points of Interest",
  DEST_SETTINGS_KNOWN_COLOR_EN = "Pin text color (english)",
  DEST_SETTINGS_KNOWN_COLOR_EN_TT = "Affects the english text for all known Points of Interest, if activated",
  DEST_SETTINGS_MUNDUS_DETAIL_PIN_TOGGLE = "Show Mundus details",
  DEST_SETTINGS_MUNDUS_TXT_COLOR = "Mundus Stone text color",
  DEST_SETTINGS_MUNDUS_TXT_COLOR_TT = "Affects the DETAIL TEXT on Mundus Stones",
  DEST_SETTINGS_GTRADER_COLOR = "Guild Trader Pin text color",
  DEST_SETTINGS_GTRADER_COLOR_TT = "Affects Guild Trader text on wayshrines",

  DEST_SETTINGS_ACH_HEADER = "Achievement Positions",
  DEST_SETTINGS_ACH_HEADER_TT = "This submenu covers most of the achievements in the game (too many to list here)",
  DEST_SETTINGS_ACH_PIN_TOGGLE = "Show incomplete Achievement",
  DEST_SETTINGS_ACH_PIN_TOGGLE_DONE = "Show completed Achievement",
  DEST_SETTINGS_ACH_PIN_STYLE = "Pin style for Achievement",
  DEST_SETTINGS_ACH_PIN_SIZE = "Pin size for Achievement",

  DEST_SETTINGS_ACH_OTHER_HEADER = "Lightbringer, Give to the Poor and Crime Pays",
  DEST_SETTINGS_ACH_MAIQ_HEADER = "I Like M'aiq",
  DEST_SETTINGS_ACH_PEACEMAKER_HEADER = "Peacemaker",
  DEST_SETTINGS_ACH_NOSEDIVER_HEADER = "Nose Diver",
  DEST_SETTINGS_ACH_EARTHLYPOS_HEADER = "Earthly Possessions",
  DEST_SETTINGS_ACH_ON_ME_HEADER = "This One's on Me",
  DEST_SETTINGS_ACH_BRAWL_HEADER = "One Last Brawl",
  DEST_SETTINGS_ACH_PATRON_HEADER = "Orsinium Patron",
  DEST_SETTINGS_ACH_WROTHGAR_JUMPER_HEADER = "Wrothgar Cliff Jumper",
  DEST_SETTINGS_ACH_RELIC_HUNTER_HEADER = "Wrothgar Master Relic Hunter",
  DEST_SETTINGS_ACH_BREAKING_HEADER = "Breaking and Entering",
  DEST_SETTINGS_ACH_CUTPURSE_HEADER = "A Cutpurse Above",

  DEST_SETTINGS_ACH_CHAMPION_PIN_HEADER = "Dungeon Champions",
  DEST_SETTINGS_ACH_CHAMPION_ZONE_PIN_TOGGLE = "Show on Zone Maps",
  DEST_SETTINGS_ACH_CHAMPION_ZONE_PIN_TOGGLE_TT = "This is for turning Champions (solo dungeons bosses) on/off on ZONE MAPS",
  DEST_SETTINGS_ACH_CHAMPION_FRONT_PIN_TOGGLE = "Zone pin to Front",
  DEST_SETTINGS_ACH_CHAMPION_FRONT_PIN_TOGGLE_TT = "This will toggle if ZONE pins (if active) should be shown in front of dungeon pins or not",
  DEST_SETTINGS_ACH_CHAMPION_PIN_SIZE = "Pin size for Dungeon Champions",

  DEST_SETTINGS_ACH_GLOBAL_HEADER = "Achievement Positions - Global settings",
  DEST_SETTINGS_ACH_GLOBAL_HEADER_TT = "This submenu covers the Global Achievement settings",
  DEST_SETTINGS_ACH_ALL_PIN_LAYER = "Pin layer for all Achievements",
  DEST_SETTINGS_ACH_PIN_COLOR_MISS = "Pin color (incomplete)",
  DEST_SETTINGS_ACH_PIN_COLOR_MISS_TT = "Affects the PIN color of incomplete Achievements",
  DEST_SETTINGS_ACH_TXT_COLOR_MISS = "Pin text color (incomplete)",
  DEST_SETTINGS_ACH_TXT_COLOR_MISS_TT = "Affects the pin TEXT of incomplete Achievements",
  DEST_SETTINGS_ACH_PIN_COLOR_DONE = "Pin color (completed)",
  DEST_SETTINGS_ACH_PIN_COLOR_DONE_TT = "Affects the PIN color of complete Achievements",
  DEST_SETTINGS_ACH_TXT_COLOR_DONE = "Pin text color (completed)",
  DEST_SETTINGS_ACH_TXT_COLOR_DONE_TT = "Affects the pin TEXT of complete Achievements",
  DEST_SETTINGS_ACH_ALL_COMPASS_TOGGLE = "Show Achievements on compass",
  DEST_SETTINGS_ACH_ALL_COMPASS_DIST = "Pin distance on compass",

  DEST_SETTINGS_MISC_HEADER = "Miscellaneous POI Positions",
  DEST_SETTINGS_MISC_HEADER_TT = "This submenu covers Ayleid Wells, Dwemer Ruins and the Craglorn Border line.",
  DEST_SETTINGS_MISC_AYLEID_WELL_HEADER = "Ayleid Wells",
  DEST_SETTINGS_MISC_DEADLANDS_ENTRANCE_HEADER = "Deadlands Entrance",
  DEST_SETTINGS_MISC_HIGHISLE_SHRINE_HEADER = "Druidic Shrine",
  DEST_SETTINGS_MISC_DWEMER_HEADER = "Dwemer Ruins",
  DEST_SETTINGS_MISC_COMPASS_HEADER = "Misc Settings",
  DEST_SETTINGS_MISC_BORDER_HEADER = "Craglorn Border",

  DEST_SETTINGS_MISC_PIN_AYLEID_WELL_TOGGLE = "Show Ayleid Wells",
  DEST_SETTINGS_MISC_PIN_AYLEID_WELL_TOGGLE_TT = "This is for turning Ayleid Wells on/off on the maps",
  DEST_SETTINGS_MISC_PIN_AYLEID_WELL_SIZE = "Pin size for Ayleid Wells",
  DEST_SETTINGS_MISC_PIN_AYLEID_WELL_COLOR = "Pin color for Ayleid Wells",
  DEST_SETTINGS_MISC_PIN_AYLEID_WELL_COLOR_TT = "Affects the PIN color for Ayleid Wells",
  DEST_SETTINGS_MISC_PINTEXT_AYLEID_WELL_COLOR = "Pin text color for Ayleid Wells",
  DEST_SETTINGS_MISC_PINTEXT_AYLEID_WELL_COLOR_TT = "Affects the pin TEXT on Ayleid Wells",

  -- Deadlands
  DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_TOGGLE = "Show Deadlands Entrance",
  DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_TOGGLE_TT = "This is for turning Deadlands Entrance on/off on the maps",
  DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_SIZE = "Pin size for Deadlands Entrance",
  DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_COLOR = "Pin color for Deadlands Entrance",
  DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_COLOR_TT = "Affects the PIN color for Deadlands Entrance",
  DEST_SETTINGS_MISC_PINTEXT_DEADLANDS_ENTRANCE_COLOR = "Pin text color for Deadlands Entrance",
  DEST_SETTINGS_MISC_PINTEXT_DEADLANDS_ENTRANCE_COLOR_TT = "Affects the pin TEXT on Deadlands Entrance",

  -- HighIsle
  DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_TOGGLE = "Show Druidic Shrine",
  DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_TOGGLE_TT = "This is for turning Druidic Shrines on/off on the maps",
  DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_SIZE = "Pin size for Druidic Shrines",
  DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_COLOR = "Pin color for Druidic Shrines",
  DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_COLOR_TT = "Affects the PIN color for Druidic Shrines",
  DEST_SETTINGS_MISC_PINTEXT_HIGHISLE_DRUIDICSHRINES_COLOR = "Pin text color for Druidic Shrines",
  DEST_SETTINGS_MISC_PINTEXT_HIGHISLE_DRUIDICSHRINES_COLOR_TT = "Affects the pin TEXT on Druidic Shrines",

  DEST_SETTINGS_MISC_DWEMER_PIN_TOGGLE = "Show Dwemer Ruins",
  DEST_SETTINGS_MISC_DWEMER_PIN_TOGGLE_TT = "This is for turning Dwemer Ruins on/off on the maps",
  DEST_SETTINGS_MISC_DWEMER_PIN_SIZE = "Pin size for Dwemer Ruins",
  DEST_SETTINGS_MISC_DWEMER_PIN_COLOR = "Pin color for Dwemer Ruins",
  DEST_SETTINGS_MISC_DWEMER_PIN_COLOR_TT = "Affects the PIN color for Dwemer Ruins",
  DEST_SETTINGS_MISC_DWEMER_PINTEXT_COLOR = "Pin text color for Dwemer Ruins",
  DEST_SETTINGS_MISC_DWEMER_PINTEXT_COLOR_TT = "Affects the pin TEXT on Dwemer Ruins",
  DEST_SETTINGS_MISC_PIN_LAYER = "Pin layer for all miscellaneous POIs",
  DEST_SETTINGS_MISC_COMPASS_PIN_TOGGLE = "Show misc POIs on compass",
  DEST_SETTINGS_MISC_COMPASS_DIST = "Pin distance for POIs on compass",
  DEST_SETTINGS_MISC_BORDER_PIN_TOGGLE = "Show Craglorn Border Line",
  DEST_SETTINGS_MISC_BORDER_PIN_TOGGLE_TT = "Shows the border line dividing Upper and Lower Craglorn",
  DEST_SETTINGS_MISC_BORDER_SIZE = "Pin size for Craglorn Border",
  DEST_SETTINGS_MISC_BORDER_PIN_COLOR = "Pin color for Craglorn Border",
  DEST_SETTINGS_MISC_BORDER_PIN_COLOR_TT = "Affects the PIN color for Craglorn Border",

  DEST_SETTINGS_VWW_HEADER = "Vampire and Werewolf Positions",
  DEST_SETTINGS_VWW_HEADER_TT = "This submenu covers Vampires and Werewolfs, including spawns, Alters and Shrines.",
  DEST_SETTINGS_VWW_WWVAMP_HEADER = "Vampire and Werewolf spawns",
  DEST_SETTINGS_VWW_VAMP_HEADER = "Vampire Altars",
  DEST_SETTINGS_VWW_WW_HEADER = "Werewolf Shrines",
  DEST_SETTINGS_VWW_COMPASS_HEADER = "Misc Settings",

  DEST_SETTINGS_VWW_PIN_WWVAMP_TOGGLE = "Show WW/Vampire spawns",
  DEST_SETTINGS_VWW_PIN_WWVAMP_TOGGLE_TT = "This is for turning Vampire and Werewolf spawns on/off on the maps",
  DEST_SETTINGS_VWW_PIN_WWVAMP_SIZE = "Pin size for Werewolfs/Vampires",
  DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_TOGGLE = "Show Vampire Altars",
  DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_TOGGLE_TT = "This is for turning Vampire Alters on/off on the maps",
  DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_SIZE = "Pin size for Vampire Altars",
  DEST_SETTINGS_VWW_PIN_WW_SHRINE_TOGGLE = "Show Werewolf Shrines",
  DEST_SETTINGS_VWW_PIN_WW_SHRINE_TOGGLE_TT = "This is for turning Werewolf Shrines on/off on the maps",
  DEST_SETTINGS_VWW_PIN_WW_SHRINE_SIZE = "Pin size for Werewolf Shrines",
  DEST_SETTINGS_VWW_PIN_LAYER = "Pin layer for Werewolfs/Vampires",
  DEST_SETTINGS_VWW_COMPASS_PIN_TOGGLE = "Show pins on compass",
  DEST_SETTINGS_VWW_COMPASS_DIST = "Pin distance for pins on compass",
  DEST_SETTINGS_VWW_PIN_COLOR = "Pin color for Werewolfs/Vampires",
  DEST_SETTINGS_VWW_PIN_COLOR_TT = "Affects the PIN color for Werewolf and Vampire spawns, Vampire Altars and Werewolf Shrines",
  DEST_SETTINGS_VWW_PINTEXT_COLOR = "Pin text color for Werewolfs/Vampires",
  DEST_SETTINGS_VWW_PINTEXT_COLOR_TT = "Affects the pin TEXT on Werewolf and Vampire spawns, Vampire Altars and Werewolf Shrines",

  DEST_SETTINGS_QUEST_HEADER = "Quest Giver Positions",
  DEST_SETTINGS_QUEST_HEADER_TT = "This submenu covers all Quest related settings.",
  DEST_SETTINGS_QUEST_UNDONE_HEADER = "Incomplete Quests",
  DEST_SETTINGS_QUEST_INPROGRESS_HEADER = "Quests In Progress",
  DEST_SETTINGS_QUEST_DONE_HEADER = "Completed Quests",
  DEST_SETTINGS_QUEST_CADWELLS_HEADER = "Cadwell's Almanac",
  DEST_SETTINGS_QUEST_DAILIES_HEADER = "Dailies/Repeatable",
  DEST_SETTINGS_QUEST_COMPASS_HEADER = "Misc",
  DEST_SETTINGS_QUEST_REGISTER_HEADER = "Other",

  DEST_SETTINGS_QUEST_UNDONE_PIN_TOGGLE = "Show Quest Giver positions",
  DEST_SETTINGS_QUEST_UNDONE_PIN_SIZE = "Pin size for Quest Givers",
  DEST_SETTINGS_QUEST_UNDONE_PIN_COLOR = "Pin color for Quest Givers",
  DEST_SETTINGS_QUEST_UNDONE_PIN_COLOR_TT = "Sets the color of the PINS for quests not yet taken",
  DEST_SETTINGS_QUEST_UNDONE_MAIN_PIN_COLOR = "Pin color for Main Quests",
  DEST_SETTINGS_QUEST_UNDONE_MAIN_PIN_COLOR_TT = "Sets the color of the PINS for MAIN STORYLINE quests not yet taken",
  DEST_SETTINGS_QUEST_UNDONE_DAY_PIN_COLOR = "Pin color for Daily Quests",
  DEST_SETTINGS_QUEST_UNDONE_DAY_PIN_COLOR_TT = "Sets the color of the PINS for DAILY quests not yet taken",
  DEST_SETTINGS_QUEST_UNDONE_REP_PIN_COLOR = "Pin color for Repeatable Quests",
  DEST_SETTINGS_QUEST_UNDONE_REP_PIN_COLOR_TT = "Sets the color of the PINS for Repeatable quests not yet taken",
  DEST_SETTINGS_QUEST_UNDONE_DUN_PIN_COLOR = "Pin color for Dungeon Quests",
  DEST_SETTINGS_QUEST_UNDONE_DUN_PIN_COLOR_TT = "Sets the color of the PINS for Dungeon quests not yet taken",
  DEST_SETTINGS_QUEST_UNDONE_PINTEXT_COLOR = "Text color for Quests Givers",
  DEST_SETTINGS_QUEST_UNDONE_PINTEXT_COLOR_TT = "Sets the color of the TEXT on the pins for quests not yet taken",
  DEST_SETTINGS_QUEST_INPROGRESS_PIN_TOGGLE = "Show Quests in Progress",
  DEST_SETTINGS_QUEST_INPROGRESS_PIN_SIZE = "Pin size for quests in progress",
  DEST_SETTINGS_QUEST_INPROGRESS_PIN_COLOR = "Pin color for quests in progress",
  DEST_SETTINGS_QUEST_INPROGRESS_PIN_COLOR_TT = "Sets the color of the PINS for quests in the journal (quest list)",
  DEST_SETTINGS_QUEST_INPROGRESS_PINTEXT_COLOR = "Text color for quests in progress",
  DEST_SETTINGS_QUEST_INPROGRESS_PINTEXT_COLOR_TT = "Sets the color of the TEXT on the pins for quests in the journal (quest list)",
  DEST_SETTINGS_QUEST_DONE_PIN_TOGGLE = "Show completed Quests",
  DEST_SETTINGS_QUEST_DONE_PIN_SIZE = "Pin size for completed quests",
  DEST_SETTINGS_QUEST_DONE_PIN_COLOR = "Pin color for completed quests",
  DEST_SETTINGS_QUEST_DONE_PIN_COLOR_TT = "Sets the color of the PINS for completed quests",
  DEST_SETTINGS_QUEST_DONE_PINTEXT_COLOR = "Text color for completed quests",
  DEST_SETTINGS_QUEST_DONE_PINTEXT_COLOR_TT = "Sets the color of the TEXT on the pins for completed quests",
  DEST_SETTINGS_QUEST_CADWELLS_PIN_TOGGLE = "Show Cadwell's Almanac",
  DEST_SETTINGS_QUEST_CADWELLS_PIN_TOGGLE_TT = "Show/Hide Cadwell's Almanac marker on the quests",
  DEST_SETTINGS_QUEST_CADWELLS_ONLY_PIN_TOGGLE = "Hide other quests",
  DEST_SETTINGS_QUEST_CADWELLS_ONLY_PIN_TOGGLE_TT = "Show/Hide all ordinary quests that are NOT part of Cadwell's Almanac",
  DEST_SETTINGS_QUEST_WRITS_PIN_TOGGLE = "Show Writs",
  DEST_SETTINGS_QUEST_WRITS_PIN_TOGGLE_TT = "Show/Hide Writs",
  DEST_SETTINGS_QUEST_DAILIES_PIN_TOGGLE = "Show Daily Quests",
  DEST_SETTINGS_QUEST_DAILIES_PIN_TOGGLE_TT = "Show/Hide Daily Quests",
  DEST_SETTINGS_QUEST_REPEATABLES_PIN_TOGGLE = "Show Repeatable Quests",
  DEST_SETTINGS_QUEST_REPEATABLES_PIN_TOGGLE_TT = "Show/Hide Repeatable Quests",
  DEST_SETTINGS_QUEST_ALL_PIN_LAYER = "Pin layer for all Quest pins",
  DEST_SETTINGS_QUEST_COMPASS_TOGGLE = "Show Quest pins on compass",
  DEST_SETTINGS_QUEST_COMPASS_DIST = "Distance for Quest pins on compass",

  DEST_SETTINGS_REGISTER_QUEST_GIVER_TOGGLE = "Hide Quest Giver Name",
  DEST_SETTINGS_REGISTER_QUEST_GIVER_TOGGLE_TT = "Show/Hide the name of the Quest giver in the tooltip.",

  DEST_SETTINGS_REGISTER_QUESTS_TOGGLE = "Register Quests",
  DEST_SETTINGS_REGISTER_QUESTS_TOGGLE_TT = "Saves quest info to variables for reporting. Please see the Destinations page on ESOUI.com for more info.",
  DEST_SETTINGS_QUEST_RESET_HIDDEN = "Reset Hidden Quests",
  DEST_SETTINGS_QUEST_RESET_HIDDEN_TT = "Resets ALL hidden quests, and show them on your map/radar again.",

  DEST_SETTINGS_COLLECTIBLES_HEADER = "Collectible Positions",
  DEST_SETTINGS_COLLECTIBLES_HEADER_TT = "This submenu covers all Collectibles related settings.",
  DEST_SETTINGS_COLLECTIBLES_SUBHEADER = "Collectible Settings",
  DEST_SETTINGS_COLLECTIBLES_COLORS_HEADER = "Collectible pin colors ",
  DEST_SETTINGS_COLLECTIBLES_MISC_HEADER = "Misc",

  DEST_SETTINGS_COLLECTIBLES_TOGGLE = "Show incomplete Collectibles",
  DEST_SETTINGS_COLLECTIBLES_TOGGLE_TT = "Shows areas where beasts can be killed to collect collectibles for achievements",
  DEST_SETTINGS_COLLECTIBLES_DONE_TOGGLE = "Show completed Collectibles",
  DEST_SETTINGS_COLLECTIBLES_DONE_TOGGLE_TT = "Show completed Collectibles areas",
  DEST_SETTINGS_COLLECTIBLES_PIN_STYLE = "Pin style for Collectibles",
  DEST_SETTINGS_COLLECTIBLES_SHOW_MOBNAME = "Show mob names on pins",
  DEST_SETTINGS_COLLECTIBLES_SHOW_MOBNAME_TT = "Shows the names of the monsters (in english at the moment) that can drop the items needed to complete the achievement",
  DEST_SETTINGS_COLLECTIBLES_SHOW_ITEM = "Show item names on pins",
  DEST_SETTINGS_COLLECTIBLES_SHOW_ITEM_TT = "Shows the name of the items needed to complete the achievement",
  DEST_SETTINGS_COLLECTIBLES_PIN_SIZE = "Pin size for Collectibles",
  DEST_SETTINGS_COLLECTIBLES_PIN_SIZE_TT = "Pin size for Collectibles",
  DEST_SETTINGS_COLLECTIBLES_PIN_LAYER = "Pin layer for Collectibles",
  DEST_SETTINGS_COLLECTIBLES_PIN_LAYER_TT = "Pin layer for Collectibles",
  DEST_SETTINGS_COLLECTIBLES_COMPASS_TOGGLE = "Show on compass",
  DEST_SETTINGS_COLLECTIBLES_COMPASS_TOGGLE_TT = "Show Collectibles on compass",
  DEST_SETTINGS_COLLECTIBLES_COMPASS_DIST = "Distance on compass",
  DEST_SETTINGS_COLLECTIBLES_COMPASS_DIST_TT = "Distance for Collectibles areas on compass",
  DEST_SETTINGS_COLLECTIBLES_COLOR_TITLE = "Header title text color",
  DEST_SETTINGS_COLLECTIBLES_COLOR_TITLE_TT = "Affects the title of the Collectibles achievement text",
  DEST_SETTINGS_COLLECTIBLES_PIN_COLOR = "Missing pin color",
  DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_TT = "Sets the color of the PINS for missing collectibles",
  DEST_SETTINGS_COLLECTIBLES_COLOR_UNDONE = "Missing text color",
  DEST_SETTINGS_COLLECTIBLES_COLOR_UNDONE_TT = "Affects the pin TEXT for missing Collectibles",
  DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_DONE = "Completed pin color",
  DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_DONE_TT = "Sets the color of the PINS for completed collectibles",
  DEST_SETTINGS_COLLECTIBLES_COLOR_DONE = "Completed text color",
  DEST_SETTINGS_COLLECTIBLES_COLOR_DONE_TT = "Affects the pin TEXT for completed Collectibles",

  DEST_SETTINGS_FISHING_HEADER = "Fishing Positions",
  DEST_SETTINGS_FISHING_HEADER_TT = "This submenu covers all Fishing related settings.",
  DEST_SETTINGS_FISHING_SUBHEADER = "Fishing Settings",
  DEST_SETTINGS_FISHING_PIN_TEXT_HEADER = "Fishing Pin Text",
  DEST_SETTINGS_FISHING_COLOR_HEADER = "Fishing Pin Colors",
  DEST_SETTINGS_FISHING_MISC_HEADER = "Misc",

  DEST_SETTINGS_FISHING_TOGGLE = "Show incomplete positions",
  DEST_SETTINGS_FISHING_TOGGLE_TT = "Shows Fishing holes where there is a chance of catching fish for achievements",
  DEST_SETTINGS_FISHING_DONE_TOGGLE = "Show completed positions",
  DEST_SETTINGS_FISHING_DONE_TOGGLE_TT = "Show completed Fishing Holes positions",
  DEST_SETTINGS_FISHING_PIN_STYLE = "Pin style for Fishing",
  DEST_SETTINGS_FISHING_SHOW_FISHNAME = "Show fish names on pins",
  DEST_SETTINGS_FISHING_SHOW_FISHNAME_TT = "Shows the missing fish for that type of water",
  DEST_SETTINGS_FISHING_SHOW_BAIT = "Show optimal bait on pins",
  DEST_SETTINGS_FISHING_SHOW_BAIT_TT = "Shows the optimal bait to use",
  DEST_SETTINGS_FISHING_SHOW_BAIT_LEFT = "Show bait left on pins",
  DEST_SETTINGS_FISHING_SHOW_BAIT_LEFT_TT = "Shows how much bait of the optimal types you have left in the bag. IF there is a third number, then that is the Simple Bait",
  DEST_SETTINGS_FISHING_SHOW_WATER = "Show water type on pins",
  DEST_SETTINGS_FISHING_SHOW_WATER_TT = "Shows the type of water",
  DEST_SETTINGS_FISHING_PIN_SIZE = "Pin size for Fishing",
  DEST_SETTINGS_FISHING_PIN_SIZE_TT = "Pin size for Fishing",
  DEST_SETTINGS_FISHING_PIN_LAYER = "Pin layer for Fishing",
  DEST_SETTINGS_FISHING_PIN_LAYER_TT = "Pin layer for Fishing",
  DEST_SETTINGS_FISHING_COMPASS_TOGGLE = "Show on compass",
  DEST_SETTINGS_FISHING_COMPASS_TOGGLE_TT = "Show Fishing Holes on compass",
  DEST_SETTINGS_FISHING_COMPASS_DIST = "Distance on compass",
  DEST_SETTINGS_FISHING_COMPASS_DIST_TT = "Distance for Fishing Holes on compass",
  DEST_SETTINGS_FISHING_COLOR_TITLE = "Achievement title text color",
  DEST_SETTINGS_FISHING_COLOR_TITLE_TT = "Affects the title of the Fishing achievement text",
  DEST_SETTINGS_FISHING_PIN_COLOR = "Missing pin color",
  DEST_SETTINGS_FISHING_PIN_COLOR_TT = "Sets the color of the PINS for missing Fish",
  DEST_SETTINGS_FISHING_COLOR_UNDONE = "Missing text color",
  DEST_SETTINGS_FISHING_COLOR_UNDONE_TT = "Affects the pin TEXT for missing Fish",
  DEST_SETTINGS_FISHING_COLOR_BAIT_UNDONE = "Missing Bait type text color",
  DEST_SETTINGS_FISHING_COLOR_BAIT_UNDONE_TT = "Affects the pin BAIT text for missing Fish, if activated",
  DEST_SETTINGS_FISHING_COLOR_WATER_UNDONE = "Missing Water type text color",
  DEST_SETTINGS_FISHING_COLOR_WATER_UNDONE_TT = "Affects the pin WATER text for missing Fish, if activated",
  DEST_SETTINGS_FISHING_PIN_COLOR_DONE = "Completed pin color",
  DEST_SETTINGS_FISHING_PIN_COLOR_DONE_TT = "Sets the color of the PINS for collected Fish",
  DEST_SETTINGS_FISHING_COLOR_DONE = "Completed text color",
  DEST_SETTINGS_FISHING_COLOR_DONE_TT = "Affects the pin TEXT for completed Fish",
  DEST_SETTINGS_FISHING_COLOR_BAIT_DONE = "Completed Bait type text color",
  DEST_SETTINGS_FISHING_COLOR_BAIT_DONE_TT = "Affects the pin BAIT text for completed Fish, if activated",
  DEST_SETTINGS_FISHING_COLOR_WATER_DONE = "Completed Water type text color",
  DEST_SETTINGS_FISHING_COLOR_WATER_DONE_TT = "Affects the pin WATER text for completed Fish, if activated",

  DEST_SETTINGS_MAPFILTERS_HEADER = "Map Filters",
  DEST_SETTINGS_MAPFILTERS_HEADER_TT = "This submenu covers all Map Filter related settings.",
  DEST_SETTINGS_MAPFILTERS_SUBHEADER = "Map Filter Settings",

  DEST_SETTINGS_MAPFILTERS_POIS_TOGGLE = "Show POI Map filters",
  DEST_SETTINGS_MAPFILTERS_POIS_TOGGLE_TT = "Shows/hides Map Filters for all Points of Interest.",
  DEST_SETTINGS_MAPFILTERS_ACHS_TOGGLE = "Show Achievement Map filters",
  DEST_SETTINGS_MAPFILTERS_ACHS_TOGGLE_TT = "Shows/hides Map Filters for all Achievements.",
  DEST_SETTINGS_MAPFILTERS_QUES_TOGGLE = "Show Questgiver Map filters",
  DEST_SETTINGS_MAPFILTERS_QUES_TOGGLE_TT = "Shows/hides Map Filters for all Questgivers.",
  DEST_SETTINGS_MAPFILTERS_COLS_TOGGLE = "Show Collectible Map filters",
  DEST_SETTINGS_MAPFILTERS_COLS_TOGGLE_TT = "Shows/hides Map Filters for all Collectibles.",
  DEST_SETTINGS_MAPFILTERS_FISS_TOGGLE = "Show Fishing Map filters",
  DEST_SETTINGS_MAPFILTERS_FISS_TOGGLE_TT = "Shows/hides Map Filters for all Fishing holes.",
  DEST_SETTINGS_MAPFILTERS_MISS_TOGGLE = "Show Misc Map filters",
  DEST_SETTINGS_MAPFILTERS_MISS_TOGGLE_TT = "Shows/hides Map Filters for Miscellaneous pins (Ayleid Wells, Dwemer Ruins, Craglorn Border, as well as all Werewolf and Vampire pins).",

  GLOBAL_SETTINGS_SELECT_TEXT_ONLY = "Text only!",

  DEST_SETTINGS_RESET = "Reset to default settings",

  --POI Types
  POITYPE_AOI = "Area of Interest",
  POITYPE_HOUSING = "House",
  POITYPE_CRAFTING = "Crafting Location",
  POITYPE_DELVE = "Delve",
  POITYPE_DOLMEN = "Dolmen",
  POITYPE_GATE = "Gate",
  POITYPE_GROUPBOSS = "Group Boss",
  POITYPE_GROUPDELVE = "Group Delve",
  POITYPE_GROUPDUNGEON = "Group Dungeon",
  POITYPE_GROUPEVENT = "Group Event",
  POITYPE_MUNDUS = "Mundus Stone",
  POITYPE_PUBLICDUNGEON = "Public Dungeon",
  POITYPE_QUESTHUB = "Quest Hub",
  POITYPE_SOLOTRIAL = "Trial",
  POITYPE_TRADER = "Guild Traders",
  POITYPE_TRIALINSTANCE = "Trial Instance",
  POITYPE_UNKNOWN = "Unknown",
  POITYPE_WAYSHRINE = "Wayshrine",
  POITYPE_VAULT = "Vault",
  POITYPE_DARK_BROTHERHOOD = "Dark Brotherhood",
  POITYPE_BREAKING_ENTERING = "Breaking and Entering",
  POITYPE_CUTPURSE_ABOVE = "A Cutpurse Above",

  POITYPE_MAIQ = zo_strformat(GetAchievementInfo(872)),
  POITYPE_LB_GTTP_CP = zo_strformat(GetAchievementInfo(873)) .. "/" .. zo_strformat(GetAchievementInfo(871)) .. "/" .. zo_strformat(GetAchievementInfo(869)),
  POITYPE_PEACEMAKER = zo_strformat(GetAchievementInfo(716)),
  POITYPE_CRIME_PAYS = zo_strformat(GetAchievementInfo(869)),
  POITYPE_GIVE_TO_THE_POOR = zo_strformat(GetAchievementInfo(871)),
  POITYPE_LIGHTBRINGER = zo_strformat(GetAchievementInfo(873)),
  POITYPE_NOSEDIVER = zo_strformat(GetAchievementInfo(406)),
  POITYPE_EARTHLYPOS = zo_strformat(GetAchievementInfo(1121)),
  POITYPE_ON_ME = zo_strformat(GetAchievementInfo(704)),
  POITYPE_BRAWL = zo_strformat(GetAchievementInfo(1247)),
  POITYPE_RELICHUNTER = zo_strformat(GetAchievementInfo(1250)),
  POITYPE_PATRON = zo_strformat(GetAchievementInfo(1316)),
  POITYPE_WROTHGAR_JUMPER = zo_strformat(GetAchievementInfo(1331)),
  POITYPE_BREAKING_ENTERING = zo_strformat(GetAchievementInfo(1349)),
  POITYPE_CUTPURSE_ABOVE = zo_strformat(GetAchievementInfo(1383)),

  POITYPE_AYLEID_WELL = "Ayleid Well",
  POITYPE_DEADLANDS_ENTRANCE = "Deadlands Entrance",
  POITYPE_DRUIDIC_SHRINE = "Druidic Shrine",
  POITYPE_WWVAMP = "Werewolf/Vampire",
  POITYPE_VAMPIRE_ALTAR = "Vampire Altar",
  POITYPE_DWEMER_RUIN = "Dwemer Ruin",
  POITYPE_WEREWOLF_SHRINE = "Werewolf Shrine",

  POITYPE_COLLECTIBLE = "Collectibles",
  POITYPE_FISH = "Fishing",
  POITYPE_UNDETERMINED = "Undetermined",

  -- Quest completion editing texts
  QUEST_EDIT_ON = "Destinations Quest Giver editing is turned ON!",
  QUEST_EDIT_OFF = "Destinations Quest Giver editing is turned OFF!",
  QUEST_MENU_NOT_FOUND = "Could not find the quest in the database",
  QUEST_MENU_HIDE_QUEST = "Hide this quest pin",
  QUEST_MENU_DISABLE_EDIT = "Disable Editing",

  -- Quest types
  QUESTTYPE_NONE = "Quest",
  QUESTTYPE_GROUP = "Group Quest",
  QUESTTYPE_MAIN_STORY = "Main Storyline Quest",
  QUESTTYPE_GUILD = "Guild Quest",
  QUESTTYPE_CRAFTING = "Crafting Quest",
  QUESTTYPE_DUNGEON = "Dungeon Quest",
  QUESTTYPE_RAID = "Raid Quest",
  QUESTTYPE_AVA = "Alliance War Quest",
  QUESTTYPE_CLASS = "Class Quest",
  QUESTTYPE_QA_TEST = "Q&A Test Quest",
  QUESTTYPE_AVA_GROUP = "Alliance War Group Quest",
  QUESTTYPE_AVA_GRAND = "Alliance War Grand Quest",
  QUESTREPEAT_NOT_REPEATABLE = "Normal Quest",
  QUESTREPEAT_REPEATABLE = "Repeatable Quest",
  QUESTREPEAT_DAILY = "Daily Quest",

  -- Fishing
  FISHING_FOUL = "Foul Water",
  FISHING_RIVER = "River",
  FISHING_OCEAN = "Ocean",
  FISHING_LAKE = "Lake",
  FISHING_UNKNOWN = "- unknown -",
  FISHING_FOUL_BAIT = "Crawlers/Fish Roe",
  FISHING_RIVER_BAIT = "Insect Parts/Shad",
  FISHING_OCEAN_BAIT = "Worms/Chub",
  FISHING_LAKE_BAIT = "Guts/Minnow",
  FISHING_HWBC = "Crab-Slaughter-Crane",

  -- Destinations chat commands
  DESTCOMMANDS = "Destinations commands list:",
  DESTCOMMANDdhlp = "/dhlp (Destinations Help) : You just used it ;)",
  DESTCOMMANDdset = "/dset (Destinations Settings) : Opens the Destinations Settings window.",
  DESTCOMMANDdqed = "/dqed (Destinations Quests Editor) : This command will TOGGLE editing of quest pins. It will show in the chat if it's on or off. When ON, open your map and click the pins you want to toggle as done or undone. Remember to turn it OFF when done editing by repeating the command!",

  -- Destinations Misc
  LOAD_NEW_QUEST_FORMAT = "Reset Quest Data",
  LOAD_NEW_QUEST_FORMAT_TT = "This will reload all known quests into a new table. The game will do a /reloadui to complete it.",
  RELOADUI_WARNING = "If you click this button, the game will do a /reloadui",
  RELOADUI_INFO = "Changes to this setting will not be in effect until after you have clicked the 'ReloadUI' button.",
  DEST_SETTINGS_RELOADUI = "ReloadUI",
  DEST_SET_REQUIREMENT = "<<1>> traits required",
}

for key, value in pairs(strings) do
  ZO_CreateStringId(key, value)
  SafeAddVersion(key, 1)
end
