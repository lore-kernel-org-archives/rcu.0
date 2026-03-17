Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6739479A;
	Tue, 17 Mar 2026 21:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783600; cv=fail; b=NTJtXfBrEiJupkLYkVkvJWi8kVGLRKuw3wLSYVnjzjcuIwpv27JyjAgkU3zsP9A6ngSbja6MxpvqWdbbv3zRodzyANa8NS3Wz/P0KlZhgI5t51G0VdxrFs2Fa3PPu5mLkvnEHIg/JEwdjjzJg//elvnpPRDHy8niPgNkqbK510A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783600; c=relaxed/simple;
	bh=hAL4lP2NzpHqWRj8kuxjCZm+ENrEJO6Xjz9Q5cuPd00=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hMx64ZK2SVP8ciusXVPYgZbV9ca3rwxNTl60tjdnbctV0hqrUGxCEcsNerzyElNf79FtPO0dNqZ190k6DvJXUfadbOY41Gw9/qpTC6OnaaBYE8uP2CGdCHnKYwSj9zBTSVufCg+Th6NH9uTJAjzggO68N6Ym8IzGFaZKHtO9qyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uOUTMiOP; arc=fail smtp.client-ip=52.101.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uOUTMiOP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+fZyaVLsozN1lLB/wfU+s59Kmxk39pV1zvhd1BofQMmTcsWP2LalTVI8u+hCVEbXAfWWQY1fLIqDQUnCbHUQYdNZgTxPQgYLZD9SrsP/DvvYygqjqGRzW0jQ388qZNDTCLjlTrvrGLbwXCtR1y3e9wVrL9eyUmMkUEkhZKm05asZcD703thk4NE+BRBanT1OG1QXdp90nShFbQea/iEPRD5Z6ZHXo62yglYeQvuJiZNPVjWmZIEItiK6onlkT5YGaSLqsssbZ2chghNyucQLWMVXf/7lrqEIp7i7/D+HhGFZI4cizWH9IV5M3cjBErmYip07UmSVvE/kAXhT/HsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAIoIRAgnr7usbcqCPjlhmWPr+9fOhogO/vbz5JibIA=;
 b=yHHok4tcwfue8a5Ozqs1o1bLJwVyBIIaoqlfMYEVaR1EGslEa3k8sOpTcmw8WbMGVyrvmv5KprxmOafov0PI+WXCGKWs18b9wKzp3svy/oOVEDNK4EICWeIPBhtx7yrT1YYZCg/wxj0+31q/+N/MubDlNhBfoUcNbv9ZpWqpE1FfDyBDLYB/6sOEfTVBfVFab34QbpJZr1a8sQSbdA4KpIDRcC5D7c98o+i2IZ00lp+E5PwAhBF4GW7ODqk7VQ+bUf93pAvR6rZQjrripsVdFNWFfH3upUg0XQSGFVbEQ1ZFL96seO8L3qtXkLRp7J6WbnxYNGiwAGJfFGCMBQcBYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAIoIRAgnr7usbcqCPjlhmWPr+9fOhogO/vbz5JibIA=;
 b=uOUTMiOPkhuaq6z/JqV5WzgWZn8T2CH6MPdujb6ycwLvt/yUiNQIwmM7jhj2za492wQmeCbZCqODMX8+NwvOgrdvI6fBL5P2u9qVEEaNtgE0Rhi1I26e3wRRy/TgENAm91VGogDXPQLMZYeY5R349PVu59OJqEBzi3kPHyeGZo8e6T6mKOc7Ju/5oUXwsMgpI8Jo34mg7f8jwi68cah0TV8VaQpCpr7rpsFRqAe9oUQ19P4nVvVfRRJJOSSS4WTGSfhcUGhhxFZEtH2pLrq+gjDFLcMp2MJbWWEHG4hr6LBXs7kyZmhjuN8Do1pTZYCKBQ1o8k2SbNEf67WjGhCqRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 21:39:56 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:39:55 +0000
