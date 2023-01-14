TriggerEvent('esx_society:registerSociety', 'ballas', 'Ballas', 'society_ballas', 'society_ballas', 'society_ballas', {type = 'public'})

local stash = {
    id = 'society_ballas',
    label = 'Coffre Ballas',
    slots = 50,
    weight = 100000
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'Xel_Gang_exemple' or resourceName == GetCurrentResourceName() then
        print("stash created successfully")
        exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight)
    end
end)