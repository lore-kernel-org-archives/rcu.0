Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC217E0;
	Sat, 22 Mar 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742653249; cv=fail; b=DXRxXss3nh6VPb+pxatrQgHhDZFqj4fVyAkfCu4lLp7qCI1T15k50Q7jRZE1ZZ4dvMYMKg/nnIBUe/a3vYAXGag+aA/o60RGdE6V+w+5ym5bHCrTxr4l6+ID0wph3eiAjoUW0IQTyuR+BpxAkHTSWyzptHGowpJSD4H9Vun9Lqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742653249; c=relaxed/simple;
	bh=ve/7wKUtKMXABVvzx5sjw6gDCYTcnNuXPCfXSqujJi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DKPeHo3kP/p7HxEGQwurvmlXE9jpNKNCTChFbUM57qcf6xAASZHU+Fyhdae9uVf1v38PoTjk4Yi8gPIrfWbJHqaDR3XQZEegv/Wwc8ZaoVyDIs/CGZ1gbriJRDFMR3rGg20HGpt3tN9Fry00A/d3UC+ChgzVRFLcSvLgfkU0aPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b2AzD98Z; arc=fail smtp.client-ip=40.107.212.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b2AzD98Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqH/l+2JMpk87xNzucWagg2YIEFVps++ppiXjBA0kCrkkWZhcL7gC9QA7Ha4zb6cNu7RyE2iiSzrs3gSATDtj6c0VOVfrdsuuMsNSowxleRE0p8RbquX1j0f13Bqp+HoIHC9xQRp7wAhMijb2bdf4GpQLdkkKoctd/DVVFvf8YAw/fCudxYvDNtxko1bgNSWzg6J87SyEWpU8MkyXwFtuFceNCYS97bYD2LGBcS9CuFoQmeDZqavgS5HHV8+8zj59+E9TXRw19j52Ti+u6TzM3QRn8txgD6MeMxYEIbjcDI9ge1g5bzUxOD1SzdwNS8+bDjB2KLgVMpbgu8pVdBWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+YpL8K9ZHuNOrRoQVooDUrI9AcDZMtE+oDVmxjqF/4=;
 b=BcaSzPaiR72qAKHgCKO6AJMIGj3+FW0PvDcOygCRCNKxUy4Pe1FTM47zjPLmgQDgPdb068akJ6ufbA3e0pIv3V8SvedE5iBbjTH9P9G2qKKZgg//F7UjxOX/cZJF3ELaK+VEUBJM8ws/i4590S0w5whEbOswMKeKhqc0b0NCyC+XcMwkJzOAWQUZI1gY3Ig+sgrKdDa+AGYquF8aEXmKvgzoyHUTPV2PQ1VWT0gdLiB6UvsKHYPDe0Wq+V/UoVYuAfcs9Ocqf13wu/1awhCBRABQfPSmzh0ritcLt8oqbMnj/FVlmWvVUUNQCZMpveXIXRWOZqQ60AzBQI5aNAnDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+YpL8K9ZHuNOrRoQVooDUrI9AcDZMtE+oDVmxjqF/4=;
 b=b2AzD98ZAUnojmR8RayZqXjH6Mp8dTxidHIMUXw+MdKYp0FOI0bmWW1Zh7VOxQs9V8ljrcPWw2f/QdsTh7J0Q/U1a7KjQS8YouyiO5dt5BaUDlUuuWVFQIqgm3Cm91hKXUz83zbHrXMHWjDAe+MSjeTZFwpjiumEtzoGaNqoBoBdTYc0p96U2H5/V7vZFvFe1zW5iXaZpGtEWObeCSwP0OP9j0EO7SeYqtAdwLr246em2OOaBoZL6xvaf1RTpOfqwmOiuMVibKBF4E8Gb8/0aPCvaGZPZd3uyS4Xoi061HVvQLF/0KqE2aFl1aoZMnhfioxSaFQjm9Ifiv5Gkg+blA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Sat, 22 Mar
 2025 14:20:44 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 14:20:43 +0000
