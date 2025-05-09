Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078982376EB;
	Fri,  9 May 2025 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746818054; cv=fail; b=RBuF0wx3bG4qORfd83UPAbgke8rIFnOEX8v38YmyDi1doJG+z6EhJ16WGDydr/7yC3o6bXtgG9+0ygA7APrYQttR3cuYcqnXZkYnhceAI6CIN7dJFuk/u1yJk80qmSqURp/WI1K5xQEPgmh6kd7DXCdid4r/6CGBB9K7M6EQ370=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746818054; c=relaxed/simple;
	bh=gyze4hfwsRhx1K/PD+epsVCX3oRHvr7F25BURvuyBLo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EmHcSKX3WSgE1ta7Ph2ssL1hew5tiYExUEfBjLejS41VwC5mPjG6FX4Q+BFTCLswJ7MDNOT1IcjOqQDscs0FUDEaaMGX2yhUt8utnIbNhUfO5nzlMd1ZUhWOsBR97muTAFWvkT5E2U+67xtg6+nI4GFOxpXKxeFFdAA/TS4Q3HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m5Is1LSn; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m5Is1LSn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL0beau5nz3omXSNO91Raq/EIbUDfI2Y4BSWNqCKly3zo8M6WakCO5BAiQ6BY5tPE1O3wVgcFP5p9FgoaOHxp2GXRpTxktluE7Qq3vH8ZnNtYzH7SsbSTzBF8L60us0JQR8qBwIsU6NFYS1ekmcI81o2AmDyeetK+j6B7NohdUdU8Bzw/YqavbvA0Oayu9BqRZe615dEvyMO+E+1Kbt8LzUAhIAhaCLKClpYk3stlXYC326FEiKsnU1qKl9QicNzTSj8wzoy5JWYQBZgjap/feKdO+InIg5D9uywl+SoqGToSP6sdruyG1uHZrmUnKlo9FimDfWOF32UcDWfGDhqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez3DdauglaE3dApokdmz6FyoPJTSrmXfqp20yp9tRAU=;
 b=R5+EL5DyvfiRHYWiCu8cGmz/Khp2M0jcph322oFazrqOcp4sqxU6kxND7pZA9YldzGmU/IUwby2SrE2J6rHeR68H4av3dlBu6wpfpWSbZlOjqf0LR5o83+BOr9QpY8/Nkiwtkb6HytjivLCq8gzJvJL0LVALqdGuwgwfNM143YKAuQ5srf5ctSIUYlf4PCey7JRug50bujp4rXfhlUSPMJ5INMUhCSTQlr4q+ls6PYQK6TtOTupneKGjm56M/W3u7vZs7m9godBiy2g7ERBPQngs9qNXE0oNXbkX4OesigJNJH9kcCr8+MPUpf3Zt3wBbjO4bdjjdzVE170vL/AcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez3DdauglaE3dApokdmz6FyoPJTSrmXfqp20yp9tRAU=;
 b=m5Is1LSnJh3EQKJaFs07KCqV/xcGQyYeQcC49DMbpzjkrahpDSP8BeTX1XePa3UwqyDcb6tBdDt02OgGypT63ZLnysswTYMYtkr0HT8Gvq+oQZy0Uo5W/b5j3T/51i8mIcOf5S8xQ+b0I0rOBzwimCYWGzPhEipv56BT6VcmoxCWAwESmWP/D2rpeiqn1kOZNlpxxb4oPFORoyASn/+Z7y2E2moNWUtxGeR+JFm3qgFGPioSZyo4fxqhFHO4u4QTQyatd74p+H5pswfEOnxOcRM4yYCU/81248/PTx+24E7bSpS9jCcfoAWplZ+K8ef5bMbUaXqXYrHq3O84jtruAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 19:14:10 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.035; Fri, 9 May 2025
 19:14:10 +0000
Message-ID: <7adc35fd-2c88-444f-93d4-45fc1a1d7369@nvidia.com>
Date: Fri, 9 May 2025 15:14:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcutorture: Fix rcutorture_one_extend_check() splat in RT
 kernels
