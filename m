Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836BF41C79;
	Tue, 12 Nov 2024 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731385950; cv=fail; b=I3+6ilUiUgyEfGNdaQxZz0HO/6QoOL47T8ABWeFSdu2d2zCxZntoUkvdmbuW2vVcCVPT9DOMGjp3CBOtp3GGh+xiPsf4tZ4owORT/iDQyw9Zdeh9DSU2dCE84mpNFvZ6FlcIAtFLhqOH/5yqkC7Y3BfmFn7xf5i0Bu6pcI25VT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731385950; c=relaxed/simple;
	bh=nPtXcWvmK+srQjorTB7eY3L3gyWP29s6HzPbuVHU66o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AYF2nbh8m9djh7rZoGF/WnBrtCctGgAn/CEvtGfV/mVt5tFkTB1GDYlUSA3+iebdFTvbTX/jEvMbxMeMz/7e2wedzXeMsliVvjM2RS6QNynoEWCcS+sAzac50JuwWkBbOcvD51IEA1BZfd9TX4qT8FEzUT8wIbxDNtuPJyn0axA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uCi4yRS4; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uCi4yRS4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSKlUYblkdcKOZCviJe2yN6gzKNL69P3qOLN1vPhINhHHIAfexjP+z6DimznyQdPk0G0EDQ5qzVE8Rv1Xm56pXM6co4m8cwVXQzw3uT2hEs1vm3x+Lq7os/Lslgt3G4heMpdF5Qp91rIr/KqLSpdTpKGWp67Alnlem9vw+diIZ2YBzZDaX7T/HqtsDmJnMPEu1bS7jaRJebC3M8g7ZeOQzUlApgrpnSqLz90V0hD4+nJI2n5wUWSh9CbWgJVkcY/PXj3RfyyX9w79xlyNy6g+gA6II0fnF119KS7jupHjr6L9YWLNLLqmdGuR2HWBpHCyPrsGH16j98zKw8GiFuGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmKZRDdjbUkP/tGh/C3AMVebgeff9JK63pbqfN9K2yg=;
 b=VCWlGls42t6PfsAEY/AoiRv816rPg9m0KmSwAFm0Os3WrTBmASKjqDz5g7OQmFDs/LZh3W/KLEo/AjKn5nnZnbuPg1GvbrlXKs7D5ZulEgesWVm+wxQqzTt86aPZnjDt9CHv0p2zrsP1bzzQTa5WqWDVnI/Kn46t/gQN63OR1jJLyWm4xqgJIDTqsTuaEzvwoJISUikolwfR1e1FsLK8huY4HOLDC4a63VJ3+BgrS2pTD91kY79EwiL/mUWJe/hdfHbZC5fDfJUvPPE3rkrDkY88bw+fyCzQuMjQQrIA55ONxwJlAL7Psb01TCmmHAQR09evYU475hGeOtWUJ09Y8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmKZRDdjbUkP/tGh/C3AMVebgeff9JK63pbqfN9K2yg=;
 b=uCi4yRS4IWCr62rLmjI0BJeSgO4f1cKfJPq0mwyCW9bsiSMawNYUinQUmepNFVupyPXtu6HKUJwmKP2Ff6ZIL90BfP97oUHX7es3kHnFp8Nt16pMcDeLLs+TOF8uvjJ0yDGqsq/Mc8+VEbqKquwGDgSfem9eoJRJmEbdrx/uXEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.28; Tue, 12 Nov 2024 04:32:22 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 04:32:22 +0000
