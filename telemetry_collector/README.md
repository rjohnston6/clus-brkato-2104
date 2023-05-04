# Telemetry Collector Example
The included docker compose file provides an example on how to configure Telegraf and Apache kafka for demonstration and lab purposes.

## How to Use
### gNMI Certificate Requirement
To use the docker compose file a certificate is required to enable the communication with a network device using dial-in telemetry configurations. The example topology provided leverages Nexus 9000v based on NX-OS 10.3(2). Using the instructions available at the following link create a certificate on the target network device and save the public key to this working directory `telemetry_collector/` as `gnmi.pem`.

[Cisco Nexus 9000 Series NX-OS Programmability Guide, Release 10.3(x) - Generating and Configuring Key/Certificate Examples for Cisco NX-OS Release 9.3(3) and Later](https://www.cisco.com/c/en/us/td/docs/dcn/nx-os/nexus9000/103x/programmability/cisco-nexus-9000-series-nx-os-programmability-guide-release-103x/m-n9k-gnmi-grpc-network-management-interface-101x.html#Cisco_Task_in_List_GUI.dita_a3318b3f-532c-4aa2-b1cb-e9a4428484da)

### Update Telegraph Credentials
A `.env` file is included and used with the docker compose file. This `.env` file is used to update the credentials used to connect to the network device. Telegraf uses these credentials to connect and create the subsciptions for telemetry. Update the `.env` file with the appropriate credentials for the target device. The environment variables are:

| Variable | Default |
| -------- | ------- |
| DOCKER_TELEGRAF_NET_USERNAME | cisco |
| DOCKER_TELEGRAF_NET_PASSWORD | cisco |

### Apache Kafka Configurations
Located in the docker compose file are defined variables for the Kafka container. To be able to connect to the kafka broker from remote source the following variable will require updates to properly allow for connectivity.

`
KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://172.22.225.11:9092,PLAINTEXT_INTERNAL://broker:29092
`

Replace the `172.22.225.11` address with the address of the docker host that is hosting the containers.

### Docker Compose Up
Once certificates, credentials and kafka configurations are set for your test environment the containers can be brought up. Use `docker compose up -d` to pull and start the containers. Use `docker ps` to verify all containers are started and running, if there are errors with the telegraf configuration the telegraf container will go into a restarting loop, correct any errors with subscription or syntax and restart. The telegraf.conf file is located in the `conf/telegraf/` directory.

# Acknowledgements
The docker compose file was based initially off the compose file [DataKnox/
Cisco-MDT-TIG-Docker](https://github.com/DataKnox/Cisco-MDT-TIG-Docker).