Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD02728FA9A;
	Fri, 23 Jan 2026 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200989; cv=fail; b=aLzr5oGkQuwB+k/CJJmggfKlatq3XTIsURGnstI+ljFfwTptqR3Y3HsuEU+AcLg8/UbTxBGVtJuNHNoQbotVy/UK87IT8ay0q88AijzGLt/ACmxGMLd9jWkCFqARdhoctqx2s/YzrxWDIMZD7xuhdtycfBFV4iqGHj2zUqvos4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200989; c=relaxed/simple;
	bh=cHmIJOyaUsKHmgpRRVDxc29S5KcQmlgS8J3iHitX1z8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JvspV6xigHOOwyi1wH2kn8KMfdErKORYgXYXacmnQc3ckFE7LzjfMb8JrhLLQlnrJS3XvyG/ADsYC8syTsCzdMrQW0QrtdWf+9JV583QjXsSXxln14VdDzjn4xmeeKBaA8ZCNTMMK0V0D+ECCARrDRsisqssctNX0hWJ7uhkiEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=heYAA141; arc=fail smtp.client-ip=52.101.46.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="heYAA141"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdlSSK2+1rFeecghPJ0j7B+Xj5UornigD6uLxkOLlpGLof53f3q4kbMuv/ZDhxDH05M8CMVa2yVVbRgMQJlsR2mR1Nj2omogcA8itboE4CTPddkowd3Y/IsFMqGK28GqjNX4YRxAdY/QTCdzo4gB51lBFNE9NrJs/tuUCIwib+0raEGD5cSVctFfLckSELZzaoE34vT98ZMGJ1BDdWS1S1skdLcpM/RkPk4G5Y9e3Nu7XcmvAtYn25uAvn01W/87SNO9unSD7ZB7SVak9rEw8GEOsGWn13tG8XI6QGCnh3Hwa/DZIOmZHRvlpkrxsbVem/RFXBIKrua9cBx71pSSVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEQtVNEZMIuBzmnpdJ2nBkjMLWM/b6pImZxSzvl2MAw=;
 b=aCU03bZf60/Xxn0Eh8oOWzD2betYeq3mLt56K+yIJDWsv0V52UoGvMGE3A5aG/eQkVfoXAx+qp3kIYTrjf3CaborZ5NgSCvnF2Spsc3UzU8flo7/oNnfK1DEjW7OvUwb9TDHuGGeSq27ugJE2R7YSAm1cae0Ltit1R4JwOJFAwlzf2YoHO5gWYU4IqkPJhGp2nicOyi/a4sXkoPE7al13LkRK+iMawJ6X16cO6Zn2dQ3SZyc3Pjo+A8XH6XEMz2cFgwrgoXJAPm9E3FVaXM69W9FbrvN/ZKnUJcE/pv2HKCM3BlMqA0LIrSqeEtnkHU9kLnfVfLZBi7MbS3m0nDgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEQtVNEZMIuBzmnpdJ2nBkjMLWM/b6pImZxSzvl2MAw=;
 b=heYAA141qgPL8vrE5NKDoMEi21SZ3U5X/s3Pmfq75PnoKQ/Ijpy4Yv/iTLDSU0tAcPdMJwxteY77b/ZlZ/YlRMOPYpCGizNmU5+djflp93r44/fsv9dIgU+KDn75p/+SQO3zzJGDVgjKNBaiQQaqIV1jE4RMRkobwd0iMX3bE0FZunh3xaW/TGszcIEaPg4DI/MgzsH7NvzHpSY7vU780wGx1VKJ7tra9yUBrG7wb+JtAPqmU+V9D9QmRd4QSiarnY9/faSRyAp9c2OTAxshIsuv9bJZwAn26Rh1f0SLAxt5c+LFl8kNN3qVis2G3id/MBWHuI+UEF3B/4BKLLK9ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.12; Fri, 23 Jan 2026 20:43:02 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 20:43:00 +0000
