-- onoes v0.01
function p(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg, 1, .4, .4);
end

function stkGetShapeshiftForm()
  local myForm = nil
  local numForms = GetNumShapeshiftForms()
  for i=1, numForms,1 do 
    icon,name,active=GetShapeshiftFormInfo(i)
    if (active==1) then
      myForm=name
      break
    end
  end
  return myForm
end

function onoes_OnLoad()

	this:RegisterEvent("UNIT_HEALTH")
	this:RegisterEvent("UNIT_MANA")

end

function onoes_OnEvent(event)

    local TARGET_PCT = 35
    local class = UnitClass("player")

    if health_flag == nil then health_flag = 0 end
    if mana_flag == nil then mana_flag = 0 end


    local h_need = 100 - (UnitHealthMax("player") - UnitHealth("player") ) / UnitHealthMax("player") * 100

    local m_need = 100 -  (UnitManaMax("player") - UnitMana("player") ) / UnitManaMax("player") * 100

    if h_need < TARGET_PCT and (health_flag ~= 1) then
        DoEmote('healme')
        p("Warning Health at: "..h_need.." \%")
        health_flag = 1
    end
    if h_need > TARGET_PCT and (health_flag ~= 0) then
        health_flag = 0
    end

    if string.find( "Druid|Mage|Warlock|Priest|Paladin|Shaman|Hunter",class) then

        if not stkGetShapeshiftForm() or not string.find("Druid",class) then
            if m_need < TARGET_PCT  and (mana_flag ~= 1) then
                DoEmote('oom')
                p("Warning Mana at: "..m_need.." \%")   
                mana_flag = 1       
            end
        if m_need > TARGET_PCT and  (mana_flag ~= 0) then
            mana_flag = 0
        end
    end
    
end

end