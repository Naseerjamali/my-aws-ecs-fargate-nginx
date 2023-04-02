output "alb" {
  value = aws_security_group.alb.id
}

output "ecs-task-sg" {
  value = aws_security_group.ecs-task-sg.id
}
