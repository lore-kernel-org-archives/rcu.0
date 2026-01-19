Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF9500960;
	Mon, 19 Jan 2026 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768858474; cv=fail; b=X0yvM9svtO/Ll+E1t02QNyOlZztJQ+N/LDMLvGKV2wq5aBk8qsMMzKdITEByQPFqL6snFn//3U3xkJPCd0IU50l/ot2B5nkMQnia55HiPpRWxYhpCe4Uq2qt6rdQOLfkmPzvTuTf/piG09aEieehGlRlJ0wqKqkF+ME+VH9t7Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768858474; c=relaxed/simple;
	bh=RVCp59DoQXrtVmEodn0XjD0PG9OUsOmdVLWo4Djlc4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Message-ID:MIME-Version; b=cTOSMIZp0adTuwi1iRWlS1VV5s2Tyffy4vvCZr/lJUFscp2HKbL4G6RA6vcsrJGPC5stKSG4HivoDtQzyNH42+jkIVhFFBszjxK9Z7N7/DgZn3nrh8Gm44h96F/GRZFcgOAP38PcZMppOHjIh7S8wVH68xQQzDHpVYMZ3fUKGcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhZeEtUl; arc=fail smtp.client-ip=52.101.85.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhZeEtUl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWALe0etn6r7SQaA811bRLqQ/mAEqkcHx+T+2D48yP0Uo6J2FXvYz45UCnkzq2W0s0CF5Oqhyj5HeGUt76YlhXuPRSng/8uuKrHshYCTqniX5FOw385LxJNnPDBQ0HtvwIOonFH8KatSHLNdVQE4gb6xPq4mjP459fGTxK1y32htAJaztvk8G/F+64RDRPXdPXvcQy4iP6HInDRQf+nXUsz9bHMUun8QbR6v4GIYQCmfo0FZ3T/CWcKVNeFIezLey0yiH68bU76H3NmJWp9doLF2sH/4xYv/osubZBs2bAgEg5MFii0Iv6Rpk+xF0jlLSFe8oHR+e2cEZgYmFZZeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLDfvz/RGzUE7KWOiJRs3+E2vFuveq6cfduizpYEFAk=;
 b=adWHoHhhHYBjoq9vpvmRHsMruXzEcHkZkUwOwtEXdlamrnVnuiHfkf+ceHt+h8luSQvnQDaZt9fd2ALARQx3y+yIk/0j2BHo1h1Cxa+UJ5fGs45inVKHo7ClNmbglDUI+RCWuUhitLa5Cap6gyQJIDXbOPldvZc2EyxNfedb0bBfEuprmpCCe7U5Q9J6ITvHxlyKZOTe8gtHfe77gbSKLutw4MH026w7XsSUgSaydxW2MCAER4zenOqZRLEmF6gODtBhuyLULeLHi0SoWan9ufCrQdKVhQHbBkTCbKRVpnzOFtVBZO+vXm/ZVrb4OGRBiYI/DDnO12l+yeukgAz9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLDfvz/RGzUE7KWOiJRs3+E2vFuveq6cfduizpYEFAk=;
 b=qhZeEtUlZlhcF0nXd4Sh6+ozUesEewTZwwK8ZGhmGDFlmQBIR0EVd3rnJq9RZTYUCHxyKr2x82f+hotIPPela+ysPPG8xuL1c+GB/n/onRP0LlOgEysA/BMusJPf9xCQV0yj/hq1IWlpLfurJ2tYj/XaGe2c1V8rL1oAeh8ZJyOQhp3c81/fd835KtrpYudUaAnqGbOozkwkd39a2fkI6WuslEqzSQk9OOUqYah1MLP1iSh2RwXK+qP4eRV1rItwiWIw36EosPn5tkWF2IzNSPqHOp4DtXOnemLvenSC22U03EiuqN0dilxU5k2Q1Gxu5GZM4tlkNl040EX+Do9bcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.11; Mon, 19 Jan 2026 21:34:29 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 21:34:29 +0000
