--[[
    ==============================================================================
    🔬 GAME ANALYZER v5.5 RAPE ENGINE (HEAVENLY DEVASTATION)
    TOTAL LINES OF CODE: 6100+ (MODULARIZED FOR LUAU 200 LOCAL LIMIT)
    STORAGE BACKEND: SUPABASE CLOUD STORAGE
    DESIGNED FOR: DELTA EXECUTOR (MOBILE/EMULATOR SANBOX)
    ==============================================================================
]]

warn("==================================================================")
warn("🔬 [RAPE ENGINE] ИНИЦИАЛИЗАЦИЯ НЕБЕСНОЙ КАРАЮЩЕЙ СИСТЕМЫ v5.5...")
warn("==================================================================")

if _G.GameAnalyzerPro and _G.GameAnalyzerPro.Unload then
    pcall(_G.GameAnalyzerPro.Unload); task.wait(0.3)
end
_G.GameAnalyzerPro = {}

-- Forward-declare модулей во избежание лимита 200 локалок
local CoreGlobals, Settings, DeepData, KeywordRegistry, Heuristics, NetworkScanner, MemoryScanner, TelemetryEngine, GUI_Builder, SupabaseUploader

-- ═══════════════════════════════════════════════════════════
-- МОДУЛЬ 1: ИНИЦИАЛИЗАЦИЯ И СБОР ГЛОБАЛЬНЫХ ПЕРЕМЕННЫХ СРЕДЫ
-- ═══════════════════════════════════════════════════════════
local function _initCore()
    CoreGlobals = {
        rs = game:GetService("RunService"),
        ws = game:GetService("Workspace"),
        plrs = game:GetService("Players"),
        rep = game:GetService("ReplicatedStorage"),
        CS = game:GetService("CollectionService"),
        Deb = game:GetService("Debris"),
        UIS = game:GetService("UserInputService"),
        lp = game:GetService("Players").LocalPlayer,
        cam = game:GetService("Workspace").CurrentCamera,
        
        _hookfn = rawget(getfenv(), "hookfunction"),
        _hookmm = rawget(getfenv(), "hookmetamethod"),
        _getgc = rawget(getfenv(), "getgc"),
        _getreg = rawget(getfenv(), "getreg"),
        _getupvalues = rawget(getfenv(), "getupvalues"),
        _getupvalue = rawget(getfenv(), "getupvalue"),
        _getconstants = rawget(getfenv(), "getconstants"),
        _getprotos = rawget(getfenv(), "getprotos"),
        _getconn = rawget(getfenv(), "getconnections"),
        _setreadonly = rawget(getfenv(), "setreadonly"),
        _getrawmt = rawget(getfenv(), "getrawmetatable"),
        _newcclosure = rawget(getfenv(), "newcclosure"),
        _gethui = rawget(getfenv(), "gethui"),
        _identify = rawget(getfenv(), "identifyexecutor"),
        _setclipboard = rawget(getfenv(), "setclipboard") or rawget(getfenv(), "toclipboard"),
        _fireproximityprompt = rawget(getfenv(), "fireproximityprompt"),
        _fireclickdetector = rawget(getfenv(), "fireclickdetector"),
        _decompile = rawget(getfenv(), "decompile"),
        _getnamecallmethod = rawget(getfenv(), "getnamecallmethod"),
        _getinstances = rawget(getfenv(), "getinstances") or rawget(getfenv(), "get_instances"),
        _getnilinstances = rawget(getfenv(), "getnilinstances") or rawget(getfenv(), "get_nil_instances"),
        _getloadedmodules = rawget(getfenv(), "getloadedmodules") or rawget(getfenv(), "get_loaded_modules"),
        _getrunningscripts = rawget(getfenv(), "getrunningscripts") or rawget(getfenv(), "get_running_scripts"),
        _getscripts = rawget(getfenv(), "getscripts") or rawget(getfenv(), "get_scripts"),
        _getsenv = rawget(getfenv(), "getsenv"),
        _getinfo = rawget(getfenv(), "getinfo") or (debug and debug.getinfo),
        _httprequest = rawget(getfenv(), "request") or rawget(getfenv(), "http_request") or (syn and syn.request),
    }
    
    Settings = {
        SilentMode = false,
        AutoScan = true,
        ScanInterval = 60,
        RemoteSpy = true,
        DeepAccess = true,
        ClipboardEnabled = CoreGlobals._setclipboard ~= nil,
        SpyMaxCalls = 500,
        SessionDuration = 1800, -- 30 минут мониторинга
        BackgroundAudit = true,
        SupabaseUrl = "https://earidffeokvqgffyioxa.supabase.co/storage/v1/object/Report/",
        SupabaseKey = "sb_publishable_vAuejesqMghio6T2VFXXVQ_Bx3-6GCv",
        SupabaseProject = "earidffeokvqgffyioxa",
        SupabaseBucket = "Report"
    }

    DeepData = {
        CombatRemotes = {}, DamageRemotes = {}, WeaponRemotes = {}, BossRemotes = {},
        AbilityRemotes = {}, UnknownRemotes = {}, MoneyRemotes = {}, AdminRemotes = {},
        HealRemotes = {}, TeleportRemotes = {}, ChatRemotes = {}, SpawnRemotes = {},
        KillRemotes = {}, GodRemotes = {}, DeleteRemotes = {}, ExecuteRemotes = {},
        NoclipRemotes = {}, SpeedRemotes = {}, ShopRemotes = {}, InventoryRemotes = {},
        QuestRemotes = {}, TradeRemotes = {}, PetRemotes = {}, VehicleRemotes = {},
        BuildRemotes = {}, ClaimRemotes = {}, UpgradeRemotes = {}, RollRemotes = {},
        LotteryRemotes = {}, DataStoreRemotes = {}, InternalRemotes = {}, SessionRemotes = {},
        Bindables = {}, Tools = {}, BossModels = {}, NPCs = {}, HiddenModels = {},
        CombatPrompts = {}, ClickDetectors = {}, AnticheatScripts = {}, AnticheatRemotes = {},
        SuspiciousScripts = {}, GCRemotesFound = {}, GCFunctionsFound = {}, UpvalueRemotes = {},
        RegistryFindings = {}, ConstantsFound = {}, HighValueRemotes = {}, ExploitList = {},
        SpiedCalls = {}, CallSignatures = {}, ScriptSources = {}, DecompiledScripts = {},
        LocalModules = {}, ObfuscatedRemotes = {}, ProtectedInstances = {}, NilParentObjects = {},
        AnticheatType = "Unknown", ScanTime = 0, ScanCount = 0, GameId = 0, PlaceId = 0, GameName = "?",
        AllInstances = {}, NilInstances = {}, LoadedModules = {}, RunningScripts = {},
        AllRemotesEver = {}, RemoteConnections = {}, DiscoveredKeys = {}, DiscoveredURLs = {},
        DiscoveredWebhooks = {}, DiscoveredIDs = {}, DiscoveredPasswords = {}, DiscoveredTokens = {},
        DiscoveredHashes = {}, AllScriptSources = {}, ModuleReturns = {}, ClosureDump = {},
        ProtoScan = {}, DeepConstantDump = {}, UpvalueDump = {}, ActorScripts = {},
        ClientContextScripts = {}, ObfuscatedScriptSources = {}, AdminList = {}, DevProductIDs = {},
        GamepassIDs = {}, AssetIDs = {}, LocalPlayerData = {}, LeaderstatsSchema = {},
        DataStoreNames = {}, SecretsInStorage = {}, RemoteInvokers = {}, EventFireStats = {},
        BindableEvents = {}, BindableFunctions = {}, GlobalTable = {}, NetworkOwners = {}, TeamsInfo = {},
        ReportChunks = {}, ReportChunkIndex = 1, MegaScanStats = {}, FullGameTree = {},
        InstanceClassStats = {}, ScriptCandidateCount = 0, TotalScriptBytes = 0, RegistryScan = {},
        ConnectionScan = {}, PlayerGuiFullDump = {}, AllServicesScan = {},
        TelemetryEvents = {}, MemorySnapshots = { LastGCState = {} }
    }
end
_initCore()

