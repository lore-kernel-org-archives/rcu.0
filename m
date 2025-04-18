Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21A8215168;
	Fri, 18 Apr 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992636; cv=fail; b=mAVTJhWPKIUPJMmSN1LWNJLZJTyWYgTTwMkc489MZwu4rvTs+/w3y8YwKGHM52nS+EAjsgc9dlGWER6HY9VBVea9j6e1e63w+k2d5waHLoBlCbUXJEYkY24a+GAWw1Wa30IFbkCH5CWUiAH3/1rnwUC+2xghZSbPjxoIMBmHrvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992636; c=relaxed/simple;
	bh=+Q3u0QY0+yiiew4RuMx5Z8wQhrdyhfgd1kBueQerSXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y5SbVLqADY25O2kIE0aeJo1serJoNeGRgHtmICeQotRXE7Ve8v65I/roAHfluK9aPGmjo9/Lto93l797Tz3Ow0qt8wdFeR8Q1km4mEoXLNf2txRW9FrvtsDEwI71F0sRYO/pPvDEFE1jL+Qy9v6k6OdHU13L+3ByLNYsk2yxsZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jdS+abWF; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jdS+abWF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6I7hEwzRYdt8kI3Je5MdqJXoYHh6bAXRLq0ldKEHxXxQRC5sxC5LEY0VWnFKfuSEKoJMJJDlwho/uATQSyxYOOkEIJ8v9/NoDYcGy4Ba4Uivy4pZq6bweSGkN8jBReP0iGPomDvJ2/g0SBDtwu47yKaeQtdc1tpBnpzr7940814iWI0z38h9rGmcM3Cg8lfXA/u9AYQeULWN552GRInhAWvhq+r/iYgeO2HN8DhlQZ2VYb1pWD4HEObZfDU4/AVWtcQMoQexj+8bv5JoFqyE1KCmFcVLAY46ulaUoyIOtCASKOy7Ccv1jVKpPt0nlHEyWCLIGFFdEo7sjZ6Slh1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K+eak0AGvF01Q75FOS0vWO5z2dFzmikQF1tNLrGobc=;
 b=jRSa/2ZpR06b5q0LQ6gFMVLjAx3AEdbVJRjE4p8wXsRR80krkDtAcW9vnoM4rpqMmcxSswUb/HpkAVtxZYdLVqk35LlcZnF8Lm6htmInDS4cALtb7KnnIXVmRmRKX3nmbgVEJ4e8X6FS8vp118ge+F+g3Oixawc3XjK8RXIsNEJrdofUeFQWCYtePZBzG00LEjcMAPJSDrPUKO9hIQa42Vm1E/xem5o4LTHeeaAlFn+9GsMO055nvIew2AA2wD/GuXcDoETnCu9BbnVvj1yegkx2oelzqFW0bU8S2AnJ0Y/Znl9rr4ztkXWf+LoHIQCmoZPLDpnQcz54rw0oKqxklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K+eak0AGvF01Q75FOS0vWO5z2dFzmikQF1tNLrGobc=;
 b=jdS+abWFdT4IwF0xxQDz5xsq6flN3FBf3limv1UaxFrCuVT7bFCPQgfHND2w8hwd6pWvtoZ3bCPCt9OwPHAfGWw6Qvjmvz4sJsHnIeodMGTaBdUJpUqYW7gMvEDNZlV0zF2jOWUJB4UmrVhPaOCRmIei0W9V6kiFJ9xnJomuO7hwx7iD/g2wft9HLgmfhi3sVWvzAU+bpe30NO76A0NNx/nmFDxzVvze87OtZe1Fliu82FTMoCmLO2IPX5BlIIs0/bC4uu1VzIAJgvTmjFfzaswG2VRoRBdK5ug7DKJegCaBpGG8UmredlMMjaX6q9z1ggtNX1GZIIrklCncHTK/rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Fri, 18 Apr
 2025 16:10:29 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:29 +0000
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
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 05/14] rcutorture: Add tests for SRCU up/down reader primitives
Date: Fri, 18 Apr 2025 12:09:37 -0400
Message-ID: <20250418161005.2425391-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c25ecb-3276-42ea-2838-08dd7e9389fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4HGMa0izHjMCmRwzUc6OUXSTdwgFBf0DVv4AVEfy/opCkUOtCMS5QvZihylQ?=
 =?us-ascii?Q?uwctc+6qMv5BxyjvykgX6OJUprj/HhMg431gfD/5sfEzkKa0EkY6CgsVF/ez?=
 =?us-ascii?Q?FOz1BZ72z02MDp+P5B5zNnlbHoPoQNePPLVWbXrVNataHnUjYNvA/Y915LF0?=
 =?us-ascii?Q?a3BvpaCgbPZOFNid8G9MttK02y6bR+zlzPWPfyCsyUdFT4qn1zz25c7yNjsd?=
 =?us-ascii?Q?hWqsdSaNg+ljs57WAy3M16EEf9E+T+qpAW0L72oBH7DsKIFNx4DHHXDajXun?=
 =?us-ascii?Q?Pu3GsNJDy2ZvEHtLU7yk/cJeg4rDCf2z9ywGpFxAoQM0SQynIQmnyrqpf/4s?=
 =?us-ascii?Q?Vekafj3EDKj5wVJEQ4VT4e+or9CqtbRkG6JEn1q7hfDnyajaM1Kbg+VOC593?=
 =?us-ascii?Q?TBinoVT5aFH5kK6LwzXSZtuMKLiH4OXbg7D9VqjT/DJSrHMFzkSMrstGJbud?=
 =?us-ascii?Q?SzeSL4/ozKFQ7KezwbwsLEstXRVsK1/fmokb2sSZ95I2U7IN3oX7aAB8CciG?=
 =?us-ascii?Q?hnqHlCnNDWKdUDT4El2dreoh2qfmQFWJUReqXkLeGBmzB3ZNNe26HyV3uPK8?=
 =?us-ascii?Q?BrN+uvCP00P7JNfLaBV7vya7IjmO6aBsC+wsxulmFdv5vj9N+QhldxfbDpvD?=
 =?us-ascii?Q?1qTPNRGNm05F05+YTxr+/sgIousgbjcEQEJ5jQwWaD7kKT+9nINB/czydiea?=
 =?us-ascii?Q?4LsGhoFZdRQ1nWXUjSpaJmIVENd7ArVqXM9l3DTnpLpXC214sHPOZyuEEZPY?=
 =?us-ascii?Q?+v08Pr4SOcWGd9tmW3amQlbIP7G/jtFQiq1my6wct4pslNhPY7q+D1vvOqSw?=
 =?us-ascii?Q?J5x/a1sJRatTXYHVk8QXVnGCBkkLm3WaH4w9zAUHWCBolx8Hya46q7PPxEVM?=
 =?us-ascii?Q?4ZuQxWcWfRi2nShxXxdI6aWf9NwoUPZ6v3LYm5tvEKEFjvcbg2E5Q4SaI5db?=
 =?us-ascii?Q?US1T8Sl+orCIdc88iEoJ/UKnF6WGq9+VfnNgqTxlArqxOD34ZIN0Nu2pLAqI?=
 =?us-ascii?Q?y+5Ko9grr9lTnRRH2K1uHswRiFwZU1LUSbQ1b/pUi6GGgqS60yRon5iLTYtp?=
 =?us-ascii?Q?9o6qidaBSYQDgrlaChMygM3V4syRNdZKrE7T2xTGrgva07+/TreNQADtr+nO?=
 =?us-ascii?Q?cHVs3K+FrqowyEB44cdJf8mDbeV5sqWm9rdh3SofulgEyDT2GziNupnZ87In?=
 =?us-ascii?Q?friiJg3FbWM50RVqNeHJAM/pQWEZxyqh0vKhAa3vjyrYngOokXiUxkXIrCt8?=
 =?us-ascii?Q?i+QxJ4Ub+BkhK3+i2bmTPdGyJsN9pyS0v+VRJz3A2z7EBDw60Bv2DxHgjh71?=
 =?us-ascii?Q?fxLPLWAWJkPl+iFWMcmmjHmMnRUf4RFDjJcRMQViOo3Wk/HqiOSeYe55JceZ?=
 =?us-ascii?Q?E1DnEyO0+dMkH7I+qvMugAjVSsT8cYiKSORSOKgw0n01n9vOwQNmeEcchyBt?=
 =?us-ascii?Q?TmqiDvW9C4YCoH9rKc4mRk5StLeo50r4vFj96cq8o0w6elTxBCl3KQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iXyr1S21zJhCEhwwq7XzrP+VXOTFj4ryxxbhTYhvN3yi1m1kI7It3hl9E56W?=
 =?us-ascii?Q?XonduOjYC0BQ6n2Y3wX/aitsLSR7wm4hBcY3p5pCFZkUsh6R4+yUgk4/cIZC?=
 =?us-ascii?Q?OrbyHdYscGOiHjAVJrv3ofBUiv/wzfvzg7woIzJ8G7RhV3dlsqtxUwBocrgv?=
 =?us-ascii?Q?30MmA5Pdh95R1JLcf6ylcez3TaSOy20ME8dgvH1gTNmFnDU2MjHtWv5Ig+ZS?=
 =?us-ascii?Q?uX+bRLwHBBupfHY42JnDn+Oo0qvJbzF1EtYmx/+fh6jnt2E82FUvUhy190Yp?=
 =?us-ascii?Q?SV01pCt+zkIQlfl5h5Pb4a6ZCrIU75E6SajdlbAKfUtZws3SYDstCR9Txt9Q?=
 =?us-ascii?Q?WdywxNs6b5ndbxwHl1Shwro1t/bEbqLdQ9gwuD7renuDeuQ3FJak8XXYmmFu?=
 =?us-ascii?Q?rPPbYXE+lnkVTMKbE68CTCE/WDqx6EpqoN5eXUt/qVn2DS9yteYtvAD6LCjk?=
 =?us-ascii?Q?nIMoNMsxBW+t5O6oRRcTcEMH8EaiEn/p0JzL7E8vKUHWMe6s64n1rKy+D501?=
 =?us-ascii?Q?8yDHrMA/Mm9xrxXk8wBiNm90/jk9clVBBzRRPgrH2W4eGg0ORiWy5keI7EQq?=
 =?us-ascii?Q?s4j3UxzZOGoGp4eyn5zsi+6/G5N8ybqqNwdVhpWjCCEtIDIqYu4XOgnhQxZD?=
 =?us-ascii?Q?B4hnKDugTEpzZUp2cTqzjKPax4bwgDIgvEF4IqF2qIaQ3NNTbRac5v79+IWu?=
 =?us-ascii?Q?EYE+ILjxtY/EnTLbGfw30/pb8ex0uV3nOT3GQaI6IZOBaiRzpheQ23zc1ZqD?=
 =?us-ascii?Q?sW2SIvF6LoEW9EZFKnZdGhEeTn2MNYDXrQNSWzQz/JxdekUis4rBsnhtoxe7?=
 =?us-ascii?Q?P4obaYV4kW5wsyNP3J00PNTP4lOTc+/gVR+BeHrZZSM21XzN6n5uMdbHkd7Y?=
 =?us-ascii?Q?DbDj2ipJWUEo1R/aI4fW/T4Mu48P5/Wkzao85xI5oXNcL6aR0bDuf993L7rP?=
 =?us-ascii?Q?Ctq+evkPyKZXy5EGTbD30uGNIYtvuStfUTwNuB+MmCY8Oht1cRTUvEk7WSrT?=
 =?us-ascii?Q?joUnkUkDPIv3XUlXnbDOmJNeoWXoj0TdsYGWC+TqNZpvWwFaTcSu1cOrZlaf?=
 =?us-ascii?Q?H+oVltjZT0tRRCabSNfQS/cNom8NGG/k5v1a9xdzj0i4gx4jyqhNs/9oWN2z?=
 =?us-ascii?Q?wPz7byl0xcgEi+3NY4d0u8kPzUhiobhZQXDO33CvFMpAvxqSky4M4K3idB7T?=
 =?us-ascii?Q?iE7SH9IlvNqcWCiJ4V38azVOZStUwdnUTvxwWIG7odbUHF8SO5uTg7j/z+Vr?=
 =?us-ascii?Q?G0fI7DvTbqvqFCVfLo6nkwMU3/c/ShS9h0jU/nXnIB2V+geKXGYC6YGw6JUI?=
 =?us-ascii?Q?uqRxnvSPHaqOSlXAZXZ5IpWb3KtK5LgsRcNtgLm5JFjT+4yXNAvpV/xTAy3y?=
 =?us-ascii?Q?E+NI84+8bZ7YvG8YD3vg3SwyaFj83U0YzMUsHYLvCqkuamVz55N/J4+6l/W1?=
 =?us-ascii?Q?HhAwQ8KHkxGaiXvjZC6SB6nh86hIrUM2S0qsLrRdQIq5gb8MePnLlqi3V7if?=
 =?us-ascii?Q?c8RRhdGrvAVmVJSuN6TMLRFps+eMG9ao+qbggZQQbOdKeWOlznf/lsg6iwdq?=
 =?us-ascii?Q?32UODFq99n4lG9UxXKO6CDt3FMAQ7Iqa1QFungJz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c25ecb-3276-42ea-2838-08dd7e9389fc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:29.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPqSK6TxPQpb6Qi2RO6E2HIv6+0o9Nra6VQXoQJoivPLTGn0mMGjOZLMkif9enGYumfObWys9VjojdDQ+eyv4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a new rcutorture.n_up_down kernel boot parameter
