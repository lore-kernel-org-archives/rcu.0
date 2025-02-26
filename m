Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5723BB
	for <rcu@vger.kernel.org>; Wed, 26 Feb 2025 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528753; cv=fail; b=AAmYL+F5a86kAnIWAsOH/Z7As1SNgFGEVbCeIZnHwvA2UKNJ7EKyYqc7hHF2LcP4CLWZELBCrthVbBTtMTTcWUBKY6oag95GiaGIRDb5u0eVKdGn70VFeyCDYluWRymeP+LzAf/fVflV0g2JQDyD2aBnrEog3Ol3uqi+Avcl28I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528753; c=relaxed/simple;
	bh=IrSFMzjJ+MvYYvFMELuhIUH5KwYJ7piVhLdXhPWLRDU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BQFfFsW5DSuuKv2DKZ/VVW/eT/hfTSy3MXa7UllsPYeZaJzMAKgFhfceKvgrVjn8fy3ixf1BFMCc8NFMbvIFJhY9FQLLPlLSyBD9L0a1PhROPpVv3OjooQMOtpu31NSADPeYBFq4eCppTkqbDYY5u7NAndPMw38k27JUnyG6ebI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o0fAiw7o; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o0fAiw7o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhxO52DITtI0j5ARETQZ5x+xqHcytEOPm58HyHa5ZayisYLBim5FJxPXPoalysRQRZKX9ObdSf8hPaee1K/J1ohaq7cEo0yv+M7WXEVFm5WVYPJ6q8Q5/vKWXMAlGoSLQXkVp1WC1wjg02+oIcd6evY0gOkyZMPtd7u69SnAm6BhyjaSKYRB8CYauUgPdoabBT9x7rD4VTaQQtbc1S6cywqQlxhTAsRt3YuDZRcImiao7QRRY5kOEckVi4ez8qLLybXk5vHO4/Lmra/oNV75l2f8Bab7N0WQ9WSDjxImthcVw1sLxQjj7OYXQRkyYm0xEyfXIFwKZFxW9gB8QrOCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrqTbvOLZxkC5OnYySNXmASgHdjhF1PWhI+lc1/Npus=;
 b=jJznXqm1JTScu6IEzHGapLZoRcbyfMMVKJsET6ilhLXgZnms6iggT7xbhsV0g0KKnKIPo/1IwCWSAmAtX5JzmH36RDSOclxNyj/UiJoSIek4qlS3msmUHn/4Js1VooF1X5r0Eekg7Do/AnFHA5PL/sszwkaTKaFee9l8uXRDxqlR7WbvQkiidDSvDZmMeJxHAjGo5WcprmrlIp25U6DH19AT7H013kp8Xs24Vmillb934Q4J+0p2nZPrYfFyQWgOWJEo71RU6VYXqQz2NOYntxBHc4o4NgB81zIf5N4AOl0j87o54AlGLhMXxYUIcpnE6IvfDecShWAt50R1OzWJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrqTbvOLZxkC5OnYySNXmASgHdjhF1PWhI+lc1/Npus=;
 b=o0fAiw7owoRDXew+editznFoIGt4PUOGz3NE7fGdPoqVPoGWCwv2Nfa/TC98StUh2NmmA+YMkgJXqMVeoLudVjRmHetqZgw7E68ad0866sg8zOLPnYVHDL3zSBS9sSvBzq8w4t18gWxfG8vxlEgXuIi8pstWqUjTAHk09X6OLD1ja7rG+cfj/D9+MZLX/DK85PcDlu66DxCl94BWjZNzvfnQclQoTcxGrS0ng03Sm15cZHJl86uBdrosrZpv1OHvc77s1jlSdlGZrbhqwUI6ZJjhHdj0ZZ7LimkUnBGnz85z9CEmVG6nNp7AOk4y1wJmkS715KV28HlJAvpy/pLhIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 00:12:28 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 00:12:27 +0000
