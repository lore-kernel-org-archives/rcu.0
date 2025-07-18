Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0843E3C01;
	Fri, 18 Jul 2025 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832066; cv=fail; b=Dlmom5TEt4QBnD7otyK8z62KwFEZIroq//VmG38370SJ8i0+jMiKMI7+u+wAeroZeuZ6FjhN1eqScAVhsV3mL/+REYWdFW9LhT4GAQ1S8u9RoO5a2OvdOjQ6YuzCr7b4SyVLEduXueYvOuKsZROWNPUWDRbpfOgc1NPzuSXI4DA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832066; c=relaxed/simple;
	bh=sChljU9z79mN6aArwmH5QeY/fzLb87zyrYs5yMu0XVo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hvs5Sl/rtX19jITvM0E1LNucEPQhOsQfUTEiocN2w4DhVCgVtSL0fbVjstRHp0Xp+/TvbOJCJRECH4k4BJ6YyYw0wT18Hr5+TNwbcv7JBM+UaJaWN0YJbK+yaC7DbQV1ia7zWtGvW9aFZ/WsNhaTpL1PtsEAY6loHs1v7uXZgLA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OJLCO0U1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OJLCO0U1; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OJLCO0U1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OJLCO0U1"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=zNrhUFMpUANf1Jajfnu6qYSd8lNnK3dCoB7ncSMUqwtpyRaChWhQwbzKifWgv6WAQvbLzFJcpjrjaiovGCuPOI1hRQWgYbBW0nTfgVlBeIZ50b27hAAb1SEhRK0sKTZd0R3FVB+PH2gOn7Iglpk+JjTal/9oupISOxiVqZggWw87AADaZefyxjzw6jGjeQIWmrzCJPEi3Lp6vj/J7ztaCQb44pw2CrPaMRRtvL7wWh0k9w2aKQWftFefm5WYcMMzGyQ6SoJtWGkZltCe4GQmxrcSyhv38ynzNl32se8sjHpyKEyEAkpO7dQP6n8+HJ3dqMUg2PXkqLdl3ZpVSY4aIg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDvIcOFLhXp8DkHzVLwWM8N/0usnFi0CzoQcu6g3voM=;
 b=nGzT1rZXKlnuTQ8AbgyxaEaDERbRaRDHM0OweW8528aPbAw6yvpyPPlTG6CT7yELaYW7Q69duXz0JL0erhlCx9xXWN9zzdH1ix4G7h+qn0MViobRlztrHC27iiu36Y33vs7a+H1Vz1ewlYb3DjyYe5o7pcaDHKmYPxbTWU7Cvw/L2JW1v8Dc9Yiphcj8NJNAdRHz2VuJxi19wJxqX9tpyGnsAdnY0aK5QWaRL1XWnErqZbI9ec/7llf1txz7Xb3YBIp4dfse8c85IfVW8m/qtAPFi1KYrf5mv1BkI7Xxqhue8aIqUD4tAvpHfP7S0Z3bq6bLl38HqFq9GIS2+VwLMQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.dev smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDvIcOFLhXp8DkHzVLwWM8N/0usnFi0CzoQcu6g3voM=;
 b=OJLCO0U1KZNCE0QqNk2gzWtlRISZ5hjD6u+OsfS2OlaYVxnd+F9zzs/c5OSG9VZUDqBWyy8rhOneDkoopqYq2fGdbWCBjfZx1tGweQR7sID/WD6q+x09Vpyzw93vKL3HqJEWYTrHkMW0WEJbr2w+1Ltja2knbedN+FGbOv+svWU=
