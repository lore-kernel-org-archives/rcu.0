Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBBE2746C;
	Mon,  7 Jul 2025 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751857696; cv=fail; b=IFzBN9krcm16bV5jt2lqwfPw6WimpASfdpsqy4wJMwWzl1XpeD1hD0W6rO1fwp/fq28K0zWaFnUc1/4Kd8IlAySC0I4+UmtzQQds1fn93paQlrXsGnp9kFiOd02vzdAEgdlkhuPsyISLSFw1iTM9f6XPxzK6orIpNwL2VUvDPZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751857696; c=relaxed/simple;
	bh=5yXfaGD618ZHMtM1jMPC9pSBD9yFkXDb3u0wHQ7PUy4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MgOG5yaH9iKyPNwlHLNjjVB9+UErEcCtzsw7j2eABe77pPjjEZbYeIS8EB6Fw4S+aMkCMowwXgX5PqU1smWqGYF/CD/zp0Qs0VobNaI0Tj7ERK5TrJbADH1GhaH/MjeIyCsaeAhnZjiIJuSahoqQEhDuShjGuJKcCknkW2hK7c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q+MLPz+Z; arc=fail smtp.client-ip=40.107.95.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q+MLPz+Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8/SZy88D4W+ADz66u9r3lIeZgYoq3Ff1ENNU8FsrKZbdHACylX009UCieglGNNaTIEn0zBMM2Dcm8mhqFtLtwb/LR4C3FO2Fn27bLUJi9tFZCcPcUvrX221wd4a573/fsNsz8kvXADnRAWOeiy93UWndsycDTH9Uyfr/cgJ9HW/sUkB7nJ5uDBbb0uBTOj7m2g7FbemoVus1CW2EnCQrA0rQ8LqYcRgFA8/6sxeDK99a3OVtUsFOu1rkjKlLs7JZ2+RfJIrBJyvlB+CkyMu4D6ok0LRy4BmMJDqzQVKGi2mp4kndQDKn/AMCtuex8r/g6Z4PRPOYZSW304X8COIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mqo+6tCkeWhJmFbVk588idnFOmDdOhsiQ9jyvdX3D9E=;
 b=VeKi0W2P4kKYF01kVKjK0DkOGQ98qi0urLoCrCUaGAlbOImyMHc3BiU59Uv3zWt/oMMNGlM25ULN134zW6EoBKzauFaMWhRTdkjLjb35+lBjl/L1RNPuIefapNCU+3jAQ0xD+T4A4WRbOvyuKoyKVaFPjOA8RjAIIOVcpiPWhpdJvykMbvIkylwktQ962Nexa8E/VWXEUMMMOAyLaM+Fu1m/WLDTPoZqFw2+itBJbLVBy7lBGYFyXYo1wlLvwlDlRoCAOvwSa2zmO4IQm66b5RugyWtRoj76NZcZu1AyagE1JAjueRkaUOG+UVCOKfJ3XseDAelEBTdumt0IGzUOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqo+6tCkeWhJmFbVk588idnFOmDdOhsiQ9jyvdX3D9E=;
 b=q+MLPz+ZcFwvIetNxYAWKdBVS74ZwcicDehI19vJDwgc8PRAP5hgLNGH5k515b06xoeS+jrZM3+CN0376l2byBjHOrq5MA4Q7kqsBh/fTH5MMpFjf9gj2d8zm2jYZUlm9YBBc2I6n8fWRgEuBQxb+O7hm8pDuwiu7v017E8cX18i21dYZMaAM2aYYsrJ88BBJsnweZeLc5UvwX/j6SUGOTQKhQmwaoZpmpuppoIHwawFE+tYcc3Yor6Urx0C4yjc1icDDyEkKiao7hyX7m/pKEyoySATdEetriXyvd/hH+0aF09SzMNlVeNf3ZmeyJW4DAmjk6E7Rs3Farnb+wxPJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Mon, 7 Jul
 2025 03:08:12 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 03:08:12 +0000
