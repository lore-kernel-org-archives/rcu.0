Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794447174;
	b=bew1OR0meIkFOOoDVJ01o4r4eBWWzsOYxWCpwMBY/vFnHhej+bZmSfrqaxxaZ5mpydDC
	 OeFaH4OU4xNMCWWHPPhxXwmuP8HHDm+yso8qqRatu9JDf0/okRS0eW23KlKfFZvMNCHOu
	 LjtfXORuU5jQgvQsZf51bCVGHfC3HP0w/GXqp/0x43oLDOGrKLeCwVabfxSOoHK62hRqq
	 DDM+knJQZfpW/tTH0bqnW9ryimt5px5MpQMn3L8iEBL5Q8Is+qrMOdot6nd1lq/3ajsE/
	 KrTOzsat25ti17IPEs2vdYPW4UOq2VH3PtHuex0Nho11Jtjqa9Ax11e49AgLFwcsPMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447174;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=kL3qS2X4V0rTwk0XQZV8vV6zPfc+zr3/+ZkOSUt7vNw=;
	b=h7SwdyPAQQryZv9wkCaaf0NPIXP1gJaQCDgkKNS1anTc/J7kbEHPHlG86Fza4IkdDyRp
	 Ddz6+W7a5rkm6Vnfla1oJ/CurJuRTggf5lRvhtbZRaJRBSzXqU7C31BDcGjWpX/qiRcur
	 K6z0YaWisLxzCIhck6XWj4gBeZZ8pPjZsWjFT6PzyXqQjQ72rnnoBB3DmEnqK/Ntfr0Pm
	 18iLGJfX6pPGGhQm4O3a4SuYGeYcUjYoxBqiMnxQvGjgl6E1pe6yltC6RTIpPYDsgIqj7
	 OC3vSG1w2DhF67BSrQRXLvnTKa6EGKh/rAgLsl+5B3lfXFx74ClOEC40Yk1XriOv9Dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="KLRRA/Vy";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.109
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020109.outbound.protection.outlook.com [52.101.191.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4D2606AD69;
	Thu, 12 Nov 2026 01:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B4D2606AD69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=KLRRA/Vy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySGtFzVxYM4viNY/CIGCNV4jPlKPcaSmXc3CrZqJBtZvzxpMVNBmpkgCPyG8StdnQoEVpQIOL/lLXXLcaVMcgp3dY+SYAwKC7HNt2fM2oTdhxGUyVxpZiOm+NVfH6hKc2V6gOTASBdx5O30dx7gcBAJoQL+ktMEvY83S+ehvJPddirpurqStrRrEo0y28Ej8qwcIJkXCvwX+32PdaQsSyr19RRPUnUEs2Yh80AxjkkTt4WZjHh2Xa8ivQhIKHhBCpEM68Uk55POaVdLsPeEtFWaHYci1I4KESCamdMbEKV/L0U58RmxkGxm6GI8zeWPQ31dkV70npApQpvn0zbgrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL3qS2X4V0rTwk0XQZV8vV6zPfc+zr3/+ZkOSUt7vNw=;
 b=xEqA1qn6ac8GuiVhwM9PG5QxQ8RfeyU1mpS8Z3Gr5OyK7JnoxddNn3xOWFozW73ufomalrZv9tGrHfplOs40rlhZMUEDHuQCk5uT6LpUdO1avx21MzO4ZV6jFEHiyk1+/5xf+ssK9xLGDI8DkIAXAMPAOpbQkI7LnVS4gkf6f49krb7D1cvYnOdsyO8wbleo7f3qom+Otc4EYmcmkK0BtmS0dLi+n38GwY1pqO7hU+qL0EiJHX+JzI52gOmTURu7LIDpaz0+qPV7EN4tPet+mFx5ZjSuPwowdfetW3OlQ3nZc6/RCYverAtqqHcqxp1xN34LH2nW73m2gV5Unc8eaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kL3qS2X4V0rTwk0XQZV8vV6zPfc+zr3/+ZkOSUt7vNw=;
 b=KLRRA/VyUBtpI+ACIf7+Re3TNJb6O9KgwF0Ar1gcnpWv5rFmTK5xvAPQhBblxhPh3o9oJOS1FhR+ySop/E7BkQ7tgKQVooXU7Tq3uO4qkgD5QCOWFtQkV/9n7HA9CM4ohKifrzeZKUnHqucjFUQEzUXdsKKT2rT+bfYI5uDeQga5BClZ1y70vOlP9XgHXxe3fQIZuemkXUWfzJ4xptwsRW+6Qjn4XhPCOSFXv1YwYoowCOtceuEjnlOo6dbb3XB8JUknISM6jYW8gKevB7gwYb+SmsEyzM3OT22vkvDLXM7vHl+L+G35KdFO9iTjTsB26HYfdONNsMeBmDkyAG1reg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB8232.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 01:32:50 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 01:32:50 +0000
Message-ID: <fc1bbc25-a410-42bd-b5b9-d734d2444b70@efficios.com>
Date: Wed, 11 Nov 2026 20:32:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] srcu: Add irqsave variants of the atomic SRCU
 readers
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, Kunwu Chan <kunwu.chan@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-5-mathieu.desnoyers@efficios.com>
 <0f5b9d22-353a-4e30-91e1-aeea47461583@paulmck-laptop>
 <31ba97d2-f02e-4c43-a9a6-5ed49263c511@paulmck-laptop>
 <9207ad1c-fe1c-4041-80c2-52723bc58486@efficios.com>
 <9fc742ab-457c-41e2-ba05-0ef0bb15d00b@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <9fc742ab-457c-41e2-ba05-0ef0bb15d00b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::10) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5d88b5-97fe-43ee-a950-08df405cdd0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|10067099003|4143699003|5023799004|56012099006|261026121527099003|261021121427099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LvKh5O41hdB72FjzS5vrZ3gISfjsVpfZZMHOl1bO2hQRCb7mmbQ7Dc4LtTBdEbcRzCPbs782N+FbhMp/p96C/gA01BUy+3QnWMRUq5/DQ+qz1weWkghntwUMh7GjHXKnyx+C78HQohZR/HfzuBo1U1ufcP1yQNgufX9qk2Lin6PS/4W07QNOwScl7AAT7wwDyW8VT9VICIpF+6BebHZTt1K3MOgpIedCadSA/G6nXXJP5G6OtykD3lR+Jke2w/EFZiGpTaATXNNeKyyw76her0YEjzy3n9FKyHTFbML6b6GTT3VfLFVZymovCclDBoiiU8uqzCKaLNxY9+LavtyO9h3SxTv0Hpa21ewzquVyiOvFiDhibqi+u49tfogVPrT4yV0EwiPv4TJ+A/wcIKaXElycBEtYHcN30JblFV6+BvKupk2eumXAV7lTaJo28ZrvM8UWKYr9Ulvj3OdV8lTO8v+dzJdyPnkp4YPaa5mn7is0SBqLtCdtm0e1yiB6R0hImnvO7XLM2AFTmNHtDeYLroG0OlTSdrrSgx5fE5DdEC0mylbcXjU3GewyZ2HalFbompopSsiMuXdN1kUjp8tAlvafoZF4kA07sOvBzTox4I4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(4143699003)(5023799004)(56012099006)(261026121527099003)(261021121427099003)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlZEdmxvVDdLY0dTWU9IL0JEL0hhSEFCWDJ2L0JqeW9OL3NPWTdrdm8wUnow?=
 =?utf-8?B?NThlYjNXY2hEZ0FKbUUvQk5ML1BJaHE5S1E4ZE5JR1FBWlpnVzg4Y1VLeTZq?=
 =?utf-8?B?Z0MwcmxLOEhHUVdNQ2NiQ2haNmxFdFZidFBhNFVtSzNMU2VFT25UQ1NwQnJS?=
 =?utf-8?B?L0lrOWpEY0JtNDI4OU1wUDVhdkh1eGRyemZoUXlDSmRBZDZOcXZzRDMwZFg5?=
 =?utf-8?B?YjVsWU9FYjVHaW4rNWczNDBuWks2WFNxK3Q3dkhTRTJZd2hFelFXbnRHV3R5?=
 =?utf-8?B?MXp5YllBWTdDYWs2UVdNcE1YUEM2QUVZMU4wNkNHMUIvcXZpdmZjbGRXWTJG?=
 =?utf-8?B?QzJJNUkyNlQ4OThyZnNaTjdIY0UrOGpKUVNrS1dOT0h0a3JBdUZUNzhHTVJS?=
 =?utf-8?B?ZFlWZlJFWlZONjE2S0U5bUtWK2d6S3FXWVE2eWxyOXNaWUdjdzhrdFZrdkxS?=
 =?utf-8?B?N3BMSDRJN1BiSXNESEQzY0RzcHFaM0U0K2w4b1JQSWgxbVNQamZwS1ZoUldk?=
 =?utf-8?B?ZzFSSU94ZkkvTjBBTGpoUDVnUGJGMUZQUXUwTDNIWVRqSmROWjVuQXB2dnBO?=
 =?utf-8?B?NXVMUGFIUTZJMWFSVzVoTjhialZ3dlY0QVV2Ni9QTUVWOSs2OEhpMGpNY012?=
 =?utf-8?B?UVFHU2lMQXp0UmM0Tm0yb3dIbDBza0JwVS85YXFWOEI4R0VMMnFSdGx6OG91?=
 =?utf-8?B?WUU1cWorcGFhYVhHd1pnNm4wSTV1dmVpS0NLM2dIMVFCRVNhaGtoR25OdVZP?=
 =?utf-8?B?NGZPWnNDRnEyVHpaeEkxZy9RbXJFdVJaWlNiMkMrbVhZKzdDWlFlTmRoYnE3?=
 =?utf-8?B?d3dUSmFzQ1NRNFg5UnMrZlpGOXF3ZW43SW9IT3VJMlBRcmRDS0FZLzY0L2Fq?=
 =?utf-8?B?YUFvdGZtRkFEZ1BXYjNiOXl1TmxLeHQwRHhXQVlWUklXN0xTczM1VXJYNWZ0?=
 =?utf-8?B?RXFkelBsVUVPYkNlOHZLVXN2VG9JTmJMc21zcGQ0ZjdGMlVSOGNmZUhOTS9N?=
 =?utf-8?B?RVB2eGhSMytUY3hIYndjRTAvVmhyTzFZM2VqY005WUtxL0xuWWZSODRxT0FD?=
 =?utf-8?B?QjBuelhVUmNEUzVqTEtOcFdNMjVMSTVFRVVoMzJUbkZQYkhlRXlYN0NIeVhn?=
 =?utf-8?B?ZFBNVnMxWW1XWWFzaVZoNGlsc3d2S1JpZ281NXIzU1h0cVR4U2xuUk9LV09T?=
 =?utf-8?B?NFdBcElCT2JVVC9kS0pXTjhHa0E4NDJMWDh5NjJqZkRuVzEraUUvS25DZkM4?=
 =?utf-8?B?Mmc5R1R4VTBBbE1ab3dUT1ZqTWw1UWF6dlR2ajFyRnJXc2RZTWJHc3NJTU1a?=
 =?utf-8?B?UGZMc2xBdjBBM3BlNWQ1ajZxRXNTblJ2ZmtHQlZqSGJTa3BpWDJhUEZPVTR1?=
 =?utf-8?B?SGcvRTZqaGpWS1RucG9NS2FlMlpydnVMU3hZVXhOc2Yzb1JzVDJkQWVDaWZi?=
 =?utf-8?B?MndQSGI3MGhpcUpjTm96djV3WlhPMGNkeWdoYkN4ZFBEZ3NkMFBUNjNIdjc3?=
 =?utf-8?B?SUJjMjVwbVdCTWlSVE81d3haNitlSVRmZWlyb1RyeU9FbUVUMGRETXc0SWl6?=
 =?utf-8?B?RjBSWmdkMXZJRXI4Q2ZtRlBaaWYxbmc5aktBQi9QQ0xmK2FNSTJtRGlSSFNq?=
 =?utf-8?B?UzVXNmhmZU94NkZoNkhiZG9JY2p1N0tBdGs2QTNpL1dObDlwVDRCZytub1I5?=
 =?utf-8?B?MHY1OUF6MVZ2QUdtbHA4N3d3RXQ2UTk2TDZvTXBBZHk4NnByRnJTVGM1SGpS?=
 =?utf-8?B?ODYzZzRsb2ZudmU0YnR3dlRlTGdGZDNRMGQwaEpaN3ZmQmI0ZGExb2FFL0Fp?=
 =?utf-8?B?RUpXVmJ0ay9WOGtoci9ERTZRbFB5R0MrdTNFeUpmc3BWM3dyRS92VjVXQmJM?=
 =?utf-8?B?MlI1aDg1Mmd0UkM1bitXUzZ2RVVNZ3NwKzBaajB3MENJTUM2czJIdkFSTzlx?=
 =?utf-8?B?TWxSa0JzVWYvMFFmOVQwSjVETjdpTmRkMGFIaWU1bU10QjE5b0U3aDd4Wm9B?=
 =?utf-8?B?NGUva21YUytYZEQvdnF5NU5NdWdwTnFub09IeTNOVHFCTUJCVXFXaklEREJ1?=
 =?utf-8?B?UStTVzhoNGYxU2dHcUFiSmJYUkw4K0E4citac0VFUG5SY0Ewd29kM2JnZGVZ?=
 =?utf-8?B?SDB3YWRPQUtFdW1jMFFlV2ZLVGRpNlAvMGtscTA3N011b2RjNy9NVFU5Szd3?=
 =?utf-8?B?R3drQjg4cm5OZHVOcTltc0ZaUk9Bd3RaenI1VVlvNW96WmphWUFXdHN1QXU4?=
 =?utf-8?B?YnFDVno2ck8ydEFVbzlXRkxaR1gxTWwyakhWVG8zdTlaNTNKV1ZnTyticy85?=
 =?utf-8?B?Zk9ieWMxUHZxempiU1hES1pDSmNXYzZpckdUUDRvemJtUTBQNHYvVm9QZktJ?=
 =?utf-8?Q?F/E3+pIU+qeV+a1AZhffhlWm2XI0Bo5ueuiVGgrAEv1pX?=
