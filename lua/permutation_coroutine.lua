function array_new(n, v)
    local a = {}
    for i = 1, n do
        table.insert(a, v)
    end
    return a
end

function array_iota(n)
    local a = {}
    for i = 1, n do
        table.insert(a, i)
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

function array_string(a) 
    if a == nil then return "nil" end
    local s = "";
    for _, v in pairs(a) do
        s = s .. " " .. v
    end
    return "[" .. string.sub(s, 2) .. "]"
end

function permgen(a, n)
    if n == 0 then
        coroutine.yield(a)
    else
        for i = 1, n do
            a[n], a[i] = a[i], a[n]
            permgen(a, n - 1)
            a[n], a[i] = a[i], a[n]
        end
    end
end

function perm(a)
    local n = #a
    local co = coroutine.create(function() permgen(a, n) end)
    return function()
        local codes, res = coroutine.resume(co)
        return res
    end
end

for p in perm(array_iota(3)) do
    array_print(p)
end

function perm_array(n, k, result, used, i)
    if i > k then
        coroutine.yield(result)
    else
        for j = 1, n do
            if not used[j] then
                used[j] = true
                result[i] = j
                perm_array(n, k, result, used, i + 1)
                used[j] = false
            end
        end
    end
end

function permutation_recursive_coroutine(n, k)
    local result = array_new(k, 0)
    local used = array_new(n, false)
    local co = coroutine.create(
        function()
            perm_array(n, k, result, used, 1)
        end)
    return function()
        local codes, res = coroutine.resume(co)
        return res
    end
end
    
print("permutation_recursive_coroutine")
for i in permutation_recursive_coroutine(3,3) do
    array_print(i)
end

function permutation_coroutine_body(n, k)
    local result = array_new(k, 0)
    local used = array_new(n, false)
    function solve(i)
        if i > k then
            coroutine.yield(result)
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

function permutation_coroutine(n, k)
    local co = coroutine.create(
        function()
            permutation_coroutine_body(n, k)
        end)
    return function()
        local codes, res = coroutine.resume(co)
        print(tostring(codes) .. array_string(res))
        return res
    end
end

print("permutation_coroutine")
for i in permutation_coroutine(3,3) do
    array_print(i)
end
