Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77EE23B633;
	Sat,  5 Jul 2025 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751747980; cv=fail; b=gMlkZ32oq5Wxueu2TxTfbZuq/Kjt+B9WCqVGaQVpSGRmYCIzvnmED2S/EMKsLaFw0RehqGxEuJOLd01rpjA1k22v/RzJDaMvdOYRNOSnUxp/z9EokDlnf0NvfW4noHPPdbylpAAS/0Ex3L60xQfwpRX45sT9QZYpV0hqUmy7yuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751747980; c=relaxed/simple;
	bh=pTclOIsXO40mMxcqp02uf+8AypgB8yDrMMiydRAkLTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ubRKLaRi5PELmudzKpQ8nHS47EacGH0hDX39oqXpzGO2HKM7WJxCnHYHSgek9/gIrxg74jNwu6K5sUtyuKwzyihZWKioAkSBOyiyFo3MzqqY23wna2zI/LFnh9FxUOMFsHNQHYGxCp2VNyXsyJtxwt/kemTjU/X/R/GiYISwirk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l75ZAjaz; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l75ZAjaz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gk6aVOYMkjmx8kVW/OMYUiRG6ZJuKalFpt2yU8pReB/u86Kp1XnIrUND4Zdjqo++pijQAPBIxMV41IECi1Hy+ypKnjRkMkHI4K2QoOyZoDKqxg81o20WgJv9EQ5Mx+q/9HHiZzWzwsEdrtuRpy1wmgkwc4s9bpPmOPlAsBz7X424jxTJIZJF356IyCsbZQGb8SsKOjKuxD7OXUc05JmvaasRAmQ32FN2snGCYPwSGTXdR2OjeMQP10Au3rRy4eYdpaOzpn+ISRuhUtRDa8j8js+ZjcWk2m/xuIigDft45q+YqzhU8GsCVSL4Oj4xCN2u+yZ6Yp1JU/LjXu0mKFZZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc0jGLof8qetzfgyP7n7bCxyuAfSPmbdg860hBEYqfg=;
 b=rKUzy/5AglYdryEJm7x0/LD9FjWajJ04JZANHVrGUs9SanirpI8hUTVKBtKTQ0N5nzoSD8cVmGH3GMMFbwQoZTc9SxNggtqw6e38a3mc4h6u7/dBUIi4ZEJtAwsCfORyraQ2dYbz4QxPpE6o2PZgJQDfuH9Xzl25YxIr2Tc2uU47tKcBanFnVUUkpnEU5HlgDUjVSh2V6f1+w4jE/CImPF+ZY1eoEi+4UOYX6KK1xsrb4wo2MfH+IA+cNVPzh38nfaJRgUgnK7wwXYIe6maDYPW0O/bN9zzEhr0c63iVJ/ubstboKBvIAM408BqvcMuzq3zUpZZzTncDy4qus9dPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc0jGLof8qetzfgyP7n7bCxyuAfSPmbdg860hBEYqfg=;
 b=l75ZAjazPWreHiWL6DdZLg9pwVuA+aUE3BRhvu1Tmcnh0WV6unwcepfT2h3qEnw5wqQtgC3QYhXa+k5mxjWFX8G3qfIzvdJUfwnkQwV+FvG06bgchjsFwTsOO28LGF7e5QWkpdiPUHIgQuXP2jxk5PxjlVjO6qgk77jcxZYuLDAImLuOebttrLec4VpXo+ussFeDP7wRhhmkEcT2i1YiymA8/wqrU25s21PLfBYoZmRJJxJPLdr6i3GnGEvuLQ27CR0BIrebsqEO770TbFqcuEOI7ZoII94aczA6/2ILwA38lVp5k6Np/3/vGpvN2uJ82DZLI2NGIlyejPWQRts8Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Sat, 5 Jul
 2025 20:39:35 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Sat, 5 Jul 2025
 20:39:35 +0000
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
	Zqiang <qiang.zhang@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>
