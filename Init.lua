--[[
-------------------------------------------------------------------------------
-- Destinations
-------------------------------------------------------------------------------
-- Original author: SnowmanDK (created 2014-07-29)
--
-- Current maintainer: Sharlikran (contributions since 2023-05-22)
-- Previous maintainers: MasterLenman, Ayantir
--
-- ----------------------------------------------------------------------------
-- The original work is licensed under the following terms (MIT-style license):
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
-- ----------------------------------------------------------------------------
-- Contributions by Sharlikran (starting 2023-05-22) are licensed under the
-- Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License:
--
-- You are free to:
--   Share � copy and redistribute the material in any medium or format
--   Adapt � remix, transform, and build upon the material
-- Under the following terms:
--   Attribution � You must give appropriate credit, provide a link to the license,
--     and indicate if changes were made.
--   NonCommercial � You may not use the material for commercial purposes.
--   ShareAlike � If you remix, transform, or build upon the material, you must
--     distribute your contributions under the same license as the original.
--
-- Full terms at: https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode
--
-- Maintainer Notice:
-- Redistribution of this software outside of ESOUI.com (including Bethesda.net
-- or other platforms) is discouraged unless authorized by the current
-- maintainer. While the original MIT license permits redistribution with proper
-- attribution and license inclusion, uncoordinated platform uploads may cause
-- version fragmentation or compatibility issues. Please respect the intent of
-- the maintainer and the integrity of the ESO addon ecosystem.
-------------------------------------------------------------------------------
]]
Destinations = Destinations or {}
Destinations.savedVarsInitialized = false
Destinations.name = "Destinations"
Destinations.author = "|c990000Snowman|r, |cFFFFFFDK|r, Ayantir, MasterLenman, |cFF9B15Sharlikran|r"
Destinations.version = "30.02"
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

DEST_PIN_TINT_CHAMPION = ZO_ColorDef:New(1, 0, 0, 1)
DEST_PIN_TINT_CHAMPION_DONE = ZO_ColorDef:New(0, 1, 0, 1)
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
  COLLECTIBLESDONE = "DEST_Pin_Collectibles_Done",
  COLLECTIBLES_SHOW_ITEM = "DEST_Compass_Collectibles_Show_Item",
  COLLECTIBLES_SHOW_MOBNAME = "DEST_Compass_Collectibles_Show_MobName",
  COLLECTIBLES_COMPASS = "DEST_Compass_Collectibles",

  FISHING = "DEST_Pin_Fishing",
  FISHINGDONE = "DEST_Pin_Fishing_Done",
  FISHING_SHOW_BAIT = "DEST_Compass_Fishing_Show_Bait",
  FISHING_SHOW_BAIT_LEFT = "DEST_Compass_Fishing_Show_Bait_Left",
  FISHING_SHOW_WATER = "DEST_Compass_Fishing_Show_Water",
  FISHING_SHOW_FISHNAME = "DEST_Compass_Fishing_Show_FishName",
  FISHING_COMPASS = "DEST_Compass_Fishing",
}
Destinations.PIN_TYPES = DPINS

