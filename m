Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810121E9B2B;
	Thu, 10 Apr 2025 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292937; cv=fail; b=oImwVJHEWAY5tS17OUpIJ7CuDGpba9R8s98qKj1vya/UTAUv2Qc4lywQhMBfp58sMdPPBSb9sFrDxfdYe8RyYwFBHayKwq8wKNHJKpN/9DvbqOOj5F2Zr0pYDP4Qj1Vu6DNGSajOub2meX5I93ff6s3B4a7O8o8CVP9ZiNMyKHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292937; c=relaxed/simple;
	bh=RO+xIZnx+zqKTHbkyZH1QgkeqcUir7JF7XKDhDB1Ii4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BX0Ovt54ETQlW9XGCOLRAksDqTIBxldsD5HW0GEHbMn/V0/ag6+BHAdJC6lioCgjx0Vs22Rit2Em2VuzMX6gXcke3yTg6zMRyOdOkGSOwN+Bc3MouR7f4hphTLwYEr858sGQyFYiu0pfMYTKtE86rpEsbcxrSCR/6O62/t8KsVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ro85Jiee; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ro85Jiee"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BREfhGKZGmbdnmj2L6Sg/HBz57sVQ+woM3TU1RJZHrSJEfKwC7BFdlZSyw4RPO1pAwl7XfGStiTOkO4wD3hMiT0oV9WV72+eL4NuKOg22vhcCpSr+AG9q9tFhLOB9uU8qzKFlo6dl8D+SeRZrl9IObv+EiBM6cXUJveiADyf5BvycwYfWxSnvdobutx/cjtxToY2sXb9Aomr3ct0tOxIf+i5X2/TlsyEh/CBFAIoOkceDfJww3jW0bRwJFDKhZcH0+z6d75666Cwn8kN86ChWR6htiXtMd7aXWbylHRVGNNQjDAaYck3l7aSMZ+P5QuE5tf4+/UnJiW0XgHXr/a1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEbkpVdUFnvETZZMu4Mfi13kGM0ak9a6fU315xM5Zpk=;
 b=ACknW8zTVBWSaN6eVEspxGzO6xHEmVU1eulHmD86WodFSKv0hq1828nBI9V/bpfqsaNkVkN4+ivaVx1fp5gEEUXuRzOX4bjp/55uF2S3MJ8slJrqDeDScql3NfAGdqS5f7ibLlvBzNmmkl2Q2OCAsip0IWG2hgOXGawFBxsiGqlcIMI/6dkeIcEMhrZkextd+z6c7BG/Lzpwp3ZhoYP7oYgTT/KWhSNzziSWojTEx23ZA86YSr/ndglHEYQqKG5ORXDmFEWTcHzFqSBfy+ekM/7kGRj0zNrT0kIBAjuTQWPoII9S3HHyEOzMsuj7RrTpIpJ1zYqRBu4dQNauTdsajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEbkpVdUFnvETZZMu4Mfi13kGM0ak9a6fU315xM5Zpk=;
 b=Ro85Jiee5WKiPZ8tizqqhQu+Fvy9DUQkx+40dYj2PVJra82qtc9HH9+wxAF7hRrFQ2RLbxt190IuWh94D+ilQ9zhNK+w+nPcvFQrOmoDNPdzOo6IxjO72kE3RMocOXia6SFNl+zD3G+bo8zHDp0MXItYd/hfH1QiMBjwXxH6nfWlRUOYO+YoKA9loWaOdroSGqYQhNQa9JiCBUuif8Fr9jGRGy8RdAxhDlZU6LhfSOnDrbeJHI4x8nWaN11CTnClpjwdFfUCUPJyJsxv8MRG0YA//z5ljwmSnXjV4ZJhvIRwkTvdhXczlo51OHx3RevgjrIZdygMe0U/bPn+r5KERw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA0PPF8CAB220A1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 13:48:52 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 13:48:52 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, rcu <rcu@vger.kernel.org>
Subject: Re: rcutorture: Perform more frequent testing of ->gpwrap
Date: Thu, 10 Apr 2025 13:48:50 -0000
Message-ID: <174429293068.108.9256249525421383845@patchwork.local>
In-Reply-To: <93682939-6e82-43e7-8681-cc84539d9bc0@paulmck-laptop>
References: <93682939-6e82-43e7-8681-cc84539d9bc0@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BN9PR03CA0625.namprd03.prod.outlook.com
 (2603:10b6:408:106::30) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA0PPF8CAB220A1:EE_
