Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793142802;
	b=m2GaqpOC3VB9b0KuWdujqgZCmyM4x5pP+MPCycU1VjwlG3pmNFSyqcccLCHFzIAczG0m
	 KPJx/IEu10w++zAnWrDiB8xUIf8jKnXy81kSldRFPTNp9ACpKGH0wgeNiC6WJ0KYLZSha
	 s0bb+kwBW1V2x4KZngPxDFf6Qo3UZ0lj17JyasOT+k+Xe9loSgxRfuFYhDLeCsUAxQqSl
	 UpF76TIFmEIQ38SaeZpM1VLSM3uh8j3TWalzkk/xfEwa3FS0x04M7xZbgYDw5V8Rr+io5
	 kiB/Q3LLyeH6zx6p4NsqNIGnxrsfFaEtDVWQJXVri9Q1cL3KOU/0xlLV6QCPzD6A/XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142802;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UXwFsvzM+WoNT0NbIH4XRSDZ8DaZF3jAYjQ0EqCxIkg=;
	b=1DWH6kyRGvib0Ld7eAuzYM8b3QLGH2FwIDjh0wb739UBBICUrrDv1wSTKTwvY/x8wiLY
	 ZsDoEuBtrnAs726GycUCtn58hfKLto2juj2C5wVl66lbS8/P6uqismqKbLMavQY3nfe1E
	 p6czjcqkUvY9NWJPGxAUgRX55El+qM3NLkL7m7j65M6pZk9gon4XVqbjwNLo6Alf1oSOn
	 AqNTkxBKf93f/97wjbx6WTxG3k68kY6z7XIW0/cepOpip4KpgdM9O6D95j3uToHlcmt2R
	 RImhWrP6NKCvdXr4sNiVyzi8UxJ/Hq8a9LIoHfZxUQJPl4NXJ5P9Qy80X/kM6/IenHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="qJx0/2a6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.30
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A2606A31A;
	Tue, 27 Oct 2026 23:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A04A2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qJx0/2a6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBzwpWWhyXtb0CcYD8aAGZnrpWaHxYh+kdWd+p80Bh26GrMiCgWUY1JNKbIl16yAnkV/MDMM9TeqUyR2fprpTN8X9kvMbzQqPNhtW1mviCvh9dG010jgQvpJBzPjPBONp13+oQ7oN8HCoWzESm/0RcD/2LZSrZTRjqZVzxx2JQhPAW5kI4bj00OAcGWzTrYJ42/loGVm/hur8MECh4E2mTsNOvCQbe+EXEEVdLZahvjyyuB/vy90cmv0TKAyQ2V60upu8+2X6P0RlNamFwerLxBqicer74HOXIJkhPgtCPSCCZ5LEyDdJf3d3KUyjuLLlNqPDr3nm26GOCHGZwMJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXwFsvzM+WoNT0NbIH4XRSDZ8DaZF3jAYjQ0EqCxIkg=;
 b=i3qf6iopE0jzHxGl3Q4M6CDYeAS5sS+MXnpQS53JZKxctr2ofOwe9hUWENS/IsY8erde7yJUN5gFsYtInHwdO0a1+eVRQpm1Q0/ZwWUkhLBru0M/TKkv0pFSqEASrFzr7LIHOiDqMR0/fh1w9pR25W6FdnR3SICJNkLOoxzOfXDKs1sBdgwJVcTKeQ6gXmmHZOFEdSNBSa1pgNLzEnE7HJUvRNZpKdxEXhlDOoycJNCeKdhejKQmfXNJgk8/BPuDRzxMKs+DkOkiJNJwlzN3lL8ZCdsl1o1gnb+LQk+3f0MtTaZb5cry66oPBS1o7r+qCSNawoorEYIBtNhnvMHbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXwFsvzM+WoNT0NbIH4XRSDZ8DaZF3jAYjQ0EqCxIkg=;
 b=qJx0/2a6a3TbfeMhQKVdswhQUmOjlCQ/eZ9KUQGYGke6DBPSHjONzGVzQ72MJeprUPdqMJhtWgWElRNCINw9q1qVjlXLL4hETP9hXxPY1bOYppoQyzBUj2R/bd7NZrEWDifBAmaaOcdKQB4X2odL9os6S31gT8gAXEkoRbrxGpTNYQvMMpCGKvO9BuAP00H+a4xfw2RDJ/dC4Mh/7lp+64JxCivmhDUdIgd1h4Cc2Fr7e8PMNb9JabjCdAOMbqEfpehD3yW8SjxBgdpdZ42M1+VTgo7KXI1DjMWQE8Ex7tSLzl4gTV4HLY2NMHp306oOjrB9SB2sQ4/5oJygCNf+WQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by LY0PR12MB639115.namprd12.prod.outlook.com (2603:10b6:404:216::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:13:18 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 23:13:17 +0000
Date: Tue, 27 Oct 2026 19:13:15 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org,
	work@onurozkan.dev, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	boqun@kernel.org, urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, qiang.zhang@linux.dev,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] rcu: Improve callback diagnostics and validation
