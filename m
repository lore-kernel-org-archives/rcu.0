Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25D32FA3C;
	Mon, 29 Dec 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025726; cv=fail; b=cogaGf3zGpNeMMZepTvQlRnZKqo2CBZssVLZvw2gU+MRYrdDx8NL/Ig3UXhnUuyd88jYDw0azagH5yMuQ/n5UvQEloeu8ypTvAlx9Cho30eATgOS9QTiyzoQlsMt6Rh6uVE5DQAkDILuu5XL+43t/lZ3dTiuGxGVXCrMyIilWeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025726; c=relaxed/simple;
	bh=fLfgRSjAN33Goo7Jw9zrpH37IbXj+98YdG020ZPzLCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O2GA/2M/kD3Mx7TocYNGwL+T2tcApazOoB15pQ9SioYl5DFA+tVWGsSaDfq5Wj36NUOxZ5+W1o7E6sQZNWBjFF1F3BEe4ZBgWTqMWGsF6MWKgJHvcUgLvEW9oDLXtUdQZdlAtpca7dZUGABNm/F1TvmAZafahrsCiqb3fwFHAp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ayWZEyyW; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ayWZEyyW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLPsBKln6/Ywvi7pS5N2H+7L2tUDaevOY02SoGDCfarXdt/hoWy76SCnAXZl0uUXyDhalHUjPQ/wTEiqGdMeV8KVf7BMMNSNKCHmai44+BF5WeLiNosYVlnuwMtL6H4S8epact0SsUok2sCIO/BqgB50Vc5T8zyeqjYpiLhXXesvMfWVDc51Z6ZsqEtwlYXaGGsDDu6jUwj/Kz6kNoTQyoQObz1sDDnSv0VWAYE43/rM30y/H6f3eiMxRiISPjHOSVq110rcN6egLDj47weIe5DKNGcskvnC0tRpbmwO66hnunaTdXoO1LMjg0KEQCGi8ZoPuks2Ot79vZH92EMbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/p/cF5MBlFsHiscr+65ltf6Zn3Hmus9OrgjZwExQaZg=;
 b=WXBH4GoZcVCd1bWTR4FQJoZ1tl1gPCpRLDg/fY+pvfdCt+w15XyOhn+YYoZATdvZJUx587cUcAYMkDiafhOanvU8GqC9k543jVIpRMxNJ2KNOpuRJtCK72v6FjKmFmnkUGsx4t7vNA/IYLTVUKg2ikeEL80asip2B/HSPiKETlI5uONav7L5ZGbappYYpa7ifzLxa8MSjhdsXsrCGIK+ADqhiiHhfUjhpySIV/hjlSzsF5guH2jW1hNKNT5wIWlCLVQwNBv1A4pizScqzuqDcYVJlvPpZ8j0KjZSesL57oYxyQKjYbvBl7REQsKXR/FGv2Q1dUsFrgNsgQa8D9jt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p/cF5MBlFsHiscr+65ltf6Zn3Hmus9OrgjZwExQaZg=;
 b=ayWZEyyWTZ98qDRVmVdSzgDc+XV8nYzaNKUy23AGBhyc75wYzBCg0BMzqPkt2/HpRGDj+zQAODRqQy9ssq+FYBAj6wXp2B29cqYpn8SXlfHWBiSEdfvhdHFENXiTlJbgaiq4Yg8moPytBVMLgXcmvWSoUVGSK9leEgzgjxtEuwyabdqKo3Nt1yvUBFAcXACmjyiNPHM/BHlp9VK4sh9Sw+3iivfNTOYoHDDcLunR0Y5Qvx7Phl9bjwOSy0hs+F0OT6rMNi288mvxrqGuzkraRDv8xMuAkdeE+Rp3UnQDYGIZZy43dBAgGAx4NCk0oqF+cGq0cF1bk2qlirxpl3obPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Mon, 29 Dec
 2025 16:28:42 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 16:28:42 +0000
Date: Mon, 29 Dec 2025 11:28:40 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Reduce synchronize_rcu() latency by reporting GP
 kthread's CPU QS early
Message-ID: <20251229162840.GA361967@joelbox2>
References: <1033a68f-c17b-4847-819d-7fb4e9e45016@paulmck-laptop>
 <164E7707-758C-44AA-BB75-B6560725C8CD@joelfernandes.org>
 <c75d4449-8329-4bf8-a4d9-03dec02c054e@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c75d4449-8329-4bf8-a4d9-03dec02c054e@paulmck-laptop>
