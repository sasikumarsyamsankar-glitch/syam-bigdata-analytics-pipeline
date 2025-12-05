FROM python:3.11-slim

WORKDIR /syam_app

COPY requirements.txt .
RUN pip install pandas

COPY syam_app.py .
COPY syam_data.csv .

CMD ["python", "syam_app.py"]
kubectl version --client --short
