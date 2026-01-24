Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789001AA1D2;
	Sat, 24 Jan 2026 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769217075; cv=fail; b=ZtS/hAhOqhx0pXViTcBb2hAPmL7thBMmW9Qkm8G57Z6MEEMJJ7tljxU7Fjn7F1YbMkzVIh2mKWQF1Wiivx8m0zQ6bRHGwmYb15H+JtS3jBu3I3QlpfvdZpUhguZVfvnfPCSoISWC1ls8Q3lahiSo55KzzxRkVs6edDhU17c8Ijc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769217075; c=relaxed/simple;
	bh=P/0OY8WTU1hDEsn10rwq3pOn4MJ0MJCIFu1PPhaluXA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JjqBTLVGcZB5zHmalxOaV0nd1ipzC+IrJJa8EmtJWl7duA0mWeK7GbRHAi9JFidXDFDv8UYHca/3PcFp5y5LtgdMBZcHbhIjWlzGfMy18hmo5igYBGTaoUxlevyFBECZNyd1WbsSbUeHzCBiPO8od86rBbjCR1/TlX2bZlwHo+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RkX6GMVH; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RkX6GMVH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BU2+Z6lPXNGVA4Aa/TJtzjgkIBzH5zTyma4zevt8O7KqxuHjhLsu9RhGGP0T3SAfob8nfvKh7mw3EM6PUmvwoslZWN1FV0W+UQ4OfuHIIzY5H3HZSu6mbqw+TlnOMk/VVCvhjXI7kTLmhJZqwmnFwpZNl4vV2QlcAvmolx8xU1j57Q52BIi+85gcIghu0myIMaJYcnDQLX2C+h1FhQvle43k3jWyLcsXNLSGKI1VvTpJ/2koAQ9HXWWMfQPx/+pJHvxXtz6lQdW/DOjzG5phMYwylCDfHC5tlXNcJDU6q4rPWiFU6gGL1PrWEgbks0ey4yliczpWIsOLX7oxT57sQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bZxY2Eyc2vtdNmPEy/thoxlRAzMYl9iN3JLPR83LhU=;
 b=Yi4R9G+AncIh27HpvPMkGWCyoZWPIFS/8EgmRF19/SEYa/zJco6dKGRLG0O25svVXws36Y5smQlqwMNC2YrkYXA48uOiZygmy81i0RptQK+fUkEyoDWXbtdySNhPrWRs2iAu0KMUvUExzEV/5WkKN0vg9fDaMfelaP1T0S+CT24OIN76DajCoJPYkN0bL0pCOwisxQ5r0ETbLdB3z5t+F6k1Pzv1U5vnQ8Xk1R3TptZcScILhXmHddIKNP3Z5uTou/l9xm3ugKRywEXQjD59vxhVvti0B3Odq3N2g8tJhdqsutrP6CgWDbql+wlKZ/PSp/iXY4W9lU1e26UGsbcNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bZxY2Eyc2vtdNmPEy/thoxlRAzMYl9iN3JLPR83LhU=;
 b=RkX6GMVH1Ae71JeMRX5pjTyDPKoWR2jIXCKCzj+vdrbogHHe+32CSUnyV3hQ0FIYn4DtS0UDyORErVMl/VA/EI7D69QFgRXfNX85spAluYUoHYDFKh60bk3Kvf5wD2ZM68W5svGGG1Z7TkoEn3X3xmUr0p6iTxwQFeO/jDOHHfDO3UUmgcfV5r8FKnp5XDEZH1A9KK0uEX2n2TTcOAjStQPaZqO8gBfEsrRuFXW86WD8I3ydIxqRi3gWUQXWoG4pxmnQIng6J2Ij3ScsABNAGR+C2TeuWZOxkny/LH2rWSvAJ9erdhyw4cD3yZzyJlPcgm7uLgRYx3/MyCugSDzDpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Sat, 24 Jan
 2026 01:11:11 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 01:11:11 +0000
