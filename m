Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00662C237E;
	Sat,  3 Jan 2026 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767478296; cv=fail; b=lubfNN922F7sRJqkovWlyIKjHWnfByLcez0VZql/U2x7NzJXD33RuyznBq9UAh8gvjEiP6/TlLFU/KeVbpKHjuPpEhWYgZ8JjbkasxxNWW+87FcGehvg4uDqWT6ELuQZRy0hAXR6qKgqq4W8vvEaA7FqpGEifmD5d66TWlNk+MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767478296; c=relaxed/simple;
	bh=xTehQ7GuI3yhV3lXA+bxF/hlCrGXPRVMlC4hNY3w+eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8+u8GXQ0kFDMWFwbs2QxxeTwfCdbden0AM0i2bh7XrKdwmoIRN3ZdtdYuYty56Rvh9urVvDx9w4BQF8KgvbVPoHCsJW9+jtvItXtP3etna1QClYIoqh5U5mHLuA/7P/HVNr7hI1as9RKkLWRDq41pq7dnDEK1uWc7HfdpaVnpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EygeGtIV; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EygeGtIV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuPNe50A2s3xu4TuJtpYcOyCrmwQiPBBjA4gx22prndvw0SaTgzMB9B8+Vcq7ncPG7NdFQ3uj6twnyKSi1iZYZHxoq4CSP/fXnDyO7UT84aGgqZdUJ4qmbNmGiVkdWwNG7RPuTYYGfmullsOVfiw6lg4wVdx5Q1Aq8q0NBzNDn5n457uLVtnBDiFt1pfzu0Fjs3hjQ++UE8gsLvnBztkaY1rp6bp+bT0maq7B+9oQM9HF6F9BeeXqQqvt819lR1A47icGBO7caOAayVRgyY0pCdZaT8kdt66LxfvG8yz2zfNJDAToTqaTQYHhrlG/eAB2C0cZaxc5p5U8hnaQH2apA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRvNGslWFvv7e5bnc78Bykn/Maqefz0pdrTlLj2nx6k=;
 b=u+tMK7Zn/ecvIEIdrdBo2d8RDlwPPqFf3x0CkdWudzASbag4XGzp7GlzbZfzbulA78hcd8q9+4Ykn7m3lCWOhI+F71ggO8643V1L1QXTGyjPYyE7FLlQb/1M5m5NK++J8TcLFtsZ9nyeEHctmAB9icNrVu+KawMIu0idusS1Miab+y1GZnLkld+MQljHDhtQQ/USOewx4xOrIXjOoN3LlK3O50fIp0h4IfAE7x9whYwOwRUq3ajvu+lt5n359JBp5KYPeGKqgpsOBTn9NwVvxdEBqrFVwADtTULzfWB6i9asQcnnsmvaSGqZ5cA7NVG5jUk1VCmr7Yh2Gtu7sjMpRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRvNGslWFvv7e5bnc78Bykn/Maqefz0pdrTlLj2nx6k=;
 b=EygeGtIV1hGEDALwnUtj85d5sGbLO2gO5XTbuquoo1OavYqP8aFDlOLfT9aJ2S2dAtpwWNyLXzzdDoxBuL0jiYF+Sw4bP1HAj0qoWuE8lSwUEBc1isfGh8KHywpFNnsajGwVHaEteRzwpZOEkKKyb0wvp6R1ZtceW3uFUQVaTQzClRCnHJeh7cm3h9+abFhyScmcHlg7zK78ANzwan9wZcC50CmvGHmfK88QlTRtcuJbqbd4WaUoX5e4+rOnQTs16rNG/V67IlrtlZg8n5nvfgxgCS4OUVA3VChylZw+lD4NUrj7qxM9KQJdQCciJx0LBZH2gF5AMo60xnBCUY/xwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 22:11:31 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 22:11:31 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 3/3] rcu/nocb: Extract nocb_bypass_needs_flush() to reduce duplication