Message-ID: <58f405af-22a3-4d2e-b06c-d8572b38df40@nvidia.com>
Date: Sun, 6 Jul 2025 23:08:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
To: Qi Xi <xiqi2@huawei.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
 ankur.a.arora@oracle.com, Frederic Weisbecker <frederic@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, neeraj.upadhyay@kernel.org,
 urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>,
 Xie XiuQi <xiexiuqi@huawei.com>
References: <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
 <c448118b-9f7e-4c29-d6b3-a66e70f7163f@huawei.com>
 <a963b475-72cd-474d-96d4-9e651fc8f857@paulmck-laptop>
 <e7354668-2573-4564-834b-44d76d983222@nvidia.com>
 <09e4d018-3db4-404e-a8f0-041cdee15a62@huawei.com>
 <279d2f06-d4f7-46e1-9678-999a2d19b710@nvidia.com>
 <506d8c4e-c317-4c85-9bcf-695596551d28@huawei.com>
 <166bc5aa-a715-438e-8805-c74c2b5fc83b@nvidia.com>
 <c16ddb6e-73f1-4eff-bbcf-c03b95f79fdf@nvidia.com>
 <8f5925c1-9553-63d3-d5a0-387c2395963d@huawei.com>
 <20250705131230.GA4059783@joelnvbox>
 <40dea5dd-7ca2-4bee-8ca5-bb1df8b3750b@huawei.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <40dea5dd-7ca2-4bee-8ca5-bb1df8b3750b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0007.namprd14.prod.outlook.com
 (2603:10b6:208:23e::12) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be918ae-40e5-45b6-76b7-08ddbd0381fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3gxRXhaNGVJZlp4cUNOZjAzMlgyZzZjT3ZiMjNwRlVjWmdFRHNrRk1OWDl4?=
 =?utf-8?B?b21tVG5MUzJDb29iZlByYUJQdUI5QUw2MDRSd2V3NlpPenluaUl1Nk41ejNO?=
 =?utf-8?B?a0JzeVdWMUxRb1pROEx3aXV1Y0NiTDI1VmpBajhFckVIK09EWVpuZS9DTWxz?=
 =?utf-8?B?Y2VoTE5STW45bjFHT0FVemR6VTBuYzhpUTRtS3I4NTZHMFh1L0RSMEZiT2ZT?=
 =?utf-8?B?Q0I5ZWhuWG54NWdaNUdiZ2dndjdsY2hkdXlaM2NOc1NwNWhKQkpGVExjT000?=
 =?utf-8?B?NnZGYmtGR2ZNTW1BK0daSlRpcHp1eHVSRFV3L3BJRVY1ZFozV3lhRlIzai9J?=
 =?utf-8?B?QkdMQmFEbUgxY3VPWklUMFZ2ZUtuNkQrU3BhYXpRcjZrejRFdE0vcFltamth?=
 =?utf-8?B?OHFmMWdFM0UvMkJVTWFYTEZVaUlxVmUvWEsxbnlIVTJPTVYzY1B1cldYT013?=
 =?utf-8?B?SVdNdDc0dkVpNTRUdjV0eHNaNUtVSzNWVlJvMHpDSThDYzZpbVl0bkZ6Rkgr?=
 =?utf-8?B?T25Gak4wMVVLQVQvRUViVnpFNG9IeklyQlJveVJVZ1ozM0x2VDdRTXZTNUVS?=
 =?utf-8?B?bkFQVVdXYjJYeVVtR0RPVkp6Q0ljOUliSWR4VTY3ZEF2YmdLdmxBSXRERlVP?=
 =?utf-8?B?QmF2OGhOUVk4eDlidG5STUgvb0p6eTZpY2ZVYzM5YllFbWJDemppQ1laK2RO?=
 =?utf-8?B?clpINm9pZXRxWXZ4dEZGSTBUd3B4SEdtTTVyMVQvRnMrbW5Hek96eWR1K056?=
 =?utf-8?B?N0tqUEFDRW1kb3k3NDY1SEZGSGt3R0hvVHlQY3N5MVQ2dnUvVEZmOHhGVm5W?=
 =?utf-8?B?cEZDNW1RZXMrSmN5TE1tenUrQ0dTdTVWbDhVak5MNk80UlVxdUNJNVF3eDYy?=
 =?utf-8?B?N1F3eFlwSTNWMWVtM1JMVEs4c3AvbFYwdWNKWGFxR2trQ25UUDNEbVZVMlh0?=
 =?utf-8?B?cjU0SzlVNUtTWjVXOVl5dXQ4VjFtdGJCRkFqOCt4YnNlcStYbTc5aGNXRCtl?=
 =?utf-8?B?b0dteWpYbTV5Y1VpMGRwdTZ1S0JMTjVrdWVwU0FmZmxqblpSY3FnUS8reVJM?=
 =?utf-8?B?MGVMSTQ4THhXR1M0KzNUcWJtaEZhMy9WdEdBemZzWnRkVVlNZFhlNnZaRUVK?=
 =?utf-8?B?ZHVQbnhlK1ozaFh6djNGaWJsckxsaWphQjN6bTc2djFGOEhhZDVxeDR6dFFx?=
 =?utf-8?B?TkZOL1FYRlU0VWhoMW03bHU5dUMrSGdhK2toRTZIaUltdUdQRlVvMVQrZEkr?=
 =?utf-8?B?eEVlMXViZlhKaS9ZMlRZMG9VcXFydWFvTUMybENqZy9NbmxvM0E1ZFZEa1M0?=
 =?utf-8?B?eTkzamVLb0V5RDFLOVlyWXJuMFNPNlJ0MitKQ3hBNFRwRFAraUhwL0swWFlE?=
 =?utf-8?B?QXdibjB5aW5HNVBGRmJUZnV3bnF0Szd5RTRERS9peVlMRGZPNUlscC9hNHNx?=
 =?utf-8?B?YUtBMHNUTzN5cGhEMnl1RTE0ZGVGc1lYU1RWdjdCZTFHTVNwbTd2bWVnVDFX?=
 =?utf-8?B?ampheTFaV2x2dUp0dlJTeHVlajZIc01BbFBoWUxUMitLY3B3VktSZG9UcUZi?=
 =?utf-8?B?Rm9OclVpNEh6TXIxdU1vZ3drUEZhdUZ0TWRZa2NtUXI1dHpaL0ZPR1RLMTNK?=
 =?utf-8?B?ZG54b1FheE5CaFovSWdDK1dOZkk4UDdwRm9MbmkwOTVqTTFtTTgxQXErT01k?=
 =?utf-8?B?RE9HU0RyNERPSTI1SzJNM3k1bTdaby9mSVdLUzNJUExsZEplMTN2QmdXaml1?=
 =?utf-8?B?SUl3clp2Rkd3Yk1td1Y1Vi9heUJTRDNOM0xZeHkwNEQ5UVl6clZMQnJ0bVBx?=
 =?utf-8?B?bFJMMGZIZ3IzdU1HZTJJVHN6ZUdPcFlBQmJRNHJRdGRHS1R1bDBrcUZSVUtt?=
 =?utf-8?B?Z3BSTnc0S0V4SEhzT3dhOVBNN21Ndm16QVN6UXI3OERDWk9zd2tkaXc1dkt6?=
 =?utf-8?Q?jyoTy1kqA30=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2RNaDVnOHBaaXFpYVhSMmpoOHpIaEFNOC9RdVVaMURYYlRXZ2VSd256ejY3?=
 =?utf-8?B?OUZkSGtSZ1ZMdU1MdmpFc3RvVVdRa05KMC9XS1B6M0g4NUlKN3dmUCtuazU5?=
 =?utf-8?B?TE92WlBXdXlJYnRyV0FDSlRaZXhJZzAvZEtPRm5VQldkUWRYRUpyc05xVEMv?=
 =?utf-8?B?c1kzN0FJdWdHbnBVSlRHeFBVOEJVVjJWVFZtMjlYNzg4bHo1OW9LbWZOUkRK?=
 =?utf-8?B?dUpxRkxlNTVUVFM4NVB5RFJkeGF0MTNFbzdpeldvbnUyajNaY2llUFg5UmFV?=
 =?utf-8?B?ZTVZb3BPaDdHaVFrMXRieDRNLzg5cGFBWE5CWWpSQ3hZc0NsbWYzTmsrd1FD?=
 =?utf-8?B?VFlCSnYzdlNhN3k4OXAwdWJqdEY0N1pFWDI2NXRQOFZ5V0p4YisydHRNUzVU?=
 =?utf-8?B?T1JoN2tvRE0zSksvTmczRWI0d05KVW9Sb1dWcEpLbnErYWRJN00yN1dtZ2ln?=
 =?utf-8?B?b0loUWxDRk9KbncrbkMwd09kZUQyYzlJZVp5YkNpanhiU0xOK3RIeU9iQlhO?=
 =?utf-8?B?K3BLZkV4SmI4bzBNL1lsbzhXR0d1RTlGYUcxSGJQNU5oSUp6OEVURVh6TE4z?=
 =?utf-8?B?YlVUQkRFcnpGQUxDYlB3VGdWOWVPMzJZYmwzeDdhVmtEbWtRQU5oV2xEKzZa?=
 =?utf-8?B?UHVnZEFWVC9pUHBLbnBLRzRvWXpCL3R0THo3cW5sdlI1VkFoTEtncFMzYVA5?=
 =?utf-8?B?RXFqRVE0RXhHc2QyNUttamdRNXpFcWtOZHE1eUR1VjN5bnJFem10Z2dzd0tV?=
 =?utf-8?B?SVhDS0VBckx1bkVLbjcwNUhNTzFDNTlkdFg2aGtFYnNmNThuZW9iU1NxaitH?=
 =?utf-8?B?WVR4RGdzUTIzNVhhYys4QUI4OEpHL0x5cnBsbFFmbllJQ3MxY1pzM2RjMG5l?=
 =?utf-8?B?U2d6SG45aWhGU3FaYkhNdlNqcm9XTjJtZTlWK0F3NlhOdkIrdnh0S2VHVnI3?=
 =?utf-8?B?ODc2K2Z3QUJpT29sTG4wQ1FVVU1tWnI0ZDhuQSsvaTYzTUthdGtnOFhSd0xi?=
 =?utf-8?B?ZWZldzl2SEFnRmZkR0ZaK25nblhZQ1VGUWpVQ0NnQ2NvWnNYUmY0cU9XZ3pm?=
 =?utf-8?B?dmdTUGcvOHNWNy9aZ2xCUTJzUWJtVjNmVkxSMXIvbGFWUGFwd2loYU5SaitJ?=
 =?utf-8?B?aklwRzB0bXRkclM2WTE4bUFuL0VYSGdZYVB4Y05EazZYalZzOFErMWZvQlZ1?=
 =?utf-8?B?NDJxODU4R3dINEtYZEdFMkozYzE5ZCtRSm91Ympkb2o4WDVpVWdFa3pmVFFE?=
 =?utf-8?B?RDRLY0UzdENQemsrOHM1WFFON2pndC9KZHRXNmtRUEg1UU4xczRTdUNvMGRl?=
 =?utf-8?B?RHdDZjdFWjY3SGprbUdjQmI1MmNya0s4ZS94Zy9BME1acVBPb3FGWVBPZ2Mx?=
 =?utf-8?B?VlpSM3BEeGRZMVlVVUNxVkpBTnlvNDkrcS9HOHAzbDRZVHhseFhGcUQ0MGxX?=
 =?utf-8?B?QTJoS29uQzU1K2xBZGJkelJqc1h4YmpGZklKb0dkb1UzRlV6M0hnK1kyQS9E?=
 =?utf-8?B?S2hVZ09LQy9WSFFZWHMvUVhzM2MrZXRxWTl5KzZUclJMNFZlTFR6NitIcm5W?=
 =?utf-8?B?emlSdU1XbEJXa292RjNoVjV6K0o2aFV5eWxBNkhXTjc2anFJbTB2Tnc5RzAx?=
 =?utf-8?B?bWM5dFBCMllzcFRuaythcEdKTEFleWJxUTl6Z2kwREFKZHFPRTZ4UGRPZXlT?=
 =?utf-8?B?elV0Vzd2S2hSZHZjRlV0VjIrZWJXT3ZZVE55Z1o3MzlXbm43QUpXZlJkOFZM?=
 =?utf-8?B?VzBEVWVkSmdFYy82MG9RSFhRR2crZFpHdm5IWWFPTWxCWkZVcjk1enJHZTBm?=
 =?utf-8?B?dlJ3R3FvaVRXZUV4RjNYWFZ5UzZlY3N0a2VsQlFDS0xvOTZDS3JVSlBob2tH?=
 =?utf-8?B?K2h0VE4xNWlJM3k5eFZObFlQak1qS1JuVE9vZ2p0RVQzQjY5dlY4d2FyQnlt?=
 =?utf-8?B?eWJpZzFXMU50WmQ5Rk80aVJrc2xwV2xNZHpxaXBhdWwyWk9wTEE2eGxEVTVO?=
 =?utf-8?B?VmRhY1hmeVVWSG5NWnF6VmhPVlp5U2VVZ1VnaG5aUDh4RjRPMjR4WUZsMjZH?=
 =?utf-8?B?bkI5RUN6L3gzZGtTTHQwK3dEQWFXOXRJQzhUanplSHo3aWNQYUlMdTJtNGVi?=
 =?utf-8?Q?1l1z4aeTphlGVM32tOtaQ7KE4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be918ae-40e5-45b6-76b7-08ddbd0381fc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 03:08:12.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOhC35QN73rRUw1UzAkKEihYnSeTSVmJutTSXQFwEc5GB4/0ga7D4UKQEkd4+mdjgoQQORDWIeVqSFJ3Eob2MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222



