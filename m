Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB45547073;
	Mon,  5 Oct 2026 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791161823; cv=fail; b=QtGZEdW/Y4mAYGCVT6eZ/x56G4qRXdtYVFEE4uEW53SYIJt+zp+0KUIQ1p4WcCHPzPFY4IZjBr54B70ql5llG+npyfrGGxZAb81CAY0/Ri3l3EvRzuNQ7XiUnM2fodXgnOCH6iq7xWlS3MLhSKWFaYmu12vzruCma19sPvmi/O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791161823; c=relaxed/simple;
	bh=wDCziOW4XhnQub2D5wghkarKe4OkbzCj1Q4S1oShOrE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A8EhpeSr7bquX3o9QoBa2k3dfKuZ1DS9hKSfQB4pPGwh2UDIrm5ajA6eX4dgShh+Kq44qkgg/ek/OixlNS5OeRH6ViJCPLSLJhfoKHsUnNXOmxf2/MK6zUo+1Ac/1BaFRhoMJeSNd+cX63UHaMkBEHHdsYfaOESP/M3FEmUM124=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V38toKVJ; arc=fail smtp.client-ip=40.107.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V38toKVJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft5F1XzEe19ctYKrJXMa1yk2SX4tGQ2R1o9woo2gWkzuu0pgc+XzcQRElUnsXtqYCxCa9FWqGHuGPZuZEqbYuLlgpO93QPDYMXmStqMfCEZSI6OQDyMIN+SzftgCjf2M83ZyHaCotUBKKkjAV9tjiPm1H9jCwoXru5LFydGcX0ztFAgChLhj6Lhu85GP4/w95YQFgn/w5+HaT5nJILll0op+Gy2ILtxis52p99kebOfzN1FzxCGjabAVeVd/pxzdFbwU6yJ+dDb7aT2wYKawS8IoQ4B8yrYOP+n3Bjfk3hAbs7Rb2xVEWEmHN0dmRXA7O63Ig0+OIPHx76qAFzu37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhcQKXybaCUSTyu+u1rnGIpuOqJNluG1C5lw1OY7dDU=;
 b=QCy72JVZ4ILwZWvAC6J7Q+GkDf7DEQSAXN+6AY7IYMZkJUp/Ez8jQYZ1GOIbS8CaRjINzdR4X1vnK/e/N2YJIWOzYVFVg0Ao6h/dUfjthYxzATHdaUTCOqr/cwp5SN62QHXq12Txd2lOcV0/r36C++hmFppaudWs+Keb9NiCbF7Y4VDSFOTVhP5VaJH49DOh3AXRHg14paquZq+4N5i/CZoJShNHi9X+ihAFCJgW+JY9nKUvjRsvAnatEhTfRfamHujG4Gfww65H1zXTQvNaIVY/j5pWiMJ+hjtcASuNGDL9i0K+Ve1K19Kmy4/dSQyE5P+kEOs4O6u/QbbpVL1tTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhcQKXybaCUSTyu+u1rnGIpuOqJNluG1C5lw1OY7dDU=;
 b=V38toKVJP3VXoJ4nqsSnr0Sxn5tS4to0rS/A0XYvxQKE9cpR0df2VcbvbHGIU8TY3ojVJe3mkTHLREVXoeettxh+WPeO1kTMXpFjb+dv3nXpjdkwc+x+g7py3aKiL2fPM4O6KrtLI7TqKQNGHh2VNNFKRxz+4M4ZcUFr2BgdT1F5i4Q4F0i0nuk3/Bx1GthwRRqg5C0h3KEneWNuGiua3b910Zwecr3VzrfjrrZbzjmIvMyk2AV3WiNhq3jmQEN5kANPPPavhJgljMxy1+qtosYCJOjUbUA5DQwA3XbWX8P/pyrgXHCXNEkTbbY9FibzC3N6HSK7S7ltcReKe+Q0qA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 00:56:54 +0000
