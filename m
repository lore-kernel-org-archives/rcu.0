Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DEF29D0E;
	Fri, 18 Jul 2025 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849188; cv=fail; b=PkFEMcjMMm1fG74THUbwm8EDwcIsfzSklx9L8lDAGFM1bNi7boeLkKELBYNY+g/qWg1JB1NL2jzvK9il60XYX693rOQR7ZvPP40e5U8eJNAqRBs/J9LUa5MAUuLFALvaCK+SNCajSA7pn/rz00erlJF98Bc+IY2jynr5apZiKTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849188; c=relaxed/simple;
	bh=pFb8VMa/UY/sbjsz5njFvlB/g4LK97QO8vjYzOpmIBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XCp5kOEuo/RpOtsm4ImZFNEH0Q0ptioAVCy/pDM07I4o0QweZCNnWdByWikjfBvwuRg6jzvrnXCL5FEFib8dM6npauAcS/a5EwTnsJSHOmOPkw8INFWUV1ITKUU0nba0qxgHfYekl1xLGgFoBMnR6Q3aygc88VvCZuMvvXInuO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DKHx3kZD; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DKHx3kZD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrqJH95A3vAw25DHAwT9r1Mb8QeQV+wP/pUYCMSxbhprDmKTCAYb1hq+pNugvSNgkwK7Xx0yLL3P59+MDHkq0FrDtU7cbCgfZ8tNxpcaGGkIWGLVC/m00mRIy9d2vm69oQ5Gd1vf1PaIkl1wh0lw6u9+5he5ppUBoptjSaO/xZAqxbrrOeyUN37/FUEqHvDbdFW2OYpV0TyzKOmhqhVEjodQBc5giqLNILo8UKYGuMT9yI5O4jBjrlBrEBaQMtd+rhBsbMoYWvpHgrYM4v4f2WvJaA2m5o4zbAmpVVc0erUEZY1fGMzWQ4XAtqrRkzW50S+/c2DUYBiwdiuNV5YQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byeCLkUJFe4muIxH2Hl0a+GMUfzqIwXZrDfpVOTr+9E=;
 b=bz2s+IQZ7R4T55S0wSRQchIsNa2H+4CCOd9MgZ8/xZJS1GkMbWb4Io+MSZZbTY/e3bi8+JkTH71QADD5RlGrjOOwudf8Nqc79Q48jMeaR8EZR0yX+0mxqXGKptQR5NJRYpDQwX3AzuwWD1v2Jb5izzU3Lado6DVD6ZPCXtqjdDXsb7s6ZTpGn4QDcPXNr8V0ZYwAhEqxhO+jl8cJI/x1vdmdO0203s5I1oP9702gIewa1EllPgQuJUCM6Hlju00mgQoZHOunmiNElU6sQ7+Cvb75tOqBvXQxPgk5nnMu+6ZrqRWmq8GODbHxV+J4oklKunhWHVqPYOknjhhnS5UMug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byeCLkUJFe4muIxH2Hl0a+GMUfzqIwXZrDfpVOTr+9E=;
 b=DKHx3kZDq0ttrDETLgu0ms/RF6w1qpQJJEaXPBXVQaenmZ+QIOZntij3m154h1nbsDD6Y8M6DfLSBkZXPGPgHGNPFt8SHFoCVhqR3zetcAj3wTR8Qga9X83QoaUMS6Bok/skviMhggvCxWExRZhi6a3bumtuudvS7rUlzuZ94qAdrtWuNOVauBaHvo5BaRjeYRcXPx4H/VgRI+DasUEgrpkwls1KCj+JGWkw9hw9yzYbjbS1Yqa7DLnJEUjv7PIr/K28KepHfy2cjpw0dg2hCt9rBecykj0aY1Ga0h2EaeIfS4tjl723UAK8PfgCHDVu55oCk7kWys7GaIraR9H65Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.35; Fri, 18 Jul 2025 14:33:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 14:33:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Ye Liu <liuye@kylinos.cn>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] mm: Replace (20 - PAGE_SHIFT) with common macros for
 pages<->MB conversion
