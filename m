Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5DA2DCF74;
	Tue, 24 Feb 2026 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974293; cv=fail; b=pS7c7i9W6jCUuTOzI9wctrK6clpJPLvE4owqtrJfpgoZn06EzTso/E3O5TTr00F3c+clzu+qMQ48iYZhg6ley81Akp4IgS1KZIPKlLlZ99rbkqwOYeKAeZKovjaF0XjN9VTS28STYV40Nvr1J6dITur0eZiCy6ze0s2uVu0tJfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974293; c=relaxed/simple;
	bh=fgZXprSTqj1GVJK+iNyJMWlt5h2jQRHI/iJMCyYlJCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e9gnl6wHbAZw/tF4C/cf5369cuYBfbak5A3YcPom/oaIE/NsJOGlpxutlkVwXUsLkvaJCBxnHScmli/TXop3OaX/oafUh3plEZ/jAy65Xu2SZqe078XAvednZ0z7hp0b6NpDUv8P3jL+xS7MlsIFC6A2GOPHXvtj6HReHJ/c9k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lQXDGRbc; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lQXDGRbc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dasvnk6ihaHJOTFQT8zGwlg2pBe5euI6ix5EySFmrZKZTdq5htpIwI1kG3gfPdrsQ+XU4M+mSMmv0abl7eJ2wAEce6u6OsJwtHfidEEQ/RMf/P4390MBanDswMCrZOMFkCpoyl77XkIjQA5H3tnbB3WjXh/DHQfblnkR5suMQsm3w2qB7hVhEMGI782NXC/18sKhm760a3kJj4s2LvkBV70Rwf1I9jiPCTHQcwuXz7ZMYHy/2atwFeRnqKVJTnj0te4eUd+yjN1/V2Bu6MVA+n41tGyj1yHYSvvoZq/RriCYY90gxiKfx10drw6aJGRiS+chzZVEKAu2Yv0y8chVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkMqvEwYK+PYi7sCof8ZJAsUfjsM128sDxKEaOQh5K8=;
 b=fWYj2X+G9uomFm0JWZeKugVsZ1+kAl5CiFdj59Xb2/KwFrNyasdYUn24IVWvJhHiyGfpB9+edc/il8uPVU2KLmrlYoBsDxNS/lMduHK8zmjYltnu5EFSyWygB7c+Ms0U5cLhkaGdS5oZan81dWSkgEpNmua0uBY6wp1nZSFB13XIc0cmIUpYc29R84PKe44I86gs3j/QxkDHsu5onxXBLr/H6uLMXLAmt4hf6lhrLc4wpm1e2nrnoA9A3xGpQHyVd6MlKEu0K6nqeMSmpxpl16SXhggpSqaVst3Zc89ATYXfTLNZt2PI6nAch9x7Q+TD0BXTE/dRe2ozC/tdkdGhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkMqvEwYK+PYi7sCof8ZJAsUfjsM128sDxKEaOQh5K8=;
 b=lQXDGRbcoUidVg3/9j5dwzhNOSFbT02pp3s48vIPM47Bf7KeI7ZyXvAZd6AYNH8Y43uL62kxKtKixSBmYx8EPFPj8+lJ6jRq8lClNnlnxRVuaTJqA3C74YjbIMKhruc4Bd4YWXwTOULoOfVpX9yzdTs96mcw9AO1icDliL4fFoNoKlq17Epu3hCSu0j7w2aDs7wzFt9pKApyQWsWTH1CShZjUyRKqm+Jzbim7v62scUTGYtZvxK/jLvfKyfnCPiTGiQnBPMOlP6z7D/kNJ32pdjpgMgFPTHDu+VHkJsUSgPIBEG6GWQ+9XjIga5o4H448ImRQABKhuGkwPfxbpq5qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.14; Tue, 24 Feb 2026 23:04:48 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 23:04:48 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v1 1/4] rcu/nocb: Consolidate rcu_nocb_cpu_offload/deoffload functions
