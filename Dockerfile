FROM python:alpine3.11

#copy everythinh except .sql
COPY . /app

WORKDIR /app

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "server.py"]