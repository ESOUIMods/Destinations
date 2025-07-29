Destinations = Destinations or {}
Destinations.savedVarsInitialized = false
Destinations.name = "Destinations"
Destinations.author = "|c990000Snowman|r, |cFFFFFFDK|r, Ayantir, MasterLenman, |cFF9B15Sharlikran|r"
Destinations.version = "29.99"
Destinations.website = "http://www.esoui.com/downloads/info667-Destinations.html"
Destinations.SV = Destinations.SV or {}
Destinations.CSSV = Destinations.CSSV or {}
Destinations.AWSV = Destinations.AWSV or {}

DEST_COLOR_YELLOW = ZO_ColorDef:New("FFFF00") -- settingsTextAccountWide
DEST_COLOR_BROWN = ZO_ColorDef:New("A52A2A") -- settingsTextImprove
DEST_COLOR_DARKGREEN = ZO_ColorDef:New("006400") -- settingsTextUnknown
DEST_COLOR_SADDLEBROWN = ZO_ColorDef:New("8B4513") -- settingsTextEnglish
DEST_COLOR_GOLD = ZO_ColorDef:New("FFD700") -- settingsTextOnlyText
DEST_COLOR_CRIMSON = ZO_ColorDef:New("DC143C") -- settingsTextWarn
DEST_COLOR_ANTIQUEWHITE = ZO_ColorDef:New("FAEBD7") -- settingsTextEvenLine
DEST_COLOR_WHITE = ZO_ColorDef:New("FFFFFF") -- settingsTextOddLine
DEST_COLOR_GREEN = ZO_ColorDef:New("008000") -- settingsTextAchievements
DEST_COLOR_LIGHTSEAGREEN = ZO_ColorDef:New("20B2AA") -- settingsTextAchHeaders
DEST_COLOR_LIME = ZO_ColorDef:New("00FF00") -- settingsTextMiscellaneous
DEST_COLOR_LIMEGREEN = ZO_ColorDef:New("32CD32") -- settingsTextVWW
DEST_COLOR_PALEGREEN = ZO_ColorDef:New("98FB98") -- settingsTextCollectibles, mapFilterTextDone2
DEST_COLOR_GAINSBORO = ZO_ColorDef:New("DCDCDC") -- settingsTextFish
DEST_COLOR_LIGHTCYAN = ZO_ColorDef:New("E0FFFF") -- settingsTextInstructions
DEST_COLOR_RED = ZO_ColorDef:New("FF0000") -- settingsTextReloadWarning
DEST_COLOR_BURLYWOOD = ZO_ColorDef:New("DEB887") -- mapFilterTextUndone1
DEST_COLOR_PALEGOLDENROD = ZO_ColorDef:New("EEE8AA") -- mapFilterTextDone1
DEST_COLOR_LIGHTSALMON = ZO_ColorDef:New("FFA07A") -- mapFilterTextUndone2

DEST_PIN_TEXT_COLOR_OTHER = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_OTHER_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_MAIQ = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_MAIQ_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_PEACEMAKER = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_PEACEMAKER_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_NOSEDIVER = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_NOSEDIVER_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_EARTHLYPOS = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_EARTHLYPOS_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_ONME = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_ONME_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_BRAWL = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_BRAWL_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_PATRON = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_PATRON_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_WROTHGARJUMPER = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_WROTHGARJUMPER_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_RELICHUNTER = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_RELICHUNTER_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_BREAKING = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_BREAKING_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_CUTPURSE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_CUTPURSE_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_CHAMPION = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_CHAMPION_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_AYLEID = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_DEADLANDS = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_HIGHISLE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_DWEMER = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_WWVAMP = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_VAMPALTAR = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_WWSHRINE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_COLLECTIBLE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_COLLECTIBLE_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_FISH = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_FISH_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_QOLPIN = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_ENGLISH_POI = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLOR_ENGLISH_KEEP = ZO_ColorDef:New(1, 1, 1)

DEST_PIN_TEXT_COLORTITLE_COLLECTIBLE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLORTITLE_FISH = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLORTITLE_FISH_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLORBAIT_FISH = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLORBAIT_FISH_DONE = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLORWATER_FISH = ZO_ColorDef:New(1, 1, 1)
DEST_PIN_TEXT_COLORWATER_FISH_DONE = ZO_ColorDef:New(1, 1, 1)

DEST_PIN_TINT_UNKNOWN = ZO_ColorDef:New(0.7, 0.7, 0.7, 0.6)
DEST_PIN_TINT_OTHER = ZO_ColorDef:New(1, 1, 1, 1)
DEST_PIN_TINT_OTHER_DONE = ZO_ColorDef:New(1, 1, 1, 1)

DEST_PIN_TINT_COLLECTIBLE = ZO_ColorDef:New(1, 1, 1, 1)
DEST_PIN_TINT_COLLECTIBLE_DONE = ZO_ColorDef:New(1, 1, 1, 1)
DEST_PIN_TINT_FISH = ZO_ColorDef:New(1, 1, 1, 1)
DEST_PIN_TINT_FISH_DONE = ZO_ColorDef:New(1, 1, 1, 1)
DEST_PIN_TINT_AYLEID = ZO_ColorDef:New(1, 1, 1, 1)
DEST_PIN_TINT_DEADLANDS = ZO_ColorDef:New(1, 1, 1, 1)
DEST_PIN_TINT_HIGHISLE = ZO_ColorDef:New(1, 1, 1, 1)
DEST_PIN_TINT_DWEMER = ZO_ColorDef:New(1, 1, 1, 1)
DEST_PIN_TINT_WWVAMP = ZO_ColorDef:New(1, 1, 1, 1)
DEST_PIN_TINT_VAMPALTAR = ZO_ColorDef:New(1, 1, 1, 1)
DEST_PIN_TINT_WWSHRINE = ZO_ColorDef:New(1, 1, 1, 1)
DEST_PIN_TINT_QOLPIN = ZO_ColorDef:New(1, 1, 1, 1)

