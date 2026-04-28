# 🧠 Technical Deep Dive: Disaster Recovery

### 🌟 What is this project about?
This is the **"Time Machine."** If a manager needs to see logs from months ago that were moved to the cloud, this script reaches into AWS, finds the exact file, and brings it back to the server instantly.

### 🎯 Objective
To minimize **MTTR** (Mean Time To Recovery). Instead of a human manually searching AWS, this script restores data in seconds.

### 🎤 Interview Q&A
**Q: How do the three projects work together?**
**A:** It is a **Full Lifecycle**: Project 02 **Watches**, Project 01 **Archives**, and Project 03 **Restores**. Together, they form a complete, safe data management system.
