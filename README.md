# docker-webmo-debian: How to create a WebMO Docker image
1. Clone the repository:
```bash
git clone https://github.com/nom05/docker-webmo-debian
```
2. Enter in the directory:
```bash
cd docker-webmo-debian
```
3. Download last version of `Server In The Cloud` (SITC) script:
```bash
curl -O https://www.webmo.net/cloud/sitc.tar.gz
```
4. Verify the downloaded file name is sitc.tar.gz.
5. Create the following file with your favorite editor:
```bash
vim ./webmoinfo
```
6. In the first and second lines add your license and password, respectively.
7. To avoid the fact Docker saves ARG or ENV variables in `docker history`, we use `RUN --mount=type=secret` to keep secret our license/password as implemented in Docker's `buildkit`. Therefore, we will employ the following command to create the WebMO image:
```bash
DOCKER_BUILDKIT=1 docker build --secret id=webmoinfo,src=./webmoinfo -t image_name .
```
`./webmoinfo` is the file created previously with the WebMO license/password.
Now the image is created. Use a `docker-compose` file or `docker run` to test your image. Keep in mind the image exposes **_port 80_**:
```bash
docker run -ti --name container_name -p 8080:80 image_name
```
8. Taking into account the last command, open your web browser and type `http://your_IP:8080/webmo`. The default user is `admin` with an empty password.
