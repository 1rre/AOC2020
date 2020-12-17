

object Part1 {
  def removeInvalid(conditions: Array[((Int,Int),(Int,Int))], tickets: Array[Array[Int]]) = {
    var invalid = 0
    (tickets.filter(ticket => 
      ticket.forall(num => 
        if (conditions.exists(condition =>
            num >= condition._1._1 && num <= condition._1._2 || num >= condition._2._1 && num <= condition._2._2)
          ) true
        else {
          invalid += num
          false
        }
      )
    ), invalid)
  }
}
