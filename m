Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568CC2FCC01;
	Thu, 25 Dec 2025 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766648707; cv=fail; b=tevqe8FyQ9LAz8hWTMauiNWR+QhkOmMrv2w/E9mXq/PbCdOPeyxAXGL/p+Rg0dlvEJEbYoaVI2oqbks5r6gdRYEvMdxEGiMPGu5UMqBBR2iTY4hAz2T0R9itqmM/5sIwWmLImmEJ8p0SRlg9PW0FpfIulR2tJfFLsYQaaOlP/7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766648707; c=relaxed/simple;
	bh=6gijeGdIsDbM2vOjnH+JwqJoeK1jtZ6zfwD4EFZ7z/s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hIC3Uh6GFA0o1Rn+L6Kkd/GzlYN2EAv/TNxRz/k6J8CW2F+TiqSXIRQr9+Wm+nzoUQG6zoiXKTDCo1gPhr1dCx+wylc3YU/gGkQFR62L7Y5RDNdJaGq3UzfkTwyo6KwyeKELQ4L1fy+uoN3YaR/lAiUoH7L//hgHton+tUJMPyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LJ7hwP+x; arc=fail smtp.client-ip=52.101.46.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJ7hwP+x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wY6pOKy7k32uGGbR51A2uK7dqIW8xz2KImJ0nZJzsRy5IptS+whtwf2xE5dDK30pT2szXS7Dg3YVsjdXUPe7xLpTVc01XfYjj7fLCVywUPug5HPzQk5lvrg/xlNJO8M9PVW7RR3x4o+M6F/cHMzujtWO+Xy5pVGFt9GdqXzaygnEqZziYu7qjboV9dN84RJ4DI7HqbZhGdEuZdRuEPC5XhApgccHy5YbsMvWi33QimmJGzbHXBx6EIFcL6Wcj6Kd8h5LfOYnSthV+H8UbDuXpszXw1tw3eKGjlVgVvK+Z15v+IHq6PZi05jys3b7mp5o6XLJiGFyrJCxOvPuqen0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XcZCnPUkmowFcmEiO+G6IIqPLniTDj/wh7wcfKLZLs=;
 b=avBGPO5eE61uiak7hw8nxKoaLaoLgvV1zfqSdIwsPlGvA3bHlNxU+eAVWKQCjrz3j3VRg1NyyOD8TToOm1iYnaCdNN1iTKrgnzZRSEZ8A+gWup22QDmiMYw1AxFcGP5rCjOpAqqFSZ2wWDWeXiufT/DHF789V747STTwlQjuqf85t1X3GaIdMCKikKoEIPTMwVfgHDo3pBk1DTH+V/F310b2njG34eKtKmISAPwdKyBmvaYXG9mdYbuPknNXQNvLAQFMhW67EfrkFverkQXNgV9qggy7feI4FKFcCw5aY7znR946zyZ9otYeIJZtgfMnczNjyz0pKuMLggA4uCr3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XcZCnPUkmowFcmEiO+G6IIqPLniTDj/wh7wcfKLZLs=;
 b=LJ7hwP+xNaKrm4AEBWoSvjPa+yb73lAbhT86M/kYFaUoVQeO20J9MEkQGOxmk+5VvNfQ7Rm745e1EPXrQD/NEbXwsRWGpXguvLcr/8GNCZ7QA+QFp85FNcY9eCEvYAsxqVxMcdt9Ewug/mj4Qu4IsIzgwtzKxFKXG9m9yfjxJwphPXP2sEUm49V8zLxEMuCZWHsbCdgFaqUSH9H0/8TkxJ9nx7pbX7NFEVa22jDY8yOTuZN0kjhOjQmD9bfyJDYSGbmEs/aKypmuBJQ7qnCKsfTG/jesAp49yv+Rd1/8WqOPJQe9aGnWrbsTZZf8Y5qGBQgIge6dxcVmGFZ0Wob0TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Thu, 25 Dec
 2025 07:44:59 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.008; Thu, 25 Dec 2025
 07:44:59 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH RFC] rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
