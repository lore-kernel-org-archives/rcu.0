Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B210F2;
	Tue, 25 Feb 2025 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468675; cv=fail; b=XLj2WYoLYmmugwBhJpkgpVN+HdF+5Y69rAt8+bIGo+yAiKzSqZ0ttIQpNgFOl8Ey1dJvDe5CPycpZamtojH9KHQBHPojuADgC2qpMYvlGlLFTLYljG80d/bRhYcB8oZ1lH8AiCMHGzzKb9hOnqCRAKqDFdaz6bw0zaR+Z2BFM24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468675; c=relaxed/simple;
	bh=NDhptx41Qm3Lhla6ZIHmmCyFdYX7hWFZ1nmPNkypTAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c7NywFgQelBYRxr73jTsui/pAYUuHIz/EH2YGXkipuKP6N+2NajPJBg9eF78DyJYYNTB2+mhe8Mnd6hof82wLNNIsnkfu6hHQJ8IM51MWTLMzbqYQUNlMNnyFr/GwlFweL2UO21dh1pn12TWYI4VJ50nNMJNvIorpb6zxvRB1Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ya7Y7LKE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nKo5AjIO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ya7Y7LKE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nKo5AjIO"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BerH001575;
	Tue, 25 Feb 2025 07:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MmrqLJobJOiCEwD0mfJztSMaL/e28YOmZb9aIoHLVGM=; b=
	Ya7Y7LKEsmFne4KgFr1LCSNdaSrSHJGwYbMSoYXv3JBj8FoRILHUQ2NoSU91n5Os
	TYWsaDD92lrnyWnSRcS97YFnfwaTbJQQwVJZee2ThnGMGSx29IH+arDMXLHNb88Z
	Vf1xn+icosq11hcHFkAYfi70QhuTq1LAPw2/IIMuQFGPHizxPpCU7KcvEbFkdnNU
	Ei1M0JtGbSNUk/zAOaGlv1iJHT1XATiFZ6/qN6Z5Y7WjM0aDYJFslltPQKwAiJPI
	cieyxgKwCDq17QXGtVSYyG1aDivyVb4RhDgTDdRXokE5RJQBrPJVlM6N5C5b3enm
	ZsCM8q/HJRuc/lFHpXGZ0A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5604dts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 07:30:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P6M4YE007366;
	Tue, 25 Feb 2025 07:30:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51et9th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 07:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6nDITFYf97XgWLfzuFH+oX60xpdZ1qPUyjsEaxf6YymwotUttCxuSGC+h+LcIUGDDI8aJZhnkKLx9fhTbrkuVkbP64fYBbZbR1+q1ynqusH96wVcjcIQXKCxWghAns86TgVRWPc+LFx5M/oJjTbsAnm2y2GQTRysOhzo6V3u01GPuXENLjSSQ09JLT10ENWTh+UPIPbXNDyiVDDwM9/M5nTiiq9UM3CztuEZ/g/JfXyaq3gC6YFI4O0hujrHKbGEBEHUVv5nyrVGCLKHRLCCsk1mHnjoKQ25o+g3oPT+Vsx4buzW11uPwF6J7P8nJT2b8/vPXCYl9iFqKMW6CLwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmrqLJobJOiCEwD0mfJztSMaL/e28YOmZb9aIoHLVGM=;
 b=b/LsIvYfvba6M7J82MlEULnckhBloH+suggxik1XoKXGsfT0eF8cuSrtXDs/ji8mun3fycl0byUN4KPDp4eq19l3/aIwGd9lSj1/D+vgHPdMg7z6SCyybaVC47CX6nec1oj45qMJroWm6KSFnU0o/EPhHbekTH7GjIl8KGFcc+Sd8CZyLYy45RFXPR9lsi96JkZf4MGLnHgs852KruwSGq1gtJMCTn24ZtjwuiqOOfaABvb1RNLF0j0+xfg5JiDgpqCxvodtDZ0lqkmkJAMqc/Op/ZZooe2Qu/hWw09xxfPDm6r2yBsh3t68QG/mlO3qnWpBUchO+y19bRq/G4bf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmrqLJobJOiCEwD0mfJztSMaL/e28YOmZb9aIoHLVGM=;
 b=nKo5AjIOD0tet/55//fTLcQhn6KFnLMO14zaJDICYEgaS0a4y0NpImozWR6L2BN0300poVxbykoziHG+Tz/UtJZXQ3u1nsEcWPO7cso+qg5vV5R7SLBonsRwarF6/hn/Mw7ri5dUtABDLXBVO7mhcoXxa+3nm7sPVjApCcNJlYo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB8126.namprd10.prod.outlook.com (2603:10b6:8:1fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 07:30:48 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 07:30:48 +0000
