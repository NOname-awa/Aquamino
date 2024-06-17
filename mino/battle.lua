local fLib=require'mino/fieldLib'
local block=require'mino/blocks'
local battle={}
function battle.init(player)
    player.garbage={} player.atkAnimList={} player.defAnimList={}
    player.lastHole=rand(player.w)
    player.defAmount=0
    player.atkScale=1 player.defScale=1
    player.atkMinusByDef=true
end
function battle.sendAtk(player,dest,atk)
    if not atk then return end
    --[[atk={
    amount=垃圾行数量
    block=什么颜色的方块，建议使用'g1' 'g2'
    cut=该组垃圾会被切割成几行一组一起进入，允许浮点数
    M_OC=Messiness On Change，该组与上一组垃圾的洞位置不一致的概率
    appearT=垃圾进槽时间
    cut=1e99 M_OC=1即标准对战垃圾
    }]]
    local x,y,ox,oy=block.size(player.history.piece)
    ins(player.atkAnimList,{x=player.history.x-ox,y=player.history.y-oy,t=0,amount=atk.amount,B2B=player.history.B2B})
    ins(dest.garbage,atk)
end
function battle.atkRecv(player,atk)
    if atk.amount==0 then return end
    player.lastHole=rand()<atk.M_OC and rand(player.w) or player.lastHole
    local h
    local l=0
    --print(atk.cut)
    for i=1,atk.amount do
        l=l+1
        local sw=rand()<(l-atk.cut)
        h=sw and rand(player.w) or player.lastHole
        player.lastHole=h
        if sw then l=0 end
        fLib.garbage(player,atk.block,1,h)
    end
end
function battle.defense(player,amount,mino)
    local n=amount*player.defScale
    local remList={}
    local defAmount=0
    while player.garbage[1] and n>0 do
        if n>=player.garbage[1].amount then
            remList[#remList+1]={pos=amount-n,amount=player.garbage[1].amount}
            defAmount=defAmount+player.garbage[1].amount
            n=n-rem(player.garbage,1).amount
        else
            player.garbage[1].amount=player.garbage[1].amount-n
            remList[#remList+1]={pos=amount-n,amount=n}
            defAmount=defAmount+n
        break end
    end
    --remList[i]={pos,amount}
    if mino.theme.updateDefenseAnim then mino.theme.updateDefenseAnim(player,remList) end

    player.defAmount=defAmount --抵消了多少攻击
end

local l,s,m,w,b,c
function battle.stdAtkCalculate(player)
    local his=player.history
    l,s,m,w,b,c=his.line,his.spin,his.mini,his.wide,his.B2B,his.combo

    local bl=(s and not m) and 2*l-1 or l>=4 and 1.5*l-1.5 or l-.5
    local ba=b>0 and (3+b)/4 or 0
    local ca=(w>=2 and w<=4) and min(c-1,.5) or max(min((c-(l==4 and 1 or 2))/2,3.5),0)
    if his.PC then return 4+l else
    return l==0 and 0 or floor(bl+ba+ca)
    end
end
function battle.stdAtkGen(player)
    local his=player.history
    l,s,m,w,b,c=his.line,his.spin,his.mini,his.wide,his.B2B,his.combo

    local atk=(battle.stdAtkCalculate(player)-(player.atkMinusByDef and player.defAmount or 0))*player.atkScale
    player.defAmount=0
    if atk<=0 then return end
    return {
        amount=atk,
        block='g1',
        cut=(w==4 or his.PC) and 1e99 or s and atk/2+b or 1e99,
        M_OC=(w>=2 and w<=4) and (4-w)*.025 or his.PC and 0 or 1/(b+atk-0.1*(c-3)),
        appearT=0,
    }
end
return battle