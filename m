Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D5D349AFA;
	Mon, 22 Dec 2025 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442398; cv=fail; b=djgsP+QbLwQtqSIYlWoXO3cLD24BJXSmUvxGZE+4K8s7NatFFmvXuYfNG1stmdh5dBv4OTaNQFLMMkyP0UHZBLMGGJQ//4aWEnTRtORhIRdS1+Qd1Y+3WPT3i7z1P/xpV3GkImfnlDQt4Sh/gAJNU8gSuTczMeYPub/Go5zFTRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442398; c=relaxed/simple;
	bh=BwzoqCm2G1SvnBb25ciSuNbSvxLkqgkS/rlxRtc3JcQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uejfq5YEjAdBp6XZ9YwEvVz0/ByslNzpRLWE/rAvi5Hv0hZ5vqUVJHGVa/CPjahMceLhUPx8gtwR6vwp1TFGbLPPNQLzqZ5Yc1eFMBs+WNpLsm+KamBCLBOyPkZUc6bYEL5hkGY8JPIusRx8qvYE1T4xZ2HYw7aFK6DXyCWeqQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DILbVDVK; arc=fail smtp.client-ip=40.93.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DILbVDVK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlCSYXE0yeglPOA++Wf/ywNQwoJVDMmK6FZunICVXCze/hgRIuPu36im5YgvNHWXZAyW6xIrH3Ji3lJ4zQvFy+Q3K3R74H95uq7trAiJQL8/NnagF9C2DumyxJPNtXOCQ3m5R4Qv0HR9iMj2mJEbtwe0Ncy0GxdyR0FKUqoJ9F4iUatSNc/K77tvJieB8J9Km3NoknYgqjwqDu9TuNJzogmHesZd7rkMOL0H2pLA+KMc/nQS9S/+EdTEOWLYtMivTnYLOlEO8mqK/FjIM+s8LBUm66N8fUW8N7jmIAxTPonucl589e2GFXfbDkpHlCyyNPo4r7sG9tQXSfG4y3kImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKkKQyUGHtTZtaiX8jlqe8IfNiohfdvICFYy16UnCaI=;
 b=riZvrOyUz0TOSO+22yz9ivmEAur/uSRSxkOEU9319nVNxS4Hqcb66Dh3qRBJVhhgxa8R9fJjVaNHBptuozQwbykti1JVfm2403bnwJG7UtfrH+xTSa7XYfqMV5td/o2fTf3hzK6aeTtTMWd8aIg7xyBEc129i43eU1/qHH48V0+OxIt07wmnDFOSv2j2P3a5RKZvD0wLfq9xveWW/RlzFml51LMrxS3zYWPNyQbvny4EvfUGru5vPvLlMlVN0BMx0zOBed47NaRcDZ8aFqOjnJGMwFHwGwmLjJ95QJYN2gIYrwH7rTbsJnLKkN5Rw5+nEHj+Fya5/M8ZhA1jKNCb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKkKQyUGHtTZtaiX8jlqe8IfNiohfdvICFYy16UnCaI=;
 b=DILbVDVKLWoJTFFvQMSa6vgraiS6RQ0E9KgrzmyYF1veyMi9Ew3MFRvGOT0TO2QWXaUzY6OJhuvYnUoldgLDvsyk2gj2U62y5msnyLMbD7PyWtY+0qh13DNCN3Ru4gpqBfm/cx+RD/OAjLjutU/CkRLtlmdmc+Q2G3azkooz9bSTUBL47htOCM48e9ru+Wm7RtjYZYbRnn1HtoXwbhaU8HBt32cu++4j+LjOoXLhJSrC65jbjXmTgGfBdoloX7roxYowSguP+UtE82w0cx14TbGl8ZH9O9pg2EOfehCNWefbRI9l8KzRzm1ttNdYbiu4buXMNGXJxu4zdBqccUOWEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 22:26:29 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 22:26:29 +0000
