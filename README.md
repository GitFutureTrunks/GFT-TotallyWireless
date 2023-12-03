# GFT-TotallyWireless
# Script for QB-Core

# About
- This is a simply IT job that allows you to repair computers around your city!
- With a very simple config to add locations
- Optimized at 0.00ms

# Required
- Add items to items.lua
  	-- TW Job
	['tw_toolbox'] 				= {['name'] = 'tw_toolbox', 			['label'] = 'Toolbox',	            			['weight'] = 8000,     ['type'] = 'item',      ['image'] = 'tw_toolbox.png',         ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['tw_monitor'] 				= {['name'] = 'tw_monitor', 			['label'] = 'Monitor',	            			['weight'] = 5000,     ['type'] = 'item',      ['image'] = 'tw_monitor.png',         ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['tw_cpu'] 					= {['name'] = 'tw_cpu', 				['label'] = 'CPU',		            			['weight'] = 100,      ['type'] = 'item',      ['image'] = 'tw_cpu.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['tw_graphiccard'] 			= {['name'] = 'tw_graphiccard', 		['label'] = 'Graphic Card',            			['weight'] = 1000,     ['type'] = 'item',      ['image'] = 'tw_graphiccard.png',     ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},
	['tw_ssd'] 					= {['name'] = 'tw_ssd', 				['label'] = '1TB SSD',            				['weight'] = 1000,     ['type'] = 'item',      ['image'] = 'tw_ssd.png',         	['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ''},

- Add to your qb-shops/config.lua
  		["totallywireless"] = {
			{ name = 'tw_toolbox', price = 1, amount = 10, requiredJob = { ["twit"] = 0} },
			{ name = 'tw_monitor', price = 1, amount = 10, requiredJob = { ["twit"] = 0} },
			{ name = 'tw_cpu', price = 1, amount = 10, requiredJob = { ["twit"] = 0} },
			{ name = 'tw_graphiccard', price = 1, amount = 10, requiredJob = { ["twit"] = 0} },
			{ name = 'tw_ssd', price = 1, amount = 10, requiredJob = { ["twit"] = 0} },
		},

- Add job to jobs.lua
  	["twit"] = {
		label = "Totally Wireless IT",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = { name = "Information Technology", payment = 0 },
        },
	},

- Add job to qb-cityhall/server/main.lua Note: Just add to your already existing list
  local availableJobs = {
    ["twit"] = "Totally Wireless",
}

# Once you have done all the above step go into the config and start adding locations!!
