warn("[GameAnalyzer v3.0 MEGA DEEP] === СКРИПТ ЗАПУЩЕН ===")
if _G.GameAnalyzerPro and _G.GameAnalyzerPro.Unload then
    pcall(_G.GameAnalyzerPro.Unload); task.wait(0.3)
end
_G.GameAnalyzerPro = {}
local rs = game:GetService("RunService")
local ws = game:GetService("Workspace")
local plrs = game:GetService("Players")
local rep = game:GetService("ReplicatedStorage")
local CS = game:GetService("CollectionService")
local Deb = game:GetService("Debris")
local UIS = game:GetService("UserInputService")
local lp = plrs.LocalPlayer
local cam = ws.CurrentCamera
local _hookfn = rawget(getfenv(), "hookfunction")
local _hookmm = rawget(getfenv(), "hookmetamethod")
local _getgc = rawget(getfenv(), "getgc")
local _getreg = rawget(getfenv(), "getreg")
local _getupvalues = rawget(getfenv(), "getupvalues")
local _getupvalue = rawget(getfenv(), "getupvalue")
local _getconstants = rawget(getfenv(), "getconstants")
local _getprotos = rawget(getfenv(), "getprotos")
local _getconn = rawget(getfenv(), "getconnections")
local _setreadonly = rawget(getfenv(), "setreadonly")
local _getrawmt = rawget(getfenv(), "getrawmetatable")
local _newcclosure = rawget(getfenv(), "newcclosure")
local _gethui = rawget(getfenv(), "gethui")
local _identify = rawget(getfenv(), "identifyexecutor")
local _setclipboard = rawget(getfenv(), "setclipboard") or rawget(getfenv(), "toclipboard")
local _fireproximityprompt = rawget(getfenv(), "fireproximityprompt")
local _fireclickdetector = rawget(getfenv(), "fireclickdetector")
local _decompile = rawget(getfenv(), "decompile")
local _getnamecallmethod = rawget(getfenv(), "getnamecallmethod")
local _getinstances = rawget(getfenv(), "getinstances") or rawget(getfenv(), "get_instances")
local _getnilinstances = rawget(getfenv(), "getnilinstances") or rawget(getfenv(), "get_nil_instances")
local _getloadedmodules = rawget(getfenv(), "getloadedmodules") or rawget(getfenv(), "get_loaded_modules")
local _getrunningscripts = rawget(getfenv(), "getrunningscripts") or rawget(getfenv(), "get_running_scripts")
local _getscripts = rawget(getfenv(), "getscripts") or rawget(getfenv(), "get_scripts")
local _getsenv = rawget(getfenv(), "getsenv")
local _getcallingscript = rawget(getfenv(), "getcallingscript")
local _getstack = rawget(getfenv(), "getstack") or (debug and debug.getstack)
local _getinfo = rawget(getfenv(), "getinfo") or (debug and debug.getinfo)
local _getcustomasset = rawget(getfenv(), "getcustomasset") or rawget(getfenv(), "getsynasset")
local _readfile = rawget(getfenv(), "readfile")
local _writefile = rawget(getfenv(), "writefile")
local _appendfile = rawget(getfenv(), "appendfile")
local _makefolder = rawget(getfenv(), "makefolder")
local _listfiles = rawget(getfenv(), "listfiles")
local _isfile = rawget(getfenv(), "isfile")
local _isfolder = rawget(getfenv(), "isfolder")
local _httprequest = rawget(getfenv(), "request") or rawget(getfenv(), "http_request") or (syn and syn.request)
local _protectgui = rawget(getfenv(), "protect_gui") or rawget(getfenv(), "protectgui")
local _cloneref = rawget(getfenv(), "cloneref") or function(x) return x end
local _getthreadidentity = rawget(getfenv(), "getthreadidentity") or rawget(getfenv(), "getidentity")
local _setthreadidentity = rawget(getfenv(), "setthreadidentity") or rawget(getfenv(), "setidentity")
hookfunction = _hookfn
hookmetamethod = _hookmm
getgc = _getgc
getreg = _getreg
getupvalues = _getupvalues
getupvalue = _getupvalue
getconstants = _getconstants
getprotos = _getprotos
getconnections = _getconn
setreadonly = _setreadonly
getrawmetatable = _getrawmt
newcclosure = _newcclosure
gethui = _gethui
fireproximityprompt = _fireproximityprompt
fireclickdetector = _fireclickdetector
setclipboard = _setclipboard
decompile = _decompile
getnamecallmethod = _getnamecallmethod
getinstances = _getinstances
getnilinstances = _getnilinstances
getloadedmodules = _getloadedmodules
getrunningscripts = _getrunningscripts
getscripts = _getscripts
getsenv = _getsenv
getcallingscript = _getcallingscript
readfile = _readfile
writefile = _writefile
appendfile = _appendfile
makefolder = _makefolder
listfiles = _listfiles
isfile = _isfile
isfolder = _isfolder
local Settings = {
    SilentMode = false,
    AutoScan = true,
    ScanInterval = 60,
    RemoteSpy = false,
    DeepAccess = true,
    ClipboardEnabled = _setclipboard ~= nil,
    SpyMaxCalls = 200,
}
local DeepData = {
    CombatRemotes = {}, DamageRemotes = {}, WeaponRemotes = {}, BossRemotes = {},
    AbilityRemotes = {}, UnknownRemotes = {}, MoneyRemotes = {}, AdminRemotes = {},
    HealRemotes = {}, TeleportRemotes = {}, ChatRemotes = {}, SpawnRemotes = {},
    KillRemotes = {}, GodRemotes = {}, DeleteRemotes = {}, ExecuteRemotes = {},
    NoclipRemotes = {}, SpeedRemotes = {},
    ShopRemotes = {}, InventoryRemotes = {}, QuestRemotes = {}, TradeRemotes = {},
    PetRemotes = {}, VehicleRemotes = {}, BuildRemotes = {}, ClaimRemotes = {},
    UpgradeRemotes = {}, RollRemotes = {}, LotteryRemotes = {},
    DataStoreRemotes = {}, InternalRemotes = {}, SessionRemotes = {},
    Bindables = {}, Tools = {}, BossModels = {}, NPCs = {}, HiddenModels = {},
    CombatPrompts = {}, ClickDetectors = {},
    AnticheatScripts = {}, AnticheatRemotes = {}, SuspiciousScripts = {},
    GCRemotesFound = {}, GCFunctionsFound = {}, UpvalueRemotes = {},
    RegistryFindings = {}, ConstantsFound = {},
    HighValueRemotes = {}, ExploitList = {},
    SpiedCalls = {}, CallSignatures = {},
    ScriptSources = {}, DecompiledScripts = {},
    LocalModules = {}, ObfuscatedRemotes = {},
    ProtectedInstances = {}, NilParentObjects = {},
    AnticheatType = "Unknown",
    ScanTime = 0, ScanCount = 0,
    GameId = 0, PlaceId = 0, GameName = "?",
    -- v3 MEGA DEEP additions
    AllInstances = {}, NilInstances = {}, LoadedModules = {}, RunningScripts = {},
    AllRemotesEver = {}, RemoteConnections = {},
    DiscoveredKeys = {}, DiscoveredURLs = {}, DiscoveredWebhooks = {}, DiscoveredIDs = {},
    DiscoveredPasswords = {}, DiscoveredTokens = {}, DiscoveredHashes = {},
    AllScriptSources = {}, ModuleReturns = {}, ClosureDump = {},
    ProtoScan = {}, DeepConstantDump = {}, UpvalueDump = {},
    ActorScripts = {}, ClientContextScripts = {}, ObfuscatedScriptSources = {},
    AdminList = {}, DevProductIDs = {}, GamepassIDs = {}, AssetIDs = {},
    LocalPlayerData = {}, LeaderstatsSchema = {}, DataStoreNames = {},
    SecretsInStorage = {}, RemoteInvokers = {}, EventFireStats = {},
    BindableEvents = {}, BindableFunctions = {}, GlobalTable = {},
    NetworkOwners = {}, TeamsInfo = {},
    ReportChunks = {}, ReportChunkIndex = 1,
    MegaScanStats = {},
}
local connections = {}
local _origWarn = warn
local _origPrint = print
warn = function(...)
    if Settings.SilentMode then return end
    return _origWarn(...)
end
print = function(...)
    if Settings.SilentMode then return end
    return _origPrint(...)
end
local function safeLower(s) return (type(s)=="string") and string.lower(s) or "" end
local function matchAny(str, list)
    for _, kw in ipairs(list) do if str:find(kw, 1, true) then return true end end
    return false
end
local function safeInsert(list, item)
    if not table.find(list, item) then table.insert(list, item); return true end
    return false
end
local function argToString(v, depth)
    depth = depth or 0
    if depth > 3 then return "<deep>" end
    local t = typeof(v)
    if t == "nil" then return "nil"
    elseif t == "boolean" then return tostring(v)
    elseif t == "number" then return tostring(v)
    elseif t == "string" then return '"' .. v:sub(1, 60) .. '"'
    elseif t == "Instance" then return v.ClassName .. "(" .. v:GetFullName() .. ")"
    elseif t == "Vector3" then return "Vector3(" .. math.floor(v.X) .. "," .. math.floor(v.Y) .. "," .. math.floor(v.Z) .. ")"
    elseif t == "CFrame" then return "CFrame(" .. math.floor(v.X) .. "," .. math.floor(v.Y) .. "," .. math.floor(v.Z) .. ")"
    elseif t == "Color3" then return "Color3"
    elseif t == "UDim2" then return "UDim2"
    elseif t == "table" then
        local n = 0; local parts = {}
        for k, val in pairs(v) do
            n = n + 1
            if n > 6 then table.insert(parts, "..."); break end
            table.insert(parts, tostring(k) .. "=" .. argToString(val, depth + 1))
        end
        return "{" .. table.concat(parts, ", ") .. "}"
    else return "<" .. t .. ">" end
end
local function argsToString(args)
    if not args or #args == 0 then return "()" end
    local parts = {}
    for _, a in ipairs(args) do table.insert(parts, argToString(a, 0)) end
    return "(" .. table.concat(parts, ", ") .. ")"
end
local KEYWORDS = {
    combat = {"attack","damage","hit","combat","kill","strike","swing","slash","shoot","fire","cast","skill","ability","weapon","hurt","assault","punch","stab","pierce","slay","fight","execute","harm","wound","deal","apply"},
    damage = {"damage","dealdamage","takedamage","dmg","hurt","inflict","harm","apply","reduce","deduct","subtract"},
    boss = {"boss","raid","dungeon","miniboss","elite","warlord","captain","overlord","titan","lord","chief","king","queen","commander","general"},
    honey = {"ban","kick","anticheat","ac_","log","report","detect","security","flag","suspicious","validate","verif","sanity","protect","moderat","punish","suspend","warn"},
    weapon = {"weapon","sword","gun","blade","axe","bow","staff","spear","hammer","knife","dagger","katana","tool","equip"},
    bindable = {"die","dead","kill","damage","death","defeat","expire","perish","destroy","despawn","died","killed"},
    ability = {"ability","skill","cast","spell","power","special","ultimate","move","technique","use","activate","trigger","proc"},
    money = {"money","cash","coin","gold","gem","credit","currency","give","reward","bux","robux","dollar","balance","wallet","bank","pay","purchase","buy","earn","claim","collect","stipend","daily"},
    admin = {"admin","staff","developer","dev","owner","gm","gamemaster","moderator","cmd","command","console","kohl","adonis","hd","basic","kohls"},
    heal = {"heal","regen","restore","cure","revive","respawn","resurrect","medic","recover","refresh","fill","top"},
    teleport = {"teleport","tp","bring","goto","warp","travel","port","spawnat"},
    chat = {"chat","message","say","talk","announce","speak","broadcast","whisper","tell"},
    spawn = {"spawn","summon","create","instantiate","make","give","grant","generate"},
    god = {"god","invulnerable","immortal","immune","invincible","shield","forcefield","protect","invin"},
    delete = {"delete","destroy","wipe","clearall","remove","clear","despawn","erase"},
    execute = {"execute","runcode","dostring","loadcode","loadstring","evalstring","runscript","injector","invoke","runcmd"},
    kick = {"kick","ban","punish","report","suspend","moderat","boot"},
    noclip = {"noclip","phase","collide","ghost","passthrough","nocollide"},
    speed = {"speed","walkspeed","velocity","fast","boost","dash","run","sprint"},
    shop = {"shop","store","market","buy","sell","purchase","merchant","vendor","gambling"},
    inventory = {"inventory","backpack","item","slot","equip","unequip","stash"},
    quest = {"quest","mission","task","objective","completeq","claimq","turnin"},
    trade = {"trade","give","request","accept","gift"},
    pet = {"pet","mount","companion","summon","hatch","egg","fuse"},
    vehicle = {"vehicle","car","bike","boat","plane","drive","ride"},
    build = {"build","place","construct","block","brick","furniture"},
    claim = {"claim","reclaim","own","occupy","territory"},
    upgrade = {"upgrade","level","enhance","rank","promote","evolve","ascend"},
    roll = {"roll","spin","gacha","summon","draw","open","unbox"},
    lottery = {"lottery","raffle","draw","chance","luck","wheel"},
    datastore = {"datastore","save","load","persist","cache","store","backup"},
    session = {"session","login","auth","token","key","verify","validate"},
    kill_all = {"killall","wipeall","clearall","tpsall","masskill","murderall"},
    instant = {"instakill","onehit","oneshot","execute","finish","assassinate","instantkill"},
    critical_effect = {"deletemap","wipemap","cleargame","resetserver","shutdownserver","kickall","banall","destroyall","nukeserver"},
    backdoor = {"backdoor","admin","execute","runstring","dostring","cmd","command","exploit","hook","bypass","superuser","dev","test","debug"},
}
local function scoreVuln(nm, fnm)
    local s = 0
    local fullPath = nm .. "|" .. fnm
    if matchAny(nm, KEYWORDS.critical_effect) then s = s + 200 end
    if matchAny(nm, KEYWORDS.backdoor) then s = s + 100 end
    if matchAny(nm, KEYWORDS.instant) then s = s + 80 end
    if matchAny(nm, KEYWORDS.execute) then s = s + 100 end
    if matchAny(nm, KEYWORDS.admin) then s = s + 60 end
    if matchAny(nm, KEYWORDS.money) then s = s + 50 end
    if matchAny(nm, KEYWORDS.kill_all) then s = s + 80 end
    if matchAny(nm, KEYWORDS.god) then s = s + 45 end
    if matchAny(nm, KEYWORDS.delete) then s = s + 40 end
    if matchAny(nm, KEYWORDS.damage) then s = s + 30 end
    if matchAny(nm, KEYWORDS.teleport) then s = s + 25 end
    if matchAny(nm, KEYWORDS.upgrade) then s = s + 20 end
    if matchAny(nm, KEYWORDS.roll) then s = s + 20 end
    if matchAny(nm, KEYWORDS.spawn) then s = s + 20 end
    if matchAny(nm, KEYWORDS.combat) then s = s + 15 end
    if matchAny(nm, KEYWORDS.shop) then s = s + 15 end
    if matchAny(nm, KEYWORDS.ability) then s = s + 10 end
    if nm:find("client") then s = s - 30 end
    if nm:find("server") then s = s + 15 end
    if nm:find("^_") or nm:find("__") then s = s + 25 end
    if #nm >= 20 or nm:find("[^%w%s_]") then s = s + 30 end
    if matchAny(fullPath, KEYWORDS.honey) then s = -1000 end
    return s
