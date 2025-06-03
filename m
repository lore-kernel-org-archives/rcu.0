Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3F4C92;
	Tue,  3 Jun 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748978570; cv=fail; b=bUrp1KPS1gAz6YcBEmjPgAiW4fUhuTdP93vwj7ZayZneMWiyM5CEn47Z3pnpT4tR2DkAGNwvw8ji4CLfwlSZeLMZuYH7U2gSyMfiw3JFLMh9pVTdG3HEN/WZnvfOWX6+zjLeVxCm8tcYAEMVesWB13E8+cF9fW01GG4Tm5XZzs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748978570; c=relaxed/simple;
	bh=V8Vl02DjhHHeYFTCVy9OoI5IQgZBuWu75Qr7m4552yw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s5fSI88ipsZbZx08MoTVfQRDf2V0ejZAQMbqHCxP1cPMo8YHhE1Ja3aopjf/sivQ0GLXgt+wM6nMs33w6JYsG6LaoZDcCjNpA5Fosk+wy8jg4buRMQS1cCmATFiGFSPW3MmizAbPql/Qb/7tdCECWiVCdzEgLOsfc/KUzewWKBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PdFbTkov; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PdFbTkov"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3pPXE+4V2nizfGuZCL4ha4yyWDMBfOrJWH6L6bsXu6Goa1JP/DplqSQdrCHmQbAtiPqsesVhKsFJIansB1wEkSSfYOMwaaa3AYCG2YxNtGxiOL7Xz8t0RmDBoa9ZOTs+XoRHsL6lNkX1Z/ol//WURo+HZEmzbT7B9a6etdpvQCmvhW9eyfjt40z8z31/dCzQcsQG84HJ0EnIKQLxu9sqw+vcGwOzaXV5T8wqNyA4Kou+c7rtbxvyS5wDxDINXRcf+S2JstWFn/IXCWetGoGaaMLbV6Ugi7IPtdHFcpaKi2ByG+27b/j5fd3vxV5MrTiiZXso41GUk7uJSldQ2SJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqQWaZliPJLyopHnRZ/mViIiUeHEllOtcZVEPugHBF4=;
 b=t+Grz5veDn+QPa4ulMwTw6tY7UsAH6WrLstOALR/m4PiNsUg47XxDx1CK3Ps3Ech/6H2Eb/HLwmWjCCx1upm0DEXvwivINnQKFBnqqWYq2oS66eX4OfKc1DXFpOBxV5wMLsxIdmRSTVviEEQTXp4UI5ODNYpCACuAgsxivkmD0mqzF3mFHw+osbvjuvEAY5X3Da5JMgmq/33nfg4dphpBYdZS9jMc0NNwTytu2UEFSaFgplVOlwrORyuidHFVGoA6EshjXGcK82Nl92RDpE0At9oS/IvQCm6i7F1Gl3W3fevLh31Ullcca+fA9saHNppR1jLc/U5UAIzZ5GXD1B+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqQWaZliPJLyopHnRZ/mViIiUeHEllOtcZVEPugHBF4=;
 b=PdFbTkovlxKJYlPkzlBR1ud6Q0inUrcVsGPO4q6xjulE75znoMB4vI0wszZeca1Kou4dtl66QIXHyelSzgEljnFGCYdGVWWJKCVZy2D73wZgYisoO7QF4vSNb91DnT92n70i01j1/83LQ/tL+AOc0RbANb8J3vK4hqyBqeqh5Ve3BIUiAKo2UMUijjIutq+hvPTq1KR8bJ0MDbzC7HRxIOcA/gG9fvXsFbMgWLPVHA9anwV6CtlqrSeJim2VPmEmvsNML5PWRn8ZY8ydP/T4r3FGFI0b/NKfyKxio1Zq+Zh6EYOuQbGkDNfpuTzKz4VqBfbtZz3IjjMyUaAxWGuyUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 19:22:45 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8769.025; Tue, 3 Jun 2025
 19:22:45 +0000
Message-ID: <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
Date: Tue, 3 Jun 2025 15:22:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, ankur.a.arora@oracle.com,
 Frederic Weisbecker <frederic@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 neeraj.upadhyay@kernel.org, urezki@gmail.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiqi2@huawei.com,
 "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
