-------------------------------------------------
----- early helper                          -----
-------------------------------------------------
local function is_empty_or_nil(t)
  if t == nil or t == "" then return true end
  return type(t) == "table" and ZO_IsTableEmpty(t) or false
end

local function is_in(search_value, search_table)
  if is_empty_or_nil(search_value) then return false end
  for k, v in pairs(search_table) do
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
local supported_menu_langs = { "de", "en", "es", "fr", "fx", "jf", "jp", "pl", "ru", "zh" }
if is_in(Destinations.client_lang, supported_menu_langs) then
  Destinations.effective_menu_lang = Destinations.client_lang
else
  Destinations.effective_menu_lang = "en"
end
Destinations.supported_menu_lang = Destinations.client_lang == Destinations.effective_menu_lang

-------------------------------------------------
----- Destinations                          -----
-------------------------------------------------
local LMP = LibMapPins
local LMD = LibMapData

local mapTextureName, zoneTextureName, mapData, mapId, zoneId, playerAlliance

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
local DESTINATIONS_PIN_TYPE_MUSHROMTOWER = 54
local DESTINATIONS_PIN_TYPE_GROUPPORTAL = 55
local DESTINATIONS_PIN_TYPE_ENDLESSARCHIVE = 56
local DESTINATIONS_PIN_TYPE_UNKNOWN = 99
local DESTINATIONS_PIN_PRIORITY_OFFSET = 1

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

function Destinations:CreateMapPinLayout(pinType)
  local def = self.pinDefinitions and self.pinDefinitions[pinType]
  if not def then return nil end

  return {
    level = def.level or 30,
    texture = def.texture,
    size = def.size or 32,
    tint = def.tint or DEST_PIN_TEXT_COLOR_OTHER,
  }
end
--[[
Destinations.pinDefinitions[Destinations.PIN_TYPES.MAIQ] = {
  pinType = Destinations.PIN_TYPES.MAIQ, -- "DEST_PinSet_Maiq"
  texture = "Destinations/pins/Achievement_Maiq_Maiq.dds",
  size = 26,
  level = 30,
  maxDistance = 0.05,

  textcolor = DEST_PIN_TEXT_COLOR_MAIQ,
  tint = DEST_PIN_TINT_OTHER,

  mapPinLayout = Destinations:CreateMapPinLayout(Destinations.PIN_TYPES.MAIQ),
  mapCallback = mapPinTypeCallback[Destinations.PIN_TYPES.MAIQ],
  mapCallbackDone = mapPinTypeCallbackDone[Destinations.PIN_TYPES.MAIQ_DONE],

  compassCallback = compassCallback[Destinations.PIN_TYPES.MAIQ],
  compassLayout = compassLayout[Destinations.PIN_TYPES.MAIQ],
  additionalLayout = compassLayout[Destinations.PIN_TYPES.MAIQ] and compassLayout[Destinations.PIN_TYPES.MAIQ].additionalLayout or nil,

  tooltip = compassPinTooltipCreator[Destinations.PIN_TYPES.MAIQ],
}
]]


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
  [DESTINATIONS_PIN_TYPE_ENDLESSARCHIVE] = GetString(POITYPE_ENDLESS_ARCHIVE),
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
  -- EP
  [281] = "balfoyen_base_0",
  [280] = "bleakrock_base_0",
  [57] = "deshaan_base_0",
  [101] = "eastmarch_base_0",
  [117] = "shadowfen_base_0",
  [41] = "stonefalls_base_0",
  [103] = "therift_base_0",
  -- DC
  [104] = "alikr_base_0",
  [92] = "bangkorai_base_0",
  [535] = "betnihk_base_0",
  [3] = "glenumbra_base_0",
  [20] = "rivenspire_base_0",
  [19] = "stormhaven_base_0",
  [534] = "strosmkai_base_0",
  -- AD
  [381] = "auridon_base_0",
  [383] = "grahtwood_base_0",
  [108] = "greenshade_base_0",
  [537] = "khenarthisroost_base_0",
  [58] = "malabaltor_base_0",
  [382] = "reapersmarch_base_0",
  -- World
  [1413] = "u38_apocrypha_base_0",
  [1027] = "artaeum_base_0",
  [1208] = "u28_blackreach_base_0", -- Arkthzand
  [1161] = "blackreach_base_0", -- Greymoor
  [1261] = "blackwood_base_0",
  [980] = "clockwork_base_0",
  [982] = "clockworkoutlawsrefuge_base_0",
  [981] = "brassfortress_base_0",
  [347] = "coldharbour_base_0",
  [888] = "craglorn_base_0",
  [267] = "eyevea_base_0",
  --[[ since there are two entries with 1283 the table is
  messed up. So for Fargrave and The Shambles the mapId
  will be used.
  ]]--
  [2119] = "u32_fargravezone_base_0", -- The zone, 1283
  [1282] = "u32_fargrave_base_0", -- Fargrave City
  [2082] = "u32_theshambles_base_0", -- The Shambles, 1283
  [1383] = "u36_galenisland_base_0", -- Galen
  [823] = "goldcoast_base_0",
  [816] = "hewsbane_base_0",
  [1318] = "u34_systreszone_base_0", -- High Isle
  [726] = "murkmire_base_0",
  [1086] = "elsweyr_base_0", -- Northern Elsweyr
  [1502] = "u46_overland_base_0", -- Solstice
  [1133] = "southernelsweyr_base_0",
  [1011] = "summerset_base_0",
  --[[ since there are two entries with 1414 the table is
  messed up. So for Telvanni Peninsula and Necrom the mapId
  will be used.
  ]]--
  [2274] = "u38_telvannipeninsula_base_0", -- Telvanni Peninsula, 1414
  [2343] = "u38_necrom_base_0", -- Necrom, 1414
  [1286] = "u32deadlandszone_base_0",
  [1207] = "reach_base_0",
  [849] = "vvardenfell_base_0",
  [1443] = "westwealdoverland_base_0",
  [1160] = "westernskryim_base_0",
  [684] = "wrothgar_base_0",
  [181] = "ava_whole_0",
  [584] = "imperialcity_base_0",
}

