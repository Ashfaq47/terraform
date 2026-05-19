resource "aws_security_group" "docdb_sg" {
  name        = var.docdb_sg.name
  description = var.docdb_sg.name
  vpc_id      = aws_vpc.vpc_db.id

  depends_on = [aws_vpc.vpc_db]
}

resource "aws_security_group_rule" "docdb_sg_rule" {
  count             = length(var.docdb_sg.rules)
  type              = var.docdb_sg.rules[count.index].type
  from_port         = var.docdb_sg.rules[count.index].from_port
  to_port           = var.docdb_sg.rules[count.index].to_port
  security_group_id = aws_security_group.docdb_sg.id
  protocol          = var.docdb_sg.rules[count.index].protocol
  cidr_blocks       = [var.docdb_sg.rules[count.index].cidr_block]

  depends_on = [aws_security_group.docdb_sg]
}