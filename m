Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9852E1C61;
	Tue,  8 Jul 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984579; cv=fail; b=aW8m9LtUI3QrHGYZL39mzjUj9QX3iPEHc20Tkhm3dWN7Tt4sPDOsvyoMCpJKuGj18V9yNWgtKKjf4NIE2LKfrypl9TyJd0fQfW6kyBWCid7idPddm9kGkyaodBah/ZgATkUpEPtou/i/lfWwL235OfMASzkajsvAnkfzeN/eMO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984579; c=relaxed/simple;
	bh=1JUPYLK6XbqAR6c+cY67AOebEkfVQsLhjClVGgh4i7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7bwJS5xfFkUkcqv1ifCPVDeCTzMmoteu448jws3JPodUS1ulHYM2U9igSMvTWbaautRaohwVNi7XloLH4bs5rJm9AuJ00h7oZOxOTu4+KP9W5lyV27I7a0AQcgLEJiUsPHu3cvtx3xkZxWmcJ4anJVHaS0m5oY+4OEwnBAva/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g56HNlrc; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g56HNlrc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcKA1ac4U677rm4l2mRaf3vB8wxpkYFQO7ZVPZBlq3C/XwZHygOYK02gkaHsyYIqPIqqzG9x9EfYIorA1KItAdjWpx3PmEA8D8FZFCO1ma4CT97equYRCkuRB05cA76JAhbJNyubYXHO+BFYyflg4u/zQSY54zhQYAQILEIBumJnsmPa66Yt+EKLoVXuQICIDly+NibulixGtdi/lrz/J9u0FeUOgOSIHjqzLjVr3XJypoRzMMo2bN0dQoizfsGVMwiXr53DT0rIg8RqUFp3omDmBgofwr9d+U9NngO/A95YdowgO7ZplPtzGGpwaYdeX3OY4tJ+xhtQ4p3hFBHJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09WuVo2+q/xz1Xph9sqzGzSlxoXZMQydk/BJPm9rizA=;
 b=R3TOrh0z8ViCtv1ENd2A7xRELnS5kW/GK7DIgGBoGMD3GhZc29/7zKKaUqakma+mGycNXMjNCdK7A5zczm0H+llGjPX6E2khuVVJBZUZQz9+rw4svjhEa3MUD7GvHipgiUqPOvwJSQfzKmzntsxVwdp5PIGTDOb1tQq7vef5Lkt4+UHy2v2q/0shQecvxIYGO4L6DUzhGB8W997/6W7GAHpeHAD9de80UE3ohzYWqJD2RRM3o6tU88MjJaIUY2wg98HePsmj5FfiRYgb19Tc7gHM/6gyaspqg0q3gpuOG6pHUfBQPymjtb3iwX+XByfV6A+KU3T4fZCjHdeLG1T7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09WuVo2+q/xz1Xph9sqzGzSlxoXZMQydk/BJPm9rizA=;
 b=g56HNlrcgaP9AO3KiqzHfW1yf+VlZhDt7LSrdNXP6MEARimyFbhzFtx9BaetMArpooSLfnov3WFa1Femy/ZhW2zC18OXmqKsNjKo8Lwo7lY/q4gESd7gS4qlwBO1ff+H2R+P6W4u0vHd2nq/G8yqLgNyu4gVVZg+bbZDAOLzLjNdT83YhHJUcYj9Tjv40zqnUPxZyWx8/0BtkjVA9OSiTNdtkekAwoGd6Gth4LEDysG2l44lE8t8vbJwd50I8aoHtTt+T4rRMsBBYxM6YH2plGzbTywh4Nj31hfC7/rk9CXBB2Mhws2fGkibqmkZ5kErb/ndE7Mzw3IMr/KuUsB4iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 14:22:54 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 8 Jul 2025
 14:22:54 +0000
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
Subject: [PATCH -rcu -next 7/7] rcu: Document concurrent quiescent state reporting for offline CPUs
Date: Tue,  8 Jul 2025 10:22:24 -0400
Message-Id: <20250708142224.3940851-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708142224.3940851-1-joelagnelf@nvidia.com>
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::9) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: ae79752c-af21-4c03-d6b0-08ddbe2aedbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lwLN9D7QBzT8kIJBkoQb6l/HuTJSuOaTrD9FCITcA6c3fTZuy9yngoAOH3Fw?=
 =?us-ascii?Q?p23k06oZAfjqteYmTdQAPklNE0iAdcX2NpRL6FB9DB6W2WURiXxhypgoxS69?=
 =?us-ascii?Q?nVxcZl1aHEki8Zf4Lqi42pFbRWv0+xxEck9Cm+7YOvKgjXOdnNxeKs57gB8q?=
 =?us-ascii?Q?y7phHtS9pO99/BkLWSPCrs9JjSHmiYGCdwARvPjabfYgJcmhQpDUqN477DVe?=
 =?us-ascii?Q?x2gd5Ak9cnSpcVXdWEKHW5IjZZnZO7GtBgXeQEMAxeZDjwddWhC0geIGohLz?=
 =?us-ascii?Q?9zN8hhpFMlQdyriFzTCpqqr0Nx7eEm9UqT4ds1uUrgPt7LgjmXqrzSl97AoQ?=
 =?us-ascii?Q?62mBMcCimMxOYyX9Edqu1KguRpBZFcWOQvFiZc1LC5Y6VaSK4alHlGAUFmpw?=
 =?us-ascii?Q?cuhXrHX71LbXkDXGVR7pzXEHJBn6r7sgZJGGsVtfwNYxEDAQyVFrXGVNut3B?=
 =?us-ascii?Q?k46+SR0xdQVYAH1yg5v/6p65O6d3JG/nQJp2/t5XBQr9RZ9Xnoyii9GJyzU5?=
 =?us-ascii?Q?NyUBcJJmaaORzef7jgyCVtUBtj9GtU6i9k5Y865H3uRBBN5Aa5oz5KAfGXEf?=
 =?us-ascii?Q?DIJx4wtfOkA4sXv5H/DXr3VTbcJbq7eW9fmKLinbDlA4u2dg6xcKWO16VfjV?=
 =?us-ascii?Q?tE0siuJILIEPQH/1K3M3ArUfi0xfHfV3+24m0WxsGA2ikJeT9TY264VNtFYF?=
 =?us-ascii?Q?npIEMQW/jeM/gxQnsJjfAdBTZaRhSgyDgHYtgnSBOHwR98j/hKs7LA8opYeC?=
 =?us-ascii?Q?cBrJKnZc+6I/rsFjx+YW5qeSUVvsQuwpvQc6to8Q/iRw52CJivVKLF8Fu673?=
 =?us-ascii?Q?vgfCMNJofC+xdwajW/OiHdWk48IQ2VVJXtIaz9KEts6G2Fa3NMDwQuoR5TWC?=
 =?us-ascii?Q?hP4gibKK9dqjK+o3doMa6nfkFaLseohDzH2584D9KpelYx3ycvSaZcekXKgU?=
 =?us-ascii?Q?58UtyWmFeOOtqAyKoAd6YGOqUXXKoJlCYw5QIOWECKTuO2etIqI2CiRco73I?=
 =?us-ascii?Q?7K4nejlZHhPPE1M1n2hm1ce0UIN1J0eoPl6dqaX8j2INVzeKlGu6Fk6qmYQn?=
 =?us-ascii?Q?rObltk0PlyZsDZ4qQAFAO3Jz0eoFyfQYAxIIe9mD5tUqC0/RZCKeXnm4NcOE?=
 =?us-ascii?Q?mnI+SrCKp/j1NY6UuCbOYGckjIf1HVT30KclhPi54IxGuF+YdLr0wVB1MAYH?=
 =?us-ascii?Q?JyDnBULzN90b9wO8E1Aeosiygg71IyC9KRAWaGpVbfstXzaeh8WgHEE2Km41?=
 =?us-ascii?Q?7fp4Fsjlvhuc1YAzTTKesEbyTKDDdRFfErk3PqDnmTIn/9Tso89PQB8Mjlkw?=
 =?us-ascii?Q?X3yW6Qpru2DIWD6bYFqHGEHu36xqNwq5NGBBqRhzdxbvZN/+7y78JVD2YsJq?=
 =?us-ascii?Q?gQUhyVYjy6pkfmiH0WgwllRxtwQzW8+CXnU1tBPgqwxFwAQWMWSl8pDQaJXT?=
 =?us-ascii?Q?fR0zXGOXZcFRC1Qxp3Vh80Zp7k3XcopmLRErHYOodmTF+ogOAUa4MQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HNF72vvTLR25sqsND6WHRSgtYcDh10fpWTOeW2WOINLr7VgUtP3bwQOideM8?=
 =?us-ascii?Q?UWD+ZHULSm3YPag098qgzPMpNazN8ZhOTwAtddyVnkHkUVJQfJziTJlcaiK8?=
 =?us-ascii?Q?vrsQLGXoRzBFnyua2Tay5Nz4LzI7oawcwMfPC0Yi4l/eLpzjYQvLOACQERyS?=
 =?us-ascii?Q?Tys2QvRiD/E8YW1amzv814P4sTNoiC1tvFNDEwwTMu+JpugyMTNeLqy5yNSy?=
 =?us-ascii?Q?IKkneHc9Z88rpctjvWJbdm5a3fTcS50OOgFweDPCI4wPBLomgg5UrVrRJza8?=
 =?us-ascii?Q?+Mom2DYtN1/r7y5HaPhaM2CXneirDj9cgowHBOE8m/L/LU20XlvBbysIsgmh?=
 =?us-ascii?Q?rezGCLS/85zcMxf4MrzBuXJL/UVF2zWHVGMIsdDtFCiWhQZVu/r/FxuvIccH?=
 =?us-ascii?Q?jdLki41rLaLwz+x3pGhmhqwtc7pqQxVnO5rG4ZU7uyLEFQNSnVJ1A6bqUZlR?=
 =?us-ascii?Q?iHWDmv799HYN3vblWvnOgkJV5qDaFHtvciPss8cUs5AUo6zHb+YC+vovsR7I?=
 =?us-ascii?Q?q1gsfHJjf7BnpXORiodDWTv39pfLElrpq7IrfVDqofstO3AZP3AQRsUmRT7a?=
 =?us-ascii?Q?mlGIG7MlyJhE5764Al6zS82nWbain0Aw3xK1I1OnbOl/n54nfVFRPznJ5mO1?=
 =?us-ascii?Q?JvFjyreDOjBKdOSqi1l9/nNQkmhk53cyW+euGcHcME3d3NCnn8V9YW1EHEga?=
 =?us-ascii?Q?jAhbXXwWnve/IxCWMMPPdHCSgrZyCkFNnpSvxNK9mivNVzzzkOHEZ9eN6Ms3?=
 =?us-ascii?Q?d5bCbDoRGAvLQSf32fwTxJ73RuNugMvUAtGC4/9wzwm456RQ6I435hOxexYV?=
 =?us-ascii?Q?8LlFWF8tH8LImCD/2HrblhkMTviEWQWF0yypCA55dJnyti5LS455h5KQb3hg?=
 =?us-ascii?Q?UEGpua7Y98p3c1MMa+ClxAtuX9w5QWqdhqFJUStNoQVe543RCytej938zejw?=
 =?us-ascii?Q?L1io51ev9Rk6ClACGeN1k9asYLjzY/rOQ92PSSEY4v1tP1SVRYqYZd1TpGhk?=
 =?us-ascii?Q?LRWDQVHBPexOQppcXKBWEvuw5+ZQUongOmzWeKPcQvFk74yPWJt3oGWZOUeu?=
 =?us-ascii?Q?s9Di/IhFN0bmpKnrnSXdOUKl6URd7weacoHKOb/V9+76PS/AxOmnV6CAc+d9?=
 =?us-ascii?Q?yTSBN3Rj4Kk68IT5lEVwbuoLHSTdkuGVFZCVC7Q9YDWo34g3bth11MzHn6lV?=
 =?us-ascii?Q?0s4p0aJWLuVcAk/aqdAWp/Z+HGHH7l9ENPPTYriW1/S7L01D3otFMMdFGDwh?=
 =?us-ascii?Q?D5BlLCLW7KkLwnaT90peUc+qmurZfG3UaBquHQPSiiPPR5FlWYpIaev9CaB1?=
 =?us-ascii?Q?TD7oRJRnOqsElpLXTNyRKjzABKAHnxCXrRQ14NFuCwOf9o6ccW4FeZbWW2lr?=
 =?us-ascii?Q?nrbcMoH8yBbO6Eoz1shiPBvVisa3bQLvkPvox7VyW9pxhPhf69bO4oo05k4i?=
 =?us-ascii?Q?RolB8aT3wDaxMlLrxBXf+lnoOJBeNZuse3qAfK9LNo7AdMt0l6MFe1E6WlP6?=
 =?us-ascii?Q?OY4LcX6LlySfb7Z94FeanXtpFW72pvI4niwTTt294+IdrnhgzViBDkhmx7G1?=
 =?us-ascii?Q?6JnJZZkLIAClSDBZXaB/aoiAj3mB6bLn0k0N17uu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae79752c-af21-4c03-d6b0-08ddbe2aedbe
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:22:54.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o76MmBFSL6lV6zsWDuLmr9O4Gq82LPzesQzf5cWJAvGJnXdJUp4rgwlCcvtvxV6yZPiismghIIJxoSKqvfnVnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

