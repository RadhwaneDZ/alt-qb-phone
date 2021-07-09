Config = Config or {}

Config.RepeatTimeout = 2000
Config.CallRepeats = 10
Config.PhoneApplications = {
    ["phone"] = {
        app = "phone",
        color = "#04b543",
        icon = "fa fa-phone-alt",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 1,
        Alerts = 0,
    },
    ["whatsapp"] = {
        app = "whatsapp",
        color = "#25d366",
        icon = "fab fa-whatsapp",
        tooltipPos = "top",
        style = "font-size: 2.8vh";
        job = false,
        blockedjobs = {},
        slot = 2,
        Alerts = 0,
    },
    ["settings"] = {
        app = "settings",
        color = "#636e72",
        icon = "fa fa-cog",
        tooltipPos = "top",
        style = "padding-right: .08vh; font-size: 2.3vh";
        job = false,
        blockedjobs = {},
        slot = 3,
        Alerts = 0,
    },
    ["twitter"] = {
        app = "twitter",
        color = "#1da1f2",
        icon = "fab fa-twitter",
        job = false,
        blockedjobs = {},
        slot = 6,
        Alerts = 0,
    },
    ["garage"] = {
        app = "garage",
        color = "#b30000",
        icon = "fas fa-warehouse",
        job = false,
        blockedjobs = {},
        slot = 5,
        Alerts = 0,
    },
    ["mail"] = {
        app = "mail",
        color = "#ff002f",
        icon = "fas fa-envelope",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 4,
        Alerts = 0,
    },
    ["advert"] = {
        app = "advert",
        color = "#ff8f1a",
        icon = "fas fa-ad",
        job = false,
        blockedjobs = {},
        slot = 7,
        Alerts = 0,
    },
    ["bank"] = {
        app = "bank",
        color = "#1f212e",
        icon = "fas fa-university",
        job = false,
        blockedjobs = {},
        slot = 8,
        Alerts = 0,
    },

    ["racing"] = {
        app = "racing",
        color = "#353b48",
        icon = "fas fa-flag-checkered",
        job = false,
        blockedjobs = {
            "police",
            "ambulance"
        },
        slot = 15,
        Alerts = 0,
    },
    ["houses"] = {
        app = "houses",
        color = "#27ae60",
        icon = "fas fa-home",
        job = false,
        blockedjobs = {},
        slot = 9,
        Alerts = 0,
    },
    ["lawyers"] = {
        app = "lawyers",
        color = "#030b85",
        icon = "fas fa-user-tie",
        job = false,
        blockedjobs = {},
        slot = 10,
        Alerts = 0,
    },
    ["mechanic"] = {
        app = "mechanic",
        color = "#353b48",
        icon = "fas fa-wrench",
        job = false,
        blockedjobs = {},
        slot = 11,
        Alerts = 0,
    },
    ["drivers"] = {
        app = "drivers",
        color = "#f4d219",
        icon = "fas fa-taxi",
        job = false,
        blockedjobs = {},
        slot = 12,
        Alerts = 0,
    },  
    ["sellix"] = {
        app = "sellix",
        color = "‎#1d00a0",
        icon = "fas fa-book-dead",
        style = "padding-right: .3vh; font-size: 2vh";
        job = false,
        blockedjobs = {
            "police",
            "ambulance"
        },
        slot = 16,
        Alerts = 0,
    },
    ["meos"] = {
        app = "meos",
        color = "#020144",
        icon = "fas fa-ad",
        job = "police",
        blockedjobs = {},
        slot = 20,
        Alerts = 0,
    },
    ["spotify"] = {
        app = "spotify",
        color = "#82c91e",
        icon = "fas fa-compact-disc",
        job = false,
        blockedjobs = {},
        slot = 13,
        Alerts = 0,
    },
    ["snake"] = {
        app = "snake",
        color = "#609",
        icon = "fas fa-ghost",
        job = false,
        blockedjobs = {},
        slot = 14,
        Alerts = 0,
    },
        --  ["rentel"] = {
    --     app = "rentel",
    --     color = "‎#ee82ee",
    --     icon = "fas fa-biking",
    --     tooltipText = "Rental",
    --     style = "padding-right: .3vh; font-size: 2vh";
    --     job = false,
    --     blockedjobs = {},
    --     slot = 17,
    --     Alerts = 0,
    -- },
    --[[
    ["store"] = {
        app = "store",
        color = "#27ae60",
        icon = "fas fa-cart-arrow-down",
        tooltipText = "App Store",
        style = "padding-right: .3vh; font-size: 2.2vh";
        job = false,
        blockedjobs = {},
        slot = 14,
        Alerts = 0,
    },
    
    ["rental"] = {
        app = "lsrental",
        color = "#27ae60",
        icon = "fas fa-cart-arrow-down",
        tooltipText = "Rental",
        style = "padding-right: .3vh; font-size: 2vh";
        job = false,
        blockedjobs = {},
        slot = 12,
        Alerts = 0,
    },]]
    -- ["trucker"] = {
    --     app = "trucker",
    --     color = "#cccc33",
    --     icon = "fas fa-truck-moving",
    --     tooltipText = "Dumbo",
    --     job = false,
    --     blockedjobs = {},
    --     slot = 17,
    --     Alerts = 0,
    -- },
}
Config.MaxSlots = 20

