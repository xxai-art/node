> @w5/binmap > BinMap
  @w5/write
  fs > existsSync readFileSync

< (fp)=>
  # 每次都重建，这样可以淘汰不存在的key
  m = new BinMap
  if existsSync fp
    prem = BinMap.load readFileSync cache_fp
  else
    prem = m

  [
    (k)=> # get
      if prem.has(k)
        v = prem.get k
        m.set k,v
        return v
      return


    (k,v)=> # set
      m.set k,v
      return

    => #save
      write(
        fp
        m.dump()
      )
      return
  ]