Date: Thu, 25 Dec 2025 02:44:50 -0500
Message-Id: <20251225074451.2405584-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:52f::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ab9d97-d607-402e-3727-08de43898143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v1378JPxmaRdjgcaHIgcmyu0SKjk9zYheetrG5glbOdnyT5dE+rEw7CvC83i?=
 =?us-ascii?Q?9GRng8WL/WocQqr5RWNsqrDJsF0zQJjdylG1L4MP/TNo3U3XWQWRtATdVYA5?=
 =?us-ascii?Q?4TrC+JFNHmAaFkgsoGc5D9+z8m3DU06dkply8SHed5GFzN6n6xJ6aOVINLwC?=
 =?us-ascii?Q?3wH4cZbJA6XsiLeP9xds0klqZY8I0GE5Uo7KkEdm8hvKfqeS6s8P8abeBbqZ?=
 =?us-ascii?Q?QhUKVtE/mpBv7ne/XF4gYhlUfmtzfJ00i8ooMBYVnBv3l7YWNXlJHBmEJvUq?=
 =?us-ascii?Q?h9pTSesi8mdjg55wT/BeO7hjtiIJeuRx2Nr7Zo4BDfsO72S/dy3KDr7nV5Ma?=
 =?us-ascii?Q?WpdxLXEySmbeRMtdCghU5BwgZPQAOqYcPnh9NZpcJctrpSixFfD5cm3Fxo+7?=
 =?us-ascii?Q?BSCMkOl9BygiAMtbRCxeoRdBcYhiHuDCqxnsgss2CaifFGX9UETmEKvxuj8n?=
 =?us-ascii?Q?AU+G32SOwr3YKGN72pjw1+DyGaUpHqIdj9yDWEpRw8UE3STzDVtNrNFzLoNb?=
 =?us-ascii?Q?yvc/5QZDV8I8LDaP2b8envOIZYQxIiiN/tz3FnFroEd9jpbD+BAjjRiKGI7A?=
 =?us-ascii?Q?WQily06MHW3G3VYH6iuz0+auKVDM8weevnbXsnCBZ/PuPhc4UAhnotrj8aqa?=
 =?us-ascii?Q?qDZvayQFXPdioH4pLg2jdLipKv7DC9L4Gk6ABe2p4JgVtrKEySKgm50Vqnjv?=
 =?us-ascii?Q?SqYrV8V9PjFfaOU1ItDEdV3iRskUWId/qqo7e7EHJeyMBNZjAcLp886+cPPU?=
 =?us-ascii?Q?uUGdCQr9gkJRMBryoQdA3LJwPdNoKrmOCtG1CEVBqjR+B7PTZ9ieqMZbTLku?=
 =?us-ascii?Q?y+gZsXBGwX9PXccmb0n2WRHUYNc8dEK2mUPRaWs/EaDgJR18jrOUEpyl99+Y?=
 =?us-ascii?Q?3eWx2cYJbxOSlcMozWKTtw40yeeVRNjVkCSwMQsQAwFbArg1yXI8o5hHFUKS?=
 =?us-ascii?Q?08TBvJk/SgkES5WJhfLAykOvfA9tuzABwwIk+qch41EgAzwsgOcqUZzL5aaT?=
 =?us-ascii?Q?gYvOHQ51HyxmUfUzaE+MWx7V9TEO1CQypcNqbjOLm3B3cx72Q7Y5+EIpsIyK?=
 =?us-ascii?Q?zo0q8BcOpx7srbaAOy6xCs6KfRtA9sX5lOn4SodKe6+rrKCDGbaCjyAll4cD?=
 =?us-ascii?Q?AEgMwFvajmYcWOExorx16P05pqycI9evuytOxgXgwn3sZHUvSz8BkTawF2ef?=
 =?us-ascii?Q?eT5vNT/VTggugt+GJVtbt9iy17p2QY9qmHAXbvh8e8Fb19eD3G3BP30ptSSK?=
 =?us-ascii?Q?emEElxh1EF6HwIIAL+JkcE3v2iDHqcTk+FjRIkjZIGiqSrcr0yEvfLtP+kJy?=
 =?us-ascii?Q?nh5OaCZycgW9SCM85uL0AKy6vZjTmuJqn0AEX38tb0i+igTO2GayygERGLKz?=
 =?us-ascii?Q?CJuIth0PxGUBJ3wGlGmLMdOheYS5tESgaN64yihH1eaiSTOvtf9gh/bVQZS+?=
 =?us-ascii?Q?o8FM0SJzvDvc/vNj8gsiZESVzn1kjuhObPGzOQoAMYAoYOVLvw19l/4hmhnU?=
 =?us-ascii?Q?s9UqkrJBozkqMILdAUJcPqIgHLGrL4nTAzta?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KzKYlccpUydrFAm6hKhz621tFQLf754jdT11+56dc/FutW9fPDwVGY8uHLai?=
 =?us-ascii?Q?YQA0vMEbLxAW8FygUwxToijJeZeU9CR+z8kf3lgZF8joL22cn/lxaZW9XOBp?=
 =?us-ascii?Q?Kl+aY9SN6+Pv0FkjFkePYFW9gJbm+1WNPZ7p8ClKAWV30HA5bvtuw36GlYtD?=
 =?us-ascii?Q?Z6+zFGTTMwk1o+s4bucBSWTPnLPDc5aFsLHi60o5eUZYFapYNjiNALfnzqAy?=
 =?us-ascii?Q?AuPrzicg2zvdtO0QXCDTy5HUjKNidCmnhnLX0AXr2nNSwi7M8pDWvb/OeaJb?=
 =?us-ascii?Q?AdJ3gGMn5WrsmEM/pfDfxeWkVsukjlQYbOTfPhneArsf7Z/7ViPbUc957S0R?=
 =?us-ascii?Q?yUtXAlAxdBLTTZ3kjh30qFfCDtcEqnwdRPmAweTxv6u/tjq1cayCKZNdaR0K?=
 =?us-ascii?Q?p00ar348F2GyA4wJ33ZEh8e2uhd4PfF5gE3B+dJ/VJQm0XcN3rDtYBeMBhit?=
 =?us-ascii?Q?XRgcXu+la3u2gwepNMQBiJ3Y0gPdBHIdr5c0E8ybSHNv3rwB8deWRF2XkZAa?=
 =?us-ascii?Q?PnxSsZQsDJry/VcUqUNvuVt3hAjL0nKiwA6qHtd7Q1cX+rCdHSEB1vMobU8o?=
 =?us-ascii?Q?lVrBLleFL/NPkIJBiRAk2ZroUoW7V2KwUE0P2BcitIkP12vjSkygDvVxPlXE?=
 =?us-ascii?Q?+bx1/0B3xlC2VcJZuYqeDaAgEdxxhmB5umOQxoEfPTQ5usYmhVR3wgPTmBDU?=
 =?us-ascii?Q?ETeAbQqDaRF+ZFPZ2pvPDSzzld9egUu/lulPayTngcf2I/UOaTn+56b8ZWl/?=
 =?us-ascii?Q?p1bLYR7L6OhMnBdBujrXEP7Yx0VyMq4vSCgK09eRv7QGTeoJgOV4dZRSKMsN?=
 =?us-ascii?Q?MREX4dW2cYd1XnqaQlMRs1Q5YqFYAAS6hECctxo0L90NofGVzYhIjdaF6e/a?=
 =?us-ascii?Q?dtEKMB5RO6geenKTXmHx5i3pwlOqthsNQJJWuVss99TkRYiAex171HCynzgO?=
 =?us-ascii?Q?9jETsoEW7Q8YuOq963Pqhq0JftgnWrQ/xewkNLxK//A9nn92r5n1Z4dCB1Sn?=
 =?us-ascii?Q?NWiY4bIjjyMyOxVdUZxJVpY3PPFklF0ro0eUl704KiCEMjP3W4Z4IVp8DNTI?=
 =?us-ascii?Q?iJcQKCkEU6fWrYTW8SAVzixmUxFXub72/3aKDiFP0Qh/cVRuR+JYN96yuPu0?=
 =?us-ascii?Q?piaIz2ElTqK4VeMERxlGr8Nb7k6ZmedwG38tl8W7dBWSInIRFlWlfdnbitBf?=
 =?us-ascii?Q?tDWT8CGBFLneVJIswd+B+tvsp16KmwLp73Uo8hMHMFw1r7XkHbUVFatK0ZRh?=
 =?us-ascii?Q?h/7uTOUQcXfNdZFnu4N7OIip6zsss9q9JoF8Ti94za1HuM/AB5ttBWrpqvWH?=
 =?us-ascii?Q?4HtVnPtpCNEzL5EuMObQN/sGmPJY+dLmmUp7GrOCzko8ucWMlKq2XCoSGWax?=
 =?us-ascii?Q?Pp5l6TiiLwuBX5lcOjPbh+/fQMpkpiMaM6DtwKsXy/mI/8UEF8oCvpYg+Kc1?=
 =?us-ascii?Q?gqkHA17DJDbGQjrn28Cg+rN2+U+FgoQofVPV6BYGfDbCmXFtj7aohYBz6GOM?=
 =?us-ascii?Q?Peco0OHajJ53Exv+RyQODBwXQZqvVehf22pKTNvrSKFC8MJe1OxfyZu/kwcB?=
 =?us-ascii?Q?yISsTjzj+5p8CB8UglwpaHemRDNTHa8e+bLddR2rO8O+c9K/TdZlsFmo0vOy?=
 =?us-ascii?Q?PSUQc6CGIoKVaE46kx2YP/V6g8d/BkuAVKqczuwv3V8nn/2RSmJ2kHxbp/0j?=
 =?us-ascii?Q?w7xMVbRW/cKilZA5zUU+V4VpzSQZsIkiqgwVUb3g96yI/7jOSft5uLAXRFhn?=
 =?us-ascii?Q?UW/gbMguEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ab9d97-d607-402e-3727-08de43898143
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2025 07:44:59.3081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7W0YGiW230+kvRU1O1WhaW+wJhK+008puq/fpZn4hFZeu0z89yW8MTYln9EU0J5Yb29EALgPWNmLESRVICuEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055

