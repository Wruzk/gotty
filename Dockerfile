# Use a lightweight base image
FROM debian:bullseye-slim

# Cài đặt các dependencies cần thiết
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    tmate \
    screen \
    supervisor \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download và cài đặt Gotty
RUN curl -LO https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz && \
    tar -xzf gotty_linux_amd64.tar.gz && \
    mv gotty /usr/local/bin/ && \
    rm gotty_linux_amd64.tar.gz

# Tạo thư mục logs và cấu hình Supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy entrypoint script vào image
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose cổng mặc định của Gotty
EXPOSE 8080

# Sử dụng Supervisor để giữ container luôn chạy
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
