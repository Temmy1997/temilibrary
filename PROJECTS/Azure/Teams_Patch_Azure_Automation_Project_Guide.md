# Azure Automation → Microsoft Teams Patch Notification Project

## Project Goal

Build an automated monthly patch notification system using:

- Azure Automation Account
- PowerShell Runbook
- System-Assigned Managed Identity
- Azure Automation Variable
- Microsoft Teams Workflow/Webhook
- Two recurring schedules

### Notification 1 — Patch Tuesday

**When:** Second Tuesday of every month at **1:00 PM Pacific Time**

**Message:**

> We are going to have the monthly patch that reboots servers in 2 days, [DATE]. Let the IT team know if there are any blockers.

### Notification 2 — Patch Night

**When:** Two days after Patch Tuesday (Thursday) at **1:00 PM Pacific Time**

**Message:**

> We are going to have the monthly patch that reboots servers tonight, [DATE]. Let the IT team know if there are any blockers.

The dates should be calculated automatically by PowerShell.

---

# 1. Final Architecture

```text
Microsoft Teams
      |
      v
IT Patch Notifications Channel
      |
      v
Teams Workflow / Webhook
      |
      | Webhook URL
      v
Azure Automation Variable
      |
      v
PowerShell Runbook
      |
      +---- System-Assigned Managed Identity
      |
      v
Azure Automation Account
      |
      +---- Schedule 1: 2nd Tuesday, 1 PM PT
      |
      +---- Schedule 2: 2nd Thursday, 1 PM PT
```

## What each component does

**Azure Automation Account:** Runs the PowerShell script in Azure.

**Managed Identity:** Gives the Automation Account an Azure identity without storing a username/password or client secret.

**Automation Variable:** Stores the Teams webhook URL so it is not hard-coded in the PowerShell script.

**PowerShell Runbook:** Retrieves the webhook, calculates the patch date, creates the message, and sends it.

**Teams Workflow/Webhook:** Receives the HTTP request and posts the message into the Teams channel.

**Schedules:** Tell Azure Automation when to run the runbook.

---

# 2. Important Authentication Concept

For this version, we are intentionally using an **Azure Automation Variable instead of Azure Key Vault**.

These are separate concepts:

```text
Managed Identity
    =
Who the Automation Account is
```

```text
Automation Variable
    =
Where the Teams webhook URL is stored
```

The runbook retrieves the variable with:

```powershell
$TeamsWebhookUrl = Get-AutomationVariable -Name "TeamsWebhookUrl"
```

For a production environment, follow your organization's security policy. Key Vault is generally preferable for sensitive secrets, but the Automation Variable approach is suitable for learning this project and mirrors the Uptime Robot variable pattern.

---

# PART A — MICROSOFT TEAMS

# 3. Create the Teams Channel

Open Microsoft Teams.

Find the Team where you want the patch notifications.

Click:

```text
Your Team → ... → Add channel
```

Create:

```text
Channel name:
IT Patch Notifications
```

Choose:

```text
Channel type:
Standard
```

Optional description:

```text
Automated notifications for monthly server patching and maintenance.
```

Click **Create/Add**.

You should now see:

```text
Your IT Teamc
|
+-- General
|
+-- IT Patch Notifications
```

---

# 4. Create the Teams Workflow

Open:

```text
IT Patch Notifications
```

Click:

```text
... → Workflows
```

Find a webhook workflow such as:

```text
Send webhook alerts to a channel
```

Configure it for:

```text
Team:
Your IT Team

Channel:
IT Patch Notifications
```

Save/create the workflow.

The workflow should provide a webhook URL.

It will look similar to:

```text
https://...
```

### IMPORTANT

Treat the webhook URL as a secret.

Do not put it directly into the PowerShell script.

Copy it temporarily because we will store it in Azure Automation.

---

# PART B — AZURE AUTOMATION

# 5. Create or Open the Automation Account

Go to the Azure Portal.

Search:

```text
Automation Accounts
```

If you already have an Automation Account, open it.

Otherwise create one.

Example:

```text
Name:
IT-Automation-Account
```

Choose your subscription, resource group, and region.

---

# 6. Understand the Automation Account

Your Automation Account will contain resources such as:

```text
Automation Account
|
+-- Identity
|
+-- Runbooks
|
+-- Schedules
|
+-- Shared Resources
      |
      +-- Variables
```

Think of the Automation Account as a cloud-based automation server that can run your PowerShell code without your computer being turned on.

---

# 7. Enable System-Assigned Managed Identity

Open:

```text
Automation Account
    ↓
Account Settings
    ↓
Identity
```

Find:

```text
System assigned
```

Turn it:

```text
On
```

Click:

```text
Save
```

Azure creates an identity for the Automation Account.

You should see an Object ID/Principal ID.

The relationship is:

