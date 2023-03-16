FROM python:alpine3.11

WORKDIR /app
#copy everythinh except .sql
COPY server/. .

RUN pip install -r requirements.txt

EXPOSE 8000

ENV DATABASE_URL hotel-db

CMD ["gunicorn", "server:app", "-b", "0.0.0.0:8000"]