Config = {}

Config.Language = 'en' -- Select your language here. [en / cs]
Config.MenuKey = false -- Configure the default key to open clothing menu (false to disable).
Config.UseRadial = false -- If true the radial menu will be used otherwise the context menu.

Config.EnableCommands = true -- Enable or disable commands for taking off clothes faster.
Config.PlayerWontLoseProps = true -- Should player lose props (hat, glasses) on damage or not?
Config.OutfitRenaming = true -- Should the option to rename outfits be enabled?
Config.ClothingIdDesc = true -- Show ID of the clothing item in item description?
Config.CreatedByDesc = false -- Show name of person that created the item in the description? Requires a framework.

-- █▀▀ █░░ █ █▀█ █▀█ █ █▄░█ █▀▀   █ █▀ █▀ █░█ █▀▀   █▀▀ █ ▀▄▀
-- █▄▄ █▄▄ █ █▀▀ █▀▀ █ █░▀█ █▄█   █ ▄█ ▄█ █▄█ ██▄   █▀░ █ █░█

Config.MaskFix = true -- Fix face clipping through certain masks?
Config.MaskFilter = { -- WIP
    enabled = false, -- Enable mask filter? Only specified masks will be whitelisted / blacklisted.
    blacklist = true, -- If false it will act as a whitelist.
    list = { -- Specify mask IDs for the filter here.
        -- 1, -- example
    }
}

Config.HatFix = true -- Fix hair clipping through certain hats?
Config.HatFilter = { -- WIP
    enabled = false, -- Enable hat filter? Only specified hats will be whitelisted / blacklisted.
    blacklist = true, -- If false it will act as a whitelist.
    list = { -- Specify hat IDs for the filter here.
        -- 1, -- example
    }
}

-- █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ ▄▀█ █░░   █▀▀ █▀▀ ▄▀█ █▀█
-- █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ █▀█ █▄▄   █▄█ ██▄ █▀█ █▀▄

Config.FunctionalGear = {
    enabled = true, -- Enable working NV goggles and other GTA stuff?
    useKey = 'H', -- Configure the default key to use gear.
}

-- ▀█▀ █▀▀ ▄▀█ █▀█ █ █▄░█ █▀▀
-- ░█░ ██▄ █▀█ █▀▄ █ █░▀█ █▄█

Config.TearClothes = false -- Enable tearing clothes? Will give an item if successful.
Config.TearMinigameSettings = { enabled = false, keys = {'E'}, difficulty = {'easy'} } -- Enable minigame when tearing clothes? You can add multiple keys and difficulties.
Config.Tearing = {
    ['outfit'] = {give = 'cloth', amount = 3, duration = 5000}, -- "give" = item to give when successful / "amount" = specifies the quantity player receives / "duration" = indicates the duration of the process
    ['torso'] = {give = 'cloth', amount = 2, duration = 5000},
    ['clothes'] = {give = 'cloth', amount = 1, duration = 5000},
}

-- █▀▄▀█ █▀▀ █▄░█ █░█
-- █░▀░█ ██▄ █░▀█ █▄█

