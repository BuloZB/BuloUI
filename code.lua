local function safeFrame(name)
  local f = _G[name]
  if f and f.ClearAllPoints and f.SetPoint then
    return f
  end
  return nil
end

local function noopSetPoint(frame)
  if frame then
    frame.SetPoint = function() end
  end
end

local function safeHide(name)
  local f = _G[name]
  if f and f.Hide then
    f:Hide()
  end
end

local mm = safeFrame("MainMenuBarArtFrame")
if mm then
  mm:ClearAllPoints()
  mm:SetPoint("CENTER", 2, 2)
  noopSetPoint(mm)
  if mm.SetScale then mm:SetScale(1.16) end

  local left = mm.LeftEndCap
  if left and left.Hide then left:Hide() end

  local right = mm.RightEndCap
  if right and right.Hide then right:Hide() end

  local page = mm.PageNumber
  if page and page.Hide then page:Hide() end
end

local ab1 = safeFrame("ActionButton1")
if ab1 then
  ab1:ClearAllPoints()
  ab1:SetPoint("CENTER", -233, -2)
  noopSetPoint(ab1)
end

local mbr7 = safeFrame("MultiBarBottomRightButton7")
if mbr7 then
  mbr7:ClearAllPoints()
  mbr7:SetPoint("CENTER", -650, 41)
  noopSetPoint(mbr7)
end

local mbr1 = safeFrame("MultiBarBottomRightButton1")
if mbr1 then
  mbr1:ClearAllPoints()
  mbr1:SetPoint("CENTER", -398, 41)
  noopSetPoint(mbr1)
end

local mbl1 = safeFrame("MultiBarBottomLeftButton1")
if mbl1 then
  mbl1:ClearAllPoints()
  mbl1:SetPoint("CENTER", -232, 47)
  noopSetPoint(mbl1)
end

safeHide("ActionBarUpButton")
safeHide("ActionBarDownButton")

local focusSpell = safeFrame("FocusFrameSpellBar")
if focusSpell and focusSpell.SetScale then
  focusSpell:SetScale(1.88)
end

safeHide("MainMenuBarArtFrameBackground")

local stance1 = safeFrame("StanceButton1")
if stance1 then
  stance1:ClearAllPoints()
  stance1:SetPoint("CENTER", -6000, 0)
  noopSetPoint(stance1)
end

-- function Movebuff() BuffFrame:ClearAllPoints() BuffFrame:SetScale(1.1) BuffFrame:SetPoint("CENTER",PlayerFrame,"CENTER",950,80) end
-- hooksecurefunc("UIParent_UpdateTopFramePositions",Movebuff) Movebuff()

-- Arena frames (TBC)
pcall(function()
  LoadAddOn("Blizzard_ArenaUI")
end)

local arena1 = safeFrame("ArenaEnemyFrame1")
local arena2 = safeFrame("ArenaEnemyFrame2")
local arena3 = safeFrame("ArenaEnemyFrame3")

if arena1 and arena2 and arena3 then
  arena1:ClearAllPoints()
  arena2:ClearAllPoints()
  arena3:ClearAllPoints()

  arena1:SetPoint("CENTER", UIParent, "CENTER", 240, 40)
  arena2:SetPoint("CENTER", UIParent, "CENTER", 240, 0)
  arena3:SetPoint("CENTER", UIParent, "CENTER", 240, -40)

  noopSetPoint(arena1)
  noopSetPoint(arena2)
  noopSetPoint(arena3)

  if _G.ArenaEnemyFrames and _G.ArenaEnemyFrames.SetScale then
    _G.ArenaEnemyFrames:SetScale(1.6)
  end
end

if _G.PlayerFrame and _G.PlayerFrame.SetScale then _G.PlayerFrame:SetScale(1.25) end
if _G.TargetFrame and _G.TargetFrame.SetScale then _G.TargetFrame:SetScale(1.25) end
if _G.FocusFrame and _G.FocusFrame.SetScale then _G.FocusFrame:SetScale(1.25) end

