Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9B801;
	Mon, 21 Apr 2025 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745267282; cv=fail; b=RQ2/T/KWVojw9iAkedUumDjB7NPZx9xnMDeN+gHQMg6y/NNQRlJOsflm1k2dI9ok8B/Y2DLQDl+wVSaEAxjRBq2FAGl2wfE5mDEzrKJ3ubzv8xMVpcs1KjKIzZqpjBsmrllGw+BN/fDIpJ9nlLx7LVnbkUx5Z9PVqPyCCkkaPRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745267282; c=relaxed/simple;
	bh=qFkMGDcnFdavsNs/QpqyVwm0B70mcJhoI5LL/qPB6ew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dzjs6ehPoDz5ZlE928VbP8z1i1hh4w8RJt1rOJCBXEd0+K3KH4nKLXyTC+HFhb0dgrvyMZ1jO5MB0e4kth/ohxRTo7nswGW6OWdo2/nIKbAOCqdZcTepOX1AWgUQXqQNauB58oeoZQ9ahMgV1TEn+SJrgU7O7nBn5VQx9ykN86Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UZsVv9R0; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UZsVv9R0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNJjzWKcQEKat3qAh5UHnpKjOpZEli7xSyxc9C6Ce6q5XHimpRZLzBjIH+s0ynnWlTALqAoiz0Vk7CJ7XN/oZf0kFPYfumAiUn4U3ZleM4WZNyUUfp7lFIO9x0M4dikGuhjX0TRbCbOvGHWrBbMMqa+ozsTvhOLa1B/WNW26OFYR6kzm7CDNCmJVKmfjnFrZJVx798N6a9zAo1b1snAuV46g933vOhkYVtTm/PDzZgZ0BqgIq0yQWXaKy5FwiJ2JYirtfcTYsRQWgrmS24TYrCM5MU+6uCEw4GMchRItjXKXEcXcCRdrj0UMVygD9XI3ASWmh6ogI0LZvVOZRsImsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nss+oJgbkxSi34A/oY3527d/ssZlq3c5aavZ/xoA1ZE=;
 b=qGyKiN1ZcnRk7Ip0J3QA1vFNOanzvUVr8OefQDKJZ1v+Wmhylm/lAapSiWGjN6O9/ifVYZAMYmrtI6PACyRA5dYyQgiK2hoT9xr4KTqLXfBG5D8xTeRruhLM5FIlmLmqJdpL/17NBg/UJW4vYoOeF0UVwp9IU+efAXMoNanw4iJkPWo5tMeq8CtXNqjrGEtIK0hj6sb9u7mcPAXBMwiV3OfPQ3g5c/HZIQ2riFvG6BWozNjD58Y3+Fv+KzYxoL5Edb9jAT9O/sEXfzAmGm1sTPCe8vwLnd2Q2qse+duwRO6lVQ5gIHdUPfd7jWY74ZjIAtiDclh8tsR+usz8yAACWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nss+oJgbkxSi34A/oY3527d/ssZlq3c5aavZ/xoA1ZE=;
 b=UZsVv9R080up0j1utdRECEmFxHQuOhhgwRtJ/Gmn4icOTgsNtR2vhLHJpwjJTtJk0n4f+AOCry2KPkAu4yH123FJGTCATa1vzWi1cWdzprPyXRPhEBuuGjrbeeatCjWBWaL2WfOr2uj0xMr3F5bMobAN5PuP1fbJCX4QKMNji9pY9pSZCYktkafUJBuAq18JufTyfPkrQM0TiW5rMPoblIJk/ZWzP6l/2OzKVLWWNyGcFubx7p8Mi/+9dPQjwigQ4kgApBdl0BUXKhUaMLpgKH8aChdWe3TRNV2azd00vAgD7wUjJ3IWkxyHsnj90KVLfsXCRhUrqaWVdGSsnTFBwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Mon, 21 Apr
 2025 20:27:57 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 20:27:56 +0000
