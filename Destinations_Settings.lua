local LAM = LibAddonMenu2
local LMP = LibMapPins
local DESTINATIONS_PIN_PRIORITY_OFFSET = 1

-- Toggle filters depending on settings
function Destinations:TogglePins(pinType, value)
  Destinations.CSSV.filters[pinType] = value
  LMP:SetEnabled(pinType, value)
  COMPASS_PINS:SetCompassPinEnabled(pinType, value)
end

-- Refresh map and compass pins
local function RedrawAllPins(pinType)
  LMP:RefreshPins(pinType)
  COMPASS_PINS:RefreshPins(pinType)
end

-- Refresh compass pins only
local function RedrawCompassPinsOnly(pinType)
  COMPASS_PINS:RefreshPins(pinType)
end

local function SetUnknownDestLayoutKey(value, newvalue)
  LMP:SetLayoutKey(Destinations.PIN_TYPES.UNKNOWN, value, newvalue)
end

-- Refresh all achievement map and compass pins
local function RedrawAllAchievementPins()
  for _, pinName in pairs(Destinations.drtv.AchPins) do
    LMP:RefreshPins(Destinations.PIN_TYPES[pinName])
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES[pinName])
    pinName = pinName .. "_DONE"
    LMP:RefreshPins(Destinations.PIN_TYPES[pinName])
    COMPASS_PINS:RefreshPins(Destinations.PIN_TYPES[pinName])
  end
end

