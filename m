Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6CF3E1233;
	Sat, 18 Jul 2026 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784394953; cv=fail; b=qzxA/tif8R56FSZAnSLdHgSVbmVGVAxsmjcZ+ldMUyV9op8Qq2JrnCqdNkT/4hoG5v1SGzDnYuJ39AlWxbDYa1I3e0Mpk6Upj+1TLxoXown4jHBdf9e5r+IMaOoPTvrJ11FaL2BngWf3hnJTpfRlZqV6rb0EFgqFVpA4pGgOqiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784394953; c=relaxed/simple;
	bh=wuzY3YFToFAq2l2yA4g8WqDqALO4Lh1tSeWNLuAJWjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=era9M69TIqGxK2i9mUM+ldhM2uDRPQez1bq2w1raePBOg/iAsnmR9tiuE3YLajltw1Ra9dRspqbo6bNLhsOXS+D5OuZ+uHn0qaU6hjHMYIJs/lMgzYMpFdAQ/fj1FjtsUPcPcAV5C08DHHSIJFTj2sFP+RjcMnsXY55L0QIe4D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UP8RWJXc; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UP8RWJXc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJpZVgYUdG6thHXx1pe9WuMOkhCWdvTAt8sE4wiytjNe90rnYabHwZxek/hXLE3V5HBairaDJd0m4YKd6KSR+zokqgcqWr9R5aNd5esrGUYyl9jvAQUeEoeJniD4i+BJlKCZ2OBdFy1fHU2x+oKXG3pqLX/W1+xfFlnS0U0wOFBgWPTk2D314gmypqBAO6AcmjVsjtl3M7Tz23F3pjAsLy2djw2QI4n2tYd9CB6aPCi9RgS+14fvwoix/jrRH2n/do83MtqMubQHCo4dQqLR+R/ZNQeX0LF90foKBeKnBq79Bn1kn2Bntvndf6/9zs6sr0uUH/nthe8zAHuRdr0+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJ18QWcKn7v1sJioixXxAbN5zPGbKMft0FiInL+jNV0=;
 b=ngXXUEKTKw1iwMLjbMPHqgq7FY7lkXm9YW1scykuGTd8IKAi5FDS1zlPluPCzecgFzojqCTW7r6ol9IHUX+ktQv9GbjsXEK5uTsVqd8gYtxhPhNTBFua5xSB68bzCMs9bqdEAB+FAITD6fGJahjJm174ne5FPUCDGqRVa0o5flKYGMKes0MDDjk+R3/c+oFESp8RauOrStDjBFG4acIoUzx64booA4F7Nz3EeGuVoVLlDDE87FLEstW32xw7uGSrpedvzv61o235W2SrsoVXw2iZpglJKidgFHv9Fh+tg7uZRiBmcljGAEbejxBQkFKrV8UnfDTNJT28uuWhHqz0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ18QWcKn7v1sJioixXxAbN5zPGbKMft0FiInL+jNV0=;
 b=UP8RWJXc5lfXhR48qxxWETfhWZQhKHQuaFhrTDkWXOtMyu1zCB+Od6W7IJnHi/k6Ec/KQc+xIU6HYQ5cXxbjjAZuO5C3y7HSL05kaSbRYFpPFwtIspG2eRNNHaArxy0srhGeqKeq95GqAghWCxuQF8tbss3hCSaiF9FS6t9MIKIWx7PnwPOKW1QMeJHeSWfS4DQcrQqbFkc/l0uR07IYkbF8IIjo7mv54lxty004UFsAzF2nty/+EwaaJrSwFz07/awiTmQ7z8SBB9RphLJNJEDG+YBuRpOQXLM18MSyHVOYn+hchR6J34HOt+vOloIDp+oxEok4H9UUyCWuMwHCGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.13; Sat, 18 Jul 2026 17:15:48 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 17:15:48 +0000
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
Subject: [PATCH v1 2/6] rcu: Remove unused rdp parameter from trace_rcu_this_gp()
Date: Sat, 18 Jul 2026 13:15:33 -0400
Message-Id: <20260718171539.3781595-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260718171539.3781595-1-joelagnelf@nvidia.com>
References: <20260718171539.3781595-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:208:32d::27) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 007299c6-cd7f-45ab-5324-08dee4f03620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|921020|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	kBBF7v4MdndUHG8ZNQC0pKsTXkMFiuVdRR0slyWmLY27EuWFEHJukzs3rVURtapyUFlOplOV2OUHnCHF/KtcaX6VdXHt6VgA05jCS4qpNCt+P0p8hMI25Kg0Sgcp4veywTpoojEh0Z5BKqABYQrRH+hc595/hKortmvnhR2TU6iXDoczRcvkoZRIXenfs6wEB7dM6GM2BAhhQb14FGQ+VOHKZH+wY/o/mxGi0ewoakavvyFfW4yCPG+TURNhmzRsP2eIAl37tnhHqmVbj0qNaaPOQCCZUzvFlI9D0iFV2uoxn/mcbIV/o4B7bvHpgXx9foYmo5fb/BJXoL9yiyjvl3a3gGfMaTObtlL+TUyGDS8cIDpcvc5LHCzY3T38HcDGrhUUmUz52gdCWc1liUymroZ8LlqmKVdo/H+4AEK7hf4Nd6kQ1A3K0CIdOTAE9A/2ZF8fw1LCyVFD82vsO3RZoCMem1Jj7rIPdtXTy5lNcFhXGtKb/1ULczlKxlOtAdXrcfT3wMWQ6XovcFikgrSEP8wQdriUZoaQ8iv7wEQsokaKsvYyMoIexOLFsSwzet4wKpqf+Qrd3jNblY2UhoW8ejTBvV2DNqr4WXQZvfwh/MLPYxH5bgeA+SjR97Im4lOrqusKiPFdPGlKEzLZS/m8i5P9uib9dMEyrp/GFS9SfnW1G85PnTnHfv6fcJUA30zw5uQN+94pT0DbpCk+XY4QcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pj/4w3dKiVKf0qW4km253QT3hbP26f9lbVUIytG1lND8vVRyDqWenQYew/ZP?=
 =?us-ascii?Q?B7pLRzH3cZ5+e1/cT4XbGl0iIHuESfNRonhGyxWfHQmHCvW4y3txNw4oRhPg?=
 =?us-ascii?Q?oX4vHBPZVwp352MIRHVgjGU1cLSxfQLrbfrgYy0YxFGYwkp4nVGATsd7AXAM?=
 =?us-ascii?Q?nwvQp5/hVWxQg60mcY/86sdrPKanJSzfnQKEKinGRCfk/UooqiInbuZ7DcoA?=
 =?us-ascii?Q?3DU1Ori2c30Tu2aor4du6musbxT9mPzTce0qJsmg0GW0ev6RqEkW7jQgE8cT?=
 =?us-ascii?Q?g7WS78IfxbWEGA2PLUbGkG6uP7hSiEKIK3JfyONAi8vkRYQVNf7qyPqKVMto?=
 =?us-ascii?Q?ZoLNGo4KBkVIwzcUZ6T0C876v0BYTvz2zGiwZG5u0ejHG8IPhlKYdCWCT6QV?=
 =?us-ascii?Q?fwt1XOlb7LZIxsF/0/ucomRCob+Sf7m+IjeZEZ3jwjvZv6nmr1CQm/WMkMuB?=
 =?us-ascii?Q?J2x8tO9ckGza1ox7PWr+1ZIZwgeXCN0MrP4Cpnhav+oaLSkepSLaQzNKPjHK?=
 =?us-ascii?Q?nth61saK2zYzbX1cEOswX1Q0CdHH/wDc1y8e7+fXpltUQPHvWDqCJrdDtmLW?=
 =?us-ascii?Q?kvg2gasS5EUGE6pJj1Xo27MDR2TzS7IcyMpVUy9JPEvuMXnubi28i1vimKe2?=
 =?us-ascii?Q?O2jqVvWmcK9mbDyoz2DO+4ZGHMzQ3ZDK5dY30fAakQgu2etxfRFVxXUHrLwS?=
 =?us-ascii?Q?9IZHUMl4xzzb9U/oreh+NhIhUrSCuX3lRAJhMw7Q7+QDh/Ex9RKGdi4ocUE9?=
 =?us-ascii?Q?tQK6w4FIyMMm5+9UvjJgBEjVvOsbaX5flBcrRE9SJj9r1XAuqVRXAPFy4WUO?=
 =?us-ascii?Q?581kweEJ1q/suDJTQrHk5uYyuRAfivZLuUxSTQb/bIU7eq3ktccxYvROPY+N?=
 =?us-ascii?Q?IIIyXCz2dLI0BdV6KQMhiWLPMEAdSjwZfZIfbdV3A2RoVEeklY4+U0hoJDOR?=
 =?us-ascii?Q?pqBtMqjMGnbHDQ9l1Cp8zN7QbktKCUvp+s/L/4NbxIWrCGA7yoOrxDbTpQVF?=
 =?us-ascii?Q?sJp5d8jgcfgUbifUGeqRNLwDgyQJrt4jQhfCF9Fz1HNXwDCqYplI0PVZtd5+?=
 =?us-ascii?Q?7hTdil9DPlF2lIWPcVWqa9oheM4U1pe4Ds22YO7qB+Y7bSupoZR/nT9lZxb1?=
 =?us-ascii?Q?p/8GlDykBR3cUssLu8FSZaFSBxtkaa8n8fBYKZbHKnk7+9iVlYPq2dcH3Tks?=
 =?us-ascii?Q?uwYi04rbhdtXs21EQCmage5BfcZggrWWTVZfHmtnALF1LoMkctr1kWsbia4A?=
 =?us-ascii?Q?HniBJFN8OQrxDpQIMO4ARKQlr2zTL5MXoxqbXQx2N8e4GR9AuPUIvRkYRkHX?=
 =?us-ascii?Q?N1wQLLMUU3mncw1QysTbBN96TPnaRWp7B3Jr5+4vQBOM2kLdaaqm31l704iL?=
 =?us-ascii?Q?Gq7hVfbP8F/kVsPkU0/O9hnShuNWcZrBxBxGVO6hfN1hiEIdwY1OSZi3CR6n?=
 =?us-ascii?Q?bBWpf0YAM/tgimGEBUK27HGhxntbWsC+O0H7UosrnRs4houzbbO6bOQvFtum?=
 =?us-ascii?Q?u0o9t4uWD1y4fqlzSHJN3oCZ4a58zVuOAEVfuROGOoAryHUzxsR+QYIFUJVl?=
 =?us-ascii?Q?1lbL3YcjCdPIixPnOasT/E5DQwUEv6Wo1hzLR/ug1CUa67SJhoDRfi44AnSE?=
 =?us-ascii?Q?/UHdyHgCZOADTw4cCX4IIQ8UohPr/TXnaundfntihG8UAPfDOFPIi3mHf+Xc?=
 =?us-ascii?Q?4KE3lY1nkkzhuImEsYBi2XnwigNhmRKon2ycfLCOGyYtqq0+S6ELbzyIEPVU?=
 =?us-ascii?Q?dEDyq5QwEw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007299c6-cd7f-45ab-5324-08dee4f03620
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 17:15:48.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpYMVgnkfCPmvpu6y6Oz05Gx1f6ZWJy24YMa8xyhh7bEI48cI5e6AQBqpih42SLpZ4jkjWs2zrzgbS6SZZZJbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

