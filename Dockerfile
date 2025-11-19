FROM golang:1.25-alpine AS builder

# Set working directory
WORKDIR /app

# Copy go mod files
COPY go.mod ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . . 

# Build the application
RUN go build -o main .

# Use the minimal image for production
FROM alpine:latest

WORKDIR /root/

# Copy the binary from the builder
COPY --from=builder /app/main .

# Expose port
EXPOSE 8080

# Run the application
CMD ["./main"]