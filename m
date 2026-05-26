Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E338655A;
	Tue, 26 May 2026 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835830; cv=fail; b=QU0smUIUJE2HUvquPcbQs0q7V0SSIM2fwn5qUAJYIqHrOCkaZWTJE9rX9RFA/+lxy3rsykQHHxQFfpZTJEiLOd+IqZV2wlga+A8X3P1G7xiawEHattig6A0WMzRd64IuqpdSWyonnOsOlvtLSK0ygz0Bsx2RrF6rqMKX8ICAqPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835830; c=relaxed/simple;
	bh=sNzdxytoBechEvKKJnuMx+G/XO/jUlvbQQkcFNUwhLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPQinm4oWGQxOEwAsEk+AY16x3UxQFQnp2ZbU9+mpjxQXdLDLx3c9hDcqZkaKrGQyccuJJdCMduWcan6t4Igtj5fh1SkXvIXoEIXpHbl4TD/OLJ0AIhxef+hNH9SrvE5wUISUQgQ/y2B/vp4jN8SH+T78PNZFfeaZLgKLbIWbck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V8SSFVhy; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8SSFVhy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTiS68pFGD/PsYtpByOSrOatNf26TaHEAooyenYLqLl0sL6zOmGbPOqt7QipIsGyMLV1fbRbgI7b2G+hxKDo+LtlFWfWayALRF6UI8KjnbX0OxRP8C5LV5XFmk2h3CQyjiZLICd7vQdd+GNSLrVEZCqcv3bBckGGRAk9eaOEi3VGb9H83KYvjqbdZDXL+9C+gvDywglATg9w7kuE8GhoerBuXDb+mop/q5teHJk/KZ55nWpB5Xc861qwZJc1WcMRsSjj+rm+lCvd0BIsPgzr/OhZOz9axEIVge0m7Z6vRwySt2lOzVoR791fg9oLJObAgHLmxmKbSPj8MF9458RnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1YouM4wpBFrfULDHc0G/kHx5Tabrcs9Hjji7ybst4o=;
 b=EI4S+Lew2u6r+Tqyl+eqMHjQpP2pSEMpo038STeJREz7FzODSQgVFLYYlIN1bYpRvL4JL2qq5jXAzumzW6McDCawLjo/7FAOPoP/C0NGmyzDReRst1mh/5JANgPuZGtyEk3qySaUn11+9r3udoHAxaCGuVwUrK+H6/+ZP6TtTmSM724nB1+xRM2882nFdUt/V3yLfT+VYnNpEslZYsnLB0FtWVViFgKHQYXGaqB6qW90xIKP22x+D9aCGm5DR68xe2yUX74B9MizrMVRSJj3FQ8UGg/sl0m5+EaTciKZbG8X0IZLXurBXbHn+wktKlNT2bmeejTi380eZSxAg1O62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1YouM4wpBFrfULDHc0G/kHx5Tabrcs9Hjji7ybst4o=;
 b=V8SSFVhyUymBvxowZT21uozv49D1Zt82CeDWgEvU1wyCxrkTEULmv6pxZ5uYYc9+sEXYj/rtD8PAHLVuo/C4EYRaoEq5RjUrLc4jM/NRWz9s8dem5nYnyJValJbAkFLZdE50sJtHVtnM28CzV19c/3Ev5lqEHB7H7ZneuclymUHj1qF90LcbNU7q7f79D2WRBFH4a3lbeTLbrMbb96Eau29suEyXHakxLrj3NsbibJ8wfYhbiQaYOS8h4iAfyogFtQt0aVKUrD15ihd3n27xTUVCLsAEzOZKX4GyF2I2d+qbSScXjGJCx6l+AjNYGP5yNW/VBiWWrQXTUFXwAj2QLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 22:50:20 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 22:50:20 +0000
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
Subject: [PATCH v2 1/7] rcu: introduce rcu_defer_qs_clear() helper
Date: Tue, 26 May 2026 18:50:08 -0400
Message-Id: <20260526225014.314734-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526225014.314734-1-joelagnelf@nvidia.com>
References: <20260526225014.314734-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:208:256::6) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f976a7-ebdc-4981-0976-08debb792a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3n6hL0q6Wru6wJDKs/7543CZCWUGIGk7VlHTcvsUMNWBtcv0iWhB0sUtpDFOiTXpzemxTjkITiJ0Qkz2p7yuEQCnnXW/VYUwgnJNIkML3BS8KSvjvwS7u84Ofn9lcc6rTkcaJ/tz3b6KoQza5zhhMGgmoRxxy60LvCh5//HB+r6XZuAwNn2ffN5rzIOWoWy6ZcCjOgNS7v9Jo0Ya8w/ga18k7xl3Ch6XuJr+rQjEJfiRGY2hS2n2crkxqe1txAwxm3b/1jfUF7grXRBHVmvk/BQUzsoJxCGrhAU6vORssj51sy67JLSx4C33lMvicuokMtJ+u1AGC4o/E7FqmKTcs8exG0kNI7JWkrrBUhqOYTJl5s3UgS+PVsrwhQTFd++fzz7bAJGehknaXKCIrzkz9GolnggDeyGh6gKjHQ2LZEDuhH56hQQAHBHRb08J2kgzuuFDZ6z4MkC2Wyz3vdU6q6Uht5B2FwFCunNbewSVzS9fygd0EQyZ6KTHohn24Rc9I77mPphsuaV9Qxwut3X/ciwVA+ElzHu0UuOic4V44r1o8ybjlGHJMe/ZDDWdDVQHEGLgfG6WIfRv6oRgyUSmvUoELWma2t2/eOq8/O5hKXOlT0Y/JNHIDKJ18KZ9sUuDCv9VkX/RV5jDizxoqJUNEqKe13m1CE8kqJL+CwPiw1FliwDgJp37p8FN+oBDOj3h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QKbJMuH9RIGxTx52Tdd5g3xcGzGQgjxWDGzCHV7LGbYzeudPE+iRofJzM3kf?=
 =?us-ascii?Q?Va98agxKoaXeg+I5wP8o9rQ7/SH3qtZOQMsR46W1tDSlWPP1XfKwI+C2YIfg?=
 =?us-ascii?Q?DnOjLIxoEz+PleZELilKCyHmY+N3BD11LMiLzEp1aRWyfsTQUC3twTPTRy6s?=
 =?us-ascii?Q?TZXpWk88Q7wQeXHdZpmJpvXpIdld3/Af0LvXYMXbAJP04W4gBEVv/dcMcjcU?=
 =?us-ascii?Q?fFXMQ/H3MFAYJGkwQ9SVK/xMQnCrvYTJbB0e1HZnqF3Ygd/t6JGHIBF3PNia?=
 =?us-ascii?Q?32kzhSyXhdYgkJ9gJHC2E/GOzvO/d/MXsx146PSFz6AOlWiC/qsgnEfzNy/w?=
 =?us-ascii?Q?FI4Tebw+vBE7ZeULCrY0XwoqudWtg8gaWLxyCDKgHUpXQRCtgk9YjN84V+if?=
 =?us-ascii?Q?Htzw2QJhBYdWtfbIPhSenOSwt7uCBqZd1L8n5AK4k7/L33rgRwNAsOhZhYKh?=
 =?us-ascii?Q?iBnkKN+EL5xHNMelrEcKKKKlvM8THp6w5OypNsdZ9H08mI5KlFBh7MQb5A1/?=
 =?us-ascii?Q?sA6ggAjsHUyeT9CaKuXa37/t3eVhSru5aX70GYVGsQOPgUj04/RwjaNKj7b4?=
 =?us-ascii?Q?RMnWgQ5GP9SfOrRTcG0MVGIhbgL5LSkgjunFUooswdPXsazkuo+9K0NOHcHs?=
 =?us-ascii?Q?vJsoYDzvCEunJPsB/QzoMahj20hEY5ubbFD5vgaoxYqDTtiB9aAr/u0o71Vf?=
 =?us-ascii?Q?s6wfEQz9VlwLuawEoF75VJEF0yOFAUFuEQqD557j5gKcz/sv//doPQAbXQA9?=
 =?us-ascii?Q?K+K9jQm92OfljFMJ9ZZ1KsGSpVMlKVtuQoPj0BIO+GNlh3z2GFbaOvabiccv?=
 =?us-ascii?Q?GtnJilZTEc2SATExyAnOyhjM04du/tINwZKN1nYexwpBfOK3vkoX1Tc+Z8CL?=
 =?us-ascii?Q?do4WP3pYTLvzSz1+DMo5rW4isDSxqdAPQWbY1dMg72lDmnyKDFNXXgF2x2g9?=
 =?us-ascii?Q?zd33/C5BivgZnbZ0eS/sx+ZT6I8vQRGyziNrvmuJCo/U8sItQWxywFqmJdrL?=
 =?us-ascii?Q?1aAgdK9j0BbBnw9ne6mheaF98dbkpjDmPVNbdSqDerThJEos05HA/cswRojf?=
 =?us-ascii?Q?jZrcbqCkv9BpItzJQQ+tC/3UyFz+Ze+9DwvjtF6Zrzil8IBngUwR8H0sEdHt?=
 =?us-ascii?Q?odzQPeYE0Evv6Q7tN0pkbdRTyAmx6S2lc+s5A61c8tf2IK9Yxf4h1tLw0NSQ?=
 =?us-ascii?Q?TWZF/p96sMQGA5z7QiWiQ7t1PDJrnRopeDzZwOks+oppO1Prx0MF7+YtBtqT?=
 =?us-ascii?Q?rEl0S7RObZwJhPhlvtxVGWjvddu7W94ZvF4ru4gni/4GGa3LNH2R/v4EQ7cI?=
 =?us-ascii?Q?+de2x72DbhCyJ3ejRNMdA2O6PZZhPbfSjdR+J5HnDvuLIYj9g0Xqm+hWpFyF?=
 =?us-ascii?Q?sVg51+tteU5z7T8j+9EVi9sX/+bR9JqCDFaMJ+ldR5Daua8H003XSh2hpARb?=
 =?us-ascii?Q?L8uCQj/U7wBEoO1HfxpfhHU9/L5ZGvreJYhSu/MR3OksJsPUV8E4QU92xdI2?=
 =?us-ascii?Q?B3QMWpiatYCLGFzlIttMes45PL2XRi55ZjpmmhhCh9X7wmjfdIZ+9nHckrp9?=
 =?us-ascii?Q?nbcrq2nStC735EpGwsuX74OHNUl1mN5CG0oj4qsQ4NFmkWKBsN7tmf7TSEuJ?=
 =?us-ascii?Q?S5YVvoBSzZxUTmGD8kuK/Fhn/7+m+QAKb3/YiH5+3iIndrKiwc/TdfIEHChG?=
 =?us-ascii?Q?JevJaL4hjYjXY518RSZR9sf2qfw5Ox/8lYkvn8VE6lgZlU/CgAPOZaBiyYHV?=
 =?us-ascii?Q?an75CVdNPA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f976a7-ebdc-4981-0976-08debb792a15
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 22:50:20.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4U//QAzJxkEENTh52hhit3jw+aGdJyUJD/SBFtTVktYJS0SBWHSdxl2fp0mfemu33paHSVC6SKeobS6BQKyU7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