To: paulmck@kernel.org, Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
 urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <c5b6ab90-82de-437e-b608-7de6b21c9586@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <c5b6ab90-82de-437e-b608-7de6b21c9586@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 893100e1-9b21-4a43-568e-08dd8f2dad55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGFDQzMzVTk1TU43WkdTbWZCUkVOT1ZIaFFtYmhhajBmZm9KVDlmc2x6SWhL?=
 =?utf-8?B?bFBhaWVsNW9NeU4yK2JpamQ5L0hqTHlUcXl5aDJkazlSOXp1dE9HZkhHMGFP?=
 =?utf-8?B?TkNkRXhIc2k0YnJzSUFLeUJZejVqcGprejFGdVlRSlVOWXdXWTNiNW1CVXNx?=
 =?utf-8?B?QkI3dk1qaXZ3Z0VPUzY5WVBXaGEwUVVxSUFQVEkxdGpHa2l1bjg0SXY1U1ll?=
 =?utf-8?B?R1FyN3llc2x3SnByT1Z6b0tuaFMxZjMxTGhtcGZYaVVjTUNUSVhMZ1NtWjBt?=
 =?utf-8?B?Mm1yN3RjNXFKeDBCMlJ1WU94MzFsTVJnSzArOHN0QWxwQmFDMEFWUzhUaTNn?=
 =?utf-8?B?d3VLMmRkV0J3TWt6ZmdiWWxSazhQZlZqcDlmaEdUbjR3ODFVSmlTRWxPRVph?=
 =?utf-8?B?ajdvc1h3NkswWTFpZUZNdVVVcmZaMzdKaGh3SU5LV1BML1QvVHBoRzdLTGh6?=
 =?utf-8?B?VHlGdU0yYXFMN1FGQmJ4NzIwaXJXbi80WTZZQ25SNUJjZjdNNFZNQnlLaUto?=
 =?utf-8?B?TUpUSWY2MVJFSkF0K2FQdUVNSnR6cHJSTW55NHJJYTRTcWcyZ0JZNnM2aDkz?=
 =?utf-8?B?ZDZSMEdMNE9neVczSW5VU3g0eFdGby9hRHVNY2NjTWZuK1l2R0h6Z0RSbFVK?=
 =?utf-8?B?QmYvOERZVisvT1RWdWkzSEYwUUNFK2IyMkVLV3pUVVF2NTJWeVA0VUNVcFA2?=
 =?utf-8?B?YjJ4LzZ1clN5NVhLbXJsYXE1cEY5MStyWm1haDN1Ums4eis4alYwaXYxZGpk?=
 =?utf-8?B?Z3NTeVprdEtST1ZiYndlc1ViR0dubmhJK2dja2pjNncrWWpSRUMyM2p1cnNl?=
 =?utf-8?B?c0RPaFhjemlVTm1DVXZFaFNWY2FpWEhSeXJyRlJWY1BuM1RYR2lPSjFDc0ln?=
 =?utf-8?B?T0FPVVpHSzVOeDZxNjJVejRaZkhaLy9LbmtMYTd3S1NqL0lQTnB6Sm5vWUZH?=
 =?utf-8?B?NGlmRnpzRzlpUE5MYWI5OEpxTmNOditNVW4rNXFoZkZ1MThiaEJ0LzNqVTdF?=
 =?utf-8?B?S2hpb3pQUldXYkVCeXlCM1dBZ0crclNxTEQ3dEdaNjcyZGJzL3pWYytuNW5F?=
 =?utf-8?B?T092aUdHVnNzMHN4SXl6R0hLb3o4dzlBTEdFZVhWVWExZzBOMjh6YTFwaXdD?=
 =?utf-8?B?bytvY3BBOUZBdi9Mcm4xY1dXT2ZLUzY1RHBTYm0zNXFCYk5FdkdaSjdhWkVE?=
 =?utf-8?B?dmpmR1dIUmVIVjJlWUQzeWNmNW4yOXl6SDVGNkk0eGJmSXUyaEs0dGxEdnRh?=
 =?utf-8?B?d2NCZUM3VHdGWGM2bmI2cXRKSmlkMmd4Zmt6NVRKaVViRDkzTFljT1BhMG1a?=
 =?utf-8?B?TEJEYm1lZXYzRE4vZmpMWWJWcFgvVkVKRnFKeTRZT0FJRTZUVk5nN3FKWTZy?=
 =?utf-8?B?T0FGQ1NwQnlHeHFseTN4bWNaTVBYSDg3ZUgrVmV4ek1OdUNwY3BHVUp3QTkr?=
 =?utf-8?B?Y3hlQ01Ta1VtdFZZT0VyUGFRcEsvZnBDbmNIR3JHZlc2cmZDa3VRMVhOb20z?=
 =?utf-8?B?VVQrSStGYi9ZUEhmTG55dXhsVlVObGtXeEVMUi8zM1MwNGxvN2FYS2o5dTNY?=
 =?utf-8?B?bDlmdHN1ZVlWUk1LWUFqNUtNaEt6V0NNeXhEcDUySFFaS0t3SlJxc2dMbDVL?=
 =?utf-8?B?NzFTdjYwcjJ6NUp4aHhhMzV6QWoyZ3VQU254YWR2d1pnSFg0K0x4Um5BQmxT?=
 =?utf-8?B?M29iMjk5b3VMaXNtdDluck1NQUd3dnRBS3djdEtvd0pZbDIvMllpMHRGek93?=
 =?utf-8?B?bDZNVUZnSEFRdUN6ZFRiTDRQTUx2NTZBUjFoMzVIU1d0Z0F2N0tpcXovM1Rv?=
 =?utf-8?B?RDJsV2xubTV0L2kwcjNBMG52NlBobVR4cGFhblNLMCtidnAzcjJtc3hCTGhx?=
 =?utf-8?B?ZSs3eVIrL1hiMnhzVVBvU2dtLzlGOUdrTFdDNlp0OWw5ZzBuTk4xelRxVTNs?=
 =?utf-8?Q?9724zkAhfag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnY3VkZzS2IxYUthY0ZKNmx3SjJIQ3pMdGVaMWl2SVVwTkN6dUppQ2l3cVNR?=
 =?utf-8?B?YnRhQVdiTXBDQkFqeHZMenZqOGVjd1NXWmFjdEZkTytvbXVhYm53RGp5M21E?=
 =?utf-8?B?MDFsN0ljeVFid1NrTXJ4NlRBaUNZNXNCTzliUEVmUGcyMVhvOEhMS1E4ZG1V?=
 =?utf-8?B?RGR2YmVqSTlPQm1NMUpoOUl3cG9aRjJ5VjBBeDJNTHNFV0VXem44MTlVU2Rj?=
 =?utf-8?B?SWdjRWNWUWNVdE4rR0grTkw1TG9mVXp4ckUybUo3RFlUK1RIL3pKZytQRjky?=
 =?utf-8?B?cHROZ2RZZkhWdEZ3QjhFUDV0cW1wcVgwTjhHbkQ2U1E2U0RLdXFUR29tbHRC?=
 =?utf-8?B?VWc1RmlNdks5aW9wbThqUXdzYTVZV3YvdklOMTVFMjRIWG5ySngvV1RvUnN1?=
 =?utf-8?B?QjR3SE1WbEp6eTQ0dXRPdUcrcis2MmJzMzlqOXM3RlR0Y0MyN3U0Z0NHd3lr?=
 =?utf-8?B?L2dqNGk5NjBWN2hRMHZoV01Qa0hZZUZldXdicWNkQ2tIbk5oQzVlTyt4ZjlX?=
 =?utf-8?B?My85SCs3a0Q1azBOaUFMWThJZEo1ZTF0bGE1MytFcnhVdlZKTWsrK0tuYlNO?=
 =?utf-8?B?UDYyOXZVcFk4Q2dJZzdKcHdBR3ZtRmNBekRCbU5IeE9jaitmZUV5VkdRUGR2?=
 =?utf-8?B?TXpjbzh1ck9YSytFNjZDZVFsRm4vbHBaa29kem9GQmVDR3JzNzFudDFHZUhi?=
 =?utf-8?B?RUxYMTkrRjNBMFdmVUhvYU9vME82NEpUVHZKL1FsYzUwcElHbWNzcnR1bkgz?=
 =?utf-8?B?dUdGZjkwYkE2MlFXRVh5U0p2ejFjaGxvRURBOGdMYlByd3QycjJaYmRVdURk?=
 =?utf-8?B?aEFFb0w3M21INWpwSmpXM0RnenptOStFQjJ3WktWWlpNVUlxRzFMTnB1cnor?=
 =?utf-8?B?aTFQOVlVbXZUOW9OTUU5dW9YcyswejlkSUZIVDVwU2VzdjQvR2ppcjBEZkZ6?=
 =?utf-8?B?UTQwVE1XZHRuVVRudytVVWhRQm1CRW5EWFNjR0I0YlhvR01SUVI3eWQwVmc0?=
 =?utf-8?B?T0YwKzJneU5saVlBZm5ROThCVEFnVEpVNHVFc2VobW5zQmhzTjdTakVxNnU3?=
 =?utf-8?B?aytFbVluWHNIMWIwS05IN2lqTHNNNWFvQjl4TlZ2eHJaODRBUDluT244UXg5?=
 =?utf-8?B?cUVEWDNBem90dmJSVmVVTDBFdXRtaHFQMTZYYStmSDFXSXp4aDYraGo5RTds?=
 =?utf-8?B?QnVMWEg1Ri8zSzBRZ1FoMVUrL3RnZHphbS8xUHk5UDhhZEEwN3g0UmlFall0?=
 =?utf-8?B?MXVDRTFZMzR5a0pxNUdIOW91YVlaK0VpUzZDN2FHUnUyZGE3RFJOWnA3SlVH?=
 =?utf-8?B?cE9UUHBoYUh5TThmQmQwcExUM2J6TDJ2cWRLWnhOWnVlOGF6RWJkalRPQXNt?=
 =?utf-8?B?YzNTT1B1TFB5dFhROTVRY3RpTnZ6aHpMWVBuSlg5aFg3WDdRdHlJeUdOOFhq?=
 =?utf-8?B?ZU11ZEQzSkVWNUpXNzhVLy81MHN2VGcwdXByaDVJdERTeFplZjN4c1ZEeFlM?=
 =?utf-8?B?OC9zcjJ3cjlzMVFLQTBqcEVUakdRRTI4blZSOTlVcnRYUXFLMFZFRlhJUS8v?=
 =?utf-8?B?bG55TTkwRktnZ1lTYnNTcC9LY2dxOWVTWjY5UXBlTEZZaHlsb3hESFJwQ2ZV?=
 =?utf-8?B?UkNOUllkWGhFcGdxREx1Uk9OaFZGWHRVMU5DNVZHbnc3eXBFajlENWdaTUVX?=
 =?utf-8?B?Z25weWI4ekpnRko4UlNmTitrTWFxYUZ0cDVHVjU1d0VoVnhnbFppMDIwT1Uz?=
 =?utf-8?B?bVBnZXdBOERvMXVWRkcyS0RBWXo4VEt4R0dvWDhRVHJ0S041aG1CeGxRdkdR?=
 =?utf-8?B?VGpXUDRtNmNGU3Z3djJ4UFgvVXRudnRBN0hyWlE1VTNIZ0J3cEFUejdzRTBv?=
 =?utf-8?B?MXhpb3pmaXVhMFdZdzBpSHhHb1BpUm0yNVdtaFFtbGtrSkIvYWFYQUpaNUZW?=
 =?utf-8?B?bEhuVFJla3dnWXZrRXVpWlMzbERHbndNamZPODdzRk5zNVNkcjEwMUJxb2dU?=
 =?utf-8?B?Y0twazh0OWNhdStvR1FPRVVjWUlPM2x3TzlmdkRwMmxmQTFjYWNtZFhPQ3F2?=
 =?utf-8?B?M1JkekNZbEphMnIyM1BCdHhSclFpTTE1NUpYSEhJSU5GbU1ILzJSSUdmbklz?=
 =?utf-8?B?VCsxMXowRDFFRXpGQ1NLUGt6VDBaNkNEZERIMWpsOTFIcDhpbi9teE00OUpq?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893100e1-9b21-4a43-568e-08dd8f2dad55
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 19:14:10.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLThyIuxoN2NbQALinXN8R7K4mJLxbF6su6hFWI3fo9cR8T0iSxGhJfCmTNbSBgXiMCOW8Y0rmfjKW2W3FIrLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111



