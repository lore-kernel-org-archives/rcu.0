Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDDF2144DD;
	Mon,  3 Mar 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024752; cv=fail; b=AXk7GJber4y1CpAPwXJxPdGtsrOwfQBk1RnN1rV/sliwlKQWSwpQBMiai/suiDzg5l/2wAQ12cud57N8Prh7XrS1UzgNAkOqen5bck2VDu/BIwSqCML3ykBHGQ3XR3c3C+j2brJxU3w7G6yom4EfK4uUP5EWLy++ChcHTXAVOR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024752; c=relaxed/simple;
	bh=w7tK8/ulL4XB8OYPSrXshxcXw/CFly2Kor38V3vEjxI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HFpRMQTg6VAWe+yQA+i7Z9UJg+XMFaoKcYBhXwOlEMniKdGuzTaViI1rBUpYiV63AdtIiX0D6bHj3+gpIGIEHX6XBmKNEwJWKOlt1vR9cFpnmCymKK393Wms5XySBhvB78vFQQbPAeUqaawGRDidcZSFNp4p8kxVPGVWvtNYsjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nEsZjb1Q; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nEsZjb1Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAFXWWin8IALp2e9uN57HTuBpR8fD6tiAyiRpZwAbSnlwgHmoNJ/HVtY1VhTonEfyOSaPc7e3MnmALI3JYywRm+3puCW/btbWUaJGP0Hm6Cq1VteOv7wHnASHfLVGh0SiT3iXNvGWkY1FmanDSiMk4ZblChNX6DQmh5gBIK9kSl3a/5vcWjs7TPzCb3x2/8+/DsNzvJLlP6q3p5NC683oj3s6IVpy0DOiytbbxqs4wKaixy7x3SqdRf83xbgshFAMZIgqSudd+OPbH+f6QqRMXNmUKcwhM/6ty6jloIjM62JBrt0QGI2yCUClE+Eu5d6Kk6QuNBMvvXkXQBjjmGFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH3TS+JtK/vFc7G4rjXgnJBUrW84gFJubjHNAdsLh1E=;
 b=e7yaGrOjlUA6/q1jyHdVsI0VAqE6lVkTVZnO0Yj1kdaXPpiNo9xd7COWDUV5dHVq/h+jixzykEFnbIeO8vb4W0VRsDZ1WPPT6oGwlY9s8hjlRcFGqyyZH5AkL44LC4Hcng2mK4sA72L8v0zFJ6NX2CGP6J0xDaWYtYsoiB8VVMMI18S66gynAO9tt7nTAG7mqL+Scj9QtDgmW1IBPSE7nEZTD/zGmgpuz6RYmTRMQIKeOrtklU93tuopnjDnkDVcKdVji8Nl/Cw0M+ZCDLrGnQNmz3SNjFJrmouXpvHsHn+2CurqIIe5mn5mLO8uNKpDEbW6aeq38D2+l0RLehn/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH3TS+JtK/vFc7G4rjXgnJBUrW84gFJubjHNAdsLh1E=;
 b=nEsZjb1Q6huViEL0fiPp20pWV3gAXXJVCAJxcwqGRrv+yurOXM6hhBbe8LugNN1Idg+5J0Gn8q2BXXGXtYKKor+4agxOV+0LtLMrSs1l/5HverCwnIVfY1D4VhGhrjjoXXaM5kfsutahf2oFEBQcNjmtFTGT//B2IZKywVw/96XquMs/O7m2oCbdlwTrhNN5XR91A8FTPJ2r5tLOO/yyEU0UY5ijSqFsDPmEpgwq77hsoZnX0JvWMxSy9cupv26EStb6CzxXgdLFe6O69kTks5D5OVbMDN+/xPZKqmdO57aJOFZ4OREE1kuRjFYVvh2tvJf5riASR/ZiqYXeEBOpag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 17:59:08 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Mon, 3 Mar 2025
 17:59:07 +0000
Message-ID: <642190b2-76b5-4f61-b0a6-8aaff3dca56a@nvidia.com>
Date: Mon, 3 Mar 2025 12:59:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Cheung Wall <zzqq0103.hey@gmail.com>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <20250303001507.GA3994772@joelnvbox> <20250303001710.GA3997787@joelnvbox>
 <20250303170040.GA31126@joelnvbox> <Z8Xh0pP4xaFm0nEV@tardis>
 <5f404973-380e-4626-a2ef-8c5c44d56b83@nvidia.com>
