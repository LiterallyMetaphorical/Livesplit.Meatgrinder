state("Meatgrinder") { }

startup
{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
	vars.Helper.GameName = "MEATGRINDER";
    vars.Helper.LoadSceneManager = true;
	vars.Helper.AlertLoadless();

    settings.Add("ch1", false, "Split on worm enter (End of Chapter 1)");
    settings.Add("ch2_worm", false, "Split on worm exit");
}

init
{
	vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
	{
        vars.Helper["isLoading"] = mono.Make<bool>("SceneLoaderManager", "_instance", "isLoading");
		var SD = mono["SessionData", 1];
        var CD = mono["ChapterData"];
        vars.Helper["chapterId"] = SD.MakeString("_instance", SD["currentChapter"], CD["chapterID"]);
        return true;
	});
}

update
{
	current.activeScene = vars.Helper.Scenes.Active.Name ?? current.activeScene;
	current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? current.loadingScene;
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

start
{
    // starts on any level in chapter 1 unfortunately
    // disable the start setting if you don't want this functionality
    return old.activeScene == "1_MenuScreen" && current.activeScene == "Level_01_FuryRoad"; 
}

split
{
    if (settings["ch1"] && old.chapterId == "ch1" && current.chapterId == "ch2_worm")
        return true;

    if (settings["ch2_worm"] && old.chapterId == "ch2_worm" && current.chapterId == "ch2")
        return true;
}