X-ClientProxiedBy: IA4P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 702d87e7-dbfc-42fb-6595-08de46f754a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjV0V29nUUhIR3lWdStwTmdTTE1nbmdkakxhTzgxL3hNYThscHczYldMdEdq?=
 =?utf-8?B?OWRuY1NPR0kxc1k1QS8vNmlSMzdZeVpTdFQwKzFWNTQ4aXo3QlQwbXIwOWQ1?=
 =?utf-8?B?ejdFaExtR3l4NU1ibnhFSDJGTldtWHg1ajNZQ05ROWVKUGZLU1A5WEFFa0Mx?=
 =?utf-8?B?ODJ4SDBEVjA4V0tRamlhL2NDODA1MHVOS0QyWFFBNlJ3V2N0K05zdW13Zzlz?=
 =?utf-8?B?UHVzeFgzeEl3VjBnZGx6d1VzMksrUG1UbFp0UG9nQWd3Mkp3cnV1dTFLWE1I?=
 =?utf-8?B?QUswYnlOSUN6a0F4bkxIZFBjWXFVUWNlSTRaZEgrdWxwc3ppbFRaVmZxQnJF?=
 =?utf-8?B?NUZxeDBCck5mK1JMbGI1OTRHTXRVeENaSnNKU3JYcUJ5MnVpQmkyWS9KMjlw?=
 =?utf-8?B?Z1AxZ0lqOVU0U290TVpWSUYwb1JaeXdweFhhMGFEMmtzNC90Ym9nNlZoQWJJ?=
 =?utf-8?B?Vy9oY2d2VHZQaEJLRnR6TCtzRHdYb1J3eWVkN2dnM29ON08vR3ZMQitzcUgv?=
 =?utf-8?B?Rkw3RFJFbmNWQUpRK1NNZFUvK0RRM083NlB3UTlNOFcwNUhBdEhRMHFob1d0?=
 =?utf-8?B?U2NIS1RVS1V4Wk9ZSzRxZkNDVEZ4bmpuSUtOTlZUbEZQT1U1OVZ4WCtNZWo4?=
 =?utf-8?B?bmFodndreUJrQy9aYUdaMHNSWTZvT1NuL05lOWhZa1JSYm1kRDRidUxFakQr?=
 =?utf-8?B?aFVQV3pQeVNWSFhsVE9WZENOUVpPMWZ4TkIwRzQ5MjVXeGVVWitBbE9zVHpJ?=
 =?utf-8?B?S3ZENkxxRDY1dE5NdG9oQzVaWXRHSGNZQ1owNkdwa01ndUIxejJLMEsxMmth?=
 =?utf-8?B?N0FLckthZ2xCeHFJUS81TmVjTCtmQzVtV1FmVkNyTFZLSzN0VTZpS0I4SzBX?=
 =?utf-8?B?K3lqMkUwQVNkOW16ZlJiZDM2U0UxZ0x3OWtvMW9zcCtCeGIyNXFQZTVudGoz?=
 =?utf-8?B?emNYRkNLaUVDME90NEFBa3pHYWRCbmVhL21RZ1Yxcy9wUlZ3VXN4RWZHTHR6?=
 =?utf-8?B?Y3I4eUdpWjJkS2VEOG1ISG1RMlN1YkRmODE5VlV0SE5RY3Bjc3VPQkc4dDFF?=
 =?utf-8?B?Rkgzek1Tb0JYd0dpQmpKdTBkRy9aZzlnaW1YeHBvcXYxTlJONk5Ec0J6bGVJ?=
 =?utf-8?B?eEZ2bkthc2lSWlhLUnlFU0NaeWNjaVpvcnh0cExnWndQSlhkVVBXbnRha05r?=
 =?utf-8?B?UDRoSTRMRVZKVWNwK3U3a0t3dHpHMGUxTUt1ZVZUY2ZaeFh4UlhKak9CVHpQ?=
 =?utf-8?B?T1BOd1RzQ05UenROcXEyNkpZUkJ2V2RsMCs4V21mOFJzSlBGTFdsVnJkakJL?=
 =?utf-8?B?MXFveDU0KzJ5VFdxMDhNWGlqclJoTEtPelYwajkxS0NCNmwvMzcyR3VvMlR2?=
 =?utf-8?B?MW5maVlKYkYwcXZwcGtNQzVzMGRiOUhqdmc1eHNTM3g0OEo3RVd2akFLSXV1?=
 =?utf-8?B?RUNzUEpmNm90d3E0azBZaVpjUjU1Y2FNMUtSRzdJRFRVdmM1VGZpL0hEcmM2?=
 =?utf-8?B?c2J2TmhSUzlrcFpEeXpSMnQ3YzJ5NUovdTQ1Vnp4YXdpWVdsOTFzTmlHSkpE?=
 =?utf-8?B?Z0EwOTZnQ0t0WlFMNFBNcVpUdXRleForOUM2NXhCQ3VYSm1WZzNjY2ZTTGF5?=
 =?utf-8?B?TW9nY2JDNmlOUXdCRjV4U3YwSWRlY1NkaFdkS2E2aThXTGkwbExOamFzNEFi?=
 =?utf-8?B?V0dFTEQ5VU1WSWlwUXhuRzJsd3JnSlN5YTI3YlplVThSeCtRVzNFQ0xpVENz?=
 =?utf-8?B?SnpFc3kvZW5ha1RsRDZ1Sy9qM3h4QzJQSG1VNWkxSmlsbjNoVlNOS2dydzJk?=
 =?utf-8?B?VkU0MjNpdUdJelp3YUlqT0F6NzlpeU05MjBWY0xsVlRDS0UxUXl5bzFTV29F?=
 =?utf-8?B?ZVBqY3pCWXdJZlRsV1drSDJaOFdoYis1TEpPWVAyRzduTHVtWGN1TWNSQllY?=
 =?utf-8?Q?mSnHDxUgMzmEXP0wJKS2JpGs160lO9CL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnQrUVhDVXdSRU41UnlEWlptV2RHTEl5VXNtMmk5engyZmRWVmZUNW4zRVds?=
 =?utf-8?B?V3BrSzkydjFqOXFma3JEOG1ndlFoVDFhUmd2eld1dGRjZUpOb3p4RmNCQmox?=
 =?utf-8?B?Y1FxNXNZNjZSZkY5Rm5ZNDZvMnZST0NDNFRUMFFEblV2bVlPV1JNY2M1WExI?=
 =?utf-8?B?Yi9McS9MUDRLVmdjZXV3UHRDNEEwTE5hdlI2VXZJZFpybWpsWmNGbGFuaVBH?=
 =?utf-8?B?NmVxdEE1WFNUa1ZySzR1T3puVVNoSmd5YjQ2UnlZcFNqLytkeHJPOTJreitz?=
 =?utf-8?B?ckgxWkYrZUdvMGsvaS9BQ215T3pPaGRGRFJkektYRjhqczM5UjhQd0dFTzIr?=
 =?utf-8?B?ZzB1WG5oSzI3SUtXTEhseEJEVmZwTCtpQmpIT0VMNnErSDdQV2h0NTZxMlI1?=
 =?utf-8?B?N2gxRGNZNDhlWDZIbzQ1NHF4OUZ1eHMxcWszRmlnbmtNWktLYzlFcG9mcFB5?=
 =?utf-8?B?aUU3RkY4TDZiUmNXRG1KOERJRkZ3OU5QVXZQZHNvSE1SWWVONDg3aTdQSnRR?=
 =?utf-8?B?dnUvYUEySEFuUjE5dkRkWXRuZGx6Z1hLVE1RZ3NPM1JKT0d3RnVUZmlCRDdj?=
 =?utf-8?B?bTE4ZE01Ukp6UTZRQ1ZnVGhHbjRYOTlxVUduZlZwU09zaW50LzhQaERxbEU1?=
 =?utf-8?B?ZEZHcVM1OWVLMGk1ZTJGUGxXUzNjTXRUaFZ6eityUmtnN1hzanphb2VSbkpt?=
 =?utf-8?B?UkRtUUwrdVB0Q3FEWXE2YzBoaGhLMXlwQVZTUjN6MEZSN3B3VTVyVEJ1TE1l?=
 =?utf-8?B?R09UVGJIZ0NoUkQxNW1mRkNZdERzWEg4ZVZNVnQwZ0pPT1NBWlkzdkZRN2Zr?=
 =?utf-8?B?eWYxTjhWNEhvYkIxTEh4cWIxVGV3eUdaUE5DTWVNd2pjK1NDdkZ4ZkgzNUFI?=
 =?utf-8?B?c1ZSS0FtY3diVFlqV1g1VDFRdDkxM0tGTHB5Z09jaEZ0clc5N0t5cnJwV0Fm?=
 =?utf-8?B?bVRqUTdhRWNXYmRtOTZ0NjFleVNnNG5xNnNtK0Y4ZW5LWnV1Q1Q5TEcvWGdO?=
 =?utf-8?B?V1RsaWNDWlRGL1djL3pRaXhNZzgwbXF0TVZqV2NwNG44ZXVpUzNGY3U3OTlV?=
 =?utf-8?B?UVJUb2FuY1NzV1VtampKcGs5ZHZhMjZBQ3RhNDl3L0FJUG0zL3ZBQmNZZ1dB?=
 =?utf-8?B?V3Z5KzROVUQxRk9jZ2FVS3Rtc2U1R2M4VUZFZUtzS0NydTlOQXNUdlQ3R2k5?=
 =?utf-8?B?dlo2UEwzN0RpQ3plNCtnUXJCMkxkZ1Fvb3NhYVpzZFRmTyt4aEtTVzBDNXdx?=
 =?utf-8?B?cnp5NHFEZDgxai9ENkFmZnlFUTRUNWxZSXd1blRLcThTdmswaSt6Y2hGWEJO?=
 =?utf-8?B?N29PWkxvVUp0UnkzZ1k4aTdBKzcwQkJPYkxoM2lxWnJDOTBkSXJWS3RhS1cy?=
 =?utf-8?B?dGtkTTlMNXJrY1RHZWNOYTU0dXA2UGh5YWVYR0xGQnhFaVh4aTdneGxCM3ZF?=
 =?utf-8?B?ckxXVWtpcEZVZGNFTU1OYTBtYnNDU3ljSzh1MnBoYUVRcUJESHE3UmxoSmgy?=
 =?utf-8?B?U0FTcGc3bkljUWlUSnE0dUh2djRxc215elFQd016MXArcTlmRysrQk1WZWhZ?=
 =?utf-8?B?dGJFeExWZG5aMElqcENJNTZKY3RVN2FUNkZsRE0vUW9MbyswN3hnYVE2am5x?=
 =?utf-8?B?VDdTOEEvMGVDcnRTYWxJa2dPYVk4d01YQjNQRlE1aXFjSXJsR1hSVnZ2SjRR?=
 =?utf-8?B?dWxkNEI0bXhYTUd6bU51SGovdXRxZEJ3NVFJdGpZMjl6b1ZkcnV4ZmY2RUZw?=
 =?utf-8?B?NjhydWZzUlBIYTFKSkhIb05mK3BNZ0pmTUlRcXZtR1NNK0I0Y29IMFFLZTI5?=
 =?utf-8?B?M3RUN1AxbmFWUUhSR0NaNjIwZ2tNZ1FQc2dxUFp6L1JxRXNOYjNWQjZDMnlr?=
 =?utf-8?B?NE5xNnlmT3MzZG5hdHp5akFFbUhYT0NjMmI5UjJ2Yk90VGQzTzZwSVA1UzJK?=
 =?utf-8?B?VWMrd1dpNGV2djE4MG4zeVpjWk41T3o0ZjBiYVQvVW9DOVNSQlpTN3pOVXVi?=
 =?utf-8?B?N2xSSVJPMDRrWnZyQ0xRT1MvV1FnWExlZUQ3eWhBbzhUdUFyRmpIcDRveHYy?=
 =?utf-8?B?b3poZGRqY1p4R3BPQnVSYzJydllxQmxRSGExRVVvZnVraUd4bXZQUDNKbm1I?=
 =?utf-8?B?STdNdjV3K0hBMjBJQVR6N0cxTjBKNm4vTUtYY2E2UzBLL1ZYN2lPMm5GOHhL?=
 =?utf-8?B?UmpPQklhbFIwNUJNVUR1RUNGN1Z6aE05MmJTWmg1RUR4Mnp4b0ZXZnB3dHJ3?=
 =?utf-8?B?VHlsbU55OTlhRDE4RmVZeU9DYmFlckZMRkI4UlQ1ZS9JY3VBczg2a3FyQWpx?=
 =?utf-8?B?NUh0dGlnMDExTHY4YmZpWDhob0xjaEVaelFvOEp3Ym5yaHl0Tmo3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702d87e7-dbfc-42fb-6595-08de46f754a2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 16:28:42.5448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldZPzlMyh7cAhpNIk8Ve4xpIX0GNOrf2sMqGOL1MaW0WJiXuBw0aRvig94ZDqn0IFvY0p3cZLaDvUMc0U7KW2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111

