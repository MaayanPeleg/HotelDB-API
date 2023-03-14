FROM python:alpine3.11

WORKDIR /app
#copy everythinh except .sql
COPY *.py .

COPY *.txt .

RUN pip install -r requirements.txt

EXPOSE 8000

CMD ["gunicorn", "server:app", "-b", "0.0.0.0:8000"]