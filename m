Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A03D33A9DB;
	Fri, 23 Jan 2026 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168929; cv=fail; b=HVTxfslfoRsvSikPtlKFN5+4oz0e04Ph2+FBVupoWRXcO4guauGyTFeIQ+lLSx4o5q+0pDIaBJ/VlYaCHtZnSksk6IyVU2dlGu9TWidxlZuG1dTr3RgSQ0XEpCDFPMw8WnM1RCJStluytIQCkKMeII0Dhl8dTVgiWQFqVwLHvlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168929; c=relaxed/simple;
	bh=QHohg61XCeFWu8OvxoEagT4TW1OJzbgRVq5/JfprsOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DF9mkOEU0bMqmwCPTrRrwYx35JE7vwZljKSQ3/T6IPrqFHkEgH+F7zyh1PAzC+LAaA+aBLmSrcI/jkNKzQVoYVSUgnfP/YDsLIQgaEud0eBd90YDWz98KseZTmpW7MmseNL3N5xR/GyHprx7KRDwlRT9UQvZNfURsIiFjHcX2W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jhx/M1cZ; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jhx/M1cZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMpfF5iXZr1LF6zogcHvLFXbSL6sNYssTqQqGRz/efzDLunwZAYWJyPiO1bOdSCYzIMrz8ZOzAOkB0alm0aFDH5Zz1lmv0XKrYQriyJJRVk5N4lxbs+XPPUYnt//6P3YCQmEHkWcUcMWc5SarAtQTz/NLNyKlnbwx6QL50HXHNRZjsQms0yyl9ou/iD9xGK98q40jEieGQROdOhjFuDuPM56lhRg01odY9VJ/qnGZBN2dAjQOdu2NgMhJYEfV9LISFG3lDS3u+OE8IY9CbituBjbSz6lSbTnGom33EyMqNbTPNNi3g2KvSAhEQ25vsLMRfvvFH1+sB2fzbjs7YFzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iYHJ3gHO7rvktuHGrq6nd98kmETMWonB2sv+CNUhYo=;
 b=o5V5HPYWKUIoFdEfXvQHT35LmoAaV+JmLGqNHtxL3mzocVfO7NkhVkKrNYEqkxT7qEdmMpnRwNARkMuhQy/qiYjLdfcHoeabwVBlelbdFpYxS9Vvf0mkaq8CQ4h/tV6GeMIIi1byDeST9GCTJVEe+pCgP68zKViJBZrO774/cL3FKh/Ioah5MnzZY6wPasXaMEIN7EOLSfE4ieqtj6t1aKZckGthJ62Gnxfz25/qpfP2PsR8Z2KWYsMucE3knJgRfL6L9e55OwL52Qn0qBLjCUFc2ttsI0lkZ2oEpRloXkL6nrl9Yogdw2fFzB7MUXmhL+J+AIwnqB3vk/GLdS3JZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iYHJ3gHO7rvktuHGrq6nd98kmETMWonB2sv+CNUhYo=;
 b=Jhx/M1cZhLm/KZsGDaVWqeB8Vm1YCUvq6WPqqUaM7+MDEXj06PDnEqU+03fZ9PgcBg+EbEf8FjsPmbM3A5qD86BQcV0rKaJ2OjLC69CtKeMudzf6IC2Zs/PA/fy0S1jTsQ9IYbtA+Mdnzcv/ossvirzsgTYtIlXa0efnKOjwfgXpiGKOdYNB4l9wNmHT6m0X6fPQCyTv2frVMP7bw/1wDJXCaPhkkYpT7H4gi4s4qOXb6AuVpIPqgQRafySx5OlTjPeZnuRLE2WxPN7epr4jpKPYW20XbmrsYrC62BxgaDCvvHfa+Uu3kGXW1ZPLsWmP+dclJc+4o1GAr+arZ1UoYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.12; Fri, 23 Jan 2026 11:48:37 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 11:48:37 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload handling
