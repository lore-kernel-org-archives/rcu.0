Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669702356B1;
	Mon,  3 Mar 2025 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032165; cv=fail; b=YiKGaDUzBRYaBnLOFvxadIB30N7GoPpAkMVAq9ztp6G9tHDeuRgHyYDx4jXs87r1noh3jRd2Z6KvAYTXgEFGWcIHzLIRb8z84ACtPWNXUs6hyrIFJGn5UeGQMjT0BNoSH827g1xxjUK7sUNMI/CRW+/cLOJ4jMuNhj9pHSgVwIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032165; c=relaxed/simple;
	bh=Q4ykBsHegep1zmbbzC+5SOMXnKWQLpA265LDy0gnIEM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aSI7wv/5QwvJ/C/PN/0afxA5DO03K63jM+BYte/tEpXh74+TeKfLByTFjH/Pwib7KoHWuaj/tSEAVpVfOUy6/L92ovjEsQt4rkv2ELxsRYftsbs9a8EaOcocKMrm1sxgZ4veHE3jih3cVByDDj6KclibgDdCLIyu+/73pPpL/lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AdJ4rX/W; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AdJ4rX/W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+N4WnxAeHRgCKAx+vErKLyjLG5Cfm+j0qm7wdVUIdivPbSw6LN4inxjWouaXaPK0TUQ2HZTv8dji70+/XFoZNhhEWkhFdNgy8vk78fogURkjR9+StwtC6i0cKiQ3hf70f3le/Qhvz4s9yfjekE/uuF87+CtAN/+w254AgcM9KUcrSiXD4wJyLlI/z4zg8uTGoEi+ptgUX9hAHLWa9O5wN3sp9a5K/BdiHkUlxRVgQGu7f7Ovfd8Fi2pFbWdsL+h9OTJh6WLCRUMuF+Qp9NnUctO2gvY7ny5fdPOw9UYys4nYFZEI5j3nptNdhj5XFqe2b2hRZ/En5S6WkrTnzD3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2c3MdAIfUNe20PgqLL3BQej2gflSjiyiRNLXu44gfA=;
 b=YiWQ3lbM5y0jz8NFnEllRwupHmcTX85KfCSeZ8KhC2PiHcKpcnvZk2JBfYn17fZL+vPnCfY2LGIQFJq61UGNaDYa+UIaAsVaLBf9+xtagKEDpSm0GYTdQFwc9LDgRqR9Ff6/dPJiyPUYnQSC3IuNxt08ICvu4SH73Y/8bduPx1Gd1HcUjON+MX9CagMMAOVciN/nfauCZWLm40lZDSmTa42OkwGM1MTxetrnRaXf0gW8qcz7pnpLx4r8BjNldGVLnzDB97ymvyFjuYQl5YywPtDusD4f7+4U1AAkxvGeujoAae9GP/2Jo1NnoHfQzn7n8ga5QS4w+K03RQFFvMYLpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2c3MdAIfUNe20PgqLL3BQej2gflSjiyiRNLXu44gfA=;
 b=AdJ4rX/WQUiC8VwHqVO6+dGKY0mB7r9UESBwvQPOK+xPjVO1Bb/eNSMtIkYJgV6XB9rBs9fMXl9Qq9VaJNECG4XtR6U7UImt3UuiDFxa7RW4CQTw6HxFEH0OeEi2YEXMSrz9FTPsgLEyaO7xZDqBFOZYBORBxeZfwsGyHEkcnBvRREjf/vu6eTsqABYwCndYtJvaOjKVH2mNUcTxKavJSpB5olk0CbCRjq/d40g7zjxlHGkaRtkaAuG3lRxadCc6WYYcJBEB9MQ1mQlyiMDk59NDT8icFjCjgwqlhHvUPnWM5pd5gwuaDXtU0ckQA0JANhNzjB1mCnA8fYHyEBtR3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 20:02:40 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Mon, 3 Mar 2025
 20:02:40 +0000
