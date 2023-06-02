# Prometheus SQL Exporter 
This is a fork from the [original](https://github.com/justwatchcom/sql_exporter) Prometheus SQL Exporter by **justwatch**.

There is no modification in source code. This repo includes Helm Charts so it can be deployed on a Kubernetes cluster in a secure method. I have used Vertica for testing DB connectivity. The code also supports MySQL and Postgres.

## What Problem Are We Trying to Solve?
There is no out of the box solution to monitor a Vertica Cluster via Prometheus which works with Kubernetes. This exporter enables us to run custom SQL queries and export the results in Prometheus time series database.

## Deploy
The original code keeps DB credentials in plain text. Helm Chart keeps the complete connection string as a secret so the database credentials are not exposed.


First create a namespace and the secret
```
kubectl create ns exporter
kubectl create secret generic db-connection-secret --from-literal=url='vertica://<DBUSER>:<DBPASS>@<DB_FQDN>:5433/<DATABASE>counters?queryArgs' -n exporter
```
Deploy Helm Chart
```
cd helm-chart
helm install mychart sqlexporter -n exporter
```