end
local function classifyExploit(rem)
    local nm = safeLower(rem.Name)
    local fnm = rem.Parent and safeLower(rem.Parent.Name) or ""
    local fullPath = nm .. "|" .. fnm
    local effect = "UNKNOWN"
    local effectIcon = "❓"
    local risk = "MEDIUM"
    local suggestedArgs = { {rem}, {lp}, {lp.Name} }
    local category = "misc"
    if matchAny(nm, KEYWORDS.critical_effect) then
        if nm:find("map") or nm:find("world") then effect = "DELETE MAP"; effectIcon = "🗺️"; risk = "CRITICAL"
        elseif nm:find("killall") or nm:find("wipeall") then effect = "KILL ALL PLAYERS"; effectIcon = "💀"; risk = "CRITICAL"
        elseif nm:find("shutdown") or nm:find("reset") then effect = "SHUTDOWN SERVER"; effectIcon = "🔌"; risk = "CRITICAL"
        else effect = "MASS EFFECT"; effectIcon = "☢️"; risk = "CRITICAL" end
        suggestedArgs = { {}, {"all"}, {ws} }
        category = "critical"
    elseif matchAny(nm, KEYWORDS.backdoor) and (nm:find("dev") or nm:find("debug") or nm:find("test") or nm:find("bypass")) then
        effect = "SUSPECTED BACKDOOR"; effectIcon = "🚪"; risk = "CRITICAL"
        suggestedArgs = { {"print('bd')"}, {}, {lp} }
        category = "backdoor"
    elseif matchAny(nm, KEYWORDS.money) then
        effect = "GET MONEY/RESOURCE"; effectIcon = "💰"; risk = "HIGH"
        suggestedArgs = { {lp, math.huge}, {math.huge}, {lp.Name, 999999999}, {"give", lp.Name, "money", math.huge} }
        category = "money"
    elseif matchAny(nm, KEYWORDS.upgrade) then
        effect = "UPGRADE / LEVEL"; effectIcon = "⬆️"; risk = "MEDIUM"
        suggestedArgs = { {lp}, {math.huge}, {lp.Name, 999} }
        category = "upgrade"
    elseif matchAny(nm, KEYWORDS.roll) then
        effect = "ROLL / GACHA"; effectIcon = "🎰"; risk = "MEDIUM"
        suggestedArgs = { {}, {lp}, {"legendary"}, {math.huge} }
        category = "roll"
    elseif matchAny(nm, KEYWORDS.shop) then
        effect = "SHOP / PURCHASE"; effectIcon = "🛒"; risk = "MEDIUM"
        suggestedArgs = { {lp}, {"free"}, {0}, {1} }
        category = "shop"
    elseif matchAny(nm, KEYWORDS.pet) then
        effect = "PET / HATCH"; effectIcon = "🐾"; risk = "MEDIUM"
        suggestedArgs = { {}, {"legendary"}, {math.huge} }
        category = "pet"
    elseif matchAny(nm, KEYWORDS.quest) then
        effect = "QUEST COMPLETE"; effectIcon = "📜"; risk = "MEDIUM"
        suggestedArgs = { {lp}, {"all"}, {math.huge} }
        category = "quest"
    elseif matchAny(nm, KEYWORDS.claim) then
        effect = "CLAIM REWARD"; effectIcon = "🎁"; risk = "MEDIUM"
        suggestedArgs = { {}, {lp}, {"daily"} }
        category = "claim"
    elseif matchAny(nm, KEYWORDS.god) then
        effect = "GOD MODE"; effectIcon = "🛡️"; risk = "HIGH"
        suggestedArgs = { {lp, true}, {true}, {lp.Name, true} }
        category = "god"
    elseif matchAny(nm, KEYWORDS.admin) then
        effect = "ADMIN ACCESS"; effectIcon = "👑"; risk = "CRITICAL"
        suggestedArgs = { {lp}, {lp.Name}, {"admin " .. lp.Name} }
        category = "admin"
    elseif matchAny(nm, KEYWORDS.execute) then
        effect = "REMOTE CODE EXEC"; effectIcon = "🚨"; risk = "CRITICAL"
        suggestedArgs = { {"print('exec-test')"}, {"game.Players.LocalPlayer.Name"} }
        category = "execute"
    elseif matchAny(nm, KEYWORDS.teleport) then
        effect = "TELEPORT"; effectIcon = "📍"; risk = "MEDIUM"
        suggestedArgs = { {lp, Vector3.new(0, 50, 0)}, {Vector3.new(0, 50, 0)} }
        category = "teleport"
    elseif matchAny(nm, KEYWORDS.delete) then
        effect = "DELETE OBJECTS"; effectIcon = "🗑️"; risk = "HIGH"
        suggestedArgs = { {}, {"all"} }
        category = "delete"
    elseif matchAny(nm, KEYWORDS.kick) then
        effect = "KICK/BAN OTHERS"; effectIcon = "🚫"; risk = "HIGH"
        suggestedArgs = {}
        for _, p in ipairs(plrs:GetPlayers()) do
            if p ~= lp then table.insert(suggestedArgs, {p}); if #suggestedArgs >= 2 then break end end
        end
        category = "kick"
    elseif matchAny(nm, KEYWORDS.heal) then
        effect = "HEAL/REVIVE"; effectIcon = "💚"; risk = "LOW"
        suggestedArgs = { {lp}, {lp, math.huge} }
        category = "heal"
    elseif matchAny(nm, KEYWORDS.spawn) then
        effect = "SPAWN ITEM"; effectIcon = "✨"; risk = "MEDIUM"
        suggestedArgs = { {lp}, {"Sword"}, {"boss"} }
        category = "spawn"
    elseif matchAny(nm, KEYWORDS.trade) then
        effect = "TRADE / GIFT"; effectIcon = "🎁"; risk = "MEDIUM"
        suggestedArgs = { {lp, math.huge}, {"give"} }
        category = "trade"
    elseif matchAny(nm, KEYWORDS.chat) then
        effect = "CHAT/MESSAGE"; effectIcon = "💬"; risk = "LOW"
        suggestedArgs = { {"HELLO"}, {"/e"} }
        category = "chat"
    elseif matchAny(nm, KEYWORDS.speed) then
        effect = "SPEED"; effectIcon = "💨"; risk = "LOW"
        suggestedArgs = { {lp, 999}, {999} }
        category = "speed"
    elseif matchAny(nm, KEYWORDS.noclip) then
        effect = "NOCLIP"; effectIcon = "👻"; risk = "LOW"
        suggestedArgs = { {lp, false}, {false} }
        category = "noclip"
    elseif matchAny(nm, KEYWORDS.damage) then
        effect = "DAMAGE ENTITY"; effectIcon = "⚔️"; risk = "MEDIUM"
        suggestedArgs = { {math.huge}, {lp, math.huge} }
        category = "damage"
    elseif matchAny(nm, KEYWORDS.combat) then
        effect = "COMBAT ACTION"; effectIcon = "⚔️"; risk = "MEDIUM"
        suggestedArgs = { {}, {lp} }
        category = "combat"
    elseif matchAny(nm, KEYWORDS.boss) then
        effect = "BOSS INTERACT"; effectIcon = "👹"; risk = "HIGH"
        suggestedArgs = { {math.huge}, {"kill"} }
        category = "boss"
    end
    return {
        remote = rem, path = rem:GetFullName(), class = rem.ClassName,
        risk = risk, effect = effect, effectIcon = effectIcon,
        suggestedArgs = suggestedArgs, source = "AutoClass",
        name = rem.Name, category = category,
        score = scoreVuln(nm, fnm),
    }
end
local function indexObject(obj)
    if not obj then return end
    pcall(function()
        local cls = obj.ClassName
        local nm = safeLower(obj.Name)
        local fnm = obj.Parent and safeLower(obj.Parent.Name) or ""
        local fullPath = nm .. "|" .. fnm
        if cls == "RemoteEvent" or cls == "RemoteFunction" then
            if matchAny(fullPath, KEYWORDS.honey) then
                safeInsert(DeepData.AnticheatRemotes, obj); return
            end
            local score = scoreVuln(nm, fnm)
            if score >= 40 then safeInsert(DeepData.HighValueRemotes, obj) end
            if #nm >= 20 or nm:find("^%w+%W%w+") == nil then
                safeInsert(DeepData.ObfuscatedRemotes, obj)
            end
            local matched = false
            local categoryMap = {
                {"combat","CombatRemotes"},{"damage","DamageRemotes"},{"boss","BossRemotes"},
                {"ability","AbilityRemotes"},{"money","MoneyRemotes"},{"admin","AdminRemotes"},
                {"heal","HealRemotes"},{"teleport","TeleportRemotes"},{"chat","ChatRemotes"},
                {"spawn","SpawnRemotes"},{"god","GodRemotes"},{"delete","DeleteRemotes"},
                {"execute","ExecuteRemotes"},{"noclip","NoclipRemotes"},{"speed","SpeedRemotes"},
                {"kick","KillRemotes"},{"shop","ShopRemotes"},{"inventory","InventoryRemotes"},
                {"quest","QuestRemotes"},{"trade","TradeRemotes"},{"pet","PetRemotes"},
                {"vehicle","VehicleRemotes"},{"build","BuildRemotes"},{"claim","ClaimRemotes"},
                {"upgrade","UpgradeRemotes"},{"roll","RollRemotes"},{"lottery","LotteryRemotes"},
                {"datastore","DataStoreRemotes"},{"session","SessionRemotes"},
            }
            for _, cat in ipairs(categoryMap) do
                if matchAny(fullPath, KEYWORDS[cat[1]]) then
                    safeInsert(DeepData[cat[2]], obj); matched = true
                end
            end
            if not matched then safeInsert(DeepData.UnknownRemotes, obj) end
            if nm:find("^_") or nm:find("__") then safeInsert(DeepData.InternalRemotes, obj) end
        elseif cls == "Tool" then
            for _, r in ipairs(obj:GetDescendants()) do
                if r:IsA("RemoteEvent") or r:IsA("RemoteFunction") then safeInsert(DeepData.WeaponRemotes, r) end
            end
            safeInsert(DeepData.Tools, obj)
        elseif cls == "BindableEvent" or cls == "BindableFunction" then
            if matchAny(nm, KEYWORDS.bindable) then safeInsert(DeepData.Bindables, obj) end
        elseif cls == "LocalScript" or cls == "Script" or cls == "ModuleScript" then
            if matchAny(fullPath, KEYWORDS.honey) then safeInsert(DeepData.AnticheatScripts, obj) end
            if cls == "ModuleScript" then safeInsert(DeepData.LocalModules, obj) end
            pcall(function()
                if obj.Source and type(obj.Source) == "string" then
                    local src = obj.Source:lower()
                    if src:find("loadstring") or src:find("getfenv%(") or src:find("hookmetamethod") then
                        safeInsert(DeepData.SuspiciousScripts, obj)
                    end
                    DeepData.ScriptSources[obj:GetFullName()] = obj.Source:sub(1, 500)
                end
            end)
        elseif cls == "ProximityPrompt" then
            local pnm = safeLower(obj.ObjectText or "") .. "|" .. safeLower(obj.ActionText or "")
            if matchAny(pnm, KEYWORDS.combat) or matchAny(pnm, KEYWORDS.money) or matchAny(pnm, KEYWORDS.shop) then
                safeInsert(DeepData.CombatPrompts, obj)
            end
        elseif cls == "ClickDetector" then
            safeInsert(DeepData.ClickDetectors, obj)
        end
    end)
end
local function scanForBosses()
    DeepData.BossModels = {}; DeepData.NPCs = {}; DeepData.HiddenModels = {}
    for _, m in ipairs(ws:GetDescendants()) do
        if m:IsA("Model") and m ~= lp.Character and not plrs:GetPlayerFromCharacter(m) then
            pcall(function()
                local h = m:FindFirstChildOfClass("Humanoid")
                if not h then return end
                local nm = safeLower(m.Name)
                local isBoss = matchAny(nm, KEYWORDS.boss) or m:GetAttribute("Boss") or m:GetAttribute("IsBoss") or (h.MaxHealth >= 1000)
                if isBoss then safeInsert(DeepData.BossModels, m) end
                safeInsert(DeepData.NPCs, m)
                if m.Parent ~= ws and not m.Parent:IsA("Model") then
                    safeInsert(DeepData.HiddenModels, m)
                end
            end)
        end
    end
end
local function detectAnticheatType()
    DeepData.AnticheatType = "None detected"
    local knownACs = {
        {"antiexploit","AntiExploit"},{"kohl","Kohl's Admin"},{"hydroxide","Hydroxide"},
        {"cerebrus","Cerebrus"},{"vermilion","Vermilion"},{"eremito","Eremito"},
        {"stronghold","Stronghold"},{"sentinel","Sentinel"},{"guard","GuardV3"},
        {"anticheat","Generic AC"},{"adonis","Adonis"},{"hddonate","HD Admin"},
        {"basicadmin","Basic Admin"},{"clockwork","Clockwork"},
    }
    for _, s in ipairs(DeepData.AnticheatScripts) do
        pcall(function()
            local nm = safeLower(s.Name)
            for _, ac in ipairs(knownACs) do
                if nm:find(ac[1]) then DeepData.AnticheatType = ac[2]; return end
            end
        end)
    end
    if DeepData.AnticheatType == "None detected" and #DeepData.AnticheatScripts > 0 then
        DeepData.AnticheatType = "Unknown (" .. #DeepData.AnticheatScripts .. " scripts)"
    end
end
local ScanState = { running = false }
local function scanGarbageCollector()
    if not getgc or ScanState.running then return end
    ScanState.running = true
    task.spawn(function()
        pcall(function()
            DeepData.GCRemotesFound = {}
            DeepData.GCFunctionsFound = {}
            DeepData.ConstantsFound = {}
            local BATCH = 200
            local gc = getgc(true)
            for i, obj in ipairs(gc) do
                if type(obj) == "table" then
                    pcall(function()
                        for k, v in pairs(obj) do
                            if typeof(v) == "Instance" and (v:IsA("RemoteEvent") or v:IsA("RemoteFunction")) then
                                safeInsert(DeepData.GCRemotesFound, v)
                            end
                        end
                    end)
                elseif type(obj) == "function" then
                    pcall(function()
                        if debug and debug.getinfo then
                            local info = debug.getinfo(obj, "S")
                            if info and info.source then
                                local src = safeLower(info.source)
                                if src:find("combat") or src:find("damage") or src:find("weapon") or src:find("money") or src:find("admin") or src:find("backdoor") then
                                    safeInsert(DeepData.GCFunctionsFound, obj)
                                end
                            end
                        end
                        if getconstants then
                            local consts = getconstants(obj)
                            if consts then
                                for _, c in pairs(consts) do
                                    if type(c) == "string" and (c:find("kick") or c:find("ban") or c:find("admin") or c:find("execute")) and #c < 100 then
                                        safeInsert(DeepData.ConstantsFound, c)
                                    end
                                end
                            end
                        end
                    end)
                end
                if i % BATCH == 0 then task.wait() end
                if i > 50000 then break end
            end
        end)
        ScanState.running = false
    end)
