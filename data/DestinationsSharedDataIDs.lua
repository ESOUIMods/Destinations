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
Destinations.AchIDs = {                     -- using dummy code 999999 for things that have no achievements.
  [872] = (GetAchievementInfo(872)), --"I like M'aiq"
  [873] = (GetAchievementInfo(873)), --"Lightbringer"        ------  using shared code: 767167 (decimal numbers for the letters LGC)
  [871] = (GetAchievementInfo(871)), --"Give to the Poor"    ------  using shared code: 767167 (decimal numbers for the letters LGC)
  [869] = (GetAchievementInfo(869)), --"Crime Pays"          ------  using shared code: 767167 (decimal numbers for the letters LGC)
  [716] = (GetAchievementInfo(716)), --"Peacemaker"
  [704] = (GetAchievementInfo(704)), --"This One's on Me"
  [406] = (GetAchievementInfo(406)), --"Nose Diver"
  [1121] = (GetAchievementInfo(1121)), --"Earthly Possessions"
  [1247] = (GetAchievementInfo(1247)), --"One Last Brawl"
  [1250] = (GetAchievementInfo(1250)), --"Wrothgar Relic Hunter"
  [1316] = (GetAchievementInfo(1316)), --"Orsinium Patron"
  [1331] = (GetAchievementInfo(1331)), --"Wrothgar Cliff Jumper"
  [1349] = (GetAchievementInfo(1349)), --"Breaking and Entering"
  [1379] = (GetAchievementInfo(1379)), --"Despoil the Dominion",
  [1380] = (GetAchievementInfo(1380)), --"Con the Covenant",
  [1381] = (GetAchievementInfo(1381)), --"Purloin the Pact",
  [1382] = (GetAchievementInfo(1382)), --"Loot the Landing",
  [1383] = (GetAchievementInfo(1383)), --"A Cutpurse Above"
  [1410] = (GetAchievementInfo(1410)), --"Litany of Blood"
}
Destinations.CollectibleIDs = {
  [838] = (GetAchievementInfo(838)), --"Tamriel Beast Collector"
  [841] = (GetAchievementInfo(841)), --"Undead Hoarder"
  [842] = (GetAchievementInfo(842)), --"Chitin Accumulator"
  [843] = (GetAchievementInfo(843)), --"Nature Collector"
  [844] = (GetAchievementInfo(844)), --"Monstrous Component Collector"
  [846] = (GetAchievementInfo(846)), --"Dwarven Secrets Gatherer"
  [847] = (GetAchievementInfo(847)), --"Atronach Element Collector"
  [848] = (GetAchievementInfo(848)), --"Oblivion Shard Gatherer"
}
Destinations.FishIDs = {
  [471] = (GetAchievementInfo(471)), --"Glenumbra Angler"
  [472] = (GetAchievementInfo(472)), --"Stormhaven Angler"
  [473] = (GetAchievementInfo(473)), --"Rivenspire Angler"
  [474] = (GetAchievementInfo(474)), --"Alik'r Desert Angler"
  [475] = (GetAchievementInfo(475)), --"Bangkorai Angler"
  [476] = (GetAchievementInfo(476)), --"Covenant Fisherman"
  [477] = (GetAchievementInfo(477)), --"Stonefalls Angler"
  [478] = (GetAchievementInfo(478)), --"Deshaan Angler"
  [479] = (GetAchievementInfo(479)), --"Shadowfen Angler"
  [480] = (GetAchievementInfo(480)), --"Eastmarch Angler"
  [481] = (GetAchievementInfo(481)), --"Rift Angler"
  [482] = (GetAchievementInfo(482)), --"Pact Fisherman"
  [483] = (GetAchievementInfo(483)), --"Auridon Angler"
  [484] = (GetAchievementInfo(484)), --"Grahtwood Angler"
  [485] = (GetAchievementInfo(485)), --"Greenshade Angler"
  [486] = (GetAchievementInfo(486)), --"Malabal Tor Angler"
  [487] = (GetAchievementInfo(487)), --"Reaper's March Angler"
  [488] = (GetAchievementInfo(488)), --"Dominion Fisherman"
  [489] = (GetAchievementInfo(489)), --"Cyrodiil Angler"
  [490] = (GetAchievementInfo(490)), --"Coldharbour Angler"
  [491] = (GetAchievementInfo(491)), --"Stros M'Kai Angler"
  [492] = (GetAchievementInfo(492)), --"Khenarthi's Roost Angler"
  [493] = (GetAchievementInfo(493)), --"Bleakrock Angler"
  [494] = (GetAchievementInfo(494)), --"Master Fisher"
  [916] = (GetAchievementInfo(916)), --"Craglorn Angler"
  [1186] = (GetAchievementInfo(1186)), --"Imperial City Angler"
  [1340] = (GetAchievementInfo(1340)), --"Wrothgar Master Angler"
  [1339] = (GetAchievementInfo(1339)), --"Hooking Wrothgar's Biggest Catch"
  [1351] = (GetAchievementInfo(1351)), --"Hew's Bane Master Angler"
  [1431] = (GetAchievementInfo(1431)), --"Gold Coast Master Angler"
  [2027] = (GetAchievementInfo(2027)), --"Clockwork City Master Angler"
  [2191] = (GetAchievementInfo(2191)), --"Summerset Master Angler"
  [2240] = (GetAchievementInfo(2240)), --"Artaeum Master Angler"
  [2655] = (GetAchievementInfo(2655)), --"Western Skyrim Master Angler"
  [1882] = (GetAchievementInfo(1882)), --"Morrowind master Angler"
  [2295] = (GetAchievementInfo(2295)), --"Murkmire Master Angler"
  [2566] = (GetAchievementInfo(2566)), --"Pellitine Master Angler"
  [2412] = (GetAchievementInfo(2412)), --"Northern Elsweyr Master Angler"
  [2861] = (GetAchievementInfo(2861)), --"The Reach Master Angler"
  [2981] = (GetAchievementInfo(2981)), --"Blackwood Master Angler"
  [3144] = (GetAchievementInfo(3144)), --"Deadlands Master Angler"
  [3269] = (GetAchievementInfo(3269)), --"High Isle Master Angler"
  [3500] = (GetAchievementInfo(3500)), --"Galen Master Angler"
  [3636] = (GetAchievementInfo(3636)), --"Necrom Master Angler" : Telvanni Peninsula, Apocrypha
  [3948] = (GetAchievementInfo(3948)), --"West Weald Master Angler"
  [4404] = (GetAchievementInfo(4404)), --"West Weald Master Angler"
}
Destinations.FishLocs = {
  ["glenumbra_base_0"] = 471, --"Glenumbra Angler"
  ["stormhaven_base_0"] = 472, --"Stormhaven Angler"
  ["rivenspire_base_0"] = 473, --"Rivenspire Angler"
  ["alikr_base_0"] = 474, --"Alik'r Desert Angler"
  ["bangkorai_base_0"] = 475, --"Bangkorai Angler"

  ["stonefalls_base_0"] = 477, --"Stonefalls Angler"
  ["deshaan_base_0"] = 478, --"Deshaan Angler"
  ["shadowfen_base_0"] = 479, --"Shadowfen Angler"
  ["eastmarch_base_0"] = 480, --"Eastmarch Angler"
  ["therift_base_0"] = 481, --"Rift Angler"

  ["auridon_base_0"] = 483, --"Auridon Angler"
  ["grahtwood_base_0"] = 484, --"Grahtwood Angler"
  ["greenshade_base_0"] = 485, --"Greenshade Angler"
  ["malabaltor_base_0"] = 486, --"Malabal Tor Angler"
  ["reapersmarch_base_0"] = 487, --"Reaper's March Angler"

  ["ava_whole_0"] = 489, --"Cyrodiil Angler"
  ["coldharbour_base_0"] = 490, --"Coldharbour Angler"
  ["strosmkai_base_0"] = 491, --"Stros M'Kai Angler"
  ["khenarthisroost_base_0"] = 492, --"Khenarthi's Roost Angler"
  ["bleakrock_base_0"] = 493, --"Bleakrock Angler"

  ["craglorn_base_0"] = 916, --"Craglorn Angler"
  ["imperialcity_base_0"] = 1186, --"Imperial City Angler"
  ["wrothgar_base_0"] = 1340, --"Wrothgar Master Angler"
  ["hewsbane_base_0"] = 1351, --"Hew's Bane Master Angler"
  ["goldcoast_base_0"] = 1431, --"Gold Coast Master Angler"

  ["clockwork_base_0"] = 2027, --"Clockwork City Master Angler"
  ["summerset_base_0"] = 2191, --"Summerset Master Angler"
  ["artaeum_base_0"] = 2240, --"Artaeum Master Angler"
  ["westernskryim_base_0"] = 2655, --"Western Skyrim Master Angler"
  ["vvardenfell_base_0"] = 1882, --"Morrowind Master Angler"
  ["murkmire_base_0"] = 2295, --"Murkmire Master Angler"
  ["southernelsweyr_base_0"] = 2566, --"Pellitine Master Angler"
  ["elsweyr_base_0"] = 2412, --"Northern Elsweyr Master Angler"
  -- The Reach, and Arkthzand Cavern are the same fishing ach
  ["reach_base_0"] = 2861, --"The Reach Master Angler"
  ["u28_blackreach_base_0"] = 2861, --"The Reach Master Angler"
  ["blackwood_base_0"] = 2981, --"Blackwood Master Angler"
  ["u32deadlandszone_base_0"] = 3144, --"Deadlands Master Angler"
  ["u34_systreszone_base_0"] = 3269, --"High Isle Master Angler"
  ["u36_galenisland_base_0"] = 3500, --"Galen Master Angler"
  ["u38_telvannipeninsula_base_0"] = 3636, --"Necrom Master Angler"
  ["u38_apocrypha_base_0"] = 3636, --"Necrom Master Angler"
  ["westwealdoverland_base_0"] = 3948, --"West Weald Master Angler"
  ["u46_overland_base_0"] = 4404, --"Western Solstice Master Angler"
}