X-MS-Office365-Filtering-Correlation-Id: c843a088-e225-4256-a192-08dd78366ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2UwTTEzanh2UW5TSHRmTktlSlgwOTlud0dTQitQL1BRc0ppMmpMbmx3ZUJ3?=
 =?utf-8?B?SzhCRFRBMENnL3ByeG1CeTNmdFBCNWR6OEcwTGhnTm81SXdxa01UNzIwblZt?=
 =?utf-8?B?UEtoQjRTT0h0MEVJOCt3VWxNNzNoKzl0UGI1QTRyV2tEdUVIT2ZvRnNZSS8y?=
 =?utf-8?B?RFo1Q243bjRPcTg5c3pFUTJhbUp4WjQxQThZRm82WjNYT04wZHdHUm16REdR?=
 =?utf-8?B?VGkrTENhNHhubHVWL3BlaGtkMC9OZ2RvNlUxb3hYcjZqK1ViSFZNQXdvZXFN?=
 =?utf-8?B?d0x3cmt5M3JWckFyQzJ1blViemZFcEJLOWVHWkhWTWVoYzN0QU83NHZmazk2?=
 =?utf-8?B?a1JTbG50WWdyaUcxa1dlM3BCd1krazZSekk1UTRFMVJLeVpucE1OZ21jL2k1?=
 =?utf-8?B?WHI1ajBYMDBQbTBFWnB5cHA4R0ZNSGJaSDN0bWFnR2VIRUVYTytDc3lQSVZD?=
 =?utf-8?B?RzRRMGVTazRDQnVlMEhjS3ZDSndYeG92cDdoSXJoSW0yMW5hUmFEaFlCZGRW?=
 =?utf-8?B?cUpLVCt0Mkl5ZjkxWGVSamdFdDQyVXFJUDdnRWJnejlHOUZzb2NUTy92TFIz?=
 =?utf-8?B?RU9KdWhlMGt1MzJxM2ZkTjhhV05ML0srV2l1OFhEVzRDRGtFQ2syQjN4RDhp?=
 =?utf-8?B?UEkrc1g0K1VobFp2bnlLNVNiKzg3RjZ6NlBzMjhkdG5XZnNqcXRvZHNKOTRh?=
 =?utf-8?B?Vzd0MVpZZHAxclMySjM4TElVL2VUeFVtcnA5Z0NzN2NrRERVVlFJVmRtNkI1?=
 =?utf-8?B?K0l4azdFeGY4c0Q0WXlUTUZhYlJKYys2OTdHSk5hQ3cvazhxVkFyQ05UUEov?=
 =?utf-8?B?RjgzSFkzWm5Wb1JnVHRGaTJ3aG1PMWdMbWFYTTg3VnNSdHBYTXFaZS9LQzhJ?=
 =?utf-8?B?ZTdHeGhUN0dja1N5Y1B0SC9xTWhnTlIrbFFTWHQwRW5OcWU2dUpQTCttQ1dM?=
 =?utf-8?B?ZGRrYmdtZ2xWZmRqMnVTRytkTHdkN1J1bGYwMXM0b0pnNG1rdWlTL2gwOUJX?=
 =?utf-8?B?TjJ5QmF4clhGNEs1WXN4KzdPUlF2alVIRStwSURFWkpCN042b0VIaTRUUnVT?=
 =?utf-8?B?TE44bmphS1pJeDdOWmJrbHBkcTBIM05rMGM5bnhYUm9iS3FjY3FMbXdXVFBk?=
 =?utf-8?B?YXhGcW5zWm1vajVpRWRJQnBSSEc0L1NBQzZQL0xjWmsxc2tEOWIwZmF3M2xZ?=
 =?utf-8?B?WGVweTN3OUZsN1NRSG5PWEhkQ2dCQmg1L2dsTUlaalhPWHhRQXk3V0gwRzN5?=
 =?utf-8?B?UHpqTm91UW11UHgweEVlSmI3R2lhWUY4K3JNMXdCTTdWV0tIRUR4SHVWV0xs?=
 =?utf-8?B?R0VVUVdZaU9zcGg0bGYwM3pRL3FQZmx0QkVUMFJFN2tsOWFLYTBRTC85cEtp?=
 =?utf-8?B?Y3lDVVNkNHRyNEJTekpNTHVHd3U2NWlZeHFsQ0J6M3luK2pzaEZvV2NSQ042?=
 =?utf-8?B?YWU3aWZVREZxRDd3elo2cDgxaEROb3c4ZjVteHMveE5pK1kraW42WlZha0tt?=
 =?utf-8?B?ZFZtVGZVb2xPaWNQQ0ovRGhXYlBIVFdjY3QrMlB4aGtJQ0pZR05zYjBwY1ZP?=
 =?utf-8?B?SjdIcC9Yc2hDMGVJejNyWVgwbjFTU3grWFUrdS9TQmhTOXVjOUlJTGNwdDlM?=
 =?utf-8?B?MjFXbGZqOWc0L1F6UjdhN3dncHcxd1B2c1N6dnVjY3Q5ZE91MzdZNnE0OFBr?=
 =?utf-8?B?ZzBITG1sUFBUbm5OTzF5NUE1WUFrTXVyZUxvQktTWC82QWNRRGxVTDlEQnJE?=
 =?utf-8?B?WWJ4Mmg3eVNzSkNIc2ZzeWk0WG9qdjdNYkx2RGFGdVNNTFVEaXdIVHVLRTh4?=
 =?utf-8?B?ZnpqTENJREUyOEwvRE1LTEdKN1V0Mm0vN0tqTlpCNktlQmM3blEzZVFZelI5?=
 =?utf-8?B?dm56VXFyclNmMkpXVWI4c2NyQVNJang1blY0Z29FcC9kMWozczdMQm5jeHVV?=
 =?utf-8?Q?7NK4HCxAIw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STIwcUFJRWhqTHpGWUNNaDBoMTlWaTRpTzZuYkZ2OUxqSnR3dGRpUng3NGZp?=
 =?utf-8?B?VE9OVXpIY0QzWW1iNk40dno5ejBJeE52T04rRW1oUnArUm5NM25qNmU4Y21t?=
 =?utf-8?B?M25TempZR3F5SWpTaHYrRGFUaVQ4ajR3MUp1SHo4WFBhMFdSVS85QnUyV2Nk?=
 =?utf-8?B?WFhFSkNRc1J0WVVISlBxMkh3bTNtTVdYRUhBNW1pS21ZQmc1SSsyQTA5aDA0?=
 =?utf-8?B?Vk83dnpYZE9WTlYrZ3N5aXh2WGU1cUM4MFZ6Sm9pN0JSTGIrcmRVYkdqbURB?=
 =?utf-8?B?eUJ3L3U3RkVqTXEybFVWY21ndkhNVXE2dmJFaEtqSHRRTjVJc2lFYnZ4UExZ?=
 =?utf-8?B?bmVGcU9jWUw3OFh4UGtKNUdxYWsrblJUd3hnVUxvbWE5ZllvUXM2dVZUVXB0?=
 =?utf-8?B?R3drWUZ2WGZZTTZmQ2RFdUljZ29DbDA5UEd0bEw4TENwM1VaT29KYUtzQTJj?=
 =?utf-8?B?NmpjWXR3bmphM3Q5NkhkZ0N5TXVwMVJTWHVKUllsMXo4bXhsRDJtY0xVV1lE?=
 =?utf-8?B?N0VJZGswcktQWHVnNnBzMlg2WlB5Z0ZuZWtNcm9tNEtHdXE2SW1XQmNwSmtJ?=
 =?utf-8?B?SEpQYXJvRkU5TkhPZk0zRkdBQmZra0FzS0ZJcmxkVEE4S1VVd0Job2FMYnFE?=
 =?utf-8?B?YVJGQmVvZUowTzB4NVZJRzNDazZqTkRKR2NLZjA5UXZXMGZjek4xeU4wejNi?=
 =?utf-8?B?dXV0enUyalN1SUU5Y3FsNXBhc3BHdHBhTS9WbmdsNlRwZXl2U093c1dHcWpu?=
 =?utf-8?B?SHNHRkFUQWI2K25BSk5PUUlZZ3hkWEhMcGE4Unl6TzBLbUlXZWlqWGlUZUpi?=
 =?utf-8?B?bzdxMTBiNVdZdjdtTjRVc2IwOXl5bjQ1Q0p3NmFjTVBPbHpWUjdUcU1SZ09N?=
 =?utf-8?B?NzJtTnBjMHgybEhubFRSVWwwQVFBRXZVdnIvdVI1L0dmeldZd291dnZ0eE9V?=
 =?utf-8?B?dG5ySGErSFR6ZHZlay96WUMrSUdYMzdaenZPNUc5K1dhREVsSG1SQnVNaEpD?=
 =?utf-8?B?OVR4c2RYKzRIeDFJVmUxV3F6NTBDZjI1WmxySWlKVFZCRkI4V0NmSjdpcnEv?=
 =?utf-8?B?WlJJYlJCM3lwaWRFajEvbEcvc1NWUU51ZnBubDZ1bUVCejVFV0c1REdFSC9V?=
 =?utf-8?B?UUx6QytrV0tkRTBhYmFVcmYwSnU1aDVYa3JoMEZuY1JzN1hwMEpWaUZmaC9n?=
 =?utf-8?B?LzVjMzhJSThkQWZsbUlIbldJNUNLQ3MybXN2Z3plSi9xR3pCLzJPRXpGZ083?=
 =?utf-8?B?NlpJMU1aVUVCWlo5L0hyZThJclZrUThuTHJHbEFsY20ySFdDaGdTK2RsbDdN?=
 =?utf-8?B?M3RXSTkrTTFzbHdFYTN6TmVDL0h2SS9EVTF4Sm5Ddk9GMWtKa0p4Q1UxalZo?=
 =?utf-8?B?QXBwVWtacCsyVzNsdVNYNjFjMWV3ampyQkk5MFhlY2tjam9DaTdEaXYzWGlO?=
 =?utf-8?B?cERQVXlrSWxkeEx0bGdyZTAxZ0hSYlNQZWhVc2c0bENSWlB0MEN6MmlIbzNh?=
 =?utf-8?B?alZ0T3NFaGtPOWZ4bTVvOEI2VWxGbUR1ZFcwYUFGd2RpUFE5MExsdGUzVXJJ?=
 =?utf-8?B?Sm94ZStHYXcvVG5UbitmUExkREoxNmg1ZXpDNFFxbzh1Rm1vU0dKbWhHcE9p?=
 =?utf-8?B?NGFLbU1hd2RLLytxU0s4OEY3dW5vNkdxMzg4eFNEWkJOSTZKSUh2TkdEbko5?=
 =?utf-8?B?Y2pDREVyNEN6U0Q5NTlOd0VoNFc1OFN2aFNSemNmM3BZNjJWbHZsMmR2ODNC?=
 =?utf-8?B?c1RnU04xQ1pQYU9FazJ0cDFkRlJJZ1p1b0tKRU95b3g2UnpMaGVVaGhaMTV3?=
 =?utf-8?B?ejhCRGZjNkFoZkIrUDZ2WHNqdmF0cnMwR0FZQUQvWGxITVJBVU9oT0t1OW1W?=
 =?utf-8?B?eW55UE9lRmtHdGt0NFNiS1IvNS84NkJBY0E3OG5Ma1N4TUZ6VUN5dkVDSkZZ?=
 =?utf-8?B?d09GYVgwN21ibThZeGNOYk5ESmN2RGNXdVhwN1R1SGRQZmc4Ynh0N3BKVmJT?=
 =?utf-8?B?aXVjWVNiL0UwMVhoTktQSG5EbDBNSkt5bUs5Y1pKTjY5SjVKTGd5c0JDNEtt?=
 =?utf-8?B?N05Qbjl2R0J2R2E1dDVEVDR3WGIxR3BwQVVTcEdrNkR0NWYwVGx1MjdxRUlx?=
 =?utf-8?B?OXdQVXNzTC9tYU9wQ0UycFF6R1hNT3pSMEk1M2hDMjFEVWxYejk1QlYwekpP?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c843a088-e225-4256-a192-08dd78366ddd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 13:48:52.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFyGwEYkrdEnQF2JmYD0w8Z/vP2IsYtR8vChuqPH3Xz0pA0uScYo8P32ALD5QdIK8qGStovTvjWq/ctKb4Tphw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8CAB220A1

