from mymodule import MyPair
from mypack.module1 import ModulePair
from ProgrammingManual import HeapArray
from ProgrammingManual import SomethingBig
from ProgrammingManual import use_something_big
from ProgrammingManual import MyIntOld
from ProgrammingManual import swap
import ProgrammingManual as pm

fn main():
    let mine = MyPair(2, 6)
    mine.dump()
    let mine2 = ModulePair(3,6)
    mine2.dump()

    let a = HeapArray(3, 1)
    a.dump()   # Should print [1, 1, 1]
    # Uncomment to see an error:
    var b = a  # ERROR: Vector doesn't implement __copyinit__
    b.dump()
    b = HeapArray(4, 2) # Memory leak?
    b.dump()   # Should print [2, 2, 2, 2]
    a.dump()   # Should print [1, 1, 1]

    let c = SomethingBig(10)
    let d = SomethingBig(20)
    use_something_big(c, d)

    var x: MyIntOld = 42
    x += 1
    print(x.value) # prints 43 as expected

    # However...
    let y = x
    # Uncomment to see the error:
    # y += 1       # ERROR: Cannot mutate 'let' value

    var k = 42
    var m = 12
    print(k, m)  # Prints 42, 12
    swap(k, m)
    print(k, m)  # Prints 12, 42

    pm.work_with_unique_ptrs()

    # This is equivalent to Python's `import numpy as np`
    try:
        let v = pm.work_with_python()
    except e:
        print(e.value)
        print("could not find module simple_interop")
    
    pm.parameter_overloads[1, 2, pm.MyInt(3)]()

    # Make a vector of 4 floats.
    let small_vec = SIMD[DType.float32, 4](1.0, 2.0, 3.0, 4.0)

    # Make a big vector containing 1.0 in float16 format.
    let big_vec = SIMD[DType.float16, 32].splat(1.0)

    # Do some math and convert the elements to float32.
    let bigger_vec = (big_vec+big_vec).cast[DType.float32]()

    # You can write types out explicitly if you want of course.
    let bigger_vec2 : SIMD[DType.float32, 32] = bigger_vec

    print('small_vec type:', small_vec.element_type, 'length:', len(small_vec))
    print('bigger_vec2 type:', bigger_vec2.element_type, 'length:', len(bigger_vec2))

    print(pm.rsqrt[DType.float16, 4](SIMD[DType.float16, 4](1.0, 2.0, 4.0, 9.0)))

    let g = SIMD[DType.float32, 2](1, 2)
    let z = pm.concat[DType.float32, 2, 2](g, g)

    print('result type:', z.element_type, 'length:', len(z))

    let h = SIMD[DType.index, 4](1, 2, 3, 4)
    print(h)
    print("Elements sum:", pm.reduce_add[DType.index, 4](h))

    let v = pm.Array[Float32](4, 3.14)
    print(v[0], v[1], v[2], v[3])

    let N = 32
    let e = DTypePointer[DType.float32].alloc(N)
    let f = DTypePointer[DType.float32].alloc(N)
    let res = DTypePointer[DType.float32].alloc(N)
    # Initialize arrays with some values
    for i in range(N):
        e.store(i, 2.0)
        f.store(i, 40.0)
        res.store(i, -1)
        
    pm.buffer_elementwise_add[DType.float32](e, f, res, N)
    print(e.load(10), f.load(10), res.load(10))

    pm.NoInstances.print_hello()

    pm.use_strings()