Date: Sat,  3 Jan 2026 17:11:17 -0500
Message-Id: <20260103221117.521087-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103221117.521087-1-joelagnelf@nvidia.com>
References: <20260103221117.521087-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0301.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::6) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: a8333b73-2641-43d1-0b34-08de4b150c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FadFSkp8sDz+3Ed95x91hkmQtrB0a+hQJ8XxCs1oLFKb8P8UIhFiroVasvzs?=
 =?us-ascii?Q?FJz6yoMfvXmEx/cFnig9SDs545KW23jlY3Jlv3zP9U2JSwKqFR4+KRRGtN+B?=
 =?us-ascii?Q?C4dHvbfc7JyadZMeMOwfi9T4SY5BGB57qbu2e+xAb7QmyU7I8I1JFOVkef/5?=
 =?us-ascii?Q?5ljkgh5wOOZZtAbaHsxyxqnPRjEH2tmhytCMa1ub03AdTgkxfe16sqlDQ9dR?=
 =?us-ascii?Q?6mkVQmhufY4N0rFw27arI2yfc+I17Cerp9pLmd8rifWggVi8yRcNXteLZ4VL?=
 =?us-ascii?Q?pCOl4zp9CQ3EheAT/8Rn84MIxe+7ygpPGPLyW2KjoBFPgP08F0+ia4MGXfpg?=
 =?us-ascii?Q?7Z65m5HOggr+MLGsvjiqNX0dlS/10mmTO7rk2YMMtQcgUtI5hEGgiXOHTO0M?=
 =?us-ascii?Q?opn/6HvjlzRL5ldo8aaivsfrExn4G3QHw9IPy+runu3h08iidleKIxjbAJjt?=
 =?us-ascii?Q?rRPM0JJAoFGD6VjKFkLQ6KkB0GGQkelxSfw1EvEgQlHUcX+lQQ4bp4MdMW7c?=
 =?us-ascii?Q?s54YSsjP1arI8LU6750iWq1m20AXmVyzvi1c9sS+cp06x/ANf/O5ebUQwzJ2?=
 =?us-ascii?Q?CcTNsZTy2femYNAMA6944Wcux0fGBT0347a+NrI3YPBqr59PjTF5pX5tXKy3?=
 =?us-ascii?Q?npCUdu3lucbhwm96sAiwqCFws8QFr4r08Zp9EYC2GHds85F0nXexW/+dX3pN?=
 =?us-ascii?Q?iTRWxLNae4sQJJLagx+koLzb0K4SewTutx+x2K7LhWkhLz3ssYbLYKdfDwKs?=
 =?us-ascii?Q?Ijy/wkdP/sE2vUCKDc9acobmfgBC5sAZxaeYEaPh25FS23/Q29nXgckJDVA5?=
 =?us-ascii?Q?jXSur/97Q5pLHnskGB9npgFLxR11GcIgF7Rfd2pnrqdY60phViLC19gEZ3J9?=
 =?us-ascii?Q?r1qPq54o8OJ3Eu/2WAkyonHKQgETZCifIpttSOpG5fh388IEs+5TQujwfe72?=
 =?us-ascii?Q?8HvTPCL8mrf9H9aP7OD77pe5vu3zLDBgjbF1nkXYWOFKF7jY4868Zi6fpKLU?=
 =?us-ascii?Q?465WXVRfyOJpwcJHo50a9hXHOGWVNVCbvrC1a4pwBOl1EkeGzVyke14WMuQc?=
 =?us-ascii?Q?8XpA+GuuEEYLnVUc5U0LJ8UtFCUGmesfM9T3UWFi8dqr8FgN6b7sbxP4Iiq/?=
 =?us-ascii?Q?ch05x8NkiK/u5F9V0nLuvW1SJLhBhuc5kON182dANXfRGti2et0GkRci1YHj?=
 =?us-ascii?Q?Qn0I7DIDpirbTcyEfDWa3nWaPAr311nHsbZZF1ADAbLfIrrtvYMs8vSxIY40?=
 =?us-ascii?Q?3W2+qLfXz8qtGnoMw+zc64YsB6rf+AsGmPwQjtAbUExmrSIbGvTlypMqACB3?=
 =?us-ascii?Q?GCSIlts9eigJJVggY1ckNTLiioSp/oNa+36uUoI4Ot53LlTSrS/ZaiYZvZiU?=
 =?us-ascii?Q?FqX/ritKBz010smv4uozhptcT+64acJAyNOYuOU9OCIlw5EUi50JbpPKi8KD?=
 =?us-ascii?Q?+1VbMdRKYM6RD7TXlQllh0FeWwb6ASxh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?19Rj9g4taA5c/2hmGb1xyxtlutcyCDg1kg2rK+fFD4erK6eko/i0ARG8bQeh?=
 =?us-ascii?Q?rPWMmsz0Lr0TXdRfqmUDaIhtvPQZQD2ISMnzo65IlQG1qH7mWTLKh5VHTFWF?=
 =?us-ascii?Q?fIIg0jB4vqw1a/EuUsB6P3sDwgplPRtFXiUQag+9rD2x/k6abpXcQFNgziEy?=
 =?us-ascii?Q?8JauJmPNL5mzEhq4/O608j2niwWTshLENDotcRZogoH5g16KH2orCmsq4VrR?=
 =?us-ascii?Q?E6sMrIBpABYzc9GgVkH2Y/MiKdB/BqSZOx8233Boxiup+ccr6YfKpl5s7xRc?=
 =?us-ascii?Q?Bk5JxOmj0OLaDa0HvQj6slURkrsvzgSXw8XCMv6JlP3mZO62C7/xUQUCiy1J?=
 =?us-ascii?Q?kllxY+yYEHZiURTl6Sfop5Jf6wUZi7m1E7cquKkazTsLRZ046Sx0rgNTvfxp?=
 =?us-ascii?Q?i4wlFHrk5GSFjgsHkbd5IKMQRBqY6IliVM8tFJna9V3w54mL6iMo+Jk4L01N?=
 =?us-ascii?Q?BLprqB+E4XC5H+DKj3BVEpl0yOdFWNPbGk6eTjTw9Yi7PkPM4f3zMeW+o+rX?=
 =?us-ascii?Q?73vmIVB/ha4CIZUtqOSNyVz48z4LeL7dRrPM1RW6kxTPDNHrTrb3LQZj1w7g?=
 =?us-ascii?Q?J0mndv1AO/4+R/FuqIYAREMbXpv0blnAM1asOHBG2fQXM3CpjSM5vslIM45F?=
 =?us-ascii?Q?uRKiibL+ngcVzE4Hgln4dyeBjXGRJR3ge0wx1G3AKuEvwj4kNkO56THpOvFo?=
 =?us-ascii?Q?NEwI52xPV2tg3dJFspNKkQh7pGEHwMbfbUKvAB4K1006xQgIz8n/1ynW0F3Z?=
 =?us-ascii?Q?T31o1NTPCrtcofn7eYr7aSKEPpE6K0WV9k4m81dAV02QCedhFvgK3j3vqah/?=
 =?us-ascii?Q?4QPPB8GI7JCB19jONqRovhk3jRJep0UDSajFiPtMPGArTf56333g5WyEaufw?=
 =?us-ascii?Q?tkNBwnk9WJ+B4YZPv2KMz3iTodnEoblTRLsHIcp4xd8Z/E7tD0DfsB+uNvVm?=
 =?us-ascii?Q?1+IayRSeHAESlb4tpZy3LPdJAXwvg6L23j66NmHpHb7kcjrSrU2FH8FRsPs6?=
 =?us-ascii?Q?4VkC90hgasTLo+AZJ57f3s7AFneYEeEgTNWItK2HyWy8PL3LdJcAHFlvsldh?=
 =?us-ascii?Q?IlgosuzwGOt5TpsGTOzDQuHt+WMMgB6NKyAUEiZO/mg9qW/fm3hULi/bAJHj?=
 =?us-ascii?Q?6O8MfrTUSgMgYKsEHnS5LFTjzVp75E0tlbRLwUB11zZf2my29bb6nHMIOBHc?=
 =?us-ascii?Q?ymUn4bGgoNCXKcy0o+ZZt9q8HwFNZNZtx7mvwu1V09XYvWyuDHnFP65s6bFl?=
 =?us-ascii?Q?PQAeRipmm4O86hQ9wdCIkjkxkIT9/+L3BRJChlJkGWEL+R7kLMVOCFwhT1C+?=
 =?us-ascii?Q?Jzeqlqw4q3fs8zuLUZIJ5EwmgBpa7NZVPNdJRQbQrjaEOGLiGUEzwM4K1ICa?=
 =?us-ascii?Q?wnqFXGhm1aU6TbRY/cGFVxflwhKNhsMbTr2eyK4xugzlW7kOvVPRgk6BDmT8?=
 =?us-ascii?Q?9TGm8tGs9HeklINN/XFVNOCdvcoefYUD/7HXkyBmDbuioEE8ybaUg6LihRxp?=
 =?us-ascii?Q?uA3o5np4amky9ZL0qTfJYiwGSaU5ygIez+WIqXcDSQiVIpVzeQVhtItjrAg7?=
 =?us-ascii?Q?ydEGQxVD/9lSle518053Y/AjlfPa3vP/Y7/9GYecXoZdOdADZK1ngzGgbIHk?=
 =?us-ascii?Q?OFcs7dLNGzGdCkEfMmyyKWO7XELQHz2wc9fVm5j87JZbDTTWeu1wqGD7DcyZ?=
 =?us-ascii?Q?jxR0xPuRI8KHtfJL5Oh+vRwuakyc6xLikJtWI5116R401J2hBUxVYAoiVBG0?=
 =?us-ascii?Q?y30GrBkxjg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8333b73-2641-43d1-0b34-08de4b150c7c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 22:11:30.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Q91DFA6QsRoFM39jKixvN2mKDSqBg5BG9N/eLhBmPpq98m9O7wwhVab7SuYTBo+rdT6W04DXiqsOAOTAsDn0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242

