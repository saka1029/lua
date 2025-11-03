function * generator() {
    yield 3;
    yield 1;
    yield 2;
}

console.log("** generator **");
for (var i of generator())
    console.log(i);

function * fib() {
    var a = 0, b = 1;
    while (true) {
        yield a;
        [a, b] = [b, a + b];
    }
}

console.log("** fib **");
var c = 0;
for (var i of fib()) {
    if (c++ > 100)
        break;
    console.log(i);
}