The synchronization of CPU offlining with GP initialization is confusing
to put it mildly (rightfully so as the issue it deals with is complex).
Recent discussions brought up a question -- what prevents the
rcu_implicit_dyntick_qs() from warning about QS reports for offline
CPUs (missing QS reports for offline CPUs causing indefinite hangs).

QS reporting for now-offline CPUs should only happen from:
- gp_init()
- rcutree_cpu_report_dead()

Add some documentation on this and refer to it from comments in the code
explaining how QS reporting is not missed when these functions are
concurrently running.

I referred heavily to this post [1] about the need for the ofl_lock.
[1] https://lore.kernel.org/all/20180924164443.GF4222@linux.ibm.com/

[ Applied paulmck feedback on moving documentation to Requirements.rst ]

Link: https://lore.kernel.org/all/01b4d228-9416-43f8-a62e-124b92e8741a@paulmck-laptop/
Co-developed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../RCU/Design/Requirements/Requirements.rst  | 87 +++++++++++++++++++
 kernel/rcu/tree.c                             | 19 +++-
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 771a1ce4c84d..841326d9358d 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2011,6 +2011,93 @@ after the CPU hotplug scanning.
 By incrementing gp_seq first, CPU1's RCU read-side critical section
 is guaranteed to not be missed by CPU2.
 
