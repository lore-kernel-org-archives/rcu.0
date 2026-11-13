Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794604856;
	b=UelElchnVGWEdVmPenRKBhuL4D/eoZKNSkw1N155oiz8yheqRb6iYQD5y5pDW4Qra+zA
	 0/g5lBghk/awf/jryW9PM1v/X+R/9XMInWb97C9fJIsJBfEsulhxvrnlZACxMh/Opq6AI
	 WSsLdNwQRDXd2+sozTg2d35IC1GiVjyPBUf9BBE5NS76b4kFhAoXKo8jRJAyoFDsdpiTT
	 a09rUHzGFaeA8EoO8zhVU+qmKMv5R+VLIqXDtxoAWjB7cXMEacAOo5zrk53Ms4EUc39cW
	 ps2+pELQ1qe6YyiwxdJ+0JIMgP/2xhiAwo0AAfHLFcSpOljPeU+8qpi35BRaeOc7rhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604856;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=RqFqcnHaV1w08hu/LhmUWUGat1nG3Uq2/8ND5ATD9S0=;
	b=konP/HsqgeKaYFPRg8LlqL5NJVpjGRpSmW0vG2wRGjJPKhz8OLTX/bmYFIwBRlugJuDl
	 LlBZVtNNd7a/zEk0u94VrrLBt0PNjj4OWLsVgF9Vxw2U7V73k7OFX/VOTrs5O5NVw6TRo
	 ECeYY7GjzL2Vx05+wPpou+nUj0d4JFGHV+kmzlmBTJ1OOCMAbGdlc7I+nE49wnupB+piA
	 mEz9kq8kP1WSz5XdB+0tB3TGDoNOXUYqJ2Aw6hfVI41/WUdbj1qtOEzTp+r7FcmwYmbpQ
	 w/kh9JEW5eqz+WaiUlcH/UQZpVv4p00BsM8yC9V8PdSHvKdLHT7s0XJ3LC2HpLNPZ6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fILRthr6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.0
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF491606A336;
	Fri, 13 Nov 2026 21:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF491606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fILRthr6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veUI2ntCAqcYdjH1tonG1ed5QDdMrkcyNIoK6Uvy/WkBVaCopZJilzmX9j2pGtGUUOEV1LrSNG7YT4ZOQiRSE0hQcUSyZ0Scl7y1/K7uYFcTPmqquBmgPXvWd2jS5WLqDakv8NyJDKH6vWtcKwlWmwsF0z0op9YqxgJpVTvJpXF2JaGoNf7X+ByBgaEt6Fa8UFTPyiHyqtN90pBgY+0ccrcuyQOGHatKA9d/lI6RvS3D7g7BxvV8s8kI+cXpT3zwMLl9l7EVkx4unfI2OtjMndzdpyS3d4o9kyvly4HEX3JzlPR4WNnojNzn+i/52+Bq9O7HOFFgfCZ2eXmFbNS1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqFqcnHaV1w08hu/LhmUWUGat1nG3Uq2/8ND5ATD9S0=;
 b=v5/R5leOUSzcr5AvmDa0ZFKb//LpdjLB3zQ6W+tJqmAKJ7D+/guD33al8UHkz9VbJEnDo3zNhD1sOVpzmPHMjqUdsxa6Yu/axj3qvFhYb4vSq4kMGyxwwvk9ueUOqDA2TkGJUxpcZHQ14Tmw4MrgT4+wqAgbbCMBxeawe2xnBYcd33/9qfo3NrEMOz5fn/a1PRGY1bTrdZSg0gziFjMuloAXMuKeP4YqJ2GF5KedE5x8QY+mjepy/R5iCWqUEkJbddgXEWdax1eVydnQtKF3sROuvvHh5wzBBEB+0Mm5V/12afsGhvhhkXFqoJ78vHm3duZ8pbLHA8Mm51OBTdL9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqFqcnHaV1w08hu/LhmUWUGat1nG3Uq2/8ND5ATD9S0=;
 b=fILRthr6rsV4xpA7G6giW+rOaOEvTqgLYZVc82UM3MVbx8/MshFb4WGFmLwPO4TJbqkbaBpxGbBIYO+mWyTpQTZe/32Tz2slRE7wM41axtkFGwtsYqRTmhIKzuH3GWiAFL8eZCD4kQfdhEpIs1t6wZzRE7d5j8oEJt0rbK8qyqatsU7FvHVQzcCSjKa/j5l7CRRH0ZLtaSK01oVvuqRLzzKeqytOcmalI02TSldRwUir/f/JQtBe+55LZxFWFbAk1yiSpi6OnL1sUqMDFOv6+CWvSuAsYwiOuOQ9F8ZlBxjSd07tvUQpx1wUCV1gRzpUqxXHjzTXBn14IgVR8REhDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com (2603:10b6:61f:fc00::622) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 13 Nov
 2026 21:20:47 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 21:20:47 +0000
