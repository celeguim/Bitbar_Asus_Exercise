# Android devices battery temperature monitoring exercise
The goal of this small exercise is to create a cookbook which will be used to configure a sample monitoring system.
The system is composed by one or more Linux boxes to which is physically attached an Android Phone via USB.
Once a new linux box is configured temperature data should be sent to an existing Prometheus instance; also
a Grafana dashboard should be created/updated in order to display the metrics.

## Notes:
* The temperature from the battery device can be easily gathered via an adb command.
* Chef Server and its configuration are not relevant for this exercise the main focus is around the cookbook itself
* Both Prometheus and Grafana can be assumed as already available in the network.