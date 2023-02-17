if GetResourceState('es_extended') == 'missing' then return end

local groups = { 'job', 'job2' }
PlayerItems = {}
local playerGroups = {}

local function setPlayerData(playerData)
    if playerData.inventory then
        for _, v in pairs(playerData.inventory) do
            if v.count > 0 then
                PlayerItems[v.name] = v.count
            end
        end
    end

    for i = 1, #groups do
        local group = groups[i]
        local data = playerData[group]

        if data then
            playerGroups[group] = data
        end
    end
end

SetTimeout(0, function()
    local ESX = exports.es_extended:getSharedObject()

    if ESX.PlayerLoaded then
        setPlayerData(ESX.PlayerData)
    end

    if GetResourceState('ox_inventory') ~= 'missing' then
        setmetatable(PlayerItems, {
            __index = function(self, index)
                self[index] = exports.ox_inventory:Search('count', index) or 0
                return self[index]
            end
        })
    end
end)

RegisterNetEvent('esx:playerLoaded', function(data)
    if source == '' then return end
    setPlayerData(data)
end)

RegisterNetEvent('esx:setJob', function(job)
    if source == '' then return end
    playerGroups.job = job
end)

RegisterNetEvent('esx:setJob2', function(job)
    if source == '' then return end
    playerGroups.job2 = job
end)

function PlayerHasGroups(filter)
    local _type = type(filter)
    for i = 1, #groups do
        local group = groups[i]

        if _type == 'string' then
            local data = playerGroups[group]

            if filter == data?.name then
                return true
            end
        elseif _type == 'table' then
            local tabletype = table.type(filter)

            if tabletype == 'hash' then
                for name, grade in pairs(filter) do
                    local data = playerGroups[group]

                    if data?.name == name and grade <= data.grade then
                        return true
                    end
                end
            elseif tabletype == 'array' then
                for j = 1, #filter do
                    local name = filter[j]
                    local data = playerGroups[group]

                    if data?.name == name then
                        return true
                    end
                end
            end
        end
    end
end

RegisterNetEvent('esx:addInventoryItem', function(name, count)
    PlayerItems[name] = count
end)

RegisterNetEvent('esx:removeInventoryItem', function(name, count)
    PlayerItems[name] = count
end)