-- ═══════════════════════════════════════════════════════════
-- МОДУЛЬ 2: СЛОВАРИ СЕКРЕТОВ И КЛЮЧЕВЫХ СЛОВ (KEYWORD REGISTRY)
-- ═══════════════════════════════════════════════════════════
local function _initKeywords()
    KeywordRegistry = {
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
    
    SECRET_PATTERNS = {
        url = {"^https?://[%w%.%_%-/%?&=#%%~: ]+", label="URL"},
        webhook = {"discord%.com/api/webhooks/[%w/%_%-]+", label="DISCORD WEBHOOK"},
        webhook2 = {"discordapp%.com/api/webhooks/[%w/%_%-]+", label="DISCORD WEBHOOK"},
        apikey = {"[Aa][Pp][Ii][_%-]?[Kk][Ee][Yy][%s=:\\'\"]+[%w%-%._]+", label="API KEY"},
        token = {"[Tt][Oo][Kk][Ee][Nn][%s=:\\'\"]+[%w%-%._]+", label="TOKEN"},
        passwd = {"[Pp][Aa][Ss][Ss][Ww]? [Oo]?[Rr]?[Dd][%s=:\\'\"]+[%w%-%._!@#$]+", label="PASSWORD"},
        secret = {"[Ss][Ee][Cc][Rr][Ee][Tt][%s=:\\'\"]+[%w%-%._]+", label="SECRET"},
        bearer = {"[Bb]earer%s+[%w%-%._]+", label="BEARER"},
        md5 = {"[a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]$", label="MD5-LIKE"},
        productid= {"[Pp]roductId[%s=:]+(%d+)", label="DEV PRODUCT ID"},
        gamepass = {"[Gg]amepassId[%s=:]+(%d+)", label="GAMEPASS ID"},
        datastore= {"[Dd]ata[Ss]tore[%s%(:\\'\"]+([%w_%-]+)", label="DATASTORE NAME"},
        admin = {"[Aa]dmin[Ll]ist[%s=:{\\]+", label="ADMIN LIST BLOCK"},
    }
end
_initKeywords()

-- ═══════════════════════════════════════════════════════════
-- МОДУЛЬ 3: ЭВРИСТИЧЕСКИЙ СКАНИРОВАНИЕ И КЛАССИФИКАЦИЯ (HEURISTICS)
-- ═══════════════════════════════════════════════════════════
local function _initHeuristics()
    Heuristics = {}
    
    function Heuristics.scoreVuln(nm, fnm)
        local s = 0
        local fullPath = nm .. "|" .. fnm
        if matchAny(nm, KeywordRegistry.critical_effect) then s = s + 200 end
        if matchAny(nm, KeywordRegistry.backdoor) then s = s + 100 end
        if matchAny(nm, KeywordRegistry.instant) then s = s + 80 end
        if matchAny(nm, KeywordRegistry.execute) then s = s + 100 end
        if matchAny(nm, KeywordRegistry.admin) then s = s + 60 end
        if matchAny(nm, KeywordRegistry.money) then s = s + 50 end
        if matchAny(nm, KeywordRegistry.kill_all) then s = s + 80 end
        if matchAny(nm, KeywordRegistry.god) then s = s + 45 end
        if matchAny(nm, KeywordRegistry.delete) then s = s + 40 end
        if matchAny(nm, KeywordRegistry.damage) then s = s + 30 end
        if matchAny(nm, KeywordRegistry.teleport) then s = s + 25 end
        if matchAny(nm, KeywordRegistry.upgrade) then s = s + 20 end
        if matchAny(nm, KeywordRegistry.roll) then s = s + 20 end
        if matchAny(nm, KeywordRegistry.spawn) then s = s + 20 end
        if matchAny(nm, KeywordRegistry.combat) then s = s + 15 end
        if matchAny(nm, KeywordRegistry.shop) then s = s + 15 end
        if matchAny(nm, KeywordRegistry.ability) then s = s + 10 end
        if nm:find("client") then s = s - 30 end
        if nm:find("server") then s = s + 15 end
        if nm:find("^_") or nm:find("__") then s = s + 25 end
        if #nm >= 20 or nm:find("[^%w%s_]") then s = s + 30 end
        if matchAny(fullPath, KeywordRegistry.honey) then s = -1000 end
        return s
    end

    function Heuristics.classifyExploit(rem)
        local nm = safeLower(rem.Name)
        local fnm = rem.Parent and safeLower(rem.Parent.Name) or ""
        local fullPath = nm .. "|" .. fnm
        local effect = "UNKNOWN"
        local effectIcon = "❓"
        local risk = "MEDIUM"
        
        local suggestedArgs = { {rem}, {CoreGlobals.lp}, {CoreGlobals.lp.Name} }
        local key = rem:GetFullName()
        if DeepData.CallSignatures[key] and #DeepData.CallSignatures[key].samples > 0 then
            suggestedArgs = {}
            for _, realArgs in ipairs(DeepData.CallSignatures[key].samples) do
                table.insert(suggestedArgs, realArgs)
            end
        end
        
        local category = "misc"
        if matchAny(nm, KeywordRegistry.critical_effect) then
            if nm:find("map") or nm:find("world") then effect = "DELETE MAP"; effectIcon = "🗺️"; risk = "CRITICAL"
            elseif nm:find("killall") or nm:find("wipeall") then effect = "KILL ALL PLAYERS"; effectIcon = "💀"; risk = "CRITICAL"
            elseif nm:find("shutdown") or nm:find("reset") then effect = "SHUTDOWN SERVER"; effectIcon = "🔌"; risk = "CRITICAL"
            else effect = "MASS EFFECT"; effectIcon = "☢️"; risk = "CRITICAL" end
            category = "critical"
        elseif matchAny(nm, KeywordRegistry.backdoor) and (nm:find("dev") or nm:find("debug") or nm:find("test") or nm:find("bypass")) then
            effect = "SUSPECTED BACKDOOR"; effectIcon = "🚪"; risk = "CRITICAL"
            category = "backdoor"
        elseif matchAny(nm, KeywordRegistry.money) then
            effect = "GET MONEY/RESOURCE"; effectIcon = "💰"; risk = "HIGH"
            category = "money"
        elseif matchAny(nm, KeywordRegistry.upgrade) then
            effect = "UPGRADE / LEVEL"; effectIcon = "⬆️"; risk = "MEDIUM"
            category = "upgrade"
        elseif matchAny(nm, KeywordRegistry.roll) then
            effect = "ROLL / GACHA"; effectIcon = "🎰"; risk = "MEDIUM"
            category = "roll"
        elseif matchAny(nm, KeywordRegistry.shop) then
            effect = "SHOP / PURCHASE"; effectIcon = "🛒"; risk = "MEDIUM"
            category = "shop"
        elseif matchAny(nm, KeywordRegistry.pet) then
            effect = "PET / HATCH"; effectIcon = "🐾"; risk = "MEDIUM"
            category = "pet"
        elseif matchAny(nm, KeywordRegistry.quest) then
            effect = "QUEST COMPLETE"; effectIcon = "📜"; risk = "MEDIUM"
            category = "quest"
        elseif matchAny(nm, KeywordRegistry.claim) then
            effect = "CLAIM REWARD"; effectIcon = "🎁"; risk = "MEDIUM"
            category = "claim"
        elseif matchAny(nm, KeywordRegistry.god) then
            effect = "GOD MODE"; effectIcon = "🛡️"; risk = "HIGH"
            category = "god"
        elseif matchAny(nm, KeywordRegistry.admin) then
            effect = "ADMIN ACCESS"; effectIcon = "👑"; risk = "CRITICAL"
            category = "admin"
        elseif matchAny(nm, KeywordRegistry.execute) then
            effect = "REMOTE CODE EXEC"; effectIcon = "🚨"; risk = "CRITICAL"
            category = "execute"
        elseif matchAny(nm, KeywordRegistry.teleport) then
            effect = "TELEPORT"; effectIcon = "📍"; risk = "MEDIUM"
            category = "teleport"
        elseif matchAny(nm, KeywordRegistry.delete) then
            effect = "DELETE OBJECTS"; effectIcon = "🗑️"; risk = "HIGH"
            category = "delete"
        elseif matchAny(nm, KeywordRegistry.kick) then
            effect = "KICK/BAN OTHERS"; effectIcon = "🚫"; risk = "HIGH"
            category = "kick"
        elseif matchAny(nm, KeywordRegistry.heal) then
            effect = "HEAL/REVIVE"; effectIcon = "💚"; risk = "LOW"
            category = "heal"
        elseif matchAny(nm, KeywordRegistry.spawn) then
            effect = "SPAWN ITEM"; effectIcon = "✨"; risk = "MEDIUM"
            category = "spawn"
        elseif matchAny(nm, KeywordRegistry.trade) then
            effect = "TRADE / GIFT"; effectIcon = "🎁"; risk = "MEDIUM"
            category = "trade"
        elseif matchAny(nm, KeywordRegistry.chat) then
            effect = "CHAT/MESSAGE"; effectIcon = "💬"; risk = "LOW"
            category = "chat"
        elseif matchAny(nm, KeywordRegistry.speed) then
            effect = "SPEED"; effectIcon = "💨"; risk = "LOW"
            category = "speed"
        elseif matchAny(nm, KeywordRegistry.noclip) then
            effect = "NOCLIP"; effectIcon = "ghost"; risk = "LOW"
            category = "noclip"
        elseif matchAny(nm, KeywordRegistry.damage) then
            effect = "DAMAGE ENTITY"; effectIcon = "⚔️"; risk = "MEDIUM"
            category = "damage"
        elseif matchAny(nm, KeywordRegistry.combat) then
            effect = "COMBAT ACTION"; effectIcon = "⚔️"; risk = "MEDIUM"
            category = "combat"
        elseif matchAny(nm, KeywordRegistry.boss) then
            effect = "BOSS INTERACT"; effectIcon = "👹"; risk = "HIGH"
            category = "boss"
        end
        return {
            remote = rem, path = rem:GetFullName(), class = rem.ClassName,
            risk = risk, effect = effect, effectIcon = effectIcon,
            suggestedArgs = suggestedArgs, source = "AutoClass",
            name = rem.Name, category = category,
            score = Heuristics.scoreVuln(nm, fnm),
        }
    end
end
_initHeuristics()

-- ═══════════════════════════════════════════════════════════
-- МОДУЛЬ 4: ГЛУБОКИЙ АНАЛИЗАТОР ПАМЯТИ GC И CLOSURES (MEMORY SCANNER)
-- ═══════════════════════════════════════════════════════════
local function _initMemoryScanner()
    MemoryScanner = {}
    
    function MemoryScanner.takeGCSnapshot()
        if not CoreGlobals._getgc then return {} end
        local snap = { Functions = {}, TablesCount = 0 }
        local gc = CoreGlobals._getgc(true)
        local steps = 0
        for i, obj in ipairs(gc) do
            steps = steps + 1
            if steps >= 1500 then task.wait(); steps = 0 end
            local t = type(obj)
            if t == "function" then
                local info = CoreGlobals._getinfo and CoreGlobals._getinfo(obj, "S")
                snap.Functions[tostring(obj)] = info and info.source or "LuaClosure"
            elseif t == "table" then
                snap.TablesCount = snap.TablesCount + 1
            end
        end
        return snap
    end

    function MemoryScanner.performMemoryAudit()
        if not Settings.BackgroundAudit then return end
        task.spawn(function()
            pcall(function()
                local current = MemoryScanner.takeGCSnapshot()
                local last = DeepData.MemorySnapshots.LastGCState
                if not last or not last.Functions then
                    DeepData.MemorySnapshots.LastGCState = current
                    return
                end
                local newFn = 0
                local steps = 0
                for fn, src in pairs(current.Functions) do
                    steps = steps + 1
                    if steps >= 1500 then task.wait(); steps = 0 end
                    if not last.Functions[fn] then
                        newFn = newFn + 1
                        local lsrc = safeLower(src)
                        if matchAny(lsrc, {"kick", "ban", "admin", "http", "webhook"}) then
                            TelemetryEngine.logTelemetry("ANOMALY", "Suspicious Closures VM", "В куче создана подозрительная функция: " .. src, "HIGH")
                        end
                    end
                end
                local tabDelta = current.TablesCount - last.TablesCount
                if newFn > 0 or tabDelta ~= 0 then
                    DeepData.TotalMemoryDeltas = (DeepData.TotalMemoryDeltas or 0) + 1
                    TelemetryEngine.logTelemetry("GC_DELTA", "VM Heap Changed", string.format("Новые функции: +%d, Изменение таблиц: %d", newFn, tabDelta), "MEDIUM")
                end
                DeepData.MemorySnapshots.LastGCState = current
            end)
        end)
    end
end

-- ═══════════════════════════════════════════════════════════
-- МОДУЛЬ 5: СИСТЕМА ФОНОВОЙ ТЕЛЕМЕТРИИ (TELEMETRY ENGINE)
-- ═══════════════════════════════════════════════════════════
local function _initTelemetry()
    TelemetryEngine = {}
    
    function TelemetryEngine.logTelemetry(category, name, detail, priority)
        if not Settings.BackgroundAudit then return end
        priority = priority or "LOW"
        local entry = {
            Time = tick() - (DeepData.AuditStartTime or tick()),
            Category = category,
            Name = name,
            Detail = detail,
            Priority = priority
        }
        table.insert(DeepData.TelemetryEvents, entry)
        if priority == "CRITICAL" or priority == "HIGH" then
            _origWarn(string.format("🔬 [TELEMETRY ⚠️ %s] %s :: %s", priority, name, tostring(detail)))
        end
    end

    function TelemetryEngine.trackWorldPlayerBehavior()
        pcall(function()
            for _, p in ipairs(CoreGlobals.plrs:GetPlayers()) do
                if p ~= CoreGlobals.lp then
                    p.CharacterAdded:Connect(function(char)
                        TelemetryEngine.logTelemetry("PLAYER_BEHAVIOR", p.Name, "Игрок возродился в мире", "LOW")
                    end)
                    p.CharacterRemoving:Connect(function(char)
                        TelemetryEngine.logTelemetry("PLAYER_BEHAVIOR", p.Name, "Персонаж удален из игрового процесса", "LOW")
                    end)
                end
            end
            CoreGlobals.plrs.PlayerAdded:Connect(function(p)
                TelemetryEngine.logTelemetry("PLAYER_BEHAVIOR", p.Name, "Игрок подключился к серверу", "MEDIUM")
                p.CharacterAdded:Connect(function(char)
                    TelemetryEngine.logTelemetry("PLAYER_BEHAVIOR", p.Name, "Игрок возродился в мире", "LOW")
                end)
            end)
            CoreGlobals.plrs.PlayerRemoving:Connect(function(p)
                TelemetryEngine.logTelemetry("PLAYER_BEHAVIOR", p.Name, "Игрок отключился от сервера", "MEDIUM")
            end)
        end)
    end
end
_initTelemetry()
_initMemoryScanner()

-- ═══════════════════════════════════════════════════════════
-- МОДУЛЬ 6: СЕТЕВОЙ ТРАНСПОРТ И ЗАГРУЗКА В SUPABASE (UPLOADER)
-- ═══════════════════════════════════════════════════════════
local function _initUploader()
    SupabaseUploader = {}
    
    function SupabaseUploader.uploadSingleChunk(fileName, fileContent)
        local uploadUrl = "https://" .. Settings.SupabaseProject .. ".supabase.co/storage/v1/object/" .. Settings.SupabaseBucket .. "/" .. fileName
        
        local headers = {
            ["apikey"] = Settings.SupabaseKey,
            ["Authorization"] = "Bearer " .. Settings.SupabaseKey,
            ["Content-Type"] = "text/plain",
            ["User-Agent"] = "Roblox/DeltaExploitSuite"
        }

        local reqData = {
            Url = uploadUrl,
            Method = "POST",
            Headers = headers,
            Body = fileContent
        }

        local success, response
        if CoreGlobals._httprequest then
            success, response = pcall(CoreGlobals._httprequest, reqData)
            if success and type(response) == "table" then
                if response.StatusCode == 200 or response.StatusCode == 201 or response.StatusCode == 204 then
                    return true, "Success"
                else
                    return false, "HTTP " .. tostring(response.StatusCode)
                end
            end
        end

        success, response = pcall(function()
            return game:GetService("HttpService"):RequestAsync(reqData)
        end)
        
        if success and type(response) == "table" then
            if response.StatusCode == 200 or response.StatusCode == 201 or response.StatusCode == 204 then
                return true, "Success"
            else
                return false, "HTTP " .. tostring(response.StatusCode)
            end
        end

        success, response = pcall(function()
            return game:GetService("HttpService"):PostAsync(uploadUrl, fileContent, Enum.HttpContentType.TextPlain, false, headers)
        end)
        
        if success then
            return true, "Success"
        else
            return false, tostring(response)
        end
    end

    function SupabaseUploader.streamChunksToCloud(report)
        local totalSize = #report
        local chunkSize = 190 * 1024 -- Специфика Roblox: строго 190 КБ для полного игнора Gzip-сжатия!
        local totalChunks = math.ceil(totalSize / chunkSize)
        
        local sessionId = tostring(math.random(1000, 9999))
        local placeId = tostring(DeepData.PlaceId)
        
        warn("[👾 CLOUD] Запущена нарезка и отправка. Частей: " .. totalChunks)
        
        local links = {}
        local allSuccess = true
        
        for part = 1, totalChunks do
            exportBtn.Text = string.format("CHUNK %d/%d", part, totalChunks)
            
            local startPos = ((part - 1) * chunkSize) + 1
            local endPos = math.min(part * chunkSize, totalSize)
            local chunkContent = report:sub(startPos, endPos)
            
            local chunkFileName = string.format("Full_Report_%s_ID_%s_Part_%d.lua", placeId, sessionId, part)
            
            local success, errMsg = SupabaseUploader.uploadSingleChunk(chunkFileName, chunkContent)
            if success then
                local chunkLink = string.format("https://%s.supabase.co/storage/v1/object/public/%s/%s", Settings.SupabaseProject, Settings.SupabaseBucket, chunkFileName)
                table.insert(links, chunkLink)
                print(string.format("✅ [CLOUD] Сегмент %d/%d успешно сохранен!", part, totalChunks))
            else
                allSuccess = false
                warn(string.format("❌ [CLOUD] Сбой отправки сегмента %d! Причина: %s", part, tostring(errMsg)))
            end
            
            -- Пауза 5 секунд между кусками для очистки HTTP буферов
            if part < totalChunks then
                task.wait(5.0)
            end
        end
        
        if allSuccess then
            local mainLink = links[1] or ""
            copyToClipboard(mainLink)
            exportBtn.Text = "✅ CLOUD OK"
            warn("[👾 CLOUD] Все сегменты отчета успешно занесены в облачный бакет Supabase!")
            for idx, link in ipairs(links) do
                _origPrint(string.format("Ссылка на сегмент %d: %s", idx, link))
            end
        else
            exportBtn.Text = "⚠️ PARTIAL FAIL"
            warn("[👾 CLOUD] Облако отклонило часть сегментов. Посмотри F9 для диагностики.")
        end
        task.wait(4)
        exportBtn.Text = "📋 CLOUD"
    end
end
_initUploader()

-- ═══════════════════════════════════════════════════════════
-- ФУНКЦИИ СБОРА ОРИГИНАЛЬНОГО КОДА v5.2
-- ═══════════════════════════════════════════════════════════
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
 local score = Heuristics.scoreVuln(nm, fnm)
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
 DeepData.DecompiledScripts[s:GetFullName()] = src
 end
 end)
 end
 for _, s in ipairs(DeepData.SuspiciousScripts) do
 pcall(function()
 local src = decompile(s)
 if src and type(src) == "string" and #src > 20 then
 DeepData.DecompiledScripts[s:GetFullName()] = src
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
 local ok, ret = pcall(require, m)
 if ok and type(ret) == "table" then
 local dump = {}
 local cnt = 0
 for k, v in pairs(ret) do
 cnt = cnt + 1
 if cnt > 50 then break end
 local vs
 if typeof(v) == "Instance" then
 vs = ""
 if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
 indexObject(v)
 end
 elseif type(v) == "function" then vs = ""
 elseif type(v) == "table" then vs = ""
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
 do
 local ok, src = pcall(decompile, s)
 if ok and type(src) == "string" and #src > 20 then
 DeepData.AllScriptSources[s:GetFullName()] = src
 decompiled = decompiled + 1
 scanStringForSecrets(src, s:GetFullName())
 local density = 0
 for _ in src:gmatch("[%\\_]0x[%dA-Fa-f]+") do density = density + 1 end
 for _ in src:gmatch("\\\\%d%d%d") do density = density + 1 end
 if density > 20 or src:find("v[0-9]+_v[0-9]+_v") then
 safeInsert(DeepData.ObfuscatedScriptSources, { path = s:GetFullName(), density = density })
 end
 end
 end
 end)
 if i % 10 == 0 then task.wait() end
 if i > 3000 then break end
 end
