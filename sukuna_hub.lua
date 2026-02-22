--[[
    ╔═══════════════════════════════════════════╗
    ║        SUKUNA HUB v3.2 ULTIMATE           ║
    ║        by sukuna 👑                       ║
    ║        Bütün Executorlar Uyumlu!          ║
    ╚═══════════════════════════════════════════╝
]]

local Players=game:GetService("Players")
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local Camera=workspace.CurrentCamera
local P=Players.LocalPlayer
local Char=P.Character or P.CharacterAdded:Wait()
local Hum=Char:WaitForChild("Humanoid")
local Root=Char:WaitForChild("HumanoidRootPart")

local S={Speed=false,SpeedVal=16,InfJump=false,JBoost=false,JVal=50,Fly=false,Noclip=false,
    Aimbot=false,AimKey=Enum.KeyCode.Q,AimPart="Head",FOV=200,ShowFOV=false,
    ESP=false,ESPColor=Color3.fromRGB(255,0,100),MenuOpen=true,Maximized=false,
    MenuKey=Enum.KeyCode.H,AccentColor=Color3.fromRGB(155,89,255)}
local CN={}
local NormalSize=UDim2.new(0,520,0,390)
local NormalPos=UDim2.new(0.5,-260,0.5,-195)
local MaxSize=UDim2.new(0,780,0,540)
local MaxPos=UDim2.new(0.5,-390,0.5,-270)

P.CharacterAdded:Connect(function(c) Char=c;Hum=c:WaitForChild("Humanoid");Root=c:WaitForChild("HumanoidRootPart")
    if S.Speed then Hum.WalkSpeed=S.SpeedVal end;if S.JBoost then Hum.JumpPower=S.JVal end end)

if game.CoreGui:FindFirstChild("SukunaHub") then game.CoreGui.SukunaHub:Destroy() end
local SG=Instance.new("ScreenGui");SG.Name="SukunaHub";SG.ResetOnSpawn=false;SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;SG.Parent=game.CoreGui

local Accent=Color3.fromRGB(155,89,255)
local DefaultAccent=Color3.fromRGB(155,89,255)
local C={BG=Color3.fromRGB(8,8,14),Side=Color3.fromRGB(12,12,20),Card=Color3.fromRGB(18,18,30),
    Hover=Color3.fromRGB(26,26,44),Green=Color3.fromRGB(0,255,100),Red=Color3.fromRGB(255,50,50),
    White=Color3.fromRGB(255,255,255),Gray=Color3.fromRGB(130,130,155),Cyan=Color3.fromRGB(0,220,255),
    Pink=Color3.fromRGB(255,50,150),Yellow=Color3.fromRGB(255,200,0)}

-- Track all accent-colored elements
local accentStrokes={}
local accentFills={}
local accentBtns={}
local accentMisc={}

local function Cr(p,r) local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,r or 8);c.Parent=p end
local function St(p,col,th,track)
    local s=Instance.new("UIStroke");s.Color=col or Accent;s.Thickness=th or 1;s.Transparency=0.4;s.Parent=p
    if track~=false and (col==nil or col==Accent) then table.insert(accentStrokes,s) end
    return s
end
local function TwP(o,pr,d,st,di) local t=TS:Create(o,TweenInfo.new(d or 0.25,st or Enum.EasingStyle.Quart,di or Enum.EasingDirection.Out),pr);t:Play();return t end

local function ApplyAccent(col)
    Accent=col;S.AccentColor=col
    -- Strokes
    for _,s in pairs(accentStrokes) do pcall(function() TwP(s,{Color=col},0.3) end) end
    -- Fills (slider fills, value labels)
    for _,f in pairs(accentFills) do pcall(function() TwP(f,{BackgroundColor3=col},0.3) end) end
    -- Buttons (dropdown selects)
    for _,b in pairs(accentBtns) do pcall(function() TwP(b,{BackgroundColor3=col},0.3) end) end
    -- Misc (sidebar line, badge, divider, refresh btn - NOT Main frame BG!)
    for _,m in pairs(accentMisc) do pcall(function() TwP(m,{BackgroundColor3=col},0.3) end) end
    -- Border
    pcall(function() TwP(mS,{Color=col},0.3) end)
end

-- ═══ MAIN ═══
local Main=Instance.new("Frame");Main.Name="Main";Main.Size=NormalSize;Main.Position=NormalPos
Main.BackgroundColor3=C.BG;Main.BorderSizePixel=0;Main.ClipsDescendants=true;Main.Parent=SG;Cr(Main,12)
local mS=St(Main,Accent,2,false)
-- Border syncs with current accent color (no Main BG change!)
spawn(function() while Main and Main.Parent do mS.Color=Accent;wait(0.3) end end)

-- Fast open anim
Main.Size=UDim2.new(0,40,0,40);Main.Position=UDim2.new(0.5,-20,0.5,-20);Main.BackgroundTransparency=0.8
TwP(Main,{Size=NormalSize,Position=NormalPos,BackgroundTransparency=0},0.35,Enum.EasingStyle.Back)
wait(0.2)

-- ═══ SIDEBAR ═══
local Side=Instance.new("Frame");Side.Size=UDim2.new(0,48,1,0);Side.BackgroundColor3=C.Side;Side.BorderSizePixel=0;Side.Parent=Main;Cr(Side,12)
local sideFix=Instance.new("Frame");sideFix.Size=UDim2.new(0,14,1,0);sideFix.Position=UDim2.new(1,-14,0,0);sideFix.BackgroundColor3=C.Side;sideFix.BorderSizePixel=0;sideFix.Parent=Side
local sLine=Instance.new("Frame");sLine.Size=UDim2.new(0,2,0.85,0);sLine.Position=UDim2.new(1,-1,0.075,0);sLine.BackgroundColor3=Accent;sLine.BackgroundTransparency=0.5;sLine.BorderSizePixel=0;sLine.Parent=Side
table.insert(accentMisc,sLine)

