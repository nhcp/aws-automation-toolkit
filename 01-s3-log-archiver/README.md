# ☁️ Project 01: S3 Automated Log Archiver

## 📋 Business Problem
High-volume system logs were threatening to exhaust disk space on production EC2 instances, leading to potential system crashes. Manual cleanup was inconsistent and risked losing historical data required for compliance.

## 🛠️ The Solution
A Bash-based automation suite that identifies "cold" log data, compresses it using `gzip` to reduce cloud storage costs by ~90%, and securely offloads it to an Amazon S3 bucket.

## 🚀 Key Technical Features
* **Automated Rotation:** Filters files older than 24h to ensure "hot" logs are untouched.
* **Storage Optimization:** Integrated with S3 Lifecycle Policies (Standard -> IA -> Glacier) to automate long-term cost savings.
* **Secure Auth:** Uses IAM Least Privilege principles for CLI authentication.

## 📈 Impact
* **Reliability:** Reduced disk-related downtime to 0%.
* **Cost:** Lowered storage expenses by 80% via tiered S3 lifecycle transitions.
