Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECEADF76;
	Tue, 15 Jul 2025 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609742; cv=fail; b=JBQCJ1XnNZpruJefgP035+oqArrN3QtvI4XoHGEWpKtFcaYp2gGVmhrX+Z763Sy7SUIfG8FZz3AT7KISkIwbzpDI8IEcdtP15ASw5vv35603iOSZ1WZynbRubVmg3CaRJ8T++ULbbXiH1y0CE1Y90C15nlThjKJEu4uIZ6rXvVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609742; c=relaxed/simple;
	bh=PKLAwT01HIbIi1cSQaMnYJJNAaq+z6+fxpp9Zgg7sP8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YfxHFc/7VaeCJFkzSJqxtFwYHajcZDy1+jt1uAnh4KGYQ+AaVrVuwT29yX0/RuI3+742P2zvgRRHAbx4jtsJc8/IdHi/VRkd5ATwZs/j3OVpAYtmmHwtaOqChm4GNKlyJgc5Rl2Nc4b2JCbyPPcse9hwmMe4jsfDubGUOcnpRDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DM849Jji; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DM849Jji"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iV3wYR1cjBHRl29TuT+IyxMcNfxmSNVX4Tkxu6X+81AVD7QyCPsDaFEAUJQYY+UdfrnyD9mju50TVnPcxmeKUK5QSnduidYYWF1pwloufjCUpcHkyCchR8x9V/fqCVEMJdvIKmYwNfz+6tPOTluJIKRzhzPLymF6J9WqiepJttjsm7gvkSuH8TZnTn+eT2KX3z0bUpclrsIWS1bzOECcePtRQCe0caldzaOah2S2tykoMFCsndpv4iVctscNuQ9/viSlVZF5N+AQkjlI0VpCymG1VhLc/WdwzsOpxihp06U49covZnmBIG0VSjjrLar2hJMuyFR21cFOwHOTRGtdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubSdWKZekMAftX3yfRhXACeXcWKGEzdkz2xjQ51cVRE=;
 b=wedkrjBgeD7Ip8HKbdtFam5kOwebtNkNt4oZRK22omEk3zR7W/2VKPATPTQJvGsYJbc1a8K/uFW6R03G5pUdL5Az/ilhvQUiAXJqqJswrnM/bAtR/AcjCfq6VNov8DRYDEKHWbVE0jpEaAggzKzF6FIHuIQ5mCPe6jZukzIIVUxfi/1NcqHHF03RoMBJOrkOIJLBQV8vfchzc8VIGDegOi49IrLm7DCG1U5dA0bflB2+tFim6L0WogH6GHr2R4Te3+9vbKA9tj+0LUCnQ5w5xLzWNqNvhWgNCaYtbxWJr/QCl4ufYzNoGjxUKpPUqQkTHuhfIBxbPMrrCReglH/16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubSdWKZekMAftX3yfRhXACeXcWKGEzdkz2xjQ51cVRE=;
 b=DM849JjiKqwz8dcILhdap61tKRPUZJMvXSG/QHKKeyu+I9S6I1wR+tN+IW3n6vvDLjemyeEBtgYhmgi1XdL/8UkY15UL+LxJPBKRjJLCrEFTognc79rvsmSbnflaWn8sKDKI43klvSCLZcQldP67/rq8m36K9ak7H02TNRRAZJhmGAoues6HS+SL7rfyZsT7SZScHHtQzbH/6s1496nhWrn/LgvkQb4EsB5RAGjbdQp8VtmtrmivN4H+htNKqTzopLpFC+S8pQOWe4iS6ps08touLiIqw/UQnKpVfOftoQdBjzOYWHiCDn80SsyqEWcPIG6//BTfsHDA4KRUoy2MoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 20:02:16 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 20:02:15 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	neeraj.iitr10@gmail.com,
	paulmck@kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next 0/6] Patches for v6.17
