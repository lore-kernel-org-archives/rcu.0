Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA41EEA55;
	Fri, 18 Jul 2025 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832738; cv=fail; b=KyzOswQXVap7H2H2lv1SG+FK+brxV2hECSYPg66d1b7xapkKAUQi94ifAYZkOih751gZrAOXYVJJAU8jaqt50nLs9tFKXaPrG7rs0Brtgz6XzrAEr0pXq3CGVpsRDupaKGxq8hzrCQYdTheJidw3/sclV/hdet8FblBxQulryqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832738; c=relaxed/simple;
	bh=FRkG/UTTflb+kgTiKI4knQU25FtpMjoIIjqxkFT3u7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VGxETXkeTKCuwXrAIXUNmLDY/rQi1pWVCpyM6vgnS+2N2v7lAzhP1vUUHLyFCKnT9oeWKZZeokq3W21JQ+I6LM4G4jyPyjfdBC7M9LPtIXHP3ZduCO4ZozX4/AlG1fGvNu08z45aLhvbqnvqsKkyXSqvbIQuaAibVBVh8f6as40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J8EUjH0r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y74DXNig; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J8EUjH0r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y74DXNig"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8fmqf029499;
	Fri, 18 Jul 2025 09:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Fhe2JzgHpMrBjedQbf
	gbHXPUqBpeIgs78DgMCubIDnM=; b=J8EUjH0r9ABCxQPvE06Vn4Kwgk4JG8olx+
	H1n+PYV9MwgwtsJBImhyDM/Kxp7zeYRednmld+uIqKubUuSgVUpGWdOmPClh1F0+
	s7vscny1iSDmdsMtMWDX7gryaIUSIhMG4811h/8+8jxAtNxHruKM7gf17YJIG88C
	aPOqFpQd3b0RRBfF48OkjPwBq03a12q8HCHlJqwq4cKeuB0ET86L38ZFKwfVo3fV
	F+63W1EtpsVuTz83B6FMPDjN4mWdlkxNPdFk8kk5K2l4g7RcqsyrMNA0c5Fj+q2b
	3yX1EHaWmMiLLx8p+h1ix78nAqWhng0LUA1RDYVU0Wkk87MMoNcQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4vpbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 09:57:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8Y9R5039897;
	Fri, 18 Jul 2025 09:57:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dx1kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 09:57:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3y/wk1WswSET+gNjFk+JT7rNIt2GA0bLRoMZzqHiJUqHrNbZFoKzStqWmLSWUFoUGqQICiQZxxe/ZEhPBS4Og+KsyGaTsNZjR5KNzkiZxQ+XcBHg/NneCVsaCQRBktzh27ysdpjHeDyJHaOqLUSabNzxRvOuVZCxC4s+K8M5WIrB7kwxT9oAM0LUC/SKFAcYXshGDZJECC35iXyEXjr5cbfazqsFw9r7RM0Na1fvQZGQJErDlaO3gQ7d/Q9GG5Gt+a+tc7FyseodgwfuwlI9XedfQ/r+RZnts6k3uf3a4p9/ZUaO8tTgJILH8Je0HkX0LB9zqXSL3NMGiKSTgRZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fhe2JzgHpMrBjedQbfgbHXPUqBpeIgs78DgMCubIDnM=;
 b=Og5DC5/AldJ5Hwmi+DlqrJDn3ubT6z4vAROgnA3Wxpdp9Y8za8hcBBNuxaUPNYkOpf7w88E9iXGQ5Sj7pviEhQIi8BaPtzysSqgNgtSYkFYTSjVlm69qhn4giKWmY9QZUxEmd+1Uk1zPfDMoPPxPu1K+ZVd6h9m+3uuFQOc3B99D3gq2aMy0fw6Nvc0+LBvaCnrZ1HmTVtLmDW2RvMvNlmLBH3p7zr5bzB8jsm3qmHStqeEQszTlDB75o0KyaMG/hEU9BqB5zjG5FeF6TRflLnjED+uzm0baKDrBL1gMLQRNlc1DjeBW5g2VlWPSM6FUT0S7SDRHvPmOWMJKrU4exA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fhe2JzgHpMrBjedQbfgbHXPUqBpeIgs78DgMCubIDnM=;
 b=y74DXNigwJ7N0gibCDYVBIyS3TERHpOW+lzzKyhLGRHMO7QrRc/BI3XIkc9cnXJtX3GCFl3c5XDbRAVyYH8Hs7/X6Exr1BdOQ2Ikd79XeO5tGuUNkyp27W6gHHNWbPRrycgob4k6njDtwE04XD2+lGiblii9fM0X/5x4iOcIinM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4589.namprd10.prod.outlook.com (2603:10b6:a03:2d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 09:57:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 09:57:39 +0000
Date: Fri, 18 Jul 2025 10:57:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] mm: Replace (20 - PAGE_SHIFT) with common macros for
 pages<->MB conversion