+**Concurrent Quiescent State Reporting for Offline CPUs**
+
+RCU must ensure that CPUs going offline report quiescent states to avoid
+blocking grace periods. This requires careful synchronization to handle
+race conditions
+
+**Race condition causing Offline CPU to hang GP**
+
+A race between CPU offlining and new GP initialization (gp_init) may occur
+because `rcu_report_qs_rnp()` in `rcutree_report_cpu_dead()` must temporarily
+release the `rcu_node` lock to wake the RCU grace-period kthread:
+
+.. code-block:: none
+
+   CPU1 (going offline)                 CPU0 (GP kthread)
+   --------------------                 -----------------
+   rcutree_report_cpu_dead()
+     rcu_report_qs_rnp()
+       // Must release rnp->lock to wake GP kthread
+       raw_spin_unlock_irqrestore_rcu_node()
+                                        // Wakes up and starts new GP
+                                        rcu_gp_init()
+                                          // First loop:
+                                          copies qsmaskinitnext->qsmaskinit
+                                          // CPU1 still in qsmaskinitnext!
+                                          
+                                          // Second loop:
+                                          rnp->qsmask = rnp->qsmaskinit
+                                          mask = rnp->qsmask & ~rnp->qsmaskinitnext
+                                          // mask is 0! CPU1 still in both masks
+       // Reacquire lock (but too late)
+     rnp->qsmaskinitnext &= ~mask       // Finally clears bit
+
+Without `ofl_lock`, the new grace period includes the offline CPU and waits
+forever for its quiescent state causing a GP hang.
+
+**A solution with ofl_lock**
+
+The `ofl_lock` (offline lock) prevents `rcu_gp_init()` from running during
+the vulnerable window when `rcu_report_qs_rnp()` has released `rnp->lock`:
+
+.. code-block:: none
+
+   CPU0 (rcu_gp_init)                   CPU1 (rcutree_report_cpu_dead)
+   ------------------                   ------------------------------
+   rcu_for_each_leaf_node(rnp) {
+       arch_spin_lock(&ofl_lock) -----> arch_spin_lock(&ofl_lock) [BLOCKED]
+       
+       // Safe: CPU1 can't interfere
+       rnp->qsmaskinit = rnp->qsmaskinitnext
+       
+       arch_spin_unlock(&ofl_lock) ---> // Now CPU1 can proceed
+   }                                    // But snapshot already taken
+
+**Another race causing GP hangs in rcu_gpu_init(): Reporting QS for Now-offline CPUs**
+
+After the first loop takes an atomic snapshot of online CPUs, as shown above,
+the second loop in `rcu_gp_init()` detects CPUs that went offline between
+releasing `ofl_lock` and acquiring the per-node `rnp->lock`. This detection is
+crucial because:
+
+1. The CPU might have gone offline after the snapshot but before the second loop
+2. The offline CPU cannot report its own QS if it's already dead
+3. Without this detection, the grace period would wait forever for CPUs that
+   are now offline.
+
+The second loop performs this detection safely:
+
+.. code-block:: none
+
+   rcu_for_each_node_breadth_first(rnp) {
+       raw_spin_lock_irqsave_rcu_node(rnp, flags);
+       rnp->qsmask = rnp->qsmaskinit;  // Apply the snapshot
+       
+       // Detect CPUs offline after snapshot
+       mask = rnp->qsmask & ~rnp->qsmaskinitnext;
+       
+       if (mask && rcu_is_leaf_node(rnp))
+           rcu_report_qs_rnp(mask, ...)  // Report QS for offline CPUs
+   }
+
+This approach ensures atomicity: quiescent state reporting for offline CPUs
+happens either in `rcu_gp_init()` (second loop) or in `rcutree_report_cpu_dead()`,
+never both and never neither. The `rnp->lock` held throughout the sequence
+prevents races - `rcutree_report_cpu_dead()` also acquires this lock when
+clearing `qsmaskinitnext`, ensuring mutual exclusion.
+
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c31b85e62310..f669f9b45e80 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1883,6 +1883,10 @@ static noinline_for_stack bool rcu_gp_init(void)
 	/* Exclude CPU hotplug operations. */
 	rcu_for_each_leaf_node(rnp) {
 		local_irq_disable();
+		/*
+		 * Serialize with CPU offline. See Requirements.rst > Hotplug CPU >
+		 * Concurrent Quiescent State Reporting for Offline CPUs.
+		 */
 		arch_spin_lock(&rcu_state.ofl_lock);
 		raw_spin_lock_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
@@ -1957,7 +1961,12 @@ static noinline_for_stack bool rcu_gp_init(void)
 		trace_rcu_grace_period_init(rcu_state.name, rnp->gp_seq,
 					    rnp->level, rnp->grplo,
 					    rnp->grphi, rnp->qsmask);
-		/* Quiescent states for tasks on any now-offline CPUs. */
+		/*
+		 * Quiescent states for tasks on any now-offline CPUs. Since we
+		 * released the ofl and rnp lock before this loop, CPUs might
+		 * have gone offline and we have to report QS on their behalf.
+		 * See Requirements.rst > Hotplug CPU > Concurrent QS Reporting.
+		 */
 		mask = rnp->qsmask & ~rnp->qsmaskinitnext;
 		rnp->rcu_gp_init_mask = mask;
 		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
@@ -4388,6 +4397,13 @@ void rcutree_report_cpu_dead(void)
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
+
+	/*
+	 * Hold the ofl_lock and rnp lock to avoid races between CPU going
+	 * offline and doing a QS report (as below), versus rcu_gp_init().
+	 * See Requirements.rst > Hotplug CPU > Concurrent QS Reporting section
+	 * for more details.
+	 */
 	arch_spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
@@ -4398,6 +4414,7 @@ void rcutree_report_cpu_dead(void)
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
+	/* Clear from ->qsmaskinitnext to mark offline. */
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	arch_spin_unlock(&rcu_state.ofl_lock);
-- 
2.34.1

