Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452DE1FAC5E;
	Tue,  4 Mar 2025 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118516; cv=fail; b=ptiZPQ//Q3wL4KJbw5HsZsF+GMPKdFQIUt1tpcMQogIHqNohXwN9AMQuRQFw4yDIotNz2snzBWLSoB7tT4pP/dBrkE0/xHlqjrcS4ooGg8COpHAmhkC3u84QaAHWoDElZHK1q4ptMClQpw1tkIy+Wk4pMc/451GB5u3QUwSeZnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118516; c=relaxed/simple;
	bh=uv49jkEZgOHJhv/fZrYtxOFbCtd8WXh23sCahF4Cl9I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sTR/UBMaJ1FauyMiXV4C/GL2g5FzPfYBscWWN7WWaTPESws4W+eKhWP1Fcts68PPQcX1ub9KfzsNy0fWRBVIZZa5t280SSlFzBfcvE1DYU8wFx1F92p7xl/zSCYOCozu4ly0xqdCsvtj22BtaRO2AxSirfhdtRbb7S3R/sugmJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r3qeVSx9; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r3qeVSx9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPlmAAO4jaSzu/ho343+Y5PuyJYSuWmJM/UUUv/BsgBbYOBhE/7s3HTSfOV/ogD/uhvefp7XUlVv9k1Ku72NLG7nn6deRqAkPYEu8MQSJ5DsB39Ff/5FIx7ZEM8eObGlDuzrYOoMjRJRsKdxtRS6jX25dXiwXgwRQToe29TevtcLc3rLZ1IieOi6fGreeMbNIlRb2E7WfZQ1avCzqs4nWPYPAGPPtlrqJaMm3qBWIoa716CMrRS/mtUj0Gme+C/Aqf2o/9190zxuq6St/QeMksnvaX/BLEIQaeuDb+RRb7w0Rk85Xxk6fwypiRbb2HZrdys8cP6eQb+g8l3Es8bE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Fs2F2blayEwmcNXO8eonCGzUd7FxYIoRQC9g+5XSVg=;
 b=I5kxFcN1BYnAKsI8J62ilQzDXn0mRa99wL2LcJJ6UIsnDGNxw9GCvXrL8rb09T6GkYvxL+Ti9U/GKhmXv2jH6+VP4sK8zvMESAUB5I8LW0+wUt44RTctaAa31slhCFl9go0yuwz24C4jPPAB1q7RCjqcjryw7zei2a0pmBC0dlG+Jqvw0JfXayK6CLYWblUWSVOL1LkQtspjj/kOgk+iCLBQvp77si1oA6jDeuh6xzd0uPq9xqeG4Cs/+Ih7GByMcCpXFx8E3dTBUaBmn6cgy/Zg+LXaT/b32Af3zxn1NR90JcIHIwuR50mLA9jU8zIXnptU5KZ4XhQaTQX+pzoM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Fs2F2blayEwmcNXO8eonCGzUd7FxYIoRQC9g+5XSVg=;
 b=r3qeVSx9frAZ+m2b6JTAGfIU/t6nxRv4Bye5zh/SaLb7ZqLKeUNiORA+4HcjalBrsZchg5M22hN8najmgKDPsQJ8tnxxGgL3mknlkde93uONzH1UmysT+qD3xAAS2UH6gfqNzcERtBKGJ3PMTXj3EIMx4jGy68HUCSvKe/QP4+1CfmMeg9ePG4tmHsMOL1PLc9Up6CuSqfnY1ZACLIotIvBx09GP2wDj08fK0d3fM5dfog9Y86HSI3mD4o2V1rRyYxxI8cEdh4rDnsWxGPo3aRVBUp+Qu7HbJApKBKvM5yd2xLzt04lnSW581u3bZJlbMu0qhuxa+u6g+vogZpgZ7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 20:01:50 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 20:01:50 +0000
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
	Valentin Schneider <vschneid@redhat.com>
Cc: paulmck@kernel.org,
	rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH RFC] sched: Disable DL server if sysctl_sched_rt_runtime is -1
