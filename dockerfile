FROM ubuntu:16.04 as builder
LABEL maintainer="tarea2_op2" \
      version="0.0.1" \
      stage="build" \
      description="test multistage build"

RUN apt-get install -y gcc && \
    mkdir /tarea2

WORKDIR /tarea2
COPY prog.c /tarea2
RUN gcc -o prog prog.c

#-------------------------------------------------
# Stage 2 - Ejecuto el binario
#-------------------------------------------------
FROM alpine:3.6
LABEL maintainer="tarea2_op2_02" \
      version="0.0.1" \
      stage="execute" \
      description="Second test multistage build"

RUN apk update && \
    apk add libc6-compat

COPY --from=builder /tarea2/prog /bin/prog
CMD ["/bin/prog"]
