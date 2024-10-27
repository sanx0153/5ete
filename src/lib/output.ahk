#Requires AutoHotkey v2.0

class output
{
    __New()
    {
        ;global TILE_SIZE := 60
        this.Gui := Gui("AlwaysOnTop -Border -Caption -SysMenu")
        this.Gui.Show("w600 h600 Center")
        this.bg := this.Gui.AddPicture("w600 h600 Disabled","hbitmap:*" images.app_bg)
        isIconChanged := TraySetIcon("hbitmap:*" images.card)
    }
    
}
/*
class block extends Gui.Picture
{
    __New()
    {
        super.__New("w60 h60 Disabled","hbitmap:*" images.block)
    }
}
*/