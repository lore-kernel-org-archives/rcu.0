Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C663933C742;
	Wed, 17 Sep 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114505; cv=fail; b=u5JKh2xe9Jiz7pZ/IjEVqjfAnBt3GYuFysOPwwgUzRVyi5Cvk1PiXWqaCNcOsgmFEXNJbbkgLXcjuIPabIkPUYXQHLtbTPxKUg/u7/U14Zf4J13kZxMyJ3ci9DL/xuWfnY6JQ1Rrg8RpTcZToD6SOlM9gNZ7kxxy2791blU5AZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114505; c=relaxed/simple;
	bh=9G3XSQraP9qv0jz3mltTUOwmcUCT/dvhs2rx6HPC6fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=frWlZzN4itVDHDhQABXSLQ8Td2zD+R9ufbqYLDoWtqOjPWpthwQ7YCdf9hfd62jkaqEWpY9wpxvDXi3VETb2zhE0J6FayvBYNKnzh57c6+297rC1TPhSqKtdWt7YFnMJtE/GuRdn5e+ZL58ZppR5MAZ4FBapN7/OcozFMBu+Wrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sHIT6M0W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JA2rRbTW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sHIT6M0W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JA2rRbTW"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HAQfxQ008301;
	Wed, 17 Sep 2025 13:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DQmFTMEv9tSVcNtNln
	94icseigbNju0MH1d/wELuGqo=; b=sHIT6M0WxBpTnMO4DynVoLBGR6YeAKqL3u
	9oRXZTrPa2sVZf0V2CNAREFmLrz1Y7Rz5znb9A7RhVfuyLF/PcFOOdw91b14PX1S
	Npfp25SGtHVmP4RkW/GROXhfYsIr8feJ9UspaBsZGF7UUN6p02I983NiuADcmjd9
	Iahtn4Xh9sFdU6m6o17lXa9OSTfkP7nzWsxPmknE7zPZKqDFUgerzqRUVETdgAVx
	Jzg1QL1UmkWsJSrMTX8N2jj75Ym0CLjAgxIH9/X/keEUlUNlrEZsuY2/yXBQaJr6
	0Oo4ZIKva33IDDRb3APGusHiGaXTb1pG8au+0LBblHDL+rP3AGcA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9157m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:08:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HBnuVV033752;
	Wed, 17 Sep 2025 13:07:55 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2dqhnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:07:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQAHfEvPUeKgfMXYb/mFoKQz/8rMla7C3iDLgsN9gPXWqJZ7PJf+ry0uEDBhABg9aMb/Yuu6MVldjdHBwn9L10zvt4WFVhdNQhp4Rz8uz2hPNevWM+b2g0D55YbvOPultYbh+24t54xQvcSR7jfmJQPBGpuG2tcLMXkaMuGgW8rTsLXiOLLMr51eQCg7s1obaGnbL53qrSV5DUdMXBTLvdhlxo7f8Ca5qrtjVSzXcAyJXv0ioMdpCxbB5j/eMMljPTXWFSJcYyHK3siXXza52BjF5D4k22kNthByyLvhTgYnBRlRntJXXhQXE8wZL5v3UdWMRKzXepyU1obm5t+kiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQmFTMEv9tSVcNtNln94icseigbNju0MH1d/wELuGqo=;
 b=NzCRvtU0eJqPHWpSD3V95H3FzcAXQoYxz8kU5qnBAZvm3FhS+ntPn2at9fhzj8OVdJcSpE4ChUjLkWmlEN72uITNL96zJimUf1g5k/llvmtb93q4PZylwyayhegfGjpwxyqOfFXlKyFrRCLGbFtZZuclAg3P/hGD0ni4krPYmuS+KndJqAMLo4yzVxyUO52DMKqm6O6grfHNSqjtbj23RMk8Ng1EmOZBrvluIgU8a5hL+P+EoIxvfdqpzLkMOCY799FsSGAkjCvIUHUPdGAKSL4qKHh1YkS8dWEDoHxHKig1e+cGwVxnbnZ8sJvqhD74UhnFy6xR5hSCpU0K3ddqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQmFTMEv9tSVcNtNln94icseigbNju0MH1d/wELuGqo=;
 b=JA2rRbTWMh0Z7CxqNEY4daANOKOSYDiZKizLMA7Xb/eCYhsfnaFqC2DM/McUVzzciYjRTXq1a7OouHwlxjri60p3rfWD2gUsNnU1qoxbEAkVHWUaLFiIUfiKUfw8Qwmh5H9D1cWgTUWpjjVaYrqH7ttoVYqFA/o7lUcY1Xbrd8g=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 13:07:52 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9115.018; Wed, 17 Sep 2025
 13:07:52 +0000
