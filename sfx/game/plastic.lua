local plastic={}
function plastic.addSFX()
    sfx.add({
        lose='sfx/game/plastic/lose.wav',
        win='sfx/game/plastic/win.wav',
        move='sfx/game/plastic/move.wav',
        moveFail='sfx/game/plastic/move fail.wav',
        landedMove='sfx/game/plastic/landed move.wav',

        HD='sfx/game/plastic/hard drop.wav',
        lock='sfx/game/plastic/lock.wav',
        hold='sfx/game/plastic/hold.wav',
        rotate='sfx/game/plastic/rotate.wav',
        spin='sfx/game/plastic/spin.wav',
        rotateFail='sfx/game/plastic/rotate fail.wav',
        touch='sfx/game/plastic/touch.wav',

        ['1']='sfx/game/plastic/1.wav',
        ['2']='sfx/game/plastic/2.wav',
        ['3']='sfx/game/plastic/3.wav',
        ['4']='sfx/game/plastic/4.wav',
        combo='sfx/game/plastic/combo.wav',

        spinClear='sfx/game/plastic/spin clear.wav',
        PC='sfx/game/plastic/PC.wav',

        loose='sfx/game/plastic/loose.wav',
        push='sfx/game/plastic/push.wav'
    })
end
function plastic.move(player,success,landed)
    if success then
        if landed and sfx.pack.landedMove then sfx.play('landedMove') else sfx.play('move') end
    else sfx.play('moveFail') end
end
function plastic.rotate(player,success,spin)
    if success then
        if spin then sfx.play('spin')
        else sfx.play('rotate') end
    else sfx.play('rotateFail') end
end
function plastic.hold()
    sfx.play('hold')
end
function plastic.touch(player,touch)
    if touch then sfx.play('touch') end
end
function plastic.lock(player)
    if player.history.dropHeight>0 then sfx.play('HD') end
    sfx.play('lock')
end
function plastic.clear(player)
    local his=player.history
    local pitch=his.line==0 and 1 or min(2^((his.combo-1)/12),2.848)
    sfx.play(''..min(his.line,4))
    if his.spin then sfx.play('spinClear',his.line>0 and 1 or .5,his.mini and .75 or 1) end
    if his.line>0 then sfx.play('combo',1,pitch) end
    if his.PC then sfx.play('PC') end
end
function plastic.loose(player)
    sfx.play('loose')
end
function plastic.push(player)
    sfx.play('push')
end
function plastic.lose()
    sfx.play('lose')
end
function plastic.win()
    sfx.play('win')
end
return plastic