Message-ID: <a2b9d79f-5406-422c-aa79-f0fd1862d4ab@nvidia.com>
Date: Sat, 22 Mar 2025 15:20:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rcu: Comment on the extraneous delta test on
 rcu_seq_done_exact()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
References: <20250318135619.4300-1-frederic@kernel.org>
 <20250318135619.4300-2-frederic@kernel.org>
 <322b052d-0f1f-45a3-bfef-226b15f3a8fd@paulmck-laptop>
 <20250319193831.GA3791727@joelnvbox>
 <Z9wjBT3RQDUrFdbE@p200300d06f3e9880e1f174d4afcc9316.dip0.t-ipconnect.de>
 <3c7f1032-f2ba-4fc6-91c0-a07fce1b9c3c@nvidia.com>
 <Z96P_K0kt-FumSjz@pavilion.home>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z96P_K0kt-FumSjz@pavilion.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ffd5a7-4e3c-4127-5426-08dd694cbb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1ppbWUzRVhEdk5ZU1hJT0JMUmhCK21xREpiM2JLWWp1TEQreEZJZGZtaTJU?=
 =?utf-8?B?azA1dkQ5aG0zWXcyNXFYbGhXWlJsRzEySDV6b05RbkRNNTFrSFJEOTBoY1Iw?=
 =?utf-8?B?amtHUzZPeStHcSsxMkRubkhYek9TOFYrbjJZRVZ4b3F2SHRsMS9mUzNHWENM?=
 =?utf-8?B?K0tpZWdlSS9uczVjRDhrSG1oN3Q3VEJOUDlPVDhDcVRvVnBhWTZ6VFowaW40?=
 =?utf-8?B?QkhQcjZWMmNJclNZRWJEem9NcU5RQllFNytpVk0xbVpyTHc2d0lxMzR0T3Fk?=
 =?utf-8?B?Q3cwVjFPSUdMdys2QU1HODNqUTk1cFM3TjVFbXkwcVVabEljMG5vRlIvWUVU?=
 =?utf-8?B?b0F3UDErZDc1K0NqeVBLQlJZVElvVTBCWkJJSXJkUnY2THdIOHh4cjFFRzJp?=
 =?utf-8?B?M1EwN1daMkc0ZUpNbUhtZmN6dXIzSkY0bnlUME1vYzBsbjBTbVVqaC9uWEpk?=
 =?utf-8?B?M0FrTytoeFVjZjdnQVlDNXFjN0FZQlNzeXdoSUZGc3RjdVA4YTUwakd3TkJ0?=
 =?utf-8?B?SWEvOEZsdWhLN2ZhdFlsNnBWcnNIRUh5ZG51MXEvR0E5UmlCUXpSTXlVcUZY?=
 =?utf-8?B?NjNUc2VZK0cwclJMdi9iRnl0U1BwSUt1NVU3RlRZYWV6bWxOQzlWbU5VRkdi?=
 =?utf-8?B?MEE5OEdGTWFVekY5VU5mUWYzUTN6QzB6cisvRWIxZFo3L1hUeU5aTFNoQUxk?=
 =?utf-8?B?ZFBVeW5ab29ZcTBPLzFMMUpKZGxQc3J2eE9yY01qaEhzMHVEWDNDM1dhOTJ6?=
 =?utf-8?B?bWljajN4M2liR2JmaHNzWmo0ZUgxYzJHSy9uRkFLMmZqRng3M045SUpnenBr?=
 =?utf-8?B?K2dsN053TlhScDg3QjBxM2U4WnJ0YjFZZE8zbWJ2SzJlTnIvcytBQVB6S0U4?=
 =?utf-8?B?Q0lUVXJ5MjNXSlVPb1F4RFVCdkJUZnQ4V1FTMVhGN3RVcUFTWEJveVlEYk9j?=
 =?utf-8?B?bnoyc09WdCtiYW9nOHdRckRWOUpRYzNzdmNxcHRpUTBnQmNmK3htb3llN0h2?=
 =?utf-8?B?WW1SY1NTdnNHRjVEWW9OVEFvbkd5NzI4dU8wM2xYVlloMC9qOXdGdlRNWHhv?=
 =?utf-8?B?V2Q3M0pPTG8xdmdmVEVTMnMxMlpXMkFIYkpKNTJzRjdmYUErK2J5dEM1L0Yy?=
 =?utf-8?B?QjYwQTV5NWJUVVhiS1UzZ0Zwa2prU0RaRUpHbUovYnhDRlNmaUxPVXlaajAy?=
 =?utf-8?B?ZVlMTVdmRjJtNk9Ea2NEZjBqU2VoZWdrQ2lnditiaVA2UW5Zam5qdzNQMSt0?=
 =?utf-8?B?WHBZWDJZdWR4U2tmUVQwdDB3VUtPTmZWZ3dJdGw4ZmRWL1llMnQvSy9VSjgy?=
 =?utf-8?B?T25mcFhpSndhK0J6SlFrWnhyck5HdENseGxTU2loK2JmZ2tFOU94WElDQi9o?=
 =?utf-8?B?b3E4enlzQW9OMWRrL2w2V3NMejdxSW5vbC9ZQmRwd3paN0d4T0NLWnRUS3kw?=
 =?utf-8?B?Qk1GWExqeHhQeWhnL1kxUmYrQTMzNjErZFFNR3VHdERkRktXYnh0V2FyOEdn?=
 =?utf-8?B?L1l3Z05GQWVBVEhvbGd3b2dPVzZsbGZCOC9hRllWWmZtMTdDYlYrZFphSDha?=
 =?utf-8?B?YUhKcVl4KzhEL1dCV2JGMVFaYjJRZGRnM1I2RHp3ODZVa3lib0ZsR0Zwcm5i?=
 =?utf-8?B?Y095Z3IzSUlzMjVaTG51T0VWc0ZlNG5qQVVmOUZublR6bDdrK0Jjam44UWtw?=
 =?utf-8?B?YUcxbmgzVXA4bVRFS2hTaStwdWE2V05KSjJuMDFMT3VFZS9hZzF1T1UzVnFS?=
 =?utf-8?B?RFR5cFhvTDN1TW8zUHF0MkRHNFFCV0ZDcmRmb3FFU09vb1BIZEZmVEpDbjBJ?=
 =?utf-8?B?TWhIRlpHdWtWSHVHWG5XREpmYkV5QW5NN2tMcWduYyt0Ykl6NGdtekU0cmpC?=
 =?utf-8?Q?HO9Ay1flO18r+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1FMOHFEYVNVUWh3YWc5eEk1b1NseDMyWUxwMFdQKzlPenBXOUNFQURmYVVQ?=
 =?utf-8?B?ajNiMlZpa2Z3SlAvTDU5SEFKcGJUK0lncXZvZlYxaGNvejFzbnhwMDZTQkVS?=
 =?utf-8?B?b2pZSTBBa1lsQlVHTW5peGhYQkp0U3QxNEZTcW05NGFDbEVaa3JJU1JSWFo2?=
 =?utf-8?B?Q09MYWpJZFFwZFNRWk5vQlFRamh4MTZhNEpzNGVCaHFmV3Z0dUxZT3l6UmhU?=
 =?utf-8?B?UFd6YkNrTmtzT3dFMFR0ZGlTM0xPRkVtU3MyWTNwOVhZNVdZVTZ3QTdWZmFa?=
 =?utf-8?B?ZENXbXMwNXJETm96Uy84WXM5cW4zYkVULys5Z3Y3cjh4K0JWRGd6bEF6bDFP?=
 =?utf-8?B?S1VGSjBkbURGYVpJQzdJVSsrNXBXbW5yYXJHMEgwaFBWdkR4SFpNZjVpNUdP?=
 =?utf-8?B?LzhDaXROYTJaUzUzdUhCV3M0WWxOem85MUNnamxCcDR3WTRUUGV3RStiL3VF?=
 =?utf-8?B?SFBVdkxRdzMxbjRmdTRNMkhZMUxZSC9yRUFTcTFBQkE2eDRYSWF1KzZOTGlC?=
 =?utf-8?B?S0wxUnNORHBCU3U4MzJYT2FqNXc0QUNSWEl6MEx6RmhtWGFJSFZ5YjZzT3NK?=
 =?utf-8?B?RklNc1Q4b1QyS3lXdzBSTkRDTkM2Q1hacGxadHRnTjNYdUU3SDhXRXJzelE4?=
 =?utf-8?B?SWRIYmd3N3l1TENMVlhQOTh1Y2t0d2VJMVpPSEFyamVaQVM1aUpZdTNmTjA5?=
 =?utf-8?B?QVFZMG1FcnZVVmZUQ0xIK1RLenY2TVk4UnY5Z20zREdqYTlNbHRnN0h5RFZX?=
 =?utf-8?B?WlZjWTJhS3FodTZ1ejJXM2RXcGUwdm1sK0N4aWwzVGd0S0xUcXRPRkZ2MjQy?=
 =?utf-8?B?YnoyWVdDQkU2UmN1c1NDeUoxYUtyMGRuT1lVa1JXRlUvdlJpZFV2Q09ibWsw?=
 =?utf-8?B?bUpBU01hTlcydktzM21rK0llaDdUWVBzV0F6SkNkdCtkUHVZR05pY0ZJTkli?=
 =?utf-8?B?R3BWR3BrTzJOZlB1OHB0Y2xXMXBTYmlwaW83d3M0cHVIZjc2Q1haWU9qUGN0?=
 =?utf-8?B?a3h4amlIRzI5azVMdjlwbmZpTW5QM0RWRThVdnBNMVZUQXN2emdlUDd6cWli?=
 =?utf-8?B?MjJNV1Q5TVRacVl6TVJsU0F0NHVHM0ZJalMyM3VSWEx5OW93bzJSbm5TenNj?=
 =?utf-8?B?cFA1a21Ob1lRWllFL0RrZjRZSXg5Y09jdUhhTzYwcCswcUthYzFpYTFOUmlq?=
 =?utf-8?B?WEo4bXF5a3BtUHVsRFNQUmVGZmtrOUZpZTVKejFYdVhjQXpmZW91Si9wNDRy?=
 =?utf-8?B?bk1NZjc5VjNuejZHM2ZFc2lzV0xVeFN2YWJ1ODhBUlQ2MG9GaGd2bnNENUkz?=
 =?utf-8?B?VUZ5Wlh6YU5jdlBEeVlBNG5VUm1haE52TlpYQmh1Rys2R2JKRjB5Z0dBYmxI?=
 =?utf-8?B?SUluY0FqanV6QWFFakNrMnkzUktScGVmUzFpUDVwMXNOaGxNN0tOcmxRVGt4?=
 =?utf-8?B?SHlUd0lPK2YySHZIWSt4QnNCVC8wT1hWV0d4UlR2eXJraXlmUnVCU2dCWVc0?=
 =?utf-8?B?Y1VDQmMwOU9DRjVlK3Y3eWRrWlpXZ000VlU3dlpGMEN3K2Z4VXEwL0lwZGFS?=
 =?utf-8?B?SklMMGhYRHJxTXEwR0ZOc0U2UGFBd1BHTjA3YkVjdEJ3MVV2dU9PSDFKWm9y?=
 =?utf-8?B?RFdXYlFYUFdadGlGeWdRcUdzOWVocGl1MlNRS29XK1QydW52ZVNSOTgxb2I1?=
 =?utf-8?B?eXRXRVBsWHhMeFIvOWVNRnJmNDdFd1loU29KSUNWcGNZRDlvQThVaGhnbEJ4?=
 =?utf-8?B?N25JYk9rVXg2VXV6OVBseGYxa3IwL3pDQzd0Rmpqb3pNaEQ1MTdtcVlCeGlk?=
 =?utf-8?B?T0NLdXJQR3VhR1d1aXVZUHUzRHNXZU9LYjgwNWhnMCs0ZXVTZUJsNEw1NXJh?=
 =?utf-8?B?UjR4aG5TK2JyRHg3WTh1L3hqZU1veVJtZkwxRkp5VzIvOVhuSjc5ck1Da3cy?=
 =?utf-8?B?WXY2UW1ETldYekF1QWtkZFJYRDF6SUJTTDJWU0I4eFZ4UDJWSzc2RnZzQjI1?=
 =?utf-8?B?YjRQemZYaXQwTXE4aktFaW5UYm5SdmVwcXpJYjVQemhNVkFuZGw5Yy9zRUNy?=
 =?utf-8?B?Q2xTNnFueHorNWExVXV3ZHdLUXpPZWNOWTFTV3pzSDBtMlBDSXUyZ1JPMFhy?=
 =?utf-8?Q?tzKtWXyO1SAMqijRfhoS64UgD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ffd5a7-4e3c-4127-5426-08dd694cbb36
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 14:20:43.8280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZu3PDnLg9PN+bR+XeRiaOiYZ1xKYcnfw6QAn81FWyZabfa/sUiikXrhr6kzj3RsTKirbh54/htIFkMV+VFUHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614



