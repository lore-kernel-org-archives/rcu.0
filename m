Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB620275AFD;
	Fri,  6 Feb 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390584; cv=fail; b=MM3oo9Pc3lKoCPz5aimQw86QuYhmwuIhNS5opKjlTOpnU9u8/EcG2d2Ixb+d5QFTcmbLf8+8wfdTxjG1aKutv3l8JZGB/13TA6uDqke/nvFT7PL2yQNyWfp9Wi8A49ISmC7ozyckkKudTD0W5qYgbwCrqSch6HcuxEEcYMCxExc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390584; c=relaxed/simple;
	bh=z5MVEUYuH/vKcZZu38DerbkAZKLsteTERJ3MV5H30g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fwKWii1hMKOVLhoiTfC3AVE5Hc7/LNWV6oUx9Py/3AWWuzHgSdLZv8bQa1q6ZkER46rsi0X4SPsTjnHDJgPy+ICZ6MA4c+t4SF58MlqqXfTDE6oQLvYux2Dp1sC4bMLXxqs7/UWZqhYLyaXdAJfgYVxWEv4mtPRM8I+0j1fdT1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XE/w5/Ym; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XE/w5/Ym"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbCmY1N5mzWHrcHErMwd/TbkvHLFAvdnCG/04aRq4IAWy8zdOO0Yrt3DoBet7nCAoUpa85FoEwI3urKOQnBCHyvg6Q6l/0oOjZtlj0JH+sCI5jecu5782N5Ymau1o4IsCb01AkgPrLbGZ9/Ft1a8+Y/ewcGqeMgfK4A5AKBVMMHzJ2wylti10attwERMEPvBk5MTT8ZYTEp/mctLbO0I/wq/cignB9Y6hHrdc/94bLzwznmYWt18FYLK4rJ64XmPotyvqAFhBQt7I4B5qiQjCR41nPr5MigTPR2hNt/YODTUWMWZ338jsuRfNWluuOOG9btqQMFtzmcVvuHWpVLRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/f4b+ABKXeYra1eooNkbOwQNsYA3ClADKb0vK9+ZVY=;
 b=naO8QiPAyjM+puDlK6bQeNhyp3psgxPgoOa6zhsgNGzRFLoEkawiIvMPlW8URaEIk/uWZF5nPRzcRKNaxWqSXC5ALDPv6ZBZhrZh4bqNG51XczE/ErB/clhtFxRGVL+HBUm0+skI+i+JNty1tuhAFvS4I91bP+M55+rCsEStx0stj6ombSJtFX4cyzQ3TrrsP4ze+MUbBu/uoZ2hk6Z9+BpVoVfHFVGvxiQi35KZqwY8wvX9CtA2CAnUMCqsRtuCI34YHNZZdY5fB+hcVUkEVLZMnuqPHLyRmnzWq4Ad+fTlNzyj3TNrJgGz7BV0Y+WBmTAxmEwNZXTHinV+UYuCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/f4b+ABKXeYra1eooNkbOwQNsYA3ClADKb0vK9+ZVY=;
 b=XE/w5/YmtRTGNlokZ/s0HEzgvwxLAMYLBxFFUozUUcAnalTQSdry5vL6t16E46r2g8M/beG0k2mbKhdYhA/nzdduF5jKGhSYxbrsiL7VVtauGkW4U8b1tSNG+kVCTzzgz5mg2V2T2MqbYWses7+Re+F7D00cLSa3++dgU5FiZbBzB0cEF5XNT9DtTDAUzHDihA8zC2uOqjqrqmdcvAEtgdCltKA9j4HIU3guj7mpl50rbi6ZseuDpgn5GgchsFts+06hnXlOFG8fJo7LhTit+1S6dDyagYyHknFx6d52OPylt/jKRtksxRg1I1/6NCYBthQJtntpRQfpaFTfcBURQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 15:09:39 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 15:09:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-mm@kvack.org,
 Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH RFC 08/12] kcompactd: Add housekeeping notifier for
 dynamic mask update
