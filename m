Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E9937C109;
	Sat, 18 Jul 2026 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784395073; cv=fail; b=kppYzeT5eO6FRhPzw+jOm+jIVdOV8QCWUMKy8L0Bu4DHrWJOEjB4xJMutyubAEp1CSZl2vRbP3Ojgx49io0YbPqsMgOal+fezhdbtbreTs31tTaSlT/kC6XrnYqszfYoR/rfWYF8XI6sL5qHD6LhIrtQrdYXTBc2oXrCMIqxnpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784395073; c=relaxed/simple;
	bh=rqrN2XD1Pm1pXFxweCoN/IICahZJE9sX3EIJMgGtbd4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i5l/smglnP84QNhmTcuUf1FrYZScZgmMd02ErA/nUzT6LTEE0VcnrGEntXKHFcmZetfN+0ClxlK6ThpabSoQEGL90UAWMGIFe0rG/o7gIuX4Sz6+XblbXAJrBcf9fKvrIwwj9Pw3hsyzIfvwk44VdqKXoaYY59E5vyhTZFynsgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FZUnL3r1; arc=fail smtp.client-ip=40.93.196.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FZUnL3r1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNpv99RXI2UgEqDZN/CmEMRryFua2St5w5FOjpspcYz2kE1JFhYWrIrchPbPErrrKEt3ori65FzygT2z/+XZt3NnjRq4tU3QQlOsCw+GzoDq02lWt4JXHRv4XJWLv3d9ljeP6ZdsRdujIwrMIs7/bLE2TyPF4opDU3F5EBn9VQgv4dk5Lyx1MLZ+s3Nt7+ta+NjdHClulYL2do0EbISk35Q/u2bO+/5LUTqgoZJEDk0QVOickI+PLtr86trAKLv13jCEEcKXI0ry3SJRY4NZHrBOr6KH3A4Sr1OSKQhVvs6LJCxTwwy897ZrwDfodNjbDIuLONHdpvPqMgBYS0b4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53P5JQoaYKGtDkNFe+9yjI3abVvbKmywQRXl6odj77s=;
 b=dywWIdsHXHPSeREmQYzhucwwlc0PTlz5Z8A9iZLYfaVplP5ipPy+0dXik7Re8J6Svp90t5WXTrWPtSJaYYu7AQZKLMDZBAm8Za2lNe546ruKbbj6YfaW9/OerC3oeFKJVdS+GzaKQ9wQzoJW10iiJ+OQuznpBDso/aSLmwiZzFXKYk2RuID/F4YfhirCVaZCrizEn0Ynl++3zPKEa1+2aVJaL/0ZxzlnK4e5kY21ZIUEZ4504FQQQRlwQz9DZtS4sTHFMWmqqHMCMCi6KX7nhg0ZKWXT6BHw+12tKVe2AuZ8mVvTQtOJ3qCf3saZ4IK6vWDUHxc3Yc02Ol1bjsyNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53P5JQoaYKGtDkNFe+9yjI3abVvbKmywQRXl6odj77s=;
 b=FZUnL3r1uUgVMsOMo3AF83mB+u7VWYqGQfPGmU18VDIqk+v9uOj+V0x8dsP/7KefESpr7RgUcntLhN2teo9t0i10IjIBxRDk/Iffz30sB574IfzxFza/PPxdAVtQgSgzvktK5u0rHybgau0vRKQujjKB6eKmnpmJeYHd0A6ihs+zChitQ6/GMC3vDWirn/qbWEN+pOixqqNdoAz3GIHzdqxldjtd6eWkN2XvhKgbTJS//5ITCYmA1xTpPboqyIP0Vsrub9LG3lFSVkkcHJx5K3OXSMeptnsiGNVErc2cZKA5XaNgsnNojAxuYecemJAt1Bd1tdK/cgBFJdfcbgXBlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.13; Sat, 18 Jul 2026 17:17:47 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 17:17:47 +0000
Message-ID: <79343d8d-230b-4562-b0e0-bd797e11727f@nvidia.com>
Date: Sat, 18 Jul 2026 13:17:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] scftorture: Make invoker threads actually wait for
 all threads to start