The bypass flush decision logic is duplicated in rcu_nocb_try_bypass()
and nocb_gp_wait() with similar conditions.

This commit therefore extracts the functionality into a common helper
function nocb_bypass_needs_flush() improving the code readability.

A flush_faster parameter is added to controlling the flushing thresholds
and timeouts. This design was in the original commit d1b222c6be1f
("rcu/nocb: Add bypass callback queueing") to avoid having the GP
kthread aggressively flush the bypass queue.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 51 ++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 946795ddf7d1..6835e5131187 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -378,6 +378,38 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
 	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false));
 }
 
+/*
+ * Determine if the bypass queue needs to be flushed based on time and size.
+ * For lazy-only bypass queues, use the lazy flush timeout; otherwise flush
+ * based on jiffy advancement. The flush_faster controls flush aggressiveness.
+ */
+static bool nocb_bypass_needs_flush(struct rcu_data *rdp, long bypass_ncbs,
+				    long lazy_ncbs, unsigned long j,
+				    bool flush_faster)
+{
+	bool bypass_is_lazy;
+	unsigned long bypass_first;
+	unsigned long flush_timeout;
+	long qhimark_thresh;
+
+	if (!bypass_ncbs)
+		return false;
+
+	qhimark_thresh = flush_faster ? qhimark : 2 * qhimark;
+	if (bypass_ncbs >= qhimark_thresh)
+		return true;
+
+	bypass_first = READ_ONCE(rdp->nocb_bypass_first);
+	bypass_is_lazy = (bypass_ncbs == lazy_ncbs);
+
+	if (bypass_is_lazy)
+		flush_timeout = rcu_get_jiffies_lazy_flush();
+	else
+		flush_timeout = flush_faster ? 0 : 1;
+
+	return time_after(j, bypass_first + flush_timeout);
+}
+
 /*
  * See whether it is appropriate to use the ->nocb_bypass list in order
  * to control contention on ->nocb_lock.  A limited number of direct
@@ -404,7 +436,8 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	unsigned long cur_gp_seq;
 	unsigned long j = jiffies;
 	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
-	bool bypass_is_lazy = (ncbs == READ_ONCE(rdp->lazy_len));
+	long lazy_len = READ_ONCE(rdp->lazy_len);
+	bool bypass_is_lazy = (ncbs == lazy_len);
 
 	lockdep_assert_irqs_disabled();
 
@@ -456,10 +489,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 
 	// If ->nocb_bypass has been used too long or is too full,
 	// flush ->nocb_bypass to ->cblist.
-	if ((ncbs && !bypass_is_lazy && j != READ_ONCE(rdp->nocb_bypass_first)) ||
-	    (ncbs &&  bypass_is_lazy &&
-	     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + rcu_get_jiffies_lazy_flush()))) ||
-	    ncbs >= qhimark) {
+	if (nocb_bypass_needs_flush(rdp, ncbs, lazy_len, j, true)) {
 		rcu_nocb_lock(rdp);
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 
@@ -699,15 +729,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		lazy_ncbs = READ_ONCE(rdp->lazy_len);
 
-		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
-		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + rcu_get_jiffies_lazy_flush()) ||
-		     bypass_ncbs > 2 * qhimark)) {
-			flush_bypass = true;
-		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
-		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
-		     bypass_ncbs > 2 * qhimark)) {
-			flush_bypass = true;
-		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
+		flush_bypass = nocb_bypass_needs_flush(rdp, bypass_ncbs, lazy_ncbs, j, false);
+		if (!flush_bypass && !bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
 			rdp->nocb_gp_wake_attempt = false;
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue; /* No callbacks here, try next. */
-- 
2.34.1

