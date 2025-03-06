Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4265224FA
	for <rcu@vger.kernel.org>; Thu,  6 Mar 2025 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741224313; cv=fail; b=JRgyzZ71EdHpGiWMllIqoCO5YH5pMWPNudCyTdyQWJvc8EVlzYgB9dybFS/nTcSiuJi/edIEb1XpQwQ4A4wHpe1vgC5nftYUVsNikEmx/QiVuiKlTjMi9UR+yYL0pvO5q4ghj0eiArv6F8xlvOwy94akfpb5myZb2bFnzZNvizE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741224313; c=relaxed/simple;
	bh=iNqzw6I9ZrnXAi4yX5JvPhJBob1kaXOBR4FaYwg0HlY=;
	h=Message-ID:Date:Subject:References:To:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z3XTlJv1ZaJATy7yjYxAPcz6Wxa21tKP/gjJLCSnUCpvyOZ8PG8zIAb+6tJUG0bjDt9+tJ7yHwxz4zldXvsr/4p593s5LNWx5ssgrMFn+y9uCtzjTdASVqj2aShhnE2W5ljK4512iBrCGnm8SpNy9hPBvtLHJuWk6zPOqk/xBQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VXskGOCR; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VXskGOCR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUrRQL+OoGU2O+Tcb7efzBpn3IZBOGAxjqStmaFylHxfTsjfuD/+b5v2hu6s0xB50ktVTvYi+DnTWGeoZCw+4guZEjBO5GdCmFHCSlO/4xC8oS0jOFOBdcQUtQcUuF8ro303IxLBjIkqU6z4tDNmt1bOOnkga+aAgp4mnIfXvdRc2DreB6I8lkr3WkY/s8IcTNMGblMRdYHkwRdtBxdQpB5Qvrl2t+pQn77VpwbpJpxqk/AwaQnvCJuMr7AzGSooLTCLf36x1jKiEIde2NBtFIKFp7ppP/7Q0T0c95m8D3ep7ns8G6AU9Q1c+Zwxw83Homsu1PXtwiHcw0E50wwDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF+NpD+lrAX1gMhWfMUXV9bGUplyuiD/LBApKtNJ4K0=;
 b=PP8+CKHoIZV3dUXy202a0ZEDmWnPcJfJNeO+t5ZYeN5PTUYaswgHtyx3Qnqi9pakbCADEgKPOy/KCKQTXo9VjQrn8VPkWkuY1V9lWbmek6+5aKt2o/M1wgo5ZLi52ysqobpCF5m1bS8qioPCzgQec95VxDm7dUjhJCxrI4YW1QHtl/W2bvhI+xE896Py7peqXjLkbGyczX9gbqiDnf2eI75aqdFrPrqNayUnbgB7A4FUxE2/G7Bc0xS2O+kW71PLFw/IWQGQpTX+BGtmEULEqvdOfd3DGGuLmjV3zVfnlVvquILtEGfzBZ5h4PTUkjyqjvommR/bhHXo7hBL3mY3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF+NpD+lrAX1gMhWfMUXV9bGUplyuiD/LBApKtNJ4K0=;
 b=VXskGOCRHM855lUyYIp2s4mauhd3SuZuj7nMU3xV5zBIAYNe0JAc8aEn+mvvT583LvIFdOLehL1ynNMv04XvHiRh3U7/xn+z7tnYxBHA71UKwCkFMhz3KRXY0SmWw3sFHG2SRvb39RYRy37eFK3ocU0vWY/UaON59BKhSn1RShO8GNfe6a5z56R+EoAyEotu38oxWFPrpeK1hSA89MpH7U42GmrSnvnyKfB7sBZIS38MMvr+0w36KitLfJGsZtwy7VfnuM9PW9uDIT/cx8amuXpiPbufkdpyc01iTMq1sVQiKH6kCjV+0RVaiUmNtfXK5XWZeviLzw7ThW+7Bv7vZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.30; Thu, 6 Mar
 2025 01:25:08 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 01:25:08 +0000
