Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C01F30C3
	for <rcu@vger.kernel.org>; Tue,  3 Jun 2025 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983869; cv=fail; b=GMWi5wY/Y/oY4jw0lZbmvVrsvebOVP5LwNh+D00bU2vTaMnDEBEMT1mX8r9U5OUAIH1Sc6FJYjkp/qzAofzZn9SvkcHVSaWC/h3RdE0Zwmo6AhlmJVbYsAbcxUuK51QIrayryZIMZJAdKWiQOUnIGRzQHnYAmvusx0VGNDJsIuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983869; c=relaxed/simple;
	bh=hsYpvGosMha5tCulLqPNCLeWcE5nplDhGUdLpFOLnYY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uBALAlvTbIJ2pA+kAway+YDWxFDCylZHYZrgS0ypq2XGmedIv4Db4VSgwDVU7KNgbWBZTQzkjnzNw2E2NzmZyWelkaDfnRWiJY6S9lCEBwCzxrDOwj8t283zsuUA7hXW3eAU6QvPUWurRm8hbZ/u8qOkZ2wQFWrelP91rJSdoMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t75aZvEn; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t75aZvEn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzApov7CiWqXDJDAxjejFDuezhwMgcpBQyPXdb/iyVMW/qswWpGC8Vx3Az5D0SIp8LlUNdoUJfTOzzIX0NKS/op1RpRTidtRq5xrnNN2cXDU9VHH/Ymjd5Fv6CX0E4ykCBaetalnSiAyl9Uqhqg8f4XBTdBOmlSAseU/l7hjJRwI2b3I14nkYQyCwSyfRlWylHSvEdvruo8b/ypWtSpsTtTOHAjWkINbu7VlgMdVph1c8u8GGxW6g1UhtWEWdXBKQ1RVyilCqO8K2IQ27h6Ib8Rts6uxzmCShHDPijzU9kAh0ygMFzqqRxcelSM+pWeY5dTYuZ+AY18qrUqRRq47/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x5oCYpopJMWHw43vVrUjt+wWX4F+A5hxOledP8H7Fs=;
 b=Az+Foqxw1E8eyZxA+Tzoz5o5W1NddyHOFgrqr/+C3KRRIS3/24KTQ0HD0E5JStHAv81SEMyi7nFToVojUTyAqflIeoL+MZJNmTfBU0bqAFYS4j0R4Xu0mIj58Tx/6x1TwrXZZnm+iSbmnjPYBsRbP6Bq/FbTy+vpWO5R9e91O7s3S4ZuFgSjf6MaVqzRpIhKLBwNNZaMSi6eE2YZkjKKVTfNhdPTvxSAAeFuO/+dZzFGij3PUzHOKq8tgvyP8HhAR0TBnexO2LztSgebOzC4bVCpFErXJz+PqPfO4c0OH+S5rBhF7CjYEVThNrfz02e1hZU9PmcA/h14pDd08MDcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x5oCYpopJMWHw43vVrUjt+wWX4F+A5hxOledP8H7Fs=;
 b=t75aZvEnbv9HytSFPkpcviy1YA7plr5jZIyZTdMKM4c+8a69biioTbd2dfuUzEysHaiwDoDxdZVqMe60k2/lZvp0CyhN5cen9eRfR2TkdwZx3jM2eicshK5v//mlLN0+MOK1keha1X2C8hsvojRkqaQv5Un9Ji7i6VSD8xqFrZtB1inJgZDRDH2092vea8cxSaYTi5b3TOZUjMxon6jtM6AgzJQP5GMPy9QbPVI+snOgIxaFMs0f/tt+z+3oHkxRIsLMYtbDlkqxDz/wiZEd/eOMPBgXkLzxB7NGqGuCd2UYrc7rEmEnY2SCY8HuEO1XtWrZEmsiBshy4nY30fh4Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 3 Jun
 2025 20:51:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8769.025; Tue, 3 Jun 2025
 20:51:03 +0000
