Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74540229B37;
	Wed, 26 Feb 2025 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592188; cv=fail; b=Z2iu7jUgu7XVVR24RX2QPqGZPyQUKRyHcDs9ewBe5hDBn0z98UFrZhfqI2AelfwhqAb1P91n11+MA28Xg2RStVJFgvB8+WRaDmGRVjGdao5AdiuInvjQRgvClM3edIFtq5VzCrbsgDSCf1+wUdYWPQIUDIw9y//JN2rX/MEAXmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592188; c=relaxed/simple;
	bh=8Yojr9ABv9J0Pbj/ojKJkpWXW23M39cf+vTQIJHH8ok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FwDAvbZvHaN0sWLnNuTC1XbSA9hCGAeAMLX+YYRDfCKMeU0DwvIiVfTKFSb16vJNJq6jhTVJsm0jH6SRLa579feUZP+xrM85CcGlICDamYE7O/AM641VQM0Uuqjk9GdM4pXhcMWOXo9vWnlGPjucrGCvzx79i/RzQjGeHpgfZA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DPN6rzj+; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DPN6rzj+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9c2xAQUALbPBmjouQJsGoTW1qAdY+XfC4xptuWCjhe708FlYivPqm0B7kBOEpyF7r+g0XLdYzrEx2T8rjDB8wQmi+NCkBb2SIEiPGhvfosYEg6pSBjV34rj4ODDAAaCnq/Q5E0OcR9V4H6+YSTFcGnl0+8kJY891RbwwNYmuzohcrtRDq0b3dFe4w4tlxTNA61LlmByWcr5kmN6h6/5K8CjvouP8tSNP9q7W24I0nm7McgmFODoaOybqScrsZ03btpka+pGL5XLOWKxrF08dwi+4Vk7+QG4zjX2HYhO1poieRujV4KYQccYpHs3IWDFV1+08joGRuydr/HXJqNWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCIFv/PZ+7v7vMmKzetqDS7J0nNJoWZ5CxIOfSN0B3o=;
 b=FbNMZlcZ5dGdtnFxyk/3p/cibcojmJNNGSOwEf2K6b09NnGmfMym+Vztc5/H8cLF2cqkKvT1yFs25zJkV9Ncp6ZYE3WXtROguDNi43lzDUW729Vj53UDERCUpWIB9+3fHYWT2wTO6Verb7hiMEozEwSUpB2NXpYrO9awyRNwGLK5ZrULKa8t5S7GexGdWtlRr0mbutK8jFgVSFBz3KG+pPupVyj99TzJ0GWTiGuMg1sorV96qQ/KzLV0OD9jlKJ2BuuHU/67Y2JLX4oVkRUxkbQR1KqpiGoZXKInMvgoC7uDVsEcq5pHBk6/4uI6MqwKUe1oP9u7ZZDhwE/cRQ31gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCIFv/PZ+7v7vMmKzetqDS7J0nNJoWZ5CxIOfSN0B3o=;
 b=DPN6rzj+yzHYFDmKEbYyDsi8Qr5ZF7KF71NwUwalq2E5a6WszN2hrgNLyraWHw917I5V3ucTDJFUqm1y4WhdXJClMAzuNRmI4C8zPIvD5tIb8Oa8pyQe79Qc/03DvbdeS4fvXCLb2WTTS+MZcWYagztDTHkEPuxq0UFJ15wtXBgimuGPimpcyGMxWrYyI7vE5kRrsbOXlXN4l3g0/Wl4hQX65xsHaYeXlm+dzA0sHZKBFxjnggMhFXNfqwOxuhk5fkU0npHAmbPFsZYKU7LlILg3Dq0AJz8YSq3kS1c8Xh9CTDGDNL1y+ZMcLYJ/Xyoi9XYcP8SPjbcnlJq2wzdDYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 17:49:44 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 17:49:42 +0000
