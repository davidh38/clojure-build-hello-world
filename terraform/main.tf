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
#resource "aws_ecs_task_definition" "myservice" {#    family = "service" #    network_mode             = "awsvpc"
#    requires_compatibilities = ["FARGATE"]
#    cpu       = 256
#    memory    = 512
#container_definitions = jsonencode([
#{
#name      = "first"
#image     = "public.ecr.aws/m5c0a2h3/cowsay:latest"
#essential = true
#}
#])
#}
#
#
#resource "aws_ecs_service" "hello-world" {
#  name            = "mongodb"
#  cluster         = aws_ecs_cluster.foo.id
#  task_definition = aws_ecs_task_definition.myservice.arn
#  desired_count   = 3
#  launch_type                        = "FARGATE"
#  scheduling_strategy                = "REPLICA"
#  
# 
# network_configuration {
#   security_groups  = ["sg-e9bd4ab9"]
#   subnets          = ["subnet-0b170efc0b8f6f53b"]
#   assign_public_ip = false
# }
# 
#}

resource "aws_ecs_cluster" "foo" {
    name               = "tryimport"

    configuration {
        execute_command_configuration {
            logging = "DEFAULT"
        }
    }

    setting {
        name  = "containerInsights"
        value = "disabled"
    }
}

# aws_ecs_task_definition.fromecr:
resource "aws_ecs_task_definition" "fromecr" {
    container_definitions    = jsonencode(
        [
            {
                cpu                   = 0
                              essential             = true
                image                 = "public.ecr.aws/m5c0a2h3/test"
                links                 = []
                logConfiguration      = {
                    logDriver     = "awslogs"
                    options       = {
                        awslogs-create-group  = "true"
                        awslogs-group         = "/ecs/fromecr"
                        awslogs-region        = "us-east-1"
                        awslogs-stream-prefix = "ecs"
                    }
                    secretOptions = []
                }
                name                  = "aoeu"
                          },
        ]
    )
    cpu                      = "1024"
    execution_role_arn       = "arn:aws:iam::632547665100:role/ecsTaskExecutionRole"
    family                   = "fromecr"
    memory                   = "3072"
    network_mode             = "awsvpc"
    requires_compatibilities = [
        "FARGATE",
    ]

    runtime_platform {
        cpu_architecture        = "X86_64"
        operating_system_family = "LINUX"
    }
}



#resource "aws_ecs_service" "example" {
#    cluster                            = "arn:aws:ecs:us-east-1:632547665100:cluster/tryimport"
#    deployment_maximum_percent         = 200
#    deployment_minimum_healthy_percent = 100
#    desired_count                      = 1
#    enable_ecs_managed_tags            = false
#    enable_execute_command             = false
#    health_check_grace_period_seconds  = 0
#    launch_type                        = "FARGATE"
#    name                               = "testme"
#    platform_version                   = "LATEST"
#    scheduling_strategy                = "REPLICA"
#    tags                               = {}
#    tags_all                           = {}
#    task_definition                    = "fromecr:2"
#
#    deployment_circuit_breaker {
#        enable   = false
#        rollback = false
#    }
#
#    deployment_controller {
#        type = "ECS"
#    }
#
#    network_configuration {
#        assign_public_ip = true
#        security_groups  = [
#            "sg-e9bd4ab9",
#        ]
#        subnets          = [
#            "subnet-0b170efc0b8f6f53b",
#        ]
#    }
#
#    timeouts {}
#}

#resource "null_resource" "ecs-run-task" {
#  provisioner "local-exec" {
#    # add other args as necessary: https://docs.aws.amazon.com/cli/latest/reference/ecs/run-task.html
#    command     = "ecs run task --task-definition ${aws_ecs_task_definition.fromecr.arn}"
#    interpreter = ["aws"]
#  }
#}

