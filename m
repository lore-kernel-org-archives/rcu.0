Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C22777F9;
	Thu, 25 Sep 2025 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790371; cv=fail; b=ifHasEV0K5LaE8nwiQB0coA/nou+7S0rSgl/CywfYUceILnL5rewMxie/8RpSz/QikIr6j0dRcHEaxJ79VIEM69QankRNyuAI2NSK1UifhNXUlz2drn5nlfNOjXQF6SBxiyJbODIVjfRE9+29U8p73aTuLMv5dJUNtjnEB3gb4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790371; c=relaxed/simple;
	bh=kMQ7L00Sed6AajhPixlmd4eSrKLyY8zzFkWqM2bLSTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KFF7z8gb7DZlLhAv5Nm+Tcop7tJUMtDLOr/SLwA2l9rjlp/6fHZnYFlAsEIgbjJ9nvdrKcrt6+6CPWJ1aJKUU5OnkK0ZVzY+csI4N750Cg9JrzQLYPbbZqP3d/wFyUjslB80y6fDevSGbkbg45VbsYhjDVYMQ1Ecsdwe961dScE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cWETsBtL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ogG7i6aA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cWETsBtL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ogG7i6aA"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P7tuxt007057;
	Thu, 25 Sep 2025 08:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NWwpbSbZ8cbMhTEI71ghFRQJJ4+3DIG7TH2noMh8A84=; b=
	cWETsBtLvKn0vu2VnI7/b5W+ERUOPP6bKuUpePPOcZWN8BcXUXK135cKpULTkIXi
	Tp0zRtM/ug4SLx20xYtOau8jJBWS83rCIiUvnFEPFDjQQgnHgqsLKpBtBlgPWoqm
	KjEYpeBWasT4FKF2rITUI07ATb0+iFOBjNvGpirbjZ4oggrqZHVROd0Y5sZR4gzn
	QiKaUdIyhjaIqfXKesNbi2IU7NVh2wZZpDjHvzBB8mnGDqJZxCQhAv6FyGQQUCD3
	2u44n1Vl1z1S81iPj0lw67zBU/Rk0r4MO+gehklQtUGdsCXD7NW9ckha6sU5nluc
	AZA9yP45YrIhH1k70IeOLQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k23hh2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 08:52:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58P8Imf6040797;
	Thu, 25 Sep 2025 08:52:22 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jqar7x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 08:52:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CINARn+PhwiQ2Rdlyg3ZMWhVzADzFmVmKY5osflUybXS3MhgVy+VJvG2D4G1KuQlhMv/tif9wqnwrVd18SYWxnuM9bES6cK32LaqqhK1j4DpRSBPkJhDLYqPf6wfqXr27OmK9oeC5VRVm9tFxDF0nC7qizWH3s2wKWwBvL0bJvowfshGrCvAM4kynSVmyH4oR/KyQa1XbQelb1Ew8aec3PhvM3/ncgaThTxTko7NOwgz2Ke/xxpsdtzRY0L1hSPA4XDk0FdRORwhyT0ftn39UTDVngRqZqu/oWWPB7ckaYkeFqaGJ0Wu1NrMZluzgyeQsejuBwjiJZb3fqnF+EcVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWwpbSbZ8cbMhTEI71ghFRQJJ4+3DIG7TH2noMh8A84=;
 b=vX86rhJQE3JLysFoKGd6gXmG2M0crDzj8wZfZVaiPvdAIIL97SS2ZcmkpQzPeu3FHQUOtrP04aOCUSYn0j9QQmr06a2AykbWMoiaQc5H7LLBG7M3BYnc/UTYwVrUifMp4G1Oxvcoa9sfsLdbtsz62rFUg/KbAXMM51QQchmUw1niB2QOK46RGFULOIUZNt6BLF1sFQlQIVSIrq9Qs4IaSwWAQ8vj4JtFKVq2bbsL2zHxu3vGdRot2S7tVsqEp8YJbbDO61dtwfWNltFi2XINFk/rkzl3aNM9OSesE7KA/g7JDfE2dMjjmyF+BWHKhbUrRIUvbU+b/I/vu54fB0gCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWwpbSbZ8cbMhTEI71ghFRQJJ4+3DIG7TH2noMh8A84=;
 b=ogG7i6aAUI9N9ArFkaErvee9eIUZI71VcprarmUzH416UxrYLK9t2TuEmhe7VOrc8HJNUynxvc0ZC6POMW5L1+8w77s3FrBCFGN4sPdHxUjJbbNsQrw9mfWscWOyluSpECDHeYPQq37/VpF7KInJPtHIg4gi7HwprMLaZbJs8PE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7930.namprd10.prod.outlook.com (2603:10b6:610:1c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 08:52:19 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 08:52:19 +0000
Date: Thu, 25 Sep 2025 17:52:10 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <aNUCuvUh5Ugdnyxr@hyeyoo>
References: <aMpxnACqmsQl-lp0@hyeyoo>
 <bbda8c25-b575-4e98-b1ae-b103c6598d38@suse.cz>
 <aMqcXyKRlZggLxu_@hyeyoo>
 <6f92eca3-863e-4b77-b2df-dc2752c0ff4e@suse.cz>
 <aMqyn6nenR8V_p1y@hyeyoo>
 <bf8b4741-1025-4cc8-b9ed-5b566bdcb2d7@suse.cz>
 <aMq40h5iOjj8K7cc@hyeyoo>
 <a32bd837-2597-43d0-9da3-1ce5a53b15f4@suse.cz>
 <40461105-a344-444f-834b-9559b6644710@suse.cz>
 <CAJuCfpG6CSm2iZ3jrwLQA4vVbTMvC=B37q10OL+wLzm-DSRhFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG6CSm2iZ3jrwLQA4vVbTMvC=B37q10OL+wLzm-DSRhFw@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0037.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: f6323718-732f-41a4-81de-08ddfc10d5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTZYNTNucTE1MHpsVWxzNE9lM2NzNFVhdE1KZXl0ay9nT2lOUzd0SFRUUlVU?=
 =?utf-8?B?WTlWZGxJcjJldUV0VEhlVVhyNVQyeUdla3NDYmhPTkRXNmhpbVNGazk4WEx6?=
 =?utf-8?B?cDhMeWcyUFNvbXVxeGpUVE1xQUlLUGpxbnBqVjdYdkNGL3g1cHlQSTZyK2xp?=
 =?utf-8?B?ck5zcXh0K1ExbHgyQ09jZ1RiTTkyKzNLL3U0a281SjFmS1JRQjg1d2RwbDFT?=
 =?utf-8?B?UnBpNTQ1RmRtZ1ZWU3lNUHpHVlVwR3REaFFDQTR3ZXQ1bXRQeGQydVIvVEVK?=
 =?utf-8?B?bU0za3diOHlvQStBQzE4YmRKUUw4U1VYalppY3hoRWxRWTdEOXFWeXhxU3RU?=
 =?utf-8?B?dmt5bGNISlJmMEdKaGxGTW1nTDQzVGN0MlBtVDRUWUVHV043WDdsSU5JWjEr?=
 =?utf-8?B?OXczM0xueHZIMHJydzdDRlZWam1EMmVPcit6eGxwOUJqSStPamlaZmhxbWVZ?=
 =?utf-8?B?VDlQNkRFWXoyM1hyd2gyeGl6Ti9kTFRqalBFQnlCRlIzRk1lU1Ircndxc2tw?=
 =?utf-8?B?UkpSVTFQMUJ6R1dSUnQ4SlVpNkh2c2YwU0xSUXgyTWV5MXUraWd6WjdET3dU?=
 =?utf-8?B?RWJIY3hOcjNraXlrMU5FVGdHbEpudUozZ2RSRzFOMHhaUTdSalB0STZiQ09x?=
 =?utf-8?B?MGRXWEpoVUFhSWFuWUVoVWY1ejA3VlNndzVaNzFpM2Y2cmxQdnZjMFRERENx?=
 =?utf-8?B?eDhGNldPcHNJK2ZwUFRaQ1A2TTBCSUcxK3puQ2pJVEhkUEtDU3NDcVZqOHcy?=
 =?utf-8?B?NjNTaDRmWnM0dHcxZmR5QnlZMW0xYmVZRDczcjc2VDRyYUNWOVk2R0RzMUJ6?=
 =?utf-8?B?VlBGNnFldTFkM211N1dLQ3ZIdWpBOHQzd0laKzhOUkdhK3Ntd0hUbjFYTmhZ?=
 =?utf-8?B?TUlaNmlQR0s2KytkMlNmNmRaNGZuWHh1aVZuUC9GVnFRanplVnlmOWpocHhH?=
 =?utf-8?B?WHcxRW4zZWNMTkYxaUZoeXgwSXF3blJ2d21KeW9SWjFhZitDeVA4TmtaTU9W?=
 =?utf-8?B?UG4rcFV0QUtTVzRKa1p0b3Z5UUxNSlpYTmY4OGhLeGplL1ExaWtBYlQ5YWtI?=
 =?utf-8?B?WHZZUGN5Qmp2NDg0SktIbFZKR1FPQnlpWU85SlNnbi9meUpheDV5VUdiQmc3?=
 =?utf-8?B?UnJIeXJDS3UyUElaZjZvSlBUNG8weTVBV1ZpRzg3Q0diYkxUbEx5bitOZ25G?=
 =?utf-8?B?RkpEakNOMFhlSWFHdkNqOWVtWFhTY3JqQ3JOMG1iYXplQjMvak8rSXpvMFh5?=
 =?utf-8?B?aWhCYlg0T3N1V1dRNVRnRUZld3hyV2Vpa2JrYmZqNmJjVVBBK1IxeWtHQnho?=
 =?utf-8?B?RUFWQUU1ajZIanRFb3hSUEQrTGpwK2tQVVFGL2REbVRZSEI2MUwwaHU4a0pT?=
 =?utf-8?B?SUJrM0FjWDJFQWY2VUJKci9GQzliQ095eEhhYXVnVUw0TmgybDlpcHkvVytN?=
 =?utf-8?B?T0FFdU9qaVEwMlBXc2tOS00vdGtwcEhzeWh2SWdGU0duSjJBd2dUYlhZSXdi?=
 =?utf-8?B?YU5mdE94WHk5T0xUeFRpZFVPYzdSN0M0NFVaaWszcUFHYkRnYzUxdDlKNUla?=
 =?utf-8?B?OXExMVNMcTlES2pmRVBYZVBDSSttQW9hKzZVT1V2MnV2WWk4QTZFeFp2dTRY?=
 =?utf-8?B?MWxvTzZlNWMyMlJZSDNwOEk4Qnk2aTN3L3lyM0dnRURHMkZ2QjJiUnVKWlQ1?=
 =?utf-8?B?T0hyUVF5NlIyWTJWOTdLNjJuNHovQXl5V29mZ2ErcndIZlVHWjNvZXJ4aUM2?=
 =?utf-8?B?RDFlWUJHcVFhMWFWZVZyY1BXanU1cXluNHNEUE1zWk9JcUFYZDlkTWJMUkJz?=
 =?utf-8?B?R2FyN0RnNmdUYTYvcDFDRTdwTEtqenR3OFBhbkoxY1Z2a1p1ZXVxbFV0NUlC?=
 =?utf-8?B?by9uaVE5TGd3dDBkVER6MFJPVitOSDBsWlA3dXNLS0FZY1FQSGZ0NlB0eHNI?=
 =?utf-8?Q?jc4b282BakQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ynp4Tzg0b0hidU9Kdk9RTmQ2ME9jRXQySzVyOXdvQWF6QkVYZHBvUithNGtP?=
 =?utf-8?B?aUNnSHJ3SlZGVkMrc3NHQllseXJKMmJIdTdyTUYvWEdRbExGT3JVaHNFNnBJ?=
 =?utf-8?B?eXB5YWF4Y2o0N1JwTURNcElxSjY4ZU8zeGo0V2RuOHNBanIwZHNEQ1A2dGJI?=
 =?utf-8?B?blRpYVprQkN3N3pUQnZ0Qkl5OXBFY0JoUkZ1azF2NlNseWlaSHpHZGg4V2NG?=
 =?utf-8?B?NmVRdVE1dUJxbjNuN2Q5Rk9uNW8rQURFTGw4RWVHOUhoemlsYjdJQ2sybVpa?=
 =?utf-8?B?dUNqc0wzVFl0YUZUczhoNnJyNjM3RTNxR3dBK1JoV29MbnJDbEk2ODFuMzlQ?=
 =?utf-8?B?akhDZDFyU09MWG9iMCtXN1dDcXBNTElPYkRSc0dhUnF1VC9RV2JBckhuQVpj?=
 =?utf-8?B?ZXIxaDlIWGs3Z2xyeEZPemVqTmFSTksrM01Mb1FiRTRudExXNjMxV1h3NzhZ?=
 =?utf-8?B?L2R5RnI3SUhiKzdocFhPWmxEVFYzQVNIdi9CeDVJeWNiRTIvSW1Na1k4U21j?=
 =?utf-8?B?NW1hYUZtenlFRGdVeExvTTlyRHRJSkFrVkZLUERnalo2Zys2c0huVmZHa0pk?=
 =?utf-8?B?VUhEd2tqc2FPanpXSGFKaUZ0dGN6MTZMSm82ZVJjRCtxeEY2czN2VWJLTzRS?=
 =?utf-8?B?UnNmRFlvaVpTdkVJOGtDTG1zSXBJMW5GQlBTekdabEtuMmoxYTE1K2xEaHhB?=
 =?utf-8?B?YStaaEM1SjFjUkFMQnpsTmlIdS9yK0pFcGdnTHc0QWU0MmYyZEhtN21wS0p2?=
 =?utf-8?B?ZXdQRDUyVFZJVTZoTi9nb2xac3NEWEk1MlBhRDJDWVFENytkSTl3OXpEd2hX?=
 =?utf-8?B?TXpWUWZZVmQ1UUg2b2tCODVuSlFTZVNwcGEzSW0vNkk5M3pZbUx5VXA3N0ZR?=
 =?utf-8?B?MkNkNnNWekRFYUcxS2s3N1RFdDlBVDRWSjRlN0Izem0zOEZRQ0JBWGcxb1BO?=
 =?utf-8?B?Z0NSTk1QUWRkWUZYdkZ2LzNoT1U1TTFsZ1FSL1pQV0hQcHNjcmZ2eGh1YUNp?=
 =?utf-8?B?MEpmVnVOaGx2dVdXYmNRU1g1V3RLdlhxeDZGR2syWmk0aVNiVTdzTkFGM2hV?=
 =?utf-8?B?TTJxVUpXU2J6Rnluakd1WXR6WWgvSUF4MldlajhJRjJjd0tnemxEVHBOZTY1?=
 =?utf-8?B?WG5yNC9HSlA4Z0VuNVpUYXBaYXBQaGlValZ5bU91R0RYOFVkakd4d0xrOUQ3?=
 =?utf-8?B?SWlNOFVvaXBaNGJhSFRuWnBpVmNOSHR0K1BocmxNRkREY0pUTkptNjVMc0J2?=
 =?utf-8?B?dENjUVZ1V0tvYUFqUVl5OG5WNnIzdWwycVRDM0N5eFpWSnhIeEpKTWo0YlJE?=
 =?utf-8?B?ZlNhUVZ1czl2bWh2UUtHV0FpNVBSS2tkNTdaQ2xFblRXdE1rU3RVVE9MeE5J?=
 =?utf-8?B?b1AySEN5L2s1dFMyUGJ3L3lxbk00dnIvUVRSNXZRaTFwZUZsYlU0azEwdk5t?=
 =?utf-8?B?L3ZPREgyTEpTTWpXRjhhSTY0RUVNNUFUTzB6ZS9kaWJPOHpUMjlocVVGQWw5?=
 =?utf-8?B?WFNTQ3VWNWtNM2FXdUUwdmdacTJCL0xRWHd6UVNlOHUrVmgrRyt2cFJzY1hp?=
 =?utf-8?B?b2U0VUhsZGx5eUVGTEFuTFR5NFBRd1J3UkdoWWg1d1c0KzZZNEQxRDJzWnB1?=
 =?utf-8?B?cm5YN01RZUwwN2xFalJlaHpnY3FpbDJVR3lLV3VrVWM1Zmx5WlNmaUNJUGJr?=
 =?utf-8?B?WS9PYnZ3ZWtZaDN4ZnpjVTcxR2tjSEM0dEFRQ0hOU2UwMVFVMHQ2aUJmTGVI?=
 =?utf-8?B?L1VUbWQzcUo2bDVwR0t6K2FnRzd4VC9lU2NscVk0dUhYV1dTWGR6N1QveGtS?=
 =?utf-8?B?Wkg1L0pCNVRzM01ZeWFNWHBTMUcwZi9MeDZjWXJ5UVZEcTlQaU5kRDJJMGp0?=
 =?utf-8?B?cXVkL0oyRW90WWppS1F6L1dJeUJadlNwTzNoVXcwQlhLSFhaSytEazN4MnR3?=
 =?utf-8?B?bEkxdnNBbmlVdHlEeFE5TlMxVGNrM05HRWJEby9sNTh2ZW9mUFFtaGFlYzdK?=
 =?utf-8?B?UEcvdlZKejUybWlkRXRERjlxNkVFYkMycHJpUjlHdWZzbWhNR3VnMFRwci9Y?=
 =?utf-8?B?Q0V2S2kyQWlrMSs1cjNUbFVqMHcvWGJ2aHMybGVra2x4SDd1c1U4dFRpU3Ux?=
 =?utf-8?Q?L09T87vgNqBKZlrmTEqhbIiYk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VJob77EMxzvSnr1YSTDoCR232BPd0VYii+h9qRjZ9kO/gPmqGSXJrC6ZEKxk59jbJDoaL/otWuEk08OrcpaGrReihNzNRCSMmWIKRKB07lqNz0MpbB6xbkx5su0n+p4W+1EzqFBxnDsrtgEERsftf7yXIRrIJGErr2U7Ip1XaGu5ZdhQmjgaZIj6BQhD82wVmnyk5Yyp1udfGbBLkaZR732rbKuEIgKduNCai5lEXmVg7DHmH0uLKuhofkF5SnQ/SZjzRAxz1TR18NxsDPDi9tIfo0GrqZyZpqc9MLNAUAm50Pp4now7ickQdEPcFNGJwRR+IoqP5nLbY9Y7k7DuilVpYAoKASVER6x1n8IY+5vdTSqp03jwg/OwqQ8L0HuDFK7HsMdUJA+1JQWJYHfjeLxu3sjSB4Yp/9Qq2CAZPy3kyRM5zCPOBFCwTsbvYtHPc6mB8wlJWWQyGZcf4duKRcpf0kb8ZPeGIf9KEehmgGbP9s0/YxJYJ77mHZgoWIHvjtb0hKZ58wyuO4zEK94ryQUHLw+yPPY5Da1+OGvEM/wUcTIhvwuAFHTL0iisnxQmCOIGsxWRN0eRK4NFRvvWNVvrElOn++WLNHrlJvTgTpk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6323718-732f-41a4-81de-08ddfc10d5b6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 08:52:19.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xom/DSZ5TwRidrNGKOvKY/7DVTkKly7FZYGvFdNmMc/QSo7heWtDN1VovJnZDCZMPEVf83l6DGcOCGKp7EUyhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250083
X-Authority-Analysis: v=2.4 cv=C5XpyRP+ c=1 sm=1 tr=0 ts=68d502c7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=YF3b-G4o7lnnymrhLbcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -YbvF044xqbVP6kcliUlSDI--Paph5cy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNiBTYWx0ZWRfX2YIgRTTHWHOJ
 WeOWONhUnhBxO14trYfJGTDvRMbNxcmZLfY/ULqmaHpY94v1sLOTqyQ4TBeBjFJ7JYvfQWzgjkg
 yMERauj3T8D/bE4ukdqz0QdAfms5TPEKy2Ym1kvsnKr5p3HV7XxWTrbB9I8EAcYLF5RHOwDA4IL
 2l+Hq0Pc6YRLI/vW7EMG/XN+MiwC3ZhxqxyehBEdPRdxFxSo287vuKj/3H/QI4h9wTVoOzkTobD
 nI/u92d3iiKErKB4CCSg+f/0y8EBINsI/N2fLjZR3ript8H+eThGvtfVupDzzN0BUw7kbswRZzI
 2A02IUgl6FrrMXgYLxzZpA4cXx0ukT0ejVxsibXdRZE66wKeIhntuHsuJLeE6rb948mKWaok3uN
 EjB1fDHs
X-Proofpoint-ORIG-GUID: -YbvF044xqbVP6kcliUlSDI--Paph5cy

On Wed, Sep 24, 2025 at 09:35:05PM -0700, Suren Baghdasaryan wrote:
> On Thu, Sep 18, 2025 at 1:09 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 9/17/25 16:14, Vlastimil Babka wrote:
> > > On 9/17/25 15:34, Harry Yoo wrote:
> > >> On Wed, Sep 17, 2025 at 03:21:31PM +0200, Vlastimil Babka wrote:
> > >>> On 9/17/25 15:07, Harry Yoo wrote:
> > >>> > On Wed, Sep 17, 2025 at 02:05:49PM +0200, Vlastimil Babka wrote:
> > >>> >> On 9/17/25 13:32, Harry Yoo wrote:
> > >>> >> > On Wed, Sep 17, 2025 at 11:55:10AM +0200, Vlastimil Babka wrote:
> > >>> >> >> On 9/17/25 10:30, Harry Yoo wrote:
> > >>> >> >> > On Wed, Sep 10, 2025 at 10:01:06AM +0200, Vlastimil Babka wrote:
> > >>> >> >> >> +                          sfw->skip = true;
> > >>> >> >> >> +                          continue;
> > >>> >> >> >> +                  }
> > >>> >> >> >>
> > >>> >> >> >> +                  INIT_WORK(&sfw->work, flush_rcu_sheaf);
> > >>> >> >> >> +                  sfw->skip = false;
> > >>> >> >> >> +                  sfw->s = s;
> > >>> >> >> >> +                  queue_work_on(cpu, flushwq, &sfw->work);
> > >>> >> >> >> +                  flushed = true;
> > >>> >> >> >> +          }
> > >>> >> >> >> +
> > >>> >> >> >> +          for_each_online_cpu(cpu) {
> > >>> >> >> >> +                  sfw = &per_cpu(slub_flush, cpu);
> > >>> >> >> >> +                  if (sfw->skip)
> > >>> >> >> >> +                          continue;
> > >>> >> >> >> +                  flush_work(&sfw->work);
> > >>> >> >> >> +          }
> > >>> >> >> >> +
> > >>> >> >> >> +          mutex_unlock(&flush_lock);
> > >>> >> >> >> +  }
> > >>> >> >> >> +
> > >>> >> >> >> +  mutex_unlock(&slab_mutex);
> > >>> >> >> >> +  cpus_read_unlock();
> > >>> >> >> >> +
> > >>> >> >> >> +  if (flushed)
> > >>> >> >> >> +          rcu_barrier();
> > >>> >> >> >
> > >>> >> >> > I think we need to call rcu_barrier() even if flushed == false?
> > >>> >> >> >
> > >>> >> >> > Maybe a kvfree_rcu()'d object was already waiting for the rcu callback to
> > >>> >> >> > be processed before flush_all_rcu_sheaves() is called, and
> > >>> >> >> > in flush_all_rcu_sheaves() we skipped all (cache, cpu) pairs,
> > >>> >> >> > so flushed == false but the rcu callback isn't processed yet
> > >>> >> >> > by the end of the function?
> > >>> >> >> >
> > >>> >> >> > That sounds like a very unlikely to happen in a realistic scenario,
> > >>> >> >> > but still possible...
> > >>> >> >>
> > >>> >> >> Yes also good point, will flush unconditionally.
> > >>> >> >>
> > >>> >> >> Maybe in __kfree_rcu_sheaf() I should also move the call_rcu(...) before
> > >>> >> >> local_unlock().
> > >>> >> >>
> > >>> >> >> So we don't end up seeing a NULL pcs->rcu_free in
> > >>> >> >> flush_all_rcu_sheaves() because __kfree_rcu_sheaf() already set it to NULL,
> > >>> >> >> but didn't yet do the call_rcu() as it got preempted after local_unlock().
> > >>> >> >
> > >>> >> > Makes sense to me.
> > >>> >
> > >>> > Wait, I'm confused.
> > >>> >
> > >>> > I think the caller of kvfree_rcu_barrier() should make sure that it's invoked
> > >>> > only after a kvfree_rcu(X, rhs) call has returned, if the caller expects
> > >>> > the object X to be freed before kvfree_rcu_barrier() returns?
> > >>>
> > >>> Hmm, the caller of kvfree_rcu(X, rhs) might have returned without filling up
> > >>> the rcu_sheaf fully and thus without submitting it to call_rcu(), then
> > >>> migrated to another cpu. Then it calls kvfree_rcu_barrier() while another
> > >>> unrelated kvfree_rcu(X, rhs) call on the previous cpu is for the same
> > >>> kmem_cache (kvfree_rcu_barrier() is not only for cache destruction), fills
> > >>> up the rcu_sheaf fully and is about to call_rcu() on it. And since that
> > >>> sheaf also contains the object X, we should make sure that is flushed.
> > >>
> > >> I was going to say "but we queue and wait for the flushing work to
> > >> complete, so the sheaf containing object X should be flushed?"
> > >>
> > >> But nah, that's true only if we see pcs->rcu_free != NULL in
> > >> flush_all_rcu_sheaves().
> > >>
> > >> You are right...
> > >>
> > >> Hmm, maybe it's simpler to fix this by never skipping queueing the work
> > >> even when pcs->rcu_sheaf == NULL?
> > >
> > > I guess it's simpler, yeah.
> >
> > So what about this? The unconditional queueing should cover all races with
> > __kfree_rcu_sheaf() so there's just unconditional rcu_barrier() in the end.
> >
> > From 0722b29fa1625b31c05d659d1d988ec882247b38 Mon Sep 17 00:00:00 2001
> > From: Vlastimil Babka <vbabka@suse.cz>
> > Date: Wed, 3 Sep 2025 14:59:46 +0200
> > Subject: [PATCH] slab: add sheaf support for batching kfree_rcu() operations
> >
> > Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
> > For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> > addition to main and spare sheaves.
> >
> > kfree_rcu() operations will try to put objects on this sheaf. Once full,
> > the sheaf is detached and submitted to call_rcu() with a handler that
> > will try to put it in the barn, or flush to slab pages using bulk free,
> > when the barn is full. Then a new empty sheaf must be obtained to put
> > more objects there.
> >
> > It's possible that no free sheaves are available to use for a new
> > rcu_free sheaf, and the allocation in kfree_rcu() context can only use
> > GFP_NOWAIT and thus may fail. In that case, fall back to the existing
> > kfree_rcu() implementation.
> >
> > Expected advantages:
> > - batching the kfree_rcu() operations, that could eventually replace the
> >   existing batching
> > - sheaves can be reused for allocations via barn instead of being
> >   flushed to slabs, which is more efficient
> >   - this includes cases where only some cpus are allowed to process rcu
> >     callbacks (Android)
> 
> nit: I would say it's more CONFIG_RCU_NOCB_CPU related. Android is
> just an instance of that.
> 
> >
> > Possible disadvantage:
> > - objects might be waiting for more than their grace period (it is
> >   determined by the last object freed into the sheaf), increasing memory
> >   usage - but the existing batching does that too.
> >
> > Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> > implementation favors smaller memory footprint over performance.
> >
> > Also for now skip the usage of rcu sheaf for CONFIG_PREEMPT_RT as the
> > contexts where kfree_rcu() is called might not be compatible with taking
> > a barn spinlock or a GFP_NOWAIT allocation of a new sheaf taking a
> > spinlock - the current kfree_rcu() implementation avoids doing that.
> >
> > Teach kvfree_rcu_barrier() to flush all rcu_free sheaves from all caches
> > that have them. This is not a cheap operation, but the barrier usage is
> > rare - currently kmem_cache_destroy() or on module unload.
> >
> > Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail to
> > count how many kfree_rcu() used the rcu_free sheaf successfully and how
> > many had to fall back to the existing implementation.
> >
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/slab.h        |   3 +
> >  mm/slab_common.c |  26 +++++
> >  mm/slub.c        | 267 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 294 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index cba188b7e04d..171273f90efd 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c