local DPINS = {

  -- This filter cannot be disabled. They are fake pins for displaying tooltips on Seen / Complete POI
  FAKEKNOWN = "DEST_PinSet_FakeKnown",

  UNKNOWN = "DEST_PinSet_Unknown",

  LB_GTTP_CP = "DEST_PinSet_Other",
  MAIQ = "DEST_PinSet_Maiq",
  PEACEMAKER = "DEST_PinSet_Peacemaker",
  NOSEDIVER = "DEST_PinSet_Nosediver",
  EARTHLYPOS = "DEST_PinSet_Earthly_Possessions",
  ON_ME = "DEST_PinSet_This_Ones_On_Me",
  BRAWL = "DEST_PinSet_Last_Brawl",
  PATRON = "DEST_PinSet_Patron",
  WROTHGAR_JUMPER = "DEST_PinSet_Wrothgar_Jumper",
  RELIC_HUNTER = "DEST_PinSet_Wrothgar_Relic_Hunter",
  BREAKING = "DEST_PinSet_Breaking_Entering",
  CUTPURSE = "DEST_PinSet_Cutpurse_Above",
  CHAMPION = "DEST_PinSet_Champion",

  LB_GTTP_CP_DONE = "DEST_PinSet_Other_Done",
  MAIQ_DONE = "DEST_PinSet_Maiq_Done",
  PEACEMAKER_DONE = "DEST_PinSet_Peacemaker_Done",
  NOSEDIVER_DONE = "DEST_PinSet_Nosediver_Done",
  EARTHLYPOS_DONE = "DEST_PinSet_Earthly_Possessions_Done",
  ON_ME_DONE = "DEST_PinSet_This_Ones_On_Me_Done",
  BRAWL_DONE = "DEST_PinSet_Last_Brawl_Done",
  PATRON_DONE = "DEST_PinSet_Patron_Done",
  WROTHGAR_JUMPER_DONE = "DEST_PinSet_Wrothgar_Jumper_Done",
  RELIC_HUNTER_DONE = "DEST_PinSet_Wrothgar_Relic_Hunter_Done",
  BREAKING_DONE = "DEST_PinSet_Breaking_Entering_Done",
  CUTPURSE_DONE = "DEST_PinSet_Cutpurse_Above_Done",
  CHAMPION_DONE = "DEST_PinSet_Champion_Done",

  ACHIEVEMENTS_COMPASS = "DEST_Compass_Achievements",

  AYLEID = "DEST_PinSet_Ayleid",
  DWEMER = "DEST_PinSet_Dwemer",
  DEADLANDS = "DEST_PinSet_Deadlands",
  HIGHISLE = "DEST_PinSet_HighIsle",
  MISC_COMPASS = "DEST_Compass_Misc",

  QOLPINS_DOCK = "DEST_Qol_Dock",
  QOLPINS_STABLE = "DEST_Qol_Stable",
  QOLPINS_PORTAL = "DEST_Qol_Portal",

  WWVAMP = "DEST_PinSet_WWVamp",
  VAMPIRE_ALTAR = "DEST_PinSet_Vampire_Alter",
  WEREWOLF_SHRINE = "DEST_PinSet_Werewolf_Shrine",
  VWW_COMPASS = "DEST_Compass_WWVamp",

  COLLECTIBLES = "DEST_Pin_Collectibles",
  COLLECTIBLES_COMPASS = "DEST_Compass_Collectibles",
  COLLECTIBLESDONE = "DEST_Pin_Collectibles_Done",
  COLLECTIBLES_SHOW_ITEM = "DEST_Compass_Collectibles_Show_Item",
  COLLECTIBLES_SHOW_MOBNAME = "DEST_Compass_Collectibles_Show_MobName",

  FISHING = "DEST_Pin_Fishing",
  FISHING_COMPASS = "DEST_Compass_Fishing",
  FISHINGDONE = "DEST_Pin_Fishing_Done",
  FISHING_SHOW_BAIT = "DEST_Compass_Fishing_Show_Bait",
  FISHING_SHOW_BAIT_LEFT = "DEST_Compass_Fishing_Show_Bait_Left",
  FISHING_SHOW_WATER = "DEST_Compass_Fishing_Show_Water",
  FISHING_SHOW_FISHNAME = "DEST_Compass_Fishing_Show_FishName",
}
Destinations.PIN_TYPES = DPINS