local achTypes = {
  [1] = GetString(POITYPE_MAIQ),
  [2] = GetString(POITYPE_LB_GTTP_CP),
  [3] = GetString(POITYPE_PEACEMAKER),
  [4] = GetString(POITYPE_CRIME_PAYS),
  [5] = GetString(POITYPE_GIVE_TO_THE_POOR),
  [6] = GetString(POITYPE_LIGHTBRINGER),
  [7] = GetString(POITYPE_NOSEDIVER),
  [8] = GetString(POITYPE_EARTHLYPOS),
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

-- Refresh map pins only
local function RedrawMapPinsOnly(pinType)
  LMP:RefreshPins(pinType)
end

local function RedrawQolPins()
  RedrawMapPinsOnly(Destinations.PIN_TYPES.QOLPINS_DOCK)
  RedrawMapPinsOnly(Destinations.PIN_TYPES.QOLPINS_STABLE)
  RedrawMapPinsOnly(Destinations.PIN_TYPES.QOLPINS_PORTAL)
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
  local notUsed
  if zoneId == 1283 or zoneId == 1414 then
    zoneTextureName = ZoneIDsToFileNames[mapId]
  else
    zoneTextureName = ZoneIDsToFileNames[zoneId]
  end
  notUsed, mapTextureName = LMP:GetZoneAndSubzone(false, true, true)
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

  if LMD.isWorld then
    --Destinations:dm("Debug", "Tamriel or Aurbis reached, stopped")
    return
  end
  qualityOfLifeMapPinData()
  if not mapData then
    --Destinations:dm("Debug", "mapData in not set")
    return
  end

  for key, pinData in pairs(mapData) do

    if pinType == Destinations.PIN_TYPES.QOLPINS_DOCK and pinData.pinsType == Destinations.DocksHighIsle then
      LMP:CreatePin(Destinations.PIN_TYPES.QOLPINS_DOCK, pinData, pinData.x, pinData.y)
    end

    if pinType == Destinations.PIN_TYPES.QOLPINS_STABLE and pinData.pinsType == Destinations.Stable then
      LMP:CreatePin(Destinations.PIN_TYPES.QOLPINS_STABLE, pinData, pinData.x, pinData.y)
    end

    if pinType == Destinations.PIN_TYPES.QOLPINS_PORTAL and pinData.pinsType == Destinations.Portals then
      LMP:CreatePin(Destinations.PIN_TYPES.QOLPINS_PORTAL, pinData, pinData.x, pinData.y)
    end

  end
end

-----
--- Slash commands
-----
--prints message to chat
local function ChatPrint(...)
  local ChatEditControl = CHAT_SYSTEM.textEntry.editControl
  if (not ChatEditControl:HasFocus()) then StartChatInput() end
  ChatEditControl:InsertText(...)
end

local function ShowMyPosition()
  local x, y = GetMapPlayerPosition("player")
  local xs = '"X"'
  local locationString = string.format("{ %.6f, %.6f, 0, 0, 1, %s }, -- %s", x, y, xs, LMD.mapTexture)
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
  if LMP:IsEnabled(Destinations.drtv.pinName) and Destinations.CSSV.filters[Destinations.drtv.pinName] then
    GetMapTextureName()
    mapData = AchStore[mapTextureName]
  end
end

local function OtherpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.LB_GTTP_CP
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 2 then
      local COMP = ZoneToAchievements[767167][zoneTextureName]
      local desca, completedLB, requiredLB = GetAchievementCriterion(873, COMP)
      local descb, completedGTTP, requiredGTTP = GetAchievementCriterion(871, COMP)
      local descc, completedCP, requiredCP = GetAchievementCriterion(869, COMP)
      local completed = completedLB + completedGTTP + completedCP
      local required = requiredLB + requiredGTTP + requiredCP
      Destinations.drtv.pinTag = {}
      if completed ~= required then
        local pinTextLine = 0
        if completedCP ~= requiredCP then
          pinTextLine = pinTextLine + 1
          table.insert(Destinations.drtv.pinTag, pinTextLine,
            DEST_PIN_TEXT_COLOR_OTHER:Colorize(zo_strformat("<<1>>", AchIDs[869])))
        end
        if completedGTTP ~= requiredGTTP then
          pinTextLine = pinTextLine + 1
          table.insert(Destinations.drtv.pinTag, pinTextLine,
            DEST_PIN_TEXT_COLOR_OTHER:Colorize(zo_strformat("<<1>>", AchIDs[871])))
        end
        if completedLB ~= requiredLB then
          pinTextLine = pinTextLine + 1
          table.insert(Destinations.drtv.pinTag, pinTextLine,
            DEST_PIN_TEXT_COLOR_OTHER:Colorize(zo_strformat("<<1>>", AchIDs[873])))
        end
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end

local function OtherpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.LB_GTTP_CP_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 2 then
      local COMP = ZoneToAchievements[767167][zoneTextureName]
      local desca, completedLB, requiredLB = GetAchievementCriterion(873, COMP)
      local descb, completedGTTP, requiredGTTP = GetAchievementCriterion(871, COMP)
      local descc, completedCP, requiredCP = GetAchievementCriterion(869, COMP)
      local completed = completedLB + completedGTTP + completedCP
      local required = requiredLB + requiredGTTP + requiredCP
      Destinations.drtv.pinTag = {}
      local pinTextLine = 0
      if not LMP:IsEnabled(Destinations.PIN_TYPES.LB_GTTP_CP) then
        LMP:SetLayoutKey(Destinations.drtv.pinName, "level", Destinations.SV.pins.pinTextureMaiq.level)
        if completed == required then
          table.insert(Destinations.drtv.pinTag, 1,
            DEST_PIN_TEXT_COLOR_OTHER_DONE:Colorize(zo_strformat("<<1>>", AchIDs[869])))
          table.insert(Destinations.drtv.pinTag, 2,
            DEST_PIN_TEXT_COLOR_OTHER_DONE:Colorize(zo_strformat("<<1>>", AchIDs[871])))
          table.insert(Destinations.drtv.pinTag, 3,
            DEST_PIN_TEXT_COLOR_OTHER_DONE:Colorize(zo_strformat("<<1>>", AchIDs[873])))
        end
      end
      if LMP:IsEnabled(Destinations.PIN_TYPES.LB_GTTP_CP) then
        LMP:SetLayoutKey(Destinations.drtv.pinName, "level", Destinations.SV.pins.pinTextureMaiq.level - 1)
        if completedCP == requiredCP then
          pinTextLine = pinTextLine + 1
          table.insert(Destinations.drtv.pinTag, pinTextLine,
            DEST_PIN_TEXT_COLOR_OTHER_DONE:Colorize(zo_strformat("<<1>>", AchIDs[869])))
        end
        if completedGTTP == requiredGTTP then
          pinTextLine = pinTextLine + 1
          table.insert(Destinations.drtv.pinTag, pinTextLine,
            DEST_PIN_TEXT_COLOR_OTHER_DONE:Colorize(zo_strformat("<<1>>", AchIDs[871])))
        end
        if completedLB == requiredLB then
          pinTextLine = pinTextLine + 1
          table.insert(Destinations.drtv.pinTag, pinTextLine,
            DEST_PIN_TEXT_COLOR_OTHER_DONE:Colorize(zo_strformat("<<1>>", AchIDs[873])))
        end
      end
      if pinTextLine >= 1 then
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function MaiqpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.MAIQ
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 1 then
      local COMP = ZoneToAchievements[872][zoneTextureName]
      local desc, completed, required = GetAchievementCriterion(872, COMP)
      Destinations.drtv.pinTag = {}
      if completed ~= required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_MAIQ:Colorize(zo_strformat("<<1>>", AchIDs[872])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function MaiqpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.MAIQ_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 1 then
      local COMP = ZoneToAchievements[872][zoneTextureName]
      local desc, completed, required = GetAchievementCriterion(872, COMP)
      Destinations.drtv.pinTag = {}
      if completed == required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_MAIQ_DONE:Colorize(zo_strformat("<<1>>", AchIDs[872])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function PeacemakerpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.PEACEMAKER
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 3 then
      local desc, completed, required = GetAchievementCriterion(716)
      Destinations.drtv.pinTag = {}
      if completed ~= required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_PEACEMAKER:Colorize(zo_strformat("<<1>>", AchIDs[716])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function PeacemakerpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.PEACEMAKER_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 3 then
      local desc, completed, required = GetAchievementCriterion(716)
      Destinations.drtv.pinTag = {}
      if completed == required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_PEACEMAKER_DONE:Colorize(zo_strformat("<<1>>", AchIDs[716])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function NosediverpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.NOSEDIVER
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 7 then
      local desc, completed, required = GetAchievementCriterion(406)
      Destinations.drtv.pinTag = {}
      if completed ~= required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_NOSEDIVER:Colorize(zo_strformat("<<1>>", AchIDs[406])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function NosediverpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.NOSEDIVER_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 7 then
      local desc, completed, required = GetAchievementCriterion(406)
      Destinations.drtv.pinTag = {}
      if completed == required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_NOSEDIVER_DONE:Colorize(zo_strformat("<<1>>", AchIDs[406])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function EarthlyPospinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.EARTHLYPOS
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 8 then
      local _, numCompleted, numRequired = GetAchievementCriterion(1121)
      Destinations.drtv.pinTag = {}
      if numCompleted ~= numRequired then
        table.insert(Destinations.drtv.pinTag, 1, DEST_PIN_TEXT_COLOR_EARTHLYPOS:Colorize(zo_strformat("<<1>>", AchIDs[1121])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function EarthlyPospinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.EARTHLYPOS_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 8 then
      local desc, completed, required = GetAchievementCriterion(1121)
      Destinations.drtv.pinTag = {}
      if completed == required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_EARTHLYPOS_DONE:Colorize(zo_strformat("<<1>>", AchIDs[1121])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function OnMepinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.ON_ME
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 9 then
      local COMP = ZoneToAchievements[704][zoneTextureName]
      local desc, completed, required = GetAchievementCriterion(704, COMP)
      Destinations.drtv.pinTag = {}
      if completed ~= required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_ONME:Colorize(zo_strformat("<<1>>", AchIDs[704])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function OnMepinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.ON_ME_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 9 then
      local COMP = ZoneToAchievements[704][zoneTextureName]
      local subName, completed, required = GetAchievementCriterion(704, COMP)
      Destinations.drtv.pinTag = {}
      if completed == required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_ONME_DONE:Colorize(zo_strformat("<<1>>", AchIDs[704])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function BrawlpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.BRAWL
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 10 then
      local desc, completed, required = GetAchievementCriterion(1247)
      Destinations.drtv.pinTag = {}
      if completed ~= required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_BRAWL:Colorize(zo_strformat("<<1>>", AchIDs[1247])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function BrawlpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.BRAWL_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 10 then
      local desc, completed, required = GetAchievementCriterion(1247)
      Destinations.drtv.pinTag = {}
      if completed == required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_BRAWL_DONE:Colorize(zo_strformat("<<1>>", AchIDs[1247])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function PatronpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.PATRON
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 11 then
      local desc, completed, required = GetAchievementCriterion(1316)
      Destinations.drtv.pinTag = {}
      if completed ~= required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_PATRON:Colorize(zo_strformat("<<1>>", AchIDs[1316])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function PatronpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.PATRON_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 11 then
      local desc, completed, required = GetAchievementCriterion(1316)
      Destinations.drtv.pinTag = {}
      if completed == required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_PATRON_DONE:Colorize(zo_strformat("<<1>>", AchIDs[1316])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function WrothgarJumperpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.WROTHGAR_JUMPER
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 12 then
      local _, completed, required = GetAchievementCriterion(1331)
      Destinations.drtv.pinTag = {}
      if completed ~= required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_WROTHGARJUMPER:Colorize(zo_strformat("<<1>>", AchIDs[1331])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function WrothgarJumperpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 12 then
      local desc, completed, required = GetAchievementCriterion(1331)
      Destinations.drtv.pinTag = {}
      if completed == required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_WROTHGARJUMPER_DONE:Colorize(zo_strformat("<<1>>", AchIDs[1331])))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function RelicHunterpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.RELIC_HUNTER
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 14 then
      local NUMBER = tonumber(pinData[AchIndex.KEYCODE])
      local desc, completed, required = GetAchievementCriterion(1250, NUMBER)
      Destinations.drtv.pinTag = {}
      if completed ~= required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_RELICHUNTER:Colorize(zo_strformat("<<1>>", desc)))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function RelicHunterpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.RELIC_HUNTER_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 14 then
      local NUMBER = tonumber(pinData[AchIndex.KEYCODE])
      local desc, completed, required = GetAchievementCriterion(1250, NUMBER)
      Destinations.drtv.pinTag = {}
      if completed == required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_RELICHUNTER_DONE:Colorize(zo_strformat("<<1>>", desc)))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function BreakingpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.BREAKING
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 15 then
      local achNum = pinData[AchIndex.KEYCODE]
      local subName, completed, required = GetAchievementCriterion(1349, achNum)
      Destinations.drtv.pinTag = {}
      if completed ~= required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_BREAKING:Colorize(zo_strformat("<<1>>", AchIDs[1349])))
        table.insert(Destinations.drtv.pinTag, 2,
          DEST_PIN_TEXT_COLOR_BREAKING:Colorize(zo_strformat("<<1>>", "[" .. subName .. "]")))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function BreakingpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.BREAKING_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 15 then
      local achNum = pinData[AchIndex.KEYCODE]
      local subName, completed, required = GetAchievementCriterion(1349, achNum)
      Destinations.drtv.pinTag = {}
      if completed == required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_BREAKING_DONE:Colorize(zo_strformat("<<1>>", AchIDs[1349])))
        table.insert(Destinations.drtv.pinTag, 2,
          DEST_PIN_TEXT_COLOR_BREAKING_DONE:Colorize(zo_strformat("<<1>>", "[" .. subName .. "]")))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
------------------Achievements------------------
local function CutpursepinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.CUTPURSE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 16 then
      local achNum = pinData[AchIndex.KEYCODE]
      local _, completedM, requiredM = GetAchievementCriterion(1383)
      local subName, completed, required = GetAchievementCriterion(pinData[AchIndex.ID], achNum)
      Destinations.drtv.pinTag = {}
      if completed ~= required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_CUTPURSE:Colorize(zo_strformat("<<1>>", AchIDs[1383])))
        table.insert(Destinations.drtv.pinTag, 2,
          DEST_PIN_TEXT_COLOR_CUTPURSE:Colorize(zo_strformat("<<1>>", "[" .. subName .. "]")))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end
local function CutpursepinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.CUTPURSE_DONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 16 then
      local achNum = pinData[AchIndex.KEYCODE]
      local _, completedM, requiredM = GetAchievementCriterion(1383)
      local subName, completed, required = GetAchievementCriterion(pinData[AchIndex.ID], achNum)
      Destinations.drtv.pinTag = {}
      if completed == required then
        table.insert(Destinations.drtv.pinTag, 1,
          DEST_PIN_TEXT_COLOR_CUTPURSE_DONE:Colorize(zo_strformat("<<1>>", AchIDs[1383])))
        table.insert(Destinations.drtv.pinTag, 2,
          DEST_PIN_TEXT_COLOR_CUTPURSE_DONE:Colorize(zo_strformat("<<1>>", "[" .. subName .. "]")))
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
  end
end

------------------Achievements------------------
local function ChampionpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  if LMD:IsOverlandMap() and not Destinations.SV.settings.ShowDungeonBossesInZones then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.CHAMPION
  if LMP:IsEnabled(Destinations.drtv.pinName) then
    GetMapTextureName()
    mapData = DBossStore[mapTextureName]
    if mapData then
      for _, pinData in ipairs(mapData) do
        local CHAMPACH = pinData[DBossIndex.ACH]
        local CHAMPIDX = pinData[DBossIndex.IDX]
        local CHAMPNAME, completed, required = GetAchievementCriterion(tonumber(CHAMPACH), tonumber(CHAMPIDX))
        Destinations.drtv.pinTag = {}
        if completed ~= required then
          Destinations.drtv.pinTag = { DEST_PIN_TINT_OTHER:Colorize(zo_strformat("<<1>>", CHAMPNAME)) }
          LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[DBossIndex.X], pinData[DBossIndex.Y])
        end
      end
    end
  end
end
local function ChampionpinTypeCallbackDone()
  if GetMapType() >= MAPTYPE_WORLD then return end
  if LMD:IsOverlandMap() and not Destinations.SV.settings.ShowDungeonBossesInZones then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.CHAMPION_DONE
  if LMP:IsEnabled(Destinations.drtv.pinName) then
    GetMapTextureName()
    mapData = DBossStore[mapTextureName]
    if mapData then
      for _, pinData in ipairs(mapData) do
        local CHAMPACH = pinData[DBossIndex.ACH]
        local CHAMPIDX = pinData[DBossIndex.IDX]
        local CHAMPNAME, completed, required = GetAchievementCriterion(tonumber(CHAMPACH), tonumber(CHAMPIDX))
        Destinations.drtv.pinTag = {}
        if completed == required then
          Destinations.drtv.pinTag = { DEST_PIN_TINT_OTHER_DONE:Colorize(zo_strformat("<<1>>", CHAMPNAME)) }
          LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[DBossIndex.X], pinData[DBossIndex.Y])
        end
      end
    end
  end
end

--------------------Misc POI--------------------
local function AyleidpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.AYLEID
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    Destinations.drtv.pinTypeName = GetAchTypeName(Destinations.drtv.pinType)
    if Destinations.drtv.pinType == 20 then
      Destinations.drtv.pinTag = { DEST_PIN_TEXT_COLOR_AYLEID:Colorize(zo_strformat("<<1>>", Destinations.drtv.pinTypeName)) }
      LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end
--------------------Misc POI--------------------
local function DeadlandspinTypeCallback()
  -- DESTINATIONS_PIN_TYPE_DEADLANDS
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.DEADLANDS
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    Destinations.drtv.pinTypeName = GetAchTypeName(Destinations.drtv.pinType)
    if Destinations.drtv.pinType == 25 then
      Destinations.drtv.pinTag = { DEST_PIN_TEXT_COLOR_DEADLANDS:Colorize(zo_strformat("<<1>>", Destinations.drtv.pinTypeName)) }
      LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end
--------------------Misc POI--------------------
local function HighIslepinTypeCallback()
  -- DESTINATIONS_PIN_TYPE_HIGHISLE
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.HIGHISLE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    Destinations.drtv.pinTypeName = GetAchTypeName(Destinations.drtv.pinType)
    if Destinations.drtv.pinType == 26 then
      Destinations.drtv.pinTag = { DEST_PIN_TEXT_COLOR_HIGHISLE:Colorize(zo_strformat("<<1>>", Destinations.drtv.pinTypeName)) }
      LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end
--------------------Misc POI--------------------
local function DwemerRuinpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.DWEMER
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    Destinations.drtv.pinTypeName = GetAchTypeName(Destinations.drtv.pinType)
    if Destinations.drtv.pinType == 23 then
      Destinations.drtv.pinTag = { DEST_PIN_TEXT_COLOR_DWEMER:Colorize(zo_strformat("<<1>>", Destinations.drtv.pinTypeName)) }
      LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end
------------Vampire and Werewolf POI------------
local function WWVamppinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.WWVAMP
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    Destinations.drtv.pinTypeName = GetAchTypeName(Destinations.drtv.pinType)
    if Destinations.drtv.pinType == 21 then
      Destinations.drtv.pinTag = { DEST_PIN_TEXT_COLOR_WWVAMP:Colorize(zo_strformat("<<1>>", Destinations.drtv.pinTypeName)) }
      LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end
------------Vampire and Werewolf POI------------
local function VampireAltarpinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.VAMPIRE_ALTAR
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    Destinations.drtv.pinTypeName = GetAchTypeName(Destinations.drtv.pinType)
    if Destinations.drtv.pinType == 22 then
      Destinations.drtv.pinTag = { DEST_PIN_TEXT_COLOR_VAMPALTAR:Colorize(zo_strformat("<<1>>", Destinations.drtv.pinTypeName)) }
      LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end
------------Vampire and Werewolf POI------------
local function WerewolfShrinepinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.WEREWOLF_SHRINE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    Destinations.drtv.pinTypeName = GetAchTypeName(Destinations.drtv.pinType)
    if Destinations.drtv.pinType == 24 then
      Destinations.drtv.pinTag = { DEST_PIN_TEXT_COLOR_WWSHRINE:Colorize(zo_strformat("<<1>>", Destinations.drtv.pinTypeName)) }
      LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end

--------------------Trophies--------------------
local function CollectiblepinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.COLLECTIBLES
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 30 then
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
      Destinations.drtv.pinTag = {}
      local textLine = 0
      local countCN, countCND = 0, 0
      if completedTotal ~= requiredTotal then
        textLine = textLine + 1
        table.insert(Destinations.drtv.pinTag, textLine,
          DEST_PIN_TEXT_COLORTITLE_COLLECTIBLE:Colorize(zo_strformat("<<1>>", CollectibleIDs[collectibleID])))
        local collectibleName, collectibleNumber, collectibleItem = nil, nil, nil, nil
        local collectibledata = CollectibleStore[collectibleID]
        local ColName, ColNumber, ColKey = nil, nil, nil
        local collectibleMobNumber = nil
        for i = 1, requiredTotal, 1 do
          for _, collectibleEntry in ipairs(collectibledata) do
            collectibleNumber = collectibleEntry[CollectibleIndex.NUMBER]
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
              elseif LMP:IsEnabled(Destinations.PIN_TYPES.COLLECTIBLESDONE) then
                countCND = countCND + 1
              end
            end
          end
        end
        if Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_MOBNAME] or Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_ITEM] then
          for i = 1, requiredTotal, 1 do
            for _, collectibleEntry in ipairs(collectibledata) do
              collectibleNumber = collectibleEntry[CollectibleIndex.NUMBER]
              collectibleName = collectibleEntry[CollectibleIndex.NAME]
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
                  if Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_MOBNAME] then
                    textLine = textLine + 1
                    table.insert(Destinations.drtv.pinTag, textLine,
                      DEST_PIN_TEXT_COLOR_COLLECTIBLE:Colorize(zo_strformat("<<1>>", "[" .. collectibleName .. "]")))
                  end
                  if Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_ITEM] then
                    textLine = textLine + 1
                    table.insert(Destinations.drtv.pinTag, textLine,
                      DEST_PIN_TEXT_COLOR_COLLECTIBLE:Colorize(zo_strformat("<<1>>", "<" .. collectibleItem .. ">")))
                  end
                elseif LMP:IsEnabled(Destinations.PIN_TYPES.COLLECTIBLESDONE) then
                  if Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_MOBNAME] then
                    textLine = textLine + 1
                    table.insert(Destinations.drtv.pinTag, textLine,
                      DEST_PIN_TEXT_COLOR_COLLECTIBLE:Colorize(zo_strformat("<<1>>", "[" .. collectibleName .. "]")))
                  end
                  if Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_ITEM] then
                    textLine = textLine + 1
                    table.insert(Destinations.drtv.pinTag, textLine,
                      DEST_PIN_TEXT_COLOR_COLLECTIBLE:Colorize(zo_strformat("<<1>>", "<" .. collectibleItem .. ">")))
                  end
                end
              end
            end
          end
        end
        if countCN >= 1 and countCND == 0 then
          LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      end
    end
  end
end

local function CollectibleDonepinTypeCallback()
  if GetMapType() >= MAPTYPE_WORLD then return end
  Destinations.drtv.pinName = Destinations.PIN_TYPES.COLLECTIBLESDONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 30 then
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
      Destinations.drtv.pinTag = {}
      local textLine = 0
      local countCN = 0
      textLine = textLine + 1
      table.insert(Destinations.drtv.pinTag, textLine,
        DEST_PIN_TEXT_COLORTITLE_COLLECTIBLE:Colorize(zo_strformat("<<1>>", CollectibleIDs[collectibleID])))
      local collectibleName, collectibleNumber, collectibleItem = nil, nil, nil
      local collectibledata = CollectibleStore[collectibleID]
      for i = 1, requiredTotal, 1 do
        for _, collectibleEntry in ipairs(collectibledata) do
          collectibleNumber = collectibleEntry[CollectibleIndex.NUMBER]
          if collectibleNumber == i and string.find(collectibleCode, i) then
            _, completed, _ = GetAchievementCriterion(collectibleID, i)
            if completed == 1 then
              countCN = countCN + 1
            end
          end
        end
      end
      if Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_MOBNAME] or Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_ITEM] then
        for i = 1, requiredTotal, 1 do
          for _, collectibleEntry in ipairs(collectibledata) do
            collectibleNumber = collectibleEntry[CollectibleIndex.NUMBER]
            collectibleName = collectibleEntry[CollectibleIndex.NAME]
            if collectibleNumber == i and string.find(collectibleCode, i) then
              collectibleItem, completed, _ = GetAchievementCriterion(collectibleID, i)
              if completed == 1 then
                if Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_MOBNAME] then
                  textLine = textLine + 1
                  table.insert(Destinations.drtv.pinTag, textLine,
                    DEST_PIN_TEXT_COLOR_COLLECTIBLE_DONE:Colorize(zo_strformat("<<1>>", "[" .. collectibleName .. "]")))
                end
                if Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_ITEM] then
                  textLine = textLine + 1
                  table.insert(Destinations.drtv.pinTag, textLine,
                    DEST_PIN_TEXT_COLOR_COLLECTIBLE_DONE:Colorize(zo_strformat("<<1>>", "<" .. collectibleItem .. ">")))
                end
              end
            end
          end
        end
      end
      if countCN >= 1 then
        LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
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
  Destinations.drtv.pinName = Destinations.PIN_TYPES.FISHING
  sharedAchievementsPinData()
  if not mapData then return end
  if Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_BAIT_LEFT] then
    local numLures = GetNumFishingLures()
    for lureIndex = 1, numLures do
      local name, icon, stack, _, _ = GetFishingLureInfo(lureIndex)
      if string.find(icon, "centipede") then
        --Crawlers
        Destinations.defaults.data.FoulBaitLeft = stack
      elseif string.find(icon, "fish_roe") then
        --Fish Roe
        Destinations.defaults.data.FoulSBaitLeft = stack
      elseif string.find(icon, "torchbug") then
        --Insect Parts
        Destinations.defaults.data.RiverBaitLeft = stack
      elseif string.find(icon, "shad") then
        --Shad
        Destinations.defaults.data.RiverSBaitLeft = stack
      elseif string.find(icon, "worms") then
        --Worms
        Destinations.defaults.data.OceanBaitLeft = stack
      elseif string.find(icon, "fish_tail") and not (string.find(name, "simple") or string.find(name, "einfacher") or string.find(name, "appât")) then
        --Chub
        Destinations.defaults.data.OceanSBaitLeft = stack
      elseif string.find(icon, "guts") then
        --Guts
        Destinations.defaults.data.LakeBaitLeft = stack
      elseif string.find(icon, "river_betty") then
        --Minnow
        Destinations.defaults.data.LakeSBaitLeft = stack
      elseif string.find(icon, "fish_tail") and (string.find(name, "simple") or string.find(name, "einfacher") or string.find(name, "appât")) then
        --Simle Bait
        Destinations.defaults.data.GeneralBait = stack
      end
    end
  end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType and Destinations.drtv.pinType >= 40 and Destinations.drtv.pinType <= 44 then
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
      if Destinations.drtv.pinType == 40 then
        fishingBait = GetString(FISHING_FOUL_BAIT)
        waterType = GetString(FISHING_FOUL)
      elseif Destinations.drtv.pinType == 41 then
        fishingBait = GetString(FISHING_RIVER_BAIT)
        waterType = GetString(FISHING_RIVER)
      elseif Destinations.drtv.pinType == 42 then
        fishingBait = GetString(FISHING_OCEAN_BAIT)
        waterType = GetString(FISHING_OCEAN)
      elseif Destinations.drtv.pinType == 43 then
        fishingBait = GetString(FISHING_LAKE_BAIT)
        waterType = GetString(FISHING_LAKE)
      elseif Destinations.drtv.pinType == 44 then
        waterType = GetString(FISHING_UNKNOWN)
      end
      Destinations.drtv.pinTag = {}
      local textLine = 0
      local countF, countL, countO, countR = 0, 0, 0, 0
      local countFN, countLN, countON, countRN = 0, 0, 0, 0
      local fishdata = FishStore[fishID]
      local FishName, FishNumber, FishLoc = nil, nil, nil
      for _, fishEntry in ipairs(fishdata) do
        FishLoc = fishEntry[FishIndex.LOCATION]
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
        for _, fishEntry in ipairs(fishdata) do
          FishLoc = fishEntry[FishIndex.LOCATION]
          FishNumber = fishEntry[FishIndex.FISHNUMBER]
          if FishNumber == i then
            if Destinations.drtv.pinType == 40 and FishLoc == DESTINATIONS_FISH_TYPE_FOUL then
              FishName, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 0 then
                countFN = countFN + 1
              end
            elseif Destinations.drtv.pinType == 41 and FishLoc == DESTINATIONS_FISH_TYPE_RIVER then
              FishName, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 0 then
                countRN = countRN + 1
              end
            elseif Destinations.drtv.pinType == 42 and FishLoc == DESTINATIONS_FISH_TYPE_OCEAN then
              FishName, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 0 then
                countON = countON + 1
              end
            elseif Destinations.drtv.pinType == 43 and FishLoc == DESTINATIONS_FISH_TYPE_LAKE then
              FishName, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 0 then
                countLN = countLN + 1
              end
            end
          end
        end
      end
      textLine = textLine + 1
      table.insert(Destinations.drtv.pinTag, textLine,
        DEST_PIN_TEXT_COLORTITLE_FISH:Colorize(zo_strformat("<<1>>", FishIDs[fishID])))
      if Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_FISHNAME] then
        for i = 1, requiredTotal, 1 do
          for _, fishEntry in ipairs(fishdata) do
            local fishFound = false
            local fishMiss = false
            FishLoc = fishEntry[FishIndex.LOCATION]
            FishNumber = fishEntry[FishIndex.FISHNUMBER]
            FishName, completed, _ = GetAchievementCriterion(fishID, i)
            if FishNumber == i then
              if Destinations.drtv.pinType == 40 and FishLoc == DESTINATIONS_FISH_TYPE_FOUL then
                if completed == 0 then
                  fishMiss = true
                elseif LMP:IsEnabled(Destinations.PIN_TYPES.FISHINGDONE) then
                  fishFound = true
                end
              elseif Destinations.drtv.pinType == 41 and FishLoc == DESTINATIONS_FISH_TYPE_RIVER then
                if completed == 0 then
                  fishMiss = true
                elseif LMP:IsEnabled(Destinations.PIN_TYPES.FISHINGDONE) then
                  fishFound = true
                end
              elseif Destinations.drtv.pinType == 42 and FishLoc == DESTINATIONS_FISH_TYPE_OCEAN then
                if completed == 0 then
                  fishMiss = true
                elseif LMP:IsEnabled(Destinations.PIN_TYPES.FISHINGDONE) then
                  fishFound = true
                end
              elseif Destinations.drtv.pinType == 43 and FishLoc == DESTINATIONS_FISH_TYPE_LAKE then
                if completed == 0 then
                  fishMiss = true
                elseif LMP:IsEnabled(Destinations.PIN_TYPES.FISHINGDONE) then
                  fishFound = true
                end
              end
            end
            if fishMiss then
              textLine = textLine + 1
              table.insert(Destinations.drtv.pinTag, textLine,
                DEST_PIN_TEXT_COLOR_FISH:Colorize(zo_strformat("<<1>>", "[" .. FishName .. "]")))
              fishMiss = false
            elseif fishFound then
              textLine = textLine + 1
              table.insert(Destinations.drtv.pinTag, textLine,
                DEST_PIN_TEXT_COLOR_FISH_DONE:Colorize(zo_strformat("<<1>>", "[" .. FishName .. "]")))
              fishFound = false
            end
            if Destinations.drtv.pinType == 44 and FishNumber == i then
              if completed == 0 then
                textLine = textLine + 1
                table.insert(Destinations.drtv.pinTag, textLine,
                  DEST_PIN_TEXT_COLOR_FISH:Colorize(zo_strformat("<<1>>", "[" .. FishName .. "]")))
              else
                textLine = textLine + 1
                table.insert(Destinations.drtv.pinTag, textLine,
                  DEST_PIN_TEXT_COLOR_FISH_DONE:Colorize(zo_strformat("<<1>>", "[" .. FishName .. "]")))
              end
            end
          end
        end
      end
      if fishingBait and Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_BAIT] then
        textLine = textLine + 1
        table.insert(Destinations.drtv.pinTag, textLine,
          DEST_PIN_TEXT_COLORBAIT_FISH:Colorize(zo_strformat("<<1>>", "<" .. fishingBait .. ">")))
        if Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_BAIT_LEFT] then
          local fishingBaitLeft = nil
          if Destinations.drtv.pinType == 40 then
            fishingBaitLeft = tostring(Destinations.defaults.data.FoulBaitLeft) .. "/" .. tostring(Destinations.defaults.data.FoulSBaitLeft)
            if Destinations.defaults.data.GeneralBait >= 1 then
              fishingBaitLeft = fishingBaitLeft .. "/" .. tostring(Destinations.defaults.data.GeneralBait)
            end
            textLine = textLine + 1
            table.insert(Destinations.drtv.pinTag, textLine,
              DEST_PIN_TEXT_COLORBAIT_FISH:Colorize(zo_strformat("<<1>>", "{" .. fishingBaitLeft .. "}")))
          elseif Destinations.drtv.pinType == 41 then
            fishingBaitLeft = tostring(Destinations.defaults.data.RiverBaitLeft) .. "/" .. tostring(Destinations.defaults.data.RiverSBaitLeft)
            if Destinations.defaults.data.GeneralBait >= 1 then
              fishingBaitLeft = fishingBaitLeft .. "/" .. tostring(Destinations.defaults.data.GeneralBait)
            end
            textLine = textLine + 1
            table.insert(Destinations.drtv.pinTag, textLine,
              DEST_PIN_TEXT_COLORBAIT_FISH:Colorize(zo_strformat("<<1>>", "{" .. fishingBaitLeft .. "}")))
          elseif Destinations.drtv.pinType == 42 then
            fishingBaitLeft = tostring(Destinations.defaults.data.OceanBaitLeft) .. "/" .. tostring(Destinations.defaults.data.OceanSBaitLeft)
            if Destinations.defaults.data.GeneralBait >= 1 then
              fishingBaitLeft = fishingBaitLeft .. "/" .. tostring(Destinations.defaults.data.GeneralBait)
            end
            textLine = textLine + 1
            table.insert(Destinations.drtv.pinTag, textLine,
              DEST_PIN_TEXT_COLORBAIT_FISH:Colorize(zo_strformat("<<1>>", "{" .. fishingBaitLeft .. "}")))
          elseif Destinations.drtv.pinType == 43 then
            fishingBaitLeft = tostring(Destinations.defaults.data.LakeBaitLeft) .. "/" .. tostring(Destinations.defaults.data.LakeSBaitLeft)
            if Destinations.defaults.data.GeneralBait >= 1 then
              fishingBaitLeft = fishingBaitLeft .. "/" .. tostring(Destinations.defaults.data.GeneralBait)
            end
            textLine = textLine + 1
            table.insert(Destinations.drtv.pinTag, textLine,
              DEST_PIN_TEXT_COLORBAIT_FISH:Colorize(zo_strformat("<<1>>", "{" .. fishingBaitLeft .. "}")))
          end
        end
      end
      if waterType and Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_WATER] then
        textLine = textLine + 1
        table.insert(Destinations.drtv.pinTag, textLine,
          DEST_PIN_TEXT_COLORWATER_FISH:Colorize(zo_strformat("<<1>>", "(" .. waterType .. ")")))
      end
      if countFN >= 1 or countLN >= 1 or countON >= 1 or countRN >= 1 then
        if countF >= 1 or countL >= 1 or countO >= 1 or countR >= 1 then
          LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
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
  Destinations.drtv.pinName = Destinations.PIN_TYPES.FISHINGDONE
  sharedAchievementsPinData()
  if not mapData then return end
  for _, pinData in ipairs(mapData) do
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType and Destinations.drtv.pinType >= 40 and Destinations.drtv.pinType <= 44 then
      local fishID = pinData[AchIndex.ID]
      local _, requiredTotal = 0, GetAchievementNumCriteria(fishID)
      local desc, completed, required = nil, 0, 0
      local fishingBait, waterType = nil
      if Destinations.drtv.pinType == 40 then
        fishingBait = GetString(FISHING_FOUL_BAIT)
        waterType = GetString(FISHING_FOUL)
      elseif Destinations.drtv.pinType == 41 then
        fishingBait = GetString(FISHING_RIVER_BAIT)
        waterType = GetString(FISHING_RIVER)
      elseif Destinations.drtv.pinType == 42 then
        fishingBait = GetString(FISHING_OCEAN_BAIT)
        waterType = GetString(FISHING_OCEAN)
      elseif Destinations.drtv.pinType == 43 then
        fishingBait = GetString(FISHING_LAKE_BAIT)
        waterType = GetString(FISHING_LAKE)
      elseif Destinations.drtv.pinType == 44 then
        waterType = GetString(FISHING_UNKNOWN)
      end
      Destinations.drtv.pinTag = {}
      local textLine = 0
      local countF, countL, countO, countR = 0, 0, 0, 0
      local countFN, countLN, countON, countRN = 0, 0, 0, 0
      local fishdata = FishStore[fishID]
      local FishName, FishNumber, FishLoc = nil, nil, nil

      for _, fishEntry in ipairs(fishdata) do
        FishLoc = fishEntry[FishIndex.LOCATION]
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
        table.insert(Destinations.drtv.pinTag, textLine,
          DEST_PIN_TEXT_COLORTITLE_FISH:Colorize(zo_strformat("<<1>>", FishIDs[fishID])))
        for i = 1, requiredTotal, 1 do
          for _, fishEntry in ipairs(fishdata) do
            FishLoc = fishEntry[FishIndex.LOCATION]
            FishNumber = fishEntry[FishIndex.FISHNUMBER]
            if FishNumber == i then
              _, completed, _ = GetAchievementCriterion(fishID, i)
              if completed == 1 then
                if Destinations.drtv.pinType == 40 and FishLoc == DESTINATIONS_FISH_TYPE_FOUL then
                  countFN = countFN + 1
                elseif Destinations.drtv.pinType == 41 and FishLoc == DESTINATIONS_FISH_TYPE_RIVER then
                  countRN = countRN + 1
                elseif Destinations.drtv.pinType == 42 and FishLoc == DESTINATIONS_FISH_TYPE_OCEAN then
                  countON = countON + 1
                elseif Destinations.drtv.pinType == 43 and FishLoc == DESTINATIONS_FISH_TYPE_LAKE then
                  countLN = countLN + 1
                end
              end
            end
          end
        end
        if Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_FISHNAME] then
          for i = 1, requiredTotal, 1 do
            for _, fishEntry in ipairs(fishdata) do
              FishLoc = fishEntry[FishIndex.LOCATION]
              FishNumber = fishEntry[FishIndex.FISHNUMBER]
              if FishNumber == i then
                FishName, completed, _ = GetAchievementCriterion(fishID, i)
                if completed == 1 then
                  local fishFound = false
                  if Destinations.drtv.pinType == 40 and FishLoc == DESTINATIONS_FISH_TYPE_FOUL then
                    fishFound = true
                  elseif Destinations.drtv.pinType == 41 and FishLoc == DESTINATIONS_FISH_TYPE_RIVER then
                    fishFound = true
                  elseif Destinations.drtv.pinType == 42 and FishLoc == DESTINATIONS_FISH_TYPE_OCEAN then
                    fishFound = true
                  elseif Destinations.drtv.pinType == 43 and FishLoc == DESTINATIONS_FISH_TYPE_LAKE then
                    fishFound = true
                  end
                  if fishFound then
                    textLine = textLine + 1
                    table.insert(Destinations.drtv.pinTag, textLine,
                      DEST_PIN_TEXT_COLOR_FISH_DONE:Colorize(zo_strformat("<<1>>", "[" .. FishName .. "]")))
                    fishFound = false
                  end
                end
              end
            end
          end
        end
        if fishingBait and Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_BAIT] then
          textLine = textLine + 1
          table.insert(Destinations.drtv.pinTag, textLine,
            DEST_PIN_TEXT_COLORBAIT_FISH_DONE:Colorize(zo_strformat("<<1>>", "<" .. fishingBait .. ">")))
        end
        if waterType and Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_WATER] then
          textLine = textLine + 1
          table.insert(Destinations.drtv.pinTag, textLine,
            DEST_PIN_TEXT_COLORWATER_FISH_DONE:Colorize(zo_strformat("<<1>>", "(" .. waterType .. ")")))
        end
        if (countF >= 1 and countF == countFN) or (countL >= 1 and countL == countLN) or (countO >= 1 and countO == countON) or (countR >= 1 and countR == countRN) then
          LMP:CreatePin(Destinations.drtv.pinName, Destinations.drtv.pinTag, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      end
    end
  end
end

local function AddAchievementCompassPins()

  if GetMapType() >= MAPTYPE_WORLD then return end

  mapData, mapTextureName, zoneTextureName, mapId, zoneId = nil, nil, nil, nil, nil
  if Destinations.CSSV.filters[Destinations.PIN_TYPES.ACHIEVEMENTS_COMPASS] then
    GetMapTextureName()
    mapData = AchStore[mapTextureName]
  end

  if mapData and mapTextureName ~= "ava_whole_0" then
    for _, pinData in ipairs(mapData) do
      Destinations.drtv.pinType = pinData[AchIndex.TYPE]
      if Destinations.drtv.pinType == 15 and ((LMP:IsEnabled(Destinations.PIN_TYPES.BREAKING) and Destinations.CSSV.filters[Destinations.PIN_TYPES.BREAKING]) or (LMP:IsEnabled(Destinations.PIN_TYPES.BREAKING_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.BREAKING_DONE])) then
        local NUMBER = tonumber(pinData[AchIndex.KEYCODE])
        local desc, completed, required = GetAchievementCriterion(1250, NUMBER)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.BREAKING, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(Destinations.PIN_TYPES.BREAKING_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.BREAKING_DONE] then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.BREAKING_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif Destinations.drtv.pinType == 14 and ((LMP:IsEnabled(Destinations.PIN_TYPES.RELIC_HUNTER) and Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER]) or (LMP:IsEnabled(Destinations.PIN_TYPES.RELIC_HUNTER_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER_DONE])) then
        local NUMBER = tonumber(pinData[AchIndex.KEYCODE])
        local desc, completed, required = GetAchievementCriterion(1250, NUMBER)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.RELIC_HUNTER, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(Destinations.PIN_TYPES.RELIC_HUNTER_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER_DONE] then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.RELIC_HUNTER_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif Destinations.drtv.pinType == 12 and ((LMP:IsEnabled(Destinations.PIN_TYPES.WROTHGAR_JUMPER) and Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER]) or (LMP:IsEnabled(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE])) then
        local desc, completed, required = GetAchievementCriterion(1331, 1)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.WROTHGAR_JUMPER, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE] then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE, pinData, pinData[AchIndex.X],
            pinData[AchIndex.Y])
        end
      elseif Destinations.drtv.pinType == 11 and ((LMP:IsEnabled(Destinations.PIN_TYPES.PATRON) and Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON]) or (LMP:IsEnabled(Destinations.PIN_TYPES.PATRON_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON_DONE])) then
        local desc, completed, required = GetAchievementCriterion(1316, 1)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.PATRON, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(Destinations.PIN_TYPES.PATRON_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON_DONE] then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.PATRON_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif Destinations.drtv.pinType == 10 and ((LMP:IsEnabled(Destinations.PIN_TYPES.BRAWL) and Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL]) or (LMP:IsEnabled(Destinations.PIN_TYPES.BRAWL_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL_DONE])) then
        local desc, completed, required = GetAchievementCriterion(1247, 1)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.BRAWL, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(Destinations.PIN_TYPES.BRAWL_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL_DONE] then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.BRAWL_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif Destinations.drtv.pinType == 9 and ((LMP:IsEnabled(Destinations.PIN_TYPES.ON_ME) and Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME]) or (LMP:IsEnabled(Destinations.PIN_TYPES.ON_ME_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME_DONE])) then
        local COMP = ZoneToAchievements[704][zoneTextureName]
        local desc, completed, required = GetAchievementCriterion(704, COMP)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.ON_ME, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(Destinations.PIN_TYPES.ON_ME_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME_DONE] then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.ON_ME_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif Destinations.drtv.pinType == 8 and ((LMP:IsEnabled(Destinations.PIN_TYPES.EARTHLYPOS) and Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS]) or (LMP:IsEnabled(Destinations.PIN_TYPES.EARTHLYPOS_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS_DONE])) then
        local desc, completed, required = GetAchievementCriterion(1121, 1)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.EARTHLYPOS, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(Destinations.PIN_TYPES.EARTHLYPOS_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS_DONE] then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.EARTHLYPOS_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif Destinations.drtv.pinType == 7 and ((LMP:IsEnabled(Destinations.PIN_TYPES.NOSEDIVER) and Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER]) or (LMP:IsEnabled(Destinations.PIN_TYPES.NOSEDIVER_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER_DONE])) then
        local desc, completed, required = GetAchievementCriterion(406, 1)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.NOSEDIVER, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(Destinations.PIN_TYPES.NOSEDIVER_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER_DONE] then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.NOSEDIVER_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif Destinations.drtv.pinType == 3 and ((LMP:IsEnabled(Destinations.PIN_TYPES.PEACEMAKER) and Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER]) or (LMP:IsEnabled(Destinations.PIN_TYPES.PEACEMAKER_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER_DONE])) then
        local desc, completed, required = GetAchievementCriterion(716, 1)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.PEACEMAKER, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(Destinations.PIN_TYPES.PEACEMAKER_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER_DONE] then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.PEACEMAKER_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif Destinations.drtv.pinType == 2 and ((LMP:IsEnabled(Destinations.PIN_TYPES.LB_GTTP_CP) and Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP]) or (LMP:IsEnabled(Destinations.PIN_TYPES.LB_GTTP_CP_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP_DONE])) then
        local COMP = ZoneToAchievements[767167][zoneTextureName]
        local desca, completedLB, requiredLB = GetAchievementCriterion(873, COMP)
        local descb, completedGTTP, requiredGTTP = GetAchievementCriterion(871, COMP)
        local descc, completedCP, requiredCP = GetAchievementCriterion(869, COMP)
        local completed = completedLB + completedGTTP + completedCP
        local required = requiredLB + requiredGTTP + requiredCP
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.LB_GTTP_CP, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(Destinations.PIN_TYPES.LB_GTTP_CP_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP_DONE] then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.LB_GTTP_CP_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      elseif Destinations.drtv.pinType == 1 and ((LMP:IsEnabled(Destinations.PIN_TYPES.MAIQ) and Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ]) or (LMP:IsEnabled(Destinations.PIN_TYPES.MAIQ_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ_DONE])) then
        local COMP = ZoneToAchievements[872][zoneTextureName]
        local desc, completed, required = GetAchievementCriterion(872, COMP)
        if completed ~= required then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.MAIQ, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        elseif LMP:IsEnabled(Destinations.PIN_TYPES.MAIQ_DONE) and Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ_DONE] then
          COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.MAIQ_DONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
        end
      end
    end
  end
  if Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION] or Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION_DONE] then
    if LMD:IsOverlandMap() and not Destinations.SV.settings.ShowDungeonBossesInZones then return end
    mapData = DBossStore[mapTextureName]
    if not mapData then return end
    for _, pinData in ipairs(mapData) do
      local CHAMPACH = pinData[DBossIndex.ACH]
      local CHAMPIDX = pinData[DBossIndex.IDX]
      local _, completed, required = GetAchievementCriterion(tonumber(CHAMPACH), tonumber(CHAMPIDX))
      if completed ~= required then
        COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.CHAMPION, pinData, pinData[DBossIndex.X], pinData[DBossIndex.Y])
      elseif Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION_DONE] then
        COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.CHAMPION_DONE, pinData, pinData[DBossIndex.X], pinData[DBossIndex.Y])
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
    Destinations.drtv.pinType = pinData[AchIndex.TYPE]
    if Destinations.drtv.pinType == 20 then
      if not LMP:IsEnabled(Destinations.PIN_TYPES.AYLEID) or not Destinations.CSSV.filters[Destinations.PIN_TYPES.MISC_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.AYLEID, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    elseif Destinations.drtv.pinType == 25 then
      if not LMP:IsEnabled(Destinations.PIN_TYPES.DEADLANDS) or not Destinations.CSSV.filters[Destinations.PIN_TYPES.MISC_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.DEADLANDS, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    elseif Destinations.drtv.pinType == 26 then
      if not LMP:IsEnabled(Destinations.PIN_TYPES.HIGHISLE) or not Destinations.CSSV.filters[Destinations.PIN_TYPES.MISC_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.HIGHISLE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    elseif Destinations.drtv.pinType == 21 then
      if not LMP:IsEnabled(Destinations.PIN_TYPES.WWVAMP) or not Destinations.CSSV.filters[Destinations.PIN_TYPES.VWW_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.WWVAMP, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    elseif Destinations.drtv.pinType == 22 then
      if not LMP:IsEnabled(Destinations.PIN_TYPES.VAMPIRE_ALTAR) or not Destinations.CSSV.filters[Destinations.PIN_TYPES.VWW_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.VAMPIRE_ALTAR, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    elseif Destinations.drtv.pinType == 23 then
      if not LMP:IsEnabled(Destinations.PIN_TYPES.DWEMER) or not Destinations.CSSV.filters[Destinations.PIN_TYPES.MISC_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.DWEMER, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    elseif Destinations.drtv.pinType == 24 then
      if not LMP:IsEnabled(Destinations.PIN_TYPES.WEREWOLF_SHRINE) or not Destinations.CSSV.filters[Destinations.PIN_TYPES.VWW_COMPASS] then return end
      COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.WEREWOLF_SHRINE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
    end
  end
end

local function CollectibleFishCompassPins()
  -- Collectibles, Fishing

  local DESTINATIONS_FISH_TYPE_FOUL = 1
  local DESTINATIONS_FISH_TYPE_RIVER = 2
  local DESTINATIONS_FISH_TYPE_OCEAN = 3
  local DESTINATIONS_FISH_TYPE_LAKE = 4

  if not LMP:IsEnabled(Destinations.PIN_TYPES.COLLECTIBLES) and not LMP:IsEnabled(Destinations.PIN_TYPES.COLLECTIBLES_DONE) and not LMP:IsEnabled(Destinations.PIN_TYPES.FISHING) and not LMP:IsEnabled(Destinations.PIN_TYPES.FISHING_DONE) then return end
  if not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES_DONE] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING_DONE] then return end
  if GetMapType() >= MAPTYPE_WORLD then return end
  GetMapTextureName()
  if not mapTextureName then return end
  local data = AchStore[mapTextureName]
  if not data then return end
  for _, pinData in ipairs(data) do
    local TYPE = pinData[AchIndex.TYPE]
    if TYPE >= 40 and TYPE <= 44 then
      if not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING_COMPASS] or not (LMP:IsEnabled(Destinations.PIN_TYPES.FISHING) and not LMP:IsEnabled(Destinations.PIN_TYPES.FISHING_DONE)) then return end
      local fishID = pinData[AchIndex.ID]
      local _, requiredTotal = 0, GetAchievementNumCriteria(fishID)
      local desc, completed = nil, 0, 0
      local countF, countL, countO, countR = 0, 0, 0, 0
      local countFN, countLN, countON, countRN = 0, 0, 0, 0
      local countFND, countLND, countOND, countRND = 0, 0, 0, 0
      local fishdata = FishStore[fishID]
      local FishName, FishNumber, FishLoc = nil, nil, nil
      for _, fishEntry in ipairs(fishdata) do
        FishLoc = fishEntry[FishIndex.LOCATION]
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
        for _, fishEntry in ipairs(fishdata) do
          FishLoc = fishEntry[FishIndex.LOCATION]
          FishNumber = fishEntry[FishIndex.FISHNUMBER]
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
        COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.FISHING, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
      elseif Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] == true then
        COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.FISHINGDONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    elseif TYPE == 30 then
      if not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES_COMPASS] or not (LMP:IsEnabled(Destinations.PIN_TYPES.COLLECTIBLES) and not LMP:IsEnabled(Destinations.PIN_TYPES.COLLECTIBLES_DONE)) then return end
      local collectibleID = pinData[AchIndex.ID]
      local _, requiredTotal = 0, GetAchievementNumCriteria(collectibleID)
      local completed = 0
      local collectibleNumber = nil
      local collectibledata = CollectibleStore[collectibleID]
      local collectibleCode = pinData[AchIndex.KEYCODE]
      local countCN = 0
      for i = 1, requiredTotal, 1 do
        for _, collectibleEntry in ipairs(collectibledata) do
          collectibleNumber = collectibleEntry[CollectibleIndex.NUMBER]
          if collectibleNumber == i and string.find(collectibleCode, i) then
            _, completed, _ = GetAchievementCriterion(collectibleID, i)
            if completed == 1 then
              countCN = countCN + 1
            end
          end
        end
      end
      if (countCN == 0) then
        COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.COLLECTIBLES, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
      elseif Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLESDONE] == true then
        COMPASS_PINS.pinManager:CreatePin(Destinations.PIN_TYPES.COLLECTIBLESDONE, pinData, pinData[AchIndex.X], pinData[AchIndex.Y])
      end
    end
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
    [DESTINATIONS_PIN_TYPE_GROUPPORTAL] = "/esoui/art/icons/poi/poi_group_portal_complete.dds",
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
    [DESTINATIONS_PIN_TYPE_MUSHROMTOWER] = "/esoui/art/icons/poi/poi_mushromtower_complete.dds",
    [DESTINATIONS_PIN_TYPE_ENDLESSARCHIVE] = "/esoui/art/icons/poi/poi_endlessdungeon_complete.dds",
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
    [DESTINATIONS_PIN_TYPE_GROUPPORTAL] = "/esoui/art/icons/poi/poi_group_portal_incomplete.dds",
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
    [DESTINATIONS_PIN_TYPE_MUSHROMTOWER] = "/esoui/art/icons/poi/poi_mushromtower_incomplete.dds",
    [DESTINATIONS_PIN_TYPE_ENDLESSARCHIVE] = "/esoui/art/icons/poi/poi_endlessdungeon_incomplete.dds",
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
        if pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_MUNDUS and Destinations.SV.settings.ImproveMundus then
          createPin = true
          pinTag.special = MundusStore[mapData[poiIndex].s]
        elseif pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_CRAFTING and Destinations.SV.settings.ImproveCrafting then
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

          LMP:CreatePin(Destinations.PIN_TYPES.FAKEKNOWN, pinTag, normalizedX, normalizedY)
        end

      end
    end
  end

