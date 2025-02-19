Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62481DFE36;
	Wed, 19 Feb 2025 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968997; cv=fail; b=KLsRgzgznDat+YZn7MxUyBfHd/8EJ/RYhTt5FKN+10Wm51sYXpBR4iuEUBSbWS+yFTihhhXv7MkhI5gXmc/w7WnxnicKWkz/LDF0nJIiMTjfCn+DrRYpvJfCUDJ0nspAomr0q212os/YHtsiDittcLt7O3r/aZgVL7ZTjimlHro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968997; c=relaxed/simple;
	bh=6q/29d1wyWZBwStn1NDpRoOtt5Vu+QWcDfYUtypAYTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M4xasGfJQuttsRnIM3wM1Iz3k/akZx2aeLDFuLehVwDc9ODQFN2ULr9OhIacQf4+8AfzAA+tI4r52jVnh5n/cTVbHQyjb/cv5CM1o1CYCJeEjJ5PjVOWJCvX1Lc44WUJacCfjjuUJNI6+pToxGlHjxRe4ntqS6iOnZGoYmaKE4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SiVuqhlY; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SiVuqhlY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbJ4YStJ9GIZbHRy4+Uv+/N6/ffSN8mUbgixYgqAkRcyJ/ySSIzO1XvaqWgIE+LBZKax1QURBDV0U1FwpgVosrSFhoqBIiadDK68K2xsbb1aY8C/CIRUpI8YnhyEeg1LkCm+lVLiM3tETR9YvdkF/EsHFDVHOkQseGuCZmdgTlekXolF0UxUY2Br/Uy8WyP5U0o+z4PYUMag/CS0fCUYjwWdqDWaxel1RHPXNBySEwvOSIZn2n8lL4ZxeLcIOZ9hWfwMkrzzpcMvBv3pBMdRBWsYgilZNWAAW4Hi33FhoDI160uS+7iQVNeGoS+gjw25Y5YFg/yB+EiUDicjerQWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utEoIiZZlrtDYS00vyITlgz9xnyORQiQ28mS5rEnhGs=;
 b=v+AmPAre7eU6AL+urftoGIOsHWAd0f1pzU9Nvjcb39JDCNMY/yKEQfWtsbbkK8RUGapWjzvDEA53/qI3812nQK3D7FlIVqRjpGWrvuXtLRNnjtLmyKMpK0sOviXOFjfqKnu6MVeifxbXZsNjxi6SEH95H36mE7lLRHkySijeNR6O9mOXplkDa2DliQ44RL4TkRQbUjIXPaG8yZ2/paaom6StIRjJ8d410LV4gRuw2P9S8cUWGrUvDpOUjLEIMypFqGxe7WDrSRVAaeERswNjgcTDiCZePIOArfMXbZ5c+Xh6+bGFa9aoi83fKS0LQK7eMyshWaWiEn99wxshO5albQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utEoIiZZlrtDYS00vyITlgz9xnyORQiQ28mS5rEnhGs=;
 b=SiVuqhlYHgaEZaZtZ83XBYDqIYfHTPErrXJe0paC1pDINc/PRQSfBvcnmT9J+bKn42P0rR/vwLXQTu32TSITwKT1rADihgVE0QPkjC4GciqoaBmFBU6Kw3LBpJtivhvIBhExnKAhizUo7U1C/wkV9LrOiONLHsmls1g7MBbmsuyRvIUye3rdZHvo8JJjgZPoXoUrXr9BUdJ1kAYc/EKVS44K8hkZnEXValg0vBHwv0XuJQOrMUweiA3DckTYSbazCz1JyjfvPNQ6rC5cCy7ge3hhvcgJ5pbMB+COWOHv4RnB7tyfC45s9SIPV2tnan5cuG8ZcpvRwEWTjG/tE9WP3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.22; Wed, 19 Feb
 2025 12:43:12 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 12:43:12 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	rcu@vger.kernel.org
