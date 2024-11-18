# GCP Monitoring and Alert Setup
## 1. Set Up Monitoring for the Server
If the server is a Google Compute Engine (GCE) instance, you can monitor it directly through GCP Monitoring.

### Enable Cloud Monitoring
1. In the Google Cloud Console, go to Monitoring.
2. If this is your first time setting up Monitoring, select the Workspace for your project and enable Monitoring.
### Install the Monitoring Agent
1. SSH into your instance and run the following commands to install the Cloud Monitoring agent:
```
curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
sudo bash add-monitoring-agent-repo.sh
sudo apt-get update
sudo apt-get install stackdriver-agent
sudo service stackdriver-agent start
```
2. The agent will start sending metrics (CPU, memory, disk usage) to Cloud Monitoring.
## 2. Set Up Uptime Checks for Server and Website
An uptime check monitors the availability of an endpoint, like a server IP or website URL.

1. In the Google Cloud Console, go to Monitoring > Uptime checks.
2. Click Create Uptime Check and configure:
3. Name: (e.g., Server Uptime or Website Uptime).
4. Protocol: Choose HTTP, HTTPS, or TCP.
5. Resource Type: Select URL for a website or specify the server’s IP.
6. Host: Enter the URL of the website or IP address of the server.
7. Path: For websites, use / or a specific endpoint (e.g., /health).
8. Regions: Choose the regions for GCP to perform the checks.
9. Click Test to verify, then Save.
## 3. Set Up Alerting Policies for the Server and Website
Create alerting policies to receive notifications if the uptime checks fail or if server metrics exceed thresholds.

### Uptime Check Failure Alerts
1. In Monitoring, go to Alerting > Create Policy.
2. Under Conditions, click Add Condition.
3. Condition Type: Choose Uptime Check.
4. Target: Select the uptime check you created.
5. Configuration: Set a failure threshold (e.g., failure for more than 2 minutes).
6. Click Done to add the condition.
### Server Metrics Alerts (CPU, Memory)
1. In Alerting, click Create Policy > Add Condition.
2. Configure conditions for specific metrics:
3. Resource Type: Select GCE VM Instance.
4. Metric: Choose a metric, like CPU utilization or memory usage.
5. Threshold: Set a threshold (e.g., CPU usage > 80% for 5 minutes).
6. Click Done to add the condition.
## 4. Configure Notification Channel
1. Under Notifications, click Add Notification Channel and choose Email.
2. Enter your email address (or others) to receive alerts.
3. Click Save.
## 5. Name and Save the Alerting Policy
1. Policy Name: Provide a descriptive name (e.g., Server CPU High, Website Down).
2. Documentation: Optionally, add troubleshooting steps or information.
3. Click Save.
## 6. Test the Setup
1. To test, simulate a failure, like stopping the server or website.
2. Verify that the uptime check fails and that an email alert is received.
## 7. View Metrics and Alerts
You can view real-time metrics and alerts in Cloud Monitoring > Dashboards or Alerting.

## 8. Also I added my configurations for better understanding of what's going bad.
If you want to import configs you can easily do this:

1. Copy the desired configuration.
2. Go to service page.
3. Open code editor.
4. Change environments that are proper for your account and project.
