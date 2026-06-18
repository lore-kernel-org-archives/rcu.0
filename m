Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1833E16A5;
	Thu, 18 Jun 2026 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808704; cv=fail; b=lc7B2DgRW+WcFjtE/RjIiQlSWQAHeUrwqRMkdv7nqsrr7LYuwPPyrKwTlNvn9uPNq3BvRJRJHKOfoDGPJNw9n9Bl/XZETdQv0jIiqU0IpBiVW9YdWVZzc4J4TSL2wmT6wdxiVZFXqd/F6U0QH2iPekFprCcTweSQmSP6iFX8jCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808704; c=relaxed/simple;
	bh=DjNXK1tiMy5oegVB3gfoIngVBeLKNhjp+Z64duZr8AQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sXyHfoITFcqJJ3xGFP8yvzqxQzoM6SJ12ov7Sko+lIfW9jtB+fwDiHcTtj9frJQKaGdAqgCyfBKfwJDWW0SCTPGz6/+X9lmWTg5ER6x0FjcL8VQaQ0eCalNtJASOvtvkLDBkB9h6SDwAa7eFMb8ipbN4T48pcLnOXzvibgY6VJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rl7rGNg4; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rl7rGNg4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUucJkAb+nnvO0DxgA1/7quAguUfeZ4/MMrU+xGuzsaP20qECIlrpYAPVcnXRcEnmhILV0VpqKj7t/Ze5sW5EBnQj8Vp3Cdk9mKMaks8rGMJEO6ezGCsHQu+5Wd6Ynnkq5vYE2dtYHV0n0uyqeCD1M658AuxKcWJ25HUKU1iyYrTChmoOUA0NVoAjARoITichsQHeiCLj9Xmr8I1ANXuUDs0lqpuHy8kfYt3SL3HjWJ+UojDFHipuVrU2tVCjhUUjxTH+U0/9vy/E51QG0+JnX7QUNRz9iXnzQ+yW5UVAyma/Eu8Qv77bmzbcmcPYBMbrImwm0vylLFUnxfPnoA4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5/pj+VZtgyOc/eB/N+PGA+5o86IXoltnLmfeWwh4O4=;
 b=MdBloD02PplBxZxYnAddjbx4qOtqeByJ158n6LNjjblcrTqqn3iKUWHl9s6cOzwWN8JTVEscfYwkGNNc7NCclvFz88w7tO/TlC4PD+2UtrsQfVGjiYhS4YHXkpm8QVW5/4HNDQtrqI+wwMEOsdmfIL7bQPUVXwRJiluGXfGokvePyhlxLucLH8DaP7Ffq3VHmYRxR2k1FLcwYeza3M80KA+C41TrTSQZgVBh2Mr/sT/mvFl+N4lTNoJZ/pVyHE73JqF0JKR0ZEj8bgPH9dCQxFMMcrdfUs214VYFUmv+y029nWNpJ2AzOiyDYjOzt+H8VltANHRO8KlJFz5Ih9MYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5/pj+VZtgyOc/eB/N+PGA+5o86IXoltnLmfeWwh4O4=;
 b=rl7rGNg4iZsdRnZEmUiacKefC2FP+Fno6dt7veqvCeZpUNpD+maYej11AXK6yjLX+n+nxAEUuOtPSAZzUqw+CYCB0iEihjwxF06ej+iQgq/RcXFEjoCO2821hIEOmM94a+I6TumJ1EeLVp3PtfhGMFRzocHlwYqeLAu5or9vtVp9/eT5Z5JI2dHvwFIID9LBQ89QiT4ZksbLfcYzJPukizf8qA0emQePfXOwDiL92nZ5PUsjK/hXNOO/zhHuAfpBh/uoIrpC+SxasR8fvxEeLSCQqKR5c3vjwFEy6rPv4ImEhULAO2nDfiRdlMRCOMT7714VU5kERDl2DI5B7D4aDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:28 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:28 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org
