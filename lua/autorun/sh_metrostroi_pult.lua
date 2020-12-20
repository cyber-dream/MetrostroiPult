if CLIENT then 
    hook.Add("PlayerButtonDown","menu",function(ply,key) --bind key for create pult window
        if key == KEY_PAGEUP then
            SpawnPultWindow()
        end
    end)

    local metrostroiPultDebug = true 

    function GetHtmlForCurrentMap() --Return html file with pult
        if metrostroiPultDebug then
            html =  file.Read( "gm_practice_pult.txt", "DATA" )
        else
            html = [[ Placeholder ]] 
        end
    return html
    end

    function SpawnPultWindow() --Create pult main window
        if !windowPult or !windowPult:IsValid() then
            windowPult = vgui.Create("DFrame")
            windowPult:SetDeleteOnClose(true)
            windowPult:SetTitle(Metrostroi.GetPhrase("Common.Couple.Title"))
            windowPult:SetSize(1280,720)
            windowPult:SetDraggable(true)
            windowPult:SetSizable(false)
            windowPult:Center()
            windowPult:MakePopup()
            local html = vgui.Create( "DHTML" , windowPult )
            html:Dock( FILL )
            html:SetHTML( GetHtmlForCurrentMap() )
            html:SetAllowLua( true )
            html:ConsoleMessage( print)
            html:AddFunction( "metrostroi", "getText", Metrostroi.GetPhrase)
        end
    end
end






if SERVER then 
    util.AddNetworkString("debug")
        
    function SetSwitch(name, status)
        for key,val in pairs(ents.FindByClass("gmod_track_switch")) do
            if(val.Name == name) then 
                val:SwitchTo(status)
            end
        end
    end
end

net.Receive("debug", function()
	SetSwitchState("sw2","alt")
end)