Message-ID: <b75d1fcd-6fcd-4619-bb5c-507fa599ee28@amd.com>
Date: Tue, 12 Nov 2024 10:02:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 3/3] srcu: Unconditionally record
 srcu_read_lock_lite() in ->srcu_reader_flavor
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 frederic@kernel.org
References: <bb96e032-4f7d-41bf-a675-81350dca8d0a@paulmck-laptop>
 <20241112013143.1926484-3-paulmck@kernel.org>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241112013143.1926484-3-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c049e5-e1ad-4d3c-ccd9-08dd02d3001b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGdjcnlobldGS0hpQkUzMlBPQ3FMbVd2ZjhPajlWbTh0VVZGTzhnWHY1MmlT?=
 =?utf-8?B?aTBNdTFWck1yR1pPNVh5MVk0aGlFdWxoUEZvWE05UjFFMkljS2Q3SGdQbGZv?=
 =?utf-8?B?RGpnRXpzaGh6Y1ZMRjNncFVYK1FiWWRGY0U4WjRhQ00rcTl4NVRRS3FqRXpq?=
 =?utf-8?B?SXBGdmlkT1lWYzVrVnc3TFY0eW9QOGlROGRtelF6ZXY4UU80QWloTFY2dVI2?=
 =?utf-8?B?RjR6WkI3c2lBRzd1Nk9IdGR6eW9iMGZEOWxGdHI1cmF4Y2hqVzJ0VkppMGsz?=
 =?utf-8?B?bDV0czF4elN2Q2pQK1pQM3g5L0F0QmhxRURvSXlIWkFubkdCWXVYQXdzSlVF?=
 =?utf-8?B?QmN6UU1Gams2U3R2ZTJSenRUc1d5c3BMdEVlSytKSjlpM21CZmZUU3VZQWhh?=
 =?utf-8?B?VHhsaDZRZThrcnhqMVZjV0pDTFlJK2ZGKy9uT2ZyZFh4UkkvRm4xb2xZajVM?=
 =?utf-8?B?YlZPQjFuL3JaUEtBa1FGR0M1SmVRMlpmdnZGc1gxSWEzcUNRbXBwVFdFRi9i?=
 =?utf-8?B?bWN0NVYzZEE0Uk5RQ24xZk8vaTVhWG85UlZQdWIvRi9wL2xqdk94THY5NEFh?=
 =?utf-8?B?NWQrSTJJdFlWWFY1aVZyWVI0eXNSd0tSMkp4b0g1SWEwSWZrektWaUNoNmhk?=
 =?utf-8?B?M1RzeEJZVFVVVll2RTRpNWo4Zm9kdFdpUUFldVppZHU3OTFVZ0hHRk1qQzdI?=
 =?utf-8?B?dXYyeGx0eW82TGdjQUNGQ20zdGg2TngrSDZSdUdmRGNYanhmcEZRMVA1M0R1?=
 =?utf-8?B?eEhQTTVqeVQrZTZyY1BCb0pYOHZTTnE4bVQ0c3VqRU5BenVnbHlYWFJZcjVO?=
 =?utf-8?B?OVNqNnRMTTBIZXpiVGVVTzk1SldGd3Q2UDQwKzAwWmI1Yk1EWlA3MXhQSWNG?=
 =?utf-8?B?TDVUSlhFQ05iTklCazBZQmNxMWtVSkc3RVdvd0IwWEQwa3ZZbGtNZlN6Y2c5?=
 =?utf-8?B?N1AxWURrRnFOQTJuTTUwV0dnN1ZlYi9sTjk0U0xiRWxLZGliWmNhRklkbGVV?=
 =?utf-8?B?N0lMenFYM2U0bExqV0xYeFF4OXNHOTBNU1QxNmlTaXFxMXpDN3VHLzZlZENM?=
 =?utf-8?B?R1ZNN3F2eE45M1pHbE9iZjRuenBIMHYvQVFpVHdJalNxN3kvM1lvZHljVEdo?=
 =?utf-8?B?NTBqQkU4RmJYWC9UZ04zL3JNZzZHM3ZzMFBjN1RWUlZxdzVmeUR2a0dQWDVx?=
 =?utf-8?B?aldRRlFycGM0eDFRcGNodU9FTWV3SUpMWTlub0o5MWl0azFOVlU1VWFjWDBk?=
 =?utf-8?B?NklFUHVralQ5d2I2Z2M0NTV2cXMrMWFqd3NjQkxXRVdJTmdkWnJOR0FXNktE?=
 =?utf-8?B?SjZvd0puM3F5bWNQbGd2Y1J0cHBwYkVpNStTVXo0ZnZ2dVYyNnpsWjBxclY1?=
 =?utf-8?B?alp0dHdLbXdXbUU3YmEyTGdKRE9KaVFqTzZGYll1R2V1c3REQmt3ejRnR2ZZ?=
 =?utf-8?B?TlY5ZmsyUjFRL002ODZvZ2ErR1I1WTA3NEc3cDZUWXh0UXhDc1R5K29UZ0Na?=
 =?utf-8?B?UFM2ZWJhenZTbDZ2UVZQY2dWbVF5WnJQWm1iR2tVTCtlRDh2U1dKTS9MN1Rm?=
 =?utf-8?B?YUx3UFdWMkxHSU1YeDNWUjZoZnE5VWh4cjN1b3A5ZGJFR1pteml5T3Q0SHQv?=
 =?utf-8?B?MnVYQjcrRUROeGkxYVRPb2x4cHRVME5lc2R3cnRyYjd2K3pvMUZuWUpoUGU1?=
 =?utf-8?B?eFJ3Qm5YKzBPcXI4c1UwREJKbWJ3YWtrSm52bmpPb0JsdFZRU2x1Q1BHMG5X?=
 =?utf-8?Q?HY4y6bGssnt+WO9pmGDtJC7/0NTkmFHV+EkH+Lz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnBkSmRmZldqM2VreUVXczNGYmtubGV3YnQ3U1R2eWthelFSczU3L2tBTDI5?=
 =?utf-8?B?ZXpqdDZhNnJXTGx0cXlyR2pVU1ZwelgyR1BFKzQ3UjRXM1hhQS83UVNrQ21C?=
 =?utf-8?B?TVE5dFY2WGFxVlBhNkNEazd3b1c0MlAram1RVnJpUWdIcUlscGJWMDdDclNN?=
 =?utf-8?B?WE9qem45SElnY1czS0E1NytQOC9UQ25jMG1vRi9wZXg3bWRHdXEwbXJLcDdh?=
 =?utf-8?B?V0JtVUlnZHZVR3Z2RnZ5WHFEYmVlSDVoWE1aZUhEeDZPbnNwemFIemtqTkE5?=
 =?utf-8?B?Rk1Wc2liQ21Sc1A4TWtDOS9OWGJZWnVVTE1hejhNVVh4SVI4SS9VOUYxY2Y3?=
 =?utf-8?B?TkdOUVJHeDIxOExQY3ZOSWpobVZtSit1bVlwZ1NHdG5mWDNFVlZYTW9qeDk4?=
 =?utf-8?B?cXhFbWZ2QWNOL2Q3YmJvanUxZDQ2eVZSS2ZxdS9CUGs2QXlCdHdLMlNPaWtP?=
 =?utf-8?B?NitWMENLVEd3UG9JS2NGUFFvaDlOTCtvOWs1WTNmY0VVWkxGRlMyRUNQSGpT?=
 =?utf-8?B?UXhmaGZ5TytobmhSWkZiVG9DUVVWMEVSdTNsT3UvSEdCdnVvUjFrU3BBRGoy?=
 =?utf-8?B?KzBCamt2eDhicjBqdjZxNW1jS2ZJWWcxeU9LdWhiUm5xYThqTTJ0OGpKSHIw?=
 =?utf-8?B?TCt2SjQzeEp2VjVQb2hNejZrUFV4eFV5dnJ5UmxHYnNEemJwc0JZTUlBZFl1?=
 =?utf-8?B?LzNkUUFvVGZFcVJlY0Y2elNUVmU5UFcwRHRKYmpya0tFeE9odXZ5YlBMK00v?=
 =?utf-8?B?aVRBcXkzOFY5MFAwVnZPK1JkNWF3WFVwTUZvOGZaaUcyeDhFL2NLSVRHZTUv?=
 =?utf-8?B?aUtBbnZrNnU5YmI3amNjdU1JdWo5TTYrNkNyQkdndFoyZzlzemFpUENqR3FB?=
 =?utf-8?B?cEJHeWx1SHZ2RVpVVCs2eElhWjBxcXFEMEJVQ3k3YWQ1RFVHbmlqZXB3OU1x?=
 =?utf-8?B?NE5pSzZZcnM2cTZRY0JST1JVN083QkN5aE4zMDYvY3dOdjJqOEZXemFaR09O?=
 =?utf-8?B?WGpSYXpyNWFhcFpaMGhYODJkQTJWcTJ4ZmNsMGMvR3k0RFhmdXU5QjM0UlBs?=
 =?utf-8?B?SVJBYW5vcXB4WFRtaDhhNzYycHdyLzJYdWZLMzVCUHJmc09pWHdRcXU4cUdK?=
 =?utf-8?B?WkxQUVdmR01UTTczdk5Mem9NRy8vcGo0a1ZvYUMwQWNUK2ZScVB4bUczbS8z?=
 =?utf-8?B?K0lOdUdsL2pIcHRldWlRZ2J3NlRXL290MDVhQ2l4RTFNTDJpcDVkNTFiNCtj?=
 =?utf-8?B?VDUyOWtBdHdmU0VsNEdlOXphOUN0Z0g0ejJ6UmVoRjNMbjYwNTlTL0VzNlhH?=
 =?utf-8?B?ZWRGb1VMaGdYYVJOYUdscUZvZnUyY1d2QzV1OXlIM3owVzBmYndEK0QzQmRK?=
 =?utf-8?B?RkZCQ29CdzlQcGpxRG9lZlRhb2NVZnNoemxDT2JDUGozRXZta2lKQkRZL29N?=
 =?utf-8?B?L1plYytoSzV6VFRMVDM5NVZ1WHI4bGNRNWQySGZGSFFPeGNSdm84QTdnUGs4?=
 =?utf-8?B?SHZRaTBYNFA4NlBXS0tTZ09Fd21zeTJFaDJ3ZmNxcWRpRVc0Q2N4bFhKYWVB?=
 =?utf-8?B?T3l0S0hRZDRtbVBkc21OY2dIVE45N2ZHdTZqNFlldld0ZFlrTThSdWdWWlNJ?=
 =?utf-8?B?NFVFMWVaWEJ4bFBBdXNxVVNNeFpKTzc3MzQ4SmhyOUs0dDBSS0lpSXQ3bDlw?=
 =?utf-8?B?WmNoWDM4T1RZYjgvYkFXQ3Q2ZmUrRGhmSjRXc0paQlBKbEp6Z0tobjVYci9p?=
 =?utf-8?B?Uk5ocnBRM1N2ckkwU21hSW0yVjNwOHNCbEVneHd4SEVQaVpleXg5RzRoWU12?=
 =?utf-8?B?Q3lEMTNuamVMZzhPM2Eybk8vQUpQRnRCdTYrRlVzY3VZN1I1aFR6cFJmTlBF?=
 =?utf-8?B?NkVuTjBEc2lyMnlrOXc2ckFRSzE2QXhBbWJRQXF0Z3Q0aDNkeTBnNXd0b3Bk?=
 =?utf-8?B?dStMTzNoT2JVVUpSN3pXK3dZRTdwNkdHWlEvWm5aV2t0YTBrRElnbjFBNS9W?=
 =?utf-8?B?TG0xWEpiYmVTakxWNFpQalEwazkyd1hBM0FzRHhaeUxaMjBmQ09ZU1QrRTdD?=
 =?utf-8?B?bU80SVBOR3Noc09mekdSaHhpWWZvKzJtMTVmaUJQc0NuQ3h4cnlJb2hPbzhI?=
 =?utf-8?Q?W71AyDWMcQ0YT2mjb9JpKmF5o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c049e5-e1ad-4d3c-ccd9-08dd02d3001b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 04:32:22.2518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSx9h/d5aOa9PhBFDBh88Je9aP1qyw6XX3xCfjbpOcWp7Zn4tl5hMaNZiZgv+CxklDPIIbLAKqad/UDskoUAHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

...

> +void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
> +
> +// Record _lite() usage even for CONFIG_PROVE_RCU=n kernels.
> +static inline void srcu_check_read_flavor_lite(struct srcu_struct *ssp)
> +{
> +	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
> +
> +	if (likely(READ_ONCE(sdp->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE))
> +		return;
> +
> +	// Note that the cmpxchg() in srcu_check_read_flavor() is fully ordered.

Nit: s/srcu_check_read_flavor/__srcu_check_read_flavor/

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj

> +	__srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
> +}
> +

