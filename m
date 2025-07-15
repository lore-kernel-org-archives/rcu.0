Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A212C158E;
	Tue, 15 Jul 2025 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609760; cv=fail; b=S8LG4Rkwtv2YFVj8NYwH8ookFkhla5mnV4tXYLAAmxkRlkX6TSaZay33bzuudmN8cqZaISqbPI7R8eKbd5GqnCpVRYSzB6P/yKEAL38KzYnVVtmVS0JMJw2ua3SR38mnjaUEWxIJcGYvgs3RzN0FR1oUVF/XEGTefF8DPVrvaqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609760; c=relaxed/simple;
	bh=jz2y7OJ6aa4tkrfG6+u44mTGmsUIElpbi6ZziSsBtpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dWjS6498HUofxYbaIQ9vmdqLpGc2P8oMLXuWn7Wr2q9R6bAWBgi/0HeNzTh81v2adV9vItSrpKlZdvS5rwX8Jf70l1Q1ze30FT5Ely6wk4jE+s07ZtOwo0NKfFbcID4cyK54QfCoioPnDGWOYj0caXcDFXSTUcXSUJTSrMqodYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hdcZga5o; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hdcZga5o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrbXWs50oVUZ6kBUN+WBqVo8+x1Jcu7470sac1I8SE8KjrjVs9r35iD3cC03kXPi8sLKYf6I68HQq3ZUAiS9kHWMX2xGNfx5IBzTzoezKCShNvfggxtIFK7QAJmRFR7XLSxp76Zl3zwUSpWlCXenJplsFXYJuabrQyqrX6w+CYiWkgiRzsbd09pnxeliVtdw1TfUfEyBcjnJwtD/4WDQdtw1QRfvljiEjaSFj8DU4e++60HRFe8/w0szQugrlM1hzklZBjU5qTmD3BJcT83W5H4UPk23d7SHVWB7E37W/ImPHN4kC8NilNs2gs8GgZebFY0x19eWlFZlaVv7ptJEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX24UGdkpMMtU2K6+ypDl4RthGVvBipXkeFN3a4iBLM=;
 b=vrdt/c7NvJT7leY9TBTDZIpgaugXRqtWUfPQKZffOKWDFn2GrIFj7ZsWBNZwsgy3i1Ylh4m5aYRhX6cHpQSbynHVwx0sFvmS62VXtBa35U0lJTisUt0xcJ1FEl9jhhRLM68/xTwkeD8CjEQLqHvh+wgPm0vdwzf4lEOMhJwMKTruxViBruIPolBqzUrMforuQho36sNO9IE8LXpOvlkRfCIzqLOPdGIH1Js0Fvt2ub/VPW10VonJ4/1yVrAhH0nLZMpL52Qi9gJH0LhQUpT1Uwa2wZb4VG55zrzP0bR2qfOtMVrzWoBPqEl5fQTXY5tTcfdhpsUua1ezrKAZnZ16Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX24UGdkpMMtU2K6+ypDl4RthGVvBipXkeFN3a4iBLM=;
 b=hdcZga5oYMimtlDGNYP1Azv1t5KipHzj/sF07M3T7J61+AscdR8Ac7wEqQgV6meOmgnna4cICrxypvVajYgdD5FWG7Qc1yjeYNHQSSM7NajOurAPm+k82vm/AqjA3neTDL3Q92XaUaghwryfbFdTbU1d0Da3g4hTj6FvQaPwaj6XYRbPdltEuy7r/J+kNvwqGlo12MJwKrOzrBme+YAJ4bHbPjoYTN7drjt0lzJe7Or1dKDD5Fn5aDaequ5v1dsRB5tRyoqb45UKX9Ybw6citMz5ALM34mlYTGcCNACKA5jnK4kGPxzBrn+E8EWj3Bly4POtq4Gfvsd6v3qObPy31g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 20:02:32 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 20:02:32 +0000
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
Cc: rcu@vger.kernel.org,
	neeraj.iitr10@gmail.com
