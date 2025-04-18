Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110B215F5F;
	Fri, 18 Apr 2025 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992634; cv=fail; b=QSrHR7LDsbHtpiJQOnLzV4ZOOpCWClqQdqScL7Djm69gLY3mN7NGfGnFtPulTe0MIJxCJUEtoJ+Tiy4B6Q4uSIHUU9NejZhWwfP5tUuKG44qSnZ7GBE4BOMhN6fTY+7vLPcUp5PQlZ6o+TFf5iilPgHW7GQuAQl+LLknUxHAMOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992634; c=relaxed/simple;
	bh=BrXqNmgwhrFzqbjUmdWHSF9dtcn1ihitGKuSX+9eQlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XxxGR7MGeV/Cb576bFin2kVb/2SOfy3hv5EMQTIhZCDtlNaLhmIQl6uRtsY3titJ+pNdZircqQe9qCDDqf4VoAXoMX7ZklTXtQCHqmHQyQWZtbMMRuUI4X/Lf1o12Bl8/WCWonqSofKhNODMGZqIaf441EGpMtMvb+XEFA+uMzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lqnnpjDD; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lqnnpjDD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIT9TryXauKO6A+uKhR42F+dKok4vvILNTiweOOvPymG6HqIyqnQA78Saw7heHtzAV62Jde8bmo+4LmMdB+FWzOLWRolpBGb3XPEpSbOEHBXjJUDd4+vTpDhRTVMPlZdT8TfXQgYyxkGLRacuJuohpFbTNA4MdI8lqmuFIDmLBgo+MRSJGKRSMfP+pAkipghw0c97RiS2aX4G6wqqqX8U7mLFCPXEZn07TFPUSnxRcd0/MvmNbz2bmI/LuiLQ8X6ES+7Frns0aqVPNe1tmyxsYt6tlretweU14J0DsyP9PtHUghq9Etmc3SVkDnl7hX8QgG6eX20a3yXdUgO/bTNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu/KJGG1bO36meIzLlDIYvGc8wgwR2cGLs24TJSUElI=;
 b=JVCKdZlgfl/c25MSDaiaP24vxQhMsuT3YVWYwUB8ykrheH27ODmXGojsh6OcWFfXUf8wm4pT7cJAfPFNjzY540PaEmT8f492nLWNFN3ooIgf/JP1fO7TjDt+fpWtwHLEvvctkeeSJsrynQ2jHMhpeXULZn/qvZOHPQgwqwkIMPonFgJ35XUQ4JDMm0yk0iocBJzo878TSbtm8lB0WK9EjNgTXUe8PTDqq5oRHYIyCg9EWybVSLw+FlzrDIQm1zgTDeD3jnIAa8MuqW0MGAS03VXIB4PNBIXpBanD4ii2GVg0G0r70PKhsTATFUj2FUWJCA7L1KuwmHfV/0JY1CnRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu/KJGG1bO36meIzLlDIYvGc8wgwR2cGLs24TJSUElI=;
 b=lqnnpjDD+KZh0TjbQRokTIjw5tQoqdBPlr7wcdkAJnVv43XXaL8Ch30FmoE0MGv7mMUFk+gJIPBXhBJDXHQ7o+Qdw6btqtMK7Nn3Vwzfwpl5laO3XxU53hraAN7ENHSuE1E9Jt4tbwlvHdjo89wNJwA9yO4CCTGmIVjqUhHlYRBXaQNMMy7t6j6vUvDMtmvYpEz7BonMpqBpvuPGZCEaJzX+AIDvHD5O8W/mpv9OPAuZA4MNUClL6dKtrJ8MrrMldw6Kbkvv7npQdA7VehypflEA5xxpXrFyl9nt8N9z0dvEu1LOHfyvGlNC3lo+xOcio6gANcRp5SgW4NdMSwN/QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Fri, 18 Apr
 2025 16:10:25 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:25 +0000
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
Subject: [PATCH 03/14] rcutorture: Split out beginning and end from rcu_torture_one_read()
Date: Fri, 18 Apr 2025 12:09:35 -0400
Message-ID: <20250418161005.2425391-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: c14af837-de23-46b2-3bf0-08dd7e938741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iBgnAVuBwB60EEm0jlwbEv0CwRh6xZxstEi7jN9d+WTdlSCk8GeoBM4ll6eB?=
 =?us-ascii?Q?8jCPvjb2oZS7I9jzqUrP1RhDYs2FWIxqSjkLuNiYmpO5IGZ9FVDhSShppEEX?=
 =?us-ascii?Q?eJlDJNV5GClQ+9mqhsM98s3Nk0QdHtEj6m92HJhGXoCs0lTHmml/Ww19AWVN?=
 =?us-ascii?Q?6LXDVfvof9vKnxN5dVT0oaDW+dPg68Cz5zj1se01S/qUBt6hQROFswr5W342?=
 =?us-ascii?Q?uQ9GcS2sZ8QlIieYS9+wDUaM0OrSpzdeZHkzeSKH+m/uBA/KfJgn4Trlkvkp?=
 =?us-ascii?Q?5W1oGwEQg/jt9BDzXQ6+zfUyaA8r9zc/vLgthWFoJlH1fRReaKreMys2ztXU?=
 =?us-ascii?Q?GgQ9tTU622JsdtoiF2EpsCU5zH7imvtTJVMK7K0kfbw+Rwoz0pCO7zgpJDuo?=
 =?us-ascii?Q?8MRUPtJ7mY3Lm5ekDdoF4nFa3jefSnh5/+7NwrcHQ6/HZn4R8aWQsHCShu0X?=
 =?us-ascii?Q?nqDuIvEoNbdX/DGnjkFa/6S2UKP5gWMvfLPopDbVod0IRgiNl1NJOAHWOlFA?=
 =?us-ascii?Q?syfd+tt1b8DU/GTJXYWjDDNijQGh/I2AEYuIYpwZw4yJYDvpppvybDC6ZJJj?=
 =?us-ascii?Q?s9Rtf9TSAH4N8qLBrxwRi7cBRnTmecwak+ZxuKWE5sJEnIS7qY1fUTbL3rW0?=
 =?us-ascii?Q?n/whRYvO1L52t+Sn+Blo43YCpBTgnpBU9rJ01PN+Cy+KGxXphCVHvsGa3wLS?=
 =?us-ascii?Q?T8qVdM2XAXXIvHFvecFj3MstJtdfN1XFWpUAyDu4jKa9nd/046RpTBhwpmOz?=
 =?us-ascii?Q?ayzozxD6Gu1SmtppwQX91yZXrgoZ8KzRUplcip2yOLY/2vNKRa429eMc1xxQ?=
 =?us-ascii?Q?1DPqsGfdOhBQZzkRD0AZxZti+wLJxqeTfEfMg+sO2WpYx+oH/OrmEQeZhuuR?=
 =?us-ascii?Q?LRwJCQYwx1d8Sp8wF7p53n5NppUHoaeh7uGAr/MVvPOXgFd4TOfRt3q36kQZ?=
 =?us-ascii?Q?utPAXhQzB4a77H6Y4F9cnnB2RG2tmFFsSqExmNRhzqqY9m+wyqK1HQgUCxsg?=
 =?us-ascii?Q?0tToSm1W6E5bvr+s8ExO6Cy71wJtDbBl8Bwq0AeAHb3hSP+vTxqDOYnVIS3K?=
 =?us-ascii?Q?t3my79OcObMFKPmo3XaduBDt5MWslxi0yBjrDY6aAMBBjo85Y1sNEZeIJYA4?=
 =?us-ascii?Q?5HpGjhrO0Gw8+fq72h63CeldPhknEc26MU33Nxygx0Ha/HHI826kEx+puIKx?=
 =?us-ascii?Q?Hv4z+Yd9VX+/AiLy2Hz/GfdpAT/BPP2iqz2+Qtsw1hz0hMkTWlf+vzmG0bo6?=
 =?us-ascii?Q?uEMDZD4fsI9cKSDpCRU4foVipPn2ETzWMKIxq0ik7vuPeG2+Mz9mlvCsOcPP?=
 =?us-ascii?Q?lumTWzTLUwRrB12bQEKFioYJT+n8pFdqrNvGQ2f3jn3XvoppAsDxWGasYXD+?=
 =?us-ascii?Q?AAXs1vPD0bQeGWhoV4Wj8KwZRF2W2yQ3az2HwCVTCTXODnGlbkK4sUuqQ8zS?=
 =?us-ascii?Q?8i/mtnlx1L4E51mzw5F0qaVLu8L7y/fb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J2joDm+U6qIsHgAPSnVT1/YLnL/smRshD+mzImnjxNmKThq6OnH0xWBHDXzn?=
 =?us-ascii?Q?l5lPW2z6/gpjrGxDz/Q53vot41Y5CNHnKAmgb+vw6A6DY1P5gj9M9lJQ+6Pp?=
 =?us-ascii?Q?X8F+Ctm/rFIsZXDwMt9eNdzcUnmrpXrSd0aefkuXI25nTrxmuvyaJ84iyTZN?=
 =?us-ascii?Q?TMaSaji0ei1JGkJguXLTFuyD25xoifMA4JLtG8gApVxvw7JZAkawyL7ITE7d?=
 =?us-ascii?Q?mWBF3k6SMVv+9VztytW3VmsBg33W5VQ4p7cdbOndeVs+SyMjittpzOu6AmfL?=
 =?us-ascii?Q?M76IQ+mZR6N7aYrQhL66syv6AGAm5fhvVnxpIm7n+v0G4oTEt/ozk8+SP4fS?=
 =?us-ascii?Q?g0UGV2ffkF2nJMtFGRcrE1h6E/bqBzWblQG33HXam5K01AvwD2k6HbmVm5Qj?=
 =?us-ascii?Q?yCrjea5AMWcbmxvYrTO8VQcJZtsYVSMdxhZnqI5tvevJvb6oDZgyTI85ypH6?=
 =?us-ascii?Q?6P/sE0JaDNQeSL39TmFBHpyRdEzhDjL5KCRXv8JQApoakA2iUTsfTCKfOGkX?=
 =?us-ascii?Q?mB8b+iyZQrD4XJiPjorl34RSRcYT3ntUBREdxhoOIkH5SsfFxcfv4tGasn+Z?=
 =?us-ascii?Q?KKN96Tmao4kh7+6uW8oFypOqdLb7o4+lnFTWc87tIh0lV1VxdqQTYGRGf7oQ?=
 =?us-ascii?Q?JsSwj4HYDT0lTGT8nRIA9i+Bkdg6t8UipofQ4UNh5vkb4o5c6pcAZHslLTnE?=
 =?us-ascii?Q?opl4ETXhyUEcV+MH9z4O2XkMZgoN7Sfbn1Rie2LmBvrDTo60JY+ns/IDKHso?=
 =?us-ascii?Q?l0kGItzIBe6B7TRRjeb9ObYJLUDngHRA5Gcot+SMOvs/U2sf2zerc2CQQeZ5?=
 =?us-ascii?Q?0hsUaNtTcxSyBQNqTcX8flYFj0knOkvl5epuH1B6zHAmv3sShmQcCET3OzTz?=
 =?us-ascii?Q?Yi8+L90Hv8MhKF5nN46oreALNQp5lj6gRGCaVYJVo2cf8+KQOHHi642PBxek?=
 =?us-ascii?Q?cFMjg1G54Z0l3Yx/Qyr5uYnriGCiTSbce2/1KniNeUrENV62LnyBoPMtXBsn?=
 =?us-ascii?Q?415bOVm4q5BSR4dPza93ovOd9v2D/pCygL20fkreXFZUwZZRfFNsK4e0ZWlP?=
 =?us-ascii?Q?9ldDEWDMVzDR/vRElXIdGKvoGLmRO2c1dsDBvfhEGYUa2xwRSCZ6s3i9qYje?=
 =?us-ascii?Q?mZKdEdxiUu5DpxYgZmTkqIcdbRFIjlksq/mV9iB5WLWoSe5W0JLJFcqC6jH7?=
 =?us-ascii?Q?sMkVb/IB8PzT9Qj9QsEi42cpwvrc7+BNF2EoZNfmcOIHgY3w2SP9C2BZym7L?=
 =?us-ascii?Q?iQq2PUvw5xN7pxGDsj3huFQY9n4+6AoMnHNGQt78Df5nGFDtqLaL6humK4Yv?=
 =?us-ascii?Q?01Z2pOdjjo5xSjcJyEORWAyJATFhH7+H3DEKnnLveY1ex0AaWR5JQYgJRTOD?=
 =?us-ascii?Q?nsjO7bx5+9/2lxbhKwU6d5SMWxxPVIM6VtbPBCJyztD7vKaHSpTI1RBTTs9U?=
 =?us-ascii?Q?8exPFPAbfb43zitosAVMSAYTpmSjyBJdY/GMuTGRsSbCLC9eZYc1t/ck5A4A?=
 =?us-ascii?Q?SHvc0i+maCkJCVOsH0OzPOXBQWl4urVVUcBKdbxlOCBJMUC57TlPCKhFw+N+?=
 =?us-ascii?Q?P2gPpQ7osVQQ+TVtbHYVT2kEq7r2Y6lS4aidUCbb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14af837-de23-46b2-3bf0-08dd7e938741
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:25.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqX9jvQVflzWivUGdbXQRJ/2R1XuyqB7KiNxAA7aqg1XDnOoISa5uPJ5E6UTE51/dR/bOW3d6fiZLHMoG6tWRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_torture_one_read() function is designed for RCU readers that are
confined to a task, such that a single thread of control extends from the
beginning of a given RCU read-side critical section to its end.  This does
not suffice for things like srcu_down_read() and srcu_up_read(), where
the critical section might start at task level and end in a timer handler.