On 7/6/2025 11:06 PM, Qi Xi wrote:
> Hi Joel,
> 
> After reverting the previous 2 commits and applying the new bugfix, the problem
> is resolved now.
> 
> Thanks for your help!

Thanks! I will add your Tested-by tag to the commit and will post for further
review.

 - Joel


> 
> 
> Best regards,
> 
> Qi
> 
> 
> On 2025/7/5 21:12, Joel Fernandes wrote:
>> On Thu, Jul 03, 2025 at 09:04:31AM +0800, Xiongfeng Wang wrote:
>>>
>>> On 2025/7/3 1:24, Joel Fernandes wrote:
>>>>
>>>> On 7/2/2025 6:59 AM, Joel Fernandes wrote:
>>>>>
>>>>> On 7/2/2025 5:14 AM, Qi Xi wrote:
>>>>>> Hi Joel,
>>>>>>
>>>>>> After applying the 2 patches, the problem still exists. Compared to the
>>>>>> previous
>>>>>> fixes which did solve the problem, the difference is ct_in_irq() in the first
>>>>>> patch.
>>>>>>
>>>>>> I am wondering why "nesting != CT_NESTING_IRQ_NONIDLE" is added?
>>>>>>
>>>>>>
>>>>>> (previous fix: problem is solved)
>>>>>>
>>>>>> +bool ct_in_irq(void)
>>>>>> +{
>>>>>> +    return ct_nmi_nesting() != 0;
>>>>>> +}
>>>>>>
>>>>>> (current fix: problem still exists)
>>>>>>
>>>>>> +bool ct_in_irq(void)
>>>>>> +{
>>>>>> +    long nesting = ct_nmi_nesting();
>>>>>> +
>>>>>> +    return (nesting && nesting != CT_NESTING_IRQ_NONIDLE);
>>>>>> +}
>>>>> Oh gosh, thanks for spotting that! Indeed,  I had changed it to != 0 in the
>>>>> last
>>>>> version but applied an older patch. I will fix it in the tree. Thank you
>>>>> again!
>>>>>
>>>>> Neeraj, would you like this as a separate commit that you can then squash? Or
>>>>> could you fix it up in your tree?
>>>>>
>>>> Qi, Xiongfeng, I am currently working on alternative fix after discussing with
>>>> the crew. I will keep you posted with the fix, and would it to be good to get
>>>> your testing on it once I have it (hopefully in couple of days), thanks for the
>>>> report!
>>> Sure, we are glad to help test once we get the fix patch.
>> Could you try the following patch? I tested it and it fixes the issue for me.
>>
>> If you prefer git, then cherry-pick the HEAD commit from:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=rcu/
>> irq-exit-v2-no-task
>> (cherry-pick sha a58cc91fdca766cb719fb8beee3bb10ffe8e9d58)
>>
>> ---8<---
>>
>> From: Joel Fernandes <joelagnelf@nvidia.com>
>> Subject: [PATCH] rcu: Fix rcu_read_unlock() deadloop due to IRQ work
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>   kernel/rcu/tree.h        | 11 ++++++++++-
>>   kernel/rcu/tree_plugin.h | 29 ++++++++++++++++++++++-------
>>   2 files changed, 32 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>> index 3830c19cf2f6..f8f612269e6e 100644
>> --- a/kernel/rcu/tree.h
>> +++ b/kernel/rcu/tree.h
>> @@ -174,6 +174,15 @@ struct rcu_snap_record {
>>       unsigned long   jiffies;    /* Track jiffies value */
>>   };
>>   +/*
>> + * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
>> + * It can be in one of the following states:
>> + * - DEFER_QS_IDLE: An IRQ work was never scheduled.
>> + * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
>> + */
>> +#define DEFER_QS_IDLE        0
>> +#define DEFER_QS_PENDING    1
>> +
>>   /* Per-CPU data for read-copy update. */
>>   struct rcu_data {
>>       /* 1) quiescent-state and grace-period handling : */
>> @@ -192,7 +201,7 @@ struct rcu_data {
>>                       /*  during and after the last grace */
>>                       /* period it is aware of. */
>>       struct irq_work defer_qs_iw;    /* Obtain later scheduler attention. */
>> -    bool defer_qs_iw_pending;    /* Scheduler attention pending? */
>> +    int defer_qs_iw_pending;    /* Scheduler attention pending? */
>>       struct work_struct strict_work;    /* Schedule readers for strict GPs. */
>>         /* 2) batch handling */
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index dd1c156c1759..baf57745b42f 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct
>> *t, unsigned long flags)
>>       struct rcu_node *rnp;
>>       union rcu_special special;
>>   +    rdp = this_cpu_ptr(&rcu_data);
>> +    if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
>> +        rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
>> +
>>       /*
>>        * If RCU core is waiting for this CPU to exit its critical section,
>>        * report the fact that it has exited.  Because irqs are disabled,
>>        * t->rcu_read_unlock_special cannot change.
>>        */
>>       special = t->rcu_read_unlock_special;
>> -    rdp = this_cpu_ptr(&rcu_data);
>>       if (!special.s && !rdp->cpu_no_qs.b.exp) {
>>           local_irq_restore(flags);
>>           return;
>> @@ -623,12 +626,24 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
>>    */
>>   static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>>   {
>> -    unsigned long flags;
>> -    struct rcu_data *rdp;
>> +    volatile unsigned long flags;
>> +    struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>>   -    rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
>>       local_irq_save(flags);
>> -    rdp->defer_qs_iw_pending = false;
>> +
>> +    /*
>> +     * Requeue the IRQ work on next unlock in following situation:
>> +     * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
>> +     * 2. CPU enters new rcu_read_lock()
>> +     * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
>> +     * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
>> +     * 5. Deferred QS reporting does not happen.
>> +     */
>> +    if (rcu_preempt_depth() > 0) {
>> +        WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
>> +        local_irq_restore(flags);
>> +        return;
>> +    }
>>       local_irq_restore(flags);
>>   }
>>   @@ -675,7 +690,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>>               set_tsk_need_resched(current);
>>               set_preempt_need_resched();
>>               if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
>> -                expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
>> +                expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
>> cpu_online(rdp->cpu)) {
>>                   // Get scheduler to re-evaluate and call hooks.
>>                   // If !IRQ_WORK, FQS scan will eventually IPI.
>>                   if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
>> @@ -685,7 +700,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>>                   else
>>                       init_irq_work(&rdp->defer_qs_iw,
>>                                 rcu_preempt_deferred_qs_handler);
>> -                rdp->defer_qs_iw_pending = true;
>> +                rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
>>                   irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>>               }
>>           }

