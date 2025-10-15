ARG BASE_TAG=full-rocm-6.3.3
FROM mixa3607/llama.cpp-gfx906:${BASE_TAG}

# has to be after the FROM
ARG LS_VER=89

WORKDIR /app
RUN \
    curl -LO https://github.com/mostlygeek/llama-swap/releases/download/v"${LS_VER}"/llama-swap_"${LS_VER}"_linux_amd64.tar.gz && \
    tar -zxf llama-swap_"${LS_VER}"_linux_amd64.tar.gz && \
    rm llama-swap_"${LS_VER}"_linux_amd64.tar.gz

COPY config.example.yaml /app/config.yaml

HEALTHCHECK CMD curl -f http://localhost:8080/ || exit 1
ENTRYPOINT [ "/app/llama-swap", "-config", "/app/config.yaml" ]