```text
Azure Automation Account
        ↓
System-Assigned Managed Identity
        ↓
Microsoft Entra ID
```

The identity allows Azure to recognize the Automation Account when it accesses supported Azure resources.

---

# 8. Create the Teams Webhook Automation Variable

Go to:

```text
Automation Account
    ↓
Shared Resources
    ↓
Variables
```

Click:

```text
+ Add a variable
```

Create:

```text
Name:
TeamsWebhookUrl
```

For the value, paste the Teams Workflow webhook URL.

If the portal gives you an encryption option for the variable, enable it.

Save it.

You should now have:

```text
Shared Resources
    ↓
Variables
    ↓
TeamsWebhookUrl
```

---

# 9. Understand Get-AutomationVariable

This is similar to the Uptime Robot API key example.

For example:

```powershell
$UptimeRobotApiKey = Get-AutomationVariable -Name "UptimeRobotApiKey"
```

For this project:

```powershell
$TeamsWebhookUrl = Get-AutomationVariable -Name "TeamsWebhookUrl"
```

Azure Automation retrieves the stored value and places it into:

```text
$TeamsWebhookUrl
```

The script can then use that value.

Do not print the webhook URL into the Automation job output.

---

# PART C — CREATE THE RUNBOOK

# 10. Create the PowerShell Runbook

Go to:

```text
Automation Account
    ↓
Process Automation
    ↓
Runbooks
```

Click:

```text
Create a runbook
```

Use:

```text
Name:
Send-Teams-Patch-Notification

Runbook type:
PowerShell
```

Create the runbook.

---

# 11. Test Managed Identity First

Do not build the complete script immediately.

First verify Managed Identity.

Put this into the runbook:

```powershell
Disable-AzContextAutosave -Scope Process

try {
    Write-Output "Connecting to Azure using Managed Identity..."

    $AzureContext = (Connect-AzAccount -Identity).Context

    Write-Output "Managed Identity authentication successful."
    Write-Output "Subscription: $($AzureContext.Subscription)"
}
catch {
    Write-Error "Managed Identity authentication failed."
    throw
}
```

Save it.

Open:

```text
Test pane
```

Run it.

Expected output:

```text
Connecting to Azure using Managed Identity...
Managed Identity authentication successful.
Subscription: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

If this works, your Automation Account Managed Identity is working.

---

# 12. Test the Automation Variable

Replace the test code with:

```powershell
$TeamsWebhookUrl = Get-AutomationVariable -Name "TeamsWebhookUrl"

if ([string]::IsNullOrWhiteSpace($TeamsWebhookUrl)) {
    throw "TeamsWebhookUrl variable was not found or is empty."
}

Write-Output "Teams webhook variable retrieved successfully."
```

Run the test.

Expected:

```text
Teams webhook variable retrieved successfully.
```

Do NOT do:

```powershell
Write-Output $TeamsWebhookUrl
```

because that could expose the webhook in the job logs.

---

# PART D — TEST TEAMS

# 13. Send a Test Message

Now test the Teams integration.

Use:

```powershell
$TeamsWebhookUrl = Get-AutomationVariable -Name "TeamsWebhookUrl"

if ([string]::IsNullOrWhiteSpace($TeamsWebhookUrl)) {
    throw "TeamsWebhookUrl variable was not found or is empty."
}

$Body = @{
    text = "Test message from Azure Automation."
} | ConvertTo-Json

try {

    Invoke-RestMethod `
        -Uri $TeamsWebhookUrl `
        -Method Post `
        -ContentType "application/json" `
        -Body $Body

    Write-Output "Teams notification sent successfully."

}
catch {

    Write-Error "Failed to send Teams notification."
    Write-Error $_.Exception.Message
    throw
}
```

Save and run the test.

Open:

```text
Microsoft Teams
    ↓
IT Patch Notifications
```

You should see:

```text
Test message from Azure Automation.
```

If you see it, the Azure Automation → Teams integration works.

---

# PART E — BUILD THE PATCH LOGIC

# 14. Add the Notification Parameter

We want one runbook to handle both messages.

At the top of the runbook:

```powershell
param(
    [ValidateSet("Reminder", "Tonight")]
    [string]$NotificationType
)
```

The runbook can now receive either:

```text
Reminder
```

or:

```text
Tonight
```

Schedule 1 will use:

```text
Reminder
```

Schedule 2 will use:

```text
Tonight
```

This is better than maintaining two separate scripts.

---

# 15. Calculate Patch Tuesday Automatically

We do not want to manually type dates.

PowerShell will calculate the second Tuesday automatically.

The logic is:

```text
Current month
      ↓
First day of month
      ↓
Find first Tuesday
      ↓
Add 7 days
      ↓
Second Tuesday
      ↓
Add 2 days
      ↓
Patch Thursday
```

Example:

```text
November 2026

November 3
    ↓
