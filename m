Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013060.outbound.protection.outlook.com [40.93.196.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76944306B21;
	Wed, 14 Jan 2026 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411954; cv=fail; b=kBhFcIbBn4PRnAccp40KCjLeJEU66YflDtTwcHxZ7TATmVcez5OURRujJq1Z5QCBSfWb5KzQF0MbpR2XWsVwVZARSuOY7Nup/o2NwRYZHEoWnYzfhRyr0jmLzP7UCAAgF9pdmZVSHMol0+92eQTG/nj8X4HhMAFqvQNaxuVH1G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411954; c=relaxed/simple;
	bh=t2K520uQsy9EEChzqMeLS/UOZviYwslp7z3zsH9MfDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=md7htT3zMX93woAbqmAamyGBqGPQfU996gBWuYenJSg1kGwgaXGSF/RCoV75VhA46EM8Mq5yx2GXpqp6fT3M/EeYpPDvnKu3YXZozkubHFSGLJ0HBrhZff4DzF1a0o6PorlHB3cHGIQXVPALkcDZysIqfjcVga/zC0ATsyqaZeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TqwH/qfc; arc=fail smtp.client-ip=40.93.196.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TqwH/qfc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRVd/SXOrBxrsTl1NfapnZzTLOiBULJrEZPY3akItVFjzuD3ll6iYvBfTh8+NQzl0/b4z4zj0RJfgmjnEHY4O1VKqNuswRhmO72km9jJNd95J9kEaijvE50khjjIWa/Z9qxUZMNvIktlCDlFA4Ai+KEe29A2RCnLrYrQfWzASpd2APl9fla30RzAkjKpWhKSzYRq9/PRXgvhjfAVGnfzKOb1Y795tB5vmuoSYCsFsMcIQJWOlobs4uZQSmFonm2ifXr4rJla1GBnjTALfEWngtRd6XTOqGvRIRIkPLJv55X/gluEHch62YXyZ5jMMrCpiFMcjBZTt1tBFHrmHzVf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4M6NjZwksnpbjg7xJAx8XHx+GFmOIQg7c5NQ+0YNjJs=;
 b=ahvC8fFrVq919EbjUBEAyzl7Hv3O9uCxSXXo+aYmAbJiskMrijgTAgVvPvpaLjrM7nzaIaYkMbGyhTYQaps4AJXRiZolhPhZhZWtRpVEs466/UMXXDavP30DNx1PDJC8MTwg6Xszy8qUbv1hq5ckmR9WTbbR3U+OqL4QkIEkmUudBOogQ8usdRgp8QniB7hkfiuwYA6NjDLYH4HCNGwd+Zcx+NErt+jg+nl9nGG5vxxWVmKgaHkG/Egu22xCVXBhJ5b6iRH1gRirZJ0L1rPeb8orUuI37DLtCMq3OVZts3SvaDGFn5GOfAQGsVJzGJ05p9rLo97TZS9+j6I67BtThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M6NjZwksnpbjg7xJAx8XHx+GFmOIQg7c5NQ+0YNjJs=;
 b=TqwH/qfcr+KUOYBfaqNOEJlMgqy6bG/IsUCZLG9XIFdwdA6u67ZBsgeUc1ZggPmfuhBeFtezVnIGRv6kjqaJp3b6z2o7R1cEZv5GtAdtHHHPxTzrHXFb7NcbzuFEPCoVLjOT7Z+9rUcNA3qnwHtk27wN0zUrmfuL0a9kjQ5HXLGXElBzSEN9p+97uMJnNjZgTLwdG2Su/UMGFX69OwRbUXUaQOieb9ufuNbzA7DiY+IXjiz/L0YsYb93/G6zaWuP4dZRbozSPvmJyNTpGuzxEPFf3mkqRrfaTptMqwq8++8eBfZSNbVeISWrYKQRSmFWnQlysEWEQd67vDsvI44Diw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by LV2PR12MB999096.namprd12.prod.outlook.com (2603:10b6:408:353::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 17:32:23 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::f071:99a4:121:353a]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::f071:99a4:121:353a%6]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 17:32:23 +0000
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
Subject: [PATCH -next v2 4/4] rcu/nocb: Extract nocb_defer_wakeup_cancel() helper
Date: Wed, 14 Jan 2026 12:31:54 -0500
Message-Id: <20260114173154.1701056-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114173154.1701056-1-joelagnelf@nvidia.com>
References: <20260114173154.1701056-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::13) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|LV2PR12MB999096:EE_
X-MS-Office365-Filtering-Correlation-Id: c98d9fbc-a9ed-463e-b684-08de5392e097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rfh74CP78L6Yw+do4FHtluMKlme6G/c6g/l0LnKObr34jtjkkDieiiE+EMPB?=
 =?us-ascii?Q?GRqMH/Q6G8X8bv9efIR5pCtKbeONCo3mxVx8pDo5FlzwlM0vc1baielw5u53?=
 =?us-ascii?Q?+hVmVEfzzkP+Befhe7UK8Hat1EuMwB+SBpLrJ5jVXo5jt27s9397PPbhxAGl?=
 =?us-ascii?Q?jrgVwp7EDeGHgrbx0H+eQ6PDDR8ORfkizHWJMfM701bgBEjNhcfGJc2FmEjH?=
 =?us-ascii?Q?ZzORkxSnOTOvr0+miWR3XzKKhj7KL/pHD7KvUncLa7IFTn1IGKAEr/Q9EAaI?=
 =?us-ascii?Q?fDiNSV+7bCREnMdXkbMnMkCTbZNgFjf0vAlTN5O4z0n/yYSlx/ooDcjOJWNc?=
 =?us-ascii?Q?L5tcC5I71oBNySwFFQoUAQpek5G9UsavEgoRSLzl6/3Of9YATwhqrw5HkY43?=
 =?us-ascii?Q?e2Brx5ujJ916H4N3WjuhUBgrr9awAyeyL4EtY69KV89lFNvN/8SCG/YZQebi?=
 =?us-ascii?Q?85EeweK9HKGs2Yx+2EIGRRpNicQh0UaPgPhzzYAGrHv/XQMMphjm1SDH5VMd?=
 =?us-ascii?Q?yiGDV70AAz9+jfUl2h756xRi0XAPEbhWFD+TKLCdAmumqB/iwodbMSkImtmz?=
 =?us-ascii?Q?4enEi9HBDidzw8QLrZpMLRoV0BCNDX4zEJ+BCEJBdPc+/vYh/Tpdb74mz4RF?=
 =?us-ascii?Q?j+OL4IPu6AtDyukgWBpKY0vYPRvUL7NjO5+PABvpJEo5/K5GBtSlfW5jciLP?=
 =?us-ascii?Q?emy9uDNLEKUHI2sbFQKPCjTY656IM4tApcQpa7P/dWGjKdZvaZQwHOfSvvS8?=
 =?us-ascii?Q?lBKNSCPt+xBGSdU5pM/iOZqJ/qxj64h5qAhTx8DJA9aMCtBMxWHycdJ4FJwz?=
 =?us-ascii?Q?Yo6dQzYXThVLwcVMADF7SRnB8tmC7eBse+fYjJ4Gus+9UR+QVs1eAAZO7j0P?=
 =?us-ascii?Q?KchvHGMgHcXBb17HzP+3u+ylq0RBKMbo1IzGldT1CdSfcAogNeiFfRIMBtYK?=
 =?us-ascii?Q?t0fMfoAmBIgUu8CRVDo2DRjSMhabBKvhT+e01J8L+fUVfEOUyCErJ7A1UKT0?=
 =?us-ascii?Q?SgWGM6T1MRnQE8yLfkBpOZ98zviyWUC4sLQcrC8T2fvJo24YozTkI1IOr6m+?=
 =?us-ascii?Q?rtuawElZ3XPc2KSGrGYa3aw9QLZXSKRDQ4q6rY+4KEYj5vk3LF4bnkrlbEcE?=
 =?us-ascii?Q?hG02VBgPM7z8AqL2gtoICbLpnW+hWwp/tjnfkvwReIxmy4MJnB8WK78ZQPcy?=
 =?us-ascii?Q?EFYSWpeGDnXMU3yXTgvo80zU3tLh6ED+WhVQln4MPdI5uPTwFiPqDmt49HqK?=
 =?us-ascii?Q?0lzdrYi1SXLF2q8RIep1GRVpvJpZp+K5qWzkmHv8yVj1XPunotK1HQOndAII?=
 =?us-ascii?Q?hbgimh1NAIoZzOlwA8WvRd44oCuICo5o6x/HhcLBdU+tldjk8CwUK5fWYso9?=
 =?us-ascii?Q?zYkWmuAuZkU2QpRqPC7S6jJufwUbXdmQD/TXfvLAQP7e+s+9IFINzMzvAbw+?=
 =?us-ascii?Q?c8ehntEyJ8P3bKLJoO8xpS5iBHsoWaRYGlc81vAg7JzemNLRxXIxKQFENH8T?=
 =?us-ascii?Q?96UBj02fA5rrkg9b2pR7bN0Z36l6pJGDPRTnUBdr0PIOaWRxMs5XBTMfHvhg?=
 =?us-ascii?Q?H4/sm8w83zECu/UFxPY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bhmhRQnpGi7eTZtwWD66B/zdTKiksQTX+hEAVepVSMtbUhS4l6xEXsxcQ+tr?=
 =?us-ascii?Q?b+pBYPKdpGNJgSSaZRIAu7ktlpyX/JMYuFzsUBSeMhgxTL3ku0rH4Sslz82g?=
 =?us-ascii?Q?wx2SXaDfUT8qMtTeW/DMicis2hLVwu23+ZXjV/tBZxcoSAw6MLg1fBBIQd5K?=
 =?us-ascii?Q?+KXr19V2SgGnXkdRcRZ2wPqqf2lx3+PKY1sGIgQRz2yUwyGTKNmwSSQRYtlk?=
 =?us-ascii?Q?PuI06bMJb89ONuRQCCaDM3c3DwWf3yyHlztIxPiw4W+gU6xGzxvR4CIeXg2P?=
 =?us-ascii?Q?5svXW+9UDnVkau2BVK1bBRmiktn9Dp+yH+TpKLHSWJ6lR/DC8CIyIxcZM8Qm?=
 =?us-ascii?Q?EHZybC8NfUiUQMqnCsasUyss5X6XtXIhgIHuIUJTnafOn8ZMjAX7K+SBzZGc?=
 =?us-ascii?Q?zE4zpnMigo1NA6m+73tsJ5ednG5NmksyhSI50F9DCg8bkFrqOBiVSgK4/iqh?=
 =?us-ascii?Q?nyJ96cJ8bb6DFqiegb4nEe7GAs0n7bUT6vNNr1D4a/oG4ASG5uo2ZsHhBlOF?=
 =?us-ascii?Q?iAVA3MzwgA5K9YAJl12em3re9zCJXsSf6vhAuTRRre19KM2SHkf3eCptBlKN?=
 =?us-ascii?Q?GA0KL6+z2VfFM1KZxOYYl9F4RDlb0uvX8cYGACoFOv/aTZ5fb599/E9ltbpv?=
 =?us-ascii?Q?TJw7k5K6tmtYojAcPYzJLicBi+wAIDlP1axpkHmUa25wTUy5H1vlHD0SEDse?=
 =?us-ascii?Q?z9cmfI08Yl2pUOxAuPnuIykjeEXonI+VWNQjCtNfdNTUkriHtOsvaE5jJtJw?=
 =?us-ascii?Q?ZTWTh4oKAfX+/+E6ZMQveMQ03bP4zQDQHB2x7Ma//ICJNI9ZIJkYLl31Bxzq?=
 =?us-ascii?Q?FWYj7hFjOlfGAs0zFEDXJlHNTOMySbRdvrk9cLgPio4+3MJ0w1OfKCRcPvZA?=
 =?us-ascii?Q?Ea+NcZjvjtBmYo3kcAyWq+WZ73CH7c1T0O2SDKUgcjrCAcmzeYXt16vRSgZX?=
 =?us-ascii?Q?th6m0WTW4tFkgp/RoYHQ3XhxaDcebTu85P3mcq3q/k2S0CWWoiQflZUhK4xN?=
 =?us-ascii?Q?CmeHJD2bnhO46a8RAfLrUEJajRCbkwh5kaxi/4RtZHJ/6pnplMYSmXQv9ut6?=
 =?us-ascii?Q?jYc6flke2noEfDbSHm1XbX5mrVBRgyLFBtP9gPQYGGxdnO5FLLxa3oQtW6tZ?=
 =?us-ascii?Q?Zy4FcsNmFyKk5r7lYOtxGMa3/xUhrAPPzUaYcHBbs774K7DOQKEfrsfKQH+M?=
 =?us-ascii?Q?bXTGkmTmNC0PQ6kre69LRL9I9UBGcJCGujkwDkm5rT8MM1Qu/EtRNPDAFbqZ?=
 =?us-ascii?Q?ncBcaUyRyi5xYAqFsfq/hv5C4fHX3xy0mRsImHANtAo2J/98xDPOi2oxB5AO?=
 =?us-ascii?Q?Vrp9fHYDtQ83edCxPhxNaHpbXdjkMFJEznEYyqXVFcKYGmAsIuRH/wR+Cqka?=
 =?us-ascii?Q?vPaUoGmLkeKcHcyV2cCJeK02lEL2CcUDiXa7NvpaLnKEw+wPewebD9KxWnIV?=
 =?us-ascii?Q?pSLP5ccO21TWqEDrX5q7tR1LnmaU7WRnOnLWu7Q3xrr2vTtaYHr5yghe5Ked?=
 =?us-ascii?Q?sCqcrdeL7pOG64bVLcYx4rDGV87WkRQK0P7H34FHOm480Gosm5ZXNKVRyq/n?=
 =?us-ascii?Q?Im1j7LsKChgDQY+5ltdNerICM2fh0/9Irika0a0BHMnbQf7lTCQhXuJg+RLn?=
 =?us-ascii?Q?o5Z/JfwBHwxj5Q7DkMqpEeiNkConJCpZ0dvtCMgOcTMNHgYlWr7NTBz+SXeQ?=
 =?us-ascii?Q?XgXH6wZNDRVhkMEJqY97HxCc/0riD3epqEoBHRdSiMDfv+7cSbL70hYbL9cO?=
 =?us-ascii?Q?VRsd+dDOfA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98d9fbc-a9ed-463e-b684-08de5392e097
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:32:23.2213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYVZ+v94JHM9W8lVgVb7Zc0wGtYMOZq06UXqeDudQbc5sSPg9h9+PHGHKytTYUWrmG/Y2VDlEtxebg2+DGHIJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999096

