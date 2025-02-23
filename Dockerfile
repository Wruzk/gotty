# Use a lightweight base image
FROM debian:bullseye-slim

# Cài đặt các dependencies cần thiết
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    tmate \
    screen \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download và cài đặt Gotty
RUN curl -LO https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz && \
    tar -xzf gotty_linux_amd64.tar.gz && \
    mv gotty /usr/local/bin/ && \
    rm gotty_linux_amd64.tar.gz

# Copy entrypoint script vào image
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose cổng mặc định của Gotty
EXPOSE 8080

# Sử dụng entrypoint script làm lệnh khởi động container
CMD ["/entrypoint.sh"]
