import Input._
import Part1._
import Part2._

object Day16 extends App {
  val input = readFile
  val conditions = input._1
  val myTicket = input._2
  val tickets = input._3
  val conditionNames = input._4
  
  val p1 = removeInvalid(conditions, tickets)
  val validTickets = p1._1 
  println(s"Part 1: ${p1._2}")
  val validConditions = findPossible(conditions, myTicket, validTickets)
  
  val reducedConditions = collection.mutable.HashMap[Int,Int]()
  validConditions.indices.foldLeft(validConditions)((acc, v) => {
    reducedConditions += ((acc.head._1(0), acc.head._2))
    acc.tail.map(x =>
      (x._1.filterNot(_ == acc.head._1(0)), x._2)
    )
  })
  val p2 = conditions.indices.filter(i =>
      """departure.*""".r.matches(conditionNames(i))
    ).map(i =>
      myTicket(reducedConditions(i)).toLong
    ).reduce((acc, v) =>
      acc * v
    )
  println(s"Part 2: ${p2}")
}