Config.Menu = {
    outfit = true, -- "Take off outfit" button.
    outfitOther = true, -- "Take off player outfit" button.

    clothes = { -- Clothing category
        enabled = true, -- Enable or disable category.
        options = { -- You can toggle individual buttons here.
            [1] = { -- mask
                title = 'take_off_mask',
                icon = 'masks-theater'
            },
            [3] = { -- gloves
                title = 'take_off_gloves',
                icon = 'mitten'
            },
            [4] = { -- pants
                title = 'take_off_pants',
                icon = 'socks'
            },
            [5] = { -- Will not work if Config.AutomaticBackpack is enabled.
                title = 'take_off_backpack',
                icon = 'briefcase'
            },
            [6] = { -- shoes
                title = 'take_off_shoes',
                icon = 'shoe-prints'
            },
            [7] = { -- accessory
                title = 'take_off_chain',
                icon = 'ring'
            },
            [8] = { -- top
                title = 'take_off_top',
                icon = 'shirt'
            },
            [9] = { -- vest
                title = 'take_off_vest',
                icon = 'vest'
            },
            [10] = { -- decals
                title = 'take_off_badges',
                icon = 'id-badge'
            },
        }
    },

    props = { -- Prop category (accessories)
        enabled = true, -- Enable or disable category.
        options = { -- You can toggle individual buttons here.
            [0] = { -- hat
                title = 'take_off_hat',
                icon = 'hat-cowboy'
            },
            [1] = { -- glasses
                title = 'take_off_glasses',
                icon = 'glasses'
            },
            [2] = { -- ear accessory
                title = 'take_off_earrings',
                icon = 'ear-deaf'
            },
        }
    }
}

-- ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█ █▀
-- █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█ ▄█

Config.Animations = { -- You can configure your animations for taking off clothes.
    take_off = {
        [1] = { dict = "missfbi4", clip = "takeoff_mask", flag = 51, duration = 1200 }, -- Mask
        [3] = { dict = "nmt_3_rcm-10", clip = "cs_nigel_dual-10", flag = 51, duration = 1200 }, -- Gloves
        [4] = { dict = "re@construction", clip = "out_of_breath", flag = 51, duration = 1300 }, -- Pants
        [5] = { dict = "clothingshirt", clip = "try_shirt_positive_d", flag = 51, duration = 1200 }, -- Bag
        [6] = { dict = "random@domestic", clip = "pickup_low", flag = 51, duration = 1200 }, -- Shoes
        [7] = { dict = "clothingshirt", clip = "try_shirt_positive_d", flag = 51, duration = 1200 }, -- Accessory
        [8] = { dict = "clothingshirt", clip = "try_shirt_positive_d", flag = 51, duration = 1200 }, -- Shirt
        [9] = { dict = "clothingshirt", clip = "try_shirt_positive_d", flag = 51, duration = 1200 }, -- Vest
        [10] = { dict = "clothingshirt", clip = "try_shirt_positive_d", flag = 51, duration = 1200 } -- Decals
    },
    put_on = {
        [1] = { dict = "mp_masks@on_foot", clip = "put_on_mask", flag = 51, duration = 600 }, -- Mask
        [3] = { dict = "nmt_3_rcm-10", clip = "cs_nigel_dual-10", flag = 51, duration = 1200 }, -- Gloves
        [4] = { dict = "re@construction", clip = "out_of_breath", flag = 51, duration = 1300 }, -- Pants
        [5] = { dict = "clothingshirt", clip = "try_shirt_positive_d", flag = 51, duration = 1200 }, -- Bag
        [6] = { dict = "random@domestic", clip = "pickup_low", flag = 51, duration = 1200 }, -- Shoes
        [7] = { dict = "clothingshirt", clip = "try_shirt_positive_d", flag = 15, duration = 1200 }, -- Accessory
        [8] = { dict = "clothingshirt", clip = "try_shirt_positive_d", flag = 51, duration = 1200 }, -- Shirt
        [9] = { dict = "clothingshirt", clip = "try_shirt_positive_d", flag = 51, duration = 1200 }, -- Vest
        [10] = { dict = "clothingshirt", clip = "try_shirt_positive_d", flag = 51, duration = 1200 } -- Decals
    }
}