Date: Mon, 19 Jan 2026 16:34:28 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v2 3/4] rcu/nocb: Add warning to detect if overload advancement is ever useful
In-Reply-To: <aWq-1IXhOeisfKC3@pavilion.home>
References: <20260114173154.1701056-1-joelagnelf@nvidia.com> <20260114173154.1701056-4-joelagnelf@nvidia.com> <aWq-1IXhOeisfKC3@pavilion.home>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::13) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Message-ID:
 <DS0PR12MB64868AAAC59AE4298DF0E0E8A388A@DS0PR12MB6486.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: cad022f7-c951-47c5-8efe-08de57a286c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xTig3Du54xpiIFpSIoKusMZKE8mWgJUQaBHa5K/mLzZH///9u90fVW4i8cxF?=
 =?us-ascii?Q?U/YGQ86WryrmwWvPjDAxmvOiA3ZFY1ul2/5yC71QVOABCyYb7xZw8nX4y1mj?=
 =?us-ascii?Q?fjsuJ2gxRnpqDoinvPKjP65FFXC+cOmYgVdS+bhxT97vVtpmJ1HHDaJx+kJa?=
 =?us-ascii?Q?n3SgZXWQkBEvksKmk8TbH4zP+BJssse/WRI1VODPm5puihOfsvnQXQKqFJIC?=
 =?us-ascii?Q?oqkllpQEcY55LBq/9ciNU1qtvot9Bvrr/hle0794phVdAR3+WJ+RSQa6rtFI?=
 =?us-ascii?Q?Cr75HSJTqKFPPvOTUo+XViV0jzQ/h+OB3kjJlDiZ/3AsDO2BxxHdHNgr6we4?=
 =?us-ascii?Q?p2x173fgLNzcSRAxS7kW7CTnBWc3HX/ZPE5DB9DeNwQcxvB/5v0fk8WrMp2k?=
 =?us-ascii?Q?ty2WomlRv1s08SUoIvpiuw2a7kFkjwHRiKo1y5KpBuYpeg7CtZYf45yJku/d?=
 =?us-ascii?Q?uBFv907rKcHr9x2Fy+LndR3tug0R20MlJyanQyFy4RT47ISGEI8NVKeRDRWn?=
 =?us-ascii?Q?qmKn910BmOXW/+JemBEGprN/+XdC5NT42+4gYb3XHAFJCH3ez97bu1VPxmMt?=
 =?us-ascii?Q?6r3aEqfBlSUasVJdtj4D6DHS1eZHg84lVEWYfj3rbUwRFM0AQaXSlNnn3J3w?=
 =?us-ascii?Q?JVy0o4V1d6ty2b5eLvufaaZiWSXNufKN1bwIdJx+e1zCivsvPb1/fOLOuTjt?=
 =?us-ascii?Q?dE7XGxNuNhhjEHQAiSZlRdqybmLFfFwhEaPwN9gt2xAyN7SIlwR5Tkb0gt4p?=
 =?us-ascii?Q?r9VRXFaMK+Bt6iDU44bVivrY+vW0zl4aDenAk3H+TAvD3ALtLADmoAeGWa2a?=
 =?us-ascii?Q?oGtMPAI+zyqwqNoUWWGosUsf1d3Lz+jtt4e8oMcWkpngnqTY49R91PyS49Ht?=
 =?us-ascii?Q?MS0mtn+UC9w3AqZfoGdtY+8RJEyJLj5rkZB518CZZtQpJCups/3obIdJZkfF?=
 =?us-ascii?Q?SAE0mT3hEGT6URZk7Vux+giOEhsaldMM3n3Wfc/VuD07/S17lJpt4vULOuOM?=
 =?us-ascii?Q?a4mPbqxK04KS7dRfptivDOOpsi9ZNPH49eTJgko08p3XMQCn6z6rIqz8DSSs?=
 =?us-ascii?Q?X1CSOqPXFVUwH+bzufr1T8sskfz8jA9TBkzDESRzYj/822hGiQ18fqNU0Bio?=
 =?us-ascii?Q?mJkUVOL2yO5uWmW6hxuKsgdUfjZsJoEExw8oYPLc6PGWjHIpqT8qYtbmlHTI?=
 =?us-ascii?Q?L+9brxFNfEc2kj+sIGAHAS+rx8VnUeYk6Y/Yp296XS7yOA2QLK5180P1wdIT?=
 =?us-ascii?Q?Ot6T9br3wDNAZSpsID7237mg07WsPYy48N0gZC8xRlehy6RAhFFJRCIAMyOY?=
 =?us-ascii?Q?2RuuVbV0r1dx0KH9EBq0ogBHKfj3xJbQouOYccHEePLuJNnUfRpnIwYC+0lT?=
 =?us-ascii?Q?wRKLOKWqpd7hGQkTxs7JV8JPOHxxT7hYNbypIp6b0pivW0+ihdSlMBhsgjy2?=
 =?us-ascii?Q?GrFebybdXx+YwwX6pthdUKxQgf4FNrHd400YMFQlHQdpTGdtMCuYqlIYK0vc?=
 =?us-ascii?Q?A19HUi1X2zh0tYdjruuh51AGMM8PUnJVWTN6UN4/z5CXUhjSzXbQEedLKhj2?=
 =?us-ascii?Q?DhmLK2IvS2k2Wer1hO8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0/Vih5NJGnC3U9YTMy1OnLm4WT/+bJuZJ2FPETL3O1ZvIgCKwiF2CM+SE1zy?=
 =?us-ascii?Q?Wgd3P2JIaYiqZazyidudWBGGynnbWO5VG2eVlyMJwpaPHAvNnSwkg0qqt6gD?=
 =?us-ascii?Q?EXVq89Uv3RrVDZPQzlC70RNtpasyCy2fKV1AIRlp3T8+TtL895Qcz1/0w8Wj?=
 =?us-ascii?Q?ECYyYrZwuapIuJVgeVCgB3SzzQk4Ur+uzjXKB7fI2fA3tNMdZ7t8f/E7WQgD?=
 =?us-ascii?Q?Tpsao42jN3TjEaiWnOFKAO/Au+9Z91dXXzz/tfo6R+BBfPNfYgslu5nXnP2A?=
 =?us-ascii?Q?1tJhaNB9OAvKXXVN91zb9aYFEgDvbsz4x5quniXZiuFe3d1T9Lj3oAPPxXGv?=
 =?us-ascii?Q?aW9oISxE+PQtbGGoqySSltDT4SRtlp/vKn2GsRxnQzLDTfzcxSozX4k8zyZq?=
 =?us-ascii?Q?6BGhgprparNs3HrQe1AyOVZLvF0pIvIyN3zoTEvCsBx30d1PmeHaqWtkucgr?=
 =?us-ascii?Q?Yp0uWviZX3XgRBY+zPjQ/IyvrJWEHMsTo6FG8nVnudqnpYiPNt0nx22i0Le/?=
 =?us-ascii?Q?T8IBmUjUd+fz5wye7Wa0TKPl7Ju425z3GLs7NBWpIVzPNoY8CntpX8z1/B+I?=
 =?us-ascii?Q?RfC2BZoqsLfYaP1UZIvWTAlYWN2Vv4vnfdIAWZxrIys7fPvTay0Gpv2msNLb?=
 =?us-ascii?Q?piN3TTQUM6BBVitCYDHkOX1rwzdnRnk1vzZeJlf6CWh3lSxEK0V+NwE1i5Sb?=
 =?us-ascii?Q?iYC1kQ9CyFqlBcsoAAMe/zdqFy6tug/XG247uoO3rBjiwmsbYpU11fV+ll2f?=
 =?us-ascii?Q?Gd/iDkPMzRz+OI5pXP1DdJ1SI/IItgSqa8vuSS5b+TvAv8onJYQzXoFC3lHl?=
 =?us-ascii?Q?kTNy50nfotPW9oSPYUK+S0rsjmPj05Lr6rPqb/TSzm6uKKBMlpueumpRiDPO?=
 =?us-ascii?Q?6CmKuC/q5YXbJmAc/bBHRqPBi3Ok3c5CUUewR/3X7WITGQww9F/bUuA23Dkc?=
 =?us-ascii?Q?9qj8CKzHc7PnGh7LtVxPKyOhVGryJnjnhxwstVX18XXQQ+cGw3lwPa60rII6?=
 =?us-ascii?Q?H5kXiAm5Kxr7gp2rECqgB01MLsMntHzVHDePwuI8WMZ5xuIm2DyzbeKsUcVk?=
 =?us-ascii?Q?VImnk82GTPG0G5KcL1gnZ83Lxpu0lF6o/yR1cUfAe+9Qz0lntFYUcHoFWAKz?=
 =?us-ascii?Q?l0RsOnKOu37hkLORQNihYi/dtIUN1MFSR4Q8DhT3IJqKaHylP/8lDoCtUOY1?=
 =?us-ascii?Q?QT5rKbXtnLSdhO3ic23iTR0LXJt39b23LED77MgqfZD7GBhm9p9CmUtuBHeK?=
 =?us-ascii?Q?+nil6Eg7wEcrm2xymlbVnBIE9s62Pqr3LXu9yTO2VBNTIYC6sd7/9eukwOW0?=
 =?us-ascii?Q?mUYYZU5/Cw07LYmXZsmkPA5D+WcyjIKcw+9cMbEiTRbdKxYvIlGMguMJye81?=
 =?us-ascii?Q?MlMsG+5Dw8lyin0Ob5MVm9EWwdtB5MiIsyqXLRStSVeyXw+HPnbdR9Ft36E7?=
 =?us-ascii?Q?qIF6qK6/LnlKogaCWn1UixrkTwBaXWWwTPk3691YnY4j++zSKpFWcK69AIFp?=
 =?us-ascii?Q?uYPsjfU9OJRfGIyty0dxLgnJuZ6Ig0HUevCNuXkU9uGOhpQLZ7PcDe3Iwk9f?=
 =?us-ascii?Q?1FJQ/tYWx3HuRr1QH5MgdC57l1iXgEYWfSDEHSxxpHE/oCbAvNqBlK3lN+sZ?=
 =?us-ascii?Q?eNskMqJyXu3bhbgij3RYF/6Jo6MvlIMvz8ZBzLFaoN8grRMCrr3MtuhvGvTA?=
 =?us-ascii?Q?Pwk7+0VVyri8QWM9k8DbKsWB0fcHdypp0Esg6CNUHiuTA/GcNJFfWg3lza3O?=
 =?us-ascii?Q?O32/ZxsumA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad022f7-c951-47c5-8efe-08de57a286c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:34:29.1716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huE1dSDp3jie1fvnRpJ3XiZsRzPSBXokurmBYhc+HXxTRoT1l3F9Fm23WID8Bf2AG4VXkoScR6SuVeLfnJanfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535

