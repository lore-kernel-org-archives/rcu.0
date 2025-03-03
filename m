Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49352214819;
	Mon,  3 Mar 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016949; cv=fail; b=ruXRKQm33J7tw7j7H8wSjHsP+0MLNVnjwFl/+qRtfMCqd5VGuuXekXGmAx+RUL24qL7pqoglWY8whGPcDtfBOwhfQM1ujxQrVZndBPx0+HxNhVfN1v0mx42lbR7r1HK5/WWYvXBgsIPIlygmHmXbxnrgrGopBT66ENKxCobeFQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016949; c=relaxed/simple;
	bh=YqG81f6zb1RIU2Q1E61LKYWTvVs7WfzREsIyPgqADA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CqyhvtGzdZHK4SfW6sM7y8Iv2yISCvn9QDKc5fKqnRts8zQNK9AT5NlXSmPTdR5AU/kTZnOvEQzmX9z21VqDGCF+Qo2jyIBr3JVxP06RIA7W7wLLEtiXTaRppxnOB9+d2MxZFxRp2GcI5RVYuy8oiqsnFOcJMwWxICClfCPnVVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OeSLP0KP; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OeSLP0KP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOOmv93PXWhR5/cOwIPSWSxzfWvOR0UFg20ecdpfV6Z7rlg0qpx67zLqFaSLsroRH8jHE5EbxrkS2765nyP4aFOODbsyf0qre0irvss/MdjhGEJjZIybgdc62xFR5wKa+ouqOETVjR5/T8KwsZZtSje37shM0Eq+UyJAykXUQM5JZCC/Y9bi6VUDZeF9kCE7c/B/vPqKQp8bixwV7aJebY8uajOjCa4lHkFixB9thLv1Bp+Jm1xOCUwUt5AFavsME0bvC+CoCzzpG0pFQFhCYLmroMpIFraupzjp59nNixD7XV1IY/HN1MXKQfDyd2+b+yaCPrRwqwNOf7/fe7E3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuyV5t2UJo9jO/CYH1/vIb8GJL+zn9SgrJ5QK8ZEkUM=;
 b=O+tWJwA1UN4TcwNbjf9nKRCOkutFGN9tmAgJxXuNpjLjr+A1fvXP+d0jy0S0wICAXQay7ydRA4Ujx50gB1g2y8bRmAQ0obZdhHzo9TUdTDUpoNqueai3Dl9GDw4+WWwT6vdBnP4VsxQTLp5GWsTSumVTCeqRBaFbZl6Spxxqq+O+n8U5agqzK7Kq501DBUnGmkGP9LjpTfNYjw3mabxReAENrhYQ7Y7emQ3xODzPrrDcv4U7C6zxk/BCgnkm81U/zHL66yhc2QCO7ncdBVOVV6EGUAdtTb6AQojW4UDap8kyoXP7mo1GCPNM4fj9WtzJlVRJtgqDw1t9SXo7JGXnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuyV5t2UJo9jO/CYH1/vIb8GJL+zn9SgrJ5QK8ZEkUM=;
 b=OeSLP0KPJwfffg7es4rzz/Hfj1ddFBCB6uhMQI+j9cQZatqGyJE428QhS8ABJuEWnwTUCYy1wPYFTLp8iA9OdayAMY+RLRCP+nYp7OJ/Mig2kcJ3Iku7UVjxiYSTU7WbkEXJC8KPvxdNNBwahxXUo+LQuOp/Pvd9r3fO8sRZQRxe0xf1zlwf2tpGe9yl+sEGOCPVY/dAyiaI4N+qJCcL1/zc3y3vb9l1soB+MXpwu73po5yeIlClz1EpUqBqY/tTvhE82vMWQa9mFrvxg56/v8mLeOpAzRlv07Ffy4kbMPL8HhbDZfezYIlc7Mz9IKki+g99AlIwyyr04Z7cJNCc4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 15:49:01 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Mon, 3 Mar 2025
 15:49:00 +0000
