#/bin/sh

public=$2/alaudaorg/qaimages:helloworld
# push code
rm -rf go-test-public
mkdir go-test-public
cd go-test-public
cat > Dockerfile << EOF
FROM $public
MAINTAINER "liuzongyao"
EOF
cat > main.go << EOF
package main
import "fmt"
func main() {
    fmt.Println("Google" + "Runoob1")
}
EOF
git init
git remote add origin100 http://gitlab-ci-token:$3@$1:31101/devops/devops.git
git config --global user.email "zyliu@alauda.io"
git config --global user.name "liuzongyao"
git add .
git commit -m "Initial commit"
git push -u origin100 master


#push镜像
public=$2/alaudaorg/qaimages:helloworld
docker login -u admin -p Harbor12345 $1:31104
private=$1:31104/library/helloworld:latest
docker pull $public
docker tag $public $private
docker push $private
docker logout $1:31104