Subject: [PATCH v2 -rcu] srcu: Use rcu_seq_done_exact() for polling API
Date: Wed, 19 Feb 2025 07:43:08 -0500
Message-ID: <20250219124309.463702-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 91342af9-02aa-4684-a9cd-08dd50e2f8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zk6jd8KIws02b/2tPPrtsboFi2t6/VTcoo5P2WbG/ja1WdgobJftf+9QncYv?=
 =?us-ascii?Q?ls7LFwG/NUzW0UjwjtYb0GC5WaCHUK1ZmJ902qlC49NgdBvFAStesqFs9he4?=
 =?us-ascii?Q?clLdkm5X0kOhTIQhotMmN7OkMlTM4N6s53xE1f3sNHqIeHmY5ywx+tzmMhTF?=
 =?us-ascii?Q?M1TxZWHTgZDZqG1Lj+B5og1mMCCIv4kJR64GBaQImsKhLlyOIngPUXe/eCxn?=
 =?us-ascii?Q?/oRB++DbrYGFT2T6bVwW4TMkgI5Qm1YtK/sKaYdX4OVOyamfN7KE62s6T+FS?=
 =?us-ascii?Q?6boqrL7scjWLDo42rGU3zWtRM7Seju/sGpC/9rXAl+3ZpbbnaorcJg2c2UN/?=
 =?us-ascii?Q?itNebkuFhQoTAqHqNApX2w787EW7Tc9qYu5n3fQXagNDEroYa/dbLlI0JyrW?=
 =?us-ascii?Q?8wnfa9Be6uSw1KB79jEE3XkhG64GqBFDjxrdf8pRQjGi/D2FjKr7pcYH+W7Y?=
 =?us-ascii?Q?VR5UQTYhSnDTGG19iHQxXt6IOW5s58cgz6N4Nqvib/8OW1KolbLdaeZojxLa?=
 =?us-ascii?Q?JoAVtRD6f1Mdr+bgAo3DuULh9MvOQ4USnsizy0/hxFaGBNPxDz8ZfEmwiztT?=
 =?us-ascii?Q?3P6hlm0WQw4D50AFMviio7cO4hztfM/ftCftQdwp+ARXPxhUkUo4GSO+XUqk?=
 =?us-ascii?Q?BMnkmYtC+K4RTeUoVS/08vtzJQFSYNdeX7u5fUS9ovsn2h/k9Vz5zrtllNZD?=
 =?us-ascii?Q?3eYgyXUrBEP3J/Kdg3A1vMu9Y8xlZX5S7HEh4TsG2Q8Hg8DvAjOHa1Ylg85R?=
 =?us-ascii?Q?NohqbSHafNBEH5DDnG7SG/2Bfg9MkDr35WEXCoNSxkER341V4H/FXgoTCxnm?=
 =?us-ascii?Q?ct+kPTpCo3TK5cxGPQq6ijzTsbU2j5LUDY2UqIOJarH+Cjba4/kc1l9lcOuv?=
 =?us-ascii?Q?BTlGJVXyXZe8jyDy2W/rup0I3Kq+9yqJ8X0NS8dBHr309qFw9S9QjwR/yd1l?=
 =?us-ascii?Q?oJetvc8ll9QNlMrHiOq/50ZAAtSu+3Oz65lFYMM33bXcW2l4BmUWt190/vV1?=
 =?us-ascii?Q?nHtXgFWHkibMqZAIngRLApNipHsGWFSVVGzzfYeln5gJ5wQjL2sfoXIWbRxG?=
 =?us-ascii?Q?Mj1k7R4HEqNWmayaeUAkpu/A4RZcMZg6YPBa/6HZ4BcMdCad07w3pinlsHSN?=
 =?us-ascii?Q?yiWSy7S1azKJktrpQG+QoiNDtn5W6U9osyoQIKwLA/iM9q9zlz0pW1hqfdMv?=
 =?us-ascii?Q?9Z56IqqOBP6gtZCPROE2CvbYBMQ55PiPtIPDi/fnnCtIIrrpFohBqcbq8Hnq?=
 =?us-ascii?Q?2CUBOuWV7yPrWIvOUmrls75sMR1/af8JZa8jsE3QXO3WFaOrcFUGcqo8z0vT?=
 =?us-ascii?Q?mi+hOfI1/Z8irip5OW3VHOUJJRaDvC2iryaKV3Ppc8NRRIy4yNM9Qq0hpopn?=
 =?us-ascii?Q?CdwF/s1dAiNKdomtecUVGv9ASaoS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o0gHf6/SjZU+CHakifxHfu3Wm9bgw3BNM+lHlXsJkuR4vgX+ivPKgckqs2lO?=
 =?us-ascii?Q?tZZsqI7US1MQuQNgONWQ9dVj+uNH/pPEWON6qm6/PD+aftzUpdXbOu1WYZER?=
 =?us-ascii?Q?+k5mdsYmk3cadMqn+z7Mb+1xs8qVEht1cIIbHnwppOsD6ekcFilJiMZoTIkf?=
 =?us-ascii?Q?zrb3rwgVWd4bleM7uhfIo0Eu4Ist0C1BMOuSsSm7e8i8BLanqevhmTwugKRW?=
 =?us-ascii?Q?cEYdKkkDn+fprLheI0Sca5FcUDcEJEZvzxHhpgTxIpqU5lWRPAjU0KkhPlK1?=
 =?us-ascii?Q?aAe6PPu5LGuNrIBM6EvaIKRj1FS7I9QWjfYcHwGGD0jO2LzgM8WKUP87D3ae?=
 =?us-ascii?Q?7Qf57YnlDESYNMgcLKfUlHn2h81NEf7QGc/InMjbJKKQsBmUvxd1DfwRhoby?=
 =?us-ascii?Q?l0gWdcjTO45GNTUOgh/b97y63HMEfvLMaJkIcqTy2rEkgstfDhk1fZWLFJt/?=
 =?us-ascii?Q?ZWXXiMJwyFVpaOikRmUCxY37oXryDq/nsnYLbLeY15LiSkINwhzRTLk0ZBOL?=
 =?us-ascii?Q?/IyY+fZQJb8LBBk9GZG2STJdH0q8k9BCr2IinEcLu+mRJOVaC1KmfUABjhwA?=
 =?us-ascii?Q?RJrpQ+sZ2Su//q24TnfKksd/ua73yAhX3yId28+KQi8CG2IDFnOTvIi9QC7m?=
 =?us-ascii?Q?PZjpA2di53/USYamwgKoBCyQJ5nUqWVr2ODMxVxOvSAuf+aJ90uHUNvGnWiE?=
 =?us-ascii?Q?2zd6zEfMHOKdlj/+ugxLHzQm1TTQB1oKYhRFoitRyOPcI+d0ihdQUbrHTUwI?=
 =?us-ascii?Q?tBjZPHKUOB0E4BgUB9+lbDjI6r7YpnqlrdcFOBjxodceq3HUC5hLFAd2J70F?=
 =?us-ascii?Q?B/l0nYqgvxMU73aTPYdTFe2vgkrrWuAeiMfkA8OwR46LuY7KnqsR++53MOMJ?=
 =?us-ascii?Q?I17+Z8ULesqK3O0Q0w1A+hIiS4dVTNDLOcMmbxEWhCaYlgPgP6KL2GEIS3jz?=
 =?us-ascii?Q?0xUjx3L5mh0KswpbDDvF/WmLYaK5bz4W8RvhnMsClatVa4AiqjiBdFCn5qex?=
 =?us-ascii?Q?Cz92ikHVs5hNVJvYYk1oSwNxQpJV9HxYQLRLjECHAMo6T2Ijc9mlgx54KPCH?=
 =?us-ascii?Q?yRenfHTqBoBz+XBrrMp5jDMyVqH9B2LC3jdPTTVeD4vGeRMzs12+0aa7MSb0?=
 =?us-ascii?Q?3ZhvKQJarrluKf2bpzwepXMh8JjFkpp3UP7XuQlnQ5MhNEztesSIBzi6sD2a?=
 =?us-ascii?Q?w0T5i99Lza1SQ7W9dIVsILLSLBSXjcIzvvfF3e27nZ+hlWy9VMaeIAnXyoWT?=
 =?us-ascii?Q?ZjBuYBY69WmhnmttoNlSVsL/j6oc3dSKnqTHOJ8t1mxvY1Kj8KlHwjQHJFJf?=
 =?us-ascii?Q?ZZZhmTpPxCw1V4ZBR+iUid++4AXXDaC8Xn5XsG78PglZACJDXzQj8mFtiU/k?=
 =?us-ascii?Q?CRMdEqyrDdGYRb7nL3lCKE7yzPeLYAuX2o5Zvz9JnNO9b+MazG+2Zes5YegD?=
 =?us-ascii?Q?rYH908x6H+vwZFP8mpcuw96uSfAght3Urz2z855ge4yxF73WC51ljCo6ieYv?=
 =?us-ascii?Q?vysstBIaQSH0+c5NSZcMlTio/0t84jW2nuJi3RZg/Jg8NW4bIVhZO/YXWuTz?=
 =?us-ascii?Q?AyI262vmeMQsXo6hwPl57oLcBz6dEIiXZ1+au0IP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91342af9-02aa-4684-a9cd-08dd50e2f8fd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 12:43:12.7885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grC07QivqcrzBT1ucFPUrmvNXXnBqpsgEBJm3ICwl/XH+IhNRnzAdSJ5H3GqYFzgJhoYmW7BEcJaG1vUokOBwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213