The trace_rcu_this_gp() wrapper forwards only the rcu_node structure's
fields and the requested grace-period sequence number to the
rcu_future_grace_period tracepoint.  Its rcu_data pointer parameter
has no users, but every one of the ten call sites must nevertheless
come up with an rcu_data pointer to pass in.

Remove the parameter and update all callers.  This also allows
rcu_future_gp_cleanup() to drop the local rcu_data pointer that
existed solely to feed this trace call.

No functional change.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c      | 23 ++++++++++-------------
 kernel/rcu/tree_nocb.h |  4 ++--
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 03a43d3d2616..ef553189ee24 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -986,8 +986,8 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
 }
 
 /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
-static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
-			      unsigned long gp_seq_req, const char *s)
+static void trace_rcu_this_gp(struct rcu_node *rnp, unsigned long gp_seq_req,
+			      const char *s)
 {
 	trace_rcu_future_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
 				      gp_seq_req, rnp->level,
@@ -1026,7 +1026,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 	 * Note that rnp_start->lock must not be released.
 	 */
 	raw_lockdep_assert_held_rcu_node(rnp_start);
-	trace_rcu_this_gp(rnp_start, rdp, gp_seq_req, TPS("Startleaf"));
+	trace_rcu_this_gp(rnp_start, gp_seq_req, TPS("Startleaf"));
 	for (rnp = rnp_start; 1; rnp = rnp->parent) {
 		if (rnp != rnp_start)
 			raw_spin_lock_rcu_node(rnp);
@@ -1034,8 +1034,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 		    rcu_seq_started(&rnp->gp_seq, gp_seq_req) ||
 		    (rnp != rnp_start &&
 		     rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))) {
-			trace_rcu_this_gp(rnp, rdp, gp_seq_req,
-					  TPS("Prestarted"));
+			trace_rcu_this_gp(rnp, gp_seq_req, TPS("Prestarted"));
 			goto unlock_out;
 		}
 		WRITE_ONCE(rnp->gp_seq_needed, gp_seq_req);
