Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E1392C34;
	Tue, 17 Mar 2026 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782608; cv=fail; b=pu65Je7Zcb8p2iQomLY9Vrh2XQx6GW+XWi5fbWuJisBIzIY9BqhxCZHUW5DKC7HFEm0ZRXFDF/teaZx30NmNUjalx3BeZ+xQmomSIIC4dVzCA6dVK/WPicP+Q7NJGd6rhCn6HVQofJNLbNFRBJHdZJtZlVHQMJ7aHPEmbOplngc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782608; c=relaxed/simple;
	bh=QHXXUB30hw6J6GZPXAeTNKS1ArW7aEnscd/jLHU8gCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OwwkBwPgLNkojz4e2c4kowv6N009yuATJYVky+gi1bDNKY9kv2IVuczWLPnEUdS2TKoNQ76HdTRCsDQGdjshK1NfC9pQJ0ReEh8uS9+lZWEiKzzjdeAt1OK27TALIyeFdfs6Y+YbCwgLpxZYWC33+sjz7AjfxVINNh2njuBT6fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TUHlXBTq; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TUHlXBTq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzNjJYIYgEocLiVk3YDUJmGFJF7ompcpbFMAdXEW990GIrHwbdQUvQ1s6HCOas0+YLDEgEgyv/75MBNv2ZIOgosYni27Xy58P+n3pC19ak610zYEK8fVVItl9LvWDVyN9O3ZaCmoFfFKoMLhtdR2kWClFpDmFXvssxMbYh7X+D7Eu37Q3492pTPlg5dwIxKyKTaXR2xGkd+V0x/tvKwedDE9X+4TTxeKCUjMZeTtl7WHNq53Mxce2Vn3g/5XZzqDuKy1ESKIn3HUqIs2Xt9107Krj6OqBZ9gmu8eKAP7SCXeW1nL/pb3k5N5YZuzCg4+Mapk4Dr3ND9pbB0it8mxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAgxR5E5eCFwHJ0k8s1XuoQly/PBkEp9m3c5kFwsbm4=;
 b=JXtlKvTl67d+i3nbtHnAxewwnPFQ4gSom6NmzsM7fNDT2tiHK/5I30Lg++3bkLgbfrtavBQQ4EM6X4L1p0NkCY613GO34j8CZBM/vVt6dmdjzeHoDJBh/o4SuD9NASQRewhKibA9XIjxfB6fwzyCXxjr8CUuFPaFDI8T9yfyLWyCPXEe406V5E7CRV+yu8Qx/4SyVRsh5e1nrazRKDwpDos3HP05u2Dh2ZLls4PgMciKsnEv0mkcxRoxx5AvETa0nQx6sYAJ7V2kqYJMjWHu/nsSx+UEXqs29gH0McjW1OXSi/fLWwXxsTRd9uRlRmOJ09r72vMUf5pNBCmZwzoQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAgxR5E5eCFwHJ0k8s1XuoQly/PBkEp9m3c5kFwsbm4=;
 b=TUHlXBTq9V3dd17LqCquGZB8/h67FvdhqNSVDfM3DzU+ZKQx4CQH/KXJobhdrx12EDmrz5z3/+VdsQUnRRlj2JkZbZYv5bypykFakR/ZEOPWoFTZC1OTztJ12CNM7VMVsTbgPzoV7L6nS2bMxritSwv1ZNdcLamcvpxYnW6Z3mFQe1wAgRtTvWxTj/6d4D9NV0n5aTPrEMxBCs9cCrxbvpEBbqb8rzCn2ipJPkmaIuI6XQEBbnKi5fHM7rUtofwJi7msQZxywdXMLS1W0Q/8VP+GHNeQhDuFI/kLIqkyovLIA24WYuZKhn9j3b32+T7q7sanYgXnr2glPpTXtoNCxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:23:18 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:23:18 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH -next v1 13/16] rcu-tasks: Remove unnecessary smp_store_release() in cblist_init_generic()
