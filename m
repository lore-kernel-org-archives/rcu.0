Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EDF2E11D7;
	Tue,  8 Jul 2025 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984576; cv=fail; b=kSHizD5MaM9Ic+n6v2N6pbNLf0OXakZPbmF7UWYqmhvi4vF9IPD8a6fBFzo9fBhbM+Kctx1FjfqZZlcuUCCKyO9GVAgNFPmxRI/9h3oe4js245E264c4Am3fW5x8yPTEpqxh3d73J7DMkd1XrFdirgUO/FDkGPfEJr9HsnHhDJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984576; c=relaxed/simple;
	bh=YoSK4v84m2cOaBQOeC7voDoGip2214jRqvS20zFD2PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SFzAn/vZp4z5EkzBn2i3OgRkk8oTAMXgajEGGyGYKcZVO6kyyLhELd3te9Ya2RXGnnQMDTQksTyxv1auL2srccf3pHwJM3KuMu4fMLBtOV5DTiv8uOpOlFZ6COedw+mvTpzVhBPfiVO5fmmecS7bXBy34YRCboLUBV1pqX4YuIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nf3JOjjX; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nf3JOjjX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtswP3Z0TXhVwkbpCo/UgmeixE0r9IQsj3v0izC4bNHvG/LiGJkWnxiyYPlzB2ANFeegn+xQfEGvh0sfx+FSt5rylyYSNF4XILu23FWoADs+tUNL6ykzUwltUmJuaSW5I8mWdGhX7GHsmE25GtISJWfxz+3xUGJsslQxa1Ifzau+Fdzedq8zBRd0FdVd8mhndKm0uA7NJLVQiCMHbtTq28OtjWtiXTHK9tKcnyFCicyPzUiuSNrHs+r7q1tS4I4Flih249B4gVQc9W0L9oo6aqR/gZwfzspkd/c/ttYF51BkNsLVDq7f9A6XsRvqlURS++qqzsmreR06zDS3Gmq/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Q70t3YM9g065XleBludviaHOBEqNP462a1rLpyNsJ8=;
 b=Jqw8NB1lOlJwOVIMcO+ep7yh7nbxRnekh9BDfuH+OMpm/sxdiFCgQ7uGn+PMW1FPaRWm7C/JExltJtEwIZH+dYBq06Ldr37PL1O6m88Wn2Dff+U2N+bWtDqima3BtTbwol/gMjLAhU278wrI7nsNh0KUqIC4bgeXZxSmkA1md2IqP8H7EsXV0w9GtUaF/WZcKauq50etOMfaEXmRdUIVqs1oODW3ROjO6QoWOygSQD9ZsBTzx9RVNS8ov/QuRnOKCc5wTDKe+0AjXbCrKfI7JOZeZQZzuObJgiahlwAWbnUoOdL6PKHpVJjYhIY+p9lTflNhtBOgvPXcV3soCA1lsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q70t3YM9g065XleBludviaHOBEqNP462a1rLpyNsJ8=;
 b=Nf3JOjjXtjmpotpRkzVGPy39wOEjCmM+Wb2dqBoBr9gUfdUX7RnIpjia31jDqdemQmV5mRbhW8ZHf6mhpZnpqQH8m61Fthr9/LTj/Vp43jvqNXRpTrnHoZjV/I7Piuh1kjwOl9uLO7UUkn1/AMTBQZ5CGVZYDz4QQ7RiqEXVCthb4ZQhEl2H80EnaA10WY+U+sFiC4YJtWHMylUw93qWzAlu5OUzIYvuCAJDTE9r/fPxA+T24jO83hnbOqHQ+sfK05RQaPNFVJUrMPZWJST3Jr3AlcYE+HE/0mAalNe7qStbzf1OZS//JKWRLdRnUiaDF4usNTf+bouzW3tTT656SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 14:22:49 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 8 Jul 2025
 14:22:48 +0000
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
	Jonathan Corbet <corbet@lwn.net>