end

local function MapCallback_unknown()

  if GetMapType() >= MAPTYPE_WORLD then return end

  Destinations.drtv.pinName = Destinations.PIN_TYPES.UNKNOWN

  mapData, mapTextureName, zoneTextureName, mapId, zoneId = nil, nil, nil, nil, nil
  if LMP:IsEnabled(Destinations.drtv.pinName) and Destinations.CSSV.filters[Destinations.drtv.pinName] then
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

      if Destinations.SV.pins.pinTextureUnknown.type == 7 then
        pinTag.texture = GetDestinationUnknownPOITexture(destinationsPinType)
      else
        pinTag.texture = Destinations.pinTextures.paths.Unknown[Destinations.SV.pins.pinTextureUnknown.type]
      end

      LMP:CreatePin(Destinations.PIN_TYPES.UNKNOWN, pinTag, normalizedX, normalizedY)

    end
  end
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
  for achId = 1, 5000 do
    local achName, achType, _, _, _, _, _ = GetAchievementInfo(achId)
    if string.len(achName) >= 3 then
      Destinations.SV.TEMPPINDATA[achId] = "\v" .. achName .. "\v"
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
      local normalizedX, normalizedZ, poiPinType, objectiveIcon, isShownInCurrentMap, linkedCollectibleIsLocked, isDiscovered, isNearby = GetPOIMapInfo(zoneIndex, i)
      local poiTypeId = 99
      if objectiveName then
        local poiIndex = tostring(i)
        local objectiveString = "{ n = 0x22%s0x22, t = %s },"
        saveData[poiIndex] = string.format(objectiveString, objectiveName, objectiveIcon)
        Destinations:dm("Info", tostring(poiIndex) .. ": " .. objectiveName)
        if string.find(objectiveIcon, "/esoui/art/icons/poi/") then
          objectiveIcon = string.gsub(objectiveIcon, "/esoui/art/icons/poi/", "")
        end
        Destinations:dm("Info", tostring(poiIndex) .. ": " .. objectiveIcon)
      end
    end
    Destinations:dm("Info", "Done...")
  else
    Destinations:dm("Info", "No data to save...")
  end
