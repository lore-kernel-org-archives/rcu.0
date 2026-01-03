Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF822F767;
	Sat,  3 Jan 2026 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399861; cv=fail; b=h7sudyg1aImsmz5MSlS+/GhO61xm7KpEaub0ld4BmrBY4YTcU2yG2l2gbfd9QCBLwAdGFucNtwG1auNtp0zn5y8ggtYxYZJCoUIr8KCn5tqeML44UdJUlGsskFP4adXwplls5+pyEFZiXI0LOWgqiSLZkBFKhwPHQqIUxHpyTUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399861; c=relaxed/simple;
	bh=jEWbHUjCwphvHrvcoVoT77xXsMIhyhbuKUFFK9T1VOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T0HnuPbhMLIPPW+T+yY+XwcLhzNgKflnaoaHbxZy2Nq/A27yFg1QWZeGcyrCJeII5sX8O8t6i9W1olDNGFyuD6Egjv32hsw7X92WgcrjATehfjwWTP98OD+S0m8rDU/KOKKLq72sd0BTIOYolY/B4CDY2DaCNFTnkLrBuRz9UFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EFgAPbbx; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EFgAPbbx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/MZcPxji7SvLXgVL7Ew+6fxKI/pL7eRNKQOgnIlt8Ke7dtZ9Bkm+5zto7h7yEoXDoRZhk9RSbSAMw3T0HN+AXvNIWwMk2NkjDSDanhRJviGnAYtqvZCfhBJAskMxoCRRCXK3f3BmgNYN3V/rW5pmmMXLfPRQ+b1fGre++iniBuF2Wfwt4aIv77mQ8dIQ0lVUf+brSCKsL2cDwGku110874ji2qLGIVO8ujefLPKGTmI4FVRdTb/DOokcBL4pGwHW9cmePltjcsP+ScQM5f70o+n8E7d4Ndfnn9lMU/T6aTIKTtU1hl2wxeyLgQaOglv1eLoG06107aqqayMdUyA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiAmPKH8lCQkwA9G5ucoxCYPHfi4lO5/dkSbinQzAAg=;
 b=R3DZOhHduoWugE4U9DYIp7xvvny5FyjBBEaW23v56AsDEy0hwYe3lWQdRNLOG7TPWK3247Hu2FFo0kXr4lqn/7QE5JhXq5j7FAPwevxLnbgaC+yR/gGbiun90i8baKGWjl6KJjUPxWklBcZHQQe0UCIkdYJxC5/OvpSFL2tXn59yHhjYA4kbN5HiYgPqO2dseGu+sIkjub3NqHaYTsyKQngVCOT6LMfE91kgQPWUBub6ZcpmozdoqOU9Ihua2tDUavUQnJFN3JWT3i5sr1EfPMI+25WutEPkh7HIVG/hDNCzDe4vXeYKZQKfcyaE6wOs7+V37XVMOHBHmfiK9l8b2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiAmPKH8lCQkwA9G5ucoxCYPHfi4lO5/dkSbinQzAAg=;
 b=EFgAPbbxVwLfV6T9yKLI54tN4vVMfU5KMLDliHGdCKS0wGrY64AHh7NubtvfZFx95KKxw8b2YyejSVU/4gD28SoMzyYIqFsxiOBHs6ZztodQg9JFeSem8iIBfwIb2Bp+0zjm3fQFyemZAAb2Ket0uXg5YDc27sDegIMEYw+0Xa0rgPkX8Zh4pU1hKpA65/caAVTZ4ohEJa3I5kO60Ouq3OPntL4YSr4nnf8hbNcklvj9vDup139VXtr5fFiDWxwH3MAPoW/n3uuruYZNNefE14glVbegzUFXxv1NfD0Yp7N9XnTQiqme/y29Tm+FzRffrxarhXs8IPB2bkQFmvNH/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:24:12 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:24:12 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Uladzislau Rezki <urezki@gmail.com>,
	joel@joelfernandes.org,
	rcu@vger.kernel.org