Message-ID: <078dd26a-9118-48f7-b9f9-c5476b168f6a@nvidia.com>
Date: Wed, 5 Mar 2025 20:25:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Fwd: [PATCH v2] sched/fair: Disable DL server on
 rcu_torture_disable_rt_throttle()
References: <20250306011014.2926917-1-joelagnelf@nvidia.com>
Content-Language: en-US
To: rcu <rcu@vger.kernel.org>
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250306011014.2926917-1-joelagnelf@nvidia.com>
X-Forwarded-Message-Id: <20250306011014.2926917-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0285.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5e4f8b-2c54-4bc5-b32d-08dd5c4dbb3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2FESnQwSHZ5QXB6b2NBR1lsWWhxL00xK1FiQXlOa0VyWmRaRVJYNFpoOUpB?=
 =?utf-8?B?NTRYdWtoTm5VMW9Mc2YxQjhJdVRsWUt5S295WEQ4YXRDelZNeGN0NE10ckRn?=
 =?utf-8?B?MkZVYk9JencvZkIvVkd4b3J2YTBEa2pxR0dSV0ZKZjRxTnNFTUlnUWZLd2M0?=
 =?utf-8?B?bDdZaWRUeHNQTS9OdFZvMVQxaE9Nc1ZQbElNL09HOCtPOWFsMXVsS01ILzBK?=
 =?utf-8?B?U3VuUCsyL0F3b1g0aExYckRxZU5CUEZXQ1V2WXhSSkhRU2pDOC9qWXFIcTBS?=
 =?utf-8?B?WmRmeVdURWFIMk93UWRGUEdqSysxelJtSHpaa3gyQTVvbEJ4NlYzRDdCK2tq?=
 =?utf-8?B?bGgyV0ttVWk3Z3lXQUd5SWhBZlByS3R1MGd5cUdGUnhuTXkrU0NSNmdReG5W?=
 =?utf-8?B?cTBtWTYzTWQ3K2M5ODdDTnpWSSt2VjBoYm1IbnIvRlRCL1A3R0VWTXRZaTVy?=
 =?utf-8?B?YmhJSGZhVllVRjArYXhsLzdyUVB6WFlmN2xsbzZJRHdQU09NUjd3c0NkaDIy?=
 =?utf-8?B?MVZFQzEvUnliNnp5dTZFcytNblZhSmZHeTRUOTRVaXM0QUtoM202SHI0ZUNM?=
 =?utf-8?B?ZHQ5ekZjZGs4dzRZTTYxcGRGbnBhblRTRVdaTWhJbHBqbkVHdkZkdk1ickhH?=
 =?utf-8?B?YVh2Z1hlNjhnWGs1alNuNWppSmlxSlBwbGVzbUZPNVRVTmtjL1BlRDhjNHBl?=
 =?utf-8?B?K1RaRXFDQlpxc3IyblRsaGhmSGJubnNTTjcyZWQvMk1JejJxcE56Q0dIUzda?=
 =?utf-8?B?OXprVlVxdVlaN1BMeExmN1VrQmRtVEVTNGtaZmVCV0tZdGRpTnN6THNNR3B5?=
 =?utf-8?B?c3dBWlRFVDI1YzNJTjVKcjBKS0JVSGhzcjhEN0lSM0tXSVEvVjhRVDFzS0JW?=
 =?utf-8?B?Y2phandLQUUrc0xUc0ZOdXU4azhPalpqQ0FhYVJTRHZzdFJCUVVhcnFMV1dI?=
 =?utf-8?B?RTd4bDZEM2FUckd4V0prRzZxSWlyM0NJNVY4QkxGM0lYaHdrZHJTeEI1UFNR?=
 =?utf-8?B?eUJSR3owVlRwVWIyOW16aDNWdDkvVk1NdnUweTB5eEJjUHNtSmFPSDZkcjZh?=
 =?utf-8?B?RHV5SkNVTUdqT3JuMUgydkJFNjVvNnYrdWtJVmVlQWYxdVpnTTJDUHFhOFo3?=
 =?utf-8?B?SERBT3M0NGxNam5jYlZSK0NWZU1XUkxYaGRzM2dIK0w1czYzVGhhYzRvRkN1?=
 =?utf-8?B?bDdOMGpPM09tR015YmZNTWpqREwwQTlCOTkrN3hWWkRpQkNmL3NvMm9VTDVp?=
 =?utf-8?B?QU1IVE5vTDk0TEhyVENxSUxrN05tYnNGZ0ZLQXBGdGdXWVFZU3NTdzFVSndu?=
 =?utf-8?B?bVEwdmw2Ynhkemh6QUVkK1hhQlcyM2xkb0t5Y1NHMWRvUWJ5SDNSeWtOaG5D?=
 =?utf-8?B?eVdGb1hmdUpzOUh0aUFkV0ZhanZYaytpWmZRTlM0REcyWERjY092TFRPdGw0?=
 =?utf-8?B?Ky85Vlhoc3Z5aEJVajlSOVNSMENuQzhPc2phZm9uWTdwRDlYbXBVWUJoc3Bl?=
 =?utf-8?B?OFZ3SzQzS05DSGNVc1dHQUVSWDRpZlgvSGswbjVsa0dBUDZ0Ky9YTXp4WDRi?=
 =?utf-8?B?MnVITnpiSXM2RXVReDcwTmpha0pKN0M1cFlkeVJvaTZFeThEUkZZdllWMHE1?=
 =?utf-8?B?TDFxM2lhNkdnQUZPM1VMaWx6cStTVFhIS29sTFZ3MmY5Z0NwVW1wbnpQallJ?=
 =?utf-8?B?U0JBcHVjZzdvWEQrcGt4VjE0N1FCbXNRVmkxWHlRdnR6TzduZG1SczJSL3dO?=
 =?utf-8?B?cDFRcW5nNmxybnkxakVyYnVXbjVmbTZzVER6V05pQkJrdDJ3b28vUlNrZURG?=
 =?utf-8?B?VkJ1UUtnWkk5MVpZNkJqM1lsV1dSS1lUSVFqWFMrMWplYy9hNXd4NTlpa1R3?=
 =?utf-8?Q?WbVCX14WWFqgB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anIrV3htYVA1c3NYa0w3MDN4b2FKM3JoQWY0WXVqQlkxbHY1RlZVZjdPS3Fj?=
 =?utf-8?B?eHkrUE5mSElRY1NPUGZSaG9oNGF0U0h3WFRXZnkxNzNRZjV4SjM2WVpyUVl2?=
 =?utf-8?B?Z0EyUkhmYUVIK2VzcFAyTkF3WGt1RGY1ZVdBRnc0TUJTZGRyaG9aZDJvT0lC?=
 =?utf-8?B?NU1CRmVLTFl0clgzbTdKRjhHZUNNU0RnWXgxbmhGV2tsSXFwWHZKUXRJdHZP?=
 =?utf-8?B?YlY0bWI3NVNpOTRVZVlqMnlEcHlINUJtRkxQSDFHaWI5S0VTclpHRjlZa1lZ?=
 =?utf-8?B?Z1UvYkt5R1BUbTQ3TG1QVDhQQkhHaHZXSm9YenRIRmhla01VMnJVTjFFZzBL?=
 =?utf-8?B?cG5zeE41Y2RSSFh4Z2VKeExnTG1rK256N0hxNk5wRFJTS2xVek1YY241aHBy?=
 =?utf-8?B?bWgrMVkwKzdBK1N0OW1JeTUwQkw4OTY5Y1hCM2JQcURZN3dMbWpLbVc4WkZZ?=
 =?utf-8?B?V3VaTG1VbXEvNGI1TmIyclZBNWdrQ1BITTJlMnpjQ2tpVlBsTHZBUC91dkxs?=
 =?utf-8?B?UU51TUdXajdrSlJKYTU4Si9ZenozUU8rQkJ6bGVqK3RJUW1uS0dTZm1wLzRN?=
 =?utf-8?B?bmd1RTdkdVVvVTZYSEpwelNKZzFZSFNDRUZ1N1lObk5KUitHMDFYVmtwNm5T?=
 =?utf-8?B?cFdjM01paGFtVVh1TGxmNXhIMGQ0SGRZVEpHK1RtTklGWDRyMURhcUxRMmxG?=
 =?utf-8?B?L2M5N3RpaUFPY0JuYWZDM2ladm96cVMvZGFhK3NVRk85SWFvSkQ3UDJicTBK?=
 =?utf-8?B?NkNMRktrMXNZLzZIWFFFVnU1b3k5RndXeFZVamcwWFRHcGxWZ2RoUkhZcVNX?=
 =?utf-8?B?czNxN2hxSkdMaXVPd3k3Z1QvMUFteTJ6ejduYU00YWtLQ1pqQlczNW5WcXBs?=
 =?utf-8?B?YnNZVVo5V2pjKy9pU3B4TXFDdnpuUUhydXFrdThrNVdqLytJcWFkSzFEdEtx?=
 =?utf-8?B?dG14WVdpNDRIYWVRUGVmMk85dVYxL1pCcG1ZOG1KNVRBblFqWTBzbVJXc0Ux?=
 =?utf-8?B?aUVJejlKUmd3b25FZzBzaEVHbkJrbG5Gemtab0s4ZENzTUpNTE0wbXllL0h1?=
 =?utf-8?B?Nk5PMVE5ZkQvSC9zSVhmdjlCS3lSb2d3NlVhN2MvL3U1VWRNSlR1K09OMWpJ?=
 =?utf-8?B?dXIrYyt5Tmk3ZFVTTFdWcFRpTnJPYzFLMGJFMnR4U0FZT1pBZ3dicFZwVVpU?=
 =?utf-8?B?NE9KbHVOcVRiNStwOWV2eDRPMGFQS251SVBaSmtWaDhlU05rY0NYUTcyZklN?=
 =?utf-8?B?aUFESW4xbkNjYW9QYXhRc2VEWWFDV3psT1dOSlIxNWpta20wSytNUXpRMHpu?=
 =?utf-8?B?ZlNjMjB5WVNudU52V1FvNXFzWjlrSTRkeVVndExnSGw4RVg2NFc3cVA4WEJy?=
 =?utf-8?B?L0RDTHJSRnRuSEhBZlFlMnpjMEM4Q0hzOWQ2OURac2YyNUtLd2NBczVJZDFl?=
 =?utf-8?B?Y29wUEgvYlh1eGM5ZTkxcnB3Y2dFRjBBZFBZdHM1Mk1GOEVoRnFXNjUyRG41?=
 =?utf-8?B?WE5NK2JjVDBmSWZ0L3llajZZc3E2VzlZNU1Ebkt5MTY3TlR3U1FCNGpSV0VD?=
 =?utf-8?B?VUtHMTh3cVJISHl3Mm9yQjdBaXY5ZkptVWVxaGV1b0hUS2F3dDZSdklDRTVq?=
 =?utf-8?B?K0wzMGhHQ2FCRGRSNFVvL0RwenI5aVYwNDNyZjFxK0xMOU9sMTZnM3BmZHF3?=
 =?utf-8?B?emRxQkRJblgzSHR6aGkyaWZUS1pQWkNMUFpjbUg0UkdqY3BqK0hZZDZ6c2FF?=
 =?utf-8?B?eUk3WUQ4N2YxRURhMlVYT3NieGRMR044Yi9BNi82WlNzZmhmb3BibGxrdld1?=
 =?utf-8?B?dDNOcmJpOWxpQ3RCQ0d2ZTMxUkFEaDFkUGFxNmdpT0Znb2diUHBOUHgrN1JB?=
 =?utf-8?B?aUI5MFdRNzdtTVhwZ3pEUkxZTGh4dmVUdHVWUkp0MTJ4QVlCaE8zMG5DOFdC?=
 =?utf-8?B?blovaHJYeFVaU0dJc25qdXVkV281V3FDNDI2YVJZWWFwZ0tlZGprVlY1VFZD?=
 =?utf-8?B?MGtBWWlHVHdUbHh2RU8ydFlzL3huODk2YjZGOWl6emdLUllyc2NOaWlpT3Q4?=
 =?utf-8?B?S0NobTcvZ0Q2L0MwL2x4RDg0bG4xa1NLRTRVdG9Vd2cvR1RlZ3hPdW15dmg3?=
 =?utf-8?B?WWJVRWVXMWxpbHdhbFpBQzF1d0RIYVRLK05qUFdZUFV5c3hMTXM2bjdxa1Fo?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5e4f8b-2c54-4bc5-b32d-08dd5c4dbb3e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 01:25:08.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXHjYw+2uExiCM/yJd5vglKTFsbsKKTAmFZkIA7zcAgxSA2FCnzzm1lLEjROQ8+mUfnViWnBWmDZM3AJ/HcPhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368

