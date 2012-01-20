<?xml version="1.0"?>
<s:schema xmlns:s="http://www.ascc.net/xml/schematron" xmlns:rng="http://relaxng.org/ns/structure/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"><s:title>Schematron rules for TEI</s:title><s:ns xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.tei-c.org/ns/1.0" prefix="tei" uri="http://www.tei-c.org/ns/1.0"/><s:ns xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.tei-c.org/ns/1.0" prefix="rng" uri="http://relaxng.org/ns/structure/1.0"/><s:pattern xmlns="http://www.tei-c.org/ns/1.0" name="spanTo_required">
      <s:rule context="tei:addSpan">
        <s:assert test="@spanTo">The spanTo= attribute of <s:name/> is required.</s:assert>
      </s:rule>
    </s:pattern><s:pattern xmlns="http://www.tei-c.org/ns/1.0" name="spanTo_required_for_damageSpan">
      <s:rule context="tei:damageSpan">
        <s:assert test="@spanTo">The spanTo= attribute of <s:name/> is required.</s:assert>
      </s:rule>
    </s:pattern><s:pattern xmlns="http://www.tei-c.org/ns/1.0" name="spanTo_required_for_delSpan">
      <s:rule context="tei:delSpan">
        <s:assert test="@spanTo">The spanTo= attribute of <s:name/> is required.</s:assert>
      </s:rule>
    </s:pattern><s:pattern xmlns="http://www.tei-c.org/ns/1.0" name="testschemapattern">
      <s:rule context="tei:moduleRef">
        <s:report test="* and @key">
	  child elements of moduleRef are only allowed when an external module
	  is being loaded
	</s:report>
      </s:rule>
    </s:pattern></s:schema>