Date: Fri, 18 Jul 2025 10:32:59 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <28DD183E-6E00-4A73-8F22-82DD74E3FBD9@nvidia.com>
In-Reply-To: <20250718024134.1304745-1-ye.liu@linux.dev>
References: <20250718024134.1304745-1-ye.liu@linux.dev>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:208:fc::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a91a665-4f8c-444a-ed13-08ddc60800cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/CmlswneKiwQyP5R3j8EgtCi/klQBuGlBGZgh2JuEjWYb+GBQxXXghJ5b2Ga?=
 =?us-ascii?Q?8ddIrz6b0w1nunNGW8mHt1Svyz7vQ1oNBw8j0Oe1rKbbccZueYWCdpobteOr?=
 =?us-ascii?Q?BHoorE518Z4iWXC7/zavsDZyFGqSRVayhU5izgv1YnOIaLkFiyUX32vKyk7Z?=
 =?us-ascii?Q?rP7A8HDq+g+g+kXK31D2t16Afcyhcif1MGvz9X1phAxqTGdMRPZ9yFJv0dCr?=
 =?us-ascii?Q?9nyzHlGye9WHsdC9fIusm8V2GQNVRRnhmNthpWfeJg8CIIpPyl+ogWD0lM4H?=
 =?us-ascii?Q?ZkW1GptZmMHr8iSMFEBptLLEjwlSUEy5qr21xsBnQonL5mZdnARvKPYOm8G7?=
 =?us-ascii?Q?3hcXjY/CJKpY9fixJxqfhtp3ZkV6+LokOsvfEkRMFK/TVxTFW7s9Jd8hsqn5?=
 =?us-ascii?Q?Ynq4RZU0lRIzpow5e3CJaSp6yTBEN7izSpML+/yYlP2rCchU4zsOpWw9Mbpx?=
 =?us-ascii?Q?UgM/yNtie9d8GGTXeeu//zauHy2LoC73DBeQtzguXuG+870mNEZw2MygvFzb?=
 =?us-ascii?Q?VO/6joLphCbDtsC5fqCHbMAnzlpFOu9JmdzUxDAderc5R7QgWYe8K47TspDR?=
 =?us-ascii?Q?tPlBSw2r8Y9ATZD/pXsO3Nai7mlIU8NPF7OHx9njAsIN0Va8zIAxfVsV2pff?=
 =?us-ascii?Q?hgo7iZsc+ipc6g/YahD35AdLL4X4yasn+32nRwFerNuL4/Pu4y5YWdmdnHxe?=
 =?us-ascii?Q?qbkD5b6rJMklk/EIm4TIOQbY5OTs1ytW6mhvuqEk6J9BoqA6vssoui6ilaKa?=
 =?us-ascii?Q?IA+gDHC3WYVuVBPAn7xyd9AMbVCpAgcJFEgFJvfW5kFQz9K9mI1hFHeTICv4?=
 =?us-ascii?Q?v1Pt7oEt5NPoCY3niKz1lGxayiJ+4xO4wL77QaVgLfYS+8Onx9dhfHcFGaZv?=
 =?us-ascii?Q?kE0OWCQIrwpDcaOgS6+1TOxv7vWYeI6yUVnEWhcKl5nKAJgdcViD7dZl+eji?=
 =?us-ascii?Q?NMTWh2XiOU1cbJy+Ru+Hadcmqx4jondEDNNB3uLqtz6/SIlgxlakE7brWcb2?=
 =?us-ascii?Q?HFQNeCq3ZUQEUXw324BxiaSpz5v0ye9ni2qSdq3p9hi/5rh6QkCpUtKhC8Ka?=
 =?us-ascii?Q?guaAg/DwG+NMCiE3ElxsPWi9m3HkRfugglZk9wyTeh5n3cg5GM5G2mpqpW6E?=
 =?us-ascii?Q?ztTjEpCt1H+MoIUeiUIniS7TfUvB8k4gxkKt51URJcja8dtnZ7/9lD7BdMK4?=
 =?us-ascii?Q?xfLt08hsrbKpUnHlrW4WxtGN7XHuFPd0K3RvrmyekXkXVeWH3oPORI2KQ0mt?=
 =?us-ascii?Q?E7uzjbDXgJulVRbSuU4seF2l33qKgaCcFhiyPbfRAEVVTXStPJyGA8F5GSqj?=
 =?us-ascii?Q?GlOk5R7PHS7BuR2LP5vAJMjv5rIU+eU5SO9qjHfq8MtN/9549dcTrFu0NPUt?=
 =?us-ascii?Q?tURjUO6kgsHjdQNbhq68jSYjRxtA0MVJzLYLb7pULOw5clW9Hu7qiTbNBrR2?=
 =?us-ascii?Q?kYmeKpkXKzI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXyRboM9nANpHIGkiRMrCHBN1n6NsSgGUONzYMk12ODGU7v9LBicjd2rNtnY?=
 =?us-ascii?Q?kpFnYMKRwGBZDiBd2aRn6auLxv6c5Z+1ZD6419mfd1At5tj8ZZTWMo41Pdfg?=
 =?us-ascii?Q?fmn5CS1dr+yLVhxuO87bQJcbapJMXxOmtBznw3c5ReMtVGI17WRlxU2UiGSt?=
 =?us-ascii?Q?la9Kq8WHGD7j5DD5HkJAy00vRFZ2NHjSsMQSzEWgmIyk6AG2PGgR0L9saKPn?=
 =?us-ascii?Q?dlmacRMkWrsEZNZghyhwpOlUfrxLz/Ck7yoSK6km8IvQwKh12m4wP0w8nzwM?=
 =?us-ascii?Q?GHPDxNGEQWXSzZBp9pBFrSo8rjNnC2f3h77eibmz8RqXgYlcBD8DmLKgJ7tt?=
 =?us-ascii?Q?oF4BGXLUXeaL8Bvt8n3G1A+RpKhIt1rp+l4XatG4UTdLDTp6uRedzIk+LBQl?=
 =?us-ascii?Q?uqaCUXEXm+D48fZVbFZwyh6yoQULeYqv1c44m7XESwhmDzSgshUEiuzNu8hR?=
 =?us-ascii?Q?olWqDyEuFYmUa8uy6ZKj9G9+emgr9X/nW4zHx8aLJI2bIg7Jqlg9ADlGRyCe?=
 =?us-ascii?Q?hfp1Cgu3YX6AHThRY1773YRUsEj1Cr+zBUxYYMgw71imrzILrknHIsBxRCN3?=
 =?us-ascii?Q?aDhTObGdKMbsW0Y9IcRPdlzM3fHpYr725GkRzHLPwFwcGwkq9rC548yjo5Vv?=
 =?us-ascii?Q?QmV9XtUCMDnZQTK8ddtt0Pn975r4hdL9q8smCxnVjibrr5A1q9GAeCwuL3NJ?=
 =?us-ascii?Q?XIKVaWY5dQ8hkLq/q+PPVUHB/omO0EGBsItFNUzq5YSd/JkCzeisrK//pEw+?=
 =?us-ascii?Q?8ubxS9RkZv87RVKygaMetDQh940D2YV3c1RlEhQEMYz5UHvoEJT+1rahL0+L?=
 =?us-ascii?Q?WHUk8ChGx7brW/jSzwMlbJhjKgMEcGV+xzWaRyFkuDc9NUGE8gNKwKjLagAi?=
 =?us-ascii?Q?qe6EW8roJ5oXRgKOKnJcpoUJ/jxU0c4haMeokTVIr8k6UqvFArmZbBed/wR7?=
 =?us-ascii?Q?644mSiYemsxqEr+NEqs4mJikmV9gnZDI+GztFZKDIO+Zj9H7RIzPbo1rzr/+?=
 =?us-ascii?Q?LA1HHwNqUOkKG+79kwerMCEO7YBguHlKwFf7qdzR2OM8Xwoj0LXlGMCSWSwE?=
 =?us-ascii?Q?g4ZQcjq2LQpvfo1WBeXEz3O14C/Xq+8on2IL4ptrlqx6sWfpRX3/AGxgQ1dw?=
 =?us-ascii?Q?7lIEOPjRzIrQRvos1WfMqPKhkUikyh3gqlHG4KEFTL+7K/Gs9gVB9KbUmPTY?=
 =?us-ascii?Q?cd2uQLsYMReF5ZEzfEtRcM3fRF61MLPUzXyUYCgQv9Nsm8FBi9+EwQbe+S0k?=
 =?us-ascii?Q?cLpXxbUBFDgUA+aeW/ctdOwURgGDCufNnS0vhAUN9ekjWb2K4RIPiP8i1ymO?=
 =?us-ascii?Q?NcW9BlSYgYRsWdOEIJ7q6twFuolfwc1taoKhn4T9EdNrgKsNGjk9Ob/KxUx9?=
 =?us-ascii?Q?mUwfkCDljrGDVlz1LiNMAeP2CYKzvICiZwEYqtaSNUeQvTvYtRU9sDR1mM3Z?=
 =?us-ascii?Q?6852y33Nui+idugSFDOQfKf75I5YbwmfNMexTQJ20P7xvJRbaPg280YbRhT9?=
 =?us-ascii?Q?bDAxaKWISBCeNZYgbMqGpPl148ndUdB7Uc+oc5qcEwdx0JtRfP13u9lD2uAv?=
 =?us-ascii?Q?g0KKqO/lbwCZ58bopEFVClzfEg4zvguzhK+V2ng4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a91a665-4f8c-444a-ed13-08ddc60800cb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:33:03.3719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5dzvqLvZSo58N4DL9XzluVfMjn6O0hrbCbwN9pYrhO1z0oigQnKe8kJVUEtURv2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344

On 17 Jul 2025, at 22:41, Ye Liu wrote:

> From: Ye Liu <liuye@kylinos.cn>
>
> Replace repeated (20 - PAGE_SHIFT) calculations with standard macros:
> - MB_TO_PAGES(mb)    converts MB to page count
> - PAGES_TO_MB(pages) converts pages to MB
>
> No functional change.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>  include/linux/mm.h    | 9 +++++++++
>  kernel/rcu/rcuscale.c | 2 +-
>  kernel/sched/fair.c   | 5 ++---
>  mm/backing-dev.c      | 2 +-
>  mm/huge_memory.c      | 2 +-
>  mm/swap.c             | 2 +-
>  6 files changed, 15 insertions(+), 7 deletions(-)
>

Thanks.

Acked-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi
