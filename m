Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D051F4183;
	Wed, 19 Feb 2025 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977753; cv=fail; b=S7aBb99dcIyfyl9l0RX4mvP2AjSE68AG2vUict5ocCsVz6i8H+l4MZ8EBshOxQvskx2J6t+dbHpMLU4XnYO2tGterw/pQaHm8bctQH7+LJJiioBc0CwwQsLWSoBO4zSnVr1IlQ8zZraxmXkV2VLR9nVNTVw1RXg5OPsoCZPy5MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977753; c=relaxed/simple;
	bh=g84B6iWzEWVG0nrYJ+fFLNTwM/t2ONhiLgK+nRlibhY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Foy8HISMh//A3YdFL548ak1m2bPAiZ5WHDvEXZ/uSr5IttB7e0FE6snxGonmZgPoynr0hIAZaSMyE3ZdcRMYiiw+wKNJaOiKzoSSokS/jWgtR1673tr1XnNmniHzt1gXoDdUmQxn9ehSqVWGzRtm6qP6dLBUmb8ZdFRZBMHedi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fuHP/PKz; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fuHP/PKz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lbk4PjQPMVuz3oM18RpeH+CUbBfbQC6UUHc7fW7k/efGAz8D/VhbnLbFm8RALzKT7omCcYZUyPtqf3updVcy6lw3T9p58qVZoVfAGS6VSXQmiKdxYzxczk49BA2SalUxPJRC181VW2FSz9dV99g9szXhfnncZjRf+i6Ge7LpGNu2YZ40b6T7ep6rAliD+4hapyEdlxWwBsJUKQnRbk80ozQe1ovExaakCijBCD79AXSMVajJG0fZr0dw/sc+2iHX8OAtHjleUBlWPT8PzJAd5hKBoGE+OmMFbF+t1kcc2aC+aj2itw7XnAlvvYKveky3R3tQ0lyS3rsf1o8OjN4wNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPuWuSfH1DlDpSa6mPiosGGm0fnppxnriHjH8hJ6J2w=;
 b=Heu43OfEU5/IQ8LGazQGg44sb/hqMIJU4SZGADxENak6Z7t1/OFYuu7ehsDCvF7eBm0NdXUj1qbxmc/PTXwsKOxEfeAbKzqpKRED2tb2PSRhFnFhzFAnkLqqckxJx+dFjGADW7hhgyyB0lK8cKYJaAzftBmLgaABlAj1saA/jYhWrp84cduPbOriRJzHmvqpTrfScBX0dXg58HvHH+z8U7jYuwaLlKKQOu/47CFc8ZY5Unc5cMnmjPnLJTKn/I1HMb+BJdliDllC9uMXyMfvT3fU3XU3l1H5kt9ScOitigKYfehX446lC1rlw22BPJh2+gj9x6m+8C0gMysY75q3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPuWuSfH1DlDpSa6mPiosGGm0fnppxnriHjH8hJ6J2w=;
 b=fuHP/PKzTszP7jfYVpVaVLQ5buWLjF+MmyWNXMOmNmVycQhZT7tlB8/QSZ0UMCmJ4FiAQimxvENYAY1+Y+sxvAmbSVo8d99Ss8TK9Ns/ZkCCxQv5pSX4295dpiz8wP22X5bl/uWuJ+yq2+HM+ufZ8x5LGv7P2cxSd5rwiLEjGq6PY3nm7kYoSo7+mQSKezHtLjn2KNkHi9eQFMZ4Op6VCoc7Tcfb+V0I39ckccNdS4qaujZsWW4SoDsvYkcQ23cV907CA/pUsHQY+DSbfLHsv5D9MI8ZlKf9wFOOYw9FJqzx1UH6IUUmUYg1QVTRCpga4JzWy4LjFFu8MUEWPx/6oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 15:09:08 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 15:09:08 +0000
Message-ID: <2c367857-e1a5-4235-94f4-724441e94968@nvidia.com>
Date: Wed, 19 Feb 2025 10:09:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [rcu?] WARNING in srcu_invoke_callbacks (2)
To: paulmck@kernel.org
Cc: syzbot <syzbot+ae5b16688c0c675b1a1f@syzkaller.appspotmail.com>,
 jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, rostedt@goodmis.org,
 syzkaller-bugs@googlegroups.com