On 5/7/2025 5:04 PM, Paul E. McKenney wrote:
> On Wed, May 07, 2025 at 07:26:03PM +0800, Zqiang wrote:
>> For built with CONFIG_PREEMPT_RT=y kernels, running rcutorture
>> tests resulted in the following splat:
>>
>> [   68.797425] rcutorture_one_extend_check during change: Current 0x1  To add 0x1  To remove 0x0  preempt_count() 0x0
>> [   68.797533] WARNING: CPU: 2 PID: 512 at kernel/rcu/rcutorture.c:1993 rcutorture_one_extend_check+0x419/0x560 [rcutorture]
>> [   68.797601] Call Trace:
>> [   68.797602]  <TASK>
>> [   68.797619]  ? lockdep_softirqs_off+0xa5/0x160
>> [   68.797631]  rcutorture_one_extend+0x18e/0xcc0 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
>> [   68.797646]  ? local_clock+0x19/0x40
>> [   68.797659]  rcu_torture_one_read+0xf0/0x280 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
>> [   68.797678]  ? __pfx_rcu_torture_one_read+0x10/0x10 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
>> [   68.797804]  ? __pfx_rcu_torture_timer+0x10/0x10 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
>> [   68.797815] rcu-torture: rcu_torture_reader task started
>> [   68.797824] rcu-torture: Creating rcu_torture_reader task
>> [   68.797824]  rcu_torture_reader+0x238/0x580 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
>> [   68.797836]  ? kvm_sched_clock_read+0x15/0x30
>>
>> Disable BH does not change the SOFTIRQ corresponding bits in
>> preempt_count() for RT kernels, this commit therefore use
>> softirq_count() to check the if BH is disabled.
>>
>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>> ---
>>  kernel/rcu/rcutorture.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>> index 373c65a6e103..ef439569f979 100644
>> --- a/kernel/rcu/rcutorture.c
>> +++ b/kernel/rcu/rcutorture.c
>> @@ -471,7 +471,7 @@ rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
>>  	    !(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
>>  		started = cur_ops->get_gp_seq();
>>  		ts = rcu_trace_clock_local();
>> -		if (preempt_count() & (SOFTIRQ_MASK | HARDIRQ_MASK))
>> +		if ((preempt_count() & HARDIRQ_MASK) || softirq_count())
>>  			longdelay_ms = 5; /* Avoid triggering BH limits. */
>>  		mdelay(longdelay_ms);
>>  		rtrsp->rt_delay_ms = longdelay_ms;
>> @@ -1990,7 +1990,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
>>  		return;
>>  
>>  	WARN_ONCE((curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
>> -		  !(preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
>> +		  !softirq_count(), ROEC_ARGS);
>>  	WARN_ONCE((curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
>>  		  !(preempt_count() & PREEMPT_MASK), ROEC_ARGS);
>>  	WARN_ONCE(cur_ops->readlock_nesting &&
>> @@ -2004,7 +2004,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
>>  
>>  	WARN_ONCE(cur_ops->extendables &&
>>  		  !(curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
>> -		  (preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
>> +		  softirq_count(), ROEC_ARGS);
> Given that softirq_count is defined as (preempt_count() & SOFTIRQ_MASK)
> for CONFIG_PREEMPT_RT=n, the above don't change anything in that case,
> so good.  For CONFIG_PREEMPT_RT=y, softirq_count() looks to be the way
> to check BH-disable nesting, so that is good as well.
> 
>>  	/*
>>  	 * non-preemptible RCU in a preemptible kernel uses preempt_disable()
>> @@ -2025,6 +2025,9 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
>>  	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
>>  		mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
>>  
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && softirq_count())
>> +		mask |= RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
> At this point in the code, we are complaining if something is disabled
> when it is not supposed to be.  So if I understand this correctly, this
> added code would suppress complaints (but only in CONFIG_PREEMPT_RT=y
> kernels) when there is an unexpected rcu_read_lock() in the case where
> there was either local_bh_disable() or rcu_read_lock_bh() in effect.
> 
> So I would expect that the CONFIG_PREEMPT_RT=y version of both
> local_bh_disable() and rcu_read_lock_bh() would contain rcu_read_lock().
> 
> And in fact, rcu_read_lock_bh() invokes local_bh_disable(),
> which, for CONFIG_PREEMPT_RT=y invokes __local_bh_disable_ip() in
> kernel/softirq.c, which on the outermost local_bh_disabe() really does
> invoke rcu_read_lock().
> 
> So this one looks good as well!
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

It is a fix so applying with the review tag, for 6.16, thanks!

 - Joel


