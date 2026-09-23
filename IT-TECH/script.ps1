<#
.SYNOPSIS
    AD User Account Unlock & Password Reset Tool
.DESCRIPTION
    Prompts for a username, checks if the account is locked,
    unlocks if necessary, resets password to a default,
    and forces a password change on next logon.
.REQUIREMENTS
    Run in PowerShell with RSAT Active Directory module installed.
    Requires AD permissions to reset passwords/unlock accounts.
#>

Import-Module ActiveDirectory

# Prompt for username
$username = Read-Host "Enter the AD username"

Write-Host "The username you entered is: $username"

# Default password (you can change this as needed)
$defaultPassword = "Welcome@123"

try {
    # Get user object
    $user = Get-ADUser -Identity $username -Properties LockedOut, Enabled&

    if (-not $user) {
        Write-Host "❌ User '$username' not found in Active Directory." -ForegroundColor Red
        exit
    }

    Write-Host "✅ Found user: $username" -ForegroundColor Green

    # Check lockout status
    if ($user.LockedOut -eq $true) {
        Write-Host "🔒 Account is locked. Unlocking now..." -ForegroundColor Yellow
        Unlock-ADAccount -Identity $username
        Write-Host "✅ Account unlocked." -ForegroundColor Green
    }
    else {
        Write-Host "ℹ Account is not locked." -ForegroundColor Cyan
    }

    # Reset password
    Write-Host "🔄 Resetting password to default..." -ForegroundColor Yellow
    Set-ADAccountPassword -Identity $username -NewPassword (ConvertTo-SecureString $defaultPassword -AsPlainText -Force) -Reset

    # Force password change at next logon
    Set-ADUser -Identity $username -ChangePasswordAtLogon $true

    Write-Host "✅ Password reset to '$defaultPassword' and user will be prompted to change it at next logon." -ForegroundColor Green

} catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
}