Received: from CY5PR12MB6479.namprd12.prod.outlook.com
 ([fe80::229a:704f:1349:5056]) by CY5PR12MB6479.namprd12.prod.outlook.com
 ([fe80::229a:704f:1349:5056%4]) with mapi id 15.21.0472.015; Mon, 5 Oct 2026
 00:56:54 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH] rcuscale: Consolidate per-writer arrays into struct writer_state
Date: Sun,  4 Oct 2026 20:56:41 -0400
Message-ID: <20261005005642.2312272-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:52c::23) To CY5PR12MB6479.namprd12.prod.outlook.com
 (2603:10b6:930:34::17)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6479:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: f43d4c81-d5d6-468d-371d-08df227b8c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|6133799003|18002099003|10067099003|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	yfHM02jXr3hfYvxMsz25EYnLcDQlcskjYJw6UqK4eV6cFi+/IY5OBXOKBKgVmFXKwKFPXUBZNkwmSEEmUxh3z/MHmkOIEI1UDGrlZFpsmabpk6/y70vKkqfKLQDOahLKcBvqFgOgUo3bci3dUIWd2haqnoaJSRFJChY6bmnnFYo0YzK+Dn5KBVY6LWggS1UavBQdI1T3CiHCTzph3nPDNhsu0nvFHWvBeCrprij0+Po5PDei9/emZZcXw1bOz438/QzCnzxUjIiWVx7Qi8X+zp5yY/s+izjXF/Uuv1Ng+Zzx+Zl+KEJj7rSwaMiXm7K4N6ggOh0NwQHB0m+VPrD8X6yMSeXq8QAxecdGdmopt8/UjDxffhuNhMlAJgNHTr/4aTc6jNx2ZuCpEvi8PqW8Vno1l58gP7ZjxOthts6RM3pHFm+p3KNJ3PSrAHs9oF+I9UAgzeAWHvoCORq7meKOPxegF02bWTjM7ncMO7gSsWzGkn/WCM49oVUrRCjayU6zzBKS2x8It52XF2GiTHbk0u3aX8OKZQwcMixpnDVR4NH2+Dy9t5PnuzBxIpExUt3y2oB0/qtBl05iixOMAiBlY5VYWoNcMAWLVEghWBNN1aTtTq4imdRTzNIYRYUuMOiVVwUR+xZnHIeVV6a80jOZhzRCIu7xttJaT5yCBzScqUNJPkPrSHs+nosws4FElDVbOOz6IWtYo5PyEGvWa1XAjg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(6133799003)(18002099003)(10067099003)(921020)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bhs1ZAlqa6dzs83h+zX6vX7aS5+lnorCuI7JmkdiAnAml/enwNCtjK3EOyha?=
 =?us-ascii?Q?NCa1gDECSal2x53ZrwonXMVeOKWez1o0jgkpsl9Q+uhNFqTzaPV/Ffegbtg8?=
 =?us-ascii?Q?hOOqpgOrjkZrYhiDa4W+yXl+9mNhLfec9ppi38B3D0CbhdeDus+Su9RRm0dP?=
 =?us-ascii?Q?bN+V/lcu6P08uhn7mR0vAN16K98hmxS1qdVZFAQ8VDR6QmaHKjLD0b9mjcPO?=
 =?us-ascii?Q?BtzCVK7lHZkQwzxAvqsmv8ZEcF+wSW3vUotgcT3m/tCDdfkNmMw/5G+s9d1V?=
 =?us-ascii?Q?jdX14JsByPV8/KuAFBafvCMVjIEVRtNBbKjqqBbY6iRvl8oRDo87Ol+KGMZG?=
 =?us-ascii?Q?Xwee40sP13ruynGIExrFlbIIH8yeb/wKLQelm/+bkesU1xRQ+7mVLvibz+cb?=
 =?us-ascii?Q?XEVbFetYvS7Wp7/36SnheRdt05D6+0ASv7G3B7Mex4cQKIt1HMn3vQn4qWf3?=
 =?us-ascii?Q?gtGCLK7usmy/AaqICIpH+H6iHF2Alx3IjBbYglG1jdXcgRYhqMWzeYRXUy5h?=
 =?us-ascii?Q?UKmANc8kiOOu9Ojj2wHVxP/H6PvHTaDWGE/xCSmvfqQLByXfNUZtF1vfA76m?=
 =?us-ascii?Q?d5NcOQw4pzxvmtRVsOK5DwGKoiBax4qEZVxlOXtlznTkkir0wB8XrQPpDrEE?=
 =?us-ascii?Q?oPRbXcc8wzcpHHEA1EMfRdxN33CTMmnyzZ41bWYOn49VyV5YyLMwRxbD45TN?=
 =?us-ascii?Q?5QpabTjnR81LNOLTz+uUWPhh5mVTr00ZdDMhSHan1GHAJ/XbSUIESA5anaK9?=
 =?us-ascii?Q?GzLANGf4tm6GU2MXcX2rqLIe8Pr+3WWpPKKl5VJhRJGX0O+31Br87jel0Ns6?=
 =?us-ascii?Q?1HHgnTMuJKKAe17MyNrtbHgnv5UrQcypzaGu/KJ1w7mHVdjKLVaAsirStglc?=
 =?us-ascii?Q?DKgNGQMPnenkZ18CsLxiZ37OfQ5j1+RggJBPiXh0ssznf0hvvsCKCqn7cWxk?=
 =?us-ascii?Q?s4t0zTMrh94dnPlgPDMr3ZnAOSKCnFbItDzx8sRjyj79sWD3zT0imQsFUWTN?=
 =?us-ascii?Q?WUPt4x+xLszRZ6N5mLOBPI6YIt+czAz4ib2MwE1Fud90GRli+51zsmGWCRJv?=
 =?us-ascii?Q?LRyQI2Rn/PRXiucA6l4xLsBw+1Q/RovomPYDKWCXngQBy9mS2eailBUOJ3FD?=
 =?us-ascii?Q?RySAgDW7Befy1wqprfJ5uccs359ea2ysbHPNq9mmygmez9P0Nr9sM+oUZtJI?=
 =?us-ascii?Q?vCtHT7LNprRoONNqlZKviIvfys1hsgO9aH7bdSZH6t17reLFhAwyA/gqCac4?=
 =?us-ascii?Q?wWpQlkBKSuH+TqVgQfTuuklsk8UM+quzC/07YXBAODdz5WG0yqMt58YOZ84I?=
 =?us-ascii?Q?OANz+NaV2XBXKLvx13omzoROMH6iEv6lld/ZaldJ6x/dR9eVp1Tg8vBMAU/Y?=
 =?us-ascii?Q?eY2vU4YMQpgHvWJ3PKgbjYMTcyjQYbtDBPl3XJQPMb9w8MoliirLZP9WgsXo?=
 =?us-ascii?Q?OMOWHXX8E4zn+tQ5U6awIVvNL8uvKPLwJxDWmCKQEG0iMFVIZeKn880TI91d?=
 =?us-ascii?Q?BN7cBdLh1RGwqSOeHcGRin6/6XCH1ldHfr0ehm7DR1ASoXBLkiAQb28ECK/B?=
 =?us-ascii?Q?bwwy7vQekWMxMhu11qDqc6m/9dLC0kQ4SEQN+Rdp6d2f86AFDDRHfcDH45Px?=
 =?us-ascii?Q?+UK2yfZXTVEG1NBl3Sw829hEHbqC6luWvZ6HJdsvGdpDanKmNefHlU/5nDOc?=
 =?us-ascii?Q?u5EvdWY6DuV91u2BoliR69iu3MZzGq9LY+lgDtyrpgoMTPAWff3iUitBgGxk?=
 =?us-ascii?Q?FD56az8nEw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43d4c81-d5d6-468d-371d-08df227b8c3d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 00:56:54.0437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wC1JTZXsG8gThuWdSnmwKIz+9Y1P9msg3tglr48DF6sPvTdWVlQthbSSXUdNzU9FYixjZcLuVr9+gglwrNCtRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