end

local function FormatCoords(number)
  return ("%05.04f"):format(zo_round(number * 10000) / 10000)
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
          local mapX, mapY = GetMapPlayerPosition("player")
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
--On "EVENT_POI_UPDATED" redraw map pins
function Destinations:OnPOIUpdated()
  LMP:RefreshPins(self.PIN_TYPES.UNKNOWN)
  LMP:RefreshPins(self.PIN_TYPES.FAKEKNOWN)
end

local function InitVariables()

  playerAlliance = GetUnitAlliance("player")
  Destinations.CSSV.settings.activateReloaduiButton = false

  for _, pinName in pairs(Destinations.drtv.AchPinTex) do
    if Destinations.SV.pins.pinTextureOther.maxDistance then
      if not Destinations.SV.pins[pinName].maxDistance then Destinations.SV.pins[pinName].maxDistance = Destinations.SV.pins.pinTextureOther.maxDistance end
      if not Destinations.SV.pins[pinName].level then Destinations.SV.pins[pinName].level = Destinations.SV.pins.pinTextureOther.level end
      if not Destinations.SV.pins[pinName].tint then Destinations.SV.pins[pinName].tint = Destinations.SV.pins.pinTextureOther.tint end
      if not Destinations.SV.pins[pinName].textcolor then Destinations.SV.pins[pinName].textcolor = Destinations.SV.pins.pinTextureOther.textcolor end
    else
      if not Destinations.SV.pins[pinName].maxDistance then Destinations.SV.pins[pinName].maxDistance = Destinations.defaults.pins.pinTextureOther.maxDistance end
      if not Destinations.SV.pins[pinName].level then Destinations.SV.pins[pinName].level = Destinations.defaults.pins.pinTextureOther.level end
      if not Destinations.SV.pins[pinName].tint then Destinations.SV.pins[pinName].tint = Destinations.defaults.pins.pinTextureOther.tint end
      if not Destinations.SV.pins[pinName].textcolor then Destinations.SV.pins[pinName].textcolor = Destinations.defaults.pins.pinTextureOther.textcolor end
    end
    if not Destinations.SV.pins[pinName].type then Destinations.SV.pins[pinName].type = Destinations.defaults.pins[pinName].type end
    if not Destinations.SV.pins[pinName].size then Destinations.SV.pins[pinName].size = Destinations.defaults.pins[pinName].size end
    pinName = pinName .. "Done"
    if Destinations.SV.pins.pinTextureOtherDone.maxDistance then
      if not Destinations.SV.pins[pinName].maxDistance then Destinations.SV.pins[pinName].maxDistance = Destinations.SV.pins.pinTextureOtherDone.maxDistance end
      if not Destinations.SV.pins[pinName].level then Destinations.SV.pins[pinName].level = Destinations.SV.pins.pinTextureOtherDone.level end
      if not Destinations.SV.pins[pinName].tint then Destinations.SV.pins[pinName].tint = Destinations.SV.pins.pinTextureOtherDone.tint end
      if not Destinations.SV.pins[pinName].textcolor then Destinations.SV.pins[pinName].textcolor = Destinations.SV.pins.pinTextureOtherDone.textcolor end
    else
      if not Destinations.SV.pins[pinName].maxDistance then Destinations.SV.pins[pinName].maxDistance = Destinations.defaults.pins.pinTextureOtherDone.maxDistance end
      if not Destinations.SV.pins[pinName].level then Destinations.SV.pins[pinName].level = Destinations.defaults.pins.pinTextureOtherDone.level end
      if not Destinations.SV.pins[pinName].tint then Destinations.SV.pins[pinName].tint = Destinations.defaults.pins.pinTextureOtherDone.tint end
      if not Destinations.SV.pins[pinName].textcolor then Destinations.SV.pins[pinName].textcolor = Destinations.defaults.pins.pinTextureOtherDone.textcolor end
    end
    if not Destinations.SV.pins[pinName].type then Destinations.SV.pins[pinName].type = Destinations.defaults.pins[pinName].type end
    if not Destinations.SV.pins[pinName].size then Destinations.SV.pins[pinName].size = Destinations.defaults.pins[pinName].size end
  end

  if not Destinations.SV.pins.pinTextureAyleid.maxDistance then Destinations.SV.pins.pinTextureAyleid.maxDistance = Destinations.defaults.pins.pinTextureAyleid.maxDistance end
  if not Destinations.SV.pins.pinTextureAyleid.type then Destinations.SV.pins.pinTextureAyleid.type = Destinations.defaults.pins.pinTextureAyleid.type end
  if not Destinations.SV.pins.pinTextureAyleid.level then Destinations.SV.pins.pinTextureAyleid.level = Destinations.defaults.pins.pinTextureAyleid.level end
  if not Destinations.SV.pins.pinTextureAyleid.size then Destinations.SV.pins.pinTextureAyleid.size = Destinations.defaults.pins.pinTextureAyleid.size end
  if not Destinations.SV.pins.pinTextureAyleid.tint then Destinations.SV.pins.pinTextureAyleid.tint = Destinations.defaults.pins.pinTextureAyleid.tint end
  if not Destinations.SV.pins.pinTextureAyleid.textcolor then Destinations.SV.pins.pinTextureAyleid.textcolor = Destinations.defaults.pins.pinTextureAyleid.textcolor end

  if not Destinations.SV.pins.pinTextureDwemer.maxDistance then Destinations.SV.pins.pinTextureDwemer.maxDistance = Destinations.defaults.pins.pinTextureDwemer.maxDistance end
  if not Destinations.SV.pins.pinTextureDwemer.type then Destinations.SV.pins.pinTextureDwemer.type = Destinations.defaults.pins.pinTextureDwemer.type end
  if not Destinations.SV.pins.pinTextureDwemer.level then Destinations.SV.pins.pinTextureDwemer.level = Destinations.defaults.pins.pinTextureDwemer.level end
  if not Destinations.SV.pins.pinTextureDwemer.size then Destinations.SV.pins.pinTextureDwemer.size = Destinations.defaults.pins.pinTextureDwemer.size end
  if not Destinations.SV.pins.pinTextureDwemer.tint then Destinations.SV.pins.pinTextureDwemer.tint = Destinations.defaults.pins.pinTextureDwemer.tint end
  if not Destinations.SV.pins.pinTextureDwemer.textcolor then Destinations.SV.pins.pinTextureDwemer.textcolor = Destinations.defaults.pins.pinTextureDwemer.textcolor end

  if not Destinations.SV.pins.pinTextureWWVamp.maxDistance then Destinations.SV.pins.pinTextureWWVamp.maxDistance = Destinations.defaults.pins.pinTextureWWVamp.maxDistance end
  if not Destinations.SV.pins.pinTextureWWVamp.type then Destinations.SV.pins.pinTextureWWVamp.type = Destinations.defaults.pins.pinTextureWWVamp.type end
  if not Destinations.SV.pins.pinTextureWWVamp.level then Destinations.SV.pins.pinTextureWWVamp.level = Destinations.defaults.pins.pinTextureWWVamp.level end
  if not Destinations.SV.pins.pinTextureWWVamp.size then Destinations.SV.pins.pinTextureWWVamp.size = Destinations.defaults.pins.pinTextureWWVamp.size end
  if not Destinations.SV.pins.pinTextureWWVamp.tint then Destinations.SV.pins.pinTextureWWVamp.tint = Destinations.defaults.pins.pinTextureWWVamp.tint end
  if not Destinations.SV.pins.pinTextureWWVamp.textcolor then Destinations.SV.pins.pinTextureWWVamp.textcolor = Destinations.defaults.pins.pinTextureWWVamp.textcolor end

  if not Destinations.SV.pins.pinTextureWWShrine.maxDistance then Destinations.SV.pins.pinTextureWWShrine.maxDistance = Destinations.defaults.pins.pinTextureWWShrine.maxDistance end
  if not Destinations.SV.pins.pinTextureWWShrine.type then Destinations.SV.pins.pinTextureWWShrine.type = Destinations.defaults.pins.pinTextureWWShrine.type end
  if not Destinations.SV.pins.pinTextureWWShrine.level then Destinations.SV.pins.pinTextureWWShrine.level = Destinations.defaults.pins.pinTextureWWShrine.level end
  if not Destinations.SV.pins.pinTextureWWShrine.size then Destinations.SV.pins.pinTextureWWShrine.size = Destinations.defaults.pins.pinTextureWWShrine.size end
  if not Destinations.SV.pins.pinTextureWWShrine.tint then Destinations.SV.pins.pinTextureWWShrine.tint = Destinations.defaults.pins.pinTextureWWShrine.tint end
  if not Destinations.SV.pins.pinTextureWWShrine.textcolor then Destinations.SV.pins.pinTextureWWShrine.textcolor = Destinations.defaults.pins.pinTextureWWShrine.textcolor end

  if not Destinations.SV.pins.pinTextureVampAltar.maxDistance then Destinations.SV.pins.pinTextureVampAltar.maxDistance = Destinations.defaults.pins.pinTextureVampAltar.maxDistance end
  if not Destinations.SV.pins.pinTextureVampAltar.type then Destinations.SV.pins.pinTextureVampAltar.type = Destinations.defaults.pins.pinTextureVampAltar.type end
  if not Destinations.SV.pins.pinTextureVampAltar.level then Destinations.SV.pins.pinTextureVampAltar.level = Destinations.defaults.pins.pinTextureVampAltar.level end
  if not Destinations.SV.pins.pinTextureVampAltar.size then Destinations.SV.pins.pinTextureVampAltar.size = Destinations.defaults.pins.pinTextureVampAltar.size end
  if not Destinations.SV.pins.pinTextureVampAltar.tint then Destinations.SV.pins.pinTextureVampAltar.tint = Destinations.defaults.pins.pinTextureVampAltar.tint end
  if not Destinations.SV.pins.pinTextureVampAltar.textcolor then Destinations.SV.pins.pinTextureVampAltar.textcolor = Destinations.defaults.pins.pinTextureVampAltar.textcolor end

  if not Destinations.SV.pins.pinTextureCollectible.maxDistance then Destinations.SV.pins.pinTextureCollectible.maxDistance = Destinations.defaults.pins.pinTextureCollectible.maxDistance end
  if not Destinations.SV.pins.pinTextureCollectible.type then Destinations.SV.pins.pinTextureCollectible.type = Destinations.defaults.pins.pinTextureCollectible.type end
  if not Destinations.SV.pins.pinTextureCollectible.level then Destinations.SV.pins.pinTextureCollectible.level = Destinations.defaults.pins.pinTextureCollectible.level end
  if not Destinations.SV.pins.pinTextureCollectible.size then Destinations.SV.pins.pinTextureCollectible.size = Destinations.defaults.pins.pinTextureCollectible.size end
  if not Destinations.SV.pins.pinTextureCollectible.tint then Destinations.SV.pins.pinTextureCollectible.tint = Destinations.defaults.pins.pinTextureCollectible.tint end
  if not Destinations.SV.pins.pinTextureCollectible.textcolor then Destinations.SV.pins.pinTextureCollectible.textcolor = Destinations.defaults.pins.pinTextureCollectible.textcolor end
  if not Destinations.SV.pins.pinTextureCollectible.textcolortitle then Destinations.SV.pins.pinTextureCollectible.textcolortitle = Destinations.defaults.pins.pinTextureCollectible.textcolortitle end

  if not Destinations.SV.pins.pinTextureCollectibleDone.maxDistance then Destinations.SV.pins.pinTextureCollectibleDone.maxDistance = Destinations.defaults.pins.pinTextureCollectibleDone.maxDistance end
  if not Destinations.SV.pins.pinTextureCollectibleDone.type then Destinations.SV.pins.pinTextureCollectibleDone.type = Destinations.defaults.pins.pinTextureCollectibleDone.type end
  if not Destinations.SV.pins.pinTextureCollectibleDone.level then Destinations.SV.pins.pinTextureCollectibleDone.level = Destinations.defaults.pins.pinTextureCollectibleDone.level end
  if not Destinations.SV.pins.pinTextureCollectibleDone.size then Destinations.SV.pins.pinTextureCollectibleDone.size = Destinations.defaults.pins.pinTextureCollectibleDone.size end
  if not Destinations.SV.pins.pinTextureCollectibleDone.tint then Destinations.SV.pins.pinTextureCollectibleDone.tint = Destinations.defaults.pins.pinTextureCollectibleDone.tint end
  if not Destinations.SV.pins.pinTextureCollectibleDone.textcolor then Destinations.SV.pins.pinTextureCollectibleDone.textcolor = Destinations.defaults.pins.pinTextureCollectibleDone.textcolor end
  if not Destinations.SV.pins.pinTextureCollectibleDone.textcolortitle then Destinations.SV.pins.pinTextureCollectibleDone.textcolortitle = Destinations.defaults.pins.pinTextureCollectibleDone.textcolortitle end

  if not Destinations.SV.pins.pinTextureFish.maxDistance then Destinations.SV.pins.pinTextureFish.maxDistance = Destinations.defaults.pins.pinTextureFish.maxDistance end
  if not Destinations.SV.pins.pinTextureFish.type then Destinations.SV.pins.pinTextureFish.type = Destinations.defaults.pins.pinTextureFish.type end
  if not Destinations.SV.pins.pinTextureFish.level then Destinations.SV.pins.pinTextureFish.level = Destinations.defaults.pins.pinTextureFish.level end
  if not Destinations.SV.pins.pinTextureFish.size then Destinations.SV.pins.pinTextureFish.size = Destinations.defaults.pins.pinTextureFish.size end
  if not Destinations.SV.pins.pinTextureFish.tint then Destinations.SV.pins.pinTextureFish.tint = Destinations.defaults.pins.pinTextureFish.tint end
  if not Destinations.SV.pins.pinTextureFish.textcolor then Destinations.SV.pins.pinTextureFish.textcolor = Destinations.defaults.pins.pinTextureFish.textcolor end
  if not Destinations.SV.pins.pinTextureFish.textcolortitle then Destinations.SV.pins.pinTextureFish.textcolortitle = Destinations.defaults.pins.pinTextureFish.textcolortitle end
  if not Destinations.SV.pins.pinTextureFish.textcolorBait then Destinations.SV.pins.pinTextureFish.textcolorBait = Destinations.defaults.pins.pinTextureFish.textcolorBait end
  if not Destinations.SV.pins.pinTextureFish.textcolorWater then Destinations.SV.pins.pinTextureFish.textcolorWater = Destinations.defaults.pins.pinTextureFish.textcolorWater end

  if not Destinations.SV.pins.pinTextureFishDone.maxDistance then Destinations.SV.pins.pinTextureFishDone.maxDistance = Destinations.defaults.pins.pinTextureFishDone.maxDistance end
  if not Destinations.SV.pins.pinTextureFishDone.type then Destinations.SV.pins.pinTextureFishDone.type = Destinations.defaults.pins.pinTextureFishDone.type end
  if not Destinations.SV.pins.pinTextureFishDone.level then Destinations.SV.pins.pinTextureFishDone.level = Destinations.defaults.pins.pinTextureFishDone.level end
  if not Destinations.SV.pins.pinTextureFishDone.size then Destinations.SV.pins.pinTextureFishDone.size = Destinations.defaults.pins.pinTextureFishDone.size end
  if not Destinations.SV.pins.pinTextureFishDone.tint then Destinations.SV.pins.pinTextureFishDone.tint = Destinations.defaults.pins.pinTextureFishDone.tint end
  if not Destinations.SV.pins.pinTextureFishDone.textcolor then Destinations.SV.pins.pinTextureFishDone.textcolor = Destinations.defaults.pins.pinTextureFishDone.textcolor end
  if not Destinations.SV.pins.pinTextureFishDone.textcolortitle then Destinations.SV.pins.pinTextureFishDone.textcolortitle = Destinations.defaults.pins.pinTextureFishDone.textcolortitle end
  if not Destinations.SV.pins.pinTextureFishDone.textcolorBait then Destinations.SV.pins.pinTextureFishDone.textcolorBait = Destinations.defaults.pins.pinTextureFishDone.textcolorBait end
  if not Destinations.SV.pins.pinTextureFishDone.textcolorWater then Destinations.SV.pins.pinTextureFishDone.textcolorWater = Destinations.defaults.pins.pinTextureFishDone.textcolorWater end

  if Destinations.SV.settings.ShowDungeonBossesInZones == nil then Destinations.SV.settings.ShowDungeonBossesInZones = Destinations.defaults.settings.ShowDungeonBossesInZones end
  if Destinations.SV.settings.ShowDungeonBossesOnTop == nil then Destinations.SV.settings.ShowDungeonBossesOnTop = Destinations.defaults.settings.ShowDungeonBossesOnTop end

  if Destinations.SV.settings.ShowCadwellsAlmanac == nil then Destinations.SV.settings.ShowCadwellsAlmanac = Destinations.defaults.settings.ShowCadwellsAlmanac end
  if Destinations.SV.settings.ShowCadwellsAlmanacOnly == nil then Destinations.SV.settings.ShowCadwellsAlmanacOnly = Destinations.defaults.settings.ShowCadwellsAlmanacOnly end

