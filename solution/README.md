Run container for first time
```
docker run --name infracloud -d infracloudio/csvserver
```

Check docker logs for failure
```
docker logs -f infracloud
```
 output: error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory 

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