The writer kthreads keep their state in five parallel arrays indexed by
writer number: writer_tasks, writer_durations, writer_n_durations,
writer_done and writer_freelists.  Each must be allocated, NULL-checked,
freed and cleared separately, and the cleanup path needs several
guards to cope with any one of them being missing.

Collapse them into a single array of struct writer_state, holding the
task pointer, the duration buffer, the measurement count, the done flag
and the existing struct writer_freelist.

This reduces initialization to one allocation and one out-of-memory
check, and cleanup to a single kfree().  As a side effect, this also
fixes a leak: cleanup only ran its frees under "if (writer_tasks)", so
if the writer_tasks allocation failed while a later allocation (for
example writer_durations or writer_n_durations) still succeeded, those
already-allocated arrays were never freed.  With a single allocation,
that partial-allocation state can no longer occur.

Assisted-by: Codex
Fixes: 8704baab9bc8 ("rcutorture: Add RCU grace-period performance tests")
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcuscale.c | 127 ++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 72 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 1097ec15879c..f0bca5dcc754 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -115,17 +115,21 @@ struct writer_freelist {
 	struct writer_mblock *ws_mblocks;
 };
 
+struct writer_state {
+	struct writer_freelist wst_fl;
+	struct task_struct *wst_task;
+	u64 *wst_durations;
+	int wst_n_durations;
+	bool wst_done;
+};
+
 static int nrealreaders;
 static int nrealwriters;
 static int nrealexp;
