# `connect moon_orbital_recon --password=Gsdfg53254Hsdfg`

> Establishing uplink to OSN-LUNA17...  
> Orbital satellite node authenticated.  
> Scan archive accessible.  
> /osn-luna17/  
> └── OSN-LUNA17_SCAN_ARCHIVE.log


Attempting to open the file `OSN-LUNA17_SCAN_ARCHIVE.log` triggers a minigame. The file [OSN-LUNA17_SCAN_ARCHIVE.log](/OSN-LUNA17_SCAN_ARCHIVE.log) is then downloaded to your desktop after successfully completing the minigame.

> Loading scan archive...  
> Archive loaded. Forensic analysis required to decrypt contents.  

## Digital Forensics

It doesn't seem to be necessary to look through any of the files, you can simply use these commands in the minigame's terminal to answer the questions and complete it:
```
answer q1 alex
answer q2 drop.glass
answer q3 backup.enc
answer q4 7812
```

The virtual directory structure is 
```
case/
    bin/
        • backup.enc
        • malware.bin
    images/
        • badge.png
        • floorplan.png
    logs/
        • auth.log
        • proxy.log
    • manifest.txt
    • README.md
    • tasks.txt
```

### `logs/auth.log`
```log
2025-08-30 21:58:33 sshd[29211]: Accepted password for james from 10.0.5.24
2025-08-30 22:14:02 sshd[29301]: Accepted password for james from 10.0.5.24
2025-08-30 22:51:55 sshd[29412]: Accepted password for alex from 10.0.5.21
2025-08-31 03:12:44 sshd[29790]: Failed password for root from 82.34.12.7
2025-08-31 03:14:53 sshd[29795]: Accepted password for guest from 10.0.5.22
```
EVIDENCE_FOUND: Login found in logs: james [+7 points]  
EVIDENCE_FOUND: Timeline event: SSH login by james [+6 points]  
EVIDENCE_FOUND: Timeline event: Repeat SSH login by james [+4 points]  
EVIDENCE_FOUND: Timeline event: SSH login by alex [+9 points]  
EVIDENCE_FOUND: Timeline event: Failed root login attempt [+8 points]  

### `open logs/proxy.log`
```log
2025-08-30 22:56:14 proxy: CONNECT downloads.kernel.org
2025-08-30 23:02:01 proxy: CONNECT data-sync.io
2025-08-30 23:05:09 proxy: GET https://drop.glass/upload
2025-08-30 23:07:42 proxy: POST https://drop.glass/api/put?token=8f91...
2025-08-31 00:02:11 proxy: CONNECT archive.ubuntu.com
```
EVIDENCE_FOUND: Exfiltration domain: drop.glass [+9 points]  
EVIDENCE_FOUND: Timeline event: Access to external service drop.glass [+9 points]  
EVIDENCE_FOUND: Timeline event: POST request with token to drop.glass [+10 points]  

### `open bin/backup.enc`
```
0000 45 4e 43 52 59 50 54 45 44 0a 63 68 75 6e 6b 3a |ENCRYPTED.chunk:|
0010 30 30 31 0a 63 68 75 6e 6b 3a 30 30 32 0a 63 68 |001.chunk:002.ch|
0020 75 6e 6b 3a 30 30 33                            |unk:003|
```

### `open manifest.txt`
```bash
/case/bin/backup.enc DEADBEEF
/case/bin/malware.bin F1733A48
/case/images/badge.png 51504853
/case/images/floorplan.png F0B0012F
/case/logs/auth.log D7695F44
/case/logs/proxy.log EF63ABA5
/case/manifest.txt 811C9DC5
/case/README.md A49930CF
/case/tasks.txt 4939E87E
```

### `open README.md`
```md
# Case 7A: "Night Breach"
Find answers to 4 questions using logs, metadata, manifest and analysis.
Hint: timeline/verify commands will help narrow down suspects.
```

### `open tasks.txt`
```
q1) Who was the last user to login on 30 Aug 2025 after 22:00?
q2) Which domain received the leaked data (from proxy logs)?
q3) Which file has been tampered with (compared to manifest.txt)?
q4) What access code is stored in badge.png metadata?
```

### `open images/badge.png`
```
��binaryPNGstub
```
EVIDENCE_FOUND: Access code from metadata: 7812 [+8 points]

### `open images/floorplan.png`
```
PNGstub
```

### help
```
CORIE FORENSICS SHELL - COMMAND_REFERENCE:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[NAVIGATION]:
 ls [path] — list files
 cd [path] — change directory
 tree — directory tree
    <div class="terminal-line"></div>

[FILE_ANALYSIS]:
 open|cat &lt;file&gt; — view file content
 meta &lt;file&gt; — metadata/properties
 hex &lt;file&gt; — hex dump
 hash &lt;file&gt; — file hash
    <div class="terminal-line"></div>

[INVESTIGATION]:
 grep &lt;pattern&gt; [path] — search content
 verify — integrity check
 timeline — event chronology
 suspects — suspect analysis
 evidence — collected evidence
    <div class="terminal-line"></div>

[CONCLUSION]:
 answer q1|q2|q3|q4 &lt;answer&gt; — answer question
 hint — get hint
 status — show progress
 reset — restart case
```

### status
```
0/4 answers completed.
✗ q1: Who was the last user to login on 30 Aug 2025 after 22:00?
✗ q2: Which domain received the leaked data (from proxy logs)?
✗ q3: Which file has been tampered with (compared to manifest.txt)?
✗ q4: What access code is stored in badge.png metadata?
```
This shows your actual progress through the minigame.

### ls
```
[D] bin
[D] images
[D] logs
[F] manifest.txt
[F] README.md
[F] tasks.txt
```