-- ═══ HEADER ═══
local HB=Instance.new("Frame");HB.Size=UDim2.new(1,-48,0,40);HB.Position=UDim2.new(0,48,0,0);HB.BackgroundColor3=C.Side;HB.BorderSizePixel=0;HB.Parent=Main
local hFix=Instance.new("Frame");hFix.Size=UDim2.new(1,0,0,8);hFix.Position=UDim2.new(0,0,1,-8);hFix.BackgroundColor3=C.Side;hFix.BorderSizePixel=0;hFix.Parent=HB

local TL=Instance.new("TextLabel");TL.Size=UDim2.new(0,160,1,0);TL.Position=UDim2.new(0,12,0,0);TL.BackgroundTransparency=1
TL.Text="⚡ SUKUNA HUB";TL.TextColor3=C.White;TL.TextSize=16;TL.Font=Enum.Font.GothamBold;TL.TextXAlignment=Enum.TextXAlignment.Left;TL.Parent=HB
local tg=Instance.new("UIGradient");tg.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Accent),ColorSequenceKeypoint.new(0.5,C.Cyan),ColorSequenceKeypoint.new(1,C.Pink)};tg.Parent=TL
spawn(function() local o=0;while TL and TL.Parent do o=(o+0.005)%1;tg.Offset=Vector2.new(o,0);RS.Heartbeat:Wait() end end)

-- v3.2 👑 badge right next to title
local vB=Instance.new("Frame");vB.Size=UDim2.new(0,58,0,20);vB.Position=UDim2.new(0,176,0.5,-10);vB.BackgroundColor3=Accent;vB.BackgroundTransparency=0.5;vB.BorderSizePixel=0;vB.Parent=HB;Cr(vB,5)
table.insert(accentMisc,vB)
local vL=Instance.new("TextLabel");vL.Size=UDim2.new(1,0,1,0);vL.BackgroundTransparency=1;vL.Text="v3.2 👑";vL.TextColor3=C.White;vL.TextSize=10;vL.Font=Enum.Font.GothamBold;vL.Parent=vB

-- 🟡 Maximize button (yellow)
local MxB=Instance.new("TextButton");MxB.Size=UDim2.new(0,28,0,28);MxB.Position=UDim2.new(1,-72,0.5,-14);MxB.BackgroundColor3=C.Yellow;MxB.BackgroundTransparency=0.4
MxB.Text="🔲";MxB.TextSize=13;MxB.Font=Enum.Font.GothamBold;MxB.TextColor3=C.White;MxB.BorderSizePixel=0;MxB.Parent=HB;Cr(MxB,7)
MxB.MouseEnter:Connect(function() TwP(MxB,{BackgroundTransparency=0.1},0.12) end)
MxB.MouseLeave:Connect(function() TwP(MxB,{BackgroundTransparency=0.4},0.12) end)
MxB.MouseButton1Click:Connect(function()
    S.Maximized=not S.Maximized
    if S.Maximized then
        MxB.Text="🔳"
        TwP(Main,{Size=MaxSize,Position=MaxPos},0.3,Enum.EasingStyle.Back)
    else
        MxB.Text="🔲"
        TwP(Main,{Size=NormalSize,Position=NormalPos},0.3,Enum.EasingStyle.Back)
    end
end)

-- ❌ Close button
local CB=Instance.new("TextButton");CB.Size=UDim2.new(0,28,0,28);CB.Position=UDim2.new(1,-38,0.5,-14);CB.BackgroundColor3=C.Red;CB.BackgroundTransparency=0.4
CB.Text="❌";CB.TextSize=13;CB.Font=Enum.Font.GothamBold;CB.TextColor3=C.White;CB.BorderSizePixel=0;CB.Parent=HB;Cr(CB,7)
CB.MouseEnter:Connect(function() TwP(CB,{BackgroundTransparency=0},0.12) end)
CB.MouseLeave:Connect(function() TwP(CB,{BackgroundTransparency=0.4},0.12) end)

-- Divider
local hDiv=Instance.new("Frame");hDiv.Size=UDim2.new(1,-48,0,1);hDiv.Position=UDim2.new(0,48,0,40);hDiv.BackgroundColor3=Accent;hDiv.BackgroundTransparency=0.6;hDiv.BorderSizePixel=0;hDiv.Parent=Main
table.insert(accentMisc,hDiv)

-- ═══ PAGES ═══
local Pages=Instance.new("Frame");Pages.Size=UDim2.new(1,-52,1,-44);Pages.Position=UDim2.new(0,50,0,42);Pages.BackgroundTransparency=1;Pages.ClipsDescendants=true;Pages.Parent=Main

local function MakePage(n)
    local pg=Instance.new("ScrollingFrame");pg.Name=n;pg.Size=UDim2.new(1,-4,1,-2);pg.Position=UDim2.new(0,2,0,1)
    pg.BackgroundTransparency=1;pg.BorderSizePixel=0;pg.ScrollBarThickness=3;pg.ScrollBarImageColor3=Accent
    pg.CanvasSize=UDim2.new(0,0,0,0);pg.AutomaticCanvasSize=Enum.AutomaticSize.Y;pg.Visible=false;pg.Parent=Pages
    local ll=Instance.new("UIListLayout");ll.Padding=UDim.new(0,4);ll.SortOrder=Enum.SortOrder.LayoutOrder;ll.Parent=pg
    local pd=Instance.new("UIPadding");pd.PaddingTop=UDim.new(0,2);pd.PaddingBottom=UDim.new(0,6);pd.Parent=pg;return pg
end

local pgH=MakePage("Hileler");pgH.Visible=true
local pgA=MakePage("Araclar")
local pgS=MakePage("Ayarlar")
local curPg=pgH

