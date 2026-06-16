Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D6394EA6;
	Tue, 16 Jun 2026 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648792; cv=fail; b=uPfwvEG3gX/9dUMNuyPkdPgKRmGM7ddabAI4SKM4unKkqcLyw49AkX2o8xLFeVn3pM4K9Bm4/OBSVStizMNyZTnlGB4z4w3tCMFeI3uUtqGaLXFsw/DD4ZmBWiOlJvulok36UD82R0k0k1D9x2YQKYtJSG87MIZKTwKz4/NCT1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648792; c=relaxed/simple;
	bh=U/Amj8gEXU3rhXeK9/d7U9c71C27/a3XiuCxp4p6KnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKqRDt+Uoe0dx5XXnwOG7kM8XGadA00nEL1DsPcERprADV8v1QjnCXH8gVe7bLIrUUOypMBzWIo6KtMeqEtVMt9eG6QFdnvSzZvZxNMtHW6QflifPRE9CfGdtPgZyRchHJUwRivY9wwhqhaH8LoUO0SolSMbwUsZ1T1vWTc3NAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SK8rVqJw; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SK8rVqJw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZKU7hAtRpKDiSB712wDgSaAj7NwOTiVE/0OKi0X8rQD1gIwiOw+6VE3cuGcG7eQ4DFcTCA69wL+HDxBOwnh/R8Yq91HKoUBfbyp2gKQo+E95DCtM4u3fCGlYkSLXQ1DPEWD75zRbBfrFNROcpoIUuSMfFgVkekQcYkGkOuUoxcgD2C+MYAxIDj7rXeQIGTqPJ59uK8Lqx1QggiC+Jhwg+qbEdIXPli54M/e5aGJjSZFUA0iJVBhO7D/fudH8o+V102fzxGFb/+9qh+szccqG+5q3wxU8+czfWeZdGzP2qY7Uz+nQZmnEnVjV4Sl3gTGqVPKM6MEffGYMc3kRc63kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdGYtDES9nOXYiv6UmpSlBNZRm5s2kbR26hd76U3Hyg=;
 b=Daofs57RVFwVwEg0BNm1SwZRdXoyxOKDkqiGhWD3m6ozsnSbzppP6gPO9JgbyoRUHnQYPGOfFWOa7vFsotyUg8AngYTaGqUWq9YxCVtn+pL2sS0IvVJEFV/iyEA4qXJZxTFHMetm7DXIQtq55JdzfLycfeKRCXaParGgVXzSa55c982anShxU4ihE/k0Nx0T40P5n0FsNcAy6zLxIwDRqk2g1T/XwWbXiZwaEfgv4RIg6F2LpEyrQmOJrVfcPr2SO9SaGpmbVAb454WDCmdEl29QPn0SXIx0GugNoLgze0gCppTJUEVIt2j2HnAfa7QxgB6bbgyBP932BZUoaL5YjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdGYtDES9nOXYiv6UmpSlBNZRm5s2kbR26hd76U3Hyg=;
 b=SK8rVqJw/a0hjFdpK+JWEHNd5qLwXFuvXLi0Y7OUzScl5jOMLPgr0MjYHSoZT4sX7v6vJp8DkkEOq15xxS5+XygOL90flQfdkUGJN5G1qpdfVKBc0v/PHi3LosFd6a4Oqdw5ChRuabmbgGnqYnU7kB+tbrMANIWsvEkPJYO3Vknozon5zkBUeTYznzcTLP6N7fMfvvZeIYsZ/SXTxJ5gMWl7tZwODdRsX5cNVAJ0Jt8ZauLkm9lkwLTGl1GOi8oR3MtRd6QBcftL8cF2sQuR12Kx9tNupt32TdxtyyOx48MU7UYIK39qsP5mtq9eELdfQ0DbH9GF6eFqdrAz60q47g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 22:26:26 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 22:26:26 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org