end
local function scanUpvalues()
    if not getupvalues or not getgc then return end
    task.spawn(function()
        pcall(function()
            DeepData.UpvalueRemotes = {}
            local BATCH = 150
            for i, fn in ipairs(getgc(true)) do
                if type(fn) == "function" then
                    pcall(function()
                        local ups = getupvalues(fn)
                        if ups then
                            for _, up in pairs(ups) do
                                if typeof(up) == "Instance" and (up:IsA("RemoteEvent") or up:IsA("RemoteFunction")) then
                                    safeInsert(DeepData.UpvalueRemotes, up)
                                end
                            end
                        end
                    end)
                end
                if i % BATCH == 0 then task.wait() end
                if i > 25000 then break end
            end
        end)
    end)
end
local function scanNilParents()
    if not Settings.DeepAccess then return end
    if not getgc then return end
    DeepData.NilParentObjects = {}
    pcall(function()
        for _, obj in ipairs(getgc(true)) do
            if typeof(obj) == "Instance" then
                pcall(function()
                    if obj.Parent == nil and (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") or obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript")) then
                        safeInsert(DeepData.NilParentObjects, obj)
                    end
                end)
            end
        end
    end)
end
local function attemptDecompile()
    if not decompile then return end
    DeepData.DecompiledScripts = {}
    pcall(function()
        for _, s in ipairs(DeepData.AnticheatScripts) do
            pcall(function()
                local src = decompile(s)
                if src and type(src) == "string" and #src > 20 then
                    DeepData.DecompiledScripts[s:GetFullName()] = src:sub(1, 1500)
                end
            end)
        end
        for _, s in ipairs(DeepData.SuspiciousScripts) do
            pcall(function()
                local src = decompile(s)
                if src and type(src) == "string" and #src > 20 then
                    DeepData.DecompiledScripts[s:GetFullName()] = src:sub(1, 1500)
                end
            end)
        end
    end)
end
local function scanProtectedInstances()
    DeepData.ProtectedInstances = {}
    pcall(function()
        for _, svc in ipairs({"ReplicatedFirst","ServerStorage","ServerScriptService"}) do
            pcall(function()
                local s = game:GetService(svc)
                if s then
                    for _, d in ipairs(s:GetDescendants()) do
                        pcall(function()
                            if d:IsA("RemoteEvent") or d:IsA("RemoteFunction") or d:IsA("ModuleScript") then
                                safeInsert(DeepData.ProtectedInstances, {
                                    obj = d, service = svc, path = d:GetFullName(), class = d.ClassName
                                })
                            end
                        end)
                    end
                end
            end)
        end
    end)
end
-- ═══════════════════════════════════════════════════════════
-- v3 MEGA DEEP SCANNERS: залезаем куда обычно не залезть
-- ═══════════════════════════════════════════════════════════

-- Паттерны для распознавания секретов в constants/strings
local SECRET_PATTERNS = {
    url      = {"^https?://[%w%._%-/%?&=#%%~:]+", label="URL"},
    webhook  = {"discord%.com/api/webhooks/[%w/_%-]+", label="DISCORD WEBHOOK"},
    webhook2 = {"discordapp%.com/api/webhooks/[%w/_%-]+", label="DISCORD WEBHOOK"},
    apikey   = {"[Aa][Pp][Ii][_%-]?[Kk][Ee][Yy][%s=:\"']+[%w%-]+", label="API KEY"},
    token    = {"[Tt][Oo][Kk][Ee][Nn][%s=:\"']+[%w%-%._]+", label="TOKEN"},
    passwd   = {"[Pp][Aa][Ss][Ss][Ww]?[Oo]?[Rr]?[Dd][%s=:\"']+[%w%-%._!@#$]+", label="PASSWORD"},
    secret   = {"[Ss][Ee][Cc][Rr][Ee][Tt][%s=:\"']+[%w%-%._]+", label="SECRET"},
    bearer   = {"[Bb]earer%s+[%w%-%._]+", label="BEARER"},
    md5      = {"[a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]$", label="MD5-LIKE"},
    productid= {"[Pp]roductId[%s=:]+(%d+)", label="DEV PRODUCT ID"},
    gamepass = {"[Gg]amepassId[%s=:]+(%d+)", label="GAMEPASS ID"},
    datastore= {"[Dd]ata[Ss]tore[%s%(:\"']+([%w_%-]+)", label="DATASTORE NAME"},
    admin    = {"[Aa]dmin[Ll]ist[%s=:{]+", label="ADMIN LIST BLOCK"},
}

local function scanStringForSecrets(str, sourcePath)
    if type(str) ~= "string" or #str > 20000 or #str < 4 then return end
    for pname, pdef in pairs(SECRET_PATTERNS) do
        pcall(function()
            for match in str:gmatch(pdef[1]) do
                if #match < 500 and #match > 3 then
                    local entry = { value = match, source = sourcePath or "?", type = pdef.label }
                    if pdef.label:find("URL") and not pdef.label:find("WEBHOOK") then
                        safeInsert(DeepData.DiscoveredURLs, entry)
                    elseif pdef.label:find("WEBHOOK") then
                        safeInsert(DeepData.DiscoveredWebhooks, entry)
                    elseif pdef.label:find("PASSWORD") then
                        safeInsert(DeepData.DiscoveredPasswords, entry)
                    elseif pdef.label:find("TOKEN") or pdef.label:find("BEARER") then
                        safeInsert(DeepData.DiscoveredTokens, entry)
                    elseif pdef.label:find("KEY") or pdef.label:find("SECRET") then
                        safeInsert(DeepData.DiscoveredKeys, entry)
                    elseif pdef.label:find("ID") then
                        safeInsert(DeepData.DiscoveredIDs, entry)
                    elseif pdef.label:find("MD5") then
                        safeInsert(DeepData.DiscoveredHashes, entry)
                    end
                end
            end
        end)
    end
    -- ID hunting: 12+ digit numeric literals часто = asset/product ids
    pcall(function()
        for id in str:gmatch("(%d%d%d%d%d%d%d%d%d%d+)") do
            if #id <= 15 then
                safeInsert(DeepData.AssetIDs, { id = id, source = sourcePath or "?" })
            end
        end
    end)
end

-- Сканим ВСЕ Instance в игре включая nil-parent через executor API
local function scanAllInstances()
    DeepData.AllInstances = {}
    DeepData.NilInstances = {}
    pcall(function()
        if getinstances then
            local all = getinstances()
            for i, o in ipairs(all) do
                safeInsert(DeepData.AllInstances, o)
                if i > 50000 then break end
            end
        end
    end)
    pcall(function()
        if getnilinstances then
            for _, o in ipairs(getnilinstances()) do
                safeInsert(DeepData.NilInstances, o)
                pcall(function()
                    if typeof(o) == "Instance" then
                        if o:IsA("RemoteEvent") or o:IsA("RemoteFunction") then
                            safeInsert(DeepData.NilParentObjects, o)
                            indexObject(o)
                        elseif o:IsA("BindableEvent") then
                            safeInsert(DeepData.BindableEvents, o)
                        elseif o:IsA("BindableFunction") then
                            safeInsert(DeepData.BindableFunctions, o)
                        end
                    end
                end)
            end
        end
    end)
end

-- Дампим ВСЕ загруженные модули + пытаемся require() → снимаем возвращаемую таблицу
local function scanLoadedModules()
    if not getloadedmodules then return end
    DeepData.LoadedModules = {}
    DeepData.ModuleReturns = {}
    pcall(function()
        local ms = getloadedmodules()
        local BATCH = 40
        for i, m in ipairs(ms) do
            pcall(function()
                if typeof(m) == "Instance" and m:IsA("ModuleScript") then
                    safeInsert(DeepData.LoadedModules, m)
                    -- Пытаемся require: часто модуль отдаёт таблицу с remote refs / config
                    local ok, ret = pcall(require, m)
                    if ok and type(ret) == "table" then
                        local dump = {}
                        local cnt = 0
                        for k, v in pairs(ret) do
                            cnt = cnt + 1
                            if cnt > 50 then break end
                            local vs
                            if typeof(v) == "Instance" then
                                vs = "<Instance " .. v.ClassName .. " " .. v:GetFullName() .. ">"
                                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                                    indexObject(v)
                                end
                            elseif type(v) == "function" then vs = "<function>"
                            elseif type(v) == "table" then vs = "<table len=" .. #v .. ">"
                            elseif type(v) == "string" then
                                vs = v:sub(1, 200)
                                scanStringForSecrets(v, m:GetFullName())
                            else vs = tostring(v) end
                            dump[tostring(k)] = vs
                        end
                        DeepData.ModuleReturns[m:GetFullName()] = dump
                    end
                end
            end)
            if i % BATCH == 0 then task.wait() end
        end
    end)
end

-- Дампим ВСЕ скрипты + пытаемся decompile каждый
local function scanAllScripts()
    if not decompile then return end
    DeepData.AllScriptSources = {}
    DeepData.ActorScripts = {}
    DeepData.ClientContextScripts = {}
    local candidates = {}
    if getscripts then
        pcall(function()
            for _, s in ipairs(getscripts()) do table.insert(candidates, s) end
        end)
    end
    if getrunningscripts then
        pcall(function()
            for _, s in ipairs(getrunningscripts()) do table.insert(candidates, s) end
        end)
    end
    if getloadedmodules then
        pcall(function()
            for _, s in ipairs(getloadedmodules()) do table.insert(candidates, s) end
        end)
    end
    -- Fallback: descendants
    for _, root in ipairs({ws, rep, game:GetService("StarterPlayer"), game:GetService("StarterGui"), game:GetService("StarterPack")}) do
        pcall(function()
            for _, d in ipairs(root:GetDescendants()) do
                if d:IsA("LocalScript") or d:IsA("ModuleScript") or d:IsA("Script") then
                    table.insert(candidates, d)
                end
            end
        end)
    end
    local seen = {}
    local decompiled = 0
    for i, s in ipairs(candidates) do
        pcall(function()
            if seen[s] then return end
            seen[s] = true
            if typeof(s) ~= "Instance" then return end
            if s:IsA("Actor") then safeInsert(DeepData.ActorScripts, s) end
            pcall(function()
                if s.RunContext and tostring(s.RunContext) == "Enum.RunContext.Client" then
                    safeInsert(DeepData.ClientContextScripts, s)
                end
            end)
            if decompiled < 60 then
                local ok, src = pcall(decompile, s)
                if ok and type(src) == "string" and #src > 20 then
                    DeepData.AllScriptSources[s:GetFullName()] = src:sub(1, 8000)
                    decompiled = decompiled + 1
                    scanStringForSecrets(src, s:GetFullName())
                    -- Обфусцированный источник?
                    local density = 0
                    for _ in src:gmatch("[\\_]0x[%dA-Fa-f]+") do density = density + 1 end
                    for _ in src:gmatch("\\%d%d%d") do density = density + 1 end
                    if density > 20 or src:find("v[0-9]+_v[0-9]+_v") then
                        safeInsert(DeepData.ObfuscatedScriptSources, { path = s:GetFullName(), density = density })
                    end
                end
            end
        end)
        if i % 10 == 0 then task.wait() end
        if i > 500 then break end
    end
end

