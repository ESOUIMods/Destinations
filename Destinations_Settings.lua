local LAM = LibAddonMenu2
local defaults = Destinations.defaults

function Destinations:InitSettings()

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

  --Icon Preview
  local unknownPoiPreview, otherPreview, otherPreviewDone, MaiqPreview, MaiqPreviewDone, PeacemakerPreview, PeacemakerPreviewDone, NosediverPreview, NosediverPreviewDone
  local EarthlyPosPreview, EarthlyPosPreviewDone, OnMePreview, OnMePreviewDone, BrawlPreview, BrawlPreviewDone, PatronPreview, PatronPreviewDone
  local WrothgarJumperPreview, WrothgarJumperPreviewDone, RelicHunterPreview, RelicHunterPreviewDone, BreakingPreview, BreakingPreviewDone, CutpursePreview, CutpursePreviewDone
  local ChampionPreview, ChampionPreviewDone, AyleidPreview, DwemerPreview, WWVampPreview, VampAltarPreview, WWShrinePreview
  local CollectiblePreview, CollectibleDonePreview, FishPreview, FishDonePreview

  local CreateIcons = function(panel)
    if panel == settingsPanel then
      unknownPoiPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureUnknown, CT_TEXTURE)
      unknownPoiPreview:SetAnchor(RIGHT, previewpinTextureUnknown.dropdown:GetControl(), LEFT, -10, 0)
      unknownPoiPreview:SetTexture(pinTextures.paths.Unknown[DestinationsSV.pins.pinTextureUnknown.type])
      unknownPoiPreview:SetDimensions(DestinationsSV.pins.pinTextureUnknown.size, DestinationsSV.pins.pinTextureUnknown.size)
      unknownPoiPreview:SetColor(unpack(DestinationsSV.pins.pinTextureUnknown.tint))

      otherPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureOther, CT_TEXTURE)
      otherPreview:SetAnchor(RIGHT, previewpinTextureOther.dropdown:GetControl(), LEFT, -40, 0)
      otherPreview:SetTexture(pinTextures.paths.Other[DestinationsSV.pins.pinTextureOther.type])
      otherPreview:SetDimensions(DestinationsSV.pins.pinTextureOther.size, DestinationsSV.pins.pinTextureOther.size)
      otherPreview:SetColor(unpack(DestinationsSV.pins.pinTextureOther.tint))

      otherPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureOther, CT_TEXTURE)
      otherPreviewDone:SetAnchor(RIGHT, previewpinTextureOther.dropdown:GetControl(), LEFT, -5, 0)
      otherPreviewDone:SetTexture(pinTextures.paths.OtherDone[DestinationsSV.pins.pinTextureOtherDone.type])
      otherPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureOtherDone.size, DestinationsSV.pins.pinTextureOtherDone.size)
      otherPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureOtherDone.tint))

      ChampionPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureChampion, CT_TEXTURE)
      ChampionPreview:SetAnchor(RIGHT, previewpinTextureChampion.dropdown:GetControl(), LEFT, -40, 0)
      ChampionPreview:SetTexture(pinTextures.paths.Champion[DestinationsSV.pins.pinTextureChampion.type])
      ChampionPreview:SetDimensions(DestinationsSV.pins.pinTextureChampion.size, DestinationsSV.pins.pinTextureChampion.size)
      ChampionPreview:SetColor(unpack(DestinationsSV.pins.pinTextureChampion.tint))

      ChampionPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureChampion, CT_TEXTURE)
      ChampionPreviewDone:SetAnchor(RIGHT, previewpinTextureChampion.dropdown:GetControl(), LEFT, -5, 0)
      ChampionPreviewDone:SetTexture(pinTextures.paths.ChampionDone[DestinationsSV.pins.pinTextureChampionDone.type])
      ChampionPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureChampionDone.size, DestinationsSV.pins.pinTextureChampionDone.size)
      ChampionPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureChampionDone.tint))

      MaiqPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureMaiq, CT_TEXTURE)
      MaiqPreview:SetAnchor(RIGHT, previewpinTextureMaiq.dropdown:GetControl(), LEFT, -40, 0)
      MaiqPreview:SetTexture(pinTextures.paths.Maiq[DestinationsSV.pins.pinTextureMaiq.type])
      MaiqPreview:SetDimensions(DestinationsSV.pins.pinTextureMaiq.size, DestinationsSV.pins.pinTextureMaiq.size)
      MaiqPreview:SetColor(unpack(DestinationsSV.pins.pinTextureMaiq.tint))

      MaiqPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureMaiq, CT_TEXTURE)
      MaiqPreviewDone:SetAnchor(RIGHT, previewpinTextureMaiq.dropdown:GetControl(), LEFT, -5, 0)
      MaiqPreviewDone:SetTexture(pinTextures.paths.MaiqDone[DestinationsSV.pins.pinTextureMaiqDone.type])
      MaiqPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureMaiqDone.size, DestinationsSV.pins.pinTextureMaiqDone.size)
      MaiqPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureMaiqDone.tint))

      PeacemakerPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTexturePeacemaker, CT_TEXTURE)
      PeacemakerPreview:SetAnchor(RIGHT, previewpinTexturePeacemaker.dropdown:GetControl(), LEFT, -40, 0)
      PeacemakerPreview:SetTexture(pinTextures.paths.Peacemaker[DestinationsSV.pins.pinTexturePeacemaker.type])
      PeacemakerPreview:SetDimensions(DestinationsSV.pins.pinTexturePeacemaker.size, DestinationsSV.pins.pinTexturePeacemaker.size)
      PeacemakerPreview:SetColor(unpack(DestinationsSV.pins.pinTexturePeacemaker.tint))

      PeacemakerPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTexturePeacemaker, CT_TEXTURE)
      PeacemakerPreviewDone:SetAnchor(RIGHT, previewpinTexturePeacemaker.dropdown:GetControl(), LEFT, -5, 0)
      PeacemakerPreviewDone:SetTexture(pinTextures.paths.PeacemakerDone[DestinationsSV.pins.pinTexturePeacemakerDone.type])
      PeacemakerPreviewDone:SetDimensions(DestinationsSV.pins.pinTexturePeacemakerDone.size, DestinationsSV.pins.pinTexturePeacemakerDone.size)
      PeacemakerPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTexturePeacemakerDone.tint))

      NosediverPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureNosediver, CT_TEXTURE)
      NosediverPreview:SetAnchor(RIGHT, previewpinTextureNosediver.dropdown:GetControl(), LEFT, -40, 0)
      NosediverPreview:SetTexture(pinTextures.paths.Nosediver[DestinationsSV.pins.pinTextureNosediver.type])
      NosediverPreview:SetDimensions(DestinationsSV.pins.pinTextureNosediver.size, DestinationsSV.pins.pinTextureNosediver.size)
      NosediverPreview:SetColor(unpack(DestinationsSV.pins.pinTextureNosediver.tint))

      NosediverPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureNosediver, CT_TEXTURE)
      NosediverPreviewDone:SetAnchor(RIGHT, previewpinTextureNosediver.dropdown:GetControl(), LEFT, -5, 0)
      NosediverPreviewDone:SetTexture(pinTextures.paths.NosediverDone[DestinationsSV.pins.pinTextureNosediverDone.type])
      NosediverPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureNosediverDone.size, DestinationsSV.pins.pinTextureNosediverDone.size)
      NosediverPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureNosediverDone.tint))

      EarthlyPosPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureEarthlyPos, CT_TEXTURE)
      EarthlyPosPreview:SetAnchor(RIGHT, previewpinTextureEarthlyPos.dropdown:GetControl(), LEFT, -40, 0)
      EarthlyPosPreview:SetTexture(pinTextures.paths.Earthlypos[DestinationsSV.pins.pinTextureEarthlyPos.type])
      EarthlyPosPreview:SetDimensions(DestinationsSV.pins.pinTextureEarthlyPos.size, DestinationsSV.pins.pinTextureEarthlyPos.size)
      EarthlyPosPreview:SetColor(unpack(DestinationsSV.pins.pinTextureEarthlyPos.tint))

      EarthlyPosPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureEarthlyPos, CT_TEXTURE)
      EarthlyPosPreviewDone:SetAnchor(RIGHT, previewpinTextureEarthlyPos.dropdown:GetControl(), LEFT, -5, 0)
      EarthlyPosPreviewDone:SetTexture(pinTextures.paths.EarthlyposDone[DestinationsSV.pins.pinTextureEarthlyPosDone.type])
      EarthlyPosPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureEarthlyPosDone.size, DestinationsSV.pins.pinTextureEarthlyPosDone.size)
      EarthlyPosPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureEarthlyPosDone.tint))

      OnMePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureOnMe, CT_TEXTURE)
      OnMePreview:SetAnchor(RIGHT, previewpinTextureOnMe.dropdown:GetControl(), LEFT, -40, 0)
      OnMePreview:SetTexture(pinTextures.paths.OnMe[DestinationsSV.pins.pinTextureOnMe.type])
      OnMePreview:SetDimensions(DestinationsSV.pins.pinTextureOnMe.size, DestinationsSV.pins.pinTextureOnMe.size)
      OnMePreview:SetColor(unpack(DestinationsSV.pins.pinTextureOnMe.tint))

      OnMePreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureOnMe, CT_TEXTURE)
      OnMePreviewDone:SetAnchor(RIGHT, previewpinTextureOnMe.dropdown:GetControl(), LEFT, -5, 0)
      OnMePreviewDone:SetTexture(pinTextures.paths.OnMeDone[DestinationsSV.pins.pinTextureOnMeDone.type])
      OnMePreviewDone:SetDimensions(DestinationsSV.pins.pinTextureOnMeDone.size, DestinationsSV.pins.pinTextureOnMeDone.size)
      OnMePreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureOnMeDone.tint))

      BrawlPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureBrawl, CT_TEXTURE)
      BrawlPreview:SetAnchor(RIGHT, previewpinTextureBrawl.dropdown:GetControl(), LEFT, -40, 0)
      BrawlPreview:SetTexture(pinTextures.paths.Brawl[DestinationsSV.pins.pinTextureBrawl.type])
      BrawlPreview:SetDimensions(DestinationsSV.pins.pinTextureBrawl.size, DestinationsSV.pins.pinTextureBrawl.size)
      BrawlPreview:SetColor(unpack(DestinationsSV.pins.pinTextureBrawl.tint))

      BrawlPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureBrawl, CT_TEXTURE)
      BrawlPreviewDone:SetAnchor(RIGHT, previewpinTextureBrawl.dropdown:GetControl(), LEFT, -5, 0)
      BrawlPreviewDone:SetTexture(pinTextures.paths.BrawlDone[DestinationsSV.pins.pinTextureBrawlDone.type])
      BrawlPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureBrawlDone.size, DestinationsSV.pins.pinTextureBrawlDone.size)
      BrawlPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureBrawlDone.tint))

      PatronPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTexturePatron, CT_TEXTURE)
      PatronPreview:SetAnchor(RIGHT, previewpinTexturePatron.dropdown:GetControl(), LEFT, -40, 0)
      PatronPreview:SetTexture(pinTextures.paths.Patron[DestinationsSV.pins.pinTexturePatron.type])
      PatronPreview:SetDimensions(DestinationsSV.pins.pinTexturePatron.size, DestinationsSV.pins.pinTexturePatron.size)
      PatronPreview:SetColor(unpack(DestinationsSV.pins.pinTexturePatron.tint))

      PatronPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTexturePatron, CT_TEXTURE)
      PatronPreviewDone:SetAnchor(RIGHT, previewpinTexturePatron.dropdown:GetControl(), LEFT, -5, 0)
      PatronPreviewDone:SetTexture(pinTextures.paths.PatronDone[DestinationsSV.pins.pinTexturePatronDone.type])
      PatronPreviewDone:SetDimensions(DestinationsSV.pins.pinTexturePatronDone.size, DestinationsSV.pins.pinTexturePatronDone.size)
      PatronPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTexturePatronDone.tint))

      WrothgarJumperPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureWrothgarJumper, CT_TEXTURE)
      WrothgarJumperPreview:SetAnchor(RIGHT, previewpinTextureWrothgarJumper.dropdown:GetControl(), LEFT, -40, 0)
      WrothgarJumperPreview:SetTexture(pinTextures.paths.WrothgarJumper[DestinationsSV.pins.pinTextureWrothgarJumper.type])
      WrothgarJumperPreview:SetDimensions(DestinationsSV.pins.pinTextureWrothgarJumper.size, DestinationsSV.pins.pinTextureWrothgarJumper.size)
      WrothgarJumperPreview:SetColor(unpack(DestinationsSV.pins.pinTextureWrothgarJumper.tint))

      WrothgarJumperPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureWrothgarJumper, CT_TEXTURE)
      WrothgarJumperPreviewDone:SetAnchor(RIGHT, previewpinTextureWrothgarJumper.dropdown:GetControl(), LEFT, -5, 0)
      WrothgarJumperPreviewDone:SetTexture(pinTextures.paths.WrothgarJumperDone[DestinationsSV.pins.pinTextureWrothgarJumperDone.type])
      WrothgarJumperPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureWrothgarJumperDone.size, DestinationsSV.pins.pinTextureWrothgarJumperDone.size)
      WrothgarJumperPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureWrothgarJumperDone.tint))

      RelicHunterPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureRelicHunter, CT_TEXTURE)
      RelicHunterPreview:SetAnchor(RIGHT, previewpinTextureRelicHunter.dropdown:GetControl(), LEFT, -40, 0)
      RelicHunterPreview:SetTexture(pinTextures.paths.RelicHunter[DestinationsSV.pins.pinTextureRelicHunter.type])
      RelicHunterPreview:SetDimensions(DestinationsSV.pins.pinTextureRelicHunter.size, DestinationsSV.pins.pinTextureRelicHunter.size)
      RelicHunterPreview:SetColor(unpack(DestinationsSV.pins.pinTextureRelicHunter.tint))

      RelicHunterPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureRelicHunter, CT_TEXTURE)
      RelicHunterPreviewDone:SetAnchor(RIGHT, previewpinTextureRelicHunter.dropdown:GetControl(), LEFT, -5, 0)
      RelicHunterPreviewDone:SetTexture(pinTextures.paths.RelicHunterDone[DestinationsSV.pins.pinTextureRelicHunterDone.type])
      RelicHunterPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureRelicHunterDone.size, DestinationsSV.pins.pinTextureRelicHunterDone.size)
      RelicHunterPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureRelicHunterDone.tint))

      BreakingPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureBreaking, CT_TEXTURE)
      BreakingPreview:SetAnchor(RIGHT, previewpinTextureBreaking.dropdown:GetControl(), LEFT, -40, 0)
      BreakingPreview:SetTexture(pinTextures.paths.Breaking[DestinationsSV.pins.pinTextureBreaking.type])
      BreakingPreview:SetDimensions(DestinationsSV.pins.pinTextureBreaking.size, DestinationsSV.pins.pinTextureBreaking.size)
      BreakingPreview:SetColor(unpack(DestinationsSV.pins.pinTextureBreaking.tint))

      BreakingPreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureBreaking, CT_TEXTURE)
      BreakingPreviewDone:SetAnchor(RIGHT, previewpinTextureBreaking.dropdown:GetControl(), LEFT, -5, 0)
      BreakingPreviewDone:SetTexture(pinTextures.paths.BreakingDone[DestinationsSV.pins.pinTextureBreakingDone.type])
      BreakingPreviewDone:SetDimensions(DestinationsSV.pins.pinTextureBreakingDone.size, DestinationsSV.pins.pinTextureBreakingDone.size)
      BreakingPreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureBreakingDone.tint))

      CutpursePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureCutpurse, CT_TEXTURE)
      CutpursePreview:SetAnchor(RIGHT, previewpinTextureCutpurse.dropdown:GetControl(), LEFT, -40, 0)
      CutpursePreview:SetTexture(pinTextures.paths.Cutpurse[DestinationsSV.pins.pinTextureCutpurse.type])
      CutpursePreview:SetDimensions(DestinationsSV.pins.pinTextureCutpurse.size, DestinationsSV.pins.pinTextureCutpurse.size)
      CutpursePreview:SetColor(unpack(DestinationsSV.pins.pinTextureCutpurse.tint))

      CutpursePreviewDone = WINDOW_MANAGER:CreateControl(nil, previewpinTextureCutpurse, CT_TEXTURE)
      CutpursePreviewDone:SetAnchor(RIGHT, previewpinTextureCutpurse.dropdown:GetControl(), LEFT, -5, 0)
      CutpursePreviewDone:SetTexture(pinTextures.paths.CutpurseDone[DestinationsSV.pins.pinTextureCutpurseDone.type])
      CutpursePreviewDone:SetDimensions(DestinationsSV.pins.pinTextureCutpurseDone.size, DestinationsSV.pins.pinTextureCutpurseDone.size)
      CutpursePreviewDone:SetColor(unpack(DestinationsSV.pins.pinTextureCutpurseDone.tint))

      AyleidPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureAyleid, CT_TEXTURE)
      AyleidPreview:SetAnchor(RIGHT, previewpinTextureAyleid.dropdown:GetControl(), LEFT, -10, 0)
      AyleidPreview:SetTexture(pinTextures.paths.Ayleid[DestinationsSV.pins.pinTextureAyleid.type])
      AyleidPreview:SetDimensions(DestinationsSV.pins.pinTextureAyleid.size, DestinationsSV.pins.pinTextureAyleid.size)
      AyleidPreview:SetColor(unpack(DestinationsSV.pins.pinTextureAyleid.tint))

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
      VampAltarPreview:SetDimensions(DestinationsSV.pins.pinTextureVampAltar.size, DestinationsSV.pins.pinTextureVampAltar.size)
      VampAltarPreview:SetColor(unpack(DestinationsSV.pins.pinTextureVampAltar.tint))

      WWShrinePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureWWShrine, CT_TEXTURE)
      WWShrinePreview:SetAnchor(RIGHT, previewpinTextureWWShrine.dropdown:GetControl(), LEFT, -10, 0)
      WWShrinePreview:SetTexture(pinTextures.paths.werewolfshrine[DestinationsSV.pins.pinTextureWWShrine.type])
      WWShrinePreview:SetDimensions(DestinationsSV.pins.pinTextureWWShrine.size, DestinationsSV.pins.pinTextureWWShrine.size)
      WWShrinePreview:SetColor(unpack(DestinationsSV.pins.pinTextureWWShrine.tint))

      CollectiblePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureCollectible, CT_TEXTURE)
      CollectiblePreview:SetAnchor(RIGHT, previewpinTextureCollectible.dropdown:GetControl(), LEFT, -40, 0)
      CollectiblePreview:SetTexture(pinTextures.paths.collectible[DestinationsSV.pins.pinTextureCollectible.type])
      CollectiblePreview:SetDimensions(DestinationsSV.pins.pinTextureCollectible.size, DestinationsSV.pins.pinTextureCollectible.size)
      CollectiblePreview:SetColor(unpack(DestinationsSV.pins.pinTextureCollectible.tint))

      CollectibleDonePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureCollectible, CT_TEXTURE)
      CollectibleDonePreview:SetAnchor(RIGHT, previewpinTextureCollectible.dropdown:GetControl(), LEFT, -5, 0)
      CollectibleDonePreview:SetTexture(pinTextures.paths.collectibledone[DestinationsSV.pins.pinTextureCollectibleDone.type])
      CollectibleDonePreview:SetDimensions(DestinationsSV.pins.pinTextureCollectibleDone.size, DestinationsSV.pins.pinTextureCollectibleDone.size)
      CollectibleDonePreview:SetColor(unpack(DestinationsSV.pins.pinTextureCollectibleDone.tint))

      FishPreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureFish, CT_TEXTURE)
      FishPreview:SetAnchor(RIGHT, previewpinTextureFish.dropdown:GetControl(), LEFT, -40, 0)
      FishPreview:SetTexture(pinTextures.paths.fish[DestinationsSV.pins.pinTextureFish.type])
      FishPreview:SetDimensions(DestinationsSV.pins.pinTextureFish.size, DestinationsSV.pins.pinTextureFish.size)
      FishPreview:SetColor(unpack(DestinationsSV.pins.pinTextureFish.tint))

      FishDonePreview = WINDOW_MANAGER:CreateControl(nil, previewpinTextureFish, CT_TEXTURE)
      FishDonePreview:SetAnchor(RIGHT, previewpinTextureFish.dropdown:GetControl(), LEFT, -5, 0)
      FishDonePreview:SetTexture(pinTextures.paths.fishdone[DestinationsSV.pins.pinTextureFishDone.type])
      FishDonePreview:SetDimensions(DestinationsSV.pins.pinTextureFishDone.size, DestinationsSV.pins.pinTextureFishDone.size)
      FishDonePreview:SetColor(unpack(DestinationsSV.pins.pinTextureFishDone.tint))

      CALLBACK_MANAGER:UnregisterCallback("LAM-PanelControlsCreated", CreateIcons)
    end
  end

  CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", CreateIcons)

  local optionsTable = {}
  optionsTable[#optionsTable + 1] = { -- Toggle using Account Wide settings
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
  }

  if DestinationsAWSV.settings.useAccountWide then
    optionsTable[#optionsTable + 1] = { -- Account wide tip
      type = "description",
      text = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_HEADER)),
    }
  end
  -- POI Improvements submenu
  local poiImprovements = #optionsTable + 1
  optionsTable[poiImprovements] = {
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextImprove:Colorize(GetString(DEST_SETTINGS_IMPROVEMENT_HEADER)),
    tooltip = GetString(DEST_SETTINGS_IMPROVEMENT_HEADER_TT),
    controls = {}
  }
  -- Add english name of POI
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_POI_SHOW_ENGLISH),
    tooltip = GetString(DEST_SETTINGS_POI_SHOW_ENGLISH_TT),
    getFunc = function() return DestinationsSV.settings.AddEnglishOnUnknwon end,
    setFunc = function(state) DestinationsSV.settings.AddEnglishOnUnknwon = state end,
    default = defaults.settings.AddEnglishOnUnknwon,
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
      DestinationsSV.settings.EnglishColorPOI = DEST_PIN_TEXT_COLOR_ENGLISH_POI:ToHex()
    end,
    default = ZO_HIGHLIGHT_TEXT,
    disabled = function() return not DestinationsSV.settings.AddEnglishOnUnknwon end,
  }
  -- Add English name on Keeps
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_POI_SHOW_ENGLISH_KEEPS),
    tooltip = GetString(DEST_SETTINGS_POI_SHOW_ENGLISH_KEEPS_TT),
    getFunc = function() return DestinationsSV.settings.AddEnglishOnKeeps end,
    setFunc = function(state) DestinationsSV.settings.AddEnglishOnKeeps = state end,
    default = defaults.settings.AddEnglishOnKeeps,
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
      DestinationsSV.settings.EnglishColorKeeps = DEST_PIN_TEXT_COLOR_ENGLISH_KEEP:ToHex()
    end,
    default = STAT_DIMINISHING_RETURNS_COLOR,
    disabled = function() return not DestinationsSV.settings.AddEnglishOnKeeps end,
  }
  -- Hide alliance on keep tooltips
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_HA),
    tooltip = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_HA_TT),
    getFunc = function() return DestinationsSV.settings.HideAllianceOnKeeps end,
    setFunc = function(value) DestinationsSV.settings.HideAllianceOnKeeps = value end,
    default = DestinationsSV.settings.HideAllianceOnKeeps,
    disabled = function() return not DestinationsSV.settings.AddEnglishOnKeeps end,
  }
  -- Add a new line for english name on keep tooltips
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_NL),
    tooltip = GetString(DEST_SETTINGS_POI_ENGLISH_KEEPS_NL_TT),
    getFunc = function() return DestinationsSV.settings.AddNewLineOnKeeps end,
    setFunc = function(value) DestinationsSV.settings.AddNewLineOnKeeps = value end,
    default = defaults.settings.AddNewLineOnKeeps,
    disabled = function() return not DestinationsSV.settings.AddEnglishOnKeeps end,
  }
  -- Improve Mundus POI
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_POI_IMPROVE_MUNDUS),
    tooltip = GetString(DEST_SETTINGS_POI_IMPROVE_MUNDUS_TT),
    getFunc = function() return DestinationsSV.settings.ImproveMundus end,
    setFunc = function(state) DestinationsSV.settings.ImproveMundus = state end,
    default = defaults.settings.ImproveMundus,
  }
  -- Improve Crafting Stations POI
  optionsTable[poiImprovements].controls[#optionsTable[poiImprovements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_POI_IMPROVE_CRAFTING),
    tooltip = GetString(DEST_SETTINGS_POI_IMPROVE_CRAFTING_TT),
    getFunc = function() return DestinationsSV.settings.ImproveCrafting end,
    setFunc = function(state) DestinationsSV.settings.ImproveCrafting = state end,
    default = defaults.settings.ImproveCrafting,
  }
  -- Points of Interest submenu
  local unknownPointsOfInterest = #optionsTable + 1
  optionsTable[unknownPointsOfInterest] = {
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextUnknown:Colorize(GetString(DEST_SETTINGS_POI_HEADER)),
    tooltip = GetString(DEST_SETTINGS_POI_HEADER_TT),
    controls = {}
  }
  -- Unknown pin toggle
  optionsTable[unknownPointsOfInterest].controls[#optionsTable[unknownPointsOfInterest].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_UNKNOWN_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.UNKNOWN] end,
    setFunc = function(state)
      TogglePins(DPINS.UNKNOWN, state)
    end,
    default = defaults.filters[DPINS.UNKNOWN],
  }
  -- Unknown pin style
  optionsTable[unknownPointsOfInterest].controls[#optionsTable[unknownPointsOfInterest].controls + 1] = {
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
  }
  -- Unknown pin size
  optionsTable[unknownPointsOfInterest].controls[#optionsTable[unknownPointsOfInterest].controls + 1] = {
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
  }
  -- Unknown pin layer
  optionsTable[unknownPointsOfInterest].controls[#optionsTable[unknownPointsOfInterest].controls + 1] = {
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
  }
  -- Unknown pin text color
  optionsTable[unknownPointsOfInterest].controls[#optionsTable[unknownPointsOfInterest].controls + 1] = {
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
  }
  -- Achievements submenu
  local achievements = #optionsTable + 1
  optionsTable[achievements] = {
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextAchievements:Colorize(GetString(DEST_SETTINGS_ACH_HEADER)),
    tooltip = GetString(DEST_SETTINGS_ACH_HEADER_TT),
    controls = { }
  }
  -- Champion Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_CHAMPION_PIN_HEADER)),
  }
  -- Champion global pin toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.CHAMPION] end,
    setFunc = function(state)
      TogglePins(DPINS.CHAMPION, state)
      RedrawAllPins(DPINS.CHAMPION)
    end,
    default = defaults.filters[DPINS.CHAMPION],
  }
  -- Champion Done global pin toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.CHAMPION_DONE] end,
    setFunc = function(state)
      TogglePins(DPINS.CHAMPION_DONE, state)
      RedrawAllPins(DPINS.CHAMPION_DONE)
    end,
    default = defaults.filters[DPINS.CHAMPION_DONE],
  }
  -- Champion zone pin toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Champion zone pin to front/back
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = GetString(DEST_SETTINGS_ACH_CHAMPION_FRONT_PIN_TOGGLE),
    tooltip = GetString(DEST_SETTINGS_ACH_CHAMPION_FRONT_PIN_TOGGLE_TT),
    getFunc = function() return DestinationsSV.settings.ShowDungeonBossesOnTop end,
    setFunc = function(state)
      local pinLevel = DestinationsSV.pins.pinTextureOther.level or defaults.pins.pinTextureOther.level
      if state == true then
        DestinationsSV.pins.pinTextureChampion.level = pinLevel + 1
        DestinationsSV.pins.pinTextureChampionDone.level = pinLevel
        LMP:SetLayoutKey(DPINS.CHAMPION, "level", pinLevel + 1)
        LMP:SetLayoutKey(DPINS.CHAMPION_DONE, "level", pinLevel)
      else
        DestinationsSV.pins.pinTextureChampion.level = 30 + 1
        DestinationsSV.pins.pinTextureChampionDone.level = 30
        LMP:SetLayoutKey(DPINS.CHAMPION, "level", DestinationsSV.pins.pinTextureChampion.level)
        LMP:SetLayoutKey(DPINS.CHAMPION_DONE, "level", DestinationsSV.pins.pinTextureChampionDone.level)
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
  }
  -- Champion pin style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Champion pin size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Other Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_OTHER_HEADER)),
  }
  -- Achievement Other Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.LB_GTTP_CP] end,
    setFunc = function(state)
      TogglePins(DPINS.LB_GTTP_CP, state)
      RedrawAllPins(DPINS.LB_GTTP_CP)
    end,
    default = defaults.filters[DPINS.LB_GTTP_CP],
  }
  -- Achievement Other Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.LB_GTTP_CP_DONE] end,
    setFunc = function(state)
      TogglePins(DPINS.LB_GTTP_CP_DONE, state)
      RedrawAllPins(DPINS.LB_GTTP_CP_DONE)
    end,
    default = defaults.filters[DPINS.LB_GTTP_CP_DONE],
  }
  -- Achievement Other Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Other size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement M'aiq Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_MAIQ_HEADER)),
  }
  -- Achievement M'aiq Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.MAIQ] end,
    setFunc = function(state)
      TogglePins(DPINS.MAIQ, state)
      RedrawAllPins(DPINS.MAIQ)
    end,
    default = defaults.filters[DPINS.MAIQ],
  }
  -- Achievement M'aiq Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.MAIQ_DONE] end,
    setFunc = function(state)
      TogglePins(DPINS.MAIQ_DONE, state)
      RedrawAllPins(DPINS.MAIQ_DONE)
    end,
    default = defaults.filters[DPINS.MAIQ_DONE],
  }
  -- Achievement M'aiq Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement M'aiq Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Peacemaker Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_PEACEMAKER_HEADER)),
  }
  -- Achievement Peacemaker Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.PEACEMAKER] end,
    setFunc = function(state)
      TogglePins(DPINS.PEACEMAKER, state)
      RedrawAllPins(DPINS.PEACEMAKER)
    end,
    default = defaults.filters[DPINS.PEACEMAKER],
  }
  -- Achievement Peacemaker Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.PEACEMAKER_DONE] end,
    setFunc = function(state)
      TogglePins(DPINS.PEACEMAKER_DONE, state)
      RedrawAllPins(DPINS.PEACEMAKER_DONE)
    end,
    default = defaults.filters[DPINS.PEACEMAKER_DONE],
  }
  -- Achievement Peacemaker Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Peacemaker Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Nosediver Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_NOSEDIVER_HEADER)),
  }
  -- Achievement Nosediver Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.NOSEDIVER] end,
    setFunc = function(state)
      TogglePins(DPINS.NOSEDIVER, state)
      RedrawAllPins(DPINS.NOSEDIVER)
    end,
    default = defaults.filters[DPINS.NOSEDIVER],
  }
  -- Achievement Nosediver Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.NOSEDIVER_DONE] end,
    setFunc = function(state)
      TogglePins(DPINS.NOSEDIVER_DONE, state)
      RedrawAllPins(DPINS.NOSEDIVER_DONE)
    end,
    default = defaults.filters[DPINS.NOSEDIVER_DONE],
  }
  -- Achievement Nosediver Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Nosediver Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Earthly Possesion Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_EARTHLYPOS_HEADER)),
  }
  -- Achievement Earthly Possesion Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.EARTHLYPOS] end,
    setFunc = function(state)
      TogglePins(DPINS.EARTHLYPOS, state)
      RedrawAllPins(DPINS.EARTHLYPOS)
    end,
    default = defaults.filters[DPINS.EARTHLYPOS],
  }
  -- Achievement Earthly Possesion Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.EARTHLYPOS_DONE] end,
    setFunc = function(state)
      TogglePins(DPINS.EARTHLYPOS_DONE, state)
      RedrawAllPins(DPINS.EARTHLYPOS_DONE)
    end,
    default = defaults.filters[DPINS.EARTHLYPOS_DONE],
  }
  -- Achievement Earthly Possesion Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Earthly Possesion Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement This One's on Me Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_ON_ME_HEADER)),
  }
  -- Achievement This One's on Me Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.ON_ME] end,
    setFunc = function(state)
      TogglePins(DPINS.ON_ME, state)
      RedrawAllPins(DPINS.ON_ME)
    end,
    default = defaults.filters[DPINS.ON_ME],
  }
  -- Achievement This One's on Me Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.ON_ME_DONE] end,
    setFunc = function(state)
      TogglePins(DPINS.ON_ME_DONE, state)
      RedrawAllPins(DPINS.ON_ME_DONE)
    end,
    default = defaults.filters[DPINS.ON_ME_DONE],
  }
  -- Achievement This One's on Me Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement This One's on Me Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement One Last Brawl Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_BRAWL_HEADER)),
  }
  -- Achievement One Last Brawl Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.BRAWL] end,
    setFunc = function(state)
      TogglePins(DPINS.BRAWL, state)
      RedrawAllPins(DPINS.BRAWL)
    end,
    default = defaults.filters[DPINS.BRAWL],
  }
  -- Achievement One Last Brawl Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.BRAWL_DONE] end,
    setFunc = function(state)
      TogglePins(DPINS.BRAWL_DONE, state)
      RedrawAllPins(DPINS.BRAWL_DONE)
    end,
    default = defaults.filters[DPINS.BRAWL_DONE],
  }
  -- Achievement One Last Brawl Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement One Last Brawl Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Orsinium Patron Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_PATRON_HEADER)),
  }
  -- Achievement Orsinium Patron Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.PATRON] end,
    setFunc = function(state)
      TogglePins(DPINS.PATRON, state)
      RedrawAllPins(DPINS.PATRON)
    end,
    default = defaults.filters[DPINS.PATRON],
  }
  -- Achievement Orsinium Patron Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.PATRON_DONE] end,
    setFunc = function(state)
      TogglePins(DPINS.PATRON_DONE, state)
      RedrawAllPins(DPINS.PATRON_DONE)
    end,
    default = defaults.filters[DPINS.PATRON_DONE],
  }
  -- Achievement Orsinium Patron Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Orsinium Patron Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Wrothgar Cliff Jumper Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_WROTHGAR_JUMPER_HEADER)),
  }
  -- Achievement Wrothgar Cliff Jumper Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER] end,
    setFunc = function(state)
      TogglePins(DPINS.WROTHGAR_JUMPER, state)
      RedrawAllPins(DPINS.WROTHGAR_JUMPER)
    end,
    default = defaults.filters[DPINS.WROTHGAR_JUMPER],
  }
  -- Achievement Wrothgar Cliff Jumper Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER_DONE] end,
    setFunc = function(state)
      TogglePins(DPINS.WROTHGAR_JUMPER_DONE, state)
      RedrawAllPins(DPINS.WROTHGAR_JUMPER_DONE)
    end,
    default = defaults.filters[DPINS.WROTHGAR_JUMPER_DONE],
  }
  -- Achievement Wrothgar Cliff Jumper Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Wrothgar Cliff Jumper Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Wrothgar Master Relic Hunter Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_RELIC_HUNTER_HEADER)),
  }
  -- Achievement Wrothgar Master Relic Hunter Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.RELIC_HUNTER] end,
    setFunc = function(state)
      TogglePins(DPINS.RELIC_HUNTER, state)
      RedrawAllPins(DPINS.RELIC_HUNTER)
    end,
    default = defaults.filters[DPINS.RELIC_HUNTER],
  }
  -- Achievement Wrothgar Master Relic Hunter Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.RELIC_HUNTER_DONE] end,
    setFunc = function(state)
      TogglePins(DPINS.RELIC_HUNTER_DONE, state)
      RedrawAllPins(DPINS.RELIC_HUNTER_DONE)
    end,
    default = defaults.filters[DPINS.RELIC_HUNTER_DONE],
  }
  -- Achievement Wrothgar Master Relic Hunter Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Wrothgar Master Relic Hunter Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Breaking and Entering Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_BREAKING_HEADER)),
  }
  -- Achievement Breaking and Entering Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.BREAKING] end,
    setFunc = function(state)
      TogglePins(DPINS.BREAKING, state)
      RedrawAllPins(DPINS.BREAKING)
    end,
    default = defaults.filters[DPINS.BREAKING],
  }
  -- Achievement Breaking and Entering Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.BREAKING_DONE] end,
    setFunc = function(state)
      TogglePins(DPINS.BREAKING_DONE, state)
      RedrawAllPins(DPINS.BREAKING_DONE)
    end,
    default = defaults.filters[DPINS.BREAKING_DONE],
  }
  -- Achievement Breaking and Entering Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement Breaking and Entering Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement A Cutpurse Above Header
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_ACH_CUTPURSE_HEADER)),
  }
  -- Achievement A Cutpurse Above Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.CUTPURSE] end,
    setFunc = function(state)
      TogglePins(DPINS.CUTPURSE, state)
      RedrawAllPins(DPINS.CUTPURSE)
    end,
    default = defaults.filters[DPINS.CUTPURSE],
  }
  -- Achievement A Cutpurse Above Done Toggle
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_ACH_PIN_TOGGLE_DONE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.CUTPURSE_DONE] end,
    setFunc = function(state)
      TogglePins(DPINS.CUTPURSE_DONE, state)
      RedrawAllPins(DPINS.CUTPURSE_DONE)
    end,
    default = defaults.filters[DPINS.CUTPURSE_DONE],
  }
  -- Achievement A Cutpurse Above Style
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  -- Achievement A Cutpurse Above Size
  optionsTable[achievements].controls[#optionsTable[achievements].controls + 1] = {
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
  }
  local achievementPositionsGlobal = #optionsTable + 1
  optionsTable[achievementPositionsGlobal] = { -- Misc POIs submenu
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextMiscellaneous:Colorize(GetString(DEST_SETTINGS_ACH_GLOBAL_HEADER)),
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
  }
  -- Achievement All Undone pin color
  optionsTable[achievementPositionsGlobal].controls[#optionsTable[achievementPositionsGlobal].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_ACH_PIN_COLOR_MISS),
    tooltip = GetString(DEST_SETTINGS_ACH_PIN_COLOR_MISS_TT),
    getFunc = function() return unpack(DestinationsSV.pins.pinTextureOther.tint) end,
    setFunc = function(r, g, b, a)
      DestinationsSV.pins.pinTextureOther.tint = { r, g, b, a }
      DEST_PIN_TINT_OTHER:SetRGBA(r, g, b, a)

      for _, pinName in pairs(drtv.AchPinTex) do
        DestinationsSV.pins[pinName].tint = { r, g, b, a }
      end
      for _, pinName in pairs(drtv.AchPins) do
        LMP:SetLayoutKey(DPINS[pinName], "tint", DEST_PIN_TINT_OTHER)
        RedrawAllPins(DPINS[pinName])
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
    not DestinationsCSSV.filters[DPINS.MAIQ] and
      not DestinationsCSSV.filters[DPINS.LB_GTTP_CP] and
      not DestinationsCSSV.filters[DPINS.PEACEMAKER] and
      not DestinationsCSSV.filters[DPINS.NOSEDIVER] and
      not DestinationsCSSV.filters[DPINS.EARTHLYPOS] and
      not DestinationsCSSV.filters[DPINS.ON_ME] and
      not DestinationsCSSV.filters[DPINS.BRAWL] and
      not DestinationsCSSV.filters[DPINS.PATRON] and
      not DestinationsCSSV.filters[DPINS.WROTHGAR_JUMPER] and
      not DestinationsCSSV.filters[DPINS.CHAMPION] and
      not DestinationsCSSV.filters[DPINS.RELIC_HUNTER] and
      not DestinationsCSSV.filters[DPINS.BREAKING] and
      not DestinationsCSSV.filters[DPINS.CUTPURSE]
    end,
    default = { r = defaults.pins.pinTextureOther.tint[1], g = defaults.pins.pinTextureOther.tint[2], b = defaults.pins.pinTextureOther.tint[3], a = defaults.pins.pinTextureOther.tint[4] }
  }
  -- Achievement All Undone pin text color
  optionsTable[achievementPositionsGlobal].controls[#optionsTable[achievementPositionsGlobal].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_ACH_TXT_COLOR_MISS),
    tooltip = GetString(DEST_SETTINGS_ACH_TXT_COLOR_MISS_TT),
    getFunc = function() return unpack(DestinationsSV.pins.pinTextureOther.textcolor) end,
    setFunc = function(r, g, b)
      for _, pinName in pairs(drtv.AchPinTex) do
        DestinationsSV.pins[pinName].textcolor = { r, g, b }
      end
      for _, pinSuffix in pairs(drtv.AchPins) do
        local colorObj = drtv.AchTextColorDefs[pinSuffix]
        if colorObj then
          colorObj:SetRGB(r, g, b)
        end
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
  }
  -- Achievement All Done pin color
  optionsTable[achievementPositionsGlobal].controls[#optionsTable[achievementPositionsGlobal].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_ACH_PIN_COLOR_DONE),
    tooltip = GetString(DEST_SETTINGS_ACH_PIN_COLOR_DONE_TT),
    getFunc = function() return unpack(DestinationsSV.pins.pinTextureOtherDone.tint) end,
    setFunc = function(r, g, b, a)
      DestinationsSV.pins.pinTextureOtherDone.tint = { r, g, b, a }
      DEST_PIN_TINT_OTHER_DONE:SetRGBA(r, g, b, a)

      for _, pinName in pairs(drtv.AchPinTex) do
        pinName = pinName .. "Done"
        DestinationsSV.pins[pinName].tint = { r, g, b, a }
      end
      for _, pinName in pairs(drtv.AchPins) do
        pinName = pinName .. "_DONE"
        LMP:SetLayoutKey(DPINS[pinName], "tint", DEST_PIN_TINT_OTHER_DONE)
        RedrawAllPins(DPINS[pinName])
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
  }
  -- Achievement All Done pin text color
  optionsTable[achievementPositionsGlobal].controls[#optionsTable[achievementPositionsGlobal].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_ACH_TXT_COLOR_DONE),
    tooltip = GetString(DEST_SETTINGS_ACH_TXT_COLOR_DONE_TT),
    getFunc = function() return unpack(DestinationsSV.pins.pinTextureOtherDone.textcolor) end,
    setFunc = function(r, g, b)
      for _, pinName in pairs(drtv.AchPinTex) do
        pinName = pinName .. "Done"
        DestinationsSV.pins[pinName].textcolor = { r, g, b }
      end
      for _, pinSuffix in pairs(drtv.AchPins) do
        local colorObj = drtv.AchTextColorDefsDone[pinSuffix]
        if colorObj then
          colorObj:SetRGB(r, g, b)
        end
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
  }
  -- Achievement All compass toggle
  optionsTable[achievementPositionsGlobal].controls[#optionsTable[achievementPositionsGlobal].controls + 1] = {
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
  }
  -- Achievement All compass distance
  optionsTable[achievementPositionsGlobal].controls[#optionsTable[achievementPositionsGlobal].controls + 1] = {
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
  }
  -- Misc POIs submenu
  local miscellaneousPOI2 = #optionsTable + 1
  optionsTable[miscellaneousPOI2] = {
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextMiscellaneous:Colorize(GetString(DEST_SETTINGS_MISC_HEADER)),
    tooltip = GetString(DEST_SETTINGS_MISC_HEADER_TT),
    controls = { }
  }
  -- Ayleid Well Header
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_AYLEID_WELL_HEADER)),
  }
  -- Ayleid Well pin toggle
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  -- Ayleid Well pintype
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  -- Ayleid Well pin size
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  -- Ayleid pin color
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_MISC_PIN_AYLEID_WELL_COLOR),
    tooltip = GetString(DEST_SETTINGS_MISC_PIN_AYLEID_WELL_COLOR_TT),
    getFunc = function() return unpack(DestinationsSV.pins.pinTextureAyleid.tint) end,
    setFunc = function(r, g, b, a)
      DestinationsSV.pins.pinTextureAyleid.tint = { r, g, b, a }
      DEST_PIN_TINT_AYLEID:SetRGBA(r, g, b, a)
      AyleidPreview:SetColor(r, g, b, a)
      RedrawAllPins(DPINS.AYLEID)
    end,
    disabled = function() return not DestinationsCSSV.filters[DPINS.AYLEID] end,
    default = { r = defaults.pins.pinTextureAyleid.tint[1], g = defaults.pins.pinTextureAyleid.tint[2], b = defaults.pins.pinTextureAyleid.tint[3], a = defaults.pins.pinTextureAyleid.tint[4] }
  }
  -- Ayleid pin text color
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_MISC_PINTEXT_AYLEID_WELL_COLOR),
    tooltip = GetString(DEST_SETTINGS_MISC_PINTEXT_AYLEID_WELL_COLOR_TT),
    getFunc = function() return unpack(DestinationsSV.pins.pinTextureAyleid.textcolor) end,
    setFunc = function(r, g, b)
      DestinationsSV.pins.pinTextureAyleid.textcolor = { r, g, b }
      DEST_PIN_TEXT_COLOR_AYLEID:SetRGB(r, g, b)
      LMP:RefreshPins(DPINS.AYLEID)
    end,
    disabled = function() return not DestinationsCSSV.filters[DPINS.AYLEID] end,
    default = { r = defaults.pins.pinTextureAyleid.textcolor[1], g = defaults.pins.pinTextureAyleid.textcolor[2], b = defaults.pins.pinTextureAyleid.textcolor[3] }
  }
  ---- Deadlands Entrance Header
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_DEADLANDS_ENTRANCE_HEADER)),
  }
  -- Deadlands pin toggle
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.DEADLANDS] end,
    setFunc = function(state)
      TogglePins(DPINS.DEADLANDS, state)
      RedrawAllPins(DPINS.DEADLANDS)
    end,
    default = defaults.filters[DPINS.DEADLANDS],
  }
  -- Deadlands pin size
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  -- Deadlands pin text color
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  -- HighIsle Druidic Shrine
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_HIGHISLE_SHRINE_HEADER)),
  }
  -- HighIsle Druidic Shrine pin toggle
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "checkbox",
    name = defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_TOGGLE)) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR)),
    tooltip = GetString(DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_TOGGLE_TT) .. " " .. defaults.miscColorCodes.settingsTextAccountWide:Colorize(GetString(DEST_SETTINGS_PER_CHAR_TOGGLE_TT)),
    getFunc = function() return DestinationsCSSV.filters[DPINS.HIGHISLE] end,
    setFunc = function(state)
      TogglePins(DPINS.HIGHISLE, state)
      RedrawAllPins(DPINS.HIGHISLE)
    end,
    default = defaults.filters[DPINS.HIGHISLE],
  }
  -- HighIsle Druidic Shrine pin size
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  -- HighIsle Druidic Shrine text color
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  -- Dwemer Ruins Header
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_DWEMER_HEADER)),
  }
  -- Dwemer pin toggle
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  -- Dwemer pin style
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  -- Dwemer pin size
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  -- Dwemer pin color
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_MISC_DWEMER_PIN_COLOR),
    tooltip = GetString(DEST_SETTINGS_MISC_DWEMER_PIN_COLOR_TT),
    getFunc = function() return unpack(DestinationsSV.pins.pinTextureDwemer.tint) end,
    setFunc = function(r, g, b, a)
      DestinationsSV.pins.pinTextureDwemer.tint = { r, g, b, a }
      DEST_PIN_TINT_DWEMER:SetRGBA(r, g, b, a)
      DwemerPreview:SetColor(r, g, b, a)
      RedrawAllPins(DPINS.DWEMER)
    end,
    disabled = function() return not DestinationsCSSV.filters[DPINS.DWEMER] end,
    default = { r = defaults.pins.pinTextureDwemer.tint[1], g = defaults.pins.pinTextureDwemer.tint[2], b = defaults.pins.pinTextureDwemer.tint[3], a = defaults.pins.pinTextureDwemer.tint[4] }
  }
  -- Dwemer pin text color
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  -- Show Misc POIs on compass
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MISC_COMPASS_HEADER)),
  }
  -- Show Misc POIs on compass toggle
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  -- Show Misc POIs on compass pin distance
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  -- Show Misc POIs on compass pin layer
  optionsTable[miscellaneousPOI2].controls[#optionsTable[miscellaneousPOI2].controls + 1] = {
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
  }
  local vampireWerewolf = #optionsTable + 1
  optionsTable[vampireWerewolf] = { -- VWW submenu
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextVWW:Colorize(GetString(DEST_SETTINGS_VWW_HEADER)),
    tooltip = GetString(DEST_SETTINGS_VWW_HEADER_TT),
    controls = { }
  }
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_VWW_WWVAMP_HEADER)),
  }
  -- Werewolf/Vampire pin toggle
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
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
  }
  -- Werewolf/Vampire pintype
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
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
  }
  -- Werewolf/Vampire pin size
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
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
  }
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_VWW_VAMP_HEADER)),
  }
  -- Vampire Alter pin toggle
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
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
  }
  -- Vampire Alter pintype
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
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
  }
  -- Vampire Alter pin size
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
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
  }
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_VWW_WW_HEADER)),
  }
  -- Werewolf Shrine pin toggle
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
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
  }
  -- Werewolf Shrine pintype
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
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
  }
  -- Werewolf Shrine pin size
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
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
  }
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_VWW_COMPASS_HEADER)),
  }
  -- Werewolf/Vampire toggle compass
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
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
  }
  -- Werewolf/Vampire compass pin distance
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
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
  }
  -- Werewolf/Vampire pin layer
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
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
  }
  -- Werewolf/Vampire pin color
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_VWW_PIN_COLOR),
    tooltip = GetString(DEST_SETTINGS_VWW_PIN_COLOR_TT),
    getFunc = function() return unpack(DestinationsSV.pins.pinTextureWWVamp.tint) end,
    setFunc = function(r, g, b, a)
      DestinationsSV.pins.pinTextureWWVamp.tint = { r, g, b, a }
      DestinationsSV.pins.pinTextureVampAltar.tint = { r, g, b, a }
      DestinationsSV.pins.pinTextureWWShrine.tint = { r, g, b, a }
      DEST_PIN_TINT_WWVAMP:SetRGBA(r, g, b, a)
      WWVampPreview:SetColor(r, g, b, a)
      DEST_PIN_TINT_VAMPALTAR:SetRGBA(r, g, b, a)
      VampAltarPreview:SetColor(r, g, b, a)
      DEST_PIN_TINT_WWSHRINE:SetRGBA(r, g, b, a)
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
  }
  -- Werewolf/Vampire pin text color
  optionsTable[vampireWerewolf].controls[#optionsTable[vampireWerewolf].controls + 1] = {
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
  }

  local collectibles = #optionsTable + 1
  optionsTable[collectibles] = { -- Collectible submenu
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextCollectibles:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_HEADER)),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_HEADER_TT),
    controls = {}
  }
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_SUBHEADER)),
  }
  -- Collectible pin toggle
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
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
  }
  -- Collectible Completed pin toggle
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
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
  }
  -- Collectible pin style
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
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
  }
  -- Collectible Name on pin toggle
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
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
  }
  -- Collectible Item on pin toggle
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
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
  }
  -- Collectible title pin text color
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
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
  }
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_COLORS_HEADER)),
  }
  -- Collectible Missing pin color
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_COLOR),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_TT),
    getFunc = function() return unpack(DestinationsSV.pins.pinTextureCollectible.tint) end,
    setFunc = function(r, g, b, a)
      DestinationsSV.pins.pinTextureCollectible.tint = { r, g, b, a }
      CollectiblePreview:SetColor(r, g, b, a)
      DEST_PIN_TINT_COLLECTIBLE:SetRGBA(r, g, b, a)
      LMP:RefreshPins(DPINS.COLLECTIBLES)
    end,
    disabled = function() return not DestinationsCSSV.filters[DPINS.COLLECTIBLES] end,
    default = { r = defaults.pins.pinTextureCollectible.tint[1], g = defaults.pins.pinTextureCollectible.tint[2], b = defaults.pins.pinTextureCollectible.tint[3], a = defaults.pins.pinTextureCollectible.tint[4] }
  }
  -- Collectible Missing pin text color
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
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
  }
  -- Collectible Completed pin color
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_DONE),
    tooltip = GetString(DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_DONE_TT),
    getFunc = function() return unpack(DestinationsSV.pins.pinTextureCollectibleDone.tint) end,
    setFunc = function(r, g, b, a)
      DestinationsSV.pins.pinTextureCollectibleDone.tint = { r, g, b, a }
      CollectibleDonePreview:SetColor(r, g, b, a)
      DEST_PIN_TINT_COLLECTIBLE_DONE:SetRGBA(r, g, b, a)
      LMP:RefreshPins(DPINS.COLLECTIBLESDONE)
    end,
    disabled = function() return not DestinationsCSSV.filters[DPINS.COLLECTIBLESDONE] end,
    default = { r = defaults.pins.pinTextureCollectibleDone.tint[1], g = defaults.pins.pinTextureCollectibleDone.tint[2], b = defaults.pins.pinTextureCollectibleDone.tint[3], a = defaults.pins.pinTextureCollectibleDone.tint[4] }
  }
  -- Collectible Completed pin text color
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
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
  }
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_COLLECTIBLES_MISC_HEADER)),
  }
  -- Collectible on compass toggle
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
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
  }
  -- Collectible compass distance
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
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
  }
  -- Collectible pin size
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
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
  }
  -- Collectible pin layer
  optionsTable[collectibles].controls[#optionsTable[collectibles].controls + 1] = {
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
  }
  local fishing = #optionsTable + 1
  optionsTable[fishing] = { -- Fish submenu
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextFish:Colorize(GetString(DEST_SETTINGS_FISHING_HEADER)),
    tooltip = GetString(DEST_SETTINGS_FISHING_HEADER_TT),
    controls = {}
  }
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = { -- Header
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_FISHING_SUBHEADER)),
  }
  -- Fish pin toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish Completed pin toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish pin style
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish pin title pin text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_FISHING_PIN_TEXT_HEADER)),
  }
  -- Fish Name on pin toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish Bait on pin toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish Bait Left on pin toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish Water on pin toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_FISHING_COLOR_HEADER)),
  }
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_FISHING_PIN_COLOR),
    tooltip = GetString(DEST_SETTINGS_FISHING_PIN_COLOR_TT),
    getFunc = function() return unpack(DestinationsSV.pins.pinTextureFish.tint) end,
    setFunc = function(r, g, b, a)
      DestinationsSV.pins.pinTextureFish.tint = { r, g, b, a }
      FishPreview:SetColor(r, g, b, a)
      DEST_PIN_TINT_FISH:SetRGBA(r, g, b, a)
      LMP:RefreshPins(DPINS.FISHING)
    end,
    disabled = function() return not DestinationsCSSV.filters[DPINS.FISHING] end,
    default = { r = defaults.pins.pinTextureFish.tint[1], g = defaults.pins.pinTextureFish.tint[2], b = defaults.pins.pinTextureFish.tint[3], a = defaults.pins.pinTextureFish.tint[4] }
  }
  -- Fish Missing pin text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish Missing pin bait text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish Missing pin water text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish Completed pin color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "colorpicker",
    name = GetString(DEST_SETTINGS_FISHING_PIN_COLOR_DONE),
    tooltip = GetString(DEST_SETTINGS_FISHING_PIN_COLOR_DONE_TT),
    getFunc = function() return unpack(DestinationsSV.pins.pinTextureFishDone.tint) end,
    setFunc = function(r, g, b, a)
      DestinationsSV.pins.pinTextureFishDone.tint = { r, g, b, a }
      FishDonePreview:SetColor(r, g, b, a)
      DEST_PIN_TINT_FISH_DONE:SetRGBA(r, g, b, a)
      LMP:RefreshPins(DPINS.FISHINGDONE)
    end,
    disabled = function() return not DestinationsCSSV.filters[DPINS.FISHINGDONE] end,
    default = { r = defaults.pins.pinTextureFishDone.tint[1], g = defaults.pins.pinTextureFishDone.tint[2], b = defaults.pins.pinTextureFishDone.tint[3], a = defaults.pins.pinTextureFishDone.tint[4] }
  }
  -- Fish Completed pin text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish Completed pin bait text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish Completed pin water text color
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_FISHING_MISC_HEADER)),
  }
  -- Fish on compass toggle
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish compass distance
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish pin size
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  -- Fish pin layer
  optionsTable[fishing].controls[#optionsTable[fishing].controls + 1] = {
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
  }
  local mapFilters = #optionsTable + 1
  optionsTable[mapFilters] = { -- Map Filters submenu
    type = "submenu",
    name = defaults.miscColorCodes.settingsTextFish:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_HEADER)),
    tooltip = GetString(DEST_SETTINGS_MAPFILTERS_HEADER_TT),
    controls = {}
  }
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = { -- Header
    type = "header",
    name = defaults.miscColorCodes.settingsTextAchHeaders:Colorize(GetString(DEST_SETTINGS_MAPFILTERS_SUBHEADER)),
  }
  -- Map Filter POIs toggle
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = {
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
  }
  -- Map Filter Achievements toggle
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = {
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
  }
  -- Map Filter Collectibles toggle
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = {
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
  }
  -- Map Filter Fishing toggle
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = {
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
  }
  -- Map Filter Misc toggle
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = {
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
  }
  -- Map Filter ReloadUI Button
  optionsTable[mapFilters].controls[#optionsTable[mapFilters].controls + 1] = {
    type = "button",
    name = GetString(DEST_SETTINGS_RELOADUI),
    tooltip = GetString(RELOADUI_WARNING),
    func = function()
      DestinationsCSSV.settings.activateReloaduiButton = false
      ReloadUI()
    end,
    disabled = function() return not DestinationsCSSV.settings.activateReloaduiButton
    end,
  }

  LAM:RegisterOptionControls("Destinations_OptionsPanel", optionsTable)

end

