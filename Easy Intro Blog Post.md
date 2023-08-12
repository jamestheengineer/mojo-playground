```mojo
%%python
import time
import numpy as np
from math import sqrt
from timeit import timeit

n = 10000000
anp = np.random.rand(n)
bnp = np.random.rand(n)

alist = anp.tolist()
blist = bnp.tolist()

def print_formatter(string, value):
    print(f"{string}: {value:5.5f}")
```


```mojo
%%python
# Pure Python iterative implementation
def python_naive_dist(a,b):
    s = 0.0
    n = len(a)
    for i in range(n):
        dist = a[i] - b[i]
        s += dist*dist
    return sqrt(s)

secs = timeit(lambda: python_naive_dist(alist,blist), number=5)/5
print("=== Pure Python Performance ===")
print_formatter("python_naive_dist value:", python_naive_dist(alist,blist))
print_formatter("python_naive_dist time (ms):", 1000*secs)
```

    === Pure Python Performance ===
    python_naive_dist value:: 1290.56439
    python_naive_dist time (ms):: 818.17188



```mojo
%%python
# Numpy's vectorized linalg.norm implementation 
def python_numpy_dist(a,b):
    return np.linalg.norm(a-b)

secs = timeit(lambda: python_numpy_dist(anp,bnp), number=5)/5
print("=== Python+NumPy Performance ===")
print_formatter("python_numpy_dist value:", python_numpy_dist(anp,bnp))
print_formatter("python_numpy_dist time (ms):", 1000*secs)
```

    === Python+NumPy Performance ===
    python_numpy_dist value:: 1290.56439
    python_numpy_dist time (ms):: 26.21805



```mojo
from Tensor import Tensor
from DType import DType
from Range import range
from SIMD import SIMD
from Math import sqrt
from Time import now

let n: Int = 10_000_000
var a = Tensor[DType.float64](n)
var b = Tensor[DType.float64](n)

for i in range(n):
    a[i] = anp[i].to_float64()
    b[i] = bnp[i].to_float64()
```


```mojo
def mojo_naive_dist(a: Tensor[DType.float64], b: Tensor[DType.float64]) -> Float64:
    var s: Float64 = 0.0
    n = a.num_elements()
    for i in range(n):
        dist = a[i] - b[i]
        s += dist*dist
    return sqrt(s)
```


```mojo
let eval_begin = now()
let naive_dist = mojo_naive_dist(a, b)
let eval_end = now()

print_formatter("mojo_naive_dist value", naive_dist)
print_formatter("mojo_naive_dist time (ms)",Float64((eval_end - eval_begin)) / 1e6)
```

    mojo_naive_dist value: 1290.56439
    mojo_naive_dist time (ms): 75.17360



```mojo
fn mojo_fn_dist(a: Tensor[DType.float64], b: Tensor[DType.float64]) -> Float64:
    var s: Float64 = 0.0
    let n = a.num_elements()
    for i in range(n):
        let dist = a[i] - b[i]
        s += dist*dist
    return sqrt(s)
```


```mojo
let eval_begin = now()
let naive_dist = mojo_fn_dist(a, b)
let eval_end = now()

print("=== Mojo Performance with fn, declarations and typing and ===")
print_formatter("mojo_fn_dist value", naive_dist)
print_formatter("mojo_fn_dist time (ms)",Float64((eval_end - eval_begin)) / 1e6)
```

    === Mojo Performance with fn, declarations and typing and ===
    mojo_fn_dist value: 1290.56439
    mojo_fn_dist time (ms): 13.83714



```mojo

```
