Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2A260A3A;
	Wed, 19 Feb 2025 23:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008714; cv=fail; b=dPt5rGZyoRBF8ltc67mBZ3j3IbgpOru0lMbKEmOFcx5RN+k5P5imStq/yZ5vbfNDGQ7yY8fH8XHEFUuCu+YKvgN7lW2IP90saXMdiAs00e/wagQRstudaPgBmG1r0V048mb3q0K9bVBuaOyY6J/hwJ/GtRYEp40xeMqbTGbPMZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008714; c=relaxed/simple;
	bh=n56jNqyTd2MJd4mtweVI2wD1n1xlKF2YkUgzVsSYcUg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HBpkKmaVKGOZgd6DiIRWqmedCy03JEu1w1etW9OIKiE53OxOG86WCq1xGvD7vMJs+w+zHAoA6aH83iQ3x/o9PHSO8x3+Wno/SxJZV+ejvShMdENnj1VMCSNn/YdzplKRhU5/pAsT0WHoxe7UfYiyifqv0ai0IWcECz5qjmrbtpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f3X/6iK5; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f3X/6iK5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIAUklXp3uFJgXktSFKeIWuyO7L5DobQTObAVdS9ooRgLciUC4PPComH0ATXlialHkXnYyMEehOba64Rukn6zWsDf6ry0VZPiW7PhyKS2UDKcf+4QJiuSP3JLMGajyIoEntRaDK4xVm6hArmM9+joSyEPZ4+/y49m4PPPKKXrudjv9oUL7skmTeTwB5lJ/oeUjsASxCAY3e21vsJmPJrHasqI3+DyoFjqNEj8T9Vcz/WwkAY75DHarBJNKgBe0W1DEHD9rY+9huGc8PBYSzcwcSrLzSaZZ3XmqshQqt0S8fhiTraWiPIeOc85t95qbddL8kAsmuv7CQ8Bc5KcDnNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAu0fSaY/tgCm90pbgoaJDURJcnZ5YEM7ixZuRewqvQ=;
 b=saLFETJH67gATDKc8JfM0wfBAHtYnaaPj6/IA9GMteezVqcApmUEGoVi4meDMQsiFN+WMAlAZ082jaNBSgwmVrWxRgaFZmy1YQAuft035iRhTxJu3qjVSl2+m7eblUZN+eIVAi4zuPE+3MwmChYXYre4Aac1+p2MNFXVDxbyaYG9UrpOSP24ck9EoXzBZP/g8cjFH9NeNGgAfFZyYPwjkOh0INKtF+N1ataoSpDj3ukH1EU63lCVLUO4J0Na6slbNfh9oF3EGtpbI2C0LurIlDkccMTVprkDpnoZh+vKNkI9pDxr4AJUMHYeBx+pbUkjLEBqo7iQg8NLR0T9oE9pdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAu0fSaY/tgCm90pbgoaJDURJcnZ5YEM7ixZuRewqvQ=;
 b=f3X/6iK57McWLolpnmuUo6KSLqU5EL2RS4YXXe0QmvuS6MOhlFxWNvG/qEqmA72qyxcfdaEGC2SBjlMFAZa4WWIYDjFroeQmOjTy6RiPm47xwTrAM/tvJSXN0OMayYYL8Vd0wrtVRONans2xmZ2UdPpF8mP9KjQaTptiTbIP+Gal6bQZuczIvKje1dVERm7Y3JqHbve3Emf6HtnU9UoF49K+O0g+t1UpHA+gtROgp/YQFdKvBZjLblQy7pq00DhRS5yZV9LXpahnwKZ8e+KTHmsaF8jazVsQFc91+48n4yFJ9IJy4R4IDsUKxEpO1JBWLaD8mvdujGDDrV1Snwi7mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 23:45:09 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 23:45:09 +0000
Message-ID: <a7d1297d-afea-4253-9139-8c44e953fd43@nvidia.com>
Date: Wed, 19 Feb 2025 18:45:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -rcu] srcu: Use rcu_seq_done_exact() for polling API
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org,
 Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett
 <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, rcu@vger.kernel.org
