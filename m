Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAD55FB95;
	Wed,  9 Apr 2025 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744163483; cv=fail; b=b+NJ6aMspCmwUC/4nPB6nU4bRxJiqPLRxxLvOcEW000CHH/Kp7qquZuDlEGU8KU9xUKZqfzmb/KQkaTtvxHkd2VZpJGUqno0E2z9J7pKM7GBuUeiOpnL+8PnYEuX0rZ3oFxqPza3bYLxrT0mgirJDeR/+Ddd2UAEbm3z46NmXZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744163483; c=relaxed/simple;
	bh=kbTABqI7Asf4DnHA+V1bqZXZ0LVhpNAsIEd7IS+IZbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VbUm+q/q+jpHBywIzjvcjesPD5QWaANyxxZ2XO7YTNzS+6vrZpCmDlIQGt4h33iCjnR+M6X4qwYtnmIsJtyeB86bmAOtbZLZtUtuETRQ3+T5Of0PRuU7VLVuDCz9y0ecDEU5sLNPL2uLATZCKBMsSPRNQZCOVDn0E3XsQBKglTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WmnACkup; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kNTIjP8u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WmnACkup";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kNTIjP8u"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538L9mSd005736;
	Wed, 9 Apr 2025 01:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=U5h5T4IU3br4tjynPx
	sRt1tHoNo/WXSTlq7PBAhS2BE=; b=WmnACkup5ashHbZPUehJ+d/DA4Iu0CWOcZ
	TNSauBIRwlPWqJ3Kk1/rJ9Sbaq0ETtew/39oiG+jckptLFa12w2rrB4/JzlYqVhh
	vBrSt+XlneRg77djEzKSjE1mXVRD4qAza4YyLhhKvpj2a+FS8YQy68SXbRQsDGsh
	JTP+qlHgnytUTJkm2g4z59U0Ca2RWnRF4L5xMB4vAewgECmKiYYMAywPqQYqpyoR
	Rhn3x0FLorewSsZraIs4HmJPo6quI5Eq5jW/XD2ndlsY0tjwuGIRk6j6uIUiEnYw
	hxumFDhNgqU+Dv3CFJEVu2UjrbFUXKLCesXK7zJMkOprju1FVhzw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvjcx4y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 01:50:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5391bJE7022410;
	Wed, 9 Apr 2025 01:50:58 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010000.outbound.protection.outlook.com [40.93.6.0])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyav18q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 01:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5fGPMS77HVQPUfAuuagAwgtJzxXPBFznxwS2Ikv/pOi58N21X/+DEXEoCbmertYIqsgeHdHg7KTUPqWwRgXnUElYwm1RBXl62XmBH5/3/TkJv2vXLcl72d/mZiQMJKwctzY13xu2V6QcA5YiCG1j9vuaLfTKCCkvmJa0llWHrRXbnNLT3+gZR3b1eq+KRp6AbywEmkVhB+uk+5zwt2MrJgVpn1GAITQDnB2L1q+G6OaRiFMgtUc8W9hH6npq0rfK58G7+JyhjimLLyXPLd9j6D8jm5F4m/DT8D4c3ls2zUE8GlRYwlXIk9mf8r3R6sBLtFAM/95GLrj2njGL0VfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5h5T4IU3br4tjynPxsRt1tHoNo/WXSTlq7PBAhS2BE=;
 b=fs8sO65G1y2HnczhxmyPLh9IVzUJX7e9BXbVsGeoEq1QD7Vzmq4NVypBjSRY1rSDK4SuXhW7/jI+U/g+yxTAQgTxGCC1wL4D6Xeubn4E7gvN+orrcy/2j6ETtCc5N/XGJDMFDq0SNFD9Rz2x3WhLJSeO6BtnVzhgTIqTg6FatlPue6yestCIsiVEAvg13OBtcgJ/XXn4225+yzdcFniTTy01oCCg3DHuaHZFMcYAgzmzZ8TVVO8BJLJc+LPfNa4NXsbKuTy/7jjUk2bO0xFumfoo9hM2aaIJ2G7dNXtx/VcyYDBmqf7+jtARlWXvgGEeWIB9iyCWzblkHb8K6uG/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5h5T4IU3br4tjynPxsRt1tHoNo/WXSTlq7PBAhS2BE=;
 b=kNTIjP8ulSEjZ2zzaIOvCKmDwTVbB4IVkgKjtN2EAzB142WBkVxmODiiwjy93M9EV/DL39pOsHkJ4oXDB2jOvGjwM6sxsx4HFLSOJeRlMAznhSRhGDqPD/RJFqtXvnO7SvLmbACtVoqqZOFtrhgWuRmkh0PPJEIkNOSfHkmFotA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 01:50:50 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 01:50:50 +0000