Date: Tue, 25 Feb 2025 16:30:39 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 06/10] slab: sheaf prefilling for guaranteed
 allocations
Message-ID: <Z71xn1EPz32nF0St@harry>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-6-88592ee0966a@suse.cz>
 <CAJuCfpEBqfhaCQnZFKFkNRhXe0z1k0ZBTDw5BXr=Zu9_s0TfkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEBqfhaCQnZFKFkNRhXe0z1k0ZBTDw5BXr=Zu9_s0TfkQ@mail.gmail.com>
X-ClientProxiedBy: SL2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::32) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c88462-40d7-4209-c317-08dd556e528b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjFGRGNRVzZaNWVzeXdjMTcwcVBRQ08xWHZQbDdzWmc1emYrazBNeGJQUTZG?=
 =?utf-8?B?VlR5UUlWQ29QVGZ4cFRHWitsS0xRL3pGR1hVaFIwVUdaUStseHBhdUpyYTZq?=
 =?utf-8?B?SG9qbjdnajRjeE1jTE12ajVvSzVXbzdmQklRVDdRam85d2Z2dnZiKytFSmhT?=
 =?utf-8?B?R1hPbElBUzgrdDlNamxIY0RickI5SmFVei91UHlIby9SelI5eXJacDhuR2du?=
 =?utf-8?B?V1NOSUhkSDYzVTZlL2dQcUZVdElpTXUzMkFySFBQaFJob05yR0d6QXY1MG13?=
 =?utf-8?B?UlM5MUVnbFAzL0M1cDFkMnJiL2ZLTWU2a1ZmNytFNCtCdWxCVzhiWDY3VGU1?=
 =?utf-8?B?TFpXRTZuZjBmQXhjL2IveXFxRU1GZk5BclhJbEh3dTZrOFdhUVRCazIxdG1X?=
 =?utf-8?B?Mzg5bHNDMko2QzFlNlhHNi84cERKSmlRVVRzdXQrd1BSTDgvcUFtaS91Q2Jt?=
 =?utf-8?B?SGVjUjFodjJRdnFxQkdMeXpBQmRMdEVucWluVmw1KzNxYlZON05IMDZYdXgv?=
 =?utf-8?B?OGhXNmg4M1pRbHM3NWp3Zk8rUlAyNU5QcXVIWkljV0hkNmd3TmhvUUthbjNI?=
 =?utf-8?B?a05GMzVQNng5V0NpSHB1UGpkOGlzK09zdlN0SEQ3Z3NDZ2hvMDhyOXFmcG5V?=
 =?utf-8?B?Y3NJTVYxQWRYRUlBelN1U2tyaDhoSTBjV0pacHB6VTFxTGw0aE1CTEJ4d1k2?=
 =?utf-8?B?MFJZaWlhczdkajZDYlV3SVpLREliVzdxaWVoRWMwTHBUSFAwSktONnhMc2ly?=
 =?utf-8?B?NVJLaWdsK2d5elVyWnF0YkFNYjlkVStNbjR4NGVBOW9OSGMyWVEyb09ldU15?=
 =?utf-8?B?NTdVdDV1M016N3dJOERCMmI3bXFKTkVleEg2dnB4aEV3MzdyUW1hdW84NnVO?=
 =?utf-8?B?aEJSRGdPUmFTV05HUjlxRTFobUVEajlrKzlDc1JkK3BsWTlvUEFNOUFmaFdx?=
 =?utf-8?B?YUFqMThCR0pZNVM3cEJONVI0V1BWeEdEajBDOWFrb2NUaXhTaVlIbG93ZlFo?=
 =?utf-8?B?a2R5cjFNUmd1Nm81c1Q4dnIxWW5rR0RjRStVa0EvMG1HR2FzQldPbERrTTQ2?=
 =?utf-8?B?alBWcngrSXdObEhKdVVsMVAyQmRScURxVlVBdEgzNXM2QkhzN2h4RHJRUjA2?=
 =?utf-8?B?MzJuay9vSXNid1JzL3A1UjJ1bXJCanIyYjJySkExQzlYekRqT05LVXFUMzlx?=
 =?utf-8?B?S3RtbXZ1MmJ4QzFlbjFUem5wdWJpYzZBRmxtZHo4eGRYRTRRRXZNZlozUUpa?=
 =?utf-8?B?WHd1YnJkVkFOWEZnd1gvTitNcDNGYitCVDBEMVQ5SHdGdmRTaEVuTFlmREsy?=
 =?utf-8?B?OE4yU0RTaENzVmhzQXlZSGNjN2tWT1Y2WVlKRjZzd202ejcwbFdlMTgwYzJU?=
 =?utf-8?B?Q3dTMVlMSUpDMW1FSTdyR2NUbis3QVExaWZScDNNbktNSWsrRm1lN1RZRnh5?=
 =?utf-8?B?SS9zaHE5R2dHSkVxc2tzeHhDcHhLWjdyZGtvZkRiVUJoVUkzUTdTRVdNTEUr?=
 =?utf-8?B?Y3hwT3kyeG16L2dIU29VaUpQWHUwYzBycm1xbG5aMjJuc1ZZcU5PR0JLT3Nn?=
 =?utf-8?B?OW1GdWREMDVkRVRhQ3ZWdjcvektvYm9NSEhiczlYRTU5UlZVRzBjUWxPRkdP?=
 =?utf-8?B?QVFwNEwxeUZQVkczV1VJaUZZQklKb1ZJVEgxTm5FMXY3S1ZhdDlRV3ZnY0FO?=
 =?utf-8?B?Zm9JcDlHUUV3YVhZajgwNUd5d3dWWDRkNjMzbFZyS2lLcjhncElEUWEyMGpj?=
 =?utf-8?B?Ukd4OXVST1QwUzFZcWdsVGtZZys0T2lXekwxM1VBajJiWWNZUXg3SXRjRDZH?=
 =?utf-8?B?aUwrU2VCZFpYbGFjMVBGblZkclR0SmxXdUoxcjBoWThnTndXZ3ozVXpHbGdq?=
 =?utf-8?Q?aNfjG/OepcR/1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGpWT1RURmdOL09hb0h3VTQvcmcxMHRLelZvenlGYjAyVy82OUp3VkdVQkpJ?=
 =?utf-8?B?RVIxUy8zTEl5cVJMSHZzNDB0TWZpNVpHdTZ6VWQ2bTB2L3owWFRETVZXSEVW?=
 =?utf-8?B?NmQ0cW1pSzgvUHg5Q0R2dEFycXBBS0RTMklQRGJBclMzSWx2T09ha2pjUEZR?=
 =?utf-8?B?eXNXQTVZUHg1Yy9DbWZvZHpQQmN2OS8wVko2c3BTQUx2UkZRVHBsTGtUeExi?=
 =?utf-8?B?QlhiNXFQOGNFZzh0c2FtMmJXdk9wUGhWT3A2aDlydGllNi9hMFJQd1ZzbTVy?=
 =?utf-8?B?dXJWdkY2NzR3V1JCOVRmdzM2TTUwWERzZjVTKytBdW1YZmF5YnM5eElJQnoy?=
 =?utf-8?B?WTV1V1JYYmxsL0E0MjJKZE5iT29IZ3NkV2JDbVBmTGNYdnR3MVFPY3c1MDdv?=
 =?utf-8?B?LzIxZFcrczhVQ0xiSFFQUzJ5aHhuTTBoeDFiWCs3RU14NmxwWDE5S3JLOHJE?=
 =?utf-8?B?MzBxdy9yMkRtTWJOQk5FS2NUYVNuc2J0RjRKb2ZDQ3NPSWNyS083RG5Lb1FH?=
 =?utf-8?B?djZpVVJYTEdWWTczY3d4dzFxd1lXTVdZZDQ2eDhtNDRCeEJJMDVZK3hUcEhC?=
 =?utf-8?B?dFloTzI5WE5wQjVlMXg4R2QwNW9lMTZ4VndDVGdRWDlsT1pibDF4d3pBV2Vh?=
 =?utf-8?B?OVp1a2RQZExmeGovZ0l5ejF5ZFZXQU8xdllKb2p1WFR2NzEvNTgzaWo4clZD?=
 =?utf-8?B?SGZBSUhodXYwYjNnWElremFQbWFwS0szbzl5dGNheUhvaFd6aWV5RXZEQ011?=
 =?utf-8?B?QklJZFRoVm1Ydm1OK2t3bFdhbitBaFBYbzFQakJtVWlvM0NWNCswZGJ2L1dB?=
 =?utf-8?B?NWMwRC8zWldndkU1OFBuMGlrMzUzK2NKaS9rYWxRVzc0WmhJQW5QZUR3aFBK?=
 =?utf-8?B?Y0svL0pXZSthUkFLWjBLbHVXeGxlRnBZRDhMUW4vYnF0ZThjMUhZR1g2WmJx?=
 =?utf-8?B?T3Vpelh0aFEvaDRwUmdVK21CYzhZZEpNejJrdks5bGM2d0lqc2FXdkQ2UzJy?=
 =?utf-8?B?eGNRNEdSUzdxVWtWaVVsTHB2bTI1Zmg4T3J4ZVRmdEdYejVlcmp4MUdJU3pq?=
 =?utf-8?B?RHo5eVNZNWU2dUNBVUNxRzhmY0hNNHl3RWQyL3d0L05OUFhvdGw1N3RxMmx1?=
 =?utf-8?B?Ukl6WHBMRWhPSUxvcTZVSlVMQmdHWDdHM3I5WloyeUlBc0VDK3VJWnc4QTIv?=
 =?utf-8?B?SEVRYXFsTjY5VGI1eFpCTkMzb2pobmRSSXlmL25xTzdDbHBnOS9uNGd6SHkx?=
 =?utf-8?B?UEJZSkFNQ3E5czJaVUYwYVNBZUZZM3dCTlZmb0JJWFd5cGpwTEl5NFBkZVQ1?=
 =?utf-8?B?NDRlWUpoNDRJZE9BYVdnVm42RTZzSkU2eUlkM0hZZ0Q5NkwxZW1nZVFETEtQ?=
 =?utf-8?B?VXpUM3Y5S0lid3l2eUlTWjRRTWYrUjZRZ0pUZ3lHLytSLzdyYnBsb2hhQU9E?=
 =?utf-8?B?RjA1UGlRSUNMdG5oTXkxT0tlN2YwSkhhS3FyclFpR3dGQ255anZBekExSnFG?=
 =?utf-8?B?bDZOMTltSFZkUTVSanhHazFld0xpNU84c0RoRS8yRTFrRGx1L0hMVmNkTkxG?=
 =?utf-8?B?ejYrTm84RkViMmE1MTA0VW5oUS8vQWNGYXdQWkdxdlBlM1k1RDdTcnNvRVlI?=
 =?utf-8?B?cnlyMUpoN3BwdWdoOVNuT015dVNLbVhNYjBoSlhEUUhWTVd5MTZhQktZQVpi?=
 =?utf-8?B?dzJ2a2FuQTJlOXFDSTVuZ3QreWRRU2QzT1hpamRLMDgyd1FQb3RML3I5cVlh?=
 =?utf-8?B?TTJOKzJwVG94eWxYNUlrWkxRUFd4aXRUSWlBTGFTSkJIc0piUTlJZzNPZXoy?=
 =?utf-8?B?TmdURTVIMEJaWUFmeUJvcStLdE1KM2lldmQzVnlDUkVMbWo0RWlJcUpaajhD?=
 =?utf-8?B?SC9XTG9TL2dTQXRvMisrNGxlcXhVaEdSUi9rSjBsUWJvQmo0aXJLMWhJQlU3?=
 =?utf-8?B?M29EUThBSGNCTkRRazlqM2UzeGpzQzdSOVptdXhBaDcxUUtHR0JSamRmb0tv?=
 =?utf-8?B?Njc3cE1IWnJ1N2FJRDZPTFNsVjBGc2dkVTBUaUNEclNHV0hMZVNiZ0NtT3lL?=
 =?utf-8?B?MCt3anlCS3I4dGpXNHlQNnRDNFAySVBCejBGRzc5VmdaODlERVM0czV4V0c3?=
 =?utf-8?Q?C+2brFoDbaVziSBwT9a+jYAwZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WVTrfZuecFJ5Er1nsYH9KJVQIPHgUJGJOrXXPxqViyYusC7WtTy0XRV5QYiFM8TGggLv6ALz/QE+MNtlxiC3TZKFNNgnlqoB73de6TFPwa9Pn4TO1kvlzl9/fyEV0AaAvOB4OM9uqLUJz3XGSoCuaP867U/YASuLk4aG7AYn5ZlVPkvP0FqnxhTto6wgkZxwWmWfGzaVC1sAZDljUwRPwjg6dhxZkBIvj3jImkjSylrPcKOavitJLMVpZZfnulT06BI8NI3newX6ZyLJ5/Z2ONrCbflc5EPYMr3UFWhoBaq8sXLmeMMG+oH3L/xKMWAaC3yu0NAC1TTHEFGoWws+MhGEBVnsZzzzizfWQTKZHD8YAOniH6qnwr/URRCgADJvxw8zrlhQETi1MJJMBrg0j8ziWjrQu5S3Sn9gis6nhmegOBDG1IanC64IPEAltvURHxCUc4PMHLQsfVer+vUkDj+2u8adYiPgKUxcg9Pz1N5vIlFmklHBeIQG8SdLOJRLtXj/atxe9mj4K1A5sV5vjEXX6CJnO1wrzbwckAZ911i8fVfr8Qc49GNbljfdpVz3Cih4cex0nmHPms4wiepr0aqdZwZerPoCzte5D1oRlB4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c88462-40d7-4209-c317-08dd556e528b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 07:30:47.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HODpWtj+4cIb6PNU1oiIFP+yj9UKwXUELlsbH+0GYNdThc/BU/8CaqgzbkwndqmXYGe8v+ZCM/wd17iRuqaSzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250049
