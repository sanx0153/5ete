#Requires AutoHotkey v2.0
#SingleInstance Force
#Include lib\include.ahk

app := main()

class main
{
    static instance := ""

    __New()
    {
        ;Makes this single instance, returning instance in case of retry creation
        if !(main.instance)
        {
            main.instance := this
            A_ScriptName := "5ete"
            A_FileEncoding := "CP1252"
            {
            this.input    := input()
            this.logic    := logic()
            this.output   := output()
            }
            SetTimer(ObjBindMethod(this,"start"),-100)
        }
        else return main.instance
    }
    start()
    {
        for target in this.OwnProps()
            {
                if this.%target%.HasMethod("start")
                {
                    this.%target%.start()
                }
            }
    }
}