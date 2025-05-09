Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA48296704;
	Fri,  9 May 2025 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796688; cv=fail; b=OTxRzZ16ISPuudqBp+jF+lppuTCbgD3Zv86kavUlb/xPuNMW2x9D4EibtPi8pYhX9dHvkb78oZPBkpS30Vfy6WGsICdymN2OLrBUy6Si54UTJqFA+fRDzpyZHeLaq86xZKbzVDWw8zbIPnt5UBYmN3u5JiVm3iNo771IY/eqUJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796688; c=relaxed/simple;
	bh=9Gg5pkzJLpfpxrSOZP/dC0exwM0kkIIKvwVu1vqed+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RZ97f+KfX3fuScNVnpHWJ6ZhXaK/hEp7I2ae1iGtZkAOpJ/56wQbELoMfZhwRM8Ie9zjWkD0AZxXptx83sQsRGj9Pdu+y99pO21x0iOU8fI3WQKdjPm0O4eqNWZ5jLhUc5jUa/ohhnET/QvClVO6l1+ogNo/sZlsuFHbxynd500=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hd/7KfTB; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hd/7KfTB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7hWm4kLbi6KaBjo2ZfFKY/eF7W6BQnXJqKeJJ8L3LA1rwlw9d3geoXlmFKXDN6vcx5zFGjss4CdKYqJTczjv8VKg5c5NyOxWE6yz5AzLnTmNloye3YAczDvrOkkp/tpqhgDpXrWSw+shvmdqfabTJonCNjEC4zEzD+Pnm1ZPBYfKc3ZYX89CQnErfZt/fwz7PrpZUgjEUnUbsaO3WUlWpuU8pWdr+KmnRaX0rPiUrlXL4ZNwn4/tTimWi7Xp3Y1KHR45cR2HqEMcott/Xds2Tvfe9Hkip0wlNxX2Bzfz0+Sxp3PaV90ACzK5Ts1Dh5SHdGKlsFioF0yhf0kv5WRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rru2ZGz8kCPlbwROgpy+KPJMV8Zo6VC4hCn8frdNfRE=;
 b=ZFz39DFOPz2O4QWvkvC6pf0SvHgINYjKU7yRnxUh6nuEbXFVCmvi0lebFFLEjp70l+fWy8nwaGZ9W/VwD4QKIW9Xn+B6NQPDA3roVPaghwiBXTU9TO27vh+9RylOB2HNTyo4Yx1Ag7R2g0DWJL8y5wlEUUT2F9qIi/Wdgme8EzoXFWAn6ScA+bCtrrZzrRppIufho3S56SIuuzaZpHFALGOVy/CK9h6VQcLr2cHH9/6NbZm3CWLRdK5SuZXVtBlU9hHbeAQ2ZRRJWVHRjPlbV3x2D71+cJgPhUJwBy6I4+DK17weMnbKbHrpq5kZvgo8TFSXSGIp+HucVNW49yI79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rru2ZGz8kCPlbwROgpy+KPJMV8Zo6VC4hCn8frdNfRE=;
 b=Hd/7KfTB1tESwSFfYD3WOhMVogqqHLP4TYKEIJXnd9Gd2hQwW0Xtl6lpcEhU3W1J2cW9UJSmDevL0KNNDCXCkeIL45kBW/B2HxGzP778zBDU0OhBtSCIVH4shJMeOqTcwovUOjYudCZRIdIROjgh3nExcYL24j/4uu3GkW206WN2LZAcLU4modXuubtwJ6ne6FYXkS35BXgS9QXRnuYpIMqw/m42JIn3wrvGMpMSwsIoQ8E/A2Auirhs7N4KcTkFQlFE2uYCts6W61mTKrJBa4/bZ6vleGPSRO7EO9pBsHRKmbdcQFsfodOkRujEuWYzlfmkGSkee1LCH5lCQRr6AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 13:18:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.035; Fri, 9 May 2025
 13:18:02 +0000