-- Tabs
local tabs={}
local tD={{I="⚔️",Pg=pgH},{I="🔧",Pg=pgA},{I="⚙️",Pg=pgS}}
for i,td in ipairs(tD) do
    local tb=Instance.new("TextButton");tb.Size=UDim2.new(0,36,0,36);tb.Position=UDim2.new(0.5,-18,0,6+(i-1)*42)
    tb.BackgroundColor3=i==1 and Accent or C.Card;tb.BackgroundTransparency=i==1 and 0.2 or 0.7
    tb.Text=td.I;tb.TextSize=17;tb.Font=Enum.Font.GothamBold;tb.TextColor3=C.White;tb.BorderSizePixel=0;tb.Parent=Side;Cr(tb,9)
    local ind=Instance.new("Frame");ind.Size=UDim2.new(0,3,0.5,0);ind.Position=UDim2.new(0,-1,0.25,0);ind.BackgroundColor3=Accent;ind.BorderSizePixel=0;ind.Visible=i==1;ind.Parent=tb;Cr(ind,2)
    tabs[i]={b=tb,ind=ind,pg=td.Pg}
    tb.MouseButton1Click:Connect(function()
        for j,t in ipairs(tabs) do local a=j==i;TwP(t.b,{BackgroundTransparency=a and 0.2 or 0.7,BackgroundColor3=a and Accent or C.Card},0.2);t.ind.Visible=a;t.pg.Visible=a end;curPg=td.Pg end)
    tb.MouseEnter:Connect(function() if curPg~=td.Pg then TwP(tb,{BackgroundTransparency=0.4},0.1) end end)
    tb.MouseLeave:Connect(function() if curPg~=td.Pg then TwP(tb,{BackgroundTransparency=0.7},0.1) end end)
end

-- ═══ BUILDERS ═══
local function Sec(pg,t)
    local s=Instance.new("Frame");s.Size=UDim2.new(1,0,0,18);s.BackgroundTransparency=1;s.Parent=pg
    local l=Instance.new("TextLabel");l.Size=UDim2.new(1,0,1,0);l.Position=UDim2.new(0,3,0,0);l.BackgroundTransparency=1;l.Text="◈ "..t;l.TextColor3=C.Cyan;l.TextSize=10;l.Font=Enum.Font.GothamBold;l.TextXAlignment=Enum.TextXAlignment.Left;l.Parent=s
end

local function Tog(pg,nm,ic,desc,def,cb)
    local cd=Instance.new("Frame");cd.Size=UDim2.new(1,0,0,42);cd.BackgroundColor3=C.Card;cd.BorderSizePixel=0;cd.Parent=pg;Cr(cd,7)
    local sk=St(cd,Accent,0.5)
    local lt=Instance.new("Frame");lt.Size=UDim2.new(0,5,0,5);lt.Position=UDim2.new(0,7,0.5,-2.5);lt.BackgroundColor3=def and C.Green or C.Red;lt.BorderSizePixel=0;lt.Parent=cd;Cr(lt,3)
    local gl=Instance.new("Frame");gl.Size=UDim2.new(0,12,0,12);gl.Position=UDim2.new(0,3.5,0.5,-6);gl.BackgroundColor3=def and C.Green or C.Red;gl.BackgroundTransparency=0.82;gl.BorderSizePixel=0;gl.Parent=cd;Cr(gl,6)
    local icL=Instance.new("TextLabel");icL.Size=UDim2.new(0,18,0,18);icL.Position=UDim2.new(0,18,0.5,-9);icL.BackgroundTransparency=1;icL.Text=ic;icL.TextSize=13;icL.Font=Enum.Font.GothamBold;icL.TextColor3=C.White;icL.Parent=cd
    local lb=Instance.new("TextLabel");lb.Size=UDim2.new(0.4,0,0,14);lb.Position=UDim2.new(0,40,0,5);lb.BackgroundTransparency=1;lb.Text=nm;lb.TextColor3=C.White;lb.TextSize=12;lb.Font=Enum.Font.GothamSemibold;lb.TextXAlignment=Enum.TextXAlignment.Left;lb.Parent=cd
    local ds=Instance.new("TextLabel");ds.Size=UDim2.new(0.4,0,0,10);ds.Position=UDim2.new(0,40,0,21);ds.BackgroundTransparency=1;ds.Text=desc;ds.TextColor3=C.Gray;ds.TextSize=9;ds.Font=Enum.Font.Gotham;ds.TextXAlignment=Enum.TextXAlignment.Left;ds.Parent=cd
    local bg=Instance.new("Frame");bg.Size=UDim2.new(0,38,0,18);bg.Position=UDim2.new(1,-46,0.5,-9);bg.BackgroundColor3=def and C.Green or C.Red;bg.BorderSizePixel=0;bg.Parent=cd;Cr(bg,9)
    local ci=Instance.new("Frame");ci.Size=UDim2.new(0,12,0,12);ci.Position=def and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,3,0.5,-6);ci.BackgroundColor3=C.White;ci.BorderSizePixel=0;ci.Parent=bg;Cr(ci,6)
    local st=def
    local bn=Instance.new("TextButton");bn.Size=UDim2.new(1,0,1,0);bn.BackgroundTransparency=1;bn.Text="";bn.Parent=cd
    bn.MouseButton1Click:Connect(function() st=not st
        TwP(bg,{BackgroundColor3=st and C.Green or C.Red},0.2);TwP(ci,{Position=st and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,3,0.5,-6)},0.2,Enum.EasingStyle.Back)
        TwP(lt,{BackgroundColor3=st and C.Green or C.Red},0.2);TwP(gl,{BackgroundColor3=st and C.Green or C.Red},0.2)
        TwP(sk,{Color=st and C.Green or C.Red},0.2);wait(0.25);TwP(sk,{Color=Accent},0.3);cb(st) end)
    bn.MouseEnter:Connect(function() TwP(cd,{BackgroundColor3=C.Hover},0.1) end)
    bn.MouseLeave:Connect(function() TwP(cd,{BackgroundColor3=C.Card},0.1) end)