First Tuesday

November 10
    ↓
Second Tuesday / Patch Tuesday

November 12
    ↓
Two days later / Patch Night
```

---

# 16. Complete PowerShell Runbook

After the individual tests work, use this as the main runbook:

```powershell
param(
    [ValidateSet("Reminder", "Tonight")]
    [string]$NotificationType
)

# ==========================================
# 1. Retrieve Teams webhook from Automation
# ==========================================

$TeamsWebhookUrl = Get-AutomationVariable -Name "TeamsWebhookUrl"

if ([string]::IsNullOrWhiteSpace($TeamsWebhookUrl)) {
    throw "TeamsWebhookUrl variable was not found or is empty."
}

# ==========================================
# 2. Get today's date
# ==========================================

$Today = Get-Date

# ==========================================
# 3. Find the first day of the month
# ==========================================

$FirstDayOfMonth = Get-Date `
    -Year $Today.Year `
    -Month $Today.Month `
    -Day 1

# ==========================================
# 4. Find the first Tuesday
# ==========================================

$DaysUntilTuesday = (
    [DayOfWeek]::Tuesday - $FirstDayOfMonth.DayOfWeek + 7
) % 7

$FirstTuesday = $FirstDayOfMonth.AddDays($DaysUntilTuesday)

# ==========================================
# 5. Find the second Tuesday
# ==========================================

$PatchTuesday = $FirstTuesday.AddDays(7)

# ==========================================
# 6. Patch occurs two days later
# ==========================================

$PatchThursday = $PatchTuesday.AddDays(2)

# ==========================================
# 7. Create the Teams message
# ==========================================

$PatchDate = $PatchThursday.ToString("MMMM d, yyyy")

if ($NotificationType -eq "Reminder") {

    $Message = "We are going to have the monthly patch that reboots servers in 2 days, $PatchDate. Let the IT team know if there are any blockers."

}
elseif ($NotificationType -eq "Tonight") {

    $Message = "We are going to have the monthly patch that reboots servers tonight, $PatchDate. Let the IT team know if there are any blockers."

}
else {

    throw "Invalid NotificationType."

}

# ==========================================
# 8. Convert message to JSON
# ==========================================

$Body = @{
    text = $Message
} | ConvertTo-Json

# ==========================================
# 9. Send message to Microsoft Teams
# ==========================================

try {

    Invoke-RestMethod `
        -Uri $TeamsWebhookUrl `
        -Method Post `
        -ContentType "application/json" `
        -Body $Body

    Write-Output "Teams notification sent successfully."
    Write-Output "Notification type: $NotificationType"
    Write-Output "Patch date: $PatchDate"

}
catch {

    Write-Error "Failed to send Teams notification."
    Write-Error $_.Exception.Message

    throw
}
```

---

# PART F — TEST THE TWO NOTIFICATIONS

# 17. Test Notification 1

Open:

```text
Runbook
    ↓
Test pane
```

Enter:

```text
NotificationType:
Reminder
```

Run it.

Expected Teams message:

```text
We are going to have the monthly patch that reboots
servers in 2 days, [DATE].
Let the IT team know if there are any blockers.
```

---

# 18. Test Notification 2

Run the test again.

Enter:

```text
NotificationType:
Tonight
```

Expected:

```text
We are going to have the monthly patch that reboots
servers tonight, [DATE].
Let the IT team know if there are any blockers.
```

---

# PART G — CREATE THE SCHEDULES

# 19. Schedule 1 — Patch Tuesday Reminder

Go to:

```text
Automation Account
    ↓
Shared Resources
    ↓
Schedules
```

Click:

```text
Add a schedule
```

Create:

```text
Name:
Patch-Tuesday-Reminder
```

Set:

```text
Frequency:
Monthly

Day:
Second Tuesday

Time:
1:00 PM

Time zone:
Pacific Time
```

Set the start date to the next month.

Link the schedule to:

```text
Send-Teams-Patch-Notification
```

Set the runbook parameter:

```text
NotificationType = Reminder
```

Save.

---

# 20. Schedule 2 — Patch Night Reminder

Create another schedule:

```text
Name:
Patch-Night-Reminder
```

Set:

```text
Frequency:
Monthly

Day:
Second Thursday

Time:
1:00 PM

Time zone:
Pacific Time
```

Link it to:

```text
Send-Teams-Patch-Notification
```

Set:

```text
NotificationType = Tonight
```

Save.

---

# 21. Why use one runbook and two schedules?

The schedules determine **when** the script runs.

The parameter determines **what message** it sends.

```text
Schedule 1
Second Tuesday
       ↓
Reminder
       ↓
Same Runbook
```

```text
Schedule 2
Second Thursday
       ↓
Tonight
       ↓
Same Runbook
```

This is cleaner than maintaining two copies of the PowerShell script.

---

