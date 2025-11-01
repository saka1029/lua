function array_new(n, v)
    local a = {}
    for i = 1, n do
        table.insert(a, v)
    end
    return a
end

function array_print(a) 
    local s = "";
    for _, v in pairs(a) do
        s = s .. " " .. v
    end
    print(string.sub(s, 2))
end

function permutation_recursive_callback(n, k, callback)
    print("permutation_recursive_callback(" .. n .. ", " .. k .. ", callback)")
    local result = array_new(k, 0)
    local used = array_new(n, false)
    local function solve(i)
        if i > k then
            callback({table.unpack(result)})
        else
            for j = 1, n do
                if not used[j] then
                    used[j] = true
                    result[i] = j
                    solve(i + 1)
                    used[j] = false
                end
            end
        end
    end
    solve(1)
end

function permutation_recursive_array(n, k)
    print("permutation_recursive_array(" .. n .. ", " .. k .. ")")
    local ret = {}
    local result = array_new(k, 0)
    local used = array_new(n, false)
    local function solve(i)
        if i > k then
            table.insert(ret, {table.unpack(result)})
        else
            for j = 1, n do
                if not used[j] then
                    used[j] = true
                    result[i] = j
                    solve(i + 1)
                    used[j] = false
                end
            end
        end
    end
    solve(1)
    return ret
end

permutation_recursive_callback(3, 3, array_print)

local result = permutation_recursive_array(3, 3)
for _, v in pairs(result) do
    local s = "";
    for _, w in pairs(v) do
        s = s .. " " .. w
    end
    print(string.sub(s, 2))
end