Config.PropAnimations = { -- You can configure your animations for taking off props.
    take_off = {
        [0] = { dict = "missheist_agency2ahelmet", clip = "take_off_helmet_stand", flag = 51, duration = 600 }, -- Hat
        [1] = { dict = "clothingspecs", clip = "take_off", flag = 51, duration = 1400 }, -- Glasses
        [2] = { dict = "mp_cp_stolen_tut", clip = "b_think", flag = 51, duration = 900 } -- Ear accessories
    },
    put_on = {
        [0] = { dict = "veh@common@fp_helmet@", clip = "put_on_helmet", flag = 51, duration = 2000 }, -- Hat
        [1] = { dict = "clothingspecs", clip = "take_off", flag = 51, duration = 1400 }, -- Glasses
        [2] = { dict = "mp_cp_stolen_tut", clip = "b_think", flag = 51, duration = 900 } -- Ear accessories
    }
}

-- █▀▄ █▀▀ █▀▀ ▄▀█ █░█ █░░ ▀█▀   █▀▀ █░░ █▀█ ▀█▀ █░█ █▀▀ █▀
-- █▄▀ ██▄ █▀░ █▀█ █▄█ █▄▄ ░█░   █▄▄ █▄▄ █▄█ ░█░ █▀█ ██▄ ▄█

-- Configure your default player clothes for both genders (with these clothes player will be considered as naked).
Config.DefaultPlayerClothes = {
    Male = {
        Components = {
            [1] = { index = 1, drawable = 0, texture = 0 }, -- Mask
            [3] = { index = 3, drawable = 15, texture = 0 }, -- Gloves
            [4] = { index = 4, drawable = 26, texture = 0 }, -- Pants
            [5] = { index = 5, drawable = 0, texture = 0 }, -- Bag
            [6] = { index = 6, drawable = 78, texture = 0 }, -- Shoes
            [7] = { index = 7, drawable = 0, texture = 0 }, -- Accessory
            [8] = { index = 8, drawable = 15, texture = 0 }, -- Shirt
            [9] = { index = 9, drawable = 0, texture = 0 }, -- Vest
            [10] = { index = 10, drawable = 0, texture = 0 }, -- Decals
            [11] = { index = 11, drawable = 15, texture = 0 } -- Jacket
        },
        Props = {
            [0] = { index = 1, drawable = -1, texture = -1 }, -- Hat
            [1] = { index = 2, drawable = -1, texture = -1 }, -- Glasses
            [2] = { index = 3, drawable = -1, texture = -1 } -- Ear accessory
        }
    },
    Female = {
        Components = {
            [1] = { index = 1, drawable = 0, texture = 0 }, -- Mask
            [3] = { index = 3, drawable = 15, texture = 0 }, -- Gloves
            [4] = { index = 4, drawable = 15, texture = 0 }, -- Pants
            [5] = { index = 5, drawable = 0, texture = 0 }, -- Bag
            [6] = { index = 6, drawable = 91, texture = 0 }, -- Shoes
            [7] = { index = 7, drawable = 0, texture = 0 }, -- Accessory
            [8] = { index = 8, drawable = 14, texture = 0 }, -- Shirt
            [9] = { index = 9, drawable = 0, texture = 0 }, -- Vest
            [10] = { index = 10, drawable = 0, texture = 0 }, -- Decals
            [11] = { index = 11, drawable = 17, texture = 0 } -- Jacket
        },
        Props = {
            [0] = { index = 1, drawable = -1, texture = -1 }, -- Hat
            [1] = { index = 2, drawable = -1, texture = -1 }, -- Glasses
            [2] = { index = 3, drawable = -1, texture = -1 } -- Ear accessory
        }
    }
}

-- █▄▄ ▄▀█ █▀▀ █▄▀ █▀█ ▄▀█ █▀▀ █▄▀ █▀
-- █▄█ █▀█ █▄▄ █░█ █▀▀ █▀█ █▄▄ █░█ ▄█

-- If enabled, if player has the items configured below they will be visually shown as a piece of clothing on the character (button for taking off bags will be disabled).
-- If disabled, backpacks will work like any other clothing item (button for taking off bags will be enabled).

