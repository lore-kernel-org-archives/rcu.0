Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A51DF265;
	Mon,  7 Jul 2025 03:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751860195; cv=fail; b=YK19f+yzxCEDe2q1MC+BPGKeH233qRpV6UP9jKJVXSt6BFpkn0NOQhiKbLxMJNCYQ2X6XNTc9zi0u5JYfJR6mRoz9XF0EECr3VO+jNw+JaA0zt12HMmOWGLWiCBmksUtTSEHcwtjh56g6E0l4uJvSs/hhec1WQ0DKggS9oodhbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751860195; c=relaxed/simple;
	bh=UhDqyy9T/sQdaDz48XXzmBZfGgOAoxHrKblMHhLfyNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pA327B34zXPT51hnAlWxe2q0cyZkBwWbhF6VILQy3WHKvrjfTsjhOb41WyfY/UjIBiud0epNbWBzy3EPyfqa2SBPYMq3xipawr3jERAFg3ilR2LbNQUzVta/aQR83MrWy3HNfeSfEtS8FwBAYTgzfcHcK/5dnJW0+dGzTVwW7A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lp6J4Vck; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lp6J4Vck"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVYvjndb1mkc09Icp4lYD5xENFOm0dVBTTDHKuxDR8Pyw7agBYdCAGWb4jb/i8yBXkzEkrNQCgZb9VrIVNGnsQw0HMesG+8T0z6R7YW4e12QG/l1WPGNUbpppatxVEIkmEK8FYb9oA5Ow22gWss84XbPCLdb0uTygEDMjK+yl8+0G4pjCrJTAakyrXHOq3v9NTkQ0BI05sHMC++tRz62HeLYXDLydP/tYUCru92+QhSh52ROGkeRu3GD58S+20og1hadnkgOk9cnIvLCV84VaL0cjicPRaQNTB5VMfclfaExRBDECs0BasOJl+GWPdAbOfS594qfj08b/OdFAtNIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLbiGfrJLX8w2u4+t5lc7VMt6WV/iTjlcKBYh9LHIro=;
 b=SWjzUqazJBCSkwM8IwevHLcR2HjTh8eridLBjry6dLJbiiaZ3krvD9qgyV4sQsA6G0I30LcpwNo2x5YjWEZFnsMtPb2sHJNdMNI5YG1KkD5n+rXEvqlg6/9OgJHfL3dxfUAP6FPdHTcTglmvET3fGH2HVADRWngYTI9nf7qcoveltQ8l7B+fuoEJoIXQ/Qb0LUfD0gnj8bKT3DxT2Mqn/B4QvyCEajW1VE71o0gDS0YwNNiykAalWyC7FuX+s31wO27YVs7/Pj6ySi6QN5NEUpCe7E3HiYtUkw4Vd9zqg0WCoU0SW0TbL+sxiE4rRxC9sp3NNR54Qy3tqefbF0X4nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLbiGfrJLX8w2u4+t5lc7VMt6WV/iTjlcKBYh9LHIro=;
 b=Lp6J4VckS/fmIMtU06Bj5J7eTofJdsSaqlSGDY91HrhSKsOC0MjkVBSiARTE37gRmRC08V+e1wimk9fFDI02tDSo5XJZnLNSiS5m1sAYYG+8nVCvG6jUZSprcm53B7mCGIbw6zbfy5yqu1kZ1DKYQUryQYZR8QL+scW9K5LX6EI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Mon, 7 Jul 2025 03:49:52 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 03:49:52 +0000
