Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47F1D54E9;
	Fri, 11 Jul 2025 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257994; cv=fail; b=Ahn2/3QfeW9pVveGxoCAj07frCuQOIOPjqhiaJzBuEy6c8FZ96UNlkklQxcT8Yn1kt1A1aERziiCw9XLt8tNGKsOH0VmAPyNngq/IlkD+qh6GXu/TL1MpuDOPnvpeo11evpMEjqADoS6h8zodFLB2AOUv54mVK4n+8tIC9D3jEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257994; c=relaxed/simple;
	bh=fHkpW+qOpnKHF4aYy6Lk5QKNumNdEFBUnfzNPqyojH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qb/p8dBaK0FiLFOvIDFtdJ4NC9dRN3MQ4bSQgl2D+HbU3vlAQhzGogOT37Tz2VkrFBjbdNQNrV1DOduLMdEVMdNazs3S/GT2lvtmrLM8ni3xWQbtcPIN8Rh+jxCfzgWlPNRaEK2SjDEa9NzDJ5gKpCoxRH4nvozX1FftI8rpBbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BSjrmaGo; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BSjrmaGo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcg9N7VjGulFUeKEf3b7mzHJFpRHz21tFt5c3XDaXOfPChgMwYjBwRKy+IslK9Jrxz7L0EHfX+Z8PKXJPAvAPr43eOS5H5HjTPxx8EeaO1dOVEbwz55Vs7xjFeE6MfBEfOWRFLM1N3WCxIOrXoMj6m/AeYJKqO9A5xeUbxVJjXHyEBs3UaxZei8ZYc91jVQjF23qxqozJkkoPMPxP9KhJb0zEPluCmgN5yi11yuwXsFPjcGxX408xIjdOmhoYjCU27SZtIf7JBtKmATP4/Bey97UkvX63qmdQrbXGMCHYpm7vueXcwoJxhnoz3dIkLxWE0J6op5+epfUMULisJOIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTQWZVM8yJHvIKh1IUmRO9M2XYofrP2IISbr4vWPt/w=;
 b=fztBCZpIkjq5hSOqMbic/tt/rnBIsD2ADUIHbqfz9QVvGadqXTYM6M5t62+96fZpFkCjh+2G7jSXetitKwMFlW5J2M4dGEHYa4TyAJY4hmObRAiv1qBmG1Ab7RM4Y4OfKiv1URS1DfS/5zmrHxIJ0gSomsVy/WdmRW6mzJjJAMUEW451zlJ8XzDQMhLG+6WT8mooodIErbEgP2OQiaH/xREC47WR1LIZ/+Q7ICf2pBEGlmGqgBI2WNnbJ4ZFr+OerybKsu7Rw0iw1VePQ1kk0SirXPLYIcqbVCSeL+pwu949cmoyqKzuYrXGzQemAHdU1L7qcOGHROsLSIoxXyYHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTQWZVM8yJHvIKh1IUmRO9M2XYofrP2IISbr4vWPt/w=;
 b=BSjrmaGoJ52QrF32OHADuZwLutxSJgBTxCEMf2x2FzvBYAf4kfMWs09/8BmD3vgTNAxHzvfxR42FgZEjfFFrNXCMEDBRtNq2/1RNTZTm9onS9XViwMWzHPFnPB2DMI7+H5Dtw6mn+MpJFDF0/6vYezLSBXcWdaQoEHji9qH+8vcWx69Vpd5x3Z+1ZxmSad+Q9XlKHLuBiYBPTitblX4Gx1AAZPoipMGJAHWQ22v1sq5WbUVidnRIbm5S2G0+ZNucegAix2tBeBYHJqz54UlV84djdGXEkK+fTMmw9HhhTXepJCnehra+TEeZE31cfyKCeSJfPIi7Syoz8WdgqOUitQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Fri, 11 Jul
 2025 18:19:50 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Fri, 11 Jul 2025
 18:19:50 +0000
