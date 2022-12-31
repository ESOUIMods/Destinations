-------------------------------------------------
----- early helper                          -----
-------------------------------------------------
local ADDON_NAME = "Destinations"

local function is_in(search_value, search_table)
  for _, v in pairs(search_table) do
    if search_value == v then return true end
    if type(search_value) == "string" then
      if string.find(string.lower(v), string.lower(search_value)) then return true end
    end
  end
  return false
end

-------------------------------------------------
----- lang setup                            -----
-------------------------------------------------

--[[
FX is an alternate Polish lang file
KB is Korean Beta and TR is some kind of Korean and English
Index Mix that I don't understand how that works

client_lang
effective_lang
supported_lang
]]--
Destinations.client_lang = GetCVar("Language.2")
Destinations.effective_menu_lang = nil
local supported_menu_langs = { "de", "en", "es", "fr", "fx", "jf", "jp", "pl", "ru", "zh", }
if is_in(Destinations.client_lang, supported_menu_langs) then
  Destinations.effective_menu_lang = Destinations.client_lang
else
  Destinations.effective_menu_lang = "en"
end
Destinations.supported_menu_lang = Destinations.client_lang == Destinations.effective_menu_lang

-------------------------------------------------
----- Destinations                          -----
-------------------------------------------------
if LibDebugLogger then
  Destinations.logger = LibDebugLogger.Create(ADDON_NAME)
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

-------------------------------------------------
----- Destinations                          -----
-------------------------------------------------

local ADDON_AUTHOR = "Sharlikran |c990000Snowman|r|cFFFFFFDK|r & MasterLenman & Ayantir"
local ADDON_VERSION = "29.77"
local ADDON_WEBSITE = "http://www.esoui.com/downloads/info667-Destinations.html"

local LMP = LibMapPins

local mapTextureName, zoneTextureName, mapData, mapId, zoneId
local DestinationsSV, DestinationsCSSV, DestinationsAWSV, playerAlliance

local destinationsSetsData = {}

local INFORMATION_TOOLTIP

local DESTINATIONS_PIN_TYPE_AOI = 1
local DESTINATIONS_PIN_TYPE_AYLEIDRUIN = 2
local DESTINATIONS_PIN_TYPE_BATTLEFIELD = 3
local DESTINATIONS_PIN_TYPE_CAMP = 4
local DESTINATIONS_PIN_TYPE_CAVE = 5
local DESTINATIONS_PIN_TYPE_CEMETERY = 6
local DESTINATIONS_PIN_TYPE_CITY = 7
local DESTINATIONS_PIN_TYPE_CRAFTING = 8
local DESTINATIONS_PIN_TYPE_CRYPT = 9
local DESTINATIONS_PIN_TYPE_DAEDRICRUIN = 10
local DESTINATIONS_PIN_TYPE_DELVE = 11
local DESTINATIONS_PIN_TYPE_DOCK = 12
local DESTINATIONS_PIN_TYPE_DUNGEON = 13
local DESTINATIONS_PIN_TYPE_DWEMERRUIN = 14
local DESTINATIONS_PIN_TYPE_ESTATE = 15
local DESTINATIONS_PIN_TYPE_FARM = 16
local DESTINATIONS_PIN_TYPE_GATE = 17
local DESTINATIONS_PIN_TYPE_GROUPBOSS = 18
local DESTINATIONS_PIN_TYPE_GROUPDELVE = 19
local DESTINATIONS_PIN_TYPE_GROUPINSTANCE = 20
local DESTINATIONS_PIN_TYPE_GROVE = 21
local DESTINATIONS_PIN_TYPE_KEEP = 22
local DESTINATIONS_PIN_TYPE_LIGHTHOUSE = 23
local DESTINATIONS_PIN_TYPE_MINE = 24
local DESTINATIONS_PIN_TYPE_MUNDUS = 25
local DESTINATIONS_PIN_TYPE_PORTAL = 26
local DESTINATIONS_PIN_TYPE_RAIDDUNGEON = 27
local DESTINATIONS_PIN_TYPE_RUIN = 28
local DESTINATIONS_PIN_TYPE_SEWER = 29
local DESTINATIONS_PIN_TYPE_SOLOTRIAL = 30
local DESTINATIONS_PIN_TYPE_TOWER = 31
local DESTINATIONS_PIN_TYPE_TOWN = 32
local DESTINATIONS_PIN_TYPE_WAYSHRINE = 33
local DESTINATIONS_PIN_TYPE_GUILDKIOSK = 34
local DESTINATIONS_PIN_TYPE_PLANARARMORSCRAPS = 35
local DESTINATIONS_PIN_TYPE_TINYCLAW = 36
local DESTINATIONS_PIN_TYPE_MONSTROUSTEETH = 37
local DESTINATIONS_PIN_TYPE_BONESHARD = 38
local DESTINATIONS_PIN_TYPE_MARKLEGION = 39
local DESTINATIONS_PIN_TYPE_DARKETHER = 40
local DESTINATIONS_PIN_TYPE_DARKBROTHERHOOD = 41
local DESTINATIONS_PIN_TYPE_GROUPLIGHTHOUSE = 42
local DESTINATIONS_PIN_TYPE_GROUPESTATE = 43
local DESTINATIONS_PIN_TYPE_GROUPRUIN = 44
local DESTINATIONS_PIN_TYPE_GROUPCAVE = 45
local DESTINATIONS_PIN_TYPE_GROUPCEMETERY = 46
local DESTINATIONS_PIN_TYPE_GROUPKEEP = 47
local DESTINATIONS_PIN_TYPE_GROUPAREAOFINTEREST = 48
local DESTINATIONS_PIN_TYPE_HOUSING = 49
local DESTINATIONS_PIN_TYPE_DWEMERGEAR = 50
local DESTINATIONS_PIN_TYPE_NORDBOAT = 51
local DESTINATIONS_PIN_TYPE_DEADLANDS = 52
local DESTINATIONS_PIN_TYPE_HIGHISLE = 53
local DESTINATIONS_PIN_TYPE_UNKNOWN = 99
local DESTINATIONS_PIN_PRIORITY_OFFSET = 1

local ENGLISH_POI_COLOR, ENGLISH_KEEP_COLOR

-- Define Runtime Variables
local drtv = {
  MapMiscPOIs = false,
  LastMapShown = "",
  pinName = nil,
  pinTag = nil,
  pinType = 99,
  pinTypeName = "",
  AchPins = {
    [2] = "LB_GTTP_CP",
    [1] = "MAIQ",
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
    [2] = "pinTextureOther",
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
}

local POIsStore
local TradersStore
local AchIndex
local AchStore
local AchIDs
local DBossIndex
local DBossStore
local SetsStore
local CollectibleIndex
local CollectibleStore
local CollectibleIDs
local FishIndex
local FishStore
local FishIDs
local FishLocs
local KeepsStore
local MundusStore
local QOLDataStore

-- Define Pins
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

-- Define Defaults
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
    settingsTextAccountWide = ZO_ColorDef:New("FFFF00"),
    settingsTextImprove = ZO_ColorDef:New("993333"),
    settingsTextUnknown = ZO_ColorDef:New("005500"),
    settingsTextEnglish = ZO_ColorDef:New("AA5500"),
    settingsTextOnlyText = ZO_ColorDef:New("CCCC00"),
    settingsTextWarn = ZO_ColorDef:New("FF3333"),
    settingsTextEvenLine = ZO_ColorDef:New("EDEDCC"),
    settingsTextOddLine = ZO_ColorDef:New("FFFFFF"),
    settingsTextAchievements = ZO_ColorDef:New("008800"),
    settingsTextAchHeaders = ZO_ColorDef:New("00AAAA"),
    settingsTextMiscellaneous = ZO_ColorDef:New("00CC00"),
    settingsTextVWW = ZO_ColorDef:New("44DD44"),
    settingsTextCollectibles = ZO_ColorDef:New("99FF99"),
    settingsTextFish = ZO_ColorDef:New("CCFFCC"),
    settingsTextInstructions = ZO_ColorDef:New("CCFFFF"),
    settingsTextReloadWarning = ZO_ColorDef:New("FF0000"),
    mapFilterTextUndone1 = ZO_ColorDef:New("DDC29E"),
    mapFilterTextDone1 = ZO_ColorDef:New("C5DD9E"),
    mapFilterTextUndone2 = ZO_ColorDef:New("FF9988"),
    mapFilterTextDone2 = ZO_ColorDef:New("99FF88"),
    mapFilterTextQUndone = ZO_ColorDef:New("FF5555"),
    mapFilterTextQProg = ZO_ColorDef:New("FFAA55"),
    mapFilterTextQDone = ZO_ColorDef:New("55FF55"),
  },
  settings = {
    useAccountWide = false,
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
    [DPINS.UNKNOWN] = true,

    [DPINS.LB_GTTP_CP] = false,
    [DPINS.MAIQ] = false,
    [DPINS.PEACEMAKER] = false,
    [DPINS.NOSEDIVER] = false,
    [DPINS.EARTHLYPOS] = false,
    [DPINS.ON_ME] = false,
    [DPINS.BRAWL] = false,
    [DPINS.PATRON] = false,
    [DPINS.WROTHGAR_JUMPER] = false,
    [DPINS.RELIC_HUNTER] = false,
    [DPINS.BREAKING] = false,
    [DPINS.CUTPURSE] = false,

    [DPINS.CHAMPION] = false,

    [DPINS.LB_GTTP_CP_DONE] = false,
    [DPINS.MAIQ_DONE] = false,
    [DPINS.PEACEMAKER_DONE] = false,
    [DPINS.NOSEDIVER_DONE] = false,
    [DPINS.EARTHLYPOS_DONE] = false,
    [DPINS.ON_ME_DONE] = false,
    [DPINS.BRAWL_DONE] = false,
    [DPINS.PATRON_DONE] = false,
    [DPINS.WROTHGAR_JUMPER_DONE] = false,
    [DPINS.RELIC_HUNTER_DONE] = false,
    [DPINS.BREAKING_DONE] = false,
    [DPINS.CUTPURSE_DONE] = false,

    [DPINS.CHAMPION_DONE] = false,

    [DPINS.ACHIEVEMENTS_COMPASS] = true,

    [DPINS.AYLEID] = false,
    [DPINS.DWEMER] = false,
    [DPINS.DEADLANDS] = false,
    [DPINS.HIGHISLE] = false,
    [DPINS.MISC_COMPASS] = true,

    [DPINS.WWVAMP] = false,
    [DPINS.VAMPIRE_ALTAR] = false,
    [DPINS.WEREWOLF_SHRINE] = false,
    [DPINS.VWW_COMPASS] = true,

    [DPINS.COLLECTIBLES] = false,
    [DPINS.COLLECTIBLESDONE] = false,
    [DPINS.COLLECTIBLES_SHOW_ITEM] = false,
    [DPINS.COLLECTIBLES_SHOW_MOBNAME] = false,
    [DPINS.COLLECTIBLES_COMPASS] = false,

    [DPINS.FISHING] = false,
    [DPINS.FISHINGDONE] = false,
    [DPINS.FISHING_SHOW_BAIT] = false,
    [DPINS.FISHING_SHOW_BAIT_LEFT] = false,
    [DPINS.FISHING_SHOW_WATER] = false,
    [DPINS.FISHING_SHOW_FISHNAME] = false,
    [DPINS.FISHING_COMPASS] = false,
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
      defaults.miscColorCodes.settingsTextOnlyText:Colorize(GetString(GLOBAL_SETTINGS_SELECT_TEXT_ONLY)),
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

local poiTypes = {
  [DESTINATIONS_PIN_TYPE_AOI] = GetString(POITYPE_AOI),
  [DESTINATIONS_PIN_TYPE_AYLEIDRUIN] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_DEADLANDS] = GetString(POITYPE_DEADLANDS_ENTRANCE),
  [DESTINATIONS_PIN_TYPE_HIGHISLE] = GetString(POITYPE_DRUIDIC_SHRINE),
  [DESTINATIONS_PIN_TYPE_BATTLEFIELD] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_CAMP] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_CAVE] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_CEMETERY] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_CITY] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_CRAFTING] = GetString(POITYPE_CRAFTING),
  [DESTINATIONS_PIN_TYPE_CRYPT] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_DAEDRICRUIN] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_DELVE] = GetString(POITYPE_DELVE),
  [DESTINATIONS_PIN_TYPE_DOCK] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_DUNGEON] = GetString(POITYPE_PUBLICDUNGEON),
  [DESTINATIONS_PIN_TYPE_DWEMERRUIN] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_ESTATE] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_FARM] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_GATE] = GetString(POITYPE_GATE),
  [DESTINATIONS_PIN_TYPE_GROUPBOSS] = GetString(POITYPE_GROUPBOSS),
  [DESTINATIONS_PIN_TYPE_GROUPDELVE] = GetString(POITYPE_GROUPDELVE),
  [DESTINATIONS_PIN_TYPE_GROUPINSTANCE] = GetString(POITYPE_GROUPDUNGEON),
  [DESTINATIONS_PIN_TYPE_GROVE] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_KEEP] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_LIGHTHOUSE] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_MINE] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_MUNDUS] = GetString(POITYPE_MUNDUS),
  [DESTINATIONS_PIN_TYPE_PORTAL] = GetString(POITYPE_DOLMEN),
  [DESTINATIONS_PIN_TYPE_RAIDDUNGEON] = GetString(POITYPE_TRIALINSTANCE),
  [DESTINATIONS_PIN_TYPE_RUIN] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_SEWER] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_SOLOTRIAL] = GetString(POITYPE_SOLOTRIAL),
  [DESTINATIONS_PIN_TYPE_TOWER] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_TOWN] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_WAYSHRINE] = GetString(POITYPE_WAYSHRINE),
  [DESTINATIONS_PIN_TYPE_GUILDKIOSK] = GetString(POITYPE_TRADER),
  [DESTINATIONS_PIN_TYPE_PLANARARMORSCRAPS] = GetString(POITYPE_VAULT),
  [DESTINATIONS_PIN_TYPE_TINYCLAW] = GetString(POITYPE_VAULT),
  [DESTINATIONS_PIN_TYPE_MONSTROUSTEETH] = GetString(POITYPE_VAULT),
  [DESTINATIONS_PIN_TYPE_BONESHARD] = GetString(POITYPE_VAULT),
  [DESTINATIONS_PIN_TYPE_MARKLEGION] = GetString(POITYPE_VAULT),
  [DESTINATIONS_PIN_TYPE_DARKETHER] = GetString(POITYPE_VAULT),
  [DESTINATIONS_PIN_TYPE_DARKBROTHERHOOD] = GetString(POITYPE_DARK_BROTHERHOOD),
  [DESTINATIONS_PIN_TYPE_GROUPLIGHTHOUSE] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_GROUPESTATE] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_GROUPRUIN] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_GROUPCAVE] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_GROUPCEMETERY] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_GROUPKEEP] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_GROUPAREAOFINTEREST] = GetString(POITYPE_AOI),
  [DESTINATIONS_PIN_TYPE_HOUSING] = GetString(POITYPE_HOUSING),
  [DESTINATIONS_PIN_TYPE_DWEMERGEAR] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_NORDBOAT] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_UNKNOWN] = GetString(POITYPE_UNKNOWN),
}

local poiTypesIC = {
  [DESTINATIONS_PIN_TYPE_AOI] = GetString(POITYPE_AOI),
  [DESTINATIONS_PIN_TYPE_BATTLEFIELD] = GetString(POITYPE_GROUPBOSS),
  [DESTINATIONS_PIN_TYPE_CRAFTING] = GetString(POITYPE_CRAFTING),
  [DESTINATIONS_PIN_TYPE_GROUPINSTANCE] = GetString(POITYPE_GROUPDUNGEON),
  [DESTINATIONS_PIN_TYPE_SEWER] = GetString(POITYPE_WAYSHRINE),
  [DESTINATIONS_PIN_TYPE_TOWN] = GetString(POITYPE_QUESTHUB),
  [DESTINATIONS_PIN_TYPE_PLANARARMORSCRAPS] = GetString(POITYPE_VAULT),
  [DESTINATIONS_PIN_TYPE_TINYCLAW] = GetString(POITYPE_VAULT),
  [DESTINATIONS_PIN_TYPE_MONSTROUSTEETH] = GetString(POITYPE_VAULT),
  [DESTINATIONS_PIN_TYPE_BONESHARD] = GetString(POITYPE_VAULT),
  [DESTINATIONS_PIN_TYPE_MARKLEGION] = GetString(POITYPE_VAULT),
  [DESTINATIONS_PIN_TYPE_DARKETHER] = GetString(POITYPE_VAULT),
  [DESTINATIONS_PIN_TYPE_UNKNOWN] = GetString(POITYPE_UNKNOWN),
}

local ZoneToAchievements = {
  [872] = { -- M'aiq zone conversion
    ["khenarthisroost_base_0"] = 1,
    ["auridon_base_0"] = 2,
    ["grahtwood_base_0"] = 3,
    ["greenshade_base_0"] = 4,
    ["malabaltor_base_0"] = 5,
    ["reapersmarch_base_0"] = 6,
    ["balfoyen_base_0"] = 7,
    ["stonefalls_base_0"] = 8,
    ["deshaan_base_0"] = 9,
    ["shadowfen_base_0"] = 10,
    ["eastmarch_base_0"] = 11,
    ["therift_base_0"] = 12,
    ["betnihk_base_0"] = 13,
    ["glenumbra_base_0"] = 14,
    ["stormhaven_base_0"] = 15,
    ["rivenspire_base_0"] = 16,
    ["alikr_base_0"] = 17,
    ["bangkorai_base_0"] = 18,
    ["coldharbour_base_0"] = 19,
  },
  [767167] = { -- Crime Pays/Lightbringer/Give to the poor zone conversion
    ["auridon_base_0"] = 1,
    ["grahtwood_base_0"] = 2,
    ["greenshade_base_0"] = 3,
    ["malabaltor_base_0"] = 4,
    ["reapersmarch_base_0"] = 5,
    ["stonefalls_base_0"] = 6,
    ["deshaan_base_0"] = 7,
    ["shadowfen_base_0"] = 8,
    ["eastmarch_base_0"] = 9,
    ["therift_base_0"] = 10,
    ["glenumbra_base_0"] = 11,
    ["stormhaven_base_0"] = 12,
    ["rivenspire_base_0"] = 13,
    ["alikr_base_0"] = 14,
    ["bangkorai_base_0"] = 15,
  },
  [704] = { -- This One's on Me zone conversion
    ["glenumbra_base_0"] = 1,
    ["stonefalls_base_0"] = 2,
    ["auridon_base_0"] = 3,
    ["stormhaven_base_0"] = 4,
    ["deshaan_base_0"] = 5,
    ["grahtwood_base_0"] = 6,
    ["rivenspire_base_0"] = 7,
    ["shadowfen_base_0"] = 8,
    ["greenshade_base_0"] = 9,
    ["alikr_base_0"] = 10,
    ["eastmarch_base_0"] = 11,
    ["malabaltor_base_0"] = 12,
    ["bangkorai_base_0"] = 13,
    ["therift_base_0"] = 14,
    ["reapersmarch_base_0"] = 15,
    ["coldharbour_base_0"] = 16,
  }
}
--------- ZoneId to mapTile name conversion ---------
local ZoneIDsToFileNames = {
  [281] = "balfoyen_base_0",
  [280] = "bleakrock_base_0",
  [57] = "deshaan_base_0",
  [101] = "eastmarch_base_0",
  [117] = "shadowfen_base_0",
  [41] = "stonefalls_base_0",
  [103] = "therift_base_0",
  [104] = "alikr_base_0",
  [92] = "bangkorai_base_0",
  [535] = "betnihk_base_0",
  [3] = "glenumbra_base_0",
  [20] = "rivenspire_base_0",
  [19] = "stormhaven_base_0",
  [534] = "strosmkai_base_0",
  [381] = "auridon_base_0",
  [383] = "grahtwood_base_0",
  [108] = "greenshade_base_0",
  [537] = "khenarthisroost_base_0",
  [58] = "malabaltor_base_0",
  [382] = "reapersmarch_base_0",
  [1027] = "artaeum_base_0",
  [1208] = "u28_blackreach_base_0", -- Arkthzand
  [1161] = "blackreach_base_0", -- Greymoor
  [1261] = "blackwood_base_0",
  [980] = "clockwork_base_0",
  [981] = "brassfortress_base_0",
  [982] = "clockworkoutlawsrefuge_base_0",
  [347] = "coldharbour_base_0",
  [888] = "craglorn_base_0",
  --[[ since there are two entries with 1283 the table is
  messed up. So for Fargrave and The Shambles the mapId
  will be used.
  ]]--
  [2119] = "u32_fargravezone_base_0", -- The zone, 1283
  [1282] = "u32_fargrave_base_0", -- Fargrave City
  [2082] = "u32_theshambles_base_0", -- The Shambles, 1283
  [823] = "goldcoast_base_0",
  [816] = "hewsbane_base_0",
  [1318] = "u34_systreszone_base_0", -- High Isle
  [1383] = "u36_galenisland_base_0", -- Galen
  [726] = "murkmire_base_0",
  [1086] = "elsweyr_base_0",
  [1133] = "southernelsweyr_base_0",
  [1011] = "summerset_base_0",
  [1286] = "u32deadlandszone_base_0",
  [1207] = "reach_base_0",
  [849] = "vvardenfell_base_0",
  [1160] = "westernskryim_base_0",
  [684] = "wrothgar_base_0",
  [181] = "ava_whole_0",
  [584] = "imperialcity_base_0",
  [267] = "eyevea_base_0",
}

local achTypes = {
  [1] = GetString(POITYPE_MAIQ),
  [2] = GetString(POITYPE_LB_GTTP_CP),
  [3] = GetString(POITYPE_PEACEMAKER),
  [4] = GetString(POITYPE_CRIME_PAYS),
  [5] = GetString(POITYPE_GIVE_TO_THE_POOR),
  [6] = GetString(POITYPE_LIGHTBRINGER),
  [7] = GetString(POITYPE_NOSEDIVER),
  [8] = GetString(POITYPE_EARTHLY_POS),
  [9] = GetString(POITYPE_ON_ME),
  [10] = GetString(POITYPE_BRAWL),
  [11] = GetString(POITYPE_PATRON),
  [12] = GetString(POITYPE_WROTHGAR_JUMPER),
  [13] = GetString(POITYPE_CHAMPION),
  [14] = GetString(POITYPE_RELICHUNTER),
  [15] = GetString(POITYPE_BREAKING_ENTERING),
  [16] = GetString(POITYPE_CUTPURSE_ABOVE),
  [20] = GetString(POITYPE_AYLEID_WELL),
  [21] = GetString(POITYPE_WWVAMP),
  [22] = GetString(POITYPE_VAMPIRE_ALTAR),
  [23] = GetString(POITYPE_DWEMER_RUIN),
  [24] = GetString(POITYPE_WEREWOLF_SHRINE),
  [25] = GetString(POITYPE_DEADLANDS_ENTRANCE),
  [26] = GetString(POITYPE_DRUIDIC_SHRINE),
  [30] = GetString(POITYPE_COLLECTIBLE),
  [31] = GetString(POITYPE_FISH),
  [50] = GetString(POITYPE_UNDETERMINED),
  [55] = GetString(POITYPE_UNKNOWN),
}

-- Toggle filters depending on settings
local function TogglePins(pinType, value)
  DestinationsCSSV.filters[pinType] = value
  LMP:SetEnabled(pinType, value)
end

-- Refresh map and compass pins
local function RedrawAllPins(pinType)
  LMP:RefreshPins(pinType)
  COMPASS_PINS:RefreshPins(pinType)
end

-- Refresh map pins only
local function RedrawMapPinsOnly(pinType)
  LMP:RefreshPins(pinType)
end

-- Refresh compass pins only
local function RedrawCompassPinsOnly(pinType)
  COMPASS_PINS:RefreshPins(pinType)
end

local function SetPlayerLocation()
  local originalMap = GetMapTileTexture()
  if SetMapToPlayerLocation() == SET_MAP_RESULT_FAILED then
    Destinations:dm("Warn", "SetMapToPlayerLocation Failed")
  end
  if GetMapTileTexture() ~= originalMap then
    CALLBACK_MANAGER:FireCallbacks("OnWorldMapChanged")
    return true
  end
  -- SET_MAP_RESULT_CURRENT_MAP_UNCHANGED
  return false
end

local function RedrawQolPins()
  RedrawMapPinsOnly(DPINS.QOLPINS_DOCK)
  RedrawMapPinsOnly(DPINS.QOLPINS_STABLE)
  RedrawMapPinsOnly(DPINS.QOLPINS_PORTAL)
end

--[[ Various map names
    Reference https://wiki.esoui.com/Texture_List/ESO/art/maps

   "/art/maps/southernelsweyr/els_dragonguard_island05_base_8.dds",
   "/art/maps/murkmire/tsofeercavern01_1.dds",
   "/art/maps/housing/blackreachcrypts.base_0.dds",
   "/art/maps/housing/blackreachcrypts.base_1.dds",
   "Art/maps/skyrim/blackreach_base_0.dds",
   "Textures/maps/summerset/alinor_base.dds",
   "art/maps/murkmire/ui_map_tsofeercavern01_0.dds",
   "art/maps/elsweyr/jodesembrace1.base_0.dds",
]]--
local function GetMapTextureName()
  zoneId = GetZoneId(GetCurrentMapZoneIndex())
  mapId = GetCurrentMapId()
  if zoneId == 1283 then
    zoneTextureName = ZoneIDsToFileNames[mapId]
  else
    zoneTextureName = ZoneIDsToFileNames[zoneId]
  end
  _, mapTextureName = LMP:GetZoneAndSubzone(false, true, true)
  if not zoneTextureName then
    zoneTextureName = mapTextureName
  end
end

-----
--- Quality of Life Map Pins
-----
local function qualityOfLifeMapPinData()
  mapData, mapTextureName, zoneTextureName, mapId, zoneId = nil, nil, nil, nil, nil
  GetMapTextureName()
  mapData = QOLDataStore[mapId]
end

local function MapCallbackQolPins(pinType)
  --Destinations:dm("Debug", "MapCallbackQolPins")

  if GetMapType() > MAPTYPE_ZONE then
    --Destinations:dm("Debug", "Tamriel or Aurbis reached, stopped")
    return
  end
  qualityOfLifeMapPinData()
  if not mapData then
    --Destinations:dm("Debug", "mapData in not set")
    return
  end

  for key, pinData in pairs(mapData) do

    if pinType == DPINS.QOLPINS_DOCK and pinData.pinsType == Destinations.DocksHighIsle then
      LMP:CreatePin(DPINS.QOLPINS_DOCK, pinData, pinData.x, pinData.y)
    end

    if pinType == DPINS.QOLPINS_STABLE and pinData.pinsType == Destinations.Stable then
      LMP:CreatePin(DPINS.QOLPINS_STABLE, pinData, pinData.x, pinData.y)
    end

    if pinType == DPINS.QOLPINS_PORTAL and pinData.pinsType == Destinations.Portals then
      LMP:CreatePin(DPINS.QOLPINS_PORTAL, pinData, pinData.x, pinData.y)
    end

  end
end


-----
---
-----
-- Slash commands -------------------------------------------------------------
--prints message to chat
local function ChatPrint(...)
  local ChatEditControl = CHAT_SYSTEM.textEntry.editControl
  if (not ChatEditControl:HasFocus()) then StartChatInput() end
  ChatEditControl:InsertText(...)
end

local function ShowMyPosition()
  if SetMapToPlayerLocation() == SET_MAP_RESULT_MAP_CHANGED then
    CALLBACK_MANAGER:FireCallbacks("OnWorldMapChanged")
  end

  local x, y = GetMapPlayerPosition("player")
  local mapname = LMP:GetZoneAndSubzone(false, true, true)
  GetMapTextureName()
  local xs = '"X"'
  local locationString = string.format("{ %.6f, %.6f, 0, 0, 1, %s }, -- %s/%s", x, y, xs, mapname, zoneTextureName)
  ChatPrint(locationString)
end

SLASH_COMMANDS["/fishloc"] = ShowMyPosition

local function GetPoiTypeName(poiTypeId)
  return poiTypes[poiTypeId] or poiTypes[99]
end

local function GetICPoiTypeName(poiTypeId)
  return poiTypesIC[poiTypeId] or poiTypesIC[99]
end

local function GetAchTypeName(TYPE)
  return achTypes[TYPE] or achTypes[55]
end

------------------- MAP PINS -------------------
------------------Achievements------------------
local function sharedAchievementsPinData()
  mapData, mapTextureName, zoneTextureName, mapId, zoneId = nil, nil, nil, nil, nil
  if LMP:IsEnabled(drtv.pinName) and DestinationsCSSV.filters[drtv.pinName] then
    GetMapTextureName()
    mapData = AchStore[mapTextureName]
  end
end

local function OtherpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.LB_GTTP_CP
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 2 then
      local COMP = ZoneToAchievements[767167][zoneTextureName]
      local desca, completedLB, requiredLB = GetAchievementCriterion(873, COMP)
      local descb, completedGTTP, requiredGTTP = GetAchievementCriterion(871, COMP)
      local descc, completedCP, requiredCP = GetAchievementCriterion(869, COMP)
      local completed = completedLB + completedGTTP + completedCP
      local required = requiredLB + requiredGTTP + requiredCP
      drtv.pinTag = {}
      if completed ~= required then
        local pinTextLine = 0
        if completedCP ~= requiredCP then
          pinTextLine = pinTextLine + 1
          table.insert(drtv.pinTag, pinTextLine,
            ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOther.textcolor)):Colorize(zo_strformat("<<1>>",
              AchIDs[869])))
        end
        if completedGTTP ~= requiredGTTP then
          pinTextLine = pinTextLine + 1
          table.insert(drtv.pinTag, pinTextLine,
            ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOther.textcolor)):Colorize(zo_strformat("<<1>>",
              AchIDs[871])))
        end
        if completedLB ~= requiredLB then
          pinTextLine = pinTextLine + 1
          table.insert(drtv.pinTag, pinTextLine,
            ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOther.textcolor)):Colorize(zo_strformat("<<1>>",
              AchIDs[873])))
        end
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end

local function OtherpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.LB_GTTP_CP_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 2 then
      local COMP = ZoneToAchievements[767167][zoneTextureName]
      local desca, completedLB, requiredLB = GetAchievementCriterion(873, COMP)
      local descb, completedGTTP, requiredGTTP = GetAchievementCriterion(871, COMP)
      local descc, completedCP, requiredCP = GetAchievementCriterion(869, COMP)
      local completed = completedLB + completedGTTP + completedCP
      local required = requiredLB + requiredGTTP + requiredCP
      drtv.pinTag = {}
      local pinTextLine = 0
      if not LMP:IsEnabled(DPINS.LB_GTTP_CP) then
        LMP:SetLayoutKey(drtv.pinName, "level", DestinationsSV.pins.pinTextureMaiq.level)
        if completed == required then
          table.insert(drtv.pinTag, 1,
            ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOtherDone.textcolor)):Colorize(zo_strformat("<<1>>",
              AchIDs[869])))
          table.insert(drtv.pinTag, 2,
            ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOtherDone.textcolor)):Colorize(zo_strformat("<<1>>",
              AchIDs[871])))
          table.insert(drtv.pinTag, 3,
            ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOtherDone.textcolor)):Colorize(zo_strformat("<<1>>",
              AchIDs[873])))
        end
      end
      if LMP:IsEnabled(DPINS.LB_GTTP_CP) then
        LMP:SetLayoutKey(drtv.pinName, "level", DestinationsSV.pins.pinTextureMaiq.level - 1)
        if completedCP == requiredCP then
          pinTextLine = pinTextLine + 1
          table.insert(drtv.pinTag, pinTextLine,
            ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOtherDone.textcolor)):Colorize(zo_strformat("<<1>>",
              AchIDs[869])))
        end
        if completedGTTP == requiredGTTP then
          pinTextLine = pinTextLine + 1
          table.insert(drtv.pinTag, pinTextLine,
            ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOtherDone.textcolor)):Colorize(zo_strformat("<<1>>",
              AchIDs[871])))
        end
        if completedLB == requiredLB then
          pinTextLine = pinTextLine + 1
          table.insert(drtv.pinTag, pinTextLine,
            ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOtherDone.textcolor)):Colorize(zo_strformat("<<1>>",
              AchIDs[873])))
        end
      end
      if pinTextLine >= 1 then
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function MaiqpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.MAIQ
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 1 then
      local COMP = ZoneToAchievements[872][zoneTextureName]
      local desc, completed, required = GetAchievementCriterion(872, COMP)
      drtv.pinTag = {}
      if completed ~= required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureMaiq.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[872])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function MaiqpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.MAIQ_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 1 then
      local COMP = ZoneToAchievements[872][zoneTextureName]
      local desc, completed, required = GetAchievementCriterion(872, COMP)
      drtv.pinTag = {}
      if completed == required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureMaiqDone.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[872])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function PeacemakerpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.PEACEMAKER
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 3 then
      local desc, completed, required = GetAchievementCriterion(716)
      drtv.pinTag = {}
      if completed ~= required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTexturePeacemaker.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[716])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function PeacemakerpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.PEACEMAKER_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 3 then
      local desc, completed, required = GetAchievementCriterion(716)
      drtv.pinTag = {}
      if completed == required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTexturePeacemakerDone.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[716])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function NosediverpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.NOSEDIVER
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 7 then
      local desc, completed, required = GetAchievementCriterion(406)
      drtv.pinTag = {}
      if completed ~= required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureNosediver.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[406])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function NosediverpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.NOSEDIVER_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 7 then
      local desc, completed, required = GetAchievementCriterion(406)
      drtv.pinTag = {}
      if completed == required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureNosediverDone.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[406])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function EarthlyPospinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.EARTHLYPOS
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 8 then
      local desc, completed, required = GetAchievementCriterion(1121)
      drtv.pinTag = {}
      if completed ~= required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureEarthlyPos.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[1121])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function EarthlyPospinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.EARTHLYPOS_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 8 then
      local desc, completed, required = GetAchievementCriterion(1121)
      drtv.pinTag = {}
      if completed == required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureEarthlyPosDone.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[1121])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function OnMepinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.ON_ME
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 9 then
      local COMP = ZoneToAchievements[704][zoneTextureName]
      local desc, completed, required = GetAchievementCriterion(704, COMP)
      drtv.pinTag = {}
      if completed ~= required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOnMe.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[704])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function OnMepinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.ON_ME_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 9 then
      local COMP = ZoneToAchievements[704][zoneTextureName]
      local subName, completed, required = GetAchievementCriterion(704, COMP)
      drtv.pinTag = {}
      if completed == required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOnMeDone.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[704])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function BrawlpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.BRAWL
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 10 then
      local desc, completed, required = GetAchievementCriterion(1247)
      drtv.pinTag = {}
      if completed ~= required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureBrawl.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[1247])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function BrawlpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.BRAWL_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 10 then
      local desc, completed, required = GetAchievementCriterion(1247)
      drtv.pinTag = {}
      if completed == required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureBrawlDone.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[1247])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function PatronpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.PATRON
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 11 then
      local desc, completed, required = GetAchievementCriterion(1316)
      drtv.pinTag = {}
      if completed ~= required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTexturePatron.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[1316])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function PatronpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.PATRON_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 11 then
      local desc, completed, required = GetAchievementCriterion(1316)
      drtv.pinTag = {}
      if completed == required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTexturePatronDone.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[1316])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function WrothgarJumperpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.WROTHGAR_JUMPER
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 12 then
      local _, completed, required = GetAchievementCriterion(1331)
      drtv.pinTag = {}
      if completed ~= required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureWrothgarJumper.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[1331])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function WrothgarJumperpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.WROTHGAR_JUMPER_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 12 then
      local desc, completed, required = GetAchievementCriterion(1331)
      drtv.pinTag = {}
      if completed == required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureWrothgarJumperDone.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[1331])))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function RelicHunterpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.RELIC_HUNTER
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 14 then
      local NUMBER = tonumber(pinData[AchIndex.KEYCODE])
      local desc, completed, required = GetAchievementCriterion(1250, NUMBER)
      drtv.pinTag = {}
      if completed ~= required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureRelicHunter.textcolor)):Colorize(zo_strformat("<<1>>",
            desc)))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function RelicHunterpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.RELIC_HUNTER_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 14 then
      local NUMBER = tonumber(pinData[AchIndex.KEYCODE])
      local desc, completed, required = GetAchievementCriterion(1250, NUMBER)
      drtv.pinTag = {}
      if completed == required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureRelicHunterDone.textcolor)):Colorize(zo_strformat("<<1>>",
            desc)))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function BreakingpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.BREAKING
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 15 then
      local achNum = pinData[AchIndex.KEYCODE]
      local subName, completed, required = GetAchievementCriterion(1349, achNum)
      drtv.pinTag = {}
      if completed ~= required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureBreaking.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[1349])))
        table.insert(drtv.pinTag, 2,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureBreaking.textcolor)):Colorize(zo_strformat("<<1>>",
            "[" .. subName .. "]")))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function BreakingpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.BREAKING_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 15 then
      local achNum = pinData[AchIndex.KEYCODE]
      local subName, completed, required = GetAchievementCriterion(1349, achNum)
      drtv.pinTag = {}
      if completed == required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureBreakingDone.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[1349])))
        table.insert(drtv.pinTag, 2,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureBreakingDone.textcolor)):Colorize(zo_strformat("<<1>>",
            "[" .. subName .. "]")))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function CutpursepinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.CUTPURSE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 16 then
      local achNum = pinData[AchIndex.KEYCODE]
      local _, completedM, requiredM = GetAchievementCriterion(1383)
      local subName, completed, required = GetAchievementCriterion(pinData[AchIndex.ID], achNum)
      drtv.pinTag = {}
      if completed ~= required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCutpurse.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[1383])))
        table.insert(drtv.pinTag, 2,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCutpurse.textcolor)):Colorize(zo_strformat("<<1>>",
            "[" .. subName .. "]")))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function CutpursepinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.CUTPURSE_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 16 then
      local achNum = pinData[AchIndex.KEYCODE]
      local _, completedM, requiredM = GetAchievementCriterion(1383)
      local subName, completed, required = GetAchievementCriterion(pinData[AchIndex.ID], achNum)
      drtv.pinTag = {}
      if completed == required then
        table.insert(drtv.pinTag, 1,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCutpurseDone.textcolor)):Colorize(zo_strformat("<<1>>",
            AchIDs[1383])))
        table.insert(drtv.pinTag, 2,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCutpurseDone.textcolor)):Colorize(zo_strformat("<<1>>",
            "[" .. subName .. "]")))
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end

------------------Achievements------------------
local function ChampionpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  if (zoneTextureName == mapTextureName) and DestinationsSV.settings.ShowDungeonBossesInZones == false then return end
  drtv.pinName = DPINS.CHAMPION
  if LMP:IsEnabled(drtv.pinName) then
    GetMapTextureName()
    mapData = DBossStore[mapTextureName]
    if mapData then
      for _, pinData in ipairs(mapData) do
        local CHAMPACH = pinData[DBossIndex.ACH]
        local CHAMPIDX = pinData[DBossIndex.IDX]
        local CHAMPNAME, completed, required = GetAchievementCriterion(tonumber(CHAMPACH), tonumber(CHAMPIDX))
        drtv.pinTag = {}
        if completed ~= required then
          drtv.pinTag = { ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureChampion.textcolor)):Colorize(zo_strformat("<<1>>",
            CHAMPNAME)) }
          LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[DBossIndex.X], pinData[DBossIndex.Y])
        end
      end
    end
  end
end
local function ChampionpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  -- TODO: New zones starting with murkmire have zoneTextureName == nil. Find a better way to handle this.
  if (zoneTextureName == mapTextureName) and DestinationsSV.settings.ShowDungeonBossesInZones == false then return end
  drtv.pinName = DPINS.CHAMPION_DONE
  if LMP:IsEnabled(drtv.pinName) then
    GetMapTextureName()
    mapData = DBossStore[mapTextureName]
    if mapData then
      for _, pinData in ipairs(mapData) do
        local CHAMPACH = pinData[DBossIndex.ACH]
        local CHAMPIDX = pinData[DBossIndex.IDX]
        local CHAMPNAME, completed, required = GetAchievementCriterion(tonumber(CHAMPACH), tonumber(CHAMPIDX))
        drtv.pinTag = {}
        if completed == required then
          drtv.pinTag = { ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureChampionDone.textcolor)):Colorize(zo_strformat("<<1>>",
            CHAMPNAME)) }
          LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[DBossIndex.X], pinData[DBossIndex.Y])
        end
      end
    end
  end
end

--------------------Misc POI--------------------
local function AyleidpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.AYLEID
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    drtv.pinTypeName = GetAchTypeName(drtv.pinType)
    if drtv.pinType == 20 then
      drtv.pinTag = { ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureAyleid.textcolor)):Colorize(zo_strformat("<<1>>",
        drtv.pinTypeName)) }
      LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end
--------------------Misc POI--------------------
local function DeadlandspinTypeCallback()
  -- DESTINATIONS_PIN_TYPE_DEADLANDS
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.DEADLANDS
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    drtv.pinTypeName = GetAchTypeName(drtv.pinType)
    if drtv.pinType == 25 then
      drtv.pinTag = { ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureDeadlands.textcolor)):Colorize(zo_strformat("<<1>>", drtv.pinTypeName)) }
      LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end
--------------------Misc POI--------------------
local function HighIslepinTypeCallback()
  -- DESTINATIONS_PIN_TYPE_HIGHISLE
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.HIGHISLE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    drtv.pinTypeName = GetAchTypeName(drtv.pinType)
    if drtv.pinType == 26 then
      drtv.pinTag = { ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureHighIsle.textcolor)):Colorize(zo_strformat("<<1>>", drtv.pinTypeName)) }
      LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end
--------------------Misc POI--------------------
local function DwemerRuinpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.DWEMER
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    drtv.pinTypeName = GetAchTypeName(drtv.pinType)
    if drtv.pinType == 23 then
      drtv.pinTag = { ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureDwemer.textcolor)):Colorize(zo_strformat("<<1>>",
        drtv.pinTypeName)) }
      LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end
------------Vampire and Werewolf POI------------
local function WWVamppinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.WWVAMP
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    drtv.pinTypeName = GetAchTypeName(drtv.pinType)
    if drtv.pinType == 21 then
      drtv.pinTag = { ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureWWVamp.textcolor)):Colorize(zo_strformat("<<1>>",
        drtv.pinTypeName)) }
      LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end
------------Vampire and Werewolf POI------------
local function VampireAltarpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.VAMPIRE_ALTAR
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    drtv.pinTypeName = GetAchTypeName(drtv.pinType)
    if drtv.pinType == 22 then
      drtv.pinTag = { ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureVampAltar.textcolor)):Colorize(zo_strformat("<<1>>",
        drtv.pinTypeName)) }
      LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end
------------Vampire and Werewolf POI------------
local function WerewolfShrinepinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.WEREWOLF_SHRINE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    drtv.pinTypeName = GetAchTypeName(drtv.pinType)
    if drtv.pinType == 24 then
      drtv.pinTag = { ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureWWShrine.textcolor)):Colorize(zo_strformat("<<1>>",
        drtv.pinTypeName)) }
      LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end

--------------------Trophies--------------------
local function CollectiblepinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.COLLECTIBLES
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 30 then
      local collectibleID = pinData[AchIndex.ID]
      local collectibleCode = pinData[AchIndex.KEYCODE]
      local completedTotal, requiredTotal = 0, GetAchievementNumCriteria(collectibleID)
      local desc, completed, required = nil, 0, 0
      for i = 1, requiredTotal, 1 do
        desc, completed, required = GetAchievementCriterion(collectibleID, i)
        if completed == 1 then
          completedTotal = completedTotal + 1
        end
      end
      drtv.pinTag = {}
      local textLine = 0
      local countCN, countCND = 0, 0
      if completedTotal ~= requiredTotal then
        textLine = textLine + 1
        table.insert(drtv.pinTag, textLine,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCollectible.textcolortitle)):Colorize(zo_strformat("<<1>>",
            CollectibleIDs[collectibleID])))
        local collectibleName, collectibleNumber, collectibleItem = nil, nil, nil, nil
        local collectibledata = CollectibleStore[collectibleID]
        local ColName, ColNumber, ColKey = nil, nil, nil
        local collectibleMobNumber = nil
        for i = 1, requiredTotal, 1 do
          for _, pinData in ipairs(collectibledata) do
            collectibleNumber = pinData[CollectibleIndex.NUMBER]
            if i == 10 then
              collectibleMobNumber = "A"
            elseif i == 11 then
              collectibleMobNumber = "B"
            elseif i == 12 then
              collectibleMobNumber = "C"
            else
              collectibleMobNumber = tostring(i)
            end
            if collectibleNumber == i and string.find(collectibleCode, collectibleMobNumber) then
              _, completed, _ = GetAchievementCriterion(collectibleID, i)
              if completed == 0 then
                countCN = countCN + 1
              elseif LMP:IsEnabled(DPINS.COLLECTIBLESDONE) then
                countCND = countCND + 1
              end
            end
          end
        end
        if DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_MOBNAME] or DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_ITEM] then
          for i = 1, requiredTotal, 1 do
            for _, pinData in ipairs(collectibledata) do
              collectibleNumber = pinData[CollectibleIndex.NUMBER]
              collectibleName = pinData[CollectibleIndex.NAME]
              if i == 10 then
                collectibleMobNumber = "A"
              elseif i == 11 then
                collectibleMobNumber = "B"
              elseif i == 12 then
                collectibleMobNumber = "C"
              else
                collectibleMobNumber = tostring(i)
              end
              if collectibleNumber == i and string.find(collectibleCode, collectibleMobNumber) then
                collectibleItem, completed, _ = GetAchievementCriterion(collectibleID, i)
                if completed == 0 then
                  if DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_MOBNAME] then
                    textLine = textLine + 1
                    table.insert(drtv.pinTag, textLine,
                      ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCollectible.textcolor)):Colorize(zo_strformat("<<1>>",
                        "[" .. collectibleName .. "]")))
                  end
                  if DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_ITEM] then
                    textLine = textLine + 1
                    table.insert(drtv.pinTag, textLine,
                      ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCollectible.textcolor)):Colorize(zo_strformat("<<1>>",
                        "<" .. collectibleItem .. ">")))
                  end
                elseif LMP:IsEnabled(DPINS.COLLECTIBLESDONE) then
                  if DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_MOBNAME] then
                    textLine = textLine + 1
                    table.insert(drtv.pinTag, textLine,
                      ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCollectible.textcolor)):Colorize(zo_strformat("<<1>>",
                        "[" .. collectibleName .. "]")))
                  end
                  if DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_ITEM] then
                    textLine = textLine + 1
                    table.insert(drtv.pinTag, textLine,
                      ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCollectible.textcolor)):Colorize(zo_strformat("<<1>>",
                        "<" .. collectibleItem .. ">")))
                  end
                end
              end
            end
          end
        end
        if countCN >= 1 and countCND == 0 then
          LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      end
    end
  end
end
local function CollectibleDonepinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.COLLECTIBLESDONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 30 then
      local collectibleID = pinData[AchIndex.ID]
      local collectibleCode = pinData[AchIndex.KEYCODE]
      local completedTotal, requiredTotal = 0, GetAchievementNumCriteria(collectibleID)
      local desc, completed, required = nil, 0, 0
      for i = 1, requiredTotal, 1 do
        desc, completed, required = GetAchievementCriterion(collectibleID, i)
        if completed == 1 then
          completedTotal = completedTotal + 1
        end
      end
      drtv.pinTag = {}
      local textLine = 0
      local countCN = 0
      textLine = textLine + 1
      table.insert(drtv.pinTag, textLine,
        ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCollectible.textcolortitle)):Colorize(zo_strformat("<<1>>",
          CollectibleIDs[collectibleID])))
      local collectibleName, collectibleNumber, collectibleItem = nil, nil, nil
      local collectibledata = CollectibleStore[collectibleID]
      for i = 1, requiredTotal, 1 do
        for _, pinData in ipairs(collectibledata) do
          collectibleNumber = pinData[CollectibleIndex.NUMBER]
          if collectibleNumber == i and string.find(collectibleCode, i) then
            _, completed, _ = GetAchievementCriterion(collectibleID, i)
            if completed == 1 then
              countCN = countCN + 1
            end
          end
        end
      end
      if DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_MOBNAME] or DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_ITEM] then
        for i = 1, requiredTotal, 1 do
          for _, pinData in ipairs(collectibledata) do
            collectibleNumber = pinData[CollectibleIndex.NUMBER]
            collectibleName = pinData[CollectibleIndex.NAME]
            if collectibleNumber == i and string.find(collectibleCode, i) then
              collectibleItem, completed, _ = GetAchievementCriterion(collectibleID, i)
              if completed == 1 then
                if DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_MOBNAME] then
                  textLine = textLine + 1
                  table.insert(drtv.pinTag, textLine,
                    ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCollectibleDone.textcolor)):Colorize(zo_strformat("<<1>>",
                      "[" .. collectibleName .. "]")))
                end
                if DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_ITEM] then
                  textLine = textLine + 1
                  table.insert(drtv.pinTag, textLine,
                    ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCollectibleDone.textcolor)):Colorize(zo_strformat("<<1>>",
                      "<" .. collectibleItem .. ">")))
                end
              end
            end
          end
        end
      end
      if countCN >= 1 then
        LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end

--------------------Fishing---------------------
local function FishpinTypeCallback()

  local DESTINATIONS_FISH_TYPE_FOUL = 1
  local DESTINATIONS_FISH_TYPE_RIVER = 2
  local DESTINATIONS_FISH_TYPE_OCEAN = 3
  local DESTINATIONS_FISH_TYPE_LAKE = 4

  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.FISHING
  sharedAchievementsPinData()
  if not mapData then return end
  if DestinationsSV.filters[DPINS.FISHING_SHOW_BAIT_LEFT] then
    local numLures = GetNumFishingLures()
    for lureIndex = 1, numLures do
      local name, icon, stack, _, _ = GetFishingLureInfo(lureIndex)
      if string.find(icon, "centipede") then
        --Crawlers
        defaults.data.FoulBaitLeft = stack
      elseif string.find(icon, "fish_roe") then
        --Fish Roe
        defaults.data.FoulSBaitLeft = stack
      elseif string.find(icon, "torchbug") then
        --Insect Parts
        defaults.data.RiverBaitLeft = stack
      elseif string.find(icon, "shad") then
        --Shad
        defaults.data.RiverSBaitLeft = stack
      elseif string.find(icon, "worms") then
        --Worms
        defaults.data.OceanBaitLeft = stack
      elseif string.find(icon, "fish_tail") and not (string.find(name, "simple") or string.find(name,
        "einfacher") or string.find(name, "appât")) then
        --Chub
        defaults.data.OceanSBaitLeft = stack
      elseif string.find(icon, "guts") then
        --Guts
        defaults.data.LakeBaitLeft = stack
      elseif string.find(icon, "river_betty") then
        --Minnow
        defaults.data.LakeSBaitLeft = stack
      elseif string.find(icon, "fish_tail") and (string.find(name, "simple") or string.find(name,
        "einfacher") or string.find(name, "appât")) then
        --Simle Bait
        defaults.data.GeneralBait = stack
      end
    end
  end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType and drtv.pinType >= 40 and drtv.pinType <= 44 then
      local fishID = pinData[AchIndex.ID]
      local completedTotal, requiredTotal = 0, GetAchievementNumCriteria(fishID)
      local desc, completed, required = nil, 0, 0
      for i = 1, requiredTotal, 1 do
        desc, completed, required = GetAchievementCriterion(fishID, i)
        if completed == 1 then
          completedTotal = completedTotal + 1
        end
      end
      if completedTotal == requiredTotal then return end
      local fishingBait, waterType = nil
      if drtv.pinType == 40 then
        fishingBait = GetString(FISHING_FOUL_BAIT)
        waterType = GetString(FISHING_FOUL)
      elseif drtv.pinType == 41 then
        fishingBait = GetString(FISHING_RIVER_BAIT)
        waterType = GetString(FISHING_RIVER)
      elseif drtv.pinType == 42 then
        fishingBait = GetString(FISHING_OCEAN_BAIT)
        waterType = GetString(FISHING_OCEAN)
      elseif drtv.pinType == 43 then
        fishingBait = GetString(FISHING_LAKE_BAIT)
        waterType = GetString(FISHING_LAKE)
      elseif drtv.pinType == 44 then
        waterType = GetString(FISHING_UNKNOWN)
      end
      drtv.pinTag = {}
      local textLine = 0
      local countF, countL, countO, countR = 0, 0, 0, 0
      local countFN, countLN, countON, countRN = 0, 0, 0, 0
      local fishdata = FishStore[fishID]
      local FishName, FishNumber, FishLoc = nil, nil, nil
      for _, pinData in ipairs(fishdata) do
        FishLoc = pinData[FishIndex.LOCATION]
        if FishLoc == DESTINATIONS_FISH_TYPE_FOUL then
          countF = countF + 1
        elseif FishLoc == DESTINATIONS_FISH_TYPE_LAKE then
          countL = countL + 1
        elseif FishLoc == DESTINATIONS_FISH_TYPE_OCEAN then
          countO = countO + 1
        elseif FishLoc == DESTINATIONS_FISH_TYPE_RIVER then
          countR = countR + 1
        end
      end
      for i = 1, requiredTotal, 1 do
        for _, pinData in ipairs(fishdata) do
          FishLoc = pinData[FishIndex.LOCATION]
          FishNumber = pinData[FishIndex.FISHNUMBER]
          if FishNumber == i then
            if drtv.pinType == 40 and FishLoc == DESTINATIONS_FISH_TYPE_FOUL then
              FishName, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 0 then
                countFN = countFN + 1
              end
            elseif drtv.pinType == 41 and FishLoc == DESTINATIONS_FISH_TYPE_RIVER then
              FishName, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 0 then
                countRN = countRN + 1
              end
            elseif drtv.pinType == 42 and FishLoc == DESTINATIONS_FISH_TYPE_OCEAN then
              FishName, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 0 then
                countON = countON + 1
              end
            elseif drtv.pinType == 43 and FishLoc == DESTINATIONS_FISH_TYPE_LAKE then
              FishName, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 0 then
                countLN = countLN + 1
              end
            end
          end
        end
      end
      textLine = textLine + 1
      table.insert(drtv.pinTag, textLine,
        ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFish.textcolortitle)):Colorize(zo_strformat("<<1>>",
          FishIDs[fishID])))
      if DestinationsSV.filters[DPINS.FISHING_SHOW_FISHNAME] then
        for i = 1, requiredTotal, 1 do
          for _, pinData in ipairs(fishdata) do
            local fishFound = false
            local fishMiss = false
            FishLoc = pinData[FishIndex.LOCATION]
            FishNumber = pinData[FishIndex.FISHNUMBER]
            FishName, completed, _ = GetAchievementCriterion(fishID, i)
            if FishNumber == i then
              if drtv.pinType == 40 and FishLoc == DESTINATIONS_FISH_TYPE_FOUL then
                if completed == 0 then
                  fishMiss = true
                elseif LMP:IsEnabled(DPINS.FISHINGDONE) then
                  fishFound = true
                end
              elseif drtv.pinType == 41 and FishLoc == DESTINATIONS_FISH_TYPE_RIVER then
                if completed == 0 then
                  fishMiss = true
                elseif LMP:IsEnabled(DPINS.FISHINGDONE) then
                  fishFound = true
                end
              elseif drtv.pinType == 42 and FishLoc == DESTINATIONS_FISH_TYPE_OCEAN then
                if completed == 0 then
                  fishMiss = true
                elseif LMP:IsEnabled(DPINS.FISHINGDONE) then
                  fishFound = true
                end
              elseif drtv.pinType == 43 and FishLoc == DESTINATIONS_FISH_TYPE_LAKE then
                if completed == 0 then
                  fishMiss = true
                elseif LMP:IsEnabled(DPINS.FISHINGDONE) then
                  fishFound = true
                end
              end
            end
            if fishMiss then
              textLine = textLine + 1
              table.insert(drtv.pinTag, textLine,
                ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFish.textcolor)):Colorize(zo_strformat("<<1>>",
                  "[" .. FishName .. "]")))
              fishMiss = false
            elseif fishFound then
              textLine = textLine + 1
              table.insert(drtv.pinTag, textLine,
                ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFishDone.textcolor)):Colorize(zo_strformat("<<1>>",
                  "[" .. FishName .. "]")))
              fishFound = false
            end
            if drtv.pinType == 44 and FishNumber == i then
              if completed == 0 then
                textLine = textLine + 1
                table.insert(drtv.pinTag, textLine,
                  ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFish.textcolor)):Colorize(zo_strformat("<<1>>",
                    "[" .. FishName .. "]")))
              else
                textLine = textLine + 1
                table.insert(drtv.pinTag, textLine,
                  ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFishDone.textcolor)):Colorize(zo_strformat("<<1>>",
                    "[" .. FishName .. "]")))
              end
            end
          end
        end
      end
      if fishingBait and DestinationsSV.filters[DPINS.FISHING_SHOW_BAIT] then
        textLine = textLine + 1
        table.insert(drtv.pinTag, textLine,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFish.textcolorBait)):Colorize(zo_strformat("<<1>>",
            "<" .. fishingBait .. ">")))
        if DestinationsSV.filters[DPINS.FISHING_SHOW_BAIT_LEFT] then
          local fishingBaitLeft = nil
          if drtv.pinType == 40 then
            fishingBaitLeft = tostring(defaults.data.FoulBaitLeft) .. "/" .. tostring(defaults.data.FoulSBaitLeft)
            if defaults.data.GeneralBait >= 1 then
              fishingBaitLeft = fishingBaitLeft .. "/" .. tostring(defaults.data.GeneralBait)
            end
            textLine = textLine + 1
            table.insert(drtv.pinTag, textLine,
              ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFish.textcolorBait)):Colorize(zo_strformat("<<1>>",
                "{" .. fishingBaitLeft .. "}")))
          elseif drtv.pinType == 41 then
            fishingBaitLeft = tostring(defaults.data.RiverBaitLeft) .. "/" .. tostring(defaults.data.RiverSBaitLeft)
            if defaults.data.GeneralBait >= 1 then
              fishingBaitLeft = fishingBaitLeft .. "/" .. tostring(defaults.data.GeneralBait)
            end
            textLine = textLine + 1
            table.insert(drtv.pinTag, textLine,
              ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFish.textcolorBait)):Colorize(zo_strformat("<<1>>",
                "{" .. fishingBaitLeft .. "}")))
          elseif drtv.pinType == 42 then
            fishingBaitLeft = tostring(defaults.data.OceanBaitLeft) .. "/" .. tostring(defaults.data.OceanSBaitLeft)
            if defaults.data.GeneralBait >= 1 then
              fishingBaitLeft = fishingBaitLeft .. "/" .. tostring(defaults.data.GeneralBait)
            end
            textLine = textLine + 1
            table.insert(drtv.pinTag, textLine,
              ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFish.textcolorBait)):Colorize(zo_strformat("<<1>>",
                "{" .. fishingBaitLeft .. "}")))
          elseif drtv.pinType == 43 then
            fishingBaitLeft = tostring(defaults.data.LakeBaitLeft) .. "/" .. tostring(defaults.data.LakeSBaitLeft)
            if defaults.data.GeneralBait >= 1 then
              fishingBaitLeft = fishingBaitLeft .. "/" .. tostring(defaults.data.GeneralBait)
            end
            textLine = textLine + 1
            table.insert(drtv.pinTag, textLine,
              ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFish.textcolorBait)):Colorize(zo_strformat("<<1>>",
                "{" .. fishingBaitLeft .. "}")))
          end
        end
      end
      if waterType and DestinationsSV.filters[DPINS.FISHING_SHOW_WATER] then
        textLine = textLine + 1
        table.insert(drtv.pinTag, textLine,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFish.textcolorWater)):Colorize(zo_strformat("<<1>>",
            "(" .. waterType .. ")")))
      end
      if countFN >= 1 or countLN >= 1 or countON >= 1 or countRN >= 1 then
        if countF >= 1 or countL >= 1 or countO >= 1 or countR >= 1 then
          LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      end
    end
  end
end
local function FishDonepinTypeCallback()

  local DESTINATIONS_FISH_TYPE_FOUL = 1
  local DESTINATIONS_FISH_TYPE_RIVER = 2
  local DESTINATIONS_FISH_TYPE_OCEAN = 3
  local DESTINATIONS_FISH_TYPE_LAKE = 4

  if GetMapType() >= MAPTYPE_WORLD then return end
  drtv.pinName = DPINS.FISHINGDONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType and drtv.pinType >= 40 and drtv.pinType <= 44 then
      local fishID = pinData[AchIndex.ID]
      local _, requiredTotal = 0, GetAchievementNumCriteria(fishID)
      local desc, completed, required = nil, 0, 0
      local fishingBait, waterType = nil
      if drtv.pinType == 40 then
        fishingBait = GetString(FISHING_FOUL_BAIT)
        waterType = GetString(FISHING_FOUL)
      elseif drtv.pinType == 41 then
        fishingBait = GetString(FISHING_RIVER_BAIT)
        waterType = GetString(FISHING_RIVER)
      elseif drtv.pinType == 42 then
        fishingBait = GetString(FISHING_OCEAN_BAIT)
        waterType = GetString(FISHING_OCEAN)
      elseif drtv.pinType == 43 then
        fishingBait = GetString(FISHING_LAKE_BAIT)
        waterType = GetString(FISHING_LAKE)
      elseif drtv.pinType == 44 then
        waterType = GetString(FISHING_UNKNOWN)
      end
      drtv.pinTag = {}
      local textLine = 0
      local countF, countL, countO, countR = 0, 0, 0, 0
      local countFN, countLN, countON, countRN = 0, 0, 0, 0
      local fishdata = FishStore[fishID]
      local FishName, FishNumber, FishLoc = nil, nil, nil

      for _, pinData in ipairs(fishdata) do
        FishLoc = pinData[FishIndex.LOCATION]
        if FishLoc == DESTINATIONS_FISH_TYPE_FOUL then
          countF = countF + 1
        elseif FishLoc == DESTINATIONS_FISH_TYPE_LAKE then
          countL = countL + 1
        elseif FishLoc == DESTINATIONS_FISH_TYPE_OCEAN then
          countO = countO + 1
        elseif FishLoc == DESTINATIONS_FISH_TYPE_RIVER then
          countR = countR + 1
        end
      end
      if countF >= 1 or countL >= 1 or countO >= 1 or countR >= 1 then
        textLine = textLine + 1
        table.insert(drtv.pinTag, textLine,
          ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFish.textcolortitle)):Colorize(zo_strformat("<<1>>",
            FishIDs[fishID])))
        local FishNumber, FishLoc = nil, nil
        for i = 1, requiredTotal, 1 do
          for _, pinData in ipairs(fishdata) do
            FishLoc = pinData[FishIndex.LOCATION]
            FishNumber = pinData[FishIndex.FISHNUMBER]
            if FishNumber == i then
              _, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 1 then
                if drtv.pinType == 40 and FishLoc == DESTINATIONS_FISH_TYPE_FOUL then
                  countFN = countFN + 1
                elseif drtv.pinType == 41 and FishLoc == DESTINATIONS_FISH_TYPE_RIVER then
                  countRN = countRN + 1
                elseif drtv.pinType == 42 and FishLoc == DESTINATIONS_FISH_TYPE_OCEAN then
                  countON = countON + 1
                elseif drtv.pinType == 43 and FishLoc == DESTINATIONS_FISH_TYPE_LAKE then
                  countLN = countLN + 1
                end
              end
            end
          end
        end
        if DestinationsSV.filters[DPINS.FISHING_SHOW_FISHNAME] then
          for i = 1, requiredTotal, 1 do
            for _, pinData in ipairs(fishdata) do
              FishLoc = pinData[FishIndex.LOCATION]
              FishNumber = pinData[FishIndex.FISHNUMBER]
              if FishNumber == i then
                FishName, completed, _ = GetAchievementCriterion(fishID, i)
                if completed == 1 then
                  local fishFound = false
                  if TYPE == 40 and FishLoc == DESTINATIONS_FISH_TYPE_FOUL then
                    fishFound = true
                  elseif TYPE == 41 and FishLoc == DESTINATIONS_FISH_TYPE_RIVER then
                    fishFound = true
                  elseif TYPE == 42 and FishLoc == DESTINATIONS_FISH_TYPE_OCEAN then
                    fishFound = true
                  elseif TYPE == 43 and FishLoc == DESTINATIONS_FISH_TYPE_LAKE then
                    fishFound = true
                  end
                  if fishFound then
                    textLine = textLine + 1
                    table.insert(tooltipText, textLine,
                      ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFishDone.textcolor)):Colorize(zo_strformat("<<1>>",
                        "[" .. FishName .. "]")))
                    fishFound = false
                  end
                end
              end
            end
          end
        end
        if fishingBait and DestinationsSV.filters[DPINS.FISHING_SHOW_BAIT] then
          textLine = textLine + 1
          table.insert(drtv.pinTag, textLine,
            ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFishDone.textcolorBait)):Colorize(zo_strformat("<<1>>",
              "<" .. fishingBait .. ">")))
        end
        if waterType and DestinationsSV.filters[DPINS.FISHING_SHOW_WATER] then
          textLine = textLine + 1
          table.insert(drtv.pinTag, textLine,
            ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFishDone.textcolorWater)):Colorize(zo_strformat("<<1>>",
              "(" .. waterType .. ")")))
        end
        if (countF >= 1 and countF == countFN) or (countL >= 1 and countL == countLN) or (countO >= 1 and countO == countON) or (countR >= 1 and countR == countRN) then
          LMP:CreatePin(drtv.pinName, drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      end
    end
  end
end

local function AddAchievementCompassPins()

  if GetMapType() >= MAPTYPE_WORLD then return end

  mapData, mapTextureName, zoneTextureName, mapId, zoneId = nil, nil, nil, nil, nil
  if DestinationsCSSV.filters[DPINS.ACHIEVEMENTS_COMPASS] then
    GetMapTextureName()
    mapData = AchStore[mapTextureName]
  end

  if mapData and mapTextureName ~= "ava_whole_0" then
    for _, pinData in ipairs(mapData) do
      drtv.pinType = pinData[AchIndex.TYPE]
      if drtv.pinType == 15 and ((LMP:IsEnabled(DPINS.BREAKING) and DestinationsCSSV.filters[DPINS.BREAKING]) or (LMP:IsEnabled(DPINS.BREAKING_DONE) and DestinationsCSSV.filters[DPINS.BREAKING_DONE])) then
        local NUMBER = tonumber(pinData[AchIndex.KEYCODE])
        local desc, completed, required = GetAchievementCriterion(1250, NUMBER)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(DPINS.BREAKING, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(DPINS.BREAKING_DONE) and DestinationsCSSV.filters[DPINS.BREAKING_DONE] then
          COMPASS_PINS.pinManager:CreatePin(DPINS.BREAKING_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif drtv.pinType == 14 and ((LMP:IsEnabled(DPINS.RELIC_HUNTER) and DestinationsCSSV.filters[DPINS.RELIC_HUNTER]) or (LMP:IsEnabled(DPINS.RELIC_HUNTER_DONE) and DestinationsCSSV.filters[DPINS.RELIC_HUNTER_DONE])) then
        local NUMBER = tonumber(pinData[AchIndex.KEYCODE])
        local desc, completed, required = GetAchievementCriterion(1250, NUMBER)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(DPINS.RELIC_HUNTER, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(DPINS.RELIC_HUNTER_DONE) and DestinationsCSSV.filters[DPINS.RELIC_HUNTER_DONE] then
          COMPASS_PINS.pinManager:CreatePin(DPINS.RELIC_HUNTER_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif drtv.pinType == 12 and ((LMP:IsEnabled(DPINS.WROTHGAR_JUMPER) and DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER]) or (LMP:IsEnabled(DPINS.WROTHGAR_JUMPER_DONE) and DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER_DONE])) then
        local desc, completed, required = GetAchievementCriterion(1331, 1)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(DPINS.WROTHGAR_JUMPER, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(DPINS.WROTHGAR_JUMPER_DONE) and DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER_DONE] then
          COMPASS_PINS.pinManager:CreatePin(DPINS.WROTHGAR_JUMPER_DONE, pinData, pinData[AchIndex.X],
            pinData[AchIndex.Y])
        end
      elseif drtv.pinType == 11 and ((LMP:IsEnabled(DPINS.PATRON) and DestinationsCSSV.filters[DPINS.PATRON]) or (LMP:IsEnabled(DPINS.PATRON_DONE) and DestinationsCSSV.filters[DPINS.PATRON_DONE])) then
        local desc, completed, required = GetAchievementCriterion(1316, 1)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(DPINS.PATRON, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(DPINS.PATRON_DONE) and DestinationsCSSV.filters[DPINS.PATRON_DONE] then
          COMPASS_PINS.pinManager:CreatePin(DPINS.PATRON_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif drtv.pinType == 10 and ((LMP:IsEnabled(DPINS.BRAWL) and DestinationsCSSV.filters[DPINS.BRAWL]) or (LMP:IsEnabled(DPINS.BRAWL_DONE) and DestinationsCSSV.filters[DPINS.BRAWL_DONE])) then
        local desc, completed, required = GetAchievementCriterion(1247, 1)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(DPINS.BRAWL, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(DPINS.BRAWL_DONE) and DestinationsCSSV.filters[DPINS.BRAWL_DONE] then
          COMPASS_PINS.pinManager:CreatePin(DPINS.BRAWL_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif drtv.pinType == 9 and ((LMP:IsEnabled(DPINS.ON_ME) and DestinationsCSSV.filters[DPINS.ON_ME]) or (LMP:IsEnabled(DPINS.ON_ME_DONE) and DestinationsCSSV.filters[DPINS.ON_ME_DONE])) then
        local COMP = ZoneToAchievements[704][zoneTextureName]
        local desc, completed, required = GetAchievementCriterion(704, COMP)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(DPINS.ON_ME, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(DPINS.ON_ME_DONE) and DestinationsCSSV.filters[DPINS.ON_ME_DONE] then
          COMPASS_PINS.pinManager:CreatePin(DPINS.ON_ME_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif drtv.pinType == 8 and ((LMP:IsEnabled(DPINS.EARTHLYPOS) and DestinationsCSSV.filters[DPINS.EARTHLYPOS]) or (LMP:IsEnabled(DPINS.EARTHLYPOS_DONE) and DestinationsCSSV.filters[DPINS.EARTHLYPOS_DONE])) then
        local desc, completed, required = GetAchievementCriterion(1121, 1)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(DPINS.EARTHLYPOS, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(DPINS.EARTHLYPOS_DONE) and DestinationsCSSV.filters[DPINS.EARTHLYPOS_DONE] then
          COMPASS_PINS.pinManager:CreatePin(DPINS.EARTHLYPOS_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif drtv.pinType == 7 and ((LMP:IsEnabled(DPINS.NOSEDIVER) and DestinationsCSSV.filters[DPINS.NOSEDIVER]) or (LMP:IsEnabled(DPINS.NOSEDIVER_DONE) and DestinationsCSSV.filters[DPINS.NOSEDIVER_DONE])) then
        local desc, completed, required = GetAchievementCriterion(406, 1)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(DPINS.NOSEDIVER, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(DPINS.NOSEDIVER_DONE) and DestinationsCSSV.filters[DPINS.NOSEDIVER_DONE] then
          COMPASS_PINS.pinManager:CreatePin(DPINS.NOSEDIVER_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif drtv.pinType == 3 and ((LMP:IsEnabled(DPINS.PEACEMAKER) and DestinationsCSSV.filters[DPINS.PEACEMAKER]) or (LMP:IsEnabled(DPINS.PEACEMAKER_DONE) and DestinationsCSSV.filters[DPINS.PEACEMAKER_DONE])) then
        local desc, completed, required = GetAchievementCriterion(716, 1)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(DPINS.PEACEMAKER, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(DPINS.PEACEMAKER_DONE) and DestinationsCSSV.filters[DPINS.PEACEMAKER_DONE] then
          COMPASS_PINS.pinManager:CreatePin(DPINS.PEACEMAKER_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif drtv.pinType == 2 and ((LMP:IsEnabled(DPINS.LB_GTTP_CP) and DestinationsCSSV.filters[DPINS.LB_GTTP_CP]) or (LMP:IsEnabled(DPINS.LB_GTTP_CP_DONE) and DestinationsCSSV.filters[DPINS.LB_GTTP_CP_DONE])) then
        local COMP = ZoneToAchievements[767167][zoneTextureName]
        local desca, completedLB, requiredLB = GetAchievementCriterion(873, COMP)
        local descb, completedGTTP, requiredGTTP = GetAchievementCriterion(871, COMP)
        local descc, completedCP, requiredCP = GetAchievementCriterion(869, COMP)
        local completed = completedLB + completedGTTP + completedCP
        local required = requiredLB + requiredGTTP + requiredCP
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(DPINS.LB_GTTP_CP, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(DPINS.LB_GTTP_CP_DONE) and DestinationsCSSV.filters[DPINS.LB_GTTP_CP_DONE] then
          COMPASS_PINS.pinManager:CreatePin(DPINS.LB_GTTP_CP_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif drtv.pinType == 1 and ((LMP:IsEnabled(DPINS.MAIQ) and DestinationsCSSV.filters[DPINS.MAIQ]) or (LMP:IsEnabled(DPINS.MAIQ_DONE) and DestinationsCSSV.filters[DPINS.MAIQ_DONE])) then
        local COMP = ZoneToAchievements[872][zoneTextureName]
        local desc, completed, required = GetAchievementCriterion(872, COMP)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(DPINS.MAIQ, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(DPINS.MAIQ_DONE) and DestinationsCSSV.filters[DPINS.MAIQ_DONE] then
          COMPASS_PINS.pinManager:CreatePin(DPINS.MAIQ_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      end
    end
  end
  if DestinationsCSSV.filters[DPINS.CHAMPION] or DestinationsCSSV.filters[DPINS.CHAMPION_DONE] then
    -- TODO: Check if Murkmire zoneTextureName was fixed, it's nil on PTS 4.2.0
    if (zoneTextureName == mapTextureName) and DestinationsSV.settings.ShowDungeonBossesInZones == false then return end
    mapData = DBossStore[mapTextureName]
    if not mapData then return end
    for _, pinData in ipairs(mapData) do
      local CHAMPACH = pinData[DBossIndex.ACH]
      local CHAMPIDX = pinData[DBossIndex.IDX]
      local _, completed, required = GetAchievementCriterion(tonumber(CHAMPACH), tonumber(CHAMPIDX))
      if completed ~= required then
        COMPASS_PINS.pinManager:CreatePin(DPINS.CHAMPION, pinData, pinData[DBossIndex.X], pinData[DBossIndex.Y])
      elseif DestinationsCSSV.filters[DPINS.CHAMPION_DONE] then
        COMPASS_PINS.pinManager:CreatePin(DPINS.CHAMPION_DONE, pinData, pinData[DBossIndex.X], pinData[DBossIndex.Y])
      end
    end
  end
end

local function AddMiscCompassPins()
  -- Ayleid, Werewolf+Shrine, Vampire+Altar, Dwemer
  if GetMapType() >= MAPTYPE_WORLD then return end
  mapData, mapTextureName, zoneTextureName, mapId, zoneId = nil, nil, nil, nil, nil
  GetMapTextureName()
  mapData = AchStore[mapTextureName]
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    drtv.pinType = pinData[AchIndex.TYPE]
    if drtv.pinType == 20 then
      if not LMP:IsEnabled(DPINS.AYLEID) or not DestinationsCSSV.filters[DPINS.MISC_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(DPINS.AYLEID, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    elseif drtv.pinType == 25 then
      if not LMP:IsEnabled(DPINS.DEADLANDS) or not DestinationsCSSV.filters[DPINS.MISC_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(DPINS.DEADLANDS, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    elseif drtv.pinType == 26 then
      if not LMP:IsEnabled(DPINS.HIGHISLE) or not DestinationsCSSV.filters[DPINS.MISC_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(DPINS.HIGHISLE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    elseif drtv.pinType == 21 then
      if not LMP:IsEnabled(DPINS.WWVAMP) or not DestinationsCSSV.filters[DPINS.VWW_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(DPINS.WWVAMP, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    elseif drtv.pinType == 22 then
      if not LMP:IsEnabled(DPINS.VAMPIRE_ALTAR) or not DestinationsCSSV.filters[DPINS.VWW_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(DPINS.VAMPIRE_ALTAR, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    elseif drtv.pinType == 23 then
      if not LMP:IsEnabled(DPINS.DWEMER) or not DestinationsCSSV.filters[DPINS.MISC_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(DPINS.DWEMER, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    elseif drtv.pinType == 24 then
      if not LMP:IsEnabled(DPINS.WEREWOLF_SHRINE) or not DestinationsCSSV.filters[DPINS.VWW_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(DPINS.WEREWOLF_SHRINE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end

local function CollectibleFishCompassPins()
  -- Collectibles, Fishing
  if not LMP:IsEnabled(DPINS.COLLECTIBLES) and not LMP:IsEnabled(DPINS.COLLECTIBLES_DONE) and not LMP:IsEnabled(DPINS.FISHING) and not LMP:IsEnabled(DPINS.FISHING_DONE) then return end
  if not DestinationsCSSV.filters[DPINS.COLLECTIBLES] and not DestinationsCSSV.filters[DPINS.COLLECTIBLES_DONE] and not DestinationsCSSV.filters[DPINS.FISHING] and not DestinationsCSSV.filters[DPINS.FISHING_DONE] then return end
  if GetMapType() >= MAPTYPE_WORLD then return end
  GetMapTextureName()
  if not mapTextureName then return end
  local data = AchStore[mapTextureName]
  if not data then return end
  for _, pinData in ipairs(data) do
    local TYPE = pinData[AchIndex.TYPE]
    if TYPE >= 40 and TYPE <= 44 then
      if not DestinationsCSSV.filters[DPINS.FISHING_COMPASS] or not (LMP:IsEnabled(DPINS.FISHING) and not LMP:IsEnabled(DPINS.FISHING_DONE)) then return end
      local fishID = pinData[AchIndex.ID]
      local _, requiredTotal = 0, GetAchievementNumCriteria(fishID)
      local desc, completed = nil, 0, 0
      local countF, countL, countO, countR = 0, 0, 0, 0
      local countFN, countLN, countON, countRN = 0, 0, 0, 0
      local countFND, countLND, countOND, countRND = 0, 0, 0, 0
      local fishdata = FishStore[fishID]
      local FishName, FishNumber, FishLoc = nil, nil, nil
      for _, pinData in ipairs(fishdata) do
        FishLoc = pinData[FishIndex.LOCATION]
        if FishLoc == DESTINATIONS_FISH_TYPE_FOUL then
          countF = countF + 1
        elseif FishLoc == DESTINATIONS_FISH_TYPE_LAKE then
          countL = countL + 1
        elseif FishLoc == DESTINATIONS_FISH_TYPE_OCEAN then
          countO = countO + 1
        elseif FishLoc == DESTINATIONS_FISH_TYPE_RIVER then
          countR = countR + 1
        end
      end
      for i = 1, requiredTotal, 1 do
        for _, pinData in ipairs(fishdata) do
          FishLoc = pinData[FishIndex.LOCATION]
          FishNumber = pinData[FishIndex.FISHNUMBER]
          if FishNumber == i then
            if TYPE == 40 and FishLoc == DESTINATIONS_FISH_TYPE_FOUL then
              FishName, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 0 then
                countFN = countFN + 1
              else
                countFND = countFND + 1
              end
            elseif TYPE == 41 and FishLoc == DESTINATIONS_FISH_TYPE_RIVER then
              FishName, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 0 then
                countRN = countRN + 1
              else
                countRND = countRND + 1
              end
            elseif TYPE == 42 and FishLoc == DESTINATIONS_FISH_TYPE_OCEAN then
              FishName, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 0 then
                countON = countON + 1
              else
                countOND = countOND + 1
              end
            elseif TYPE == 43 and FishLoc == DESTINATIONS_FISH_TYPE_LAKE then
              FishName, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 0 then
                countLN = countLN + 1
              else
                countLND = countLND + 1
              end
            end
          end
        end
      end
      if (countFN >= 1 and countF >= 1 and countF ~= countFND) or (countLN >= 1 and countL >= 1 and countL ~= countLND) or (countON >= 1 and countO >= 1 and countO ~= countOND) or (countRN >= 1 and countR >= 1 and countR ~= countRND) then
        COMPASS_PINS.pinManager:CreatePin(DPINS.FISHING, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
      elseif DestinationsCSSV.filters[DPINS.FISHINGDONE] == true then
        COMPASS_PINS.pinManager:CreatePin(DPINS.FISHINGDONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    elseif TYPE == 30 then
      if not DestinationsCSSV.filters[DPINS.COLLECTIBLES_COMPASS] or not (LMP:IsEnabled(DPINS.COLLECTIBLES) and not LMP:IsEnabled(DPINS.COLLECTIBLES_DONE)) then return end
      local collectibleID = pinData[AchIndex.ID]
      local _, requiredTotal = 0, GetAchievementNumCriteria(collectibleID)
      local completed = 0
      local collectibleNumber = nil
      local collectibledata = CollectibleStore[collectibleID]
      local collectibleCode = pinData[AchIndex.KEYCODE]
      local countCN = 0
      for i = 1, requiredTotal, 1 do
        for _, pinData in ipairs(collectibledata) do
          collectibleNumber = pinData[CollectibleIndex.NUMBER]
          if collectibleNumber == i and string.find(collectibleCode, i) then
            _, completed, _ = GetAchievementCriterion(collectibleID, i)
            if completed == 1 then
              countCN = countCN + 1
            end
          end
        end
      end
      if (countCN == 0) then
        COMPASS_PINS.pinManager:CreatePin(DPINS.COLLECTIBLES, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
      elseif DestinationsCSSV.filters[DPINS.COLLECTIBLESDONE] == true then
        COMPASS_PINS.pinManager:CreatePin(DPINS.COLLECTIBLESDONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end

-- Refresh all achievement map and compass pins
local function RedrawAllAchievementPins()
  for _, pinName in pairs(drtv.AchPins) do
    LMP:RefreshPins(DPINS[pinName])
    COMPASS_PINS:RefreshPins(DPINS[pinName])
    pinName = pinName .. "_DONE"
    LMP:RefreshPins(DPINS[pinName])
    COMPASS_PINS:RefreshPins(DPINS[pinName])
  end
end

-- Because game for a specific MapDisplayPinType can have multiple textures.

local function GetDestinationKnownPOITexture(poiTypeId)

  local mapPinTypeCorrespondance = {
    [DESTINATIONS_PIN_TYPE_AOI] = "/esoui/art/icons/poi/poi_areaofinterest_complete.dds",
    [DESTINATIONS_PIN_TYPE_AYLEIDRUIN] = "/esoui/art/icons/poi/poi_ayleidruin_complete.dds",
    [DESTINATIONS_PIN_TYPE_BATTLEFIELD] = "/esoui/art/icons/poi/poi_battlefield_complete.dds",
    [DESTINATIONS_PIN_TYPE_CAMP] = "/esoui/art/icons/poi/poi_camp_complete.dds",
    [DESTINATIONS_PIN_TYPE_CAVE] = "/esoui/art/icons/poi/poi_cave_complete.dds",
    [DESTINATIONS_PIN_TYPE_CEMETERY] = "/esoui/art/icons/poi/poi_cemetery_complete.dds",
    [DESTINATIONS_PIN_TYPE_CITY] = "/esoui/art/icons/poi/poi_city_complete.dds",
    [DESTINATIONS_PIN_TYPE_CRAFTING] = "/esoui/art/icons/poi/poi_crafting_complete.dds",
    [DESTINATIONS_PIN_TYPE_CRYPT] = "/esoui/art/icons/poi/poi_crypt_complete.dds",
    [DESTINATIONS_PIN_TYPE_DAEDRICRUIN] = "/esoui/art/icons/poi/poi_daedricruin_complete.dds",
    [DESTINATIONS_PIN_TYPE_DELVE] = "/esoui/art/icons/poi/poi_delve_complete.dds",
    [DESTINATIONS_PIN_TYPE_DOCK] = "/esoui/art/icons/poi/poi_dock_complete.dds",
    [DESTINATIONS_PIN_TYPE_DUNGEON] = "/esoui/art/icons/poi/poi_dungeon_complete.dds",
    [DESTINATIONS_PIN_TYPE_DWEMERRUIN] = "/esoui/art/icons/poi/poi_dwemerruin_complete.dds",
    [DESTINATIONS_PIN_TYPE_ESTATE] = "/esoui/art/icons/poi/poi_estate_complete.dds",
    [DESTINATIONS_PIN_TYPE_FARM] = "/esoui/art/icons/poi/poi_farm_complete.dds",
    [DESTINATIONS_PIN_TYPE_GATE] = "/esoui/art/icons/poi/poi_gate_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPBOSS] = "/esoui/art/icons/poi/poi_groupboss_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPDELVE] = "/esoui/art/icons/poi/poi_groupdelve_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPINSTANCE] = "/esoui/art/icons/poi/poi_groupinstance_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROVE] = "/esoui/art/icons/poi/poi_grove_complete.dds",
    [DESTINATIONS_PIN_TYPE_KEEP] = "/esoui/art/icons/poi/poi_keep_complete.dds",
    [DESTINATIONS_PIN_TYPE_LIGHTHOUSE] = "/esoui/art/icons/poi/poi_lighthouse_complete.dds",
    [DESTINATIONS_PIN_TYPE_MINE] = "/esoui/art/icons/poi/poi_mine_complete.dds",
    [DESTINATIONS_PIN_TYPE_MUNDUS] = "/esoui/art/icons/poi/poi_mundus_complete.dds",
    [DESTINATIONS_PIN_TYPE_PORTAL] = "/esoui/art/icons/poi/poi_portal_complete.dds",
    [DESTINATIONS_PIN_TYPE_RAIDDUNGEON] = "/esoui/art/icons/poi/poi_raiddungeon_complete.dds",
    [DESTINATIONS_PIN_TYPE_RUIN] = "/esoui/art/icons/poi/poi_ruin_complete.dds",
    [DESTINATIONS_PIN_TYPE_SEWER] = "/esoui/art/icons/poi/poi_sewer_complete.dds",
    [DESTINATIONS_PIN_TYPE_SOLOTRIAL] = "/esoui/art/icons/poi/poi_solotrial_complete.dds",
    [DESTINATIONS_PIN_TYPE_TOWER] = "/esoui/art/icons/poi/poi_tower_complete.dds",
    [DESTINATIONS_PIN_TYPE_TOWN] = "/esoui/art/icons/poi/poi_town_complete.dds",
    [DESTINATIONS_PIN_TYPE_WAYSHRINE] = "/esoui/art/icons/poi/poi_wayshrine_complete.dds",
    [DESTINATIONS_PIN_TYPE_GUILDKIOSK] = "/esoui/art/icons/servicemappins/servicepin_guildkiosk.dds",
    [DESTINATIONS_PIN_TYPE_PLANARARMORSCRAPS] = "/esoui/art/icons/poi/poi_ic_planararmorscraps_complete.dds",
    [DESTINATIONS_PIN_TYPE_TINYCLAW] = "/esoui/art/icons/poi/poi_ic_tinyclaw_complete.dds",
    [DESTINATIONS_PIN_TYPE_MONSTROUSTEETH] = "/esoui/art/icons/poi/poi_ic_monstrousteeth_complete.dds",
    [DESTINATIONS_PIN_TYPE_BONESHARD] = "/esoui/art/icons/poi/poi_ic_boneshard_complete.dds",
    [DESTINATIONS_PIN_TYPE_MARKLEGION] = "/esoui/art/icons/poi/poi_ic_marklegion_complete.dds",
    [DESTINATIONS_PIN_TYPE_DARKETHER] = "/esoui/art/icons/poi/poi_ic_darkether_complete.dds",
    [DESTINATIONS_PIN_TYPE_DARKBROTHERHOOD] = "/esoui/art/icons/poi/poi_darkbrotherhood_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPLIGHTHOUSE] = "/esoui/art/icons/poi/poi_group_lighthouse_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPESTATE] = "/esoui/art/icons/poi/poi_group_estate_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPRUIN] = "/esoui/art/icons/poi/poi_group_ruin_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPCAVE] = "/esoui/art/icons/poi/poi_group_cave_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPCEMETERY] = "/esoui/art/icons/poi/poi_group_cemetery_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPKEEP] = "/esoui/art/icons/poi/poi_group_keep_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPAREAOFINTEREST] = "/esoui/art/icons/poi/poi_group_areaofinterest_complete.dds",
    [DESTINATIONS_PIN_TYPE_HOUSING] = "/esoui/art/icons/poi/poi_group_house_owned.dds",
    [DESTINATIONS_PIN_TYPE_DWEMERGEAR] = "/esoui/art/icons/poi/poi_u26_dwemergear_complete.dds",
    [DESTINATIONS_PIN_TYPE_NORDBOAT] = "/esoui/art/icons/poi/poi_u26_nord_boat_complete.dds",
    [DESTINATIONS_PIN_TYPE_UNKNOWN] = "Destinations/pins/poi_unknown_pintype.dds",
  }

  if poiTypeId and mapPinTypeCorrespondance[poiTypeId] then
    return mapPinTypeCorrespondance[poiTypeId]
  end

  return mapPinTypeCorrespondance[DESTINATIONS_PIN_TYPE_UNKNOWN]

end

local function GetDestinationUnknownPOITexture(poiTypeId)

  local mapPinTypeCorrespondance = {
    [DESTINATIONS_PIN_TYPE_AOI] = "/esoui/art/icons/poi/poi_areaofinterest_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_AYLEIDRUIN] = "/esoui/art/icons/poi/poi_ayleidruin_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_BATTLEFIELD] = "/esoui/art/icons/poi/poi_battlefield_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_CAMP] = "/esoui/art/icons/poi/poi_camp_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_CAVE] = "/esoui/art/icons/poi/poi_cave_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_CEMETERY] = "/esoui/art/icons/poi/poi_cemetery_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_CITY] = "/esoui/art/icons/poi/poi_city_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_CRAFTING] = "/esoui/art/icons/poi/poi_crafting_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_CRYPT] = "/esoui/art/icons/poi/poi_crypt_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_DAEDRICRUIN] = "/esoui/art/icons/poi/poi_daedricruin_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_DELVE] = "/esoui/art/icons/poi/poi_delve_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_DOCK] = "/esoui/art/icons/poi/poi_dock_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_DUNGEON] = "/esoui/art/icons/poi/poi_dungeon_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_DWEMERRUIN] = "/esoui/art/icons/poi/poi_dwemerruin_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_ESTATE] = "/esoui/art/icons/poi/poi_estate_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_FARM] = "/esoui/art/icons/poi/poi_farm_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_GATE] = "/esoui/art/icons/poi/poi_gate_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPBOSS] = "/esoui/art/icons/poi/poi_groupboss_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPDELVE] = "/esoui/art/icons/poi/poi_groupdelve_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPINSTANCE] = "/esoui/art/icons/poi/poi_groupinstance_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_GROVE] = "/esoui/art/icons/poi/poi_grove_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_KEEP] = "/esoui/art/icons/poi/poi_keep_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_LIGHTHOUSE] = "/esoui/art/icons/poi/poi_lighthouse_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_MINE] = "/esoui/art/icons/poi/poi_mine_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_MUNDUS] = "/esoui/art/icons/poi/poi_mundus_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_PORTAL] = "/esoui/art/icons/poi/poi_portal_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_RAIDDUNGEON] = "/esoui/art/icons/poi/poi_raiddungeon_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_RUIN] = "/esoui/art/icons/poi/poi_ruin_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_SEWER] = "/esoui/art/icons/poi/poi_sewer_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_SOLOTRIAL] = "/esoui/art/icons/poi/poi_solotrial_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_TOWER] = "/esoui/art/icons/poi/poi_tower_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_TOWN] = "/esoui/art/icons/poi/poi_town_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_WAYSHRINE] = "/esoui/art/icons/poi/poi_wayshrine_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_GUILDKIOSK] = "/esoui/art/icons/servicemappins/servicepin_guildkiosk.dds",
    [DESTINATIONS_PIN_TYPE_PLANARARMORSCRAPS] = "/esoui/art/icons/poi/poi_ic_planararmorscraps_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_TINYCLAW] = "/esoui/art/icons/poi/poi_ic_tinyclaw_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_MONSTROUSTEETH] = "/esoui/art/icons/poi/poi_ic_monstrousteeth_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_BONESHARD] = "/esoui/art/icons/poi/poi_ic_boneshard_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_MARKLEGION] = "/esoui/art/icons/poi/poi_ic_marklegion_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_DARKETHER] = "/esoui/art/icons/poi/poi_ic_darkether_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_DARKBROTHERHOOD] = "/esoui/art/icons/poi/poi_darkbrotherhood_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPLIGHTHOUSE] = "/esoui/art/icons/poi/poi_group_lighthouse_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPESTATE] = "/esoui/art/icons/poi/poi_group_estate_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPRUIN] = "/esoui/art/icons/poi/poi_group_ruin_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPCAVE] = "/esoui/art/icons/poi/poi_group_cave_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPCEMETERY] = "/esoui/art/icons/poi/poi_group_cemetery_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPKEEP] = "/esoui/art/icons/poi/poi_group_keep_complete.dds",
    [DESTINATIONS_PIN_TYPE_GROUPAREAOFINTEREST] = "/esoui/art/icons/poi/poi_group_areaofinterest_complete.dds",
    [DESTINATIONS_PIN_TYPE_HOUSING] = "/esoui/art/icons/poi/poi_group_house_unowned.dds",
    [DESTINATIONS_PIN_TYPE_DWEMERGEAR] = "/esoui/art/icons/poi/poi_u26_dwemergear_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_NORDBOAT] = "/esoui/art/icons/poi/poi_u26_nord_boat_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_UNKNOWN] = "Destinations/pins/poi_unknown_pintype.dds",
  }

  if poiTypeId and mapPinTypeCorrespondance[poiTypeId] then
    return mapPinTypeCorrespondance[poiTypeId]
  end

  return mapPinTypeCorrespondance[DESTINATIONS_PIN_TYPE_UNKNOWN]

end

local function InitializeSetDescription()

  for setIndex, setData in ipairs(SetsStore) do

    local itemLink = ("|H1:item:%d:370:50:0:0:0:0:0:0:0:0:0:0:0:0:1:0:0:0:10000:0|h|h"):format(setData[1])
    local _, setName, numBonuses = GetItemLinkSetInfo(itemLink)

    local setRequirement = zo_strformat(DEST_SET_REQUIREMENT, setData[2])
    local setBonuses = ""

    local numRequired, bonusDescription
    for bonusIndex = 1, numBonuses do
      numRequired, bonusDescription = GetItemLinkSetBonusInfo(itemLink, false, bonusIndex)
      setBonuses = setBonuses .. bonusDescription .. "\n"
    end

    local setHeader = zo_strformat(SI_ITEM_FORMAT_STR_SET_NAME, setName, numRequired, numRequired)

    setBonuses = string.sub(setBonuses, 1, -2)
    destinationsSetsData[setIndex] = { setHeader, setRequirement, setBonuses }

  end

end

local function GetSetDescription(setId)
  return destinationsSetsData[setId]
end

-- /script d(GetZoneId(GetCurrentMapZoneIndex())) _zoneId_ 823
-- /script d(GetCurrentMapZoneIndex()) _zoneIndex_ 448
-- /script d(GetCurrentMapId()) _mapId_ 1006
-- mapTextureName, zoneTextureName

local function MapCallback_fakeKnown()

  if GetMapType() >= MAPTYPE_WORLD then return end

  mapData, mapTextureName, zoneTextureName, mapId, zoneId = nil, nil, nil, nil, nil
  GetMapTextureName()
  mapData = POIsStore[GetZoneId(GetCurrentMapZoneIndex())]

  local zoneIndex = GetCurrentMapZoneIndex()

  if not mapData then
    mapData = { ["zoneName"] = "unknown zone" }
  end
  for poiIndex = 1, GetNumPOIs(zoneIndex) do
    if not mapData[poiIndex] then
      mapData[poiIndex] = { n = "unknown " .. poiIndex, t = DESTINATIONS_PIN_TYPE_UNKNOWN }
    end
  end

  for poiIndex = 1, GetNumPOIs(zoneIndex) do

    local normalizedX, normalizedY, poiPinType, icon, isShownInCurrentMap, linkedCollectibleIsLocked, isDiscovered, isNearby = GetPOIMapInfo(zoneIndex,
      poiIndex)
    local unknown = not (isDiscovered or isNearby)
    local seen = isDiscovered

    if not unknown and mapData[poiIndex] then

      local destinationsPinType = mapData[poiIndex].t

      if destinationsPinType == DESTINATIONS_PIN_TYPE_MUNDUS or destinationsPinType == DESTINATIONS_PIN_TYPE_CRAFTING then

        local englishName = mapData[poiIndex].n
        local objectiveName = zo_strformat(SI_WORLD_MAP_LOCATION_NAME, GetPOIInfo(zoneIndex, poiIndex))

        local pinTag = {
          newFormat = true,
          objectiveName = objectiveName,
          englishName = englishName,
        }

        -- IC icons don't have same meaning than standard ones
        if mapTextureName == "imperialcity_base_0" then
          pinTag.poiTypeName = GetICPoiTypeName(destinationsPinType)
        else
          pinTag.poiTypeName = GetPoiTypeName(destinationsPinType)
        end

        -- some destinationsPinType should display some extra info
        pinTag.destinationsPinType = destinationsPinType

        local createPin
        if pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_MUNDUS and DestinationsSV.settings.ImproveMundus then
          createPin = true
          pinTag.special = MundusStore[mapData[poiIndex].s]
        elseif pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_CRAFTING and DestinationsSV.settings.ImproveCrafting then
          createPin = true
          pinTag.special = GetSetDescription(mapData[poiIndex].s)
          local r1, g1, b1 = ZO_SELECTED_TEXT:UnpackRGB()
          local r2, g2, b2 = ZO_HIGHLIGHT_TEXT:UnpackRGB()
          pinTag.multipleFormat = {
            k = {
              [1] = { "ZoFontWinT2", r1, g1, b1, TOPLEFT, MODIFY_TEXT_TYPE_UPPERCASE, TEXT_ALIGN_CENTER, true },
              [2] = { "", r2, g2, b2, TOPLEFT, MODIFY_TEXT_TYPE_NONE, TEXT_ALIGN_CENTER, true },
              [3] = { "", r2, g2, b2, TOPLEFT, MODIFY_TEXT_TYPE_NONE, TEXT_ALIGN_CENTER, true },
            },
            g = {
              [1] = { fontSize = 27, fontColorField = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_1 },
              [2] = { fontSize = 24, fontColorField = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_3 },
              [3] = { fontSize = 24, fontColorField = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_3 },
            },
          }
        end

        if createPin then
          if seen then
            pinTag.texture = GetDestinationUnknownPOITexture(destinationsPinType)
          else
            pinTag.texture = GetDestinationKnownPOITexture(destinationsPinType)
          end

          LMP:CreatePin(DPINS.FAKEKNOWN, pinTag, normalizedX, normalizedY)
        end

      end
    end
  end

end

local function MapCallback_unknown()

  if GetMapType() >= MAPTYPE_WORLD then return end

  drtv.pinName = DPINS.UNKNOWN

  mapData, mapTextureName, zoneTextureName, mapId, zoneId = nil, nil, nil, nil, nil
  if LMP:IsEnabled(drtv.pinName) and DestinationsCSSV.filters[drtv.pinName] then
    GetMapTextureName()
    mapData = POIsStore[GetZoneId(GetCurrentMapZoneIndex())]
  end

  local zoneIndex = GetCurrentMapZoneIndex()

  if not mapData then
    mapData = { ["zoneName"] = "unknown zone" }
  end
  for poiIndex = 1, GetNumPOIs(zoneIndex) do
    if not mapData[poiIndex] then
      mapData[poiIndex] = { n = "unknown " .. poiIndex, t = DESTINATIONS_PIN_TYPE_UNKNOWN }
    end
  end

  for poiIndex = 1, GetNumPOIs(zoneIndex) do

    local normalizedX, normalizedY, poiPinType, icon, isShownInCurrentMap, linkedCollectibleIsLocked, isDiscovered, isNearby = GetPOIMapInfo(zoneIndex,
      poiIndex)
    local unknown = not (isDiscovered or isNearby)

    if unknown and mapData[poiIndex] then

      local englishName = mapData[poiIndex].n
      local destinationsPinType = mapData[poiIndex].t
      local objectiveName = zo_strformat(SI_WORLD_MAP_LOCATION_NAME, GetPOIInfo(zoneIndex, poiIndex))

      local pinTag = {
        newFormat = true,
        objectiveName = objectiveName,
        englishName = englishName,
      }

      -- IC icons don't have same meaning than standard ones
      if mapTextureName == "imperialcity_base_0" then
        pinTag.poiTypeName = GetICPoiTypeName(destinationsPinType)
      else
        pinTag.poiTypeName = GetPoiTypeName(destinationsPinType)
      end

      --Future usage
      pinTag.destinationsPinType = destinationsPinType

      -- some destinationsPinType should display some extra info
      if pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_MUNDUS then
        pinTag.special = GetAbilityDescription(mapData[poiIndex].s)
      elseif pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_CRAFTING then
        pinTag.special = GetSetDescription(mapData[poiIndex].s)
        local r1, g1, b1 = ZO_SELECTED_TEXT:UnpackRGB()
        local r2, g2, b2 = ZO_HIGHLIGHT_TEXT:UnpackRGB()
        pinTag.multipleFormat = {
          k = {
            [1] = { "ZoFontWinT2", r1, g1, b1, TOPLEFT, MODIFY_TEXT_TYPE_UPPERCASE, TEXT_ALIGN_CENTER, true },
            [2] = { "", r2, g2, b2, TOPLEFT, MODIFY_TEXT_TYPE_NONE, TEXT_ALIGN_CENTER, true },
            [3] = { "", r2, g2, b2, TOPLEFT, MODIFY_TEXT_TYPE_NONE, TEXT_ALIGN_CENTER, true },
          },
          g = {
            [1] = { fontSize = 27, fontColorField = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_1 },
            [2] = { fontSize = 24, fontColorField = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_3 },
            [3] = { fontSize = 24, fontColorField = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_3 },
          },
        }
      end

      if DestinationsSV.pins.pinTextureUnknown.type == 7 then
        pinTag.texture = GetDestinationUnknownPOITexture(destinationsPinType)
      else
        pinTag.texture = pinTextures.paths.Unknown[DestinationsSV.pins.pinTextureUnknown.type]
      end

      LMP:CreatePin(DPINS.UNKNOWN, pinTag, normalizedX, normalizedY)

    end
  end
end

local function FormatCoords(number)
  return ("%05.04f"):format(zo_round(number * 10000) / 10000)
end

SLASH_COMMANDS["/dhlp"] = function()
  --Show help
  Destinations:dm("Info", GetString(DESTCOMMANDS))
  Destinations:dm("Info", GetString(DESTCOMMANDdhlp))
  Destinations:dm("Info", GetString(DESTCOMMANDdset))
end
SLASH_COMMANDS["/dgac"] = function()
  --Get All Achievements (to saved vars)
  Destinations:dm("Info", "Saving all achievements...")
  local achId = nil
  local achName = nil
  local achType
  for i = 1, 5000 do
    achId = i
    achName, achType, _, _, _, _, _ = GetAchievementInfo(achId)
    if string.len(achName) >= 3 then
      DestinationsSV.TEMPPINDATA[achId] = "\v" .. achName .. "\v"
    end
  end
  Destinations:dm("Info", "Done...")
end
SLASH_COMMANDS["/dgap"] = function()
  --Get All POI's (to saved vars)
  Destinations:dm("Info", "Saving all POI's...")
  local zoneIndex = GetCurrentMapZoneIndex()
  local currentMapId = GetZoneId(zoneIndex)
  if Destinations_Settings.pointsOfIntrest == nil then Destinations_Settings.pointsOfIntrest = {} end
  if Destinations_Settings.pointsOfIntrest[currentMapId] == nil then Destinations_Settings.pointsOfIntrest[currentMapId] = {} end
  Destinations_Settings.pointsOfIntrest[currentMapId] = {}
  local saveData = Destinations_Settings.pointsOfIntrest[currentMapId]
  if zoneIndex then
    for i = 1, GetNumPOIs(zoneIndex) do
      local objectiveName, objectiveLevel, startDescription, finishedDescription = GetPOIInfo(zoneIndex, i)
      local normalizedX, normalizedY, poiPinType, objectiveIcon, _, _, _, _ = GetPOIMapInfo(zoneIndex, i)
      local poiTypeId = 99
      if objectiveName then
        local POIno = tostring(i)
        if string.len(POIno) == 1 then
          POIno = "0" .. POIno
        end
        local objectiveString = "{ n = 0x22%s0x22, t = %s },"
        saveData[POIno] = string.format(objectiveString, objectiveName, objectiveIcon)
        Destinations:dm("Info", tostring(POIno) .. ": " .. objectiveName)
        if string.find(objectiveIcon, "/esoui/art/icons/poi/") then
          objectiveIcon = string.gsub(objectiveIcon, "/esoui/art/icons/poi/", "")
        end
        Destinations:dm("Info", tostring(POIno) .. ": " .. objectiveIcon)
      end
    end
    Destinations:dm("Info", "Done...")
  else
    Destinations:dm("Info", "No data to save...")
  end
end

SLASH_COMMANDS["/dsav"] = function(...)
  --Save coords data
  local param = select(1, ...)
  if (param ~= nil and param ~= "") then
    local cmdparam = nil
    if (param == "ff") then
      Destinations:dm("Info", "Saving Foul Water Fishing Spot.")
      cmdparam = 40
    elseif (param == "fr") then
      Destinations:dm("Info", "Saving River Fishing Spot.")
      cmdparam = 41
    elseif (param == "fo") then
      Destinations:dm("Info", "Saving Ocean Fishing Spot.")
      cmdparam = 42
    elseif (param == "fl") then
      Destinations:dm("Info", "Saving Lake Fishing Spot.")
      cmdparam = 43
    elseif (string.sub(param, 0, 2) == "co") and (string.len(param) >= 5) then
      Destinations:dm("Info", "Saving Collectible Spot.")
      cmdparam = 100
    elseif (param == "-h") then
      Destinations:dm("Info", "Write /dsav <param>")
      Destinations:dm("Info", "The following parameters can be used:")
      Destinations:dm("Info", "co* > saves Collectible spot")
      Destinations:dm("Info", "replace the * with the mob name")
      Destinations:dm("Info", "like: /dsav coMudcrab")
      Destinations:dm("Info", "ff > saves Foul Fishing spot")
      Destinations:dm("Info", "fr > saves River Fishing spot")
      Destinations:dm("Info", "fo > saves Ocean Fishing spot")
      Destinations:dm("Info", "fl > saves Lake Fishing spot")
      Destinations:dm("Info", "-h > Shows this help text.")
      Destinations:dm("Info", "Example: /dsav ff")
      cmdparam = nil
    else
      Destinations:dm("Info", "Unknown parameter!")
      Destinations:dm("Info", "Write /dsav -h for help.")
      cmdparam = nil
    end
    if cmdparam then
      GetMapTextureName()
      if not mapTextureName then return end
      local mapNumber = 1
      local coordData, mapName = {}, {}
      local xtra1, xtra2, xtra3, xtra4, xtra5, xtra6, xtra7 = " ", " ", " ", " ", " ", " ", " "
      if cmdparam >= 40 and cmdparam <= 43 then
        xtra1 = FishLocs[zoneTextureName]
        xtra2 = 1
        xtra3 = "X"
      elseif cmdparam == 100 then
        cmdparam = "\\dq" .. string.sub(param, 3) .. "\\dq"
      end
      SetMapToPlayerLocation()
      while (GetMapContentType() == MAP_CONTENT_DUNGEON) or (GetMapType() == MAPTYPE_SUBZONE) or (GetMapType() == MAPTYPE_ZONE) do
        GetMapTextureName()
        if mapTextureName then
          mapName[mapNumber] = mapTextureName
          mapX, mapY = GetMapPlayerPosition("player")
          coordData[mapNumber] = mapName[mapNumber] .. "{" .. FormatCoords(mapX) .. ", " .. FormatCoords(mapY) .. ",\\t" .. cmdparam .. ",\\t" .. xtra1 .. ",\\t" .. xtra2 .. ",\\t" .. xtra3 .. ",\\t" .. xtra4 .. ",\\t" .. xtra5 .. ",\\t" .. xtra6 .. ",\\t" .. xtra7 .. "},"
          mapNumber = mapNumber + 1
          MapZoomOut()
        end
      end
    end
  else
    Destinations:dm("Info", "Missing parameter!")
    Destinations:dm("Info", "Write /dsav -h for help.")
  end
end

--On changing LayoutKeys on unknown pins (size and layer)
local function SetUnknownDestLayoutKey(value, newvalue)
  LMP:SetLayoutKey(DPINS.UNKNOWN, value, newvalue)
end

--On "EVENT_POI_UPDATED" redraw map pins
local function OnPOIUpdated()
  LMP:RefreshPins(DPINS.UNKNOWN)
  LMP:RefreshPins(DPINS.FAKEKNOWN)
end

local function InitVariables()

  playerAlliance = GetUnitAlliance("player")
  DestinationsCSSV.settings.activateReloaduiButton = false

  for _, pinName in pairs(drtv.AchPinTex) do
    if DestinationsSV.pins.pinTextureOther.maxDistance then
      if not DestinationsSV.pins[pinName].maxDistance then DestinationsSV.pins[pinName].maxDistance = DestinationsSV.pins.pinTextureOther.maxDistance end
      if not DestinationsSV.pins[pinName].level then DestinationsSV.pins[pinName].level = DestinationsSV.pins.pinTextureOther.level end
      if not DestinationsSV.pins[pinName].tint then DestinationsSV.pins[pinName].tint = DestinationsSV.pins.pinTextureOther.tint end
      if not DestinationsSV.pins[pinName].textcolor then DestinationsSV.pins[pinName].textcolor = DestinationsSV.pins.pinTextureOther.textcolor end
    else
      if not DestinationsSV.pins[pinName].maxDistance then DestinationsSV.pins[pinName].maxDistance = defaults.pins.pinTextureOther.maxDistance end
      if not DestinationsSV.pins[pinName].level then DestinationsSV.pins[pinName].level = defaults.pins.pinTextureOther.level end
      if not DestinationsSV.pins[pinName].tint then DestinationsSV.pins[pinName].tint = defaults.pins.pinTextureOther.tint end
      if not DestinationsSV.pins[pinName].textcolor then DestinationsSV.pins[pinName].textcolor = defaults.pins.pinTextureOther.textcolor end
    end
    if not DestinationsSV.pins[pinName].type then DestinationsSV.pins[pinName].type = defaults.pins[pinName].type end
    if not DestinationsSV.pins[pinName].size then DestinationsSV.pins[pinName].size = defaults.pins[pinName].size end
    pinName = pinName .. "Done"
    if DestinationsSV.pins.pinTextureOtherDone.maxDistance then
      if not DestinationsSV.pins[pinName].maxDistance then DestinationsSV.pins[pinName].maxDistance = DestinationsSV.pins.pinTextureOtherDone.maxDistance end
      if not DestinationsSV.pins[pinName].level then DestinationsSV.pins[pinName].level = DestinationsSV.pins.pinTextureOtherDone.level end
      if not DestinationsSV.pins[pinName].tint then DestinationsSV.pins[pinName].tint = DestinationsSV.pins.pinTextureOtherDone.tint end
      if not DestinationsSV.pins[pinName].textcolor then DestinationsSV.pins[pinName].textcolor = DestinationsSV.pins.pinTextureOtherDone.textcolor end
    else
      if not DestinationsSV.pins[pinName].maxDistance then DestinationsSV.pins[pinName].maxDistance = defaults.pins.pinTextureOtherDone.maxDistance end
      if not DestinationsSV.pins[pinName].level then DestinationsSV.pins[pinName].level = defaults.pins.pinTextureOtherDone.level end
      if not DestinationsSV.pins[pinName].tint then DestinationsSV.pins[pinName].tint = defaults.pins.pinTextureOtherDone.tint end
      if not DestinationsSV.pins[pinName].textcolor then DestinationsSV.pins[pinName].textcolor = defaults.pins.pinTextureOtherDone.textcolor end
    end
    if not DestinationsSV.pins[pinName].type then DestinationsSV.pins[pinName].type = defaults.pins[pinName].type end
    if not DestinationsSV.pins[pinName].size then DestinationsSV.pins[pinName].size = defaults.pins[pinName].size end
  end

  if not DestinationsSV.pins.pinTextureAyleid.maxDistance then DestinationsSV.pins.pinTextureAyleid.maxDistance = defaults.pins.pinTextureAyleid.maxDistance end
  if not DestinationsSV.pins.pinTextureAyleid.type then DestinationsSV.pins.pinTextureAyleid.type = defaults.pins.pinTextureAyleid.type end
  if not DestinationsSV.pins.pinTextureAyleid.level then DestinationsSV.pins.pinTextureAyleid.level = defaults.pins.pinTextureAyleid.level end
  if not DestinationsSV.pins.pinTextureAyleid.size then DestinationsSV.pins.pinTextureAyleid.size = defaults.pins.pinTextureAyleid.size end
  if not DestinationsSV.pins.pinTextureAyleid.tint then DestinationsSV.pins.pinTextureAyleid.tint = defaults.pins.pinTextureAyleid.tint end
  if not DestinationsSV.pins.pinTextureAyleid.textcolor then DestinationsSV.pins.pinTextureAyleid.textcolor = defaults.pins.pinTextureAyleid.textcolor end

  if not DestinationsSV.pins.pinTextureDwemer.maxDistance then DestinationsSV.pins.pinTextureDwemer.maxDistance = defaults.pins.pinTextureDwemer.maxDistance end
  if not DestinationsSV.pins.pinTextureDwemer.type then DestinationsSV.pins.pinTextureDwemer.type = defaults.pins.pinTextureDwemer.type end
  if not DestinationsSV.pins.pinTextureDwemer.level then DestinationsSV.pins.pinTextureDwemer.level = defaults.pins.pinTextureDwemer.level end
  if not DestinationsSV.pins.pinTextureDwemer.size then DestinationsSV.pins.pinTextureDwemer.size = defaults.pins.pinTextureDwemer.size end
  if not DestinationsSV.pins.pinTextureDwemer.tint then DestinationsSV.pins.pinTextureDwemer.tint = defaults.pins.pinTextureDwemer.tint end
  if not DestinationsSV.pins.pinTextureDwemer.textcolor then DestinationsSV.pins.pinTextureDwemer.textcolor = defaults.pins.pinTextureDwemer.textcolor end

  if not DestinationsSV.pins.pinTextureWWVamp.maxDistance then DestinationsSV.pins.pinTextureWWVamp.maxDistance = defaults.pins.pinTextureWWVamp.maxDistance end
  if not DestinationsSV.pins.pinTextureWWVamp.type then DestinationsSV.pins.pinTextureWWVamp.type = defaults.pins.pinTextureWWVamp.type end
  if not DestinationsSV.pins.pinTextureWWVamp.level then DestinationsSV.pins.pinTextureWWVamp.level = defaults.pins.pinTextureWWVamp.level end
  if not DestinationsSV.pins.pinTextureWWVamp.size then DestinationsSV.pins.pinTextureWWVamp.size = defaults.pins.pinTextureWWVamp.size end
  if not DestinationsSV.pins.pinTextureWWVamp.tint then DestinationsSV.pins.pinTextureWWVamp.tint = defaults.pins.pinTextureWWVamp.tint end
  if not DestinationsSV.pins.pinTextureWWVamp.textcolor then DestinationsSV.pins.pinTextureWWVamp.textcolor = defaults.pins.pinTextureWWVamp.textcolor end

  if not DestinationsSV.pins.pinTextureWWShrine.maxDistance then DestinationsSV.pins.pinTextureWWShrine.maxDistance = defaults.pins.pinTextureWWShrine.maxDistance end
  if not DestinationsSV.pins.pinTextureWWShrine.type then DestinationsSV.pins.pinTextureWWShrine.type = defaults.pins.pinTextureWWShrine.type end
  if not DestinationsSV.pins.pinTextureWWShrine.level then DestinationsSV.pins.pinTextureWWShrine.level = defaults.pins.pinTextureWWShrine.level end
  if not DestinationsSV.pins.pinTextureWWShrine.size then DestinationsSV.pins.pinTextureWWShrine.size = defaults.pins.pinTextureWWShrine.size end
  if not DestinationsSV.pins.pinTextureWWShrine.tint then DestinationsSV.pins.pinTextureWWShrine.tint = defaults.pins.pinTextureWWShrine.tint end
  if not DestinationsSV.pins.pinTextureWWShrine.textcolor then DestinationsSV.pins.pinTextureWWShrine.textcolor = defaults.pins.pinTextureWWShrine.textcolor end

  if not DestinationsSV.pins.pinTextureVampAltar.maxDistance then DestinationsSV.pins.pinTextureVampAltar.maxDistance = defaults.pins.pinTextureVampAltar.maxDistance end
  if not DestinationsSV.pins.pinTextureVampAltar.type then DestinationsSV.pins.pinTextureVampAltar.type = defaults.pins.pinTextureVampAltar.type end
  if not DestinationsSV.pins.pinTextureVampAltar.level then DestinationsSV.pins.pinTextureVampAltar.level = defaults.pins.pinTextureVampAltar.level end
  if not DestinationsSV.pins.pinTextureVampAltar.size then DestinationsSV.pins.pinTextureVampAltar.size = defaults.pins.pinTextureVampAltar.size end
  if not DestinationsSV.pins.pinTextureVampAltar.tint then DestinationsSV.pins.pinTextureVampAltar.tint = defaults.pins.pinTextureVampAltar.tint end
  if not DestinationsSV.pins.pinTextureVampAltar.textcolor then DestinationsSV.pins.pinTextureVampAltar.textcolor = defaults.pins.pinTextureVampAltar.textcolor end

  if not DestinationsSV.pins.pinTextureCollectible.maxDistance then DestinationsSV.pins.pinTextureCollectible.maxDistance = defaults.pins.pinTextureCollectible.maxDistance end
  if not DestinationsSV.pins.pinTextureCollectible.type then DestinationsSV.pins.pinTextureCollectible.type = defaults.pins.pinTextureCollectible.type end
  if not DestinationsSV.pins.pinTextureCollectible.level then DestinationsSV.pins.pinTextureCollectible.level = defaults.pins.pinTextureCollectible.level end
  if not DestinationsSV.pins.pinTextureCollectible.size then DestinationsSV.pins.pinTextureCollectible.size = defaults.pins.pinTextureCollectible.size end
  if not DestinationsSV.pins.pinTextureCollectible.tint then DestinationsSV.pins.pinTextureCollectible.tint = defaults.pins.pinTextureCollectible.tint end
  if not DestinationsSV.pins.pinTextureCollectible.textcolor then DestinationsSV.pins.pinTextureCollectible.textcolor = defaults.pins.pinTextureCollectible.textcolor end
  if not DestinationsSV.pins.pinTextureCollectible.textcolortitle then DestinationsSV.pins.pinTextureCollectible.textcolortitle = defaults.pins.pinTextureCollectible.textcolortitle end

  if not DestinationsSV.pins.pinTextureCollectibleDone.maxDistance then DestinationsSV.pins.pinTextureCollectibleDone.maxDistance = defaults.pins.pinTextureCollectibleDone.maxDistance end
  if not DestinationsSV.pins.pinTextureCollectibleDone.type then DestinationsSV.pins.pinTextureCollectibleDone.type = defaults.pins.pinTextureCollectibleDone.type end
  if not DestinationsSV.pins.pinTextureCollectibleDone.level then DestinationsSV.pins.pinTextureCollectibleDone.level = defaults.pins.pinTextureCollectibleDone.level end
  if not DestinationsSV.pins.pinTextureCollectibleDone.size then DestinationsSV.pins.pinTextureCollectibleDone.size = defaults.pins.pinTextureCollectibleDone.size end
  if not DestinationsSV.pins.pinTextureCollectibleDone.tint then DestinationsSV.pins.pinTextureCollectibleDone.tint = defaults.pins.pinTextureCollectibleDone.tint end
  if not DestinationsSV.pins.pinTextureCollectibleDone.textcolor then DestinationsSV.pins.pinTextureCollectibleDone.textcolor = defaults.pins.pinTextureCollectibleDone.textcolor end
  if not DestinationsSV.pins.pinTextureCollectibleDone.textcolortitle then DestinationsSV.pins.pinTextureCollectibleDone.textcolortitle = defaults.pins.pinTextureCollectibleDone.textcolortitle end

  if not DestinationsSV.pins.pinTextureFish.maxDistance then DestinationsSV.pins.pinTextureFish.maxDistance = defaults.pins.pinTextureFish.maxDistance end
  if not DestinationsSV.pins.pinTextureFish.type then DestinationsSV.pins.pinTextureFish.type = defaults.pins.pinTextureFish.type end
  if not DestinationsSV.pins.pinTextureFish.level then DestinationsSV.pins.pinTextureFish.level = defaults.pins.pinTextureFish.level end
  if not DestinationsSV.pins.pinTextureFish.size then DestinationsSV.pins.pinTextureFish.size = defaults.pins.pinTextureFish.size end
  if not DestinationsSV.pins.pinTextureFish.tint then DestinationsSV.pins.pinTextureFish.tint = defaults.pins.pinTextureFish.tint end
  if not DestinationsSV.pins.pinTextureFish.textcolor then DestinationsSV.pins.pinTextureFish.textcolor = defaults.pins.pinTextureFish.textcolor end
  if not DestinationsSV.pins.pinTextureFish.textcolortitle then DestinationsSV.pins.pinTextureFish.textcolortitle = defaults.pins.pinTextureFish.textcolortitle end
  if not DestinationsSV.pins.pinTextureFish.textcolorBait then DestinationsSV.pins.pinTextureFish.textcolorBait = defaults.pins.pinTextureFish.textcolorBait end
  if not DestinationsSV.pins.pinTextureFish.textcolorWater then DestinationsSV.pins.pinTextureFish.textcolorWater = defaults.pins.pinTextureFish.textcolorWater end

  if not DestinationsSV.pins.pinTextureFishDone.maxDistance then DestinationsSV.pins.pinTextureFishDone.maxDistance = defaults.pins.pinTextureFishDone.maxDistance end
  if not DestinationsSV.pins.pinTextureFishDone.type then DestinationsSV.pins.pinTextureFishDone.type = defaults.pins.pinTextureFishDone.type end
  if not DestinationsSV.pins.pinTextureFishDone.level then DestinationsSV.pins.pinTextureFishDone.level = defaults.pins.pinTextureFishDone.level end
  if not DestinationsSV.pins.pinTextureFishDone.size then DestinationsSV.pins.pinTextureFishDone.size = defaults.pins.pinTextureFishDone.size end
  if not DestinationsSV.pins.pinTextureFishDone.tint then DestinationsSV.pins.pinTextureFishDone.tint = defaults.pins.pinTextureFishDone.tint end
  if not DestinationsSV.pins.pinTextureFishDone.textcolor then DestinationsSV.pins.pinTextureFishDone.textcolor = defaults.pins.pinTextureFishDone.textcolor end
  if not DestinationsSV.pins.pinTextureFishDone.textcolortitle then DestinationsSV.pins.pinTextureFishDone.textcolortitle = defaults.pins.pinTextureFishDone.textcolortitle end
  if not DestinationsSV.pins.pinTextureFishDone.textcolorBait then DestinationsSV.pins.pinTextureFishDone.textcolorBait = defaults.pins.pinTextureFishDone.textcolorBait end
  if not DestinationsSV.pins.pinTextureFishDone.textcolorWater then DestinationsSV.pins.pinTextureFishDone.textcolorWater = defaults.pins.pinTextureFishDone.textcolorWater end

  if DestinationsSV.settings.ShowDungeonBossesInZones == nil then DestinationsSV.settings.ShowDungeonBossesInZones = defaults.settings.ShowDungeonBossesInZones end
  if DestinationsSV.settings.ShowDungeonBossesOnTop == nil then DestinationsSV.settings.ShowDungeonBossesOnTop = defaults.settings.ShowDungeonBossesOnTop end

  if DestinationsSV.settings.ShowCadwellsAlmanac == nil then DestinationsSV.settings.ShowCadwellsAlmanac = defaults.settings.ShowCadwellsAlmanac end
  if DestinationsSV.settings.ShowCadwellsAlmanacOnly == nil then DestinationsSV.settings.ShowCadwellsAlmanacOnly = defaults.settings.ShowCadwellsAlmanacOnly end

end

local function OnAchievementUpdate(eventCode, achievementId)
  if achievementId then

    if achievementId >= 749 and achievementId <= 754 then return end

    LMP:RefreshPins(DPINS.MAIQ)
    COMPASS_PINS:RefreshPins(DPINS.MAIQ)

    LMP:RefreshPins(DPINS.LB_GTTP_CP)
    COMPASS_PINS:RefreshPins(DPINS.LB_GTTP_CP)

    LMP:RefreshPins(DPINS.PEACEMAKER)
    COMPASS_PINS:RefreshPins(DPINS.PEACEMAKER)

    LMP:RefreshPins(DPINS.NOSEDIVER)
    COMPASS_PINS:RefreshPins(DPINS.NOSEDIVER)

    LMP:RefreshPins(DPINS.EARTHLYPOS)
    COMPASS_PINS:RefreshPins(DPINS.EARTHLYPOS)

    LMP:RefreshPins(DPINS.ON_ME)
    COMPASS_PINS:RefreshPins(DPINS.ON_ME)

    LMP:RefreshPins(DPINS.BRAWL)
    COMPASS_PINS:RefreshPins(DPINS.BRAWL)

    LMP:RefreshPins(DPINS.PATRON)
    COMPASS_PINS:RefreshPins(DPINS.PATRON)

    LMP:RefreshPins(DPINS.WROTHGAR_JUMPER)
    COMPASS_PINS:RefreshPins(DPINS.WROTHGAR_JUMPER)

    LMP:RefreshPins(DPINS.RELIC_HUNTER)
    COMPASS_PINS:RefreshPins(DPINS.RELIC_HUNTER)

    LMP:RefreshPins(DPINS.CHAMPION)
    COMPASS_PINS:RefreshPins(DPINS.CHAMPION)

    LMP:RefreshPins(DPINS.MAIQ_DONE)
    COMPASS_PINS:RefreshPins(DPINS.MAIQ_DONE)

    LMP:RefreshPins(DPINS.LB_GTTP_CP_DONE)
    COMPASS_PINS:RefreshPins(DPINS.LB_GTTP_CP_DONE)

    LMP:RefreshPins(DPINS.PEACEMAKER_DONE)
    COMPASS_PINS:RefreshPins(DPINS.PEACEMAKER_DONE)

    LMP:RefreshPins(DPINS.NOSEDIVER_DONE)
    COMPASS_PINS:RefreshPins(DPINS.NOSEDIVER_DONE)

    LMP:RefreshPins(DPINS.EARTHLYPOS_DONE)
    COMPASS_PINS:RefreshPins(DPINS.EARTHLYPOS_DONE)

    LMP:RefreshPins(DPINS.ON_ME_DONE)
    COMPASS_PINS:RefreshPins(DPINS.ON_ME_DONE)

    LMP:RefreshPins(DPINS.BRAWL_DONE)
    COMPASS_PINS:RefreshPins(DPINS.BRAWL_DONE)

    LMP:RefreshPins(DPINS.PATRON_DONE)
    COMPASS_PINS:RefreshPins(DPINS.PATRON_DONE)

    LMP:RefreshPins(DPINS.WROTHGAR_JUMPER_DONE)
    COMPASS_PINS:RefreshPins(DPINS.WROTHGAR_JUMPER_DONE)

    LMP:RefreshPins(DPINS.RELIC_HUNTER_DONE)
    COMPASS_PINS:RefreshPins(DPINS.RELIC_HUNTER_DONE)

    LMP:RefreshPins(DPINS.CHAMPION_DONE)
    COMPASS_PINS:RefreshPins(DPINS.CHAMPION_DONE)

    LMP:RefreshPins(DPINS.FISHING)
    COMPASS_PINS:RefreshPins(DPINS.FISHING)

    LMP:RefreshPins(DPINS.FISHINGDONE)
    COMPASS_PINS:RefreshPins(DPINS.FISHINGDONE)

  end
end

--[[TODO What did this do in the past?
]]--
local function UpdateInventoryContent()
  MapMiscPOIs = false
  if DestinationsCSSV.filters[DPINS.RELIC_HUNTER] or DestinationsCSSV.filters[DPINS.CUTPURSE] then
    GetMapTextureName()
    if mapTextureName and zoneTextureName then
      -- Destinations:dm("Info", "getting inventory...")
    end
  end
end

local function OnGamepadPreferredModeChanged()
  if IsInGamepadPreferredMode() then
    INFORMATION_TOOLTIP = ZO_MapLocationTooltip_Gamepad
  else
    INFORMATION_TOOLTIP = InformationTooltip
  end
end

local function GetPinTextureUnknown(self)
  return self.m_PinTag.texture
end

local function GetFakedPinTexture(self)
  return self.m_PinTag.texture
end

local function SetPinLayouts()

  local pinLayout_Faked = {
    maxDistance = 0.05,
    level = 30,
    texture = GetFakedPinTexture,
    size = 26,
  }

  local pinLayout_unknown = {
    maxDistance = DestinationsSV.pins.pinTextureUnknown.maxDistance,
    level = DestinationsSV.pins.pinTextureUnknown.level,
    texture = GetPinTextureUnknown,
    size = DestinationsSV.pins.pinTextureUnknown.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureUnknown.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureUnknown.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_other = {
    maxDistance = DestinationsSV.pins.pinTextureOther.maxDistance,
    level = DestinationsSV.pins.pinTextureOther.level,
    texture = pinTextures.paths.Other[DestinationsSV.pins.pinTextureOther.type],
    size = DestinationsSV.pins.pinTextureOther.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOther.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureOther.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_other_Done = {
    maxDistance = DestinationsSV.pins.pinTextureOtherDone.maxDistance,
    level = DestinationsSV.pins.pinTextureOtherDone.level,
    texture = pinTextures.paths.OtherDone[DestinationsSV.pins.pinTextureOtherDone.type],
    size = DestinationsSV.pins.pinTextureOtherDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOtherDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureOtherDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Maiq = {
    maxDistance = DestinationsSV.pins.pinTextureMaiq.maxDistance,
    level = DestinationsSV.pins.pinTextureMaiq.level,
    texture = pinTextures.paths.Maiq[DestinationsSV.pins.pinTextureMaiq.type],
    size = DestinationsSV.pins.pinTextureMaiq.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureMaiq.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureMaiq.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Maiq_Done = {
    maxDistance = DestinationsSV.pins.pinTextureMaiqDone.maxDistance,
    level = DestinationsSV.pins.pinTextureMaiqDone.level,
    texture = pinTextures.paths.MaiqDone[DestinationsSV.pins.pinTextureMaiqDone.type],
    size = DestinationsSV.pins.pinTextureMaiqDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureMaiqDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureMaiqDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Peacemaker = {
    maxDistance = DestinationsSV.pins.pinTexturePeacemaker.maxDistance,
    level = DestinationsSV.pins.pinTexturePeacemaker.level,
    texture = pinTextures.paths.Peacemaker[DestinationsSV.pins.pinTexturePeacemaker.type],
    size = DestinationsSV.pins.pinTexturePeacemaker.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTexturePeacemaker.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTexturePeacemaker.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Peacemaker_Done = {
    maxDistance = DestinationsSV.pins.pinTexturePeacemakerDone.maxDistance,
    level = DestinationsSV.pins.pinTexturePeacemakerDone.level,
    texture = pinTextures.paths.PeacemakerDone[DestinationsSV.pins.pinTexturePeacemakerDone.type],
    size = DestinationsSV.pins.pinTexturePeacemakerDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTexturePeacemakerDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTexturePeacemakerDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Nosediver = {
    maxDistance = DestinationsSV.pins.pinTextureNosediver.maxDistance,
    level = DestinationsSV.pins.pinTextureNosediver.level,
    texture = pinTextures.paths.Nosediver[DestinationsSV.pins.pinTextureNosediver.type],
    size = DestinationsSV.pins.pinTextureNosediver.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureNosediver.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureNosediver.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Nosediver_Done = {
    maxDistance = DestinationsSV.pins.pinTextureNosediverDone.maxDistance,
    level = DestinationsSV.pins.pinTextureNosediverDone.level,
    texture = pinTextures.paths.NosediverDone[DestinationsSV.pins.pinTextureNosediverDone.type],
    size = DestinationsSV.pins.pinTextureNosediverDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureNosediverDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureNosediverDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_EarthlyPos = {
    maxDistance = DestinationsSV.pins.pinTextureEarthlyPos.maxDistance,
    level = DestinationsSV.pins.pinTextureEarthlyPos.level,
    texture = pinTextures.paths.Earthlypos[DestinationsSV.pins.pinTextureEarthlyPos.type],
    size = DestinationsSV.pins.pinTextureEarthlyPos.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureEarthlyPos.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureEarthlyPos.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_EarthlyPos_Done = {
    maxDistance = DestinationsSV.pins.pinTextureEarthlyPosDone.maxDistance,
    level = DestinationsSV.pins.pinTextureEarthlyPosDone.level,
    texture = pinTextures.paths.EarthlyposDone[DestinationsSV.pins.pinTextureEarthlyPosDone.type],
    size = DestinationsSV.pins.pinTextureEarthlyPosDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureEarthlyPosDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureEarthlyPosDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_OnMe = {
    maxDistance = DestinationsSV.pins.pinTextureOnMe.maxDistance,
    level = DestinationsSV.pins.pinTextureOnMe.level,
    texture = pinTextures.paths.OnMe[DestinationsSV.pins.pinTextureOnMe.type],
    size = DestinationsSV.pins.pinTextureOnMe.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOnMe.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureOnMe.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_OnMe_Done = {
    maxDistance = DestinationsSV.pins.pinTextureOnMeDone.maxDistance,
    level = DestinationsSV.pins.pinTextureOnMeDone.level,
    texture = pinTextures.paths.OnMeDone[DestinationsSV.pins.pinTextureOnMeDone.type],
    size = DestinationsSV.pins.pinTextureOnMeDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureOnMeDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureOnMeDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Brawl = {
    maxDistance = DestinationsSV.pins.pinTextureBrawl.maxDistance,
    level = DestinationsSV.pins.pinTextureBrawl.level,
    texture = pinTextures.paths.Brawl[DestinationsSV.pins.pinTextureBrawl.type],
    size = DestinationsSV.pins.pinTextureBrawl.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureBrawl.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureBrawl.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Brawl_Done = {
    maxDistance = DestinationsSV.pins.pinTextureBrawlDone.maxDistance,
    level = DestinationsSV.pins.pinTextureBrawlDone.level,
    texture = pinTextures.paths.BrawlDone[DestinationsSV.pins.pinTextureBrawlDone.type],
    size = DestinationsSV.pins.pinTextureBrawlDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureBrawlDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureBrawlDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Patron = {
    maxDistance = DestinationsSV.pins.pinTexturePatron.maxDistance,
    level = DestinationsSV.pins.pinTexturePatron.level,
    texture = pinTextures.paths.Patron[DestinationsSV.pins.pinTexturePatron.type],
    size = DestinationsSV.pins.pinTexturePatron.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTexturePatron.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTexturePatron.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Patron_Done = {
    maxDistance = DestinationsSV.pins.pinTexturePatronDone.maxDistance,
    level = DestinationsSV.pins.pinTexturePatronDone.level,
    texture = pinTextures.paths.PatronDone[DestinationsSV.pins.pinTexturePatronDone.type],
    size = DestinationsSV.pins.pinTexturePatronDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTexturePatronDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTexturePatronDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_WrothgarJumper = {
    maxDistance = DestinationsSV.pins.pinTextureWrothgarJumper.maxDistance,
    level = DestinationsSV.pins.pinTextureWrothgarJumper.level,
    texture = pinTextures.paths.WrothgarJumper[DestinationsSV.pins.pinTextureWrothgarJumper.type],
    size = DestinationsSV.pins.pinTextureWrothgarJumper.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureWrothgarJumper.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureWrothgarJumper.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_WrothgarJumper_Done = {
    maxDistance = DestinationsSV.pins.pinTextureWrothgarJumperDone.maxDistance,
    level = DestinationsSV.pins.pinTextureWrothgarJumperDone.level,
    texture = pinTextures.paths.WrothgarJumperDone[DestinationsSV.pins.pinTextureWrothgarJumperDone.type],
    size = DestinationsSV.pins.pinTextureWrothgarJumperDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureWrothgarJumperDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureWrothgarJumperDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_RelicHunter = {
    maxDistance = DestinationsSV.pins.pinTextureRelicHunter.maxDistance,
    level = DestinationsSV.pins.pinTextureRelicHunter.level,
    texture = pinTextures.paths.RelicHunter[DestinationsSV.pins.pinTextureRelicHunter.type],
    size = DestinationsSV.pins.pinTextureRelicHunter.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureRelicHunter.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureRelicHunter.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_RelicHunter_Done = {
    maxDistance = DestinationsSV.pins.pinTextureRelicHunterDone.maxDistance,
    level = DestinationsSV.pins.pinTextureRelicHunterDone.level,
    texture = pinTextures.paths.RelicHunterDone[DestinationsSV.pins.pinTextureRelicHunterDone.type],
    size = DestinationsSV.pins.pinTextureRelicHunterDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureRelicHunterDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureRelicHunterDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Champion = {
    maxDistance = DestinationsSV.pins.pinTextureChampion.maxDistance,
    level = DestinationsSV.pins.pinTextureChampion.level,
    texture = pinTextures.paths.Champion[DestinationsSV.pins.pinTextureChampion.type],
    size = DestinationsSV.pins.pinTextureChampion.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureChampion.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureChampion.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Champion_Done = {
    maxDistance = DestinationsSV.pins.pinTextureChampionDone.maxDistance,
    level = DestinationsSV.pins.pinTextureChampionDone.level,
    texture = pinTextures.paths.ChampionDone[DestinationsSV.pins.pinTextureChampionDone.type],
    size = DestinationsSV.pins.pinTextureChampionDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureChampionDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureChampionDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Breaking = {
    maxDistance = DestinationsSV.pins.pinTextureBreaking.maxDistance,
    level = DestinationsSV.pins.pinTextureBreaking.level,
    texture = pinTextures.paths.Breaking[DestinationsSV.pins.pinTextureBreaking.type],
    size = DestinationsSV.pins.pinTextureBreaking.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureBreaking.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureBreaking.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Breaking_Done = {
    maxDistance = DestinationsSV.pins.pinTextureBreakingDone.maxDistance,
    level = DestinationsSV.pins.pinTextureBreakingDone.level,
    texture = pinTextures.paths.BreakingDone[DestinationsSV.pins.pinTextureBreakingDone.type],
    size = DestinationsSV.pins.pinTextureBreakingDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureBreakingDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureBreakingDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Cutpurse = {
    maxDistance = DestinationsSV.pins.pinTextureCutpurse.maxDistance,
    level = DestinationsSV.pins.pinTextureCutpurse.level,
    texture = pinTextures.paths.Cutpurse[DestinationsSV.pins.pinTextureCutpurse.type],
    size = DestinationsSV.pins.pinTextureCutpurse.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCutpurse.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureCutpurse.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Cutpurse_Done = {
    maxDistance = DestinationsSV.pins.pinTextureCutpurseDone.maxDistance,
    level = DestinationsSV.pins.pinTextureCutpurseDone.level,
    texture = pinTextures.paths.CutpurseDone[DestinationsSV.pins.pinTextureCutpurseDone.type],
    size = DestinationsSV.pins.pinTextureCutpurseDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCutpurseDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureCutpurseDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Collectible = {
    maxDistance = DestinationsSV.pins.pinTextureCollectible.maxDistance,
    level = DestinationsSV.pins.pinTextureCollectible.level,
    texture = pinTextures.paths.collectible[DestinationsSV.pins.pinTextureCollectible.type],
    size = DestinationsSV.pins.pinTextureCollectible.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCollectible.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureCollectible.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_CollectibleDone = {
    maxDistance = DestinationsSV.pins.pinTextureCollectibleDone.maxDistance,
    level = DestinationsSV.pins.pinTextureCollectibleDone.level,
    texture = pinTextures.paths.collectibledone[DestinationsSV.pins.pinTextureCollectibleDone.type],
    size = DestinationsSV.pins.pinTextureCollectibleDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureCollectibleDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureCollectibleDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Fish = {
    maxDistance = DestinationsSV.pins.pinTextureFish.maxDistance,
    level = DestinationsSV.pins.pinTextureFish.level,
    texture = pinTextures.paths.fish[DestinationsSV.pins.pinTextureFish.type],
    size = DestinationsSV.pins.pinTextureFish.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFish.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureFish.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_FishDone = {
    maxDistance = DestinationsSV.pins.pinTextureFishDone.maxDistance,
    level = DestinationsSV.pins.pinTextureFishDone.level,
    texture = pinTextures.paths.fishdone[DestinationsSV.pins.pinTextureFishDone.type],
    size = DestinationsSV.pins.pinTextureFishDone.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureFishDone.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureFishDone.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Ayleid = {
    maxDistance = DestinationsSV.pins.pinTextureAyleid.maxDistance,
    level = DestinationsSV.pins.pinTextureAyleid.level,
    texture = pinTextures.paths.Ayleid[DestinationsSV.pins.pinTextureAyleid.type],
    size = DestinationsSV.pins.pinTextureAyleid.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureAyleid.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureAyleid.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Deadlands = {
    maxDistance = DestinationsSV.pins.pinTextureDeadlands.maxDistance,
    level = DestinationsSV.pins.pinTextureDeadlands.level,
    texture = pinTextures.paths.Deadlands[DestinationsSV.pins.pinTextureDeadlands.type],
    size = DestinationsSV.pins.pinTextureDeadlands.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureDeadlands.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureDeadlands.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_HighIsle = {
    maxDistance = DestinationsSV.pins.pinTextureHighIsle.maxDistance,
    level = DestinationsSV.pins.pinTextureHighIsle.level,
    texture = pinTextures.paths.HighIsle[DestinationsSV.pins.pinTextureHighIsle.type],
    size = DestinationsSV.pins.pinTextureHighIsle.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureHighIsle.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureHighIsle.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_Dwemer = {
    maxDistance = DestinationsSV.pins.pinTextureDwemer.maxDistance,
    level = DestinationsSV.pins.pinTextureDwemer.level,
    texture = pinTextures.paths.dwemer[DestinationsSV.pins.pinTextureDwemer.type],
    size = DestinationsSV.pins.pinTextureDwemer.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureDwemer.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureDwemer.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_WWVamp = {
    maxDistance = DestinationsSV.pins.pinTextureWWVamp.maxDistance,
    level = DestinationsSV.pins.pinTextureWWVamp.level,
    texture = pinTextures.paths.wwvamp[DestinationsSV.pins.pinTextureWWVamp.type],
    size = DestinationsSV.pins.pinTextureWWVamp.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureWWVamp.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureWWVamp.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_VampireAltar = {
    maxDistance = DestinationsSV.pins.pinTextureVampAltar.maxDistance,
    level = DestinationsSV.pins.pinTextureVampAltar.level,
    texture = pinTextures.paths.vampirealtar[DestinationsSV.pins.pinTextureVampAltar.type],
    size = DestinationsSV.pins.pinTextureVampAltar.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureVampAltar.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureVampAltar.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }
  local pinLayout_WereWolfShrine = {
    maxDistance = DestinationsSV.pins.pinTextureWWShrine.maxDistance,
    level = DestinationsSV.pins.pinTextureWWShrine.level,
    texture = pinTextures.paths.werewolfshrine[DestinationsSV.pins.pinTextureWWShrine.type],
    size = DestinationsSV.pins.pinTextureWWShrine.size,
    tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureWWShrine.tint)),
    additionalLayout = {
      function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(DestinationsSV.pins.pinTextureWWShrine.tint))
      end,
      function(pin)
        pin:GetNamedChild("Background"):SetColor(1, 1, 1, 1)
      end,
    },
  }

  --Activate the Tooltip Creator for the pins
  local pinTooltipCreator = {
    creator = function(pin)
      local _, pinTag = pin:GetPinTypeAndTag()
      if pinTag.newFormat then

        if IsInGamepadPreferredMode() then
          INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, nil, pinTag.objectiveName,
            INFORMATION_TOOLTIP.tooltip:GetStyle("mapTitle"))

          if DestinationsSV.settings.AddEnglishOnUnknwon then
            INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, nil, pinTag.englishName,
              { fontSize = 27, fontColorField = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_3 })
          end

          if pinTag.special then
            if pinTag.multipleFormat and pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_CRAFTING and DestinationsSV.settings.ImproveCrafting then
              for lineIndex, lineData in ipairs(pinTag.special) do
                INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, nil, lineData,
                  pinTag.multipleFormat.g[lineIndex])
              end
            elseif pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_MUNDUS and DestinationsSV.settings.ImproveMundus then
              INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, nil, pinTag.special,
                { fontSize = 27, fontColorField = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_3 })
            end
          end

        else

          INFORMATION_TOOLTIP:AddLine(pinTag.objectiveName, "ZoFontGameOutline",
            unpack(DestinationsSV.pins.pinTextureUnknown.textcolor))
          INFORMATION_TOOLTIP:AddLine(pinTag.poiTypeName, "", ZO_HIGHLIGHT_TEXT:UnpackRGB())

          if DestinationsSV.settings.AddEnglishOnUnknwon then
            INFORMATION_TOOLTIP:AddLine(pinTag.englishName, "",
              unpack(DestinationsSV.pins.pinTextureUnknown.textcolorEN))
          end

          if pinTag.special then
            ZO_Tooltip_AddDivider(INFORMATION_TOOLTIP)
            if pinTag.multipleFormat and pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_CRAFTING and DestinationsSV.settings.ImproveCrafting then
              for lineIndex, lineData in ipairs(pinTag.special) do
                INFORMATION_TOOLTIP:AddLine(lineData, unpack(pinTag.multipleFormat.k[lineIndex]))
              end
            elseif pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_MUNDUS and DestinationsSV.settings.ImproveMundus then
              INFORMATION_TOOLTIP:AddLine(pinTag.special, "", ZO_HIGHLIGHT_TEXT:UnpackRGB())
            end
          end

        end
      else
        for lineIndex, lineData in ipairs(pinTag) do
          if IsInGamepadPreferredMode() then
            if pinTag[1] == lineData then
              INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, icon, zo_strformat(lineData),
                { fontSize = 27, fontColorField = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_3 })
            else
              INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, nil, zo_strformat(lineData),
                INFORMATION_TOOLTIP.tooltip:GetStyle("worldMapTooltip"))
            end
          else
            INFORMATION_TOOLTIP:AddLine(lineData)
          end
        end
      end
    end,
    tooltip = 1,
  }

  --Create the Map Pins

  LMP:AddPinType(DPINS.FAKEKNOWN, MapCallback_fakeKnown, nil, pinLayout_Faked, pinTooltipCreator)

  LMP:AddPinType(DPINS.UNKNOWN, MapCallback_unknown, nil, pinLayout_unknown, pinTooltipCreator)

  LMP:AddPinType(DPINS.LB_GTTP_CP, OtherpinTypeCallback, nil, pinLayout_other, pinTooltipCreator)
  LMP:AddPinType(DPINS.LB_GTTP_CP_DONE, OtherpinTypeCallbackDone, nil, pinLayout_other_Done, pinTooltipCreator)

  LMP:AddPinType(DPINS.MAIQ, MaiqpinTypeCallback, nil, pinLayout_Maiq, pinTooltipCreator)
  LMP:AddPinType(DPINS.MAIQ_DONE, MaiqpinTypeCallbackDone, nil, pinLayout_Maiq_Done, pinTooltipCreator)

  LMP:AddPinType(DPINS.PEACEMAKER, PeacemakerpinTypeCallback, nil, pinLayout_Peacemaker, pinTooltipCreator)
  LMP:AddPinType(DPINS.PEACEMAKER_DONE, PeacemakerpinTypeCallbackDone, nil, pinLayout_Peacemaker_Done,
    pinTooltipCreator)

  LMP:AddPinType(DPINS.NOSEDIVER, NosediverpinTypeCallback, nil, pinLayout_Nosediver, pinTooltipCreator)
  LMP:AddPinType(DPINS.NOSEDIVER_DONE, NosediverpinTypeCallbackDone, nil, pinLayout_Nosediver_Done, pinTooltipCreator)

  LMP:AddPinType(DPINS.EARTHLYPOS, EarthlyPospinTypeCallback, nil, pinLayout_EarthlyPos, pinTooltipCreator)
  LMP:AddPinType(DPINS.EARTHLYPOS_DONE, EarthlyPospinTypeCallbackDone, nil, pinLayout_EarthlyPos_Done,
    pinTooltipCreator)

  LMP:AddPinType(DPINS.ON_ME, OnMepinTypeCallback, nil, pinLayout_OnMe, pinTooltipCreator)
  LMP:AddPinType(DPINS.ON_ME_DONE, OnMepinTypeCallbackDone, nil, pinLayout_OnMe_Done, pinTooltipCreator)

  LMP:AddPinType(DPINS.BRAWL, BrawlpinTypeCallback, nil, pinLayout_Brawl, pinTooltipCreator)
  LMP:AddPinType(DPINS.BRAWL_DONE, BrawlpinTypeCallbackDone, nil, pinLayout_Brawl_Done, pinTooltipCreator)

  LMP:AddPinType(DPINS.PATRON, PatronpinTypeCallback, nil, pinLayout_Patron, pinTooltipCreator)
  LMP:AddPinType(DPINS.PATRON_DONE, PatronpinTypeCallbackDone, nil, pinLayout_Patron_Done, pinTooltipCreator)

  LMP:AddPinType(DPINS.WROTHGAR_JUMPER, WrothgarJumperpinTypeCallback, nil, pinLayout_WrothgarJumper, pinTooltipCreator)
  LMP:AddPinType(DPINS.WROTHGAR_JUMPER_DONE, WrothgarJumperpinTypeCallbackDone, nil, pinLayout_WrothgarJumper_Done,
    pinTooltipCreator)

  LMP:AddPinType(DPINS.RELIC_HUNTER, RelicHunterpinTypeCallback, nil, pinLayout_RelicHunter, pinTooltipCreator)
  LMP:AddPinType(DPINS.RELIC_HUNTER_DONE, RelicHunterpinTypeCallbackDone, nil, pinLayout_RelicHunter_Done,
    pinTooltipCreator)

  LMP:AddPinType(DPINS.CHAMPION, ChampionpinTypeCallback, nil, pinLayout_Champion, pinTooltipCreator)
  LMP:AddPinType(DPINS.CHAMPION_DONE, ChampionpinTypeCallbackDone, nil, pinLayout_Champion_Done, pinTooltipCreator)

  LMP:AddPinType(DPINS.BREAKING, BreakingpinTypeCallback, nil, pinLayout_Breaking, pinTooltipCreator)
  LMP:AddPinType(DPINS.BREAKING_DONE, BreakingpinTypeCallbackDone, nil, pinLayout_Breaking_Done, pinTooltipCreator)

  LMP:AddPinType(DPINS.CUTPURSE, CutpursepinTypeCallback, nil, pinLayout_Cutpurse, pinTooltipCreator)
  LMP:AddPinType(DPINS.CUTPURSE_DONE, CutpursepinTypeCallbackDone, nil, pinLayout_Cutpurse_Done, pinTooltipCreator)

  LMP:AddPinType(DPINS.COLLECTIBLES, CollectiblepinTypeCallback, nil, pinLayout_Collectible, pinTooltipCreator)
  LMP:AddPinType(DPINS.COLLECTIBLESDONE, CollectibleDonepinTypeCallback, nil, pinLayout_CollectibleDone,
    pinTooltipCreator)

  LMP:AddPinType(DPINS.FISHING, FishpinTypeCallback, nil, pinLayout_Fish, pinTooltipCreator)
  LMP:AddPinType(DPINS.FISHINGDONE, FishDonepinTypeCallback, nil, pinLayout_FishDone, pinTooltipCreator)

  LMP:AddPinType(DPINS.AYLEID, AyleidpinTypeCallback, nil, pinLayout_Ayleid, pinTooltipCreator)
  LMP:AddPinType(DPINS.DEADLANDS, DeadlandspinTypeCallback, nil, pinLayout_Deadlands, pinTooltipCreator)
  LMP:AddPinType(DPINS.HIGHISLE, HighIslepinTypeCallback, nil, pinLayout_HighIsle, pinTooltipCreator)
  LMP:AddPinType(DPINS.WWVAMP, WWVamppinTypeCallback, nil, pinLayout_WWVamp, pinTooltipCreator)

  LMP:AddPinType(DPINS.VAMPIRE_ALTAR, VampireAltarpinTypeCallback, nil, pinLayout_VampireAltar, pinTooltipCreator)
  LMP:AddPinType(DPINS.WEREWOLF_SHRINE, WerewolfShrinepinTypeCallback, nil, pinLayout_WereWolfShrine, pinTooltipCreator)

  LMP:AddPinType(DPINS.DWEMER, DwemerRuinpinTypeCallback, nil, pinLayout_Dwemer, pinTooltipCreator)

  local qolPinTooltipCreator = {
    creator = function(pin)
      local pinTag = select(2, pin:GetPinTypeAndTag())
      if IsInGamepadPreferredMode() then
        local InformationTooltip = ZO_MapLocationTooltip_Gamepad
        local baseSection = InformationTooltip.tooltip
        InformationTooltip:LayoutIconStringLine(baseSection, nil, ADDON_NAME, baseSection:GetStyle("mapLocationTooltipContentHeader"))
        InformationTooltip:LayoutIconStringLine(baseSection, nil, pinTag.pinName, baseSection:GetStyle("mapLocationTooltipContentName"))
      else
        if pinTag.pinTitle then
          INFORMATION_TOOLTIP:AddLine(pinTag.pinTitle, "ZoFontGameOutline", ZO_SELECTED_TEXT:UnpackRGB())
          ZO_Tooltip_AddDivider(INFORMATION_TOOLTIP)
        end
        INFORMATION_TOOLTIP:AddLine(pinTag.pinName, "ZoFontGameOutline", ZO_TOOLTIP_DEFAULT_COLOR:UnpackRGB())
      end
    end,
  }
  local qolPinLayout = {
    [DPINS.QOLPINS_DOCK] = {
      level = DestinationsSV.pins.pinTextureQolPin.level,
      size = DestinationsSV.pins.pinTextureQolPin.size,
      tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureQolPin.tint)),
      texture = "/esoui/art/icons/servicemappins/servicepin_dock.dds",
    },
    [DPINS.QOLPINS_STABLE] = {
      level = DestinationsSV.pins.pinTextureQolPin.level,
      size = DestinationsSV.pins.pinTextureQolPin.size,
      tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureQolPin.tint)),
      texture = "/esoui/art/icons/servicemappins/servicepin_stable.dds",
    },
    [DPINS.QOLPINS_PORTAL] = {
      level = DestinationsSV.pins.pinTextureQolPin.level,
      size = DestinationsSV.pins.pinTextureQolPin.size,
      tint = ZO_ColorDef:New(unpack(DestinationsSV.pins.pinTextureQolPin.tint)),
      texture = "/esoui/art/icons/servicemappins/servicepin_fargraveportal.dds",
    },
  }
  -- Quality Of Life Pins
  LMP:AddPinType(DPINS.QOLPINS_DOCK, function() MapCallbackQolPins(DPINS.QOLPINS_DOCK) end, nil, qolPinLayout[DPINS.QOLPINS_DOCK], qolPinTooltipCreator)
  LMP:AddPinType(DPINS.QOLPINS_STABLE, function() MapCallbackQolPins(DPINS.QOLPINS_STABLE) end, nil, qolPinLayout[DPINS.QOLPINS_STABLE], qolPinTooltipCreator)
  LMP:AddPinType(DPINS.QOLPINS_PORTAL, function() MapCallbackQolPins(DPINS.QOLPINS_PORTAL) end, nil, qolPinLayout[DPINS.QOLPINS_PORTAL], qolPinTooltipCreator)

  --Add filter check boxes
  if DestinationsCSSV.settings.MapFiltersPOIs then
    LMP:AddPinFilter(DPINS.UNKNOWN,
      defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_UNKNOWN)), nil,
      DestinationsCSSV.filters)
  end

  if DestinationsCSSV.settings.MapFiltersAchievements then
    LMP:AddPinFilter(DPINS.LB_GTTP_CP,
      defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_OTHER)), nil,
      DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.LB_GTTP_CP_DONE,
      defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_OTHER_DONE)), nil,
      DestinationsCSSV.filters)

    LMP:AddPinFilter(DPINS.MAIQ, defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_MAIQ)),
      nil, DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.MAIQ_DONE,
      defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_MAIQ_DONE)), nil,
      DestinationsCSSV.filters)

    LMP:AddPinFilter(DPINS.PEACEMAKER,
      defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_PEACEMAKER)), nil,
      DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.PEACEMAKER_DONE,
      defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_PEACEMAKER_DONE)), nil,
      DestinationsCSSV.filters)

    LMP:AddPinFilter(DPINS.NOSEDIVER,
      defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_NOSEDIVER)), nil,
      DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.NOSEDIVER_DONE,
      defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_NOSEDIVER_DONE)), nil,
      DestinationsCSSV.filters)

    LMP:AddPinFilter(DPINS.EARTHLYPOS,
      defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_EARTHLYPOS)), nil,
      DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.EARTHLYPOS_DONE,
      defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_EARTHLYPOS_DONE)), nil,
      DestinationsCSSV.filters)

    LMP:AddPinFilter(DPINS.ON_ME, defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_ON_ME)),
      nil, DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.ON_ME_DONE,
      defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_ON_ME_DONE)), nil,
      DestinationsCSSV.filters)

    LMP:AddPinFilter(DPINS.BRAWL, defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_BRAWL)),
      nil, DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.BRAWL_DONE,
      defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_BRAWL_DONE)), nil,
      DestinationsCSSV.filters)

    LMP:AddPinFilter(DPINS.PATRON, defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_PATRON)),
      nil, DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.PATRON_DONE,
      defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_PATRON_DONE)), nil,
      DestinationsCSSV.filters)

    LMP:AddPinFilter(DPINS.WROTHGAR_JUMPER,
      defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_WROTHGAR_JUMPER)), nil,
      DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.WROTHGAR_JUMPER_DONE,
      defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_WROTHGAR_JUMPER_DONE)), nil,
      DestinationsCSSV.filters)

    LMP:AddPinFilter(DPINS.RELIC_HUNTER,
      defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_RELIC_HUNTER)), nil,
      DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.RELIC_HUNTER_DONE,
      defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_RELIC_HUNTER_DONE)), nil,
      DestinationsCSSV.filters)

    LMP:AddPinFilter(DPINS.CHAMPION,
      defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_CHAMPION)), nil,
      DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.CHAMPION_DONE,
      defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_CHAMPION_DONE)), nil,
      DestinationsCSSV.filters)

    LMP:AddPinFilter(DPINS.BREAKING,
      defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_BREAKING_ENTERING)), nil,
      DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.BREAKING_DONE,
      defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_BREAKING_ENTERING_DONE)), nil,
      DestinationsCSSV.filters)

    LMP:AddPinFilter(DPINS.CUTPURSE,
      defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_CUTPURSE_ABOVE)), nil,
      DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.CUTPURSE_DONE,
      defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_CUTPURSE_ABOVE_DONE)), nil,
      DestinationsCSSV.filters)
  end

  if DestinationsCSSV.settings.MapFiltersCollectibles then
    LMP:AddPinFilter(DPINS.COLLECTIBLES,
      defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_COLLECTIBLE)), nil,
      DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.COLLECTIBLESDONE,
      defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_COLLECTIBLE_DONE)), nil,
      DestinationsCSSV.filters)
  end

  if DestinationsCSSV.settings.MapFiltersFishing then
    LMP:AddPinFilter(DPINS.FISHING,
      defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_FISHING)), nil,
      DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.FISHINGDONE,
      defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_FISHING_DONE)), nil,
      DestinationsCSSV.filters)
  end

  if DestinationsCSSV.settings.MapFiltersMisc then
    LMP:AddPinFilter(DPINS.AYLEID, defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_AYLEID)),
      nil, DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.DEADLANDS, defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_DEADLANDS_ENTRANCE)),
      nil, DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.HIGHISLE, defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_HIGHISLE_DRUIDICSHRINE)),
      nil, DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.WWVAMP, defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_WWVAMP)),
      nil, DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.VAMPIRE_ALTAR,
      defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_VAMPIRE_ALTAR)), nil,
      DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.WEREWOLF_SHRINE,
      defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_WEREWOLF_SHRINE)), nil,
      DestinationsCSSV.filters)
    LMP:AddPinFilter(DPINS.DWEMER, defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_DWEMER)),
      nil, DestinationsCSSV.filters)
  end

  --Create the Compass Pins
  COMPASS_PINS:AddCustomPin(DPINS.LB_GTTP_CP, AddAchievementCompassPins, pinLayout_other)
  COMPASS_PINS:AddCustomPin(DPINS.LB_GTTP_CP_DONE, AddAchievementCompassPins, pinLayout_other_Done)

  COMPASS_PINS:AddCustomPin(DPINS.MAIQ, AddAchievementCompassPins, pinLayout_Maiq)
  COMPASS_PINS:AddCustomPin(DPINS.MAIQ_DONE, AddAchievementCompassPins, pinLayout_Maiq_Done)

  COMPASS_PINS:AddCustomPin(DPINS.PEACEMAKER, AddAchievementCompassPins, pinLayout_Peacemaker)
  COMPASS_PINS:AddCustomPin(DPINS.PEACEMAKER_DONE, AddAchievementCompassPins, pinLayout_Peacemaker_Done)

  COMPASS_PINS:AddCustomPin(DPINS.NOSEDIVER, AddAchievementCompassPins, pinLayout_Nosediver)
  COMPASS_PINS:AddCustomPin(DPINS.NOSEDIVER_DONE, AddAchievementCompassPins, pinLayout_Nosediver_Done)

  COMPASS_PINS:AddCustomPin(DPINS.EARTHLYPOS, AddAchievementCompassPins, pinLayout_EarthlyPos)
  COMPASS_PINS:AddCustomPin(DPINS.EARTHLYPOS_DONE, AddAchievementCompassPins, pinLayout_EarthlyPos_Done)

  COMPASS_PINS:AddCustomPin(DPINS.ON_ME, AddAchievementCompassPins, pinLayout_OnMe)
  COMPASS_PINS:AddCustomPin(DPINS.ON_ME_DONE, AddAchievementCompassPins, pinLayout_OnMe_Done)

  COMPASS_PINS:AddCustomPin(DPINS.BRAWL, AddAchievementCompassPins, pinLayout_Brawl)
  COMPASS_PINS:AddCustomPin(DPINS.BRAWL_DONE, AddAchievementCompassPins, pinLayout_Brawl_Done)

  COMPASS_PINS:AddCustomPin(DPINS.PATRON, AddAchievementCompassPins, pinLayout_Patron)
  COMPASS_PINS:AddCustomPin(DPINS.PATRON_DONE, AddAchievementCompassPins, pinLayout_Patron_Done)

  COMPASS_PINS:AddCustomPin(DPINS.WROTHGAR_JUMPER, AddAchievementCompassPins, pinLayout_WrothgarJumper)
  COMPASS_PINS:AddCustomPin(DPINS.WROTHGAR_JUMPER_DONE, AddAchievementCompassPins, pinLayout_WrothgarJumper_Done)

  COMPASS_PINS:AddCustomPin(DPINS.RELIC_HUNTER, AddAchievementCompassPins, pinLayout_RelicHunter)
  COMPASS_PINS:AddCustomPin(DPINS.RELIC_HUNTER_DONE, AddAchievementCompassPins, pinLayout_RelicHunter_Done)

  COMPASS_PINS:AddCustomPin(DPINS.CHAMPION, AddAchievementCompassPins, pinLayout_Champion)
  COMPASS_PINS:AddCustomPin(DPINS.CHAMPION_DONE, AddAchievementCompassPins, pinLayout_Champion_Done)

  COMPASS_PINS:AddCustomPin(DPINS.BREAKING, AddAchievementCompassPins, pinLayout_Breaking)
  COMPASS_PINS:AddCustomPin(DPINS.BREAKING_DONE, AddAchievementCompassPins, pinLayout_Breaking_Done)

  COMPASS_PINS:AddCustomPin(DPINS.CUTPURSE, AddAchievementCompassPins, pinLayout_Cutpurse)
  COMPASS_PINS:AddCustomPin(DPINS.CUTPURSE_DONE, AddAchievementCompassPins, pinLayout_Cutpurse_Done)

  COMPASS_PINS:AddCustomPin(DPINS.COLLECTIBLES, CollectibleFishCompassPins, pinLayout_Collectible)
  COMPASS_PINS:AddCustomPin(DPINS.COLLECTIBLESDONE, CollectibleFishCompassPins, pinLayout_CollectibleDone)

  COMPASS_PINS:AddCustomPin(DPINS.FISHING, CollectibleFishCompassPins, pinLayout_Fish)
  COMPASS_PINS:AddCustomPin(DPINS.FISHINGDONE, CollectibleFishCompassPins, pinLayout_FishDone)

  COMPASS_PINS:AddCustomPin(DPINS.AYLEID, AddMiscCompassPins, pinLayout_Ayleid)
  COMPASS_PINS:AddCustomPin(DPINS.DEADLANDS, AddMiscCompassPins, pinLayout_Deadlands)
  COMPASS_PINS:AddCustomPin(DPINS.HIGHISLE, AddMiscCompassPins, pinLayout_HighIsle)
  COMPASS_PINS:AddCustomPin(DPINS.WWVAMP, AddMiscCompassPins, pinLayout_WWVamp)
  COMPASS_PINS:AddCustomPin(DPINS.VAMPIRE_ALTAR, AddMiscCompassPins, pinLayout_VampireAltar)
  COMPASS_PINS:AddCustomPin(DPINS.WEREWOLF_SHRINE, AddMiscCompassPins, pinLayout_WereWolfShrine)
  COMPASS_PINS:AddCustomPin(DPINS.DWEMER, AddMiscCompassPins, pinLayout_Dwemer)

end

-- Points of interest ---------------------------------------------------------
local function HookPoiTooltips()

  ENGLISH_POI_COLOR = ZO_ColorDef:New(DestinationsSV.settings.EnglishColorPOI)

  local function AddEnglishName(pin)

    if DestinationsSV.settings.AddEnglishOnUnknwon then
      local zoneId = GetZoneId(pin:GetPOIZoneIndex())
      local poiIndex = pin:GetPOIIndex()

      local mapData = POIsStore[zoneId]

      if mapData and mapData[poiIndex] then
        local englishName = mapData[poiIndex].n
        if englishName then
          local localizedName = ZO_WorldMapMouseoverName:GetText()
          ZO_WorldMapMouseoverName:SetText(zo_strformat("<<1>>\n<<2>>", localizedName,
            ENGLISH_POI_COLOR:Colorize(englishName)))
        end
      end
    end

  end

  local CreatorPOISeen = ZO_MapPin.TOOLTIP_CREATORS[MAP_PIN_TYPE_POI_SEEN].creator
  ZO_MapPin.TOOLTIP_CREATORS[MAP_PIN_TYPE_POI_SEEN].creator = function(...)
    CreatorPOISeen(...) --original tooltip creator
    AddEnglishName(...)
  end

  local CreatorPOIComplete = ZO_MapPin.TOOLTIP_CREATORS[MAP_PIN_TYPE_POI_COMPLETE].creator
  ZO_MapPin.TOOLTIP_CREATORS[MAP_PIN_TYPE_POI_COMPLETE].creator = function(...)
    CreatorPOIComplete(...) --original tooltip creator
    AddEnglishName(...)
  end

end

-- Keeps
local function HookKeepTooltips()

  local englishKeepNames = KeepsStore
  ENGLISH_KEEP_COLOR = ZO_ColorDef:New(DestinationsSV.settings.EnglishColorKeeps)

  local function AnchorTo(control, anchorTo)
    local isValid, point, _, relPoint, offsetX, offsetY = control:GetAnchor(0)
    if isValid then
      control:ClearAnchors()
      control:SetAnchor(point, anchorTo, relPoint, offsetX, offsetY)
    end
  end

  local function ModifyKeepTooltip(self, keepId)
    local keepName = GetKeepName(keepId)
    local englishKeepName = englishKeepNames[keepId]
    local nameLabel = self:GetNamedChild("Name")
    local allianceLabel, guildLabel, englishLabel, lineHeight
    if self.lastLine and nameLabel then
      local lastLine = self.lastLine
      local previousLine
      while lastLine or lastLine ~= nameLabel do
        local anchoredTo = select(3, lastLine:GetAnchor(0))
        if anchoredTo == nameLabel then
          allianceLabel = lastLine
          guildLabel = previousLine
          break
        end
        previousLine = lastLine
        lastLine = anchoredTo
      end
    end
    if englishKeepName and DestinationsSV.settings.AddNewLineOnKeeps then
      englishLabel = self.linePool:AcquireObject()
      englishLabel:SetHidden(false)
      englishLabel:SetText(ENGLISH_KEEP_COLOR:Colorize(englishKeepName))
      englishLabel:SetAnchor(TOPLEFT, nameLabel, BOTTOMLEFT, 0, 3)
      lineHeight = englishLabel:GetHeight()
      if DestinationsSV.HideAllianceOnKeeps and allianceLabel then
        allianceLabel:SetHidden(true)
        if guildLabel then
          AnchorTo(guildLabel, englishLabel)
        end
      elseif allianceLabel then
        AnchorTo(allianceLabel, englishLabel)
        self.height = self.height + lineHeight + 3
      else
        self.height = self.height + lineHeight + 3
      end
      local width = englishLabel:GetTextWidth() + 16
      if width > self.width then
        self.width = width
      end
    elseif englishKeepName then
      nameLabel:SetText(zo_strformat("<<1>> (<<2>>)", keepName, ENGLISH_KEEP_COLOR:Colorize(englishKeepName)))
      local width = nameLabel:GetTextWidth() + 16
      if width > self.width then
        self.width = width
      end
    end
    if DestinationsSV.settings.HideAllianceOnKeeps and allianceLabel and not englishLabel then
      lineHeight = allianceLabel:GetHeight()
      allianceLabel:SetHidden(true)
      if guildLabel then
        AnchorTo(guildLabel, nameLabel)
      end
      self.height = self.height - lineHeight - 3
    end
    self:SetDimensions(self.width, self.height)
  end

  --hooks
  local SetKeep = ZO_KeepTooltip.SetKeep
  ZO_KeepTooltip.SetKeep = function(self, keepId, ...)
    SetKeep(self, keepId, ...) --original function
    if DestinationsSV.settings.AddEnglishOnKeeps then
      ModifyKeepTooltip(self, keepId)
    end
  end

  local RefreshKeep = ZO_KeepTooltip.RefreshKeepInfo
  ZO_KeepTooltip.RefreshKeepInfo = function(self, ...)
    RefreshKeep(self, ...)  --original function
    if self.keepId and self.battlegroundContext and self.historyPercent and DestinationsSV.settings.AddEnglishOnKeeps then
      ModifyKeepTooltip(self, self.keepId)
    end
  end

end

--[[TODO Figure out what this was for originally, not used in 27.0]]--
local function UpdateMapFilters()
  for pin, pinname in pairs(DPINS) do
    pin = "DPINS." .. pin
    if LMP:IsEnabled(pinname) and DestinationsCSSV.filters[pinname] then
      LMP:RefreshPins(pinname)
      if DestinationsCSSV.filters[DPINS.ACHIEVEMENTS_COMPASS] then
        COMPASS_PINS:RefreshPins(pinname)
      end
    end
    if string.find(pin, "UNKNOWN") then
      TogglePins(pinname, LMP:IsEnabled(DPINS.UNKNOWN))
    end
  end
end

local function ShowLanguageWarning()
  EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, EVENT_PLAYER_ACTIVATED)
  if Destinations.client_lang == "it" then
    CHAT_ROUTER:AddSystemMessage("Destinations non è localizzato correttamente dalla lingua italiana. Verranno utilizzati termini inglesi e non tutti i punti di interesse potrebbero essere classificati correttamente.")
  else
    CHAT_ROUTER:AddSystemMessage("Destinations is not properly localized for " .. Destinations.client_lang .. ".  English terms will be used and not all POIs may be properly classified.")
  end
end

local function DisableEnglishFunctionnalities()

  if Destinations.client_lang == "en" then
    DestinationsSV.settings.AddEnglishOnUnknwon = false
    DestinationsSV.settings.AddEnglishOnKeeps = false
  end

end

local function InitSettings()

  local LAM = LibAddonMenu2

  local panelData = {
    type = "panel",
    name = GetString(DEST_SETTINGS_TITLE),
    displayName = GetString(DEST_SETTINGS_TITLE),
    author = ADDON_AUTHOR,
    version = ADDON_VERSION,
    slashCommand = "/dset",
    registerForRefresh = true,
    registerForDefaults = true,
    website = ADDON_WEBSITE,
  }

  local settingsPanel = LAM:RegisterAddonPanel("Destinations_OptionsPanel", panelData)

  local optionsTable = {}

  --Icon Preview

  local unknownPoiPreview, otherPreview, otherPreviewDone, MaiqPreview, MaiqPreviewDone, PeacemakerPreview, PeacemakerPreviewDone, NosediverPreview, NosediverPreviewDone
  local EarthlyPosPreview, EarthlyPosPreviewDone, OnMePreview, OnMePreviewDone, BrawlPreview, BrawlPreviewDone, PatronPreview, PatronPreviewDone
  local WrothgarJumperPreview, WrothgarJumperPreviewDone, RelicHunterPreview, RelicHunterPreviewDone, BreakingPreview, BreakingPreviewDone, CutpursePreview, CutpursePreviewDone
  local ChampionPreview, ChampionPreviewDone, AyleidPreview, DeadlandsPreview, HighIslePreview, DwemerPreview, WWVampPreview, VampAltarPreview, WWShrinePreview
  local CollectiblePreview, CollectibleDonePreview, FishPreview, FishDonePreview

  CreateIcons = function(panel)
    if panel == settingsPanel then
      unknownPoiPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureUnknown, CT_TEXTURE)
      unknownPoiPreview:SetAnchor(RIGHT, previewpinTextureUnknown.dropdown:GetControl(), LEFT, -10, 0)
      unknownPoiPreview:SetTexture(pinTextures.paths.Unknown[DestinationsSV.pins.pinTextureUnknown.type])
      unknownPoiPreview:SetDimensions(DestinationsSV.pins.pinTextureUnknown.size,
        DestinationsSV.pins.pinTextureUnknown.size)
      unknownPoiPreview:SetColor(unpack(DestinationsSV.pins.pinTextureUnknown.tint))

      otherPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureOther, CT_TEXTURE)
      otherPreview:SetAnchor(RIGHT, previewpinTextureOther.dropdown:GetControl(), LEFT, -40, 0)
      otherPreview:SetTexture(pinTextures.paths.Other[DestinationsSV.pins.pinTextureOther.type])
      otherPreview:SetDimensions(DestinationsSV.pins.pinTextureOther.size, DestinationsSV.pins.pinTextureOther.size)
      otherPreview:SetColor(unpack(DestinationsSV.pins.pinTextureOther.tint))

      otherPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureOther, CT_TEXTURE)
      otherPreviewDone:SetAnchor(RIGHT, previewpinTextureOther.dropdown:GetControl(), LEFT, -5, 0)
      otherPreviewDone:SetTexture(pinTextures.paths.OtherDone[DestinationsSV.pins.pinTextureOtherDone.type])
      otherPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureOtherDone.size,
        DestinationsSV.pins.pinTextureOtherDone.size)
      otherPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureOtherDone.tint))

      ChampionPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureChampion, CT_TEXTURE)
      ChampionPreview:SetAnchor(RIGHT, previewpinTextureChampion.dropdown:GetControl(), LEFT, -40, 0)
      ChampionPreview:SetTexture(pinTextures.paths.Champion[DestinationsSV.pins.pinTextureChampion.type])
      ChampionPreview:SetDimensions(DestinationsSV.pins.pinTextureChampion.size,
        DestinationsSV.pins.pinTextureChampion.size)
      ChampionPreview:SetColor(unpack(DestinationsSV.pins.pinTextureChampion.tint))

      ChampionPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureChampion, CT_TEXTURE)
      ChampionPreviewDone:SetAnchor(RIGHT, previewpinTextureChampion.dropdown:GetControl(), LEFT, -5, 0)
      ChampionPreviewDone:SetTexture(pinTextures.paths.ChampionDone[DestinationsSV.pins.pinTextureChampionDone.type])
      ChampionPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureChampionDone.size,
        DestinationsSV.pins.pinTextureChampionDone.size)
      ChampionPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureChampion.tint))

      MaiqPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureMaiq, CT_TEXTURE)
      MaiqPreview:SetAnchor(RIGHT, previewpinTextureMaiq.dropdown:GetControl(), LEFT, -40, 0)
      MaiqPreview:SetTexture(pinTextures.paths.Maiq[DestinationsSV.pins.pinTextureMaiq.type])
      MaiqPreview:SetDimensions(DestinationsSV.pins.pinTextureMaiq.size, DestinationsSV.pins.pinTextureMaiq.size)
      MaiqPreview:SetColor(unpack(DestinationsSV.pins.pinTextureMaiq.tint))

      MaiqPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureMaiq, CT_TEXTURE)
      MaiqPreviewDone:SetAnchor(RIGHT, previewpinTextureMaiq.dropdown:GetControl(), LEFT, -5, 0)
      MaiqPreviewDone:SetTexture(pinTextures.paths.MaiqDone[DestinationsSV.pins.pinTextureMaiqDone.type])
      MaiqPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureMaiqDone.size,
        DestinationsSV.pins.pinTextureMaiqDone.size)
      MaiqPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureMaiqDone.tint))

      PeacemakerPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTexturePeacemaker, CT_TEXTURE)
      PeacemakerPreview:SetAnchor(RIGHT, previewpinTexturePeacemaker.dropdown:GetControl(), LEFT, -40, 0)
      PeacemakerPreview:SetTexture(pinTextures.paths.Peacemaker[DestinationsSV.pins.pinTexturePeacemaker.type])
      PeacemakerPreview:SetDimensions(DestinationsSV.pins.pinTexturePeacemaker.size,
        DestinationsSV.pins.pinTexturePeacemaker.size)
      PeacemakerPreview:SetColor(unpack(DestinationsSV.pins.pinTexturePeacemaker.tint))

      PeacemakerPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTexturePeacemaker, CT_TEXTURE)
      PeacemakerPreviewDone:SetAnchor(RIGHT, previewpinTexturePeacemaker.dropdown:GetControl(), LEFT, -5, 0)
      PeacemakerPreviewDone:SetTexture(pinTextures.paths.PeacemakerDone[DestinationsSV.pins.pinTexturePeacemakerDone.type])
      PeacemakerPreviewDone:SetDimensions(DestinationsSV.pins.pinTexturePeacemakerDone.size,
        DestinationsSV.pins.pinTexturePeacemakerDone.size)
      PeacemakerPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTexturePeacemakerDone.tint))

      NosediverPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureNosediver, CT_TEXTURE)
      NosediverPreview:SetAnchor(RIGHT, previewpinTextureNosediver.dropdown:GetControl(), LEFT, -40, 0)
      NosediverPreview:SetTexture(pinTextures.paths.Nosediver[DestinationsSV.pins.pinTextureNosediver.type])
      NosediverPreview:SetDimensions(DestinationsSV.pins.pinTextureNosediver.size,
        DestinationsSV.pins.pinTextureNosediver.size)
      NosediverPreview:SetColor(unpack(DestinationsSV.pins.pinTextureNosediver.tint))

      NosediverPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureNosediver, CT_TEXTURE)
      NosediverPreviewDone:SetAnchor(RIGHT, previewpinTextureNosediver.dropdown:GetControl(), LEFT, -5, 0)
      NosediverPreviewDone:SetTexture(pinTextures.paths.NosediverDone[DestinationsSV.pins.pinTextureNosediverDone.type])
      NosediverPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureNosediverDone.size,
        DestinationsSV.pins.pinTextureNosediverDone.size)
      NosediverPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureNosediverDone.tint))

      EarthlyPosPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureEarthlyPos, CT_TEXTURE)
      EarthlyPosPreview:SetAnchor(RIGHT, previewpinTextureEarthlyPos.dropdown:GetControl(), LEFT, -40, 0)
      EarthlyPosPreview:SetTexture(pinTextures.paths.Earthlypos[DestinationsSV.pins.pinTextureEarthlyPos.type])
      EarthlyPosPreview:SetDimensions(DestinationsSV.pins.pinTextureEarthlyPos.size,
        DestinationsSV.pins.pinTextureEarthlyPos.size)
      EarthlyPosPreview:SetColor(unpack(DestinationsSV.pins.pinTextureEarthlyPos.tint))

      EarthlyPosPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureEarthlyPos, CT_TEXTURE)
      EarthlyPosPreviewDone:SetAnchor(RIGHT, previewpinTextureEarthlyPos.dropdown:GetControl(), LEFT, -5, 0)
      EarthlyPosPreviewDone:SetTexture(pinTextures.paths.EarthlyposDone[DestinationsSV.pins.pinTextureEarthlyPosDone.type])
      EarthlyPosPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureEarthlyPosDone.size,
        DestinationsSV.pins.pinTextureEarthlyPosDone.size)
      EarthlyPosPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureEarthlyPosDone.tint))

      OnMePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureOnMe, CT_TEXTURE)
      OnMePreview:SetAnchor(RIGHT, previewpinTextureOnMe.dropdown:GetControl(), LEFT, -40, 0)
      OnMePreview:SetTexture(pinTextures.paths.OnMe[DestinationsSV.pins.pinTextureOnMe.type])
      OnMePreview:SetDimensions(DestinationsSV.pins.pinTextureOnMe.size, DestinationsSV.pins.pinTextureOnMe.size)
      OnMePreview:SetColor(unpack(DestinationsSV.pins.pinTextureOnMe.tint))

      OnMePreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureOnMe, CT_TEXTURE)
      OnMePreviewDone:SetAnchor(RIGHT, previewpinTextureOnMe.dropdown:GetControl(), LEFT, -5, 0)
      OnMePreviewDone:SetTexture(pinTextures.paths.OnMeDone[DestinationsSV.pins.pinTextureOnMeDone.type])
      OnMePreviewDone:SetDimensions(DestinationsSV.pins.pinTextureOnMeDone.size,
        DestinationsSV.pins.pinTextureOnMeDone.size)
      OnMePreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureOnMeDone.tint))

      BrawlPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureBrawl, CT_TEXTURE)
      BrawlPreview:SetAnchor(RIGHT, previewpinTextureBrawl.dropdown:GetControl(), LEFT, -40, 0)
      BrawlPreview:SetTexture(pinTextures.paths.Brawl[DestinationsSV.pins.pinTextureBrawl.type])
      BrawlPreview:SetDimensions(DestinationsSV.pins.pinTextureBrawl.size, DestinationsSV.pins.pinTextureBrawl.size)
      BrawlPreview:SetColor(unpack(DestinationsSV.pins.pinTextureBrawl.tint))

      BrawlPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureBrawl, CT_TEXTURE)
      BrawlPreviewDone:SetAnchor(RIGHT, previewpinTextureBrawl.dropdown:GetControl(), LEFT, -5, 0)
      BrawlPreviewDone:SetTexture(pinTextures.paths.BrawlDone[DestinationsSV.pins.pinTextureBrawlDone.type])
      BrawlPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureBrawlDone.size,
        DestinationsSV.pins.pinTextureBrawlDone.size)
      BrawlPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureBrawlDone.tint))

      PatronPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTexturePatron, CT_TEXTURE)
      PatronPreview:SetAnchor(RIGHT, previewpinTexturePatron.dropdown:GetControl(), LEFT, -40, 0)
      PatronPreview:SetTexture(pinTextures.paths.Patron[DestinationsSV.pins.pinTexturePatron.type])
      PatronPreview:SetDimensions(DestinationsSV.pins.pinTexturePatron.size, DestinationsSV.pins.pinTexturePatron.size)
      PatronPreview:SetColor(unpack(DestinationsSV.pins.pinTexturePatron.tint))

      PatronPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTexturePatron, CT_TEXTURE)
      PatronPreviewDone:SetAnchor(RIGHT, previewpinTexturePatron.dropdown:GetControl(), LEFT, -5, 0)
      PatronPreviewDone:SetTexture(pinTextures.paths.PatronDone[DestinationsSV.pins.pinTexturePatronDone.type])
      PatronPreviewDone:SetDimensions(DestinationsSV.pins.pinTexturePatronDone.size,
        DestinationsSV.pins.pinTexturePatronDone.size)
      PatronPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTexturePatronDone.tint))

      WrothgarJumperPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureWrothgarJumper, CT_TEXTURE)
      WrothgarJumperPreview:SetAnchor(RIGHT, previewpinTextureWrothgarJumper.dropdown:GetControl(), LEFT, -40, 0)
      WrothgarJumperPreview:SetTexture(pinTextures.paths.WrothgarJumper[DestinationsSV.pins.pinTextureWrothgarJumper.type])
      WrothgarJumperPreview:SetDimensions(DestinationsSV.pins.pinTextureWrothgarJumper.size,
        DestinationsSV.pins.pinTextureWrothgarJumper.size)
      WrothgarJumperPreview:SetColor(unpack(DestinationsSV.pins.pinTextureWrothgarJumper.tint))

      WrothgarJumperPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureWrothgarJumper, CT_TEXTURE)
      WrothgarJumperPreviewDone:SetAnchor(RIGHT, previewpinTextureWrothgarJumper.dropdown:GetControl(), LEFT, -5, 0)
      WrothgarJumperPreviewDone:SetTexture(pinTextures.paths.WrothgarJumperDone[DestinationsSV.pins.pinTextureWrothgarJumperDone.type])
      WrothgarJumperPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureWrothgarJumperDone.size,
        DestinationsSV.pins.pinTextureWrothgarJumperDone.size)
      WrothgarJumperPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureWrothgarJumperDone.tint))

      RelicHunterPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureRelicHunter, CT_TEXTURE)
      RelicHunterPreview:SetAnchor(RIGHT, previewpinTextureRelicHunter.dropdown:GetControl(), LEFT, -40, 0)
      RelicHunterPreview:SetTexture(pinTextures.paths.RelicHunter[DestinationsSV.pins.pinTextureRelicHunter.type])
      RelicHunterPreview:SetDimensions(DestinationsSV.pins.pinTextureRelicHunter.size,
        DestinationsSV.pins.pinTextureRelicHunter.size)
      RelicHunterPreview:SetColor(unpack(DestinationsSV.pins.pinTextureRelicHunter.tint))

      RelicHunterPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureRelicHunter, CT_TEXTURE)
      RelicHunterPreviewDone:SetAnchor(RIGHT, previewpinTextureRelicHunter.dropdown:GetControl(), LEFT, -5, 0)
      RelicHunterPreviewDone:SetTexture(pinTextures.paths.RelicHunterDone[DestinationsSV.pins.pinTextureRelicHunterDone.type])
      RelicHunterPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureRelicHunterDone.size,
        DestinationsSV.pins.pinTextureRelicHunterDone.size)
      RelicHunterPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureRelicHunterDone.tint))

      BreakingPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureBreaking, CT_TEXTURE)
      BreakingPreview:SetAnchor(RIGHT, previewpinTextureBreaking.dropdown:GetControl(), LEFT, -40, 0)
      BreakingPreview:SetTexture(pinTextures.paths.Breaking[DestinationsSV.pins.pinTextureBreaking.type])
      BreakingPreview:SetDimensions(DestinationsSV.pins.pinTextureBreaking.size,
        DestinationsSV.pins.pinTextureBreaking.size)
      BreakingPreview:SetColor(unpack(DestinationsSV.pins.pinTextureBreaking.tint))

      BreakingPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureBreaking, CT_TEXTURE)
      BreakingPreviewDone:SetAnchor(RIGHT, previewpinTextureBreaking.dropdown:GetControl(), LEFT, -5, 0)
      BreakingPreviewDone:SetTexture(pinTextures.paths.BreakingDone[DestinationsSV.pins.pinTextureBreakingDone.type])
      BreakingPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureBreakingDone.size,
        DestinationsSV.pins.pinTextureBreakingDone.size)
      BreakingPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureBreakingDone.tint))

      CutpursePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureCutpurse, CT_TEXTURE)
      CutpursePreview:SetAnchor(RIGHT, previewpinTextureCutpurse.dropdown:GetControl(), LEFT, -40, 0)
      CutpursePreview:SetTexture(pinTextures.paths.Cutpurse[DestinationsSV.pins.pinTextureCutpurse.type])
      CutpursePreview:SetDimensions(DestinationsSV.pins.pinTextureCutpurse.size,
        DestinationsSV.pins.pinTextureCutpurse.size)
      CutpursePreview:SetColor(unpack(DestinationsSV.pins.pinTextureCutpurse.tint))

      CutpursePreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureCutpurse, CT_TEXTURE)
      CutpursePreviewDone:SetAnchor(RIGHT, previewpinTextureCutpurse.dropdown:GetControl(), LEFT, -5, 0)
      CutpursePreviewDone:SetTexture(pinTextures.paths.CutpurseDone[DestinationsSV.pins.pinTextureCutpurseDone.type])
      CutpursePreviewDone:SetDimensions(DestinationsSV.pins.pinTextureCutpurseDone.size,
        DestinationsSV.pins.pinTextureCutpurseDone.size)
      CutpursePreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureCutpurseDone.tint))

      AyleidPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureAyleid, CT_TEXTURE)
      AyleidPreview:SetAnchor(RIGHT, previewpinTextureAyleid.dropdown:GetControl(), LEFT, -10, 0)
      AyleidPreview:SetTexture(pinTextures.paths.Ayleid[DestinationsSV.pins.pinTextureAyleid.type])
      AyleidPreview:SetDimensions(DestinationsSV.pins.pinTextureAyleid.size, DestinationsSV.pins.pinTextureAyleid.size)
      AyleidPreview:SetColor(unpack(DestinationsSV.pins.pinTextureAyleid.tint))

      -- Deadlands
      DeadlandsPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureDeadlands, CT_TEXTURE)
      DeadlandsPreview:SetAnchor(RIGHT, previewpinTextureDeadlands.dropdown:GetControl(), LEFT, -10, 0)
      DeadlandsPreview:SetTexture(pinTextures.paths.Deadlands[DestinationsSV.pins.pinTextureDeadlands.type])
      DeadlandsPreview:SetDimensions(DestinationsSV.pins.pinTextureDeadlands.size, DestinationsSV.pins.pinTextureDeadlands.size)
      DeadlandsPreview:SetColor(unpack(DestinationsSV.pins.pinTextureDeadlands.tint))

      -- HighIsle
      HighIslePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureHighIsle, CT_TEXTURE)
      HighIslePreview:SetAnchor(RIGHT, previewpinTextureHighIsle.dropdown:GetControl(), LEFT, -10, 0)
      HighIslePreview:SetTexture(pinTextures.paths.HighIsle[DestinationsSV.pins.pinTextureHighIsle.type])
      HighIslePreview:SetDimensions(DestinationsSV.pins.pinTextureHighIsle.size, DestinationsSV.pins.pinTextureHighIsle.size)
      HighIslePreview:SetColor(unpack(DestinationsSV.pins.pinTextureHighIsle.tint))

      DwemerPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureDwemer, CT_TEXTURE)
      DwemerPreview:SetAnchor(RIGHT, previewpinTextureDwemer.dropdown:GetControl(), LEFT, -10, 0)
      DwemerPreview:SetTexture(pinTextures.paths.dwemer[DestinationsSV.pins.pinTextureDwemer.type])
      DwemerPreview:SetDimensions(DestinationsSV.pins.pinTextureDwemer.size, DestinationsSV.pins.pinTextureDwemer.size)
      DwemerPreview:SetColor(unpack(DestinationsSV.pins.pinTextureDwemer.tint))

      WWVampPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureWWVamp, CT_TEXTURE)
      WWVampPreview:SetAnchor(RIGHT, previewpinTextureWWVamp.dropdown:GetControl(), LEFT, -10, 0)
      WWVampPreview:SetTexture(pinTextures.paths.wwvamp[DestinationsSV.pins.pinTextureWWVamp.type])
      WWVampPreview:SetDimensions(DestinationsSV.pins.pinTextureWWVamp.size, DestinationsSV.pins.pinTextureWWVamp.size)
      WWVampPreview:SetColor(unpack(DestinationsSV.pins.pinTextureWWVamp.tint))

      VampAltarPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureVampAltar, CT_TEXTURE)
      VampAltarPreview:SetAnchor(RIGHT, previewpinTextureVampAltar.dropdown:GetControl(), LEFT, -10, 0)
      VampAltarPreview:SetTexture(pinTextures.paths.vampirealtar[DestinationsSV.pins.pinTextureVampAltar.type])
      VampAltarPreview:SetDimensions(DestinationsSV.pins.pinTextureVampAltar.size,
        DestinationsSV.pins.pinTextureVampAltar.size)
      VampAltarPreview:SetColor(unpack(DestinationsSV.pins.pinTextureVampAltar.tint))

      WWShrinePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureWWShrine, CT_TEXTURE)
      WWShrinePreview:SetAnchor(RIGHT, previewpinTextureWWShrine.dropdown:GetControl(), LEFT, -10, 0)
      WWShrinePreview:SetTexture(pinTextures.paths.werewolfshrine[DestinationsSV.pins.pinTextureWWShrine.type])
      WWShrinePreview:SetDimensions(DestinationsSV.pins.pinTextureWWShrine.size,
        DestinationsSV.pins.pinTextureWWShrine.size)
      WWShrinePreview:SetColor(unpack(DestinationsSV.pins.pinTextureWWShrine.tint))

      CollectiblePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureCollectible, CT_TEXTURE)
      CollectiblePreview:SetAnchor(RIGHT, previewpinTextureCollectible.dropdown:GetControl(), LEFT, -40, 0)
      CollectiblePreview:SetTexture(pinTextures.paths.collectible[DestinationsSV.pins.pinTextureCollectible.type])
      CollectiblePreview:SetDimensions(DestinationsSV.pins.pinTextureCollectible.size,
        DestinationsSV.pins.pinTextureCollectible.size)
      CollectiblePreview:SetColor(unpack(DestinationsSV.pins.pinTextureCollectible.tint))

      CollectibleDonePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureCollectible, CT_TEXTURE)
      CollectibleDonePreview:SetAnchor(RIGHT, previewpinTextureCollectible.dropdown:GetControl(), LEFT, -5, 0)
      CollectibleDonePreview:SetTexture(pinTextures.paths.collectibledone[DestinationsSV.pins.pinTextureCollectibleDone.type])
      CollectibleDonePreview:SetDimensions(DestinationsSV.pins.pinTextureCollectibleDone.size,
        DestinationsSV.pins.pinTextureCollectibleDone.size)
      CollectibleDonePreview:SetColor(unpack(DestinationsSV.pins.pinTextureCollectibleDone.tint))

      FishPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureFish, CT_TEXTURE)
      FishPreview:SetAnchor(RIGHT, previewpinTextureFish.dropdown:GetControl(), LEFT, -40, 0)
      FishPreview:SetTexture(pinTextures.paths.fish[DestinationsSV.pins.pinTextureFish.type])
      FishPreview:SetDimensions(DestinationsSV.pins.pinTextureFish.size, DestinationsSV.pins.pinTextureFish.size)
      FishPreview:SetColor(unpack(DestinationsSV.pins.pinTextureFish.tint))

      FishDonePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureFish, CT_TEXTURE)
      FishDonePreview:SetAnchor(RIGHT, previewpinTextureFish.dropdown:GetControl(), LEFT, -5, 0)
      FishDonePreview:SetTexture(pinTextures.paths.fishdone[DestinationsSV.pins.pinTextureFishDone.type])
      FishDonePreview:SetDimensions(DestinationsSV.pins.pinTextureFishDone.size,
        DestinationsSV.pins.pinTextureFishDone.size)
      FishDonePreview:SetColor(unpack(DestinationsSV.pins.pinTextureFishDone.tint))

      CALLBACK_MANAGER:UnregisterCallback("LAM-PanelControlsCreated", CreateIcons)
    end
  end

  CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", CreateIcons)

  local function GetDestinationsLAMSubMenu(menu)

    local submenu = {}

    if menu == "Improvement" then

      --[[

                        {
                type = "colorpicker",
                name = GetString(POINAMES_POI_COL),
                tooltip = GetString(POINAMES_POI_COL_DESC),
                getFunc = function() return POI_COLOR:UnpackRGBA() end,
                setFunc = function(...)
                        POI_COLOR:SetRGBA(...)
                        db.colorPOI = POI_COLOR:ToHex()
                    end,
                width = "full",
                default = ZO_HIGHLIGHT_TEXT,
            },
            {
                type = "colorpicker",
                name = GetString(POINAMES_KEEP_COL),
                tooltip = GetString(POINAMES_KEEP_COL_DESC),
                getFunc = function() return KEEP_COLOR:UnpackRGBA() end,
                setFunc = function(...)
                        KEEP_COLOR:SetRGBA(...)
                        db.colorKeep = KEEP_COLOR:ToHex()
                    end,
                width = "full",
                default = STAT_DIMINISHING_RETURNS_COLOR,
            }
            ]]

      submenu = {
        { -- Add english name of POI
          type = "checkbox",
          name = GetString(DEST_SETTINGS_POI_SHOW_ENGLISH),
          tooltip = GetString(DEST_SETTINGS_POI_SHOW_ENGLISH_TT),
          getFunc = function() return DestinationsSV.settings.AddEnglishOnUnknwon end,
          setFunc = function(state) DestinationsSV.settings.AddEnglishOnUnknwon = state end,
          default = defaults.settings.AddEnglishOnUnknwon,
          disabled = function() return Destinations.client_lang == "en" end,
        },
        { -- Color of English name
          type = "colorpicker",
          name = GetString(DEST_SETTINGS_POI_ENGLISH_COLOR),
          tooltip = GetString(DEST_SETTINGS_POI_ENGLISH_COLOR_TT),
          getFunc = function() return ENGLISH_POI_COLOR:UnpackRGBA() end,
          setFunc = function(...)
            ENGLISH_POI_COLOR:SetRGBA(...)
            DestinationsSV.settings.EnglishColorPOI = ENGLISH_POI_COLOR:ToHex()
          end,
          default = ZO_HIGHLIGHT_TEXT,
          disabled = function() return not DestinationsSV.settings.AddEnglishOnUnknwon end,
        },
        { -- Add English name on Keeps
          type = "checkbox",
          name = GetString(DEST_SETTINGS_POI_SHOW_ENGLISH_KEEPS),
          tooltip = GetString(DEST_SETTINGS_POI_SHOW_ENGLISH_KEEPS_TT),
          getFunc = function() return DestinationsSV.settings.AddEnglishOnKeeps end,
          setFunc = function(state) DestinationsSV.settings.AddEnglishOnKeeps = state end,
          default = defaults.settings.AddEnglishOnKeeps,
          disabled = function() return Destinations.client_lang == "en" end,
        },
        { -- Color for English name on Keeps
          type = "colorpicker",
          name = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_COLOR),
          tooltip = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_COLOR_TT),
          getFunc = function() return ENGLISH_KEEP_COLOR:UnpackRGBA() end,
          setFunc = function(...)
            ENGLISH_KEEP_COLOR:SetRGBA(...)
            DestinationsSV.settings.EnglishColorKeeps = ENGLISH_KEEP_COLOR:ToHex()
          end,
          default = STAT_DIMINISHING_RETURNS_COLOR,
          disabled = function() return not DestinationsSV.settings.AddEnglishOnKeeps end,
        },
        { -- Hide alliance on keep tooltips
          type = "checkbox",
          name = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_HA),
          tooltip = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_HA_TT),
          getFunc = function() return DestinationsSV.settings.HideAllianceOnKeeps end,
          setFunc = function(value) DestinationsSV.settings.HideAllianceOnKeeps = value end,
          default = DestinationsSV.settings.HideAllianceOnKeeps,
          disabled = function() return not DestinationsSV.settings.AddEnglishOnKeeps end,
        },
        { -- Add a new line for english name on keep tooltips
          type = "checkbox",
          name = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_NL),
          tooltip = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_NL_TT),
          getFunc = function() return DestinationsSV.settings.AddNewLineOnKeeps end,
          setFunc = function(value) DestinationsSV.settings.AddNewLineOnKeeps = value end,
          default = defaults.settings.AddNewLineOnKeeps,
          disabled = function() return not DestinationsSV.settings.AddEnglishOnKeeps end,
        },
        { -- Improve Mundus POI
          type = "checkbox",
          name = GetString(DEST_SETTINGS_POI_IMPROVE_MUNDUS),
          tooltip = GetString(DEST_SETTINGS_POI_IMPROVE_MUNDUS_TT),
          getFunc = function() return DestinationsSV.settings.ImproveMundus end,
          setFunc = function(state) DestinationsSV.settings.ImproveMundus = state end,
          default = defaults.settings.ImproveMundus,
        },
        { -- Improve Crafting Stations POI
          type = "checkbox",
          name = GetString(DEST_SETTINGS_POI_IMPROVE_CRAFTING),
          tooltip = GetString(DEST_SETTINGS_POI_IMPROVE_CRAFTING_TT),
          getFunc = function() return DestinationsSV.settings.ImproveCrafting end,
          setFunc = function(state) DestinationsSV.settings.ImproveCrafting = state end,
          default = defaults.settings.ImproveCrafting,
        },
      }

    elseif menu == "POI" then

      table.insert(submenu, { -- Unknown pin toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_UNKNOWN_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.UNKNOWN] end,
        setFunc = function(state)
          TogglePins(DPINS.UNKNOWN, state)
        end,
        default = defaults.filters[DPINS.UNKNOWN],
      })
      table.insert(submenu, { -- Unknown pin style
        type = "dropdown",
        name = defaults.miscColorCodes.settingsTextUnknown:Colorize(GetString(DEST_SETTINGS_UNKNOWN_PIN_STYLE)),
        reference = "previewpinTextureUnknown",
        choices = pinTextures.lists.Unknown,
        getFunc = function() return pinTextures.lists.Unknown[DestinationsSV.pins.pinTextureUnknown.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Unknown) do
            if name == selected then
              DestinationsSV.pins.pinTextureUnknown.type = index

              if index == 7 then
                DestinationsSV.pins.pinTextureUnknown.tint = defaults.pins.pinTextureUnknown.tint
              else
                DestinationsSV.pins.pinTextureUnknown.tint = defaults.pins.pinTextureUnknownOthers.tint
              end

              LMP:SetLayoutKey(DPINS.UNKNOWN, "tint", unpack(DestinationsSV.pins.pinTextureUnknown))

              unknownPoiPreview:SetTexture(pinTextures.paths.Unknown[index])
              unknownPoiPreview:SetColor(unpack(DestinationsSV.pins.pinTextureUnknown.tint))

              OnPOIUpdated()

              break
            end
          end
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.UNKNOWN] end,
        default = pinTextures.lists.Unknown[defaults.pins.pinTextureUnknown.type],
      })
      table.insert(submenu, { -- Unknown pin size
        type = "slider",
        name = defaults.miscColorCodes.settingsTextUnknown:Colorize(GetString(DEST_SETTINGS_UNKNOWN_PIN_SIZE)),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureUnknown.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureUnknown.size = size
          unknownPoiPreview:SetDimensions(size, size)
          SetUnknownDestLayoutKey("size", size)
          OnPOIUpdated()
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.UNKNOWN] end,
        default = defaults.pins.pinTextureUnknown.size
      })
      table.insert(submenu, { -- Unknown pin layer
        type = "slider",
        name = defaults.miscColorCodes.settingsTextUnknown:Colorize(GetString(DEST_SETTINGS_UNKNOWN_PIN_LAYER)),
        min = 10,
        max = 200,
        step = 5,
        getFunc = function() return DestinationsSV.pins.pinTextureUnknown.level end,
        setFunc = function(level)
          DestinationsSV.pins.pinTextureUnknown.level = level
          SetUnknownDestLayoutKey("level", level)
          OnPOIUpdated()
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.UNKNOWN] end,
        default = defaults.pins.pinTextureUnknown.level
      })
      table.insert(submenu, { -- Unknown pin text color
        type = "colorpicker",
        name = defaults.miscColorCodes.settingsTextUnknown:Colorize(GetString(DEST_SETTINGS_UNKNOWN_COLOR)),
        tooltip = GetString(DEST_SETTINGS_UNKNOWN_COLOR_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureUnknown.textcolor) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureUnknown.textcolor = { r, g, b }
          OnPOIUpdated()
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.UNKNOWN] end,
        default = { r = defaults.pins.pinTextureUnknown.textcolor[1], g = defaults.pins.pinTextureUnknown.textcolor[2], b = defaults.pins.pinTextureUnknown.textcolor[3] }
      })

    elseif menu == "Achievements" then

      table.insert(submenu, { -- Champion Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_CHAMPION_PIN_HEADER)),
      })
      table.insert(submenu, { -- Champion global pin toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.CHAMPION] end,
        setFunc = function(state)
          TogglePins(DPINS.CHAMPION, state)
          RedrawAllPins(DPINS.CHAMPION)
        end,
        default = defaults.filters[DPINS.CHAMPION],
      })
      table.insert(submenu, { -- Champion Done global pin toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.CHAMPION_DONE] end,
        setFunc = function(state)
          TogglePins(DPINS.CHAMPION_DONE, state)
          RedrawAllPins(DPINS.CHAMPION_DONE)
        end,
        default = defaults.filters[DPINS.CHAMPION_DONE],
      })
      table.insert(submenu, { -- Champion zone pin toggle
        type = "checkbox",
        name = GetString(DEST_SETTINGS_ACH_CHAMPION_ZONE_PIN_TOGGLE),
        getFunc = function() return DestinationsSV.settings.ShowDungeonBossesInZones end,
        setFunc = function(state)
          DestinationsSV.settings.ShowDungeonBossesInZones = state
          RedrawAllPins(DPINS.CHAMPION)
          RedrawAllPins(DPINS.CHAMPION_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.CHAMPION] and
          not DestinationsCSSV.filters[DPINS.CHAMPION_DONE]
        end,
        default = defaults.settings.ShowDungeonBossesInZones,
      })
      table.insert(submenu, { -- Champion zone pin to front/back
        type = "checkbox",
        name = GetString(DEST_SETTINGS_ACH_CHAMPION_FRONT_PIN_TOGGLE),
        tooltip = GetString(DEST_SETTINGS_ACH_CHAMPION_FRONT_PIN_TOGGLE_TT),
        getFunc = function() return DestinationsSV.settings.ShowDungeonBossesOnTop end,
        setFunc = function(state)
          if state == true then
            DestinationsSV.pins.pinTextureChampion.level = 56 + 1
            DestinationsSV.pins.pinTextureChampionDone.level = 56
            LMP:SetLayoutKey(DPINS.CHAMPION, "level", 56 + 1)
            LMP:SetLayoutKey(DPINS.CHAMPION_DONE, "level", 56)
          else
            DestinationsSV.pins.pinTextureChampion.level = 30 + 1
            DestinationsSV.pins.pinTextureChampionDone.level = 30
            LMP:SetLayoutKey(DPINS.CHAMPION, "level", 30 + 1)
            LMP:SetLayoutKey(DPINS.CHAMPION_DONE, "level", 30)
          end
          DestinationsSV.settings.ShowDungeonBossesOnTop = state
          RedrawAllPins(DPINS.CHAMPION)
          RedrawAllPins(DPINS.CHAMPION_DONE)
        end,
        disabled = function() return
        (not DestinationsCSSV.filters[DPINS.CHAMPION] and
          not DestinationsCSSV.filters[DPINS.CHAMPION_DONE]) or
          not DestinationsSV.settings.ShowDungeonBossesInZones
        end,
        default = defaults.settings.ShowDungeonBossesOnTop,
      })
      table.insert(submenu, { -- Champion pin style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
        reference = "previewpinTextureChampion",
        choices = pinTextures.lists.Champion,
        getFunc = function() return pinTextures.lists.Champion[DestinationsSV.pins.pinTextureChampion.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Champion) do
            if name == selected then
              DestinationsSV.pins.pinTextureChampion.type = index
              DestinationsSV.pins.pinTextureChampionDone.type = index
              LMP:SetLayoutKey(DPINS.CHAMPION, "texture", pinTextures.paths.Champion[index])
              LMP:SetLayoutKey(DPINS.CHAMPION_DONE, "texture", pinTextures.paths.ChampionDone[index])
              ChampionPreview:SetTexture(pinTextures.paths.Champion[index])
              ChampionPreviewDone:SetTexture(pinTextures.paths.ChampionDone[index])
              RedrawAllPins(DPINS.CHAMPION)
              RedrawAllPins(DPINS.CHAMPION_DONE)
              break
            end
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.CHAMPION] and
          not DestinationsCSSV.filters[DPINS.CHAMPION_DONE]
        end,
        default = pinTextures.lists.Champion[defaults.pins.pinTextureChampion.type],
      })
      table.insert(submenu, { -- Champion pin size
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureChampion.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureChampion.size = size
          DestinationsSV.pins.pinTextureChampionDone.size = size
          ChampionPreview:SetDimensions(size, size)
          ChampionPreviewDone:SetDimensions(size, size)
          LMP:SetLayoutKey(DPINS.CHAMPION, "size", size)
          LMP:SetLayoutKey(DPINS.CHAMPION_DONE, "size", size)
          RedrawAllPins(DPINS.CHAMPION)
          RedrawAllPins(DPINS.CHAMPION_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.CHAMPION] and
          not DestinationsCSSV.filters[DPINS.CHAMPION_DONE]
        end,
        default = defaults.pins.pinTextureChampion.size
      })
      table.insert(submenu, { -- Achievement Other Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_OTHER_HEADER)),
      })
      table.insert(submenu, { -- Achievement Other Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.LB_GTTP_CP] end,
        setFunc = function(state)
          TogglePins(DPINS.LB_GTTP_CP, state)
          RedrawAllPins(DPINS.LB_GTTP_CP)
        end,
        default = defaults.filters[DPINS.LB_GTTP_CP],
      })
      table.insert(submenu, { -- Achievement Other Done Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.LB_GTTP_CP_DONE] end,
        setFunc = function(state)
          TogglePins(DPINS.LB_GTTP_CP_DONE, state)
          RedrawAllPins(DPINS.LB_GTTP_CP_DONE)
        end,
        default = defaults.filters[DPINS.LB_GTTP_CP_DONE],
      })
      table.insert(submenu, { -- Achievement Other Style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
        reference = "previewpinTextureOther",
        choices = pinTextures.lists.Other,
        getFunc = function() return pinTextures.lists.Other[DestinationsSV.pins.pinTextureOther.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Other) do
            if name == selected then
              DestinationsSV.pins.pinTextureOther.type = index
              DestinationsSV.pins.pinTextureOtherDone.type = index
              LMP:SetLayoutKey(DPINS.LB_GTTP_CP, "texture", pinTextures.paths.Other[index])
              LMP:SetLayoutKey(DPINS.LB_GTTP_CP_DONE, "texture", pinTextures.paths.OtherDone[index])
              otherPreview:SetTexture(pinTextures.paths.Other[index])
              otherPreviewDone:SetTexture(pinTextures.paths.OtherDone[index])
              RedrawAllPins(DPINS.LB_GTTP_CP)
              RedrawAllPins(DPINS.LB_GTTP_CP_DONE)
              break
            end
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.LB_GTTP_CP] and
          not DestinationsCSSV.filters[DPINS.LB_GTTP_CP_DONE]
        end,
        default = pinTextures.lists.Other[defaults.pins.pinTextureOther.type],
      })
      table.insert(submenu, { -- Achievement Other size
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureOther.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureOther.size = size
          LMP:SetLayoutKey(DPINS.LB_GTTP_CP, "size", size)
          otherPreview:SetDimensions(size, size)
          DestinationsSV.pins.pinTextureOtherDone.size = size
          LMP:SetLayoutKey(DPINS.LB_GTTP_CP_DONE, "size", size)
          otherPreviewDone:SetDimensions(size, size)
          RedrawAllPins(DPINS.LB_GTTP_CP)
          RedrawAllPins(DPINS.LB_GTTP_CP_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.LB_GTTP_CP] and
          not DestinationsCSSV.filters[DPINS.LB_GTTP_CP_DONE]
        end,
        default = defaults.pins.pinTextureOther.size
      })
      table.insert(submenu, { -- Achievement M'aiq Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_MAIQ_HEADER)),
      })
      table.insert(submenu, { -- Achievement M'aiq Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.MAIQ] end,
        setFunc = function(state)
          TogglePins(DPINS.MAIQ, state)
          RedrawAllPins(DPINS.MAIQ)
        end,
        default = defaults.filters[DPINS.MAIQ],
      })
      table.insert(submenu, { -- Achievement M'aiq Done Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.MAIQ_DONE] end,
        setFunc = function(state)
          TogglePins(DPINS.MAIQ_DONE, state)
          RedrawAllPins(DPINS.MAIQ_DONE)
        end,
        default = defaults.filters[DPINS.MAIQ_DONE],
      })
      table.insert(submenu, { -- Achievement M'aiq Style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
        reference = "previewpinTextureMaiq",
        choices = pinTextures.lists.Maiq,
        getFunc = function() return pinTextures.lists.Maiq[DestinationsSV.pins.pinTextureMaiq.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Maiq) do
            if name == selected then
              DestinationsSV.pins.pinTextureMaiq.type = index
              DestinationsSV.pins.pinTextureMaiqDone.type = index
              LMP:SetLayoutKey(DPINS.MAIQ, "texture", pinTextures.paths.Maiq[index])
              LMP:SetLayoutKey(DPINS.MAIQ_DONE, "texture", pinTextures.paths.MaiqDone[index])
              MaiqPreview:SetTexture(pinTextures.paths.Maiq[index])
              MaiqPreviewDone:SetTexture(pinTextures.paths.MaiqDone[index])
              RedrawAllPins(DPINS.MAIQ)
              RedrawAllPins(DPINS.MAIQ_DONE)
              break
            end
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.MAIQ] and
          not DestinationsCSSV.filters[DPINS.MAIQ_DONE]
        end,
        default = pinTextures.lists.Maiq[defaults.pins.pinTextureMaiq.type],
      })
      table.insert(submenu, { -- Achievement M'aiq Size
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureMaiq.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureMaiq.size = size
          LMP:SetLayoutKey(DPINS.MAIQ, "size", size)
          MaiqPreview:SetDimensions(size, size)
          DestinationsSV.pins.pinTextureMaiqDone.size = size
          LMP:SetLayoutKey(DPINS.MAIQ_DONE, "size", size)
          MaiqPreviewDone:SetDimensions(size, size)
          RedrawAllPins(DPINS.MAIQ)
          RedrawAllPins(DPINS.MAIQ_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.MAIQ] and
          not DestinationsCSSV.filters[DPINS.MAIQ_DONE]
        end,
        default = defaults.pins.pinTextureMaiq.size
      })
      table.insert(submenu, { -- Achievement Peacemaker Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_PEACEMAKER_HEADER)),
      })
      table.insert(submenu, { -- Achievement Peacemaker Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.PEACEMAKER] end,
        setFunc = function(state)
          TogglePins(DPINS.PEACEMAKER, state)
          RedrawAllPins(DPINS.PEACEMAKER)
        end,
        default = defaults.filters[DPINS.PEACEMAKER],
      })
      table.insert(submenu, { -- Achievement Peacemaker Done Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.PEACEMAKER_DONE] end,
        setFunc = function(state)
          TogglePins(DPINS.PEACEMAKER_DONE, state)
          RedrawAllPins(DPINS.PEACEMAKER_DONE)
        end,
        default = defaults.filters[DPINS.PEACEMAKER_DONE],
      })
      table.insert(submenu, { -- Achievement Peacemaker Style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
        reference = "previewpinTexturePeacemaker",
        choices = pinTextures.lists.Peacemaker,
        getFunc = function() return pinTextures.lists.Peacemaker[DestinationsSV.pins.pinTexturePeacemaker.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Peacemaker) do
            if name == selected then
              DestinationsSV.pins.pinTexturePeacemaker.type = index
              DestinationsSV.pins.pinTexturePeacemakerDone.type = index
              LMP:SetLayoutKey(DPINS.PEACEMAKER, "texture", pinTextures.paths.Peacemaker[index])
              LMP:SetLayoutKey(DPINS.PEACEMAKER_DONE, "texture", pinTextures.paths.PeacemakerDone[index])
              PeacemakerPreview:SetTexture(pinTextures.paths.Peacemaker[index])
              PeacemakerPreviewDone:SetTexture(pinTextures.paths.PeacemakerDone[index])
              RedrawAllPins(DPINS.PEACEMAKER)
              RedrawAllPins(DPINS.PEACEMAKER_DONE)
              break
            end
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.PEACEMAKER] and
          not DestinationsCSSV.filters[DPINS.PEACEMAKER_DONE]
        end,
        default = pinTextures.lists.Peacemaker[defaults.pins.pinTexturePeacemaker.type],
      })
      table.insert(submenu, { -- Achievement Peacemaker Size
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTexturePeacemaker.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTexturePeacemaker.size = size
          LMP:SetLayoutKey(DPINS.PEACEMAKER, "size", size)
          PeacemakerPreview:SetDimensions(size, size)
          DestinationsSV.pins.pinTexturePeacemakerDone.size = size
          LMP:SetLayoutKey(DPINS.PEACEMAKER_DONE, "size", size)
          PeacemakerPreviewDone:SetDimensions(size, size)
          RedrawAllPins(DPINS.PEACEMAKER)
          RedrawAllPins(DPINS.PEACEMAKER_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.PEACEMAKER] and
          not DestinationsCSSV.filters[DPINS.PEACEMAKER_DONE]
        end,
        default = defaults.pins.pinTexturePeacemaker.size
      })
      table.insert(submenu, { -- Achievement Nosediver Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_NOSEDIVER_HEADER)),
      })
      table.insert(submenu, { -- Achievement Nosediver Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.NOSEDIVER] end,
        setFunc = function(state)
          TogglePins(DPINS.NOSEDIVER, state)
          RedrawAllPins(DPINS.NOSEDIVER)
        end,
        default = defaults.filters[DPINS.NOSEDIVER],
      })
      table.insert(submenu, { -- Achievement Nosediver Done Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.NOSEDIVER_DONE] end,
        setFunc = function(state)
          TogglePins(DPINS.NOSEDIVER_DONE, state)
          RedrawAllPins(DPINS.NOSEDIVER_DONE)
        end,
        default = defaults.filters[DPINS.NOSEDIVER_DONE],
      })
      table.insert(submenu, { -- Achievement Nosediver Style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
        reference = "previewpinTextureNosediver",
        choices = pinTextures.lists.Nosediver,
        getFunc = function() return pinTextures.lists.Nosediver[DestinationsSV.pins.pinTextureNosediver.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Nosediver) do
            if name == selected then
              DestinationsSV.pins.pinTextureNosediver.type = index
              DestinationsSV.pins.pinTextureNosediverDone.type = index
              LMP:SetLayoutKey(DPINS.NOSEDIVER, "texture", pinTextures.paths.Nosediver[index])
              LMP:SetLayoutKey(DPINS.NOSEDIVER_DONE, "texture", pinTextures.paths.NosediverDone[index])
              NosediverPreview:SetTexture(pinTextures.paths.Nosediver[index])
              NosediverPreviewDone:SetTexture(pinTextures.paths.NosediverDone[index])
              RedrawAllPins(DPINS.NOSEDIVER)
              RedrawAllPins(DPINS.NOSEDIVER_DONE)
              break
            end
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.NOSEDIVER] and
          not DestinationsCSSV.filters[DPINS.NOSEDIVER_DONE]
        end,
        default = pinTextures.lists.Nosediver[defaults.pins.pinTextureNosediver.type],
      })
      table.insert(submenu, { -- Achievement Nosediver Size
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureNosediver.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureNosediver.size = size
          LMP:SetLayoutKey(DPINS.NOSEDIVER, "size", size)
          NosediverPreview:SetDimensions(size, size)
          DestinationsSV.pins.pinTextureNosediverDone.size = size
          LMP:SetLayoutKey(DPINS.NOSEDIVER_DONE, "size", size)
          NosediverPreviewDone:SetDimensions(size, size)
          RedrawAllPins(DPINS.NOSEDIVER)
          RedrawAllPins(DPINS.NOSEDIVER_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.NOSEDIVER] and
          not DestinationsCSSV.filters[DPINS.NOSEDIVER_DONE]
        end,
        default = defaults.pins.pinTextureNosediver.size
      })
      table.insert(submenu, { -- Achievement Earthly Possesion Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_EARTHLYPOS_HEADER)),
      })
      table.insert(submenu, { -- Achievement Earthly Possesion Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.EARTHLYPOS] end,
        setFunc = function(state)
          TogglePins(DPINS.EARTHLYPOS, state)
          RedrawAllPins(DPINS.EARTHLYPOS)
        end,
        default = defaults.filters[DPINS.EARTHLYPOS],
      })
      table.insert(submenu, { -- Achievement Earthly Possesion Done Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.EARTHLYPOS_DONE] end,
        setFunc = function(state)
          TogglePins(DPINS.EARTHLYPOS_DONE, state)
          RedrawAllPins(DPINS.EARTHLYPOS_DONE)
        end,
        default = defaults.filters[DPINS.EARTHLYPOS_DONE],
      })
      table.insert(submenu, { -- Achievement Earthly Possesion Style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
        reference = "previewpinTextureEarthlyPos",
        choices = pinTextures.lists.EarthlyPos,
        getFunc = function() return pinTextures.lists.EarthlyPos[DestinationsSV.pins.pinTextureEarthlyPos.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.EarthlyPos) do
            if name == selected then
              DestinationsSV.pins.pinTextureEarthlyPos.type = index
              DestinationsSV.pins.pinTextureEarthlyPosDone.type = index
              LMP:SetLayoutKey(DPINS.EARTHLYPOS, "texture", pinTextures.paths.Earthlypos[index])
              LMP:SetLayoutKey(DPINS.EARTHLYPOS_DONE, "texture", pinTextures.paths.EarthlyposDone[index])
              EarthlyPosPreview:SetTexture(pinTextures.paths.Earthlypos[index])
              EarthlyPosPreviewDone:SetTexture(pinTextures.paths.EarthlyposDone[index])
              RedrawAllPins(DPINS.EARTHLYPOS)
              RedrawAllPins(DPINS.EARTHLYPOS_DONE)
              break
            end
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.EARTHLYPOS] and
          not DestinationsCSSV.filters[DPINS.EARTHLYPOS_DONE]
        end,
        default = pinTextures.lists.Nosediver[defaults.pins.pinTextureNosediver.type],
      })
      table.insert(submenu, { -- Achievement Earthly Possesion Size
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureEarthlyPos.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureEarthlyPos.size = size
          LMP:SetLayoutKey(DPINS.EARTHLYPOS, "size", size)
          EarthlyPosPreview:SetDimensions(size, size)
          DestinationsSV.pins.pinTextureEarthlyPosDone.size = size
          LMP:SetLayoutKey(DPINS.EARTHLYPOS_DONE, "size", size)
          EarthlyPosPreviewDone:SetDimensions(size, size)
          RedrawAllPins(DPINS.EARTHLYPOS)
          RedrawAllPins(DPINS.EARTHLYPOS_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.EARTHLYPOS] and
          not DestinationsCSSV.filters[DPINS.EARTHLYPOS_DONE]
        end,
        default = defaults.pins.pinTextureEarthlyPos.size
      })
      table.insert(submenu, { -- Achievement This One's on Me Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_ON_ME_HEADER)),
      })
      table.insert(submenu, { -- Achievement This One's on Me Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.ON_ME] end,
        setFunc = function(state)
          TogglePins(DPINS.ON_ME, state)
          RedrawAllPins(DPINS.ON_ME)
        end,
        default = defaults.filters[DPINS.ON_ME],
      })
      table.insert(submenu, { -- Achievement This One's on Me Done Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.ON_ME_DONE] end,
        setFunc = function(state)
          TogglePins(DPINS.ON_ME_DONE, state)
          RedrawAllPins(DPINS.ON_ME_DONE)
        end,
        default = defaults.filters[DPINS.ON_ME_DONE],
      })
      table.insert(submenu, { -- Achievement This One's on Me Style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
        reference = "previewpinTextureOnMe",
        choices = pinTextures.lists.OnMe,
        getFunc = function() return pinTextures.lists.OnMe[DestinationsSV.pins.pinTextureOnMe.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.OnMe) do
            if name == selected then
              DestinationsSV.pins.pinTextureOnMe.type = index
              DestinationsSV.pins.pinTextureOnMeDone.type = index
              LMP:SetLayoutKey(DPINS.ON_ME, "texture", pinTextures.paths.OnMe[index])
              LMP:SetLayoutKey(DPINS.ON_ME_DONE, "texture", pinTextures.paths.OnMeDone[index])
              OnMePreview:SetTexture(pinTextures.paths.OnMe[index])
              OnMePreviewDone:SetTexture(pinTextures.paths.OnMeDone[index])
              RedrawAllPins(DPINS.ON_ME)
              RedrawAllPins(DPINS.ON_ME_DONE)
              break
            end
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.ON_ME] and
          not DestinationsCSSV.filters[DPINS.ON_ME_DONE]
        end,
        default = pinTextures.lists.OnMe[defaults.pins.pinTextureOnMe.type],
      })
      table.insert(submenu, { -- Achievement This One's on Me Size
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureOnMe.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureOnMe.size = size
          LMP:SetLayoutKey(DPINS.ON_ME, "size", size)
          OnMePreview:SetDimensions(size, size)
          DestinationsSV.pins.pinTextureOnMeDone.size = size
          LMP:SetLayoutKey(DPINS.ON_ME_DONE, "size", size)
          OnMePreviewDone:SetDimensions(size, size)
          RedrawAllPins(DPINS.ON_ME)
          RedrawAllPins(DPINS.ON_ME_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.ON_ME] and
          not DestinationsCSSV.filters[DPINS.ON_ME_DONE]
        end,
        default = defaults.pins.pinTextureOnMe.size
      })
      table.insert(submenu, { -- Achievement One Last Brawl Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_BRAWL_HEADER)),
      })
      table.insert(submenu, { -- Achievement One Last Brawl Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.BRAWL] end,
        setFunc = function(state)
          TogglePins(DPINS.BRAWL, state)
          RedrawAllPins(DPINS.BRAWL)
        end,
        default = defaults.filters[DPINS.BRAWL],
      })
      table.insert(submenu, { -- Achievement One Last Brawl Done Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.BRAWL_DONE] end,
        setFunc = function(state)
          TogglePins(DPINS.BRAWL_DONE, state)
          RedrawAllPins(DPINS.BRAWL_DONE)
        end,
        default = defaults.filters[DPINS.BRAWL_DONE],
      })
      table.insert(submenu, { -- Achievement One Last Brawl Style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
        reference = "previewpinTextureBrawl",
        choices = pinTextures.lists.Brawl,
        getFunc = function() return pinTextures.lists.Brawl[DestinationsSV.pins.pinTextureBrawl.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Brawl) do
            if name == selected then
              DestinationsSV.pins.pinTextureBrawl.type = index
              DestinationsSV.pins.pinTextureBrawlDone.type = index
              LMP:SetLayoutKey(DPINS.BRAWL, "texture", pinTextures.paths.Brawl[index])
              LMP:SetLayoutKey(DPINS.BRAWL_DONE, "texture", pinTextures.paths.BrawlDone[index])
              BrawlPreview:SetTexture(pinTextures.paths.Brawl[index])
              BrawlPreviewDone:SetTexture(pinTextures.paths.BrawlDone[index])
              RedrawAllPins(DPINS.BRAWL)
              RedrawAllPins(DPINS.BRAWL_DONE)
              break
            end
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.BRAWL] and
          not DestinationsCSSV.filters[DPINS.BRAWL_DONE]
        end,
        default = pinTextures.lists.Brawl[defaults.pins.pinTextureBrawl.type],
      })
      table.insert(submenu, { -- Achievement One Last Brawl Size
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureBrawl.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureBrawl.size = size
          LMP:SetLayoutKey(DPINS.BRAWL, "size", size)
          BrawlPreview:SetDimensions(size, size)
          DestinationsSV.pins.pinTextureBrawlDone.size = size
          LMP:SetLayoutKey(DPINS.BRAWL_DONE, "size", size)
          BrawlPreviewDone:SetDimensions(size, size)
          RedrawAllPins(DPINS.BRAWL)
          RedrawAllPins(DPINS.BRAWL_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.BRAWL] and
          not DestinationsCSSV.filters[DPINS.BRAWL_DONE]
        end,
        default = defaults.pins.pinTextureBrawl.size
      })
      table.insert(submenu, { -- Achievement Orsinium Patron Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_PATRON_HEADER)),
      })
      table.insert(submenu, { -- Achievement Orsinium Patron Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.PATRON] end,
        setFunc = function(state)
          TogglePins(DPINS.PATRON, state)
          RedrawAllPins(DPINS.PATRON)
        end,
        default = defaults.filters[DPINS.PATRON],
      })
      table.insert(submenu, { -- Achievement Orsinium Patron Done Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.PATRON_DONE] end,
        setFunc = function(state)
          TogglePins(DPINS.PATRON_DONE, state)
          RedrawAllPins(DPINS.PATRON_DONE)
        end,
        default = defaults.filters[DPINS.PATRON_DONE],
      })
      table.insert(submenu, { -- Achievement Orsinium Patron Style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
        reference = "previewpinTexturePatron",
        choices = pinTextures.lists.Patron,
        getFunc = function() return pinTextures.lists.Patron[DestinationsSV.pins.pinTexturePatron.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Patron) do
            if name == selected then
              DestinationsSV.pins.pinTexturePatron.type = index
              DestinationsSV.pins.pinTexturePatronDone.type = index
              LMP:SetLayoutKey(DPINS.PATRON, "texture", pinTextures.paths.Patron[index])
              LMP:SetLayoutKey(DPINS.PATRON_DONE, "texture", pinTextures.paths.PatronDone[index])
              PatronPreview:SetTexture(pinTextures.paths.Patron[index])
              PatronPreviewDone:SetTexture(pinTextures.paths.PatronDone[index])
              RedrawAllPins(DPINS.PATRON)
              RedrawAllPins(DPINS.PATRON_DONE)
              break
            end
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.PATRON] and
          not DestinationsCSSV.filters[DPINS.PATRON_DONE]
        end,
        default = pinTextures.lists.Patron[defaults.pins.pinTexturePatron.type],
      })
      table.insert(submenu, { -- Achievement Orsinium Patron Size
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTexturePatron.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTexturePatron.size = size
          LMP:SetLayoutKey(DPINS.PATRON, "size", size)
          PatronPreview:SetDimensions(size, size)
          DestinationsSV.pins.pinTexturePatronDone.size = size
          LMP:SetLayoutKey(DPINS.PATRON_DONE, "size", size)
          PatronPreviewDone:SetDimensions(size, size)
          RedrawAllPins(DPINS.PATRON)
          RedrawAllPins(DPINS.PATRON_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.PATRON] and
          not DestinationsCSSV.filters[DPINS.PATRON_DONE]
        end,
        default = defaults.pins.pinTexturePatron.size
      })
      table.insert(submenu, { -- Achievement Wrothgar Cliff Jumper Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_WROTHGAR_JUMPER_HEADER)),
      })
      table.insert(submenu, { -- Achievement Wrothgar Cliff Jumper Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER] end,
        setFunc = function(state)
          TogglePins(DPINS.WROTHGAR_JUMPER, state)
          RedrawAllPins(DPINS.WROTHGAR_JUMPER)
        end,
        default = defaults.filters[DPINS.WROTHGAR_JUMPER],
      })
      table.insert(submenu, { -- Achievement Wrothgar Cliff Jumper Done Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER_DONE] end,
        setFunc = function(state)
          TogglePins(DPINS.WROTHGAR_JUMPER_DONE, state)
          RedrawAllPins(DPINS.WROTHGAR_JUMPER_DONE)
        end,
        default = defaults.filters[DPINS.WROTHGAR_JUMPER_DONE],
      })
      table.insert(submenu, { -- Achievement Wrothgar Cliff Jumper Style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
        reference = "previewpinTextureWrothgarJumper",
        choices = pinTextures.lists.WrothgarJumper,
        getFunc = function() return pinTextures.lists.WrothgarJumper[DestinationsSV.pins.pinTextureWrothgarJumper.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.WrothgarJumper) do
            if name == selected then
              DestinationsSV.pins.pinTextureWrothgarJumper.type = index
              DestinationsSV.pins.pinTextureWrothgarJumperDone.type = index
              LMP:SetLayoutKey(DPINS.WROTHGAR_JUMPER, "texture", pinTextures.paths.WrothgarJumper[index])
              LMP:SetLayoutKey(DPINS.WROTHGAR_JUMPER_DONE, "texture", pinTextures.paths.WrothgarJumperDone[index])
              WrothgarJumperPreview:SetTexture(pinTextures.paths.WrothgarJumper[index])
              WrothgarJumperPreviewDone:SetTexture(pinTextures.paths.WrothgarJumperDone[index])
              RedrawAllPins(DPINS.WROTHGAR_JUMPER)
              RedrawAllPins(DPINS.WROTHGAR_JUMPER_DONE)
              break
            end
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER] and
          not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER_DONE]
        end,
        default = pinTextures.lists.WrothgarJumper[defaults.pins.pinTextureWrothgarJumper.type],
      })
      table.insert(submenu, { -- Achievement Wrothgar Cliff Jumper Size
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureWrothgarJumper.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureWrothgarJumper.size = size
          LMP:SetLayoutKey(DPINS.WROTHGAR_JUMPER, "size", size)
          WrothgarJumperPreview:SetDimensions(size, size)
          DestinationsSV.pins.pinTextureWrothgarJumperDone.size = size
          LMP:SetLayoutKey(DPINS.WROTHGAR_JUMPER_DONE, "size", size)
          WrothgarJumperPreviewDone:SetDimensions(size, size)
          RedrawAllPins(DPINS.WROTHGAR_JUMPER)
          RedrawAllPins(DPINS.WROTHGAR_JUMPER_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER] and
          not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER_DONE]
        end,
        default = defaults.pins.pinTextureWrothgarJumper.size
      })
      table.insert(submenu, { -- Achievement Wrothgar Master Relic Hunter Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_RELIC_HUNTER_HEADER)),
      })
      table.insert(submenu, { -- Achievement Wrothgar Master Relic Hunter Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.RELIC_HUNTER] end,
        setFunc = function(state)
          TogglePins(DPINS.RELIC_HUNTER, state)
          RedrawAllPins(DPINS.RELIC_HUNTER)
        end,
        default = defaults.filters[DPINS.RELIC_HUNTER],
      })
      table.insert(submenu, { -- Achievement Wrothgar Master Relic Hunter Done Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.RELIC_HUNTER_DONE] end,
        setFunc = function(state)
          TogglePins(DPINS.RELIC_HUNTER_DONE, state)
          RedrawAllPins(DPINS.RELIC_HUNTER_DONE)
        end,
        default = defaults.filters[DPINS.RELIC_HUNTER_DONE],
      })
      table.insert(submenu, { -- Achievement Wrothgar Master Relic Hunter Style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
        reference = "previewpinTextureRelicHunter",
        choices = pinTextures.lists.RelicHunter,
        getFunc = function() return pinTextures.lists.RelicHunter[DestinationsSV.pins.pinTextureRelicHunter.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.RelicHunter) do
            if name == selected then
              DestinationsSV.pins.pinTextureRelicHunter.type = index
              DestinationsSV.pins.pinTextureRelicHunterDone.type = index
              LMP:SetLayoutKey(DPINS.RELIC_HUNTER, "texture", pinTextures.paths.RelicHunter[index])
              LMP:SetLayoutKey(DPINS.RELIC_HUNTER_DONE, "texture", pinTextures.paths.RelicHunterDone[index])
              RelicHunterPreview:SetTexture(pinTextures.paths.RelicHunter[index])
              RelicHunterPreviewDone:SetTexture(pinTextures.paths.RelicHunterDone[index])
              RedrawAllPins(DPINS.RELIC_HUNTER)
              RedrawAllPins(DPINS.RELIC_HUNTER_DONE)
              break
            end
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.RELIC_HUNTER] and
          not DestinationsCSSV.filters[DPINS.RELIC_HUNTER_DONE]
        end,
        default = pinTextures.lists.RelicHunter[defaults.pins.pinTextureRelicHunter.type],
      })
      table.insert(submenu, { -- Achievement Wrothgar Master Relic Hunter Size
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureRelicHunter.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureRelicHunter.size = size
          LMP:SetLayoutKey(DPINS.RELIC_HUNTER, "size", size)
          RelicHunterPreview:SetDimensions(size, size)
          DestinationsSV.pins.pinTextureRelicHunterDone.size = size
          LMP:SetLayoutKey(DPINS.RELIC_HUNTER_DONE, "size", size)
          RelicHunterPreviewDone:SetDimensions(size, size)
          RedrawAllPins(DPINS.RELIC_HUNTER)
          RedrawAllPins(DPINS.RELIC_HUNTER_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.RELIC_HUNTER] and
          not DestinationsCSSV.filters[DPINS.RELIC_HUNTER_DONE]
        end,
        default = defaults.pins.pinTextureRelicHunter.size
      })
      table.insert(submenu, { -- Achievement Breaking and Entering Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_BREAKING_HEADER)),
      })
      table.insert(submenu, { -- Achievement Breaking and Entering Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.BREAKING] end,
        setFunc = function(state)
          TogglePins(DPINS.BREAKING, state)
          RedrawAllPins(DPINS.BREAKING)
        end,
        default = defaults.filters[DPINS.BREAKING],
      })
      table.insert(submenu, { -- Achievement Breaking and Entering Done Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.BREAKING_DONE] end,
        setFunc = function(state)
          TogglePins(DPINS.BREAKING_DONE, state)
          RedrawAllPins(DPINS.BREAKING_DONE)
        end,
        default = defaults.filters[DPINS.BREAKING_DONE],
      })
      table.insert(submenu, { -- Achievement Breaking and Entering Style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
        reference = "previewpinTextureBreaking",
        choices = pinTextures.lists.Breaking,
        getFunc = function() return pinTextures.lists.Breaking[DestinationsSV.pins.pinTextureBreaking.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Breaking) do
            if name == selected then
              DestinationsSV.pins.pinTextureBreaking.type = index
              DestinationsSV.pins.pinTextureBreakingDone.type = index
              LMP:SetLayoutKey(DPINS.BREAKING, "texture", pinTextures.paths.Breaking[index])
              LMP:SetLayoutKey(DPINS.BREAKING_DONE, "texture", pinTextures.paths.BreakingDone[index])
              BreakingPreview:SetTexture(pinTextures.paths.Breaking[index])
              BreakingPreviewDone:SetTexture(pinTextures.paths.BreakingDone[index])
              RedrawAllPins(DPINS.BREAKING)
              RedrawAllPins(DPINS.BREAKING_DONE)
              break
            end
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.BREAKING] and
          not DestinationsCSSV.filters[DPINS.BREAKING_DONE]
        end,
        default = pinTextures.lists.Breaking[defaults.pins.pinTextureBreaking.type],
      })
      table.insert(submenu, { -- Achievement Breaking and Entering Size
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureBreaking.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureBreaking.size = size
          DestinationsSV.pins.pinTextureBreakingDone.size = size
          LMP:SetLayoutKey(DPINS.BREAKING, "size", size)
          LMP:SetLayoutKey(DPINS.BREAKING_DONE, "size", size)
          BreakingPreview:SetDimensions(size, size)
          BreakingPreviewDone:SetDimensions(size, size)
          RedrawAllPins(DPINS.BREAKING)
          RedrawAllPins(DPINS.BREAKING_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.BREAKING] and
          not DestinationsCSSV.filters[DPINS.BREAKING_DONE]
        end,
        default = defaults.pins.pinTextureBreaking.size
      })
      table.insert(submenu, { -- Achievement A Cutpurse Above Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_CUTPURSE_HEADER)),
      })
      table.insert(submenu, { -- Achievement A Cutpurse Above Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.CUTPURSE] end,
        setFunc = function(state)
          TogglePins(DPINS.CUTPURSE, state)
          RedrawAllPins(DPINS.CUTPURSE)
        end,
        default = defaults.filters[DPINS.CUTPURSE],
      })
      table.insert(submenu, { -- Achievement A Cutpurse Above Done Toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.CUTPURSE_DONE] end,
        setFunc = function(state)
          TogglePins(DPINS.CUTPURSE_DONE, state)
          RedrawAllPins(DPINS.CUTPURSE_DONE)
        end,
        default = defaults.filters[DPINS.CUTPURSE_DONE],
      })
      table.insert(submenu, { -- Achievement A Cutpurse Above Style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
        reference = "previewpinTextureCutpurse",
        choices = pinTextures.lists.Cutpurse,
        getFunc = function() return pinTextures.lists.Cutpurse[DestinationsSV.pins.pinTextureCutpurse.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Cutpurse) do
            if name == selected then
              DestinationsSV.pins.pinTextureCutpurse.type = index
              DestinationsSV.pins.pinTextureCutpurseDone.type = index
              LMP:SetLayoutKey(DPINS.CUTPURSE, "texture", pinTextures.paths.Cutpurse[index])
              LMP:SetLayoutKey(DPINS.CUTPURSE_DONE, "texture", pinTextures.paths.CutpurseDone[index])
              CutpursePreview:SetTexture(pinTextures.paths.Cutpurse[index])
              CutpursePreviewDone:SetTexture(pinTextures.paths.CutpurseDone[index])
              RedrawAllPins(DPINS.CUTPURSE)
              RedrawAllPins(DPINS.CUTPURSE_DONE)
              break
            end
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.CUTPURSE] and
          not DestinationsCSSV.filters[DPINS.CUTPURSE_DONE]
        end,
        default = pinTextures.lists.Cutpurse[defaults.pins.pinTextureCutpurse.type],
      })
      table.insert(submenu, { -- Achievement A Cutpurse Above Size
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureCutpurse.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureCutpurse.size = size
          LMP:SetLayoutKey(DPINS.CUTPURSE, "size", size)
          CutpursePreview:SetDimensions(size, size)
          DestinationsSV.pins.pinTextureCutpurseDone.size = size
          LMP:SetLayoutKey(DPINS.CUTPURSE_DONE, "size", size)
          CutpursePreviewDone:SetDimensions(size, size)
          RedrawAllPins(DPINS.CUTPURSE)
          RedrawAllPins(DPINS.CUTPURSE_DONE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.CUTPURSE] and
          not DestinationsCSSV.filters[DPINS.CUTPURSE_DONE]
        end,
        default = defaults.pins.pinTextureCutpurse.size
      })

    elseif menu == "Misc" then

      table.insert(submenu, { -- Achievement All Pin Layer
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_ALL_PIN_LAYER),
        min = 10,
        max = 200,
        step = 5,
        getFunc = function() return DestinationsSV.pins.pinTextureOther.level end,
        setFunc = function(level)
          for _, pinName in pairs(drtv.AchPinTex) do
            DestinationsSV.pins[pinName].level = level
            pinName = pinName .. "Done"
            DestinationsSV.pins[pinName].level = level
          end
          for _, pinName in pairs(drtv.AchPins) do
            LMP:SetLayoutKey(DPINS[pinName], "level", level)
            pinName = pinName .. "_DONE"
            LMP:SetLayoutKey(DPINS[pinName], "level", level)
          end
          RedrawAllAchievementPins()
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.LB_GTTP_CP] and
          not DestinationsCSSV.filters[DPINS.MAIQ] and
          not DestinationsCSSV.filters[DPINS.PEACEMAKER] and
          not DestinationsCSSV.filters[DPINS.NOSEDIVER] and
          not DestinationsCSSV.filters[DPINS.EARTHLYPOS] and
          not DestinationsCSSV.filters[DPINS.ON_ME] and
          not DestinationsCSSV.filters[DPINS.BRAWL] and
          not DestinationsCSSV.filters[DPINS.PATRON] and
          not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER] and
          not DestinationsCSSV.filters[DPINS.RELIC_HUNTER] and
          not DestinationsCSSV.filters[DPINS.CHAMPION] and
          not DestinationsCSSV.filters[DPINS.LB_GTTP_CP_DONE] and
          not DestinationsCSSV.filters[DPINS.MAIQ_DONE] and
          not DestinationsCSSV.filters[DPINS.PEACEMAKER_DONE] and
          not DestinationsCSSV.filters[DPINS.NOSEDIVER_DONE] and
          not DestinationsCSSV.filters[DPINS.EARTHLYPOS_DONE] and
          not DestinationsCSSV.filters[DPINS.ON_ME_DONE] and
          not DestinationsCSSV.filters[DPINS.BRAWL_DONE] and
          not DestinationsCSSV.filters[DPINS.PATRON_DONE] and
          not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER_DONE] and
          not DestinationsCSSV.filters[DPINS.RELIC_HUNTER_DONE] and
          not DestinationsCSSV.filters[DPINS.CHAMPION_DONE]
        end,
        default = defaults.pins.pinTextureOther.level
      })
      table.insert(submenu, { -- Achievement All Undone pin color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_ACH_PIN_COLOR_MISS),
        tooltip = GetString(DEST_SETTINGS_ACH_PIN_COLOR_MISS_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureOther.tint) end,
        setFunc = function(r, g, b, a)
          for _, pinName in pairs(drtv.AchPinTex) do
            DestinationsSV.pins[pinName].tint = { r, g, b, a }
          end
          for _, pinName in pairs(drtv.AchPins) do
            LMP:SetLayoutKey(DPINS[pinName], "tint", ZO_ColorDef:New(r, g, b, a))
            RedrawAllPins(DPINS[pinName])
          end
          otherPreview:SetColor(r, g, b, a)
          MaiqPreview:SetColor(r, g, b, a)
          PeacemakerPreview:SetColor(r, g, b, a)
          NosediverPreview:SetColor(r, g, b, a)
          EarthlyPosPreview:SetColor(r, g, b, a)
          OnMePreview:SetColor(r, g, b, a)
          BrawlPreview:SetColor(r, g, b, a)
          PatronPreview:SetColor(r, g, b, a)
          WrothgarJumperPreview:SetColor(r, g, b, a)
          RelicHunterPreview:SetColor(r, g, b, a)
          ChampionPreview:SetColor(r, g, b, a)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.LB_GTTP_CP] and
          not DestinationsCSSV.filters[DPINS.MAIQ] and
          not DestinationsCSSV.filters[DPINS.PEACEMAKER] and
          not DestinationsCSSV.filters[DPINS.NOSEDIVER] and
          not DestinationsCSSV.filters[DPINS.EARTHLYPOS] and
          not DestinationsCSSV.filters[DPINS.ON_ME] and
          not DestinationsCSSV.filters[DPINS.BRAWL] and
          not DestinationsCSSV.filters[DPINS.PATRON] and
          not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER] and
          not DestinationsCSSV.filters[DPINS.RELIC_HUNTER] and
          not DestinationsCSSV.filters[DPINS.BREAKING] and
          not DestinationsCSSV.filters[DPINS.CHAMPION]
        end,
        default = { r = defaults.pins.pinTextureOther.tint[1], g = defaults.pins.pinTextureOther.tint[2], b = defaults.pins.pinTextureOther.tint[3], a = defaults.pins.pinTextureOther.tint[4] }
      })
      table.insert(submenu, { -- Achievement All Undone pin text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_ACH_TXT_COLOR_MISS),
        tooltip = GetString(DEST_SETTINGS_ACH_TXT_COLOR_MISS_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureOther.textcolor) end,
        setFunc = function(r, g, b)
          for _, pinName in pairs(drtv.AchPinTex) do
            DestinationsSV.pins[pinName].textcolor = { r, g, b }
          end
          for _, pinName in pairs(drtv.AchPins) do
            LMP:RefreshPins(DPINS[pinName])
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.LB_GTTP_CP] and
          not DestinationsCSSV.filters[DPINS.MAIQ] and
          not DestinationsCSSV.filters[DPINS.PEACEMAKER] and
          not DestinationsCSSV.filters[DPINS.NOSEDIVER] and
          not DestinationsCSSV.filters[DPINS.EARTHLYPOS] and
          not DestinationsCSSV.filters[DPINS.ON_ME] and
          not DestinationsCSSV.filters[DPINS.BRAWL] and
          not DestinationsCSSV.filters[DPINS.PATRON] and
          not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER] and
          not DestinationsCSSV.filters[DPINS.RELIC_HUNTER] and
          not DestinationsCSSV.filters[DPINS.CHAMPION]
        end,
        default = { r = defaults.pins.pinTextureOther.textcolor[1], g = defaults.pins.pinTextureOther.textcolor[2], b = defaults.pins.pinTextureOther.textcolor[3] }
      })
      table.insert(submenu, { -- Achievement All Done pin color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_ACH_PIN_COLOR_DONE),
        tooltip = GetString(DEST_SETTINGS_ACH_PIN_COLOR_DONE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureOtherDone.tint) end,
        setFunc = function(r, g, b, a)
          for _, pinName in pairs(drtv.AchPinTex) do
            pinName = pinName .. "Done"
            DestinationsSV.pins[pinName].tint = { r, g, b, a }
          end
          for _, pinName in pairs(drtv.AchPins) do
            pinName = pinName .. "_DONE"
            LMP:SetLayoutKey(DPINS[pinName], "tint", ZO_ColorDef:New(r, g, b, a))
            RedrawAllPins(DPINS[pinName])
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.LB_GTTP_CP_DONE] and
          not DestinationsCSSV.filters[DPINS.MAIQ_DONE] and
          not DestinationsCSSV.filters[DPINS.PEACEMAKER_DONE] and
          not DestinationsCSSV.filters[DPINS.NOSEDIVER_DONE] and
          not DestinationsCSSV.filters[DPINS.EARTHLYPOS_DONE] and
          not DestinationsCSSV.filters[DPINS.ON_ME_DONE] and
          not DestinationsCSSV.filters[DPINS.BRAWL_DONE] and
          not DestinationsCSSV.filters[DPINS.PATRON_DONE] and
          not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER_DONE] and
          not DestinationsCSSV.filters[DPINS.RELIC_HUNTER_DONE] and
          not DestinationsCSSV.filters[DPINS.CHAMPION_DONE]
        end,
        default = { r = defaults.pins.pinTextureOtherDone.tint[1], g = defaults.pins.pinTextureOtherDone.tint[2], b = defaults.pins.pinTextureOtherDone.tint[3], a = defaults.pins.pinTextureOtherDone.tint[4] }
      })
      table.insert(submenu, { -- Achievement All Done pin text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_ACH_TXT_COLOR_DONE),
        tooltip = GetString(DEST_SETTINGS_ACH_TXT_COLOR_DONE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureOtherDone.textcolor) end,
        setFunc = function(r, g, b)
          for _, pinName in pairs(drtv.AchPinTex) do
            pinName = pinName .. "Done"
            DestinationsSV.pins[pinName].textcolor = { r, g, b }
          end
          for _, pinName in pairs(drtv.AchPins) do
            pinName = pinName .. "_DONE"
            LMP:RefreshPins(DPINS[pinName])
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.LB_GTTP_CP_DONE] and
          not DestinationsCSSV.filters[DPINS.MAIQ_DONE] and
          not DestinationsCSSV.filters[DPINS.PEACEMAKER_DONE] and
          not DestinationsCSSV.filters[DPINS.NOSEDIVER_DONE] and
          not DestinationsCSSV.filters[DPINS.EARTHLYPOS_DONE] and
          not DestinationsCSSV.filters[DPINS.ON_ME_DONE] and
          not DestinationsCSSV.filters[DPINS.BRAWL_DONE] and
          not DestinationsCSSV.filters[DPINS.PATRON_DONE] and
          not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER_DONE] and
          not DestinationsCSSV.filters[DPINS.RELIC_HUNTER_DONE] and
          not DestinationsCSSV.filters[DPINS.CHAMPION_DONE]
        end,
        default = { r = defaults.pins.pinTextureOtherDone.textcolor[1], g = defaults.pins.pinTextureOtherDone.textcolor[2], b = defaults.pins.pinTextureOtherDone.textcolor[3] }
      })
      table.insert(submenu, { -- Achievement All compass toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_ALL_COMPASS_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.ACHIEVEMENTS_COMPASS] end,
        setFunc = function(state)
          DestinationsCSSV.filters[DPINS.ACHIEVEMENTS_COMPASS] = state
          for _, pinName in pairs(drtv.AchPins) do
            RedrawCompassPinsOnly(DPINS[pinName])
            pinName = pinName .. "_DONE"
            RedrawCompassPinsOnly(DPINS[pinName])
          end
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.LB_GTTP_CP] and
          not DestinationsCSSV.filters[DPINS.MAIQ] and
          not DestinationsCSSV.filters[DPINS.PEACEMAKER] and
          not DestinationsCSSV.filters[DPINS.NOSEDIVER] and
          not DestinationsCSSV.filters[DPINS.EARTHLYPOS] and
          not DestinationsCSSV.filters[DPINS.ON_ME] and
          not DestinationsCSSV.filters[DPINS.BRAWL] and
          not DestinationsCSSV.filters[DPINS.PATRON] and
          not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER] and
          not DestinationsCSSV.filters[DPINS.RELIC_HUNTER] and
          not DestinationsCSSV.filters[DPINS.CHAMPION] and
          not DestinationsCSSV.filters[DPINS.LB_GTTP_CP_DONE] and
          not DestinationsCSSV.filters[DPINS.MAIQ_DONE] and
          not DestinationsCSSV.filters[DPINS.PEACEMAKER_DONE] and
          not DestinationsCSSV.filters[DPINS.NOSEDIVER_DONE] and
          not DestinationsCSSV.filters[DPINS.EARTHLYPOS_DONE] and
          not DestinationsCSSV.filters[DPINS.ON_ME_DONE] and
          not DestinationsCSSV.filters[DPINS.BRAWL_DONE] and
          not DestinationsCSSV.filters[DPINS.PATRON_DONE] and
          not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER_DONE] and
          not DestinationsCSSV.filters[DPINS.RELIC_HUNTER_DONE] and
          not DestinationsCSSV.filters[DPINS.CHAMPION_DONE]
        end,
        default = defaults.filters[DPINS.ACHIEVEMENTS_COMPASS],
      })
      table.insert(submenu, { -- Achievement All compass distance
        type = "slider",
        name = GetString(DEST_SETTINGS_ACH_ALL_COMPASS_DIST),
        min = 1,
        max = 100,
        getFunc = function() return DestinationsSV.pins.pinTextureOther.maxDistance * 1000 end,
        setFunc = function(maxDistance)
          for _, pinName in pairs(drtv.AchPinTex) do
            DestinationsSV.pins[pinName].maxDistance = maxDistance / 1000
            pinName = pinName .. "Done"
            DestinationsSV.pins[pinName].maxDistance = maxDistance / 1000
          end
          for _, pinName in pairs(drtv.AchPins) do
            COMPASS_PINS.pinLayouts[DPINS[pinName]].maxDistance = maxDistance / 1000
            RedrawCompassPinsOnly(DPINS[pinName])
            pinName = pinName .. "_DONE"
            COMPASS_PINS.pinLayouts[DPINS[pinName]].maxDistance = maxDistance / 1000
            RedrawCompassPinsOnly(DPINS[pinName])
          end
        end,
        width = "full",
        disabled = function() return
        (not DestinationsCSSV.filters[DPINS.LB_GTTP_CP] and
          not DestinationsCSSV.filters[DPINS.MAIQ] and
          not DestinationsCSSV.filters[DPINS.PEACEMAKER] and
          not DestinationsCSSV.filters[DPINS.NOSEDIVER] and
          not DestinationsCSSV.filters[DPINS.EARTHLYPOS] and
          not DestinationsCSSV.filters[DPINS.ON_ME] and
          not DestinationsCSSV.filters[DPINS.BRAWL] and
          not DestinationsCSSV.filters[DPINS.PATRON] and
          not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER] and
          not DestinationsCSSV.filters[DPINS.RELIC_HUNTER] and
          not DestinationsCSSV.filters[DPINS.CHAMPION] and
          not DestinationsCSSV.filters[DPINS.LB_GTTP_CP_DONE] and
          not DestinationsCSSV.filters[DPINS.MAIQ_DONE] and
          not DestinationsCSSV.filters[DPINS.PEACEMAKER_DONE] and
          not DestinationsCSSV.filters[DPINS.NOSEDIVER_DONE] and
          not DestinationsCSSV.filters[DPINS.EARTHLYPOS_DONE] and
          not DestinationsCSSV.filters[DPINS.ON_ME_DONE] and
          not DestinationsCSSV.filters[DPINS.BRAWL_DONE] and
          not DestinationsCSSV.filters[DPINS.PATRON_DONE] and
          not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER_DONE] and
          not DestinationsCSSV.filters[DPINS.RELIC_HUNTER_DONE] and
          not DestinationsCSSV.filters[DPINS.CHAMPION_DONE]) or
          not DestinationsCSSV.filters[DPINS.ACHIEVEMENTS_COMPASS]
        end,
        default = defaults.pins.pinTextureOther.maxDistance * 1000,
      })

    elseif menu == "Misc2" then

      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_AYLEID_WELL_HEADER)),
      })
      table.insert(submenu, { -- Ayleid Well pin toggle
        type = "checkbox",
        width = "half",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MISC_PIN_AYLEID_WELL_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_MISC_PIN_AYLEID_WELL_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.AYLEID] end,
        setFunc = function(state)
          TogglePins(DPINS.AYLEID, state)
          RedrawAllPins(DPINS.AYLEID)
        end,
        default = defaults.filters[DPINS.AYLEID],
      })
      table.insert(submenu, { -- Ayleid Well pintype
        type = "dropdown",
        width = "half",
        reference = "previewpinTextureAyleid",
        choices = pinTextures.lists.Ayleid,
        getFunc = function() return pinTextures.lists.Ayleid[DestinationsSV.pins.pinTextureAyleid.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Ayleid) do
            if name == selected then
              DestinationsSV.pins.pinTextureAyleid.type = index
              LMP:SetLayoutKey(DPINS.AYLEID, "texture", pinTextures.paths.Ayleid[index])
              AyleidPreview:SetTexture(pinTextures.paths.Ayleid[index])
              RedrawAllPins(DPINS.AYLEID)
              break
            end
          end
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.AYLEID] end,
        default = pinTextures.lists.Ayleid[defaults.pins.pinTextureAyleid.type],
      })
      table.insert(submenu, { -- Ayleid Well pin size
        type = "slider",
        name = GetString(DEST_SETTINGS_MISC_PIN_AYLEID_WELL_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureAyleid.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureAyleid.size = size
          AyleidPreview:SetDimensions(size, size)
          LMP:SetLayoutKey(DPINS.AYLEID, "size", size)
          RedrawAllPins(DPINS.AYLEID)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.AYLEID] end,
        default = defaults.pins.pinTextureAyleid.size
      })
      table.insert(submenu, { -- Ayleid pin color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_MISC_PIN_AYLEID_WELL_COLOR),
        tooltip = GetString(DEST_SETTINGS_MISC_PIN_AYLEID_WELL_COLOR_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureAyleid.tint) end,
        setFunc = function(r, g, b, a)
          DestinationsSV.pins.pinTextureAyleid.tint = { r, g, b, a }
          LMP:SetLayoutKey(DPINS.AYLEID, "tint", ZO_ColorDef:New(r, g, b, a))
          AyleidPreview:SetColor(r, g, b, a)
          RedrawAllPins(DPINS.AYLEID)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.AYLEID] end,
        default = { r = defaults.pins.pinTextureAyleid.tint[1], g = defaults.pins.pinTextureAyleid.tint[2], b = defaults.pins.pinTextureAyleid.tint[3], a = defaults.pins.pinTextureAyleid.tint[4] }
      })
      table.insert(submenu, { -- Ayleid pin text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_MISC_PINTEXT_AYLEID_WELL_COLOR),
        tooltip = GetString(DEST_SETTINGS_MISC_PINTEXT_AYLEID_WELL_COLOR_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureAyleid.textcolor) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureAyleid.textcolor = { r, g, b }
          LMP:RefreshPins(DPINS.AYLEID)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.AYLEID] end,
        default = { r = defaults.pins.pinTextureAyleid.textcolor[1], g = defaults.pins.pinTextureAyleid.textcolor[2], b = defaults.pins.pinTextureAyleid.textcolor[3] }
      })
      ---- Deadlands Begin
      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_DEADLANDS_ENTRANCE_HEADER)),
      })
      table.insert(submenu, { -- Deadlands pin toggle
        type = "checkbox",
        width = "half",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.DEADLANDS] end,
        setFunc = function(state)
          TogglePins(DPINS.DEADLANDS, state)
          RedrawAllPins(DPINS.DEADLANDS)
        end,
        default = defaults.filters[DPINS.DEADLANDS],
      })
      table.insert(submenu, { -- Deadlands pintype
        type = "dropdown",
        width = "half",
        reference = "previewpinTextureDeadlands",
        choices = pinTextures.lists.Deadlands,
        getFunc = function() return pinTextures.lists.Deadlands[DestinationsSV.pins.pinTextureDeadlands.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Deadlands) do
            if name == selected then
              DestinationsSV.pins.pinTextureDeadlands.type = index
              LMP:SetLayoutKey(DPINS.DEADLANDS, "texture", pinTextures.paths.Deadlands[index])
              DeadlandsPreview:SetTexture(pinTextures.paths.Deadlands[index])
              RedrawAllPins(DPINS.DEADLANDS)
              break
            end
          end
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.DEADLANDS] end,
        default = pinTextures.lists.Deadlands[defaults.pins.pinTextureDeadlands.type],
      })
      table.insert(submenu, { -- Deadlands pin size
        type = "slider",
        name = GetString(DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureDeadlands.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureDeadlands.size = size
          DeadlandsPreview:SetDimensions(size, size)
          LMP:SetLayoutKey(DPINS.DEADLANDS, "size", size)
          RedrawAllPins(DPINS.DEADLANDS)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.DEADLANDS] end,
        default = defaults.pins.pinTextureDeadlands.size
      })
      --[[
      table.insert(submenu, { -- Deadlands pin color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_COLOR),
        tooltip = GetString(DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_COLOR_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureDeadlands.tint) end,
        setFunc = function(r, g, b, a)
          DestinationsSV.pins.pinTextureDeadlands.tint = { r, g, b, a }
          LMP:SetLayoutKey(DPINS.DEADLANDS, "tint", ZO_ColorDef:New(r, g, b, a))
          DeadlandsPreview:SetColor(r, g, b, a)
          RedrawAllPins(DPINS.DEADLANDS)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.DEADLANDS] end,
        default = { r = defaults.pins.pinTextureDeadlands.tint[1], g = defaults.pins.pinTextureDeadlands.tint[2], b = defaults.pins.pinTextureDeadlands.tint[3], a = defaults.pins.pinTextureDeadlands.tint[4] }
      })
      ]]--
      table.insert(submenu, { -- Deadlands pin text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_MISC_PINTEXT_DEADLANDS_ENTRANCE_COLOR),
        tooltip = GetString(DEST_SETTINGS_MISC_PINTEXT_DEADLANDS_ENTRANCE_COLOR_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureDeadlands.textcolor) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureDeadlands.textcolor = { r, g, b }
          LMP:RefreshPins(DPINS.DEADLANDS)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.DEADLANDS] end,
        default = { r = defaults.pins.pinTextureDeadlands.textcolor[1], g = defaults.pins.pinTextureDeadlands.textcolor[2], b = defaults.pins.pinTextureDeadlands.textcolor[3] }
      })
      ---- Deadlands End
      ---- HighIsle Begin
      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_HIGHISLE_SHRINE_HEADER)),
      })
      table.insert(submenu, { -- HighIsle pin toggle
        type = "checkbox",
        width = "half",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.HIGHISLE] end,
        setFunc = function(state)
          TogglePins(DPINS.HIGHISLE, state)
          RedrawAllPins(DPINS.HIGHISLE)
        end,
        default = defaults.filters[DPINS.HIGHISLE],
      })
      table.insert(submenu, { -- HighIsle pintype
        type = "dropdown",
        width = "half",
        reference = "previewpinTextureHighIsle",
        choices = pinTextures.lists.HighIsle,
        getFunc = function() return pinTextures.lists.HighIsle[DestinationsSV.pins.pinTextureHighIsle.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.HighIsle) do
            if name == selected then
              DestinationsSV.pins.pinTextureHighIsle.type = index
              LMP:SetLayoutKey(DPINS.HIGHISLE, "texture", pinTextures.paths.HighIsle[index])
              HighIslePreview:SetTexture(pinTextures.paths.HighIsle[index])
              RedrawAllPins(DPINS.HIGHISLE)
              break
            end
          end
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.HIGHISLE] end,
        default = pinTextures.lists.HighIsle[defaults.pins.pinTextureHighIsle.type],
      })
      table.insert(submenu, { -- HighIsle pin size
        type = "slider",
        name = GetString(DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureHighIsle.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureHighIsle.size = size
          HighIslePreview:SetDimensions(size, size)
          LMP:SetLayoutKey(DPINS.HIGHISLE, "size", size)
          RedrawAllPins(DPINS.HIGHISLE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.HIGHISLE] end,
        default = defaults.pins.pinTextureHighIsle.size
      })
      --[[
      table.insert(submenu, { -- HighIsle pin color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_COLOR),
        tooltip = GetString(DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_COLOR_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureHighIsle.tint) end,
        setFunc = function(r, g, b, a)
          DestinationsSV.pins.pinTextureHighIsle.tint = { r, g, b, a }
          LMP:SetLayoutKey(DPINS.HIGHISLE, "tint", ZO_ColorDef:New(r, g, b, a))
          HighIslePreview:SetColor(r, g, b, a)
          RedrawAllPins(DPINS.HIGHISLE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.HIGHISLE] end,
        default = { r = defaults.pins.pinTextureHighIsle.tint[1], g = defaults.pins.pinTextureHighIsle.tint[2], b = defaults.pins.pinTextureHighIsle.tint[3], a = defaults.pins.pinTextureHighIsle.tint[4] }
      })
      ]]--
      table.insert(submenu, { -- HighIsle pin text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_MISC_PINTEXT_HIGHISLE_DRUIDICSHRINES_COLOR),
        tooltip = GetString(DEST_SETTINGS_MISC_PINTEXT_HIGHISLE_DRUIDICSHRINES_COLOR_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureHighIsle.textcolor) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureHighIsle.textcolor = { r, g, b }
          LMP:RefreshPins(DPINS.HIGHISLE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.HIGHISLE] end,
        default = { r = defaults.pins.pinTextureHighIsle.textcolor[1], g = defaults.pins.pinTextureHighIsle.textcolor[2], b = defaults.pins.pinTextureHighIsle.textcolor[3] }
      })
      ---- HighIsle End
      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_DWEMER_HEADER)),
      })
      table.insert(submenu, { -- Dwemer pin toggle
        type = "checkbox",
        width = "half",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MISC_DWEMER_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_MISC_DWEMER_PIN_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.DWEMER] end,
        setFunc = function(state)
          TogglePins(DPINS.DWEMER, state)
          RedrawAllPins(DPINS.DWEMER)
        end,
        default = defaults.filters[DPINS.DWEMER],
      })
      table.insert(submenu, { -- Dwemer pin style
        type = "dropdown",
        width = "half",
        reference = "previewpinTextureDwemer",
        choices = pinTextures.lists.Dwemer,
        getFunc = function() return pinTextures.lists.Dwemer[DestinationsSV.pins.pinTextureDwemer.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Dwemer) do
            if name == selected then
              DestinationsSV.pins.pinTextureDwemer.type = index
              LMP:SetLayoutKey(DPINS.DWEMER, "texture", pinTextures.paths.dwemer[index])
              DwemerPreview:SetTexture(pinTextures.paths.dwemer[index])
              RedrawAllPins(DPINS.DWEMER)
              break
            end
          end
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.DWEMER] end,
        default = pinTextures.lists.Dwemer[defaults.pins.pinTextureDwemer.type],
      })
      table.insert(submenu, { -- Dwemer pin size
        type = "slider",
        name = GetString(DEST_SETTINGS_MISC_DWEMER_PIN_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureDwemer.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureDwemer.size = size
          DwemerPreview:SetDimensions(size, size)
          LMP:SetLayoutKey(DPINS.DWEMER, "size", size)
          RedrawAllPins(DPINS.DWEMER)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.DWEMER] end,
        default = defaults.pins.pinTextureDwemer.size
      })
      table.insert(submenu, { -- Dwemer pin color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_MISC_DWEMER_PIN_COLOR),
        tooltip = GetString(DEST_SETTINGS_MISC_DWEMER_PIN_COLOR_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureDwemer.tint) end,
        setFunc = function(r, g, b, a)
          DestinationsSV.pins.pinTextureDwemer.tint = { r, g, b, a }
          LMP:SetLayoutKey(DPINS.DWEMER, "tint", ZO_ColorDef:New(r, g, b, a))
          DwemerPreview:SetColor(r, g, b, a)
          RedrawAllPins(DPINS.DWEMER)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.DWEMER] end,
        default = { r = defaults.pins.pinTextureDwemer.tint[1], g = defaults.pins.pinTextureDwemer.tint[2], b = defaults.pins.pinTextureDwemer.tint[3], a = defaults.pins.pinTextureDwemer.tint[4] }
      })
      table.insert(submenu, { -- Dwemer pin text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_MISC_DWEMER_PINTEXT_COLOR),
        tooltip = GetString(DEST_SETTINGS_MISC_DWEMER_PINTEXT_COLOR_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureDwemer.textcolor) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureDwemer.textcolor = { r, g, b }
          LMP:RefreshPins(DPINS.DWEMER)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.DWEMER] end,
        default = { r = defaults.pins.pinTextureDwemer.textcolor[1], g = defaults.pins.pinTextureDwemer.textcolor[2], b = defaults.pins.pinTextureDwemer.textcolor[3] }
      })
      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_COMPASS_HEADER)),
      })
      table.insert(submenu, { -- Ayleid Well/Dwemer toggle compass
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MISC_COMPASS_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.MISC_COMPASS] end,
        setFunc = function(state)
          TogglePins(DPINS.MISC_COMPASS, state)
          RedrawCompassPinsOnly(DPINS.AYLEID)
          RedrawCompassPinsOnly(DPINS.DEADLANDS)
          RedrawCompassPinsOnly(DPINS.HIGHISLE)
          RedrawCompassPinsOnly(DPINS.DWEMER)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.AYLEID] and
          not DestinationsCSSV.filters[DPINS.DEADLANDS] and
          not DestinationsCSSV.filters[DPINS.HIGHISLE] and
          not DestinationsCSSV.filters[DPINS.DWEMER]
        end,
        default = defaults.filters[DPINS.MISC_COMPASS],
      })
      table.insert(submenu, { -- Ayleid Well/Dwemer compass pin distance
        type = "slider",
        name = GetString(DEST_SETTINGS_MISC_COMPASS_DIST),
        min = 1,
        max = 100,
        getFunc = function() return DestinationsSV.pins.pinTextureAyleid.maxDistance * 1000 end,
        setFunc = function(maxDistance)
          DestinationsSV.pins.pinTextureAyleid.maxDistance = maxDistance / 1000
          DestinationsSV.pins.pinTextureDeadlands.maxDistance = maxDistance / 1000
          DestinationsSV.pins.pinTextureHighIsle.maxDistance = maxDistance / 1000
          DestinationsSV.pins.pinTextureDwemer.maxDistance = maxDistance / 1000
          COMPASS_PINS.pinLayouts[DPINS.AYLEID].maxDistance = maxDistance / 1000
          COMPASS_PINS.pinLayouts[DPINS.DEADLANDS].maxDistance = maxDistance / 1000
          COMPASS_PINS.pinLayouts[DPINS.HIGHISLE].maxDistance = maxDistance / 1000
          COMPASS_PINS.pinLayouts[DPINS.DWEMER].maxDistance = maxDistance / 1000
          RedrawCompassPinsOnly(DPINS.AYLEID)
          RedrawCompassPinsOnly(DPINS.DEADLANDS)
          RedrawCompassPinsOnly(DPINS.HIGHISLE)
          RedrawCompassPinsOnly(DPINS.DWEMER)
        end,
        disabled = function() return
        (not DestinationsCSSV.filters[DPINS.AYLEID] and
          not DestinationsCSSV.filters[DPINS.DEADLANDS] and
          not DestinationsCSSV.filters[DPINS.HIGHISLE] and
          not DestinationsCSSV.filters[DPINS.DWEMER]) or
          not DestinationsCSSV.filters[DPINS.MISC_COMPASS]
        end,
        default = defaults.pins.pinTextureAyleid.maxDistance * 1000,
      })
      table.insert(submenu, { -- Ayleid Well/Dwemer pin layer
        type = "slider",
        name = GetString(DEST_SETTINGS_MISC_PIN_LAYER),
        min = 10,
        max = 200,
        step = 5,
        getFunc = function() return DestinationsSV.pins.pinTextureAyleid.level end,
        setFunc = function(level)
          DestinationsSV.pins.pinTextureAyleid.level = level
          DestinationsSV.pins.pinTextureDeadlands.level = level
          DestinationsSV.pins.pinTextureHighIsle.level = level
          DestinationsSV.pins.pinTextureDwemer.level = level
          LMP:SetLayoutKey(DPINS.AYLEID, "level", level)
          LMP:SetLayoutKey(DPINS.DEADLANDS, "level", level)
          LMP:SetLayoutKey(DPINS.HIGHISLE, "level", level)
          LMP:SetLayoutKey(DPINS.DWEMER, "level", level)
          RedrawAllPins(DPINS.AYLEID)
          RedrawAllPins(DPINS.DEADLANDS)
          RedrawAllPins(DPINS.HIGHISLE)
          RedrawAllPins(DPINS.DWEMER)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.AYLEID] and
          not DestinationsCSSV.filters[DPINS.DWEMER] and
          not DestinationsCSSV.filters[DPINS.HIGHISLE] and
          not DestinationsCSSV.filters[DPINS.DEADLANDS]
        end,
        default = defaults.pins.pinTextureAyleid.level
      })

    elseif menu == "VampWW" then

      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_VWW_WWVAMP_HEADER)),
      })
      table.insert(submenu, { -- Werewolf/Vampire pin toggle
        type = "checkbox",
        width = "half",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_VWW_PIN_WWVAMP_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_VWW_PIN_WWVAMP_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.WWVAMP] end,
        setFunc = function(state)
          TogglePins(DPINS.WWVAMP, state)
          RedrawAllPins(DPINS.WWVAMP)
        end,
        default = defaults.filters[DPINS.WWVAMP],
      })
      table.insert(submenu, { -- Werewolf/Vampire pintype
        type = "dropdown",
        width = "half",
        reference = "previewpinTextureWWVamp",
        choices = pinTextures.lists.WWVamp,
        getFunc = function() return pinTextures.lists.WWVamp[DestinationsSV.pins.pinTextureWWVamp.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.WWVamp) do
            if name == selected then
              DestinationsSV.pins.pinTextureWWVamp.type = index
              LMP:SetLayoutKey(DPINS.WWVAMP, "texture", pinTextures.paths.wwvamp[index])
              WWVampPreview:SetTexture(pinTextures.paths.wwvamp[index])
              RedrawAllPins(DPINS.WWVAMP)
              break
            end
          end
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.WWVAMP] end,
        default = pinTextures.lists.WWVamp[defaults.pins.pinTextureWWVamp.type],
      })
      table.insert(submenu, { -- Werewolf/Vampire pin size
        type = "slider",
        name = GetString(DEST_SETTINGS_VWW_PIN_WWVAMP_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureWWVamp.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureWWVamp.size = size
          WWVampPreview:SetDimensions(size, size)
          LMP:SetLayoutKey(DPINS.WWVAMP, "size", size)
          RedrawAllPins(DPINS.WWVAMP)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.WWVAMP] end,
        default = defaults.pins.pinTextureWWVamp.size
      })
      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_VWW_VAMP_HEADER)),
      })
      table.insert(submenu, { -- Vampire Alter pin toggle
        type = "checkbox",
        width = "half",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.VAMPIRE_ALTAR] end,
        setFunc = function(state)
          TogglePins(DPINS.VAMPIRE_ALTAR, state)
          RedrawAllPins(DPINS.VAMPIRE_ALTAR)
        end,
        default = defaults.filters[DPINS.VAMPIRE_ALTAR],
      })
      table.insert(submenu, { -- Vampire Alter pintype
        type = "dropdown",
        width = "half",
        reference = "previewpinTextureVampAltar",
        choices = pinTextures.lists.VampAltar,
        getFunc = function() return pinTextures.lists.VampAltar[DestinationsSV.pins.pinTextureVampAltar.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.VampAltar) do
            if name == selected then
              DestinationsSV.pins.pinTextureVampAltar.type = index
              LMP:SetLayoutKey(DPINS.VAMPIRE_ALTAR, "texture", pinTextures.paths.vampirealtar[index])
              VampAltarPreview:SetTexture(pinTextures.paths.vampirealtar[index])
              RedrawAllPins(DPINS.VAMPIRE_ALTAR)
              break
            end
          end
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.VAMPIRE_ALTAR] end,
        default = pinTextures.lists.VampAltar[defaults.pins.pinTextureVampAltar.type],
      })
      table.insert(submenu, { -- Vampire Alter pin size
        type = "slider",
        name = GetString(DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureVampAltar.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureVampAltar.size = size
          VampAltarPreview:SetDimensions(size, size)
          LMP:SetLayoutKey(DPINS.VAMPIRE_ALTAR, "size", size)
          RedrawAllPins(DPINS.VAMPIRE_ALTAR)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.VAMPIRE_ALTAR] end,
        default = defaults.pins.pinTextureVampAltar.size
      })
      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_VWW_WW_HEADER)),
      })
      table.insert(submenu, { -- Werewolf Shrine pin toggle
        type = "checkbox",
        width = "half",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_VWW_PIN_WW_SHRINE_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_VWW_PIN_WW_SHRINE_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.WEREWOLF_SHRINE] end,
        setFunc = function(state)
          TogglePins(DPINS.WEREWOLF_SHRINE, state)
          RedrawAllPins(DPINS.WEREWOLF_SHRINE)
        end,
        default = defaults.filters[DPINS.WEREWOLF_SHRINE],
      })
      table.insert(submenu, { -- Werewolf Shrine pintype
        type = "dropdown",
        width = "half",
        reference = "previewpinTextureWWShrine",
        choices = pinTextures.lists.WWShrine,
        getFunc = function() return pinTextures.lists.WWShrine[DestinationsSV.pins.pinTextureWWShrine.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.WWShrine) do
            if name == selected then
              DestinationsSV.pins.pinTextureWWShrine.type = index
              LMP:SetLayoutKey(DPINS.WEREWOLF_SHRINE, "texture", pinTextures.paths.werewolfshrine[index])
              WWShrinePreview:SetTexture(pinTextures.paths.werewolfshrine[index])
              RedrawAllPins(DPINS.WEREWOLF_SHRINE)
              break
            end
          end
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.WEREWOLF_SHRINE] end,
        default = pinTextures.lists.WWShrine[defaults.pins.pinTextureWWShrine.type],
      })
      table.insert(submenu, { -- Werewolf Shrine pin size
        type = "slider",
        name = GetString(DEST_SETTINGS_VWW_PIN_WW_SHRINE_SIZE),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureWWShrine.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureWWShrine.size = size
          WWShrinePreview:SetDimensions(size, size)
          LMP:SetLayoutKey(DPINS.WEREWOLF_SHRINE, "size", size)
          RedrawAllPins(DPINS.WEREWOLF_SHRINE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.WEREWOLF_SHRINE] end,
        default = defaults.pins.pinTextureWWShrine.size
      })
      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_VWW_COMPASS_HEADER)),
      })
      table.insert(submenu, { -- Werewolf/Vampire toggle compass
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_VWW_COMPASS_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.VWW_COMPASS] end,
        setFunc = function(state)
          TogglePins(DPINS.VWW_COMPASS, state)
          RedrawCompassPinsOnly(DPINS.WWVAMP)
          RedrawCompassPinsOnly(DPINS.VAMPIRE_ALTAR)
          RedrawCompassPinsOnly(DPINS.WEREWOLF_SHRINE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.WWVAMP] and
          not DestinationsCSSV.filters[DPINS.VAMPIRE_ALTAR] and
          not DestinationsCSSV.filters[DPINS.WEREWOLF_SHRINE]
        end,
        default = defaults.filters[DPINS.VWW_COMPASS],
      })
      table.insert(submenu, { -- Werewolf/Vampire compass pin distance
        type = "slider",
        name = GetString(DEST_SETTINGS_VWW_COMPASS_DIST),
        min = 1,
        max = 100,
        getFunc = function() return DestinationsSV.pins.pinTextureWWShrine.maxDistance * 1000 end,
        setFunc = function(maxDistance)
          DestinationsSV.pins.pinTextureWWVamp.maxDistance = maxDistance / 1000
          DestinationsSV.pins.pinTextureWWShrine.maxDistance = maxDistance / 1000
          DestinationsSV.pins.pinTextureVampAltar.maxDistance = maxDistance / 1000
          COMPASS_PINS.pinLayouts[DPINS.WWVAMP].maxDistance = maxDistance / 1000
          COMPASS_PINS.pinLayouts[DPINS.VAMPIRE_ALTAR].maxDistance = maxDistance / 1000
          COMPASS_PINS.pinLayouts[DPINS.WEREWOLF_SHRINE].maxDistance = maxDistance / 1000
          RedrawCompassPinsOnly(DPINS.WWVAMP)
          RedrawCompassPinsOnly(DPINS.VAMPIRE_ALTAR)
          RedrawCompassPinsOnly(DPINS.WEREWOLF_SHRINE)
        end,
        disabled = function() return
        (not DestinationsCSSV.filters[DPINS.WWVAMP] and
          not DestinationsCSSV.filters[DPINS.VAMPIRE_ALTAR] and
          not DestinationsCSSV.filters[DPINS.WEREWOLF_SHRINE]) or
          not DestinationsCSSV.filters[DPINS.VWW_COMPASS]
        end,
        default = defaults.pins.pinTextureWWShrine.maxDistance * 1000,
      })
      table.insert(submenu, { -- Werewolf/Vampire pin layer
        type = "slider",
        name = GetString(DEST_SETTINGS_VWW_PIN_LAYER),
        min = 10,
        max = 200,
        step = 5,
        getFunc = function() return DestinationsSV.pins.pinTextureWWShrine.level end,
        setFunc = function(level)
          DestinationsSV.pins.pinTextureWWVamp.level = level
          DestinationsSV.pins.pinTextureWWShrine.level = level
          DestinationsSV.pins.pinTextureVampAltar.level = level
          LMP:SetLayoutKey(DPINS.WWVAMP, "level", level)
          LMP:SetLayoutKey(DPINS.VAMPIRE_ALTAR, "level", level)
          LMP:SetLayoutKey(DPINS.WEREWOLF_SHRINE, "level", level)
          RedrawAllPins(DPINS.WWVAMP)
          RedrawAllPins(DPINS.VAMPIRE_ALTAR)
          RedrawAllPins(DPINS.WEREWOLF_SHRINE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.WWVAMP] and
          not DestinationsCSSV.filters[DPINS.VAMPIRE_ALTAR] and
          not DestinationsCSSV.filters[DPINS.WEREWOLF_SHRINE]
        end,
        default = defaults.pins.pinTextureWWShrine.level
      })
      table.insert(submenu, { -- Werewolf/Vampire pin color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_VWW_PIN_COLOR),
        tooltip = GetString(DEST_SETTINGS_VWW_PIN_COLOR_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureWWVamp.tint) end,
        setFunc = function(r, g, b, a)
          DestinationsSV.pins.pinTextureWWVamp.tint = { r, g, b, a }
          DestinationsSV.pins.pinTextureVampAltar.tint = { r, g, b, a }
          DestinationsSV.pins.pinTextureWWShrine.tint = { r, g, b, a }
          LMP:SetLayoutKey(DPINS.WWVAMP, "tint", ZO_ColorDef:New(r, g, b, a))
          WWVampPreview:SetColor(r, g, b, a)
          LMP:SetLayoutKey(DPINS.VAMPIRE_ALTAR, "tint", ZO_ColorDef:New(r, g, b, a))
          VampAltarPreview:SetColor(r, g, b, a)
          LMP:SetLayoutKey(DPINS.WEREWOLF_SHRINE, "tint", ZO_ColorDef:New(r, g, b, a))
          WWShrinePreview:SetColor(r, g, b, a)
          RedrawAllPins(DPINS.WWVAMP)
          RedrawAllPins(DPINS.VAMPIRE_ALTAR)
          RedrawAllPins(DPINS.WEREWOLF_SHRINE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.WWVAMP] and
          not DestinationsCSSV.filters[DPINS.VAMPIRE_ALTAR] and
          not DestinationsCSSV.filters[DPINS.WEREWOLF_SHRINE]
        end,
        default = { r = defaults.pins.pinTextureWWVamp.tint[1], g = defaults.pins.pinTextureWWVamp.tint[2], b = defaults.pins.pinTextureWWVamp.tint[3], a = defaults.pins.pinTextureWWVamp.tint[4] }
      })
      table.insert(submenu, { -- Werewolf/Vampire pin text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_VWW_PINTEXT_COLOR),
        tooltip = GetString(DEST_SETTINGS_VWW_PINTEXT_COLOR_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureWWVamp.textcolor) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureWWVamp.textcolor = { r, g, b }
          DestinationsSV.pins.pinTextureVampAltar.textcolor = { r, g, b }
          DestinationsSV.pins.pinTextureWWShrine.textcolor = { r, g, b }
          LMP:RefreshPins(DPINS.WWVAMP)
          LMP:RefreshPins(DPINS.VAMPIRE_ALTAR)
          LMP:RefreshPins(DPINS.WEREWOLF_SHRINE)
        end,
        disabled = function() return
        not DestinationsCSSV.filters[DPINS.WWVAMP] and
          not DestinationsCSSV.filters[DPINS.VAMPIRE_ALTAR] and
          not DestinationsCSSV.filters[DPINS.WEREWOLF_SHRINE]
        end,
        default = { r = defaults.pins.pinTextureWWVamp.textcolor[1], g = defaults.pins.pinTextureWWVamp.textcolor[2], b = defaults.pins.pinTextureWWVamp.textcolor[3] }
      })

    elseif menu == "Collectibles" then

      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_SUBHEADER)),
      })
      table.insert(submenu, { -- Collectible pin toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.COLLECTIBLES] end,
        setFunc = function(state)
          TogglePins(DPINS.COLLECTIBLES, state)
          RedrawAllPins(DPINS.COLLECTIBLES)
          RedrawAllPins(DPINS.COLLECTIBLESDONE)
        end,
        default = defaults.filters[DPINS.COLLECTIBLES],
      })
      table.insert(submenu, { -- Collectible Completed pin toggle
        type = "checkbox",
        width = "full",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_DONE_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_DONE_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.COLLECTIBLESDONE] end,
        setFunc = function(state)
          TogglePins(DPINS.COLLECTIBLESDONE, state)
          RedrawAllPins(DPINS.COLLECTIBLESDONE)
        end,
        default = defaults.filters[DPINS.COLLECTIBLESDONE],
      })
      table.insert(submenu, { -- Collectible pin style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_STYLE),
        reference = "previewpinTextureCollectible",
        choices = pinTextures.lists.Collectible,
        getFunc = function() return pinTextures.lists.Collectible[DestinationsSV.pins.pinTextureCollectible.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Collectible) do
            if name == selected then
              DestinationsSV.pins.pinTextureCollectible.type = index
              DestinationsSV.pins.pinTextureCollectibleDone.type = index
              LMP:SetLayoutKey(DPINS.COLLECTIBLES, "texture", pinTextures.paths.collectible[index])
              LMP:SetLayoutKey(DPINS.COLLECTIBLESDONE, "texture", pinTextures.paths.collectibledone[index])
              CollectiblePreview:SetTexture(pinTextures.paths.collectible[index])
              CollectibleDonePreview:SetTexture(pinTextures.paths.collectibledone[index])
              RedrawAllPins(DPINS.COLLECTIBLES)
              RedrawAllPins(DPINS.COLLECTIBLESDONE)
              break
            end
          end
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.COLLECTIBLES] and not DestinationsCSSV.filters[DPINS.COLLECTIBLESDONE] end,
        default = pinTextures.lists.Collectible[defaults.pins.pinTextureCollectible.type],
      })
      table.insert(submenu, { -- Collectible Name on pin toggle
        type = "checkbox",
        width = "full",
        name = GetString(DEST_SETTINGS_COLLECTIBLES_SHOW_MOBNAME),
        tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_SHOW_MOBNAME_TT),
        getFunc = function() return DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_MOBNAME] end,
        setFunc = function(state)
          DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_MOBNAME] = state
          RedrawAllPins(DPINS.COLLECTIBLES)
          RedrawAllPins(DPINS.COLLECTIBLESDONE)
        end,
        default = defaults.filters[DPINS.COLLECTIBLES_SHOW_MOBNAME],
        disabled = function() return not DestinationsCSSV.filters[DPINS.COLLECTIBLES] and not DestinationsCSSV.filters[DPINS.COLLECTIBLESDONE] end,
      })
      table.insert(submenu, { -- Collectible Item on pin toggle
        type = "checkbox",
        width = "full",
        name = GetString(DEST_SETTINGS_COLLECTIBLES_SHOW_ITEM),
        tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_SHOW_ITEM_TT),
        getFunc = function() return DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_ITEM] end,
        setFunc = function(state)
          DestinationsSV.filters[DPINS.COLLECTIBLES_SHOW_ITEM] = state
          RedrawAllPins(DPINS.COLLECTIBLES)
          RedrawAllPins(DPINS.COLLECTIBLESDONE)
        end,
        default = defaults.filters[DPINS.COLLECTIBLES_SHOW_ITEM],
        disabled = function() return not DestinationsCSSV.filters[DPINS.COLLECTIBLES] and not DestinationsCSSV.filters[DPINS.COLLECTIBLESDONE] end,
      })
      table.insert(submenu, { -- Collectible title pin text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_COLLECTIBLES_COLOR_TITLE),
        tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_COLOR_TITLE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureCollectible.textcolortitle) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureCollectible.textcolortitle = { r, g, b }
          RedrawAllPins(DPINS.COLLECTIBLES)
          RedrawAllPins(DPINS.COLLECTIBLESDONE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.COLLECTIBLES] and not DestinationsCSSV.filters[DPINS.COLLECTIBLESDONE] end,
        default = { r = defaults.pins.pinTextureCollectible.textcolortitle[1], g = defaults.pins.pinTextureCollectible.textcolortitle[2], b = defaults.pins.pinTextureCollectible.textcolortitle[3] }
      })
      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_COLORS_HEADER)),
      })
      table.insert(submenu, { -- Collectible Missing pin color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_COLOR),
        tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureCollectible.tint) end,
        setFunc = function(r, g, b, a)
          DestinationsSV.pins.pinTextureCollectible.tint = { r, g, b, a }
          CollectiblePreview:SetColor(r, g, b, a)
          LMP:SetLayoutKey(DPINS.COLLECTIBLES, "tint", ZO_ColorDef:New(r, g, b, a))
          LMP:RefreshPins(DPINS.COLLECTIBLES)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.COLLECTIBLES] end,
        default = { r = defaults.pins.pinTextureCollectible.tint[1], g = defaults.pins.pinTextureCollectible.tint[2], b = defaults.pins.pinTextureCollectible.tint[3], a = defaults.pins.pinTextureCollectible.tint[4] }
      })
      table.insert(submenu, { -- Collectible Missing pin text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_COLLECTIBLES_COLOR_UNDONE),
        tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_COLOR_UNDONE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureCollectible.textcolor) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureCollectible.textcolor = { r, g, b }
          RedrawAllPins(DPINS.COLLECTIBLES)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.COLLECTIBLES] end,
        default = { r = defaults.pins.pinTextureCollectible.textcolor[1], g = defaults.pins.pinTextureCollectible.textcolor[2], b = defaults.pins.pinTextureCollectible.textcolor[3] }
      })
      table.insert(submenu, { -- Collectible Completed pin color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_DONE),
        tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_DONE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureCollectibleDone.tint) end,
        setFunc = function(r, g, b, a)
          DestinationsSV.pins.pinTextureCollectibleDone.tint = { r, g, b, a }
          CollectibleDonePreview:SetColor(r, g, b, a)
          LMP:SetLayoutKey(DPINS.COLLECTIBLESDONE, "tint", ZO_ColorDef:New(r, g, b, a))
          LMP:RefreshPins(DPINS.COLLECTIBLESDONE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.COLLECTIBLESDONE] end,
        default = { r = defaults.pins.pinTextureCollectibleDone.tint[1], g = defaults.pins.pinTextureCollectibleDone.tint[2], b = defaults.pins.pinTextureCollectibleDone.tint[3], a = defaults.pins.pinTextureCollectibleDone.tint[4] }
      })
      table.insert(submenu, { -- Collectible Completed pin text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_COLLECTIBLES_COLOR_DONE),
        tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_COLOR_DONE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureCollectibleDone.textcolor) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureCollectibleDone.textcolor = { r, g, b }
          RedrawAllPins(DPINS.COLLECTIBLESDONE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.COLLECTIBLESDONE] end,
        default = { r = defaults.pins.pinTextureCollectibleDone.textcolor[1], g = defaults.pins.pinTextureCollectibleDone.textcolor[2], b = defaults.pins.pinTextureCollectibleDone.textcolor[3] }
      })
      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_MISC_HEADER)),
      })
      table.insert(submenu, { -- Collectible on compass toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_COMPASS_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_COMPASS_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.COLLECTIBLES_COMPASS] end,
        setFunc = function(state)
          TogglePins(DPINS.COLLECTIBLES_COMPASS, state)
          RedrawCompassPinsOnly(DPINS.COLLECTIBLES)
          RedrawCompassPinsOnly(DPINS.COLLECTIBLESDONE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.COLLECTIBLES] and not DestinationsCSSV.filters[DPINS.COLLECTIBLESDONE] end,
        default = defaults.filters[DPINS.COLLECTIBLES_COMPASS],
      })
      table.insert(submenu, { -- Collectible compass distance
        type = "slider",
        name = GetString(DEST_SETTINGS_COLLECTIBLES_COMPASS_DIST),
        tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_COMPASS_DIST_TT),
        min = 1,
        max = 100,
        getFunc = function() return DestinationsSV.pins.pinTextureCollectible.maxDistance * 1000 end,
        setFunc = function(maxDistance)
          DestinationsSV.pins.pinTextureCollectible.maxDistance = maxDistance / 1000
          DestinationsSV.pins.pinTextureCollectibleDone.maxDistance = maxDistance / 1000
          COMPASS_PINS.pinLayouts[DPINS.COLLECTIBLES].maxDistance = maxDistance / 1000
          COMPASS_PINS.pinLayouts[DPINS.COLLECTIBLESDONE].maxDistance = maxDistance / 1000
          RedrawCompassPinsOnly(DPINS.COLLECTIBLES)
          RedrawCompassPinsOnly(DPINS.COLLECTIBLESDONE)
        end,
        width = "full",
        disabled = function() return (not DestinationsCSSV.filters[DPINS.COLLECTIBLES] and not DestinationsCSSV.filters[DPINS.COLLECTIBLESDONE]) or not DestinationsCSSV.filters[DPINS.COLLECTIBLES_COMPASS] end,
        default = defaults.pins.pinTextureCollectible.maxDistance * 1000,
      })
      table.insert(submenu, { -- Collectible pin size
        type = "slider",
        name = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_SIZE),
        tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_SIZE_TT),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureCollectible.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureCollectible.size = size
          DestinationsSV.pins.pinTextureCollectibleDone.size = size
          CollectiblePreview:SetDimensions(size, size)
          CollectibleDonePreview:SetDimensions(size, size)
          LMP:SetLayoutKey(DPINS.COLLECTIBLES, "size", size)
          LMP:SetLayoutKey(DPINS.COLLECTIBLESDONE, "size", size)
          RedrawAllPins(DPINS.COLLECTIBLES)
          RedrawAllPins(DPINS.COLLECTIBLESDONE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.COLLECTIBLES] and not DestinationsCSSV.filters[DPINS.COLLECTIBLESDONE] end,
        default = defaults.pins.pinTextureCollectible.size
      })
      table.insert(submenu, { -- Collectible pin layer
        type = "slider",
        name = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_LAYER),
        tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_LAYER_TT),
        min = 10,
        max = 200,
        step = 5,
        getFunc = function() return DestinationsSV.pins.pinTextureCollectible.level end,
        setFunc = function(level)
          DestinationsSV.pins.pinTextureCollectible.level = level
          DestinationsSV.pins.pinTextureCollectibleDone.level = level - 1
          LMP:SetLayoutKey(DPINS.COLLECTIBLES, "level", level)
          LMP:SetLayoutKey(DPINS.COLLECTIBLESDONE, "level", level - 1)
          RedrawAllPins(DPINS.COLLECTIBLES)
          RedrawAllPins(DPINS.COLLECTIBLESDONE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.COLLECTIBLES] and not DestinationsCSSV.filters[DPINS.COLLECTIBLESDONE] end,
        default = defaults.pins.pinTextureCollectible.level
      })

    elseif menu == "Fish" then

      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_FISHING_SUBHEADER)),
      })
      table.insert(submenu, { -- Fish pin toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_FISHING_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_FISHING_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.FISHING] end,
        setFunc = function(state)
          TogglePins(DPINS.FISHING, state)
          RedrawAllPins(DPINS.FISHING)
          RedrawAllPins(DPINS.FISHINGDONE)
        end,
        default = defaults.filters[DPINS.FISHING],
      })
      table.insert(submenu, { -- Fish Completed pin toggle
        type = "checkbox",
        width = "full",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_FISHING_DONE_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_FISHING_DONE_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
        setFunc = function(state)
          TogglePins(DPINS.FISHINGDONE, state)
          RedrawAllPins(DPINS.FISHINGDONE)
        end,
        default = defaults.filters[DPINS.FISHINGDONE],
      })
      table.insert(submenu, { -- Fish pin style
        type = "dropdown",
        name = GetString(DEST_SETTINGS_FISHING_PIN_STYLE),
        reference = "previewpinTextureFish",
        choices = pinTextures.lists.Fish,
        getFunc = function() return pinTextures.lists.Fish[DestinationsSV.pins.pinTextureFish.type] end,
        setFunc = function(selected)
          for index, name in ipairs(pinTextures.lists.Fish) do
            if name == selected then
              DestinationsSV.pins.pinTextureFish.type = index
              DestinationsSV.pins.pinTextureFishDone.type = index
              LMP:SetLayoutKey(DPINS.FISHING, "texture", pinTextures.paths.fish[index])
              LMP:SetLayoutKey(DPINS.FISHINGDONE, "texture", pinTextures.paths.fishdone[index])
              FishPreview:SetTexture(pinTextures.paths.fish[index])
              FishDonePreview:SetTexture(pinTextures.paths.fishdone[index])
              RedrawAllPins(DPINS.FISHING)
              RedrawAllPins(DPINS.FISHINGDONE)
              break
            end
          end
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] and not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
        default = pinTextures.lists.Fish[defaults.pins.pinTextureFish.type],
      })
      table.insert(submenu, { -- Fish pin title pin text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_FISHING_COLOR_TITLE),
        tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_TITLE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureFish.textcolortitle) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureFish.textcolortitle = { r, g, b }
          RedrawAllPins(DPINS.FISHING)
          RedrawAllPins(DPINS.FISHINGDONE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] and not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
        default = { r = defaults.pins.pinTextureFish.textcolortitle[1], g = defaults.pins.pinTextureFish.textcolortitle[2], b = defaults.pins.pinTextureFish.textcolortitle[3] }
      })
      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_FISHING_PIN_TEXT_HEADER)),
      })
      table.insert(submenu, { -- Fish Name on pin toggle
        type = "checkbox",
        width = "full",
        name = GetString(DEST_SETTINGS_FISHING_SHOW_FISHNAME),
        tooltip = GetString(DEST_SETTINGS_FISHING_SHOW_FISHNAME_TT),
        getFunc = function() return DestinationsSV.filters[DPINS.FISHING_SHOW_FISHNAME] end,
        setFunc = function(state)
          DestinationsSV.filters[DPINS.FISHING_SHOW_FISHNAME] = state
          RedrawAllPins(DPINS.FISHING)
          RedrawAllPins(DPINS.FISHINGDONE)
        end,
        default = defaults.filters[DPINS.FISHING_SHOW_FISHNAME],
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] and not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
      })
      table.insert(submenu, { -- Fish Bait on pin toggle
        type = "checkbox",
        width = "full",
        name = GetString(DEST_SETTINGS_FISHING_SHOW_BAIT),
        tooltip = GetString(DEST_SETTINGS_FISHING_SHOW_BAIT_TT),
        getFunc = function() return DestinationsSV.filters[DPINS.FISHING_SHOW_BAIT] end,
        setFunc = function(state)
          DestinationsSV.filters[DPINS.FISHING_SHOW_BAIT] = state
          RedrawAllPins(DPINS.FISHING)
          RedrawAllPins(DPINS.FISHINGDONE)
        end,
        default = defaults.filters[DPINS.FISHING_SHOW_BAIT],
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] and not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
      })
      table.insert(submenu, { -- Fish Bait Left on pin toggle
        type = "checkbox",
        width = "full",
        name = GetString(DEST_SETTINGS_FISHING_SHOW_BAIT_LEFT),
        tooltip = GetString(DEST_SETTINGS_FISHING_SHOW_BAIT_LEFT_TT),
        getFunc = function() return DestinationsSV.filters[DPINS.FISHING_SHOW_BAIT_LEFT] end,
        setFunc = function(state)
          DestinationsSV.filters[DPINS.FISHING_SHOW_BAIT_LEFT] = state
          RedrawAllPins(DPINS.FISHING)
        end,
        default = defaults.filters[DPINS.FISHING_SHOW_BAIT_LEFT],
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] and not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
      })
      table.insert(submenu, { -- Fish Water on pin toggle
        type = "checkbox",
        width = "full",
        name = GetString(DEST_SETTINGS_FISHING_SHOW_WATER),
        tooltip = GetString(DEST_SETTINGS_FISHING_SHOW_WATER_TT),
        getFunc = function() return DestinationsSV.filters[DPINS.FISHING_SHOW_WATER] end,
        setFunc = function(state)
          DestinationsSV.filters[DPINS.FISHING_SHOW_WATER] = state
          RedrawAllPins(DPINS.FISHING)
          RedrawAllPins(DPINS.FISHINGDONE)
        end,
        default = defaults.filters[DPINS.FISHING_SHOW_WATER],
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] and not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
      })
      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_FISHING_COLOR_HEADER)),
      })
      table.insert(submenu, { -- Fish Missing pin color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_FISHING_PIN_COLOR),
        tooltip = GetString(DEST_SETTINGS_FISHING_PIN_COLOR_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureFish.tint) end,
        setFunc = function(r, g, b, a)
          DestinationsSV.pins.pinTextureFish.tint = { r, g, b, a }
          FishPreview:SetColor(r, g, b, a)
          LMP:SetLayoutKey(DPINS.FISHING, "tint", ZO_ColorDef:New(r, g, b, a))
          LMP:RefreshPins(DPINS.FISHING)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] end,
        default = { r = defaults.pins.pinTextureFish.tint[1], g = defaults.pins.pinTextureFish.tint[2], b = defaults.pins.pinTextureFish.tint[3], a = defaults.pins.pinTextureFish.tint[4] }
      })
      table.insert(submenu, { -- Fish Missing pin text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_FISHING_COLOR_UNDONE),
        tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_UNDONE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureFish.textcolor) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureFish.textcolor = { r, g, b }
          RedrawAllPins(DPINS.FISHING)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] end,
        default = { r = defaults.pins.pinTextureFish.textcolor[1], g = defaults.pins.pinTextureFish.textcolor[2], b = defaults.pins.pinTextureFish.textcolor[3] }
      })
      table.insert(submenu, { -- Fish Missing pin bait text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_FISHING_COLOR_BAIT_UNDONE),
        tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_BAIT_UNDONE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureFish.textcolorBait) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureFish.textcolorBait = { r, g, b }
          RedrawAllPins(DPINS.FISHING)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] end,
        default = { r = defaults.pins.pinTextureFish.textcolorBait[1], g = defaults.pins.pinTextureFish.textcolorBait[2], b = defaults.pins.pinTextureFish.textcolorBait[3] }
      })
      table.insert(submenu, { -- Fish Missing pin water text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_FISHING_COLOR_WATER_UNDONE),
        tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_WATER_UNDONE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureFish.textcolorWater) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureFish.textcolorWater = { r, g, b }
          RedrawAllPins(DPINS.FISHING)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] end,
        default = { r = defaults.pins.pinTextureFish.textcolorWater[1], g = defaults.pins.pinTextureFish.textcolorWater[2], b = defaults.pins.pinTextureFish.textcolorWater[3] }
      })
      table.insert(submenu, { -- Fish Completed pin color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_FISHING_PIN_COLOR_DONE),
        tooltip = GetString(DEST_SETTINGS_FISHING_PIN_COLOR_DONE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureFishDone.tint) end,
        setFunc = function(r, g, b, a)
          DestinationsSV.pins.pinTextureFishDone.tint = { r, g, b, a }
          FishDonePreview:SetColor(r, g, b, a)
          LMP:SetLayoutKey(DPINS.FISHINGDONE, "tint", ZO_ColorDef:New(r, g, b, a))
          LMP:RefreshPins(DPINS.FISHINGDONE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
        default = { r = defaults.pins.pinTextureFishDone.tint[1], g = defaults.pins.pinTextureFishDone.tint[2], b = defaults.pins.pinTextureFishDone.tint[3], a = defaults.pins.pinTextureFishDone.tint[4] }
      })
      table.insert(submenu, { -- Fish Completed pin text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_FISHING_COLOR_DONE),
        tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_DONE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureFishDone.textcolor) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureFishDone.textcolor = { r, g, b }
          RedrawAllPins(DPINS.FISHINGDONE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
        default = { r = defaults.pins.pinTextureFishDone.textcolor[1], g = defaults.pins.pinTextureFishDone.textcolor[2], b = defaults.pins.pinTextureFishDone.textcolor[3] }
      })
      table.insert(submenu, { -- Fish Completed pin bait text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_FISHING_COLOR_BAIT_DONE),
        tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_BAIT_DONE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureFishDone.textcolorBait) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureFishDone.textcolorBait = { r, g, b }
          RedrawAllPins(DPINS.FISHING)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
        default = { r = defaults.pins.pinTextureFishDone.textcolorBait[1], g = defaults.pins.pinTextureFishDone.textcolorBait[2], b = defaults.pins.pinTextureFishDone.textcolorBait[3] }
      })
      table.insert(submenu, { -- Fish Completed pin water text color
        type = "colorpicker",
        name = GetString(DEST_SETTINGS_FISHING_COLOR_WATER_DONE),
        tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_WATER_DONE_TT),
        getFunc = function() return unpack(DestinationsSV.pins.pinTextureFishDone.textcolorWater) end,
        setFunc = function(r, g, b)
          DestinationsSV.pins.pinTextureFishDone.textcolorWater = { r, g, b }
          RedrawAllPins(DPINS.FISHING)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
        default = { r = defaults.pins.pinTextureFishDone.textcolorWater[1], g = defaults.pins.pinTextureFishDone.textcolorWater[2], b = defaults.pins.pinTextureFishDone.textcolorWater[3] }
      })
      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_FISHING_MISC_HEADER)),
      })
      table.insert(submenu, { -- Fish on compass toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_FISHING_COMPASS_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_FISHING_COMPASS_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.filters[DPINS.FISHING_COMPASS] end,
        setFunc = function(state)
          TogglePins(DPINS.FISHING_COMPASS, state)
          RedrawCompassPinsOnly(DPINS.FISHING)
          RedrawCompassPinsOnly(DPINS.FISHINGDONE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] and not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
        default = defaults.filters[DPINS.FISHING_COMPASS],
      })
      table.insert(submenu, { -- Fish compass distance
        type = "slider",
        name = GetString(DEST_SETTINGS_FISHING_COMPASS_DIST),
        tooltip = GetString(DEST_SETTINGS_FISHING_COMPASS_DIST_TT),
        min = 1,
        max = 100,
        getFunc = function() return DestinationsSV.pins.pinTextureFish.maxDistance * 1000 end,
        setFunc = function(maxDistance)
          DestinationsSV.pins.pinTextureFish.maxDistance = maxDistance / 1000
          DestinationsSV.pins.pinTextureFishDone.maxDistance = maxDistance / 1000
          COMPASS_PINS.pinLayouts[DPINS.FISHING].maxDistance = maxDistance / 1000
          COMPASS_PINS.pinLayouts[DPINS.FISHINGDONE].maxDistance = maxDistance / 1000
          RedrawCompassPinsOnly(DPINS.FISHING)
          RedrawCompassPinsOnly(DPINS.FISHINGDONE)
        end,
        width = "full",
        disabled = function() return (not DestinationsCSSV.filters[DPINS.FISHING] and not DestinationsCSSV.filters[DPINS.FISHINGDONE]) or not DestinationsCSSV.filters[DPINS.FISHING_COMPASS] end,
        default = defaults.pins.pinTextureFish.maxDistance * 1000,
      })
      table.insert(submenu, { -- Fish pin size
        type = "slider",
        name = GetString(DEST_SETTINGS_FISHING_PIN_SIZE),
        tooltip = GetString(DEST_SETTINGS_FISHING_PIN_SIZE_TT),
        min = 20,
        max = 70,
        getFunc = function() return DestinationsSV.pins.pinTextureFish.size end,
        setFunc = function(size)
          DestinationsSV.pins.pinTextureFish.size = size
          DestinationsSV.pins.pinTextureFishDone.size = size
          FishPreview:SetDimensions(size, size)
          FishDonePreview:SetDimensions(size, size)
          LMP:SetLayoutKey(DPINS.FISHING, "size", size)
          LMP:SetLayoutKey(DPINS.FISHINGDONE, "size", size)
          RedrawAllPins(DPINS.FISHING)
          RedrawAllPins(DPINS.FISHINGDONE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] and not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
        default = defaults.pins.pinTextureFish.size
      })
      table.insert(submenu, { -- Fish pin layer
        type = "slider",
        name = GetString(DEST_SETTINGS_FISHING_PIN_LAYER),
        tooltip = GetString(DEST_SETTINGS_FISHING_PIN_LAYER_TT),
        min = 10,
        max = 200,
        step = 5,
        getFunc = function() return DestinationsSV.pins.pinTextureFish.level end,
        setFunc = function(level)
          DestinationsSV.pins.pinTextureFish.level = level
          DestinationsSV.pins.pinTextureFishDone.level = level - 1
          LMP:SetLayoutKey(DPINS.FISHING, "level", level)
          LMP:SetLayoutKey(DPINS.FISHINGDONE, "level", level - 1)
          RedrawAllPins(DPINS.FISHING)
          RedrawAllPins(DPINS.FISHINGDONE)
        end,
        disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] and not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
        default = defaults.pins.pinTextureFish.level
      })

    elseif menu == "MapFilters" then

      table.insert(submenu, { -- Header
        type = "header",
        name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_SUBHEADER)),
      })
      table.insert(submenu, { -- Map Filter POIs toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_POIS_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_MAPFILTERS_POIS_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.settings.MapFiltersPOIs end,
        setFunc = function(state)
          DestinationsCSSV.settings.activateReloaduiButton = true
          DestinationsCSSV.settings.MapFiltersPOIs = state
        end,
        warning = defaults.miscColorCodes.settingsTextReloadWarning:Colorize(GetString(RELOADUI_INFO)),
        default = defaults.settings.MapFiltersPOIs,
      })
      table.insert(submenu, { -- Map Filter Achievements toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_ACHS_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_MAPFILTERS_ACHS_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.settings.MapFiltersAchievements end,
        setFunc = function(state)
          DestinationsCSSV.settings.activateReloaduiButton = true
          DestinationsCSSV.settings.MapFiltersAchievements = state
        end,
        warning = defaults.miscColorCodes.settingsTextReloadWarning:Colorize(GetString(RELOADUI_INFO)),
        default = defaults.settings.MapFiltersAchievements,
      })
      table.insert(submenu, { -- Map Filter Collectibles toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_COLS_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_MAPFILTERS_COLS_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.settings.MapFiltersCollectibles end,
        setFunc = function(state)
          DestinationsCSSV.settings.activateReloaduiButton = true
          DestinationsCSSV.settings.MapFiltersCollectibles = state
        end,
        warning = defaults.miscColorCodes.settingsTextReloadWarning:Colorize(GetString(RELOADUI_INFO)),
        default = defaults.settings.MapFiltersCollectibles,
      })
      table.insert(submenu, { -- Map Filter Fishing toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_FISS_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_MAPFILTERS_FISS_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.settings.MapFiltersFishing end,
        setFunc = function(state)
          DestinationsCSSV.settings.activateReloaduiButton = true
          DestinationsCSSV.settings.MapFiltersFishing = state
        end,
        warning = defaults.miscColorCodes.settingsTextReloadWarning:Colorize(GetString(RELOADUI_INFO)),
        default = defaults.settings.MapFiltersFishing,
      })
      table.insert(submenu, { -- Map Filter Misc toggle
        type = "checkbox",
        name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_MISS_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
        tooltip = GetString(DEST_SETTINGS_MAPFILTERS_MISS_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
        getFunc = function() return DestinationsCSSV.settings.MapFiltersMisc end,
        setFunc = function(state)
          DestinationsCSSV.settings.activateReloaduiButton = true
          DestinationsCSSV.settings.MapFiltersMisc = state
        end,
        warning = defaults.miscColorCodes.settingsTextReloadWarning:Colorize(GetString(RELOADUI_INFO)),
        default = defaults.settings.MapFiltersMisc,
      })
      table.insert(submenu, { -- Map Filter ReloadUI Button
        type = "button",
        name = GetString(DEST_SETTINGS_RELOADUI),
        tooltip = GetString(RELOADUI_WARNING),
        func = function()
          DestinationsCSSV.settings.activateReloaduiButton = false
          ReloadUI()
        end,
        disabled = function() return not DestinationsCSSV.settings.activateReloaduiButton end,
      })

    end

    return submenu

  end

  table.insert(optionsTable, { -- Toggle using Account Wide settings
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_USE_ACCOUNTWIDE)),
    tooltip = GetString(DEST_SETTINGS_USE_ACCOUNTWIDE_TT),
    getFunc = function() return DestinationsAWSV.settings.useAccountWide end,
    setFunc = function(state)
      DestinationsAWSV.settings.useAccountWide = state
      ReloadUI()
    end,
    warning = defaults.miscColorCodes.settingsTextReloadWarning:Colorize(GetString(DEST_SETTINGS_RELOAD_WARNING)),
    default = defaults.settings.useAccountWide,
  })

  if DestinationsAWSV.settings.useAccountWide then
    table.insert(optionsTable, { -- Account wide tip
      type = "description",
      text = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_HEADER)),
    })
  end

  table.insert(optionsTable, { -- POI Improvements
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextImprove:Colorize(GetString(DEST_SETTINGS_IMPROVEMENT_HEADER)),
    tooltip = GetString(DEST_SETTINGS_IMPROVEMENT_HEADER_TT),
    controls = GetDestinationsLAMSubMenu("Improvement")
  })
  table.insert(optionsTable, { -- Points of Interest submenu
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextUnknown:Colorize(GetString(DEST_SETTINGS_POI_HEADER)),
    tooltip = GetString(DEST_SETTINGS_POI_HEADER_TT),
    controls = GetDestinationsLAMSubMenu("POI")
  })
  table.insert(optionsTable, { -- Achievements submenu
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextAchievements:Colorize(GetString(DEST_SETTINGS_ACH_HEADER)),
    tooltip = GetString(DEST_SETTINGS_ACH_HEADER_TT),
    controls = GetDestinationsLAMSubMenu("Achievements")
  })
  table.insert(optionsTable, { -- Misc POIs submenu
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextMiscellaneous:Colorize(GetString(DEST_SETTINGS_ACH_GLOBAL_HEADER)),
    tooltip = GetString(DEST_SETTINGS_ACH_GLOBAL_HEADER_TT),
    controls = GetDestinationsLAMSubMenu("Misc")
  })
  table.insert(optionsTable, { -- Misc POIs submenu
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextMiscellaneous:Colorize(GetString(DEST_SETTINGS_MISC_HEADER)),
    tooltip = GetString(DEST_SETTINGS_MISC_HEADER_TT),
    controls = GetDestinationsLAMSubMenu("Misc2")
  })
  table.insert(optionsTable, { -- VWW submenu
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextVWW:Colorize(GetString(DEST_SETTINGS_VWW_HEADER)),
    tooltip = GetString(DEST_SETTINGS_VWW_HEADER_TT),
    controls = GetDestinationsLAMSubMenu("VampWW")
  })
  table.insert(optionsTable, { -- Collectible submenu
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextCollectibles:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_HEADER)),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_HEADER_TT),
    controls = GetDestinationsLAMSubMenu("Collectibles")
  })
  table.insert(optionsTable, { -- Fish submenu
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextFish:Colorize(GetString(DEST_SETTINGS_FISHING_HEADER)),
    tooltip = GetString(DEST_SETTINGS_FISHING_HEADER_TT),
    controls = GetDestinationsLAMSubMenu("Fish")
  })
  table.insert(optionsTable, { -- Map Filters submenu
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextFish:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_HEADER)),
    tooltip = GetString(DEST_SETTINGS_MAPFILTERS_HEADER_TT),
    controls = GetDestinationsLAMSubMenu("MapFilters")
  })

  LAM:RegisterOptionControls("Destinations_OptionsPanel", optionsTable)

end

local function InitializeDatastores()

  POIsStore = Destinations.POIsStore
  TradersStore = Destinations.TraderTableStore
  AchIndex = Destinations.ACHDataIndex
  AchStore = Destinations.ACHDataStore
  AchIDs = Destinations.AchIDs
  DBossIndex = Destinations.ChampionTableIndex
  DBossStore = Destinations.ChampionTableStore
  SetsStore = Destinations.SetsStore
  CollectibleIndex = Destinations.CollectibleDataIndex
  CollectibleStore = Destinations.CollectibleDataStore
  CollectibleIDs = Destinations.CollectibleIDs
  FishIndex = Destinations.FishLocationsIndex
  FishStore = Destinations.FishLocationsStore
  FishIDs = Destinations.FishIDs
  FishLocs = Destinations.FishLocs
  KeepsStore = Destinations.KeepsStore
  MundusStore = Destinations.mundusStrings
  QOLDataStore = Destinations.QOLDataStore

end

local function OnLoad(eventCode, addonName)
  if addonName == ADDON_NAME then

    InitializeDatastores()

    DestinationsSV = ZO_SavedVars:NewCharacterNameSettings("Destinations_Settings", 1, nil, defaults) -- Basic
    DestinationsCSSV = ZO_SavedVars:NewCharacterNameSettings("Destinations_Settings", 1, nil, defaults)
    DestinationsAWSV = ZO_SavedVars:NewAccountWide("Destinations_Settings", 1, nil, defaults) -- AccountWide

    if not Destinations.supported_menu_lang then
      --chat messages aren't shown before player is activated
      EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_PLAYER_ACTIVATED, ShowLanguageWarning)
    end

    --Initialize Settings
    if DestinationsAWSV.settings.useAccountWide then
      DestinationsSV = ZO_SavedVars:NewAccountWide("Destinations_Settings", 1, nil, defaults)
    end

    DestinationsSV.settings.useAccountWide = DestinationsAWSV.settings.useAccountWide
    DestinationsCSSV.settings.useAccountWide = DestinationsAWSV.settings.useAccountWide

    if not DestinationsSV.oneTamrielUpdate and not DestinationsCSSV.oneTamrielUpdate and not DestinationsAWSV.oneTamrielUpdate then
      DestinationsSV.pins.pinTextureUnknown = defaults.pins.pinTextureUnknown
      DestinationsCSSV.pins.pinTextureUnknown = defaults.pins.pinTextureUnknown
      DestinationsAWSV.pins.pinTextureUnknown = defaults.pins.pinTextureUnknown
      DestinationsSV.oneTamrielUpdate = true
      DestinationsCSSV.oneTamrielUpdate = true
      DestinationsAWSV.oneTamrielUpdate = true
    end

    DisableEnglishFunctionnalities()

    InitVariables()

    --Check if Gampad mode is activated
    OnGamepadPreferredModeChanged()

    -- Hook ZOS POI Tooltips
    HookPoiTooltips()
    HookKeepTooltips()

    --Establish Pin Configurations
    SetPinLayouts()

    --Initialize Settings Menu
    InitSettings()

    -- Set Description
    InitializeSetDescription()

    --Register Event Triggers
    EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_POI_UPDATED, OnPOIUpdated)
    EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_ACHIEVEMENT_UPDATED, OnAchievementUpdate)
    EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_GAMEPAD_PREFERRED_MODE_CHANGED, OnGamepadPreferredModeChanged)

    EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED)

  end
end
EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED, OnLoad)
