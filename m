Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F812EF9B4;
	Fri, 11 Jul 2025 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251415; cv=fail; b=OVhImh9rDjW4mMFbg7rlnkc2JnHX5ccWbjFJfa+HrpBitiJB+fIdtrF7QC1IdWbeVK1yNwLfzQxz0aUCPsF5G2xnnwtolDL4NuPoBarm9kzV1CW1mIS6EuvhrEsWWqeyo32PMMqmc4u19CHjvlOHlLxt5z1N1Vl0CJjC/RR4xRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251415; c=relaxed/simple;
	bh=+h2Ya/2bAvF3LMFYLJFflZq4kB8PpBVLZr56ILU79kU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R3TmFUNVVk+/VtzsM2j6v2Y/MYG29uSZMVV+PfEYG2kUNqcvfEeFbAQocGi5HVrlMEjk/SL7nUmZIVWlwuh2AxFQF2jcNPSv86E1XEYNsaEqbmAVzx35NSBOFSbB1kPOXlEjZto/be0reYNVMGHqlSkfQVIH/QLTYNaQ5ghW6WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Af7RxVMy; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Af7RxVMy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0VrsTKXHy6U7rBdnTeORV/fw/Zkhx8GIhu2ZXhXmVdchvriw6XElbyR54yfTUzvFEoQfiiOkbNd2NRqmqPmNuE9Hqhsli1gRt1PuJmRx0X4NdjWC4Hb2KyBG+zNLdi+1B4crJZa4++OcBkyeKpRuQfu6hjXwaa4PgLn+WaQNBKj61eqSp+iGjcQM3AugVsYCc40A8l5u/fWzig64TU0AMTDMt9Sjck+vCJY4i5vw0bLpor+on+WS/+0TlwOoLv4bCcK00UFg6WRVC2VbynhKFZeAFbr4CEj1nOWZLhcr8HbBPXxOhhw1FyXx7OwIRt3Z4OuIbufbqFYlNrUNN2Xng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8PE5FT7HucUrEPBByOWW2HuDmPgFDwo9PtZd4DkNdQ=;
 b=d56f37HBgJRPCdW8NPlBt86hsY4R2xmAptJIKBnnsXHKawuNNyQ2Upi6SiMtougNMndx8PWm1EQVshzdruUD/zjscSckAwnv9m4xnHGdmmuvOlZqr9+Ks2nT0nbq2XA9UNT9daGoqNyWMGXhiChPKxmTtAcPm/XYr7Dl7nNXiN9E0oPdzqhjH5Zr7TquMAB+VVdcjav0DtGaf3gxJsr5aGX7rPWIhjpH0P/INSBtUqxwoCQDUggTmRBYmkmOmAx9QuPk6KNOnANABAOBQ29V67Q6fvkkEdGtyew+mELKEOCNWAH4l7azHW1IrE/O7jhlGIXQMlgSvvvYCxgzuYEpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8PE5FT7HucUrEPBByOWW2HuDmPgFDwo9PtZd4DkNdQ=;
 b=Af7RxVMyRQrzgTu1UKJ4pEb3Bs8fLGGdnV3iPjUehGoKusl04QfLM0IcI/UbGW3CHyCsFEZLprH6NHeX49V4M/VyKMSXqo5pY+diZKmEoSh+gZZsR3f8y6yGIq25JAqgbJBeJhthV2/K3RXbYnpPy0WSxW92nPwYICEj1jvgxkpwtlI3prvrtvbPKIWJ2/DR3xYoom4THdZWgc/U6Q2brWjcyWlJ+iVfweUJXdoL0wVlbLuCIn3I4yPNp6k57fHPPlq1g57U1ZpNFj8jZMUdqQc4LTsk3fkuK+c9YNdxGWEZCcLenjDwx2Fu5hEbzEWYLVInWbpYy75CqALcCPvJ/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 11 Jul
 2025 16:30:11 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Fri, 11 Jul 2025
 16:30:11 +0000
