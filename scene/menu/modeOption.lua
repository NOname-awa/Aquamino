local BUTTON,SLIDER=scene.button,scene.slider
local lst={}

function lst.button()
    local argTxt=user.lang.menu.arg
    BUTTON.setLayer(2)
end
function lst.slider(menu)
    local argTxt=user.lang.menu.arg
    local opt=menu.option
    SLIDER.create('battle_botDropDelay',{
        x=0,y=-64,type='hori',sz={800,32},button={32,32},
        gear=0,pos=(1/opt.battle.bot_DropDelay-.2)/4.8,
        act=function ()
            return menu.lvl==2 and menu.selectedMode=='battle'
        end,
        sliderDraw=function(g,sz)
            if menu.lvl==2 and menu.selectedMode=='battle' then
            gc.setColor(.5,.5,.5,.8)
            gc.polygon('fill',-sz[1]/2-8,0,-sz[1]/2,-8,sz[1]/2,-8,sz[1]/2+8,0,sz[1]/2,8,-sz[1]/2,8)
            gc.setColor(1,1,1)
            gc.printf(string.format(argTxt.battle.bot_PPS.."%.2f",1/opt.battle.bot_DropDelay),
                font.JB,-416,-48,114514,'left',0,.3125,.3125,0,84)
            end
        end,
        buttonDraw=function(pos,sz)
            if menu.lvl==2 and menu.selectedMode=='battle' then
            gc.setColor(1,1,1)
            gc.circle('fill',sz[1]*(pos-.5),0,20,4)
            end
        end,
        always=function(pos)
            if menu.lvl==2 and menu.selectedMode=='battle' then
            opt.battle.bot_DropDelay=1/(4.8*pos+.2)
            end
        end
    })
    SLIDER.create('battle_playerPos',{
        x=0,y=64,type='hori',sz={500,32},button={32,32},
        gear=2,pos=opt.battle.playerPos=='left' and 0 or 1,
        act=function ()
            return menu.lvl==2 and menu.selectedMode=='battle'
        end,
        sliderDraw=function(g,sz)
            if menu.lvl==2 and menu.selectedMode=='battle' then
            gc.setColor(.5,.5,.5,.8)
            gc.polygon('fill',-sz[1]/2-8,0,-sz[1]/2,-8,sz[1]/2,-8,sz[1]/2+8,0,sz[1]/2,8,-sz[1]/2,8)
            gc.setColor(1,1,1)
            gc.printf(argTxt.battle.player.pos..argTxt.battle.player[opt.battle.playerPos],
                font.JB,-266,-48,114514,'left',0,.3125,.3125,0,84)
            end
        end,
        buttonDraw=function(pos,sz)
            if menu.lvl==2 and menu.selectedMode=='battle' then
            gc.setColor(1,1,1)
            gc.circle('fill',sz[1]*(pos==0 and -.5 or .5),0,20,4)
            end
        end,
        always=function(pos)
            if menu.lvl==2 and menu.selectedMode=='battle' then
            opt.battle.playerPos=pos==0 and 'left' or 'right'
            end
        end
    })
    SLIDER.create('cd_botDropDelay',{
        x=0,y=-64,type='hori',sz={800,32},button={32,32},
        gear=0,pos=(1/opt['core destruction'].bot_DropDelay-.2)/4.8,
        act=function ()
            return menu.lvl==2 and menu.selectedMode=='core destruction'
        end,
        sliderDraw=function(g,sz)
            if menu.lvl==2 and menu.selectedMode=='core destruction' then
            gc.setColor(.5,.5,.5,.8)
            gc.polygon('fill',-sz[1]/2-8,0,-sz[1]/2,-8,sz[1]/2,-8,sz[1]/2+8,0,sz[1]/2,8,-sz[1]/2,8)
            gc.setColor(1,1,1)
            gc.printf(string.format(argTxt.battle.bot_PPS.."%.2f",1/opt['core destruction'].bot_DropDelay),
                font.JB,-416,-48,114514,'left',0,.3125,.3125,0,84)
            end
        end,
        buttonDraw=function(pos,sz)
            if menu.lvl==2 and menu.selectedMode=='core destruction' then
            gc.setColor(1,1,1)
            gc.circle('fill',sz[1]*(pos-.5),0,20,4)
            end
        end,
        always=function(pos)
            if menu.lvl==2 and menu.selectedMode=='core destruction' then
            opt['core destruction'].bot_DropDelay=1/(4.8*pos+.2)
            end
        end
    })
end
return lst