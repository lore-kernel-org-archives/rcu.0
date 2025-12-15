Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020139.outbound.protection.outlook.com [52.101.191.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D215224AED
	for <rcu@vger.kernel.org>; Mon, 15 Dec 2025 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833071; cv=fail; b=RqSZjv+pKjiM+R9grHk55nnaVa3o+K0x9o3ArTYjrrRfIRQNFKtBFFjo9a920jEkaBtef4foGx/697zRxV+h1XjtKyotkZ14hC598TwsPwS51rCjfX7kw/1FJLZk53Yp3hrOdCW4XZhXBku8oayD6gP6PXrWjVQJcQ2HkJhCCqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833071; c=relaxed/simple;
	bh=RTwpTKGYpPk804hlbU0khNUk6TrULVrC7udJFRvzj9g=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r3fj5jY2nKhuj2zuSZQ6RGJfB/FukGdlyiWG7BnNlyMzcg30FG3sFvi7iu5/T6bvwXDB6PnkZRFqcwQrX8tMlu6siln76y48KDeSOioR3rNb2Exu8KaQmCZf089dqUU3rB5t40Y99J+vO+ESlPYxvb56OMqauq+WRTUVgXnRMhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XodypT80; arc=fail smtp.client-ip=52.101.191.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XodypT80"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMuEsTLUGYhOK6XC/WAXxqv1cjW88BlSMlb/PgveM9ucdsc1OI8iICwFi/kMHrZYc/EYWaDeWaVNl/2/F3AVz3lCJyeTAqNbBON8Y3KuZ6acOTTUVg9PKszIrOTDdsIVQ8b5Sp1hKTQgY9F3kgTXNqyRua1qcQ2nuA5Htu2oNfDW3xxkSA+ZUQHsn5Kyi7yMqew/rNkHYQ31d8TYGHx8dylPnqg9Hugv2LTgbVW7iKLzu2VzGIXzEVLaf9V3TvrTijPSbdlRFnEo5GTCeni3lDj2ZJIERBMg1rg3XTCfWrfzI8Gi0vFzYHasVAuNk9ePlDESXEc3xfWg/6E44XUcmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLVAz8gYITO5XyjlcWagfcpN3BKOaM10TN1flG3n6P8=;
 b=wGllO3mi2DBqVdvo7jrEn31c9+JgObhrcFvvh9ZR/vb5KRFWq15vhc57vKQEznoZXIfQ3W+ISTdr7xBfuBpR5g5BmiHm+lUbqdZy2cUAbR4+5sEJucT18KGxzqjKlLuUm4JhCbhPbrxSPLMRhwLbWcqkUsyNowZ0R5Tb9FmQvzxNeMHDryPpqygrKEXWQV5iYjbKDc+qv4DpB5WbLjFhZwhrm0cOiw2H3cukKBw1KJgyHtuZlru5O5gSlT3XT0uDeK63D4Z6UJjLdF4m1fcNhTAp9w+UWfd1yNbF+5airHMf2IA7kTH+r8lFYEBYBRWs808aAlcpTg3livCZKcZ76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLVAz8gYITO5XyjlcWagfcpN3BKOaM10TN1flG3n6P8=;
 b=XodypT8086Naf+ih+tRaoavGpGSvMLo4+gpFT/UctYrh4OZjHghHlU3UYkAwESkh6E4irv8IzhH4FKm8D9kzUwBhPCgPNzVmOWO+f4KsvK2hDo3pqLhH7blg+IVy5+40KG6XpLhF8YFmTSPKNQ+VRT87wnGM7Z0z4SEr4eoYAy0shkTVjPphJPDefsRrtgu1bfM/O/cm/tpSh/AmFXWuV9I0r1UIwbinRNyOcJgSCSQ2tSVHOhDTwUtE2bvQQSl2EdiD4SNnuI5AepNDvKxj00ssgXo5JO18JPAAbGX+lsfqcUhL05VHCJFLjIKR1Yc8pj4hr3UxEOukyvxFDV4aog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8404.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 21:11:05 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 21:11:05 +0000
Message-ID: <46e90069-e782-47b4-b323-ce85f6efa83e@efficios.com>
Date: Mon, 15 Dec 2025 16:11:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Handling large numbers of hazard pointers
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
References: <77ffb53f-91fb-4bd4-96d4-e16b0e6ff0f1@paulmck-laptop>
 <091915fa-d6a9-4aba-99c6-d93d9b65e0de@efficios.com>
 <961B6DB0-3071-41D0-9AB6-70B76C547F19@nvidia.com>
 <207B1F17-D789-48DC-88E3-352ECF0DAF11@nvidia.com>
 <1ee9bfee-d754-48db-b72d-763193cb92ca@efficios.com>
 <aT8iw4zfk3sTKtMH@tardis-2.local>
 <3b3fc28d-3e95-4376-b0e0-e3ee41564c82@efficios.com>
Content-Language: en-US
In-Reply-To: <3b3fc28d-3e95-4376-b0e0-e3ee41564c82@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0334.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 07949d34-eb6f-4512-053f-08de3c1e75ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UThha0ovcDN4YlduM2hIVkxjUnpjL0Nxb3R2cjJvTk52eEdoT2N0ZVRDS1Fq?=
 =?utf-8?B?S25HdHNRWWJROThkTlFOT09KUmVSb1FWNEZoako0ajZ5dmIvbzdWQ2d4alVj?=
 =?utf-8?B?NnZIOHdBbXpiU25aRUdld3ZuMHhxYmxxMEZ4Y3k0Y3JmRG1iYU16U29Lc0Jj?=
 =?utf-8?B?MEs2SytUNjRQYi9ScXZZWUYxd3pkcW41L3VUNThnVVJpWFN1M3NWazZPd2sr?=
 =?utf-8?B?VGRYK1k5aTE1RitwZEUzY1pQTm5kQWwxbzNPUnBiSXdqVWpObktjRjIvUTIv?=
 =?utf-8?B?V3Nmem05b2dSTk1vY3JESEgwQmdLWml1RFdRekk4SFQ4Z1ExT2FuelYzVHhP?=
 =?utf-8?B?Q0hhU1E0VWViVVplaHpvanZ1YXRuTkI1NXdhUGxScUExM25aZE5zck1EQ2tK?=
 =?utf-8?B?TXAyS2ZaSmJIMG1TMFF0c1duUkV0UDhIQnVqY09TaEl6djRUTFNnQlMxYzVI?=
 =?utf-8?B?LzNmMHE1RDkwUzYwMDUyL3RBeEFiSzdJUlVpajBxc09mUFAvamZOdEdhUlRE?=
 =?utf-8?B?RlZhRFpPanRtZ0VWZmJCUi9uS0N1MEttQnJreXBVWjFuMnlCdU9kYitiUkxP?=
 =?utf-8?B?L3FTQ0FZWWorK2llTjZSY2RuN1FaRDNTVFNTMEtsODRlczk1cFZ0SzFZOERj?=
 =?utf-8?B?UnhnSGpSTVptQXJtOFNzQW9Qd0cvZlhQZEMzbk1BcnYrYjNvVkJ5aWV3RWFu?=
 =?utf-8?B?UGJib09HcThBSTFpeElaMG9XWWVMT1FmdVE4cERnVHlEd3N1RXZUNmNKR0VM?=
 =?utf-8?B?RkZWa1lhZ0lwRzBqbHA0eThFNUIzWVpCK2l4WFN3emJCUmhFSU1hSHdEVHRT?=
 =?utf-8?B?UzhOcTlWSDVwcjhQNjhKd3ZzQlRZSldocC9HeS9YRnY5SjFRQkMxdDU2Zk1K?=
 =?utf-8?B?UXRTS2RtTTY4WkdXMjlqcVlad2l1NHd2ZURGVHdpQXBCOWJpU3JGck1uU3lr?=
 =?utf-8?B?OXdMcFR1NjZyWExTZER3dVY0enBXVzVSV0J0R2pJMVhTanM2Q3pPWHdKTnhF?=
 =?utf-8?B?anNrdzNmMkhlbVNKTDNKTTZydkNyUHU0RjJ5cE5WUUlQL2NBd1p5VzBrcUtW?=
 =?utf-8?B?MDE4OEZZOVJuOVhUSE9DVVViNmFXVmYzQUtnek5paW0rbDNIOFJTNTNZUjB3?=
 =?utf-8?B?WWpOWHVUaW03cHdYakFpK3lLYkRrdWp3eDJ2VnArajJGYnV0WUc3d1AyQVhF?=
 =?utf-8?B?eldMbEZaRklHUUxxMUs4UEVqaXVXSHF2VVBpM2g0SUpuNUlDTHhBRlMrYlN6?=
 =?utf-8?B?VnpnempKdjA0SG1CVkhjcGxTOExISGk0ZWFSbUJVYnNDclYwQURaNXdmaDJT?=
 =?utf-8?B?RHBDczlQMnd5ajFTM1BDcGlIQWpRb1B4YmN4ZHlncmZHUFJ5bnNucG9oVWdP?=
 =?utf-8?B?SHM3dzNhR2lTbFhDUks2WmswN1dicmxIYWQzcER4ZmQvR3plUThtY0wxMEJE?=
 =?utf-8?B?eGQ0TXNHMHdpaVdvWTk3YTlGdGRJYUNPdGhnSlJVUjFaemVZUG5LTWdZSFdD?=
 =?utf-8?B?VmRiU0E2OE1GUkZhMitQNlNNWVhJQmdRQVlPVGtYYUpPbUJESWpJUTdraTQ5?=
 =?utf-8?B?VHA3bzl4WVVva2wrWERFaS8vak5kSTBIMEh6MkZnZ3BSd1F5a29EUzNUY1hj?=
 =?utf-8?B?WG5OQTVsVWVrL2t2ekJZazhuRnNVajQwTjNRY01KZHd1V0NWeVdCYnMvTVZm?=
 =?utf-8?B?Z3hZbnZOMnIwZWVSNENGM3Nkb1BqTGpicW9MeFZNa2hZTEJtVklCNmVaNEh0?=
 =?utf-8?B?RlJ3MkZwRWY0UUxna0pIemJpODJ2VERHdG5VVUdLampnVUlBTG5nZW5CMy9Z?=
 =?utf-8?B?bEpSYUU4R1l3R1dzSHFXZ2hSM2hsdktuYjdjZDNENTVkRncrbFNIUXZEbi92?=
 =?utf-8?B?S1Q4WXFzSDBObm82eGExYkxIc0hsVFdLSDAxL290SWUrMEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlFZT3Bia2lEMjBRd1VuQXpYcnY1NkROSTFOajV1YWJ0R2t5NWNCU2pDTUN4?=
 =?utf-8?B?NkJIU2lhWlB0RGhUNlVXV1loSVZkeG9ReTBXQWkzSTNTSm11ZUFEZjBLYWFU?=
 =?utf-8?B?ZVJNblZFaTNRemJYZzlYMk0wbTNWR2RVWFh0SUF4eDNoVXlWNXMyRmIzc2V5?=
 =?utf-8?B?SmFxb2o3SXNQbkJrL0l4cWF0MEpGb0NBOVNVYUpQbjNhSGF4cENRazB6QnNa?=
 =?utf-8?B?azlCZmhCNmFka0F3ejJvZXYyVnVtM3VNdk5GY1NYM1lkWGRDZ29hZGRMdm8w?=
 =?utf-8?B?MGJ5WmtZeFpiOXZTM0djeE8reDFwYWhIcEN1QmlsdnBVdk50ZmdtN2RGUjNY?=
 =?utf-8?B?eE9pRTRicnczVHBIL0V0MmZUYk5FQmVKTGJzM3h2U1Y5dVVGU0NMRzJhdjhz?=
 =?utf-8?B?akFuR2t0L3VRbWFDVEkvb3VEcE9wOWgyYkRGTVJsREFGMW9BVkQ0Ujc3YXJk?=
 =?utf-8?B?c2JCZXkzd3pIRVM2K3ZMcThrQW9DV0lzbm9uK3MxRUQra3BFTjNPYTZCVmNa?=
 =?utf-8?B?MzU1QnoyMG9lNWV3Sjg0ZlFCN0JjNU43aEdCLzQ5WUNnMXhXTjBpdmNBcVd0?=
 =?utf-8?B?cm1LTURBbGhkejdaVU9saUI4d25ta1ZUZ2p3cU9TMVYvWTBtTk0vSlBiMkhS?=
 =?utf-8?B?VmhZWkhSN2dHbTIzYVdXdnp0Kzdsd2NsdEpRZjYrT0RCWE1NWCtSQlFCUXp5?=
 =?utf-8?B?bThBcW84anVLY3VwNVhUUFBjS3ZDY3RJR1dISjRScUtIWmQrYStJZXA2dGt2?=
 =?utf-8?B?N0lhUU81QkpJaXNLRENKemZjK0s5R3JZYXkyak84bFNlZmxNS2E3VHVrZTBM?=
 =?utf-8?B?OVdqMXpIcHF5L2dUVWROelNmcnNzODdORjJML0hka1ZUdWlNRkp2bmswSW8x?=
 =?utf-8?B?c214RWpZRUNid0hEWUkyQWJ2Q0hldHpISmx5QTZzTlhQbitNbEppWnZ0TllR?=
 =?utf-8?B?d20rSVlzbko0TjlMQlNpZzR5b1VvSmRvK09pMmJBTWh5UnFsWWxaTGc3S0to?=
 =?utf-8?B?dzkyQ0VKay92YWJmTEtGQ0xzZFpPeUxRQm5VbCs3Zk1WbW5XeHZDbVdvd21t?=
 =?utf-8?B?U2lxeXA5R1R2dlM4Z09OMHFia0ErcFpUUVZRWEtlRThYTFlURXpwQURUcHZO?=
 =?utf-8?B?ckRDUE1IbEI2Y0lQTmdaY0NZSnhIMDByTy9XRmduaHdjSVNtdHZOVHkxZDh3?=
 =?utf-8?B?allmdkFNb2NWUVo1LzFSY3JMTVdrM2F4aWhmQ2lFTGpDeDVLdjF5bllYMWJ1?=
 =?utf-8?B?YlFBUGV0UHN1UFYzeDlhQ3dUclRFbHpCZThCRVpSWk9PbTRzRzZlRVFTclFi?=
 =?utf-8?B?N3NYK01tbVlBdVNxa3A5OFZCNjlvV011UGlUN1pnL3cwWitZcVNVYlZOWWNJ?=
 =?utf-8?B?NHk0YTd1dWFDalFWZ1R4MXMzZFJTOVcrMGhNNHVnVW9idmptc3FPN0gvYW9C?=
 =?utf-8?B?Z2huWnoydDRpeDQ4TkVWWm9OSktvVDBHdXhnVlFZYUJ6TnR1M0cxbVRwak1x?=
 =?utf-8?B?aVpVMDdhOXZoOTZFSVFzRGpaZktwbGpKdEFNRVd5akxZSmlPTDhpR0VqZUwv?=
 =?utf-8?B?WUtjamxBWm41REtydFlpQndHajdhRDREcTh6YXpkQ0xrUEVPU0tCUnFLRzBL?=
 =?utf-8?B?aDdYZ21MWGVXNW41VnhrdTZRNzErNkJCREdzaEFkRGtIR1NXS0Jtd25zR240?=
 =?utf-8?B?VXZjUk9LaFBhSzdySTNxbjNlY3U4cGExd0xrRWJ2Z3hUK1VnT1hPN3pnM3pm?=
 =?utf-8?B?bkRWWWJQa1RzcjlhRXkxZ0hXK212V2ErQ2x3UnJKUG9leU9hcTI0d0tkL2lG?=
 =?utf-8?B?VExjT055eGNpWFhiWUhkOGRWRm9tYzZhUHJFbHVGSi9wYmZVR0VkMkV5WHJo?=
 =?utf-8?B?eXBlMDc1VDJseWNGenVDblZmbFFlSkpYaHpMcTFiZ3JFYVRBdzNsTSt6SWs0?=
 =?utf-8?B?RFE0SDZXL25Wb0dhWFF0dndOdGc2aGVZRCttQjNhMmtNMHhTWGJXdkV2VlA2?=
 =?utf-8?B?aUsrQkxnZ0NPTGIxMStEVjUweElpSWV4bnJLQ0xGclRHMzJKakEzdTZOY2tQ?=
 =?utf-8?B?a013WVlxTlRVOTVLdHVqTjFjZUdlem1hQ1AwS0tsRVF5c29MdWIwcEkvUExu?=
 =?utf-8?B?U0FaQkFkWldWYnVJeE9ydnpHandtaWxmOFhRaGhvbXhHNmFFYVJCVk12bnpa?=
 =?utf-8?Q?phqvbBBIEI2ZbqUPISpz71w=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07949d34-eb6f-4512-053f-08de3c1e75ca
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 21:11:05.7192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLooPvf2jmo18UuLmMPIYD3hJwiwFWbNBN6GCgkDzpS0nV+rXpVelVASlTgquKjkOLwHqa5KWlDK3wmbomB9AG6kDEV4TA/p2A3tmDEh9oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8404

On 2025-12-15 14:34, Mathieu Desnoyers wrote:
[...]
> Feedback is welcome!

Note: here is an updated commit which renames the
"hazptr_load_try_protect" to "hazptr_acquire". The
change of name makes sense now that the memory for
the backup slot is already allocated on the caller
stack. The hazard pointer acquire operation cannot fail
anymore.

The loaded pointer value change scenario is handled with a
retry.

https://github.com/compudj/linux-dev/commit/cd9e8721a2409d7ab651c9a191f35a48fcbc4e9b

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
