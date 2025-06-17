Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62440F9C0;
	Tue, 17 Jun 2025 02:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750127117; cv=fail; b=IxItP/cYgKbIl6rxUXDvwOUIgOC/41/NgkA3pNd9fpChMqlDqGFXIOgzU/lL3uXoHMWnAN7htsl95btAgUYRydmUERpUl4ghWJdKi0giVhY9aWSfudk3JMDqegFOLHPlRvKeWs7mJk0Fi7C4Gt2dW8vdZdVJza/HfhzP4ffZlpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750127117; c=relaxed/simple;
	bh=3/74kqIexVEGkgq7EQOU0Wi10fSzP4wHE7BOZUHwX7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMFSDQdheNDRgQA/F1TsqXN9jhLHmMtOFDcHSFJL7ML4HrcdzccGaZRjmbJkmKVKS3aTNQ+kfysaRJi3evBdJpEtV5+hRud65QShuXVfnWE8BktAUZEw7D9+3jaEO8ouSx8xhz+4a4Gy/Kx+BnqKFrdnT2xEfmcuf5MOjExMS4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=osZhZ9cf; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="osZhZ9cf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbnG651f1VIz4sebH3ChtGF+5CUOGkoI01pb9FI6CQs/73HCkRdzWYS2wFbabXBANCsi3MMXCegm65SbN8gZAWDOEIn08UhMliYvuWOlrAaNVLwTaIQwYxKjqGVV7LQ9PpmPGoxHFWHMwClayYwusOhwSG+jpWG8kbmui54jfRc/+1h92DkLXja8MCZZQpATbQyQcl/xnxValRIer3+dh0LtATwwUmSW635gSPn1yvdX8wOgivX7+RcLINAmk6oqNkthu4gu7GB0vOeQAh5IjntRhBRepUEaE8Ajmzg1oNP9yi64dt0M8Qqo4gtpW/Hq1QiQm8/4ctBBngbH5k741Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4yVvSdjMZMeoZ1jjDZuGjaHvkC0qNnVbDQ7pRzYTsA=;
 b=iBXAwzH7xYVX99n0P++ehYlKqEr6CykLuap+9v+a8tuV1ILeSKEknkABSFA/nG367k/RvtrPRSPCSIVNhAEGWjWYFGZraPGmv/gbET3O+FP6/he9QwPLPQXGt5MQN9wCksgxq6U9ZIWs8npewYM0Pv/LJyXNZZVPnvNOhufNuKc1OjjkcZQ6MbCZ4ZTZJjWgCkZTIJMa4GyL3X492F/OaGJe8XupVxaTLZ69/zIwBUu/LKUwKdwUDN/GZjIbMbCoS4EgX/fPkF0zQ0wqAbd0qOeJoto0PW0iQ5uNUOsVjnbUvjxTuO9dQuYgwZAQFLNt2bP7932WFg8qYM5FruRklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4yVvSdjMZMeoZ1jjDZuGjaHvkC0qNnVbDQ7pRzYTsA=;
 b=osZhZ9cf2ACtfpGXKxSxu2Ia6+vfQgGOVOC5/8ieYEExz6PVEAmo54hkQUw6m0OzHF2SbPxFqRYlRiX29kcCHIbSG4OqctozMJLkLeL0KTR4+Q5otl0WxD6FJxAhmlXIC4rUsMCMvngPgNsfCJTUW42aPjnadm1hIThUUu/XuCbkulrXIXLe9YSpGhSw9bcN9+7uwjGZvRO8mrqbIMolPA+jXdzcs1KcEqdw8G/KxoaWSsZwop9+YORTbEV8dS5Fz+HKJoRVHPNegIudXocNjDx4dgeRJ5zb1AoqfiN9bT6JyVil5Twcbsfqca5m17pPPiYe2c3VFk5zknVYa5HMWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 17 Jun
 2025 02:25:13 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 02:25:13 +0000