Message-ID: <fcf1bc68-d8f1-4efc-9315-d333cf6ddcc1@nvidia.com>
Date: Mon, 21 Apr 2025 16:27:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] rcutorture: Perform more frequent testing of ->gpwrap
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250421174717.3332525-1-joelagnelf@nvidia.com>
 <cdc20491-a0a8-4dfd-9326-797bb0de0f90@nvidia.com>
 <6e1d8bbb-41b6-4e5f-878a-c35a7405444b@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <6e1d8bbb-41b6-4e5f-878a-c35a7405444b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::27) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6a1ced-f194-49f6-f90e-08dd81130027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nklmc3R1NUlYOWtjTi84bnBxRkI5bFN1YlhwQUs0WnNFSnh6V3RmN0wxbmpw?=
 =?utf-8?B?bkp0YTRhVTd3K2VITjR4NnRkOEdSWWhmdzFZeEsrMWc4L3JEdTNaSVJkK2Va?=
 =?utf-8?B?bVlsTWdVQ1dKQWlMMVdaRVgyK056NUxzbkYxWmlDMUc0OGNRKzNBUE5tNXIz?=
 =?utf-8?B?NE5Db2hDb1QrUXBmNDgyUnR2emxVMlErSU1YUFlUTFYvRWVDTDlROC9XUlIw?=
 =?utf-8?B?V0tRRG0vRnRVVHNyWDY0V0ZXbFQrdFF3eWo1TDBRRU5BcFdLTUd2SzFEdWFK?=
 =?utf-8?B?a0lzSzVkaGY3QzB0QndWWUxUNFhOWlRWQkxWODl2WC9UWjJHeHlFS0hFYWQx?=
 =?utf-8?B?WFhEOUtUTDd5K3VhNHhEWHpQaWRwYW8zQVZGajk4dlJHTnlQNk9MM3BadGw1?=
 =?utf-8?B?TjBTRkxmY2tpMDlQcmFwdGZ3a3lEKzdxSktJZnBISEVSVVRCNGhZeHJzbDdB?=
 =?utf-8?B?N2w0Y3hXRTFKNkM2c3E2a0NOd0kzSTIvUlAvSTlya2FTcDd0UlhuZnAvTW1S?=
 =?utf-8?B?Y0hKVE56REtBZlQvR0RWSStCbXlhZWp5ZG4zb1I0NjhxR2d2N01WRW5ycEVy?=
 =?utf-8?B?MVVKWDVCVWE3VVVmUFBSSVEyRnB1S0VrMVNXNTZxNk1Md09lVmpWaFRmdm5S?=
 =?utf-8?B?NGxoRDA0SkJKcFFMMUdsQUhlZVJRNDJQSE15SEV4cGNZOGluQVBYMXJWcWlz?=
 =?utf-8?B?Mkh2QlhtN2ZjWW1ZaXV1VkRsRFhBUUVNdXdxTEZSaE5aeVlhYjdZL0dCVXVB?=
 =?utf-8?B?eEg0M1NxblJhL2FBUFlnVlUranJBS3ovWTRQcERyeHpkTFJYT3NyYTR6RS9x?=
 =?utf-8?B?UzNDYnBoZ0lUd1V0WW5MTHFBNy9UWlBEMTk1ZmIva0xrRUFRS0pSdzVGSHBC?=
 =?utf-8?B?WGxaMEt3bU5pbzR6MWNQWjljemRqa2hCdDRnK1NxTkF1Q0RKdWQyL0hBaDVs?=
 =?utf-8?B?dC9PSEtCUmE4dkdIU2lJRVRubE5mL2V2U1V1bzZpdE9XNGcyY2xwMU9RSjlh?=
 =?utf-8?B?TlhZK0FmWHNBaW9ZYW9CZDBiSGRid2lyS0lCOGMxODlnekwvQ3AzVXl2WlFn?=
 =?utf-8?B?RFNxMkZza2VYUkJYdWtnRlNDZkVVT3dpU1RWVDVia2YxVmQ2ME9QUG5JRW12?=
 =?utf-8?B?WjYzN0lYaUNxM2hFUG9ldXhSYXNRU0RJeDdjR2J3SFI5WndXbU9uQW9HRWR0?=
 =?utf-8?B?SWYwcEw5RVZ3MGRXMFV6UjJmejNKVnp0OUlaaG9ZNjY0U2VCVHV6MUJWOHFP?=
 =?utf-8?B?Q1VGU0lvUDRXZEUwcEVaQ2NtclJzT21YQS9GQnYrenMwYUpzRk0zUGJOcXB1?=
 =?utf-8?B?TFpodFVSZHJ4Z1hmWjFRTytCUUs3R3I1K0RocWVJVVBIU1VQci9HZ0wzTk1P?=
 =?utf-8?B?ZStzMXc5aThjSnc1MU0zTWVLTDh3THduRk56V09mKzVYZmZ4T1p4SXl2cWZP?=
 =?utf-8?B?TWoyUEdlYyswSVhpUm9Sa2w5ZkVDRDRRYzlKc2owNS9Qck5lQWVkeEFPUjFC?=
 =?utf-8?B?VVhydUpkbHp4NHV4WHlTbERqQlU4UmRHaVovMHBzSFhrdTR6TUNoTnF0K2tX?=
 =?utf-8?B?bSs4TDRvanlvMG5NWlJsVXpvWmhyVTZySGNOeEpTNlp0emR3UEt1SWVOVjMr?=
 =?utf-8?B?TUNtVlRkSjQ4c2trRzlyT3FSdEVxcG1HYmdXY3REOXZDcm1mMUdWWkQ1Y2hl?=
 =?utf-8?B?cUx5c0w0SUdZakRjU1ZUSjRWbjNIelVLUzVxRUdrdzZDeDMvTGxXREJ5THdD?=
 =?utf-8?B?ZHc5RUJING1zckV6VWV2cE1FQmRCbTY1V0p1M3VtcXc1NXpaTGMycS9lOHJv?=
 =?utf-8?B?OVlSSmZRS3JpZm1TbzREZm1ZaEYzTDVrR1RWclg1WVJqNlVRVmFvZlhQYURY?=
 =?utf-8?B?NkNtc0tOdmNlZlgyVGNJaC9PWWp6Z0UxREdKT1F6WGFDanN5a08xRnBEa3Fi?=
 =?utf-8?Q?YzjpQGBHzUU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aENRbEpBUEMzZU9RYSs4bEF0SG55N3pjQVhzamt3eXFrRGliUUl0TzdLdFhx?=
 =?utf-8?B?aFh3UFB0bCt6TXJ6TFd3cUFMOGdYZ2YyL0tTblFuY214M3Q4TDA2MnAwTU0r?=
 =?utf-8?B?YWhGL2RwLzM5WUhvT2pLZ1RhcXgvYVVJWis1VkZyTzlLWnoyK3Z3YitZZ2VV?=
 =?utf-8?B?czFVd2ZmMkZ6Qy9WaDVOMTVkZlcvaG1Fa3pHTU9XbGVNRm1xYTJDdjNsMVdI?=
 =?utf-8?B?N3hmMmR2MnB1TkZ5QTBCSG9YN1FvSy92RWhlOHprM1FNZFBwR1Jnd0d3Um1a?=
 =?utf-8?B?WWNJaWoxR3dWNTg5L2xvanpNWCtXTUtOVXVPSGlqL1dpd00rZ3Nyekx2N3hv?=
 =?utf-8?B?UHVidStwSEk1TFNPbkNuaSt3V1p1V09LN0VJZ0pnNkRaTVBNNVRiaVg1MDJB?=
 =?utf-8?B?emtZTzl5VDhkdFBPZHFqQnBlQmNhZWdJcFUrTzdHc3BGeUpsMnZQcGRESENY?=
 =?utf-8?B?TWxkWGF0OUk2YW5WdWwxZ0RCSXhlczcwUmtMVGQzU1BFMzc5a2thYnBXZFhj?=
 =?utf-8?B?cGZWWEhCNktxMUQyeVkvTmc4TkhPV05EQksrOFBMclNaS25STkgvdTJ4cnAr?=
 =?utf-8?B?VUJDbzZZUGtscWZhSWNWNzU5OVB3SjlrVnREaDRNcDNqU3hkZ2JOQ2V4YVMr?=
 =?utf-8?B?UExySVBkTGNxMFNsdURMMWY5ckFNalRscjlySHc4ZllHR2crc3ZVd1Rzbkc3?=
 =?utf-8?B?SXlwUHBvN0YwSHBXYkJRQ1N6MlFWVHBsMnIxTERGaGQ1blpaT3RVb1FUL0lS?=
 =?utf-8?B?M2k2enpIUEFQM1loSjlRSFgvc2FPOVdKa0pxWllxRlhqTVFiWmFGdkhGMDJz?=
 =?utf-8?B?MUJXbkNQSjVERUxsS1MwMDg2a2lVVksvYkYwaldUdnJuQjRtaDU3RXpJbUtD?=
 =?utf-8?B?OWJJWWhqR0xCaXMzOGF3MjNTbVBnYjh3cWoxcTBIaXpVZExrWitYMTBNZmdx?=
 =?utf-8?B?dStUWkNLK0o1VE1MWS81YlB5OUhyRFJhZEtaS0hIeW1oTmhQSGJnVXdxbkdo?=
 =?utf-8?B?eG1VMnkzTXJzYVFYUk5SVEY3dWJZQ2hZTXpNZGE2bysvZDVhVHdXLzhnaEkv?=
 =?utf-8?B?ZHJ5NmxWR29QOGQraEdua2lwT3drM2FMUUtKZjd2S0wrVDBiYXIzaEtDZFVH?=
 =?utf-8?B?RU42c3FrL2FRb1I2eHE0cDlZa2xRR3VEMTJBS0ljWExVN3U4Qk9yRGdBWXBa?=
 =?utf-8?B?R1VJclc4aWlvUVVoRXBXOE5tRnNOd3lDRDN5NnFaUlhmZlJVM2NMdUgrTURj?=
 =?utf-8?B?bGs1K3pveW8vVGg1Ym9SbHpRRTEwbitpeVBTbmFxM3E0VTdUZTVZUEc5SW4w?=
 =?utf-8?B?R09Yb2lFTmhNMUlJaGNVTDlYM1Ayb1FMOFFNb1llSmpOajhjVDBaSEJzaGRl?=
 =?utf-8?B?V2oycFJCMUxKek9mOHFMMk1BaUY0Qk5uZ3JrTkgvY0RQRlY0MDB4Lzdka3lC?=
 =?utf-8?B?NUJEdEZIcHpGZE1mOW1tMyttUGdwMy91VEh0V08rM2grNlFPRWIvNk9Fdjk5?=
 =?utf-8?B?QXNhTHpWaENUWThaVzBQMEc3bld0eXVlRWN6NERYZTUxU2NwMWlHcmozQVZs?=
 =?utf-8?B?a2Q2d2NFcmppdkMxMklJemoyelZvdThrNElPREtFMFdUTzdCRTB5TnNhcjJq?=
 =?utf-8?B?WUpqblhPWTJWNkVxNS9vUnlmV3ZHcitzOVJoVzk5djZ5VFB4YXJHdHB4N2xE?=
 =?utf-8?B?Z0xLeUZ3UUFNNGFlVWl5MXBjME5xK2lMbHhHRVhtVC9jdFNGK1J0ZUNzWWoy?=
 =?utf-8?B?NmJ3aUY2dHJiUlJsdGZUeXNiUm9uSnF3MVZPemFqK2tsWER6Zmh2QjBEUEZX?=
 =?utf-8?B?bTV6TEY2ZjlOR3pucVVYeEhIRVUzcUtNQk5UM1lqV0ZMZVIyVWxZWnNYNFVE?=
 =?utf-8?B?ZHdQUHlwL2I3UUhjSm5DZmdWMVRkdmc4b0NmNVFEMjRBcTRWSGk5OFUwS0dl?=
 =?utf-8?B?U1JuV1AxdGNEMzNHOGRzbDZGeUtyQ0tFeXJaRUluUk8wRElTTmV5ZWlJd2Fq?=
 =?utf-8?B?WHNHdnVBQjArdW11blloYTdQdmxHVVJSYnBkejg3VGxKWFhNZnRLU3RncDg0?=
 =?utf-8?B?S1RyZHc1aFVSbitiUTBBN3hpTXFFR1pJNWRoQk1qRlBhY1d0WE9OOU93TWpB?=
 =?utf-8?Q?xpIov82sYgX2ojSbA3LQcMJOd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6a1ced-f194-49f6-f90e-08dd81130027
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 20:27:56.5518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTNsRV62hJ1Z8xFTDYNl7Jj7ysJhgjnXfI/emBNULVtfyrRkkj5F+qyyXRdEBzapxgDs+D9l68nYMi/LVGTdzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132



