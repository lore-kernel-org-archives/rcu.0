Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874341DC98C;
	Sat,  9 Aug 2025 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754766129; cv=fail; b=tMRHlasIbb3CLfJl40qEdTfV+7g2F0FH1JfZzljlYRBMqV9Av9C2Vo3uW5H5WvLYft/eHUHxZpe7+NiEN8k3E+xMvGjXNLf7JDiVpgmRtraZHQLdJSFrHExAC5ZMLO01PQxsmSo5V9xPgs+P9uxQlSqzvEe11zu+SypFGbOXSCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754766129; c=relaxed/simple;
	bh=qEWnp4LKEEtVoisapLgx6Y2+3kU2Lp+5BpHxhyLtkQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oTMzPUE2tTwQYHZs9oM0G1EBie4gKxmDe7W5mz0nHa09p6G7bFb2CoFacrS99iIJUBIqTiFl9miaWaREQ/BK6GmggExYKZ7LBxkXGndC+ll5pXokZISRhebZuWFjLJBjWO2QkaxkBRKhaJYz02h5INL/qmhc4sBev68zoUlV8eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ce2JXcAd; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ce2JXcAd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dk5+1oZf6UA9u1pap8Wurv/xDh7HCF6REpsu/fXigj/i7+lYQs+bptN/aDtOUCaL8evS6xCGN3wTiMaGiCKHOJe4MrZEMai/mdChS0GzuxF9VxW88TcHUnjPiiBEJnozIFIxf+9BGr2hQwsokhAKEkHYaVfz/kWqjbVfx6Z4EAdeJAoc5V6TKjs7bepoXXF0f8emsrbC11L6rP1q0PxMTAkMx+D/AqN1TFJsNYLYQJlN/PskzUegQdFnne/VoWcM4Udr1s3gk4pQ+Pq1uElj0NOqBcAtqHHClLvR30kDTxPRywIUyln3+zlFZYKNHInQQdp4GH2yDhSy2puTtsyBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1/rTGJQV6464BSp26z3PBRSu7n490tiEnPtn70zq/A=;
 b=oegQZdHjGRZyqRqUxgA9qrcZ2UpsF+a2U/jYPl96eJzOn1KwiQ91yNygGJ+AgpeOmcBv+4EcqO5HEgp/ojD0uageN/iBrlziahAOQnmVoNwTFgxN8MI3DqVUU0r5V7JCiHXXOqgEXAT5U9808vfvnlJMrReAORWFgDl73XO4wBh+QDdGhPjrNZ7ifAoRje2ekaWUHmXY9QLVkhU3YHrlg4iGseyRLOJZ1T5DPKbiNpIYtJxuTnUep/6z0gJCx5BCsfvgDXr6WYTZ7yXBIq8M93D/zixIHEEfFV+kxqU6huGGVX2LtoyhfquE7XVNthXMbIzm2jqs32hMfDGBWTGTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1/rTGJQV6464BSp26z3PBRSu7n490tiEnPtn70zq/A=;
 b=Ce2JXcAdq20HiAUr7t/d03VPGBAwnfFs2aiK3Mk+uxyEjVt5p1n9o/digmOajQvyYxQU2bkCIEpfdIoRmXqwO5EBUFbScSq9ehJ3xvxbkTF3MmXyCOg79d5CsFjJe45ymr3nsd+2A18o2vYAhS8iZ7gyDeOGrkvmS361uSMWT1bNV2AkbHsVu3iQ3ecceZbJnuOmfyIrfkxp1ejvYOVUmXtK55nMbPKyUQf/SFNaJJbAIhQcU4WxF+1Uk6hcUjYh8e6J/UPNtVMFY0087EIlGZ32VIWBpS4IruM8ejwLO0XPbkTRjxzeNuJuGVEmN+e/49GrKN0rzDtvyBD2Y0JA+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 19:02:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 19:02:03 +0000
