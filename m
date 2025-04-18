Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC222686B;
	Fri, 18 Apr 2025 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992679; cv=fail; b=C8B3/NZw185snB50AcxJRdKVB4R9Tw8lrVkJVU5+JLmAQjioItWieT56QmMHBEiL3iWMxrfc5lAm4dhHTZV9ag7zvXjt9zlPZB+s3rOUD4OuyXNjYChl0KKaJ9d6CI7jPlSCYgmyN/DWEkceLJm/oBVD+lDcTQtxoiLbNesR45A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992679; c=relaxed/simple;
	bh=TFvt4lNgzIOqBne/m6m5Ets6K2ZqY3VvpIH6wAwUOck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b/GNpZV5WKzFk6FH7ZiP8h+tV/e/iqqEVNbUI/lf1LnTI4HEv+LMN18hE1c4glfRCgHPaxia2HIJr5pFwe3OAxynGklhMY3Ni6EJt3Gai3n5z3nagqFj40DeMNugph7ZMr8/qKRp7hogGLOcDCQyseQpuXwmXUeHCD4F2WQUMiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ma1Ig4Yb; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ma1Ig4Yb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vX13S2K0i1BF3UnGdGzsPltlEQNOgZOkC4NDf2ABOnQl2lXyV+J3pbRsFsUCcxkk6w+QSn7mVzygqDe42KXx90O2x7VhY6sHnUvpabrLw5WkhNmOlC1xx1gR0kqT1b4+Prf56NzuVys59DDSDL2n/svUfZqp2MgOhI/2p5VZavM7xGxbu4X1Z/tHuOfZ7oY4z79PFV1tD0ff1mU+OQmpYOwHq/egk7QAOI25jrElMa9CM+1xejl36EV3lZQu/g6RlpNaRGfsKe7RqN2Z/XVwfotuxji2w/oJ3e3qz4RJWDFLzsNXdrNwmtXaa+G03xPZuPGGm5rE5nkowHQV9V2jIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKWuzpoAY0kNt4sTS2JmxVzpI51uWBXcd7bR88SVrwo=;
 b=BQC9kvcU0ailhnmjDheiGMA4iESFEq7YXD0jxB/WT49N4eCzEIhGdkys2paU7N9cz2WTLnnCYvnvUIB7t+YCMgl+DB9BETk3n0/YbhnWxa7Am51rpW4L9bTozXu+M4WxgOUM3eCdz7plXH8rL7M3MSosGRDOZJAO9JpJZausTfPJqWM1H5zifzJttNsikDuu60QtdPbwp0kSk3V9uo/B0yEz4n7ayb5FMc/YtVLAKLIEfpA6WWtuJPrtDH+cSYXpnCCCdP0oweEd/ZhsoSwHP+t4X+YKsKxf7r57hLEl7/LkkVqPbVrJUHKYWkip4S7MdSHtSiyekNnwaszSmG6U2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKWuzpoAY0kNt4sTS2JmxVzpI51uWBXcd7bR88SVrwo=;
 b=ma1Ig4YbO70M1hXCdI7Qw6AbfZxOMueYmS1h9QrWHir3JQEnz4oA5DqwjHtVrvMVORZN+FwW+yWovR+QxOjLJDQsuRspkUxDHsBvFW+MX8EbrRv9dw1saHjWe8fUB9t7B735R5BSoUV5g+N8633Me0ObBcIIyamWvjp1MkTg1Mpzv4HKUZmZF0hGyjiJvy1knj+eGzfVPYSqzsfEkM00M1bDeC6kleLPakaMtqtBVJXHWcDXz8Z2ZZmSlOn1PeAn2YlXAuIQPJ8TRFUaVsMf76D3ra271kZeNql/n1tL0LYKkp7XZRkyIprN34+gcwSeCEw2wWSjSo90HR/dPXlm9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:11:11 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:11:11 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 09/12] rcutorture: Check for ->up_read() without matching ->down_read()