-static struct task_struct **writer_tasks;
 static struct task_struct **reader_tasks;
 static struct task_struct **exp_tasks;
 
-static u64 **writer_durations;
-static bool *writer_done;
-static struct writer_freelist *writer_freelists;
-static int *writer_n_durations;
+static struct writer_state *writer_states;
 static atomic_t n_rcu_scale_reader_started;
 static atomic_t n_rcu_scale_writer_started;
 static atomic_t n_rcu_scale_writer_finished;
@@ -504,9 +508,9 @@ static struct writer_mblock *rcu_scale_alloc(long me)
 	struct writer_freelist *wflp;
 	struct writer_mblock *wmbp;
 
-	if (WARN_ON_ONCE(!writer_freelists))
+	if (WARN_ON_ONCE(!writer_states))
 		return NULL;
-	wflp = &writer_freelists[me];
+	wflp = &writer_states[me].wst_fl;
 	if (llist_empty(&wflp->ws_lhp)) {
 		// ->ws_lhp is private to its rcu_scale_writer task.
 		wmbp = container_of(llist_del_all(&wflp->ws_lhg), struct writer_mblock, wmb_node);
@@ -560,8 +564,9 @@ rcu_scale_writer(void *arg)
 	u64 t;
 	DEFINE_TORTURE_RANDOM(tr);
 	u64 *wdp;
-	u64 *wdpp = writer_durations[me];
-	struct writer_freelist *wflp = &writer_freelists[me];
+	struct writer_state *wsp = &writer_states[me];
+	u64 *wdpp = wsp->wst_durations;
+	struct writer_freelist *wflp = &wsp->wst_fl;
 	struct writer_mblock *wmbp = NULL;
 
 	VERBOSE_SCALEOUT_STRING("rcu_scale_writer task started");
@@ -631,7 +636,7 @@ rcu_scale_writer(void *arg)
 			started = true;
 		if (!done && i >= MIN_MEAS && time_after(jiffies, jdone)) {
 			done = true;
-			WRITE_ONCE(writer_done[me], true);
+			WRITE_ONCE(wsp->wst_done, true);
 			sched_set_normal(current, 0);
 			pr_alert("%s%s rcu_scale_writer %ld has %d measurements\n",
 				 scale_type, SCALE_FLAG, me, MIN_MEAS);
@@ -649,7 +654,7 @@ rcu_scale_writer(void *arg)
 						cur_ops->get_gp_seq();
 				}
 				if (shutdown_secs) {
-					writer_tasks[me] = NULL;
+					wsp->wst_task = NULL;
 					smp_mb(); /* Assign before wake. */
 					rcu_scale_cleanup();
 					kernel_power_off();
@@ -665,10 +670,10 @@ rcu_scale_writer(void *arg)
 
 			if (!atomic_xchg(&dumped, 1)) {
 				for (i = 0; i < nrealwriters; i++) {
-					if (writer_done[i])
+					if (writer_states[i].wst_done)
 						continue;
 					pr_info("%s: Task %ld flags writer %d:\n", __func__, me, i);
-					sched_show_task(writer_tasks[i]);
+					sched_show_task(writer_states[i].wst_task);
 				}
 				if (cur_ops->stats)
 					cur_ops->stats();
@@ -676,7 +681,7 @@ rcu_scale_writer(void *arg)
 		}
 		if (!selfreport && time_after(jiffies, jdone + HZ * (70 + me))) {
 			pr_info("%s: Writer %ld self-report: started %d done %d/%d->%d i %d jdone %lu.\n",
-				__func__, me, started, done, writer_done[me], atomic_read(&n_rcu_scale_writer_finished), i, jiffies - jdone);
+				__func__, me, started, done, wsp->wst_done, atomic_read(&n_rcu_scale_writer_finished), i, jiffies - jdone);
 			selfreport = true;
 		}
 		if (gp_succeeded && started && !alldone && i < MAX_MEAS - 1)
@@ -687,7 +692,7 @@ rcu_scale_writer(void *arg)
 		rcu_scale_free(wmbp);
 		cur_ops->gp_barrier();
 	}
