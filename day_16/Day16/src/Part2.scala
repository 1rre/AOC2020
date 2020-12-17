
object Part2 {

  def findPossible(conditions: Array[((Int,Int),(Int,Int))], myTicket: Array[Int], tickets: Array[Array[Int]]) = {
    Array.fill(conditions.size)(0 until conditions.size).zipWithIndex.map(x => 
      x._1.filter(y => 
        tickets.forall(ticket =>
          ticket(x._2) >= conditions(y)._1._1 && ticket(x._2) <= conditions(y)._1._2 || ticket(x._2) >= conditions(y)._2._1 && ticket(x._2) <= conditions(y)._2._2
        )
      )
    ).zipWithIndex.sortBy(_._1.size)
  }

}
