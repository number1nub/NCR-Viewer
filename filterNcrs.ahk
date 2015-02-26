FilterNcrs(criteria*)
{
	if (!criteria || criteria1 = "*")
		return ncrs
	filters:=[], tmp:=[]
	for c, v in criteria
	{
		if IsObject(v)
			filters.Insert({ att: v.attrib, crit: v.crit })
		else
		{
			if (!Mod(c,2))
				filters.Insert({ att: prev, crit: v })
			else
				prev := v
		}
	}
	for id, ncr in ncrs
	{
		for c, filt in filters
		{
			if (ncr[filt.att] = filt.crit)
				if (c = filters.MaxIndex())
					tmp.Insert(id, ncr)
		}
	}
	return tmp
}