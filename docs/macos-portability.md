# Chạy trên macOS

Không thể mang các file nhị phân đã build trên Ubuntu sang macOS. Hãy mang toàn bộ thư mục project này, sau đó build lại tại máy Mac bằng `setup-macos.sh`.

```bash
git clone <repository-url> v2x-sim
cd v2x-sim
chmod +x setup-macos.sh
./setup-macos.sh
source "$HOME/sim-stack/env.sh"  # optional; scenario/run.sh loads it automatically
```

Sau khi cài xong, mở project bằng OMNeT++ IDE hoặc chạy `opp_run` từ thư mục mô phỏng. Các file SUMO trong `scenario/` là dữ liệu đầu vào độc lập với hệ điều hành.

Trên Mac Apple Silicon, nên dùng Terminal native ARM64 và Homebrew `/opt/homebrew`. Nếu một thư viện chỉ có bản x86_64, dùng Rosetta 2 hoặc build toàn bộ stack bằng cùng một kiến trúc.
