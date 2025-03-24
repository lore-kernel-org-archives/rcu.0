Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB083264607;
	Mon, 24 Mar 2025 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835737; cv=fail; b=UFHFvlYIgF4wbBfh4PoQB/y8pZzGZ3A6JoBuJIzWWgk7Xag3I8GCdB+2ES2jLRhp8mL4gE0Cpvn7RR4g6XNGVN0OcwF7DD02Pz6w0SDLH505vZJpw1Rd6ImSiRFHfz+oLT8F8oYxhA7fQfNLHi7h30qOVGEjr4bmKkA1DGJp+ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835737; c=relaxed/simple;
	bh=H95hVklH24R3FlSo9lsaTw7bvUyrzBIfRe7PeltmVOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJW0OqDiTEQDSeXI4RyOcATbQRuW7hJDqyTEPVcY2EZIsys9UFlMceWXNFY1K3Fz0lPHysnLOuUka8Eia3lHPFYsCRqWjbjMFno/RsLg5adva/rXSZKc3b3AxuP3YvnYUsrYGX3AgHXHF0Fg1rpDbogAWYQqPRxM1qnZpsT7CWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DQEtJzKn; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DQEtJzKn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iablArJBdW61qm9X+KNvMv6L1vJzYQBNCKAlAiwamEq5CXz5z7HqJk6l3uk+3048Vvt2/mAe+JY0cTiUkmi5V8pNMuGupZEFl4iaeQss/D/CxcnjWuTcfGizJPZk4B9R7pbRI8curIBUZ2ZBN+wmduK4Zb/0VxSlTXEQUOGpne7GWeYkZHJFLREg6m+XOnyEQMlOA4+PMA0l56xQCycfJYaLvRb+94qMmS4DJMoBrrguhVs4cfLf1XAc5cQFIQs+W59Ee7BddUH/mdh3APjcenlZgF1nBI63XFvq1tl6oXQGLCQp6YLeScSQc5dawJRL3HppmztBogeWsFkc9TOU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt3wdWcdnkChPtNzKKYPgjGTDNQrKKMKSwzqzP4j3v4=;
 b=pzG88EaWHnIpwx6BKd0ds/qja9I0STkuRXvrXcxAWfzUAAUi92LXFut4CiqGiZVYZ01TJD4BBMMKl1+Vi5K5KvAu8z0u5NPPVovwdfvJ4Dv3fgcS+jeF/WQJ8gDLLPgP0spMzae+eiYXJzciVWuzucgiSm5BaW/OD7RCTNF+X2M9wno0HOcaIKMBj4jZvhVX8cd9w4+BVOs1WndYxJD4kxY41hBikk666x/r49gDXpn4m2d4I37EE94abpwvLpKXJO9/ntjpRfuv76olrLbzdsfsgVrK49EgCfOAsNFF533z/n6r5dQ9NQug+otb6rTu7+lcEycb1JmXC0hQWQO7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt3wdWcdnkChPtNzKKYPgjGTDNQrKKMKSwzqzP4j3v4=;
 b=DQEtJzKnB+aeZzkFy3UacyIUTbBjddvycZCjo3rtVfkT0DS1CJhjFlxQsWko2zfRp49va984mrFaATTxsgHEsHep6S4BsraVVhkb7gZ/6jFlkFkXAYVdniXvuyxF0tNoGehBrXzBn5Jk4w9mH1HcSNhvwLLO0Ptl7psMCE5J6WBWT/3C+BSnLFPxsWK0g61QsNFKcA43Vdy9X/3TY8zbBnfyguLr2RNq1u2rlmyRznytZhtPhc+pdhvZyhUfTbEF5oyJrfkZBQXTpX0JHz6WCu4KtmQ3W3LV/paicegZI8Pu0ytHSjr8WAAyk/Vr+4XkeXmg6qeoxSIZ9lZbU/+ZZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:02:14 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 17:02:13 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org
Subject: [PATCH 3/3] rcu: Comment on the extraneous delta test on rcu_seq_done_exact()
Date: Mon, 24 Mar 2025 13:01:55 -0400
Message-ID: <20250324170156.469763-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324170156.469763-1-joelagnelf@nvidia.com>
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:208:23b::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: ea48f218-7135-4ee2-fb5c-08dd6af59f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xzkD2GDSk5QTIyEbyLE/V/XG6XpJGbCgYEgdDMP8y91zaiovmNkYCkW3JCD5?=
 =?us-ascii?Q?BmbFnu/W9dUnQvvN04qCiK/jmXNpdBfPsTTOZtVzVup1YDggOyqEkwRL0CtB?=
 =?us-ascii?Q?mvunemty3wbB291nrMOWFwWJ8ISm9wRLpq2y8XN368zXBEx2u+geYl1G+lOB?=
 =?us-ascii?Q?pUF87yGUOMym5rZrkzi0zQAOL+nKzFnjxII5GLefR0VjhZsdP4YYPnC61y0D?=
 =?us-ascii?Q?axrQ4LBOBGrPGlpvBOnVi9NA28WBuZ9F/tbLWoJI4ZDj0BgxUG8RX8JkGCB+?=
 =?us-ascii?Q?i13+HHh42uDgRDtjc0xgGd/2NQ5eKn7zocEmU9ILqAJgoTSoO3WpJOMmGFk2?=
 =?us-ascii?Q?/hO9tbfVI6hr3tsi3HKqpBoqNXTrPDg3qcA4KK4iORlu6zgA+ycBgFWR8AFj?=
 =?us-ascii?Q?CLLbqno6RYNReCSNoZ5TfPgsQCTPoJ+EGlCg13Z+IgBhjgPUheXvyBy4Vyvs?=
 =?us-ascii?Q?t+/tEVMrrOuORAC7TKYeHk0WatVOToDUibJ4AYfMX/jgGWMqscyWtDRAfLLE?=
 =?us-ascii?Q?FcpGIPwHeBXJ6A7Xg7kD0Z5Vj2YrBY/7rcCWu8cKvyJEZq2nMYMLbMVDKEvj?=
 =?us-ascii?Q?D4bYCAOe7SbtfO0szLP5x5g24zT87qqES5t2du0FKv0K551P0cttcin8VlTm?=
 =?us-ascii?Q?8mj+I/2Zo5tEM9gEJZtY6k5TUh9YGMDlIlTEBeWFQkyLRlzY1cbhXo9kKNt2?=
 =?us-ascii?Q?y57QaEZFTj8Wqi1+FdjNYJWjOyOpXnkxFTUjxxVnfk5MD7El1DLrHIKX6/HO?=
 =?us-ascii?Q?UKdErcRU0BhM2qz9YoIWPR60VFIUW5HJuPo2ffRKuynzUfV3eX1wMO/hh2uI?=
 =?us-ascii?Q?wpLTooKd1cV1ol4v4L2lxzVbOfj632t7Lmr0OuvPWDqwVpjOLaMMDRpQspXX?=
 =?us-ascii?Q?+AL8rrIgjNyJtRkDORWKQJCLXZ5y2USJRUKKO7dMFxKKzHMK/oJbrNxoMc00?=
 =?us-ascii?Q?/xsB4QJYpwrlQzQFe/e0JtI+D4pzWSzHi9j6nWT9BwZqrTq4pMWx+gJFX5Yf?=
 =?us-ascii?Q?VFYMJz7bM/GeXWt/WCUxD/B8tY+vJniPDLT1GxWboNBJX+Myd5/oswIc3cGx?=
 =?us-ascii?Q?ONHJXUAZB4WAgEDDc/6FkYTkFDF9qI2metGGzkWwDvKGsub1NgaNVmM7AYGY?=
 =?us-ascii?Q?gXhR/lmLYb1v9UIBiHodm3qIZvdCW3BcS6MSxpRVarhZtz4fqbiopDHAuNwx?=
 =?us-ascii?Q?vG/MxE81JHUw3A4z1qv35KsP3j7mWKB7WNUmiuNkkNSjl3GBTF6Jxo6fUX24?=
 =?us-ascii?Q?o6P1z/2qn1gzYu0d0euTNqF6Vo9y3rO4LESfLVZ2zS9rzfEv8PyBhQL6nLur?=
 =?us-ascii?Q?7ZoPc9ofi0XeW16uv9/8ub/K58dlIqDfX0cQo82tjDi6CSnjbcPwpTxoC5Ks?=
 =?us-ascii?Q?90vvHUh+sxyPUg4CHLyBf6Msdq4nC53iK2eQINKL1V8WlW75lnwClpDe7Y+H?=
 =?us-ascii?Q?lSOIUERHLVU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ebhRnE8jDlEKDft0p4qk3xVeiXxBk8uOgsFxNX1vW3mFBkJSTy5GqitgeN2p?=
 =?us-ascii?Q?t4+loRcNoVQ+oX/sKnylCVCUf20hJA10qCQBhHUxtacXYGHbIjIDtKWrWyhB?=
 =?us-ascii?Q?Y+LKR4g/2SXoBYZuCncNQY5POOZ9qOM2cbULAk0pLG4mAWP8WoegHU1f1U3/?=
 =?us-ascii?Q?ST/PPiur0tnn17x1yGIVIDEZM/wdPqMLlpVGVuIUc0tj0YUVXCNKoEzNdnp/?=
 =?us-ascii?Q?ezGu+NOek9Wh8/AiXoyPJR7xvUaQdhtK+QrynBcEsWqR3Cztc8G4MjVzEAIw?=
 =?us-ascii?Q?JzmDs0PapMXCXVuFnXKomBj2vfln8RMXOKJMvcKAuqB3C1A+qjYJowJ75jsk?=
 =?us-ascii?Q?idSeWspGlFx941GTy2/t2Im6jhyDsgtYON90c8oFiedplg23wUWNVqRgwPkV?=
 =?us-ascii?Q?mx3huBF7jxuFtMiS7odf5QXkCKMgfmNYXKh3GDuXL050amlLqE4X/7iSxkT/?=
 =?us-ascii?Q?XAk22Qm4E45zMwyN43xtYryT7amXXFLAHnGNtdOk+H1C6x17cDad4ndq1AzR?=
 =?us-ascii?Q?+WCRxOAGziJNlEt2j5/iEvYFJYNs2m9ewMlgKaLXKm/mMSv62GlzfU7FN3Iy?=
 =?us-ascii?Q?6exALxvvlyzDaRay9MmCiHNOxBiZnW9Odun8UmJuLYk+zeXFwfx7VIEhhRIL?=
 =?us-ascii?Q?m1N9Ikvta3q6neusHFkqdUTObgUr5i0h4FrIgnZD8D4E4YF8ncYrJ/Muk4IG?=
 =?us-ascii?Q?WYvZne4gZY5LyBLnjMZQeMussJvDezroi5lkl0R/hmIL/qGB8GaKjytxy+CH?=
 =?us-ascii?Q?IIfvPftUVRWoadkgYoBnRgTO5/NnCCPyYsy9rocSpLGoWxQ3mrmtPjm1haLE?=
 =?us-ascii?Q?2UEbyV5jw5VIiLTq4LNk/NT/WbOSVi9pXWA+dQVVuEcSHFmWf+asrBq2spnl?=
 =?us-ascii?Q?jo0mU5UvMv7uADyIAIRWBRn8i9vSZ2DQBOeDQB2BwiI54VHu4LxvXlUPKPyc?=
 =?us-ascii?Q?/FqKICICWWuADx5kwBL6qnltGNSGYxuPG3PS4u91uILzH1eapznv+7b2gH2w?=
 =?us-ascii?Q?VuLzxqjDk/10mRa7e0Iv81onR9PXN6xUJb1wYF5iQzITrGudtBRVpwfuSSqb?=
 =?us-ascii?Q?1CPr5ZlIJEogm1gLC/3bPn/reljwy5Ao4e0yHKCq1WOZm5OWsjdVMsK+TKkS?=
 =?us-ascii?Q?TM2fQLgNXf/eX+kLsULXP0JpafB1INYH8AmpYgc8PnyV7103UEylxMbhWmBX?=
 =?us-ascii?Q?/n2AymlGOsD+o2RMl6er838H/8XcUctLlbJLALtV1Fv9SmlvC8ZskE1m3MCY?=
 =?us-ascii?Q?0t9xgS5fI3LZa7AY3M+bc7ebqFJyCbnxk4ZN5WSOfNhnDz/P0vEjG+3/Tbog?=
 =?us-ascii?Q?Xm3IiIudQnwQleYQNI929vXg62Qb+ZyLFHooXTJQEtCR4gI20FHDvaL9G/L1?=
 =?us-ascii?Q?6vxZLVwfP0CLXnrjUxXZYAy4ZJMLUyj30YXlK6i/7I4dCGqxaxBjGEjuQqkW?=
 =?us-ascii?Q?MaV7HErZfCRPudiQjqrHjUoHYf9koHtOgPZEflVegknp77XEv1o88QaGUpPA?=
 =?us-ascii?Q?am1Tm90P+QXK/nH1qRbyLB8IMCJc7gw1ZN8c9otd8w/veVF32wSnpQ7h3p3n?=
 =?us-ascii?Q?uZRvSEr6JZPRmw+BR8KlPrJ0qyQySnwWE2KTAcox?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea48f218-7135-4ee2-fb5c-08dd6af59f66
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 17:02:13.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /psp3BxxPeRZnRf2Or/+/SGE0Zm3jfwlYA1MuXB5Axg08gK/EQ0YJoltm1lKWZ8FM8fMNeBOLDK8ro6ygzWmTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061