Content-Language: en-US
In-Reply-To: <5f404973-380e-4626-a2ef-8c5c44d56b83@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccc3363-07f6-4e2c-473f-08dd5a7d17fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTNsaW5QcTBiVXJ2SmRoUk03UTY3NUlxS1NuRW1YSEhwUDBUL1I0MmpDQ01l?=
 =?utf-8?B?aGJBQlFVSVdlaG1NRFAvTm5PVXJaWm5sbWFkOG01YUNNN0ROY2FIaTNNSWJw?=
 =?utf-8?B?dnRoamp5NE1jcUxGTHZDdXViRlpEQk1DUGFXNTJFak1HK2l2VG9vNEVKRjB2?=
 =?utf-8?B?MHNxWDM3TTJnVVQwNE4vdFlVcXczVjZxS0NpMVE2aGs2UWJ3d3Y4ZDhiRUZX?=
 =?utf-8?B?UW5MOFViV3Zla1gzaitRaERTWm9XWU1kcE5Ua25Hb1NXWkhEbWwzc3M2ZjI4?=
 =?utf-8?B?VWNTVXhWc0VNNVczRlJ3cGlTWEVVd3BtUElWQzFvSkRndVdCVUg3TSttTGJN?=
 =?utf-8?B?YWFoWU9ZY1czamkwdHFDbWNpbVBYaXVDYkwxWDRBS0MzWmk2dDhqdFRidEFU?=
 =?utf-8?B?RVJmTFhvMjBBS1Y0RDJlTnN3SllOV2d2NStxSG40M3lWTXAxZWpSRDdDOGtC?=
 =?utf-8?B?MHdkSGw0eDk3b2E4NG1Gd2JlaTgwQjJDNVlHSlJLWXMyK1BYVzE0S1UzZGcr?=
 =?utf-8?B?eVYvNlFzU09jZDVTRk44OFVMbkRSODMrbUJoeDdmajgvT0x6eDhXNUFkdk1a?=
 =?utf-8?B?Q1BnLzFOMzVURmlOSWhHR2lhRzhjd1hkUmsvQUMxNzJYYlVNRG9wcTlGZGxN?=
 =?utf-8?B?UTRqY29mQktwMUc4RGtCSGpWcFFIVFptTEJIS3J3d0dHakd1YlFaeHRuTmpp?=
 =?utf-8?B?bThwMmx4amNHeDFvK25IZUx3c3oveEQ4VzNURHIvaXZMbWNla0daUERUZ2lP?=
 =?utf-8?B?N01yOE9BMGVXNUJkVm81enV6TEE4azQ1N0NabWUvNi90QTNCQmNxZzBrTEln?=
 =?utf-8?B?azQ0TWNKbmhZQUlSMjViQWdsN0V0cFdiaS9YZ1IzTzJvYzlWM0RWQjIyNjh1?=
 =?utf-8?B?Y3ovWjFmN2ZxaDh3VkU1ZXZ6ZmVtWXhCMGRhNUczclRpVWFFSitNSWJQMllR?=
 =?utf-8?B?Vmxia0dZQzFjNHpLQktYVThoaHIvYkt6aGhxMW40OWNuZE9XWkMvdTF3UlFa?=
 =?utf-8?B?aU42MUFZTkI4ZGVYNDlFeWxnOGZWNmVBbk1HNVdIZHNES3Z2ZlZ1T29KUnMv?=
 =?utf-8?B?NVd3d29hcVJuNitHMmd2VUlsQXFjVktYUFVlblVLMGpGNkZkMXlpd3dmR1VP?=
 =?utf-8?B?ZkpmajVpdkQzWG91dnZKZWMwdE81QjhQOEo3Z1VielV4N0FyK0dxUExpNG9G?=
 =?utf-8?B?dUU4a2xEZWRJc3N3YUhyMlFvRUVmaDJHUk5nODcrZjhJU3NOVGhIbFhpOEt0?=
 =?utf-8?B?Y1B0cFZidmFLYURaTnhONjFzK3lSY2lPSk1OTUtLbTFFYzFsaDl3cEtqTzRs?=
 =?utf-8?B?NldUVEUwL1J6QkpNQmpxUmJtVEhGY2oyREdUaFI0TkNkMkZDU3oyTTJ0SWZS?=
 =?utf-8?B?WVE4TkpqTHdKL1U0cTVjR0x6OWo3ZXo4R2JiUG1Gb0J2S3pFaStSREZOSG9v?=
 =?utf-8?B?WTJkTTU4WFdyK2N3Q2p6ZXJnMy8wMWl3dStzQThkcUgyeDRFYlVvanNOZXRy?=
 =?utf-8?B?bTVzd1pZK2hqWkhoSEJXQlUxamFDMjJHZ0pmViszRzlFbVdVOHZEd2pQVkgr?=
 =?utf-8?B?dnNVejNqT08xMEFYU3NGN1MzQkUwUUlMVFN4M1llaXVTMko3R0JMWldDQXRE?=
 =?utf-8?B?YWJTSXhieFZNcnRGckF2aU5iN3FjNkY1MzJYOXk3NmpTRng0TzFkUWV6NnZz?=
 =?utf-8?B?RjJ4SmJLc3BNcnhTbXBzV3lXOCt5VVdFTDQwdGxXSGtibFE0MFZ1YW9sSHlm?=
 =?utf-8?B?RmFFYW05bHY4bTVZc0EzWUsrVFNEK1Z2VU5DQmdJSE02dk9nN1FsKzdOK0Rt?=
 =?utf-8?B?eVBZNmdwQXJIelhRbkdRYW9oQXVzSzJBU0JrdmRBR3JmY1VBazBuRVo5SkdW?=
 =?utf-8?Q?4I2dRq7STb7nl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnF1d3VNbHcxaGFlQk4xVzNqTms3OGNlblJpVERNVHhQTlcwSW81ZHVaaTBo?=
 =?utf-8?B?WWlsZUFXczg5ZTNKRHVYRlJqZ3JUZm9jeHo3RFg1Rk5QSjFYWVU2UUl5SERI?=
 =?utf-8?B?QkNYRW5XRFQ5dTN3cXlkSFJrQ0pLWFh4eVNmT291YXZyV0k0bEFGU2N1UjE3?=
 =?utf-8?B?NmFoOGxMYU4wa2VoQUJTM2g5NmJxRkZqNkttR2Y4b29NZDFFSC9vaUYrR3ZE?=
 =?utf-8?B?QkdvVjRURWxLMFNMVExqSEpOMVpsenJzOTZNS1gwaHkrWVgxVXBmWnVBclc1?=
 =?utf-8?B?czNtUlFkN2NqZkhET1MzZGwzL2NMQ0dHaVVpZUgwTS9iMWlLTGFVbSt3ZE9P?=
 =?utf-8?B?SW5USzJwR0Y2UUVUbkdHaGFGU1c4byswR2x5MHg2Yno4UW1WK1NuOFFpWTBV?=
 =?utf-8?B?QUVCa2lMVUtGWW9zc2R5eks2OXFoajJkNDFhZkVjaXJzZmRBWW1vdkdUOUph?=
 =?utf-8?B?ZnVXdTNldEE2bHZZamY0RU0vUDZJMUswS3pRNmJWMTNmSTYzZWp0Z0d3WEht?=
 =?utf-8?B?WVVXeTV3VWhPNlIvaWtKY243UHVQMnBKdnRMbGJyVGlIaFdVWEhHL0hxek85?=
 =?utf-8?B?NWkrT3FIc3dtdjNSRkdKbHRuQTVZRkJXb0FOVVdSdU9GTkNJVUpEVnR1K2J2?=
 =?utf-8?B?enR5VTk0ayttblZ3cHVYWkpXNm8vM25Vd0l6SVU4aGdDcENXWmc2WVNlTHBF?=
 =?utf-8?B?NlZKWmIvL2lWQXZ5T01kKzd4RDdKKzNXOXZUWitTMVE4dmFnRGc5eFVzZGhw?=
 =?utf-8?B?TG9yOGhKRFp0ZnBTQjNoejc0M04wb3dpc2NoaHhFSDF6MXVqc3ErQmtzUTB0?=
 =?utf-8?B?ZkRtT1pxaDgvb2hUeWhIWXZ1THNkYlFTRVliZGhla1lGSm9wcDVKelp2MlQz?=
 =?utf-8?B?TUhPRWZERTAyUktCWnpiVlRhdStFOS83czJCNUk4RlEzUHArenM0NXNYT0xK?=
 =?utf-8?B?WGpZdjAvSGNzZ2pSSkVoaW1OaXpOZE9oMk9RaDUyNCthWEc2bTdER2FRQlhl?=
 =?utf-8?B?czZNbDdUZktLVU1TUVRQVW1GN0dVYWVJdFI4dzI0NGtCTDRGc0RsRnVUcnJn?=
 =?utf-8?B?RXZ4dzYrUTl3R0lrYlMxWXZiVWFLekhCZ0I1ZjJnbkh4UnFKRFkzY2hCdSs5?=
 =?utf-8?B?SjNDTlpaQjYwazBxbFJWTDNvVHJUa3R6enZwUmNLQmpLRkV5b1JxNmVUQ29I?=
 =?utf-8?B?MkQ2MU1ZVWFlTEpDdm5oMDdyTExPVmhPSUV4N1VqQlRWNGIyakVhaDBRa1RF?=
 =?utf-8?B?MGMwSzEyK05lQ1hUMHpPU1JOR0xXQksyWmk0QUpSY200QXo3WjR5YVd3TkhY?=
 =?utf-8?B?NDFmNU94OEtyS0lwNHh5K0UvZWdCQzFYUUxKUjVkVklJcFIyeHdMQ0NJVVhJ?=
 =?utf-8?B?c0lPTUNBckNvUjh1Y3BNU0lPSkZsTlRRL25jQmpqelRiWGdtY2NSNHErRUQ1?=
 =?utf-8?B?b2pKM1NZWm9YVWwxdGw0NFFqdmRrSkhOSVAyZXd2VWxaZEl5ZXdGY0tDM0pS?=
 =?utf-8?B?c3lDTW41YkRrckVVeXE3SHVsdEdNWEJVemxUeWJpdWF0RXVsNlNiRGMyK2th?=
 =?utf-8?B?WUtMUXVtM0NyY1RKd0RaTXR6aElud3o5dDFYWjJzSGJDZmphYVpOMUxWRkVW?=
 =?utf-8?B?c0t1cU1Yc2h3MWwyRjltQkxsSmVqUVhPaTFWa3hvZlVUM0JvZG8ySlNiSWdh?=
 =?utf-8?B?UWJuLzZBZCtlU0F1R1R4ZjJMVS9ETzhESTljczQ1REp0K0JUZ0xFMVFlN2VI?=
 =?utf-8?B?aTVsVEllQTBLdTNVWitZZkFqU1ZLKzBJaXJqTGwvbWg3NmMzOFMrQ3lRS09Y?=
 =?utf-8?B?ZmRKZWU4K1llVUxITHlzZU5tWjl2VUY2VFFHbHp1VjFybHBHV2JINHZIcURB?=
 =?utf-8?B?blpNZlRqekdUZ1RnRGZOMnVZRVNVbEZpSVRWNncrSmlYNnVyZTVhRzkrZU9z?=
 =?utf-8?B?ZzBVcERkdk1xaUpTR2k1clVtQzFSbmduNW92dXVXQXI1TEV6dThkVjR1Z3dp?=
 =?utf-8?B?L2REeWM0UmtXM05SYlFGY1N3S3pDM0tmcjMwR0cra3dXTFUySytJd1pZaGhh?=
 =?utf-8?B?ZjdETWVzR0JQMU9jMXhBR1hwWWE3K1lna2ZqeWVYbWp0M3BzNVdEWGI2MXJC?=
 =?utf-8?Q?H5DACGtvBOjLrJJjnzI1nZPR7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccc3363-07f6-4e2c-473f-08dd5a7d17fd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:59:07.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dwon8n6pTn0SJCDiIaFD6de4Omyjy8nPa0HJMKgnm4TfGcTBy60AywmfFdzudUfnW+LbEe872RmROoRT9Qi1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260



