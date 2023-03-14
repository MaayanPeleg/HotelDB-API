FROM python:alpine3.11

WORKDIR /app
#copy everythinh except .sql
COPY . /app

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "server.py"]