Message-ID: <17ec3354-934a-48c3-8ed1-a68bf838e524@nvidia.com>
Date: Tue, 17 Mar 2026 17:39:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Add BOOTPARAM_RCU_STALL_PANIC Kconfig option
To: paulmck@kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Breno Leitao <leitao@debian.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260313-panic_on_rcustall-v1-1-a4f8fe54a4bd@gmail.com>
 <3dbfa497-091f-4538-8926-13f33fed3603@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <3dbfa497-091f-4538-8926-13f33fed3603@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:23a::28) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a61c65e-effe-4694-dfd6-08de846dbaf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	X55hdC5FT8sI1qLTKyo3BnL23JdAy+dMcvXs+9Iuj9dWuuPJ83/Nr+SjfjICRmqfPHoM7Aeh9Lv7EefmOqhpFG92D0a2jrhgWy0WOuYmi3ocIgXeSFpIhrMOTL80YvXsO8I7yjidmhgRz2Hx9g1trNFiOflCYOvIkwpbeNVdgC8jIZUErdPJGfuP0DdfvVwnHJeBewOXPsvX/N6b7Aju4xEwQPRzZ4vKG7m9w49cnVpe9jBQWDqCndkiJYbWICa8F/eZ/BpTnkS9uqnG66TJn9sHRNxU9wqPBwJSs9+UH7pQuzc6V+9sZ7gOJQDADyQbzoIY6zoF0yDrkAWr1PpUFyPDbzhVrb2rdC1tNLw7eBi1obmDI7BrcNFelFlxANBIDX3Ck2waBXqO1XY92ToaM0aGUcqXncx3s481N0HM2+x8BamDYGe0uMyMecuNNm2+aJvWk7SycZIj9z7mGyOJBo92zAdrmjiLZChqbu11mh/GURXAqsM8N5xye3obDgqAANdW/hSkmYtUVoPggHelFzu+1Yb/YQ05G8B/CmSMWSSyvylXrhpb9gLOY9gR5piIeh7ysTPlkc7YG/62IdVB7hV69EeNb2f+I09JZjvsKGZqNxHl86M0/kqYdum7LrByIEnEOnmHm/cFgJKpW61FoL8fXktQORRCGVMAebEtDxcxRs7fZlE6ALt+BQu9qE57m6wkChvQtK3qrR6bFLnKett52y2OwciuKzEDq9gp/Gs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVlzYkZ2VlVFM3FsaWIzUXNrUzhVZlc1MjZaTkZXVGVxR3R5Z1BZRGhFUk5Z?=
 =?utf-8?B?OEFlQ1AvRkJvdmtsUmtndFVJOW9HSXFhNlBvM200UGdLSHl0RGhFY1VFK251?=
 =?utf-8?B?cTdIUGFYdXFLeCszOHNUenRpVXZqSXVPenFIUmRvVm04MUdZMk5iS05QR0R2?=
 =?utf-8?B?aGFVdVM3WGtHZDRqejV0dEZJQlcrMk4ySDM1bURJYXMvdUhlWXhRRTR3UlNH?=
 =?utf-8?B?dXhWRzFOVEJPbHc0VVRodVh1cGIxUUlPRW5xVFFnODNpQ2NSRW5zRENGMDdT?=
 =?utf-8?B?YnZxLzNqaW5POG8wZDlaUDNEakxpOU5BOGViUlZOdTFBMG96ZkNIYjBmNU42?=
 =?utf-8?B?SlFmSzFjTU9aYkl0bnJacE1ta0k5M0dvQThsRFNXMDF6QXRKSTVJckFWZElO?=
 =?utf-8?B?MzVzM1JJbDQ2ZEFNOUhUek4wU3lwdnlYNjJhNktucjVoWFBQRFNLZUN1UFht?=
 =?utf-8?B?TTc1ekIvVitoWlBJcng4VVdtK1BjaXRFYTRrS0JrMnl6YXV6V3NuN3Y1L1R3?=
 =?utf-8?B?M2RGeXZsaU40RDVOK203UUs2TFZsTHk5QTVXbGdXSTd4cHppREVKVkxodytQ?=
 =?utf-8?B?bGlLSHIzWUVRWmdTUFhqdXNpdHJCTndacVJhMVNJaURYbWJ0OGtydElXUjF4?=
 =?utf-8?B?QURYaXQwZUx1YnBZbXd3OHc3T2hNcFAwVGEyRDZpVW8rc1JqL1lDK0lyTjJ3?=
 =?utf-8?B?RlVVNjlQQ202QllJcy9pcEFjcUxLRVo4TFdYdFIwVW50TXY1Z3Z0VUViQXVq?=
 =?utf-8?B?SHdFbkNoZHJaN25oRUpjOFdubXJ2TVhRNEg1aGRuSDFKeUhHTGs4RGdpNnF5?=
 =?utf-8?B?aWp4U3F2a2NndmlKWTFjcVl2SEdpbmVIWjRXa3VXaU5BaWIyYy8rQ0Q5ekxF?=
 =?utf-8?B?eGwxVHlnL1dzcHMyU0NUblpLbHhkVllpUHBVbFpMSGltckVXZ1dFSUloaDlV?=
 =?utf-8?B?NVVUckUwV0R2aTRqWnJRcXFWdHd3MVkxRms1b0tlaG9xYnhYSUxUWEIzemxF?=
 =?utf-8?B?YXhiTjUwY1c1TURhczVDWHFXMi9qWFh0VWhrZ2h0dldlanNZWVl4Y01WOFlB?=
 =?utf-8?B?a3MzWXhBMVRnVmo1SkN4WnRtWmt0ZEZGQ3NyWWs1N1hZK1FiQTBYVHBGWlR6?=
 =?utf-8?B?YXcxM1lQSkV5NUNiVTBROTlCTHpxenRPNFg4NjFEcVFCTXpLUm5jUzFNOXhL?=
 =?utf-8?B?N3hST0tWdlBNYjM2a3R4c3MyK090WHhraStxdmQzeW5GTmhyK2I4S1hEOTcz?=
 =?utf-8?B?eTR1djFkdDNJcHhpOUZCNXhzbjg1UEU5UjVqcndYZVVSMVpFN0tZMDJsQncv?=
 =?utf-8?B?T3NHNDZac0JUV0RvZ3VlV3hRaFhoSzVIa09JNzg3R0E1Yjl0Q25BWUFFaEVt?=
 =?utf-8?B?K2F6Sld1R1FHckZlZHBTbkNUVDNGVlRjRzBjMi91aFU4SXVtb1c1VElBVTho?=
 =?utf-8?B?MkV2S1lyU05UaWVIZ3pYZmt0SzIyWHdhcVJNR0Q4bDhLakI3Q1dFWmwzem9D?=
 =?utf-8?B?ZzBVOEZBMldMdFZBbG0yU1pDWEpqcnpVV1FGWWxQbWZaeDRpV2RoY1p0NzJD?=
 =?utf-8?B?VmIxejNsTUkxN0F6K0N0UWQxQ3lLaHFHZmZ6a1lPYmMya2VOeWZkNzRYV1Nq?=
 =?utf-8?B?ZkpFZVVVbnNqN3ZoT1BaTXVqaDZtQmdsMmM1TzFyd25hRHU5cFVUQnhSbGh3?=
 =?utf-8?B?V0ljVkpiU0ROZDhOcHhqN1hERXVWb3I4N1RJQTdMc21sRHYyZVdFTXZMd1NY?=
 =?utf-8?B?VGtudU9HbmZYWXVjVXRyZnlQYThwSkRQVGVRWW9XeUNxQ1B4YjZiN3Fxc2Uv?=
 =?utf-8?B?cUZwWEVwa3piOFhWMC9kaEJ2OGlDTksrS1FpN3pNSjB5L3kxTDdiZFdmZHVN?=
 =?utf-8?B?UWxqeFdkaksyZW45a3ZYOGFxY08wejFRT2d2NWhVYzd0Z1c3VEwyZ1djeXNh?=
 =?utf-8?B?aE9ZRzlHMHhmdUVrd1gvM2JKRXp3YWxRYWVDRE9oc3pDRHFOOENtWFZPWVVY?=
 =?utf-8?B?alU0UFZZb3R1REFvQ0pXcGlmcE96U2NLODlaNzg3ak5HYVJZdDdsVktob1dF?=
 =?utf-8?B?NGxoS2wvb1VtampqQUdVNDlUazVqZ1M3L2hjMWx4emVCSzdRRTVHZW84OHls?=
 =?utf-8?B?ME9BRm9NNVpWdlM3U1NsenE2TmdmeUlXbS82MElpempmVzFBYXViZG01RDkv?=
 =?utf-8?B?WE5zYnhXQWcwbGtWaityRTlNc201QklsWWVLTVNyNXQxUmZjc1Y3bk1SazM1?=
 =?utf-8?B?cjFXYWxsOVVZcHp2TXA4ckFFSkVYZGJGV1JFQTlVNFVYQ0lzdDJUdDEzd09v?=
 =?utf-8?B?Y0hmRjdRL3NwYklCbnFxRmtzVzh3UDZhc1dncFc1T0xhNUVvQUpxQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a61c65e-effe-4694-dfd6-08de846dbaf0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:39:55.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pq00lgTfMtNk4dU/umu/fX80+mSXAmXVFKJmsQDnacA+ZzMcZk5otJ/tpCbmvgasyrXwuTqNlGBWG1yT477jtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954



On 3/13/2026 1:07 PM, Paul E. McKenney wrote:
> On Fri, Mar 13, 2026 at 09:56:49AM -0700, Gustavo Luiz Duarte wrote:
>> Add a Kconfig option to set the default value of the
>> kernel.panic_on_rcu_stall sysctl, allowing the kernel to be built
>> with panic-on-RCU-stall enabled by default.
>>
>> This is useful for high-availability systems that require automatic
>> recovery (via panic_timeout) when a CPU stall is detected, without
>> needing userspace to configure the sysctl at boot.
>>
>> This follows the pattern established by BOOTPARAM_SOFTLOCKUP_PANIC
>> and BOOTPARAM_HUNG_TASK_PANIC.  The runtime sysctl can still override
>> the Kconfig default.
>>
>> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Applied for 7.1, thanks!
-- 
Joel Fernandes