Subject: [PATCH RFC v1 1/5] rcutorture: Abstract reader-segment dump into rcu_torture_dump_read_segs()
Date: Tue, 16 Jun 2026 18:26:18 -0400
Message-Id: <20260616222622.2981876-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616222622.2981876-1-joelagnelf@nvidia.com>
References: <20260616222622.2981876-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26)
 To DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c0ab00-2752-4c7f-6d51-08decbf64dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|56012099006|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	O/+nKTN/HC49iDXgPfJLxVdF53tW0FAu0Itq23NSyZJt9QbFNkTe1DlrcXep/2OgNqiUfFup7Uadkym2YuZZkE7IgMSvBDflXCoRc0E5hi1HQJ9SuuLOLSFFQiMipjx57qomjnvhJEdPwaBrLRbnXIDfMbmMvlR5uQdPZy4+uf9NDKb80po/R7utNw9tvCASDOnqDI7dWgOKJ4fdPejuktt1FLA3wraWW0IJ/d+cqO2CgerZxRZpdK6QifcjeRy8aM39ZrwiEBLLgnZFyyiFsTkMPXTDxSiey36+7z5YeLmNwddIJLPhU5M1kqnvdGPz5ZPJURbIAKJWylR2auvAR6Pl6V8I1xV2AOHFwYMIYe1BQLHGHkLxB893G79Z6MiEuWBybEgvbyiHaABtnxnwZt8bKyt1HklM5xEupSNIz63YS5dAuYWbaocdBuzlhvUcCfHTPoNDg8ESqwJ/dnQofaPqiWSqRqpkYLWO/4zZr2DD5WXovpSLcxNhpDX2uJSRufV5i+FJ/fPsR0+3f03w3lgLhxhWMUUIi3iFvlsVE91OdLVbAC+YFrMwF8rEATuxmpHI7ULvJa5Ek3Ohm5404mZ4rmARPRr+pskSKRNRH7p/aTRIyja+5Ijts7+GDdx2QCDBQHY6TiEfjz8c+XhXbaPDFyZEUrjixrK3yGUWNQKSA/conJBI5XALV/ZvDPXB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d7NuNDFN/JIInJBzVyNgjSxgo2XAjj/8p3y8zail0FD5SjXSYO75ytn1IG3u?=
 =?us-ascii?Q?WxwySjfJ935SSKQoApi7lLsHGw4oFxO8E0oalkvDEyP9xXf3qgObt/LsR+1f?=
 =?us-ascii?Q?gSIqiKp42JY8V3GmYZqFOj/ixlIqTgwElPOE22/YmEMRlqFTWGHQq7ab/Akd?=
 =?us-ascii?Q?olMeY3LG4PbiZ6L5eon42jwE5UOpRGiAn9x8vHIHijLxL0s5j3PZiarWCVGv?=
 =?us-ascii?Q?c9iBHl3ngTO/GJLaZdBY7zH4jJKR37TkOHBGbydoPdGZsI6+YVcs8EbSphg/?=
 =?us-ascii?Q?eobDCgenaeRdtCs5JXiNn8/D111i8P0STsIXuhwa4uyGVBdDExIlnP+oZYBu?=
 =?us-ascii?Q?OY1jVwM30RTJD1+/6A57JD4GELFfuPq5IiRbIey+qmnfgGWT/loSJzlSBDqa?=
 =?us-ascii?Q?qT6FTOnA7Bbo8YMvK1bm8ehdJ7g7MYn9P+GjILA61NCTYBgrOLVsvKct8dZA?=
 =?us-ascii?Q?RX7V9vJ64sfBuLBHfkGOjqu2BK8y20bqy8QpHp20dp2vu3UZ04env9h/w+Fm?=
 =?us-ascii?Q?l0EKeLWcKEcyvKGxFfziSANeU4tpgUAq63fcLYH1sW+TlyjKGdxNxuI364d8?=
 =?us-ascii?Q?ZGW/Bx6a6g0IHUMEXLGAcs4wkMGoXjPQFzkjRugxgX9GbYpEGMR6NuvMI4HY?=
 =?us-ascii?Q?hxs3EfoA6M32Fv4rbTAkXAOV/KYqu1LTn0ORMdpNW7bfokZmD3oRw8P5rj/f?=
 =?us-ascii?Q?1PXKRoqGFvNdaTLJC11+l3aGWqx00d9dIVUDo+X9yuvmupq567tH0ovjlQ9e?=
 =?us-ascii?Q?5DJn2KY5G3uVAMiHAfbnm3Fg4yZAAwVm1MYTxkx1vziqNVQd50ChAfscz3wI?=
 =?us-ascii?Q?HmZloiDJti5yoIsfMv+QJWMwDOIVmnbraI0KXa+Ub0iclcMrnNOD9OTFCLbg?=
 =?us-ascii?Q?copnuOPmfUAwInDpoEHuG/EYpqIwRap6OFMrA7mf1kjYJw4EIzBrg1/+J24g?=
 =?us-ascii?Q?py8q2k6qSjXE6ODmpzFd64P8eBcKmAXy47j/Mvw0e159+olUGuZzmFHr44lo?=
 =?us-ascii?Q?Vh/2oo3mmuls7yE2VsWC1Ryn0rOwFmchh+BwOGUUk9vntsEbClUMdBzREKuz?=
 =?us-ascii?Q?FjaxAWmQgv2kMU35ju7BRUffoMhb1TKPLT8BKdZl9RzxDu1ogxmY6JcFKxyE?=
 =?us-ascii?Q?ZcHZG6WtHmxI7QdkFdD/7wN25q1AiaN/uvdtKw0aFqK/DKBKAvvFrB1y5/oH?=
 =?us-ascii?Q?TsNk3IQn5KEOFQW+YGwqn7laW3ZfvVGUNP3DEzJ8LCwKNAF4bMJM3Uio1NEC?=
 =?us-ascii?Q?xWDXit3gzhSVf7pKBYJkwHbChgUcsdiI2ukRzrdJB4rcgcKfv/yVBUv47jFV?=
 =?us-ascii?Q?yZ7QCi5VlwOb3QrQS8KeTrb14yoj0qQWj1TuCcTouISFzFA+8D39AbmvanLq?=
 =?us-ascii?Q?oGw1gvlD0w8yG44rxndK2JHLULj1DpABimJpeX7ehyD5+WK/L8YCrsdMCRvK?=
 =?us-ascii?Q?MkM9J3p6alsyjrPy1zeqbEqAhxx5CLAdvBVW4TqBYfaBmrmD1DzXaabJsGtQ?=
 =?us-ascii?Q?BkLsoQZYUA8FhpwQTR5oGj5DESfNXU++Y8xlw8QFjURzenrumSvfI5Ek3No1?=
 =?us-ascii?Q?ky7saJH0/MIGi5sxFMev5ZXga7O8Po4ONTSvmlvoPFbeN1E0uB/92hmfWps3?=
 =?us-ascii?Q?5nFuYLqG3DM/Fj78H8sjsDnyW1AKcqexpbJ9qFGCHWieugLyCKLMg124qJ3z?=
 =?us-ascii?Q?sRlWFlBL74DXr2D6oY02K0kh2BrYRLLSZgSzUHN3RtidJ6yyXzs66zG652JD?=
 =?us-ascii?Q?0/uGibwhiw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c0ab00-2752-4c7f-6d51-08decbf64dc2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 22:26:26.2757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9iaxBOTyikmURVNrE3kdl3VRXkRYM4A2JZVdso71c7DRk9IZK26i74v/QiQvqH7KeeuElS1on08x01G2xIpOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit abstracts the open-coded dumping of reader segments in the
