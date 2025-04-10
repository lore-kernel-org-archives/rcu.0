Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3B28A404;
	Thu, 10 Apr 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294416; cv=fail; b=JMZWCe//zxn6GQ6Inh/FUyq5gB08qq5MTpwRY7W0dp/ON31hJaFO0llcAj5a/6nBRQcoiEvkffQyU00UkxXjH8A8RtIENG0+zeX5nikr6LcXGG5/ZsWiUkwUQXwVTuyZkUwOJq4v/L04nnWT2C/iUlneHlFaFulJ8G3Zlb17KEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294416; c=relaxed/simple;
	bh=cWXJYWBeajiDmHRrrbjDXyPHlL4DN+StYgH9mEiBkH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aDBWo/pLCqBAjFj9pEFtlU6ErtM8cAjCIwuNzpf/yBTWO2o+c4qHHZUyIQ8srGTuuzyhb+gRyD7haEd+FnvqC2faQerYqsqq0/ru/lFiZqbJNOoxxxMQqrW419tA4YeMu0q8BKTGC9g11Cuj4nJ6XhiAGjKOOdehqIk27AeFqsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rKfliifl; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rKfliifl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5xfmyxRCko525jkqfeBUMffnKw0zVJ8lGCnFWk/6rOCS3tmXeTRfS0sS1dPpqCI7pz9W96bRYx+K0+ASD9KXecAYJnBfL3/kPmHJ0pzBqr8F1DtrxlESxTYU4/nq4+i5TBVAxSTTQ6pJ0vXCTOgP1jVrzC0W8fUJM6t14R29Xn3l3yvulUSEKQcXlgmuU9ih0WIOPFOhccSuUp0/sK97cE1QuPNSvqg+QwJcRN6QN0ObbSGsEo3qNBP+1U7E9GiNryPDcJub8wP3yyuyDuLu7TaFjgzZl+FarAOAb+CD8c5YxLtax4zOIWapXR6FpyDWHEdP9jXtlJhuc2diTwHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWHdfJMU60NZ97UbSn+ybC6J4OjXCTxwelQbO8Uhf3M=;
 b=stl+Fz+FLc8xbw444Cd5zkKOUmGQzUG247U9Sz/GcY9hsoGSMGLvhMZi64/RqfAg+K3QWSUniR+jgq7kIIJE7uOACoGNj+Uaami9TlMuIPaPIF8ERjnEU1UQazUwl6yFX1CTC1J+rLyOWbwq2nVJmoj3YCxbj04RkR9e4lcsJH12NVFD3zxU/cdiCGO3vNA44d1WDX/lKDfst9C7fwJdd7Jf8OFRZVg4gBPdcDmTSz894snyjjswAVjoGWRkL+KIJdYSzT5Zd34X+CxJ+Le6ixi+UO75KB7O7XRZ1zA2sOVfFhFuaAQE9RIeRvYky4VkH8+03of94iwAtjq+/N44yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWHdfJMU60NZ97UbSn+ybC6J4OjXCTxwelQbO8Uhf3M=;
 b=rKfliiflSCHidVJ50Tp9Gwpt7ynI9GjiICoe4THII1UKIfu+1g5SAqarXuEiBdkovZQO9gi+RBvdhf2q4zNrrmk+2zy2QjHsre5i38w8iUyJoyGB1iHcASNTVlYHMHyH2UPMLCvkjbuyp5poo8L/4txlH0y88CeSy5OTzgIqsOHyf+B9bYtYQh4knXYrvhlq4dzCHjx1GgDxBZehnPldMGKvyeB5tY8i91/nfXxnFMgABswh2rAZ+ZaaOmHNNyEgI/8CXa2qGbAgFLMaFr7cllCr0ATlPc1pikOw4Yp/8heqOFfiCA/WYVaVWdUZGzcrb0TKNXgs72fC29s/qm3jaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 14:13:31 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 14:13:31 +0000