end

local function Sld(pg,nm,ic,min,max,def,cb)
    local cd=Instance.new("Frame");cd.Size=UDim2.new(1,0,0,50);cd.BackgroundColor3=C.Card;cd.BorderSizePixel=0;cd.Parent=pg;Cr(cd,7);St(cd,Accent,0.5)
    local lb=Instance.new("TextLabel");lb.Size=UDim2.new(0.5,0,0,13);lb.Position=UDim2.new(0,8,0,4);lb.BackgroundTransparency=1;lb.Text=ic.." "..nm;lb.TextColor3=C.White;lb.TextSize=11;lb.Font=Enum.Font.GothamSemibold;lb.TextXAlignment=Enum.TextXAlignment.Left;lb.Parent=cd
    local vl=Instance.new("TextLabel");vl.Size=UDim2.new(0,36,0,16);vl.Position=UDim2.new(1,-44,0,3);vl.BackgroundColor3=Accent;vl.BackgroundTransparency=0.7;vl.Text=tostring(def);vl.TextColor3=C.Cyan;vl.TextSize=10;vl.Font=Enum.Font.GothamBold;vl.BorderSizePixel=0;vl.Parent=cd;Cr(vl,4)
    table.insert(accentFills,vl)
    local tr=Instance.new("Frame");tr.Size=UDim2.new(1,-16,0,5);tr.Position=UDim2.new(0,8,0,30);tr.BackgroundColor3=Color3.fromRGB(30,30,48);tr.BorderSizePixel=0;tr.Parent=cd;Cr(tr,3)
    local pc=(def-min)/(max-min)
    local fl=Instance.new("Frame");fl.Size=UDim2.new(pc,0,1,0);fl.BackgroundColor3=Accent;fl.BorderSizePixel=0;fl.Parent=tr;Cr(fl,3)
    table.insert(accentFills,fl)
    local kb=Instance.new("Frame");kb.Size=UDim2.new(0,10,0,10);kb.Position=UDim2.new(pc,-5,0.5,-5);kb.BackgroundColor3=C.White;kb.BorderSizePixel=0;kb.ZIndex=5;kb.Parent=tr;Cr(kb,5)
    local dr=false
    local sb=Instance.new("TextButton");sb.Size=UDim2.new(1,0,0,20);sb.Position=UDim2.new(0,0,0,24);sb.BackgroundTransparency=1;sb.Text="";sb.Parent=cd
    sb.MouseButton1Down:Connect(function() dr=true end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=false end end)
    UIS.InputChanged:Connect(function(i) if dr and i.UserInputType==Enum.UserInputType.MouseMovement then
        local p=math.clamp((i.Position.X-tr.AbsolutePosition.X)/tr.AbsoluteSize.X,0,1);local v=math.floor(min+(max-min)*p)
        fl.Size=UDim2.new(p,0,1,0);kb.Position=UDim2.new(p,-5,0.5,-5);vl.Text=tostring(v);cb(v) end end)
end

