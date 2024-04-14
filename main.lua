-- micro-cheat copyright 2022 Tero Karvinen https://TeroKarvinen.com

-- Cheatsheets are copyrighted by their original authors

-- Cheatsheets from Devhints.io are copyright 2021 
-- Rico Sta. Cruz and contributors, received under the MIT license

local micro = import("micro")
local config = import("micro/config")
local os = import("os")

local cheatdir = config.ConfigDir.."/plug/micro-cheat/cheatsheets/"

function getSuffix(filename)
	-- return last suffix without dot. Example: "tero.foo.bar.sass" -> "sass"
	return filename:match("%.(%w+)$")
end

function fileExists(filename)
	-- return true if "filename" exists
	local _, err = os.Stat(filename)
	return not err
end
	
function init()
	-- runs once when micro starts
	config.MakeCommand("cheat", cheatCommand, config.NoComplete)
	config.TryBindKey("F1", "command:cheat", false)
end

function cheatCommand(bp)
	local filename = bp.Buf:GetName()
	local filetype = bp.Buf:FileType()
	local filesuffix = getSuffix(filename)

	if "Vagrantfile" == filename or "Dockerfile" == filename then
		filetype = filename:lower()
		micro.InfoBar():Message("Cheatsheet by file name: "..filename)
-- Disabled org-mode support, because literal dot (backslash dot) escape causes error
-- in the micro shipped by latest Kali
--	elseif string.find(filename, "\.org$") then -- not detected by micro
--		filetype = "org"
--		micro.InfoBar():Message("Cheatsheet by file suffix: "..filename)
	elseif "unknown" ~= filetype then
		-- micro hopefully detected the filetype, the typical case
		micro.InfoBar():Message("Cheatsheet by file type: "..filetype)
	elseif nil ~= filesuffix then
		filetype = filesuffix
		micro.InfoBar():Message("Cheatsheet by file suffix: "..filetype)
	--else
	--	micro.InfoBar():Message("Cheatsheet not found for type '"..filetype.."', filename '"..filename.."'")
	--	return
	end

	local cheatsheet = cheatdir .. filetype .. ".md"

	if not fileExists(cheatsheet) then
		micro.InfoBar():Message("Cheatsheet for \""..filetype.."\" does not exist. Contribute to https://github.com/terokarvinen/micro-cheat")
	end
	
	-- local cmd = "tab " .. cheatdir .. filetype .. ".md"
	local cmd = "tab " .. cheatsheet
	bp:HandleCommand(cmd)
	
	-- bp:HandleCommand("setlocal readonly true") -- user changes would be overwritten my micro-cheat updates

end
