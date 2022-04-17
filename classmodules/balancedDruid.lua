---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Vojta.
--- DateTime: 02.03.2022 9:34
---
local _, E = ...

E.BALANCED_DRUID_DATA = {}
bf = E.BUTTON_FACTORY

function E:initBalanceDruid()
    print("Initializing BALA")
    local data = E.BALANCED_DRUID_DATA

    data.balDruidFrame = CreateFrame("Frame", "BDruidFrame", UIParent)

    data.balDruidFrame:SetFrameStrata("TOOLTIP")
    data.balDruidFrame:SetWidth(150)
    data.balDruidFrame:SetHeight(120)

    data.combatTexture = data.balDruidFrame:CreateTexture(nil, "BACKGROUND")
    data.combatTexture:SetPoint("BOTTOMLEFT", 0, 90)
    data.combatTexture:SetSize(30, 30)


    data.activeTexture = data.balDruidFrame:CreateTexture(nil, "BACKGROUND")
    data.activeTexture:SetPoint("BOTTOMLEFT", 30, 90)
    data.activeTexture:SetSize(120, 30)

    data.toggleButtons = {}
    data.activatingButtons = {}

    bf.setGlobalVariables(self, 30,30)

    data.toggleButtons.moonFireButton = bf.createToggleButton(self,0,2, data.balDruidFrame, 136096)
    data.toggleButtons.starFireButton = bf.createToggleButton(self,1,2, data.balDruidFrame, 135753)
    data.toggleButtons.insectSwarmButton = bf.createToggleButton(self,2,2, data.balDruidFrame, 136045)
    data.toggleButtons.faerieFireButton = bf.createToggleButton(self,3,2, data.balDruidFrame, 136033)
    data.toggleButtons.runModeButton = bf.createToggleButton(self,4,2, data.balDruidFrame, 132539)


    data.activatingButtons.trinket1Button = bf.createTrinket1ActivatingButton(self,0,1, data.balDruidFrame, 135659)
    data.activatingButtons.drumsButton = bf.createItemActivatingButton(self,1,1, data.balDruidFrame, 133842, 185848)
    data.activatingButtons.destructionPotionButton = bf.createItemActivatingButton(self,0,0, data.balDruidFrame, 134729, 22839)


    data.activatingButtons.manaPotionButton = bf.createItemActivatingButton(self,3,1, data.balDruidFrame, 134762,22832)
    data.activatingButtons.darkRuneButton = bf.createItemActivatingButton(self,4,1, data.balDruidFrame, 136192, 20520)
    data.activatingButtons.innervateButton = bf.createSpellActivatingButton(self,3,0, data.balDruidFrame, 136048, 29166)


    data.balDruidFrame:SetPoint("CENTER", 0, 0)
    data.balDruidFrame:SetMovable(true)
    data.balDruidFrame:EnableMouse(true)
    data.balDruidFrame:RegisterForDrag("LeftButton")
    data.balDruidFrame:SetScript("OnDragStart", data.balDruidFrame.StartMoving)
    data.balDruidFrame:SetScript("OnDragStop", data.balDruidFrame.StopMovingOrSizing)

    E.actualizeBalanceDruidFrame()
    data.balDruidFrame:Hide()

end

function E:loadBalanceDruid()
    E.BALANCED_DRUID_DATA.balDruidFrame:Show()
    print("Loading BALA")
end

function E:unloadBalanceDruid()
    E.BALANCED_DRUID_DATA.balDruidFrame:Hide()
    print("Unloading BALA")
end

function E:updateBalanceDruid()

    local data = E.BALANCED_DRUID_DATA
    local serializationData = E.serializationData

    serializationData.profile = "bd_01";

    serializationData.pmfd = isUsableBySpellAndDebuff("Moonfire", "Moonfire", true, 0)
    serializationData.pmf = isUsableSpell("Moonfire")
    serializationData.psf = isUsableSpell("Starfire")
    serializationData.pff = isUsableBySpellAndDebuff("Faerie Fire", "Faerie Fire", false, 5)
    serializationData.pis = isUsableBySpellAndDebuff("Insect Swarm", "Insect Swarm", false, 2)

    serializationData.emf = data.toggleButtons.moonFireButton.value
    serializationData.esf = data.toggleButtons.starFireButton.value
    serializationData.eff = data.toggleButtons.faerieFireButton.value
    serializationData.eis = data.toggleButtons.insectSwarmButton.value
    serializationData.rm = data.toggleButtons.runModeButton.value

    serializationData.amp = data.activatingButtons.manaPotionButton.value
    serializationData.adr = data.activatingButtons.darkRuneButton.value
    serializationData.at = data.activatingButtons.trinket1Button.value
    serializationData.ad = data.activatingButtons.drumsButton.value
    serializationData.ai = data.activatingButtons.innervateButton.value
    serializationData.adp = data.activatingButtons.destructionPotionButton.value

    E.actualizeBalanceDruidFrame()
end

function E:actualizeBalanceDruidFrame()
    if UnitAffectingCombat("Player") then
        E.BALANCED_DRUID_DATA.combatTexture:SetColorTexture(0,1,0,0.5)
    else
        E.BALANCED_DRUID_DATA.combatTexture:SetColorTexture(1,0,0,0.5)
    end

    if E.active then
        E.BALANCED_DRUID_DATA.activeTexture:SetColorTexture(0,1,0,0.5)
    else
        if UnitAffectingCombat("Player") then
            E.BALANCED_DRUID_DATA.activeTexture:SetColorTexture(1,0.5,0,0.5)
        else
            E.BALANCED_DRUID_DATA.activeTexture:SetColorTexture(1,0,0,0.5)
        end
    end

    local data = E.BALANCED_DRUID_DATA

    data.toggleButtons.moonFireButton.update()
    data.toggleButtons.starFireButton.update()
    data.toggleButtons.insectSwarmButton.update()
    data.toggleButtons.faerieFireButton.update()
    data.toggleButtons.runModeButton.update()

    data.activatingButtons.trinket1Button.update()
    data.activatingButtons.destructionPotionButton.update()
    data.activatingButtons.drumsButton.update()
    data.activatingButtons.manaPotionButton.update()
    data.activatingButtons.darkRuneButton.update()
    data.activatingButtons.innervateButton.update()

end

E.CLASS_CONFIGURATIONS["DRUID_BALANCE"] = {
    ['profileName'] = 'balance',
    ['init'] = E.initBalanceDruid,
    ['load'] = E.loadBalanceDruid,
    ['unload'] = E.unloadBalanceDruid,
    ['update'] = E.updateBalanceDruid,
    ['toggleFunctions'] = {}
}
