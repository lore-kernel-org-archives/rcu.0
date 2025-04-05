Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D531917D0;
	Sat,  5 Apr 2025 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743852232; cv=fail; b=eomdVR/+I8peWic3LGMuknK2rNxIU6f1R2WOL8gYKcA0/jnh9/KDHKcYzZdywT8q5S6p8XGMhB4Rxabja2Qxm3G8aAR7BtyRJG7qlzLPqk3FSxRUASkdTLhJdNxHa57uBY2h0DCmjCrki9VqDxdj+HiNhCRELNmMs8B04DdoXK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743852232; c=relaxed/simple;
	bh=q5TS6KLxTgGJJU+XEudTdxRtuVYuem2ltahi9iJf+zE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IuQS6AP+0+463onP8CNar2/ShB2tnf/830jOSCUfdYJqAJX/gsBjXXUTW5vyCUEIllJ7dluXn1YaxFjAPNmsK8navHhskwob3HrriwtuwTI4Df0gTPn+bOy8Iq90Pl5Y5nrWewj1RDqYopDUzXPQUobsgmiUXuBcRSO4fH6JP+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LFANCwfz; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LFANCwfz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBYjxpP6Ud1bmmArPwwo24MYYrn+rnz4JG5wJY7culKcGuSfa/2FHLRaBdb6FMHYID0s+DG2ulU2JkegayZRhDevXnPHr4YLw4bQtRCDUK9JebJRNWRjQe/6hdT8Y5ydfvcPL2pdQWxTSN8PA9duldAkBHCA+4dZ78jhm0DF7s5UW44/6NMoKEhz/ahdEbBYxHzyXJ1ZEdVPXBshD4uXXaHEgZvbLv2ryF8DcuouTwey8JdSQAcKR8SyKgX/JGUXUVcU9xIHK4oLukA5smoXpPz+trIvvhELtPegk/tTGlc94xK8RzLPKV2U8eHrsZq4e+4Agfi2SUkexh+wdcUybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovbxvqM2q2663mQjEA5RHMv4NZbn959+YboJoBYRKXo=;
 b=wEhhfwU+Jx7G/+yuWyFGMWi3nCMwMygxW0I+ZCj306Je/n5WOYSH9vjeYw52dmegzP3I2zQy/iZdrEu7+HdTIcqrzLaj5gAphw0tdcthgSWDocG/dqAuN4sJ5Ne5nSjYi9JOlRlGUTIJr0DKiwUSDK4OhDR+36uV4cjnLiwyz4sn61ZslT78uf4Gw5kCqCJqXbW7qDBpZ2keoA8jgldwIDSVZKHloFJ4GNEOwkPVlyJl9tMd7Jqsp/lSBhGgsG6LtPGhmrrrRv1TkrOzdKsiOM2EakuLJ5gHvkMPAElKZPlacC0RIO/tePsuggincX4azLdP/4jkixYYP0XaCWuYxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovbxvqM2q2663mQjEA5RHMv4NZbn959+YboJoBYRKXo=;
 b=LFANCwfz7vQAiM8GGKeyKpvrdNqnILzKlRLboq9/Xn0dVlNn1Fi7mNWtlkdrxD0Vq1o/G79snjdRqpgFJ4spi02fOwJWUpSol0IAeM/Z8AErwJrH0np3kb5eX9Cq1ZVo7MXfcFSk4TTTU+0tvoElRhJ5KIWYFHtapJP7klQyYEYjBKS44j9qItuWgvwFU8B1FMM1jICLMcjTdKdu8LmO+IF5dgBZY8eKmyhTDaxmRMxIbap1yKcFU8TfdNPn9F7j9v9Aq6DVZ+Z/ScK5QO9CZqAapOIZPAvNY9Kl0yyI68lfCHchIzA3+5x6312xUzWx+RUVJEkKqGEt2HKsmT9Apw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Sat, 5 Apr
 2025 11:23:47 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8583.045; Sat, 5 Apr 2025
 11:23:47 +0000
Message-ID: <0c721fa7-f458-42ae-b206-9168539b6356@nvidia.com>
Date: Sat, 5 Apr 2025 07:23:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [1/3] rcu: Replace magic number with meaningful constant in
 rcu_seq_done_exact() - Patchwork
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>
References: <8c8932fd34334718e94f979f9bab2fb7.joelagnelf@nvidia.com>
 <Z-1IJ34Xb6RzucCQ@localhost.localdomain>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z-1IJ34Xb6RzucCQ@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f96600-ac7a-4cb3-a1be-08dd743454ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXdyVEVYd1dJVElWOEhPaXlTbytqa1J1dGhwQ3JvZG92cE8zTEJ4ZmZpNGEr?=
 =?utf-8?B?TFNMNUIrLzZFd3NqRnh0MFZCRlVjUXFicFYxeTV5QlFJWmZCWThXaWJXWWhy?=
 =?utf-8?B?cUpYZ2tVZGNtcjlOcHBDZU00dFR6U3R6ZmJVZ3d3SHJLS0lzMHV4Y1h3a1Y3?=
 =?utf-8?B?d2dwcWplMzhiSWFKL0p2K2pKTGVhT3plTU5mMnhwQlltTVNCVmVZZ0Q2cS96?=
 =?utf-8?B?U1dqRWh1RDkwTUVqMXpIWGx4MmcwbjJZenBzcUlVSGgrMWdQaWZhUmZFUXBl?=
 =?utf-8?B?emVMMlRsR1NKSlBsZFcwM1NCTU1vNzFTYVl4Y1JSbW9BbXdNbGluUWVody9t?=
 =?utf-8?B?Ym8wZFdDOGdmNGZTanNJWDB5aGtQcUgxc1dsbHFDREs0SFdNRG9DdDBKMEpt?=
 =?utf-8?B?ajVHMDFQQ3BkczMrU0lSd0pLMVhVa2I5SWxYaGNJeUJBelVyOGRCZk95Z2hW?=
 =?utf-8?B?NW05amFXc05pbkgvYzBMTzFOdmdld2Ura0ZRWG1JbU9YK3lKWjhiMDdlM0Rk?=
 =?utf-8?B?WnVlSnFPaWlGcGpuQ3pMRFgvNWlsVUdqVFQ5SkhoMVBRNk02eWFVTXh3bkFO?=
 =?utf-8?B?SjdMVlQ2THVBSlg4c2lEOUozWnBPTFlJcjdwUjVMT24wR2FOQ1JUKzlsRVRa?=
 =?utf-8?B?RHZvMmtLV1NOR2RabHkxRkhCUVQ3TnNaZm92RHI5eWlGRzhGVkVISjQ3M2t0?=
 =?utf-8?B?YnM3SFE5aU9YclQvNFUyZGVYbWJrc1pkVHFVVHNaU2tzazBUcTRmQi95L0Jq?=
 =?utf-8?B?ZlNablB5V0Qyc3hpb1lJcS9XVDNkL1BMUWd4OHR5am1aVkM0SjlxaEphRkkz?=
 =?utf-8?B?OVNxL2c0aDd0aldxek5sbjcveDV6MlozNmpGZSt6TGk1by9HM1FEUlp5cWp1?=
 =?utf-8?B?bExYRGF0aTdYb3psb3F1WmROY2UzQnpOMkRNdmMwTkRtY1hWMGJmZXA4VXdT?=
 =?utf-8?B?MFBLd21jclhSNkxxa3ZpaEZoTmZUZDNGNDdNbVVKMFRSWHM5SXhJbTJMRllv?=
 =?utf-8?B?b09tRWtqcTVpMkIxSW5aU2hvUmtVQ1NPdGtEQTc1R1lJWHhjMW5CQVkvVWVQ?=
 =?utf-8?B?dzZDdERZc3BLN0J3OWZLSWU3cjB1NFJ2SC9oUSt4UXVEQ25PeVRDYXphNHZE?=
 =?utf-8?B?RE1sVUt5MkpUZUtJT0FoUGJPTzRHcWtVV2o4S0w2NjcxZFlVYnZ0eGZLeW1z?=
 =?utf-8?B?MUFYcXluZEwzNVZLRlFRSGZFeTQ5TmYvNVYzdmx3WGhNY3hqdk96VTJUMHM4?=
 =?utf-8?B?ZTlERit3bnNOOHQ2bEZjR2F5a2Fhd0JKVWs4Z2V4dHdDNHcyVUxQbGdnZXE1?=
 =?utf-8?B?bkxEdFkvV1oxZy91N2ViR1B2bHR1RVN0cC9veXFaR0xSMHhUYzBpc004U3dG?=
 =?utf-8?B?OUp2M2xmcE5Fa3p1MUJXSlFoYlBheU91UGR3MlI1OE5QRzNyM0tSVGRlL1Yr?=
 =?utf-8?B?MzBOMzZnZWdJNzNsekZRNlpJSmpqUFJFTlE2RU1rUWVYVkRMMHJMek1JejBQ?=
 =?utf-8?B?b2dGVUdidHpHanlmWFdlUlFwQ3BGczNKUzJqRzY5OHh1aXQ3QkVVZU5ZWjNp?=
 =?utf-8?B?bStKM2llMW5ZV1dUZ3Z6M2cwc1ZYZFF2aTIxUk5zNEwxMk5SQ3llbkFGVmU3?=
 =?utf-8?B?MEVhZFAvaGRBaExZNkxmUS9IdmY0dkNPdnpXWTAyaTFLbHhrNzVQYU5nRDJF?=
 =?utf-8?B?eUd1Nk1jaGxnWDRGWVB3TjBTRzBBTFcvZC9kYi9wbU1wZzhZWU56cDNZd0kr?=
 =?utf-8?B?V3VKelFQVktRVHJzMTRqa1MyZHlYdE5DL1lrRU53MlJZSmU0T1h3QWRNQ3k5?=
 =?utf-8?B?azdJRHkzUGNmY0dFTzdBNWhSNHBLOTZhbjljUWkxbENwZm1XV3hTNEJOQVly?=
 =?utf-8?Q?sJ2O1MKEe4lso?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDd2UFBTd3N6RUdwSnJTdnpaTkN1L3lBV3pXd3ZQbTFxU1RRYVVhUXNpcDNI?=
 =?utf-8?B?SUM2N3dMN1NHYkxXd3dqQzhHbStRdWE4K3VFNUw4c1NiSHl0em9mVlpNaFdX?=
 =?utf-8?B?d3pXVXZLTTRxTzJRVFNMKzN2emZFaFRrKzhLNHJsdnJsSHhzdEVYRzVYYmgw?=
 =?utf-8?B?b2x0YTVYbGFaMjUxQS9Sa1crVEduV09tR1VXQVJzWS9CL01pWWtZZEF3VnFC?=
 =?utf-8?B?dEtYZHg1elIvUHM5WGt4K29kRm55VGhQQVpBdWxsaDNIRWVyTW9HaldTaDBm?=
 =?utf-8?B?ZXRHbDBaSHdJL0QzQ2c3MlhvYTFrZi95dFZqTCtOS3A1WnJ3cWs3NEtSQnRQ?=
 =?utf-8?B?QnRxTUtpc3U2YStvbnl4RVdldndNU2psbHQxUjJlbHBmaCtQSFIwVytxSGxT?=
 =?utf-8?B?aWFKRDNzelN3RXl6UDZsdElhdkFKK04zOENxdzhhV3lUQUFab3lRRHZZNkpz?=
 =?utf-8?B?SEpETGVORURxMTRqRlMrTHNFNHhBOWgzMXNDN29vSGdzTW9pZmZ0dytya0c1?=
 =?utf-8?B?blRtK25XTHZZQ2pSVHRueE13TVA0VWZaaHFqOG9adVBwRWRhNkFqbEtYV3NY?=
 =?utf-8?B?L01JTHM4QkMwcCt5TDFLR0pMK1ZkUERRbG93cHJhLzlCc0pkbEo4a3pQOGg5?=
 =?utf-8?B?RmNBbzUxamRCM3BEVnpGbEJPMEErR0hoQ0ZJME5UbzBEOGhkYWJXOXRIVThx?=
 =?utf-8?B?dy81YXRkbXI4Q2doL2tIMStTWkh0Tmo1blNlMk1pQSsveGlpdjdQZ01JRVpx?=
 =?utf-8?B?WUNoU2ZHeVg4R1ZnejIvUWNnaW9sUSs2MkczNmZOOVdtWkVVUWMyUWpqa2RM?=
 =?utf-8?B?cXQzV091NzNMZkZrT3BNZXBhWjNac1hRZnVjZWtDK2NQWkx0bUtWc0dxMFlB?=
 =?utf-8?B?aG1lTU1FU2xPTWMrbkRhamphUnVDZG9sWnl2TmJaNEI1NVFid1RwdGxaOWxx?=
 =?utf-8?B?Qk5Qbjk3YVBNNjVpTElPalBRSGRISE5OMDh0dHRPZlU2Mk9WWkI5azVkYld2?=
 =?utf-8?B?RUdBUTB0bG5Qa2VHNmFYbzZmTTM1emNkM0xsK3Rsb2FkQUdia2Nud1BFTHND?=
 =?utf-8?B?dmxobVJpdkpwOXdSUXo5NDd3OGlUbmJJQW51OHg4Vk10emJEQUtxeFpYV0JU?=
 =?utf-8?B?Y0RQeXIxSGRPQjRFeXRTTVF0cjk4bk1DUGErbmRHb3NldVJCWkJ3bEFuVVNT?=
 =?utf-8?B?SVY1K1JnQjZDRjlTd1pjblF1U21vNGxwcVdleTNncUdyNEY1MjZEVVoyVExF?=
 =?utf-8?B?R0czUWNocTNTWFRud2JBTHNjTHNMLzduaTNPQ2srNUVrZnJjVksxYUV1MEVD?=
 =?utf-8?B?ZHBnQVBRUThwOCtDME5VbnBzdkI2UThVTWZBRTRJblZHck9EREJvbHliTkg2?=
 =?utf-8?B?NEhjNXZoWFpaUGtiejFRYnR0ZDhxbEJoRmFhQVNQOWdlUVRXTFJOb1h5dlJq?=
 =?utf-8?B?Ty9xWngrN09GVFJQRzNkcWxubW5BVHgvcGxnT3l3NzBBdzM5bWxkRmsrdmlj?=
 =?utf-8?B?TU93Y0cyVGQzZ2FlSzhnMS9DTmFyOVJodVEySnhTS3dKL1h4MWs3MzZnM3dr?=
 =?utf-8?B?dWlrNzNrRWFkVXNVaDN3VFFNODkzRXdFRXdmSFBqL3JvY0I4enM2d05GbmZP?=
 =?utf-8?B?d1laYy9nZ3Zja1kyUFhFRHVmMXRrNVZVRW9MZURMRmpSUVRMVDNEbUZvQXJK?=
 =?utf-8?B?UEZ3VlpoV1ZnZkxUOE9lOVROWnBWa0JYaVRBV1RsNnMyUDM4MVhCcXp6UVQ0?=
 =?utf-8?B?VVdrUG1YbWFyRklVRktIRTFSTzIyazkwZVNiV3dhd1BIL2s3Zld6djBBRmE1?=
 =?utf-8?B?d3BKeWF2bzZVOEZwTXY3V2RsL2loNGdVb25Mcld2ZlBwTk9lQTl3dVM4S0VU?=
 =?utf-8?B?SExKM2RqSytlWUhiL0hCdVc1NDIxdU91Rk1zNzl3WTA3b2dCaGc0dHQ0MUx0?=
 =?utf-8?B?N1ZITXhMNTZSN2pnd2FEUzR1RSt1Qk0xWGtyaWQ5L2xDcXk0VCtubnNxd0g2?=
 =?utf-8?B?SzhTbk1YVU1pOGlDMWgyTmF5LzFnU2tKTEFhN3RnUnJXaXI1U0M1N2k5TzdE?=
 =?utf-8?B?TXNpeTU5b2hjSDZXSlZpYlVNVXBwcW5WamJ1RVl5cFowRHp4cUVMN0RYUlVG?=
 =?utf-8?Q?mgsONUSHyw9tUNOov9E/bRjs5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f96600-ac7a-4cb3-a1be-08dd743454ec
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2025 11:23:46.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gyt8nfP6olQNyV3ZmAsM7T/koaZZibm1Nl8mUvgY7IGjt0vYsqhzBrrLOU5htlhCwuH77iv0Sy9pFHjItI2lwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039

