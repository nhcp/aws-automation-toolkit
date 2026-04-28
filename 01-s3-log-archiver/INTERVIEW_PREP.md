cat <<EOF > ~/aws-automation-toolkit/01-s3-log-archiver/INTERVIEW_PREP.md
# 🧠 Technical Deep Dive: S3 Log Archiver

This document contains the engineering logic and architectural decisions made during the development of this tool. It is intended for technical interviews and system audits.

## 📋 Q&A Breakdown

### Q1: Can you walk me through the cost-benefit analysis of using Gzip?
**A:** In a production environment, logs can grow to several gigabytes daily. AWS S3 charges based on storage volume (GB/month) and data transfer. By implementing **Gzip (LZ77 algorithm)**, we achieve up to a 90% reduction in file size. Across a fleet of 500 instances, this automation saves thousands of dollars annually.

### Q2: How did you implement the "Least Privilege" security model?
**A:** I configured the AWS CLI with an **IAM User** that has a specific **Inline Policy**. Instead of 'AdministratorAccess', the user only has 's3:PutObject' and 's3:ListBucket' permissions restricted specifically to the 'nhcp-log-archive-2026' ARN.

### Q3: Explain your Error Handling logic. How do you prevent data loss?
**A:** The script follows a **"Verify-Before-Delete"** pattern. I capture the **Standard Exit Code (\$?)** of the 'aws s3 cp' command. A code of '0' indicates success. The local 'mv' command only executes if the code is 0.

### Q4: How does this fit into a larger SRE strategy?
**A:** This addresses **MTTR (Mean Time To Recovery)** and **Error Budgets**. By automating rotation, we eliminate "Disk Full" outages. By archiving to S3, we ensure post-incident reports have historical data available for root-cause analysis.
EOF
