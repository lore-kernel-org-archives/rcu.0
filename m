Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9E1A9B48;
	Tue, 15 Apr 2025 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737383; cv=fail; b=Fi3rv1mfPjzI8cXhsuT/QnNFo0Df9MDth/n09bXxIh7X8EfVQqem5vikHVCeXuiG42SlaMZTVdvCOjAguvF7bVj4sBRgbWci/9Bvo3ohbJzgpDit2pr2755Xc3OIzam2eUjn26jw3eFzD5D3Hc6DaXzFPE7qpDGPn6KpCfEWCEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737383; c=relaxed/simple;
	bh=wqNoN9KMlYDG1s4aUQ/f9/6GTutv2QoIDSszgiqtk5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lowjTkFmyBIO7d8ty6liAPuS3zzXcCIdtc7uNb5tzMStrTKgBv7nRsQgb9cCU6TdHXjmZjX5z54Wn10FuevJP3dPQs5en+8x4GLhsr0fI6pC5TQtvFYIxStiKt6kVf4pS3J0VkmrCx7QrrowpMpDWznYWRvEddZPARKc6GUBDk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lVFOZlF2; arc=fail smtp.client-ip=40.107.95.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lVFOZlF2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKcVxB9zK0bPhMkxcktXHsrvzu4SdmoT1hwXK5tOS3cvLtEqkFNmfMCpSOuYilj7Z1gnZBqvr7ZxpzhxG+oPdvukAwDZ++5afZnDCDXWqkaaChgy6hhNqBzIMEPYBm13tOaqLR8fGrY/Z+hrS8FtYWUgUuAKmwrx/w19redV3pz4bEISeZLvua/r49rVRTvuWBQSq2zWcEyrfjJDPJy+uRD3boO7XJ0MQUcOOe7kIfjI+iO1APazAacvqlAc8wlMoWrQzwn8hMyqxKEYStRGz852/AkNtbGKIJC+96yv6zM3ODdm78L/EL5tgYF3zEd6k416YsQDBgIbtlHMXv+gog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EK8n/vySTPzbAiWPE/OHJWUkCOjz1B4Q16HoYTxXy0=;
 b=o/cRxWWm4v2vN9xhk7rfQEEBm8RZxbpZkZ0KRI2VjLYw5q7wA90A9mW6p++fh94v8XEssZPWBk9oQtUst7HsBdi7WCzyVMjrJujfi/Uuml3tTqLEItefPhQUzA7Jac2mEC8S6IMDopIJff61y6DtWIyvQf/FL4xdjJSwvQnvUnbJircTlMBzmcWobmOIbnvfCkaK60E9BziqlwD47XqSp0ZtY7DJLJ4iUqWKJLnYFdVWYGVDrFCozoS1ZQlDtb9TrLuEdMKtu/lxRLSKGW4VeZWz0f++dFc2p8FMU0sT71CRAiWNhhUakoM7IXOOBQtoXqyG9XXWlu345g9dhNxu9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EK8n/vySTPzbAiWPE/OHJWUkCOjz1B4Q16HoYTxXy0=;
 b=lVFOZlF2AYe76I+i5Xy7f46gbhbeqNSCpaLrupzOp1WhJdoSNKj3KcK6/3LRa0zUWF0JKYtOprdiOO4IyXxrNxPAUU67Daw18MuOgc+5yvI2hCg3iulMngb8o4hGlaGYnunjHIMVgYGBPx1Cp6+ewPa0vMJFNfTPKCexpAwtNFcGsHAYektMJG3+i+G10LP7ryZi2hKB7AWrTjUVGVjk+GfdqFDer4mXmjTK/8zDVxPmi0w3tPeBUCT6iqK/L3og5aeHU5qshKCi8KIDb5e6GGa0K/DvKcy0yI2PeGozGwLns3zk0ODcF8Gn7XAWt3LGumifDF64TVTHCwgBcYQZxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 17:16:18 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 17:16:18 +0000
