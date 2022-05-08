-------------------------------------------
-- Localización en Español de Destinations -- Sharlikran
-------------------------------------------
local strings = {
  --Map Filter Tags
  DEST_FILTER_UNKNOWN = "(Dest) Puntos de interés desconocidos",
  DEST_FILTER_KNOWN = "(Dest) Puntos de interés conocidos",
  DEST_FILTER_OTHER = "(Dest) Otros logros",
  DEST_FILTER_OTHER_DONE = "(Dest) Otros logros realizados",
  DEST_FILTER_MAIQ = "(Dest) " .. zo_strformat(GetAchievementInfo(872)),
  DEST_FILTER_MAIQ_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(872)) .. " Hecho",
  DEST_FILTER_PEACEMAKER = "(Dest) " .. zo_strformat(GetAchievementInfo(716)),
  DEST_FILTER_PEACEMAKER_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(716)) .. " Hecho",
  DEST_FILTER_NOSEDIVER = "(Dest) " .. zo_strformat(GetAchievementInfo(406)),
  DEST_FILTER_NOSEDIVER_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(406)) .. " Hecho",
  DEST_FILTER_EARTHLYPOS = "(Dest) " .. zo_strformat(GetAchievementInfo(1121)),
  DEST_FILTER_EARTHLYPOS_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1121)) .. " Hecho",
  DEST_FILTER_ON_ME = "(Dest) " .. zo_strformat(GetAchievementInfo(704)),
  DEST_FILTER_ON_ME_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(704)) .. " Hecho",
  DEST_FILTER_BRAWL = "(Dest) " .. zo_strformat(GetAchievementInfo(1247)),
  DEST_FILTER_BRAWL_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1247)) .. " Hecho",
  DEST_FILTER_PATRON = "(Dest) " .. zo_strformat(GetAchievementInfo(1316)),
  DEST_FILTER_PATRON_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1316)) .. " Hecho",
  DEST_FILTER_WROTHGAR_JUMPER = "(Dest) " .. zo_strformat(GetAchievementInfo(1331)),
  DEST_FILTER_WROTHGAR_JUMPER_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1331)) .. " Hecho",
  DEST_FILTER_RELIC_HUNTER = "(Dest) " .. zo_strformat(GetAchievementInfo(1250)),
  DEST_FILTER_RELIC_HUNTER_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1250)) .. " Hecho",
  DEST_FILTER_BREAKING_ENTERING = "(Dest) " .. zo_strformat(GetAchievementInfo(1349)),
  DEST_FILTER_BREAKING_ENTERING_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1349)) .. " Hecho",
  DEST_FILTER_CUTPURSE_ABOVE = "(Dest) " .. zo_strformat(GetAchievementInfo(1383)),
  DEST_FILTER_CUTPURSE_ABOVE_DONE = "(Dest) " .. zo_strformat(GetAchievementInfo(1383)) .. " Hecho",

  DEST_FILTER_CHAMPION = "(Dest) Dungeon Champions",
  DEST_FILTER_CHAMPION_DONE = "(Dest) Campeones de la mazmorra hechos",

  DEST_FILTER_COLLECTIBLE = "(Dest) Collectibles Pins",
  DEST_FILTER_COLLECTIBLE_DONE = "(Dest) Coleccionables hechos",

  DEST_FILTER_FISHING = "(Dest) Fishing Pins",
  DEST_FILTER_FISHING_DONE = "(Dest) Pesca realizada",

  DEST_FILTER_QUESTGIVER = "(Dest) Quest Giver Pins",
  DEST_FILTER_QUESTS_IN_PROGRESS = "(Dest) Quests in progress",
  DEST_FILTER_QUESTS_DONE = "(Dest) Quests Done",

  DEST_FILTER_AYLEID = "(Dest) Ayleid Wells",
  DEST_FILTER_DEADLANDS_ENTRANCE = "(Dest) Deadlands Entrance",
  DEST_FILTER_HIGHISLE_DRUIDICSHRINE = "(Dest) Druidic Shrine",
  DEST_FILTER_DWEMER = "(Dest) Ruinas Dwemer",
  DEST_FILTER_BORDER = "(Dest) Craglorn Border Line",

  DEST_FILTER_WWVAMP = "(Dest) Hombres lobo y vampiros",
  DEST_FILTER_VAMPIRE_ALTAR = "(Dest) Vampire Alters",
  DEST_FILTER_WEREWOLF_SHRINE = "(Dest) Werewolf Shrines",

  --Settings Menu
  DEST_SETTINGS_TITLE = "Destinations",

  DEST_SETTINGS_IMPROVEMENT_HEADER = "Mejora de PDI",
  DEST_SETTINGS_IMPROVEMENT_HEADER_TT = "Mejora de los PDI desconocidos y conocidos",
  DEST_SETTINGS_POI_ENGLISH_TEXT_HEADER = "Texto en inglés sobre los puntos de interés",
  DEST_SETTINGS_POI_SHOW_ENGLISH = "Mostrar nombres de PDI en inglés",
  DEST_SETTINGS_POI_SHOW_ENGLISH_TT = "Mostrar nombres de PDI en inglés en la parte superior del mapa",
  DEST_SETTINGS_POI_ENGLISH_COLOR = "Color del texto para los nombres de PDI en inglés",
  DEST_SETTINGS_POI_ENGLISH_COLOR_TT = "Establecer el color del texto para la traducción al inglés de los nombres de los PDI",
  DEST_SETTINGS_POI_SHOW_ENGLISH_KEEPS = "Mostrar nombres de PDI en inglés para los Keeps",
  DEST_SETTINGS_POI_SHOW_ENGLISH_KEEPS_TT = "Mostrar los nombres de los PDI en inglés en el tooltip de los guardados",
  DEST_SETTINGS_POI_ENGLISH_KEEPS_COLOR = "Color del texto para los nombres de las bodegas en inglés",
  DEST_SETTINGS_POI_ENGLISH_KEEPS_COLOR_TT = "Establecer el color del texto para la traducción al inglés de los nombres de las bodegas",
  DEST_SETTINGS_POI_ENGLISH_KEEPS_HA = "Ocultar el nombre de la alianza en la información sobre las bodegas",
  DEST_SETTINGS_POI_ENGLISH_KEEPS_HA_TT = "Ocultar el nombre de la alianza en la información sobre las bodegas",
  DEST_SETTINGS_POI_ENGLISH_KEEPS_NL = "Añadir una nueva línea en la información de herramientas de Keeps",
  DEST_SETTINGS_POI_ENGLISH_KEEPS_NL_TT = "Añadir una nueva línea en la información de herramientas de Keeps para el nombre en inglés",
  DEST_SETTINGS_POI_IMPROVE_MUNDUS = "Mejorar los PDI de Mundus",
  DEST_SETTINGS_POI_IMPROVE_MUNDUS_TT = "Mejorar los POIs de Mundus añadiendo la descripción del efecto en la información sobre la herramienta",
  DEST_SETTINGS_POI_IMPROVE_CRAFTING = "Mejora de los PDI de artesanía",
  DEST_SETTINGS_POI_IMPROVE_CRAFTING_TT = "Mejora de los PDI de artesanía añadiendo la descripción del conjunto en la información sobre herramientas",

  DEST_SETTINGS_USE_ACCOUNTWIDE = "Utilizar la configuración de la cuenta",
  DEST_SETTINGS_USE_ACCOUNTWIDE_TT = "Si está activado, los ajustes serán los mismos para TODOS los personajes",
  DEST_SETTINGS_RELOAD_WARNING = "El cambio de esta configuración forzará un /reloadui instantáneo",
  DEST_SETTINGS_PER_CHAR_HEADER = "Los ajustes marcados con un '*' amarillo sólo afectan al carácter actual",
  DEST_SETTINGS_PER_CHAR = "*",
  DEST_SETTINGS_PER_CHAR_TOGGLE_TT = "Este interruptor sólo afecta al carácter actual",
  DEST_SETTINGS_PER_CHAR_BUTTON_TT = "Este botón sólo afecta al carácter actual",

  DEST_SETTINGS_POI_HEADER = "Puntos de interés desconocidos",
  DEST_SETTINGS_POI_HEADER_TT = "Este submenú cubre los Puntos de Interés Desconocidos",
  DEST_SETTINGS_POI_UNKOWN_SUBHEADER = "Puede que no se utilice",
  DEST_SETTINGS_POI_KNOWN_SUBHEADER = "Puede que no se utilice",
  DEST_SETTINGS_POIS_ENGLISH_TEXT_HEADER = "Esto puede no ser utilizado",

  DEST_SETTINGS_UNKNOWN_PIN_TOGGLE = "Mostrar PDIs desconocidos",
  DEST_SETTINGS_UNKNOWN_PIN_STYLE = "Pines de mapa para PDIs desconocidos",
  DEST_SETTINGS_UNKNOWN_PIN_SIZE = "Tamaño de la clavija para PDIs desconocidos",
  DEST_SETTINGS_UNKNOWN_PIN_LAYER = "Capa de pines para PDIs desconocidos",
  DEST_SETTINGS_UNKNOWN_COLOR = "Color del texto de la chincheta para PDIs desconocidos",
  DEST_SETTINGS_UNKNOWN_COLOR_TT = "Afecta a todos los puntos de interés desconocidos",
  DEST_SETTINGS_UNKNOWN_COLOR_EN = "Color del texto del pin (inglés)",
  DEST_SETTINGS_UNKNOWN_COLOR_EN_TT = "Afecta al texto en inglés de todos los Puntos de Interés desconocidos, si está activado",
  DEST_SETTINGS_KNOWN_PIN_TOGGLE = "Mostrar PDIs ya conocidos",
  DEST_SETTINGS_KNOWN_PIN_STYLE = "Pines del mapa para PDIs conocidos",
  DEST_SETTINGS_KNOWN_PIN_SIZE = "Tamaño de la clavija para los PDI conocidos",
  DEST_SETTINGS_KNOWN_PIN_LAYER = "Capa de puntos de interés conocidos",
  DEST_SETTINGS_KNOWN_COLOR = "Color del texto de la chincheta para los PDI conocidos",
  DEST_SETTINGS_KNOWN_COLOR_TT = "Afecta a todos los puntos de interés conocidos",
  DEST_SETTINGS_KNOWN_COLOR_EN = "Color del texto del pin (inglés)",
  DEST_SETTINGS_KNOWN_COLOR_EN_TT = "Afecta al texto en inglés de todos los Puntos de Interés conocidos, si está activado",
  DEST_SETTINGS_MUNDUS_DETAIL_PIN_TOGGLE = "Mostrar detalles de Mundus",
  DEST_SETTINGS_MUNDUS_TXT_COLOR = "Color del texto de Mundus Stone",
  DEST_SETTINGS_MUNDUS_TXT_COLOR_TT = "Afecta al TEXTO DETALLADO de las piedras Mundus",
  DEST_SETTINGS_GTRADER_COLOR = "Color del texto de la insignia del comerciante del gremio",
  DEST_SETTINGS_GTRADER_COLOR_TT = "Afecta al texto del comerciante del gremio en los caminos",

  DEST_SETTINGS_ACH_HEADER = "Posiciones de logro",
  DEST_SETTINGS_ACH_HEADER_TT = "Este submenú abarca la mayoría de los logros del juego (demasiados para enumerarlos aquí)",
  DEST_SETTINGS_ACH_PIN_TOGGLE = "Mostrar logros incompletos",
  DEST_SETTINGS_ACH_PIN_TOGGLE_DONE = "Mostrar logro completado",
  DEST_SETTINGS_ACH_PIN_STYLE = "Estilo de pin para el logro",
  DEST_SETTINGS_ACH_PIN_SIZE = "Tamaño del pin para el logro",

  DEST_SETTINGS_ACH_OTHER_HEADER = "Lightbringer, Da a los pobres y el crimen paga",
  DEST_SETTINGS_ACH_MAIQ_HEADER = "Me gusta M'aiq",
  DEST_SETTINGS_ACH_PEACEMAKER_HEADER = "Pacificador",
  DEST_SETTINGS_ACH_NOSEDIVER_HEADER = "Nose Diver",
  DEST_SETTINGS_ACH_EARTHLYPOS_HEADER = "Posesiones terrenales",
  DEST_SETTINGS_ACH_ON_ME_HEADER = "Esta la pago yo",
  DEST_SETTINGS_ACH_BRAWL_HEADER = "Una última pelea",
  DEST_SETTINGS_ACH_PATRON_HEADER = "Orsinium Patron",
  DEST_SETTINGS_ACH_WROTHGAR_JUMPER_HEADER = "Wrothgar Saltador de Acantilados",
  DEST_SETTINGS_ACH_RELIC_HUNTER_HEADER = "Wrothgar Master Relic Hunter",
  DEST_SETTINGS_ACH_BREAKING_HEADER = "Allanamiento de morada",
  DEST_SETTINGS_ACH_CUTPURSE_HEADER = "Un Ratero Mejor",

  DEST_SETTINGS_ACH_CHAMPION_PIN_HEADER = "Campeones de la mazmorra",
  DEST_SETTINGS_ACH_CHAMPION_ZONE_PIN_TOGGLE = "Mostrar en mapas de zonas",
  DEST_SETTINGS_ACH_CHAMPION_ZONE_PIN_TOGGLE_TT = "Esto es para activar/desactivar a los campeones (jefes de mazmorras en solitario) en los MAPAS DE ZONA",
  DEST_SETTINGS_ACH_CHAMPION_FRONT_PIN_TOGGLE = "Pin de zona al frente",
  DEST_SETTINGS_ACH_CHAMPION_FRONT_PIN_TOGGLE_TT = "Esto alternará si los pines de la ZONA (si están activos) deben mostrarse delante de los pines de la mazmorra o no",
  DEST_SETTINGS_ACH_CHAMPION_PIN_SIZE = "Tamaño de la clavija para los campeones de mazmorra",

  DEST_SETTINGS_ACH_GLOBAL_HEADER = "Posiciones de logro - Ajustes globales",
  DEST_SETTINGS_ACH_GLOBAL_HEADER_TT = "Este submenú abarca los ajustes de Logro Global",
  DEST_SETTINGS_ACH_ALL_PIN_LAYER = "Capa de pines para todos los logros",
  DEST_SETTINGS_ACH_PIN_COLOR_MISS = "Color del pin (incompleto)",
  DEST_SETTINGS_ACH_PIN_COLOR_MISS_TT = "Afecta al color del PIN de los logros incompletos",
  DEST_SETTINGS_ACH_TXT_COLOR_MISS = "Color del texto del pin (incompleto)",
  DEST_SETTINGS_ACH_TXT_COLOR_MISS_TT = "Afecta al pin TEXT de los logros incompletos",
  DEST_SETTINGS_ACH_PIN_COLOR_DONE = "Color del pin (completado)",
  DEST_SETTINGS_ACH_PIN_COLOR_DONE_TT = "Afecta al color del PIN de los logros completos",
  DEST_SETTINGS_ACH_TXT_COLOR_DONE = "Color del texto del pin (completado)",
  DEST_SETTINGS_ACH_TXT_COLOR_DONE_TT = "Afecta al pin TEXT de los logros completos",
  DEST_SETTINGS_ACH_ALL_COMPASS_TOGGLE = "Mostrar logros en la brújula",
  DEST_SETTINGS_ACH_ALL_COMPASS_DIST = "Distancia de la brújula",

  DEST_SETTINGS_MISC_HEADER = "Posiciones de PDI varias",
  DEST_SETTINGS_MISC_HEADER_TT = "Este submenú cubre los Pozos Ayleid, las Ruinas Dwemer y la línea de Frontera Craglorn",
  DEST_SETTINGS_MISC_AYLEID_WELL_HEADER = "Pozos de Ayleid",
  DEST_SETTINGS_MISC_DEADLANDS_ENTRANCE_HEADER = "Entrada de Deadlands",
  DEST_SETTINGS_MISC_HIGHISLE_SHRINE_HEADER = "Druidic Shrine",
  DEST_SETTINGS_MISC_DWEMER_HEADER = "Ruinas Dwemer",
  DEST_SETTINGS_MISC_COMPASS_HEADER = "Ajustes varios",
  DEST_SETTINGS_MISC_BORDER_HEADER = "Frontera Craglorn",

  DEST_SETTINGS_MISC_PIN_AYLEID_WELL_TOGGLE = "Mostrar pozos ayleides",
  DEST_SETTINGS_MISC_PIN_AYLEID_WELL_TOGGLE_TT = "Sirve para activar/desactivar los pozos de Ayleid en los mapas",
  DEST_SETTINGS_MISC_PIN_AYLEID_WELL_SIZE = "Tamaño de la clavija para los pozos de ayleo",
  DEST_SETTINGS_MISC_PIN_AYLEID_WELL_COLOR = "Color de la clavija para los pozos de Ayleid",
  DEST_SETTINGS_MISC_PIN_AYLEID_WELL_COLOR_TT = "Afecta al color del PIN para los pozos de Ayleid",
  DEST_SETTINGS_MISC_PINTEXT_AYLEID_WELL_COLOR = "Color del texto de la chincheta para los pozos de Ayleid",
  DEST_SETTINGS_MISC_PINTEXT_AYLEID_WELL_COLOR_TT = "Afecta al TEXTO del pin en los pozos de Ayleid",

  -- Deadlands
  DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_TOGGGLE = "Mostrar la entrada de las tierras muertas",
  DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_TOGGLE_TT = "Sirve para activar/desactivar la entrada a las tierras muertas en los mapas",
  DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_SIZE = "Tamaño de la clavija para la entrada de las tierras muertas",
  DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_COLOR = "Color del pin para la entrada de las tierras muertas",
  DEST_SETTINGS_MISC_PIN_DEADLANDS_ENTRANCE_COLOR_TT = "Afecta al color del PIN de la entrada de las tierras muertas",
  DEST_SETTINGS_MISC_PINTEXT_DEADLANDS_ENTRANCE_COLOR = "Color del texto del pin para la entrada de las tierras muertas",
  DEST_SETTINGS_MISC_PINTEXT_DEADLANDS_ENTRANCE_COLOR_TT = "Afecta al TEXTO del pin en la entrada de Deadlands",

  -- HighIsle
  DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_TOGGLE = "Show Druidic Shrine",
  DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_TOGGLE_TT = "This is for turning Druidic Shrines on/off on the maps",
  DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_SIZE = "Pin size for Druidic Shrines",
  DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_COLOR = "Pin color for Druidic Shrines",
  DEST_SETTINGS_MISC_PIN_HIGHISLE_DRUIDICSHRINES_COLOR_TT = "Affects the PIN color for Druidic Shrines",
  DEST_SETTINGS_MISC_PINTEXT_HIGHISLE_DRUIDICSHRINES_COLOR = "Pin text color for Druidic Shrines",
  DEST_SETTINGS_MISC_PINTEXT_HIGHISLE_DRUIDICSHRINES_COLOR_TT = "Affects the pin TEXT on Druidic Shrines",

  DEST_SETTINGS_MISC_DWEMER_PIN_TOGGLE = "Mostrar Ruinas Dwemer",
  DEST_SETTINGS_MISC_DWEMER_PIN_TOGGLE_TT = "Esto es para activar/desactivar las Ruinas Dwemer en los mapas",
  DEST_SETTINGS_MISC_DWEMER_PIN_SIZE = "Tamaño de la clavija para las Ruinas Dwemer",
  DEST_SETTINGS_MISC_DWEMER_PIN_COLOR = "Color del pin para las ruinas Dwemer",
  DEST_SETTINGS_MISC_DWEMER_PIN_COLOR_TT = "Afecta al color del PIN de las Ruinas Dwemer",
  DEST_SETTINGS_MISC_DWEMER_PINTEXT_COLOR = "Color del texto del pin para las Ruinas Dwemer",
  DEST_SETTINGS_MISC_DWEMER_PINTEXT_COLOR_TT = "Afecta al TEXTO de las clavijas en las Ruinas Dwemer",
  DEST_SETTINGS_MISC_PIN_LAYER = "Capa de pines para todos los PDIs diversos",
  DEST_SETTINGS_MISC_COMPASS_PIN_TOGGLE = "Mostrar misc POIs en la brújula",
  DEST_SETTINGS_MISC_COMPASS_DIST = "Distancia de los PDI en la brújula",
  DEST_SETTINGS_MISC_BORDER_PIN_TOGGLE = "Mostrar la línea fronteriza de Craglorn",
  DEST_SETTINGS_MISC_BORDER_PIN_TOGGLE_TT = "Muestra la línea fronteriza que divide el Alto y el Bajo Craglorn",
  DEST_SETTINGS_MISC_BORDER_SIZE = "Tamaño de la clavija para la frontera de Craglorn",
  DEST_SETTINGS_MISC_BORDER_PIN_COLOR = "Color del pin para el borde de Craglorn",
  DEST_SETTINGS_MISC_BORDER_PIN_COLOR_TT = "Afecta al color del PIN de la frontera de Craglorn",

  DEST_SETTINGS_VWW_HEADER = "Posiciones de Vampiros y Hombres Lobo",
  DEST_SETTINGS_VWW_HEADER_TT = "Este submenú cubre a los Vampiros y Hombres Lobo, incluyendo los spawns, Alters y Shrines",
  DEST_SETTINGS_VWW_WVAMP_HEADER = "Vampiros y Hombres Lobo",
  DEST_SETTINGS_VWW_VAMP_HEADER = "Altares de Vampiros",
  DEST_SETTINGS_VWW_WW_HEADER = "Santuarios de hombres lobo",
  DEST_SETTINGS_VWW_COMPASS_HEADER = "Ajustes varios",

  DEST_SETTINGS_VWW_PIN_WVAMP_TOGGLE = "Mostrar spawns de WW/Vampiros",
  DEST_SETTINGS_VWW_PIN_WVAMP_TOGGLE_TT = "Esto es para activar/desactivar la aparición de Vampiros y Hombres Lobo en los mapas",
  DEST_SETTINGS_VWW_PIN_WVAMP_SIZE = "Tamaño del pin para Hombres Lobo/Vampiros",
  DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_TOGGLE = "Mostrar Altares de Vampiros",
  DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_TOGGLE_TT = "Esto es para activar/desactivar los Alters Vampiro en los mapas",
  DEST_SETTINGS_VWW_PIN_VAMP_ALTAR_SIZE = "Tamaño de la clavija para los altares vampíricos",
  DEST_SETTINGS_VWW_PIN_WW_SHRINE_TOGGLE = "Mostrar santuarios de hombres lobo",
  DEST_SETTINGS_VWW_PIN_WW_SHRINE_TOGGLE_TT = "Sirve para activar y desactivar los santuarios de los hombres lobo en los mapas",
  DEST_SETTINGS_VWW_PIN_WW_SHRINE_SIZE = "Tamaño del pin para los santuarios de los hombres lobo",
  DEST_SETTINGS_VWW_PIN_LAYER = "Capa de pines para Hombres Lobo/Vampiros",
  DEST_SETTINGS_VWW_COMPASS_PIN_TOGGLE = "Mostrar pines en la brújula",
  DEST_SETTINGS_VWW_COMPASS_DIST = "Distancia de los pines en la brújula",
  DEST_SETTINGS_VWW_PIN_COLOR = "Color del pin para Hombres Lobo/Vampiros",
  DEST_SETTINGS_VWW_PIN_COLOR_TT = "Afecta al color del PIN de los engendros de Hombres Lobo y Vampiros, de los Altares de Vampiros y de los Santuarios de Hombres Lobo",
  DEST_SETTINGS_VWW_PINTEXT_COLOR = "Color del texto del pin para Hombres Lobo/Vampiros",
  DEST_SETTINGS_VWW_PINTEXT_COLOR_TT = "Afecta al TEXTO de las insignias en los spawns de Hombres Lobo y Vampiros, Altares de Vampiros y Santuarios de Hombres Lobo",

  DEST_SETTINGS_QUEST_HEADER = "Posiciones del buscador",
  DEST_SETTINGS_QUEST_HEADER_TT = "Este submenú abarca todos los ajustes relacionados con la búsqueda",
  DEST_SETTINGS_QUEST_UNDONE_HEADER = "Consultas incompletas",
  DEST_SETTINGS_QUEST_INPROGRESS_HEADER = "Misiones en curso",
  DEST_SETTINGS_QUEST_DONE_HEADER = "Misiones completadas",
  DEST_SETTINGS_QUEST_CADWELLS_HEADER = "Almanaque de Cadwell",
  DEST_SETTINGS_QUEST_DAILIES_HEADER = "Dailies/Repeatable",
  DEST_SETTINGS_QUEST_COMPASS_HEADER = "Misc",
  DEST_SETTINGS_QUEST_REGISTER_HEADER = "Otros",

  DEST_SETTINGS_QUEST_UNDONE_PIN_TOGGLE = "Mostrar posiciones del buscador",
  DEST_SETTINGS_QUEST_UNDONE_PIN_SIZE = "Tamaño de la clavija para los dadores de la búsqueda",
  DEST_SETTINGS_QUEST_UNDONE_PIN_COLOR = "Color de los pines para los buscadores",
  DEST_SETTINGS_QUEST_UNDONE_PIN_COLOR_TT = "Establece el color de los PINS de las misiones aún no realizadas",
  DEST_SETTINGS_QUEST_UNDONE_MAIN_PIN_COLOR = "Color de la insignia para las misiones principales",
  DEST_SETTINGS_QUEST_UNDONE_MAIN_PIN_COLOR_TT = "Establece el color de los PINES de las misiones de la LÍNEA DE LA HISTORIA PRINCIPAL que aún no se han realizado",
  DEST_SETTINGS_QUEST_UNDONE_DAY_PIN_COLOR = "Color de la insignia para las búsquedas diarias",
  DEST_SETTINGS_QUEST_UNDONE_DAY_PIN_COLOR_TT = "Establece el color de los PINES de las misiones DIARIAS aún no realizadas",
  DEST_SETTINGS_QUEST_UNDONE_REP_PIN_COLOR = "Color de la chincheta para las misiones repetibles",
  DEST_SETTINGS_QUEST_UNDONE_REP_PIN_COLOR_TT = "Establece el color de los PINS para las misiones repetibles aún no realizadas",
  DEST_SETTINGS_QUEST_UNDONE_DUN_PIN_COLOR = "Color de la chincheta para las aventuras de mazmorra",
  DEST_SETTINGS_QUEST_UNDONE_DUN_PIN_COLOR_TT = "Establece el color de los PINS para las misiones de mazmorras aún no realizadas",
  DEST_SETTINGS_QUEST_UNDONE_PINTEXT_COLOR = "Color del texto para los dadores de las misiones",
  DEST_SETTINGS_QUEST_UNDONE_PINTEXT_COLOR_TT = "Establece el color del TEXTO en los pines de las misiones aún no tomadas",
  DEST_SETTINGS_QUEST_INPROGRESS_PIN_TOGGGLE = "Mostrar misiones en curso",
  DEST_SETTINGS_QUEST_INPROGRESS_PIN_SIZE = "Tamaño de la clavija para las misiones en curso",
  DEST_SETTINGS_QUEST_INPROGRESS_PIN_COLOR = "Color de la chincheta para las misiones en curso",
  DEST_SETTINGS_QUEST_INPROGRESS_PIN_COLOR_TT = "Establece el color de los PINS de las misiones en el diario (lista de misiones)",
  DEST_SETTINGS_QUEST_INPROGRESS_PINTEXT_COLOR = "Color del texto de las misiones en curso",
  DEST_SETTINGS_QUEST_INPROGRESS_PINTEXT_COLOR_TT = "Establece el color del TEXTO de los pines de las misiones en el diario (lista de misiones)",
  DEST_SETTINGS_QUEST_DONE_PIN_TOGGLE = "Mostrar búsquedas completadas",
  DEST_SETTINGS_QUEST_DONE_PIN_SIZE = "Tamaño de la clavija para las misiones completadas",
  DEST_SETTINGS_QUEST_DONE_PIN_COLOR = "Color del pin para las misiones completadas",
  DEST_SETTINGS_QUEST_DONE_PIN_COLOR_TT = "Establece el color de los PINS de las misiones completadas",
  DEST_SETTINGS_QUEST_DONE_PINTEXT_COLOR = "Color del texto para las misiones completadas",
  DEST_SETTINGS_QUEST_DONE_PINTEXT_COLOR_TT = "Establece el color del TEXTO en los pines de las misiones completadas",
  DEST_SETTINGS_QUEST_CADWELLS_PIN_TOGGLE = "Mostrar el almanaque de Cadwell",
  DEST_SETTINGS_QUEST_CADWELLS_PIN_TOGGLE_TT = "Mostrar/Ocultar el marcador del Almanaque de Cadwell en las misiones",
  DEST_SETTINGS_QUEST_CADWELLS_ONLY_PIN_TOGGLE = "Ocultar otras misiones",
  DEST_SETTINGS_QUEST_CADWELLS_ONLY_PIN_TOGGLE_TT = "Mostrar/Ocultar todas las misiones ordinarias que NO forman parte del Almanaque de Cadwell",
  DEST_SETTINGS_QUEST_WRITS_PIN_TOGGLE = "Mostrar escrituras",
  DEST_SETTINGS_QUEST_WRITS_PIN_TOGGLE_TT = "Mostrar/Ocultar escrituras",
  DEST_SETTINGS_QUEST_DAILIES_PIN_TOGGLE = "Mostrar búsquedas diarias",
  DEST_SETTINGS_QUEST_DAILIES_PIN_TOGGLE_TT = "Mostrar/Ocultar búsquedas diarias",
  DEST_SETTINGS_QUEST_REPEATABLES_PIN_TOGGLE = "Mostrar búsquedas repetibles",
  DEST_SETTINGS_QUEST_REPEATABLES_PIN_TOGGLE_TT = "Mostrar/Ocultar las búsquedas repetibles",
  DEST_SETTINGS_QUEST_ALL_PIN_LAYER = "Capa de pines para todos los pines de Quest",
  DEST_SETTINGS_QUEST_COMPASS_TOGGLE = "Mostrar pines de búsqueda en la brújula",
  DEST_SETTINGS_QUEST_COMPASS_DIST = "Distancia para los pines de Quest en la brújula",

  DEST_SETTINGS_REGISTER_QUEST_GIVER_TOGGLE = "Ocultar el nombre del buscador",
  DEST_SETTINGS_REGISTER_QUEST_GIVER_TOGGLE_TT = "Mostrar/Ocultar el nombre del Quest giver en el tooltip",

  DEST_SETTINGS_REGISTER_QUESTS_TOGGLE = "Registrar misiones",
  DEST_SETTINGS_REGISTER_QUESTS_TOGGLE_TT = "Guarda la información de la búsqueda en las variables para los informes. Por favor, consulta la página de Destinos en ESOUI.com para más información",
  DEST_SETTINGS_QUEST_RESET_HIDDEN = "Restablecer misiones ocultas",
  DEST_SETTINGS_QUEST_RESET_HIDDEN_TT = "Restablece TODAS las misiones ocultas, y las muestra en tu mapa/radar de nuevo",

  DEST_SETTINGS_COLLECTIBLES_HEADER = "Posiciones coleccionables",
  DEST_SETTINGS_COLLECTIBLES_HEADER_TT = "Este submenú abarca todos los ajustes relacionados con los coleccionables",
  DEST_SETTINGS_COLLECTIBLES_SUBHEADER = "Ajustes coleccionables",
  DEST_SETTINGS_COLLECTIBLES_COLORS_HEADER = "Colores del pin coleccionable",
  DEST_SETTINGS_COLLECTIBLES_MISC_HEADER = "Misc",

  DEST_SETTINGS_COLLECTIBLES_TOGGLE = "Mostrar coleccionables incompletos",
  DEST_SETTINGS_COLLECTIBLES_TOGGLE_TT = "Muestra las zonas en las que se puede matar a las bestias para recoger los coleccionables de los logros",
  DEST_SETTINGS_COLLECTIBLES_DONE_TOGGLE = "Mostrar coleccionables completados",
  DEST_SETTINGS_COLLECTIBLES_DONE_TOGGLE_TT = "Mostrar áreas de Coleccionables completadas",
  DEST_SETTINGS_COLLECTIBLES_PIN_STYLE = "Estilo de pin para coleccionables",
  DEST_SETTINGS_COLLECTIBLES_SHOW_MOBNAME = "Mostrar nombres de mafias en los pines",
  DEST_SETTINGS_COLLECTIBLES_SHOW_MOBNAME_TT = "Muestra los nombres de los monstruos (en inglés de momento) que pueden soltar los objetos necesarios para completar el logro",
  DEST_SETTINGS_COLLECTIBLES_SHOW_ITEM = "Mostrar los nombres de los artículos en los pines",
  DEST_SETTINGS_COLLECTIBLES_SHOW_ITEM_TT = "Muestra el nombre de los objetos necesarios para completar el logro",
  DEST_SETTINGS_COLLECTIBLES_PIN_SIZE = "Tamaño del pin para coleccionables",
  DEST_SETTINGS_COLLECTIBLES_PIN_SIZE_TT = "Tamaño de los pines para los coleccionables",
  DEST_SETTINGS_COLLECTIBLES_PIN_LAYER = "Capa de pines para coleccionables",
  DEST_SETTINGS_COLLECTIBLES_PIN_LAYER_TT = "Capa de pines para Coleccionables",
  DEST_SETTINGS_COLLECTIBLES_COMPASS_TOGGLE = "Mostrar en la brújula",
  DEST_SETTINGS_COLLECTIBLES_COMPASS_TOGGLE_TT = "Mostrar coleccionables en la brújula",
  DEST_SETTINGS_COLLECTIBLES_COMPASS_DIST = "Distancia en la brújula",
  DEST_SETTINGS_COLLECTIBLES_COMPASS_DIST_TT = "Distancia para las áreas de Coleccionables en la brújula",
  DEST_SETTINGS_COLLECTIBLES_COLOR_TITLE = "Color del texto del título de la cabecera",
  DEST_SETTINGS_COLLECTIBLES_COLOR_TITLE_TT = "Afecta al título del texto del logro de Coleccionables",
  DEST_SETTINGS_COLLECTIBLES_PIN_COLOR = "Falta el color del pin",
  DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_TT = "Establece el color de los PINS de los coleccionables perdidos",
  DEST_SETTINGS_COLLECTIBLES_COLOR_UNDONE = "Falta el color del texto",
  DEST_SETTINGS_COLLECTIBLES_COLOR_UNDONE_TT = "Afecta al TEXTO de los pines de los Coleccionables perdidos",
  DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_DONE = "Color del pin completado",
  DEST_SETTINGS_COLLECTIBLES_PIN_COLOR_DONE_TT = "Establece el color de los PINS de los coleccionables completados",
  DEST_SETTINGS_COLLECTIBLES_COLOR_DONE = "Colordel texto terminado",
  DEST_SETTINGS_COLLECTIBLES_COLOR_DONE_TT = "Afecta al TEXTO de los pines de los Coleccionables completados",

  DEST_SETTINGS_FISHING_HEADER = "Posiciones de pesca",
  DEST_SETTINGS_FISHING_HEADER_TT = "Este submenú abarca todos los ajustes relacionados con la pesca",
  DEST_SETTINGS_FISHING_SUBHEADER = "Ajustes de pesca",
  DEST_SETTINGS_FISHING_PIN_TEXT_HEADER = "Texto del pin de pesca",
  DEST_SETTINGS_FISHING_COLOR_HEADER = "Colores del pin de pesca",
  DEST_SETTINGS_FISHING_MISC_HEADER = "Misc",

  DEST_SETTINGS_FISHING_TOGGLE = "Mostrar posiciones incompletas",
  DEST_SETTINGS_FISHING_TOGGLE_TT = "Muestra los agujeros de pesca en los que hay posibilidad de pescar para conseguir logros",
  DEST_SETTINGS_FISHING_DONE_TOGGLE = "Mostrar posiciones completadas",
  DEST_SETTINGS_FISHING_DONE_TOGGLE_TT = "Mostrar posiciones de agujeros de pesca completados",
  DEST_SETTINGS_FISHING_PIN_STYLE = "Estilo de pin para la pesca",
  DEST_SETTINGS_FISHING_SHOW_FISHNAME = "Mostrar los nombres de los peces en los pines",
  DEST_SETTINGS_FISHING_SHOW_FISHNAME_TT = "Muestra los peces que faltan para ese tipo de agua",
  DEST_SETTINGS_FISHING_SHOW_BAIT = "Mostrar el cebo óptimo en los bolos",
  DEST_SETTINGS_FISHING_SHOW_BAIT_TT = "Muestra el cebo óptimo a utilizar",
  DEST_SETTINGS_FISHING_SHOW_BAIT_LEFT = "Mostrar el cebo a la izquierda en los bolos",
  DEST_SETTINGS_FISHING_SHOW_BAIT_LEFT_TT = "Muestra cuánto cebo de los tipos óptimos te queda en la bolsa. Si hay un tercer número, ese es el cebo simple",
  DEST_SETTINGS_FISHING_SHOW_WATER = "Mostrar el tipo de agua en los pines",
  DEST_SETTINGS_FISHING_SHOW_WATER_TT = "Muestra el tipo de agua",
  DEST_SETTINGS_FISHING_PIN_SIZE = "Tamaño del pin para la pesca",
  DEST_SETTINGS_FISHING_PIN_SIZE_TT = "Tamaño del pin para la pesca",
  DEST_SETTINGS_FISHING_PIN_LAYER = "Capa de pines para la pesca",
  DEST_SETTINGS_FISHING_PIN_LAYER_TT = "Capa de pines para la pesca",
  DEST_SETTINGS_FISHING_COMPASS_TOGGLE = "Mostrar en la brújula",
  DEST_SETTINGS_FISHING_COMPASS_TOGGLE_TT = "Mostrar agujeros de pesca en la brújula",
  DEST_SETTINGS_FISHING_COMPASS_DIST = "Distancia en la brújula",
  DEST_SETTINGS_FISHING_COMPASS_DIST_TT = "Distancia para los agujeros de pesca en la brújula",
  DEST_SETTINGS_FISHING_COLOR_TITLE = "Color del texto del título del logro",
  DEST_SETTINGS_FISHING_COLOR_TITLE_TT = "Afecta al título del texto del logro de pesca",
  DEST_SETTINGS_FISHING_PIN_COLOR = "Falta el colordel pin",
  DEST_SETTINGS_FISHING_PIN_COLOR_TT = "Establece el color de los PINS para los peces perdidos",
  DEST_SETTINGS_FISHING_COLOR_UNDONE = "Falta el color del texto",
  DEST_SETTINGS_FISHING_COLOR_UNDONE_TT = "Afecta al TEXTO de la chincheta para los peces perdidos",
  DEST_SETTINGS_FISHING_COLOR_BAIT_UNDONE = "Falta el color del texto del tipo de cebo",
  DEST_SETTINGS_FISHING_COLOR_BAIT_UNDONE_TT = "Afecta al texto del pin BAIT para los peces perdidos, si está activado",
  DEST_SETTINGS_FISHING_COLOR_WATER_UNDONE = "Falta el color del texto del tipo de agua",
  DEST_SETTINGS_FISHING_COLOR_WATER_UNDONE_TT = "Afecta al texto del pin AGUA para los peces que faltan, si está activado",
  DEST_SETTINGS_FISHING_PIN_COLOR_DONE = "Color del pin completado",
  DEST_SETTINGS_FISHING_PIN_COLOR_DONE_TT = "Establece el color de los PINS para los peces recogidos",
  DEST_SETTINGS_FISHING_COLOR_DONE = "Color del texto terminado",
  DEST_SETTINGS_FISHING_COLOR_DONE_TT = "Afecta al TEXTO del pin para los Peces completados",
  DEST_SETTINGS_FISHING_COLOR_BAIT_DONE = "Color del texto del tipo de cebo completado",
  DEST_SETTINGS_FISHING_COLOR_BAIT_DONE_TT = "Afecta al texto del pin BAIT para los peces completados, si está activado",
  DEST_SETTINGS_FISHING_COLOR_WATER_DONE = "Color del texto del tipo de agua completado",
  DEST_SETTINGS_FISHING_COLOR_WATER_DONE_TT = "Afecta al texto del pin AGUA para los Peces completados, si está activado",

  DEST_SETTINGS_MAPFILTERS_HEADER = "Filtros de mapa",
  DEST_SETTINGS_MAPFILTERS_HEADER_TT = "Este submenú abarca todos los ajustes relacionados con los filtros de mapa",
  DEST_SETTINGS_MAPFILTERS_SUBHEADER = "Ajustes del filtro de mapa",

  DEST_SETTINGS_MAPFILTERS_POIS_TOGGLE = "Mostrar filtros de mapa de PDI",
  DEST_SETTINGS_MAPFILTERS_POIS_TOGGLE_TT = "Muestra/oculta los filtros de mapa para todos los puntos de interés",
  DEST_SETTINGS_MAPFILTERS_ACHS_TOGGLE = "Mostrar filtros de mapa de logros",
  DEST_SETTINGS_MAPFILTERS_ACHS_TOGGLE_TT = "Muestra/oculta los filtros de mapa para todos los logros",
  DEST_SETTINGS_MAPFILTERS_QUES_TOGGLE = "Mostrar filtros de mapa de Questgiver",
  DEST_SETTINGS_MAPFILTERS_QUES_TOGGLE_TT = "Muestra/oculta los filtros de mapa para todos los Questgivers",
  DEST_SETTINGS_MAPFILTERS_COLS_TOGGLE = "Mostrar filtros de mapa coleccionables",
  DEST_SETTINGS_MAPFILTERS_COLS_TOGGLE_TT = "Muestra/oculta los filtros de mapa para todos los coleccionables",
  DEST_SETTINGS_MAPFILTERS_FISS_TOGGLE = "Mostrar filtros de mapa de pesca",
  DEST_SETTINGS_MAPFILTERS_FISS_TOGGLE_TT = "Muestra/oculta los filtros de mapa para todos los agujeros de pesca",
  DEST_SETTINGS_MAPFILTERS_MISS_TOGGLE = "Mostrar varios filtros de mapa",
  DEST_SETTINGS_MAPFILTERS_MISS_TOGGLE_TT = "Muestra/oculta los Filtros de Mapa para los pines Misceláneos (Pozos Ayleid, Ruinas Dwemer, Frontera Craglorn, así como todos los pines de Hombres Lobo y Vampiros)",

  GLOBAL_SETTINGS_SELECT_TEXT_ONLY = "¡Sólo texto!",

  DEST_SETTINGS_RESET = "Restablecer la configuración por defecto",

  --POI Types
  POITYPE_AOI = "Área de interés",
  POITYPE_HOUSING = "Casa",
  POITYPE_CRAFTING = "Ubicación dela artesanía",
  POITYPE_DELVE = "Delve",
  POITYPE_DOLMEN = "Dolmen",
  POITYPE_GATE = "Puerta",
  POITYPE_GROUPBOSS = "Jefe de Grupo",
  POITYPE_GROUPDELVE = "Grupo Delve",
  POITYPE_GROUPDUNGEON = "Mazmorra de grupo",
  POITYPE_GROUPEVENT = "Evento de grupo",
  POITYPE_MUNDUS = "Piedra Mundus",
  POITYPE_PUBLICDUNGEON = "Calabozo público",
  POITYPE_QUESTHUB = "Quest Hub",
  POITYPE_SOLOTRIAL = "Prueba",
  POITYPE_TRADER = "Comerciantes del gremio",
  POITYPE_TRIALINSTANCE = "Instancia de prueba",
  POITYPE_UNKNOWN = "Desconocido",
  POITYPE_WAYSHRINE = "Camino",
  POITYPE_VAULT = "Bóveda",
  POITYPE_DARK_BROTHERHOOD = "Hermandad oscura",
  POITYPE_BREAKING_ENTERING = "Allanamiento de morada",
  POITYPE_CUTPURSE_ABOVE = "Un monedero encima",

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

  POITYPE_AYLEID_WELL = "Pozo Ayleid",
  POITYPE_DEADLANDS_ENTRANCE = "Entrada de Deadlands",
  POITYPE_DRUIDIC_SHRINE = "Druidic Shrine",
  POITYPE_WWVAMP = "Hombre Lobo/Vampiro",
  POITYPE_VAMPIRE_ALTAR = "Altar de Vampiros",
  POITYPE_DWEMER_RUIN = "Ruina Dwemer",
  POITYPE_WEREWOLF_SHRINE = "Santuario del hombre lobo",

  POITYPE_COLLECTIBLE = "Coleccionables",
  POITYPE_FISH = "Pesca",
  POITYPE_UNDETERMINED = "Indeterminado",

  -- Quest completion editing texts
  QUEST_EDIT_ON = "¡La edición de los Destinos Quest Giver está activada!",
  QUEST_EDIT_OFF = "¡La edición de los Destinos Quest Giver está desactivada!",
  QUEST_MENU_NOT_FOUND = "No se ha podido encontrar la búsqueda en la base de datos",
  QUEST_MENU_HIDE_QUEST = "Ocultar este pin de búsqueda",
  QUEST_MENU_DISABLE_EDIT = "Desactivar edición",

  -- Quest types
  QUESTTYPE_NONE = "Quest",
  QUESTTYPE_GROUP = "Búsqueda de grupo",
  QUESTTYPE_MAIN_STORY = "Búsqueda de la historia principal",
  QUESTTYPE_GUILD = "Guild Quest",
  QUESTTYPE_CRAFTING = "Crafting Quest",
  QUESTTYPE_DUNGEON = "Dungeon Quest",
  QUESTTYPE_RAID = "Raid Quest",
  QUESTTYPE_AVA = "Búsqueda de guerra de la Alianza",
  QUESTTYPE_CLASS = "Búsqueda de clase",
  QUESTTYPE_QA_TEST = "Q&A Test Quest",
  QUESTTYPE_AVA_GROUP = "Búsqueda del Grupo de Guerra de la Alianza",
  QUESTTYPE_AVA_GRAND = "Gran Búsqueda de Guerra de la Alianza",
  QUESTREPEAT_NOT_REPEATABLE = "Búsqueda normal",
  QUESTREPEAT_REPEATABLE = "Búsqueda repetible",
  QUESTREPEAT_DAILY = "Búsqueda diaria",

  -- Fishing
  FISHING_FOUL = "Agua sucia",
  FISHING_RIVER = "Río",
  FISHING_OCEAN = "Océano",
  FISHING_LAKE = "Lago",
  FISHING_UNKNOWN = "- desconocido -",
  FISHING_FOUL_BAIT = "Crawlers/Fish Roe",
  FISHING_RIVER_BAIT = "Piezas de insectos/Shad",
  FISHING_OCEAN_BAIT = "Gusanos/Chub",
  FISHING_LAKE_BAIT = "Guts/Minnow",
  FISHING_HWBC = "Cangrejo-grúa",

  -- Destinations chat commands
  DESTCOMMANDS = "Lista de comandos de destino:",
  DESTCOMMANDdhlp = "/dhlp (Ayuda para destinos) : Acaba de utilizarlo ;)",
  DESTCOMMANDdset = "/dset (Configuración de destinos) : Abre la ventana de Configuración de destinos",
  DESTCOMMANDdqed = "/dqed (Destinations Quests Editor) : Este comando TOGGLEará la edición de los pines de búsqueda. Se mostrará en el chat si está activado o desactivado. Cuando esté activado, abra su mapa y haga clic en los pines que desee alternar como hechos o deshechos. Recuerda desactivarlo cuando termines de editar repitiendo el comando",

  -- Destinations Misc
  LOAD_NEW_QUEST_FORMAT = "Restablecer datos de búsqueda",
  LOAD_NEW_QUEST_FORMAT_TT = "Esto recargará todas las misiones conocidas en una nueva tabla. El juego hará un /reloadui para completarla",
  RELOADUI_WARNING = "Si haces clic en este botón, el juego hará un /reloadui",
  RELOADUI_INFO = "Los cambios en esta configuración no tendrán efecto hasta que hayas hecho clic en el botón 'ReloadUI'",
  DEST_SETTINGS_RELOADUI = "ReloadUI",
  DEST_SET_REQUIREMENT = "<<1>> rasgos requeridos",
}

for key, value in pairs(strings) do
  ZO_CreateStringId(key, value)
  SafeAddVersion(key, 1)
end