On 3/3/2025 12:30 PM, Joel Fernandes wrote:
> 
> 
> On 3/3/2025 12:07 PM, Boqun Feng wrote:
>> On Mon, Mar 03, 2025 at 12:00:40PM -0500, Joel Fernandes wrote:
>> [...]
>>>
>>> I see the original patch "rcu: Fix get_state_synchronize_rcu_full() GP-start
>>> detection" is not yet on -next. Once we are convinced about the fix, do we
>>> want to squash the fix into this patch and have Boqun take it?
>>>
>>
>> Which "-next" are you talking about? The original patch and the fix is
>> already in next-20250303 of linux-next:
>>
>> 	https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=next-20250303&qt=range&q=153fc45000e0058435ec0609258fb16e7ea257d2
> I see it now during manual inspection, but I'm confused why git cherry tells me
> otherwise.
> 
> I tried the following command and it shows the patch in question in the first
> line of output. Basically the question that the command asks is "What is in
> Paul's dev branch that is not in RCU tree's -next branch".  This question is
> asked for the obvious raisins.
> So I am obviously missing something in the command. Thoughts?
> 
> (rcugit is the RCU tree, and paul/dev is Paul's dev branch)
> 
> git cherry --abbrev -v rcugit/next paul/dev | grep "^+" | cut -d' ' -f2,3-
> 
> 012f47f0f806 rcu: Fix get_state_synchronize_rcu_full() GP-start detection
Ah, its because Paul's dev branch has an older version of the patch I think
(without the fix being discussed here) :-D

So that explains it...

thanks,

 - Joel