[...snip...]

> > @@ -3840,6 +3895,77 @@ static void flush_all(struct kmem_cache *s)
> >         cpus_read_unlock();
> >  }
> >
> > +static void flush_rcu_sheaf(struct work_struct *w)
> > +{
> > +       struct slub_percpu_sheaves *pcs;
> > +       struct slab_sheaf *rcu_free;
> > +       struct slub_flush_work *sfw;
> > +       struct kmem_cache *s;
> > +
> > +       sfw = container_of(w, struct slub_flush_work, work);
> > +       s = sfw->s;
> > +
> > +       local_lock(&s->cpu_sheaves->lock);
> > +       pcs = this_cpu_ptr(s->cpu_sheaves);
> > +
> > +       rcu_free = pcs->rcu_free;
> > +       pcs->rcu_free = NULL;
> > +
> > +       local_unlock(&s->cpu_sheaves->lock);
> > +
> > +       if (rcu_free)
> > +               call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
> > +}
> > +
> > +
> > +/* needed for kvfree_rcu_barrier() */
> > +void flush_all_rcu_sheaves(void)
> > +{
> > +       struct slub_flush_work *sfw;
> > +       struct kmem_cache *s;
> > +       unsigned int cpu;
> > +
> > +       cpus_read_lock();
> > +       mutex_lock(&slab_mutex);
> > +
> > +       list_for_each_entry(s, &slab_caches, list) {
> > +               if (!s->cpu_sheaves)
> > +                       continue;
> > +
> > +               mutex_lock(&flush_lock);
> > +
> > +               for_each_online_cpu(cpu) {
> > +                       sfw = &per_cpu(slub_flush, cpu);
> > +
> > +                       /*
> > +                        * we don't check if rcu_free sheaf exists - racing
> > +                        * __kfree_rcu_sheaf() might have just removed it.
> > +                        * by executing flush_rcu_sheaf() on the cpu we make
> > +                        * sure the __kfree_rcu_sheaf() finished its call_rcu()
> > +                        */
> > +
> > +                       INIT_WORK(&sfw->work, flush_rcu_sheaf);
> > +                       sfw->skip = false;
> 
> I think you don't need this sfw->skip flag since you never skip anymore, right?

Yes, at least in flush_all_rcu_sheaves().
I'm fine with or without sfw->skip in this function.

> > +                       sfw->s = s;
> > +                       queue_work_on(cpu, flushwq, &sfw->work);
> > +               }
> > +
> > +               for_each_online_cpu(cpu) {
> > +                       sfw = &per_cpu(slub_flush, cpu);
> > +                       if (sfw->skip)
> > +                               continue;
> > +                       flush_work(&sfw->work);
> 
> I'm sure I'm missing something but why can't we execute call_rcu()
> from here instead of queuing the work which does call_rcu() and then
> flushing all the queued work? I'm sure you have a good reason which
> I'm missing.

Because a local lock cannot be held by other CPUs, you can't take off the
rcu_free sheaf remotely and call call_rcu(). That's why the work is
queued on each CPU, ensuring the rcu_free sheaf is flushed by its local CPU.

> > +               }
> > +
> > +               mutex_unlock(&flush_lock);
> > +       }
> > +
> > +       mutex_unlock(&slab_mutex);
> > +       cpus_read_unlock();
> > +
> > +       rcu_barrier();
> > +}
> > +
> >  /*
> >   * Use the cpu notifier to insure that the cpu slabs are flushed when
> >   * necessary.
> > +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
> > +{
> > +       struct slub_percpu_sheaves *pcs;
> > +       struct slab_sheaf *rcu_sheaf;
> > +
> > +       if (!local_trylock(&s->cpu_sheaves->lock))
> > +               goto fail;
> > +
> > +       pcs = this_cpu_ptr(s->cpu_sheaves);
> > +
> > +       if (unlikely(!pcs->rcu_free)) {
> > +
> > +               struct slab_sheaf *empty;
> > +               struct node_barn *barn;
> > +
> > +               if (pcs->spare && pcs->spare->size == 0) {
> > +                       pcs->rcu_free = pcs->spare;
> > +                       pcs->spare = NULL;
> > +                       goto do_free;
> > +               }
> > +
> > +               barn = get_barn(s);
> > +
> > +               empty = barn_get_empty_sheaf(barn);
> > +
> > +               if (empty) {
> > +                       pcs->rcu_free = empty;
> > +                       goto do_free;
> > +               }
> > +
> > +               local_unlock(&s->cpu_sheaves->lock);
> > +
> > +               empty = alloc_empty_sheaf(s, GFP_NOWAIT);
> > +
> > +               if (!empty)
> > +                       goto fail;
> > +
> > +               if (!local_trylock(&s->cpu_sheaves->lock)) {
> > +                       barn_put_empty_sheaf(barn, empty);
> > +                       goto fail;
> > +               }
> > +
> > +               pcs = this_cpu_ptr(s->cpu_sheaves);
> > +
> > +               if (unlikely(pcs->rcu_free))
> > +                       barn_put_empty_sheaf(barn, empty);
> > +               else
> > +                       pcs->rcu_free = empty;
> > +       }
> > +
> > +do_free:
> > +
> > +       rcu_sheaf = pcs->rcu_free;
> > +
> > +       rcu_sheaf->objects[rcu_sheaf->size++] = obj;
> 
> nit: The above would result in OOB write if we ever reached here with
> a full rcu_sheaf (rcu_sheaf->size == rcu_sheaf->sheaf_capacity) but I
> think it's impossible. You always start with an empty rcu_sheaf and
> objects are added only here with a following check for a full
> rcu_sheaf. I think a short comment clarifying that would be nice.

Sounds good to me.

-- 
Cheers,
Harry / Hyeonggon

> > +
> > +       if (likely(rcu_sheaf->size < s->sheaf_capacity))
> > +               rcu_sheaf = NULL;
> > +       else
> > +               pcs->rcu_free = NULL;
> > +
> > +       /*
> > +        * we flush before local_unlock to make sure a racing
> > +        * flush_all_rcu_sheaves() doesn't miss this sheaf
> > +        */
> > +       if (rcu_sheaf)
> > +               call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> > +
> > +       local_unlock(&s->cpu_sheaves->lock);
> > +
> > +       stat(s, FREE_RCU_SHEAF);
> > +       return true;
> > +
> > +fail:
> > +       stat(s, FREE_RCU_SHEAF_FAIL);
> > +       return false;
> > +}
