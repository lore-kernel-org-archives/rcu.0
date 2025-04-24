Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC028CF48
	for <rcu@vger.kernel.org>; Thu, 24 Apr 2025 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518506; cv=fail; b=Pig1mWMivgDXNUyqTs7pwk1NU/ot4S4NbXgTsscqWFvPwhGUSwK+bde4E8IlgE0Ydc0MNLeXQ7EmWVasV/ezHYRJaROjBCGd4VkD9OeSh7HAoOiOGNAhqggaRjB2FFL+4xOhj0JWhn1G7b2ruIczI2tj41P6+fKW6LswlqmcaUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518506; c=relaxed/simple;
	bh=Sqg43bu6sAIQT5b/vVy99L3SP7RR5VCkp5ODZBjzPqI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=prNwZl/dWc0SxfslkclMqs95Hcc3SxL9YWQZJd8RHhqOsLLwCp1D09eodj4LTeq2GahTjJTAW1yAxxiqXYs/zMmaCv8gVp4Vn7BYozQ/ZmtL34MePSAsdI8F6iPUVK17liDrKAB3KQYfhGPCuL+hfIgQkLyTLSjTfabkfPs1hPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pdixWBV5; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pdixWBV5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jctyzrZii5flzAs/xPT5ospEqxnjWEhAeHXCrYGO+Qo6iQ5+3Ktk6DRNatunqpcoQ/9tXIv7akvw3ObR8bvV+NmasQylkVeS/jekLVSe7QlbB7ic1RmRLat3sbMIVfRYrvcpIE5LEmeuFVarH4gPHOSuDO2gcE5Hh7PVA1U/Q7VYV1T/bpNj18f1SJdPhfJ5wpDMw+smr1jP1/l4HSX9fvm2q7947SOdiiLOmDFjQiZqmQqC15mBperAbtvNBiwnGP8iamDoVNKYxL4DoB1ffsLOXUKH9Io+x0oNh6Ln2VaNVjVecsmbVDhaceqBZGXZSlK5b02uUZ1Iyq9/QA/5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V7Qp52KrVg7Sjxkww5VBF+QphTOklBVL9iJm8ASLVM=;
 b=uYx5ZB9PHa3UfErzocIXr5nRFjv5u7nzt7dn/drAW+ncz7sg4YVMEvXGwd75/9RG8zC6cG4JTTnj1NM0K4ndab/UCHzxPNxUSeYCd7azW00DYQkUp2ToMaPl4Xh2CsJhQrqWUX67Ep7+hCQO7UIi37DpOmq8V+5/h3cNVYPr/490b+VxnSIgnz4eIzcyb1RzEp9r4egTMfGnvUCu6cRcqahyuVbvn2l9xVkHP3bh+0OG2JXPIERw/QSGhtEyGhf+R39xbgOWSJpp8J8HMM3GjusDQEFEmweLL94Tuhsobz0tydH7GI6WycHUiH6+RwCi/fGRACcNitBtFK+aGReedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V7Qp52KrVg7Sjxkww5VBF+QphTOklBVL9iJm8ASLVM=;
 b=pdixWBV5YZ7ktlvuKFcCCJ44FDPd08EPnuvtal+SBzMeiatoDPQfg4uEWEhj6jrMJJnIM+OIvZLQ72OYtTsYY1eQTiL5fR9FyPoZOOFFsKtg8DITnx4ArOljjsIXvTgJ0IAVTz9YT5It0AnYbQLBcb/ack+7Y/6KOPX7w/KwerBxz28sqoDGgUFkLYNzH1T7CDz6v4IR4rZ4HpuRR1jpluVpERKXoNGTw4gNjVMo9G7MEqxRKzCGnTjEKsV5xFlkFwsWM996s8wYuJChHIKSU1pw7wf9eUqklYWOXLifjbICz46+hH0BlWVmdh6baXHT+QQUYakVSzgigTFyzhvqNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 18:15:00 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 18:15:00 +0000
Message-ID: <1bb64781-4fe3-4b46-a246-1673371d7c1c@nvidia.com>
Date: Thu, 24 Apr 2025 14:14:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] rcutorture: Perform more frequent testing of
 ->gpwrap