that specifies the number of outstanding SRCU up/down readers, which
begin in kthread context and end in an hrtimer handler.  There is a new
kthread ("rcu_torture_updown") that scans an per-reader array looking
for elements whose readers have ended.  This kthread sleeps between one
and two milliseconds between consecutive scans.

[ paulmck: Apply kernel test robot feedback. ]
[ paulmck: Apply Z qiang feedback. ]
[ joel: Fix build error: hrtimer_init is replaced by  hrtimer_setup. ]
[ joel: Apply Boqun bug fix to drop extra up_read() call in
        rcu_torture_updown()].

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 225 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 206 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ae7b68043150..be671e09c1ce 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -55,22 +55,24 @@ MODULE_DESCRIPTION("Read-Copy Update module-based torture test facility");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@joshtriplett.org>");
 
-/* Bits for ->extendables field, extendables param, and related definitions. */
-#define RCUTORTURE_RDR_SHIFT_1	 8	/* Put SRCU index in upper bits. */
-#define RCUTORTURE_RDR_MASK_1	 (0xff << RCUTORTURE_RDR_SHIFT_1)
-#define RCUTORTURE_RDR_SHIFT_2	 16	/* Put SRCU index in upper bits. */
-#define RCUTORTURE_RDR_MASK_2	 (0xff << RCUTORTURE_RDR_SHIFT_2)
-#define RCUTORTURE_RDR_BH	 0x01	/* Extend readers by disabling bh. */
-#define RCUTORTURE_RDR_IRQ	 0x02	/*  ... disabling interrupts. */
-#define RCUTORTURE_RDR_PREEMPT	 0x04	/*  ... disabling preemption. */
-#define RCUTORTURE_RDR_RBH	 0x08	/*  ... rcu_read_lock_bh(). */
-#define RCUTORTURE_RDR_SCHED	 0x10	/*  ... rcu_read_lock_sched(). */
-#define RCUTORTURE_RDR_RCU_1	 0x20	/*  ... entering another RCU reader. */
-#define RCUTORTURE_RDR_RCU_2	 0x40	/*  ... entering another RCU reader. */
-#define RCUTORTURE_RDR_NBITS	 7	/* Number of bits defined above. */
-#define RCUTORTURE_MAX_EXTEND	 \
+// Bits for ->extendables field, extendables param, and related definitions.
+#define RCUTORTURE_RDR_SHIFT_1	8	// Put SRCU index in upper bits.
+#define RCUTORTURE_RDR_MASK_1	(0xff << RCUTORTURE_RDR_SHIFT_1)
+#define RCUTORTURE_RDR_SHIFT_2	16	// Put SRCU index in upper bits.
+#define RCUTORTURE_RDR_MASK_2	(0xff << RCUTORTURE_RDR_SHIFT_2)
+#define RCUTORTURE_RDR_BH	0x01	// Extend readers by disabling bh.
+#define RCUTORTURE_RDR_IRQ	0x02	//  ... disabling interrupts.
+#define RCUTORTURE_RDR_PREEMPT	0x04	//  ... disabling preemption.
+#define RCUTORTURE_RDR_RBH	0x08	//  ... rcu_read_lock_bh().
+#define RCUTORTURE_RDR_SCHED	0x10	//  ... rcu_read_lock_sched().
+#define RCUTORTURE_RDR_RCU_1	0x20	//  ... entering another RCU reader.
+#define RCUTORTURE_RDR_RCU_2	0x40	//  ... entering another RCU reader.
+#define RCUTORTURE_RDR_UPDOWN	0x80	//  ... up-read from task, down-read from timer.
+					//	Note: Manual start, automatic end.
+#define RCUTORTURE_RDR_NBITS	8	// Number of bits defined above.
+#define RCUTORTURE_MAX_EXTEND	\
 	(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | RCUTORTURE_RDR_PREEMPT | \
-	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)
+	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)  // Intentionally omit RCUTORTURE_RDR_UPDOWN.
 #define RCUTORTURE_RDR_ALLBITS	\
 	(RCUTORTURE_MAX_EXTEND | RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2 | \
 	 RCUTORTURE_RDR_MASK_1 | RCUTORTURE_RDR_MASK_2)
