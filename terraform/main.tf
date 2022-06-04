terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_ecs_cluster" "foo" {
  name = "white-hart"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "myservice" {
    family = "service"
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu       = 256
    memory    = 512
container_definitions = jsonencode([
{
name      = "first"
image     = "public.ecr.aws/m5c0a2h3/cowsay:latest"
essential = true
}
])
}


resource "aws_ecs_service" "hello-world" {
  name            = "mongodb"
  cluster         = aws_ecs_cluster.foo.id
  task_definition = aws_ecs_task_definition.myservice.arn
  desired_count   = 3
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
  
 
 network_configuration {
   security_groups  = ["sg-e9bd4ab9"]
   subnets          = ["subnet-0b170efc0b8f6f53b"]
   assign_public_ip = false
 }
 
}