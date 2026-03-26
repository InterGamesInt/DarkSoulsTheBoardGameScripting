-- ============================================
-- СКРИПТ ДЛЯ ОБЪЕКТА-ПАНЕЛИ НАСТРОЕК (с панелью выбора наборов сокровищ)
-- ============================================

-- Глобальные переменные (без local)
selectedMiniBoss = "Asylum Demon"
selectedMainBoss = "Artorias"
selectedCampaign = "A Hollow Pursuit"
selectedTileSets = {"Core Map Tiles"}                     -- по умолчанию выбран Core Tiles
selectedEncounterSets = {}                                 -- дополнительные наборы карт стычек
selectedTreasureSets = {}                                  -- дополнительные наборы карт сокровищ (Core всегда активен)
currentPlayerCount = 2

function onLoad()
    print("[DEBUG] onLoad панели вызван")
    createSettingsButton()
end

function createSettingsButton()
    self.createButton({
        label = "⚙️ Настройки",
        click_function = "openSetupUI",
        function_owner = self,
        position = {0, 0.5, 0},
        rotation = {0, 180, 0},
        height = 300,
        width = 900,
        font_size = 100
    })
    print("[DEBUG] кнопка создана")
end

function removeSettingsButton()
    self.removeButton(0)
    print("[DEBUG] кнопка удалена")
end