local function Drp(pg,nm,ic,opts,def,cb)
    local cd=Instance.new("Frame");cd.Size=UDim2.new(1,0,0,36);cd.BackgroundColor3=C.Card;cd.BorderSizePixel=0;cd.Parent=pg;Cr(cd,7);St(cd,Accent,0.5)
    local lb=Instance.new("TextLabel");lb.Size=UDim2.new(0.45,0,1,0);lb.Position=UDim2.new(0,8,0,0);lb.BackgroundTransparency=1;lb.Text=ic.." "..nm;lb.TextColor3=C.White;lb.TextSize=11;lb.Font=Enum.Font.GothamSemibold;lb.TextXAlignment=Enum.TextXAlignment.Left;lb.Parent=cd
    local idx=1;for i,v in ipairs(opts) do if v==def then idx=i end end
    local sel=Instance.new("TextButton");sel.Size=UDim2.new(0,80,0,22);sel.Position=UDim2.new(1,-88,0.5,-11);sel.BackgroundColor3=Accent;sel.BackgroundTransparency=0.5
    sel.Text="◀ "..def.." ▶";sel.TextColor3=C.White;sel.TextSize=10;sel.Font=Enum.Font.GothamBold;sel.BorderSizePixel=0;sel.Parent=cd;Cr(sel,5)
    table.insert(accentBtns,sel)
    sel.MouseButton1Click:Connect(function() idx=idx%#opts+1;sel.Text="◀ "..opts[idx].." ▶";cb(opts[idx]) end)
end

local function ActBtn(pg,nm,ic,desc,cb)
    local cd=Instance.new("Frame");cd.Size=UDim2.new(1,0,0,38);cd.BackgroundColor3=C.Card;cd.BorderSizePixel=0;cd.Parent=pg;Cr(cd,7);St(cd,C.Cyan,0.5)
    local lb=Instance.new("TextLabel");lb.Size=UDim2.new(0.55,0,0,13);lb.Position=UDim2.new(0,8,0,4);lb.BackgroundTransparency=1;lb.Text=ic.." "..nm;lb.TextColor3=C.White;lb.TextSize=11;lb.Font=Enum.Font.GothamSemibold;lb.TextXAlignment=Enum.TextXAlignment.Left;lb.Parent=cd
    local ds=Instance.new("TextLabel");ds.Size=UDim2.new(0.55,0,0,10);ds.Position=UDim2.new(0,8,0,19);ds.BackgroundTransparency=1;ds.Text=desc;ds.TextColor3=C.Gray;ds.TextSize=8;ds.Font=Enum.Font.Gotham;ds.TextXAlignment=Enum.TextXAlignment.Left;ds.Parent=cd
    local bt=Instance.new("TextButton");bt.Size=UDim2.new(0,44,0,22);bt.Position=UDim2.new(1,-52,0.5,-11);bt.BackgroundColor3=C.Cyan;bt.BackgroundTransparency=0.3;bt.Text="AÇ";bt.TextColor3=C.White;bt.TextSize=10;bt.Font=Enum.Font.GothamBold;bt.BorderSizePixel=0;bt.Parent=cd;Cr(bt,5)
    bt.MouseButton1Click:Connect(cb)
    bt.MouseEnter:Connect(function() TwP(bt,{BackgroundTransparency=0},0.1) end)
    bt.MouseLeave:Connect(function() TwP(bt,{BackgroundTransparency=0.3},0.1) end)
end

-- ═══ HİLELER ═══
Sec(pgH,"HAREKET")
Tog(pgH,"Speed Hack","🏃","Hızını ayarla",false,function(s) S.Speed=s;Hum.WalkSpeed=s and S.SpeedVal or 16 end)
Sld(pgH,"Speed","⚡",16,500,16,function(v) S.SpeedVal=v;if S.Speed then Hum.WalkSpeed=v end end)
Tog(pgH,"Fly","🦅","WASD+Space/Shift",false,function(s) S.Fly=s
    if s then
        local bv=Instance.new("BodyVelocity");bv.Name="SF";bv.MaxForce=Vector3.new(9e9,9e9,9e9);bv.Parent=Root
        local bg=Instance.new("BodyGyro");bg.Name="SG";bg.MaxTorque=Vector3.new(9e9,9e9,9e9);bg.D=200;bg.P=10000;bg.Parent=Root
        CN.Fly=RS.Heartbeat:Connect(function() if not S.Fly then return end
            local cm=Camera;local d=Vector3.zero;local sp=S.SpeedVal>16 and S.SpeedVal or 60
            if UIS:IsKeyDown(Enum.KeyCode.W) then d=d+cm.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then d=d-cm.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then d=d-cm.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then d=d+cm.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then d=d+Vector3.yAxis end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then d=d-Vector3.yAxis end
            bv.Velocity=d*sp;bg.CFrame=cm.CFrame end)
    else if CN.Fly then CN.Fly:Disconnect() end;pcall(function() Root.SF:Destroy();Root.SG:Destroy() end) end end)
Tog(pgH,"Noclip","👻","Duvarlardan geç",false,function(s) S.Noclip=s
    if s then CN.NC=RS.Stepped:Connect(function() if S.Noclip and Char then for _,p in pairs(Char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end end)
    else if CN.NC then CN.NC:Disconnect() end end end)

Sec(pgH,"ZIPLAMA")
Tog(pgH,"Infinite Jump","🔄","Sonsuz zıpla",false,function(s) S.InfJump=s
    if s then CN.IJ=UIS.JumpRequest:Connect(function() if S.InfJump then Hum:ChangeState(Enum.HumanoidStateType.Jumping) end end)
    else if CN.IJ then CN.IJ:Disconnect() end end end)
Tog(pgH,"Jump Boost","🚀","Zıplama gücü",false,function(s) S.JBoost=s;Hum.JumpPower=s and S.JVal or 50 end)
Sld(pgH,"Jump Power","📈",50,500,50,function(v) S.JVal=v;if S.JBoost then Hum.JumpPower=v end end)

Sec(pgH,"AİMBOT")
Tog(pgH,"Aimbot","🎯","En yakına kilitle",false,function(s) S.Aimbot=s end)
Sld(pgH,"FOV","🔘",20,1200,200,function(v) S.FOV=v end)
Tog(pgH,"FOV Göster","⭕","FOV dairesi",false,function(s) S.ShowFOV=s end)
Drp(pgH,"Hedef","🧠",{"Head","HumanoidRootPart","UpperTorso"},"Head",function(v) S.AimPart=v end)
Drp(pgH,"Kilit Tuşu","🔑",{"Q","E","C","X","V","F","MB2"},"Q",function(v)
    if v=="MB2" then S.AimKey="MB2" else S.AimKey=Enum.KeyCode[v] end end)

-- FOV Circle (Frame-based - works on ALL executors)
local fovFrame = Instance.new("Frame")
fovFrame.Name = "FOVCircle"
fovFrame.BackgroundTransparency = 1
fovFrame.BorderSizePixel = 0
fovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
fovFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
fovFrame.Size = UDim2.new(0, 400, 0, 400)
fovFrame.Visible = false
fovFrame.Parent = SG
local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovFrame
local fovStroke = Instance.new("UIStroke")
fovStroke.Color = Accent
fovStroke.Thickness = 2
fovStroke.Transparency = 0.3
fovStroke.Parent = fovFrame

-- Aimbot target lock system
local lockedTarget = nil

RS.RenderStepped:Connect(function()
    -- FOV circle update
    local sz = S.FOV * 2
    fovFrame.Size = UDim2.new(0, sz, 0, sz)
    fovFrame.Visible = S.ShowFOV and S.Aimbot
    fovStroke.Color = Accent

    if not S.Aimbot then lockedTarget = nil; return end

    -- Check if key is held
    local holding = false
    if S.AimKey == "MB2" then
        holding = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    else
        holding = UIS:IsKeyDown(S.AimKey)
    end

    -- Release key = unlock target
    if not holding then lockedTarget = nil; return end

    -- Check if locked target is still valid
    if lockedTarget then
        local valid = lockedTarget.Character
            and lockedTarget.Character:FindFirstChild(S.AimPart)
            and lockedTarget.Character:FindFirstChild("Humanoid")
            and lockedTarget.Character.Humanoid.Health > 0
            and lockedTarget.Parent == Players
        if not valid then lockedTarget = nil end
    end

    -- Find new target only if no locked target
    if not lockedTarget then
        local minD = S.FOV
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= P and plr.Character and plr.Character:FindFirstChild(S.AimPart)
                and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                local pos, vis = Camera:WorldToViewportPoint(plr.Character[S.AimPart].Position)
                if vis then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if dist < minD then minD = dist; lockedTarget = plr end
                end
            end
        end
    end

    -- Lock camera to target
    if lockedTarget and lockedTarget.Character and lockedTarget.Character:FindFirstChild(S.AimPart) then
        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, lockedTarget.Character[S.AimPart].Position)
    end
end)

Sec(pgH,"ESP")
local espF=Instance.new("Folder");espF.Name="SukunaESP";espF.Parent=game.CoreGui
Tog(pgH,"Player ESP","👁️","Oyuncuları gör",false,function(s) S.ESP=s
    if not s then for _,v in pairs(espF:GetChildren()) do v:Destroy() end end end)
local espCols={"Kırmızı","Yeşil","Mavi","Mor","Pembe","Cyan","Turuncu","Beyaz"}
local espMap={["Kırmızı"]=Color3.fromRGB(255,50,50),["Yeşil"]=Color3.fromRGB(0,255,100),["Mavi"]=Color3.fromRGB(0,120,255),
    ["Mor"]=Color3.fromRGB(155,89,255),["Pembe"]=Color3.fromRGB(255,50,150),["Cyan"]=Color3.fromRGB(0,220,255),
    ["Turuncu"]=Color3.fromRGB(255,150,0),["Beyaz"]=Color3.fromRGB(255,255,255)}
Drp(pgH,"ESP Rengi","🎨",espCols,"Kırmızı",function(v) S.ESPColor=espMap[v] or C.Red end)

-- ESP loop - faster refresh, fixed distance bug
spawn(function() while true do
    RS.Heartbeat:Wait()
    if not S.ESP then
        if #espF:GetChildren()>0 then for _,v in pairs(espF:GetChildren()) do v:Destroy() end end
        wait(0.2);continue
    end
    -- Update existing or create
    for _,v in pairs(espF:GetChildren()) do v:Destroy() end
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=P and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health>0 then
            pcall(function()
                local hl=Instance.new("Highlight");hl.Adornee=plr.Character;hl.FillColor=S.ESPColor;hl.FillTransparency=0.75;hl.OutlineColor=S.ESPColor;hl.OutlineTransparency=0.15;hl.Parent=espF
                local bb=Instance.new("BillboardGui");bb.Adornee=plr.Character.HumanoidRootPart;bb.Size=UDim2.new(0,100,0,32);bb.StudsOffset=Vector3.new(0,3.2,0);bb.AlwaysOnTop=true;bb.Parent=espF
                local nl=Instance.new("TextLabel");nl.Size=UDim2.new(1,0,0.5,0);nl.BackgroundTransparency=1;nl.Text=plr.Name;nl.TextColor3=S.ESPColor;nl.TextSize=12;nl.Font=Enum.Font.GothamBold;nl.TextStrokeTransparency=0.4;nl.Parent=bb
                local dist=Root and plr.Character.HumanoidRootPart and math.floor((plr.Character.HumanoidRootPart.Position-Root.Position).Magnitude) or 0
                local dl=Instance.new("TextLabel");dl.Size=UDim2.new(1,0,0.5,0);dl.Position=UDim2.new(0,0,0.5,0);dl.BackgroundTransparency=1;dl.Text="["..dist.."m]";dl.TextColor3=C.White;dl.TextSize=10;dl.Font=Enum.Font.Gotham;dl.TextStrokeTransparency=0.5;dl.Parent=bb
                local hp=math.floor(plr.Character.Humanoid.Health)
                local hb=Instance.new("Frame");hb.Size=UDim2.new(0.7,0,0,3);hb.Position=UDim2.new(0.15,0,0.92,0);hb.BackgroundColor3=Color3.fromRGB(40,40,40);hb.BorderSizePixel=0;hb.Parent=bb;Cr(hb,2)
                local hf=Instance.new("Frame");hf.Size=UDim2.new(math.clamp(hp/100,0,1),0,1,0);hf.BackgroundColor3=hp>50 and C.Green or C.Red;hf.BorderSizePixel=0;hf.Parent=hb;Cr(hf,2)
            end)
        end
    end
    wait(0.15)
end end)

-- ═══ GOTO TP (compact) ═══
Sec(pgH,"GOTO")
local gF=Instance.new("Frame");gF.Size=UDim2.new(1,0,0,130);gF.BackgroundColor3=C.Card;gF.BorderSizePixel=0;gF.ClipsDescendants=true;gF.Parent=pgH;Cr(gF,7);St(gF,C.Pink,0.5)

local gH=Instance.new("Frame");gH.Size=UDim2.new(1,0,0,26);gH.BackgroundTransparency=1;gH.Parent=gF
local gL=Instance.new("TextLabel");gL.Size=UDim2.new(0.7,0,1,0);gL.Position=UDim2.new(0,8,0,0);gL.BackgroundTransparency=1;gL.Text="🎯 Oyuncuya Tıkla → TP";gL.TextColor3=C.White;gL.TextSize=11;gL.Font=Enum.Font.GothamSemibold;gL.TextXAlignment=Enum.TextXAlignment.Left;gL.Parent=gH
local rB=Instance.new("TextButton");rB.Size=UDim2.new(0,22,0,22);rB.Position=UDim2.new(1,-28,0.5,-11);rB.BackgroundColor3=Accent;rB.BackgroundTransparency=0.5;rB.Text="🔄";rB.TextSize=12;rB.Font=Enum.Font.GothamBold;rB.TextColor3=C.White;rB.BorderSizePixel=0;rB.Parent=gH;Cr(rB,5)
table.insert(accentMisc,rB)

-- Scrollable player list inside goto
local pSF=Instance.new("ScrollingFrame");pSF.Size=UDim2.new(1,-6,0,98);pSF.Position=UDim2.new(0,3,0,28);pSF.BackgroundTransparency=1;pSF.BorderSizePixel=0;pSF.ScrollBarThickness=2;pSF.ScrollBarImageColor3=C.Pink;pSF.CanvasSize=UDim2.new(0,0,0,0);pSF.AutomaticCanvasSize=Enum.AutomaticSize.Y;pSF.Parent=gF
local pLL=Instance.new("UIListLayout");pLL.Padding=UDim.new(0,2);pLL.Parent=pSF

local function RefP()
    for _,c in pairs(pSF:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _,plr in pairs(Players:GetPlayers()) do if plr~=P then
        local pb=Instance.new("TextButton");pb.Size=UDim2.new(1,0,0,22);pb.BackgroundColor3=Color3.fromRGB(22,22,38);pb.BorderSizePixel=0;pb.Parent=pSF;Cr(pb,5)
        pb.Text="  👤 "..plr.Name;pb.TextColor3=C.White;pb.TextSize=10;pb.Font=Enum.Font.GothamSemibold;pb.TextXAlignment=Enum.TextXAlignment.Left
        local dt=Instance.new("Frame");dt.Size=UDim2.new(0,4,0,4);dt.Position=UDim2.new(1,-10,0.5,-2);dt.BackgroundColor3=C.Green;dt.BorderSizePixel=0;dt.Parent=pb;Cr(dt,2)
        pb.MouseEnter:Connect(function() TwP(pb,{BackgroundColor3=Color3.fromRGB(36,36,58)},0.08) end)
        pb.MouseLeave:Connect(function() TwP(pb,{BackgroundColor3=Color3.fromRGB(22,22,38)},0.08) end)
        pb.MouseButton1Click:Connect(function()
            pcall(function() if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                Root.CFrame=plr.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
                TwP(pb,{BackgroundColor3=C.Green},0.08);wait(0.15);TwP(pb,{BackgroundColor3=Color3.fromRGB(22,22,38)},0.15) end end) end)
    end end
end
RefP();rB.MouseButton1Click:Connect(RefP)
Players.PlayerAdded:Connect(RefP);Players.PlayerRemoving:Connect(function() wait(0.2);RefP() end)

-- ═══ ARAÇLAR ═══
Sec(pgA,"ARAÇLAR")
ActBtn(pgA,"Infinite Yield","💠","Admin komut paneli",function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end) end)
ActBtn(pgA,"Dex Explorer","🔍","Oyun explorer aç",function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end) end)

