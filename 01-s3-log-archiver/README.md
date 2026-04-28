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

---

## 🧠 Interview Prep: Deep Dive
<details>
  <summary><b>Q1: Why did you use gzip instead of just moving the files?</b></summary>
  <br>
  <b>A:</b> Storage costs in AWS are calculated by size. Gzip provides a ~90% compression ratio for text logs. This directly reduces the S3 storage bill and lowers the "Data Transfer Out" costs during the upload process.
</details>

<details>
  <summary><b>Q2: How did you ensure security during the S3 transfer?</b></summary>
  <br>
  <b>A:</b> I utilized AWS IAM (Identity and Access Management) with the principle of "Least Privilege." The credentials used by the script only have 'PutObject' permissions for this specific bucket, preventing any unauthorized access to other cloud resources.
</details>

<details>
  <summary><b>Q3: What happens if the internet goes down during the upload?</b></summary>
  <br>
  <b>A:</b> The script checks the exit code ($?) of the AWS CLI command. If the upload fails, the exit code is non-zero. The script then skips the local deletion and keeps the file safe on the disk until the next successful run.
</details>

## ☁️ Cloud Architecture Explanation

* **Compute:** Ubuntu Instance (WSL/EC2) generates system logs.
* **Storage:** Amazon S3 (Standard) acts as the primary archive.
* **Automation:** S3 Lifecycle Rules move data to **Glacier** after 90 days for maximum cost efficiency.