Message-ID: <3242b1cf-728e-4c75-bcb4-3f0619388458@nvidia.com>
Date: Fri, 23 Jan 2026 20:11:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload
 handling
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>
References: <EBEF016B-721C-4A54-98E3-4B8BE6AA4C21@nvidia.com>
 <013102c7-a1c8-4f13-8dd9-5803e4d69aaf@nvidia.com>
 <68fd874e-ac9b-4d91-ab05-903bf45856fa@paulmck-laptop>
 <1737646200.reply.joelagnelf@nvidia.com>
 <735d16d4-f727-4cc1-91d8-16155135f550@paulmck-laptop>
 <6441f33d-b4ac-4483-87c6-236998803338@nvidia.com>
 <816a14e0-c06e-496a-9c84-512c76d98157@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <816a14e0-c06e-496a-9c84-512c76d98157@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:208:160::43) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: a2285d1c-8b3a-4b38-4a5f-08de5ae5761d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkpWQ1d1UFhkVi9RU2V6RFlYMjgrc1p0WitEeTByamxadi9QR21NWU9oY3ZY?=
 =?utf-8?B?U21VQ0xPS3NRUWpreC9TaHpXa01MdGtIbWNiQ2xaQXpIam0vdU5OdzlBTHJ1?=
 =?utf-8?B?QTk5Z3BCVVhQdTRmUzRscXJGM1VyZkh3K2MzLzgzRVQ4bHJNeXhab3owSk1G?=
 =?utf-8?B?KzZaTEY0WGFrc3ljaVdNWEpSdzFJRXg0SnpscmRqR0VwVmtOK08rdkpxQjRR?=
 =?utf-8?B?bjlQU2wyUHRWY0plUGt4aUZFZm5KMU9lOUQ5dXI5cENDaW1Obm9WSCthc2lL?=
 =?utf-8?B?NE5ENlFXNjZzUkFVeFJ3cHlCTmFPSlVGakVSaDlGazI3Z1BUcExhTHE1dGYz?=
 =?utf-8?B?V1U2MFdabE5sbmVPa3FTYUFFL1JlWW1NWXh4cnRUeGh4OXRQcWp3NFUvM0tm?=
 =?utf-8?B?SWFkRU9NU1dQajB0WnVXb1d5dUdLZGx1ZGZGYlo5TExLNmtZWFNZWU1rWDRD?=
 =?utf-8?B?SndRK2ovaUpiTnlTL1ZUdmZCZGxoaEZhcVVYc2t3eDkwMlR3ZUxWSW5teENM?=
 =?utf-8?B?V1A3RURHRTI1R3BiSkROYkR1Yll4aWdZUmpNTVdxSlF6enE0YnNxUkMyQmlL?=
 =?utf-8?B?eElHZE5UZ0FuY2xLYWNyN1drRk40djllenQ3S2NWUHpzOWRzcXVORmJNbm5a?=
 =?utf-8?B?L1JSOEVWUkJGNzg1Q2xGQVVqZTY1VlFKTENsamRtSnNCSlV6ZFVzWWRPWUJi?=
 =?utf-8?B?d0lSMW5SMzMvcVF4RTl4MGVpdVJCK1c0U2dqSit5Z0wydVR4YS9lS1FVTWNO?=
 =?utf-8?B?RE9XRkJzSldyM25POVB4N2t1dmFlRFg2Kzh5YWFFcklIZGQ3Rmw1Zk0rUTJ0?=
 =?utf-8?B?ZzlFZ1RTcUpPL1VTL0tkb3BhM1FXTmxvRmt3OHI2VnVsK3AyTUM4aDB1MkNp?=
 =?utf-8?B?bjV5UDZMZUt6S2pTQ3RlejBrWFkyR3dKMHAxTit5c0s3MUFJcmdoYWhsM0RB?=
 =?utf-8?B?eHZvZXkxV3V1Mmd0MERWcktQOTNGMGtCQUVtcTJzK2VOQm9TMndxK3FMUzNY?=
 =?utf-8?B?TkhCM0Via2pxMmZLWmhXRXMzMmUvTXJvOExPOEFjQ1QreDhLQStlNDVvQ0Ru?=
 =?utf-8?B?ZlZTSFdYbFNLcHJSRjNPMXcwc1E4NWNIYVJqNExYNTlNaDZOMG1Jd0l4UE90?=
 =?utf-8?B?aVZFVGN5MVJkTTg2STVKRXg2VDZhdnNGU1FJVWpvalhDeHJ6QWVtdmc3MnJt?=
 =?utf-8?B?a0YyNlF4ckJvM1dHeXlTRjRzTlkrNVJrZStRRmJxUmhud25obVlsVVJxNTc3?=
 =?utf-8?B?WlZubUFPeTBEQUVMaFEzNmtZdE1MRHlUR2xsbUJycmRYTnJKa1JTdUJSMDcz?=
 =?utf-8?B?UFdZSTNEMWsyeW5TZkdQb1lPZjk4NEdudGd3ekVkUEJ4bmkyT3kxeWdiRXZl?=
 =?utf-8?B?UEsvMmd4dTg0enQ0bGhucG0zOThINk8xUEc1eS9Hem9obXQxZEZiNGljdStl?=
 =?utf-8?B?eWVabGtKbTZVc0FzT28zMWJHazM4Z0RuSWtEenF0Sm9lcng0MXlYeWFsZ1hU?=
 =?utf-8?B?eDFEdFBtQmZzaWU1dkI5SHlwZGg1ZVMxa2xVb0w1S1BDQStOT3p1cENxNTlT?=
 =?utf-8?B?eHlWN2R3ek9Jazd0L2xQOG81Ukh4eVdIUXpHWStCZHp2WkFCdnpzT2tvZmpy?=
 =?utf-8?B?dVkrYXcyL240TC9oaXB4SktuVjhTSXExbFJ2V1BqOUJGZTFhZEhPa0tEOVRC?=
 =?utf-8?B?YitPRUJnMllvZSttcG94WmgvckgrZDJVeGpwRi9kQ05ERlRVOVJvVHI1YWV2?=
 =?utf-8?B?aEZqZjlHVitSV1orR3hiQ2Ryamp2OW4zZmpVL0FQZ0ZlTzV0VWwwR0hNaEdV?=
 =?utf-8?B?blJiZU40MDVobVROM2lRSzBjMTJKL2RwUkI1QWlIVEdXZTJsL2drOWlCV0ZL?=
 =?utf-8?B?OUVENFZLc09BL1VEcFVVbU5yZVBBaVQ3dnUyak0yV1FWUXhyai9hcjM1Q296?=
 =?utf-8?B?ZWNzRXVkdGdpMkVkZ3lqR2grNXhiMjdWS2lDN29JSGVqQVpvSHQrVmxUVnNZ?=
 =?utf-8?B?eUxSNGdoajFFN2RZc2lWdFN4MmhXc25Pc050MGJGTzJNTU82M1cyRTBJMVhT?=
 =?utf-8?B?blBjRWZGQUxVRWFhSXEvdWFZSU9SK3VpOGFUZW4vT0NxcnNyZVVTbGZEZjdL?=
 =?utf-8?Q?vLgw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWw2SkMvQk5jSm1qMjFKK04yMWlFOUY2VzlHOEQ0TXI2WUo5azY4MWRxOTAr?=
 =?utf-8?B?MmRZd2ZHelpSdW5jNWNCTXE4Nnhha2thSERpaHpkK1F2NGtLdDlBc2ZsRERS?=
 =?utf-8?B?NnJpNUlaMkRFbHp3TmpjYy9TZGkrdk9iRHpRdmR6emd4NEduWnMrT1pXQW0y?=
 =?utf-8?B?YkZQMUVJMldVT1RuQ0NjWWVWbG5FM0xLQTIybGt6b004SHF1bTBUb1NOQU9C?=
 =?utf-8?B?dS9zMWJpNlpHS1paVnVWdmx5RGR6cC9YOGVJQVZHZG0rVWJqU3JjM1J6RG9L?=
 =?utf-8?B?SkdCcmFuVUhleit5aDg2MlBabndwbWVSaytYVTFndU45TkFuQ3lmdm1aUldY?=
 =?utf-8?B?SFlQWnNMT1JJbTg0QnFzaGNpMGJJN1Y0N0U0eVphUzZaWG5aZC83WnhhSFli?=
 =?utf-8?B?ZnY2NTNxaFRBNEdwNTBkL3JCWDM1ci9oTkdoVTdxejVyVnJZVnhxVllvc1V2?=
 =?utf-8?B?ZmRKRXpsanJnTHA1OGtQTWxuTWVwcWxYOHdpODdqQnllUVh2d0l1enNZdzBI?=
 =?utf-8?B?NVZpc0NrcEJ1QThhRTNsNXJPWGxxTlo4dFlFaFcxZDRySE8yOHFNeUFiOWU2?=
 =?utf-8?B?eXZLM3U3bkMzV1RQeVoxTU53Q1NCQ242OHJWTldqU0JUNkpoTFZqUkZISUxR?=
 =?utf-8?B?L1pNV2JjTndHTi9qbW51cnpIeUh1UWRJcllUZFRQb2RwdnA1TWhYdDU4V3Bu?=
 =?utf-8?B?aktzNm5hRnV6Sys4T3JDaG8vNG81OXVoVjFtQkZoa2c4K0ZMdWgwYXFjOTBB?=
 =?utf-8?B?RVVNaGF1Vm1USWJvK2tCcExrVE1TRDdLMFY1QXlmeGNHYnVOa0xEMkRTeGlr?=
 =?utf-8?B?d1g4QTFRTVJxYWxKWkRKRzYzdmxLeURRZyt1bWtleitUUDZGTkRPc3phV0Uy?=
 =?utf-8?B?MnNQZjFqYUl4THZhZENIYVE4SUhlMk91bHZoS1l4akJKTDVOcFJmZzJlbHRC?=
 =?utf-8?B?U2tDMHBjOFBDR09nVzJGaW5zVEdVTWNQQUo5NGhyY2ZOZ1QveVRuR20wOUw4?=
 =?utf-8?B?WDgrcUN4bDI4QlEyYlBXbU5mbzQwbmkrMlU1WWtJOUFtajQ1SmpCT3VocE92?=
 =?utf-8?B?WVVaaUdVS1RiWXA3ZFFFZTBHS2kxcWc5SXpIbmtoNkJkbHN0OXBHWlVmWUlk?=
 =?utf-8?B?MlVzUlpNMGx2dFkxU3JYaUZEcUltRWNqUFpWdlRLbTJFYlhVSGtxRGs1K0U2?=
 =?utf-8?B?d0psTWZiaU8vVDNyWEFaOXdTYmlQQUNTcFErZjNuaUR1SjJ5amlyM3ZZeklR?=
 =?utf-8?B?UGhaaE05MnBTREJyYWE2Y0ZRemhXYXYwR0FxZUMrTHVWYVVVUWgvZFM1cjZ0?=
 =?utf-8?B?SEszV3M0MFRBak95czB6dkZYeUMxSlliNTVmeGpGSWVLQjRsaEtuTEFRSkZj?=
 =?utf-8?B?U2JHSkh6S2hLR1NyeHlKZXBQWWF0K3dXbDBjSFBCSXU3cmxWNEhDc1pWMVo1?=
 =?utf-8?B?M2VaSGRoTWtsVTNKZVFtVnJNKzBvTkJqeFgxNzZpclM5TEtoRTNyR0k4bkIr?=
 =?utf-8?B?bmFvUk04OHRsalhRd2tobmR5NmI1YUdDNS96dzJ2c2dpc1hHZVUwcjhzU1c4?=
 =?utf-8?B?L3Rybkx3Slp6a09FRkpqQ0E1MGpRQlFHU2dlbms1cGVFRmowR2VLemtjOUU4?=
 =?utf-8?B?ZENpcE1CTmtQdzdMbHV4V3FVUnNUYzd1OHcvY215OFZtY3RVbk5aNU5mZ1dp?=
 =?utf-8?B?Z2JNTno4dk1pbzNWcGdLNjArWGpEU3p6QWtwS0x1MGY4eFJ3WDVjQ1Q1NXhH?=
 =?utf-8?B?Mk03MUJoL2JqQk51RGRuSkNEZEpWZXdYK2tOV0J3RXJFaTVLRHNCK2JxU2pD?=
 =?utf-8?B?TC9MQTBhSitBVFBFVzBUV1pmWmlYUFJ0N1M5RUtETFJiZWViNTd2eUFCekNN?=
 =?utf-8?B?TDdnMUUzVDVKKzZjNDMyaHlCU2p5R3p1QUZqK1ZxeVRQOENLTDVSOXplNmdX?=
 =?utf-8?B?LzBWOW9Xdkc1QkJPc0ZMbzRXeTl1K0s1QnBpck9uQVVFcUpQZVpHZk55MWpR?=
 =?utf-8?B?RHVZN0Vjd3lSN0ZjSlp1bU0wOWZsQkRSdkx6SDBvOUJORUk4VUJmMURrdC83?=
 =?utf-8?B?ZmlJTmptU2VWWWNhREU3MWZiaTN1RTR4S3VrWTlTYmRoSjBoQTNBRlUrZUZI?=
 =?utf-8?B?bjMvWHpjVVh2Z29RdzNmTWhDVHkxYWptWFBCT2ZkMmFCRDhOSWRId2ROL0Jt?=
 =?utf-8?B?RjY3SWNna25LVnBLMFM3WDRFVm5DeDBMSDZwcFcwUlJlVWF2NEVsUTR0dUsr?=
 =?utf-8?B?aHpYYjZjdlRad05FOXhCZGx2K2ZWMmlpRGVyV3d6ZTFMQjlZc1RGVGUzMTdM?=
 =?utf-8?B?NFNPRC9DZXo2dHFKdmlGZlV0R1Z0RU94czJJWlBROWc0ZU54MDUxUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2285d1c-8b3a-4b38-4a5f-08de5ae5761d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 01:11:11.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJE7834xUIU1OQXDh1DukSOwcSOpmHz8EroVqft2152KDwQ/yAtW9JUZmJWZHmmbrftiBbyc/3xxLlo+pq9bmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741



