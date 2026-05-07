Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C7305E10;
	Thu,  7 May 2026 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778180385; cv=fail; b=W6pzgT6TIInHoD0Ruu+vLyX5B/4D592C0WdlD5uH61MAmwa+FdjBTltTpGX88k3C3q3ze4YnCMPt7pej697ch2MAD0WNbaMt5o2OQhZo4hk2xndN7LNqckyV0butg1LR3rm12RZmZraNBlbJlYOnUFp9GYDouXfS7LBtkX4zxLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778180385; c=relaxed/simple;
	bh=9QzdJNI0QRaAoRaxX4cBbYO6IRSuSWUaRI7jNNfSGuQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ehlo4W2aXnnD4C1UBQNRZjvTRE0pvnk6loU8Zy8MXLHhgRWVG9Ib1dw0UXce2+J2ClzgYwyPNjmZ47lwj2Uz/8AAiYZ/id1X+Z4zrZa6Phc0S2Agi5j7MXx1rIqTDzICf8xLTdxEfdyuqTQDoF6jlpmdfvZbXqk49M9tKSjCtQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=djDF5wzF; arc=fail smtp.client-ip=40.107.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="djDF5wzF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnGlSRIx/uN+DCBfojf0olYShr90RHlreYZW4L7nbTesQPdHZYF+RGOT2SbeGzgbI8klsXIyW0gFzsOmz1jpbd+dKTCxwadd0XbYYtHMNBDcj5nZAClnzkBgf0fLXq/ZlwYZiE4cJ9m27Cs54wBqy/DiDWfV8l/oDBu0sKsTqtGFEThnYYKB9UvkpUZquuLbAU3lGrIs8ruGZqNbqKvbP5KUXHccE+zq2ptWyXz2zHjuxPPptftcfgt5Pqxaeogyo+LXH+pDsM1uOdKwzjTEgmGb6qPiyrHJnJZ04/8nnrbCKLBTgbpMfj/4bAjCpbaveWzczDn7imAxW3P6Sny70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhOcJMuOPIRvcF8OSeGhh/YoFBpY6QNdDaC4Mq+b/XY=;
 b=rlwI4SF63iqM93Q74/td7uEZu3SXD5fOF0J8SA4JjWyKTFtueuBbYWcFr+9rH5qy0zV1ufIt7DakMMz9x6Wh6gskNF2XN/3KKyZ5ymMNkEtbfQ/q2ftLr2zAVYFZ2lmEDipMFLC3QD5Lyi87YnEeas2GGqPy0tuBcqGnwPbiXYOwwWVhcLQT06sXE6Eeyu/Vxp1EYbuCZOyaLb09gsb/LVlrV+HEAw3ldr5eWnZ6BvtZSQqJKglHq9CMjD36qS/EIE3WlP0FRwPGCT5zmPtLv63/LUG+Cr5MGdSyfo2f0ytTcm4ra8XfK0w2E1pKrIR5zC4aeFymxJrSAwe4cxO7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhOcJMuOPIRvcF8OSeGhh/YoFBpY6QNdDaC4Mq+b/XY=;
 b=djDF5wzFEmAs+yizKIT0dnn9RnlXIhETziPJckuj5v4Pso/5VMK8hJaNXw3EFRokSBRjRlUqNkEaxNqG3xLC0Ywt2iyf5gfo7jwdIAokJCWvFggWU9myd8t+IuA4nro9hkzAKK3kD6pn+5+p32CcadS1sIUXM2+/kF5eLrT+lGyz9td9cpHFdA1QOgUXdZZV2D3KAQasFx59EIZmgNaJmpxtPVL2qmKcodM1jHpu9JDu5o3OIoJBI2zL0b4Gw88VFEvLenr04xnRAYGSbzw+GlouYIM2RTwdARPiAxI7bf4BShyvok4a4pM9mJlG0bbAe6IoDwMd3xQO0Irf0aclEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Thu, 7 May 2026 18:59:37 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 18:59:37 +0000
Message-ID: <fd8b4470-930b-4688-b423-2e349f8c883f@nvidia.com>
Date: Thu, 7 May 2026 14:59:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] rcu: Add debugfs interface for pending callback
 monitoring
