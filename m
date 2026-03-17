Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F9737CD51;
	Tue, 17 Mar 2026 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782575; cv=fail; b=UEw0U3rhi5kyGI17h7FwKZ7S60mTBPUqlKY6jlVF2gGqnpG7S0Sxv8RffOyFvdoKDmj751zt7SGwOJoQ2UpvQ9t21QK9UzTqccTJCmRDhs+li+F2fZ0foigmp2HybT1WvqU/W0lYY/NZlcWi5DUdRE1B2I+g8k4o25y8wmFvnQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782575; c=relaxed/simple;
	bh=do8umQSGBUsARx7Xy4oiBoBsBIm0YUdDaV9LvxSbJJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E8Tt0pFfZWAbo4yzN1xMWti+fi4kCpCM+oOukhAUQ/+yny0HaeM5cA/pP/AR/rOdintCDguXzOUAY9n8atbyxUhPId5R3V6eZYWZOGsXBsPmmQiAxdSttOT9OtbDHJ8gggR2N24y+Ry3gpkdNWl0wtjz9jaWpCXkUD9EwGJvxRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nF5VwnbI; arc=fail smtp.client-ip=40.107.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nF5VwnbI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CV+PXLybyi3oLS8svIMMXLl1bCvbsvZnpsIRdZ1dOAOckw8yaD9CXaWe30NwDiI7sfdQeVmaxawaiWaAo0e/bt8RDOhOF0GwSTSU3E5khHiM/e4MNqaDGhnqmzIrb7HTEtyHhYLc0LFkNaHXDxHItJqrNTMAOcymMlwPJZLAbCAMDTUSWbLKlHE6BVDHhAAmA7Vba8EM/gpEq1DO25OAZ1L3aRfJgLkD9f1JxfYuKLP5+U1E9Ja3NPI2IhaS1nCay4WD6VihitMrxyvmigrDPQ2EftVG2LXwiI8btOytV/xAQpnCZwR5z4JU2m5RBmPvf6vrZJe2FYgFBPEV9xWHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65LZUkoGjWzviq/iskE5aDMsOQdPMFKqZvDLIvURUe4=;
 b=pzzRyRuPKmYDY6cvGhoFH7imifI237gFhikHMi7v59SGNbot/XSjzTjJGEJSS0K3fxFkqh3RhKVa/eMz7/tGXrnMULsqM80QIn4G5YOcROweTGUNFVfWqv6lx49koM4dih5LY1B1RW7dBjIXy+kqqaFqhGytLXqxlXTqHEZ2Nyr03zySf7+1l5oVLE7FPuLIJUKSTxqIw0pHwhQleUBOkEfimSYn+05ugM1KZpu3UMrwqug4EPUtZN8RbJTv6hoqM6V5YMrqZNdn7Okv9ER5IrUhRO8Y+yP2jeV8qL2pHN3slXTnCUKef8sRm7foH08ZD2km8bQ1J74UcvNRSphPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65LZUkoGjWzviq/iskE5aDMsOQdPMFKqZvDLIvURUe4=;
 b=nF5VwnbIx7Vkgy6oKkt5CcONiEvsxfKKrimkpoVSpeUOvOksUq75i+9fndk/RIKlvF2P39mOPhLH+QC6FeBEQr9U9lnySWoToKm2n01VUeF/IPAXYYQEC/CDpFFJ8VWylbL+htKDNp1FckIZ1aStewwRFNT9Ihz9vOMG21aE/uf4kj0A1Hs8693f1Mi7KTs6EmbhpcUUJOh96EF6934WoXidiBl+SBZWvMSgicfXOSFTft0+mKBvgGUjcakEcuOXnleFhD3y8f8t/8DC+QDxijKdarpglVm0rAzJJIgujLC9OjxBoQiiq6KhWy8f5oC3Lc+tsW+q0JbGrW3tQdFfNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:22:50 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:22:50 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH -next v1 01/16] rcutorture: Add a textbook-style trivial preemptible RCU