Date: Mon, 3 Mar 2025 10:48:59 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Strforexc yn <strforexc@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"boqun.feng@gmail.com Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: KASAN: global-out-of-bounds Read in srcu_gp_start_if_needed
Message-ID: <20250303154859.GA19598@joelnvbox>
References: <CA+HokZrPb-oHcuZQsc=LZ6_aJfjKy9oMeCBd-tq4b_sX5EG7NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HokZrPb-oHcuZQsc=LZ6_aJfjKy9oMeCBd-tq4b_sX5EG7NQ@mail.gmail.com>
X-ClientProxiedBy: MN0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:52f::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 64199155-4c18-497d-1150-08dd5a6aeaac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkllZHNmbDNxMklmRTJWVzVxSjlsSjZ2a0FqazY1RGxJQyszNTRQQXFsNkdx?=
 =?utf-8?B?U2hzYWhkQldLMTBHcXBoS0lHYzU0dTZyYUJmVmU1VjBvV0kvSHMxODRhbm1C?=
 =?utf-8?B?d0lUNC9XS3V1dTRRYlVVUTRhNzdhSXZUTGhCdGhCUmNjQWhFTlovb1dMcUpj?=
 =?utf-8?B?UHVRZmd4RlFlODJoS3RwaHM5Mms1YzVuNDkySmlvOXQxL25MUjIxbGd3N0tM?=
 =?utf-8?B?ai83S1BYajFCV01oT2dzSVB6OUNyWW03M05EUkpKT2I2R3pKMVdBL24wN3lQ?=
 =?utf-8?B?VWdSM3g5UVNDSjVzeVdiSzFzNXp1TXJnalFHeGE2RHBFUTcxVlBUempTQmpC?=
 =?utf-8?B?Z2RDR0FRRXZWMmdkTW85QTFWVDVTbHFlU2IxSXBqMXBuNGVxcFVZbVNaell2?=
 =?utf-8?B?YmlxTkhOMEhDeUxCMkpTNkV1emFKZm5uNFA2Vk1vY21wQXBIdnYxY1V1ZE82?=
 =?utf-8?B?TWhQOGlDWEhWNTBTbUU2eXlVSjhzTVdMVjlBMGxlN3I2d0gzcUxkYjBmL2dv?=
 =?utf-8?B?aDcySXVOS2VoTG1CUkd1UXF2eWhHcG1vR2VnL0hrQnRMVElUN1pLaHdQWFFq?=
 =?utf-8?B?T1o3K0NNUjZLejlJVk5TWUR0T1VTYmFuZEQ3aURJemRzVW5Bb1g0OWNpZHkv?=
 =?utf-8?B?TmVkUlpkR1hlNmR3Zk9VNXNSZ0d3dy93eVV5cVVTcHBWMHN3QXhuc2RSczU1?=
 =?utf-8?B?Rjk2eHprZ2Fwb2pRZDBvSUZTdmRRbUV4TERKdmpJbEZBYVJNaGl0azNGZG9k?=
 =?utf-8?B?dzZpZGEzTTIyZ3VjMy9VZG1seWhoMElhUnZMRit6cFZ1VFdBbGFDbStSS00x?=
 =?utf-8?B?NjdmcUtOank1dVJzSlR2VzBGNmFtY2U1UXdIZmJJSkJsc3RCdW9uczh3RlJh?=
 =?utf-8?B?YVZ3WWk1VklUM01RRUdBdjBpRDFhRm9hYWdxb2hiQTQ4ZGtzbEdEYjdRZExh?=
 =?utf-8?B?ODJUNkdZWlJUT0dRZnBJVyt2NERDSDgvendGcTVHSW5OeWFyMG5SVEhod2tD?=
 =?utf-8?B?enBlRHUxeHNraHNHbDVzVmduZVp4YlZBY0g3NEQyRXp5Y1UxdXo0dnJ2cSs0?=
 =?utf-8?B?eEg3QkYvZmpxck9JTFJXTEN1V29yeTYveGVKdXZsK1NnOEJuYTRkWFVwV2Jm?=
 =?utf-8?B?QlB1Vi9YQTdtL2dUMTVhdXZ0dU85YmdMNG5Ib1g2eHZuTVNtamM5ZWN2eDg4?=
 =?utf-8?B?ZWlSTGRidEt5dHZsdk55bFFIL1plS2szN1VScWFhaW1FRUlPVVVzMzBzazcy?=
 =?utf-8?B?aGw5MUZ2SW1aS2hwd2Z6NCtpWmFTSzR5MW5SMlRhWEZPUlMzZ25Idk5oUEFW?=
 =?utf-8?B?SEtkcFNVcndIaFV0eU4xVjNXTElBR1prVTQwUi9QaWhIOVlVQjdBMyszRXJF?=
 =?utf-8?B?Z21Md2tKUWsxL1RrSjFjQldGQjR4RzZGU2xQSzNuSUZ6Mk02bEg3VzA4bWxI?=
 =?utf-8?B?UTNFNUVBZXJVUVV6a2I3YTZ1OTJkanJPVjdrTHhzUXFaTkc3b0wxZ2g1NTZn?=
 =?utf-8?B?UGI0cHpHRXpCVkJ6YUtyV3draFlEbjh5akNTQ2lveCszVnJ4OUI2MFRFVE5q?=
 =?utf-8?B?ZEFiejFVeFYxenVnNHdZaGVPbHMzVTNBWTdUQmNBdWhKV2xDZ0t5dGtYYkZK?=
 =?utf-8?B?Y01kYnhEYWVaUWVhbllDN0pOY2xnRWdacy9UUUlneElEMW9VbUtzSWZIYWsr?=
 =?utf-8?B?MTlaWVFSaWNsYlF3RGhyNGNrVThaYk0xblF1ZVdCYUtOU24rK1FMK3Fmanpp?=
 =?utf-8?B?VmRkcUtKZnZIdUhkMnp4Ni9RVXgxZjMzQ2dJb1NaRlJTb1JyRkI1c3FxaXZO?=
 =?utf-8?B?T3Y4RFQyYWZ1ZkFkMXZSM0hzOWRrN0wrbDNUNGhGZndLL25PK1A5dVV3OHQr?=
 =?utf-8?Q?7Rt8hJ5w1F4OL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1gwKysxYlg4SngwVDQrU3Nhc3d5Ui9TU1RVUG40Sm55VU9MdkVjVkVSd2xW?=
 =?utf-8?B?dzNVNkpGV2VXb1JsdE53aDM1Lzk3Nng2TnllcitLdzcrNEdmZHVNT09XeWxU?=
 =?utf-8?B?VlFqb2NnQVRxemNkSW9kVHBxZ3lpUHlCWGFBdUpEK3N3UFJPRDBlWVBsSmtm?=
 =?utf-8?B?TkY0RFdhWlRMTnk1OVN5OTdpN29UMEJYM0NlWEY5czhKV2d4TUR3OHVYZ1J2?=
 =?utf-8?B?K0VDdk5ONnhCbmlMd2pNOWhhSlhCSmZiWVdvYkZXb3RKY3NzMzNlTVExTS8x?=
 =?utf-8?B?TGx4bDFYZlRHNERaRVhjclN6MTVRb0Nwak5YTlRJZDN4aGZObG85TWNCOHZS?=
 =?utf-8?B?ZVNtQkhYYyt0TXJicGZrTGpyaFNUei84M0p5MW1XWjg2TmNsUXl1OEMwUVZG?=
 =?utf-8?B?N3YwWkpsSWlmdTB0emhLeE9STzVMNFJvWFVkMjExRTBzZDFxR2VuNDNhTm9M?=
 =?utf-8?B?TTdVbjdySEo3QlNLSmZYZ09ER2xNNG9WeWtYM3NUN1loQ3poVUtDdjE0Tm8w?=
 =?utf-8?B?M3BNRm5Ec1RaOFZQQ1F5Wmk0VlBlaytBRjVpK2g1MlZOYllTY0ROUHYzWmlU?=
 =?utf-8?B?NG41TmFpMFlNbVBJdk1Nc0dXdDU5MEJLRlo4TVdUZDY0Sm9Cb0hjNHN4dThO?=
 =?utf-8?B?a0poMVBkTys4TEFQc2YyK0lFZDlNUFUyV3greGM0UUx2cHBqY08rMkpBQUdV?=
 =?utf-8?B?bW54U09HRVlCTlE2SW05T0NsNStackc4WVg4OExLOWRhN2hNbHYvWnRFUUo0?=
 =?utf-8?B?d09JVXhMMlovbVlTbG9iNTBQZUxBemwzdkNLeEtPRXB2WXVEUW9WWEVGdlNX?=
 =?utf-8?B?SWRxVkM3dWRCazFRc3dJcDZNRWxNSnVBSDBVU1Q0a0s2Ni8veVQzSGNSLzhZ?=
 =?utf-8?B?NThUSjB5R0NaZEwxdy8wRTUxYkJlY0F4ckpDdHpORTBlTzhiNGJqNmFzMTR4?=
 =?utf-8?B?b3g3bUR1MUlFbjRVWG10QVg4Q3BKekFnNDNkRWhld1JnQ2ZoQk1Rc1NWd3No?=
 =?utf-8?B?aUhxSksvVVlGMTRSOGpraHNXYXI4OUtwc3RzbDlvTGsxbU9YUWt6SVh1Rndv?=
 =?utf-8?B?cFNLMC9pdWtTZzFVZm9PdjZXZjhRWlNtdXA2eGkxTjNVMDMxK0gxSTdZUkVR?=
 =?utf-8?B?NGRQT1BZNVV3ZGtSVVZYMjFhZlByRkdPSEo4Z1NiNTFuVzZXR3VZTUZKVSs2?=
 =?utf-8?B?OS9OditXRGZYNGx3N2trbkxWTGIrWnBvOElMcGVtRU02VEljZ0xUalptV0lm?=
 =?utf-8?B?T0c0QUdpbzQ1YnQwazZQRHlUK2I3SWNzNmpqczVMRm9MTVk1bW9NcU4yTjRK?=
 =?utf-8?B?NnVJSFk3cldQWEY4OFBuTXlOdWwzbzJUYXJ6aDBDanpVbHpwNll0RS8xSm5D?=
 =?utf-8?B?c0h5M2pSQm00UktVMnNvM1VrcDBwcWJmdmNTc3pmZmdGdldHeUo0UU5CaHc5?=
 =?utf-8?B?NHN2TWliRllPUDNRMmNqRWNiRlJ5KzRpdGV6MFBPSStqRVhhRXBUcHp5UklS?=
 =?utf-8?B?a1o4NnF0SVBVVEpsd0JPeTJYNnJvZ0YzZjd4RXYxeTdFejgycFBhbWhzUHZH?=
 =?utf-8?B?RnJvTjE5N2NiWkpVeDd1S3BWM3BYYlFva2s4aUszYzZ0SUtZbHN3L1E1UEpB?=
 =?utf-8?B?SjRpeXpmcDRxRlJvUG82b3FBOHZsRDMxMnJNZjF6MFgrdmU4MDRQSnpHbkJ0?=
 =?utf-8?B?aGMweGlUWmdFNzVUU3ZVZm84YVpQWEMvNzloWFNCb3RlbVcxMXQzRHUxRjlk?=
 =?utf-8?B?WFNIOU9TajRQa1VISFhjQUNhaUpSYTJTNENmYzZJQXRoaksybTV2ajZoTFF3?=
 =?utf-8?B?NnVEcW9ka1ZHVWJyelZDUHpuaFQ3NUdPSVJURThaMHg0cktQa0JXTm5KSmo3?=
 =?utf-8?B?V29jaU10WXdZRnR3a1RPMXF2QmpCQzhzOXdNMVpia0VKUjd1OEVBbWlRS292?=
 =?utf-8?B?MmpSc2w2YkR5eXFFcVJwL3FaOXFkdEJnZFN1ZEM4aDg0aGxna0tZWXg5aG02?=
 =?utf-8?B?dndWSWIzSXljNklkWTZQcWlRd0VYQmFCbGFtSXovRGM4YVlmWWloalY5c2cw?=
 =?utf-8?B?a3JIQWtwMXFGcEs4Y0pUUEREQkR5bkx2S0tEVEFHM2g5RHhOL3RIaVdUMC9a?=
 =?utf-8?Q?nEdumT0LPIbIwjfv7puxERgfH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64199155-4c18-497d-1150-08dd5a6aeaac
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:49:00.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd17XEIbWIGGncvHtu2F/RW55ygVU5QnGg77ipkaSjlJ+EhvJdj9zKJdiPDvNnCw9y86XcxuktseSDdTYH6twA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657

