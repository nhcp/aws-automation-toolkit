# 🧠 Technical Deep Dive: S3 Log Archiver

### 🌟 What is this project about?
Think of this as an **Automated Cleaning Service**. As servers work, they create "notes" (logs) about everything they do. If you don't clean them up, the computer runs out of space and crashes. This project automatically finds old notes, squashes them to save space, and puts them in a safe "cloud warehouse" (AWS S3).

### 🎯 Objective
To move data from expensive local storage to cheap cloud storage without any human effort.

### 🎤 Interview Q&A
**Q: Why use Gzip?**
**A:** Gzip reduces file size by up to 90%. Across a large fleet of servers, this saves thousands of dollars in AWS storage fees annually.

**Q: What happens if the internet goes out during upload?**
**A:** The script checks the **Exit Code ($?)**. If the AWS upload fails, the script stops and won't delete the local file, ensuring zero data loss.
