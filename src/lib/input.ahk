#Requires AutoHotkey v2.0

class input
{
    collectInput()
    {
        wordTried := ""
        if (StrLen(app.output.inputField.Value) == 5)
        {
            wordTried := app.output.inputField.Value
            app.output.inputField.Value := ""
        }
        if (app.logic.gameIsRunning == true)
        {
            if (StrLen(wordTried) == 5)
            {
                sendTry := this.try(wordTried)
                return true
            }
        }
        return false
    }
    try(word)
    {
        wordIsValid := logic.validateWord(word)
        wordIsNew := app.logic.checkPlayHistory(word)
        actuallyPlay := app.logic.actuallyPlay(word)
        if (wordIsValid & wordIsNew & actuallyPlay == false)
        {
            MsgBox(A_ThisFunc . " error " . wordIsValid . wordIsNew . actuallyPlay)
            return false
        }
        MsgBox(A_ThisFunc . " succeded " . wordIsValid . wordIsNew . actuallyPlay)
        return true
    }
    start()
    {
        SetTimer(ObjBindMethod(this,"collectInput"),500)
    }
}