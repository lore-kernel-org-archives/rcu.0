Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62A3D9DC5;
	Thu, 19 Mar 2026 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951715; cv=fail; b=oizbibMpUIS2HpBdslT+T9Cf8xB17QlAqStBpZSd6u+1FfYZxIJ3444SGn/yUwTkFkopu0mOyzIeB7C1uFas/aGqgjLwqm72JyvOHHn1JkGGp9Ko61kXIGKzrThEaxT45BURiZ0rgR2C4Wyqkf0q1Zmw6cvAcSocv8OxWha6HGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951715; c=relaxed/simple;
	bh=+ysVeigIISXiV0AsdnhWx3/pnvJCnnBDE4tsdRRUSAM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kj2r5myQY0yqSmjA5PJpqBBNrFVc5epDB70kAYppzkB+HrFwqub/0obOZpyft6zxBMWO2v2rM1r7D1ZzON1MC5b7BZmb4rYN1M05o/E9AIQFa4mem9viZt+YH6Wh/y4kKTDk9y/wQbV/fmdQyeryZJs5i4dsFaP8S8Kolu3uctc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uiKDM3NX; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uiKDM3NX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WevOwnJbGqDamtGtTaWMFepZXmy1VoEkJfDW8MfZTzduqf9Zs7q8rxxEzqUSTWx001i71WgYit3h4R3LoN6nd/tUiEUAaTv3XWIFe6JPQeBHhVJ0kpHfTqCqaZXzNqsEgjX6ILnQ3a0v2N3BcrNB5Bz45NYvG0HDJxZYGnHv8eTQB3wzHMoxrXEbVygNgEn1cI/+vWDpvO44SNmY6y6CyMnFxt0nNTxk26V3k2UUPerwmoVWmQl5M1ourdH8PSi0XTLFm7vrjvxIFJNRXl60dE66WkE3v50PJSrUSO79C9HeN6KoM9UZn22H/UtGzz4bifSNRJj2bJ8XP2pPaNLvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnySmA9YDY9isjdHzW/Hkznbfl8ZMK7J2TVgCddvAuU=;
 b=l4vN0ZTNGGZ3kuxC3Du7E1JKnQmaLD3p1/WnhInvI8E/7wkVhIGmcnIhEMCQhaquAOkMGrROpyatAd06XGDRFM+T6th+Cv9cpo7gyDJiiBMuz3LK6YJo/nj8wNtxADVI6ZQ4pyZBHBipYMVF3w4+saaoANR4V7Fr4l5Dy+dq2705uzRkDEuT5KWoD2LAeJPuWnVv8IhzYuw2nJGB8iwJj06sTMwOqO6OyLoEzLaDsefrmMlRHaQFeeoxlDhyCPABLEU30kaPLclR4qnVftrDqqqQbQeSYQeD4vUM8ta+VR85QKM5AfCHKRvspl8XMLlyZnaKNJqcADwNY2T1ZaERNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnySmA9YDY9isjdHzW/Hkznbfl8ZMK7J2TVgCddvAuU=;
 b=uiKDM3NXKzD7iYQlJeI7nNUGjrZI0bj7dnvqVUrTH2igfpR5yTtIHbrZe1BohqIpnOkq1ckj+jG8fJ0qgW4H7Gum8vUp+RwAC/1BH76kez3SWF7h+IXlKQh6f+6Rayv66P90+9tb2RPeMhNZuTLXg4iYRKw/M3CZLk2gcyOQBlTCLJ5GcpPbyHygnXMZ7JTP6u4OBLLZ6nXYD2TQ6us2JkKmj37aPcr1uQM7C7iDvKsmEj0tGPS3i0h3Q8n457cR8U+aA/LfZo/uw33h7D6SfmylAQFDSo0wiCCiONUdlazZupTypnq1mpuz2cuDEstm0zrG2fD15+IEU8zciltVWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Thu, 19 Mar 2026 20:21:48 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 20:21:48 +0000
Message-ID: <89763fcd-3710-49a0-91ca-cd923b47fc1e@nvidia.com>
Date: Thu, 19 Mar 2026 16:21:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
To: Boqun Feng <boqun@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, paulmck@kernel.org,
 frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
 boqun.feng@gmail.com, rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>
