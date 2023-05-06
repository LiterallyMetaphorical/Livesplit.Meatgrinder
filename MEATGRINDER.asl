state("Meatgrinder") { }

startup
{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
	vars.Helper.GameName = "Meatgrinder";
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

isLoading
{
    return current.isLoading;
}