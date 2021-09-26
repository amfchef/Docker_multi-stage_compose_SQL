# Inlämningsuppgift 2

Vad som i denna inlämningsuppgift evalueras:

**Efter genomför kurs ska den studerande ha färdigheter i att:**

1. Redogöra för de olika koncepten inom Docker

   

**Efter genomförd kurs ska den studerande ha färdigheter i att:**

1. Använda Docker på ett för ändamålet effektivt sätt

**Efter genomför kurs ska den studerande ha kompetens i att:**

1. Skapa, utveckla, implementera, driftsätta och underhålla containrar i Docker

Inlämningsuppgiften("Inlämningsuppgift 2") består av två delar, en teoretisk och en praktisk. Med den här inlämningsuppgiften skall du även skriva en kortare rapport där du dokumenterar hur du tänkt igenom det praktiska momentet ("Del 2, Praktisk tillämpning").



#### Del  1, Teoretiskt

###### 1.1 Docker och containerteknologi

Beskriv de olika koncepten inom Docker utifrån följande frågor:

- Vad är Docker(plattformen)?
- Vad är en Docker Image och hur relaterar en sådan till Docker Containers?
- Vad innebär containerteknologi?
- Vad är Docker Registry?
- Hur lyder Docker Linux Kernels arbetsbeskrivning (vad den gör och hur det går till)?
- På vilket sätt kan Docker och Docker Containers jämföras med fartygstransporter? 
- Vad händer när vi har en Dockerfile och kör "docker build ."? Gå igenom build-processen

###### 1.2 Docker Client

Gå igenom en containers livscykel genom att använda Docker Commands.

Ex: 

**En container föds**

```
docker create
```

###### 1.3 Docker Compose

Förklara rad för rad följande i docker-compose fil:

```yaml
version: "3.8"
services: 
 flask:
  container_name: flaskcontainer
  build:
   context: ./app
   dockerfile: Dockerfile.dev
  ports:
   - "5000:5000"
  depends_on: 
   - db
  networks:
    - flask_app_net
 db:
  container_name: dbcontainer
  image: postgres:latest
  restart: always
  environment: 
   POSTGRES_DB: mydb
   POSTGRES_PASSWORD: postgres
   POSTGRES_USER: postgres
  volumes:
   - postgres_data:/var/lib/postgresql/data/
  networks:
   - flask_app_net
       
networks:   
  flask_app_net:
      driver: bridge

volumes:
 postgres_data:

```

Utgå ifrån att mappen där docker-compose även innehar en flask-applikation i en mapp som heter "app".

#### Del 2, Praktiskt

##### 2.1 Dockerfile

**2.1.1 Flask app**

På din dator: Skapa en mapp som heter flask-app.

I denna mapp skapar du tre filer: app.py, donotinclude.txt och requirements.txt. Kopiera in respektive kod i filerna.

**app.py**

```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
  return '<h1>Hello World</h1>'

if __name__=='__main__':
  app.run(host='0.0.0.0')
```

**requirements.txt**

```yaml
Flask==2.0.1
```

**donotinclude.txt**

```
textthatshouldnotbeincluded
```

Din uppgift:

1. Skapa en Dockerfile för appen.

2. När du bygger imagen ska "donotinclude.txt" INTE inkluderas.

3. Beskriv i Dockerfile vem som är "maintainer" genom att använda en instruktion för meta data.

4. Base image ska vara pythons, men det ska vara baserad på python version 3.9 och alpine 3.13.

5. När du kör 

   ```
   docker run -p 5000:5000 <image id>
   ```

   och går in på localhost:5000 ska det visas

   "Hello World"

     

6. Pusha imagen till Docker Hub. Imagen som pushas ska ha tag :1.0.

7. Skriv en kort rapport på stegen där du även har med en länk till imagen i docker hub.

   

**2.1.2 Multi-stage Build**

Skapa en mapp vid namn multi-stage.

I denna mapp skapar du två filer: index.html och nginx.conf. Kopiera in respektive kod i filerna. 

**index.html**