Message-ID: <f9620624-807e-4b2d-afc1-8207e06d2c63@nvidia.com>
Date: Tue, 25 Feb 2025 19:12:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Testing of shared RCU branching
To: paulmck@kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org
References: <c5bd6873-6e29-4f44-9c40-fbdffc6d1165@paulmck-laptop>
 <Z73rFVTHr-etZ8SE@Mac.home> <Z73rn9nqlCwns1IY@Mac.home>
 <267f54c6-4604-41fc-8cc9-6adb761fa257@paulmck-laptop>
 <20250225212007.GA1806882@joelnvbox>
 <e4853773-f834-4224-bf17-f7ed895ffef3@paulmck-laptop>
 <5c7f08b3-a007-4bd4-b063-eb034373a385@nvidia.com>
 <6bb936e8-5507-456c-a77c-3a72e40408cb@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <6bb936e8-5507-456c-a77c-3a72e40408cb@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0362.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::7) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: b636585b-3b7c-4f5d-2ab0-08dd55fa4106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjdkUW43RmJiY2tETFFkS3Z3UTNuaHdDQUVmOE1XZ2ZXNUt6ZTdIS3RNeTJC?=
 =?utf-8?B?a25EWllNZlRPcXhKeTR5QlgxWXVNMkltRk9EVUwwOE0yWDVpOFJlQlBjeE15?=
 =?utf-8?B?dHRxZzIwR2M0Q25wb1Q4TUFXWWZSdWkwcVdReUlpWEhXN0FiUXkydDlvVEZk?=
 =?utf-8?B?T2U0cHQ3Yk0rTFhjSHZuM255d2djT0J0MnBHcUpuTHZMano4Y2RVQWxzcE5O?=
 =?utf-8?B?eEkrMWY0YnV3Vm1DYjljSVJnTlBXSzVMb01mRVlBcjQ2Z3JXbDlSNHhoQUox?=
 =?utf-8?B?d3NQR2xmN0dsZERJSmJFc0ppdjFPZy8zamZnR1IwZFp3enJ3ODhHc0FwSUtP?=
 =?utf-8?B?NmFGdlJJTFB1NHd0MGRYcWRWK3c2bzViOS9xMngvbDFkY3NTcVZQTlcxbWw1?=
 =?utf-8?B?QzZjT3QvbEttWCs5dk5iQXdBQXowUXh4dlorVVRvZUxwRGZnT2RleHcyVzhX?=
 =?utf-8?B?WUxRVGUwR0NpWnFVNkZXaHBnVG1CeHl4Vm9MNlFMWHBRVzBLTkJPQ0tsM0Jk?=
 =?utf-8?B?ZkNsK09tYU5HTDF6bU5IOW9UTEJQZDJNeXpZM25rcklnaUZZTjNvcE1iVE5w?=
 =?utf-8?B?NTZ2bzlDNjV0eXc0b25TUE1ZdG1QY2JFK0ROaDVjdFpoOGZHZXJHUE1QZVNw?=
 =?utf-8?B?djVyOWUzOHVnZ2RyMmhxQmNxZnBhbU9wbU4zb1UrdXZOUTVENWphczB5NkpF?=
 =?utf-8?B?M0dCUnlNNUFDbGttcjVPTW5jOVBQa3pydnczL1VrcmpsRjc4aEtrajVsNGM3?=
 =?utf-8?B?SHU0TWgvalFCbVpHeE12TzNlYjFXbmtORVRaSHJUaHR0b0hnL3lpcjZFbUZH?=
 =?utf-8?B?T2pNQTVoZEE5dlRVeUZhY0tZWWZKUWhLMkdOSGVKUm9qcFR5d0RwcnJTWm9R?=
 =?utf-8?B?aFk1eS96K3BCQlRDeGljUElqSFFaSnlkd3RQOWN5dGpzVWZyTm5FWTVVR2Rx?=
 =?utf-8?B?aDNCZzdKNVo4eXpiSUV2dVVHQ1htSUdaM3NXQS9qNm4rMjdCSjl1YTZ1eEND?=
 =?utf-8?B?QldJekM0U1g3NzNWUUFrd0ZUUmF3RlF0Z1dJNllmSzBQUStIdXl4YUpQWm5G?=
 =?utf-8?B?TVhlV3BJYWxwMXVNQXc3V2JKMmkwd0JEVEZTOXJEVkRoN0w2U29uRE9wY24r?=
 =?utf-8?B?S2h3OHZ1TnkzMGFSbmNYOW5tV2hzem1aeUhNMnlRVnZtMkNMa1BXL1NCbTc1?=
 =?utf-8?B?c2ZocVJLWVpRT2NLNElLR1RTeEEwSFFQS2wxWHdGaXNCcW1mTGxkdGRHaVpJ?=
 =?utf-8?B?UGpRT2U4VFExVmhIYy9lU3FjNFlGeHBLNDZLekgvSEZ6Z3hJMS9ObE1oRStE?=
 =?utf-8?B?VUt0ZE9rOHZlMjdZYjROT0ZSQ3hxM0hraUhrblExY1ptZWVLNFhjUVN4V3pv?=
 =?utf-8?B?a2F2UmFJazNUQU5BZTgxUHN6dk9kbjJqMEJyWHEzNmxzSUdQSTZnWG9RdE9h?=
 =?utf-8?B?V2pkbm1SWlloSEVZU2tyV3ZoTFdEOE40T1E2WmxWN0VBVW0zNkNlOENqWFZJ?=
 =?utf-8?B?RE5xelVlSXo1TWpKdmE3cmtXMTA1NEhjU2k1U2RlTUNPNm9SRXRpNU41dEZT?=
 =?utf-8?B?MURJd0FDbXRKTkhmU0lTOXczNjVlOS8vbUdDWU0zQkZDODVCQmtETHFpRTlV?=
 =?utf-8?B?cG9ta3F2M01JRUtKcTQyQWRJM21WbENhNW5wUFFWemZYb1hPYWFjcWRMZWNm?=
 =?utf-8?B?aStuNzU5N0EzTE15RXdnMnUzMmtPRjBqZkxDWGgyenQ0aHBCT1B2YVplKzQ1?=
 =?utf-8?B?V1VmKy8zd2UwSHZoUmRFZGtXZU1jZnJQU3hZbExrK3BRQ0F4VG0zNExyM2hl?=
 =?utf-8?B?U2NJTjRTd1lnNVJyY3RiUXJDWVFrakQxMmRnZnF5QURvTnhTQkFxb2VOZzhO?=
 =?utf-8?Q?ZxeSGAXDX8/us?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGtkZFdlRExId0tKQXRIYWJJMXZmcm9WQVkvTUQxejBCMTlEV2V2V0JLUWV5?=
 =?utf-8?B?VEd4MUU5ZUlGbUYyRm9kMWk2RUZmN0dGbGNHTG94TVlrTmV3QkdkNDR2SzhS?=
 =?utf-8?B?MStTWFJjYUZXUkoxYzIyMit1YWl5SU1VMGN0UG11ZWhSbkRXbHBUcUx1Ymlq?=
 =?utf-8?B?RTUvN1VpNFdrcHluZmdycXJvWHJmWGhCdFBMeThQTXBtV1F0YW51QXBiMHNX?=
 =?utf-8?B?OHQvbXlhbG9nUEF3RjUzKzVVQmFQRm5JODdCUkpYKzNmaU1SdU1hTnNPdkxY?=
 =?utf-8?B?WXdQSHlGZG54Q0Jsay9CZkY0UG10Wm9PUlF3ajQzMGRod0hiSGN3eTZ3aFkx?=
 =?utf-8?B?aU5mMTlTaEZmSjJsak5nRTZ1QzhyWjZYZWI3VnA0UE96M09NT0swNWdnZ2oy?=
 =?utf-8?B?cnpuUk1mVEgyU0RtZE9NNlhzSFZ4SWVmREp2b1NkcHJCbkgvQW1ZaFpLRXYw?=
 =?utf-8?B?eGRqK3ZKdUR3U0JLb0o3OVdna0F6RTVXMDk4TjhLSU5Cek1Yeng0enBaWkJa?=
 =?utf-8?B?M2YyMEM5NkZrNDVDQWhSNGVsenJ6M3c5Rmx4WDR1MnA5N1hxNkIvRFJYbXl1?=
 =?utf-8?B?cksrd0lVRTRiQXQwMEpKQnJNcEQ2ZVZFVTl1eDgwOS9YaEJLNE5ZcG92T3pq?=
 =?utf-8?B?VER3N3l2N0ZwbU1zNWJrK29SNHFzdExKK0piS0huVlpQckRacUhKeWpsa2Zq?=
 =?utf-8?B?bFV6WGtkekFFTTBGRW9uak92TmdONDNnNWgyZ3phMXdqYmtmQmYxaURMWGoy?=
 =?utf-8?B?ekdWUDBjR3F2UzFtUnREeDFJZGE0bE9KTXpNa2phM24zeThCK0hvUEpKMEFC?=
 =?utf-8?B?T0pFRGY0aVZDM2cwekllckRMQS9aK2ZUS2ozdm9xUTBhMEpxUHNka1B6eGxi?=
 =?utf-8?B?Tlg5aW9GVTNnVDEwaE1QMlBYZWhkb3NoYmNmRGF0VWpmSFR1ZmNleDkwVHRt?=
 =?utf-8?B?T29DeFoxY2xWVGFieTV0K0QvaXBlL2pCZkFsdkZ5eTlNL0RxeHZoOXVvM3ov?=
 =?utf-8?B?K2J4Y05oSjhKZG1oUWcweFNsSG1lNE1ZMzJkYm50enlOdGhqN0RBZklGc3lx?=
 =?utf-8?B?Z3FCUi9QakFPVXlSL1p0T0NZbTc2QTl1R1N1TDJ2aUVUdC9nMmJoQzJaYzZk?=
 =?utf-8?B?RzFNbHUxdTlTL2E4Tk1UOUdEaEhWSmRHSlNCU3pCYjY0dTRSd2U5VlJ2dEE1?=
 =?utf-8?B?c0ozTmFvb1pqQzF3R3FiNHE2Y3dvelgrZlU3T3NLbzlEUFVCZzc2L0x3QlBv?=
 =?utf-8?B?eDJBRFEyQkQrd3FhZ0taUHpkTWtUaVRvbkhCVFo2VTNiUzVUVDZadGVzT0pl?=
 =?utf-8?B?b2RzWHNBbmRETDhuOGU4T0plbnRxYXREU3R0dXdaNEFuZjFLcTQrZitIVlVQ?=
 =?utf-8?B?MGNITUhGdThiRWNZdWhkSzRwelRDU2RBM2lBSGdkZ3MvVmhlSzNIaG4xeHNv?=
 =?utf-8?B?bnhLc2Ewc2dpUCtEd1cvUXJBT3I1MkFtVlFTbTMxSTYyQTBIWXlGMExScko4?=
 =?utf-8?B?MUljcDMrVG1FdktZMkNtaEdRU2JtYkRkOERNZ1lzUmJqQUVyNnNWSlJ6aExi?=
 =?utf-8?B?eWUxdFVMT3N5Y3F6NURYbnIvTXFBNEdCTC9NNTRLODBWenNWRHJDOU5rUHlV?=
 =?utf-8?B?VkNQbDhwYXBGVW9hcTU3bW8wYzBWTTdDY1Q2TnRjQkUrQ2wwVUlWdlFjemxm?=
 =?utf-8?B?UDkvNEk4NHdPbVlRbElmYmIzcWwrWDliQjhjK00yVnBEYTdlVEJpbHdoa2Mz?=
 =?utf-8?B?bDQwM1pVWFczWE1jY2tFejVTbDZrR2FSaGphaWRoNzIzZUJTVmtHUlhrYVNM?=
 =?utf-8?B?YTZ2RlRYQTlNSDhOQTJicmFUTXNnRmlvUm5IYnl5Y2Y1Y01mZk9vdm12L0NL?=
 =?utf-8?B?cEEwd0ovOVE1bzB4ZGU4VXJ0dWN4S0dqMW5kY0h1RkxBeWFRQnBhcCswSVNq?=
 =?utf-8?B?d3Q2eUNNMW45Vm9SZU9rUi9sanY3Q0NQa3l4a2c4OElRem11Y1ROcnhpT0sr?=
 =?utf-8?B?ajlDbjM1ZHp3THg2cmU3cVIrUDJKWmlndHZ6WWVMYVk1WXBuOEY1R2dHYXlj?=
 =?utf-8?B?QjRONGdUdXhjaFVvVUhmQ0tXY0IrSUpKRkhPajNoNDB3OExpeWxDY3RUZCts?=
 =?utf-8?B?bU9hWVN1R2dLcFJTOWVFeXkvSGFCZlRYdUpnMDUvVGJSNDFCNWFxU3ZNdHZQ?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b636585b-3b7c-4f5d-2ab0-08dd55fa4106
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 00:12:27.8926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rk0lwcH2jVeQxkdZ3+zjvq6+w3IT5fQbOv0+Gxls8KbO3UzJpCtlXcQT6ixif7QMnXAXoe/UaX7/GK3CVqmpIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547



