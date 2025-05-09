Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DAE24466B;
	Fri,  9 May 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817922; cv=fail; b=cwfjLNYW2/mRM4SxJDZ+2YmJsJd3ufYZfOFoERIcWLMBt6E+K/MhAvFp7IQhR0CT44Kbl3vgCWqiAupNCekrIu+05khn9E71oWSgjnU7BiqgppHLDTezp3lWTEii9IIfvCuIITkUoLUNuqGfB4V5/BoAzG4WTNQeAG5dtigUVf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817922; c=relaxed/simple;
	bh=4UTR5+miSiHrXfbDYlarKKdxtXfGT+j44arlZRnS0bU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nXRzlrucZL8Cd/A/V9XyNU3mTE4bndDlHXpkkuNANvIlZFRloyjMpGhGCHRf3P8sWIv3U+Aw3pNcKpb2xtZY5PzW3t1dhD+6DQChF1Trob+axDhH6am/AJGChMuYOUGbKqvyFuiN1XClkookPQnMQ4KrXoW+IGTxYDLYu99+reA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YBZSrh9X; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YBZSrh9X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oeq/9jlDCAuVaCCOk9MwNe1kYEztbeCJGLtoX51uGYgKrAb6GPUVzLLA4rP5qIfxmlwoOEvWywd82g1noiDQb5FuUOwC8+WmUX3N/McRWUgjRJs/ou8pMnAt2thmggcKRgoiP66H7p0FawduSO1pg0P8tU6AqHt12/+T8JNfRua5eKVYGp1gSGKce0DiTn09E2F8+YODm8MfHc1CpB4JwuUQW4i2e7fnTRHNSOFjWQD27576Sv335GgTbqA8IHeDT4BxKyssXwQOhuM+K4mmRGpcsccPF3mroAYDHWF6jbI33FSn2DzIDD3fTXfsmSQupQFytG8S2dUVc0AvFfmoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05JZQD+mclOes0HjIaiGb9YZji8McDS2nkJUlxK8uno=;
 b=EheEPGTOoOjRxqUCp1EMfv8OFF8jaodZj4KK5UALffvkf2Em0W86e5B3x5xMS0+vITEJ6MOKk9OHzUSWS9jWbi5/dpsX1ZlQvggbxvBAeOsdKbIoYdHAtnVUPFQq2O96UxIRVn4T1JfYB+/12mEujUNqJH7GMC97+9KSDbRiA6SaWhSZiO3qnv2+dRKWaQlUPCx8Ll1jZSyyHz2J3OpJg4EwScdqx1xzMdIsTBPGAcZqu1J2W3wwn7VA7fi3WE58LfKAdL5R/Mf+8Yw63x30Rzd6Voq2e3nidP/Am77SjlM4hccpRZXQcmFg6t6B65AFpQWlQk8Q/HFDgaNzvjF6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05JZQD+mclOes0HjIaiGb9YZji8McDS2nkJUlxK8uno=;
 b=YBZSrh9Xx54D7MYgOTGZv43NrOWCF9mzMjJYoLN2V30mpNwUl8E0VGJdqO4pXx5vVMXPzbUwwURX5daX4iZMQR5kCABPOQOrFkcFrocc6LX9uGDmptKNhQ4oYHGC2Nij/YhWbTIh0KiynJGb6uGEvP3nIY8F+AeO2RWjm3A6Jyt56sEvlrQ3AAF5SF79hs9vF94amFj3i24P8TTEBagxmMni+n6pes16TretT6GsI/QmqkSpCxixLlFzhgDcvNVwj1inx8Y1jzeWcTi+RqSrqYnFHr1NSB5Md1JfvHAaIBlI3Py9TErlJbPDH2KOGqk1sQ0t179xP6/oaLm4HZJMWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 19:11:58 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.035; Fri, 9 May 2025
 19:11:57 +0000
Message-ID: <7581b542-e591-422b-acc3-0c154161ab34@nvidia.com>
Date: Fri, 9 May 2025 15:11:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread
 pointer access
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zqiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
 urezki@gmail.com, boqun.feng@gmail.com
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-3-qiang.zhang1211@gmail.com>
 <23f488d7-d369-46f2-8da6-c5fd2af0f9d7@nvidia.com>
