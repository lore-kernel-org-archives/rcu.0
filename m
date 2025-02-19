Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B21C8618;
	Wed, 19 Feb 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971796; cv=fail; b=T0n/XrSspumVOBPJWwWh1+ux9t9w+ReDtV4uPldWkJyhL6Hr6JKWbOFXBcgrFSNC8ftQhTYEY4w94GS9RkOOmxUCXNgC1EISvU6TLojoas/0fRk+rx/p9e7W+MVSvbuVsJxTVcRSwqCIXeb3M04olDxNZyJRlfylylFtcrEzio8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971796; c=relaxed/simple;
	bh=ImlpdudygmALp9hfMplbYlLhSKNKUwW3SvSzVuzh4kg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dhkqd75gPooU9qMyS7Lf88frImJsQksWzFsPzZDj6g0xDDjp7qVi+s6DIsbYYQ7vo2MtSJe5CQtME6My2HLkjDFS8NY475HmcAYNfuRlOOO4r7yfPUMidfj5eosYesfTxOm3S3WabndgWV6RkQwqTTtppZVa+Dn9CbNMtKH4+rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MrIRLh2K; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MrIRLh2K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLlPJckmNBgu1V2mpqBtF3jnRGzZW/LDi1ZVQI+XgSvnr4uEjEerXYjPViKpMvWsPOolq92V3tPq+jK2tULl4F/eyYNtuY39+5TAtB8InqZwRSIqU3B6LSKuNwjRbN/0l2RAs9bliLrCOYQy0UbEQcB0pBpY9fBwg5iqizQjLxvsr0lRgpZrJ1qKSAmaZ52sUAsn+L1wlhADvvri6fdkpESJIqSTpaObPxK1LawkND8fmG3C2zkTTPk1qb4cqIaQK5CYhbj9lOW0Sa2E0pMizVp9FLKg1bcYiu3tx0h9eyIlh3qHU3MkzJb6UZmh+zHkkuW2RB2qZAjqPUlwZfQxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/QG+xs72OvTzmVbZZnnO8X4rznKAb++LovyUvGmjww=;
 b=CqdA/2e6tXQfzMlye2VffzFKCyqRUKj2MCk64MhiqOi3LiowIMWm0BD7qVPLfG9h3H0I8WDT90d/nXEE70bmlb+cXfLqibQcMfOB8APRu1cPcBkifpg4vtNBNAK3LTx95Kf9Xxe1xn4MXLzEDV3ADd49aaXGwn3aB+mT/XGwNsedZPDKm1dKlSFvKBfD1p5622GWFArTYX6AduUnp0PQpcNKPY2PgV3yIoLaytkrNwFwbQ9P6MSWFwKptlfZXjwCy7yTP/7t+4GoLuaG0havDRDlTvRBDZUDUdi1m0funsriih0b8aXCtUuKgDfv4n2a//sdApT415A0VbSmR1qZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/QG+xs72OvTzmVbZZnnO8X4rznKAb++LovyUvGmjww=;
 b=MrIRLh2KFqEt4DTN0bgsCCuS27amNsAzJPocGHRBKMJSsfRqoaSbCQvrX3MNDaH+bz5q+FflYbScazS0zM2KyPpVvJ1dnuM7/heVF53NgWgql6C0k3ZtVFDHtz4oCQ7KjjPjSZbjx62lN7KVo72N3M4b//B+ud1gzTmLib5s2Opshd0q/0IR8D5YkIba9h1P295Lwf5xUSFTROBmmDz4o++iAUtCBP67kudlB03Nithqy8OleN4kXSwnhxjvftOb5eKcHGPlpdYZaian2/uMx3+kfl/nVclUYqtVSPejwBCNwy0a8sPI6r0Y9cciaP4U+qCLr5HjXx0Ty6R+udhX4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 13:29:49 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 13:29:49 +0000
