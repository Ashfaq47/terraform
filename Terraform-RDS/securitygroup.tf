resource "aws_security_group" "rdssg" {
  name        = var.rdssg.name
  description = var.rdssg.description
  vpc_id      = aws_vpc.rds_vpc.id

  depends_on = [aws_vpc.rds_vpc]
}

resource "aws_security_group_rule" "rdssgrule" {
  count             = length(var.rdssg.rules)
  security_group_id = aws_security_group.rdssg.id
  type              = var.rdssg.rules[count.index].type
  from_port         = var.rdssg.rules[count.index].from_port
  to_port           = var.rdssg.rules[count.index].to_port
  protocol          = var.rdssg.rules[count.index].protocol
  cidr_blocks       = [var.rdssg.rules[count.index].cidr_block]

  depends_on = [aws_security_group.rdssg]
}