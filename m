Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA864407CDC;
	Thu, 18 Jun 2026 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808706; cv=fail; b=o+1T9ZrQHXhvTpThDmn5D9z+YuIWntSc3SdXD1HZj9LcaVLtQ2OUAAR/7qUbzuc9pbvrSTMEaNMZ+fJtzq7xNmmfbAc4nf7qtcOrx5lK+O1pU7k7OYc9i/zsT2QV7/aTMphyV7AXnbt5az5S7iD2Sr8vk8bFgy9vj1w0Q86wa3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808706; c=relaxed/simple;
	bh=isgylsXFQ9FWeJzO9pHYN1Q375/UbBfOvy4djEkoofk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKGnxBeRaoUCfwD7jPw1nbHB1ycUaUZ9km4I3ItupPMzi3h/kOguaZsLnkkzWCp88wpsvYX8715u3+T+TPq1n+RiLkSlJvth+P+SaFA4Havv/hmfLQiOuXeQ4R5m6mdkQk6Nz5B2H+ToMmU1rArQIqjFq6xtk8YTHzVjx2aVJ6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jYbl7kUJ; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jYbl7kUJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNLXfuOnxpJqC6s0HhDrQcY9kVr7pC7cIKvTnIsgSsENMTdd4m7cInb87nz4p1elYeeji3Wg37JudUxiHGEitYK3bPcDrmTTN/JxQW9Djb3qcK9OvlDCx06syhSFGJ6fIBm+44whlGleVtL/gp9y5v9ZlA+v/xlcIjw79x4venjbT5TfTDPMDG9L9J2tQJiC9yg8s1aulJalAETmde6CcnhYcxtOxJ/puuCn4ap5MmdG2wb1dFKvjHjBv6fHnq1zsGyu1M+t70hIRqw64s533HS51mrpiaHHKt4GjBNKQb0POUPMFW+tRn4H5CUzTGHNUUaydqtwfMSZnpGXuAKSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HDunSoeuMqIxyZpuCoF6TRatL2bfu5IBiTxoTH4E2s=;
 b=qDobgUz1MtNjOXIo4Sf/oC68QnRICOMP6441oDhOqT5ivPqHFr5pyH/xFOe8Y66d8x1xDZs5CSkVr4WdjQSgr5MvHLW5bhvWWZPEWBiM1s2mwiKNbKKy0PUJSNzIfvyu6+N2mcag5YlEzyUAef/c7qSqRgvssdJqh68tZUtFTvxOS22Ca1mwyIcCCB29HzDfTBgxWO3X2A/i4Oix1t5zGif4L6lSl2877ywvytdMKP4reITfA92JpzunU5I9uqcghCzfWXlSHiA+7F9QHBJa9WYnDCmIV2V25EZX/ErdXjfLyuQ68AznETtjUHsiz05oHV3YmdthEedRddOmCjrLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HDunSoeuMqIxyZpuCoF6TRatL2bfu5IBiTxoTH4E2s=;
 b=jYbl7kUJy2cYH3Lr3M2enWvah5YNR2MxccLc/kVbLyD4jvH5FE3vzvtcuT/jv7u0LSNGt+0qAszNC/1jxpJLv2kWQUwlWSWOtkYUhPIKDi2LZ5iM6tr2rMq9gHQzQM9ATfqWqfHtNIuU9b3lk8EF/8Q0iNqAfDrC+wnSQnQtI4tl/qyUCb0J9HagDQcv2NpnKW97JG8KRf1kWjXzMX0nrf5uXPiXzvhHEal+ho0sglo5Ng1oTHQgVG72faPSugbazyncpipkUKGcSU6akFpoiUH1w4CRSgSzll9X+PYMm64yJF3BT/5Wkkhbx+FxAmEbypffUu4/V7jmtIiOV3R48g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:30 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:30 +0000
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
Subject: [PATCH v3 10/14] rcutorture: Check for immediate deboosting at reader end
Date: Thu, 18 Jun 2026 14:50:26 -0400
Message-Id: <20260618185030.376450-11-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:208:91::37) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: dd307143-2da8-49ba-8883-08decd6a9c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|5023799004|11063799006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	J4HJgDGx8dcZCpnmoQoT6ud4cY4ZOYgXJxtj/TCT00bnFrVynNMZ8YA4oxLEglBZAdQ6iFYsbAjzda3Q5jKm4IZjpOMRMmFuam4wiKFDBODqsNN7ebsmFBOkSDBJm1BBjSHKAtKHXdD6+6fQJb8EvpmpB2HwqFXPlOrLEx7cYdR7V/UHw3ka6UZmAoEWM1JVORpyDVp1t8ZU8TTnLofUUnZzXCXWbkNYwyhzJtRvsSBKWEOZiB1j9R45P01vLKUx5AYp1dmAVEglnKplzpZfDndGlNGfK1oxjPVbd6P2c+B03hs89IdgNJJxqJ467kIZKzVGm6KGOK/d1ALXgwI1IjslZAhCVFK1gnUafq3LF90lpEfvgvYy27ZrxeStWNxcYLHJgqtcOZt7f2Vou/tmUF2jElfJtwIDtUQApY+hBuO57ykLuvFIPcmhKpuLikmZ+CkWrhgTb2tm5VbDNfBGyXPioKqFznMQX8jc8UWcNI41X7fCQ6x3LwMDb6e8y3foMWOu7sg2R6CLsuJdDv+uWk2NpdJI2cLNuv7ZuKX/HY7ds9EBrJrzkUNwZeridE7clTFo7Aer6t95wOBhk2WdNsWiuyx6Wu4t/NFJTmJVM6veKy2BnP/FJMfCfvZVZpXzirhSvHB0l8WLyzjgbT3HF49uwY4nUi6Bwq7h2WKCJ9WuUTu3P4oWxVN2kHON1JTF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m/KIJ8BaIa2vubH0NzdTThYll/2NKLUBMOWm6yyc9YzE7a1wlWRsi4dPSgHj?=
 =?us-ascii?Q?CYv5P5Hcq8ibNleJN5RhpCcYe1gFrd4nMymhL1MIQIIhzMY8yuDDAXXQZA7k?=
 =?us-ascii?Q?M2gAlWS2rlJ7yCNpiZuM45+ttwHUvt9pYI30dPZhEPIoBOvbNWtinJBaQZx0?=
 =?us-ascii?Q?oFqB/fQA8e8G6kwYEdZRMNBweybtwkheA8XE/ttKiJ+igd8xJp4uT8GVufVC?=
 =?us-ascii?Q?RlftHUkPTuwwhDIzTe1q73asotc4UOCoa7ItpDig7qkTBTB5XmNnFOh4495Y?=
 =?us-ascii?Q?K7c3nQeOK4YIMod8whi/XRDUKD+or3udoDEWTBi0Bdne7yT0q1/VhV0JBX0U?=
 =?us-ascii?Q?/0s0BQQtISTALIY7gnGB6/LxKI+4xo5ivUIDO1RCDB097NvhIQcAhXl1zNE6?=
 =?us-ascii?Q?Czs5wz6Vc/x/60csBBfNlfTqrvVpWktEzFS5tDVUVXYpPXffvukWlJV9Jr6I?=
 =?us-ascii?Q?zFaU96VZGiNXmiA0m1Yo/vLY3JXqVcnPXjqhoGJzv5EX4RzNS+PNRnul1jmw?=
 =?us-ascii?Q?7Ve9W6YO01rWgWlc32tCMxutx1DU709bXrMgJ7wDuzezvQJW1A2+mMN2pH/J?=
 =?us-ascii?Q?CyZbP7X53F8oyqFdbCzGo9Ho9LpLfo+KnfRY9cf+8VddXdrbwzHMf0oETKPZ?=
 =?us-ascii?Q?ZnG4UELKJ0ym91s8+xh4tcIaum+Nx9fjibiNpsKvmH9EOt87DTuktJozsFO3?=
 =?us-ascii?Q?glPfhIq8tj9AUWirs4EaaPf7FUu/jG0R8hNjcQNjnboOqd4ld+eYZY5WiNRV?=
 =?us-ascii?Q?SyAPq6F0a5iqVGBEBLSdXGSOanqJ2CL8hf9wvHMKRbMJ5QVx5PVjfbwe1Tqm?=
 =?us-ascii?Q?xGuK32Q6mTMod9zkAvfnf0cdHxZNmBZgVhpBon4VVBiBDWAtu/2uKRk1cLRH?=
 =?us-ascii?Q?u8BWKnb5vYDHkXhyOg6Otk3e7+1Q8tDwb14+Tfhzm/zmlZxXtW9bTZyMoNHi?=
 =?us-ascii?Q?+ExwR2+hJD/aMAT1kTLN0mGvtn9b9Q6T+xMFXkgZ0z4BdVghRwbfkloMkcP1?=
 =?us-ascii?Q?bNaZ6UcrXkTEp82byoCQCLMKCyVfUBqktGUlliOyUpk/1F0x+yyYCkLr9t5J?=
 =?us-ascii?Q?L7Eg/kdteZ9lBU+P1mVaBcafPsMvnRDbQ4OcbwNbnAT/W5DpX72uhviByAVN?=
 =?us-ascii?Q?SXBydehafz8EBKmIoaw0aR+IQjablIGQhL2Vxsu9iDy3joRXzjbyBjh9vgEA?=
 =?us-ascii?Q?HJCjmD+x6t1accoHFugp7laUcDVggy0Jfl2G8K8EQMw5LZKU9z5TJf4tq1E6?=
 =?us-ascii?Q?js+5aXL8UfBBR87k/thH9xik59Ae1cFzclLEwekMOggYE3yIMrzFkPGhkJyc?=
 =?us-ascii?Q?LNf8Z85yDflNGfba4EPulAvmiKRyB0X8d6VQK8gM16UDE1IDGNjrrY9fbaC9?=
 =?us-ascii?Q?u1EGNPaoJBiC/bFWOSyumcrFBT8TCsknxfWQGUIMNh4Qahk8Y3FaWtVZTgx8?=
 =?us-ascii?Q?WQt8Zc1n+e2whuZhMdBSl9iscZ0b6LmRX8VQ8+vhlT6i+baGJ3gOiTinzFiW?=
 =?us-ascii?Q?lgx0eUSnmPORFqOOD9UazrPHbsqPUrFFtBOGU7Kb2viNyBNcW4MlVbAfvjFG?=
 =?us-ascii?Q?b+17PND5bQsDHMmBv/MwOzD3bZwdTDXnlh0qkFzP7+RUUXU7YenkuCC7lAVc?=
 =?us-ascii?Q?IhDCX8mL+N4fu7ZtqRfVwWDAt+KSeEV85JVR7Li+Lo/0gH2kroPMZ1ha+0JF?=
 =?us-ascii?Q?b66+oq2aR15UFSZri+apWub3L3NeKLB/vguu9cOGlkRUoNQtZ3KV2sFazC7T?=
 =?us-ascii?Q?Ojuxf1XoKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd307143-2da8-49ba-8883-08decd6a9c0a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:30.4029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AI+Nlww+WeAB5UP2hjysOHnwTFRIPN6uFAWYJ0N6EJ5W0Kx/KMfSTPNbJ11WA0ooiKdJaugg710sZX88IQJP5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a check for failure to have fully deboosted a