Message-ID: <a134c923-ddb0-4ac1-8b99-473a0472aa53@nvidia.com>
Date: Fri, 13 Nov 2026 16:20:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/7] rcutorture: Rewrite RCU priority-boost test
 around a CPU-hungry reader
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
 <20261111213826.2035045-2-joelagnelf@nvidia.com>
 <20261113155301.Rs-PyiuR@linutronix.de>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20261113155301.Rs-PyiuR@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:208:2be::34) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a70b601-b9f0-4a95-9ee5-08df41cbfbe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|10067099003|4143699003|11063799006|261022105027099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022075727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ECfpLIQTvXY7uh2tV4JIgAGad263y3xEtJXrQW09Wqk84JksEp79B4gGpjoEQ9JU5Zt6C0B6S6zkRDYvXCdS1Io6HFVCIrhe/GpttRiZWmX2GUhHzqQusiDeyajQEjp3DytaOsxCgCezFIGWjRIW2WQJx7ww2Kb5Q4oxyybQcFNt/n4/8FpLIDFwwBqDxFi18NBhwDjx1C8jSZzJSylp6VMSp5KFY4g/6nTErdMo9cAxJ/Sv8GqNf1vTu1e4oMav49roJ9hQjYcnKBNey6Ik77b3Gzn/zJ+3wIJEfJfurCeXI/aBJNdS6PKY5Z/PwtUe0Ee6CgHs+BZOjY+loi07bvaZTptxtkiDIn7p7AIabiUZOAns//nVq2TsZN+mpnjybSYBP20yrqnGxlRiJ57dJCBPSeaiwngGJJUmjC9nhz6FFVj+4Nlt5U56PreW/ObhWkQM0OcrHdYgKbHRC4HA/fdczJLUynrLCwv4y1mmudb4oggQsFZ2xmqL+Xo4lr0sYqEaNUZiMeWi9ruMJ08UwSUEyfg4Noy9+YJj81KzVk6T7QBJXFz5NFMAh6AOIGKu9zFjnNs7VwcF2J0zh0PFNCN7kMiO5yAZj0deXyiUW2r1OmliKUJuEv3SCGFmZPWMuFnI28TwgNcZShECObI8cylcCfnTAZOYpwTjOrZxrms=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(261022105027099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M05jdGNya3dyaWFVOENwd3dKSUtHZExjMWhaNE9mcDViQWV4bGc0Z25udjRl?=
 =?utf-8?B?cm5wQVlGV2N6RFlmYXdnVWJSQzY4Z1pPa01iU3lWR0pyTkE3VFN6eWZ0TXFn?=
 =?utf-8?B?YksxcC9sdG5ENXlYQ0JuWkpKWEFSdzFEMVgyYkR0TEI1MlVoL0l6NWZudXlm?=
 =?utf-8?B?NmVvRFdNblVrWjh0ejk4ZkMrZDAzN2ozZWp2NmtzTk4vcFFNVFZzQmhtUVI3?=
 =?utf-8?B?VDdDcitHdU9xMEd3NmdNZVV6N2o3QkhnL05yM3JwNC9wSEczRVZacGpsVzgv?=
 =?utf-8?B?OG8xVDQ5QXE1VlJEMWFBVlpCVHVseVRYL09mU2NrNmxleERrNWN3ZzRGNkdU?=
 =?utf-8?B?VTJOM0xSQ2FjTXhjY05WTDRNM3ZXSTJFL1JGWDVmb1pjU3NVNmFFRlhNNmZT?=
 =?utf-8?B?R2Rmem5DZ1ZxR3Y3Z0w2L3krWldlcERXY3ZjWTQxYWthaWFKeU9VYkJkYlBk?=
 =?utf-8?B?U1Z0cnU5RnpGUms3cDFYMEs2YmQ5eXVjT3RyMzdBcFhMNUFwMjVpTmpqWUtT?=
 =?utf-8?B?eVBGbXJrZkxXT2RuSkgxL3hoYnM4M1FvNzREMHpMOFhLRy9jYm9mdm12cVg3?=
 =?utf-8?B?VkhJdnhrZERxZDVOQVZTVTMrdFdvRG5wUDh0VmdrWWFYL3JpZUhMMk9NTEZF?=
 =?utf-8?B?Zll6WHpKS2lmNEdTblJHL094c1YrLzJuQnFWalhPNzEvTm1JZHB4d2FlcW1r?=
 =?utf-8?B?TUJ2ZFNOR1NxYVBnNk9EVVRmNDc4YU1taVpHRFFsMDdGVmFZQ1YzVWErVTFv?=
 =?utf-8?B?b1dsUmJoRk8xSk9iTC9CMzVoZkhVRTkxaDNEU3BJRlJqcWw0VkRFTFFrUnpE?=
 =?utf-8?B?WkFDWjZGTVJVS3RFR1UvR1hKS0w3aHpadWdGcjZ0dGRDY3c3TTB5bDB4ZTcy?=
 =?utf-8?B?empoSEZpSHQ2SWFjbG1TcmdZbmVhK0J0OFNZTFF1Q3J4L1F1REQwM05rZnJn?=
 =?utf-8?B?WEFNTUxtWXJKVHJodnJ3Q2pPcWZOdDczdDRoaW5FUG1XQm9DVGhNRCt1dHRT?=
 =?utf-8?B?SS9FN0hwR01yMCtwUWRPY3l4alN6RTdzeElzSE04MFhuNjBQUXo2Z1pFTUx0?=
 =?utf-8?B?MmdhUlh3eWUvS1hDUmpzZ1B4VXBlSCtFVzF0RUMvcHI2VzRDS0JIVXFDekFK?=
 =?utf-8?B?QVhOUlMybnpzU29EbWtkempwd1dmbXUxeDRMZUdPM3dQN2swalZQYkRFUUZ0?=
 =?utf-8?B?WFB2elI3enFFcnl1N1JPSUg5MDNyVnFiMWlISW5pRmRxS2paeUZRMytIQ0h2?=
 =?utf-8?B?MEZyV3pndE93c0FjUzFSVVVUdTlFM25BelY4cXI5MDVCeDRFWmdNQ3o3ajNx?=
 =?utf-8?B?bENKT2hqSXN6ZGVoeE5OK0V1NjNsMWRuQWF1VGtmZEx4S3ZRQmt0cTFJSlpR?=
 =?utf-8?B?MGUwNVpPLzBHVWd1SmRxc0RIbzlvNXY1T1JNWGhUU0lBSjJqY0diUmtoVzk5?=
 =?utf-8?B?cGxYQmVTcDdKQXF3QVgxTUI1SG93ckdrTjR4N1FiZ2M0THZzL3VsTHF5eDEx?=
 =?utf-8?B?MTJVMkg4K3hrZk1lUVVDK0tmWmdTNUovNkIwdzcreTh5ajArL2I3Sjg4MGJx?=
 =?utf-8?B?NGdpeW9NcndMYW9kclZJZDBDeXFxMjZOVDhnSzN3RTdHekQ4QWpYQklGOHMr?=
 =?utf-8?B?RmlTcFV3QktLNFA0NWxJYTN0RXZ2b1RvYVFoeDZKb3NLb2loMXd4UEFTYkNZ?=
 =?utf-8?B?S215S2g3MlB4OHFEY0tCU09uMkh6Mjc3Mzl1TkxLUFVpZGg1S1B6azZjQTly?=
 =?utf-8?B?OFVuSDFMRm1IM3h0c1o5aHBTZUtnd3lRcEZ4bUs4YzBCWHBuNm5CUE96ZUkz?=
 =?utf-8?B?QnlnZ0U3NzZlMjVzVC9jRlg5eXpMY21YMEJNenBFN256Nm94Vk9SN1A4TGh5?=
 =?utf-8?B?d0VTTTRGdE9xWTFueGdTQmtNWVFsaXFydVU3bUM1WTBLV3RlbGtrNFM4RWRM?=
 =?utf-8?B?WVVWdmRDck1VdVpYbkZ1Tkd3aVhiVjRxTG0vNHFzK2VVcVljR0dGU0dzVCtZ?=
 =?utf-8?B?L1dUcFUxRmJxVCtjeVBocGYyUDA0akM2YVFqQktZWEZRUXVKRWl3Z2hKdk9y?=
 =?utf-8?B?RkZia3BRYzNpdUlaTVJmbmNjVm5QQ0c4VEhQYUxDUTB5U0txeEFFNXRwaUFY?=
 =?utf-8?B?Y3VkTWhxYzByMGJkbW5uYjFZUlcwbnJMcmxYVnBUWFhleGVkN0JZbjB4aUtm?=
 =?utf-8?B?cmxLbUE1YjZGQ2dVcG94UGJ2L0ZtU1hWcUV2Ui9KSU5qb0lkQzlSYW1CLysy?=
 =?utf-8?B?U3BRR2lVWnhDdXpNV1BlVHRwNzVHejcvRUFaSmdoTlA4TzhLMEJWbVp2MWZN?=
 =?utf-8?B?T1QxNklXNGo4VkpFRCtXYVZPdFhxRGY0SlpsMlB6TUk1MWZOTVcxdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a70b601-b9f0-4a95-9ee5-08df41cbfbe8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 21:20:47.2133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NImqbv7VqYOhhyxNkgl5LmgtOl+9GxMoq5vF+xH9JxO+GcmBYUjoms3t69U3ytqVE3YPE7gnZs48pYRlpTyE9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859