Message-ID: <0cabdd10-658e-4577-9b4e-5d4a2641360e@nvidia.com>
Date: Fri, 9 May 2025 09:18:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Make rcutorture safe(r) for arm64
To: paulmck@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
References: <da86a280-f402-499f-a4ba-df626ca4c748@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <da86a280-f402-499f-a4ba-df626ca4c748@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f44fbee-bd53-44ea-bcfb-08dd8efbed6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UittYnpVR1pzekp2ZTlYSlgyeDJiMENMc3BEbitGbTU3UG9DL2tpcmQ3ZTJH?=
 =?utf-8?B?M0QyQjFKT05pVnFDQ3EzMWlIMkxJbHpTMHgrY20zbzhTZmNVUEZRS3NjK3Ax?=
 =?utf-8?B?aHJQaU5BdFNPNTJLUXB5RHYwdGFPQm9oSGxFTlBRV1VGeXkyUUtjeWNkdXdD?=
 =?utf-8?B?S1JybGpTZVd2N0lScVUrVE5UVzd5SmtkNG9QbW1kTFJxNnhFWkFKVVAwV0pY?=
 =?utf-8?B?cStOaU5zN0dxZEJhSGdhMFJFOHFYZjJxWkN0eFJMZVNlZ2NHM1A0SkVZYTlI?=
 =?utf-8?B?Y2gwM3JFbVkyUFd6RFU0UEs0a2E0d3lRSW4ycDVvT1NFSnBXeWRHRjhyUFhH?=
 =?utf-8?B?d3cxR1dnLzhXd2xTWERGUTZobzR6Q2Qzc2lTUXo4WWxIRm9xQlJsL1lVK1Js?=
 =?utf-8?B?aXNiam1KYVBDM3hvZEE0bkEvL0k0MFNUVXc2cE9KaTlkeGRGekZWT3hoN2Nx?=
 =?utf-8?B?TlNrVWhxS2Nrc2ovanp5VFAyYSttQjhMdUtsUXZZdnRPRTZjSHo1VUV2VFZR?=
 =?utf-8?B?ZTFFSHVpV1h3azhwekVzVEFxZFEwdnMyS0FKQ1RlTURjUFBnWmhrdDJuZ1Bv?=
 =?utf-8?B?a3RSRmQ1a3Ftb0dqRkdyelNxeFFPbWFPZDhVNkp2NXdKbFQzOEpYV1pJSmtK?=
 =?utf-8?B?NHRyNXF3L29sSGlMSnRmRkw4d0xVR3A1N2lsNTNiYU5EZHpKcEVpdXNsZmNT?=
 =?utf-8?B?MFF2VVl5RHhmRU90aFFLdVB6a2VRTVFlNkgzT25UUWYvbzIwY1NYNUV6UFJh?=
 =?utf-8?B?Z2hNbWxiV1VycWFEcWhJT2FabE1XZThwbEo3Ry9YUENWbFRPOHdnMUFydE5s?=
 =?utf-8?B?djREc1ZsaU5XQlZpNS9YMVIwY2xEaGszRzM2RmtmbmZrMTh2eXdXWFpmSmFU?=
 =?utf-8?B?YUV2M0tFeHRVU2M0K2g1K3RFaEpzTDIzVWtyR1RCZjNRT2lsQi82NStPdnNU?=
 =?utf-8?B?dllxSFZ4dEhZUVltYThOYStoUXR1RmMyYnZVUUJ1SDJLSkVEVkRnVlVHQS9O?=
 =?utf-8?B?RU45eERrTmE4U01kTGQveVA4bnJHblQ0MFNnTFZJMXEwdWZUcU1senFWRGF3?=
 =?utf-8?B?d281OHVsRzhaZFBub3VhYi9OZ2NvamdMWmlPbnNNV213NnNjejQ3a2U4NUFm?=
 =?utf-8?B?TWNCSXhIdUx5dkxuMFBRY3lpS05vTzVYYzYrRmFTNm11THhFTVBqNkc0UEtJ?=
 =?utf-8?B?ekwxMTYxcnlsY1VFWC9kUW5MVFNhTFFmTXdYQUVjT1FBQit1TmVob083eGZV?=
 =?utf-8?B?RGRRUGxHNGNxVnM5U0ZtNmVxVlhSZEVpaWNlNWR4YjM0WGNtKyswUWF2ekJG?=
 =?utf-8?B?QUpQSnEvMDJkdE5JeFlwRGlqTkI1UnpTUHh1em9PcUhyaWZSbjZCRldDNllS?=
 =?utf-8?B?MXU3d3VEOVAzMFI5NGVpWXcweGIwZ0hZS0M1VmtwYlZjM1N0OFpnV0xPK00v?=
 =?utf-8?B?ZTNIWWxTMklqeTExdEtFejBMVDg3VlE5S21PRE15WlNhU3RERXRaS1ozanBC?=
 =?utf-8?B?NlFtdEpHSVV0L25PNmd5TkhtdlZjWkxXb0ZORkNLZXB2V2RhZGlPU2RCRUJQ?=
 =?utf-8?B?QjVoUGJTb3JNTVVWSVdKSVRVb0xYUk41TncraGFUVzliRjBDMmQ5Mkl3aEFy?=
 =?utf-8?B?SEVqSFVsZ1B6cEcxV1ljMVg4YzFaa0xINTg0NjlSV1dNalN5UUYrcEZGTTJo?=
 =?utf-8?B?TW80ZVpBQ3RKU2FOMHg4djhQeFZwdHVrdy9uMlYzNisyMERXVXVkaDNDNHB0?=
 =?utf-8?B?Zk54ZmYxK2ljd25CcGpkQlVvTHhVZWYrK2U1VWpUT0IxQlZpQW9pUWEyMW9V?=
 =?utf-8?B?ZTYxdk4vbUdkOTRzRXJFMy8ybXBCWUxvT2wxNHNHaDN2WkkvYk1oNlRiMzZT?=
 =?utf-8?B?VXNla0E4QUVOTnQ0V0FoWjRTdWhBMVZrby8rZjZCWVdIQmhMRjBRN05DUnVw?=
 =?utf-8?Q?T7wT7JUq5tc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlFJRFhCQWtKM2JPUDhycFUwUGkrczM1RGlQZFd0STZOR2YxUmh1d25yaTl0?=
 =?utf-8?B?WmZ0ZlpTZnc1OUFFRWM4eklSeklKZW9qM041N1U5LzhRRFlrWURwbnVxZm9C?=
 =?utf-8?B?YjQxZ0NHMzVZMFVqM0h2Nk1sZkxMbHdDOTBnMDRhWHMrOWp1YmRpUmZHc05P?=
 =?utf-8?B?V1puc0ZVWjdiaUUvcXJGd0hROHN0d1dReHVHbEtBb29oTW5paEZaRDlqQ0g1?=
 =?utf-8?B?ZE92eXFzQy8zMmgwWlM2STc5YlVhdlBxaHhaNURJVEFYMnpNT2Y3OFBzalYw?=
 =?utf-8?B?WXZsU0VyVnJDVWRtWUVYblVwTDVOMnpBSnV4WklkaS9mQmhtMWlXYU4vbDJj?=
 =?utf-8?B?TXJreC9ybFkycmYyL09hdDlUY0RsMVUxcFBIVG96V2R5R1hQRTRtVmRqSkIr?=
 =?utf-8?B?TUIxS0srN3BSMkNrcWh3bnRKeTFYai9xMHJZQlVkMzEwQUNmR2dFREFJN3hO?=
 =?utf-8?B?Uy9NS1l3UFY0d2dNSmM1NHJhWjJZQUp2WCtWUFhkc3RiMzNHZnd3T2ZlTmVx?=
 =?utf-8?B?dUVrRk9YZkJRRWlPSVhnRDcxR0VMdThHSlN1cHczcGxCNU52aDg0QUlBb1Yx?=
 =?utf-8?B?b3c0UWxBakVvOWVwL25KM0kwZjFDWmRTVEg1UnhJemo1U1RHLzM3UXkrUFRh?=
 =?utf-8?B?SDRJdEZldXVtZ0xGcGRYVlJyc0pNOXlNaW9wMStBNVhSeUpWZ2ZsSjU4eEg0?=
 =?utf-8?B?UFp2cWFtSVl0RjhrK0ljdElxU0JHTGNkQU9OQUFXRmFmNUpDajB1VTJUdFZI?=
 =?utf-8?B?QjFybmtKdkRjcnlVWEpZaFlVVkVQeWJPc2pFMnkzNGlUMThDZjBsNlpLY0tD?=
 =?utf-8?B?RnNtRU8wYjdYVnBockx5ZEJESVF0RHdwWmlIeTVaa3k2dlpaQ3lNcGRUMGFw?=
 =?utf-8?B?c0tPZi9CU21YcUF6WDRSOGZxTjI1Rko4eXA0M1JMcU5kS2FURkN0aS8wYVpx?=
 =?utf-8?B?NWYybkVGMm5LVTZmSnhuVHhBUVpsQ0hFcmM0eGZXdHFhVERWejlqd2NjK29E?=
 =?utf-8?B?eUhhdUhObWpIQTVxSVhjNGRaOVdHdkNaSUhHVldPZDJWMG5OWFBHRTkvNEJ6?=
 =?utf-8?B?dWh1TXR0cC9RRk1IRHY5OUN4WjdnNFZ4UEZLQzN0YW1KajBaTEdBMVlYbFZN?=
 =?utf-8?B?NXBBTFdsQUJ2M29oRWYyWlJjMC85QjlodWxocVJENzVMbkF5TnJheVh5VWpj?=
 =?utf-8?B?M2l3Y29HMFF0Mk9HMDdqVm8veUJyQ2VPQitKOXZxK0NYZGZRUUdSY3hWWTUy?=
 =?utf-8?B?MHBLS0JGdkVwUXpNUFNBQWtBbHgybi8raEppNzk0eUlKdlBIa055aEgydTd2?=
 =?utf-8?B?S1FWa1loNndJU000Ri91ZFppTkJnREJMN2JMUXJMWTMvR1hPN050elV0aUdE?=
 =?utf-8?B?ZjlZUlFyaGpteENmV2RKekMzOHJ6bDVFUHEyTXZwS2lYeHFKdkZmOHI3Mjl6?=
 =?utf-8?B?b3pibHI5M3RlQmhPL3FPMDczelVnMjVHVzN1WU9ZUi84cFRrNTM0aTZnVXhV?=
 =?utf-8?B?T2dlRjZDODh6MGREdjFPckx2SDh5K3AwNUxQTUdmT3o1amdYOFk5QU1iVjZ4?=
 =?utf-8?B?Z1pLN0R5SlU5VmdldmdFVFFRdWd5MHhXRTRONmoxKzRPaU9ZZHBEZDdlQWZU?=
 =?utf-8?B?b20wR3EvdFNSU0hrS3FQRGIvMzQ2L1hxcTBSZUJlR1R6YmJvTWZPRWdSRmpD?=
 =?utf-8?B?V2kvZVlyMUpWZlJ6NFRZSklRdGlzS2NVb29IV3FsRE9yclIzR3VvKzh3cnFl?=
 =?utf-8?B?b1psd1diMTBlZitlODRxYkYzbzl3Z3FmOWhLcW1VaXJBdW5XRHBMT1FnMU1N?=
 =?utf-8?B?VU54eUJrWHZhSldValhMb0xpQVkvUzFOVldMSTdiaHFFYnE2aWNZTFBZV0hN?=
 =?utf-8?B?UzhBSG8rTTdVZlU0SXJTaUJINXB1MVlKc09qOCtEcTk5b3czSUdlb3REU3Y4?=
 =?utf-8?B?K3NVdDVwQVlNWWFDdU1UaDh0ckwwZXhuMVJqWHgySWkyMW5MZURSNmVFV0Jl?=
 =?utf-8?B?bDF5dFdTSDh6cTgvOStNcWxCZHFmcmoyOHBFemNhTVQwMVF3Mm5HM0QzQ2Nm?=
 =?utf-8?B?VDdaelRRQlRJcWx0ODVvekdxT3VmQUNXK2tUUHZCV1k0RVpVUmd2RG9Db3Mz?=
 =?utf-8?B?VWF5OEtQbWN2M3dIaTZEUlo5STdza2xSTmdTenJhL2FERmFMZk53YmRuRzFl?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f44fbee-bd53-44ea-bcfb-08dd8efbed6c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 13:18:02.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2WLgty84Ztp0sfEww7gSPexOzLj8f/V1xn/RaxAuQ2UgGX3wJE0zDYfp1GJC+Kgp7lw7BnI/0etK/u3vydOew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764



On 5/8/2025 7:42 PM, Paul E. McKenney wrote:
> Hello!
> 
> This series makes a few small updates to make rcutorture run better
> on arm64 servers.  Remaining issues include TREE07 .config issues
> that are addressed by Mark Rutland's porting of PREEMPT_LAZY to arm64
> and by upcoming work to handle the fact that arm64 kernels cannot be
> built with CONFIG_SMP=n.  In the meantime, the CONFIG_SMP=n issue can
> be worked around by explictly specifying the TREE01, TREE02, TREE03,
> TREE04, TREE05, TREE07, SRCU-L, SRCU-N, SRCU-P, TASKS01, TASKS03, RUDE01,
> TRACE01, and TRACE02 scenarios, preferably in a script.  (But if you
> want typing practice, don't let me stand in your way!)
> 
> 1.	Check for "Call trace:" as well as "Call Trace:".
> 
> 2.	Reduce TREE01 CPU overcommit.
> 
> 3.	Remove MAXSMP and CPUMASK_OFFSTACK from TREE01.
> 

These I will take for 6.16 and run some tests, since we're seeing these issues
on ARM. But let me know if you want to delay to 6.17. Thanks!