From: Frederic Weisbecker <frederic@kernel.org>

The numbers used in rcu_seq_done_exact() lack some explanation behind
their magic. Especially after the commit:

    85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")

which reported a subtle issue where a new GP sequence snapshot was taken
on the root node state while a grace period had already been started and
reflected on the global state sequence but not yet on the root node
sequence, making a polling user waiting on a wrong already started grace
period that would ignore freshly online CPUs.

The fix involved taking the snaphot on the global state sequence and
waiting on the root node sequence. And since a grace period is first
started on the global state and only afterward reflected on the root
node, a snapshot taken on the global state sequence might be two full
grace periods ahead of the root node as in the following example:

rnp->gp_seq = rcu_state.gp_seq = 0

    CPU 0                                           CPU 1
    -----                                           -----
    // rcu_state.gp_seq = 1
    rcu_seq_start(&rcu_state.gp_seq)
                                                    // snap = 8
                                                    snap = rcu_seq_snap(&rcu_state.gp_seq)
                                                    // Two full GP differences
                                                    rcu_seq_done_exact(&rnp->gp_seq, snap)
    // rnp->gp_seq = 1
    WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);

Add a comment about those expectations and to clarify the magic within
the relevant function.

Note that the issue arises mainly with the use of rcu_seq_done_exact()
which has a much tigher guardband (of 2 GPs) to ensure the false-negative
window of the API during wraparound is limited to just 2 GPs.
rcu_seq_done() does not have such strict requirements, however its large
false-negative window of ULONG_MAX/2 is not ideal for the polling API.
However, this also means care is needed to ensure the guardband is as
large as needed to avoid the example scenario describe above which a
warning added in an earlier patch does.

[ Comment wordsmithing by Joel ]

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 5e1ee570bb27..db63f330768c 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -160,6 +160,15 @@ static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)
  * Given a snapshot from rcu_seq_snap(), determine whether or not a
  * full update-side operation has occurred, but do not allow the
  * (ULONG_MAX / 2) safety-factor/guard-band.
+ *
+ * The token returned by get_state_synchronize_rcu_full() is based on
+ * rcu_state.gp_seq but it is tested in poll_state_synchronize_rcu_full()
+ * against the root rnp->gp_seq. Since rcu_seq_start() is first called
+ * on rcu_state.gp_seq and only later reflected on the root rnp->gp_seq,
+ * it is possible that rcu_seq_snap(rcu_state.gp_seq) returns 2 full grace
+ * periods ahead of the root rnp->gp_seq. To prevent false-positives with the
+ * full polling API that a wrap around instantly completed the GP, when nothing
+ * like that happened, adjust for the 2 GPs in the ULONG_CMP_LT().
  */
 static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
 {
-- 
2.43.0

