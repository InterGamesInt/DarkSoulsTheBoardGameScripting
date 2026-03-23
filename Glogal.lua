function delete(obj) obj.destruct() end

-- ============================================
-- СТРУКТУРЫ ДАННЫХ ДЛЯ АВТОМАТИЗАЦИИ Dark Souls: The Board Game
-- ============================================

-- 1. ДАННЫЕ О БОССАХ (для стандартного режима)
-- Ключ = имя босса (строка), значение = таблица с параметрами
bossData = {
    -- Мини-боссы (базовая игра)
    ["Gargoyle"] = {
        type = "mini",
        -- Уровни стычек на 4 тайлах (порядок: от ближнего к костру к дальнему)
        -- ⚠️ Значения нужно уточнить по официальным правилам или картам боссов
        encounterLevels = {1, 1, 1, 2},
        usesMegaBoard = false
    },
    ["Boreal Outrider Knight"] = {
        type = "mini",
        encounterLevels = {1, 1, 2, 2},
        usesMegaBoard = false
    },
    ["Titanite Demon"] = {
        type = "mini",
        encounterLevels = {1, 2, 2, 2},
        usesMegaBoard = false
    },
    ["Winged Knight"] = {
        type = "mini",
        encounterLevels = {1, 1, 2, 2},
        usesMegaBoard = false
    },
    -- Мини-боссы (Asylum Demon)
    ["Asylum Demon"] = {
        type = "mini",
        encounterLevels = {1, 1, 1, 2},
        usesMegaBoard = true,
        specialRules = {"PillarSmasher", "WindUp"}
    },
    -- Мини-боссы из дополнения Explorers
    ["Old Dragonslayer"] = {
        type = "mini",
        encounterLevels = {1, 1, 1, 2},
        usesMegaBoard = false
    },

    -- Главные боссы (базовая игра)
    ["Dancer of the Boreal Valley"] = {
        type = "main",
        encounterLevels = {2, 2, 3, 3},
        usesMegaBoard = false
    },
    ["Dragon Slayer Ornstein & Executioner Smough"] = {
        type = "main",
        encounterLevels = {2, 3, 3, 3},
        usesMegaBoard = false
    },
    -- Главные боссы (Darkroot)
    ["Great Grey Wolf Sif"] = {
        type = "main",
        encounterLevels = {2, 3, 3, 3},
        usesMegaBoard = false
    },
    ["Artorias"] = {
        type = "main",
        encounterLevels = {3, 3, 3, 3},
        usesMegaBoard = false
    },
    -- Главные боссы (Iron Keep)
    ["Smelter Demon"] = {
        type = "main",
        encounterLevels = {2, 2, 3, 3},
        usesMegaBoard = false
    },
    ["Sir Alonne"] = {
        type = "main",
        encounterLevels = {2, 2, 2, 3},
        usesMegaBoard = false
    },
    -- Главные боссы (Explorers)
    ["The Pursuer"] = {
        type = "main",
        encounterLevels = {2, 3, 3, 3},
        usesMegaBoard = false
    },
    -- Мега-боссы
    ["Stray Demon"] = {
        type = "mega",
        -- Для мега-босса не используется стандартный набор из 4 тайлов.
        -- Вместо этого перед ним один уровень 4 стычки на Mega Boss game board.
        encounterLevels = nil,
        usesMegaBoard = true,
        level4Encounter = true,
        specialRules = {"PillarSmasher", "WindUp"}
    },
    ["Black Dragon Kalameet"] = {
        type = "mega",
        usesMegaBoard = true,
        level4Encounter = true,
        specialRules = {"Calamity", "Strafe"},
    },
    ["Gaping Dragon"] = {
        type = "mega",
        usesMegaBoard = true,
        level4Encounter = true,
        specialRules = {"Corrosion", "CrawlingCharge"},
    },
    ["Old Iron King"] = {
        type = "mega",
        usesMegaBoard = true,
        level4Encounter = true,
        specialRules = {"MoltenIronDweller", "Beam"},
    },
    ["The Last Giant"] = {
        type = "mega",
        usesMegaBoard = true,
        level4Encounter = true,
        specialRules = {"WindUp", "ArmBehavior"},
    },
    ["Guardian Dragon"] = {
        type = "mega",
        usesMegaBoard = true,
        level4Encounter = true,
        specialRules = {"CageNodes", "Inferno"},
    },
    ["Four Kings"] = {
        type = "mega",
        usesMegaBoard = true,
        level4Encounter = true,
        specialRules = {"RoyalSummons", "TakeABreather"},
    },
    ["Vordt of the Boreal Valley"] = {
        type = "mega",
        usesMegaBoard = true,
        level4Encounter = true,
        specialRules = {"DualDecks", "Frostbreath", "DoubleHeatUp"},
    }
}