Hi Frederic,

On 4/2/2025 10:22 AM, Frederic Weisbecker wrote:

>> On Tue, 1 Apr 2025 16:27:36 GMT, Frederic Weisbecker wrote:
>>> Le Mon, Mar 31, 2025 at 02:29:52PM -0700, Paul E. McKenney a écrit :
>>>> The disagreement is a feature, at least up to a point.  That feature
>>>> allows CPUs to go idle for long periods without RCU having to bother
>>>> them or to mess with their per-CPU data (give or take ->gpwrap).  It also
>>>> allows per-rcu_node-leaf locking, which is important on large systems.
>>>>
>>>> Trying to make precisely globally agreed-on beginnings and ends of
>>>> RCU grace periods will not end well from performance, scalability,
>>>> or real-time-response viewpoints.  ;-)
>>>
>>> The distributed disagreement is definetly a feature. The duplicate root
>>> is more debatable.
>>>
>>>> But simplifications that don't hurt performance, scalability, and
>>>> real-time-response are of course welcome.
>>>
>>> I'm not even sure my proposal is a simplification. Perhaps it is. Another
>>> hope is that it could avoid future accidents.
>>>
>>
>> Aside from the performance concerns:
>>
>> Sorry if this is silly but could you provide a small hint as to how
>> unifying the global counter with the node affects QS reporting or hotplug?
>> It was not immediately obvious to me. Thanks for the help.
> 
> First of all rcu_seq_start() must be before the hotplug scan, otherwise
> you run into this:
> 
> rcu_state.gp_seq = 4
> 
> 
> CPU0/ rcu_gp_kthread()                                CPU 1                                                 CPU 2
> -------------                                      ----------                                            -----------
> //rcu_gp_init()
> rcu_for_each_leaf_node(rnp) {
>     raw_spin_lock_rcu_node(rnp);
>     rnp->qsmaskinit = rnp->qsmaskinitnext
>     raw_spin_unlock_rcu_node(rnp);
> }
>                                                    rcutree_report_cpu_starting()
>                                                        raw_spin_lock_rcu_node(rnp);
>                                                        rnp->qsmaskinitnext |= rdp->grpmask
>                                                        raw_spin_unlock_rcu_node(rnp);
>                                                    
>                                                    rcu_read_lock()
>                                                    r0 = *X
>                                                                                                          r1 = *X
>                                                                                                          X = NULL
>                                                                                                          cookie = get_state_sychronize_rcu()
>                                                                                                          //cookie = 8
> rcu_seq_start(&rcu_state.gp_seq)
> //rcu_state.gp_seq == 5
> 
> rcu_for_each_node_breadth_first(rnp)  {
>     raw_spin_lock_rcu_node(rnp);
>     // Ignore CPU 1
>     rnp->qsmask = rnp->qsmaskinit;
>     raw_spin_unlock_rcu_node(rnp);
> }
> [...]
> 
> //rcu_gp_cleanup()
> rcu_seq_end(&rcu_state.gp_seq)
> // rcu_state.gp_seq == 8
>                                                                                                          poll_state_sychronize_rcu(cookie)
>                                                                                                          kfree(r1)
>                                                    r2 = *r0 // CRASH
> 
>                                                    
>                                                                                   

Makes sense! It will be too short GP if we did seq_start but missed the incoming
CPU which happened to start a reader before we did the seq_start.

> So the same applies if we convert rcu_state to use the root node.
> But if we do rcu_seq_start() on the root node, then an update side
> can call note_gp_changes() because of the state change (only if the
> root node is also the unique leaf). But this then happens before
> the loop that initializes all the ->qsmask
> 
> It's not a correctness problem because it won't make the rdp to
> report a QS too early, since rnp->qsmask isn't intialized anyway,
> but note_gp_changes() would needlessly lock the rnp lock to record
> the state change in rdp->gp_seq.
> 
> This is why we need an intermediate state called RCU_SEQ_STARTED
> during which note_gp_changes() can safely ignore the state change.

Ah ok, so it is not a correctness problem.. that's what I was wondering. It is
more of a performance optimization it sounds like.

> 
> Then once the root's qsmask is initialized, the state can switch
> to RCU_SEQ_WAIT_QS, after which calling note_gp_changes() becomes
> useful.

I agree, it is helpful to track the initialization through states and check for
that in code paths.

> Hope that helped.

It does, thanks!

 - Joel