References: <67b4c7af.050a0220.14d86d.000a.GAE@google.com>
 <20250219132538.GA468969@joelnvbox>
 <27f4ffbe-2342-484d-9924-716a799b265f@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <27f4ffbe-2342-484d-9924-716a799b265f@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0055.namprd16.prod.outlook.com
 (2603:10b6:208:234::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 7909f743-97a6-49ec-8b99-08dd50f75b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c09XSG5FSkRuMi9oYjFCMW4vY1RXN2M3YmVVZElCYmRDMXhlVDZDYjdvaEVy?=
 =?utf-8?B?aWxDcFBuYWdGb2xlT0hWYitxR3c1MGpqd3lnMXhZLzR0c3FkZWthZ2dIOXB5?=
 =?utf-8?B?QjNCR1hVOHF5U2RiY1FOckNheGtSd05lNFdxZjdwcG1MYUJhejFxbnp2d01i?=
 =?utf-8?B?azJtNXF5Wk1YdHV3MER0b2o5R2xFdEl2bjh1UTZ3UmV6UU43TkR6TlAvYnJH?=
 =?utf-8?B?enNVejMyRCtlZzdVdU5yZVBjblR2b09DMUx0OThaZ0dsMUpsdkcvOVVRUm5u?=
 =?utf-8?B?emx3U3VHNHNFTDllTDN1dXNPYlJXclBZSExSbmVnb3h6WVdiNzZ0SVNtVmFz?=
 =?utf-8?B?VTZDbkZTT0dYWUgrTE5Zbk1scUh3eWQwRDRCOUNBd0dBNFRQSzVVV1U3NTE0?=
 =?utf-8?B?VldzQ2M4SVF6RWNqVWUzV215YU9MQW5JdEtZektwTnQ2Umd0RWtjVWM2bVl1?=
 =?utf-8?B?M1daQnJUQVpCWFgzYklQeW9SVXhJL3k0S3ZESktiWmhuTSttR2Y0MjBVT3hl?=
 =?utf-8?B?ZE1lUGNPRFRTQTFpRXF2bHQ1eDR0WG1nejdtdlVxNGFDaDFSWlREVE5sN3NL?=
 =?utf-8?B?ZzJRY0hIT1NTbWlIVko5Sms4cXc4ais0c2FSWkVDNzIwbFpNVHo3UW94V3NK?=
 =?utf-8?B?MVlaVysyL3ByZlk2ZGY5Yk9OcldOT2ZLQUJLUkgrdFNyUDBXQmZVL0FmYlNu?=
 =?utf-8?B?NnZjL2VLWTdPVHRuTGFDaHJhR3krWStHdEkxbUV6bXZzK3R3QlNVNWVNYjQ1?=
 =?utf-8?B?V0NFVnMyMlU2MS9WeFRQenc3OCt2dEMySktaRHA5UnlpRExqeGtnV0xOdFpR?=
 =?utf-8?B?VGRoRE54MVVkNlBoNWlHUFlYMWZKTGtPVkYvUFNENDEvREFabWZzZHpBdTQ0?=
 =?utf-8?B?VUVuNG9LQUhhTVBCcmNrSVQrQ1UwUWJDYVRUakd5d05GWkhVVlZValhwVHNK?=
 =?utf-8?B?cjBRTVNDMitENTBWNHBhQTJxTHhBZ25FKzVMQ2dhNDVYNnBXeHJPUzEvY0U0?=
 =?utf-8?B?WG45OEdvWXRQQWQxMEZaS2tTajFBaGJuWldtMmhLOVNnL2NsaFBJSFFibTRu?=
 =?utf-8?B?dWdnQmJWczdFd3VJTGRkY2NOOEkyOUdSQUJ1WjhRVGhMU25LTVBST1A4bG9a?=
 =?utf-8?B?V3VDOFRhVlJFc3laSDNDYnNkRU1PT3Q1YVNFdWVCRVBLNDlseW1jUkpLQmd4?=
 =?utf-8?B?YUNvV2Y4ZjBQa3BLZVBUQlhGRjg4WUpPZUFkZm5BVGdVUzlsaUJXenpPcldP?=
 =?utf-8?B?TWtyMXF2bGRkWWxJcFpqQWpFUVVGL21wRDlQZCtGaDJzaklxbFBScGhHcWh5?=
 =?utf-8?B?d2xyMWtsaVVvZmpFOTNLVHo5N0pkdTRrS0JYMVNyRjZhOFh3YW0ycnd1bWUx?=
 =?utf-8?B?Y2JyM3pVUWJEeDNHa29oaEtlRVhpV1NsL2dyVS9QYlRFbDFFMytSZm1JbEhW?=
 =?utf-8?B?ZmdjdDFuUEhoOTE5RjcwZDhweHFwV3EwRWhmYTRoN3RzcE1VMEd4RVA1Qk9S?=
 =?utf-8?B?WDhYQlpGT2tFWUlhM1cwZnpucDNLN0xMdCsva3hhOXJ0c0NoRHdGeERoejRI?=
 =?utf-8?B?UEZzNWc4SlUrVklSQTh4d3Z0U0JHVXBTVkZQM0hZVGRMK01vUEVpS3lEbVRX?=
 =?utf-8?B?YXhSNy8rTld2N1FWWW1sdG5GM2ZPSkpmdEkyR0lpaDNVdXNoSGE1a05mMktM?=
 =?utf-8?B?RHkrSCtNaTJvOHE0cURRQmhWaDMvZlZUT0JOaHJMeVBhQmg4YWpyKzV2ZG9w?=
 =?utf-8?B?ZnhtTFJkdE1DQXNjQU0zdk5xVGlVTGg2VE5oMXluSlN1TG5wS010YXR4MDJ2?=
 =?utf-8?B?QUFmOXVub2dGaW1uTmM2S0VNcTBDTmJ4RHdUV21wS2xZbXBaN20vdlpCSTRI?=
 =?utf-8?Q?QjNnhPytrsYpC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXlwd2gvSnlLZTdVeTZscm1QL21SM3lObkxLRS9Rd3Y5MjZhWkc3L1hXY3Vs?=
 =?utf-8?B?STJSQk96N2gybVVQM1ZXK2MyMHpBK3ltL0EzY1B1VFQ2S1psMU5YOS9HVita?=
 =?utf-8?B?azBZcERzd3pmVjhaUkFFM2kyK2xMeUxLYmVXb3UvaUZtWGtCbjJZWnkyZndH?=
 =?utf-8?B?RGpaYWNvMHMzZStUMlVMZEs3dW96U2krRGp6N1Z3Qk0wRkMzZmppZ3d5U0xU?=
 =?utf-8?B?QlpyTDN5eUpmK0t5b3pBcEpsTHRWbTVxaXlKZ2tWZWFQZlNTYjJQRFZzcjk3?=
 =?utf-8?B?MzhBUit6ckJwVSt4Z0V3LzVhOWJsZlVzN1hKMXJvTzFKbzhnKy9uNWt4cHh3?=
 =?utf-8?B?amZaQi84M3lXRHBNZy9SelNwN1dzRjVyV1E5UHhYWjBkNzZnMlNSdUJZMVlq?=
 =?utf-8?B?NHV4NmYvMm5ZbWw2bDBmZ25BdENXT252eFJDR0w1TFYxMEh5MkN2aitlTG5h?=
 =?utf-8?B?Y0grRTRLLzluM3BOSzl4UmJoNitVN3JlbDEvZnpVdmRqR0doM25qTjExQlIv?=
 =?utf-8?B?RzdBalQ1b0twUS9QSVVRREU3UklTRFZrTExmanIreW0yNnJWWUMrMDJ2NENQ?=
 =?utf-8?B?Qy92UmFsWVc5b1FEMG9wWFZydjhLYlptZzBDN1RiRThjQklLYmNrVnpjNHJp?=
 =?utf-8?B?V0hCNENqbGc1MTgrUmtDb0Mrd3JRa0VlWnVjRlp1WHdWMUlISzZuemZVZ2Yx?=
 =?utf-8?B?dmhHQXBOeS9INk4wWk9haVdqYktRL003ZGRPS2pxQUIzNGptU2liQlJWSFV4?=
 =?utf-8?B?Y1JQdVpkZVd0T0ZCTXEwc2FvQkhxa1RtVVdsSDhkOFEycTNWcWVTWnhFUVU5?=
 =?utf-8?B?MU1kM01oWDZLZFZTek9TQ0FwQzJsMk5oUWJYanVmM1FTajFzMkwvWHVUWldn?=
 =?utf-8?B?M0tnTkRDYXRNVHNaL0p2VFBYdnhpTHBBSldreldPZ3hBemZGQ3MrTG9Hd3ph?=
 =?utf-8?B?eDUrNytwQVFpWGFUUnlSejhyallESGFNK0pTUVF5ZEt0bnNmN3JURWRHNFBQ?=
 =?utf-8?B?MWxaSWZDc2FVd1FXRHY4WUN4YVVyR3NLTG5ibUJmSE41L2R6Rlk0NFpIaGVB?=
 =?utf-8?B?dEdlS0NEbUlPQTZ5L0hZZWg2MTRXUUVXUE1uRDZjOFV4Q2xFT3JENjRqUHIz?=
 =?utf-8?B?REVwdmlzZThtRHRJTXBzUFZkYUZRME42US9lcksveUhzZVA1eEpjclRpOVlq?=
 =?utf-8?B?elQyTUR2cC9aYjh2ZmVUaVpQT21EVUNQaTEzTWJVTUdzRHdTYmhQRkpTS2xs?=
 =?utf-8?B?NGgzUVBCNEdGK0pUTU9uU0d5OVVZbThLK0IrM0JZaDhJV2I3bngydDdzckw3?=
 =?utf-8?B?Y0p5TUd5RlhuTTRyVFMrNXRHSFdYOWJSaGRSYWJzZ1R2bGlJejMwUno0WFRa?=
 =?utf-8?B?WEpQbzFYWmhBTDlFblNqcnNRZytpd2RhV2ZWNm5haHhaQUNuMjFDWXVpM2Qr?=
 =?utf-8?B?aS9FQlp1RkY1aXlDYk1lQUlCV05oSjUwclNMYnpBQ2hVR3UxU2JMVDIzUnM0?=
 =?utf-8?B?M1lSY3FtN2xkWXRibE1yVHV5SGY1MDgrODEvaDkyTHYrc0Y2TFJ4UURENVIv?=
 =?utf-8?B?aHgvVDRJQUhTR1JRR0w2TDNXaDdnaXRUZG9jM2lyWCs0UThxQXoyUkk4bXpl?=
 =?utf-8?B?TzR2cTd2dXhhdmlXNmJuVVlsU1JkZGY2QTVYQk1Db3RGVHVMYjJwdEQ0eUNG?=
 =?utf-8?B?V3ptaDlheWk4dHg3eTBKUDhUUmpib2V0VC9zaTBZOExya2c4THJVa3VPUnlI?=
 =?utf-8?B?M1pxWkh4YS9QVVhTZEpuK1dHM2lmTWYrMm9GUXo4eXFDSW9mU1VuY08xNnZT?=
 =?utf-8?B?aThJTS94akhiN2xIQWk1M1llczRYZUpFa0ZobVJwTGlHMTdaeUJHR1llTG5B?=
 =?utf-8?B?TVk3S3BtdXhqdFFzVytyVDlvVWRicWR1akQ3VzZxWmpHK2FhVThHNlVvU3Uz?=
 =?utf-8?B?ZXZFV0VQYTVFcHJsNDcwZ1h1V3ZHcVRHT2hlL3VDYng2alhLR2F5L3pPMGtr?=
 =?utf-8?B?enNKMWdkaUxKV09tWis2TndjQktMUExNem50aVdBWjVQUjVtTTVaR1hUQjRU?=
 =?utf-8?B?MGU1dUdiLzR6cHJwS05pWjA1d2Q4OFRtb3pvbDZDQjZ2amlxeEF5TDZiSmhG?=
 =?utf-8?Q?SAc0wsupQLcdmGN+AWMbeEgWV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7909f743-97a6-49ec-8b99-08dd50f75b83
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:09:08.0276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUxUPy4e/nDbci9t8WDxqBtb5gEVJLG/G+PwM6hPE3tCimUJCNJU0Au9N9h+SqDXhAhUyKiP7fq2F3WpkscQ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272



On 2/19/2025 8:58 AM, Paul E. McKenney wrote:
> On Wed, Feb 19, 2025 at 08:25:38AM -0500, Joel Fernandes wrote:
>> On Tue, Feb 18, 2025 at 09:47:27AM -0800, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    a64dcfb451e2 Linux 6.14-rc2
>>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12398f18580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c9c47badcd079906
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=ae5b16688c0c675b1a1f
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>> userspace arch: arm64
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/c0a862fcec77/disk-a64dcfb4.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/f03793fc001b/vmlinux-a64dcfb4.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/ae71c33eae14/Image-a64dcfb4.gz.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+ae5b16688c0c675b1a1f@syzkaller.appspotmail.com
>>>
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 6430 at kernel/rcu/srcutree.c:1798 srcu_invoke_callbacks+0x368/0x3d8
>>
>> This is weird, happens to be WARN_ON_ONCE(ready_cbs.len); in
>> srcu_invoke_callbacks().
> 
> Thank you for tracking that down!

Sure!

>> Perhaps, stack corruption or the SRCU cblist's ->seglen got corrupted?
> 
> That has been the usual cause.  And a double call_srcu() is a common
> cause of ->cblist corruption.  We have CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> set up for SRCU as well as for RCU, it appears, so perhaps retry with
> that should this ever become reproducible?
Makes sense, will keep an eye out for it!

thanks,

 - Joel