Message-ID: <416948e5-6308-4d57-8a05-d611522f5f2e@lucifer.local>
References: <20250718024134.1304745-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718024134.1304745-1-ye.liu@linux.dev>
X-ClientProxiedBy: LO4P123CA0645.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed2993f-0c3e-41f5-7850-08ddc5e187ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n7FsX6oyyPc5FeHMoIABBYEJtupeIT0bRlSqpdh7QXpWlETzGSL5go2yjxpF?=
 =?us-ascii?Q?QFjSS8Ux3YD3qQOyr9+YRpEyMZpnOoW0Ha6NG+anXSVsIHblQFzfBhyfu4Ef?=
 =?us-ascii?Q?ZlwEUs6yFV80Q0InoXsLOfeRx+gbXPoSJSoDASpIwfrW94Ek+vR+/jk8TsQ9?=
 =?us-ascii?Q?IbYnlVo1Xt9lglFlcjc6Ajbiu57LqJwdQpnLuxV3dcEwDRqNGETvkpjRe1/A?=
 =?us-ascii?Q?3++SWC0UbY7G3URMkqHmv71aD2Q0Q+TUJB3kIAaOPEOsZ/g+klArk3dKP6rm?=
 =?us-ascii?Q?rIyumeX/YnbKZBeCCey7Nxe6QHb8m/PbXNApUD4JWuLBxv1IBZ81f6yeEnuZ?=
 =?us-ascii?Q?2q0M6BBQDTtwdzOhCwf29XTEGJtA+NddgXdL83N2jXcvPYmdxCLlrPD7L32R?=
 =?us-ascii?Q?5zhOdt8fbMfCJRJejOnVOXPWz1G4unxrU4YrFDVhrfpi86etDvt+hzSBDV0Q?=
 =?us-ascii?Q?oDSKlwybT7oZTY9F8+alnfjAocshia2FHObVKg5GpwcynFnIHO5vl1zoucmN?=
 =?us-ascii?Q?pS2feJPn9uHmyeZlDR4MIytYA4WkAR2KDQZVMqbOLaRvFtV5S5ycyfKojfOy?=
 =?us-ascii?Q?AvzKYesILNBoZT64UL4us4zHSfP5S0k6Qua3VJ6TZU98UxCi4B0k6e/0fBhK?=
 =?us-ascii?Q?9A3yRxFn2BgLzuZVU5OGt4eldfQCsDBVmm/C+OBZwgv3Z37w/ED1i/J/coK7?=
 =?us-ascii?Q?iDpqkWkcBuR73o3NH/lQblwDABauqSrdsKA5Npguaz7gQVJ7so7hRGaLhbVg?=
 =?us-ascii?Q?/iZk/EwrNeQUnlqzVHktotT7nZdjYWUpK3PTWOKwfOuV4toJvN5R6etWKeEO?=
 =?us-ascii?Q?qMxQvO7GSAwlDkt7Ce2Ge+2rheXG0cNfZpRssAgfxW4iNlzZ9CZ1UX+3R4z6?=
 =?us-ascii?Q?1uuAK2HZ0kJZAf+mMi9yxLcB6ybzybi3roF51HPzknxD5OB5DG3OY5Z0ecDd?=
 =?us-ascii?Q?QSgWEVm8dkcGbR25WjoQv6ai8FDMbpF87qbT6W7PVu/yoG4CwpOzvPQ/S/fz?=
 =?us-ascii?Q?eakpb/7n2wFDRkCbXBbT76JVW9FOka0VNsDECaKCsnkJIe7jx941WSZuxyUS?=
 =?us-ascii?Q?8demeRERWN6O4LxhfUqtX+QZoPm13AA2Iw9rr/mdvggldHcccSzNHjc+xGjA?=
 =?us-ascii?Q?JOffOJvoNRHLJbK+YMZ+tM2cfWMALoXAvcRLWDXTqNTlC1xiaKBbsgiVUmne?=
 =?us-ascii?Q?7EjkoXntU8qsUnduu6zOFJvwALLAiyP3XL2ZKKEdiV9mE4JHkhLUvLI3lgn9?=
 =?us-ascii?Q?cmrXnjC4Y7VxbKn6SqOM8kcHu5v0DlpDnc8NA8ckIGqxOpUxu2vyQNEiHSlC?=
 =?us-ascii?Q?EksV/bBfazZX7exd+Gn73Z40iZtrBi6MgWvw+2FroLr1/w7SqaisuNx7xe8/?=
 =?us-ascii?Q?YtAFYArzk43KZa/1WrUD8+HMJVh2McST4bVOD4tNm+ugKhKXadVoiMNPJkTK?=
 =?us-ascii?Q?g6cQAx8AbcE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H7whdqiRcQazB0vkWZ4uCwBIDUKD15/w77U0dYkGPxekWx0AfvotKxQcn1Bn?=
 =?us-ascii?Q?RKjnEerOOae60snDOUAmnRKOiO3V3JnCxwI6Recz+fPdGjwat9sKsb1nSscQ?=
 =?us-ascii?Q?mUoBVB1DZfGXNTzggXL7N55LV1AEnAL+41kGRyVEe5VTH5Ou30sfhKi7H2AB?=
 =?us-ascii?Q?XrwZOJFUJ22QEr0v+LYOqZBJO9slZCxghIbr2IbjYcUPdIoocVrU9/tY92im?=
 =?us-ascii?Q?QjRvu+SCcspTbJxUQnkWhfv96xjVRZjQxquQng5sJ+s/3R1Uy1hCKAxRVbYo?=
 =?us-ascii?Q?NRVN1A6L6OWLf6hnDpE9xiRl+A46fgPN5IPCk0fRLC7WJEdYW9Ru9qSZUQPT?=
 =?us-ascii?Q?3QCOj9CzdELnKPidZ/N3yVEaaDPi4x8JYqq9fhNGKHdAQWh+q+0ysr0MqMU2?=
 =?us-ascii?Q?+Jb+4G8D6DVmEgwrVL/U05RLC8BKppeEWzJ3Qhd8zdEZusY/ise5SF44+UKJ?=
 =?us-ascii?Q?+IlkoTY+BrMEb1ckWZBU2cKyQdnjdbsNg9JD0Xlm4p7yiT6NSn0Un/vyfEYD?=
 =?us-ascii?Q?xo+aKZYUb0aNbucRPIkFj/7xWemKKhAwbFHrUgZyhiJqnRQNZ0gGBzQpWEtp?=
 =?us-ascii?Q?Sacp83/ygv4ZwjEvwaPnd4Tn56CM+fcf4d/QLI7TCuFxKq1nN1GAhUI9WEeK?=
 =?us-ascii?Q?lSq/ddEIxnbUNCxqK4K/WVMmmnPze0XaNqD1scTnaT8uW9VyRVToHbwnWORK?=
 =?us-ascii?Q?dHa1jR7jKekMwMrihYHi9VTdwcuXtUK2FSQDAysUyPyYwxu5nW0VgOxOArFn?=
 =?us-ascii?Q?Wfjo/VpGqfv1TyMKPXzOgoww5jaUJAOxNsfeeL62ZYme5UFonHSUfwap7d7d?=
 =?us-ascii?Q?nEBVzXdDBS6gnW2sTjnTOP0LRiUlioDdgRXfbKWNZzYMBe7SDxIymo7Bugu7?=
 =?us-ascii?Q?HD1L61T8W8T7xUaq4axFWEW5gfS7T7Iwhktnwsp6RpUBWrei0uLjOipatVOe?=
 =?us-ascii?Q?UTAoJpWPhGuTpIGpx3ro43PS5ECs8ad4Wt9CkYLELuPS6LndR5dn7Iv/vBIt?=
 =?us-ascii?Q?XZMXesEFvKBoTHEXOXjFoSiKtYiUX39+zrfoOmm9RB2/OzaXQaIJhn3O7oPg?=
 =?us-ascii?Q?4c5ZQL2QK6ABY6607r1F0mwEL0jxv0QH+EmrB8P2lZJBBbpFo+ojuYa92MtY?=
 =?us-ascii?Q?/rEgkQjWytg1QirOVNg5QvJGCjLzXLQ/s4CdCfkTtU88TaPVMIYbiHXO24Uf?=
 =?us-ascii?Q?GpMKSJxzVupsIbqzZFzhIkdH67DZAiKBn8X1ap8pTWlFBJkXGblMSaoyt9AX?=
 =?us-ascii?Q?TK24G66+D9VdEeFck4iwJYMOSc4nOZAP7b8JQ2Ya1Thcnp2mjdy+wQ6RmeVP?=
 =?us-ascii?Q?v2cTWxQes5jyBTGJn8JC0IeYfRz4/HhGxHji6aSyx8h04ap1dD1l9aFJGD6G?=
 =?us-ascii?Q?d2Y21DM5UN1T7gdkaXFUiEb6+zhMoQHP/+QanKcFba4fsQGwEtsbXZhpkprV?=
 =?us-ascii?Q?PoKaTY+G1kTZa4DF/ZvHNscDFL0tSqPmho91XhZTsh10KzzQCwvAM4n4hEsC?=
 =?us-ascii?Q?DLmiTjnEiz9t8Z37mHpL+vQV+4ruMrhRx7fYWbGmxTLUsJZNlZAYtEbPhf4H?=
 =?us-ascii?Q?8HNxpQhev84FOqg13oTsrncVIEWuVDy2PkirZ0nrKSkgjN103jDU0E3Gty+4?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rOQzgVKK6nsXYuXy8lySvTyHXwQhpihLweoMC6pYz9lRTeBn2wAxoIX2km+FnzZMlQ63vf4M5j3VUx7cpHaoCkngB1icu9sdLXTlPNDBhZXYchd05wV0UZ0fuClwzFwR/qlgnQVImProCQQjA56Ja1Tgj7BYSYoKS7nW7Y+bVYkFRqe576rLY2aZWACuMdjeZ5eccUvOLzmdYXJB0q8UA/dqqwMG/XBXVpqtLwrxtCRog63k+VyzQFyEbxWTTiZrjXH0tcRx8m5kurLZat20nbv1pGnTeQCyUZVT41cuPKml1tK0mOeg7IQSXL0zBpGhE7h6IyQVF9rS68z262bH8DYgtSsn2yTIvfDskUE4fabbEhwk+Aaxv0Hr0BNnKYcLmy6wTku8aOOeNzDjwkf054kdIQFPRPDRrlAomwiGHMsFSjGLeYx1QC2uiNN/7tBtcuqY8VuVWw4Ws4BKCCgFtzrQa0Ed8UwDapQj7zgwL8zlFa1g4FpiZOSTVXtPSaHZw/AhchLSux25dZ+61ZmPf2Ejad5WMEZM9uYxrOxvt1i0/i3DkUbE10dgf9srJnLtoykdN66nqMYqrTzyYvmGNFpaMUIVnqaKoAVaj7z49NM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed2993f-0c3e-41f5-7850-08ddc5e187ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 09:57:39.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ic+1m6ah4+IEFN1QK4K7hvB95KRy+hvdI55cKtilHIRzx5yfslSHFts4M7D7sr5Ko0djnz/Q+Vd3IfXrUEm9XIqkSkO7ds0ryzY6aselOos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=935 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180077
