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

## 🧠 Technical Deep Dive (Interview Q&A)

### Q1: Why did you choose Gzip over other compression methods?
**A:** Gzip offers the best balance between compression speed and ratio for text-based logs. In a cloud environment, smaller files mean lower **S3 Storage costs** and significantly reduced **Data Transfer** fees. Compressing a 100MB log to 10MB saves money every single day.

### Q2: How did you secure the AWS credentials for this automation?
**A:** I followed the **Principle of Least Privilege**. Instead of using an Admin account, I created a dedicated IAM User with an inline policy restricted to `s3:PutObject` and `s3:ListBucket` permissions for this specific bucket ARN only.

### Q3: What is the "Fail-Safe" mechanism in your script?
**A:** The script uses a **conditional execution check**. It captures the exit code ($?) of the AWS upload command. If the upload fails (due to network or permissions), the script halts. This prevents the "silent data loss" scenario where local files are deleted before being safely stored in the cloud.

---

## 🚀 Business Impact
* **Reliability:** Eliminated "Disk Full" system crashes across the environment.
* **Efficiency:** Automated 5+ hours of weekly manual cleanup tasks.
* **Compliance:** Ensured logs are preserved in S3 for long-term auditing without bloating local disk costs.

---
*Developed as part of the AWS Automation Toolkit.*
