Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6613CAA3A;
	Tue, 26 May 2026 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835832; cv=fail; b=k28QAlgXJDF7DoJosEV/6Zez4ojECli169oLffa6z8zyrd2CILWKUlVDLu4Oe/pft9Ng/HSG117Wj1EenkhZlGHX98A1Ro398INQXdoEW0m15SagIgukqFIz+eJ/WXAJuTBKporUPFbPPcHzgCeSwjChb2Fj2taVrD/8Kxq8vXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835832; c=relaxed/simple;
	bh=5cUsGHCX47yjmjJTgFNT8J8NEigkjsQ6L/A95WK4c+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B66oEatdcP7wTHvaeaVTa04QXa26qrepNVUjkXiMfoGUEcY4CXqN1tNBFZZQIgmPVPb5uzw2RwAV+ZZ3YHWb7U9wG3UyPjaDMZX2sAKakOcc5BsV8m9lxk0swjpOEBZ7msl7+SzujO2Jyz+jOXbJ8fFUe2qCF/DIuxZaO2ddjfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f6iOtYza; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f6iOtYza"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnBbjlJwZ5hwvLe8Q6IEouya9AloJefJ5NS9wc1YJNgYw38AT2purr1O11GWQYRukSCF8T/kcTtBigmv5ERMmBs0wE1uWH0QTjhbAwVHrsnZwUZ82HeEDKL1v/ydEGlGSXguBtUosPB+BFxZXq2uzvJROxeyb8jvzvCCHpjFuTDft/yku4C7Tb9I1w29Bo27SdQWgR1GQ07d5dpzvSvHcZ6q0EAUfoYZlbIS98aEvszgb04cyQ4YQxD+yIHXDYfFpfj/Z/tAwkO77X7ck5GlaLewgr/XR7xMNHj7mbA7BJhyY9jbqQDqb6zEu2tM8xrm9CG6whHRt/t8GGuJYo2gTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCBFTBQm+wrHDEdstVzAFKfSRfgAapC0qWBeYstsKAE=;
 b=OfeIlhFNzL7i1WOzNWzL1dRJwcN/DR+gkfF4uiqIwGn6dn7EB1fHigM2t8c9EHcvnNoDYKGPyWKzyk6XcQDIKOcHg6Rt5oIz2x/YTaDNOundzmJ6/8I4H5aWK2FHioj+ldZmdwuHFTvoTV8jeQUwZd8i2bSJ3jAnoDOfFC07Mtfi2TMXbwm4Jfni6eY45hPYr4zh+g7U5ZER91KstVTHmB8K+pHKZEDtWWrokv0D8K0m53zN2HE6vxFt9M1dEBh6n8aTcl8paIeo95QBsK2D0G8leWIDrbn/5sOAJzY6wxGErUvtI5Q+vD18ahQp4FTWOOIKQyE6aImJM03P5dh2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCBFTBQm+wrHDEdstVzAFKfSRfgAapC0qWBeYstsKAE=;
 b=f6iOtYza9JQXGtp0EiaKAd6hB+vIcaa0jNloIMt+PYpa7x7uPXOK56JHG9uYaIQ3kcTft8TK1uHa6jiuqnDHGDbCL7O6xI+5BPNaThDCfXRKwDC0k6IiOVx83FoT5OznB3nEM0seaAWpwGngWDwpaE5dNYRwGz6v7cbItd/1tfHX2OyH7A2X6Xz1x//QkQzss0jM2BZUqvfjNilK2NgthLsHQCj717VP95f+fzcz6Yoe+9C7jOjsXcDd9j/ts736rmexN5DEENKL3MiH2BP/V2ZZ/mdcx9wSmjVEPc39v64GiYSUtm1nA9ozOxQ7D+C5AwxEom5gS/VHVjHpMIocPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 22:50:24 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 22:50:22 +0000
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
	rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v2 2/7] rcu: clear defer_qs_pending when notifying GP changes
