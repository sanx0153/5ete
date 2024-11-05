#Requires AutoHotkey v2.0

class output
{
    __New()
    {
        global outputinstance := this
        ;global TILE_SIZE := 60
        this.Gui := Gui("-Border -Caption -SysMenu")
        this.Gui.Show("w600 h600 Center")
        this.Gui.SetFont("s22 w1000")
        this.bg := this.Gui.AddPicture("x0 y0 w600 h600 Disabled","hbitmap:*" images.app_bg)
        isIconChanged := TraySetIcon("hbitmap:*" images.block("face"))
        this.inputField := this.Gui.AddEdit("vInputField Limit5 Uppercase x60 y490 w480 h60 Center -VScroll") ; CHECKPOINT > continue from here, stopped because of my glasses
        this.inputField.SetFont("s36 w1000")
        this.buttonNew := this.Gui.AddButton("h40 w90 x130 y+5 Center","NEW")
        this.buttonLeave := this.Gui.AddButton("h40 w90 x+180 Center","EXIT")
        this.panel := output.panel()
    }
    createBlock(index)
    {
        return output.block(this.makeControl("picture"),this.makeControl("text"),index)
    }
    createEvents()
    {
        ;REMEMBER HOW THE HELL I MADE THIS WORK ON THE OTHER, THIS IS SO ANNOYING.
        ;UPDATE: DID IT AND IT SEEMS SO WRONG ACCORDING TO DOCUMENTATION...
        ;JUST A MEMENTO: THE TARGET MUST BE ABLE TO RECEIVE PARAMS IN ORDER FOR THIS SOLUTION TO WORK, AND I REALLY MEAN JUST ACCEPT (solved by making logic.promptNewGame() become logic.promptNewGame(*) AND SO ON, TESTED THE OTHER WAY AROUND AND IT RETURNS TOO MANY ARGUMENTS ERROR.)
        ;TRY TO FIGURE OUT WHY, IF IT'S ME MISUNDERSTANDING STUFF OR JUST A CATCH FROM AHK2
        ;nested ObjBindMethods don't work either, Copilot agrees that it should be the way according to doc
        ;figuring if this is my error or error at either doc or even the language might be useful either case.
        this.buttonNew.OnEvent("Click",logic.promptNewGame.Bind())
        this.buttonLeave.OnEvent("Click",logic.leaveGame.Bind())
    }

    makeControl(type)
    {
        control := this.Gui.Add(type)
        return control
    }
    start()
    {
        this.createEvents()
    }
    updateLine(N)
    {
        this.panel.updateLine(N)
    }
    class block
    {
        __New(pictureControl,textControl,index)
        {
            this.shineStatus := false
            this.index := index
            this.column := To.Column(index)
            this.line := To.Line(index)
            this.control := {}
            this.control.picture := pictureControl
            this.control.text := textControl
            this.control.picture.opt("w60 h60")
            this.control.text.opt("Center BackgroundTrans w60 h60")
            ;Sets placeholders
            this.control.picture.Value := "HBITMAP:*" images.block("red")
            ;this.updateText()
            this.control.text.SetFont("s40 w500")
            this.setPosition(700,700)
            ;this.getIntoPlace()
            this.setSkin("orange")
            this.hide()
            ;SetTimer(ObjBindMethod(this,"colorTest"),Random(1,10) * (-100))
        }
        colorTest()
        {
            for color, code in images.blockTable.OwnProps()
            {
                this.setSkin(color)
                Sleep((Random(2,6) * (100)))
            }
            SetTimer(ObjBindMethod(this,"colorTest"),-50)
        }
        getIntoPlace()
        {
            this.setPosition((To.Column(this.index) * 90),(to.line(this.index) * 61))
        }
        hide()
        {
            this.setPosition(700,700)
        }
        isShining
        {
            set
            {
                this.shineStatus := value
            }
            get
            {
                return this.shineStatus
            }
        }
        setPosition(x,y)
        {
            this.control.picture.Move(x,y,60,60)
            this.control.text.Move(x,y,60,60)
            this.x := x
            this.y := y
            this.redraw()
        }
        setSkin(color)
        {
            if StrLower(color) == "orange"||"yellow"
                this.control.text.SetFont("cBlack")
            else
                this.control.text.SetFont("c808080")
            this.control.picture.Value := "HBITMAP:*" images.block(color)
            this.redraw()
        }
        setText(text)
        {
            if StrLen(text) > 1
                return MsgBox(text "is too long, should be a single chr")
            this.control.text.Value := StrUpper(text)
        }
        shine()
        {
            if this.isShining == true
            {
                this.isShining := false
                baseTime := (Random(2,3) * Random(5,10) * 100)
                SetTimer(ObjBindMethod(this,"setSkin","blue"),-(baseTime))
                SetTimer(ObjBindMethod(this,"setSkin","orange"),-(baseTime + 100))
            }
        }
        show()
        {
            this.getIntoPlace()
        }
        redraw()
        {
            this.control.picture.redraw()
            this.control.text.redraw()
        }
        update()
        {
            this.updateText()
            this.updateColor()
            this.show()
        }
        updateColor()
        {
            this.setSkin(app.logic.history.%this.line%.getColor(this.column))
        }
        updateText()
        {
            this.setText(app.logic.history.%this.line%.letter[this.column])
        }
    }
    class panel
    {
        __New()
        {
            this.blocks := []
            loop 35
            {
                this.blocks.Push(outputinstance.createBlock(A_Index))
            }
        }
        updateLine(N)
        {
            loop 5
            {
                this.blocks[to.Index(N,A_Index)].update()
            }
        }
        hide()
        {
            loop 35
            {
                this.blocks[A_Index].hide()
            }
        }
    }
}