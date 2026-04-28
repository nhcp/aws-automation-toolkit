# ☁️ Project 01: S3 Automated Log Archiver

## 📋 Project Overview
In production environments, application and system logs can grow exponentially, quickly consuming disk space on EC2 instances. This leads to system instability and potential outages. This project provides a **production-ready Bash automation suite** that manages the entire log lifecycle: from local rotation and compression to secure cloud archiving.

---

## 🛠️ Key Technical Features
* **Intelligent Log Rotation:** Identifies "cold" logs (older than 24 hours) while maintaining "hot" logs for real-time debugging.
* **Storage Optimization:** Implements the **LZ77 compression algorithm (Gzip)**, reducing storage footprint by ~90%.
* **AWS Integration:** Utilizes the AWS CLI v2 for high-performance data transfer to Amazon S3.
* **Security-First Design:** Configured to work with **IAM Least Privilege** policies (limiting access to specific buckets).
* **Error Handling:** Uses shell exit-status verification to ensure local files are only moved after a confirmed successful upload.

---

## ☁️ Cloud Architecture & Workflow
1.  **Generation:** System logs are generated on the Ubuntu/EC2 instance.
2.  **Processing:** The script runs via Crontab, filters files, and compresses them.
3.  **Transit:** Data is pushed to **Amazon S3** using secure HTTPS endpoints.
4.  **Retention:** S3 Lifecycle policies are utilized to transition data from **Standard** to **Glacier** after 90 days for 80% cost savings.

---



## 🚀 Business Impact
* **Reliability:** Eliminated "Disk Full" system crashes across the environment.
* **Efficiency:** Automated 5+ hours of weekly manual cleanup tasks.
* **Compliance:** Ensured logs are preserved in S3 for long-term auditing without bloating local disk costs.

---
*Developed as part of the AWS Automation Toolkit.*