Content-Language: en-US
In-Reply-To: <23f488d7-d369-46f2-8da6-c5fd2af0f9d7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA4P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: f39edae3-6aae-466e-17bf-08dd8f2d5e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3g0bnVodHhDTHp1dUYvaFpPNGVZV01qS1ZMUVB0N2Q3a1FHd3RNbW1sbFJB?=
 =?utf-8?B?SVJZNUtjT0FPSXErZ2pRU29tYjJzcnhDSlRZdTVKdDZWOGJJbTNzR1krdmVl?=
 =?utf-8?B?cjRveUQyalViYU5PUDlwS2xON0NOdHFYNEw5azcraE1FbmpMRDYrckFWa2JC?=
 =?utf-8?B?OWhJbHh4bnd1WDRtMTYxVUVvWmdGUmZNWitZZXg1dVBVYnlDcGhvZ0NuNW5M?=
 =?utf-8?B?VElsVDZTUDdHV3IycGtMeFRMdHE4UmRKR1ZvQjJsMjNYUEtuV1I1TGZFNmU2?=
 =?utf-8?B?MDF5eDRBeWk0YldMQzlRa1JoSitWcXhBTnpSRDc0ZHNGUmgrenJiaWExNmZG?=
 =?utf-8?B?d1FuaFRiR3dzbWp2UlMxTnhDdzIyN2xlWDBsak90ODB0NGJXdVo4WEcyV2xB?=
 =?utf-8?B?T2FwOVF4L2I1OEtLUWlobE9iUjVIYmFLeHZLZWtWQVBSeWJsSVdvdnpUcVA5?=
 =?utf-8?B?NGZDaE1yTk5YVmgvK21HbGZZUHk3SGxpamZqQ0Fodkhoc21PT3NWU0tvaXI5?=
 =?utf-8?B?M0Y2RTFlNk45dE5RdnMxTmpOS1VHbEdERitpaVJiSGJpNjEra1dKRkFESjNE?=
 =?utf-8?B?ckJTNXdZUW00QU1hd2VXdkVNMEsrMllWOHRGNlpKMWxLcGhMT1hyMCtTK3Bv?=
 =?utf-8?B?THhMMjZpVUZ6RjNFZldLOXZRdmVPUTN1bC8vdUpDOUtWL3BxVzRCeFN0YU5y?=
 =?utf-8?B?SnlrTENzajNVaDcxbThreDh5OVY2Y0dSSk9xRE1QQkIrdFYwdHNsLzF0WU42?=
 =?utf-8?B?RHFzcFRsdll6YUxrV2k4U09xK0FlbU4vM1pxbFB5ZEF0YXV5S2NwUFluVkQw?=
 =?utf-8?B?Y2J5cTF4Mk5hcFNDUWthaG5JSkN0Ym01NlBTOGxYeExVRzI5NTFrTi9KckxU?=
 =?utf-8?B?dUdreUVvVjM0bzlsUmN5MmltaVpnSVdrN0kramtSODVnTWgxYUExTWZKU0Va?=
 =?utf-8?B?amI4bEltTGt4YmJpWWV1aUNDTlhmUGU3Ry9kSlNGdVdwVnhDU2ZhaDRMK1Fo?=
 =?utf-8?B?UW12QzYvZzByTnFGR3lVdU1IdXlRQ01FajB3ZXJnRlRSNFhxUjJRdWZVd0gr?=
 =?utf-8?B?VitjM3ozOXVXbStMVkFyYkFlTHhhR2tQRkZTT2o2bERvYVNQZ205RENQdnBR?=
 =?utf-8?B?SUl4bXRkay8yZGgvRm15L1NvYTRKVi9GK0taakovVEIxakhwcUhEUXVMKzYz?=
 =?utf-8?B?aXhwaytxRitlL1RUTmo2dVFJZjBFbGE0TFpNOUM4QStOeGZVVWQyRlpVTVFv?=
 =?utf-8?B?T2hrZExNYUpiS1BDa2g4UGt2SVJWNWgzaFh6SUV6VXYwMkRqb011d3p3RXVM?=
 =?utf-8?B?UzgxMlRsVGcwSlpYdFVmNFN2OVdCOWQwMHJtZGNLZ3VPRG1reUdBaDdFQUF2?=
 =?utf-8?B?V1ZMdmdma2preGdGM2ZVTU9BOFYyK0VJYVJvMjVGb0M4aTczaCt3VTdScDhL?=
 =?utf-8?B?QVhlWXlIbG16NWplRHZSNkUxclByTDNFaUN0dUdsdXdmd0ltb05Lbm5mbnk1?=
 =?utf-8?B?OUdQWFVMMG1sYUJZMkE3STAxc3IzeTNLelY2dHRwWUo5UFprWnhaRm1NRXQv?=
 =?utf-8?B?WG1GTDJLd2Z0aTl1dkcxbGMxQjdTZ1lXTXpxNmJLWFdHdXkycDA4RDhWWFZq?=
 =?utf-8?B?bG9pbFArLzVVYWtEMUhCSFFIdUdEZWZZSFB4L1NIblhyMThNenBkZDVjektG?=
 =?utf-8?B?c3JWS01yMGFHTVFDTnVTKzloZm8yRkZyblM0SExGUkVGRE1GVHhhRCtzaWFY?=
 =?utf-8?B?SU5DQkFsQ0huTEhUcFVwUVFtRXlBMUdqWG9lVGxCaTJoNjNOOFI2WU1PeWJY?=
 =?utf-8?B?TDYrWVMrS3pjYlFtMnJQNkJaSERyd0lML0pwcXB0SnhMcTlQd3NPV003cTQ1?=
 =?utf-8?B?UVdjWEZmTDJJZU84Wjl3MmNaYi9peWZ1YVRiM1lnOVEyenlYOFVnOEQ3dElG?=
 =?utf-8?Q?9O5DlUcKYv8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk9uSjNaNnFSdFN6SjEwdlplTFlJYW1UaWd3MkNwVXViUFpzbzVabER2MEFX?=
 =?utf-8?B?UDVTOEY2UW5vUG13cXZabjNkNXhBZFVGWVhGSFQ0ME1pQWozRm5WQW9XdWpm?=
 =?utf-8?B?UElXN1c3VUd3LzROVWNmK1hxeUMyeWJnTTBEd1gzY29MTUlrOUV1aXhjZHh2?=
 =?utf-8?B?VXVCZDgwQUxTV29Uc1d1YmxSMGJ2ZDVzNStBcjNldXRIMndXUWtCdExqMWFL?=
 =?utf-8?B?eFJVRGtGMENqRFFON3c5T0dWVzhPc3Frc1ZNTUV2d2FKbXBDUTFuQUNBOEhn?=
 =?utf-8?B?WFhoMENwanhSaS9JSDkyMkRSTklNL0dSZGRuSVRHMVdnSjhQUS9QaC9lbVd4?=
 =?utf-8?B?VmVVdHNtL1l4UDczQ1U3UW5sUjRQSjNJem9zN0cwbE56SE1uOEdoYjhMd25x?=
 =?utf-8?B?U1VUMXRybFZqZDlMbkVQcFFHK2pYOVcxTC9LZVNXV1AvcjN4OEc5MVlTOWFo?=
 =?utf-8?B?S09zcGVIZG53a1ZKaVZsVHA2cHYvVXRBTGU4NUJ1bHZLRk5DRHJtWUpYRGZP?=
 =?utf-8?B?RHpVK1RobVU0a2loNHZEZTl1bGsyVGpxSk9LQXl5akVsNXM5YjRpb05JZFFk?=
 =?utf-8?B?aDlsRDZBRkU2Q2xzM3VyUlZNZnYveFlBVzAxOGZqM0E3T1BYblM2Y2NYc1FD?=
 =?utf-8?B?NHNTK3JCR3ExMDI2dy9jTjArSC9OdWFIUGJvd0dRVWsra0hYUWwzUXNDeWQw?=
 =?utf-8?B?MzNWbmRvOXhva1ZZdVpQUlY0a1l4SWZFY1lIekNBUi9PS0ZVTFZ1N2VDZ3Bk?=
 =?utf-8?B?WjUwM1dBRWxvZGJuOTE4UmE2c0xRYlBMWCtUMjhPNTBnU1pleUk4K3kxNDlp?=
 =?utf-8?B?Nis5b1JUQUFWb0pDTXRncVhtN0xhcUFERXF2RTJZcURCcnY5emg3RkltcUFN?=
 =?utf-8?B?RFBuU3NZZy9aWXRxL29ZYzlFUmxKeERxVC9MTmRzYTAreEJhUlpFc3c2TzFV?=
 =?utf-8?B?Tk9iY1kxR3owTTMvdUlWUlpncG1sNEpYRURuM2gvWGpyZzdaU1Brdzc4R1Nl?=
 =?utf-8?B?Rnp1b3ZhRXVOOFRvaVAyYXdJbFhlNEZUVVlkOWtmTDF1Q2JjSFB0dVdjbVll?=
 =?utf-8?B?NlBKaEEvRHg3TGtQR2hPSmhqWGxpekNIMWlRZTZML2dBQ1lqeGdNaGI3S1gw?=
 =?utf-8?B?L3M5a3EvQnR0SFR2d2U0M3JzSko5MGxQQjVqSStvSGJVNG9jRW15bXZia1E2?=
 =?utf-8?B?L2ZzaGtjbGhxR2d3WTJHSEhEVVhJU3dvVWFWUUszQzZ2ak92cmZHMmxwRzRr?=
 =?utf-8?B?SHByRVNMTUVZRmUvMElWc0wxakRmL0IzVlM3OGlrRkhvRUJmeVJaNSt4S0xj?=
 =?utf-8?B?Y2VGYzAwY2k2SGZUbXdGclVxUE1Ic2VQVHhrV2Fad0E3cFNZTytqNXNHUlN1?=
 =?utf-8?B?WTQxbkJ6OVp0Zy9KRHlDN2lJWHljcDBnTDB5ME12YTFWSzZ3eTRiSSt4NXoz?=
 =?utf-8?B?M3AvelEvRS9sb1huMkZYSnR1UHdRS012OEpuRzdlNnpwSkh4UEE4RHd0b0tD?=
 =?utf-8?B?ekxQd0drVWd2dVZ0eFlWaUYxOHlhdHZmYU1yVzhCemZEN2QxSnY5RmdNNlQw?=
 =?utf-8?B?WFozZWpvL0V0N2lOcVRyS0lkYitEd3Z6aXExMUpTUENQaE1iT0FOczd5NmhB?=
 =?utf-8?B?Z3pKTkhZY2hLdjhLcTBqVHdvN2UrdEZ0R0t2TnNrYmlaTGtKaHdBK3pXTVd6?=
 =?utf-8?B?NnQyNTgwdXhEL244QzhsMmFWaDhUUi95VEltY3hFMkl1c3B4WjlGM3IxbkQ4?=
 =?utf-8?B?RTh6Nnk0eW02OFR2N0xkWTkyeGRYNUtSOE93TnRwTjN5NC9zd01ENWdlYjd5?=
 =?utf-8?B?RDNwdGVJNUR5NFRQQWRXUGRsQWxLOTQ1LzBjK3R3dStFQU0xUTdINlBZZm4y?=
 =?utf-8?B?VnVDSTNiQkxDd3BuaWViYzUzQllHV3g4enJuczl5ZmFrKytqWDBwQytiN3Z1?=
 =?utf-8?B?V3JKaDN1d0wyVDR0VHVRM0pWSkIzVDY3K1Fyb1RaTXY3MzJQb3BBbkFEUTEv?=
 =?utf-8?B?OXFSUkdUd2pMb0liNXR2eDBPWFkvWXZtbzRPMDRKb2prdURMQmtRV0tidmt1?=
 =?utf-8?B?YW50Q0dEbUNGU05pdUhLazhPL2JzaDVyaWxjY1dqYWVNVk53NW5Oc1VMMWNU?=
 =?utf-8?B?L2E4N3lKaWFWaW9mZnZOUjRSazZYaHBkOGVDRWZObHN5b0k1L0p3MU9ndklj?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39edae3-6aae-466e-17bf-08dd8f2d5e5c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 19:11:57.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fumr/aT/kwUSZ1EZiLm1o2750wWKtuc+OECSdmUsi/u3TDVfJT2jROxyatBg78iME0bJGOtBh8tW68qEEbLjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396

