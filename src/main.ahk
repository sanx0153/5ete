#Requires AutoHotkey v2.0

#Include lib\include.ahk

app := main()

class main
{
    static instance := ""

    __New()
    {
        ;Makes this single instance, returning instance in case of retry creation
        if !main.instance
        {
            main.instance := this
            this.input    := input()
            this.logic    := logic()
            this.output   := output()
        }
        return main.instance
    }
    
}