Subject: [PATCH -next 6/6] [please squash] fixup! rcu: Fix rcu_read_unlock() deadloop due to IRQ work
Date: Tue, 15 Jul 2025 16:01:56 -0400
Message-Id: <20250715200156.2852484-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715200156.2852484-1-joelagnelf@nvidia.com>
References: <20250715200156.2852484-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:208:23b::35) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: ea71aeeb-4f05-4102-a9f0-08ddc3da88a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TJjKe3e9ZquLQb8uMqFQS8wYuWJcsgPvh89JQjb/7fqW4r805pJHZCGi2tDK?=
 =?us-ascii?Q?0XiyXh53OQmG3YxWBP6cmuUqCZRJbujacsoD/zKJpgZV1Ek1V932GSMrXlY9?=
 =?us-ascii?Q?mCmXKbkbIPoBN0Z2M6+R+TB14Ib0wAiugeimx2cocBWHfa4Qw8O1E1Snld+O?=
 =?us-ascii?Q?nmXqwAGEmtioIp6njWb4l78w5AIcFMAksrsPofggrCRSD9ZU2piaj2Hmr7qR?=
 =?us-ascii?Q?OIiA2RQ2KsxmBylsukwalFFc7UOWmhp88m6/K18TbR4mjG0gTY190mMf7NL5?=
 =?us-ascii?Q?xxPJM50nSz4BvrS5bnZ7aDFn8vQz2XbOF1WJUPB4PA3G+2H7RQmULgw1SZzk?=
 =?us-ascii?Q?QexpLZxX1NX5Abufhb9hiNMEvS9Y7djeLh8mJAsqeUMYylFyaXR6VuVB6y3L?=
 =?us-ascii?Q?dVLctHASplGLI4mveRTlrre1EaWrCdF9T3v1I6pcUKCK68aiiecnDnVKCvN6?=
 =?us-ascii?Q?CxNNwAM3a/VEMe1KYoOHyZNOmtnyHN4SXv/AQcWRDpPnl6vJ0flfYN6DlYML?=
 =?us-ascii?Q?AhFyLrvwmpqK7lnuEDJZeayw7vZJpnW7fAAbRCiEFUnNfwfd9liq7p0n9sU1?=
 =?us-ascii?Q?A5enaoL5ph1vX0ukxlcaGt0e42rb2ED1K4/AiYORsVGGnAC+/XODteOoH7M3?=
 =?us-ascii?Q?trSpv8y43CrLGDU2z7eOTQzc1zyWmwcyB2BgWJdKQkRZZonxBuH3FeIB3Q6A?=
 =?us-ascii?Q?tRDyPBbpQ/tUSfCu1VzuG/X/yqL07VsQBPSgcljy08EkdtmgWnhtjccz6xNA?=
 =?us-ascii?Q?jrMceJmK1wcQ/DGQX2aJgr8nPUN5r6dyFhqfyMO+due66iUw553ZzbXOAtYd?=
 =?us-ascii?Q?0lADKRyqz81uCgtknXPCXk04SS6TrDmkCxYQ3IoMVJqFjbBojUqPu2YBXyPk?=
 =?us-ascii?Q?9lXybvKE92Zd8D+ODQjFSGMWA5Grnes3MVNsNSbwKhFORF9WVZIzWUJvGD22?=
 =?us-ascii?Q?oSLfhRDkk1O1rHJq1yYQ34K2zVdiJCVQ5Zr+oruQigVKwI2oztICprMQGyob?=
 =?us-ascii?Q?XBLxbeQImQRWBv4ZO0WvovuV92CzMP9Vx2IzVG1wDRqPC9x8GLclhA1D0tJ9?=
 =?us-ascii?Q?srZYZlPPTGHxTiKuFbORFTERs3cMteUYCrYa6DNsYPhukCYPg/zqUUwJzKhi?=
 =?us-ascii?Q?vxHwkJl7SDTqH3vCKJ1A2vpoBuj8RLBbqz0Eq8AXV7Cu6G90OUCeRG1Typwz?=
 =?us-ascii?Q?W4IDWASQ4ZmFsSqeJjkhhUB1nsJAUG96dqU89R6K2YDtcqqUB0wVH4XO82B7?=
 =?us-ascii?Q?wxiyjZB+w/p97l9/2gv2+7rznJYKYyC3LnIq6LzrSlnxURV2qC/6rE/cabWx?=
 =?us-ascii?Q?3zrRnq40sNgyPGP7z7LhhU3UTy9aqomGZ4ehXpdy2aDFhpb/WVCFkG8PmetA?=
 =?us-ascii?Q?s5w1KKh+aacPaaNcjDh0Gg6dQKRvaqzSnhn7IzAlRpsuUcrv3zGNaXE+6v5K?=
 =?us-ascii?Q?BJjqNzVw89vOVG/xY/jCWqNd7hKBdHQhUl3DnIYwiTi+mLGbMYjQDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KN948doYWUG1N7JIjs6cXN9cfilrBq/+eFR8Re5EhdEgE2JlpzfP9pgGvreT?=
 =?us-ascii?Q?jBg4+24dz8f0qA1uStkzkBCvC15TRNH/P9v1TO0sovz3BA5zsCs955uCui8Q?=
 =?us-ascii?Q?yst9DV4UHtsl+nMx76a2ky/pd0e8bt40s0yHMJ4QFRPJ6lSYk879jiW9WxCF?=
 =?us-ascii?Q?6GJffFI+TZCSE3Ks/3BVokcriBjMfX0ufpatkClAbfbHxilUwUsqF4KDKs4O?=
 =?us-ascii?Q?jGbqeYKawxPnJjkkF/ZDH0V/lCaIWTr6bG0pUNxoGg3diNCoeTcyuWOFnTvt?=
 =?us-ascii?Q?jR9p2+IGo5IcJ6Es3zCp28Nqd4is2kd7kNigcHNILrQGmAuxbDAA+bGpo84O?=
 =?us-ascii?Q?FSMyWdlI8J69YvVyvPJ0DCYhw7nnATY/MlgdhNEOQDPKiMVNauKDyZCLDRTe?=
 =?us-ascii?Q?rdDHt+nevr3YfvEP98x1lwu57WJDWF3CIOJ/uwFnjhDXYSeBt0xUnU9SmmUc?=
 =?us-ascii?Q?bzivlAsjuXrzZjHKAqlxrzCtztGbjM/18IeOTOAQcGR+9/74QXF30+HPVqv4?=
 =?us-ascii?Q?nWgG1aT/mg1c0RVKmCv+KP/iQ23B4xd7HYCHDl2+MwwSW57kypiWSU+s+V6n?=
 =?us-ascii?Q?CLCC4O76PjsUl3eI7SG4jbRCXeb/N0+80QbK/zT/j5fmmcLnuJ3irljrkMzM?=
 =?us-ascii?Q?MfRmTHJtC84jaxUMPeJOvFmmMjrxWN2kLmw1iGJJTO+vzYJEzi8lf07zhFs8?=
 =?us-ascii?Q?rBVzRXHiX3DfFGFLrYYrm0v+XEL2LgubfWvm5zAdYqsz9ZlVZo7nBz2mZWd+?=
 =?us-ascii?Q?w1JhpykfGsxSIjDReY+7ssCgioLyeVKTzmDBHiNIiluW9m8RyNObdeMjkfax?=
 =?us-ascii?Q?4Tou9VXu1+ZkxM4YWTSPva0RfgXbzb1PQbBGkx5LOxPjVM29ww4/zksYazbc?=
 =?us-ascii?Q?nEjJquUWnphFs83wIzmTLyomxHPGN7zR8GcHz/I+NhG5iDDBH3RDxFXHv092?=
 =?us-ascii?Q?EHYugSpS2Z00TldaExaEH+K+ct9dI0NY9loeO5jOXJa5qMnNaT/9DKGu13iM?=
 =?us-ascii?Q?hypdjq6gcn+f5ETuqqCEFaMaTih5hf9GgEevdzyOPY02P1wsDjMDS+o2+tzd?=
 =?us-ascii?Q?EgapsRc7zpI2ABzmkVZkEouvl1bEuynoKbVprb6N9Hq8NiYZz5fC6jHZrPFR?=
 =?us-ascii?Q?aKQlTU2rH/43sZ8zFjHUxrPzTKrb6kfO8UziK8tDKyYH3UUjoyV0SoB2PQrT?=
 =?us-ascii?Q?NCBxAvlvTBdLaXAN+Rxv0AtNHtCfk3dpegdk3Ee/WbFkMbDYxxgCL8s4zcgR?=
 =?us-ascii?Q?u+SUBj5XoLR7wFY3cQJdsW5G0U1Xff0x5sExVyVVWFdPftQoc9nEhxJ3Ja2Q?=
 =?us-ascii?Q?6XzXs+6rzeToL2YEQG1xVxCF3Kex/zrj78RLAKZ/XlWTh0eAWHwRy7f6PGq1?=
 =?us-ascii?Q?gMli+Gne5aSLz+PrcXt/+AqqEglLkVE+wyFspTe1ranEra3JxT9KjSlPapOQ?=
 =?us-ascii?Q?Iehjv/wj2cyD94Yf2ew4b7zmbgHX15SKXa8wBECBQVJOKSsj3sPv+I2O6YBV?=
 =?us-ascii?Q?/QVXgPhgknGexVrrPvjzhVsqSpUN+d0Rjsx5pJqDim6ViLOm5Uj5nzwN30RS?=
 =?us-ascii?Q?lwrRE1geYv2/dwhDMdD3LujVF6cUxxhhwdJaayaT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea71aeeb-4f05-4102-a9f0-08ddc3da88a8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 20:02:32.0494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPye+iHY1EGRu3QgmvvBvW9NTTuJ0KEH/p019a74YTHFojGYY1cN8DPhVGAQVlYlIYDVSTXESfWXgDtSmyEJfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009

