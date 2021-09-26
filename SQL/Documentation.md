# Documentation MySQL
 - Create a docker-compose.yml file
 - Add:
```
version: "3"  # optional since v1.27.0

services:
  db:
    image: mysql
    command: --default-authentication-plugin=mysql_native_password

    restart: always
    environment:
        MYSQL_ROOT_PASSWORD: root
        MYSQL_DATABASE: mydb
        MYSQL_USER: user
        MYSQL_PASSWORD: user
    volumes:
        - ./init.sql/:/docker-entrypoint-initdb.d/init.sql
        - mydbdata:/var/lib/mysql
  adminer:
    image: adminer
    restart: always
    ports:
        - 8081:8080
        #- 5000:5000
volumes:
  mydbdata:
```

- I add two services
- db, is an pre exited image from mysql
- then I use a command, to add a plugin to mysql image
- Saving environment variable such as:
password, database, userName, password
- adding volumes:
a init file, which will create a table with some information
The other volume is a mydbdata, which will save the data in a path
- The next service is an adminer, which is a pre exited image
It will run on localhost:8081, and be a GUI version of the DB.