References: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
 <CAEXW_YRC=f6i3KOd_uhuH=xAOCG7mW7-LwtA4+_fc8FMjfRHeg@mail.gmail.com>
 <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
 <20250603185939.GA1109523@joelnvbox>
 <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
Content-Language: en-US
In-Reply-To: <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:208:23b::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA0PR12MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab65855-d0e5-424d-ab20-08dda2d404a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1Raa2NJQTBDeVA3a2g1UjNWWG9aajlyODdnUFhrQ2lGMDhUaEVPUXVTYVRT?=
 =?utf-8?B?bUJSaDJrMlFNTjljd3FOOFhzREwycmptaXRSa0N3WEN5Y0ZMTzhlQjJrTi9V?=
 =?utf-8?B?MjdOemY4QWlkdjluYVF0TWNHRGgrRE4zTUJvWHUyMzFHSDhicXFLVE9iR3hj?=
 =?utf-8?B?cjVrbFZhb2daYWZFTVRhVGlGa0FhSURoK0ZyZCt6Z3JrZ3NLQW5FMUxobzlT?=
 =?utf-8?B?eFhIelNnTUFWL0lTU045dTgvQm5mVXBhNEh0VkZNVU8zd2VzQlZMRHJ3THFq?=
 =?utf-8?B?TGFYMGs0SzFIS01vb0k3bVRGRHVOUWNMcHdwSEp4UFpjb1VtY0dHaXp3d0JW?=
 =?utf-8?B?eThzNXYreVhyaFVEODVGOVZXdUR6QUEyZFBSU0ZsZGMwKyszUVFGdGdFSHNB?=
 =?utf-8?B?Wm1uWm1CRDJkbnNVak81Qmp1a0ZLemsyYk5oZDVOdXB3T1FLUVlZQjcrQ0lD?=
 =?utf-8?B?VTlFdTBZY2ViaEZZUlI3MU1TeTNqbmVzRExiRmNWK01JTTY1dW1tQmpVaXkw?=
 =?utf-8?B?NTNmTm1sdlNSVDVXVzNYYzN2b0ZkRVFlWXFMdTJITjVLaVNjYzFnMjA0RDE4?=
 =?utf-8?B?RTdkVmFBcHE3ZytHOFdBWVRwMW9WTzQvUk9DcHFlTUZpNU9HNVV0ck1pMWMz?=
 =?utf-8?B?cGYxZHNNbHlZcElzeUo5MU02ZTNRK0t1U01ZbGlSb0JLWWd2S3A1eDlFZ2Zy?=
 =?utf-8?B?dmhKYTNvYkVCVjBob3EvZEZOSXBWWCs2MGxxRzBTRzdOemgrOHNXUGxpMytW?=
 =?utf-8?B?ZGNIdzl4dmk0OUl2bmNFcC9BSVN1eFlERE0rTFUzaS9Ha3ZrS3pIVGp6ZDVN?=
 =?utf-8?B?bXBnUnN5NFJ2T0ZmREVqUEtQK3ZDZmJRVXFIaSthdWU3Z1NHOGh3NWd2Qkxs?=
 =?utf-8?B?akxMenBVRGppdFBSZzRnODhqckpVODA0Z2JTNXV0TEVHOFQ4eFdWNVJnMFhj?=
 =?utf-8?B?NDBRQ3UyTnEvYWRNRDlZL1hHNWpxL1U4N0pQNlRVeTRpcVczaGI4d2h1cHlu?=
 =?utf-8?B?dlRZS2xNc3IvaENpM1E3UzlkN0h2TElZcFdzVWh1SEVMVlZsUmhCb0FBL3p4?=
 =?utf-8?B?Vjd5WWhKUStmQy92QVBvMUcyd0cyN0NNRlFsQktDVDhOZStrQmZ6Y2VxV2Mx?=
 =?utf-8?B?RkZNMzU2a1JEMHBiTzNTK1VmNGNOMlBJMWpubVJTVUxZRmZwTGlrTVE2RHVS?=
 =?utf-8?B?Tkt0dXhOQVF6VW85eU5vblVCY1kza0ZKa0NIY1ExY2xsUis1YzV1RHhqVGF5?=
 =?utf-8?B?UmcxdU9NVVdYQjk5UXNiUFZSUUVHa2s5Y1N0L3VBTG1nNEdreGkzVndPSVVo?=
 =?utf-8?B?R1FVM2R2STJzVXc0aE0yZjNnQ1NXSllqUGJJUGxvMkovMXYvM1JPSlVCMjFH?=
 =?utf-8?B?dGxtUkQ1V2RzSXBnZTdhQUdKUVBPakxRQ2l6U2xleXgvNHhyTFpHV29lekxD?=
 =?utf-8?B?bWpSVm4zQXNRdXZSSCsyM0xod2VaWmFHMXhwTFpwVkI3WVlPaWhDVzFNc1Nj?=
 =?utf-8?B?N2tUVzJndjVlUUNDNUdzblNFZUx6c0QzTnJQdlA2OWdlVFo4QkxIMnFiWVNT?=
 =?utf-8?B?QnlxUzc1dEdpR1FDRE5YV25pTzcrZUw0U1pVT2FZT3dyUDBiL0tpN0ZqTkhG?=
 =?utf-8?B?dm9nOUk5R3NZUUZLT0lVald2bkw1V0pGRUdYcnB0citaUXpZSmRnQVJ3MTNy?=
 =?utf-8?B?ZmRxOTVTK1pKdUtEbjNocFA3aGNUK2IwUm1xQXY3ZGxkL0w1UlBYanNlRzhE?=
 =?utf-8?B?anFQSXJqdFhUWVdLUzRNS1VvU082K0xxSmRVcXFUYUZIY2VSdHExQnBsV2Vw?=
 =?utf-8?B?N1dISWZnazB4MjFxRFZuNjJQSFpUYXZ1QkJPUm14SG9VdURrM3N1WkVKQWZ0?=
 =?utf-8?B?Smg5ZEJEeU1EVHk3Vm5qWEd6bERUZk5ZTURmR05NdU9STVpHMFliSjFkTkhU?=
 =?utf-8?Q?Ci65DpgH2E4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHZOYWRPRktIcXJLZnArVms1WXNYbjl0UUg4R0xVN2hlTm0xK2QrSFhZRFpT?=
 =?utf-8?B?TGVwc2t2bUQ1azZhSVF3WWhyWlBaSGV2WUZlbEtSSGZKRFY1SWc2YmNoem9G?=
 =?utf-8?B?amozekdaNExZTDVraEFqTVpQQWg1RVdEUUpiQlVkOTVaSjluWENhT0FNNUVI?=
 =?utf-8?B?MWZydWF4UU9UQ3IzUEhZQzF0aFE2ZjBMckpLa01JRlpXWUNIQlBlVVpjS3dC?=
 =?utf-8?B?MFM4NFVzL3A2MzQ3UmphRHU5eVVQVStQTzFJM1JCUWQ4L2h5dFFIblJRNG1W?=
 =?utf-8?B?VmxtcjNtSmNGU3h0RTIrRVNOdmVrVWxRZ3E5OHlkdDAzaEdNUUF5V3Z2Vmpn?=
 =?utf-8?B?WWYvaWMzcGcwRC9TVG0xU2pPNVFUSDA0ekxHZ2hXMXJXeGdCQnRKR0pGcmZa?=
 =?utf-8?B?RmNxVGo3LzdRT0ZodHV3M2d1OGNSbkptTDFiUmRlZkhONTkzQ2xjNG9pUmpl?=
 =?utf-8?B?VmVxREJrZ1lXaGJXZnZjblV4STRENDEyL1lIS3JNelFTU2luWDhmdStwOWdr?=
 =?utf-8?B?VE96aEExQmdtcWpDeTlzZlA3bndBbXFUNFp6VHJ4cWpsbm11UFVrWnFJdDd4?=
 =?utf-8?B?eDlKRVNFSUdLTXpqTUIwdW9UTW9RdHhSR0dqSUZQdUowa09FSXZUWTRGTEVP?=
 =?utf-8?B?SGdwR013ZXRaYjlGY1htT1BwR1U5NUYxYjY0K2lmdmppbTNxOVdXWHpsZE9B?=
 =?utf-8?B?T3JSb0cyYkltQUliQ3oyYm5jMUFiS1hXdGVZWGM1bU5FQUdZOVY3OElvTTdu?=
 =?utf-8?B?a1h2V0grVFg2ZEY5RDNoV21xRnNPNmV5QnBHTW8xNUg5L1A3U3hFY1plMFdn?=
 =?utf-8?B?Q1loc000R2xpeW9qaWxKMDVPcENoem9lUFowcmlhR1ZGaFVkbjVmdXRCMFMx?=
 =?utf-8?B?Q2hrRXpZSzVIU0xoTnp0RHlhblRvQ2JSMmMwbGhuT0FFT1VHR3RNaFByNS9D?=
 =?utf-8?B?VVE3UXdLbTdFUjFhNE5lTyt4eiswZGZOVTNKTDBkYWdaeTJHbllnRGNQWDF6?=
 =?utf-8?B?cTY3Tm5hMk9qYnNITEpQY1JrVndodkRQU0V2Y2FWUUxqNFF4NFVRSVcvbjIw?=
 =?utf-8?B?ZlM4NkZjM2ljM0dmdDdPZWgrbDBpTFBsYUZRR21qS281N2huM0tPL3RTaGZ1?=
 =?utf-8?B?U0R4WkRwM054QnhWbWxlZ1huSkxPRUJiM0VzZnZJdG4zUERyUnpaMEhwVUdM?=
 =?utf-8?B?R3hzSVBPdTU1UmdmQWRIU0VWcUloUXk3T01UbTllMGVRdFRFUWFyS3MyRGhi?=
 =?utf-8?B?ZUpZemdKTFVXNVF2Y2ZSRTd3N2dKak5zRzJvSnV3eUI0TGNYSDZXZDlBanlX?=
 =?utf-8?B?d3NDUnRhK0FHT3JUNmtEVnRLcFh4LzgydFh0NnZjRDdqelVCTktoc3lGek9z?=
 =?utf-8?B?cjY1ZHN2cVFrOFhYSjB2R1ZMOEhuTGJyR3U4ckdjMk9WaW9vTkNVTjhtQmt4?=
 =?utf-8?B?SWFFU0xUT1gzbXVQSUEzS3JBY3drQWxlN21ydWhKZ3o2VWl6OEFZWFNIZjVk?=
 =?utf-8?B?Sjd1OFlkZ0xDQ0RDYXpsakdOa1FXbDlJY2poZFlqNTFlald2TXdnNzZac2tY?=
 =?utf-8?B?QS9sSVk5MW5kT0d0YkdkOENnSUtrYkI1VHBvd1JQWUhFZndLMjZFZ0IzZk9K?=
 =?utf-8?B?MDZiazcvVzdMSjRGWTc2Ung2VUNhNy9qVU8vR09LbkxGeTBwcEZuYkZRSVVw?=
 =?utf-8?B?ZkkvVHhyYUF6L0xMMWx4Q2dySXdieVpGRXNRUk5YUTVRZXlDSVRiOUJGbHlE?=
 =?utf-8?B?TWE5U0ZTaVduZm1oUWt1dHh0MDF6WnhvV3F6ekorRkZzQ2x4Ti9Dcjg1V3Va?=
 =?utf-8?B?OEtIK2Y1eUQzUHI3K0pvTnNWcEZsaFRtZnZHbitENTJVRVROSFI3NXRaZFAv?=
 =?utf-8?B?WXpDWUVxV2VKcmZ0WkgzRS8ya2Y2RXdFVmZWY0h4OFBJRXFmNHZqWjhkV2ts?=
 =?utf-8?B?N2JyYXZOalduS0hQTVpQZWtBM1BDMStURHNkU2FjSkU5RUNzbjFLRkRqc1d1?=
 =?utf-8?B?b3IvM2poRDlMWENERm5ZL3ZGRzErcFdtdGlUbjhNVzI4WkZrQlVtdFlTVE9u?=
 =?utf-8?B?MTBZbEZnT2QrbTRZMmRzN0xlcUU1N1RINWphLzk0eDZ6TVNtQW83M1JRRkoy?=
 =?utf-8?Q?scoBD+IEvC/YNTusDTsu6WJtE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab65855-d0e5-424d-ab20-08dda2d404a3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:22:45.2693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38vmE7BDakTzTDbsD4Kr253WZbePeLFoC8FtiBt1drUOBKEUCo9O5x64NH3O6cz3CBoNBfLjLHh0WKDoO+snlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648



