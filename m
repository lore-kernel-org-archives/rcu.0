Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022140.outbound.protection.outlook.com [40.107.193.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37022F7ADE;
	Thu, 18 Dec 2025 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079326; cv=fail; b=lKc/KOH0DLTENsRj8kWMvgYNtjWE6U+MDz/CiI3LgCe+QcoLIzPlUWSEhXtvfjPVB7JLsb94mw9ef5Hrc43k+ikS8xsLJL3W6k1BT1gpTVyBfsNWwRykntokOYwHgEXbchkY2vI3WXfZD0AAAyxQphiyGrUbSBH5Hp7kqjGHXNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079326; c=relaxed/simple;
	bh=KmXm0Wwal+LcAM+T/znXhbOF4G1xLk9mcW8ulO18F5E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VjSa+zg1iXI+uQW8oaZsqKJt7xR0+NsqLnDhlhZeoRPTdFY+c2/1m6DcMth3VwlOvm3AdKvBWJ6qpFvQGk8qyipC6A1Yrximf66lCoV+PGMdNs2VyK7mI5KpuUF0MQKXhxEgQO1on4P5vi395cUhYMc3is8ydEmwbXqaXINqdJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dfpaEI2v; arc=fail smtp.client-ip=40.107.193.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dfpaEI2v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQtRj9wK18crn3oW/THmgI/Igtwd5nzxycHONKWrs+hOsgWmXsyKMLWLmBvg/hFpP43WRfcqp/xtKEsjVyjfkEk9bLgKGNwcegLIrPd+n2QunmU1Roobk9gkT1H2SZrcam8w5J1y20Wd1cOKyXdIRbrua1TybjsRuIY8uAz++aCBiP3qMqP4uQgq4q/YngO/I7x9zaNyVPBYlydnZYLstCUl6CDgS+BRXkbRu+fkbRac7qLddrksO0J+B1x4FeNRYp48Y4qyZBBkUgxtQzXCCyQ68H847JZTIm0p064oKQGgw7dti7rrVfs55QnlyEhJqWNeEg9L6E28CedqBdjAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaC4gd4RyCDBbxUbDKGgVdPuKzlnAtBYXMtq/0VOqhs=;
 b=qgTFIm+LkUHrje1lAT4c30CJvA+IYrKcfxRz8oOWL0zBvBPSCwNbH2ID8iDAmIXg5AGBS/kPDdly+kLBOdOr9RxvOasQ6nKSbd75Etm+g5tFSBDCDwoitcrOMVo8/EDflM/uxakaxMEdqRDehFWiwXbgt0NpARdWsiQ19IgY5sdMV1ceZa7kJcQc3s7eU4/iyVY3vesyspIJ2EhIJ0Wan8arMpTkH6eo1JUj3GfAx2idWqkWX/E0P9lVmTnX+I8lo8GIG16cVQ6Lib4MZaIif/s4h8ugySROpKPufYO80cezqJH3Tii0C6mLS11Bg19QPhtZ1KpPDXnfAWKMCIGJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaC4gd4RyCDBbxUbDKGgVdPuKzlnAtBYXMtq/0VOqhs=;
 b=dfpaEI2vD51HUtNwC8osjy8rWP3A2xapQTgTHyTgEFO+AXKADzg0OxtiaOFUZtikWzKbSspLW79+SvBIw0PbbBQKaPfRthIWHWgKgb/MOPnmXOcN9gyKOP3oQUQN1cMR4gDX56tyrNDfz/5AhgFiPr0LwvRVGCxv6VlfQO64tyXOWwdl8qSDD4syWbalyTGx/qLVjngF1NGlFWXueH9L300OtVaCvuKCaW/RCYl46tDC7AKm6QbVJ+NBB0AxfCssMRAPFUH3SQVVk2Ec1jFh/Hl0iU5/wU4m6Gr9cIeTgZV4aTfbe2tfd43BQsX/nPWr5E40NpAFSheDmY2RsSkfNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10605.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 17:35:20 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 17:35:20 +0000
Message-ID: <fcbc99d0-b7c7-45f7-9cf8-f5d3bfad966e@efficios.com>
Date: Thu, 18 Dec 2025 12:35:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/4] hazptr: Implement Hazard Pointers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org,
 linux-mm@kvack.org, lkmm@lists.linux.dev
References: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
 <20251218014531.3793471-4-mathieu.desnoyers@efficios.com>
 <aUO9KRaP0FXpm_l9@tardis-2.local>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <aUO9KRaP0FXpm_l9@tardis-2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0422.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10605:EE_
