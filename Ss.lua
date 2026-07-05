warn("[GameAnalyzer v1.0] === СКРИПТ ЗАПУЩЕН ===")
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
local _getconn = rawget(getfenv(), "getconnections")
local _setreadonly = rawget(getfenv(), "setreadonly")
local _getrawmt = rawget(getfenv(), "getrawmetatable")
local _newcclosure = rawget(getfenv(), "newcclosure")
local _gethui = rawget(getfenv(), "gethui")
local _identify = rawget(getfenv(), "identifyexecutor")
local _setclipboard = rawget(getfenv(), "setclipboard")
local _fireproximityprompt = rawget(getfenv(), "fireproximityprompt")
local _fireclickdetector = rawget(getfenv(), "fireclickdetector")
hookfunction = _hookfn
hookmetamethod = _hookmm
getgc = _getgc
getreg = _getreg
getupvalues = _getupvalues
getconnections = _getconn
setreadonly = _setreadonly
getrawmetatable = _getrawmt
newcclosure = _newcclosure
gethui = _gethui
fireproximityprompt = _fireproximityprompt
fireclickdetector = _fireclickdetector
local Settings = {
    SilentMode = false,
    AutoScan = true,
    ScanInterval = 60,
    DetectAntiCheat = true,
}
local DeepData = {
    CombatRemotes = {}, DamageRemotes = {}, WeaponRemotes = {}, BossRemotes = {},
    AbilityRemotes = {}, UnknownRemotes = {}, MoneyRemotes = {}, AdminRemotes = {},
    HealRemotes = {}, TeleportRemotes = {}, ChatRemotes = {}, SpawnRemotes = {},
    KillRemotes = {}, GodRemotes = {}, DeleteRemotes = {}, ExecuteRemotes = {},
    NoclipRemotes = {}, SpeedRemotes = {},
    Bindables = {}, Tools = {}, BossModels = {}, NPCs = {},
    CombatPrompts = {}, ClickDetectors = {},
    AnticheatScripts = {}, AnticheatRemotes = {}, SuspiciousScripts = {},
    GCRemotesFound = {}, GCFunctionsFound = {}, UpvalueRemotes = {}, RegistryFindings = {},
    HighValueRemotes = {}, ExploitList = {},
    AnticheatType = "Unknown",
    MemoryStats = { tables = 0, functions = 0, strings = 0 },
    ScanTime = 0, ScanCount = 0,
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
local KEYWORDS = {
    combat = {"attack","damage","hit","combat","kill","strike","swing","slash","shoot","fire","cast","skill","ability","weapon","hurt","assault","punch","stab","pierce","slay","fight","execute","harm","wound"},
    damage = {"damage","dealdamage","takedamage","dmg","hurt","inflict","harm","apply","reduce","deduct"},
    boss = {"boss","raid","dungeon","miniboss","elite","warlord","captain","overlord","titan","lord","chief","king","queen","commander","general"},
    honey = {"ban","kick","anticheat","ac_","log","report","detect","security","flag","suspicious","validate","verif","sanity","protect","admin","moderat","exploit","hack","cheat"},
    weapon = {"weapon","sword","gun","blade","axe","bow","staff","spear","hammer","knife","dagger","katana","tool"},
    bindable = {"die","dead","kill","damage","death","defeat","expire","perish","destroy","despawn","died","killed"},
    ability = {"ability","skill","cast","spell","power","special","ultimate","move","technique","use","activate","trigger"},
    money = {"money","cash","coin","gold","gem","credit","currency","give","reward","bux","robux","dollar","balance","wallet","bank","pay","purchase","buy"},
    admin = {"admin","staff","developer","dev","owner","gm","gamemaster","moderator","cmd","command","console"},
    heal = {"heal","regen","restore","cure","revive","respawn","resurrect","medic","recover","refresh"},
    teleport = {"teleport","tp","bring","goto","warp","travel","move","summon"},
    chat = {"chat","message","say","talk","announce","speak","broadcast"},
    spawn = {"spawn","summon","create","instantiate","make","give","grant"},
    god = {"god","invulnerable","immortal","immune","invincible","shield","forcefield","protect"},
    delete = {"delete","destroy","wipe","clearall","remove","kill","kick","clear"},
    execute = {"execute","runcode","dostring","loadcode","loadstring","evalstring","runscript","injector"},
    kick = {"kick","ban","punish","report","suspend","moderat"},
    noclip = {"noclip","phase","collide","ghost","passthrough"},
    speed = {"speed","walkspeed","velocity","fast","boost","dash","run"},
    kill_all = {"killall","wipeall","clearall","tpsall","masskill"},
    instant = {"instakill","onehit","oneshot","execute","finish","assassinate"},
    critical_effect = {"deletemap","wipemap","cleargame","resetserver","shutdownserver","kickall","banall"},
}
local function scoreVuln(nm, fnm)
    local s = 0
    local fullPath = nm .. "|" .. fnm
    if matchAny(nm, KEYWORDS.critical_effect) then s = s + 100 end
    if matchAny(nm, KEYWORDS.instant) then s = s + 60 end
    if matchAny(nm, KEYWORDS.execute) then s = s + 80 end
    if matchAny(nm, KEYWORDS.admin) then s = s + 50 end
    if matchAny(nm, KEYWORDS.money) then s = s + 40 end
    if matchAny(nm, KEYWORDS.kill_all) then s = s + 70 end
    if matchAny(nm, KEYWORDS.damage) then s = s + 30 end
    if matchAny(nm, KEYWORDS.god) then s = s + 40 end
    if matchAny(nm, KEYWORDS.teleport) then s = s + 25 end
    if matchAny(nm, KEYWORDS.combat) then s = s + 15 end
    if matchAny(nm, KEYWORDS.ability) then s = s + 10 end
    if nm:find("client") then s = s - 20 end
    if nm:find("server") then s = s + 10 end
    if matchAny(fnm, KEYWORDS.combat) then s = s + 5 end
    if matchAny(fullPath, KEYWORDS.honey) then s = -100 end
    return s
end
local function classifyExploit(rem)
    local nm = safeLower(rem.Name)
    local fnm = rem.Parent and safeLower(rem.Parent.Name) or ""
    local effect = "UNKNOWN"
    local effectIcon = "❓"
    local risk = "MEDIUM"
    local suggestedArgs = { {rem}, {lp}, {lp.Name} }
    if matchAny(nm, KEYWORDS.critical_effect) then
        if nm:find("map") or nm:find("world") then
            effect = "DELETE MAP"; effectIcon = "🗺️"; risk = "CRITICAL"
        elseif nm:find("killall") or nm:find("wipeall") then
            effect = "KILL ALL PLAYERS"; effectIcon = "💀"; risk = "CRITICAL"
        elseif nm:find("shutdown") or nm:find("reset") then
            effect = "SHUTDOWN SERVER"; effectIcon = "🔌"; risk = "CRITICAL"
        else
            effect = "MASS EFFECT"; effectIcon = "☢️"; risk = "CRITICAL"
        end
        suggestedArgs = { {}, {"all"}, {ws} }
    elseif matchAny(nm, KEYWORDS.money) then
        effect = "GET MONEY/RESOURCE"; effectIcon = "💰"; risk = "HIGH"
        suggestedArgs = { {lp, math.huge}, {math.huge}, {lp.Name, 999999999}, {"give", lp.Name, "money", math.huge} }
    elseif matchAny(nm, KEYWORDS.god) then
        effect = "GOD MODE"; effectIcon = "🛡️"; risk = "HIGH"
        suggestedArgs = { {lp, true}, {true}, {lp.Name, true} }
    elseif matchAny(nm, KEYWORDS.admin) then
        effect = "ADMIN ACCESS"; effectIcon = "👑"; risk = "CRITICAL"
        suggestedArgs = { {lp}, {lp.Name}, {"admin", lp.Name} }
    elseif matchAny(nm, KEYWORDS.execute) then
        effect = "REMOTE CODE EXEC"; effectIcon = "🚨"; risk = "CRITICAL"
        suggestedArgs = { {"print('found via GameAnalyzer')"}, {"local p=game.Players.LocalPlayer;print(p.Name)"} }
    elseif matchAny(nm, KEYWORDS.teleport) then
        effect = "TELEPORT"; effectIcon = "📍"; risk = "MEDIUM"
        suggestedArgs = { {lp, Vector3.new(0, 50, 0)}, {Vector3.new(0, 50, 0)} }
    elseif matchAny(nm, KEYWORDS.delete) then
        effect = "DELETE OBJECTS"; effectIcon = "🗑️"; risk = "HIGH"
        suggestedArgs = { {}, {"all"} }
    elseif matchAny(nm, KEYWORDS.kick) then
        effect = "KICK/BAN"; effectIcon = "🚫"; risk = "HIGH"
        suggestedArgs = {}
        for _, p in ipairs(plrs:GetPlayers()) do
            if p ~= lp then table.insert(suggestedArgs, {p}); if #suggestedArgs >= 2 then break end end
        end
    elseif matchAny(nm, KEYWORDS.heal) then
        effect = "HEAL/REVIVE"; effectIcon = "💚"; risk = "LOW"
        suggestedArgs = { {lp}, {lp, math.huge} }
    elseif matchAny(nm, KEYWORDS.spawn) then
        effect = "SPAWN ITEM/BOSS"; effectIcon = "✨"; risk = "MEDIUM"
        suggestedArgs = { {lp}, {"Sword"}, {"boss"} }
    elseif matchAny(nm, KEYWORDS.chat) then
        effect = "CHAT/MESSAGE"; effectIcon = "💬"; risk = "LOW"
        suggestedArgs = { {"HELLO"}, {"/e"} }
    elseif matchAny(nm, KEYWORDS.speed) then
        effect = "SPEED"; effectIcon = "💨"; risk = "LOW"
        suggestedArgs = { {lp, 999}, {999} }
    elseif matchAny(nm, KEYWORDS.noclip) then
        effect = "NOCLIP"; effectIcon = "👻"; risk = "LOW"
        suggestedArgs = { {lp, false}, {false} }
    elseif matchAny(nm, KEYWORDS.damage) then
        effect = "DAMAGE ENTITY"; effectIcon = "⚔️"; risk = "MEDIUM"
        suggestedArgs = { {math.huge}, {lp, math.huge} }
    elseif matchAny(nm, KEYWORDS.combat) then
        effect = "COMBAT ACTION"; effectIcon = "⚔️"; risk = "MEDIUM"
        suggestedArgs = { {}, {lp} }
    elseif matchAny(nm, KEYWORDS.boss) then
        effect = "BOSS INTERACT"; effectIcon = "👹"; risk = "HIGH"
        suggestedArgs = { {math.huge}, {"kill"} }
    end
    return {
        remote = rem, path = rem:GetFullName(), class = rem.ClassName,
        risk = risk, effect = effect, effectIcon = effectIcon,
        suggestedArgs = suggestedArgs, source = "AutoClass",
        name = rem.Name,
    }
end
local function indexRemote(obj)
    if not obj then return end
    pcall(function()
        local cls = obj.ClassName
        local nm = safeLower(obj.Name)
        local fnm = obj.Parent and safeLower(obj.Parent.Name) or ""
        local fullPath = nm .. "|" .. fnm
        if cls == "RemoteEvent" or cls == "RemoteFunction" then
            if matchAny(fullPath, KEYWORDS.honey) then
                safeInsert(DeepData.AnticheatRemotes, obj)
                return
            end
            local score = scoreVuln(nm, fnm)
            if score >= 40 then safeInsert(DeepData.HighValueRemotes, obj) end
            local matched = false
            for _, cat in ipairs({
                {"combat", "CombatRemotes"}, {"damage", "DamageRemotes"},
                {"boss", "BossRemotes"}, {"ability", "AbilityRemotes"},
                {"money", "MoneyRemotes"}, {"admin", "AdminRemotes"},
                {"heal", "HealRemotes"}, {"teleport", "TeleportRemotes"},
                {"chat", "ChatRemotes"}, {"spawn", "SpawnRemotes"},
                {"god", "GodRemotes"}, {"delete", "DeleteRemotes"},
                {"execute", "ExecuteRemotes"}, {"noclip", "NoclipRemotes"},
                {"speed", "SpeedRemotes"}, {"kick", "KillRemotes"},
            }) do
                if matchAny(fullPath, KEYWORDS[cat[1]]) then
                    safeInsert(DeepData[cat[2]], obj)
                    matched = true
                end
            end
            if not matched then safeInsert(DeepData.UnknownRemotes, obj) end
        elseif cls == "Tool" then
            for _, r in ipairs(obj:GetDescendants()) do
                if r:IsA("RemoteEvent") or r:IsA("RemoteFunction") then safeInsert(DeepData.WeaponRemotes, r) end
            end
            safeInsert(DeepData.Tools, obj)
        elseif cls == "BindableEvent" or cls == "BindableFunction" then
            if matchAny(nm, KEYWORDS.bindable) then safeInsert(DeepData.Bindables, obj) end
        elseif cls == "LocalScript" or cls == "Script" or cls == "ModuleScript" then
            if matchAny(fullPath, KEYWORDS.honey) then safeInsert(DeepData.AnticheatScripts, obj) end
            pcall(function()
                if obj.Source and type(obj.Source) == "string" then
                    local src = obj.Source:lower()
                    if src:find("loadstring") or src:find("getfenv%(") then
                        safeInsert(DeepData.SuspiciousScripts, obj)
                    end
                end
            end)
        elseif cls == "ProximityPrompt" then
            local pnm = safeLower(obj.ObjectText or "") .. "|" .. safeLower(obj.ActionText or "")
            if matchAny(pnm, KEYWORDS.combat) or matchAny(pnm, KEYWORDS.money) then
                safeInsert(DeepData.CombatPrompts, obj)
            end
        elseif cls == "ClickDetector" then
            safeInsert(DeepData.ClickDetectors, obj)
        end
    end)
end
local function scanForBosses()
    DeepData.BossModels = {}
    DeepData.NPCs = {}
    for _, m in ipairs(ws:GetDescendants()) do
        if m:IsA("Model") and m ~= lp.Character and not plrs:GetPlayerFromCharacter(m) then
            pcall(function()
                local h = m:FindFirstChildOfClass("Humanoid")
                if not h then return end
                local nm = safeLower(m.Name)
                local isBoss = matchAny(nm, KEYWORDS.boss) or m:GetAttribute("Boss") or m:GetAttribute("IsBoss") or (h.MaxHealth >= 1000)
                if isBoss then safeInsert(DeepData.BossModels, m) end
                safeInsert(DeepData.NPCs, m)
            end)
        end
    end
end
local function detectAnticheatType()
    DeepData.AnticheatType = "Unknown"
    local knownACs = {
        {"antiexploit", "AntiExploit"}, {"kohl", "Kohl's Admin"},
        {"hydroxide", "Hydroxide"}, {"cerebrus", "Cerebrus"},
        {"vermilion", "Vermilion"}, {"eremito", "Eremito"},
        {"stronghold", "Stronghold"}, {"sentinel", "Sentinel"},
        {"guard", "GuardV3"}, {"anticheat", "Generic AC"},
    }
    for _, s in ipairs(DeepData.AnticheatScripts) do
        pcall(function()
            local nm = safeLower(s.Name)
            for _, ac in ipairs(knownACs) do
                if nm:find(ac[1]) then DeepData.AnticheatType = ac[2]; return end
            end
        end)
    end
    if DeepData.AnticheatType == "Unknown" and #DeepData.AnticheatScripts > 0 then
        DeepData.AnticheatType = "Generic (" .. #DeepData.AnticheatScripts .. " scripts)"
    end
end
local ScanState = { running = false }
local function scanGarbageCollector()
    if not getgc then return end
    if ScanState.running then return end
    ScanState.running = true
    task.spawn(function()
        pcall(function()
            DeepData.GCRemotesFound = {}
            DeepData.GCFunctionsFound = {}
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
                                if src:find("combat") or src:find("damage") or src:find("weapon") or src:find("money") or src:find("admin") then
                                    safeInsert(DeepData.GCFunctionsFound, obj)
                                end
                            end
                        end
                    end)
                end
                if i % BATCH == 0 then task.wait() end
                if i > 40000 then break end
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
            local BATCH = 100
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
                if i > 20000 then break end
            end
        end)
    end)
