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
        this.history.%this.round%.__New(word)
        app.output.updateLine(this.round)
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
            isUserSure := MsgBox("Isso vai encerrar a partida atual. Prosseguir?",,"0x8234")
            if isUserSure == "Yes"
                return this.setNewGame()
            else return false
        } else this.setNewGame()
    }
    setEmptyRound()
    {
        this.history :=
        {
            1: logic.PlayerWord(),
            2: logic.PlayerWord(),
            3: logic.PlayerWord(),
            4: logic.PlayerWord(),
            5: logic.PlayerWord(),
            6: logic.PlayerWord(),
            7: logic.PlayerWord()
        }
        this.round := 0

    }
    setNewGame()
    {
        app.output.panel.hide()
        this.setEmptyRound()
        this.sortNewAnswer()
        this.round += 1
        outputinstance.inputField.Focus()
        return true
    }
    sortNewAnswer()
    {
        this.answer := logic.word(logic.validWords.SortOne())
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
        }
        getLetter(N)
        {
            if N < 1 || N > 5
            {
                MsgBox("expected an integer 1~5")
                return false
            }
            return this.letter[N]
        }
    }
    class PlayerWord extends logic.word
    {
        __New(theWord?)
        {
            super.__New(theWord?)
            this.color := this.makeEmptyColorArray()
            if IsSet(theWord)
                this.compareAnswer()
        }
        compareAnswer()
        {
            theAnswer := app.logic.answer

            notgreen := ""
            loop theAnswer.letter.Length
            {
                if StrUpper(theAnswer.getLetter(A_Index)) == StrUpper(this.getLetter(A_Index))
                {
                    this.setColor("green",A_Index)
                } else
                {
                    notgreen .= StrUpper(theAnswer.getLetter(A_Index))
                }
            }
            loop theAnswer.letter.Length
            {
                if !(StrUpper(this.getColor(A_Index)) == StrUpper("green"))
                {
                    if (InStr(notgreen,this.getLetter(A_Index),0) == 0)
                    {
                        this.setColor("red",A_Index)
                    } else
                    {
                        this.setColor("yellow",A_Index)
                    }
                }
            }
        }
        makeEmptyColorArray()
        {
            answer := []
            loop 5 
            {
                answer.Push("orange")
            }
            return answer
        }
        setColor(color,index)
        {
            this.color[index] := color
        }
        getColor(N)
        {
            if N < 1 || N > 5
            {
                MsgBox("expected an integer 1~5")
                return false
            }
            return this.Color[N]
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
        SortOne()
        {
            sortedWord := this.list[Random(1,this.list.Length)]
            return sortedWord
        }
    }
}