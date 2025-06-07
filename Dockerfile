FROM python:3.10-slim

WORKDIR /app

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN groupadd -g ${GROUP_ID} demo \
 && useradd -m -u ${USER_ID} -g demo -s /bin/bash demo

COPY . /app/
RUN chown -R demo:demo /app

RUN pip install --upgrade pip \
 && pip install setuptools==65.5.0 wheel \
 && pip install --only-binary :all: --no-cache-dir -r requirements.txt

USER demo

CMD ["uvicorn", "app.main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "8080"]
