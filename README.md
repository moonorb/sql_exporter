# Prometheus SQL Exporter 

This is a fork from the [original](https://github.com/justwatchcom/sql_exporter) Prometheus SQL Exporter.

There is no modification in source code. This repo includes Helm Charts so it can be deployed on a Kubernetes cluster in a secure method. I have used Vertica for testing DB connectivity.

## Deploy Helm Chart

The original code keeps DB credentials in plain text. Helm Chart keeps the complete connection string as a secret so the database credentials are not exposed.