Message-ID: <a26d4cc5-ff54-4f9f-b2df-aa423c112487@nvidia.com>
Date: Wed, 26 Feb 2025 12:49:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] rcutorture: Allow a negative value for
 nfakewriters
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Cheung Wall <zzqq0103.hey@gmail.com>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20250225110020.59221-1-urezki@gmail.com>
 <20250225212409.GA1807836@joelnvbox> <Z78lNRKjLQKigyLw@pc636>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z78lNRKjLQKigyLw@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ea41a4-8660-4bb3-8f3a-08dd568df32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTY5ZmhjbVpUeGtlbnl5aFBEajFucWpJYjliN0Zqby82SHlndm5GOXczWEJO?=
 =?utf-8?B?dlBhTVI5ak0xSENnZTJJd3hPNGRxU1lLdmFsSFhXYjlDQzFIQVU3TlRZOHdo?=
 =?utf-8?B?MU1JcVZsZUZPaktJQ0s0MlRjbmMyZ3g1RnowaDNVUjEydEc5a3Iya0lzR3dH?=
 =?utf-8?B?dFVKU1F0a3hnemRuZ1dyQXJHYTVIOTk5YTd4Z0VnTkpZUDd5RTJJbm14K1pr?=
 =?utf-8?B?anFtTy9hMjQ4QjRYb0ZaNk1uUHdxdzFDSjhvbHZhU1YyT2VGOWNJYzRHZkxG?=
 =?utf-8?B?SDdMbHJZYnhudFFXY0ZFV0pEV296TWpySUg0dTJpNmNqeElNNTJES250d1BY?=
 =?utf-8?B?MzRSd251eExwaTU3cERaUmxNVXdZL3hKS1cwMk5GcVEyMFRROVVaNk0rRmx6?=
 =?utf-8?B?ZjkzNjFISUh3T1JkaWxFMkJDay8zZThQaDgxRUordFhJbEx2QzJPWGRJWjdt?=
 =?utf-8?B?VWYvTXBhMVZVUWRQL3E3bmwrSjVXWm9KUTk4cmhrNEw2alNXVERaRzhnY2Fo?=
 =?utf-8?B?RTJoVmtHSG5taWRGZVIwSXgyVE9jUnVhaHA0bmFzdWNXTnA1THUzbmFSb3NM?=
 =?utf-8?B?dE1oOTFQQXFjL1pUcG5pUldVandwN3lzNC9RVnYzYWkvU1hUc1hiQ050Qmox?=
 =?utf-8?B?MUkyKzgzRUJhb3BwTFFLWkJ0YW5BUnd4ckg1ZXlUQ2Z5UlRmb1hQd2dHVTV6?=
 =?utf-8?B?YngxcXFjbmNHcEdoNGRjZmFCdGp5L1dnZTdMbVByQW5Ebkl3Ykh3UWdtejdy?=
 =?utf-8?B?V3BqRmZrbjc1V29YSEVJZEorQWZmMVRSWExnY0JiZG9RWWk0NjY0OXprS1FS?=
 =?utf-8?B?ZE9pMjBkU2gySHkxN2lzM05uTXNEdENRaFJ1bEdEbWxOMWpNR0ttYnd3bXdY?=
 =?utf-8?B?NG52WEltZHpOS1l4aHBtT1BDajNxWGp4NDcyK3k5c3FtVnFxbU9LendMWHpV?=
 =?utf-8?B?ZkJPeGRxaERGTWdjMVdrUFJKYmpJeG1IcWlpenBHV1RjeVZHMXpzT2x0eHM2?=
 =?utf-8?B?SklHV2tPRUQ5b1BHQjgvRFF0MUVNU3Zxbm1MdjE4ejRuRW4zZDFUNnpsQUFa?=
 =?utf-8?B?ZU8vcGtpSDJ1UG1QSVU3Q2V1emRSL2xsaENvbDlNeXlEcWt6TExqVWNLUkt4?=
 =?utf-8?B?c0NSYjZkQzJLdE9DVXhxRVpmVXdSSDB6TmhYZ1MyMGFLamRCKzhLOGFDYUV0?=
 =?utf-8?B?cll4am5XTFJCUHhnQVJrMHVQV2o2VlFXaC9DckdHa2F6c2k2aE1IQ3RVaFcy?=
 =?utf-8?B?SXB1cFFRRFBJUFR2VVZUdTQrV29YV1hacnRUQW9vTTZ5UVVGOW81T1RvcE5i?=
 =?utf-8?B?Z2Z3cjlKcGVkZFdpdG90RWdBcXpTRHZGU013QTFKODdSUSs0ajNSR1NJRkc4?=
 =?utf-8?B?ckJpOTYzcUthQlRQV2VvUStCMXYrZVFMOUhpNDJwZTFVUlpZT0hpUXlMbnNM?=
 =?utf-8?B?dlhZd28rZnRIZEN2b1hMK1ZYSFdYSUFIK0d4VTMvdE9VYmwxeVVpM1NRMWhv?=
 =?utf-8?B?c1RSSmtsVGJDbGkyWmxQdlRSNzBmM0FQdHdzbHUwNzk5TnpXVHZXaHdKbThQ?=
 =?utf-8?B?NlFXNnFPV0NYbWdKdXlJdUdKQ21oM085V2RHOVpxZGhIZWRUcnZrZHRtMnBk?=
 =?utf-8?B?ZlRFMzEvZ0ttc3N0VkpqRjZIejcxRkU3Nm1vS3hjTDhCTWxkSGIrMzExQXFk?=
 =?utf-8?B?bTBRVG1OWFRBSlZFU2xFSXFwZld3M1gzMFNwUjVXWlJGSEdwMzdvdXJWQ2xH?=
 =?utf-8?B?alZqNk0xazFTZTRMYUFNREVmaElYNGtXLzRtQjlkQVh5YnpuSDQ1dUNuek1L?=
 =?utf-8?B?TEV5dXBMTnM1azJnRC9qeDhaVmswRCtUS3lmWSsxem5FSGdYQWVoc2hjNkJt?=
 =?utf-8?Q?DRe22KX73MrKN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE90UGxtOGFwSkVwT3ZPNTI5Z3VYMWtNZ3p3d1B5SGh1UTRGSHNsQXdGMy80?=
 =?utf-8?B?K2tRcTlJVGovQndwbUhkSnpKYXA3eXErMW11VE81OG85OE9CdTZZcmlUYjBl?=
 =?utf-8?B?Rkg4L3NrUmQ5RWRKTXN0aWxGUkw1aVdxeWF4T2ZDaTJQY1ptalVvdWJxUFlp?=
 =?utf-8?B?S0RTNEVqRDBjTmcxQ2oyRnovT2JpMGZRclJuUTBwY0ZVSnhNdWNBWDg0L2l3?=
 =?utf-8?B?aFlRdHhiYVYzbmcweUZ0NG1obzM2NjdYRjkyQnNzdmNpU3gyOWQrNE1vbFBN?=
 =?utf-8?B?RjZjdldZNCtWVkprTENoekgxeUxmekt6b0RTNmtSK2I4MVlSSlVmTjFVb2VD?=
 =?utf-8?B?aUMrZERxa3haam00VHNuUUJ3ZWt0SEpTRERXN21Oa3VEWE5xUGJOMi9rVXBt?=
 =?utf-8?B?bkVBOVJESVVUUkdQUEFhTmw3czlaa281RzJyR2luYTdkR25JM2hCcXNiZGZ6?=
 =?utf-8?B?ZVBIOWEwQmhmM0hCd1BuRXBWMTkrQ2pmaWVDTWF3bmpUY09xNFBTcEdmSTRw?=
 =?utf-8?B?MS82bWt3dmZDWS8wcDNMUjNrR0JyaE1yRmV6UVUrc2c4SmNUUTJWbDFmWjNU?=
 =?utf-8?B?ZHlSUFQyQk5PZGpHNTYzeVFLaWU4WjJLNFhTUVhCdHhUTGxMMTZMMnhGV2xv?=
 =?utf-8?B?dGZTT3hzTVhGTkpMamZGbWs3VnE3RVRCWG1JYXBncWpOUy9sSWlKKzNqVGpz?=
 =?utf-8?B?S0hwWHhRN2FqVFVkRlp3US9qanpwK1lrSFZ5b1hrZXlpd3B4NTNJUkdEOUZV?=
 =?utf-8?B?SHVHcCs1bU9FU0FROUowZ0RiaGkwS3RDaHpVb2IzQjFKTnpRN3lVT1luOER2?=
 =?utf-8?B?cnFJdWFEUTNoSVdQMU9XTWNLZXhyemRYck9PQWN4MWd0b3ZTcmhkYUlVL0xs?=
 =?utf-8?B?K3U4VGw3V2VnZXVpNzZjSWpRUUNSTnVKenhpL2RrR0hkcUhQVThEOURsalVi?=
 =?utf-8?B?SGQxeUlkNTFxcFM5bGZpM3NBcmJtUUZwMVNEKzg2M0p2YkZaZWdTcWM3aGNS?=
 =?utf-8?B?bGVvMCtPYWV6ZExGK2JuUEk3Ykd2T0FwWUpFSi9LRHJ1NGpWMStmWUxCNlNi?=
 =?utf-8?B?VllPR3pBbWc3NzdyNGdoQmxOSzBhWDkwZk5XUlo2US9wZ3FGdS93QWErQXNW?=
 =?utf-8?B?MWhuOU5jMnBDYXFtVE5GYnNLMnZQbFdIbUNDU3EySjZNclVyWkJvck80UzRl?=
 =?utf-8?B?cUpBTURYUVFVbGNXRFc5bktEQ2loUDB2aVhJUDUwVUVnQ0tHa1pCbCtTUHBK?=
 =?utf-8?B?ZUFHMEMzc3NEZ2JhbGNEemFuQWxwTG81cHBwM2xOeVlHZ0ZGK2dKZ3BGNlBO?=
 =?utf-8?B?UWNob1U1a3pmN3ZSQ3UvMjgwUFhkeU9hZjUwRDRWZVNwMjJHL0tSaFJHWGlM?=
 =?utf-8?B?enVNZlZKVkltYmlRRFBpdXU5d0l5SGd2YXpleGl3dS9qaVp1TkJDNHNwRFNz?=
 =?utf-8?B?WGh3YjlRWUN0V2Y1K3Y0SnJrK3NwUWFMWm9lZ1hoRmhjbHV0emhsRHdtdklS?=
 =?utf-8?B?dWpPSGFCWlI1MW9ac1ZVRXp3bVZabVoyT3loa3pzcUQwV1BScFhpTnB1TkdX?=
 =?utf-8?B?QVh5N0d6NkFpbTkxRXBtMGJuSi9vdGczQVdySVAvVHlIeHNMc2hWRXNNSWlG?=
 =?utf-8?B?dUpWT0VwOFNDMWFlRDZpODg5N25ZSTdPUmFOQTUvdHVSWlFPdUNEWTN4VGVa?=
 =?utf-8?B?SzBZV0RadHRRaURyWFhqT2Z1SEdUTUxnQTZhTlcyRnhIM1loR0ovN2tKSm5O?=
 =?utf-8?B?OGdmNVh0UUZHUDN1OXB0TmU2MWtPK0h5YVA3TUtUZithQVk4NzVhS29rQ2N1?=
 =?utf-8?B?dUZrWDZ5MGxHSS9wbi9XU013V0x6QkJFVmJCQ0l5SS9rMTRET0dWamNjY3Ev?=
 =?utf-8?B?ekhWQzdnQ1gzb3dMWmRvcDdNUzRxNGFkYUxsYjhvODJWM0J6bGkxa3RPY0x6?=
 =?utf-8?B?T1JKVXlrQzRHYVp5d1k0TWsrNG15TWEvaE1JSzFKOXJoNENtMUo1bmJPbzNJ?=
 =?utf-8?B?NVhaeVRqTEtsdWJKU29nV0ZLclBYRG5OZ0E2eGVWVEdMYVhJYU92cDAyNUkr?=
 =?utf-8?B?eEF2NXZHeTh1Q2pRZTY0VTFLc1U1TFIvbUVpYTRBc1kzQ1ZPbSs5ZXNZWjlU?=
 =?utf-8?B?cGhvQUUveGRIR1B6SmpNRzJhbjdmNGd0Q2dGcUJiR3BWQjcydUhISkVBT2VJ?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ea41a4-8660-4bb3-8f3a-08dd568df32a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:49:42.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rW1fbM3kQC9w0dT43W+dDUSah3mkLymV7Ev7MjOAxFOQIMIhcCCqnV7T9HKMYNWRNgOH+quMkp4nfrR2g+a/hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150



