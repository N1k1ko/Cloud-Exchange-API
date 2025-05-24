#cloud-config
package_update: true
package_upgrade: true
packages:
  - docker.io

runcmd:
  - systemctl start docker
  - systemctl enable docker
  - |
    docker run -d \
    %{ for key, value in env_vars ~}
      -e ${key}="${value}" \
    %{ endfor ~}
      -p ${env_vars["APP__RUN__PORT"]}:${env_vars["APP__RUN__PORT"]} \
      ${docker_image}