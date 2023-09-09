fn main():
   var x: Int = 1
   x += 1
   print(x)
   do_math()
   let z = add(2, 2)
   print(z)

fn do_math():
   let x: Int = 1
   let y = 2
   print(x + y)

fn add(x: Int, y: Int) -> Int:
   return x + y