Date: Fri, 18 Apr 2025 12:09:55 -0400
Message-ID: <20250418161005.2425391-24-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::11) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: ecce1608-d43d-4b9a-8c7a-08dd7e93a2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eYMHoUmgsMBb6/Q/o1l1s0xvar/k0fxiOBuiYdt2pIn79o5is1qbaQ1ESUqe?=
 =?us-ascii?Q?SzfbDzFKgV46too4KrkulWkkP8Dy0Uf6XE4MNyKj0hNxG1yqdaUlCPb24/FI?=
 =?us-ascii?Q?UxyAguhfNEDt8SUyj9vlhx2Hnj8tHGxywOKcawi2M/g4lJwhCR8xjwOifZwx?=
 =?us-ascii?Q?lR+oRQesz+vAlqy8/liWfAhnikGb/nGOlPnm2NaFMPEu50A3yxq7pYqx7LXR?=
 =?us-ascii?Q?vMO0D/p2mj5ddYBF3eAhnuVm/3EPbtaSWvJbNcHgpWTJHIicMzDxY2WJZFhy?=
 =?us-ascii?Q?Huy1J2FtGn830bvI8bZ/kU6/QWZxDuSi69n5BOVRXGMYO9AE/75m7qb/z/0z?=
 =?us-ascii?Q?j2jVKPwzJkWEO+MW5SqUiKq/yh59Iw0HkrcNAgAX1qZX33nODELOhCuXaAlh?=
 =?us-ascii?Q?K6cuvPn8ZYUM/tv7CChukpW6gFrH91xyGVaOczkWjsvUSuO1nYNNJHRvFOP4?=
 =?us-ascii?Q?Cc5ni4wymU+Lxq73+sEPO3xAvIRAOIkVdcWEH58fs84BmqiEzIbnDUuvUfjr?=
 =?us-ascii?Q?3Uq1yqQNcugKFZKUwR4aDt/sSg9eiK/1qIo4ToCJULEto1L++WxY/YWSQvfR?=
 =?us-ascii?Q?HNQEv/AQlqR3jmVZjwcErFJFxXqVzgXUiaoHzJAYpePIYtngoTrTX3eVTouV?=
 =?us-ascii?Q?xvRqCBdks66bNuvm++3y6Ke3ZzVNHmG2rZcdwj2XIPYtLDGm110dhMp5CXry?=
 =?us-ascii?Q?uYyHTrBEMgSq9raJV25ByvJsDWdYjVyiYhEqC6iv9Bk7S9U+Z9vLRozGlOa5?=
 =?us-ascii?Q?jF7pbqkg6v+hBrmufj+LmlHwz3+YJje6r+NcuFTlnllPaYRCuvanQCYQ0iIk?=
 =?us-ascii?Q?8Pj5R+PI+KUDQoi5ttUBjhzU/IYp6CsrRerFWD7kfpqRnzxhquLQV8Q5UCkj?=
 =?us-ascii?Q?pjW6KqgejXoS+vtjKr1E0uhihZB7GcYNbrqBXEwUBGRQxg+LMOQvaUG99rF1?=
 =?us-ascii?Q?GhicKdweG/TSCreFHIimXZii4rxYALuqeC1yjd6a/v8avfJw+4CTUjATf6HK?=
 =?us-ascii?Q?umddzk7g8i8FzzhpM+DEiV+3eCxIPOFbYxl/dTIsCElId7364s4Evz0Jhaoi?=
 =?us-ascii?Q?pNRGxEe8ewXfa8RUeDhrV6jFL5jSV2azAP1LDdg9gODUkrnKDNePDPa2qPYj?=
 =?us-ascii?Q?zCthMRth3xH7fgsRjRExYMPeYYe0TapVi9uSUZ9wnMauGphOD3phRG40XWQW?=
 =?us-ascii?Q?jyPMv3Xr5pDBY7KRi8YOQF64UEpLz6GF3dnfGy2DQjAgIVciePU3bnJH/XBD?=
 =?us-ascii?Q?n2VW2fl4jk9ll0kWwkGfGs8C3RI/8RYOAhoIYyscPs5jJqGxCgQ7pBCmcEPV?=
 =?us-ascii?Q?uMbogqr899PBvkrUZsZRkkW71+5orqzCQYGyrofvs8WHrm72TyxZr1tvFyTp?=
 =?us-ascii?Q?JxTW9bUWnOSQGvjuLVvAUYvVh3jyWsmjQRkOHL+XVontXMHGV4v9covn+cBc?=
 =?us-ascii?Q?xd3W9MqjvF4vQPWqZmUMbClFCyuLV/Tbna+tAQfJGx3MfPwL62QiGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q9Nh7RFEGlSCi/inU+tDFMfQq8VO5dsRzMg9BFAL2+0gHII6ytS7odrnOe9E?=
 =?us-ascii?Q?1giU2b9wQ/WDTSJA9GXVL0YBnZUGeYnxUnPQwfpQnM0Ta2pgVasllZSeaTVT?=
 =?us-ascii?Q?1nS/xblRr4kbYmo8xbT4QWWf+RimDFFS+txS3kgpyVwxiB+qf3Onz3hkymET?=
 =?us-ascii?Q?hTVspg0q0kTIzxZzTkaT5AlrZoqvJbs8p1a5IvyKheXCJOpNjL/eK65gJV8s?=
 =?us-ascii?Q?BOpIw7qtiThaSqnxp+QH0yXSn7Ukt78PjkSKbZSkTIEIrNHFCSR1RnsxQVIY?=
 =?us-ascii?Q?sn87eLTd8y4exOT0JYq9xwE9XByjwvULyMM0AWgUAobQ9PklbQK+zW8mNT/H?=
 =?us-ascii?Q?5qykX6iEevVdFjiEG4Zz7BM/v6/Y8GPuGC+/EJXSS4DrILjXDvz4S64xeUpa?=
 =?us-ascii?Q?tjgSJrjueKdsm4ZZwlTmd+O3rziHV5jbxrG+4MIh7KkPek9APGVl0xfllmln?=
 =?us-ascii?Q?KGEl/FdaQIkYTd0GHROSb/ImKPgHUV/nw4hrq6jNtg1zLn3a47xz855N9bk1?=
 =?us-ascii?Q?ScBUbtBfs1RBB81s742H5FdpPLueYydku2g6UbnsCyeydy7jvBbvbWyXQWsI?=
 =?us-ascii?Q?KKFmWVQ+Pzyc4gFJerRZGWfmucxv60T/p9N4MXVpRjzrSgHwvX4aosgvX1bb?=
 =?us-ascii?Q?H0QjnF28ehMWxHS2B50KplggVbI7p+VZwr35fQLCs6T7TRUy23tUZnDTBDmy?=
 =?us-ascii?Q?0se6pLcm15B7kcCnV5cR3LmlQR/HQ2RasFspJWbMMLOJJbeE9nXdbuR3Gziy?=
 =?us-ascii?Q?ggZkRMZs1KvqY97By8IPcan+xiDcBXx8+BvNp8nHhd9sKzphNituB8g5+nfU?=
 =?us-ascii?Q?pX/R+gxL7PFMo3QcBgqkacjWlCxAvkssecIbNB0RNnMnMBEk2zlq0ynvwtdZ?=
 =?us-ascii?Q?ejmt6kd2fi6BRghisIpYEEjDW699Y2e5UH0foW8jBqKitHhA/iM53hEz5BvG?=
 =?us-ascii?Q?yekjkm/GsYKxqeXaADq3mcde3Dal9EkI0O98OQ+KOBbFJ6TvSdGXSGw/8Uiu?=
 =?us-ascii?Q?K+61bN3GnjBt61tXZtdCLbxvonHVr5M7CMxK14w0GzC7DTGeYKfcuAVC8/Ex?=
 =?us-ascii?Q?53X7F0ydceu+ooSNxtSdBRLF6WT54UhayifVS8Q74MLwHVeCTkh7I27wzXAi?=
 =?us-ascii?Q?LjXThByvWgym1JmQUr6YjmRWLTp608kD7r0feeENJhwAI97keoQ/J1kxwwgN?=
 =?us-ascii?Q?E7rchqLFYEulO+j5fXI9JNXBwk2I09kWI+u9yLR+N8voTcWh/90OHG2/+5p+?=
 =?us-ascii?Q?UqRibuyufZbsBH2ZzQ1XfBOx62l5CFj8ji6LLsD/VqPX9arpzFMjPVVRn7Bi?=
 =?us-ascii?Q?gs7WEz6LLR3QPQ5CUf76OplC6AAUyuqJrSyI3dM9l2VnVDMD8VMNmu8I+RZF?=
 =?us-ascii?Q?G+scmz9IjcIv96FUrQQiy+MbpTRHJhlZaoGTOgtS+6xJR3FsPI4dbEyeizPH?=
 =?us-ascii?Q?85jGCQ13ALFVCeQ9U3uCx/I7HlahBapSC6rK5J27CFCp62Fs01KZEfSmuoYQ?=
 =?us-ascii?Q?BjC83JYNpn4Nwd0YBg9FMUG92asWOUCrbKIcMa6N9Mo0uCRYvSMcAzSxf0rX?=
 =?us-ascii?Q?rSUUNDuBUTZfRRpUrAU1ijzWMF96mmf/8sGFxJxo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecce1608-d43d-4b9a-8c7a-08dd7e93a2b7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:11:11.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZplGnjO0mm53bCefqktbwwJnqJ+bPBpzGetSBCpD+oe1qs71fxJuBWFh9ujrHZu+3oJybfcECZsesi3Cxrtcqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit creates counters in the rcu_torture_one_read_state_updown