On Mon, Mar 03, 2025 at 08:44:48AM +0800, Strforexc yn wrote:
> Dear Maintainers, When using our customized Syzkaller to fuzz the
> latest Linux kernel, the following crash was triggered.
> 
> Kernel commit: v6.14-rc4 (Commits on Feb 24, 2025)
> Kernel Config : https://github.com/Strforexc/LinuxKernelbug/blob/main/.config
> Kernel Log: attachment
> 
> I’ve encountered a KASAN-reported global-out-of-bounds read in Linux
> kernel 6.14.0-rc4, involving the RCU subsystem and bcachefs. Here are
> the details:
> 
> A global-out-of-bounds read of size 1 was detected at address
> ffffffff8b8e8d55 in string_nocheck (lib/vsprintf.c:632), called from
> string (lib/vsprintf.c:714). The buggy address belongs to
> str__rcu__trace_system_name+0x815/0xb40, triggered by a kworker task.
> 
> The issue occurs during a bcachefs transaction commit
> (bch2_trans_commit), which enqueues an RCU callback via
> srcu_gp_start_if_needed. The out-of-bounds access happens in
> string_nocheck, likely during a printk or tracepoint operation
> (vprintk_emit), triggered by a lockdep warning (__warn_printk). The
> variable str__rcu__trace_system_name (size 0xb40) is overrun at offset
> 0x815, suggesting a string handling bug in RCU or bcachefs debug
> output.
> 
> The bug was observed in a QEMU environment during
> btree_interior_update_work execution in bcachefs. It may involve
> filesystem operations (e.g., key cache dropping) under load. I don’t
> have a precise reproducer yet but can assist with testing.
> 
> Could RCU or bcachefs maintainers investigate? This might be a
> tracepoint or printk format string issue in srcu_gp_start_if_needed or
> related code. I suspect an invalid index into
> str__rcu__trace_system_name or a pointer corruption. Happy to provide
> more logs or test patches.