Cc: rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH -rcu -next 5/7] rcu: Document GP init vs hotplug-scan ordering requirements
Date: Tue,  8 Jul 2025 10:22:22 -0400
Message-Id: <20250708142224.3940851-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708142224.3940851-1-joelagnelf@nvidia.com>
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::22) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ab2f7f-f56a-467e-a0d0-08ddbe2aea4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bA7xBB76z3N1CHzLTnYYWFn/AHwWHjvugFOcyk0wCQSe7w3+GJYNbTIeuga2?=
 =?us-ascii?Q?3ZibU+LFU89f1anlw1/pFkCKsZeo5Zp7dUdpwLqOBiQOZ4TB+wFFfSV4wd4x?=
 =?us-ascii?Q?1EzhB2Nie1IiivFDLe/MwPeQT5zkyJDyQvInrmIKDaKPSYRyn1t5SSRRLuMJ?=
 =?us-ascii?Q?v2a24aHZ8Oie4RScqrnoVyenXZ3SXTFxd5T57Rc52+Z6Tez+J0et1z896G1e?=
 =?us-ascii?Q?gEBeRuwJchrqXyxhRN8FL18a6ITSSJ8KohJQsIQ9OUZlMZs665KDDRAnonDB?=
 =?us-ascii?Q?yKy1ojs/Meiok+/KtNQveGqtATo4bIfDrbslIkpov+5lWsS21kX5GgzWiOQ9?=
 =?us-ascii?Q?H3Ujz9N9ZSSXhf1Z49oEIeLZ87EtudpUbYWAvPCtabNBfx7V3wjs9+oROq/5?=
 =?us-ascii?Q?QpQn2UM+/a6GhnT7RDAki2/ZOShWPFsettTi+YxyLR253Q5b1RT2xyi6EE3R?=
 =?us-ascii?Q?3ebPNUQ6fYb+T7oY3s+EIiR4acavbpXR4DpI3ATUQbaPQS6M1cW3I7PQ9DsL?=
 =?us-ascii?Q?r4yZHTnCPY7trrVgNSIHkO9mE7rvmV65/+AQoGKnW3nPYSK63TYYRfrrDZ3p?=
 =?us-ascii?Q?NgpNpcxult4RBu+DGONQ5ia1Aw6ht0cAJgCU598bbHHSGkZMd1CZ0wk8V1K3?=
 =?us-ascii?Q?KhZGr5T/NypfRLuXe3J1m04y7Kf9gy6b7iyJ52gB2QtplSqtCGRJ/WUS5g92?=
 =?us-ascii?Q?MTaQ6M2YWLnFyXqcRbdmp5QzMUjtObxKXIcwJzkVFaOS3H7l+Gj4jVHt7l9Y?=
 =?us-ascii?Q?tG9TJKQKJdiJBc7zMI5JDiwCarKHiusJyS7U2hCcZlCG/Ccb2xlsPk3s1ygb?=
 =?us-ascii?Q?nmuGvLMIeY0X+472/0dcoEPFJ6+Orq0SskLv6AWmMug5AIGn6R+tF9jNzdG7?=
 =?us-ascii?Q?oOZE5EoSqDmG4CKXwP3si4Hk9I+Llk5mjc7S/RuU6ya8LertUM/yXvG0CzZV?=
 =?us-ascii?Q?+O7K1oW29RUHd9gboJ0z6lAEi3hs+R1Kc/k5ih0MfKxnx4wbt8LE6OYWOa26?=
 =?us-ascii?Q?oahp0g+zAczDcELElfDfMONRKMoXV4L9VLSbL9g5idPA0lmq/gJydqA9laoJ?=
 =?us-ascii?Q?Iuzv4qUeKoZh8WXHbBJpscTF5hp9TgMePVO8XZSMpW5yhTM3wYV2BuCupv0T?=
 =?us-ascii?Q?qiHK/XIGI59yfR3UNScYdkTBCf4ZvYejeBjb78F4yud0/zxohhONLo5dHuYk?=
 =?us-ascii?Q?rZ1d2W6O4I3BfjPgqCXBBFnofPR3YaoRUxc3yIqJcjTnJdybscvH83Y6nNAT?=
 =?us-ascii?Q?VGpsWFFL1dUCJz8UMA4fCBmyMBdTa0MeYAG1Q/P3bBgePto5kR5HVx+RorOU?=
 =?us-ascii?Q?3B2aoj7scrjK23CYrTfrMK3V12ovOe1t3Y0z38QZm//uAWRWDgnkgMCgUob7?=
 =?us-ascii?Q?a453+NP4ZVXW5gk0i70TsRgRh94oYK3pk2fAqFR/RN/XTWiHA+ie6k8FMeFG?=
 =?us-ascii?Q?Ei5Jt/NAeYemqb3XotZDad+7CkyzjBi2CVidRynpi3mZjTVvyGcD5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6GGJGiebx7SLsHLHb3ftkEbL7RzlSb2fhFHLoQ53TNr8QR6LAM88BelwboU+?=
 =?us-ascii?Q?pFQEqcajuBXTtIBqsigaCFkwSHy5ZmedfveerW16U2pcvGRgDiI2gcNKA1DQ?=
 =?us-ascii?Q?Zu55fDW1ZIMsiKO3p7YehgrsHytNyVT56U7ofoweDPzhCfC5uEoZ8PpUzt01?=
 =?us-ascii?Q?p50qszCFRz4hjek6dzRi1smT3s2OgpWAkmzF/KDl8BLZtRTOnxK5RO5Lre55?=
 =?us-ascii?Q?BjxwsZUfIVQhetbdBOmi5A6y7ghYwDJ2GhhDBuZWbJ57RNbVoe/PL4SOaNwv?=
 =?us-ascii?Q?93P798XFeQpwnY6m9N88fekrK0aLX6nthdS+oTwj60Wv/p4pkMYDglxx8rAJ?=
 =?us-ascii?Q?BRi54Lh5sIf1YM7T63bPrxCZ12Db6vZ2vDmxiFkiNSqHhwOQp4ES074UpbMA?=
 =?us-ascii?Q?iOX+qNrIpioGKl7ryFvAl60mIs0B2MwxVnGiznqzNqxyAJEXCvMdrIw3cTIb?=
 =?us-ascii?Q?GKaTQdcuu2XNCPlpcdB3WDDXWjQueUpqqnw5oef4E63CBxqyXIl4dCDLbAAR?=
 =?us-ascii?Q?Kev8toFe/32rMtUx87xb6/rpXYfRfjL+VQT2KzB8XEXYkH+DHXUsBubphbBI?=
 =?us-ascii?Q?Ef5a4+QLfqbC22+8Fk/xObCLDAtzKMNlOq4P7oJm4hMxCO16O/GN0Anw5iIG?=
 =?us-ascii?Q?gWXKkg7rQ0pCPQYXFe8K+R511y/oV7t5gfiEXzPATw8u/mJm5+Xi71bbY3BQ?=
 =?us-ascii?Q?GUqZymjo/1KWpyYr5w9AQTG6Ygec2661ImhQFGFXerfXL9PLY9BSPxOmPADm?=
 =?us-ascii?Q?Sc/KjXtyDfCqLuKTayxjWBB2QlfAMASxZkA79Py9Q24gWcOQ38zExBCORkbX?=
 =?us-ascii?Q?OuQLf3DoarCVFmlitwvjsIvcMWYJPkSgF2ACQcZ1+SS9koMrus/kSW4jueen?=
 =?us-ascii?Q?N3Flkz7xa4MJAFImM7WvG3rrn2jwh2nx0ADU1fWQNB7b6w+GC1RJkyo7jnCE?=
 =?us-ascii?Q?nvK5fC/sl0VnTCqzKGgWWLU9D40C2CDz3FuDaR6Wbi/3MP6wq+gpkKmyTG49?=
 =?us-ascii?Q?XZibXMRBzo+CIXq2y3dtcYVy6zMMRdzxU+OwCkdVMORjs7J4IeUK9QqEIQ4h?=
 =?us-ascii?Q?R6tXf1KKkCJxLmKYhrO0ILr+AQrrV4yw8VxhnkqI0mhkQReMQcxnqWnWTpNb?=
 =?us-ascii?Q?2spUzs3WJNv/1IWibWbjhPXcjyLW3Ue4jZJjsYzOQ5gW8lXw7KHaMpVy3t+a?=
 =?us-ascii?Q?1JJAhBN/ta/eyxg21nMgwObATMWsaLMIYsQp0hmxMbi2hf9VqS2T+ejuixe5?=
 =?us-ascii?Q?GV7Ujl/k19ocH7AXJIKbbUetwlsUtRmuxqW6nSxvms9Vjl06e7nhaME35K2Y?=
 =?us-ascii?Q?MT2P6UKpkk8FbWj78H11lIVmwiOWTln3/UR2NCugF4/E68sU0ciyiWcHZCa6?=
 =?us-ascii?Q?H0xIWAdCgseeTgVpEZP+8wGZY4G4bjDosSkJ2IcjTorKh4Pf2kEW4mgxtz+M?=
 =?us-ascii?Q?31tR+1deAeMg0dGXUegvhLOL3dz3hsxfh4I2XNuUJhh+iLhZhs/pWJObFlCE?=
 =?us-ascii?Q?cL6CbdViT2BfZy7RCAQ4rQvfUl7gzQmlGMyu25Up//Dgkoy6F9FYxWsZczYQ?=
 =?us-ascii?Q?g/PRxtpy/dqpRV8f5GZnX0+tyBgWmbmoe+lXZb0h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ab2f7f-f56a-467e-a0d0-08ddbe2aea4d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:22:48.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxhUMsNPgEhN/hnrJ2w9yKvXL6inCTtOW5GpmX2Wbgh8D2cdGQRtt4/SjE0MVCaMNm5jtip/hnrPqoWIPxJ+Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