poll_state_synchronize_srcu() uses rcu_seq_done() unlike
poll_state_synchronize_rcu() which uses rcu_seq_done_exact().

The  rcu_seq_done_exact() makes more sense for polling API, as with
this API, there is a higher chance that there is a significant delay
between the get_state..() and poll_state..() calls since a cookie
can be stored and reused at a later time. During such a delay, if
the gp_seq counter progresses more than ULONG_MAX/2 distance, then
poll_state..() may return false for a long time unwantedly.

Fix by using the more accurate rcu_seq_done_exact() API which is
exactly what straight RCU's polling does.

It may make sense, as future work, to add debug code here as well, where
we compare a physical timestamp between get_state..() and poll_state()
calls and yell if significant time has past but the grace period has
still not progressed.

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
v1->v2: Resend with Neeraj review tag. Rebased on rcu/dev.

 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d2a694944553..591371d62e89 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1589,7 +1589,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
 {
 	if (cookie != SRCU_GET_STATE_COMPLETED &&
-	    !rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, cookie))
+	    !rcu_seq_done_exact(&ssp->srcu_sup->srcu_gp_seq, cookie))
 		return false;
 	// Ensure that the end of the SRCU grace period happens before
 	// any subsequent code that the caller might execute.
-- 
2.34.1

