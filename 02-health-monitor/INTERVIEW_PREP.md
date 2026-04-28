# 🧠 Technical Deep Dive: System Health Monitor (The Watchdog)

### 🌟 Project Concept: "The Self-Healing Brain"
Most companies find out their server is down because a customer complains. That is "Reactive" engineering. This project is "Proactive." It acts as a 24/7 Watchdog that monitors the server's vitals and fixes problems before they become outages.

### 🎯 Objective & Strategy
The goal is **High Availability (HA)**. 
* **Strategy:** The script checks Disk Usage. If it hits a specific "Threshold" (e.g., 80%), it triggers two actions:
  1. **Alerting:** Sends an instant email via **AWS SNS** so humans stay informed.
  2. **Remediation:** Automatically calls the Project 01 script to clear space.

### 💰 Real-World Business Value
* **Reduced MTTR (Mean Time To Repair):** Instead of waiting for an engineer to wake up at 3 AM to clear a disk, the script does it in milliseconds.
* **Customer Trust:** Prevents "Disk Full" errors that lead to website downtime.

### 🎤 Interview Q&A (Beginner to Pro)
**Q: Why use AWS SNS instead of a simple local email?**
**A:** AWS SNS (Simple Notification Service) is a managed cloud service. It is highly reliable and can scale to send alerts to SMS, Email, or even PagerDuty. It keeps the "Alerting" separate from the server's own problems.

**Q: How does this connect to the other projects?**
**A:** It is the **Orchestrator**. It’s the "Brain" that decides when to use the "Mover" (Project 01).
