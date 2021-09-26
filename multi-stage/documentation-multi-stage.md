# Documentation Multi-stage

- Create the files from the instructions
- Create a Dockerfile as follows:
```
FROM ubuntu as builder

COPY . .

FROM nginx

COPY ./nginx.conf /etc/nginx/conf.d/nginx.conf

COPY --from=builder . /usr/share/nginx/html
```
- First I need to create a builder which will copy the from the local mashine to the container
- Second Im using nginx to copy a new congiguration file to my container
This config will let nginx know where the which file it needs to show on my localhost
- Then I copy from builder into the path name to were I told nginx to find the index.html file
CMD:
- docker build -t amfchef/multi-stage .
- docker run -p 80:80 -v $(pwd):/usr/share/nginx/html amfchef/multi-stage
- open localhost:80
- see if "Hello World" shows
- Try to change the index.html to "Hello World!!!"
- refresh the localhost:80
- See if it updates
- And it does!!
- - CTR c --> to exit
- docker run -d -p 80:80 --name=nginx amfchef/multi-stage
- docker stop nginx
- docker container rm nginx
- docker rmi amfchef/multi-stage