local defaults = {
  pins = {
    pinTextureUnknown = {
      type = 7,
      size = 42,
      level = 80,
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
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureOtherDone = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureMaiq = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureMaiqDone = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTexturePeacemaker = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTexturePeacemakerDone = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureNosediver = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureNosediverDone = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureEarthlyPos = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureEarthlyPosDone = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureOnMe = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureOnMeDone = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureBrawl = {
      type = 5,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureBrawlDone = {
      type = 5,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTexturePatron = {
      type = 5,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTexturePatronDone = {
      type = 5,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureWrothgarJumper = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureWrothgarJumperDone = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureRelicHunter = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureRelicHunterDone = {
      type = 6,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureChampion = {
      type = 1,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureChampionDone = {
      type = 1,
      size = 26,
      level = 81,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureBreaking = {
      type = 5,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureBreakingDone = {
      type = 5,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureCutpurse = {
      type = 5,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureCutpurseDone = {
      type = 5,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureAyleid = {
      type = 5,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureDeadlands = {
      type = 1,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureHighIsle = {
      type = 1,
      size = 26,
      level = 80,
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
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureWWShrine = {
      type = 5,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureVampAltar = {
      type = 5,
      size = 26,
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
    },
    pinTextureCollectible = {
      type = 2,
      size = 26,
      level = 80,
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
      level = 80,
      maxDistance = 0.05,
      texture = "",
      tint = { 1, 1, 1, 1 },
      textcolor = { 1, 1, 1 },
      textcolortitle = { 1, 1, 1 },
    },
    pinTextureFish = {
      type = 1,
      size = 26,
      level = 80,
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
      level = 80,
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
      [1] = "Destinations/pins/a_global_asghaard-croix_black.dds",
      [2] = "Destinations/pins/a_global_asghaard-aura.dds",
      [3] = "/esoui/art/icons/poi/poi_wayshrine_incomplete.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/x-red.dds",
      [6] = "Destinations/pins/old/exclaimyellow.dds",
      [7] = "/esoui/art/icons/poi/poi_areaofinterest_incomplete.dds",
    },
    Other = {
      [1] = "Destinations/pins/achievement_other_robber_mask.dds",
      [2] = "Destinations/pins/achievement_other_vendetta.dds",
      [3] = "Destinations/pins/achievement_other_robber.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_other_colored.dds",
      [6] = "Destinations/pins/old/achievement_other_colored_red.dds",
    },
    OtherDone = {
      [1] = "Destinations/pins/achievement_other_robber_mask.dds",
      [2] = "Destinations/pins/achievement_other_vendetta.dds",
      [3] = "Destinations/pins/achievement_other_robber.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_other_colored-complete.dds",
      [6] = "Destinations/pins/old/achievement_other_colored-complete.dds",
    },
    Maiq = {
      [1] = "Destinations/pins/achievement_maiq_maiq.dds",
      [2] = "Destinations/pins/achievement_maiq_hood.dds",
      [3] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_maiq_colored.dds",
      [6] = "Destinations/pins/old/achievement_maiq_colored_red.dds",
    },
    MaiqDone = {
      [1] = "Destinations/pins/achievement_maiq_maiq.dds",
      [2] = "Destinations/pins/achievement_maiq_hood.dds",
      [3] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_maiq_colored-complete.dds",
      [6] = "Destinations/pins/old/achievement_maiq_colored-complete.dds",
    },
    Peacemaker = {
      [1] = "Destinations/pins/achievement_peacemaker_dove.dds",
      [2] = "Destinations/pins/achievement_peacemaker_peacesign.dds",
      [3] = "Destinations/pins/achievement_peacemaker_peacelogo.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_peacemaker_colored.dds",
      [6] = "Destinations/pins/old/achievement_peacemaker_colored_red.dds",
    },
    PeacemakerDone = {
      [1] = "Destinations/pins/achievement_peacemaker_dove.dds",
      [2] = "Destinations/pins/achievement_peacemaker_peacesign.dds",
      [3] = "Destinations/pins/achievement_peacemaker_peacelogo.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_peacemaker_colored-complete.dds",
      [6] = "Destinations/pins/old/achievement_peacemaker_colored-complete.dds",
    },
    Nosediver = {
      [1] = "Destinations/pins/achievement_nosediver_nose_1.dds",
      [2] = "Destinations/pins/achievement_nosediver_nose_2.dds",
      [3] = "Destinations/pins/achievement_nosediver_diver.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_nosediver_colored.dds",
      [6] = "Destinations/pins/old/achievement_nosediver_colored_red.dds",
    },
    NosediverDone = {
      [1] = "Destinations/pins/achievement_nosediver_nose_1.dds",
      [2] = "Destinations/pins/achievement_nosediver_nose_2.dds",
      [3] = "Destinations/pins/achievement_nosediver_diver.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_nosediver_colored-complete.dds",
      [6] = "Destinations/pins/old/achievement_nosediver_colored-complete.dds",
    },
    Earthlypos = {
      [1] = "Destinations/pins/achievement_earthlypossessions_pouch.dds",
      [2] = "Destinations/pins/achievement_earthlypossessions_gold.dds",
      [3] = "Destinations/pins/achievement_earthlypossessions_chest.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_earthlypossessions_gold.dds",
      [6] = "Destinations/pins/old/achievement_earthlypossessions_gold_red.dds",
    },
    EarthlyposDone = {
      [1] = "Destinations/pins/achievement_earthlypossessions_pouch.dds",
      [2] = "Destinations/pins/achievement_earthlypossessions_gold.dds",
      [3] = "Destinations/pins/achievement_earthlypossessions_chest.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_earthlypossessions_gold-complete.dds",
      [6] = "Destinations/pins/old/achievement_earthlypossessions_gold-complete.dds",
    },
    OnMe = {
      [1] = "Destinations/pins/achievement_thisonesonme_coctail_1.dds",
      [2] = "Destinations/pins/achievement_thisonesonme_coctail_2.dds",
      [3] = "Destinations/pins/achievement_thisonesonme_wine.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_thisonesonme_colored.dds",
      [6] = "Destinations/pins/old/achievement_thisonesonme_colored_red.dds",
    },
    OnMeDone = {
      [1] = "Destinations/pins/achievement_thisonesonme_coctail_1.dds",
      [2] = "Destinations/pins/achievement_thisonesonme_coctail_2.dds",
      [3] = "Destinations/pins/achievement_thisonesonme_wine.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_thisonesonme_colored-complete.dds",
      [6] = "Destinations/pins/old/achievement_thisonesonme_colored-complete.dds",
    },
    Brawl = {
      [1] = "Destinations/pins/achievement_brawl_brawl.dds",
      [2] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [3] = "Destinations/pins/a_global_x.dds",
      [4] = "Destinations/pins/old/achievement_brawl_colored.dds",
      [5] = "Destinations/pins/old/achievement_brawl_colored_red.dds",
    },
    BrawlDone = {
      [1] = "Destinations/pins/achievement_brawl_brawl.dds",
      [2] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [3] = "Destinations/pins/a_global_x.dds",
      [4] = "Destinations/pins/old/achievement_brawl_colored-complete.dds",
      [5] = "Destinations/pins/old/achievement_brawl_colored-complete.dds",
    },
    Patron = {
      [1] = "Destinations/pins/achievement_patron_patron.dds",
      [2] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [3] = "Destinations/pins/a_global_x.dds",
      [4] = "Destinations/pins/old/achievement_patron_colored.dds",
      [5] = "Destinations/pins/old/achievement_patron_colored_red.dds",
    },
    PatronDone = {
      [1] = "Destinations/pins/achievement_patron_patron.dds",
      [2] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [3] = "Destinations/pins/a_global_x.dds",
      [4] = "Destinations/pins/old/achievement_patron_colored-complete.dds",
      [5] = "Destinations/pins/old/achievement_patron_colored-complete.dds",
    },
    WrothgarJumper = {
      [1] = "Destinations/pins/achievement_wrothgarcliffjumper.dds",
      [2] = "Destinations/pins/achievement_wrothgarcliffjumper_inverted.dds",
      [3] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_wrothgarcliffjumper_colored.dds",
      [6] = "Destinations/pins/old/achievement_wrothgarcliffjumper_colored_red.dds",
    },
    WrothgarJumperDone = {
      [1] = "Destinations/pins/achievement_wrothgarcliffjumper.dds",
      [2] = "Destinations/pins/achievement_wrothgarcliffjumper_inverted.dds",
      [3] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_wrothgarcliffjumper_colored-complete.dds",
      [6] = "Destinations/pins/old/achievement_wrothgarcliffjumper_colored-complete.dds",
    },
    RelicHunter = {
      [1] = "Destinations/pins/achievement_relichunter.dds",
      [2] = "Destinations/pins/achievement_relichunter_inverted.dds",
      [3] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_relichunter_colored.dds",
      [6] = "Destinations/pins/old/achievement_relichunter_colored_red.dds",
    },
    RelicHunterDone = {
      [1] = "Destinations/pins/achievement_relichunter.dds",
      [2] = "Destinations/pins/achievement_relichunter_inverted.dds",
      [3] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/achievement_relichunter_colored-complete.dds",
      [6] = "Destinations/pins/old/achievement_relichunter_colored-complete.dds",
    },
    Champion = {
      [1] = "Destinations/pins/achievement_champ.dds",
      [2] = "Destinations/pins/achievement_champ_red.dds",
      [3] = "Destinations/pins/dwemer_helmet.dds",
      [4] = "Destinations/pins/a_global_asghaard-aura.dds",
      [5] = "Destinations/pins/old/achievement_champ_colored.dds",
      [6] = "Destinations/pins/old/achievement_champ_colored_red.dds",
      [7] = "/esoui/art/icons/poi/poi_groupboss_incomplete.dds",
    },
    ChampionDone = {
      [1] = "Destinations/pins/achievement_champ.dds",
      [2] = "Destinations/pins/achievement_champ_green.dds",
      [3] = "Destinations/pins/dwemer_helmet.dds",
      [4] = "Destinations/pins/a_global_asghaard-aura.dds",
      [5] = "Destinations/pins/old/achievement_champ_colored-complete.dds",
      [6] = "Destinations/pins/old/achievement_champ_colored-complete.dds",
      [7] = "/esoui/art/icons/poi/poi_groupboss_complete.dds",
    },
    Breaking = {
      [1] = "Destinations/pins/achievement_breaking_padlock_black.dds",
      [2] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [3] = "Destinations/pins/a_global_x.dds",
      [4] = "Destinations/pins/old/achievement_breaking_colored.dds",
      [5] = "Destinations/pins/old/achievement_breaking_colored_red.dds",
    },
    BreakingDone = {
      [1] = "Destinations/pins/achievement_breaking_padlock_white.dds",
      [2] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [3] = "Destinations/pins/a_global_x.dds",
      [4] = "Destinations/pins/old/achievement_breaking_colored-complete.dds",
      [5] = "Destinations/pins/old/achievement_breaking_colored-complete.dds",
    },
    Cutpurse = {
      [1] = "Destinations/pins/achievement_cutpurse_cutpurse_black.dds",
      [2] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [3] = "Destinations/pins/a_global_x.dds",
      [4] = "Destinations/pins/old/achievement_cutpurse_colored.dds",
      [5] = "Destinations/pins/old/achievement_cutpurse_colored_red.dds",
    },
    CutpurseDone = {
      [1] = "Destinations/pins/achievement_cutpurse_cutpurse_white.dds",
      [2] = "Destinations/pins/a_global_asghaard-croix_white.dds",
      [3] = "Destinations/pins/a_global_x.dds",
      [4] = "Destinations/pins/old/achievement_cutpurse_colored-complete.dds",
      [5] = "Destinations/pins/old/achievement_cutpurse_colored-complete.dds",
    },
    Ayleid = {
      [1] = "Destinations/pins/ayleid_well_1.dds",
      [2] = "Destinations/pins/ayleid_well_1_inverted.dds",
      [3] = "Destinations/pins/ayleid_well_2.dds",
      [4] = "Destinations/pins/a_global_asghaard-aura.dds",
      [5] = "Destinations/pins/old/ayleid_well_colored.dds",
      [6] = "Destinations/pins/old/ayleid_well_colored_red.dds",
    },
    Deadlands = {
      [1] = "Destinations/pins/deadlands.dds",
    },
    HighIsle = {
      [1] = "/esoui/art/icons/passive_warden_005.dds",
    },
    dwemer = {
      [1] = "Destinations/pins/dummy.dds",
      [2] = "Destinations/pins/dwemer_helmet.dds",
      [3] = "Destinations/pins/dwemer_cog.dds",
      [4] = "Destinations/pins/a_global_asghaard-aura.dds",
      [5] = "Destinations/pins/old/dwemer_helm.dds",
      [6] = "Destinations/pins/old/dwemer_helm_red_circle.dds",
      [7] = "Destinations/pins/old/dwemer_spider_colored.dds",
      [8] = "Destinations/pins/old/dwemer_spider_red_circle.dds",
      [9] = "Destinations/pins/collectible_dwemer_cog.dds",
    },
    wwvamp = {
      [1] = "Destinations/pins/vampww_werewolf.dds",
      [2] = "Destinations/pins/vampww_werewolf_inverted.dds",
      [3] = "Destinations/pins/vampww_vampire.dds",
      [4] = "Destinations/pins/vampww_vampire_inverted.dds",
      [5] = "Destinations/pins/old/vampww_werewolf.dds",
      [6] = "Destinations/pins/old/vampww_vampire.dds",
      [7] = "Destinations/pins/old/vampww_werewolf_red.dds",
      [8] = "Destinations/pins/old/vampww_vampire_red.dds",
    },
    vampirealtar = {
      [1] = "Destinations/pins/vampire_altar_vampireskull.dds",
      [2] = "Destinations/pins/vampire_altar_1.dds",
      [3] = "Destinations/pins/vampire_altar_2.dds",
      [4] = "Destinations/pins/a_global_asghaard-aura.dds",
      [5] = "Destinations/pins/old/vampire_altar.dds",
      [6] = "Destinations/pins/old/vampire_altar_red_circle.dds",
    },
    werewolfshrine = {
      [1] = "Destinations/pins/werewolf_wolf.dds",
      [2] = "Destinations/pins/werewolf_shrine_1.dds",
      [3] = "Destinations/pins/werewolf_shrine_2.dds",
      [4] = "Destinations/pins/a_global_asghaard-aura.dds",
      [5] = "Destinations/pins/old/werewolf_shrine.dds",
      [6] = "Destinations/pins/old/werewolf_shrine_red.dds",
    },
    collectible = {
      [1] = "Destinations/pins/collectible_skull.dds",
      [2] = "Destinations/pins/collectible_dwemer_cog.dds",
      [3] = "Destinations/pins/collectible_mudcrab.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/collectible_trophy.dds",
      [6] = "Destinations/pins/old/collectible_colored.dds",
      [7] = "/esoui/art/treeicons/achievements_indexicon_summary_down.dds",
    },
    collectibledone = {
      [1] = "Destinations/pins/collectible_skull.dds",
      [2] = "Destinations/pins/collectible_dwemer_cog.dds",
      [3] = "Destinations/pins/collectible_mudcrab.dds",
      [4] = "Destinations/pins/a_global_x.dds",
      [5] = "Destinations/pins/old/collectible_trophy.dds",
      [6] = "Destinations/pins/old/collectible_colored-complete.dds",
      [7] = "/esoui/art/treeicons/achievements_indexicon_summary_down.dds",
    },
    fish = {
      [1] = "Destinations/pins/fish_1.dds",
      [2] = "Destinations/pins/fish_2.dds",
      [3] = "Destinations/pins/fish_3.dds",
      [4] = "Destinations/pins/fish_4.dds",
      [5] = "Destinations/pins/old/fish_colored.dds",
      [6] = "/esoui/art/treeicons/achievements_indexicon_fishing_down.dds",
    },
    fishdone = {
      [1] = "Destinations/pins/fish_1.dds",
      [2] = "Destinations/pins/fish_2.dds",
      [3] = "Destinations/pins/fish_3.dds",
      [4] = "Destinations/pins/fish_4.dds",
      [5] = "Destinations/pins/old/fish_colored-complete.dds",
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
Destinations.show_log = true
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
