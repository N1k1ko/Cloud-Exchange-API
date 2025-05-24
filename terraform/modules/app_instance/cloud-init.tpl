#cloud-config
runcmd:
  - |
    docker run -d \
    %{ for key, value in env_vars ~}
      -e ${key}="${value}" \
    %{ endfor ~}
      -p ${env_vars["APP__RUN__PORT"]}:${env_vars["APP__RUN__PORT"]} \
      ${docker_image}
