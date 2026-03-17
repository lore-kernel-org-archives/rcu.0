Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA44391847;
	Tue, 17 Mar 2026 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782595; cv=fail; b=m5ME9/wbkjzXIdbw0yvWq+GOXlQAJZ2vflq8TEvUvu0Pe+SLTLPKLJH8IxBzAuBxus9gVR/miUyWGDx5gXwdWS/gv/t8RSLXv39Jna/IhmGQsqLXuhLMx7Q12zi/Z1ixWtOayzFKYdQw3L1l6111XUqZg0AE0lrNWPCErXjxvIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782595; c=relaxed/simple;
	bh=j/U+rAmWKYGyibDoD+qlb1D30pJYB0XJVS/R4JZytJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRdocYZ72+n484pGZRFZxYwvlzfs5mkX9ls7jy6Wfzwe/16JrcUMBlxT5plcFoIPnjdcF8dPANuuFiP/LIxNwcCTfot5aFYSLLfBOCsmqOROoH7FG4xIFXeNYAquUNeDrria2i040uyX+QU11/8blHrM4vmLxZIGLed1SxYzqws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sHg6XaaX; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sHg6XaaX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg3qp/hSFW7Lm/127nR4zW/eE8veL3ey95KC9pCCh3Wo0CKWN3gOabU6leMEnch0fmcV16opWIX7xVJAxpnz4Tkw31wi8t+Hct1OY4CmaGyX0tsFFvQMUzrnzVswaz7L4IOnkfb/u55IzneC+axchNpVStoy+B2saBJuvDZzBLgTCln9U7xGaDA3jrsAf+lhSnvH8ZFsNCY0sqXLVQbuqywVYir8mpuQG0f/G2X63lGgnk8rwuHsT55AO3Xp58RXt72g2+i8FyBftfcw2pcL+EJ/FWdWg1ThSm8XFGXgvaj+Ruy/uZWtH1hKflJxYhSGyphzv6YUZAlPIrcMnp4uTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mGmNYJDBA4/psgnJsQsR65ywFC80i11SU2UF+G0zt0=;
 b=PJy0n69H+x9Y0uLkbpuvYqwkBP9/ia9sckjWktvTcdTyKEvlXI+SijrCBwH/h1hDiGml7OrHlGS7NHb1Sl9eoUhMVmROk9Ltmy5A2+C1c4WJsNpxGH78mDivqXRq2TbHAzPG2ejCjk+Qky1mEze7prQqqgHJZSmLcWHjXb/qFAqAqU0P6V4PbHS/qg+x0W0/gd0kMzqeTCNL+pGTww2ZsGT+IU36wvg6u+GInw7u0+zRvjyZlvTmW+rtSdBcmE2ySuvRI5YB/fQKcUufZyA1OdZzUmeqdS17C8A/7WCrO7BPnbl/pO1NzaDQ8th0bnxvei/L1unggU74B9RcNBzgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mGmNYJDBA4/psgnJsQsR65ywFC80i11SU2UF+G0zt0=;
 b=sHg6XaaXR+qFkuxqI73c52V6KJ2bymiwL9Pe8mSWFpaXHLnqXLn5xVoX3HqngZT688l/0k8okESItQB+sZXZw94sEl3lrowpAsryjEx2gRi4J73iLCEeFMIVcfxNIx+oihYk0xgkCUzTyD/3GNPGZM6zt09TP+MlRX+xElLHJZHhX3dLD6bA3uUWD6lKQKN5ecwlUu24qC0Op91UN4xHoCsDZk8qocc4sw3J+GcVwK6NugBdnY8VNREKT9N8hwF+C6myzLubW9XaeHfmKqx2ReEmgQdPZ/DXOUn/1mbaQ/a2LEAQHtCpzCRnBxg6lU5eanFxZkirloQX+z9K1UnmlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:23:06 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:23:05 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next v1 08/16] srcu: Fix SRCU read flavor macro comments