Date: Tue, 26 May 2026 18:50:09 -0400
Message-Id: <20260526225014.314734-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526225014.314734-1-joelagnelf@nvidia.com>
References: <20260526225014.314734-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0009.namprd14.prod.outlook.com
 (2603:10b6:208:23e::14) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 6137c002-9db7-4cfb-9c49-08debb792b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|5023799004|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8tpMCnSSpS7wMIlVoYlP3zn6MKNi9s2kiOQlEkY76BUZ1JBSCTaCLHVwXxvUUpabGst8+6JyiT9U2SREiRFoOxA6e58CdBop4CTnX0b0IQyj/1c2HST/ROyOVEpmg/AAB1rT+uqvo6nTzpUQACa2N01ccpX30PbkfkmAoMLFDBXUI14J7MoOKRueRPLGyoEOAZCjNWVAKKQ4ECpRYQpUD04svPdUFJIuNEH749ckjZnKJd1XjeTxmTFp82x/iS6qea3wqtfi6v8l8drtc7qXGfKhhfk/jyUz+DBmdmzQwyOMoOoRZbTw7Nbk4Po7Bi4zDNyEnTpYCROJuhHeVi79KwRN1f5Zy0HNcu5Vq+141KxcmxjvR9TgsPsJXx7DBpBzabafQqsCoITAMIV87fpU+oDiA76kflhfV32w+DyayvEfh56rcDAKxGwoo3zv3eV+nbBPxx01UT+/e1d13oIw2Sqp4uNF/EyUVFF6qBL0on+eDLxkuaLcubmgNoogd1S7eyGmG4yJkkbE+pc3BggI3vJuiaR9Zs2KSpxjC4HJGwIip51VJ9Xyo6rvhfc1Xs6crQFUB6PfsYD3Ds+x4WlSJci9rXEHQb80uYMmR5lsRGRWLo1AXgFGBdqvDNJrh9n4ensjhT5kFj8SbxN3RalI1UAtWB2psAKtJoTdSkYUME6yrgpmdcAWXewYhLM7mMuZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(5023799004)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EUXaQ0B0rCInh7JjbMnIkEsVKE2juqN6UGq1nCe1dYRThTiLJr60SBcasDzv?=
 =?us-ascii?Q?YC1pMtYUivvRPwKQDSTu7k213z5rDOSJE8Hy9mfM6e98zd46dapmPO25d/bW?=
 =?us-ascii?Q?6UXn25uqIWhiIFrK7P0CVUzZl7NQaRRG7F+yQ36QhJITHr7gCc0y4GI/OYGo?=
 =?us-ascii?Q?lMCHBoBbbwSBb3ea8PdelQXu+Q0OiwmxPVxT9fr9i2MXC2l0UdMMannUZal+?=
 =?us-ascii?Q?RwdTeizfQo8Q0MGupQPa69Lh2kM+jnIkWyzh7gNntdqY7HushjtVfSg2pBRn?=
 =?us-ascii?Q?UcHfO9xsnAarusu/PoSfJxMr0sgr5mLUv7wypASlOIwQuXs/IU7bs1/4R3ga?=
 =?us-ascii?Q?B0PFc5G90xsioY9kCngVkk1Htup1UNEWGZ9vjMJMg2m97hdNisUhIe5sM8gY?=
 =?us-ascii?Q?xw/FodMYKedfgT9mBE95xM7q+zOjBNF8bs5OILeOnKN35VgSYj6zlQHWUqcr?=
 =?us-ascii?Q?Bmbem5lDkFEr0iONeMmb0cFwq9w9Lc5O76xkXrVMaN1iuVo5aV3f93FlQl93?=
 =?us-ascii?Q?HEuuWX94W8G+GUCl1Ahzsx4COPajo2nfGEvIJiyTrypRzDoKhmOaD9YqVWyJ?=
 =?us-ascii?Q?+WlesB3p+D296AvnoGvhYmt0sKHgNH2xWzM/E530oYyexE/Eg+DoilXkhZOA?=
 =?us-ascii?Q?NE31SLp+TH4vFUiZun0/ylKZHsllyKLjZCXnWWE9BQURx7vaFteVQhxkzNuM?=
 =?us-ascii?Q?i5fPgPlgwUWUNciDo1rsWtbCR1JdnwGpZRrl25fHHi0CRlng4Z9RyLdEsHYK?=
 =?us-ascii?Q?l8kytmBKaz93ldE5flbqORM0n+Ib8Kvzd4foDqefv/RSdbuHMnsKUitxiPXL?=
 =?us-ascii?Q?ooGCuM59zs2nbNjbQy2Q51V9A85Ds1Cm/pqoajA7Z4vGsGeQo75PKt0CMD0J?=
 =?us-ascii?Q?8WbuZ74YjLtTPcFQL/qA/l/AqGF/BwYHhePQwEQU+0TqbyfLkCsm0j/fNVi+?=
 =?us-ascii?Q?EGiirEp8kF3cn3qUUjnf6EHqN9e17NPrd5EKLYO9BBUQyv4DrLgrJF8lm+tR?=
 =?us-ascii?Q?Rub4xWBPn0GmxY+tkYtk3VAcy+4mU+UGYfa0r6PKsMy5ienfwDI9MbYHFL8d?=
 =?us-ascii?Q?deGjflAseEmBo2cBtA2RYIb+jdajO95XRnUT22PPR2U7If/r1XRfvyav/rvt?=
 =?us-ascii?Q?Sj/RedFnbICU3eGM+6KMXf1fjwvSVld/X6d8pSWq3qcozVYOL/z4D9qVtqv/?=
 =?us-ascii?Q?Y9KMW6cxoAnuwUMl0vmMW0yPYGlQDMlf1Fv81+NZBBUWdiz+MBBybEahkPhs?=
 =?us-ascii?Q?S/SThTsczPZeyyqWkA4VvGFxrYT5EImLjZ6w98hoeuPxcSWCiNgAvwj9Q4cN?=
 =?us-ascii?Q?Cd1lxs0yJLEEGl2OAPkOCR6b1qpNSecq7toyQi5kj2gzQyUMo8EOGLBrbswf?=
 =?us-ascii?Q?2l1hvz6tncZuPxK9pNJEv0l6hVqnNsfxlZ1KWSwpgPiWuAyBKbfddhWPgTeH?=
 =?us-ascii?Q?+QMxA5X1lCjvsS7YnlLQkR/PqPvmDjiV0V2XRmj4nMzooQQm47v3BX2LEHDw?=
 =?us-ascii?Q?+DJsDllxSGA+sFunbRLn8Jd4/3/AF0jOZGglvFblMxA6RkjhvhrP+2WhilTp?=
 =?us-ascii?Q?sBiBUJGX7t29lcGQ1z2FAV9vAaKdWiFF8V8DdSr/t9RWvY83XMsV9GwvfUtm?=
 =?us-ascii?Q?uyFgBTRZ/PTXVT39/NezxNtJ42nUEnaDIB20oqlJEfajQfPg85TWqHOuk0zL?=
 =?us-ascii?Q?Os7xByW0vqfm5IfR5ZebGtcHM0RGgBHo8VZaP3fxLhyDhWgPkFsfNLL7tfg1?=
 =?us-ascii?Q?lt3QZmjl7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6137c002-9db7-4cfb-9c49-08debb792b53
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 22:50:22.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ShX7RuzYv0fQ7PQoY4dIPXYBVUk7gMx5pFgYcw90OYThR4RunWMu5QISNTIGQbIAmp/BUrcTWqCPJul7TMWvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

