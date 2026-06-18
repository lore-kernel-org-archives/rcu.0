Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B9F3D75D7;
	Thu, 18 Jun 2026 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808689; cv=fail; b=HV88oWSGA7SVf/EwZq/TWJ1p3GLi2vQsvKaaxmm0ELo64lvnaoz1MkqZSFEQaSrMn6aPlQENHPXJsewY0ngF3U19HfOR6lUOscOsGfQS+AYBZyvm0Br7gVLyvyf11eoi5kifYmdPrkvq6373mQVobuvtkFgnSMh7qOzvmhqbu98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808689; c=relaxed/simple;
	bh=i5ccyOM6NQzmv+Oq+eBJFpH1UlwsRjLK8QAgVcA9JUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lwx//yrdnlk0MVorn3l023RcRqGQZ4XW8T5SnIX0sBZs/V9Ngg77Dm2kRLm6vfOLqspCtXLiNfu/1L+T7Ght8jcsrvy6QZwcQdH+bLY8dCqDdRCzkJ5BNnwLakgP8bLkjd/Sr0oVShLT5nffq9R87SXKVRoGcUXJpyZJeL1xLbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bZN79Xdv; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bZN79Xdv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lud1xzMkSRThYATPbKQ6P4BvarUcOd/mONltTd6WBSdL4EWjgTtymFNdyVLwMjbEdBwQRtErZHjj9Zki7vhg9w17drDbKxGmWtFYKagPYhXzuShlnRLy9EVx9hjlS2HAoaWNo1iB0erOYMNgnLbA8uvADBZX9YA6YFdjTzQ2q3rkZo+FzGo8Va9ERdzkYO6UaUv8i/MbIHWxNUUjoytAOlIU5cpcWh7jLRhY1ZDoIlpsQMXh90bSgjeZ/QyIU3XIZOt63kINRD4IgJk4z4WpRlYH6qbWWkgwNgBCV+///9IfYArUdnQsEhDPRJ8ygnyZVHHXx/IOiVjnr8v9dzhKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8caone8W+O1koWf1I0fbJ31miabks0BK1rNItW5rdw=;
 b=RUnnTVfIY4p7ycycvvcJyKo1PxBh4XPWCSLoSo28Ac4E8biQluMR5rfXcDSgdhHQXirKBiYRgWNicEwLoeecF5cmZkSr3l2BxzGejwATBN3k+tzmmQM3vOetoYLZWZuDkSRTwkkI16QsogMY6SSZszscZP4iG1GNWS03gHAtU5TQxstxjUHqPEu/YtQMWcSq7TTucAHpIqrWlbqX/yrZOG1uZL8kqcYt9U1qKFu9PIsu6DvGNnQzq03H0fWzqmZXGWpjzg2yxWWMKKq+/CgppzoUVZ5N+kGiIRtq4MHKPv4Llme5bD7Am+x0jCB60iCG9Njy/979aZaqDsWuVMTVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8caone8W+O1koWf1I0fbJ31miabks0BK1rNItW5rdw=;
 b=bZN79XdvF7c8cR97fwwfcCwDOwinK8XCntpDGH7W2vc9wePzHaSEuTHUEsuLwq75+BfcHlt22CgT3CHidvLYQ0OHaYKCBLxGt3l0V7DsICJUt5iHHJgBGEZEbzQX6E2fYf1PToFoHSpH+PCyJikAf0FmbbQ39QZqjw6/HAwPSBDiECD2XX6hbfmvMEMv1621h0ZfTaD5fowg9XMhKKKmMDsD9F3FtWa5WTMkHjra/oj/jxbjjBMfVTTAYJuosGS0sZ9eJ+lqC06pB7HINxaz+MhNibpmggFY0ohi5S5SCtpo0+SY8O+RuPLP7jzhsFQ0EeoyXa335RfO7gCJhGoV7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:20 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:19 +0000
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
	Davidlohr Bueso <dave@stgolabs.net>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org
