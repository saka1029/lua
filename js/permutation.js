function permutation_recursive_callback(n, k, callback) {
    console.log("permutation_recursive_callback(" + n + ", " + k + " callback)")
    let result = Array(k)
    let used = Array(n).fill(false)
    function solve(i) {
        if (i >= k) {
            callback(result.concat())
        } else
            for (var j = 0; j < n; ++j)
                if (!used[j]) {
                    used[j] = true
                    result[i] = j
                    solve(i + 1)
                    used[j] = false
                }
    }
    solve(0)
}

permutation_recursive_callback(3, 3, console.log)

function * generator() {
    yield 3
    yield 1
    yield 2
}

for (var i of generator())
    console.log(i)

function * permutation_recursive_generator_body(n, k, result, used, i) {
    console.log("permutation_recursive_generator_body(i=" + i + ")")
    if (i >= k) {
        yield result.concat()
    } else {
        for (var j = 0; j < n; ++j) {
            if (!used[j]) {
                used[j] = true
                result[i] = j
                console.log("before call")
                permutation_recursive_generator_body(n, k, result, used, i + 1)
                console.log("after call")
                used[j] = false
            }
        }
    }
}

function * permutation_recursive_generator(n, k) {
    console.log("permutation_recursive_generator(" + n + ", " + k + ")")
    let result = Array(k)
    let used = Array(n).fill(false)
    for (var a of permutation_recursive_generator_body(n, k, result, used, 0)) {
        console.log("inter: " + a)
        yield a
    }
}


for (var a of permutation_recursive_generator(3, 3))
    console.log(a)