Message-ID: <fe07319e-01ec-4700-bc89-e548f4dc7271@nvidia.com>
Date: Mon, 22 Dec 2025 17:26:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Fix rcu_read_unlock() deadloop due to softirq
To: Yao Kai <yaokai34@huawei.com>
Cc: rcu@vger.kernel.org, liuyongqiang13@huawei.com, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, josh@joshtriplett.org,
 boqun.feng@gmail.com, urezki@gmail.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, linux-kernel@vger.kernel.org, yujiacheng3@huawei.com
References: <a32ad653-1bcb-44d4-9802-bcfc2725d712@nvidia.com>
 <20251222080600.201867-1-yaokai34@huawei.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251222080600.201867-1-yaokai34@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0443.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::28) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f0f063-9559-423f-1178-08de41a926c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3BHYnRQaGgvRjM3bFdWMEpIc1luYjNOS01qdkRIYjNSUW5mbGtYZWhaZ21C?=
 =?utf-8?B?dXRtbXBHaHZCNkNsK3QvVzFRS09qTStDVE5ROCtjQVdTeXFHUC8rSS81Q1Za?=
 =?utf-8?B?ck44T2JoV25oc2VkN055Q2dNcTJyZzFBV3BiSFp1Qk8vWS9yNGVMUElaN2Ni?=
 =?utf-8?B?WE5jVEZ1TmFKL3lDQ1ByODhiWGFuRVJEcG1iTFVkcTZocUlOWWNEeC9ySEZC?=
 =?utf-8?B?amU2VTNDeTlveStQVENMa3kwRXFVL2IyZ3Y3QUpNMldySS9SQXhOdnVaanRE?=
 =?utf-8?B?VEhmRnIrbEJueFh2VTdZVzdBOTEvT3p4K29vRk80b1BTT2hnL2U3cFkvRWho?=
 =?utf-8?B?VWtqMWRWcnNOa01NK210MlFJc0pQdWFjVWFMUVNLNG9DaGNqeGt6ZFJrL2lI?=
 =?utf-8?B?WXZCWTRsckJhZTBFakptd090ZHZTZ09oR2RlZGVxb083WU93NmorOFBYOFFJ?=
 =?utf-8?B?aGNpVlFoY3FzL0JEbFZLWnE3eHRHUE5tWFVDaDlBWm5veHBnZXgvWURXcnhW?=
 =?utf-8?B?aGlkQ2xiTGh0RUdQUWRZcTNtK3lKZXZYUzdDUGY0ZXFDR2NLL3NNM2daWnd5?=
 =?utf-8?B?UzZZL21zK3RkUUpQWVJVamJnWHJrNjdRak9wb3FRV1RNcEJBMGJOZmhJcjZJ?=
 =?utf-8?B?dGVXUjlFcU05SW11QnFRai82NGtCbTZ0VkhuOTNYRk5DZEhYUFBlZGR4NUJU?=
 =?utf-8?B?ZjRnRkFEL3U4TER5eUttdUVwTjZON0IrWE9yZTI2S3loQlBOWlZHenNXS1Qr?=
 =?utf-8?B?a21SUTFOOTNrUW9oSG55ZE9HNlpSTHNUQVJvM0h3SHlxdjVLTC8yU1VaU1lB?=
 =?utf-8?B?RmVRSlZqNmxXSUtpYVF1SWZDQWUyc1JlRHJPUWtqUUNTS2VzRVJFVGQ4cEZk?=
 =?utf-8?B?aHMyRU9md0tieUZQa1FtL2hhbXZHUG8vUlZqSVdZMC9UdVZnVzg0SFZWOFB0?=
 =?utf-8?B?c2hJenIzaXpMQ2U4V08yTkdHdkEwa2JCSjlreEpmd1VPWEpLNTNqcUQxUlov?=
 =?utf-8?B?OThXSWk0dGlQd1ZTdnl0RjJyQ1hqMk1aczVSVnRQYmlLVENUcG41cnBKaFhJ?=
 =?utf-8?B?dm9tQzVqRXJSYmpOclRMeThSZ1VGRWtqRFhFbTUra2t3dEdWbFVOaEdpSlNK?=
 =?utf-8?B?ODFNR3FKaHdMSlcrM0ZuV3ZrbTRvUElYdVpWQVVvdmNidE1pU3hhZ2RUWUN0?=
 =?utf-8?B?a012SFFOSThTUDY4MU5ZNytBd1dkZS9rdUM1OGtLbldFQTNYck9JOGtQWk9Y?=
 =?utf-8?B?MUIyOFdKTUlTQzBtMDl2dmVMSjBVVG9XN1UvbkxDa1BGb3hjT2N1YVowZW1V?=
 =?utf-8?B?cjdkUXlzaC9RVkNNZzBTS01tZ1F0T0ZGMjJ2VVV1RitIY1ptS1g0QmxOVUEw?=
 =?utf-8?B?Y0ZYZHY1d21IQ0MvUkZLRjhjdXJnVnNEbldyQVdmWWVKamVjYWQrTGF1cGlU?=
 =?utf-8?B?aVhMQU94SGdMVUEvVzN3amF0TlorVmkzUjB2SERxU01YZHU1V0ZUUjZBZTgy?=
 =?utf-8?B?aE4zc3c2QmlZb1hIck5Vb2I3ZjN0RDNzUThPR1g4REcvNExFV1pwZDhjdjRK?=
 =?utf-8?B?NWNKdlZXYjdFbzEzdlhiSjB1bFFLcVdPc2JjVGZpZG1pSU9UL1lIcVU4NWlF?=
 =?utf-8?B?N2pNWEU2VHgyemlTMExGQU5rNnduMHgyRDVMMW56VHBIcXdVSmdhNUp2WWs4?=
 =?utf-8?B?dXF5M01wMlJtYmszZVJXT3pPbmdQTG9lVXQ0MTdqVXExZit1NFkwclRPSkpu?=
 =?utf-8?B?S2tsclhKTitQWk5RTmY1UnpNWkpoU3hHdTUxejVFdVAzdWkxWGZlS0tycitt?=
 =?utf-8?B?MVJXa2lLTWpSc3JpYnR1ZFBwOTRrZEtEUlZzOEE2MDgrdlY1cmd0eUlsUS93?=
 =?utf-8?B?WExLMW1yVEtkMDBUY0ZjM1prd1hmNUVGNFVPZ2dQK0NEUjZKZzZPNWFPb1V1?=
 =?utf-8?Q?ck/bVu9fdpbFzb7/gWWe3izY7VGHFBlU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWpYWXdDSXdxWmFURUduM1lxTUx6SUtSNGhiWXVaNXpOaktXRnFDZ0loS1Yr?=
 =?utf-8?B?M1JoaVBMd2I5ZVNpUG1DM0s3Nmdjd2hOajNJVVFYTnRSWnJ0NTVIQVZYa3Qy?=
 =?utf-8?B?N0ZzTlFraHRsUUFGL0k5MVdrVnB5YjBUbHo1U01mckpBNUFwdWp0NDZueHI2?=
 =?utf-8?B?T0I5b3pjbkZldjNOL2I0b0dNVUxSTXRtUWovaVVVYUpET0VqUVppaXN1enZy?=
 =?utf-8?B?V2dldHhSeHpxaUpCdlpINlpOekxyTVRtYmdHOERXL0RiL0plMHdFTFRoSVkx?=
 =?utf-8?B?eGxnUHFxQjRoWkpQbExVQU5SQWFwYVcvbnFNakxYdXk5VzlPSDVRZ1p6eUl4?=
 =?utf-8?B?Tk9XdE9uUTU3UUd6dUowZzZhNHRoM1Z3QjJra0RiV01oQ1QwVjU3ajVRZGtp?=
 =?utf-8?B?aFk2WEZRbmFQM0UyN2FXS2tiTDE4K0wxMktmL1pMVGRYd1ZDb3dxbm54dFpm?=
 =?utf-8?B?bWVsenhxeUF4Ty90RkI2UmdNTU5sZ2N5ZHBjb0tzdVBQYzhYMEFyQjdDSWZz?=
 =?utf-8?B?RDBDczkxNmVhaEpFSCtvTUMzTlB5UkJqQ0puZGFHOWppa2NYc3dsTlhkRzFJ?=
 =?utf-8?B?WXZZWmh5aXBiazdpSW0rZG5BMC96VnU3SjFvcXdBU0xoK0QzM2dtUzlBN0JB?=
 =?utf-8?B?VE5BS291NU5GbXBuZGtpNUd5TjBpeFcrZ1BIOXFwRm91dWJIdUl2VlFjSDN3?=
 =?utf-8?B?bS9lVkNLRlhERnF0eFBQVDVpb3FVdmlTWkgvZldpVFY0V2NjUnlHdnE0RGdU?=
 =?utf-8?B?VVVscG80M1JobDNyUmRaTHlndnJucEQ0aVoxL3BPd3I5N3pRWUtNVkhiNnV2?=
 =?utf-8?B?WWlyd0lPZjRmZVFFQ2s0SXFJNTZDYUcxejV3ZDJKUTRLdm9uMG42UVFTc2Fv?=
 =?utf-8?B?bTh6M29TSWk1bm9kekpQNFZoQ2JySkdkVlllNHhUNjFtejNlNnhYQ1kzZXg3?=
 =?utf-8?B?Sk15MW03UTROV0oyTlFTbk9zUWdreHZQWGZWUmtEa2E3YnNhOGwvcUhtQWp0?=
 =?utf-8?B?akhUSE9naFQxUEFOUVEwaTJYZWhjTDlER3dwVjlqcy9KTlZtNjJ2NlMra3hk?=
 =?utf-8?B?dnpxdXJRK1AyUk5BTlUwUGs4blpZeGlpcnpTSzlKMjhJcWFHTTVaSmNsOVlU?=
 =?utf-8?B?L0xLdmt6eUxPSXloRWtWREpSZk1TS0tqb3l0d2NLelltaXZqMWxoQU5KY0h4?=
 =?utf-8?B?MEswbEdLTlllc0U3RTdrYXdmd2N0am84MFgvOU9XL09RUnU2SEYzaG52eGsz?=
 =?utf-8?B?RHI4T1hjbXM1bG4wejZIUDYzVEFOeE1yQjNEcUo4Tm9Ld1BNOFN6YVh6RmND?=
 =?utf-8?B?clRwU2pGWGxOR0x0RGpZUjZIKzJyUi9OVEFJa0s4cjhyZ1RVbDNZRnBURTZ2?=
 =?utf-8?B?MktGOEtHazZ6QjlWZ1VYUHJRSnJFa091eGxycGFsWkRZMHlaYVlPb3hKRXo5?=
 =?utf-8?B?UzdLVzVGWWFkLzBEVWhYSUw5OWIzVEZQaVR5TjFvNkhTNTc1UnRKNnluVi8v?=
 =?utf-8?B?OGdzaUd6cGhpRncxYkVsNCtYMUNHcHhOK3hKZFlYbzkvSTI5R3Ntdkl5bEV3?=
 =?utf-8?B?Sm5OMGx1RnpQVmVNa0VWVVp2QTM3Y2JYMHhuTkJZdUlXUFJzZmhNNGJidVRh?=
 =?utf-8?B?NnArdTNnQ3pDZ1VFMlZqQTRxREhDTkRUbERseGFBSVdBSFJJTnBETWt6a3NX?=
 =?utf-8?B?ZlN3MS9rSkdidkxGY1kxTUY0QS9YTEtPaVRQcGdJZVZpK1htbHBkT0xlWk9l?=
 =?utf-8?B?aXh1SzVJWWZIbFcwSStiZTBwMFlXL0RrYzhEbThkZG9XK3dBT3ZmN3gyWkFh?=
 =?utf-8?B?dVFhWVU1WXd4NmVqZjluNllSOEw3NlErUTVMaWRNenNNa1krWXBhQ0ttN0wx?=
 =?utf-8?B?TEhWRU1TMkdsVnI4S2NzSlhma3UvdEFmS1RGQjQzdWNJb1pNbmt1ZUtNd1dM?=
 =?utf-8?B?MFZxT2lsb3FHQUdPMjJROHdSSGtBaFpockdjd2M5LzhqczNraEsvaEhPayt3?=
 =?utf-8?B?dlZjQ1NocFdxdWExRmxKdVpKcXhzNWhSL0VSMzFFMGl5WGsvNlp1RVlPaWor?=
 =?utf-8?B?NitpbG9UWTZLRk9Xd2xhVFVMemVSMmsxc2U1Z0lsUnVUL1FyemM1aitGVmhB?=
 =?utf-8?B?ZGZsOG4vYkpGVFVnc2xPVzFOcXdjMmZOY1I4cElGaTFlMkZoT0M5K0NnbTJE?=
 =?utf-8?B?REtVSE83TTVRa29OOG1ZZXdxM2luLzE4Ny9OSzg4MmxqQXZBZUx4N2k4a1By?=
 =?utf-8?B?QjROdmhZS0FVQmo3cWFjTm1mNE5HUnkvUTF6dW03NStSelhEZHg4aGxEQzJp?=
 =?utf-8?B?ZVQ4YmVDWFlrNVdqa2tOcXhJNmdDOVZRMXVyazU2b0l1clRCeXR3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f0f063-9559-423f-1178-08de41a926c4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 22:26:28.9910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+eb6auenDqX02maCOIGZyYXJdgQPWVo0xA1kjHMddYfZlPdCrJOILck70Jo/pf1bH2H0zZZo7MnLKYBt/WpEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720



