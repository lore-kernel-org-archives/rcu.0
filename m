Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C252A27B347;
	Mon,  5 Jan 2026 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627865; cv=fail; b=mQoFFHWjCYBswsKjrmeRq35ZOW0LsG9RzS2RBLuxmuT2jHYLSPHpzziG+HDgFDMUFNSMvs1IBkuf32lh+CZuoa2dNWCClj5cQf0j6zaDaKl9PZF3CJpGSWfV/lz8mUetXfrzt2Glde5VKZgYyMVHT05RHwIof5CDzqlgQwPD0ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627865; c=relaxed/simple;
	bh=g8TXG6j+r5LZhceXWpmfBFss8+MXCUHY68e4xUlSdo0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pMCQJUMwp8tz+WxEMXn0/VeryxN8+Ly2gAY6tslY1/Z1jxNeXO8h4w4HHDll05pFz4scusAaZVqggs/j4MRIBR2wsKnMYjX1KdzrjLZFS3GvOWALcH0JimoE4xRdbsIqvo3DxR37vRCrTP/DoR056WUTUqSvqlG60+FzUowQJcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VDu/l3zl; arc=fail smtp.client-ip=40.107.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VDu/l3zl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BD1gaK7LBtaGiCVb4jgLJjgIHPOFJV6SJkK93DZwVcJ3TtfCCTKp6gk4UIJFFP8zZ/pqcVX3CINla2uoJTGnhRQjDTXRXJUDKLvW7YaseQTapN49zGQUuK3nAQXOOi/8Sb/wU+mWggSLwFlrFmbieiNmyird/axuvrOCm490tsRAxgqg6Cn3W0BsjwFLp47fyGojHrLh/pszjnkY2yykxLC23Akfv2XekqMGLQiyqrZrZJa+eN11bRH6j5vx//dW5kOZdglHg1Jf4s4KqHl+oHLqPjqTTvrU8bfZPXUFwYekp0yrpflTHZj4lFvnAlN4aVR/5dZJKuJUThnlyjPz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ns0Z+wMKGEmXh4XYR7inOcIGdpoMxafdrfcGejO6acU=;
 b=R1neR/0HL2D/m3nKvfkoAVyu7BYN0xrP0auPt8XhkzP7EZdTvH/binow8+9mx1e0au8NIf7AK+ueHEjHRFkgsUPXmQceJ/KWta7IfjSqpUPWK/K1Klk09paoY5eQx/hZfxwNTDz6iAwY3de4apq4Mk+0tOMkXiSBe/VrGkVvCiASIFfyELDED3eMRyPKMd+hI6AnXyYwZ8lvS0wrW1LTKG36hRhwbAKz0Op+s36srOBZ7eY8hAC5evJwuFvvvZOK6Sj7n2/GcJ89YwCQ/pDLEfpgh4sGsjus4gNfIv/d6oFa5P272T/TbwZXZMsF5vz6vRANxGwtwsOJG47wQmtjhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns0Z+wMKGEmXh4XYR7inOcIGdpoMxafdrfcGejO6acU=;
 b=VDu/l3zl6oXAD78FLeAscyu1f3t2rrrpKcnUcv7D8hvbf1VvPl8m/dHiyRc38q95Oe8iAPcjN1NCYdzeX6CY9dLNgo9SOMwYXhjgRYPOGbQ4Bti/ff30NcvIgstUo8xtwsF9g1G/rgCG07zWq1KGyvsxoArwb2lWrvD3kytqaHDw9FW2rZtaYDurSxIITirfb3fEdi67W0Qj5AUFenILbDRNt0VEOWsPaXc/hkvyQK1rjIo36K1s7sc8Uey8ePL8inyfI9XExcw7NBFpKBSrQm6+MAjcklyrEej5iivTq2JedR4rw6/vhqHJo+0NWHJWxvaNacTQ182JaePAWoNb/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 15:44:20 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 15:44:19 +0000
