Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022123.outbound.protection.outlook.com [40.107.193.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB021B9D2
	for <rcu@vger.kernel.org>; Sun, 14 Dec 2025 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765719808; cv=fail; b=XLTFyePhJJW/TeCMNkHRt8xf7lbuxlcyBXu8QxxhjO9WtsWENB+XVmdh1H0NXoSN0G+s3/ZpIVAHXdSQSWxvR3Auxp+mht+CAgMqTwGTQlgr3kPlVJx4W6S7Rq2pNhSaVm/Sl9B9KM70cMMtrSTkSzqUecluOranYYzHw7Br478=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765719808; c=relaxed/simple;
	bh=miejsNN4dd34BHPco6Wm322oP/BLgpF+op8NBONcgk8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZWxOTO8TOjxuXE3Bsw0Smk0Lepr+foXGoBZKJZQ8afFFL27jORQkh+k0O99Ef+7RWkZRMoKR6Y3SwLoQ2NbfNsl3wNdFvcvLRNLmq3+UBytebx5txFjXnGoqFbZUOMy1zcImDkCke83xKNuDdFDBPbbmiiI6zU//QD6AeC2G/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kJ+vfF1f; arc=fail smtp.client-ip=40.107.193.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kJ+vfF1f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niRnOlJlxOouGvoMlRunmYIenqKB8BLwW9ixYbeVkUkxqns4v3SJAlsXxcseUkLHdZrhBdvZsSajns3C4cv8gf+nUQiQwTWllTERN+PMBTWe2h3V5263ssXZ8an2SlnqtUbASEmbyLaw2lnFD0G/hb0PwlT5XIlK2yctjCMpphmmM8EuyC/gKGNxVc+jbAvFh3eIri2FqsL8GA2n1pCX8r7WIGi69Mi5zVcs5/ONlQPyta3fPK3lEBi9c11/RwUfxVt0472R3BS7bmZYbA4+xViPgydN2A0LW2nX+zib1ROPgYC/W8nVknnPztOPdD8EuOQLAr9WppE+KcrsXfDWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVGKAanwXSEzAlZrReSYTYASc5fvJvs3oa0SahCGCPY=;
 b=kiDNjXVUkRqi5T/b0Ph0Ic17YrPHLOhYP+CilD1NGxZd+TnxT+NDDMGuzYWoS7Pp4cIgwztMmQ8QILif08p1QmaodzKjEngcrrnSPVJs9p/S0mKAlCktyzEygYTWleDuRjs4RSK3ToznLLxnPUz+2sAc2CK3SOtC93+dLJd2pYKR0jQhX50S0seB6x03VJLd9E6Gn1OznQAi5P4znsuUlwg5yXGmpyALOpELbYvLNswCQlVbEFkkPlbRN65CxnicDPOWnFkOX9nRZ/cxEw/fatcx4iyRookYNkAS1R0uHlCxOMYFbaXBxDOTXx5qhoOC+o+iG89kXSEOpyKrOtsHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVGKAanwXSEzAlZrReSYTYASc5fvJvs3oa0SahCGCPY=;
 b=kJ+vfF1fCJsxKyU8/gNEbzS+A59ultZ8FdIX7oQ41stW1Vz3+Ac4r6ZjYxoXoQJJw3QAE5e61wHqHtCUXqrUS7RXOPDjAA9Odlf+vXj0laeS5tQFTwsJPuh4+KujxDpAjw9OnB3sG8YfDsfZ5tKTENV0W9xWyje6kYTSW41/OiVzWXulDKPDQnlnaOwdlzWBapDC3JYuF8nAyszJeG1qIW0SuvUDxKVD8hlIHbj6jPfLUXhNabKfkLf+tIHXgVnYfbf8XXuPM6PMyMb3sXzb7EIXWxKHf1A4Fo9Fa6TwN9steE3V4RT9htaTtE9U/V5XoWG6kXDfwqB79mGOb/PQjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB5892.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sun, 14 Dec
 2025 13:43:21 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9412.011; Sun, 14 Dec 2025
 13:43:20 +0000
Message-ID: <1ee9bfee-d754-48db-b72d-763193cb92ca@efficios.com>
Date: Sun, 14 Dec 2025 08:43:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Handling large numbers of hazard pointers
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "paulmck@kernel.org" <paulmck@kernel.org>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
References: <77ffb53f-91fb-4bd4-96d4-e16b0e6ff0f1@paulmck-laptop>
 <091915fa-d6a9-4aba-99c6-d93d9b65e0de@efficios.com>
 <961B6DB0-3071-41D0-9AB6-70B76C547F19@nvidia.com>
 <207B1F17-D789-48DC-88E3-352ECF0DAF11@nvidia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <207B1F17-D789-48DC-88E3-352ECF0DAF11@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c01c23-22d6-4149-5643-08de3b16bea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmVPNXhmWktmUUwxVHRlN1pRWlQ4UldjaDdRNS9XVW1vNGh5VUpNTFRhRkVW?=
 =?utf-8?B?OGcrK1MzRVlLRTBpNEdZTkRiQUREK2laampaZGNoSllvVTNVVVViZEVxQzRJ?=
 =?utf-8?B?SGRVY1NPcFBQTmxIMHdlZmhsdDg3WlU5R3VrN0FpNDgySkZKNDgxVzhKVjBl?=
 =?utf-8?B?ZjR1RmFzVnFBUmdGdFUyNlV0R3IydG5IRHpTMDM1ZXdDVDhPZy9RSjArdWFT?=
 =?utf-8?B?N3pNZ1pDYTAyRFFHSERHalZVT1FjSUEwQ0RjZmVyQnlybGVKRWsza2I3Qmpn?=
 =?utf-8?B?Sm5OYnlocFpXeklwSGhGcGZEcS9NblBKL1NoRGJNbWVSWlJLSjF5T0JpTXgy?=
 =?utf-8?B?SndyYTVsMmZ5NGczR0xpV0Qwd21VbHhwS3ZRTzhBck82UG9pcnRuTkU4UW52?=
 =?utf-8?B?OXNMelV1dlY2ZzZEeTZkb290NWRSNCtvNnlrSFdqSTNJcTYwTWhvQjZGSzlu?=
 =?utf-8?B?bEI1SWRtVVJMdHZqTzhKclVtRkhWbGJEWkJUUGxXeTlPYVRBV2xzbk9EMDlq?=
 =?utf-8?B?b1lxTFkvS3dadXJsYlFkd2owUDFMZmtYTWhCTWw2NXp4TWhmWTFYbVBkZVZM?=
 =?utf-8?B?RndkRGtrdkI4QXIxYTVWVXV3TFdaOStSNitBckRkOW1wUWpDVTZvbEU5bnQw?=
 =?utf-8?B?K05MN2k2YW1QelR3M0t5YTJ5YUNIZjFZcTdLNCtkZ0dBUTRwN1l2MmE3MTZH?=
 =?utf-8?B?WStGTlg5Nm1wZVppSlZyLzZaT0RKOEpNb09mNTRjYXhzT2RKREcrVXVCNWpT?=
 =?utf-8?B?aXBCQTVuNk5PeHhjUDRRWTJzcml2MUtzbnZIcmRNRG1icU1QZ29FQUNsZ1I2?=
 =?utf-8?B?WExsUytXa0I2eWFWTHJ0ZUY5akJWVTVEY0xjcGIyZU44YmlJZytjWG5pMnIr?=
 =?utf-8?B?WDVrOWZ4VFBLRmtnMkRmYTkybXlCakNWZ25KMFM5Wkp4cUkyYXZDZStZWmN2?=
 =?utf-8?B?eDE2MmM1bGpYKzk0aExpMUljcVlvV1F1RXBRRkU4a1dWdWdBTGNrMEhFbmRY?=
 =?utf-8?B?Y1lGY0x0b0t4d0x4TSs1eG5WSFhJVDIzUU1ITTlPSnE5ZmkwMnZndnlUK1NQ?=
 =?utf-8?B?QmVqZUtNb0daR3dHMXlBaWM4QVo2ZFVVRVJQeUMxZE01MDM1TENsckdRdmZZ?=
 =?utf-8?B?ckFVTFhZV1J3Z0NERFVFcitzVWp0ZGU3b2swTnpSYWhFeFAxTjZDdnhXWE1Z?=
 =?utf-8?B?K29BTi81Wkx4L0JwRTg5TEpEVng3RVR2R1pyQ2R1RTN4M0ZlNTkxUTdrcHds?=
 =?utf-8?B?bVZxY0Q3ZzlBWUdoOEgxUFBRMFNENkFnNm84MEpRM1RVR2ZMTHB0ZzFlVS9m?=
 =?utf-8?B?dkV6TXd2WDRzbytyeWJ5dWV0dSt3bGxyR0NHTEpIenptM2trUFlzZ3hVQzlp?=
 =?utf-8?B?UCtDME5JMmxMRDFsTStUUG11dFZ6NEpRbnA0L3dSUmtTY0lnWFl1UmVRSGRx?=
 =?utf-8?B?QUtSN1RiNHZtZXFKTlVxL01hWEN5N3JjSDJGeGNxRFlxTTZraGlqOGFveHVx?=
 =?utf-8?B?TnZobzZUblNQMjVBeVZFcFdJYk4zdXFpL2U2ckppNXZobFVZZ1pGbWhqZXJn?=
 =?utf-8?B?VGxzTEJQT2E2U0lhUWFkbkNVTGJXb1NjQWlEUCs2M1hxc2UvQkUxMjhYemd6?=
 =?utf-8?B?ZkwrakdqdUtIN0M1SGt2b3lXQ00rU280dUtUWW9iSDFLd1ozZ1lnUS94OGUw?=
 =?utf-8?B?SHlGelpreWdra1MybnNWMlQyaEpzL3FXWGhwU3VORVVud2lSdjN3TGg3SDdm?=
 =?utf-8?B?SU1ESXdrUGwzZDF3djROcjIrZzFQVjBMMWoyT0FrTUtoRkpxWU00bmE3d1Zh?=
 =?utf-8?B?SkVxTjRRVkZML1hLSHJCOFFWc1paVlQ2V0E1NDgzbnAwWm9YYVRMbmZrN0sv?=
 =?utf-8?Q?Oyay8SuX1q3i+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEtoUUdVczBDQ0JRZVE2TDR4Zm5ubHFKb2xkNFVETzVRR3F3MEVNY1lxbU9V?=
 =?utf-8?B?emJLVDZPQXVNOTE4a0NyM3BxK3cwSERMWjJCa3k5aVVzNHl4MnNnRG12NHln?=
 =?utf-8?B?Q0k0TmxxNlJOUlZ1a0pYWmxHWjQ2M1NNOEMvNWs2S0NIK3FsYVZCT1dNbnRP?=
 =?utf-8?B?d1hyNER4QnJ1S0FPSS90djBWc1dQb1NQL2pydkVBNXhteUQyUzNPYzZmSFZ3?=
 =?utf-8?B?cVlwTHlVbU51S0Zpa2FqdFNOa3h0enh5eTE4UXhZaUpMUEJiV1FjZi91K0pB?=
 =?utf-8?B?N0ttenNHMUV3a3NOY3JKR0t5ZzJHTGUrYXlRdEVzV24xNW9ORHFGd0RWMWNl?=
 =?utf-8?B?bGlTd2hJRC93VDFZRjhTa1JTeXhHSnZ5U0prcnN3bEhwN2hPZzd1OWRxU3B5?=
 =?utf-8?B?TzBubW9sOWJjR1hYY0p5T21aREVNMkxkRDZtcFBQSzEvM0dKOFBBZE1VQjVR?=
 =?utf-8?B?R0t3NTRzcVowY3NUUGF0Vy9EVWJxb3BWeVRtQkNsRjNaQXdsUTNsNzlYY3BH?=
 =?utf-8?B?RXRaQUpmZnlBWGRTUzlSYWlaKzhsQjZGc1ZQSnA0R3ZzVlkvYjFhRk50Z2Iv?=
 =?utf-8?B?Q3FtYjBjQ1FOcGN5UnJSZUlmYmVXL21JMm5NUHA4Y2pQSTlaNHFzVUpSS0pN?=
 =?utf-8?B?UC9jUnVhbC8wcDZqMFFSQWczQkF5MmV6N3VLdGlKUzNoOURXcnlZb1NYVUsx?=
 =?utf-8?B?VC9nMlNvNW95SUlVK0hsZ3JuL2pHb3VGNHVPaXdUZVB5VS9oNHpSVHZtMWh4?=
 =?utf-8?B?b0o5cUhGejRIQjlaV291QnNLbEFyaW9Sc20zaEJZaHVON1owUEN5d1N4MGc2?=
 =?utf-8?B?R3pMZ2dpVGJ3TGJJMEp4b01SVGVnY1Y5WDFzYzdEbkRnZUxLOEFtWTNheDkx?=
 =?utf-8?B?Z05WQlhPdWtIT0tGWWN4UzZxaUtBa1ZBUlNiQTVjaDdpTzRHTFlIWU5oR0Jl?=
 =?utf-8?B?dFlBczcvanZFbGg3aGRTNmVJL0VFUk5rZHFSYlN0N0E3a1Z4MlIrK0NRcTFE?=
 =?utf-8?B?T2VNTlRueXMvVjI0WFdMck4xZVlKZEw4UmV5T0puMjV1ek1BclJzb2VQWkgr?=
 =?utf-8?B?VWlTbDM5N3BwQ0xxWWNOdVFRQnFIQXB1anhodjZkUVZJWDZCVmkzQTh5ME5r?=
 =?utf-8?B?ZzAzUUk1SUY1bEJONHgyblA3TC8wekE2dEdMQjJCMzZwZC9LdDZUNmxTUXg4?=
 =?utf-8?B?YTVmaXcxZEVTdHFpa0RlQlJGQmlVa2cvNXE2ckp2bW5iTEJvT2NlMWFkOWdo?=
 =?utf-8?B?ZVcxTHBhcmtuTjEvcnRKMmdrVnd0dUJiYXVtNkRkRWt2U1RWdG1jcElzODIx?=
 =?utf-8?B?bVBiK05nTGU1TXVEQjNjd1p1cTZkdlNSUGg0bkxYampiYm1GMHJNTkFaNkRl?=
 =?utf-8?B?UnlkMFBtWTY2NlNDOU9tSVRQWVZxYVVSQWE1cC9qUGo4Vm9qUkhDSmFGaTdZ?=
 =?utf-8?B?RW5BdUk3aks1ZjJHZW4xR0JQc1cyN1lBMlQwUkdDTWpOdG1SakdsUGd6c2pn?=
 =?utf-8?B?S2l0QnBNOGRpWnpBQjd3UWM1YlQ0Vk9PbGpEdG9BSkQzdmY0dTJiTUY4S0RL?=
 =?utf-8?B?NUlyNVZaWWhabXhxc2VxZEVCYkxNOTJhYWEwb1NUdnpIMWZGRExlTXVLZFB2?=
 =?utf-8?B?anVMeU1QWFUrUmcrRThkYmUxcExCQmVoOWlqYnlKWFFNY3h6WThqcEpMRUdW?=
 =?utf-8?B?RWVWZWRXZkp4dTg5Si9YRndwT1RjNkZEV0RUN254dnhvSDY4WW5GL0JWUFRp?=
 =?utf-8?B?ZXBNVHlMNVNhd1dCY1NEbmZWY2lNa2V4aURIRm9ZUlNuYWhXOTNQbEhnYmNn?=
 =?utf-8?B?MlNRenpnYnVtWWszazYzeFdjci9lNUhYOGRXUmY1MEh2ckhsV3RMSXpLc1hz?=
 =?utf-8?B?NHpEblJZbEN5WERYUlpDaHZSRi82UVU2MkVJRm56dlJadUoyME9TRlRrdXJa?=
 =?utf-8?B?RkFkZXVvb3J0M2NDY3JxOWdYN0hBc25yYVpTZEJSem5QZGxJM2VxYnl2RWt1?=
 =?utf-8?B?cnIzRm0wU2ZWbHRPK1hmRjBSMEQvdlBxZHp5blNtdHBKREdONFRGQ3lEYWhG?=
 =?utf-8?B?cGltV3RIbzhJQWVNa1FXYlNJeE9UcGZuOXM1ZWpqNHNUNFZ4aDdDSVd5VnhG?=
 =?utf-8?B?ZjFrS0RXOWFuTnBaWXV0UjRlNy9ld05PL25tbFhmRjRiTWhZbkh0SUt1Q3ly?=
 =?utf-8?Q?BRq8QuSe9E5ayp1M2kSVkB4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c01c23-22d6-4149-5643-08de3b16bea7
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2025 13:43:20.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqENO4Z1LnsAOEX6fpUhnEWbNRhO8QW2MpvJhZ3iCe01XD0Wgk6/dW3rpHp4tusNBRzQbMNue6aBIdl3tubiQ9hAeqRaAwIElH6j8UHXNzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5892

On 2025-12-14 02:14, Joel Fernandes wrote:
> 
[...]
>> We have had similar issues with kfree_rcu() and running out of preallocated memory there meant we just triggered a slow path (synchronize) but for hazard ptr I am not sure what such a slow path would be since, since this problem appears to be on the reader side.
>>
>> Perhaps we can also pre allocate overflow nodes in the api itself, and tap into that in case of overflow? The user need not provide their own storage then for overflow purposes, I think. And perhaps this pre allocated pool of overflow nodes can also be common to all hazptr users. Ideally it would be good to not all the api user deal with overflow at all and it transparently works behind the scenes.

With the preallocation approach, how can we guarantee that we
preallocate enough, and if we cannot provide that guarantee,
how should readers behave when they reach that limit ?

>>
>> I think we need not worry too much about cases of preallocated overflow nodes itself running out because that is no different than reserved memory needed in atomic context which need a minimum off anyway right? And we have a bounded number of CPU and bounded number of context, so the number of *active* nodes required at any given time should also be bounded?

So the "simple" implementation presented by Boqun at LPC2025 was limited
to preemption disabled context, but in general there is really no need
to require hazptr users to disable preemption for the entire duration of
their hazptr protected critical section. This means that tasks holding a
hazptr can be preempted or blocked, which increases significantly the
number of concurrently active hazptr we need to preallocate.

So I'd rather remove the preempt disable constraint across the entire
hazptr crtitical section if it's not too much trouble. And it appears
that backup slots preallocation is the only fundamental reason that
would motivate this constraint so far.

>... 
> By the way I wanted to emphasize my PoV, that requiring storage provided by the user seems to negate one of the big benefits of hazard pointers I think. Unless there is a solid use case for it, we should probably not require the user to provide separate storage IMHO (or make allocation internal to the api as I mentioned).
I think the solution I have in mind takes care of the negative aspects
of preallocation requirement. Here is how it would be used (see
[1] for the current prototype). The "backup slot" is within the
struct hazptr_ctx, so from a user perspective, it's under the hood.

The user just has to provide a context variable on its stack.

(untested example below)

void *ptr;

void fct(void)
{
	struct hazptr_ctx ctx;
	void *addr;

	addr = hazptr_load_try_protect(&ctx, &ptr);
	if (!addr)
		return;
	[critical section]
	hazptr_release(&ctx, addr);
}

Thanks,

Mathieu

[1] https://github.com/compudj/linux-dev/commit/5e33fc13f950929e630a60ef44249e7b0978e80f


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
