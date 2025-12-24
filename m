Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E292E78F4F;
	Wed, 24 Dec 2025 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766537516; cv=fail; b=P86QpgLLtcjZi5n240vVpT0QkcWgZM38W3PGC6YOgWDwlpObhoioWXvYPyZ8CJZEwcCAeJwALL/tiuWPrpuWYWfw3bL0x4unFWpNNTSO0P9eecCLJAy/gUrCAGSfTd9f4vbIcepFTqdEYXETQPQQ+zHqngOBgNH7vt+mk2tuGu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766537516; c=relaxed/simple;
	bh=ub6YKLhSiw/eR4dkBSU9nK3LIMAhdq/RsEPliLp73xU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V47CrEWZnKVru0nxYMENaGk+MbYQYspxRrsEkgLKMfoYlz1wF6xKe5vf1OPC4qH4eZsXpzxWOZoVGRzahQd8/3s4pTH3detjmQym82noDgpmRx3YhbI2rIyuFz+VyrzBqfbVt4KR0bPwPLw2UqjRmAPbByWT8TZulANiTeADamM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=N/SSTFKs; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="N/SSTFKs"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5BNKchbY3066371;
	Tue, 23 Dec 2025 16:50:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=a4jQ1faMwuUyO+kBcIm4fKh4A7y72AV5lSISs00B6cQ=; b=N/SSTFKsGwW4
	9EvvpLauT1mBGO6tQZ0lHjJcEB009f+FKubffBWi1fVUCsEUhrBpLQarAzWHjIeE
	0EMrswFFBOJjfawm3RaAQlNJYJJmw4cSCtOtckgqby+ph3KPdsAZvzRC3SG1iD/D
	TxhNucsSbdl3vRka2W/H1hCQ1nVP4QmLMAMq09JbgLbIKreOyDbzbA8Tpd5WSrWi
	gUPckeaNt145kOKvXO3HP855XdbbmmSA5IWh3iCUtmrAvfKbOUspKsDBcos6zXne
	+cASPGCjb5WEZJMO78hAz4zyarKBNUjVExyXmlqqgPzOt8JW/rDxyUngynk+DSYV
	yEJRuye9Sg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	by m0089730.ppops.net (PPS) with ESMTPS id 4b7trmnq8b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 16:50:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWcxuGwMyJN+bpnKsrEA8exiKQMrNSm6oa5TvBDllxPvrL6dZrXN/1rVF22x14vGk/Qv9Ev1D5OB63xIfY68imvrUqy+CON+hh/3c77+zpmpZ+pou2abZdmMyKCSys6G8+4ParoshWgGmm4hJfOJNbdOush3X4zS5pOB76vhv85e78rhW/0bwBIxmudUkNpAI1rZFr+8m9Y44oaNYJh/vGEz/w53dLpBal2JcBkAunNNgr0nbyxKIowgVDBi8hmCGpfRzsad1wNR9XjgTEHL6WtGKd8iAXQbeiXcqNwwRHr3g3VlNs2Cs57XZEUimFPZyjq7VlU5Yx7VgrgSluwS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4jQ1faMwuUyO+kBcIm4fKh4A7y72AV5lSISs00B6cQ=;
 b=kONc71P5DUdRCgPu7/gCKcVz6Mg3nVroXug/UcUVd/b+UUT/fXVM/IQzSmRO1njcmdKPaTS9DWn9am8CrEeHtNNCroqCjNw5LhJW9/zHY8n0KJ31T0aKETujhdOlZGszISQVSO8Q+Pdcxw9RYs3DDlBWXfvxi3EHR1r4PHowOVA1RVUAAkao1H0WAgrzIttP/g0PQSNsW3jsB5yWb5X71V5gKVsSWfTYpHu5bI01WlHgQobZwk7ezX0qQztMTcVVkMXLP8Zau02iSvDdqIXZVjEA7MMzJubD797TT0w7//VX1gZRg2SM+krvZ21OJD8Yqc+zSls84CEABYnAZ/WZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SA1PR15MB4403.namprd15.prod.outlook.com (2603:10b6:806:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 00:50:35 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 00:50:35 +0000
