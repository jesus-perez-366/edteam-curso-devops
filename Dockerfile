FROM python:3.10.8-alpine

WORKDIR /app

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN addgroup -g ${GROUP_ID} demo \
 && adduser -D demo -u ${USER_ID} -g demo -G demo -s /bin/sh

COPY --chown=demo . /app/

# Ya no necesitas cython ni gcc si PyYAML tiene wheel
RUN pip install --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

USER demo

CMD ["uvicorn", "app.main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "8080"]
