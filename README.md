# 🛠️ AWS Cloud-Native Automation Toolkit

A production-grade suite of Bash-based automation tools designed to manage infrastructure health, data lifecycle, and disaster recovery on AWS environments.

## 🏗️ Architecture Overview
This toolkit implements a **Closed-Loop Automation** pattern:
1. **Observability:** Continuous monitoring of system vitals (Disk, RAM).
2. **Alerting:** Real-time event notifications via **AWS SNS**.
3. **Action:** Automated data offloading to **Amazon S3** to prevent system outages.
4. **Recovery:** Streamlined restoration paths for archived data.

---

## 📁 Project Breakdown

### [01. S3 Log Archiver](./01-s3-log-archiver)
* **Role:** Cost Optimization & Storage Management.
* **Function:** Compresses and migrates stale logs to S3.
* **Key Feature:** Implements a 24-hour retention policy before cloud migration.

### [02. System Health Monitor](./02-health-monitor)
* **Role:** Reliability Engineering.
* **Function:** Monitors disk usage and triggers auto-scaling/cleanup logic.
* **Key Feature:** Integrated with **AWS SNS** for immediate engineering alerts.

### [03. Disaster Recovery](./03-disaster-recovery)
* **Role:** Business Continuity.
* **Function:** Selective restoration of unzipped logs from S3.
* **Key Feature:** One-command retrieval and decompression.

---

## 🔒 Security & Best Practices
* **IAM Least Privilege:** Designed to work with granular IAM policies (S3:PutObject, SNS:Publish).
* **Environment Variables:** No hardcoded credentials; uses AWS CLI configuration profiles.
* **Idempotency:** Scripts check for existing directories/files before execution to prevent errors.

## 🚀 Deployment
1. Clone the repo: `git clone https://github.com/nhcp/aws-automation-toolkit.git`
2. Configure AWS CLI: `aws configure`
3. Set execution permissions: `chmod +x **/*.sh`
4. Automate via Cron: `*/5 * * * * /path/to/monitor.sh`

---
**Author:** nhcp | **Focus:** DevOps & Cloud Engineering
