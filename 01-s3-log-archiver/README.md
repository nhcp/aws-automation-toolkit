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

---

## 👨‍💻 Detailed DevOps Interview Preparation

<details>
  <summary><b>Q1: Can you walk me through the cost-benefit analysis of using Gzip for Cloud Archiving?</b></summary>
  <br>
  <b>A:</b> In a production environment, logs can grow to several gigabytes daily. AWS S3 charges based on storage volume (GB/month) and data transfer. By implementing <b>Gzip (LZ77 algorithm)</b>, we achieve up to a 90% reduction in file size. 
  <br><br>
  For example, 100GB of raw logs costs ~.30/month in S3 Standard. Compressed, that's 10GB costing /bin/bash.23. While that seems small for one server, across a fleet of 500 instances, this automation saves thousands of dollars annually. Furthermore, smaller files mean faster upload times, reducing the window of potential network interruption.
</details>

<details>
  <summary><b>Q2: How did you implement the "Least Privilege" security model for this automation?</b></summary>
  <br>
  <b>A:</b> Hardcoding root credentials is a major security risk. To secure this pipeline, I configured the AWS CLI with an <b>IAM User</b> that has a specific <b>Inline Policy</b>. 
  <br><br>
  Instead of 'AdministratorAccess', the user only has 's3:PutObject' and 's3:ListBucket' permissions restricted specifically to the 'nhcp-log-archive-2026' ARN. This ensures that even if the script or the server is compromised, an attacker cannot delete existing backups or access other sensitive data in the AWS account.
</details>

<details>
  <summary><b>Q3: Explain your Error Handling logic. How do you prevent data loss?</b></summary>
  <br>
  <b>A:</b> The script follows a <b>"Verify-Before-Delete"</b> pattern. I capture the <b>Standard Exit Code ($?)</b> of the 'aws s3 cp' command. 
  <br><br>
  In Bash, an exit code of '0' indicates success. If the upload is interrupted by a network timeout or AWS API throttling, the code returns a non-zero value. My script uses an 'if-then' block to ensure the local 'mv' (move) command only executes on code 0. This prevents the "silent failure" where a script deletes a local log that never actually made it to the cloud.
</details>

<details>
  <summary><b>Q4: How does this fit into a larger SRE (Site Reliability Engineering) strategy?</b></summary>
  <br>
  <b>A:</b> This project addresses two key SRE metrics: <b>MTTR (Mean Time To Recovery)</b> and <b>Error Budgets</b>. By automating log rotation, we eliminate "Disk Full" outages—a common cause of manual intervention. By archiving to S3, we ensure that post-incident reports (Post-mortems) always have historical data available for root-cause analysis, even if the original EC2 instance is terminated.
</details>