Prior to this commit, defer_qs_pending was an unbalanced flag:
rcu_read_unlock_special() set it to PENDING whenever a deferred-QS
mechanism was scheduled, but the clear paths did not cover every
up-tree quiescent-state reporting site. In those cases the flag stays
PENDING after the QS is reported, and rcu_read_unlock_special()'s
pending-gate then silently rejects all future arming attempts.

A test patch confirms TREE03 can have get into the problematic stuck
state very quickly (< 5 minutes).

Clear the flag in __note_gp_changes(), right after the nothing-to-do
early return.  This is the natural per-CPU "GP transitioned, sync local
state" hook, called from the GP-kthread's rcu_gp_init()/rcu_gp_cleanup()
paths, and other GP advancement paths.

For dynticks-idle CPUs, they do not call __note_gp_changes(), but they
also do not arm new PENDING work (no readers running), and on wake-up,
note_gp_changes() is called before any new reader runs.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55df6d37145e..d0816468ffee 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1281,6 +1281,8 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (rdp->gp_seq == rnp->gp_seq)
 		return false; /* Nothing to do. */
 
+	rcu_defer_qs_clear(rdp);
+
 	/* Handle the ends of any preceding grace periods first. */
 	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
 	    unlikely(rdp->gpwrap)) {
-- 
2.34.1