To: Gustavo Luiz Duarte <gustavold@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Breno Leitao <leitao@debian.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260507-rcu-pending-cbs-stats-v1-0-8f4eb3553bc9@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260507-rcu-pending-cbs-stats-v1-0-8f4eb3553bc9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:408:f9::23) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 248dae49-6d58-4969-6021-08deac6ac93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|22082099003|56012099003|18002099003|921020|3023799003;
X-Microsoft-Antispam-Message-Info:
	S52MGkJAIGRDwJwNAaBsNOaWT5zbTcHTWFtaDYQNpgrRqF2oUd3FYqZafKmvGAd5E2DAoq9P4Ph9c/6Wrxmeigrdi+ZpWvjefY0cjzwgMfwM3b6a6OT7+OYxb5AMtmqwQjFa3Mmsuo6Srlq/ZARc5TQubTzaAqubwVBw9QxjaXLd961KBrm+Rxj2xVznHO4mHpzM2IZWhR39ai5EQDtXfC/O8QyP5X//P/4MqofXGgdDnea7+DamPiaYUEbZ+WZ/9fbyYO9XaRPVUC+YvqUp2YZxjqOVUtG0OJOoWM74bDYv5BLx3QRZpFrP1g5M83U6JUKYsBg8nQVFOMWUYrP9HOdWIrVv8Mro6bI0S/reYV54VgtvEEcoTs67U4DyIWcWVQV4X/XOExR0l3ybUL0I3V6N6zfcAsip0t3i+PJlFbduPpuBxByNzdhzS9ubmhdMHpUqHnbJN5XLjacMDg38SrTEk2I6rqDOvrdMaLTcffRx72YL3MXP6zotmpe/UBCRlt8Usifs8TidWkjOYRE9bEE6DKWP/CeZ+W/lc8k2iyHeAHpGwREP2bM1tO8bofctnJfvKYq/YHyS0tzyMBPnHMQjO3BLBaHgN14zg5dVGiQawDtV8XrP0in62lAbLpMc/VTyGtn5KXFEOgWYR+eWXGbt8woNn0H3mwDQ3IhNCPZhZ2EOXHHCCSW/OYnWrYPZRrsarYU4yDOUah01OFTQrbD9IGjexFSHd6JTtPfSulpt2iQDuy3BIxewySwXT/Mk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(22082099003)(56012099003)(18002099003)(921020)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkFxU05mTVFEZ2crRnVYQytoUVZzRWtVa2tiMHlXQ3oxVkhPTFIvZ3RhdTJr?=
 =?utf-8?B?REtKaHRlMnBSMGlOZE4wQWIrOHJvSGxGcWpqRm1iWW1rSWV4RXJ2bXdLM1gr?=
 =?utf-8?B?SURnaXlNYnNSZ0JUaEZqRTBNd1dFcVdQZjJaUkxaNGZOZGVtTTNzWWhZVFVu?=
 =?utf-8?B?R20valFlWlI0dFJsNHJXQkZDTXM2aG80T1ovZWNGNGpOY2taMGU5b0dCYTUz?=
 =?utf-8?B?dGowbzZ2Tm51dkV4ZEI4ajRiRUZEYmRicGk2TWpsNVhFek8wTy9uOCsxd3RF?=
 =?utf-8?B?WXd2ckI1UUNIZ1l6MUJweW9SbWxSWWtZSEYwdHBjajlZVjhNMlB5NGZ4KzI0?=
 =?utf-8?B?TVRHSEZPb3NQNVAwcytFTFdJUThablg2Ukd0YlNNUXdVNFVPRmRTaHNabHAw?=
 =?utf-8?B?UlFCK0hkbG1OL3I5dXgzS3NMNCtlaDZlMmdkYmlJcm9xMS9JdTkrd1ZXSFp5?=
 =?utf-8?B?R0F0Sk5aYlNteVZxMzZNR3hOYmFVYzZ3eHU2OXdVdDFhUTVCTzh2SUJPalRZ?=
 =?utf-8?B?ckJZMWpQRFJuUVhQWVhqZUVCZXBYQXc5T3VoTEx6bWt2dS8ralpBNVU2V1hY?=
 =?utf-8?B?TjNicnRxUUZHU3hpN3J5Y1NEZnFEeWFWRTgvbHp2R0UyVDZRUXRQYzhzcFF4?=
 =?utf-8?B?MXFLK2pzMTRjYStNTnZoVzdEWWgrR0h5eDhGeXRra3VqdWtkYzJOY3FKSlRS?=
 =?utf-8?B?eTlWU3VUcHRiMnVMU3RJSDBqK25HQTRINzIzbXc2Zi8xKzZzUFNLSFp2SFpZ?=
 =?utf-8?B?UWI4K2V5aHR6eDRIZytxTUVrMEhuaXdieXZiNkpUZTZ3dnpkbEVsbStiTEQw?=
 =?utf-8?B?SVJhbkVVYVNPTW9XeEtBbUtUZDVxem50cE9ueWtneXFtZmE1OENscmxhUEhw?=
 =?utf-8?B?a3c4YnZTYU5BSDkrNkxWaWxta1hvT1JsZVVsVnFvTktQNCtNdytaL3ZXS1pJ?=
 =?utf-8?B?Zmx0dVhjV2U2STJzMTNjQktBbjcrWkxZWHB0dERqcnNVamt3SkxJU2xPZFl0?=
 =?utf-8?B?dmZsSWs0NGp6MXJ5OTNOeGl6L0hRV2hxQ3g0SlNVYzRlTXVyT1d4QVR6WEVO?=
 =?utf-8?B?SU85eXhXMWdxcE9ZeEpaWnBuckNmVjJobHZiY1F3bWloZ253c25EQTkrWmtB?=
 =?utf-8?B?M0Q5a3BlbW5HRjBoeGhoVHVwV25PREF1YlZLMGptR3hodXlJbVZQRHBDUkNm?=
 =?utf-8?B?R1ZlNnlpSUc0c0RZVW1ROGEzWm9EUldYSFpjRmxIdzZ2d3pyU294aitzZXli?=
 =?utf-8?B?WWpxak5YSkJkTHo0Q2IwQ2lRUG5teWFEVmZDVmk3QVAwa0RwZWR6U0R2dFZ0?=
 =?utf-8?B?eUJla3ZtSVdBazdzcWlCWC85c0JQUVU1RDZyT2w1NzBMekY5ZGV2VHRjUWR0?=
 =?utf-8?B?bmc0TEQwa3hpZWNVQXRuUjE1aDQzUUdldW1jUzdCTjQvZ3J6MitiaDdxMmRZ?=
 =?utf-8?B?MkZOeXkvMlA2MEplK1pKd3FNQUFiZGxjOWlmUDBDVmh5K1pEU0VaQnB3T2Rn?=
 =?utf-8?B?amc3SFFsSE8rQ01vOE9tR2FLeVlDbWFENHc3bFdSbUMwZTlsNmFHeEl3VVpQ?=
 =?utf-8?B?bTQ5S3ZadzNicCtyU05kd2RsYXZreW9US2NaUmh6UWZGUFRXVG9mYjFBdVpH?=
 =?utf-8?B?WlZmemJTSExPbmVSZkRpMHNraERWbzJFR2pmc2JZNUJqdmNOWkFXeEE1azhY?=
 =?utf-8?B?TDJ4dlpvbyt1Tm1kMFBDMytTeHRLcnJGSEpvb2dDblBnd0VUeTNuSktaNU9F?=
 =?utf-8?B?TE1vdHE0aWh2QWtlNXBuMi9LU3JQdXpUaGh4M2ZadzVGSW1DUWt5aDFCM2Zu?=
 =?utf-8?B?a0UzSmdVRlVSY2t0MzZqL2U5SEg3eURxVDZlZkZiQnZJazBOalRJTk9OcHVp?=
 =?utf-8?B?UzRSQ09xMDFNak5IYlVwZDBlak5GcVpvRFlmZGNEVG9MSkFzS3hKbDBoZ1Fa?=
 =?utf-8?B?QWVkdHFwT1c2NjUzWVlROFVuZWlDend3QWd1WkFyZG9Sd1BNenUxOTJzR05i?=
 =?utf-8?B?anlVZEh0NnMzcFpHOU8rNHJnMmdOWDhrOWt5aEZhR0JkRHVpeEVjdGFFK1ZF?=
 =?utf-8?B?Smw2Y1F5TllJMmJEeWxIcVY1WWpDbytVZ0F5enBTZC94d3AzWFJvYmRmakpH?=
 =?utf-8?B?RG5VYnhYYk1iakc4UDBrQnkwQmcvR1huaThJbmRHd3hKUDJVTXNucUxtRVRa?=
 =?utf-8?B?d0k4RWtyZzVDeVpDMEFOVUt6cWxwZFNiUTU4bUZDdDN2UnhDYk9XVGk0UnZO?=
 =?utf-8?B?QXFid0xjN2h6WjR5YnNPV1A3UEVoY1VBN2hCTGRUTlQxa0UzVVdESGpxVTlr?=
 =?utf-8?B?TGhZT2g5Y0RxNlhUVWtPdmhOeC90NEx2d3FtMUtheWxUMEFGT1JaSTk3SmtR?=
 =?utf-8?Q?g03yKhQhz7CvG70h0Y7SphS3z+VuyRgV9KQRyixZFXoLu?=