Message-ID: <f9ec8762-5f61-4a12-9724-e1361436cb35@nvidia.com>
Date: Sat, 9 Aug 2025 15:02:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [rcu] b41642c877: BUG:kernel_hang_in_boot_stage
To: Frederic Weisbecker <frederic@kernel.org>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>, Qi Xi <xiqi2@huawei.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>, rcu@vger.kernel.org
References: <202508071303.c1134cce-lkp@intel.com>
 <aJY1DsIUQxzq1U1Q@localhost.localdomain>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aJY1DsIUQxzq1U1Q@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL6PEPF00013E0D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:11) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 58255b92-6acd-4246-2b0e-08ddd77739f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjJPbTBHRjBmVzNvWFo2UkF0Nnd5bkR6RkdKRUJydU5NYTVkK3FXOTNNcG5q?=
 =?utf-8?B?YURNRkRuK2tHZlNDODNhL244SkFiY0prbU9MNjc1ZVVkbHlrWFdRR2Ntdncr?=
 =?utf-8?B?N2FlV0dMSGl1RTI3VVZ3eDlLNDBBQzM2WVNHNVZxM3RBTnMzVmprNFh5NWxX?=
 =?utf-8?B?MXByc0RRU2VNT2hBQUlMWE43QTJvMkM2OGg1RUs2TjZWRW4zWWUrZUYwNmRu?=
 =?utf-8?B?L3B6aktyR09vTTNMOU1KYUFBZm1JZDdPb25qdG1hM0tvNlR3UnBRY1RwaEgy?=
 =?utf-8?B?c2k5bXJSRFhnN0xvMmN4ZHJQVlRsWUYxK2tyRE1Lb2RiZ1V3NEVkcTRmUVlG?=
 =?utf-8?B?OFJJMFpXczJQVjYrZG9XbVlLNG5YMWRDYjBTckZvVkdZTXhwMStrNmxJUEJH?=
 =?utf-8?B?a2RzMTB6RHFZS08wOU9ZSkV3OWNpclhKdXR2M05DTnB0Z3VaZVc5dWlvZnNJ?=
 =?utf-8?B?ZnlKcGI3cGFDc3haNklreDRuMnFKMXg2TnlibldhYkxqc09BOGd6OUNlWDFJ?=
 =?utf-8?B?V2dOWWt6RWNNVFpUbUdZV3JnTXYvZzR5WC9oOGo5R2JyRlZtZmdFYThlaXpN?=
 =?utf-8?B?RXk3dnlyZGEzcjloUGF6eVkybnhUeE4xWmFDc0VpdXZoeVpHaDlIcEUvODJp?=
 =?utf-8?B?Y1ZUdUtPU2d1NXlHdFRGaHNrZTFQajRlSE4wSk54Q1h2NlBHMmJCU3ArTVJE?=
 =?utf-8?B?dnA3SlVjRVo3dzdRN1ZwUnNsbHR6RnEzSmFzWHY1d25zUmYrSnNOOGlTNmRZ?=
 =?utf-8?B?V0dpNkNEU0lUbjVwNmFOMFgzb0paRTYvNGxYT1NYT0NxbisraHZvNDJDeDgr?=
 =?utf-8?B?NEgyYjNrcjRsUWtHUUwvVGk4Y0trcGZMUXJ3bk5oR3JjRWJWVjVQMEdwdjRj?=
 =?utf-8?B?YUtBekZheGJJSW1OSzRWRGdNRDVxcVpqWnZtMnJ3SE1pQzVvZ3hOMTRMeGo5?=
 =?utf-8?B?UHNCdjJDaWVLSzh2NG44SU00Y1c0VGlTUjk0cE1pR2x1MEZqU0hla0U3VGNj?=
 =?utf-8?B?V1VnNmtIbkhTanMrK3c4T1NFcitHbTJGdDE3RFBiWWxjdTlmNis5NGd4YkNJ?=
 =?utf-8?B?SHlyNEw1QzQ1OEc4TEszQkFWS2hYbGhzV3ZHUkJZbitLRFRWbTFmQ3NONy9O?=
 =?utf-8?B?U01GL2w2cWU2eGlkbnUyRU1jcFpGZS9HOFUreHB6UzJvdWdDK2M2RTRqZDNZ?=
 =?utf-8?B?cnRoOUtqNDJ4eXNBWkNKbkgvdjR0ZFVkS0QxODJJWmdBTEdYSzF6SDV3a2RT?=
 =?utf-8?B?NXVtVWM5QlBkaytMN2N4MUlmaURpUmI4WGJUeXZGaFgvYWNLNzZqazkzaTBy?=
 =?utf-8?B?ZWJUa3F4OU1wWTBCa1hkc1NHRTFEWS9wNTVNUG90THB5aGJwM3JxNWtSaUNi?=
 =?utf-8?B?VFZWaHZUQjVMOVlnQ2svVUxyZEs4a1RUOHVUZytEam1MM3lxTHJkcHF5TFJI?=
 =?utf-8?B?VjZ3MmxXMktlUzN3UjlmMVBub3BvK0NXVW5waGdUaDI5VHdQU2ltWHdsZUY1?=
 =?utf-8?B?RTFQN1c2cnlPcWRrb3N6enNaOGM1WlE5QnVEc1gvbmJmRFlxSkFjK3JFc0gv?=
 =?utf-8?B?cVhYcmlQYlQxRmNQTGsvQ3BwZU05eEdScjhUUkJLU1Q5cnE0SlFDblMzZjF2?=
 =?utf-8?B?M1RWK3ZYV3gyNjBPSVVKVHdodS9CbUNHQW1ZUjd6bzJJS3V3ZVBVdEZGaXdD?=
 =?utf-8?B?aGtKNU9leklYazRoZ2Z5ZEhYY2lXdVF5QTN0VG1QZ0hSVzdiMk9TY0RJdEpP?=
 =?utf-8?B?cmhTSE8zeXRBRFZqbHIydWlBYmFDd05CN0ZTYm9pVmV3cWJ2aUxpaVVYN2F3?=
 =?utf-8?B?bW5NME9KRk5kN21BZDFndFBwWEZsaUFBS1ZXcTZJOWgwc3o5aExlU0NVbEpa?=
 =?utf-8?B?YUNBV1dsNUdnRkFlRVB2UVVqaGxodnNvNkRNT0NhQjE4NXZ6S3FjZ01IdXJL?=
 =?utf-8?Q?RudzSP8Zfag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjNEOEFsN1NZNytMaFhodnkvNW9lVk5VbnNiUkl2SUtkUHUzOG81WHJINXNG?=
 =?utf-8?B?NldMMlNRQ0Fsb21SQVZydWRwdHIvNE9DVGdkRG5QeS9nZVZFT0xTbGVRb1R2?=
 =?utf-8?B?anlVajdZS3B2STlpdG9VNmhicURtWUNDei9nSG4rUmYrM2hoL3VLZVRVUThK?=
 =?utf-8?B?eTU2KzM1Q2lQYWI1ckdWOE4wY3dEWitvZmNWRUVZUG80WFpBTXZ2RFlUU2dV?=
 =?utf-8?B?L2NjNkhGZDVMaGdWcnQ2b1RzNkZnTXFnQnE3OTFHSGR2UDhXaE1zLzJXQlFB?=
 =?utf-8?B?ODR6SFFpajZZeFFaOCtCenRpOUd6Y1A2YVFKcHgzUXphMDVNcGlXMmpUZGxk?=
 =?utf-8?B?Q1c5bDVZSXpJK1Z3YVBzd0d4aGVzcjU2dzJHZDlxVnkweVlhRGlIVXh2TDZB?=
 =?utf-8?B?WE1aWDd3R0xpRnVPSzNveXFVOUx0NEwwd1U0SUhsTVl5eVRpeTdjVjQzVUZj?=
 =?utf-8?B?WHp5MUNhcVRCdDJRL1M3RENSZGdXT21PUDVpL0lvYWFoWlkrZjBuWWJzb1Mr?=
 =?utf-8?B?T0RkekJhcUVDSGpncGlWRFhsNjdwZ3RmTG1lWmVndlN3VjBjYmh4S1MzVFRl?=
 =?utf-8?B?czRPa29wYmd6eWNuSzlkUlpMRFh4cjFDU0l3a3lyNlpBeW9UNnZpMkxLblFR?=
 =?utf-8?B?eThCd3pEMStjVHA1b3dIaDcxN0lsUUkzK1NlSldpQlFUUWMwdWFQU2xXYi8v?=
 =?utf-8?B?bUZCbGhtNkswejcwZ1ZTSklSYjIvaS9jYVVUaWZTTW9GdS9IMDRoVTBQR3RU?=
 =?utf-8?B?aW9Xdnd6N0N6eW1mZG9MeHJGMUVma1lWYWg1aUZNV2FJbEpDVlF4VW8rSFgr?=
 =?utf-8?B?b3NnRG9FZXB1dDZNYjdaUzVXK3VEbVp3dU1oSFJnZXd1WVpyUE9KZW5rSGtt?=
 =?utf-8?B?Z0ZoNUZyZUZxZlN3WTNJejhMY05mNjZWbTJ0WFZIZStkb2JxaDNTallGdjZB?=
 =?utf-8?B?V0VCZHZicmNlWG4wZnRyZGRZMXdjZUhvWDB5dGhubm9FUHpuOVUzd1A5UXcr?=
 =?utf-8?B?MU9ja2RmOVRCMFRxcDZSWHZKdlYwaC9udHlSR3czMFJaaDBBdFFlclZnRjVE?=
 =?utf-8?B?QlZZaW9zVm9kSGV5UTlzRWZwd0JnOHcycUVabTJDSUQzY2NuS0RrRmFwTU5q?=
 =?utf-8?B?d3h1SDVPb2NnMWtYWEU3bGFob2pEVUZrbTdRUU82ZFZiMmpuZ0s1OXdYMHVE?=
 =?utf-8?B?T3YzZ1lUNGVoVDN5UktLUEE1Nklyb2hFR3o0WUsxc1Z0ZTFsTWNyOU5uUDY1?=
 =?utf-8?B?Wk9mUnp0VE1EYXJXdE5wMStKMHVOcXg5T1JCYzNjYnJCdTliTXBjUU9pY0ti?=
 =?utf-8?B?VnhZaVhQZHBHRnM2K0x6bGZYMWJ6NVl4eENCSWJSTFFJWEdtcGJCWVJ2bE42?=
 =?utf-8?B?MmovMERYQ29ERWVEZ2VNSU13WHRMQks0T0JVenhsOHhXU01KVVZJVHlPT3FB?=
 =?utf-8?B?NGJCdi9aT29GVng2ZVNsRmFzZVRHeTV2M0JGM1RyUWpyMFhtZCtaMlE1bGtS?=
 =?utf-8?B?bWl2VzJuTnJTZ0lBSGU4bHg4bUdUQzJhSFFzVXJZUGdNQWl4QW5sMzVuK0F2?=
 =?utf-8?B?LzN5MXpITWRlNFpRQm1FZEEwSVdkd2pNamtsQkVNUHcySEcwa2NRK1pWUDRV?=
 =?utf-8?B?dTNIZ05ZbTlOMEhFZCtRUVBMS3BCZnU1WE5PTFZRcG9lZ3NxSWs3ZVJBRmxU?=
 =?utf-8?B?QTNvTHVQKy9Pd0dMUkh1ZG9ZZ3VzMEh5WWY5TzN5cG9ILzJ4bStvN1g3ZVVF?=
 =?utf-8?B?N1kxUTRCbHN3K3lhdmJZRXg3NVNmd2J6aTc1Z21FaHpHY1czaWNPNnkzY3dK?=
 =?utf-8?B?Ykh3cjRaMVVuSVRMRStaNExUT2RBQnEwRVltWU5UdU9nL00reFZSM1ZRNHhP?=
 =?utf-8?B?RFNiOHdLeFdxTHFneWZpdmdYUUhCOUYwTWJlNVRheTdrTUNwaE9BVFdzWXht?=
 =?utf-8?B?QU1GSjNYUS9aakdYL0orZ0Z0Snl0dnNXQ2ZCTG5jSGpqcmgvMUxwZGVoTzlI?=
 =?utf-8?B?bVA4OVpDVFAvUFR0bCt6eTl2VDdlWWd2blkrR1Z6TVMxR0ZlZ1I5UGxFbTBR?=
 =?utf-8?B?ZkpwVkZBNGRUMFdQQURycGdPL09iOUxXZWd2d3pqVEFWMlJCM1BJNnhhbjUv?=
 =?utf-8?Q?vEnhF0TYgWT8H9UOKytp7A825?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58255b92-6acd-4246-2b0e-08ddd77739f5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 19:02:03.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTr90DWOBy7/LGs1v5SAZaIddM2aTSDDr9L/HcSW3SQvIQb5MBnAx6xtESsOuRllSOwd+ZD5v5ylt6OeEx2cQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466



