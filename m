Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87612DF3F8;
	Tue,  8 Jul 2025 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984564; cv=fail; b=RU7vvDm+eLKkzwTGeSrBk49zqCWpHqpPAQXBOSiMscMax8xq4PLkK3keg7ECt2F+ua5K5QwJyYGMhLYytlauHg+Xr+idZhHgaXm0XDSddIN07LVsaFW6fk9FJQocBnXX+NcwnfTXtKb6ld8jarJexHFiRRIf3g627JRTJ74f5LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984564; c=relaxed/simple;
	bh=K8ljY8/u9DIah2j/7GKPtwFUkAQqDrvjNC2lkUSdmRM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MhvX+9rABJdCohwQmvIb9zxOkNic8G5WWJdoWVYXT/4VUnVIItuqaCFEBA1aV3hyLblAmYEzTS0gQx4sAuyzrZ9op7RL77bOD+to75kzkz+wbd6Om6BBuQls4NN1upjE8eXC5dTEUQ/DQstp0oOCwYpSt3YF4fE81rD4UrOmbIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kEKEkDbG; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kEKEkDbG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5Or0YxXIn5ZzCsZhRRQcsd11mzGTaQUs25TNMGUVR35jofrF0XYA7DHnTEJOdAGyQnIyp9dJHLYKPQ/AHrLW1FqfKQdmQqmBYVHFt6l5G8CuBD/+shx9q7OwNUmrPDYtePJsa411/jGLfH8Addgk4QP4oa9DGkp4tvZYy4J63EpZeldqAy+xpnlLRCdwoD3xQnGNIreDl3KhojiwzAej4TZNZn59E5SC0fzU7jjETQmCgAkfxOkMFcev9Dez4uaAzqpczvDv4DyZdEpyvFUwKJ0fOPicy3MnHaxtzvZw0k+DTzZ1RBaqQo+hP53jZp+R9binZlJrp9YOIZKeBWT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ss9MhyMZXwYNxeeNugkbOUpkHHQI7AJR6xCeoZfKhfc=;
 b=jxWel37+mGLLqFf7v1u1xVyjcoV2/W+QflTV94RDRdEZdONgqvhC05HWqacmd9h24DbfIoaZqtmR5CiptyWJvng+LoDksMT+lyczlJIIo4rBNiR6XHKrnmt3vLBB3pTAkN8iKGMmFOjj0/KR6A8H2UmO6pMA0OKKoJVnKOs/U1DAOnOQba5czxgZy1lk4TPDeLsDVhBy3j22dA89Hij1MttVfOEoKEXckkT2IWjYFGCBtuI0X5SXKo/klhMkrT5QpnqEXzUfH/brOWQTGkhZWxtuPQVab9FGtaxtGXQRnDR8s45/DylxTjuzfJNSHiOWRdwnY790gqEG3lOh1665Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ss9MhyMZXwYNxeeNugkbOUpkHHQI7AJR6xCeoZfKhfc=;
 b=kEKEkDbGFwJh2daYgrf0L1Vvm4uAhGda98gry+i1Wi4tp9KI6oOPgf1L6Bi6BglCAqxAvj7cxlcTnMfipfv1mPQVbgH/c9Krii1xpocNquS6DHrTreLn5rua+T/W+uZ9taTTqy+ydYW3z3M5QF+OlJsc8pCzNXzd1mbEgfiDCYsKdQ0b9JBKlZmGuLFcreBwZXSxqLtf5iGGUM5Soa9qloqZorjhx24opF7QMqEgusT9E3OlbEFOZXO1K1kELyNQmxIU2uPr6biBXvsVowzx6ugIwOGNEVmUQK4L/OA2cIQWpP2uH0vXd3jix5gnD82dlh3+AbkyuomlRi1oDnfIzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 14:22:39 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 8 Jul 2025
 14:22:38 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Andrea Righi <arighi@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	rcu@vger.kernel.org
