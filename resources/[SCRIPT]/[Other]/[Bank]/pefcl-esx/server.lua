local ESX = exports['es_extended']:getSharedObject()

math.randomseed(os.time())
local charset = {}

do -- [0-9a-zA-Z]
    for c = 48, 57 do
        table.insert(charset, string.char(c))
    end
    for c = 65, 90 do
        table.insert(charset, string.char(c))
    end
    for c = 97, 122 do
        table.insert(charset, string.char(c))
    end
end

local function randomString(length)
    if not length or length <= 0 then
        return ''
    end
    return randomString(length - 1) .. charset[math.random(1, #charset)]
end

local AVOID_SYNC = randomString(20)

local function addCash(src, amount)
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.addMoney(amount)
end

local function removeCash(src, amount)
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeMoney(amount)
end

local function getCash(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    return xPlayer.getMoney()
end

local function syncBankBalance(account)
    local society = nil
    TriggerEvent('esx_society:getSociety', account.ownerIdentifier, function(_society)
        society = _society
    end)

    if society ~= nil then
        TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(societyAccount)
            -- TODO: Fix this asap
            -- societyAccount.setMoney(account.balance)
        end)
    end

    if not account.isDefault then
        return
    end

    local xPlayer = ESX.GetPlayerFromIdentifier(account.ownerIdentifier)

    if not xPlayer then
        return
    end

    xPlayer.setAccountMoney('bank', account.balance, AVOID_SYNC)
end

local function getBank(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    local account = xPlayer.getAccount('bank')
    return account.money
end

local function getCards(src)
    local retval = {}
    -- local inv = exports.ox_inventory:Inventory(src)
    local cards = exports.ox_inventory:Search(src, 'slots', 'mastercard')

    for _, v in pairs(cards) do
        retval[#retval + 1] = {
            id = v.metadata.id,
            holder = v.metadata.holder,
            number = v.metadata.number
        }
    end

    return retval
end

local function giveCard(src, card)
    -- local inv = exports.ox_inventory:Inventory(src)
    exports.ox_inventory:AddItem(src, 'mastercard', 1, {
        id = card.id,
        holder = card.holder,
        number = card.number,
        description = ('Card Number: %s'):format(card.number)
    })
end

local function updateSocietyAccountAccess(player, playerJob, playerLastJob)
    local citizenid = player.identifier
    local playerSrc = player.source
    local society = nil

    TriggerEvent('esx_society:getSociety', playerJob.name, function(_society)
        society = _society
    end)

    if society == nil then
        return
    end

    local currentUniqueAccount = exports.pefcl:getUniqueAccount(playerSrc, playerJob.name).data;

    if playerLastJob ~= nil and playerLastJob.name then
        local data = {
            userIdentifier = player.getIdentifier(),
            accountIdentifier = playerLastJob.name
        }
        exports.pefcl:removeUserFromUniqueAccount(playerSrc, data)
    end

    if not currentUniqueAccount then
        local data = {
            name = society.label,
            type = 'shared',
            identifier = playerJob.name
        }
        exports.pefcl:createUniqueAccount(playerSrc, data)
    end

    if playerJob.grade_name == "boss" then
        local data = {
            role = "admin",
            accountIdentifier = playerJob.name,
            userIdentifier = citizenid,
            source = playerSrc
        }
        exports.pefcl:addUserToUniqueAccount(playerSrc, data)
    end

end

local function updateBusinessAccountAccess(player, playerJob, playerLastJob)
    local citizenid = player.identifier
    local playerSrc = player.source

    if Config.BusinessAccounts[playerJob.name] == nil then
        return
    end

    local currentUniqueAccount = exports.pefcl:getUniqueAccount(playerSrc, playerJob.name).data;

    if playerLastJob ~= nil and playerLastJob.name then
        print("Removing from last job ..", playerLastJob.name)

        local data = {
            userIdentifier = player.getIdentifier(),
            accountIdentifier = playerLastJob.name
        }
        exports.pefcl:removeUserFromUniqueAccount(playerSrc, data)
    end

    if playerJob.grade < Config.BusinessAccounts[playerJob.name].ContributorRole then
        print("Grade below Contributor role. Returning.")
        return
    end

    -- If account doesn't exist, lets create it.
    if not exports.pefcl:getUniqueAccount(playerSrc, playerJob.name).data then
        local data = {
            name = Config.BusinessAccounts[playerJob.name].AccountName,
            type = 'shared',
            identifier = playerJob.name
        }
        exports.pefcl:createUniqueAccount(playerSrc, data)
    end

    local role = 'contributor'
    if playerJob.grade >= Config.BusinessAccounts[playerJob.name].AdminRole then
        role = 'admin'
    end

    if role then
        local data = {
            role = role,
            accountIdentifier = playerJob.name,
            userIdentifier = citizenid,
            source = playerSrc
        }
        exports.pefcl:addUserToUniqueAccount(playerSrc, data)
    end

end

-- Exports
exports("addCash", addCash)
exports("removeCash", removeCash)
exports("getCash", getCash)
exports("getBank", getBank)

if Config.OxInventory then
    exports("getCards", getCards)
    exports("giveCard", giveCard)
end

-- EVENTS: GLOBAL
AddEventHandler("playerDropped", function()
    local src = source
    exports.pefcl:unloadPlayer(src)
end)

AddEventHandler("onServerResourceStart", function(resName)
    local resourceName = GetCurrentResourceName();

    if resName ~= resourceName and resName ~= "pefcl" then
        return
    end

    if not GetResourceState("pefcl") == 'started' then
        return
    end

    local xPlayers = ESX.GetExtendedPlayers()
    for _, xPlayer in pairs(xPlayers) do
        Citizen.Wait(50)

        updateBusinessAccountAccess(xPlayer, xPlayer.getJob())
        updateSocietyAccountAccess(xPlayer, xPlayer.getJob())
        exports.pefcl:loadPlayer(xPlayer.source, {
            source = xPlayer.source,
            identifier = xPlayer.identifier,
            name = xPlayer.getName()
        })
    end
end)

-- EVENTS: ESX
AddEventHandler('esx:playerLoaded', function(playerSrc, xPlayer)
    if not xPlayer then
        return
    end

    exports.pefcl:loadPlayer(playerSrc, {
        source = playerSrc,
        identifier = xPlayer.getIdentifier(),
        name = xPlayer.getName()
    })
end)

AddEventHandler('esx:playerLogout', function(playerId)
    exports.pefcl:unloadPlayer(playerId)
end)

AddEventHandler('esx:addAccountMoney', function(playerSrc, accountName, amount, message)
    if accountName ~= "bank" or message == AVOID_SYNC then
        return
    end

    exports.pefcl:addBankBalance(playerSrc, {
        amount = amount,
        message = message
    })
end)

AddEventHandler('esx:removeAccountMoney', function(playerSrc, accountName, amount, message)
    if accountName ~= "bank" or message == AVOID_SYNC then
        return
    end

    exports.pefcl:removeBankBalance(playerSrc, {
        amount = amount,
        message = message
    })
end)

AddEventHandler('esx:setAccountMoney', function(playerSrc, accountName, amount, message)
    if accountName ~= "bank" or message == AVOID_SYNC then
        return
    end

    exports.pefcl:setBankBalance(playerSrc, {
        amount = amount,
        message = message
    })
end)

-- Handle society balance updates
AddEventHandler('esx_addonaccount:addMoney', function(identifier, amount)
    if string.find(identifier, "society_") then
        exports.pefcl:addBankBalanceByIdentifier(0, {
            amount = amount,
            message = Config.Locale.deposited,
            identifier = string.gsub(identifier, "society_", "")
        })
    end
end)

AddEventHandler('esx_addonaccount:removeMoney', function(identifier, amount)
    if string.find(identifier, "society_") then
        exports.pefcl:removeBankBalanceByIdentifier(0, {
            amount = amount,
            message = Config.Locale.withdrew,
            identifier = string.gsub(identifier, "society_", "")
        })
    end
end)

AddEventHandler('esx_addonaccount:setMoney', function(identifier, amount)
    if string.find(identifier, "society_") then
        exports.pefcl:setMoneyByIdentifier(0, {
            amount = amount,
            identifier = string.gsub(identifier, "society_", "")
        })
    end
end)

AddEventHandler('esx:setJob', function(playerSrc, job, lastJob)
    local xPlayer = ESX.GetPlayerFromId(playerSrc)

    if not xPlayer then
        return
    end

    updateBusinessAccountAccess(xPlayer, job, lastJob)
    updateSocietyAccountAccess(xPlayer, job, lastJob)
end)

-- EVENTS: PEFCL
AddEventHandler('pefcl:newAccountBalance', function(account)
    syncBankBalance(account)
end)

AddEventHandler('pefcl:changedDefaultAccount', function(account)
    syncBankBalance(account)
end)