Message-ID: <d40885a0-b0e3-4f13-a2b3-41ee2defbde0@nvidia.com>
Date: Tue, 15 Apr 2025 13:16:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] rcutorture: Add tests for SRCU up/down reader
 primitives
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
 <20250331210314.590622-5-paulmck@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250331210314.590622-5-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0106.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::47) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: e1840fe0-e269-4945-9c9a-08dd7c413c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1kxZTRrUUFiaEdGTW9yaWNGWVl2cU0wOUw4dzNtY3kreGUzYTdpbENBcHFt?=
 =?utf-8?B?bDMwVVhIRmNUN2paQ29zejd5TmVkWEs0eU1XMDlmOWhpMThNdmh6R0F3NG1N?=
 =?utf-8?B?VUNSUkpNdGd6RWJsL2hHa1ZlSEdUVTB2MWpYdmpYNVNMYng0dTZvRUpsQlZ4?=
 =?utf-8?B?TVVodE95R3lZcTVmeWRwUUZwTEtLTTM1UWsxd2EyenBnb3ExT3EzbzljWEJu?=
 =?utf-8?B?TEU1L2htMk50ZzdqUUhmSFNhaHNycXhUZkRFbnk0T1JlVUtzM1BtREd5by91?=
 =?utf-8?B?NUdlaFVzamh4RjhEeUFsT1dDZWErcTFxcmszV2QrZklpSklVQVVIdkhHT2hL?=
 =?utf-8?B?NnpJVlVPTC81MXo0SllrRzFMMUhSY1U3YllOYXdSaDJUamVWV09RbURJVlNq?=
 =?utf-8?B?TXZDNFd0VFp1dVJUYUp3OG5sUnl1eGRjdFBEVzA1UzdFcWI2MHpxcktsVjVm?=
 =?utf-8?B?RVhxTUVkRUZYNEtxUEppbFpWWE1GRVd3eEFURldqdTJ4WVhDVHJkZ1JmaExT?=
 =?utf-8?B?NThPM2FVblBFMDlvQ2JvYlQrRFFkaGhMOVRobDVuMURBSTYzZEl3MVZ0WG0x?=
 =?utf-8?B?Qjhsd1FNSm9TY2xmajBDeEs2WEtQNFV6aUp0blpkeHRmeWJmNkI4MkFWeU5T?=
 =?utf-8?B?MDd1UC80c2ZnNjIxRDl6K0l3QlVVcjNqUEp3TFNFR2dMT0FhVHhVc1c5VHd1?=
 =?utf-8?B?ejdzTzd2bXlyYWZuSE95SUdKaFVPZlJEcGpoVUZYaHBOcDJMOWg3bTIrcWxP?=
 =?utf-8?B?azBJOEZRdG9TT0psWFBJN3MyVTJrY0dQZnJoOUxVTThsbmNqbytnRzZmeUJm?=
 =?utf-8?B?NDUySENZSnZYMmNNT0lOb0p5VG4wOHYvRFVaRXJIMkozdmxvTVRQWDFWekNL?=
 =?utf-8?B?Yy93ZnpZV2VkUFRRdlJDSEh4U215SzgwOUc0OGNlMm96eFAzRHNXZHNWU2RB?=
 =?utf-8?B?SkZnRkhTamNyQ3kwYXZhNC8zeVZGWFhKblc4RXpXT3VPMFJPWDc5NFpwaGV4?=
 =?utf-8?B?SGpWRWxzdEtHbFF1MlJjS1o2NlZHZ2VjbDhoNlFSRWh0d1RqR0FqbGFrWHo3?=
 =?utf-8?B?Wk1PWUY0ZTJvcndPYjcyUE12RnU3MVZMZDkyRThuQUNDd1k3bnFLVVRubFZu?=
 =?utf-8?B?djZpSERYWDgzUU8raVVNT1p0cWRkdCtBaEovYkZQUytBb3Bic3ZjZXM2dGk1?=
 =?utf-8?B?Q0NKTHc4dURPZE0yRENueXhUQXNVNmsyR0FRQzQ3MnFPNEtKdFpFbzU4WTlZ?=
 =?utf-8?B?T0lLSTh4YTJGZXc2Ukk2N1N2VVVHTDBqZjJCbWhaYmV6S0IzSWVTcnFEWHlC?=
 =?utf-8?B?R21SNzJObm5EeVAwY05WTUdVZG56WSt4anVDcm0vRWRUcXY4cExXNUh3dld4?=
 =?utf-8?B?b1ZDS0QxZXlIeUJVc25uUzVyYWgzUGFmS1ZmelBvbGZxakJWUDltcm0vZ2dw?=
 =?utf-8?B?Tmt1czB1UTRmbmhrM0JMR3JmWGl2a090TGk0VC96K0g1MzllbDRsc1lBbmcy?=
 =?utf-8?B?Zm9VMjlOUUk2bDk1dWRqREU4eXBiYVBzTXQxd0l3enRWZW1maS9HM3FrTnp5?=
 =?utf-8?B?MVdyeEFUa0R4bEdZbUZEVVNRMEtIdEFqbW8rQXJDUW5LWkVUWVpIeFVvdFdM?=
 =?utf-8?B?SDc3Z3dvRVFsTE5sdmlZUmhmdU1rMjkyTlhXeDJ6cStUK0hXemFSUURKL1ZF?=
 =?utf-8?B?L2UxSjVsMVBtQjc2dmo1Vzh2OTZqVXNuUFF0alhqYUZIVG9DN2xLbDh5Q0NG?=
 =?utf-8?B?SFAxMjdVdFFiMWdnQUYrWFpadWRVZnczVWtyZjY2bmVJNmRWWDkzaEJaKzBB?=
 =?utf-8?B?dGthdTVaZm1PbUlKMUg3d1d3bGltSncwRzFjbFNwa2hjSE9JZ3M1akpUQ0hB?=
 =?utf-8?B?Qm1sWm5OTlY3K00rZnk1Vy81SWtHakp4YkFFM1RacWNOd0RncDFJZ0srbmxw?=
 =?utf-8?Q?48eP+eftlVk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzBZVEFDd2xrWFJEanJhNUk5d2hMSmZjRHExL01WdHJzOXJWNmpCWmtDSzJV?=
 =?utf-8?B?UWsxN3dSK05PYVhjZGFwSXlhNFBsci9MaDV0dTNadWZpOVBSeFB6d3pEdW1C?=
 =?utf-8?B?UXRxaDZ0Z1VZcG0yeWpVSWNGdEsvWWx1REYzbVYrbU9OS0E4R3k0Nm0rVVgy?=
 =?utf-8?B?bngvTytMRVh0bFJzbHplWXYwL1B4RVVIWm4xUm8vQ043aENsYXplQ3VBMUFy?=
 =?utf-8?B?QmV2ZGR1RnpWV2M0V3hiaDRKdHBCeit5YVRKd2pyelBDNTZzelcveUwxQWVF?=
 =?utf-8?B?cE9FRG51MEZkbGUveTNkMGdUOUVMQjhoOVJ2VVR0WW4rckdkcldrQ0wwQ3Ba?=
 =?utf-8?B?blN0QmNqU2hheEFmblFabFJCb2pUTGxCbjVmY290R0RubnJybldIRytpdG1y?=
 =?utf-8?B?eWZnVGNNaElnUkVITVpmZjJiTEN3QnNreVcxcklCQzRmckR4S1pyN0kycU5v?=
 =?utf-8?B?QXVPMThFaEljWmtoZlI3QUFuNXBwMmFOOTViM1FBRzNlV2pySk41WUJIUmVs?=
 =?utf-8?B?aVJPTlViemVzczc3bElkbG5CdXQxTE0zazRRRjNLT0NEZ203bjh1TDNTazY1?=
 =?utf-8?B?MlVuZ2h6SkRseFBRSGhUV1BBUHlkbFQrT0pmWnNUd01Gb1JpayszWjNScURD?=
 =?utf-8?B?RTBKNU5EWGo3V1J4YXJSN3VMMGRScndPcGxLeURRODFjL2wzTkp4UmU1Uzd0?=
 =?utf-8?B?RnBtTVhJL3FObVd1U0hEaS9qMjNzKy8yWXBObGNaRkI3YTA0MUN6MGdEZGJ5?=
 =?utf-8?B?UDcxVFB2enFBWStDSXlTNUFNU2xmMkFKTU9vUTVML0twNS96SmljZlFOYzJk?=
 =?utf-8?B?bUV4L1B3cnFFSG9CVlkzUDkxbENPdnJFSDlSUWloODl3eDhFVVJLZVNzdXIz?=
 =?utf-8?B?TG9tYmpwbnRmTGNwbE1XSFZVZUp2Nmo0Sm1sR25XNTRyWkllWHdrZTF4MlhS?=
 =?utf-8?B?OGRqWTRyUFBNY2VDU2Y5L0w0QUYxTDRRdDYyZGc1aHBTZGdpUUJWMmtNSVRN?=
 =?utf-8?B?WlpFaExkZUNlMHRaTHhIZWFibGdkckdMNC9Oa21XTVVFNE5BYnVrd0tVa2Nr?=
 =?utf-8?B?ekRCMGl2SDZtUmdtL2l3bXA5TW1GemROdXExN3VXK2ZzdGFleFExWnhxZ0dk?=
 =?utf-8?B?aklPTzhzODlVbEVIbldFK0hNSTc0UFJqWVVxUDh6WW5NaSttR1dhSHpjUXA3?=
 =?utf-8?B?TWpuN0txWmtBa2tNSlZHeDVPTHI3TUF2WXFSMDJvMzl6KzJXcnBGSTlNbDFu?=
 =?utf-8?B?UVFhTERXempvUnVTazcxbWZMUVRyZXpEREdjeDlta2xFaVQyKzArNVQxcUJW?=
 =?utf-8?B?ZEhTSnNlRk9YSGpQS0tGc1MvRU5ac0duWVNUV2hhN2RMRUpGK2pheEUyMlRt?=
 =?utf-8?B?VmhYd2ZkeWxGMk40emhpUTNsc1B1WDlLZndjcWhnVTZYZFBCZ3N5OGZWMG1a?=
 =?utf-8?B?blIzODEzREFWblp4MW5hQ1JJVjh5eG5FSFcwT0o2azZuNUh1NEx3Vmh0dDBa?=
 =?utf-8?B?eE9lQjd2OWxsZkhkeWpCRk15TXBGeFE0d3RyTW9WbVg1L1J1aGVHcUE4UGV2?=
 =?utf-8?B?UzMxWTFQQXBCaHRVeWl4UGhrWk1FWENVRHRkSmJqam91S1IzRmFGVU1YU1cv?=
 =?utf-8?B?TWdqd014K3RBc2J1dnE2UEtQOWl5Vm5CVllRTmlzM1VOOWIzWVYyY2Z5d0hm?=
 =?utf-8?B?SlJ6UnVKWXhFUEN6elg3K3JjVmRHcEZqVTNVZHJkR2pWUEhSMDFiUU1uTHQr?=
 =?utf-8?B?RWIwTE5RRW1NK2N1SDFvV0hOMzV5V3dHb2JlSUhhTjJRQ2YzTHNldURGWUVZ?=
 =?utf-8?B?U2xHWk9MU2MzUDVlYk1LbGZOSzlSVFRsQVJ5K0VkcXZiVWsrVHErMzF1L09F?=
 =?utf-8?B?VEpVajdsZmZaOGV6MlF0ZUhSaVpvRUpOc3NaaDZMeHR0VnVUbW9nRU0yYXE4?=
 =?utf-8?B?ZVVkS3VWZGFFclMxMy9TZ0lrUnNObHlKU2hkWXhneWxnSTRqMGlLVjhvRWpa?=
 =?utf-8?B?MUlvYVY3VGNlY25hTHZ5OXkxWTdwYndrc28vOWY4V0NiZDYyeG45eWh3Y1JX?=
 =?utf-8?B?dkNISzI2L1A5NVFyUEFiTjRiV08wN0l0TU05QTVMY0J0aG53N2ZUb3hkY1pH?=
 =?utf-8?B?T0pmMnh3UTA3OU9KbWoycU9yOWtxc01pK3pLNThQb0F4eE1lKzBubWtCNEN6?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1840fe0-e269-4945-9c9a-08dd7c413c13
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 17:16:18.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlgeolz1B+w6cuoelww5oj6ae9u6I3Y8wwyHedqflATFD3m86lZmAYKT6Js/Wukx05tioUorA/IupzONEpeX4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901



On 3/31/2025 5:03 PM, Paul E. McKenney wrote:
> This commit adds a new rcutorture.n_up_down kernel boot parameter
> that specifies the number of outstanding SRCU up/down readers, which
> begin in kthread context and end in an hrtimer handler.  There is a new
> kthread ("rcu_torture_updown") that scans an per-reader array looking
> for elements whose readers have ended.  This kthread sleeps between one
> and two milliseconds between consecutive scans.
> 
> [ paulmck: Apply kernel test robot feedback. ]
> [ paulmck: Apply Z qiang feedback. ]
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

For completeness, posting our discussion for the archives, an issue exists in
this patch causing the following errors on an ARM64 machine with 288 CPUs:

When running SRCU-P test, we intermittently see:

[ 9500.806108] ??? Writer stall state RTWS_SYNC(21) g18446744073709551218 f0x0
->state 0x2 cpu 4
[ 9515.833356] ??? Writer stall state RTWS_SYNC(21) g18446744073709551218 f0x0
->state 0x2 cpu 4

It bisected to just this patch.

thanks,

 - Joel

