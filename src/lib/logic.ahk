#Requires AutoHotkey v2.0

class logic
{
    static validWords := logic.wordList()
    static startNewGame(*)
    {
        app.logic.startNewGame()
    }
    static leaveGame(*)
    {
        ExitApp()
    }
    static validateWord(word)
    {
        for words in logic.validWords
            if StrCompare(word,words,0) == true
                return true
        return false
    }

    gameIsRunning
    {
        get
        {
            if this.round == 0
                return false
            return true
        }
    }

    __New()
    {
        this.history :=
        {
            1: unset,
            2: unset,
            3: unset,
            4: unset,
            5: unset,
            6: unset,
            7: unset,
        }
        this.round := 0
    }
    startNewGame()
    {
        if !(this.round == 0)
            MsgBox("Jogada em andamento aplicar rotina de escape daqui")
        this.round += 1
    }
    class wordList
    {
        __New()
        {
            P
        }
    }
}