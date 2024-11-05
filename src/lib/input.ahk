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
            if (app.logic.gameIsRunning == true)
            {
                if (StrLen(wordTried) == 5)
                {
                    sendTry := this.try(wordTried)
                    if sendTry == true
                    {
                        wordTried := ""
                        return true
                    } else
                    {
                        MsgBox("word: " wordTried " returned error: " sendTry)
                        wordTried := ""
                        return false
                    }
                }
            } else
            {
                MsgBox("Game is not running.")
                return false
            }
        }
    }
    try(word)
    {
        wordIsValid := logic.validateWord(word)
        wordIsNew := app.logic.checkPlayHistory(word)
        if (wordIsValid & wordIsNew == false)
            {
                Mistake := wordIsValid . wordIsNew
                MsgBox(A_ThisFunc . " error " . Mistake)
                return false
            } else actuallyPlay := app.logic.actuallyPlay(word)
        if (actuallyPlay == false)
        {
            Mistake := wordIsValid . wordIsNew . actuallyPlay
            MsgBox(A_ThisFunc . " error " . Mistake)
            return false
        }
        MsgBox(A_ThisFunc . " succeded " . wordIsValid . wordIsNew . actuallyPlay,,"t0.5")
        return true
    }
    start()
    {
        SetTimer(ObjBindMethod(this,"collectInput"),500)
    }
}