Date: Tue, 24 Feb 2026 18:04:32 -0500
Message-Id: <20260224230435.3390963-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224230435.3390963-1-joelagnelf@nvidia.com>
References: <20260224230435.3390963-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::31) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c61cefb-037a-4298-8a2f-08de73f91bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DLqK0BU4L6B279KUY0z1bgZs7R1/rPTVXo8KuJmAi9BSrePdtoQnNilGC+nH?=
 =?us-ascii?Q?PsRXyWdQdZLfQn2Yn8U1C+QEulZ8hlGOtfzRkyTsizuwFU1Z0sF1pjqT2Qec?=
 =?us-ascii?Q?5bh9DqGktUthlw0DQZ0fEC6Dx36zR5bwcocdcYZAvMFwCMMOya9QZXsJseRc?=
 =?us-ascii?Q?QbDwpGTXAjZ8Qz4L5vqXo59YK1fscC7Z0tV1dFhdXJxQMcDXilQOYSmLk0ei?=
 =?us-ascii?Q?HUC1utKuSzUm2KgIVxXcEgbcfrdXPZjyHKAbpTG/WtcklHV2wKbzjKGiJerb?=
 =?us-ascii?Q?ZigtYX23lq1x0Md0P1NtrA+V6hfj6I9v6Cg9hKBBqw0REi1GV9q3WK2CrG/C?=
 =?us-ascii?Q?cuMieKQUm7Q3GhnyErO531srfEpiTqt2v1+h7JNG2EBxdmpvOnWx8mr5xuQf?=
 =?us-ascii?Q?9NIZhYigvrPhODlsyzdYwu/yKNWlB7ifOdedBhOeWH5Zhp1YDs1Tdn0Z3PmB?=
 =?us-ascii?Q?tApBVp0Vv6InLXhljlpTzBHMtxoNGE8ic5+eKAMd51raWuHraegFv/smHhpJ?=
 =?us-ascii?Q?lEvfbKuiYcsXr8cYwILAx/4DSD3CCxAyXfAKcRkQEzKQKCSKv8OjqhnxU/MU?=
 =?us-ascii?Q?xPDIzbqAc1X7Eq+Jds5ozrYdYPNB2470Sevcw3P0WeoD/fdRisu1MxGJPmTC?=
 =?us-ascii?Q?zHK1PpaBq5MfZLODaZNbquV7+cS83DnYHg46vg+XOky2/+KOIqwvE0dlXKyO?=
 =?us-ascii?Q?vD5xar8GfrttxBiygIo5Ue7w/LGAO5ctD+xibaO/1epZIdFlv4SosAgsAiN3?=
 =?us-ascii?Q?izvbcx2lPlhLx2Ht8GqpE7YtH4WYpp+eNE/86btdvELcYVVjJ+aUaaNoL4vC?=
 =?us-ascii?Q?vEVV/A3GBGKrkAm4zRJes3kqnKzQIPydIXQAjLL14O1bUeXkGlrudC7esQ4C?=
 =?us-ascii?Q?hQi5A3N32jd9nHBwL4ZM51Kq+a8fs1kjosLhjWEWu5PL9R+l+j6doM0qQ+Td?=
 =?us-ascii?Q?IxbmO5iBA1xOrbrhb//Y0JKU5DJoVhoxRhKOx2iu/5KB9ovjJpic4M5C9oEU?=
 =?us-ascii?Q?U9qy6YPULDmZgI3Z2FqxUMcbtfsI5FUydJrofq1HzqL3fO+VOczVozojFyzb?=
 =?us-ascii?Q?UDnmDRWg8UDJyJQBfz3rQAgMmyyMC+Ezv+38iHmZnNDEsQUjw6D1iGFmVUbI?=
 =?us-ascii?Q?V3/ljGprMocAzZlF3DDeyn90eGMungxyGRaOWWKfc3WUlOlGgZWu/4Z/l2ER?=
 =?us-ascii?Q?ERHUx/rK+iRHrW7snoVb74h8WIRodQEPBlmHGYM3GEMwfIzISgVwmphyT3A+?=
 =?us-ascii?Q?0flBiagcDoru5CEigLddxU5dwr+0sZTUPLlFBMwUp9jgOGUCHvU7iy99XZL/?=
 =?us-ascii?Q?zxUXpWZvJ+jwScooeRFUprG4bH77pjlnGI7NunVdiF103ra2diDp28nim/1A?=
 =?us-ascii?Q?Zpz6LlnQl5hY8gPoLOFQ2tgFD9Ls5y+a1lFkSJqPXtCB3IWu7xn95CzDQf1N?=
 =?us-ascii?Q?8XzDwcT3O4axTK49r1yjXFSqqHJM+Ot1qDc8x2TJvpoUidWv67dkdwV5ug25?=
 =?us-ascii?Q?tFxHCdh5+TU5e2sQ2/8b3pM2/uDPJD6K+rJX+c83OxXa3vGdL0p+lu6tbiZU?=
 =?us-ascii?Q?IpU+zruz0Au8M55PvQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+1WSocsICxgiabuYqgs5wzvr2cCM1Bh7WjMmvUMVH49BLwlvfxmrtR90sdMV?=
 =?us-ascii?Q?y0D8Q1a+gbFpzf1nzosKmefdp1lqvC//i/lZQZO9EsSW8EG7TVdtfIvh91ox?=
 =?us-ascii?Q?tUoPmSkK4G0DkLfdzDhpYR02FxioJMO7bnV9Hq6b2p3qfWYHozUImrR/iyJc?=
 =?us-ascii?Q?TUec5xPvG+ruIhmkMyxbYKqgtEKZWZrrak7gwLLn3ltAE3V5dq9hg8aQZLK5?=
 =?us-ascii?Q?qLhdKZ+S2OHU65/0whhePXOO5HbpSFCnoJkjojAagno8pOoxmRxoqhGsHr0p?=
 =?us-ascii?Q?BR8re7EwXmh1bMkUiZVEmIRkFhBhPLJJB0iezqg/coL++vmbC7dl1neAaEQ4?=
 =?us-ascii?Q?KLxddJBdu6SfauH0B/CMyUCGoOp+vbg7QnWOSKOUdqRJH87qiyVs+qMuyWWw?=
 =?us-ascii?Q?ZVQ/mAj57WrIVxKLSMkG5sYuIG/BqlCvn2X0usozbpnZ7jmRpvp0HeObr1Mt?=
 =?us-ascii?Q?wEv+3i3wnYgfNhsqJ1ZEb+3yYOHr2G6SikAh+/GH3XXYrcEWYnxQjpjiPuoE?=
 =?us-ascii?Q?2faTN9LgTf97VjniC8CeWRqmAd21hUOw1UqvD6F4CA8KV/9Ri58baoDWImjT?=
 =?us-ascii?Q?vnbTij0lSNFEk6ejxWEpKr/C+i50cXhOL50aqFcMg86cSaWMKJKC+PXK/lP1?=
 =?us-ascii?Q?X1jqkpOjuuYFdIjOqDeKoX5bIwU96bHAfR0JLF3Kbn/ptuohhD+idmfnyRYE?=
 =?us-ascii?Q?l4LJLGkt/+v7zN7s4TfT7XD53CRa7vMTBoE4dIxaQ5lnpvlKPABBieXkQ+yw?=
 =?us-ascii?Q?gcPSb44up1ar6+RnwSSd2tTJ1d8AIjZTSCi4yKCg4uf+i/80UGj7dPcKvp47?=
 =?us-ascii?Q?4dVYzzNs8nEayAOXjZ8kFfdflNf4+nZkF/1P+aslBx9PMC75rt1UJrKMPyLx?=
 =?us-ascii?Q?giKpdE6a2Rccq/75wJ1S2ffRbc+7jc6NLXaV/vTNi/HA35RW50W8CpiJXyRZ?=
 =?us-ascii?Q?GnFFKY++N/ATL7qcVa1LfH8CKpmV6dDvB8wpa50p8hD1ToBV0PfNp/CE4C0j?=
 =?us-ascii?Q?DZTvOSSxq8ESgaaN/ADFYbRU59AL0CUKWZ8nBgV5vKdriATvVJckj4IveFaF?=
 =?us-ascii?Q?YOw/OE5ots48bfxSle060YOzUx9gotwfwtr4O0DFjXQRtdnOKdHTNGJDoW0J?=
 =?us-ascii?Q?9LpIrcPQ1JhrTmRN8b+/WoxQHhFWnqG/eQWDRpXKJiOwZLU8rBMFnbvvFrZO?=
 =?us-ascii?Q?lGIScLKU00iNalL38SVux9WG3x9hMYE+4bwNzELXch9Z+xg+6Y3gmX5M+OkD?=
 =?us-ascii?Q?fvO0Gls1XbeQ159n96muD48vV07pYxFRm+wMjTmsAM+LoX1roATHR549c7MZ?=
 =?us-ascii?Q?rWkul2Rp3QPLNUz4C8YO1yysTRNuOAAkQVKfkX67rvU2cNiJqQKZ3VMkHDUD?=
 =?us-ascii?Q?qA5aKVGztBHtl2OLyZe49h4c8LCZb5uehJdFzguQTa50h/dhDUyG/Via7esR?=
 =?us-ascii?Q?lP5oxUSKcL2o8tF+BzNL3qSyon3ZegAj1RPeGX5gmBWUtn4dmS9NOOyMuzLu?=
 =?us-ascii?Q?jirAZZTmsZk5HmndAq3j6xiczhoNbd6cgAAASAj1PLRyCkLtE6HBTFMBIGLr?=
 =?us-ascii?Q?PPr3LhIJh9ECFQKY3WUQxHe9jT9YyAqbm++e3mRSqnqxAvAp+N9W/BC0Yl0s?=
 =?us-ascii?Q?7CvPV9qpBmLKJc/kglVgo1DyBxW3ve0mpHFrwfofUx5SxdKigTygIMW7CiRm?=
 =?us-ascii?Q?FIsb+4+A/k1Q6MulTbzTX1OmVSjokeWTKLs+Dm8yvNasWNESKJ74WZ7JYcKS?=
 =?us-ascii?Q?+xHTizkUBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c61cefb-037a-4298-8a2f-08de73f91bb7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 23:04:48.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peTu5Y1JFQgNv1mDPzy281uEI8dP4RDk2GD3/IjeyxAswu5Q6CACkfL1mWdh2bXIC+nBevK8uzVrlTioTSvuFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617

