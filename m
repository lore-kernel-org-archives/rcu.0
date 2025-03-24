Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A3B2641ED;
	Mon, 24 Mar 2025 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835735; cv=fail; b=X+re5nl3k0SpD1ByanJ8WAz6MGmHIF2SIspwzMOiDYQ0Rp/94T33y7WmEm6Fh+wT7WLk/GlXSzpkxun5reTrbXGmc0fRgTT85v15zwUcsBD7gg+Sge1O5BKBsdYj9XETfiyL/94v3NykJV0Kxk/JXkyzRoDGcDTjgGQ+JPn5Urc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835735; c=relaxed/simple;
	bh=5sNPr6B7gw2ZJeLq3gbXWYUpWMAZ/qUryfXlL0pjCd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ocs7YiOXE9kkDFuhCrFC5+SdFCDcVLq6vSFArnILHvj92F7Aq5CyCAgGeUN8FdhGnYlH2V5pGNL13jrgZQv+V9YLGVAAvpYSppaSzoZtmqspl2VTL4JkS7B7IDlRhJTdqFkJ3yagmFxCtAhCBx4BVp9KPyXWDbKzMwvDkD1I6YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pEVSJFBm; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pEVSJFBm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MR+amqCVnw3BgpMWgoLwMD7qb/S5S8Mx1c8iNIBRlP6dIVENFnsTSC5vl1g0aI4M02sgIzrNO16NAQI7aHq+3GduuCkcOfoSnggt34MYPgLJp27DC8EcVz0mJAEjlpkGxFaBmKDTRGru8XWnfja7sQnfYMFj/QSm3tPlsMEdWedGu0JLWE6xczhfHXYHUuunO44gCk7ynXzPjTWsx7I3m7zZ6JpNORbMaZOAi23/1ml1LstiKTw5hlQlrzXI/NdBTVxRRDTK0ns6tch1CPjH+agFg3Kzf3QTvDRj5k83mN1S27AHnOySbehR5kROPUpZukzxRn21IIpXJyRhgKivkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xGaF/7vMP9LBdKnBUf9531hTdCVZWmk0wz7XGueDRc=;
 b=uFvh+jF8pvXT2eA6aCe8QktCrIW3a+/nl3meOUpN7KgOsUmSkroSr+8FSY0fN0R8aF2PrX82L5dZ/JHwJDL1htGCbeXW9/r3t/t+kaVuMMpr6AkLSGQSjZtqhM+JjV4AnYQM0r91oydYrdkpVaSF3eoHjuDcqwuYUKhiqqsAE6IvlAM1c9YH6L4EUiN7vzg17rU1uLsel6SR/zKvdt17VPIR+o7hZQcbd0t1VCagaCbeZEustq4tBDz1sIi/45JFSXSSQDb4fg7qbwEUTp4Xg/9Jakjlau1cjXsSLWkXTp3bD5Vf+hgqwJ3RwQHy8sw28JqXhAkv2M9XoUCU6qAyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xGaF/7vMP9LBdKnBUf9531hTdCVZWmk0wz7XGueDRc=;
 b=pEVSJFBmCYvpA9At+4OCYjmmr/zVhGXsksbFYgG4OmsBKhLSCd6NOgrXm/JR+nq3pwJv1Qgelw4mRWU3RPq8MDsOaxOjq+NRBP1kN1DmWSluxoXmWNorEJc8wjq0XgpO3pZtgmFdO4lLQXvNwBfYWid6bFM3KUASmOEpMeInPDPAJs/ERuBVTF3tS/B+0e2QVIK9NHSNOzeeBLnZ9p/GLkA572h4IF9YsRARRplSO0R8lR/HiTPknQaSHQbzGBydJOQJmuhh4Rqvfg33z+gt8fWN5Degt2YrTdbTlLYo/iq2IT+tU7zAb3gvVJm9kH81pZN71L8nbx/h6wiUro6zPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:02:11 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 17:02:11 +0000
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
Subject: [PATCH 2/3] rcu: Add warning to ensure rcu_seq_done_exact() is working
Date: Mon, 24 Mar 2025 13:01:54 -0400
Message-ID: <20250324170156.469763-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324170156.469763-1-joelagnelf@nvidia.com>
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:408:ea::6) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: afee31f9-1865-42df-4aa0-08dd6af59e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QP350wDlGJrmgIDHiMWAUdEBj0dRY/cnC3rMjPgQLxNacctTR34+/oL2imNl?=
 =?us-ascii?Q?knXQ2jzeZiuDZENkznsUc6IU6OjBjqLl5QL7o1dheV5oOGaNLh18Sw7iEV8e?=
 =?us-ascii?Q?b11GE2Ag0p2rO0IxDXlLSqZKCoD4ejcT1RxSs+Z/r8OTTVccysav3GS6FuEa?=
 =?us-ascii?Q?JR2JmlUwWAna3ZhV0wjOzmkPvfxI4K20u0NpnQ2S9HmBUPmpJdUigRANdzjP?=
 =?us-ascii?Q?VlcoSzH6pvUHQgL7jxxcrc2pbxwLqdmdUphvoLR4nNIJ7OMD/HJHIaqoqlf/?=
 =?us-ascii?Q?4nsudWdqztknNpgJaOLdnY06/ndsYffwtm0FYtAgXyzcSDCmLErADsJf5AF0?=
 =?us-ascii?Q?X4medZWjEGhFcn7u1RZCFUM1J7W1AfC8JAxC/B8L+4GUC+sgYayxDiA86x7Q?=
 =?us-ascii?Q?YcW3ZCFQVWyGZAec2k8M1DnUmFPp2ZdZwynbaRAlZmztzUH8THZatdLoAbFJ?=
 =?us-ascii?Q?YKeApxIHPzTaFFWEN/aoLAyxp+J3WU9VntBGT3HgaeIw4gL3H1a1GHzEzJs3?=
 =?us-ascii?Q?QBq/LMUgFJwRX3iYOGVABoJdnR1j5POUIjgU86mgjU1ERbBplhqygZ5KRjDb?=
 =?us-ascii?Q?aAnt3Q5ok1QCrKzXp+14L0G4fOmUbkJFW8Yvk1iceLHqV7FtgnBMkrR8H0QI?=
 =?us-ascii?Q?JkZOZFbvcyIjv56xj50w39sJJn5YAuDKh+Z9W75dv3HOv0KEH5+wkD+4qDcb?=
 =?us-ascii?Q?b8Eb91FOaOborZsEaCBjltsJmCoYzQ9gGiuqBQXu8RoxK6nAf1THv7hvK1ku?=
 =?us-ascii?Q?hCYkxG5FpR+4R69htKEMsKJjYl2PIWYVMsNd0aL0UnUe+13o1azSKGR4q/X8?=
 =?us-ascii?Q?hTgcBAvcSyAwTosInj3N51x9TKiFjZ37bS1sQdqjJW2a/KpjzUlV5xPpK+HT?=
 =?us-ascii?Q?BEGqYsyxGirISW4F59fGpzVMEOViDsqbEGDAwXE4LgFOFPbJEhpO1ytY3O0V?=
 =?us-ascii?Q?umn+LhrgWi3VyqdAOFLhS4t0ea1xM5WXI5/xR2MAoT7MUlwvT6b9x10wRKWG?=
 =?us-ascii?Q?Q2VXv5lmtM3uQg1IpiAgug+crB8g8/Hfw/tO4Svkv5xtDVUkSxuSkyRoyip4?=
 =?us-ascii?Q?RBCpoU8IkhIJ/4o24C1A/DiJaJrbV6Dl3GnGApifQWyIqw2VrA4zhQDNlmTk?=
 =?us-ascii?Q?j6e7prG3syjuBdCW1wQpxeNMG+N4AMoYNdYTAIfDOMXkAougG8lv2RG7oS/+?=
 =?us-ascii?Q?+Bxhiv9qk3lOn5ElsVA+OcxhcBtDsb5nBQyADRdHlZRmpAuai13sPzGhKX4z?=
 =?us-ascii?Q?pvjWW+npujo9/UIsyOi9/SdfvrK+Wa/Xbq9KRanRgHGiMktIwQrGdWNcrYqH?=
 =?us-ascii?Q?oix4chvczYPlx94P50DhoIrkPZDwrica25WKy+3Yll8YaBnrvoUD6xooXwBg?=
 =?us-ascii?Q?S7YD9uiCnI9Q7gsQeO61ZxsVvBIW3qrQIl4CKu9Q6Qw/uJe0ciIDIckG7Ts1?=
 =?us-ascii?Q?I6oNfv1gsrU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvGilbn8tu988wg1SSOwUtcBiVAppLDb10E5c7kP2bbRfU0bmnhVsWgN5A8h?=
 =?us-ascii?Q?EehggdGzcQUM/KoskOY+UfE/KZet6oB/XlUYyACEynPSSCEbEv9vUZG1hELU?=
 =?us-ascii?Q?V3oPMjO0mnPEH0ZUkXiNTFlDx6ONmNQUrk4L6m6hRdXT9QvDlgjhDJNEpNA5?=
 =?us-ascii?Q?M2OyQHVAnAQ+XaJFm+FyiuIC0wYkAPDlYRvFAlsRlxL0QeJBK+0EPo1e+He5?=
 =?us-ascii?Q?/vqPlxpZaK3Tkd8xZT04XvDoJK81E/usK0HIvSmKfkFX9pi2dLvmODhD46+P?=
 =?us-ascii?Q?vGLaVO2DtlUPjOlY6O+opNz5XGMzc6i9VZQXkFW6wCUUp+PoBsVKil7Qk5Zq?=
 =?us-ascii?Q?peO7x72nUqa1tUgiSAQp7F4GlzufxpAwMit3r+Y9+eEq5pD56d6X51frNQOV?=
 =?us-ascii?Q?j9bK92ZjInWr8HHbE2Pt7wKnshefyDw522z7T7l9M2zc0GliBtnuPmu61WuI?=
 =?us-ascii?Q?RkmvVSWBw8ePN3vQBXCVIS5CuQ5yKeF5ra/DWcklHuFrApQ2+2mx+ZeAehmj?=
 =?us-ascii?Q?EtEF/I2v/Npyc/ZGCbyWDEvCy6lTah6EGHEYqtZpcGBI50k0t9oM/I12tjvk?=
 =?us-ascii?Q?xk/Ja/KbkC/rCmCcEwqfKW5iyQsNxlimuBSWt5OxgphaEUK1fCMZx0Du4iAe?=
 =?us-ascii?Q?b+jbjLgYt6bXykohthK0vGjRR+oWyRBfdgZHlFGR1ANzd5R/IZKZfAnyuNeK?=
 =?us-ascii?Q?BwHzcKT33vbm4nm/yRbD27jSYeuPTFISy2/RGVa8HoRqLOM1owxsKYkcHITO?=
 =?us-ascii?Q?Ndd6Wfwu4eShQFfQXcrt0PuU4W1OU+Hnd3YLRpGgd7HMgaJptaFunLdxYwTo?=
 =?us-ascii?Q?RofYEvSxei0aivmSe9oE/wfN5nSF6LvSIV5A7Bo6CeC1RYkvit8C+ppbbu+5?=
 =?us-ascii?Q?qyInpKHfxMXM7PbM9FGn/kKS34WIanK5Fx9KXhOFMJzIn1j/rbPaDz6uBA39?=
 =?us-ascii?Q?RF/Os0Om+ME6CucdJqTG6GKUMGdtBDjhbiZm8L89lbYSFZADgTkN2BYhkMBA?=
 =?us-ascii?Q?YRTeFkfnyAxwyuA5oi0FULJOx3RxgcMiU8BdK0F0FcSACXx6vmK8oFek3N1w?=
 =?us-ascii?Q?bZqhKvy6wlMxL5cu9htCcC7XPTl2aUwRJIBkNeNXTBvOXfZuLDkxiCPPDZ+B?=
 =?us-ascii?Q?itmJSuHgjBY2ThM+pESSqCzXlTyyZxmkCjbd/rbj3mbt0eepJYbjtXngpTdr?=
 =?us-ascii?Q?Xpd3ieqKgRnKuht8qH/fFuejVGi4xzLuxJ0Si8JK2jbL3TS7nzt9uasd3+tv?=
 =?us-ascii?Q?ojO9xb3x5e4nTvf/FyLZpxcHOvnjertoBdNN6f7TyZETuI81HMTM5A+MzT6z?=
 =?us-ascii?Q?iMWEf7Vkbpzxo2df7YjWzotgj6B2sTgPLV8eqjXUNQd8CKXqPRZM041Wr5ZV?=
 =?us-ascii?Q?c4YpwbSNeGz2J0SAY1TeE7q5N3TaNj5QSUpzer77Z6c0esNFSMyt/kLbeuxG?=
 =?us-ascii?Q?WoTq9tM9leZOFMiltyqYrpBCJVDp2Viy9ZjAwn8ALauaDUZA3fgPx3L8o9Jj?=
 =?us-ascii?Q?cUPQ3msvAQsOoJvN6x3QWcmI1q5nOmVG8Ljr4M4hOL4wwAxmWge3IaUxSu5D?=
 =?us-ascii?Q?ktvanUbePsE6ZSmCbr1rYX4Y5VHG0p3eM35Whfsc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afee31f9-1865-42df-4aa0-08dd6af59e29
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 17:02:11.0749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BazWKj1AVOJ4z9ZjBd6smvT2+Q4OBYXoqLIfYTAkyvSpuemXf7Toz20Y+M3WBtK35bgfs9fkqLiNdmUIM18DXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061

The previous patch improved the rcu_seq_done_exact() function by adding
a meaningful constant for the guardband.

Ensure that this is working for the future by a quick check during
rcu_gp_init().

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 659f83e71048..29ddbcbea25e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1798,6 +1798,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root();
 	bool start_new_poll;
+	unsigned long old_gp_seq;
 
 	WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	raw_spin_lock_irq_rcu_node(rnp);
@@ -1825,7 +1826,11 @@ static noinline_for_stack bool rcu_gp_init(void)
 	 */
 	start_new_poll = rcu_sr_normal_gp_init();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
+	old_gp_seq = rcu_state.gp_seq;
 	rcu_seq_start(&rcu_state.gp_seq);
+	/* Ensure that rcu_seq_done_exact() guardband doesn't give false positives. */
+	WARN_ON_ONCE(rcu_seq_done_exact(&old_gp_seq, rcu_seq_snap(&rcu_state.gp_seq)));
+
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
-- 
2.43.0