-	writer_n_durations[me] = i_max + 1;
+	wsp->wst_n_durations = i_max + 1;
 	torture_kthread_stopping("rcu_scale_writer");
 	return 0;
 }
@@ -1031,13 +1036,11 @@ rcu_scale_cleanup(void)
 		reader_tasks = NULL;
 	}
 
-	if (writer_tasks) {
+	if (writer_states) {
 		for (i = 0; i < nrealwriters; i++) {
 			torture_stop_kthread(rcu_scale_writer,
-					     writer_tasks[i]);
-			if (!writer_n_durations)
-				continue;
-			j = writer_n_durations[i];
+					     writer_states[i].wst_task);
+			j = writer_states[i].wst_n_durations;
 			pr_alert("%s%s writer %d gps: %d\n",
 				 scale_type, SCALE_FLAG, i, j);
 			ngps += j;
@@ -1051,14 +1054,12 @@ rcu_scale_cleanup(void)
 			 rcuscale_seq_diff(b_rcu_gp_test_finished,
 					   b_rcu_gp_test_started));
 		for (i = 0; i < nrealwriters; i++) {
-			if (!writer_durations)
-				break;
-			if (!writer_n_durations)
-				continue;
-			wdpp = writer_durations[i];
+			struct writer_state *wsp = &writer_states[i];
+
+			wdpp = wsp->wst_durations;
 			if (!wdpp)
 				continue;
-			for (j = 0; j < writer_n_durations[i]; j++) {
+			for (j = 0; j < wsp->wst_n_durations; j++) {
 				wdp = &wdpp[j];
 				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
 					scale_type, SCALE_FLAG,
@@ -1066,34 +1067,23 @@ rcu_scale_cleanup(void)
 				if (j % 100 == 0)
 					schedule_timeout_uninterruptible(1);
 			}
-			kfree(writer_durations[i]);
-			if (writer_freelists) {
+			kfree(wdpp);
+			if (wsp->wst_fl.ws_mblocks) {
 				int ctr = 0;
 				struct llist_node *llnp;
-				struct writer_freelist *wflp = &writer_freelists[i];
 
-				if (wflp->ws_mblocks) {
-					llist_for_each(llnp, wflp->ws_lhg.first)
-						ctr++;
-					llist_for_each(llnp, wflp->ws_lhp.first)
-						ctr++;
-					WARN_ONCE(ctr != gp_async_max,
-						  "%s: ctr = %d gp_async_max = %d\n",
-						  __func__, ctr, gp_async_max);
-					kfree(wflp->ws_mblocks);
-				}
+				llist_for_each(llnp, wsp->wst_fl.ws_lhg.first)
+					ctr++;
+				llist_for_each(llnp, wsp->wst_fl.ws_lhp.first)
+					ctr++;
+				WARN_ONCE(ctr != gp_async_max,
+					  "%s: ctr = %d gp_async_max = %d\n",
+					  __func__, ctr, gp_async_max);
+				kfree(wsp->wst_fl.ws_mblocks);
 			}
 		}
-		kfree(writer_tasks);
-		writer_tasks = NULL;
-		kfree(writer_durations);
-		writer_durations = NULL;
-		kfree(writer_n_durations);
-		writer_n_durations = NULL;
-		kfree(writer_done);
-		writer_done = NULL;
-		kfree(writer_freelists);
-		writer_freelists = NULL;
+		kfree(writer_states);
+		writer_states = NULL;
 	}
 
 	/* Do torture-type-specific cleanup operations.  */
@@ -1187,37 +1177,30 @@ rcu_scale_init(void)
 				goto unwind;
 		}
 	}