-- ═══ AYARLAR ═══
Sec(pgS,"MENÜ RENGİ")
local cPresets={
    {n="Mor",c=Color3.fromRGB(155,89,255)},{n="Mavi",c=Color3.fromRGB(0,120,255)},
    {n="Kırmızı",c=Color3.fromRGB(255,50,50)},{n="Yeşil",c=Color3.fromRGB(0,200,100)},
    {n="Pembe",c=Color3.fromRGB(255,50,150)},{n="Cyan",c=Color3.fromRGB(0,220,255)},
    {n="Turuncu",c=Color3.fromRGB(255,150,0)},{n="Altın",c=Color3.fromRGB(255,215,0)}
}
local cC=Instance.new("Frame");cC.Size=UDim2.new(1,0,0,68);cC.BackgroundColor3=C.Card;cC.BorderSizePixel=0;cC.Parent=pgS;Cr(cC,7);St(cC,Accent,0.5)
local ccL=Instance.new("TextLabel");ccL.Size=UDim2.new(1,0,0,18);ccL.Position=UDim2.new(0,8,0,3);ccL.BackgroundTransparency=1;ccL.Text="🎨 Accent Rengi Seç";ccL.TextColor3=C.White;ccL.TextSize=11;ccL.Font=Enum.Font.GothamSemibold;ccL.TextXAlignment=Enum.TextXAlignment.Left;ccL.Parent=cC
for i,cp in ipairs(cPresets) do
    local row=math.floor((i-1)/4);local col=(i-1)%4
    local cb=Instance.new("TextButton");cb.Size=UDim2.new(0,50,0,20);cb.Position=UDim2.new(0,5+col*56,0,24+row*24)
    cb.BackgroundColor3=cp.c;cb.BackgroundTransparency=0.2;cb.Text=cp.n;cb.TextColor3=C.White;cb.TextSize=9;cb.Font=Enum.Font.GothamBold;cb.BorderSizePixel=0;cb.Parent=cC;Cr(cb,4)
    cb.MouseButton1Click:Connect(function()
        ApplyAccent(cp.c)
        pcall(function() fovStroke.Color=cp.c end)
        pcall(function() TwP(FT,{BackgroundColor3=cp.c},0.3) end)
        pcall(function() FG.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,cp.c),ColorSequenceKeypoint.new(0.5,C.White),ColorSequenceKeypoint.new(1,cp.c)} end)
        pcall(function() tg.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,cp.c),ColorSequenceKeypoint.new(0.5,C.Cyan),ColorSequenceKeypoint.new(1,cp.c)} end)
        for _,t in ipairs(tabs) do if t.pg==curPg then TwP(t.b,{BackgroundColor3=cp.c},0.2) end;t.ind.BackgroundColor3=cp.c end
        for _,pg in pairs({pgH,pgA,pgS}) do pg.ScrollBarImageColor3=cp.c end
    end)
