Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB6330D54;
	Fri, 13 Feb 2026 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983796; cv=fail; b=mwYRuwwkeXc64STIpKaF/eOp+HpNQ0rBqFncbpXoL71cqfkwdKTR2gL3xTvZKHJ2U3HTl+umT9dVizPPAvqZP1xUaMuPg6Pve7Sjs/i7yrWQg2MUdCST1lejS9oq34/aPd6aqmlZ40KOVh8v9dqEdYDWsUDLxa0pfy1lGiV1+PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983796; c=relaxed/simple;
	bh=MjM91KQPEt9sjLrzO+npm3Z4nivDox7F7kvfgMaUycE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YSJ3HlvX9HxQzrmHaUc9EzENJx6BrfouCtgntFdbHOx2+RR9nLkV0dMtpldSvWgeT/Cfm9u4gjujLoOpIJHiWwJPNkF9LuyaWYLkm4EGcUgfph5XeXMufWqeqaX5E2XnSbaDft+81ZvPk+cKgYhWoeRXlXqLWsuWDr4reRkTGTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o7RrBMPA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V+8AfOzm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o7RrBMPA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V+8AfOzm"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D6B7Gm594184;
	Fri, 13 Feb 2026 11:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=g3NqcGnuZ5+6V9T6nBisgNGpikspmvyl/GUyx/oWqjs=; b=
	o7RrBMPAAWJLGZudHpig2d5DJPT/55f9VL4UgDDj6fKkxJMb8vUxXeJrW1Vs2vt6
	pKskQfAiIJITGVGWouYoT9/3MX1biWBjBDLzVB8l47DoKSJqY6zq5xCpjE35Kcms
	viKk8JGfpDG8yBw3rIy91NfUxtbwXP3mpoLpxFml4FeGk1nA0EZac1uQdhiY9WGl
	eQ2Z/wzUO1XMas00VC36A7t7mNwRSm9A+5fQWPC3JOK6fcPSdr/VQdknsSOUm+JP
	VQBEM3FcL1n+uLS953vHyQPIniLP8uGqSIbabxC9FNIievbyqW1nQNHUxqJGthBI
	CSoWrT1WqAQOikpOdkjRDw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c88qt530p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 11:55:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61D9mt0E030224;
	Fri, 13 Feb 2026 11:55:53 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c822c85tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 11:55:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjC+MqnCgxDOz3Ev03bTXslGVVg/DZaXzYiUq1snaIreZP2fc1XJ09CQF6e318jDYb69hzqYOleua/2jru11Ke2PEErOOhdRrpb8ZCmeRs+lSfNsZ4eaolrM0bOZcXutivbzFU+qsW8QeRRoxCstUS0165MwaEBGhTNYpiP7yOvPSbxtjsueXrbd7L2Nl+oPqBYZDHuc5lkV0AErxeFBJlgA0iyQxnqfTpUNh8QxDXYiqsEF9H1HT1UYYxpa1ClsdUHSJYUCUA4Zc0pVQucuqJcqjLB4bK/M2Y1Ge34pg/Ul3+A+lNagPtYme79zNvkuhFxq33uc10NLCsv54y5wow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3NqcGnuZ5+6V9T6nBisgNGpikspmvyl/GUyx/oWqjs=;
 b=cL7DfMALd3EQMjc5998GMOUHOry7IcGdPruXlTjfJ+NX2ryJ8W3wVJv66pUZJcnmificj0k5UjIzCcYO1pVuXQnuig0yAX4XGGlYJRDf1Ped5xqBsNBQnQFA6GGAUEULm5Jv/DNQ5PerWAci5My/43nVNKykLo+J4bgr9aeMQzPu/3wRe7sjDaw6cAw/NFvWR+py7CqutYV3meaC2FwBDHcteSYfHhZOpnzVoOSJcsA/XDjC3T58TkbeKsjudl3j8wmdR9UGpLySi6PIgOe4THr2xsxmJNCdCIDE31D2LfNFPGQOBw6Q5Pd+08DQd0HH5yjuANHCMJSK/ZToHzO/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3NqcGnuZ5+6V9T6nBisgNGpikspmvyl/GUyx/oWqjs=;
 b=V+8AfOzmIrfmxuz1WpZSMbLVuT/YS3qnnngoDP5Eiqbbdg+DxdyikE+KyM69M759jmYavIyS6AlNk9hczqcX9vCKocHuRm8iGZ9A+WGJoqcW35eKWXjzNd9XweIoJcqqo5Yh2+ZUW6HgZ3am3GlzPh/IA4dHYSyqvTf3L/n7esM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN6PR10MB7468.namprd10.prod.outlook.com (2603:10b6:208:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 11:55:49 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 11:55:49 +0000
Date: Fri, 13 Feb 2026 20:55:39 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Puranjay Mohan <puranjay@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
        Dave Chinner <david@fromorbit.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 7/7] mm/slab: make kfree_rcu_nolock() work with
 sheaves