The rcu_nocb_cpu_offload() and rcu_nocb_cpu_deoffload() functions are
nearly duplicates.

Therefore, extract the common logic into rcu_nocb_cpu_toggle_offload()
which takes an 'offload' boolean, and make both exported functions
simple wrappers.

This eliminates a bunch of duplicate code at the call sites, namely
mutex locking, CPU hotplug locking and CPU online checks.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 89 ++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 43 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b3337c7231cc..5b041134d6bb 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1081,30 +1081,6 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	return 0;
 }
 
-int rcu_nocb_cpu_deoffload(int cpu)
-{
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	int ret = 0;
-
-	cpus_read_lock();
-	mutex_lock(&rcu_state.nocb_mutex);
-	if (rcu_rdp_is_offloaded(rdp)) {
-		if (!cpu_online(cpu)) {
-			ret = rcu_nocb_rdp_deoffload(rdp);
-			if (!ret)
-				cpumask_clear_cpu(cpu, rcu_nocb_mask);
-		} else {
-			pr_info("NOCB: Cannot CB-deoffload online CPU %d\n", rdp->cpu);
-			ret = -EINVAL;
-		}
-	}
-	mutex_unlock(&rcu_state.nocb_mutex);
-	cpus_read_unlock();
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
-
 static bool rcu_nocb_rdp_offload_wait_cond(struct rcu_data *rdp)
 {
 	unsigned long flags;
@@ -1149,27 +1125,54 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
 	return 0;
 }
 
+/* Common helper for CPU offload/deoffload operations. */
+static int rcu_nocb_cpu_toggle_offload(int cpu, bool offload)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	bool currently_offloaded;
+	int ret = 0;
+
+	cpus_read_lock();
+	mutex_lock(&rcu_state.nocb_mutex);
+
+	currently_offloaded = rcu_rdp_is_offloaded(rdp);
+
+	/* Already in desired state, nothing to do. */
+	if (currently_offloaded == offload)
+		goto out_unlock;
+
+	if (cpu_online(cpu)) {
+		pr_info("NOCB: Cannot CB-%soffload online CPU %d\n",
+			offload ? "" : "de", rdp->cpu);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (offload) {
+		ret = rcu_nocb_rdp_offload(rdp);
+		if (!ret)
+			cpumask_set_cpu(cpu, rcu_nocb_mask);
+	} else {
+		ret = rcu_nocb_rdp_deoffload(rdp);
+		if (!ret)
+			cpumask_clear_cpu(cpu, rcu_nocb_mask);
+	}
+
+out_unlock:
+	mutex_unlock(&rcu_state.nocb_mutex);
+	cpus_read_unlock();
+	return ret;
+}
+
+int rcu_nocb_cpu_deoffload(int cpu)
+{
+	return rcu_nocb_cpu_toggle_offload(cpu, false /* de-offload */);
+}
+EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
+
 int rcu_nocb_cpu_offload(int cpu)
 {
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	int ret = 0;
-
-	cpus_read_lock();
-	mutex_lock(&rcu_state.nocb_mutex);
-	if (!rcu_rdp_is_offloaded(rdp)) {
-		if (!cpu_online(cpu)) {
-			ret = rcu_nocb_rdp_offload(rdp);
-			if (!ret)
-				cpumask_set_cpu(cpu, rcu_nocb_mask);
-		} else {
-			pr_info("NOCB: Cannot CB-offload online CPU %d\n", rdp->cpu);
-			ret = -EINVAL;
-		}
-	}
-	mutex_unlock(&rcu_state.nocb_mutex);
-	cpus_read_unlock();
-
-	return ret;
+	return rcu_nocb_cpu_toggle_offload(cpu, true /* offload */);
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
-- 
2.34.1