Subject: [PATCH v3 05/14] rcu: clear defer_qs_pending at expedited IPI entry
Date: Thu, 18 Jun 2026 14:50:21 -0400
Message-Id: <20260618185030.376450-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0331.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::6) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f895ac-dacc-46d1-d208-08decd6a95bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qqwq3xrIDpePqBva/6ShLLVtm30SOjnOpg+xOHMNQ7Gul0HD/W4bH6eBvaBYm4rM/H2Y7ZmJT/jXMJTEX4LTjL12J1ogp+L6TTbZgDkxnHccnsWEyXsWv0gBnckinxBuqRKJ0I5We//PkmLi8fEAAA8X2yu4/lpnjNDW4nfIgCquVOjm9TQ4igK303VbLcYZSvTftso/gj1uvp8Ro7ORcC4SHzK49IltupyrGQ9m6EB43m0Fw1p9pzRucSVZpKnq2hKy6L0vTn8xFLqhdzaG/o20kJAoVzKsZBLSuU5ZPjyRmqWJZ/9vDutWkOObMua+CVWOuKVcGc/O7qYkK0u/CHaHwKcntYRFTA8nWNh9JodpmaVBrg7nPdm+lws2YtV3Eniy3KHw+caXHbbixpVgnHgF+9eozhGL1W2yYHbwjWBeEFZ1lLXIBxL/2rNWjrIjOHE2MFhWE6wG9U9sP+9SSKv4k9qRjl6ixsazOnYWyGDBg7Zn67NjVRKwKYLT4H0OQuJCIi15xRxG5k93+Ym9gm0A77EhhfcSeIq3gH+IscTFWXp0w8bKTkRx+4XBw/R2LbU6TFYuT/7WbHLFVxgTL9wq72+BxiB2Dy86vlSsVC3Vs+vm1O+gnJZ5N6sSiGrL+1xJ7xzmZUWSvrTNW5/Ab4idtqjUw/a4eqsTFQyzfn20gM/BLuYcgGKpJyMKrA0M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U4rHMYCKoE8ymNPYMoRvTCCiqeoi+YrLnVf5nOE7M/Pe5bH61F4Pqc/wrJ+n?=
 =?us-ascii?Q?9bBfaqQjnSoRzh5qEvktfnFweGrQ9v8MkuSuYTOvETCI2rN1Drdi2/Ipk2/2?=
 =?us-ascii?Q?+M6RVSfXWo458Y3OWbEjaagcIjVSKpjQg6NySNZ9KU3eBxE8pE7Qx+nDs3Z0?=
 =?us-ascii?Q?aPo6O97LkbstsTH0OsNKw51oWCrhUfecef8THOrGyd4gXIluVH+lA/YpNnL8?=
 =?us-ascii?Q?5eE2sY44snBoN2YoNBt/hk6L0bxEefI7Pj6UZ9WQUkO39V1t6Hxb/8NXZLaK?=
 =?us-ascii?Q?Oxc4lcpQQa8+ZrV1u9dsmRshGZ4sX42AbilT9clqFHVHm6fuO2QuZgMYj0aR?=
 =?us-ascii?Q?GhiS/U+iQTz0nDKU8Mt65YHPnO3LMbxlZg05eWmBz9Qrx0tG2e9E+A+ygy2x?=
 =?us-ascii?Q?mUHzKrVsG0xZkQvrYUrt1KJUHFey4qctUKCCJcdlTCHgb8YR25cy3Ng5fiB3?=
 =?us-ascii?Q?gbfdzKTmAQ/0SDh1zbjvATG9oFErUcDnLRUPtI2dkm8sg31rMgk4dLKNjPOO?=
 =?us-ascii?Q?gXFDcByKk7G37GFXYF5RiEFI5S3HB59iDNi3/NhEpbtiqqegkbipQ0T0B2MI?=
 =?us-ascii?Q?TwuSpP2KDTEmUOkmhYeCl3vaAH0UfJFEIh8tyFVasYZl5P9fWwI06ajUTgJC?=
 =?us-ascii?Q?KJxZ/oB+NKv6O93Ctc+k0rWxhZVsCcRZ51wvOSl+kFu1ztsmquSp3dnyp4Yz?=
 =?us-ascii?Q?AuUofG1waFD6BDfkeTk87GZnFtqcdTZF4GbKCXECECrlujXnlQF9lc1Mkksn?=
 =?us-ascii?Q?Wz/y0m1PHKyLOQAOs/eiZuuQKYYko0zITzKex1D/WT7bu397aYTqOchKzOA8?=
 =?us-ascii?Q?G8euuzeJFeL9SZl//AFIjjjEv8t+figNS2yhBHYAXwJThoFkqL6dHmIbK/ER?=
 =?us-ascii?Q?asQYDWmR2XRou2kdSdCeQVnr8LV0/u03GHQQalLl20RXo1ZnBUSuk4hHYUZ+?=
 =?us-ascii?Q?p29c9R5RmB0gOqNS7DDAJpcl1U1z30FUWDVLDYdpeivji/T6otUYnQFGK83x?=
 =?us-ascii?Q?5Rxa0UwkNkautohrowPq37myUVQY4OI3uMPpd43IvjBK6aE6YBw1ZAA6L2dL?=
 =?us-ascii?Q?k1Q1Zps6caJyGYHQxC1AqsOGkJsewpckyo7L8qtUice5hzi5t/XVDr0OGdyx?=
 =?us-ascii?Q?9jlwaFQt08IJE7ivqNV867M67lfBXXD/ytqlw/p7HYcsC7bEiKbJSEBL1feL?=
 =?us-ascii?Q?kDrP8rf+lqhAbruryIYu8malAPe00eeBJuSFAHHPTgs3PvFpFptmlCkh5lKe?=
 =?us-ascii?Q?FCRECXmDMe7JSuh/zsYkn8JCezgGg5GGIU/OSDYaiw9vdzJtWJnqXv46v/2C?=
 =?us-ascii?Q?vhwlU52oQz7m/NOwtmb1mmxwnGGqg/iBpxk0iBM3gNWXLabWtEXONYjj84pC?=
 =?us-ascii?Q?9fSgwwnkdxB+9VQgUHQ2Q0RV8zUskktvM8vrepAR+CogF/Pke9Vg5RybEZ42?=
 =?us-ascii?Q?JiBV7k2+C5wWwIzgneC1OQOJWXvOV13lJn0sUyU6xiTNfPKbrs144Ag6adgv?=
 =?us-ascii?Q?Pf1gPE2pV1tekoKXOSgrAUSrabvxXTAMU8ccGEaPVT2J4Pm1tQjUkgiIA3Nk?=
 =?us-ascii?Q?Ywg3UAwLW2EvKZ7QQiHueK2d5mIBZZQ4INU30k5v4W41gGuRlf4vABMV/0GE?=
 =?us-ascii?Q?zQzGFkt7yWZXmtu2tgbkst3JQr1fS3I3Vf81scAFHGdLNK9XCADjfC4Yn+Di?=
 =?us-ascii?Q?CUzcl1+ibxRqAPie9zxLqv5k1b0qNj4lG/SPgIVHO9gI9ZpizvnLztRlzwO8?=
 =?us-ascii?Q?d+bjuzBWYw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f895ac-dacc-46d1-d208-08decd6a95bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:19.8248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psvh122wHxz+lvtRvZnvBdw4moIJqWT5qDgZpX0bRYz0OLoHgJNaIRl2GxQ+oQe6ZS8ifICu22ZbEaQZOrHJgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

The per-CPU clear in __note_gp_changes() (from an earlier commit)
runs only when the local CPU notices a normal-GP advance.  When an
expedited GP arrives at a CPU whose defer_qs_pending is already
PENDING, rcu_read_unlock_special() may skip irq_work queuing due to the
pending gate.

Clear defer_qs_pending on the IPI target right in rcu_exp_handler().
This makes it possible for any arming attempt that follows
the IPI within the current GP to be able to queue irq_work again,
allowing completion expedited GPs quickly than waiting for one scheduler
tick.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_exp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 82cada459e5d..f8564a041879 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -763,6 +763,12 @@ static void rcu_exp_handler(void *unused)
 			 READ_ONCE(rdp->cpu_no_qs.b.exp)))
 		return;
 
+	/*
+	 * Clear defer_qs_pending so arming attempts following this IPI
+	 * within the current GP can queue irq_work again.
+	 */
+	rcu_defer_qs_clear(rdp);
+
 	/*
 	 * Second, the common case of not being in an RCU read-side
 	 * critical section.  If also enabled or idle, immediately
-- 
2.34.1