To: linux-kernel@vger.kernel.org, RCU <rcu@vger.kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>
References: <20260718171539.3781595-1-joelagnelf@nvidia.com>
 <20260718171539.3781595-7-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260718171539.3781595-7-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:208:239::26) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: afda9a13-f505-4907-1b14-08dee4f07d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|4143699003|10067099003|56012099006|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	y1+haYQ5DW8F3clotXjG05vU9sB3y7DcQkOwJTrbKW7ANXi/VyOtAm+66pKEECA6kv5f73Gv4T6uyWto8VVFm2Wu8WYqHk+xHcW78Jhe+mfrz2jvNSg1pi0vmOlDDl/lXjTAzgB5R2YOSSv1xTHi+kygTooOy1cktXNn5wEqL0uMmV94zVnjR9lYOFL0Bir2vJ6+816Scb/4Qwh6Nlnci7DQFhJ7uth8frg7eXteLueWEEUAPxVfLIrBy0vRfhMA0VlFpo5Jim3O1iNRjAavYhAqViL4aMJv0An/1VZHW05S+JaE9+t7NEtetTQBoghHO8/3XxwjRDuVMa10CUiIE5kz324LbxYx3uc2sM/tSU+kI2tcXV0Wk+IY4qS5HnXKCRRN2NNbgzjdAGsx9trf+EUgzsV3R8mLuXhbvzxr124gKyj3UaS0UPDE9i9eofa6RY3PPsljpbLLRV6cLcLvqIm9f86wGcnsKEVrtXcJhuuB3kBf4hea61RgXQRgslg9fob0AFT6ZRS5Vp20cHOC6r1qYEU9fdbK/ahQKoz9J0HU4OijsCK3uTWQADZw9zw8p9S/o/yPTsIQ8VzTlam2K2rpylilE7cqLORUg57sHz+h2+EbAFG56ipRIO/4CaFVtEevG/TpwcNzNhDSxKCkUBJuxQnnxxnMElTxQ8gwA6g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M05ydXMvajFITUc3dkExd2J2R3RuVEc1Nzl2dE5JY3VBeEYvK093a1Q0SFBN?=
 =?utf-8?B?SVlZN09UMU9GZ2xkcTNlblpibTYyV3NsL0pSR09HWTUyQTNDeDRTQTBIbkw3?=
 =?utf-8?B?Yit0RGh4c0lCcFRHTU5waTlsa1N6TVMyMWxXNWQ2VDVTZkFSbzhneVZiTDVL?=
 =?utf-8?B?K2tyWUhQd3N4K3N0VmQzN2dPNFY4TlNJZ00zUDV3NGMrR0lrMGRrbzl3d1Yy?=
 =?utf-8?B?ejBISHV1L3Y3ZzNyNTg3MTIyVDZlem1MRnRwcnptaWJ3UE9OVFRaSmgxTjFl?=
 =?utf-8?B?YXo4SWtwRDI3WTM1YWlwYTNZY1FKUTczSjk0RHRCaWl6dlAvb1ZycDJqV1o1?=
 =?utf-8?B?YTRXNk5qK1I5c0JPOW1HZko1U05rM2xiejNvckwvZVI5MmRsNGl3elI0Sm9p?=
 =?utf-8?B?Rlh5NlpFVDZxQ3hXVXE0aFplWmNtejNEejRMMmMvRnFINXlIOERnWEhMZ2wr?=
 =?utf-8?B?M1JLZVlLb3dNUFhhZzkrc2lqS05XaXNXOHFxUnhUZXF0dmtJZkdUejhwV3lk?=
 =?utf-8?B?RXlQaG9YQ2pVYVpIRm9jV05WWFMwQnFFOG1aSlZjWEFIb2xKSWhqdnhVbmxn?=
 =?utf-8?B?TFE4b0xlY0h2c3dpZXBoVXc0bWJiNXJoci9JUllUR3RreHZhM3hFaWlxMjJR?=
 =?utf-8?B?NDN3cVpZWlpkOUdiVG5NbHgySXJKR24vYTVKaVFGOVpGdWYxeUoyRkpWSEhZ?=
 =?utf-8?B?TWpWM0FWdDlDV0JrRUU0WTkvQ3E1WmNyOUhNRndjZzJyelpUNFFla1QybEZW?=
 =?utf-8?B?NWVvYmlkeXRpU2xyYTBKekdoaEdtNjZzVitLb1NyeUdDYWQwTE1hRzd3UTZy?=
 =?utf-8?B?S2FocVpHa0pFbVR3V0QvU2hzd1Vyd3FvZU5UNDNuTWxQR0N2ZFZLeldvQ2Z0?=
 =?utf-8?B?c2V3ZHJnMk03QUNvcUdsQTFCczQzR1VHUUd0d3g3YTMwcTNWK05KYmZkaTJW?=
 =?utf-8?B?SE5GS3NaTnh5T0tWL2ZuOTJGMlZKa1dvLzdhNXZHMTZ6bWZvU0J1N0UwQktS?=
 =?utf-8?B?SE8xTmNBYmdyNVJuMXpzVjg0QXpPZnpJQ0VsUWtRTXB2L040YnI0V1V0MGNn?=
 =?utf-8?B?MlJDaXFoejcvSnRseTNWUzBnRnNKUVo4cTVZWnlRK1A5V2JxYkQyQ0JWT1Y4?=
 =?utf-8?B?MHpONXVwYmk4d3Nrbm1rV3F0TnFHcFRscnBvdGREVDZHZERNTHh0NzAvc0JX?=
 =?utf-8?B?L0dRd1EwOXBDUSt1SkYvZTdHOVdzRzVkTmtmOGNLaUhtOWwzNkJxWUFONFVy?=
 =?utf-8?B?MWpTK2hhMWFocFhSME5TdUZGeFlGNFRHSUE0RUpoWm81MEtVYUJ2ai9jT20z?=
 =?utf-8?B?RXdwb0k5aGtnWU15QmV6MjVheEI3cmMyaVJqdHpxeWFxTUdkbmhRbUhKa294?=
 =?utf-8?B?QmpNbHV3L1hwdXBGcXA3a1FWcVp1NlBWUzV5aVY1TUk4U1diK3ZrUzI5bTJt?=
 =?utf-8?B?VmFId0tjMEJFWmxtSE9vY1pjSHJGM0FRS2UwSlJBVTF6TGZaMTlIdWtOTjZP?=
 =?utf-8?B?TjdOSEtML3N6eHUrVjdTcFdIYnF6WlpFZzVPT25SQmV0K3N3d3pkMjhHWXJB?=
 =?utf-8?B?QndmVTI3NmZxVjNYd3ZIb2dvMEFacCtYdXpIYm9ZdTJWWE81K0luQTNtdFMz?=
 =?utf-8?B?bndLWW5JT3RXMjkzTkU3NGwrTzF1dGFoUEhQY0dZaUFGNitsOGR4L01zZHd0?=
 =?utf-8?B?UVNDb1hFQUxNRW00WmxSbnoweHJoNkV4SXpxS0U2N0ZGaE8zYldmVTJDYVZn?=
 =?utf-8?B?UndjSjBQWnBoZWc4SUkyVHR5Q3F3dVhnOUk1YTFBd3MzdzRRREZvZk9nNzJm?=
 =?utf-8?B?YnlxM1FsV0VZd2hFYTJjdVBrdWptT1g0M1hNb3R0WkFoYlBJN3EvOVBtU1lQ?=
 =?utf-8?B?OGFLekdjb3BFOHNFMFJpMzZXYUlLZngyd1I1NUhSYkRqanZaTS8rdGlNMVpO?=
 =?utf-8?B?ZXMzRzZ6WG5BNGE5ZGRreTk1S2RUenAwNDJDajRhQ213QUxKQVBuZHI3L1dF?=
 =?utf-8?B?SjBISzhlVS9nRFh3Qzd1Tzl5Y2hWT20rL2NoWGhOaExBQjBERVpCK0M1aGV0?=
 =?utf-8?B?dEZoMEUzT0VRMmxFeEZzaUNNdTQ2Ny84U3MwKzlWZVdRbVE1MFVTRFArNkJ4?=
 =?utf-8?B?cjgvd2RMR2xKKzNUamRlQ01OeTlHVkdJK2lTZjNUUXEyaG84VU52bTU1NVZ4?=
 =?utf-8?B?RkZOdnpYbkJNd0lQeUp4NUdvdUdOS2VFOVFEZHNzb1dTS0hqUHM0eG9POVJO?=
 =?utf-8?B?aU9YZU9mUnM5azlsWUpoaERVRnhuVzFXRlZGNVJ4UCs4RkZMcmxZNVN2N3V2?=
 =?utf-8?B?Yi8xRUJtaGtOOE5LeXZhcFJxYjA5d21jU0c1MWZPeW1qSUliWEhKZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afda9a13-f505-4907-1b14-08dee4f07d0b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 17:17:47.5476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlvEV1KxBrb4XZjfFvqaMa8HlvvEzY8QuY52o4+nhCO6tkPzCucoytMTswcGTiE1r72XR1O5ybwe/9/F+/rwgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

