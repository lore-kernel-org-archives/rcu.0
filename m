Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF682FBE1F;
	Mon, 19 Jan 2026 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768864356; cv=fail; b=aJq/l0F7QbgNO9S4ODbE2nEtr3+7QDoTOrrbRuvTj/AYrD91lWIX3R8tgZs89Muk5Dieo9UqEit85kF+WnncfqIuUXSYCyrp2wOaKuaUWqoOSAgnMoWUWEAwqRQS2Ww+DzOKhuhPqJSX3FRAZeRxlCQ/B+McdQuyJh3cVRLyvDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768864356; c=relaxed/simple;
	bh=NLikKhNkRnkgQuALKz9kp1sbwi7tJYGhjzDr0Fn8NfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PSwcnSSzjHwKqkDo+ldvawgcDlXQunlFlCO1rvBgBCJeSXHYbFZd0dV2UgNKaoEjloRC+r0Le/4w37gYaDTT+mcGPoKE25kag7MHsv1lhJK37D1Oa/+ukVTPeIrag1DTrYkb9ULXF0hju1KbmBXjCvGonq3VYa6cjwGQVIB2uKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f7E8ErY6; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f7E8ErY6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqyTMjgi3ArTHK7uPN0KiAi3/ZuqSpB9gAjsPnSV9G9V+8mpI9z5QLyJB5UOX2MkHC8i9RQowgUsMhwrqaMDEtFyXaFDFh2HzYHhsyJgwpTrR/0ak2ENTdUm/UdR0aDpjwaRi/jUYAsJmhesy8JKNGdAdLRrkw1T5l/GGWzQxi5IQkL9zl62SWEJT97jXIxv+LXVhi5am+3X/jqS8MTMZvCjSztA8tjI20Bsa3a3FM1syH8LbYAzmZZYc444hxa3yCV8IKXVsHp7pGyVNnZ/AQXBBOmziGUJ/Op6Q29CuxOsJxmRvLKrJoH/6Vtcj4nLxB0TKAP0YB9iPDvNc9Ekbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDNxI81rrY6qiTfQB4FbvBo8v1lSZzrXABunhqyCJRo=;
 b=dyL0El0iolRs7SEJlxa0RBqglCXltwKoqSV947XtEPathAAbz6TqD6QHTDUw34FscrWp5WbA8VEmSpu29d6W7dcrwV/lp6x4fuNmw7DDkYMaLvoBvDl5/EKnSRbO9tbMXsefPGkLuntGtm+Kw+07gJzmeGqMEVSdKNYROlKHCeltAKnnY1FelMg1IO+xnnhv1aqWvqDJYElykcUCBt9XjGvgzHF7QYKRBEsfnEL8AxRZvq5Sjyo0myS47xQ3orwwjBBDJgdQkOMNRQkTS5as8mmuabMeqUiqFBq3Kvp9FqnHcpBEoC9kLF9UnsxuaOZ52CahxCkdD994QR/tETkeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDNxI81rrY6qiTfQB4FbvBo8v1lSZzrXABunhqyCJRo=;
 b=f7E8ErY641HTNmTUb2LZtQEN4+onJ3WXWd5HmWhYBN+R+uTX5RjRlvFKR2I5wXW1GcIL7RIy2PnsWDJI7zBxTBck+Q7SlpPUJuYawS27ZmGB3NLeDmyN7OKOOrQFsj2HXL9DD5yXBoFs7pX+1stoS39u3cLLkJYvVbWsmg1QJifrQkq9JBmWAhyU5SVb8/GhAGS1tez+6h34y7UY26tfWRQQ/iQmPRzjQlDIwag180py9Fxlro9Tsqp1MitUF7TNmd3aRqZXc4eBtPiYUfblaX7h7Bjdz0JccdnniUOCaDYbkC83bvL626Mt3cHQ/lKPgUuJviokZFrFxz6ACSSqhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.10; Mon, 19 Jan 2026 23:12:30 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 23:12:30 +0000
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
Subject: [PATCH -next v3 3/3] rcu/nocb: Extract nocb_defer_wakeup_cancel() helper
Date: Mon, 19 Jan 2026 18:12:23 -0500
Message-Id: <20260119231223.989409-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119231223.989409-1-joelagnelf@nvidia.com>
References: <20260119231223.989409-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::18) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0fafe3-5dd4-4a7e-786f-08de57b0387a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?19jua/KHjhLeI+Oc61BzzQqOgdmgdWVLS/Ot0814QIZuzaNvw9Lso4hN+K3A?=
 =?us-ascii?Q?7cYzBYq64ZWv8OIbmSIlJfZHS8o37jaXkch2Gd39zht+Z+qenRWPKFM2Cwlr?=
 =?us-ascii?Q?M29DL8m0Vkz1FY5uZlOIBSY82uWBs2dYLfkdXGO+N23kKVlMKtVD2dIndAO6?=
 =?us-ascii?Q?5uAuW4385uEcqXIN+uxxTFxL678y2vNcC5iqSZwxY2aGMhJ29F0jXAeGrjL2?=
 =?us-ascii?Q?rQXDzkKjxOrOgXW5qbBmu1vvXMmQIFQdNh5XJLMyiXVVacY2a+cRnf7IamJt?=
 =?us-ascii?Q?EK9kjMND1XEOPVAZK+u82LhrpBLWa2cRhFeXVLjhlN8oePmvNYKVSyMPrmGm?=
 =?us-ascii?Q?fpq6Y9CSGN1V2TzGNcBROr/m/SIYkWaCGHYD8uyDnqMZyKMEZLwBLsuecKnH?=
 =?us-ascii?Q?JvC//PWh5skzVG9G8W/SGRolqDjddWkl/pmH3a+Y7c1o0sID48CZxJeBW4yW?=
 =?us-ascii?Q?CtvvucSdcw4Aa2vk+svIH27nk9PiULJbP6SqXNbQMMiMVP4xlsKIMHFxTFjp?=
 =?us-ascii?Q?vkenLXM19fVoVyDboUR5pswaTOU9WCMPQjFWXgWc9QYM4sCRgT1KxOOTNfu/?=
 =?us-ascii?Q?YcVNf7mTngneXGOzyugCkHuD+BsQpXdOHVMuc8/C1kUJPSfSYHu195UW0Js6?=
 =?us-ascii?Q?J2DjqEmJI6464km1i7FmWRdb+HZ6XlhSzCEV1FKDAS6VNSwY9Y2bn21yWDFu?=
 =?us-ascii?Q?moCmPYQW6e/9JkHeKGN1omHWTqahzWMH5EZAjmECh+3rVsLsjE63Y66yEm/q?=
 =?us-ascii?Q?piVdVov7O8OMTfcl6ipZDG7oZOj64jl1/T0rfG9CVMq0wET6HZ1ESMSnzPXh?=
 =?us-ascii?Q?v7IWSD0kAqor+NLG45xhSr716Dh7QgH8Lw36btjHyzQWZkXhED7nxxK5kFjN?=
 =?us-ascii?Q?gn60sO1vYDTeDYwUurOhaaR2FEwrG+SvfR1TEKtUhNGL3PliGbmxKQBeJ87x?=
 =?us-ascii?Q?f80hI8p3lsi313xgJS8w/TgnyIz5CwwhmPlFJZx3YCIIHMgpTSpcPfznMsgB?=
 =?us-ascii?Q?vINoAsDmj3gRr50ZWXp/y7HtRCbEcAtSxE1tgIBuuu6M6Qx9MshHD+nrFfr6?=
 =?us-ascii?Q?5jQGAjcY1qS9kKERIrRfFhzImO01maG8RAdGB/16SIi+6Sk1ViVRfyh1r1Ov?=
 =?us-ascii?Q?mUFQaYgTmoxtTCTrihS2GW4l1BwMXyvNe5byPm/mJZXbuYYpKy+dQoGw6fjA?=
 =?us-ascii?Q?NMM10NNgkNXd/mLg7b4nBP1P5fpniYvB3c4jUrkO9Smh8f30ZIY9XbwIO9ss?=
 =?us-ascii?Q?+TRPX6s4r1iNVIxkKYx333mjhO6htqyAn19XQgiQCUAok1Vh4XtgDVOtEUe1?=
 =?us-ascii?Q?oq/Ho0V9/purFZn+UKFCJgCyN7daEOOog5jRA+VRXRPyEx3EmLYyyap7rF3D?=
 =?us-ascii?Q?5mcb964VZQIQPTg8/t9QA5Yu0TSlkoCVSbqryxZoPeQzNGQ8Tj3hsa56XGcu?=
 =?us-ascii?Q?BJ9cm/BYZFDOQkTHNYUm5ydoKSOOZyjiGFH1JuY0/zQzY/j6GqY/Wvm4O0HH?=
 =?us-ascii?Q?X8+oDS6Ie+64Z5dLvXX+xQmjJKhQmBWIYsFv0WmtrJ1QCpT8Kdoy5wB/d3Xt?=
 =?us-ascii?Q?Qz+szcDgSGRFUrkizuE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7SWMleAhUw2JO85h3JPnY+7r/XQ8iWr38h8KXR1UpMnX0rEbeg+eJ4VmVeSp?=
 =?us-ascii?Q?4O2HaBPg45GaTpJSGgXnX1nCHJqsweUC3rLvYqyNgpVnRm7MQ1EFTNadAY5+?=
 =?us-ascii?Q?P1RhMVAxm8jY0bq6Uymq+BL6swqw7gNRGXnXeFfKn8fewgu5lkO4YK9eyadG?=
 =?us-ascii?Q?bKFDrxVx0TnktQeeZNV3vDX/dgcUS3HgNDY5P/6Ynn0V3VTkoMltfFjHLo3F?=
 =?us-ascii?Q?O6QkIEe2xjZ7BqMY1YU7vY+9dJwmTaAOwwnU5PO2UbuyrfhlEEx7ZudnWmF9?=
 =?us-ascii?Q?RZI3WbDdnSkYv2EF9/evVIIVaHLjSR+/rnDYcXQKPqGrTjJ+xuR7AxWT7Gkv?=
 =?us-ascii?Q?elGHiRj5uaTMC5nwTTp1d9MN6GvUMRaxkGAm5hb2+k89ZxSZ5meiL5A4itvQ?=
 =?us-ascii?Q?HLI0x99PiMm6NZTZR2IgMMSFxBJq5oTlyjZoh+TeX3s6CMGdsSiRF9/iHlAh?=
 =?us-ascii?Q?torQ7WzlU+NtmVi4q0W4O4X5qQ2M5Rm6a9MnDWPtgTOrf8vs8pfKxd8soDqS?=
 =?us-ascii?Q?NQIC8qDkTOORe8xWZnCyWkLhZYPs20UweutZwvd6p08VKSRoXBC8y42hjPbp?=
 =?us-ascii?Q?HrZWl6i/MtivDeuIg0z4uGwT6zSXrInma/X3qfAJUsAoFmnydO05nIS8Bh4b?=
 =?us-ascii?Q?6MLKo30a5ydOP+M37INq3UffW4oqHidcjK7FV6P7CKaIRrcJRf51gdvFOjN3?=
 =?us-ascii?Q?bvgRtphl2rv1BCvm3VFGC341YMD8CNNex4ff2PjReIhm2PqAHJNz1b7nk1zY?=
 =?us-ascii?Q?YUIgFLenK7ZSssGispi9cRyWQ8EWByTKjBjZEnLEVCDil9Ti/KcKniNo68rq?=
 =?us-ascii?Q?YYI9J+8UBmEmCK0Na+HVWtvISCmYCjURxOAjh4cpJDIz02iqqdlyYJL5L+jj?=
 =?us-ascii?Q?6uLfjXlmr14deQvzNtoBqnWA01Q+b8Wp7wBwA3aJEdB6Wpq1dvLBWwh0hgPw?=
 =?us-ascii?Q?1cibE8+F6xRYFmauYRUmPg/lZ/BTWZ/sskUHhXwPmeOcC8SOaZOcYAAcnH9z?=
 =?us-ascii?Q?ynXqM/cA8Qmlc5FS6CSqoGsF+gWT6ujYWbaf8f5StNcGQ5xtnAcg7RteJ5I9?=
 =?us-ascii?Q?zhEyhSlyrZAORNfF8pEWCIunjwVMc4wCBVu9BqItmIKoZy5cM+M1W/Ob6BRe?=
 =?us-ascii?Q?TvnT9ZveX6HZJQMKI8y9wRGsjuL4tR3045MUWj+CvHVjhx3Cn/c6av/o7WaR?=
 =?us-ascii?Q?75QLqPY+qFphcZddGMnZ83K7oNU2HD8DSv0UJx41rUbJl/HPHE3IdyzhAZ2m?=
 =?us-ascii?Q?sHIUB4iXRktNrRAMzch7Epu9NYPmGGLsWPt/eNSd1ODgz6n451UM6NlrRzeF?=
 =?us-ascii?Q?YPWjb4N9Tymn1ydyS1/w1d1X5cXAIPkZqk9c3YiwOm/PLBEDqKOkjX9ygrbl?=
 =?us-ascii?Q?uSJ3H8E2UqioJnca7aNIUlvAcvet2ILIkSZ6Qhq0Npv41KCq8J6dZwDkD66+?=
 =?us-ascii?Q?Q10iTFTTDnNSxuwL5ZfaQklU8D6EoO12tSeR/8N7cUhEid7LhCsB9dEZpUzh?=
 =?us-ascii?Q?ZMWS7Bvo2YE9ODhY63cnNQs0FGqbNmA4GLRwVsGZc6JGY3zZyxI8H27ERqTG?=
 =?us-ascii?Q?i3VHwfGiAeUivAVUNR1V1OctCezE1ZuFaUED9sKS4sJtZYAL3di94F/oZiIR?=
 =?us-ascii?Q?SgmtoQYIFb3ptE5OVp2EO52Rm2HKPuADtQd9CbWdVJKh3Vmjz2sY6cOWq14h?=
 =?us-ascii?Q?QkpvdL1aGTQI+YJ4K3M6ZsP9SXaXY3eCp8UyvEBW29u1UFpWCiN8BdOA7kSM?=
 =?us-ascii?Q?qwWSAwVhpA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0fafe3-5dd4-4a7e-786f-08de57b0387a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 23:12:30.7500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEg+2OP5+loBATiKK9ynmwCWj5pbwKkUhZ6b5Dk3RLyQReuOrcf4uz54wCpR+nCaSS79ByER5Q12LMabqd5Khg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987

The pattern of checking nocb_defer_wakeup and deleting the timer is
duplicated in __wake_nocb_gp() and nocb_gp_wait(). Extract this into a
common helper function nocb_defer_wakeup_cancel().

This removes code duplication and makes it easier to maintain.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
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

