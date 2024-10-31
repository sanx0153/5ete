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
    static validateWord(word) ;continue daqui!!!
    {
        for ,words in logic.validWords.OwnProps()
            if StrCompare(word,words,"Logical") == true
            {
                MsgBox("Palavra Válida.")
                return true
            }
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
    actuallyPlay(word)
    {
        this.history.%this.round% := logic.word(word)
        return true
    }
    checkPlayHistory(word)
    {
        for , words in this.history.OwnProps()
        {
            if !words
                return false
            if StrCompare(StrUpper(word),StrUpper(words.value),"Logical") == true
            {
                return true
            }
        }
        return false
    }
    startNewGame()
    {
        if !(this.round == 0)
            MsgBox("Jogada em andamento aplicar rotina de escape daqui")
        this.round += 1
    }
    class slot
    {
        __New(index,letter)
        {
            this.index := index
            this.value := letter
            this.color := unset
        }
    }
    class word
    {
        __New(theWord)
        {
            this.value := theWord
            this.slots := []
            loop 5
            {
                this.slots.Push(logic.slot(A_Index,SubStr(this.value,A_Index,1)))
            }
        }
    }
    class wordList
    {
        __New()
        {
            if FileExist("data/grimoire.csv")
                return FileRead("data/grimoire.csv","CP1252")
            lastWord := ""
            loop read "data/DELAS.csv", "data/grimoire.csv"
                {
                lineN := A_Index
                if lineN != 1
                {
                    wholeLine := A_LoopReadLine
                    loop parse A_LoopReadLine, "CSV"
                    {
                        columnN := A_Index
                        currentWord := A_LoopField
                        currentWordLenght := StrLen(currentWord) == 5 ? true : false
                        differentWords := !(StrCompare(lastWord,currentWord,"Logical")) ? true : false
                        if columnN == 1 && currentWordLenght == true && differentWords == true
                        {
                            ;MsgBox(currentWord,,"t1")
                            FileAppend(currentWord "`n")
                            lastWord := currentWord
                        }
                    }
                }
            }
            return FileRead("data/grimoire.csv","CP1252")
        }
    }
}