Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793906588;
	b=M2BVv+qTcdOPAgN1mVemkEzMzYyvCz7z1D9FcitbXtxpK+zEPqxukT0S3JniENGJJQ95
	 zWypHz1mTYNkZkp0wZZtaUl7cqfIRkxxmtggqXoLBCuLFsVx0Y+tLHJUB6Cb+QnWbhMGn
	 HXMlWJ8OG8HQhcUiuJUAz6jzZtaLLgArT6qMB6cbKtNKaOlJuTwGpPGpeIx6PiMCvVA4y
	 WGtVH1Fps9SeJ4fHvvOhTI9wEfgVXMhzzLQRbwSNCMR9i14oo/J+L56pREZ6iGL6kyqV5
	 3el6dlOMQJ4cQZ0AqYIquWW9cyxKCuUVyOUBkqxq4yHPblZhTWjnEJnPP+Y6dWz+zgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906588;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=68yCviUMEOHtkjiaFWDTSd1hZGHG6J7t3aPABKB3lJg=;
	b=MhpFRW3VjiK7ZJiSHwcOUm0cuP/6Vr8mE0Oy29wYT76g9y896Rty2WxdInFb6r4TZe/+
	 N8YnQCecHULWlf6wYRDcd4+lpp9i1NiB//OHF5HDhKxZi1TwH1En10MGYDswkgQxWl0cn
	 zK+vRV0JXKV5y2uCaCvZVNY8fQIE0EQOuXAVn74uZpXbUqe264bDVli+gUSEWoZBSJZCN
	 f1WzNOhqmaG+pLlVhwMUQquBENlXmlfefH5H3F/vZ+KWtDBuYVtsgomYYGRJ9T/iOtfH1
	 KWldSt+IHdhdB3AdO6VQCYqA2bAI7CQ8LKlmTr5taWJcw71UivwsrXq4clQn/vniSjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g4NXnL9y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.19
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CEA606D802
	for <rcu@vger.kernel.org>; Thu,  5 Nov 2026 19:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33CEA606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g4NXnL9y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/vVf+PNB1pFZBSOxxna7JAVJd5G12M0k1P4wTnHQkjNEG/OcnlfVoaNnUOMSceL2pNzZU1DlVM6zd3ajVxVDAR4xX4bju8dvv4+kj1YrxSHPDtoKWcW5DvwpvLCisTt2VNBYm6Htmiox+YYg01yJxd5uf6Fj+xytRq9Mmol200RZg7cUaZUck8ZjdKTlB/HOJyipXcSEKRUAOuQMUjTD+cXUBJZlON0TZz1F8NfUlvi9y/CLaeTU/yI6tMnH/Ox5PXlhi/AdvGUWqrqiwkFuMKeK7mfYahAqm1kgcQOE676CenTY4ZEaAgVLwphjorgu+Y0s3a75pLYjBMOJcIuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68yCviUMEOHtkjiaFWDTSd1hZGHG6J7t3aPABKB3lJg=;
 b=A9VzTiQU+WXxJ8eZ+4ro3GrGZBZB8aDiSq1TD07CWNuRyA5EBjYQ+bWf6Z8q0UyB1NOtO7eeMjKMAg/NBVo9A1i7vR34D+Xz+grDPb2WUW5KafDRhJV8hNB/V774dysc0O/YrTQaoL2P3VPPYQcqXw8TYfuKtlwMb8JIbY/K0r4Djspg/kN9+7Nxi+KUTpWTEuEcu1R7X5eYfX6v0kQZ/Iliz6BpH7W42JUrBgp8/T/qqT7dch5XoKgUDGqaA4U36FbkBsjsU8ok3XEcTLOWk0EDIuSzdlxNtZUmth7PPcBomzc1ymok6JnYlDW0zGmvXHVaITji8ZTp2U9pCq2lPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68yCviUMEOHtkjiaFWDTSd1hZGHG6J7t3aPABKB3lJg=;
 b=g4NXnL9yKPZHdBtkrvFW93BOO9w1sTPxzd5lhl9d+PVYe5pU8id0BJFx2aXOSVyvT9LH7VL8Rl8f/qOtJ65z1NCnikMaxq74PQC3EEdyF4Fx/vOMFAMKxr7z69A//KruFZRHPG0s9ScVSwkYv3I99Mn0d9Fs49oF/TAtAGQvXxlK/tnZZOPMnr9ThlzYkV6CW7uExVdkPDJE50Hppz7xZE/00zT3f0x+j8KtUiJkSy0WPo2yFurjEqTLR94TjewPgyQxisagekAoMrLbycZJCoZEOXKGiO2bl3nyuXG52NygNktjxXiHe+uwdFB1F7yWcd6nL+eFspw/UjDwvaHeIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:23:02 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 19:23:01 +0000