Date: Tue, 17 Mar 2026 17:22:02 -0400
Message-Id: <20260317212217.1527644-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:930:4a::16) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 45604b3a-1428-4fb7-4337-08de846b57dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	vYLU7e83NZOXb2ssx1D+ZC5CI+XFvfZvgXvf4b68sQlGLQI/iCes4aKFgTcPEllbN7MCD46hd5X0qfTuIfOp4mD1RD5TXBffkyLrv3ZBWGHgymvelumNNd9m+h9g+nkbcuZwHi5A015wWJG//sJK4EQoHbOX03Y1FDIIbIWmf5malYXXEUcZq+v81xovD2tUjhDLPT/naW6RlUldFYJj72nmMaGKqdgD3zB083+Zv/O30aQ9TDaL5msagFNDwyF0DUd6MZ9iAWPhBLJNLU7tXvcrSjCOP/BW9vRGcwEktyGNkf9JBHc+N8/dIkJJXX+huNFBA8jAywNiKkbJWNMM8kMEtW/0b+2TzsxFllM/UbnMebgg2O2S/8+6Tzu97MsVmod+tKBXcHIBdRtydDU6OXkCYFxjXqkgdKf2dqUmKZ0nHGAZuJZ+kpcMbLVD2q4CUfL6PtBuapW9NcuUIYpzQsYfIBMs/rpYfyL+KG9ZEpxUeGQB4Ogo4KMqEG++5pqSb+wVVPxUybZzpSuLxv4SheU+fFKnIfviMrPCHKPd6gkZw1lgaq/bWaJpFxGIpiGIP33KQb0NR/DcRToYaCmUtoEOCq60868euw1V2FsmpNl3GbdEiT36QJ8pa8vM57zPMeDOhMxklMM64iHsAFoaz5vFr85V2hHeFZgzGMFT3tkbLLitWPzZjJynfjlHdvQ+XE+V1RxbIndAfSFIJrpnfFwrNIQdUU36Xx1xlJ/tCdU5UyYQzE/PhL8uyWpAaCMni1J3CEwYXFmB7fdR9DUkdw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6OPP8t+Ymc7KhMrt27N7WPHneKmdypeIXCibHdXdqI0lABdmfbKt/Ej/ZTyU?=
 =?us-ascii?Q?mcKW3j2ySEPBLuD7iBk8VKJpA2UREBxY6zCh3WtEVv/t+GozyFVmheA5MwmI?=
 =?us-ascii?Q?J9ed3kUTxqEFPHJahs2Il2dQllBAYp9dipEOod1wBAs+yRxgreNQRKoMn6At?=
 =?us-ascii?Q?V41dRmxUkiLYNleedc2PTVrUxTzNJE79ZEEOwV56Mu5JBFBe/pkKex2gb8Ud?=
 =?us-ascii?Q?yubVnKartnBQnLFcAlgJYXVOu/3iH4vyH1EKl+B0raEuTkgO4wsw21PLZiZs?=
 =?us-ascii?Q?xV3m6pDk66p6JLPGIJFd3/QfRUN7tkpzUqKig1k1c8S95/f7pQlv3j2uZgrL?=
 =?us-ascii?Q?5s00s7lU/hIvbXQ2+7wPEFzpbUvKdsY0130Mzndq592nJpFa40VZTYthGrNw?=
 =?us-ascii?Q?d8J/OMEozSPi2SFMN3YtA7PG7Y9KmFKTGYGQDsxCdkEPq29icmEa0f1zRFu6?=
 =?us-ascii?Q?3GovH/LKIpCimI6U7/2mlneaIlKsDlKy8pBRg/24nLCOXv8XFVvbfi5QXhlL?=
 =?us-ascii?Q?iKTcFNFzx5lFeVQtlbRGfnmPSWuhNvQapOfn86YmdVwMWfSPxYJU4QPbiB9U?=
 =?us-ascii?Q?7MIWm3KdN3+bTMuRQLBW981Jl+zREXUhrOtb0Mv8c2vAXWhEggbL0VsoW/XB?=
 =?us-ascii?Q?P93mJKetu/OtPP+FgpXIc18S8PR8itA9gapvbR9q5r1z/A5jn2Ypyx5z2HQN?=
 =?us-ascii?Q?PUIuHWgvy7DJy8npWsTpw5zI5gG3q+NeKFodeNEdmkjBtj8a1ZiaGiSidlAm?=
 =?us-ascii?Q?eV3VJw+9mu0rApLHNP1eqvcd2DiXFUgGNXHiXNcziituZTKMadyfLQcROfDM?=
 =?us-ascii?Q?MJhuvRoVhMTUwmqxOnLTCkjBv53u5vYvjzJHlLYGmP6y0iaxN9BBuLFOZL4Z?=
 =?us-ascii?Q?NOvjKb+kWcqbV/wM5h0IR6G3wf+PsMziVX1/YZ5NN3BQbWu+vS+nva1s7wld?=
 =?us-ascii?Q?6igUo2ex4Brid+4dcG+ZtEVU1WppZqDiBGUIvx1SZBM9HkX+NdfFoFEP8X9m?=
 =?us-ascii?Q?pgMwRHgt/4y5K8IG4d1aQPFwh3CXpAoM83fnqPRGbhd/CiEtbPLZeWyOUOq0?=
 =?us-ascii?Q?wXomDOiTrTlxMg+1kdnILKYwEVecrXbm0YdyhPyEhpCmWdqSmJIdLA7BWxQ/?=
 =?us-ascii?Q?OuqMGb7qpJQhbqwCYl6OaR5ZnA2WDHBks7CJ4lfC9o8YqGwClM9CnaJF/VNp?=
 =?us-ascii?Q?YzH80lenEC8jiReAM+YnTDTb3B8Hs6ECtyZ0MDh+Ly4m1dGUn4GIikTN5gxH?=
 =?us-ascii?Q?Pj0FDgFg9wrBFL3B1eOLE/PR+DwDoJ99lHmynwo0WwUlEuNxQmKD/1AhUPsy?=
 =?us-ascii?Q?otP6FHi+W5HUM6m4SrBfoYnFi2H7srH7rhUliFeRV63eJIFBxZ6tPQzWbIdX?=
 =?us-ascii?Q?GNDuKE7lQf+B57gHV+ChfM7zO/pjSAt3U/Tj1GOpxqwqpnh/CumnpgocIfoe?=
 =?us-ascii?Q?hzWCTNtgkRK9ccbShvK6nj8QqHezPy4iYZJnu4iEeXF6paGfKAUyuXj5z84W?=
 =?us-ascii?Q?lhBBPj8dkWXCC9NTiJfPf/yfCnUEK6mnc2raFV/WVOWXpJ3yJ/u3kER/+Zag?=
 =?us-ascii?Q?6GBlqGOsarC9p7UHOJ2YQtwJCz3Iy7qsrP2G0JFaV+zdYlLUOjTKeWpPr/0k?=
 =?us-ascii?Q?9m/4iDjj/GxKehCc6otBdfsrznF8YKekAD4jdDWhLIi49zYSycDMMvpCleqS?=
 =?us-ascii?Q?hVQKfNSx3jAHUMKaedn9gGwjsRygIvn/7ds16YY9jYF+cZIyFN9+amt9z5vz?=
 =?us-ascii?Q?C4kqHBRhCQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45604b3a-1428-4fb7-4337-08de846b57dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:22:50.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSrO0X8jVVFCgoAV8qS6dfQFuZsbksk5TSyFh3Q0h3QOSUvQB/h9vk/7v8AtSKZwbz01XpTRqb73D8cQeiYkTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a trivial textbook implementation of preemptible RCU