end
local function buildExploitList()
    DeepData.ExploitList = {}
    local seen = {}
    local function add(rem)
        if not rem or seen[rem] then return end
        seen[rem] = true
        pcall(function() table.insert(DeepData.ExploitList, classifyExploit(rem)) end)
    end
    for _, cat in ipairs({"MoneyRemotes","AdminRemotes","GodRemotes","ExecuteRemotes",
        "TeleportRemotes","KillRemotes","DeleteRemotes","HealRemotes","SpawnRemotes",
        "ChatRemotes","SpeedRemotes","NoclipRemotes","BossRemotes","DamageRemotes",
        "CombatRemotes","HighValueRemotes","AbilityRemotes"}) do
        for _, r in ipairs(DeepData[cat]) do add(r) end
    end
    for _, r in ipairs(DeepData.GCRemotesFound) do add(r) end
    for _, r in ipairs(DeepData.UpvalueRemotes) do add(r) end
    table.sort(DeepData.ExploitList, function(a, b)
        local order = { CRITICAL = 4, HIGH = 3, MEDIUM = 2, LOW = 1 }
        return (order[a.risk] or 0) > (order[b.risk] or 0)
    end)
end
local LastScanTime = 0
local function runFullAnalysis(force)
    local now = tick()
    if not force and (now - LastScanTime) < 20 then
        warn("[ANALYZER] Skip — прошло меньше 20 сек")
        return
    end
    LastScanTime = now
    DeepData.ScanCount = DeepData.ScanCount + 1
    for k, v in pairs(DeepData) do
        if type(v) == "table" and k ~= "MemoryStats" then
            DeepData[k] = {}
        end
    end
    DeepData.AnticheatType = "Unknown"
    local sources = {rep, ws, game:GetService("StarterPack"), game:GetService("StarterGui"), game:GetService("StarterPlayer")}
    for _, s in ipairs(sources) do
        pcall(function() for _, o in ipairs(s:GetDescendants()) do indexRemote(o) end end)
    end
    for _, p in ipairs(plrs:GetPlayers()) do
        local bp = p:FindFirstChild("Backpack")
        if bp then for _, o in ipairs(bp:GetDescendants()) do indexRemote(o) end end
    end
    scanForBosses()
    detectAnticheatType()
    scanGarbageCollector()
    scanUpvalues()
    task.wait(1)
    buildExploitList()
    DeepData.ScanTime = tick() - now
    warn("╔═══════════════════════════════════════╗")
    warn("║ 🔬 GAME ANALYZER v1 — SCAN #" .. DeepData.ScanCount .. " (" .. math.floor(DeepData.ScanTime*10)/10 .. "s)")
    warn("╠═══════════════════════════════════════╣")
    warn(string.format("║ 🚪 Total exploits found: %d", #DeepData.ExploitList))
    warn(string.format("║ 💰 Money: %d  |  👑 Admin: %d  |  🛡️ God: %d",
        #DeepData.MoneyRemotes, #DeepData.AdminRemotes, #DeepData.GodRemotes))
    warn(string.format("║ 🚨 Execute: %d  |  📍 TP: %d  |  💀 Kill: %d",
        #DeepData.ExecuteRemotes, #DeepData.TeleportRemotes, #DeepData.KillRemotes))
    warn(string.format("║ ⚔️ Combat: %d  |  👹 Boss: %d  |  ❓ Unknown: %d",
        #DeepData.CombatRemotes, #DeepData.BossRemotes, #DeepData.UnknownRemotes))
    warn(string.format("║ 🎭 AntiCheat: %s (%d scripts)", DeepData.AnticheatType, #DeepData.AnticheatScripts))
    warn("╚═══════════════════════════════════════╝")
end
ws.DescendantAdded:Connect(function(obj) if obj then indexRemote(obj) end end)
rep.DescendantAdded:Connect(function(obj) if obj then indexRemote(obj) end end)
local function executeExploit(exp)
    if not exp or not exp.remote or not exp.remote.Parent then return false, "no remote" end
    local rem = exp.remote
    local fired = 0
    for _, args in ipairs(exp.suggestedArgs or {{}}) do
        pcall(function()
            if type(args) == "table" then
                if rem:IsA("RemoteEvent") then rem:FireServer(unpack(args)); fired = fired + 1
                elseif rem:IsA("RemoteFunction") then task.spawn(function() pcall(function() rem:InvokeServer(unpack(args)) end) end); fired = fired + 1 end
            else
                if rem:IsA("RemoteEvent") then rem:FireServer(args); fired = fired + 1
                elseif rem:IsA("RemoteFunction") then task.spawn(function() pcall(function() rem:InvokeServer(args) end) end); fired = fired + 1 end
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
    print("[🛡️ AK v1] Installing FE-safe Anti-Kick...")
    if hookfunction then
        pcall(function()
            local orig
            orig = hookfunction(lp.Kick, function(...)
                if AK.active then AK.blocked = AK.blocked + 1; warn("[🛡️ L1] Kick #" .. AK.blocked .. " blocked"); return end
                return orig(...)
            end)
            AK.layers = AK.layers + 1; print("[🛡️ L1] hookfunction(lp.Kick) OK")
        end)
    end
    if getrawmetatable and setreadonly then
        pcall(function()
            local mt = getrawmetatable(lp)
            setreadonly(mt, false)
            local oldIndex = mt.__index
            local newIndex = function(s, k)
                if AK.active and k == "Kick" and typeof(s) == "Instance" and s:IsA("Player") then
                    return function() AK.blocked = AK.blocked + 1; warn("[🛡️ L2] Kick #" .. AK.blocked .. " intercepted") end
                end
                if type(oldIndex) == "function" then return oldIndex(s, k) end
                return oldIndex[k]
            end
            mt.__index = newcclosure and newcclosure(newIndex) or newIndex
            setreadonly(mt, true)
            AK.layers = AK.layers + 1; print("[🛡️ L2] metatable __index OK")
        end)
    end
    pcall(function()
        local count = 0
        local function scanFor(cont)
            for _, r in ipairs(cont:GetDescendants()) do
                if r:IsA("RemoteEvent") and isBanRemote(r) then
                    if getconnections then
                        pcall(function()
                            for _, c in ipairs(getconnections(r.OnClientEvent)) do
                                pcall(function() c:Disable() end)
                                count = count + 1
                            end
                        end)
                    end
                    table.insert(AK.hooks, r.OnClientEvent:Connect(function()
                        if AK.active then AK.blocked = AK.blocked + 1; warn("[🛡️ L3] Ban-remote blocked:", r.Name) end
                    end))
                end
            end
        end
        scanFor(rep); scanFor(ws)
        AK.layers = AK.layers + 1; print("[🛡️ L3] Ban-remote connections killed: " .. count)
    end)
    pcall(function()
        connections["ak_desc_watch"] = ws.DescendantAdded:Connect(function(obj)
            if AK.active and obj:IsA("RemoteEvent") and isBanRemote(obj) then
                pcall(function()
                    table.insert(AK.hooks, obj.OnClientEvent:Connect(function()
                        AK.blocked = AK.blocked + 1
                        warn("[🛡️ L4] Runtime ban-remote blocked:", obj.Name)
                    end))
                end)
            end
        end)
        AK.layers = AK.layers + 1; print("[🛡️ L4] Runtime ban-remote watcher OK")
    end)
    pcall(function()
        if hookfunction then
            local TeleportService = game:GetService("TeleportService")
            local origT
            origT = hookfunction(TeleportService.Teleport, function(self, ...)
                if AK.active then AK.blocked = AK.blocked + 1; warn("[🛡️ L5] TeleportService:Teleport blocked"); return end
                return origT(self, ...)
            end)
            AK.layers = AK.layers + 1; print("[🛡️ L5] TeleportService:Teleport hooked")
        end
    end)
    pcall(function()
        connections["ak_player_removing"] = plrs.PlayerRemoving:Connect(function(p)
            if AK.active and p == lp then
                AK.blocked = AK.blocked + 1
                warn("[🛡️ L6] CRITICAL: PlayerRemoving для НАС!")
            end
        end)
        AK.layers = AK.layers + 1; print("[🛡️ L6] PlayerRemoving watcher OK")
    end)
    pcall(function()
        connections["ak_gui_watch"] = task.spawn(function()
            while AK.installed do
                if AK.active then
                    pcall(function()
                        local pg = lp:FindFirstChildOfClass("PlayerGui")
                        if not pg then return end
                        for _, g in ipairs(pg:GetDescendants()) do
                            if g:IsA("Frame") and g.Size == UDim2.new(1,0,1,0) and g.BackgroundTransparency < 0.4 then
                                local nm = safeLower(g.Name)
                                if nm:find("kick") or nm:find("ban") or nm:find("block") or nm:find("overlay") then
                                    pcall(function() g:Destroy() end)
                                    AK.blocked = AK.blocked + 1
                                    warn("[🛡️ L7] Fullscreen overlay killed:", nm)
                                end
                            end
                            if g:IsA("TextLabel") then
                                local t = safeLower(g.Text or "")
                                if t:find("kicked") or t:find("banned") or t:find("disconnect") or t:find("detected") then
                                    local sg = g:FindFirstAncestorOfClass("ScreenGui")
                                    if sg then pcall(function() sg:Destroy() end); warn("[🛡️ L7] Kick-text GUI destroyed") end
                                    AK.blocked = AK.blocked + 1
                                end
                            end
                        end
                    end)
                end
                task.wait(0.3)
            end
        end)
        AK.layers = AK.layers + 1; print("[🛡️ L7] PlayerGui overlay killer OK")
    end)
    pcall(function()
        local Lighting = game:GetService("Lighting")
        connections["ak_blur_watch"] = Lighting.DescendantAdded:Connect(function(obj)
            if AK.active and (obj:IsA("BlurEffect") or obj:IsA("ColorCorrectionEffect")) then
                task.wait(0.1)
                local nm = safeLower(obj.Name)
                if nm:find("kick") or nm:find("ban") or nm:find("dark") or nm:find("dim") then
                    pcall(function() obj:Destroy() end)
                    warn("[🛡️ L8] Blur/dim effect destroyed:", obj.Name)
                    AK.blocked = AK.blocked + 1
                end
            end
        end)
        AK.layers = AK.layers + 1; print("[🛡️ L8] Lighting blur/dim watcher OK")
    end)
    pcall(function()
        local StarterGui = game:GetService("StarterGui")
        connections["ak_topbar"] = task.spawn(function()
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
        AK.layers = AK.layers + 1; print("[🛡️ L9] Topbar/CoreGui forced ON")
    end)
    pcall(function()
        local sc = game:GetService("ScriptContext")
        connections["ak_script_error"] = sc.Error:Connect(function(msg, trace, script)
            if AK.active and msg then
                local lm = tostring(msg):lower()
                if lm:find("kick") or lm:find("ban") or lm:find("disconnect") then
                    warn("[🛡️ L10] Script error caught: " .. msg:sub(1,60))
                    AK.blocked = AK.blocked + 1
                end
            end
        end)
        AK.layers = AK.layers + 1; print("[🛡️ L10] ScriptContext.Error watcher OK")
    end)
    print("[🛡️ ANTI-KICK v1] Установлено " .. AK.layers .. " слоёв защиты!")
end
function AK:Toggle(state)
    self.active = state
    if state and not self.installed then self:Install() end
    print("[🛡️ AK] " .. (state and ("🟢 АКТИВЕН — " .. self.layers .. " слоёв | заблокировано: " .. self.blocked) or "🔴 OFF"))
end
local function newInst(class, props, parent)
    local o = Instance.new(class)
    if props then for k, v in pairs(props) do pcall(function() o[k] = v end) end end
    if parent then pcall(function() o.Parent = parent end) end
    return o
end
local function makeCorner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = p
end
local function stealthName()
    local list = { "PlayerListGui", "ChatModule", "SystemUI", "TopBarUI", "MessageBox", "CoreGuiExt", "PromptModule", "InputHandler" }
    return list[math.random(1, #list)] .. "_" .. tostring(math.random(1000, 9999))
end
local sg = newInst("ScreenGui", { Name = stealthName(), ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999999, Enabled = true })
local parented = false
pcall(function() if gethui then sg.Parent = gethui(); parented = true end end)
if not parented then pcall(function() sg.Parent = game:GetService("CoreGui"); parented = (sg.Parent ~= nil) end) end
if not parented then pcall(function() sg.Parent = lp:WaitForChild("PlayerGui", 5); parented = true end) end
if not parented then warn("[v1] ❌ GUI PARENT FAIL"); return end
warn("[v1] ✅ GUI parent: " .. tostring(sg.Parent))
local mf = newInst("Frame", {
    Size = UDim2.new(0, 500, 0, 560),
    Position = UDim2.new(0, 20, 0, 60),
    BackgroundColor3 = Color3.fromRGB(18, 18, 24),
    BorderSizePixel = 0, Active = true, Draggable = true, Visible = true, ZIndex = 10
}, sg)
makeCorner(mf, 10)
newInst("UIStroke", { Color = Color3.fromRGB(80, 80, 100), Thickness = 2, Transparency = 0.3 }, mf)
local title = newInst("TextLabel", {
    Size = UDim2.new(1, -70, 0, 32),
    Text = "  🔬 GAME ANALYZER v1.0",
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
        mf:TweenSize(UDim2.new(0,500,0,34), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        minBtn.Text = "+"
        for _,v in ipairs(mf:GetChildren()) do
            if v:IsA("GuiObject") and v~=title and v~=minBtn and v~=unloadBtn then v.Visible=false end
        end
    else
        mf:TweenSize(UDim2.new(0,500,0,560), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        minBtn.Text = "-"
        for _,v in ipairs(mf:GetChildren()) do
            if v:IsA("GuiObject") and v~=title and v~=minBtn and v~=unloadBtn then v.Visible=true end
        end
    end
end)
local actF = newInst("Frame", {
    Size = UDim2.new(1, -12, 0, 42), Position = UDim2.new(0, 6, 0, 38),
    BackgroundTransparency = 1, ZIndex = 11
}, mf)
local scanBtn = newInst("TextButton", {
    Size = UDim2.new(0.48, -3, 1, 0), Position = UDim2.new(0, 0, 0, 0),
    Text = "🔄 FULL SCAN", Font = Enum.Font.GothamBold, TextSize = 13,
    TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(0, 140, 180),
    BorderSizePixel = 0, ZIndex = 12
}, actF)
makeCorner(scanBtn, 6)
local execAllBtn = newInst("TextButton", {
    Size = UDim2.new(0.48, -3, 1, 0), Position = UDim2.new(0.52, 0, 0, 0),
    Text = "🔥 EXEC ALL", Font = Enum.Font.GothamBold, TextSize = 13,
    TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(180, 40, 40),
    BorderSizePixel = 0, ZIndex = 12
}, actF)
makeCorner(execAllBtn, 6)
local tabBar = newInst("Frame", {
    Size = UDim2.new(1, -12, 0, 28), Position = UDim2.new(0, 6, 0, 84),
    BackgroundTransparency = 1, ZIndex = 11
}, mf)
local tabPanels = {}
local curTab = "exploits"
local tabButtons = {}
local function makeTabBtn(id, label, x, w)
    local b = newInst("TextButton", {
        Size = UDim2.new(w, -3, 1, 0), Position = UDim2.new(x, 0, 0, 0),
        Text = label, Font = Enum.Font.GothamBold, TextSize = 11,
        TextColor3 = Color3.fromRGB(255,255,255),
        BackgroundColor3 = (id == curTab) and Color3.fromRGB(60, 100, 140) or Color3.fromRGB(45, 45, 55),
        BorderSizePixel = 0, ZIndex = 12
    }, tabBar)
    makeCorner(b, 5)
    tabButtons[id] = b
    b.MouseButton1Click:Connect(function()
        curTab = id
        for pid, p in pairs(tabPanels) do p.Visible = (pid == id) end
        for tid, tb in pairs(tabButtons) do
            tb.BackgroundColor3 = (tid == id) and Color3.fromRGB(60, 100, 140) or Color3.fromRGB(45, 45, 55)
        end
    end)
end
makeTabBtn("exploits", "🚪 Эксплоиты", 0, 0.28)
makeTabBtn("workspace", "📊 Workspace", 0.28, 0.28)
makeTabBtn("analyzer", "🔬 Анализ", 0.56, 0.22)
makeTabBtn("settings", "⚙️ Настр", 0.78, 0.22)
local panelArea = newInst("Frame", {
    Size = UDim2.new(1, -12, 1, -122), Position = UDim2.new(0, 6, 0, 116),
    BackgroundTransparency = 1, ZIndex = 11
}, mf)
local expPanel = newInst("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = true, ZIndex = 11 }, panelArea)
tabPanels.exploits = expPanel
local expInfo = newInst("TextLabel", {
    Size = UDim2.new(1, -4, 0, 18), BackgroundTransparency = 1,
    Text = "  🚪 Найдено: 0 эксплоитов | Тапни для execute",
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
    expInfo.Text = "  🚪 Найдено: " .. #DeepData.ExploitList .. " эксплоитов | Тапни для execute"
    if #DeepData.ExploitList == 0 then
        local lbl = newInst("TextLabel", {
            Size = UDim2.new(1, -8, 0, 40), BackgroundTransparency = 1,
            Text = "  Нажми FULL SCAN чтобы найти эксплоиты",
            Font = Enum.Font.SourceSans, TextSize = 11,
            TextColor3 = Color3.fromRGB(180,180,180), TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true, ZIndex = 12
        }, expScroll)
        return
    end
    for i, exp in ipairs(DeepData.ExploitList) do
        local col = Color3.fromRGB(80,80,100)
        if exp.risk == "CRITICAL" then col = Color3.fromRGB(180,40,40)
        elseif exp.risk == "HIGH" then col = Color3.fromRGB(180,120,40)
        elseif exp.risk == "MEDIUM" then col = Color3.fromRGB(150,150,40) end
        local btn = newInst("TextButton", {
            Size = UDim2.new(1, -8, 0, 42), Text = "",
            BackgroundColor3 = col, AutoButtonColor = true,
            BorderSizePixel = 0, LayoutOrder = i, ZIndex = 12
        }, expScroll)
        makeCorner(btn, 4)
        local effectLbl = newInst("TextLabel", {
            Size = UDim2.new(1, -8, 0, 16), Position = UDim2.new(0, 5, 0, 2),
            Text = exp.effectIcon .. " " .. exp.effect .. "  [" .. exp.risk .. "]",
            Font = Enum.Font.GothamBold, TextSize = 11,
            TextColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 13
        }, btn)
        local nameLbl = newInst("TextLabel", {
            Size = UDim2.new(1, -8, 0, 12), Position = UDim2.new(0, 5, 0, 17),
            Text = exp.name .. "  (" .. exp.class .. ")",
            Font = Enum.Font.SourceSans, TextSize = 10,
            TextColor3 = Color3.fromRGB(230,230,240), BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 13
        }, btn)
        local pathLbl = newInst("TextLabel", {
            Size = UDim2.new(1, -8, 0, 12), Position = UDim2.new(0, 5, 0, 28),
            Text = exp.path:sub(1, 60),
            Font = Enum.Font.SourceSans, TextSize = 9,
            TextColor3 = Color3.fromRGB(180,200,220), BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 13
        }, btn)
        btn.MouseButton1Click:Connect(function()
            local origColor = btn.BackgroundColor3
            btn.BackgroundColor3 = Color3.fromRGB(255,200,100)
            executeExploit(exp)
            task.wait(0.5)
            btn.BackgroundColor3 = origColor
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
    elseif cls == "Part" or cls == "BasePart" or cls == "MeshPart" then return "🧊"
    elseif cls == "Script" or cls == "LocalScript" then return "📜"
    elseif cls == "ModuleScript" then return "📘"
    elseif cls == "RemoteEvent" then return "📡"
    elseif cls == "RemoteFunction" then return "📶"
    elseif cls == "BindableEvent" then return "🔔"
    elseif cls == "Tool" then return "🗡️"
    elseif cls == "Humanoid" then return "🚶"
    elseif cls == "NumberValue" or cls == "IntValue" or cls == "StringValue" or cls == "BoolValue" then return "🔢"
    elseif cls == "ClickDetector" then return "🖱️"
    elseif cls == "ProximityPrompt" then return "🎬"
    else return "🔷" end
end
local function refreshWorkspaceTree()
    for _, c in ipairs(wsScroll:GetChildren()) do
        if c:IsA("TextButton") or c:IsA("Frame") then c:Destroy() end
    end
    local function addNode(obj, depth, layoutOrder)
        if not obj then return layoutOrder end
        local prefix = string.rep("  ", depth)
        local expandable = #obj:GetChildren() > 0
        local isExpanded = expandedNodes[obj]
        local arrow = expandable and (isExpanded and "▼" or "▶") or " "
        local icon = iconFor(obj.ClassName)
        local row = newInst("TextButton", {
            Size = UDim2.new(1, -6, 0, 20), Text = "",
            BackgroundColor3 = Color3.fromRGB(30, 30, 40),
            BorderSizePixel = 0, LayoutOrder = layoutOrder, ZIndex = 12
        }, wsScroll)
        makeCorner(row, 3)
        local lbl = newInst("TextLabel", {
            Size = UDim2.new(1, -8, 1, 0), Position = UDim2.new(0, 4, 0, 0),
            Text = prefix .. arrow .. " " .. icon .. " " .. obj.Name .. " [" .. obj.ClassName .. "]",
            Font = Enum.Font.SourceSans, TextSize = 10, TextColor3 = Color3.fromRGB(230, 230, 240),
            BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 13
        }, row)
        layoutOrder = layoutOrder + 1
        row.MouseButton1Click:Connect(function()
            if expandable then
                expandedNodes[obj] = not expandedNodes[obj]
                refreshWorkspaceTree()
            else
                warn("[📊] " .. obj:GetFullName())
                if _setclipboard then pcall(function() _setclipboard(obj:GetFullName()) end) end
            end
        end)
        if expandable and isExpanded then
            for _, child in ipairs(obj:GetChildren()) do
                layoutOrder = addNode(child, depth + 1, layoutOrder)
                if layoutOrder > 150 then return layoutOrder end
            end
        end
        return layoutOrder
    end
    local lo = 1
    lo = addNode(ws, 0, lo)
    lo = addNode(rep, 0, lo)
    lo = addNode(game:GetService("StarterPack"), 0, lo)
    lo = addNode(game:GetService("StarterGui"), 0, lo)
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
        Font = Enum.Font.SourceSansBold, TextSize = 12,
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
    ln("═══ SCAN #" .. DeepData.ScanCount .. " ═══", Color3.fromRGB(150, 255, 200))
    ln(string.format("⏱️ Scan time: %.1fs", DeepData.ScanTime), Color3.fromRGB(200, 200, 200))
    ln(string.format("🎭 AntiCheat: %s", DeepData.AnticheatType), Color3.fromRGB(255, 200, 100))
    ln("", nil)
    ln("═══ EXPLOITS BY EFFECT ═══", Color3.fromRGB(100, 200, 255))
    ln(string.format("💰 Money: %d", #DeepData.MoneyRemotes), Color3.fromRGB(255, 220, 100))
    ln(string.format("👑 Admin: %d", #DeepData.AdminRemotes), Color3.fromRGB(255, 200, 100))
    ln(string.format("🛡️ God: %d", #DeepData.GodRemotes), Color3.fromRGB(100, 200, 255))
    ln(string.format("🚨 Execute: %d", #DeepData.ExecuteRemotes), Color3.fromRGB(255, 100, 100))
    ln(string.format("📍 Teleport: %d", #DeepData.TeleportRemotes), Color3.fromRGB(150, 200, 255))
    ln(string.format("💀 Kill: %d", #DeepData.KillRemotes), Color3.fromRGB(255, 100, 100))
    ln(string.format("💚 Heal: %d", #DeepData.HealRemotes), Color3.fromRGB(100, 255, 150))
    ln(string.format("✨ Spawn: %d", #DeepData.SpawnRemotes), Color3.fromRGB(200, 200, 255))
    ln(string.format("💬 Chat: %d", #DeepData.ChatRemotes), Color3.fromRGB(180, 220, 180))
    ln(string.format("💨 Speed: %d", #DeepData.SpeedRemotes), Color3.fromRGB(200, 255, 200))
    ln(string.format("👻 Noclip: %d", #DeepData.NoclipRemotes), Color3.fromRGB(180, 180, 200))
    ln(string.format("🗑️ Delete: %d", #DeepData.DeleteRemotes), Color3.fromRGB(200, 100, 100))
    ln("", nil)
    ln("═══ COMBAT REMOTES ═══", Color3.fromRGB(100, 200, 255))
    ln(string.format("⚔️ Combat: %d", #DeepData.CombatRemotes), Color3.fromRGB(255, 180, 100))
    ln(string.format("⚔️ Damage: %d", #DeepData.DamageRemotes), Color3.fromRGB(255, 150, 100))
    ln(string.format("👹 Boss: %d", #DeepData.BossRemotes), Color3.fromRGB(200, 100, 200))
    ln(string.format("✨ Ability: %d", #DeepData.AbilityRemotes), Color3.fromRGB(150, 200, 255))
    ln(string.format("🗡️ Weapon: %d", #DeepData.WeaponRemotes), Color3.fromRGB(200, 200, 150))
    ln(string.format("🎯 High-Value: %d", #DeepData.HighValueRemotes), Color3.fromRGB(255, 220, 100))
    ln(string.format("❓ Unknown: %d", #DeepData.UnknownRemotes), Color3.fromRGB(150, 150, 150))
    ln("", nil)
    ln("═══ DEEP SCAN ═══", Color3.fromRGB(200, 150, 255))
    ln(string.format("🔬 GC-Remotes: %d", #DeepData.GCRemotesFound), Color3.fromRGB(200, 150, 255))
    ln(string.format("🔬 Upvalue-Remotes: %d", #DeepData.UpvalueRemotes), Color3.fromRGB(200, 150, 255))
    ln(string.format("🔬 GC-Functions: %d", #DeepData.GCFunctionsFound), Color3.fromRGB(200, 150, 255))
    ln("", nil)
    ln("═══ ANTICHEAT ═══", Color3.fromRGB(255, 100, 100))
    ln(string.format("🛡️ AC-Remotes: %d", #DeepData.AnticheatRemotes), Color3.fromRGB(255, 100, 100))
    ln(string.format("⚠️ AC-Scripts: %d", #DeepData.AnticheatScripts), Color3.fromRGB(255, 100, 100))
    ln(string.format("🚨 Sus-Scripts: %d", #DeepData.SuspiciousScripts), Color3.fromRGB(255, 150, 100))
    ln("", nil)
    ln("═══ WORLD ═══", Color3.fromRGB(150, 255, 200))
    ln(string.format("👹 Boss-Models: %d", #DeepData.BossModels), Color3.fromRGB(200, 100, 200))
    ln(string.format("🚶 NPCs: %d", #DeepData.NPCs), Color3.fromRGB(150, 200, 150))
    ln(string.format("🗡️ Tools: %d", #DeepData.Tools), Color3.fromRGB(150, 200, 150))
    ln(string.format("💀 Bindables: %d", #DeepData.Bindables), Color3.fromRGB(180, 150, 150))
    ln(string.format("🎬 CombatPrompts: %d", #DeepData.CombatPrompts), Color3.fromRGB(150, 200, 200))
    ln(string.format("🖱️ ClickDetectors: %d", #DeepData.ClickDetectors), Color3.fromRGB(150, 200, 200))
end
local setPanel = newInst("Frame", { Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false, ZIndex = 11 }, panelArea)
tabPanels.settings = setPanel
local setList = newInst("UIListLayout", { Padding = UDim.new(0, 6) }, setPanel)
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
        if key == "SilentMode" then
            _origPrint("[⚙️] SilentMode = " .. tostring(Settings[key]))
        end
    end)
    return b
end
makeToggle("🛡️ Anti-Kick PRO (" .. AK.layers .. " слоёв)", "_AntiKick", Color3.fromRGB(0, 180, 120))
local akBtn = setPanel:GetChildren()[#setPanel:GetChildren()]
akBtn.MouseButton1Click:Connect(function()
    AK:Toggle(not AK.active)
    local ll = akBtn:FindFirstChildOfClass("TextLabel")
    ll.Text = "🛡️ Anti-Kick PRO (" .. AK.layers .. " слоёв)  [" .. (AK.active and "ON" or "OFF") .. "]"
    akBtn.BackgroundColor3 = AK.active and Color3.fromRGB(0, 180, 120) or Color3.fromRGB(60, 60, 80)
end)
makeToggle("🤫 Silent Mode (тихие warn/print)", "SilentMode", Color3.fromRGB(80, 40, 120))
makeToggle("🔄 Auto-Scan каждую минуту", "AutoScan", Color3.fromRGB(0, 130, 180))
makeToggle("🔬 Детект античита при скане", "DetectAntiCheat", Color3.fromRGB(140, 60, 180))
scanBtn.MouseButton1Click:Connect(function()
    scanBtn.Text = "🔄 SCANNING..."
    task.spawn(function()
        runFullAnalysis(true)
        refreshExploits()
        refreshAnalyzer()
        refreshWorkspaceTree()
        scanBtn.Text = "🔄 SCAN OK: " .. #DeepData.ExploitList
        task.wait(3)
        scanBtn.Text = "🔄 FULL SCAN"
    end)
end)
execAllBtn.MouseButton1Click:Connect(function()
    execAllBtn.Text = "🔥 EXECUTING..."
    task.spawn(function()
        local count = 0
        for _, exp in ipairs(DeepData.ExploitList) do
            task.spawn(function() pcall(function() executeExploit(exp) end) end)
            count = count + 1
            task.wait(0.03)
        end
        execAllBtn.Text = "✅ FIRED: " .. count
        task.wait(3)
        execAllBtn.Text = "🔥 EXEC ALL"
    end)
end)
task.spawn(function()
    runFullAnalysis(true)
    refreshExploits()
    refreshAnalyzer()
    refreshWorkspaceTree()
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
local function unloadAll()
    AK.active = false; AK.installed = false
    for _, c in pairs(connections) do pcall(function() if c.Disconnect then c:Disconnect() end end) end
    for _, c in pairs(AK.hooks) do pcall(function() if c.Disconnect then c:Disconnect() end end) end
    if sg and sg.Parent then sg:Destroy() end
    warn = _origWarn
    print = _origPrint
    _G.GameAnalyzerPro = nil
end
_G.GameAnalyzerPro.Unload = unloadAll
unloadBtn.MouseButton1Click:Connect(unloadAll)
warn("[GameAnalyzer v1.0] ✅ Загружен!")