Date: Thu, 5 Nov 2026 20:22:53 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "paulmck@kernel.org" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
Message-ID: <auzXjQfYXs_gzx1y@gpd4>
References: <20261105165113.82N-rPMG@linutronix.de>
 <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
 <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
X-ClientProxiedBy: MI1P293CA0009.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::6)
 To BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb66392-cf4f-4e55-b464-08df3b72353f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|22082099003|18002099003|10067099003|4143699003|11063799006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|56012099006|261021123027099003|261009221227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	abJGnxLqkTLHNKJ3YELXOHBuIcuCzdWtLUrJGVXl72zLyC/bDCwHj3B5CksKCLjg0Y4RGXqltFIi3KI5fiiFodukufiXuE7Jku9nK8847WatkxfX8Ph8399/xy67knYLejKXFLKpkQhCd7XP7EGhMf60usHiRUbYqIZIva+HabLRicDA+zMKaP6XWwnAYX6DUDkeVVb0jBSY/r2tmp689nA2thgC6p2A7JN++mrO3B9WAktz4s5GMFSgkUla7KlKAD8FCAQ5apLklKjJnsDv5VVs8UKN8GBZUozDtDpmPk+Sb5EFsqUGzFeJA6zdl3ZwyIDoNAMj/fk48ikMOxtaBm2yYOd4Kt+0vrKuCXgmkz6tHNfrY2F09Ld8oXIpSiqcD+YGSkZg3Meixf8I46NXIng+RWLeCcB/qd3ciqoIvUqN++wMJeFFrNTT2X9aBGwsborIRyQNj+KYohcIMpUjHJJJWBoz8hmFp7FoJGzWYB/4ibIbckzdn8lV0HmBSbAviQ/i92xCAa3HqrSO4G20y+63lRQAbgsv8SpGDIu6yXlIQfPjS8qkuN33u+tk0wDIZMVRAD/WvtMky/uqHsk6Zd2h5i0PaiZEDlZWIR7F85EOH+4AKkYErgzGRHV5kOyXlcISlDBU0GptFZndy0UDHzikPAOM7DxC0T5T1jZPRtI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(56012099006)(261021123027099003)(261009221227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkNUUmR4bHRwclNNL0NtTDdyUDAxSmNSRnprcjBJTVpWUG02QmlhVEEwUzc3?=
 =?utf-8?B?VFRJSXVlYTN2eDJsSXA1WEd1WFZ2RUFBWVdaR1doUDZHd01SSCtVVUpuMnlF?=
 =?utf-8?B?MmRxdENoeG1BSmwvdnNXRVFDZisvSGs5YXl4NTFVSUczYUQ3eFI1ME9FRzVR?=
 =?utf-8?B?VGJ4TFNRRU12U0ErVHAvbVdqUTJpMStwbkFmVzV5S0NaSW5CdjA5UmRPMU9J?=
 =?utf-8?B?MGVvZUlCQ1BSakRoZngra25BZG1vTndMUVVJSGRRNjJ6MFErenVRSi9JL1Yz?=
 =?utf-8?B?Tm1GQ1NBbDhGMnhoMkgrNDBENkxuMDl6TDJrLzhKQmxwR25TdTFwNDdROEVL?=
 =?utf-8?B?TzEwRHlvS2g5WHk2RmFZODRDUnh2OEptZlhnWUpvbjFUTkhUNzBLWUQzUUNP?=
 =?utf-8?B?ak40bUVBOVJlYjR2dlk4aHhtamhXYURoQjVvNDVWK3FaejNNckdiazlsRVRT?=
 =?utf-8?B?ZUQ5emhFSWdNbFY0TVprZEZNL0dJNXdFT2Nyd0tQU3RsMkl1Q3d6VCtaRURz?=
 =?utf-8?B?c1Rka09nQmt5YmZTeEZIK2JFcGVmdWxoNEozMENNVmZKQUgwMEVwQ0hoeVYy?=
 =?utf-8?B?MG80bTRyUmo2aENkNXAxUVQwYXlaS3Y2VE5zZTJkc2dZU1lqemx3RFhJOG5i?=
 =?utf-8?B?ZUhCQkpuZXVsYzg2ZjR1UE5ZTjQ1alVRU3VTVmlvZGY4K2c0TzZtWll4RS91?=
 =?utf-8?B?UmVOM3IzQUcxZitPZ09PMFFFejhKWGZET1VIZWpVOGtucXFMK20yeGRxQ3lP?=
 =?utf-8?B?NENYSzB1RlJyaTE0K0laNkpEbFV6aE1DRlRtM01HZTZsMzZyY1R2UmlsSFhE?=
 =?utf-8?B?VTZ0ZUdQa2trK1Y4UkQrb2RSc3JyanhuMU1OaTRmNFdvb2lnN1RpOWplY0px?=
 =?utf-8?B?Nkovem9yb3BjQS9McWlxd1dsbDZQU0FtNTN3N2VhQi90RFVVNC96N0dpNVR2?=
 =?utf-8?B?VkpTcVRCb1RtMFpXM0RtZ05WVU82b2szS3JOYlFLK29TL3JLbnZyVkRnSHZz?=
 =?utf-8?B?VmFRSjZJbTVEcVZKOTY0NmRBSnEwNzl0NTd1VFZFZms2dUx1bnp6b3FPeDJX?=
 =?utf-8?B?NVY0VWYvWXJvVkJUdTNQZlhqUmlKWFcwVXJJWHhiNjVpbU5qbVpXNUN6RDNV?=
 =?utf-8?B?ckplbEFWa0pSRVBtYmdvOVBNWVpiUWNFTHZkQTQwM3p1dnpHbEcrTEd3YVhO?=
 =?utf-8?B?NkVaZlNaUHJ1YXNVWXY2VktJeW8xOVRyNDF0T3JtMHBCUUo1UWtmTVVwdWZU?=
 =?utf-8?B?YjQrZDhndVJQODYyRURVcWVuYW5XUnk3aUppaU5QRXJmNk4zRW9XMkdEVVp4?=
 =?utf-8?B?eXp6b0JXNEpxWmU0MFdacHk3Mnd2d2tGMG5JcS9aL0ZXYm9RNjM0WWFRc1ph?=
 =?utf-8?B?ZTVMTmFJWVhkeGY0ekExWWd2ZnhGdWFOM29UWE04bm96RUhHQnNlcEdUQTV4?=
 =?utf-8?B?czc3ZVRVSEdkOHZVNkpzS0FpYU5mVll2b1FRV05UdFMwSHJoYWZpblU5dGxL?=
 =?utf-8?B?YUN3WEZBa2RIVGhPSDA2RnlMTE4relJPa21jQ1dvWW5uY2hGS2NyZ1d1WVlJ?=
 =?utf-8?B?dU1UMysxTmxrVFdlQzZnK05UcE9jWEtsNHhLR0dYdjFZNlFxa200KzduMklJ?=
 =?utf-8?B?ODJSblFJVkllVXhwZkpRMk5wek4rZTYwbmw1Qmx0YWMxdVM5ajVWd0l0N2M4?=
 =?utf-8?B?b1BqZkhLVHRYTDNOVDJMdXhHMjM0bTgweUczZVgra0NWY0RFNk5ZMVcrU3B0?=
 =?utf-8?B?K0haK2FxWTNyQnMyUXB5eFVXaTNjUGVFUVhYaDhqUEpyNnIwelQzNld3M1Bq?=
 =?utf-8?B?OVdLUHVoN2tEcm91Y3NDZ3RzQ3I3WWZFaEpUSkVkNmdEbUs5UXJnUnlnU3RE?=
 =?utf-8?B?NlllSnI3b1BiNWtqbzBTbEp1VU53dXQ4YWxGZ0VUSi91d3R5VThoYkxlZ3Jj?=
 =?utf-8?B?VmdlM0JCZnV4VTVTR3BzWnhJYThYOTJhOGFjSEUwRXRZWk1RazRJVGMzNWxE?=
 =?utf-8?B?ZGVUSzVqZjFXeXljYXNxbjZOdDJ2c0xzc2hDUnRrQlF3dDR2bDFTZVZNdHJV?=
 =?utf-8?B?dWpka3hINGJ4Q1M2d2hqQkhCZWdHOXRpNEU5aFI0eWpFNXE0ZDRzMkJZRlI5?=
 =?utf-8?B?b2xmOTdhRXI4ano0blZzU1p0alBVdGkwWmpEUHN6c2Z6VEZMSmVkdEZTb3J3?=
 =?utf-8?B?emNJMnkwbkFJcFZFdE1DYUJXa1JHUk04eVZMRWlHWjRTQzVTZ2pibGtPU1pT?=
 =?utf-8?B?dTF1UVdRVm4rRUJMNHA3azQrS0h1SzdkanF1cE9PVkVTWWVzNkJ4SzVvdzFu?=
 =?utf-8?Q?CNWWd2AIYjMFi6bnRc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb66392-cf4f-4e55-b464-08df3b72353f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:23:01.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLsSz9TUGADvJPAt8+tMZGvEAONMio3P7xYuRgR6OQeh2DzrMkngGoMzLyDuhKrKktnivZcDTENQ7Q2cFvYpMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029

Hello,

On Thu, Nov 05, 2026 at 06:52:47PM +0000, Joel Fernandes wrote:
> 
> 
> > On Nov 5, 2026, at 1:36 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Thu, Nov 05, 2026 at 05:51:13PM +0100, Sebastian Andrzej Siewior wrote:
> >> Commit 450efca7182a5 ("rcutorture: Disable RT throttling for boost
> >> tests") added the ability to disable RT throttling while rcutorture was
> >> run.
> >> 
> >> Since v6.12 the DL fair_server takes control of throttling and this
> >> interface no longer serves this purpose. That sysctl control still
> >> exists but serves a different cause.
> >> 
> >> There is no in-kernel interface to provide this feature, one needs to
> >> echo -1 to each /sys/kernel/debug/sched/fair_server/cpu*/runtime file.
> >> 
> >> Since sysctl_sched_rt_runtime does not do what it once did, remove it
> >> from rcutorture.
> >> 
> >> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > Thank you, but ouch...  Does this mean that there is no longer any useful
> > in-kernel way to test RCU priority boosting?
> 
> There should be a way to disable DL server. Adding Andreas to check if there is a way. But I am wondering if the prio boost tests are working, then is the DL server throttling broken? ;-)

The existing knob to disable the DL servers is debugfs, writing 0 to
each /sys/kernel/debug/sched/fair_server/cpu*/runtime disables the fair
server and, with sched_ext, the corresponding knob is in
/sys/kernel/debug/sched/fair_server/ext_server/cpu*/runtime.

Small nit: the disable value is 0, not -1 (the handler parses an
unsigned).

For rcutorture, I don't think there's a ready-made kernel interface,
maybe we could add a sched helper that performs the same operation as
the debugfs knobs?

And I think a passing boost test doesn't necessarily mean the DL server
is necessarily broken. The server can still give a starved reader enough
CPU time to leave its RCU read-side critical section without relying on
priority boosting. That can mask a boosting failure, much like the old
RT throttling could.

Thanks,
-Andrea

> 
> Thanks
> 
> > 
> >                            Thanx, Paul
> > 
> >> ---
> >> kernel/rcu/rcu.h        |  2 --
> >> kernel/rcu/rcutorture.c | 35 -----------------------------------
> >> 2 files changed, 37 deletions(-)
> >> 
> >> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> >> index d60444bf3a02d..6d1034e49d411 100644
> >> --- a/kernel/rcu/rcu.h
> >> +++ b/kernel/rcu/rcu.h
> >> @@ -69,8 +69,6 @@
> >> /* A complete grace period count */
> >> #define RCU_SEQ_GP (RCU_SEQ_STATE_MASK + 1)
> >> 
> >> -extern int sysctl_sched_rt_runtime;
> >> -
> >> /*
> >>  * Return the counter portion of a sequence number previously returned
> >>  * by rcu_seq_snap() or rcu_seq_current().
> >> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >> index 968343be4e0d1..acab425e72ad5 100644
> >> --- a/kernel/rcu/rcutorture.c
> >> +++ b/kernel/rcu/rcutorture.c
> >> @@ -1333,39 +1333,6 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
> >>    return cur_ops->gp_diff(new, old);
> >> }
> >> 
> >> -/*
> >> - * RCU torture priority-boost testing.  Runs one real-time thread per
> >> - * CPU for moderate bursts, repeatedly starting grace periods and waiting
> >> - * for them to complete.  If a given grace period takes too long, we assume
> >> - * that priority inversion has occurred.
> >> - */
> >> -
> >> -static int old_rt_runtime = -1;
> >> -
> >> -static void rcu_torture_disable_rt_throttle(void)
> >> -{
> >> -    /*
> >> -     * Disable RT throttling so that rcutorture's boost threads don't get
> >> -     * throttled. Only possible if rcutorture is built-in otherwise the
> >> -     * user should manually do this by setting the sched_rt_period_us and
> >> -     * sched_rt_runtime sysctls.
> >> -     */
> >> -    if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime != -1)
> >> -        return;
> >> -
> >> -    old_rt_runtime = sysctl_sched_rt_runtime;
> >> -    sysctl_sched_rt_runtime = -1;
> >> -}
> >> -
> >> -static void rcu_torture_enable_rt_throttle(void)
> >> -{
> >> -    if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime == -1)
> >> -        return;
> >> -
> >> -    sysctl_sched_rt_runtime = old_rt_runtime;
> >> -    old_rt_runtime = -1;
> >> -}
> >> -
> >> static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long *start)
> >> {
> >>    int cpu;
> >> @@ -3390,7 +3357,6 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
> >>    mutex_lock(&boost_mutex);
> >>    t = boost_tasks[cpu];
> >>    boost_tasks[cpu] = NULL;
> >> -    rcu_torture_enable_rt_throttle();
> >>    mutex_unlock(&boost_mutex);
> >> 
> >>    /* This must be outside of the mutex, otherwise deadlock! */
> >> @@ -3428,7 +3394,6 @@ static int rcutorture_booster_init(unsigned int cpu)
> >> 
> >>    /* Don't allow time recalculation while creating a new task. */
> >>    mutex_lock(&boost_mutex);
> >> -    rcu_torture_disable_rt_throttle();
> >>    VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
> >>    boost_tasks[cpu] = kthread_run_on_cpu(rcu_torture_boost, NULL,
> >>                          cpu, "rcu_torture_boost_%u");
> >> --
> >> 2.55.0
> >> 
