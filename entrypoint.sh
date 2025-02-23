#!/bin/bash
set -e

echo "Chờ 5 giây để tmate khởi động..."
sleep 5

echo "Thông tin kết nối tmate:"
tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}'
tmate -S /tmp/tmate.sock display -p '#{tmate_web}'

echo "Tất cả dịch vụ đã sẵn sàng!"
exec "$@"