Date: Tue, 17 Mar 2026 17:22:09 -0400
Message-Id: <20260317212217.1527644-9-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR13CA0022.namprd13.prod.outlook.com (2603:10b6:930::32)
 To DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 09336e6a-73de-4a49-5d41-08de846b6102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6p4/IvpwkfdtBjA5TlYEODj5JnVjKR3fzf37/oEag4uA0dSHaAlyuCNotewrRVuEsFKnAVUYcegLgd+GaAWJQ19LAIQdvZnkf2qNERtTvmZupRrBKkunxu2Qq7qh9s7tFPrGOzzGPiDF7aHPiDU3hcM7IGVF9p9jwZq6Llv7ARRIH+9ALiuw/9RNorYZ4//0SGPwXhrH3FrC7DaY7p2too6+XHSoT7ji1u2coB5nsZWo+dbZmRz1JB/N55XSHO7/cVB6pRMXLFWLjAGdWoVoQl1MtaQqMa++LEAbRGmk7V3Mc3zzE4SKtnObUp6z7Vex/00+J7KLvwtUqSbDyOJpDkyqv80jd+wwOxbFgmteBtjSAEXPEM96BTxAZRZcftXD9wb1qf1ginj3kN2yu3RExwSSbDPMmjjdj7PefW02ER0+XJutmWp8Vsg505GHvFDHiU6uB8+M0ELlGg1KDLqsCnT39G40A8uTxDMZHC9FvobVpQRr3NSg38I6UDUVD/mSSptz9n1QDMzxKrlWSdcsqDo7O3mtSvCmVD9dJvO/xAY0Al3Or/H93biwy5GNyvCBonc20iX7rZWSBYJk17x4nnVW1DDjvMWuL114XeiDz9dEfyscywn3KPgimgLO4w7B/qP/N/zui67Nzuth3JGOZCGMDR8YYnIGlSqOpRbtjRfwHHU/PkhKzKqzhSx5h6/uMHZNx9whQEP78PHcO1RX9wYDfB16L7s3agIxJsLtfMU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1uZMGxYvpJYsHyaL1PQ6ytqm2Y4YizDGOE/l5Njdhn/ILKe59Bdgb7hqxWvP?=
 =?us-ascii?Q?ycVkoLk+T+77R5CY/QqVnCRNPGKda4eYUWSoj6Ndj80f+mx6fpwV4Xbvl6xW?=
 =?us-ascii?Q?mt8mIaeGscJuu0LRWv/f/YcKHFlpIWQ8i7JeSQoBFTCtQdt63bf10NKb6l8c?=
 =?us-ascii?Q?zGLB76RA5JZEKTEG3wZxoPUGk2E1WgVvA+CGtN7bUrkHh5fJa5LbMNucS1fb?=
 =?us-ascii?Q?L0yoStYZyWohalA5CyisNC+igHCmnBCzBvy0n/XsD3C+0iMsNq5D24ruFxfy?=
 =?us-ascii?Q?gU53tSK7iAk2F4bIGmHmnCoJDCz09ZNi9m+FRK6HTPffTkAm6sZl0Dw5oQTH?=
 =?us-ascii?Q?2Dnx+gfC6qZSv7ro3zwFJkSVjwy4o6PKDMSsk6EZjDoyycxAzRx0CtxKcsw+?=
 =?us-ascii?Q?KCqfkiCaUR1XtWNXTnk0LEYvDX4epRENdBxRsnQVIFRv3hQFeRU4K/uKwiAy?=
 =?us-ascii?Q?4qUkNXKl8MKNqo1I84XzVt0YzKfCSzTsy8co1AGC7H4Vs+uQLdJD/xzL7HoH?=
 =?us-ascii?Q?2Y+9Ritc/dnk/VtRkoC46S4AJAzqC5y0OPwLwolpetPygoAGZlbCBAjrrTUG?=
 =?us-ascii?Q?e044wJqhOpq6+4f8dtEuCzg5Ne428dyeqtzU3LEcGAqkdE4WdJ9YLXQqqISD?=
 =?us-ascii?Q?CxMtNFUdMtmnNTvPd7PkoB0Mn0QcJ3hWft00X9T8lgd0AsMdZNwER+sdtPt+?=
 =?us-ascii?Q?0TYAQZ7TgjHu24tTRqDdZnGUiiYScYKRSLm74ni6fiB4XNaP3kCRrNKPpaLg?=
 =?us-ascii?Q?oaWOMqHy7ZaoU5tgt69VfMQ9hKA0bkoi6ZHSLGvrrNcObu8Ii450EtzljQoL?=
 =?us-ascii?Q?GoWVt7Pge9Gtka/o/XrDTIkrjbwxxfc9EvF8fhgdgT7uQ5oVms5LodUA5TPR?=
 =?us-ascii?Q?qhyQqtlGe1xZZqDM7ynhZ0FmV7DSPkRKLpQv6tVsICX4wVryNmj71EP+prQ6?=
 =?us-ascii?Q?vkySGKypXjE03tF5p734QKQe0mhUCyYL7DeDO+4HK1vof1KvVrGIQo7IaEUI?=
 =?us-ascii?Q?I1D9qImG70GoRKKEbOPEfDIJmiZTqd148k3HqT3SlQz2t3Rk1vXxyF1BOtYY?=
 =?us-ascii?Q?g1V2XRyqwsZnqxHmCgvHI+VnrZvWuo1xjBBGC6L6D2bEYjdpFEafQ5D4uvr7?=
 =?us-ascii?Q?kRzGSXGL5QDCSqV05ctm2eEjwmERuaNHBVGt0ty3SsI4oXzTstq850w9dk72?=
 =?us-ascii?Q?tNMjEXtQdy1B34vkhTlfXtmGyyHxLg4bPlporaiACnM8DOQj1EOkcXMjtEcf?=
 =?us-ascii?Q?rHTkMkQMAK275kZ9yhrWsndrFn8ULIiNCS56nMDMVevgbD4zc3s0bYmuKpjQ?=
 =?us-ascii?Q?v+LqNeGCEB11GxjZYc6CQ3Zi0ohyPGfrZrf5npDReyGr9hpi/IkTkC7Z9JDs?=
 =?us-ascii?Q?RsZAN2ABduMN6gZyEV5Hb0fOszSo4mw0XY5H+lyFkJbpHSMm3M1UDftg+u3A?=
 =?us-ascii?Q?RnuDrH6urtaS7gexy75I5c4M/UHBiOpiDBom/+lk7RyY5pVr9Xdk88AvEAyC?=
 =?us-ascii?Q?AxKT4jewmus5ii9Dz1ixsDOL9xJJkrgAyfsoYyTr5laDTbc/1sr2Y9jc36NL?=
 =?us-ascii?Q?aK0rYCqB56dhGqfxhK+xd3HtMQSgP4cvZZwk1g67SGIVshQZDd0Z3+imePFN?=
 =?us-ascii?Q?Ds63NmTd610r5EwXzri+h01Z+8K8g1QDsM7fb/q7i5ZFTJnIJ3yhPxKJZSDp?=
 =?us-ascii?Q?lOjgcyaZm52mE1zgUdROpYrEaWukkWR2jaomxPMCAmunMpHgqZ0bhHVYv51X?=
 =?us-ascii?Q?mIxcDmQ2Ug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09336e6a-73de-4a49-5d41-08de846b6102
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:23:05.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLOlgcvL+NT4T9lCNLDDWdkGMDi8jfNnDbkV1aTchbMf7ErqUJltt0wsPEqUp0Lg2cL/2/c81xSu1mi3DA8sMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

