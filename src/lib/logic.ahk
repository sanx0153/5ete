#Requires AutoHotkey v2.0

class logic
{
    static validWords := this.wordList()
    static promptNewGame(*)
    {
        app.logic.promptNewGame()
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
        this.setEmptyRound()
    }
    actuallyPlay(word)
    {
        this.history.%this.round% := logic.word(word)
        this.round += 1
        return true
    }
    checkPlayHistory(word) ;returns true if the word has not been played, false if it's found on play history
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
    promptNewGame()
    {
        if this.gameIsRunning == true
        {
            isUserSure := MsgBox("Jogada em andamento aplicar rotina de escape daqui",,"0x8234")
            if isUserSure == "Yes"
                return this.setNewGame()
            else return false
        } else this.setNewGame()
    }
    setEmptyRound()
    {
        this.history :=
        {
            1: logic.word(),
            2: logic.word(),
            3: logic.word(),
            4: logic.word(),
            5: logic.word(),
            6: logic.word(),
            7: logic.word(),
        }
        this.round := 0
    }
    setNewGame()
    {
        this.setEmptyRound()
        this.round += 1
        return true
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
        __New(theword := "?????")
        {
            this.setWord(theword)
        }
        setWord(theword)
        {
            if !(StrLen(theword) == 5)
            {
                MsgBox(A_ThisFunc " expects a 5 letter word")
                return false
            }
            this.value := theword
            this.letter := StrSplit(theword)
            return true
        }
        __call()
        {
            return this.value 
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