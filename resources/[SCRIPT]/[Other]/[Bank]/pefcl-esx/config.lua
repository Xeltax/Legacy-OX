Config = {}

-- You should not need BusinessAccounts when using ESX & esx_society
Config.BusinessAccounts = {
    -- ['police'] = { -- Job Name
    --     AccountName = 'Los Santos Police', -- Display name for bank account
    --     ContributorRole = 2, -- Minimum role required to contribute to the account
    --     AdminRole = 3 -- Minumum role to be able to add/remove money from the account
    -- },
    -- ['ambulance'] = { -- Job Name
    --     AccountName = 'Los Santos EMS', -- Display name for bank account
    --     ContributorRole = 2, -- Minimum role required to contribute to the account
    --     AdminRole = 3 -- Minumum role to be able to add/remove money from the account
    -- }
}

--
-- If you have ox_inventory you can enable it here.
-- This will expose the required exports for physical cards.
-- 
-- Make sure to update config.json in "PEFCL" as well to enable physical cards.
--
Config.OxInventory = true

Config.Locale = {
    deposited = "Deposited money into society account",
    withdrew = "Withdrew money from society account"
}