X-MS-Office365-Filtering-Correlation-Id: a42a5045-56a8-41eb-11ff-08de3e5bd10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVV2TlFPdnlXTWMydkIzU0RWUnVrWGdOdHdFZ1RpZmFZZ09PSlR5MjhPV3pY?=
 =?utf-8?B?b2gxTllZYTN0VDZ0UjZSeDB5a3FEUVhvRHh1cFRCdFRSTXB2RjMwR1BxLzd1?=
 =?utf-8?B?T3NGbmZHOWIrMkt1d0pBZS93MGp1RmlvS2VhbCtmUC9STVpRcjU5S2d4bFFu?=
 =?utf-8?B?VlRTU1ovWFM0aHNJOTM0V3ZHSURhSUd3bkRBWk1FWG5RMjNBUDFKbUdWTHc3?=
 =?utf-8?B?b1FWZDNYeEoydG5FSDVOa3ZiNnVqdkFsdStaVld5bVhVdUppQ2pHdGhUdzJN?=
 =?utf-8?B?cElRNGd4YnVIMnlFRW04QXdSWGlNbDdGRmNZc1Uzd2Q1VUpNSTFadTk0RDZy?=
 =?utf-8?B?WjhBSmt4dnVkNEgyOHZZelVObGJMazNwT0RhT1pRNGU2Q2VpOHFmdlJ2WnZD?=
 =?utf-8?B?LzBESWU1TDFlRm1sNCtEY3NUaDlFemloWmdKc1BEN0QrR3NhU2dmYmpaVW9R?=
 =?utf-8?B?YUhmS0w0MVB2VFhWaWVNNWpqSWRrUnlpU0E2Tlg5RW1FSTljSVd2ZXJFV04x?=
 =?utf-8?B?Qml6T1FjQUpOZE0ySmlsai9IMWhpNVlkTlRVSFpoSXdEU21KY3k5RzRLcG5y?=
 =?utf-8?B?S0pyU21sUXN6Q2pLQVgrN2hiUVNpaXY0bnpQcnFGaUxsUCtFNEs0VHF4TXl2?=
 =?utf-8?B?QVRrYkpFanFSbFc4ODFHbk5JcFo2bmt0K3dQUjBDU0k3NFdNZ2NvSzk0T0FT?=
 =?utf-8?B?am82c1ZHU1lobnZkTFlnblU5V3hUZlBJcXQ1eVFBWjJCUzJQakhLZWlCZHdp?=
 =?utf-8?B?WVZhZUdFTEtGUE02dGJabWNPTjF1TDk2V2d2WlFzdHpJMzA5ZjZhS28wSzJu?=
 =?utf-8?B?V3pKQWVoQTJFdGJCaGM4cjBobVlvaVkwOVpqV0dKdlk1WmhDTkYzWEhCNVJS?=
 =?utf-8?B?QU8rU2ZGSWFVcGhmM2hVSlEyZmRqRndUSjJXZVFCY3VNLy9YUVZVVWZqZ09Q?=
 =?utf-8?B?WVhOekpqMHZxOXlSTVdVWTR4TFN4U2pWUThkN2ZCM1VKT1VFUG9pdmhhc2Zk?=
 =?utf-8?B?ZnkzbXFHOWJZT3NvR1h0TTFsSUltQ2hDTlNNdllUM05MNTlKbThZT2gwazlB?=
 =?utf-8?B?VUkyNlRlR1JrbUs0VHdwZUFNS2t4aS9USS9TZFB1VTFmVDZhVlcvc0JUaVdv?=
 =?utf-8?B?Y1FKOGhLMG9kMkYzM2Vyb0VCL0RZV21zRDNTUG5ISnpFQktFUGErZHNJS1o1?=
 =?utf-8?B?eGI5SkFabWRTbFh6T3gyUjlXdWowdUNwU3JEUmdIRTJaTkR3eGt3Ly8rYnVM?=
 =?utf-8?B?UWRoQkxBWFFrTVRzQXRaUDd4ejRSOGV1d3F6V3RhUTdsWnk5OE1DMGVxRnR1?=
 =?utf-8?B?ZlpQYmh6QlV3Zy9ZelJLNkNQS254VDBEdHlFTjFIYTdTdEwwcWNBTXNlQ21q?=
 =?utf-8?B?b1psRm1yTzJFcUdhM1U0RmVtNzY3YmIzZ29WYUhBVnNvZ3E2eUtrZktRUGtW?=
 =?utf-8?B?TVZEUWY1ZXVoTGFhS2FETFFrRjl1eUFSdDFkZC9ETlVwdjBpc2lXRnVzcWJP?=
 =?utf-8?B?Uit5WlNsTUR5Qm1KTTExK0pIcHFTN25YQUNwZEIxcFJ3Qjh3THVXeVZPbjFw?=
 =?utf-8?B?Q2cvbHczdEpwQjFlZDdEQy9lM3hZM2dZTmUxTitBTnA1NEt0ZG9GMjRyS2Fn?=
 =?utf-8?B?ZkVqcS8rZXhJd05QQWN4NTlEaS8yb3g5L09HcmhrbWpLcjRSV2djeWFhMTMv?=
 =?utf-8?B?RmFnSkRRaFRIKzAyQ3Q5b3NobU9DRi8zd1MzVUhxTE9CTlN4VjdYL0pIYWwx?=
 =?utf-8?B?b2ZFdi91aE5YYU9YSWg5b2RtWWpmUHUvV0FOamZXZzRvOEt1RlJnbitMbW5h?=
 =?utf-8?B?clkydTF1SUxnNGEzanEwUXBGbjArdTk3NlBaYlNpbHB6WmlpYUtkQ2pjSENX?=
 =?utf-8?B?dWhhWmE5VHA2dWVsZW1xaFJsT3JSMnI2bk8xN2JJN1VETFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDBXUE42YXMvSXVmTXdxTjFNQmhCekhZZFhJZlJqb004T2NaZjd0Ukg1UUFB?=
 =?utf-8?B?MkNXVlR3c285WkVYY1Vjem5YdlhlVU8yZ2hIcmZGTjB3ekNEZEkya3ZkRzlp?=
 =?utf-8?B?ZFJ2SkVLdUQ3MXl3V25VM3FCaEFZUHNQQUZESlNoUVU0Y2RtSVhabTZXUkpW?=
 =?utf-8?B?Y3k1VVY2TmI1NEpKUVRudlJqVktUcTgwOGp0UmpZbHlWSWtYNDFtV0NFY08z?=
 =?utf-8?B?YUxGNndKQU1IMnFwUmZrbVFOM1lOaktBS1dkaW13ekd4TnhkOHp0alVnS3JT?=
 =?utf-8?B?clJ3YTZOVUgvN2hUY0pwR0RaZ0d4R3k4bGtPK1JzWmpDZEp0RnVrN1ByNjRq?=
 =?utf-8?B?Z0xKYnJPRUZuSHR1ZTJsSFJyN2k0aEljOXBkdVpOTzJZTFBQZmRaVlJuSFZv?=
 =?utf-8?B?djNRbTZBRHpjbFJzUkVPSjA4WklDaGFaUTdtZXpzalNvZWM1d2g3NG1oVnBJ?=
 =?utf-8?B?TkNJTUo1RE9ZQTE5aHJybEhnQ1NIUFFtNCtPdlhMNDhMSDlvM1JhOGJHc1B6?=
 =?utf-8?B?TWpqWStNQjQ1MUtGNmNTcXJkZVdkb2tURmVnTzBOdUVjcEZZWWhreWY2WTU2?=
 =?utf-8?B?cG5wNEdENDBkYVd5eXlKTVd0OG9qZlFzcVlqV2UzK3BGb1RZb25Sb0RleXZm?=
 =?utf-8?B?a3dnSUErbngrd3pVbmhueFdrdmZPcU51V25RaVUvK3hHUVhSY01XbThMY0Zl?=
 =?utf-8?B?S1p2c1Q2NWY5UW4xbEVhZjN3V2ljcU5WZWthdnBIK1I5VmZ1SUlPSU9MUzFa?=
 =?utf-8?B?YWgzRTE3ZFZtakZobXIrQVlpVXdCTWtOVDQ5dDFlSVZMUkRJZzhiRnN3RzRy?=
 =?utf-8?B?RStBQXdmUyt2My9XdGwwNmhTWlkvVmdQOGZ1TVprWFhTV0dsbC9GMitYTUVi?=
 =?utf-8?B?eFVIWSt1dDNQMmpMTlNud0g1TGo5emxGUnlhM2xReDJaYmFuNW9STGtQeVpn?=
 =?utf-8?B?amhGNjRpTDBGb21IM1VsczdHNjNJQlo0Z1MzZndrRmVrejZtTkVKajY0NVQv?=
 =?utf-8?B?NFk1UStLRUVrTWdSOHRSRmRpS3NONjd0YlpQanFzaW0zWE1FUWhKVXdTK3lw?=
 =?utf-8?B?aXVhMEFST243QldoZTVTMyszTFRPUGlzVmpoSVJWYjlCOEY4WmcwWDFWeEpk?=
 =?utf-8?B?aTZHTzFLa28xc09renMwK09CS3V4bWRhMWJSU2JOd0NQcW9DcmMrVmVEdEhk?=
 =?utf-8?B?RDZ0dkptZ2lXN2xZUmZXcldSUERreS9NVFlZeGxxYkdHWWdoblJoMmhyTzVp?=
 =?utf-8?B?RVJXS3lHZ3N0WVN0RW1ocDVJcUhlbkFYYml4RzdXUm5rR1BXZWYrTzF5bDU5?=
 =?utf-8?B?ZjJLZ0JGVExNU1VVd1huaURKYk1mTmRhOFlIY0xqQTlHSysyUFpJYW1TN0VP?=
 =?utf-8?B?MjkxVmNkWUpvL2VQdU40TXlBNEJtT2krcjJBLzZYaUg0cDAxVjk4OE1icjNP?=
 =?utf-8?B?M05yRXB1SSthc2h3bG5NNHBSZGFBS0cxNmNraUo1eXVtZVpGeEpsRTNOUmoz?=
 =?utf-8?B?dmp1bVdkdi9IU3N6c1RvOE15anhFSkY0VzZvdVNEQ1h6RTd0NEErcUpjbVFE?=
 =?utf-8?B?cy94YmhmaUNBZzFBL1hDQTkyYVNuVkwxY1F5QW5yTFlRV2tHSEdvRkRVSVh1?=
 =?utf-8?B?SExyck5ubXVuOWlES0E2YnFDQ1dEcStBTmgrZUMrNjVobFhDeFdGZGJzYmdW?=
 =?utf-8?B?V3JVU0ttbTRCTElkdnI3SUp4RFNXVlBsNzNmQ1BkKzRUL3BBTVlyZCtDTVJl?=
 =?utf-8?B?cU0yQ01NTDdZOEE4YkRSNVdlc25tY1p6bWI3QkltSUx3OHZ3d0N4d0FVVG1w?=
 =?utf-8?B?YTllMVZvaitaWDlDeHdaVjRybWdzTWlHSWphSGMvSmh1RTN6OXBpMDl1eFVn?=
 =?utf-8?B?YXlSTlZoMkFiVEx5Ti9FUExRaGtpcitjU2c3V3QvMWVUb3NUeC9BanZPY0sr?=
 =?utf-8?B?ejJzQUxwTFFDZzhYZHU1SjZkTHhMNHY4TXkva2MwUjRMQjNsZVVRVkJnRk9z?=
 =?utf-8?B?T3FlQ0FuZ3VER0laSmQ2MWtVU21lUDRqOTBBc2h1TkxGbXRrVGYyeUFSVVoz?=
 =?utf-8?B?TGt4NnZlcUFIczdvZHh2Nlc4SzU1VlZBVnMxK1Ywa2Z5K0I4dlAvQWhoQ1dj?=
 =?utf-8?B?bUltQ3VaQU9YaUZTNitMc0NoWkN4cld3T0NPUUpiS2cyTzNzdzFoT0tnQVBU?=
 =?utf-8?Q?URTVJ2WJfwpb46ugiWs2AFs=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42a5045-56a8-41eb-11ff-08de3e5bd10c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 17:35:20.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAiSJydGAn55zsQCvoZn8HhWtNwtP+hI5iyRjNPPVIyqfI+UmwqON99M1Mm8XXYqmy2hEmfq90xsa9u+TIgwZuMEck16HeLNYE7ORXku42A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10605