```
<h1>Hello World</h1>
```

**nginx.conf**

```
server {
  listen 80;

  location / {
    root /usr/share/nginx/html;
    index index.html;
  }
}
```

Din uppgift:

Skapa en Dockerfile som använder sig av multi-stage-build.

```
docker build -t username/nginx .
docker run -p 80:80 username/nginx
```

Ska rendera Hello World på localhost:80/

Din uppgift slutar docker inte där.

Ditt mål är att kunna utföra följande steg:

1. Bygg en image utfifrån din Dockerfile
2. Starta en container utifrån image. Ditt mål är att
   1. När du går in på localhost:80 ska "Hello World" synas
   2. När du gör en ändring i index.html ska det reflekteras i browsern.
   3. Containern ska köras i bakgrunden. Alltså när du kör dit docker run-kommando ska du kunna använda samma flik som du körde kommandot i.

Skriv en kort rapport på stegen du har tagit.

###### 2.2 Docker Compose

###### 2.2.1 Mysql Persistent Data

Du ska nu, med hjälp av Docker Compose, köra en container baserad på MySQL's officiella Image.

Ditt mål är kunna köra följande steg, precis som det står skrivet:

Efter att du har kört 

```
docker-compose up
```

Ska du i en annan terminal-flik köra

```
docker exec -it mysqlcontainer sh
```

Väl inne i containern kör du

```
mysql -u iamtheuser -pmypassword
```

och du ska då vara ansluten till mysql

```
mysql>
```

Kör:

```
USE mydb
> Database changed
```

Kör:

```
CREATE TABLE books(id INT NOT NULL AUTO_INCREMENT, title VARCHAR(50) NOT NULL, PRIMARY KEY(id));
> Query OK, 0 rows affected (0.02 sec)
```

Kör:

```
INSERT INTO books(title) VALUES("jack");
> Query OK, 1 row affected (0.01 sec)
```

För att försökra dig om att datan har lagrats:

```
SELECT * FROM books;
>
+----+-------+
| id | title |
+----+-------+
|  1 | jack  |
+----+-------+
```

Gå tillbaka till fliken där docker-compose körs och tryck ctrl + c.

```
^CGracefully stopping... (press Ctrl+C again to force)
Killing mysqlcontainer  ... done
```

kör

```
docker-compose down
>
Removing mysqlcontainer ... done
Removing network mysql_default
```

Kör

```
docker-compose up
```

Öppna ett ny flik och kör återigen

```
docker exec -it mysqlcontainer sh
```



```
mysql -u iamtheuser -pmypassword
```



```
USE mydb;
> Database changed
```



```
SELECT title FROM books WHERE id=1;
```



```
+-------+
| title |
+-------+
| jack  |
+-------+
1 row in set (0.00 sec)
```

Skriv en kort rapport där även docker-compose.yml finns med.

### 3. Projekt

Uppgift:

Containerize ett project med minst 2 services, (ex front-end och db).

Även om du får gå hur långt du vill med projektet exempelvis använda dig av Github Actions eller deploya projektet, så kommer projektet att bedömas efter följande kriterier:

```
Efter genomförd kurs ska den studerande ha färdigheter i att

Använda Docker på ett för ändamålet effektivt sätt

Efter genomför kurs ska den studerande ha kompetens i att:

Skapa, utveckla, implementera, driftsätta och underhålla containrar i Docker
```

Alltså:

Du har ett projekt skapat lokalt. Hur bra använder du Docker för ditt ändamål? Vad är ditt ändamål?

Har du olika versioner för dev och  produktion? Vad är skillnaded på dessa version?

I produktionsbygget, använder du dig då av endast det du behöver?

Hur du skapar, utvecklar, implementerar, driftsätter och underhåller du containrar.

Du behöver inte använda dig av en egen applikation. 

Skicka med rapport där du går igenom steg för steg hur du har tänkt och vilka avvägningar du har gjort. 



Dokumentation:

Skicka helst in alla rapporter i ett dokument.

Deadline 210926 kl 23.55.