@@ -110,6 +112,7 @@ torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
 torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
 torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
 torture_param(int, n_barrier_cbs, 0, "# of callbacks/kthreads for barrier testing");
+torture_param(int, n_up_down, 32, "# of concurrent up/down hrtimer-based RCU readers");
 torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
@@ -152,6 +155,7 @@ static int nrealfakewriters;
 static struct task_struct *writer_task;
 static struct task_struct **fakewriter_tasks;
 static struct task_struct **reader_tasks;
+static struct task_struct *updown_task;
 static struct task_struct **nocb_tasks;
 static struct task_struct *stats_task;
 static struct task_struct *fqs_task;
@@ -374,6 +378,8 @@ struct rcu_torture_ops {
 	void (*readunlock)(int idx);
 	int (*readlock_held)(void);   // lockdep.
 	int (*readlock_nesting)(void); // actual nesting, if available, -1 if not.
+	int (*down_read)(void);
+	void (*up_read)(int idx);
 	unsigned long (*get_gp_seq)(void);
 	unsigned long (*gp_diff)(unsigned long new, unsigned long old);
 	void (*deferred_free)(struct rcu_torture *p);
@@ -421,6 +427,7 @@ struct rcu_torture_ops {
 	int no_pi_lock;
 	int debug_objects;
 	int start_poll_irqsoff;
+	int have_up_down;
 	const char *name;
 };
 
@@ -754,6 +761,50 @@ static int torture_srcu_read_lock_held(void)
 	return srcu_read_lock_held(srcu_ctlp);
 }
 
