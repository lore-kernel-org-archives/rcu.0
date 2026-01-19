Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A121917ED;
	Mon, 19 Jan 2026 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768860264; cv=fail; b=KNgD+UclFcMEbh3GKDuVpz27Xn4vmkT3wESw6RXiOODEfURu3QhAewc7lwDzb78pTTqT45qjc7yg1/Y2yi67h5wPhsGm0hDk7FFDP6y3gZu1iMA92a4QH+KelKTyxtV6js9pzb2gS38aKmWGsPevoJwRhQQ9Ng+Tr4pNoy8EKX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768860264; c=relaxed/simple;
	bh=YElBm3/FPBEtx0gRoAMmrBK43KtzWtNwFUSUF406szA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CqM+rYMvbe0oJIrCu1S5EluMe/98VWwsG6qpv5CjVcF1ihOwfvd4b0VmMos3+iDncYvb8ojMyoOuC25dZwtznZnCrhoc4h8HnZTE2fbBrW3Kk6uYlxg07S5R6byP8B6RtNZnEjUN9o8w5t+0b0BJwU8NmxyXVOq0g/3lUO+ejz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UFe58UvT; arc=fail smtp.client-ip=52.101.46.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UFe58UvT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OG37PkeejbKkRfkqyVoTDUNlUupXPWA5bJCPm203bkY0yCqzdruExw6gyddJTEwJ+b72bG23xTiACnIP1apExdZFiwA1fJreYTXTe0E+8QlLTB93hcl+Fr1XbBfpOGkwQtBYCFHTvuYlIQiSyDnAcjvXd/Pq70iYPAf2VU/w/8SzonKaWXYAvCalwuxz1CuXAToWg8eeVVUX0vSMcBqnnr65NCtEhgNIsPdhgNRk0ctoVZpvvaLAVbXDJJl0f0WwILHZM1Akwee9S9qkXpKOUztcCpdKfT0Jbb/i3UTDi6chcc/DawThL4ds19B7Ls7LDxGYndRp6WLHpDrtLHxMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUcbeMy7Ve00lNEeuV9ukpFWYzClAp5DN7vqoLeb0ZU=;
 b=TAIeZfFVjVmGPVi1f/yaN9Oqqj8RDp1oeYUVPtgebli+6wny2jLzfOOEqqQkq8xtuJH8N0Q+HW+ioU/sE3Udyeq5Gty5Lew9VTqJe538/3vdfhmw9e85w8zMFYr4uw7iZUzswSp6drV4Gxt+po603ZHcb4qEeX7wSV4aeCAv7en0/38UyRC3SRgDmedmSknNtEMjq8J1HrVosRUbEOA5lvpk9rcbsCEN8yDD4KRmjNhZe84icAcnViXjvDF4UcnxYuuGHfw2FGRibNmFuLhRjgogHs2qFjSP+BBuoxZjrRlKx+QfuXWkZ8vaqWMszxCoT8lSdHSoAjmkVh4VmuT3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUcbeMy7Ve00lNEeuV9ukpFWYzClAp5DN7vqoLeb0ZU=;
 b=UFe58UvTZNmyiN4DniO5AYq0hr1XFTaam2vuwc4ZCyttxcWOXBkW7dU1p40HtAfaDnbDcMkt2hzFYu7Lkex/iNALWY7+ZdtH62BiW0SCOk0r+AEyRVbwFRkiOtNrpdCZfOMvYXswhNjGj/skUw5RSvP0EZUHyORRdkgHbJUDft6P2ceEaBjStpr7ITTe1dW9XSAiS8zTzjfSxT8h18xLgCwlsvvizISN0MCuWsmQWqVRaYBmtg+XSyDdcEdusFMgUH+/raTEP0GJu96vv5Q75ZT6JY9wc3I3Nw4CqKpz7hG0/N/ImHF4TpvCCVRbG3m3x6kEqj+vuiqm6AkkDcSPYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.11; Mon, 19 Jan 2026 22:04:16 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 22:04:16 +0000