Subject: [PATCH v3 09/14] rcutorture: Abstract reader-segment dump into rcu_torture_dump_read_segs()
Date: Thu, 18 Jun 2026 14:50:25 -0400
Message-Id: <20260618185030.376450-10-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:208:32d::29) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5da932-f45c-4f16-b6ad-08decd6a9ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bFtAVIN+qUUDOzzeinoIbUaVognddUpyGS964zT3xp5sVMry1tVKSkY/FMZdR4nCRfaKRicOtIJcIn6VHxQ7ESoqsNTBzgcqwYhdMVN0sCzuhf2ZS53sWcDzl6atRobGCGnMGP+MdBsb7btDzNSUK72rWQT6CaG15fvkXQjawFUuRZjkusDxlma9/wa8Pm6nTpZ8sGnncR+idYnzij++G+GhMfJM6ggfWb2wsTocsIEXVBfTg9BGTAaO9TmQWG1RKtNf64g40PgbdIiuc2gbOiWCKpJdppXQ6QBNONtYN9JH2y1ozNCRFBrGGJgxwBIURrDRSk2v3Bmy4T+tfMSM+4huoHMV13zaPyz4tvZpmKnPnHNRCL1lUepyTOi6B9F4nJwGfKT50abc5NUi3rtbMgPbc965BKRwEt4mRz+XShGK223f3t1SVZ+PeXfEDR8iat8BA9UQx8b/HlUL2XPSSLENdyED/mPpq5bWpvc1842jnkWJYlPm9VI/pJ8Q+xHAbCJAQNGJd1F2dKJsUX/VcX2E27N88RNfgQT1Z2Y9avo52jYNFaEivtNeA50QzE7u1lkyDCnd2UHZWs+/JVWwjtfeUCarjYftMNUQ+FXEMcNKOAAhjfsWWPQ8ZV3J9GsNinxb1DlWY0bZ9rv/fxOFps33+1Hq0NWHhj+hTILitafIyhm/+IUxvueruYz0pCrL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dIYu87CG9kq8GM07NMDR7qn6lXBBT47OsY0Vr+cv+YpDByh3hhm+mMBGyu/B?=
 =?us-ascii?Q?N8tlTh2ME+MP/sEmCjw86QDGMYpnIFl8ZielkjLs+xuWEna9oSKY1h81QeUp?=
 =?us-ascii?Q?AhCzTxrQC8Ls1QajrxU8Z2wxDkAHO02UdDVD60/RSnMPbBHaEAIl4TGhhWG3?=
 =?us-ascii?Q?G8GXoNfp0RPyguOA+kD4KLz+He4MZ6phFV69xvATYLhFn4ivPT2hJoWWwUoD?=
 =?us-ascii?Q?gkbKGeqy4h25Oog56bWCD7Wx2kLpIA3WaXgNKofZf3i/9yd528wSXcUhIglW?=
 =?us-ascii?Q?Dv6fBbM1OvE8ykGnYYhgNGADcf+F7fxqBwuCVfvDDn6xG132C8ycMp1/qQtZ?=
 =?us-ascii?Q?x2dWiz/8QazsTuYuHite20LlDpSPteiSarkqtB+3l0d5FXyd2wWgf1aaI6jz?=
 =?us-ascii?Q?fsovVRN4+2qcdaQU6sizFlkUG4JCdspBcaW6e50v4z6xGkjK/W4BfwUDaBOw?=
 =?us-ascii?Q?zXR0Eis+kSi8wlRocRIfIaXT1gEPulbXpuNuDXZsDTwem3ODCeE3kMvc4SoO?=
 =?us-ascii?Q?AWPCXIwbMDOwk4fpaugFqR1v2BMmyHiuQhju4xY5yENv1j/qfq05f9lO+GB0?=
 =?us-ascii?Q?cljjNNrG72piTNmqhSn2ptQJyxZvNxmhOY4DNxMLr1e8MG3QD9yWzufETxgX?=
 =?us-ascii?Q?DvQhGNcltoKE0NTS85Fzu464Igs/SA9dhwTGzW2mahj3E8SKQSwFaIc0bdGa?=
 =?us-ascii?Q?7/30EWPrnYeCIa4aSPhEgC75oxXECUXOxJPhrXjuAtQm2LBBpjVBebHA3AiM?=
 =?us-ascii?Q?yUcTQVG7sdudy8SMGLp+tZmNeY546Qfa31Kk+XmKjfmb0uaVxnRtlPKBXMwV?=
 =?us-ascii?Q?NPZv+COhk3oIm7XNd5QwDVjSweXgCNq/ARkozDRXZ4ZcfMT8tx55fS91zn+R?=
 =?us-ascii?Q?OiT1CTjbz8DvOpdjhsF1XQImrc10GzvRWllPJud578BduIHCFszn6QTGDZqA?=
 =?us-ascii?Q?J2VIJ8F9Gi8K4360k+TmjrZDRC/JL2ebCjJaTMr3rvvpQ5fhSotf3gbMptoo?=
 =?us-ascii?Q?Hih3pRMZju5Opy+4Wdq7i/LK3BIfeTNTuJVhZgdRjgiQo/F4c+cuRM8k6KTs?=
 =?us-ascii?Q?QsaWx4z6zuBbg/mvECRt31AYq73Ft06dTCT5BLfRUGZ55OMks4wE4tLA07BH?=
 =?us-ascii?Q?Xa2xE5cdzjgJLGYw8NqYJU42papgaOyzW7oO2V5FRkJx5M6+iLtu0WWvpmlo?=
 =?us-ascii?Q?lfpOLPnXYdDvsazmYw2zadi0VRd6IrmMh65jFWuk+NIx+Zxo7GTSbvLnz4fa?=
 =?us-ascii?Q?a9MX2Cjgz+sH2pMmsNcEWer1vTD9t06eBCzTGcelFae3wzNvlv1zBvYvdojg?=
 =?us-ascii?Q?0kJ8hdgrxMxhgDSBf5/I0yUY1B0jWz10T8VXkeCr1P36LxytRsevRxnBy5I+?=
 =?us-ascii?Q?C/zvzx1bWQ3nGPCnvyXKO9hQ9Vp/xSxmFas29K4yV09znxzMFJNHuneTCS/H?=
 =?us-ascii?Q?Ekux2Tnst/cpA/CLGm/WZBXGIDX2+PbpAEGoY5yESOLfh5Bdfw+DYOl9Xc6X?=
 =?us-ascii?Q?ckrt9zSzDWpTpewmO/idLJWD1QuOgduGB6sxKtMsX2Ng+IvXVqGqgVDlBjzj?=
 =?us-ascii?Q?/7DYiKYzTCLKgzyqukCQKswAfi8364lpW8zLN12VPSuw1OK7wg6eQCCmc49S?=
 =?us-ascii?Q?aoYRtxd716iWMLdT6+f6N0Vi6cbL4so7MSggY9eR6k0/jw2pHWiB4GI2AA84?=
 =?us-ascii?Q?TYAn2+yLDASQdc0l5c1FuKSJQInjAw1aSZl/Rq0gd3yWEaXho6KGaYWyo3IA?=
 =?us-ascii?Q?K1aN75r3bg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5da932-f45c-4f16-b6ad-08decd6a9ab1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:28.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOKhoi+WbDdky2LXQd6aGR2zEPIiS58dQpkNip0bMqRp7JgwXfaijRkA6G2ddQr8f2r9zEHf5BUYOGMT1CIdcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit abstracts the open-coded dumping of reader segments in the
rcu_torture_cleanup() function into a new rcu_torture_dump_read_segs()
function.  This abstraction will allow reader segments to be dumped for
other purposes.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
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