Config.StoreApps = {
    ["territory"] = {
        app = "territory",
        color = "#353b48",
        icon = "fas fa-globe-europe",
        tooltipText = "territory",
        style = "";
        job = false,
        blockedjobs = {},
        slot = 15,
        Alerts = 0,
        password = true,
        creator = "Qbus",
        title = "Territory",
    },
}

Config.RentelVehicles = {
	['tribike3'] = { ['model'] = 'tribike3', ['label'] = 'Tribike Blue', ['price'] = 100, ['icon'] = 'fas fa-biking' },
	['bmx'] = { ['model'] = 'bmx', ['label'] = 'BMX', ['price'] = 100, ['icon'] = 'fas fa-biking' },
    --['panto'] = { ['model'] = 'panto', ['label'] = 'Panto', ['price'] = 250, ['icon'] = 'fas fa-car' },
	--['rhapsody'] = { ['model'] = 'rhapsody', ['label'] = 'Rhapsody', ['price'] = 300, ['icon'] = 'fas fa-car' },
	--['felon'] = { ['model'] = 'felon', ['label'] = 'Felon', ['price'] = 400, ['icon'] = 'fas fa-car' },
	--['bagger'] = { ['model'] = 'bagger', ['label'] = 'Bagger', ['price'] = 400, ['icon'] = 'fas fa-motorcycle' },
    --['biff'] = { ['model'] = 'biff', ['label'] = 'Biff', ['price'] = 500, ['icon'] = 'fas fa-truck-moving' },
}

Config.RentelLocations = {
    ['Courthouse Paystation'] = {
        ['coords'] = vector4(129.93887, -898.5326, 30.148599, 166.04177)
    },
    ['Train Station'] = {
        ['coords'] = vector4(-213.4004, -1003.342, 29.144016, 345.36584)
    },
    ['Bus Station'] = {
        ['coords'] = vector4(416.98699, -641.6024, 28.500173, 90.011344)
    },    
    ['Morningwood Blvd'] = {
        ['coords'] = vector4(-1274.631, -419.1656, 34.215377, 209.4456)
    },    
    ['South Rockford Drive'] = {
        ['coords'] = vector4(-682.9262, -1112.928, 14.525076, 37.729667)
    },    
    ['Tinsel Towers Street'] = {
        ['coords'] = vector4(-716.9338, -58.31439, 37.472839, 297.83691)
    },
    ['magazin ul de masini nu e gata'] = {
        ['coords'] = vector4(252.51887, -635.4688, 40.480518, 182.19883)
    }     
}