function openSetupUI()
    print("[DEBUG] openSetupUI вызвана")
    removeSettingsButton()

    selectedMiniBoss = "Asylum Demon"
    selectedMainBoss = "Artorias"
    selectedCampaign = "A Hollow Pursuit"
    selectedTileSets = {"Core Map Tiles"}                     -- по умолчанию выбран Core Tiles
    selectedEncounterSets = {}                                 -- дополнительные наборы карт стычек
    selectedTreasureSets = {}                                  -- дополнительные наборы карт сокровищ (Core всегда активен)
    currentPlayerCount = 2

    local bossData = Global.getTable("bossData")
    local campaignScenarios = Global.getTable("campaignScenarios")
    if not bossData or not campaignScenarios then
        broadcastToAll("Ошибка: глобальные данные не найдены!", {1,0,0})
        createSettingsButton()
        return
    end

    -- Собираем списки мини-боссов и главных боссов
    local miniBosses, mainBosses = {}, {}
    for name, data in pairs(bossData) do
        if data.type == "mini" then
            table.insert(miniBosses, name)
        elseif data.type == "main" then
            table.insert(mainBosses, name)
        end
    end
    table.sort(miniBosses)
    table.sort(mainBosses)

    -- Список названий кампаний (убираем дубликаты)
    local campaignNames = {}
    local seen = {}
    for key, sc in pairs(campaignScenarios) do
        local rawName = sc.name
        if not seen[rawName] then
            table.insert(campaignNames, rawName)
            seen[rawName] = true
        end
    end
    table.sort(campaignNames)

    -- Функция экранирования для XML
    local function xmlEscape(s)
        if not s then return "" end
        s = s:gsub("&", "&amp;")
        s = s:gsub("<", "&lt;")
        s = s:gsub(">", "&gt;")
        s = s:gsub('"', "&quot;")
        s = s:gsub("'", "&apos;")
        return s
    end

    -- Функция генерации опций для Dropdown
    local function buildOptions(list)
        local opts = {}
        for _, item in ipairs(list) do
            local esc = xmlEscape(item)
            table.insert(opts, string.format('<Option value="%s">%s</Option>', esc, esc))
        end
        if #opts == 0 then
            table.insert(opts, '<Option value="Нет доступных">Нет доступных</Option>')
        end
        return table.concat(opts, "\n")
    end

    local miniBossOptions = buildOptions(miniBosses)
    local mainBossOptions = buildOptions(mainBosses)
    local campaignOptions = buildOptions(campaignNames)

    -- Формируем XML
    local uiXml = string.format([[
<VerticalLayout id="setupPanel" width="800" height="600" color="#2b2b2b" padding="10" rectAlignment="MiddleCenter" childForceExpandWidth="true" childForceExpandHeight="false" spacing="10">
    <Text fontSize="24" color="white" alignment="MiddleCenter" minHeight="40" preferredHeight="40" flexibleWidth="1">⚙️ Настройка игры Dark Souls</Text>

    <HorizontalLayout spacing="20" minHeight="40" preferredHeight="40" childForceExpandWidth="true" childForceExpandHeight="false" childAlignment="MiddleCenter">
        <Text fontSize="18" color="white" minWidth="200" minHeight="30" alignment="MiddleLeft">Режим игры:</Text>
        <ToggleGroup id="modeGroup" flexibleWidth="1" minHeight="30" preferredHeight="30">
            <HorizontalLayout childForceExpandWidth="false" childForceExpandHeight="false">
                <Toggle id="standardToggle" text="Стандартный" isOn="true" onClick="onModeSelected" flexibleWidth="1" minHeight="30" preferredHeight="30" textColor="#FFFFFF"/>
                <Toggle id="campaignToggle" text="Кампания" isOn="false" onClick="onModeSelected" flexibleWidth="1" minHeight="30" preferredHeight="30" textColor="#FFFFFF"/>
            </HorizontalLayout>
        </ToggleGroup>
    </HorizontalLayout>

    <Panel id="standardPanel" active="true" color="#3a3a3a" padding="10">
        <VerticalLayout childForceExpandWidth="true" childForceExpandHeight="false" childAlignment="MiddleCenter" spacing="10">
            <HorizontalLayout spacing="10" minHeight="40" preferredHeight="40" childForceExpandWidth="true" childForceExpandHeight="false" childAlignment="MiddleCenter">
                <Text fontSize="18" color="white" minWidth="200" alignment="MiddleLeft">Мини-босс:</Text>
                <Dropdown id="miniBoss" flexibleWidth="1" minHeight="35" preferredHeight="35" scrollSensitivity="6" onValueChanged="onMiniBossSelected">
%s
                </Dropdown>
            </HorizontalLayout>
            <HorizontalLayout spacing="10" minHeight="40" preferredHeight="40" childForceExpandWidth="true" childForceExpandHeight="false" childAlignment="MiddleCenter">
                <Text fontSize="18" color="white" minWidth="200" alignment="MiddleLeft">Главный босс:</Text>
                <Dropdown id="mainBoss" flexibleWidth="1" minHeight="35" preferredHeight="35" scrollSensitivity="6" onValueChanged="onMainBossSelected">
%s
                </Dropdown>
            </HorizontalLayout>
        </VerticalLayout>
    </Panel>

    <Panel id="campaignPanel" active="false" flexibleHeight="1" color="#3a3a3a" padding="10">
        <HorizontalLayout spacing="10" minHeight="40" preferredHeight="40" childForceExpandWidth="true" childForceExpandHeight="false" childAlignment="MiddleCenter">
            <Text fontSize="18" color="white" minWidth="200" alignment="MiddleLeft">Сценарий:</Text>
            <Dropdown id="campaignChoice" flexibleWidth="1" minHeight="35" preferredHeight="35" onValueChanged="onCampaignSelected">
%s
            </Dropdown>
        </HorizontalLayout>
    </Panel>

    <!-- Панель выбора наборов тайлов -->
    <Panel id="tileSetsPanel" active="true" color="#3a3a3a" padding="5" minHeight="50" preferredHeight="50">
        <VerticalLayout childForceExpandWidth="true" childForceExpandHeight="false" childAlignment="MiddleCenter">
            <Text fontSize="16" color="white" alignment="MiddleCenter">Выберите наборы тайлов:</Text>
            <HorizontalLayout spacing="10" childAlignment="MiddleCenter" childForceExpandWidth="true">
                <Toggle id="setCore" text="Core Tiles" textColor="white" isOn="true" onValueChanged="onTileSetSelected" flexibleWidth="1" minHeight="30" preferredHeight="30"/>
                <Toggle id="setDarkwood" text="Darkwood Tiles" textColor="white" isOn="false" onValueChanged="onTileSetSelected" flexibleWidth="1" minHeight="30" preferredHeight="30"/>
                <Toggle id="setIronKeep" text="Iron Keep Tiles" textColor="white" isOn="false" onValueChanged="onTileSetSelected" flexibleWidth="1" minHeight="30" preferredHeight="30"/>
                <Toggle id="setExtra" text="Extra Map Tiles" textColor="white" isOn="false" onValueChanged="onTileSetSelected" flexibleWidth="1" minHeight="30" preferredHeight="30"/>
            </HorizontalLayout>
        </VerticalLayout>
    </Panel>

    <!-- Панель выбора дополнительных наборов карт стычек (Core всегда активны) -->
    <Panel id="encounterSetsPanel" active="true" color="#3a3a3a" padding="5" minHeight="50" preferredHeight="50">
        <VerticalLayout childForceExpandWidth="true" childForceExpandHeight="false" childAlignment="MiddleCenter">
            <Text fontSize="16" color="white" alignment="MiddleCenter">Дополнительные наборы карт стычек:</Text>
            <HorizontalLayout spacing="10" childAlignment="MiddleCenter" childForceExpandWidth="true">
                <Toggle id="setDarkrootEncounters" text="Darkroot Encounters" textColor="white" isOn="false" onValueChanged="onEncounterSetSelected" flexibleWidth="1" minHeight="30" preferredHeight="30"/>
                <Toggle id="setIronKeepEncounters" text="Iron Keep Encounters" textColor="white" isOn="false" onValueChanged="onEncounterSetSelected" flexibleWidth="1" minHeight="30" preferredHeight="30"/>
                <Toggle id="setExplorersEncounters" text="Explorers Encounters" textColor="white" isOn="false" onValueChanged="onEncounterSetSelected" flexibleWidth="1" minHeight="30" preferredHeight="30"/>
            </HorizontalLayout>
        </VerticalLayout>
    </Panel>

    <!-- Панель выбора дополнительных наборов карт сокровищ (Core Treasure всегда активны) -->
    <Panel id="treasureSetsPanel" active="true" color="#3a3a3a" padding="5" minHeight="50" preferredHeight="50">
        <VerticalLayout childForceExpandWidth="true" childForceExpandHeight="false" childAlignment="MiddleCenter">
            <Text fontSize="16" color="white" alignment="MiddleCenter">Дополнительные наборы карт сокровищ:</Text>
            <HorizontalLayout spacing="10" childAlignment="MiddleCenter" childForceExpandWidth="true">
                <Toggle id="setDarkrootTreasure" text="Darkroot Treasure" textColor="white" isOn="false" onValueChanged="onTreasureSetSelected" flexibleWidth="1" minHeight="30" preferredHeight="30"/>
                <Toggle id="setIronKeepTreasure" text="Iron Keep Treasure" textColor="white" isOn="false" onValueChanged="onTreasureSetSelected" flexibleWidth="1" minHeight="30" preferredHeight="30"/>
                <Toggle id="setExplorersTreasure" text="Explorers Treasure" textColor="white" isOn="false" onValueChanged="onTreasureSetSelected" flexibleWidth="1" minHeight="30" preferredHeight="30"/>
                <Toggle id="setCharactersTreasure" text="Characters Treasure" textColor="white" isOn="false" onValueChanged="onTreasureSetSelected" flexibleWidth="1" minHeight="30" preferredHeight="30"/>
            </HorizontalLayout>
        </VerticalLayout>
    </Panel>

    <HorizontalLayout spacing="10" minHeight="40" preferredHeight="40" childForceExpandWidth="false" childForceExpandHeight="false" childAlignment="MiddleCenter">
        <Text fontSize="18" color="white" minHeight="40" preferredHeight="40" alignment="MiddleLeft">Количество игроков:</Text>
        <Text fontSize="14" color="gray" minWidth="20" preferredWidth="20" alignment="MiddleRight">1</Text>
        <Slider id="playerCount"
            minValue="1"
            maxValue="4"
            value="2"
            flexibleWidth="1"
            minHeight="20"
            preferredHeight="20"
            wholeNumbers="true"
            backgroundColor="#3a3a3a"
            onValueChanged="updatePlayerCountLabel"
        />
        <Text fontSize="14" color="gray" minWidth="20" preferredWidth="20" alignment="MiddleLeft">4</Text>
        <Text id="playerCountLabel" fontSize="18" color="white" minWidth="20" preferredWidth="20" alignment="MiddleCenter">2</Text>
    </HorizontalLayout>

    <HorizontalLayout spacing="20" minHeight="50" preferredHeight="50" childForceExpandWidth="true" childForceExpandHeight="false">
        <Button onClick="applySetup" flexibleWidth="1" minHeight="40" preferredHeight="40" color="#4CAF50">Применить и начать</Button>
        <Button onClick="closeUI" flexibleWidth="1" minHeight="40" preferredHeight="40" color="#f44336">Закрыть</Button>
    </HorizontalLayout>
</VerticalLayout>
    ]], miniBossOptions, mainBossOptions, campaignOptions)
    self.UI.setXml(uiXml)
    print("[DEBUG] XML интерфейса установлен")

    -- Небольшая задержка, чтобы UI успел отрисоваться
    Wait.time(function()
        -- Устанавливаем состояния тогглов для наборов тайлов
        for _, setName in ipairs(selectedTileSets) do
            if setName == "Core Map Tiles" then
                self.UI.setAttribute("setCore", "isOn", "true")
            elseif setName == "Darkwood Tiles" then
                self.UI.setAttribute("setDarkwood", "isOn", "true")
            elseif setName == "Iron Keep Tiles" then
                self.UI.setAttribute("setIronKeep", "isOn", "true")
            elseif setName == "Extra Map Tiles" then
                self.UI.setAttribute("setExtra", "isOn", "true")
            end
        end

        -- Блокируем единственный выбранный набор тайлов
        if #selectedTileSets == 1 then
            local onlyId = nil
            if selectedTileSets[1] == "Core Map Tiles" then
                onlyId = "setCore"
            elseif selectedTileSets[1] == "Darkwood Tiles" then
                onlyId = "setDarkwood"
            elseif selectedTileSets[1] == "Iron Keep Tiles" then
                onlyId = "setIronKeep"
            elseif selectedTileSets[1] == "Extra Map Tiles" then
                onlyId = "setExtra"
            end
            if onlyId then
                self.UI.setAttribute(onlyId, "interactable", "false")
            end
        end

        -- Устанавливаем состояния тогглов для дополнительных наборов карт стычек
        for _, setName in ipairs(selectedEncounterSets) do
            if setName == "Darkroot Encounters" then
                self.UI.setAttribute("setDarkrootEncounters", "isOn", "true")
            elseif setName == "Iron Keep Encounters" then
                self.UI.setAttribute("setIronKeepEncounters", "isOn", "true")
            elseif setName == "Explorers Encounters" then
                self.UI.setAttribute("setExplorersEncounters", "isOn", "true")
            end
        end

        -- Устанавливаем состояния тогглов для дополнительных наборов карт сокровищ
        for _, setName in ipairs(selectedTreasureSets) do
            if setName == "Darkroot Treasure" then
                self.UI.setAttribute("setDarkrootTreasure", "isOn", "true")
            elseif setName == "Iron Keep Treasure" then
                self.UI.setAttribute("setIronKeepTreasure", "isOn", "true")
            elseif setName == "Explorers Treasure" then
                self.UI.setAttribute("setExplorersTreasure", "isOn", "true")
            elseif setName == "Characters Treasure" then
                self.UI.setAttribute("setCharactersTreasure", "isOn", "true")
            end
        end
    end, 0.1)  -- задержка 0.1 секунды