The WakeOvfIsDeferred code path in __call_rcu_nocb_wake() attempts to
wake rcuog when the callback count exceeds qhimark and callbacks aren't
done with their GP (newly queued or awaiting GP). However, a lot of
testing proves this wake is always redundant or useless.

In the flooding case, rcuog is always waiting for a GP to finish. So
waking up the rcuog thread is pointless. The timer wakeup adds overhead,
rcuog simply wakes up and goes back to sleep achieving nothing.

This path also adds a full memory barrier, and additional timer expiry
modifications unnecessarily.

The root cause is that WakeOvfIsDeferred fires when
!rcu_segcblist_ready_cbs() (GP not complete), but waking rcuog cannot
accelerate GP completion.

This commit therefore removes this path, which also adding some rdp
counters to ensure we don't have lost wake ups.

Tested with rcutorture scenarios: TREE01, TREE05, TREE08 (all NOCB
configurations) - all pass. Also stress tested using a kernel module
that floods call_rcu() to trigger the overload conditions and made the
observations confirming the findings.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h      |  3 ++-
 kernel/rcu/tree_nocb.h | 43 +++++++++++++++++-------------------------
 2 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b8bbe7960cda..03ff62f28d00 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -257,6 +257,8 @@ struct rcu_data {
 	unsigned long nocb_gp_loops;	/* # passes through wait code. */
 	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
 	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
+	bool nocb_gp_wake_attempt;	/* Was rcuog wake attempted? */
+	bool nocb_gp_serving;		/* Is rcuog serving this rdp? */
 	struct task_struct *nocb_cb_kthread;
 	struct list_head nocb_head_rdp; /*
 					 * Head of rcu_data list in wakeup chain,
@@ -301,7 +303,6 @@ struct rcu_data {
 #define RCU_NOCB_WAKE_BYPASS	1
 #define RCU_NOCB_WAKE_LAZY	2
 #define RCU_NOCB_WAKE		3
-#define RCU_NOCB_WAKE_FORCE	4
 
 #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
 					/* For jiffies_till_first_fqs and */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index e6cd56603cad..9f58589f08d7 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -518,10 +518,8 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 }
 
 /*
- * Awaken the no-CBs grace-period kthread if needed, either due to it
- * legitimately being asleep or due to overload conditions.
- *
- * If warranted, also wake up the kthread servicing this CPUs queues.
+ * Awaken the no-CBs grace-period kthread if needed due to it legitimately
+ * being asleep.
  */
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 				 unsigned long flags)
@@ -533,7 +531,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	long lazy_len;
 	long len;
 	struct task_struct *t;