Date: Wed, 9 Apr 2025 10:50:42 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v3 3/8] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <Z_XScomDqU_Dke17@harry>
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
 <20250317-slub-percpu-caches-v3-3-9d9884d8b643@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-slub-percpu-caches-v3-3-9d9884d8b643@suse.cz>
X-ClientProxiedBy: SL2PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:100:55::23) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB4752:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b087a95-2fe6-4a66-fa36-08dd7708f470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0JDNDJ9P43rgI5S7dew/CqnKZF6p/Xr8Od6YN31RupOELFsGcRs/AY0JK1zA?=
 =?us-ascii?Q?luH6GOvkZkyMtb+vvsUia15mJGEPp7T6Opf8NXnwAubo2fWmXcRTZAEFGhC6?=
 =?us-ascii?Q?OuZXVYhe29AltXfSF34X42lxtgScES3w+txiLu1pkS5SztJcJ+4OFovI0L9O?=
 =?us-ascii?Q?+9/+7yfz0cr6lNUMOAtp5xs32sD2/CKbcOXQHIs5NsWg64AHuTIwo8mHNCIc?=
 =?us-ascii?Q?eyPuvfo4iCnNy/FaWxyJ2OujbtcuwsiFeIkfXal4owAuZH4Skv+x5SiUzqGq?=
 =?us-ascii?Q?UgZdt4pC6sERF4INj56B4Q0H+zEzvo07byL8Acmcv5qGAdkdvLm+rrUB/GCN?=
 =?us-ascii?Q?QVOk24PkQrVscaWKdN8biU7LnBQGPRJ4VHBHxrl7kJ1MC0/dZ27ZtW2ahiIM?=
 =?us-ascii?Q?FLa0emCzW5rnQU/qezy4COb1nieVWIUFUtY4Z2cjNEb/u05f8m6kpUPqtJ5W?=
 =?us-ascii?Q?eKVbg6LsmL4rW1QucAn21M77wvMZ2wjT5dLXmCCvs5Tzc2XdYpLdaA0sXiUT?=
 =?us-ascii?Q?SQSOCIIBPfIDDCBvvMX958oblwjFp4XCD0vTjx5NARykGGYaohjweU6XjP+e?=
 =?us-ascii?Q?yFDb+ErWbN1ZsJOjgXEAMAvlvKB/1DmsgVtdP/FI6Dcp8XiHc0wQ0R+c3+MN?=
 =?us-ascii?Q?I5uJrP9/TENnkHaBjiTRDUUC3baibAsv845t3O7fncGbaQE2IHEcpOIENdzo?=
 =?us-ascii?Q?lcmLbjjniGY6aMpLInf9+/1ExucwF1Hk7d08om7ZFDupSIDaYi86dOhJqd15?=
 =?us-ascii?Q?L5QPO3P9HHF/BR4JS1LcxEdYNZIgXYZiM/vJYsp7PcR/oiJXencCaip/HFAC?=
 =?us-ascii?Q?b6R/KHtfrI7Hcp5NjPOueo0DsgCCiviqLCD3Og09CnD5C2PvQfzzadDcTX97?=
 =?us-ascii?Q?i24BpIUR9eE04ovmvxV1TUa/2Z2x4IerzjZr5L/YVqGsqzFpHsmpPlkS9KoU?=
 =?us-ascii?Q?J3dfijEcV6Vee5DlMSyGnxC4mVj5Y3sUCykk3MwChiEgrxifwNJh+w0tI1qv?=
 =?us-ascii?Q?hyGRFs9HM54IZhEDpIpwi5ZtIQHOUqF2TsKvmR+aSS5u1kuH5lYI6P9Q/t4u?=
 =?us-ascii?Q?oQqFvoYKkxhD942b3Sb2znv3Mzpirv42V/5hySsfC4kGj3CivIazp+Wd9+Wt?=
 =?us-ascii?Q?vlU36lHe8imb8yav7Qe2O/k/OCYAtRA6F7bSyhD6nQvfTcE026aE9jvzkzKc?=
 =?us-ascii?Q?+hCuPlGd5z05g/29SliaPt4XdF48X+/YW2ii9alps0d5A/DR1isQo3GmcV8i?=
 =?us-ascii?Q?CdPJePQ4ZUStrjyG2F3wLyqutmDUIkCiqYkzG1exPPglU+rxNPT6gWI3NgxQ?=
 =?us-ascii?Q?JCf4uzDxf2pOewbEF7eoXmJPADpKsKH6iSZ/p9K7aKYvP5qXuUrdUQ7OR9GM?=
 =?us-ascii?Q?YvoP6zH9zc1lXR2EpACujQDFtk2B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6MizkdL+zibvvZzYi+gB0IuM4PgRSDnBMVAGEY3ZNN2Ha/z8q3Q6qVLc62y4?=
 =?us-ascii?Q?UZVSgiejQIpjxh6pW5Wg0Bt1f6pIYgmBtsIXUPUEa/ShlLwDfn31LkGRxufz?=
 =?us-ascii?Q?XxPsM5wC0v81S3MFU9p5b03KpPUBLR+/KM6piM4bpC9bQo1uHM00GF3BCNSM?=
 =?us-ascii?Q?UWYpdD6DXMLCSfszHqR2ftPlrv5aAH9yM20VQu5vp6fLCmnJlczZWno8A59Y?=
 =?us-ascii?Q?/kwJwPv8lIcYXdF9cJDFnLjYkI+AIStIs8Xu9W5mlI6vVM290IQF4KaJJCLS?=
 =?us-ascii?Q?dTQS0ZFHRY4ti9J93vPCyiCFzTYQ6zKPk877efkD6D/J+Cav8UCLinlg5Y64?=
 =?us-ascii?Q?tMUUq6Ussjs7ip/X49gwAk7Lre4+5JjXyF2gWi3gJDU2IJ2WJtFR+Enj5HWm?=
 =?us-ascii?Q?mTtmFEixfA9Y5kAuHYZWcog+w/+eu/MDB5ssDNILArDQtqw1VizvgZUptiln?=
 =?us-ascii?Q?HDa4dsN+AvEJletUph6ova4ls4Q1QS27PXnBwTWFO9WbubMNBHEppB4MnCCz?=
 =?us-ascii?Q?1RfZsKKmWqxXUhZV/6hgYF+vrnIUk82ZNlM958CkD8xhY7sR0XnHSeEYHCCs?=
 =?us-ascii?Q?3qA6wsVOYrrKgHgedq//PnyL0VrWYRIQ3O9B/lNGzueVxjQrgggGomri8OMq?=
 =?us-ascii?Q?R0P3rD0pGCTPFAOn/uHWwedoZEeCH+7JmxPw4Ovu8ERHNTSsXFvUj4pN5UQ5?=
 =?us-ascii?Q?G05Tf3FZzf/+dc3gWZjFRns9gb3Y56+x1d2pEDtPz0t2cK/6ny7+melFofA3?=
 =?us-ascii?Q?03Vc7Xc+Hgsb2bzlIbHfGX6KE43o2d0sA5KQizPTQFJcIZiq9HcuhRw3qvK1?=
 =?us-ascii?Q?hm0hU8qXyiTRrn96Beq/FS6lqUJDoe39w+jqZb4FoHYScqzC8a6Q37k+o0vS?=
 =?us-ascii?Q?uoRVVV7RyHbjt61JiZmT8/dygF98Km3UCnVyJEfwbdLL18wME8pJaAiMZUss?=
 =?us-ascii?Q?WrK+uw22itEEubjFLA9lDbZNxD24k8R2FsjeQmI4M1qLYw0J7UGPRvzU6Mdz?=
 =?us-ascii?Q?ePP8VDOxggFIPYiV0zx+aa6T9pysjvj8ggjRV7T4oj34g6aLmVj9m3OtH4fR?=
 =?us-ascii?Q?XFEvCqhbnKT2A+CKmlyyYvQdn6EiKHsQEHSR3McDXyOl/tUszhinrsNuk5Fn?=
 =?us-ascii?Q?YHfvnTxTwY9hz374Gm42HMz4RiScNvvlncuzyr2oDpPk5dUrFdlead0UK3ea?=
 =?us-ascii?Q?DvFQWQnKCVROskLTEgq7yjBOzXZGRsbTD8ndKJZkj6UaDy+6LRF4JVHbG1v5?=
 =?us-ascii?Q?StS68ygnbFfL8/iZY9ydaHnwh24WwpAC5Vhe1fLK1f7BpM9KX1GXw6m6qzV0?=
 =?us-ascii?Q?VlWgCTEyvRuBqRo+SsmTxolQ1GOBmjmgPn1Uxte99FTxZwh4Uhk5FgZVQVY9?=
 =?us-ascii?Q?BefT68HG27U2VijpfMy6vM+G6uaP0GJHsIhw+Qi+R25/ox1ZNGlXZ5kr0Dw/?=
 =?us-ascii?Q?5jIaBi0EpWtXne34VyH+QhwIdWyT9APkzIQH2TCpzBgmQn9t0U0RvggzC9o0?=
 =?us-ascii?Q?lm2i/7gsZFnqUbpBM0KEreQDXPs5GOlt3CgDmPrhs83Tpn2OmozTKzM943cT?=
 =?us-ascii?Q?3iznzbTLh6sYH8R3zeRUJYbUyTMDmLGNWbewv2C4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CQuFHqVCpSYSciwcmrjLc0EcgC8iPbhfItTNZhNCpJEHfxq/M0DEmJP//d738+tC/JrS9JaWc7Y3jZizSSog/wfmfUVhphSneNGs0JqLBNxc2R3SMG2EZoXlU/h0iImPrsjeFTqVp7oxRIGJX225pzEJMUwUfTQ2nq5PC5/0KrFrGxZlp9zlAHVoMcXv6xSvX5vV3bBdX7sa4LKyhfy9k754Mws0r7Q6ZEdUFJnfVsntaABTE4lMjypk36Bw0APtP7xmkbNDr8sUU+W+eszmrv6LiTBJIYhkznh7BAfLjvxhukINs91ifJxEoHcQjam9K7ak00kN5leT/BpgcUk8UaItwtD0VqvjrpuQJ/4aP2OnrxVdNm+rczNF4WSEb43WxabA0VPBxndn7+v4mHccKSYDR9mwltiiSXa5aN/HI7AzAAykc9NL1aoudWwMyGQpXZdyp/MfNot3/vUQlcXMCrG1p/xFP7Ywcg9vaIY63Yk5zIKRXUXxboE3mjkUFoDDcpzFDZcpT8/5JncqdZ7olUdKC1WjStZHjHkRCuIRf7CLfau/npRmLkAH+5yG0golujbnhSpJNYJRtaIFWbnazTsXtx/zDo9vfDOckIhU1oU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b087a95-2fe6-4a66-fa36-08dd7708f470
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 01:50:50.5510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwmePSmZAFGAM6vX2x+gWnA8gM4XMtj3QX3JsG+3e9ShdhAwljIHLpZPxM/QuyrdMr/5MnYVbXKQQ4PNljTu8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504090002
X-Proofpoint-ORIG-GUID: EVCsr9jcYJE6NfzQbCN9Ku1SubexngwC
X-Proofpoint-GUID: EVCsr9jcYJE6NfzQbCN9Ku1SubexngwC