On 2/26/2025 9:29 AM, Uladzislau Rezki wrote:
> On Tue, Feb 25, 2025 at 04:24:09PM -0500, Joel Fernandes wrote:
>> On Tue, Feb 25, 2025 at 12:00:18PM +0100, Uladzislau Rezki (Sony) wrote:
>>> Currently "nfakewriters" parameter can be set to any value but
>>> there is no possibility to adjust it automatically based on how
>>> many CPUs a system has where a test is run on.
>>>
>>> To address this, if the "nfakewriters" is set to negative it will
>>> be adjusted to num_online_cpus() during torture initialization.
>>>
>>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>> ---
>>>  kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
>>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>>> index d98b3bd6d91f..f376262532ce 100644
>>> --- a/kernel/rcu/rcutorture.c
>>> +++ b/kernel/rcu/rcutorture.c
>>> @@ -148,6 +148,7 @@ MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
>>
>> IMO, this should also be updated to reflect the possibily to set it negative
>> and hence to number CPUs:
>>
>> torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
>>
> You can set it to a negative as well as to number of CPUs or any other
> number.
Sorry I just meant amend the description to something like "Number of RCU fake
writer threads (or set to -1 for NR_CPUs)", so user does not have to read code
to know that (and update the kernel cmdline params document as well).

thanks,

 - Joel