Your bug report is a bit misleading.

We should first debug the underlying issue than debugging the debugger which
may be already compromised due to memory corruption etc. In fact I remember
Steve telling me, sometimes you get console print issues due to lockdep
printing which itself causes more lockdep issues.

The warning in the first place happens because of this in lockdep.

			WARN_ONCE(class->name != lock->name &&
				  lock->key != &__lockdep_no_validate__,
				  "Looking for class \"%s\" with key %ps, \
				  but found a different class \"%s\" with the same key\n",
				  lock->name, lock->key, class->name);

This looks like some kind of corruption of the global data or heap. Which
could be pointing to a deeper memory corruption issue.

+Boqun is our lockdep expert (as are others).

thanks,

 - Joel



> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Zhizhuo Tang <strforexctzzchange@foxmail.com>, Jianzhou
> Zhao <xnxc22xnxc22@qq.com>, Haoran Liu <cherest_san@163.com>
> ------------[ cut here ]------------
> ==================================================================
> BUG: KASAN: global-out-of-bounds in string_nocheck lib/vsprintf.c:632 [inline]
> BUG: KASAN: global-out-of-bounds in string+0x4b3/0x500 lib/vsprintf.c:714
> Read of size 1 at addr ffffffff8b8e8d55 by task kworker/u10:0/28
> 
> CPU: 1 UID: 0 PID: 28 Comm: kworker/u10:0 Not tainted 6.14.0-rc4 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: btree_update btree_interior_update_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
>  print_address_description.constprop.0+0x2c/0x420 mm/kasan/report.c:408
>  print_report+0xaa/0x270 mm/kasan/report.c:521
>  kasan_report+0xbd/0x100 mm/kasan/report.c:634
>  string_nocheck lib/vsprintf.c:632 [inline]
>  string+0x4b3/0x500 lib/vsprintf.c:714
>  vsnprintf+0x620/0x1120 lib/vsprintf.c:2843
>  vprintk_store+0x34f/0xb90 kernel/printk/printk.c:2279
>  vprintk_emit+0x151/0x330 kernel/printk/printk.c:2408
>  __warn_printk+0x162/0x320 kernel/panic.c:797
>  look_up_lock_class+0xad/0x160 kernel/locking/lockdep.c:938
>  register_lock_class+0xb2/0xfc0 kernel/locking/lockdep.c:1292
>  __lock_acquire+0xc3/0x16a0 kernel/locking/lockdep.c:5103
>  lock_acquire+0x181/0x3a0 kernel/locking/lockdep.c:5851
>  __raw_spin_trylock include/linux/spinlock_api_smp.h:90 [inline]
>  _raw_spin_trylock+0x76/0xa0 kernel/locking/spinlock.c:138
>  spin_lock_irqsave_sdp_contention kernel/rcu/srcutree.c:375 [inline]
>  srcu_gp_start_if_needed+0x1a9/0x5f0 kernel/rcu/srcutree.c:1270
>  __call_rcu fs/bcachefs/rcu_pending.c:76 [inline]
>  __rcu_pending_enqueue fs/bcachefs/rcu_pending.c:497 [inline]
>  rcu_pending_enqueue+0x686/0xd30 fs/bcachefs/rcu_pending.c:531
>  bkey_cached_free+0xfd/0x170 fs/bcachefs/btree_key_cache.c:115
>  bch2_btree_key_cache_drop+0xe7/0x770 fs/bcachefs/btree_key_cache.c:613
>  bch2_trans_commit_write_locked.constprop.0+0x2bc6/0x3bc0
> fs/bcachefs/btree_trans_commit.c:794
>  do_bch2_trans_commit.isra.0+0x7a6/0x12f0 fs/bcachefs/btree_trans_commit.c:866
>  __bch2_trans_commit+0x1018/0x18e0 fs/bcachefs/btree_trans_commit.c:1070
>  bch2_trans_commit fs/bcachefs/btree_update.h:183 [inline]
>  btree_update_nodes_written+0x1352/0x2210
> fs/bcachefs/btree_update_interior.c:708
>  btree_interior_update_work+0xda/0x100 fs/bcachefs/btree_update_interior.c:846
>  process_one_work+0x109d/0x18c0 kernel/workqueue.c:3236
>  process_scheduled_works kernel/workqueue.c:3317 [inline]
>  worker_thread+0x677/0xe90 kernel/workqueue.c:3398
>  kthread+0x3b3/0x760 kernel/kthread.c:464
>  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
> The buggy address belongs to the variable:
>  str__rcu__trace_system_name+0x815/0xb40
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xb8e8
> flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000002000 ffffea00002e3a08 ffffea00002e3a08 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner info is not present (never set?)
> 
> Memory state around the buggy address:
>  ffffffff8b8e8c00: f9 f9 f9 f9 00 00 00 00 03 f9 f9 f9 f9 f9 f9 f9
>  ffffffff8b8e8c80: 00 00 00 00 00 00 01 f9 f9 f9 f9 f9 00 00 00 07
> >ffffffff8b8e8d00: f9 f9 f9 f9 00 00 00 03 f9 f9 f9 f9 00 00 00 06
>                                                  ^
>  ffffffff8b8e8d80: f9 f9 f9 f9 00 00 03 f9 f9 f9 f9 f9 00 00 01 f9
>  ffffffff8b8e8e00: f9 f9 f9 f9 00 01 f9 f9 f9 f9 f9 f9 00 00 00 00
> ==================================================================
> Thanks,
> Zhizhuo Tang