-	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	// If we are being polled or there is no kthread, just leave.
 	t = READ_ONCE(rdp->nocb_gp_kthread);
@@ -549,24 +546,26 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	lazy_len = READ_ONCE(rdp->lazy_len);
 	if (was_alldone) {
 		rdp->qlen_last_fqs_check = len;
+		rdp->nocb_gp_wake_attempt = true;
+		rcu_nocb_unlock(rdp);
 		// Only lazy CBs in bypass list
 		if (lazy_len && bypass_len == lazy_len) {
-			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
 		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
-			rcu_nocb_unlock(rdp);
 			wake_nocb_gp(rdp, false);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
-			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
 		}
+
+		return;
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
-		/* ... or if many callbacks queued. */
+		/* Callback overload condition. */
+		WARN_ON_ONCE(!rdp->nocb_gp_wake_attempt && !rdp->nocb_gp_serving);
 		rdp->qlen_last_fqs_check = len;
 		j = jiffies;
 		if (j != rdp->nocb_gp_adv_time &&
@@ -575,21 +574,10 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
-		smp_mb(); /* Enqueue before timer_pending(). */
-		if ((rdp->nocb_cb_sleep ||
-		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
-		    !timer_pending(&rdp_gp->nocb_timer)) {
-			rcu_nocb_unlock(rdp);
-			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
-					   TPS("WakeOvfIsDeferred"));
-		} else {
-			rcu_nocb_unlock(rdp);
-			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
-		}
-	} else {
-		rcu_nocb_unlock(rdp);
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 	}
+
+	rcu_nocb_unlock(rdp);
+	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 }
 
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
@@ -702,10 +690,13 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		     bypass_ncbs > 2 * qhimark)) {
 			flush_bypass = true;
 		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
+			rdp->nocb_gp_wake_attempt = false;
+			rdp->nocb_gp_serving = false;
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue; /* No callbacks here, try next. */
 		}
 
+		rdp->nocb_gp_serving = true;
 		if (flush_bypass) {
 			// Bypass full or old, so flush it.
 			(void)rcu_nocb_try_flush_bypass(rdp, j);
@@ -966,7 +957,6 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
 					   unsigned long flags)
 	__releases(rdp_gp->nocb_gp_lock)
 {
-	int ndw;
 	int ret;
 
 	if (!rcu_nocb_need_deferred_wakeup(rdp_gp, level)) {
@@ -974,8 +964,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
 		return false;
 	}
 
-	ndw = rdp_gp->nocb_defer_wakeup;
-	ret = __wake_nocb_gp(rdp_gp, rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
+	ret = __wake_nocb_gp(rdp_gp, rdp, false, flags);
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
 
 	return ret;
@@ -1077,6 +1066,8 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	rcu_nocb_lock_irqsave(rdp, flags);
 	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 	WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
+	rdp->nocb_gp_wake_attempt = false;
+	rdp->nocb_gp_serving = false;
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	wake_gp = rcu_nocb_queue_toggle_rdp(rdp);
-- 
2.34.1