Cc: rcu@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH RFC 3/3] rcu: Remove redundant check for irq state during unlock
Date: Sat,  5 Jul 2025 16:39:17 -0400
Message-ID: <20250705203918.4149863-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250705203918.4149863-1-joelagnelf@nvidia.com>
References: <20250705203918.4149863-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:52f::35) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e96756-a79f-4505-e050-08ddbc040d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I8/pEn/3yyQT1UBu6pCXxSUkSPzH8dv6AR3zS3XV8YO2cAPs+L41LTJA14V7?=
 =?us-ascii?Q?1kJgvYlaHp4NqTqkQ9yzsC+xVuSXbcnZDYz+5j8QR+ASfdyvGT79XR/PwFlo?=
 =?us-ascii?Q?sO96eLteN2YW1IzAuCpvO0DFnNmHlMz6ecaliSuUdGER9h3ab8ml1YphyZcH?=
 =?us-ascii?Q?QP8zQ9XCan8/adzYs8PJkLGbdS/lepFzzFbElbWiVs6K2bnL6ERCp/C02u0E?=
 =?us-ascii?Q?RgIhhfyuy+GxsWYw71OhadZp02SecoIS+6q2QlRmTk21/HmK90NUnnDwxTLU?=
 =?us-ascii?Q?TdRVIeSbWWDemkrwm6AvkUO8PljYgA67afxLQ/xYPtX57+XIIEMlyI4yFUha?=
 =?us-ascii?Q?lb6Cu5yvfHFS3KHVKoXtml0GbsNgtLD1xuP7sFAa9osGwz1zWnYTgVxHAIXJ?=
 =?us-ascii?Q?K/DHcXOA5VnpJpPXCXtn+IUFJwg8R2LrNvU2aPdAYFTWM/9S+1mbDXQdkQ9o?=
 =?us-ascii?Q?VcnWvOjw/xWq6B4c1KWbIdwCdrjLGLgskG0eJNQ8OIuVa5SeAwV6H7BztkS/?=
 =?us-ascii?Q?MMhOTGEF3oBr9vudyMtbl2UtvYe9DQn9ISxmidMblxI6MpmqF/tOToW4MNOr?=
 =?us-ascii?Q?kw1K5EUEvD7pGBikkfYcbldfdmSvp7bg316nQgfKsaf7x2ssAYdGzcAop1Pu?=
 =?us-ascii?Q?nFToOycwBUdGIpYighkj7q5hqeqqLWA7MjZzekGeA0R8qkNJVCpOQjdJ3d8C?=
 =?us-ascii?Q?QQeTlDPfE5JOUrD4hcY/0X6V4+TnqxBJslUkPjzyLLsWldF0b2XQyvoY7K6w?=
 =?us-ascii?Q?rcJXRHkMVTBIrgT936re3tFYjgu0pT89GL1ojIJ+p4swjBy5dIZt7QZTMs1M?=
 =?us-ascii?Q?a44ugr9cG2OOHNipM+6uNg8JIqAGjlPDPZI4GvRki60nlKCe5bc7naM7TsWH?=
 =?us-ascii?Q?Yvo6mkT33sK2kGC8ukhuyh0kTTFfZa834BUvyKrSlmtCJ7B9kReU9adSZGoO?=
 =?us-ascii?Q?na8NNjgCRsnvo8FsHApSp5ac9ysX9LD43vwMRC75VtdDQgbH0u7oQFtHAXHS?=
 =?us-ascii?Q?ttJ6ZRrZ7GC9SAbfVKuXiTKEm+88j/cmsdRknfydnUTCyL8IihnJPUbF1ud7?=
 =?us-ascii?Q?6nLOkikpL+l2ucoLcrFeaT8x3vKPeqSp4iJjt+Y+QBTJgxXy9yC+kThTzB8k?=
 =?us-ascii?Q?wpkC3cWU0+mnp3IikbtGU0TVC2itWeRUDYXTmYJ+aMOZwr7jlQ96uMDcSrua?=
 =?us-ascii?Q?QO3+ID2W3yTYWNX9brRsjDos8lt+JhMZ43LkevRCQtCC/qKlsUNg28xSXdct?=
 =?us-ascii?Q?Z6leQDwIFJmWWMddoDXV0GKusDmpTvgGDqTi2KkStIhLhrc/QCGGcoh7Jh+j?=
 =?us-ascii?Q?AsQ14C7l1zUypO5vX1n9SysZw7h0kzBe05Arg1ta1XIyci8MQPILXdumUg0c?=
 =?us-ascii?Q?fwJeM8v82QKy9hzWe67h9ngbodJq1j1xvtzoc5eE1q5ZdcRQdQKvM8usPf8Q?=
 =?us-ascii?Q?o7LuXDo6U1vWQVI6HoiXoQ1qV+zCAIo1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RrRRQSjcUR2IiXhciR+qdtFz8KDqzsAYionORpptkO+7+A7SM9uwzhPJXZsE?=
 =?us-ascii?Q?wAsXmGnhOgscELlo+pEkpOofkA9uBocR3+dVrnvjoZzpzikOQYsq5z0f39i5?=
 =?us-ascii?Q?vSdmAXZD3smQmVgMyG4vhlPFl6rAXlaVeAwDOp4IzPwjCIpAXGj2tE+pDswf?=
 =?us-ascii?Q?4yOHrS199wLurc5VoAc7XpuLTIEHvyuSV3lavCQvOr0rZe63oq9gBYcQPrfH?=
 =?us-ascii?Q?YJWgKkMTEFVcyMSd1go43AKRxFg3ve+QXI5Impm1nRCZ1PaUDPYA2L6h/Vp5?=
 =?us-ascii?Q?11hkXbAKqFtSNy4rC3ajOaO/AbGPoNeeYBGzhA37T23P0a9dzdEuvb//dJTx?=
 =?us-ascii?Q?M95BSINvpOHrmrXr6P/nh5n7xplgmp82HLVP2N5PH2XYQVtOEFnq+IMqixCG?=
 =?us-ascii?Q?bF+pJ021fbmWEePNHzy2CukwJqIVUXwobaBdFgd6rEPySceI0+/9mG27fE26?=
 =?us-ascii?Q?HIZLwZtiskQg6lycaTvkKGS4tkI2QNEgBlVvBmVpEwxSCQ+5NTKY56Il71BG?=
 =?us-ascii?Q?wxa7HuArcVRlmEgFEdb2Puxhok0f360qEru0OPzDJ2U6s0/85+zVpwTCRFHc?=
 =?us-ascii?Q?ROPBURCyj+lsOgTiPmEjXsj18K54tfGeBx/aqzcnlcyNUxwledCGGnFe48dO?=
 =?us-ascii?Q?y0EbMbI8p3Y1mt7w0oZ9s+MTa+KMDttTiMwaQ/vV3NbcMF6rYp5JTf3uTEwB?=
 =?us-ascii?Q?btPdiQq3h5lj3XKkWgdP8NfmJcWA6LZ2pKYsw09cpRGo3Oyvkc9W3fof5m+C?=
 =?us-ascii?Q?o5jv4rYNFn97crptL9srsGn6s+hCW/WY5IXxp9BaLUmwslhEUQAM51XxW026?=
 =?us-ascii?Q?Xq9nhUM0WUsojVMjpVRv24iV/FS/j+tJQbBBXsG4SeYGcUtdrvmOUgJalILK?=
 =?us-ascii?Q?WXfKUA/yWi3OMRKOd/ZGv+GaGozkeR8DfWkBkOiZidF6xRpmARccNyrm3/kj?=
 =?us-ascii?Q?qmodZkUOZK6XoXq1IQPk4uggG4CzA7s5R2AS0j0MOGMQSZBMp1m9iO2aBbr+?=
 =?us-ascii?Q?UOh7UsgZSmQf55coh+GFRh8Uu0WG1GiOLJLRBfHjlqScRF47plaK4KbLxBx9?=
 =?us-ascii?Q?k7zqUVfArBqX2H9e5lIsC+NIWx1k+S1Xdu0UdHD5H6OnnfYgNl5JWlCxyLzG?=
 =?us-ascii?Q?6Np3Jz1Vf1pfVeg0ruq3nkOry2Pmb8s0S8ewKCGYGmkIgziFfIv0uPh2KA4Z?=
 =?us-ascii?Q?p4WGfCMg0xQMPq3KAny68S2t5HvkaUSIWowBWe9QzwCtkQRzs2TpdUIAabjb?=
 =?us-ascii?Q?QxgPS/Q58T6MGvdKfvr+j+NFP+uxsMJBxlMQOfnpXmlNN91o46UXZc2RiZvB?=
 =?us-ascii?Q?chqbaWGOpWD5G2j3bRl6aTtL5lTPzeRfBPPagJj9LOi70nqzX3QEC6uodQ2M?=
 =?us-ascii?Q?a0lD8sShmBvlN12vOgBZj7Lzv7m6WuQRb6Mj57Be0VTAcfI0+7P+ld+Zlcsv?=
 =?us-ascii?Q?Z13lmXywiAd65IQluSLXNj0c1pA1gAUz/fJHS1Ep64MPFxDDN51dbxG1UFMi?=
 =?us-ascii?Q?R6VTj4FSSnitmoyFKbOYwSAMYxRlaf/jWuhXXjMR5kmkwlKd+X+BJKeFFCd6?=
 =?us-ascii?Q?Bk7bNwp7D9w19GC2MiJg0jIrdSjakNbhU2+Dk/jZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e96756-a79f-4505-e050-08ddbc040d9a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 20:39:35.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2ybFZNy7TgkxNh4PiIn0nbRcOiWWpw+y29eh35yr08TFCYK8YhvDpCMFLX4aiY6yajLieON9OWyzz9avDYSQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