Date: Thu, 23 Jan 2026 10:30:00 -0500
Message-ID: <1737646200.reply.joelagnelf@nvidia.com>
In-Reply-To: <68fd874e-ac9b-4d91-ab05-903bf45856fa@paulmck-laptop>
References: <EBEF016B-721C-4A54-98E3-4B8BE6AA4C21@nvidia.com>
	<013102c7-a1c8-4f13-8dd9-5803e4d69aaf@nvidia.com>
	<68fd874e-ac9b-4d91-ab05-903bf45856fa@paulmck-laptop>
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: MN2PR01CA0062.prod.exchangelabs.com (2603:10b6:208:23f::31)
 To DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e80d3c-3022-440b-46ed-08de5a755840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHJPdFJiUzJQeGJJbysxYkpSUFRTTWszQTh2Z0pEQ1RpMkFNcjh5bTQzaWdp?=
 =?utf-8?B?amViRnMxcTJoQjk4dy9NOGtaY3pHb0Y2WVdMUzhxakNBekZ1VDBiOUNxdnFo?=
 =?utf-8?B?amFpQ3FRNnNHWURvTFZ1NnBNV0ZRZDNzVFE4cm5BeGF2bEZKZkk2RE43a0xY?=
 =?utf-8?B?K0ZPME0xa1pINjl5ZEp6bklQdGIrcnRxK0J0ODJkbUtQS0x1eE9RSWpRSlRX?=
 =?utf-8?B?c0JibUZJVGZoZ2c4ZE9Ga0Fsak9tYUZCUTE2S3k5QnNJN1RzSUh4V3V4cU8x?=
 =?utf-8?B?azY0VlhFaXVTbENhVElBNHMyVnYyYVYrV0IrYzFJUlY3SGdkYWk0ZnRBMld3?=
 =?utf-8?B?K1RlN0E2czdwWU96VzBRanZscU4yQnU0Z2xodVJhaHF0by8vRkU4YWR4Ulh3?=
 =?utf-8?B?ajlhdW9VTUNzYWc1U3J1MWgrS1NyMFN5d3F3ZlNNU1NSZ3MyU1pZczdjKzFK?=
 =?utf-8?B?NWx1TFZobHUyd2lybW1lakNpaWpNeklOUHMvdUlXM3RHKzJHdnlMa3BFU3NH?=
 =?utf-8?B?Nm52Mk01SWRlVGt2cFUrRE9wNzRiYy9yNEpzWHlvRmQwS3M4QzlDOUl3Y0Fl?=
 =?utf-8?B?bnBwWG9LcjJMK1B0Y1l0L2Y1Z0phcnAxV0JjUi9lb3R2MTZKbVM1V0ozNzdO?=
 =?utf-8?B?MitOUHBodjJKNlNmZTlsL2JGK0xmTmhrKzcybFNPSStQeklCWHJWTjJZcDlS?=
 =?utf-8?B?dXJueFNCYnFZTk1YMHdvZ29vSk1uZXdKWCtwQ1VPVWhNS2NWaXJTOFl3Slc4?=
 =?utf-8?B?b2J6d1lJY0N1ZGNLV0RwZWYwTExwTmQ4WlB0d0k5RElOOStVZ2tKdmpmK0N5?=
 =?utf-8?B?YzlyYkJxb052UFZNVHpYZGg4bi9oMmd1SmpNZDJ4TGtETHRPNXJuek16OGkw?=
 =?utf-8?B?THNKU0ljZ0YvUjdxYzFaaTRqNDM2YU5nVytCWDNTaFFJcmYrSGRuUmJ6WWNw?=
 =?utf-8?B?UE01VjdWTG4wdFE3WHZZc2RGeGgvZHIrRmlGc3hxOUlPdFJ6c2FRL2F2a2dY?=
 =?utf-8?B?RlNBL0VKaFdUc3o3VzB5azVZaHNranRqekRHWG5HN2VyRlFCZWV3amMxUytn?=
 =?utf-8?B?MG0wcjh5ZDByMTdTWC9DRjJYMFczYjIxM1paVDd2VFNiS0NWeDV6cGNNVmw4?=
 =?utf-8?B?dWs2OFl5ZHZPVy9OOEcrUlIzZDlPQ1FaUnpjMzZPdWVwTFdOTFEyNlN1cTl6?=
 =?utf-8?B?QkpyM2Z2ZCtXQkpKQjRXZU92NFFHU0tZYWNWM2NGYjB5cEgzdzMrSkJwN2Fv?=
 =?utf-8?B?SWFLRkxxclFoUG9Hc3FPL2NGa1BDVFFDWlpsV1dSL3BwRWpXenRoRTB5YUJZ?=
 =?utf-8?B?YUZYaThZUVdIcGtBTG56dnMrcWc2U1hWOTE4TGtHNWRmeGI2SjlIZ3Fkekh5?=
 =?utf-8?B?M0RTVkRDSzA4OTA5U0hVd3RxVEdPZnMzYzVkSkF5SmdpTlFqR3lkYTZqUEQ2?=
 =?utf-8?B?NTZVU3BCM3JyNVJ2VTE0U0NiTEIveWVkMFZmQnA0MTByQ2g4ZU5kZjREUDRP?=
 =?utf-8?B?WHRRcjNBQzc1OElZNUdVVS9PM3BDUzhpcll4Kzg0czBBczc1TmVQVmJmS0Zz?=
 =?utf-8?B?NnYvWGtobDVDKzVFdWhIWUV4WlE3em8yei9OdmpvZHVvUnRpRGN5UG51djND?=
 =?utf-8?B?QUkwTTlrdVptVGpDdnJvUXYweWFhSEczRVkzdFF0aDZRU29xM0RXMEZYSGtZ?=
 =?utf-8?B?enhUOGYvVVRtZmNsUXVKd3ZpWGg1U1ZHQ1pzdWVxQmZkcTJIT2tpZFRhemxW?=
 =?utf-8?B?cUpnWm96Z3V3LzVhZk5xYnExMUF6UVp6MVFOUUJQZ0Nvall2V1poN3IycnBQ?=
 =?utf-8?B?clBvZHBoR3h6Y0d2WXVKbUZDRmx2TXo4VkMyUno4bHBBUnNmQVBCOGJ1RXBw?=
 =?utf-8?B?NWNvK3p2d0lIS3F1VEpWUzFFWkV4ZHhPNHBvMGRKT3lKRk0vcjQ5Y21weVBK?=
 =?utf-8?B?VnZDVzRlRGxhNWFUVlNvRnNpQnpnNWxqTWxHTEJRMUxKRGlJUTFObUYwdFBn?=
 =?utf-8?B?ZEJxbndkcVA4Y2FpcFNWMzZ2MDVyK1BNUTZOS1pWMDdiU0EyWVdkd0NtVDl6?=
 =?utf-8?B?TzdiNDJXZ1F4UzJMY0Jia010VURGS1M3alFwY1JyOUVUQ244YkZ3ME9ieWJM?=
 =?utf-8?Q?haKw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWhOUmhud3JOa2k5T1k4dW5qL0JJT3RUUmhuQW5kb0swVEhCMjFiM2FxQ0py?=
 =?utf-8?B?MnE2eFVqV3JLa282dTZkUkFNTmhQYWlwMmlrSWMyYkRZZHZTYytlZXBVUlNI?=
 =?utf-8?B?ZVRxTTd5c1p1Rk9EV095VzRWUW5oMVU1MytLbXRZeWhGTG1IUGhuU29qbTFU?=
 =?utf-8?B?bmM3N3NLV3RRSURYWWVpT3NVQ05ubVg4Q2xJNmVHRlhrcmtSdDMzVlk5RWxr?=
 =?utf-8?B?ZVdaNmJDVmcvdHJrSC9OUVd6WlFCSkFhVS9ySzd4VFB5cWZpSC80SkJhRWl1?=
 =?utf-8?B?WkJiQnNyamtyQ2FjM2N1ZDRJV3RLZEpPS1JIYzA0bkZ5SDJGRzJibzl2SW5u?=
 =?utf-8?B?SjJaQUR0eWRWV25zOEhZcnFrenBNMC9XcXNKTDBhYWNkb1c3N241L3JkZlp1?=
 =?utf-8?B?RUxDMnpCeWxHb3hrQlNuT3VOS2FQVFZ2SWpVV1Aydk45Uk42Z3lWd1RQTzVE?=
 =?utf-8?B?UW5DbDd1T0E1czAyTk55bzR5WXJ1N2FISUZDYis2cTRMRnlrWHYrQVd6cU1B?=
 =?utf-8?B?aURhSXZBaVRpUTVSUmc1eVZWZ0JTV1FUcnpzMjJMRFV5UFFmQko4QllNa1Vu?=
 =?utf-8?B?Ynd0V1pZVVNQM3AvYlpFMVJ2Snk4ZTJmbGpCdm94MUY0NlBqWk1XWHF4ZlEy?=
 =?utf-8?B?RWhnWDhzSWFoTVJyYzN0aEdyeTJaMmd4c0FveEx5NGxEOEY4R0hSSWQ1UlZ4?=
 =?utf-8?B?cTdVL0pXQnBvR2xaeXJ2cFJHUlRsYlpGODAwYVY5VWUrbmgyQWdGOTVDN2g4?=
 =?utf-8?B?aUJjMXZHN2xVbkpjSUN3d2tSbEJFb1hQYjNSU1BQcEpxcUJVR2pSRFVENTBp?=
 =?utf-8?B?aU80aXUxZUd2TEpkMCtiMmNTU28yc1ZTeERlMndISHdBU0VLS3BjeFhabGxQ?=
 =?utf-8?B?UENLRHhPKyt6Y1RmaFlCcU5iRzBuamEvRWlVV0dyVStHeVpiMGtzVVBiN3NG?=
 =?utf-8?B?OFBrNGNvREl6bnB4OHFFenRjTlhDTFZBSmlsV3hCR3lwdVNwRTUrbmNvWmdQ?=
 =?utf-8?B?ZDJYNWFjQWZ3WU13S24rRGxEMU9aMTQvU0hmT3BoSThCb2g5emhBWHMwenJE?=
 =?utf-8?B?YVRhQlZWVjRPbS9EZHhzaXhZRmhsMjNqUjhOT21MR3B4aEp4RDFzNlp0eVor?=
 =?utf-8?B?eWxGMDdCeVp2Q21McWVRWnhJeUVickF4U0draGk3TkNGZlZQcTRNYWxkUVhZ?=
 =?utf-8?B?TVF6ZU9HWVRXK2xvQnY2aFdDZ0JSRmlKa0h4UzFxcVV1NzNESy83QUkwU3h6?=
 =?utf-8?B?Y1lON1RDcUJpRTZMMjJqc2JCaXNNNzdjdVdJUGNpaHFjR0xoV01rU29DaFV1?=
 =?utf-8?B?TnRubEdYZXpGZnArdE1ib0JvWXc2Z0UvVzdxUGFlTUdGTGxjbFdLTzcwc1dr?=
 =?utf-8?B?M0VZNnU0VmRhd201eXpieWtYNWN3bUIwM0JNOFFDQnRPKzFKYWYrVlk1NVBW?=
 =?utf-8?B?WG9Xd293OE5rUVltUGp3T1g0S2VwQjZja3pkd2lzMVZqYVpSN2lidm92cFBI?=
 =?utf-8?B?VHNoeXk2WU4vdDU1c2d3TE0xTXZiTTU3REUyaFhKMk1HbU1aSWJaVkUvYXJN?=
 =?utf-8?B?Ym1ZaG5SRldVeFpVVjd5aklLQ1ZPTm9MaGJyaDhrQW9mSy9tTTBMWk4xUHFl?=
 =?utf-8?B?cm5zNWczeGsybWlFdjRTcTk3L05OWU81SEY3NTZlN0kxVzFidU5xWC9jRlVH?=
 =?utf-8?B?S1FCQUhTRG9jTWhMTnlFSUtmZ2N2NW0xV2F1VmRKTlV6R05HcmIrSjhHb3Iv?=
 =?utf-8?B?OWdkZGVtaGZpekQ0dC83WmpTZGxlKzhac0NNQU5XeHhLVXhLT1JZRXUwV3I3?=
 =?utf-8?B?Ujd6RmcyRi9nWjdOVnQ0QXU0Z0VkdUxnZmhiWDYvVFlQMWh1bWNlalNNald2?=
 =?utf-8?B?UllXSnUzb0JLK0p6ekdNYks0a0htR21XZURnN3Z1Uk0wT28ydzNkbmRyWmVk?=
 =?utf-8?B?L3RFVlRVanBoMGZHVHh4NkV1WUxadmJoSEo2T1Q4RzA4OHg4aDRpZkdVd3Mw?=
 =?utf-8?B?ZTZIaUEwWGFFeWMxdVErZnJOTzk1VG1UK2VUQWFSaERnRWxpZmxoK3BXS1N0?=
 =?utf-8?B?K3UwN0dMeGJNckVQTWUycEhrajIrL09GUUNhalFCcWxrV3BCL2JiN2EzZkQr?=
 =?utf-8?B?SUlYV3V0bVhqMHF5N2ZkQm1nZXRVcFltRTd5ZkNaazBjOWtkWkUxSnltVU1V?=
 =?utf-8?B?anNXbUhaYk5ncHc2ajluN203UlZHY0tzcUo2aWN5UXFDS3g3ZVp1K1RMT2FM?=
 =?utf-8?B?S1RjS3ZGYi9wYUFkeDRyT0JrM2ZCTWJ2ZWl6eEg0MXZUOFcyU1JNbUYxNG1u?=
 =?utf-8?B?eHRPTjhncHErYVgxMVR6USsrdVk2V3RQdVo5WVdkWnZ1RUVGNkZvUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e80d3c-3022-440b-46ed-08de5a755840
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 11:48:37.3945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmvzHIeJeN4Oo+haoDp+OtAom6KdRxHf3oarzt3arRsxlRpQuLdcSK6Rg9vS0vGzTK7rOR45saTERu7bTM8thA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486