Message-ID: <73d2561b-a36a-4578-b68e-bb8e7a7585be@nvidia.com>
Date: Mon, 5 Jan 2026 10:44:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/14] rcu: Add WARN_ON_ONCE for blocked flag
 invariant in exit_rcu()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>, joel@joelfernandes.org,
 rcu@vger.kernel.org
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
 <20260103002343.6599-2-joelagnelf@nvidia.com>
 <20260105103145.5b3eaaf5@gandalf.local.home>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260105103145.5b3eaaf5@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0028.namprd18.prod.outlook.com
 (2603:10b6:208:23c::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1e3d65-a9fe-46c4-0b9f-08de4c714a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlgrODRJT3BCS2k4V3dQOHdBNS9uOGN5dXdsNVFUck5EMmkweExlcHB4WjV5?=
 =?utf-8?B?cmtCOEI1STdMUHpmWllFWThxQUxpTXJFaVBBOEhSbXVNdnE1QUV4MXRWSlR1?=
 =?utf-8?B?WE4yb3FtTERKWkNpbC9sdk00MVdueXdYSXMxQlBSSytrMXJYUFpYVUhtZURG?=
 =?utf-8?B?THpldkg0M3dGbjkxY3pRWFBXVGQvbDFJY3pzaWw4WUJMS24ySnJSdTlJSlpZ?=
 =?utf-8?B?Nk1JSmk3RlJVQzZkREJ3MDVTc1RTL3JRVFpuVWhNS1c4L2ZwMDE3OHluVXgz?=
 =?utf-8?B?eDRzd1pVYm0zK3FleFMrWFA3dU1ld1Zvd3dRTWRDV043U2thdEc4K3ZOSUlB?=
 =?utf-8?B?d245ZXJ6MlkxSVp2bGJtYmdMVkduVWoxOENUMUozalRDY1dyWS94ZDN6dG10?=
 =?utf-8?B?OHpqUTBzbjI2RXY0bEZHVmdNL2w2cGM5YjF1eFJ4TVlXSU5aZkhidkNSL2xy?=
 =?utf-8?B?MlFnOGE1V0NkUENnSUE1MkN3Vnk5d0JJSmpWZVdLL29LMlRmWHozZ3dlbC9N?=
 =?utf-8?B?S2xHRmRROXJ4Q0RlSjR4QUUxVkFXSFZtckh1NHRzUzJVeEhQR2tCckN3bnR4?=
 =?utf-8?B?MldrOEhRM0tFSGdPRjJFOHF5R0FiOEVkbVZRYlZldkN3R3dDNXVIc3BLTnQy?=
 =?utf-8?B?UFFyWG5VRjd5b2JUb0owTTNQSS9YQjh4Z0hBU2RsRFgwaXpNc3JWWE1maWVT?=
 =?utf-8?B?RVVHZkpVT3BQdG45SG9aRHBqU3p3Q3ViVzdTRkhjamZDZkRXajcvRE44clNQ?=
 =?utf-8?B?ZkE0UUR1UE9ZUjFhTmJrSWU4dVgrdFRNVU5UV2JuOGg2ekpIWk5wZDlJeVVm?=
 =?utf-8?B?eEpJMVBoTi9ndiszYmNab3pTck9EZnEwb0YzVU9UcDdGYTdNR0JBZ01wMmkr?=
 =?utf-8?B?WDNrbXhlTDdSZ2xTVkh0Nzd6UUwxaFkvVk93bFlvb2EvTzNsSWhBSXhXUjN1?=
 =?utf-8?B?YWZ3cUttWkZkVjlaUFBHLzNsendScllyNlVOd0VzS0ljbGVxcjNiYXIxY1p0?=
 =?utf-8?B?bmNKYnpYMEVYV2RQNGJuZjg3Q2MxSmF6R1hPZGlZK0V4YTJSczBabHRHbWdG?=
 =?utf-8?B?ZUc3amVPR2YvWFUwelgxRjNFUWlTNnVlclhnV1h6L1JTenpMMmJyc1VIL09W?=
 =?utf-8?B?RzJScnJsMElJN0JYZmFEc2pJcm1YTlYvaENwZGZWYWF5SXNCdnVsbmkvQUhi?=
 =?utf-8?B?M2Y5ekYzZHNPK0JvdURFM05hSVBRT1pCTTl6R2N4L3ltUjdXV0hSTTJLR3FM?=
 =?utf-8?B?R3ZNUEZqYWZKQWhLOUhJZS9tWTRVeFY5SUxuYVRUN1FTNWtlWW9iWFJESk9n?=
 =?utf-8?B?aVkwS3lWei9oQVVNb094ZkYwNDFackFTQ0xiTUI5WlhhQ0t1aVNTZDh3U2hU?=
 =?utf-8?B?ZTVjZS83bVZrbU1iaHdoL3AvSHB0ZStVVU5MNzJxL0hGUHpBMExneVkwT2la?=
 =?utf-8?B?aW9DMUI0eERnM05TcnJpbXYwK2pkK2kzME5RT2hSQjZ2TmJWYnFyUXNmTDV3?=
 =?utf-8?B?V3FVVTdnUDdUS0x2QTcyazBRNnlsVXBndXd5T1c3MDJHeHR2REVsa1F5MVly?=
 =?utf-8?B?ZVVQeFB6WXJob3gzUm9xQUhGNW9XK1JNT3dHeVI5Njg5KzNjZ3NNRjd1YjdT?=
 =?utf-8?B?RUVZR1FRZjcwNXVuZ0NmQitEa2VCWGN1ZnNMWmppWDFMd29YZXJrODVsNDlJ?=
 =?utf-8?B?M2tqQXZlMTdWQW92eURteHRjYkNQYkpVSW9vWG0xRnk1aE9ESGtOK1J3MVhk?=
 =?utf-8?B?WDZUZ3FMd0haOHJrUTFnQUl4RVBRVVBaYzlGY2RpeWNPeXlQdm00RGNmWThi?=
 =?utf-8?B?QVRNbFFIU1IvZ0daZjJOWjY2aDlQM3U3WHY0VHEvTW5yKzQ4MnpvNm52VFlZ?=
 =?utf-8?B?KzgvcHJ4WHRISFdWV1pBV01FdmFTU1M5cFV2UkNXbkdoaHJ0cnNzbWRvRG1J?=
 =?utf-8?Q?s0UO/MkBJ5/9nRlpXJv3PuJNEhmztBPz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHB4Vk4xRGg1V3h3MDdsQXRPRnNwVTcxRU5sOTJHbEVpUklGUzVKaFcyL3Nl?=
 =?utf-8?B?V2FUcGFKcVgrYy92RUg3RlJrYjNKb3BsM0lzRUVHUDkzcTZRdmRkZzkrUG93?=
 =?utf-8?B?ZjcwdVRHeDN2RXV0YXY4MXNxVkVXUXZLdFdBMlpac3h2NzRUblZiS3NuQjFt?=
 =?utf-8?B?ZXNta1d6ZVFFV2dpQTc1QlQrT3VVc29PTzlwbmYwc3RBWnpCck4ybDhYNzlT?=
 =?utf-8?B?Q3pWVTRJWDFIZzhJeXZZUjdtUDRFYWZqRDAycjNBYnlpcG12TjdkRHVub2VH?=
 =?utf-8?B?U1BZK1VwTWpEU2RvQWd4L05wdDNCaFQxZzBKeEVQN2VBTDNkOTVJVDN3bW9z?=
 =?utf-8?B?VWxoaW1vOUh6K2F2d0ZqMXBQUjBGZ2c1WStWajNPNDVxdlpVL3B2L0Y5MTcz?=
 =?utf-8?B?RTJNUDN5TlVVWk00WExuNjBXSHljeFFyQkJCejJVSURyTC9sdmM5NXFPb0Nx?=
 =?utf-8?B?MkVGYTJlaFk4cFIxTGxRWkowZm8zaHdUZmtNaUVObkowMzduVTB4WjZnTSs4?=
 =?utf-8?B?UUdjS3c1cFUvMmswSGIxQko4YnZWQzVBY1RxaWYvb0RpdmR4YWlna2RscU9m?=
 =?utf-8?B?alV5QmxFc3BsQ1JCMC9pV0JqQXFaN01xUlZNY0FTc2wyeVRnVEtIR2xIZUh0?=
 =?utf-8?B?a2xZdm4ybTBaZDcrUE84N2I1WDNxYTVHODlyUUJ1Q1U0d29aMUg5R0VCTmhv?=
 =?utf-8?B?S000a1Ara1JiS2lrSnY3UVRRVitSdEVaY29hRlR2TGVjVGlkcUdYNXgyb1My?=
 =?utf-8?B?cHpUeldzQWJmMzlZNVNiWkdTQy82d1ZyaVBoWTZqczVlUzkxU2l4SlNBMDZL?=
 =?utf-8?B?UndjYS9aMzR0cDlGT1VIOWpnSG9SaTNDbmJXZ2xweDFyZkFsUDdSeEdxaU5V?=
 =?utf-8?B?UThaRkx5K3dtMnY2L29CZFJiUG9NQVlxUC9GMWJEbFZYVmFnZ3hxWVFNZzVY?=
 =?utf-8?B?anlJb1hyZWRyM1BBZWpMOERHeHdJUjk5UjJGbmoxSHpGK1g0bWFYZ3l2Z1pP?=
 =?utf-8?B?RkZyUWxjNCtzcnNOVVFURU51SE5zS2RHeGwveFdXWExweU1yZ3g0bUphNXFW?=
 =?utf-8?B?ZE5BYUdGL3RUWkhqN2RMM3BmSWg3QzhFRG5qOGc4VzhsMGdLSUthQzhKUWJZ?=
 =?utf-8?B?STZjMHZsYjMwczZlQmVPVVd2NkVCVU9DNFRvT1JFOUs1dnRsQXhxWVEzcnVu?=
 =?utf-8?B?YXA4NjBJbXAwUUJvNER6ak1Zb3JyZFpBTVdPU2JOaDVnTCtBZEF4R3NpdzR6?=
 =?utf-8?B?akRuYlRoVS9TY3BFOEpUa2JaYzQydjFJS2ZWblo0OVpLTmRiTUdvTE5Uaitt?=
 =?utf-8?B?TWtjU0ZlY2oyT2VHclF5TFF3RkFGUlNkd1RBSDU2SGkrUnl4RjVtY1RaYjdB?=
 =?utf-8?B?ZFZyMkMxRW44ZW8xa0pZMHg5VVFOaUtVQzRUMTRtVFBPY1h6WWJ1WjNTMFFJ?=
 =?utf-8?B?SjE4TlNNV00weTMrWlNTeExKRUd5eEZlWnY5ME12V0dIQVlGZXNjMnVwOTFB?=
 =?utf-8?B?NStQQ0NoaXRPQjdlYk1zWEYwOVcwOFUyV0VjWlZVZGRQZU56azlZUEswdGR4?=
 =?utf-8?B?UzMyZFhaaGpNV3d4b0RQelBxWEdVSHJ5M29TVVFhVU5GUVJlR1lXVEJmMU0w?=
 =?utf-8?B?SWtnaUpnYUhsSWVjeHlHQVY1WS9ER1JZTldkU3BDVzJkb294dlNwaHByQ2I0?=
 =?utf-8?B?MVNVVU9BU09mN1ZGR09BMkFWVE5DWWdnUGVMSDZyV1dTVlV5dUpjK0FMdW1G?=
 =?utf-8?B?WnFRcHRQSjdWVU4xY2xudGt4NnlZMDQxTThnSlRuSHhOWDd2a3NMUjVvRUhF?=
 =?utf-8?B?RVlGQTh6aThuaXJ3QldmVXV1d2RmOVNHVjZJamg0aE51RWFXSkppbzQvOTZp?=
 =?utf-8?B?MjJ2TXE1WTVmSmNZMU1TdW1MTTkrL0tkMjdVMXhWK3BQbHZ4S3VVRFdKalJ2?=
 =?utf-8?B?bUlaWVRUb01Tc09iVEVxUDl1bnJheU8wK0hoZ2pzTjVwMXpBTnR2dy9YOWFD?=
 =?utf-8?B?YVNZWmVEMC9MZWxCeWl1S1lNR0NyVldCdmFkQzZXaGkyb3JkS1lyb0wveDlj?=
 =?utf-8?B?K2k1MGpEbS9YSzdXTUpvME44S3plYkVob3lvMGk4S2hkMGdJQUFxSzljSjdi?=
 =?utf-8?B?dk4xYXhKaFZQaWtVZFE4VkxOaXlweUJPdzdsMWRCcmRGUUlVMExxdkVvbUZM?=
 =?utf-8?B?a1RYMHZPUmFiZjVCNEx3ZjRVb2ZxN05JUHZHcmJ3djJ4Q0l0QS9KT3BMcExh?=
 =?utf-8?B?YllId0hEYjJKMkJzcWhxakpKZGtRdHJwMVdwTVJmc3RjQVY4emRGemN1VEJJ?=
 =?utf-8?B?N2k1dDg3d2toQlZBb0dFY1U1TmRNODdIbHRoNWNGWmJJdHFGTWVKUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1e3d65-a9fe-46c4-0b9f-08de4c714a5a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 15:44:19.7927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpe/0RPCdB+dZyAXdCM8uA1UjeL4J2fFcWsdTmEQHlciOAIO5xNcFhrQSsDA05gsY+slCaYW+C5Bomt5c+m19A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286



On 1/5/2026 10:31 AM, Steven Rostedt wrote:
> On Fri,  2 Jan 2026 19:23:30 -0500
> Joel Fernandes <joelagnelf@nvidia.com> wrote:
> 
>> Add a WARN_ON_ONCE to detect this invariant violation. If this
>> warning ever fires, it indicates a bug where a task was added to
>> a blocked list without properly setting the blocked flag first.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  kernel/rcu/tree_plugin.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index dbe2d02be824..73ba5f4a968d 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -846,6 +846,7 @@ void exit_rcu(void)
>>  	if (unlikely(!list_empty(&current->rcu_node_entry))) {
>>  		rcu_preempt_depth_set(1);
>>  		barrier();
>> +		WARN_ON_ONCE(!t->rcu_read_unlock_special.b.blocked);
>>  		WRITE_ONCE(t->rcu_read_unlock_special.b.blocked, true);

Right, so it is ever not set then we are trying to "right" a "wrong", so..

> 
> If we warn when it is not set, could we just remove setting it?
> Or do:
> 
> 		if (WARN_ON_ONCE(!t->rcu_read_unlock_special.b.blocked))
> 	 		WRITE_ONCE(t->rcu_read_unlock_special.b.blocked, true);

.. we could just do this. I'll apply the suggestion, thanks!

 - Joel

