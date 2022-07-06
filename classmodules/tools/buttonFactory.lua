local _, E = ...
E.BUTTON_FACTORY = {}
bf = E.BUTTON_FACTORY
bf.variables = {}
bf.constants = {}

bf.constants.ACTIVATED = "ACTIVE"
bf.constants.INACTIVE = "INACTIVE"
bf.constants.UNUSABLE = "UNUSABLE"

st = E.SPELL_TOOLS

function bf:setGlobalVariables(width, height)
    bf.variables.width = width;
    bf.variables.height = height
end

function bf:createSwitch(x, y, parent, buttonsData)
    local buttonsObject = {}
    buttonsObject.objects = {}

    for i, buttonData in pairs(buttonsData) do
        local buttonObject = bf:createButton(x+i-1, y, parent, buttonData.icon)
        buttonObject.textValue = buttonData.textValue;
        buttonObject.value = false;
        table.insert(buttonsObject.objects, buttonObject)
    end

    print(buttonsObject)

    for i, buttonObject in ipairs(buttonsObject.objects) do
        buttonObject.button:SetScript("OnClick",
                function()
                    for i, buttonObject in ipairs(buttonsObject.objects) do
                        buttonObject.value = false
                    end

                    buttonObject.value = true
                    buttonsObject.textValue = buttonObject.textValue;
                    buttonsObject.update()

                end
        )

        buttonObject.update = function()
            if buttonObject.value then
                buttonObject.overlayTexture:SetColorTexture(0, 1, 0, 0.5)
            else
                buttonObject.overlayTexture:SetColorTexture(1, 0, 0, 0.0)
            end
        end

        buttonObject.update()
    end

    buttonsObject.update = function()
        for i, buttonObject in ipairs(buttonsObject.objects) do
            buttonObject.update()
        end
    end

    return buttonsObject;

end



function bf:createToggleButton(x, y, parent, icon)
    local buttonObject = bf:createButton(x, y, parent, icon)
    buttonObject.value = false;
    buttonObject.button:SetScript("OnClick",
            function()
                buttonObject.value = not buttonObject.value
            end
    )

    buttonObject.update = function()
        if buttonObject.value then
            buttonObject.overlayTexture:SetDesaturated(true);
            buttonObject.overlayTexture:SetColorTexture(0, 1, 0, 0.0)
        else
            buttonObject.overlayTexture:SetDesaturated(false);
            buttonObject.overlayTexture:SetColorTexture(1, 0, 0, 0.5)
        end
    end

    buttonObject.update()
    return buttonObject
end

function bf:createTrinket1ActivatingButton(x, y, parent, icon)
    local buttonObject = bf:createActivatingButton(x, y, parent, icon)

    buttonObject.coolDownFunction = function()
        if st.getTrinket1CD(self) > 2 then
            buttonObject.value = bf.constants.UNUSABLE;
        else
            if buttonObject.value == bf.constants.UNUSABLE then
                buttonObject.value = bf.constants.INACTIVE;
            end
        end
    end

    buttonObject.update()

    return buttonObject
end

function bf:createTrinket2ActivatingButton(x, y, parent, icon)
    local buttonObject = bf:createActivatingButton(x, y, parent, icon)

    buttonObject.coolDownFunction = function()
        if st.getTrinket2CD(self) > 2 then
            buttonObject.value = bf.constants.UNUSABLE;
        else
            if buttonObject.value == bf.constants.UNUSABLE then
                buttonObject.value = bf.constants.INACTIVE;
            end
        end
    end

    buttonObject.update()

    return buttonObject
end

function bf:createItemActivatingButton(x, y, parent, icon, itemID)
    local buttonObject = bf:createActivatingButton(x, y, parent, icon)

    buttonObject.coolDownFunction = function()
        if st.getItemCD(self, itemID) > 2 then
            buttonObject.value = bf.constants.UNUSABLE;
        else
            if buttonObject.value == bf.constants.UNUSABLE then
                buttonObject.value = bf.constants.INACTIVE;
            end
        end
    end

    buttonObject.update()

    return buttonObject
end

function bf:createSpellActivatingButton(x, y, parent, icon, spellID)
    local buttonObject = bf:createActivatingButton(x, y, parent, icon)

    buttonObject.coolDownFunction = function()
        if st.getSpellCD(self,spellID) > 2 then
            buttonObject.value = bf.constants.UNUSABLE;
        else
            if buttonObject.value == bf.constants.UNUSABLE then
                buttonObject.value = bf.constants.INACTIVE;
            end
        end
    end

    buttonObject.update()

    return buttonObject
end

function bf:createActivatingButton(x, y, parent, icon)
    local buttonObject = bf:createButton(x, y, parent, icon)
    buttonObject.value = bf.constants.INACTIVE;
    buttonObject.coolDownFunction = coolDownFunction

    buttonObject.button:SetScript("OnClick", function()
        if buttonObject.value == bf.constants.UNUSABLE then
            return
        elseif buttonObject.value == bf.constants.ACTIVATED then
            buttonObject.value = bf.constants.INACTIVE
        elseif buttonObject.value == bf.constants.INACTIVE then
            buttonObject.value = bf.constants.ACTIVATED
        end
    end)

    buttonObject.update = function()
        buttonObject.coolDownFunction(buttonObject)

        if buttonObject.value == bf.constants.UNUSABLE then
            buttonObject.overlayTexture:SetColorTexture(1, 0, 0, 0.5)
        elseif buttonObject.value == bf.constants.ACTIVATED then
            buttonObject.overlayTexture:SetColorTexture(0, 1, 0, 0.5)
        elseif buttonObject.value == bf.constants.INACTIVE then
            buttonObject.overlayTexture:SetColorTexture(0, 1, 0, 0.0)
        end
    end

    buttonObject.isActivated = function()
        if buttonObject.value == bf.constants.ACTIVATED then return true
        else return false end
    end

    return buttonObject

end

function bf:createButton(x, y, parent, icon)
    local buttonObject = {}

    buttonObject.button = CreateFrame("Button", nil, parent)
    buttonObject.button:SetPoint("BOTTOMLEFT", x * bf.variables.width, y * bf.variables.height)
    buttonObject.button:SetSize(bf.variables.width, bf.variables.height)

    buttonObject.button:RegisterForClicks("AnyUp")

    buttonObject.button:SetScript("OnClick", clickFunction)

    buttonObject.texture = buttonObject.button:CreateTexture(nil, "BACKGROUND")
    buttonObject.texture:SetPoint("BOTTOMLEFT", 0, 0)
    buttonObject.texture:SetSize(bf.variables.width, bf.variables.height)
    buttonObject.texture:SetTexture(icon);

    buttonObject.overlayTexture = buttonObject.button:CreateTexture(nil, "OVERLAY")
    buttonObject.overlayTexture:SetPoint("BOTTOMLEFT", 0, 0)
    buttonObject.overlayTexture:SetSize(bf.variables.width, bf.variables.height)

    return buttonObject
end