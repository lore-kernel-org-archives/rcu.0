Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E9D18DF62;
	Sat,  5 Jul 2025 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751735995; cv=fail; b=F5lySxmyvcmO5sXf01VP3BnbB3v7nISjoBZvHsmxhoT9Gvj48lRn8rPJOvC9+tEZt91PDeMTxJ3CuCk36PIHx4E04MlfgDjBcfAS8bG85EseaHQOjWvVk/RGIVjN2Zu342BgmMCgPQSrT657QQB43POVZAHc1xK/8DygE4P80IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751735995; c=relaxed/simple;
	bh=6g7VKhRHSaJ1WgvgBhB/b1By/Uy9LWTvgqrt01zTwYk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j7BcncVBEGwSVXnVuw4rLePQ+8c9dfxHu7Tm3JZ5ZIToYw3ZwrEojimag+mvgxR8zbLijNiJIqq6KGUGVprnpKIu/UYDa16O0vlni7tBCmShspwY0PkIhnEzfDhIL+f+5oTz5sXcCssTboYXkivIe34mb/uumQNjdm8Oc2Chkzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UJNqilHF; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UJNqilHF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3VHaWFgo9LyfHRUs6K7EfsKUqSveY6DPwiqT+NF7AZZw/4XQE4NF70iFruI+nw/VjLy5Sgoywsd5l0ClwncJiXmvfBMzmprCehGXbYZ+qcYDuqLHIeEf73v6jmzYgTiIZdg6tJJ9zzavUDnXcZU991I97MEXt9rIU1gXM7ZhquiSPw9dNZ/VtHLz5A8ty9MpMNYrV0+QB6xf+p2Hv9a+9TI4ktdZK01+WbACKs3NViAjVy+ByHC2TXlliKpmWMrJHzWPZXuWnqSp4tLIB9wamQ+2lE5qKH1UkQ7Ia2UkgRxlvFig7PVTUROD0DTyNd+tsjrGguAprstuYs3lOojRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4MCSWU1t2QvI8vBajNqNzLjZCjFwBtXHdZ6bTbM9r0=;
 b=Vo6cRDSRow/AYtKu2cDcAcG29uT2cn1E5jJ3PZtPa/KTRSKNLztKJkFF3h98OnY3Do0Q2e1IKsfrP8W9861sP3bbg5MyT+qZ7ewyNJvE2UVuDVsdpVzGpqvCPNvBNXVPHNmqeMP5+GlM2f1o0ewbuugrzgPGnsW8mdv6mBE5vd8SVI7h+fh70Q3Y8/+43x2zZsq2L65BOCM+mkgHFttQ4G/o6QCa1I6ooGWsXLRUIEsFFwR3KC5ApD8W3QfU9hjHD2B3cfUjt1eh3mKBPHrIvYkq/O1wTo7rZKg5tiF/ZJUccZqwvwQXTwZ44OF3LeIYndRH8N3YhAHn9U/Nbg/KrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4MCSWU1t2QvI8vBajNqNzLjZCjFwBtXHdZ6bTbM9r0=;
 b=UJNqilHFfQoydvHolBh+CT/uEQbTYK1RkLnu55iF9H0HpTNYhYwoqao66efnad6Qh0Iy2JOnB9H9+bZx/fnkHWvvBDsccc8otPyp9fwV50Is/UaRmcbaAN6nBhAFmivObOtpPNAsGuMs495JfILu6NF4NBEAluYyqt/apr+EV/KrpjZub/7a/cVY3lXQvt+uQkS3zZGaVsEIYwXbQ1KsmDH2r06Rg8hOGFyKp04otQV4fjyPjJd3UvRoU5xW1wASash5xJd7wdIoXO7/Etxu/rlYP02Kyl2CzZlsMCjNjPmzhzrFINZek220MH3NgI9/jv/FUTVgeivitbbjijgdbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Sat, 5 Jul
 2025 17:19:48 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Sat, 5 Jul 2025
 17:19:48 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Andrea Righi <arighi@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	rcu@vger.kernel.org
