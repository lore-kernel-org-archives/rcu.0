Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794433123;
	b=ujKFJ4AUtXYMvMMWk6dDyBDsZC+g/OV8u0hyrbG3946F5AFFUrrVvh1V/vD2TCKdjL8O
	 jn/Hsh03WuphLwYkcTtjwXNolc2EDT4XQDJ43nQ7TIWT8pwLPCKDVz+0Ewx6xEDfFb/xB
	 XZu9mmX4vOHSgEkdUUtpYRLFG7EOSSF5YFvsOe+eBf/YpTXou1f9/OTAjNs38jb66WHgr
	 S0GQ5YMPsywgXCJVx6cip1hoJsmQU00mocRg16W0voaHgxXcjwWENzefhtFefNx8Bb6Wz
	 AZxPtpGG/NbtwPg/4yO6LVx4GKtn6M6e1Petoisf8x1VT3FON6x5qtgkAqaMf03Ef5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433123;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yWmbs+bz3X6AZBRl6yI76d+MvOChUguanp/btk5aoMo=;
	b=XwUZHzKPhGnuX+D34ANN2Sry468dZlyZiDHQ46iF9l+nN86iM5tQe8m7eoT7tqo4DRXo
	 VAuxGoaRQdPL5gDxXklWXqvjQS9AaJ3bPCKW7nCMmBOJvd1G8pNj7QzAVmCjIHxceaFvJ
	 gd1VvcbXeDjOOIbthAM3e2qPqDgVbXuaPS1TWdeqH/ZsB7tZzThA+wzhCM0Mg80SScnop
	 mRdxxfD9GJkCHxtaRMuuy4rUe7anoJ9bV2aEGIfQmq4kVYdTYkAMXfO3Jnts3VxE53fF0
	 dD4LeMIglfrj8lX7X0/dadQrTfUhXQYJry/M25e2TCAbssfG7kuFWCd1KtzcnGYhULQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EOhBDZuy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.49
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47824606A326;
	Wed, 11 Nov 2026 21:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47824606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EOhBDZuy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5qbsRvS58D0GbbHINc9X2GkLRhSjFmxxxROp8Wme2PgDx/qj93dUDBEALJO0h++rVvbFymtMx3CveFMNA0IVVQe4//hH9HAVLczzYWCg5zvPccnS6P6TGfnPijpwxtWfpXDIWH/jYk2En4TTFXmroKbG+0RgIsopzVxz5Scjp9nsBNaFb5xrpZ244NC1mIRtfoLpYEV/H1Vlr0d4gTNdJM+Kbiz5S7h0fTaj8Y5DiVbzV6U5O5rIaD2sm5QEgjphZ5MWbPe7H+mEIO+8/1qphUcUzeDg4siMaVPuxV2wQe261ncUlozlh0wOa0N8qTVBsZD3K0XD9+z9yO4eiUYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWmbs+bz3X6AZBRl6yI76d+MvOChUguanp/btk5aoMo=;
 b=HXhGLZqyo3HLe7s1e/VlqrQlNaTuwFunF+5yVxbVPxJjVQzHAqIdAI+nT3bIhP9J/5VfsBUBLtxblUW+jdbpKwqisEQIfablK7Bv0stij0W6jL+UBXqGB8E6uhjKYv6G1oUjRk3tK5O3W+8CbrIniU3C3qv52pKlfn6VG/j0ewbf//b1owaf0vWOfEqHqby6QNbtpbzBBgk15zNKHiD97DO309+eNZx/9GYU9YfSjRqXPmnccmlI86FKvbFjCREsPmJL0w+L6hMwJRcGCna7kUQZ9r6osfuDRU8oQd5ttnmL274IvanEs3gLJ3Ef+wW2rk1JODpbHo46EVSZIrV84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWmbs+bz3X6AZBRl6yI76d+MvOChUguanp/btk5aoMo=;
 b=EOhBDZuyzZppbqOu+k+tPfl9lAZ/A4l4TcOIZVMv2xDiyQrDxqqjI+iqx4SHZWEyDvFKbcQMnDCKtH9vaMVZkAbkIuAlQ9/ACRohttauQX+nGcIb0gCttkZFlRTCFN9LUG76Wc/P5m4D+mEiECf5l4QSDEPeU9uIdZWG2c/j9B20nAXnfCjLmK+gY2Bil49lmVHACZPCi9iKRJhJhQsPiP6IacE+MmtdhtGKAbeOcNM310ALjDrtbPeyVJ4pP0vwiExnqJY7+OANqbEBH79mm+pKgKMXX/h41WHoWo4a2yEvpbcysrMoVJUgZe9XBSWFghq0mJMuMHbp8AwexFBMng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 21:38:35 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 21:38:35 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC 2/7] rcutorture: Stop disabling RT throttling for boost testing
