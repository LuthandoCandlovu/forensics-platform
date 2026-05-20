# AI-Powered Digital Forensics Platform

## Features
- Malware file analysis (YARA)
- Windows event log suspicious activity detection
- Email phishing analysis
- Timeline reconstruction
- AI-generated forensic reports (ML attribution)

## Quick Start
1. Run .\setup_forensics_fixed.ps1 to install dependencies
2. Place suspicious files in suspicious_samples\
3. Place emails (.eml) in emails\
4. Execute .\Run-FullForensics_Fixed.ps1
5. View AI_Report.html

## Requirements
- Windows PowerShell 5.1+
- Python 3.8+
- YARA Python module (installed by setup script)

## Disclaimer
Use only on systems you own or have explicit permission to analyze.