end

Sec(pgS,"MENÜ TUŞU")
local mkOpts={"H","J","K","L","M","N","P","RightShift","Insert"}
Drp(pgS,"Menü Aç/Kapa","🔑",mkOpts,"H",function(v)
    if v=="RightShift" then S.MenuKey=Enum.KeyCode.RightShift
    elseif v=="Insert" then S.MenuKey=Enum.KeyCode.Insert
    else S.MenuKey=Enum.KeyCode[v] end
end)

-- Reset button
Sec(pgS,"SIFIRLA")
local rstBtn=Instance.new("TextButton");rstBtn.Size=UDim2.new(1,0,0,34);rstBtn.BackgroundColor3=C.Red;rstBtn.BackgroundTransparency=0.4;rstBtn.Text="🔄 Varsayılana Sıfırla";rstBtn.TextColor3=C.White;rstBtn.TextSize=12;rstBtn.Font=Enum.Font.GothamBold;rstBtn.BorderSizePixel=0;rstBtn.Parent=pgS;Cr(rstBtn,7)
rstBtn.MouseButton1Click:Connect(function()
    ApplyAccent(DefaultAccent)
    pcall(function() fovStroke.Color=DefaultAccent end)
    pcall(function() TwP(FT,{BackgroundColor3=DefaultAccent},0.3) end)
    pcall(function() FG.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,DefaultAccent),ColorSequenceKeypoint.new(0.5,C.White),ColorSequenceKeypoint.new(1,DefaultAccent)} end)
    pcall(function() tg.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,DefaultAccent),ColorSequenceKeypoint.new(0.5,C.Cyan),ColorSequenceKeypoint.new(1,C.Pink)} end)
    -- Reset Main BG back to dark black
    TwP(Main,{BackgroundColor3=C.BG},0.3)
    for _,t in ipairs(tabs) do if t.pg==curPg then TwP(t.b,{BackgroundColor3=DefaultAccent},0.2) end;t.ind.BackgroundColor3=DefaultAccent end
    for _,pg in pairs({pgH,pgA,pgS}) do pg.ScrollBarImageColor3=DefaultAccent end
    TwP(rstBtn,{BackgroundColor3=C.Green},0.15);wait(0.3);TwP(rstBtn,{BackgroundColor3=C.Red},0.3)