On Thu, Jan 22, 2026 at 09:46:58PM -0800, Paul E. McKenney wrote:
> > Thanks. I will focus on this argument, then. I will resend with a better
> > patch description in the morning.
> 
> And my Reviewed-by does assume that change, so go ahead and send the
> improved commit log with my Reviewed-by appended.

Sure, will do.

> > Hmm true. There is also the case that any of the kthreads in the way of the
> > callback getting preempted by the hypervisor could also be problematic, to
> > your point of requiring a more principled approach. I guess we did not want
> > the reader side vCPU preemption workarounds either for similar reason.
> 
> Well, principles only get you so far.  We need both the principles and the
> pragmatism to know when to depart from those principles when warranted.

Agreed. Indeed we have to balance the cost of workarounds and in the case
of per cpu blocked lists, I agree that perhaps the balance tipped more in
favor of not doing it pending other more comprehensive fixes.

> > One trick I found irrespective of virtualization, is, rcu_nocb_poll can
> > result in grace periods completing faster. I think this could help overload
> > situations by retiring callbacks sooner than later. I can experiment with
> > this idea in future. Was considering a dynamic trigger to enable polling
> > mode in overload. I guess there is one way to find out how well this will
> > work, but initial testing does look promising. :-D.
> 
> Careful of the effect on power consumption, especially for the world of
> battery-powered embedded systems!  ;-)

Thanks, yes I was considering this argument already to be honest as one of
the potential pitfalls, but thanks for the reminder! FWIW, my inclination
is that if we are in an overloaded situation, we would not benefit from
idleness anyway. To the contrary, I think we may hurt idleness and power
if we are not able to settle the system into a quiet state due to slowness
in alleviating the callback overload. I will profile for CPU consumption
and maybe run turbostat to check whenever I have the prototype.

-- 
Joel Fernandes