Message-ID: <9b63decb-d075-441f-be2b-84344fb14786@meta.com>
Date: Tue, 23 Dec 2025 19:50:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcutorture: Fix operator precedence bug in exp_current()
 invocation
To: Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
        rcu@vger.kernel.org
References: <20251223004407.61147-1-joelagnelf@nvidia.com>
 <4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
 <20251223113758.2c6bb15d@gandalf.local.home>
 <f99bbb2e-62bd-47fb-8cee-07716766c087@nvidia.com>
 <52bda0a7-5311-4e62-89c5-287c731548e4@paulmck-laptop>
 <086174f6-8bc9-4417-a878-ef665c0b0f10@nvidia.com>
 <fa889e55-19f6-417b-9a25-676ecfcd39a7@paulmck-laptop>
 <20251223155443.7165adf9@gandalf.local.home>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20251223155443.7165adf9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::14) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SA1PR15MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: 877404b1-f9a6-4228-a951-08de428672c8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzM1Y2tyTDJsV0pKRjMvU1FYeWY4TzZ2azR2a0tMTlozY0Y5QzZIdTVIemZO?=
 =?utf-8?B?TG5YMEpIVzh2K1IzSTdtOHNmVExQQUNnZ2FBamlTSGFSaFdiUFZ5YWhna2hp?=
 =?utf-8?B?V3VSSUF6aXFZN1htQmEyb3hUbFdtai9TNCs2U2VzZFpsK0xKejhmVEo3RU5Z?=
 =?utf-8?B?cVh3a1FXOXp4Z3dBYXNJK0g2MjlMdGdpdFJienkvb29lTVhKV2UybkVURm9i?=
 =?utf-8?B?Wi9sNVd1NENRWUR4Z25rM0dCZXRkSE5pUEM2ZXdITEd5cnBSYldVcVR3NnNy?=
 =?utf-8?B?UjVuQ1lZRG5BVEF1Y2ZWOWZteTcrRUtaUHh5Ylh4MnlSbGFvbUVDWHlHc2FB?=
 =?utf-8?B?NUpsWFRnTERzTkxpaytDNDg4cGhsMXNqRDF0aSsvOE9hMEErWkJNbUFXMUF5?=
 =?utf-8?B?Wi84TjJOS210NjExbmZlczFxaEdGckY3YWcxaWJCRDU4SEg5MWFlNHZXTWZD?=
 =?utf-8?B?cW4rRUZkZ1h5NDMzc2NoTi9CNmI2Q3VpSVVMNnhvalhGcG85cnF6eTZnZFd0?=
 =?utf-8?B?ZDQxSnQrMVBZZmNydE9PNGdoYzdTb1hESkJHWlFPRmlYQXpKbW5RZ05SNkd4?=
 =?utf-8?B?NWwwVkhmZUEwcVBYdVVCaUhhVGc5VlF6SVdkL3J3Z3M4Um9DSlVUemdPSWxi?=
 =?utf-8?B?NnFaK2haa2h1ajc0WUt6cVh4MGx5VEc0MHE2SHR2QkFOeitFWVdtaXc0NVl3?=
 =?utf-8?B?eXpRQitUOHdSd2sxemo0Q1dnbHRMeGxYTStuZFEzTHFWV2lhaVFQdkZIc09I?=
 =?utf-8?B?REwzTXpjWGR4NHprbmI0aEZWREJZQVdWVm1GS3ltWVowK1dpUWZHUUlBeDhY?=
 =?utf-8?B?cHYyZU5zaGVmaHVaZWtqcGZVbzJLRVl6Zytlek5wdVJTNitrWXVpMGd1MVBX?=
 =?utf-8?B?bExDSVY5TTA1WGhvaUdNQWdGbktpNWJLVWlNeWFXZ2Y4dThKUGhpZjQ4ZXNT?=
 =?utf-8?B?a1FNRXlnODhocXo2Z0pDU2VGTlFKVVlvWW1PNWJNY0ZPSWlHTmp2bGJ3U2dx?=
 =?utf-8?B?OEc0aHBuQzgzdEJIaUdiVDJTSE1kSlUweHkzRERJazREMjF0aHQ5M0tUaXZu?=
 =?utf-8?B?bVFJR21GaXVKOVhuSkpkQkxhOXByejVGSGhkZTNlRldsOUcyS2lxQlM3dzNS?=
 =?utf-8?B?SHJMOHdId0ZYVm43ejduUjEzVTI0R1B2VFZTWW5DeHZKT1VacUdmOGdVelFa?=
 =?utf-8?B?b2I1ZHRyVURWaDJ1RURncEU0eHd6WW1Ha0RJNThCZFAwSTVEWEU1SHRBMTZS?=
 =?utf-8?B?dnlxQWxlYWx2amFlUy8vTmdRY1BLdHJtQnBWYWpkMDNQdHZOWnFpRVBxeFFp?=
 =?utf-8?B?NEg3U0ZIZW8vM1ZGUWt5bWlGQi9yZUtJY0IxMUdmeEQ3QTNic0JxQzNGU1g1?=
 =?utf-8?B?c0tNWWFZRitUOFp0SlRxTEg5SUVnQ0JuZGtlRFFuWld5TXpIeTZIeXhvWEM5?=
 =?utf-8?B?TTA5T3ZKZDJNTkMvSjJxM2xXc2F1dUdHMnpPRm1Pa0lsRVQzZE5XWGVGZlJr?=
 =?utf-8?B?K3ozTy9mamVDTWl3UXlhOTRGVnJQNUxxTHFqVkJBQ0pRc3FwTnF2blBoUTE4?=
 =?utf-8?B?L0pQMkN3SjdrbnZBNUl3VlNGOXoxQWhyMEYvUFdPbW5BMnRlSnhGUkJxQnpH?=
 =?utf-8?B?VGYyTEprSU9sZTVreVRmTzhaZm4rcVBMT0E5YjBRQzFhWTRKYXJvWWlja0p0?=
 =?utf-8?B?VU9tMjNUZlBkcXd4eHBFWS9OUy81VndJL1BBcUhWL1VSY3B5MVhGMVdrWGdB?=
 =?utf-8?B?V1lBd0QxMk82SlJkYkI0OGtIcVdOMHcvclNEbWlxb05sMzkxUE41MUNqK0s5?=
 =?utf-8?B?TkRCZmJJYm9EMXh1TCtyOVcxTFpxemxEUlhsVGhBZy9tRVNRZkNmYXFsVEhW?=
 =?utf-8?B?OGJkSktGdVBWYlRTbWNNZ0lSdTBUSDh0aHMvdWlxZHJxYkhqR0IwQ0N6bEU1?=
 =?utf-8?Q?6UtuE5sOQTtnUJwXqD1VqcPC/l5opj71?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmNZTjAvNXRwRkt2YktkVHlXWU9XVmZjdkxlREM4SWJVSmMyT2RjZkFDZ2Nu?=
 =?utf-8?B?WU1MTzJ3RzAwc1BNaGtRY0JEUFhHN0RYZDFHRW1haEJ6TytzRS9HWTV6MldC?=
 =?utf-8?B?dzM5ZHVpa3YvNUJ3WE9sRDdHTmJCbmNvZHJwdGVOUGxZcUFnWGJOdmdrbVBl?=
 =?utf-8?B?NWFPaGZFQk0vcHFJQVl6ZUl2bll6WUF2K056T1VoanYvdm03Ry9xdUNjNmo3?=
 =?utf-8?B?OUJTb2JTRlJKMGlhajh0TGg1Um5RTUdzWHJzK0I5R2dtdFY1SjNDbDNzOHYy?=
 =?utf-8?B?ZFYzcGhCTWVEd0VkVDJvd0N4d3Yzcjd1TnY4Rno4MW9NazRiNm9WZURQMzRT?=
 =?utf-8?B?OEJ5b0U3UGN4a3JNL0F6WmF3VUNoQVhYTzcrNm12MzB5OGJJVytMc3dhUVZE?=
 =?utf-8?B?a3JsU1IyK1grOTY4RXM5Ukk5K0ZQN3Qvc2dsT2VtZlBCMXRhN1piejlRTWRo?=
 =?utf-8?B?QUJSdWg3NFVzTktVckNmQjBqMlpHd1VvcGJ0M1BRaXdaRWwyQVdYb2phZE9j?=
 =?utf-8?B?SFltSHJFMW5CdnhPNVU2YjF0dGk2MXgzR28wNktkM0hFeDZxRm5yYUlqdzhM?=
 =?utf-8?B?SU02dUFVR3ArZjlWUE1mQTFnbTVmVzZhZjk1emE4NHNHRHAvZ01pNW12blpI?=
 =?utf-8?B?dllhM3hxRzdocnAvYVBoZlNrZnArVnJuMXlhMHhOSTdKVUtWZUlpV0hib3Rz?=
 =?utf-8?B?WFY0aENDaGEzSkpUazZZaWtUUFpMTnVRb1AxcU8yU3dXdXYzeFN5aW1NUlh3?=
 =?utf-8?B?Qk9oS2N2L1U1QUFUSUhMaGkxbUtrRFRpU3RMakdTLzU0Y2RPUGpMU0lTNXBQ?=
 =?utf-8?B?eUpxNFNQaWg3Ymo2ZCtDV2hzSWViajliUUJxWlhzUEh2RkhJTW5tek5ZemF3?=
 =?utf-8?B?R04zU3h3ZE0rUXhXM21oYm5ua2hEN0ZIdmZNZi9xcW10SkdTQU5mNGlLVkZs?=
 =?utf-8?B?QXFyZ0pVZWh0NzcyUnNKSXhVTzlZUlp1R3l1RWJ0UXYycWJLQnkxZDhoTU1L?=
 =?utf-8?B?UUxaclMrMzRxQTZSYThsRG5rcWw4U2E4Y2JxVGdoZHY3c1FqQ2treHhpOVdv?=
 =?utf-8?B?WVVWbGhFKytUVlZMaGt6SjlOcmtyN0dmUktsT0wwYXBURjdJVzFqN2sxVmMw?=
 =?utf-8?B?NXpQbzU0MW53RU9lSFBEWjNzeXpVdHFSbFFMUklaTXlRNkNwc3ZaVFI4R0Jm?=
 =?utf-8?B?dExWNGZDa2xzYzN2MXNIbWxJdVVxYTU3QU1INUc1VUFqQnRCN1ZKMG41TlJz?=
 =?utf-8?B?bC8vWmVqbGl3WTdkcmtCcnh1MVJBa3RVNUtndFhrR2dyOFpWUXZZeEt2TUx3?=
 =?utf-8?B?MVFxZlpJdkh3NDNEUnhHWDJqb1hnVTREWmdVRmFuM1RMRktsVjJ3SHV6TklP?=
 =?utf-8?B?YjhheTZILzMxc0NJUU5JVzB5c0FKemJadDhSdWxuU25INVE5YnVaYlNmREMy?=
 =?utf-8?B?QzRwWVNhZTZOVStxN1R0T3o0VXBlVHpQZVZFNThSTWV0VHNvUkhjVHlEZlZp?=
 =?utf-8?B?MmxnZ1hjVzR3OWlzdmhNYWt2TmFhTFZnQVoyL3RpQVU0Zmcxb3hxK3VyakYy?=
 =?utf-8?B?dkRPUUkySE5MRnJpSkdqNisxRFh6V3NiaWd4d0xXcHYzMUlmY0ZRTlB2QmJm?=
 =?utf-8?B?Ukl5MEhVaWZSOGVNWnlLVkExNDNGdFRGazVZcVFMdHB1T2dFRGxsYnB0ZEJB?=
 =?utf-8?B?V2ZnaEZhR1dpRkN3RzdJREt5MnR0akxvOFJsUmJybTFsK1ZXVW5jdVBlclhN?=
 =?utf-8?B?OUQwZTAvRlJBZU1GN3dZL1Fac294alJtU2dodmFPTU5wcTIwdjlYdG1HM040?=
 =?utf-8?B?bDdxSXYvOUphNkY0bVdQYnRrWm9oZzFTOE1iVU1DQ1ZrQ0QxalZWTWpyTUIy?=
 =?utf-8?B?N2t1a2pkRS9xN1FtRm9kYXBHNjc4dUNwc00vanFoYldYdW9HNExBdis2dmFi?=
 =?utf-8?B?ZVJLUUdVNVNybGFsblBBcXlIc0k2QmRKd3BJMlVIb2hCQ3UvUnFIK0k0MUY2?=
 =?utf-8?B?cW5tZG1EOFhrYnFRSUJ0NGdoVURJMzdZVnNWOVZNY1BOb05LcVRpQlRFVDhZ?=
 =?utf-8?B?SkVKOFh3ODBNQXh3V202eG1lUWwzZkk2MmNrY2txZFRKSkl2NzRlYWlTbXJy?=
 =?utf-8?B?czRXcDk3aEJaanRJamdlOEQxUUNRa1BhY0FjR3pFQkpObHNJdkV3cjRJdUR2?=
 =?utf-8?B?YWx5SXJORGExVkVLbUJzSmNSdHFxWFFNdnZLSnlXL1lHTEpCbmF6dm1kelpU?=
 =?utf-8?B?Y1pYRHdIZExKOFJjTlJJNnBGOFQ2UDQ3SzRQa1p3SFBrU040dTVHcWVZdFZJ?=
 =?utf-8?Q?juYzm2kgb8oCOY2/Ei?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877404b1-f9a6-4228-a951-08de428672c8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 00:50:35.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qdjnPQs3wtxmvgiseY4AlQPv922JHZ63cGaTiUkFAi9wxmEmvyoJIdbA/T285v/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4403
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDAwNSBTYWx0ZWRfXycE0bDbz0jZ4
 HyFwXYzK1bUAoWwskckhZOZbl/VlN2hVyAG1cgMDTggkWPk2nXa2m5UUhy2zMsH4BI8pz5RF5jb
 2X/0r7qhujEm4qKon7bybGJPcZ6Sbg5AFHCyZg2evx7l7/Gfo6STWxi4NkE31yUtu3yKAF3QJGS
 ah+b6+k3JnSyvmrgKNngyHgumuQ8HIhZQ9+oUBsJ9fLLkW07cEvPVcgHvVQsp36UveXeDKDmWIA
 BMZUb67vcWD+uMnV7g3FqkbfZulA5Sl+XfPgIsZDn5tUqoLz/XVOOUVPYRNotdiDcjb0/T0MPUk
 S/AF3GBr49MB/Jn5pHbi314D0McryeJ/2ukZ7Mz69mxGL3NUtt/OKv+vuXMkeKd6cfi4AmwwAdR
 VMUIQUso3XAI6rvSwSFuVttkc4RHw1atE+nCZkqdgjLZntpk6LcUzg8pcudN8cF4P+qeQTCYAMU
 USnfJa9+4PA/JGqCzEQ==
