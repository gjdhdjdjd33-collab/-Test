repeat task.wait() until game:IsLoaded()
local a,b,c,d,e,f=game:GetService("Players"),game:GetService("RunService"),game:GetService("Workspace"),game:GetService("UserInputService"),game:GetService("Lighting"),a.LocalPlayer
repeat task.wait() until f and f:FindFirstChild("PlayerGui")
local g,h,i,j,k=c.CurrentCamera,"ПУЗО",false,500,150
for _,l in ipairs(f.PlayerGui:GetChildren())do if l.Name=="BCP"or l.Name=="BKW"then pcall(function()l:Destroy()end)end end
local m=Instance.new("Frame")m.Name="BKW"m.Size=UDim2.new(0,280,0,150)m.Position=UDim2.new(0.5,-140,0.5,-75)m.BackgroundColor3=Color3.fromRGB(30,60,120)m.BorderSizePixel=0m.ZIndex=60000m.Parent=f.PlayerGui
local n=Instance.new("TextLabel")n.Size=UDim2.new(1,0,0,25)n.Position=UDim2.new(0,0,0,12)n.BackgroundTransparency=1n.Text="KEY"n.TextColor3=Color3.fromRGB(255,255,255)n.Font=Enum.Font.SourceSansBoldn.TextSize=16n.Parent=m
local o=Instance.new("TextBox")o.Size=UDim2.new(0,240,0,35)o.Position=UDim2.new(0.5,-120,0,48)o.BackgroundColor3=Color3.fromRGB(45,80,150)o.Text=""o.PlaceholderText="Key..."o.TextColor3=Color3.fromRGB(255,255,255)o.Font=Enum.Font.SourceSansBoldo.TextSize=16o.ClearTextOnFocus=false o.Parent=m
local p=Instance.new("TextButton")p.Size=UDim2.new(0,240,0,32)p.Position=UDim2.new(0.5,-120,0,100)p.BackgroundColor3=Color3.fromRGB(60,100,180)p.Text="SUBMIT"p.TextColor3=Color3.fromRGB(255,255,255)p.Font=Enum.Font.SourceSansBoldp.TextSize=14p.Parent=m
p.MouseButton1Click:Connect(function()if o.Text:gsub("%s+",""):upper()==h then i=true m:Destroy()else n.Text="WRONG"n.TextColor3=Color3.fromRGB(255,80,80)o.Text=""task.wait(1)n.Text="KEY"n.TextColor3=Color3.fromRGB(255,255,255)end end)repeat task.wait()until i
local q=Instance.new("ScreenGui")q.Name="BCP"q.Parent=f.PlayerGui
local r=Instance.new("Frame")r.Size=UDim2.new(0,500,0,420)r.Position=UDim2.new(0.5,-250,0.5,-210)r.BackgroundColor3=Color3.fromRGB(35,50,90)r.BorderSizePixel=0r.Active=true r.Visible=false r.Parent=q
local s=Instance.new("Frame")s.Size=UDim2.new(1,0,0,45)s.BackgroundColor3=Color3.fromRGB(25,38,70)s.BorderSizePixel=0s.Parent=r
local t=Instance.new("TextLabel")t.Size=UDim2.new(0,300,1,0)t.Position=UDim2.new(0,15,0,0)t.BackgroundTransparency=1t.Text="BURMALDA COMBAT PRO"t.TextColor3=Color3.fromRGB(255,255,255)t.Font=Enum.Font.SourceSansBoldt.TextSize=18t.TextXAlignment=Enum.TextXAlignment.Leftt.Parent=s
local u=Instance.new("TextButton")u.Size=UDim2.new(0,45,0,45)u.Position=UDim2.new(1,-45,0,0)u.BackgroundTransparency=1u.Text="X"u.TextColor3=Color3.fromRGB(255,255,255)u.Font=Enum.Font.SourceSansBoldu.TextSize=22u.Parent=s u.MouseButton1Click:Connect(function()q:Destroy()end)
local v=Instance.new("TextButton")v.Size=UDim2.new(0,50,0,50)v.Position=UDim2.new(0,10,0.5,-25)v.BackgroundColor3=Color3.fromRGB(25,38,70)v.BorderSizePixel=0v.Text="B"v.TextColor3=Color3.fromRGB(255,255,255)v.Font=Enum.Font.SourceSansBoldv.TextSize=24v.Parent=q v.MouseButton1Click:Connect(function()r.Visible=not r.Visible end)
r.InputBegan:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then local startPos=input.Position local startFramePos=r.Position local dragCon local dragCon=d.InputChanged:Connect(function(input2)if input2.UserInputType==Enum.UserInputType.MouseMovement or input2.UserInputType==Enum.UserInputType.Touch then local delta=input2.Position-startPos r.Position=UDim2.new(startFramePos.X.Scale,startFramePos.X.Offset+delta.X,startFramePos.Y.Scale,startFramePos.Y.Offset+delta.Y)end end)local endCon endCon=d.InputEnded:Connect(function(input2)if input2.UserInputType==Enum.UserInputType.MouseButton1 or input2.UserInputType==Enum.UserInputType.Touch then dragCon:Disconnect()endCon:Disconnect()end end)end end)
local w=Instance.new("Frame")w.Size=UDim2.new(0,120,1,-45)w.Position=UDim2.new(0,0,0,45)w.BackgroundColor3=Color3.fromRGB(25,38,70)w.BorderSizePixel=0w.Parent=r
local x=Instance.new("Frame")x.Size=UDim2.new(1,-130,1,-55)x.Position=UDim2.new(0,125,0,50)x.BackgroundColor3=Color3.fromRGB(30,43,80)x.BorderSizePixel=0x.Parent=r
local y,z,A,B,C,D,E,F,G,H,I,J,K,L,M={},{},false,false,false,false,"ENEMIES","ENEMIES","ENEMIES",false,"Head","Head",false,false,false
local N={"ENEMIES","ALL","TEAM"}
local O={"Head","Body"}
local function P(j,k)local l=Instance.new("Frame")l.Size=UDim2.new(1,0,1,0)l.BackgroundTransparency=1l.Visible=false l.Parent=j y[k]=l return l end
local Q=P(x,"Aimbot")local R=P(x,"AimAssist")local S=P(x,"ESP")local T=P(x,"Protection")local U=P(x,"Settings")Q.Visible=true
local function V(j,k,l,m)local n=Instance.new("TextButton")n.Size=UDim2.new(0,105,0,35)n.Position=UDim2.new(0,7,0,15+(m-1)*45)n.BackgroundColor3=(k=="Aimbot")and Color3.fromRGB(60,100,180)or Color3.fromRGB(35,50,90)n.Text=l n.TextColor3=Color3.fromRGB(255,255,255)n.Font=Enum.Font.SourceSansBoldn.TextSize=14n.Parent=j z[k]=n n.MouseButton1Click:Connect(function()for i,o in pairs(y)do o.Visible=false end y[k].Visible=true for i,o in pairs(z)do o.BackgroundColor3=(i==k)and Color3.fromRGB(60,100,180)or Color3.fromRGB(35,50,90)end end)end
V(w,"Aimbot","AIMBOT",1)V(w,"AimAssist","AIM ASSIST",2)V(w,"ESP","ESP",3)V(w,"Protection","PROTECT",4)V(w,"Settings","SETTINGS",5)
local function W(j,k,l,m,n)local o=Instance.new("TextButton")o.Size=UDim2.new(0,200,0,35)o.Position=UDim2.new(0.5,-100,0,l)o.BackgroundColor3=m and Color3.fromRGB(40,150,60)or Color3.fromRGB(60,100,180)o.Text=k..(m and": ON"or": OFF")o.TextColor3=Color3.fromRGB(255,255,255)o.Font=Enum.Font.SourceSansBoldo.TextSize=14o.Parent=j local p=m o.MouseButton1Click:Connect(function()p=not p o.Text=k..(p and": ON"or": OFF")o.BackgroundColor3=p and Color3.fromRGB(40,150,60)or Color3.fromRGB(60,100,180)if n then n(p)end end)end
local function X(j,k,l,m,n,o)local p=Instance.new("TextButton")p.Size=UDim2.new(0,200,0,35)p.Position=UDim2.new(0.5,-100,0,l)p.BackgroundColor3=Color3.fromRGB(60,100,180)p.Text=k..": "..m p.TextColor3=Color3.fromRGB(255,255,255)p.Font=Enum.Font.SourceSansBoldp.TextSize=14p.Parent=j local q=1 for r,s in ipairs(o)do if s==m then q=r break end end p.MouseButton1Click:Connect(function()q=q%#o+1 p.Text=k..": "..o[q]if n then n(o[q])end end)end
local function Y(j,k,l,m,n,o,p)local q=Instance.new("Frame")q.Size=UDim2.new(0,200,0,60)q.Position=UDim2.new(0.5,-100,0,l)q.BackgroundColor3=Color3.fromRGB(45,80,150)q.BorderSizePixel=0q.Parent=j local r=Instance.new("TextLabel")r.Size=UDim2.new(1,0,0,20)r.Position=UDim2.new(0,0,0,3)r.BackgroundTransparency=1r.Text=k..": "..tostring(o)r.TextColor3=Color3.fromRGB(255,255,255)r.Font=Enum.Font.SourceSansBoldr.TextSize=12r.Parent=q local s=Instance.new("Frame")s.Size=UDim2.new(0,180,0,6)s.Position=UDim2.new(0.5,-90,0,30)s.BackgroundColor3=Color3.fromRGB(30,43,80)s.BorderSizePixel=0s.Parent=q local t=Instance.new("Frame")t.Size=UDim2.new((o-m)/(n-m),0,1,0)t.BackgroundColor3=Color3.fromRGB(40,150,60)t.BorderSizePixel=0t.Parent=s local u=false local function v(w)local x=math.clamp((w.Position.X-s.AbsolutePosition.X)/s.AbsoluteSize.X,0,1)t.Size=UDim2.new(x,0,1,0)local y=math.floor(m+(n-m)*x)r.Text=k..": "..tostring(y)if p then p(y)end end s.InputBegan:Connect(function(w)if w.UserInputType==Enum.UserInputType.MouseButton1 then u=true v(w)end end)d.InputChanged:Connect(function(w)if u and w.UserInputType==Enum.UserInputType.MouseMovement then v(w)end end)d.InputEnded:Connect(function(w)if w.UserInputType==Enum.UserInputType.MouseButton1 then u=false end end)end

W(Q,"Aimbot",10,false,function(v)A=v end)X(Q,"Target",60,E,function(v)E=v end,N)X(Q,"Hit Part",110,J,function(v)J=v end,O)W(Q,"WallCheck",165,false,function(v)B=v end)Y(Q,"Distance",215,50,1000,j,function(v)j=v end)Y(Q,"FOV",290,30,500,k,function(v)k=v end)
W(R,"Aim Assist",10,false,function(v)C=v end)X(R,"Target",60,F,function(v)F=v end,N)X(R,"Hit Part",110,K,function(v)K=v end,O)W(R,"WallCheck",165,false,function(v)D=v end)Y(R,"Distance",215,50,1000,j,function(v)j=v end)Y(R,"FOV",290,30,500,k,function(v)k=v end)
W(S,"ESP",10,false,function(v)I=v end)X(S,"ESP Mode",60,G,function(v)G=v end,N)
W(T,"Anti Kick",10,false,function(v)L=v end)W(T,"Anti Fling",60,false,function(v)M=v end)W(T,"Anti Detect",110,false,function(v)H=v end)

local Z=Instance.new("TextLabel")Z.Size=UDim2.new(0,200,0,30)Z.Position=UDim2.new(0.5,-100,0,20)Z.BackgroundTransparency=1Z.Text="BURMALDA COMBAT PRO"Z.TextColor3=Color3.fromRGB(255,255,255)Z.Font=Enum.Font.SourceSansBoldZ.TextSize=14Z.Parent=U
local _=Instance.new("TextLabel")_.Size=UDim2.new(0,200,0,60)_.Position=UDim2.new(0.5,-100,0,70)_.BackgroundTransparency=1_.Text="Full Protection Suite\nAnti Kick / Fling / Detect"_.TextColor3=Color3.fromRGB(200,210,230)_.Font=Enum.Font.SourceSans_.TextSize=12_.TextXAlignment=Enum.TextXAlignment.Center_.Parent=U

local a0=Drawing.new("Circle")a0.Color=Color3.fromRGB(255,255,255)a0.Thickness=1a0.NumSides=64a0.Radius=k a0.Transparency=0.4a0.Visible=false a0.Filled=false

local function b0(h)if h.Team then return h.Team end if h:FindFirstChild("Team")then return h.Team end return nil end
local function c0(h,l)if h==f then return false end local m=h.Character if not m then return false end local n=m:FindFirstChild("HumanoidRootPart")if not n then return false end local o=m:FindFirstChildOfClass("Humanoid")if not o or o.Health<=0 then return false end if l=="ALL"then return true end local p=b0(f)local q=b0(h)if l=="ENEMIES"then return p~=q end if l=="TEAM"then return p==q end return false end
local function d0(h)local i,j=g:WorldToViewportPoint(h)return Vector2.new(i.X,i.Y),j end
local function e0(h,i,l)if not l then return false end local dir=(i-h).Unit local dist=(i-h).Magnitude local rayParams=RaycastParams.new()rayParams.FilterType=Enum.RaycastFilterType.Exclude rayParams.FilterDescendantsInstances={f.Character}local result=c:Raycast(h,dir*dist,rayParams)if result then local hit=result.Instance local plr=a:GetPlayerFromCharacter(hit.Parent)if plr then return false end return true end return false end

local function f0(l,m,n,o,p)
    local q=d:GetMouseLocation()
    local r=n or k
    local s=nil
    for _,t in ipairs(a:GetPlayers())do
        if not c0(t,l)then continue end
        local u=t.Character
        local v=u:FindFirstChild(o=="Head"and"Head"or"HumanoidRootPart")
        if not v then continue end
        local w,x=d0(v.Position)
        if not x then continue end
        local y=(w-q).Magnitude
        if y>=r then continue end
        local z=f.Character and f.Character:FindFirstChild("HumanoidRootPart")
        local A=z and(z.Position-v.Position).Magnitude or 0
        if A>(m or j)then continue end
        if(z and e0(z.Position,v.Position,p))then continue end
        r=y
        s=v
    end
    return s
end

local g0={}
local function h0(h)if g0[h]then for _,i in ipairs(g0[h])do i:Remove()end g0[h]=nil end end
local function i0(h)h0(h)local i={}i[1]=Drawing.new("Square")i[1].Thickness=1 i[1].Filled=false i[2]=Drawing.new("Line")i[2].Thickness=1 i[2].Transparency=0.7 i[3]=Drawing.new("Text")i[3].Size=14 i[3].Center=true i[3].Outline=true i[4]=Drawing.new("Text")i[4].Size=12 i[4].Center=true i[4].Outline=true g0[h]=i end

b.Heartbeat:Connect(function()
    a0.Radius=k
    a0.Position=Vector2.new(g.ViewportSize.X/2,g.ViewportSize.Y/2)
    a0.Visible=A or C
    
    if A then
        local target=f0(E,j,k,J,B)
        if target then
            g.CFrame=CFrame.lookAt(g.CFrame.Position,target.Position)
        end
    end
    
    if C then
        local char=f.Character
        if char then
            local hrp=char:FindFirstChild("HumanoidRootPart")
            local hum=char:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health>0 then
                local target=f0(F,j,k,K,D)
                if target then
                    local dir=(target.Position-hrp.Position).Unit
                    hrp.CFrame=hrp.CFrame:Lerp(CFrame.lookAt(hrp.Position,hrp.Position+dir),0.25)
                    hrp.Velocity=dir*30
                end
            end
        end
    end
    
    if L then
        pcall(function()
            local char=f.Character
            if char then
                local hum=char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
                end
                for _,v in ipairs(char:GetDescendants())do
                    if v:IsA("BasePart")then
                        v.CanCollide=true
                        v.CustomPhysicalProperties=PhysicalProperties.new(100,1,1,1,1)
                    end
                end
            end
        end)
    end
    
    if M then
        pcall(function()
            local char=f.Character
            if char then
                local hrp=char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Velocity=Vector3.zero
                    hrp.RotVelocity=Vector3.zero
                    hrp.AssemblyLinearVelocity=Vector3.zero
                    hrp.AssemblyAngularVelocity=Vector3.zero
                end
            end
        end)
    end
    
    if H then
        pcall(function()
            for _,v in ipairs(c:GetDescendants())do
                if v:IsA("Script")and(v.Name:lower():find("anti")or v.Name:lower():find("detect")or v.Name:lower():find("check"))then
                    v.Enabled=false
                end
            end
            local char=f.Character
            if char then
                for _,v in ipairs(char:GetDescendants())do
                    if v:IsA("Script")and(v.Name:lower():find("anti")or v.Name:lower():find("detect")or v.Name:lower():find("check"))then
                        v.Enabled=false
                    end
                end
            end
        end)
    end
end)

b.RenderStepped:Connect(function()
    if not I then for h,_ in pairs(g0)do h0(h)end return end
    for _,h in ipairs(a:GetPlayers())do
        if not c0(h,G)and G~="ALL"then h0(h)continue end
        local i=h.Character local j=i and i:FindFirstChild("HumanoidRootPart")local l=i and i:FindFirstChild("Head")local m=i and i:FindFirstChildOfClass("Humanoid")
        if not j or not l or not m or m.Health<=0 then h0(h)continue end
        if not g0[h]then i0(h)end local n=g0[h]if not n then continue end
        local o=b0(f)local p=b0(h)local q=o~=p
        local r=G=="ALL"and(q and Color3.fromRGB(255,60,60)or Color3.fromRGB(50,200,100))or(G=="ENEMIES"and Color3.fromRGB(255,60,60)or Color3.fromRGB(50,120,255))
        local s,t=d0(l.Position)local u,v=d0(j.Position)
        if t or v then
            local w=(s-u).Magnitude local x=Vector2.new(w*0.6,w)local y=Vector2.new(u.X-x.X/2,s.Y)
            n[1].Color=r n[1].Size=x n[1].Position=y n[1].Visible=true
            n[2].From=Vector2.new(g.ViewportSize.X/2,g.ViewportSize.Y)n[2].To=u n[2].Color=r n[2].Visible=true
            local z=f.Character and f.Character:FindFirstChild("HumanoidRootPart")and math.floor((f.Character.HumanoidRootPart.Position-j.Position).Magnitude)or 0
            n[3].Text=z.."m"n[3].Position=Vector2.new(u.X,u.Y+15)n[3].Color=r n[3].Visible=true
            n[4].Text=h.Name n[4].Position=Vector2.new(u.X,u.Y-15)n[4].Color=r n[4].Visible=true
        else for _,A in ipairs(n)do A.Visible=false end end
    end
end)