X-Proofpoint-ORIG-GUID: 5PP43TJxAyzRuED0GZXKe-rjP8J3yD5i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA3OCBTYWx0ZWRfX7g1y7QthkSrH hPNSgEiz6/VDAXwsp+qsP3mxk8nz2eseI64L/Bq4qoNxoMZNmwX5I8+j1Of4izPfaPlRySZtYtq ESZf8b5PIbhvH7dAHohLEBgMXOOhnvFHwRcdApHMp7tvAXxRGg4ALu0CrhOyhRNUerIirJoY3A5
 qKY/zzY0OUlCeG8hnQFnSDlzkrrxvUgvPVWFdXDbwbBzireiYMjtgjYRjKfQVUmnNZ9GWGJCAcY Rt6lDLvALIz2Q7jbKdz9bbqqDmFgXm/GV3dwTtGgHLNGjY2Za5TKZWNp9l9jOqEQHPkPn4Ts4gN WsyCL63PvibcfxYIyz+ZWBQB+cgpPm6Y77UixtsnqzWma3aIK0EJkV4ldi6z1tC4a9RghvD0K8R
 ULX5fbhizamo/dhYtZqBwsedx2FXQzPXOFrGD3TqJs9XMC9LIec4k36LE0xV/km3KAZJgEYC
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=687a1a99 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=xSESJtX_IqoJi-oaihsA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: 5PP43TJxAyzRuED0GZXKe-rjP8J3yD5i

