state("Meatgrinder") { }

startup
{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
	vars.Helper.GameName = "MEATGRINDER";
	vars.Helper.AlertLoadless();
}

init
{
	vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
	{
        vars.Helper["isLoading"] = mono.Make<bool>("SceneLoaderManager", "_instance", "isLoading");
		return true;
	});
}

onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading;
}