Message-ID: <6441f33d-b4ac-4483-87c6-236998803338@nvidia.com>
Date: Fri, 23 Jan 2026 14:36:37 -0500
Subject: Re: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload
 handling
To: <paulmck@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	<rcu@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
References: <EBEF016B-721C-4A54-98E3-4B8BE6AA4C21@nvidia.com>
 <013102c7-a1c8-4f13-8dd9-5803e4d69aaf@nvidia.com>
 <68fd874e-ac9b-4d91-ab05-903bf45856fa@paulmck-laptop>
 <1737646200.reply.joelagnelf@nvidia.com>
 <735d16d4-f727-4cc1-91d8-16155135f550@paulmck-laptop>
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <735d16d4-f727-4cc1-91d8-16155135f550@paulmck-laptop>
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: BLAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:335::19) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: de043623-42e9-4ecc-b394-08de5abfff31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmxMWWlQOG1YWjdOWThwdU5qSzRYdDlsc0VwbmVTZ0p2MGsxV1NVcUppY0xP?=
 =?utf-8?B?Y0luQTlubmEyWXovM2VVSDl5dVpRK2lJZ0hnNEdjcFV1YUVwVlRyZCtvRVJG?=
 =?utf-8?B?S1VFb3hxUExZWGxQWVZtcklUVlN1c09SU1I5K1dsQTBNZ3ZDZ1NEUEF5OVFT?=
 =?utf-8?B?ODV3WlVIMUFPZ3dienRYU3pXOTVwN2J4SjAxRVVCK1ZCQmdYbVI0dGdwOWJY?=
 =?utf-8?B?a1Y0Tisxd2pKQUpHcmFDMmxUTGZzMzg4Z0xqWWxWTUhhRjlJZXVZQlhrY2U1?=
 =?utf-8?B?aWluWkl6ZE9tV1lza21ZaTc3NVIrejJuYjlOMnFiTmwxVUtXeFdCVFU1RUw3?=
 =?utf-8?B?Lzk3SjlHMVE5U0Q2cXBRbnZxT0hSK0lJdW4wd2dQbjZpeHM4cXQ4bUozZS80?=
 =?utf-8?B?ZTJ6Tkt0SkQwcUdCT3I3dmdzRUxubzZVYjVqSXA3eCtsbVp6YTlRS0JPbng0?=
 =?utf-8?B?RWs4T2NTalRZNGRwOC9YUGFMM0EyeUVKSnBqdmtvVG50OEVRRTRBNU1HaWRB?=
 =?utf-8?B?RUJSZUxVYnYwRUNEaThUdTNaYnJxVGNPR2FvdGJtSnZ0YkFYaXU3Q2ltSjkz?=
 =?utf-8?B?bmJNTGRoMXpxVE50MTB0ZUo3QkpQbHlZK3JyMys5Nlk3T0lhNVFlblpReElQ?=
 =?utf-8?B?STc1Yjc1ZmVNZEoyeUF0NU1OOWVWRDVUOEc3NEs1OHE5cUorak5CR3pqcUg0?=
 =?utf-8?B?R2F6TnhrbUswU2NjZklITXhMM1dXTDNSUDdwQngzbU1veUpZODk3RllwdERM?=
 =?utf-8?B?ZUdvb1dzTndzalpnbTlnRkxrb2o3UUhVZGJJSk1hYnBPNlNkelJacFRpcUFQ?=
 =?utf-8?B?M1FIWFFMKy9OTWxsdHRDRmc5Ym5CNlhKRHRzWU5CRmNhK2c3VGJaOFlKSnFp?=
 =?utf-8?B?R2hMTFovMGpDSkN5VXJ2YWJJZnVCVUE0b1VnOHoyODZyNDl3dEtYdThNcHhD?=
 =?utf-8?B?TU1VazRjWjl2dk1KN253NnhRZnZjRlh4WWNSb2dSQThmTFVEREtLVituQU5G?=
 =?utf-8?B?VU01bTVRM0hlQ0szNjhnbW9NTE0wdVNZK0VrNmhwOGo4MWoveDZsNytaUEo4?=
 =?utf-8?B?V2pCZGhGSFRTWE9uWHdBSWo0NVpmWlUzR3Y0amFQOGRQVHVyQnA5SmJ5SThP?=
 =?utf-8?B?Qk83cklGcWpSMm9MaGMzWDhOWGtjZ2ZJZm1xQyt2OVJKOFN1SUVSU1hqaE02?=
 =?utf-8?B?ZWR1WmhFR3NYZmtNT1lER0JGWlJraDBTSmZxcXVzS1RXSWNka3BwNnFkamd5?=
 =?utf-8?B?c0VJSmVNRW45MzFjdUdqNnY4N0lnWVFjR2wzbmM1ZE1rL2hJM3lPUW1ERVpO?=
 =?utf-8?B?WWFZZ3NtN3pCcC80NDBWOUNlTXB3M2RhdVdWTlZtWlZRNTk3KzJkU2pWYW9q?=
 =?utf-8?B?TWpXdldRckhEVjBydVkyRmpmRnhvQjAvTFFJdlY4czdNWGJqckN4Vlp4bitD?=
 =?utf-8?B?Q0h5SUFJUjFyUkYzQ2tCeFdvdlBwcDV0WHEveTl1aVVLaVo1TUVmcUFWRStR?=
 =?utf-8?B?a0RKRE93bDR4U3FUV05YZTJVQ0NBY0pobE1wV1ZKemE0T1VPUVAxTEtvenFF?=
 =?utf-8?B?V0hGb1ozam85VVhQQVllODczc0I2b1pvcUd5QVk2WEEwL3RIM3Btakx4RHcz?=
 =?utf-8?B?ZmNZOERTLzNocll6WUlGRUQydXpXa0JGV1p4ZzlOU1liQnJEZFB3N2pZb0xZ?=
 =?utf-8?B?OHFiTVJVc1hqWnhDSk9DSnRpZ29maTZSbGNQSnZkZ1ZCdmdJeGc5N1FPWXAw?=
 =?utf-8?B?U2hsVzQ2K2JVVjBHQ3F4bHRXZk8vdFB4QmpXaGttekl3d0dlS0FNY0RKbHpV?=
 =?utf-8?B?dmhicGs0VEJsNHRObC9GVDBtODMyYlJwOFEweWRyclYzN2dSV1NvUzR1U2Ev?=
 =?utf-8?B?YXY2UHhzV0U5MWtjRE9XU1VMaFFmZWdCUnBYYTNZN2JDVTR3bzNXeVpZeHZw?=
 =?utf-8?B?N1huNmpxdkJQVWl3WUZ5U2xVbkM4MmRBRHc3TlhjZTFNVk5SaU9zMUIyYm40?=
 =?utf-8?B?Q1RsNkp2N3NVTlJVMTRheWJCK1p5cUhCVm1DTlFtWG1RVy94WnBFdGV0ZGh5?=
 =?utf-8?B?WjJjL1JkT0Z6aDg1d0dXMk11OFFydHZrKzdxdGZHZ2l0ODcxdXZDdTFnOU5V?=
 =?utf-8?Q?cwEk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnB2d2hHTHZoWC9pVGhaa1dPU1pnWnh1a2ptajYrTXBDZFVaa2UwaHNGMWd4?=
 =?utf-8?B?dStnZHFGeE9GaGllM2JiUVI1U09GVXFqZGZoMGttUkQ2Q2JTZjRJSU5mMFdm?=
 =?utf-8?B?alBnNHNSWTd0RmxKcDJ0WWhSR0N6YjFUZ1cvV1hkejdnZTFBSHZ2M2hkblha?=
 =?utf-8?B?T3AweDB1OWhmN0k2YzlzLzdsdEdtNklNY3BSN2VmNHp5YXNsWGFTekViZnRO?=
 =?utf-8?B?aTF2NnVUQ0R6SzlBYlhQS1h5MzJmWk0xTzBpYzJnVUQxdDJrdDFQTWczbGls?=
 =?utf-8?B?NCtXclIvendwMHlRN29TakViM3JzWXYraHovZ0d3UUp4dHhJNFVnamZ2Rm9G?=
 =?utf-8?B?UFFabVpmZHdrOXZ6TThKOWQxS3hzV1phQ2tLenlPQUZidk1YZFZ3eW91V1NK?=
 =?utf-8?B?NmFHUE5TdHZoZnNHc0tHSThOUStXZ2ZUTHorZWkzaGJ1b1laM296Nnlpam9B?=
 =?utf-8?B?bXpLV2NrRmdZMHZnSTZiRGZvQ1ZsK05YWlRQMmZBc0xGa3RMa29xSzZlbS9h?=
 =?utf-8?B?SHpNUWJVWkZiQzB6YWdBRXJOWnFVYlluSzZsZXVEUVBlUEdKWkZnRGNnSEVT?=
 =?utf-8?B?TVBwRlFkaGdWYVBEMVJOUU05ZHVOQy9jcHp0S3BmSTBSVmp5Rjl1Wk84Vndm?=
 =?utf-8?B?d3VubE80ZnQveGpYTWJEaWNmb0NqSTU1a0EvSDh4L3FvaUZRdnRLcm5QNGlE?=
 =?utf-8?B?RG02MDRRL3Y2d0NvbXZBSXl2V1ZSQW5PV0VjK3VraUNYb1RTOFBZSkJaUVhM?=
 =?utf-8?B?MGU2dGF3a0hxcGo3aGZCbkcrMHdpNHlLY2RINnZ1R0lxSFdCTDJFSHR3bmJy?=
 =?utf-8?B?dXowT2VQbnNyNEIwL3JyeERqcEhPRXNOTUJmdkxhdkNNZjhVYnJ0ZnNCTVZh?=
 =?utf-8?B?VVo2WEFQK01CclJudDNKZ216R0QwSDVzQjkwZm4yTGlQYlpOU2NpcEdUUzl0?=
 =?utf-8?B?dHc1UTYraUErU0xiaHFVbWFsZW96Y0JxVkpJbXROR0h5VW5jNCswYklRaWIr?=
 =?utf-8?B?SWxCNzRlaitsdlUrYlNFVFN0VG44M1ZoeVNqSmcrNGRucXgyKzFuWXFOVkhK?=
 =?utf-8?B?WmlTTmFuQXQ4Y0lEQVhXTFhsVWpDbFdDUHhCOVpjOC94Wk9WZENjbS9EKzRo?=
 =?utf-8?B?a3pyci9jTDZxRHc3aUZ6R0djMjNaUmVidm5aMndBRHJsMTR6R1E4b2NvSFFE?=
 =?utf-8?B?Ulo3LzNBTkVvT2V3UGZJb1VOZTFHUGdvREF6bFEvd1gvaytPUmY5c3NMVStL?=
 =?utf-8?B?b2VGMkRBeHJnbEhXK21Xbm10M0NSeWFZcmhNb0c2Z0FGem5pZUIrV21MY3NX?=
 =?utf-8?B?YWM5a1ErRU5haFhkRlN5NW1pSkhJYnNQc203b3IxUTdjS0xjVnpLaUt2SkQ4?=
 =?utf-8?B?RkFQUEFvOUtLYlNCNHo1Yzh3RGwwMU82NEh5Q1BsK0hmalNJRmxPRFFlaEd1?=
 =?utf-8?B?N3RRdTk2OHhzTEZCM0gwOVJ1STcyRDVnSHdPblVFeVpuQlVoVGN0WHZNMEtZ?=
 =?utf-8?B?TzBveFd6b3AxNUpOUjZ6d2Z0Z0cxanMxUTJMRCtYT1RubnhJM2hwWFU0UTJC?=
 =?utf-8?B?cUNwRWlDdGwxTW1tU01GNDlNVmxWSVJudmNWN1RKcWtkdCtDa2tPNFpsZkJ0?=
 =?utf-8?B?M1NiNTJET2gyQXV0N3dPcFpIOGJYODFTUUE4K1hpblhNU2twUzZtZ3M5S0NT?=
 =?utf-8?B?T0xMZGt6UHpwTTIzZDdlWVlNS2hMTkN2TTN2dkVyWlRXNHBkYWcwN1Qva1Nv?=
 =?utf-8?B?MzBTdFZYUnVoZDU4SndZOUhUMldYd3EzRDAzYXZlZU15Slg2NklucjV2WXJX?=
 =?utf-8?B?SC84T0VRYkk2L2haWGtNUVZsUjhPSlpDeGtkbkx0dGY1R2xFVFdSdHJ5VkNO?=
 =?utf-8?B?VEMwTkI3dVU0VDE4cGVFSE1yQmZHQkRhZzRQaS9VTlNWcGVVUTF6VS9PbmNH?=
 =?utf-8?B?OUIvanZaUXZnb1hrandTNGxXUmVlNGVmelVpUFl4WTNSdmZmcGdBUUROazVz?=
 =?utf-8?B?QVpreWFCbUkrQnZpeTZKcVBRZEJZaWZQK3Rhc1ZRUkRZQTdqeitaVzdaV1oy?=
 =?utf-8?B?YWxUTGcyZG1obzR4NGpYN1RwRSswMXBJWTAzazNpNHlFdjdac3doRzUyT29P?=
 =?utf-8?B?OTg1bkpBNDl4elJ5MjZjenBFaXY4eHU3NXhycm02RVgyUHNjUksrc3YyOU5R?=
 =?utf-8?B?YU1EVW9NSEZwTWIzM0tTNG53V0NDV3BkVlVGNDExMlZOK3VDQ1lBT0hXbVRt?=
 =?utf-8?B?TWFLKzBHZzJsOEtpNW42ZnpGRXIyY3R4TDlKampwY1NiZFpXbE4wK1pNWUZT?=
 =?utf-8?B?SE54YS9GUktwOXZlTktTZU00YkFmWWhZV1BsNW1ONVBhZWxMVUcxdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de043623-42e9-4ecc-b394-08de5abfff31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 20:43:00.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Hfy0tOSRkNVCOXvabZQwLtKdezsj/1UaqkNmYE0hsbATO0iEyjjasIGwcbm3FvSvjYQS5CT7SNHYIx0WBDPFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569

On 1/23/2026 11:49 AM, Paul E. McKenney wrote:
> We could have one CPU flooding and the rest idle, and many other
> combinations.  And, if I recall correctly, polling can burn extra CPU
> and cause extra wakeups even when the system is fully idle.  Or has
> that changed?

In my experience working on lazy RCU, if you have such a kind of overload on
any CPU, then you're usually not saving any power anyway. The system has to
be really quiet and idle with a low stream of callbacks for you to save
power. Further, when the callback length increases too much, we don't turn
on lazy RCU anyway because the idea is that we are overloaded and the
system is busy - so we already have such assumptions baked in. I think a
similar argument could apply here for dynamically enabling polling mode only
when overloaded.

I was coming more from the point of view of improving grace period performance
when we do have an overload, potentially resolving the overloaded situation
faster than usual. We would dynamically trigger polling based on such
circumstances.

That said, I confess I don't have extensive experience with polling mode beyond
testing. I believe we should add more rcutorture test cases for this. I'm
considering adding a new config that enables polling for NOCB - this testing is
what revealed the potential for grace period performance improvement with NOCB
to me.

-- 
Joel Fernandes