Date: Tue, 17 Mar 2026 17:22:14 -0400
Message-Id: <20260317212217.1527644-14-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0027.prod.exchangelabs.com
 (2603:10b6:207:18::40) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 143fd4af-7877-4929-5766-08de846b684f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	lkdMDh5JFToRRogd7tTuWiGiQwCWpraUWEQXHAReMGA5bKMoXjtcnSgKDpVVR5TWHzWRHqy88byY4XdTLLf0VakNMBn00I0Kc47hN2tv4QCms/J8zHKe1pzr1FlS0XlwaWwXWjwj1DIZCp8m+rsvRGM5VptDIoaAmTxPZi5QWdFoJCGV1ye2BARGxn5lCji5AQKIlRsUuoJi0mzimNTYqRjQCcQtLtCLswzzIZV/1BtIkXhEiiQ1TGsVqzLUvn9AUAQQpbSv+sGkmIB64+8DF17I7lVCclhxmOD5oYUXXimHmpKPSPqNYGAEAnSJgZRP0zrGb31XDgM5jQ/WRECgWzXY8hwLXzjxEGHwkrw+dh6p7ZPcOdQ1EGg2ikRVA562QqYbhjFs95g5x3T70r+aWFOxqNaH7Nd4SBecCOQivgXop+ADtz39dyIBGOaVwg0z0kj/DcizNYvIlnWyJuaGrHm4OJ5SPkWKxvX/QjrdMtO3PgwBJLAFw8GFkNlTTLXGBhiVFbZIeCVR9vKBcmsKwjMZ3AmjnOSiqq2k9ql3yjVcfcdGhRYk3f+hVKO8rJRx1mGTwHP+ZyU0i0oIjJI355UChzxHOgn9PE0F2l7QG4jB2i3NxXb1MDGUT0hiSrUtn1HrsS/ljea1JMvkKqlxgUuT3QkKg6cYlycdxTrMk6a0PKGWgx/0C9swSOvgtpbxClohaVP1c+R1N2x5qAkJOOQ9CjqDAxr0rPfyr/NYrLs3PjoW5e7tteTMHMkNByGMJd0EMHGiBuCME5fnYmM1vw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Q1aNWzlZ7zBWEVpo8qyp0VOZvbpQQiqkRzk6aCyZ4A/XnmRBBEd8ErGmo73?=
 =?us-ascii?Q?K0Ap0TNyFfajb6RQQs6LJnF1GPvl3yIRh3Dr40RR2bIwN9jVG/HpF0mmjL0P?=
 =?us-ascii?Q?DTG2AU2O1nX2jq1GJrBAt4RAqN04i+fvmLqx49qdpMkzKChXIS9J09Or78ra?=
 =?us-ascii?Q?Bc3VyK1LaCMA+6Pc2V6LNg/yBnWo+q7vUYth0BTw2KkjFbrO1wHbbHhRUY46?=
 =?us-ascii?Q?d/2o6V1StfapLgJXQsUv4s8vNJst1PkALCqlUY+Wx0QsoTBCIJwV54UtVsyu?=
 =?us-ascii?Q?pzRflXvLgQxDOC2ubVD/RDJaznne+PkEApd+UChTl98bpM3OKH6rWYf+0lPp?=
 =?us-ascii?Q?mCDE1kbdFLaq+QboN8ykX4l/c76xwrecqbHb/edf1aqo8GLeB4Zt6MHVVnpX?=
 =?us-ascii?Q?3GCMcQq2W5Y62c4ZuDJVHhTnb8iGNyy+4yiU853ijb8fR9eeYEOZp67ykQxs?=
 =?us-ascii?Q?ccZP0w2BGH7/iQP8X5S5nor7OTG7RGY2uw3PzQIU0gTbBShvUBsd2fBB53pX?=
 =?us-ascii?Q?oD6mZsilyJiI+efIRwR56TYexERYboOZOcvsIs3RqUq4bJvexYn2K3BsWfqF?=
 =?us-ascii?Q?IF9i3OQRFSOGiFhsMgOSZwhA9jrNMe40NxTBbIs4GdCPgE9BFxLDxZ0qi7kP?=
 =?us-ascii?Q?4530fnXog1SkOpyczPuXkRralPyQrjUn1RCZdzhjs5b1SvxmhxLrDOEvI1jx?=
 =?us-ascii?Q?125qBWpeapBfN62yv2+VG4UwSIBZNOqPzBDknvOYqrX//WfQH0gXxi6WyFIZ?=
 =?us-ascii?Q?5OQVU08eh2n+niVBPakv0LopfW3c+NUah6xo1cr9qarF+0ycZcvTGwZF+1nr?=
 =?us-ascii?Q?QCiRROqpXAs8P+VdCMNYmeIEwsv/j4sCvVk2rcR9G8vDgsWVZmrU29FAgLIH?=
 =?us-ascii?Q?WsZPwsOnrihoRIfIWej8rReXGZZpoS5RNZniaDXRKB+FEfIC81pGdYrPG8GQ?=
 =?us-ascii?Q?Wulkbb+ACbTZ2VJgCTrw+8I0jOD1p0hR9q/l7aVYAwvq1ckfB3TcHr/wg5iA?=
 =?us-ascii?Q?5OzguisYyAHUOAgrSqC/nzZHz1EpKcZh0Hr6ZPp9GtxiQzOaxsl3+Galx3CH?=
 =?us-ascii?Q?rNT3ABsmusxwNL4RP6CVtKYkbZEcfCRYyP+5FAfZSQoRylzkPNFDFr5Hn0w5?=
 =?us-ascii?Q?0IDvxhgywmUhfZPCTeHIaDCH5l4WF7C7pGvkLgEsBQn9/REs3Nls6+K5K5Ql?=
 =?us-ascii?Q?RdMm8I5ni+rXBOpQmlHZFFBUqdQSWCYhnYd4daurASdN5HG9T6NEtGkgZMNB?=
 =?us-ascii?Q?lgh3FpmGRJNZeGdkTJ/g25fmjj3sSKNxWLePFYK3emOqjc7PaEOb+wUPtfzY?=
 =?us-ascii?Q?o2xYi2tBeflWinakRvLJfQthhB6ysNnBnmS1rLO3ZTgsY6MeGJNI14Tc0tkR?=
 =?us-ascii?Q?hGppaonSLl4g52mv5fx0Z9yYBWjHRtUsqY27bUpuA7LZ1E6kO8d7df91Su8u?=
 =?us-ascii?Q?fZLSPMUlSFRuY/ho6JWGh7ACoF8ZcDCmVuNoXczWNVhWH3bJsWzgKow75UYX?=
 =?us-ascii?Q?3bgEhmk09cIucC5Q2TOzXOsgnbZJx9KI8dll9u7kccMPNEUIC2RH4FlfeL5v?=
 =?us-ascii?Q?PMyV/XwwFe1cg9yaG8H8fnLlGnZhJFB8bwndiH+vaRv4FzgkScUtfDt4jgUh?=
 =?us-ascii?Q?RrjoH0IWhcW+4xaf+n4RgEmN8cRTfB9cV+6CnpuSZL+yC+27K3I3AN3MheS/?=
 =?us-ascii?Q?gIFN7IPOdGW0ycC01uTV+roGXAxqjQUhZaVCTV+3daSodZQ1020mi1NXdOJp?=
 =?us-ascii?Q?tim0v+xQZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143fd4af-7877-4929-5766-08de846b684f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:23:18.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyYLuBeiveuRKQ5PwiKy6UPfPQOCtfyUPEghudX3pzrqcm/Jhxgc6Tv70an6L5+oIhZj7xlXmrIjPVdRx2yZTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

From: Zqiang <qiang.zhang@linux.dev>

The cblist_init_generic() is executed during the CPU early boot
phase due to commit:30ef09635b9e ("rcu-tasks: Initialize callback
lists at rcu_init() time"), at this time, only one boot CPU is
online and the irq is disabled. this commit therefore use routine
assignment replace of smp_store_release() and WRITE_ONCE() in the
cblist_init_generic().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tasks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 2b55e6acf3c1..48f0d803c8e2 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -291,9 +291,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	shift = ilog2(rcu_task_cpu_ids / lim);
 	if (((rcu_task_cpu_ids - 1) >> shift) >= lim)
 		shift++;
-	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
-	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
-	smp_store_release(&rtp->percpu_enqueue_lim, lim);
+	rtp->percpu_enqueue_shift = shift;
+	rtp->percpu_dequeue_lim = lim;
+	rtp->percpu_enqueue_lim = lim;
 
 	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
 			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
-- 
2.34.1

