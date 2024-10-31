#Requires AutoHotkey v2.0

class input
{
    collectInput()
    {
        if (app.logic.gameIsRunning == true) && (StrLen(app.output.inputField.Value) == 5)
        {
            this.try(app.output.inputField.Value)
            app.output.inputField.Value := ""
        }

    }
    try(word)
    {
        wordIsValid := logic.validateWord(word)
        wordIsRepeated := app.logic.checkPlayHistory(word)
        actuallyPlay := app.logic.actuallyPlay(word)
        if wordIsValid || !wordIsRepeated || actuallyPlay == false
            return MsgBox(A_ThisFunc " error.")
        return true
    }
    start()
    {
        SetTimer(ObjBindMethod(this,"collectInput"),500)
    }
}