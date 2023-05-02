state("Meatgrinder")
{
    bool loading : "UnityPlayer.dll", 0x01AB35E8, 0xD0, 0x8, 0xB8, 0x64, 0x8, 0x448;
}

startup
  {
	// Asks user to change to game time if LiveSplit is currently set to Real Time.
		if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | MEATGRINDER",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
}

update
{
	//DEBUG CODE 
	//print(modules.First().ModuleMemorySize.ToString());
	print(current.loading.ToString());
}

isLoading
{
    return current.loading;
}