On 1/23/2026 4:27 PM, Paul E. McKenney wrote:
> On Fri, Jan 23, 2026 at 02:36:37PM -0500, Joel Fernandes wrote:
>> On 1/23/2026 11:49 AM, Paul E. McKenney wrote:
>>> We could have one CPU flooding and the rest idle, and many other
>>> combinations.  And, if I recall correctly, polling can burn extra CPU
>>> and cause extra wakeups even when the system is fully idle.  Or has
>>> that changed?
>>
>> In my experience working on lazy RCU, if you have such a kind of overload on
>> any CPU, then you're usually not saving any power anyway. The system has to
>> be really quiet and idle with a low stream of callbacks for you to save
>> power. Further, when the callback length increases too much, we don't turn
>> on lazy RCU anyway because the idea is that we are overloaded and the
>> system is busy - so we already have such assumptions baked in. I think a
>> similar argument could apply here for dynamically enabling polling mode only
>> when overloaded.
> 
> The concern is detecting overload quickly.  Any unnecessary gaps in
> invoking RCU callbacks cannot be made up.  That time is gone.
> And the polling does sleeps...

Right, the time is gone, but perhaps the recent past is an indication 
that the gears of the machinery need to move faster, possibly to improve 
things. :-D. Obviously, it's also totally possible that entering polling 
mode doesn't benefit anything if RCU readers are taking forever to exit 
their critical sections and so forth.

> 
>> I was coming more from the point of view of improving grace period performance
>> when we do have an overload, potentially resolving the overloaded situation
>> faster than usual. We would dynamically trigger polling based on such
>> circumstances.
>>
>> That said, I confess I don't have extensive experience with polling mode beyond
>> testing. I believe we should add more rcutorture test cases for this. I'm
>> considering adding a new config that enables polling for NOCB - this testing is
>> what revealed the potential for grace period performance improvement with NOCB
>> to me.
> 
> The main purpose of polling was to make call_rcu() avoid at least some
> of its slowpaths.  If we are getting some other benefit out of it, is
> polling the best way to achieve that benefit?

Thanks for the clarification. I will study what exactly is the behavior 
first. The main benefit I see is that Grace Periods progress more 
quickly in polling mode. My suspicion is perhaps this is because of the 
speed of wakeups happening due to timer interrupts vs. those happening 
because of one thread waking another. I am just speculating, and I will 
study it more before being able to say anything meaningful here. ;-). 
But thanks for the discussion!

--
Joel Fernandes