Message-ID: <3d1217a9-2d22-4808-adca-0fdf78278a36@nvidia.com>
Date: Fri, 11 Jul 2025 14:19:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -rcu -next 4/7] rcu: Remove redundant check for irq state
 during unlock
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 rcu@vger.kernel.org
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
 <20250708142224.3940851-4-joelagnelf@nvidia.com>
 <9b67bbca-dfdc-470e-9a32-486300efa586@paulmck-laptop>
 <ebfa8f35-8ede-46c3-a865-384d12d11e90@nvidia.com>
 <c25c1084-ef70-409b-b38f-84c69e08e562@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <c25c1084-ef70-409b-b38f-84c69e08e562@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0035.namprd15.prod.outlook.com
 (2603:10b6:207:17::48) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA1PR12MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aea79f9-09a8-4094-1f00-08ddc0a78634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cStYRFFvODB0dE4xTWdsdlZkbkhmZTBSN2xrMEsydEl2UDNncHcyeEV5cTRX?=
 =?utf-8?B?dUFjVEF6Ykd2YU1TTG54VGJIVmlIRHFlOW1DWFJGV0V1VityOEE1R1FvdnFw?=
 =?utf-8?B?WUFYMVBaQWc3MHYycGFoYS9yOS84SllNUHNUSEcyYzdkZ2dDdjJvcVFTU25s?=
 =?utf-8?B?ZlpCcUFidDQyYVRwM21yT2tUT3lvMi83a3l2ZUZsakpuSmwvOERmUUlWRVNZ?=
 =?utf-8?B?LzJIQlVtaDAwL2tkWW1VUVpuYVVpUFZHdmlGOTJDaWZVQTBtcnV4ampWSlVr?=
 =?utf-8?B?LytETXAvbTFzUkR1WGx3TXdURDBQWXdtV1JWNVc3dG1yUU83MFNZMmVDa3Fq?=
 =?utf-8?B?b0taamhtWWhwblJBLzFUTUlvWCtYNWRNVlBjRm5EeGUyVks4Z3ZFMzRWZjZz?=
 =?utf-8?B?TzhMYnRMN1JCRWJuNzZHV0xjekMvYlJZMVlqR3N4cGduSU5OVXVxNDdOaHFx?=
 =?utf-8?B?eGRTMFZheDZpdDdKRFRhdFBabXpwVkJiMmg0cXhPQk5TODR4bXFCMThNS3Bp?=
 =?utf-8?B?VDR0clYxcEY5MXlIeWZQSHdldzh4b3RRRkJnMlFmSzRkcVFmOFk3dUJhWGxt?=
 =?utf-8?B?R1FXbmdPSThpTHBrRWdFbmVNald1Z0IyR1hQbHZqcDBEakZNZldjRHRYQThl?=
 =?utf-8?B?eEZieUtQM0lBM0pJTXcveGkyZ243QUs5cjZtS0xDZVVTTHRLNjFydmRydlNr?=
 =?utf-8?B?R2FMYXRjMTkzQjlHQnR5ZmVTWXIwRlRHNWNiNmovOVFRSXM3aXZ1OXJtR1ZQ?=
 =?utf-8?B?aWdMQmlnUDkwS29FU3ZSL3FhdVRBcEl0YytmcTlWM0xoU2V0d2p5dGN6M2xP?=
 =?utf-8?B?WjkxcEtBNTMrM1Y1c09teWVYOTBjYVMwY0tpK2hTbDdpQUVXakk2NVl3VlUw?=
 =?utf-8?B?RENuN3F3MnNwdTkzL2ExNndPME9kOVZkWFNTTSt4UnoralFnQ2F4dDJad0hK?=
 =?utf-8?B?ZUNodVNBcTlSZjg1a1BtM2ZuSHo3ZENCc25MbGFzL2xDYVRaOUlDWnlreWUv?=
 =?utf-8?B?bXU2ZlJlY2c2QjJDMXhrMzdXRU44SGJVYXU2Mi9nRjNPZjV2ck1COHEyYjlG?=
 =?utf-8?B?MktmNVlDbnNPSExSckJ0RmNPc1B2bTE4MnNHNjhNaExwSEl3RktPZ0d1M1Bj?=
 =?utf-8?B?bVBjTXMzTjV0OU9waXZQT1crSVhnZzdFWDNVMFNzU3RKNkFzdkVEbjdSLzcr?=
 =?utf-8?B?S3BwQVdrU0l0d1FnTTJwc2xxUE9BQml2VkIzMEJ2bDZ2cVZ0dS8wWW0va0FL?=
 =?utf-8?B?QWVDWDNmTG9YWFV1cGdxSDVKMTZob3ZZMHZYOXoyM1ZBeFR2c2Fnd0pRVGg2?=
 =?utf-8?B?b2FhMU1GY3BnTFlIVFJwZGtxdU1tR0V2dUk0cEM2dVhUZkI2dzQ2dVRmcXhU?=
 =?utf-8?B?RmZRZmxvWEZqVm1COStraFBhZkx5UDU4TGZTUnU1QlFWNmRtZG1KdjNjYW9k?=
 =?utf-8?B?bUlteVUybkVDRlNBOWNwbGVKTVhFYldsZ0FGdXhmY20yT3U3b0NnR1dnVUZa?=
 =?utf-8?B?R0xyWm9qbllFVXZwWnQ4ZjRFV2JFa0FzdVlMeUVLMVFpNDM2Yk1DN2JQdjJw?=
 =?utf-8?B?cEREazYySTNtM0NyS0Jrcm0rdTFpWTc0cHNZOVZXTkdYNmFwb0hCUXg1WHgw?=
 =?utf-8?B?VFZJR2dVdWZWRzlldkdxaEY1eDNISnlZcG1KYlFzbTgrNlorMHVtcERLd2p0?=
 =?utf-8?B?ZXJvSk96OVFrWUp6QkYxVGNibjl1VFlteGpDRHVrTGxvUmJvb0FKSG1xeGJn?=
 =?utf-8?B?ZWlUZTlUKzhzbGJ1RCtjb3FtZ0V1c0g4Sy9XMm1DcGlGNUpjU2QrM2FNc2h5?=
 =?utf-8?B?Mm5CaWxFdlVxVU9NbFI5NkU1YzBzSTJXdG02UmpHcllxWFVHY1Rzekg5WVh4?=
 =?utf-8?B?QVBNajJJTHFzcUxlL0l6UVR0dEVsZ3N0ZWEyMEV6djVWZEdPOGZCQXBLNnJn?=
 =?utf-8?Q?uQW1gRwMZdg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnFWTStOZXhoVmNTY1NDanVkbmw0MG5qZCtHZ2YvYTlONnF2VjBQMXM2aE9Q?=
 =?utf-8?B?WTU0eVBocm04U0NtUUIvQ2FuN1ZYN3U3bkRZelVhaHRBQ0U1Mm5vaFViaWFk?=
 =?utf-8?B?ODdaRmZ1MVh1ZHUyNHNheFkwWmlWSm9Ob09vMkRNeGRldEM5Wkl6UEtkQUQy?=
 =?utf-8?B?SlV3cXVWN0ZQRkt2RzdKVXFxSHJrbnh2TWZaV3BRc2VJYWFVL2Fwd0h0eW9y?=
 =?utf-8?B?YmJ5WHVyUVZ3QmlPdkFNa2x6d0xSZ3FidVp2bVl0NmNNYTlYSnA0WVB4ai9G?=
 =?utf-8?B?NXkyTTMrMWEzZ3pnU0JhQm43RVMwTU9yME1QSkhuamlHRzl2YjY2WG9QbUpq?=
 =?utf-8?B?aWZab1MrV25SdFpIdEswelVhRk9yVUVpN2o4Qkc1TGF1aFU1SzdqSVdVZWlU?=
 =?utf-8?B?b2VYbDBPRXZ6d2FLWEs3OTA2NytpdlE0cW5zeGlWY25BRjkvcGR6aU1wRW1m?=
 =?utf-8?B?T2dMMmw3VUptWkpmalpvNXhGVXJWcDhkNEdWVlhOdEtxTGx1MDFIUTFQRERS?=
 =?utf-8?B?Q2doZ0ZMb0dETW1HS05LRkNlK1I0MVY1VTY1Y2lPTWM1b0wvM2dsUTZMN1Ro?=
 =?utf-8?B?aitSRjl6SmM4b0dhQjAwbWVqQzZGNXh5anJwOVRHRVlKNHg3a3ZFZ0Yzc041?=
 =?utf-8?B?VDVhWXJLUlpCays4ZTJUNWZmSDJrRGt4MWNZYXhZdndWdUhkc1cvRTVZV0Vw?=
 =?utf-8?B?OEhRN1hiUzFsMHJ3eWlUekR1RmFuVG1ZelBqMHpBQ2dacS81MFE2b2Y1a1cz?=
 =?utf-8?B?N2c2TnpzeHBmcTliL291UjYzaGFoSDhUL3ViaW9qci9sbEgweUhhMUhEU3hM?=
 =?utf-8?B?T3JqRGZUV3hmdnppR1dTdjVBaXc1VTRob2Q1enBmUXAvUFZSZEFnNWUrQXd3?=
 =?utf-8?B?UVN0MzdObzl0Z0hqb25VcDNJSTFKS3orTm5pdEtaVmora3IvYStTTVhaNGpu?=
 =?utf-8?B?RktzMGszTVgyOSs0ZHlWeTAxQ25IYkk5UGpscSsvZitsRFczUGVxd01VOEpz?=
 =?utf-8?B?S1A2OHljU25ONkRqM0tQZHo5M1gzUTNMTnBCRXJzQTFvWHRxcWlFdkpPeGls?=
 =?utf-8?B?N0hSRVZSY0M1S24yVnFoUWtJS2FDZlZONVVnT1g5K1MyTldUYWdkZkNTWm9M?=
 =?utf-8?B?Rm14aXpvUUFYN2JYbCtDSXhuMUtZSForUkxiTUVTckh0c3pCa1BYQ1hSV3E1?=
 =?utf-8?B?VVBUK2xTT1Q0TXhLbTNEZ3ZHaThocy9nanFyVGp3bzBpbEhHdmJvYWRmU0hN?=
 =?utf-8?B?ZHRFTHRqQjlUZ1lJN2MzUkdmNk9zeERVRlpUZnRkbXZVRDBybEllTzN0ZDVI?=
 =?utf-8?B?Q2ZkMkRLY1JTNTRVdHV5NnE5Mlo3Q1MrWk53MkxPeTFvK1F6Z3VDeURmV3Fn?=
 =?utf-8?B?eTBjdDdEREN4QXJad0xtaUkvRFoxNkgyYTF4REc0QXlON0poRE1YMnlKeHVL?=
 =?utf-8?B?c2NtVGRjNmJVdE44bnRTb0J1VE1zN1ArZGZ3Qm44dmJqL2RCOWJPVHBzeWxx?=
 =?utf-8?B?anRHWHF4eC9OalgvQkpYS21hSUxqWU8rVHJZajhuL0dsTlJWVXpYNHFrMCtH?=
 =?utf-8?B?eW1rZUw1L3hDc3AvanQ1azhPaUNoV2c4M2JXeUhlamIydVNEbC9EMnVPZmJT?=
 =?utf-8?B?RjdEbVJVc3lyamJ3Q2FVaHN3Y3RTdEtrK2VRaHlhMUJmRFZ5SmZVNUVadmhn?=
 =?utf-8?B?OGtENWtxaE5COHhNMlNIL2lkb05JNVpScTJzaGRrcVBOL29JSmVBSU5LYmpt?=
 =?utf-8?B?TWorZmZKVU0xUzZwSGVYNU5ObGJKRVlVN1N4K2pzYUhMaUpJakVrS2QydER5?=
 =?utf-8?B?MEtVSFBDVmx0Qk82S0p1MzkwUTZQY3dMNTNyUWNEeUs4a1FIWHNUaHBIa2gr?=
 =?utf-8?B?cmdCQkRHSDQ4Vm11cEIrQW5ZcUltd2Fzd3NhK0Yrbm9RVDFaZm11VVRvSWFx?=
 =?utf-8?B?Yy9NWUdqbm5YU2JEQkxVbzlGK1k4bTJ3WGQ4cTRTNDE0akpScStyRjZQeGp0?=
 =?utf-8?B?dE1oRXowSzNFYWZTT3J5KzY0MDlZYXM4RFpxK1J1dDgxRWlqQlk2dFhRTStG?=
 =?utf-8?B?aFBtNXRyb3drZmhxSDhxR1g4Nmx0YmpKTTZQUUVJcHRaMnpiRmpLcm1Ubmtq?=
 =?utf-8?Q?uSG9LLk6U/N1ccqev3xKA31kq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aea79f9-09a8-4094-1f00-08ddc0a78634
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 18:19:50.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoKitvCnelXK7OjC/8s9r/oZnb81xunVMf3kgnIcuej4Ii21TkJIeGkFEcMUdhSNxx2pGgtpoFXF0YCIsAY3Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9491