This commit therefore creates separate init_rcu_torture_one_read_state(),
rcu_torture_one_read_start(), and rcu_torture_one_read_end() functions,
along with a rcu_torture_one_read_state structure to coordinate their
actions.  These will be used to create tests for srcu_down_read()
and friends.

One caution:  The caller to rcu_torture_one_read_start() must enter the
initial read-side critical section prior to the call.  This enables use
of non-standard primitives such as srcu_down_read() while still using
the same validation code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 124 ++++++++++++++++++++++++++--------------
 1 file changed, 81 insertions(+), 43 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4fa7772be183..ae7b68043150 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2164,53 +2164,70 @@ rcutorture_loop_extend(int *readstate, bool insoftirq, struct torture_random_sta
 	return &rtrsp[j];
 }
 
-/*
- * Do one read-side critical section, returning false if there was
- * no data to read.  Can be invoked both from process context and
- * from a timer handler.
- */
-static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
-{
-	bool checkpolling = !(torture_random(trsp) & 0xfff);
+struct rcu_torture_one_read_state {
+	bool checkpolling;
 	unsigned long cookie;
 	struct rcu_gp_oldstate cookie_full;
-	int i;
 	unsigned long started;
-	unsigned long completed;
-	int newstate;
 	struct rcu_torture *p;
-	int pipe_count;
-	bool preempted = false;
-	int readstate = 0;
-	struct rt_read_seg rtseg[RCUTORTURE_RDR_MAX_SEGS] = { { 0 } };
-	struct rt_read_seg *rtrsp = &rtseg[0];
-	struct rt_read_seg *rtrsp1;
+	int readstate;
+	struct rt_read_seg rtseg[RCUTORTURE_RDR_MAX_SEGS];
+	struct rt_read_seg *rtrsp;
 	unsigned long long ts;
+};
 
-	WARN_ON_ONCE(!rcu_is_watching());
-	newstate = rcutorture_extend_mask(readstate, trsp);
-	rcutorture_one_extend(&readstate, newstate, myid < 0, trsp, rtrsp++);
-	if (checkpolling) {
+static void init_rcu_torture_one_read_state(struct rcu_torture_one_read_state *rtorsp,
+					    struct torture_random_state *trsp)
+{
+	memset(rtorsp, 0, sizeof(*rtorsp));
+	rtorsp->checkpolling = !(torture_random(trsp) & 0xfff);
+	rtorsp->rtrsp = &rtorsp->rtseg[0];
+}
+
+/*
+ * Set up the first segment of a series of overlapping read-side
+ * critical sections.  The caller must have actually initiated the
+ * outermost read-side critical section.
+ */
+static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp,
+				       struct torture_random_state *trsp, long myid)
+{
+	if (rtorsp->checkpolling) {
 		if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-			cookie = cur_ops->get_gp_state();
+			rtorsp->cookie = cur_ops->get_gp_state();
 		if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
-			cur_ops->get_gp_state_full(&cookie_full);
+			cur_ops->get_gp_state_full(&rtorsp->cookie_full);
 	}
-	started = cur_ops->get_gp_seq();
-	ts = rcu_trace_clock_local();
-	p = rcu_dereference_check(rcu_torture_current,
+	rtorsp->started = cur_ops->get_gp_seq();
+	rtorsp->ts = rcu_trace_clock_local();
+	rtorsp->p = rcu_dereference_check(rcu_torture_current,
 				  !cur_ops->readlock_held || cur_ops->readlock_held());
-	if (p == NULL) {
+	if (rtorsp->p == NULL) {
 		/* Wait for rcu_torture_writer to get underway */
-		rcutorture_one_extend(&readstate, 0, myid < 0, trsp, rtrsp);
+		rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
 		return false;
 	}
-	if (p->rtort_mbtest == 0)
+	if (rtorsp->p->rtort_mbtest == 0)
 		atomic_inc(&n_rcu_torture_mberror);
-	rcu_torture_reader_do_mbchk(myid, p, trsp);
-	rtrsp = rcutorture_loop_extend(&readstate, myid < 0, trsp, rtrsp);
+	rcu_torture_reader_do_mbchk(myid, rtorsp->p, trsp);
+	return true;
+}
+
+/*
+ * Complete the last segment of a series of overlapping read-side
+ * critical sections and check for errors.
+ */
+static void rcu_torture_one_read_end(struct rcu_torture_one_read_state *rtorsp,
+				     struct torture_random_state *trsp, long myid)
+{
+	int i;
+	unsigned long completed;
+	int pipe_count;
+	bool preempted = false;
+	struct rt_read_seg *rtrsp1;
+
 	preempt_disable();
-	pipe_count = READ_ONCE(p->rtort_pipe_count);
+	pipe_count = READ_ONCE(rtorsp->p->rtort_pipe_count);
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
 		// Should not happen in a correct RCU implementation,
 		// happens quite often for torture_type=busted.
@@ -2218,28 +2235,28 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	}
 	completed = cur_ops->get_gp_seq();
 	if (pipe_count > 1) {
-		do_trace_rcu_torture_read(cur_ops->name, &p->rtort_rcu,
-					  ts, started, completed);
+		do_trace_rcu_torture_read(cur_ops->name, &rtorsp->p->rtort_rcu,
+					  rtorsp->ts, rtorsp->started, completed);
 		rcu_ftrace_dump(DUMP_ALL);
 	}
 	__this_cpu_inc(rcu_torture_count[pipe_count]);
-	completed = rcutorture_seq_diff(completed, started);
+	completed = rcutorture_seq_diff(completed, rtorsp->started);
 	if (completed > RCU_TORTURE_PIPE_LEN) {
 		/* Should not happen, but... */
 		completed = RCU_TORTURE_PIPE_LEN;
 	}
 	__this_cpu_inc(rcu_torture_batch[completed]);
 	preempt_enable();
-	if (checkpolling) {
+	if (rtorsp->checkpolling) {
 		if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-			WARN_ONCE(cur_ops->poll_gp_state(cookie),
+			WARN_ONCE(cur_ops->poll_gp_state(rtorsp->cookie),
 				  "%s: Cookie check 2 failed %s(%d) %lu->%lu\n",
 				  __func__,
 				  rcu_torture_writer_state_getname(),
 				  rcu_torture_writer_state,
-				  cookie, cur_ops->get_gp_state());
+				  rtorsp->cookie, cur_ops->get_gp_state());
 		if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
-			WARN_ONCE(cur_ops->poll_gp_state_full(&cookie_full),
+			WARN_ONCE(cur_ops->poll_gp_state_full(&rtorsp->cookie_full),
 				  "%s: Cookie check 6 failed %s(%d) online %*pbl\n",
 				  __func__,
 				  rcu_torture_writer_state_getname(),
@@ -2248,21 +2265,42 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	}
 	if (cur_ops->reader_blocked)
 		preempted = cur_ops->reader_blocked();
-	rcutorture_one_extend(&readstate, 0, myid < 0, trsp, rtrsp);
-	WARN_ON_ONCE(readstate);
+	rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
+	WARN_ON_ONCE(rtorsp->readstate);
 	// This next splat is expected behavior if leakpointer, especially
 	// for CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels.
-	WARN_ON_ONCE(leakpointer && READ_ONCE(p->rtort_pipe_count) > 1);
+	WARN_ON_ONCE(leakpointer && READ_ONCE(rtorsp->p->rtort_pipe_count) > 1);
 
 	/* If error or close call, record the sequence of reader protections. */
 	if ((pipe_count > 1 || completed > 1) && !xchg(&err_segs_recorded, 1)) {
 		i = 0;
-		for (rtrsp1 = &rtseg[0]; rtrsp1 < rtrsp; rtrsp1++)
+		for (rtrsp1 = &rtorsp->rtseg[0]; rtrsp1 < rtorsp->rtrsp; rtrsp1++)
 			err_segs[i++] = *rtrsp1;
 		rt_read_nsegs = i;
 		rt_read_preempted = preempted;
 	}
+}
 
+/*
+ * Do one read-side critical section, returning false if there was
+ * no data to read.  Can be invoked both from process context and
+ * from a timer handler.
+ */
+static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
+{
+	int newstate;
+	struct rcu_torture_one_read_state rtors;
+
+	WARN_ON_ONCE(!rcu_is_watching());
+	init_rcu_torture_one_read_state(&rtors, trsp);
+	newstate = rcutorture_extend_mask(rtors.readstate, trsp);
+	rcutorture_one_extend(&rtors.readstate, newstate, myid < 0, trsp, rtors.rtrsp++);
+	if (!rcu_torture_one_read_start(&rtors, trsp, myid)) {
+		rcutorture_one_extend(&rtors.readstate, 0, myid < 0, trsp, rtors.rtrsp);
+		return false;
+	}
+	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, myid < 0, trsp, rtors.rtrsp);
+	rcu_torture_one_read_end(&rtors, trsp, myid);
 	return true;
 }
 
-- 
2.43.0

