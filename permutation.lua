function array(n, v)
    local a = {}
    for i = 1, n do
        table.insert(a, v)
    end
    return a
end

function permutation(n, k, callback)
    print("permutation(" .. n .. ", " .. k .. ")")
    local result = array(k, 0)
    local used = array(n, false)
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

function pr(r) 
    local s = "";
    for i, v in pairs(r) do
        s = s .. " " .. v
    end
    print(s)
end

print("** start **")
permutation(3, 3, pr)