Date: Wed, 17 Sep 2025 22:07:43 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
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
Message-ID: <aMqyn6nenR8V_p1y@hyeyoo>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>
 <aMpxnACqmsQl-lp0@hyeyoo>
 <bbda8c25-b575-4e98-b1ae-b103c6598d38@suse.cz>
 <aMqcXyKRlZggLxu_@hyeyoo>
 <6f92eca3-863e-4b77-b2df-dc2752c0ff4e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f92eca3-863e-4b77-b2df-dc2752c0ff4e@suse.cz>
X-ClientProxiedBy: SEWP216CA0137.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: 0abe08bd-3d13-482a-9b41-08ddf5eb3554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MP/QRk2CA/g92A7eIaqH7W+nzGF6DLxtU3bWhWWVGwaVYgBj9IOes1Ys20gB?=
 =?us-ascii?Q?+U9fgj7OMY8toz1gFjBIhegToUSpSF4f2sOxjsowW5Mgv6UqBUCTawm8FbPl?=
 =?us-ascii?Q?dXs5ANOubzjRRYTjlmVYIy6tcrDT2segaNPVeUav7hZ8De/FmuUOALgSREmy?=
 =?us-ascii?Q?4bvECNHj4g0A99VxxUoM7udNzkJwQZ00AKhNwUgGFsGuHy6bWsBi6vz2q4fw?=
 =?us-ascii?Q?qeIGPN2kzr2RJ8euOE+qRuRBqXTyD7aZLVPWhFnANnlH+bIwXy3D6P4qDbV9?=
 =?us-ascii?Q?1zTe+j2gPu9cxN575qoMXYrx9MdyX/WVdAw7cxlziu0veXRPZ4BQh9yCuowE?=
 =?us-ascii?Q?TS388KNmIe2R78YUakAO0Jrm6U3ecpBFaUt4OiUtShsrT52h7wyDDo1m+TRo?=
 =?us-ascii?Q?v4QSGP06yMlC6x0glYsJG9ks8OV/2zle+AMk94/0uZ9twZCBC8xc47ll5tl0?=
 =?us-ascii?Q?uWIQWuAr56D+VFlzziREE2nwO9qB72y6Hy+mS2xUT/nn8pi09gNv0q4wJUnl?=
 =?us-ascii?Q?uA6AHVFvDZ7plAzUL+7hwAxUNcuBDl3XkJHZxIgyj55Fj5iU1g2qiM8bHDac?=
 =?us-ascii?Q?uFPtDoaEcKvqxtI/Ch6spCpQ+x0umWFrWM3eed3Gr8lrAMTQTsAZe+HtQmN6?=
 =?us-ascii?Q?CYvSv/YydQXKgSbL2UCk6A+Z8baNsHG7gyNVRl2cKqDBWsf4mdFz/OTSikag?=
 =?us-ascii?Q?i7Iyw8SFXLUSNF6u8vF3nr9LzpJvgxEnljrT3RSAqJJ2sZDLhkx5b4HhEr8q?=
 =?us-ascii?Q?hrxHCvT0Jk6zqlUX3kRlejx4hpqAPPgcktUrYYICA4Ha/F0AOZGgYbjqcKGu?=
 =?us-ascii?Q?SSjnw8h5ecpX4ZRf4goqhlOMi+AItOGDITpo5eXWZ0SnMP6Kf+F/KNUDLajt?=
 =?us-ascii?Q?bC3r4gd35K3bQNCZgagRGh6z4K9tGAI8lhEkONfxlc4EIS+ygybhXIcQdJmu?=
 =?us-ascii?Q?D+92WRBikoAi2pAppg1fpdYHZBzYYuXeO92S/G0jQ6HvTzdbNc0XiBKaThoQ?=
 =?us-ascii?Q?6QO6S2WsYyAcurGglgwmeAceD/mYjoDLUR7ukjzx7OlXp+fomYasjtQZjrHS?=
 =?us-ascii?Q?RPECL7LqRg+yOPoKptUcMPa2p079KKlCFkMGs8UL6K/YzzmrPxxfrmtubr17?=
 =?us-ascii?Q?4TlfoGQDaIShMEhTom2b0JR17ufyNOIV0z8aDeyQ+hulcNUw7Yrlevo15Ys6?=
 =?us-ascii?Q?DBDyEYhovG7zdg7dDX0rU/RkxW3g0XaLUmxx8Fblzso1qA0PzkF9iFgZkCZ9?=
 =?us-ascii?Q?zurwve4/PJyB87KoFdFwJH5FS1N3bOygqv87tcPF+nbAbb+SNKFqmaxjoich?=
 =?us-ascii?Q?JwTCd+m2lJEw+asXNv895h9oBlgkIv192tkrOYxv+xAxByjaD1CjHxmDYXaj?=
 =?us-ascii?Q?+GTX8xSTw/12sIq7XiPrg3P8qFqQsnRpCtX3FDLalQEYltU11Gy9vEIEYddH?=
 =?us-ascii?Q?9Q14i7JibQE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UYfNqqBtJDjNYFDTl6qx06AXoI878dGjN1VCjpGviNstzjA1EjxCUIq8RgqR?=
 =?us-ascii?Q?+SzQjrT/Bdphcgv+wRQAG2XZ/Qyt7TiVjQs0t7KbBob5/uQ6vceSV2XWtZrY?=
 =?us-ascii?Q?AL3O44nqlxUtj/tUik0GNBrRuxQVGXLverh62n01AED88SnbnLFkLlZcwSI2?=
 =?us-ascii?Q?bSIW62hUwoFhVWdtkagq7KL/YOwrIsv+JkHB5ZPNva48PnTRdSPH8NXO225Q?=
 =?us-ascii?Q?YXS19cvpOYLGJ0bJ68LRLO3bJIr3C4yp6Dplael/6nbMCkZtNupVGP6Zo2Qn?=
 =?us-ascii?Q?vX2lxUZiULj62D/H5TcxbUT2RERhZk4xqQ0rH/vYhMQGdlsgAPhs95fwyOKZ?=
 =?us-ascii?Q?VU55fBur6ySJiFri4tkFnrDMQnerPPPqTo2U399Qush8659BI3GkUCI2ivqc?=
 =?us-ascii?Q?I4UL0Zl6Qh3jV+g7oj0BE8larTExnSXH87vT4ZIviJq4Nzlp44y5iHQPBMF1?=
 =?us-ascii?Q?t2FxvvjVjON6Ad4hAbayUwUWvH3qqJZ6Ek6/3IFQAWq4Qrmuas/nuhLR1UzQ?=
 =?us-ascii?Q?SoQae0nYlX2FIEZALZI8rz5bKFORJjYXNMNsRRAS44h/2A3gPflA+a0Td5Mw?=
 =?us-ascii?Q?4d5hjuaR03MS80H26xjUMlf2UfCEXvAm3xF6BVwKnEELzWOqzWmbMBasB2+Q?=
 =?us-ascii?Q?bJGCksnpXiOsqR4VtfYgcodddw2hAW6WPR2vo1ScLj83gMVTFTdTKOUXaI3w?=
 =?us-ascii?Q?1fqIBC3v9w9hwjOaluMQurkgRILtmqL2RFi5Mq2lfcF1l0p7eXoFRSUc8TRL?=
 =?us-ascii?Q?OLUn6fV5ZGc3LzRT4SjORP/KQUHhy/6b1Mpracczoglvxjq87vGH7kMUw1Ch?=
 =?us-ascii?Q?e6b6x55NqRi3/Msp1JCMhJ3Jdn0kN/X6HJWRf4Myz1PWBBxhufYtWeV/VuvC?=
 =?us-ascii?Q?e88VV0haTy9/tAgZuCeMeW1SwN9H9SsZ1gHFnErrs7sn3oxqCJ/V2vebxRTv?=
 =?us-ascii?Q?IsyWUEJiEc2OvD1hQJsGHNTyKCDA6Xfuu4pBVNfZl28Atq0MyHMK2ukZZDn4?=
 =?us-ascii?Q?Kfp23U8yWt9CbSa9C5q2TswjENM+2Vxr06drQRvhlTnYOLgeLdyeOQ2yw1Ks?=
 =?us-ascii?Q?dKTZn9QBehssq3iVhFYxh5YK+qJTg00po1d7cJCXgA2FG8bOScduEi4j9zYD?=
 =?us-ascii?Q?BVsnBKDd5HUZM8aqMx9cHC4fuRz8qBcTlOu1FPtMs5cRgY/T9NCzlyWMmNr1?=
 =?us-ascii?Q?yChnrzANk8eNbLHsE0Y1+HCUTkTBJbpH+66+MeMbcUrzxBsHjUym3M3o/gA8?=
 =?us-ascii?Q?IvihXgI6Xfj7p78uxKGV/mf7UAG5morYrWF4ChcDBHS6xU9R1k9u34bOb1AV?=
 =?us-ascii?Q?3krHo5YxXIMQ7ghw7XNik4OomD0vFq7eYaAEbagqD5dPxYRAJgpqQoQJYgxA?=
 =?us-ascii?Q?nvLX+pMSYkpTNBU6GZNcPjijkj11YD+uQD7BT/jy9EdMkpvnCQi7ysOhpqyn?=
 =?us-ascii?Q?LJpue7g+chDr7jEIn7hobgnF9HNd39BhDvmKTr905ffjawynzpsiCYI/Hi7O?=
 =?us-ascii?Q?je2c3/i2qeP8n1KR5XI5sd1XfUtpI/g4bHLeoW5Jufc15Qz+qS9LMX2imrep?=
 =?us-ascii?Q?jUmiDoelo/L4U432LoUPZv+trT2nsdQYQNk/5IKa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ixJIjdlX2Fi3DuUcpivb5auvBnrfV73GpnpOnWbuA9PDcGNCpy2fgvgr4o18TFsNBFOF0CepmVKbr91cRwKuvsiSvv1/CV2A+/5tr9eE1SIqOYtb8UBqJD1ObMTqEoRiTLmk48H8cPhiNqgbkgcdttIB0LwMuYVQE4s//EAoy0RHAwKQzik35kO3COLRlrtABQJGwgwx8ZHrXGsjxiDf8XYtdCu8yqVKSkCS0ZBtkHlYsa9Hip4zaUYm/XTlgTo4fc62jfuB/5riYbLL2/F7tDperfftHPplN1kH4CoIGQL3fTFgGnujvwBNjMVgRyLAT6emKfs6CbClplI9vj9kB6CT0EBjRhRD/gxCOQMCDjnEmiPBWGxOzOHeJ/gzMipHZx7qcyKkpPWZ/CZIq6FXk4H3DeI+bXCKQ4VClcutzqm6YZi8UjO9oAty282hPT1bGyCcfVMbkHPEha7lHeBbuoqUP3q4onoACE1SiNLPwe9yntfH+6UApA2GRj86HyNSPdeSXbTcJ8GOtsXw+rOy+abUttvfdQBVOOu3QUHiVFJv46A4M1PPnYGC6VjmH60TkBZOpiHS05dXJdQFOypSK9Sd61S9bkl5ulPCyFePLz4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abe08bd-3d13-482a-9b41-08ddf5eb3554
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:07:52.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0kKL/z3x4T2Oavn26kgqYNfiC6Qfc/bE11dzz6A3TiAT0cwgBYdW6yZX3lXx2RpS2mjChxtEtZA4+uCYaztqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170127
X-Proofpoint-ORIG-GUID: 1eEKXK4faAkWkvIdmbbrOPapFUofqNKd
X-Proofpoint-GUID: 1eEKXK4faAkWkvIdmbbrOPapFUofqNKd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9kEViy3CGIMI
 LGstSPJsZZaOAVQs88GzHRh3mXLQbDSOgJYZe8oTOr68W/lZBbA6r2rF1ah/mc0R5ez11/wSd9E
 RA4tKIBqt9g6OL9O8yrBjXaZSjG44kbclDduN6Buc0svbmukeH2Zx+odce/Roq03JsySFqF6Ldk
 MQWfzaX81Eae1Fc7DAhl8ii5fho/xhNA2IrVixFVopk2cJxB17o9UuKJt/uT5xGLhlmSTYQ2c3b
 crWF3iwWRi1fONhHf5LGjCkazgduyTQhB5PHXhbJXptOQ49O3Y5HYE6Z1Zs+AgJ4pS68nVyBsgk
 u+dBB9A/rPPeQHH/zxgGjLPQBI8l5GTu5kQkI+OIFZdEU76ASP5mfvtHz/TXar/+uL1m70i4N6Z
 mMD7zI9z
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cab2b0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=oFNO0EsnXWWuSgokDikA:9
 a=CjuIK1q_8ugA:10