+static bool srcu_torture_have_up_down(void)
+{
+	int rf = reader_flavor;
+
+	if (!rf)
+		rf = SRCU_READ_FLAVOR_NORMAL;
+	return !!(cur_ops->have_up_down & rf);
+}
+
+static int srcu_torture_down_read(void)
+{
+	int idx;
+	struct srcu_ctr __percpu *scp;
+
+	WARN_ON_ONCE(reader_flavor & ~SRCU_READ_FLAVOR_ALL);
+	WARN_ON_ONCE(reader_flavor & (reader_flavor - 1));
+
+	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL)) {
+		idx = srcu_down_read(srcu_ctlp);
+		WARN_ON_ONCE(idx & ~0x1);
+		return idx;
+	}
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
+		scp = srcu_down_read_fast(srcu_ctlp);
+		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
+		WARN_ON_ONCE(idx & ~0x1);
+		return idx << 3;
+	}
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static void srcu_torture_up_read(int idx)
+{
+	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+		srcu_up_read_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
+	else if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) ||
+		 !(reader_flavor & SRCU_READ_FLAVOR_ALL))
+		srcu_up_read(srcu_ctlp, idx & 0x1);
+	else
+		WARN_ON_ONCE(1);
+}
+
 static unsigned long srcu_torture_completed(void)
 {
 	return srcu_batches_completed(srcu_ctlp);
@@ -811,6 +862,8 @@ static struct rcu_torture_ops srcu_ops = {
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
+	.down_read	= srcu_torture_down_read,
+	.up_read	= srcu_torture_up_read,
 	.readlock_held	= torture_srcu_read_lock_held,
 	.get_gp_seq	= srcu_torture_completed,
 	.gp_diff	= rcu_seq_diff,
@@ -831,6 +884,8 @@ static struct rcu_torture_ops srcu_ops = {
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.debug_objects	= 1,
+	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
+				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST,
 	.name		= "srcu"
 };
 
@@ -856,6 +911,8 @@ static struct rcu_torture_ops srcud_ops = {
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
 	.readlock_held	= torture_srcu_read_lock_held,
+	.down_read	= srcu_torture_down_read,
+	.up_read	= srcu_torture_up_read,
 	.get_gp_seq	= srcu_torture_completed,
 	.gp_diff	= rcu_seq_diff,
 	.deferred_free	= srcu_torture_deferred_free,
@@ -875,6 +932,8 @@ static struct rcu_torture_ops srcud_ops = {
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.debug_objects	= 1,
+	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
+				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST,
 	.name		= "srcud"
 };
 
@@ -1985,7 +2044,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 
 	first = idxold1 == 0;
 	WARN_ON_ONCE(idxold2 < 0);
-	WARN_ON_ONCE(idxold2 & ~RCUTORTURE_RDR_ALLBITS);
+	WARN_ON_ONCE(idxold2 & ~(RCUTORTURE_RDR_ALLBITS | RCUTORTURE_RDR_UPDOWN));
 	rcutorture_one_extend_check("before change", idxold1, statesnew, statesold, insoftirq);
 	rtrsp->rt_readstate = newstate;
 
@@ -2061,6 +2120,11 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 		if (lockit)
 			raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 	}
+	if (statesold & RCUTORTURE_RDR_UPDOWN) {
+		cur_ops->up_read((idxold1 & RCUTORTURE_RDR_MASK_1) >> RCUTORTURE_RDR_SHIFT_1);
+		WARN_ON_ONCE(idxnew1 != -1);
+		idxold1 = 0;
+	}
 
 	/* Delay if neither beginning nor end and there was a change. */
 	if ((statesnew || statesold) && *readstate && newstate)
@@ -2201,7 +2265,8 @@ static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp
 	rtorsp->started = cur_ops->get_gp_seq();
 	rtorsp->ts = rcu_trace_clock_local();
 	rtorsp->p = rcu_dereference_check(rcu_torture_current,
-				  !cur_ops->readlock_held || cur_ops->readlock_held());
+					  !cur_ops->readlock_held || cur_ops->readlock_held() ||
+					  (rtorsp->readstate & RCUTORTURE_RDR_UPDOWN));
 	if (rtorsp->p == NULL) {
 		/* Wait for rcu_torture_writer to get underway */
 		rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
@@ -2370,6 +2435,121 @@ rcu_torture_reader(void *arg)
 	return 0;
 }
 
+struct rcu_torture_one_read_state_updown {
+	struct hrtimer rtorsu_hrt;
+	bool rtorsu_inuse;
+	struct torture_random_state rtorsu_trs;
+	struct rcu_torture_one_read_state rtorsu_rtors;
+};
+
+static struct rcu_torture_one_read_state_updown *updownreaders;
+static DEFINE_TORTURE_RANDOM(rcu_torture_updown_rand);
+static int rcu_torture_updown(void *arg);
+
+static enum hrtimer_restart rcu_torture_updown_hrt(struct hrtimer *hrtp)
+{
+	struct rcu_torture_one_read_state_updown *rtorsup;
+
+	rtorsup = container_of(hrtp, struct rcu_torture_one_read_state_updown, rtorsu_hrt);
+	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
+	smp_store_release(&rtorsup->rtorsu_inuse, false);
+	return HRTIMER_NORESTART;
+}
+
+static int rcu_torture_updown_init(void)
+{
+	int i;
+	struct torture_random_state *rand = &rcu_torture_updown_rand;
+	int ret;
+
+	if (n_up_down < 0)
+		return 0;
+	if (!srcu_torture_have_up_down()) {
+		VERBOSE_TOROUT_STRING("rcu_torture_updown_init: Disabling up/down reader tests due to lack of primitives");
+		return 0;
+	}
+	updownreaders = kcalloc(n_up_down, sizeof(*updownreaders), GFP_KERNEL);
+	if (!updownreaders) {
+		VERBOSE_TOROUT_STRING("rcu_torture_updown_init: Out of memory, disabling up/down reader tests");
+		return -ENOMEM;
+	}
+	for (i = 0; i < n_up_down; i++) {
+		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
+		hrtimer_setup(&updownreaders[i].rtorsu_hrt, rcu_torture_updown_hrt, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+		torture_random_init(&updownreaders[i].rtorsu_trs);
+		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors,
+						&updownreaders[i].rtorsu_trs);
+	}
+	ret = torture_create_kthread(rcu_torture_updown, rand, updown_task);
+	if (ret) {
+		kfree(updownreaders);
+		updownreaders = NULL;
+	}
+	return ret;
+}
+
+static void rcu_torture_updown_cleanup(void)
+{
+	struct rcu_torture_one_read_state_updown *rtorsup;
+
+	for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
+		if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
+			continue;
+		if (!hrtimer_cancel(&rtorsup->rtorsu_hrt))
+			WARN_ON_ONCE(rtorsup->rtorsu_inuse);
+
+	}
+	kfree(updownreaders);
+	updownreaders = NULL;
+}
+
+/*
+ * RCU torture up/down reader kthread, starting RCU readers in kthread
+ * context and ending them in hrtimer handlers.  Otherwise similar to
+ * rcu_torture_reader().
+ */
+static int
+rcu_torture_updown(void *arg)
+{
+	int idx;
+	int rawidx;
+	struct rcu_torture_one_read_state_updown *rtorsup;
+	ktime_t t;
+
+	VERBOSE_TOROUT_STRING("rcu_torture_updown task started");
+	do {
+		for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
+			if (torture_must_stop())
+				break;
+			if (smp_load_acquire(&rtorsup->rtorsu_inuse))
+				continue;
+			init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors,
+							&rtorsup->rtorsu_trs);
+			rawidx = cur_ops->down_read();
+			idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
+			rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
+			rtorsup->rtorsu_rtors.rtrsp++;
+			if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors,
+							&rtorsup->rtorsu_trs, -1)) {
+				schedule_timeout_idle(HZ);
+				continue;
+			}
+			smp_store_release(&rtorsup->rtorsu_inuse, true);
+			t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
+			if (t < 10 * 1000)
+				t = 200 * 1000 * 1000;
+			hrtimer_start(&rtorsup->rtorsu_hrt, t,
+				      HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+		}
+		torture_hrtimeout_ms(1, 1000, &rcu_torture_updown_rand);
+		stutter_wait("rcu_torture_updown");
+	} while (!torture_must_stop());
+	rcu_torture_updown_cleanup();
+	torture_kthread_stopping("rcu_torture_updown");
+	return 0;
+}
+
 /*
  * Randomly Toggle CPUs' callback-offload state.  This uses hrtimers to
  * increase race probabilities and fuzzes the interval between toggling.
@@ -2620,7 +2800,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "reader_flavor=%x "
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
 		 "test_nmis=%d "
-		 "preempt_duration=%d preempt_interval=%d\n",
+		 "preempt_duration=%d preempt_interval=%d n_up_down=%d\n",
 		 torture_type, tag, nrealreaders, nrealfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
@@ -2634,7 +2814,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 reader_flavor,
 		 nocbs_nthreads, nocbs_toggle,
 		 test_nmis,
-		 preempt_duration, preempt_interval);
+		 preempt_duration, preempt_interval, n_up_down);
 }
 
 static int rcutorture_booster_cleanup(unsigned int cpu)
@@ -3686,6 +3866,10 @@ rcu_torture_cleanup(void)
 		nocb_tasks = NULL;
 	}
 
+	if (updown_task) {
+		torture_stop_kthread(rcu_torture_updown, updown_task);
+		updown_task = NULL;
+	}
 	if (reader_tasks) {
 		for (i = 0; i < nrealreaders; i++)
 			torture_stop_kthread(rcu_torture_reader,
@@ -4216,6 +4400,9 @@ rcu_torture_init(void)
 		if (torture_init_error(firsterr))
 			goto unwind;
 	}
+	firsterr = rcu_torture_updown_init();
+	if (torture_init_error(firsterr))
+		goto unwind;
 	nrealnocbers = nocbs_nthreads;
 	if (WARN_ON(nrealnocbers < 0))
 		nrealnocbers = 1;
-- 
2.43.0