From: Joel Fernandes <joelagnelf@nvidia.com>
To: paulmck@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Cc: rcu@vger.kernel.org
References: <aAiT_KWYN-gP-2MN@stanley.mountain>
 <f8669b6b-63e0-454d-8a58-09043015bc61@stanley.mountain>
 <a2090431-7299-4fc3-89cb-114026f482b1@paulmck-laptop>
 <616131f6-5365-40ee-ab57-27d484077a31@stanley.mountain>
 <6b26b3cc-6429-48c4-ae58-868d6512f0d3@paulmck-laptop>
 <849e0751-2911-4b71-8274-725255f4826c@nvidia.com>
Content-Language: en-US
In-Reply-To: <849e0751-2911-4b71-8274-725255f4826c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::28) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: a324c8a3-051c-41e9-e22a-08dd835bed42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWwvQ0VzbGRva1NtL2l5Z1p2R2dBZmhmK0xFZEFKK2xMbGUxT3JLZ3NYdzUv?=
 =?utf-8?B?eW55WE5EbmxTUFJxRHNnMlFzU1RPMEVoVWFGd0tmWFZSa0tVcHBmQUY3Z0hP?=
 =?utf-8?B?TXR4eHlod3FBbFR6dEF6NU4zZ25lWEFMYlYvaWpya0ZGUWNpMDdvbHJNSTVk?=
 =?utf-8?B?azZSeGRWbHZpR2lxKzN0VWR0U05aTmJWV2xxTTV2UWZVdmpoMFdwcnpwcFBr?=
 =?utf-8?B?T2Q5b0k1TFJQQmIzRmN4SUhzam9KS1ZEQlUvcTQ2Y2M4TW9sRFNvdVEraDVG?=
 =?utf-8?B?ak1zaThmTmxIRTFENFREMlkwRkR2NElONGpua1RScy9lWld6Nk5oQ1crTjlT?=
 =?utf-8?B?bm9qVWk4RW5abWgrZUduNUwrcVM2c3JjT2lpMkxJLzBkWnBOdldRZTZkUnMy?=
 =?utf-8?B?MjRkdys1NlhBbHVUajRBOEFXZzlWOFlSK095dENxMzRSQzk0SzlmM3BnaWx3?=
 =?utf-8?B?NEQrQ1drdG1hUk0rNXBMSEIzWEFKNXVTcFRnNmJWbVZ1VUphVkhuS2oxamhM?=
 =?utf-8?B?bm9zMzNNMzJtK00zVWUvU1lqcDNPS3ZGblpqc2UyblgxMU4xNE9hNnY4QzQr?=
 =?utf-8?B?amdwSFJOWTVSRjkvakJXS1cwbDdpdm1RUXc0M1hWM08rWlBDS3dxNnlJa1Az?=
 =?utf-8?B?WmtPbno5UXQ0R0VCNmdlSU5VcUlmNitsZVJ4bHo4MnJMNFhyU3BKeWZIV0Fh?=
 =?utf-8?B?YnV0NngrZUR6Tk10d2dFUzNkNVpiOU5uVHMvWHFFSmVvekpJSFFtN21uVisz?=
 =?utf-8?B?ZjBsSjV6cG8xbTYzNitZTkl4alUwMG14c2dhVDJjS0p4VUhpcnRBenpYTjhl?=
 =?utf-8?B?cExyT29SRFBPYUpQT3dtMXo5QjFBejZKTHdheGRDWjNBNmtYV1NsRkJsTFk2?=
 =?utf-8?B?NjFEY0RSeDQvTUxrZVhnUFQ1c2xrcXNwRzB4ZEpjYm9iQVVKcHM2RGJzSzlO?=
 =?utf-8?B?K21NQTJDODh2ODhzSEo2TVRiZ3FKZjg2VmxjaWtXOUJtcUMzam9HVmkydzdu?=
 =?utf-8?B?N0JFUm9QVER0ZlRIZnFBMWlGY1NYNFd5T09UODZ6TlgyM3FwY01zQmNMeXFj?=
 =?utf-8?B?bGtMN0s0UEwwbnZJcGNNcks2VDNGcFkvSVRpSjZIRXFSV1JXRUxoMDRrSUli?=
 =?utf-8?B?ZW9hNytOdHQ4d0p4UkY2WkwzUzgrQ0RFY2F0UnlVZHpFZlcyVmJYOHRrNTl2?=
 =?utf-8?B?ZjlCeVpRZ2V0NnRsV1JzL2FMTEpYMHYyZFBXSUtIZ2pWb1FnUFRtTjU3Y0lP?=
 =?utf-8?B?ZW5nVlBHTDJ2UUZEMGloMkkzaDlJd1dZeHh4MmJrbkJ6czludGVsNHNNRTB2?=
 =?utf-8?B?Smo5RWxDMWZyT2YxSkxsOURZNU1WQVk2UHNUMzFUalpzNUxmbmZabEcrUURY?=
 =?utf-8?B?UHcxMkJNSktwc1JLSldkTVF2NGE3YkZzTG16WXVCcXJZdUZ1K3U0aGk5SURC?=
 =?utf-8?B?UHFvU1BYYit4UFpPWS9ySHVPOWZVaHFiTlc3Z2ZjOHlmOTlkbHhCVDdySklx?=
 =?utf-8?B?UGVIVkM4cHV3TjFxUWlZR090dFUrSDkxcUpSLzFvQ2c2c01IcDJRUlNsTkZ0?=
 =?utf-8?B?VGRESXZUZTlZNWF1K09tOThGNG40ZG1DZjBwWDVrRmlTOGpVZi9FQlFWSVZv?=
 =?utf-8?B?RnZWdngxaUw4OEFOazZpSUNUeDF5S1M2cW95VTQvWkg1UGloZlVwOC9LbFhX?=
 =?utf-8?B?dHVaOTBPcWJkSm1mSldjNC9qWGZDU0l1K0grWHExaDlsWnFuRHltRzNBVlFP?=
 =?utf-8?B?eEdscXk3RXhhbnIyOUdCUmh6d0x6eDcyNUg2Z2hDUzlybkw5WEsyalIycVJM?=
 =?utf-8?B?d2U4a2h2S25KNFlGU0VVSk8wNis5UGJOTTNUbHM1d25vT1o1c1p1ZzB6blAy?=
 =?utf-8?B?Nnl0alJoeWhoaERvaTc4R3N1SXFoaHRialVpVGRVRThHZXZ5MkJaRTF6VTI0?=
 =?utf-8?Q?7n9ImHd5Z/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDY3aGFyN1ZmeXUyYlVuV2h5VWV4ekw2KzVVS2dZTjJndEJTU1M4ZUE1OGFv?=
 =?utf-8?B?N1laWXdoa0pmQjVrdXMyT3RLZW5rQU96NGRmNGhxRkxXYW5aQmdUWXF4Y2lT?=
 =?utf-8?B?TE5iN1VlNW9Xc3hPZ0pOd094WEpYYVd3UmdIQ0FianUybjhRR3ZQTHNqUWsz?=
 =?utf-8?B?VG1pSzEzR2l1bEo1bXUxSWxOV0E0MWVFNzZWeUF3U0ZKd2tkYklueERWT1B4?=
 =?utf-8?B?eDBYbzNpeUlKS1g1SE9TNXQzU1pSYTZLS01lZUtwSVJ4dkZxNzNmMlQ3RVdn?=
 =?utf-8?B?SFA4cEhxcjJhRXJ4Z1NJMXNmWmt5aDRMMjY2ZnRmbUc4cXErWE1LclVwQmk3?=
 =?utf-8?B?YmhCYy8yaWxRbWZucXZDUTc0RjhXM1MrQW5yM3Vad3VuOURIMUVLalI0Wkgw?=
 =?utf-8?B?bDRCa1RXTW5vd01wbDMyVGpXeEl1TUxuWk1EUmhjMVVVV2t5dTd2VGtaRGIy?=
 =?utf-8?B?aVR5MXhmbjBhMWZnQlFKblhTd2dRS0JJeEVFQ0o1ZktFWTh5T3FVYUJYMWVq?=
 =?utf-8?B?YzFzM1pEYjdRVTdjMldnOEZzRkkrTGlPWVhYL3FjZkw4VG45R1AydHR0VnF1?=
 =?utf-8?B?SlJlOG0wbzdNMktsSElHMjhqa04yazlOV1VzL2Rtb0NVdkpvTkJkWnpESDV4?=
 =?utf-8?B?NzJyOXpLMEFaUXRmN3k5aW95TmVCNTR5dVhJNDJYWlRoY2tJdEVORGxHRlJZ?=
 =?utf-8?B?QjNrQmpzK3VBdERNZ29qY3MrTW5NdnExcXpGNENOSWcvdm5mcXNzdThIM2dm?=
 =?utf-8?B?TS85M3NxVC83RktCNGxIWDJ6SUhIVkIxbjVibGhNaDN4V3RKMHRLRGtnQk1p?=
 =?utf-8?B?NDJMdTFhTFdNdmlUS29ZVEZDZG4xdnVDV0NjSUZDeUdlYXFXQWFrek8xay9k?=
 =?utf-8?B?TGtkMWlXTlA3T3pCUHVFUUtld1pLRjZHd052MG9HOThtVStmOGFuMVRub2NP?=
 =?utf-8?B?bHlRYVZseW9YRGxTUTlyUWxaeHNUN3JhRXBPU1FzYVBINkFXUVFkRVF1TGdh?=
 =?utf-8?B?eDNPZnArdlBCMlB5NHNNN2hySWdGY050cHllSXBlWVF3c2YwY3NyUFhKaDBB?=
 =?utf-8?B?Z3NmVitnSmRUR0hRMXROWGxqamRuWFQ5U1BTRkYxS1k5WFpadFJxOXhOTHlv?=
 =?utf-8?B?MUgzN0pORXhlbTZNQ1VsRThMNEV3ZkdScnRoaXM2T1oyMDhaM01rYTJ5SzZj?=
 =?utf-8?B?bWQ3eE1hT3V4eFdGay9HaFJ0ZHM4SWw4TEd4MXlaajFWTDRIYmxJclA1Tno5?=
 =?utf-8?B?UlZtVk9EYTMwUFJVckp1aW85Ym1BOEl3SWxHa0xGeWx0T0UrTFEwenl1ZmRC?=
 =?utf-8?B?cjVLOExGb1o3VmtNU3Y0NXJjKzJjTE8rZWNTOFR0ZUxjV0diR3llTHJIS0Zr?=
 =?utf-8?B?L3IybUQ3YmVUNE9kMEhzVWk3dmV5emJYV0cyOTRjS3NFRU9aamhpOUF5Ujhh?=
 =?utf-8?B?VEZ1aDJIU1oreDR6MGpNd2ZybXBMVGc2Y3FFYWRBUWVpaVFuUFR0SXRjVFBn?=
 =?utf-8?B?VVFwdUlaa3dKaXc3RzZXQUxGQ1FMN1BkVkRiU2d6UXZBemdDWHRsQnV6MGRR?=
 =?utf-8?B?UTgxK1kxYlhUWXF4M01uVmwvSWdOMTlDdHQ3NVlveEZsSzF1V1RqVkt5SEpT?=
 =?utf-8?B?ejNnTnVnOWR1UU5IeTBja2dETzJRSDJDUy9hb283ZHYxazRIbHlDWEZlVG12?=
 =?utf-8?B?WVo5ekpWR2VnZjhnSWZjS0QrNXdoMG1ZQ3hxQUtzeDVSRWxWVm9QN21IYlly?=
 =?utf-8?B?ZEUwejhRQXNDTXZQazdHcXdyUnA5MTdQOElrZE5QT0taWUJBWnhaVE9iM2NF?=
 =?utf-8?B?Qkc2MHhsQzhuNnRzRlZnWW1QVUFJNGZZTDRFUkkwd0dEMDF6SlI5SVEzM0JC?=
 =?utf-8?B?dU4zN2ZxQkx1ZU5QWVNScVhiTGFZSUwrb3VoVjhrWHQ1dXQwajRScnFLb0ZR?=
 =?utf-8?B?S2Fac1M5SjNwQ2NlckxVazJibVhXT3YxMjcxbU02WXlFM2hzRHJDUlYraDMw?=
 =?utf-8?B?M0VYZi9nSUtqSXJTelROYnR5dThOYmVXSlMzWnFiaHcxbzVmdEptaU5UWXBF?=
 =?utf-8?B?amI3UTZraHcvakxVWjVQK09sL25Ja0ZDcmpMUk1zZjZWaFVObzF6NEhUMEtj?=
 =?utf-8?Q?w93Hyd+w490cV27BbCD6WIQ5H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a324c8a3-051c-41e9-e22a-08dd835bed42
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 18:15:00.4375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGMxUUCYSCdUIBTOOfuaaZX/7zPOA4NLhD0n6r6IQG4nXJrGX8yBAxOSphxAE7vnoejkEb43Ie2F6hbQ8ynzwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901