On Wed, Sep 17, 2025 at 02:05:49PM +0200, Vlastimil Babka wrote:
> On 9/17/25 13:32, Harry Yoo wrote:
> > On Wed, Sep 17, 2025 at 11:55:10AM +0200, Vlastimil Babka wrote:
> >> On 9/17/25 10:30, Harry Yoo wrote:
> >> > On Wed, Sep 10, 2025 at 10:01:06AM +0200, Vlastimil Babka wrote:
> >> >> +				sfw->skip = true;
> >> >> +				continue;
> >> >> +			}
> >> >>
> >> >> +			INIT_WORK(&sfw->work, flush_rcu_sheaf);
> >> >> +			sfw->skip = false;
> >> >> +			sfw->s = s;
> >> >> +			queue_work_on(cpu, flushwq, &sfw->work);
> >> >> +			flushed = true;
> >> >> +		}
> >> >> +
> >> >> +		for_each_online_cpu(cpu) {
> >> >> +			sfw = &per_cpu(slub_flush, cpu);
> >> >> +			if (sfw->skip)
> >> >> +				continue;
> >> >> +			flush_work(&sfw->work);
> >> >> +		}
> >> >> +
> >> >> +		mutex_unlock(&flush_lock);
> >> >> +	}
> >> >> +
> >> >> +	mutex_unlock(&slab_mutex);
> >> >> +	cpus_read_unlock();
> >> >> +
> >> >> +	if (flushed)
> >> >> +		rcu_barrier();
> >> > 
> >> > I think we need to call rcu_barrier() even if flushed == false?
> >> > 
> >> > Maybe a kvfree_rcu()'d object was already waiting for the rcu callback to
> >> > be processed before flush_all_rcu_sheaves() is called, and
> >> > in flush_all_rcu_sheaves() we skipped all (cache, cpu) pairs,
> >> > so flushed == false but the rcu callback isn't processed yet
> >> > by the end of the function?
> >> > 
> >> > That sounds like a very unlikely to happen in a realistic scenario,
> >> > but still possible...
> >> 
> >> Yes also good point, will flush unconditionally.
> >> 
> >> Maybe in __kfree_rcu_sheaf() I should also move the call_rcu(...) before
> >> local_unlock().
> >>
> >> So we don't end up seeing a NULL pcs->rcu_free in
> >> flush_all_rcu_sheaves() because __kfree_rcu_sheaf() already set it to NULL,
> >> but didn't yet do the call_rcu() as it got preempted after local_unlock().
> > 
> > Makes sense to me.

Wait, I'm confused.

I think the caller of kvfree_rcu_barrier() should make sure that it's invoked
only after a kvfree_rcu(X, rhs) call has returned, if the caller expects
the object X to be freed before kvfree_rcu_barrier() returns?

IOW if flush_all_rcu_sheaves() is called while __kfree_rcu_sheaf(s, X) was
running on another CPU, we don't have to guarantee that
flush_all_rcu_sheaves() returns after the object X is freed?

> >> But then rcu_barrier() itself probably won't mean we make sure such cpus
> >> finished the local_locked section, if we didn't queue work on them. So maybe
> >> we need synchronize_rcu()?

So... we don't need a synchronize_rcu() then?

Or my brain started malfunctioning again :D

-- 
Cheers,
Harry / Hyeonggon
