#Requires AutoHotkey v2.0
Yes := On  := true
No  := Off := false


class To
{
    static Column(index) ;translates index into column number
    {
        answer := ""
        column := ""
        column := (Mod((index - 1),5) + 1)
        answer := column
        return answer    
    }
    static Index(line,column) ;states index from line,column numbers
    {
        args := Map()
        args["line"] := ""
        args["column"] := ""
        args["line"] := line
        args["column"] := column
        for i, j in args
            if (j < 1) || (j > 7)
                return MsgBox(i " precisa ser 1, 2, 3, 4, 5, 6 ou 7 mas é:" j)
        answer := ""
        index := ""
        index := (column + ((line - 1) * 5))
        answer := Integer(index)
        return answer
    }
    static Line(index) ;translates index into line number
    {
        answer := ""
        line := ""
        line := (((index - 1) // 5) + 1)
        answer := line
        return answer
    }
}
/*
for ii in [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35]
    MsgBox(To.Column(ii),,"t1")

loop 7
    {
        lineN := A_Index
        loop 5
            {
                columnN := A_Index
                MsgBox(to.Index(lineN,columnN),,"t1")
            }
    }
*/