Message-ID: <20261027231315.GA3580680@joelbox>
References: <20261027070923.3054462-1-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027070923.3054462-1-kunwu.chan@gmail.com>
X-ClientProxiedBy: CH5P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::23) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|LY0PR12MB639115:EE_
X-MS-Office365-Filtering-Correlation-Id: 18995f16-0c86-4abe-5335-08df347fe288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|261026121527099003|3023799007|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	H2xbqc1cAlGquL2Vsgm0O3cojYpU+izKvfyfFapPPMJy8QJriCCab7kBXNDhzKhQKpA16m4Y9pGBSYZCX1SYwIXDef4UZPT88CMurKBCyfpl/yxiMGTyKRWEH2hIPhopfFl8iQWedbhCv3I0c0lYcQN3AaVXEMjjk5T2emX9mtRTuWXUZ3W4MFwGPDKITZWkANNnzvUgKVdBbi6J+7QBv6MWfHSbNo8tOugehDGDiuApfPitdWTcDuURQyZsdX87m0ST2CPziBx4rUi5b/mHQAZ6Kg1rezB5TpnEhs3U9Kg/MMG89Z7TRdsEfZYeo+fOt3LtyRJ9YrYQ56ZcefDWPJjbGYjrs5klGTblkKZLyyT8kvtfwZt2uzMXVj3TMexskyYPAEmgybFt0PCekRVUo9BIXvDg4NFnVdhqE7SKZVaHFkyknUoK/7hulkVumwScdK1nCLi0wKZVwmUhtBgIdakIsQP1+jx5/krx8pvesj3/CQiC4qZmNJwiRZcL5vEdnAQdyScWXmyqF7P9BhCGvbe5bcdxYNWoFFsv2HeTlS/ZduwT4mU20ik/+9ORiIQFIfSw3bISnOMDptfjmmoVSEHj+ly3SO4UnrT06qd5zvSy8UUOtX0BYuzbqMpD+BypMsFBLCNR3lk8Wkojd/NOc4sTNJG2o51b/zCWGQ8mmpQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(261026121527099003)(3023799007)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7B8rJJubYFTnYIFsR2SC3ef8yTvDXiYqPFVwO9Hqw6v1GFRVf39L0VrhvEBK?=
 =?us-ascii?Q?SoFxGriXcY0wSFTkSNZPZ+3nsyQQV1AXtU4hzoy4oRjEfySt233WjM4epEIA?=
 =?us-ascii?Q?xey7eEf5JDAN99jJ23uSeRuXjMdBrALVh132MG8lK+66v+SWyg7HkD9BZpvH?=
 =?us-ascii?Q?GAeK+B4GbPFyxvpCOCuSb59dmGKWIoGHZX0/vkFwwze/cSwRH7HRjNb0Y7YG?=
 =?us-ascii?Q?WFxvrKebvChouxrzKQ++Jfet22fvXQijPV2s4ehxd/zjbjZzyBKGppdvqBQF?=
 =?us-ascii?Q?ofR59WD88i6NLjsdQQeJO8ZOB5K3Hg0kiQ+BkLlE0i4v2IF3lfVuoqjuUnxR?=
 =?us-ascii?Q?8dVumqYnG2cslSpMn+o3th+G2YCXJxuOeHaEyvfT/Kk3YrwABWcGWwn8OSGq?=
 =?us-ascii?Q?jYyhTpVFUcpw4zue01QkbctZrhBsKjRNWPcXWEZnzkHeEX3rp39DXtQUaQ8N?=
 =?us-ascii?Q?CgKwjr1MGNxq76RJjQeFdQi3nRRI3UR58bKAA6qgOsDa4P8PTPn0tcKkAcUh?=
 =?us-ascii?Q?1yigWdEbtZvIBlEB0xK+LGyQaBuPmkRu5A/TFO0PejdbRg1tJ9WMFYQWnMJm?=
 =?us-ascii?Q?ZRg3V9gBEImS4kaN+NGspAhyQy2Odh8MKmQp4y9WCpaxd95p+M35U/NWr+fg?=
 =?us-ascii?Q?JrUZwmopk+MKkkmbsCmlwml4g/CeheGQIhNmpefdjzsa0CSjaSQNy8bnwHAE?=
 =?us-ascii?Q?QD8nMsLfFGOgapCoXmNVPvIKMD8uNCdOhxDp5FiyoGxtNkJzZbGHXh1CqB/K?=
 =?us-ascii?Q?piI1VG+Cxv0/F2oMzV5RDQWiR3+NLx3Fdp6ThTTUSye9y6T+ZQEOGDzCE8mS?=
 =?us-ascii?Q?Tai2pHZYyZpnrALH+bAP4BsgafAxFLGLWaVD6nkQb6ZllSTIqWv4vblkhYT9?=
 =?us-ascii?Q?KoL5NFWHAtK1tPi+GxkVuczeBaqYWclKovNG3yJHmyboCstu5zgtnQYt8L9z?=
 =?us-ascii?Q?1MyffpTgXv69tq98X5T6kizpN+7WmdEq5253sR6bzPJeU7RZ7NPcRLG7dEVH?=
 =?us-ascii?Q?Bh1rHvRSOZYAUHlPoo/FH+yn9j7+B/hLqE9G0v9zkdEVY0klHte5zDb3rQsI?=
 =?us-ascii?Q?LQObHOpa6iWaf7J8ZIkcwRcNpgfdySeMyxAO2uUmBuEn3UCZApulCSZPcV1I?=
 =?us-ascii?Q?q8/mhRDUwFbQMvJj+QSlKqrZgW4Bi8e9C71uF+XZlROx54IldP7UA7z6rDuS?=
 =?us-ascii?Q?ZF3crArF5ACZOrssu2PwGa2UcIAlxt+7bayAZE2uQtWB8l7RRcNqbE+g5sXI?=
 =?us-ascii?Q?CbLsUw6ebQDK2pIn9zhyWgO0xMjo1ckhzSc3yz34FWebn7M7hNatP74Scbrk?=
 =?us-ascii?Q?l1bUPzVOi9nzRAYTK6u54ayOiGkPXHXZc8BjOdzz1F/Hyok4eGpM2eKt6K4n?=
 =?us-ascii?Q?ZHUAAV501A/QARtX6TMTFGx9S4/e6bfMewB8dYZsXSWcKL1WFR0Ir6fOWot4?=
 =?us-ascii?Q?eY7Bb0FlomiGRZfgewfOSBZ9hhgV6TYpbEbY+WFxTxcY7tU7Ilh6vZBrftSE?=
 =?us-ascii?Q?Q6MVhtsvMMRb4D8TjWwt4uvpIXMup5ir9XfeQZk9CY49Ur6NGjR7fwpgwVDw?=
 =?us-ascii?Q?Cu2PEwBKsf6Cza9+tZmcJ4Uiw1eeRaZubSSFMrpNNnYWkaRcJMprzVN4Ktf2?=
 =?us-ascii?Q?TQp43EAzsecsfLHi0S4RSw0k4ZMpvKUdoZUhKeTFt2qaY9OEk5ye3o4HdH6H?=
 =?us-ascii?Q?vpi1YmygpKSPSn/Ho+fxqNwz3vav/sGp/BABw4i9Qr9Or66tEXOAueLO1YjI?=
 =?us-ascii?Q?j+MvhctUww=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18995f16-0c86-4abe-5335-08df347fe288
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:13:17.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHnGS5Wj/d3KKhPTZpghcx9DgcD/piA0Na3e5jR2hoLJiGckYUQ2LsQF1h3ADaZEqW5I/XNz0oKHJ1whIbyXow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB639115