The check for irqs_were_disabled is redundant in
rcu_unlock_needs_exp_handling() as the caller already checks for this.
This includes the boost case as well. Just remove the redundant check.

This is a first win for the refactor of the needs_exp (formerly
expboost) condition into a new rcu_unlock_needs_exp_handling() function,
as the conditions became more easier to read.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 8504d95bb35b..112973ecebb8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -659,14 +659,12 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
  * @t: The task being checked
  * @rdp: The per-CPU RCU data
  * @rnp: The RCU node for this CPU
- * @irqs_were_disabled: Whether interrupts were disabled before rcu_read_unlock()
  *
  * Returns true if expedited processing of the rcu_read_unlock() is needed.
  */
 static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
 				      struct rcu_data *rdp,
-				      struct rcu_node *rnp,
-				      bool irqs_were_disabled)
+				      struct rcu_node *rnp)
 {
 	/*
 	 * Check if this task is blocking an expedited grace period.
@@ -692,7 +690,7 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
 	 * disturbing the system more. Check if either:
 	 * - This CPU has not yet reported a quiescent state, or
 	 * - This task was preempted within an RCU critical section
-	 * In either case, requird expedited handling for strict GP mode.
+	 * In either case, require expedited handling for strict GP mode.
 	 */
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
 	    ((rdp->grpmask & READ_ONCE(rnp->qsmask)) || t->rcu_blocked_node))
