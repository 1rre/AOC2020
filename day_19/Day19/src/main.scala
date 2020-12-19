object Main extends App {

  val lines = io.Source.fromFile(s"part${args(0)}").getLines
  
  val rules = lines.takeWhile(_ != "").toArray.map(s => {
    val split = s.split(": ")
    (split(0).toInt, if (""""[a-z]+"""".r.matches(split(1))) split(1).tail.init
                    else split(1).split(""" \| """).map(_.split(" ").map(_.toInt)))
  }).toMap

  val input = lines.toArray
  
  def fits(s: String, i: Int): Array[(Boolean, String)] = {
    rules(i) match {
      case rule: String if s.startsWith(rule) => Array((true, s.stripPrefix(rule)))
      case _: String => Array((false, s))
      case list: Array[Array[Int]] => list.map(fitList(s, _)).flatten
    }
  }

  def fitList(s: String, list: Array[Int]): Array[(Boolean, String)] = {
    if (list.length == 0) return Array((true, s))
    val result = fits(s, list(0))
    result.filter(_._1).map(f => fitList(f._2, list.tail)).flatten
  }

  def answer = input.count(fits(_, 0).contains((true,"")))

  println(answer)
}