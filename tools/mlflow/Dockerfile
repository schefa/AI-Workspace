FROM python:3.6

LABEL maintainer="Fjodor Schaefer <fjodor@schefa.com>"

ENV MLFLOW_EXTRA_OPS="${MLFLOW_EXTRA_OPS}" \
    MYSQL_HOST="${MYSQL_HOST}" \
    MYSQL_USER="${MYSQL_USER}" \
    MYSQL_PASSWORD="${MYSQL_PASSWORD}" \
    AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" \
    AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"

COPY wait-for-mysql.py /tmp
COPY requirements.txt /tmp
COPY entrypoint.sh /etc

RUN apt-get update && \
    apt-get install -y dos2unix && \
    dos2unix /etc/entrypoint.sh 

RUN pip install -U pip && \
    pip install -r /tmp/requirements.txt

EXPOSE 5000
  
ENTRYPOINT ["/etc/entrypoint.sh"]