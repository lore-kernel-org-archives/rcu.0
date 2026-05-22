Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96F288C2C;
	Fri, 22 May 2026 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459845; cv=fail; b=Cx8fMBngd6oBzXE54IZEw2+9aw1DBH9r4lHwV4dU4fiTNcX+H2Q1EvbyF9GHZSK8i/rQL838bznWHl9W7tbivyq6v1WGUz9dn0iOu/ZM08NSIN8EGfaivUGyLY54LcnXZKR6758BgoHEg4A7/8bAX+J0syxBYXsk9GbqLXB1P+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459845; c=relaxed/simple;
	bh=JI4LHCzgY3w8eH3CAWOK7oAmJGUpO3IXSRVef6qXutQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=taE+HxK+G/hwCAYlz/H/wxkkZjQjFX2s5V7FIA2bzZjF9xCS6PPx7c0gNmQk9X9SB5zCqdOrCyfpi5jSTGoOwLmr65aRSVc8YyzPR3dpw3cPqF0tJKJYB07SgJ3Gix8PtvWgrc3n5/k9qQmIjZP8bkt42Dm+f8TWt81kHmrjRUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CNHf07Dp; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CNHf07Dp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c56g4Z4CMyf1cQSwEAYFLgUtbk85X2zRrNbUIRiXyNlGPq0hUrbVFsu5lhWGG6DnkOMGHozFb3aZldMvLWrepOX6dKANqGa4/euqSsIQXf8+WRoY0LuCAwwejSNpPrmKWP0grB5gRgxUHpOZsEZV+rqHVIYqXKVHAuZdhiD0y6pYD9xF8247nzWqHMQzvT6lj15DaNExcU0ZiT3R+Mcz2ZsJHvo/KTGgnQ83NQd6TdV52rFf2e0TGifoZddtnILM/DmtNltkSMjBLFvlXKaAvTsLlN5/uqawNwJQFj0dQiLx6byU4gtCLSRAFQ1tiRZhJbImrjl6l02o7Rl0CAOtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOM1pK9je2wdZhl8FWe5vZx4985LhB6ahjZTBMYIUU8=;
 b=INrOxgID1ynvYxOF3tUNUk92b3GW7jYk+JBDn1B5alanwzg8PU5QKsdpmbyX/KqvCMRGK5OAjv5QhwvGelg66aYDl4uo/auo6VrVyb5Tu74lta5nYUVjbvMLYpLYQAZrYI6iNQQMQ4fONWjZIxVDfpn4sS/aWy1pgymOQmkIf1/HEzi5XKWLiap+MjLfMG1x2RKu3tDWKHvFPrcqAUMHmN1fYyeJXUbC1qezUiUl13TGpFxHgyPB/7wBDBaY+OhY16cvGfNC50QfMmrqPdKZovR5k1U3BQR4fI/uve1O0DIKbOtTNaZF2FikvzGq5xvofHe8WoOUzxomFGnfzxiiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOM1pK9je2wdZhl8FWe5vZx4985LhB6ahjZTBMYIUU8=;
 b=CNHf07DpNPsWRrrzcFKz4giLWaqAMamEtYTXtp0utHKFYUz66IKRV1tj4VBGODiK4uPgzf8TShUoTq/s2tgv6Q9GlXyNGd7Es98L0oGoDZhF2PHbsbJ44ZDOtC9dVMjxjlDEGD/beJLt/MhnPLGtC446HFuHKDvNq96iQFeB+wKioc5PVG734O78OyJR3EcpPvx7FhfclUF9OmmsMBTT8dSWYDATMddfUKCXRX15Z9ANoGFwbaaH2arTCz2s4io79zCRw/7eH7IIswOi+TeNRagearhA4lmTGLYejSe7p69w1Q7ZyD3S6aa5htYy7KU9wl27pth4nPuL8UkTqsCmOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 14:23:57 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:23:57 +0000
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
Subject: [PATCH RFC v1 0/6] rcu: fix stuck defer_qs_pending state
Date: Fri, 22 May 2026 10:23:34 -0400
Message-Id: <20260522142342.1536533-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:408:e5::14) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e7af07d-5ffc-42ff-b70f-08deb80dc23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vrN6Udzmxh91xNCtpFD8oeGoxThcKOmJ+CNty0WBOyZgjC9U2GUb08FxGB4yX+2JHTRP9AL0IfS+TvNvROFTXggxS56geMPmUOh1kZUKtiM9QHdd2Xf0ZGFGrDW9D/bjVztZx2KQXi8bMhozulvZXuPK105Tj10qFsdTnPb9Kh5WRALIQcPixHZ2XPqkIcepGlzB+qtDZMYG5SQzlnA+e+J+IHI23CAsbp/tL1WFKuO5zk0ZQ6/unsSrmcPOUVQDyDJVFeQHlUHbIlOYeHiaGkMQGf8RnPbU2Jd7yPEYFwd7DzgULw2SHrTXZdCGZuoKnPkTfEO7FsirJ9P/Xhuc4cXKiJJ9v7UPrplp5ESYtQlB7v0h/u4z/S5Gjv4Bgf69WvohXRYB8GoNiXA1ZV6LgJfWyNQ26QFdOZ87+t8uYAZ7h9IvBU03pWXSO5Svhzka8yDrCvyVi7tlEDKwYgQ/ollhQkbEwvJZeUTYZQ4Uw1buFOE2BGruQhFuav0z/ApIArC0XKce+tcYx0IPVwVtpb8niysLAc82t9DHSVniwLnWQQi8a17Y+SNGtCLxhDmX3MD8BtuYhHyF4L68s9jUDTLZK8YVemtKcRThKEryC4Bjn2/iEnqbM4ypYDxUxmShLwYxliusfeuyGemml4h9TCGyzptW9AinFfTizOB3THuo/9clHz+sd23e+3St87fU4YVTHYncENMqELvnmvfuSyhCoSKTf41Fw7B7HalBgYtsdRGfPzIx+MpjIqP0hfqg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(11063799006)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KCoovNR+oRxX4sLw8mIQLh6mwavkWSdxdmZFv1aRsbNCj2MzjuEtIhtdBjz+?=
 =?us-ascii?Q?4hxoJ7/IPPf/5PG8tbNB4ADEgWYpsNwQMn+oYvLgy4y11BN3Z4laPKvw4ILX?=
 =?us-ascii?Q?zX4kOJtSuFsaHxWR2lDOV+weP8NozatQviGMPuqLsoaDxd+B6h3ZYMRDjFzw?=
 =?us-ascii?Q?3aLOLRa7bwLG6iJQHAkxVzapVBcMvg0AKfRmZ2lqkjahZClHibt+xAMYq3g0?=
 =?us-ascii?Q?p4BrMtMyT5DoimtLJtOySoK45SuMhRRv8saGSj4iDIeMcLnSTnyoI2r4f9NO?=
 =?us-ascii?Q?tFHh6A8KqoLlPqOJZtY6rZcNI+JgvuFQevxEeIcL2bO2IHIHXBUgsmxwH5dj?=
 =?us-ascii?Q?S418KSvFHvJ5Bq6vBItNVX0i9OzJx95b/ogMubLbIerWkq9j7gyROaSe7zOx?=
 =?us-ascii?Q?8lR93xzIgDlqqpKXMwbu6a6GrD1blUmmfrzMAV3Gto7VATPVoxpp5YmzQNiG?=
 =?us-ascii?Q?+9k1FtEk8/rtD4Yz2du7Rided2CT2UpjWaiHuH7+1XZjVwc84eORDAc06R9w?=
 =?us-ascii?Q?YWbMYQG+r7R/LNigUl7C2/9IwHJUr2qWQkeIryJb37J16HL0S67DvT2ZvaEe?=
 =?us-ascii?Q?/tGEjCn1I5jg7emNAJRp2y5EFeslqxbr8JU1Mm8R1aYxvtG81js72/htoMkH?=
 =?us-ascii?Q?+4dDs/g4HPLxq0XW2usAx4L69ct1xqi4jLlp1GL8XEFRPIxu06iccRekE1D1?=
 =?us-ascii?Q?fFsGJv0GAwa8Oy0InF5G+RMgavjTyal22qkiTC+UUPAmlZHezkeYJMnkvLZM?=
 =?us-ascii?Q?lQ1VnJ7S5JbOaN6V7Y08mC2ViCN88rKpW0dekWQxNZ8arEOhBCvo9rO8CRC5?=
 =?us-ascii?Q?gxrqTUAyA9Vgyy2og98+CqjWMmTgf04Pyt+4d6tIyMfX7Ksb3vbqCKW6U9MU?=
 =?us-ascii?Q?V5kNc8j5EPW0r21VMEURf7sk3CSzfZ1SidRYzbdVj5P/hWR3ppL4mw9HY4/1?=
 =?us-ascii?Q?bhfrK2gUqqfT5t6MQzQG4hjGQYH9BVxpXFNlDaoHdV6lHN7WbT7qh51+tQ4e?=
 =?us-ascii?Q?F1uodHaVPfZzLftfJC3TMHW11tRYytbA237wjw2Tdl/kTK1+CuMuucBOvf3k?=
 =?us-ascii?Q?M/AR40L6XvL17yiGiZI38xcbdC/aOb4bquLQRzgpPzTy0/Oco/AL/FsBET4M?=
 =?us-ascii?Q?KH7HkcglfR01HjbkS0N8g71zYkxPoQ+rpU2Duupwowzv05JgeRW3kUd9amQP?=
 =?us-ascii?Q?kOMw5pG9oyVaAzWbBQa3jgLubzZBuYxSi1DJ6P/Vx3eJD/8qA87Wy4fDDFT4?=
 =?us-ascii?Q?8BgasblNJ/RTuRi7ueIleQMXDDkZhkhljZuqqA+vdkpxNrJzKU9/VfvHm3XJ?=
 =?us-ascii?Q?PR2RG4DsCcWGIXiPy5VrwiKmdfO4EulWjw/PViTbO4CEk6R4pnlhP98jTy73?=
 =?us-ascii?Q?hPnSOk2T1MRFUKCDXobrOjN044DGz2BHfciufc7JHSGeBIikOZGISJV7jYJH?=
 =?us-ascii?Q?ASdBbkQ6vA/kWIEgwzwhecm1rAw3X3Udz3fvbdi4xnBNv6s9l8aNBZHTTp67?=
 =?us-ascii?Q?Cu6Qe43vN7t9UxRiMDQCF7j5Nh72Lpm0ixRL6AzkKe7Gh4mnDdYFQIb8IOGY?=
 =?us-ascii?Q?7EdzzmSqNngd/eyNAQ+HtlBhWnciEQ5hfDv48wJ65qkV691Uvv9XLibjP8B8?=
 =?us-ascii?Q?Zgncb8BcNCyNI8dwNt9Zlhl2WQsNZm7wjPDe+hvE5NEUdSUv00AJU9GJtCuT?=
 =?us-ascii?Q?A+Wg8b7ppGkmxazex1xeJEVA3MhyHBmpPg/P2CPLvu341DGpGeCgBtbkkDJf?=
 =?us-ascii?Q?GNjRuGf/1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7af07d-5ffc-42ff-b70f-08deb80dc23c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:23:57.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDD4p6pofP8GURvfYkwbqTVXyEircPmNms8b6DYNMKxSotbPzTa4fyDF6eZ6soHAbLCpwmKLqcUQV9s+98IYfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