Some reason my scripting missed rcu list for these last 2 patches. But they
are on the lkml list :) sorry.

Adding back rcu@.

On 7/18/2026 1:15 PM, Joel Fernandes wrote:
> Each scftorture_invoker() thread decrements n_started, which is
> initialized to the number of threads, and is then supposed to wait
> until all of its siblings have also checked in before starting the
> test proper.  However, the wait loop is guarded by
> !atomic_dec_return(&n_started), which is true only for the final
> thread to arrive, and by then n_started is already zero, so the
> final thread does not wait either.  The side-effect (possibly positive)
> is that no thread ever waits and the start-synchronization barrier is
> dead code, with early threads beginning to hammer smp_call_function*()
> while later threads are still being spawned.
> 
> Invert the test so that every thread other than the last spins until
> n_started reaches zero, making the threads start testing together as
> intended.  The existing torture_must_stop() check in the wait loop
> continues to bound the wait during shutdown.
> 
> We can also drop the spinning entirely if the intent is to leave it as
> dead code, however for the current intent, this patches fixes the code.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/scftorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/scftorture.c b/kernel/scftorture.c
> index ffd6c83732ee..392df1b4d4ed 100644
> --- a/kernel/scftorture.c
> +++ b/kernel/scftorture.c
> @@ -497,7 +497,7 @@ static int scftorture_invoker(void *arg)
>  		  "%s: Wanted CPU %d, running on %d, nr_cpu_ids = %d\n",
>  		  __func__, scfp->cpu, curcpu, nr_cpu_ids);
>  
> -	if (!atomic_dec_return(&n_started))
> +	if (atomic_dec_return(&n_started))
>  		while (atomic_read_acquire(&n_started)) {
>  			if (torture_must_stop()) {
>  				VERBOSE_SCFTORTOUT("scftorture_invoker %d ended before starting", scfp->cpu);

