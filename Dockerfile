FROM golang:1.18.3 as build
WORKDIR /go/src/github.com/akath19/drone-sonar-plugin 
COPY . .
RUN go get && GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o drone-sonar

FROM sonarsource/sonar-scanner-cli:4.7.0
WORKDIR /bin
COPY --from=build /go/src/github.com/akath19/drone-sonar-plugin/drone-sonar .
ENTRYPOINT /bin/drone-sonar