Oops, forgot to CC rcu@.


-------- Forwarded Message --------
Subject: [PATCH v2] sched/fair: Disable DL server on
rcu_torture_disable_rt_throttle()
Date: Wed, 5 Mar 2025 20:10:13 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
CC: Joel Fernandes <joelagnelf@nvidia.com>, stable@vger.kernel.org, Paul E .
McKenney <paulmck@kernel.org>, linux-kernel@vger.kernel.org

Currently, RCU boost testing in rcutorture is broken because it relies on
having RT throttling disabled. This means the test will always pass (or
rarely fail). This occurs because recently, RT throttling was replaced
by DL server which boosts CFS tasks even when rcutorture tried to
disable throttling (see rcu_torture_disable_rt_throttle()). However, the
systctl_sched_rt_runtime variable is not considered thus still allowing
RT tasks to be preempted by CFS tasks.

Therefore this patch prevents DL server from starting when RCU torture
sets the sysctl_sched_rt_runtime to -1.

With this patch, boosting in TREE09 fails reliably if RCU_BOOST=n.

Steven also mentioned that this could fix RT usecases where users do not
want DL server to be interfering.

Cc: stable@vger.kernel.org
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: cea5a3472ac4 ("sched/fair: Cleanup fair_server")
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
v1->v2:
	Updated Fixes tag (Steven)
	Moved the stoppage of DL server to fair (Juri)

 kernel/sched/fair.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef435a7aa..d7ba333393f2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1242,7 +1242,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		 *    against fair_server such that it can account for this time
 		 *    and possibly avoid running this period.
 		 */