On Sun, Dec 28, 2025 at 08:37:14PM -0800, Paul E. McKenney wrote:
> On Sun, Dec 28, 2025 at 09:49:45PM -0500, Joel Fernandes wrote:
> > 
> > 
> > > On Dec 28, 2025, at 7:04 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > ﻿On Sun, Dec 28, 2025 at 06:57:58PM +0100, Uladzislau Rezki wrote:
> > >>> On Thu, Dec 25, 2025 at 09:33:39PM -0500, Joel Fernandes wrote:
> > >>> On Thu, Dec 25, 2025 at 10:35:44AM -0800, Paul E. McKenney wrote:
> > >>>> On Mon, Dec 22, 2025 at 10:46:29PM -0500, Joel Fernandes wrote:
> > >>>>> The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
> > >>>>> State) design where the first FQS saves dyntick-idle snapshots and
> > >>>>> the second FQS compares them. This results in long and unnecessary latency
> > >>>>> for synchronize_rcu() on idle systems (two FQS waits of ~3ms each with
> > >>>>> 1000HZ) whenever one FQS wait sufficed.
> > >>>>> 
> > >>>>> Some investigations showed that the GP kthread's CPU is the holdout CPU
> > >>>>> a lot of times after the first FQS as - it cannot be detected as "idle"
> > >>>>> because it's actively running the FQS scan in the GP kthread.
> > >>>>> 
> > >>>>> Therefore, at the end of rcu_gp_init(), immediately report a quiescent
> > >>>>> state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). The
> > >>>>> GP kthread cannot be in an RCU read-side critical section while running
> > >>>>> GP initialization, so this is safe and results in significant latency
> > >>>>> improvements.
> > >>>>> 
> > >>>>> I benchmarked 100 synchronize_rcu() calls with 32 CPUs, 10 runs each
> > >>>>> showing significant latency improvements (default settings for fqs jiffies):
> > >>>>> 
> > >>>>> Baseline (without fix):
> > >>>>> | Run | Mean      | Min      | Max       |
> > >>>>> |-----|-----------|----------|-----------|
> > >>>>> | 1   | 10.088 ms | 9.989 ms | 18.848 ms |
> > >>>>> | 2   | 10.064 ms | 9.982 ms | 16.470 ms |
> > >>>>> | 3   | 10.051 ms | 9.988 ms | 15.113 ms |
> > >>>>> | 4   | 10.125 ms | 9.929 ms | 22.411 ms |
> > >>>>> | 5   |  8.695 ms | 5.996 ms | 15.471 ms |
> > >>>>> | 6   | 10.157 ms | 9.977 ms | 25.723 ms |
> > >>>>> | 7   | 10.102 ms | 9.990 ms | 20.224 ms |
> > >>>>> | 8   |  8.050 ms | 5.985 ms | 10.007 ms |
> > >>>>> | 9   | 10.059 ms | 9.978 ms | 15.934 ms |
> > >>>>> | 10  | 10.077 ms | 9.984 ms | 17.703 ms |
> > >>>>> 
> > >>>>> With fix:
> > >>>>> | Run | Mean     | Min      | Max       |
> > >>>>> |-----|----------|----------|-----------|
> > >>>>> | 1   | 6.027 ms | 5.915 ms |  8.589 ms |
> > >>>>> | 2   | 6.032 ms | 5.984 ms |  9.241 ms |
> > >>>>> | 3   | 6.010 ms | 5.986 ms |  7.004 ms |
> > >>>>> | 4   | 6.076 ms | 5.993 ms | 10.001 ms |
> > >>>>> | 5   | 6.084 ms | 5.893 ms | 10.250 ms |
> > >>>>> | 6   | 6.034 ms | 5.908 ms |  9.456 ms |
> > >>>>> | 7   | 6.051 ms | 5.993 ms | 10.000 ms |
> > >>>>> | 8   | 6.057 ms | 5.941 ms | 10.001 ms |
> > >>>>> | 9   | 6.016 ms | 5.927 ms |  7.540 ms |
> > >>>>> | 10  | 6.036 ms | 5.993 ms |  9.579 ms |
> > >>>>> 
> > >>>>> Summary:
> > >>>>> - Mean latency: 9.75 ms -> 6.04 ms (38% improvement)
> > >>>>> - Max latency:  25.72 ms -> 10.25 ms (60% improvement)
> > >>>>> 
> > >>>>> Tested rcutorture TREE and SRCU configurations.
> > >>>>> 
> > >>>>> [apply paulmck feedack on moving logic to rcu_gp_init()]
> > >>>> 
> > >>>> If anything, these numbers look better, so good show!!!
> > >>> 
> > >>> Thanks, I ended up collecting more samples in the v2 to further confirm the
> > >>> improvements.
> > >>> 
> > >>>> Are there workloads that might be hurt by some side effect such
> > >>>> as increased CPU utilization by the RCU grace-period kthread?  One
> > >>>> non-mainstream hypothetical situation that comes to mind is a kernel
> > >>>> built with SMP=y but running on a single-CPU system with a high-frequence
> > >>>> periodic interrupt that does call_rcu().  Might that result in the RCU
> > >>>> grace-period kthread chewing up the entire CPU?
> > >>> 
> > >>> There are still GP delays due to FQS, even with this change, so it could not
> > >>> chew up the entire CPU I believe. The GP cycle should still insert delays
> > >>> into the GP kthread. I did not notice in my testing that synchronize_rcu()
> > >>> latency dropping to sub millisecond, it was still limited by the timer wheel
> > >>> delays and the FQS delays.
> > >>> 
> > >>>> For a non-hypothetical case, could you please see if one of the
> > >>>> battery-powered embedded guys would be willing to test this?
> > >>> 
> > >>> My suspicion is the battery-powered folks are already running RCU_LAZY to
> > >>> reduce RCU activity, so they wouldn't be effected. call_rcu() during idleness
> > >>> will be going to the bypass. Last I checked, Android and ChromeOS were both
> > >>> enabling RCU_LAZY everywhere (back when I was at Google).
> > >>> 
> > >>> Uladzislau works on embedded (or at least till recently) and had recently
> > >>> checked this area for improvements so I think he can help quantify too
> > >>> perhaps. He is on CC. I personally don't directly work on embedded at the
> > >>> moment, just big compute hungry machines. ;-) Uladzislau, would you have some
> > >>> time to test on your Android devices?
> > >>> 
> > >> I will check the patch on my home based systems, big machines also :)
> > >> I do not work with mobile area any more thus do not have access to our
> > >> mobile devices. In fact i am glad that i have switched to something new.
> > >> I was a bit tired by the applied Google restrictions when it comes to
> > >> changes to the kernel and other Android layers.
> > > 
> > > How quickly I forget!  ;-)
> > > 
> > > Any thoughts on who would be a good person to ask about testing Joel's
> > > patch on mobile platforms?
> > 
> > Maybe Suren? As precedent and fwiw, When rcu_normal_wake_from_gp
> > optimization happened, it only improved things for Android.
> > 
> > Also Android already uses RCU_LAZY so this should not affect power for
> > non-hurry usages.
> > 
> > Also networking bridge removal depends on synchronize_rcu() latency. When
> > I forced rcu_normal_wake_from_gp on large machines, it improved bridge
> > removal speed by about 5% per my notes. I would expect similar
> > improvements with this.
> 
> Could you please try running on a single-CPU system or VM to check the
> CPU overhead from RCU's grace-period kthread?

Hi, Paul,

I ran some tests with single CPU and used perf to measure overhead of the
GP kthread (rcu_preempt).

Actually, the GP kthread's CPU usage goes down, I believe this is because it
sleeps more.

I see similar/same results with synchronize_rcu() loop (200 iterations). I
also tested call_rcu() stressing from timer interrupts and call_rcu_hurry()
flooding.

                          Baseline    With Patch    Change
  task-clock:             1008 ms     898 ms        -11%
  CPU cycles:             48M         44M           -8%

Should I add these results to the changelog and send out a v3 (preferrably
with your review tag if you approve).

thanks,

 - Joel