On 12/22/2025 3:06 AM, Yao Kai wrote:
> Commit 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in
> __rcu_read_unlock()") removes the recursion-protection code from
> __rcu_read_unlock(). Therefore, we could invoke the deadloop in
> raise_softirq_irqoff() with ftrace enabled as follows:
> 
> WARNING: CPU: 0 PID: 0 at kernel/trace/trace.c:3021 __ftrace_trace_stack.constprop.0+0x172/0x180
> Modules linked in: my_irq_work(O)
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G O 6.18.0-rc7-dirty #23 PREEMPT(full)
> Tainted: [O]=OOT_MODULE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:__ftrace_trace_stack.constprop.0+0x172/0x180
> RSP: 0018:ffffc900000034a8 EFLAGS: 00010002
> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
> RDX: 0000000000000003 RSI: ffffffff826d7b87 RDI: ffffffff826e9329
> RBP: 0000000000090009 R08: 0000000000000005 R09: ffffffff82afbc4c
> R10: 0000000000000008 R11: 0000000000011d7a R12: 0000000000000000
> R13: ffff888003874100 R14: 0000000000000003 R15: ffff8880038c1054
> FS:  0000000000000000(0000) GS:ffff8880fa8ea000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055b31fa7f540 CR3: 00000000078f4005 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  unwind_next_frame+0x203/0x9b0
>  __unwind_start+0x15d/0x1c0
>  arch_stack_walk+0x62/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  unwind_next_frame+0x203/0x9b0
>  __unwind_start+0x15d/0x1c0
>  arch_stack_walk+0x62/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  unwind_next_frame+0x203/0x9b0
>  __unwind_start+0x15d/0x1c0
>  arch_stack_walk+0x62/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  __is_insn_slot_addr+0x54/0x70
>  kernel_text_address+0x48/0xc0
>  __kernel_text_address+0xd/0x40
>  unwind_get_return_address+0x1e/0x40
>  arch_stack_walk+0x9c/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  __raise_softirq_irqoff+0x61/0x80
>  __flush_smp_call_function_queue+0x115/0x420
>  __sysvec_call_function_single+0x17/0xb0
>  sysvec_call_function_single+0x8c/0xc0
>  </IRQ>
> 
> Commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
> fixed the infinite loop in rcu_read_unlock_special() for IRQ work by
> setting a flag before calling irq_work_queue_on(). We fix this issue by
> setting the same flag before calling raise_softirq_irqoff() and rename the
> flag to defer_qs_pending for more common.
> 
> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read_unlock()")
> Reported-by: Tengda Wu <wutengda2@huawei.com>
> Signed-off-by: Yao Kai <yaokai34@huawei.com>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Thank you. I will apply this patch, I am preparing a few other RCU patches from
me and others. Will send it in a series for review/testing for 7.0.

 - Joel