Message-ID: <ffbf9606-572e-49d6-9d90-5532a5376f23@nvidia.com>
Date: Thu, 10 Apr 2025 10:13:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcutorture: Perform more frequent testing of ->gpwrap
To: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
References: <20250410135439.3718363-1-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250410135439.3718363-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: de479a12-27bc-48c8-68db-08dd7839df64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkRpd2cxM0JoTFArdmVVSWd0L3I3RHNxOVZseDgydlVNSElhc2w0cFZBWEFC?=
 =?utf-8?B?U1JsVEV3K3c1cWRGQzdGSjhCK3daUWZ5aTNiRDBzdWsxb0hzRERRWmlGaTJr?=
 =?utf-8?B?MjR0dkNuTy91MzJRajg0VzRMTlhWYlpQc2VZa0tRQlpXQTJjZWhqMGV2Q3RU?=
 =?utf-8?B?bG9CZmlJWEh6YXYyRDNyMkFSOSsvZjdmVHk2eFpvREtIU09vdUVCNm9MN291?=
 =?utf-8?B?dlhQN2w5ckdPSDNKSHBGTGlxM1ZXcVVBMlBOREFkSkcxdXpoUVhNeHJjK1p3?=
 =?utf-8?B?Z3BsZGNLZm9tUHB2ODlFTDBFdWx5OUYycWExV1U5VEd0ekkrb05Gci9FZDBL?=
 =?utf-8?B?TXRNbUs3SkE5WXU1eUd5ZXd4UHpCMUFLNFRrVGpEKzNKZFM2S0oxeTI2RFR5?=
 =?utf-8?B?SXdOcTNpVkZ3RXJXdDZuYVkvWkRETXN0c0FoMzFnMjdHN0ovRk9sa21tSEcx?=
 =?utf-8?B?ODJXR0pYd2p4cjFSM2U2T3llU000Sk5NWmJJYzhaU1ByMXhnUEUyQkF4ekNw?=
 =?utf-8?B?eDZqbHcyWGdsd3Z5N2tJUVJ1ek92c2d2MDcvMUt0Y0FoeHFxem8zLys0NUNJ?=
 =?utf-8?B?MHQ5OWJGVjJVU1Rab0J6U1hFaGlyK0w1YXlNcG1FZEV2UVdHVXk2KzV4bitx?=
 =?utf-8?B?cHJZWStaWnlnYjJXVU4yczlYUno0RWU5bHVXV1ZnZFQ5ZEI5WFIvSEMyRFlx?=
 =?utf-8?B?SUN0alJnekJQNytidmd1WWFOenhxMDZMc1JVWFhCRXBmck9WcTk1ZnFDL2xS?=
 =?utf-8?B?WVg3c3Fwd2dQSGtPSjVCa0gxbG9xMXg5LzZDSHhTNE50cWQ4WmZoOExLUzEr?=
 =?utf-8?B?VDQ5RHVIUXVYQXVPYjdyUWlic3laeHV3NmxNdkhlOWd4dWc0SkRUVkZRUWc4?=
 =?utf-8?B?TXFGY29BZFJWR3dmSTc4SHF3MndwVTVhK0ljQjc5cUZqNzdBREFWd1RvdGdo?=
 =?utf-8?B?RTZMeWZHdmpQYjNxaHB2eHNBTExxaGNlZ01CRGkrOUhEV3dyU1NUeU55VmhE?=
 =?utf-8?B?SGl2MEY3RktLRU5rUHFqUUkwODJjYktKd0JGNm1UbHVtTklQeVl1SHhhWjVz?=
 =?utf-8?B?VXFHSlgwK083VisyamVvZG9Fb0lTSzZwRHFGVU0xMFdsQzdUNjVPVjZQVDJM?=
 =?utf-8?B?WGRtZWRBQzFzdHIrUXd6ZWo0OVd6V2dYc1d5QWFreHRnWHV1S1hHUmxxWTg2?=
 =?utf-8?B?bVBmaFIwUENPSHFGdDVaT2xYQjFSNERBNDJSR24yVjFQL0ZIdkRSV1pUbWFa?=
 =?utf-8?B?a3lQWjVaYjVrZVVWWWo5N0t2YzBpaS9qMGZSZm5lTVR1Y1VkY3Nhek0rYjJ5?=
 =?utf-8?B?TkkyRVA4ZnZ2WGQ5eStZVVJYTXZxZnRJT2xPREVNR2FxUlAxazFadG14cFR4?=
 =?utf-8?B?c1RvUjVYTUdqeU94ZG1pKzRmL0dVWWhrKzczQ1czejJPTHdyR1FmdnN0Qkdj?=
 =?utf-8?B?ZnZzTFFmV25iWDhhdGFqMHd4ODdOTG1uNHY0MWw4ZUZaTUpaUDVXc1ZRR3ps?=
 =?utf-8?B?SU9WdHpacHc2eFJnSnVxL1gybE9ZcmdqYlpUVlRibkk5Ri9sbzVxQ3FQRmxK?=
 =?utf-8?B?aVpZUjErNit4S0RGUTZVRGNwKzIzby9rdFVIVytoWUNJQU9mK3dYUTJCUGsy?=
 =?utf-8?B?OE9lanoxblczVkVmYUZTNU1yYTdzeUZnK0FmbnIwQ1MwdGJEZS9hYXNQcklv?=
 =?utf-8?B?Y1d0Y0lySHErYmRxYmdxRU9kT0F6c1dyanlkVnJTSmwvalZWWDRzdHR5VXEr?=
 =?utf-8?B?dmE3U3ZwR1liUU55UGlETHMzYnJnUXVhRFpiOTBudGV4MWFiSXlobHVwazhR?=
 =?utf-8?B?UFNvMDNxd1RxdUhZKzFRWWs3MUZpZ3l2NmtYNnh4cE9SNUZ1MUUwRi9jVTky?=
 =?utf-8?B?WTJSeHRUUEwzTHQrWUowT1RVNFo3L1Noc2czTTdpd2pnVmZUcDFiZ1B3L2Vk?=
 =?utf-8?Q?ngv7MVeMKms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG83a2ZkMXNiV3JxOTZ5QmlQa2VQT2hhTE82Z25JN1NMZnVtVnFuaGJjQ1Rp?=
 =?utf-8?B?b3IwQy9Va2pTVTEwZm9CeDZBTGh1dm9hRWMybEtTVWhEaitDTitTUW93bWNo?=
 =?utf-8?B?ektPTEpCL2w4bW8zQ3pxZjkvSkJWK0RqcXlnZDVZaGtyRTh0a1lpekhkd0U1?=
 =?utf-8?B?aFRmT2pLaENCN05yckhCeFJUb0MxU3lrVnl4U2l6S3lYTkFva1dGU3kySmhB?=
 =?utf-8?B?dERzTi9DWnArSkg2bHZLdHBBQ1FLajVYa2gvTlpTNnlkbVFCWUlRZ2pLb3pi?=
 =?utf-8?B?VUVsQXpZMTkxSHNFV080V3RQdDcvUjZYMkNXNEhJR3NCTGRWZCtvY2tJWXp3?=
 =?utf-8?B?V2hzSy9ONnF2VHd5QnpJR05kaGtYb3BLdFQySEI4MCtzS1l5eUFNY0p2L3FS?=
 =?utf-8?B?anNvdkhxWWJrUmFYVjEzSlVZalM1Wm9JRFdDS2hmd3NZd01GT2xZVVh0WEg4?=
 =?utf-8?B?REFyaDJ5eGRqQk1mTjBGY0gySnIwRlF6Tmc5Sk5HWHl6ZnZ5OWVLdGxIQUNp?=
 =?utf-8?B?QTcwaTg5NmMyUUREQ0lOT0VuOU1haHFPSm1mYWgyNGFqbnlnTE5iWjIvaVdF?=
 =?utf-8?B?RG5BdjVKaU1KdGtUY1BZd3FFWVVuSS8yTzNRMTQ1TUMzWno0WHRYUGV1Smxy?=
 =?utf-8?B?NmxFaUw4clRLc3p4UVFRQlF6djFXWFJ2Q1prWk5vYlJDRXpWeE1pT21FMnE1?=
 =?utf-8?B?Q0FYUzl6STZ5bW1hVjRiZE5PZGM4dkpaSitUcTRyMWlXZ1hFRXRmNGxPQWd2?=
 =?utf-8?B?UEJtYi92Y1o3Y20rS3FycFU3ZlVaMk5kZDhLM2dsWTdMZ1BxOHRZY0JGakpu?=
 =?utf-8?B?czdyMVp4SnZKbXArN0xhT2JOc01JbG92VzVtWGk0TGc3ZU02Tnp3MUxTWW5E?=
 =?utf-8?B?cjdNOEZoekxRSDZaelJjcUVzUUFkcUM2YTRJOHZIRFoyKzVVVG5GdEhwM1RQ?=
 =?utf-8?B?dUhpZHliWkh4Q1BxWlNNdTJrREo5UnhhQmcyQkMxMDdZdkp3RCtidThNWm5v?=
 =?utf-8?B?WElrZnBXZlZnZUIvRC9mRXowbTVNenJiTHhLbkxPM0FxSDFxRWVSM3Z1WVBS?=
 =?utf-8?B?VWU0ZDF0V2FjNTNlYUxWdkwyR1kvMzJOR0g4bFYzVkdBN2hEUkRPRlUrdXBY?=
 =?utf-8?B?R3lmYUxkM0M2cGQ4SGxOQzI0MHNzZFpqZW8wS0VibUtBejVZL3FlOVc5b0Mv?=
 =?utf-8?B?RzhUSkcxMkN2d0Q4eDhKT3l6WnNtempUeXUzY3RoZ3hOZmU4UGJURDdGdkt3?=
 =?utf-8?B?eVNQcWxBazZMQ3FDL1VxbEJvOFdabCs1YUdaU0NjSmdtWFFON3AzL05yaDhG?=
 =?utf-8?B?KzFKNjVxVHY1QXErNVZZWVdxbmJIVTJKdUJHZC9lUVdwSmJDM2Z0Q1JBZ0Rr?=
 =?utf-8?B?N0wwUGVPNFhqbjJMTHd1QXhKWkhkeEtrTHM3WVg4YlM1SEx3MVhZdnJiNSs5?=
 =?utf-8?B?dnFqSlB6VjZsV0psMlkwVjhpV3puN2VZUCsrWHZsYkh6WnRIVDI3eGF5c0Yr?=
 =?utf-8?B?NTZ6Rk1BUnJHRzFod2FkTDFpMFFKdG5aY0pMV1N3Z1ZYM2pBeFMyQWc3KzdT?=
 =?utf-8?B?Z2o2QlhnMkpzRjRMQ0RvRkl0SXVNMGx0djlxY2YvNHhFTjMwS2ZYNVBwcFZ4?=
 =?utf-8?B?QW1NWFhzT2xDbldKbnF1VG9NOXlXcUdOVTRockR6cGxUZmxtNDAzNEFrNEEr?=
 =?utf-8?B?NlRxVCtsa1pmSUpsd2h3anZSMVphdERmM0o4Y0p3RCtrTDN2N0hmbFYwWVF3?=
 =?utf-8?B?d0xEei9IZGxUdWV0MTUxaGFYQmFUcjdrMHVKM1VpK3VKQ0JvQkZiR0txRlpk?=
 =?utf-8?B?dE1lVTZaWEZOVTVJYjdFNk9xYlFmUllIMTRWYkRGWFRJaXMydXJpVnlHdVFC?=
 =?utf-8?B?Y1EweXp5OXJwTXFiTVFZV0YxR0R2NHdqdEg2b3hSa25GY1hkbnBQMzR1QkN1?=
 =?utf-8?B?bEIxcG1nU2dCMERoRFY5alJGaUtCSTUwMERxS1duTFByUG1ndWE4UEVEVzhK?=
 =?utf-8?B?eUh5Vk9HeGI5WnAzTjhGTStPTDZhMy8yL0dkeWF5NVlzY29xajlBeXRaOTVz?=
 =?utf-8?B?MEUvT0NPS1J6eVIrMmZCRlJWUjJGU0R0bDhaTm9vYTEyaGhlajFnaElXTlcv?=
 =?utf-8?B?RVpvT3RDQ0pOWEkyVlFnc3p0NGVUSFVTejVHc3Z1NXlMQTB6OEhhNlNCVVZ1?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de479a12-27bc-48c8-68db-08dd7839df64
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 14:13:31.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYvRUD+B+CU9MzyTKprDjVy/LVUjpDnnVY0qYIFqiPeVuJv9bl7751XWbBiwnC8UVhoduc106stSRCUazieZng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012