References: <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local> <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de> <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de> <abwo0I_mu94t5Ews@tardis.local>
 <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>
 <abwyGtG7hDpd8vBN@tardis.local>
 <CAP01T75S-NMgB=s_0jqq52xRwe1cQ29DzD33eeqUZHM3cSb=oA@mail.gmail.com>
 <abxZEE4SAMkNEleq@tardis.local>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <abxZEE4SAMkNEleq@tardis.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::14) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: eefe296e-64cc-4d26-eb13-08de85f52563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	k0dqbD1KNMGffBvH/CbTeEMAHuT1I8uR8/SVGubO8PpSShITNOFdPs2LQqrKgCtfO8Tq40O5y9kBgypqmM1ubTtmgaw2U5LAFztZZgHiBQ0yHaE3S76mvGG11DL6kGC3GCVi4dClQpjcv0QdJhewVt8fuynVu/aCkA1nK78qq+lkvSLgRwXLofxg0/nEdbt7S6ZweB2UcVeXeQBeCFcH9ehKqqqCpwcHyX2ZoMV0SjP/R3BJrNk9rYOGE4DnMxbMOcPSFHT/zig2NHycT80yMKwReo2Nd3vNz0T4v5l+iaH921n0HzJU5cth3tLReygj1oyEYJiC/7KKQ1KyP6zMK1KG95Lf7wd0QPxF/mx0ial/5BLbUkjuihT5QiFANsEHEd76aKZPJDCfVP6AjsqAdSMATrhZtDHFCav407SAjmWzFl+U/bxAMRMu0bFG53JuaR+ekaPbrQOl6yUxQcB2aBd6/4PcheowluuUxu7F20dYOdsCwEba6gBHk9ORQAai107+U3ZLUGb8dzsh1r8K6zC7KZ/6kKTGKmUWITjEEBvthKAA/3smn+yZFex2onPep81QV+qEeGbTf344gZoETT86HcdDd9Ickfl52BvE+lwZNhSvklEFwK+J0VDdM+9cxnkjbLLsbAja2V7m1b70k9Hqnu/NN68MVifIijdO7WcjwkakJE1Co+LYPM0QOl5bFSkaOAQFbbkD1RNTyyp5jmCImljdaqF8gBxoYx2fScE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmJQMXRJZ25HM2Q1K2FvTnlza0JYSkoxUHVFRjhLZ2t4S0VPRTFDUXRFTk8y?=
 =?utf-8?B?TGRaam1xV2VzMms0RCswTU5aWlVuS0djc2ZER0phcVNrbzNKZ2tWcUE2YVdY?=
 =?utf-8?B?QUo1MzRESW9jZXdLRTZUdmNyczQrQ25HemluVGd5OGxhT25XUmQydFFsTlcx?=
 =?utf-8?B?Y1YrWXdPVlpaS09ySi9ZT0FKRmlvMWJPOFk1QzNRNC81Q0JKR0ZOWW9peWlR?=
 =?utf-8?B?TzZhVlZsa0R6Mnhpa0xNUmQwTnM5WVdaYldibDNMRGhqSWF1b2FrN0VMbXk0?=
 =?utf-8?B?c29sOTYwMFFyQmlTM0tFQlB6RDZnTXJFL2grYmNESHNyeU5FRnpLTTBCMlZL?=
 =?utf-8?B?dlhpMklZL1NPdWFieW5jSGlZWU1hSWFnM29EU0VZaGRwZHlWNTE2ZUlTQ1JM?=
 =?utf-8?B?a2N6dnFKY2lHbkxRajlHMWZKd2hMUnFSRmpXdTBFNUVVQm94Mzk0S3VHdHdv?=
 =?utf-8?B?Tm1KTEN5eVJrYVplditNTHcwYXQ4ckxNSnYvUkJ1eXVEVG5CeThlcmJLekI5?=
 =?utf-8?B?N0pwSENmMVNrdmxLamlzQ2g1bFlUQUcvT29HQ3Z1cEVUSHZpMVVHTXZER1F6?=
 =?utf-8?B?SXI3ZlpHenY3SDlDQVhEbXFIbEI1Y1VTTVViNmNPdkRqRVFvcU5EZUtxYktC?=
 =?utf-8?B?cmhWRzhIMnVtaVlFcjJHNnEza3JRQnBFQjBoT0JrTFdLWlhheHNOUStKWWN1?=
 =?utf-8?B?K1UrT3dZZzZjbm9ZT2d2U1kyVSszZ2MyRXk5czVQbnN1N05tRDNMamo3NVo1?=
 =?utf-8?B?TnEyMEQ2L3ArMmVieXVpRW5oRkEraTZ2VERFYlZIQi9WY3lCUUhvMTh0eFVk?=
 =?utf-8?B?bXpvbVBDVTQwUC94aWt0NG9HZWRERkkyaTdJNHBBVXEvSU9ZUTNpalVEY0pV?=
 =?utf-8?B?Y21mOElyUXlSSGhrdlJ3VGlPNEViTkJWZjVlRWYrUU5yQzl1UW5qL0FaUU5o?=
 =?utf-8?B?Z0dZZXdiQ21Xa2JDMDZNVDFhV3ZmWEJxejFOYllYM1BuSkNvaXErbmZFcVNu?=
 =?utf-8?B?M2ZlSk9qQzFGUjRBcUFISGlBcXVVaktjYUVObDYrc1E1MTZmaCs2UWJXZEd3?=
 =?utf-8?B?VHAwTTFOaEVNUGZHbHpOcEpKZHBWTEFmeEdJMUJkTlFFcG1Pd055TUoxRFNz?=
 =?utf-8?B?Zm0vTGJSc1l0WmI0Y09SQUVISlYrOEY3VlZ2OE9sR2xNRSs3cEtScS93Qlk2?=
 =?utf-8?B?VGxYeHpPQzB2MlBrTXZUcWRoaW5MRlQvTmMwb2EyVTBUOStyUjArWUo5eU8z?=
 =?utf-8?B?YU5SaTkyeHVBNTZNNE5zR2RWMHIyVG8wc3pLaVNpOXZIQmdsWUdqdm9oR2dj?=
 =?utf-8?B?YTdOc0YvTndNcmwxckRxRGZDSldaa1VIeGxxaW8vYlk5eHc2cXp1SDJBMEVo?=
 =?utf-8?B?SjZKem5PeWJNL2xiYkNSY3llZE5CajZMZVF1NkdyY1VDTlBld1dQTkkwclFI?=
 =?utf-8?B?RERLMktnTmdESUVoWXJhNVBWUkpXZUJ2VnhzU0dFOTkrWDY0eUpCSTdvdzBX?=
 =?utf-8?B?R0RkV2hZRVArb1hwaHhvdEw3SHFnMFVUeHB6clJIWCtBWHJQTE1OVDhJbFo0?=
 =?utf-8?B?RWYvZTVJbGZZc1dXcmNOOElQVy8zOHJqdXd6aEFsSi9CSnoyRHNSa2RoWDFk?=
 =?utf-8?B?MGlRYzlXUXdDQS8zbXdoZzBPODB4VDluQmkrSkRuZldzSk4rdTllbm4wRDcv?=
 =?utf-8?B?VTN3WThML2ppbGt2bTlDei9QUUVjMFNqVWZYVDV3cDkvZGQrWlJycThYSmN6?=
 =?utf-8?B?SjZDenE0TG5taVJOR25CVUVBSXFwbUxsY3RIQlZieXFCbllwVUlUWkd2UGYr?=
 =?utf-8?B?TTU2UU4vNHJTQmVsbUZ2OTVEWU5nUFg2cHhuaG90eHVIeExhT2dFdTVLLzJV?=
 =?utf-8?B?UWk0a0pVVlNsZWRWa2xQTUtFbWkrQm5yd2Fpb2NWc0Q0WjJLeDNEZ3lDK1hX?=
 =?utf-8?B?ejAyM0ZacWdGNEpOREg2cXEvRzBON1AwVVZDMFMzelg5VjVvRmFpMzlhb3FP?=
 =?utf-8?B?U1BvdU1MSGxTZkhwdk5UZ280R3kyMTBFZ0dLVFlqVzBlNWtDWE4vaURwTXNw?=
 =?utf-8?B?eFhEV3RJNTk2Q2w5cTd5M2NxYVlHRDlrS2N3bStmMlkrVmFsYjdFTWlYUngz?=
 =?utf-8?B?VkwvOUE0SSt2L0R0UGdEY09DSGpCWkVIZkFic1dMdDNPZ3FySytrU0E0RUhZ?=
 =?utf-8?B?WEJVWDFMWEs1dE9IWXppaXI3U2RYc3dzS3BhUW9zZkIzSnpOK3B5dWk4OG51?=
 =?utf-8?B?WEo4aTlKQ3BtYk1mejBZSUNWb1QvWktJTjJFMVd0TzhRNGpPQVFDRlZlTGVD?=
 =?utf-8?B?ZExjOW5IZDdzSjlaRkNkSm1pRkZWZ0sxWGxSeTYvSmhzam53enBYZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefe296e-64cc-4d26-eb13-08de85f52563
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 20:21:47.7301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ct2un79GeBfHG05xFYchX5YNNIifPxePtNGlG/GESotBioiysVqaAAqTnGjnOnRHGq2P1H8vCm0zc8iBcLdtNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676