On 4/24/2025 11:17 AM, Joel Fernandes wrote:
> 
> 
> On 4/24/2025 10:44 AM, Paul E. McKenney wrote:
>> On Thu, Apr 24, 2025 at 09:54:14AM +0300, Dan Carpenter wrote:
>>> On Wed, Apr 23, 2025 at 05:41:37PM -0700, Paul E. McKenney wrote:
>>>> On Wed, Apr 23, 2025 at 10:19:56AM +0300, Dan Carpenter wrote:
>>>>> On Wed, Apr 23, 2025 at 10:17:16AM +0300, Dan Carpenter wrote:
>>>>>> Hello Joel Fernandes,
>>>>>>
>>>>>> Commit bd57ec707441 ("rcutorture: Perform more frequent testing of
>>>>>> ->gpwrap") from Feb 16, 2025 (linux-next), leads to the following
>>>>>> Smatch static checker warning:
>>>>>>
>>>>>> 	kernel/rcu/rcutorture.c:4586 rcu_torture_init()
>>>>>> 	warn: missing error code 'firsterr'
>>>>>>
>>>>>> kernel/rcu/rcutorture.c
>>>>>>     4576                 if (torture_init_error(firsterr))
>>>>>>     4577                         goto unwind;
>>>>>>     4578         }
>>>>>>     4579         if (object_debug)
>>>>>>     4580                 rcu_test_debug_objects();
>>>>>>     4581         torture_init_end();
>>>>>                    ^^^^^^^^^^^^^^^^^^^
>>>>> Also:
>>>>>
>>>>> kernel/rcu/rcutorture.c:4591 rcu_torture_init() warn: double unlock 'global &fullstop_mutex' (orig line 4581)
>>>>
>>>> You lost me on this one.  This mutex is acquired by the earlier call to
>>>> torture_init_begin(), but only if that function returns true.  If that
>>>> function returns false, yes, it releases fullstop_mutex, but in that case
>>>> rcu_torture_init() returns immediately, thus avoiding this invocation
>>>> of torture_init_end().
>>>>
>>>> Or am I missing something subtle here?  Or missing something obvious,
>>>> for that matter!  ;-)
>>>>
>>>
>>> I explained it badly.  Joel's patch added a goto so now we call
>>> torture_init_end() twice in a row.
>>>
>>>> 							Thanx, Paul
>>>>
>>>>>>     4582         if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
>>>>>>     4583                 cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
>>>>>>     4584 
>>>>>>     4585         if (cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
>>>>>> --> 4586                 goto unwind;
>>>>>>
>>>>>> set an error code?
>>>
>>> Here is the goto.
>>>
>>>>>>
>>>>>>     4587 
>>>>>>     4588         return 0;
>>>>>>     4589 
>>>>>>     4590 unwind:
>>>>>>     4591         torture_init_end();
>>>>>                    ^^^^^^^^^^^^^^^^^^^
>>>
>>> Here is the second torture_init_end().
>>
>> Ah!  Thank you for persisting.  Over to you, Joel!
> 
> Oops, thanks for finding both the issues. I will move the torture_init_end()
> further down and run some tests. At first look, that seems like the right thing
> to do:
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 92e2686a4795..bb9a8e718533 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -4582,13 +4582,17 @@ rcu_torture_init(void)
>         }
>         if (object_debug)
>                 rcu_test_debug_objects();
> -       torture_init_end();
> +
>         if (cur_ops->gp_slow_register &&
> !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
>                 cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
> 
> -       if (gpwrap_lag && cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
> -               goto unwind;
> +       if (gpwrap_lag && cur_ops->set_gpwrap_lag) {
> +               firsterr = rcu_gpwrap_lag_init();
> +               if (torture_init_error(firsterr))
> +                       goto unwind;
> +       }
> 
> +       torture_init_end();
>         return 0;
Passes basic testing, fixed and pushed for more testing with attribution:

git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (next.2025.04.24b)

Thanks!

 - Joel




