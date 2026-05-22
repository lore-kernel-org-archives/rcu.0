Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342CF407CEC;
	Fri, 22 May 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459848; cv=fail; b=hhNwLWKO9yrjISSskk5N19t/ARHdM0wVdZp1hnqy33NMgfMcyAgMyDhhICTBoZuJpT6Jp1d3EMvse/EzW6egS/kAyzk73P6YOxCOww7faiNmyRNFc+Bu5/hJA3OyEEWvy0MQOFFbqeeQaMJIy1yMhe5321z+TQ7tg/NEyKivg4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459848; c=relaxed/simple;
	bh=sNzdxytoBechEvKKJnuMx+G/XO/jUlvbQQkcFNUwhLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OVrT3twkVMPELraqRv0BzLuZ1qNa+XGDGcyuB7iD+s++epiLxkoWc1rd/3dNxpDfUI/+C1dPM37BY9vE5T5pfaa3Udqm5qYcRzxKHeVsWWf2lzVdUbQPY6RtE2vJGcr7WAvWoIaNJdUsMTlKwpsmxrW5VXYFEIRzIyl4CvMrmM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kfTPuNc3; arc=fail smtp.client-ip=52.101.62.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kfTPuNc3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAiC9BKKMGoEte9NCX/Cyc4OLCaOvy7OJWZk0IZ6/wUuoXVZ+Kld/Ire76DH+9mCdq0sZYwVh+jYglJ3W3r4aZpavfpd7TwhtBnet+/hHh3W69uFYa+Tfs0sKZoknJuCbfRMZy2FejhONvynBLBF5gslxlo0vPFUAcuDAl2Lh4VO07iCh14CbvzSWVGr2dkr5P4H57AkrUeOgD/gXnVUqxAb2Tb2aNO57m+8lVwzqSlCJeNWbsW3lGSTf/4lt6qh8mmM4VerurclsC95uHboCXmuQDftf8TpdH0tzpZMTyC+Tb2koElrqDfkTl4zT0Uc7LxCryRGIdwjDEQ2Z0hR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1YouM4wpBFrfULDHc0G/kHx5Tabrcs9Hjji7ybst4o=;
 b=fx/yqENhTJMJP6puBZBWE+hrjDl7vH8TThmIeNEudhviVrgBFdzV/RG0v5cosZFeqo+3JEb4HgZVXGnfjekcGVGjRV3gYwOWecyaNCzRI8wVWqdmcnZOyc6lEcaBfFL1Lj3See9Udo+O0HeD5LLtvDq+46KJ7CrQOqz7MN5BotBiwTgxaRVEl4U77Qq74cUFRy46tAeUzrZyvjiJW0HaBa7oYauJE+VIyXM6ruUwiD+heIRls0LL6svbnRC/UA0+LRXNw938FW6x0xdiRxBfLPR0zfEgWSPGonm2OVbzXc4FCK+pF/RYNZAgKdioQSOO3v1qSFTqwPPACODiTjt7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1YouM4wpBFrfULDHc0G/kHx5Tabrcs9Hjji7ybst4o=;
 b=kfTPuNc30WoYMBCEc7skPXto+8DoL0aW/ExTI/Zucrf4LV1+GHYWIKuQK2gaa14P2S7avaP8V8KOJv3WNBxFeY0fNs3f6WdDRJSZU+yhE1Nmpo4J/N6AxLciq4IoptprnzQl1beBzcg0KbSTm5DC3xypDO88p5+v/HxpC1D6+K+mZXtmACg8YErbi7jtFGrsJZaYOTL+cGFMmaBPPKuylyiZBPi+sq6nW8M19UphkbUt4m+QnGkO8HsloJKOS02jwRmFRwbipjJIEjO7H8APfyXmZZaGYZKfNVohrhdlmCT9vT3xxgL4umC5Yron9HfRgjAx/Fh6V5fbnUk7uD1QAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Fri, 22 May 2026 14:23:59 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:23:59 +0000
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
Subject: [PATCH RFC v1 1/6] rcu: introduce rcu_defer_qs_clear() helper
Date: Fri, 22 May 2026 10:23:35 -0400
Message-Id: <20260522142342.1536533-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522142342.1536533-1-joelagnelf@nvidia.com>
References: <20260522142342.1536533-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20)
 To DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS4PR12MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e61e10a-3a0f-4cae-eead-08deb80dc3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	60ERlrnzsmhyYZXHM/4uhDQk14mH9+J7CH4CSaCx3llJ9BHayjcbfPKlOhTohMzeMzXVHLJ8tjTV0KgmwxVq0+XAgmg1xcOlPbtc8AoAEBICYnN06XfRz/Ua/EkRTAnVeIcKOjwbedSMX0t1j0GcLyJuzNmvl2oLKvMxM1Pm+54XM5UF7G7LEQd48O1gakBwqhsm4xukhFzrEhV/ONgTyns1da8Qol+biSXxcOKv1hYDJmWVYXHyqJQa7Em7qgTv8V2OMFXiJy/pqUdfU67BASojQaf34ZV23tlaxvZ5dxJifqyZyPaa3LInRJV5w52ZFegDypN2TzpMwz5e7yNlpSNIGmoryqaG3EkyN1V5Ck5tyNZ8aj63Q8GxzTLYv3WWEI/qgSfDQf8m3tyENIXaVsrOdbHYc8bX064QEyusCWoUFxmvEWCEtvcixyfYLzBH8a8FrQ3XSMeJBQyI6mgIun+Q/E69YibDeMr+DAvdoVtb+EWWGbg10ZP1XjW62YM0R6Q+MlF3ka+DY0xnNisbKC0sdcO2t8g1J8YWNv3khg27Cxbb4ctrqwP09rdAQ+M2rQbOfHtRurf+IzOLfnjm/BAZhoEkNwJueYrHJBF+2OqxdaToyapglW5xJa8qflHARqplJ6z66IhR9ylkPb48Sbu2sec8TC8T59Yp5lwWEWCepiz6UcaXa1E6Vw6uA06y25jto6Oz25e/LJfbWTymTmFCOoSwTc6g7Jgin8xQ/sM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(56012099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iS1fV2U4lNfsz7l5obGoQzMLaYnoSOFsFmxbHY9xgj8v/sAcSfIXqp+g6Aa3?=
 =?us-ascii?Q?wP6c1DIVVhONK//BtiNhsgFzVO4+2jALIgStk0vhq2Gf2NYKmYCHLIpuu/+U?=
 =?us-ascii?Q?QvCB7svxhVcPHpBnbzNNJX9w2bNpcQdV9QGYEXLSEQIemieBVKBe1cMH7hih?=
 =?us-ascii?Q?GjCge+We447H04gijcQFyklApEX2bVDNjbWXDBCOCJaA15HIj0rnLbYIzwJn?=
 =?us-ascii?Q?oij2TOWxSBXN0NSgbJJx/L1OObo+u7lYIKXlioA7Rd5CsZQrWH54GnUNwtn3?=
 =?us-ascii?Q?KaBPm2e1hWEuhVwNK2gEszUM9MJMNwYP2PBgOzQ5YIOTS7MT6cheDGXE7fnc?=
 =?us-ascii?Q?wnIRZ0XSdxMZ20edOEgGgwfPO/owgn0rPIWQDT+1lyJqJZjEWF1dbLroZCSY?=
 =?us-ascii?Q?FbtQrH/xdedb0I5XPD/01un59HP6Az8ro8SP5mYzwxz/ro7+ld4whCAaBBMn?=
 =?us-ascii?Q?kYYHIYhApVl+wFdXSlHx0hgzU0/6fkkMS3IJVpmDPnBRvymQwLhzKNqxnydX?=
 =?us-ascii?Q?UbptwC3GCG1yFZe6WPHJw3lysioHzqDfu0YCJ+ESaQ/Af20Zf0Lz4AX2q/Xi?=
 =?us-ascii?Q?FgqkHN52F22Q8R1Ajkf6U/R2HdPXe2wHfTeKvGwG4KoXRZGlRQq6YIwxnhKC?=
 =?us-ascii?Q?E6xvXL5+0Ko2LYWXXToil7NAfudkfpu7Yy14j5HirXjkIYWcPuknmSXYMaDB?=
 =?us-ascii?Q?JTgpMgoDwFuIvCfXJVSXkbj6gK5rMgaVAkDnhH3QrvtXOkYMn/AqhWLmIBgG?=
 =?us-ascii?Q?tOm6DexFKAoHmSbmzoLt9yI4yk6b9GZrZh0xMD7fgGdxcO71j/k4nI7Pew7z?=
 =?us-ascii?Q?cBACKSB5j8tFmWebhR31y0Ya3V69VIn4yL9O5nNXMU+0pc0M6aBluQcTxoyC?=
 =?us-ascii?Q?HS62cESR7lukqQ98Kqn5V+v0vIKoBs5tJJSEnWKZDycRfMf4UjkvfU5nSXxY?=
 =?us-ascii?Q?F4Q/+EgiZvsnrReh5l2AomppChaVAMEeFJ7vRpV5lfHSPlUop7NWiKxtp/fT?=
 =?us-ascii?Q?PJFBgqJgAw0JYcgOYQZ0e/bAOXbtPnGcUIPSuFpMG648csrX+SfACIwVdITo?=
 =?us-ascii?Q?dSUQTMt7GDqrlf08kkygMppv06NjDIvWXnqnJO+05Mct1kiS36PaI6aJe1dK?=
 =?us-ascii?Q?kJmuJwyGSEYVjFLsfzcVc/2z/8v4HEdkQ4WtVxC+fYbilvlH5GGM7WOb1dV/?=
 =?us-ascii?Q?EY8TzIcuCG3WJ0kf63wIRuN/0dTnZxRgmmnY+UrCVA2LFW6htnutQZo5nYXi?=
 =?us-ascii?Q?+ZRZZYnlfKvb5xNaKMKB5KeBywt4H/AuMWlzZ54dkdNjA3e5OfhWgptEiLyt?=
 =?us-ascii?Q?H6CtucDIcA0VeG2FaJqNWjkKAwdkXriJEcoD2YoDQVLPg0dP7DPdjB0/p9gW?=
 =?us-ascii?Q?MbOE1Dd2WTxF9iICixIHyDKbrDGTiFECc3tDlR+dLruf6ESOCN4m8era/jyq?=
 =?us-ascii?Q?PvLs0rStOhw9bw2n2lsiuNykaW/vph7P7ruF8f5qF4EDZbLyq2dopud/Qdpy?=
 =?us-ascii?Q?Ix5csxTCTXvFFvJL+wWXCzph/60kbuIp5+ny2jFEDIJIKUjv+3DQqJ1rrWAe?=
 =?us-ascii?Q?lg9roIEnQRCmukQogOL1NQGYj2OdHy1M8t2K0wnTsoQIbztDiRysjBAp44MP?=
 =?us-ascii?Q?KVEL6wlaRcpJesIbMZfX9bj3QMLkhLuNTpGS+YFfWRaZXgRV0SCXCoZNbdwO?=
 =?us-ascii?Q?JZYqxm9kee7s9wAPxEmDYP1QNhSnNmpQ9aOTG2lR1erredX90T487B37I6vT?=
 =?us-ascii?Q?ReAeenFsQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e61e10a-3a0f-4cae-eead-08deb80dc3e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:23:59.5920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rwf0UeHqpwSlKbsICGAkhhnPPU/1icA7oo13judRuqjD1mqLA1+Q4518sAkXnVZlAtxOAQYRvA5Z9CRa3yvDbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793

Currently rdp->defer_qs_pending transitions from DEFER_QS_PENDING to
DEFER_QS_IDLE at two sites: rcu_preempt_deferred_qs_irqrestore() and
rcu_preempt_deferred_qs_handler() (depth>0 reset).  Both write the
IDLE value directly.

Introduce a single inline helper rcu_defer_qs_clear() in tree.h and
route both sites through it.  This becomes the single
PENDING->IDLE transition point for upcoming work.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h        | 5 +++++
 kernel/rcu/tree_plugin.h | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7dfc57e9adb1..4069132f9d44 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -296,6 +296,11 @@ struct rcu_data {
 	int cpu;
 };
 
+static inline void rcu_defer_qs_clear(struct rcu_data *rdp)
+{
+	WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
+}
+
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
 #define RCU_NOCB_WAKE_NOT	0
 #define RCU_NOCB_WAKE_BYPASS	1
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 95ad967adcf3..8637f405cb47 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -488,7 +488,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 
 	rdp = this_cpu_ptr(&rcu_data);
 	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
-		rdp->defer_qs_pending = DEFER_QS_IDLE;
+		rcu_defer_qs_clear(rdp);
 
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
@@ -645,7 +645,7 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	 * 5. Deferred QS reporting does not happen.
 	 */
 	if (rcu_preempt_depth() > 0)
-		WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
+		rcu_defer_qs_clear(rdp);
 }
 
 /*
-- 
2.34.1