Message-ID: <4e2211c9-d0ed-4c51-be9d-763c9eef370a@nvidia.com>
Date: Tue, 3 Jun 2025 16:51:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: RCU patches in flight
To: Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
 rcu@vger.kernel.org
References: <b7a341ba-cd4d-468a-9d66-4aabe70a747d@paulmck-laptop>
 <aD9exNsGkKng3ac5@tardis.local>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aD9exNsGkKng3ac5@tardis.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:408:d4::30) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6c0376-38f1-477b-e613-08dda2e05a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0o5TW1zdzQrSWE5VHVHcVRqTnhOZVVqdmVXVENZQ0gxdXNJcnFYZlozeWI2?=
 =?utf-8?B?Wm5CRHdoRW1wOXZxbkora1JONXg2UFBBNWJsOWJsWUpJUWdqajRVMTF1eXNE?=
 =?utf-8?B?aitDVXNCUy9EbmdSZ2Jhb1BtZ21lcjhOWDJrSGlDV0NuWFRxa2dGRndGM1hm?=
 =?utf-8?B?UVByb3BVL2oyeE1aMkRsZkJGRzRyZWZvU2ErQ3NSOVJmdFdBeTRLQmlXZWJ2?=
 =?utf-8?B?QkdCa0oxUjRrRFNwQnc5S05rLzIxSFNsRS8zN3BjeWVWMHl1aDVvbHAyZHRx?=
 =?utf-8?B?OC94Vkg1OWc1S1dtWk1OSGU5QVVrYmlOWHZSSis3bmxTNXEvRHFoaGNNeXpD?=
 =?utf-8?B?WElaUmdsb1l5OWdvM0U5UE5MR1ZlVFF6bzFQRUFpSXpJTHRkM1BJU3ZHM3ZB?=
 =?utf-8?B?aENLdTV4V1NCQWhZMy9CeFJtQkNVOG1RaVZJRWQ4RG1qeHFJVHlJWFEzR2FF?=
 =?utf-8?B?ZTZTNFNxU25xN2JuSTJSMklJZUt3Mm9Da3htSnVxdlgyS213N3F0Z3ZvdW1y?=
 =?utf-8?B?aDVtc1hNVVFqT25EelB0a1J3RWphUGNuVGx5SVVUYVlObTZHR1pJU1FNYi9v?=
 =?utf-8?B?ZXR0dFRLLytwSHByYWl4clZ5TE1aZFN4UGI3VnVJS29FZ1YyeEhrbWFQYmtE?=
 =?utf-8?B?azVQZSt4T0t6R0YwM1dpeTFjVU9CWHhidDlUWmR6SFNWdHU0WFNCRDVlc3Jp?=
 =?utf-8?B?ekRHaW1aSzh6elltOWY4K29LcXNFREUrMndTM0JEYlRTU0gzcU4wMitkZ0RO?=
 =?utf-8?B?VjJkZ0FvYUhrd0NuMW95UUlDYjNQWTROeVVhcjF3a1M2a3NsMkEwakFDOWdK?=
 =?utf-8?B?OHhnYnMySXFQS3dJa0xWVTdOeElMVUFSVU9qRUlaWFA4Y1U4cXBvRFRNb2lW?=
 =?utf-8?B?UzMzR3ZvZHNNa0JjVDU3SmVtQXJpS0ludXBjRG45NlRVQk11MW5hZERWdkI2?=
 =?utf-8?B?bHhKTFZoTVY2RXVhaEgxQytpblNjaDVpMC8xUnZKQmhiR2VQTEZDdllTb1pV?=
 =?utf-8?B?eHllK3UwZFM3RGtsSDNxRlJON0FYYUdybi9BTTBhZmpFRmlnclFwSlRDcFBN?=
 =?utf-8?B?eldMS2VtVlNjdldobEVXRWVEbGZVT1psZVJrNFluTGxwdno2UVNNd0FKV1hl?=
 =?utf-8?B?aUNnSm9kTHVrTE9HRUR5SjU0Q1doNFA0Z2xnbkJpYUlTcThJRDBhNWoxTEdW?=
 =?utf-8?B?N0cxM0gyUDdMMURENnhEcWN5UHdhK3V3OE9OV0kwY3RUaDBud0dqcWhZN2JO?=
 =?utf-8?B?bXZnZEF0ampEUTQveDVxUkxaaURmMStrd05uVmdLelU5bVljUERVOGtCUkRU?=
 =?utf-8?B?TGRaeVZKdHJrYzdwc0pwZnJzVEt3aUF6TnpqbE5RRjRjNmVKSVRBZFNVZmpW?=
 =?utf-8?B?bU1Lb3lxWVJ4YmlvdXBYNFJHSWVhNkhkMmQ0YWFNRFJjbDNWR3YzWStzeWxG?=
 =?utf-8?B?VEZ4OUthbmtLL2FMZ2JQZVZJMzBuckRmdUJSS1BEWEVNbEtxLzhER2tpMytZ?=
 =?utf-8?B?bmlKaWhQb3kvRzlCUFZEb1R6Wk9tWnE3VWhReGU4VVlDRGxmT3Q1VDNyMzln?=
 =?utf-8?B?aDhwSmVKbDdBU3BXNVQxZGFYL1NCcmhsa2FtOFNaU0JZbWliK0lCRG8vN1RC?=
 =?utf-8?B?ZHRRbjdpbHphbVlNZWFWUEw0WlRwZlBIQlZTMHk4cWY5dURXamVWTDNyNUNJ?=
 =?utf-8?B?RUhjQTZSaDNXM2xhNDRFZDZOL25NbG9leElRRUlDaWMyV2JJR3piODlXNUNj?=
 =?utf-8?B?SVc4VW13WW1aakNocnREUU5wRGwxOUh2RlVpT3lIcFpkYStpT2phMnJDaGFr?=
 =?utf-8?B?UStZcXFuM1FKRFprbU9zaTBsK2laV2FsWklXUHE2WExHaWRiNjYyOTRpeHl1?=
 =?utf-8?B?eDRDSVZJczRtVElrOTZlYzFJTVpVZmxyRDQ5TWpxRUNFQkVPUEEyQnpyNlQr?=
 =?utf-8?Q?VJcqUALtnoY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzcrNnBHREZyRm9aZ2pLNFA0YmthQVh3S2xSWFFFTVN1SUV3QW1xNERMUWJX?=
 =?utf-8?B?ZU82b1g3QW5Eb3QzZUFBV3NoQnNBdWlFOUk2MTRpWUtPTFNEd2YvMUFwK285?=
 =?utf-8?B?M3JyRjdyZTNDUGhIbW9FcHVtQlhtNFdMZUFHOFNIdTh0V3NYdmdZaTYxL25O?=
 =?utf-8?B?VTV3UnhBZ28rQlQvdFZySHlEWWE3Y0xnUUdzNlhtSDdpa1ZzdGJVRXp6Umxy?=
 =?utf-8?B?aE1lN0RaSDkrckRXbDVUanFwemxRNG1vdEdYNkIxM2ozeis5aGk2VVd0LzhL?=
 =?utf-8?B?ZG9MTTJ4T0wyNHJNUFFhUUxhNm5zVUxGWVg3T2NmOFZUVHJGemZ5aGJmSk82?=
 =?utf-8?B?bkRjajhXdzZscW1KN2FPbUZPTnZKMVlYWXFUdGZhZGw1bXVkY0tqblY1Z3dW?=
 =?utf-8?B?SDF6eVhLVTFjOVlyWnhBV09rTjRiOTYxUmY2aGFDeDBUVTBsZURMWXg1VzRF?=
 =?utf-8?B?UWNRMElXbFpDMEx5SXRCeEhUL1RTTHJHWEtkYXd5OWJaUVJDOEsxb1EwM2Q1?=
 =?utf-8?B?WkIzblNQN3c5NVN1dEtWTHR4VlVBYlNmSlgvU1FwTXpheDMrZkpDV2ZXNXdO?=
 =?utf-8?B?R1B6aGVuTVpML2tlS2NpbTE4WktmbEFpT2Q4RE9mMnQzWDNUQ04yMEhka0h6?=
 =?utf-8?B?c00yYk5XRU8vR1BqTXo0TmtKeUtydlQ1WUhyY254ejRjUFExN2N4cytPTlVx?=
 =?utf-8?B?T1c3TkVlMzU3cnRDeU10Y28vTFNSOFhtZVYrVDA1eUJ6WHI0LzZTUzh3OURR?=
 =?utf-8?B?R0xOOVlvREhwdm93MjdUbjlveEgzWVNCMUFWUzdhNzQ0eGdWaG83RkREdkFN?=
 =?utf-8?B?SDVDNzJHK2QzRWJGeXRoVlVxSlRJOWtlcU5IaDZuOUgxc3pUelhYZUNZbDZr?=
 =?utf-8?B?ano4REx4eUtkdmRFMUNReHMyL2QzR3ZiajVZQjhjbHNLbURSV2x3UTZLanRa?=
 =?utf-8?B?WUkxalVLd2xQUVVJY1VjY2F6UzliNnFvbmdtdzVoMDdFaFdicW5BSmtFYzlw?=
 =?utf-8?B?eU05ZGhVMEx0OURxUnVSTlVuYTR4cVZWajlJNGtQYS9lUlZYUFV1SERkVytz?=
 =?utf-8?B?a2VLRUQ4UVR5Mi9LemZpU25FRzEvNEVERTNwRlBZckpGM0IyYVhHUnhKMTFt?=
 =?utf-8?B?eHJGNGYzcTRXMWl0NTFrS1RVZVFCVHFKSkozUktUSkEvM21JNU1NZDEyNUtl?=
 =?utf-8?B?dUdoMXpyS3Z1UDlrcE5YYXgzUms0U3lTYXZQRnVQemJQNTJxdXNoZXdnVEVQ?=
 =?utf-8?B?a1pOakorQWdvVVpEZFp1NlM1ODlhQ0ovZUlhNjlKS2NtQzlSMmFWSnpheEtz?=
 =?utf-8?B?Z3l2engydmJMdk1ma2dFT0FqL09wdi9zY0l3eTNXZnMwVEQzZnIwSDcrWnI0?=
 =?utf-8?B?Q0tsbTYrTkJNbHVxeVBpcE0xUmFodGhTZEh5MElvTFZLU3hiOThmaGhXMWp3?=
 =?utf-8?B?eVQzNDBFR0k1WmRvS0NSVzVUUUhqQk5VeHZuZVJreXdXdnVacWVEUTlRSDFO?=
 =?utf-8?B?dnkvUldDK24xSzlyWUM5RWRqYmpna1pVdGI5eG5SczJQQ0ZRQkFSLzBKWjlu?=
 =?utf-8?B?c04wSUVIbksyL0Y5bUhxSmQwak8xYjRDZmxrL2c3bittYks2amFZY0EwSmtB?=
 =?utf-8?B?eUV0OCtieXVPUHo1R1ZXN0FDY3ZMRklFUVljNFpTb3AyZlNUZFZycHIvYUVJ?=
 =?utf-8?B?R1BPTVBtY3poaFVDZk40NkZjMDNwdHdQdnQzSUgrN3U5blFGUTBXVkEvaFRl?=
 =?utf-8?B?WlFjcGJVb3ZKejNkS2doVy82VHBza1BLSkhGSDNZQWlGK0xCaHRUTTlPYXdH?=
 =?utf-8?B?Z0k4bTBtL1czQjlXdUtuazBKRHNYYW12Q0JXZU9UMWZVSjkwdmFjanJnQlhr?=
 =?utf-8?B?U0hVcTl0d2x4UUFFWnA2ME5LNkR2bExvR0NGMm5tUnl2amVwcjhvbWxhM0Zj?=
 =?utf-8?B?K3JmSGIxSU9zamE0bjlKNVdvWnYxb2dSYlZMUDNFZDdkNmRhZXlQNkpyWWJp?=
 =?utf-8?B?VTFuNTAyaE5FMHQ2eGtRMnh2RFdvY1NGUTdvNEVNdk5IV3ozTFJuU29Xa2lX?=
 =?utf-8?B?NTVaSUNaMloxaWgralZLdXhmUjlDUW10Ylh4Q2JhMDMrVkhSemRBcmZ3NUhq?=
 =?utf-8?Q?Td3iWg9UAJLLTtRfJtFcVKlzl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6c0376-38f1-477b-e613-08dda2e05a4b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 20:51:02.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdhX+IZK/wjajjnhG/QIQXCi/R24Chm7ZjrLfWSe/atvPi4tEsaX557DrTPc6Wlaq1RVO1aB/5F75qJ47okY/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16