References: <20250219124309.463702-1-joelagnelf@nvidia.com>
 <dde0f073-c3d9-44c9-bd85-cf0e8a0fd628@paulmck-laptop>
 <52320693-3247-454f-931f-d9e23592862a@nvidia.com>
 <dyzwqkaldmoi7qircj6plzp6wnghvkmrxjbaf4ejvv7xy6t4p2@ea7mpkosxju2>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <dyzwqkaldmoi7qircj6plzp6wnghvkmrxjbaf4ejvv7xy6t4p2@ea7mpkosxju2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF00013E05.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:4) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: bb896131-0e68-4635-5e0c-08dd513f7203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3RzNkw4Wlp2b3dLVXJtSWxCSjVDOTErTnl5cXhqWEFNWVJVNjZMelkyMzdh?=
 =?utf-8?B?SFdXTmJWRENOS1pBOFpydzBkemhSZVJsczRBenlZM3VBSjJ1NWhqWmRWcVNE?=
 =?utf-8?B?SXNOYVFsMWtmcFFzOVBDdGpoY2VtUDIyWVo3ZTkxUjJuVXJhTjhoRUd1eEhw?=
 =?utf-8?B?cDIyUlJRbGgyOHQ4QThJck50UUFTNDdyR2tCdkZmbXY2aXA4eU5xdkxjWlE1?=
 =?utf-8?B?UGtJWEoyY3orZnprdFR4Mk5YUWMvWHR1SU1NNmc2dS82NmpTSkRTalpJTExy?=
 =?utf-8?B?V2FYYUtta0FKTStsVzlHZk4rRGRkVDUwK2tPbk9pd0V0OVJ5cUZWQ0RIeGQ3?=
 =?utf-8?B?MTBlUWxUTUplTlh6UXd3NWUyVTkzWGJZQUhBS2lZU1VGeE42cDdVcWt1UGth?=
 =?utf-8?B?NERPaTJUOGYzRHlEMzhwZEo5OXRLNEc1V1FGTUtOT21ETUhDZ2t3a1EvTnBS?=
 =?utf-8?B?dkEzdnZpT25kdnhMaE9WTXJBR0RmeEc2WDFGTExvQnR6dUp2RTJUNUNCVGZE?=
 =?utf-8?B?RmZEb1Z6dE5CUTIrUmVRYkIybVZKRm5JR0FDYXBoSE9HOG1QTnF2VGJQZ2FG?=
 =?utf-8?B?ZVVhc0VYT3M5OEJBcUVUZnN6Z3pES3dvMEhscXdNT2x1M2pSWGNUZ1orSTh4?=
 =?utf-8?B?UGZsK1ppUXMyQyttWm1wSW13aUxJalNyMHJFcjN4TG9JWXlNcFZ4Y3BIMU9i?=
 =?utf-8?B?d2hzVm5pbmd5Sll4UmZYdjZIUVNkMXFQemRucng5UlQ1YXhzcThPNzFrNnIv?=
 =?utf-8?B?elFRTUpHcmlITDBNanA5R2JQd09YSXNjSU5CcEQvNWpWc2E4QWhleTVFbGM0?=
 =?utf-8?B?TXlGc21laHhwc1ZiTnpWMWJNcFQ3RTNXQVdBeVJIL29BcS8yQlFMdk1MQmwx?=
 =?utf-8?B?cVl6K2xIak8yRGx6OEp3WnBOVCttTEVXcU4zZythTG5aTEo0MklEUVFxY2ZY?=
 =?utf-8?B?YWl5Q1U1Zk9LaWExQ1FHYjhxTW9nV3p5L0h5UzdzdDlvRjlLL2x0Qm00STht?=
 =?utf-8?B?eU00WHdZS3pvc3E5MHdHMUtyN1hheE83alFFUXdRcFhOTFZIb1BKY0pHQXRh?=
 =?utf-8?B?UjFhWURabUd1VFhnS0crblVVaXdmdHB5NUpSbDY0SWpvR01zcHc1NzAzZjZO?=
 =?utf-8?B?Ly92M1hnWklFQ2tFUnF5VDIwM3o5RkF0MkZQYTVGaVlFTXF5UkdVU05JMXFB?=
 =?utf-8?B?bjAxb29MV0dKVlQ1KzhzNlZRWGlvbDNvTmtwczhRL0J1QzNVSnJpNXZZUzBz?=
 =?utf-8?B?eXVuV00vZXB0ajA4OFVQMnkwV0pBdjZlUDgrb0g0alZiQnFYN3lNRjJpL21K?=
 =?utf-8?B?NlVxNlE5RHlRb0JGSW9pV3BNVFRNZ2I0SkRReTRmelB1VklrMDFYc2pjR0E1?=
 =?utf-8?B?ODVKNzJBZG9vUUJWanFyUTNkcTZkUzhmWWwwM2xqS0FSUHhHMEpwVlpzcHFH?=
 =?utf-8?B?cGJQK1FsZHh2b3B1V0JuTVQ4Sk5rOG5mcVl2R2wvSVFrT0xtanNZRlAvWGJU?=
 =?utf-8?B?SkF1c2JNZnhMbCtMM2c2TjQvdkd4NWt1M0FvenljYlR6YW8vd1NWeTRDbXNC?=
 =?utf-8?B?cGZYcHhMZ1BRVmh3MXBvTlJjV2NoWU9kVmZ0T1RhQ3pJeEJmMXdscEFJdlBn?=
 =?utf-8?B?TVE3YVRHN3Uyd2F2N0ZCUE1XclZSMmFnNnNUbkQxOTk1akN3dElCTU1qZHA0?=
 =?utf-8?B?ckMwZEJwRjVOTUVjSm1Oblk5MWxKa3hZekxGOVpjQzBTL09YQTNrR280YlF2?=
 =?utf-8?B?VXVkMEZRa2Ntc1R6MkM4Vnk5NWwveVFHOVBWakEwcS8waW5uM2w4WHFGUkhR?=
 =?utf-8?B?TjNwWDZLcnBGbmVXVUJqUGNCOWwzVzcwN1h2VmJDRzhZakdMeFlLTXJIamNF?=
 =?utf-8?Q?ZKdALYxtjBrXV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHNLdUlwMGZoSW53QnR0cHJvRGF5Zk1xNWNrZGlKTk9kMTh3U3V2ZnBYNWxh?=
 =?utf-8?B?OUlpT09ybGhKYWlTazFzdVZURDhkdEpCdHFrMFRMaExnSzNDcXF3VkZaNnlO?=
 =?utf-8?B?MTIxNndJbGpuQlZlUzloOU85Nkl5L3hWY0prckdPaHRvaFVrTTU3MmdNVVhy?=
 =?utf-8?B?b0xJVEdyQmRMTHdBRlBMZHlXRHNGMDBOY2tFL3BtM0ZuVGc1WThJaG9keHpS?=
 =?utf-8?B?RFNPTXlKaFdiY3krN2wrK1JSdUVoQzlUNm5pc2c2M0JVbHBXaU04dzZiOWxs?=
 =?utf-8?B?WjUza1VCU0Z6dEdqY2VHdEs0ZUJDZ3hSUjRLVDZEMjI4UWJnWnRXUWlMK3pn?=
 =?utf-8?B?QlF5VkdJU29Ic05QRjk2V2g3K2hUV1pjUkU3a0lwZHltSGY0VTJNQzJNUlBx?=
 =?utf-8?B?TmhRMHZXaWdsV2c3SVZ1UERnUzc5QXRiY01GcE1Rck52c2JUS3JPRW1YaFlM?=
 =?utf-8?B?WEE2ajVkVGNVR1M2b0tUczJiMVdiakczYktQMlZISUMzd3FRUU9xeGk0OWli?=
 =?utf-8?B?VzR5RzYzd1dNTGw5TDBGeENBNzNKazhYSSsxWXNDd1BxdmVvbnVaUnpmdTlu?=
 =?utf-8?B?ZTlUMlNaZ0xsZFpvc25TaFR5TVoxVm1wSXlLU3JuKzlnZ0pwcGxrUTJGZjFV?=
 =?utf-8?B?LzVTK29aT3E1WUdjRHI3WXlFTGhPd1J1WUozaHhsQWdwVEp4MlM2TFNpVktM?=
 =?utf-8?B?WVNsMHc1L3BteitQNDFBZGtZSE1WM3k3c2VrWUN4QU44ZHduclBBNUxHZjh1?=
 =?utf-8?B?bGw2UTBndEx6ZFZFa3EwZUJBTDd0d0V0Y2hTaytvY1g1TThOYUZlUUphQ29x?=
 =?utf-8?B?VzJhZE42eVhLVFdhQ3FQYk9tSVp1Q0JzRzQwY2lDYW8vcEhHWitJWWdhWUxZ?=
 =?utf-8?B?WGE0aVdQeVRRU3NWZk95NUtPSGt1UEpaN01WMzBOMjZLNFBaMFNuSXR1a253?=
 =?utf-8?B?V01VaGNSTnd0aFRYUm14T29PKzJKam1Va2pDd3M2YkhMWTlsR2ZVazRWR1ha?=
 =?utf-8?B?ZTd5UHlnSEN5MFNZTVY0RXJWa2pGUEo3SWF2UlNTZDVRWHBja3RFN2FBVnpv?=
 =?utf-8?B?eVFSUHhMdVhmV05KVUUwNTFveWJ2SVdiZ05OMVRSU2oxRCtOMEIrVm9mRDI0?=
 =?utf-8?B?dUFUMzZkZEMxY21kSXdRQThGTmlkTWpJSzY4eVNRQ3g1bGl4M0hzZUxXSzdz?=
 =?utf-8?B?K2k0ajB1M1lySFF1eEtVZmFLOWg5OUNxOURPN0NkL2ZRcXRmQlRWQ3N1SkNP?=
 =?utf-8?B?WktOWDJZeVA2SitWbHNxS1g5M1ZLTWV5UGhqWVZVNys4RHpUc05jQ0d6ZmNj?=
 =?utf-8?B?UytyYU9lc1l3cExONEh5a25rc1VrbWlFblN1ZUpSYXhkRTVnRDRoUmtZWG9C?=
 =?utf-8?B?UnZENXFmTWdFN0pxRWxYWHc0NndHcjNJZXRYY3JQb1RIM1RteWhncnBqQ1Rh?=
 =?utf-8?B?aWltTk5aQ3JObitHRDgrbGovZ2xXOWhSL3diRG53OTNIT0s3WmpjQjBZQWZO?=
 =?utf-8?B?NVYyMEFjKytSdzl2Z3BucFAva2ROcW1SRUdOaFZ2bkVnTko0TXVUcVp1d2lB?=
 =?utf-8?B?UjJHR0NGTk5Md3h0Nk5BTmpuYkVjRFdhWVl0NmR0UmQ0Tk1STFNsZW53R0dx?=
 =?utf-8?B?SVJBWi9xT2xHUEk5M2xucis1bTlOc1BBRzVRUUQ0QnZ4c21oZXdaNEs2cHBF?=
 =?utf-8?B?TEE4Kzdka3FwdkRQSEdKRGFaMVIyVm9BTHErMmh2OCsxd1ppRXhZUFlTMjAr?=
 =?utf-8?B?NU45azN3c0RCditmZ05NQjJQdzVLWm5TWHhPbHN3WElmQ1NNeGpnYko3ek1j?=
 =?utf-8?B?a1owZjlwRHJvMDAvT2hRODVxOFgrY3kyQllrMGhUZzdTZFFlMko0Wm8xL294?=
 =?utf-8?B?QWZRWnVEaEFRVVFib2I2bXhRVHBCOTROYm5TNXloVjNVT0FYbThHRkZTTE1m?=
 =?utf-8?B?TTJtQU5ic0JzUzE3NkZQUkFpLzVqREZvYnJpOTQ4OTRtU3M3eWNRcjhHcFdr?=
 =?utf-8?B?REs5elc2OGl1dkxqaWJ1Z253aGNxSXRVbTBTNnFQb3VVVDNZeUtUL0FaaEM1?=
 =?utf-8?B?WHdVRWROZXNUVFdJSnFLUnVuL0JjRzV0MTR2RVlGNUJIWnp3alhzVGtuQUJI?=
 =?utf-8?B?WUJydFRkMitXUENGY2ROdDIxWXltTUluWGdiNEJ5TnFtUzFQRFFmbEovdW9W?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb896131-0e68-4635-5e0c-08dd513f7203
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:45:09.5604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdJUBWTb7bwQHU09auyxEMAMAaajs9Au/eRE0mqc2nJHCxDikrSNkNwUKGl9Cw8L7sIIkexdu7L8tx40agugyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287