end

-- Обработчики выбора в Dropdown
function onMiniBossSelected(_, value)
    selectedMiniBoss = value
    print("[DEBUG] выбран мини-босс: " .. tostring(value))
end

function onMainBossSelected(_, value)
    selectedMainBoss = value
    print("[DEBUG] выбран главный босс: " .. tostring(value))
end

function onCampaignSelected(_, value)
    selectedCampaign = value
    print("[DEBUG] выбран сценарий: " .. tostring(value))
end

-- Обработчик переключения режимов
function onModeSelected(_, value, id)
    print("[DEBUG] onModeSelected: id=" .. tostring(id) .. ", value=" .. tostring(value))
    if id == "standardToggle" then
        self.UI.setAttribute("standardPanel", "active", "true")
        self.UI.setAttribute("campaignPanel", "active", "false")
        self.UI.setAttribute("campaignToggle", "isOn", "false")
        self.UI.setAttribute("tileSetsPanel", "active", "true")
        self.UI.setAttribute("encounterSetsPanel", "active", "true")
        self.UI.setAttribute("treasureSetsPanel", "active", "true")   -- показываем
        self.UI.setAttribute("setupPanel", "height", "600")            -- увеличиваем высоту
    elseif id == "campaignToggle" then
        self.UI.setAttribute("standardPanel", "active", "false")
        self.UI.setAttribute("campaignPanel", "active", "true")
        self.UI.setAttribute("standardToggle", "isOn", "false")
        self.UI.setAttribute("tileSetsPanel", "active", "false")
        self.UI.setAttribute("encounterSetsPanel", "active", "false")
        self.UI.setAttribute("treasureSetsPanel", "active", "false")   -- скрываем
        self.UI.setAttribute("setupPanel", "height", "280")
    end