Subject: [PATCH RFC 11/14] rcu: Add per-CPU blocked list check in exit_rcu()
Date: Fri,  2 Jan 2026 19:23:40 -0500
Message-Id: <20260103002343.6599-12-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a740cc7-2aec-410c-6dcc-08de4a5e6b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rb5zvQ8ZzHLHBByhiYYmcjCpo/GF011/BLnSzaligzYVdzL9pM0k/xHGub+G?=
 =?us-ascii?Q?xEUerVPz+kvKfvywHGhzVAdhl0zCfrdIPnoIiV59tH2OxQS07uoY5mTqvvkM?=
 =?us-ascii?Q?a/tbi+ot/c4232mUGbvZTaO1UYFMtfmlv5k5FHwMCaiS4IGrS44LH0wGsx0Q?=
 =?us-ascii?Q?M0h+uuaVAAkX/WPYr1kytFJ3QaVGMy1jf6YCKyPUi4mZ8vBec0pYa1OQb8sZ?=
 =?us-ascii?Q?3iplmtuo8OYonqUktjFk0k8Lkcyb3ri1Ao1LZav1YTuRvzB2lfdPz0k/kqC4?=
 =?us-ascii?Q?IOOAEirC2+W/rYE17uHVKHIlNpcF+3tBB23RAoDFqQhkRSfCpP/HLx2omCM9?=
 =?us-ascii?Q?ztTPTcI4tVJ6EAr4OCjFzdj7TL4xNvV7zUu8T5S+kdNgynYIBOmdOwAoEzFC?=
 =?us-ascii?Q?jl6tOy0ijB64nfusNfMrFljHngRo/L3d4SzGVQ07xUyWJ+8vwDctZkiwNYdQ?=
 =?us-ascii?Q?r5Pb0JuqW4dio5SdZ74wW88VE/rqakreb328jU8GUKPgunObdQzvK8OgbyM3?=
 =?us-ascii?Q?59HTR8B2dr6o+VT4bH6/zbXp6bIsVHOtItQ0T3jcRqBiGlMW6vOljVOzs28K?=
 =?us-ascii?Q?9tQTM9aHGzqYlMbkqux/FUBmFJ5jlzaDZwY6YgkNS6qFRiOsJV7erKmYDU6G?=
 =?us-ascii?Q?JmuCBZfJ2WF/T4ynK8G5P+m3Vo6hBCwdl/1kGpy84NaklRtBPByJ87GI5lrw?=
 =?us-ascii?Q?ZclvfZjalssUZOBUzGXiTeosBe84ZGIUegJDVbTnaSEEA6hjWszzyFu6NpBK?=
 =?us-ascii?Q?Wiplecu05hpbl0onCJCfvVQ4r8Itwg+/K9HdkuNGLuATR81sI99yvxmSZyvX?=
 =?us-ascii?Q?9PR0wt7xzay8KIOPTPEE3TJ3gzmJYxy0KVMQYovYi8vhgaPm2PbxGdXWyWzU?=
 =?us-ascii?Q?qPd3XAgYkwET/VQvT+TZIompn6zAKwH0EETeLr6XWOwzH91+nVKWbqIiSDye?=
 =?us-ascii?Q?LpYMQDsBxF7GETIa8zUUOUGFI2xVZphwObNKrhurTkNyS38NLOPeA855RBKv?=
 =?us-ascii?Q?HKYOP97he7ltc7bE1/ggn8U5TUFMVnt2XG3ciUNV6EHQSr8CnSGsinvhuWiR?=
 =?us-ascii?Q?H3+LoxyYgmbPT+eJf5r3hf/OrX7WjsHw0a6YG5uH/++8vWmVoOFE+e5OZJp3?=
 =?us-ascii?Q?Bj+b5XqiW5SFcM+6eiKpRTckk8eUoJkrbemum29eRu/PW77i53hU78HTD9nT?=
 =?us-ascii?Q?bTTQ00ZHunW50JEO+2tjS5AOjjpmP32jwjkWC8L3FrV/WnJU1W9/fOwUy1v5?=
 =?us-ascii?Q?6vN6iaRUFwMn36tGa8mqJemaO6cZTw74wxBRll8XzB1TH+PBwiSXSV7c0Rnv?=
 =?us-ascii?Q?DhXvmPNre9QmpP3C5TelVU4UadT23go7k5dLCL2gxRG0Qv56JjDAXYkIjWEn?=
 =?us-ascii?Q?Tb7Cy/efCAT+1dxd0gKSzyoEZSCgzc2Pe2ssk7fMDMKSS6qU/PdRSsw/Xilh?=
 =?us-ascii?Q?2CaxFAmopJO8ol0FfY6tKxAXT670rR9U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HyFkrN3GSMe/LQyRuNwQFS/6JlmhvkmxvY+YdKvQwhpOXQaqNijV/fkPGTv0?=
 =?us-ascii?Q?Ulxeon9aVUJLT3bvhLqLpGaNTy5JP05vXNl7lZhgR/PNNVb+YdOKamzk8nH1?=
 =?us-ascii?Q?8J1vpbLPtbyLZ+TtRR5uLjJXM3p/F6rnUudYQ42aTU+aNCthU7qb+c4Upe+G?=
 =?us-ascii?Q?xTyDyOcYMwEQiY4Es9Y2ZA2Xv58aF1ljh1av4BvjT2CgKSQnFyDTmIl4QCO6?=
 =?us-ascii?Q?nfnnkFjRoz2bmz/DOHevropWaI02ABTIyBwQQgIZ54i3zYNaXF8B+M82SZEt?=
 =?us-ascii?Q?aUs7Ksj4RK8pigOUOnZj1oVf2VnzunLlnVe2wtaR6m5HID4pUD6iuyClybyf?=
 =?us-ascii?Q?OyW666E3kwpNOJYusSdnZDC5gPMj2bUoQHRNuhXhEgubNh8kNPDyUp0OX0MQ?=
 =?us-ascii?Q?vsavoaBiiOCxabxeSaFNLEIkgLATJbvmnStv9sTzcqgGELAnjlL0g+mkGqyW?=
 =?us-ascii?Q?yAHEOEDR4skmE5BtV9abDTLkUps0s0PaUibS1bT8hPOw9zm1E8U76t/Oy5Rl?=
 =?us-ascii?Q?1KUVVTYsgWgYiEX+xoPHPvRUldfPCYOAGJjqxMsmJe0AwF+k+oamrxqu7OEo?=
 =?us-ascii?Q?DrHRCPG3jIjQUgVQc7IQlXmGUKKTLF+KK4zwcAvVdA9PRm/7tJUJNoF5vm5d?=
 =?us-ascii?Q?mNdYJbAWu0WcP2ou12X44zndDFEjX9qJnmqRA3F/sCJ0W7DjuFYR7usKOCXz?=
 =?us-ascii?Q?qqzQT1pQOtDBWGkaka1Jtm/u1fouD84lk4PFfUrYoyZmp/Ihj2XTmQ0igFfV?=
 =?us-ascii?Q?Qs3XUFfVn6AiNoNpC5reQDntxQS8HPPGwRqL9xMGPLSM6GJqvBIvXoqAO/Rg?=
 =?us-ascii?Q?KzQmyIk7bdvFrbjh6cZ2uZFfMvJBy/trjsWbOZNgrVJIXUFcBrhmuYr+X/qO?=
 =?us-ascii?Q?bxBJ2SsJA+iuZu9oLs7n+L0Q68UI723qfZsWsAZGs9lBmJpVqTY7vVcPqBzT?=
 =?us-ascii?Q?XgR5ZwXdzvUw20dNjotH7nUTKPKjjvkICWj2yLz3T/gsdvRdMnxgw7Z1IhD7?=
 =?us-ascii?Q?OV+7vRHxjs8uviRAPVmEatIzVbRoYUcHvaQ9xJ+e0isjfFWLidh/cHfHMrbG?=
 =?us-ascii?Q?ZiXn+BlbmUAZcDGqAU7cAEXfiXkmExKTfJqkEKlf2hrVhdU6nYqg6X7v0fqy?=
 =?us-ascii?Q?YLNh37D5vsdkPILhxEpwM5ZW0V1Wce2vWY+x+Tm/xYjI4HljNNYANpVYS7sg?=
 =?us-ascii?Q?c7AlBU7bC1crIVETTi9QHSzfPt7nHaSwVClNn75LavQL57I0nus5HrF+JEyD?=
 =?us-ascii?Q?iTRK8coaKujy+mCuG1W3Zuu94OH5J2VsqESN63IDKvIZp5gMdFjoS5qPUBUM?=
 =?us-ascii?Q?o94RfEchHttYXy0wC6lnnmReblybgxexaBLurqFmzC46Z63ahB+q0fBL/L1O?=
 =?us-ascii?Q?DpVaoKM8PFtKQmjfL2Su2A9O3tNHVbFcUpgF6BdvJB99TPi/zHsuO684Jv+u?=
 =?us-ascii?Q?J6tOd8bOsbfhqcJOesXcvxQt9MNi+KqOKm598Z1xK2GaMtxsT/H6Bcg/JBb4?=
 =?us-ascii?Q?B5AiO1Jfokcwmh7WTUocTqDHG3bpBjvZyI3Z7Y3x5cCklh3yIOmi9XNuQea6?=
 =?us-ascii?Q?4mdXHoy0uy1p9xDPqpkX27foGJ8RyW8bvyG8CLCnXDRao7cgz7Cy9fe76Sy2?=
 =?us-ascii?Q?3rZbyM0ELtyxPE6s0Zn3q+2VJcpzIHMv5brTQ1zsKfQzMz6FBNiniHB8u8qp?=
 =?us-ascii?Q?tdW9n6XYXRaCIV6vRwFp2czA9kMk9egyM77D3GJnil5mpK/DimgbuEbHttcp?=
 =?us-ascii?Q?x0ojXzRdcA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a740cc7-2aec-410c-6dcc-08de4a5e6b87
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:24:12.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6vRALycva02/F946Bw7va7tmrnVXCBIx7TkCTtQ/NEDZa3K0kApmFVjev0IlLRPH8gtu+WjoBB6elJ0VKhUvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

With per-CPU blocked lists, a task can be on either the rcu_node's
blkd_tasks list or on the per-CPU blocked list.

Therefore, extend exit_rcu() to check both lists. This ensures that if
a task exits while on any blocked list, the cleanup path will properly
handle it.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6ed3815bb912..8622e79660ed 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -978,8 +978,15 @@ static void rcu_flavor_sched_clock_irq(int user)
 void exit_rcu(void)
 {
 	struct task_struct *t = current;
+	bool on_list;
 
-	if (unlikely(!list_empty(&current->rcu_node_entry))) {
+	/* Check if task is on any blocked list (rnp or per-CPU). */
+	on_list = !list_empty(&current->rcu_node_entry);
+#ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
+	on_list = on_list || !list_empty(&current->rcu_rdp_entry);
+#endif
+
+	if (unlikely(on_list)) {
 		rcu_preempt_depth_set(1);
 		barrier();
 		WARN_ON_ONCE(!t->rcu_read_unlock_special.b.blocked);
-- 
2.34.1