On 2/19/2025 4:07 PM, Kent Overstreet wrote:
> On Wed, Feb 19, 2025 at 08:29:47AM -0500, Joel Fernandes wrote:
>>
>>
>> On 2/19/2025 8:22 AM, Paul E. McKenney wrote:
>>> On Wed, Feb 19, 2025 at 07:43:08AM -0500, Joel Fernandes wrote:
>>>> poll_state_synchronize_srcu() uses rcu_seq_done() unlike
>>>> poll_state_synchronize_rcu() which uses rcu_seq_done_exact().
>>>>
>>>> The  rcu_seq_done_exact() makes more sense for polling API, as with
>>>> this API, there is a higher chance that there is a significant delay
>>>> between the get_state..() and poll_state..() calls since a cookie
>>>> can be stored and reused at a later time. During such a delay, if
>>>> the gp_seq counter progresses more than ULONG_MAX/2 distance, then
>>>> poll_state..() may return false for a long time unwantedly.
>>>>
>>>> Fix by using the more accurate rcu_seq_done_exact() API which is
>>>> exactly what straight RCU's polling does.
>>>>
>>>> It may make sense, as future work, to add debug code here as well, where
>>>> we compare a physical timestamp between get_state..() and poll_state()
>>>> calls and yell if significant time has past but the grace period has
>>>> still not progressed.
>>>>
>>>> Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>>
>>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>>>
>>> But we should also run this by Kent Overstreet, given that bcachefs
>>> uses this.  Should be OK, given that bcachefs uses this API in the same
>>> way that it does poll_state_synchronize_rcu(), but still...
>>
>> Thanks Paul!  Adding Kent Overstreet to the email to raise any objections.
> 
> It sounds like rcu_done_exact() is indeed what we want - bcachefs uses
> this for determining when objects may be reclaimed (as is typical with
> rcu), so we don't want objects to be stranded a "significant time past
> the grace period".

Thanks for confirming. May I add your Reviewed-by tag as well?

> 
> Is there any additional cost? I'm not seeing rcu_done_exact() in Linus's
> tree yet. Minor additional overhead would be totally fine; we use this
> from fs/bcachefs/rcu_pending.c which doesn't call it for each object.

The additional overhead should be minimal. rcu_seq_done_exact() is the function.

thanks,

 -Joel

