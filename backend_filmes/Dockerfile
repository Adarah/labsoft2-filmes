FROM python:3.9
WORKDIR /app
EXPOSE 8000
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . ./
ENTRYPOINT ["python"]
CMD ["manage.py", "runserver"]