On Mon, Mar 17, 2025 at 03:33:04PM +0100, Vlastimil Babka wrote:
> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> addition to main and spare sheaves.
> 
> kfree_rcu() operations will try to put objects on this sheaf. Once full,
> the sheaf is detached and submitted to call_rcu() with a handler that
> will try to put it in the barn, or flush to slab pages using bulk free,
> when the barn is full. Then a new empty sheaf must be obtained to put
> more objects there.
> 
> It's possible that no free sheaves are available to use for a new
> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
> kfree_rcu() machinery.
> 
> Expected advantages:
> - batching the kfree_rcu() operations, that could eventually replace the
>   existing batching
> - sheaves can be reused for allocations via barn instead of being
>   flushed to slabs, which is more efficient
>   - this includes cases where only some cpus are allowed to process rcu
>     callbacks (Android)
> 
> Possible disadvantage:
> - objects might be waiting for more than their grace period (it is
>   determined by the last object freed into the sheaf), increasing memory
>   usage - but the existing batching does that too?
> 
> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> implementation favors smaller memory footprint over performance.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/slab.h        |   2 +
>  mm/slab_common.c |  24 ++++++++
>  mm/slub.c        | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 189 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 8daaec53b6ecfc44171191d421adb12e5cba2c58..94e9959e1aefa350d3d74e3f5309fde7a5cf2ec8 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -459,6 +459,8 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
>  }
>  
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
> +
>  /* Legal flag mask for kmem_cache_create(), for various configurations */
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>  			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index ceeefb287899a82f30ad79b403556001c1860311..9496176770ed47491e01ed78e060a74771d5541e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1957,6 +1978,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	if (!head)
>  		might_sleep();
>  
> +	if (kfree_rcu_sheaf(ptr))
> +		return;
> +
>  	// Queue the object but don't yet schedule the batch.
>  	if (debug_rcu_head_queue(ptr)) {
>  		// Probable double kfree_rcu(), just leak.
> diff --git a/mm/slub.c b/mm/slub.c
> index fa3a6329713a9f45b189f27d4b1b334b54589c38..83f4395267dccfbc144920baa7d0a85a27fbb1b4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -350,6 +350,8 @@ enum stat_item {
>  	ALLOC_FASTPATH,		/* Allocation from cpu slab */
>  	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
>  	FREE_PCS,		/* Free to percpu sheaf */
> +	FREE_RCU_SHEAF,		/* Free to rcu_free sheaf */
> +	FREE_RCU_SHEAF_FAIL,	/* Failed to free to a rcu_free sheaf */
>  	FREE_FASTPATH,		/* Free to cpu slab */
>  	FREE_SLOWPATH,		/* Freeing not to cpu slab */
>  	FREE_FROZEN,		/* Freeing to frozen slab */
> @@ -442,6 +444,7 @@ struct slab_sheaf {
>  		struct rcu_head rcu_head;
>  		struct list_head barn_list;
>  	};
> +	struct kmem_cache *cache;
>  	unsigned int size;
>  	void *objects[];
>  };
> @@ -450,6 +453,7 @@ struct slub_percpu_sheaves {
>  	localtry_lock_t lock;
>  	struct slab_sheaf *main; /* never NULL when unlocked */
>  	struct slab_sheaf *spare; /* empty or full, may be NULL */
> +	struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
>  	struct node_barn *barn;
>  };
>  
> @@ -2597,7 +2621,7 @@ static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
>  static void pcs_flush_all(struct kmem_cache *s)
>  {
>  	struct slub_percpu_sheaves *pcs;
> -	struct slab_sheaf *spare;
> +	struct slab_sheaf *spare, *rcu_free;
>  
>  	localtry_lock(&s->cpu_sheaves->lock);
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
> @@ -2605,6 +2629,9 @@ static void pcs_flush_all(struct kmem_cache *s)
>  	spare = pcs->spare;
>  	pcs->spare = NULL;
>  
> +	rcu_free = pcs->rcu_free;
> +	pcs->rcu_free = NULL;
> +
>  	localtry_unlock(&s->cpu_sheaves->lock);

Hmm this hunk in v3 is fine, but on your slub-percpu-shaves-v4r0 branch
it's calling local_unlock() twice. Probably a rebase error?

Otherwise looks good to me.

When you address this, please feel free to add:

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Thanks!

-- 
Cheers,
Harry / Hyeonggon