function Destinations:InitSettings()
  local panelData = {
    type = "panel",
    name = GetString(DEST_SETTINGS_TITLE),
    displayName = GetString(DEST_SETTINGS_TITLE),
    author = Destinations.author,
    version = Destinations.version,
    slashCommand = "/dset",
    registerForRefresh = true,
    registerForDefaults = true,
    website = Destinations.website,
  }
  local settingsPanel = LAM:RegisterAddonPanel("Destinations_OptionsPanel", panelData)

  --Icon Preview
  local unknownPoiPreview, otherPreview, otherPreviewDone, MaiqPreview, MaiqPreviewDone, PeacemakerPreview, PeacemakerPreviewDone, NosediverPreview, NosediverPreviewDone
  local EarthlyPosPreview, EarthlyPosPreviewDone, OnMePreview, OnMePreviewDone, BrawlPreview, BrawlPreviewDone, PatronPreview, PatronPreviewDone
  local WrothgarJumperPreview, WrothgarJumperPreviewDone, RelicHunterPreview, RelicHunterPreviewDone, BreakingPreview, BreakingPreviewDone, CutpursePreview, CutpursePreviewDone
  local ChampionPreview, ChampionPreviewDone, AyleidPreview, DwemerPreview, WWVampPreview, VampAltarPreview, WWShrinePreview
  local CollectiblePreview, CollectibleDonePreview, FishPreview, FishDonePreview

  local function CreateAllIconPreviews()
    unknownPoiPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureUnknown, CT_TEXTURE)
    unknownPoiPreview:SetAnchor(RIGHT, previewpinTextureUnknown.dropdown:GetControl(), LEFT, -10, 0)
    unknownPoiPreview:SetTexture(Destinations.pinTextures.paths.Unknown[Destinations.SV.pins.pinTextureUnknown.type])
    unknownPoiPreview:SetDimensions(Destinations.SV.pins.pinTextureUnknown.size, Destinations.SV.pins.pinTextureUnknown.size)
    unknownPoiPreview:SetColor(unpack(Destinations.SV.pins.pinTextureUnknown.tint))

    otherPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureOther, CT_TEXTURE)
    otherPreview:SetAnchor(RIGHT, previewpinTextureOther.dropdown:GetControl(), LEFT, -40, 0)
    otherPreview:SetTexture(Destinations.pinTextures.paths.Other[Destinations.SV.pins.pinTextureOther.type])
    otherPreview:SetDimensions(Destinations.SV.pins.pinTextureOther.size, Destinations.SV.pins.pinTextureOther.size)
    otherPreview:SetColor(unpack(Destinations.SV.pins.pinTextureOther.tint))

    otherPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureOther, CT_TEXTURE)
    otherPreviewDone:SetAnchor(RIGHT, previewpinTextureOther.dropdown:GetControl(), LEFT, -5, 0)
    otherPreviewDone:SetTexture(Destinations.pinTextures.paths.OtherDone[Destinations.SV.pins.pinTextureOtherDone.type])
    otherPreviewDone:SetDimensions(Destinations.SV.pins.pinTextureOtherDone.size, Destinations.SV.pins.pinTextureOtherDone.size)
    otherPreviewDone:SetColor(unpack(Destinations.SV.pins.pinTextureOtherDone.tint))

    ChampionPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureChampion, CT_TEXTURE)
    ChampionPreview:SetAnchor(RIGHT, previewpinTextureChampion.dropdown:GetControl(), LEFT, -40, 0)
    ChampionPreview:SetTexture(Destinations.pinTextures.paths.Champion[Destinations.SV.pins.pinTextureChampion.type])
    ChampionPreview:SetDimensions(Destinations.SV.pins.pinTextureChampion.size, Destinations.SV.pins.pinTextureChampion.size)
    ChampionPreview:SetColor(unpack(Destinations.SV.pins.pinTextureChampion.tint))

    ChampionPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureChampion, CT_TEXTURE)
    ChampionPreviewDone:SetAnchor(RIGHT, previewpinTextureChampion.dropdown:GetControl(), LEFT, -5, 0)
    ChampionPreviewDone:SetTexture(Destinations.pinTextures.paths.ChampionDone[Destinations.SV.pins.pinTextureChampionDone.type])
    ChampionPreviewDone:SetDimensions(Destinations.SV.pins.pinTextureChampionDone.size, Destinations.SV.pins.pinTextureChampionDone.size)
    ChampionPreviewDone:SetColor(unpack(Destinations.SV.pins.pinTextureChampionDone.tint))

    MaiqPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureMaiq, CT_TEXTURE)
    MaiqPreview:SetAnchor(RIGHT, previewpinTextureMaiq.dropdown:GetControl(), LEFT, -40, 0)
    MaiqPreview:SetTexture(Destinations.pinTextures.paths.Maiq[Destinations.SV.pins.pinTextureMaiq.type])
    MaiqPreview:SetDimensions(Destinations.SV.pins.pinTextureMaiq.size, Destinations.SV.pins.pinTextureMaiq.size)
    MaiqPreview:SetColor(unpack(Destinations.SV.pins.pinTextureMaiq.tint))

    MaiqPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureMaiq, CT_TEXTURE)
    MaiqPreviewDone:SetAnchor(RIGHT, previewpinTextureMaiq.dropdown:GetControl(), LEFT, -5, 0)
    MaiqPreviewDone:SetTexture(Destinations.pinTextures.paths.MaiqDone[Destinations.SV.pins.pinTextureMaiqDone.type])
    MaiqPreviewDone:SetDimensions(Destinations.SV.pins.pinTextureMaiqDone.size, Destinations.SV.pins.pinTextureMaiqDone.size)
    MaiqPreviewDone:SetColor(unpack(Destinations.SV.pins.pinTextureMaiqDone.tint))

    PeacemakerPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTexturePeacemaker, CT_TEXTURE)
    PeacemakerPreview:SetAnchor(RIGHT, previewpinTexturePeacemaker.dropdown:GetControl(), LEFT, -40, 0)
    PeacemakerPreview:SetTexture(Destinations.pinTextures.paths.Peacemaker[Destinations.SV.pins.pinTexturePeacemaker.type])
    PeacemakerPreview:SetDimensions(Destinations.SV.pins.pinTexturePeacemaker.size, Destinations.SV.pins.pinTexturePeacemaker.size)
    PeacemakerPreview:SetColor(unpack(Destinations.SV.pins.pinTexturePeacemaker.tint))

    PeacemakerPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTexturePeacemaker, CT_TEXTURE)
    PeacemakerPreviewDone:SetAnchor(RIGHT, previewpinTexturePeacemaker.dropdown:GetControl(), LEFT, -5, 0)
    PeacemakerPreviewDone:SetTexture(Destinations.pinTextures.paths.PeacemakerDone[Destinations.SV.pins.pinTexturePeacemakerDone.type])
    PeacemakerPreviewDone:SetDimensions(Destinations.SV.pins.pinTexturePeacemakerDone.size, Destinations.SV.pins.pinTexturePeacemakerDone.size)
    PeacemakerPreviewDone:SetColor(unpack(Destinations.SV.pins.pinTexturePeacemakerDone.tint))

    NosediverPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureNosediver, CT_TEXTURE)
    NosediverPreview:SetAnchor(RIGHT, previewpinTextureNosediver.dropdown:GetControl(), LEFT, -40, 0)
    NosediverPreview:SetTexture(Destinations.pinTextures.paths.Nosediver[Destinations.SV.pins.pinTextureNosediver.type])
    NosediverPreview:SetDimensions(Destinations.SV.pins.pinTextureNosediver.size, Destinations.SV.pins.pinTextureNosediver.size)
    NosediverPreview:SetColor(unpack(Destinations.SV.pins.pinTextureNosediver.tint))

    NosediverPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureNosediver, CT_TEXTURE)
    NosediverPreviewDone:SetAnchor(RIGHT, previewpinTextureNosediver.dropdown:GetControl(), LEFT, -5, 0)
    NosediverPreviewDone:SetTexture(Destinations.pinTextures.paths.NosediverDone[Destinations.SV.pins.pinTextureNosediverDone.type])
    NosediverPreviewDone:SetDimensions(Destinations.SV.pins.pinTextureNosediverDone.size, Destinations.SV.pins.pinTextureNosediverDone.size)
    NosediverPreviewDone:SetColor(unpack(Destinations.SV.pins.pinTextureNosediverDone.tint))

    EarthlyPosPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureEarthlyPos, CT_TEXTURE)
    EarthlyPosPreview:SetAnchor(RIGHT, previewpinTextureEarthlyPos.dropdown:GetControl(), LEFT, -40, 0)
    EarthlyPosPreview:SetTexture(Destinations.pinTextures.paths.Earthlypos[Destinations.SV.pins.pinTextureEarthlyPos.type])
    EarthlyPosPreview:SetDimensions(Destinations.SV.pins.pinTextureEarthlyPos.size, Destinations.SV.pins.pinTextureEarthlyPos.size)
    EarthlyPosPreview:SetColor(unpack(Destinations.SV.pins.pinTextureEarthlyPos.tint))

    EarthlyPosPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureEarthlyPos, CT_TEXTURE)
    EarthlyPosPreviewDone:SetAnchor(RIGHT, previewpinTextureEarthlyPos.dropdown:GetControl(), LEFT, -5, 0)
    EarthlyPosPreviewDone:SetTexture(Destinations.pinTextures.paths.EarthlyposDone[Destinations.SV.pins.pinTextureEarthlyPosDone.type])
    EarthlyPosPreviewDone:SetDimensions(Destinations.SV.pins.pinTextureEarthlyPosDone.size, Destinations.SV.pins.pinTextureEarthlyPosDone.size)
    EarthlyPosPreviewDone:SetColor(unpack(Destinations.SV.pins.pinTextureEarthlyPosDone.tint))

    OnMePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureOnMe, CT_TEXTURE)
    OnMePreview:SetAnchor(RIGHT, previewpinTextureOnMe.dropdown:GetControl(), LEFT, -40, 0)
    OnMePreview:SetTexture(Destinations.pinTextures.paths.OnMe[Destinations.SV.pins.pinTextureOnMe.type])
    OnMePreview:SetDimensions(Destinations.SV.pins.pinTextureOnMe.size, Destinations.SV.pins.pinTextureOnMe.size)
    OnMePreview:SetColor(unpack(Destinations.SV.pins.pinTextureOnMe.tint))

    OnMePreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureOnMe, CT_TEXTURE)
    OnMePreviewDone:SetAnchor(RIGHT, previewpinTextureOnMe.dropdown:GetControl(), LEFT, -5, 0)
    OnMePreviewDone:SetTexture(Destinations.pinTextures.paths.OnMeDone[Destinations.SV.pins.pinTextureOnMeDone.type])
    OnMePreviewDone:SetDimensions(Destinations.SV.pins.pinTextureOnMeDone.size, Destinations.SV.pins.pinTextureOnMeDone.size)
    OnMePreviewDone:SetColor(unpack(Destinations.SV.pins.pinTextureOnMeDone.tint))

    BrawlPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureBrawl, CT_TEXTURE)
    BrawlPreview:SetAnchor(RIGHT, previewpinTextureBrawl.dropdown:GetControl(), LEFT, -40, 0)
    BrawlPreview:SetTexture(Destinations.pinTextures.paths.Brawl[Destinations.SV.pins.pinTextureBrawl.type])
    BrawlPreview:SetDimensions(Destinations.SV.pins.pinTextureBrawl.size, Destinations.SV.pins.pinTextureBrawl.size)
    BrawlPreview:SetColor(unpack(Destinations.SV.pins.pinTextureBrawl.tint))

    BrawlPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureBrawl, CT_TEXTURE)
    BrawlPreviewDone:SetAnchor(RIGHT, previewpinTextureBrawl.dropdown:GetControl(), LEFT, -5, 0)
    BrawlPreviewDone:SetTexture(Destinations.pinTextures.paths.BrawlDone[Destinations.SV.pins.pinTextureBrawlDone.type])
    BrawlPreviewDone:SetDimensions(Destinations.SV.pins.pinTextureBrawlDone.size, Destinations.SV.pins.pinTextureBrawlDone.size)
    BrawlPreviewDone:SetColor(unpack(Destinations.SV.pins.pinTextureBrawlDone.tint))

    PatronPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTexturePatron, CT_TEXTURE)
    PatronPreview:SetAnchor(RIGHT, previewpinTexturePatron.dropdown:GetControl(), LEFT, -40, 0)
    PatronPreview:SetTexture(Destinations.pinTextures.paths.Patron[Destinations.SV.pins.pinTexturePatron.type])
    PatronPreview:SetDimensions(Destinations.SV.pins.pinTexturePatron.size, Destinations.SV.pins.pinTexturePatron.size)
    PatronPreview:SetColor(unpack(Destinations.SV.pins.pinTexturePatron.tint))

    PatronPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTexturePatron, CT_TEXTURE)
    PatronPreviewDone:SetAnchor(RIGHT, previewpinTexturePatron.dropdown:GetControl(), LEFT, -5, 0)
    PatronPreviewDone:SetTexture(Destinations.pinTextures.paths.PatronDone[Destinations.SV.pins.pinTexturePatronDone.type])
    PatronPreviewDone:SetDimensions(Destinations.SV.pins.pinTexturePatronDone.size, Destinations.SV.pins.pinTexturePatronDone.size)
    PatronPreviewDone:SetColor(unpack(Destinations.SV.pins.pinTexturePatronDone.tint))

    WrothgarJumperPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureWrothgarJumper, CT_TEXTURE)
    WrothgarJumperPreview:SetAnchor(RIGHT, previewpinTextureWrothgarJumper.dropdown:GetControl(), LEFT, -40, 0)
    WrothgarJumperPreview:SetTexture(Destinations.pinTextures.paths.WrothgarJumper[Destinations.SV.pins.pinTextureWrothgarJumper.type])
    WrothgarJumperPreview:SetDimensions(Destinations.SV.pins.pinTextureWrothgarJumper.size, Destinations.SV.pins.pinTextureWrothgarJumper.size)
    WrothgarJumperPreview:SetColor(unpack(Destinations.SV.pins.pinTextureWrothgarJumper.tint))

    WrothgarJumperPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureWrothgarJumper, CT_TEXTURE)
    WrothgarJumperPreviewDone:SetAnchor(RIGHT, previewpinTextureWrothgarJumper.dropdown:GetControl(), LEFT, -5, 0)
    WrothgarJumperPreviewDone:SetTexture(Destinations.pinTextures.paths.WrothgarJumperDone[Destinations.SV.pins.pinTextureWrothgarJumperDone.type])
    WrothgarJumperPreviewDone:SetDimensions(Destinations.SV.pins.pinTextureWrothgarJumperDone.size, Destinations.SV.pins.pinTextureWrothgarJumperDone.size)
    WrothgarJumperPreviewDone:SetColor(unpack(Destinations.SV.pins.pinTextureWrothgarJumperDone.tint))

    RelicHunterPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureRelicHunter, CT_TEXTURE)
    RelicHunterPreview:SetAnchor(RIGHT, previewpinTextureRelicHunter.dropdown:GetControl(), LEFT, -40, 0)
    RelicHunterPreview:SetTexture(Destinations.pinTextures.paths.RelicHunter[Destinations.SV.pins.pinTextureRelicHunter.type])
    RelicHunterPreview:SetDimensions(Destinations.SV.pins.pinTextureRelicHunter.size, Destinations.SV.pins.pinTextureRelicHunter.size)
    RelicHunterPreview:SetColor(unpack(Destinations.SV.pins.pinTextureRelicHunter.tint))

    RelicHunterPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureRelicHunter, CT_TEXTURE)
    RelicHunterPreviewDone:SetAnchor(RIGHT, previewpinTextureRelicHunter.dropdown:GetControl(), LEFT, -5, 0)
    RelicHunterPreviewDone:SetTexture(Destinations.pinTextures.paths.RelicHunterDone[Destinations.SV.pins.pinTextureRelicHunterDone.type])
    RelicHunterPreviewDone:SetDimensions(Destinations.SV.pins.pinTextureRelicHunterDone.size, Destinations.SV.pins.pinTextureRelicHunterDone.size)
    RelicHunterPreviewDone:SetColor(unpack(Destinations.SV.pins.pinTextureRelicHunterDone.tint))

    BreakingPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureBreaking, CT_TEXTURE)
    BreakingPreview:SetAnchor(RIGHT, previewpinTextureBreaking.dropdown:GetControl(), LEFT, -40, 0)
    BreakingPreview:SetTexture(Destinations.pinTextures.paths.Breaking[Destinations.SV.pins.pinTextureBreaking.type])
    BreakingPreview:SetDimensions(Destinations.SV.pins.pinTextureBreaking.size, Destinations.SV.pins.pinTextureBreaking.size)
    BreakingPreview:SetColor(unpack(Destinations.SV.pins.pinTextureBreaking.tint))

    BreakingPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureBreaking, CT_TEXTURE)
    BreakingPreviewDone:SetAnchor(RIGHT, previewpinTextureBreaking.dropdown:GetControl(), LEFT, -5, 0)
    BreakingPreviewDone:SetTexture(Destinations.pinTextures.paths.BreakingDone[Destinations.SV.pins.pinTextureBreakingDone.type])
    BreakingPreviewDone:SetDimensions(Destinations.SV.pins.pinTextureBreakingDone.size, Destinations.SV.pins.pinTextureBreakingDone.size)
    BreakingPreviewDone:SetColor(unpack(Destinations.SV.pins.pinTextureBreakingDone.tint))

    CutpursePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureCutpurse, CT_TEXTURE)
    CutpursePreview:SetAnchor(RIGHT, previewpinTextureCutpurse.dropdown:GetControl(), LEFT, -40, 0)
    CutpursePreview:SetTexture(Destinations.pinTextures.paths.Cutpurse[Destinations.SV.pins.pinTextureCutpurse.type])
    CutpursePreview:SetDimensions(Destinations.SV.pins.pinTextureCutpurse.size, Destinations.SV.pins.pinTextureCutpurse.size)
    CutpursePreview:SetColor(unpack(Destinations.SV.pins.pinTextureCutpurse.tint))

    CutpursePreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureCutpurse, CT_TEXTURE)
    CutpursePreviewDone:SetAnchor(RIGHT, previewpinTextureCutpurse.dropdown:GetControl(), LEFT, -5, 0)
    CutpursePreviewDone:SetTexture(Destinations.pinTextures.paths.CutpurseDone[Destinations.SV.pins.pinTextureCutpurseDone.type])
    CutpursePreviewDone:SetDimensions(Destinations.SV.pins.pinTextureCutpurseDone.size, Destinations.SV.pins.pinTextureCutpurseDone.size)
    CutpursePreviewDone:SetColor(unpack(Destinations.SV.pins.pinTextureCutpurseDone.tint))

    AyleidPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureAyleid, CT_TEXTURE)
    AyleidPreview:SetAnchor(RIGHT, previewpinTextureAyleid.dropdown:GetControl(), LEFT, -10, 0)
    AyleidPreview:SetTexture(Destinations.pinTextures.paths.Ayleid[Destinations.SV.pins.pinTextureAyleid.type])
    AyleidPreview:SetDimensions(Destinations.SV.pins.pinTextureAyleid.size, Destinations.SV.pins.pinTextureAyleid.size)
    AyleidPreview:SetColor(unpack(Destinations.SV.pins.pinTextureAyleid.tint))

    DwemerPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureDwemer, CT_TEXTURE)
    DwemerPreview:SetAnchor(RIGHT, previewpinTextureDwemer.dropdown:GetControl(), LEFT, -10, 0)
    DwemerPreview:SetTexture(Destinations.pinTextures.paths.dwemer[Destinations.SV.pins.pinTextureDwemer.type])
    DwemerPreview:SetDimensions(Destinations.SV.pins.pinTextureDwemer.size, Destinations.SV.pins.pinTextureDwemer.size)
    DwemerPreview:SetColor(unpack(Destinations.SV.pins.pinTextureDwemer.tint))

    WWVampPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureWWVamp, CT_TEXTURE)
    WWVampPreview:SetAnchor(RIGHT, previewpinTextureWWVamp.dropdown:GetControl(), LEFT, -10, 0)
    WWVampPreview:SetTexture(Destinations.pinTextures.paths.wwvamp[Destinations.SV.pins.pinTextureWWVamp.type])
    WWVampPreview:SetDimensions(Destinations.SV.pins.pinTextureWWVamp.size, Destinations.SV.pins.pinTextureWWVamp.size)
    WWVampPreview:SetColor(unpack(Destinations.SV.pins.pinTextureWWVamp.tint))

    VampAltarPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureVampAltar, CT_TEXTURE)
    VampAltarPreview:SetAnchor(RIGHT, previewpinTextureVampAltar.dropdown:GetControl(), LEFT, -10, 0)
    VampAltarPreview:SetTexture(Destinations.pinTextures.paths.vampirealtar[Destinations.SV.pins.pinTextureVampAltar.type])
    VampAltarPreview:SetDimensions(Destinations.SV.pins.pinTextureVampAltar.size, Destinations.SV.pins.pinTextureVampAltar.size)
    VampAltarPreview:SetColor(unpack(Destinations.SV.pins.pinTextureVampAltar.tint))

    WWShrinePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureWWShrine, CT_TEXTURE)
    WWShrinePreview:SetAnchor(RIGHT, previewpinTextureWWShrine.dropdown:GetControl(), LEFT, -10, 0)
    WWShrinePreview:SetTexture(Destinations.pinTextures.paths.werewolfshrine[Destinations.SV.pins.pinTextureWWShrine.type])
    WWShrinePreview:SetDimensions(Destinations.SV.pins.pinTextureWWShrine.size, Destinations.SV.pins.pinTextureWWShrine.size)
    WWShrinePreview:SetColor(unpack(Destinations.SV.pins.pinTextureWWShrine.tint))

    CollectiblePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureCollectible, CT_TEXTURE)
    CollectiblePreview:SetAnchor(RIGHT, previewpinTextureCollectible.dropdown:GetControl(), LEFT, -40, 0)
    CollectiblePreview:SetTexture(Destinations.pinTextures.paths.collectible[Destinations.SV.pins.pinTextureCollectible.type])
    CollectiblePreview:SetDimensions(Destinations.SV.pins.pinTextureCollectible.size, Destinations.SV.pins.pinTextureCollectible.size)
    CollectiblePreview:SetColor(unpack(Destinations.SV.pins.pinTextureCollectible.tint))

    CollectibleDonePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureCollectible, CT_TEXTURE)
    CollectibleDonePreview:SetAnchor(RIGHT, previewpinTextureCollectible.dropdown:GetControl(), LEFT, -5, 0)
    CollectibleDonePreview:SetTexture(Destinations.pinTextures.paths.collectibledone[Destinations.SV.pins.pinTextureCollectibleDone.type])
    CollectibleDonePreview:SetDimensions(Destinations.SV.pins.pinTextureCollectibleDone.size, Destinations.SV.pins.pinTextureCollectibleDone.size)
    CollectibleDonePreview:SetColor(unpack(Destinations.SV.pins.pinTextureCollectibleDone.tint))

    FishPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureFish, CT_TEXTURE)
    FishPreview:SetAnchor(RIGHT, previewpinTextureFish.dropdown:GetControl(), LEFT, -40, 0)
    FishPreview:SetTexture(Destinations.pinTextures.paths.fish[Destinations.SV.pins.pinTextureFish.type])
    FishPreview:SetDimensions(Destinations.SV.pins.pinTextureFish.size, Destinations.SV.pins.pinTextureFish.size)
    FishPreview:SetColor(unpack(Destinations.SV.pins.pinTextureFish.tint))

    FishDonePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureFish, CT_TEXTURE)
    FishDonePreview:SetAnchor(RIGHT, previewpinTextureFish.dropdown:GetControl(), LEFT, -5, 0)
    FishDonePreview:SetTexture(Destinations.pinTextures.paths.fishdone[Destinations.SV.pins.pinTextureFishDone.type])
    FishDonePreview:SetDimensions(Destinations.SV.pins.pinTextureFishDone.size, Destinations.SV.pins.pinTextureFishDone.size)
    FishDonePreview:SetColor(unpack(Destinations.SV.pins.pinTextureFishDone.tint))

  end

  local function CreateIcons(panel)
    if panel == settingsPanel then
      CreateAllIconPreviews()
      CALLBACK_MANAGER:UnregisterCallback("LAM-PanelControlsCreated", CreateIcons)
    end
  end
  CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", CreateIcons)

  local optionsTable = {}
  optionsTable[#optionsTable + 1] = { -- Toggle using Account Wide settings
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_USE_ACCOUNTWIDE)),
    tooltip = GetString(DEST_SETTINGS_USE_ACCOUNTWIDE_TT),
    getFunc = function() return Destinations.AWSV.settings.useAccountWide end,
    setFunc = function(state)
      Destinations.AWSV.settings.useAccountWide = state
      ReloadUI()
    end,
    warning = Destinations.defaults.miscColorCodes.settingsTextReloadWarning:Colorize(GetString(DEST_SETTINGS_RELOAD_WARNING)),
    default = Destinations.defaults.settings.useAccountWide,
  }

  local displayName = GetDisplayName()
  local accountData = Destinations_Settings["Default"][displayName]["$AccountWide"]
  if accountData.settings.useAccountWide then
    optionsTable[#optionsTable + 1] = { -- Account wide tip
      type = "description",
      text = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_HEADER)),
    }
  end
  -- POI Improvements submenu
  local poiImprovements = #optionsTable + 1
  optionsTable[poiImprovements] = {
    type = "submenu",
    name = Destinations.defaults.miscColorCodes.settingsTextImprove:Colorize(GetString(DEST_SETTINGS_IMPROVEMENT_HEADER)),
    tooltip = GetString(DEST_SETTINGS_IMPROVEMENT_HEADER_TT),
    controls = {}
  }
  -- Add english name of POI
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_POI_SHOW_ENGLISH),
    tooltip = GetString(DEST_SETTINGS_POI_SHOW_ENGLISH_TT),
    getFunc = function() return Destinations.SV.settings.AddEnglishOnUnknwon end,
    setFunc = function(state) Destinations.SV.settings.AddEnglishOnUnknwon = state end,
    default = Destinations.defaults.settings.AddEnglishOnUnknwon,
    disabled = function() return Destinations.client_lang == "en" end,
  }
  -- Color of English name
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_POI_ENGLISH_COLOR),
    tooltip = GetString(DEST_SETTINGS_POI_ENGLISH_COLOR_TT),
    getFunc = function() return DEST_PIN_TEXT_COLOR_ENGLISH_POI:UnpackRGBA() end,
    setFunc = function(...)
      DEST_PIN_TEXT_COLOR_ENGLISH_POI:SetRGBA(...)
      Destinations.SV.settings.EnglishColorPOI = DEST_PIN_TEXT_COLOR_ENGLISH_POI:ToHex()
    end,
    default = ZO_HIGHLIGHT_TEXT,
    disabled = function() return not Destinations.SV.settings.AddEnglishOnUnknwon end,
  }
  -- Add English name on Keeps
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_POI_SHOW_ENGLISH_KEEPS),
    tooltip = GetString(DEST_SETTINGS_POI_SHOW_ENGLISH_KEEPS_TT),
    getFunc = function() return Destinations.SV.settings.AddEnglishOnKeeps end,
    setFunc = function(state) Destinations.SV.settings.AddEnglishOnKeeps = state end,
    default = Destinations.defaults.settings.AddEnglishOnKeeps,
    disabled = function() return Destinations.client_lang == "en" end,
  }
  -- Color for English name on Keeps
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_COLOR),
    tooltip = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_COLOR_TT),
    getFunc = function() return DEST_PIN_TEXT_COLOR_ENGLISH_KEEP:UnpackRGBA() end,
    setFunc = function(...)
      DEST_PIN_TEXT_COLOR_ENGLISH_KEEP:SetRGBA(...)
      Destinations.SV.settings.EnglishColorKeeps = DEST_PIN_TEXT_COLOR_ENGLISH_KEEP:ToHex()
    end,
    default = ZO_HIGHLIGHT_TEXT,
    disabled = function() return not Destinations.SV.settings.AddEnglishOnKeeps end,
  }
  -- Hide alliance on keep tooltips
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_HA),
    tooltip = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_HA_TT),
    getFunc = function() return Destinations.SV.settings.HideAllianceOnKeeps end,
    setFunc = function(value) Destinations.SV.settings.HideAllianceOnKeeps = value end,
    default = Destinations.defaults.settings.HideAllianceOnKeeps,
    disabled = function() return not Destinations.SV.settings.AddEnglishOnKeeps end,
  }
  -- Add a new line for english name on keep tooltips
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_NL),
    tooltip = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_NL_TT),
    getFunc = function() return Destinations.SV.settings.AddNewLineOnKeeps end,
    setFunc = function(value) Destinations.SV.settings.AddNewLineOnKeeps = value end,
    default = Destinations.defaults.settings.AddNewLineOnKeeps,
    disabled = function() return not Destinations.SV.settings.AddEnglishOnKeeps end,
  }
  -- Improve Mundus POI
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_POI_IMPROVE_MUNDUS),
    tooltip = GetString(DEST_SETTINGS_POI_IMPROVE_MUNDUS_TT),
    getFunc = function() return Destinations.SV.settings.ImproveMundus end,
    setFunc = function(state) Destinations.SV.settings.ImproveMundus = state end,
    default = Destinations.defaults.settings.ImproveMundus,
  }
  -- Improve Crafting Stations POI
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_POI_IMPROVE_CRAFTING),
    tooltip = GetString(DEST_SETTINGS_POI_IMPROVE_CRAFTING_TT),
    getFunc = function() return Destinations.SV.settings.ImproveCrafting end,
    setFunc = function(state) Destinations.SV.settings.ImproveCrafting = state end,
    default = Destinations.defaults.settings.ImproveCrafting,
  }
  -- Points of Interest submenu
  local unknownPointsOfInterest = #optionsTable + 1
  optionsTable[unknownPointsOfInterest] = {
    type = "submenu",
    name = Destinations.defaults.miscColorCodes.settingsTextUnknown:Colorize(GetString(DEST_SETTINGS_POI_HEADER)),
    tooltip = GetString(DEST_SETTINGS_POI_HEADER_TT),
    controls = {}
  }
  -- Unknown pin toggle
  optionsTable[unknownPointsOfInterest].controls[#optionsTable[unknownPointsOfInterest].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_UNKNOWN_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.UNKNOWN] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.UNKNOWN, state)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.UNKNOWN],
  }
  -- Unknown pin style
  optionsTable[unknownPointsOfInterest].controls[#optionsTable[unknownPointsOfInterest].controls + 1] = {
    type = "dropdown",
    name = Destinations.defaults.miscColorCodes.settingsTextUnknown:Colorize(GetString(DEST_SETTINGS_UNKNOWN_PIN_STYLE)),
    reference = "previewpinTextureUnknown",
    choices = Destinations.pinTextures.lists.Unknown,
    getFunc = function() return Destinations.pinTextures.lists.Unknown[Destinations.SV.pins.pinTextureUnknown.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Unknown) do
        if name == selected then
          Destinations.SV.pins.pinTextureUnknown.type = index

          if index == 7 then
            Destinations.SV.pins.pinTextureUnknown.tint = Destinations.defaults.pins.pinTextureUnknown.tint
          else
            Destinations.SV.pins.pinTextureUnknown.tint = Destinations.defaults.pins.pinTextureUnknownOthers.tint
          end

          LMP:SetLayoutKey(Destinations.PIN_TYPES.UNKNOWN, "tint", unpack(Destinations.SV.pins.pinTextureUnknown))

          unknownPoiPreview:SetTexture(Destinations.pinTextures.paths.Unknown[index])
          unknownPoiPreview:SetColor(unpack(Destinations.SV.pins.pinTextureUnknown.tint))

          Destinations:OnPOIUpdated()

          break
        end
      end
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.UNKNOWN] end,
    default = Destinations.pinTextures.lists.Unknown[Destinations.defaults.pins.pinTextureUnknown.type],
  }
  -- Unknown pin size
  optionsTable[unknownPointsOfInterest].controls[#optionsTable[unknownPointsOfInterest].controls + 1] = {
    type = "slider",
    name = Destinations.defaults.miscColorCodes.settingsTextUnknown:Colorize(GetString(DEST_SETTINGS_UNKNOWN_PIN_SIZE)),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureUnknown.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureUnknown.size = size
      unknownPoiPreview:SetDimensions(size, size)
      SetUnknownDestLayoutKey("size", size)
      Destinations:OnPOIUpdated()
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.UNKNOWN] end,
    default = Destinations.defaults.pins.pinTextureUnknown.size
  }
  -- Unknown pin layer
  optionsTable[unknownPointsOfInterest].controls[#optionsTable[unknownPointsOfInterest].controls + 1] = {
    type = "slider",
    name = Destinations.defaults.miscColorCodes.settingsTextUnknown:Colorize(GetString(DEST_SETTINGS_UNKNOWN_PIN_LAYER)),
    min = 10,
    max = 200,
    step = 5,
    getFunc = function() return Destinations.SV.pins.pinTextureUnknown.level end,
    setFunc = function(level)
      Destinations.SV.pins.pinTextureUnknown.level = level
      SetUnknownDestLayoutKey("level", level)
      Destinations:OnPOIUpdated()
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.UNKNOWN] end,
    default = Destinations.defaults.pins.pinTextureUnknown.level
  }
  -- Unknown pin text color
  optionsTable[unknownPointsOfInterest].controls[#optionsTable[unknownPointsOfInterest].controls + 1] = {
    type = "colorpicker",
    name = Destinations.defaults.miscColorCodes.settingsTextUnknown:Colorize(GetString(DEST_SETTINGS_UNKNOWN_COLOR)),
    tooltip = GetString(DEST_SETTINGS_UNKNOWN_COLOR_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureUnknown.textcolor) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureUnknown.textcolor = { r, g, b }
      Destinations:OnPOIUpdated()
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.UNKNOWN] end,
    default = { r = Destinations.defaults.pins.pinTextureUnknown.textcolor[1], g = Destinations.defaults.pins.pinTextureUnknown.textcolor[2], b = Destinations.defaults.pins.pinTextureUnknown.textcolor[3] }
  }
  -- Achievements submenu
  local achievements = #optionsTable + 1
  optionsTable[achievements] = {
    type = "submenu",
    name = Destinations.defaults.miscColorCodes.settingsTextAchievements:Colorize(GetString(DEST_SETTINGS_ACH_HEADER)),
    tooltip = GetString(DEST_SETTINGS_ACH_HEADER_TT),
    controls = { }
  }
  -- Champion Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_CHAMPION_PIN_HEADER)),
  }
  -- Champion global pin toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.CHAMPION, state)
      RedrawAllPins(Destinations.PIN_TYPES.CHAMPION)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.CHAMPION],
  }
  -- Champion Done global pin toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION_DONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.CHAMPION_DONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.CHAMPION_DONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.CHAMPION_DONE],
  }
  -- Champion zone pin toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_ACH_CHAMPION_ZONE_PIN_TOGGLE),
    getFunc = function() return Destinations.SV.settings.ShowDungeonBossesInZones end,
    setFunc = function(state)
      Destinations.SV.settings.ShowDungeonBossesInZones = state
      RedrawAllPins(Destinations.PIN_TYPES.CHAMPION)
      RedrawAllPins(Destinations.PIN_TYPES.CHAMPION_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION_DONE]
    end,
    default = Destinations.defaults.settings.ShowDungeonBossesInZones,
  }
  -- Champion zone pin to front/back
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_ACH_CHAMPION_FRONT_PIN_TOGGLE),
    tooltip = GetString(DEST_SETTINGS_ACH_CHAMPION_FRONT_PIN_TOGGLE_TT),
    getFunc = function() return Destinations.SV.settings.ShowDungeonBossesOnTop end,
    setFunc = function(state)
      local pinLevel = Destinations.SV.pins.pinTextureOther.level or Destinations.defaults.pins.pinTextureOther.level
      if state == true then
        Destinations.SV.pins.pinTextureChampion.level = pinLevel + DESTINATIONS_PIN_PRIORITY_OFFSET
        Destinations.SV.pins.pinTextureChampionDone.level = pinLevel
        LMP:SetLayoutKey(Destinations.PIN_TYPES.CHAMPION, "level", pinLevel + DESTINATIONS_PIN_PRIORITY_OFFSET)
        LMP:SetLayoutKey(Destinations.PIN_TYPES.CHAMPION_DONE, "level", pinLevel)
      else
        DestinationsSV.pins.pinTextureChampion.level = 30 + DESTINATIONS_PIN_PRIORITY_OFFSET
        DestinationsSV.pins.pinTextureChampionDone.level = 30
        LMP:SetLayoutKey(DPINS.CHAMPION, "level", 30 + DESTINATIONS_PIN_PRIORITY_OFFSET)
        LMP:SetLayoutKey(DPINS.CHAMPION_DONE, "level", 30)
      end
      Destinations.SV.settings.ShowDungeonBossesOnTop = state
      RedrawAllPins(Destinations.PIN_TYPES.CHAMPION)
      RedrawAllPins(Destinations.PIN_TYPES.CHAMPION_DONE)
    end,
    disabled = function() return
    (not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION_DONE]) or
      not Destinations.SV.settings.ShowDungeonBossesInZones
    end,
    default = Destinations.defaults.settings.ShowDungeonBossesOnTop,
  }
  -- Champion pin style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
    reference = "previewpinTextureChampion",
    choices = Destinations.pinTextures.lists.Champion,
    getFunc = function() return Destinations.pinTextures.lists.Champion[Destinations.SV.pins.pinTextureChampion.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Champion) do
        if name == selected then
          Destinations.SV.pins.pinTextureChampion.type = index
          Destinations.SV.pins.pinTextureChampionDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.CHAMPION, "texture", Destinations.pinTextures.paths.Champion[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.CHAMPION_DONE, "texture", Destinations.pinTextures.paths.ChampionDone[index])
          ChampionPreview:SetTexture(Destinations.pinTextures.paths.Champion[index])
          ChampionPreviewDone:SetTexture(Destinations.pinTextures.paths.ChampionDone[index])
          RedrawAllPins(Destinations.PIN_TYPES.CHAMPION)
          RedrawAllPins(Destinations.PIN_TYPES.CHAMPION_DONE)
          break
        end
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION_DONE]
    end,
    default = Destinations.pinTextures.lists.Champion[Destinations.defaults.pins.pinTextureChampion.type],
  }
  -- Champion pin size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureChampion.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureChampion.size = size
      Destinations.SV.pins.pinTextureChampionDone.size = size
      ChampionPreview:SetDimensions(size, size)
      ChampionPreviewDone:SetDimensions(size, size)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.CHAMPION, "size", size)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.CHAMPION_DONE, "size", size)
      RedrawAllPins(Destinations.PIN_TYPES.CHAMPION)
      RedrawAllPins(Destinations.PIN_TYPES.CHAMPION_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION_DONE]
    end,
    default = Destinations.defaults.pins.pinTextureChampion.size
  }
  -- Achievement Other Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_OTHER_HEADER)),
  }
  -- Achievement Other Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.LB_GTTP_CP, state)
      RedrawAllPins(Destinations.PIN_TYPES.LB_GTTP_CP)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.LB_GTTP_CP],
  }
  -- Achievement Other Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP_DONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.LB_GTTP_CP_DONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.LB_GTTP_CP_DONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.LB_GTTP_CP_DONE],
  }
  -- Achievement Other Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
    reference = "previewpinTextureOther",
    choices = Destinations.pinTextures.lists.Other,
    getFunc = function() return Destinations.pinTextures.lists.Other[Destinations.SV.pins.pinTextureOther.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Other) do
        if name == selected then
          Destinations.SV.pins.pinTextureOther.type = index
          Destinations.SV.pins.pinTextureOtherDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.LB_GTTP_CP, "texture", Destinations.pinTextures.paths.Other[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.LB_GTTP_CP_DONE, "texture", Destinations.pinTextures.paths.OtherDone[index])
          otherPreview:SetTexture(Destinations.pinTextures.paths.Other[index])
          otherPreviewDone:SetTexture(Destinations.pinTextures.paths.OtherDone[index])
          RedrawAllPins(Destinations.PIN_TYPES.LB_GTTP_CP)
          RedrawAllPins(Destinations.PIN_TYPES.LB_GTTP_CP_DONE)
          break
        end
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP_DONE]
    end,
    default = Destinations.pinTextures.lists.Other[Destinations.defaults.pins.pinTextureOther.type],
  }
  -- Achievement Other size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureOther.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureOther.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.LB_GTTP_CP, "size", size)
      otherPreview:SetDimensions(size, size)
      Destinations.SV.pins.pinTextureOtherDone.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.LB_GTTP_CP_DONE, "size", size)
      otherPreviewDone:SetDimensions(size, size)
      RedrawAllPins(Destinations.PIN_TYPES.LB_GTTP_CP)
      RedrawAllPins(Destinations.PIN_TYPES.LB_GTTP_CP_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP_DONE]
    end,
    default = Destinations.defaults.pins.pinTextureOther.size
  }
  -- Achievement M'aiq Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_MAIQ_HEADER)),
  }
  -- Achievement M'aiq Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.MAIQ, state)
      RedrawAllPins(Destinations.PIN_TYPES.MAIQ)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.MAIQ],
  }
  -- Achievement M'aiq Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ_DONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.MAIQ_DONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.MAIQ_DONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.MAIQ_DONE],
  }
  -- Achievement M'aiq Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
    reference = "previewpinTextureMaiq",
    choices = Destinations.pinTextures.lists.Maiq,
    getFunc = function() return Destinations.pinTextures.lists.Maiq[Destinations.SV.pins.pinTextureMaiq.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Maiq) do
        if name == selected then
          Destinations.SV.pins.pinTextureMaiq.type = index
          Destinations.SV.pins.pinTextureMaiqDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.MAIQ, "texture", Destinations.pinTextures.paths.Maiq[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.MAIQ_DONE, "texture", Destinations.pinTextures.paths.MaiqDone[index])
          MaiqPreview:SetTexture(Destinations.pinTextures.paths.Maiq[index])
          MaiqPreviewDone:SetTexture(Destinations.pinTextures.paths.MaiqDone[index])
          RedrawAllPins(Destinations.PIN_TYPES.MAIQ)
          RedrawAllPins(Destinations.PIN_TYPES.MAIQ_DONE)
          break
        end
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ_DONE]
    end,
    default = Destinations.pinTextures.lists.Maiq[Destinations.defaults.pins.pinTextureMaiq.type],
  }
  -- Achievement M'aiq Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureMaiq.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureMaiq.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.MAIQ, "size", size)
      MaiqPreview:SetDimensions(size, size)
      Destinations.SV.pins.pinTextureMaiqDone.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.MAIQ_DONE, "size", size)
      MaiqPreviewDone:SetDimensions(size, size)
      RedrawAllPins(Destinations.PIN_TYPES.MAIQ)
      RedrawAllPins(Destinations.PIN_TYPES.MAIQ_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ_DONE]
    end,
    default = Destinations.defaults.pins.pinTextureMaiq.size
  }
  -- Achievement Peacemaker Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_PEACEMAKER_HEADER)),
  }
  -- Achievement Peacemaker Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.PEACEMAKER, state)
      RedrawAllPins(Destinations.PIN_TYPES.PEACEMAKER)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.PEACEMAKER],
  }
  -- Achievement Peacemaker Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER_DONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.PEACEMAKER_DONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.PEACEMAKER_DONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.PEACEMAKER_DONE],
  }
  -- Achievement Peacemaker Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
    reference = "previewpinTexturePeacemaker",
    choices = Destinations.pinTextures.lists.Peacemaker,
    getFunc = function() return Destinations.pinTextures.lists.Peacemaker[Destinations.SV.pins.pinTexturePeacemaker.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Peacemaker) do
        if name == selected then
          Destinations.SV.pins.pinTexturePeacemaker.type = index
          Destinations.SV.pins.pinTexturePeacemakerDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.PEACEMAKER, "texture", Destinations.pinTextures.paths.Peacemaker[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.PEACEMAKER_DONE, "texture", Destinations.pinTextures.paths.PeacemakerDone[index])
          PeacemakerPreview:SetTexture(Destinations.pinTextures.paths.Peacemaker[index])
          PeacemakerPreviewDone:SetTexture(Destinations.pinTextures.paths.PeacemakerDone[index])
          RedrawAllPins(Destinations.PIN_TYPES.PEACEMAKER)
          RedrawAllPins(Destinations.PIN_TYPES.PEACEMAKER_DONE)
          break
        end
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER_DONE]
    end,
    default = Destinations.pinTextures.lists.Peacemaker[Destinations.defaults.pins.pinTexturePeacemaker.type],
  }
  -- Achievement Peacemaker Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTexturePeacemaker.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTexturePeacemaker.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.PEACEMAKER, "size", size)
      PeacemakerPreview:SetDimensions(size, size)
      Destinations.SV.pins.pinTexturePeacemakerDone.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.PEACEMAKER_DONE, "size", size)
      PeacemakerPreviewDone:SetDimensions(size, size)
      RedrawAllPins(Destinations.PIN_TYPES.PEACEMAKER)
      RedrawAllPins(Destinations.PIN_TYPES.PEACEMAKER_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER_DONE]
    end,
    default = Destinations.defaults.pins.pinTexturePeacemaker.size
  }
  -- Achievement Nosediver Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_NOSEDIVER_HEADER)),
  }
  -- Achievement Nosediver Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.NOSEDIVER, state)
      RedrawAllPins(Destinations.PIN_TYPES.NOSEDIVER)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.NOSEDIVER],
  }
  -- Achievement Nosediver Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER_DONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.NOSEDIVER_DONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.NOSEDIVER_DONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.NOSEDIVER_DONE],
  }
  -- Achievement Nosediver Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
    reference = "previewpinTextureNosediver",
    choices = Destinations.pinTextures.lists.Nosediver,
    getFunc = function() return Destinations.pinTextures.lists.Nosediver[Destinations.SV.pins.pinTextureNosediver.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Nosediver) do
        if name == selected then
          Destinations.SV.pins.pinTextureNosediver.type = index
          Destinations.SV.pins.pinTextureNosediverDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.NOSEDIVER, "texture", Destinations.pinTextures.paths.Nosediver[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.NOSEDIVER_DONE, "texture", Destinations.pinTextures.paths.NosediverDone[index])
          NosediverPreview:SetTexture(Destinations.pinTextures.paths.Nosediver[index])
          NosediverPreviewDone:SetTexture(Destinations.pinTextures.paths.NosediverDone[index])
          RedrawAllPins(Destinations.PIN_TYPES.NOSEDIVER)
          RedrawAllPins(Destinations.PIN_TYPES.NOSEDIVER_DONE)
          break
        end
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER_DONE]
    end,
    default = Destinations.pinTextures.lists.Nosediver[Destinations.defaults.pins.pinTextureNosediver.type],
  }
  -- Achievement Nosediver Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureNosediver.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureNosediver.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.NOSEDIVER, "size", size)
      NosediverPreview:SetDimensions(size, size)
      Destinations.SV.pins.pinTextureNosediverDone.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.NOSEDIVER_DONE, "size", size)
      NosediverPreviewDone:SetDimensions(size, size)
      RedrawAllPins(Destinations.PIN_TYPES.NOSEDIVER)
      RedrawAllPins(Destinations.PIN_TYPES.NOSEDIVER_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER_DONE]
    end,
    default = Destinations.defaults.pins.pinTextureNosediver.size
  }
  -- Achievement Earthly Possesion Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_EARTHLYPOS_HEADER)),
  }
  -- Achievement Earthly Possesion Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.EARTHLYPOS, state)
      RedrawAllPins(Destinations.PIN_TYPES.EARTHLYPOS)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.EARTHLYPOS],
  }
  -- Achievement Earthly Possesion Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS_DONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.EARTHLYPOS_DONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.EARTHLYPOS_DONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.EARTHLYPOS_DONE],
  }
  -- Achievement Earthly Possesion Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
    reference = "previewpinTextureEarthlyPos",
    choices = Destinations.pinTextures.lists.EarthlyPos,
    getFunc = function() return Destinations.pinTextures.lists.EarthlyPos[Destinations.SV.pins.pinTextureEarthlyPos.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.EarthlyPos) do
        if name == selected then
          Destinations.SV.pins.pinTextureEarthlyPos.type = index
          Destinations.SV.pins.pinTextureEarthlyPosDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.EARTHLYPOS, "texture", Destinations.pinTextures.paths.Earthlypos[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.EARTHLYPOS_DONE, "texture", Destinations.pinTextures.paths.EarthlyposDone[index])
          EarthlyPosPreview:SetTexture(Destinations.pinTextures.paths.Earthlypos[index])
          EarthlyPosPreviewDone:SetTexture(Destinations.pinTextures.paths.EarthlyposDone[index])
          RedrawAllPins(Destinations.PIN_TYPES.EARTHLYPOS)
          RedrawAllPins(Destinations.PIN_TYPES.EARTHLYPOS_DONE)
          break
        end
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS_DONE]
    end,
    default = Destinations.pinTextures.lists.Nosediver[Destinations.defaults.pins.pinTextureNosediver.type],
  }
  -- Achievement Earthly Possesion Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureEarthlyPos.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureEarthlyPos.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.EARTHLYPOS, "size", size)
      EarthlyPosPreview:SetDimensions(size, size)
      Destinations.SV.pins.pinTextureEarthlyPosDone.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.EARTHLYPOS_DONE, "size", size)
      EarthlyPosPreviewDone:SetDimensions(size, size)
      RedrawAllPins(Destinations.PIN_TYPES.EARTHLYPOS)
      RedrawAllPins(Destinations.PIN_TYPES.EARTHLYPOS_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS_DONE]
    end,
    default = Destinations.defaults.pins.pinTextureEarthlyPos.size
  }
  -- Achievement This One's on Me Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_ON_ME_HEADER)),
  }
  -- Achievement This One's on Me Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.ON_ME, state)
      RedrawAllPins(Destinations.PIN_TYPES.ON_ME)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.ON_ME],
  }
  -- Achievement This One's on Me Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME_DONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.ON_ME_DONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.ON_ME_DONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.ON_ME_DONE],
  }
  -- Achievement This One's on Me Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
    reference = "previewpinTextureOnMe",
    choices = Destinations.pinTextures.lists.OnMe,
    getFunc = function() return Destinations.pinTextures.lists.OnMe[Destinations.SV.pins.pinTextureOnMe.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.OnMe) do
        if name == selected then
          Destinations.SV.pins.pinTextureOnMe.type = index
          Destinations.SV.pins.pinTextureOnMeDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.ON_ME, "texture", Destinations.pinTextures.paths.OnMe[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.ON_ME_DONE, "texture", Destinations.pinTextures.paths.OnMeDone[index])
          OnMePreview:SetTexture(Destinations.pinTextures.paths.OnMe[index])
          OnMePreviewDone:SetTexture(Destinations.pinTextures.paths.OnMeDone[index])
          RedrawAllPins(Destinations.PIN_TYPES.ON_ME)
          RedrawAllPins(Destinations.PIN_TYPES.ON_ME_DONE)
          break
        end
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME_DONE]
    end,
    default = Destinations.pinTextures.lists.OnMe[Destinations.defaults.pins.pinTextureOnMe.type],
  }
  -- Achievement This One's on Me Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureOnMe.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureOnMe.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.ON_ME, "size", size)
      OnMePreview:SetDimensions(size, size)
      Destinations.SV.pins.pinTextureOnMeDone.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.ON_ME_DONE, "size", size)
      OnMePreviewDone:SetDimensions(size, size)
      RedrawAllPins(Destinations.PIN_TYPES.ON_ME)
      RedrawAllPins(Destinations.PIN_TYPES.ON_ME_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME_DONE]
    end,
    default = Destinations.defaults.pins.pinTextureOnMe.size
  }
  -- Achievement One Last Brawl Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_BRAWL_HEADER)),
  }
  -- Achievement One Last Brawl Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.BRAWL, state)
      RedrawAllPins(Destinations.PIN_TYPES.BRAWL)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.BRAWL],
  }
  -- Achievement One Last Brawl Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL_DONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.BRAWL_DONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.BRAWL_DONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.BRAWL_DONE],
  }
  -- Achievement One Last Brawl Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
    reference = "previewpinTextureBrawl",
    choices = Destinations.pinTextures.lists.Brawl,
    getFunc = function() return Destinations.pinTextures.lists.Brawl[Destinations.SV.pins.pinTextureBrawl.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Brawl) do
        if name == selected then
          Destinations.SV.pins.pinTextureBrawl.type = index
          Destinations.SV.pins.pinTextureBrawlDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.BRAWL, "texture", Destinations.pinTextures.paths.Brawl[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.BRAWL_DONE, "texture", Destinations.pinTextures.paths.BrawlDone[index])
          BrawlPreview:SetTexture(Destinations.pinTextures.paths.Brawl[index])
          BrawlPreviewDone:SetTexture(Destinations.pinTextures.paths.BrawlDone[index])
          RedrawAllPins(Destinations.PIN_TYPES.BRAWL)
          RedrawAllPins(Destinations.PIN_TYPES.BRAWL_DONE)
          break
        end
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL_DONE]
    end,
    default = Destinations.pinTextures.lists.Brawl[Destinations.defaults.pins.pinTextureBrawl.type],
  }
  -- Achievement One Last Brawl Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureBrawl.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureBrawl.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.BRAWL, "size", size)
      BrawlPreview:SetDimensions(size, size)
      Destinations.SV.pins.pinTextureBrawlDone.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.BRAWL_DONE, "size", size)
      BrawlPreviewDone:SetDimensions(size, size)
      RedrawAllPins(Destinations.PIN_TYPES.BRAWL)
      RedrawAllPins(Destinations.PIN_TYPES.BRAWL_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL_DONE]
    end,
    default = Destinations.defaults.pins.pinTextureBrawl.size
  }
  -- Achievement Orsinium Patron Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_PATRON_HEADER)),
  }
  -- Achievement Orsinium Patron Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.PATRON, state)
      RedrawAllPins(Destinations.PIN_TYPES.PATRON)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.PATRON],
  }
  -- Achievement Orsinium Patron Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON_DONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.PATRON_DONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.PATRON_DONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.PATRON_DONE],
  }
  -- Achievement Orsinium Patron Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
    reference = "previewpinTexturePatron",
    choices = Destinations.pinTextures.lists.Patron,
    getFunc = function() return Destinations.pinTextures.lists.Patron[Destinations.SV.pins.pinTexturePatron.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Patron) do
        if name == selected then
          Destinations.SV.pins.pinTexturePatron.type = index
          Destinations.SV.pins.pinTexturePatronDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.PATRON, "texture", Destinations.pinTextures.paths.Patron[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.PATRON_DONE, "texture", Destinations.pinTextures.paths.PatronDone[index])
          PatronPreview:SetTexture(Destinations.pinTextures.paths.Patron[index])
          PatronPreviewDone:SetTexture(Destinations.pinTextures.paths.PatronDone[index])
          RedrawAllPins(Destinations.PIN_TYPES.PATRON)
          RedrawAllPins(Destinations.PIN_TYPES.PATRON_DONE)
          break
        end
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON_DONE]
    end,
    default = Destinations.pinTextures.lists.Patron[Destinations.defaults.pins.pinTexturePatron.type],
  }
  -- Achievement Orsinium Patron Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTexturePatron.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTexturePatron.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.PATRON, "size", size)
      PatronPreview:SetDimensions(size, size)
      Destinations.SV.pins.pinTexturePatronDone.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.PATRON_DONE, "size", size)
      PatronPreviewDone:SetDimensions(size, size)
      RedrawAllPins(Destinations.PIN_TYPES.PATRON)
      RedrawAllPins(Destinations.PIN_TYPES.PATRON_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON_DONE]
    end,
    default = Destinations.defaults.pins.pinTexturePatron.size
  }
  -- Achievement Wrothgar Cliff Jumper Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_WROTHGAR_JUMPER_HEADER)),
  }
  -- Achievement Wrothgar Cliff Jumper Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.WROTHGAR_JUMPER, state)
      RedrawAllPins(Destinations.PIN_TYPES.WROTHGAR_JUMPER)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER],
  }
  -- Achievement Wrothgar Cliff Jumper Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE],
  }
  -- Achievement Wrothgar Cliff Jumper Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
    reference = "previewpinTextureWrothgarJumper",
    choices = Destinations.pinTextures.lists.WrothgarJumper,
    getFunc = function() return Destinations.pinTextures.lists.WrothgarJumper[Destinations.SV.pins.pinTextureWrothgarJumper.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.WrothgarJumper) do
        if name == selected then
          Destinations.SV.pins.pinTextureWrothgarJumper.type = index
          Destinations.SV.pins.pinTextureWrothgarJumperDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.WROTHGAR_JUMPER, "texture", Destinations.pinTextures.paths.WrothgarJumper[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE, "texture", Destinations.pinTextures.paths.WrothgarJumperDone[index])
          WrothgarJumperPreview:SetTexture(Destinations.pinTextures.paths.WrothgarJumper[index])
          WrothgarJumperPreviewDone:SetTexture(Destinations.pinTextures.paths.WrothgarJumperDone[index])
          RedrawAllPins(Destinations.PIN_TYPES.WROTHGAR_JUMPER)
          RedrawAllPins(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE)
          break
        end
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE]
    end,
    default = Destinations.pinTextures.lists.WrothgarJumper[Destinations.defaults.pins.pinTextureWrothgarJumper.type],
  }
  -- Achievement Wrothgar Cliff Jumper Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureWrothgarJumper.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureWrothgarJumper.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.WROTHGAR_JUMPER, "size", size)
      WrothgarJumperPreview:SetDimensions(size, size)
      Destinations.SV.pins.pinTextureWrothgarJumperDone.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE, "size", size)
      WrothgarJumperPreviewDone:SetDimensions(size, size)
      RedrawAllPins(Destinations.PIN_TYPES.WROTHGAR_JUMPER)
      RedrawAllPins(Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE]
    end,
    default = Destinations.defaults.pins.pinTextureWrothgarJumper.size
  }
  -- Achievement Wrothgar Master Relic Hunter Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_RELIC_HUNTER_HEADER)),
  }
  -- Achievement Wrothgar Master Relic Hunter Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.RELIC_HUNTER, state)
      RedrawAllPins(Destinations.PIN_TYPES.RELIC_HUNTER)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.RELIC_HUNTER],
  }
  -- Achievement Wrothgar Master Relic Hunter Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER_DONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.RELIC_HUNTER_DONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.RELIC_HUNTER_DONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.RELIC_HUNTER_DONE],
  }
  -- Achievement Wrothgar Master Relic Hunter Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
    reference = "previewpinTextureRelicHunter",
    choices = Destinations.pinTextures.lists.RelicHunter,
    getFunc = function() return Destinations.pinTextures.lists.RelicHunter[Destinations.SV.pins.pinTextureRelicHunter.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.RelicHunter) do
        if name == selected then
          Destinations.SV.pins.pinTextureRelicHunter.type = index
          Destinations.SV.pins.pinTextureRelicHunterDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.RELIC_HUNTER, "texture", Destinations.pinTextures.paths.RelicHunter[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.RELIC_HUNTER_DONE, "texture", Destinations.pinTextures.paths.RelicHunterDone[index])
          RelicHunterPreview:SetTexture(Destinations.pinTextures.paths.RelicHunter[index])
          RelicHunterPreviewDone:SetTexture(Destinations.pinTextures.paths.RelicHunterDone[index])
          RedrawAllPins(Destinations.PIN_TYPES.RELIC_HUNTER)
          RedrawAllPins(Destinations.PIN_TYPES.RELIC_HUNTER_DONE)
          break
        end
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER_DONE]
    end,
    default = Destinations.pinTextures.lists.RelicHunter[Destinations.defaults.pins.pinTextureRelicHunter.type],
  }
  -- Achievement Wrothgar Master Relic Hunter Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureRelicHunter.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureRelicHunter.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.RELIC_HUNTER, "size", size)
      RelicHunterPreview:SetDimensions(size, size)
      Destinations.SV.pins.pinTextureRelicHunterDone.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.RELIC_HUNTER_DONE, "size", size)
      RelicHunterPreviewDone:SetDimensions(size, size)
      RedrawAllPins(Destinations.PIN_TYPES.RELIC_HUNTER)
      RedrawAllPins(Destinations.PIN_TYPES.RELIC_HUNTER_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER_DONE]
    end,
    default = Destinations.defaults.pins.pinTextureRelicHunter.size
  }
  -- Achievement Breaking and Entering Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_BREAKING_HEADER)),
  }
  -- Achievement Breaking and Entering Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.BREAKING] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.BREAKING, state)
      RedrawAllPins(Destinations.PIN_TYPES.BREAKING)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.BREAKING],
  }
  -- Achievement Breaking and Entering Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.BREAKING_DONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.BREAKING_DONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.BREAKING_DONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.BREAKING_DONE],
  }
  -- Achievement Breaking and Entering Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
    reference = "previewpinTextureBreaking",
    choices = Destinations.pinTextures.lists.Breaking,
    getFunc = function() return Destinations.pinTextures.lists.Breaking[Destinations.SV.pins.pinTextureBreaking.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Breaking) do
        if name == selected then
          Destinations.SV.pins.pinTextureBreaking.type = index
          Destinations.SV.pins.pinTextureBreakingDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.BREAKING, "texture", Destinations.pinTextures.paths.Breaking[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.BREAKING_DONE, "texture", Destinations.pinTextures.paths.BreakingDone[index])
          BreakingPreview:SetTexture(Destinations.pinTextures.paths.Breaking[index])
          BreakingPreviewDone:SetTexture(Destinations.pinTextures.paths.BreakingDone[index])
          RedrawAllPins(Destinations.PIN_TYPES.BREAKING)
          RedrawAllPins(Destinations.PIN_TYPES.BREAKING_DONE)
          break
        end
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.BREAKING] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BREAKING_DONE]
    end,
    default = Destinations.pinTextures.lists.Breaking[Destinations.defaults.pins.pinTextureBreaking.type],
  }
  -- Achievement Breaking and Entering Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureBreaking.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureBreaking.size = size
      Destinations.SV.pins.pinTextureBreakingDone.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.BREAKING, "size", size)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.BREAKING_DONE, "size", size)
      BreakingPreview:SetDimensions(size, size)
      BreakingPreviewDone:SetDimensions(size, size)
      RedrawAllPins(Destinations.PIN_TYPES.BREAKING)
      RedrawAllPins(Destinations.PIN_TYPES.BREAKING_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.BREAKING] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BREAKING_DONE]
    end,
    default = Destinations.defaults.pins.pinTextureBreaking.size
  }
  -- Achievement A Cutpurse Above Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_CUTPURSE_HEADER)),
  }
  -- Achievement A Cutpurse Above Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.CUTPURSE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.CUTPURSE, state)
      RedrawAllPins(Destinations.PIN_TYPES.CUTPURSE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.CUTPURSE],
  }
  -- Achievement A Cutpurse Above Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.CUTPURSE_DONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.CUTPURSE_DONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.CUTPURSE_DONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.CUTPURSE_DONE],
  }
  -- Achievement A Cutpurse Above Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_ACH_PIN_STYLE),
    reference = "previewpinTextureCutpurse",
    choices = Destinations.pinTextures.lists.Cutpurse,
    getFunc = function() return Destinations.pinTextures.lists.Cutpurse[Destinations.SV.pins.pinTextureCutpurse.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Cutpurse) do
        if name == selected then
          Destinations.SV.pins.pinTextureCutpurse.type = index
          Destinations.SV.pins.pinTextureCutpurseDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.CUTPURSE, "texture", Destinations.pinTextures.paths.Cutpurse[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.CUTPURSE_DONE, "texture", Destinations.pinTextures.paths.CutpurseDone[index])
          CutpursePreview:SetTexture(Destinations.pinTextures.paths.Cutpurse[index])
          CutpursePreviewDone:SetTexture(Destinations.pinTextures.paths.CutpurseDone[index])
          RedrawAllPins(Destinations.PIN_TYPES.CUTPURSE)
          RedrawAllPins(Destinations.PIN_TYPES.CUTPURSE_DONE)
          break
        end
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.CUTPURSE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CUTPURSE_DONE]
    end,
    default = Destinations.pinTextures.lists.Cutpurse[Destinations.defaults.pins.pinTextureCutpurse.type],
  }
  -- Achievement A Cutpurse Above Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureCutpurse.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureCutpurse.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.CUTPURSE, "size", size)
      CutpursePreview:SetDimensions(size, size)
      Destinations.SV.pins.pinTextureCutpurseDone.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.CUTPURSE_DONE, "size", size)
      CutpursePreviewDone:SetDimensions(size, size)
      RedrawAllPins(Destinations.PIN_TYPES.CUTPURSE)
      RedrawAllPins(Destinations.PIN_TYPES.CUTPURSE_DONE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.CUTPURSE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CUTPURSE_DONE]
    end,
    default = Destinations.defaults.pins.pinTextureCutpurse.size
  }
  local achievementPositionsGlobal = #optionsTable + 1
  optionsTable[achievementPositionsGlobal] = { -- Misc POIs submenu
    type = "submenu",
    name = Destinations.defaults.miscColorCodes.settingsTextMiscellaneous:Colorize(GetString(DEST_SETTINGS_ACH_GLOBAL_HEADER)),
    tooltip = GetString(DEST_SETTINGS_ACH_GLOBAL_HEADER_TT),
    controls = { }
  }
  -- Achievement All Pin Layer
  optionsTable[achievementPositionsGlobal].controls[#optionsTable[achievementPositionsGlobal].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_ALL_PIN_LAYER),
    min = 10,
    max = 200,
    step = 5,
    getFunc = function() return Destinations.SV.pins.pinTextureOther.level end,
    setFunc = function(level)
      for _, pinName in pairs(Destinations.drtv.AchPinTex) do
        Destinations.SV.pins[pinName].level = level + DESTINATIONS_PIN_PRIORITY_OFFSET
        pinName = pinName .. "Done"
        Destinations.SV.pins[pinName].level = level
      end
      for _, pinName in pairs(Destinations.drtv.AchPins) do
        LMP:SetLayoutKey(Destinations.PIN_TYPES[pinName], "level", level + DESTINATIONS_PIN_PRIORITY_OFFSET)
        pinName = pinName .. "_DONE"
        LMP:SetLayoutKey(Destinations.PIN_TYPES[pinName], "level", level)
      end
      Destinations.SV.pins.pinTextureOther.level = level
      RedrawAllAchievementPins()
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION_DONE]
    end,
    default = Destinations.defaults.pins.pinTextureOther.level
  }
  -- Achievement All Undone pin color
  optionsTable[achievementPositionsGlobal].controls[#optionsTable[achievementPositionsGlobal].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_ACH_PIN_COLOR_MISS),
    tooltip = GetString(DEST_SETTINGS_ACH_PIN_COLOR_MISS_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureOther.tint) end,
    setFunc = function(r, g, b, a)
      Destinations.SV.pins.pinTextureOther.tint = { r, g, b, a }
      DEST_PIN_TINT_OTHER:SetRGBA(r, g, b, a)

      for _, pinName in pairs(Destinations.drtv.AchPinTex) do
        Destinations.SV.pins[pinName].tint = { r, g, b, a }
      end
      for _, pinName in pairs(Destinations.drtv.AchPins) do
        LMP:SetLayoutKey(Destinations.PIN_TYPES[pinName], "tint", DEST_PIN_TINT_OTHER)
        RedrawAllPins(Destinations.PIN_TYPES[pinName])
      end

      MaiqPreview:SetColor(r, g, b, a)
      otherPreview:SetColor(r, g, b, a)
      PeacemakerPreview:SetColor(r, g, b, a)
      NosediverPreview:SetColor(r, g, b, a)
      EarthlyPosPreview:SetColor(r, g, b, a)
      OnMePreview:SetColor(r, g, b, a)
      BrawlPreview:SetColor(r, g, b, a)
      PatronPreview:SetColor(r, g, b, a)
      WrothgarJumperPreview:SetColor(r, g, b, a)
      ChampionPreview:SetColor(r, g, b, a)
      RelicHunterPreview:SetColor(r, g, b, a)
      BreakingPreview:SetColor(r, g, b, a)
      CutpursePreview:SetColor(r, g, b, a)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BREAKING] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CUTPURSE]
    end,
    default = { r = Destinations.defaults.pins.pinTextureOther.tint[1], g = Destinations.defaults.pins.pinTextureOther.tint[2], b = Destinations.defaults.pins.pinTextureOther.tint[3], a = Destinations.defaults.pins.pinTextureOther.tint[4] }
  }
  -- Achievement All Undone pin text color
  optionsTable[achievementPositionsGlobal].controls[#optionsTable[achievementPositionsGlobal].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_ACH_TXT_COLOR_MISS),
    tooltip = GetString(DEST_SETTINGS_ACH_TXT_COLOR_MISS_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureOther.textcolor) end,
    setFunc = function(r, g, b)
      for _, pinName in pairs(Destinations.drtv.AchPinTex) do
        Destinations.SV.pins[pinName].textcolor = { r, g, b }
      end
      for _, pinSuffix in pairs(Destinations.drtv.AchPins) do
        local colorObj = Destinations.drtv.AchTextColorDefs[pinSuffix]
        if colorObj then
          colorObj:SetRGB(r, g, b)
        end
      end
      for _, pinName in pairs(Destinations.drtv.AchPins) do
        LMP:RefreshPins(Destinations.PIN_TYPES[pinName])
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION]
    end,
    default = { r = Destinations.defaults.pins.pinTextureOther.textcolor[1], g = Destinations.defaults.pins.pinTextureOther.textcolor[2], b = Destinations.defaults.pins.pinTextureOther.textcolor[3] }
  }
  -- Achievement All Done pin color
  optionsTable[achievementPositionsGlobal].controls[#optionsTable[achievementPositionsGlobal].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_ACH_PIN_COLOR_DONE),
    tooltip = GetString(DEST_SETTINGS_ACH_PIN_COLOR_DONE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureOtherDone.tint) end,
    setFunc = function(r, g, b, a)
      Destinations.SV.pins.pinTextureOtherDone.tint = { r, g, b, a }
      DEST_PIN_TINT_OTHER_DONE:SetRGBA(r, g, b, a)

      for _, pinName in pairs(Destinations.drtv.AchPinTex) do
        pinName = pinName .. "Done"
        Destinations.SV.pins[pinName].tint = { r, g, b, a }
      end
      for _, pinName in pairs(Destinations.drtv.AchPins) do
        pinName = pinName .. "_DONE"
        LMP:SetLayoutKey(Destinations.PIN_TYPES[pinName], "tint", DEST_PIN_TINT_OTHER_DONE)
        RedrawAllPins(Destinations.PIN_TYPES[pinName])
      end

      MaiqPreviewDone:SetColor(r, g, b, a)
      otherPreviewDone:SetColor(r, g, b, a)
      PeacemakerPreviewDone:SetColor(r, g, b, a)
      NosediverPreviewDone:SetColor(r, g, b, a)
      EarthlyPosPreviewDone:SetColor(r, g, b, a)
      OnMePreviewDone:SetColor(r, g, b, a)
      BrawlPreviewDone:SetColor(r, g, b, a)
      PatronPreviewDone:SetColor(r, g, b, a)
      WrothgarJumperPreviewDone:SetColor(r, g, b, a)
      ChampionPreviewDone:SetColor(r, g, b, a)
      RelicHunterPreviewDone:SetColor(r, g, b, a)
      BreakingPreviewDone:SetColor(r, g, b, a)
      CutpursePreviewDone:SetColor(r, g, b, a)

    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION_DONE]
    end,
    default = { r = Destinations.defaults.pins.pinTextureOtherDone.tint[1], g = Destinations.defaults.pins.pinTextureOtherDone.tint[2], b = Destinations.defaults.pins.pinTextureOtherDone.tint[3], a = Destinations.defaults.pins.pinTextureOtherDone.tint[4] }
  }
  -- Achievement All Done pin text color
  optionsTable[achievementPositionsGlobal].controls[#optionsTable[achievementPositionsGlobal].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_ACH_TXT_COLOR_DONE),
    tooltip = GetString(DEST_SETTINGS_ACH_TXT_COLOR_DONE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureOtherDone.textcolor) end,
    setFunc = function(r, g, b)
      for _, pinName in pairs(Destinations.drtv.AchPinTex) do
        pinName = pinName .. "Done"
        Destinations.SV.pins[pinName].textcolor = { r, g, b }
      end
      for _, pinSuffix in pairs(Destinations.drtv.AchPins) do
        local colorObj = Destinations.drtv.AchTextColorDefsDone[pinSuffix]
        if colorObj then
          colorObj:SetRGB(r, g, b)
        end
      end
      for _, pinName in pairs(Destinations.drtv.AchPins) do
        pinName = pinName .. "_DONE"
        LMP:RefreshPins(Destinations.PIN_TYPES[pinName])
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION_DONE]
    end,
    default = { r = Destinations.defaults.pins.pinTextureOtherDone.textcolor[1], g = Destinations.defaults.pins.pinTextureOtherDone.textcolor[2], b = Destinations.defaults.pins.pinTextureOtherDone.textcolor[3] }
  }
  -- Achievement All compass toggle
  optionsTable[achievementPositionsGlobal].controls[#optionsTable[achievementPositionsGlobal].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_ALL_COMPASS_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.ACHIEVEMENTS_COMPASS] end,
    setFunc = function(state)
      Destinations.CSSV.filters[Destinations.PIN_TYPES.ACHIEVEMENTS_COMPASS] = state
      for _, pinName in pairs(Destinations.drtv.AchPins) do
        RedrawCompassPinsOnly(Destinations.PIN_TYPES[pinName])
        pinName = pinName .. "_DONE"
        RedrawCompassPinsOnly(Destinations.PIN_TYPES[pinName])
      end
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION_DONE]
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.ACHIEVEMENTS_COMPASS],
  }
  -- Achievement All compass distance
  optionsTable[achievementPositionsGlobal].controls[#optionsTable[achievementPositionsGlobal].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_ACH_ALL_COMPASS_DIST),
    min = 1,
    max = 100,
    getFunc = function() return Destinations.SV.pins.pinTextureOther.maxDistance * 1000 end,
    setFunc = function(maxDistance)
      for _, pinName in pairs(Destinations.drtv.AchPinTex) do
        Destinations.SV.pins[pinName].maxDistance = maxDistance / 1000
        pinName = pinName .. "Done"
        Destinations.SV.pins[pinName].maxDistance = maxDistance / 1000
      end
      for _, pinName in pairs(Destinations.drtv.AchPins) do
        COMPASS_PINS.pinLayouts[Destinations.PIN_TYPES[pinName]].maxDistance = maxDistance / 1000
        RedrawCompassPinsOnly(Destinations.PIN_TYPES[pinName])
        pinName = pinName .. "_DONE"
        COMPASS_PINS.pinLayouts[Destinations.PIN_TYPES[pinName]].maxDistance = maxDistance / 1000
        RedrawCompassPinsOnly(Destinations.PIN_TYPES[pinName])
      end
    end,
    width = "full",
    disabled = function() return
    (not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.LB_GTTP_CP_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.MAIQ_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PEACEMAKER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.NOSEDIVER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.EARTHLYPOS_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.ON_ME_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.BRAWL_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.PATRON_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WROTHGAR_JUMPER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.RELIC_HUNTER_DONE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.CHAMPION_DONE]) or
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.ACHIEVEMENTS_COMPASS]
    end,
    default = Destinations.defaults.pins.pinTextureOther.maxDistance * 1000,
  }
  -- Misc POIs submenu
  local miscellaneousPOI2 = #optionsTable + 1
  optionsTable[miscellaneousPOI2] = {
    type = "submenu",
    name = Destinations.defaults.miscColorCodes.settingsTextMiscellaneous:Colorize(GetString(DEST_SETTINGS_MISC_HEADER)),
    tooltip = GetString(DEST_SETTINGS_MISC_HEADER_TT),
    controls = { }
  }
  -- Ayleid Well Header
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_AYLEID_WELL_HEADER)),
  }
  -- Ayleid Well pin toggle
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "checkbox",
    width = "half",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MISC_PIN_AYLEID_WELL_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_MISC_PIN_AYLEID_WELL_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.AYLEID] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.AYLEID, state)
      RedrawAllPins(Destinations.PIN_TYPES.AYLEID)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.AYLEID],
  }
  -- Ayleid Well pintype
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "dropdown",
    width = "half",
    reference = "previewpinTextureAyleid",
    choices = Destinations.pinTextures.lists.Ayleid,
    getFunc = function() return Destinations.pinTextures.lists.Ayleid[Destinations.SV.pins.pinTextureAyleid.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Ayleid) do
        if name == selected then
          Destinations.SV.pins.pinTextureAyleid.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.AYLEID, "texture", Destinations.pinTextures.paths.Ayleid[index])
          AyleidPreview:SetTexture(Destinations.pinTextures.paths.Ayleid[index])
          RedrawAllPins(Destinations.PIN_TYPES.AYLEID)
          break
        end
      end
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.AYLEID] end,
    default = Destinations.pinTextures.lists.Ayleid[Destinations.defaults.pins.pinTextureAyleid.type],
  }
  -- Ayleid Well pin size
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_MISC_PIN_AYLEID_WELL_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureAyleid.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureAyleid.size = size
      AyleidPreview:SetDimensions(size, size)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.AYLEID, "size", size)
      RedrawAllPins(Destinations.PIN_TYPES.AYLEID)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.AYLEID] end,
    default = Destinations.defaults.pins.pinTextureAyleid.size
  }
  -- Ayleid pin color
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_MISC_PIN_AYLEID_WELL_COLOR),
    tooltip = GetString(DEST_SETTINGS_MISC_PIN_AYLEID_WELL_COLOR_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureAyleid.tint) end,
    setFunc = function(r, g, b, a)
      Destinations.SV.pins.pinTextureAyleid.tint = { r, g, b, a }
      DEST_PIN_TINT_AYLEID:SetRGBA(r, g, b, a)
      AyleidPreview:SetColor(r, g, b, a)
      RedrawAllPins(Destinations.PIN_TYPES.AYLEID)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.AYLEID] end,
    default = { r = Destinations.defaults.pins.pinTextureAyleid.tint[1], g = Destinations.defaults.pins.pinTextureAyleid.tint[2], b = Destinations.defaults.pins.pinTextureAyleid.tint[3], a = Destinations.defaults.pins.pinTextureAyleid.tint[4] }
  }
  -- Ayleid pin text color
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_MISC_PINTEXT_AYLEID_WELL_COLOR),
    tooltip = GetString(DEST_SETTINGS_MISC_PINTEXT_AYLEID_WELL_COLOR_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureAyleid.textcolor) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureAyleid.textcolor = { r, g, b }
      DEST_PIN_TEXT_COLOR_AYLEID:SetRGB(r, g, b)
      LMP:RefreshPins(Destinations.PIN_TYPES.AYLEID)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.AYLEID] end,
    default = { r = Destinations.defaults.pins.pinTextureAyleid.textcolor[1], g = Destinations.defaults.pins.pinTextureAyleid.textcolor[2], b = Destinations.defaults.pins.pinTextureAyleid.textcolor[3] }
  }
  ---- Deadlands Entrance Header
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_DEADLANDS_ENTRANCE_HEADER)),
  }
  -- Deadlands pin toggle
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.DEADLANDS] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.DEADLANDS, state)
      RedrawAllPins(Destinations.PIN_TYPES.DEADLANDS)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.DEADLANDS],
  }
  -- Deadlands pin size
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureDeadlands.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureDeadlands.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.DEADLANDS, "size", size)
      RedrawAllPins(Destinations.PIN_TYPES.DEADLANDS)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.DEADLANDS] end,
    default = Destinations.defaults.pins.pinTextureDeadlands.size
  }
  -- Deadlands pin text color
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_MISC_PINTEXT_DEADLANDS_ENTRANCE_COLOR),
    tooltip = GetString(DEST_SETTINGS_MISC_PINTEXT_DEADLANDS_ENTRANCE_COLOR_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureDeadlands.textcolor) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureDeadlands.textcolor = { r, g, b }
      LMP:RefreshPins(Destinations.PIN_TYPES.DEADLANDS)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.DEADLANDS] end,
    default = { r = Destinations.defaults.pins.pinTextureDeadlands.textcolor[1], g = Destinations.defaults.pins.pinTextureDeadlands.textcolor[2], b = Destinations.defaults.pins.pinTextureDeadlands.textcolor[3] }
  }
  -- HighIsle Druidic Shrine
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_HIGHISLE_SHRINE_HEADER)),
  }
  -- HighIsle Druidic Shrine pin toggle
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.HIGHISLE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.HIGHISLE, state)
      RedrawAllPins(Destinations.PIN_TYPES.HIGHISLE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.HIGHISLE],
  }
  -- HighIsle Druidic Shrine pin size
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureHighIsle.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureHighIsle.size = size
      LMP:SetLayoutKey(Destinations.PIN_TYPES.HIGHISLE, "size", size)
      RedrawAllPins(Destinations.PIN_TYPES.HIGHISLE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.HIGHISLE] end,
    default = Destinations.defaults.pins.pinTextureHighIsle.size
  }
  -- HighIsle Druidic Shrine text color
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_MISC_PINTEXT_HIGHISLE_DRUIDICSHRINES_COLOR),
    tooltip = GetString(DEST_SETTINGS_MISC_PINTEXT_HIGHISLE_DRUIDICSHRINES_COLOR_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureHighIsle.textcolor) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureHighIsle.textcolor = { r, g, b }
      LMP:RefreshPins(Destinations.PIN_TYPES.HIGHISLE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.HIGHISLE] end,
    default = { r = Destinations.defaults.pins.pinTextureHighIsle.textcolor[1], g = Destinations.defaults.pins.pinTextureHighIsle.textcolor[2], b = Destinations.defaults.pins.pinTextureHighIsle.textcolor[3] }
  }
  -- Dwemer Ruins Header
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_DWEMER_HEADER)),
  }
  -- Dwemer pin toggle
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "checkbox",
    width = "half",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MISC_DWEMER_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_MISC_DWEMER_PIN_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.DWEMER] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.DWEMER, state)
      RedrawAllPins(Destinations.PIN_TYPES.DWEMER)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.DWEMER],
  }
  -- Dwemer pin style
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "dropdown",
    width = "half",
    reference = "previewpinTextureDwemer",
    choices = Destinations.pinTextures.lists.Dwemer,
    getFunc = function() return Destinations.pinTextures.lists.Dwemer[Destinations.SV.pins.pinTextureDwemer.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Dwemer) do
        if name == selected then
          Destinations.SV.pins.pinTextureDwemer.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.DWEMER, "texture", Destinations.pinTextures.paths.dwemer[index])
          DwemerPreview:SetTexture(Destinations.pinTextures.paths.dwemer[index])
          RedrawAllPins(Destinations.PIN_TYPES.DWEMER)
          break
        end
      end
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.DWEMER] end,
    default = Destinations.pinTextures.lists.Dwemer[Destinations.defaults.pins.pinTextureDwemer.type],
  }
  -- Dwemer pin size
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_MISC_DWEMER_PIN_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureDwemer.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureDwemer.size = size
      DwemerPreview:SetDimensions(size, size)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.DWEMER, "size", size)
      RedrawAllPins(Destinations.PIN_TYPES.DWEMER)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.DWEMER] end,
    default = Destinations.defaults.pins.pinTextureDwemer.size
  }
  -- Dwemer pin color
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_MISC_DWEMER_PIN_COLOR),
    tooltip = GetString(DEST_SETTINGS_MISC_DWEMER_PIN_COLOR_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureDwemer.tint) end,
    setFunc = function(r, g, b, a)
      Destinations.SV.pins.pinTextureDwemer.tint = { r, g, b, a }
      DEST_PIN_TINT_DWEMER:SetRGBA(r, g, b, a)
      DwemerPreview:SetColor(r, g, b, a)
      RedrawAllPins(Destinations.PIN_TYPES.DWEMER)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.DWEMER] end,
    default = { r = Destinations.defaults.pins.pinTextureDwemer.tint[1], g = Destinations.defaults.pins.pinTextureDwemer.tint[2], b = Destinations.defaults.pins.pinTextureDwemer.tint[3], a = Destinations.defaults.pins.pinTextureDwemer.tint[4] }
  }
  -- Dwemer pin text color
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_MISC_DWEMER_PINTEXT_COLOR),
    tooltip = GetString(DEST_SETTINGS_MISC_DWEMER_PINTEXT_COLOR_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureDwemer.textcolor) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureDwemer.textcolor = { r, g, b }
      LMP:RefreshPins(Destinations.PIN_TYPES.DWEMER)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.DWEMER] end,
    default = { r = Destinations.defaults.pins.pinTextureDwemer.textcolor[1], g = Destinations.defaults.pins.pinTextureDwemer.textcolor[2], b = Destinations.defaults.pins.pinTextureDwemer.textcolor[3] }
  }
  -- Show Misc POIs on compass
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_COMPASS_HEADER)),
  }
  -- Show Misc POIs on compass toggle
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MISC_COMPASS_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.MISC_COMPASS] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.MISC_COMPASS, state)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.AYLEID)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.DEADLANDS)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.HIGHISLE)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.DWEMER)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.AYLEID] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.DEADLANDS] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.HIGHISLE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.DWEMER]
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.MISC_COMPASS],
  }
  -- Show Misc POIs on compass pin distance
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_MISC_COMPASS_DIST),
    min = 1,
    max = 100,
    getFunc = function() return Destinations.SV.pins.pinTextureAyleid.maxDistance * 1000 end,
    setFunc = function(maxDistance)
      Destinations.SV.pins.pinTextureAyleid.maxDistance = maxDistance / 1000
      Destinations.SV.pins.pinTextureDeadlands.maxDistance = maxDistance / 1000
      Destinations.SV.pins.pinTextureHighIsle.maxDistance = maxDistance / 1000
      Destinations.SV.pins.pinTextureDwemer.maxDistance = maxDistance / 1000
      COMPASS_PINS.pinLayouts[Destinations.PIN_TYPES.AYLEID].maxDistance = maxDistance / 1000
      COMPASS_PINS.pinLayouts[Destinations.PIN_TYPES.DEADLANDS].maxDistance = maxDistance / 1000
      COMPASS_PINS.pinLayouts[Destinations.PIN_TYPES.HIGHISLE].maxDistance = maxDistance / 1000
      COMPASS_PINS.pinLayouts[Destinations.PIN_TYPES.DWEMER].maxDistance = maxDistance / 1000
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.AYLEID)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.DEADLANDS)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.HIGHISLE)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.DWEMER)
    end,
    disabled = function() return
    (not Destinations.CSSV.filters[Destinations.PIN_TYPES.AYLEID] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.DEADLANDS] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.HIGHISLE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.DWEMER]) or
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.MISC_COMPASS]
    end,
    default = Destinations.defaults.pins.pinTextureAyleid.maxDistance * 1000,
  }
  -- Show Misc POIs on compass pin layer
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_MISC_PIN_LAYER),
    min = 10,
    max = 200,
    step = 5,
    getFunc = function() return Destinations.SV.pins.pinTextureAyleid.level end,
    setFunc = function(level)
      Destinations.SV.pins.pinTextureAyleid.level = level
      Destinations.SV.pins.pinTextureDeadlands.level = level
      Destinations.SV.pins.pinTextureHighIsle.level = level
      Destinations.SV.pins.pinTextureDwemer.level = level
      LMP:SetLayoutKey(Destinations.PIN_TYPES.AYLEID, "level", level)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.DEADLANDS, "level", level)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.HIGHISLE, "level", level)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.DWEMER, "level", level)
      RedrawAllPins(Destinations.PIN_TYPES.AYLEID)
      RedrawAllPins(Destinations.PIN_TYPES.DEADLANDS)
      RedrawAllPins(Destinations.PIN_TYPES.HIGHISLE)
      RedrawAllPins(Destinations.PIN_TYPES.DWEMER)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.AYLEID] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.DWEMER] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.HIGHISLE] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.DEADLANDS]
    end,
    default = Destinations.defaults.pins.pinTextureAyleid.level
  }
  local vampireWerewolf = #optionsTable + 1
  optionsTable[vampireWerewolf] = { -- VWW submenu
    type = "submenu",
    name = Destinations.defaults.miscColorCodes.settingsTextVWW:Colorize(GetString(DEST_SETTINGS_VWW_HEADER)),
    tooltip = GetString(DEST_SETTINGS_VWW_HEADER_TT),
    controls = { }
  }
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_VWW_WWVAMP_HEADER)),
  }
  -- Werewolf/Vampire pin toggle
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "checkbox",
    width = "half",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_VWW_PIN_WWVAMP_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_VWW_PIN_WWVAMP_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.WWVAMP] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.WWVAMP, state)
      RedrawAllPins(Destinations.PIN_TYPES.WWVAMP)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.WWVAMP],
  }
  -- Werewolf/Vampire pintype
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "dropdown",
    width = "half",
    reference = "previewpinTextureWWVamp",
    choices = Destinations.pinTextures.lists.WWVamp,
    getFunc = function() return Destinations.pinTextures.lists.WWVamp[Destinations.SV.pins.pinTextureWWVamp.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.WWVamp) do
        if name == selected then
          Destinations.SV.pins.pinTextureWWVamp.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.WWVAMP, "texture", Destinations.pinTextures.paths.wwvamp[index])
          WWVampPreview:SetTexture(Destinations.pinTextures.paths.wwvamp[index])
          RedrawAllPins(Destinations.PIN_TYPES.WWVAMP)
          break
        end
      end
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.WWVAMP] end,
    default = Destinations.pinTextures.lists.WWVamp[Destinations.defaults.pins.pinTextureWWVamp.type],
  }
  -- Werewolf/Vampire pin size
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_VWW_PIN_WWVAMP_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureWWVamp.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureWWVamp.size = size
      WWVampPreview:SetDimensions(size, size)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.WWVAMP, "size", size)
      RedrawAllPins(Destinations.PIN_TYPES.WWVAMP)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.WWVAMP] end,
    default = Destinations.defaults.pins.pinTextureWWVamp.size
  }
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_VWW_VAMP_HEADER)),
  }
  -- Vampire Alter pin toggle
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "checkbox",
    width = "half",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.VAMPIRE_ALTAR] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.VAMPIRE_ALTAR, state)
      RedrawAllPins(Destinations.PIN_TYPES.VAMPIRE_ALTAR)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.VAMPIRE_ALTAR],
  }
  -- Vampire Alter pintype
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "dropdown",
    width = "half",
    reference = "previewpinTextureVampAltar",
    choices = Destinations.pinTextures.lists.VampAltar,
    getFunc = function() return Destinations.pinTextures.lists.VampAltar[Destinations.SV.pins.pinTextureVampAltar.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.VampAltar) do
        if name == selected then
          Destinations.SV.pins.pinTextureVampAltar.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.VAMPIRE_ALTAR, "texture", Destinations.pinTextures.paths.vampirealtar[index])
          VampAltarPreview:SetTexture(Destinations.pinTextures.paths.vampirealtar[index])
          RedrawAllPins(Destinations.PIN_TYPES.VAMPIRE_ALTAR)
          break
        end
      end
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.VAMPIRE_ALTAR] end,
    default = Destinations.pinTextures.lists.VampAltar[Destinations.defaults.pins.pinTextureVampAltar.type],
  }
  -- Vampire Alter pin size
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureVampAltar.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureVampAltar.size = size
      VampAltarPreview:SetDimensions(size, size)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.VAMPIRE_ALTAR, "size", size)
      RedrawAllPins(Destinations.PIN_TYPES.VAMPIRE_ALTAR)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.VAMPIRE_ALTAR] end,
    default = Destinations.defaults.pins.pinTextureVampAltar.size
  }
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_VWW_WW_HEADER)),
  }
  -- Werewolf Shrine pin toggle
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "checkbox",
    width = "half",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_VWW_PIN_WW_SHRINE_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_VWW_PIN_WW_SHRINE_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.WEREWOLF_SHRINE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.WEREWOLF_SHRINE, state)
      RedrawAllPins(Destinations.PIN_TYPES.WEREWOLF_SHRINE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.WEREWOLF_SHRINE],
  }
  -- Werewolf Shrine pintype
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "dropdown",
    width = "half",
    reference = "previewpinTextureWWShrine",
    choices = Destinations.pinTextures.lists.WWShrine,
    getFunc = function() return Destinations.pinTextures.lists.WWShrine[Destinations.SV.pins.pinTextureWWShrine.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.WWShrine) do
        if name == selected then
          Destinations.SV.pins.pinTextureWWShrine.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.WEREWOLF_SHRINE, "texture", Destinations.pinTextures.paths.werewolfshrine[index])
          WWShrinePreview:SetTexture(Destinations.pinTextures.paths.werewolfshrine[index])
          RedrawAllPins(Destinations.PIN_TYPES.WEREWOLF_SHRINE)
          break
        end
      end
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.WEREWOLF_SHRINE] end,
    default = Destinations.pinTextures.lists.WWShrine[Destinations.defaults.pins.pinTextureWWShrine.type],
  }
  -- Werewolf Shrine pin size
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_VWW_PIN_WW_SHRINE_SIZE),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureWWShrine.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureWWShrine.size = size
      WWShrinePreview:SetDimensions(size, size)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.WEREWOLF_SHRINE, "size", size)
      RedrawAllPins(Destinations.PIN_TYPES.WEREWOLF_SHRINE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.WEREWOLF_SHRINE] end,
    default = Destinations.defaults.pins.pinTextureWWShrine.size
  }
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_VWW_COMPASS_HEADER)),
  }
  -- Werewolf/Vampire toggle compass
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_VWW_COMPASS_PIN_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.VWW_COMPASS] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.VWW_COMPASS, state)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.WWVAMP)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.VAMPIRE_ALTAR)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.WEREWOLF_SHRINE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.WWVAMP] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.VAMPIRE_ALTAR] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WEREWOLF_SHRINE]
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.VWW_COMPASS],
  }
  -- Werewolf/Vampire compass pin distance
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_VWW_COMPASS_DIST),
    min = 1,
    max = 100,
    getFunc = function() return Destinations.SV.pins.pinTextureWWShrine.maxDistance * 1000 end,
    setFunc = function(maxDistance)
      Destinations.SV.pins.pinTextureWWVamp.maxDistance = maxDistance / 1000
      Destinations.SV.pins.pinTextureWWShrine.maxDistance = maxDistance / 1000
      Destinations.SV.pins.pinTextureVampAltar.maxDistance = maxDistance / 1000
      COMPASS_PINS.pinLayouts[Destinations.PIN_TYPES.WWVAMP].maxDistance = maxDistance / 1000
      COMPASS_PINS.pinLayouts[Destinations.PIN_TYPES.VAMPIRE_ALTAR].maxDistance = maxDistance / 1000
      COMPASS_PINS.pinLayouts[Destinations.PIN_TYPES.WEREWOLF_SHRINE].maxDistance = maxDistance / 1000
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.WWVAMP)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.VAMPIRE_ALTAR)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.WEREWOLF_SHRINE)
    end,
    disabled = function() return
    (not Destinations.CSSV.filters[Destinations.PIN_TYPES.WWVAMP] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.VAMPIRE_ALTAR] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WEREWOLF_SHRINE]) or
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.VWW_COMPASS]
    end,
    default = Destinations.defaults.pins.pinTextureWWShrine.maxDistance * 1000,
  }
  -- Werewolf/Vampire pin layer
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_VWW_PIN_LAYER),
    min = 10,
    max = 200,
    step = 5,
    getFunc = function() return Destinations.SV.pins.pinTextureWWShrine.level end,
    setFunc = function(level)
      Destinations.SV.pins.pinTextureWWVamp.level = level
      Destinations.SV.pins.pinTextureWWShrine.level = level
      Destinations.SV.pins.pinTextureVampAltar.level = level
      LMP:SetLayoutKey(Destinations.PIN_TYPES.WWVAMP, "level", level)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.VAMPIRE_ALTAR, "level", level)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.WEREWOLF_SHRINE, "level", level)
      RedrawAllPins(Destinations.PIN_TYPES.WWVAMP)
      RedrawAllPins(Destinations.PIN_TYPES.VAMPIRE_ALTAR)
      RedrawAllPins(Destinations.PIN_TYPES.WEREWOLF_SHRINE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.WWVAMP] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.VAMPIRE_ALTAR] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WEREWOLF_SHRINE]
    end,
    default = Destinations.defaults.pins.pinTextureWWShrine.level
  }
  -- Werewolf/Vampire pin color
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_VWW_PIN_COLOR),
    tooltip = GetString(DEST_SETTINGS_VWW_PIN_COLOR_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureWWVamp.tint) end,
    setFunc = function(r, g, b, a)
      Destinations.SV.pins.pinTextureWWVamp.tint = { r, g, b, a }
      Destinations.SV.pins.pinTextureVampAltar.tint = { r, g, b, a }
      Destinations.SV.pins.pinTextureWWShrine.tint = { r, g, b, a }

      DEST_PIN_TINT_WWVAMP:SetRGBA(r, g, b, a)
      DEST_PIN_TINT_VAMPALTAR:SetRGBA(r, g, b, a)
      DEST_PIN_TINT_WWSHRINE:SetRGBA(r, g, b, a)

      WWVampPreview:SetColor(r, g, b, a)
      VampAltarPreview:SetColor(r, g, b, a)
      WWShrinePreview:SetColor(r, g, b, a)

      RedrawAllPins(Destinations.PIN_TYPES.WWVAMP)
      RedrawAllPins(Destinations.PIN_TYPES.VAMPIRE_ALTAR)
      RedrawAllPins(Destinations.PIN_TYPES.WEREWOLF_SHRINE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.WWVAMP] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.VAMPIRE_ALTAR] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WEREWOLF_SHRINE]
    end,
    default = { r = Destinations.defaults.pins.pinTextureWWVamp.tint[1], g = Destinations.defaults.pins.pinTextureWWVamp.tint[2], b = Destinations.defaults.pins.pinTextureWWVamp.tint[3], a = Destinations.defaults.pins.pinTextureWWVamp.tint[4] }
  }
  -- Werewolf/Vampire pin text color
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_VWW_PINTEXT_COLOR),
    tooltip = GetString(DEST_SETTINGS_VWW_PINTEXT_COLOR_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureWWVamp.textcolor) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureWWVamp.textcolor = { r, g, b }
      Destinations.SV.pins.pinTextureVampAltar.textcolor = { r, g, b }
      Destinations.SV.pins.pinTextureWWShrine.textcolor = { r, g, b }
      LMP:RefreshPins(Destinations.PIN_TYPES.WWVAMP)
      LMP:RefreshPins(Destinations.PIN_TYPES.VAMPIRE_ALTAR)
      LMP:RefreshPins(Destinations.PIN_TYPES.WEREWOLF_SHRINE)
    end,
    disabled = function() return
    not Destinations.CSSV.filters[Destinations.PIN_TYPES.WWVAMP] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.VAMPIRE_ALTAR] and
      not Destinations.CSSV.filters[Destinations.PIN_TYPES.WEREWOLF_SHRINE]
    end,
    default = { r = Destinations.defaults.pins.pinTextureWWVamp.textcolor[1], g = Destinations.defaults.pins.pinTextureWWVamp.textcolor[2], b = Destinations.defaults.pins.pinTextureWWVamp.textcolor[3] }
  }

  local collectibles = #optionsTable + 1
  optionsTable[collectibles] = { -- Collectible submenu
    type = "submenu",
    name = Destinations.defaults.miscColorCodes.settingsTextCollectibles:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_HEADER)),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_HEADER_TT),
    controls = {}
  }
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_SUBHEADER)),
  }
  -- Collectible pin toggle
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.COLLECTIBLES, state)
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLES)
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLESDONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.COLLECTIBLES],
  }
  -- Collectible Completed pin toggle
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "checkbox",
    width = "full",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_DONE_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_DONE_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLESDONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.COLLECTIBLESDONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLESDONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.COLLECTIBLESDONE],
  }
  -- Collectible pin style
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_STYLE),
    reference = "previewpinTextureCollectible",
    choices = Destinations.pinTextures.lists.Collectible,
    getFunc = function() return Destinations.pinTextures.lists.Collectible[Destinations.SV.pins.pinTextureCollectible.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Collectible) do
        if name == selected then
          Destinations.SV.pins.pinTextureCollectible.type = index
          Destinations.SV.pins.pinTextureCollectibleDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.COLLECTIBLES, "texture", Destinations.pinTextures.paths.collectible[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.COLLECTIBLESDONE, "texture", Destinations.pinTextures.paths.collectibledone[index])
          CollectiblePreview:SetTexture(Destinations.pinTextures.paths.collectible[index])
          CollectibleDonePreview:SetTexture(Destinations.pinTextures.paths.collectibledone[index])
          RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLES)
          RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLESDONE)
          break
        end
      end
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLESDONE] end,
    default = Destinations.pinTextures.lists.Collectible[Destinations.defaults.pins.pinTextureCollectible.type],
  }
  -- Collectible Name on pin toggle
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "checkbox",
    width = "full",
    name = GetString(DEST_SETTINGS_COLLECTIBLES_SHOW_MOBNAME),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_SHOW_MOBNAME_TT),
    getFunc = function() return Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_MOBNAME] end,
    setFunc = function(state)
      Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_MOBNAME] = state
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLES)
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLESDONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_MOBNAME],
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLESDONE] end,
  }
  -- Collectible Item on pin toggle
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "checkbox",
    width = "full",
    name = GetString(DEST_SETTINGS_COLLECTIBLES_SHOW_ITEM),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_SHOW_ITEM_TT),
    getFunc = function() return Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_ITEM] end,
    setFunc = function(state)
      Destinations.SV.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_ITEM] = state
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLES)
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLESDONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.COLLECTIBLES_SHOW_ITEM],
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLESDONE] end,
  }
  -- Collectible title pin text color
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_COLLECTIBLES_COLOR_TITLE),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_COLOR_TITLE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureCollectible.textcolortitle) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureCollectible.textcolortitle = { r, g, b }
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLES)
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLESDONE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLESDONE] end,
    default = { r = Destinations.defaults.pins.pinTextureCollectible.textcolortitle[1], g = Destinations.defaults.pins.pinTextureCollectible.textcolortitle[2], b = Destinations.defaults.pins.pinTextureCollectible.textcolortitle[3] }
  }
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_COLORS_HEADER)),
  }
  -- Collectible Missing pin color
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_COLOR),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureCollectible.tint) end,
    setFunc = function(r, g, b, a)
      Destinations.SV.pins.pinTextureCollectible.tint = { r, g, b, a }
      CollectiblePreview:SetColor(r, g, b, a)
      DEST_PIN_TINT_COLLECTIBLE:SetRGBA(r, g, b, a)
      LMP:RefreshPins(Destinations.PIN_TYPES.COLLECTIBLES)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES] end,
    default = { r = Destinations.defaults.pins.pinTextureCollectible.tint[1], g = Destinations.defaults.pins.pinTextureCollectible.tint[2], b = Destinations.defaults.pins.pinTextureCollectible.tint[3], a = Destinations.defaults.pins.pinTextureCollectible.tint[4] }
  }
  -- Collectible Missing pin text color
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_COLLECTIBLES_COLOR_UNDONE),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_COLOR_UNDONE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureCollectible.textcolor) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureCollectible.textcolor = { r, g, b }
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLES)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES] end,
    default = { r = Destinations.defaults.pins.pinTextureCollectible.textcolor[1], g = Destinations.defaults.pins.pinTextureCollectible.textcolor[2], b = Destinations.defaults.pins.pinTextureCollectible.textcolor[3] }
  }
  -- Collectible Completed pin color
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_DONE),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_DONE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureCollectibleDone.tint) end,
    setFunc = function(r, g, b, a)
      Destinations.SV.pins.pinTextureCollectibleDone.tint = { r, g, b, a }
      CollectibleDonePreview:SetColor(r, g, b, a)
      DEST_PIN_TINT_COLLECTIBLE_DONE:SetRGBA(r, g, b, a)
      LMP:RefreshPins(Destinations.PIN_TYPES.COLLECTIBLESDONE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLESDONE] end,
    default = { r = Destinations.defaults.pins.pinTextureCollectibleDone.tint[1], g = Destinations.defaults.pins.pinTextureCollectibleDone.tint[2], b = Destinations.defaults.pins.pinTextureCollectibleDone.tint[3], a = Destinations.defaults.pins.pinTextureCollectibleDone.tint[4] }
  }
  -- Collectible Completed pin text color
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_COLLECTIBLES_COLOR_DONE),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_COLOR_DONE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureCollectibleDone.textcolor) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureCollectibleDone.textcolor = { r, g, b }
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLESDONE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLESDONE] end,
    default = { r = Destinations.defaults.pins.pinTextureCollectibleDone.textcolor[1], g = Destinations.defaults.pins.pinTextureCollectibleDone.textcolor[2], b = Destinations.defaults.pins.pinTextureCollectibleDone.textcolor[3] }
  }
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_MISC_HEADER)),
  }
  -- Collectible on compass toggle
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_COMPASS_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_COMPASS_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES_COMPASS] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.COLLECTIBLES_COMPASS, state)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.COLLECTIBLES)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.COLLECTIBLESDONE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLESDONE] end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.COLLECTIBLES_COMPASS],
  }
  -- Collectible compass distance
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_COLLECTIBLES_COMPASS_DIST),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_COMPASS_DIST_TT),
    min = 1,
    max = 100,
    getFunc = function() return Destinations.SV.pins.pinTextureCollectible.maxDistance * 1000 end,
    setFunc = function(maxDistance)
      Destinations.SV.pins.pinTextureCollectible.maxDistance = maxDistance / 1000
      Destinations.SV.pins.pinTextureCollectibleDone.maxDistance = maxDistance / 1000
      COMPASS_PINS.pinLayouts[Destinations.PIN_TYPES.COLLECTIBLES].maxDistance = maxDistance / 1000
      COMPASS_PINS.pinLayouts[Destinations.PIN_TYPES.COLLECTIBLESDONE].maxDistance = maxDistance / 1000
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.COLLECTIBLES)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.COLLECTIBLESDONE)
    end,
    width = "full",
    disabled = function() return (not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLESDONE]) or not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES_COMPASS] end,
    default = Destinations.defaults.pins.pinTextureCollectible.maxDistance * 1000,
  }
  -- Collectible pin size
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_SIZE),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_SIZE_TT),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureCollectible.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureCollectible.size = size
      Destinations.SV.pins.pinTextureCollectibleDone.size = size
      CollectiblePreview:SetDimensions(size, size)
      CollectibleDonePreview:SetDimensions(size, size)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.COLLECTIBLES, "size", size)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.COLLECTIBLESDONE, "size", size)
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLES)
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLESDONE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLESDONE] end,
    default = Destinations.defaults.pins.pinTextureCollectible.size
  }
  -- Collectible pin layer
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_LAYER),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_LAYER_TT),
    min = 10,
    max = 200,
    step = 5,
    getFunc = function() return Destinations.SV.pins.pinTextureCollectible.level end,
    setFunc = function(level)
      Destinations.SV.pins.pinTextureCollectible.level = level + DESTINATIONS_PIN_PRIORITY_OFFSET
      Destinations.SV.pins.pinTextureCollectibleDone.level = level
      LMP:SetLayoutKey(Destinations.PIN_TYPES.COLLECTIBLES, "level", level + DESTINATIONS_PIN_PRIORITY_OFFSET)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.COLLECTIBLESDONE, "level", level)
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLES)
      RedrawAllPins(Destinations.PIN_TYPES.COLLECTIBLESDONE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLES] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.COLLECTIBLESDONE] end,
    default = Destinations.defaults.pins.pinTextureCollectible.level
  }
  local fishing = #optionsTable + 1
  optionsTable[fishing] = { -- Fish submenu
    type = "submenu",
    name = Destinations.defaults.miscColorCodes.settingsTextFish:Colorize(GetString(DEST_SETTINGS_FISHING_HEADER)),
    tooltip = GetString(DEST_SETTINGS_FISHING_HEADER_TT),
    controls = {}
  }
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = { -- Header
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_FISHING_SUBHEADER)),
  }
  -- Fish pin toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_FISHING_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_FISHING_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.FISHING, state)
      RedrawAllPins(Destinations.PIN_TYPES.FISHING)
      RedrawAllPins(Destinations.PIN_TYPES.FISHINGDONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.FISHING],
  }
  -- Fish Completed pin toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "checkbox",
    width = "full",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_FISHING_DONE_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_FISHING_DONE_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.FISHINGDONE, state)
      RedrawAllPins(Destinations.PIN_TYPES.FISHINGDONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.FISHINGDONE],
  }
  -- Fish pin style
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "dropdown",
    name = GetString(DEST_SETTINGS_FISHING_PIN_STYLE),
    reference = "previewpinTextureFish",
    choices = Destinations.pinTextures.lists.Fish,
    getFunc = function() return Destinations.pinTextures.lists.Fish[Destinations.SV.pins.pinTextureFish.type] end,
    setFunc = function(selected)
      for index, name in ipairs(Destinations.pinTextures.lists.Fish) do
        if name == selected then
          Destinations.SV.pins.pinTextureFish.type = index
          Destinations.SV.pins.pinTextureFishDone.type = index
          LMP:SetLayoutKey(Destinations.PIN_TYPES.FISHING, "texture", Destinations.pinTextures.paths.fish[index])
          LMP:SetLayoutKey(Destinations.PIN_TYPES.FISHINGDONE, "texture", Destinations.pinTextures.paths.fishdone[index])
          FishPreview:SetTexture(Destinations.pinTextures.paths.fish[index])
          FishDonePreview:SetTexture(Destinations.pinTextures.paths.fishdone[index])
          RedrawAllPins(Destinations.PIN_TYPES.FISHING)
          RedrawAllPins(Destinations.PIN_TYPES.FISHINGDONE)
          break
        end
      end
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
    default = Destinations.pinTextures.lists.Fish[Destinations.defaults.pins.pinTextureFish.type],
  }
  -- Fish pin title pin text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_FISHING_COLOR_TITLE),
    tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_TITLE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureFish.textcolortitle) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureFish.textcolortitle = { r, g, b }
      RedrawAllPins(Destinations.PIN_TYPES.FISHING)
      RedrawAllPins(Destinations.PIN_TYPES.FISHINGDONE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
    default = { r = Destinations.defaults.pins.pinTextureFish.textcolortitle[1], g = Destinations.defaults.pins.pinTextureFish.textcolortitle[2], b = Destinations.defaults.pins.pinTextureFish.textcolortitle[3] }
  }
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_FISHING_PIN_TEXT_HEADER)),
  }
  -- Fish Name on pin toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "checkbox",
    width = "full",
    name = GetString(DEST_SETTINGS_FISHING_SHOW_FISHNAME),
    tooltip = GetString(DEST_SETTINGS_FISHING_SHOW_FISHNAME_TT),
    getFunc = function() return Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_FISHNAME] end,
    setFunc = function(state)
      Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_FISHNAME] = state
      RedrawAllPins(Destinations.PIN_TYPES.FISHING)
      RedrawAllPins(Destinations.PIN_TYPES.FISHINGDONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.FISHING_SHOW_FISHNAME],
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
  }
  -- Fish Bait on pin toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "checkbox",
    width = "full",
    name = GetString(DEST_SETTINGS_FISHING_SHOW_BAIT),
    tooltip = GetString(DEST_SETTINGS_FISHING_SHOW_BAIT_TT),
    getFunc = function() return Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_BAIT] end,
    setFunc = function(state)
      Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_BAIT] = state
      RedrawAllPins(Destinations.PIN_TYPES.FISHING)
      RedrawAllPins(Destinations.PIN_TYPES.FISHINGDONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.FISHING_SHOW_BAIT],
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
  }
  -- Fish Bait Left on pin toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "checkbox",
    width = "full",
    name = GetString(DEST_SETTINGS_FISHING_SHOW_BAIT_LEFT),
    tooltip = GetString(DEST_SETTINGS_FISHING_SHOW_BAIT_LEFT_TT),
    getFunc = function() return Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_BAIT_LEFT] end,
    setFunc = function(state)
      Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_BAIT_LEFT] = state
      RedrawAllPins(Destinations.PIN_TYPES.FISHING)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.FISHING_SHOW_BAIT_LEFT],
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
  }
  -- Fish Water on pin toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "checkbox",
    width = "full",
    name = GetString(DEST_SETTINGS_FISHING_SHOW_WATER),
    tooltip = GetString(DEST_SETTINGS_FISHING_SHOW_WATER_TT),
    getFunc = function() return Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_WATER] end,
    setFunc = function(state)
      Destinations.SV.filters[Destinations.PIN_TYPES.FISHING_SHOW_WATER] = state
      RedrawAllPins(Destinations.PIN_TYPES.FISHING)
      RedrawAllPins(Destinations.PIN_TYPES.FISHINGDONE)
    end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.FISHING_SHOW_WATER],
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
  }
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_FISHING_COLOR_HEADER)),
  }
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_FISHING_PIN_COLOR),
    tooltip = GetString(DEST_SETTINGS_FISHING_PIN_COLOR_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureFish.tint) end,
    setFunc = function(r, g, b, a)
      Destinations.SV.pins.pinTextureFish.tint = { r, g, b, a }
      FishPreview:SetColor(r, g, b, a)
      DEST_PIN_TINT_FISH:SetRGBA(r, g, b, a)
      LMP:RefreshPins(Destinations.PIN_TYPES.FISHING)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] end,
    default = { r = Destinations.defaults.pins.pinTextureFish.tint[1], g = Destinations.defaults.pins.pinTextureFish.tint[2], b = Destinations.defaults.pins.pinTextureFish.tint[3], a = Destinations.defaults.pins.pinTextureFish.tint[4] }
  }
  -- Fish Missing pin text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_FISHING_COLOR_UNDONE),
    tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_UNDONE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureFish.textcolor) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureFish.textcolor = { r, g, b }
      RedrawAllPins(Destinations.PIN_TYPES.FISHING)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] end,
    default = { r = Destinations.defaults.pins.pinTextureFish.textcolor[1], g = Destinations.defaults.pins.pinTextureFish.textcolor[2], b = Destinations.defaults.pins.pinTextureFish.textcolor[3] }
  }
  -- Fish Missing pin bait text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_FISHING_COLOR_BAIT_UNDONE),
    tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_BAIT_UNDONE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureFish.textcolorBait) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureFish.textcolorBait = { r, g, b }
      RedrawAllPins(Destinations.PIN_TYPES.FISHING)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] end,
    default = { r = Destinations.defaults.pins.pinTextureFish.textcolorBait[1], g = Destinations.defaults.pins.pinTextureFish.textcolorBait[2], b = Destinations.defaults.pins.pinTextureFish.textcolorBait[3] }
  }
  -- Fish Missing pin water text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_FISHING_COLOR_WATER_UNDONE),
    tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_WATER_UNDONE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureFish.textcolorWater) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureFish.textcolorWater = { r, g, b }
      RedrawAllPins(Destinations.PIN_TYPES.FISHING)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] end,
    default = { r = Destinations.defaults.pins.pinTextureFish.textcolorWater[1], g = Destinations.defaults.pins.pinTextureFish.textcolorWater[2], b = Destinations.defaults.pins.pinTextureFish.textcolorWater[3] }
  }
  -- Fish Completed pin color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_FISHING_PIN_COLOR_DONE),
    tooltip = GetString(DEST_SETTINGS_FISHING_PIN_COLOR_DONE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureFishDone.tint) end,
    setFunc = function(r, g, b, a)
      Destinations.SV.pins.pinTextureFishDone.tint = { r, g, b, a }
      FishDonePreview:SetColor(r, g, b, a)
      DEST_PIN_TINT_FISH_DONE:SetRGBA(r, g, b, a)
      LMP:RefreshPins(Destinations.PIN_TYPES.FISHINGDONE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
    default = { r = Destinations.defaults.pins.pinTextureFishDone.tint[1], g = Destinations.defaults.pins.pinTextureFishDone.tint[2], b = Destinations.defaults.pins.pinTextureFishDone.tint[3], a = Destinations.defaults.pins.pinTextureFishDone.tint[4] }
  }
  -- Fish Completed pin text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_FISHING_COLOR_DONE),
    tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_DONE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureFishDone.textcolor) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureFishDone.textcolor = { r, g, b }
      RedrawAllPins(Destinations.PIN_TYPES.FISHINGDONE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
    default = { r = Destinations.defaults.pins.pinTextureFishDone.textcolor[1], g = Destinations.defaults.pins.pinTextureFishDone.textcolor[2], b = Destinations.defaults.pins.pinTextureFishDone.textcolor[3] }
  }
  -- Fish Completed pin bait text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_FISHING_COLOR_BAIT_DONE),
    tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_BAIT_DONE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureFishDone.textcolorBait) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureFishDone.textcolorBait = { r, g, b }
      RedrawAllPins(Destinations.PIN_TYPES.FISHING)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
    default = { r = Destinations.defaults.pins.pinTextureFishDone.textcolorBait[1], g = Destinations.defaults.pins.pinTextureFishDone.textcolorBait[2], b = Destinations.defaults.pins.pinTextureFishDone.textcolorBait[3] }
  }
  -- Fish Completed pin water text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_FISHING_COLOR_WATER_DONE),
    tooltip = GetString(DEST_SETTINGS_FISHING_COLOR_WATER_DONE_TT),
    getFunc = function() return unpack(Destinations.SV.pins.pinTextureFishDone.textcolorWater) end,
    setFunc = function(r, g, b)
      Destinations.SV.pins.pinTextureFishDone.textcolorWater = { r, g, b }
      RedrawAllPins(Destinations.PIN_TYPES.FISHING)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
    default = { r = Destinations.defaults.pins.pinTextureFishDone.textcolorWater[1], g = Destinations.defaults.pins.pinTextureFishDone.textcolorWater[2], b = Destinations.defaults.pins.pinTextureFishDone.textcolorWater[3] }
  }
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_FISHING_MISC_HEADER)),
  }
  -- Fish on compass toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_FISHING_COMPASS_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_FISHING_COMPASS_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING_COMPASS] end,
    setFunc = function(state)
      Destinations:TogglePins(Destinations.PIN_TYPES.FISHING_COMPASS, state)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.FISHING)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.FISHINGDONE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
    default = Destinations.defaults.filters[Destinations.PIN_TYPES.FISHING_COMPASS],
  }
  -- Fish compass distance
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_FISHING_COMPASS_DIST),
    tooltip = GetString(DEST_SETTINGS_FISHING_COMPASS_DIST_TT),
    min = 1,
    max = 100,
    getFunc = function() return Destinations.SV.pins.pinTextureFish.maxDistance * 1000 end,
    setFunc = function(maxDistance)
      Destinations.SV.pins.pinTextureFish.maxDistance = maxDistance / 1000
      Destinations.SV.pins.pinTextureFishDone.maxDistance = maxDistance / 1000
      COMPASS_PINS.pinLayouts[Destinations.PIN_TYPES.FISHING].maxDistance = maxDistance / 1000
      COMPASS_PINS.pinLayouts[Destinations.PIN_TYPES.FISHINGDONE].maxDistance = maxDistance / 1000
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.FISHING)
      RedrawCompassPinsOnly(Destinations.PIN_TYPES.FISHINGDONE)
    end,
    width = "full",
    disabled = function() return (not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE]) or not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING_COMPASS] end,
    default = Destinations.defaults.pins.pinTextureFish.maxDistance * 1000,
  }
  -- Fish pin size
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_FISHING_PIN_SIZE),
    tooltip = GetString(DEST_SETTINGS_FISHING_PIN_SIZE_TT),
    min = 20,
    max = 70,
    getFunc = function() return Destinations.SV.pins.pinTextureFish.size end,
    setFunc = function(size)
      Destinations.SV.pins.pinTextureFish.size = size
      Destinations.SV.pins.pinTextureFishDone.size = size
      FishPreview:SetDimensions(size, size)
      FishDonePreview:SetDimensions(size, size)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.FISHING, "size", size)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.FISHINGDONE, "size", size)
      RedrawAllPins(Destinations.PIN_TYPES.FISHING)
      RedrawAllPins(Destinations.PIN_TYPES.FISHINGDONE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
    default = Destinations.defaults.pins.pinTextureFish.size
  }
  -- Fish pin layer
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "slider",
    name = GetString(DEST_SETTINGS_FISHING_PIN_LAYER),
    tooltip = GetString(DEST_SETTINGS_FISHING_PIN_LAYER_TT),
    min = 10,
    max = 200,
    step = 5,
    getFunc = function() return Destinations.SV.pins.pinTextureFish.level end,
    setFunc = function(level)
      Destinations.SV.pins.pinTextureFish.level = level + DESTINATIONS_PIN_PRIORITY_OFFSET
      Destinations.SV.pins.pinTextureFishDone.level = level
      LMP:SetLayoutKey(Destinations.PIN_TYPES.FISHING, "level", level + DESTINATIONS_PIN_PRIORITY_OFFSET)
      LMP:SetLayoutKey(Destinations.PIN_TYPES.FISHINGDONE, "level", level)
      RedrawAllPins(Destinations.PIN_TYPES.FISHING)
      RedrawAllPins(Destinations.PIN_TYPES.FISHINGDONE)
    end,
    disabled = function() return not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHING] and not Destinations.CSSV.filters[Destinations.PIN_TYPES.FISHINGDONE] end,
    default = Destinations.defaults.pins.pinTextureFish.level
  }
  local mapFilters = #optionsTable + 1
  optionsTable[mapFilters] = { -- Map Filters submenu
    type = "submenu",
    name = Destinations.defaults.miscColorCodes.settingsTextFish:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_HEADER)),
    tooltip = GetString(DEST_SETTINGS_MAPFILTERS_HEADER_TT),
    controls = {}
  }
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = { -- Header
    type = "header",
    name = Destinations.defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_SUBHEADER)),
  }
  -- Map Filter POIs toggle
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_POIS_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_MAPFILTERS_POIS_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.settings.MapFiltersPOIs end,
    setFunc = function(state)
      Destinations.CSSV.settings.activateReloaduiButton = true
      Destinations.CSSV.settings.MapFiltersPOIs = state
    end,
    warning = Destinations.defaults.miscColorCodes.settingsTextReloadWarning:Colorize(GetString(RELOADUI_INFO)),
    default = Destinations.defaults.settings.MapFiltersPOIs,
  }
  -- Map Filter Achievements toggle
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_ACHS_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_MAPFILTERS_ACHS_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.settings.MapFiltersAchievements end,
    setFunc = function(state)
      Destinations.CSSV.settings.activateReloaduiButton = true
      Destinations.CSSV.settings.MapFiltersAchievements = state
    end,
    warning = Destinations.defaults.miscColorCodes.settingsTextReloadWarning:Colorize(GetString(RELOADUI_INFO)),
    default = Destinations.defaults.settings.MapFiltersAchievements,
  }
  -- Map Filter Collectibles toggle
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_COLS_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_MAPFILTERS_COLS_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.settings.MapFiltersCollectibles end,
    setFunc = function(state)
      Destinations.CSSV.settings.activateReloaduiButton = true
      Destinations.CSSV.settings.MapFiltersCollectibles = state
    end,
    warning = Destinations.defaults.miscColorCodes.settingsTextReloadWarning:Colorize(GetString(RELOADUI_INFO)),
    default = Destinations.defaults.settings.MapFiltersCollectibles,
  }
  -- Map Filter Fishing toggle
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_FISS_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_MAPFILTERS_FISS_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.settings.MapFiltersFishing end,
    setFunc = function(state)
      Destinations.CSSV.settings.activateReloaduiButton = true
      Destinations.CSSV.settings.MapFiltersFishing = state
    end,
    warning = Destinations.defaults.miscColorCodes.settingsTextReloadWarning:Colorize(GetString(RELOADUI_INFO)),
    default = Destinations.defaults.settings.MapFiltersFishing,
  }
  -- Map Filter Misc toggle
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = {
    type = "checkbox",
    name = Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_MISS_TOGGLE)) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_MAPFILTERS_MISS_TOGGLE_TT) .. " " .. Destinations.defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return Destinations.CSSV.settings.MapFiltersMisc end,
    setFunc = function(state)
      Destinations.CSSV.settings.activateReloaduiButton = true
      Destinations.CSSV.settings.MapFiltersMisc = state
    end,
    warning = Destinations.defaults.miscColorCodes.settingsTextReloadWarning:Colorize(GetString(RELOADUI_INFO)),
    default = Destinations.defaults.settings.MapFiltersMisc,
  }
  -- Map Filter ReloadUI Button
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = {
    type = "button",
    name = GetString(DEST_SETTINGS_RELOADUI),
    tooltip = GetString(RELOADUI_WARNING),
    func = function()
      Destinations.CSSV.settings.activateReloaduiButton = false
      ReloadUI()
    end,
    disabled = function() return not Destinations.CSSV.settings.activateReloaduiButton
    end,
  }

  LAM:RegisterOptionControls("Destinations_OptionsPanel", optionsTable)

end

