#!/bin/bash
set -e

echo "Khởi tạo phiên screen 'myshell' (detached mode)..."
# Tạo phiên screen chứa bash và để ở chế độ background
screen -dmS myshell bash

echo "Khởi chạy tmate..."
# Khởi tạo tmate với socket cụ thể
TMATE_SOCKET="/tmp/tmate.sock"
tmate -S "$TMATE_SOCKET" new-session -d
tmate -S "$TMATE_SOCKET" wait tmate-ready

echo "Thông tin kết nối tmate:"
tmate -S "$TMATE_SOCKET" display -p '#{tmate_ssh}'
tmate -S "$TMATE_SOCKET" display -p '#{tmate_web}'

echo "Khởi chạy gotty để reattach phiên screen 'myshell'..."
# Gotty chạy ở foreground, giữ container luôn chạy
exec gotty -w screen -r myshell
