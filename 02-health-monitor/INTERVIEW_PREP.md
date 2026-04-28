# 🧠 Technical Deep Dive: System Health Monitor

### 🌟 What is this project about?
This is the **"Security Guard"** of the toolkit. It stands watch over the server 24/7, checking how much disk space is left. If the server gets too full (over 80%), it "screams" (sends an AWS SNS email alert) and then "fixes" the problem by calling the Log Archiver.

### 🎯 Objective
To achieve **"Self-Healing Infrastructure"**—where a server fixes its own problems before a human even wakes up.

### 🎤 Interview Q&A
**Q: How does this project relate to the others?**
**A:** This is the **Trigger**. Project 01 is the "tool," but Project 02 is the "hand" that picks up the tool when it's needed.

**Q: Why send an email via SNS?**
**A:** Because engineers need **Visibility**. Even if the script fixes the problem, we need to know it happened so we can investigate the root cause later.