end

local function OnAchievementUpdate(eventCode, achievementId)
  if achievementId then

    if achievementId >= 749 and achievementId <= 754 then return end

    LMP:RefreshPins(Destinations.PIN_TYPES.MAIQ)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.MAIQ)

    LMP:RefreshPins(Destinations.PIN_TYPES.LB_GTTP_CP)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.LB_GTTP_CP)

    LMP:RefreshPins(Destinations.PIN_TYPES.PEACEMAKER)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.PEACEMAKER)

    LMP:RefreshPins(Destinations.PIN_TYPES.NOSEDIVER)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.NOSEDIVER)

    LMP:RefreshPins(Destinations.PIN_TYPES.EARTHLYPOS)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.EARTHLYPOS)

    LMP:RefreshPins(Destinations.PIN_TYPES.ON_ME)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.ON_ME)

    LMP:RefreshPins(Destinations.PIN_TYPES.BRAWL)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.BRAWL)

    LMP:RefreshPins(Destinations.PIN_TYPES.PATRON)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.PATRON)

    LMP:RefreshPins(Destinations.PIN_TYPES.WROTHGAR_JUMPER)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.WROTHGAR_JUMPER)

    LMP:RefreshPins(Destinations.PIN_TYPES.RELIC_HUNTER)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.RELIC_HUNTER)

    LMP:RefreshPins(Destinations.PIN_TYPES.CHAMPION)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.CHAMPION)

    LMP:RefreshPins(Destinations.PIN_TYPES.MAIQ_DONE)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.MAIQ_DONE)

    LMP:RefreshPins(Destinations.PIN_TYPES.LB_GTTP_CP_DONE)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.LB_GTTP_CP_DONE)

    LMP:RefreshPins(Destinations.PIN_TYPES.PEACEMAKER_DONE)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.PEACEMAKER_DONE)

    LMP:RefreshPins(Destinations.PIN_TYPES.NOSEDIVER_DONE)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.NOSEDIVER_DONE)

    LMP:RefreshPins(Destinations.PIN_TYPES.EARTHLYPOS_DONE)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.EARTHLYPOS_DONE)

    LMP:RefreshPins(Destinations.PIN_TYPES.ON_ME_DONE)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.ON_ME_DONE)

    LMP:RefreshPins(Destinations.PIN_TYPES.BRAWL_DONE)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.BRAWL_DONE)

    LMP:RefreshPins(Destinations.PIN_TYPES.PATRON_DONE)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.PATRON_DONE)

    LMP:RefreshPins(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE)

    LMP:RefreshPins(Destinations.PIN_TYPES.RELIC_HUNTER_DONE)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.RELIC_HUNTER_DONE)

    LMP:RefreshPins(Destinations.PIN_TYPES.CHAMPION_DONE)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.CHAMPION_DONE)

    LMP:RefreshPins(Destinations.PIN_TYPES.FISHING)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.FISHING)

    LMP:RefreshPins(Destinations.PIN_TYPES.FISHINGDONE)
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES.FISHINGDONE)

  end
end

