Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3473D1CD7;
	Tue,  6 Oct 2026 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322079; cv=fail; b=GSd2OPzCtG8ZtVAJxmY2K5OF06pKDu+owngRYvIkpQX6oMkOmFlL4MRXaNOw5o+wutyC10yDaPiQwwYrDh3ZTN6hsROXx83sHbAqe6SwvRBgNLM0x7u64d8IzkqonLh0QDKrWkH+z0ZkOvR9BBx8g8h6zc8YI54DAWCmN7s/fuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322079; c=relaxed/simple;
	bh=LaHoQ7zj3AI6b1l/hCPyQdvNPZLhnFBzgiyZ7hKbr+0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kvmv3ZMmHzM/p6MyYXhrDxr18hNB2+QK7RNuoz4fzfuGB4ovw6hiaEpgbQWq4jB7iw/8yZ3+FNpXdYwj+QG+zRHNQ1hyUNcRUJx4x3wylNZzallYgunF5/Lvp6zb9z1IhUaYMGEA+XnUkbyasnFIdUhHKA922Y1fhKzwidFlrOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M+MgsBZn; arc=fail smtp.client-ip=52.101.57.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M+MgsBZn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqfYXmgEfUcKalXR0Xx55aWOOX/OZVvB8UB23Zp6HzWd9paCIF8n4nswdLplyEriWff7ykn2I406IA6cQNvWaPy4ql1mOcuf9LENkMGpVAutY5E1pcS0uuCZ7c0wizFmhQTZySZcUmRMq7f5dfpu3OpYgAAfa/BrUsVPFRSpvWbqvIxgqLIeJc7MXaw3jE0UBzV9rERSZzyPvX49wK5t6Vrnda+nDpLqe+25sF3T5G72qcoFLHwN4jqb+GyBA7v+Ma+TmvbOrS84yqkNKiagdEgSBf04yRvkLao+Aveuhel92IdVpN43UxMZq1yiKx6JBr5X4VmNmrhaoGboe9hT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FlBTRiOpYN0yzmQgMRKnim5X+iO3GqxWNfiua75n0U=;
 b=ZgsJPvKLjD3pRvqHvQk5QUId8vLc7TLRjGzppzV3tdvO4rrViGF8O2VP1Fp5DergjrUNLrvKzMMXYkPpEpLt6Nfokg2OMOniG7+YAdvTQDPuJX+q2EhLWfugbiDKj0DZjX05XVsbkfA23zc+MS8kf5Ipnj5k57A26DHKpWYMBDAVL/pIYMkPtMUrhyPiOKf0XhuldZ6HETkuQ7agccXBKus4qn5QmDqt93iEf5dimW0mgos5AHRl+y8h6Z7Zd/Al9rSkOmaHuTcYl1i267hUYZRrhEMQ8FhGDTutdCbc3e09sg10gn2ShwkZvCMPheV64cuQPJA9/4zECogAxvsmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FlBTRiOpYN0yzmQgMRKnim5X+iO3GqxWNfiua75n0U=;
 b=M+MgsBZnRwMrXKg25E9Y9aJeNMSv1gZPLqnoiJk9SO3KsVRS+yXLaHVQmB6mAmeGSElxlKeS0jr+dfhZ2f1FbDruzwNiqm2ML5OgzW1I61JcbRl6mOHSwJX1GaeKTRxccmIexJhYB9t0P7WJi+1L++R5uxiAF1IXfwI3GKuB01enfdQ5c4WtbURvsx2uVhe7KQQiir1+/frffL8da9Zc4W6502sNNcqMNj9Rh2LQ26nGekmINTzpp+e7D95xTEFE+SwwzDztBffowc8V2O1PwtlKKXDnNqLteCmmwgfLKjZFoWTswZHAQrMbyqvg4eG2j3R5VzwLIoCey30uMIJNHA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) by
 SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 21:27:53 +0000