X-MS-Exchange-AntiSpam-MessageData-1: WfQ618Y/AqdeJQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248dae49-6d58-4969-6021-08deac6ac93a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:59:37.7381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDRX7kSDwMGPT2fj/sef5Xb7xb4tY4C5W/UuWy6kGfIk9evK84VNpgthLnbPrq0Nu2/AT3mU03vhXqBhERlx+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994



On 5/7/2026 1:37 PM, Gustavo Luiz Duarte wrote:
> There is currently no easy way to monitor how many RCU callbacks are
> pending system-wide. The existing trace points provide per-event data
> but require active tracing, which makes them awkward for fleet-wide
> monitoring. Knowing the depth and stage of pending callbacks helps
> admins reason about RCU health, gives an indirect signal of memory
> held back by RCU, and is useful when tuning RCU parameters.
> 
> This series adds a debugfs file at:
> 
>   /sys/kernel/debug/rcu/pending_cbs
> 
> that reports per-CPU pending callback counts with a "total" row.
> 
> Patch 1 introduces the file with per-CPU columns for each segcblist
> segment (done, wait, next_ready, next) plus a "lazy" column.
> 
> Patch 2 extends the file with a "kfree_rcu" column reporting objects
> queued in the batched kfree_rcu()/kvfree_rcu() path
> (CONFIG_KVFREE_RCU_BATCHED), which has its own per-CPU queues outside
> the main segmented callback list.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

You actually don't need debugfs for this. You can just use bpftrace and
instrument trace_rcu_ (with other RCU tracing Kconfig options enabled?). I had
something like that working sometime ago.

Generally RCU doesn't add userspace interfaces randomly like that. I remember
Paul ripped similar things out some time ago.