to rcutorture ("torture_type=trivial-preempt"), similar in spirit to the
existing "torture_type=trivial" textbook implementation of non-preemptible
RCU.  Neither trivial RCU implementation has any value for production use,
and are intended only to keep Paul honest in his introductory writings
and presentations.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 include/linux/sched.h                         |  4 ++
 kernel/rcu/Kconfig.debug                      | 11 ++++
 kernel/rcu/rcu.h                              |  4 ++
 kernel/rcu/rcutorture.c                       | 57 ++++++++++++++++++-
 kernel/rcu/update.c                           | 22 +++++++
 .../rcutorture/configs/rcu/TRIVIAL-PREEMPT    | 12 ++++
 .../configs/rcu/TRIVIAL-PREEMPT.boot          |  3 +
 7 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT.boot

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a7b4a980eb2f..940db7ddbb49 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -949,6 +949,10 @@ struct task_struct {
 	struct srcu_ctr __percpu	*trc_reader_scp;
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
+#ifdef CONFIG_TRIVIAL_PREEMPT_RCU
+	int				rcu_trivial_preempt_nesting;
+#endif /* #ifdef CONFIG_TRIVIAL_PREEMPT_RCU */
+
 	struct sched_info		sched_info;
 
 	struct list_head		tasks;
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 625d75392647..e078e988773d 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -228,4 +228,15 @@ config RCU_DYNTICKS_TORTURE
 
 	  This has no value for production and is only for testing.
 
+config TRIVIAL_PREEMPT_RCU
+	bool "Textbook trivial preemptible RCU in rcutorture"
+	depends on RCU_EXPERT && RCU_TORTURE_TEST
+	default n
+	help
+	  This option enables a textbook preemptible RCU that is
+	  implemented in rcutorture.  Its sole purpose is to validate
+	  code used in books, papers, and presentations.
+
+	  This has no value for production and is only for testing.
+
 endmenu # "RCU Debugging"
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index dc5d614b372c..37e7a8a9e375 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -682,4 +682,8 @@ int rcu_stall_notifier_call_chain(unsigned long val, void *v);
 static inline int rcu_stall_notifier_call_chain(unsigned long val, void *v) { return NOTIFY_DONE; }
 #endif // #else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
+#ifdef CONFIG_TRIVIAL_PREEMPT_RCU
+void synchronize_rcu_trivial_preempt(void);
+#endif // #ifdef CONFIG_TRIVIAL_PREEMPT_RCU
+
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8a9282a0245c..3c272413666b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1061,6 +1061,61 @@ static struct rcu_torture_ops trivial_ops = {
 	.name		= "trivial"
 };
 
+#ifdef CONFIG_TRIVIAL_PREEMPT_RCU
+
+/*
+ * Definitions for trivial CONFIG_PREEMPT=y torture testing.  This
+ * implementation does not work well with large numbers of tasks or with
+ * long-term preemption.  Either or both get you RCU CPU stall warnings.
+ */
+
+static void rcu_sync_torture_init_trivial_preempt(void)
+{
+	rcu_sync_torture_init();
+	if (WARN_ONCE(onoff_interval || shuffle_interval, "%s: Non-zero onoff_interval (%d) or shuffle_interval (%d) breaks trivial RCU, resetting to zero", __func__, onoff_interval, shuffle_interval)) {
+		onoff_interval = 0;
+		shuffle_interval = 0;
+	}
+}
+
+static int rcu_torture_read_lock_trivial_preempt(void)
+{
+	struct task_struct *t = current;
+
+	WRITE_ONCE(t->rcu_trivial_preempt_nesting, t->rcu_trivial_preempt_nesting + 1);
+	smp_mb();
+	return 0;
+}
+
+static void rcu_torture_read_unlock_trivial_preempt(int idx)
+{
+	struct task_struct *t = current;
+
+	smp_store_release(&t->rcu_trivial_preempt_nesting, t->rcu_trivial_preempt_nesting - 1);
+}
+
+static struct rcu_torture_ops trivial_preempt_ops = {
+	.ttype		= RCU_TRIVIAL_FLAVOR,
+	.init		= rcu_sync_torture_init_trivial_preempt,
+	.readlock	= rcu_torture_read_lock_trivial_preempt,
+	.read_delay	= rcu_read_delay,  // just reuse rcu's version.
+	.readunlock	= rcu_torture_read_unlock_trivial_preempt,
+	.readlock_held	= torture_readlock_not_held,
+	.get_gp_seq	= rcu_no_completed,
+	.sync		= synchronize_rcu_trivial_preempt,
+	.exp_sync	= synchronize_rcu_trivial_preempt,
+	.irq_capable	= 0, // In theory it should be, but let's keep it trivial.
+	.name		= "trivial-preempt"
+};
+
+#define TRIVIAL_PREEMPT_OPS &trivial_preempt_ops,
+
+#else // #ifdef CONFIG_TRIVIAL_PREEMPT_RCU
+
+#define TRIVIAL_PREEMPT_OPS
+
+#endif // #else // #ifdef CONFIG_TRIVIAL_PREEMPT_RCU
+
 #ifdef CONFIG_TASKS_RCU
 
 /*
@@ -4449,7 +4504,7 @@ rcu_torture_init(void)
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops, &busted_srcud_ops,
 		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
-		&trivial_ops,
+		&trivial_ops, TRIVIAL_PREEMPT_OPS
 	};
 
 	if (!torture_init_begin(torture_type, verbose))
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index d98a5c38e19c..b62735a67884 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -538,6 +538,28 @@ long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask, bool do
 EXPORT_SYMBOL_GPL(torture_sched_setaffinity);
 #endif
 
+#if IS_ENABLED(CONFIG_TRIVIAL_PREEMPT_RCU)
+// Trivial and stupid grace-period wait.  Defined here so that lockdep
+// kernels can find tasklist_lock.
+void synchronize_rcu_trivial_preempt(void)
+{
+	struct task_struct *g;
+	struct task_struct *t;
+
+	smp_mb(); // Order prior accesses before grace-period start.
+	rcu_read_lock(); // Protect task list.
+	for_each_process_thread(g, t) {
+		if (t == current)
+			continue;  // Don't deadlock on ourselves!
+		// Order later rcu_read_lock() on other tasks after QS.
+		while (smp_load_acquire(&t->rcu_trivial_preempt_nesting))
+			continue;
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(synchronize_rcu_trivial_preempt);
+#endif // #if IS_ENABLED(CONFIG_TRIVIAL_PREEMPT_RCU)
+
 int rcu_cpu_stall_notifiers __read_mostly; // !0 = provide stall notifiers (rarely useful)
 EXPORT_SYMBOL_GPL(rcu_cpu_stall_notifiers);
 
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT
new file mode 100644
index 000000000000..8230b14bfe68
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT
@@ -0,0 +1,12 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=8
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_TRIVIAL_PREEMPT_RCU=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT.boot b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT.boot
new file mode 100644
index 000000000000..299cd3a12df6
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT.boot
@@ -0,0 +1,3 @@
+rcutorture.torture_type=trivial-preempt
+rcutorture.onoff_interval=0
+rcutorture.shuffle_interval=0
-- 
2.34.1