Hi Boqun and Paul,

On 6/3/2025 4:44 PM, Boqun Feng wrote:
> On Tue, Jun 03, 2025 at 01:01:19PM -0700, Paul E. McKenney wrote:
>> Hello!
>>
>> From what I can see, when I start testing v6.16-rc1, I will need to pull
>> in the following commits and patches into my pile in my -rcu "dev" branch:
>>
>> 6c59a7c789f0 ("rcutorture: Add tests for SRCU up/down reader primitives")
>> 0a67dd132d1d ("rcutorture: Pull rcu_torture_updown() loop body into new function")
>> c27d0d38f2ca ("rcutorture: Complain if an ->up_read() is delayed more than 10 seconds")
>> 3b4863a42139 ("rcutorture: Check for ->up_read() without matching ->down_read()")

Paul and this one too? I dropped it from both my PR and my rcu/dev branch:
Subject: [PATCH 5/5] rcutorture: Fix rcutorture_one_extend_check() splat in RT

>>
>> The above commits must be ordered after this -rcu "dev" commit:
>>
>> db950fccd45a ("rcutorture: Make rcutorture_one_extend_check() account for hardirq")
>> 	Tested-by: kernel test robot <oliver.sang@intel.com>
>>
>> There might be a few conflicts to resolve.  ;-)
>>
>> I need to drop the following commits because they are already in mainline
>> (thank you, Joel!):
>>
>> 604d70035eaf ("torture: Check for "Call trace:" as well as "Call Trace:")
>> 2e5158390089 ("rcutorture: Reduce TREE01 CPU overcommit")
>> 90c0254a6d48 ("rcutorture: Remove MAXSMP and CPUMASK_OFFSTACK from TREE01")
>>
>> Anything else?
>>
> 
> Hmm... we didn't sync Joel's rcu/dev to the rcu repo, did we? I believe
> Joel had a few patches queued in the rcu/dev of his repo:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git rcu/dev
> 
> , which should be handed over to the next guy.
> 
> These are the commmits:
> 
> ac05b397cb2b ("rcutorture: Start rcu_torture_writer() after rcu_torture_reader()")
> 006bc5216bd0 ("rcutorture: Print only one rtort_pipe_count splat")
> af97b7685824 ("rcutorture: Check for no up/down readers at task level")
> 2baf873c6c2b ("torture: Suppress torture.sh "Zero time" messages for disabled tests")
> b0fb3ada8fb0 ("rcu: Robustify rcu_is_cpu_rrupt_from_idle()")
> e2cf1ccc99a3 ("rcu/exp: Warn on CPU lagging for too long within hotplug IPI's blindspot")
> e8b1ec78cf81 ("rcu/exp: Warn on QS requested on dying CPU")
> b4783fc5ab1f ("rcu/exp: Remove needless CPU up quiescent state report")
> a7e008d32033 ("rcu/exp: Remove confusing needless full barrier on task unblock")
> 6e8a70ce57b6 ("rcu/exp: Protect against early QS report")
> 
> @Joel, do you want me to sync this rcu/dev branch to the rcu repo then?
Yes Boqun, go ahead and sync it with rcu's /dev. Thanks.

Also how do I get added to access the RCU tree?

thanks,

 - Joel