local defaults = {
  pins = {
    pinTextureUnknown = {
      type = 7,
      size = 42,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 0.7, 0.7, 0.7, 0.6 },
      textcolor = { 1, 1, 1 },
      textcolorEN = { 1, 1, 1 },
      textcolorTrader = { 1, 1, 1 },
    },
    pinTextureUnknownOthers = {
      tint = { 1, 1, 1, 1 },
    },
    pinTextureOther = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureOtherDone = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureMaiq = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureMaiqDone = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTexturePeacemaker = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTexturePeacemakerDone = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureNosediver = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureNosediverDone = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureEarthlyPos = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureEarthlyPosDone = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureOnMe = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureOnMeDone = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureBrawl = {
      type = 5,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureBrawlDone = {
      type = 5,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTexturePatron = {
      type = 5,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTexturePatronDone = {
      type = 5,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureWrothgarJumper = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureWrothgarJumperDone = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureRelicHunter = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureRelicHunterDone = {
      type = 6,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureChampion = {
      type = 1,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureChampionDone = {
      type = 1,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureBreaking = {
      type = 5,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureBreakingDone = {
      type = 5,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureCutpurse = {
      type = 5,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureCutpurseDone = {
      type = 5,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureAyleid = {
      type = 5,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureDeadlands = {
      type = 1,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureHighIsle = {
      type = 1,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureDwemer = {
      type = 7,
      size = 26,
      level = 145,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureWWVamp = {
      type = 5,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureWWShrine = {
      type = 5,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureVampAltar = {
      type = 5,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureCollectible = {
      type = 2,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
      textcolortitle = { 1, 1, 1 },
    },
    pinTextureQolPin = {
      type = 1,
      size = 35,
      level = 45,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
      textcolortitle = { 1, 1, 1 },
    },
    pinTextureCollectibleDone = {
      type = 2,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
      textcolortitle = { 1, 1, 1 },
    },
    pinTextureFish = {
      type = 1,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
      textcolortitle = { 1, 1, 1 },
      textcolorBait = { 1, 1, 1 },
      textcolorWater = { 1, 1, 1 },
    },
    pinTextureFishDone = {
      type = 1,
      size = 26,
      level = 30,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
      textcolortitle = { 1, 1, 1 },
      textcolorBait = { 1, 1, 1 },
      textcolorWater = { 1, 1, 1 },
    },
  },
  miscColorCodes = {
    settingsTextAccountWide = DEST_COLOR_YELLOW,
    settingsTextImprove = DEST_COLOR_BROWN,
    settingsTextUnknown = DEST_COLOR_DARKGREEN,
    settingsTextEnglish = DEST_COLOR_SADDLEBROWN,
    settingsTextOnlyText = DEST_COLOR_GOLD,
    settingsTextWarn = DEST_COLOR_CRIMSON,
    settingsTextEvenLine = DEST_COLOR_ANTIQUEWHITE,
    settingsTextOddLine = DEST_COLOR_WHITE,
    settingsTextAchievements = DEST_COLOR_GREEN,
    settingsTextAchHeaders = DEST_COLOR_LIGHTSEAGREEN,
    settingsTextMiscellaneous = DEST_COLOR_LIME,
    settingsTextVWW = DEST_COLOR_LIMEGREEN,
    settingsTextCollectibles = DEST_COLOR_PALEGREEN,
    settingsTextFish = DEST_COLOR_GAINSBORO,
    settingsTextInstructions = DEST_COLOR_LIGHTCYAN,
    settingsTextReloadWarning = DEST_COLOR_RED,
    mapFilterTextUndone1 = DEST_COLOR_BURLYWOOD,
    mapFilterTextDone1 = DEST_COLOR_PALEGOLDENROD,
    mapFilterTextUndone2 = DEST_COLOR_LIGHTSALMON,
    mapFilterTextDone2 = DEST_COLOR_PALEGREEN,
  },
  settings = {
    useAccountWide = true,
    activateReloaduiButton = false,
    ShowDungeonBossesInZones = true,
    ShowDungeonBossesOnTop = false,
    ShowCadwellsAlmanac = false,
    ShowCadwellsAlmanacOnly = false,
    MapFiltersPOIs = true,
    MapFiltersAchievements = true,
    MapFiltersCollectibles = true,
    MapFiltersFishing = true,
    MapFiltersMisc = true,
    AddEnglishOnUnknwon = true,
    AddEnglishOnKeeps = true,
    AddNewLineOnKeeps = true,
    HideAllianceOnKeeps = false,
    ImproveCrafting = true,
    ImproveMundus = true,
    EnglishColorKeeps = STAT_BATTLE_LEVEL_COLOR:ToHex(),
    EnglishColorPOI = ZO_HIGHLIGHT_TEXT:ToHex(),
  },
  filters = {
    [Destinations.PIN_TYPES.UNKNOWN] = true,

    [Destinations.PIN_TYPES.LB_GTTP_CP] = false,
    [Destinations.PIN_TYPES.MAIQ] = false,
    [Destinations.PIN_TYPES.PEACEMAKER] = false,
    [Destinations.PIN_TYPES.NOSEDIVER] = false,
    [Destinations.PIN_TYPES.EARTHLYPOS] = false,
    [Destinations.PIN_TYPES.ON_ME] = false,
    [Destinations.PIN_TYPES.BRAWL] = false,
    [Destinations.PIN_TYPES.PATRON] = false,
    [Destinations.PIN_TYPES.WROTHGAR_JUMPER] = false,
    [Destinations.PIN_TYPES.RELIC_HUNTER] = false,
    [Destinations.PIN_TYPES.BREAKING] = false,
    [Destinations.PIN_TYPES.CUTPURSE] = false,

    [Destinations.PIN_TYPES.CHAMPION] = false,

    [Destinations.PIN_TYPES.LB_GTTP_CP_DONE] = false,
    [Destinations.PIN_TYPES.MAIQ_DONE] = false,
    [Destinations.PIN_TYPES.PEACEMAKER_DONE] = false,
    [Destinations.PIN_TYPES.NOSEDIVER_DONE] = false,
    [Destinations.PIN_TYPES.EARTHLYPOS_DONE] = false,
    [Destinations.PIN_TYPES.ON_ME_DONE] = false,
    [Destinations.PIN_TYPES.BRAWL_DONE] = false,
    [Destinations.PIN_TYPES.PATRON_DONE] = false,
    [Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE] = false,
    [Destinations.PIN_TYPES.RELIC_HUNTER_DONE] = false,
    [Destinations.PIN_TYPES.BREAKING_DONE] = false,
    [Destinations.PIN_TYPES.CUTPURSE_DONE] = false,

    [Destinations.PIN_TYPES.CHAMPION_DONE] = false,

    [Destinations.PIN_TYPES.ACHIEVEMENTS_COMPASS] = true,

    [Destinations.PIN_TYPES.AYLEID] = false,
    [Destinations.PIN_TYPES.DWEMER] = false,
    [Destinations.PIN_TYPES.DEADLANDS] = false,
    [Destinations.PIN_TYPES.HIGHISLE] = false,
    [Destinations.PIN_TYPES.MISC_COMPASS] = true,

    [Destinations.PIN_TYPES.WWVAMP] = false,
    [Destinations.PIN_TYPES.VAMPIRE_ALTAR] = false,
    [Destinations.PIN_TYPES.WEREWOLF_SHRINE] = false,
    [Destinations.PIN_TYPES.VWW_COMPASS] = true,

    [Destinations.PIN_TYPES.COLLECTIBLES] = false,
    [Destinations.PIN_TYPES.COLLECTIBLESDONE] = false,
    [Destinations.PIN_TYPES.COLLECTIBLES_SHOW_ITEM] = false,
    [Destinations.PIN_TYPES.COLLECTIBLES_SHOW_MOBNAME] = false,
    [Destinations.PIN_TYPES.COLLECTIBLES_COMPASS] = false,

    [Destinations.PIN_TYPES.FISHING] = false,
    [Destinations.PIN_TYPES.FISHINGDONE] = false,
    [Destinations.PIN_TYPES.FISHING_SHOW_BAIT] = false,
    [Destinations.PIN_TYPES.FISHING_SHOW_BAIT_LEFT] = false,
    [Destinations.PIN_TYPES.FISHING_SHOW_WATER] = false,
    [Destinations.PIN_TYPES.FISHING_SHOW_FISHNAME] = false,
    [Destinations.PIN_TYPES.FISHING_COMPASS] = false,
  },
  data = {
    FoulBaitLeft = 0,
    FoulSBaitLeft = 0,
    RiverBaitLeft = 0,
    RiverSBaitLeft = 0,
    OceanBaitLeft = 0,
    OceanSBaitLeft = 0,
    LakeBaitLeft = 0,
    LakeSBaitLeft = 0,
    GeneralBait = 0,
  },
  TEMPPINDATA = {},
}
Destinations.defaults = defaults

local pinTextures = {
  paths = {
    Unknown = {
      [1] = "Destinations/pins/A_Global_Asghaard-croix_black.dds",
      [2] = "Destinations/pins/A_Global_Asghaard-aura.dds",
      [3] = "/esoui/art/icons/poi/poi_wayshrine_incomplete.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/X-Red.dds",
      [6] = "Destinations/pins/old/exclaimYellow.dds",
      [7] = "/esoui/art/icons/poi/poi_areaofinterest_incomplete.dds",
    },
    Other = {
      [1] = "Destinations/pins/Achievement_Other_robber_mask.dds",
      [2] = "Destinations/pins/Achievement_Other_vendetta.dds",
      [3] = "Destinations/pins/Achievement_Other_robber.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_Other_colored.dds",
      [6] = "Destinations/pins/old/Achievement_Other_colored_Red.dds",
    },
    OtherDone = {
      [1] = "Destinations/pins/Achievement_Other_robber_mask.dds",
      [2] = "Destinations/pins/Achievement_Other_vendetta.dds",
      [3] = "Destinations/pins/Achievement_Other_robber.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_Other_colored-complete.dds",
      [6] = "Destinations/pins/old/Achievement_Other_colored-complete.dds",
    },
    Maiq = {
      [1] = "Destinations/pins/Achievement_Maiq_Maiq.dds",
      [2] = "Destinations/pins/Achievement_Maiq_Hood.dds",
      [3] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_Maiq_colored.dds",
      [6] = "Destinations/pins/old/Achievement_Maiq_colored_Red.dds",
    },
    MaiqDone = {
      [1] = "Destinations/pins/Achievement_Maiq_Maiq.dds",
      [2] = "Destinations/pins/Achievement_Maiq_Hood.dds",
      [3] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_Maiq_colored-complete.dds",
      [6] = "Destinations/pins/old/Achievement_Maiq_colored-complete.dds",
    },
    Peacemaker = {
      [1] = "Destinations/pins/Achievement_Peacemaker_Dove.dds",
      [2] = "Destinations/pins/Achievement_Peacemaker_Peacesign.dds",
      [3] = "Destinations/pins/Achievement_Peacemaker_Peacelogo.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_Peacemaker_colored.dds",
      [6] = "Destinations/pins/old/Achievement_Peacemaker_colored_Red.dds",
    },
    PeacemakerDone = {
      [1] = "Destinations/pins/Achievement_Peacemaker_Dove.dds",
      [2] = "Destinations/pins/Achievement_Peacemaker_Peacesign.dds",
      [3] = "Destinations/pins/Achievement_Peacemaker_Peacelogo.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_Peacemaker_colored-complete.dds",
      [6] = "Destinations/pins/old/Achievement_Peacemaker_colored-complete.dds",
    },
    Nosediver = {
      [1] = "Destinations/pins/Achievement_Nosediver_Nose_1.dds",
      [2] = "Destinations/pins/Achievement_Nosediver_Nose_2.dds",
      [3] = "Destinations/pins/Achievement_Nosediver_Diver.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_Nosediver_colored.dds",
      [6] = "Destinations/pins/old/Achievement_Nosediver_colored_Red.dds",
    },
    NosediverDone = {
      [1] = "Destinations/pins/Achievement_Nosediver_Nose_1.dds",
      [2] = "Destinations/pins/Achievement_Nosediver_Nose_2.dds",
      [3] = "Destinations/pins/Achievement_Nosediver_Diver.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_Nosediver_colored-complete.dds",
      [6] = "Destinations/pins/old/Achievement_Nosediver_colored-complete.dds",
    },
    Earthlypos = {
      [1] = "Destinations/pins/Achievement_EarthlyPossessions_Pouch.dds",
      [2] = "Destinations/pins/Achievement_EarthlyPossessions_Gold.dds",
      [3] = "Destinations/pins/Achievement_EarthlyPossessions_Chest.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_EarthlyPossessions_Gold.dds",
      [6] = "Destinations/pins/old/Achievement_EarthlyPossessions_Gold_Red.dds",
    },
    EarthlyposDone = {
      [1] = "Destinations/pins/Achievement_EarthlyPossessions_Pouch.dds",
      [2] = "Destinations/pins/Achievement_EarthlyPossessions_Gold.dds",
      [3] = "Destinations/pins/Achievement_EarthlyPossessions_Chest.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_EarthlyPossessions_Gold-complete.dds",
      [6] = "Destinations/pins/old/Achievement_EarthlyPossessions_Gold-complete.dds",
    },
    OnMe = {
      [1] = "Destinations/pins/Achievement_ThisOnesOnMe_Coctail_1.dds",
      [2] = "Destinations/pins/Achievement_ThisOnesOnMe_Coctail_2.dds",
      [3] = "Destinations/pins/Achievement_ThisOnesOnMe_Wine.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_ThisOnesOnMe_colored.dds",
      [6] = "Destinations/pins/old/Achievement_ThisOnesOnMe_colored_Red.dds",
    },
    OnMeDone = {
      [1] = "Destinations/pins/Achievement_ThisOnesOnMe_Coctail_1.dds",
      [2] = "Destinations/pins/Achievement_ThisOnesOnMe_Coctail_2.dds",
      [3] = "Destinations/pins/Achievement_ThisOnesOnMe_Wine.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_ThisOnesOnMe_colored-complete.dds",
      [6] = "Destinations/pins/old/Achievement_ThisOnesOnMe_colored-complete.dds",
    },
    Brawl = {
      [1] = "Destinations/pins/Achievement_Brawl_Brawl.dds",
      [2] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [3] = "Destinations/pins/A_Global_X.dds",
      [4] = "Destinations/pins/old/Achievement_Brawl_colored.dds",
      [5] = "Destinations/pins/old/Achievement_Brawl_colored_Red.dds",
    },
    BrawlDone = {
      [1] = "Destinations/pins/Achievement_Brawl_Brawl.dds",
      [2] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [3] = "Destinations/pins/A_Global_X.dds",
      [4] = "Destinations/pins/old/Achievement_Brawl_colored-complete.dds",
      [5] = "Destinations/pins/old/Achievement_Brawl_colored-complete.dds",
    },
    Patron = {
      [1] = "Destinations/pins/Achievement_Patron_Patron.dds",
      [2] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [3] = "Destinations/pins/A_Global_X.dds",
      [4] = "Destinations/pins/old/Achievement_Patron_colored.dds",
      [5] = "Destinations/pins/old/Achievement_Patron_colored_Red.dds",
    },
    PatronDone = {
      [1] = "Destinations/pins/Achievement_Patron_Patron.dds",
      [2] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [3] = "Destinations/pins/A_Global_X.dds",
      [4] = "Destinations/pins/old/Achievement_Patron_colored-complete.dds",
      [5] = "Destinations/pins/old/Achievement_Patron_colored-complete.dds",
    },
    WrothgarJumper = {
      [1] = "Destinations/pins/Achievement_WrothgarCliffJumper.dds",
      [2] = "Destinations/pins/Achievement_WrothgarCliffJumper_Inverted.dds",
      [3] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_WrothgarCliffJumper_colored.dds",
      [6] = "Destinations/pins/old/Achievement_WrothgarCliffJumper_colored_Red.dds",
    },
    WrothgarJumperDone = {
      [1] = "Destinations/pins/Achievement_WrothgarCliffJumper.dds",
      [2] = "Destinations/pins/Achievement_WrothgarCliffJumper_Inverted.dds",
      [3] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_WrothgarCliffJumper_colored-complete.dds",
      [6] = "Destinations/pins/old/Achievement_WrothgarCliffJumper_colored-complete.dds",
    },
    RelicHunter = {
      [1] = "Destinations/pins/Achievement_RelicHunter.dds",
      [2] = "Destinations/pins/Achievement_RelicHunter_Inverted.dds",
      [3] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_RelicHunter_colored.dds",
      [6] = "Destinations/pins/old/Achievement_RelicHunter_colored_Red.dds",
    },
    RelicHunterDone = {
      [1] = "Destinations/pins/Achievement_RelicHunter.dds",
      [2] = "Destinations/pins/Achievement_RelicHunter_Inverted.dds",
      [3] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Achievement_RelicHunter_colored-complete.dds",
      [6] = "Destinations/pins/old/Achievement_RelicHunter_colored-complete.dds",
    },
    Champion = {
      [1] = "Destinations/pins/Achievement_Champ.dds",
      [2] = "Destinations/pins/Achievement_Champ_Red.dds",
      [3] = "Destinations/pins/Dwemer_Helmet.dds",
      [4] = "Destinations/pins/A_Global_Asghaard-aura.dds",
      [5] = "Destinations/pins/old/Achievement_Champ_colored.dds",
      [6] = "Destinations/pins/old/Achievement_Champ_colored_Red.dds",
      [7] = "/esoui/art/icons/poi/poi_groupboss_incomplete.dds",
    },
    ChampionDone = {
      [1] = "Destinations/pins/Achievement_Champ.dds",
      [2] = "Destinations/pins/Achievement_Champ_Green.dds",
      [3] = "Destinations/pins/Dwemer_Helmet.dds",
      [4] = "Destinations/pins/A_Global_Asghaard-aura.dds",
      [5] = "Destinations/pins/old/Achievement_Champ_colored-complete.dds",
      [6] = "Destinations/pins/old/Achievement_Champ_colored-complete.dds",
      [7] = "/esoui/art/icons/poi/poi_groupboss_complete.dds",
    },
    Breaking = {
      [1] = "Destinations/pins/Achievement_Breaking_Padlock_Black.dds",
      [2] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [3] = "Destinations/pins/A_Global_X.dds",
      [4] = "Destinations/pins/old/Achievement_Breaking_colored.dds",
      [5] = "Destinations/pins/old/Achievement_Breaking_colored_Red.dds",
    },
    BreakingDone = {
      [1] = "Destinations/pins/Achievement_Breaking_Padlock_White.dds",
      [2] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [3] = "Destinations/pins/A_Global_X.dds",
      [4] = "Destinations/pins/old/Achievement_Breaking_colored-complete.dds",
      [5] = "Destinations/pins/old/Achievement_Breaking_colored-complete.dds",
    },
    Cutpurse = {
      [1] = "Destinations/pins/Achievement_Cutpurse_Cutpurse_Black.dds",
      [2] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [3] = "Destinations/pins/A_Global_X.dds",
      [4] = "Destinations/pins/old/Achievement_Cutpurse_colored.dds",
      [5] = "Destinations/pins/old/Achievement_Cutpurse_colored_Red.dds",
    },
    CutpurseDone = {
      [1] = "Destinations/pins/Achievement_Cutpurse_Cutpurse_White.dds",
      [2] = "Destinations/pins/A_Global_Asghaard-croix_white.dds",
      [3] = "Destinations/pins/A_Global_X.dds",
      [4] = "Destinations/pins/old/Achievement_Cutpurse_colored-complete.dds",
      [5] = "Destinations/pins/old/Achievement_Cutpurse_colored-complete.dds",
    },
    Ayleid = {
      [1] = "Destinations/pins/Ayleid_Well_1.dds",
      [2] = "Destinations/pins/Ayleid_Well_1_inverted.dds",
      [3] = "Destinations/pins/Ayleid_Well_2.dds",
      [4] = "Destinations/pins/A_Global_Asghaard-aura.dds",
      [5] = "Destinations/pins/old/Ayleid_Well_colored.dds",
      [6] = "Destinations/pins/old/Ayleid_Well_colored_Red.dds",
    },
    Deadlands = {
      [1] = "Destinations/pins/deadlands.dds",
    },
    HighIsle = {
      [1] = "/esoui/art/icons/passive_warden_005.dds",
    },
    dwemer = {
      [1] = "Destinations/pins/dummy.dds",
      [2] = "Destinations/pins/Dwemer_Helmet.dds",
      [3] = "Destinations/pins/Dwemer_Cog.dds",
      [4] = "Destinations/pins/A_Global_Asghaard-aura.dds",
      [5] = "Destinations/pins/old/Dwemer_Helm.dds",
      [6] = "Destinations/pins/old/Dwemer_Helm_Red_Circle.dds",
      [7] = "Destinations/pins/old/Dwemer_Spider_colored.dds",
      [8] = "Destinations/pins/old/Dwemer_Spider_Red_Circle.dds",
      [9] = "Destinations/pins/Collectible_Dwemer_Cog.dds",
    },
    wwvamp = {
      [1] = "Destinations/pins/VampWW_Werewolf.dds",
      [2] = "Destinations/pins/VampWW_Werewolf_inverted.dds",
      [3] = "Destinations/pins/VampWW_Vampire.dds",
      [4] = "Destinations/pins/VampWW_Vampire_inverted.dds",
      [5] = "Destinations/pins/old/VampWW_Werewolf.dds",
      [6] = "Destinations/pins/old/VampWW_Vampire.dds",
      [7] = "Destinations/pins/old/VampWW_Werewolf_Red.dds",
      [8] = "Destinations/pins/old/VampWW_Vampire_Red.dds",
    },
    vampirealtar = {
      [1] = "Destinations/pins/Vampire_Altar_VampireSkull.dds",
      [2] = "Destinations/pins/Vampire_Altar_1.dds",
      [3] = "Destinations/pins/Vampire_Altar_2.dds",
      [4] = "Destinations/pins/A_Global_Asghaard-aura.dds",
      [5] = "Destinations/pins/old/Vampire_Altar.dds",
      [6] = "Destinations/pins/old/Vampire_Altar_Red_Circle.dds",
    },
    werewolfshrine = {
      [1] = "Destinations/pins/Werewolf_Wolf.dds",
      [2] = "Destinations/pins/Werewolf_Shrine_1.dds",
      [3] = "Destinations/pins/Werewolf_Shrine_2.dds",
      [4] = "Destinations/pins/A_Global_Asghaard-aura.dds",
      [5] = "Destinations/pins/old/Werewolf_Shrine.dds",
      [6] = "Destinations/pins/old/Werewolf_Shrine_Red.dds",
    },
    collectible = {
      [1] = "Destinations/pins/Collectible_Skull.dds",
      [2] = "Destinations/pins/Collectible_Dwemer_Cog.dds",
      [3] = "Destinations/pins/Collectible_Mudcrab.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Collectible_Trophy.dds",
      [6] = "Destinations/pins/old/Collectible_colored.dds",
      [7] = "/esoui/art/treeicons/achievements_indexicon_summary_down.dds",
    },
    collectibledone = {
      [1] = "Destinations/pins/Collectible_Skull.dds",
      [2] = "Destinations/pins/Collectible_Dwemer_Cog.dds",
      [3] = "Destinations/pins/Collectible_Mudcrab.dds",
      [4] = "Destinations/pins/A_Global_X.dds",
      [5] = "Destinations/pins/old/Collectible_Trophy.dds",
      [6] = "Destinations/pins/old/Collectible_colored-complete.dds",
      [7] = "/esoui/art/treeicons/achievements_indexicon_summary_down.dds",
    },
    fish = {
      [1] = "Destinations/pins/Fish_1.dds",
      [2] = "Destinations/pins/Fish_2.dds",
      [3] = "Destinations/pins/Fish_3.dds",
      [4] = "Destinations/pins/Fish_4.dds",
      [5] = "Destinations/pins/old/Fish_colored.dds",
      [6] = "/esoui/art/treeicons/achievements_indexicon_fishing_down.dds",
    },
    fishdone = {
      [1] = "Destinations/pins/Fish_1.dds",
      [2] = "Destinations/pins/Fish_2.dds",
      [3] = "Destinations/pins/Fish_3.dds",
      [4] = "Destinations/pins/Fish_4.dds",
      [5] = "Destinations/pins/old/Fish_colored-complete.dds",
      [6] = "/esoui/art/treeicons/achievements_indexicon_fishing_down.dds",
    },
  },
  lists = {
    Unknown = {
      "Asghaard's Croix",
      "Asghaard's Aura",
      "Real Transparent",
      "X",
      "Old Red X",
      "Old Yellow Exclamation Mark",
      "Default",
    },
    Other = {
      "Robber Mask",
      "Vendetta Mask",
      "Robber",
      "X",
      "Old Colored Robber",
      "Old Red Circled Robber",
    },
    Maiq = {
      "M'aiq",
      "Hood",
      "Asghaard's Croix",
      "X",
      "Old Colored M'aiq",
      "Old Red Circled M'aiq",
    },
    Peacemaker = {
      "Dove",
      "Peace Sign",
      "Peace Logo",
      "X",
      "Old Colored Dove",
      "Old Red Circled Dove",
    },
    Nosediver = {
      "Nose 1",
      "Nose 2",
      "Diver",
      "X",
      "Old Colored Nose",
      "Old Red Circled Nose",
    },
    EarthlyPos = {
      "Pouch",
      "Gold",
      "Chest",
      "X",
      "Old Colored Gold",
      "Old Red Circled Gold",
    },
    OnMe = {
      "Cocktail 1",
      "Cocktail 2",
      "Wine",
      "X",
      "Old Colored Drink",
      "Old Red Circled Drink",
    },
    Brawl = {
      "Orc",
      "Asghaard's Croix",
      "X",
      "Old Colored Orc",
      "Old Red Circled Orc",
    },
    Patron = {
      "Patron",
      "Asghaard's Croix",
      "X",
      "Old Colored Patron",
      "Old Red Circled Patron",
    },
    WrothgarJumper = {
      "Cliff",
      "Cliff Inverted",
      "Asghaard's Croix",
      "X",
      "Old Colored Cliff",
      "Old Red Circled Cliff",
    },
    RelicHunter = {
      "Relic",
      "Relic Inverted",
      "Asghaard's Croix",
      "X",
      "Old Colored Relic",
      "Old Red Circled Relic",
    },
    Champion = {
      "Skull",
      "Pre-colored Skull",
      "Helmet",
      "Asghaard's Aura",
      "Old Colored Skull",
      "Old Red Circled Skull",
      "ESO Skull",
    },
    Breaking = {
      "Padlock",
      "Asghaard's Croix",
      "X",
      "Old Colored Padlock",
      "Old Red Circled Padlock",
    },
    Cutpurse = {
      "Cutpurse",
      "Asghaard's Croix",
      "X",
      "Old Colored Cutpurse",
      "Old Red Circled Cutpurse",
    },
    Ayleid = {
      "Well",
      "Well inverted",
      "Well 2",
      "Asghaard's Aura",
      "Old Colored Well",
      "Old Red Circled Well",
    },
    Deadlands = {
      "Entrance",
    },
    HighIsle = {
      "Druidic Shrine",
    },
    Dwemer = {
      Destinations.defaults.miscColorCodes.settingsTextOnlyText:Colorize(GetString(GLOBAL_SETTINGS_SELECT_TEXT_ONLY)),
      "Helmet",
      "Real Dwemer Cog",
      "Asghaard's Aura",
      "Old Colored Dwemer Helm",
      "Old Red Circled Dwemer Helm",
      "Old Colored Spider",
      "Old Red Circled Spider",
      "Dwemer Cog",
    },
    WWVamp = {
      "Werewolf",
      "Werewolf inverted",
      "Vampire",
      "Vampire inverted",
      "Old Colored Werewolf",
      "Old Colored Vampire",
      "Old Red Circled Werewolf",
      "Old Red Circled Vampire",
    },
    WWShrine = {
      "Werewolf",
      "Werewolf Shrine 1",
      "Werewolf Shrine 2",
      "Asghaard's Aura",
      "Old Colored Shrine",
      "Old Red Circled Shrine",
    },
    VampAltar = {
      "Vampire Skull",
      "Vampire Altar 1",
      "Vampire Altar 2",
      "Asghaard's Aura",
      "Old Colored Altar",
      "Old Red Circled Altar",
    },
    Collectible = {
      "Skull",
      "Dwemer Cog",
      "Mudcrab",
      "X",
      "Old Trophy",
      "Old Colored Trophy",
      "Real Scroll",
    },
    Fish = {
      "Fish 1",
      "Fish 1 inverted",
      "Fish 2",
      "Fish 2 inverted",
      "Old Colored Fish",
      "Real Fishing Hook",
    },
  },
}
Destinations.pinTextures = pinTextures

-- Define Runtime Variables
local drtv = {
  MapMiscPOIs = false,
  LastMapShown = "",
  pinName = nil,
  pinTag = nil,
  pinType = 99,
  pinTypeName = "",
  AchPins = {
    [1] = "MAIQ",
    [2] = "LB_GTTP_CP", -- Corresponds to pinTextureOther
    [3] = "PEACEMAKER",
    [4] = "NOSEDIVER",
    [5] = "EARTHLYPOS",
    [6] = "ON_ME",
    [7] = "BRAWL",
    [8] = "PATRON",
    [9] = "WROTHGAR_JUMPER",
    [10] = "CHAMPION",
    [11] = "RELIC_HUNTER",
    [12] = "BREAKING",
    [13] = "CUTPURSE",
  },
  AchPinTex = {
    [1] = "pinTextureMaiq",
    [2] = "pinTextureOther", -- LB_GTTP_CP (Lightbringer, etc.)
    [3] = "pinTexturePeacemaker",
    [4] = "pinTextureNosediver",
    [5] = "pinTextureEarthlyPos",
    [6] = "pinTextureOnMe",
    [7] = "pinTextureBrawl",
    [8] = "pinTexturePatron",
    [9] = "pinTextureWrothgarJumper",
    [10] = "pinTextureChampion",
    [11] = "pinTextureRelicHunter",
    [12] = "pinTextureBreaking",
    [13] = "pinTextureCutpurse",
  },
  AchTextColorDefs = {
    LB_GTTP_CP = DEST_PIN_TEXT_COLOR_OTHER,
    MAIQ = DEST_PIN_TEXT_COLOR_OTHER,
    PEACEMAKER = DEST_PIN_TEXT_COLOR_OTHER,
    NOSEDIVER = DEST_PIN_TEXT_COLOR_OTHER,
    EARTHLYPOS = DEST_PIN_TEXT_COLOR_OTHER,
    ON_ME = DEST_PIN_TEXT_COLOR_OTHER,
    BRAWL = DEST_PIN_TEXT_COLOR_OTHER,
    PATRON = DEST_PIN_TEXT_COLOR_OTHER,
    WROTHGAR_JUMPER = DEST_PIN_TEXT_COLOR_OTHER,
    RELIC_HUNTER = DEST_PIN_TEXT_COLOR_OTHER,
    BREAKING = DEST_PIN_TEXT_COLOR_OTHER,
    CUTPURSE = DEST_PIN_TEXT_COLOR_OTHER,
    CHAMPION = DEST_PIN_TEXT_COLOR_OTHER,
  },
  AchTextColorDefsDone = {
    LB_GTTP_CP = DEST_PIN_TEXT_COLOR_OTHER_DONE,
    MAIQ = DEST_PIN_TEXT_COLOR_OTHER_DONE,
    PEACEMAKER = DEST_PIN_TEXT_COLOR_OTHER_DONE,
    NOSEDIVER = DEST_PIN_TEXT_COLOR_OTHER_DONE,
    EARTHLYPOS = DEST_PIN_TEXT_COLOR_OTHER_DONE,
    ON_ME = DEST_PIN_TEXT_COLOR_OTHER_DONE,
    BRAWL = DEST_PIN_TEXT_COLOR_OTHER_DONE,
    PATRON = DEST_PIN_TEXT_COLOR_OTHER_DONE,
    WROTHGAR_JUMPER = DEST_PIN_TEXT_COLOR_OTHER_DONE,
    RELIC_HUNTER = DEST_PIN_TEXT_COLOR_OTHER_DONE,
    BREAKING = DEST_PIN_TEXT_COLOR_OTHER_DONE,
    CUTPURSE = DEST_PIN_TEXT_COLOR_OTHER_DONE,
    CHAMPION = DEST_PIN_TEXT_COLOR_OTHER_DONE,
  },
}
Destinations.drtv = drtv

-------------------------------------------------
----- Logger Function                       -----
-------------------------------------------------
Destinations.show_log = false
if LibDebugLogger then
  Destinations.logger = LibDebugLogger.Create(Destinations.name)
end
local logger
local viewer
if DebugLogViewer then viewer = true else viewer = false end
if LibDebugLogger then logger = true else logger = false end

local function create_log(log_type, log_content)
  if not viewer and log_type == "Info" then
    CHAT_ROUTER:AddSystemMessage(log_content)
    return
  end
  if not Destinations.show_log then return end
  if logger and log_type == "Debug" then
    Destinations.logger:Debug(log_content)
  end
  if logger and log_type == "Info" then
    Destinations.logger:Info(log_content)
  end
  if logger and log_type == "Verbose" then
    Destinations.logger:Verbose(log_content)
  end
  if logger and log_type == "Warn" then
    Destinations.logger:Warn(log_content)
  end
end

local function emit_message(log_type, text)
  if (text == "") then
    text = "[Empty String]"
  end
  create_log(log_type, text)
end

local function emit_table(log_type, t, indent, table_history)
  indent = indent or "."
  table_history = table_history or {}

  for k, v in pairs(t) do
    local vType = type(v)

    emit_message(log_type, indent .. "(" .. vType .. "): " .. tostring(k) .. " = " .. tostring(v))

    if (vType == "table") then
      if (table_history[v]) then
        emit_message(log_type, indent .. "Avoiding cycle on table...")
      else
        table_history[v] = true
        emit_table(log_type, v, indent .. "  ", table_history)
      end
    end
  end
end

function Destinations:dm(log_type, ...)
  for i = 1, select("#", ...) do
    local value = select(i, ...)
    if (type(value) == "table") then
      emit_table(log_type, value)
    else
      emit_message(log_type, tostring(value))
    end
  end
end