Add detailed comments explaining the critical ordering constraints
during RCU grace period initialization, based on discussions with
Frederic.

Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../RCU/Design/Requirements/Requirements.rst  | 41 +++++++++++++++++++
 kernel/rcu/tree.c                             |  8 ++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 6125e7068d2c..771a1ce4c84d 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1970,6 +1970,47 @@ corresponding CPU's leaf node lock is held. This avoids race conditions
 between RCU's hotplug notifier hooks, the grace period initialization
 code, and the FQS loop, all of which refer to or modify this bookkeeping.
 
+Note that grace period initialization (rcu_gp_init()) must carefully sequence
+CPU hotplug scanning with grace period state changes. For example, the
+following race could occur in rcu_gp_init() if rcu_seq_start() were to happen
+after the CPU hotplug scanning.
+
+.. code-block:: none
+
+   CPU0 (rcu_gp_init)                   CPU1                          CPU2
+   ---------------------                ----                          ----
+   // Hotplug scan first (WRONG ORDER)
+   rcu_for_each_leaf_node(rnp) {
+       rnp->qsmaskinit = rnp->qsmaskinitnext;
+   }
+                                        rcutree_report_cpu_starting()
+                                            rnp->qsmaskinitnext |= mask;
+                                        rcu_read_lock()
+                                        r0 = *X;
+                                                                      r1 = *X;
+                                                                      X = NULL;
+                                                                      cookie = get_state_synchronize_rcu();
+                                                                      // cookie = 8 (future GP)
+   rcu_seq_start(&rcu_state.gp_seq);
+   // gp_seq = 5
+
+   // CPU1 now invisible to this GP!
+   rcu_for_each_node_breadth_first() {
+       rnp->qsmask = rnp->qsmaskinit;
+       // CPU1 not included!
+   }
+
+   // GP completes without CPU1
+   rcu_seq_end(&rcu_state.gp_seq);
+   // gp_seq = 8
+                                                                      poll_state_synchronize_rcu(cookie);
+                                                                      // Returns true!
+                                                                      kfree(r1);
+                                        r2 = *r0; // USE-AFTER-FREE!
+
+By incrementing gp_seq first, CPU1's RCU read-side critical section
+is guaranteed to not be missed by CPU2.
+
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 327848f436e7..32fdb66e9c9f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1835,6 +1835,14 @@ static noinline_for_stack bool rcu_gp_init(void)
 	start_new_poll = rcu_sr_normal_gp_init();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	old_gp_seq = rcu_state.gp_seq;
+	/*
+	 * Critical ordering: rcu_seq_start() must happen BEFORE the CPU hotplug
+	 * scan below. Otherwise we risk a race where a newly onlining CPU could
+	 * be missed by the current grace period, potentially leading to
+	 * use-after-free errors. For a detailed explanation of this race, see
+	 * Documentation/RCU/Design/Requirements/Requirements.rst in the
+	 * "Hotplug CPU" section.
+	 */
 	rcu_seq_start(&rcu_state.gp_seq);
 	/* Ensure that rcu_seq_done_exact() guardband doesn't give false positives. */
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
-- 
2.34.1