This series fixes a bug where rdp->defer_qs_pending can remain stuck in
PENDING when a preempted reader's quiescent state is reported up-tree via
a path other than the deferred-QS irq-work handler (FQS scan, hotplug
transition, expedited GP IPI, context switch). Once stuck, the pending
gate in rcu_read_unlock_special() silently suppresses all future arming
attempts on that CPU. The series adds PENDING -> IDLE transitions at the
missing sites.

Also handles the case where the deferred-QS irq-work handler may run between
segments of a compound section (per Paul McKenney's counter-example):

I also handled expedited GP cases in a patch. I have not yet looked at how this
interacts with the softirq paths so I am keeping the RFC tag on.

The last patch is a debug-only detector (CONFIG_RCU_GP_CLEANUP_STALE_CHECK,
marked [TEST COMMIT], not for merge) -- applied alone on unmodified mainline
without patches 2-5 it reliably fires a WARN within 5 minutes under TREE03
rcutorture, confirming the bug exists and the detector catches it; with the
full fix applied, I could not reproduce the issue.

The git tree with all patches can be found at:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/tag/?h=rcu-dqs-stuck-rfc-v1-20260522

Joel Fernandes (6):
  rcu: introduce rcu_defer_qs_clear() helper
  rcu: clear defer_qs_pending when notifying GP changes
  rcu: clear defer_qs_pending in handler for compounded sections
  rcu: drop redundant defer_qs_pending clear in irqrestore handler
  rcu: clear defer_qs_pending at expedited IPI entry
  [TEST COMMIT] rcu: detect stuck defer_qs_pending at GP cleanup

 kernel/rcu/Kconfig.debug | 11 +++++++++
 kernel/rcu/tree.c        | 49 ++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree.h        | 13 +++++++++++
 kernel/rcu/tree_exp.h    |  6 +++++
 kernel/rcu/tree_plugin.h | 30 ++++++++++++------------
 5 files changed, 94 insertions(+), 15 deletions(-)

-- 
2.34.1