On 4/21/2025 2:32 PM, Paul E. McKenney wrote:
> On Mon, Apr 21, 2025 at 01:53:17PM -0400, Joel Fernandes wrote:
>> On 4/21/2025 1:47 PM, Joel Fernandes wrote:
>>> Currently, the ->gpwrap is not tested (at all per my testing) due to the
>>> requirement of a large delta between a CPU's rdp->gp_seq and its node's
>>> rnp->gpseq.
>>>
>>> This results in no testing of ->gpwrap being set. This patch by default
>>> adds 5 minutes of testing with ->gpwrap forced by lowering the delta
>>> between rdp->gp_seq and rnp->gp_seq to just 8 GPs. All of this is
>>> configurable, including the active time for the setting and a full
>>> testing cycle.
>>>
>>> By default, the first 25 minutes of a test will have the _default_
>>> behavior there is right now (ULONG_MAX / 4) delta. Then for 5 minutes,
>>> we switch to a smaller delta causing 1-2 wraps in 5 minutes. I believe
>>> this is reasonable since we at least add a little bit of testing for
>>> usecases where ->gpwrap is set.
>>>
>>> Tested-by: Paul E. McKenney <paulmck@kernel.org>
>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>> ---
>>> v4->v5
>>>  - Added gpwrap_lag torture param to turn off entire test.
>>>  - replaced references to 'ovf' with 'gpwrap lag'.
>>>
>>> Will move this to my rcu/torture-for-6.16 and update my rcu/for-next branches.
>>>  
>>>  .../admin-guide/kernel-parameters.txt         |  5 ++
>>>  kernel/rcu/rcu.h                              |  4 ++
>>>  kernel/rcu/rcutorture.c                       | 72 ++++++++++++++++++-
>>>  kernel/rcu/tree.c                             | 34 ++++++++-
>>>  kernel/rcu/tree.h                             |  1 +
>>>  5 files changed, 113 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 76e538c77e31..e1d11b6595fd 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -5657,6 +5657,11 @@
>>>  			are zero, rcutorture acts as if is interpreted
>>>  			they are all non-zero.
>>>  
>>> +	rcutorture.gpwrap_lag= [KNL]
>>> +			Enable grace-period wrap lag testing. Setting
>>> +			to false prevents the gpwrap lag test from
>>> +			running.
>>> +
>> FYI, I added docs for the additional params here as well:
> 
> Even better, thank you!
> 
>> +       rcutorture.gpwrap_lag= [KNL]
>> +                       Enable grace-period wrap lag testing. Setting
>> +                       to false prevents the gpwrap lag test from
>> +                       running.
>> +
>> +       rcutorture.gpwrap_lag_gps= [KNL]
>> +                       Set the value for grace-period wrap lag during
>> +                       active lag testing periods. This controls how many
>> +                       grace periods differences we tolerate between
>> +                       rdp and rnp's gp_seq before setting overflow flag.
> 
> I suggest adding the default, as well as the default when no testing
> is taking place.
Will do, thanks.

 - Joel

