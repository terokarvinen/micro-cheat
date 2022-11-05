-- micro-cheat copyright 2022 Tero Karvinen https://TeroKarvinen.com

-- Cheatsheets are copyrighted by their original authors

-- Cheatsheets from Devhints.io are copyright 2021 
-- Rico Sta. Cruz and contributors, received under the MIT license

local micro = import("micro")
local config = import("micro/config")

local cheatdir = config.ConfigDir.."/plug/micro-cheat/cheatsheets/"

function init()
	-- runs once when micro starts
	config.MakeCommand("cheat", cheatCommand, config.NoComplete)
	config.TryBindKey("F1", "command:cheat", false)
end

function cheatCommand(bp)
	local cmd = "tab " .. cheatdir .. bp.Buf:FileType() .. ".md"
	micro.InfoBar():Message(cmd)
	bp:HandleCommand(cmd)
end
