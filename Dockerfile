FROM alpine
COPY --from=rclone/rclone --chmod=755 /usr/local/bin/rclone /usr/local/bin/rclone
WORKDIR /app
COPY --chmod=755 start.sh /app/start.sh

CMD [ "/app/start.sh" ]
