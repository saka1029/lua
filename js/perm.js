function * generator() {
    yield 3
    yield 1
    yield 2
}

for (var i of generator())
    console.log(i)