On 8/8/2025 1:34 PM, Frederic Weisbecker wrote:
> Le Thu, Aug 07, 2025 at 01:39:32PM +0800, kernel test robot a écrit :
>>
>>
>> Hello,
>>
>> kernel test robot noticed "BUG:kernel_hang_in_boot_stage" on:
>>
>> commit: b41642c87716bbd09797b1e4ea7d904f06c39b7b ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> [test failed on linus/master      7e161a991ea71e6ec526abc8f40c6852ebe3d946]
>> [test failed on linux-next/master 5c5a10f0be967a8950a2309ea965bae54251b50e]
>>
>> in testcase: boot
>>
>> config: i386-randconfig-2006-20250804
>> compiler: clang-20
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>> +-------------------------------+------------+------------+
>> |                               | d827673d8a | b41642c877 |
>> +-------------------------------+------------+------------+
>> | boot_successes                | 15         | 0          |
>> | boot_failures                 | 0          | 15         |
>> | BUG:kernel_hang_in_boot_stage | 0          | 15         |
>> +-------------------------------+------------+------------+
>>
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202508071303.c1134cce-lkp@intel.com
> 
> #syz test
> 
> From a3cc7624264743996d2ad1295741933103a8d63b Mon Sep 17 00:00:00 2001
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Fri, 8 Aug 2025 19:03:22 +0200
> Subject: [PATCH] rcu: Fix racy re-initialization of irq_work causing hangs
> 
> RCU re-initializes the deferred QS irq work everytime before attempting
> to queue it. However there are situations where the irq work is
> attempted to be queued even though it is already queued. In that case
> re-initializing messes-up with the irq work queue that is about to be
> handled.
> 
> The chances for that to happen are higher when the architecture doesn't
> support self-IPIs and irq work are then all lazy, such as with the
> following sequence:
> 
> 1) rcu_read_unlock() is called when IRQs are disabled and there is a
>    grace period involving blocked tasks on the node. The irq work
>    is then initialized and queued.
> 
> 2) The related tasks are unblocked and the CPU quiescent state
>    is reported. rdp->defer_qs_iw_pending is reset to DEFER_QS_IDLE,
>    allowing the irq work to be requeued in the future (note the previous
>    one hasn't fired yet).
> 
> 3) A new grace period starts and the node has blocked tasks.
> 
> 4) rcu_read_unlock() is called when IRQs are disabled again. The irq work
>    is re-initialized (but it's queued! and its node is cleared) and
>    requeued. Which means it's requeued to itself.
> 
> 5) The irq work finally fires with the tick. But since it was requeued
>    to itself, it loops and hangs.
> 
> Fix this with initializing the irq work only once before the CPU boots.

