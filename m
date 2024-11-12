Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A27F1DFE4;
	Tue, 12 Nov 2024 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381463; cv=fail; b=ffP8LqYgvP0SyIpoufoFHAazxbU5+S43sGrm/E0t8NMoPJbrKrM8+XZ7qSNEoWkg3ke2ltA4ZhjXZ4AyF7H+Tp6zNeiCwHkuQuQ6eFpcnA1jy9oh5+UarJmHCHFQYohnlwcUU9GiEtWM0tki2Ksec8DTK4kCmjDxBvososH1luE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381463; c=relaxed/simple;
	bh=mUn9bWYy+XhHWfbz2osnDFn1IblwCQ4j9E/fA6GQpRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a8JPL/nyHaaI1dxNzZrQHsdEgPFtgC3FF+/WPPltiWFkSGi+v1kLjudLvOKlkppI1sgFe34aPJ2/gi/UBVuWwHTN/2Wgg6Lr774ffgbWI0AxbGDrXlZacMGsqU0XgjpQktI1tYYIWjoZUD+ddJiOhVVZeeK6C0tHKss3mp+nno0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kW3OHWIv; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kW3OHWIv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vs7CNRCUiFe8w62t6mjCEt57hSA6/7XvOuD//DVFaby3M5sYKuDz/kdcFyoDL9WPAckpO02ItK17+H4zXr945sLM5QmJTOOh4vczdoOe9x8fLr1/T8gANNc3glso0tOdUhDa7Thy3PUfhf+aeydLV3nzTUg2fu5CrzT/cQKsRlwj35b46aj9oqYLvI1MMpjjCWF8m6GlNGRLZIU5pjwbzN6uw7BeXa1V5LeY7QrOfNjsDP8CoZojbmX6VFPiNiXAEoCTu58/hPT//DaBA+mnNGKxcDMEY9Q2XR8qtG7Z9+B+P22Ofiy31bAQzGaU3x9e5VeycQL700ZdjWvlN44Mww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2k/hI8OhZf+0TvgFvRt4Ce6lOr8+XyEfvQAxTNg4Liw=;
 b=cNlACjfppSk9b2PtWExEp8B/UArrvlPMCY1sWX1CQc9x5kGho7XjaYW944Vk6xC9GBcuTHYvxl7bSd4oZVqn2immzP3AqkyPYPJa51bz0q9W1sG1DRWqNcwYMQBDu2q/Ksg6kRrtrQK8iYuHmsxA2EEX/YS4AjHws8ZczAt76U8GFl7jITcK2tVA3JXo7MNQRg+YhVRM46X5qG4TwVpyHlKUoXaEac/kiE3RvsA1u5HjvYHtDa30XzYP3oEIgC3WpLxdV81QU8iYHJVL0D6h8h3IcGw+UAWEz+cqzYp+5uI8Pk3qiRErZtPkIvWI29WcYTuuxKeNkiZ19cf6Rdy3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2k/hI8OhZf+0TvgFvRt4Ce6lOr8+XyEfvQAxTNg4Liw=;
 b=kW3OHWIvsqYklfr6vgo3K+SBXKoHN9dwrcyXeBCm7FCQ/ryJsYmSIhK7ySTtjUpdYuSrS/065Ck1HPkEGmIdS/2R6i8mSCSG9rpC23HHTvkyJWPLeOdbIqCQIYeLqmDzE8R2W2tGTHsPijmP1C6p/iK+7axaVI3VYC7bUrtdH5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 03:17:39 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 03:17:39 +0000