Message-ID: <ebfa8f35-8ede-46c3-a865-384d12d11e90@nvidia.com>
Date: Fri, 11 Jul 2025 12:30:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -rcu -next 4/7] rcu: Remove redundant check for irq state
 during unlock
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 rcu@vger.kernel.org
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
 <20250708142224.3940851-4-joelagnelf@nvidia.com>
 <9b67bbca-dfdc-470e-9a32-486300efa586@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <9b67bbca-dfdc-470e-9a32-486300efa586@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:208:32f::6) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d9f915-4e67-4d74-4b83-08ddc09834dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVk4K0VqNGVJNFdQUWxZcWtsWWsvR01VZXhJVXljTXluZGhncmtzazZUeG1s?=
 =?utf-8?B?ck1ITCtmOURtYzlJVXIzaXVUa2RYeDZrb3pJTVMzcGV5SjlLd3lsblhDU3lx?=
 =?utf-8?B?Q1VLcDJQZTBPQndOWE1xeVp5TVRMazVhKzRYVE1Dbmt0MklWZU9xeWYvRDdR?=
 =?utf-8?B?WGhlV1NFcFFEaFp4dGI0dXpva09Qbm9GRXlSVUY5dzU2RU90ZXdtVklLSTF3?=
 =?utf-8?B?MHF4bmlKUlV6Z21yUlZPQ0RpaXc0eTNlSVRYeWxwMUtJU3ZrTW44cXpMRG1v?=
 =?utf-8?B?dFlmYlMvT0FhNzdUTDVvaWNpZHdzcWxWbTRBUXNYN1hFekx6SE1lMUIxOU1H?=
 =?utf-8?B?VE9veWhiWDVoaHFLMUpVcHdlWkltN2IwQVF3WjhTVkxxZmkvTVQ3ajcvY2ZP?=
 =?utf-8?B?OGs0RFhXQ3ltNUZsbXVlSWNYYXVqWlVrZnY0c0JTTW9BRHhNMHVTeHpwY3h2?=
 =?utf-8?B?aG80K2E3aXZ6T05DUWNOVWxuMUQwM1U4b1IzdEFJQkNBMXV5R05JbFAwNGtF?=
 =?utf-8?B?akFYWng5TWFYR3RvYmxXZ1Y1RWNiUlN6Ny9Vajd5dFhxNnJlcWdBWmcvWEEy?=
 =?utf-8?B?ZXhwcU5ZZ2drQUFsL3U1cjFpT0ZiaUVzL21MTExNQmhRbnRJNGRCOVNqQnZX?=
 =?utf-8?B?c2lGWm9YSDVRU2V3RGR3Yng3anhjMzIzSDhxTE5zOHl4bHowRVVTYzRoNGtF?=
 =?utf-8?B?TUI1ZnlGYmdtS09jMkN5ZTMzRTVJelZHU2dUZ3RhdHk5THJyQUNQeUNLcGNO?=
 =?utf-8?B?bnF4dWpOa0VsRll1M0xWOFlyNXFIdTQ5L2FyVjJka2V5QkRTYjQzRW1nVXMv?=
 =?utf-8?B?WVlLSlRmck9MdXVXNVYrM1BPQ21VcTRwbWdzemFDTkI2TUlheHppdGN3TmUy?=
 =?utf-8?B?M0dRMm5yZytVdFJKZGNTVjhYUE51WXhrSFpqWmZ6K2g4cVJHNWJzWDFNUkxm?=
 =?utf-8?B?U3lZTElsNkFlQWpnNU10d1g3V1ZZT1JkMkRwNkl4VElHYlJTTFkwZUt3NS9m?=
 =?utf-8?B?TEhyeEVYTkFTeDNyc2oySGo1OXJpOWtlVEdsZmlsNGkwU05xaHJjM2haUkRz?=
 =?utf-8?B?c2tNeGdDcHNXdmZ2Y25QK2t4K0pSVkVrcCtQNXJwMFU5cUlpeUsyN2UySkxv?=
 =?utf-8?B?QzFqeGp4NG1YdzRDTld4VXBybWNBMDVZUlVHWTIzRzk2UlFDYkRPTml6ejA3?=
 =?utf-8?B?bHIrTm5UdHJWcXZaYVhYVTRIbDNLOFJNa2UrWGI5Y3I0bUVjaW53dGdyQ3Ez?=
 =?utf-8?B?WHpkSGNKYnlRTVQ3eXlnSjVZeUZ0WWpMYnFjNGQwcVorYmJCdHlUNEIrVDV2?=
 =?utf-8?B?SWFyeityVHlTSWJNbVduU0FhOE85djRUWlZDeW1EbmRkYzkrWHltZmdvYUVa?=
 =?utf-8?B?cU1MNy96UVkxSUo4K1ZKMHR4S0paYzFyU0tSbnZSVHQwV2F4K2llS3NOenZP?=
 =?utf-8?B?TkkvMHd1TmYyOThKNWZHajJxR0lld2xZMFhzTjJBSGVpaTNrSlprR2R2Z1lK?=
 =?utf-8?B?NERGSjRQQ2pTM1hEalY3aEE0RU1ESDZqSzFBdVg3UC96OGhFY3RidFBLbHFB?=
 =?utf-8?B?R3JjRmJPaUtLZXYrQ05Hcm45cTlpcUx4RVdQUlZaU1VLd1V5eWU2ZS9oRGF2?=
 =?utf-8?B?em53WFM3ZUlJSGxuRXZ6L0xMakVmVEVrRXNpdmlKbkdEb0x2RmZucU5mN1Nj?=
 =?utf-8?B?T09xSFpYZzd6M0F1a0VsNy80V0htckdtZmR1bCtPSDVSU3RYVVdkeEZ5bU1v?=
 =?utf-8?B?dmRtRHR5dlphUDZvZkc4L2dlc3I1YUdHV0U1NDZIcDkxWDlpZy95NnFiS2w4?=
 =?utf-8?B?UFNjMEMyWkkyQUthbFpUbkpTVGwyRkJPelBlM21LeDNaRGx3VmxiYkVFaHRq?=
 =?utf-8?B?VmJhQnAwdTRBY0t4QlZOUXlTbUhIcWtaYWoyQk5XR2xxYmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEZQZUhTdjI0OTM2aGw1N0g2bkRqN2RoM3JTaUQ3MXh3cXVMSVV5ZnZXeTBs?=
 =?utf-8?B?M1o5TmNHVVlZd1k3bDZqckFjQ2NKMkFjV3loL0s5anBTRTVSTHVrOVgxN2dV?=
 =?utf-8?B?UEw2dFdjTVczNnd2MnMrZlhIVU5RVnY3aEIxL1ZFM2FRYWlUU0hmYldNUjlV?=
 =?utf-8?B?MWlQWmpwK2pmNFFOL3BsNWI2ZUUvNHFmT2tkK252UlgxUDRPU1JPd2hrck1N?=
 =?utf-8?B?eWNqK1poYjQwUmhaamtMUnZMVXlLN2dwbTdqSnE0ZVNOblc0QnlPYm1WSS9D?=
 =?utf-8?B?S2lza1RNK242SDhHK3VRMUNnWXZZQVlHRkIzZnRYU2o2ZmtpN2U1Qkwvc3RB?=
 =?utf-8?B?TDVuaVZZSkRKZVkva1ZJendPV3Bra3pROTVMS1dvWE9DSXNLZEV5ZGJQeUZi?=
 =?utf-8?B?L2REMnNVc25qcGJONWRQa3RhWXV2WXFDWHJxcmErZUtxMnp6RmRyZTdXVUNV?=
 =?utf-8?B?MzR0dHZid3dSYUZoZGVlejBTT25jUm9HZUUrV3c2N3YwR0VXWTNveWxVRDJ1?=
 =?utf-8?B?aUw1Z1BtV1Mxb3V6cVdJcG5UNlVJd1FCcXZ0SUJGUkFMYjd3cmRQVllSRkx4?=
 =?utf-8?B?ckg5dy9XZUlZeGlla1NMTW9IbVRmNngybkw1aHFLT3kzOVVyWGpFeFpzNW5F?=
 =?utf-8?B?R0pEc01GM213ZHhYeDl0NTRWejNkbTJ3VTJ0QUMrdTdScncySGhwRldxL2ln?=
 =?utf-8?B?ekd0a0ZQRG8yd3JwUFdzcXJSWlBuVWhYVUJ5dlJuTTJFOHZPUGtBamkwUGpr?=
 =?utf-8?B?Wnd4cS9hMUoxNnpjYzRKcGsvVkVoUWVFRytvdHo0ZUJLTjhJajFKRll3dEdG?=
 =?utf-8?B?WTFwTmhJZ2J6cHdLdlJQa2ZSZDZWKy9udE9hcTMvMUdqOG9kY0hrTEdxRFRG?=
 =?utf-8?B?Q1hSNGI3c0JnU3djOFBIQjFvdFN2RUJUc0VZdW5MOGhZMzlTTTV5Y21DN0xQ?=
 =?utf-8?B?YXhBSWJRSE5xY1VPN2s4aisyNGJobkxiVkFUa05lWWpmbzdPaWdiT2tYbFZI?=
 =?utf-8?B?QkxSbXdGcUpqUC9sc3UxU282QTdZQlhKNFc5bTRFUEJWWUFkcUIzd3R4Kzlt?=
 =?utf-8?B?MVdPeEcwSVlLZDc3UHJJT1ZmMEhNU21qRTUwNStTdkxNRTlQbmZUSFlMM3dH?=
 =?utf-8?B?eTZuV0hlc1hrL1ZaNjRWa0wwR1dYR0Z6eitDazRHT0w4T1dzWTlKZHVEOVAx?=
 =?utf-8?B?eWpVc3lWTFBZVXZ0eFhJUGRBYXRibjF0WnBhTk1OYzhNZFJEMkkxZWZnRWEr?=
 =?utf-8?B?MmQzNmNaZ0prOER0YVdBbTFmTCtBZmlGaHoydG9lQlZWdG5rQytwQlhjVlVR?=
 =?utf-8?B?ajRDSXBOYk51bFl4SXQ2dnVSN0hiNXhUNEhYTDBMKzhENlpyTEpkcmI3YXJz?=
 =?utf-8?B?S0FSdjRLbGNyb2tQN00wcnlnZXRheEIzdFlja2pndDRXdm9zejM5WjkwMEhm?=
 =?utf-8?B?S2JaSmFUV04zVU9tajdYbktxeEVPeTg1TS8rNjRkczdqWlBXbTU5QnZnVWJx?=
 =?utf-8?B?bDJ3eHRzemc4NUdrNmw5Q0M2VUg3VTB1cnUxZmJoOHVmN28rUnpsTHZNMVk1?=
 =?utf-8?B?R2QyYnlzVXhhRTc5R1htS0xqTzdCczRvOWFvR1Z0NWtGQXlSS2VxaWVNdE14?=
 =?utf-8?B?ZlQ3ZUdqNnROWEkyTUpYb1BISU9PVUIyRnlZb2gxVWJUblRMUmhlSGc1WDF3?=
 =?utf-8?B?endNSGhvZmh3V2I2S2YrakdXRGZSRitwZFVmMlpLTDcvMTJ6UlRJejNPVEtC?=
 =?utf-8?B?VDhlNlhuT0dEVHIzMWV4MkhoZWJjZGh0TFBwVWtxc21xWGhnakQxOU11T2xE?=
 =?utf-8?B?cGF0eTEzZUVnN3Mxcjd5eGxjaGdRN2ZGV2NLcjFRc1VyT1hzWFJOdUZWYnB6?=
 =?utf-8?B?cVZ1MytGNTJoeHBVUGIxTHR2QmNFZ0ZpbXczTWM0SXZ5NTU5NUVkMndEN3Zv?=
 =?utf-8?B?b3lyS3ZKbllLRnRFUkVWdkFKczZTcDZsWkNWSUJBb0RUckVMY1VIRUxQOWxT?=
 =?utf-8?B?VEZTNStyRDIzUHJSNGE2K2E2SW1ZcEVqaUM1N09lOUJleWZac0l0Zm9XaDVI?=
 =?utf-8?B?aGhHbVV0ODM0dkJVa3R4OGxBbkwyZjVRMjhlSE54RW11Z29uYjNFaDcrUzhL?=
 =?utf-8?Q?EcQ8PSGCIAH4H1v4BloYi6P5b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d9f915-4e67-4d74-4b83-08ddc09834dc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 16:30:11.2791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWgnC5J+C6cEsS/a72G564vC7KRK2toTX8wbNlJQDaLnGoKjpk3GkM60CVCrS+uFN8ReZ3moz8TqlyoDuZoXCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998