Date: Tue,  4 Mar 2025 15:01:47 -0500
Message-ID: <20250304200148.2211096-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:408:f9::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: 385f3299-234b-4eef-dcb7-08dd5b5766f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dMmnVLm8b/VqoqDyjKCXZEIRwXn21rVTZEVgjdSTop90wMOfxkHmYU8jG6sm?=
 =?us-ascii?Q?0nLCHPvdBxs/zEfDGAWdR6P/LlmqK1QOr+ijAYhSQ8tPa/sIOnJuPCE8zBxS?=
 =?us-ascii?Q?RKjjch1T98vzGPon5j5cZygKiY2dnRXMRtsG/aU0EBQ8IUN4THLmE14TQqip?=
 =?us-ascii?Q?LoogUcXeqhd2/PIXall4uQQXn2D5sQ9I3LwaySSbZcCzMl9nqpETCPpG5+VL?=
 =?us-ascii?Q?hPQAI4nZZSwsJT7JgUkBve+5hbQilAbq7RUm3mDETRH0mXamAwdbi+yow3Zz?=
 =?us-ascii?Q?B1uTC0sfU0olcNtRPPopKH+MVNBuhIohBydkWu4ENnD4RM466X1fmR2XTtUz?=
 =?us-ascii?Q?1vvc077qFgoQkMA0CJeMwtD87kA1j/PnZlV712fiiIhE7UxDcJEIZY3uNcIv?=
 =?us-ascii?Q?9O7am5HndsKX8V7R5AccLDAUlwtzMCZBEAvdNMMnrnDgqMEi43TrPo2rPKdz?=
 =?us-ascii?Q?dLuHmGDgJtbzJO3QbX2pgQ/MLa4OdP9iDO8xxGuCv4VJ4RY9hs+lu3NpWVKP?=
 =?us-ascii?Q?sV9dyL0/nRtDZYG7d0xgcjbjqzSYZtVPdrOqAhhoToXDbWqZ/TQaDnCHBKkK?=
 =?us-ascii?Q?WHJG9gNFycPyUpx8YZSK+cXeyz5yrU+mai/EqrD7TxXkcGwWPY7HtPOPYDFJ?=
 =?us-ascii?Q?k31SPuJFkc5xGyaQnKwoV+TNTk+ENlnR5T+WTF+KmLhOyrU9gwYJTv3tglbh?=
 =?us-ascii?Q?zok1ho7uWhDfKn9lmnyZjGRd8w+B8QNIuZaJk0b+1jrUrmKmQQNU+bhmxsEQ?=
 =?us-ascii?Q?khSYQAQk+IPmtn/os1PiajT2EaydvBrwWD8eSwjlVVN+Nf+zRu7z04JCh/8v?=
 =?us-ascii?Q?bwhtNy55CZx8B9WQQZ4yzPa9SHqscB3eM6PownkmJDh3O7g9ACFgoNE8jxNx?=
 =?us-ascii?Q?8rKL7/ZvmK9B9CsPfAggcPyD8GZJtYh3lA3rlpiqUouhgj3DlRpy2udCcw2D?=
 =?us-ascii?Q?BDTXCZRvmDnnG9cVSmIq+Q3WkpNliO2USwNo6wpjQmUmpBM7rjwkEu9a2Sxt?=
 =?us-ascii?Q?1eW6bhTSnSmpAj0MNBWIKglUXTlaCia947pgdirlizQwJwPA2VT3Hq25XZGh?=
 =?us-ascii?Q?iMRMbfN4cMsOj8s8jGy9jte1qLjeaIoAb1VZUMcYWpqj7xa/unguLnPUQs6O?=
 =?us-ascii?Q?8M2G71Jdi0HXJoxevjJOQqlHtq7f5B9SOiDzwz2nmmwJmvhekGpICB/GnueF?=
 =?us-ascii?Q?2RY1PzvTGPlnioDStrT9btq2jcEKvP8m6zc8JFSasmOSOVRDjEq0IvK2LsFW?=
 =?us-ascii?Q?7sdQEApXr2Qt4es961TQeN72VZV4/GHrlRIBS1vTdTIb1ID9eDCrTZXdA3xV?=
 =?us-ascii?Q?s6cg1lAGDUrK+n/hLFUyEoVh7i22EgKK2Mw3A4oRgahrc2p3c6vZF2MT2jKM?=
 =?us-ascii?Q?xalrf/RDZ/jogc2FZUJYTth12F6QwJtWjc1S/+oIvpYuja0fK2qNqbGof4HB?=
 =?us-ascii?Q?nU/gNahR4Jc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9EoxFiymoDgdf0nNmDAJ+tsMwaRrDXu1kxsKw96VcqdmVP2b0WwM9F8UX0cq?=
 =?us-ascii?Q?P6wZDshsyg381I984Ok7ab9g7hCppKQPM3mCPYls5nTVdfddNQscL7F/N1gs?=
 =?us-ascii?Q?3+gV/u6IZ0zbHr0RVvPYDwZnP3RbHHGTjX+JMGTCLW9a9eIoRzwn3T12YTG4?=
 =?us-ascii?Q?wE8kvqPZP1oyglQSOzhPpXgl6Ag+IVinPGO9UVgspbWi5gqchomdaMjrWQxS?=
 =?us-ascii?Q?oT7GXZju5GX6YeFlt1zYwltBn6voGRKu1IDNYAyVXG6lUhK+KJFFHCBG8/zN?=
 =?us-ascii?Q?6uXqFrgPrJ0/UFHLBSgzrcJm9EDyg2H3H9qK2MdPsMSidbiskn5LEVpFBf82?=
 =?us-ascii?Q?DKx5Og54dYYY41xeUyN8u3vPmltPdud+M1anDObTmqBegQyfSN1ykMWh1Bcs?=
 =?us-ascii?Q?4fq7bMrc6I/xPFOUHRz84BdBFERvg2Mt2oW20YfggeykCsNsroS1gnliUAbk?=
 =?us-ascii?Q?wuaXYt5BEsaI177RHMXsWgL0SSxx4oQUjZLcNtvUjBxAhYyqH0/GkdMU1NBS?=
 =?us-ascii?Q?rPqCr0CaTSLYKjouSqPHaPCkhvshHAgje/OiDyZ9Q/nfMToo+rqlxKCJR0cA?=
 =?us-ascii?Q?Umhq0rTNhh/sNaGqtoHP9yNvAnXaoOsEwdkuY8JkWKQNJTQjPBoD0EYrGVZZ?=
 =?us-ascii?Q?I/wqD8Yxu+sX18EPQqF/zMXo0zsMvVT+trYDz5dyFHDOBbaiOSFGqIiu6ajO?=
 =?us-ascii?Q?jH+BYWigpqKbVp3ubxFMxXh0PhyWZrlbKQAToJHoH7YR1oettX/rY3G9UBRF?=
 =?us-ascii?Q?ZQoZc5u9tmXavr/VaHaPD/ZnPByp9YDlhic/FB8zYhXM3oGvRRsFM8Fpdt+7?=
 =?us-ascii?Q?+jq+rQ/8OkhrNKrx50qNvY1YUKBN/8N5s9U1ERcSNwPq3xUCg2Pt6ea9wjeB?=
 =?us-ascii?Q?uhjNyux6mr1cagnpWhP8eLq3DsC0w+Ir68ILbJJr3KmLr3aQZ4QFMR6BSffA?=
 =?us-ascii?Q?xkW+m1zsdPjuYwjJ9BQ+5DUfwnjKHeBppnpeHZtGyUFuC2GNX0rlFJ2XuSm/?=
 =?us-ascii?Q?n3SgeBg60wJOWGbaBy/YpAkGykyFL8USMSUZpGFO8una4TzpHS2gZAKxVJu1?=
 =?us-ascii?Q?eJ3PZKbKFSmoq9SppJ32kwPVJ//7etK0n26ddn/b/kAsTILPaWrYFcW8VShc?=
 =?us-ascii?Q?KfWr1mSS8IXB9KB3SeHmPk6iqxvXpNE2YXl8RZTjTYYHpi3kvu/LASUvd+CB?=
 =?us-ascii?Q?0AzXB7AQkkS9+v89E9v4rRVF9VA+4Jx/d+ka6FnFOC9esCKAYQRf3NXB+JlM?=
 =?us-ascii?Q?HK/4mjTYmZypni7qSJDhCJdNtLG3uuz1Ydr4oQYH1fK7JypHJDbG2gBmX76D?=
 =?us-ascii?Q?185PsUDWT6y2nvcninYfR3uETf/Que2DhvxeHDCYSLyWOMDdY7CGAJTfZ8Gt?=
 =?us-ascii?Q?22VAvynk++uw8/YwyCizNzGdtVFJ9ZDQVxs4AyT5mTip0Opge7H++YoHeYHG?=
 =?us-ascii?Q?OpNLP4bv8dho63qTOziImWnh3aekqRJwO/TiLXP/pabA/HqaGKGZnWeGJWf4?=
 =?us-ascii?Q?8j5BoIxaFDS1o6iwf1Go6dk4RBqDR2+70aRI4JhKAtYotUmsqypC9eIvjqX8?=
 =?us-ascii?Q?4eTHtwXWEMP7lS6SigynAmJ2yRab2iXL7QEpq6bF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385f3299-234b-4eef-dcb7-08dd5b5766f7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 20:01:50.5720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/DSkf5MaIf/GCrA14Vr7A4oYsneR4eNJ1KS4i7n7FuN5d2f1eN3sP4gcmE1KJiK2C5D/OIv7I/WYL+80LMaSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437