--[[TODO What did this do in the past?

Not in version 27
]]--
local function UpdateInventoryContent()
  local MapMiscPOIs = false
  if Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER] or Destinations.CSSV.filters[Destinations.PIN_TYPES.CUTPURSE] then
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
    maxDistance = Destinations.SV.pins.pinTextureUnknown.maxDistance,
    level = Destinations.SV.pins.pinTextureUnknown.level,
    texture = GetPinTextureUnknown,
    size = Destinations.SV.pins.pinTextureUnknown.size,
    tint = DEST_PIN_TINT_UNKNOWN,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureUnknown.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.UNKNOWN,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_other = {
    maxDistance = Destinations.SV.pins.pinTextureOther.maxDistance,
    level = Destinations.SV.pins.pinTextureOther.level,
    texture = Destinations.pinTextures.paths.Other[Destinations.SV.pins.pinTextureOther.type],
    size = Destinations.SV.pins.pinTextureOther.size,
    tint = DEST_PIN_TINT_OTHER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureOther.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.LB_GTTP_CP,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_other_Done = {
    maxDistance = Destinations.SV.pins.pinTextureOtherDone.maxDistance,
    level = Destinations.SV.pins.pinTextureOtherDone.level,
    texture = Destinations.pinTextures.paths.OtherDone[Destinations.SV.pins.pinTextureOtherDone.type],
    size = Destinations.SV.pins.pinTextureOtherDone.size,
    tint = DEST_PIN_TINT_OTHER_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureOtherDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.LB_GTTP_CP_DONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Maiq = {
    maxDistance = Destinations.SV.pins.pinTextureMaiq.maxDistance,
    level = Destinations.SV.pins.pinTextureMaiq.level,
    texture = Destinations.pinTextures.paths.Maiq[Destinations.SV.pins.pinTextureMaiq.type],
    size = Destinations.SV.pins.pinTextureMaiq.size,
    tint = DEST_PIN_TINT_OTHER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureMaiq.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.MAIQ,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Maiq_Done = {
    maxDistance = Destinations.SV.pins.pinTextureMaiqDone.maxDistance,
    level = Destinations.SV.pins.pinTextureMaiqDone.level,
    texture = Destinations.pinTextures.paths.MaiqDone[Destinations.SV.pins.pinTextureMaiqDone.type],
    size = Destinations.SV.pins.pinTextureMaiqDone.size,
    tint = DEST_PIN_TINT_OTHER_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureMaiqDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.MAIQ_DONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Peacemaker = {
    maxDistance = Destinations.SV.pins.pinTexturePeacemaker.maxDistance,
    level = Destinations.SV.pins.pinTexturePeacemaker.level,
    texture = Destinations.pinTextures.paths.Peacemaker[Destinations.SV.pins.pinTexturePeacemaker.type],
    size = Destinations.SV.pins.pinTexturePeacemaker.size,
    tint = DEST_PIN_TINT_OTHER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTexturePeacemaker.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.PEACEMAKER,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Peacemaker_Done = {
    maxDistance = Destinations.SV.pins.pinTexturePeacemakerDone.maxDistance,
    level = Destinations.SV.pins.pinTexturePeacemakerDone.level,
    texture = Destinations.pinTextures.paths.PeacemakerDone[Destinations.SV.pins.pinTexturePeacemakerDone.type],
    size = Destinations.SV.pins.pinTexturePeacemakerDone.size,
    tint = DEST_PIN_TINT_OTHER_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTexturePeacemakerDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.PEACEMAKER_DONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Nosediver = {
    maxDistance = Destinations.SV.pins.pinTextureNosediver.maxDistance,
    level = Destinations.SV.pins.pinTextureNosediver.level,
    texture = Destinations.pinTextures.paths.Nosediver[Destinations.SV.pins.pinTextureNosediver.type],
    size = Destinations.SV.pins.pinTextureNosediver.size,
    tint = DEST_PIN_TINT_OTHER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureNosediver.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.NOSEDIVER,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Nosediver_Done = {
    maxDistance = Destinations.SV.pins.pinTextureNosediverDone.maxDistance,
    level = Destinations.SV.pins.pinTextureNosediverDone.level,
    texture = Destinations.pinTextures.paths.NosediverDone[Destinations.SV.pins.pinTextureNosediverDone.type],
    size = Destinations.SV.pins.pinTextureNosediverDone.size,
    tint = DEST_PIN_TINT_OTHER_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureNosediverDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.NOSEDIVER_DONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_EarthlyPos = {
    maxDistance = Destinations.SV.pins.pinTextureEarthlyPos.maxDistance,
    level = Destinations.SV.pins.pinTextureEarthlyPos.level,
    texture = Destinations.pinTextures.paths.Earthlypos[Destinations.SV.pins.pinTextureEarthlyPos.type],
    size = Destinations.SV.pins.pinTextureEarthlyPos.size,
    tint = DEST_PIN_TINT_OTHER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureEarthlyPos.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.EARTHLYPOS,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_EarthlyPos_Done = {
    maxDistance = Destinations.SV.pins.pinTextureEarthlyPosDone.maxDistance,
    level = Destinations.SV.pins.pinTextureEarthlyPosDone.level,
    texture = Destinations.pinTextures.paths.EarthlyposDone[Destinations.SV.pins.pinTextureEarthlyPosDone.type],
    size = Destinations.SV.pins.pinTextureEarthlyPosDone.size,
    tint = DEST_PIN_TINT_OTHER_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureEarthlyPosDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.EARTHLYPOS_DONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_OnMe = {
    maxDistance = Destinations.SV.pins.pinTextureOnMe.maxDistance,
    level = Destinations.SV.pins.pinTextureOnMe.level,
    texture = Destinations.pinTextures.paths.OnMe[Destinations.SV.pins.pinTextureOnMe.type],
    size = Destinations.SV.pins.pinTextureOnMe.size,
    tint = DEST_PIN_TINT_OTHER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureOnMe.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.ON_ME,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_OnMe_Done = {
    maxDistance = Destinations.SV.pins.pinTextureOnMeDone.maxDistance,
    level = Destinations.SV.pins.pinTextureOnMeDone.level,
    texture = Destinations.pinTextures.paths.OnMeDone[Destinations.SV.pins.pinTextureOnMeDone.type],
    size = Destinations.SV.pins.pinTextureOnMeDone.size,
    tint = DEST_PIN_TINT_OTHER_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureOnMeDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.ON_ME_DONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Brawl = {
    maxDistance = Destinations.SV.pins.pinTextureBrawl.maxDistance,
    level = Destinations.SV.pins.pinTextureBrawl.level,
    texture = Destinations.pinTextures.paths.Brawl[Destinations.SV.pins.pinTextureBrawl.type],
    size = Destinations.SV.pins.pinTextureBrawl.size,
    tint = DEST_PIN_TINT_OTHER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureBrawl.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.BRAWL,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Brawl_Done = {
    level = Destinations.SV.pins.pinTextureBrawlDone.level,
    texture = Destinations.pinTextures.paths.BrawlDone[Destinations.SV.pins.pinTextureBrawlDone.type],
    size = Destinations.SV.pins.pinTextureBrawlDone.size,
    tint = DEST_PIN_TINT_OTHER_DONE,
    maxDistance = Destinations.SV.pins.pinTextureBrawlDone.maxDistance,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureBrawlDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.BRAWL_DONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Patron = {
    maxDistance = Destinations.SV.pins.pinTexturePatron.maxDistance,
    level = Destinations.SV.pins.pinTexturePatron.level,
    texture = Destinations.pinTextures.paths.Patron[Destinations.SV.pins.pinTexturePatron.type],
    size = Destinations.SV.pins.pinTexturePatron.size,
    tint = DEST_PIN_TINT_OTHER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTexturePatron.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.PATRON,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Patron_Done = {
    maxDistance = Destinations.SV.pins.pinTexturePatronDone.maxDistance,
    level = Destinations.SV.pins.pinTexturePatronDone.level,
    texture = Destinations.pinTextures.paths.PatronDone[Destinations.SV.pins.pinTexturePatronDone.type],
    size = Destinations.SV.pins.pinTexturePatronDone.size,
    tint = DEST_PIN_TINT_OTHER_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTexturePatronDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.PATRON_DONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_WrothgarJumper = {
    maxDistance = Destinations.SV.pins.pinTextureWrothgarJumper.maxDistance,
    level = Destinations.SV.pins.pinTextureWrothgarJumper.level,
    texture = Destinations.pinTextures.paths.WrothgarJumper[Destinations.SV.pins.pinTextureWrothgarJumper.type],
    size = Destinations.SV.pins.pinTextureWrothgarJumper.size,
    tint = DEST_PIN_TINT_OTHER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureWrothgarJumper.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.WROTHGAR_JUMPER,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_WrothgarJumper_Done = {
    maxDistance = Destinations.SV.pins.pinTextureWrothgarJumperDone.maxDistance,
    level = Destinations.SV.pins.pinTextureWrothgarJumperDone.level,
    texture = Destinations.pinTextures.paths.WrothgarJumperDone[Destinations.SV.pins.pinTextureWrothgarJumperDone.type],
    size = Destinations.SV.pins.pinTextureWrothgarJumperDone.size,
    tint = DEST_PIN_TINT_OTHER_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureWrothgarJumperDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_RelicHunter = {
    maxDistance = Destinations.SV.pins.pinTextureRelicHunter.maxDistance,
    level = Destinations.SV.pins.pinTextureRelicHunter.level,
    texture = Destinations.pinTextures.paths.RelicHunter[Destinations.SV.pins.pinTextureRelicHunter.type],
    size = Destinations.SV.pins.pinTextureRelicHunter.size,
    tint = DEST_PIN_TINT_OTHER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureRelicHunter.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.RELIC_HUNTER,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_RelicHunter_Done = {
    maxDistance = Destinations.SV.pins.pinTextureRelicHunterDone.maxDistance,
    level = Destinations.SV.pins.pinTextureRelicHunterDone.level,
    texture = Destinations.pinTextures.paths.RelicHunterDone[Destinations.SV.pins.pinTextureRelicHunterDone.type],
    size = Destinations.SV.pins.pinTextureRelicHunterDone.size,
    tint = DEST_PIN_TINT_OTHER_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureRelicHunterDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.RELIC_HUNTER_DONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Champion = {
    maxDistance = Destinations.SV.pins.pinTextureChampion.maxDistance,
    level = Destinations.SV.pins.pinTextureChampion.level,
    texture = Destinations.pinTextures.paths.Champion[Destinations.SV.pins.pinTextureChampion.type],
    size = Destinations.SV.pins.pinTextureChampion.size,
    tint = DEST_PIN_TINT_OTHER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureChampion.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.CHAMPION,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Champion_Done = {
    maxDistance = Destinations.SV.pins.pinTextureChampionDone.maxDistance,
    level = Destinations.SV.pins.pinTextureChampionDone.level,
    texture = Destinations.pinTextures.paths.ChampionDone[Destinations.SV.pins.pinTextureChampionDone.type],
    size = Destinations.SV.pins.pinTextureChampionDone.size,
    tint = DEST_PIN_TINT_OTHER_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureChampionDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.CHAMPION_DONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Breaking = {
    maxDistance = Destinations.SV.pins.pinTextureBreaking.maxDistance,
    level = Destinations.SV.pins.pinTextureBreaking.level,
    texture = Destinations.pinTextures.paths.Breaking[Destinations.SV.pins.pinTextureBreaking.type],
    size = Destinations.SV.pins.pinTextureBreaking.size,
    tint = DEST_PIN_TINT_OTHER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureBreaking.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.BREAKING,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Breaking_Done = {
    maxDistance = Destinations.SV.pins.pinTextureBreakingDone.maxDistance,
    level = Destinations.SV.pins.pinTextureBreakingDone.level,
    texture = Destinations.pinTextures.paths.BreakingDone[Destinations.SV.pins.pinTextureBreakingDone.type],
    size = Destinations.SV.pins.pinTextureBreakingDone.size,
    tint = DEST_PIN_TINT_OTHER_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureBreakingDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.BREAKING_DONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Cutpurse = {
    maxDistance = Destinations.SV.pins.pinTextureCutpurse.maxDistance,
    level = Destinations.SV.pins.pinTextureCutpurse.level,
    texture = Destinations.pinTextures.paths.Cutpurse[Destinations.SV.pins.pinTextureCutpurse.type],
    size = Destinations.SV.pins.pinTextureCutpurse.size,
    tint = DEST_PIN_TINT_OTHER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureCutpurse.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.CUTPURSE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Cutpurse_Done = {
    maxDistance = Destinations.SV.pins.pinTextureCutpurseDone.maxDistance,
    level = Destinations.SV.pins.pinTextureCutpurseDone.level,
    texture = Destinations.pinTextures.paths.CutpurseDone[Destinations.SV.pins.pinTextureCutpurseDone.type],
    size = Destinations.SV.pins.pinTextureCutpurseDone.size,
    tint = DEST_PIN_TINT_OTHER_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureCutpurseDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.CUTPURSE_DONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Collectible = {
    maxDistance = Destinations.SV.pins.pinTextureCollectible.maxDistance,
    level = Destinations.SV.pins.pinTextureCollectible.level,
    texture = Destinations.pinTextures.paths.collectible[Destinations.SV.pins.pinTextureCollectible.type],
    size = Destinations.SV.pins.pinTextureCollectible.size,
    tint = DEST_PIN_TINT_COLLECTIBLE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureCollectible.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.COLLECTIBLES,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_CollectibleDone = {
    maxDistance = Destinations.SV.pins.pinTextureCollectibleDone.maxDistance,
    level = Destinations.SV.pins.pinTextureCollectibleDone.level,
    texture = Destinations.pinTextures.paths.collectibledone[Destinations.SV.pins.pinTextureCollectibleDone.type],
    size = Destinations.SV.pins.pinTextureCollectibleDone.size,
    tint = DEST_PIN_TINT_COLLECTIBLE_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureCollectibleDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.COLLECTIBLESDONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Fish = {
    maxDistance = Destinations.SV.pins.pinTextureFish.maxDistance,
    level = Destinations.SV.pins.pinTextureFish.level,
    texture = Destinations.pinTextures.paths.fish[Destinations.SV.pins.pinTextureFish.type],
    size = Destinations.SV.pins.pinTextureFish.size,
    tint = DEST_PIN_TINT_FISH,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureFish.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.FISHING,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_FishDone = {
    maxDistance = Destinations.SV.pins.pinTextureFishDone.maxDistance,
    level = Destinations.SV.pins.pinTextureFishDone.level,
    texture = Destinations.pinTextures.paths.fishdone[Destinations.SV.pins.pinTextureFishDone.type],
    size = Destinations.SV.pins.pinTextureFishDone.size,
    tint = DEST_PIN_TINT_FISH_DONE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureFishDone.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.FISHINGDONE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Ayleid = {
    maxDistance = Destinations.SV.pins.pinTextureAyleid.maxDistance,
    level = Destinations.SV.pins.pinTextureAyleid.level,
    texture = Destinations.pinTextures.paths.Ayleid[Destinations.SV.pins.pinTextureAyleid.type],
    size = Destinations.SV.pins.pinTextureAyleid.size,
    tint = DEST_PIN_TINT_AYLEID,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureAyleid.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.AYLEID,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Deadlands = {
    maxDistance = Destinations.SV.pins.pinTextureDeadlands.maxDistance,
    level = Destinations.SV.pins.pinTextureDeadlands.level,
    texture = Destinations.pinTextures.paths.Deadlands[Destinations.SV.pins.pinTextureDeadlands.type],
    size = Destinations.SV.pins.pinTextureDeadlands.size,
    tint = DEST_PIN_TINT_DEADLANDS,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureDeadlands.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.DEADLANDS,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_HighIsle = {
    maxDistance = Destinations.SV.pins.pinTextureHighIsle.maxDistance,
    level = Destinations.SV.pins.pinTextureHighIsle.level,
    texture = Destinations.pinTextures.paths.HighIsle[Destinations.SV.pins.pinTextureHighIsle.type],
    size = Destinations.SV.pins.pinTextureHighIsle.size,
    tint = DEST_PIN_TINT_HIGHISLE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureHighIsle.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.HIGHISLE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_Dwemer = {
    maxDistance = Destinations.SV.pins.pinTextureDwemer.maxDistance,
    level = Destinations.SV.pins.pinTextureDwemer.level,
    texture = Destinations.pinTextures.paths.dwemer[Destinations.SV.pins.pinTextureDwemer.type],
    size = Destinations.SV.pins.pinTextureDwemer.size,
    tint = DEST_PIN_TINT_DWEMER,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureDwemer.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.DWEMER,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_WWVamp = {
    maxDistance = Destinations.SV.pins.pinTextureWWVamp.maxDistance,
    level = Destinations.SV.pins.pinTextureWWVamp.level,
    texture = Destinations.pinTextures.paths.wwvamp[Destinations.SV.pins.pinTextureWWVamp.type],
    size = Destinations.SV.pins.pinTextureWWVamp.size,
    tint = DEST_PIN_TINT_WWVAMP,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureWWVamp.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.WWVAMP,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_VampireAltar = {
    maxDistance = Destinations.SV.pins.pinTextureVampAltar.maxDistance,
    level = Destinations.SV.pins.pinTextureVampAltar.level,
    texture = Destinations.pinTextures.paths.vampirealtar[Destinations.SV.pins.pinTextureVampAltar.type],
    size = Destinations.SV.pins.pinTextureVampAltar.size,
    tint = DEST_PIN_TINT_VAMPALTAR,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureVampAltar.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.VAMPIRE_ALTAR,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }
  local pinLayout_WereWolfShrine = {
    maxDistance = Destinations.SV.pins.pinTextureWWShrine.maxDistance,
    level = Destinations.SV.pins.pinTextureWWShrine.level,
    texture = Destinations.pinTextures.paths.werewolfshrine[Destinations.SV.pins.pinTextureWWShrine.type],
    size = Destinations.SV.pins.pinTextureWWShrine.size,
    tint = DEST_PIN_TINT_WWSHRINE,
    additionalLayout = {
      [CUSTOM_COMPASS_LAYOUT_UPDATE] = function(pin)
        pin:GetNamedChild("Background"):SetColor(unpack(Destinations.SV.pins.pinTextureWWShrine.tint))
      end,
    },
    mapPinTypeString = Destinations.PIN_TYPES.WEREWOLF_SHRINE,
    onToggleCallback = function(compassPinType, enabled)
      COMPASS_PINS:SetCompassPinEnabled(compassPinType, enabled)
      COMPASS_PINS:RefreshPins(compassPinType)
    end,
  }

  --Activate the Tooltip Creator for the pins
  local pinTooltipCreator = {
    creator = function(pin)
      local _, pinTag = pin:GetPinTypeAndTag()
      if pinTag.newFormat then

        if IsInGamepadPreferredMode() then
          INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, nil, pinTag.objectiveName,
            INFORMATION_TOOLTIP.tooltip:GetStyle("mapTitle"))

          if Destinations.SV.settings.AddEnglishOnUnknwon then
            INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, nil, pinTag.englishName,
              { fontSize = 27, fontColorField = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_3 })
          end

          if pinTag.special then
            if pinTag.multipleFormat and pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_CRAFTING and Destinations.SV.settings.ImproveCrafting then
              for lineIndex, lineData in ipairs(pinTag.special) do
                INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, nil, lineData,
                  pinTag.multipleFormat.g[lineIndex])
              end
            elseif pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_MUNDUS and Destinations.SV.settings.ImproveMundus then
              INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, nil, pinTag.special,
                { fontSize = 27, fontColorField = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_3 })
            end
          end

        else

          INFORMATION_TOOLTIP:AddLine(pinTag.objectiveName, "ZoFontGameOutline",
            unpack(Destinations.SV.pins.pinTextureUnknown.textcolor))
          INFORMATION_TOOLTIP:AddLine(pinTag.poiTypeName, "", ZO_HIGHLIGHT_TEXT:UnpackRGB())

          if Destinations.SV.settings.AddEnglishOnUnknwon then
            INFORMATION_TOOLTIP:AddLine(pinTag.englishName, "",
              unpack(Destinations.SV.pins.pinTextureUnknown.textcolorEN))
          end

          if pinTag.special then
            ZO_Tooltip_AddDivider(INFORMATION_TOOLTIP)
            if pinTag.multipleFormat and pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_CRAFTING and Destinations.SV.settings.ImproveCrafting then
              for lineIndex, lineData in ipairs(pinTag.special) do
                INFORMATION_TOOLTIP:AddLine(lineData, unpack(pinTag.multipleFormat.k[lineIndex]))
              end
            elseif pinTag.destinationsPinType == DESTINATIONS_PIN_TYPE_MUNDUS and Destinations.SV.settings.ImproveMundus then
              INFORMATION_TOOLTIP:AddLine(pinTag.special, "", ZO_HIGHLIGHT_TEXT:UnpackRGB())
            end
          end

        end
      else
        for lineIndex, lineData in ipairs(pinTag) do
          if IsInGamepadPreferredMode() then
            if pinTag[1] == lineData then
              INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, nil, zo_strformat(lineData),
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

  LMP:AddPinType(Destinations.PIN_TYPES.FAKEKNOWN, MapCallback_fakeKnown, nil, pinLayout_Faked, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.UNKNOWN, MapCallback_unknown, nil, pinLayout_unknown, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.LB_GTTP_CP, OtherpinTypeCallback, nil, pinLayout_other, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.LB_GTTP_CP_DONE, OtherpinTypeCallbackDone, nil, pinLayout_other_Done, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.MAIQ, MaiqpinTypeCallback, nil, pinLayout_Maiq, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.MAIQ_DONE, MaiqpinTypeCallbackDone, nil, pinLayout_Maiq_Done, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.PEACEMAKER, PeacemakerpinTypeCallback, nil, pinLayout_Peacemaker, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.PEACEMAKER_DONE, PeacemakerpinTypeCallbackDone, nil, pinLayout_Peacemaker_Done,
    pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.NOSEDIVER, NosediverpinTypeCallback, nil, pinLayout_Nosediver, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.NOSEDIVER_DONE, NosediverpinTypeCallbackDone, nil, pinLayout_Nosediver_Done, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.EARTHLYPOS, EarthlyPospinTypeCallback, nil, pinLayout_EarthlyPos, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.EARTHLYPOS_DONE, EarthlyPospinTypeCallbackDone, nil, pinLayout_EarthlyPos_Done,
    pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.ON_ME, OnMepinTypeCallback, nil, pinLayout_OnMe, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.ON_ME_DONE, OnMepinTypeCallbackDone, nil, pinLayout_OnMe_Done, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.BRAWL, BrawlpinTypeCallback, nil, pinLayout_Brawl, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.BRAWL_DONE, BrawlpinTypeCallbackDone, nil, pinLayout_Brawl_Done, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.PATRON, PatronpinTypeCallback, nil, pinLayout_Patron, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.PATRON_DONE, PatronpinTypeCallbackDone, nil, pinLayout_Patron_Done, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.WROTHGAR_JUMPER, WrothgarJumperpinTypeCallback, nil, pinLayout_WrothgarJumper, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE, WrothgarJumperpinTypeCallbackDone, nil, pinLayout_WrothgarJumper_Done,
    pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.RELIC_HUNTER, RelicHunterpinTypeCallback, nil, pinLayout_RelicHunter, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.RELIC_HUNTER_DONE, RelicHunterpinTypeCallbackDone, nil, pinLayout_RelicHunter_Done,
    pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.CHAMPION, ChampionpinTypeCallback, nil, pinLayout_Champion, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.CHAMPION_DONE, ChampionpinTypeCallbackDone, nil, pinLayout_Champion_Done, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.BREAKING, BreakingpinTypeCallback, nil, pinLayout_Breaking, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.BREAKING_DONE, BreakingpinTypeCallbackDone, nil, pinLayout_Breaking_Done, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.CUTPURSE, CutpursepinTypeCallback, nil, pinLayout_Cutpurse, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.CUTPURSE_DONE, CutpursepinTypeCallbackDone, nil, pinLayout_Cutpurse_Done, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.COLLECTIBLES, CollectiblepinTypeCallback, nil, pinLayout_Collectible, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.COLLECTIBLESDONE, CollectibleDonepinTypeCallback, nil, pinLayout_CollectibleDone,
    pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.FISHING, FishpinTypeCallback, nil, pinLayout_Fish, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.FISHINGDONE, FishDonepinTypeCallback, nil, pinLayout_FishDone, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.AYLEID, AyleidpinTypeCallback, nil, pinLayout_Ayleid, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.DEADLANDS, DeadlandspinTypeCallback, nil, pinLayout_Deadlands, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.HIGHISLE, HighIslepinTypeCallback, nil, pinLayout_HighIsle, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.WWVAMP, WWVamppinTypeCallback, nil, pinLayout_WWVamp, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.VAMPIRE_ALTAR, VampireAltarpinTypeCallback, nil, pinLayout_VampireAltar, pinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.WEREWOLF_SHRINE, WerewolfShrinepinTypeCallback, nil, pinLayout_WereWolfShrine, pinTooltipCreator)

  LMP:AddPinType(Destinations.PIN_TYPES.DWEMER, DwemerRuinpinTypeCallback, nil, pinLayout_Dwemer, pinTooltipCreator)

  local qolPinTooltipCreator = {
    creator = function(pin)
      local pinTag = select(2, pin:GetPinTypeAndTag())
      if IsInGamepadPreferredMode() then
        local InformationTooltip = ZO_MapLocationTooltip_Gamepad
        local baseSection = InformationTooltip.tooltip
        InformationTooltip:LayoutIconStringLine(baseSection, nil, Destinations.name, baseSection:GetStyle("mapLocationTooltipContentHeader"))
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
    [Destinations.PIN_TYPES.QOLPINS_DOCK] = {
      level = Destinations.SV.pins.pinTextureQolPin.level,
      size = Destinations.SV.pins.pinTextureQolPin.size,
      tint = DEST_PIN_TINT_QOLPIN,
      texture = "/esoui/art/icons/servicemappins/servicepin_dock.dds",
    },
    [Destinations.PIN_TYPES.QOLPINS_STABLE] = {
      level = Destinations.SV.pins.pinTextureQolPin.level,
      size = Destinations.SV.pins.pinTextureQolPin.size,
      tint = DEST_PIN_TINT_QOLPIN,
      texture = "/esoui/art/icons/servicemappins/servicepin_stable.dds",
    },
    [Destinations.PIN_TYPES.QOLPINS_PORTAL] = {
      level = Destinations.SV.pins.pinTextureQolPin.level,
      size = Destinations.SV.pins.pinTextureQolPin.size,
      tint = DEST_PIN_TINT_QOLPIN,
      texture = "/esoui/art/icons/servicemappins/servicepin_fargraveportal.dds",
    },
  }
  -- Quality Of Life Pins
  LMP:AddPinType(Destinations.PIN_TYPES.QOLPINS_DOCK, function() MapCallbackQolPins(Destinations.PIN_TYPES.QOLPINS_DOCK) end, nil, qolPinLayout[Destinations.PIN_TYPES.QOLPINS_DOCK], qolPinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.QOLPINS_STABLE, function() MapCallbackQolPins(Destinations.PIN_TYPES.QOLPINS_STABLE) end, nil, qolPinLayout[Destinations.PIN_TYPES.QOLPINS_STABLE], qolPinTooltipCreator)
  LMP:AddPinType(Destinations.PIN_TYPES.QOLPINS_PORTAL, function() MapCallbackQolPins(Destinations.PIN_TYPES.QOLPINS_PORTAL) end, nil, qolPinLayout[Destinations.PIN_TYPES.QOLPINS_PORTAL], qolPinTooltipCreator)

  --Add filter check boxes
  if Destinations.CSSV.settings.MapFiltersPOIs then
    LMP:AddPinFilter(Destinations.PIN_TYPES.UNKNOWN,
      Destinations.defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_UNKNOWN)), nil,
      Destinations.CSSV.filters)
  end

  if Destinations.CSSV.settings.MapFiltersAchievements then
    LMP:AddPinFilter(Destinations.PIN_TYPES.LB_GTTP_CP,
      Destinations.defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_OTHER)), nil,
      Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.LB_GTTP_CP_DONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_OTHER_DONE)), nil,
      Destinations.CSSV.filters)

    LMP:AddPinFilter(Destinations.PIN_TYPES.MAIQ, Destinations.defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_MAIQ)),
      nil, Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.MAIQ_DONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_MAIQ_DONE)), nil,
      Destinations.CSSV.filters)

    LMP:AddPinFilter(Destinations.PIN_TYPES.PEACEMAKER,
      Destinations.defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_PEACEMAKER)), nil,
      Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.PEACEMAKER_DONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_PEACEMAKER_DONE)), nil,
      Destinations.CSSV.filters)

    LMP:AddPinFilter(Destinations.PIN_TYPES.NOSEDIVER,
      Destinations.defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_NOSEDIVER)), nil,
      Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.NOSEDIVER_DONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_NOSEDIVER_DONE)), nil,
      Destinations.CSSV.filters)

    LMP:AddPinFilter(Destinations.PIN_TYPES.EARTHLYPOS,
      Destinations.defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_EARTHLYPOS)), nil,
      Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.EARTHLYPOS_DONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_EARTHLYPOS_DONE)), nil,
      Destinations.CSSV.filters)

    LMP:AddPinFilter(Destinations.PIN_TYPES.ON_ME, Destinations.defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_ON_ME)),
      nil, Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.ON_ME_DONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_ON_ME_DONE)), nil,
      Destinations.CSSV.filters)

    LMP:AddPinFilter(Destinations.PIN_TYPES.BRAWL, Destinations.defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_BRAWL)),
      nil, Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.BRAWL_DONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_BRAWL_DONE)), nil,
      Destinations.CSSV.filters)

    LMP:AddPinFilter(Destinations.PIN_TYPES.PATRON, Destinations.defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_PATRON)),
      nil, Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.PATRON_DONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_PATRON_DONE)), nil,
      Destinations.CSSV.filters)

    LMP:AddPinFilter(Destinations.PIN_TYPES.WROTHGAR_JUMPER,
      Destinations.defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_WROTHGAR_JUMPER)), nil,
      Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_WROTHGAR_JUMPER_DONE)), nil,
      Destinations.CSSV.filters)

    LMP:AddPinFilter(Destinations.PIN_TYPES.RELIC_HUNTER,
      Destinations.defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_RELIC_HUNTER)), nil,
      Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.RELIC_HUNTER_DONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_RELIC_HUNTER_DONE)), nil,
      Destinations.CSSV.filters)

    LMP:AddPinFilter(Destinations.PIN_TYPES.CHAMPION,
      Destinations.defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_CHAMPION)), nil,
      Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.CHAMPION_DONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_CHAMPION_DONE)), nil,
      Destinations.CSSV.filters)

    LMP:AddPinFilter(Destinations.PIN_TYPES.BREAKING,
      Destinations.defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_BREAKING_ENTERING)), nil,
      Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.BREAKING_DONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_BREAKING_ENTERING_DONE)), nil,
      Destinations.CSSV.filters)

    LMP:AddPinFilter(Destinations.PIN_TYPES.CUTPURSE,
      Destinations.defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_CUTPURSE_ABOVE)), nil,
      Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.CUTPURSE_DONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_CUTPURSE_ABOVE_DONE)), nil,
      Destinations.CSSV.filters)
  end

  if Destinations.CSSV.settings.MapFiltersCollectibles then
    LMP:AddPinFilter(Destinations.PIN_TYPES.COLLECTIBLES,
      Destinations.defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_COLLECTIBLE)), nil,
      Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.COLLECTIBLESDONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_COLLECTIBLE_DONE)), nil,
      Destinations.CSSV.filters)
  end

  if Destinations.CSSV.settings.MapFiltersFishing then
    LMP:AddPinFilter(Destinations.PIN_TYPES.FISHING,
      Destinations.defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_FISHING)), nil,
      Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.FISHINGDONE,
      Destinations.defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_FISHING_DONE)), nil,
      Destinations.CSSV.filters)
  end

  if Destinations.CSSV.settings.MapFiltersMisc then
    LMP:AddPinFilter(Destinations.PIN_TYPES.AYLEID, Destinations.defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_AYLEID)),
      nil, Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.DEADLANDS, Destinations.defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_DEADLANDS_ENTRANCE)),
      nil, Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.HIGHISLE, Destinations.defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_HIGHISLE_DRUIDICSHRINE)),
      nil, Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.WWVAMP, Destinations.defaults.miscColorCodes.mapFilterTextUndone1:Colorize(GetString(DEST_FILTER_WWVAMP)),
      nil, Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.VAMPIRE_ALTAR,
      Destinations.defaults.miscColorCodes.mapFilterTextDone2:Colorize(GetString(DEST_FILTER_VAMPIRE_ALTAR)), nil,
      Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.WEREWOLF_SHRINE,
      Destinations.defaults.miscColorCodes.mapFilterTextUndone2:Colorize(GetString(DEST_FILTER_WEREWOLF_SHRINE)), nil,
      Destinations.CSSV.filters)
    LMP:AddPinFilter(Destinations.PIN_TYPES.DWEMER, Destinations.defaults.miscColorCodes.mapFilterTextDone1:Colorize(GetString(DEST_FILTER_DWEMER)),
      nil, Destinations.CSSV.filters)
  end

  --Create the Compass Pins
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.LB_GTTP_CP, AddAchievementCompassPins, pinLayout_other, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.LB_GTTP_CP_DONE, AddAchievementCompassPins, pinLayout_other_Done, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.MAIQ, AddAchievementCompassPins, pinLayout_Maiq, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.MAIQ_DONE, AddAchievementCompassPins, pinLayout_Maiq_Done, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.PEACEMAKER, AddAchievementCompassPins, pinLayout_Peacemaker, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.PEACEMAKER_DONE, AddAchievementCompassPins, pinLayout_Peacemaker_Done, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.NOSEDIVER, AddAchievementCompassPins, pinLayout_Nosediver, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.NOSEDIVER_DONE, AddAchievementCompassPins, pinLayout_Nosediver_Done, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.EARTHLYPOS, AddAchievementCompassPins, pinLayout_EarthlyPos, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.EARTHLYPOS_DONE, AddAchievementCompassPins, pinLayout_EarthlyPos_Done, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.ON_ME, AddAchievementCompassPins, pinLayout_OnMe, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.ON_ME_DONE, AddAchievementCompassPins, pinLayout_OnMe_Done, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.BRAWL, AddAchievementCompassPins, pinLayout_Brawl, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.BRAWL_DONE, AddAchievementCompassPins, pinLayout_Brawl_Done, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.PATRON, AddAchievementCompassPins, pinLayout_Patron, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.PATRON_DONE, AddAchievementCompassPins, pinLayout_Patron_Done, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.WROTHGAR_JUMPER, AddAchievementCompassPins, pinLayout_WrothgarJumper, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE, AddAchievementCompassPins, pinLayout_WrothgarJumper_Done, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.RELIC_HUNTER, AddAchievementCompassPins, pinLayout_RelicHunter, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.RELIC_HUNTER_DONE, AddAchievementCompassPins, pinLayout_RelicHunter_Done, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.CHAMPION, AddAchievementCompassPins, pinLayout_Champion, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.CHAMPION_DONE, AddAchievementCompassPins, pinLayout_Champion_Done, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.BREAKING, AddAchievementCompassPins, pinLayout_Breaking, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.BREAKING_DONE, AddAchievementCompassPins, pinLayout_Breaking_Done, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.CUTPURSE, AddAchievementCompassPins, pinLayout_Cutpurse, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.CUTPURSE_DONE, AddAchievementCompassPins, pinLayout_Cutpurse_Done, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.COLLECTIBLES, CollectibleFishCompassPins, pinLayout_Collectible, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.COLLECTIBLESDONE, CollectibleFishCompassPins, pinLayout_CollectibleDone, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.FISHING, CollectibleFishCompassPins, pinLayout_Fish, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.FISHINGDONE, CollectibleFishCompassPins, pinLayout_FishDone, Destinations.CSSV.filters)

  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.AYLEID, AddMiscCompassPins, pinLayout_Ayleid, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.DEADLANDS, AddMiscCompassPins, pinLayout_Deadlands, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.HIGHISLE, AddMiscCompassPins, pinLayout_HighIsle, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.WWVAMP, AddMiscCompassPins, pinLayout_WWVamp, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.VAMPIRE_ALTAR, AddMiscCompassPins, pinLayout_VampireAltar, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.WEREWOLF_SHRINE, AddMiscCompassPins, pinLayout_WereWolfShrine, Destinations.CSSV.filters)
  COMPASS_PINS:AddCustomPin(Destinations.PIN_TYPES.DWEMER, AddMiscCompassPins, pinLayout_Dwemer, Destinations.CSSV.filters)