Message-ID: <aY8RO5vZeZQyRata@hyeyoo>
References: <20260206093410.160622-1-harry.yoo@oracle.com>
 <20260206093410.160622-8-harry.yoo@oracle.com>
 <CAADnVQKRVD5ZSnEKbZZU7w86gHbGHUug2pvzpgZTngNS+fg4rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKRVD5ZSnEKbZZU7w86gHbGHUug2pvzpgZTngNS+fg4rw@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0009.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN6PR10MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e89d7b7-cf87-48ba-99c4-08de6af6d3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clJnVk1tN2JVbE5JN2lNdzlUK3Y1cW1zSVhleGg5SlhlNGI4WDkvTHRhVWdP?=
 =?utf-8?B?N3lTVjRFUWVMOHZnZmM0WXBTNFBkdWxHRzJzRDJRZHh4QWRxcnRsdlhRQUtW?=
 =?utf-8?B?MkdkaHlKYi9kNlRLMzI0V2lhU2oxOWp5ZjJrZlhKQ25jU0ExWWZPVDJ4am5a?=
 =?utf-8?B?cmVNTWN3a1RHWTFNdWVPMzI2UllsdmxaVVJJS2lXTW9VeXFRVkVNTTY4L05L?=
 =?utf-8?B?eG9JZ1U2NC9raXZJaGt4V0VQTENIUlZ6NENlWE80RThsaXFETlpWWERFdlZS?=
 =?utf-8?B?MVlpV0JNaFlkS1JaSzFVZkxxcC9lZ29VelNNZWlMTzNjVkFkdGovNGQrdnBY?=
 =?utf-8?B?TlZlbW1SeGV4NnZNNVgyWjdqTm8reWVYK0V6OEpwY1ExS3dBV1V4TUJuYXNm?=
 =?utf-8?B?NWlFbW4vUlJycDF1WUM4clp6Nk43dHJLL3gwU3UwSzNXaXFMck5xNFcyamZU?=
 =?utf-8?B?dVBNRFVXNGNYYis1TDBSRzU1R3RUYUVrL0lhMTI1TEwvWU9qMjZkZklMRGZu?=
 =?utf-8?B?TTEyaGZLOEpsMzRBZkNJM2U5aTg3ZnN0cjYrcWJxN0VLZE41R0lkK1I1Q3Er?=
 =?utf-8?B?ck5PODc3UWVMYnpGZ0hjc1E4YkdydmhZR09aTUFENFJxWUZqckxqbWhkMS9p?=
 =?utf-8?B?ZHV4K0g1M2NUaEJSV281MnVrdHhZdFZ4azdQcVU3WlRXNG5CMTBzdjBiQ0FY?=
 =?utf-8?B?SXNNK1JlVlVBeFhqeHRqak0zQ3hGcTdjTjloY3VxTnNuMERReGh3dHM3QXNI?=
 =?utf-8?B?eXQvb1NTT2JJUDhNMWlxZW5UZ01SRloySk5UaXRCUHpoY2k5UWVoSGtGQXJQ?=
 =?utf-8?B?dWpnNmNMT2h4V25Qam9UNko0dWJINW1NNXZCaFkvZEJuQ04vNEFTejJoU0xP?=
 =?utf-8?B?RUlsKzM5MUgxK3kzelZZMUI0UkdEV3pOUWJ0cjVUVVlsTnJHclZIWlpNcDFT?=
 =?utf-8?B?cXhEN0JWa0piVHFzek1CdDZFakpQY1RGTTdReWpmUjhUejNlVkRFWi8vd1c4?=
 =?utf-8?B?MXFrQWxzMUIwT29Lck5zMXlXV09aNFVNemY0RHpXbGQwdFRQOS9sWGx1Vzk2?=
 =?utf-8?B?RnY4b2IvZW5MZnppSWNlZDc1LzBFcGx6Y253Q0Nxc0hZM3VaOUNwZkp4QmZN?=
 =?utf-8?B?bEhSYXlpQzJzQjhISDlwVWxSMTVHUTM4MWpaNHRvSytlOENiVExDakFueklL?=
 =?utf-8?B?eFVKeDB0UFgxK1VjVkx0bFVud2J4bCt0cFlYdUR3alV3UkU5WXgvL1lpRmhI?=
 =?utf-8?B?QWhWSVpYU1NGVk1PRUVsSEo2UE16Q29oL1FaNzI2Wk5aUXpBdUdOdnZrK1pE?=
 =?utf-8?B?Q05CaTFlektHUmJoM3g4TWFSK1VqYzExUTZkWkZSK2srVGFkNGRGVlVnMXlH?=
 =?utf-8?B?TlBDcjM4bnlza284a08yZWFCY3RMNlVpL05BMHpwZXhRWFhXTFdJRTdWYUVm?=
 =?utf-8?B?SVliWHJXbkRqWGI3TUp1QjJzL0ZoOGRqSTczenQwU2preUN6djRMMUtyV3RF?=
 =?utf-8?B?UTl2R09TTzg1ZXNyM3NEQ1l6SnREUzRQS1RVdmtXemlQRkYwQmwxbU01S3Rw?=
 =?utf-8?B?eHpqTGIvZDlGRGs1MzN5UnhBK0lVK1dLUVZWbFZtS21rR0FhcnkvTnVyNDBK?=
 =?utf-8?B?RlQxY3pKcFlwWjZSeTRiNjhxKzl3UmlKb3hXZnpwWE5aNWw0ck9tclNJbTBQ?=
 =?utf-8?B?SlgvejZKZGVoRG5IcVJXZnJqWjJzbDJNaW5ycVV5T3F6clV2dmU3Z1NIcFZk?=
 =?utf-8?B?S1ZyT2srWjNEN2l2SXRpQlQ0KzhwWUU0OFJtcFdHbEhmN25Na3NqWkpDUHV0?=
 =?utf-8?B?UEpzamxxcnBPVENNRFkwejc1VUFmNVZxWlIzdVhVNS9tb241M2xTNmFReEhw?=
 =?utf-8?B?T3Q2RE1WSVJHREtseEFvUkZWUjhKaUN0R2oyaGc3dW5Ta0I2Y1NsaG1YMEpv?=
 =?utf-8?B?VzdxL21pOWhzNVVETGlHM0QydkNNUFlFaitwSnFWd0N6NVJ3S0dsNFpRd2FR?=
 =?utf-8?B?UklOUERWUmNxV29iS0x6N0RjN0JVSFY5Y01qdzN5cU9QMjYyVzhjWk00ZW8z?=
 =?utf-8?B?cjllMnpQOGp0LzVkZmliZGxqV3FOR0Q1TnZTQkxaVzRNbTZHeGhYZVRIeFAz?=
 =?utf-8?Q?4FRo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTJ0djl5V05xVHQ0d1lEa2FHQUVRVWhPbDR3QnBEQWgxbEtyM3h3a1BJUG9H?=
 =?utf-8?B?Mk1SUHQxR1F4S0piODhKREIvSUpzd3MrNXRnc3cwOGxwLzhITjNDT2t0Um0w?=
 =?utf-8?B?TXVtMGFyQzZGQ1lTaXE0TjdodzY2OEd3eUtnd0thdExJTjNXOGp3c29ibVlp?=
 =?utf-8?B?a3VwMzBXeU9iRnlwQktzUEFWT2dEdlNJL2h6WTVHOXJxeUw3ZFQ0ZjQyVUI5?=
 =?utf-8?B?UStnUGxaWkt2anNsbHoyc201S0VFM2RoZWduMWJYbGtYOTFKOHNpYlg0b2dK?=
 =?utf-8?B?SzVFUXRRdXNxbmU4enRzMk5zbThVVU4zQWVzVU91RDRBUzhDZ3B5eENhb3pR?=
 =?utf-8?B?MUNjSHk0ekZPUytudzY2MFVtd0ptb0JNYUtkQ1llOEtZOWNwRlhkcVQvY0Np?=
 =?utf-8?B?OC8wWXZlZUhNaHBVelNUQkFmOW90RG9sbDdkTmJqbTc2OGNMNVFTMXkvNWVj?=
 =?utf-8?B?MXcwNGNrTnpDWkIvdytYdE9LdUcvK09GdnNSSWVPMTZlaTJWUUQrcDI3UXQv?=
 =?utf-8?B?TWRxUWt6ZE96SlgwT3Vlb3NzaWtFaUZ1Smlvdmt6aHlmTE04ZzZuZ3hyYXhO?=
 =?utf-8?B?c0RCbkVoaEJjQXEva1FLOUljNGZ3WFFwUlJPOHFGVWFNaENlSUtOYWJUeHFT?=
 =?utf-8?B?U0sxOXdETVFCbVQ1OExqNU9hMXpjRGJBeTVPbDVtNlRnNTlVaGRvUWxsOXgv?=
 =?utf-8?B?RnZvWmlzWmRYT0NMOTlTbEttcUF3RFp0QnR6bVpCc1RVdVJoUFo3MmpxUG9N?=
 =?utf-8?B?dE90YktmVml2Z0IzUVJLZkxoOGtReHFmVkRReHRCdUo3clRUVU8xTHR6VTcr?=
 =?utf-8?B?YkN5cGpwSVZkeEZtOUs0c0kxSStUcEYwWHN4d3kramh6TWtqN0k5ZElYM1Ix?=
 =?utf-8?B?UmJPU2RkTld6VnhNRVlIQWZ1U0dnSmRQRk1hQzlNd1NoRUh2Um9jVnZLWFVk?=
 =?utf-8?B?MC9OdnlINllyVDBCOFdSOUMwZzhnc2VaM2RUbSs4YUJKSU1KblNnU1dzN0tm?=
 =?utf-8?B?UDNnejVMSVFSSUEvOTlHdTdaNlVwZUlCRG12dURnZCtJN1hmVit5R1hPRTlt?=
 =?utf-8?B?eW13bllmMHBtWFJjVFpYcjk0eTJsUW4rYzM0MkZKS3hoK1dhTWtBT3JXRFAr?=
 =?utf-8?B?QS8xYXJhRkJsUkZtaUxRVndPVzFkNE1CUjFZVEI4Z3I0amNsSERWZVpUbU9G?=
 =?utf-8?B?WUxTdGlaQTkrYTFVbmt0V0o1emtnODNOaWlxNzBKUXBEakVsRG0zekQ5clhL?=
 =?utf-8?B?YmQ1VlhHdjkzdmhkTkRpOXQ1MG9kL2VzalZqU1BPSnhKNFZJeVdsNUJ2SE5P?=
 =?utf-8?B?WCsvb3g5cXFpYWtwTCtvcG10blBxZHNWTjdLUCtJL3Q3ZWsreWdVYW1vYm53?=
 =?utf-8?B?a2JjOTBic3h0UlZleDhEMDBGOVpMNW9BNFRHdlVrOFlXc3dZaXhsdlJLSlJm?=
 =?utf-8?B?WDZ3OTUzYlRMeFpBQUNIa1luWE1EV1Y5UXhEUkhtL0tNZWVEU3lDb2RLdFd0?=
 =?utf-8?B?RHZqamJLUkxCbjlDU3U1UHY2dHFiUnJSVkp4VGxSbkRBTmhNM1JYR1poNWk2?=
 =?utf-8?B?TDRGb3hqKzlpN0x6YWNBSWRONnd0dFJERlZPYnRiL09ZZnE4ZkZvRlVBUFkz?=
 =?utf-8?B?bUxwS3NOL05JaVNXaWF3d3VHTzJhMHhmS01mVEpsRjdlc0dTZE1oRFp3aUpr?=
 =?utf-8?B?c0s2MTNQNkdYZDBXZWNoZGI3MWIvV1N4QmxYZC9BTkhvQ252VXJWeVZ1ai9v?=
 =?utf-8?B?bmRQaHU4RzRnaTBxTXJ4cGoxanZQRC9RVDhYYkdHdm1ad3VCdWYwMU9GRnJG?=
 =?utf-8?B?TjJkWi9yT0ZHZmRyRk1kU0ljOUFXUTlaWnVjeUdRdVc3eHFXMHpmYmJUMTNV?=
 =?utf-8?B?c09KbnZFU3FaMDE3QW9HdTVSbEltcVU4MzF5SW91eDE5NzdJNE1Ua2o1SnpJ?=
 =?utf-8?B?WFJSMUpkTHlaczE3ejJqN0hOcDhNa0xkMzBNVTZsZWEyVGI4d0N4YWRCK0VJ?=
 =?utf-8?B?SnYvVldCUVBJZWNxU0NtYmlaNTgrYlpGelZaZDlFc1I1Tk94ME1rZ0RFZHlx?=
 =?utf-8?B?ZXMrcFUwSlUvMnRiWGVMaEdqc095VUFjbGtLaW9rN2toUUIzY3IxelhFRkVD?=
 =?utf-8?B?eXd0bDBwaExqTHlRWjJTa245OUd3MFdPZW5Xa2VtbHhoS01pQlRqNXNJM3ND?=
 =?utf-8?B?TjZQcmc0SWxCTWRSeTI4TkpMcEM1eWZMQkRSeXdzOGdVNVJvUHpUdDBBQk9s?=
 =?utf-8?B?SXg0NHpGcWRGQWtXbXBJQlluQllFY1hTSkVqd3pjaDh3akdVcWhubFZHS2Ry?=
 =?utf-8?B?UkZ2YUx2S2hlNGpzVkxUeGNEZmR4L2Jrb1JBUHdNOHdkd0Rja2liUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wZKd+ktHfqfcMIcegALntO/PK75tHpMxaiE8uJ2y7ik4O7nP+ixNcDF6Czl2dBMhnMhV58JxQ+5gmq/YTX/SrCQ1FzaTLTEREnJivLEnkW7HTfh+Ds8lglIm6sF/hc3HCK7jevdx0UaDnKDYRiN3EIcSZWFqLb7OaGqGGAk/arCIw6w9b9cZW4IlYNFVjTEpbKUtVaNqpNcl86AiK6UKugHRfb831HUN1YkRWrjmXBhFjU/18KKtjyz+W/ozQ/gP+xeR04RVvCL9PKysPPz7l43Fmj1lTNXoEfFsr6RAvBpd0G9oz+bc41lsYwJ+BRoq4ELwBibPUL2Dp0pGyJ/lcuoRK7pkhVQHJe0uJhJJwXiYunW85O1rrIA/EcJ8swf6u+eIki55UrXshpZtLgR/S7q9rAOfM0N8kzacoJQDKajNIT/+el0n21W0lp6My6sRziCJ2oWT5vDkde6gHz1CTlm5EmpRiM1qHzJEcwqVQh4GXTM6FDDpECKpBbSjMbhDyguecx+Sb6lAMMHjPN86nUs5UbjFbIfF6+/J2wh10Fj0LF0LPrlUp3CodSUB/Ncr1VzSboCd8VCWEKgte4BQ2BjYAab+jAGvFeHqBRsDbKg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e89d7b7-cf87-48ba-99c4-08de6af6d3ff
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 11:55:48.9340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXCSalOwjJI3t0hD84hKLiA2dZpZ+ATTU8ElQX2tBKfUk8rH8y0I8J0/ToOLar2G1BJMgkRqDAq8OdWq60QGZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_02,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=880 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602130091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA5MSBTYWx0ZWRfXxjlAXBLkcOlZ
 DjvT+wbe91AGUBUhJKGk7eUKyBt3vMng4uqnG7l4s69ezxAeOADsBiiNE5tnEloV7YoBqf2Syt6
 UbWUVOVSwjQ7K3pbiGr6DkWF9kDGB5TYAVqI4MirLAzFMgMnhdVZe0g/XVmNpxN5HD2Q18/Wo5n
 GEzD3wRwpbeEo3IzSY2LYlnIqK3BxVkpzjAg/tY0PNsrxUaZSMnhWlFkEpxl4x2x73oWPwoAhfB
 VXWTMgHkiIsm5lt+VbuNE/lIqlB9iKSjkIkORzia/xZNFwsePzqYPAkcuimNWfld6WrK72hZTKr
 Ewa24Z7xZbIYYxA3oABPzs10WcVqzN6Ll3EMm2MyYSH6n54ISvxV6kKXiZiWdH6kU3K2o2+QvGw
 zyE39FN2oQtDT4oix1cX17N7U06hXLUAtx2o8IsNOTinK35FR059wswuucalQRtpCLDQOC6ivbQ
 e4TTzmMxRvFmdltJe/w==