end

-- Обработчик выбора набора тайлов
function onTileSetSelected(_, value, id)
    print("[DEBUG] onTileSetSelected вызвана, id=" .. id .. ", value=" .. tostring(value))
    if value == "True" then
        if id == "setCore" then
            table.insert(selectedTileSets, "Core Map Tiles")
        elseif id == "setDarkwood" then
            table.insert(selectedTileSets, "Darkwood Tiles")
        elseif id == "setIronKeep" then
            table.insert(selectedTileSets, "Iron Keep Tiles")
        elseif id == "setExtra" then
            table.insert(selectedTileSets, "Extra Map Tiles")
        end
    else
        if #selectedTileSets > 1 then
            if id == "setCore" then
                for i, name in ipairs(selectedTileSets) do
                    if name == "Core Map Tiles" then
                        table.remove(selectedTileSets, i)
                        break
                    end
                end
            elseif id == "setDarkwood" then
                for i, name in ipairs(selectedTileSets) do
                    if name == "Darkwood Tiles" then
                        table.remove(selectedTileSets, i)
                        break
                    end
                end
            elseif id == "setIronKeep" then
                for i, name in ipairs(selectedTileSets) do
                    if name == "Iron Keep Tiles" then
                        table.remove(selectedTileSets, i)
                        break
                    end
                end
            elseif id == "setExtra" then
                for i, name in ipairs(selectedTileSets) do
                    if name == "Extra Map Tiles" then
                        table.remove(selectedTileSets, i)
                        break
                    end
                end
            end
        else
            self.UI.setAttribute(id, "isOn", "true")
            return
        end
    end

    -- Разблокируем все
    self.UI.setAttribute("setCore", "interactable", "true")
    self.UI.setAttribute("setDarkwood", "interactable", "true")
    self.UI.setAttribute("setIronKeep", "interactable", "true")
    self.UI.setAttribute("setExtra", "interactable", "true")

    print("[DEBUG] Выбранные наборы тайлов: " .. table.concat(selectedTileSets, ", "))
