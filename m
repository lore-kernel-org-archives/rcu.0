Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC81E1E1D;
	Sat,  5 Jul 2025 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751736221; cv=fail; b=uJVbp+3z8hvDdKyBkHDvnveQnwYLipr/fqAOffZJif9KU8OI9bdhxa091G9wod01GUzj1E5L76Gd680tBQMPe572B7uBywh5J37qeTpzFAYNDnFy3vD+JDn2AqbJqGUCpfuoU2HFiThk9vTmlrOx7NzIFbiOX2aIfrfyt0XbM+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751736221; c=relaxed/simple;
	bh=Fwk5lLXBGKYC5YH6KQXhYwe3Yb5DCUL2Aa5cMqOMeOs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HfM7Jz8Me1q8vEHvRaZItn85SOho8P8AxDUotwZMzN+B2fR7rxX3wB3GdvD2ovd72QKPgDaMVJJdNBUWXYipe+K5+Fu006UL9QgtUBCjeWHAKMIFq4DaVdTDplkI+RA9pglVqvyi68e8usdiF/8K7+MoghWxclLm2uWCH8/vfq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V2rHDK5V; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V2rHDK5V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCSei34xJ2qZbotOrtTyZrCHQw0YWA7egaD1NYkUXrDYXFn1AT6/qqbHIEM7O3XpLoCgoK9SsGxmPP32BFQi7g99983JINPHqnBQ27LJHCSrl+CzOFoJ1dY2atoVYdUiPlkn1Qs4DmvYwJcBitzFwM5EuTm3+hwqQOy7i7ro4v3d3dPbIkjAqHRyyCCt3+60i1mOPpA+xMCzYJtE2wm9Z/HlxOfmD1BOOFKW5I8SCaaYtWfrbwuzXs+Y0+wYJXE7GR/CKBhJo3p33cCtU26JQz6zOHpQFHW+Sy5Q7AYHCjvMpGdv3qHM4epu4Gzk7IGwDCx8XPW2ERlUeIFB0OYhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eoy54hKmiWUJNyuMZUhTU10AESOTJocGQ6eXY2ZM8u0=;
 b=vvx7I92OF9pBOlBjnRb6Lj1/iKoiLyd608foCHg442x9r16LNqtVcC7I2KR6AzVM2FN+cFfQvJk1D3t89x/jV0GgaJa3evU2WZ29Pdm/mt2AhXc66/Gg328PG1hVeF9Lj8dqFAP2c7kaRWBh5KYuO4xqWvnZ1JTqEnqMXi+sDBRs2vidka4I+7fPGBOWHWk1QccA8KRpsBduBeXEPhIoy5oc5a8JcJBx0+UGAcLEo1MGB4E7J/osPfQDXzDvqwda43BRY9hz3UwBbI1hDm+HV/jVqICwfN6bVHB9H00Tb17YkeaUo2vLgv6f6Y7Xc/7QHhu8kSolJwOL/jSaGRgmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eoy54hKmiWUJNyuMZUhTU10AESOTJocGQ6eXY2ZM8u0=;
 b=V2rHDK5VCc7coZyvJ9Pdz/DILSnCJfD6RV3MEGZmuniHGIzxXpsvSCthci7Rj82KtQwYoiAv002Mk02mrn+2aAQtdscrFEYqdL4yeTFfv/bCmHqkt+vqwijk4svjK0LjcuXOXxGzoFBtYTC/aQNqNX2pLtV/jpvC4NEoziHlWxFXS9LS4aOai0835PFqyX/oUa9tME9H72RnimotPnR3ApiOb2o06rA8zJqQVBSUe773bvLW3IRPnL83KZi4LcA74ggXZSdQZ5vIYGElrkg5qG7nEDc+gzu+xvVnKoT+Hwbb6caFUeI+eSSZ/q7l6SZLYM/pstO7x5jlsRXaT5wTBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Sat, 5 Jul
 2025 17:23:34 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Sat, 5 Jul 2025
 17:23:34 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Andrea Righi <arighi@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	rcu@vger.kernel.org