@@ -1046,7 +1045,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 			 * rcu_gp_cleanup() will see the marking.  Bail to
 			 * reduce contention.
 			 */
-			trace_rcu_this_gp(rnp_start, rdp, gp_seq_req,
+			trace_rcu_this_gp(rnp_start, gp_seq_req,
 					  TPS("Startedleaf"));
 			goto unlock_out;
 		}
@@ -1058,14 +1057,14 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 
 	/* If GP already in progress, just leave, otherwise start one. */
 	if (rcu_gp_in_progress()) {
-		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedleafroot"));
+		trace_rcu_this_gp(rnp, gp_seq_req, TPS("Startedleafroot"));
 		goto unlock_out;
 	}
-	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedroot"));
+	trace_rcu_this_gp(rnp, gp_seq_req, TPS("Startedroot"));
 	WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags | RCU_GP_FLAG_INIT);
 	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
 	if (!READ_ONCE(rcu_state.gp_kthread)) {
-		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
+		trace_rcu_this_gp(rnp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
 	trace_rcu_grace_period(rcu_state.name, data_race(rcu_state.gp_seq), TPS("newreq"));
@@ -1088,12 +1087,11 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
 {
 	bool needmore;
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	needmore = ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed);
 	if (!needmore)
 		rnp->gp_seq_needed = rnp->gp_seq; /* Avoid counter wrap. */
-	trace_rcu_this_gp(rnp, rdp, rnp->gp_seq,
+	trace_rcu_this_gp(rnp, rnp->gp_seq,
 			  needmore ? TPS("CleanupMore") : TPS("Cleanup"));
 	return needmore;
 }
@@ -2252,8 +2250,7 @@ static noinline void rcu_gp_cleanup(void)
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(&rcu_data);
 	if (!needgp && ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
-		trace_rcu_this_gp(rnp, rdp, rnp->gp_seq_needed,
-				  TPS("CleanupMore"));
+		trace_rcu_this_gp(rnp, rnp->gp_seq_needed, TPS("CleanupMore"));
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 373b877cf171..c4a5b4662b3a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -802,12 +802,12 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 		nocb_gp_sleep(my_rdp, cpu);
 	} else {
 		rnp = my_rdp->mynode;
-		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
+		trace_rcu_this_gp(rnp, wait_gp_seq, TPS("StartWait"));
 		swait_event_interruptible_exclusive(
 			rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq) & 0x1],
 			rcu_seq_done(&rnp->gp_seq, wait_gp_seq) ||
 			!READ_ONCE(my_rdp->nocb_gp_sleep));
-		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("EndWait"));
+		trace_rcu_this_gp(rnp, wait_gp_seq, TPS("EndWait"));
 	}
 
 	if (!rcu_nocb_poll) {
-- 
2.34.1

