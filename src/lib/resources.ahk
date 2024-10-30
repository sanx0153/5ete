#Requires AutoHotkey v2.0
ruler()
class ruler
{
    __New()
    {
    global TILEW := 60
    global TILEH := 60
    global WINW := 600
    global WINH := 600
    global TILESIZETAG := "w" TILEW " h" TILEH
    global WINSIZETAG := "w" WINW " h" WINH
    }
}
class images
{
    static app_bg := LoadPicture("img\bg_halloween.jpg",WINSIZETAG)
    static card := LoadPicture("img\king.png")
    static block(color)
    {
        table := images.blockTable
        for colors,code in table.OwnProps()
            if StrLower(color) == StrLower(colors)
                return LoadPicture("img\blocks_" code ".png",TILESIZETAG)
        return false
    }
    static blockTable :=
    {
        face  : "face",
        pink  : "001",
        red   : "002",
        orange: "003",
        yellow: "004",
        green : "005",
        blue  : "006",
        purple: "007",
    }
}