On 4/10/2025 9:54 AM, Joel Fernandes wrote:
> Currently, the ->gpwrap is not tested (at all per my testing) due to the
> requirement of a large delta between a CPU's rdp->gp_seq and its node's
> rnp->gpseq.
> 
> This results in no testing of ->gpwrap being set. This patch by default
> adds 5 minutes of testing with ->gpwrap forced by lowering the delta
> between rdp->gp_seq and rnp->gp_seq to just 8 GPs. All of this is
> configurable, including the active time for the setting and a full
> testing cycle.
> 
> By default, the first 25 minutes of a test will have the _default_
> behavior there is right now (ULONG_MAX / 4) delta. Then for 5 minutes,
> we switch to a smaller delta causing 1-2 wraps in 5 minutes. I believe
> this is reasonable since we at least add a little bit of testing for
> usecases where ->gpwrap is set.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/rcu.h        |  4 +++
>  kernel/rcu/rcutorture.c | 68 ++++++++++++++++++++++++++++++++++++++++-
>  kernel/rcu/tree.c       | 34 +++++++++++++++++++--
>  kernel/rcu/tree.h       |  1 +
>  4 files changed, 104 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index eed2951a4962..516b26024a37 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -572,6 +572,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
>  			       unsigned long c_old,
>  			       unsigned long c);
>  void rcu_gp_set_torture_wait(int duration);
> +void rcu_set_gpwrap_lag(unsigned long lag);
> +int rcu_get_gpwrap_count(int cpu);
>  #else
>  static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
>  {
> @@ -589,6 +591,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
>  	do { } while (0)
>  #endif
>  static inline void rcu_gp_set_torture_wait(int duration) { }
> +static inline void rcu_set_gpwrap_lag(unsigned long lag) { }
> +static inline int rcu_get_gpwrap_count(int cpu) { return 0; }
>  #endif
>  unsigned long long rcutorture_gather_gp_seqs(void);
>  void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len);
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 895a27545ae1..c64cb5498401 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -118,6 +118,9 @@ torture_param(int, nreaders, -1, "Number of RCU reader threads");
>  torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
>  torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
>  torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
> +torture_param(int, gpwrap_lag_cycle_mins, 30, "Total cycle duration for ovf lag testing (in minutes)");
> +torture_param(int, gpwrap_lag_active_mins, 5, "Duration for which ovf lag is active within each cycle (in minutes)");
> +torture_param(int, gpwrap_lag_gps, 8, "Value to set for set_gpwrap_lag during an active testing period.");
>  torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
>  torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
>  torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
> @@ -418,6 +421,8 @@ struct rcu_torture_ops {
>  	bool (*reader_blocked)(void);
>  	unsigned long long (*gather_gp_seqs)(void);
>  	void (*format_gp_seqs)(unsigned long long seqs, char *cp, size_t len);
> +	void (*set_gpwrap_lag)(unsigned long lag);
> +	int (*get_gpwrap_count)(int cpu);
>  	long cbflood_max;
>  	int irq_capable;
>  	int can_boost;
> @@ -625,6 +630,8 @@ static struct rcu_torture_ops rcu_ops = {
>  				  : NULL,
>  	.gather_gp_seqs		= rcutorture_gather_gp_seqs,
>  	.format_gp_seqs		= rcutorture_format_gp_seqs,
> +	.set_gpwrap_lag		= rcu_set_gpwrap_lag,
> +	.get_gpwrap_count	= rcu_get_gpwrap_count,
>  	.irq_capable		= 1,
>  	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
>  	.extendables		= RCUTORTURE_MAX_EXTEND,
> @@ -2629,6 +2636,7 @@ rcu_torture_stats_print(void)
>  	int i;
>  	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
>  	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> +	long n_gpwraps = 0;
>  	struct rcu_torture *rtcp;
>  	static unsigned long rtcv_snap = ULONG_MAX;
>  	static bool splatted;
> @@ -2639,6 +2647,7 @@ rcu_torture_stats_print(void)
>  			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
>  			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
>  		}
> +		n_gpwraps += cur_ops->get_gpwrap_count(cpu);
>  	}
>  	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
>  		if (pipesummary[i] != 0)
> @@ -2670,8 +2679,9 @@ rcu_torture_stats_print(void)
>  		data_race(n_barrier_attempts),
>  		data_race(n_rcu_torture_barrier_error));
>  	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
> -	pr_cont("nocb-toggles: %ld:%ld\n",
> +	pr_cont("nocb-toggles: %ld:%ld ",
>  		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
> +	pr_cont("gpwraps: %ld\n", n_gpwraps);
>  
>  	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
>  	if (atomic_read(&n_rcu_torture_mberror) ||
> @@ -3842,6 +3852,55 @@ static int rcu_torture_preempt(void *unused)
>  
>  static enum cpuhp_state rcutor_hp;
>  
> +static struct hrtimer gpwrap_lag_timer;
> +static bool gpwrap_lag_active;
> +
> +/* Timer handler for toggling RCU grace-period sequence overflow test lag value */
> +static enum hrtimer_restart rcu_gpwrap_lag_timer(struct hrtimer *timer)
> +{
> +	ktime_t next_delay;
> +
> +	if (gpwrap_lag_active) {
> +		pr_alert("rcu-torture: Disabling ovf lag (value=0)\n");
> +		cur_ops->set_gpwrap_lag(0);
> +		gpwrap_lag_active = false;
> +		next_delay = ktime_set((gpwrap_lag_cycle_mins - gpwrap_lag_active_mins) * 60, 0);
> +	} else {
> +		pr_alert("rcu-torture: Enabling ovf lag (value=%d)\n", gpwrap_lag_gps);
> +		cur_ops->set_gpwrap_lag(gpwrap_lag_gps);
> +		gpwrap_lag_active = true;
> +		next_delay = ktime_set(gpwrap_lag_active_mins * 60, 0);
> +	}
> +
> +	if (torture_must_stop())
> +		return HRTIMER_NORESTART;
> +
> +	hrtimer_forward_now(timer, next_delay);
> +	return HRTIMER_RESTART;
> +}
> +
> +static int rcu_gpwrap_lag_init(void)
> +{
> +	if (gpwrap_lag_cycle_mins <= 0 || gpwrap_lag_active_mins <= 0) {
> +		pr_alert("rcu-torture: lag timing parameters must be positive\n");
> +		return -EINVAL;
> +	}
> +
> +	hrtimer_init(&gpwrap_lag_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	gpwrap_lag_timer.function = rcu_gpwrap_lag_timer;
I should change this to hrtimer_setup() per the latest timer tree. Will await
any other further comments before reposting.

Sorry, thanks,

 - Joel


