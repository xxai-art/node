> @w5/binmap > BinMap
  @w5/write

< (fp)=>
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
      if m.size
        write(
          fp
          m.dump()
        )
      return
  ]