X-Proofpoint-GUID: eIVOh0f7NxeWKdLU9Y2umUDuV_dJM08Q
X-Authority-Analysis: v=2.4 cv=Mehhep/f c=1 sm=1 tr=0 ts=698f114a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=ZjnedAPQjhg5HCaBv10A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eIVOh0f7NxeWKdLU9Y2umUDuV_dJM08Q

On Thu, Feb 12, 2026 at 11:15:52AM -0800, Alexei Starovoitov wrote:
> On Fri, Feb 6, 2026 at 1:35 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> >         } else {
> > +               if (unlikely(!allow_spin)) {
> > +                       /* call_rcu() does not support NMI context */
> > +                       rcu_sheaf->size--;
> > +                       local_unlock(&s->cpu_sheaves->lock);
> > +                       goto fail;
> 
> As a first step it's ok, but we need to make call_rcu() work too.

Yeah I was thinking it would be nice to have call_rcu_nolock()...

> Shouldn't be too hard. It protects itself with local_irq_save,
> so if (irqs_disabled()) defer to irq_work and call_rcu there
> or guard reentrance into __call_rcu_common() with per-cpu busy counter.
> rcu_head can be reused to form list of objects to be processed in irq work.

I'll take a look at that, thanks!

-- 
Cheers,
Harry / Hyeonggon