On 11/13/2026 10:53 AM, Sebastian Andrzej Siewior wrote:
> On 2026-11-11 16:38:19 [-0500], Joel Fernandes wrote:
>> The old boost test relies on RT throttling being disabled and on grace
>> periods taking too long, which is fragile.  Instead, each interval one
>> CPU runs a normal-priority reader that spins inside an RCU read-side
>> critical section until it has consumed test_boost_reader_ms of CPU time
>> (measured via sum_exec_runtime, so time spent preempted does not count),
>> while a SCHED_FIFO hog on the same CPU tries to starve it.  With RT
>> throttling enabled, an unboosted reader gets only about 5% of the CPU,
>> far less than it needs within test_boost_duration.  If the reader
>> finishes, boosting worked, otherwise it failed.
> 
> What I see from tracing is:
> 
> | rcu_torture_boo-2066    [001] d..2.   237.448002: sched_switch: prev_comm=rcu_torture_boo prev_pid=2066 prev_prio=120 prev_state=R+ ==> next_comm=rcu_torture_boo next_pid=93 next_prio=98
> 
> preempted as SCHED_OTHER
> 
> |          rcub/0-16      [003] d..3.   237.460085: sched_pi_setprio: comm=rcu_torture_boo pid=2066 oldprio=120 newprio=97
> 
> boosted shortly after
> 
> | rcu_torture_boo-93      [001] d..2.   237.460108: sched_switch: prev_comm=rcu_torture_boo prev_pid=93 prev_prio=98 prev_state=R+ ==> next_comm=rcu_torture_boo next_pid=2066 next_prio=97
> | rcu_torture_boo-2066    [001] d.h1.   237.463994: sched_stat_runtime: comm=rcu_torture_boo pid=2066 runtime=3908069 [ns]
> | rcu_torture_boo-2066    [001] d.h1.   237.467985: sched_stat_runtime: comm=rcu_torture_boo pid=2066 runtime=3991212 [ns]
> | rcu_torture_boo-2066    [001] d.h1.   237.471995: sched_stat_runtime: comm=rcu_torture_boo pid=2066 runtime=4009726 [ns]
> 
> back on CPU and not pushed away.
> |  rcu_torture_boo-2066    [001] dN.2.   238.397969: sched_stat_runtime: comm=rcu_torture_boo pid=2066 runtime=5311 [ns]
> |  rcu_torture_boo-2066    [001] d..2.   238.397975: sched_switch: prev_comm=rcu_torture_boo prev_pid=2066 prev_prio=97 prev_state=R+ ==> next_comm=kworker/1:3 next_pid=1386 next_prio=120
> |     kworker/1:1H-745     [001] d..2.   238.398067: sched_switch: prev_comm=kworker/1:1H prev_pid=745 prev_prio=100 prev_state=I ==> next_comm=rcu_torture_boo next_pid=2066 next_prio=97
> |  rcu_torture_boo-2066    [001] d.s3.   238.398122: sched_waking: comm=kworker/1:3 pid=1386 prio=120 target_cpu=001
> |  rcu_torture_boo-2066    [001] d.s4.   238.398124: sched_stat_runtime: comm=rcu_torture_boo pid=2066 runtime=63431 [ns]
> |  rcu_torture_boo-2066    [001] dNs4.   238.398128: sched_wakeup: comm=kworker/1:3 pid=1386 prio=120 target_cpu=001
> |  rcu_torture_boo-2066    [001] d..2.   238.398130: sched_switch: prev_comm=rcu_torture_boo prev_pid=2066 prev_prio=97 prev_state=R+ ==> next_comm=kworker/1:3 next_pid=1386 next_prio=120
> |      kworker/1:3-1386    [001] d..2.   238.398137: sched_switch: prev_comm=kworker/1:3 prev_pid=1386 prev_prio=120 prev_state=I ==> next_comm=rcu_torture_boo next_pid=2066 next_prio=97
> |  rcu_torture_boo-2066    [001] d.h1.   238.399986: sched_stat_runtime: comm=rcu_torture_boo pid=2066 runtime=1851337 [ns]
> |  rcu_torture_boo-2066    [001] d.h1.   238.400081: sched_stat_runtime: comm=rcu_torture_boo pid=2066 runtime=94860 [ns]
> 
> The fair_server preempts now and then.
> |  rcu_torture_boo-2066    [001] d.h1.   239.455988: sched_stat_runtime: comm=rcu_torture_boo pid=2066 runtime=4002590 [ns]
> |  rcu_torture_boo-2066    [001] d..3.   239.455999: sched_waking: comm=rcu_preempt pid=15 prio=97 target_cpu=000
> |  rcu_torture_boo-2066    [001] d..3.   239.456012: sched_waking: comm=rcu_exp_gp_kthr pid=18 prio=120 target_cpu=002
> |  rcu_torture_boo-2066    [001] d..3.   239.456023: sched_pi_setprio: comm=rcu_torture_boo pid=2066 oldprio=97 newprio=120
> |  rcu_torture_boo-2066    [001] d..3.   239.456024: sched_stat_runtime: comm=rcu_torture_boo pid=2066 runtime=35773 [ns]
> |  rcu_torture_boo-2066    [001] d..2.   239.456032: sched_switch: prev_comm=rcu_torture_boo prev_pid=2066 prev_prio=120 prev_state=R+ ==> next_comm=rcu_torture_boo next_pid=93 next_prio=98
> 
> Leaving the RCU section and getting de-boosted.
> 
> This looks good.
> 

Thank you for testing! I went through your other suggestions and they mostly
look good to me, so I will revise the series and post a v2.

> …
> 
>> Success testing: with the series applied and no other changes, run
>> TREE01 TREE02 TREE03 TREE08 TREE09 BUSTED-BOOST for 10 minutes each.
>> Every scenario ended "SUCCESS" with rtbf (boost failures) of 0 in 59 to
>> 83 boost intervals.  (BUSTED-BOOST can no longer fail by construction
>> because CONFIG_RCU_BOOST is now enabled automatically for preemptible
>> RCU.)
> 
> I didn't run the individual tests but checked in my rcu-tree setup that
> boosting works as it should and that it complains once it does not. And
> the throttling of the RT tasks has no visible impact.
Excellent, thanks!

Joel Fernandes