On Fri, Jul 18, 2025 at 10:41:32AM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Replace repeated (20 - PAGE_SHIFT) calculations with standard macros:
> - MB_TO_PAGES(mb)    converts MB to page count
> - PAGES_TO_MB(pages) converts pages to MB
>
> No functional change.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Nice idea :)

NOte I see arch/x86/include/asm/pgtable.h has a pages_to_mb() static inline
declaration, but probably being an asm include can't ref mm.h so meh not a big
deal.

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm.h    | 9 +++++++++
>  kernel/rcu/rcuscale.c | 2 +-
>  kernel/sched/fair.c   | 5 ++---
>  mm/backing-dev.c      | 2 +-
>  mm/huge_memory.c      | 2 +-
>  mm/swap.c             | 2 +-
>  6 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 957acde6ae62..0c1b2c074142 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -69,6 +69,15 @@ static inline void totalram_pages_add(long count)
>
>  extern void * high_memory;
>
> +/*
> + * Convert between pages and MB
> + * 20 is the shift for 1MB (2^20 = 1MB)
> + * PAGE_SHIFT is the shift for page size (e.g., 12 for 4KB pages)
> + * So (20 - PAGE_SHIFT) converts between pages and MB
> + */
> +#define PAGES_TO_MB(pages) ((pages) >> (20 - PAGE_SHIFT))
> +#define MB_TO_PAGES(mb)    ((mb) << (20 - PAGE_SHIFT))
> +
>  #ifdef CONFIG_SYSCTL
>  extern int sysctl_legacy_va_layout;
>  #else
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index b521d0455992..7484d8ad5767 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -796,7 +796,7 @@ kfree_scale_thread(void *arg)
>  		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
>  		       (unsigned long long)(end_time - start_time), kfree_loops,
>  		       rcuscale_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
> -		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
> +		       PAGES_TO_MB(mem_begin - mem_during));
>
>  		if (shutdown) {
>  			smp_mb(); /* Assign before wake. */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b9b4bbbf0af6..ae1d9a7ef202 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1489,7 +1489,7 @@ static unsigned int task_nr_scan_windows(struct task_struct *p)
>  	 * by the PTE scanner and NUMA hinting faults should be trapped based
>  	 * on resident pages
>  	 */
> -	nr_scan_pages = sysctl_numa_balancing_scan_size << (20 - PAGE_SHIFT);
> +	nr_scan_pages = MB_TO_PAGES(sysctl_numa_balancing_scan_size);
>  	rss = get_mm_rss(p->mm);
>  	if (!rss)
>  		rss = nr_scan_pages;
> @@ -1926,8 +1926,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>  		}
>
>  		def_th = sysctl_numa_balancing_hot_threshold;
> -		rate_limit = sysctl_numa_balancing_promote_rate_limit << \
> -			(20 - PAGE_SHIFT);
> +		rate_limit = MB_TO_PAGES(sysctl_numa_balancing_promote_rate_limit);
>  		numa_promotion_adjust_threshold(pgdat, rate_limit, def_th);
>
>  		th = pgdat->nbp_threshold ? : def_th;
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 783904d8c5ef..e4d578e6121c 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -510,7 +510,7 @@ static void wb_update_bandwidth_workfn(struct work_struct *work)
>  /*
>   * Initial write bandwidth: 100 MB/s
>   */
> -#define INIT_BW		(100 << (20 - PAGE_SHIFT))
> +#define INIT_BW		MB_TO_PAGES(100)
>
>  static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
>  		   gfp_t gfp)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 389620c65a5f..dcc33d9c300f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -911,7 +911,7 @@ static int __init hugepage_init(void)
>  	 * where the extra memory used could hurt more than TLB overhead
>  	 * is likely to save.  The admin can still enable it through /sys.
>  	 */
> -	if (totalram_pages() < (512 << (20 - PAGE_SHIFT))) {
> +	if (totalram_pages() < MB_TO_PAGES(512)) {
>  		transparent_hugepage_flags = 0;
>  		return 0;
>  	}
> diff --git a/mm/swap.c b/mm/swap.c
> index 3632dd061beb..cb164f9ef9e3 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1096,7 +1096,7 @@ static const struct ctl_table swap_sysctl_table[] = {
>   */
>  void __init swap_setup(void)
>  {
> -	unsigned long megs = totalram_pages() >> (20 - PAGE_SHIFT);
> +	unsigned long megs = PAGES_TO_MB(totalram_pages());
>
>  	/* Use a smaller cluster for small-memory machines */
>  	if (megs < 16)
> --
> 2.43.0
>