On 7/10/2025 8:00 PM, Paul E. McKenney wrote:
> On Tue, Jul 08, 2025 at 10:22:21AM -0400, Joel Fernandes wrote:
>> The check for irqs_were_disabled is redundant in
>> rcu_unlock_needs_exp_handling() as the caller already checks for this.
>> This includes the boost case as well. Just remove the redundant check.
> 
> But in the very last "if" statement in the context of the last hunk of
> this patch, isn't it instead checking for !irqs_were_disabled?
> 
> Or is there something that I am missing that makes this work out OK?

You are right, after going over all the cases I introduced a behavioral change.

Say, irqs_were_disabled was false. And say we are RCU-boosted. needs_exp might
return true now, but previously it was returning false. Further say, we are not
in hardirq.

New code will raise softirq, old code would go to the ELSE and just set:
                set_tsk_need_resched(current);
set_preempt_need_resched();

But preempt_bh_were_disabled that's why we're here.

So we need to only set resched and not raise softirq, because the preempt enable
would reschedule.

Sorry I missed this, but unless this behavior is correct or needs further work,
lets drop this patch. Thanks and kudos on the catch!

 - Joel

> 
> 							Thanx, Paul
> 
>> This is a first win for the refactor of the needs_exp (formerly
>> expboost) condition into a new rcu_unlock_needs_exp_handling() function,
>> as the conditions became more easier to read.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  kernel/rcu/tree_plugin.h | 16 +++++++---------
>>  1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index e20c17163c13..7d03d81e45f6 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -659,14 +659,12 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>>   * @t: The task being checked
>>   * @rdp: The per-CPU RCU data
>>   * @rnp: The RCU node for this CPU
>> - * @irqs_were_disabled: Whether interrupts were disabled before rcu_read_unlock()
>>   *
>>   * Returns true if expedited processing of the rcu_read_unlock() is needed.
>>   */
>>  static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
>>  				      struct rcu_data *rdp,
>> -				      struct rcu_node *rnp,
>> -				      bool irqs_were_disabled)
>> +				      struct rcu_node *rnp)
>>  {
>>  	/*
>>  	 * Check if this task is blocking an expedited grace period. If the
>> @@ -702,14 +700,14 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
>>  
>>  	/*
>>  	 * RCU priority boosting case: If a task is subject to RCU priority
>> -	 * boosting and exits an RCU read-side critical section with interrupts
>> -	 * disabled, we need expedited handling to ensure timely deboosting.
>> -	 * Without this, a low-priority task could incorrectly run at high
>> -	 * real-time priority for an extended period degrading real-time
>> +	 * boosting and exits an RCU read-side critical section, we need
>> +	 * expedited handling to ensure timely deboosting. Without this,
>> +	 * a low-priority task could incorrectly run at high real-time
>> +	 * priority for an extended period degrading real-time
>>  	 * responsiveness. This applies to all CONFIG_RCU_BOOST=y kernels,
>>  	 * not just to PREEMPT_RT.
>>  	 */
>> -	if (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled && t->rcu_blocked_node)
>> +	if (IS_ENABLED(CONFIG_RCU_BOOST) && t->rcu_blocked_node)
>>  		return true;
>>  
>>  	return false;
>> @@ -738,7 +736,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>>  		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>>  		struct rcu_node *rnp = rdp->mynode;
>>  
>> -		needs_exp = rcu_unlock_needs_exp_handling(t, rdp, rnp, irqs_were_disabled);
>> +		needs_exp = rcu_unlock_needs_exp_handling(t, rdp, rnp);
>>  	
>>  		// Need to defer quiescent state until everything is enabled.
>>  		if (use_softirq && (in_hardirq() || (needs_exp && !irqs_were_disabled))) {
>> -- 
>> 2.34.1
>>

