﻿-------------------------------------------
-- English localization for Destinations --
-------------------------------------------
do
  local Add = ZO_CreateStringId

  --Map Filter Tags
  Add("DEST_FILTER_UNKNOWN", "(Dest) Unknown POIs")
  Add("DEST_FILTER_KNOWN", "(Dest) Known POIs")
  Add("DEST_FILTER_OTHER", "(Dest) Other Achievements")
  Add("DEST_FILTER_OTHER_DONE", "(Dest) Other Achievements Done")
  Add("DEST_FILTER_MAIQ", "(Dest) " .. zo_strformat(GetAchievementInfo(872)))
  Add("DEST_FILTER_MAIQ_DONE", "(Dest) " .. zo_strformat(GetAchievementInfo(872)) .. " Done")
  Add("DEST_FILTER_PEACEMAKER", "(Dest) " .. zo_strformat(GetAchievementInfo(716)))
  Add("DEST_FILTER_PEACEMAKER_DONE", "(Dest) " .. zo_strformat(GetAchievementInfo(716)) .. " Done")
  Add("DEST_FILTER_NOSEDIVER", "(Dest) " .. zo_strformat(GetAchievementInfo(406)))
  Add("DEST_FILTER_NOSEDIVER_DONE", "(Dest) " .. zo_strformat(GetAchievementInfo(406)) .. " Done")
  Add("DEST_FILTER_EARTHLYPOS", "(Dest) " .. zo_strformat(GetAchievementInfo(1121)))
  Add("DEST_FILTER_EARTHLYPOS_DONE", "(Dest) " .. zo_strformat(GetAchievementInfo(1121)) .. " Done")
  Add("DEST_FILTER_ON_ME", "(Dest) " .. zo_strformat(GetAchievementInfo(704)))
  Add("DEST_FILTER_ON_ME_DONE", "(Dest) " .. zo_strformat(GetAchievementInfo(704)) .. " Done")
  Add("DEST_FILTER_BRAWL", "(Dest) " .. zo_strformat(GetAchievementInfo(1247)))
  Add("DEST_FILTER_BRAWL_DONE", "(Dest) " .. zo_strformat(GetAchievementInfo(1247)) .. " Done")
  Add("DEST_FILTER_PATRON", "(Dest) " .. zo_strformat(GetAchievementInfo(1316)))
  Add("DEST_FILTER_PATRON_DONE", "(Dest) " .. zo_strformat(GetAchievementInfo(1316)) .. " Done")
  Add("DEST_FILTER_WROTHGAR_JUMPER", "(Dest) " .. zo_strformat(GetAchievementInfo(1331)))
  Add("DEST_FILTER_WROTHGAR_JUMPER_DONE", "(Dest) " .. zo_strformat(GetAchievementInfo(1331)) .. " Done")
  Add("DEST_FILTER_RELIC_HUNTER", "(Dest) " .. zo_strformat(GetAchievementInfo(1250)))
  Add("DEST_FILTER_RELIC_HUNTER_DONE", "(Dest) " .. zo_strformat(GetAchievementInfo(1250)) .. " Done")
  Add("DEST_FILTER_BREAKING_ENTERING", "(Dest) " .. zo_strformat(GetAchievementInfo(1349)))
  Add("DEST_FILTER_BREAKING_ENTERING_DONE", "(Dest) " .. zo_strformat(GetAchievementInfo(1349)) .. " Done")
  Add("DEST_FILTER_CUTPURSE_ABOVE", "(Dest) " .. zo_strformat(GetAchievementInfo(1383)))
  Add("DEST_FILTER_CUTPURSE_ABOVE_DONE", "(Dest) " .. zo_strformat(GetAchievementInfo(1383)) .. " Done")

  Add("DEST_FILTER_CHAMPION", "(Dest) Dungeon Champions")
  Add("DEST_FILTER_CHAMPION_DONE", "(Dest) Dungeon Champions Done")

  Add("DEST_FILTER_COLLECTIBLE", "(Dest) Collectibles Pins")
  Add("DEST_FILTER_COLLECTIBLE_DONE", "(Dest) Collectibles Done")

  Add("DEST_FILTER_FISHING", "(Dest) Fishing Pins")
  Add("DEST_FILTER_FISHING_DONE", "(Dest) Fishing Done")

  Add("DEST_FILTER_QUESTGIVER", "(Dest) Quest Giver Pins")
  Add("DEST_FILTER_QUESTS_IN_PROGRESS", "(Dest) Quests in progress")
  Add("DEST_FILTER_QUESTS_DONE", "(Dest) Quests Done")

  Add("DEST_FILTER_AYLEID", "(Dest) Ayleid Wells")
  Add("DEST_FILTER_DWEMER", "(Dest) Dwemer Ruins")
  Add("DEST_FILTER_BORDER", "(Dest) Craglorn Border Line")

  Add("DEST_FILTER_WWVAMP", "(Dest) Werewolfs and Vampires")
  Add("DEST_FILTER_VAMPIRE_ALTAR", "(Dest) Vampire Alters")
  Add("DEST_FILTER_WEREWOLF_SHRINE", "(Dest) Werewolf Shrines")

  --Settings Menu
  Add("DEST_SETTINGS_TITLE", "Destinations")

  Add("DEST_SETTINGS_USE_ACCOUNTWIDE", "Accountweite Einstellungen")
  Add("DEST_SETTINGS_USE_ACCOUNTWIDE_TT", "Wenn eingeschaltet, gelten die Einstellugen für alle Charakter.")
  Add("DEST_SETTINGS_RELOAD_WARNING", "Benutze den Chat-Befehl \'/reloadui\' um die Einstellungen wirksam zu machen")
  Add("DEST_SETTINGS_PER_CHAR_HEADER",
    "Einstellungen die mit '*' markiert sind, gelten ausschliesslich für den aktuellen Charakter.")
  Add("DEST_SETTINGS_PER_CHAR", "*")
  Add("DEST_SETTINGS_PER_CHAR_TOGGLE_TT", "Der Wechsel hat nur Einfluss auf den aktuellen Charakter.")
  Add("DEST_SETTINGS_PER_CHAR_BUTTON_TT", "Dieser Knopf hat nur Einfluss auf den aktuellen Charakter.")

  Add("DEST_SETTINGS_IMPROVEMENT_HEADER", "POI Improvement")
  Add("DEST_SETTINGS_IMPROVEMENT_HEADER_TT", "Improve unknown and known POI")
  Add("DEST_SETTINGS_POI_ENGLISH_TEXT_HEADER", "English text on Points of interest")
  Add("DEST_SETTINGS_POI_SHOW_ENGLISH", "Show english POI names")
  Add("DEST_SETTINGS_POI_SHOW_ENGLISH_TT", "Show english POI names at the top of the map")
  Add("DEST_SETTINGS_POI_ENGLISH_COLOR", "Text color for English POI names")
  Add("DEST_SETTINGS_POI_ENGLISH_COLOR_TT", "Set the text color for english translation of POI names")
  Add("DEST_SETTINGS_POI_SHOW_ENGLISH_KEEPS", "Show english POI names for Keeps")
  Add("DEST_SETTINGS_POI_SHOW_ENGLISH_KEEPS_TT", "Show english POI names on the keep tooltip")
  Add("DEST_SETTINGS_POI_ENGLISH_KEEPS_COLOR", "Text color for English Keeps names")
  Add("DEST_SETTINGS_POI_ENGLISH_KEEPS_COLOR_TT", "Set the text color for english translation of Keeps names")
  Add("DEST_SETTINGS_POI_ENGLISH_KEEPS_HA", "Hide Alliance Name on Keeps Tooltips")
  Add("DEST_SETTINGS_POI_ENGLISH_KEEPS_HA_TT", "Hide Alliance Name on Keeps Tooltips")
  Add("DEST_SETTINGS_POI_ENGLISH_KEEPS_NL", "Add a new line on Keeps tooltips")
  Add("DEST_SETTINGS_POI_ENGLISH_KEEPS_NL_TT", "Add a new line on Keeps tooltips for english name")
  Add("DEST_SETTINGS_POI_IMPROVE_MUNDUS", "Improve Mundus POIs")
  Add("DEST_SETTINGS_POI_IMPROVE_MUNDUS_TT", "Improve Mundus POIs by adding effect description on tooltip")
  Add("DEST_SETTINGS_POI_IMPROVE_CRAFTING", "Improve Crafting POIs")
  Add("DEST_SETTINGS_POI_IMPROVE_CRAFTING_TT", "Improve Crafting POIs by adding set description on tooltip")

  Add("DEST_SETTINGS_POI_HEADER", "Sehenswürdigkeiten")
  Add("DEST_SETTINGS_POI_HEADER_TT",
    "Dieses untermenü deckt dir unbekannte und bekannte Sehenswürdigkeiten, sowie Gildenhändler auf.")
  Add("DEST_SETTINGS_POI_UNKOWN_SUBHEADER", "unbekannte Sehenswürdigkeiten")
  Add("DEST_SETTINGS_POI_KNOWN_SUBHEADER", "bekannte Sehenswürdigkeiten")
  Add("DEST_SETTINGS_POIS_ENGLISH_TEXT_HEADER", "Englische Bezeichnungen der Sehenswürdigkeiten")

  Add("DEST_SETTINGS_UNKNOWN_PIN_TOGGLE", "Zeigt unbekannte Sehenswürdigkeiten")
  Add("DEST_SETTINGS_UNKNOWN_PIN_STYLE", "Symbolstil")
  Add("DEST_SETTINGS_UNKNOWN_PIN_SIZE", "Symbolgrösse")
  Add("DEST_SETTINGS_UNKNOWN_PIN_LAYER", "Symbolebene (Layer)")
  Add("DEST_SETTINGS_UNKNOWN_COLOR", "Symbolfarbe")
  Add("DEST_SETTINGS_UNKNOWN_COLOR_TT", "Betrifft alle unbekannten Sehenswürdigkeiten")
  Add("DEST_SETTINGS_UNKNOWN_COLOR_EN", "Textfarbe der englischen Bezeichnungen")
  Add("DEST_SETTINGS_UNKNOWN_COLOR_EN_TT", "Betrifft alle englischen Bezeichnungen, sofern diese aktiviert sind")
  Add("DEST_SETTINGS_KNOWN_PIN_TOGGLE", "Zeigt bekannte Sehenswürdigkeiten")
  Add("DEST_SETTINGS_KNOWN_PIN_STYLE", "Symbolstil")
  Add("DEST_SETTINGS_KNOWN_PIN_SIZE", "Symbolgrösse")
  Add("DEST_SETTINGS_KNOWN_PIN_LAYER", "Symbolebene (Layer)")
  Add("DEST_SETTINGS_KNOWN_COLOR", "Symbolfarbe")
  Add("DEST_SETTINGS_KNOWN_COLOR_TT", "Betrifft alle bekannten Sehenswürdigkeiten")
  Add("DEST_SETTINGS_KNOWN_COLOR_EN", "Textfarbe der englischen Bezeichnungen")
  Add("DEST_SETTINGS_KNOWN_COLOR_EN_TT", "Betrifft alle englischen Bezeichnungen, sofern diese aktiviert sind")
  Add("DEST_SETTINGS_MUNDUS_DETAIL_PIN_TOGGLE", "Mundussteine Details anzeigen")
  Add("DEST_SETTINGS_MUNDUS_TXT_COLOR", "Textfarbe")
  Add("DEST_SETTINGS_MUNDUS_TXT_COLOR_TT", "Textfarbe der Mundusstein Bezeichnungen")
  Add("DEST_SETTINGS_GTRADER_COLOR", "Symbolfarbe")
  Add("DEST_SETTINGS_GTRADER_COLOR_TT", "Farbe der Symbole von Gildenhändlern")
  Add("DEST_SETTINGS_ALL_SHOW_ENGLISH",
    "* nicht auf englischen Systemen möglich") -- Should read "Show english POI names" on all non-english clients.

  Add("DEST_SETTINGS_ACH_HEADER", "Errungenschaften")
  Add("DEST_SETTINGS_ACH_HEADER_TT", "Dieses Untermenü zeigt dir die meisten Errungenschaftspositionen im Spiel an")
  Add("DEST_SETTINGS_ACH_PIN_TOGGLE", "Zeige unvollständige Errungenschaften")
  Add("DEST_SETTINGS_ACH_PIN_TOGGLE_DONE", "Zeige vollständige Errungenschaften")
  Add("DEST_SETTINGS_ACH_PIN_STYLE", "Symbolstil")
  Add("DEST_SETTINGS_ACH_PIN_SIZE", "Symbolgrösse")

  Add("DEST_SETTINGS_ACH_OTHER_HEADER", "Lichtbringer, Gaben für die Amen, Verbrechen zahlt sich aus")
  Add("DEST_SETTINGS_ACH_MAIQ_HEADER", "Auf M'aiqs Spuren")
  Add("DEST_SETTINGS_ACH_PEACEMAKER_HEADER", "Friedensschöpfer")
  Add("DEST_SETTINGS_ACH_NOSEDIVER_HEADER", "Voll auf die Nase")
  Add("DEST_SETTINGS_ACH_EARTHLYPOS_HEADER", "Weltliche Besitztümer")
  Add("DEST_SETTINGS_ACH_ON_ME_HEADER", "Der hier geht auf mich")
  Add("DEST_SETTINGS_ACH_BRAWL_HEADER", "Ein letztes Gemenge")
  Add("DEST_SETTINGS_ACH_PATRON_HEADER", "Unterstützer Orsiniums")
  Add("DEST_SETTINGS_ACH_WROTHGAR_JUMPER_HEADER", "Klippenspringer Wrothgars")
  Add("DEST_SETTINGS_ACH_RELIC_HUNTER_HEADER", "Reliktjäger Wrothgars")
  Add("DEST_SETTINGS_ACH_BREAKING_HEADER", "Aufbrechen und Eindringen")
  Add("DEST_SETTINGS_ACH_CUTPURSE_HEADER", "Leert die Landung")

  Add("DEST_SETTINGS_ACH_CHAMPION_PIN_HEADER", "Champions")
  Add("DEST_SETTINGS_ACH_CHAMPION_ZONE_PIN_TOGGLE", "Auf Weltkarte anzeigen")
  Add("DEST_SETTINGS_ACH_CHAMPION_ZONE_PIN_TOGGLE_TT",
    "This is for turning Champions (solo dungeons bosses) on/off on ZONE MAPS")
  Add("DEST_SETTINGS_ACH_CHAMPION_FRONT_PIN_TOGGLE", "ESO Pinmarkierung")
  Add("DEST_SETTINGS_ACH_CHAMPION_FRONT_PIN_TOGGLE_TT",
    "Wenn die ESO Pinmarkierung aktiviert ist, sollte diese vor dem Destinations Symbol erscheinen")
  Add("DEST_SETTINGS_ACH_CHAMPION_PIN_SIZE", "Symbolgrösse")

  Add("DEST_SETTINGS_ACH_GLOBAL_HEADER", "Errungenschaften - Allgemeines")
  Add("DEST_SETTINGS_ACH_GLOBAL_HEADER_TT",
    "Dieses Untermenü zeigt die globalen Einstellungen für die Errungenschaften")
  Add("DEST_SETTINGS_ACH_ALL_PIN_LAYER", "Symbolebene (Layer)")
  Add("DEST_SETTINGS_ACH_PIN_COLOR_MISS", "Symbolfarbe (unvollständig)")
  Add("DEST_SETTINGS_ACH_PIN_COLOR_MISS_TT", "Beeinflusst die Symbolfarbe für unvollständige Errungenschaften")
  Add("DEST_SETTINGS_ACH_TXT_COLOR_MISS", "Textfarbe (unvollständig)")
  Add("DEST_SETTINGS_ACH_TXT_COLOR_MISS_TT", "Beeinflusst die Textfarbe für unvollständige Errungenschaften")
  Add("DEST_SETTINGS_ACH_PIN_COLOR_DONE", "Symbolfarbe (vollständig)")
  Add("DEST_SETTINGS_ACH_PIN_COLOR_DONE_TT", "Beeinflusst die Symbolfarbe für vollständige Errungenschaften")
  Add("DEST_SETTINGS_ACH_TXT_COLOR_DONE", "Textfarbe (vollständig)")
  Add("DEST_SETTINGS_ACH_TXT_COLOR_DONE_TT", "Beeinflusst die Textfarbe für vollständige Errungenschaften")
  Add("DEST_SETTINGS_ACH_ALL_COMPASS_TOGGLE", "Errungenschaften im Kompass anzeigen")
  Add("DEST_SETTINGS_ACH_ALL_COMPASS_DIST", "Distanz im Kompass")

  Add("DEST_SETTINGS_MISC_HEADER", "Verschiedene Sehenswürdigkeiten")
  Add("DEST_SETTINGS_MISC_HEADER_TT", "This submenu covers Ayleid Wells, Dwemer Ruins and the Craglorn Border line.")
  Add("DEST_SETTINGS_MISC_AYLEID_WELL_HEADER", "Ayleïden Brunnen")
  Add("DEST_SETTINGS_MISC_DWEMER_HEADER", "Dwemerruinen")
  Add("DEST_SETTINGS_MISC_COMPASS_HEADER", "Verschiedenes")
  Add("DEST_SETTINGS_MISC_BORDER_HEADER", "Kargstein Grenze")

  Add("DEST_SETTINGS_MISC_PIN_AYLEID_WELL_TOGGLE", "Zeige Ayleïden Brunnen")
  Add("DEST_SETTINGS_MISC_PIN_AYLEID_WELL_TOGGLE_TT", "Zeigt Ayleïden Brunnen auf der Weltkarte an")
  Add("DEST_SETTINGS_MISC_PIN_AYLEID_WELL_SIZE", "Symbolgrösse")
  Add("DEST_SETTINGS_MISC_PIN_AYLEID_WELL_COLOR", "Symbolfarbe")
  Add("DEST_SETTINGS_MISC_PIN_AYLEID_WELL_COLOR_TT", "Beeinflusst die Symbolfarbe für Ayleïden Brunnen")
  Add("DEST_SETTINGS_MISC_PINTEXT_AYLEID_WELL_COLOR", "Textfarbe")
  Add("DEST_SETTINGS_MISC_PINTEXT_AYLEID_WELL_COLOR_TT", "Beeinflusst die Textfarbe für Ayleïden Brunnen")
  Add("DEST_SETTINGS_MISC_DWEMER_PIN_TOGGLE", "Zeige Dwemerruinen")
  Add("DEST_SETTINGS_MISC_DWEMER_PIN_TOGGLE_TT", "Zeigt Dwemerruinen auf der Weltkarte an")
  Add("DEST_SETTINGS_MISC_DWEMER_PIN_SIZE", "Symbolgrösse")
  Add("DEST_SETTINGS_MISC_DWEMER_PIN_COLOR", "Symbolfarbe")
  Add("DEST_SETTINGS_MISC_DWEMER_PIN_COLOR_TT", "Beeinflusst die Symbolfarbe für Dwemerruinen")
  Add("DEST_SETTINGS_MISC_DWEMER_PINTEXT_COLOR", "Textfarbe")
  Add("DEST_SETTINGS_MISC_DWEMER_PINTEXT_COLOR_TT", "Beeinflusst die Textfarbe für Dwemerruinen")
  Add("DEST_SETTINGS_MISC_PIN_LAYER", "Symbolebene (Layer)")
  Add("DEST_SETTINGS_MISC_COMPASS_PIN_TOGGLE", "Verschiedene Sehenswürdigkeiten im Kompass anzeigen")
  Add("DEST_SETTINGS_MISC_COMPASS_DIST", "Distanz im Kompass")
  Add("DEST_SETTINGS_MISC_BORDER_PIN_TOGGLE", "Grenze in Kargstein")
  Add("DEST_SETTINGS_MISC_BORDER_PIN_TOGGLE_TT", "Zeigt die Grenze vom oberen zum unteren Kargstein")
  Add("DEST_SETTINGS_MISC_BORDER_SIZE", "Symbolgrösse")
  Add("DEST_SETTINGS_MISC_BORDER_PIN_COLOR", "Symbolfarbe")
  Add("DEST_SETTINGS_MISC_BORDER_PIN_COLOR_TT", "Beeinflusst die Symbolfarbe der Grenzlinie")

  Add("DEST_SETTINGS_VWW_HEADER", "Vampire und Werwölfe")
  Add("DEST_SETTINGS_VWW_HEADER_TT", "Dieses Untermenü zeigt dir Aufenthaltspunkte, Altäre und Schreine.")
  Add("DEST_SETTINGS_VWW_WWVAMP_HEADER", "Vampire und Werwölfe Aufenhaltspunkte")
  Add("DEST_SETTINGS_VWW_VAMP_HEADER", "Vampir Altäre")
  Add("DEST_SETTINGS_VWW_WW_HEADER", "Werwolf Schreine")
  Add("DEST_SETTINGS_VWW_COMPASS_HEADER", "Verschiedenes")

  Add("DEST_SETTINGS_VWW_PIN_WWVAMP_TOGGLE", "Zeige Vampir/WW Aufenhaltspunkte")
  Add("DEST_SETTINGS_VWW_PIN_WWVAMP_TOGGLE_TT",
    "Diese Einstellung hilft dir Aufenhaltspunkte von Vampire und Werwölfen auf der Weltkarte anzeigen zu lassen")
  Add("DEST_SETTINGS_VWW_PIN_WWVAMP_SIZE", "Symbolgrösse")
  Add("DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_TOGGLE", "Zeige Vampir Altäre")
  Add("DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_TOGGLE_TT", "Diese Einstellung zeigt dir die Altäre auf der Weltkarte an")
  Add("DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_SIZE", "Symbolgrösse")
  Add("DEST_SETTINGS_VWW_PIN_WW_SHRINE_TOGGLE", "Zeige Werwolf Schreine")
  Add("DEST_SETTINGS_VWW_PIN_WW_SHRINE_TOGGLE_TT", "Diese Einstellung zeigt dir die Schreine auf der Weltkarte an")
  Add("DEST_SETTINGS_VWW_PIN_WW_SHRINE_SIZE", "Symbolgrösse")
  Add("DEST_SETTINGS_VWW_PIN_LAYER", "Symbolebene (Layer)")
  Add("DEST_SETTINGS_VWW_COMPASS_PIN_TOGGLE", "Im Kompass anzeigen")
  Add("DEST_SETTINGS_VWW_COMPASS_DIST", "Distanz im Kompass")
  Add("DEST_SETTINGS_VWW_PIN_COLOR", "Symbolfarbe")
  Add("DEST_SETTINGS_VWW_PIN_COLOR_TT", "Beeinflusst die Symbolfarbe")
  Add("DEST_SETTINGS_VWW_PINTEXT_COLOR", "Textfarbe")
  Add("DEST_SETTINGS_VWW_PINTEXT_COLOR_TT", "Beeinflusst die Textfarbe")

  Add("DEST_SETTINGS_QUEST_HEADER", "Quest Positionen")
  Add("DEST_SETTINGS_QUEST_HEADER_TT", "Dieses Untermenü bezieht sich auf alle Quest bezogenen Einstellungen")
  Add("DEST_SETTINGS_QUEST_UNDONE_HEADER", "unvollständige Quests")
  Add("DEST_SETTINGS_QUEST_INPROGRESS_HEADER", "angefangene Quests")
  Add("DEST_SETTINGS_QUEST_DONE_HEADER", "vollständige Quests")
  Add("DEST_SETTINGS_QUEST_CADWELLS_HEADER", "Cadwells Almanach")
  Add("DEST_SETTINGS_QUEST_DAILIES_HEADER", "Dailies/Wiederholbare")
  Add("DEST_SETTINGS_QUEST_COMPASS_HEADER", "Verschiedenes")
  Add("DEST_SETTINGS_QUEST_REGISTER_HEADER", "Anderes")

  Add("DEST_SETTINGS_QUEST_UNDONE_PIN_TOGGLE", "Zeige Quest Positionen")
  Add("DEST_SETTINGS_QUEST_UNDONE_PIN_SIZE", "Symbolgrösse")
  Add("DEST_SETTINGS_QUEST_UNDONE_PIN_COLOR", "Symbolfarbe")
  Add("DEST_SETTINGS_QUEST_UNDONE_PIN_COLOR_TT", "Beeinflusst die Symbolfarbe")
  Add("DEST_SETTINGS_QUEST_UNDONE_MAIN_PIN_COLOR", "Symbolfarbe für Hauptquests")
  Add("DEST_SETTINGS_QUEST_UNDONE_MAIN_PIN_COLOR_TT",
    "Beeinflusst die Symbolfarbe für noch nicht angenommene Hauptquests")
  Add("DEST_SETTINGS_QUEST_UNDONE_DAY_PIN_COLOR", "Symbolfarbe für Dailies")
  Add("DEST_SETTINGS_QUEST_UNDONE_DAY_PIN_COLOR_TT", "Beeinflusst die Symbolfarbe für Dailies")
  Add("DEST_SETTINGS_QUEST_UNDONE_REP_PIN_COLOR", "Symbolfarbe für wiederholbare Quests")
  Add("DEST_SETTINGS_QUEST_UNDONE_REP_PIN_COLOR_TT",
    "Beeinflusst die Symbolfarbe für noch nicht angenommene wiederholbare Quests")
  Add("DEST_SETTINGS_QUEST_UNDONE_DUN_PIN_COLOR", "Symbolfarbe für Verlies Quests")
  Add("DEST_SETTINGS_QUEST_UNDONE_DUN_PIN_COLOR_TT",
    "Beeinflusst die Symbolfarbe für noch nicht angenommene Verlies Quests")
  Add("DEST_SETTINGS_QUEST_UNDONE_PINTEXT_COLOR", "Textfarbe von Questgebern")
  Add("DEST_SETTINGS_QUEST_UNDONE_PINTEXT_COLOR_TT", "Beeinflusst die Textfarbe für noch nicht angenommene Quests")
  Add("DEST_SETTINGS_QUEST_INPROGRESS_PIN_TOGGLE", "Zeige angefangene Quests")
  Add("DEST_SETTINGS_QUEST_INPROGRESS_PIN_SIZE", "Symbolgrösse")
  Add("DEST_SETTINGS_QUEST_INPROGRESS_PIN_COLOR", "Symbolfarbe")
  Add("DEST_SETTINGS_QUEST_INPROGRESS_PIN_COLOR_TT", "Beeinflusst die Symbolfarbe der Quests in deinem Questjournal")
  Add("DEST_SETTINGS_QUEST_INPROGRESS_PINTEXT_COLOR", "Textfarbe")
  Add("DEST_SETTINGS_QUEST_INPROGRESS_PINTEXT_COLOR_TT", "Beeinflusst die Textfarbe der Quests in deinem Questjournal")
  Add("DEST_SETTINGS_QUEST_DONE_PIN_TOGGLE", "Zeige vollständige Quests")
  Add("DEST_SETTINGS_QUEST_DONE_PIN_SIZE", "Symbolgrösse")
  Add("DEST_SETTINGS_QUEST_DONE_PIN_COLOR", "Symbolfarbe")
  Add("DEST_SETTINGS_QUEST_DONE_PIN_COLOR_TT", "Beeinflusst die Symbolfarbe")
  Add("DEST_SETTINGS_QUEST_DONE_PINTEXT_COLOR", "Textfarbe")
  Add("DEST_SETTINGS_QUEST_DONE_PINTEXT_COLOR_TT", "Beeinflusst die Textfarbe")
  Add("DEST_SETTINGS_QUEST_CADWELLS_PIN_TOGGLE", "Zeige Cadwells Almanach")
  Add("DEST_SETTINGS_QUEST_CADWELLS_PIN_TOGGLE_TT", "Zeigt die Quests für Cadwells Almanach")
  Add("DEST_SETTINGS_QUEST_CADWELLS_ONLY_PIN_TOGGLE", "Verstecke andere Quests")
  Add("DEST_SETTINGS_QUEST_CADWELLS_ONLY_PIN_TOGGLE_TT",
    "Versteckt alle normaen Quests welche NICHT von Cadwells Almanach sind")
  Add("DEST_SETTINGS_QUEST_WRITS_PIN_TOGGLE", "Handwerksschriebe")
  Add("DEST_SETTINGS_QUEST_WRITS_PIN_TOGGLE_TT", "Zeige Handwerksschriebe")
  Add("DEST_SETTINGS_QUEST_DAILIES_PIN_TOGGLE", "Dailies")
  Add("DEST_SETTINGS_QUEST_DAILIES_PIN_TOGGLE_TT", "Zeige Dailies")
  Add("DEST_SETTINGS_QUEST_REPEATABLES_PIN_TOGGLE", "Wiederholbare")
  Add("DEST_SETTINGS_QUEST_REPEATABLES_PIN_TOGGLE_TT", "Zeige Wiederholbare")
  Add("DEST_SETTINGS_QUEST_ALL_PIN_LAYER", "Symbolebene (Layer) aller Questpins")
  Add("DEST_SETTINGS_QUEST_COMPASS_TOGGLE", "Quests im Kompass")
  Add("DEST_SETTINGS_QUEST_COMPASS_DIST", "Distanz im Kompass")
  Add("DEST_SETTINGS_REGISTER_QUESTS_TOGGLE", "Quests erfassen")
  Add("DEST_SETTINGS_REGISTER_QUESTS_TOGGLE_TT",
    "Speichert die Questinfos in deinen SavedVariables um neue dem Author zu melden. Genauere Infos bitte auf ESOUI.com nachlesen.")
  Add("DEST_SETTINGS_QUEST_RESET_HIDDEN", "Versteckte Quests zurücksetzen")
  Add("DEST_SETTINGS_QUEST_RESET_HIDDEN_TT", "Setzt alle versteckten Quests auf der Weltkarte/Kompass zurück.")

  Add("DEST_SETTINGS_COLLECTIBLES_HEADER", "Sammlungen")
  Add("DEST_SETTINGS_COLLECTIBLES_HEADER_TT", "Dieses Untermenü zeigt die für eure Sammlungen relevante Sachen an.")
  Add("DEST_SETTINGS_COLLECTIBLES_SUBHEADER", "Einstellungen")
  Add("DEST_SETTINGS_COLLECTIBLES_COLORS_HEADER", "Symbolfarben")
  Add("DEST_SETTINGS_COLLECTIBLES_MISC_HEADER", "Verschiedenes")

  Add("DEST_SETTINGS_COLLECTIBLES_TOGGLE", "Zeige unvollständige Sammlungen")
  Add("DEST_SETTINGS_COLLECTIBLES_TOGGLE_TT",
    "Zeige Bereiche wo sich Monster aufhalten, damit du deine Sammlungen vervollständigen kannst")
  Add("DEST_SETTINGS_COLLECTIBLES_DONE_TOGGLE", "Zeige vollständige Sammlungen")
  Add("DEST_SETTINGS_COLLECTIBLES_DONE_TOGGLE_TT", "Zeige Bereiche von bereits abgeschlossenen Sammlungen")
  Add("DEST_SETTINGS_COLLECTIBLES_PIN_STYLE", "Symbolstil")
  Add("DEST_SETTINGS_COLLECTIBLES_SHOW_MOBNAME", "Zeige Monsternamen")
  Add("DEST_SETTINGS_COLLECTIBLES_SHOW_MOBNAME_TT",
    "Zeigt die Namen der Monster wo die entsprechenden Gegenstände der Sammlung auftauchen können. Derzeitig sind die Namen nur in Englisch verfügbar")
  Add("DEST_SETTINGS_COLLECTIBLES_SHOW_ITEM", "Zeige Gegenstandsname")
  Add("DEST_SETTINGS_COLLECTIBLES_SHOW_ITEM_TT", "Zeigt dir den Namen des noch benötigten Gegenstandes der Sammlung an")
  Add("DEST_SETTINGS_COLLECTIBLES_PIN_SIZE", "Symbolgrösse")
  Add("DEST_SETTINGS_COLLECTIBLES_PIN_SIZE_TT", "Symbolgrösse")
  Add("DEST_SETTINGS_COLLECTIBLES_PIN_LAYER", "Symbolebene (Layer)")
  Add("DEST_SETTINGS_COLLECTIBLES_PIN_LAYER_TT", "Symbolebene (Layer)")
  Add("DEST_SETTINGS_COLLECTIBLES_COMPASS_TOGGLE", "Sammlungen im Kompass")
  Add("DEST_SETTINGS_COLLECTIBLES_COMPASS_TOGGLE_TT", "Sammlungen werden im Kompass angezeigt")
  Add("DEST_SETTINGS_COLLECTIBLES_COMPASS_DIST", "Distanz im Kompass")
  Add("DEST_SETTINGS_COLLECTIBLES_COMPASS_DIST_TT",
    "Distanz zu den Bereichen im Kompass, wo sich die Sammlungsgegenstände aufhalten")
  Add("DEST_SETTINGS_COLLECTIBLES_COLOR_TITLE", "Textfarbe des Titels")
  Add("DEST_SETTINGS_COLLECTIBLES_COLOR_TITLE_TT", "Beeinflusst die Textfarbe des Titels von Sammlungen")
  Add("DEST_SETTINGS_COLLECTIBLES_PIN_COLOR", "Symbolfarbe fehlender Sammlungen")
  Add("DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_TT", "Beeinflusst die Symbolfarbe fehlender Sammlungen")
  Add("DEST_SETTINGS_COLLECTIBLES_COLOR_UNDONE", "Textfarbe fehlender Sammlungen")
  Add("DEST_SETTINGS_COLLECTIBLES_COLOR_UNDONE_TT", "Beeinflusst die Textfarbe fehlender Sammlungen")
  Add("DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_DONE", "Symbolfarbe vollständiger Sammlungen")
  Add("DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_DONE_TT", "Beeinflusst die Symbolfarbe vollständiger Sammlungen")
  Add("DEST_SETTINGS_COLLECTIBLES_COLOR_DONE", "Textfarbe vollständiger Sammlungen")
  Add("DEST_SETTINGS_COLLECTIBLES_COLOR_DONE_TT", "Beeinflusst die Textfarbe vollständiger Sammlungen")

  Add("DEST_SETTINGS_FISHING_HEADER", "Angeln")
  Add("DEST_SETTINGS_FISHING_HEADER_TT", "Dieses Untermenü zeigt umfasst die Einstellungen rund um das Angeln.")
  Add("DEST_SETTINGS_FISHING_SUBHEADER", "Einstellungen")
  Add("DEST_SETTINGS_FISHING_PIN_TEXT_HEADER", "Bezeichnungen")
  Add("DEST_SETTINGS_FISHING_COLOR_HEADER", "Textfarbe")
  Add("DEST_SETTINGS_FISHING_MISC_HEADER", "Diverses")

  Add("DEST_SETTINGS_FISHING_TOGGLE", "Zeige unvollständige Fischgründe")
  Add("DEST_SETTINGS_FISHING_TOGGLE_TT",
    "Zeigt nur Fischgründe an, wo eine Chance besteht, einen Fisch zu einer Errungenschaft zu bekommen")
  Add("DEST_SETTINGS_FISHING_DONE_TOGGLE", "Zeige alle Fischgründe")
  Add("DEST_SETTINGS_FISHING_DONE_TOGGLE_TT", "Zeigt alle Fischgründe an")
  Add("DEST_SETTINGS_FISHING_PIN_STYLE", "Symbolstil")
  Add("DEST_SETTINGS_FISHING_SHOW_FISHNAME", "Fischnamen anzeigen")
  Add("DEST_SETTINGS_FISHING_SHOW_FISHNAME_TT", "Zeigt die möglich zu fangenden Fischnamen an")
  Add("DEST_SETTINGS_FISHING_SHOW_BAIT", "Benötigte Köder anzeigen")
  Add("DEST_SETTINGS_FISHING_SHOW_BAIT_TT", "Zeigt die optimalen Köder für dieses Gewässer an")
  Add("DEST_SETTINGS_FISHING_SHOW_BAIT_LEFT", "Verfügbare Köder anzeigen")
  Add("DEST_SETTINGS_FISHING_SHOW_BAIT_LEFT_TT",
    "Zeigt dir die Anzahl der verfügbaren und optimalen Köder an. Falls eine dritte Zahl hinter den beiden Köder erscheint bedeutet es, die Anzahl \'einfacher Köder\' die du ebenfalls verwenden könntest.")
  Add("DEST_SETTINGS_FISHING_SHOW_WATER", "Gewässername")
  Add("DEST_SETTINGS_FISHING_SHOW_WATER_TT", "Zeigt dir den Gewässername an")
  Add("DEST_SETTINGS_FISHING_PIN_SIZE", "Symbolgrösse")
  Add("DEST_SETTINGS_FISHING_PIN_SIZE_TT", "Symbolgrösse")
  Add("DEST_SETTINGS_FISHING_PIN_LAYER", "Symbolebene (Layer)")
  Add("DEST_SETTINGS_FISHING_PIN_LAYER_TT", "Symbolebene (Layer)")
  Add("DEST_SETTINGS_FISHING_COMPASS_TOGGLE", "Fischgründe im Kompass anzeigen")
  Add("DEST_SETTINGS_FISHING_COMPASS_TOGGLE_TT", "Fischgründe im Kompass anzeigen")
  Add("DEST_SETTINGS_FISHING_COMPASS_DIST", "Distanz im Kompass")
  Add("DEST_SETTINGS_FISHING_COMPASS_DIST_TT", "Distanz zu den Bereichen im Kompass, wo sich die Fischgründe befinden")
  Add("DEST_SETTINGS_FISHING_COLOR_TITLE", "Textfarbe des Titels")
  Add("DEST_SETTINGS_FISHING_COLOR_TITLE_TT", "Beeinflusst die Textfarbe des Titels von Angeln Errungenschaften")
  Add("DEST_SETTINGS_FISHING_PIN_COLOR", "Symbolfarbe (unvollständig)")
  Add("DEST_SETTINGS_FISHING_PIN_COLOR_TT", "Beeinflusst die Symbolfarbe von Angeln Errungenschaften")
  Add("DEST_SETTINGS_FISHING_COLOR_UNDONE", "Textfarbe fehlender Fisch")
  Add("DEST_SETTINGS_FISHING_COLOR_UNDONE_TT", "Beeinflusst die Textfarbe von fehlenden Fischen")
  Add("DEST_SETTINGS_FISHING_COLOR_BAIT_UNDONE", "Textfarbe Köder")
  Add("DEST_SETTINGS_FISHING_COLOR_BAIT_UNDONE_TT", "Beeinflusst die Textfarbe von Ködern, sofern aktiviert")
  Add("DEST_SETTINGS_FISHING_COLOR_WATER_UNDONE", "Textfarbe Gewässer")
  Add("DEST_SETTINGS_FISHING_COLOR_WATER_UNDONE_TT", "Beeinflusst die Textfarbe von Gewässer, sofern aktiviert")
  Add("DEST_SETTINGS_FISHING_PIN_COLOR_DONE", "Symbolfarbe (vollständig)")
  Add("DEST_SETTINGS_FISHING_PIN_COLOR_DONE_TT", "Beeinflusst die Symbolfarbe von Angeln Errungenschaften")
  Add("DEST_SETTINGS_FISHING_COLOR_DONE", "Textfarbe (vollständig)")
  Add("DEST_SETTINGS_FISHING_COLOR_DONE_TT", "Beeinflusst die Textfarbe von einer vollständigen Errungenschaft")
  Add("DEST_SETTINGS_FISHING_COLOR_BAIT_DONE", "Textfarbe (vollständig) für Köder")
  Add("DEST_SETTINGS_FISHING_COLOR_BAIT_DONE_TT", "Beeinflusst die Textfarbe von einer vollständigen Errungenschaft")
  Add("DEST_SETTINGS_FISHING_COLOR_WATER_DONE", "Textfarbe (vollständig) für Gewässer")
  Add("DEST_SETTINGS_FISHING_COLOR_WATER_DONE_TT", "Beeinflusst die Textfarbe von einer vollständigen Errungenschaft")

  Add("DEST_SETTINGS_MAPFILTERS_HEADER", "Weltkarte Filter")
  Add("DEST_SETTINGS_MAPFILTERS_HEADER_TT", "Dieses Untermenü handhabt alle Weltkarten Filter Einstellungen.")
  Add("DEST_SETTINGS_MAPFILTERS_SUBHEADER", "Einstellungen")

  Add("DEST_SETTINGS_MAPFILTERS_POIS_TOGGLE", "Sehenswürdigkeiten Filter auf Weltkarte")
  Add("DEST_SETTINGS_MAPFILTERS_POIS_TOGGLE_TT",
    "Zeige (Ein) / Verberge (Aus) die Weltkartenfilter für alle Sehenswürdigkeiten.")
  Add("DEST_SETTINGS_MAPFILTERS_ACHS_TOGGLE", "Errungenschaften Filter auf Weltkarte")
  Add("DEST_SETTINGS_MAPFILTERS_ACHS_TOGGLE_TT",
    "Zeige (Ein) / Verberge (Aus) die Weltkartenfilter für alle Errungenschaften.")
  Add("DEST_SETTINGS_MAPFILTERS_QUES_TOGGLE", "Questgeber Filter auf Weltkarte")
  Add("DEST_SETTINGS_MAPFILTERS_QUES_TOGGLE_TT",
    "Zeige (Ein) / Verberge (Aus) die Weltkartenfilter für alle Questgeber.")
  Add("DEST_SETTINGS_MAPFILTERS_COLS_TOGGLE", "Sammlungen Filter auf Weltkarte")
  Add("DEST_SETTINGS_MAPFILTERS_COLS_TOGGLE_TT",
    "Zeige (Ein) / Verberge (Aus) die Weltkartenfilter für alle Sammlungen.")
  Add("DEST_SETTINGS_MAPFILTERS_FISS_TOGGLE", "Angeln Filter auf Weltkarte")
  Add("DEST_SETTINGS_MAPFILTERS_FISS_TOGGLE_TT",
    "Zeige (Ein) / Verberge (Aus) die Weltkartenfilter für alle Fischgründe.")
  Add("DEST_SETTINGS_MAPFILTERS_MISS_TOGGLE", "Diverses Filter auf Weltkarte")
  Add("DEST_SETTINGS_MAPFILTERS_MISS_TOGGLE_TT",
    "Zeige (Ein) / Verberge (Aus) die Weltkartenfilter für alles Diverses (Ayleïden Brunnen, Dwemerruinen, Kargstein Grenze, Werwölfe und Vampire).")

  Add("GLOBAL_SETTINGS_SELECT_TEXT_ONLY", "Nur Text!")

  Add("DEST_SETTINGS_RESET", "Standardeinstellungen herstellen")

  --POI Types
  Add("POITYPE_AOI", "Sehenswürdigkeit")
  Add("POITYPE_HOUSING", "Haus")
  Add("POITYPE_CRAFTING", "Handwerksstation")
  Add("POITYPE_DELVE", "Gewölbe")
  Add("POITYPE_DOLMEN", "Dolmen")
  Add("POITYPE_GATE", "Tor")
  Add("POITYPE_GROUPBOSS", "Gruppenboss")
  Add("POITYPE_GROUPDELVE", "Gruppengewölbe")
  Add("POITYPE_GROUPDUNGEON", "Gruppenverlies")
  Add("POITYPE_GROUPEVENT", "Gruppenveranstaltung")
  Add("POITYPE_MUNDUS", "Mundusstein")
  Add("POITYPE_PUBLICDUNGEON", "Öffentliches Verlies")
  Add("POITYPE_QUESTHUB", "Quest Hub")
  Add("POITYPE_SOLOTRIAL", "Prüfung")
  Add("POITYPE_TRADER", "Gildenhändler")
  Add("POITYPE_TRIALINSTANCE", "Prüfungsinstanz")
  Add("POITYPE_UNKNOWN", "unbekannt")
  Add("POITYPE_WAYSHRINE", "Wegschrein")
  Add("POITYPE_VAULT", "Trophäenkammer")
  Add("POITYPE_DARK_BROTHERHOOD", "Dunkle Bruderschaft")
  Add("POITYPE_BREAKING_ENTERING", "Einbruch")
  Add("POITYPE_CUTPURSE_ABOVE", "Leert die Ladung")

  Add("POITYPE_MAIQ", zo_strformat(GetAchievementInfo(872)))
  Add("POITYPE_LB_GTTP_CP",
    zo_strformat(GetAchievementInfo(873)) .. "/" .. zo_strformat(GetAchievementInfo(871)) .. "/" .. zo_strformat(GetAchievementInfo(869)))
  Add("POITYPE_PEACEMAKER", zo_strformat(GetAchievementInfo(716)))
  Add("POITYPE_CRIME_PAYS", zo_strformat(GetAchievementInfo(869)))
  Add("POITYPE_GIVE_TO_THE_POOR", zo_strformat(GetAchievementInfo(871)))
  Add("POITYPE_LIGHTBRINGER", zo_strformat(GetAchievementInfo(873)))
  Add("POITYPE_NOSEDIVER", zo_strformat(GetAchievementInfo(406)))
  Add("POITYPE_EARTHLYPOS", zo_strformat(GetAchievementInfo(1121)))
  Add("POITYPE_ON_ME", zo_strformat(GetAchievementInfo(704)))
  Add("POITYPE_BRAWL", zo_strformat(GetAchievementInfo(1247)))
  Add("POITYPE_RELICHUNTER", zo_strformat(GetAchievementInfo(1250)))
  Add("POITYPE_PATRON", zo_strformat(GetAchievementInfo(1316)))
  Add("POITYPE_WROTHGAR_JUMPER", zo_strformat(GetAchievementInfo(1331)))
  Add("POITYPE_BREAKING_ENTERING", zo_strformat(GetAchievementInfo(1349)))
  Add("POITYPE_CUTPURSE_ABOVE", zo_strformat(GetAchievementInfo(1383)))

  Add("POITYPE_AYLEID_WELL", "Ayleïden Brunnen")
  Add("POITYPE_WWVAMP", "Werwölfe/Vampire")
  Add("POITYPE_VAMPIRE_ALTAR", "Vampir Altar")
  Add("POITYPE_DWEMER_RUIN", "Dwemerruinen")
  Add("POITYPE_WEREWOLF_SHRINE", "Werwolf Schrein")

  Add("POITYPE_COLLECTIBLE", "Sammlungen")
  Add("POITYPE_FISH", "Angeln")
  Add("POITYPE_UNDETERMINED", "Unbestimmt")

  -- Quest completion editing texts
  Add("QUEST_EDIT_ON", "Destinations Questgeber Bearbeitung ist EINGESCHALTEN!")
  Add("QUEST_EDIT_OFF", "Destinations Questgeber Bearbeitung ist AUSGESCHALTEN!")
  Add("QUEST_MENU_NOT_FOUND", "Die Quest konnte nicht in der Datenbank gefunden werden")
  Add("QUEST_MENU_HIDE_QUEST", "Verstecke diese Quest")
  Add("QUEST_MENU_DISABLE_EDIT", "Bearbeitung ausschalten")

  -- Quest types
  Add("QUESTTYPE_NONE", "Quest")
  Add("QUESTTYPE_GROUP", "Gruppenquest")
  Add("QUESTTYPE_MAIN_STORY", "Hauptgeschichte Quest")
  Add("QUESTTYPE_GUILD", "Gilden Quest")
  Add("QUESTTYPE_CRAFTING", "Handwerks Quest")
  Add("QUESTTYPE_DUNGEON", "Verlies Quest")
  Add("QUESTTYPE_RAID", "Prüfungs Quest")
  Add("QUESTTYPE_AVA", "Allianzkrieg Quest")
  Add("QUESTTYPE_CLASS", "Klassen Quest")
  Add("QUESTTYPE_QA_TEST", "Q&A Test Quest")
  Add("QUESTTYPE_AVA_GROUP", "Allianzkrieg Gruppen Quest")
  Add("QUESTTYPE_AVA_GRAND", "Allianzkrieg Quest")
  Add("QUESTREPEAT_NOT_REPEATABLE", "Normale Quest")
  Add("QUESTREPEAT_REPEATABLE", "Wiederholbare Quest")
  Add("QUESTREPEAT_DAILY", "Dailie Quest")

  -- Fishing
  Add("FISHING_FOUL", "Tümpel")
  Add("FISHING_RIVER", "Fluss")
  Add("FISHING_OCEAN", "Meer")
  Add("FISHING_LAKE", "See")
  Add("FISHING_UNKNOWN", "- unbekannt -")
  Add("FISHING_FOUL_BAIT", "Krabbler/Fischrogen")
  Add("FISHING_RIVER_BAIT", "Insektenstücke/Maifische")
  Add("FISHING_OCEAN_BAIT", "Würmer/Döbel")
  Add("FISHING_LAKE_BAIT", "Innereien/Meeresfische")
  Add("FISHING_HWBC", "Krabbenknackschlächter^m")

  -- Destinations chat commands
  Add("DESTCOMMANDS", "Destinations Liste mit Befehlen:")
  Add("DESTCOMMANDdhlp", "/dhlp (Destinations Hilfe) : Du hast sie gerade benutzt ;)")
  Add("DESTCOMMANDdset", "/dset (Destinations Einstellungen) : Öffnet die Einstellungen.")
  Add("DESTCOMMANDdqed",
    "/dqed (Destinations Quests Editor) : Mit diesem Befehl kann man den Quest Editor aufrufen um die Pins zu bearbeiten. Im Chat wirst du entsprechend eine Nachricht erhalten ob dieser gerade aktiviert/deaktivert ist. Falls aktiviert, öffne die Weltkarte und klicke einen Pin an um ihn zu aktivieren/deaktivieren. Vergiss nicht den Modus wieder auszuschalten, wenn du ihn nicht mehr benötigst!")

  -- Destinations Misc
  Add("LOAD_NEW_QUEST_FORMAT", "Questdaten zurücksetzen")
  Add("LOAD_NEW_QUEST_FORMAT_TT",
    "Das wird alle bekannten Quests in eine neue Tabelle speichern. Dabei macht das Spiel einen /reloadui um es abzuschliessen.")
  Add("RELOADUI_WARNING", "Wenn du diesen Knopf drückst, führt das Spiel einen /reloadui aus")
  Add("RELOADUI_INFO", "Erst nach einem \'ReloadUI\' werden diese Einstellungen übernommen.")
  Add("DEST_SETTINGS_RELOADUI", "ReloadUI")
  Add("DEST_SET_REQUIREMENT", "<<1>> Eigenschaften benötigt")
end