Date: Fri, 06 Feb 2026 10:09:31 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <96511BC8-1A04-40FA-B49F-59A5FB702C73@nvidia.com>
In-Reply-To: <20260206-feature-dynamic_isolcpus_dhei-v1-8-00a711eb0c74@gmail.com>
References: <20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com>
 <20260206-feature-dynamic_isolcpus_dhei-v1-8-00a711eb0c74@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cc011c-8587-46a4-c6f7-08de6591bf1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ycR6f+RT1Sg/iPOCVj5juZPxUkN4fPCCUNPSfWnQa87zGU1bEVKzYzMzXrY?=
 =?us-ascii?Q?fBNeq7DblbhzUJ/M0M7Y/LCGmOMWEgpkYwRHw1brnAUIPLyn/0YOGAxTsDu7?=
 =?us-ascii?Q?C5FCXE0mXcsGseiN4NDntqnmc3U3GpyFl+ddxIh76ZdMGE1aFYz5y3cYjQPN?=
 =?us-ascii?Q?L6Z20Ql9DyJFyyys7D6QBr6UmXOuJaGB7cTgWb08UGTPAfVLKzyUHvxuSnbl?=
 =?us-ascii?Q?oRQXkLuacnnpWvyx21R0aLqAhcT4rgj4fyooSuvIIoPK9FUznxXnfk01hhyX?=
 =?us-ascii?Q?uoMKutziSWtHyY5W4pKvFF+nfEtEPTNmm/cPERVqF67JP7UARk0gcQiDfpQR?=
 =?us-ascii?Q?VAuP4kM6m+/qZt/AERpuGwWqSXsAHDWQGxp9UMkrpTaHKjNFC+5eOUBS7La9?=
 =?us-ascii?Q?NeqJD2pCQGRFBj67sx3Y8w+KQzs6c00HfXrcirrKAG7kRkDQuNE9Kvf5bqsI?=
 =?us-ascii?Q?YNDiAALCeo0u84Pue5Qadc6ZiLaPVqs/zP9Zf977vntY6zu/BrymX3b0nYLG?=
 =?us-ascii?Q?uEZhlOFpx78U15O7UHAY4IuZiAKGDiSy9GYviud4Md54kqCdaDaYHPAo4x1L?=
 =?us-ascii?Q?vy0qVHnJHIxzmL+N16K99GiQgyQQ5NJmXZTfmSNlJydOPioc7/je31/93EBz?=
 =?us-ascii?Q?nu04V3VTFzv+pY4tGVCxn+rUik+hzcAXJ1GosfJTkYPDK1fSjaKlZ+9/Plm+?=
 =?us-ascii?Q?SEW8WQZ5tWqF0psusDH7eouRdbjpE+M2CDR21nsCZkRC0y3POleoaT14bNv/?=
 =?us-ascii?Q?ac8S93uhWKfeRBFvTpz9nNtfd/g+mUVueGUgNlqMd/UINdL+3UiiPXjVm1Lb?=
 =?us-ascii?Q?nOrGbDTm63ArMjdRPzVIbkRWKpEuUM0hC3aXlg1kpfzUldIevujdLR4ogWr6?=
 =?us-ascii?Q?nb60pfA1U0QNBbbEAxaX6uYKkRSJPEN2tDh2PbZRCY4lcgIXegslBr8ZdY/v?=
 =?us-ascii?Q?TbkZSzklNOjKzGd5gfKRpqhIaENYeDZ+iKSr2l6Db6CUct4KcVI6+VSCljTJ?=
 =?us-ascii?Q?rivbc9Hxlmm9xvv8LDVKxid9vzAsW35GFG/BQ87hPpNxPzpZETqjlUzacF5I?=
 =?us-ascii?Q?9xAJSAXaUFJXA3y6xnXioo6bcC09fANTT8tKFs2k/N7hptBUEY6f5TZVoEuW?=
 =?us-ascii?Q?OwwcsxTnDwDMs8L2YpX08KqIWBU4yQ2g2NgSVqW2CPrCdR5iDML3raIhyJMi?=
 =?us-ascii?Q?m5XvLABwV+CqodUqAs62uT7GQZnBj0IZv1JVdtPfaCbAYUTRGeEZX5UOr+2K?=
 =?us-ascii?Q?J56lbC8bL10SZH1DnIyHX19OqCbImGN8C1+AWxh7Fm8QlBk134nRyBsLOD9O?=
 =?us-ascii?Q?EoSKbXltTEvgxNpw9yCQV8PUhYPauS9Ovcca2AcQomkjao19NicNp1pt+3Ir?=
 =?us-ascii?Q?66r9GnQdkQpdhM8cJPFQlqGAosbqQY5ERJe2brBYuH2YpNTGcrKqnvpvyLIC?=
 =?us-ascii?Q?+EST+LitjvDhJxDyxw6yw4q/QtGFopbelLdhmdd3rlaK0Dh/0ShIm+FA8dxs?=
 =?us-ascii?Q?gsEHm0gWGFejhbTV+UMUMPGFboTPPiZOQVtMVqas/RxPEJU1t+sm7uul/3tU?=
 =?us-ascii?Q?LeEUXzWMDdFjdDk+bOQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XDyzVbVgB3x+wN1Kk3sDjKPWsevP4yCJ066K2LQ6UvggdO3gznc0aCHcRIN4?=
 =?us-ascii?Q?AYcYGiN02NET0rl6daZ1frHT9K20Mb+QXjl14wbhyFGpHwOC57bx9H/lOhi6?=
 =?us-ascii?Q?lFkzjpGtk51N7dcb6Ee1hvyKyog9KaVfV42Jap+ZoJ0YKgMiNgljp1t/wZ8G?=
 =?us-ascii?Q?VuHN3k+r94qh0nhE1O3wssEYugXZ9dyupGR/GvKlOVqqWUFDpJybIbDQMX+R?=
 =?us-ascii?Q?tbTVR7I+YlMKN7DCgeiV/2hICoMpOlQOmGFwZ8APcorvT4owmACcIdSpVTHU?=
 =?us-ascii?Q?vRUbu/ctZQo1kfnJkAQ3MD1bRKNJJ11qCPGRKez4tjjIOZNEwSH9lTatk8N6?=
 =?us-ascii?Q?VS5VRx7K2PSCSKWacps5DRjWjJl6AygfC2SXgFEn8shYnR0AEW3VS+O0BOV6?=
 =?us-ascii?Q?/orEUU7mvH70I9KLos4rItndohWOoWGjnzlqCcasPYOApIdgCYyHQoStNLLV?=
 =?us-ascii?Q?4NL9Hj4I99Alzrd7qZKzjJdOyRieYIRImLM0ghsXr6dqUImuhBW+Vlqbswj8?=
 =?us-ascii?Q?UUPPeYg8OX3GayK23F41++L31nYheGKV8DEEnsUf9XHdlqB9IwcF/ts95BBl?=
 =?us-ascii?Q?wz0G6VSPICOEcIUixoBmiG0DqKnJeREkoN098NZKioS2khErXOvRmWlVV+ON?=
 =?us-ascii?Q?58Ftiws4dUN+sQUFSkukNtPQFBUZpApyrk+czTqL4qk6wzkIQmp2xPs6yMHf?=
 =?us-ascii?Q?9vwo7rPvb1CBlKFPb1fmofyZjK4++KnpPedS6b+XGTLQN1jj1JYazOtAsGFD?=
 =?us-ascii?Q?aMQ3+w0cZYbwjZ19HqaykYocYHRiASaYT0u/KEwmXNsVdICZtbPSAAAL/VTn?=
 =?us-ascii?Q?1ITqrPi/5es6SDWJB1xYlO/7YferTYXofXtT0KOrCrQyoMX75hSQhnRF7Huj?=
 =?us-ascii?Q?HHqcWNnxnI3+92OrFJNOeu/NT7oeWGmVMhw7Ab7QGqZqIulj/Xp7Suyjs4rs?=
 =?us-ascii?Q?N1lesNm0g8w3aL3g+hTcflTsGWuGmIqzFh9PZr0w1ezp62Mg/JBFGtLpQpVg?=
 =?us-ascii?Q?3FaI0gcDKf+NEfkoVBCGyLqviCNBalGtbNACsUWieSaKOX3hZ1zD5B6ArWQw?=
 =?us-ascii?Q?Rf7AhI4iGQMNkprGgm+PUZ3kAqGT+huFjZLpKRQor2IbpPoUqe+MJOmFdRdD?=
 =?us-ascii?Q?CSyxlD3j8DSDx1qEqXF/wDnWzmCk8+7Vlv5WXOSxIfWdAqRf8adJenOHzGYr?=
 =?us-ascii?Q?clilsg362qPmVjvhdlR6b/QOavvndABapcpgySw2GRXdUgSllPjNBhkNsj2s?=
 =?us-ascii?Q?5W4iwpmuOLRexkVGxmdigfWS5icNbRJFoOq4NLK/VXtIE8R4O/NNYjFPnJBI?=
 =?us-ascii?Q?bliw0/y6rMSdT4geKQJBcE5ZsrkYyj3tUAfeKQ3BzNhWdcacBJ/EqkGupHpG?=
 =?us-ascii?Q?wj0amobfIaUlxnj7gGnQ+X5fSYlabxao5L5JGOOQiH5PS1B4yDbYRdo3mtVo?=
 =?us-ascii?Q?hHSczAAmKCUMVWkdYjixsbZSH5QK7SWTR+g98ACVpn6S+f1Ju929v1J/rkMh?=
 =?us-ascii?Q?kQZ2R8Sj2NakIvS7LKFXQ4RTA2U0ppMjS1uIgC5HSa2LztrpKTEtVTS4GKRI?=
 =?us-ascii?Q?biwOxTUq0I8+f8GvNMabnr3mVr+cjCYb91wH568W9MvuaInoGuLe1lcytZjS?=
 =?us-ascii?Q?gy54Yh61IZNbpJ3r4oLSrCcqOOF/tXhmYzRrKStusxKj6yNVoBdvpWvH0siw?=
 =?us-ascii?Q?YmMfWBZoC4apzA1CBNzWthOW74hCSGrYXZUmhHlo/8yzo3yN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cc011c-8587-46a4-c6f7-08de6591bf1b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:09:38.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jHynTu7G8DbvZdPXjjdvJ5q1suDBt+CzoBqOTBvEgsjJ/o0Ahap/Pn0yp7SXbCU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602

On 6 Feb 2026, at 2:04, Qiliang Yuan wrote:

> The kcompactd threads should respect the housekeeping mask for kthreads
> (HK_TYPE_KTHREAD) to avoid running on isolated CPUs. Currently, they
> are created without explicit affinity constraints beyond the node
> preference.
>
> Add housekeeping_affine() to kcompactd_run() to set initial affinity,
> and register a housekeeping notifier to update kcompactd affinity
> when the HK_TYPE_KTHREAD mask is changed at runtime.
>

How about khugepaged and kswapd?

khugepaged thread is created in start_stop_khugepaged() from mm/khugepaged.c.
kswapd threads are created in kswapd_init() from mm/vmscan.c.

> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---
>  mm/compaction.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>


Best Regards,
Yan, Zi