On 3/22/2025 11:25 AM, Frederic Weisbecker wrote:
> Le Sat, Mar 22, 2025 at 03:06:08AM +0100, Joel Fernandes a écrit :
>> Insomnia kicked in, so 3 am reply here (Zurich local time) ;-):
>>
>> On 3/20/2025 3:15 PM, Frederic Weisbecker wrote:
>>> Le Wed, Mar 19, 2025 at 03:38:31PM -0400, Joel Fernandes a écrit :
>>>> On Tue, Mar 18, 2025 at 11:37:38AM -0700, Paul E. McKenney wrote:
>>>>> On Tue, Mar 18, 2025 at 02:56:18PM +0100, Frederic Weisbecker wrote:
>>>>>> The numbers used in rcu_seq_done_exact() lack some explanation behind
>>>>>> their magic. Especially after the commit:
>>>>>>
>>>>>>     85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")
>>>>>>
>>>>>> which reported a subtle issue where a new GP sequence snapshot was taken
>>>>>> on the root node state while a grace period had already been started and
>>>>>> reflected on the global state sequence but not yet on the root node
>>>>>> sequence, making a polling user waiting on a wrong already started grace
>>>>>> period that would ignore freshly online CPUs.
>>>>>>
>>>>>> The fix involved taking the snaphot on the global state sequence and
>>>>>> waiting on the root node sequence. And since a grace period is first
>>>>>> started on the global state and only afterward reflected on the root
>>>>>> node, a snapshot taken on the global state sequence might be two full
>>>>>> grace periods ahead of the root node as in the following example:
>>>>>>
>>>>>> rnp->gp_seq = rcu_state.gp_seq = 0
>>>>>>
>>>>>>     CPU 0                                           CPU 1
>>>>>>     -----                                           -----
>>>>>>     // rcu_state.gp_seq = 1
>>>>>>     rcu_seq_start(&rcu_state.gp_seq)
>>>>>>                                                     // snap = 8
>>>>>>                                                     snap = rcu_seq_snap(&rcu_state.gp_seq)
>>>>>>                                                     // Two full GP differences
>>>>>>                                                     rcu_seq_done_exact(&rnp->gp_seq, snap)
>>>>>>     // rnp->gp_seq = 1
>>>>>>     WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
>>>>>>
>>>>>> Add a comment about those expectations and to clarify the magic within
>>>>>> the relevant function.
>>>>>>
>>>>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>>>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>>>>>
>>>>> But it would of course be good to get reviews from the others.
>>>> I actually don't agree that the magic in the rcu_seq_done_exact() function about the
>>>> ~2 GPs is related to the lag between rcu_state.gp_seq and root rnp->gp_seq,
>>>> because the small lag can just as well survive with the rcu_seq_done()
>>>> function in the above sequence right?
>>>>
>>>> The rcu_seq_done_exact() function on the other hand is more about not being
>>>> stuck in the ULONG_MAX/2 guard band, but to actually get to that, you need a
>>>> wrap around to happen and the delta between "rnp->gp_seq" and "snap" to be at
>>>> least ULONG_MAX/2 AFAIU.
>>>>
>>>> So the only time this magic will matter is if you have a huge delta between
>>>> what is being compared, not just 2 GPs.
>>> You're right, and perhaps I should have made it more specific that my comment
>>> only explains the magic "3" number here, in that if it were "2" instead, there
>>> could be accidents with 2 full GPs difference (which is possible) spuriously
>>> accounted as a wrap around.
>>
>> Ahh, so I guess I get it now and we are both right. The complete picture is - We
>> are trying to handle the case of "very large wrap" around but as a part of that,
>> we don't want to create false-positives for this "snap" case.
>>
>> A "snap" can be atmost  (2 * RCU_SEQ_STATE_MASK + 1) away from a gp_seq.
>>
>> That's within "2 GPs" worth of counts (about 8 counts)
>>
>> Taking some numbers:
>>
>> cur_s	s	delta (s - cur_s)
>> 0	4	4
>> 1	8	7
>> 2	8	6
>> 3	8	5
>> 4	8	4
>> 5	12	7
>>
>> The maximum delta of a snap from actual gp_seq can be (2 * RCU_SEQ_STATE_MASK +
>> 1) which in this case is 7.
>>
>> So we adjust the comparison by adding the  ULONG_CMP_LT(cur_s, s - (2 *
>> RCU_SEQ_STATE_MASK + 1)). i.e.
> 
> 3, right?