end)
rstBtn.MouseEnter:Connect(function() TwP(rstBtn,{BackgroundTransparency=0.1},0.1) end)
rstBtn.MouseLeave:Connect(function() TwP(rstBtn,{BackgroundTransparency=0.4},0.1) end)

Sec(pgS,"BİLGİ")
local iC=Instance.new("Frame");iC.Size=UDim2.new(1,0,0,52);iC.BackgroundColor3=C.Card;iC.BorderSizePixel=0;iC.Parent=pgS;Cr(iC,7);St(iC,Accent,0.5)
local iL=Instance.new("TextLabel");iL.Size=UDim2.new(1,-10,1,0);iL.Position=UDim2.new(0,6,0,0);iL.BackgroundTransparency=1
iL.Text="⚡ SUKUNA HUB v3.2 ULTIMATE\n👑 by sukuna\n🎮 H = Menü Aç/Kapa\n🔓 Bütün Executorlar Uyumlu!";iL.TextColor3=C.Gray;iL.TextSize=9;iL.Font=Enum.Font.Gotham;iL.TextXAlignment=Enum.TextXAlignment.Left;iL.Parent=iC

-- ═══ FOOTER ═══
local FT=Instance.new("Frame");FT.Size=UDim2.new(1,0,0,2);FT.Position=UDim2.new(0,0,1,-2);FT.BackgroundColor3=Accent;FT.BorderSizePixel=0;FT.ZIndex=10;FT.Parent=Main
local FG=Instance.new("UIGradient");FG.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Accent),ColorSequenceKeypoint.new(0.5,C.White),ColorSequenceKeypoint.new(1,Accent)};FG.Parent=FT
spawn(function() local o=0;while FT and FT.Parent do o=(o+0.01)%1;FG.Offset=Vector2.new(o,0);RS.Heartbeat:Wait() end end)

-- ═══ DRAG ═══
local dg,ds2,sp2
HB.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dg=true;ds2=i.Position;sp2=Main.Position
    i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dg=false end end) end end)
UIS.InputChanged:Connect(function(i) if dg and i.UserInputType==Enum.UserInputType.MouseMovement then local d=i.Position-ds2
    TwP(Main,{Position=UDim2.new(sp2.X.Scale,sp2.X.Offset+d.X,sp2.Y.Scale,sp2.Y.Offset+d.Y)},0.05) end end)

-- ═══ CLOSE & TOGGLE ═══
CB.MouseButton1Click:Connect(function()
    TwP(Main,{Size=UDim2.new(0,40,0,40),Position=UDim2.new(0.5,-20,0.5,-20),BackgroundTransparency=0.8},0.25,Enum.EasingStyle.Back,Enum.EasingDirection.In)
    wait(0.3);S.MenuOpen=false;Main.Visible=false end)

UIS.InputBegan:Connect(function(i,gp) if gp then return end
    if i.KeyCode==S.MenuKey then S.MenuOpen=not S.MenuOpen
        if S.MenuOpen then
            Main.Visible=true;Main.Size=UDim2.new(0,40,0,40);Main.Position=UDim2.new(0.5,-20,0.5,-20);Main.BackgroundTransparency=0.8
            local sz=S.Maximized and MaxSize or NormalSize;local ps=S.Maximized and MaxPos or NormalPos
            TwP(Main,{Size=sz,Position=ps,BackgroundTransparency=0},0.3,Enum.EasingStyle.Back)
        else
            TwP(Main,{Size=UDim2.new(0,40,0,40),Position=UDim2.new(0.5,-20,0.5,-20),BackgroundTransparency=0.8},0.25,Enum.EasingStyle.Back,Enum.EasingDirection.In)
            wait(0.3);Main.Visible=false
        end
    end end)

print("⚡ SUKUNA HUB v3.2 ULTIMATE")
print("👑 by sukuna")
print("🎮 H = Toggle Menu")
print("🔓 Bütün Executorlar Uyumlu!")