end

-- Обработчик выбора дополнительных наборов карт стычек
function onEncounterSetSelected(_, value, id)
    if value == "True" then
        if id == "setDarkrootEncounters" then
            table.insert(selectedEncounterSets, "Darkroot Encounters")
        elseif id == "setIronKeepEncounters" then
            table.insert(selectedEncounterSets, "Iron Keep Encounters")
        elseif id == "setExplorersEncounters" then
            table.insert(selectedEncounterSets, "Explorers Encounters")
        end
    else
        if id == "setDarkrootEncounters" then
            for i, name in ipairs(selectedEncounterSets) do
                if name == "Darkroot Encounters" then
                    table.remove(selectedEncounterSets, i)
                    break
                end
            end
        elseif id == "setIronKeepEncounters" then
            for i, name in ipairs(selectedEncounterSets) do
                if name == "Iron Keep Encounters" then
                    table.remove(selectedEncounterSets, i)
                    break
                end
            end
        elseif id == "setExplorersEncounters" then
            for i, name in ipairs(selectedEncounterSets) do
                if name == "Explorers Encounters" then
                    table.remove(selectedEncounterSets, i)
                    break
                end
            end
        end
    end

    -- Всегда разблокируем (никогда не блокируем последний)
    self.UI.setAttribute("setDarkrootEncounters", "interactable", "true")
    self.UI.setAttribute("setIronKeepEncounters", "interactable", "true")
    self.UI.setAttribute("setExplorersEncounters", "interactable", "true")

    print("[DEBUG] Выбранные дополнительные наборы карт стычек: " .. table.concat(selectedEncounterSets, ", "))