end

-- Points of interest ---------------------------------------------------------
local function HookPoiTooltips()

  local function AddEnglishName(pin)

    if Destinations.SV.settings.AddEnglishOnUnknwon then
      local zoneId = GetZoneId(pin:GetPOIZoneIndex())
      local poiIndex = pin:GetPOIIndex()

      local mapData = POIsStore[zoneId]

      if mapData and mapData[poiIndex] then
        local englishName = mapData[poiIndex].n
        if englishName then
          local localizedName = ZO_WorldMapMouseoverName:GetText()
          ZO_WorldMapMouseoverName:SetText(zo_strformat("<<1>>\n<<2>>", localizedName,
            DEST_PIN_TEXT_COLOR_ENGLISH_POI:Colorize(englishName)))
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
    if englishKeepName and Destinations.SV.settings.AddNewLineOnKeeps then
      englishLabel = self.linePool:AcquireObject()
      englishLabel:SetHidden(false)
      englishLabel:SetText(DEST_PIN_TEXT_COLOR_ENGLISH_KEEP:Colorize(englishKeepName))
      englishLabel:SetAnchor(TOPLEFT, nameLabel, BOTTOMLEFT, 0, 3)
      lineHeight = englishLabel:GetHeight()
      if Destinations.SV.HideAllianceOnKeeps and allianceLabel then
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
      nameLabel:SetText(zo_strformat("<<1>> (<<2>>)", keepName, DEST_PIN_TEXT_COLOR_ENGLISH_KEEP:Colorize(englishKeepName)))
      local width = nameLabel:GetTextWidth() + 16
      if width > self.width then
        self.width = width
      end
    end
    if Destinations.SV.settings.HideAllianceOnKeeps and allianceLabel and not englishLabel then
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
    if Destinations.SV.settings.AddEnglishOnKeeps then
      ModifyKeepTooltip(self, keepId)
    end
  end

  local RefreshKeep = ZO_KeepTooltip.RefreshKeepInfo
  ZO_KeepTooltip.RefreshKeepInfo = function(self, ...)
    RefreshKeep(self, ...)  --original function
    if self.keepId and self.battlegroundContext and self.historyPercent and Destinations.SV.settings.AddEnglishOnKeeps then
      ModifyKeepTooltip(self, self.keepId)
    end
  end

