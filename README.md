# sonic-bmc

docker rmi obmc-debian12:1 && docker build -t obmc-debian12:1 .

git clone https://github.com/Naios/function2.git

patch:
git diff > my_changes.patch

    docker rmi obmc-debian12:1 && docker build -t obmc-debian12:1 .



docker run -it --privileged -v /root/sonic-bmc:/app/sonic-bmc:rw -v /var/run/dbus:/var/run/dbus:rw --rm --network=host --name obmc obmc-debian12:1 bash