X-Proofpoint-GUID: z1Sqg9Un9isrfQgw53oHyiD9vWhgOWK6
X-Authority-Analysis: v=2.4 cv=b9m/I9Gx c=1 sm=1 tr=0 ts=694b38dd cx=c_pps
 a=DSCxmJijwPVh9NBC5YRuGw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=hEgZ3jT0Ahl_fyKg1B0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: z1Sqg9Un9isrfQgw53oHyiD9vWhgOWK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_05,2025-12-22_01,2025-10-01_01

On 12/23/25 3:54 PM, Steven Rostedt wrote:
> On Tue, 23 Dec 2025 09:51:19 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
>> On Tue, Dec 23, 2025 at 12:30:01PM -0500, Joel Fernandes wrote:
>>>
>>>
>>> On 12/23/2025 12:28 PM, Paul E. McKenney wrote:  
>>>> On Tue, Dec 23, 2025 at 12:22:51PM -0500, Joel Fernandes wrote:  
>>>>> On 12/23/2025 11:37 AM, Steven Rostedt wrote:  
>>>>>> On Mon, 22 Dec 2025 17:12:18 -0800
>>>>>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>>>>>  
>>>>>>> Good eyes, thank you!
>>>>>>>
>>>>>>> Unfortunately, Chris Mason beat you to it:  
>>>>>>
>>>>>> Was it Chris or his AI? ;-)  
>>>>>
>>>>> Does it matter? It is like saying, was it "Chris or his text editor". ;-)  
> 
> I think AI is a bit more powerful than a text editor. Unless you think
> Chris is using emacs?

In the interest of full disclosure, this review came from a local
version of my prompts that told AI to review as though it was a kernel
developer who preferred vi over emacs.

-chris