Message-ID: <e91e70ad-5f30-4b90-9877-7a2dd46375e1@amd.com>
Date: Tue, 12 Nov 2024 08:47:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 1/3] srcu: Remove smp_mb() from
 srcu_read_unlock_lite()
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 frederic@kernel.org
References: <bb96e032-4f7d-41bf-a675-81350dca8d0a@paulmck-laptop>
 <20241112013143.1926484-1-paulmck@kernel.org>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241112013143.1926484-1-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 6014cc6a-27b8-4f7a-6053-08dd02c8901a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cU9KWmQ3NzZPTTRIdy9mWURPcnl1TnZYRldyakJUUEpOVnZGYXZuc2xJOStF?=
 =?utf-8?B?cGMzMzBCamJYeERlYXM1cmtSNzRXZFA4Mm5xYmJ3eVFYRktwSVREdXRVb3k3?=
 =?utf-8?B?M3FrNnJJUzhoc285NkxRWW5zSDVlLzVFNld0bDlnUXBQdjdja2liNWNZRlFv?=
 =?utf-8?B?RlBwTWpyK2F6d0s1ZHNsT0M2aFkyUkNqaGRjY0lNR0t4RFBlaCs1Y3lhdjNp?=
 =?utf-8?B?UTQxRWRRd0lDSDJicUxMTUU0V3Y2aC8reUlOV0pldjBIMkdoTVI5VGpHNGtn?=
 =?utf-8?B?YjlicU5CU0RHakluZGdyaTJzN1JXM01DSmRhOWFBOWR6L1h0ZW1kc0lrWlpr?=
 =?utf-8?B?NDhPRlMzOHRsdWhWMEZkYXYzQWVwcStGYkNnbVZnWDFsdmZNWmM2V3dBNEVu?=
 =?utf-8?B?N213SUtaMG5CRGpxMjhYZ1JTZytIRXAwcXJZTkl1QUIwYllQdXh5QUM0a3BR?=
 =?utf-8?B?WFhIRkZGdnNWMjlTaldPeUZuTkJscU13eXZNWERBRFlGSVhGT3pVeWpQaTJo?=
 =?utf-8?B?ZUJ4b0NnWGlYaEsrWWR3akN2QVIrb3hrSmJiakZab1RZUklGbm5LYzBhd2Q1?=
 =?utf-8?B?anhUM1JlT2VrQkp1QnJHbUNNaDNNaDI5NUpkWWEwdEZHY1ZLK1h4cnF2d0s4?=
 =?utf-8?B?dmZMdW1HVzl4eVJCb1ZaQy80SWRGVGFqZ1JhRFZubTBSUlZ1WnFrZW44ZFRn?=
 =?utf-8?B?blVOeExFcFphQlUzcFJFV3k1YkQrZFdkN2VENzFvMmhNbkxVN1hqTjdkQmxw?=
 =?utf-8?B?bWxIQWkzYzVnbGpYWjR3Q2luNjZMWDJTQzlFUkVtbFpkbE5Ebk9rTDZYNUVj?=
 =?utf-8?B?N2twcm5maWFZaVUxVFJoZ2g1bHFQSU5nc01sUEtqWmx5am5zSnBRaEE4eEpo?=
 =?utf-8?B?aHZId2R6R1hqTU00Ly9ELzR3MGVLc3JVS1BQaFNndzE4VU05OUpPbjdFc2wv?=
 =?utf-8?B?NnFsU0J6cThtOGxRVlRwcTBjTko1NGxWeU9DTkE1UnZiTUM2eEZSYk1GcUp6?=
 =?utf-8?B?N1JNR2NOZ05iSW9jT1pXMWQraktzclJGRW9oUUpvbE1Ldmpub3FrajU3VlJU?=
 =?utf-8?B?bkVlSXJCeSt4ZWNqbXhqMGhPVkVWMW9ybmw2Uk9RMHJvb0lJdEJoUTRhc1Va?=
 =?utf-8?B?dXR3VjZwdDRYLzM1YnFoRWFLMnNOVkZhaUZ3OXRhQThnbzNnMmpIaGMxdUM4?=
 =?utf-8?B?MWcyNm1lc1dwSUR3ZExGZkJvVk90UC93djN5bjBJbFhGZDExaHVybVVUZkJq?=
 =?utf-8?B?RmFEc0xHWnNUWS9PRUl2MHUyaUFxNWd1Qm9wcEtSM1VLOG9uTi9XMVVnU0pN?=
 =?utf-8?B?a28xdktRSnZSYU1PejNTUlh6MGZKMzllZGUrT2ozeDJPZG5RdUhiYnBsQThF?=
 =?utf-8?B?bElyTjRlZzR0M3BYekF5ZVNQNHFoNXhOMlk0UTg2Z0FoV3BFWGRIZFFzc1lF?=
 =?utf-8?B?SXZoY3h2M1lMa3h1dTNqdW1EcEdZTWhpMzFlWVdSWVNNSEI0eW5LREk5cGpI?=
 =?utf-8?B?OFdhT21kRlF1cjFaMThDUFpYcXRQM1QxYmlDRWRML1U1SzZqKzJuTk45UWVi?=
 =?utf-8?B?Q2dPQmxzUi9HSnVyem1yZmY3dXV5M3g4OWJONEU4RkpHa3hLK29BSnNwNkQ3?=
 =?utf-8?B?UlpENWh2ZW05VWNaMW1naUgvZ2xmclRpekY5Y0JsNzAxN0VzbjRtbDRTSm9J?=
 =?utf-8?B?NzZ0QWxrOWdjV3MyTXdOK2RLWGlkTzNYcWlXSkUwRWNOeDdKcTVZNm41VUhr?=
 =?utf-8?Q?55JXx7s7e8jXQsNV3+0xgxeATUrJZxPmS8CBfbj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1pLenBRMUVxeHZsQkRxUUowZGM2MGtSQ3NRcjBCbS82RnFkLzF3N0V4Njcv?=
 =?utf-8?B?M1NnWE5CTExoVCtwK1h2UG1PNGxUSGxNcWlNU2YwaTg5NzBNdmdQRUJFL0w3?=
 =?utf-8?B?Y2M2bG5LWEF5NDE5bitYdVNjNWJ1YTh5MHBaam9iOGRXdXVGeVhFY2s0Nkgr?=
 =?utf-8?B?U0E5bjlsYU91UUxYVy9CKzNmc3dyV09WLy82YjQxeXhBaCtmVVNxZzZLcnNW?=
 =?utf-8?B?ZnV0UkdSNjJLVGZXclZpUko5dnBxc2tCUlNWUGJhODNsSGtqdVVVd3lyTUdz?=
 =?utf-8?B?L0s0ZHZaVnIxblJrbXg5bGY3SWxJK0lpQkpWeGRzelprSGpLZzRROHdEVmZq?=
 =?utf-8?B?NW9tY0xaMHhsQUdvemxzN052NFVuNzNXYVMzRzhJMExucGhRL1VzK1FQcHBM?=
 =?utf-8?B?YXN4T2EzZUp4RndNZEdEOEtKa1ZmeHJmZG1EMUh4dDJMMCt6V0VPcU02SDZv?=
 =?utf-8?B?TVZ6aTJVaHF5WWhhTWxucWdhUStmYXNlUW9SVWJvK1U1a3RUREpJWHVTNGo1?=
 =?utf-8?B?bld4b1RwdFErN2FCMmJwMlI2SDhDZ2doQTFtYXFBd2NxVU5BSTRNTWVBWi9L?=
 =?utf-8?B?ZStIcDV0U3R5b3Z2VG14Q09rU0F3THBBbWxFbnNSZUFJRldsMGdCOU1pSFdp?=
 =?utf-8?B?dkwrQmdmMlpTRzhiTXNEV3NIdmZEL3FjY056REJhVG1mNW1jYVFLUTgzdjdp?=
 =?utf-8?B?SUIyYTBHV01SUXJsQWFlTm1JdDllZysrVGVVZXViR21pQkhJY3NSZXI3SVpX?=
 =?utf-8?B?UGlhOXVYQWZyLzluU1pFeElaTW9MTC9QM0NSUlVQWFFmaFN4cUwwM3NzbXB2?=
 =?utf-8?B?ZmFjVHREOUhucmlDYUJnRGExVWwwREQvVk9icGRMUFN2VlVESjNCYTRlRklB?=
 =?utf-8?B?elpNTmFMSVlwZW0wNXkrN2NRSS9FTk5iMFhsLzVOUWpVSFVKamRRclRHbUxP?=
 =?utf-8?B?QkZrTkxrSUpiVTdTRDFEMjd4VFBZSEpYMHFNalRob1lneEVVOE1qV0VWMkhx?=
 =?utf-8?B?VTJYQXc4N29JNkV1UHBabWFYRHVQLzFhTm1uMm80dHNGU1R5dlZBZXhCUHJN?=
 =?utf-8?B?M01sM0U5L3RTT2xJRkRmR0RhZWpzUHlFSXJ2UVN0cEJWcTU4SlpzblhPazRh?=
 =?utf-8?B?ejdHbDJsSms0eHA5SXBlYng2L0pyamxhREJrT3JaMVhBb3lZa3huQzBGbEJI?=
 =?utf-8?B?WmpEWmhtZjhrVGgwQXdwaE1QcFd3cVpZbEJ2dk92YVhjNE1UOC9zNEVsTzRG?=
 =?utf-8?B?RHdQc0xEWENWU0U5bEVnNGpGRk14TFpIcVRkeWd5QTBnZEZPWmxSWDFzaHFn?=
 =?utf-8?B?TExlWVF5OXBLM1d6V2J2K0hnMFpZNWcvUkRTRUUvT0RZV0dsODZvRmkrOW9m?=
 =?utf-8?B?NWJsc05ycWk3NDh0d3RMWS9NTE1XTS8wdGdSQ2Z4SzA2TWZSY200VU8zTGlz?=
 =?utf-8?B?MXZSU1FxbTkrcnpqeFZYVVBRdTE1a3pyS1g4eitOYTJkZ21TUXBWUS9UQ29m?=
 =?utf-8?B?eDlPbERmYnliQWpjTXNyMGo4VnVZYmM0R3hsS3cwcTlMclB6aVRYU3M1SXg0?=
 =?utf-8?B?N010RUE3Qlp5QUhhL01vMGhVeDZuNzV5Y3poUmdHbmpOUmF0eVVGSnphZXZR?=
 =?utf-8?B?QnNpT21FdzFoNWZaRWdqUE5pRkd2ZkhuVUNVTFRmL2E5WVlEaWFqNnNEWnp4?=
 =?utf-8?B?djB5cm9uN25rcTRWYXdRbVpTeUFjMXB6cWdNc2NmSFVVc3JBeXFxa08zQjgx?=
 =?utf-8?B?ZzRKS3NkZ0RETWtNQk45S0ttQkVRWVVMK0M0b3M5Z1kzVEZOOXFEaDFuOTc5?=
 =?utf-8?B?Vkp6dEptWXk2QmlYZmNOOGlBRytLSS8rRE1UVlBqTVBSblNKd2ZxUGZuWlBj?=
 =?utf-8?B?VWVLVUpyQk5XNmpyTjQ2bVZOK21pS2VVSk5CVW93NEgxbFVwaUpvYS9iV2oy?=
 =?utf-8?B?akdVOWh0SGRLN2JzSjdhZUloRjk3aHZNS3ZmQ0ZNVERaeVU0dDlIY09McGhz?=
 =?utf-8?B?K25yVVdyQTVob1BPazB2UVdYeTBJWlpsUmhFd1ZpRmlDUWFiS3dxNWdkR2Qv?=
 =?utf-8?B?a0ZwMHE1YjZFUWhIaENIdHR5cHlzS2JOWWlqOXVRbHJRZm9tcWEwZDlsRmpS?=
 =?utf-8?Q?roFSW0gvrDb/iiNlx/8t0hTRs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6014cc6a-27b8-4f7a-6053-08dd02c8901a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 03:17:39.1901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nGKPpks2HoztGcxRMVHnlFyySRbUXSSOgytxiqwfIYjQjLzOQypuI+GeVdyCQrrM6Txd+FD0xsajRV1AZ1iSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930



On 11/12/2024 7:01 AM, Paul E. McKenney wrote:
> The srcu_read_unlock_lite() function invokes __srcu_read_unlock() instead
> of __srcu_read_unlock_lite(), which means that it is doing an unnecessary
> smp_mb().  This is harmless other than the performance degradation.
> 
> This commit therefore switches to __srcu_read_unlock_lite().
> 
> Reported-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Closes: https://lore.kernel.org/all/d07e8f4a-d5ff-4c8e-8e61-50db285c57e9@amd.com/
> Fixes: c0f08d6b5a61 ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj
