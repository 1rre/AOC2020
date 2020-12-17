import scala.collection.mutable
import scala.util.Failure
import scala.util.Success
object Main extends App {
  val result = (1 to 6).foldLeft(getInput)((acc, _) => {
    expandCube(acc) 
  })
  println(getSum(result))
  
  def getSum(cube: Array[Array[Array[Array[Boolean]]]]) = {
    cube.map(i => {
      i.map(j => {
        j.map(k => {
          k.count(x => x)
        }).sum
      }).sum
    }).sum
  }

  def getInput = {
    val input = io.Source.fromFile("input").getLines()
    Array(Array(input.map(_.map(_ == '#').toArray).toArray))
  }

  def expandCube(cube: Array[Array[Array[Array[Boolean]]]]) = {
    Array.tabulate(cube.length + 2)(i => 
      Array.tabulate(cube(0).length + 2)(j => 
        Array.tabulate(cube(0)(0).length + 2)(k => 
          Array.tabulate(cube(0)(0)(0).length + 2)(l => {
            val neighbours = {
              (math.max(i-2, 0) to math.min(i, cube.length - 1)).map(a => 
                (math.max(j-2, 0) to math.min(j, cube(0).length - 1)).map(b => 
                  (math.max(k-2, 0) to math.min(k, cube(0)(0).length - 1)).map(c => 
                    (math.max(l-2, 0) to math.min(l, cube(0)(0)(0).length - 1)).count(d => {
                      (a,b,c,d) != (i-1,j-1,k-1,l-1) && cube(a)(b)(c)(d)
                    })
                  ).sum
                ).sum
              ).sum
            }
            (util.Try(!cube(i-1)(j-1)(k-1)(l-1))).getOrElse(true) && neighbours == 3 ||
            util.Try(cube(i-1)(j-1)(k-1)(l-1)).getOrElse(false) && (2 to 3).contains(neighbours)

          })
        )
      )
    )
  }
}