From: "Paul E. McKenney" <paulmck@kernel.org>

The SRCU_READ_FLAVOR_FAST and SRCU_READ_FLAVOR_FAST_UPDOWN comments
need repair.  The former fails to not that SRCU-fast can be used in NMI
handlers, and the latter says that it goes with srcu_read_lock_fast()
when it really goes with srcu_read_lock_fast_updown().  This commit
therefore fixes both comments.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 include/linux/srcu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index bb44a0bd7696..81b1938512d5 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -69,8 +69,8 @@ int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_NORMAL		0x1		// srcu_read_lock().
 #define SRCU_READ_FLAVOR_NMI		0x2		// srcu_read_lock_nmisafe().
 //					0x4		// SRCU-lite is no longer with us.
-#define SRCU_READ_FLAVOR_FAST		0x4		// srcu_read_lock_fast().
-#define SRCU_READ_FLAVOR_FAST_UPDOWN	0x8		// srcu_read_lock_fast().
+#define SRCU_READ_FLAVOR_FAST		0x4		// srcu_read_lock_fast(), also NMI-safe.
+#define SRCU_READ_FLAVOR_FAST_UPDOWN	0x8		// srcu_read_lock_fast_updown().
 #define SRCU_READ_FLAVOR_ALL		(SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
 					 SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_FAST_UPDOWN)
 						// All of the above.
-- 
2.34.1