Received: from DS0PR12MB6487.namprd12.prod.outlook.com
 ([fe80::f923:10b2:e6d8:d47a]) by DS0PR12MB6487.namprd12.prod.outlook.com
 ([fe80::f923:10b2:e6d8:d47a%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 21:27:53 +0000
Message-ID: <53383f19-3d54-405b-85af-f597b69befe6@nvidia.com>
Date: Tue, 6 Oct 2026 17:27:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Enable runtime reset of the RCU stall panic count
To: Cunlong Li <shenxiaogll@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>
References: <20261004-rcu-v1-1-3799a44367f1@gmail.com>
 <00F6D386-FE41-42E3-9B89-07381A49E061@nvidia.com>
 <asThhHxoFP2L25Nc@63b45mr6s164qmn>
 <A522703D-CBCE-4F3A-9CA2-968BA382166C@nvidia.com>
 <asT08QHOiIJrfIIZ@63b45mr6s164qmn>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <asT08QHOiIJrfIIZ@63b45mr6s164qmn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:208:23e::23) To DS0PR12MB6487.namprd12.prod.outlook.com
 (2603:10b6:8:c4::18)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6487:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 6edeb3d0-ccee-44b1-d1f4-08df23f0ae45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|11063799006|921020|4143699003|18002099003|22082099003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	B87AjezygC34GLxR1kjoo2icQGpSuh2m9/s+sWI+N4qHHB/6wHk5qusPUjyUoKdvNcmFYMVp5RqcsxKStW6kqwlmEtFg54+ndhRCHNDG1xehE4n/rZRXEej5DnJiuIxSpAiydMKBNcmd4bq/6dz4fnIZPPZbP70rs/54gPP4CV68RcVIJhfYCbLPd6gjqV+XReD+ZEnWmjMjLz0DevuRkMb3g2pkML5TWHnKUFgyUcbBn5ktiJk1JXs/qg4apDQwk4N7YXTiirGRA3+VFUTm/OqWRVNekozmkKR7HvhHssUm1VpJPn6TmEQQ9J2K8NgsQmISAfjraq0MSzW3K4LfJMAYnmjQpyO5rNp0Hi89tUHoDiPs6q96dM/S/eyD+LbqflKcpYF0sAgnVQplA8hS4H3D6rW6s/jzraOh1WLLN3OWRNPJaHRqXogNMQ4QwHRi0Djafm80zfH6v/nunfy/fYGxURSkCBzggFhEKJ/mZeMYQNENd9jokbbuj/UzaVmywhQihXve6+pGyBOOUEuRixrC0R+kj/sccD6XvgXGGbV5x0LGI71SDAQE/AxOrrX5+BnPMyYZRESLOoKm8QGtByH5ZVqa1yyJmqLzCLoi+5byWhokfQrEebJ87KyfOviXn6SuRDcH8VmHMwNaMTTO89bfESHmMbkY60AwvfxLNLuRq3MY2mYAicQYGxkbhmUoK+u/NUfxvb1bDpYkaUpMNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6487.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(11063799006)(921020)(4143699003)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGoxWXA5Ri9hTUhqUkxFSGMyQkNadXkzZlQ1NUU1WGRpQktoYW05QlNkd2lM?=
 =?utf-8?B?TWh3MVlKY0xGY3pIdGJwc3ZMK3BJVUNEVW9QN3RodkRnTTlTUFU1MnZsYmJT?=
 =?utf-8?B?eEtzQ1VaQXFsbWlHRjgwTGc4cWJma01RbDJwYkZlb0pTSlB2djQ0YlEybWVQ?=
 =?utf-8?B?QjdKTEpYaXE0UWVWWVJuQm5pYXRlYi9OcVdERkxPcXFucENqM0ljSVFidzBq?=
 =?utf-8?B?RWQ4clBzUjZCM0FuRHlFejdUa2tWdVpjdnEvR1hudzVDNEhYcklvUVp1cGdx?=
 =?utf-8?B?MDJPdEZobndqRHVXZk5MWXBiZlVJSGJZSktpWG9DVDRwT0FTRVVveG1QZytW?=
 =?utf-8?B?RnZMR1kvdkJNY1FFVis4ZDl4aTA0ZHNKWXJLOHFyZ1RGQktDZUZkYndpSnJJ?=
 =?utf-8?B?ZHp6NVBManZUcjVHZmQyeHp2cXVseCtZSTN2QlZDU1czeDdXR3E3S2c0cENq?=
 =?utf-8?B?QzhOOUl1QW9HbzZ4TWpPQ2FxT3dPanJOK2FyN3UwMy94YWxidFFXSHlNL1FG?=
 =?utf-8?B?TVpKUnVnZGVYR1lYUExNcHdVRFJDUS91dExoK1h5YnJzR2poZTlvSDdIWDUx?=
 =?utf-8?B?TjVXejV3clRkOWduRjJoSFZWMmwwODRLYXZTeTh4cFVxSWJsMnNpMFJnb1kv?=
 =?utf-8?B?WmtEZldqRWFFbFpTMGZ6WXNqRjcrc2dWT2Flb08wRDRpeTJTQWl6UnJOMGpm?=
 =?utf-8?B?aGthc1YxTy9uMG5rT0V1cFhUODh0WFZnU1ZMcGwxQXVwZkJaTGVTaVB3b21F?=
 =?utf-8?B?VklydzZkdjByNVM5OEVkazZmUTJCT1BlV2VVa2VrTkRFYkU2eFk5YlpHS2pT?=
 =?utf-8?B?YURrZW9GTWVMbkY3aDBCT0FKUDZZb2hzR3RBMDRLelp2dGdDenBNQzBHOVo1?=
 =?utf-8?B?YzVDOFh4eE9MUE5JZi9wd3hsbGFIVlFzTVFQNS91QWFlWFp4VE1NR0RRV1RF?=
 =?utf-8?B?aUg3SGJRb1gyUVFmODlzY25DZWV1RmJjZjhMNENSYWpYeFdWOGJmdzNBVFhK?=
 =?utf-8?B?eHZIODRzUlRoTzVVaVpBUVFyYy90WWtNOVlqV2FqMTZMcHExM2VpU3JIQ0xx?=
 =?utf-8?B?MkQ3aWN6N2VEbUlvc01lMlNkUSsxdUMvY3V0YUl3RkMxQUc0Qmtxcm4wello?=
 =?utf-8?B?b2xrUTRjZldGVTZrTzhlTUZ4TS9vL1JvTHNBYU9MSDlaWkFwUjQyRHRCNk45?=
 =?utf-8?B?OVdDNVpObzMwQi9CM0dFNzJwbzJZcVBrbUR1L0xBMTFGVGxPYmVYdzc0L0xV?=
 =?utf-8?B?c0x4cnVjbC84aG9aeWZRS25OUWt3SjE3VUxuckJMRWVsRkluKzUxaFQ3Y2hN?=
 =?utf-8?B?TGdmT2YxSHdwcGlFSktqSW1BOFoyNmZJc0pUMXB2eFdWUVQxa1RCTG9mcUJx?=
 =?utf-8?B?WGU3dDdSbnpuU0tGL29OMWZsaWtjZk9TZUpyNHRTR3AwelI3ZUVYYWpPd2p4?=
 =?utf-8?B?aE1kcUptbkdQb1V0cjNLT0dLWkRVMHd6Qk4rK1hxenpmeGo5UWl3bVJHajRN?=
 =?utf-8?B?YXZsakJwV3dyYWdHZVF4SUdYRXJKQ2FVc0dtSVU2OXhtc29EUEx1SXFSaElh?=
 =?utf-8?B?a3lJaDVsRk1VZENXSVpGUlhHYkowVlNkYmFaQmRIN1J6QTkvWXRyNXRWQ2x5?=
 =?utf-8?B?UVlhVzRhVXZZOXo0cXRmREN0b1NsaG1QbmxBd2FjYlZDVnplSGRobjB0MVFu?=
 =?utf-8?B?elMrTGhVMkFTQzBlVDlxeHlXNitTTU9NRkw2aUJ3eXlTUXZSa0YwNjlQS201?=
 =?utf-8?B?MVBuWU1odU1wOGFFbmcxNnlFN1dOdDZjOXMzNVlKMVVVbE83R3U4S3RTUmpN?=
 =?utf-8?B?a0dqTFBPK2Y4eUw5TUg2ZktkYWVlaVNVeStkWTZXTTNVdlhUbVkrTysxSGRJ?=
 =?utf-8?B?RkF3S0sxdlZ4MGtYSldIaXlQUWRyOEtGT3JsckxSbHNVek4wR0Y5bDMyYnVx?=
 =?utf-8?B?c0s1Zm42U0xzVTVNWTAwcnlVRjVUTlhnUWtFOUNEVk1aOXRlYmJWekU0RzRW?=
 =?utf-8?B?SStaU011a3JFanNpZ011Z2luZCtJdVZxTktxaW5tQWZWZGlGOTZsaUt4Z0xJ?=
 =?utf-8?B?eHFmOEZDdkJwYWl4MGM5cURvbUlxc3d2bFB1bjBYL3oxVHgvaHQ1T0UrdDJa?=
 =?utf-8?B?MDhna0tzbG56bkVHbU1odUttamQ1NkJrOXhrUHdsODdXNWNOdytzV2xHSnhD?=
 =?utf-8?B?L0ttemFTVHNueXNuWktzdFNwc1hBUUpoVUhYL0R3U0o1QmdZbXAyVWxUY2Ny?=
 =?utf-8?B?ellWODQxa3FPdEw4RnJZRnNUTWl5OHVIaXh2WXFZd3NYRVFMdTEvdDhhcFNn?=
 =?utf-8?B?enViNUlmbTNCeWdjdk4rNFVLK1BpajVRZzRqY2x2ckV2NmdMeWZUdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edeb3d0-ccee-44b1-d1f4-08df23f0ae45
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6487.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 21:27:53.5034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6NbMntJ6QfETWtHPzketpqD4s/t94HDSvgjB3yq6sBNuHl/FzRaR6pwOmG8SMWn8tG7U/TZIQ1gRQ+mqefRsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974



On 10/6/2026 9:17 AM, Cunlong Li wrote:
>> It sounds like you do know that it is likely transient - but based on this description and the below, it sounds like you have not yet found a use of this patch.
>>
>>
> To be precise, we worry that some of the stalls were transient, so a
> panic reboot would affect the users.  But we have no hard evidence
> either way: every incident ended in a forced reset, and the dmesg was
> lost.  Going forward, we plan to enable the NMI and kdump to keep
> investigating the cause of the RCU stalls. We will also monitor dmesg
> to confirm whether transient RCU stalls actually occur.


Right, I just worry that if you're not seeing recoverable/transient stalls and
you start using this patch, then you might be causing side-effects that don't
really help your problem and might be masking the real issue. It would be good
to debug this further, and fix the right way IMO.

If you show that this patch indeed helps your problem, we can consider it for
7.5, but there's little bit of time. :-)

Thanks,

Joel Fernandes


