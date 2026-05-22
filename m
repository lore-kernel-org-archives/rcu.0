Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF274534A2;
	Fri, 22 May 2026 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459854; cv=fail; b=lG30AH268h3gGGfEVMrWkhiR+zi6xdtRNzAsELiPEL6t6XptjaVoYKI0BgSgi+bPfQW/71a3f8MppBMkPO7COphlRllEPEOGJy190ltID8zveqI8iLi/VsBUpkQivcsebSPNZiYFmPT2veq6ftXcOgyqScqjOpGaU7rNyBmCKhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459854; c=relaxed/simple;
	bh=hsxPzI+av6oaL8CBIfvbAcFT672ooILCBEN5mfn38x8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jh6nuuRBkdS0yPrvga7kmhgGR37lQjtN+R8oH2DgxGUSZsQY0kBjWLic5B+F5Bftlu4jnSiN1RFLzgP+r0UiAwgXy9rlcYKs01cPmjuvwDcoXRwkO7DPongL/UxQHarh9IYBxnw9tkG37/DMpbMb3gO52ph4KlAHcCXm0I1Eqmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PgP6eNe5; arc=fail smtp.client-ip=40.107.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PgP6eNe5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK/BbnrqPA+Z0MF7ANqpTskmeg9ZcbLs1PxdSlxgCx8C+4MHp2LP6MImhCS66jxvJhHG4fvYxLqbVQJWf8JjzN7EyEzHzS4+tfUky6Tkxq8yC3Z30m4l8hA6Jbdb7MhuGUhdoay/Mx7UcFGbLK7kpy2h6HxEu6g1B5CpytB0ZOzyQEMV+wZz8tBsqabmp4rACCwgqdFgatW0dsNWR3sabssC0NI3vJb8AldAHlpnoa/jBfYgcTJ13QnPm7NNAxIGL0xv8VdkVy2wisoIb0JaeUHeXtR8frEmlj3akrGUa/F++njWU0Yjrql3msqV1NVU9hrg0EXqX1VIzX1LbiW+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOTcX9evTxo1FRB9J0hTdp18eLGUmzDvBQomLqMeZMY=;
 b=iAxvK4Ff9Vfq2cc0EKWrPgmN8XrxggQ8C8KTW4vDRfjLrmXU9ZlgYXcfkdD1loH3ZkvLH1OGJbpbJoJzDFIILIE1pQSdkzUru6We7hT1DiubhQrrRie51fRdSJsmOR49sFJtNhY4ww1Y3185WXhY8hXr/AaSDl20T92kRJgUtQmIt5zkSZMRZhZg1QV1h+AbuYI3lyzWD7YPlwsAe38bgT3kQ0yg2QS505LASobKyrbtho5FkgZPM2Xc1fLgN0f5chYqonxNS2SuUFgprQ3m3McLCTv8e9V3TQzC3ivNB+njST6SFtv+8CQtnjYkk92MdGRa9mrc93AScUReV7kv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOTcX9evTxo1FRB9J0hTdp18eLGUmzDvBQomLqMeZMY=;
 b=PgP6eNe5AUAU9QzTWoV9HQ4ZaNdIDArUHZArsi29DyzGwIGhHVO5U/lOKvWlCrQRlrW/dQ8rnFj4xG93wc5dsd+Ku+qgfCk/F5YqdkHy5JyLyjaUnAWFJcWxLNEh0TPJ3NN64p29wgE1VQ/MSReYIwIx28VW5Qv4/zMT2wkGjb0E5iI6VSI0l/S01ot+j7WViqVEq9Z0ZN1xGsHkckQizNTAXbpyh2Lb73E8kAiGOd/x6RGKN9pt0MJuMTFePv+G762XyRinkBKrfIudRya+LDOlt+OqZfnlP2PSwScbvNmCmf5Y9LTAe7lZY9hBNq8K09iajY9C1ZBd5yopoefq8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 14:24:08 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:24:07 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH RFC v1 4/6] rcu: drop redundant defer_qs_pending clear in irqrestore handler
