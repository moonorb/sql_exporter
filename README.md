# Prometheus SQL Exporter 
This is a fork from the [original](https://github.com/justwatchcom/sql_exporter) Prometheus SQL Exporter by **justwatch**.

There is no modification in source code. This repo includes Helm Charts so it can be deployed on a Kubernetes cluster in a secure method. I have used Vertica for testing DB connectivity. The code also supports MySQL and Postgres.

## What Problem Are We Trying to Solve?
There is no out of the box solution to monitor a Vertica Cluster via Prometheus which works with Kubernetes. This exporter enables us to run custom SQL queries and export the results in Prometheus time series database.

![Alt text](https://github.com/moonorb/sql_exporter/blob/master/images/SQL_Exporter.PNG)

## Prerequisites
You must have a running VerticaDB to test this.

## Deploy SQL Exporter
The original code keeps DB credentials in plain text. Helm Chart keeps the complete connection string as a secret so the database credentials are not exposed.


create a namespace and the secret before deploying the chart
```
kubectl create ns exporter
kubectl create secret generic db-connection-secret --from-literal=url='vertica://<DBUSER>:<DBPASS>@<DB_FQDN>:5433/<DATABASE>counters?queryArgs' -n exporter
cd helm-chart
helm install mychart sqlexporter -n exporter
```
Validate Pod logs to see if you Pod has succesfully connected to Vertica DB outside the Kubernetes cluster.

```
[blah@jumphost helm-chart]$ k logs pod/sqlexporter-559946bc5f-95fxt -n exporter --tail=5
{"caller":"job.go:204","job":"vertica1","level":"debug","msg":"Running Query","query":"vertica_connections_per_node_k8s","ts":"2023-06-02T02:22:05.634939993Z"}
{"caller":"job.go:210","job":"vertica2","level":"debug","msg":"Query finished","query":"node_count","ts":"2023-06-02T02:22:05.639192088Z"}
{"caller":"job.go:177","job":"vertica2","level":"debug","msg":"Sleeping until next run","sleep":"5m0s","ts":"2023-06-02T02:22:05.639243343Z"}
{"caller":"job.go:210","job":"vertica1","level":"debug","msg":"Query finished","query":"vertica_connections_per_node_k8s","ts":"2023-06-02T02:22:05.644242849Z"}
{"caller":"job.go:177","job":"vertica1","level":"debug","msg":"Sleeping until next run","sleep":"1m0s","ts":"2023-06-02T02:22:05.644284974Z"}
```



Depending on what you want to monitor on your Vertica DB, jobs with different intervals can be added in values.yaml. I only have 2 jobs to monitor node_count and DB Connection.

If you check your Prometheus you should see the service monitor and counters

