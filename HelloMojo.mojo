from python import Python

fn main():
   var x: Int = 1
   x += 1
   print(x)
   do_math()
   let z = add(2, 2)
   print(z)
   var a = 1
   var b = 2
   let c = add_inout(a, b)
   print(a)
   print(b)
   print(c)
   mojo()
   let mine = MyPair(2, 4)
   mine.dump()
   try:
      let np = Python.import_module("numpy")
      let ar = np.arange(15).reshape(3, 5)
      print(ar)
      print(ar.shape)
   except e:
      print(e.value)
      print("could not find module simple_interop")
   
   

fn do_math():
   let x: Int = 1
   let y = 2
   print(x + y)

fn add(x: Int, y: Int) -> Int:
   return x + y

fn add_inout(inout x: Int, inout y: Int) -> Int:
    x += 1
    y += 1
    return x + y

fn set_fire(owned text: String) -> String:
    text += "🔥"
    return text

fn mojo():
    let a: String = "mojo"
    let b = set_fire(a)
    print(a)
    print(b)

struct MyPair:
    var first: Int
    var second: Int

    fn __init__(inout self, first: Int, second: Int):
        self.first = first
        self.second = second
    
    fn dump(self):
        print(self.first, self.second)