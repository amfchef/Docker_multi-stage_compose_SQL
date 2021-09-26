FROM python:3.9-alpine

WORKDIR /app

RUN pip install --upgrade pip

COPY ../requirements.txt .

RUN pip install -r requirements.txt

LABEL maintainer="Jakob Johansson <jakobtj@hotmail.com>"

COPY . .

EXPOSE 5000

CMD [ "python3", "app.py" ]