On 7/11/2025 1:18 PM, Paul E. McKenney wrote:
> On Fri, Jul 11, 2025 at 12:30:08PM -0400, Joel Fernandes wrote:
>>
>>
>> On 7/10/2025 8:00 PM, Paul E. McKenney wrote:
>>> On Tue, Jul 08, 2025 at 10:22:21AM -0400, Joel Fernandes wrote:
>>>> The check for irqs_were_disabled is redundant in
>>>> rcu_unlock_needs_exp_handling() as the caller already checks for this.
>>>> This includes the boost case as well. Just remove the redundant check.
>>>
>>> But in the very last "if" statement in the context of the last hunk of
>>> this patch, isn't it instead checking for !irqs_were_disabled?
>>>
>>> Or is there something that I am missing that makes this work out OK?
>>
>> You are right, after going over all the cases I introduced a behavioral change.
>>
>> Say, irqs_were_disabled was false. And say we are RCU-boosted. needs_exp might
>> return true now, but previously it was returning false. Further say, we are not
>> in hardirq.
>>
>> New code will raise softirq, old code would go to the ELSE and just set:
>>                 set_tsk_need_resched(current);
>> set_preempt_need_resched();
>>
>> But preempt_bh_were_disabled that's why we're here.
>>
>> So we need to only set resched and not raise softirq, because the preempt enable
>> would reschedule.
>>
>> Sorry I missed this, but unless this behavior is correct or needs further work,
>> lets drop this patch. Thanks and kudos on the catch!
> 
> Not a problem!
> 
> You can use cbmc to check these sorts of transformations, as described
> here: https://paulmck.livejournal.com/38997.html
Much appreciated! Does the tool automatically create stubs for dependent
structures or is that upto the CBMC user? I see in your example in the blog you
did create an rcu_node :). I wonder if for large number of dependencies on the
code base, how it does in terms of overhead for the user.

But perhaps for simpler examples (such as perhaps the above), manually mocking
data structures and dependent code is reasonable?

We'd have to stub irq_work and raise_softirq and functions too and also the
CONFIG option values.

Thanks!

 - Joel




