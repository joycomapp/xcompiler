class AbsToken

   def uninitialize()

   end
   def GetSym()
      return @sym
   end
   def SetSym(sym)
      return @sym=sym
   end
   def GetPos()
      return @pos
   end
   def Init(sym = 0,line = 0,col = 0,pos = 0,len = 0)
      @sym=sym
      @line=line
      @col=col
      @pos=pos
      @len=len
   end

   @sym
   @line
   @col
   @len
   @pos







end
