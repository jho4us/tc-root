FROM golang:latest

COPY tc /go/src/github.com/jho4us/tc

WORKDIR /go/src/github.com/jho4us/tc

RUN make install

CMD /go/bin/tc 

EXPOSE 3001