X-MS-Exchange-AntiSpam-MessageData-1: hWDDh/4VOmW58f+t5gMGz6Wv/OICtdLeLRA=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5d88b5-97fe-43ee-a950-08df405cdd0d
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 01:32:50.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjcmZNXTHiVlxPEWkYluX9cSCBZMfEOMEVX6+JcnDbFfNwhtCjt/HcSxActKmHOiZ+HQwDJtPrYDlnOKNWfQWkOSAhPgGULV0wVu7qmg8Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8232

On 2026-11-11 19:07, Paul E. McKenney wrote:
[...]
> Although that doesn't help on my laptop, it does work on my x86 test
> system.

Is the laptop a hybrid CPU, with P-cores and E-cores?  KVM gives its
guests no PMU on those.  kvm_init_pmu_capability() in arch/x86/kvm/pmu.c
clears enable_pmu under X86_FEATURE_HYBRID_CPU.

> Perhaps something like the following would be helpful in keeping this
> well-tested?

Yes, that would help.  Three comments on the patch:

[...]
> +             qemu_args='--qemu-args "-cpu host,pmu=on"'
[...]
> +             --configs "SRCU-P" ${qemu_args} --trust-make

1) The quotes inside the variable stay literal.  The expansion is split
    on spaces, so kvm.sh gets three words:

        --qemu-args
        "-cpu
        host,pmu=on"

    A kvm.sh --dryrun with these arguments stops with:

        --qemu-args (qemu arguments) ""-cpu" must match "^-"

    Keeping only the value in the variable works:

        qemu_arg="-cpu host,pmu=on"
        [...]
        --configs "SRCU-P" ${qemu_arg:+--qemu-args "$qemu_arg"} --trust-make

    It expands to two words when set, and to nothing when empty.  I
    checked it with kvm.sh --dryrun only.

2) nmi_readers and nmi_calls both default to true.  So the two boot
    arguments change nothing.  They are fine if you want them explicit.

3) The "atomic-srcu" run just above also runs readers in NMI, by
    default.  It still starts without a PMU, so it keeps printing the
    "went untested" lines.  It could take the same qemu argument.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