multi-segmented RCU reader at the end of the full read-side critical
section.  This check only happens for fully task-level readers, because a
a handler might have interrupted an already-boosted task-level RCU reader,
and a reader in that handler could then cause false positives.  The first
failed check (due to an RCU reader that was not immediately deboosted)
causes a splat and a list of the segments making up that RCU reader.
Subsequent failures fail silently, all in the name of keeping console
output down to a dull roar.

Although most uses of RCU priority boosting serve as debugging aids,
this might change, and in fact might already have changed.  And allowing
(for example) RCU priority boosting to persist until the next scheduler
tick could cause an aggressively real-time system to miss sub-millisecond
deadlines.  So we do need to find this sort of problem during testing,
and preferably not in the field.

The name and type of the newly added rcu_torture_ops function pointer
(named "->is_task_rcu_boosted()") may need to change should other
end-of-reader checks be needed.  But let's start simple.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcu.h         |  7 +++++++
 kernel/rcu/rcutorture.c  | 22 ++++++++++++++++++++++
 kernel/rcu/tree_plugin.h | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index fa6d30ce73d1..14faa11ef23c 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -695,4 +695,11 @@ static inline int rcu_stall_notifier_call_chain(unsigned long val, void *v) { re
 void synchronize_rcu_trivial_preempt(void);
 #endif // #ifdef CONFIG_TRIVIAL_PREEMPT_RCU
 
+#if defined(CONFIG_RCU_TORTURE_TEST) && defined(CONFIG_RCU_BOOST)
+bool rcu_is_task_rcu_boosted(void);
+#else // #if defined(CONFIG_RCU_TORTURE_TEST) && defined(CONFIG_RCU_BOOST)
+static inline bool rcu_is_task_rcu_boosted(void) { return false; }
+#endif // #else // #if defined(CONFIG_RCU_TORTURE_TEST) && defined(CONFIG_RCU_BOOST)
+
+
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 42f94c62c18a..04c36fcde5cd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -426,6 +426,7 @@ struct rcu_torture_ops {
 	void (*format_gp_seqs)(unsigned long long seqs, char *cp, size_t len);
 	void (*set_gpwrap_lag)(unsigned long lag);
 	int (*get_gpwrap_count)(int cpu);
+	bool (*is_task_rcu_boosted)(void);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -635,6 +636,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.format_gp_seqs		= rcutorture_format_gp_seqs,
 	.set_gpwrap_lag		= rcu_set_gpwrap_lag,
 	.get_gpwrap_count	= rcu_get_gpwrap_count,
+	.is_task_rcu_boosted	= rcu_is_task_rcu_boosted,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -2565,7 +2567,9 @@ static void rcu_torture_one_read_end(struct rcu_torture_one_read_state *rtorsp,
  */
 static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 {
+	static int firsttime = 1;
 	int newstate;
+	unsigned int nsegs;
 	struct rcu_torture_one_read_state rtors;
 
 	WARN_ON_ONCE(!rcu_is_watching());
@@ -2577,6 +2581,24 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 		return false;
 	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, trsp, rtors.rtrsp);
 	rcu_torture_one_read_end(&rtors, trsp);
+	// This splat will happen on systems built with CONFIG_IRQ_WORK=n
+	// and on systems where arch_irq_work_has_interrupt() returns false.
+	// It might also happen on systems using a short-duration clock
+	// interrupt instead of a self-IPI (powerpc, s390) or that use
+	// neither a self-IPI nor a short-duration clock interrupts
+	// (all architectures using the generic implementation
+	// of arch_irq_work_raise()).  On such systems, RCU cannot
+	// guarantee to immediately deboost RCU readers when the outermost
+	// rcu_read_unlock() does not end the full segmented RCU read-side
+	// critical section.
+	if (WARN_ON_ONCE(cur_ops->is_task_rcu_boosted && cur_ops->is_task_rcu_boosted() &&
+			 !in_serving_softirq() && !in_hardirq() && !in_nmi()) &&
+	    READ_ONCE(firsttime) && xchg(&firsttime, 0)) {
+		nsegs = rtors.rtrsp - rtors.rtseg;
+		nsegs = clamp_val(nsegs, 0, RCUTORTURE_RDR_MAX_SEGS);
+		pr_alert("Slow-deboost rcutorture reader segments:\n");
+		rcu_torture_dump_read_segs(rtors.rtseg, nsegs);
+	}
 	return true;
 }
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index f906d5d59b7f..35d90eff871e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1026,7 +1026,7 @@ void rcu_read_unlock_strict(void)
 	 *
 	 * The in_atomic_preempt_off() check ensures that we come here holding
 	 * the last preempt_count (which will get dropped once we return to
-	 * __rcu_read_unlock().
+	 * __rcu_read_unlock()).
 	 */
 	rdp = this_cpu_ptr(&rcu_data);
 	rdp->cpu_no_qs.b.norm = false;
@@ -1423,6 +1423,36 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
 }
 
+#ifdef CONFIG_RCU_TORTURE_TEST
+
+/*
+ * Is the current task RCU priority boosted?  This is used by
+ * rcutorture to check that tasks are always deboosted once then exit
+ * an RCU read-side critical section, no matter how many overlapping
+ * segments of rcu_read_lock(), preempt_disable(), local_bh_disable(),
+ * or local_irq_disable() made up that reader.
+ *
+ * The lockless accesses in rt_mutex_owner(&rnp->boost_mtx.rtmutex)
+ * are safe because tasks release ->boost_mtx when they own it, they
+ * cannot be boosted unless current->rcu_blocked_node is non-NULL,
+ * current->rcu_blocked_node is modified only by the current task,
+ * rt_mutex_owner() uses READ_ONCE() on the ->owner field, and the owner
+ * switching among other tasks cannot force an equality comparison.
+ */
+bool rcu_is_task_rcu_boosted(void)
+{
+	struct rcu_node *rnp;
+	struct task_struct *t = current;
+
+	rnp = t->rcu_blocked_node;
+	if (!rnp)
+		return false;
+	return rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t;
+}
+EXPORT_SYMBOL_GPL(rcu_is_task_rcu_boosted);
+
+#endif // #ifdef CONFIG_RCU_TORTURE_TEST
+
 #else /* #ifdef CONFIG_RCU_BOOST */
 
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
-- 
2.34.1