Message-ID: <dab39950-569e-4363-a9ed-7e515b114f1f@nvidia.com>
Date: Mon, 19 Jan 2026 17:04:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 2/4] rcu/nocb: Add warning if no rcuog wake up
 attempt happened during overload
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>
References: <20260114173154.1701056-1-joelagnelf@nvidia.com>
 <20260114173154.1701056-3-joelagnelf@nvidia.com>
 <aWqz9Wvrf5683OBQ@pavilion.home>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aWqz9Wvrf5683OBQ@pavilion.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0003.namprd15.prod.outlook.com
 (2603:10b6:207:17::16) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 39084684-5a4d-48de-9d5f-08de57a6affe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXJ5cDB2eVRDRmdsTzkxT3JkMGo1T1I5eWRuWjNobnRKaGQvOTVGVUZnNVdl?=
 =?utf-8?B?VmdWYytvK0piSVJBR1BHekFTUUNmK3JlQzZxYnFzbWZONkJLSHV5aWJsRWxq?=
 =?utf-8?B?UFM1a2F4OUtFa2lMOTBHNHN0SVpIdndzeXhDQVUxaytodEZRUlJBQythRDh2?=
 =?utf-8?B?MFYrSHdJU3hmd3VibzAzd0hEenNBT0lPSURMYjNIN3hmbWY1TjVjSDl3blI3?=
 =?utf-8?B?amhaYnV6cURiVUNpYVdxYkhBTlR1dzc3YTc2cjZVcFhVZkh6MVFIdWR4UTRX?=
 =?utf-8?B?cjFud29vdjIxdWEvb2MvazhReGNkdDBkUUhwZ3hQRWxZRU9SekF4RE5OQ3BU?=
 =?utf-8?B?V2NncWk4MFNqelpvMkZiZGQ2UFM0ZzdPbG1OOFFBR1VsOXg1dk0rWDhyWU1S?=
 =?utf-8?B?QmlqTG9OTmxrSnpQYzlucisyU1pjbmlOTURCU0pPNkp1QXBoVU93NTQ1aVZY?=
 =?utf-8?B?TjRnOEZ4K05yRVA0Ym9GOURQeUNTZzViREF3UG5YQlB1eWpqV2RqbzVrK1FO?=
 =?utf-8?B?N0g2bmVKdE1BMVppcERySElSRWVQVko3L1JRT095MXZzdHpXbGxkY3dYYzVY?=
 =?utf-8?B?d1VKMWFydW5jenM5WmFtUEd6UWhwUkpIaVpwSWZ5akN6cFV3VGhiRFp1OWxS?=
 =?utf-8?B?TDFXVU5jVjhZQTJ6enlNdTZnWTdxcjFoSVFab0k0VGoxaG5TWkYwSWprdENk?=
 =?utf-8?B?REJLM2hUS3c4M2dZY0tzVWVUTDJKUXJMWHIzYmFWbVcxMS9zVGE4SFd2bWw0?=
 =?utf-8?B?bkttaHJKM0R6LzlpbURzVXNGZzNpQkhxYld3UUU1UGtpWkVtVGcwZ0RYa05j?=
 =?utf-8?B?Zm1Ham1DcExBVXFHVzNaNVFlcGo3aXhaaWoyUjdkd0xJYzd0YTZXa0FraW1N?=
 =?utf-8?B?aVUxUDJtQXJOZ3ZEc2tieXovTHhMY0ZqbWtpTmpiUDdsUGdOTnRZd2xrZTBh?=
 =?utf-8?B?aE9qWlBLL2VkaG4wSWkwUTFBbmJETTR3UzdIV0VrTFhsNkFCb0RWaVo2clg5?=
 =?utf-8?B?cFZKMFpqWVhuM2ZMNC9adGp6Q3FJSG5naEZINTduU0NmWVlLaGtRMlI2VTJD?=
 =?utf-8?B?dy9RSDFxY0RkcmxQVnRsV2xsamJoRkRpeFkwaTZ3K3VKVnRuY3RZOEp5Q09P?=
 =?utf-8?B?TWhqeE9IeFE2OVVEZlZ0T1dma2Fva1hoQUJERWp1aEdnYkZreWpYZ1VFWG9C?=
 =?utf-8?B?YUZYY1lqWVU0UjJvSFVoQWVNY3lGR1VCZFl5Y3RmSVBiWWRwTWFzSm51cjYx?=
 =?utf-8?B?Y09DY1FXWHR1MmJ1TnI3dWl3Sjk5b1JEeVJWbldXS0gvQXZFenhvUFZSbTk4?=
 =?utf-8?B?dlBVaWltTldhUjFsMkdwM2w5NWtMcFluWEFYM3dDTGMxeVhiV2I5U2Y3dXpY?=
 =?utf-8?B?TXI0ODJxOEhYNTZrS1V6MEowZGtXcU1xaGthd0d1WjhFbVk3RDNOL1pzSTNw?=
 =?utf-8?B?aEp5SzRKV010UThLQTg1TEdGeDl3ZGUveWJQSGs0ZXhZZWRlbzdsdEp5dHBD?=
 =?utf-8?B?K3A2MTBkTGRmbGljaXdVS0QzK0pxck4ydmNYUWtvdTQxOHB1Z2tRK3NUZHpF?=
 =?utf-8?B?aUZGbU5OODJNTWJydnZhMnFWcWNxaForYm9ISDBhMlZzQTQ3bTlSWndjYmYw?=
 =?utf-8?B?YjJBSUNzOEl6dTEvRGQzMDk1T0hOdkl0L0Z1aUxrZUhoSTJ6SHhsK2NaK21s?=
 =?utf-8?B?bDBObmtnOFloK2JIdSt4S1JOOVlpNGdxeFg1bFN5ejlIRkFHSEVxL29IbjN1?=
 =?utf-8?B?cldSNHhRd1BsVGN1NmZiMTdXSWRzRHB1ZytKYVVJdlBnU3MvRzgzdXBJa1I2?=
 =?utf-8?B?dW41SU9wdldMbmQrZURlc0x6Um4zZ1l3SHBUVXBIOFE3N1JkUG5DTDIzSi8w?=
 =?utf-8?B?cGQ2czBPZTNuMmtkVXpHZ0YvWHFJTDJELzZta0Q2MXNaZkdpdEdEem80MXU5?=
 =?utf-8?B?T1JGcDAwZHl2Ri96S21maUhPNVRvTFkwUjdwVlIySkY3VTcwNU1rRkM4QVpy?=
 =?utf-8?B?WTI4dldBUThaSml3SUpKcDJ3Z3ZCWk1pYnpwNDY1TDNtdi9zTVNTc1ZnWk43?=
 =?utf-8?B?OWg3QnRaRmw2VEhYRVJSRmE3d0Y1NDljMWcvNklTRHRsMFI0RnpwckJHVFRn?=
 =?utf-8?Q?zhWo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnkzZm1rUXFOZEJZREYwcE5SdnJqSWs0R3dSUHVpZ09tdFdwUDRsRjFJaHkw?=
 =?utf-8?B?bHhtaXkzU3ZVenp6SEFCaG16dFozZDQrdnE2Y2xrRnNNeFpEU3lFcm9GZkpK?=
 =?utf-8?B?SFlMOWFoRXE2b3FVdmR3Z2dPZWN5T0pWSElTK1hjWXlrc1JYQndUeGVhL2Ju?=
 =?utf-8?B?dndqU0RsRFd1S2lKRDR1NmN0U0tSSHZNOWNiUnFFdzlzS0RoamRPc1dNMGxx?=
 =?utf-8?B?TUJhRUVlMHAyVVUvNm0yY1BuWXJucis2SGtsbFVrQy9SU3k4RXF0dlVTbkVu?=
 =?utf-8?B?NU5Vd09DZDdqem5vZnEvSzlwVHNQQ0FXVWtRMGJiWGJLV3pwVWNKTkQyZkd4?=
 =?utf-8?B?Q0VEVjdrY2VuaElYR2hxRlhyL1ExUnhvbVZSdGE0OUprUkdRa2J2UmFDeUlo?=
 =?utf-8?B?dXdBcityNnVLNEMzZk5DajlXdjlKVlN6U2dlSTFVNThmOGQrL0FGazhOY0c5?=
 =?utf-8?B?Wno3alozMDdCMWVkRGpMRFd4U2tqdzllcmkzUnVKVGFUOXpONmd4WUErZjZO?=
 =?utf-8?B?QXkva3g3d0FIWmFJcUJWR2h5NGlWTGY3NktHSWZ2MUZleFMzZk9FUGZHdHJE?=
 =?utf-8?B?V3cyUkk3THFKUHFOa3NCSDZXcVBZaUVnN1VJWkpuWFdWTjBIaVFyK2IrQVZY?=
 =?utf-8?B?K0xoMjQvZEs2Tzd2ekEza0FDM1NoYUd2bXlCNlByWm4ydm1pR2J1WllEdTlu?=
 =?utf-8?B?K1NxRWgrOW0yN2lkV1ppUVpiYXJTcXV2VldlOTFvM0M5dmRXZXZjVy9SQTFK?=
 =?utf-8?B?dCtMRnJjbGlWS2pIOWs2Z0FBMHJjbXY2Wm5pRlJTNjV6YTVzOTJXaDNxNWlv?=
 =?utf-8?B?RTlwUFJkVUtVek0yNnM5aWd0cUhXc0JlU1lkWXh5QW10S284SGF3dkdlbXVH?=
 =?utf-8?B?dHJtNGhRRVNXKzBpWHhVby81TDZVRTRNR0JKRDRrV1RZV1NjK1hFTUtkODVp?=
 =?utf-8?B?c21jZ0lFd2lmNjFtNjRxbEppUjNBTnBlekZmdllWSE11dnVzSVhvTkw2WVZw?=
 =?utf-8?B?Z3BXLzB0N2RDZm5VZVVZYzdaWDdrUUdpMGxsSUxCSzA0REgyUm1ueUdwa1o3?=
 =?utf-8?B?TGExMnNpYXhWcEI2OFdjdjcrOEpvTHFPRGo0MWMreGc1ZlpaNGZVRkppUlE5?=
 =?utf-8?B?Q3B4RWdjWFUwU2VEUEozeGZ2Q3NlallSTk9Ia2xBTVBrVmgreittb3J0QnFW?=
 =?utf-8?B?bk45Z0hZM3pYeng2M0dCQ2JHb1pyT2xlMDdZTXlNLzBBS29IREQwUGVFaDIw?=
 =?utf-8?B?ZU8wS2QvRGdNZjJIeHJkN2lNYlVVY1kwam9FMkptSDhiUU0zQm0zSWZpWnBC?=
 =?utf-8?B?a0lHdWxKYVJhZ21LKzJkWEtQb1UvOUpzSUFhT3pBVkN6bkhLNDZMcWliOVRm?=
 =?utf-8?B?RVQ4OWlSWWppMFdoZElQRmVsWGdCZWhSUGZheHlPaGRoNVdVS0w2aFN4S3Iw?=
 =?utf-8?B?RDk3NnJ0N3pPaHZUNkl4MzA5bUpZd0d5NEtDUXZEWnA2a3d3RE1WYXVkU0w4?=
 =?utf-8?B?UzRjc3U3ZkZCZmJ4QzcvWWZESUZJK3pwZGs3b0wwQUM2SXJYeW9GNjJrOG9G?=
 =?utf-8?B?NWF2Z2wzOGxSekM2SG5YYXRJZ2t2ZExjczJ5MlRqcEtvaDJTSUxYNkJFZVZ6?=
 =?utf-8?B?UC9UUXluNUNIdnQwUUJyczQ3UTluSkFvSEVnbDVhdE85ZkJxeXpMdzhzOWp6?=
 =?utf-8?B?SDNYRWtybjlJL21WMEpDQkhXbEhCUjR3K1dpODJLNmlLTzkwQU1yQU44SjI5?=
 =?utf-8?B?ZXZ5M1RDQ1U1bW1hRDIzT093MDQzbkRGU3I3L0VEOFJnR0lkclNMdElTZzg3?=
 =?utf-8?B?UGVpTDNqcngrNWwwcWVKTWFCVG0xWHBYTGZ1cktVYVRqeXljMENkdGErelJ5?=
 =?utf-8?B?Vmw1YUl4ejJHbzZDeTYzY2NkRmthajlDZjFZNXRWYThYdWliV0QxMk9MaDEr?=
 =?utf-8?B?L3Vtb1RVU2E3bzJWVnp5OVZoVUF2NkY5VU5MNnpGNXNlWlp6bTZiQUwydkRz?=
 =?utf-8?B?VUpGUHZqSUlQdVRTdHoyOFluS3BvZlRXVG1NdE5zTS9vVGxsWkpNOW9yS0hC?=
 =?utf-8?B?MUlteklnZVlLUmtnRU9NZjM1Q1BtdkRoSXZXbFRSY2p1Wk9NSzZMQmpEdnk4?=
 =?utf-8?B?eDI3d1VhU1BTMXFLU0VmV0pNbjk3UDUreDJGeDVaK21VRUlPN1djOTVOMjdv?=
 =?utf-8?B?aGd6NEh6Qk50L2xQVzhXakVxK0VXdzNVdHlobWh5ZHQ3bmVMWHhNdFEyMUxq?=
 =?utf-8?B?U1VWTnlVVXdNQ00xQ0JLTjNob0hKdEU2MTBYeEc5KzJ5eFoyWEpHU2JQZ05q?=
 =?utf-8?B?ZGxXMnBudjVKMllvUUZGTElnSTB1UFYxTTJIdUdBQVdSWTdPb3c4QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39084684-5a4d-48de-9d5f-08de57a6affe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 22:04:16.3856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5izGI7J4n4yRvGIb0Jt3cB8ebWDUd9Oezmj/QR87yvQnXAHH9AURyqKJhf2GTsWzeirN8C6dMyRo8p+LFaNLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246



On 1/16/2026 4:56 PM, Frederic Weisbecker wrote:
> Le Wed, Jan 14, 2026 at 12:31:52PM -0500, Joel Fernandes a écrit :
>> @@ -1254,6 +1262,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>>   			continue;
>>   		}
>>   		rcu_nocb_try_flush_bypass(rdp, jiffies);
>> +		rdp->nocb_gp_handling = true;
> 
> It should be true already, right?
> 
Yes! I will drop this hunk on respin, thanks.

  - Joel

