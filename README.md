Build and run docker Container:
docker build . -t <image_name>
docker run -d --privileged -p 2222:22 -p 8888:8080 -v /var/run/docker.sock:/var/run/docker.sock -e AUTH_MECHANISM=noAuth <image_name>

Enter docker and run web server:
docker exec it <CONTAINER ID> bash
python3 ./manage.py runserver 8080 
curl http://127.0.0.1:8080/

In order to add more users run inside docker: 
adduser <username>
passwd <username>

To login to the os system:
ssh <username>@localhost -p 2222

in case you get this error when trying to login with user other than root: 
"System is booting up. See pam_nologin(8) 
Connection closed by 127.0.0.1 port 2222"
Run this inside docker: 
rm -fr /var/run/nologin

Lines 2-13 in Dockerfile explained:
The current official Docker image for CentOS does contain systemd, but it is inactive by default.
By removing these files, systemd is prevented from starting several services during container startup. This approach results in a bare-bones, yet functional systemd inside the container.
Running a container from this image also requires a specific option to mount the cgroup volume:
$ docker run -it -v /sys/fs/cgroup:/sys/fs/cgroup:ro systemd-app
The -v option bind mounts the /sys/fs/cgroup directory from the host to the container in a read-only fashion.