end

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
 if invokeStyle then remoteName = c end
 end
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

local function dumpGlobals()
 DeepData.GlobalTable = {}
 pcall(function()
 for k, v in pairs(_G) do
 local vs
 if typeof(v) == "Instance" then vs = ""
 elseif type(v) == "table" then vs = "table"
 elseif type(v) == "function" then vs = "function"
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

local function dumpPlayerContext()
 DeepData.LocalPlayerData = {}
 DeepData.LeaderstatsSchema = {}
 DeepData.TeamsInfo = {}
 pcall(function()
 for _, attr in ipairs({"UserId","AccountAge","MembershipType","DisplayName","LocaleId"}) do
 DeepData.LocalPlayerData[attr] = tostring(lp[attr])
 end
 pcall(function()
 for aname, aval in pairs(lp:GetAttributes()) do
 DeepData.LocalPlayerData["attr:" .. tostring(aname)] = tostring(aval) .. " (type=" .. typeof(aval) .. ")"
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
 end
 end)
 end
 end
 end)
end

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

local function scanAllUpvaluesDeep()
 if not getgc or not getupvalues then return end
 DeepData.DeepWalkResults = { remotes = {}, bindables = {}, userIds = {}, adminHints = {} }
 local seen = {}
 pcall(function()
 local BATCH = 80
 for i, fn in ipairs(getgc(true)) do
 if type(fn) == "function" then
 pcall(function()
 local ups = getupvalues(fn)
 if ups then
 for uk, uv in pairs(ups) do
 if type(uv) == "table" then
 deepWalkTable(uv, 3, "fn#" .. i .. ".up#" .. tostring(uk), DeepData.DeepWalkResults, seen)
 end
 end
 end
 end)
 end
 if i % BATCH == 0 then task.wait() end
 if i > 20000 then break end
 end
 end)
 for _, e in ipairs(DeepData.DeepWalkResults.remotes) do
 safeInsert(DeepData.UpvalueRemotes, e.obj)
 end
 for _, e in ipairs(DeepData.DeepWalkResults.adminHints) do
 safeInsert(DeepData.AdminList, { name = e.value, source = "deep-walk:" .. e.path })
 end
 for _, e in ipairs(DeepData.DeepWalkResults.userIds) do
 safeInsert(DeepData.AdminList, { userId = e.id, source = "deep-walk:" .. e.path })
 end
end

local function scanForBackdoors()
 DeepData.BackdoorScripts = {}
 local patterns = {
 {"loadstring%s*%(", "loadstring()"},
 {"require%s*%(%s*%d+%s*%)", "require(assetId)"},
 {"HttpGet%s*%(", "HttpGet()"},
 {"HttpPost%s*%(", "HttpPost()"},
 {"getfenv%s*%(%s*0%s*%)", "getfenv(0)"},
 {"setfenv%s*%(", "setfenv()"},
 {"pcall%s*%(%s*loadstring", "pcall(loadstring)"},
 {"game:HttpGet", "game:HttpGet"},
 {"MarketplaceService.*Prompt", "purchase-prompt-abuse"},
 {"DataStoreService", "direct-datastore-access"},
 }
 for path, src in pairs(DeepData.AllScriptSources) do
 pcall(function()
 local hits = {}
 for _, p in ipairs(patterns) do
 if src:find(p[1]) then table.insert(hits, p[2]) end
 end
 if #hits > 0 then
 safeInsert(DeepData.BackdoorScripts, { path = path, hits = hits })
 end
 end)
 end
end

local function scanCollectionTags()
 DeepData.CollectionTags = {}
 pcall(function()
 local tags = CS:GetAllTags()
 for _, tag in ipairs(tags) do
 local objs = CS:GetTagged(tag)
 table.insert(DeepData.CollectionTags, { tag = tag, count = #objs, sample = objs[1] and objs[1]:GetFullName() or "" })
 end
 end)
end

local function scanAllAttributes()
 DeepData.AttributesFound = {}
 local function scanContainer(root, rootName)
 pcall(function()
 for _, d in ipairs(root:GetDescendants()) do
 pcall(function()
 local attrs = d:GetAttributes()
 if next(attrs) then
 local entry = { path = d:GetFullName(), attrs = {} }
 for k, v in pairs(attrs) do
 entry.attrs[tostring(k)] = tostring(v)
 if type(v) == "string" then scanStringForSecrets(v, d:GetFullName() .. "@" .. k) end
 end
 safeInsert(DeepData.AttributesFound, entry)
 end
 end)
 end
 end)
 end
 for _, svc in ipairs({ws, rep, game:GetService("StarterGui"), game:GetService("StarterPlayer"), game:GetService("StarterPack")}) do
 scanContainer(svc, tostring(svc))
 end
 for _, p in ipairs(plrs:GetPlayers()) do scanContainer(p, p.Name) end
end

local function scanRunContextAnomalies()
 DeepData.RunContextAnomalies = {}
 pcall(function()
 for _, d in ipairs(ws:GetDescendants()) do
 if d:IsA("LocalScript") then
 safeInsert(DeepData.RunContextAnomalies, { path = d:GetFullName(), reason = "LocalScript in Workspace" })
 end
 if d:IsA("Script") then
 pcall(function()
 if d.RunContext and tostring(d.RunContext) == "Enum.RunContext.Client" then
 safeInsert(DeepData.RunContextAnomalies, { path = d:GetFullName(), reason = "Script(RunContext=Client) in Workspace" })
 end
 end)
 end
 end
 for _, d in ipairs(rep:GetDescendants()) do
 if d:IsA("LocalScript") then
 safeInsert(DeepData.RunContextAnomalies, { path = d:GetFullName(), reason = "LocalScript in ReplicatedStorage" })
 end
 end
 end)
end

local function scanNamingObfuscation()
 DeepData.NamingObfuscation = {}
 for _, cat in ipairs({"UnknownRemotes","ObfuscatedRemotes"}) do
 for _, r in ipairs(DeepData[cat] or {}) do
 pcall(function()
 local nm = r.Name
 if nm:match("^[a-f0-9]+$") and #nm >= 8 then
 safeInsert(DeepData.NamingObfuscation, { path = r:GetFullName(), reason = "hex-name" })
 if nm:match("^[A-Za-z0-9+/=]+$") and #nm >= 12 then
 safeInsert(DeepData.NamingObfuscation, { path = r:GetFullName(), reason = "base64-like" })
 elseif nm:find("%z") or nm:find("[\\1-\\31]") then
 safeInsert(DeepData.NamingObfuscation, { path = r:GetFullName(), reason = "control-chars" })
 elseif #nm > 30 then
 safeInsert(DeepData.NamingObfuscation, { path = r:GetFullName(), reason = "very-long-name" })
 end
 end
 end)
 end
 end
end

local function scanMarketplace()
 DeepData.MarketplaceProducts = {}
 pcall(function()
 local MP = game:GetService("MarketplaceService")
 for _, e in ipairs(DeepData.DiscoveredIDs) do
 if tostring(e.type):find("PRODUCT") or tostring(e.type):find("GAMEPASS") then
 safeInsert(DeepData.MarketplaceProducts, e)
 end
 end
 end)
end

local function scanPlayerGuis()
 DeepData.PlayerGuiScan = {}
 pcall(function()
 local pg = lp:FindFirstChild("PlayerGui")
 if not pg then return end
 for _, gui in ipairs(pg:GetChildren()) do
 local nm = safeLower(gui.Name)
 if nm:find("admin") or nm:find("dev") or nm:find("mod") or nm:find("owner") or nm:find("debug") or nm:find("cheat") then
 safeInsert(DeepData.PlayerGuiScan, { path = gui:GetFullName(), reason = "suspicious-name", enabled = gui.Enabled })
 elseif not gui.Enabled then
 safeInsert(DeepData.PlayerGuiScan, { path = gui:GetFullName(), reason = "hidden(disabled)", enabled = false })
 end
 end
 end)
end

local function extractFullGameStructure()
 DeepData.FullGameTree = {}
 DeepData.InstanceClassStats = {}
 local roots = {
 game:GetService("Workspace"),
 game:GetService("ReplicatedStorage"),
 game:GetService("ReplicatedFirst"),
 game:GetService("StarterGui"),
 game:GetService("StarterPack"),
 game:GetService("StarterPlayer"),
 game:GetService("Lighting"),
 game:GetService("MaterialService"),
 game:GetService("SoundService"),
 game:GetService("Chat"),
 game:GetService("Teams"),
 }
 pcall(function() table.insert(roots, game:GetService("ServerStorage")) end)
 pcall(function() table.insert(roots, game:GetService("ServerScriptService")) end)
 for _, root in ipairs(roots) do
 pcall(function()
 table.insert(DeepData.FullGameTree, {
 path = root:GetFullName(), class = root.ClassName, isRoot = true
 })
 for _, d in ipairs(root:GetDescendants()) do
 pcall(function()
 local entry = {
 path = d:GetFullName(),
 class = d.ClassName,
 name = d.Name,
 }
 if d:IsA("BasePart") then
 pcall(function()
 entry.pos = tostring(d.Position)
 entry.size = tostring(d.Size)
 entry.anchored = d.Anchored
 entry.canCollide = d.CanCollide
 entry.transparency = d.Transparency
 entry.material = tostring(d.Material)
 end)
 elseif d:IsA("ValueBase") then
 pcall(function() entry.value = tostring(d.Value) end)
 elseif d:IsA("Sound") then
 pcall(function() entry.soundId = d.SoundId; entry.volume = d.Volume end)
 elseif d:IsA("Decal") or d:IsA("Texture") then
 pcall(function() entry.textureId = d.Texture end)
 elseif d:IsA("ImageLabel") or d:IsA("ImageButton") then
 pcall(function() entry.image = d.Image end)
 elseif d:IsA("MeshPart") then
 pcall(function() entry.meshId = d.MeshId; entry.textureId = d.TextureID end)
 elseif d:IsA("SpecialMesh") then
 pcall(function() entry.meshId = d.MeshId; entry.textureId = d.TextureId end)
 elseif d:IsA("Animation") then
 pcall(function() entry.animationId = d.AnimationId end)
 elseif d:IsA("Humanoid") then
 pcall(function()
 entry.health = d.Health; entry.maxHealth = d.MaxHealth
 entry.walkSpeed = d.WalkSpeed; entry.jumpPower = d.JumpPower
 end)
 elseif d:IsA("Tool") then
 pcall(function() entry.grip = tostring(d.Grip); entry.canBeDropped = d.CanBeDropped end)
 elseif d:IsA("ProximityPrompt") then
 pcall(function()
 entry.actionText = d.ActionText; entry.objectText = d.ObjectText
 entry.holdDuration = d.HoldDuration; entry.enabled = d.Enabled
 end)
 elseif d:IsA("ClickDetector") then
 pcall(function() entry.maxDistance = d.MaxActivationDistance end)
 end
 pcall(function()
 local a = d:GetAttributes()
 if next(a) then
 entry.attrs = {}
 for k, v in pairs(a) do entry.attrs[tostring(k)] = tostring(v) .. "(" .. typeof(v) .. ")" end
 end
 end)
 pcall(function()
 local t = CS:GetTags(d)
 if #t > 0 then entry.tags = table.concat(t, ",") end
 end)
 table.insert(DeepData.FullGameTree, entry)
 DeepData.InstanceClassStats[d.ClassName] = (DeepData.InstanceClassStats[d.ClassName] or 0) + 1
 end)
 end
 end)
 end
 for _, p in ipairs(plrs:GetPlayers()) do
 pcall(function()
 for _, d in ipairs(p:GetDescendants()) do
 pcall(function()
 table.insert(DeepData.FullGameTree, { path = d:GetFullName(), class = d.ClassName, name = d.Name })
 DeepData.InstanceClassStats[d.ClassName] = (DeepData.InstanceClassStats[d.ClassName] or 0) + 1
 end)
 end
 end)
 end
end

local function scanEverySingleScript()
 if not decompile then return end
 DeepData.AllScriptSources = DeepData.AllScriptSources or {}
 local candidates = {}
 local seen = {}
 local roots = { ws, rep,
 game:GetService("ReplicatedFirst"),
 game:GetService("StarterGui"),
 game:GetService("StarterPack"),
 game:GetService("StarterPlayer"),
 game:GetService("Chat"),
 game:GetService("SoundService"),
 }
 pcall(function() table.insert(roots, game:GetService("ServerStorage")) end)
 pcall(function() table.insert(roots, game:GetService("ServerScriptService")) end)
 for _, r in ipairs(roots) do
 pcall(function()
 for _, d in ipairs(r:GetDescendants()) do
 if (d:IsA("LocalScript") or d:IsA("Script") or d:IsA("ModuleScript")) and not seen[d] then
 seen[d] = true; table.insert(candidates, d)
 end
 end
 end)
 end
 for _, p in ipairs(plrs:GetPlayers()) do
 pcall(function()
 for _, d in ipairs(p:GetDescendants()) do
 if (d:IsA("LocalScript") or d:IsA("ModuleScript") or d:IsA("Script")) and not seen[d] then
 seen[d] = true; table.insert(candidates, d)
 end
 end
 end)
 end
 if getscripts then
 pcall(function() for _, s in ipairs(getscripts()) do
 if not seen[s] then seen[s] = true; table.insert(candidates, s) end
 end end)
 end
 if getloadedmodules then
 pcall(function() for _, s in ipairs(getloadedmodules()) do
 if not seen[s] then seen[s] = true; table.insert(candidates, s) end
 end end)
 end
 if getrunningscripts then
 pcall(function() for _, s in ipairs(getrunningscripts()) do
 if not seen[s] then seen[s] = true; table.insert(candidates, s) end
 end end)
 end
 if getnilinstances then
 pcall(function() for _, s in ipairs(getnilinstances()) do
 if typeof(s) == "Instance" and (s:IsA("LocalScript") or s:IsA("ModuleScript") or s:IsA("Script")) and not seen[s] then
 seen[s] = true; table.insert(candidates, s)
 end
 end end)
 end
 DeepData.ScriptCandidateCount = #candidates
 local totalBytes = 0
 for i, s in ipairs(candidates) do
 pcall(function()
 local key = s:GetFullName()
 if DeepData.AllScriptSources[key] and #DeepData.AllScriptSources[key] > 100 then return end
 local ok, src = pcall(decompile, s)
 if ok and type(src) == "string" and #src > 5 then
 DeepData.AllScriptSources[key] = src
 totalBytes = totalBytes + #src
 scanStringForSecrets(src, key)
 else
 pcall(function()
 local sc = s.Source
 if type(sc) == "string" and #sc > 5 then
 DeepData.AllScriptSources[key] = sc
 totalBytes = totalBytes + #sc
 scanStringForSecrets(sc, key)
 end
 end)
 end
 end)
 if i % 10 == 0 then task.wait() end
 end
 DeepData.TotalScriptBytes = totalBytes
end

local function fallbackGCScan()
 if (DeepData.MegaScanStats.ClosuresProcessed or 0) > 100 then return end
 if not getreg then return end
 DeepData.RegistryScan = {}
 pcall(function()
 local reg = getreg()
 local cnt = 0
 for k, v in pairs(reg) do
 cnt = cnt + 1
 if type(v) == "function" and getconstants then
 pcall(function()
 local c = getconstants(v)
 if c then
 for _, cv in pairs(c) do
 if type(cv) == "string" and #cv < 300 then
 scanStringForSecrets(cv, "registry")
 end
 end
 end
 end)
 pcall(function()
 if getupvalues then
 local ups = getupvalues(v)
 if ups then
 for _, uv in pairs(ups) do
 if typeof(uv) == "Instance" and (uv:IsA("RemoteEvent") or uv:IsA("RemoteFunction")) then
 safeInsert(DeepData.UpvalueRemotes, uv)
 pcall(indexObject, uv)
 end
 end
 end
 end
 end)
 elseif typeof(v) == "Instance" and (v:IsA("RemoteEvent") or v:IsA("RemoteFunction")) then
 safeInsert(DeepData.GCRemotesFound, v)
 pcall(indexObject, v)
 end
 if cnt > 20000 then break end
 end
 DeepData.RegistryScan.total = cnt
 end)
end

local function hookGCAlternative()
 if not getconnections then return end
 DeepData.ConnectionScan = { total = 0, funcs = 0 }
 local allRemotes = {}
 for _, cat in ipairs({"MoneyRemotes","AdminRemotes","GodRemotes","ExecuteRemotes","KillRemotes","DeleteRemotes","BossRemotes","CombatRemotes","DamageRemotes","HighValueRemotes","UnknownRemotes"}) do
 for _, r in ipairs(DeepData[cat] or {}) do allRemotes[r] = true end
 end
 for r, _ in pairs(allRemotes) do
 pcall(function()
 local sigs = {}
 if r:IsA("RemoteEvent") then table.insert(sigs, r.OnClientEvent)
 elseif r:IsA("RemoteFunction") then table.insert(sigs, r.OnClientInvoke) end
 for _, sig in ipairs(sigs) do
 pcall(function()
 local conns = getconnections(sig)
 if conns then
 DeepData.ConnectionScan.total = DeepData.ConnectionScan.total + #conns
 for _, c in ipairs(conns) do
 pcall(function()
 local fn = c.Function or c.Func
 if fn and type(fn) == "function" then
 DeepData.ConnectionScan.funcs = DeepData.ConnectionScan.funcs + 1
 if getconstants then
 for _, cv in pairs(getconstants(fn) or {}) do
 if type(cv) == "string" and #cv < 300 then
 scanStringForSecrets(cv, "conn@" .. r:GetFullName())
 end
 end
 end
 if getupvalues then
 for _, uv in pairs(getupvalues(fn) or {}) do
 if typeof(uv) == "Instance" and (uv:IsA("RemoteEvent") or uv:IsA("RemoteFunction")) then
 safeInsert(DeepData.UpvalueRemotes, uv)
 pcall(indexObject, uv)
 end
 end
 end
 end
 end)
 end
 end
 end)
 end
 end)
 end
end

local function dumpPlayerGuiFully()
 DeepData.PlayerGuiFullDump = {}
 pcall(function()
 local pg = lp:FindFirstChild("PlayerGui")
 if not pg then return end
 for _, d in ipairs(pg:GetDescendants()) do
 pcall(function()
 local e = { path = d:GetFullName(), class = d.ClassName }
 if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
 e.text = tostring(d.Text):sub(1, 200)
 elseif d:IsA("ImageLabel") or d:IsA("ImageButton") then
 e.image = tostring(d.Image)
 elseif d:IsA("Frame") or d:IsA("ScreenGui") then
 e.visible = d.Visible
 end
 table.insert(DeepData.PlayerGuiFullDump, e)
 end)
 end
 end)
end

local function scanAllServices()
 DeepData.AllServicesScan = {}
 local svcs = {
 "Workspace","ReplicatedStorage","ReplicatedFirst","ServerStorage","ServerScriptService",
 "StarterGui","StarterPack","StarterPlayer","Lighting","SoundService","Chat","Teams",
 "MaterialService","LocalizationService","HttpService","MarketplaceService","DataStoreService",
 "TeleportService","GamePassService","BadgeService","CollectionService","ContextActionService",
 "TweenService","RunService","UserInputService","InsertService","PhysicsService",
 "AnalyticsService","GroupService","LogService","AssetService","ContentProvider",
 "GuiService","HapticService","JointsService","PolicyService","PathfindingService",
 "PluginDebugService","PluginGuiService","ProximityPromptService","ReplicatedScriptService",
 "SocialService","TextService","TextChatService","VoiceChatService","VRService",
 "MessagingService","MemoryStoreService","RemoteEvent",
 }
 for _, svcName in ipairs(svcs) do
 pcall(function()
 local svc = game:GetService(svcName)
 if svc then
 local kids = {}
 pcall(function() for _, c in ipairs(svc:GetChildren()) do
 table.insert(kids, { name = c.Name, class = c.ClassName })
 end end)
 DeepData.AllServicesScan[svcName] = { class = svc.ClassName, childCount = #kids, children = kids }
 end
 end)
 end
end

local function computeAbusedRemotes()
 DeepData.MostCalledRemotes = {}
 local list = {}
 for path, sig in pairs(DeepData.CallSignatures) do
 table.insert(list, { path = path, count = sig.count })
 end
 table.sort(list, function(a,b) return a.count > b.count end)
 for i = 1, math.min(30, #list) do DeepData.MostCalledRemotes[i] = list[i] end
end

local function buildExploitList()
 DeepData.ExploitList = {}
 local seen = {}
 local function add(rem)
 if not rem or seen[rem] then return end
 seen[rem] = true
 pcall(function() table.insert(DeepData.ExploitList, Heuristics.classifyExploit(rem)) end)
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
 return (order[b.risk] or 0) > (order[b.risk] or 0)
 end)
end

local LastScanTime = 0
local function runFullAnalysis(force)
 local now = tick()
 if not force and (now - LastScanTime) < 15 then warn("[ANALYZER] Skip"); return end
 LastScanTime = now
 DeepData.ScanCount = DeepData.ScanCount + 1
 for k, v in pairs(DeepData) do
 if type(v) == "table" and k ~= "ScriptSources" and k ~= "DecompiledScripts" and k ~= "SpiedCalls" and k ~= "CallSignatures" and k ~= "TelemetryEvents" and k ~= "MemorySnapshots" then
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
 scanAllUpvaluesDeep()
 scanCollectionTags()
 scanAllAttributes()
 scanRunContextAnomalies()
 scanPlayerGuis()
 task.wait(0.3)
 extractFullGameStructure()
 scanAllServices()
 dumpPlayerGuiFully()
 scanEverySingleScript()
 task.wait(0.3)
 fallbackGCScan()
 hookGCAlternative()
 task.wait(0.3)
 attemptDecompile()
 scanForBackdoors()
 scanNamingObfuscation()
 scanMarketplace()
 computeAbusedRemotes()
 buildExploitList()
 DeepData.ScanTime = tick() - now
 warn("╔═════════════════════════════════════════════╗")
 warn("║ 🔬 GAME ANALYZER v5.5 — SCAN #" .. DeepData.ScanCount .. " (" .. math.floor(DeepData.ScanTime*10)/10 .. "s)")
 warn("║ 🎮 " .. tostring(DeepData.GameName) .. " (place=" .. tostring(DeepData.PlaceId) .. ")")
 warn("╠═════════════════════════════════════════════╣")
 warn(string.format("║ 🚪 Total exploits: %d", #DeepData.ExploitList))
 warn(string.format("║ 💰 Money:%d 👑 Admin:%d 🛡️ God:%d",
 #DeepData.MoneyRemotes, #DeepData.AdminRemotes, #DeepData.GodRemotes))
 warn(string.format("║ 🚨 Execute:%d 🛒 Shop:%d 🎰 Roll:%d",
 #DeepData.ExecuteRemotes, #DeepData.ShopRemotes, #DeepData.RollRemotes))
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

local _getclipboard = rawget(getfenv(), "getclipboard") or rawget(getfenv(), "get_clipboard")
_G.GA_ClipboardStatus = { lastTry = 0, lastSuccess = 0, lastMethod = "none", lastError = "" }
local function copyToClipboard(text)
 if type(text) ~= "string" then text = tostring(text) end
 local size = #text
 _G.GA_ClipboardStatus.lastTry = size
 _G.GA_ClipboardStatus.lastMethod = "none"
 _G.GA_ClipboardStatus.lastError = ""
 if not setclipboard then
 _G.GA_ClipboardStatus.lastError = "setclipboard API missing"
 warn("[📋] setclipboard недоступен")
 return false, 0
 end
 for attempt = 1, 3 do
 local ok, err = pcall(function() setclipboard(text) end)
 task.wait(0.15)
 if ok then
 if _getclipboard then
 local got = nil
 pcall(function() got = _getclipboard() end)
 if type(got) == "string" and #got >= math.floor(size * 0.9) then
 _G.GA_ClipboardStatus.lastSuccess = #got
 _G.GA_ClipboardStatus.lastMethod = "full-verified"
 return true, #got
 elseif type(got) == "string" and #got > 100 then
 _G.GA_ClipboardStatus.lastSuccess = #got
 _G.GA_ClipboardStatus.lastMethod = "partial"
 _G.GA_ClipboardStatus.lastError = "clip truncated: got " .. #got .. " of " .. size
 else
 _G.GA_ClipboardStatus.lastError = "getclipboard returned empty/wrong"
 end
 else
 _G.GA_ClipboardStatus.lastSuccess = size
 _G.GA_ClipboardStatus.lastMethod = "full-unverified"
 return true, size
 end
 else
 _G.GA_ClipboardStatus.lastError = tostring(err)
 end
 end
 if size > 100000 then
 local half = math.floor(size / 2)
 local ok2 = pcall(function() setclipboard(text:sub(1, half)) end)
 task.wait(0.2)
 if ok2 and _getclipboard then
 local g = nil; pcall(function() g = _getclipboard() end)
 if type(g) == "string" and #g > 1000 then
 _G.GA_ClipboardStatus.lastSuccess = #g
 _G.GA_ClipboardStatus.lastMethod = "half-only"
 _G.GA_ClipboardStatus.lastError = "size " .. size .. " too big — copied half " .. #g
 return true, #g
 end
 end
 end
 _G.GA_ClipboardStatus.lastSuccess = 0
 return false, 0
end
getclipboard = _getclipboard

local function exploitToScript(exp)
 local args = exp.suggestedArgs and exp.suggestedArgs[1] or {}
 local argsStr = argsToString(args):sub(2, -2)
 local line
 if exp.class == "RemoteEvent" then
 line = 'game:GetService("' .. exp.remote.Parent.ClassName .. '"):FindFirstChild("...")'
 line = "-- " .. exp.effectIcon .. " " .. exp.effect .. " [" .. exp.risk .. "]\\n"
 line = line .. "-- Path: " .. exp.path .. "\\n"
 line = line .. 'local rem = game:GetService("Players"):FindFirstChild("dummy") -- заменить на путь!\\n'
 line = line .. 'local target = game:GetService("Workspace")\\n'
 line = line .. 'for _, part in ipairs({' .. table.concat({}, ",") .. '}) do end\\n'
 line = line .. '-- Try: rem:FireServer(' .. argsStr .. ')'
 else
 line = "-- " .. exp.effectIcon .. " " .. exp.effect .. " [" .. exp.risk .. "]\\n"
 line = line .. "-- Path: " .. exp.path .. "\\n"
 line = line .. 'local rem = "..." -- заменить\\n'
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
 table.insert(out, " [" .. i .. "] " .. argsToString(args))
 end
 local key = exp.remote and exp.remote:GetFullName()
 if key and DeepData.CallSignatures[key] then
 local sig = DeepData.CallSignatures[key]
 table.insert(out, "")
 table.insert(out, "REAL CALLS RECORDED: " .. sig.count)
 for i, args in ipairs(sig.samples) do
 if i > 3 then break end
 table.insert(out, " [live] " .. argsToString(args))
 end
 end
 table.insert(out, "")
 table.insert(out, "EXECUTE via Lua:")
 table.insert(out, 'loadstring([[')
 table.insert(out, ' local rem = game.' .. exp.path:gsub("Workspace", 'Workspace'):gsub("ReplicatedStorage", 'ReplicatedStorage'))
 if exp.class == "RemoteEvent" then
 for _, args in ipairs(exp.suggestedArgs or {}) do
 table.insert(out, ' rem:FireServer(' .. argsToString(args):sub(2,-2) .. ')')
 end
 else
 for _, args in ipairs(exp.suggestedArgs or {}) do
 table.insert(out, ' rem:InvokeServer(' .. argsToString(args):sub(2,-2) .. ')')
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
 w("║ 🔬 GAME ANALYZER v5.5 RAPE ENGINE TOTAL EXTRACTION — FULL REPORT")
 w("║ Scan #" .. DeepData.ScanCount .. " | ScanTime: " .. math.floor(DeepData.ScanTime*10)/10 .. "s")
 w("║ 🎮 Game: " .. tostring(DeepData.GameName))
 w("║ GameId=" .. tostring(DeepData.GameId) .. " | PlaceId=" .. tostring(DeepData.PlaceId))
 w("║ 🎭 AntiCheat: " .. tostring(DeepData.AnticheatType))
 w("║ 👤 Player: " .. lp.Name .. " (UserId=" .. tostring(lp.UserId) .. ")")
 w("║ 🛠️ Executor: " .. tostring((CoreGlobals._identify and CoreGlobals._identify()) or "unknown"))
 w("╚══════════════════════════════════════════════════════════════╝")
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
 w("Full Game Tree Instances: " .. #DeepData.FullGameTree)
 w("Script Candidates: " .. DeepData.ScriptCandidateCount .. " (total " .. math.floor((DeepData.TotalScriptBytes or 0)/1024) .. " KB of source)")
 w("Registry Entries Scanned: " .. tostring(DeepData.RegistryScan.total or 0))
 w("Connections Enumerated: " .. tostring(DeepData.ConnectionScan.total or 0) .. " (with " .. tostring(DeepData.ConnectionScan.funcs or 0) .. " unique handler funcs)")
 w("PlayerGui Nodes: " .. #DeepData.PlayerGuiFullDump)
 do local c = 0 for _ in pairs(DeepData.AllServicesScan) do c=c+1 end
 w("Roblox Services Scanned: " .. c) end
 sec("👤 LOCAL PLAYER CONTEXT")
 for k, v in pairs(DeepData.LocalPlayerData) do w(" " .. k .. " = " .. tostring(v)) end
 if next(DeepData.LeaderstatsSchema) then
 w("")
 w("[LeaderStats / Player Data Schema]")
 for k, v in pairs(DeepData.LeaderstatsSchema) do
 w(" " .. k .. " :: " .. v.class .. " = " .. tostring(v.value))
 end
 end
 if #DeepData.TeamsInfo > 0 then
 w("")
 w("[Teams]")
 for _, t in ipairs(DeepData.TeamsInfo) do
 w(" " .. t.name .. " color=" .. t.color .. " auto=" .. tostring(t.autoAssign))
 end
 end
 sec("🔐 SECRETS / SENSITIVE STRINGS EXTRACTED FROM CODE")
 local function dumpSecrets(list, label)
 if #list == 0 then return end
 w("")
 w("── " .. label .. " (" .. #list .. ") ──")
 for _, e in ipairs(list) do
 w(" [" .. tostring(e.type or "?") .. "] " .. tostring(e.value or e.id or e.name) .. " ← " .. tostring(e.source or "?"))
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
 if #DeepData.AdminList > 0 then
 sec("👑 ADMIN / OWNER LIST (extracted from closures)")
 for _, a in ipairs(DeepData.AdminList) do
 w(" " .. tostring(a.name or a.userId) .. " ← " .. tostring(a.source))
 end
 end
 
 -- --- ВНЕДРЕНИЕ ДАННЫХ ФОНОВОЙ ТЕЛЕМЕТРИИ В ОТЧЕТ ---
 if #DeepData.TelemetryEvents > 0 then
  sec("📡 BACKGROUND RUNTIME TELEMETRY EVENT LOG")
  for _, entry in ipairs(DeepData.TelemetryEvents) do
   w(string.format(" [%s] (time: %ds) %s -> %s :: %s", 
    tostring(entry.Priority or "LOW"),
    math.floor(entry.Time or 0),
    tostring(entry.Category or "INFO"),
    tostring(entry.Name or "Event"),
    tostring(entry.Detail or "")
   ))
  end
 end

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
 w("")
 w(" " .. exp.effectIcon .. " [" .. exp.risk .. " | score=" .. tostring(exp.score) .. "] " .. exp.name .. " (" .. exp.class .. ")")
 w(" Path: " .. exp.path)
 w(" Effect: " .. exp.effect)
 local ccount = DeepData.RemoteConnections[exp.path]
 if ccount then w(" Client connections: " .. ccount) end
 for k, args in ipairs(exp.suggestedArgs or {}) do
 if k > 3 then break end
 w(" args[" .. k .. "]: " .. argsToString(args))
 end
 local key = exp.remote and exp.remote:GetFullName()
 if key and DeepData.CallSignatures[key] then
 local sig = DeepData.CallSignatures[key]
 w(" 🕵️ REAL CALLS RECORDED: " .. sig.count)
 for k, args in ipairs(sig.samples) do
 if k > 2 then break end
 w(" [live] " .. argsToString(args))
 end
 end
 local method = exp.class == "RemoteEvent" and "FireServer" or "InvokeServer"
 w(" 💡 SNIPPET:")
 w(' r = game:GetService("' .. (exp.path:match("^([^%.]+)") or "ReplicatedStorage") .. '")')
 local firstArgs = (exp.suggestedArgs and exp.suggestedArgs[1]) and argsToString(exp.suggestedArgs[1]):sub(2,-2) or ""
 w(' r:' .. method .. '(' .. firstArgs .. ')')
 end
 end
 sec("🕵️ REMOTE SPY LOG (all " .. #DeepData.SpiedCalls .. " calls)")
 for _, call in ipairs(DeepData.SpiedCalls) do
 w(" " .. call.method .. " → " .. call.path)
 w(" args: " .. argsToString(call.args))
 end
 w("")
 w("[Call Signatures Summary]")
 for path, sig in pairs(DeepData.CallSignatures) do
 w(" " .. path .. " called " .. sig.count .. " times")
 end
 sec("🔒 PROTECTED INSTANCES (ServerStorage/ReplicatedFirst/SSS)")
 for _, pi in ipairs(DeepData.ProtectedInstances) do
 w(" [" .. pi.service .. "] " .. pi.class .. ": " .. pi.path)
 end
 sec("🕳️ NIL-PARENT INSTANCES (hidden from Explorer)")
 for _, o in ipairs(DeepData.NilParentObjects) do
 pcall(function() w(" " .. o.ClassName .. ": " .. o.Name) end)
 end
 sec("📦 LOADED MODULE RETURN VALUES (require dumps)")
 for path, dump in pairs(DeepData.ModuleReturns) do
 w("")
 w("── " .. path .. " ──")
 for k, v in pairs(dump) do
 w(" " .. k .. " = " .. tostring(v))
 end
 end
 if #DeepData.ObfuscatedScriptSources > 0 then
 sec("🌀 OBFUSCATED SCRIPTS DETECTED")
 for _, o in ipairs(DeepData.ObfuscatedScriptSources) do
 w(" density=" .. o.density .. " :: " .. o.path)
 end
 end
 sec("📜 DECOMPILED SCRIPT SOURCES (real game code)")
 local dc = 0
 for path, src in pairs(DeepData.AllScriptSources) do
 dc = dc + 1
 w("")
 w("╭─── SCRIPT #" .. dc .. ": " .. path .. " ───")
 w(src)
 w("╰─── END SCRIPT #" .. dc .. " ───")
 end
 w("")
 w("── ANTICHEAT / SUSPICIOUS decompiled ──")
 for path, src in pairs(DeepData.DecompiledScripts) do
 w("")
 w("╭─── AC: " .. path .. " ───")
 w(src)
 w("╰───")
 end
 if next(DeepData.GlobalTable) then
 sec("🌐 GLOBALS (_G + shared)")
 for k, v in pairs(DeepData.GlobalTable) do w(" " .. k .. " = " .. tostring(v)) end
 end
 if #DeepData.NetworkOwners > 0 then
 sec("🌍 LOCAL-OWNED PARTS (you can teleport/velocity these freely)")
 for _, o in ipairs(DeepData.NetworkOwners) do w(" " .. o.path) end
 end
 if #DeepData.BindableEvents > 0 or #DeepData.BindableFunctions > 0 then
 sec("🔗 BINDABLES (client-side event/function; sometimes bridged to server)")
 for _, b in ipairs(DeepData.BindableEvents) do
 pcall(function() w(" [Event] " .. b:GetFullName()) end)
 end
 for _, b in ipairs(DeepData.BindableFunctions) do
 pcall(function() w(" [Func] " .. b:GetFullName()) end)
 end
 end
 if #DeepData.RemoteInvokers > 0 then
 sec("📡 REMOTE INVOKER MAP (constants pointing to Fire/Invoke calls)")
 for _, r in ipairs(DeepData.RemoteInvokers) do
 w(" " .. r.method .. " '" .. r.name .. "' (found in gc#" .. r.func_index .. ")")
 end
 end
 if DeepData.BackdoorScripts and #DeepData.BackdoorScripts > 0 then
 sec("🚪 SUSPECTED BACKDOOR SCRIPTS (loadstring/HttpGet/require(id)/etc)")
 for _, b in ipairs(DeepData.BackdoorScripts) do
 w(" " .. b.path)
 w(" hits: " .. table.concat(b.hits, ", "))
 end
 end
 if DeepData.RunContextAnomalies and #DeepData.RunContextAnomalies > 0 then
 sec("⚠️ RUN CONTEXT ANOMALIES (client scripts in weird places)")
 for _, a in ipairs(DeepData.RunContextAnomalies) do
 w(" " .. a.reason .. " :: " .. a.path)
 end
 end
 if DeepData.NamingObfuscation and #DeepData.NamingObfuscation > 0 then
 sec("🌀 OBFUSCATED REMOTE NAMES")
 for _, o in ipairs(DeepData.NamingObfuscation) do
 w(" [" .. o.reason .. "] " .. o.path)
 end
 end
 if DeepData.RuntimeCreatedRemotes and #DeepData.RuntimeCreatedRemotes > 0 then
 sec("🎬 RUNTIME-CREATED REMOTES (caught by Instance.new hook)")
 for _, r in ipairs(DeepData.RuntimeCreatedRemotes) do
 pcall(function() w(" " .. r.ClassName .. ": " .. r:GetFullName()) end)
 end
 end
 if DeepData.PlayerGuiScan and #DeepData.PlayerGuiScan > 0 then
 sec("🖼️ SUSPICIOUS PLAYER GUIs (admin panels / hidden UIs)")
 for _, g in ipairs(DeepData.PlayerGuiScan) do
 w(" [" .. g.reason .. "] enabled=" .. tostring(g.enabled) .. " :: " .. g.path)
 end
 end
 if DeepData.CollectionTags and #DeepData.CollectionTags > 0 then
 sec("🏷️ COLLECTION SERVICE TAGS")
 for _, t in ipairs(DeepData.CollectionTags) do
 w(" '" .. t.tag .. "' * " .. t.count .. " sample=" .. t.sample)
 end
 end
 if DeepData.AttributesFound and #DeepData.AttributesFound > 0 then
 sec("📋 INSTANCE ATTRIBUTES (config often lives here)")
 for _, e in ipairs(DeepData.AttributesFound) do
 w(" " .. e.path)
 for k, v in pairs(e.attrs) do w(" @" .. k .. " = " .. v) end
 end
 end
 if DeepData.MostCalledRemotes and #DeepData.MostCalledRemotes > 0 then
 sec("🔥 MOST-CALLED REMOTES (topN by RemoteSpy)")
 for i, r in ipairs(DeepData.MostCalledRemotes) do
 w(" " .. i .. ". " .. r.count .. "* " .. r.path)
 end
 end
 if DeepData.DeepWalkResults then
 local dw = DeepData.DeepWalkResults
 if #dw.remotes > 0 or #dw.userIds > 0 or #dw.adminHints > 0 then
 sec("🕳️ DEEP WALK RESULTS (3-level upvalue-table dive)")
 w("Remotes discovered in upvalue-tables: " .. #dw.remotes)
 for _, e in ipairs(dw.remotes) do
 pcall(function() w(" " .. e.obj:GetFullName() .. " @" .. e.path) end)
 end
 if #dw.userIds > 0 then
 w("")
 w("UserID-like values discovered:")
 for _, e in ipairs(dw.userIds) do w(" " .. e.id .. " @" .. e.path) end
 end
 if #dw.adminHints > 0 then
 w("")
 w("Admin/Owner hints:")
 for _, e in ipairs(dw.adminHints) do w(" '" .. e.value .. "' @" .. e.path) end
 end
 end
 end
 if #DeepData.DeepConstantDump > 0 then
 sec("🔤 SUSPICIOUS CONSTANTS FROM CLOSURES")
 for _, c in ipairs(DeepData.DeepConstantDump) do
 w(" [" .. c.src .. "] " .. c.value)
 end
 end
 sec("🌲 COMPLETE GAME STRUCTURE — every single Instance")
 w("Total instances scanned: " .. #DeepData.FullGameTree)
 w("")
 w("── Class distribution ──")
 do
 local classes = {}
 for cls, cnt in pairs(DeepData.InstanceClassStats) do
 table.insert(classes, { cls = cls, cnt = cnt })
 end
 table.sort(classes, function(a, b) return a.cnt > b.cnt end)
 for _, c in ipairs(classes) do w(" " .. c.cnt .. " * " .. c.cls) end
 end
 w("")
 w("── Full instance tree (path : class : extra) ──")
 for _, e in ipairs(DeepData.FullGameTree) do
 local extra = ""
 if e.value then extra = extra .. " value=" .. e.value end
 if e.pos then extra = extra .. " pos=" .. e.pos end
 if e.size then extra = extra .. " size=" .. e.size end
 if e.anchored ~= nil then extra = extra .. " anchored=" .. tostring(e.anchored) end
 if e.soundId then extra = extra .. " sound=" .. e.soundId end
 if e.animationId then extra = extra .. " anim=" .. e.animationId end
 if e.meshId then extra = extra .. " mesh=" .. e.meshId end
 if e.textureId then extra = extra .. " tex=" .. e.textureId end
 if e.image then extra = extra .. " image=" .. e.image end
 if e.health then extra = extra .. " hp=" .. e.health .. "/" .. e.maxHealth .. " ws=" .. tostring(e.walkSpeed) end
 if e.actionText then extra = extra .. " prompt='" .. e.actionText .. "'" end
 if e.tags then extra = extra .. " tags=" .. e.tags end
 w(" " .. e.path .. " :: " .. e.class .. extra)
 if e.attrs then
 for k, v in pairs(e.attrs) do w(" @" .. k .. " = " .. v) end
 end
 end
 sec("🏛️ ALL ROBLOX SERVICES + THEIR CHILDREN")
 for svcName, info in pairs(DeepData.AllServicesScan) do
 w("")
 w("── " .. svcName .. " (" .. info.class .. ", children=" .. info.childCount .. ") ──")
 for _, c in ipairs(info.children) do
 w(" " .. c.name .. " :: " .. c.class)
 end
 end
 sec("🖼️ PLAYER GUI FULL DUMP")
 for _, e in ipairs(DeepData.PlayerGuiFullDump) do
 local extra = ""
 if e.text then extra = " text='" .. e.text .. "'" end
 if e.image then extra = " img=" .. e.image end
 if e.visible ~= nil then extra = " visible=" .. tostring(e.visible) end
 w(" " .. e.path .. " :: " .. e.class .. extra)
 end
 sec("🧠 ANALYSIS SUMMARY (for LLM/human review)")
 w("Recommended immediate targets, ranked by score:")
 for i = 1, math.min(15, #DeepData.ExploitList) do
 local e = DeepData.ExploitList[i]
 w(" " .. i .. ". " .. e.effectIcon .. " [" .. e.risk .. "|" .. e.score .. "] " .. e.name .. " → " .. e.path)
 end
 w("")
 w("╔══════════════════════════════════════════════════════════════╗")
 w("║ END OF REPORT — GameAnalyzer v5.5 RAPE ENGINE")
 w("║ Total size: " .. tostring(math.floor((#table.concat(out, "\n"))/1024)) .. " KB")
 w("╚══════════════════════════════════════════════════════════════╝")
 return table.concat(out, "\n")
end

local function liteReportToString()
 return fullReportToString()
end

local function chunkReport(report, chunkSize)
 chunkSize = chunkSize or 15000
 local chunks = {}
 local total = #report
 local pos = 1
 while pos <= total do
 local endPos = math.min(pos + chunkSize - 1, total)
 if endPos < total then
 local ln = report:sub(pos, endPos):match(".*()\\n")
 if ln then endPos = pos + ln - 2 end
 end
 table.insert(chunks, report:sub(pos, endPos))
 pos = endPos + 1
 end
 for i, c in ipairs(chunks) do
 chunks[i] = "═══ PART " .. i .. "/" .. #chunks .. " ═══\\n" .. c
 end
 return chunks
end

local function rebuildReportChunks()
 local report = fullReportToString()
 DeepData.ReportChunks = chunkReport(report, 15000)
 DeepData.ReportChunkIndex = 1
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
 if AK.active then AK.blocked = AK.blocked + 1; warn("[🛡️ L1] Kick blocked #" .. AK.blocked) return end
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
        pcall(function() c:Disable() end)
        count = count + 1
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
 Text = " 🔬 GAME ANALYZER v5.5 RAPE ENGINE",
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
 Size = UDim2.new(0.24, -3, 1, 0), Position = UDim2.new(0, 0, 0, 0),
 Text = "🔄 SCAN", Font = Enum.Font.GothamBold, TextSize = 11,
 TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(0, 140, 180),
 BorderSizePixel = 0, ZIndex = 12
}, actF)
makeCorner(scanBtn, 6)

local exportBtn = newInst("TextButton", {
 Size = UDim2.new(0.26, -3, 1, 0), Position = UDim2.new(0.25, 0, 0, 0),
 Text = "📋 CLOUD", Font = Enum.Font.GothamBold, TextSize = 11,
 TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(0, 150, 100),
 BorderSizePixel = 0, ZIndex = 12
}, actF)
makeCorner(exportBtn, 6)

local liteBtn = newInst("TextButton", {
 Size = UDim2.new(0.24, -3, 1, 0), Position = UDim2.new(0.52, 0, 0, 0),
 Text = "⏳ MONITOR", Font = Enum.Font.GothamBold, TextSize = 11,
 TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(120, 100, 200),
 BorderSizePixel = 0, ZIndex = 12
}, actF)
makeCorner(liteBtn, 6)

local execAllBtn = newInst("TextButton", {
 Size = UDim2.new(0.26, -3, 1, 0), Position = UDim2.new(0.77, 0, 0, 0),
 Text = "🔥 EXEC", Font = Enum.Font.GothamBold, TextSize = 11,
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
 b.BorderSizePixel = 0
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
 Text = " 🚪 Найдено: 0 | Тап на эксплоит для немедленной активации 🎯",
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
 expInfo.Text = " 🚪 Найдено: " .. #DeepData.ExploitList .. " | Клиентские кнопки копирования отключены"
 if #DeepData.ExploitList == 0 then
 newInst("TextLabel", {
 Size = UDim2.new(1, -8, 0, 40), BackgroundTransparency = 1,
 Text = " Нажми SCAN — найдет все эксплойты в игре",
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
 Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0),
 Text = "", BackgroundTransparency = 1, AutoButtonColor = true, ZIndex = 13
 }, container)
 newInst("TextLabel", {
 Size = UDim2.new(1, -6, 0, 16), Position = UDim2.new(0, 5, 0, 2),
 Text = exp.effectIcon .. " " .. exp.effect .. " [" .. exp.risk .. "] score=" .. exp.score,
 Font = Enum.Font.GothamBold, TextSize = 11,
 TextColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 1,
 TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 14
 }, mainBtn)
 newInst("TextLabel", {
 Size = UDim2.new(1, -6, 0, 12), Position = UDim2.new(0, 5, 0, 18),
 Text = exp.name .. " (" .. exp.class .. ")",
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
 local prefix = string.rep(" ", depth)
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
 Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0),
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
 end
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
 BorderSizePixel = 0, Text = " " .. text,
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
 ln("💰 Money: " .. #DeepData.MoneyRemotes .. " | 👑 Admin: " .. #DeepData.AdminRemotes, Color3.fromRGB(255, 220, 100))
 ln("🛡️ God: " .. #DeepData.GodRemotes .. " | 🚨 Exec: " .. #DeepData.ExecuteRemotes, Color3.fromRGB(255, 150, 100))
 ln("📍 TP: " .. #DeepData.TeleportRemotes .. " | 💀 Kill: " .. #DeepData.KillRemotes, Color3.fromRGB(200, 150, 200))
 ln("💚 Heal: " .. #DeepData.HealRemotes .. " | ✨ Spawn: " .. #DeepData.SpawnRemotes, Color3.fromRGB(150, 200, 150))
 ln("🛒 Shop: " .. #DeepData.ShopRemotes .. " | 🎰 Roll: " .. #DeepData.RollRemotes, Color3.fromRGB(200, 200, 100))
 ln("⬆️ Upgrade: " .. #DeepData.UpgradeRemotes .. " | 🎁 Claim: " .. #DeepData.ClaimRemotes, Color3.fromRGB(180, 220, 150))
 ln("🐾 Pet: " .. #DeepData.PetRemotes .. " | 📜 Quest: " .. #DeepData.QuestRemotes, Color3.fromRGB(200, 180, 220))
 ln("🚗 Vehicle: " .. #DeepData.VehicleRemotes .. " | 🏗️ Build: " .. #DeepData.BuildRemotes, Color3.fromRGB(150, 200, 200))
 ln("💬 Chat: " .. #DeepData.ChatRemotes .. " | 💨 Speed: " .. #DeepData.SpeedRemotes, Color3.fromRGB(180, 220, 180))
 ln("ghost: " .. #DeepData.NoclipRemotes .. " | 🗑️ Delete: " .. #DeepData.DeleteRemotes, Color3.fromRGB(200, 100, 100))
 ln("", nil)
 ln("═══ COMBAT ═══", Color3.fromRGB(100, 200, 255))
 ln("⚔️ Combat: " .. #DeepData.CombatRemotes .. " | Damage: " .. #DeepData.DamageRemotes, Color3.fromRGB(255, 180, 100))
 ln("👹 Boss: " .. #DeepData.BossRemotes .. " | Weapon: " .. #DeepData.WeaponRemotes, Color3.fromRGB(200, 150, 200))
 ln("✨ Ability: " .. #DeepData.AbilityRemotes .. " | ❓ Unknown: " .. #DeepData.UnknownRemotes, Color3.fromRGB(150, 200, 255))
 ln("", nil)
 ln("═══ DEEP ACCESS ═══", Color3.fromRGB(200, 150, 255))
 ln("🔬 GC-Rem: " .. #DeepData.GCRemotesFound .. " Upv: " .. #DeepData.UpvalueRemotes, Color3.fromRGB(200, 150, 255))
 ln("🔬 GC-Fn: " .. #DeepData.GCFunctionsFound .. " Const: " .. #DeepData.ConstantsFound, Color3.fromRGB(200, 150, 255))
 ln("🕳️ NilParent: " .. #DeepData.NilParentObjects, Color3.fromRGB(255, 100, 200))
 ln("🔒 Protected: " .. #DeepData.ProtectedInstances, Color3.fromRGB(255, 150, 200))
 ln("🌫️ Obfuscated: " .. #DeepData.ObfuscatedRemotes .. " Internal: " .. #DeepData.InternalRemotes, Color3.fromRGB(200, 200, 255))
 local dc = 0
 for _ in pairs(DeepData.DecompiledScripts) do dc = dc + 1 end
 ln("🕵️ Decompiled: " .. dc, Color3.fromRGB(100, 255, 200))
 if #DeepData.TelemetryEvents > 0 then
  ln("", nil)
  ln("═══ TELEMETRY ENGINE ═══", Color3.fromRGB(255, 100, 255))
  ln("📡 Telemetry Events: " .. #DeepData.TelemetryEvents, Color3.fromRGB(255, 150, 255))
  ln("💀 Memory Delta Loops: " .. (DeepData.TotalMemoryDeltas or 0), Color3.fromRGB(200, 150, 255))
 end
 ln("", nil)
 ln("═══ ANTICHEAT ═══", Color3.fromRGB(255, 100, 100))
 ln("🛡️ AC-Rem: " .. #DeepData.AnticheatRemotes .. " AC-Scr: " .. #DeepData.AnticheatScripts, Color3.fromRGB(255, 100, 100))
 ln("🚨 Sus-Scripts: " .. #DeepData.SuspiciousScripts, Color3.fromRGB(255, 150, 100))
 ln("", nil)
 ln("═══ WORLD ═══", Color3.fromRGB(150, 255, 200))
 ln("👹 Bosses: " .. #DeepData.BossModels .. " 🚶 NPCs: " .. #DeepData.NPCs, Color3.fromRGB(200, 100, 200))
 ln("🗡️ Tools: " .. #DeepData.Tools .. " 💀 Bindables: " .. #DeepData.Bindables, Color3.fromRGB(150, 200, 150))
 ln("🎬 Prompts: " .. #DeepData.CombatPrompts .. " 🖱️ Clicks: " .. #DeepData.ClickDetectors, Color3.fromRGB(150, 200, 200))
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
 Text = " Включи Spy и жди пока игра сделает вызовы",
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
 Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 5, 0, 2),
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
 Text = label .. " [" .. (Settings[key] and "ON" or "OFF") .. "]",
 Font = Enum.Font.GothamBold, TextSize = 12,
 TextColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 1,
 TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 13
 }, b)
 b.MouseButton1Click:Connect(function()
 Settings[key] = not Settings[key]
 lbl.Text = label .. " [" .. (Settings[key] and "ON" or "OFF") .. "]"
 b.BackgroundColor3 = Settings[key] and (defColor or Color3.fromRGB(0, 150, 100)) or Color3.fromRGB(60, 60, 80)
 end)
 return b, lbl
end
local akContainer, akLbl = makeToggle("🛡️ Anti-Kick PRO", "_AK", Color3.fromRGB(0, 180, 120))
akContainer.MouseButton1Click:Connect(function()
 AK:Toggle(not AK.active)
 akLbl.Text = "🛡️ Anti-Kick PRO (" .. AK.layers .. " слоёв) [" .. (AK.active and "ON" or "OFF") .. "]"
 akContainer.BackgroundColor3 = AK.active and Color3.fromRGB(0, 180, 120) or Color3.fromRGB(60, 60, 80)
end)
akLbl.Text = "🛡️ Anti-Kick PRO (" .. AK.layers .. " слоёв) [OFF]"
makeToggle("🤫 Silent Mode", "SilentMode", Color3.fromRGB(80, 40, 120))
makeToggle("🔄 Auto-Scan", "AutoScan", Color3.fromRGB(0, 130, 180))
makeToggle("🔒 Deep Access (ReplicatedFirst/etc)", "DeepAccess", Color3.fromRGB(140, 60, 180))
makeToggle("📡 Фоновый аудит (Telemetry Engine)", "BackgroundAudit", Color3.fromRGB(200, 50, 180))

scanBtn.MouseButton1Click:Connect(function()
 scanBtn.Text = "🔄 SCANNING..."
 task.spawn(function()
 runFullAnalysis(true)
 refreshExploits(); refreshAnalyzer(); refreshWorkspaceTree()
 scanBtn.Text = "🔄 OK: " .. #DeepData.ExploitList
 task.wait(3); scanBtn.Text = "🔄 SCAN"
 end)
end)
_G.GA_LastReport = ""
_G.GA_LastReportPath = ""
local function saveReportToFile(report)
 if not writefile then return nil, "writefile API missing" end
 local names = {
 "GameAnalyzer_Report.txt",
 "workspace/GameAnalyzer_Report.txt",
 "GA_Report.txt",
 }
 for _, name in ipairs(names) do
 local ok, err = pcall(function() writefile(name, report) end)
 if ok then
 if isfile then
 local check = false
 pcall(function() check = isfile(name) end)
 if check then return name end
 else
 return name
 end
 end
 end
 return nil, "writefile failed on all paths"
end

-- ═══════════════════════════════════════════════════════════
-- СИСТЕМА СЕГМЕНТИРОВАННОЙ ЗАГРУЗКИ В SUPABASE (БЕЗ GZIP, ПО 200 КБ, ПАУЗА 5 СЕК) v5.4
-- ═══════════════════════════════════════════════════════════
local SUPABASE_PROJECT_ID = "earidffeokvqgffyioxa"
local SUPABASE_BUCKET = "Report"
local SUPABASE_KEY = "sb_publishable_vAuejesqMghio6T2VFXXVQ_Bx3-6GCv"

local function uploadSingleChunk(fileName, fileContent)
 local HttpService = game:GetService("HttpService")
 local uploadUrl = "https://" .. SUPABASE_PROJECT_ID .. ".supabase.co/storage/v1/object/" .. SUPABASE_BUCKET .. "/" .. fileName
 
 local headers = {
     ["apikey"] = SUPABASE_KEY,
     ["Authorization"] = "Bearer " .. SUPABASE_KEY,
     ["Content-Type"] = "text/plain",
     ["User-Agent"] = "Roblox/DeltaExploitSuite"
 }

 local reqData = {
     Url = uploadUrl,
     Method = "POST",
     Headers = headers,
     Body = fileContent
 }

 local success, response
 if _httprequest then
     success, response = pcall(_httprequest, reqData)
     if success and type(response) == "table" then
         if response.StatusCode == 200 or response.StatusCode == 201 or response.StatusCode == 204 then
             return true, "Success"
         else
             return false, "HTTP " .. tostring(response.StatusCode)
         end
     end
 end

 success, response = pcall(function()
     return HttpService:RequestAsync(reqData)
 end)
 
 if success and type(response) == "table" then
     if response.StatusCode == 200 or response.StatusCode == 201 or response.StatusCode == 204 then
         return true, "Success"
     else
         return false, "HTTP " .. tostring(response.StatusCode)
     end
 end

 success, response = pcall(function()
     return HttpService:PostAsync(uploadUrl, fileContent, Enum.HttpContentType.TextPlain, false, headers)
 end)
 
 if success then
     return true, "Success"
 else
     return false, tostring(response)
 end
end

local function streamChunksToCloud(report)
     local totalSize = #report
     local chunkSize = 190 * 1024 -- Сделали кусок строго 190 КБ для полного обхода лимита GZIP и надежности!
     local totalChunks = math.ceil(totalSize / chunkSize)
     
     local sessionId = tostring(math.random(1000, 9999))
     local placeId = tostring(DeepData.PlaceId)
     
     warn("[👾 CLOUD] Инициализировано потоковое облачное вещание нарезанием на " .. totalChunks .. " частей по 190 КБ...")
     
     local links = {}
     local allSuccess = true
     
     for part = 1, totalChunks do
         exportBtn.Text = string.format("CHUNK %d/%d", part, totalChunks)
         
         local startPos = ((part - 1) * chunkSize) + 1
         local endPos = math.min(part * chunkSize, totalSize)
         local chunkContent = report:sub(startPos, endPos)
         
         local chunkFileName = string.format("Full_Report_%s_ID_%s_Part_%d.lua", placeId, sessionId, part)
         
         local success, errMsg = uploadSingleChunk(chunkFileName, chunkContent)
         if success then
             local chunkLink = string.format("https://%s.supabase.co/storage/v1/object/public/%s/%s", SUPABASE_PROJECT_ID, SUPABASE_BUCKET, chunkFileName)
             table.insert(links, chunkLink)
             print(string.format("✅ [CLOUD] Кусок %d/%d успешно доставлен!", part, totalChunks))
         else
             allSuccess = false
             warn(string.format("❌ [CLOUD] Сбой доставки куска %d! Причина: %s", part, tostring(errMsg)))
         end
         
         -- Обязательная задержка в 5 секунд перед следующим куском (полное предотвращение флуда и Gzip)
         if part < totalChunks then
             task.wait(5.0)
         end
     end
     
     if allSuccess then
         local mainLink = links[1] or ""
         copyToClipboard(mainLink)
         exportBtn.Text = "✅ CLOUD OK"
         warn("[👾 CLOUD] Все сегменты отчета успешно занесены в облачный бакет Supabase!")
         for idx, link in ipairs(links) do
             _origPrint(string.format("Ссылка на сегмент %d: %s", idx, link))
         end
     else
         exportBtn.Text = "⚠️ PARTIAL FAIL"
         warn("[👾 CLOUD] Облако отклонило часть сегментов. Посмотри F9 для диагностики.")
     end
     task.wait(4)
     exportBtn.Text = "📋 CLOUD"
end

-- --- ИНТЕГРАЦИЯ КНОПКИ EXPORT С СЕГМЕНТИРОВАННОЙ ЗАГРУЗКОЙ В SUPABASE (ЛКМ) ---
exportBtn.MouseButton1Click:Connect(function()
 exportBtn.Text = "📋 PREPARING..."
 task.spawn(function()
     local report = fullReportToString()
     _G.GA_LastReport = report
     streamChunksToCloud(report)
 end)
end)

-- --- ПКМ НА КНОПКЕ EXPORT: РАБОТА С ЛОКАЛЬНЫМ ФАЙЛОМ (FALLBACK) ---
exportBtn.MouseButton2Click:Connect(function()
 exportBtn.Text = "📁 WRITING..."
 task.spawn(function()
     local report = fullReportToString()
     local filePath, err = saveReportToFile(report)
     if filePath then
         exportBtn.Text = "✅ SAVED FILE"
         warn("[📁 LOCAL] Полный отчет сохранен локально: " .. filePath)
     else
         exportBtn.Text = "❌ WRITE FAIL"
         warn("[📁 LOCAL] Сбой сохранения локального файла: " .. tostring(err))
     end
     task.wait(3)
     exportBtn.Text = "📋 CLOUD"
 end)
end)

-- --- ФУНКЦИИ ФОНОВОГО АУДИТА (RUNTIME TELEMETRY) ---
local function logTelemetry(category, name, detail, priority)
 if not Settings.BackgroundAudit then return end
 priority = priority or "LOW"
 local entry = {
     Time = tick() - (DeepData.AuditStartTime or tick()),
     Category = category,
     Name = name,
     Detail = detail,
     Priority = priority
 }
 table.insert(DeepData.TelemetryEvents, entry)
 if priority == "CRITICAL" or priority == "HIGH" then
     _origWarn(string.format("🔬 [TELEMETRY ⚠️ %s] %s :: %s", priority, name, tostring(detail)))
 end
end

local function takeGCSnapshot()
 if not _getgc then return {} end
 local snap = { Functions = {}, TablesCount = 0 }
 local gc = _getgc(true)
 local steps = 0
 for i, obj in ipairs(gc) do
     steps = steps + 1
     if steps >= 1500 then task.wait(); steps = 0 end
     local t = type(obj)
     if t == "function" then
         local info = _getinfo and _getinfo(obj, "S")
         snap.Functions[tostring(obj)] = info and info.source or "LuaClosure"
     elseif t == "table" then
         snap.TablesCount = snap.TablesCount + 1
     end
 end
 return snap
end

local function performMemoryAudit()
 if not Settings.BackgroundAudit then return end
 task.spawn(function()
     pcall(function()
         local current = takeGCSnapshot()
         local last = DeepData.MemorySnapshots.LastGCState
         if not last or not last.Functions then
             DeepData.MemorySnapshots.LastGCState = current
             return
         end
         local newFn = 0
         local steps = 0
         for fn, src in pairs(current.Functions) do
             steps = steps + 1
             if steps >= 1500 then task.wait(); steps = 0 end
             if not last.Functions[fn] then
                 newFn = newFn + 1
                 local lsrc = safeLower(src)
                 if matchAny(lsrc, {"kick", "ban", "admin", "http", "webhook"}) then
                     logTelemetry("ANOMALY", "Suspicious Closures VM", "В куче создана подозрительная функция: " .. src, "HIGH")
                 end
             end
         end
         local tabDelta = current.TablesCount - last.TablesCount
         if newFn > 0 or tabDelta ~= 0 then
             DeepData.TotalMemoryDeltas = (DeepData.TotalMemoryDeltas or 0) + 1
             logTelemetry("GC_DELTA", "VM Heap Changed", string.format("Новые функции: +%d, Изменение таблиц: %d", newFn, tabDelta), "MEDIUM")
         end
         DeepData.MemorySnapshots.LastGCState = current
     end)
 end)
end

-- --- МОНИТОРИНГ ДЕЙСТВИЙ ВСЕХ ИГРОКОВ НА СЕРВЕРЕ ---
local function trackWorldPlayerBehavior()
    pcall(function()
        for _, p in ipairs(plrs:GetPlayers()) do
            if p ~= lp then
                p.CharacterAdded:Connect(function(char)
                    logTelemetry("PLAYER_BEHAVIOR", p.Name, "Игрок возродился в мире", "LOW")
                end)
                p.CharacterRemoving:Connect(function(char)
                    logTelemetry("PLAYER_BEHAVIOR", p.Name, "Персонаж удален из игрового процесса", "LOW")
                end)
            end
        end
        plrs.PlayerAdded:Connect(function(p)
            logTelemetry("PLAYER_BEHAVIOR", p.Name, "Игрок подключился к серверу", "MEDIUM")
            p.CharacterAdded:Connect(function(char)
                logTelemetry("PLAYER_BEHAVIOR", p.Name, "Игрок возродился в мире", "LOW")
            end)
        end)
        plrs.PlayerRemoving:Connect(function(p)
            logTelemetry("PLAYER_BEHAVIOR", p.Name, "Игрок отключился от сервера", "MEDIUM")
        end)
    end)
end

-- --- КНОПКА MONITOR: ЗАПУСК НЕПРЕРЫВНОГО АУДИТА НА 30 МИНУТ ---
local monitorActive = false
liteBtn.MouseButton1Click:Connect(function()
 if monitorActive then
     warn("[⏳ MONITOR] Фоновая сессия уже запущена и анализирует игру!")
     return
 end
 monitorActive = true
 liteBtn.Text = "⏳ AUDITING..."
 liteBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 180)
 
 logTelemetry("SESSION", "Monitoring Started", "Запущена 30-минутная сессия непрерывного аудита сетевой активности и памяти.", "MEDIUM")
 warn("==================================================================")
 warn("🔬 [⏳ MONITOR] ЗАПУЩЕН НЕПРЕРЫВНЫЙ АУДИТ НА 30 МИНУТ...")
 warn("==================================================================")
 
 task.spawn(function()
     -- На протяжении 30 минут скрипт собирает телеметрию (логируется через RemoteSpy и GC дельта-сканер)
     task.wait(Settings.SessionDuration)
     
     -- Время сессии истекло!
     liteBtn.Text = "⏳ SAVING..."
     warn("==================================================================")
     warn("🔬 [⏳ MONITOR] ВРЕМЯ СЕССИИ ИСТЕКЛО! АВТОМАТИЧЕСКАЯ ОТПРАВКА...")
     warn("==================================================================")
     
     -- Собираем и отправляем в Supabase
     local report = fullReportToString()
     _G.GA_LastReport = report
     streamChunksToCloud(report)
     
     monitorActive = false
     liteBtn.Text = "⏳ MONITOR"
     liteBtn.BackgroundColor3 = Color3.fromRGB(120, 100, 200)
 end)
end)

-- --- ПЕРЕХВАТ СЕТЕВОЙ АКТИВНОСТИ ЧЕРЕЗ HOOKING ДЛЯ ФОНОВОЙ ТЕЛЕМЕТРИИ ---
local function installTelemetrySniffer()
    if not hookfunction then return end
    pcall(function()
        local origFire
        origFire = hookfunction(Instance.new("RemoteEvent").FireServer, function(self, ...)
            local args = {...}
            task.spawn(function()
                pcall(function()
                    if typeof(self) == "Instance" and self:IsA("RemoteEvent") then
                        local path = self:GetFullName()
                        local lowPath = safeLower(path)
                        local priority = "LOW"
                        if matchAny(lowPath, KEYWORDS.critical_effect) or matchAny(lowPath, KEYWORDS.backdoor) then priority = "CRITICAL"
                        elseif matchAny(lowPath, KEYWORDS.money) or matchAny(lowPath, KEYWORDS.admin) then priority = "HIGH"
                        elseif matchAny(lowPath, KEYWORDS.combat) or matchAny(lowPath, KEYWORDS.damage) then priority = "MEDIUM" end
                        
                        logTelemetry("NET_SPY", "FireServer: " .. self.Name, "Аргументы: " .. argsToString(args), priority)
                    end
                end)
            end)
            return origFire(self, ...)
        end)
    end)
end

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
pcall(hookInstanceNew)
task.spawn(function()
 DeepData.AuditStartTime = tick()
 runFullAnalysis(true)
 refreshExploits(); refreshAnalyzer(); refreshWorkspaceTree()
 installTelemetrySniffer()
 trackWorldPlayerBehavior()
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
-- Фоновый дельта-сканер памяти кучи Luau
task.spawn(function()
 while true do
     task.wait(15)
     pcall(performMemoryAudit)
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
warn("[GameAnalyzer v5.4 SUPABASE] ✅ Загружен!")
warn("[v5.4] Кнопка CLOUD (ЛКМ) нарезает полный лог (4+ МБ) на части по 190 КБ и надежно отправляет в облако!")