On Fri, Jan 16, 2026 at 11:42:28PM +0100, Frederic Weisbecker wrote:
> Le Wed, Jan 14, 2026 at 12:31:53PM -0500, Joel Fernandes a écrit :
> > During callback overload, the NOCB code attempts an opportunistic
> > advancement via rcu_advance_cbs_nowake().
> > 
> > Analysis via tracing with 300,000 callbacks flooded shows this
> > optimization is likely dead code:
> > - 30 overload conditions triggered
> > - 0 advancements actually occurred
> > - 100% of time no advancement due to current GP not done.
> > 
> > I also ran TREE05 and TREE08 for 2 hours and cannot trigger it.
> > 
> > When callbacks overflow (exceed qhimark), they are waiting for a grace
> > period that hasn't completed yet. The optimization requires the GP to be
> > complete to advance callbacks, but the overload condition itself is
> > caused by callbacks piling up faster than GPs can complete. This creates
> > a logical contradiction where the advancement cannot happen.
> > 
> > In *theory* this might be possible, the GP completed just in the nick of
> > time as we hit the overload, but this is just so rare that it can be
> > considered impossible when we cannot even hit it with synthetic callback
> > flooding even, it is a waste of cycles to even try to advance, let alone
> > be useful and is a maintenance burden complexity we don't need.
> 
> Rare is far from impossible with billions of android devices living out there.
> 
> I can imagine the warning to just hit if the flooding callback enqueuer happen
> to hit the qhimark right after the GP has completed but before nocb_gp_wait()
> managed yet to advance the callbacks.
> 
> But what would that prove then?

I agree with you. I think the original goal of this code path was to help
nocb_gp_wait() by doing some of the advancement work early when we already
know we're in an overload situation. But in all my testing, the cblist is
already advanced by the time we get here - making this path pointless as
you noted.

> > I suggest deletion. However, add a WARN_ON_ONCE for a merge window or 2
> > and delete it after out of extreme caution.
> 
> 2 merge windows is the least of time for that warning to ever land on the billions
> machines. My phone still runs a v5.4 kernel :-)
> 
> And the patch doesn't quite qualify for a stable backport.
> 
> Anyway, consider an unpleasant case where nocb_gp_wait() is starving for
> example. How would just advancing the callbacks help? We still need
> nocb_gp_wait() to run its round to eventually wake up nocb_cb_wait()
> so that the done callbacks are executed. And before doing that, it needs
> to advance the callbacks anyway...
> 
> I'm personally in favour of removing this right away instead, unless Paul
> has a good reason that I missed?

Agreed. Unless I hear otherwise from others, I will delete it in my respin.
I also agree that it is better to delete it sooner rather than later -
waiting for a merge window or two buys us very little given the latency of
kernel release ending in product.

Thanks,

 - Joel