Subject: [PATCH] smp: Document preemption and stop_machine() mutual exclusion
Date: Sat,  5 Jul 2025 13:19:44 -0400
Message-ID: <20250705171945.4113545-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:208:23d::7) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6f5c51-0f26-4079-c3ed-08ddbbe824dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZkaaeQKWdz/ofqXKjRNDu5xQ7YGQWBjP6qpqd0A2BGohVmzlH46E/uccnulC?=
 =?us-ascii?Q?zEQX9fFpWGRtesSW3kIStb7rNzzNxaCXek6kSZpQLsUEoJ4X5BZEGS5Nd3w5?=
 =?us-ascii?Q?FXLgwtIS5aQpCqkPBPtXbMDs7m6FOo94OaEB91BvRB6TxEaQamsotIdc4GCZ?=
 =?us-ascii?Q?RWPxIP4n8oa0RpC6HE1AIYimP6bAQiSnZgPsHhwYsg36LzwAfpAS4Ykfk3Uq?=
 =?us-ascii?Q?iHlXaCMKUjxX847BA94assZxTJD0YrtoBn6dlhs5Ux+6ZroAEmnjjkHfPxxs?=
 =?us-ascii?Q?+IbnHr1V2KThoAJE0JU4VssNWaB0WMnRsmLNnSXPx19T/Ww85NaiJANvbdIi?=
 =?us-ascii?Q?Hlkr1v4TsOzTcPXCkb6B9wK9tM4bAshMEO59gI5GVRgQYrNq1wHc2cykQL6i?=
 =?us-ascii?Q?iBkgp1arHE4eL/R36mnF4aaFi8B3l+IGCMYAd9d19uw37HoJR/38cxJWcb+B?=
 =?us-ascii?Q?iq7bEZsPqgiHM0qG+Po23Yx/uxz9eolaC3JzolFeywJnpDwJKkhK29WU9g4y?=
 =?us-ascii?Q?Nv1Nf+Y5QhDCSQY9YIeUjufiiPNMf8pLKWoFLA7MZlG4jKfWkCgDHSk16HOp?=
 =?us-ascii?Q?bXTRgQnhDz0vHzypuJG3tlUl7G0IhSipVZLncQQH6NT4PNn87eSBQiQKAWbJ?=
 =?us-ascii?Q?V8IYLh/9ElI7FI/bDVUUxlnz7yiX79m21Hxyxmfs60mLs2PNx8roI+Fp+rdp?=
 =?us-ascii?Q?uBlqLmUvDKoA4VqMcpjp2k1UowhL2Yf/frERD/6W1SPN4agzrpubdfhUn+/o?=
 =?us-ascii?Q?kpifiyHt2Zt7+we977VacDqEIJDnSh5Ovim7kRoAgXszPuQIKj+HNUy+7OKM?=
 =?us-ascii?Q?DALoz0dqWeC3Sg4Hvk8LYdlOZDNbCosoHJ8wDQH/Cx2nIkzGcNdNtq7bFv+k?=
 =?us-ascii?Q?5wjsVJI/1xCyh8lK8PFVekByuWGhy80SdQNLF8ODc/A8WaWCuE59LnQKfqKj?=
 =?us-ascii?Q?WKYX2oCKTP6/PV+yfV6WsECNDjrhuwZR5WbO9fNJqvd4XArpaNYTdgyLFEr9?=
 =?us-ascii?Q?i9foB4KaU0c/80OJcimuBtsgS4AavJWhJNUv+MRSdw5L3t+XaWASG5xlFlVL?=
 =?us-ascii?Q?MmcA7kFX0CFoiApDNWconxZwNccbSGIFCmJ9C9KNqpSB8+9D8jcmz/XSm93F?=
 =?us-ascii?Q?Cq7WBeAjdGc+MA82bwhN35S8BhqwYF8WlOGx5zctoT2M5DN3/wQdvq/FAsgZ?=
 =?us-ascii?Q?aj24go1jYveRGO2CFRRC79H9+x0Y+QDKXTX29ONRHjlIfRUfWc94KbQ0ZXeU?=
 =?us-ascii?Q?j0AGhWwsJjBSId0FoJR8+eKw+73m+eX3oeBt6o6he83yXwj9/lyayjSxWu/s?=
 =?us-ascii?Q?EcOf2fB7pYGa9/SnHs9WW9Skpkys/kBLuy/7ovcenez2R7uxObZ89Y07Yv4M?=
 =?us-ascii?Q?1t/tDcq1JRgVkQxs0GN7ag8OPj01Rbpk9R12R0tZANu91Vd6JH5JB20pANet?=
 =?us-ascii?Q?ZdyUnAscESM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sOrqDXGt+Mf7nCm68l03xMCIn0PAD2zOH3uw7RjzeTWzYsWS+Dvsuts17ryU?=
 =?us-ascii?Q?nPDn9jv+xRIKtjZrhjo9Q/UfZ9HPiZLWPr2sM3mPv5XNl07epgPS9V2xKwAH?=
 =?us-ascii?Q?DokuVfGxq7J83G25qCy4dBlhm6ueDkrUBP9kuIDtbGYUQGb2J+YM5+QVt7su?=
 =?us-ascii?Q?6pj4vZA74tUkWT8R72AfzPREPqVlcX//B9QkEKy5zcrOlZzSM6O48pf9R1Op?=
 =?us-ascii?Q?x2DgHx/Qp2COf7O/hoD6hXDQQMAtc5sLnMSoETEqNmM3QNlVN4UE5p7mFXEv?=
 =?us-ascii?Q?P1fWX6Vf0O7/RYqunSBq+AxiNhT1CPHLEns+PegmNrXuJvENRvnXGY1Ogop5?=
 =?us-ascii?Q?al7EGTAwVMxT1qsnDeKLcBm/mCxMFwuZmgwbZgPbWGIc7yCahl9xDfP+/I0J?=
 =?us-ascii?Q?qcxcwazmqx2JAQALQDCso/ChlPlKvPoZj1ulnlh1sMJiZFHaDQc4NCPFkerJ?=
 =?us-ascii?Q?QcEMvb2qiHUrQru06HGYLE4iyRrwBn10of/y7/66e3tpMgY23RB+xnr5MAe4?=
 =?us-ascii?Q?ni0To7A2gFlJYhLwck2ZQEarR6LYgbLYknYHdCImraK+Fo5lPb/PXAJGyFHl?=
 =?us-ascii?Q?K6GSsykEG/MsjCq1GDds+OeYHNF3wvB0y6EGAplNe3/6WG7gnYfC3g4YaUFb?=
 =?us-ascii?Q?lD908jGfwtnXSuvmW/N1HXCjfhpc09bEHwOdTS6Q9KmJeP3T/G5HIV+O0LpJ?=
 =?us-ascii?Q?uVJt7O/6s+xuP+vP0AVdvXUzBiw86bs5foQ2tSAdnzIXz5bI/kFeiEBGNMTu?=
 =?us-ascii?Q?YEXAPy2o1EQOtfKcwHRFAbIsteQutCiDgVuGBXFSGcd2KuO6GA2dipoROL++?=
 =?us-ascii?Q?rf2Jd00ctRFKacrnVh0GMgzEEW3hry7v++YHKQFniviKMt7FNli4gdzMFrYD?=
 =?us-ascii?Q?6Ew78fVxFRUVy+PBoLXLIuH16EMxIIaYLhfXQULOZGbCSXrIDWFcVOSB30Fx?=
 =?us-ascii?Q?SiAcQxgSMfQ44OM2VzKjDfQvDxYwy66GwZ+x2ZTIyWFq35dvOnm36wiIk6MV?=
 =?us-ascii?Q?U8Ey7G9bz82V/y6oeAGgt5zAPH+S2sNwp+1deQBvi77NfOdDQamSVf/P7iwX?=
 =?us-ascii?Q?zRk9PY/RVpBEXMKfbeRhc3AH/sJpXaZlJAaeUaMqJRoUseqQKT8AelCxwsno?=
 =?us-ascii?Q?EBFtxL+hq6KqbYwupxSCOVZyIfdZGusecP+zfBI37cI8KMTC4a70/UUkUDf3?=
 =?us-ascii?Q?Z7g1Z7c7nFoYHo+yOP0E7aElCqq9j9O+ED5vkAsQwUTb8UFDntpfovGbBbcP?=
 =?us-ascii?Q?369Eisocw31t2xOf39nmkNnLROZA9wjTfsSkDrmkhs9ZrLq825zPdZ+f28s0?=
 =?us-ascii?Q?gh7Nn/dOSaTIG0E88PWb7hnfpkp9INY8CvQnMxHOfiTqG6sqYErTvIMSvc+J?=
 =?us-ascii?Q?Ci5R2sbMQJ/cbshoYd8GXV06eKBy+MO6KooPlB/FCJUfZGdVsNWQa1D9h0+8?=
 =?us-ascii?Q?rOYLSyGMDj64AK7lbTFx+zGdpL458AdRtHY6eDtHEWuhBFbpCfxZ6JGcXJ+U?=
 =?us-ascii?Q?riChPekjWWnwqSmznOtgc8YcgP+XDqf3Q89GvgseCqbNs/nigDEOTYCDGltE?=
 =?us-ascii?Q?V4nUxH1ppNarB/pF8oAc2SEnQs2klRi4ZxEjXgVq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6f5c51-0f26-4079-c3ed-08ddbbe824dc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 17:19:48.3333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00z/7ICznDwXcbAa7EdpJblUazAcv6GHcoB0jqEP9sZaE8S7sm9IUOul0A4GD1G9/tYKYMjRkwQ6xmRQ7juMsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453