X-Proofpoint-GUID: agbu93DQX77ycyfkWBK7PXw6-4PPluQQ
X-Proofpoint-ORIG-GUID: agbu93DQX77ycyfkWBK7PXw6-4PPluQQ

On Sat, Feb 22, 2025 at 07:54:16PM -0800, Suren Baghdasaryan wrote:
> On Fri, Feb 14, 2025 at 8:27 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > Add functions for efficient guaranteed allocations e.g. in a critical
> > section that cannot sleep, when the exact number of allocations is not
> > known beforehand, but an upper limit can be calculated.
> >
> > kmem_cache_prefill_sheaf() returns a sheaf containing at least given
> > number of objects.
> >
> > kmem_cache_alloc_from_sheaf() will allocate an object from the sheaf
> > and is guaranteed not to fail until depleted.
> >
> > kmem_cache_return_sheaf() is for giving the sheaf back to the slab
> > allocator after the critical section. This will also attempt to refill
> > it to cache's sheaf capacity for better efficiency of sheaves handling,
> > but it's not stricly necessary to succeed.
> >
> > kmem_cache_refill_sheaf() can be used to refill a previously obtained
> > sheaf to requested size. If the current size is sufficient, it does
> > nothing. If the requested size exceeds cache's sheaf_capacity and the
> > sheaf's current capacity, the sheaf will be replaced with a new one,
> > hence the indirect pointer parameter.
> >
> > kmem_cache_sheaf_size() can be used to query the current size.
> >
> > The implementation supports requesting sizes that exceed cache's
> > sheaf_capacity, but it is not efficient - such sheaves are allocated
> > fresh in kmem_cache_prefill_sheaf() and flushed and freed immediately by
> > kmem_cache_return_sheaf(). kmem_cache_refill_sheaf() might be expecially
> 
> s/expecially/especially
> 
> > ineffective when replacing a sheaf with a new one of a larger capacity.
> > It is therefore better to size cache's sheaf_capacity accordingly.
> 
> If support for sizes exceeding sheaf_capacity adds much complexity
> with no performance benefits, I think it would be ok not to support
> them at all. Users know the capacity of a particular kmem_cache, so
> they can use this API only when their needs are within sheaf_capacity,
> otherwise either size the sheaf appropriately or use slab bulk
> allocation.

At least for maple tree, I think the reason why it support varying size
(that may exceed sheaf_capacity) of sheaves is because the upper limit depends
on the store operation maple tree is going to perform, and height of a maple
tree?

Or can we set a single maximum sheaf capacity that works for any
store operation and any height of maple trees?

Liam may have an opinion on it...

> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

-- 
Cheers,
Harry