On 2025-12-18 03:36, Boqun Feng wrote:
> On Wed, Dec 17, 2025 at 08:45:30PM -0500, Mathieu Desnoyers wrote:
[...]
>> +static inline
>> +void *hazptr_acquire(struct hazptr_ctx *ctx, void * const * addr_p)
>> +{
>> +	struct hazptr_slot *slot = NULL;
>> +	void *addr, *addr2;
>> +
>> +	/*
>> +	 * Load @addr_p to know which address should be protected.
>> +	 */
>> +	addr = READ_ONCE(*addr_p);
>> +	for (;;) {
>> +		if (!addr)
>> +			return NULL;
>> +		guard(preempt)();
>> +		if (likely(!hazptr_slot_is_backup(ctx, slot))) {
>> +			slot = hazptr_get_free_percpu_slot();
> 
> I need to continue share my concerns about this "allocating slot while
> protecting" pattern. Here realistically, we will go over a few of the
> per-CPU hazard pointer slots *every time* instead of directly using a
> pre-allocated hazard pointer slot.

No, that's not the expected fast-path with CONFIG_PREEMPT_HAZPTR=y
(introduced in patch 4/4).

With PREEMPT_HAZPTR, using more than one hazard pointer per CPU will
only happen if there are nested hazard pointer users, which can happen
due to:

- Holding a hazard pointer across function calls, where another hazard
   pointer is used.
- Using hazard pointers from interrupt handlers (note: my current code
   only does preempt disable, not irq disable, this is something I'd need
   to change if we wish to acquire/release hazard pointers from interrupt
   handlers). But even that should be a rare event.

So the fast-path has an initial state where there are no hazard pointers
in use on the CPU, which means hazptr_acquire() finds its empty slot at
index 0.

> Could you utilize this[1] to see a
> comparison of the reader-side performance against RCU/SRCU?

Good point ! Let's see.

On a AMD 2x EPYC 9654 96-Core Processor with 192 cores,
hyperthreading disabled,
CONFIG_PREEMPT=y,
CONFIG_PREEMPT_RCU=y,
CONFIG_PREEMPT_HAZPTR=y.

scale_type                 ns
-----------------------
hazptr-smp-mb             13.1   <- this implementation
hazptr-barrier            11.5   <- replace smp_mb() on acquire with barrier(), requires IPIs on synchronize.
hazptr-smp-mb-hlist       12.7   <- replace per-task hp context and per-cpu overflow lists by hlist.
rcu                       17.0
srcu                      20.0
srcu-fast                  1.5
rcu-tasks                  0.0
rcu-trace                  1.7
refcnt                  1148.0
rwlock                  1190.0
rwsem                   4199.3
lock                   41070.6
lock-irq               46176.3
acqrel                     1.1

So only srcu-fast, rcu-tasks, rcu-trace and a plain acqrel
appear to beat hazptr read-side performance.

[...]

>> +/*
>> + * Perform piecewise iteration on overflow list waiting until "addr" is
>> + * not present. Raw spinlock is released and taken between each list
>> + * item and busy loop iteration. The overflow list generation is checked
>> + * each time the lock is taken to validate that the list has not changed
>> + * before resuming iteration or busy wait. If the generation has
>> + * changed, retry the entire list traversal.
>> + */
>> +static
>> +void hazptr_synchronize_overflow_list(struct overflow_list *overflow_list, void *addr)
>> +{
>> +	struct hazptr_backup_slot *backup_slot;
>> +	uint64_t snapshot_gen;
>> +
>> +	raw_spin_lock(&overflow_list->lock);
>> +retry:
>> +	snapshot_gen = overflow_list->gen;
>> +	list_for_each_entry(backup_slot, &overflow_list->head, node) {
>> +		/* Busy-wait if node is found. */
>> +		while (smp_load_acquire(&backup_slot->slot.addr) == addr) { /* Load B */
>> +			raw_spin_unlock(&overflow_list->lock);
>> +			cpu_relax();
> 
> I think we should prioritize the scan thread solution [2] instead of
> busy waiting hazrd pointer updaters, because when we have multiple
> hazard pointer usages we would want to consolidate the scans from
> updater side.

I agree that batching scans with a worker thread is a logical next step.

> If so, the whole ->gen can be avoided.

How would it allow removing the generation trick without causing long
raw spinlock latencies ?

> 
> However this ->gen idea does seem ot resolve another issue for me, I'm
> trying to make shazptr critical section preemptive by using a per-task
> backup slot (if you recall, this is your idea from the hallway
> discussions we had during LPC 2024),

I honestly did not remember. It's been a whole year! ;-)

> and currently I could not make it
> work because the following sequeue:
> 
> 1. CPU 0 already has one pointer protected.
> 
> 2. CPU 1 begins the updater scan, and it scans the list of preempted
>     hazard pointer readers, no reader.
> 
> 3. CPU 0 does a context switch, it stores the current hazard pointer
>     value to the current task's ->hazard_slot (let's say the task is task
>     A), and add it to the list of preempted hazard pointer readers.
> 
> 4. CPU 0 clears its percpu hazptr_slots for the next task (B).
> 
> 5. CPU 1 continues the updater scan, and it scans the percpu slot of
>     CPU 0, and finds no reader.
> 
> in this situation, updater will miss a reader. But if we add a
> generation snapshotting at step 2 and generation increment at step 3, I
> think it'll work.
> 
> IMO, if we make this work, it's better than the current backup slot
> mechanism IMO, because we only need to acquire the lock if context
> switch happens.

With PREEMPT_HAZPTR we also only need to acquire the per-cpu overflow
list raw spinlock on context switch (preemption or blocking). The only
other case requiring it is hazptr nested usage (more than 8 active
hazptr) on a thread context + nested irqs.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