Config.AutomaticBackpack = false
Config.Backpacks = {
    [3] = { -- The number is the backpack priority (if player has item 1 and item 2 then item 1 will be always shown).
        item = 'large_backpack', -- Item name of your backpack.
        drawable = 66, -- Drawable ID of the backpack.
        texture = 0 -- Texture ID of the backpack.
    },
    [2] = {
        item = 'medium_backpack',
        drawable = 65,
        texture = 0
    },
    [1] = {
        item = 'small_backpack',
        drawable = 67,
        texture = 0
    },
}

-- █▄░█ █▀█ ▀█▀ █ █▀▀ █▄█
-- █░▀█ █▄█ ░█░ █ █▀░ ░█░

-- You can edit the notifications here.
function notify(text, type)
    lib.notify({
        title = 'CLOTHING',
        description = text,
        type = type
    })
end

-- █▀ █▀█ █▀▀ █▀▀ █ ▄▀█ █░░   █▀█ █░█ ▀█▀ █▀▀ █ ▀█▀ █▀
-- ▄█ █▀▀ ██▄ █▄▄ █ █▀█ █▄▄   █▄█ █▄█ ░█░ █▀░ █ ░█░ ▄█

-- This section allows you to configure specific outfits to have "special effects".
-- For example: You can make fireman uniform fire proof.
-- If you have the effect script it will be automatically available to be used with these outfits to show them visually.

Config.EnableSpecialOutfits = false -- Should special outfits be enabled or disabled?
Config.MarkUnnamedOutfits = false -- Should these outfits be marked by default? Can prevent players from faking outfits by renaming them.
Config.MarkText = '⭐'

-- WIP --------------------------------------------------------
Config.UseOutfitEffects = false -- Requires the effects script.
-- You can find it here: https://github.com/LikeManTV/effects
-- WIP --------------------------------------------------------

Config.SpecialOutfits = {
    -- ['example'] = {
    --     label = 'Example Outfit',
    --     outfitEffect = 'outfit',
    --     proofs = {
    --         false, -- BULLET
    --         false, -- FIRE
    --         false, -- EXPLOSION
    --         false, -- COLLISION
    --         false, -- MELEE
    --         false, -- STEAM
    --         false,
    --         false -- DROWNING
    --     },
    --     Male = {
    --         comps = {
    --             [1] = {d = 0, t = 0}, -- Mask
    --             [3] = {d = 0, t = 0}, -- Gloves
    --             [4] = {d = 0, t = 0}, -- Pants
    --             [6] = {d = 0, t = 0}, -- Shoes
    --             [7] = {d = 0, t = 0}, -- Accessory
    --             [8] = {d = 0, t = 0}, -- Shirt
    --             [9] = {d = 0, t = 0}, -- Vest
    --             [10] = {d = 0, t = 0}, -- Decals
    --             [11] = {d = 0, t = 0}, -- Jacket
    --         },
    --         props = {
    --             [0] = {d = 0, t = 0}, -- Hat
    --             [1] = {d = 0, t = 0}, -- Glassses
    --             [2] = {d = 0, t = 0}, -- Ear accessory
    --         }
    --     },
    --     Female = {
    --         comps = {
    --             [1] = {d = 0, t = 0}, -- Mask
    --             [3] = {d = 0, t = 0}, -- Gloves
    --             [4] = {d = 0, t = 0}, -- Pants
    --             [6] = {d = 0, t = 0}, -- Shoes
    --             [7] = {d = 0, t = 0}, -- Accessory
    --             [8] = {d = 0, t = 0}, -- Shirt
    --             [9] = {d = 0, t = 0}, -- Vest
    --             [10] = {d = 0, t = 0}, -- Decals
    --             [11] = {d = 0, t = 0}, -- Jacket
    --         },
    --         props = {
    --             [0] = {d = 0, t = 0}, -- Hat
    --             [1] = {d = 0, t = 0}, -- Glassses
    --             [2] = {d = 0, t = 0}, -- Ear accessory
    --         }
    --     }
    -- },
}