On 5/9/2025 3:07 PM, Joel Fernandes wrote:
> 
> 
> On 5/7/2025 7:26 AM, Zqiang wrote:
>> In the preparation stage of CPU online, if the corresponding
>> the rdp's->nocb_cb_kthread does not exist, will be created,
>> there is a situation where the rdp's rcuop kthreads creation fails,
>> and then de-offload this CPU's rdp, does not assign this CPU's
>> rdp->nocb_cb_kthread pointer, but this rdp's->nocb_gp_rdp and
>> rdp's->rdp_gp->nocb_gp_kthread is still valid.

Maybe I mixed up what you're doing but this commit message is a bit hard to
parse. You're saying in the problematic scenario, "rdp's->nocb_gp_rdp" is valid,
but in the patch below you're checking for "rdp's->nocb_gp_rdp". So I am a bit
confused, why you would not run into the same problematic scenario. I think I
agree with your patch but it would be good to refine and clarify the problematic
condition, the commit message, and also please add some comments to the code :).

Do you have a reproducer for this? If not, maybe we can work on some test cases
Both CPU hotplug and offload is tested by rcutorture, so I'd expect we run into
it. But perhaps not, because it requires kthread creation to fail?

thanks,

 - Joel


>>
>> This will cause the subsequent re-offload operation of this offline
>> CPU, which will pass the conditional check and the kthread_unpark()
>> will access invalid rdp's->nocb_cb_kthread pointer.
>>
>> This commit therefore use rdp's->nocb_gp_kthread instead of
>> rdp_gp's->nocb_gp_kthread for safety check.
>>
>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> 
> Is it possible that rdp_gp->nocb_gp_kthread is valid, but  rdp->nocb_cb_kthread
> is still invalid (because its creation failed?). This seems a bit fragile to me
> to assume that if rdp_gp->nocb_gp_kthread then rdp->nocb_cb_kthread is valid. Or
> is there a path that makes sure this invariant is always satisfied? If so, can
> we add additional warnings for checking this invariant?
> 
> Also from the other thread, it sounds like there is more work to do here
> (related patches so I'd like to defer this to 6.17 - feel free to keep posting
> patches for this work though).
> 
> Thanks!
> 
>  - Joel
> 
>> ---
>>  kernel/rcu/tree_nocb.h | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index 1596812f7f12..6679140bb0b5 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -1146,7 +1146,6 @@ static bool rcu_nocb_rdp_offload_wait_cond(struct rcu_data *rdp)
>>  static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
>>  {
>>  	int wake_gp;
>> -	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
>>  
>>  	WARN_ON_ONCE(cpu_online(rdp->cpu));
>>  	/*
>> @@ -1156,7 +1155,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
>>  	if (!rdp->nocb_gp_rdp)
>>  		return -EINVAL;
>>  
>> -	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
>> +	if (WARN_ON_ONCE(!rdp->nocb_gp_kthread))
>>  		return -EINVAL;
>>  
>>  	pr_info("Offloading %d\n", rdp->cpu);
>> @@ -1166,7 +1165,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
>>  
>>  	wake_gp = rcu_nocb_queue_toggle_rdp(rdp);
>>  	if (wake_gp)
>> -		wake_up_process(rdp_gp->nocb_gp_kthread);
>> +		wake_up_process(rdp->nocb_gp_kthread);
>>  
>>  	swait_event_exclusive(rdp->nocb_state_wq,
>>  			      rcu_nocb_rdp_offload_wait_cond(rdp));
> 