The pattern of checking nocb_defer_wakeup and deleting the timer is
duplicated in __wake_nocb_gp() and nocb_gp_wait(). Extract this into a
common helper function nocb_defer_wakeup_cancel().

This removes code duplication and makes it easier to maintain.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 702ede003dce..df49c2fa79c5 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -190,6 +190,15 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 	init_swait_queue_head(&rnp->nocb_gp_wq[1]);
 }
 
+/* Clear any pending deferred wakeup timer (nocb_gp_lock must be held). */
+static void nocb_defer_wakeup_cancel(struct rcu_data *rdp_gp)
+{
+	if (rdp_gp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
+		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
+		timer_delete(&rdp_gp->nocb_timer);
+	}
+}
+
 static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 			   struct rcu_data *rdp,
 			   unsigned long flags)
@@ -204,10 +213,7 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 		return false;
 	}
 
-	if (rdp_gp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
-		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-		timer_delete(&rdp_gp->nocb_timer);
-	}
+	nocb_defer_wakeup_cancel(rdp_gp);
 
 	if (READ_ONCE(rdp_gp->nocb_gp_sleep)) {
 		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
@@ -820,10 +826,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		if (rdp_toggling)
 			my_rdp->nocb_toggling_rdp = NULL;
 
-		if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
-			WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-			timer_delete(&my_rdp->nocb_timer);
-		}
+		nocb_defer_wakeup_cancel(my_rdp);
 		WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
 		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
 	} else {
-- 
2.34.1