On 3/19/2026 4:14 PM, Boqun Feng wrote:
> On Thu, Mar 19, 2026 at 07:41:06PM +0100, Kumar Kartikeya Dwivedi wrote:
>> On Thu, 19 Mar 2026 at 18:27, Boqun Feng <boqun@kernel.org> wrote:
>>>
>>> On Thu, Mar 19, 2026 at 05:59:40PM +0100, Kumar Kartikeya Dwivedi wrote:
>>>> On Thu, 19 Mar 2026 at 17:48, Boqun Feng <boqun@kernel.org> wrote:
>>>>>
>>>>> On Thu, Mar 19, 2026 at 05:33:50PM +0100, Sebastian Andrzej Siewior wrote:
>>>>>> On 2026-03-19 09:27:59 [-0700], Boqun Feng wrote:
>>>>>>> On Thu, Mar 19, 2026 at 10:03:15AM +0100, Sebastian Andrzej Siewior wrote:
>>>>>>>> Please just use the queue_delayed_work() with a delay >0.
>>>>>>>>
>>>>>>>
>>>>>>> That doesn't work since queue_delayed_work() with a positive delay will
>>>>>>> still acquire timer base lock, and we can have BPF instrument with timer
>>>>>>> base lock held i.e. calling call_srcu() with timer base lock.
>>>>>>>
>>>>>>> irq_work on the other hand doesn't use any locking.
>>>>>>
>>>>>> Could we please restrict BPF somehow so it does roam free? It is
>>>>>> absolutely awful to have irq_work() in call_srcu() just because it
>>>>>> might acquire locks.
>>>>>>
>>>>>
>>>>> I agree it's not RCU's fault ;-)
>>>>>
>>>>> I guess it'll be difficult to restrict BPF, however maybe BPF can call
>>>>> call_srcu() in irq_work instead? Or a more systematic defer mechanism
>>>>> that allows BPF to defer any lock holding functions to a different
>>>>> context. (We have a similar issue that BPF cannot call kfree_rcu() in
>>>>> some cases IIRC).
>>>>>
>>>>> But we need to fix this in v7.0, so this short-term fix is still needed.
>>>>>
>>>>
>>>> I don't think this is an option, even longer term. We already do it
>>>> when it's incorrect to invoke call_rcu() or any other API in a
>>>> specific context (e.g., NMI, where we punt it using irq_work).
>>>> However, the case reported in this thread is different. It was an
>>>> existing user which worked fine before but got broken now. We were
>>>> using call_rcu_tasks_trace() just fine in scx callbacks where rq->lock
>>>> is held before, so the conversion underneath to call_srcu() should
>>>> continue to remain transparent in this respect.
>>>>
>>>
>>> I'm not sure that's a real argument here, kernel doesn't have a stable
>>> internal API, which allows developers to refactor the code into a saner
>>> way. There are currently multiple issues that suggest we may need a
>>> defer mechanism for BPF core, and if it makes the code more easier to
>>> reason about then why not? Think about it like a process that we learn
>>> about all the defer patterns that BPF currently needs and wrap them in a
>>> nice and maintainable way.
>>
>> This is all right in theory, but I don't understand how your
>> theoretical deferral mechanism for BPF will help here in the case
>> we're discussing, or is even appealing.
>>
>> How do we decide when to defer? Will we annotate all locks that can be
>> held by RCU internals to be able to check if they are held (on the
>> current cpu, which is non-trivial except by maintaining a held lock
>> table, testing the locked bit is too conservative), and then deferring
>> the call_srcu() from the caller in BPF? What if you gain new locks? It
>> doesn't seem practical to me. Plus it pushes the burden of detection
>> and deferral to the caller, making everything more complicated and
>> error-prone.
>>
> 
> My suggestion would be: deferring all call_srcu()s that in BPF
> core. [...]

isn't one of the issues is that BPF is using call_rcu_tasks_trace() which is now
internally using call_srcu? So whether other parts of BPF use call_srcu() or
not, the issue still stands AFAICS.

I think we have to fix RCU tasks trace, one way or the other.

Or did I miss something?

thanks,

--
Joel Fernandes