On 2/25/2025 6:45 PM, Paul E. McKenney wrote:
> On Tue, Feb 25, 2025 at 05:04:37PM -0500, Joel Fernandes wrote:
>>
>>
>> On 2/25/2025 4:53 PM, Paul E. McKenney wrote:
>>> On Tue, Feb 25, 2025 at 04:20:07PM -0500, Joel Fernandes wrote:
>>>> On Tue, Feb 25, 2025 at 09:54:29AM -0800, Paul E. McKenney wrote:
>>>>> On Tue, Feb 25, 2025 at 08:11:11AM -0800, Boqun Feng wrote:
>>>> [...]
>>>>>>>> These passed other than a KCSAN complaint involving
>>>>>>>> rcu_preempt_deferred_qs_handler() and rcu_read_unlock_special().
>>>>>>>> This looks like the plain C-language writes to ->defer_qs_iw_pending.
>>>>>>>>
>>>>>>>> My guess is that this is low probability, despite having happened twice,
>>>>>>>> and that it happens when rcu_read_unlock_special() is interrupted,
>>>>>>>> resulting in rcu_preempt_deferred_qs_handler() being invoked as an
>>>>>>>> IRQ-work handler.  Keeping in mind that RCU runs KCSAN so as to locate
>>>>>>>> data races between task and handler on the same CPU.
>>>>>>>>
>>>>>>>> Thoughts?
>>>>>>>>
>>>>>>>
>>>>>>> Do you have a KCSAN of this? Also this is not a regression, right?
>>>>>>> Meaning you probably have seen this before? Anyway, it should be an easy
>>>>>>> fix (just using READ_ONCE() and WRITE_ONCE()). I can send the fix out
>>>>>>> and put it in.
>>>>>
>>>>> Here you go!  And you are right, if it is a regression, it is from a
>>>>> long time ago, though something more recent might have made it more
>>>>> probable.
>>>>
>>>> In my opinion I probably wouldn't even call it a regression because the
>>>> data-race is happening on a boolean element. If I am not mistaken, this is
>>>> thus a false-positive and KCSAN has no way of silencing it?
>>>
>>> You can still get in trouble with booleans.  The usual example
>>> is as follows:
>>>
>>> 	bool x;
>>>
>>> 	...
>>>
>>>
>>> 	while (!x)
>>> 		do_something();
>>>
>>> In many cases, the compiler is free to transform that "while" loop
>>> into this:
>>>
>>> 	if (!x)
>>> 		for (;;)
>>> 			do_something();
>>>
>>> Putting a READ_ONCE() in the original "while" condition prevents this
>>> transformation.
>>
>> True, thanks for clarifying. I will be a bit more annoying and say that in
>> rcu_read_unlock_special(), there is no such looping transformation possible
>> though AFAICS. The test is an if() block. But this is beyond KCSAN's ability to
>> analyze I guess.
> 
> Besides, better safe than sorry.  Especially given the decades-long
> trend of increasingly clever compilers.  ;-)
Yeah true, thanks!

 - Joel

