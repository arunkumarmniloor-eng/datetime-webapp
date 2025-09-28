# Build stage
FROM golang:1.20-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN apk add --no-cache git
RUN go mod download
COPY . .
RUN go build -o /server

# Final image
FROM alpine:3.18
WORKDIR /root/
COPY --from=build /server .
EXPOSE 8080
CMD ["./server"]
