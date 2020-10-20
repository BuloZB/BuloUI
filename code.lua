MainMenuBarArtFrame:ClearAllPoints()
MainMenuBarArtFrame:SetPoint("CENTER",2,2)
MainMenuBarArtFrame.SetPoint = function() end
MainMenuBarArtFrame:SetScale(1.16)
 
ActionButton1:ClearAllPoints()
ActionButton1:SetPoint("cENTER",-233,-2)
ActionButton1.SetPoint = function() end
 
MultiBarBottomRightButton7:ClearAllPoints()
MultiBarBottomRightButton7:SetPoint("cENTER",-650,41)
MultiBarBottomRightButton7.SetPoint = function() end
 
MultiBarBottomRightButton1:ClearAllPoints()
MultiBarBottomRightButton1:SetPoint("cENTER",-398,41)
MultiBarBottomRightButton1.SetPoint = function() end
 
MultiBarBottomLeftButton1:ClearAllPoints()
 
ActionBarUpButton:Hide()
ActionBarDownButton:Hide()
FocusFrameSpellBar:SetScale(1.88)
 
MainMenuBarArtFrameBackground:Hide()
MainMenuBarArtFrame.LeftEndCap:Hide()
MainMenuBarArtFrame.RightEndCap:Hide()
MainMenuBarArtFrame.PageNumber:Hide()
 
MultiBarBottomLeftButton1:SetPoint("cENTER",-232,47)
MultiBarBottomLeftButton1.SetPoint = function() end
StanceButton1:ClearAllPoints()
StanceButton1:SetPoint("cENTER",-6000,0)
StanceButton1.SetPoint = function() end
 
--function Movebuff() BuffFrame:ClearAllPoints() BuffFrame:SetScale(1.1) BuffFrame:SetPoint("CENTER",PlayerFrame,"CENTER",950,80) end  hooksecurefunc("UIParent_UpdateTopFramePositions",Movebuff) Movebuff()
 --remove -- if you want activate function for movebuff comand
LoadAddOn("Blizzard_ArenaUI")
ArenaEnemyFrame1:ClearAllPoints()
ArenaEnemyFrame2:ClearAllPoints()
ArenaEnemyFrame3:ClearAllPoints()
 
ArenaEnemyFrame1:SetPoint("CENTER",UIParent,"CENTER",240,40)
ArenaEnemyFrame2:SetPoint("CENTER",UIParent,"CENTER",240,0)
ArenaEnemyFrame3:SetPoint("CENTER",UIParent,"CENTER",240,-40)
 
ArenaEnemyFrame1.SetPoint = function() end
ArenaEnemyFrame2.SetPoint = function() end
ArenaEnemyFrame3.SetPoint = function() end
 
ArenaEnemyFrames:SetScale(1.6)
PlayerFrame:SetScale(1.25)
TargetFrame:SetScale(1.25)
FocusFrame:SetScale(1.25)
TargetFrameSpellBar:SetScale(1.88)
for i=0,3 do _G["MainMenuBarTexture"..i]:Hide();end
 
TargetFrameSpellBar:ClearAllPoints();TargetFrameSpellBar:SetPoint("CENTER", UIParent, "CENTER", -125, 110);TargetFrameSpellBar.SetPoint = function() end
FocusFrameSpellBar:SetScale(1.88)
 
FocusFrameSpellBar:ClearAllPoints();FocusFrameSpellBar:SetPoint("CENTER", UIParent, "CENTER", -100, -110);FocusFrameSpellBar.SetPoint = function() end
 
SetCVar('BreakUpLargeNumbers', 0)
 
PetActionBarFrame:ClearAllPoints()PetActionBarFrame:SetScale(1)PetActionBarFrame:SetPoint("RIGHT", UIParent, "CENTER", 290, -255)PetActionBarFrame.SetPoint=function()end
local b=HonorWatchBar b:UnregisterAllEvents() b:Hide() b.Show=b.Hide
local b=ArtifactWatchBar b:UnregisterAllEvents() b:Hide() b.Show=b.Hide
SetCVar("nameplateOccludedAlphaMult",1)
 
local t="Interface\\TargetingFrame\\UI-TargetingFrame-rare"PlayerFrameTexture:SetTexture(t)hooksecurefunc("TargetFrame_Update",function(f)if UnitIsPlayer(f.unit)then _G[f:GetName().."TextureFrameTexture"]:SetTexture(t)end end)
 
function sp(f,i) tr="TOPRIGHT";f2=f.debuffFrames;s=f2[1]:GetWidth();f3=f2[i];f3:SetSize(s,s);f3:ClearAllPoints();if i>6 then f3:SetPoint("BOTTOMRIGHT",f2[i-3],tr,0,0) else f3:SetPoint(tr,f2[1],tr,-(s*(i-3)),0) end end
function CBF(f,i) bf=CreateFrame("Button",f:GetName().."Debuff"..i,f,"CompactDebuffTemplate");bf.baseSize=22;bf:SetSize(f.buffFrames[1]:GetSize()) end;function mv(f) for i=4,12 do sp(f,i) end end
function mv3(f) CompactUnitFrame_SetMaxDebuffs(f,12); if not f.debuffFrames[4] then for i=4,12 do CBF(f,i) end end mv(f) end;hooksecurefunc("CompactUnitFrame_UpdateDebuffs",function(f) if f:GetName():match("^Compact") then mv3(f) end end);