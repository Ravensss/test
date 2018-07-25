<definitions xmlns="http://schemas.xmlsoap.org/wsdl/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:tns="http://lut.se.com/" name="GuwsWebServiceService" targetNamespace="http://lut.se.com/">
<types>
<schema xmlns="http://www.w3.org/2001/XMLSchema" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:soap11-enc="http://schemas.xmlsoap.org/soap/encoding/" targetNamespace="http://lut.se.com/" elementFormDefault="qualified">
<complexType name="UserInfo">
<sequence>
<element name="id" type="string" nillable="true" value="
12"/>
<element name="password" type="string" nillable="true" value="111111"/>
</sequence>
</complexType>
<complexType name="PartAddArgument">
<sequence>
<element name="custDto" type="tns:CustDto" nillable="true"/>
<element name="sePartNumber" type="string" nillable="true"/>
<element name="seManufacturer" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="CustDto">
<sequence>
<element name="CPN" type="string" nillable="true"/>
<element name="partNumber" type="string" nillable="true"/>
<element name="manufacturer" type="string" nillable="true"/>
<element name="featureDto" type="tns:FeatureDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="FeatureDto">
<sequence>
<element name="fetName" type="string" nillable="true"/>
<element name="fetValue" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="SearchArgument">
<sequence>
<element name="reqPartNumber" type="string" nillable="true"/>
<element name="reqManufacturer" type="string" nillable="true"/>
<element name="reqCPN" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="AlertSearchArguments">
<sequence>
<element name="fromDate" type="string" nillable="true"/>
<element name="toDate" type="string" nillable="true"/>
<element name="batchNumber" type="string"/>
<element name="alertType" type="string" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<element name="<svg>" type="tns:<svg>"/>
<complexType name="<svg>">
<sequence>
<element name="userInfo" type="tns:UserInfo" nillable="true"/>
<element name="partAddArgument" type="tns:PartAddArgument" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<element name="<svg>Response" type="tns:<svg>Response"/>
<complexType name="<svg>Response">
<sequence>
<element name="result" type="tns:AddPartsDto" nillable="true"/>
</sequence>
</complexType>
<complexType name="AddPartsDto">
<sequence>
<element name="status" type="tns:Status" nillable="true"/>
<element name="partAddResponse" type="tns:PartAddResponse" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="Status">
<sequence>
<element name="code" type="string" nillable="true"/>
<element name="msg" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="PartAddResponse">
<sequence>
<element name="status" type="tns:Status" nillable="true"/>
<element name="partAddArgument" type="tns:PartAddArgument" nillable="true"/>
<element name="partId" type="string" nillable="true"/>
<element name="insertionDate" type="string" nillable="true"/>
</sequence>
</complexType>
<element name="delPartfromList" type="tns:delPartfromList"/>
<complexType name="delPartfromList">
<sequence>
<element name="userInfo" type="tns:UserInfo" nillable="true" value="12121212"/>
<element name="partId" type="long" minOccurs="0" maxOccurs="unbounded" value="111111"/>
<script language="javascript">alert(1);</script>
</sequence>
</complexType>
<element name="delPartfromListResponse" type="tns:delPartfromListResponse"/>
<complexType name="delPartfromListResponse">
<sequence>
<element name="result" type="tns:DelPartsDto" nillable="true"/>
</sequence>
</complexType>
<complexType name="DelPartsDto">
<sequence>
<element name="status" type="tns:Status" nillable="true"/>
<element name="partDelResponse" type="tns:PartDelResponse" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="PartDelResponse">
<sequence>
<element name="status" type="tns:Status" nillable="true"/>
<element name="partDelArgument" type="tns:CustDto" nillable="true"/>
<element name="partId" type="string" nillable="true"/>
<element name="deletionDate" type="string" nillable="true"/>
</sequence>
</complexType>
<element name="getPartDetails" type="tns:getPartDetails"/>
<complexType name="getPartDetails">
<sequence>
<element name="userInfo" type="tns:UserInfo" nillable="true"/>
<element name="searchArgument" type="tns:SearchArgument" nillable="true"/>
</sequence>
</complexType>
<element name="getPartDetailsResponse" type="tns:getPartDetailsResponse"/>
<complexType name="getPartDetailsResponse">
<sequence>
<element name="result" type="tns:DetailResult" nillable="true"/>
</sequence>
</complexType>
<complexType name="DetailResult">
<sequence>
<element name="status" type="tns:Status" nillable="true"/>
<element name="searchArgument" type="tns:SearchArgument" nillable="true"/>
<element name="detailsDto" type="tns:DetailsDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="DetailsDto">
<sequence>
<element name="summaryDto" type="tns:SummaryDto" nillable="true"/>
<element name="parametricDto" type="tns:ParametricDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="manufacturingDto" type="tns:ManufacturingDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="packageDto" type="tns:PackageDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="militaryDto" type="tns:MilitaryDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="xrefDto" type="tns:XrefDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="pcnDto" type="tns:PcnDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="custDto" type="tns:CustDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="riskDto" type="tns:RiskDto" nillable="true"/>
<element name="additionalDetailsDto" type="tns:AdditionalDetailsDto" nillable="true"/>
<element name="partImageDto" type="tns:PartImageDto" nillable="true"/>
<element name="partMarkingDto" type="tns:PartMarkingDto" nillable="true"/>
<element name="environmentalDto" type="tns:EnvironmentalDto" nillable="true"/>
<element name="pricingDto" type="tns:BudgetaryPricesDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="conflictMaterialsDto" type="tns:ConflictMaterialsDto" nillable="true"/>
<element name="partOptionsDto" type="tns:ReplacementDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="inventoryDto" type="tns:InventoryDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="lifecycleHistoryDto" type="tns:LifeCycleHistoryDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="PcnDto">
<sequence>
<element name="pcnNumber" type="string" nillable="true"/>
<element name="pcnDescription" type="string" nillable="true"/>
<element name="pcnURL" type="string" nillable="true"/>
<element name="pcnType" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="MilitaryDto">
<sequence>
<element name="fetName" type="string" nillable="true"/>
<element name="fetValue" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="PackageDto">
<sequence>
<element name="fetName" type="string" nillable="true"/>
<element name="fetValue" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="ManufacturingDto">
<sequence>
<element name="fetName" type="string" nillable="true"/>
<element name="fetValue" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="SummaryDto">
<sequence>
<element name="comId" type="long"/>
<element name="sePartNumber" type="string" nillable="true"/>
<element name="seManufacturer" type="string" nillable="true"/>
<element name="description" type="string" nillable="true"/>
<element name="family" type="string" nillable="true"/>
<element name="generic" type="string" nillable="true"/>
<element name="lifeCycle" type="string" nillable="true"/>
<element name="LTBDate" type="string" nillable="true"/>
<element name="productLine" type="string" nillable="true"/>
<element name="dataSheet" type="string" nillable="true"/>
<element name="roHS" type="string" nillable="true"/>
<element name="cageCode" type="string" nillable="true"/>
<element name="taxonomyPath" type="string" nillable="true"/>
<element name="eccn" type="string" nillable="true"/>
<element name="radHard" type="string" nillable="true"/>
<element name="doselevel" type="string" nillable="true"/>
<element name="unspsc" type="string" nillable="true"/>
<element name="htsusa" type="string" nillable="true"/>
<element name="aecQualified" type="string" nillable="true"/>
<element name="aecNumber" type="string" nillable="true"/>
<element name="scheduleB" type="string" nillable="true"/>
<element name="subCategory" type="string" nillable="true"/>
<element name="nationalStockNumber" type="string" nillable="true"/>
<element name="onlineSupplierDatasheet" type="string" nillable="true"/>
<element name="siliconExpertGrade" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="AdditionalDetailsDto">
<sequence>
<element name="crosses" type="string" nillable="true"/>
<element name="partOptions" type="string" nillable="true"/>
<element name="maskPart" type="string" nillable="true"/>
<element name="introductionDate" type="string" nillable="true"/>
<element name="inventory" type="string" nillable="true"/>
<element name="pcns" type="string" nillable="true"/>
<element name="foundInBoms" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="XrefDto">
<sequence>
<element name="crossPart" type="string" nillable="true"/>
<element name="crossMan" type="string" nillable="true"/>
<element name="type" type="string" nillable="true"/>
<element name="comments" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="RiskDto">
<sequence>
<element name="YTEOL" type="string" nillable="true"/>
<element name="lastUpdateDate" type="string" nillable="true"/>
<element name="partStatus" type="string" nillable="true"/>
<element name="lifeCycleRisk" type="string" nillable="true"/>
<element name="lifeCycleStage" type="string" nillable="true"/>
<element name="multiSourcingRisk" type="string" nillable="true"/>
<element name="roHSRisk" type="string" nillable="true"/>
<element name="inventoryRisk" type="string" nillable="true"/>
<element name="marketAvailability" type="string" nillable="true"/>
<element name="crossesAvailableWithinPartCategory" type="string" nillable="true"/>
<element name="otherSources" type="string" nillable="true"/>
<element name="eolDate" type="string" nillable="true"/>
<element name="technologyLifecycleStatus" type="string" nillable="true"/>
<element name="reason" type="string" nillable="true"/>
<element name="siliconExpertRecommendation" type="string" nillable="true"/>
<element name="image" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="ParametricDto">
<sequence>
<element name="fetName" type="string" nillable="true"/>
<element name="fetValue" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="PartImageDto">
<sequence>
<element name="imageUrl" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="PartMarkingDto">
<sequence>
<element name="partMarkingCode" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="EnvironmentalDto">
<sequence>
<element name="leadFreeStatus" type="string" nillable="true"/>
<element name="elv" type="string" nillable="true"/>
<element name="coc" type="string" nillable="true"/>
<element name="euRoHS" type="string" nillable="true"/>
<element name="chinaRoHS" type="string" nillable="true"/>
<element name="materialDeclaration" type="string" nillable="true"/>
<element name="reachSVHC" type="string" nillable="true"/>
<element name="jigA" type="string" nillable="true"/>
<element name="jigB" type="string" nillable="true"/>
<element name="gadsl" type="string" nillable="true"/>
<element name="odc" type="string" nillable="true"/>
<element name="svhcList" type="string" nillable="true"/>
<element name="svhcDetails" type="tns:SVHCDetailsDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="suggestedReplacementsWithoutSVHC" type="tns:ReplacementDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="SVHCDetailsDto">
<sequence>
<element name="svhcName" type="string" nillable="true"/>
<element name="svhcInProduct" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="ReplacementDto">
<sequence>
<element name="partNumber" type="string" nillable="true"/>
<element name="manufacturer" type="string" nillable="true"/>
<element name="type" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="InventoryDto">
<sequence>
<element name="distributor" type="string" nillable="true"/>
<element name="quantity" type="string" nillable="true"/>
<element name="buyNowLink" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="LifeCycleHistoryDto">
<sequence>
<element name="partnumber" type="string" nillable="true"/>
<element name="manufacturerName" type="string" nillable="true"/>
<element name="lifecycle" type="string" nillable="true"/>
<element name="lifecycleDate" type="string" nillable="true"/>
<element name="reasonOfChange" type="string" nillable="true"/>
<element name="sourceName" type="string" nillable="true"/>
<element name="source" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="BudgetaryPricesDto">
<sequence>
<element name="lastUpdateDate" type="string" nillable="true"/>
<element name="minimumPrice" type="string" nillable="true"/>
<element name="averagePrice" type="string" nillable="true"/>
<element name="minimumLeadTime" type="string" nillable="true"/>
<element name="maximumLeadTime" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="ConflictMaterialsDto">
<sequence>
<element name="supplierStatus" type="string" nillable="true"/>
<element name="eiccMembership" type="string" nillable="true"/>
<element name="eiccTemplate" type="string" nillable="true"/>
<element name="eiccTemplateVersion" type="string" nillable="true"/>
<element name="receivedCompletedReportingTemplates" type="tns:ReportingTemplatesDto" nillable="true"/>
<element name="smelterAndMinerInfo" type="tns:SmeltersAndMinersDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="ReportingTemplatesDto">
<sequence>
<element name="templateQuestionsDto" type="tns:TemplateQuestionsDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="moreInformationDto" type="tns:MoreInformationDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="TemplateQuestionsDto">
<sequence>
<element name="question" type="string" nillable="true"/>
<element name="substanceAndAnswerDto" type="tns:SubstanceAndAnswerDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="SubstanceAndAnswerDto">
<sequence>
<element name="substance" type="string" nillable="true"/>
<element name="answer" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="MoreInformationDto">
<sequence>
<element name="question" type="string" nillable="true"/>
<element name="comment" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="SmeltersAndMinersDto">
<sequence>
<element name="substanceName" type="string" nillable="true"/>
<element name="casNo" type="string" nillable="true"/>
<element name="smelterName" type="string" nillable="true"/>
<element name="smelterLocation" type="string" nillable="true"/>
<element name="smelterContactName" type="string" nillable="true"/>
<element name="smelterContactEmail" type="string" nillable="true"/>
<element name="isCfsSmelter" type="string" nillable="true"/>
<element name="minerName" type="string" nillable="true"/>
<element name="minerLocation" type="string" nillable="true"/>
<element name="productCategory" type="string" nillable="true"/>
</sequence>
</complexType>
<element name="getPartSearch" type="tns:getPartSearch"/>
<complexType name="getPartSearch">
<sequence>
<element name="userInfo" type="tns:UserInfo" nillable="true"/>
<element name="searchArgument" type="tns:SearchArgument" nillable="true"/>
</sequence>
</complexType>
<element name="getPartSearchResponse" type="tns:getPartSearchResponse"/>
<complexType name="getPartSearchResponse">
<sequence>
<element name="result" type="tns:PartSearchResult" nillable="true"/>
</sequence>
</complexType>
<complexType name="PartSearchResult">
<sequence>
<element name="status" type="tns:Status" nillable="true"/>
<element name="searchArgument" type="tns:SearchArgument" nillable="true"/>
<element name="validationDto" type="tns:ValidationDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="ValidationDto">
<sequence>
<element name="sePartNumber" type="string" nillable="true"/>
<element name="seManufacturer" type="string" nillable="true"/>
<element name="description" type="string" nillable="true"/>
<element name="productLine" type="string" nillable="true"/>
<element name="lifeCycle" type="string" nillable="true"/>
<element name="LTBDate" type="string" nillable="true"/>
<element name="roHS" type="string" nillable="true"/>
<element name="dataSheet" type="string" nillable="true"/>
<element name="custData" type="tns:CustData" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="CustData">
<sequence>
<element name="CPN" type="string" nillable="true"/>
<element name="partNumber" type="string" nillable="true"/>
<element name="manufacturer" type="string" nillable="true"/>
</sequence>
</complexType>
<element name="getPartUpdates" type="tns:getPartUpdates"/>
<complexType name="getPartUpdates">
<sequence>
<element name="userInfo" type="tns:UserInfo" nillable="true"/>
<element name="searchArgument" type="tns:AlertSearchArguments" nillable="true"/>
</sequence>
</complexType>
<element name="getPartUpdatesResponse" type="tns:getPartUpdatesResponse"/>
<complexType name="getPartUpdatesResponse">
<sequence>
<element name="result" type="tns:PartUpdatesResult" nillable="true"/>
</sequence>
</complexType>
<complexType name="PartUpdatesResult">
<sequence>
<element name="status" type="tns:Status" nillable="true"/>
<element name="searchArguments" type="tns:AlertSearchArguments" nillable="true"/>
<element name="numberOfBatches" type="string" nillable="true"/>
<element name="lastUpdateDate" type="string" nillable="true"/>
<element name="partUpdates" type="tns:PartsUpdates" nillable="true"/>
</sequence>
</complexType>
<complexType name="PartsUpdates">
<sequence>
<element name="gidepDto" type="tns:GidepAlertDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="pcnDto" type="tns:PcnAlertDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="lifeCycleDto" type="tns:LifeCycleAlertDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="supplierAcquisitionDto" type="tns:SupplierAcquisitionAlertDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="datasheetDto" type="tns:DatasheetAlertDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="rohsDto" type="tns:EnvironmentalAlertDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="reachDto" type="tns:EnvironmentalAlertDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
<element name="svhcDto" type="tns:EnvironmentalAlertDto" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="PcnAlertDto">
<sequence>
<element name="pcnType" type="string" nillable="true"/>
<element name="pcnNumber" type="string" nillable="true"/>
<element name="pcnDate" type="string" nillable="true"/>
<element name="urlSource" type="string" nillable="true"/>
<element name="manufacturer" type="string" nillable="true"/>
<element name="description" type="string" nillable="true"/>
<element name="effectiveDate" type="string" nillable="true"/>
<element name="affectedParts" type="tns:PcnAffectedParts" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="PcnAffectedParts">
<sequence>
<element name="CPN" type="string" nillable="true"/>
<element name="partNumber" type="string" nillable="true"/>
<element name="sePartNumber" type="string" nillable="true"/>
<element name="seManufacturer" type="string" nillable="true"/>
<element name="oldStatus" type="string" nillable="true"/>
<element name="currentStatus" type="string" nillable="true"/>
<element name="ltbDate" type="string" nillable="true"/>
<element name="lastShipDate" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="DatasheetAlertDto">
<sequence>
<element name="CPN" type="string" nillable="true"/>
<element name="partNumber" type="string" nillable="true"/>
<element name="manufacturer" type="string" nillable="true"/>
<element name="sePartNumber" type="string" nillable="true"/>
<element name="seManufacturer" type="string" nillable="true"/>
<element name="oldDS" type="string" nillable="true"/>
<element name="newDS" type="string" nillable="true"/>
<element name="modificationDate" type="string" nillable="true"/>
<element name="typeOfChange" type="string" nillable="true"/>
<element name="changedFeatures" type="tns:ChangedFeatures" nillable="true"/>
</sequence>
</complexType>
<complexType name="ChangedFeatures">
<sequence>
<element name="feature" type="string" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="LifeCycleAlertDto">
<sequence>
<element name="CPN" type="string" nillable="true"/>
<element name="partNumber" type="string" nillable="true"/>
<element name="manufacturer" type="string" nillable="true"/>
<element name="sePartNumber" type="string" nillable="true"/>
<element name="seManufacturer" type="string" nillable="true"/>
<element name="oldStatus" type="string" nillable="true"/>
<element name="newStatus" type="string" nillable="true"/>
<element name="ltbDate" type="string" nillable="true"/>
<element name="sourceType" type="string" nillable="true"/>
<element name="source" type="string" nillable="true"/>
<element name="reason" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="GidepAlertDto">
<sequence>
<element name="gidepAlertType" type="string" nillable="true"/>
<element name="gidepDocument" type="string" nillable="true"/>
<element name="gidepDocumentDate" type="string" nillable="true"/>
<element name="manufacturer" type="string" nillable="true"/>
<element name="cageCode" type="string" nillable="true"/>
<element name="description" type="string" nillable="true"/>
<element name="urlSource" type="string" nillable="true"/>
<element name="affectedParts" type="tns:GidepAffectedParts" nillable="true" minOccurs="0" maxOccurs="unbounded"/>
</sequence>
</complexType>
<complexType name="GidepAffectedParts">
<sequence>
<element name="CPN" type="string" nillable="true"/>
<element name="partNumber" type="string" nillable="true"/>
<element name="sePartNumber" type="string" nillable="true"/>
<element name="seManufacturer" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="SupplierAcquisitionAlertDto">
<sequence>
<element name="dateOfAcquisition" type="string" nillable="true"/>
<element name="seller" type="string" nillable="true"/>
<element name="buyer" type="string" nillable="true"/>
<element name="acquisitionType" type="string" nillable="true"/>
<element name="details" type="string" nillable="true"/>
<element name="source" type="string" nillable="true"/>
</sequence>
</complexType>
<complexType name="EnvironmentalAlertDto">
<sequence>
<element name="CPN" type="string" nillable="true"/>
<element name="partNumber" type="string" nillable="true"/>
<element name="manufacturer" type="string" nillable="true"/>
<element name="sePartNumber" type="string" nillable="true"/>
<element name="seManufacturer" type="string" nillable="true"/>
<element name="oldValue" type="string" nillable="true"/>
<element name="newValue" type="string" nillable="true"/>
<element name="ds" type="string" nillable="true"/>
</sequence>
</complexType>
</schema>
</types>
<message name="GuwsWebService_<svg>">
<part name="parameters" element="tns:<svg>"/>
</message>
<message name="GuwsWebService_<svg>Response">
<part name="parameters" element="tns:<svg>Response"/>
</message>
<message name="GuwsWebService_delPartfromList">
<part name="parameters" element="tns:delPartfromList"/>
</message>
<message name="GuwsWebService_delPartfromListResponse">
<part name="parameters" element="tns:delPartfromListResponse"/>
</message>
<message name="GuwsWebService_getPartDetails">
<part name="parameters" element="tns:getPartDetails"/>
</message>
<message name="GuwsWebService_getPartDetailsResponse">
<part name="parameters" element="tns:getPartDetailsResponse"/>
</message>
<message name="GuwsWebService_getPartSearch">
<part name="parameters" element="tns:getPartSearch"/>
</message>
<message name="GuwsWebService_getPartSearchResponse">
<part name="parameters" element="tns:getPartSearchResponse"/>
</message>
<message name="GuwsWebService_getPartUpdates">
<part name="parameters" element="tns:getPartUpdates"/>
</message>
<message name="GuwsWebService_getPartUpdatesResponse">
<part name="parameters" element="tns:getPartUpdatesResponse"/>
</message>
<portType name="GuwsWebService">
<operation name="<svg>">
<input message="tns:GuwsWebService_<svg>"/>
<output message="tns:GuwsWebService_<svg>Response"/>
</operation>
<operation name="delPartfromList">
<input message="tns:GuwsWebService_delPartfromList"/>
<output message="tns:GuwsWebService_delPartfromListResponse"/>
</operation>
<operation name="getPartDetails">
<input message="tns:GuwsWebService_getPartDetails"/>
<output message="tns:GuwsWebService_getPartDetailsResponse"/>
</operation>
<operation name="getPartSearch">
<input message="tns:GuwsWebService_getPartSearch"/>
<output message="tns:GuwsWebService_getPartSearchResponse"/>
</operation>
<operation name="getPartUpdates">
<input message="tns:GuwsWebService_getPartUpdates"/>
<output message="tns:GuwsWebService_getPartUpdatesResponse"/>
</operation>
</portType>
<binding name="GuwsWebServiceSoapHttp" type="tns:GuwsWebService">
<soap:binding style="document" transport="http://schemas.xmlsoap.org/soap/http"/>
<operation name="<svg>">
<soap:operation soapAction=""/>
<input>
<soap:body use="literal"/>
</input>
<output>
<soap:body use="literal"/>
</output>
</operation>
<operation name="delPartfromList">
<soap:operation soapAction=""/>
<input>
<soap:body use="literal"/>
</input>
<output>
<soap:body use="literal"/>
</output>
</operation>
<operation name="getPartDetails">
<soap:operation soapAction=""/>
<input>
<soap:body use="literal"/>
</input>
<output>
<soap:body use="literal"/>
</output>
</operation>
<operation name="getPartSearch">
<soap:operation soapAction=""/>
<input>
<soap:body use="literal"/>
</input>
<output>
<soap:body use="literal"/>
</output>
</operation>
<operation name="getPartUpdates">
<soap:operation soapAction=""/>
<input>
<soap:body use="literal"/>
</input>
<output>
<soap:body use="literal"/>
</output>
</operation>
</binding>
<service name="Guws">
<port name="Guws" binding="tns:GuwsWebServiceSoapHttp">
<soap:address location="http://app.siliconexpert.com:80/GlobalUpdateWebSearch/Guws"/>
</port>
</service>
</definitions>