Subject: [PATCH -rcu -next 1/7] smp: Document preemption and stop_machine() mutual exclusion
Date: Tue,  8 Jul 2025 10:22:18 -0400
Message-Id: <20250708142224.3940851-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013E01.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1c) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: f6def151-e48e-424b-e1b1-08ddbe2ae432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kWDjThRkSlapLTaKOEd7v9dZnOU1y9HMB0FR2E4eJ3gPCfrpPQU4PoBoLv8k?=
 =?us-ascii?Q?EAIeWZ6hKr7P7IYhSSdpk7PgDohD27V6Z94d9hNuLNCrWxLPmng8rMd0W04H?=
 =?us-ascii?Q?fZL/xSgTLDh8mN2O6bh+nJuzW/SPrOd0xtUMBM8dDNZHeP9Zd1WDpx6cZSgA?=
 =?us-ascii?Q?YyVZNLfSaD7uACzBphAO9m73Rw9OZjI2Q/eLiWi7OYQRi7CHxYA0CDcwOxpy?=
 =?us-ascii?Q?0BWJCzM4AILlSXktMPjO+CYSYNMSTUyqAGYPBNnMl2EQj/hoURTlt8li3KTi?=
 =?us-ascii?Q?k9Mkx7P+6pcLa+5S4rYpb/KSST3IZycawpXhibwp2BvvLDbaOFeQZMdhdgIs?=
 =?us-ascii?Q?pIIuaStM8XZDEYLfRKZcDcDMEbL3Bx9c1ITb4kHkuEFAn+uylLk8jpAsDUG0?=
 =?us-ascii?Q?W4jZYCl4e1cqwTFrhd9jxuRx46+qzcGU7RxplaJ/PicEusyk88n/osNPu7fQ?=
 =?us-ascii?Q?TIfAF5wkZsPwWs5sUdHYxpNzVOYlmAn0z6IP9ejmVSQshzPuxWj1EyQqltQ4?=
 =?us-ascii?Q?KWE7dWLeCPzVj6nhwV5rkHG2ewhU/zcd8GVZt+Wlz+DVHsbZvT5YqMhkcKTZ?=
 =?us-ascii?Q?+u70mm5itbOfAXm3qf8XY8QBOXj8u9DfkKimoFdDSNN7OSwNf/8A02OluuiP?=
 =?us-ascii?Q?HkVIxjaw3Mcgk5yViOU6pP3E+CHFqUOMT87fcGRYXJjkYxkgWAIz6g/JBZQD?=
 =?us-ascii?Q?2rUdEPvFhoDqshes0FhwZG9krHWxIjUNGKu2rw4037veT4bVOraPYKxVn/TA?=
 =?us-ascii?Q?SxRF8M7SV+LTT2oWutNQ+Phaf9kxeZzDZ4XGMwWSRZ8IcAT/oJw3p0Jp4GCk?=
 =?us-ascii?Q?KWNYX8GXC32D9rPoh0jX+6ppKG/S7eYhyb5rW+cNg7ow84g5PpcGVs4QjR+g?=
 =?us-ascii?Q?pamxpS5iv3iH5g7bvHGnRi69QBoeXSpFq+6+nDw9i4KpWwyoXNHQ8oC/hnHo?=
 =?us-ascii?Q?1ZzzviG/qxahkXVlW+tra44RsTUdXLfYQGQ6FoeHUxNSEX6mGAPj+9HpY0Zk?=
 =?us-ascii?Q?1riC3NSGkKO28De5FLdRFkpGcOsF0kzCPQaWtokcxm0nAO+Nrje40izFNV9U?=
 =?us-ascii?Q?xmwsOPvenszijii7YeujB0bsAghRRaTwoJKs1wn32j/i3dgqRwbGUFGjfkpY?=
 =?us-ascii?Q?tKwo1tYtKN+W+gUOxqCECud0Cfy/DCZwuJ9jclFDWjaJzTsMmnsUOXEROd89?=
 =?us-ascii?Q?VB3TbKCpKbyPDNd+ED2/I3aiCL8aF7zE4++BjHR9utwKt6Y2Qlh+eUH8+D9H?=
 =?us-ascii?Q?lXqxw8LvvVJwCFhtFFzCvvooU863Mhyuppe4wkRNpl18ecAoYfKneJYDgKVo?=
 =?us-ascii?Q?rhnergMhMxg/jTBypDHfdQg61L9VZgIKozpU6q+VX58HeKCVP21u7kgyQJ1T?=
 =?us-ascii?Q?he1pTvEMBWFHGnux2EU/NFFn5FnAr2ihzOu06lOwjt1MIK5zvSHZ2/MlF+05?=
 =?us-ascii?Q?Ur5RUy2KxNs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TEgJKtDmVAJyRjgmwjd+SOFnOJDpa0poaJmk8Yk8+KSKhKAWUkZ2oZ8gCkQe?=
 =?us-ascii?Q?HBjJyuZFwHou+uQQ3lKkrNWo/Deb526giF51QJJmZ0BYkXFg7Lh1XsYBgWkv?=
 =?us-ascii?Q?lbanHZjykwKpkmkGvba/PFetlTnLNDhnSi5KeIw6gAGJ3e65bezMUH1LzOBR?=
 =?us-ascii?Q?l8gd2lnnQW1WxMiCDBbUhDDAKM4NCuY93HzgFBZJu2D0cV4eJm/vLmPTZLG7?=
 =?us-ascii?Q?6oxSld65ah8hEJ/qm69T4O9YrlwZUXx7ZdSkMsIppGZA06vbJ2Jhhz1ldPKh?=
 =?us-ascii?Q?5z2yaCRvfoTTIepUusAArfGDJAI1jxwTq3INXqPeGlZ9CzAOhggtoFzkti0h?=
 =?us-ascii?Q?XEspN7rG6UL1IzJR8f4zo4d0PvaxXzK10kzS+HhXLCmcI37zgjEis08mzTE8?=
 =?us-ascii?Q?lgb/Z5ayQEPecaGXT7/2sy+W1VDBgFLijbtnZGROjsvDYGrdhnoi+GjzJPmk?=
 =?us-ascii?Q?Ju5UROvZYTsjb8uLkk+6byk+aEaqcK4gzoSu9j7uZcbU9EuwddMhn9klxphH?=
 =?us-ascii?Q?3DVEMeXcA5AyMZTcq8ALZ0qaNsVV6GM+/oMYXFpE41WRK+aMc7y3relgaSft?=
 =?us-ascii?Q?4pdD/OJhVX4pZMXWsksP1XUw5sTdLRo2MhjvWFDI0kd3kTm+gGqwt+iiCcD2?=
 =?us-ascii?Q?msYPep3snJoy2xTIKQBEvePWanm+S/OLYuQrkoV8ZQSJY5tUL9idLMWajDC/?=
 =?us-ascii?Q?nVrLREd6Bb8f1zx0md8eY7WJTGRxRBXufWdnNSdgZ6t1szlxf8KArpRzpXie?=
 =?us-ascii?Q?YGokBSF+CQzApWMRPcNcqh1CcHvJag1pTZmxy7vdXBIs9I7A7yOHThOAY0fr?=
 =?us-ascii?Q?INpKnX/Ipfougrw2u4B5elfYq/9MId20ElYAkJnifeakPgLX74yasdDqs8hP?=
 =?us-ascii?Q?JFskyFq7uU6oL3N6izTA7H+7mNBhCS3kXsm9IgdmjgPnBWi9F6qywXBEdVx0?=
 =?us-ascii?Q?gfZDSuqkZnxZEt7UVsW9I3kp9qJcXTP1yglEg5Vgh7xt22HHedsaXTxTzJH7?=
 =?us-ascii?Q?X4HDzVT5C/UfAUrmFft+ELU91aNyzvxeCEqUJKf1R38+rmLlC0k0KlbhTl2G?=
 =?us-ascii?Q?lXgw/1bRxcf7nP3Q3DUf0RkDmxQFPGiGL2X00hs4gAiOamb2FfqrV3ZiPlK7?=
 =?us-ascii?Q?S6V8h88jh65xgzGj0tviLnAtHwBVvflAQNTnqkPdWWpPWswZnjSP6p7UZ3vk?=
 =?us-ascii?Q?tRO8s9+b/YfMkNZ05kLqgg3Bh1WdoJr7LjzqvjBv1kb866r9wrfoBwYD4foh?=
 =?us-ascii?Q?VsIUttWhSSK6/Eiz1AojO6k54fiQ2bKKmqtPn8HGZw6rm+Ut4CFWxazZkHuM?=
 =?us-ascii?Q?DBE+w4uIRjnAU9v1nvMAHesnXm7HK5+etPwonieGyC1/gJi1m2iZh9xNaeKH?=
 =?us-ascii?Q?JKaak2/9KfBGlglhRjqcMcLoDZ27Sc78lGuKni7lbfSr9mQmwTvgBNnSmkb1?=
 =?us-ascii?Q?8kcEku6dNkXh6mQJqLcvhEMccxTE1EqgFbCHglDSeiWzpEE/0qZ7tSckoreD?=
 =?us-ascii?Q?hW7BLZIFd9SxAdAwhaUD4V1dHyydx8W1oG9SEoXUcGltCGiA7KV9addIZ8p7?=
 =?us-ascii?Q?7mH/xwlz8C9apMgOyj9Ee0p4QjSfZhv73Qt+PNsA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6def151-e48e-424b-e1b1-08ddbe2ae432
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:22:38.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgbn20Y/jklOaVtLLUOnm+7jIOQgqNbK+ALjzEpI6mkrDk7Wr/8PbisilJBBkSg9VW352R5orY7ZYf4IygyoFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

