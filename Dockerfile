FROM python:3.7.0-alpine3.8

COPY requirements.txt /

SHELL ["/bin/ash", "-xeo", "pipefail", "-c"]

RUN apk upgrade --update-cache &&\
    apk --update add postgresql-dev &&\
    apk add --virtual build-dependencies gcc libffi-dev musl-dev &&\
    pip install --upgrade --no-cache-dir pip setuptools wheel &&\
    pip install --no-cache-dir -r requirements.txt &&\
    apk del build-dependencies &&\
    rm -rf /var/cache/apk/ &&\
    rm -rf /root/.cache/pip &&\
    :

COPY controller.py functions.py /

CMD ["python", "-u", "controller.py"]