Date: Fri, 22 May 2026 10:23:38 -0400
Message-Id: <20260522142342.1536533-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522142342.1536533-1-joelagnelf@nvidia.com>
References: <20260522142342.1536533-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0285.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::20) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b11e240-b558-4ac5-82a0-08deb80dc885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mdVvZ1gRlNWYMZoIM3zPm8HUMbtxRyb4yeE8i9/OhWvZeH/R1FQo6NPC/qOvDthicbd563yZBbs0dmeU7wOI8n5ZJna/FGSdZiz09aNWcyTTgiw4BdokWk3W5QO2B28FagzCpgFD62W7xFZ3V7pmKivxKhH7v2pPgGHO2hvonTBCDaEurflIovvXyyNOPZjRUgAeBPDUKsEZjjb9ZhJWB5/lii+2rbP8e6Js2jPdO4EL+zhMtYbNjlRF6DYVadweYvpm5Rs+E+aVK0AXgVCGMp1EezB0YaIhFMiba6XkCgAiCtV2Q1For0K8y5M1WA/EQuTroNKDeWQ57wl/OBiiBlkSQH87QgBlXi4VUYLkz5zezvFGJB7mtkZ0mzziRTzo91D+xzGig+9uhJnpD5/QccXCDVdK182XKGDeAviE7PxMNi4td1ZSRqURKXxnArnfdDb9z+3AqTgOhwVuD5/3YtSLrNaQlFmKwJR+Z9otvaUPWK4Ypf8afZBA/lx7+he74Mr5LDzZzeV0NtX8SRGkB/HXoj0BL5aSpxHIeRbB47piXVl6Jz6VDowYk5uz+g/gAbFEz7uPUAPWw8RFlieElTZf2GqqE10f1uNXe3a4X48fdM1bdGGVLmuRYoV3JHMLu7MxLV3i3rLJKG3hmYBLhj+Tj2cTvMVO25M2kqkNz6of+xORnfYhzaFer34YvQ4dXYwxmCEnS35HJxXyypbhgADaYksBQ4HzZmPnlXsoGbY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(11063799006)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5p0hD/BqTAnX3zXZoBn646jrmAQTHZMDK/ywrtw4pvxEHBXDAdCNF1t+t9Z/?=
 =?us-ascii?Q?6relthZwzj0De4xk4edU0pcrQasJlqTjnXzXg1qUSVn+FPORlaWOIHMJi9Z4?=
 =?us-ascii?Q?grdaTNhew0EWb9cD5FRBXWn8oJ1/jH1U348QOwdYSdWsjels5yVOUfezrex1?=
 =?us-ascii?Q?eS/EYmS4MDROKxRFQTrmPSMCbcjmJKsB3fP2aC59090wKUbPgLzDDXwoooJ7?=
 =?us-ascii?Q?tn2fsyfOM2rs/9bPn4r5Gv++3UCAeobCkRRwInJxmAfkSvwTdkgkfDyBYvuk?=
 =?us-ascii?Q?iJU+M6Ax/ELYjV3VNQWazBIuMq9URt709xlc/QfryFAnd7jqoIT7y5osbibZ?=
 =?us-ascii?Q?6lGZ8bndNiq5J+MgHxeLHl5k3RI4BuknBXOJncdiIVisoNRv/77bn1JB74QJ?=
 =?us-ascii?Q?KcQNQanmpTRtUHG8NDJ7YrlAssPdlV9vuPS/gqVdlwlevmi63X8chsgcFsZ7?=
 =?us-ascii?Q?qe8OLCtON/IjJAxX9tFob2tMr2BTqLDXmeJ2XYHFsOOdYYiARPKtOKHOFPT8?=
 =?us-ascii?Q?kLnz+VkyL8V7m/fbkDDt+RGfV8enpFdz15N/2q8dghIfzpaRk51yZxbVBBG5?=
 =?us-ascii?Q?zLKJl5F+n4tKF94AC7TedTKx042YHR0lw6F2W9yFoTBXfLpXu1okiJtds320?=
 =?us-ascii?Q?upcB/k01x7+Jnznh2nqLuSg7Q98bRtxGu13S93VSzLr2t2GprhfA9T9S785Q?=
 =?us-ascii?Q?m2j3lmhEcm57kePBD63liX9rOpAZHtd1z/QnEwKqG+Bic8X8d5jE32kSuPKa?=
 =?us-ascii?Q?5eujkuQH6kZWB+k7kPGT2/USJAXGqbJPRoIAM3M3ldEYBKWTJ9qIDDV8RbBp?=
 =?us-ascii?Q?qQ0GyfsJTKpYs7YJmZfUlEpxCf3XbrQWYn8BBFsbTD4kXY22YlUJ8VRsEsEW?=
 =?us-ascii?Q?E7bZk5KDD64YlZzSgNPNGisJmgMIOKEtWwc9uhj9yIOtZyKIk3+AQM9Okl8/?=
 =?us-ascii?Q?+6tEvTuHCKSv2Y0Q8lV4iZTgySFBiCwkl+cuuSj3U8S0tELMaIEr+/cdd+ql?=
 =?us-ascii?Q?X/HeJlE31YLRF4HMRbMdn+ilNkouDCAZi8OCJ9imZkdgkCLrT9a4gVQRDq7g?=
 =?us-ascii?Q?VLJxLgPwAPrBbEJBTFLBVEgMXDKqUAnzO1k68UFTA2HaOQ6K40XHGHyK4Reu?=
 =?us-ascii?Q?WhXWUpuVWTStnRuX4bN959UkduiCzyJKUQOrhqBNF72eRfYp97li5lwo/ulV?=
 =?us-ascii?Q?RcqyQB+GyWGUPKFazG4YEC3JDLpsgh4fkZPw+hhANoNrJSQHntFbsxDoiBXI?=
 =?us-ascii?Q?Wbx1tFxmPn6HwIneScGrrvRNeMiMwCheMZVd0LCEpLbdHqTd333CG4dfeFpM?=
 =?us-ascii?Q?LaCR4AtXGWysliurXZCaRrE80+BsPac3WY9B6lKDrS7hG8O04U5Z3nZE1DRL?=
 =?us-ascii?Q?+UYJzDeOrkuLL6A1CMTWZBMR2rFEUUBVWitxnoNmqtcGpybOI8cGQpCtvY6G?=
 =?us-ascii?Q?dM4pYVFrscMSKvn10yNChuWACQlNVJwOHklOh7hqKfcEYrkaHCB6dYJWD1aB?=
 =?us-ascii?Q?W+P7lavY9JfRWMZ+GOJlfwY5BUZbc4eBceNl0IFAMBPm8kUHpIfIJsbbh06z?=
 =?us-ascii?Q?UuQeeVPwXg+uuZ3rYAI+wVM90P7nusBGterr9duaruZk3AUJ4pm95D/ImEKt?=
 =?us-ascii?Q?O0eUuQmpEuZqk2W/A+0UT9yFjF+If0gaVG5VqAlnivc9DQGumLfZIdUiZvSG?=
 =?us-ascii?Q?4v42ME15Gq7V9TNf/YRodqAHIwSPZ5ilr5uJyn1/5LAGkcqpZ7/B2WWNLnIl?=
 =?us-ascii?Q?2giS9DZACw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b11e240-b558-4ac5-82a0-08deb80dc885
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:24:07.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecw+mNON+Xjiv47VG9VfKRjDadTIyaKS3QTqV5GVA+XdHOAtE919AL3YZexmaWKOrIfbQszVlhvxeBQeVrdJUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

With __note_gp_changes() now clearing defer_qs_pending at every
per-CPU GP advance, the per-irqrestore clear is redundant.  Remove it.

Effect: PENDING now stays set from arming until the next per-CPU GP
advance, future arming attempts on the same CPU within the same GP are
gated by the rcu_read_unlock_special().

This serves both as an optimization (should not need new irq_work again
this GP - for the compounded section case, we detect and clear it there),
and reduces risks of recursion due to clearing too aggressively.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2da009dbe64c..bb5f955a06df 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -487,8 +487,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	union rcu_special special;
 
 	rdp = this_cpu_ptr(&rcu_data);
-	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
-		rcu_defer_qs_clear(rdp);
 
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
-- 
2.34.1

