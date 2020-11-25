class CRDosScanner < CRScanner

   def initialize(*_args_)                    # this method has been overriden with different number of parameters

      ignoreCase = *_args_[0]

      if _args_.size != 1
         return method("initialize_v#{_args_.size}").call(*_args_)
      end

   end
   def CurrentCh(pos)
      return (@bufferVec[pos/BLKSIZE])[pos%BLKSIZE]
   end

   @bufferVec




end
