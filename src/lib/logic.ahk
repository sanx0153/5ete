#Requires AutoHotkey v2.0

class logic
{
    static validWords := this.wordList()
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
        for i,w in this.validWords.OwnProps()
        {
            loop w.Length 
            {
                if StrUpper(word) == StrUpper(w[A_Index])
                {
                    return true
                }
            }
            return false
        }
    }

    gameIsRunning
    {
        get
        {
            if this.round <= 0 || this.round >= 8
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
        this.round += 1
        return true
    }
    checkPlayHistory(word)
    {
        for order,words in this.history.OwnProps()
        {
            if !words
                return true
            if StrUpper(word) == StrUpper(words.value)
            {
                return false
            }
        }
        return true
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
            answer := []
            if !FileExist("data/grimoire.csv")
            {
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
            }
            if !(FileExist("data/wordlist.txt"))
            {
                loop read "data/grimoire.csv", "data/wordlist.txt"
                {
                    FileAppend(A_LoopReadLine "`n")
                }
            }
            loop read "data/wordlist.txt"
            {
                answer.Push(A_LoopReadLine)
            }
            this.list := answer
        }
        __call()
        {
            return this.list
        }
    }
}