On 6/3/2025 3:03 PM, Joel Fernandes wrote:
> 
> 
> On 6/3/2025 2:59 PM, Joel Fernandes wrote:
>> On Fri, May 30, 2025 at 09:55:45AM +0800, Xiongfeng Wang wrote:
>>> Hi Joel,
>>>
>>> On 2025/5/29 0:30, Joel Fernandes wrote:
>>>> On Wed, May 21, 2025 at 5:43 AM Xiongfeng Wang
>>>> <wangxiongfeng2@huawei.com> wrote:
>>>>>
>>>>> Hi RCU experts,
>>>>>
>>>>> When I ran syskaller in Linux 6.6 with CONFIG_PREEMPT_RCU enabled, I got
>>>>> the following soft lockup. The Calltrace is too long. I put it in the end.
>>>>> The issue can also be reproduced in the latest kernel.
>>>>>
>>>>> The issue is as follows. CPU3 is waiting for a spin_lock, which is got by CPU1.
>>>>> But CPU1 stuck in the following dead loop.
>>>>>
>>>>> irq_exit()
>>>>>   __irq_exit_rcu()
>>>>>     /* in_hardirq() returns false after this */
>>>>>     preempt_count_sub(HARDIRQ_OFFSET)
>>>>>     tick_irq_exit()
>>>>>       tick_nohz_irq_exit()
>>>>>             tick_nohz_stop_sched_tick()
>>>>>               trace_tick_stop()  /* a bpf prog is hooked on this trace point */
>>>>>                    __bpf_trace_tick_stop()
>>>>>                       bpf_trace_run2()
>>>>>                             rcu_read_unlock_special()
>>>>>                               /* will send a IPI to itself */
>>>>>                               irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>>>>>
>>>>> /* after interrupt is enabled again, the irq_work is called */
>>>>> asm_sysvec_irq_work()
>>>>>   sysvec_irq_work()
>>>>> irq_exit() /* after handled the irq_work, we again enter into irq_exit() */
>>>>>   __irq_exit_rcu()
>>>>>     ...skip...
>>>>>            /* we queue a irq_work again, and enter a dead loop */
>>>>>            irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>>>>
>>>> This seems legitimate, Boqun and I were just talking about it. He may
>>>> share more thoughts but here are a few:
>>>>
>>>> Maybe we can delay subsequent clearing of the flag in
>>>> rcu_preempt_deferred_qs_handler() using a timer and an exponential
>>>> back-off? That way we are not sending too many self-IPIs.
>>>>
>>>> And reset the process at the end of a grace period.
>>>>
>>>> Or just don't send subsequent self-IPIs if we just sent one for the
>>>> rdp. Chances are, if we did not get the scheduler's attention during
>>>> the first one, we may not in subsequent ones I think. Plus we do send
>>>> other IPIs already if the grace period was over extended (from the FQS
>>>> loop), maybe we can tweak that?
>>>
>>> Thanks a lot for your reply. I think it's hard for me to fix this issue as
>>> above without introducing new bugs. I barely understand the RCU code. But I'm
>>> very glad to help test if you have any code modifiction need to. I have
>>> the VM and the syskaller benchmark which can reproduce the problem.
>>
>> Sure, I understand. This is already incredibly valuable so thank you again.
>> Will request for your testing help soon. I also have a test module now which
>> can sort-off reproduce this. Keep you posted!
>
> Oh sorry I meant to ask - could you provide the full kernel log and also is
> there a standalone reproducer syzcaller binary one can run to reproduce it in a VM?
>

Sorry for the noise, but please provide the full .config as well. I am curious
if you have CONFIG_RCU_STRICT_GRACE_PERIOD. Since that has an effect on
rcu_read_unlock_special().

Thanks!

 - Joel

