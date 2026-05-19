resource "aws_security_group" "appsg" {
  name        = var.appsg.name
  description = var.appsg.description
  vpc_id      = aws_vpc.vpc1.id

  depends_on = [aws_vpc.vpc1]
}

resource "aws_security_group_rule" "app_rule" {
  count             = length(var.appsg.rules)
  type              = var.appsg.rules[count.index].type
  from_port         = var.appsg.rules[count.index].from_port
  to_port           = var.appsg.rules[count.index].to_port
  protocol          = var.appsg.rules[count.index].protocol
  security_group_id = aws_security_group.appsg.id
  cidr_blocks       = [var.appsg.rules[count.index].cidr_block]

  depends_on = [aws_security_group.appsg]
}

resource "aws_security_group" "websg" {
  name        = var.websg.name
  description = var.websg.description
  vpc_id      = aws_vpc.vpc1.id

  depends_on = [aws_vpc.vpc1]
}

resource "aws_security_group_rule" "web_rule" {
  count             = length(var.websg.rules)
  type              = var.websg.rules[count.index].type
  from_port         = var.websg.rules[count.index].from_port
  to_port           = var.websg.rules[count.index].to_port
  protocol          = var.websg.rules[count.index].protocol
  security_group_id = aws_security_group.websg.id
  cidr_blocks       = [var.websg.rules[count.index].cidr_block]

  depends_on = [aws_security_group.websg]
}

resource "aws_security_group" "dbsg" {
  name        = var.dbsg.name
  description = var.dbsg.description
  vpc_id      = aws_vpc.vpc1.id

  depends_on = [aws_vpc.vpc1]
}

resource "aws_security_group_rule" "db_rule" {
  count             = length(var.dbsg.rules)
  type              = var.dbsg.rules[count.index].type
  from_port         = var.dbsg.rules[count.index].from_port
  to_port           = var.dbsg.rules[count.index].to_port
  protocol          = var.dbsg.rules[count.index].protocol
  security_group_id = aws_security_group.dbsg.id
  cidr_blocks       = [var.dbsg.rules[count.index].cidr_block]

  depends_on = [aws_security_group.dbsg]
}

