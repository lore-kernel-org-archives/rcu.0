Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7FC201033;
	Tue, 22 Apr 2025 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362522; cv=fail; b=UJRiqY9fROEZnPQ/J7N3tCPuZ03aJQF8ZRRI69jmKNRPdsdtP0g6n2zeVHD7P/oVgM4G/bmJbIiJXC+Ybi1fGCWduJiHOFbG9lY9CTVW/iin4IH6hKSd/uFUOz56+vvpnpJZjTzT9NhrKtmSOlJ3cxGHP4Uv88zgU9PKSHw7Bw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362522; c=relaxed/simple;
	bh=IhrGdQgwdXcDTOGaHzPZnZgttXFeFgzHWfGIO8eQrRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gHcjV0ux4sbU22oUBh9jnihsV0rmCUvbX7yS2JGaPU+HivIconIfoW1N0YZWxjayawUdnwsqPzAZ35WgGLbJ/rSpeyRQct/L33J9HjogakTxpc6DCs8NayjGX0PR1ZRRMcITtadGrvWOXPIcbHVqsbMMZpWC9cY3tj5wC98X7pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mCG2YVUL; arc=fail smtp.client-ip=40.107.96.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mCG2YVUL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hv+FAF/b0/zkwkvMsUxdJrFKNQgUbmOZy8aoJs0JEXMk+9310BYRym/tyeMh2iRrQPfJtOmsBlutS9ghTEatsbIwmJRtp2jNOpF2w4GSQlonhR2uQH3J6eb7jkUkEKNyMrZRUQteHeNpP0BxosvELIJJ2L+GrSAkQU166UYfDC330pn4RDNZF6PXWw1J+vQvqru6cf9cKjeavVurKtWKyPbLxG9PPkpJfi0u/wAkauCN3332HMYo4jmNwELl6Am+uUUIgx9UovBXU8CX+EvEI2qVR1bJayFgsdRCZvFxYufObpKRC28bCoQpzvAKHH8vwsQk4ZKf9z7Uhc5nkYXL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoK3iwdSXuG56+HF0G8MsvnmQbGoE14HpyubJIbBSzk=;
 b=D+y2eJbCdPh4KxvdG31jbrqMQzTBaiSSPOd/OA4jkwzU2J0jOqKyRe9i55v2RQvQBDAHcDNFPzWiGP/qPZHcHbXSnuIHr6pYO/pxM3au7E2Sxy3mT4PNGnHrnisBO7H12ETedjNhpzki2TqFUwQYMsZey44tZJvpWE9A46sL8HtpImiHNDLP+GpBxZ4xkEgifHqJDab3Gabbv29c31gct1yL+/w5M/zUK3Ht07Du+gcvKyXf1IBY2V02zdP2+IGThx2Es7AlB8cjNQeRd05ZisZlgtV1OTkwfAxKALviD02BmKyYPrOK2qUdVqAGTZ6VrdboI2m9/1eqR1xPMk/VyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoK3iwdSXuG56+HF0G8MsvnmQbGoE14HpyubJIbBSzk=;
 b=mCG2YVULAWLk6M2xwJm6+qxPs3UE0bjEkxDnMLDh6RlAplKKLn51CrHov3EYGN3yCuOA0khbKiBzB4QGsWiKLwCcnqAVFPjsepLuTrEqQecTPnGpcaQzWb7ZMn3AdIqkkMAxkxcdu9g4BJE7dZowFl5cFrNxBB6UL8z//HJB15YQBg1NbhEWZ0QT89ZmQEn5sHaOP4Su6k28ud6aHWOCFJQkxETPGx5vNYDYsmZLmll21r18Pfk/N7QDNLCAAK2sKobOC60QnfB9x6iw8NoLBDsi/tDyQAUv5JupB0YROhoAxDsJpdi+JPVYNTZHtMo2HtQevM6hpp6hfEbT/qT2Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 22:55:17 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 22:55:16 +0000
Message-ID: <1a9388fb-83ff-4345-ab2b-6c1825913d71@nvidia.com>
Date: Tue, 22 Apr 2025 18:55:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model/Documentation: Fix SRCU section in
 explanation.txt