Currently rdp->defer_qs_pending transitions from DEFER_QS_PENDING to
DEFER_QS_IDLE at two sites: rcu_preempt_deferred_qs_irqrestore() and
rcu_preempt_deferred_qs_handler() (depth>0 reset).  Both write the
IDLE value directly.

Introduce a single inline helper rcu_defer_qs_clear() in tree.h and
route both sites through it.  This becomes the single
PENDING->IDLE transition point for upcoming work.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h        | 5 +++++
 kernel/rcu/tree_plugin.h | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7dfc57e9adb1..4069132f9d44 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -296,6 +296,11 @@ struct rcu_data {
 	int cpu;
 };
 
+static inline void rcu_defer_qs_clear(struct rcu_data *rdp)
+{
+	WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
+}
+
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
 #define RCU_NOCB_WAKE_NOT	0
 #define RCU_NOCB_WAKE_BYPASS	1
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 95ad967adcf3..8637f405cb47 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -488,7 +488,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 
 	rdp = this_cpu_ptr(&rcu_data);
 	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
-		rdp->defer_qs_pending = DEFER_QS_IDLE;
+		rcu_defer_qs_clear(rdp);
 
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
@@ -645,7 +645,7 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	 * 5. Deferred QS reporting does not happen.
 	 */
 	if (rcu_preempt_depth() > 0)
-		WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
+		rcu_defer_qs_clear(rdp);
 }
 
 /*
-- 
2.34.1

