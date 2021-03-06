package com.powerdata.pse.csvmemdb;

public class PsrObject
{
	protected CsvMemoryStore _rep;
	/** order read from CSV file.  In general not a good idea to need this */
	private int _index;
	private String _id;

	public String getID() {return _id;}
	
	/** order read from CSV file.  In general not a good idea to need this */
	public int getIndex() {return _index;}
	
	public void configure(RecordReader rr)
	{
		_id = rr.getProperty("id");
		_index = rr.getCount();
	}
	
	protected StringBuilder reportString()
	{
		StringBuilder sb = new StringBuilder(getClass().getSimpleName());
		sb.append(": id=");
		sb.append(_id);
		return sb;
	}
	
	protected static Float processFloat(RecordReader rr, String prop)
	{
		String val = rr.getProperty(prop);
		return (val == null || val.isEmpty()) ? null : Float.valueOf(val);
	}
	protected static Integer processInteger(RecordReader rr, String prop)
	{
		String val = rr.getProperty(prop);
		return (val == null || val.isEmpty()) ? null : Float.valueOf(val).intValue();
	}
	protected static Boolean processBoolean(RecordReader rr, String prop)
	{
		String val = rr.getProperty(prop);
		Boolean rv = null;
		if (val != null && !val.isEmpty())
		{
			char f = Character.toLowerCase(val.charAt(0));
			rv = (f == 't' || f == 'y' || f == '1') ? Boolean.TRUE : Boolean.FALSE;
		}
		return rv;
	}
	@Override
	public int hashCode()
	{
		return _id.hashCode();
	}
	@Override
	public boolean equals(Object obj)
	{
		return _id.equals(((PsrObject)obj)._id);
	}
	
	
}