Date: Wed, 11 Nov 2026 16:38:20 -0500
Message-ID: <20261111213826.2035045-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111213826.2035045-1-joelagnelf@nvidia.com>
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0372.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::17) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2a1e12-686a-4f51-fd41-08df403c23ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|261028144727099003|261026140227099003|261026121527099003|261022105027099003|11063799006|261021123027099003|56012099006|10067099003|22082099003|261009221227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mKCUzp5u+rznK0NMHzUjiQrav3GJBLurezfwuPl7z92aOMVTFGnEyLDIr6FhjYbAE6mwxUJuB7uEOnyujTqvBC9sO0pnF/Bov9jGBQE0Kkh82WBRVbRaGOz0lE6BVYLkN7v91pVzQSEDK0NNjwlOloZXN2/hDlFVphuvudpIf03rFDq9Tspwrwfr53lr9vD1yw/Uy4gf7bxPkH6tuVeNizTj+fH4gsEtz20ym064zTMQgkGlfd2DeIA+LjaCEPGY8gvppmC0uMpdaJ5C1oL6oUwf9wNZdllq4jsWtQD9X3ZMLoBIl/aCw668080e5/1CDg3aNWXXNkpE2XhurYFmD7KpJsMksWs1Q0Pi4q3AQjk1B12tJBw9eGsm3+rMjzBLifPRtobUDX7w4Bt8pfcguV3j+9O2T5X4TMB4OuvgmeE3WExDaQnh2MV14xJ9S7nTuQiZSwWxQfsDO/kkGOB3KeVxbIIsnYTtpTAByQBcPRTQ8wlr7C5yxksjqz+RZlBGV0I8yPaiyqHzM+QLbb5vKyg5LL8eGiw8+H+EjckPVXdESEdSyn3cGzi6/MOxbCTwN71iaJJdWPCQsGwLaEgXxYIr5DOOBZjLhv5vAiuO5t02/8qeLSK16Sjwq6pbfWpBkPyOq3ubaxs4Y/snvmNt5hRG/Of6JuhTGUeWJv4xxzo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(11063799006)(261021123027099003)(56012099006)(10067099003)(22082099003)(261009221227099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wxh3E+rRV7eH48Z3fS/tLe3sRd5SnM3Y/QctSjE/vtEWs6gEN8sihRf/dHPI?=
 =?us-ascii?Q?NRwhhVZ/1yoOszObvmyAcAtdC9p0DriWyxNXP0mzPr3SqL5Rn9UB4yutdpU7?=
 =?us-ascii?Q?0PaYjkhiZCG9uD1sKzR3x8N0JTxjOXDUeZrQuTu67KiEnUbKRxql6d5QAfDB?=
 =?us-ascii?Q?lVNjyrRiy+VoJNMXGgyrHLJPx0mBQIKmXfjn+TBdhj2aHSNL6PT2vLJ3rvks?=
 =?us-ascii?Q?pp6PzZ3gfcxhZA1CSOEaURNGNoabbik2UZMyhwVO2p8ZrrsUPHPbJfzPDfOJ?=
 =?us-ascii?Q?kkWv7EWnkIVegjgDCbwLj6H5D3ALeZSSEN/Z01TUvbB6PFfFt1ffbxVnkpUN?=
 =?us-ascii?Q?Z/LsBu3tyAPF0vHW857l5cPe2wIAL7wTnXhrkc/YuZ8dLynujjGEys0PKYfB?=
 =?us-ascii?Q?HGlXiKuH04XNZ766aryhPq0V6GpdlLePsA92cJnURhghRygoKNitiYCtTqpA?=
 =?us-ascii?Q?hXyPjyYaIjx1pbogeusnV/322gfgElhsaAZXyYwpXPkj7wM2+cC4jIDSq5QX?=
 =?us-ascii?Q?lxF08eH1Vjw81LmV9coUheoZ1CXd31ET1qbLWRbvoFwnAZd/ODqYuphRG6tW?=
 =?us-ascii?Q?CuFGaHaP+mWhNhz30WkyqVJooyuiQJDtjOOgMqPfIRMxlAGKG8vvGiwrjIvn?=
 =?us-ascii?Q?eduvbnnhpgv92zoD+a45QYUWjI9zPC6D67I8sn+xcen65NmbchZUP1MAccil?=
 =?us-ascii?Q?D/5KWhXefqvbFsgsl3lb3/cFMDjs3MvcRkQz0L9Ge4ehBC1cfFey/TAU6rWZ?=
 =?us-ascii?Q?fz9fQwQ5+oFlBY1WGcSqzgdYqOjVIY8TJqJ/WEfKq90XkKdGi5YFE2cu90V2?=
 =?us-ascii?Q?JQH5SyjEbXWkWlO9TzhzbfmtvnK/mUdHRe5Wh3X1rh1Mi/3+Tr5PokblnCAW?=
 =?us-ascii?Q?DurDuGJwNai3MogzdtLb4IPEKZEke/n0WpzHOuYuOmQQaGq8fK2+mxdUXSpl?=
 =?us-ascii?Q?o+/QXixzi37/lcKOxTIhTwMlDnSqlDr/4FASZTOCGcxBPTXxXTc7B+4xzmtW?=
 =?us-ascii?Q?zlxS1XZ+5mqNbtPsya4gC88QvrrskGaYI6AkU56y1RV+zpoktHzHoXHqS/Fh?=
 =?us-ascii?Q?XyOlKK6HPzuWfm2VzFAqYC9qDK+SVDeEJB3ZNi7FjnqAjja3zW67zC5y0NbJ?=
 =?us-ascii?Q?jHGZF47Gs1wCio+/qQvuS/jJ+mkAE8Qo78z8kJU622bGVnZ6jdj9JWLYb6JQ?=
 =?us-ascii?Q?glq+7C6J7zUBKdCPbQmf/M9W714xTe3wJWUX6/DB7P5GJfDfEMf0VIGgjAyo?=
 =?us-ascii?Q?iZuGGsxRHXm/NoCekz5AI7I33kchO5sUOoM+8B9Keq30u4VHyLDUCIDjpMwM?=
 =?us-ascii?Q?hVKPJZD/pz5CuSKghk9ciXAcIUGsZeaXTYpeTnn/Rbl+OqUTzAD++PtQicDn?=
 =?us-ascii?Q?0KqhJiHtLNeJwf+S7pZJRz0/5gZT6/DQzebh/FNtzb9bCsB7c+Gzoz7Zwtdx?=
 =?us-ascii?Q?1Tp6CahF7fCZc6Lo4AEWI6gNQLGZsePUWSSVMuE8Y5AxPbCNwETNWhyhpm09?=
 =?us-ascii?Q?YRemYXqid1z/Cnxc3DwbkBa8Upn/WfvGhHYi/85lASD+zNVJGMp3rQkPiFdF?=
 =?us-ascii?Q?+SEmNGdJa+Mw+r2VBqXjMfuPma+DT/Nci9OfrgfL968tdzPbL+xoGgp06Ouz?=
 =?us-ascii?Q?rJLMx+V8v21AWq0Usx+2yMOlrzt940uL13NxtV53VZJhC9Dc+2ymbuEync8n?=
 =?us-ascii?Q?lNxICn1qpqGCkuMfuQOgVCQ7EXLatwfse6PhqS/mpOjgReCLVoKuSxpgEaF7?=
 =?us-ascii?Q?TtCTF/QOrw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2a1e12-686a-4f51-fd41-08df403c23ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 21:38:35.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L55SunLvTdvmj7mG2MMgVujuuwus/o2u9A13zmmRJ5xaOVI1DKJCxmA9D8dSrK+gL0lfAV43JKbPEMUx8Mx3mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201

The CPU-hungry-reader boost test depends on RT throttling to bound the
CPU time an unboosted reader can obtain, so there is no longer any
reason to disable it.  Remove the code that does so, along with the
now-unneeded sched/sysctl.h include.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2152906a807e..ad980e9257dd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -43,7 +43,6 @@
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/debug.h>
-#include <linux/sched/sysctl.h>
 #include <linux/oom.h>
 #include <linux/tick.h>
 #include <linux/rcupdate_trace.h>
@@ -1349,32 +1348,6 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
  * rcu_node would wait for the first one's whole CPU burn.
  */
 
-static int old_rt_runtime = -1;
-
-static void rcu_torture_disable_rt_throttle(void)
-{
-	/*
-	 * Disable RT throttling so that rcutorture's boost threads don't get
-	 * throttled. Only possible if rcutorture is built-in otherwise the
-	 * user should manually do this by setting the sched_rt_period_us and
-	 * sched_rt_runtime sysctls.
-	 */
-	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime != -1)
-		return;
-
-	old_rt_runtime = sysctl_sched_rt_runtime;
-	sysctl_sched_rt_runtime = -1;
-}
-
-static void rcu_torture_enable_rt_throttle(void)
-{
-	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime == -1)
-		return;
-
-	sysctl_sched_rt_runtime = old_rt_runtime;
-	old_rt_runtime = -1;
-}
-
 struct rcu_torture_boost_reader {
 	struct completion done;
 	bool in_cs;	// Reader is inside its RCU read-side critical section.
@@ -3422,7 +3395,6 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
 	mutex_lock(&boost_mutex);
 	t = boost_tasks[cpu];
 	boost_tasks[cpu] = NULL;
-	rcu_torture_enable_rt_throttle();
 	mutex_unlock(&boost_mutex);
 
 	/* This must be outside of the mutex, otherwise deadlock! */
@@ -3460,7 +3432,6 @@ static int rcutorture_booster_init(unsigned int cpu)
 
 	/* Don't allow time recalculation while creating a new task. */
 	mutex_lock(&boost_mutex);
-	rcu_torture_disable_rt_throttle();
 	VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
 	boost_tasks[cpu] = kthread_run_on_cpu(rcu_torture_boost, NULL,
 					      cpu, "rcu_torture_boost_%u");
-- 
2.54.0