Received: from DU7PR01CA0042.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::26) by AS8PR08MB9979.eurprd08.prod.outlook.com
 (2603:10a6:20b:633::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 09:47:38 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::37) by DU7PR01CA0042.outlook.office365.com
 (2603:10a6:10:50e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Fri,
 18 Jul 2025 09:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 09:47:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnNZ+nMbh6hhJKYCIWgj5dQg/+ewCfq+4shHnKr2FpWg4g+IhdpQ9texJQ2Uo0S8/DDP20but1lO9LikCz4plYe2BXDG8fu7Gp5YayO77fxIVRYfsiahQRAPCX34RRhuLtEyiruLT6tY9mtYffps5kUmyJrugoIZew98xaIDP062RmNiCQrkX95dygE51W+yZRGAjNA2Gv2lL4rKptXo14LtTUuk5lACi2WS/F70uFsB09jR2Rx/P3T1fV3TmByySvI9gJDEJYmbOGX4M8YEkQWVmV/bmob31XAXpwhn6mDpEaOMzMyA15ijqS+SCEpnbCMFhva/XcWwRGzmybf2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDvIcOFLhXp8DkHzVLwWM8N/0usnFi0CzoQcu6g3voM=;
 b=T5xdJaq6aNS4l/NL3qpGu1Daiu4K6vA1wOdxEiMeWqp8WCov+u30iENkJKw8SrGk8LL5wV5Rqmoz5qa2P9VP1V5MY253t5xU3trLBiZiK08qTkJyEK8Uwp4+0N4Si488BcuvcztdYkI1u1KGsyycjbn6KttdHM0dk05vdEQOqAfP638wPrGFEJKFC72vXkPrnkU67YnNGOm336knge6wa9aj/eHvs3twoHwlIzYYCv2e/lZmokwJXlr9hyeAEBBa68lNFRfqjciIFNrp5yLXZJzswZbR5aDty5/mlVj3LLS/yua9comoUN6dTmA/c2yLywy9baJURhIlOaNdDX6TOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDvIcOFLhXp8DkHzVLwWM8N/0usnFi0CzoQcu6g3voM=;
 b=OJLCO0U1KZNCE0QqNk2gzWtlRISZ5hjD6u+OsfS2OlaYVxnd+F9zzs/c5OSG9VZUDqBWyy8rhOneDkoopqYq2fGdbWCBjfZx1tGweQR7sID/WD6q+x09Vpyzw93vKL3HqJEWYTrHkMW0WEJbr2w+1Ltja2knbedN+FGbOv+svWU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB10069.eurprd08.prod.outlook.com (2603:10a6:20b:636::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 09:47:06 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8943.024; Fri, 18 Jul 2025
 09:47:06 +0000
Message-ID: <d68d1947-3ef5-4171-aa0b-73f7189b74ab@arm.com>
Date: Fri, 18 Jul 2025 15:16:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Replace (20 - PAGE_SHIFT) with common macros for
 pages<->MB conversion
To: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org
References: <20250718024134.1304745-1-ye.liu@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250718024134.1304745-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::9) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB10069:EE_|DU2PEPF00028D11:EE_|AS8PR08MB9979:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a17a62-3b12-4f51-77d1-08ddc5e021b2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?eEMxckNZUDJYeXUvVldJaFRXN0Y0V0pJYlBTVmlaZzAwOWhHQ3NnNDFjdFpG?=
 =?utf-8?B?YThuWStJT3RRNEZFMURacVJ3cVRQT2FCRitDMHVvd3NiUjkrSFYreks4NW9S?=
 =?utf-8?B?Zk8yYmJrcE5WeTFMMCtva2h5S1pFQWRIQyt0dDlNZHJITHM5a3dVQUFmbm9B?=
 =?utf-8?B?blpISzZtZW5OL2pqVHBuR1BObDFhOENKbVRlQ1hIcnRYMXVYb3ptZDlKTU15?=
 =?utf-8?B?c09SYXNqVGZ3eWROTHU3V3Z1d1VYdnFiT3V2aEowVC9ERmVBTlRibVQvV1RN?=
 =?utf-8?B?K1lZcjh1eDR0aWpaRWZMaVRLOU1zRXdLZHZsNU9EQlVwK0s3MzYxRmVLN1NP?=
 =?utf-8?B?Ry94MkMvRFJ4dnRsUjdmdTdJWkt5VjNNWFh5bkl5WmZkQmlVdnZjY0NuZ0RE?=
 =?utf-8?B?a0dRaTVCS0hDdGNnU3RvSytEaHlRQ2U1QTRQS0U3eU50bXFGKzlQaWlWeDhY?=
 =?utf-8?B?dnVkUFowTlNzOCt4RUtrdUtVWXZQQnBLdWQ5OC9hY3htK3d3SUt4ajJrcGFh?=
 =?utf-8?B?MGVhaUQ3dXRqRUpoUTZqUU8zbXZBQWRrK2dGQyt5MWttK2t0TGlkdW9waUtv?=
 =?utf-8?B?K3c4MTExL0dhK2xZeDlYQzh0UXpFKzV4VHNLN1FPTWdwL0dxNGViL2hXLzI1?=
 =?utf-8?B?Tmc4bHp5UERaR3FHYUN5SnhNOHNYOWFTd2NDWS8rZkNvTlF6MzFUSE50YjEy?=
 =?utf-8?B?QnlETmpoc3hYd0NlYUNHWFhYd2NaODJZNmcxWkZScDJLdzVIejFSRWhKOWhF?=
 =?utf-8?B?dW1OWVdUR3pBbnhEU0NtQWptNE1jTmd2ZG9rMlAwdlpKMGd0M3poT2tBZ08w?=
 =?utf-8?B?eXpnQ0FlYXd5R29HME1FUnkyTkNVMXJIbTdCTks4ajV1Qm1HbURNM3ZFVEVu?=
 =?utf-8?B?dkNlNFhudmRMYWltL3ZiVVY0Uit6VVBZclRhYlVvQUxQbUpXdEc1M2dBdXgw?=
 =?utf-8?B?UFI5NE8ySUoxTVZrRzY2Tkh5cU5NZWIybk4vY3hpcDRlVWNwTENySEh5NHdZ?=
 =?utf-8?B?M1RSMHp1YlVEcmVYdEV4R2ZwSkNmRWlPdGM1UUNSMUpIWWhXdlM4YnFISG5Q?=
 =?utf-8?B?Nm9zNGtIdnZjcTQ2MXVyWnZ2dDdWMzV5S2NNK2tGWUViR3NOUVVod3V0RWdI?=
 =?utf-8?B?WlA0dUsyUHBFOUxtNHVES3dKT1ZZemV5QWpCNGxoME5MbzlxWmxmL1dROTcr?=
 =?utf-8?B?dUUwdDFjaW9tRnVDdkJTWUdLQkRHR0NlMnhFZVJNc2dBM1RIc2s3eEJmc0lL?=
 =?utf-8?B?Q2pmRXpOeWpRSyt6VUlQcmhTVm5ZVHR6KzJlekwxQ1pLdlJQVS8xREhGaDlk?=
 =?utf-8?B?VjZrOXpHQmtXMEhCYmVkbWx5K3NqTzluQk9tR1prSFowTmxFUmRVTndJdXZj?=
 =?utf-8?B?ZkdRTU9ZUVAvUVZuaFdVNS85MXFYV3VwRm5NTkZoR0hva28wSjVsMTNERkRB?=
 =?utf-8?B?QURKMkxiR05KaHgxY3Q0c0ZhUHhQWUQ0akZmVGFXc1ZlVUxtYlhsMFh2RFdG?=
 =?utf-8?B?VUNiZGp5NzBxUkNxcG1xbW16b25WN2lvOUtxb0x3QVJKb3JvM2RXZTVlTzd0?=
 =?utf-8?B?MGpYd294Ry82d0NoeWI5dG1LYVFlVkFpT2lQeCtDZFJUeUxMWlRtV3lGQ1lo?=
 =?utf-8?B?MUtYWDE2N3p4RTYrZWFmYmlqRi9lWTZKTUJ5UzdiWHJHQWR2OUZYVDY2TlJY?=
 =?utf-8?B?N0tKZTVucmhlMUFPWnNtb2Y5a2pITTlSVEdUelBiak9PSXR2M3JwZ1M3MkdH?=
 =?utf-8?B?NzQ3VDFpSXJOa0tMN05nVDdoWmIyNnBlUnh4UzZUa29XLzhjcFNxeW5rQlNJ?=
 =?utf-8?B?Z0hvOUNvdnRtNEJzV1owcUYxQXRnbXFwZEV5V2h5V2Z0TEJDeCtvTXNxaGVu?=
 =?utf-8?B?UlBNU3NDY1hyM0J1dVJQVnVyblRienU4WFc4Y281SGRiOG1wN25uU3hCQjM2?=
 =?utf-8?B?OUNsMFhCSlBPN085TW5jZzl1UnJjWUhaY0dWdjBhWGRtSHJTaDRXUEprM1ZW?=
 =?utf-8?B?RWtUZElZQTV3PT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10069
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0241f60e-0938-4bf5-decf-08ddc5e00e2f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|36860700013|35042699022|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGhodEd3aEl5djJvdlE4UWJvSzAvTWowSTJVdWd5RzU1cUVKc2xpcjdVbFZH?=
 =?utf-8?B?NWRrLzhSaUNFdmdka091Q1lieHhXZ0F4WHQ5NlVwQk0xTFl2aTRUbkwvY1JL?=
 =?utf-8?B?dy9UOWtqM1J5N3o4QXVaNWd5MEg2NS9vRkM4T3J6UmJ5Y21KcFl4T3ltVUVw?=
 =?utf-8?B?bVJPZmlyVWExTXFYc01jbmNEbTIwL0NMTW9VZ09OcGZlYVRubmRXRkQ3Y0tH?=
 =?utf-8?B?c2xQRVpJNW9HRHdlajV5enVIYVltaXBoK2hyQzNxYWhwOGlMa0VMdEVrODQ5?=
 =?utf-8?B?czA2a0pmbyt2RlJ2TS96VGY3clNOQ0htTThDNGhCVmJvWHJuWUhEbWZ4aWJq?=
 =?utf-8?B?Ti9YNWVzVXFRZ25sMXRyOGdvSzR0V2hkNG4xSTY2U0hZSDFKRmVpQmluVUlv?=
 =?utf-8?B?N0F1NHlZVEU0UzNVMVNLTExqOXNZZkN4YUxZSmxtSFBvMGNEUk05U3pNdGpY?=
 =?utf-8?B?TzJEdy8vVGdYSkNpcThLRkVVSE1sWlY0bFMwWTdKQ3VTOFVqc2J6WEVIQ0pq?=
 =?utf-8?B?S0d5bXYzUHRPUkhiTWkzKzhaY1h1a2hjSms2WEkvUEJSMjRHTC83amM5WElY?=
 =?utf-8?B?UVcvcEVrTE5oNldKQjc4MVlWOEY5U1BJYk5EdnlidlBMSGw3OWVsVG1WR0xY?=
 =?utf-8?B?dWpHSW01bGNaZHU5czNpL3BncDBWeCtJakY3c0JjbGRGVnc5bzFNVlBIcDhS?=
 =?utf-8?B?TjZld0ZSc2JtVkRvdXE3YWd2dlRDOTZ0a3VPcGVUbklzcDVNSGdtS0Z6algy?=
 =?utf-8?B?eWRmRTNDQlQ0bkM2Y0VtRXNndHUwc2ZsVEhrMHFrYityZnZiQ2RqR0FqeDlz?=
 =?utf-8?B?dkhkWWh5UDVjK09MSjMxV0Y2NG5Xdmd1V2NlVzNjaVNZTjFCQXFObFZCZm9x?=
 =?utf-8?B?UmM1b3Y4RUNzWUg0T2tJcEd1dlRGOEk0ZG1pc0I2b05MdjNaN01ibS9pejJp?=
 =?utf-8?B?SEcvTlRZM3BTbXA4YlZSQkR1eENydTV2VStVZ0NsK0VHeWpxUi90QWN4aGlY?=
 =?utf-8?B?NWlIeUovMGdWZitVVy90SCtwODBVQmNxODBYK1pLVjE4Wmhwd0g4clFVSy91?=
 =?utf-8?B?L3pyY2l3amNJVnl2emQ4VU1Od0t2QWhNQXJ0WElNaHJ2RnpLalkrK0JJVHpB?=
 =?utf-8?B?TXVDeUo2WFphOVB0L0s1aUV0aDNCVkRxMlVnVURiLzNDYm9vYWNMdjJTSmR4?=
 =?utf-8?B?SVIxTzVEbXc5bmlUZmRhMWZ3ZDl2c2Z1aHQ5QnBLS2NIcjZ1WlpBbjZUVVM0?=
 =?utf-8?B?d0EwN05wRytSTksrV2hWL2xCSEFTVnpYR0R5ZjE2bml4cVRZSmVnK1ErbHZM?=
 =?utf-8?B?Wi95dzNMdnMxbDRQM0ttWFBJMXJ3eG84aVBCY3F3aWU0UVU4ZWhhcjhyWlIr?=
 =?utf-8?B?SGtRdlJ3UTByN1gxUjk1ZG5ZV2hQRHpuR05jeG5CQU1GQndSQSs3aVN1Smwx?=
 =?utf-8?B?aFRaYmJOaTV4bENtN1RYNWp0R1ZoWVVEbHlMRzlVaWxya2lzREkrU0thZ2hY?=
 =?utf-8?B?ZW03T1VhMFpGWG9ZOC81ZWEwTHdVQXkvWDEvODdOVktIVkFidFQ2RkVKYzU4?=
 =?utf-8?B?Q2pTYXQ5YVFsZnVrYk1vcWk1S3I3UWVLUG1pVXJibFRFWXF2S0dhUENyS0lT?=
 =?utf-8?B?RDZLQzdQRE1pR1ZycGdtZmxXcTlOS1M5RnlCS05LYnM2L3JpVkVhbi9UZjhY?=
 =?utf-8?B?eEZ3bFlhUlB0T1k4WmlDMWttaWkrRkl0NUZaY3hKSkZaQ3QwV2NYclRRM1lr?=
 =?utf-8?B?b2xCVlpTb01HWjdHeGE3MURWNXkweWVIc2NyczlHSHRrek1abHp1dTZaVktN?=
 =?utf-8?B?TFExYzhHcEVFdXVBMVN6bHozUm56UW0rNCtvUWh2Q3JqMm9JK0Jndk5qUjI4?=
 =?utf-8?B?TDFDcVRsSDRTVVpVOHJVaTQzcmE1c3dOVURHRG02TW01bVhadEYram5xeXBu?=
 =?utf-8?B?TmJ0QjVRbWtDMXJ6TW0ybjJvZ2ZITXNqRWRqdzVROVdSbnBqN095YzhadVgr?=
 =?utf-8?B?MHptQWR6Rk9ySWtzUmRPQk1CeXlRTGNTWjVVZStlbVZhU29FSEdyaE5RNG1M?=
 =?utf-8?B?dFZFYi9TMHZXak5MeTlBRkFyMGdYL0NWSXdkZz09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(36860700013)(35042699022)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 09:47:38.4479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a17a62-3b12-4f51-77d1-08ddc5e021b2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9979


On 18/07/25 8:11 am, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Replace repeated (20 - PAGE_SHIFT) calculations with standard macros:
> - MB_TO_PAGES(mb)    converts MB to page count
> - PAGES_TO_MB(pages) converts pages to MB
>
> No functional change.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>   

sh and x86 have their own pages_to_mb, drivers/target/target_core_user.c too.
I guess no one likes to clean the kernel :)

