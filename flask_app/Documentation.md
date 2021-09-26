# Documentation

- `mkdir Assignments2-Docker` 
- `cd Assignments2-Docker`
- `touch app.py requirements.txt .dockerignore Dockerfile doNotInclude.txt`
- Append to requirements.txt:
```
Flask==2.0.1
```
- This will install dependencies to be able to run the app
- Append to app.py:
```
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
    return '<h1>Hello World! Happi Coding!!</h1>'

if __name__=="__main__":
    app.run(host="0.0.0.0")
```
- This code will run an application an print Hello World! Happi Coding on a webiste, when you run it
- Append some text to `.dockerignore`
This file will not be added to the dockerhub repo
- Append to `Dockerfile`:
```
FROM python:3.9-alpine

WORKDIR /app

RUN pip install --upgrade pip

COPY requirements.txt .

RUN pip install -r requirements.txt

LABEL maintainer="Jakob Johansson <jakobtj@hotmail.com>"

COPY . .

EXPOSE 5000

CMD [ "python3", "app.py" ]
```
- This code is instructions to Docker, which creates an image, and the app will be able to run on port 5000
- `docker build -t amfchef/assignment2:1.0`
This will build an image of the app, and tag it :1.0
- `docker images`
The terminal will print out images, in this case:
amfchef/assignment2:1.0
- `docker run amfchef/assignment2:1.0`
This command will run the application on localhost:5000
Go to localhost:5000 and check that the website prints "Hello World! Happi Coding"
- `docker ps`
This will print out the running containers
- `docker push amfchef/assignment2:1.0`
This will push it to a dockerhub repo, I recently created
- docker build -t amfchef/assignment2:1.0