# PART H — FINAL TEST

# 22. Test Every Component

## Microsoft Teams

- [ ] Teams channel created
- [ ] Teams Workflow created
- [ ] Webhook URL obtained

## Azure Automation

- [ ] Automation Account exists
- [ ] System-Assigned Managed Identity enabled
- [ ] `TeamsWebhookUrl` variable created
- [ ] PowerShell runbook created

## Authentication

- [ ] `Connect-AzAccount -Identity` works
- [ ] Managed Identity authentication confirmed

## Variable

- [ ] `Get-AutomationVariable` works
- [ ] Webhook is not printed in logs

## Teams

- [ ] Test message reaches Teams
- [ ] Reminder message works
- [ ] Tonight message works

## Scheduling

- [ ] Second Tuesday schedule created
- [ ] Second Thursday schedule created
- [ ] Both use 1:00 PM Pacific Time
- [ ] Correct runbook parameters configured
- [ ] Both schedules enabled

---

# PART I — TROUBLESHOOTING

## Teams message doesn't appear

Check:

1. Teams Workflow is enabled.
2. Webhook URL is correct.
3. Automation Variable is named exactly `TeamsWebhookUrl`.
4. Runbook successfully retrieves the variable.
5. Workflow points to the correct Team/channel.

## Automation Variable not found

Check:

```powershell
Get-AutomationVariable -Name "TeamsWebhookUrl"
```

Make sure the name matches exactly.

## Managed Identity authentication fails

Check:

1. Automation Account identity is enabled.
2. System-assigned identity is On.
3. Runbook is running in Azure Automation.
4. Required Az modules are available.

Test:

```powershell
Connect-AzAccount -Identity
```

## HTTP 400

Usually means the request/payload is invalid.

Check the JSON structure:

```json
{
  "text": "Your message"
}
```

## HTTP 401/403

Check:

- Webhook URL
- Teams Workflow
- Workflow configuration
- Whether the webhook/workflow is still active

## Wrong schedule time

Check the schedule's timezone.

It should be:

```text
Pacific Time
```

Do not assume your local Eastern Time setting is the same as Pacific Time.

---

# PART J — HOW TO EXPLAIN THE PROJECT IN AN INTERVIEW

## 30-second explanation

> I built a PowerShell-based automation solution in Azure Automation to automate monthly server patch notifications in Microsoft Teams. I enabled a system-assigned managed identity for the Automation Account, stored the Teams webhook URL as an Automation Variable, and created a runbook that dynamically calculates Patch Tuesday and the patch date two days later. I then configured two recurring schedules to send the appropriate notification to a dedicated Teams channel.

## Resume bullet

> Developed a PowerShell-based Azure Automation solution using System-Assigned Managed Identity, Automation Variables, Teams webhooks, and scheduled runbooks to automate monthly server patch notifications.

## Skills demonstrated

```text
Azure Automation
PowerShell
Microsoft Entra ID
Managed Identity
Azure Automation Variables
Microsoft Teams
Teams Workflows
Webhooks
HTTP/REST
JSON
Automation Scheduling
Patch Management
Cloud Automation
Error Handling
IT Operations
```

---

# FINAL PROJECT FLOW

```text
                    AZURE AUTOMATION
                           |
             +-------------+-------------+
             |                           |
             v                           v
      Schedule 1                    Schedule 2
      2nd Tuesday                  2nd Thursday
      1 PM Pacific                 1 PM Pacific
             |                           |
             | Reminder                  | Tonight
             +-------------+-------------+
                           |
                           v
                  PowerShell Runbook
                           |
                           v
              Get-AutomationVariable
                           |
                           v
                   TeamsWebhookUrl
                           |
                           v
                     HTTP POST
                           |
                           v
                   Teams Workflow
                           |
                           v
              IT Patch Notifications
                           |
                           v
                       IT TEAM
```

# The Five Things to Remember

**Azure Automation** = runs the script.

**Managed Identity** = gives the Automation Account an Azure identity.

**Automation Variable** = stores the Teams webhook URL.

**PowerShell Runbook** = performs the automation.

**Teams Workflow** = receives the webhook and posts the message.

---

# Recommended Build Order

Do NOT try to build everything at once.

Complete the project in this exact order:

1. Create Teams channel
2. Create Teams Workflow
3. Get webhook URL
4. Create Azure Automation Account
5. Enable Managed Identity
6. Create `TeamsWebhookUrl` Automation Variable
7. Create PowerShell Runbook
8. Test Managed Identity
9. Test Automation Variable
10. Test Teams webhook
11. Add Patch Tuesday date calculation
12. Add notification parameter
13. Test Reminder
14. Test Tonight
15. Create Patch Tuesday schedule
16. Create Patch Night schedule
17. Check job history
18. Confirm both schedules are enabled

**Do not move to the next step until the current step works.**