end

local function UpdateMapFilters()
  for pin, pinname in pairs(Destinations.PIN_TYPES) do
    pin = "Destinations.PIN_TYPES." .. pin
    if LMP:IsEnabled(pinname) and Destinations.CSSV.filters[pinname] then
      LMP:RefreshPins(pinname)
      if Destinations.CSSV.filters[Destinations.PIN_TYPES.ACHIEVEMENTS_COMPASS] then
        COMPASS_PINS:RefreshPins(pinname)
      end
    end
    if string.find(pin, "UNKNOWN") then
      Destinations:TogglePins(pinname, LMP:IsEnabled(Destinations.PIN_TYPES.UNKNOWN))
    end
  end
end

local function UpdateCompassFilters()
  if not Destinations or not Destinations.CSSV or not Destinations.CSSV.filters then return end

  for _, pinName in pairs(Destinations.PIN_TYPES) do
    local enabled = Destinations.CSSV.filters[pinName]
    if enabled then
      COMPASS_PINS:RefreshPins(pinName)
    end
  end
end

local function ShowLanguageWarning()
  EVENT_MANAGER:UnregisterForEvent(Destinations.name, EVENT_PLAYER_ACTIVATED)
  if Destinations.client_lang == "it" then
    CHAT_ROUTER:AddSystemMessage("Destinations non è localizzato correttamente dalla lingua italiana. Verranno utilizzati termini inglesi e non tutti i punti di interesse potrebbero essere classificati correttamente.")
  else
    CHAT_ROUTER:AddSystemMessage("Destinations is not properly localized for " .. Destinations.client_lang .. ".  English terms will be used and not all POIs may be properly classified.")
  end
end

local function DisableEnglishFunctionnalities()

  if Destinations.client_lang == "en" then
    Destinations.SV.settings.AddEnglishOnUnknwon = false
    Destinations.SV.settings.AddEnglishOnKeeps = false
  end

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

local function InitializePinTextColorDefs()
  DEST_PIN_TEXT_COLOR_OTHER:SetRGB(unpack(Destinations.SV.pins.pinTextureOther.textcolor))
  DEST_PIN_TEXT_COLOR_OTHER_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureOtherDone.textcolor))
  DEST_PIN_TEXT_COLOR_MAIQ:SetRGB(unpack(Destinations.SV.pins.pinTextureMaiq.textcolor))
  DEST_PIN_TEXT_COLOR_MAIQ_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureMaiqDone.textcolor))
  DEST_PIN_TEXT_COLOR_PEACEMAKER:SetRGB(unpack(Destinations.SV.pins.pinTexturePeacemaker.textcolor))
  DEST_PIN_TEXT_COLOR_PEACEMAKER_DONE:SetRGB(unpack(Destinations.SV.pins.pinTexturePeacemakerDone.textcolor))
  DEST_PIN_TEXT_COLOR_NOSEDIVER:SetRGB(unpack(Destinations.SV.pins.pinTextureNosediver.textcolor))
  DEST_PIN_TEXT_COLOR_NOSEDIVER_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureNosediverDone.textcolor))
  DEST_PIN_TEXT_COLOR_EARTHLYPOS:SetRGB(unpack(Destinations.SV.pins.pinTextureEarthlyPos.textcolor))
  DEST_PIN_TEXT_COLOR_EARTHLYPOS_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureEarthlyPosDone.textcolor))
  DEST_PIN_TEXT_COLOR_ONME:SetRGB(unpack(Destinations.SV.pins.pinTextureOnMe.textcolor))
  DEST_PIN_TEXT_COLOR_ONME_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureOnMeDone.textcolor))
  DEST_PIN_TEXT_COLOR_BRAWL:SetRGB(unpack(Destinations.SV.pins.pinTextureBrawl.textcolor))
  DEST_PIN_TEXT_COLOR_BRAWL_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureBrawlDone.textcolor))
  DEST_PIN_TEXT_COLOR_PATRON:SetRGB(unpack(Destinations.SV.pins.pinTexturePatron.textcolor))
  DEST_PIN_TEXT_COLOR_PATRON_DONE:SetRGB(unpack(Destinations.SV.pins.pinTexturePatronDone.textcolor))
  DEST_PIN_TEXT_COLOR_WROTHGARJUMPER:SetRGB(unpack(Destinations.SV.pins.pinTextureWrothgarJumper.textcolor))
  DEST_PIN_TEXT_COLOR_WROTHGARJUMPER_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureWrothgarJumperDone.textcolor))
  DEST_PIN_TEXT_COLOR_RELICHUNTER:SetRGB(unpack(Destinations.SV.pins.pinTextureRelicHunter.textcolor))
  DEST_PIN_TEXT_COLOR_RELICHUNTER_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureRelicHunterDone.textcolor))
  DEST_PIN_TEXT_COLOR_BREAKING:SetRGB(unpack(Destinations.SV.pins.pinTextureBreaking.textcolor))
  DEST_PIN_TEXT_COLOR_BREAKING_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureBreakingDone.textcolor))
  DEST_PIN_TEXT_COLOR_CUTPURSE:SetRGB(unpack(Destinations.SV.pins.pinTextureCutpurse.textcolor))
  DEST_PIN_TEXT_COLOR_CUTPURSE_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureCutpurseDone.textcolor))
  DEST_PIN_TEXT_COLOR_CHAMPION:SetRGB(unpack(Destinations.SV.pins.pinTextureChampion.textcolor))
  DEST_PIN_TEXT_COLOR_CHAMPION_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureChampionDone.textcolor))
  DEST_PIN_TEXT_COLOR_AYLEID:SetRGB(unpack(Destinations.SV.pins.pinTextureAyleid.textcolor))
  DEST_PIN_TEXT_COLOR_DEADLANDS:SetRGB(unpack(Destinations.SV.pins.pinTextureDeadlands.textcolor))
  DEST_PIN_TEXT_COLOR_HIGHISLE:SetRGB(unpack(Destinations.SV.pins.pinTextureHighIsle.textcolor))
  DEST_PIN_TEXT_COLOR_DWEMER:SetRGB(unpack(Destinations.SV.pins.pinTextureDwemer.textcolor))
  DEST_PIN_TEXT_COLOR_WWVAMP:SetRGB(unpack(Destinations.SV.pins.pinTextureWWVamp.textcolor))
  DEST_PIN_TEXT_COLOR_VAMPALTAR:SetRGB(unpack(Destinations.SV.pins.pinTextureVampAltar.textcolor))
  DEST_PIN_TEXT_COLOR_WWSHRINE:SetRGB(unpack(Destinations.SV.pins.pinTextureWWShrine.textcolor))
  DEST_PIN_TEXT_COLOR_COLLECTIBLE:SetRGB(unpack(Destinations.SV.pins.pinTextureCollectible.textcolor))
  DEST_PIN_TEXT_COLOR_COLLECTIBLE_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureCollectibleDone.textcolor))
  DEST_PIN_TEXT_COLOR_FISH:SetRGB(unpack(Destinations.SV.pins.pinTextureFish.textcolor))
  DEST_PIN_TEXT_COLOR_FISH_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureFishDone.textcolor))
  DEST_PIN_TEXT_COLOR_QOLPIN:SetRGB(unpack(Destinations.SV.pins.pinTextureQolPin.textcolor))
end

local function InitializePinTextColorCollectibleDefs()
  DEST_PIN_TEXT_COLORTITLE_COLLECTIBLE:SetRGB(unpack(Destinations.SV.pins.pinTextureCollectible.textcolortitle))
end

local function InitializePinTextColorFishingDefs()
  DEST_PIN_TEXT_COLORTITLE_FISH:SetRGB(unpack(Destinations.SV.pins.pinTextureFish.textcolortitle))
  DEST_PIN_TEXT_COLORTITLE_FISH_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureFishDone.textcolortitle))
  DEST_PIN_TEXT_COLORBAIT_FISH:SetRGB(unpack(Destinations.SV.pins.pinTextureFish.textcolorBait))
  DEST_PIN_TEXT_COLORBAIT_FISH_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureFishDone.textcolorBait))
  DEST_PIN_TEXT_COLORWATER_FISH:SetRGB(unpack(Destinations.SV.pins.pinTextureFish.textcolorWater))
  DEST_PIN_TEXT_COLORWATER_FISH_DONE:SetRGB(unpack(Destinations.SV.pins.pinTextureFishDone.textcolorWater))
end

local function InitializePinTintColorDefs()
  DEST_PIN_TINT_UNKNOWN:SetRGBA(unpack(Destinations.SV.pins.pinTextureUnknown.tint))
  DEST_PIN_TINT_OTHER:SetRGBA(unpack(Destinations.SV.pins.pinTextureOther.tint))
  DEST_PIN_TINT_OTHER_DONE:SetRGBA(unpack(Destinations.SV.pins.pinTextureOtherDone.tint))

  DEST_PIN_TINT_COLLECTIBLE:SetRGBA(unpack(Destinations.SV.pins.pinTextureCollectible.tint))
  DEST_PIN_TINT_COLLECTIBLE_DONE:SetRGBA(unpack(Destinations.SV.pins.pinTextureCollectibleDone.tint))
  DEST_PIN_TINT_FISH:SetRGBA(unpack(Destinations.SV.pins.pinTextureFish.tint))
  DEST_PIN_TINT_FISH_DONE:SetRGBA(unpack(Destinations.SV.pins.pinTextureFishDone.tint))
  DEST_PIN_TINT_AYLEID:SetRGBA(unpack(Destinations.SV.pins.pinTextureAyleid.tint))
  DEST_PIN_TINT_DEADLANDS:SetRGBA(unpack(Destinations.SV.pins.pinTextureDeadlands.tint))
  DEST_PIN_TINT_HIGHISLE:SetRGBA(unpack(Destinations.SV.pins.pinTextureHighIsle.tint))
  DEST_PIN_TINT_DWEMER:SetRGBA(unpack(Destinations.SV.pins.pinTextureDwemer.tint))
  DEST_PIN_TINT_WWVAMP:SetRGBA(unpack(Destinations.SV.pins.pinTextureWWVamp.tint))
  DEST_PIN_TINT_VAMPALTAR:SetRGBA(unpack(Destinations.SV.pins.pinTextureVampAltar.tint))
  DEST_PIN_TINT_WWSHRINE:SetRGBA(unpack(Destinations.SV.pins.pinTextureWWShrine.tint))
  DEST_PIN_TINT_QOLPIN:SetRGBA(unpack(Destinations.SV.pins.pinTextureQolPin.tint))
end

local function OnLoad(eventCode, addonName)

  if addonName == Destinations.name then

    InitializeDatastores()

    -- Initialize Saved Variables (default to character-specific)
    Destinations.SV = ZO_SavedVars:NewCharacterNameSettings("Destinations_Settings", 1, nil, Destinations.defaults) -- Basic
    Destinations.CSSV = ZO_SavedVars:NewCharacterNameSettings("Destinations_Settings", 1, nil, Destinations.defaults)
    Destinations.AWSV = ZO_SavedVars:NewAccountWide("Destinations_Settings", 1, nil, Destinations.defaults) -- AccountWide

    -- Use account-wide data if enabled
    if Destinations.AWSV.settings.useAccountWide then
      Destinations.SV = ZO_SavedVars:NewAccountWide("Destinations_Settings", 1, nil, Destinations.defaults)
    end

    -- Sync the settings flag across all tables
    Destinations.SV.settings.useAccountWide = Destinations.AWSV.settings.useAccountWide
    Destinations.CSSV.settings.useAccountWide = Destinations.AWSV.settings.useAccountWide

    -- OneTamriel patch for legacy upgrades (runs once)
    if not Destinations.SV.oneTamrielUpdate and not Destinations.CSSV.oneTamrielUpdate and not Destinations.AWSV.oneTamrielUpdate then
      Destinations.SV.pins.pinTextureUnknown = Destinations.defaults.pins.pinTextureUnknown
      Destinations.CSSV.pins.pinTextureUnknown = Destinations.defaults.pins.pinTextureUnknown
      Destinations.AWSV.pins.pinTextureUnknown = Destinations.defaults.pins.pinTextureUnknown
      Destinations.SV.oneTamrielUpdate = true
      Destinations.CSSV.oneTamrielUpdate = true
      Destinations.AWSV.oneTamrielUpdate = true
    end

    -- Language functionality
    DisableEnglishFunctionnalities()

    -- Initialize Pin colors and text colors (requires SV to be resolved)
    InitializePinTextColorDefs()
    InitializePinTintColorDefs()
    InitializePinTextColorCollectibleDefs()
    InitializePinTextColorFishingDefs()

    Destinations.savedVarsInitialized = true

    --d("Redrawin Qol Pins")
    RedrawQolPins()

    if not Destinations.supported_menu_lang then
      --chat messages aren't shown before player is activated
      EVENT_MANAGER:RegisterForEvent(Destinations.name, EVENT_PLAYER_ACTIVATED, ShowLanguageWarning)
    end

    --Initialize Variables
    InitVariables()

    --Check if Gampad mode is activated
    OnGamepadPreferredModeChanged()

    -- Hook ZOS POI Tooltips
    HookPoiTooltips()
    HookKeepTooltips()

    --Establish Pin Configurations
    SetPinLayouts()

    -- Refresh enabled compass pins after initialization
    UpdateCompassFilters()

    --Initialize Settings Menu
    Destinations:InitSettings()

    -- Set Description
    InitializeSetDescription()

    --Register Event Triggers
    EVENT_MANAGER:RegisterForEvent(Destinations.name, EVENT_POI_UPDATED, function() Destinations:OnPOIUpdated() end)
    EVENT_MANAGER:RegisterForEvent(Destinations.name, EVENT_ACHIEVEMENT_UPDATED, OnAchievementUpdate)
    EVENT_MANAGER:RegisterForEvent(Destinations.name, EVENT_GAMEPAD_PREFERRED_MODE_CHANGED, OnGamepadPreferredModeChanged)

    EVENT_MANAGER:UnregisterForEvent(Destinations.name, EVENT_ADD_ON_LOADED)

  end
end

EVENT_MANAGER:RegisterForEvent(Destinations.name, EVENT_ADD_ON_LOADED, OnLoad)