Currently, RCU boost testing in rcutorture is broken because it relies on
having RT throttling disabled. This means the test will always pass (or
rarely fail). This occurs because recently, RT throttling was replaced
by DL server which boosts CFS tasks even when rcutorture tried to
disable throttling (see rcu_torture_disable_rt_throttle()).

Therefore this patch prevents DL server from starting when RC torture
sets the sysctl_sched_rt_runtime to -1.

With this patch, boosting in TREE09 fails more than 50% of boost attempts
making the test more useful.

Also add a check of this to task_non_contending() because otherwise it
throws a warning (in the case when DL server was already started before
rcutorture started).

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537790af..09c5139a3183 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -448,7 +448,7 @@ static void task_non_contending(struct sched_dl_entity *dl_se)
 	if (dl_entity_is_special(dl_se))
 		return;
 
-	WARN_ON(dl_se->dl_non_contending);
+	WARN_ON(dl_se->dl_non_contending && rt_bandwidth_enabled());
 
 	zerolag_time = dl_se->deadline -
 		 div64_long((dl_se->runtime * dl_se->dl_period),
@@ -1648,6 +1648,13 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
 
+	/*
+	 * Prevent dl_server from starting if RT bandwidth is not enabled.
+	 * This is used by test code to test RCU boosting.
+	 */
+	if (!rt_bandwidth_enabled())
+		return;
+
 	/*
 	 * XXX: the apply do not work fine at the init phase for the
 	 * fair server because things are not yet set. We need to improve
-- 
2.43.0