Recently while revising RCU's cpu online checks, there was some discussion
around how IPIs synchronize with hotplug.

Add comments explaining how preemption disable creates mutual exclusion with
CPU hotplug's stop_machine mechanism. The key insight is that stop_machine()
atomically updates CPU masks and flushes IPIs with interrupts disabled, and
cannot proceed while any CPU (including the IPI sender) has preemption
disabled.

[ Apply peterz feedback. ]

Cc: Andrea Righi <arighi@nvidia.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: rcu@vger.kernel.org
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
Just reduced LOC of that first paragraph by indent, and some minor nits from
Peter. Removed the comments in stop machine and kept few comments in smp.c.

 kernel/smp.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 974f3a3962e8..23d51a8e582d 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -86,13 +86,15 @@ int smpcfd_dead_cpu(unsigned int cpu)
 int smpcfd_dying_cpu(unsigned int cpu)
 {
 	/*
-	 * The IPIs for the smp-call-function callbacks queued by other
-	 * CPUs might arrive late, either due to hardware latencies or
-	 * because this CPU disabled interrupts (inside stop-machine)
-	 * before the IPIs were sent. So flush out any pending callbacks
-	 * explicitly (without waiting for the IPIs to arrive), to
-	 * ensure that the outgoing CPU doesn't go offline with work
-	 * still pending.
+	 * The IPIs for the smp-call-function callbacks queued by other CPUs
+	 * might arrive late, either due to hardware latencies or because this
+	 * CPU disabled interrupts (inside stop-machine) before the IPIs were
+	 * sent. So flush out any pending callbacks explicitly (without waiting
+	 * for the IPIs to arrive), to ensure that the outgoing CPU doesn't go
+	 * offline with work still pending.
+	 *
+	 * This runs with interrupts disabled inside the stopper task invoked by
+	 * stop_machine(), ensuring mutually exclusive CPU offlining and IPI flush.
 	 */
 	__flush_smp_call_function_queue(false);
 	irq_work_run();
@@ -418,6 +420,10 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
  */
 static int generic_exec_single(int cpu, call_single_data_t *csd)
 {
+	/*
+	 * Preemption already disabled here so stopper cannot run on this CPU,
+	 * ensuring mutually exclusive CPU offlining and last IPI flush.
+	 */
 	if (cpu == smp_processor_id()) {
 		smp_call_func_t func = csd->func;
 		void *info = csd->info;
@@ -638,8 +644,10 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 	int err;
 
 	/*
-	 * prevent preemption and reschedule on another processor,
-	 * as well as CPU removal
+	 * Prevent preemption and reschedule on another CPU, as well as CPU
+	 * removal. This prevents stopper from running on this CPU, thus
+	 * providing mutual exclusion of the below cpu_online() check and
+	 * IPI sending ensuring IPI are not missed by CPU going offline.
 	 */
 	this_cpu = get_cpu();
 
-- 
2.34.1