-	writer_tasks = kzalloc_objs(writer_tasks[0], nrealwriters);
-	writer_durations = kcalloc(nrealwriters, sizeof(*writer_durations), GFP_KERNEL);
-	writer_n_durations = kzalloc_objs(*writer_n_durations, nrealwriters);
-	writer_done = kzalloc_objs(writer_done[0], nrealwriters);
-	if (gp_async) {
-		if (gp_async_max <= 0) {
-			pr_warn("%s: gp_async_max = %d must be greater than zero.\n",
-				__func__, gp_async_max);
-			WARN_ON_ONCE(IS_BUILTIN(CONFIG_RCU_TORTURE_TEST));
-			firsterr = -EINVAL;
-			goto unwind;
-		}
-		writer_freelists = kzalloc_objs(writer_freelists[0],
-						nrealwriters);
+	writer_states = kzalloc_objs(writer_states[0], nrealwriters);
+	if (gp_async && gp_async_max <= 0) {
+		pr_warn("%s: gp_async_max = %d must be greater than zero.\n",
+			__func__, gp_async_max);
+		WARN_ON_ONCE(IS_BUILTIN(CONFIG_RCU_TORTURE_TEST));
+		firsterr = -EINVAL;
+		goto unwind;
 	}
-	if (!writer_tasks || !writer_durations || !writer_n_durations || !writer_done ||
-	    (gp_async && !writer_freelists)) {
+	if (!writer_states) {
 		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
 	for (i = 0; i < nrealwriters; i++) {
-		writer_durations[i] =
-			kcalloc(MAX_MEAS, sizeof(*writer_durations[i]),
-				GFP_KERNEL);
-		if (!writer_durations[i]) {
+		struct writer_state *wsp = &writer_states[i];
+
+		wsp->wst_durations = kcalloc(MAX_MEAS, sizeof(*wsp->wst_durations),
+					     GFP_KERNEL);
+		if (!wsp->wst_durations) {
 			firsterr = -ENOMEM;
 			goto unwind;
 		}
-		if (writer_freelists) {
-			struct writer_freelist *wflp = &writer_freelists[i];
+		if (gp_async) {
+			struct writer_freelist *wflp = &wsp->wst_fl;
 
 			init_llist_head(&wflp->ws_lhg);
 			init_llist_head(&wflp->ws_lhp);
@@ -1235,7 +1218,7 @@ rcu_scale_init(void)
 			}
 		}
 		firsterr = torture_create_kthread(rcu_scale_writer, (void *)i,
-						  writer_tasks[i]);
+						  wsp->wst_task);
 		if (torture_init_error(firsterr))
 			goto unwind;
 	}
-- 
2.54.0