Message-ID: <52320693-3247-454f-931f-d9e23592862a@nvidia.com>
Date: Wed, 19 Feb 2025 08:29:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -rcu] srcu: Use rcu_seq_done_exact() for polling API
To: paulmck@kernel.org, Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, rcu@vger.kernel.org
References: <20250219124309.463702-1-joelagnelf@nvidia.com>
 <dde0f073-c3d9-44c9-bd85-cf0e8a0fd628@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <dde0f073-c3d9-44c9-bd85-cf0e8a0fd628@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:408:ac::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: d336f8db-7bde-4c5f-46f7-08dd50e97bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ni9wQ3QrZUtwQkR4Uzh4NUFjaTk1ZCtVOFFuWEJ3QkFuUlN3eDdDbkdQNlpt?=
 =?utf-8?B?Um9oZVJGMGNYa3hFWDI5a25rek1JVEVVcFpjUnFyNzliU0JYQTg2OEdOZGN1?=
 =?utf-8?B?enNwOXJJUkEyd1RjbEFGVjlCQVZ2REpCVkF4S2p0dEdPN0Z0VXFBOExTWmls?=
 =?utf-8?B?VTBIUEM5YWRVS3cwelRqNWdnVUpKSHFUZXJHbllIb3p3N1NhdHYzMWdDVHNm?=
 =?utf-8?B?Z3d5aEozRHh2UkRxeUdRRkpnb0tVSjJhMWVpenBreGxrL3g4NGNjN3krOU5E?=
 =?utf-8?B?czFtMGVrMGlhamRlb20zR1ZkSUkwNyt1MDhmWHVBSUNmclpQTGVEOGtLanlx?=
 =?utf-8?B?Ulgzd016bERqU0xlclpZWW4yVVN2bnpqbXM0aDNybmV3R3VuTUtYekZQeHcx?=
 =?utf-8?B?TDJJcVdPUHFlbWtHZEtHN0xBSm55UlpCelZ2YUM4aTNkcDJINkZxckVkaFJQ?=
 =?utf-8?B?NG0rTUdGL243cUI5RDltN2xUNWZnMEZUOVl0VXJVaWJBVlBSU05xalIvVys5?=
 =?utf-8?B?Wlp3NEZlUkVZMEZnWTBBRXRhS0FUYVpZNnk5KytKNjJ5M3NOOUxkTWk2WGlB?=
 =?utf-8?B?bWNQd1lTaXVFWEVsUlRyMmtrTnF4aHFLd2JmV250aEgrS1V3SUgzZlhNNHpI?=
 =?utf-8?B?Tm9KWFp4SEFFWDZCYWk3U2dMSUJzQy9JWnoxWUdEY2toeWhmMnRDb3owdUdN?=
 =?utf-8?B?Mm1LeFpmS0dDK05ibzY5TmE4QklTdWh4dmRoZ3AxNEd6YWJVczVoRFVZNU55?=
 =?utf-8?B?UXUzWktDREJSUG1XQXdrRCt6TFJybDFId3FMcS8xU3hXVkp6SnFJc2VKcnJO?=
 =?utf-8?B?bVFHVWJTSFlhVkVoQnkzK0FwT0VBeCtNYWdhdEdmU005SFBHNU1CejR1Tkpz?=
 =?utf-8?B?TURwNDNZNjVscTdxNXRLZ0l2dHl5b3YvYzVzVW9sbmhSd1IyMTZ0bWpCR2JX?=
 =?utf-8?B?T1JkZVJDYUF2VjdLMnpsbFd3a2szOFBQUDJGdnprejZCN2hVTjBZY0Q1ajVC?=
 =?utf-8?B?U2JxMERsYnBkOXY5cU1zRFRjWWx2VjVoU2V5NXlqSmdHZVFNcHpiWHQ5RVVp?=
 =?utf-8?B?WmNhOTVQNno0VGh4ZTRyWiswemJmSGtyNU04QjVORGQ1UWE3TGZrM1RiM2lD?=
 =?utf-8?B?MDI3ZkNMVFBaU0FDZzZPL016aEFpT3k3R3dPQm1pbVE2dERERjN2ZER5Zkpk?=
 =?utf-8?B?RTgvdGlCMHF4eE1SZlJUMVJFeWw4WDNodG9ubndDb0ZIZEdsTmxLNndGSXc4?=
 =?utf-8?B?dGh0M3NITTB0MjdtMDhzSURPbW9lNG1EbXJBTGZTTy9uRGkyaUtpRVNhSGRI?=
 =?utf-8?B?MnpKTEJ6OWhBNnpnbk5WdXprNmpoQU5PQkVmdnRKbHpxT1g4NThYWkFYS2FD?=
 =?utf-8?B?ODRNL0c5aXl0RlY3M1dWaDlucUZOa1IxcTQxb3hta2Z1WEx3REVnL2M3T0Zv?=
 =?utf-8?B?ODF0a2paSnlwUTlxclpYSDk3cmN3YXMzYzBuUzZPWFVteWQyM0dhcGhNNzFh?=
 =?utf-8?B?MEh3T2tOeXV4MUxVNnVtVWhJelhSRlVUc1FUdlcycUdVK3RGZzJhMCt2cW9G?=
 =?utf-8?B?M2xyeU5IN0RCaXRpdFZ6WWxkUUFrellYTGRjelVUOC9pK1RpUVFvRERzK2No?=
 =?utf-8?B?c0szL0xFVE9xeVdhT21ra0p5VXFocUlDblJFeEhYRXRaSWcrVG9nbkNROHQ1?=
 =?utf-8?B?b25GMWhwc1A0TEYzUHI3a3pDZWV4Z3Q3MzJPRHh5VnBPaHNQMlB6NVRvUEI1?=
 =?utf-8?B?WE5yUkV5NjBFY00vOWFiMDlrdEp6NU5IWDgyb29yRzVER3RWd2xkclRQaUh1?=
 =?utf-8?B?NzVTTVk1MlBYWENWMDhLTmVpY2pNcnhkNitsRGZ5UThmUFlVamRjL1JhcWpp?=
 =?utf-8?Q?dzSTkWkFb/PcX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUdGTjNlbnBZRnJlVzc1Mkg5WlZ1eVNqdHM3azdlVVBxd1lyTjBWcTAzMzI0?=
 =?utf-8?B?QnhyMW40V0xqSkp3SGxvZFNpTnpUNUpmeEZoWFloeVlGNUFkSEZYMlA2aDNs?=
 =?utf-8?B?QmpaWUV3MG5JQmhyYzRRc3ZYRnl3R1hXQ2pHWlZFRGxtUFBpdmpKZ0Q2Ky9i?=
 =?utf-8?B?N0ZVNW9tQmQwM25sR3U0MnhMcm9PMnowUWpoemZWRXBWUHY2Y2Z3dnd2bm5O?=
 =?utf-8?B?Ukk2Um51eklDVkZqck5TWlhhZ1JsTlRxeE92U2FRVnFUZ3Vpc2pIeTJBdmZO?=
 =?utf-8?B?VEZ4ZDJIS3BPKzdKS0VVRmM4YkpHbjNaYnI0ZG44Q1pLazRITVI1aVJXU0gx?=
 =?utf-8?B?ZzNrcGhWWndiVVRUN3B0VUVmVnAxTlJ0RWo2QmMrMlp5d0lpNXRDdjRRc2xO?=
 =?utf-8?B?cEFpRjM5c3FLMTd1K2twVFUwQUFwSndzSkZCTEUxOGRxbHRzRFZiQU5YUGkw?=
 =?utf-8?B?QTZ0MzZUb3BrOVBzQnNZZ0ZwVHlZaERnYWhKdFZGRTd0ckJqbG9Vc09XV2sw?=
 =?utf-8?B?anpUNmN6OW5kT1pZWXplU29iMEVkbmhmbW1SbkMrc2hQT0xxUVJ6TDcyTVdh?=
 =?utf-8?B?dTZZcVZKRElteWZaTlNNcHRXbjh5a0ZYRW1MRDVBZ0dONDB1NjFrRk1FQXJO?=
 =?utf-8?B?MjN2V3dURkNhcSt1Rm9OcDB5OFllYWFNTmxFanRoanVOM0k2Q0ZueHRJVEIw?=
 =?utf-8?B?VGJxZUczSFZDcG5BUU8zNlBZbGU4ZEY1dnZjNFM2Ykw2VzNzZHFSYko4UDlz?=
 =?utf-8?B?WmhremVzUnNVKzZJbjY3K1lzL1BZT1B3bm9BOVpCSkN2Z09GRDJVdHorSVFt?=
 =?utf-8?B?cnE4ZFNRWE5GQ281VmtRUU9yUnJMQnZzUjdrektiVXozZ3o5dG9RblFBa1Vz?=
 =?utf-8?B?dzE3S1pPUFNKMGJTWXhNSEhieFMrUTlvNGVuUFUraWVGSTRlNllnK2Y2Mzdv?=
 =?utf-8?B?WG12aDNyT3ljNEVtdGxJY29pcllZRks3K002bjc1Mld3UUNyeDZiZS9mSldF?=
 =?utf-8?B?alFQYXo4RW9KZDU3bTl6YWdOdzBaQlB5ZDJQQlNFR3ZhVVdhZWdrN3FRdmNw?=
 =?utf-8?B?RXJGUWMySU44UEUwa0J4YlF3L1hmUi9tVEU4WVJCVVZYWlltaU8zblEvVGYz?=
 =?utf-8?B?djczNkwzUzZWZ1YrR2dUOGJtSmxtNmdES0s2VSsvMWpKM2ZYTEwxZmU3VVpu?=
 =?utf-8?B?eXFPb3lSVzI3VW1mYU4yOTF0V05HQytnOHN3YzdIbzJhdXQ2bzVManc1Vjgz?=
 =?utf-8?B?dHZnd0FxdXk1RWxlRDVkZHZkU2hmakZObkt3Y0dtUVJlTzJLMm9DVWdwYStu?=
 =?utf-8?B?SENWRjhuMWJSelduNVg3Nnh0NDVCd2pESjZEbVB0QVg1SFl1RE5EK0J6cHZ0?=
 =?utf-8?B?YVFMVzMyTG5uTWFQVVd1Yk9YQklvbWRiam5iWFY0a2lPaEtmWjBlMHkraG5S?=
 =?utf-8?B?cWE5U1NjWjJZcVNSZ1VUbVlENTBqclBhdTlQOHpyMUJKZklMMVFRbnhNRHhC?=
 =?utf-8?B?SjFIcGpabHJSRlBPR040ZUpHV25HWC95WWR3K3N3UUNDdjdpRE85V0REYlBU?=
 =?utf-8?B?bHNjOEZkaFNDUzJjbFBtb0pSY1h3bldzUTYyNjVkQm5ubjZJMTRNY0VPdFVq?=
 =?utf-8?B?YVhGSkNSekNTNHFnZEo5ZGVST1ZjcDYxN3Q0R2tMQ3pzZ3hYcTZJSkFmM2Rk?=
 =?utf-8?B?SlF1a0orMUVBRCszcTJVNGxXbFA0MUNCTlhOOUlyR1NlaXpuRVg0eE1yaGt6?=
 =?utf-8?B?OVpyajU2RnJrdFZua0lMU1RCalcyb2xwckFWelpxNUYvbkF6aUZVZTNoZEJv?=
 =?utf-8?B?MmxubFlJMllvQ0NHanN4bW51RmhlOXFUdU9GWHJ6UUNkdFpBNjFVRUlFUFNy?=
 =?utf-8?B?VGR3M1YvNi9SRytCSFlPVFlEUnpkVUp5dDRwTlhyL3F5ZUY4Rjhqbzk1Zjhw?=
 =?utf-8?B?dWluZGlzOWxzZmNNUnkwTW9MRXByUVd3ZEpRbGd0c0Z4V2FKRGlPNjRxTHpz?=
 =?utf-8?B?akJsbUs0V01MZTQ2YVgwWVJ4cW81alg0Y0NFWjc3TzJxQXhISGJGVGJ5K2lB?=
 =?utf-8?B?SWVicVRwbkw4cTVwS1ZZdmJ5Z2hBaUpSTm45eTZZcDRNTkJCOTBESy9oQm9i?=
 =?utf-8?Q?2uaXxCSJYVXnLcdFtVZjJcjou?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d336f8db-7bde-4c5f-46f7-08dd50e97bed
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:29:49.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgAAFRe7/KN0WD7MoqKE1x7b/8M4I8MAeCGRYimwH7BHGB3zKSjkXVulSyBlvo/EnqqbBBGt7yA/SyRfjDuyAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543



