object Input {
  def readFile = {
    val lines = io.Source.fromFile("input").getLines
    var conditions: collection.mutable.ArrayBuffer[((Int, Int), (Int, Int))] = collection.mutable.ArrayBuffer()
    var myTicket: Array[Int] = null
    var tickets: collection.mutable.ArrayBuffer[Array[Int]] = collection.mutable.ArrayBuffer()
    var conditionNames: collection.mutable.ArrayBuffer[String] = collection.mutable.ArrayBuffer()
    while(lines.hasNext) {
      lines.next match {
        case condition if """.+: \d+-\d+ or \d+-\d+""".r.matches(condition) => {
          conditionNames += condition.takeWhile(_ != ':')
          conditions += extractCondition(condition)
        }
        case ticket if myTicket == null && """(\d,?)+""".r.matches(ticket) =>
          myTicket = ticket.split(",").map(_.toInt)
        case ticket if """(\d,?)+""".r.matches(ticket) =>
          tickets += ticket.split(",").map(_.toInt)
        case _ =>
      }
    }
    (conditions.toArray, myTicket, tickets.toArray, conditionNames.toArray)
  }

  def extractCondition(condition: String): ((Int,Int),(Int,Int)) = {
    val matches = """\d+-\d+""".r.findAllMatchIn(condition)
    ((matches.next.toString.split("-") match {
      case Array(a,b) => (a.toInt,b.toInt)
    }),(matches.next.toString.split("-") match {
      case Array(a,b) => (a.toInt,b.toInt)
    }))
  }
}
