--- File Name : player_group.lua
--- Created By : liruiguang
--- Description: 玩家组

local setmetatable = setmetatable
local ipairs = ipairs

---@class player_group
local player_group = {}
player_group.__index = player_group
y3.player_group = player_group


function player_group.create_lua_player_group_from_py(py_player_group)
    local new = {}
    local py = py_obj.new(py_player_group)
    new.base = py
    setmetatable(new, player_group)
    return new
end

--遍历玩家组中玩家做动作
function player_group.pick(group)
    local lua_table ={}
    for i = 0, python_len(group)-1 do
        local iter_player = python_index(group,i)
        table.insert(lua_table,y3.player(iter_player))
    end
    return lua_table
end

---@param player player 玩家
--添加玩家
function player_group.add_player(player,group)
    game_api.add_role_to_group(player.base(), group)
end

---@param player player 玩家
--移除玩家
function player_group.remove_player(player,group)
    game_api.rem_role_from_group(player.base(), group)
end

--清空组
function player_group.clear_group(group)
    global_api.clear_group(group)
end

---获取玩家组的玩家数量
function player_group.get_player_num(group)
    return global_api.get_player_group_num(group)
end
---@return player_group player_group 单位组
---獲取所有玩家
function player_group.get_all_players()
    return game_api.get_all_role_ids()
end

---@param camp integer 陣營
---@return player_group player_group 单位组
---陣營內所有玩家
function player_group.get_player_group_by_camp(camp)
    return game_api.get_role_ids_by_camp(camp)
end

---@param player player 玩家
---@return player_group player_group 单位组
---玩家的所有敌对玩家
function player_group.get_enemy_player_group_by_player(player)
    return game_api.get_enemy_ids_by_role(player.base())
end

---@param player player 玩家
---@return player_group player_group 单位组
---玩家的所有同盟玩家
function player_group.get_ally_player_group_by_player(player)
    return game_api.get_ally_ids_by_role(player.base())
end

---@return player_group player_group 单位组
---获取所有胜利的玩家
function player_group.get_victorious_player_group()
    return game_api.get_victorious_role_ids()
end

---@return player_group player_group 单位组
---获取所有失败的玩家
function player_group.get_defeated_player_group()
    return game_api.get_defeated_role_ids()
end

---@return player_group player_group 单位组
---所有非中立玩家
function player_group.get_neutral_player_group()
    return game_api.get_role_ids_by_type(1)
end