local targetSpell = safeFrame("TargetFrameSpellBar")
if targetSpell and targetSpell.SetScale then
  targetSpell:SetScale(1.88)
  targetSpell:ClearAllPoints()
  targetSpell:SetPoint("CENTER", UIParent, "CENTER", -125, 110)
  noopSetPoint(targetSpell)
end

if focusSpell and focusSpell.ClearAllPoints then
  focusSpell:ClearAllPoints()
  focusSpell:SetPoint("CENTER", UIParent, "CENTER", -100, -110)
  noopSetPoint(focusSpell)
end

for i = 0, 3 do
  local tex = _G["MainMenuBarTexture" .. i]
  if tex and tex.Hide then
    tex:Hide()
  end
end

pcall(function()
  SetCVar("BreakUpLargeNumbers", 0)
  SetCVar("nameplateOccludedAlphaMult", 1)
end)

local pet = safeFrame("PetActionBarFrame")
if pet then
  pet:ClearAllPoints()
  if pet.SetScale then pet:SetScale(1) end
  pet:SetPoint("RIGHT", UIParent, "CENTER", 290, -255)
  noopSetPoint(pet)
end

-- Retail-only watch bars (guarded for TBC)
local honor = _G.HonorWatchBar
if honor and honor.UnregisterAllEvents and honor.Hide then
  honor:UnregisterAllEvents()
  honor:Hide()
  honor.Show = honor.Hide
end

local artifact = _G.ArtifactWatchBar
if artifact and artifact.UnregisterAllEvents and artifact.Hide then
  artifact:UnregisterAllEvents()
  artifact:Hide()
  artifact.Show = artifact.Hide
end

local t = "Interface\\TargetingFrame\\UI-TargetingFrame-rare"
if _G.PlayerFrameTexture and _G.PlayerFrameTexture.SetTexture then
  _G.PlayerFrameTexture:SetTexture(t)
end

if hooksecurefunc then
  hooksecurefunc("TargetFrame_Update", function(f)
    if f and f.unit and UnitIsPlayer(f.unit) then
      local tex = _G[f:GetName() .. "TextureFrameTexture"]
      if tex and tex.SetTexture then
        tex:SetTexture(t)
      end
    end
  end)
end
 
-- Compact unitframe debuff layout (guard for clients where CompactUnitFrame API differs)
if _G.CompactUnitFrame_UpdateDebuffs and _G.CompactUnitFrame_SetMaxDebuffs and CreateFrame and hooksecurefunc then
  local function sp(f, i)
    local tr = "TOPRIGHT"
    local f2 = f.debuffFrames
    if not (f2 and f2[1] and f2[i] and f2[1].GetWidth) then return end

    local s = f2[1]:GetWidth()
    local f3 = f2[i]
    if not (f3.SetSize and f3.ClearAllPoints and f3.SetPoint) then return end

    f3:SetSize(s, s)
    f3:ClearAllPoints()

    if i > 6 then
      f3:SetPoint("BOTTOMRIGHT", f2[i - 3], tr, 0, 0)
    else
      f3:SetPoint(tr, f2[1], tr, -(s * (i - 3)), 0)
    end
  end

  local function CBF(f, i)
    if not (f and f.GetName and f.buffFrames and f.buffFrames[1] and f.buffFrames[1].GetSize) then return end
    local bf = CreateFrame("Button", f:GetName() .. "Debuff" .. i, f, "CompactDebuffTemplate")
    if not bf then return end
    bf.baseSize = 22
    bf:SetSize(f.buffFrames[1]:GetSize())
  end

  local function mv(f)
    for i = 4, 12 do
      sp(f, i)
    end
  end

  local function mv3(f)
    if not (f and f.debuffFrames) then return end
    _G.CompactUnitFrame_SetMaxDebuffs(f, 12)
    if not f.debuffFrames[4] then
      for i = 4, 12 do
        CBF(f, i)
      end
    end
    mv(f)
  end

  hooksecurefunc("CompactUnitFrame_UpdateDebuffs", function(f)
    if f and f.GetName and f:GetName():match("^Compact") then
      mv3(f)
    end
  end)
end
