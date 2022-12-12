FROM python:3.6-alpine

ADD app /app
RUN pip3 install --upgrade pip && pip3 install -r /app/requirements.txt

EXPOSE 8000
WORKDIR /app
CMD ["python", "main.py"]