-		if (dl_server_active(&rq->fair_server))
+		if (dl_server_active(&rq->fair_server) && rt_bandwidth_enabled())
 			dl_server_update(&rq->fair_server, delta_exec);
 	}
 @@ -5957,7 +5957,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	sub_nr_running(rq, queued_delta);
  	/* Stop the fair server if throttling resulted in no runnable tasks */
-	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued && dl_server_active(&rq->fair_server))
 		dl_server_stop(&rq->fair_server);
 done:
 	/*
@@ -6056,7 +6056,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	}
  	/* Start the fair server if un-throttling resulted in new runnable tasks */
-	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
+	if (!rq_h_nr_queued && rq->cfs.h_nr_queued && rt_bandwidth_enabled())
 		dl_server_start(&rq->fair_server);
  	/* At this point se is NULL and we are at root level*/
@@ -7005,9 +7005,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p,
int flags)
  	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
 		/* Account for idle runtime */
-		if (!rq->nr_running)
+		if (!rq->nr_running && rt_bandwidth_enabled())
 			dl_server_update_idle_time(rq, rq->curr);
-		dl_server_start(&rq->fair_server);
+
+		if (rt_bandwidth_enabled())
+			dl_server_start(&rq->fair_server);
 	}
  	/* At this point se is NULL and we are at root level*/
@@ -7134,7 +7136,7 @@ static int dequeue_entities(struct rq *rq, struct
sched_entity *se, int flags)
  	sub_nr_running(rq, h_nr_queued);
 -	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued && dl_server_active(&rq->fair_server))
 		dl_server_stop(&rq->fair_server);
  	/* balance early to pull high priority tasks */
-- 
2.43.0