structure that check for a call to ->up_read() that lacks a matching
call to ->down_read().

While in the area, add end-of-run cleanup code that prevents calls to
rcu_torture_updown_hrt() from happening after the test has moved on.  Yes,
the srcu_barrier() at the end of the test will wait for them, but this
could result in confusing states, statistics, and diagnostic information.
So explicitly wait for them before we get to the end-of-test output.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d2728e95a69b..079e164c85a1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2439,6 +2439,8 @@ struct rcu_torture_one_read_state_updown {
 	struct hrtimer rtorsu_hrt;
 	bool rtorsu_inuse;
 	unsigned long rtorsu_j;
+	unsigned long rtorsu_ndowns;
+	unsigned long rtorsu_nups;
 	struct torture_random_state rtorsu_trs;
 	struct rcu_torture_one_read_state rtorsu_rtors;
 };
@@ -2453,6 +2455,8 @@ static enum hrtimer_restart rcu_torture_updown_hrt(struct hrtimer *hrtp)
 
 	rtorsup = container_of(hrtp, struct rcu_torture_one_read_state_updown, rtorsu_hrt);
 	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
+	WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
+	rtorsup->rtorsu_nups++;
 	smp_store_release(&rtorsup->rtorsu_inuse, false);
 	return HRTIMER_NORESTART;
 }
@@ -2498,8 +2502,12 @@ static void rcu_torture_updown_cleanup(void)
 	for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
 		if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
 			continue;
-		if (!hrtimer_cancel(&rtorsup->rtorsu_hrt))
-			WARN_ON_ONCE(rtorsup->rtorsu_inuse);
+		if (hrtimer_cancel(&rtorsup->rtorsu_hrt) || WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
+			rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
+			WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
+			rtorsup->rtorsu_nups++;
+			smp_store_release(&rtorsup->rtorsu_inuse, false);
+		}
 
 	}
 	kfree(updownreaders);
@@ -2515,11 +2523,14 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 
 	init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
 	rawidx = cur_ops->down_read();
+	rtorsup->rtorsu_ndowns++;
 	idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
 	rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
 	rtorsup->rtorsu_rtors.rtrsp++;
 	if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1)) {
 		cur_ops->up_read(rawidx);
+		rtorsup->rtorsu_nups++;
+		WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
 		schedule_timeout_idle(HZ);
 		return;
 	}
-- 
2.43.0

