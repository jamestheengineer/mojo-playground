from mymodule import MyPair
from mypack.module1 import ModulePair
from ProgrammingManual import HeapArray
from ProgrammingManual import SomethingBig
from ProgrammingManual import use_something_big
from ProgrammingManual import MyInt
from ProgrammingManual import swap

fn main():
    let mine = MyPair(2, 6)
    mine.dump()
    let mine2 = ModulePair(3,6)
    mine2.dump()

    var a = HeapArray(3, 1)
    a.dump()   # Should print [1, 1, 1]
    # Uncomment to see an error:
    var b = a  # ERROR: Vector doesn't implement __copyinit__
    b.dump()
    b = HeapArray(4, 2) # Memory leak?
    b.dump()   # Should print [2, 2, 2, 2]
    a.dump()   # Should print [1, 1, 1]

    let a = SomethingBig(10)
    let b = SomethingBig(20)
    use_something_big(a, b)

    var x: MyInt = 42
    x += 1
    print(x.value) # prints 43 as expected

    # However...
    let y = x
    # Uncomment to see the error:
    # y += 1       # ERROR: Cannot mutate 'let' value