-- 2. ДАННЫЕ О СЦЕНАРИЯХ КАМПАНИЙ
campaignScenarios = {
    -- Сценарий "The First Journey" (Dark Souls 1) из базовой книги, стр. 35
    ["FirstJourney"] = {
        name = "The First Journey",
        sections = {
            {
                name = "Undead Burg",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 }
                },
                boss = "Gargoyle",
                nextSectionAfterBoss = true
            },
            {
                name = "Sen's Fortress",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 },
                    { level = 2 }
                },
                boss = "Titanite Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "Anor Londo",
                tiles = {
                    { level = 2 },
                    { level = 2 },
                    { level = 3 },
                    { level = 3 },
                    { level = 3 }
                },
                boss = "Dragon Slayer Ornstein & Executioner Smough",
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "The Coiled Sword" (Dark Souls 3) из базовой книги, стр. 37
    ["CoiledSword"] = {
        name = "The Coiled Sword",
        sections = {
            {
                name = "High Wall of Lothric",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 1 },
                    { level = 2 },
                    { level = 2 }
                },
                boss = "Winged Knight",
                nextSectionAfterBoss = true
            },
            {
                name = "Undead Settlement",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 },
                    { level = 2 },
                    { level = 3 }
                },
                boss = "Boreal Outrider Knight",
                nextSectionAfterBoss = true
            },
            {
                name = "High Wall of Lothric (again)",
                tiles = {
                    { level = 2 },
                    { level = 2 },
                    { level = 3 },
                    { level = 3 },
                    { level = 3 }
                },
                boss = "Dancer of the Boreal Valley",
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "Facing the Abyss" (Dark Souls 1) из дополнения Darkroot, стр. 10
    ["FacingTheAbyss"] = {
        name = "Facing the Abyss",
        sections = {
            {
                name = "Darkroot Garden",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 },
                    { level = 2 },
                    { special = "Hydra Lake" }
                },
                boss = nil,
                nextSectionAfterBoss = true
            },
            {
                name = "Darkroot Basin",
                tiles = {
                    { level = 1 },
                    { level = 2 },
                    { level = 3 },
                    { level = 3 }
                },
                boss = "Great Grey Wolf Sif",
                nextSectionAfterBoss = true
            },
            {
                name = "Royal Wood",
                tiles = {
                    { level = 2 },
                    { level = 3 },
                    { level = 3 },
                    { level = 3 }
                },
                boss = "Artorias",
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "Playing with Fire" (Dark Souls 2) из дополнения Iron Keep, стр. 6
    ["PlayingWithFire"] = {
        name = "Playing with Fire",
        sections = {
            {
                name = "Poison Pool",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 },
                    { level = 2 },
                    { special = "Smoking Gallery" }
                },
                boss = nil,
                nextSectionAfterBoss = true
            },
            {
                name = "Threshold Bridge",
                tiles = {
                    { level = 1 },
                    { level = 2 },
                    { level = 2 },
                    { level = 3 }
                },
                boss = "Smelter Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "Ironhearth Hall",
                tiles = {
                    { level = 2 },
                    { level = 3 },
                    { level = 3 },
                    { level = 3 }
                },
                boss = "Sir Alonne",
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "A Hollow Pursuit" (Dark Souls 2) из дополнения Explorers, стр. 14
    ["HollowPursuit"] = {
        name = "A Hollow Pursuit",
        sections = {
            {
                name = "The Crestfallen's Retreat",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 1 },
                    { level = 2 }
                },
                boss = "Old Dragonslayer",
                nextSectionAfterBoss = true
            },
            {
                name = "Lower Earthen Peak",
                tiles = {
                    { level = 1 },
                    { level = 2 },
                    { level = 2 },
                    { special = "Gallery of the Hidden Warrior" }
                },
                boss = nil,
                nextSectionAfterBoss = true
            },
            {
                name = "Threshold Bridge",
                tiles = {
                    { level = 2 },
                    { level = 3 },
                    { level = 3 },
                    { level = 3 }
                },
                boss = "The Pursuer",
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "Ambush Lies Ahead" из дополнения Phantoms, стр. 17
    ["AmbushLiesAhead"] = {
        name = "Ambush Lies Ahead",
        sections = {
            {
                name = "Undead Burg",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 }
                },
                boss = "Gargoyle",
                nextSectionAfterBoss = true
            },
            {
                name = "Sen's Fortress",
                tiles = {
                    { level = 1 },
                    { special = "Invader_Kirk" },
                    { level = 2 },
                    { special = "Invader_Mildred" }
                },
                boss = "Titanite Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "Anor Londo",
                tiles = {
                    { level = 2 },
                    { special = "Invader_Jeremiah" },
                    { level = 3 },
                    { special = "Invader_Leeroy" },
                    { level = 3 }
                },
                boss = "Dragon Slayer Ornstein & Executioner Smough",
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "The Gauntlet" из дополнения Phantoms, стр. 19
    ["TheGauntlet"] = {
        name = "The Gauntlet",
        sections = {
            {
                name = "Invader Ruins",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { special = "Invader_Melinda" },
                    { special = "Invader_Maldron" },
                    { special = "Invader_Kirk" }
                },
                boss = nil,
                nextSectionAfterBoss = true
            },
            {
                name = "Invader Hall",
                tiles = {
                    { level = 2 },
                    { special = "Invader_Oliver" },
                    { special = "Invader_Jeremiah" },
                    { special = "Invader_Mildred" },
                    { special = "Invader_Sharron" }
                },
                boss = nil,
                nextSectionAfterBoss = true
            },
            {
                name = "Invader Spire",
                tiles = {
                    { special = "Invader_Dennis" },
                    { special = "Invader_Leeroy" },
                    { special = "Invader_Chester" },
                    { special = "Invader_Brylex" },
                    { special = "Invader_Kirk2" }
                },
                boss = nil,
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "Demon Hunting" из дополнения Asylum Demon, стр. 14
    ["DemonHunting"] = {
        name = "Demon Hunting",
        sections = {
            {
                name = "Undead Asylum",
                tiles = {
                    { level = 1 },
                    { level = 1 }
                },
                boss = "Asylum Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "Undead Burg",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 }
                },
                boss = "Gargoyle",
                nextSectionAfterBoss = true
            },
            {
                name = "Sen's Fortress",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 },
                    { level = 2 }
                },
                boss = "Titanite Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "Northern Undead Asylum",
                tiles = {
                    { level = 2 },
                    { level = 3 },
                    { level = 4 }
                },
                boss = "Stray Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "Anor Londo",
                tiles = {
                    { level = 2 },
                    { level = 2 },
                    { level = 3 },
                    { level = 3 },
                    { level = 3 }
                },
                boss = "Dragon Slayer Ornstein & Executioner Smough",
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "Bathed in Flame" из дополнения Black Dragon Kalameet, стр. 14
    ["BathedInFlame"] = {
        name = "Bathed in Flame",
        sections = {
            {
                name = "Undead Burg",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 }
                },
                boss = "Gargoyle",
                nextSectionAfterBoss = true
            },
            {
                name = "Sen's Fortress",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 },
                    { level = 2 }
                },
                boss = "Titanite Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "Anor Londo",
                tiles = {
                    { level = 2 },
                    { level = 2 },
                    { level = 3 },
                    { level = 3 },
                    { level = 3 }
                },
                boss = "Dragon Slayer Ornstein & Executioner Smough",
                nextSectionAfterBoss = true
            },
            {
                name = "Royal Wood",
                tiles = {
                    { level = 3 },
                    { level = 3 },
                    { level = 4 }
                },
                boss = "Black Dragon Kalameet",
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "Into the Depths" из дополнения Gaping Dragon, стр. 14
    ["IntoTheDepths"] = {
        name = "Into the Depths",
        sections = {
            {
                name = "Broken Path",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 },
                    { level = 2 }
                },
                boss = "Winged Knight",
                nextSectionAfterBoss = true
            },
            {
                name = "Shattered Spire",
                tiles = {
                    { level = 2 },
                    { level = 2 },
                    { level = 2 }
                },
                boss = "Titanite Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "Crypt of the Fallen",
                tiles = {
                    { level = 2 },
                    { level = 3 },
                    { level = 3 }
                },
                boss = "Artorias",
                nextSectionAfterBoss = true
            },
            {
                name = "Warriors’ Revenge",
                tiles = {
                    { level = 3 },
                    { level = 3 },
                    { special = "Outskirts of Blighttown" }
                },
                boss = "Dragon Slayer Ornstein & Executioner Smough",
                nextSectionAfterBoss = false
            },
            {
                name = "The Depths",
                tiles = {
                    { special = "Darkened Chamber" },
                    { special = "The Depths" },
                },
                boss = "Gaping Dragon",
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "Demons & Dragons" из дополнения Guardian Dragon, стр. 14
    ["Demons&Dragons"] = {
        name = "Demons & Dragons",
        sections = {
            {
                name = "The Dungeon’s Gates",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 },
                    { level = 2 }
                },
                boss = "Asylum Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "The Bloody Road",
                tiles = {
                    { level = 2 },
                    { level = 2 },
                    { level = 2 },
                    { level = 2 },
                },
                boss = "Titanite Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "The Peak of Peril",
                tiles = {
                    { level = 2 },
                    { level = 3 },
                    { level = 3 },
                    { level = 4 }
                },
                boss = "Guardian Dragon",
                nextSectionAfterBoss = true
            },
            {
                name = "The Maw of Death",
                tiles = {
                    { level = 3 },
                    { level = 3 },
                    { level = 4 }
                },
                boss = "Gaping Dragon",
                nextSectionAfterBoss = true
            },
            {
                name = "The Final Conflict",
                tiles = {},
                bosses = { "Stray Demon", "Black Dragon Kalameet" },
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "Go Beyond Death" из дополнения Old Iron King, стр. 14
    ["GoBeyondDeath"] = {
        name = "Go Beyond Death",
        sections = {
            {
                name = "Tower of Flame",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 1 },
                    { level = 2 }
                },
                boss = "Old Dragonslayer",
                nextSectionAfterBoss = true
            },
            {
                name = "Threshold Bridge",
                tiles = {
                    { level = 1 },
                    { level = 2 },
                    { level = 2 },
                    { level = 3 }
                },
                boss = "Smelter Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "Ironhearth Hall",
                tiles = {
                    { level = 2 },
                    { level = 3 },
                    { level = 3 },
                    { special = "Fortress Gates" }
                },
                boss = "The Pursuer",
                nextSectionAfterBoss = true
            },
            {
                name = "Eygil’s Idol",
                tiles = {
                    { level = 3 },
                    { special = "Blazing Furnace" }
                },
                boss = "Old Iron King",
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "Call of the Abyss" из дополнения The Four Kings, стр. 14
    ["CallOfTheAbyss"] = {
        name = "Call of the Abyss",
        sections = {
            {
                name = "Undead Parish",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 },
                    { level = 2 }
                },
                boss = "Titanite Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "Darkroot Basin",
                tiles = {
                    { level = 1 },
                    { level = 2 },
                    { level = 3 },
                    { level = 3 }
                },
                boss = "Great Grey Wolf Sif",
                nextSectionAfterBoss = true
            },
            {
                name = "Royal Wood",
                tiles = {
                    { level = 2 },
                    { level = 3 },
                    { level = 3 },
                    { level = 3 }
                },
                boss = "Artorias",
                nextSectionAfterBoss = false
            },
            {
                name = "Penultimate Trial",
                tiles = {
                    { level = 3 },
                    { level = 3 },
                    { level = 4 }
                },
                boss = "Dragon Slayer Ornstein & Executioner Smough",
                nextSectionAfterBoss = false
            },
            {
                name = "The Abyss",
                tiles = {
                    { level = 4 },
                    { level = 4 }
                },
                boss = "Four Kings",
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "Treasures of the Ice Cave" из дополнения Vordt of the Boreal Valley, стр. 14
    ["TreasuresOfTheIceCave"] = {
        name = "Treasures of the Ice Cave",
        sections = {
            {
                name = "Glacial Entrance",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 },
                    { level = 2 }
                },
                boss = nil,
                nextSectionAfterBoss = true
            },
            {
                name = "Arctic Pass",
                tiles = {
                    { level = 2 },
                    { level = 2 },
                    { level = 2 },
                    { level = 3 }
                },
                boss = "Boreal Outrider Knight",
                nextSectionAfterBoss = true
            },
            {
                name = "Frozen Corridor",
                tiles = {
                    { level = 2 },
                    { level = 3 },
                    { level = 3 },
                    { special = "Guarded Path" }
                },
                boss = nil,
                nextSectionAfterBoss = true
            },
            {
                name = "The Boreal Sanctuary",
                tiles = {
                    { level = 3 },
                    { level = 3 },
                    { special = "The Dog's Domain" }
                },
                boss = "Vordt of the Boreal Valley",
                nextSectionAfterBoss = false
            }
        }
    },

    -- Сценарий "Big Game Hunting" из дополнения Manus, Father of the Abyss, стр. 14
    ["BigGameHunting"] = {
        name = "Big Game Hunting",
        sections = {
            {
                name = "Asylum Hunt",
                tiles = {
                    { level = 1 },
                    { level = 1 },
                    { level = 2 },
                    { level = 2 }
                },
                boss = "Asylum Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "Forest Hunt",
                tiles = {
                    { level = 4 }
                },
                boss = "The Last Giant",
                nextSectionAfterBoss = true
            },
            {
                name = "Bridge Hunt",
                tiles = {
                    { level = 4 }
                },
                boss = "Stray Demon",
                nextSectionAfterBoss = true
            },
            {
                name = "Chasm Hunt",
                tiles = {
                    { level = 4 }
                },
                boss = "Black Dragon Kalameet",
                nextSectionAfterBoss = false
            }
        }
    }
}

-- ============================================
-- ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ
-- ============================================

function findObjectByName(name)
    local objects = getAllObjects()
    for _, obj in ipairs(objects) do
        if obj.getName() == name then
            return obj
        end
    end
    return nil
end

function cleanTableExceptImportant()
    local objects = getAllObjects()
    for _, obj in ipairs(objects) do
        local name = obj.getName()
        if name ~= "Dark Souls Setup Panel"
            and name ~= "Bonfire Tile"
            and name ~= "Sparks Dial" then
            obj.destruct()
        end
    end
end

function shuffleTable(t)
    math.randomseed(os.time())
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

function setupSparks(playerCount)
    local sparks = 3
    if playerCount == 1 then
        sparks = 5
    elseif playerCount == 2 then
        sparks = 4
    elseif playerCount == 3 then
        sparks = 3
    else
        sparks = 2
    end
    local dial = findObjectByName("Sparks")
    if dial then
        dial.call("setValue", sparks)
        print("Установлено искр: " .. sparks)
    else
        print("Счётчик искр не найден, установите вручную")
    end
end

encounterDecks = {
    ["Core Encounters"] = {
        [1] = "89a427",
        [2] = "126f9e",
        [3] = "462efd"
    },
    ["Darkroot Encounters"] = {
        [1] = "8f8e6f",
        [2] = "17d4b1",
        [3] = "c925ba"
    },
    ["Iron Keep Encounters"] = {
        [1] = "d47b29",
        [2] = "008559",
        [3] = "fb93f3"
    },
    ["Explorers Encounters"] = {
        [1] = "3d6df6",
        [2] = "b0b022",
        [3] = "cb556c"
    }
}

function placeEncounterCards(tiles, levels, bonfireTile, encounterSetNames)
    local decksByLevel = { [1] = {}, [2] = {}, [3] = {} }
    local tempPos = { 0, 10, 0 }

    for _, setName in ipairs(encounterSetNames) do
        local setDecks = encounterDecks[setName]
        if setDecks then
            for lvl = 1, 3 do
                local bagGuid = setDecks[lvl]
                if bagGuid then
                    local bag = getObjectFromGUID(bagGuid)
                    if bag then
                        local contained = bag.getData().ContainedObjects
                        if contained and #contained > 0 then
                            local deck = bag.takeObject({
                                index = contained[1].index,
                                position = tempPos,
                                smooth = false
                            })
                            if deck then
                                deck.shuffle()
                                table.insert(decksByLevel[lvl], deck)
                                print("[DEBUG] Добавлена колода уровня " .. lvl .. " из набора " .. setName)
                            else
                                print("[ERROR] Не удалось извлечь колоду из сумки " .. bagGuid)
                            end
                        else
                            print("[WARN] Сумка " .. bagGuid .. " пуста или не содержит объектов")
                        end
                    else
                        print("[WARN] Сумка с GUID " .. bagGuid .. " не найдена (набор " .. setName .. ", уровень " .. lvl .. ")")
                    end
                end
            end
        end
    end

    local bonfirePos = bonfireTile.getPosition()
    local sortedTiles = {}
    for _, tile in ipairs(tiles) do
        local pos = tile.getPosition()
        local distSq = (pos.x - bonfirePos.x) ^ 2 + (pos.z - bonfirePos.z) ^ 2
        table.insert(sortedTiles, { tile = tile, dist = distSq })
    end
    table.sort(sortedTiles, function(a, b) return a.dist < b.dist end)

    for i, entry in ipairs(sortedTiles) do
        local level = levels[i]
        local availableDecks = decksByLevel[level]
        if #availableDecks > 0 then
            local chosenDeck = availableDecks[math.random(#availableDecks)]
            local card = chosenDeck.takeObject({ position = { 0, 0, 0 }, smooth = false })
            if card then
                Wait.frames(function()
                    local tilePos = entry.tile.getPosition()
                    card.setPosition({ tilePos.x, tilePos.y + 0.2, tilePos.z })
                    card.setRotation({ 0, 180, 0 })
                    card.flip()
                    print("[DEBUG] Карта уровня " .. level .. " размещена на тайле, расстояние " .. math.sqrt(entry.dist))
                end, 1)
            else
                print("[ERROR] Не удалось взять карту из колоды уровня " .. level)
            end
        else
            print("[ERROR] Нет доступных колод для уровня " .. level)
        end
    end

    for lvl, decks in pairs(decksByLevel) do
        for _, deck in ipairs(decks) do
            deck.destruct()
        end
    end
end

-- ============================================
-- ФУНКЦИИ ДЛЯ РАБОТЫ С ТАЙЛАМИ В СУМКАХ
-- ============================================

function collectTileCandidates(tileSetConfig)
    local candidates = {}
    local innerBags = {}
    local tempPos = { 0, 10, 0 }

    local neededBags = {}
    if tileSetConfig.core then
        table.insert(neededBags, "Core Map Tiles")
    end
    if tileSetConfig.darkwood or tileSetConfig.ironkeep then
        table.insert(neededBags, "Darkwood/Iron Keep Tiles")
    end
    if tileSetConfig.extra then
        table.insert(neededBags, "Extra Map Tiles")
    end

    for _, bagName in ipairs(neededBags) do
        local outerBag = findObjectByName(bagName)
        if outerBag then
            print("[DEBUG] Найдена внешняя сумка: " .. bagName)
            local innerBagsData = outerBag.getData().ContainedObjects
            if innerBagsData then
                for i, innerData in ipairs(innerBagsData) do
                    local innerBag = outerBag.takeObject({
                        index = i - 1,
                        position = tempPos,
                        smooth = false
                    })
                    if innerBag then
                        local namePart = innerData.Nickname or innerData.Name or "unnamed"
                        print("[DEBUG] Извлечена внутренняя сумка: " .. namePart .. ", GUID=" .. innerBag.getGUID())
                        table.insert(innerBags, innerBag)

                        if innerBag.getObjects then
                            local tilesData = innerBag.getObjects()
                            for _, tileData in ipairs(tilesData) do
                                table.insert(candidates, {
                                    bag = innerBag,
                                    index = tileData.index,
                                    name = tileData.nickname or tileData.name or "unknown",
                                    sourceBag = bagName
                                })
                            end
                        end
                    else
                        print("[ERROR] Не удалось извлечь внутреннюю сумку по индексу " .. i)
                    end
                end
            end
        else
            print("[WARN] Внешняя сумка с именем '" .. bagName .. "' не найдена!")
        end
    end

    print("[DEBUG] Собрано кандидатов: " .. #candidates)
    return candidates, innerBags
end

function prepareTile(tile, sourceBag, tileSetConfig)
    local faceDown = tile.is_face_down
    local needFlip = false

    local currentSet = nil
    if sourceBag == "Core Map Tiles" then
        currentSet = "Core"
    elseif sourceBag == "Extra Map Tiles" then
        currentSet = "Extra"
    elseif sourceBag == "Darkwood/Iron Keep Tiles" then
        if not faceDown then
            currentSet = "IronKeep"
        else
            currentSet = "Darkwood"
        end
    end

    if sourceBag == "Core Map Tiles" and not tileSetConfig.core then
        return false
    elseif sourceBag == "Core Map Tiles" and tileSetConfig.core then
        needFlip = math.random(0, 1) == 1
    end
    if sourceBag == "Extra Map Tiles" and not tileSetConfig.extra then
        return false
    end
    if sourceBag == "Darkwood/Iron Keep Tiles" then
        local ok = false
        if tileSetConfig.darkwood and currentSet == "Darkwood" then
            ok = true
        end
        if tileSetConfig.ironkeep and currentSet == "IronKeep" then
            ok = true
        end
        if not ok then
            if tileSetConfig.darkwood and currentSet == "IronKeep" then
                needFlip = true
                ok = true
            elseif tileSetConfig.ironkeep and currentSet == "Darkwood" then
                needFlip = true
                ok = true
            end
            if not ok then
                return false
            end
        end
    end

    if needFlip then
        tile.flip()
        print("[DEBUG] Тайл перевёрнут для соответствия набору")
    end
    return true
end

function extractRandomTiles(count, tileSetConfig)
    print("[DEBUG] extractRandomTiles: запрошено " .. count .. " тайлов")
    local candidates, innerBags = collectTileCandidates(tileSetConfig)
    if #candidates < count then
        broadcastToAll("Недостаточно тайлов! Требуется " .. count .. ", доступно " .. #candidates, { 1, 0, 0 })
        for _, bag in ipairs(innerBags) do
            bag.destruct()
        end
        return {}
    end

    shuffleTable(candidates)

    local selectedCandidates = {}
    for i = 1, count do
        table.insert(selectedCandidates, candidates[i])
    end

    local bagCandidates = {}
    for _, cand in ipairs(selectedCandidates) do
        local bag = cand.bag
        if not bagCandidates[bag] then
            bagCandidates[bag] = {}
        end
        table.insert(bagCandidates[bag], cand)
    end

    local selectedTiles = {}
    local tempPos = { 0, 10, 0 }

    for bag, candList in pairs(bagCandidates) do
        table.sort(candList, function(a, b) return a.index > b.index end)
        for _, cand in ipairs(candList) do
            print(string.format("[DEBUG] Извлечение тайла: имя='%s', индекс=%d, сумка GUID=%s", cand.name, cand.index, cand.bag.getGUID()))
            local tile = cand.bag.takeObject({
                index = cand.index,
                position = tempPos,
                smooth = false
            })
            if tile then
                if prepareTile(tile, cand.sourceBag, tileSetConfig) then
                    table.insert(selectedTiles, tile)
                else
                    tile.destruct()
                    print("[DEBUG] Тайл не подошёл, уничтожен")
                end
            else
                print("[ERROR] Не удалось извлечь тайл по индексу " .. cand.index)
            end
        end
    end

    print("[DEBUG] Извлечено тайлов в selectedTiles: " .. #selectedTiles)

    for _, bag in ipairs(innerBags) do
        bag.destruct()
    end

    if #selectedTiles < count then
        print("[ERROR] Не удалось набрать нужное количество подходящих тайлов")
        for _, tile in ipairs(selectedTiles) do
            tile.destruct()
        end
        return {}
    end

    return selectedTiles
end

-- ============================================
-- ФУНКЦИИ ДЛЯ РАБОТЫ С ДВЕРНЫМИ ТОЧКАМИ (с учётом поворота Z для перевёрнутых тайлов)
-- ============================================

function getDoorPointsProj(obj)
    local result = {}
    local snaps = obj.getSnapPoints()
    local isFaceDown = obj.is_face_down
    local targetY = isFaceDown and -20 or 20

    for _, point in ipairs(snaps) do
        if point.position.y == targetY then
            table.insert(result, { x = point.position.x, y = 0, z = point.position.z })
        end
    end

    return result
end

function getWorldDoors(obj)
    local world = {}
    local doors = getDoorPointsProj(obj)
    for _, door in ipairs(doors) do
        table.insert(world, obj.positionToWorld(door))
    end
    return world
end

function hasDoorOnSide(tile, side)
    local doors = getDoorPointsProj(tile)
    local center = tile.getPosition()
    for _, door in ipairs(doors) do
        local worldDoor = tile.positionToWorld(door)
        local dx = worldDoor.x - center.x
        local dz = worldDoor.z - center.z
        if math.abs(dx) > math.abs(dz) then
            if dx > 0.1 and side == "east" then return true end
            if dx < -0.1 and side == "west" then return true end
        else
            if dz > 0.1 and side == "north" then return true end
            if dz < -0.1 and side == "south" then return true end
        end
    end
    return false
end

function getSides(dx, dz)
    local threshold = 0.1
    if math.abs(dx) > math.abs(dz) then
        if dx > threshold then
            return "east", "west"
        elseif dx < -threshold then
            return "west", "east"
        end
    else
        if dz > threshold then
            return "north", "south"
        elseif dz < -threshold then
            return "south", "north"
        end
    end
    return nil, nil
end

function isPositionFree(pos, ignoreObjs)
    local objects = getAllObjects()
    for _, obj in ipairs(objects) do
        local ignore = false
        for _, ig in ipairs(ignoreObjs) do
            if obj == ig then
                ignore = true
                break
            end
        end
        if not ignore then
            local objPos = obj.getPosition()
            local dx = objPos.x - pos.x
            local dz = objPos.z - pos.z
            local dist = math.sqrt(dx * dx + dz * dz)
            if dist < 8 then
                return false
            end
        end
    end
    return true
end

function checkPlacement(tile, targetPos, angle, ownerObj, placedObjects)
    local originalPos = tile.getPosition()
    local originalRot = tile.getRotation()

    tile.setPosition(targetPos)
    if tile.is_face_down then
        tile.setRotation({ 0, angle, 180 })
    else
        tile.setRotation({ 0, angle, 0 })
    end

    local centerOwner = ownerObj.getPosition()
    local tileDoors = getDoorPointsProj(tile)
    local parentOk = false
    for _, door in ipairs(tileDoors) do
        local doorWorld = tile.positionToWorld(door)
        if math.abs(doorWorld.x - centerOwner.x) < 0.01 and
            math.abs(doorWorld.z - centerOwner.z) < 0.01 then
            parentOk = true
            break
        end
    end
    if not parentOk then
        tile.setPosition(originalPos)
        tile.setRotation(originalRot)
        return false
    end

    if not isPositionFree(targetPos, { tile, ownerObj }) then
        tile.setPosition(originalPos)
        tile.setRotation(originalRot)
        return false
    end

    local currentPos = tile.getPosition()
    for _, obj in ipairs(placedObjects) do
        if obj ~= ownerObj then
            local objPos = obj.getPosition()
            local dx = objPos.x - currentPos.x
            local dz = objPos.z - currentPos.z
            local dist = math.sqrt(dx * dx + dz * dz)
            if dist > 5 and dist < 30 then
                local mySide, objSide = getSides(dx, dz)
                if mySide and objSide then
                    local myHasDoor = hasDoorOnSide(tile, mySide)
                    local objHasDoor = hasDoorOnSide(obj, objSide)
                    if myHasDoor ~= objHasDoor then
                        tile.setPosition(originalPos)
                        tile.setRotation(originalRot)
                        return false
                    end
                end
            end
        end
    end

    tile.setPosition(originalPos)
    tile.setRotation(originalRot)
    return true
end

-- ============================================
-- ОСНОВНАЯ ФУНКЦИЯ РАССТАНОВКИ ТАЙЛОВ
-- ============================================

function placeTilesAroundBonfire(tiles, bonfireTile)
    local bonfireDoors = getWorldDoors(bonfireTile)
    local tileFreeDoors = {}
    local placedObjects = { bonfireTile }
    local numBonfireDoors = #bonfireDoors

    for i = 1, math.min(#tiles, numBonfireDoors) do
        local tile = tiles[i]
        local tileName = tile.getName() or "Unknown"
        print("[DEBUG] Размещаю " .. tileName .. " к костру")
        local placed = false

        shuffleTable(bonfireDoors)

        for j, doorWorld in ipairs(bonfireDoors) do
            local angles = { 0, 90, 180, 270 }
            shuffleTable(angles)
            for _, angle in ipairs(angles) do
                if checkPlacement(tile, doorWorld, angle, bonfireTile, placedObjects) then
                    tile.setPosition(doorWorld)
                    if tile.is_face_down then
                        tile.setRotation({ 0, angle, 180 })
                    else
                        tile.setRotation({ 0, angle, 0 })
                    end
                    print("[DEBUG] " .. tileName .. " пристыкован к костру, угол " .. angle)

                    table.remove(bonfireDoors, j)

                    local newDoors = getWorldDoors(tile)
                    for _, d in ipairs(newDoors) do
                        table.insert(tileFreeDoors, { world = d, owner = tile })
                    end

                    table.insert(placedObjects, tile)
                    placed = true
                    break
                end
            end
            if placed then break end
        end

        if not placed then
            print("[WARN] " .. tileName .. " не удалось пристыковать к костру, запасная позиция")
        end
    end

    for i = numBonfireDoors + 1, #tiles do
        local tile = tiles[i]
        local tileName = tile.getName() or "Unknown"
        print("[DEBUG] Размещаю " .. tileName)
        local placed = false

        shuffleTable(tileFreeDoors)

        for j, doorRec in ipairs(tileFreeDoors) do
            local angles = { 0, 90, 180, 270 }
            shuffleTable(angles)
            for _, angle in ipairs(angles) do
                if checkPlacement(tile, doorRec.world, angle, doorRec.owner, placedObjects) then
                    tile.setPosition(doorRec.world)
                    if tile.is_face_down then
                        tile.setRotation({ 0, angle, 180 })
                    else
                        tile.setRotation({ 0, angle, 0 })
                    end
                    print("[DEBUG] " .. tileName .. " пристыкован к объекту " .. (doorRec.owner.getName() or "Unknown") .. ", угол " .. angle)

                    table.remove(tileFreeDoors, j)

                    local newDoors = getWorldDoors(tile)
                    for _, d in ipairs(newDoors) do
                        table.insert(tileFreeDoors, { world = d, owner = tile })
                    end

                    table.insert(placedObjects, tile)
                    placed = true
                    break
                end
            end
            if placed then break end
        end

        if not placed then
            print("[WARN] " .. tileName .. " не удалось пристыковать, запасная позиция")
        end
    end
end

function placeFogGate(tiles, bonfireTile)
    local bonfirePos = bonfireTile.getPosition()
    local farthestTile = nil
    local maxDistSq = -1
    for _, tile in ipairs(tiles) do
        local pos = tile.getPosition()
        local distSq = (pos.x - bonfirePos.x) ^ 2 + (pos.z - bonfirePos.z) ^ 2
        if distSq > maxDistSq then
            maxDistSq = distSq
            farthestTile = tile
        end
    end
    if not farthestTile then
        print("[ERROR] Не найден самый дальний тайл")
        return
    end

    local snaps = farthestTile.getSnapPoints()
    local isFlipped = math.abs(farthestTile.getRotation().z) > 0.1
    local targetY = isFlipped and -20 or 20
    local doorLocalPoints = {}
    for _, point in ipairs(snaps) do
        if math.abs(point.position.y - targetY) < 0.01 then
            table.insert(doorLocalPoints, { x = point.position.x, y = 0, z = point.position.z })
        end
    end
    if #doorLocalPoints == 0 then
        print("[WARN] У дальнего тайла нет дверей")
        return
    end

    local bestPoint = nil
    local bestDistSq = -1
    local bestWorldDoor = nil
    for _, localDoor in ipairs(doorLocalPoints) do
        local halfLocal = { x = localDoor.x, y = 0, z = localDoor.z }
        if math.abs(localDoor.x) > 0.1 then
            halfLocal.x = localDoor.x / 2.01
        end
        if math.abs(localDoor.z) > 0.1 then
            halfLocal.z = localDoor.z / 2.01
        end
        local worldPoint = farthestTile.positionToWorld({ x = halfLocal.x, y = 0, z = halfLocal.z })
        local worldDoor = farthestTile.positionToWorld({ x = localDoor.x, y = 0, z = localDoor.z })
        local distSq = (worldPoint.x - bonfirePos.x) ^ 2 + (worldPoint.z - bonfirePos.z) ^ 2
        if distSq > bestDistSq then
            bestDistSq = distSq
            bestPoint = worldPoint
            bestWorldDoor = worldDoor
        end
    end

    if not bestPoint then
        print("[ERROR] Не удалось найти точку для Fog Gate")
        return
    end

    local tileCenter = farthestTile.getPosition()
    local dx = bestWorldDoor.x - tileCenter.x
    local dz = bestWorldDoor.z - tileCenter.z
    local side = nil
    if math.abs(dx) > math.abs(dz) then
        if dx > 0 then side = "east" else side = "west" end
    else
        if dz > 0 then side = "north" else side = "south" end
    end

    local fogBag = getObjectFromGUID("a3b9e7")
    if not fogBag then
        print("[ERROR] Сумка Fog Gates не найдена (GUID a3b9e7)")
        return
    end
    local fogToken = fogBag.takeObject({ position = { 0, 0, 0 }, smooth = false })
    if not fogToken then
        print("[ERROR] Не удалось извлечь Fog Gate")
        return
    end

    local rotation = { 0, 0, 0 }
    if side == "east" or side == "west" then
        rotation = { 0, 90, 0 }
    end
    fogToken.setPosition({ bestPoint.x, bestPoint.y + 1, bestPoint.z })
    fogToken.setRotation(rotation)
    print("[DEBUG] Fog Gate установлен на самом дальнем тайле, сторона " .. side)
end

-- ============================================
-- ФУНКЦИИ ДЛЯ СТАНДАРТНОГО РЕЖИМА
-- ============================================

function setupStandardGame(args)
    local miniBoss = args[1]
    local mainBoss = args[2]
    local playerCount = args[3]
    local tileSetNames = args[4] or { "Core Map Tiles" }
    local encounterSetNames = args[5] or { "Core Encounters" }

    local tileSetConfig = {
        core = false,
        darkwood = false,
        ironkeep = false,
        extra = false
    }
    for _, name in ipairs(tileSetNames) do
        if name == "Core Map Tiles" then
            tileSetConfig.core = true
        elseif name == "Darkwood Tiles" then
            tileSetConfig.darkwood = true
        elseif name == "Iron Keep Tiles" then
            tileSetConfig.ironkeep = true
        elseif name == "Extra Map Tiles" then
            tileSetConfig.extra = true
        end
    end

    broadcastToAll("Настройка стандартной игры: " .. miniBoss .. " -> " .. mainBoss .. " (" .. playerCount .. " игроков)", { 0, 1, 0 })

    -- cleanTableExceptImportant() -- раскомментируйте, если нужна очистка

    local bonfireTile = findObjectByName("Bonfire Tile")
    if not bonfireTile then
        broadcastToAll("Ошибка: не найден тайл костра!", { 1, 0, 0 })
        return
    end

    local maxAttempts = 10
    local attempt = 1

    local function tryPlace(attempt)
        if attempt > maxAttempts then
            broadcastToAll("Не удалось расставить тайлы после " .. maxAttempts .. " попыток!", { 1, 0, 0 })
            return
        end

        print("[DEBUG] Попытка " .. attempt .. " из " .. maxAttempts)
        local tiles = extractRandomTiles(4, tileSetConfig)
        if #tiles < 4 then
            broadcastToAll("Недостаточно подходящих тайлов для расстановки!", { 1, 0, 0 })
            return
        end

        Wait.time(function()
            placeTilesAroundBonfire(tiles, bonfireTile)

            local allPlaced = true
            for _, tile in ipairs(tiles) do
                local pos = tile.getPosition()
                if math.abs(pos.y - 10) < 0.1 then
                    allPlaced = false
                    break
                end
            end

            if allPlaced then
                print("[DEBUG] Расстановка успешна!")
                setupSparks(playerCount)

                placeFogGate(tiles, bonfireTile)

                local miniBossData = getBossData(miniBoss)
                if not miniBossData then
                    broadcastToAll("Ошибка: данные мини-босса не найдены!", { 1, 0, 0 })
                    return
                end
                local encounterLevels = miniBossData.encounterLevels or { 1, 1, 1, 1 }
                placeEncounterCards(tiles, encounterLevels, bonfireTile, encounterSetNames)

                broadcastToAll("Стол подготовлен для первого этапа (путь к " .. miniBoss .. ")", { 0, 1, 0 })

                 -- Небольшая задержка, чтобы все объекты успокоились, затем блокируем тайлы и показываем UI
                Wait.time(function()
                    for _, tile in ipairs(tiles) do
                        tile.setLock(true)
                    end
                    print("[DEBUG] Тайлы заблокированы")

                    local activeColors = {}
                    local playerColorsList = {"White","Green","Red","Blue"}
                    for _, player in ipairs(Player.getPlayers()) do
                        local color = player.color
                        for _, pc in ipairs(playerColorsList) do
                            if color == pc then
                                table.insert(activeColors, color)
                                break
                            end
                        end
                    end
                    local playerColorsStr = table.concat(activeColors, "|")
                    showCharacterSelectionUI(playerColorsStr)
                end, 0.5)  -- задержка 0.5 секунды (можно увеличить при необходимости)
            else
                print("[WARN] Не все тайлы удалось установить, уничтожаем и пробуем снова")
                for _, tile in ipairs(tiles) do
                    tile.destruct()
                end
                tryPlace(attempt + 1)
            end
        end, 0.5)
    end

    tryPlace(1)
end

-- ============================================
-- КАМПАНИЯ (заглушка)
-- ============================================

function setupCampaignGame(scenarioKey, playerCount)
    broadcastToAll("Запуск кампании: " .. scenarioKey .. " (" .. playerCount .. " игроков) - логика ещё не реализована", { 1, 1, 0 })
end

-- ============================================
-- РАБОТА С ДАННЫМИ
-- ============================================

function getBossData(bossName)
    return bossData[bossName]
end

function getBossEncounterLevels(bossName)
    local boss = getBossData(bossName)
    if boss and boss.encounterLevels then
        return boss.encounterLevels
    else
        print("Ошибка: нет данных для босса " .. tostring(bossName))
        return { 1, 1, 1, 1 }
    end
end

function bossUsesMegaBoard(bossName)
    local boss = getBossData(bossName)
    return boss and boss.usesMegaBoard or false
end

function isMegaBoss(bossName)
    local boss = getBossData(bossName)
    return boss and boss.type == "mega"
end

function hasLevel4Encounter(bossName)
    local boss = getBossData(bossName)
    return boss and boss.level4Encounter or false
end

function getBossSpecialRules(bossName)
    local boss = getBossData(bossName)
    return boss and boss.specialRules or {}
end

function getCampaignScenario(scenarioKey)
    return campaignScenarios[scenarioKey]
end

function testData()
    print("=== ТЕСТ ДАННЫХ ===")
    local testBosses = { "Gargoyle", "Stray Demon", "Four Kings", "Dancer of the Boreal Valley" }
    for _, name in ipairs(testBosses) do
        local data = getBossData(name)
        if data then
            print(name .. ": тип=" .. data.type .. ", usesMegaBoard=" .. tostring(data.usesMegaBoard))
        else
            print(name .. " не найден")
        end
    end
end

-- ============================================
-- UI ВЫБОРА ПЕРСОНАЖА
-- ============================================

charactersData = {
    ["Knight"] = {
        name = "Knight",
        image = "https://darksouls3.wiki.fextralife.com/file/Dark-Souls-3/knight_small.jpg",
        stats = "Strength: 13, Dexterity: 12, Intelligence: 9, Faith: 9",
        startingEquipment = "Longsword(1blu, 0 Phys, 0 Mag, 0 Dodge), Iron Shield(1blk Phys, 0 Mag, 0 Dodge), Knight Armour(1blu Phys, 1blk Mag, 0 Dodge)"
    },
    ["Assassin"] = {
        name = "Assassin",
        image = "https://darksouls3.wiki.fextralife.com/file/Dark-Souls-3/assassin_small.jpg",
        stats = "Strength: 10, Dexterity: 14, Intelligence: 11, Faith: 9",
        startingEquipment = "Estoc(2blk -1, 0 Phys, 0 Mag, 0 Dodge), Target Shield(0 Phys, 0 Mag, 1 Dodge), Assassin Armour(1blk Phys, 1blk Mag, 1 Dodge)"
    },
    ["Warrior"] = {
        name = "Warrior",
        image = "https://darksouls3.wiki.fextralife.com/file/Dark-Souls-3/warrior_small.jpg",
        stats = "Strength: 16, Dexterity: 9, Intelligence: 8, Faith: 9",
        startingEquipment = "Battle Axe(2blk, 0 Phys, 0 Mag, 0 Dodge), Round Shield(1blk Phys, 0 Mag, 0 Dodge) Northern Armour(1blk Phys, 1blk Mag, 1 Dodge)"
    },
    ["Herald"] = {
        name = "Herald",
        image = "https://darksouls3.wiki.fextralife.com/file/Dark-Souls-3/herald_small.jpg",
        stats = "Strength: 12, Dexterity: 11, Intelligence: 8, Faith: 13",
        startingEquipment = "Spear(1blk (Shaft), 0 Phys, 0 Mag, 0 Dodge), Iron Shield(1blk Phys, 0 Mag, 0 Dodge), Herald Armour(1blk Phys, 1blk Mag, 1 Dodge)"
    },
    ["Thief"] = {
        name = "Thief",
        image = "https://darksouls3.wiki.fextralife.com/file/Dark-Souls-3/thief_small.jpg",
        stats = "Strength: 9, Dexterity: 13, Intelligence: 10, Faith: 8",
        startingEquipment = "Bandit Knife(1blk, 0 Phys, 0 Mag, 0 Dodge), Shortbow(1blu (Shaft), 0 Phys, 0 Mag, 0 Dodge), Iron Round Shield(0 Phys, 0 Mag, 1 Dodge (Can use with two-handed weapon)), Deserter Armour(1blk Phys, 1blk Mag, 1 Dodge)"
    },
    ["Mercenary"] = {
        name = "Mercenary",
        image = "https://darksouls3.wiki.fextralife.com/file/Dark-Souls-3/mercenary_small.jpg",
        stats = "Strength: 10, Dexterity: 16, Intelligence: 10, Faith: 8",
        startingEquipment = "Sellsword Twinblade(1blk, 0 Phys, 0 Mag, 0 Dodge) x2, Wooden Shield(0 Phys, 0 Mag, 1 Dodge), Sellsword Armour(1blk Phys, 1blk Mag, 1 Dodge)"
    },
    ["Cleric"] = {
        name = "Cleric",
        image = "https://darksouls3.wiki.fextralife.com/file/Dark-Souls-3/cleric_small.jpg",
        stats = "Strength: 12, Dexterity: 8, Intelligence: 7, Faith: 16",
        startingEquipment = "Mace(1blu, 0 Phys, 1blk Mag, 0 Dodge), Sacred Chime(1 Char within 2 nodes gains 1 health, 0 Phys, 1blk Mag, 0 Dodge), Blue Wooden Shield(1blk Phys, 0 Mag, 0 Dodge), Cleric Robes(1blk Phys, 1blu Mag, 0 Dodge)"
    },
    ["Pyromancer"] = {
        name = "Pyromancer",
        image = "https://darksouls3.wiki.fextralife.com/file/Dark-Souls-3/pyromancer_small.jpg",
        stats = "Strength: 12, Dexterity: 9, Intelligence: 14, Faith: 14",
        startingEquipment = "Hand Axe(1blk, 0 Phys, 0 Mag, 0 Dodge), Pyromancy Flame(1blk (Magical), 0 Phys, 0 Mag, 0 Dodge), Caduceus Round Shield(1blu Phys, 0 Mag, 0 Dodge), Pyromancer Garb(0 Phys, 2blk Mag, 1 Dodge)"
    },
    ["Sorcerer"] = {
        name = "Sorcerer",
        image = "https://darksouls3.wiki.fextralife.com/file/Dark-Souls-3/sorcerer_small.jpg",
        stats = "Strength: 7, Dexterity: 12, Intelligence: 16, Faith: 7",
        startingEquipment = "Mail Breaker(1blk, 0 Phys, 0 Mag, 0 Dodge), Sorcerer's Staff(1blu (Magical), 0 Phys, 0 Mag, 0 Dodge), Leather Shield(0 Phys, 1blk Mag, 1 Dodge), Sorcerer Robe(1blk Phys, 1blu Mag, 0 Dodge)"
    },
    ["Deprived"] = {
        name = "Deprived",
        image = "https://darksouls3.wiki.fextralife.com/file/Dark-Souls-3/deprived_small.jpg",
        stats = "Strength: 10, Dexterity: 10, Intelligence: 10, Faith: 10",
        startingEquipment = "Club(1blk, 0 Phys, 0 Mag, 0 Dodge), Plank Shield(1blk Phys, 0 Mag, 0 Dodge), Loincloth(0 Phys, 1blk Mag, 0 Dodge)"
    }
}

playerChoices = {}
totalPlayers = 0
pendingStandardGameParams = nil
selected = nil -- временная переменная для UI

function showCharacterSelectionUI(playersColors)
    print(tostring(playersColors))
    playerChoices = {}
    selected = "Knight"
    local rowHeight = 270
    local spacing = 5
    local padding = 5
    local charCount = 0
    local charXml = ""

    for charName, data in pairs(charactersData) do
        charCount = charCount + 1
        charXml = charXml .. string.format([[
            <HorizontalLayout childForceExpandHeight="false" childForceExpandWidth="false" childAlignment="MiddleLeft" spacing="10" color="Black" minHeight="270" padding="5">
                <Image image="%s" preserveAspect="true" minHeight="265" minWidth="78" />
                <VerticalLayout childForceExpandHeight="false" preferredWidth="1300" padding="5,5,0,0">
                    <Text fontSize="24" color="#FFFFFF" text="%s" />
                    <Text fontSize="18" color="#FFFFFF" text="%s" />
                    <Text fontSize="14" color="#FFFFFF" text="Стартовое снаряжение: %s" horizontalOverflow="Wrap" />
                </VerticalLayout>
                <Toggle id="toggle_%s" text="" minWidth="30" onValueChanged="charSelectionChanged"/>
            </HorizontalLayout>
        ]], data.image or "", data.name, data.stats, data.startingEquipment, charName)
    end

    local totalHeight = charCount * rowHeight + (charCount - 1) * spacing + padding * 2

    local uiXml = string.format([[
    <Panel id="charSelectionPanel" visibility="%s" width="600" height="500" color="#2b2b2b" rectAlignment="MiddleCenter">
        <VerticalLayout padding="5" childForceExpandHeight="false">
            <Text fontSize="20" minHeight="50" color="#FFFFFF" alignment="MiddleCenter">Выберите персонажа</Text>
            <VerticalScrollView minHeight="400">
                <ToggleGroup height="%d">
                    <VerticalLayout spacing="5" padding="5" id="charactersList" childForceExpandHeight="false" minHeight="%d">
                        %s
                    </VerticalLayout>
                </ToggleGroup>
            </VerticalScrollView>
            <Button onClick="confirmCharacter" minHeight="40" color="#4CAF50">Подтвердить</Button>
        </VerticalLayout>
    </Panel>
    ]], playersColors, totalHeight, totalHeight, charXml)

    self.UI.setXml(uiXml)

    Wait.time(function()
        for charName, _ in pairs(charactersData) do
            local id = "toggle_" .. charName
            self.UI.setAttribute(id, "group", "characterGroup")
        end
    end, 0.1)
end

function charSelectionChanged(_, value, id)
    if value == "True" then
        selected = id:gsub("^toggle_", "")
        print("[DEBUG] Выбран персонаж: " .. selected)
    end
end

function confirmCharacter(player, _, _)
    if not selected then
        broadcastToAll("Выберите персонажа!", { 1, 0, 0 })
        return
    end

    local color = player.color
    if playerChoices[color] then
        broadcastToAll("Вы уже выбрали персонажа!", { 1, 0, 0 })
        return
    end

    playerChoices[color] = selected
    broadcastToAll("Игрок " .. tostring(color) .. " выбрал: " .. selected)
    selected = nil

    local currentVis = self.UI.getAttribute("charSelectionPanel", "visibility") or ""
    print(tostring(currentVis))
    local colors = {}
    for c in string.gmatch(currentVis, "[^|]+") do
        if c ~= color then
            table.insert(colors, c)
        end
    end
    print(tostring(colors))
    local newVis = table.concat(colors, "|")
    print(tostring(newVis))
    self.UI.setAttribute("charSelectionPanel", "visibility", newVis)

    if newVis == "" then
        self.UI.setXml("")
        setupCharacters(playerChoices)
    end
end

-- ============================================
-- НАСТРОЙКА ПЕРСОНАЖЕЙ (добавить в глобальный скрипт)
-- ============================================

-- GUID планшетов игроков (замените на реальные из вашего мода)
playerBoardGUIDs = {
    ["White"] = "790737",
    ["Green"] = "098220",
    ["Red"] = "cbeedf",
    ["Blue"] = "f78f18"
}

-- GUID контейнеров с ресурсами
containers = {
    -- Контейнеры для каждого персонажа (фигурки и мешки колод)
    ["Knight"] = {
        Figure = "31323f",
        Decks = "785ef4"
    },
    ["Warrior"] = {
        Figure = "4ba67b",
        Decks = "e61fba"
    },
    ["Assassin"] = {
        Figure = "185fef",
        Decks = "838b37"
    },
    ["Herald"] = {
        Figure = "40d0cd",
        Decks = "d8a8df"
    },
    ["Thief"] = {
        Figure = "944f69",
        Decks = "5b18fa"
    },
    ["Mercenary"] = {
        Figure = "1c8794",
        Decks = "e80dc5"
    },
    ["Cleric"] = {
        Figure = "813dde",
        Decks = "461f0d"
    },
    ["Pyromancer"] = {
        Figure = "3ecb33",
        Decks = "04281b"
    },
    ["Sorcerer"] = {
        Figure = "ef6467",
        Decks = "e2edde"
    },
    ["Deprived"] = {
        Figure = "95ca44",
        Decks = "53fd14"
    },
    -- Общие контейнеры с жетонами
    estusTokens = "15f264",
    luckTokens = "e6e476",
    heroicActionTokens = "db68eb",
    upgradeTokens = "a7741d"
}

-- Получить индекс состояния планшета по имени персонажа
function getCharacterStateIndex(characterName)
    local order = {"Knight", "Warrior", "Assassin", "Herald", "Thief", "Mercenary", "Cleric", "Pyromancer", "Sorcerer", "Deprived"}
    for i, name in ipairs(order) do
        if name == characterName then
            return i
        end
    end
    print("[ERROR] Не найден индекс состояния для персонажа " .. characterName)
    return 1 -- по умолчанию первый
end

-- Извлекает объект из контейнера по GUID и имени (или никнейму)
function takeObjectFromContainer(containerGUID, objectName)
    local container = getObjectFromGUID(containerGUID)
    if not container then
        print("[ERROR] Контейнер не найден: " .. containerGUID)
        return nil
    end
    local contained = container.getData().ContainedObjects
    for _, objData in ipairs(contained) do
        if objData.name == objectName or objData.Nickname == objectName then
            local obj = container.takeObject({ index = objData.index, position = {0, 10, 0}, smooth = false })
            return obj
        end
    end
    print("[WARN] Объект " .. objectName .. " не найден в контейнере " .. containerGUID)
    return nil
end

-- Размещает объект на планшете, ища snap point с заданным тегом
function placeOnSnapPointByTag(board, obj, tag)
    local snapPoints = board.getSnapPoints()
    for _, point in ipairs(snapPoints) do
        if point.tags and point.tags[1] == tag then
            local worldPos = board.positionToWorld(point.position)
            obj.setPosition(worldPos)
            if point.rotation then
                obj.setRotation(point.rotation)
            end
            return true
        end
    end
    print("[WARN] Не найден snap point с тегом " .. tag .. " на планшете " .. board.getName())
    return false
end

-- Настраивает планшет для игрока: жетоны, маркеры, стартовое снаряжение
function setupPlayerBoard(playerColor, characterName)
    local boardGUID = playerBoardGUIDs[playerColor]
    if not boardGUID then
        print("[ERROR] Нет GUID для планшета игрока " .. playerColor)
        return nil
    end
    local board = getObjectFromGUID(boardGUID)
    if not board then
        print("[ERROR] Планшет не найден: " .. boardGUID)
        return nil
    end

    -- Устанавливаем состояние планшета в соответствии с выбранным персонажем
    local stateIndex = getCharacterStateIndex(characterName)
    board = board.setState(stateIndex + 1)
    print("[DEBUG] Планшет игрока " .. playerColor .. " установлен в состояние " .. stateIndex .. " (" .. characterName .. ")")

    -- 1. Жетон эстуса
    local estus = takeObjectFromContainer(containers.estusTokens, "Estus")
    if estus then placeOnSnapPointByTag(board, estus, "EstusToken") end

    -- 2. Жетон удачи
    local luck = takeObjectFromContainer(containers.luckTokens, "Luck")
    if luck then placeOnSnapPointByTag(board, luck, "LuckToken") end

    -- 3. Жетон героического действия
    local heroic = takeObjectFromContainer(containers.heroicActionTokens, "Heroic Action")
    if heroic then placeOnSnapPointByTag(board, heroic, "HeroicActionToken") end

    -- 4. Маркеры повышения (4 штуки)
    local upgradeBag = getObjectFromGUID(containers.upgradeTokens)
    if upgradeBag then
        local upgrades = {
            strength = "StrengthBase",
            dexterity = "DexterityBase",
            intelligence = "IntelligenceBase",
            faith = "FaithBase"
        }
        for stat, tag in pairs(upgrades) do
            local token = upgradeBag.takeObject({ position = {0,0,0}, smooth = false })
            if token then
                placeOnSnapPointByTag(board, token, tag)
            else
                print("[WARN] Не удалось взять маркер повышения для " .. stat)
            end
        end
    end

    -- 5. Стартовое снаряжение: извлекаем безк. контейнер с колодами
    local deckBagGUID = containers[characterName].Decks
    if deckBagGUID then
        local outerBag = getObjectFromGUID(deckBagGUID)
        if outerBag then
            local innerBagsData = outerBag.getData().ContainedObjects
            if #innerBagsData >= 1 then
                local innerBag = outerBag.takeObject({ index = innerBagsData[1].index, position = {0,0,0}, smooth = false })
                if innerBag then
                    local decksData = innerBag.getData().ContainedObjects
                    if #decksData >= 1 then
                        local starterDeck = innerBag.takeObject({ index = decksData[1].index, position = {0,0,0}, smooth = false })
                        if starterDeck then
                            -- Извлекаем все карты из колоды
                            local cards = {}
                            local deckContents = starterDeck.getData().ContainedObjects
                            for _, cardData in ipairs(deckContents) do
                                local card = starterDeck.takeObject({ index = cardData.index, position = {0,0,0}, smooth = false })
                                if card then
                                    table.insert(cards, card)
                                end
                            end

                            -- Разделяем карты по типам
                            local weapons = {}
                            local twoHandedWeapon = nil
                            local shields = {}
                            local armors = {}
                            local accessories = {}
                            for _, card in ipairs(cards) do
                                local notes = card.getGMNotes()
                                if notes and notes ~= "" then
                                    local success, data = pcall(JSON.decode, notes)
                                    if success then
                                        if data.type == "weapon" then
                                            if data.slot == "two_handed" then
                                                twoHandedWeapon = {card = card, data = data}
                                            else
                                                table.insert(weapons, {card = card, data = data})
                                            end
                                        elseif data.type == "shield" then
                                            table.insert(shields, {card = card, data = data})
                                        elseif data.type == "armor" then
                                            table.insert(armors, {card = card, data = data})
                                        elseif data.type == "accessory" then
                                            table.insert(accessories, {card = card, data = data})
                                        else
                                            print("[WARN] Неизвестный тип предмета: " .. data.type)
                                        end
                                    else
                                        print("[WARN] Не удалось распарсить GMNotes для " .. card.getName())
                                    end
                                else
                                    print("[WARN] Нет GMNotes для карты " .. card.getName())
                                end
                            end

                            -- Размещаем двуручное оружие (если есть)
                            if twoHandedWeapon then
                                placeOnSnapPointByTag(board, twoHandedWeapon.card, "WeaponSlotR")
                                twoHandedWeapon.card.locked = true
                            end

                            -- Размещаем одноручное оружие
                            local usedRight = twoHandedWeapon ~= nil
                            local usedLeft = false
                            for i, w in ipairs(weapons) do
                                if not usedRight then
                                    placeOnSnapPointByTag(board, w.card, "WeaponSlotR")
                                    w.card.locked = true
                                    usedRight = true
                                elseif not usedLeft then
                                    placeOnSnapPointByTag(board, w.card, "WeaponSlotL")
                                    w.card.locked = true
                                    usedLeft = true
                                else
                                    placeOnSnapPointByTag(board, w.card, "SpareSlot")
                                    w.card.locked = true
                                end
                            end

                            -- Размещаем щиты
                            for i, s in ipairs(shields) do
                                if not usedLeft then
                                    placeOnSnapPointByTag(board, s.card, "WeaponSlotL")
                                    s.card.locked = true
                                    usedLeft = true
                                else
                                    placeOnSnapPointByTag(board, s.card, "SpareSlot")
                                    s.card.locked = true
                                end
                            end

                            -- Размещаем броню
                            for _, a in ipairs(armors) do
                                placeOnSnapPointByTag(board, a.card, "ArmorSlot")
                                a.card.locked = true
                            end

                            -- Размещаем аксессуары
                            for _, acc in ipairs(accessories) do
                                placeOnSnapPointByTag(board, acc.card, "accessory")
                            end

                            starterDeck.destruct()
                        else
                            print("[ERROR] Не удалось извлечь колоду стартового снаряжения для " .. characterName)
                        end
                    else
                        print("[ERROR] Во внутренней сумке нет колод для " .. characterName)
                    end
                    innerBag.destruct()
                else
                    print("[ERROR] Не удалось извлечь внутреннюю сумку для " .. characterName)
                end
            else
                print("[ERROR] Во внешнем контейнере нет внутренних сумок для " .. characterName)
            end
        else
            print("[ERROR] Не найден контейнер с колодами для персонажа " .. characterName .. " (GUID " .. deckBagGUID .. ")")
        end
    else
        print("[ERROR] Нет GUID мешка колод для персонажа " .. characterName)
    end

    -- 6. Фигурка
    local figureGUID = containers[characterName].Figure
    local figure = nil
    if figureGUID then
        figure = takeObjectFromContainer(figureGUID, characterName)
    else
        print("[ERROR] Нет GUID фигурки для персонажа " .. characterName)
    end

    return figure
end

-- Основная функция настройки всех персонажей после выбора
function setupCharacters(characterChoices)
    broadcastToAll("Настройка персонажей", {0,1,0})

    local bonfireTile = findObjectByName("Bonfire Tile")
    local figures = {}
    for color, charName in pairs(characterChoices) do
        local figure = setupPlayerBoard(color, charName)
        if figure then
            table.insert(figures, figure)
        end
    end

    -- Размещаем фигурки на костре
    if bonfireTile then
        local snapPoints = bonfireTile.getSnapPoints()
        local spawnPoints = {}
        for _, point in ipairs(snapPoints) do
            if point.tags and point.tags[1] == "CharacterSpawn" then
                table.insert(spawnPoints, point)
            end
        end
        if #spawnPoints == 0 then
            spawnPoints = snapPoints
        end
        for i, figure in ipairs(figures) do
            if i <= #spawnPoints then
                local worldPos = bonfireTile.positionToWorld(spawnPoints[i].position)
                figure.setPosition(worldPos)
                figure.setRotation(spawnPoints[i].rotation or {0,0,0})
            else
                figure.setPosition(bonfireTile.getPosition())
            end
        end
    end

    broadcastToAll("Стол подготовлен, можно начинать игру!", {0,1,0})
end

-- ============================================
-- ЗАГРУЗКА
-- ============================================

function onLoad()
    Global.setTable("bossData", bossData)
    Global.setTable("campaignScenarios", campaignScenarios)
    print("Глобальные данные загружены")
end