Message-ID: <aff3f6ba-9ee3-49fb-82e7-b22ae6e12ca7@nvidia.com>
Date: Mon, 3 Mar 2025 15:02:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
To: paulmck@kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Cheung Wall <zzqq0103.hey@gmail.com>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <20250303001507.GA3994772@joelnvbox> <20250303001710.GA3997787@joelnvbox>
 <20250303170040.GA31126@joelnvbox> <Z8Xh0pP4xaFm0nEV@tardis>
 <5f404973-380e-4626-a2ef-8c5c44d56b83@nvidia.com>
 <667b6907-7ac7-4217-a3e4-0ad299267754@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <667b6907-7ac7-4217-a3e4-0ad299267754@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:408:e1::8) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 60336afe-fd51-40b0-79ea-08dd5a8e5a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmI0a0wxQWtDNklKU1JqU0o5eVRSc09pYk54K2tIbUg4L1lrY3dIaSthVnhR?=
 =?utf-8?B?aCtWb2JaL1BoeHdkaHliOEdHS05DYmN6cUlldlFEOWY1WVUwaXVhZzdxWk9w?=
 =?utf-8?B?czZiNGZaRERneEVHQkJGYXBtcW9WYURPMTNTRjVRQmQvTVY4elA3VFRVam9J?=
 =?utf-8?B?K1VBWTFBcmtZc1RWWUVXTWIzYTdsL1paY1JkR3o5NHUyM1N3UXNaSjJWd1Jj?=
 =?utf-8?B?N3FFbWlSdWJUMXhFMTVKbG1TMy92L0VZZWpPbExsQXZ1d0RwNDUySjBMaUNM?=
 =?utf-8?B?TEY1a1o3ak04ZmJqWDRZcy9kUERDblZSdG5UWGJNR2lzMVpxa3VXVEQvRmU2?=
 =?utf-8?B?emovQlBYQlpORCt3eVVmVFVqc3M3TE4zY0Z4OHVVTjBxcWNxSlpmeDlZNHAr?=
 =?utf-8?B?ajRqeXZYS0ZVZ0MxOTRXenM2bDRaSW5BaVBvRkNJaHRlU0lJc3hxNVVxb3M1?=
 =?utf-8?B?SE1FUFNiTGlkUzhCTFJRcjUyS04vYXNkUE9qcnp3RktweUtGWUx4MGwyWGg2?=
 =?utf-8?B?QkcxRUxML3BGZEJDek1lWFhDbzIxcm5EcmVIU2x6K0JBaXMwa01yWTdSV1NX?=
 =?utf-8?B?TXpUaklTd1dHOWZtK05yZ3dZTGpSdFZ1UURCU0l4Y1dETStYd3R1eHViRm51?=
 =?utf-8?B?VkVHQ0c0ZGdyVVJ0eVgwcnFESDV4dGY0aWdxZjQwMUxUcG1KSzR6OHd2dWRG?=
 =?utf-8?B?WitDMUxDU0ZSam04RWtrdE5LcW5YLzFSenFzUlZtMVU1aXhrQzk4WWgwR0Zq?=
 =?utf-8?B?SSt6bnJTUEpsYU5QU2pWa0EwNzNUSDFwamFERkVJUGJtVVJ0cWo1d3FrNDhH?=
 =?utf-8?B?V2lYS2dZcGF2UVFHb0VPV3JoRDd4Q3J3UWRGVkJHV1dDK25Zd0p5bE1nZVZT?=
 =?utf-8?B?Tzd2eEtadzd6aXJYWm1XTnhCYW10WUZONTVtcU1HNitNaHZ1a2llOUR6MUJK?=
 =?utf-8?B?WGNGNW9RWmNDbkdmOC9xMlhmQ0hNV1hmdXBSV3g0SEhiSHlBelZNNklpTlda?=
 =?utf-8?B?Y1JkWG9sT3E4b1U4cHNtaFNjNWNrbzhWbWlrNXhwVXpHRnF2WEZ3cGJyaHp6?=
 =?utf-8?B?KzF6eGNMR0RyTXIwa2JIaVhFTG9ZREU0SGdaS1RwMTUxMG92c0FXNWUybFNM?=
 =?utf-8?B?YzVlZjNIZ0tVemNDUEcyVnhZNnZkNHBFcTdkZ3BVS01tbnBKK1pOeGRiN0pT?=
 =?utf-8?B?aGtLZTZTbUJoZFh4cHJYeHM1UVplUmNIR2pmT0lpUEMrRTdvRTAvY2VrZzFk?=
 =?utf-8?B?Ull2eTdVZ05EelVNTGN4RlJNdFRrNkQvNWxjMW0yb0pmRUJZWjNvK1hhOWJF?=
 =?utf-8?B?eDRlVmU3bGo0ajFSa1hzd1JHbER1Sk1HRHdpWFBaT3p2bmdQbElEbFpaY3JX?=
 =?utf-8?B?Z3Bjb1NkSS9jNXFKajhGUE9VT1pnRldZd0tTVWRsVnFCMkhtTjJTbHFYZ3pW?=
 =?utf-8?B?ZTZyM1J1YzI0SU5NSjVQbjJFQ0hiMHNtbzFXWVFTamR0QTZDbXhKRmxRYmtN?=
 =?utf-8?B?bmhHWXBXcE1JNmhCZldVcngwS0F4Tm1SM0NWc0RLcXFhTFc2YkNsLzlMM0Zz?=
 =?utf-8?B?M3ZBK3h4YWc5azZxNzkwVnRFVHFmZHR1QUlUQW9vUHp4RnBwZ3N6MnRub050?=
 =?utf-8?B?VFRRNkpTejhuMXhWaWRZZHI5MlN6NmNlOWNJcmIwbDArR09pc3VabWd0TUg2?=
 =?utf-8?B?b2N3WjBJTzg5Wjc2U28wbGpPNFlwYTJtck9SUkRETmZQaWhyOW1wdEtlQytJ?=
 =?utf-8?B?YjdsVGtZcXFyYjlBZXpVRXFIdzkyNGUyaFZKSENzV2pJMkRCcjNXdUVYZFhl?=
 =?utf-8?B?SkplVVUxa0lzVFQvZlZISEVHZ0VVS0FLNHBzd3BQVzFLQ2Z2YWZvS2ErVWkr?=
 =?utf-8?Q?WZbUCOUvRtBky?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGlodVlHazFnODdvdTlYRHo0dzF3RGx3UDNaeGNnYXdONWlEOTZRTkJTNExV?=
 =?utf-8?B?S0duSDcxd1FUdFl1WXJlYzh3dm5qRExxOXdITm5PdFIzbkoxR0xiUDR2TFht?=
 =?utf-8?B?WXBIVnVSaVlCdkhkOWU1d2N1Z1hrbnhtQUswM20zMThRMk90SE4rd3BOQXpX?=
 =?utf-8?B?Ykw0blljWHA3Rnc4NEY5QkhIRUNjZGhXVW9oQkM2UmpZUmM5dDJTdHhQVkJs?=
 =?utf-8?B?VGh3OTdyTnpyVW1JZUY1elRYM1RDK3Ywc1lObUZqbDVJZEs5ZVhMcS91Rll3?=
 =?utf-8?B?K2tPbnZUcEl6VEdLZWxKM1EwZzQ4SWxmM2s2czhHYWJCYkhBV2Y4OFZrc3Bn?=
 =?utf-8?B?bkk2Rmtxcys2YWZGZjlVTkpHa0pZREs0OGd0U0wzS1FUcU1JeVc4TEtaT3ZT?=
 =?utf-8?B?YUxVUEMrQzVYWlVyOW0weXRObkdRcjlUazMwUmVpTkE4TUx6eTVDeWorTDZr?=
 =?utf-8?B?SHlvT0wxdUpzYmFVaThwK21kUkp3UXZzN0JiQ1RCVkR6dWZveW9OODFLb0RL?=
 =?utf-8?B?dTNaT0tlVDQ5MDc3S2hmdFhZTmNOQlY4L2F4ODR6TS96ZHdVZFY1d2d1QWVa?=
 =?utf-8?B?QmNOMmsweS83YlMyT1IrWE80NllNNzJpQkdCbmF4NFZMRjgyQVlPT0F4MmtP?=
 =?utf-8?B?c3RtZER1c2l3ZEExRmJWbGo1V1B6a05xWEh6RlFDMzRZSjJ0Q1h2NjBmNDhO?=
 =?utf-8?B?alI4cFY2ZWhtUThrWUozTEtUeUpJQ01WQU5zWTNKc2M4NUNJWmxzcExaUzZS?=
 =?utf-8?B?Ty9jdGxXam01T0ZpV082aHVlZW1saExpSm1BZGVneGNJY1B5Si8weHlZWm92?=
 =?utf-8?B?NTVZYm9uSVJNWjB0NW5NS0hWeTE2RTFaM3VJT2hFK2l4dHpjcTNHeDErMjdN?=
 =?utf-8?B?SEovYkpDRmp5bDlyWWZWVjkzL0hNYmozUGQwcDR1ZEYxMStMNHZkYmV2T0lD?=
 =?utf-8?B?RW41TUpDc2VZRXNFUUZoWEJUd2VReXRuRmtzalYxVXZldmVWazFxUytHby9o?=
 =?utf-8?B?U3NRMWU3WjNVaDRjTGZjSG55bG9lcFJyS1FtK1BPVVB0TE5LN2RCV3RCbHhi?=
 =?utf-8?B?RDUvemRrSzJPTVd6L2dxVkNSTUtDZVVLSXFtYUFvUU40WUxSVzZ2R3UwMDRO?=
 =?utf-8?B?dHFnL0V2UnhyUWJxQlVJTzhleHJYMmE3cDNldThvY3lzQWQwY0RIZkZDNFEz?=
 =?utf-8?B?amwxb0UwOW1NZFVNNW9XcTBDTXh0VnBJbkNMSVRPQXdqRHZHZVFuVkhKUXp4?=
 =?utf-8?B?MDNtdk9iSXhMM3crUTZLYTNjL2k0L1dpSTcrWjNYT0Jlc0tRTVZ1OHZVM2xu?=
 =?utf-8?B?RSsxVkJXdW1senJDa1grVjFnOTBUb3E1ZEpUdU9qdFd3OVdxSWlHeHJNaEZH?=
 =?utf-8?B?RitHNGZ5d0NFRU5heEpra2Q1S3lGdDhHak8wZU9hSmE1dU4ydi9SN1cwYVoz?=
 =?utf-8?B?UGh2Z2hmbXdCQXZkQWNjUVBDWVJUQUErbkxRV2lRYWhsQWtZVXpvVUtDM3Y5?=
 =?utf-8?B?dllBdzBvWnhXR24wYjVZSnpqLzA2QlplVDlwTzlkZ0hrZFdoSEMwVHNwcXk2?=
 =?utf-8?B?TzZNeDRtb2NyTVpDb1NvWGxUU3JKUzRKWURUY0ZpTnJKNjJkMDdyTUxrWWZU?=
 =?utf-8?B?QnZqZXBCRzNrYWlrN1d0QklpZHp3aDVlU0c5V1FzQkYvNndLRWh3ejQ4R0l5?=
 =?utf-8?B?b0twM0xENW44enc1MWlGb0hwcU94YWtwR3NXT05KNWdGbk5kOWNMUGhiRW1h?=
 =?utf-8?B?Qk4waEYzYnRKbTJaQWl3TWFLRks0K1F6Uk1nTmVORmE5VVhXNC8wdHh5UVZB?=
 =?utf-8?B?dms0VlFDbStqZXowUnljbjQxbjNwbE1ha2hXSlYyb3lESFlKaDNWSC8yT0c5?=
 =?utf-8?B?bWF3WWxpZy9LQVhVam9jenJCUGdSdjZFeWZZTWRvTHdPTFlxMzBaVEd1WFhi?=
 =?utf-8?B?RzRUdGEzYTBxUEt4UzBLTWhZMHdoWGhZclNjSEl4SFNQcStseGhZSU41Skpq?=
 =?utf-8?B?dDVXb09leVRtWkVKNTQvSjZEZFA4ZmZZWHRSUUNWN2p3T21vdnRUWFFIQUlK?=
 =?utf-8?B?T1hJWXV1Nm5DS2pqcXFIUG5jeUJxdkhLNi9xVkNraXN3ZkVZTUE4MmRsWmpH?=
 =?utf-8?Q?m6pKYGIWcSJUYdKASh6k/tlnx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60336afe-fd51-40b0-79ea-08dd5a8e5a38
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:02:40.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAYFXTGJuggJZXJR1loc4VI1w9ziqBk0talFCZFJd+WAh2niOdFdCu9dRuBAUrjELmLwu4VdPSjI0OIR3cWS0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912



On 3/3/2025 1:55 PM, Paul E. McKenney wrote:
>> I tried the following command and it shows the patch in question in the first
>> line of output. Basically the question that the command asks is "What is in
>> Paul's dev branch that is not in RCU tree's -next branch".  This question is
>> asked for the obvious raisins.
>> So I am obviously missing something in the command. Thoughts?
>>
>> (rcugit is the RCU tree, and paul/dev is Paul's dev branch)
>>
>> git cherry --abbrev -v rcugit/next paul/dev | grep "^+" | cut -d' ' -f2,3-
> I must defer to others on this one.  I must confess that I have not yet
> found a good use case for "git cherry".

In this case git cherry was seemingly correct because it detected a difference
between the same patch in your dev branch versus the next branch [1]. It seems
the next branch has the fix with the reordering of the statements. So it thought
that your branch had a patch that wasn't there in next, where in reality the one
in next was "newer".

[1]
https://web.git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/commit/?h=misc.2025.03.02a&id=153fc45000e0058435ec0609258fb16e7ea257d2

thanks,

 - Joel

