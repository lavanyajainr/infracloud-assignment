PART 1
Pull docker images
```
docker pull infracloudio/csvserver:latest
docker pull prom/prometheus:v2.22.0
```

Run container for first time
```
docker run --name infracloud -d infracloudio/csvserver
```

Check docker logs for failure
```
docker logs -f infracloud
```
 output: error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory 

Delete the  container (NOTE: delete infracloud if you are running multiple docker run command)
```
docker rm -f infracloud
```

Write bash script to generate inputFile and other required content
```
touch gencsv.sh
```

Give executable permisiion for the script
```
chmod +x gencsv.sh
```

Run the bash script
```
bash gencsv.sh
```

Get the content of inputFile
```
0, 10483
1, 10706
2, 24295
3, 12775
4, 3263
5, 19376
6, 24830
7, 22507
8, 25324
9, 26749
```

Run the container again in the background with file generated  available inside the container
Mounting the inputFile from current working directory into the container path /csvserver with renamed file inputdata
```
docker run --name infracloud -v $PWD/inputFile:/csvserver/inputdata -d infracloudio/csvserver
```

Get shell access to the container and find the port
```
docker exec -it infracloud bash
```

Check the application port
```
netstat -ntlp
```

Output:
```
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp6       0      0 :::9300                 :::*                    LISTEN      1/csvserver
```

Run the container with mapping app port 9300 to localhost 9393 and passing environmanet variable with its value
```
docker run --name infracloud -v $PWD/inputFile:/csvserver/inputdata --env CSVSERVER_BORDER="Orange" -p 9393:9300 -d infracloudio/csvserver
```

Hit the browser
```
http://localhost:9393/
```
Running teh following command to generate file part-1-output
```
curl -o ./part-1-output http://localhost:9393/raw
```

PART 2
Create docker-compose.yaml file for running application
```
vi docker-compose.yaml
```
Run the docker-compose file
```
docker-compose up -d
```

PART 3
Add Prometheus container to docker compose file
 Mounting the prometheus.yml file from current workimg directory.
 New yml file has configuration to collect data from our application at ```infracloud:9300/metrics```.

Prometheus can be accessed at
```
http://localhost:9090
```
below command shows a straight line graph with value 10 for the record csvserver_records
```
http://localhost:9090/graph?g0.range_input=1h&g0.expr=csvserver_records&g0.tab=0
```


