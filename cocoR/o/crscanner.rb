class CRScanner < AbsScanner

   def initialize(*_args_)                    # this method has been overriden with different number of parameters

      if _args_.size != 0
         return method("initialize_v#{_args_.size}").call(*_args_)
      end

      Buffer=nil
   end
   def SetIgnoreCase()
      IgnoreCase=1
   end
   def CurrentCh(pos)
      return @buffer[pos]
   end

   @buffer
   @comEols
   @buffPos
   @currCol
   @inputLen
   @currLine
   @lineStart
   @ch
   @ignoreCase






end
