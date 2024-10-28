#Requires AutoHotkey v2.0

class output
{
    __New()
    {
        ;global TILE_SIZE := 60
        this.Gui := Gui("-Border -Caption -SysMenu")
        this.Gui.Show("w600 h600 Center")
        this.Gui.SetFont("s22 w1000")
        this.bg := this.Gui.AddPicture("x0 y0 w600 h600 Disabled","hbitmap:*" images.app_bg)
        isIconChanged := TraySetIcon("hbitmap:*" images.face)
        this.buttonNew := this.Gui.AddButton("h60 w180 x360 y120 Center","NEW GAME")
        this.buttonLeave := this.Gui.AddButton("h60 w180 x360 y240 Center","EXIT")
        this.inputField := this.Gui.AddEdit("Limit5 Uppercase x60 y420 w480 h120 Center") ; CHECKPOINT > continue from here, stopped because of my glasses
        this.inputField.SetFont("bold s60 w1000")
        this.blockzero := output.block(this.makeControl("picture"),this.makeControl("text"))
    }
    createEvents()
    {
        ;REMEMBER HOW THE HELL I MADE THIS WORK ON THE OTHER, THIS IS SO ANNOYING.
        ;UPDATE: DID IT AND IT SEEMS SO WRONG ACCORDING TO DOCUMENTATION...
        ;JUST A MEMENTO: THE TARGET MUST BE ABLE TO RECEIVE PARAMS IN ORDER FOR THIS SOLUTION TO WORK, AND I REALLY MEAN JUST ACCEPT (solved by making logic.startNewGame() become logic.startNewGame(*) AND SO ON, TESTED THE OTHER WAY AROUND AND IT RETURNS TOO MANY ARGUMENTS ERROR.)
        ;TRY TO FIGURE OUT WHY, IF IT'S ME MISUNDERSTANDING STUFF OR JUST A CATCH FROM AHK2
        ;nested ObjBindMethods don't work either, Copilot agrees that it should be the way according to doc
        ;figuring if this is my error or error at either doc or even the language might be useful either case.
        this.buttonNew.OnEvent("Click",logic.startNewGame.Bind())
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
    class block
    {
        __New(pictureControl,textControl)
        {
            this.control := {}
            this.control.picture := pictureControl
            this.control.text := textControl
            this.control.picture.opt("w60 h60")
            this.control.text.opt("Center BackgroundTrans w60 h60")
            ;Sets placeholders
            this.control.picture.Value := "HBITMAP:*" images.blockRed
            this.control.text.Value := "?"
            this.control.text.SetFont("s40")
            this.setPosition(60,60)
            this.setSkin("orange")
        }
        setPosition(x,y)
        {
            this.control.picture.Move(x,y)
            this.control.text.Move(x,y,60,60)
            this.x := x
            this.y := y
            this.redraw()
        }
        setSkin(color)
        {
            this.control.text.SetFont("c808080")
            switch color
            {
            case "orange":
                this.control.picture.Value := "HBITMAP:*" images.blockOrange
                this.control.text.SetFont("cBlack")
            default:
                this.control.picture.Value := "HBITMAP:*" images.blockPink
            }
            this.redraw()
        }
        redraw()
        {
            this.control.picture.redraw()
            this.control.text.redraw()
        }
    }
}