Just to be absolutely sure, are you talking about the value of RCU_SEQ_STATE_MASK ?

That is indeed 3 (RCU_SEQ_STATE_MASK).

But if we're talking about number of GPs, my understanding is a count of 4 is
one GP worth. Per the above table, the delta between gp_seq and is snap is
always a count of 7 (hence less than 2 GPs).

Agreed?

If RCU_SEQ_STATE_MASK was 0x1 instead of 0x11, that is a single bit (or a count
of 2 instead of 4, for a GP), then the table would be:

 cur_s	s (snap)	delta (s - cur_s)
 0	2		2
 1	4		3
 2	4		2
 3	6		3
 4	6		2
 5	8		3

So delta is always <= 3,  Or more generally: <= (RCU_SEQ_STATE_MASK * 2) + 1

>> Unless you beat me to it, I may modify your patch for v6.16 augmented with this
>> reasoning ;) (Also since I am also working on adding that forced wrap around
>> test to rcutorture).
> 
> Please do, I appreciate!

Great, will do.

>> Also it is still not fully clear to me what the root node has to do with all
>> this in your example, because the rcu_seq_done_exact() needs to be what it is
>> (that is having that 2 GP adjustment) even if the rnp->gp_seq and
>> rcu_state.gp_seq were in sync?
> 
> Yes, this is only to explain that the maximum drift between the snap on rsp
> and the current state on root rnp can be at most 2 full GP. And that explain the "3"
> magic in the function. But if they were in sync it's all fine.

Right. But I would argue that, even if things were in sync, its not fine to drop
the magic number. Because you cannot take a gp_seq and its corresponding "snap"
and compare them instantly without the "ULONG_CMP_LT". If you do, you'd get a
false positive. But as you did, we could say that the lag between rnp and rsp's
gp_seq values is also covered by this "ULONG_CMP_LT" expression.

Glad we are discussing this in detail so that once we forget all this in 24
hours, we can go back to the archives ;-) ;-)

thanks,

 - Joel



