# 🛡️ Project 02: Self-Healing System Health Monitor

## 📋 Project Overview
Automation is only as good as the triggers that execute it. This project acts as the **"Observability Layer"** for our infrastructure. It monitors critical system metrics (Disk, RAM) and autonomously triggers maintenance routines when thresholds are breached.

## ⚙️ How it Works
1. **Continuous Monitoring:** The script checks the root file system usage percentage.
2. **Threshold Logic:** If usage exceeds **80%**, the system identifies a risk of crash.
3. **Integrated Response:** The monitor automatically executes the **S3 Log Archiver (Project 01)** to offload data and clear space.
4. **Audit Logging:** Every check is recorded in `system_health.log` for future performance analysis.

## 🚀 Business Value
* **Proactive Prevention:** Issues are resolved before users or services are affected.
* **Cost Efficiency:** Only runs heavy cleanup tasks when necessary, saving CPU cycles.
* **Reduced MTTR:** Minimizes "Mean Time To Recovery" by automating the resolution of common disk-related issues.