rcu_torture_cleanup() function into a new rcu_torture_dump_read_segs()
function.  This abstraction will allow reader segments to be dumped for
other purposes.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 148 +++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 72 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5f2848b828dc..42f94c62c18a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2378,6 +2378,80 @@ struct rcu_torture_one_read_state {
 	unsigned long long ts;
 };
 
+static void rcu_torture_dump_read_segs(struct rt_read_seg *rrsp, int nsegs)
+{
+	bool firsttime;
+	int i;
+	int j;
+
+	firsttime = 1;
+	for (i = 0; i < nsegs; i++) {
+		if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP))
+			pr_alert("\t%lluus ", div64_u64(rrsp[i].rt_ts, 1000ULL));
+		else
+			pr_alert("\t");
+		pr_cont("%d: %#4x", i, rrsp[i].rt_readstate);
+		if (rrsp[i].rt_delay_jiffies != 0) {
+			pr_cont("%s%ldjiffies", firsttime ? "" : "+",
+				rrsp[i].rt_delay_jiffies);
+			firsttime = 0;
+		}
+		if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU)) {
+			pr_cont(" CPU %2d", rrsp[i].rt_cpu);
+			if (rrsp[i].rt_cpu != rrsp[i].rt_end_cpu)
+				pr_cont("->%-2d", rrsp[i].rt_end_cpu);
+			else
+				pr_cont(" ...");
+		}
+		if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP) &&
+		    cur_ops->gather_gp_seqs && cur_ops->format_gp_seqs) {
+			char buf1[20+1];
+			char buf2[20+1];
+			char sepchar = '-';
+
+			cur_ops->format_gp_seqs(rrsp[i].rt_gp_seq, buf1, ARRAY_SIZE(buf1));
+			cur_ops->format_gp_seqs(rrsp[i].rt_gp_seq_end, buf2, ARRAY_SIZE(buf2));
+			if (rrsp[i].rt_gp_seq == rrsp[i].rt_gp_seq_end) {
+				if (buf2[0]) {
+					for (j = 0; buf2[j]; j++)
+						buf2[j] = '.';
+					if (j)
+						buf2[j - 1] = ' ';
+				}
+				sepchar = ' ';
+			}
+			pr_cont(" %s%c%s", buf1, sepchar, buf2);
+		}
+		if (rrsp[i].rt_delay_ms != 0) {
+			pr_cont(" %s%ldms", firsttime ? "" : "+", rrsp[i].rt_delay_ms);
+			firsttime = 0;
+		}
+		if (rrsp[i].rt_delay_us != 0) {
+			pr_cont(" %s%ldus", firsttime ? "" : "+", rrsp[i].rt_delay_us);
+			firsttime = 0;
+		}
+		pr_cont("%s", rrsp[i].rt_preempted ? " preempted" : "");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_BH)
+			pr_cont(" BH");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_IRQ)
+			pr_cont(" IRQ");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_PREEMPT)
+			pr_cont(" PREEMPT");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_RBH)
+			pr_cont(" RBH");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_SCHED)
+			pr_cont(" SCHED");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_RCU_1)
+			pr_cont(" RCU_1");
+		if (rrsp[i].rt_readstate & RCUTORTURE_RDR_RCU_2)
+			pr_cont(" RCU_2");
+		pr_cont("\n");
+
+	}
+	if (rt_read_preempted)
+		pr_alert("\tReader was preempted.\n");
+}
+
 static void init_rcu_torture_one_read_state(struct rcu_torture_one_read_state *rtorsp,
 					    struct torture_random_state *trsp)
 {
@@ -4071,11 +4145,9 @@ static void rcu_gpwrap_lag_cleanup(void)
 static void
 rcu_torture_cleanup(void)
 {
-	int firsttime;
 	int flags = 0;
 	unsigned long gp_seq = 0;
 	int i;
-	int j;
 
 	if (torture_cleanup_begin()) {
 		if (cur_ops->cb_barrier != NULL) {
@@ -4160,76 +4232,8 @@ rcu_torture_cleanup(void)
 		pr_alert("Failure/close-call rcutorture reader segments:\n");
 		if (rt_read_nsegs == 0)
 			pr_alert("\t: No segments recorded!!!\n");
-		firsttime = 1;
-		for (i = 0; i < rt_read_nsegs; i++) {
-			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP))
-				pr_alert("\t%lluus ", div64_u64(err_segs[i].rt_ts, 1000ULL));
-			else
-				pr_alert("\t");
-			pr_cont("%d: %#4x", i, err_segs[i].rt_readstate);
-			if (err_segs[i].rt_delay_jiffies != 0) {
-				pr_cont("%s%ldjiffies", firsttime ? "" : "+",
-					err_segs[i].rt_delay_jiffies);
-				firsttime = 0;
-			}
-			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU)) {
-				pr_cont(" CPU %2d", err_segs[i].rt_cpu);
-				if (err_segs[i].rt_cpu != err_segs[i].rt_end_cpu)
-					pr_cont("->%-2d", err_segs[i].rt_end_cpu);
-				else
-					pr_cont(" ...");
-			}
-			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_GP) &&
-			    cur_ops->gather_gp_seqs && cur_ops->format_gp_seqs) {
-				char buf1[20+1];
-				char buf2[20+1];
-				char sepchar = '-';
-
-				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq,
-							buf1, ARRAY_SIZE(buf1));
-				cur_ops->format_gp_seqs(err_segs[i].rt_gp_seq_end,
-							buf2, ARRAY_SIZE(buf2));
-				if (err_segs[i].rt_gp_seq == err_segs[i].rt_gp_seq_end) {
-					if (buf2[0]) {
-						for (j = 0; buf2[j]; j++)
-							buf2[j] = '.';
-						if (j)
-							buf2[j - 1] = ' ';
-					}
-					sepchar = ' ';
-				}
-				pr_cont(" %s%c%s", buf1, sepchar, buf2);
-			}
-			if (err_segs[i].rt_delay_ms != 0) {
-				pr_cont(" %s%ldms", firsttime ? "" : "+",
-					err_segs[i].rt_delay_ms);
-				firsttime = 0;
-			}
-			if (err_segs[i].rt_delay_us != 0) {
-				pr_cont(" %s%ldus", firsttime ? "" : "+",
-					err_segs[i].rt_delay_us);
-				firsttime = 0;
-			}
-			pr_cont("%s", err_segs[i].rt_preempted ? " preempted" : "");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_BH)
-				pr_cont(" BH");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_IRQ)
-				pr_cont(" IRQ");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_PREEMPT)
-				pr_cont(" PREEMPT");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_RBH)
-				pr_cont(" RBH");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_SCHED)
-				pr_cont(" SCHED");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_RCU_1)
-				pr_cont(" RCU_1");
-			if (err_segs[i].rt_readstate & RCUTORTURE_RDR_RCU_2)
-				pr_cont(" RCU_2");
-			pr_cont("\n");
-
-		}
-		if (rt_read_preempted)
-			pr_alert("\tReader was preempted.\n");
+		else
+			rcu_torture_dump_read_segs(err_segs, rt_read_nsegs);
 	}
 	if (atomic_read(&n_rcu_torture_error) || n_rcu_torture_barrier_error)
 		rcu_torture_print_module_parms(cur_ops, "End of test: FAILURE");
-- 
2.34.1