Message-ID: <e1e70709-b799-4da1-9f0f-9d222b315db4@nvidia.com>
Date: Mon, 16 Jun 2025 22:25:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rcu: Return early if callback is not specified
To: Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun@fixme.name>, "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20250610173450.107293-1-urezki@gmail.com>
 <4bc63cf3-29a4-4a64-be65-30f7bd55e31c@nvidia.com>
 <0caf7054-140e-4b6c-abd4-2ec2ebe79b2c@app.fastmail.com>
 <aEsSZINUrRvy1g4F@pc636> <aEtAtLu6IIv_0QHs@tardis.local>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aEtAtLu6IIv_0QHs@tardis.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:408:fd::10) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a1450e-123c-4955-bd32-08ddad4630ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3VOajdrRWd3WHIxbmNxUXZqSUJhaE5YWmlFTjg3L2JrMW8yM20rTkNjaTNZ?=
 =?utf-8?B?ZEJNYkpOM0owSmh6cU1uaVFFQmM1QzE4VFpNdGhlSGVUbjNURUFKa2tlK3BP?=
 =?utf-8?B?MVZxbHlzdnhIbDE3WDd1dmdCRFNrd3hzWWFIVGh3djMrZTdUSldWaWdRUG5X?=
 =?utf-8?B?d2UxVjlGSjVqN1Znc2RyblZSMXl4T0l3eloyYXVFemt5WERkY2t0SUFYRmk0?=
 =?utf-8?B?LzRZWGp3TTRUUGZSdjBkSDlxQ0dpd1dvb05heXJEL1RxVlYxa3FjT3hSbFkx?=
 =?utf-8?B?TGRYVFFyZXFkM0hIaUlUMUVkK3V6MXZRVHlKeEZyVndOMjZmVUlwUjQwMjhq?=
 =?utf-8?B?bFoxTUp2ZTJKUm5zZGxweTBKTFFMRjhSUTRRdk1DQTVGOG9tNXVKRW5GTE0v?=
 =?utf-8?B?RUhiQkZFM20wVnZ1ZzBRVitDN1NUOFEyRHJxaStnUUcrNURGRitGYkQ0dy9J?=
 =?utf-8?B?YTRWdkpTdiswa1ZwRGNXWWNwWkozaUlmZi9TWGorLzdKRjhnZ0hWOXRLNzF3?=
 =?utf-8?B?SHpoVTEzNVdpbDY4Q0U1Rmx2ZnFsM0dDa09RMERUSnoramMvTmdjK2hLRzY4?=
 =?utf-8?B?Zis4bmhTZktmeXNYblkzTENVdWQzenZUb21KZUdWaTV3Y3dYdjVQMjNzM1pY?=
 =?utf-8?B?ckNOL0ZLMFptNWpyUlk4dlVuRWVDc0NBSFl6cTB3NnM5ZkNiM0w3ZVMyMzJJ?=
 =?utf-8?B?cWxMK1ZsS0NIMmN3YnBqTTJUdHh4V1piOW1EQ21DYnZiUkI2OHVhQ0FhZ2VG?=
 =?utf-8?B?NVd1YmhWMHd6RlVpZTN5VlJpS0h1c0ZyR3Z1TElDRkw2cDVITGsvS1BncUFK?=
 =?utf-8?B?dlN5VEFkQXFqa2RQcWNRUnBMTU1OQmNoaHB0Q0ozVW8zVDhISUJ6Sm9DNWlh?=
 =?utf-8?B?Y1VsRlJGT3FhcjdRSG42aWlEK3BKcjNRRCtIV2RzZGxxTUtSd2lubGRyemhR?=
 =?utf-8?B?WWFzMnpINWRoYTRTREQ0VWhDTEZQNER5NExsaHZaYS9BblV5eHBudVNYQUh2?=
 =?utf-8?B?R3R0UUhSeVRzaE40M0M5T0drODVZbUlNQXA0dk5GTTgvYVFRNm5ubGMzS2ww?=
 =?utf-8?B?TkVWa2tEMXM2RnhIYUJ6cVd2bHFHN2ZhVHQ1Wll4Q0hIcFMyVzZXWHQ3MUg2?=
 =?utf-8?B?S3FXbTNSUUNCS0RYSkh2WFlMbWF5SURIMGRBRHg4RVN1d1hpbU9YSG1iMU5h?=
 =?utf-8?B?L0pxVzFub0I0SWN4YWdLK1p1aVNpZi92QVNiOU56UTd4SDBXZFpnOC9KNUx2?=
 =?utf-8?B?SjdTQ3dUUk1YTk1LUGJkREwrWGNmNEdCNjZIcXFuSFFRZzIyQlRWaWYyYnBk?=
 =?utf-8?B?VGhQSzljYXNIeUZMNWFJQ1JkSldpOUZKNGFqa0lkSkNPbzV1bzlodzRjZXl1?=
 =?utf-8?B?c3l4VkxnT0tHRWxVS2Ryb0pOQkZSL1JvdmVFY1cxN1l3TUhsQTBVNm1CUm5Y?=
 =?utf-8?B?dzBiazFxSjkybDE2bGJQSlhidjVTcG11RjlybXVRQUZBMkhDRjYvQTdocTZF?=
 =?utf-8?B?eDI0dlZ2TzhSbzcxWWJ1aWVxMXBMWG9rcUFVamhockxuT3VpRFZhYURoeTdw?=
 =?utf-8?B?aGI2azAvSjUrTVhBSkVZcHRvRGV1NHQySWpEcEJBdkJWOU9UTkFlVVRxWldC?=
 =?utf-8?B?QzRQZThySExGMEZrNnd1MWpLTGY2M2p5bGdXWUhoZzNTU1dmY1lLRUZ4V01o?=
 =?utf-8?B?UGVTWWZkUDU0Rm9aQUNaUDllRHdlR2h2amExRFVMTkhCZkw3S25ITlQwZTJm?=
 =?utf-8?B?ZTRWZ1YzclJEUXJPUmt3VldsQ0Z0RXdaaTI3MWRpK0UrVEdFNWRBdWNyZVN2?=
 =?utf-8?B?aUVyalRqVktIZWZWbHEvOHppU3hXS2xzaGJRU3UrdjFMazBMN3kxYklXdmU4?=
 =?utf-8?B?ZXlCeEdybTBTeVhSajBLazNFcmxFVFNWTkNWME1nbVZQUGozY21GQ3k4bmRi?=
 =?utf-8?Q?+li6zgAdeqc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWZTL0VKK3RFQVhZenY0VDVMMS9DalpIdTRqZHJRM2xDM2l2Q2EzbGNENUdu?=
 =?utf-8?B?WTBUb0RLYTBjeC9XM0c4ZUVIb253YWdXSzNZbHdCaWRiQjdLU1lHSFM2UGtH?=
 =?utf-8?B?V21qZjJUdTRKYUQ5ZGtwQXNGT0dIK3dyR0dva01pK0pXc3BjTkFsTkNhUHZR?=
 =?utf-8?B?VzNuUnh6WVQzNFdvcW9HdTV6dCtYcDE3MUpkUnFUTWsra1lPdytQdVlyelR4?=
 =?utf-8?B?ZDl6M3dtK2VBT3FuOUNScUVRYjlzL3AzSFhvRzJuYmVoM3NQQWEyQS9LRmRz?=
 =?utf-8?B?elFzTlZTZVpEcG5MM2hBQlFGdmZxMWVhYm5TK3ZXY0ExbTV6QnhCQUtzS3J3?=
 =?utf-8?B?U0FORXR4eHFnWmdBMVZKaEhmM1luR2gxRUptVTVjZnVoMEV1MjRFTEFwZW1P?=
 =?utf-8?B?QWRLSkRrd3hGN010TWRNMlZkTXREMlVGUUtXc2hZVFlRQXlTaDVOemxkK2lm?=
 =?utf-8?B?QWFrbmdJMXJFNUZYNkhZdGZ4V0hWMDNxc0s0clVhLytWMVhUTFhzTWVXM1pX?=
 =?utf-8?B?aXo4eEk1RVBZMUsrSTc5dE0rbE1tNlZ0dFhrSFI3S2VWTHVsNjFEdjBPQyt4?=
 =?utf-8?B?cnh2L01Pd1VacVBSejNTVGtkMGN1Qm9jbXdTUFRJckcwbzArQ2VvNnRjSWVW?=
 =?utf-8?B?dVd1cmVUcGQrN2ZKQlZDYnZsTVM4elBCVDVPOVVWRzk3Qm1kK0xOczhORXQw?=
 =?utf-8?B?SlFsby9HVmtZOWdsZERBU2x5MnNaQWM0QVU2RTdHNDFUbFRWWUVVcXZRM2Mw?=
 =?utf-8?B?SHBHcGZaTTA5cUo0S21yQ0JWbm90U0VvVE45Z1M2SDcwSkJoQkVjL2xVRDQr?=
 =?utf-8?B?V0c2NWdkSFlnVnVhWjl2aFJaWGxZNkJlTGc1T1pIRzVhOGE1SVFqcHJKa1p4?=
 =?utf-8?B?dHpNU1Zvd2JwTTZFU3F0Q3RlRGVMMm9iUEZhdEhFVHRrQ3FvUXJmQUdMKzBH?=
 =?utf-8?B?NGt0WG5VYWhKdEVuUHl4b3Y5TVhnbmJJTVM3Y2hVOGdRZEV0ODhqeXRPZU1i?=
 =?utf-8?B?eFZjSkhRZ2J2T1QvOGNEaHhHUk9SMjFZRHFIb1RCaENWeFhIWmhTbFl6dlQz?=
 =?utf-8?B?eEJnOWdZdktIUHpZR3VONHI4NWhZLzAvZmxZM1M3ZGgxb3dGdU4zSi9qb1ly?=
 =?utf-8?B?SjBGSzJUVlpiV1p0aUlqenBOMnBtY2xORjg3L3dISUVNZ1MrdGVHa0U1Zm00?=
 =?utf-8?B?MXZQb0ROUWVwSC9BZFBzREFXQkFSTXl6eFJjWk9nU2wzUjR6dm1HSUhsaXlX?=
 =?utf-8?B?dStDc1RCQTRLZXc5eHlwVUNTSVczNWhpZGtGWjNOeXdLdTlYR0w5aVg0ck5K?=
 =?utf-8?B?WDBNN3hob2NJK2t2UkVMZW5pUWVqeDd2Sk84eXlaRks2bzhUamo5QnVja2J0?=
 =?utf-8?B?Z0hBSXJzaVdUV2JNY2RPSTJiaEl1b05ocUo5bDN2bGZKWlAweHZmeHd5RlRw?=
 =?utf-8?B?VjlRVVl4NlM1WGZnRGR2eGNWTWdwRE5NTk9QaFlPWHhWYlZHTEhWU1JIZ0hN?=
 =?utf-8?B?Ujc3NE4zT3R1aXIrTGVrRENadkk3Q0tZTW83cXNqaGlLNkMzbzJCUDQ4S3pC?=
 =?utf-8?B?eDFPMjVhWlNtbWV2WVZCeHJkcnBic1NENnIrY1VIQmVtNkJZM2pVM0dBVngv?=
 =?utf-8?B?SHRNeU5uVnlPeXpscnp3VE9YY09QdHpnNjNvaDN5ajVNcU5naDJ6cFhTbWsr?=
 =?utf-8?B?MmxoaWJ2MUxER3UzOVYzNXhQMGY5TjNya1dhN3JZM1I4eXFwVlR5WHR3SG5n?=
 =?utf-8?B?Nkt1d2JuWVFFRzlVUmxsVnRXaXRKbE1wUTQ0QnZnb2hqNS9EazNrRGFPRDRL?=
 =?utf-8?B?eWhiMmVibE9tSVRScnJwSjBtZDBRRGNySVpLZEZqZDZEdGJsSXRadWJOMUlP?=
 =?utf-8?B?VWVyOHkyN3lxUjJTU0tqR1Z6SUxPRjA4WEFQRWhQNlFTN2dXYmhGMm9Ra1Ev?=
 =?utf-8?B?UWlMYWV5eXgxUFlPYUN2RnREY2FQdkd0R1FpS2U5NFlhUlVPdjJWQ1Y2RzAx?=
 =?utf-8?B?cXBtVEFSRGdBWW13L3BRNzdaQlcwZTFVQjN6ajc0TmRhWHV4M2dlb1hBVnVr?=
 =?utf-8?B?MEdoZnVBN0xSb0FhUUNGUE1adGFXMk0zZ1ZKSld5S1RicjJHdTlIUUFEUmly?=
 =?utf-8?Q?6hUW3NyuI0IMXtyH6F53BvmyX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a1450e-123c-4955-bd32-08ddad4630ae
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 02:25:13.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gItyPTt+HExr/H6mIN0+8tJNy3mvwfYnd+AUKHkRmdfCQU32U2hh373hRV27dZNR15ORQwynsxTU9kYC6E1Kow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572



On 6/12/2025 5:03 PM, Boqun Feng wrote:
[..]
> 
>> The kernel robot reports it and it is already a strong indication that
>> the subsystem is not hardened against invalid inputs:
>>
>> "BUG: unable to handle kernel NULL pointer dereference in rcu_core (3)"
>>
>> so this in the rcu_core() which is part of RCU.
>>
>> But, anyway Joel should decide. I shared my opinion :)
>>
> 
> Of course, my point is that the urgency is not high enough so we have to
> put it in rcu/fixes, but it's a fix, and if Joel had the time to do
> it, feel free. Joel's decision.
> 
Yeah I feel Vlad's fix for a crash is important so I'll send this up to Linus
for 6.16 after some testing this week. For the other 2 patches, since that is
triggered by a trace point, I'll just let Neeraj take them for 6.17.

thanks,

 - Joel