Message-ID: <fee9ae77-2d10-47d2-9fb6-ea6a1f850dd4@amd.com>
Date: Mon, 7 Jul 2025 09:19:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Documentation/kernel-parameters: Update
 rcu_normal_wake_from_gp doc
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20250702145938.66459-1-urezki@gmail.com>
 <20250702145938.66459-2-urezki@gmail.com> <aGajYsyMTAD17WIY@pc636>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <aGajYsyMTAD17WIY@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fe71e5-11b5-4659-87ed-08ddbd0953d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vlgwc3pnSVViMXp1ZmxuUEwvQUNIVFpRMUlPTWw4VW9RMy9UZHBSclZVWmFw?=
 =?utf-8?B?NFdWM1JPcnJiMGJHMVNIbm5DWVVKSFZyMURDNmU5NEQ4VWwxUUJCNjc5WGdC?=
 =?utf-8?B?VFBqL0JxOUFhTWZwcmZUd2JuWm0zRTBpNk8yNmNjUE92U0NWRVlRMjI1bVVJ?=
 =?utf-8?B?b2EzVkp5Q3MzZHVaVHlmbnBZMUYzUTZFeUJWTXY2Z1E2NHhGTHRiV3JvaFhN?=
 =?utf-8?B?WnpydWt3TG5ZZmU3Y01XbUlSMXp5VzV5T0Y1cWtVSUpSWU8xTCtoalYwbTdV?=
 =?utf-8?B?ZDdnaHhoMFlmSjFublNnY09ScGJqRUdaR1ZPVnMrQ01heTVabC9ETnZjK1Zj?=
 =?utf-8?B?T3R5NjZsR2VKOC9ibnZQMGlVRHI3eUdGdUwwR2NKWVRrNHFQOUxJL0F5RUtv?=
 =?utf-8?B?SHAxOXJvVUdaMnduZzJPQnFyOG1rSjFHdnI3ZGZ2ak5jREg1Nmxuc3JTZU94?=
 =?utf-8?B?ejgyb0I1WE93TWtzVVJYbWZPckVuTGg5YkI5MHJQOEZqQnR2K0U2YTFTdkRQ?=
 =?utf-8?B?MVpiRmZueWZiaTIyWkduOUFPeVI2L2NjVHQ2Z3NpOEp4V0NxTC9mS1dzRzZt?=
 =?utf-8?B?TDVQdTIzZ3UyWmFRZEVrZy9KbldUU1UyMnNvV1ZYZGJXNTNSRWYwb0llSlNp?=
 =?utf-8?B?c2tkMTZPelY5dGxKYU40bDZXRi9XbW96OWNyNnVlYkZNUVh1ZFViSXRGMWJM?=
 =?utf-8?B?bUMxVkVHd1hlVnRXbWVRWU5OeFAyWENRNmd6bGlTWENKbk9LSDVuTjJQb0dQ?=
 =?utf-8?B?NmJ2dG9qNVB3eUxKTmdKZVcwZW05NVorTWFEbzBmQUQrSUpsbHRWQzdrb3dP?=
 =?utf-8?B?RnZCWjhhZWYwaVhyWVZGR1E5ZzZqMFpZT2R3bUVObnhwbzFMSkJ4K1FZQVVl?=
 =?utf-8?B?eXM1bkNjZCszODJvbFBMUERnUlFqK1NVK0ZEOENieHBGRHJVQTFnU0Zvdi9M?=
 =?utf-8?B?bXBVeFgyUU54NWtmMm5WV0pzRE5idUdiY1FueXNsUjFkQ0N6eWFVUVU1cG9k?=
 =?utf-8?B?VnJRZFFRL1I1Y1BWUCs0MndtU0xoR1hKYlFIbWFLRnFBK2V5Tkt1ay9rSHBF?=
 =?utf-8?B?WFpqL3Q3TTd6d01vZlpwenY3cS95M2h1WkY1UFpPNGdWQUQ1WGtBRkpGaTIw?=
 =?utf-8?B?QmdQc0YzcThJY0pqajBaS1FCSHErN0JQdER0VGdHOFFyeTQxMGhvT01neFN0?=
 =?utf-8?B?M2YrQjdFa053cUxiNVJCd1BTbDVRL21DdFlYbXhqOFdCRm85c0JCMmNWd2lq?=
 =?utf-8?B?WGM1YnBXVEJDWWFjS2JWd3dmZFJNWkNjS1p1cmVxb201bXN6ZlNxUWp1T2o3?=
 =?utf-8?B?aXVjQXBpdFFueStQUmJ0bFA0QTBPVjBXSmNpU3Q1VitsTjQzcEFUK29kVjFh?=
 =?utf-8?B?NmtWUStyVnR4cXNOSldkOGd6N1N6d2xJY0NmN2o0S0Y1aEw0bXlkdW5xNG1S?=
 =?utf-8?B?NDFZNHJqWnVWUWNXcHQ1WC9CNHljYXIrUk5LdHQyb0I0NWpSNXJ3MFdTOHRY?=
 =?utf-8?B?VUxDYWNxTmdqZG5PQmVlMGFoSHM2anlMeEJzVFc0Q285NStRMlhsYVNVTm50?=
 =?utf-8?B?bGxkYlhNandaUnY5ankvU29RWlJnSU9pYThPbDlPUDJxZXRXOGdvUndhY3gw?=
 =?utf-8?B?ZXVMd0FLUmwvS3JDYzVWWlgwMk5veEJnY2xFWGtaMVA4Q003V09mOGVkMGpL?=
 =?utf-8?B?bk5sNjVjem9oQzV5Unl6eHVwNGlNNXIyek56aVlKWDdIM2xnU3hrYkpYVmlm?=
 =?utf-8?B?VXFYZ0xQcWZqY1AxYUo1anU4SldrcGxqMG03NXI4WXRVMnFyK3N2cDEweXla?=
 =?utf-8?B?UlhzMFMyd2lCUmYwZTgzUllkRS9iUFIvT05OUTNZaDE5bVdVOUoyYUl5bVpY?=
 =?utf-8?B?NVlzamQ0VUYvVCtTQmVCQUR2cG9KaUE1RHZvNk5ZMmlLMzlDWlNjTE9qbGts?=
 =?utf-8?Q?Bhh3ZBMDmGw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmUwVllqazh4OTJZZURsN1lwYUJLRVREeE1tZDVhM1pDSnp5cTZEUWdRZzRJ?=
 =?utf-8?B?SERPVjdlR3NsQzRvaExHZkd2UW1YbnFUSDQ2M2dhVTE5aXRiZU5sWHR6bVdM?=
 =?utf-8?B?UXVnaG55U3lkMzk1QTlXV1Q4MWVwMnFSUDBYcHRwTGdNVGhhMnpjK0RhZk9i?=
 =?utf-8?B?TGNGWkJ2QW9MZTdvWnY2MnNwcG1hS0l5dTlqZXczaDF4dDZuOS85WVNZbW1L?=
 =?utf-8?B?YjRDTEtUVFVBQkwyb1pzaGVLaHIwd2QwK1JyVE9qbXhSOWFYNUE4eFdNWXVy?=
 =?utf-8?B?N0dCZ3NFUFY1aEpzUkhsaXZuREljVGdQRFppZTQ0dWFKdjh6MGRRZkNFLzA2?=
 =?utf-8?B?V1pZUUt3bnVqRlhTK3pmMHR1Ujc2QWI2RXNscHlqUWZrNG13cWVzUHRrVnAv?=
 =?utf-8?B?YnZIUVpjVzFCWHJZM1pVMDRHRjdvY3ZpaDlkd01YUWJvR0w0bWhRYko3M1dS?=
 =?utf-8?B?MWRzZ2dnclV3dGtpcDllZGUyOFl1blA1TDRrakExUnNxNm1FUTNINUo4QkNq?=
 =?utf-8?B?WWRmZVhMVkx1YlNPSnJLeVZmU2s1TkEwWHVCS3AxMTZaa0RTakdxU2QzY0lR?=
 =?utf-8?B?bDBtNFlBTmlQeXJ2T2d4bDRpWE5VeVN4c3ZVOENjY3JnckJROWhmSVRWVjFq?=
 =?utf-8?B?ZnFEdkZieVoybndqUjNoZWdsNjVpYUhYeExpQzFFRmJ1V250cHk0YWtwVGgw?=
 =?utf-8?B?ZWwyVTJkOU9hNk9JdmF3K2RiRVlYK0FhbWtiN1BtYzMxcEZhV1hSOTI1a0dE?=
 =?utf-8?B?VzQ3NStZdk00cXZwS0txZDdzMElPN2pWdmxEVmhGamNTdnArMHcwM09lQkRC?=
 =?utf-8?B?aU1vUzNLTGlZeVBzZ1h5WjArUzRKZjZxUFk4VkUwNWxibDl0UHpTTjlkbmtl?=
 =?utf-8?B?eG02OEFZbzNEK3pVZUc3YlBBMHBmKzZOWWRIdlNTRERwUzVnb0ZKZzVteEx6?=
 =?utf-8?B?blZwdHpHOWhHdnJjdE81Q0RkbUZ0WlNQL0c1NmxWeE8wR0tNN04vSmVpQlhp?=
 =?utf-8?B?V2pBMDBZc1JUTGU5N1UzSVZkVForNGpERkpnazZBMG1SbFVwOUxDT1I0N1FT?=
 =?utf-8?B?WVRPcy9IQ0F5QTlFeWdpdTFWQS9iS1pqZVpUU3hiQUxUb1pPMjhDU3Q0SVVG?=
 =?utf-8?B?QWRZOWdTQ1FHa292TzBqd3ZxUC9aZ1hIYVlmc3VJTlRlS0doMkE4Sm5lemlT?=
 =?utf-8?B?NWxDYUVVL0dvcHJFZkxNdzVWRDRHdzhMVWR0Wk9TODlwWVBVWDdXSEtwS1Vq?=
 =?utf-8?B?TEtkdldhYnk5d0oyZkxWaHV5eGpadzgzWkJUT3ljRHRlNkFLdExGSEpQOVdP?=
 =?utf-8?B?YlcxNDFGM1d2TVBKVmh3UFN1NVdXZ0dtWmlIWnNxcmFnVkVrdXM0cjdTOG40?=
 =?utf-8?B?dDE0L0hZS2ozUEZTSnF5VncrUHhBMzlEQnVrbTJoTEFLZWltTlc4UHBhTEFu?=
 =?utf-8?B?aEhTVERZeVpnRUpKaUdxcHB0RzhlR2loemJNdGQ1Nld0aUFkNTRhTU9KdzZO?=
 =?utf-8?B?cVJMaGduTU5MTy9zN0U0anV2YUpSRld4aTNOb0ZUZGFvQ2hWSDFpbG9jYlJR?=
 =?utf-8?B?dVV3MjE4Y2xzMUFEQ2hDM1RYUlphSGhJenB5Q1hqMUl3UFA3bVlyYzlYWTVP?=
 =?utf-8?B?UWpaUnZwYVZZNWh2WklwRUJOSHNwdENGUkVaOFVONmJ2VSt6ZXZaRG9ZbUJM?=
 =?utf-8?B?c1JyTmJZNUY2TTNBRE5kOEVwSkordkg3RjUrd2RITG1ScjhuOHlZRUdUbEVG?=
 =?utf-8?B?SDF5VHdETitEVjE5TXhvUWlIZVBPWllzQ2xjb0l1MW55a0h1U0V0NitMNUxJ?=
 =?utf-8?B?M09RVUJKTEJpTUFURE44TUM0UkNHbzhkUWpKUTFOUW1TUGhiQlowNDRWRE1K?=
 =?utf-8?B?UzJNbTh6RzRLWWV4aDJzOGdydzI4dE5CdmlseGE3TUpFeExEWmdVampxc2JW?=
 =?utf-8?B?NEtwbjBndis2YklBZ0lGdkYybG5XaHJYK1pCbS8yckg5QmNkYlhvdnRuZUhj?=
 =?utf-8?B?M0xMb0lBSkV3MFlQMzNmUXR1ZWdNZHNLRDYwMElad1hUbWxhaWxRWWErSXVS?=
 =?utf-8?B?L3VqQlNiQ3BkcGZyL09pNnVCWXBXU3ZyRkw4VVo4a0EyYVZqWVN6WVdrbmJx?=
 =?utf-8?Q?eBa6F3AePW6iLzt0ywNyDe7+z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fe71e5-11b5-4659-87ed-08ddbd0953d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 03:49:51.9270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xY3MHzbECQqXkixfxAvWZCXds9zsm3QTkFHxCcXMYcFqbaLpbsm0/PQf2ObjNFlydYTC1iVAXvvUQz2jkzEj7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112



On 7/3/2025 9:06 PM, Uladzislau Rezki wrote:
> On Wed, Jul 02, 2025 at 04:59:37PM +0200, Uladzislau Rezki (Sony) wrote:
>> Update the documentation about rcu_normal_wake_from_gp parameter.
>>
>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index f1f2c0874da9..f7e4bee2b823 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5485,7 +5485,8 @@
>>  			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
>>  			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
>>  
>> -			Default is 0.
>> +			Default is 1 if num_possible_cpus() <= 16 and it is not explicitly
>> +			disabled by the boot parameter passing 0.
>>  
>>  	rcuscale.gp_async= [KNL]
>>  			Measure performance of asynchronous
>> -- 
>> 2.39.5
>>
> Same this one. Are you planning?
> 

Yes, will be including these in the PR for next merge window.


- Neeraj

> --
> Uladzislau Rezki