Hello, Paul,

On Thu, 10 Apr 2025 13:35:35 GMT, "Paul E. McKenney" wrote:
[...]
> > > >  kernel/rcu/rcu.h        |  4 +++
> > > >  kernel/rcu/rcutorture.c | 64 ++++++++++++++++++++++++++++++++++++++++
> > > >  kernel/rcu/tree.c       | 34 ++++++++++++++++++++--
> > > >  kernel/rcu/tree.h       |  1 +
> > > >  4 files changed, 101 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > index eed2951a4962..9a15e9701e02 100644
> > > > --- a/kernel/rcu/rcu.h
> > > > +++ b/kernel/rcu/rcu.h
> > > > @@ -572,6 +572,8 @@ void do_trace_rcu_torture_read(const char *rcutort
> > > >  			       unsigned long c_old,
> > > >  			       unsigned long c);
> > > >  void rcu_gp_set_torture_wait(int duration);
> > > > +void rcu_set_torture_ovf_lag(unsigned long lag);
> > > > +int rcu_get_gpwrap_count(int cpu);
> > > >  #else
> > > >  static inline void rcutorture_get_gp_data(int *flags, unsigned long *
> > > >  {
> > > > @@ -589,6 +591,8 @@ void do_trace_rcu_torture_read(const char *rcutort
> > > >  	do { } while (0)
> > > >  #endif
> > > >  static inline void rcu_gp_set_torture_wait(int duration) { }
> > > > +static inline void rcu_set_torture_ovf_lag(unsigned long lag) { }
> > > > +static inline int rcu_get_gpwrap_count(int cpu) { return 0; }
> > > 
> > > Very good, you did remember CONFIG_SMP=n.  And yes, I did try it.  ;-)
> > > 
> > > But shouldn't these be function pointers in rcu_torture_ops?  That way if
> > > some other flavor of RCU starts doing wrap protection for its grace-period
> > > sequence numbers, this testing can apply directly to that flavor as well.
> > 
> > These are here because 'rdp' is not accessible AFAIK from rcutorture.c.
> > I could add wrappers to these and include them as pointers the a struct as well.
> > But I think these will still stay to access rdp.
> 
> Why not just pass in the CPU number and let the pointed-to function find
> the rdp?

Great, I did this and it looks good now, will post v2 shortly.

> > > I could argue with the defaults, but I run long tests often enough that
> > > I am not worried about coverage.  As long as we remember to either run
> > > long tests or specify appropriate rcutorture.ovf_cycle_mins when messing
> > > with ->gpwrap code.
> > > 
> > > >  torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads,
> > > >  torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb st
> ate (ms)");
> > > >  torture_param(int, preempt_duration, 0, "Preemption duration (ms), ze
> > > > @@ -2629,6 +2632,7 @@ rcu_torture_stats_print(void)
> > > >  	int i;
> > > >  	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> > > >  	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> > > > +	long n_gpwraps = 0;
> > > >  	struct rcu_torture *rtcp;
> > > >  	static unsigned long rtcv_snap = ULONG_MAX;
> > > >  	static bool splatted;
> > > > @@ -2639,6 +2643,7 @@ rcu_torture_stats_print(void)
> > > >  			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
> > > >  			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
> > > >  		}
> > > > +		n_gpwraps += rcu_get_gpwrap_count(cpu);
> > > >  	}
> > > >  	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
> > > >  		if (pipesummary[i] != 0)
> > > > @@ -2672,6 +2677,7 @@ rcu_torture_stats_print(void)
> > > >  	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
> > > >  	pr_cont("nocb-toggles: %ld:%ld\n",
> > > 
> > > The "\n" on the above line needs to be deleted.
> > 
> > Ok.

Done.

> > 
> > > >  		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deofflo
> > > > +	pr_cont("gpwraps: %ld\n", n_gpwraps);
> > > >  
> > > >  	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
> > > >  	if (atomic_read(&n_rcu_torture_mberror) ||
> > > > @@ -3842,6 +3848,58 @@ static int rcu_torture_preempt(void *unused)
> > > >  
> > > >  static enum cpuhp_state rcutor_hp;
> > > >  
> > > > +static struct hrtimer ovf_lag_timer;
> > > > +static bool ovf_lag_active;
> > > 
> > > Same "ovf" naming complaint as before.
> > 
> > Ok.

Done.

> > 
> > > > +}
> > > > +
> > > > +static int rcu_torture_ovf_lag_init(void)
> > > > +{
> > > > +	if (ovf_cycle_mins <= 0 || ovf_active_mins <= 0) {
> > > > +		pr_alert("rcu-torture: lag timing parameters must be positive\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > 
> > > Why not refuse to start this portion of the test when CONFIG_SMP =n
> > > or something other than vanilla RCU?  No need to fail the test, just
> > > print something saying that this testing won't be happening.
> > 
> > Got it, will do.
> 
> Again, thank you!

I changed this to, something like:

	if (cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
		goto unwind;

So it will only test RCU flavor.

However, to your point - for TINY, we would still start the timer which will be
a NOOP.  But considering it is 5 minutes every 30 minutes, maybe that's Ok? ;-)
We could also have a ops pointer ->can_test_gpwrap_lag() which returns FALSE
for Tiny, but then it is adding more ops pointers.

thanks,

 - Joel