To: paulmck@kernel.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20250422173830.90647-1-urezki@gmail.com>
 <1497ef3c-b1fc-4723-949b-28d92a3afb6b@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <1497ef3c-b1fc-4723-949b-28d92a3afb6b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0105.namprd02.prod.outlook.com
 (2603:10b6:208:51::46) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c5907a-994d-4fad-2c35-08dd81f0bfd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE5JWjVBekcrN08rc091RTZPb3BiWkVqMmc0a1Y2clR3MjNtSXVVRk1Ielgy?=
 =?utf-8?B?KytneXBuZVdsMUlEQy9keTRZQU1DcEFmT09zR1BDMUg4eUEzMDNFalhPRzli?=
 =?utf-8?B?aFRlb1JSYVlXbDVkWlIwY2JiL0tEMUVkYXlRUENoVW9KL0w0RGo1YkdoN1lv?=
 =?utf-8?B?aitnY2dGUE1JRDh5SW5rK1F0VGRQRTBpaVZaQUdObGpHd1ArWDJnaTNtQ2x0?=
 =?utf-8?B?cjFKNGFpcHY2MXV2MDhOMEZ5RGQ2Y3k1Z0hHMnJrSTFSVi9nWTl0cUw1d2V3?=
 =?utf-8?B?TGMyUjR0czF4Y1lZRXZSQ3NaMnFHNDJOWjAxSUw2R3dNVUxrRFhqUTU1RzJI?=
 =?utf-8?B?a1BRaXhDS0ZYUHhnZDV6TEVLUUJYcUFtSi9RQ3JWMlJGVVR1T0g0RTJDL1Fn?=
 =?utf-8?B?Sm5DaTFHeVdlVGdHbkcrblpFVFEvUVRxTzlyRTR2TVU5QzIwOGJCd0tYSG1Y?=
 =?utf-8?B?Y3JWOTdkOGcreFdURmFxcmF4SVoyeEtQTWVaRmdZQUk4SnlHUzhKbUQ0NW5U?=
 =?utf-8?B?aWhmeXpHcTBYalJ2MlpHTFNCK2wzNnJRTkZ0T1VrVXN0L0RFd1IxWHRobEoy?=
 =?utf-8?B?L2liT2F1bWZmczMrUFUwc1ZWT1FyeVR4WHZ5aGN5RWlkZmtBTkhkbit3SGp1?=
 =?utf-8?B?cy9UbXNTbWNvTGJrWjErNDFsV2lyVGxPbVgwRVBLMjRKUE5pYnQ0Qkh2MzZB?=
 =?utf-8?B?RGdSS0l5M2daU0s5SjlzQSswWlRsdFppYXRZcnU4OTI1cHVacHgrSHpseFAw?=
 =?utf-8?B?SmMxTVlKVVgrcitqOTNseWl6U3FLWUdTOVNnMzl3TzdSbzBPNEFFL2ltTmxU?=
 =?utf-8?B?UE9xbCt1eUdkVWJpOWdMTFJLK29XMGN4eVQwR3V2K3VNVzBESm9XeDJGMnFR?=
 =?utf-8?B?UElCeFI3YWJFZVFTVnJib3NPY2VWOUwxVVkvekw2Rm52c09lY1hoYmNJUkJ0?=
 =?utf-8?B?T01hd3VGazVOWDNwT2swZkdnUTR0d2RHc2JTem92NkJ3cTNiTDh3SWdxaDZy?=
 =?utf-8?B?S3I4SDBiSXZQYTFBalNzZ0oxRUxNNm0rL2RuUTBud3FYNDlXQytwZFRWYTlR?=
 =?utf-8?B?YjVuandkUHl5LzFEaE9vTG0rTExwNkR0SUtVRFl3WDNpcHYrcGJNY2F5aVVK?=
 =?utf-8?B?R3JiNG1ONnZ1aVkrRzcxZzVyZ0d1TmFIQUtQUElZRlJBR2RtWjg4WGlROFFq?=
 =?utf-8?B?UnhnN1dJN1NTOXNmb3VCTTdLSjAwbFBNd3liMjN3K0NQZUVIdWJjUUVsMElJ?=
 =?utf-8?B?UHcwU1ZXcnJ1UkxGdXV4NmlRcUpiUE03UDE4akxUT2w5WkUwekQxZzFtOUNt?=
 =?utf-8?B?TzVnZ0R6N2k3MjBOd0k2RnRKclhEaFF4eW5wNlVEMTJwNzVNMWNqQ1Ira05J?=
 =?utf-8?B?U3YzUGtPN096MHhsdGRLRDRCdjIxbGtURThRTWJrbUpGTGxmc1NlQ0haN2Vp?=
 =?utf-8?B?RTVxR3MyV3pheG1lQWdkUTZPY3pUMkpZOE9OZUVUU0ZOYVNpT2ZHNCtpRlNl?=
 =?utf-8?B?a25sMnI3cHJBUHdwQVllZTJ4YWFpc2kvUURrQWt1dGtMeXZ6NS9NbGd5Yyt1?=
 =?utf-8?B?ZU1EZHNPd3gzZG5UQjRYbmNONHppa21yS1FjYld1K1R2KzVjZDAxTm0rZGhK?=
 =?utf-8?B?ZG5ZT0o3QmlXS3R0cUVwV0c0L0twZStjU1NraUR3Ukk3aVFzZjR2RzZ6RXV2?=
 =?utf-8?B?cWR6Ulo0aWdIMGhRMXJ2eWE0YnpTaEx0Rlpic3grS080dzB1dWxZNmlFeVpn?=
 =?utf-8?B?amNJMXVuQlQwSXAxN04xeDB2QkN0VWZMblhrRk55cUJtam8xcVh5Y3gwU3hV?=
 =?utf-8?B?VWZpVnQ3L1Y2elFXL1FYTU5MUzFVOVJQeVZuZmx1Und2RGppeWlLOWpCR0lk?=
 =?utf-8?B?cUNIY1hiQ0dkRnV5azVVbUZxZHBRQjNJakIyLzlkNHg4N2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDBmV1padkNyaEdwS2I3OEZRdFlVNllha0lPQ1JRSnVnTFhrREFucmozTjZ5?=
 =?utf-8?B?UFVFeEUrU2haak9yZVJGS3hKSG1HaEpZU1hVNjVpdEJBT1E4ZUxZdUw5Z21X?=
 =?utf-8?B?aHltSEpOMlFiZ2xBbGFaN09sTk5uc3lhVDhKZ09LYXV4VmVQWEt2dktsQ1JK?=
 =?utf-8?B?ZE5lYmpEby9sWGxIOVFFNnY4aUE3MlB0WlVPeEJVM0dKazFPeCtkVnNkdXlE?=
 =?utf-8?B?Nmxnb0VxR0NkREtCR0hpRC9BazBCRE1TaCtXWkx3dWdLSUhrbjdsN1Q5ZCtY?=
 =?utf-8?B?MEFkbkRpKy9ETklWRDdaL2dPUlYweUJ5U0Y5bVlCWmlsQzh6Q2VBaFdXUUxk?=
 =?utf-8?B?VEFMVWlHcmxnQzM3djVzbWxHWUk0bnRhMGtFcVh0NnNieUVWUUJPVVdJbTVh?=
 =?utf-8?B?YURCSWFRbjFQMzk3cnZ6TFhsUys1VytVOUdPT2FLMUtTbkh3cGlHbGdhemdD?=
 =?utf-8?B?d1hjTGgrS1VKRWRVT211OTBxaFpubERvRmx0bzBYK1RtR3k3VUVJb0ErbVR4?=
 =?utf-8?B?NFEzV1FUYkwzNFhBK1Y3cjUxWEtNL0FNV0pIWjlHQ3NZRnFxdjRjd0Flc1h0?=
 =?utf-8?B?S3l6MW1rTkQ4ZDNaWjJNemtuV0dlQnFlbnN1Zi9jYkRzcTI4Q2VSWSthMWtM?=
 =?utf-8?B?aVQ1NVRidW1LeHB3a2xjTzUwRHo3SnUyTFBoS3FqTzB0bEVUOWtEcnN3c3RL?=
 =?utf-8?B?dDZUQVNicVNWZWFXNVNBYk5WQlFTTlFRb2x6RVlEcm9CcUdNVFVJWWFhcEE5?=
 =?utf-8?B?Y2U2MjY1VjM5T2tiMlVNNFpPZUYzOGdPUWI1VTJ2N0syTTZndTZLNEpucU0w?=
 =?utf-8?B?NGtvRnJCQmw4aVlQTFpFblZsQ3lQRXFnUVY3dHZBYmF6R2NnSE55UXZFQ2d3?=
 =?utf-8?B?Qm5TLy9QRUNMRFZXSGdhY1NpWGhMSEY5ckx6V1F5N1ZiVDFPL1BMZTV5ZWJI?=
 =?utf-8?B?MXBxdWNIQjlBN29LREd1V3BUVTJWNkd3TUVPRmViZFJ5M2VWZ1ZTZTcxbUwr?=
 =?utf-8?B?QXdaanhGemhWM0tpYWs1TGtMNGhIcGxYN1p4NEE5emZlc0RrejJHMUVCK1Ax?=
 =?utf-8?B?RitPLy9uMk1GczFKNVR1VjFqZ1hxOHU3WVYvclY0em1IcTRQbjFkVk80SnB1?=
 =?utf-8?B?d1Y3UncxMnRTK3hMVVo0aW5vZ3BpYTYyS2EyOFBScGtyam4vYzlTSXFjajZm?=
 =?utf-8?B?cktDWllUTGVaU3V5N0NYTEx4dCtCanpJUS90S0ZBbDBseUdReTFSbTBQMUxN?=
 =?utf-8?B?bUNLUHp0bkpqSzlYYXBseWVNaWJrRnVjRGlxUk5HbnBweUlYaHFCNDEyaVRL?=
 =?utf-8?B?aFZia3FUdEhObFpRYjZpMEhCdTMycWZ5R2VhbFdodVd0YURvWUl3NkZRRjVO?=
 =?utf-8?B?M01TbkVMSXFCYUh2bUU3NmFSUEp4T2o2WFhERVNDQWNsTW43a0Z6YXlCTE9D?=
 =?utf-8?B?eW0vU1Z2QmtRS1pEQzN5bU1ESFo3QzVFWVJvVk8yaEZiSjlZanRuSTZ6R0k4?=
 =?utf-8?B?NzdqRFpvaUJnZnRDTnh0NzBPRlNlTlJIZDMwM0NsMDE0TUJLR1hiTGxFNzgw?=
 =?utf-8?B?K3Q2RTc4RFZFdm41VWlCdTNLTHRtSFNzcVJuWW9IOTB4aTY1L1lKM3N5UnMx?=
 =?utf-8?B?M1RySElDM2hyK0lEcnlsbllOWVVTLzZKZjQwSm4wdDZNU1VteWcxNHJHMy9U?=
 =?utf-8?B?U0pIWCtOUWt5N0tVTFp5cWhnV0FrQjZuMFFySTNEazM4MDM0WW1kU1o0STA0?=
 =?utf-8?B?VVlwcVU2c3lKaWZUaGlrTkRxOTZVMlNuQVNGRVo0QVRlNTJGdHczV2dxOGwr?=
 =?utf-8?B?RlQvUkM5eHBqTFVzV0NhemtIOTBCRCtFWGhJcE5GdUZLeHpqd2FDcGt2STZ1?=
 =?utf-8?B?SjNwRm1YUUdVQng3QWZWQ2FabDdCNTJDMjhZMm5uYWdPN2Q2bGk3WUJsT1ZF?=
 =?utf-8?B?MGQ5NnlzdUJIeWVXNVBUY1NZaFZubzltaXNMdkd0aGlrMFJ1UVpwdGdQOWpv?=
 =?utf-8?B?ZFU0TXNPSWpMeDA2djJHVmZiM1Bnc3V1Wjlhc2NKck1JNWptd2o5bzZlWGtk?=
 =?utf-8?B?Wkh1UWxoM1ltdUlnRTR1Y0g5Rzh2TURkZTBlc3BYUThqaFJsbWY0aFVvdUZE?=
 =?utf-8?Q?4x4mk0s/5I44WLNsuh7LAO17i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c5907a-994d-4fad-2c35-08dd81f0bfd8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 22:55:16.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9zDV/zL0p3a6U2VLQGv6zamUGNyVoud9348blD6gJogbqZGZ6SnzrZmputxSCvCHpKn3hwit0gTDVTpu2oqLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607



On 4/22/2025 1:56 PM, Paul E. McKenney wrote:
> On Tue, Apr 22, 2025 at 07:38:30PM +0200, Uladzislau Rezki (Sony) wrote:
>> The SRCU read-side critical sections describes the difference between
>> srcu_down_read()/srcu_up_read() and srcu_read_lock()/srcu_read_unlock()
>> in a way that a last pair must occur on the same CPU.
>>
>> This is not true, the srcu_read_unlock() can happen on any CPU, but it
>> must be performed by the same task that invoked srcu_read_lock().
>>
>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Good catch!
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Applied, thanks.