Recently while revising RCU's cpu online checks, there was some discussion
around how IPIs synchronize with hotplug.

Add comments explaining how preemption disable creates mutual exclusion with
CPU hotplug's stop_machine mechanism. The key insight is that stop_machine()
atomically updates CPU masks and flushes IPIs with interrupts disabled, and
cannot proceed while any CPU (including the IPI sender) has preemption
disabled.

Cc: Andrea Righi <arighi@nvidia.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org
Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/cpu.c |  4 ++++
 kernel/smp.c | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index a59e009e0be4..a8ce1395dd2c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1310,6 +1310,10 @@ static int takedown_cpu(unsigned int cpu)
 
 	/*
 	 * So now all preempt/rcu users must observe !cpu_active().
+	 *
+	 * stop_machine() waits for all CPUs to enable preemption. This lets
+	 * take_cpu_down() atomically update CPU masks and flush last IPI
+	 * before new IPIs can be attempted to be sent.
 	 */
 	err = stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));
 	if (err) {
diff --git a/kernel/smp.c b/kernel/smp.c
index 974f3a3962e8..842691467f9e 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -93,6 +93,9 @@ int smpcfd_dying_cpu(unsigned int cpu)
 	 * explicitly (without waiting for the IPIs to arrive), to
 	 * ensure that the outgoing CPU doesn't go offline with work
 	 * still pending.
+	 *
+	 * This runs in stop_machine's atomic context with interrupts disabled,
+	 * thus CPU offlining and IPI flushing happen together atomically.
 	 */
 	__flush_smp_call_function_queue(false);
 	irq_work_run();
@@ -418,6 +421,10 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
  */
 static int generic_exec_single(int cpu, call_single_data_t *csd)
 {
+	/*
+	 * Preemption must be disabled by caller to mutually exclude with
+	 * stop_machine() atomically updating CPU masks and flushing IPIs.
+	 */
 	if (cpu == smp_processor_id()) {
 		smp_call_func_t func = csd->func;
 		void *info = csd->info;
@@ -640,6 +647,11 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 	/*
 	 * prevent preemption and reschedule on another processor,
 	 * as well as CPU removal
+	 *
+	 * get_cpu() disables preemption, ensuring mutual exclusion with
+	 * stop_machine() where CPU offlining and last IPI flushing happen
+	 * atomically versus.This guarantees here that the cpu_online()
+	 * check and IPI sending are safe.
 	 */
 	this_cpu = get_cpu();
 
-- 
2.43.0

