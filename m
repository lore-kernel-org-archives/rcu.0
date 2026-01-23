Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69C2848A7;
	Fri, 23 Jan 2026 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181611; cv=fail; b=CPF0BnZpWI3niHky7dKR3maD1XWLiD2ONGnjdcgd8OzyKqkgiqUd5wI0dkr+mt4NJu9oztEDDR1ERoOFHMEvNDrhqjMlWd7YQ9R0HPCbmu1XQduA3+q0ND2Z0JHwIXkBqZlZVPPb4JBdvIgQ3UFjd6Fj+QxmTBRk6uUAhcPCnGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181611; c=relaxed/simple;
	bh=O1jUijz5yuMHHOdhmwhbzH8BYlfzxUen4fCdiK5DA7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NWHqcd2Fbyr9VhFqLKT8ngcu56+3FAyZ3Gwo1Yu3LotaGmoivC7ugdbCc6aNXUGvRFuI7J6pEUfwRDGlFfSy5mTcBO0KuYRcsvFIYVucUVVkR5CVYgR9N84QtWSwcK4cxSiVNARq64Wl/C4liNK9qHcFNRiLufSrvwjLRhFdb5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JMWuR00L; arc=fail smtp.client-ip=52.101.62.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JMWuR00L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rk1ZNp8XJNUF4jW3WFWlogoOFehJz4gXd/qTqUQK9Qo487QYJXcB6i8D2+DXkcslbirRA/pdxTyz8vXwHoVuXMXJyWI6/zkN3jO120Ep6fos6ppOcv3DB+IsHKRn2FWuPIH1pIsSMisaqN43XRFIB89E792Bp24XUiNlcRKi/pIDs+zKp8d1Lv+eHMIA3zeqWTBH0gMYrpz0AfCaUpvhA7RJ1CmQkq5DqfXEfi0II71TO6wUpW/AdXZXyFxFVDODBoTA6oTCqkPvqHZMYWQCxbSOv5Ow+rNk+a9nRZ9pcaCY+nrldAokNlzdoFl8EjWpVHTMMiGlSImwC5QA33ehpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yf3y0qg0nC7t4T+yYRsBsewFbR8+bn5MFGCiHORZLSE=;
 b=YD8AGWCPW7t83+RSn+H/luCa7bdn7TqrxdFLP0TnSU4xOLXu63M11XFYscMl3JnYQxbSBhLDXTzwzpJTOhELANVX0CQ2gfNRt+Ou8oUkcquLAQ7mP0NYj40Qk4kJU3HeQHQ/UQmysfoSuVzB7YC7HLyzrl4G0ExC8sX8OoNQmLZPb8UXTGyxY/yFqAJxuK+j/wPfJvc9G+I2SdwRNLsayc27ZbnjZhyDBfR6frrQz6QhC3lr2hvRi/bd9w/pYz8KC2fkvO2tk2vkAQuRRYzZtGyQToEuYtbWMEmlnXfKqY04S50NjaP16H7CnoAmBASPKsQQHV/jKfW1fg87J0tjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf3y0qg0nC7t4T+yYRsBsewFbR8+bn5MFGCiHORZLSE=;
 b=JMWuR00LuL0SVTtSOQnRephW6TgcfE0hLn+BYYtzamxfujoohtwcBEtHHIhgoHAR92ERVaEHswAry7cvSvlmmvS7JH0RsMrNnLxg24e7c7CAbe10fH9ANn9VveYEFi5oQQLARdyV6QjzMENjEd5MaC16dGf28EtaU1XMIil474jzAPTgYSsx9tgmacJ5foXNwP31eaRIM8ivgcB08YvLA56pXG6u0eVS8IDj7gkv7Gbs1LINNKH2kiqeDJjfW5nXwADeaKy+Y4Q9wTDtkJvgPXG10BBfwKXcbCoNUtxzYtn4tPrCA8N1o75lemzodn0JLH3kbzJA1X2YTdmz1x2FzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 15:19:53 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 15:19:53 +0000
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
Subject: [PATCH -next v4 3/3] rcu/nocb: Extract nocb_defer_wakeup_cancel() helper
Date: Fri, 23 Jan 2026 10:19:44 -0500
Message-Id: <20260123151944.732328-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123151944.732328-1-joelagnelf@nvidia.com>
References: <20260123151944.732328-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:208:52d::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3da2a2-1386-4b5c-72cd-08de5a92dbcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9zXBwasxkR8ElNZrSr9J02tqZ1NaPtZXjGBONcLkRDE9Ny+B82SORDbhZZTT?=
 =?us-ascii?Q?A1G/zS7CTICpxGgZeLI2xWyzDmylPYHvm4OsMJqfbCsUGYxU+Rg4RBZkLeUr?=
 =?us-ascii?Q?XJGYyBsKJxVE+nisHX9grZhxHuqB7Aj1Fz610VxwDTOEw3iGUjjUG2zTNhi8?=
 =?us-ascii?Q?KdiiRY8AJQRG2EqqVATrQWMzAN+10u5ahVb3Q6DAv1BVfB6iFE+2OKQBlVdm?=
 =?us-ascii?Q?qyg56hoeMC9SuPaIVzuhOSvdIP5SOp4rCoton7rf++RrsJmloXHLNS0gg/X1?=
 =?us-ascii?Q?OYAQx93Av3fxk848lpJopE+CGu1hPYgw6xj/dtGflGnxiY8GYwyzXYw1rE6i?=
 =?us-ascii?Q?UAOJlXiAZPXzVNzVhYkn52ATuGKbkmiuF6S3UM4nTCK2pbmUUKXw4grFCv2x?=
 =?us-ascii?Q?qYxrIDR3emJMCmWuFsWXy2J3lK9wZb/0Fr2ea5Yjj29xbewIaBJQC42Rp6nP?=
 =?us-ascii?Q?FcZO2LEp7SFsmAg6KSWVMJk5ZmW5bk5n7yBRoBY5PagpZglEy7pZoM8gpj1z?=
 =?us-ascii?Q?A0jEbxDj8n0sZKb5r5E89R01n3FeMsSpUxkOEWZwOjRz+hHuytI75v1k6g2Q?=
 =?us-ascii?Q?1yutDJuLwVbU5aFp5q4yE7U9nKUOMM5R8grtVMLTkaCA6FCPmnrrk0qa0JuM?=
 =?us-ascii?Q?gFOBFx+q9czhdYTAwKhHbpyJxEpvr54HeTIdbv+HGR4gZVEHUDafsZXYZvOO?=
 =?us-ascii?Q?y9U4DecjsX05JIANJkD1Bj15CAQBgcXxciX0SW5hMxGgzKqx3a6nemOVF1oO?=
 =?us-ascii?Q?4sq6yo5awNKOEHUxAA2dvu/gk7s222oqetCXG1U1THqfLIHUb6ykoLx4PFOO?=
 =?us-ascii?Q?SUAU+j4s461E9tum2B1aEaCSFGPO7VdG1HoSiLkHxLCzE+nU4TxC7sCt6gmn?=
 =?us-ascii?Q?jqGHnbu0HURaRfCIx+15u90GFuoOVlM7kebqxGezj3SPXzjXfHyiRP4tSXaN?=
 =?us-ascii?Q?ViYzK2ObkeC2Ua0n3F7FT1QrMrn20mEZsmmDfEu1QAcbAtRRD2ItxgmGD4i0?=
 =?us-ascii?Q?UJZMypgJXq7H+VX3JBItH7gUrloXOjXh8+2LzTP5jgLZuFXffSyVAF9rBu5h?=
 =?us-ascii?Q?EokjOiy5gShWI9TZOyKmvYG8UhNMgdo4N84e5Epoo3LMIjL9ie/7Wk5NYX4i?=
 =?us-ascii?Q?j9EwSsPqKo5wxZWDuZZBJT1PEJ/JZxSWlkUq9uweOPNHbBW+q4mcgHA+kOOH?=
 =?us-ascii?Q?jyFGbcywFZDjYgZvjHLyy5kgmN5UbGp+Cj/VHCUawCWyUE0dRHNhPhtumJdU?=
 =?us-ascii?Q?Kg6tqf1a6+I20uUHpguwLfFewfAAh5qkArvmkDE9A0odCF+z7AKREwSrYqCt?=
 =?us-ascii?Q?x97is6RmeXFJjwV+w7/o/+PztFmgaht41XFWLPwOYtH4QfsAAv3VKrrPxLaT?=
 =?us-ascii?Q?83VyD6LLNsW66p+oRdRJDl7WyQL7fHEDq+U7m5UGBOm6CK5kTsy1JSbD+R4u?=
 =?us-ascii?Q?qZsZDb/wKxXKyeiaGafDPVnryErW6TQmX2Q68kM0XULuHxTMJUuSaJe0seDT?=
 =?us-ascii?Q?8qbkouDoP+mMv342UdRhg7v4iIsMOxbPkYmzq0HN075wYdAZVV/Zj7xocReJ?=
 =?us-ascii?Q?XG1qC1+EkCtApNrYF5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VdzSM73EAyVQD0eqCw/HRYicYMKZ0ltiXbavHBIGpxOxqfsSf8cMPPWTlNXs?=
 =?us-ascii?Q?t86xKaTlHMSr3fePwenAA7AHMTuJZLa+4azLPiLEcDYxE4uH4R/st6aEOymb?=
 =?us-ascii?Q?fPqz+I7wjpoJBWMifmSM7Y/o47tu1GNXQ+brfUo60wkjnUw14wcPaMW+prqf?=
 =?us-ascii?Q?tLLpkxCnDjJhT+4qrtA0V0JgXscHwioZoRNrjq4vapWkxcMOyPnWDGmlobVY?=
 =?us-ascii?Q?FYbw4lS787oM1tb9OomCUInAjovZusGivQKIx9tRUGTHsXe4e0R9cE+8pxco?=
 =?us-ascii?Q?U6HQ6VpRnCWQF6k/psF4URF+rVfg5la4Nvx5Gh1Sn6GByaPFZ1IV2FOuC43a?=
 =?us-ascii?Q?YD1nkxTRoGQKKA4Se9QOMTdsTe1RBoHyy30lfWlu8vGKjCUc2eeNWxQSdO9p?=
 =?us-ascii?Q?QhblzZv0csSAOX89RB6HkiyJnqatStz/RdQJM7b1SxIoIVtRDI72Z1hSsF9L?=
 =?us-ascii?Q?ndgi+9yB9gqqQaL8eMo422+l7rWBN9SyzANIqg+9X5F6gRPFUaZ03EfV1t9b?=
 =?us-ascii?Q?Oe5A1HmVdg1X8VRLE3MqCUQrhUaPZqmfSyzwOY+itAmBlzD4JKNZEk3VRWFT?=
 =?us-ascii?Q?wSO7P6qfKAjJapkYkY4agdLObqDCg0plaDiQRdoq4XULfd81l7kgODadZ5a3?=
 =?us-ascii?Q?IfLZRgdpI2n9MPoBtimbuHVLnHb9H21fn4ik0uBIvuBn5C//lL1MxgRXJE7S?=
 =?us-ascii?Q?Kj8r8QD2eyAmpCUUB4pcETRsE7yNAvhaq0qWU0bpIpOlEfEu5/xg7yxNYbPo?=
 =?us-ascii?Q?KrELjHNmQPYgjXL+NN25zOcdiJHAkcsSZk/gmH+9Q6SZlnTg0J4TBqxXsaIK?=
 =?us-ascii?Q?WUqeLyz+x0bmFlYnf6rYNH+ZM6EASqYnBFU0i4Zs4RFHwuEHKBweQ86NW/dy?=
 =?us-ascii?Q?PAynuB7eFd3a5z4V3FR+VnE53088SoMr7qyk3qqUfjKtDNm5rU+3bCiRvxNC?=
 =?us-ascii?Q?qw6Xweu0GB/TTjJJWDcFs353zG9V35sGrrp6ra00/Zsd8RNE9Uuk4TANm30C?=
 =?us-ascii?Q?9luPZDTgNyf+2Mn0sUsAHfkCtmjcXR8CW6KrBOYs8HQtGsDc8RrrhxuzCul0?=
 =?us-ascii?Q?h9ndFw14MUF6G6z/2MqTBGqWlhRuQhyZEH4/eiIekcswLotwOMpsmo4R7LrX?=
 =?us-ascii?Q?9LS+g4cQFM7yq/gG+9j5GtwqOsuOTD+RSUjzuAB3gydFXs8ZyiI0UESHIPvX?=
 =?us-ascii?Q?j8G2kt/RIrbiNhPFDIhnr7Sa8C0rlztJ7bJHRGfFJQaIP1Fw/61/xN0LWDMv?=
 =?us-ascii?Q?Y3PER3MweEL4S6WUPVQl7rQn8ARamSPXlfdPsGSFS10ouJSHs3Vz28pd5nTl?=
 =?us-ascii?Q?5a4FzZ34c72rMlbe+clDD/5H6y0GjIewukgdqeMLzSY0DWitqoYiwPhZv2nV?=
 =?us-ascii?Q?8P0ZEwbu3DU2zaFFGTRb99MTjz9CqjWu3gI069zIm50YHgf26S0yKLAmyEHn?=
 =?us-ascii?Q?f5qERtBlgJlXY+8PPTzJm704g+Usr/Q/9E39/dhSf6bCPoZraSpURQiwbXKV?=
 =?us-ascii?Q?fv/oSNKAb0ptsZCxBS2wsxIwOjpGf78sfzFPBmeyvf6E5k7LwDvJU2BbYfyk?=
 =?us-ascii?Q?u87KN2+gVDF0uUKkkXaiuLpQKARDdd3k5xKKpZfHauePnvKHC1ORAbdGlB8B?=
 =?us-ascii?Q?5rbe1EYe8cj+Ndhd5YkXxPMxE5kz+N+s9xl8kxbbT1Id9w8I+NxGg9b30IIe?=
 =?us-ascii?Q?cCr1Lms0qkUISLn5DoDoZvMDqAcQEcfakSi+2awACZ2rTTWwhWPZo+GiKLYj?=
 =?us-ascii?Q?e7rNh5E2dw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3da2a2-1386-4b5c-72cd-08de5a92dbcb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 15:19:53.3637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYgLNvJdv3dzdEcvp51mre1Ws5gqTk5AZGE23Da2E00Zy/KPw0VEpJTivBN2OrWi76dbTEcRdPvFL8Nw6zEf8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524

The pattern of checking nocb_defer_wakeup and deleting the timer is
duplicated in __wake_nocb_gp() and nocb_gp_wait(). Extract this into a
common helper function nocb_defer_wakeup_cancel().

This removes code duplication and makes it easier to maintain.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 64a8ff350f92..b3337c7231cc 100644
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
@@ -788,10 +794,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
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

