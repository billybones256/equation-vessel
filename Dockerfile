FROM golang:alpine as builder 

RUN apk update && apk upgrade && apk add --no-cache git 

RUN mkdir /equation-vessel
WORKDIR /equation-vessel

ENV G0111MODULE=on

COPY . .

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o vessel


FROM alpine:latest 

RUN apk --no-cache add ca-certificates

RUN mkdir /app 
WORKDIR /app 
COPY --from=builder /equation-vessel/vessel .

CMD ["./vessel"]