On 2/19/2025 8:22 AM, Paul E. McKenney wrote:
> On Wed, Feb 19, 2025 at 07:43:08AM -0500, Joel Fernandes wrote:
>> poll_state_synchronize_srcu() uses rcu_seq_done() unlike
>> poll_state_synchronize_rcu() which uses rcu_seq_done_exact().
>>
>> The  rcu_seq_done_exact() makes more sense for polling API, as with
>> this API, there is a higher chance that there is a significant delay
>> between the get_state..() and poll_state..() calls since a cookie
>> can be stored and reused at a later time. During such a delay, if
>> the gp_seq counter progresses more than ULONG_MAX/2 distance, then
>> poll_state..() may return false for a long time unwantedly.
>>
>> Fix by using the more accurate rcu_seq_done_exact() API which is
>> exactly what straight RCU's polling does.
>>
>> It may make sense, as future work, to add debug code here as well, where
>> we compare a physical timestamp between get_state..() and poll_state()
>> calls and yell if significant time has past but the grace period has
>> still not progressed.
>>
>> Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> But we should also run this by Kent Overstreet, given that bcachefs
> uses this.  Should be OK, given that bcachefs uses this API in the same
> way that it does poll_state_synchronize_rcu(), but still...

Thanks Paul!  Adding Kent Overstreet to the email to raise any objections.

thanks,

 - Joel

> 
> 							Thanx, Paul
> 
>> ---
>> v1->v2: Resend with Neeraj review tag. Rebased on rcu/dev.
>>
>>  kernel/rcu/srcutree.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>> index d2a694944553..591371d62e89 100644
>> --- a/kernel/rcu/srcutree.c
>> +++ b/kernel/rcu/srcutree.c
>> @@ -1589,7 +1589,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
>>  bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
>>  {
>>  	if (cookie != SRCU_GET_STATE_COMPLETED &&
>> -	    !rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, cookie))
>> +	    !rcu_seq_done_exact(&ssp->srcu_sup->srcu_gp_seq, cookie))
>>  		return false;
>>  	// Ensure that the end of the SRCU grace period happens before
>>  	// any subsequent code that the caller might execute.
>> -- 
>> 2.34.1
>>

