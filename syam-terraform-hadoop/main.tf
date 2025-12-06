terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "hadoop_net" {
  name = "syam-hadoop-net"
}

resource "docker_container" "namenode" {
  name  = "syam-namenode"
  image = "bde2020/hadoop-namenode:2.0.0-hadoop3.2.1-java8"
  networks_advanced {
    name = docker_network.hadoop_net.name
  }

  env = [
    "CLUSTER_NAME=syam-hadoop"
  ]

  ports {
    internal = 9870
    external = 9870
  }

  volumes {
    host_path      = "/tmp/syam-hadoop/namenode"
    container_path = "/hadoop/dfs/name"
  }
}

resource "docker_container" "datanode" {
  name  = "syam-datanode"
  image = "bde2020/hadoop-datanode:2.0.0-hadoop3.2.1-java8"
  networks_advanced {
    name = docker_network.hadoop_net.name
  }

  env = [
    "SERVICE_PRECONDITION=syam-namenode:9870",
    "CLUSTER_NAME=syam-hadoop"
  ]

  volumes {
    host_path      = "/tmp/syam-hadoop/datanode"
    container_path = "/hadoop/dfs/data"
  }
}

resource "docker_container" "resourcemanager" {
  name  = "syam-resourcemanager"
  image = "bde2020/hadoop-resourcemanager:2.0.0-hadoop3.2.1-java8"
  networks_advanced {
    name = docker_network.hadoop_net.name
  }

  env = [
    "SERVICE_PRECONDITION=syam-namenode:9870 syam-datanode:9864"
  ]

  ports {
    internal = 8088
    external = 8088
  }
}

resource "docker_container" "nodemanager" {
  name  = "syam-nodemanager"
  image = "bde2020/hadoop-nodemanager:2.0.0-hadoop3.2.1-java8"
  networks_advanced {
    name = docker_network.hadoop_net.name
  }

  env = [
    "SERVICE_PRECONDITION=syam-resourcemanager:8088"
  ]
}

resource "docker_container" "hive" {
  name  = "syam-hive"
  image = "bde2020/hive:2.3.2-postgresql-metastore"
  networks_advanced {
    name = docker_network.hadoop_net.name
  }

  ports {
    internal = 10000
    external = 10000
  }
}