@@ -700,14 +698,14 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
 
 	/*
 	 * RCU priority boosting case: If a task is subject to RCU priority
-	 * boosting and exits an RCU read-side critical section with interrupts
-	 * disabled, we need expedited handling to ensure timely deboosting.
-	 * Without this, a low-priority task could incorrectly run at high
-	 * real-time priority for an extended period effecting real-time
-	 * responsiveness. This applies to all CONFIG_RCU_BOOST=y kernels,
-	 * not just PREEMPT_RT.
+	 * boosting and exits an RCU read-side critical section, we need
+	 * expedited handling to ensure timely deboosting. Without this,
+	 * a low-priority task could incorrectly run at high real-time
+	 * priority for an extended period effecting real-time
+	 * responsiveness. This applies to all RCU_BOOST=y kernels,
+	 * not just to PREEMPT_RT.
 	 */
-	if (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled && t->rcu_blocked_node)
+	if (IS_ENABLED(CONFIG_RCU_BOOST) && t->rcu_blocked_node)
 		return true;
 
 	return false;
@@ -736,7 +734,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
-		needs_exp = rcu_unlock_needs_exp_handling(t, rdp, rnp, irqs_were_disabled);
+		needs_exp = rcu_unlock_needs_exp_handling(t, rdp, rnp);
 	
 		// Need to defer quiescent state until everything is enabled.
 		if (use_softirq && (in_hardirq() || (needs_exp && !irqs_were_disabled))) {
-- 
2.43.0