Please squash few comment-related changes courtesy of review from
Frederic.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h        | 10 ++++++----
 kernel/rcu/tree_plugin.h |  7 ++++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index f8f612269e6e..de6ca13a7b5f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -175,10 +175,12 @@ struct rcu_snap_record {
 };
 
 /*
- * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
- * It can be in one of the following states:
- * - DEFER_QS_IDLE: An IRQ work was never scheduled.
- * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
+ * An IRQ work (deferred_qs_iw) is used by RCU to get the scheduler's attention.
+ * to report quiescent states at the soonest possible time.
+ * The request can be in one of the following states:
+ * - DEFER_QS_IDLE: An IRQ work is yet to be scheduled.
+ * - DEFER_QS_PENDING: An IRQ work was scheduled but either not yet run, or it
+ *                     ran and we still haven't reported a quiescent state.
  */
 #define DEFER_QS_IDLE		0
 #define DEFER_QS_PENDING	1
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ffe6eb5d8e34..1b9403505c42 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -633,7 +633,12 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	local_irq_save(flags);
 
 	/*
-	 * Requeue the IRQ work on next unlock in following situation:
+	 * If the IRQ work handler happens to run in the middle of RCU read-side
+	 * critical section, it could be ineffective in getting the scheduler's
+	 * attention to report a deferred quiescent state (the whole point of the
+	 * IRQ work). For this reason, requeue the IRQ work.
+	 *
+	 * Basically, we want to avoid following situation:
 	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
 	 * 2. CPU enters new rcu_read_lock()
 	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
-- 
2.34.1