end

-- Обработчик выбора дополнительных наборов карт сокровищ
function onTreasureSetSelected(_, value, id)
    if value == "True" then
        if id == "setDarkrootTreasure" then
            table.insert(selectedTreasureSets, "Darkroot Treasure")
        elseif id == "setIronKeepTreasure" then
            table.insert(selectedTreasureSets, "Iron Keep Treasure")
        elseif id == "setExplorersTreasure" then
            table.insert(selectedTreasureSets, "Explorers Treasure")
        elseif id == "setCharactersTreasure" then
            table.insert(selectedTreasureSets, "Characters Treasure")
        end
    else
        if id == "setDarkrootTreasure" then
            for i, name in ipairs(selectedTreasureSets) do
                if name == "Darkroot Treasure" then
                    table.remove(selectedTreasureSets, i)
                    break
                end
            end
        elseif id == "setIronKeepTreasure" then
            for i, name in ipairs(selectedTreasureSets) do
                if name == "Iron Keep Treasure" then
                    table.remove(selectedTreasureSets, i)
                    break
                end
            end
        elseif id == "setExplorersTreasure" then
            for i, name in ipairs(selectedTreasureSets) do
                if name == "Explorers Treasure" then
                    table.remove(selectedTreasureSets, i)
                    break
                end
            end
        elseif id == "setCharactersTreasure" then
            for i, name in ipairs(selectedTreasureSets) do
                if name == "Characters Treasure" then
                    table.remove(selectedTreasureSets, i)
                    break
                end
            end
        end
    end

    -- Всегда разблокируем (никогда не блокируем последний)
    self.UI.setAttribute("setDarkrootTreasure", "interactable", "true")
    self.UI.setAttribute("setIronKeepTreasure", "interactable", "true")
    self.UI.setAttribute("setExplorersTreasure", "interactable", "true")
    self.UI.setAttribute("setCharactersTreasure", "interactable", "true")

    print("[DEBUG] Выбранные дополнительные наборы карт сокровищ: " .. table.concat(selectedTreasureSets, ", "))
end

-- Обновление метки слайдера
function updatePlayerCountLabel(_, value)
    currentPlayerCount = tonumber(value) or 2
    self.UI.setAttribute("playerCountLabel", "text", tostring(currentPlayerCount))
    print("[DEBUG] playerCountLabel обновлён: " .. currentPlayerCount)
end

-- Применение настроек
function applySetup()
    print("[DEBUG] applySetup вызвана")

    local playerCount = currentPlayerCount
    local isStandard = self.UI.getAttribute("standardPanel", "active") == "true"

    if isStandard then
        if not selectedMiniBoss or not selectedMainBoss then
            broadcastToAll("Выберите мини-босса и главного босса!", {1,0,0})
            return
        end
        print("Режим: Стандартный, игроков: " .. playerCount .. ", мини-босс: " .. selectedMiniBoss .. ", главный босс: " .. selectedMainBoss)
        Global.call("setupStandardGame", {selectedMiniBoss, selectedMainBoss, playerCount, selectedTileSets, selectedEncounterSets, selectedTreasureSets})
    else
        if not selectedCampaign then
            broadcastToAll("Выберите сценарий!", {1,0,0})
            return
        end
        local campaignScenarios = Global.getTable("campaignScenarios")
        local scenarioKey = nil
        for key, sc in pairs(campaignScenarios) do
            if sc.name == selectedCampaign then
                scenarioKey = key
                break
            end
        end
        if not scenarioKey then
            broadcastToAll("Ошибка: сценарий не найден в глобальных данных!", {1,0,0})
            return
        end
        print("Режим: Кампания, игроков: " .. playerCount .. ", сценарий: " .. selectedCampaign .. " (ключ: " .. scenarioKey .. ")")
        Global.call("setupCampaignGame", {scenarioKey, playerCount})
    end

    closeUI()
end

function closeUI()
    self.UI.setXml("")
    createSettingsButton()
    print("[DEBUG] UI закрыт, кнопка восстановлена")
end