Makes sense, good catch and thanks!

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

 - Joel



> 
> Fixes: b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508071303.c1134cce-lkp@intel.com
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree.c        | 2 ++
>  kernel/rcu/tree.h        | 1 +
>  kernel/rcu/tree_plugin.h | 8 ++++++--
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8c22db759978..3a17466ae84a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4242,6 +4242,8 @@ int rcutree_prepare_cpu(unsigned int cpu)
>  	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
>  	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +
> +	rcu_preempt_deferred_qs_init(rdp);
>  	rcu_spawn_rnp_kthreads(rnp);
>  	rcu_spawn_cpu_nocb_kthread(cpu);
>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.n_online_cpus);
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index de6ca13a7b5f..b8bbe7960cda 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -488,6 +488,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp);
>  static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
>  static void rcu_flavor_sched_clock_irq(int user);
>  static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
> +static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp);
>  static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
>  static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
>  static bool rcu_is_callbacks_kthread(struct rcu_data *rdp);
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index b6f44871f774..c99701dfffa9 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -699,8 +699,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			    cpu_online(rdp->cpu)) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
> -				rdp->defer_qs_iw =
> -					IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
>  				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
>  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>  			}
> @@ -840,6 +838,10 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
>  	}
>  }
>  
> +static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp)
> +{
> +	rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
> +}
>  #else /* #ifdef CONFIG_PREEMPT_RCU */
>  
>  /*
> @@ -1039,6 +1041,8 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
>  	WARN_ON_ONCE(!list_empty(&rnp->blkd_tasks));
>  }
>  
> +static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp) { }
> +
>  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>  
>  /*