Subject: [PATCH v2] smp: Document preemption and stop_machine() mutual exclusion
Date: Sat,  5 Jul 2025 13:23:27 -0400
Message-ID: <20250705172328.4114289-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0023.prod.exchangelabs.com (2603:10b6:208:71::36)
 To SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 06694e4f-7d36-468e-3699-08ddbbe8ab8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DDJALBEjNFq3+UXmvnr5eJOtIqDSIYCYWB+SX/rg+o4BlJreUvP8zIFHCyOl?=
 =?us-ascii?Q?saYYFJ88ofUSvgS+T49oy3c6MRbgoXzEInfIjehl6zeT3QIKiuvFD7LezNiy?=
 =?us-ascii?Q?nTLvB/icI2DCy5NVN+YvNPKSXIO9TI0hX9oaFM4Gl84/pIWn8DGMeRfNGxzj?=
 =?us-ascii?Q?Pv5ylb/u0hYft9EZtwKNRrJ0R5o2eHsx0FoKbBaUvyidtYOU9/uUy/re7c8s?=
 =?us-ascii?Q?fDJgsJ0zg36lV9ZxwWI1zMywKYTcXSHHw+aIzZqTs9n7NyOCjVNVG90LFi48?=
 =?us-ascii?Q?NAZpxhTR89Uf3rRDkJPT2bjt154MDTcCAoWTVj1rOkADSwf/qXuSfodIfWPN?=
 =?us-ascii?Q?ehcsEgQMifO/AkBk3s+BF+VhT60JXtv5PUnuUbu73lGRtsXEuuhP2Eha6nYE?=
 =?us-ascii?Q?MzgU/QhEdclMZheD6Onsv8bHBQGxf6IoCUbLi5oLYPjEZY98+zxROI86Mpd+?=
 =?us-ascii?Q?isLQQjlSgHggS9sHLy5GaitxEqZe7ricsi9Ta947gid9rNDGuG9U0lwLHyNC?=
 =?us-ascii?Q?WXrQHUYpf/gyC66TPGqDrhtvrve53kvVhH1KDlqgKEga7zU5Cl5mSy4e+GDK?=
 =?us-ascii?Q?6xdUGn04y74AwzzaxNHMXqhh2ahLh/s1rYo4Rd3plef23urFHx5sfDecQ6Ou?=
 =?us-ascii?Q?r2cL6wsBvkx3ARCE3CPV3iMm+BNljbkV/SvKMGElEYQBSt9Uri2QhfM8JW8J?=
 =?us-ascii?Q?0yopW6hOxdMUsNptQHKGlMnoPqwzEWBYAIOk2XcvdW6J/Ad+FAi0s+nHuaim?=
 =?us-ascii?Q?QFByOC6bVQDsiz352tGvT4AxFDClgT5GmF5QTvYj/jhgEeGOMPTylcCzoitA?=
 =?us-ascii?Q?o6PeXGvJXhVwc21UeuOVz5eIVAtbC3YncHjpPJJTqr1kU6bSixotXpGZWUop?=
 =?us-ascii?Q?5wYPktRsbHJp95iFoppYIl/xshw8wqvDa4NDDIye0ZPBegSERAenB2ZB8A/d?=
 =?us-ascii?Q?BxTNR+kw+8xU62sIgti/7mVPGTOS3OLWG88rmajnS4bFOPimNnQS0axLsGKW?=
 =?us-ascii?Q?sxnic2x/DgFIj2dWAZbyrj3Hk96aTDa/Q+k3+I9WkuyqzDMvD6o7lTZ3bV8b?=
 =?us-ascii?Q?q8hiX9fY2d941Gbi1ZvEKf6jvBGuovtZ8A/p/jkZDDjEoyROHtWkWvM6fEKi?=
 =?us-ascii?Q?0AdSZOCSfobQqveVZIWUuOeJIgxb2AYOQko6SgL9mTELlIU7JIgZfE8Y3Mpr?=
 =?us-ascii?Q?bB49RhR/znFB+Heh2ralLdqwsVmkMtYIzD8mDok6XYZp+t0RTU7x6Lg74ETx?=
 =?us-ascii?Q?N1N/wZSLr5oQ6K6rvVIviyP1q8MYExeD4JvPgvfeKN/zG5W59sUa+TmmRN0Y?=
 =?us-ascii?Q?oOhdkQ1ndCPz4J5hyCbf7/8ar4E6dXqFHPgxM8C20FXXmnL6i4sjHTDX5xbN?=
 =?us-ascii?Q?077MtyOYL9oGFd4dATkkbg7V2Yt3R/BMaKFPy0VeUFYLvwRpRI+3bj8FozeP?=
 =?us-ascii?Q?jlhVzHhz+us=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kRN105Sl3uLqarnkiofYSV79Plc9PKr5MBer6FCsvdt5y/4iU/73HWzYRl+H?=
 =?us-ascii?Q?wRMzo1PYEjDKf+oR79gu77hndqH2L1ozOX+eppIGGawaR/z+t5NmU2NiDxg/?=
 =?us-ascii?Q?74UxxC3MPWtLxn+mvM5ebktnvxSm+2+13OzUJO7lUTLb/IMKtG5WLcusOVfn?=
 =?us-ascii?Q?DkWj3nOojWy0O+aIxcC+QMMdppUrqHROZlhoSuNhGk5+TanDNPY7a/cUpo+9?=
 =?us-ascii?Q?nr7kmRPkrmq02p6iOGgNkIMxtckju0RTD71t8JmlW2FW7KudkBfgaDPYsYca?=
 =?us-ascii?Q?e+axjlZj4AEO3+/1xrD6OfFkxDTjn3z5j8l+0/7u3r7yE1R+OXm1NWQRrUG3?=
 =?us-ascii?Q?zP1V2EBDpfWRcLT7xvjgB+YJUKPENlWLoOvMOZo8UHIg+yay5CG6GjfJui/h?=
 =?us-ascii?Q?kX8hnRPuMAiNV6D2I0NizM/PpP0I80a7XCHnd22n8ZANP/fBbUxJeJBDADLd?=
 =?us-ascii?Q?vV4F4BBg4ibhaue/YEbl/lnyh5X2uuMVSPfbgEoWbsgZfB24XhFg7q3+hjrF?=
 =?us-ascii?Q?ox2aLtCynP8klyOf6VYOOJ+OiUcCrZI7jrgMsNJ6efZ2fgo5mGoiv68Tne8L?=
 =?us-ascii?Q?nzht4l65m8G6GxLv6Y3BAVt2KebDKnhNFNBefjzNCkchg8KC1A8k/gYxLxUb?=
 =?us-ascii?Q?TcQ/lg8n1n88Lakwigzrj/dgV49Mz+UwXOKV76V6MvLi4NU6fjBBQC1AOLL0?=
 =?us-ascii?Q?qsYachY23xyVFjdqZM51D9XSvbZXvVa0fbvHjZtzfOHJJ/GryBQHAryUa4hH?=
 =?us-ascii?Q?LYtIpLhAHlep2HfJ4BFKyFp5br16a20e9r3ii28/IR0kCRghQphDOdQyeX+5?=
 =?us-ascii?Q?Z5lnSZT35lxs+QHX6omX3xQE0zXV67r6J2RBg5q3D1N6hEI/oEuEO9zU7rKL?=
 =?us-ascii?Q?T5lJeU+m112Lno16SgV/VmiccNv7xl/cNzWACdoVDkAerNpG5ajxtydqdppX?=
 =?us-ascii?Q?vqjHITz+YQtUzZUG6MazHJS7vr6vn7CFQq+uEWt/5XJpnGsoWLZQngIYiQ10?=
 =?us-ascii?Q?/MfY9b4smhxBl6vxJlgXVO936j8PZXK3OHzVbn2XBNcPokW+VcTBsX01xb4n?=
 =?us-ascii?Q?ZwKICycGgL1jSyT8HPYBE8MN4HTCxpvufHP/v+sqPfv9oQwFMVRU2vihvFI0?=
 =?us-ascii?Q?2rYd0SiOvztWnqL7PS+jnKRwFW45fy1BYd1n1v/U7SQHZYXYJCXVh8vxoidX?=
 =?us-ascii?Q?zjUupYagR5AITWYhOlQTyTqSMSC64VKBC763UQnHK1kKOcsmYvnfOfAmCay3?=
 =?us-ascii?Q?dOtXYUj4A8HOCoOUIbMWZfIXuzzmx07TA51lTelbcmvf47YQog8NTUQ1rfDC?=
 =?us-ascii?Q?V2N+2k06g1lxDrWVjoh2B+qaVOEp87sGcQyKPuI8DLteDTm+afzvXRmPTuMS?=
 =?us-ascii?Q?K7xjqIeYtAeGM8mgKEH14KspZsa+GZlW5qtJPAA5bpMW1fujWs+SdCRdqucy?=
 =?us-ascii?Q?1oPgkn1h7mdsFX1FiAYkhZ2HTWtQNl2CZpLMjI8Aia/nPXxbLkR6tzExdU3Q?=
 =?us-ascii?Q?CqQFWmMMGg7NDKW0DBYUGQIXH7TVxXejCyKVX7HsS8WKByvFMCU4cOfcCqtz?=
 =?us-ascii?Q?EMG0qX/pvjRh1QkGkgREUuRuRNjy1Kn/aUAzNvs4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06694e4f-7d36-468e-3699-08ddbbe8ab8b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 17:23:34.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5YXJ6xMCIrRwoBjpjRSxJ5Ut4pULpH2BHhM4KH0HiPJZLHyXbCkMQmx1UNzBSYLMYIJlMYfiRsQWd0Dhwb22Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669

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
v1->v2: Reworded a bit more (minor nit).

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
+	 * atomically versus this code. This guarantees here that the cpu_online()
+	 * check and IPI sending are safe without losing IPIs due to offlining.
 	 */
 	this_cpu = get_cpu();
 
-- 
2.43.0