Date: Tue, 15 Jul 2025 16:01:50 -0400
Message-Id: <20250715200156.2852484-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:236::7) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e1dde3-3f38-43a8-6516-08ddc3da7ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z57R/aMeKZqYn35tW0ieXcnpOG9aDWCTiKqC5ToYzg5tfG+GJr3F2CAi4bbO?=
 =?us-ascii?Q?5B/coLBl+NoKhLeDIC6vdE3FltsJWCtbZk/a/6NVxcO7c1+GSldEGKC2VkhI?=
 =?us-ascii?Q?8Wtr7IcKuNbmthISCdIWF2dcd+xuq3yjxGhHsVjPsrE+kZcwRD8o+eqO+16T?=
 =?us-ascii?Q?KmJ7Ey45pfwJXhyssTJAgpbd6Mj5gXeeaWwD93keM2EkYeHC72fs3mWZfVNe?=
 =?us-ascii?Q?NXsFpnpxsBXZwj76pVw/fBdaAJHk0Ji1kDyyfocuy4SmgHCBmlwDArv7oPP5?=
 =?us-ascii?Q?6Z7Es8CICBuTWSTdqrp0yMV2HyR7YacIIiGRKPIvV/owyqqgD+DQzKZ5SFYH?=
 =?us-ascii?Q?TJqLsEhnIc2cFFDuVSRNqnOh5ataAUdYdIXaD6JRgXlVHoy/SodF3vTE/hvY?=
 =?us-ascii?Q?ywZMAz2ucHsp8RDnHpuMGlKnAD3aKsmmtQUpeXhJyg0xs5OSe2rQxGX6YMZE?=
 =?us-ascii?Q?CtdtXLpeWoC+fqafgFWzRISIGaCk6NtqguQK4z4FAZ+0c4Z8K4s1O4e0GYp7?=
 =?us-ascii?Q?ENITEaYLWOuVSd1eUwT9ZrHyxNHHDAsFnd1dt+gszLmvGCu+Yv3hsw23eHce?=
 =?us-ascii?Q?c5/wsRrr4E5sghWUrtPC4ed51SsMY8xQoWsi8wsgADiyPhy1kEQNNKuzqyqz?=
 =?us-ascii?Q?bxtuICzUu3EHekpnGCCjg5w1cW+PRRc6mxRlyyMGcceXcdhsp5hRmjYLuNw8?=
 =?us-ascii?Q?4m/nEerGaJleEbyClEHhy09XpaUd3i9sUloSKSpS/lmbIobKPod1fgUC34dk?=
 =?us-ascii?Q?A/UnvOLVykCEz+F1Wt9YmH1NNItZlHxd8o7NASwejbsw8Tqj7Q44z8njqTOS?=
 =?us-ascii?Q?W6TL2f6EmsvKkycA1sZHmyYsig1WGvp29/SJRUqr8P7/MwoEvunUinqt6lEr?=
 =?us-ascii?Q?LpmsgZArfe9FP/NIqXZlGayd1jQlbw06YENISN//oPSO4muojOHIyb1Iq8K3?=
 =?us-ascii?Q?M1zmBmQ9w21AIxG6EouIzDt1J4AYNAUNXTRkUQx6f8G9REK0Yxb1enqp9BTx?=
 =?us-ascii?Q?L6nyLikY99H3t10hHt2GFpXOnvhE4HtRRK7xEqzZ5xLg9B8b+f6wfIzwJap1?=
 =?us-ascii?Q?IWoDIjJ0/JZlnq/bXtSoH/qYngkFGStj73dnEvTFKwTbUhfUDdAwyfAli29N?=
 =?us-ascii?Q?iddvv6RYw/0FkUQUYJvidpfnKMALNx4ntL0yurmBt7RlwW0Ox0zRfyAC38xH?=
 =?us-ascii?Q?fEoqbIQEpmiArvUTXexVLeDV1X9vEQ5IeNMNKULPadzpfhYhM4ECWQVw0don?=
 =?us-ascii?Q?Gmhjzhv4Qc2HOTm1NuCgwtnUUEExqhOWWaH5fu1IyIh/LRW4DBJjCcRlfhQD?=
 =?us-ascii?Q?MI+S5V9s+zZCw3Sj076A78SJpk6j2dlHY/qdC0VeMpvaH+Vdg9eBYBAERnUC?=
 =?us-ascii?Q?CmAQJLJsM7vG/YJPWihV76IafXz9JX8pk58LxHXs4AydFbONhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wzBoANJsX/txlP/najKIWnNxMAUpFkwdKJBj928mzO96npTrP88Tff5uui+g?=
 =?us-ascii?Q?kZeXpPsDE9lhNlX+dcKN6p4pOBEihQOLKuliPUDccadrArMEKKMHHAJQ6qH+?=
 =?us-ascii?Q?SKVrfazI3Xl0NUGK5Ty98jQWpIepSRGAJ1tt3EoQe3hSLjlcpZdpHoh0blfa?=
 =?us-ascii?Q?GfpnB5ZsXas/lJGzwobowSOj7UMsa2azXM/9ghZRg5GM9c6SDkBZKPS5+3uE?=
 =?us-ascii?Q?Zuj/jPGPWFIA1elwjD51/CoHobFpK/ILkLs1gg/qqrx1Z0j2aEFwqOeiasF9?=
 =?us-ascii?Q?SsVXpJji8KwYsbxOTmKrKBi9GD09s+i0gUHMT+2MoB1YauNDyIGSbdHaWjb0?=
 =?us-ascii?Q?zqmykjuHCr9nnElcxARapeIsh5ZosQ4ljcTxW+P6bvAEbipv96KgKtElFywG?=
 =?us-ascii?Q?FU67YteC2XJcLQrzBjThz2Odm02WXh2MwR5GUq7HooZb4PDwi+nCLCw2uHQx?=
 =?us-ascii?Q?N5Pp3OUPrFejv7AeRuLV2tGcOiRd4zMFUnq9S5eF3iNiSZy/RSCpsCYF7xCA?=
 =?us-ascii?Q?k3w3HjOvrmsdCvpEl1/FEYFYyEjM6yzPS7YDieZthssIsX1nVrTT4uKWKuhi?=
 =?us-ascii?Q?iB+baNLBudi2E/q4YxnVWzK9EYOuYgCh1WfgKng0FP8cee70fIU+XEI0Letp?=
 =?us-ascii?Q?eVm1bExN3ANu9uL1bMzyAygG6PyYfAI+qHOQ228CtsJ0EUFwOJKiOth/x6/f?=
 =?us-ascii?Q?uA90Kb1ceQsEuuRkKM/wd3fvXxTXMeIekIWElEyEsSUBS9f4sdkCX+EhUUjT?=
 =?us-ascii?Q?5is1EGsBvzP89CHwAentZARo6yZwhmq8aJzYVsXMR7DBxZ9qe5OSJ13wMM2n?=
 =?us-ascii?Q?oXzojghJGvSdktCfsjXayUp/AjzlpEKkubpTFEuvUxJTyVPyDQET7uTY1YTb?=
 =?us-ascii?Q?ZQ0p11zd814EQ10XsS/w163EEHieVWRwAB/pRBvm5kyaZpEEO4DbrB5y6ehw?=
 =?us-ascii?Q?c/68sDyw1UYii9q5zvnTbiFQ9FpOtM+ebBhL2qIeYBHmUzarRCTtGEiQqHew?=
 =?us-ascii?Q?IP+fGIbA7MMFoJJb2Np8pak395e5VMdQXSCk6dJikl4og8RF4l26akT4+tFs?=
 =?us-ascii?Q?D18pf25TcRprkbzgjtn7Tubv4KmVCanlA2XeJ2iWIHy87mqMNun3hsZVFRn1?=
 =?us-ascii?Q?FHPAo82PaCHkz0iyxnrIwXPKoYDAyO0fz+LtWAay13rdImnu3E8aB02DijtT?=
 =?us-ascii?Q?gqHiXxq8mNr/hpHd7dMWF6wE2vKvKYIDEW6IRCTXV0uWvKZyzdvKDKZfniNi?=
 =?us-ascii?Q?jXDfFHLQqjWKV1SM09h9Duz1ceMYs9c89gwmbzvuSqbWgoAzRqGB53wwNZZI?=
 =?us-ascii?Q?PQWbqC4M+LAL0hwBiaUiqQq1sZLzkJjL4xM6Kod4HMWTP/7FP9kttvoqUfZM?=
 =?us-ascii?Q?ARAfoSXxZjiIKkMAfaptEBHXX8cz6/xyWVcGIiujCn5zQQ5NpF+Cp9W9QE95?=
 =?us-ascii?Q?2nGsGNZikwofEWjHqJwYt0sx61+2hvOWlEL8fYA4I6o/SAzvYccGdjSEUMzP?=
 =?us-ascii?Q?Dpa3cyIVhXndfZvtFAfe7idS8dNzDfX+ruAgxW/c5mRgst/du8BDQYeqeH9G?=
 =?us-ascii?Q?GorylTSBlmapWRre/smvrzG3f24Q7PqpmjUVBccE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e1dde3-3f38-43a8-6516-08ddc3da7ec8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 20:02:15.4907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmThjnwR9n1lTg5OAynBfXOXuCmROemQsrTopRLvyPL6wgoXrQHuc2uB2zJvRON/6jg/yN9IAfF5nNnrZCYeXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009

Just a repost of patches with tags, for our consideration into v6.17.

All have tags, and the last commit is a fixup for the deadloop patch which can
be squashed into the original patch.

Joel Fernandes (6):
  smp: Document preemption and stop_machine() mutual exclusion
  rcu: Refactor expedited handling check in rcu_read_unlock_special()
  rcu: Document GP init vs hotplug-scan ordering requirements
  rcu: Document separation of rcu_state and rnp's gp_seq
  rcu: Document concurrent quiescent state reporting for offline CPUs
  [please squash] fixup! rcu: Fix rcu_read_unlock() deadloop due to IRQ
    work

 .../Data-Structures/Data-Structures.rst       |  32 +++++
 .../RCU/Design/Requirements/Requirements.rst  | 128 ++++++++++++++++++
 kernel/rcu/tree.c                             |  31 ++++-
 kernel/rcu/tree.h                             |  10 +-
 kernel/rcu/tree_plugin.h                      |  90 ++++++++++--
 kernel/smp.c                                  |  26 ++--
 6 files changed, 293 insertions(+), 24 deletions(-)

-- 
2.34.1

