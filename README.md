# WakeToRun_Removal
A clean, invisible and easy-to-use script that periodically disables the "Wake To Run" property for scheduled tasks. This script requires [PsExec](https://docs.microsoft.com/en-us/sysinternals/downloads/psexec).

___

## Rationale

For some context: I regularly put my computer to sleep overnight, as opposed to shutting it off, since being able to pick up exactly where I left off the next morning is convenient. My computer is always air-gapped when it is sleeping. However, this doesn't stop Windows 10 from waking up my computer to perform tasks such as `\Microsoft\Windows\UpdateOrchestrator\Schedule Scan` and `\Microsoft\Windows\UpdateOrchestrator\Universal Orchestrator Start`, which are pointless since my computer is air-gapped and cannot update. So, just disable the "Wake To Run" setting for the offending tasks, right?

Unfortunately, Microsoft doesn't want users to get an uninterrupted night's sleep. To disable this "Wake To Run" setting, `SYSTEM` privileges are required. Administrator privileges just don't cut it. In addition, Microsoft regularly re-enables this setting for all of its internal tasks, meaning that users must, in turn, regularly disable it. As per a [suggestion](https://superuser.com/questions/958109/how-to-prevent-windows-10-waking-from-sleep-when-traveling-in-bag/959983#959983) on Superuser, I tried achieving this with a repeating task run under `SYSTEM` authority, but repeating tasks become unreliable if they are subjected to a computer's sleep state. Which kinda defeats the purpose, really.

___

## Usage

Now to get to this script: it's meant to be invisible to the user, and be extremely easy to activate. Running `launcher.vbs` as administrator will launch an invisible PowerShell script, which will disable the "Wake To Run" setting for all problematic tasks every 10 seconds. This script can run through sleep stages without any issues. Since the script is specifically designed to be invisible and unending, cancelling it is less trivial: kill `PSEXESVC.exe` and all of its descendants.

Make sure you place the PsExec executable in the same folder as `launcher.vbs` and `disable_waketorun_tasks.ps1`!