-- ГЛУБОКИЙ дамп замыканий: getconstants + getupvalues + getprotos рекурсивно
local function megaDumpClosures()
    if not getgc then return end
    DeepData.DeepConstantDump = {}
    DeepData.UpvalueDump = {}
    DeepData.ProtoScan = {}
    DeepData.RemoteInvokers = {}
    pcall(function()
        local gc = getgc(true)
        local BATCH = 100
        local processed = 0
        local dumpedRemotes = {}
        for i, fn in ipairs(gc) do
            if type(fn) == "function" then
                pcall(function()
                    -- constants
                    if getconstants then
                        local consts = getconstants(fn)
                        if consts then
                            local remoteName, invokeStyle
                            for _, c in pairs(consts) do
                                if type(c) == "string" then
                                    if #c < 200 then
                                        scanStringForSecrets(c, "GC:function#" .. i)
                                    end
                                    if c == "FireServer" or c == "InvokeServer" then
                                        invokeStyle = c
                                    elseif #c > 2 and #c < 60 and c:match("^[%w_]+$") then
                                        -- Возможное имя remote
                                        if invokeStyle then remoteName = c end
                                    end
                                    -- Ключевые слова
                                    local lc = c:lower()
                                    if #c < 100 and (lc:find("kick") or lc:find("ban") or lc:find("admin") or lc:find("execute") or lc:find("bypass") or lc:find("debug") or lc:find("owner") or lc:find("dev") or lc:find("password")) then
                                        safeInsert(DeepData.DeepConstantDump, { value = c:sub(1, 150), src = "gc#" .. i })
                                    end
                                end
                            end
                            if remoteName and invokeStyle then
                                safeInsert(DeepData.RemoteInvokers, { name = remoteName, method = invokeStyle, func_index = i })
                            end
                        end
                    end
                    -- upvalues
                    if getupvalues then
                        local ups = getupvalues(fn)
                        if ups then
                            for uk, uv in pairs(ups) do
                                if typeof(uv) == "Instance" and (uv:IsA("RemoteEvent") or uv:IsA("RemoteFunction")) then
                                    if not dumpedRemotes[uv] then
                                        dumpedRemotes[uv] = true
                                        safeInsert(DeepData.UpvalueRemotes, uv)
                                        indexObject(uv)
                                    end
                                elseif type(uv) == "table" then
                                    -- Ищем в таблице конфига remote-ссылки и admin-листы
                                    pcall(function()
                                        local tcnt = 0
                                        for tk, tv in pairs(uv) do
                                            tcnt = tcnt + 1
                                            if tcnt > 40 then break end
                                            if typeof(tv) == "Instance" and (tv:IsA("RemoteEvent") or tv:IsA("RemoteFunction")) then
                                                if not dumpedRemotes[tv] then
                                                    dumpedRemotes[tv] = true
                                                    safeInsert(DeepData.UpvalueRemotes, tv)
                                                    indexObject(tv)
                                                end
                                            elseif type(tv) == "string" then
                                                local ltv = tv:lower()
                                                if ltv:find("admin") or ltv:find("owner") or ltv:find("dev") then
                                                    safeInsert(DeepData.AdminList, { name = tv, source = "gc-upvalue-table" })
                                                end
                                                if tv:match("^%d%d%d%d%d%d%d+$") then
                                                    safeInsert(DeepData.AdminList, { userId = tv, source = "gc-upvalue-table" })
                                                end
                                            end
                                        end
                                    end)
                                elseif type(uv) == "string" and #uv > 5 and #uv < 200 then
                                    scanStringForSecrets(uv, "upvalue")
                                end
                            end
                        end
                    end
                    -- protos: рекурсивный дамп внутренних функций
                    if getprotos then
                        local pr = getprotos(fn)
                        if pr and #pr > 0 then
                            for _, sub in ipairs(pr) do
                                if getconstants then
                                    local sc = getconstants(sub)
                                    if sc then
                                        for _, c in pairs(sc) do
                                            if type(c) == "string" and #c < 200 then
                                                scanStringForSecrets(c, "proto")
                                            end
                                        end
                                    end
                                end
                            end
                            safeInsert(DeepData.ProtoScan, { func_index = i, proto_count = #pr })
                        end
                    end
                end)
                processed = processed + 1
            elseif type(fn) == "table" then
                -- Ищем _G-like таблицы с чит-ключами
                pcall(function()
                    local cnt = 0
                    for k, v in pairs(fn) do
                        cnt = cnt + 1
                        if cnt > 30 then break end
                        if type(k) == "string" and type(v) == "string" and #v < 500 then
                            scanStringForSecrets(v, "gc-table[" .. k .. "]")
                        end
                    end
                end)
            end
            if i % BATCH == 0 then task.wait() end
            if i > 30000 then break end
        end
        DeepData.MegaScanStats.ClosuresProcessed = processed
    end)
end

-- Дамп _G и shared
local function dumpGlobals()
    DeepData.GlobalTable = {}
    pcall(function()
        for k, v in pairs(_G) do
            local vs
            if typeof(v) == "Instance" then vs = "<Instance " .. v.ClassName .. ">"
            elseif type(v) == "table" then vs = "<table>"
            elseif type(v) == "function" then vs = "<function>"
            else vs = tostring(v):sub(1, 200) end
            DeepData.GlobalTable["_G." .. tostring(k)] = vs
        end
    end)
    pcall(function()
        if shared then
            for k, v in pairs(shared) do
                DeepData.GlobalTable["shared." .. tostring(k)] = tostring(v):sub(1, 200)
            end
        end
    end)
end

-- Собираем инфу об игроке / leaderstats / командах
local function dumpPlayerContext()
    DeepData.LocalPlayerData = {}
    DeepData.LeaderstatsSchema = {}
    DeepData.TeamsInfo = {}
    pcall(function()
        for _, attr in ipairs({"UserId","AccountAge","MembershipType","DisplayName","LocaleId"}) do
            DeepData.LocalPlayerData[attr] = tostring(lp[attr])
        end
        pcall(function()
            for _, a in pairs(lp:GetAttributes()) do
                DeepData.LocalPlayerData["attr:" .. tostring(a)] = tostring(a)
            end
        end)
        local ls = lp:FindFirstChild("leaderstats")
        if ls then
            for _, v in ipairs(ls:GetChildren()) do
                DeepData.LeaderstatsSchema[v.Name] = { class = v.ClassName, value = tostring(v.Value) }
            end
        end
        for _, name in ipairs({"Data","PlayerData","Stats","PlayerStats","SaveData"}) do
            local d = lp:FindFirstChild(name)
            if d then
                for _, v in ipairs(d:GetDescendants()) do
                    if v:IsA("ValueBase") then
                        DeepData.LeaderstatsSchema[name .. "/" .. v.Name] = { class = v.ClassName, value = tostring(v.Value) }
                    end
                end
            end
        end
    end)
    pcall(function()
        local Teams = game:GetService("Teams")
        for _, t in ipairs(Teams:GetTeams()) do
            table.insert(DeepData.TeamsInfo, { name = t.Name, color = tostring(t.TeamColor), autoAssign = t.AutoAssignable })
        end
    end)
end

-- Сканим NetworkOwnership (кто владеет физикой чего = потенциальный експлойт)
local function scanNetworkOwners()
    DeepData.NetworkOwners = {}
    pcall(function()
        for _, obj in ipairs(ws:GetDescendants()) do
            if obj:IsA("BasePart") and not obj.Anchored then
                pcall(function()
                    local owner = obj:GetNetworkOwner()
                    if owner == lp then
                        safeInsert(DeepData.NetworkOwners, { path = obj:GetFullName(), owner = "LocalPlayer(YOU)" })
                    elseif owner == nil then
                        -- server owned
                    end
                end)
            end
        end
    end)
end

-- Vulnerability heuristics: RemoteEvent без OnServerEvent connections = мертвый / бэкдор?
local function scanRemoteConnectionCount()
    if not getconnections then return end
    DeepData.RemoteConnections = {}
    local all = {}
    for _, cat in ipairs({"MoneyRemotes","AdminRemotes","GodRemotes","ExecuteRemotes","KillRemotes","DeleteRemotes","BossRemotes"}) do
        for _, r in ipairs(DeepData[cat] or {}) do
            all[r] = true
        end
    end
    for r, _ in pairs(all) do
        pcall(function()
            local conns
            if r:IsA("RemoteEvent") then
                conns = getconnections(r.OnClientEvent)
            end
            local c = conns and #conns or 0
            DeepData.RemoteConnections[r:GetFullName()] = c
        end)
    end
end

-- Bindable events / functions собираем отдельно (часто дублируют серверную логику клиенту)
local function scanBindables()
    for _, root in ipairs({ws, rep, game:GetService("StarterPlayer"), game:GetService("StarterGui")}) do
        pcall(function()
            for _, d in ipairs(root:GetDescendants()) do
                if d:IsA("BindableEvent") then safeInsert(DeepData.BindableEvents, d)
                elseif d:IsA("BindableFunction") then safeInsert(DeepData.BindableFunctions, d) end
            end
        end)
    end
end

local function buildExploitList()
    DeepData.ExploitList = {}
    local seen = {}
    local function add(rem)
        if not rem or seen[rem] then return end
        seen[rem] = true
        pcall(function() table.insert(DeepData.ExploitList, classifyExploit(rem)) end)
    end
    local categories = {"MoneyRemotes","AdminRemotes","GodRemotes","ExecuteRemotes",
        "TeleportRemotes","KillRemotes","DeleteRemotes","HealRemotes","SpawnRemotes",
        "ChatRemotes","SpeedRemotes","NoclipRemotes","BossRemotes","DamageRemotes",
        "CombatRemotes","HighValueRemotes","AbilityRemotes","ShopRemotes","InventoryRemotes",
        "QuestRemotes","TradeRemotes","PetRemotes","VehicleRemotes","BuildRemotes",
        "ClaimRemotes","UpgradeRemotes","RollRemotes","LotteryRemotes","DataStoreRemotes",
        "ObfuscatedRemotes","InternalRemotes"}
    for _, cat in ipairs(categories) do
        for _, r in ipairs(DeepData[cat]) do add(r) end
    end
    for _, r in ipairs(DeepData.GCRemotesFound) do add(r) end
    for _, r in ipairs(DeepData.UpvalueRemotes) do add(r) end
    for _, obj in ipairs(DeepData.NilParentObjects) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then add(obj) end
    end
    table.sort(DeepData.ExploitList, function(a, b)
        if a.score ~= b.score then return (a.score or 0) > (b.score or 0) end
        local order = { CRITICAL = 4, HIGH = 3, MEDIUM = 2, LOW = 1 }
        return (order[a.risk] or 0) > (order[b.risk] or 0)
    end)
end
local LastScanTime = 0
local function runFullAnalysis(force)
    local now = tick()
    if not force and (now - LastScanTime) < 15 then warn("[ANALYZER] Skip"); return end
    LastScanTime = now
    DeepData.ScanCount = DeepData.ScanCount + 1
    for k, v in pairs(DeepData) do
        if type(v) == "table" and k ~= "ScriptSources" and k ~= "DecompiledScripts" and k ~= "SpiedCalls" and k ~= "CallSignatures" then
            DeepData[k] = {}
        end
    end
    DeepData.ScriptSources = {}
    DeepData.AnticheatType = "None detected"
    pcall(function()
        DeepData.GameId = game.GameId
        DeepData.PlaceId = game.PlaceId
        DeepData.GameName = game.Name
    end)
    local sources = { rep, ws, game:GetService("StarterPack"), game:GetService("StarterGui"), game:GetService("StarterPlayer") }
    for _, s in ipairs(sources) do
        pcall(function() for _, o in ipairs(s:GetDescendants()) do indexObject(o) end end)
    end
    for _, p in ipairs(plrs:GetPlayers()) do
        local bp = p:FindFirstChild("Backpack")
        if bp then for _, o in ipairs(bp:GetDescendants()) do indexObject(o) end end
    end
    if Settings.DeepAccess then
        scanProtectedInstances()
    end
    scanForBosses()
    detectAnticheatType()
    scanGarbageCollector()
    scanUpvalues()
    if Settings.DeepAccess then scanNilParents() end
    -- v3 MEGA DEEP passes
    scanAllInstances()
    scanBindables()
    scanLoadedModules()
    task.wait(0.3)
    megaDumpClosures()
    task.wait(0.3)
    scanAllScripts()
    dumpGlobals()
    dumpPlayerContext()
    scanNetworkOwners()
    scanRemoteConnectionCount()
    task.wait(0.5)
    attemptDecompile()
    buildExploitList()
    DeepData.ScanTime = tick() - now
    warn("╔═════════════════════════════════════════════╗")
    warn("║ 🔬 GAME ANALYZER v3 — SCAN #" .. DeepData.ScanCount .. " (" .. math.floor(DeepData.ScanTime*10)/10 .. "s)")
    warn("║ 🎮 " .. tostring(DeepData.GameName) .. " (place=" .. tostring(DeepData.PlaceId) .. ")")
    warn("╠═════════════════════════════════════════════╣")
    warn(string.format("║ 🚪 Total exploits: %d", #DeepData.ExploitList))
    warn(string.format("║ 💰 Money:%d  👑 Admin:%d  🛡️ God:%d",
        #DeepData.MoneyRemotes, #DeepData.AdminRemotes, #DeepData.GodRemotes))
    warn(string.format("║ 🚨 Execute:%d  🛒 Shop:%d  🎰 Roll:%d",
        #DeepData.ExecuteRemotes, #DeepData.ShopRemotes, #DeepData.RollRemotes))
    warn(string.format("║ 🔬 GC-found:%d  🔬 Upvalue:%d  🕳️ NilParent:%d",
        #DeepData.GCRemotesFound, #DeepData.UpvalueRemotes, #DeepData.NilParentObjects))
    warn(string.format("║ 🎭 AntiCheat: %s (%d scripts)", DeepData.AnticheatType, #DeepData.AnticheatScripts))
    warn(string.format("║ 🕵️ Decompiled: %d  🔒 Protected: %d",
        (function() local c=0; for _ in pairs(DeepData.DecompiledScripts) do c=c+1 end; return c end)(),
        #DeepData.ProtectedInstances))
    warn(string.format("║ 🧬 AllInst:%d  🕳️ NilInst:%d  📦 Modules:%d",
        #DeepData.AllInstances, #DeepData.NilInstances, #DeepData.LoadedModules))
    warn(string.format("║ 📜 AllSrc:%d  🌀 Obfusc:%d  🎭 Actors:%d",
        (function() local c=0; for _ in pairs(DeepData.AllScriptSources) do c=c+1 end; return c end)(),
        #DeepData.ObfuscatedScriptSources, #DeepData.ActorScripts))
    warn(string.format("║ 🔑 Keys:%d  🌐 URLs:%d  📡 Webhooks:%d",
        #DeepData.DiscoveredKeys, #DeepData.DiscoveredURLs, #DeepData.DiscoveredWebhooks))
    warn(string.format("║ 🔐 Passwd:%d  🎫 Tokens:%d  🏷️ IDs:%d",
        #DeepData.DiscoveredPasswords, #DeepData.DiscoveredTokens, #DeepData.DiscoveredIDs))
    warn(string.format("║ 👥 AdminList:%d  🔗 BindEv:%d  🌍 NetOwn:%d",
        #DeepData.AdminList, #DeepData.BindableEvents, #DeepData.NetworkOwners))
    warn("╚═════════════════════════════════════════════╝")
end
ws.DescendantAdded:Connect(function(o) if o then indexObject(o) end end)
rep.DescendantAdded:Connect(function(o) if o then indexObject(o) end end)
local RemoteSpy = { installed = false, active = false }
function RemoteSpy:Install()
    if self.installed then return end
    self.installed = true
    if not hookmetamethod then return end
    pcall(function()
        local old
        old = hookmetamethod(game, "__namecall", function(self, ...)
            local m = getnamecallmethod and getnamecallmethod() or ""
            if RemoteSpy.active and (m == "FireServer" or m == "InvokeServer") then
                if typeof(self) == "Instance" and (self:IsA("RemoteEvent") or self:IsA("RemoteFunction")) then
                    local args = {...}
                    pcall(function()
                        local sig = { rem = self, method = m, args = args, time = tick(), path = self:GetFullName() }
                        table.insert(DeepData.SpiedCalls, 1, sig)
                        if #DeepData.SpiedCalls > Settings.SpyMaxCalls then
                            table.remove(DeepData.SpiedCalls)
                        end
                        local key = self:GetFullName()
                        if not DeepData.CallSignatures[key] then
                            DeepData.CallSignatures[key] = { remote = self, samples = {}, count = 0 }
                        end
                        DeepData.CallSignatures[key].count = DeepData.CallSignatures[key].count + 1
                        if #DeepData.CallSignatures[key].samples < 5 then
                            table.insert(DeepData.CallSignatures[key].samples, args)
                        end
                    end)
                end
            end
            return old(self, ...)
        end)
    end)
end
function RemoteSpy:Toggle(state)
    self.active = state
    if state and not self.installed then self:Install() end
end
local function executeExploit(exp)
    if not exp or not exp.remote or not exp.remote.Parent then return false end
    local rem = exp.remote
    local fired = 0
    local key = rem:GetFullName()
    if DeepData.CallSignatures[key] and #DeepData.CallSignatures[key].samples > 0 then
        for _, args in ipairs(DeepData.CallSignatures[key].samples) do
            pcall(function()
                if rem:IsA("RemoteEvent") then rem:FireServer(unpack(args)); fired = fired + 1
                elseif rem:IsA("RemoteFunction") then task.spawn(function() pcall(function() rem:InvokeServer(unpack(args)) end) end); fired = fired + 1 end
            end)
        end
    end
    for _, args in ipairs(exp.suggestedArgs or {{}}) do
        pcall(function()
            if type(args) == "table" then
                if rem:IsA("RemoteEvent") then rem:FireServer(unpack(args)); fired = fired + 1
                elseif rem:IsA("RemoteFunction") then task.spawn(function() pcall(function() rem:InvokeServer(unpack(args)) end) end); fired = fired + 1 end
            end
        end)
    end
    if fired == 0 then
        if rem:IsA("RemoteEvent") then pcall(function() rem:FireServer(); fired = fired + 1 end)
        elseif rem:IsA("RemoteFunction") then task.spawn(function() pcall(function() rem:InvokeServer() end) end); fired = fired + 1 end
    end
    warn("[🚪 EXEC " .. exp.effectIcon .. "] " .. exp.effect .. " → " .. exp.path .. " (fired " .. fired .. ")")
    return true, fired
end
local function copyToClipboard(text)
    if setclipboard then
        pcall(function() setclipboard(text) end)
        return true
    end
    warn("[📋] setclipboard недоступен — text:\n" .. text:sub(1, 500))
    return false
end
local function exploitToScript(exp)
    local args = exp.suggestedArgs and exp.suggestedArgs[1] or {}
    local argsStr = argsToString(args):sub(2, -2)
    local line
    if exp.class == "RemoteEvent" then
        line = 'game:GetService("' .. exp.remote.Parent.ClassName .. '"):FindFirstChild("...")'
        line = "-- " .. exp.effectIcon .. " " .. exp.effect .. " [" .. exp.risk .. "]\n"
        line = line .. "-- Path: " .. exp.path .. "\n"
        line = line .. 'local rem = game:GetService("Players"):FindFirstChild("dummy") -- заменить на путь!\n'
        line = line .. 'local target = game:GetService("Workspace")\n'
        line = line .. 'for _, part in ipairs({' .. table.concat({}, ",") .. '}) do end\n'
        line = line .. '-- Try: rem:FireServer(' .. argsStr .. ')'
    else
        line = "-- " .. exp.effectIcon .. " " .. exp.effect .. " [" .. exp.risk .. "]\n"
        line = line .. "-- Path: " .. exp.path .. "\n"
        line = line .. 'local rem = "..." -- заменить\n'
        line = line .. '-- rem:InvokeServer(' .. argsStr .. ')'
    end
    return line
end
local function exploitToReadableInfo(exp)
    local out = {}
    table.insert(out, "═════════════════════════════════")
    table.insert(out, exp.effectIcon .. " " .. exp.effect .. " [RISK: " .. exp.risk .. "]")
    table.insert(out, "═════════════════════════════════")
    table.insert(out, "Name: " .. exp.name)
    table.insert(out, "Class: " .. exp.class)
    table.insert(out, "Path: " .. exp.path)
    table.insert(out, "Category: " .. exp.category)
    table.insert(out, "Vuln-Score: " .. tostring(exp.score))
    table.insert(out, "")
    table.insert(out, "SUGGESTED ARGS:")
    for i, args in ipairs(exp.suggestedArgs or {}) do
        table.insert(out, "  [" .. i .. "] " .. argsToString(args))
    end
    local key = exp.remote and exp.remote:GetFullName()
    if key and DeepData.CallSignatures[key] then
        local sig = DeepData.CallSignatures[key]
        table.insert(out, "")
        table.insert(out, "REAL CALLS RECORDED: " .. sig.count)
        for i, args in ipairs(sig.samples) do
            if i > 3 then break end
            table.insert(out, "  [live] " .. argsToString(args))
        end
    end
    table.insert(out, "")
    table.insert(out, "EXECUTE via Lua:")
    table.insert(out, 'loadstring([[')
    table.insert(out, '  local rem = game.' .. exp.path:gsub("Workspace", 'Workspace'):gsub("ReplicatedStorage", 'ReplicatedStorage'))
    if exp.class == "RemoteEvent" then
        for _, args in ipairs(exp.suggestedArgs or {}) do
            table.insert(out, '  rem:FireServer(' .. argsToString(args):sub(2,-2) .. ')')
        end
    else
        for _, args in ipairs(exp.suggestedArgs or {}) do
            table.insert(out, '  rem:InvokeServer(' .. argsToString(args):sub(2,-2) .. ')')
        end
    end
    table.insert(out, ']])()') 
    return table.concat(out, "\n")
end
local function fullReportToString()
    local out = {}
    local function w(s) table.insert(out, s or "") end
    local function sec(title) w(""); w("╔══════════════════════════════════════════════════════════════╗"); w("║ " .. title); w("╚══════════════════════════════════════════════════════════════╝") end

    w("╔══════════════════════════════════════════════════════════════╗")
    w("║ 🔬 GAME ANALYZER v3.0 MEGA DEEP — FULL REPORT")
    w("║ Scan #" .. DeepData.ScanCount .. " | ScanTime: " .. math.floor(DeepData.ScanTime*10)/10 .. "s")
    w("║ 🎮 Game: " .. tostring(DeepData.GameName))
    w("║ GameId=" .. tostring(DeepData.GameId) .. " | PlaceId=" .. tostring(DeepData.PlaceId))
    w("║ 🎭 AntiCheat: " .. tostring(DeepData.AnticheatType))
    w("║ 👤 Player: " .. lp.Name .. " (UserId=" .. tostring(lp.UserId) .. ")")
    w("║ 🛠️ Executor: " .. tostring((_identify and _identify()) or "unknown"))
    w("╚══════════════════════════════════════════════════════════════╝")

    -- ============ MEGA STATS ============
    sec("📊 MEGA DEEP SCAN STATISTICS")
    w("Total Instances Scanned: " .. #DeepData.AllInstances)
    w("Nil-Parent Instances: " .. #DeepData.NilInstances)
    w("Loaded ModuleScripts: " .. #DeepData.LoadedModules)
    w("Total Exploits Found: " .. #DeepData.ExploitList)
    w("Money Remotes: " .. #DeepData.MoneyRemotes)
    w("Admin Remotes: " .. #DeepData.AdminRemotes)
    w("God Remotes: " .. #DeepData.GodRemotes)
    w("Execute (RCE) Remotes: " .. #DeepData.ExecuteRemotes)
    w("Delete/Kick Remotes: " .. (#DeepData.DeleteRemotes + #DeepData.KillRemotes))
    w("GC-discovered Remotes: " .. #DeepData.GCRemotesFound)
    w("Upvalue-discovered Remotes: " .. #DeepData.UpvalueRemotes)
    w("Protected Storage Items: " .. #DeepData.ProtectedInstances)
    w("Obfuscated Scripts: " .. #DeepData.ObfuscatedScriptSources)
    w("Actor-parented Scripts: " .. #DeepData.ActorScripts)
    w("Client RunContext Scripts: " .. #DeepData.ClientContextScripts)
    w("BindableEvents: " .. #DeepData.BindableEvents)
    w("BindableFunctions: " .. #DeepData.BindableFunctions)
    w("Local Network-owned Parts: " .. #DeepData.NetworkOwners)
    w("Discovered Secrets: keys=" .. #DeepData.DiscoveredKeys ..
        " urls=" .. #DeepData.DiscoveredURLs ..
        " webhooks=" .. #DeepData.DiscoveredWebhooks ..
        " passwds=" .. #DeepData.DiscoveredPasswords ..
        " tokens=" .. #DeepData.DiscoveredTokens ..
        " ids=" .. #DeepData.DiscoveredIDs ..
        " hashes=" .. #DeepData.DiscoveredHashes)
    w("Admin Names Found: " .. #DeepData.AdminList)
    w("Closures Processed: " .. tostring(DeepData.MegaScanStats.ClosuresProcessed or 0))

    -- ============ PLAYER CONTEXT ============
    sec("👤 LOCAL PLAYER CONTEXT")
    for k, v in pairs(DeepData.LocalPlayerData) do w("  " .. k .. " = " .. tostring(v)) end
    if next(DeepData.LeaderstatsSchema) then
        w("")
        w("[LeaderStats / Player Data Schema]")
        for k, v in pairs(DeepData.LeaderstatsSchema) do
            w("  " .. k .. " :: " .. v.class .. " = " .. tostring(v.value))
        end
    end
    if #DeepData.TeamsInfo > 0 then
        w("")
        w("[Teams]")
        for _, t in ipairs(DeepData.TeamsInfo) do
            w("  " .. t.name .. " color=" .. t.color .. " auto=" .. tostring(t.autoAssign))
        end
    end

    -- ============ SECRETS ============
    sec("🔐 SECRETS / SENSITIVE STRINGS EXTRACTED FROM CODE")
    local function dumpSecrets(list, label)
        if #list == 0 then return end
        w("")
        w("── " .. label .. " (" .. #list .. ") ──")
        for i, e in ipairs(list) do
            if i > 30 then w("  ... +" .. (#list - 30) .. " more"); break end
            w("  [" .. tostring(e.type or "?") .. "] " .. tostring(e.value or e.id or e.name) .. "   ← " .. tostring(e.source or "?"))
        end
    end
    dumpSecrets(DeepData.DiscoveredWebhooks, "🔥 DISCORD WEBHOOKS")
    dumpSecrets(DeepData.DiscoveredPasswords, "🔐 PASSWORDS")
    dumpSecrets(DeepData.DiscoveredTokens, "🎫 TOKENS / BEARER")
    dumpSecrets(DeepData.DiscoveredKeys, "🔑 API KEYS / SECRETS")
    dumpSecrets(DeepData.DiscoveredURLs, "🌐 URLs")
    dumpSecrets(DeepData.DiscoveredIDs, "🏷️ Product/Gamepass IDs")
    dumpSecrets(DeepData.AssetIDs, "🎨 Asset ID candidates (12+ digits)")
    dumpSecrets(DeepData.DiscoveredHashes, "#️⃣ Hash-like strings")

    -- ============ ADMIN LIST ============
    if #DeepData.AdminList > 0 then
        sec("👑 ADMIN / OWNER LIST (extracted from closures)")
        for i, a in ipairs(DeepData.AdminList) do
            if i > 50 then w("  ... +" .. (#DeepData.AdminList - 50) .. " more"); break end
            w("  " .. tostring(a.name or a.userId) .. "   ← " .. tostring(a.source))
        end
    end

    -- ============ TOP EXPLOITS with FULL DETAIL ============
    sec("🚪 ALL EXPLOITS — FULL DETAIL WITH READY-TO-USE CODE")
    local byCat = {}
    for _, exp in ipairs(DeepData.ExploitList) do
        byCat[exp.category] = byCat[exp.category] or {}
        table.insert(byCat[exp.category], exp)
    end
    local sortedCats = {}
    for c in pairs(byCat) do table.insert(sortedCats, c) end
    table.sort(sortedCats)
    for _, cat in ipairs(sortedCats) do
        local list = byCat[cat]
        w("")
        w("═════ CATEGORY: " .. cat:upper() .. " (" .. #list .. ") ═════")
        for i, exp in ipairs(list) do
            if i > 15 then w("  ... +" .. (#list - 15) .. " more in this category"); break end
            w("")
            w("  " .. exp.effectIcon .. " [" .. exp.risk .. " | score=" .. tostring(exp.score) .. "] " .. exp.name .. " (" .. exp.class .. ")")
            w("    Path: " .. exp.path)
            w("    Effect: " .. exp.effect)
            local ccount = DeepData.RemoteConnections[exp.path]
            if ccount then w("    Client connections: " .. ccount) end
            for k, args in ipairs(exp.suggestedArgs or {}) do
                if k > 3 then break end
                w("    args[" .. k .. "]: " .. argsToString(args))
            end
            local key = exp.remote and exp.remote:GetFullName()
            if key and DeepData.CallSignatures[key] then
                local sig = DeepData.CallSignatures[key]
                w("    🕵️ REAL CALLS RECORDED: " .. sig.count)
                for k, args in ipairs(sig.samples) do
                    if k > 2 then break end
                    w("      [live] " .. argsToString(args))
                end
            end
            -- Готовый снипет
            local method = exp.class == "RemoteEvent" and "FireServer" or "InvokeServer"
            w("    💡 SNIPPET:")
            w('      local r = game:GetService("' .. (exp.path:match("^([^%.]+)") or "ReplicatedStorage") .. '")')
            w('      -- full path: ' .. exp.path)
            local firstArgs = (exp.suggestedArgs and exp.suggestedArgs[1]) and argsToString(exp.suggestedArgs[1]):sub(2,-2) or ""
            w('      r:' .. method .. '(' .. firstArgs .. ')')
        end
    end

    -- ============ SPY LOG ============
    sec("🕵️ REMOTE SPY LOG (last " .. math.min(50, #DeepData.SpiedCalls) .. " calls)")
    for i, call in ipairs(DeepData.SpiedCalls) do
        if i > 50 then break end
        w("  " .. call.method .. " → " .. call.path)
        w("    args: " .. argsToString(call.args))
    end
    w("")
    w("[Call Signatures Summary]")
    local sigcnt = 0
    for path, sig in pairs(DeepData.CallSignatures) do
        sigcnt = sigcnt + 1
        if sigcnt > 30 then w("  ... +more"); break end
        w("  " .. path .. " called " .. sig.count .. " times")
    end

    -- ============ PROTECTED / HIDDEN INSTANCES ============
    sec("🔒 PROTECTED INSTANCES (ServerStorage/ReplicatedFirst/SSS)")
    for i, pi in ipairs(DeepData.ProtectedInstances) do
        if i > 100 then w("  ... +" .. (#DeepData.ProtectedInstances - 100) .. " more"); break end
        w("  [" .. pi.service .. "] " .. pi.class .. ": " .. pi.path)
    end

    sec("🕳️ NIL-PARENT INSTANCES (hidden from Explorer)")
    for i, o in ipairs(DeepData.NilParentObjects) do
        if i > 50 then w("  ... +more"); break end
        pcall(function() w("  " .. o.ClassName .. ": " .. o.Name) end)
    end

    -- ============ MODULE RETURNS ============
    sec("📦 LOADED MODULE RETURN VALUES (require dumps)")
    local mrcnt = 0
    for path, dump in pairs(DeepData.ModuleReturns) do
        mrcnt = mrcnt + 1
        if mrcnt > 15 then w(""); w("  ... +more modules"); break end
        w("")
        w("── " .. path .. " ──")
        for k, v in pairs(dump) do
            w("    " .. k .. " = " .. tostring(v))
        end
    end

    -- ============ OBFUSCATED SCRIPTS ============
    if #DeepData.ObfuscatedScriptSources > 0 then
        sec("🌀 OBFUSCATED SCRIPTS DETECTED")
        for _, o in ipairs(DeepData.ObfuscatedScriptSources) do
            w("  density=" .. o.density .. " :: " .. o.path)
        end
    end

    -- ============ FULL DECOMPILED SOURCE ============
    sec("📜 DECOMPILED SCRIPT SOURCES (real game code)")
    local dc = 0
    for path, src in pairs(DeepData.AllScriptSources) do
        dc = dc + 1
        if dc > 15 then w(""); w("  ... +" .. ((function() local c=0 for _ in pairs(DeepData.AllScriptSources) do c=c+1 end return c end)() - 15) .. " more scripts (increase limit / use per-script copy)"); break end
        w("")
        w("╭─── SCRIPT #" .. dc .. ": " .. path .. " ───")
        w(src)
        w("╰─── END SCRIPT #" .. dc .. " ───")
    end
    -- Anticheat scripts тоже
    w("")
    w("── ANTICHEAT / SUSPICIOUS decompiled ──")
    for path, src in pairs(DeepData.DecompiledScripts) do
        w("")
        w("╭─── AC: " .. path .. " ───")
        w(src)
        w("╰───")
    end

    -- ============ GLOBALS ============
    if next(DeepData.GlobalTable) then
        sec("🌐 GLOBALS (_G + shared)")
        for k, v in pairs(DeepData.GlobalTable) do w("  " .. k .. " = " .. tostring(v)) end
    end

    -- ============ NETWORK OWNERS ============
    if #DeepData.NetworkOwners > 0 then
        sec("🌍 LOCAL-OWNED PARTS (you can teleport/velocity these freely)")
        for i, o in ipairs(DeepData.NetworkOwners) do
            if i > 40 then w("  ... +more"); break end
            w("  " .. o.path)
        end
    end

    -- ============ BINDABLES ============
    if #DeepData.BindableEvents > 0 or #DeepData.BindableFunctions > 0 then
        sec("🔗 BINDABLES (client-side event/function; sometimes bridged to server)")
        for i, b in ipairs(DeepData.BindableEvents) do
            if i > 30 then break end
            w("  [Event] " .. b:GetFullName())
        end
        for i, b in ipairs(DeepData.BindableFunctions) do
            if i > 30 then break end
            w("  [Func]  " .. b:GetFullName())
        end
    end

    -- ============ INVOKER MAP ============
    if #DeepData.RemoteInvokers > 0 then
        sec("📡 REMOTE INVOKER MAP (constants pointing to Fire/Invoke calls)")
        for i, r in ipairs(DeepData.RemoteInvokers) do
            if i > 60 then break end
            w("  " .. r.method .. " '" .. r.name .. "'  (found in gc#" .. r.func_index .. ")")
        end
    end

    -- ============ ANALYST NOTE ============
    sec("🧠 ANALYSIS SUMMARY (for LLM/human review)")
    w("Recommended immediate targets, ranked by score:")
    for i = 1, math.min(15, #DeepData.ExploitList) do
        local e = DeepData.ExploitList[i]
        w("  " .. i .. ". " .. e.effectIcon .. " [" .. e.risk .. "|" .. e.score .. "] " .. e.name .. " → " .. e.path)
    end
    w("")
    w("Send this whole report to your LLM. It contains:")
    w(" - Full remote inventory with categories, scores, real call samples")
    w(" - Decompiled source of client scripts and anticheat")
    w(" - Extracted secrets (webhooks/keys/passwords/admin lists)")
    w(" - Player context + leaderstats schema")
    w(" - Hidden/nil-parent instances")
    w(" - Module return dumps (config tables)")
    w(" - Network ownership map")
    w("")
    w("╔══════════════════════════════════════════════════════════════╗")
    w("║ END OF REPORT — GameAnalyzer v3.0 MEGA DEEP")
    w("║ Total size: " .. tostring(math.floor((#table.concat(out, "\n"))/1024)) .. " KB")
    w("╚══════════════════════════════════════════════════════════════╝")
    return table.concat(out, "\n")
end

-- Разбивает большой отчёт на куски ~15KB чтобы влезло в буфер Discord/чата LLM
local function chunkReport(report, chunkSize)
    chunkSize = chunkSize or 15000
    local chunks = {}
    local total = #report
    local pos = 1
    while pos <= total do
        local endPos = math.min(pos + chunkSize - 1, total)
        -- Ищем ближайший \n назад чтобы не резать по середине строки
        if endPos < total then
            local ln = report:sub(pos, endPos):match(".*()\n")
            if ln then endPos = pos + ln - 2 end
        end
        table.insert(chunks, report:sub(pos, endPos))
        pos = endPos + 1
    end
    for i, c in ipairs(chunks) do
        chunks[i] = "═══ PART " .. i .. "/" .. #chunks .. " ═══\n" .. c
    end
    return chunks
end

local function rebuildReportChunks()
    local report = fullReportToString()
    DeepData.ReportChunks = chunkReport(report, 15000)
    DeepData.ReportChunkIndex = 1
    -- Пробуем сохранить полный отчёт файлом на диск через executor
    if writefile then
        pcall(function() writefile("GameAnalyzer_Report.txt", report) end)
    end
    return report
end
local AK = { active = false, installed = false, hooks = {}, blocked = 0, layers = 0 }
local BAN_KW = {"kick","ban","anticheat","ac_","punish","report","detect","suspend","moderat","admin","exploit","hack","cheat","suspicious","violation","flag","warn"}
local function isBanRemote(r)
    local nm = safeLower(r.Name)
    local fnm = r.Parent and safeLower(r.Parent.Name) or ""
    for _, kw in ipairs(BAN_KW) do if nm:find(kw) or fnm:find(kw) then return true end end
    return false
end
function AK:Install()
    if self.installed then return end
    self.installed = true
    self.layers = 0
    if hookfunction then
        pcall(function()
            local orig
            orig = hookfunction(lp.Kick, function(...)
                if AK.active then AK.blocked = AK.blocked + 1; warn("[🛡️ L1] Kick blocked #" .. AK.blocked); return end
                return orig(...)
            end)
            AK.layers = AK.layers + 1
        end)
    end
    if getrawmetatable and setreadonly then
        pcall(function()
            local mt = getrawmetatable(lp)
            setreadonly(mt, false)
            local oldIndex = mt.__index
            local newIndex = function(s, k)
                if AK.active and k == "Kick" and typeof(s) == "Instance" and s:IsA("Player") then
                    return function() AK.blocked = AK.blocked + 1; warn("[🛡️ L2] Kick intercepted") end
                end
                if type(oldIndex) == "function" then return oldIndex(s, k) end
                return oldIndex[k]
            end
            mt.__index = newcclosure and newcclosure(newIndex) or newIndex
            setreadonly(mt, true)
            AK.layers = AK.layers + 1
        end)
    end
    pcall(function()
        local count = 0
        for _, s in ipairs({rep, ws}) do
            for _, r in ipairs(s:GetDescendants()) do
                if r:IsA("RemoteEvent") and isBanRemote(r) then
                    if getconnections then
                        pcall(function()
                            for _, c in ipairs(getconnections(r.OnClientEvent)) do
                                pcall(function() c:Disable() end); count = count + 1
                            end
                        end)
                    end
                    table.insert(AK.hooks, r.OnClientEvent:Connect(function()
                        if AK.active then AK.blocked = AK.blocked + 1; warn("[🛡️ L3] Ban-remote blocked") end
                    end))
                end
            end
        end
        AK.layers = AK.layers + 1
    end)
    pcall(function()
        connections["ak_desc"] = ws.DescendantAdded:Connect(function(obj)
            if AK.active and obj:IsA("RemoteEvent") and isBanRemote(obj) then
                pcall(function()
                    table.insert(AK.hooks, obj.OnClientEvent:Connect(function()
                        AK.blocked = AK.blocked + 1; warn("[🛡️ L4] Runtime ban-remote blocked")
                    end))
                end)
            end
        end)
        AK.layers = AK.layers + 1
    end)
    pcall(function()
        if hookfunction then
            local TS = game:GetService("TeleportService")
            local origT
            origT = hookfunction(TS.Teleport, function(self, ...)
                if AK.active then AK.blocked = AK.blocked + 1; warn("[🛡️ L5] Teleport blocked"); return end
                return origT(self, ...)
            end)
            AK.layers = AK.layers + 1
        end
    end)
    pcall(function()
        connections["ak_pr"] = plrs.PlayerRemoving:Connect(function(p)
            if AK.active and p == lp then AK.blocked = AK.blocked + 1; warn("[🛡️ L6] CRIT: PlayerRemoving for us!") end
        end)
        AK.layers = AK.layers + 1
    end)
    pcall(function()
        connections["ak_gui"] = task.spawn(function()
            while AK.installed do
                if AK.active then
                    pcall(function()
                        local pg = lp:FindFirstChildOfClass("PlayerGui")
                        if not pg then return end
                        for _, g in ipairs(pg:GetDescendants()) do
                            if g:IsA("Frame") and g.Size == UDim2.new(1,0,1,0) and g.BackgroundTransparency < 0.4 then
                                local nm = safeLower(g.Name)
                                if nm:find("kick") or nm:find("ban") or nm:find("overlay") then
                                    pcall(function() g:Destroy() end); AK.blocked = AK.blocked + 1
                                end
                            end
                            if g:IsA("TextLabel") then
                                local t = safeLower(g.Text or "")
                                if t:find("kicked") or t:find("banned") or t:find("detected") then
                                    local sg = g:FindFirstAncestorOfClass("ScreenGui")
                                    if sg then pcall(function() sg:Destroy() end); AK.blocked = AK.blocked + 1 end
                                end
                            end
                        end
                    end)
                end
                task.wait(0.3)
            end
        end)
        AK.layers = AK.layers + 1
    end)
    pcall(function()
        local Lighting = game:GetService("Lighting")
        connections["ak_blur"] = Lighting.DescendantAdded:Connect(function(obj)
            if AK.active and (obj:IsA("BlurEffect") or obj:IsA("ColorCorrectionEffect")) then
                task.wait(0.1)
                local nm = safeLower(obj.Name)
                if nm:find("kick") or nm:find("ban") or nm:find("dim") then
                    pcall(function() obj:Destroy() end); AK.blocked = AK.blocked + 1
                end
            end
        end)
        AK.layers = AK.layers + 1
    end)
    pcall(function()
        local StarterGui = game:GetService("StarterGui")
        connections["ak_top"] = task.spawn(function()
            while AK.installed do
                if AK.active then
                    pcall(function()
                        StarterGui:SetCore("TopbarEnabled", true)
                        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
                    end)
                end
                task.wait(1)
            end
        end)
        AK.layers = AK.layers + 1
    end)
    pcall(function()
        local sc = game:GetService("ScriptContext")
        connections["ak_err"] = sc.Error:Connect(function(msg)
            if AK.active and msg then
                local lm = tostring(msg):lower()
                if lm:find("kick") or lm:find("ban") or lm:find("disconnect") then
                    warn("[🛡️ L10] Script error: " .. msg:sub(1,50)); AK.blocked = AK.blocked + 1
                end
            end
        end)
        AK.layers = AK.layers + 1
    end)
    print("[🛡️ AK] Установлено " .. AK.layers .. " слоёв")
end
function AK:Toggle(state)
    self.active = state
    if state and not self.installed then self:Install() end
    print("[🛡️ AK] " .. (state and "🟢 ON" or "🔴 OFF"))
end
local function newInst(class, props, parent)
    local o = Instance.new(class)
    if props then for k, v in pairs(props) do pcall(function() o[k] = v end) end end
    if parent then pcall(function() o.Parent = parent end) end
    return o
end
local function makeCorner(p, r)
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r or 6); c.Parent = p
end
local function stealthName()
    local list = { "PlayerListGui", "ChatModule", "SystemUI", "TopBarUI", "MessageBox", "CoreGuiExt", "PromptModule", "InputHandler", "TextChatContainer" }
    return list[math.random(1, #list)] .. "_" .. tostring(math.random(1000, 9999))
end
local sg = newInst("ScreenGui", { Name = stealthName(), ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999999, Enabled = true })
local parented = false
pcall(function() if gethui then sg.Parent = gethui(); parented = true end end)
if not parented then pcall(function() sg.Parent = game:GetService("CoreGui"); parented = (sg.Parent ~= nil) end) end
if not parented then pcall(function() sg.Parent = lp:WaitForChild("PlayerGui", 5); parented = true end) end
if not parented then warn("[v2] ❌ GUI parent fail"); return end
warn("[v2] ✅ GUI parent: " .. tostring(sg.Parent) .. " | Name: " .. sg.Name)
local mf = newInst("Frame", {
    Size = UDim2.new(0, 520, 0, 600),
    Position = UDim2.new(0, 20, 0, 60),
    BackgroundColor3 = Color3.fromRGB(18, 18, 24),
    BorderSizePixel = 0, Active = true, Draggable = true, Visible = true, ZIndex = 10
}, sg)
makeCorner(mf, 10)
newInst("UIStroke", { Color = Color3.fromRGB(80, 80, 100), Thickness = 2, Transparency = 0.3 }, mf)
local title = newInst("TextLabel", {
    Size = UDim2.new(1, -70, 0, 32),
    Text = "  🔬 GAME ANALYZER v3.0",
    TextColor3 = Color3.fromRGB(150, 220, 255),
    Font = Enum.Font.GothamBold, TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    BackgroundColor3 = Color3.fromRGB(10, 10, 14),
    BorderSizePixel = 0, ZIndex = 11
}, mf)
makeCorner(title, 10)
local minBtn = newInst("TextButton", {
    Size = UDim2.new(0, 32, 0, 28), Position = UDim2.new(1, -68, 0, 2),
    Text = "-", Font = Enum.Font.GothamBold, TextSize = 18,
    TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(45,45,55),
    BorderSizePixel = 0, ZIndex = 12
}, mf)
makeCorner(minBtn, 6)
local unloadBtn = newInst("TextButton", {
    Size = UDim2.new(0, 32, 0, 28), Position = UDim2.new(1, -34, 0, 2),
    Text = "X", Font = Enum.Font.GothamBold, TextSize = 14,
    TextColor3 = Color3.fromRGB(255,200,200), BackgroundColor3 = Color3.fromRGB(100,30,30),
    BorderSizePixel = 0, ZIndex = 12
}, mf)
makeCorner(unloadBtn, 6)
local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        mf:TweenSize(UDim2.new(0,520,0,34), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true); minBtn.Text = "+"
        for _, v in ipairs(mf:GetChildren()) do if v:IsA("GuiObject") and v~=title and v~=minBtn and v~=unloadBtn then v.Visible=false end end
    else
        mf:TweenSize(UDim2.new(0,520,0,600), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true); minBtn.Text = "-"
        for _, v in ipairs(mf:GetChildren()) do if v:IsA("GuiObject") and v~=title and v~=minBtn and v~=unloadBtn then v.Visible=true end end
    end
end)
local actF = newInst("Frame", { Size = UDim2.new(1, -12, 0, 42), Position = UDim2.new(0, 6, 0, 38), BackgroundTransparency = 1, ZIndex = 11 }, mf)
local scanBtn = newInst("TextButton", {
    Size = UDim2.new(0.32, -3, 1, 0), Position = UDim2.new(0, 0, 0, 0),
    Text = "🔄 SCAN", Font = Enum.Font.GothamBold, TextSize = 13,
    TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(0, 140, 180),
    BorderSizePixel = 0, ZIndex = 12
}, actF)
makeCorner(scanBtn, 6)
local exportBtn = newInst("TextButton", {
    Size = UDim2.new(0.32, -3, 1, 0), Position = UDim2.new(0.34, 0, 0, 0),
    Text = "📋 EXPORT", Font = Enum.Font.GothamBold, TextSize = 13,
    TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(0, 150, 100),
    BorderSizePixel = 0, ZIndex = 12
}, actF)
makeCorner(exportBtn, 6)
local execAllBtn = newInst("TextButton", {
    Size = UDim2.new(0.32, -3, 1, 0), Position = UDim2.new(0.68, 0, 0, 0),
    Text = "🔥 EXEC ALL", Font = Enum.Font.GothamBold, TextSize = 13,
    TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(180, 40, 40),
    BorderSizePixel = 0, ZIndex = 12
}, actF)
makeCorner(execAllBtn, 6)
local tabBar = newInst("Frame", { Size = UDim2.new(1, -12, 0, 26), Position = UDim2.new(0, 6, 0, 84), BackgroundTransparency = 1, ZIndex = 11 }, mf)
local tabPanels = {}
local curTab = "exploits"
local tabButtons = {}
local function makeTabBtn(id, label, x, w)
    local b = newInst("TextButton", {
        Size = UDim2.new(w, -2, 1, 0), Position = UDim2.new(x, 0, 0, 0),
        Text = label, Font = Enum.Font.GothamBold, TextSize = 10,
        TextColor3 = Color3.fromRGB(255,255,255),
        BackgroundColor3 = (id == curTab) and Color3.fromRGB(60, 100, 140) or Color3.fromRGB(45, 45, 55),
        BorderSizePixel = 0, ZIndex = 12
    }, tabBar)
    makeCorner(b, 4)
    tabButtons[id] = b
    b.MouseButton1Click:Connect(function()
        curTab = id
        for pid, p in pairs(tabPanels) do p.Visible = (pid == id) end
        for tid, tb in pairs(tabButtons) do tb.BackgroundColor3 = (tid == id) and Color3.fromRGB(60, 100, 140) or Color3.fromRGB(45, 45, 55) end
    end)
end
makeTabBtn("exploits", "🚪 Экспл", 0, 0.22)
makeTabBtn("workspace", "📊 Дерево", 0.22, 0.22)
makeTabBtn("analyzer", "🔬 Анлз", 0.44, 0.18)
makeTabBtn("spy", "🕵️ Spy", 0.62, 0.16)
makeTabBtn("settings", "⚙️", 0.78, 0.22)
local panelArea = newInst("Frame", { Size = UDim2.new(1, -12, 1, -122), Position = UDim2.new(0, 6, 0, 114), BackgroundTransparency = 1, ZIndex = 11 }, mf)
local expPanel = newInst("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = true, ZIndex = 11 }, panelArea)
tabPanels.exploits = expPanel
local expInfo = newInst("TextLabel", {
    Size = UDim2.new(1, -4, 0, 18), BackgroundTransparency = 1,
    Text = "  🚪 Найдено: 0 | Тап=execute  🎯=copy info  📋=copy path",
    Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = Color3.fromRGB(200, 220, 255),
    TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 12
}, expPanel)
local expScroll = newInst("ScrollingFrame", {
    Size = UDim2.new(1, -4, 1, -22), Position = UDim2.new(0, 0, 0, 20),
    BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 4,
    AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(0,0,0,0), ZIndex = 11
}, expPanel)
newInst("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder }, expScroll)
local function refreshExploits()
    for _, c in ipairs(expScroll:GetChildren()) do
        if c:IsA("TextButton") or c:IsA("Frame") or c:IsA("TextLabel") then c:Destroy() end
    end
    expInfo.Text = "  🚪 Найдено: " .. #DeepData.ExploitList .. " | Тап=exec  🎯=info  📋=path"
    if #DeepData.ExploitList == 0 then
        newInst("TextLabel", {
            Size = UDim2.new(1, -8, 0, 40), BackgroundTransparency = 1,
            Text = "  Нажми SCAN — найдёт эксплойты",
            Font = Enum.Font.SourceSans, TextSize = 11,
            TextColor3 = Color3.fromRGB(180,180,180), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 12
        }, expScroll)
        return
    end
    for i, exp in ipairs(DeepData.ExploitList) do
        local col = Color3.fromRGB(80,80,100)
        if exp.risk == "CRITICAL" then col = Color3.fromRGB(180,40,40)
        elseif exp.risk == "HIGH" then col = Color3.fromRGB(180,120,40)
        elseif exp.risk == "MEDIUM" then col = Color3.fromRGB(150,150,40) end
        local container = newInst("Frame", {
            Size = UDim2.new(1, -8, 0, 48), BackgroundColor3 = col,
            BorderSizePixel = 0, LayoutOrder = i, ZIndex = 12
        }, expScroll)
        makeCorner(container, 4)
        local mainBtn = newInst("TextButton", {
            Size = UDim2.new(1, -68, 1, 0), Position = UDim2.new(0, 0, 0, 0),
            Text = "", BackgroundTransparency = 1, AutoButtonColor = true, ZIndex = 13
        }, container)
        newInst("TextLabel", {
            Size = UDim2.new(1, -6, 0, 16), Position = UDim2.new(0, 5, 0, 2),
            Text = exp.effectIcon .. " " .. exp.effect .. "  [" .. exp.risk .. "]  score=" .. exp.score,
            Font = Enum.Font.GothamBold, TextSize = 11,
            TextColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 14
        }, mainBtn)
        newInst("TextLabel", {
            Size = UDim2.new(1, -6, 0, 12), Position = UDim2.new(0, 5, 0, 18),
            Text = exp.name .. "  (" .. exp.class .. ")",
            Font = Enum.Font.SourceSans, TextSize = 10,
            TextColor3 = Color3.fromRGB(230,230,240), BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 14
        }, mainBtn)
        newInst("TextLabel", {
            Size = UDim2.new(1, -6, 0, 12), Position = UDim2.new(0, 5, 0, 32),
            Text = exp.path:sub(1, 55),
            Font = Enum.Font.SourceSans, TextSize = 9,
            TextColor3 = Color3.fromRGB(180,200,220), BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 14
        }, mainBtn)
        mainBtn.MouseButton1Click:Connect(function() executeExploit(exp) end)
        local infoBtn = newInst("TextButton", {
            Size = UDim2.new(0, 30, 1, -4), Position = UDim2.new(1, -64, 0, 2),
            Text = "🎯", Font = Enum.Font.GothamBold, TextSize = 14,
            TextColor3 = Color3.fromRGB(255,255,255),
            BackgroundColor3 = Color3.fromRGB(40, 100, 140), BorderSizePixel = 0, ZIndex = 14
        }, container)
        makeCorner(infoBtn, 4)
        infoBtn.MouseButton1Click:Connect(function()
            local info = exploitToReadableInfo(exp)
            copyToClipboard(info)
            infoBtn.Text = "✅"
            _origPrint("\n" .. info)
            task.wait(1); infoBtn.Text = "🎯"
        end)
        local pathBtn = newInst("TextButton", {
            Size = UDim2.new(0, 30, 1, -4), Position = UDim2.new(1, -32, 0, 2),
            Text = "📋", Font = Enum.Font.GothamBold, TextSize = 14,
            TextColor3 = Color3.fromRGB(255,255,255),
            BackgroundColor3 = Color3.fromRGB(40, 120, 80), BorderSizePixel = 0, ZIndex = 14
        }, container)
        makeCorner(pathBtn, 4)
        pathBtn.MouseButton1Click:Connect(function()
            copyToClipboard(exp.path)
            pathBtn.Text = "✅"
            task.wait(1); pathBtn.Text = "📋"
        end)
    end
end
local wsPanel = newInst("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false, ZIndex = 11 }, panelArea)
tabPanels.workspace = wsPanel
local wsScroll = newInst("ScrollingFrame", {
    Size = UDim2.new(1, -4, 1, 0), BackgroundTransparency = 1, BorderSizePixel = 0,
    ScrollBarThickness = 4, AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(0,0,0,0), ZIndex = 11
}, wsPanel)
newInst("UIListLayout", { Padding = UDim.new(0, 1) }, wsScroll)
local expandedNodes = {}
local function iconFor(cls)
    if cls == "Folder" then return "📁"
    elseif cls == "Model" then return "🎯"
    elseif cls == "Part" or cls == "BasePart" or cls == "MeshPart" or cls == "UnionOperation" then return "🧊"
    elseif cls == "Script" then return "📜"
    elseif cls == "LocalScript" then return "📝"
    elseif cls == "ModuleScript" then return "📘"
    elseif cls == "RemoteEvent" then return "📡"
    elseif cls == "RemoteFunction" then return "📶"
    elseif cls == "BindableEvent" then return "🔔"
    elseif cls == "BindableFunction" then return "🎯"
    elseif cls == "Tool" then return "🗡️"
    elseif cls == "Humanoid" then return "🚶"
    elseif cls == "Configuration" then return "⚙️"
    elseif cls == "NumberValue" or cls == "IntValue" or cls == "StringValue" or cls == "BoolValue" or cls == "ObjectValue" then return "🔢"
    elseif cls == "ClickDetector" then return "🖱️"
    elseif cls == "ProximityPrompt" then return "🎬"
    elseif cls == "Attachment" then return "🔗"
    elseif cls == "Motor6D" or cls == "Weld" or cls == "WeldConstraint" then return "🔗"
    elseif cls == "SpecialMesh" or cls == "BlockMesh" then return "🎭"
    elseif cls == "Sound" then return "🔊"
    elseif cls == "ParticleEmitter" then return "✨"
    elseif cls == "Beam" then return "🌈"
    else return "🔷" end
end
local function refreshWorkspaceTree()
    for _, c in ipairs(wsScroll:GetChildren()) do
        if c:IsA("TextButton") or c:IsA("Frame") then c:Destroy() end
    end
    local function addNode(obj, depth, layoutOrder)
        if not obj then return layoutOrder end
        local prefix = string.rep("  ", depth)
        local children = obj:GetChildren()
        local expandable = #children > 0
        local isExpanded = expandedNodes[obj]
        local arrow = expandable and (isExpanded and "▼" or "▶") or " "
        local icon = iconFor(obj.ClassName)
        local container = newInst("Frame", {
            Size = UDim2.new(1, -6, 0, 20),
            BackgroundColor3 = Color3.fromRGB(30, 30, 40),
            BorderSizePixel = 0, LayoutOrder = layoutOrder, ZIndex = 12
        }, wsScroll)
        makeCorner(container, 3)
        local row = newInst("TextButton", {
            Size = UDim2.new(1, -32, 1, 0), Position = UDim2.new(0, 0, 0, 0),
            Text = "", BackgroundTransparency = 1, AutoButtonColor = false, ZIndex = 13
        }, container)
        newInst("TextLabel", {
            Size = UDim2.new(1, -8, 1, 0), Position = UDim2.new(0, 4, 0, 0),
            Text = prefix .. arrow .. " " .. icon .. " " .. obj.Name .. " [" .. obj.ClassName .. "]",
            Font = Enum.Font.SourceSans, TextSize = 10, TextColor3 = Color3.fromRGB(230, 230, 240),
            BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 14
        }, row)
        layoutOrder = layoutOrder + 1
        row.MouseButton1Click:Connect(function()
            if expandable then
                expandedNodes[obj] = not expandedNodes[obj]
                refreshWorkspaceTree()
            else
                copyToClipboard(obj:GetFullName())
                warn("[📊] " .. obj:GetFullName())
            end
        end)
        local copyBtn = newInst("TextButton", {
            Size = UDim2.new(0, 28, 1, -2), Position = UDim2.new(1, -30, 0, 1),
            Text = "📋", Font = Enum.Font.GothamBold, TextSize = 10,
            TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(50, 80, 100),
            BorderSizePixel = 0, ZIndex = 14
        }, container)
        makeCorner(copyBtn, 3)
        copyBtn.MouseButton1Click:Connect(function()
            copyToClipboard(obj:GetFullName())
            copyBtn.Text = "✅"; task.wait(1); copyBtn.Text = "📋"
        end)
        if expandable and isExpanded then
            for _, child in ipairs(children) do
                layoutOrder = addNode(child, depth + 1, layoutOrder)
                if layoutOrder > 250 then return layoutOrder end
            end
        end
        return layoutOrder
    end
    local lo = 1
    lo = addNode(ws, 0, lo)
    lo = addNode(rep, 0, lo)
    pcall(function() lo = addNode(game:GetService("StarterPack"), 0, lo) end)
    pcall(function() lo = addNode(game:GetService("StarterGui"), 0, lo) end)
    pcall(function() lo = addNode(game:GetService("StarterPlayer"), 0, lo) end)
    pcall(function() lo = addNode(game:GetService("ReplicatedFirst"), 0, lo) end)
end
local anaPanel = newInst("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false, ZIndex = 11 }, panelArea)
tabPanels.analyzer = anaPanel
local anaScroll = newInst("ScrollingFrame", {
    Size = UDim2.new(1, -4, 1, 0), BackgroundTransparency = 1, BorderSizePixel = 0,
    ScrollBarThickness = 4, AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(0,0,0,0), ZIndex = 11
}, anaPanel)
newInst("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }, anaScroll)
local function addAnaLine(text, color, order)
    return newInst("TextLabel", {
        Size = UDim2.new(1, -8, 0, 18), BackgroundColor3 = Color3.fromRGB(30, 30, 40),
        BorderSizePixel = 0, Text = "  " .. text,
        Font = Enum.Font.SourceSansBold, TextSize = 11,
        TextColor3 = color or Color3.fromRGB(230, 230, 230),
        TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = order or 0, ZIndex = 12
    }, anaScroll)
end
local function refreshAnalyzer()
    for _, c in ipairs(anaScroll:GetChildren()) do
        if c:IsA("TextLabel") or c:IsA("Frame") or c:IsA("TextButton") then c:Destroy() end
    end
    local o = 0
    local function ln(t, col) o = o + 1; addAnaLine(t, col, o) end
    ln("═══ SCAN #" .. DeepData.ScanCount .. " (" .. math.floor(DeepData.ScanTime*10)/10 .. "s) ═══", Color3.fromRGB(150, 255, 200))
    ln("🎮 " .. tostring(DeepData.GameName):sub(1,40), Color3.fromRGB(200, 220, 255))
    ln("🎭 AC: " .. DeepData.AnticheatType, Color3.fromRGB(255, 200, 100))
    ln("", nil)
    ln("═══ EXPLOITS BY EFFECT ═══", Color3.fromRGB(100, 200, 255))
    ln("💰 Money: " .. #DeepData.MoneyRemotes .. "  |  👑 Admin: " .. #DeepData.AdminRemotes, Color3.fromRGB(255, 220, 100))
    ln("🛡️ God: " .. #DeepData.GodRemotes .. "  |  🚨 Exec: " .. #DeepData.ExecuteRemotes, Color3.fromRGB(255, 150, 100))
    ln("📍 TP: " .. #DeepData.TeleportRemotes .. "  |  💀 Kill: " .. #DeepData.KillRemotes, Color3.fromRGB(200, 150, 200))
    ln("💚 Heal: " .. #DeepData.HealRemotes .. "  |  ✨ Spawn: " .. #DeepData.SpawnRemotes, Color3.fromRGB(150, 200, 150))
    ln("🛒 Shop: " .. #DeepData.ShopRemotes .. "  |  🎰 Roll: " .. #DeepData.RollRemotes, Color3.fromRGB(200, 200, 100))
    ln("⬆️ Upgrade: " .. #DeepData.UpgradeRemotes .. "  |  🎁 Claim: " .. #DeepData.ClaimRemotes, Color3.fromRGB(180, 220, 150))
    ln("🐾 Pet: " .. #DeepData.PetRemotes .. "  |  📜 Quest: " .. #DeepData.QuestRemotes, Color3.fromRGB(200, 180, 220))
    ln("🚗 Vehicle: " .. #DeepData.VehicleRemotes .. "  |  🏗️ Build: " .. #DeepData.BuildRemotes, Color3.fromRGB(150, 200, 200))
    ln("💬 Chat: " .. #DeepData.ChatRemotes .. "  |  💨 Speed: " .. #DeepData.SpeedRemotes, Color3.fromRGB(180, 220, 180))
    ln("👻 Noclip: " .. #DeepData.NoclipRemotes .. "  |  🗑️ Delete: " .. #DeepData.DeleteRemotes, Color3.fromRGB(200, 100, 100))
    ln("", nil)
    ln("═══ COMBAT ═══", Color3.fromRGB(100, 200, 255))
    ln("⚔️ Combat: " .. #DeepData.CombatRemotes .. "  |  Damage: " .. #DeepData.DamageRemotes, Color3.fromRGB(255, 180, 100))
    ln("👹 Boss: " .. #DeepData.BossRemotes .. "  |  Weapon: " .. #DeepData.WeaponRemotes, Color3.fromRGB(200, 150, 200))
    ln("✨ Ability: " .. #DeepData.AbilityRemotes .. "  |  ❓ Unknown: " .. #DeepData.UnknownRemotes, Color3.fromRGB(150, 200, 255))
    ln("", nil)
    ln("═══ DEEP ACCESS ═══", Color3.fromRGB(200, 150, 255))
    ln("🔬 GC-Rem: " .. #DeepData.GCRemotesFound .. "  Upv: " .. #DeepData.UpvalueRemotes, Color3.fromRGB(200, 150, 255))
    ln("🔬 GC-Fn: " .. #DeepData.GCFunctionsFound .. "  Const: " .. #DeepData.ConstantsFound, Color3.fromRGB(200, 150, 255))
    ln("🕳️ NilParent: " .. #DeepData.NilParentObjects, Color3.fromRGB(255, 100, 200))
    ln("🔒 Protected: " .. #DeepData.ProtectedInstances, Color3.fromRGB(255, 150, 200))
    ln("🌫️ Obfuscated: " .. #DeepData.ObfuscatedRemotes .. "  Internal: " .. #DeepData.InternalRemotes, Color3.fromRGB(200, 200, 255))
    local dc = 0
    for _ in pairs(DeepData.DecompiledScripts) do dc = dc + 1 end
    ln("🕵️ Decompiled: " .. dc, Color3.fromRGB(100, 255, 200))
    ln("", nil)
    ln("═══ ANTICHEAT ═══", Color3.fromRGB(255, 100, 100))
    ln("🛡️ AC-Rem: " .. #DeepData.AnticheatRemotes .. "  AC-Scr: " .. #DeepData.AnticheatScripts, Color3.fromRGB(255, 100, 100))
    ln("🚨 Sus-Scripts: " .. #DeepData.SuspiciousScripts, Color3.fromRGB(255, 150, 100))
    ln("", nil)
    ln("═══ WORLD ═══", Color3.fromRGB(150, 255, 200))
    ln("👹 Bosses: " .. #DeepData.BossModels .. "  🚶 NPCs: " .. #DeepData.NPCs, Color3.fromRGB(200, 100, 200))
    ln("🗡️ Tools: " .. #DeepData.Tools .. "  💀 Bindables: " .. #DeepData.Bindables, Color3.fromRGB(150, 200, 150))
    ln("🎬 Prompts: " .. #DeepData.CombatPrompts .. "  🖱️ Clicks: " .. #DeepData.ClickDetectors, Color3.fromRGB(150, 200, 200))
    ln("👥 Hidden Models: " .. #DeepData.HiddenModels, Color3.fromRGB(255, 200, 100))
end
local spyPanel = newInst("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false, ZIndex = 11 }, panelArea)
tabPanels.spy = spyPanel
local spyHeader = newInst("Frame", {
    Size = UDim2.new(1, -4, 0, 32), BackgroundColor3 = Color3.fromRGB(30,30,40),
    BorderSizePixel = 0, ZIndex = 12
}, spyPanel)
makeCorner(spyHeader, 4)
local spyToggle = newInst("TextButton", {
    Size = UDim2.new(0.5, -3, 0, 26), Position = UDim2.new(0, 3, 0, 3),
    Text = "🕵️ Spy: OFF", Font = Enum.Font.GothamBold, TextSize = 11,
    TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(80, 60, 100),
    BorderSizePixel = 0, ZIndex = 13
}, spyHeader)
makeCorner(spyToggle, 4)
local spyClearBtn = newInst("TextButton", {
    Size = UDim2.new(0.5, -3, 0, 26), Position = UDim2.new(0.5, 0, 0, 3),
    Text = "🗑️ Clear log", Font = Enum.Font.GothamBold, TextSize = 11,
    TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(100, 60, 60),
    BorderSizePixel = 0, ZIndex = 13
}, spyHeader)
makeCorner(spyClearBtn, 4)
local spyScroll = newInst("ScrollingFrame", {
    Size = UDim2.new(1, -4, 1, -36), Position = UDim2.new(0, 0, 0, 36),
    BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 4,
    AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(0,0,0,0), ZIndex = 11
}, spyPanel)
newInst("UIListLayout", { Padding = UDim.new(0, 2) }, spyScroll)
spyToggle.MouseButton1Click:Connect(function()
    Settings.RemoteSpy = not Settings.RemoteSpy
    RemoteSpy:Toggle(Settings.RemoteSpy)
    spyToggle.Text = "🕵️ Spy: " .. (Settings.RemoteSpy and "ON ✅" or "OFF")
    spyToggle.BackgroundColor3 = Settings.RemoteSpy and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(80, 60, 100)
end)
spyClearBtn.MouseButton1Click:Connect(function()
    DeepData.SpiedCalls = {}
    DeepData.CallSignatures = {}
end)
local function refreshSpy()
    for _, c in ipairs(spyScroll:GetChildren()) do
        if c:IsA("TextButton") or c:IsA("Frame") or c:IsA("TextLabel") then c:Destroy() end
    end
    if #DeepData.SpiedCalls == 0 then
        newInst("TextLabel", {
            Size = UDim2.new(1, -8, 0, 30), BackgroundTransparency = 1,
            Text = "  Включи Spy и жди пока игра сделает вызовы",
            Font = Enum.Font.SourceSans, TextSize = 11,
            TextColor3 = Color3.fromRGB(180,180,180), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 12
        }, spyScroll)
        return
    end
    for i, call in ipairs(DeepData.SpiedCalls) do
        if i > 50 then break end
        local container = newInst("Frame", {
            Size = UDim2.new(1, -8, 0, 44), BackgroundColor3 = Color3.fromRGB(40, 50, 60),
            BorderSizePixel = 0, ZIndex = 12
        }, spyScroll)
        makeCorner(container, 4)
        newInst("TextLabel", {
            Size = UDim2.new(1, -40, 0, 14), Position = UDim2.new(0, 5, 0, 2),
            Text = call.method .. " → " .. call.path:sub(1, 50),
            Font = Enum.Font.GothamBold, TextSize = 10,
            TextColor3 = Color3.fromRGB(200, 255, 200), BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 13
        }, container)
        newInst("TextLabel", {
            Size = UDim2.new(1, -10, 0, 26), Position = UDim2.new(0, 5, 0, 16),
            Text = "args: " .. argsToString(call.args):sub(1, 80),
            Font = Enum.Font.SourceSans, TextSize = 10,
            TextColor3 = Color3.fromRGB(220, 220, 240), BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true, ZIndex = 13
        }, container)
        local cpBtn = newInst("TextButton", {
            Size = UDim2.new(0, 28, 0, 20), Position = UDim2.new(1, -30, 0, 2),
            Text = "📋", Font = Enum.Font.GothamBold, TextSize = 10,
            TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(50, 80, 100),
            BorderSizePixel = 0, ZIndex = 14
        }, container)
        makeCorner(cpBtn, 3)
        cpBtn.MouseButton1Click:Connect(function()
            local snippet = call.method .. "(" .. argsToString(call.args):sub(2,-2) .. ")"
            copyToClipboard(call.path .. ":" .. snippet)
            cpBtn.Text = "✅"; task.wait(1); cpBtn.Text = "📋"
        end)
    end
end
local setPanel = newInst("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false, ZIndex = 11 }, panelArea)
tabPanels.settings = setPanel
newInst("UIListLayout", { Padding = UDim.new(0, 6) }, setPanel)
local function makeToggle(label, key, defColor)
    local b = newInst("TextButton", {
        Size = UDim2.new(1, -8, 0, 34), Text = "",
        BackgroundColor3 = Settings[key] and (defColor or Color3.fromRGB(0, 150, 100)) or Color3.fromRGB(60, 60, 80),
        BorderSizePixel = 0, ZIndex = 12
    }, setPanel)
    makeCorner(b, 5)
    local lbl = newInst("TextLabel", {
        Size = UDim2.new(1, -12, 1, 0), Position = UDim2.new(0, 8, 0, 0),
        Text = label .. "  [" .. (Settings[key] and "ON" or "OFF") .. "]",
        Font = Enum.Font.GothamBold, TextSize = 12,
        TextColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 13
    }, b)
    b.MouseButton1Click:Connect(function()
        Settings[key] = not Settings[key]
        lbl.Text = label .. "  [" .. (Settings[key] and "ON" or "OFF") .. "]"
        b.BackgroundColor3 = Settings[key] and (defColor or Color3.fromRGB(0, 150, 100)) or Color3.fromRGB(60, 60, 80)
    end)
    return b, lbl
end
local akContainer, akLbl = makeToggle("🛡️ Anti-Kick PRO", "_AK", Color3.fromRGB(0, 180, 120))
akContainer.MouseButton1Click:Connect(function()
    AK:Toggle(not AK.active)
    akLbl.Text = "🛡️ Anti-Kick PRO (" .. AK.layers .. " слоёв)  [" .. (AK.active and "ON" or "OFF") .. "]"
    akContainer.BackgroundColor3 = AK.active and Color3.fromRGB(0, 180, 120) or Color3.fromRGB(60, 60, 80)
end)
akLbl.Text = "🛡️ Anti-Kick PRO (" .. AK.layers .. " слоёв)  [OFF]"
makeToggle("🤫 Silent Mode", "SilentMode", Color3.fromRGB(80, 40, 120))
makeToggle("🔄 Auto-Scan", "AutoScan", Color3.fromRGB(0, 130, 180))
makeToggle("🔒 Deep Access (ReplicatedFirst/etc)", "DeepAccess", Color3.fromRGB(140, 60, 180))
scanBtn.MouseButton1Click:Connect(function()
    scanBtn.Text = "🔄 SCANNING..."
    task.spawn(function()
        runFullAnalysis(true)
        refreshExploits(); refreshAnalyzer(); refreshWorkspaceTree()
        scanBtn.Text = "🔄 OK: " .. #DeepData.ExploitList
        task.wait(3); scanBtn.Text = "🔄 SCAN"
    end)
end)
exportBtn.MouseButton1Click:Connect(function()
    exportBtn.Text = "📋 BUILDING..."
    task.spawn(function()
        local report = rebuildReportChunks()
        local n = #DeepData.ReportChunks
        -- Копируем первый кусок сразу, следующие через повторные клики
        if n > 0 then
            copyToClipboard(DeepData.ReportChunks[1])
            DeepData.ReportChunkIndex = 2
        end
        _origPrint("\n════ FULL REPORT (" .. math.floor(#report/1024) .. "KB, " .. n .. " parts) ════\n" .. report)
        if writefile then
            exportBtn.Text = "✅ 1/" .. n .. " → file+clip"
        else
            exportBtn.Text = "✅ COPIED 1/" .. n .. " (click for next)"
        end
        task.wait(4)
        if DeepData.ReportChunkIndex > n then
            exportBtn.Text = "📋 EXPORT"
        else
            exportBtn.Text = "📤 NEXT " .. DeepData.ReportChunkIndex .. "/" .. n
        end
    end)
end)
-- Дополнительная кнопка: правый клик или повторный клик → следующий кусок
exportBtn.MouseButton2Click:Connect(function()
    local n = #DeepData.ReportChunks
    if n == 0 then exportBtn.Text = "⚠️ EXPORT FIRST"; task.wait(2); exportBtn.Text = "📋 EXPORT"; return end
    local idx = DeepData.ReportChunkIndex
    if idx > n then idx = 1 end
    copyToClipboard(DeepData.ReportChunks[idx])
    exportBtn.Text = "✅ " .. idx .. "/" .. n .. " copied"
    DeepData.ReportChunkIndex = idx + 1
    task.wait(3)
    if DeepData.ReportChunkIndex > n then
        exportBtn.Text = "📋 DONE (RMB=restart)"
    else
        exportBtn.Text = "📤 NEXT " .. DeepData.ReportChunkIndex .. "/" .. n
    end
end)
execAllBtn.MouseButton1Click:Connect(function()
    execAllBtn.Text = "🔥 FIRING..."
    task.spawn(function()
        local count = 0
        for _, exp in ipairs(DeepData.ExploitList) do
            task.spawn(function() pcall(function() executeExploit(exp) end) end)
            count = count + 1
            task.wait(0.03)
        end
        execAllBtn.Text = "✅ " .. count
        task.wait(3); execAllBtn.Text = "🔥 EXEC ALL"
    end)
end)
task.spawn(function()
    runFullAnalysis(true)
    refreshExploits(); refreshAnalyzer(); refreshWorkspaceTree()
end)
task.spawn(function()
    while true do
        task.wait(Settings.ScanInterval)
        if Settings.AutoScan then
            pcall(function() runFullAnalysis() end)
            if tabPanels.exploits.Visible then pcall(refreshExploits) end
            if tabPanels.analyzer.Visible then pcall(refreshAnalyzer) end
        end
    end
end)
task.spawn(function()
    while true do
        task.wait(2)
        if tabPanels.spy and tabPanels.spy.Visible then pcall(refreshSpy) end
    end
end)
local function unloadAll()
    AK.active = false; AK.installed = false
    RemoteSpy.active = false
    for _, c in pairs(connections) do pcall(function() if c.Disconnect then c:Disconnect() end end) end
    for _, c in pairs(AK.hooks) do pcall(function() if c.Disconnect then c:Disconnect() end end) end
    if sg and sg.Parent then sg:Destroy() end
    warn = _origWarn; print = _origPrint
    _G.GameAnalyzerPro = nil
end
_G.GameAnalyzerPro.Unload = unloadAll
unloadBtn.MouseButton1Click:Connect(unloadAll)
warn("[GameAnalyzer v3.0 MEGA DEEP] ✅ Загружен!")
warn("[v3] 🔄 SCAN — глубокий анализ (getinstances/getnilinstances/getloadedmodules/require дампы/decompile всех LocalScript'ов)")
warn("[v3] 📋 EXPORT — левый клик: 1-я часть отчёта в буфер + файл GameAnalyzer_Report.txt")
warn("[v3] 📤 EXPORT — правый клик: следующая часть отчёта (для длинных дампов)")
warn("[v3] Отчёт содержит реальный код игры + все секреты (webhooks/keys/passwords/admin lists)")