On Tue, Oct 27, 2026 at 03:09:13PM +0800, Kunwu Chan wrote:
> Hi,
> 
> This series improves callback diagnostics and validation across RCU,
> SRCU, and RCU Tasks.
> 
> Patches 1-3 record callback registration stacks for KASAN in Tree
> SRCU, Tiny SRCU, and Tiny RCU.  KASAN prints the recorded auxiliary
> stack when reporting a use-after-free.
> 
> Patches 4-6 add rcu_head alignment and NULL callback-function checks.
> 
> Patches 7-10 detect duplicate callback enqueue attempts before
> queueing, using the RCU head debug-object mechanism.  A duplicate
> registration is rejected at entry and __ratelimit() controls the
> diagnostic output group (pr_err, mem_dump_obj, dump_stack).
> Detection requires CONFIG_DEBUG_OBJECTS_RCU_HEAD.
> 
> Changes since v1:
> - Patches 7-9: __ratelimit() + dump_stack() instead of hard-coded limit
> - Patch 10 (new): same change for Tree RCU's rcu_do_enqueue()
> - Patch 9: fixed log format to avoid pseudo-function names
> - Tags: Reviewed-by (4-6), Suggested-by (7-10)
> - v1: https://lore.kernel.org/all/20261023101841.2910719-1-kunwu.chan@gmail.com/
> 
> 
> Testing:
>   rcutorture with KASAN (SRCU-N, SRCU-P, SRCU-T, SRCU-U, TINY01,
>   TINY02, TREE03, 3min each): all exitcode 0.
> 
>   KASAN aux stack (QEMU, CONFIG_KASAN_GENERIC=y):
>     Last potentially related work creation:
>      kasan_save_stack+0x33/0x60
>      kasan_record_aux_stack+0x8c/0xa0
>      call_srcu+0xb2/0x390
> 
>   Duplicate enqueue (QEMU, CONFIG_DEBUG_OBJECTS_RCU_HEAD=y):
>     call_srcu(): Duplicate call_srcu() CB ... ->cb
>     dump_stack_lvl+0x47/0x60
>     call_rcu_tasks_generic(): Duplicate CB for RCU Tasks, ... ->cb
>     dump_stack_lvl+0x47/0x60
>     rcu_do_enqueue(): Double-freed CB ... ->cb  slab kmalloc-16 ...
> 
> 
> Kunwu Chan (10):
>   srcu: Record callback registration stack for KASAN
>   srcutiny: Record callback registration stack for KASAN
>   rcu: Record callback registration stack for Tiny RCU
>   srcu: Validate callback arguments
>   rcu: Validate callback arguments in Tiny RCU
>   rcu-tasks: Validate callback arguments
>   srcu: Detect duplicate callback enqueue at registration
>   srcutiny: Detect duplicate callback enqueue
>   rcu-tasks: Detect duplicate callback enqueue
>   rcu: Improve duplicate callback diagnostics


Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

All look good to me, applying for further testing and review for 7.5. Did you
also test double-call-srcu and confirm intended behavior? Thanks!

thanks,

Joel Fernandes


> 
>  kernel/rcu/srcutiny.c | 34 ++++++++++++++++++++++++++++++++++
>  kernel/rcu/srcutree.c | 36 ++++++++++++++++++++++++++++++------
>  kernel/rcu/tasks.h    | 27 +++++++++++++++++++++++++++
>  kernel/rcu/tiny.c     | 11 +++++++++++
>  kernel/rcu/tree.c     |  9 +++++++--
>  5 files changed, 109 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 940793b926aa94bf65ec404043050888e3053188
> -- 
> 2.43.0
> 
