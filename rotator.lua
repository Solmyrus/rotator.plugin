---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Vojta.
--- DateTime: 16.03.2022 10:47
---
local _, E = ...

E.initAddon()

function toggleActive()
    E.active = not E.active;
end

function toggleButton(index)
    if(E.CLASS_CONFIGURATION.toggleFunctions[index]) then
        E.CLASS_CONFIGURATION.toggleFunctions[index]()
    end
end

