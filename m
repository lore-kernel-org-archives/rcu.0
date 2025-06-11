Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C49248895;
	Wed, 11 Jun 2025 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678544; cv=fail; b=lW9WDBNE2+Zu/p04knAhqcEq4Z6osyuxsI3TvVxQo5jQ9d/uo829xjdxe2q0BJ4IyLoROWqvlOEJ/jzZ64jua7PHoGGfOALbIGxfE7960R8fSHI/WyHfDYJi+ZjoI5cSDcVeJf03PkVTQA1dfRzfil+usEAVy+RpHZFSQxAFkLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678544; c=relaxed/simple;
	bh=bLVEGp56C7qP+kCsnW2p8E4lGkHbzNuTuwVpSsvaokM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HCtzfW8GefYSP1T9Wjdy7SgDBfRblfEa1LL2hRcKGNZ6sKSbbEzjJcuyPRdvDpdY0IUVkkwTi0C7v2DV3QIR07aXI+ydIZ+XnoR4/m/D7d8em8rCEGxLdu6nHQmVhUI6Qi6EUrp51EO2Y1/81RV1ayTYTJrWww3CpUJ5eKyfqZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cwRS6y4z; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cwRS6y4z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxpRnMAsZtIbD1Ex5jPYjjqh9CTxfPKU1D88ChMdT1YCAqf/uYI/8SXSn++DGwDl6tiNFDVTSqOpohiKT/6t8IUeONbqgzfKK6zFZW4iESC2rbzBoHdFMa5j8v/YahNgFlJxC5fFiDIVomFf6jPX4sbFjkuHKUnM/OG9QvTbmq3DEhMCMAkDCb3uFNrbJB9YN1TVU1GwhxT7pre4anJeAO7f38CvLj/qvDm1/DnK8n6koUn0QHzPZzsYZUmHHP9sUNQ1s3jfpZnJiDmHOTchWQEgdGTQjQANOez2O8UfCvP0b1G5aCwzQiqF/l+zJFKwVkjedhrm3uw7K3fP0GdMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4YKvwQtncUA83/5+RrXV+r3udazFMtmGlQ1x4mjBF4=;
 b=YJtuTZsVgeUP3TRhYSQV4b+B0mFTK8hbY6sEsEF97G56uRSSjkTUF42EvIQKM6qCVDXx2SBb7y19pxrLWk7Qu6m0g5HxtJ1RTj2OwcNpIysa4Y74NpmF4o3UglkOsyDmS9V9izeIsXmkmisqBupgVSiRwQNlWEGPKLbhp4RT3aahg0cL7donmXzXcq+BZT1EzkxN2SBboWGjm7WBMTcejffu1S1+QUBz1JB5L3cAvIZOHFD2FFiWaFHmfQWlhxm35rMZ3PA0JiBZ3JhK2MTlCPZs748fRNBtrcSW9HqyOzRsM/av31MxyoPg/asOPcgp2WuNy1rqCjfD5IHtzVHEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4YKvwQtncUA83/5+RrXV+r3udazFMtmGlQ1x4mjBF4=;
 b=cwRS6y4zuGo3IONrFnmCUu6i7tMTXPo9lxw8iqxXkc9kS/Inr7Zl4mtemZc2ULew89qGmbV6J95A8vCMNgo+Ve4t0pLm5rFcvnSFcZf+tHTrbNd0pwfHSAAqmj242PFzBjzeJBvt4iQr9aXs3ahQ74tKr464dvmyk9rgubBdxr9c/tLW+fNP22BukswDD69L80PiQzL/N1tAYXQPcg0NIpf3KU4gLE5yXtyiRVZmnEYTNK5GWlJzBDjlZkUvPOjR3LaKz/eQ7zLXYuzR/5mVPrQyDxWSS9yY84IyutDM6G8iaFQHHAzzZXRO5MB/mqIQVucuX94mLcOnyh2v7ffdJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 21:49:00 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8792.034; Wed, 11 Jun 2025
 21:48:59 +0000
Message-ID: <af4557b3-4352-400b-a000-0a3f2014526e@nvidia.com>
Date: Wed, 11 Jun 2025 17:48:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rcu: Enable rcu_normal_wake_from_gp on small
 systems
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20250611175658.91361-1-urezki@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250611175658.91361-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|BL4PR12MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: c51eb6dc-bfdb-49f2-4f59-08dda931c607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3FJVlM4cUs0V2xhMW5YNnIveTVsNmRvb2FnME91TjJDRWVpZGxWR1ZNNjBG?=
 =?utf-8?B?MGZSZExNQnp3LzYzeGs5Z1BNZDVOV3IwRVYweGFmWWU2MlZsOUFxYW1oaVgr?=
 =?utf-8?B?SFBpVE5lL2s1YUtTeXlRU1E1clFoV2ptdkkwZC9ZdjRlNDlwS0Zlb1dYZjhh?=
 =?utf-8?B?MkFGd01vSlhrTDVHRFZDUmpxajhsNFhlaVVvdlVrOFBqc2JmY0VHNDF6NlFJ?=
 =?utf-8?B?NnRFS0wzNEg1UWM0MXVYVGQraFpBN21lWkE0L2FHV1M3RCszVDVTc0xEaFRQ?=
 =?utf-8?B?RkVIdGI1b1RLcnVhUGRid0QrTkx3RzhXSzZoODlRRWNMVDhpbWE0MHhtWDlK?=
 =?utf-8?B?RnpWU3c1WDFCRXJIaEFGMk9LQm8renpaYVBHU2hJc0cwdk5ZaHZiMEMzRkFV?=
 =?utf-8?B?UFh1TG9ZUGlaaXdYYmdpbEFLYjROc0pDcXlIN1QxZ3MyQm1xN0llWm9pVjBs?=
 =?utf-8?B?dTFCRlMyRVdkQXI0c0hvTEJVdDVHMmVSelhacnpKbWRsNjd6a09PdHM1d0FO?=
 =?utf-8?B?emNFeVZoTGcxdVk3M1pVRHhvM1VOdnBkNkdHQ2x5cmxyVjJCQk5qSlVwNW9x?=
 =?utf-8?B?a05FckVSRjRVMFZEckJxQWlPdUhNbkVQQ0Jiem9aMTh1WU8yQXkzV0t0OURO?=
 =?utf-8?B?aTFYVnVEdHFaanRCelc2c3o4ZFlDMjZSN3RZQTMrU21xWWM5aWMxZmZYUEsx?=
 =?utf-8?B?OW82Z3l5SjU3dnA0V0tlL3kxVHlDVm1KNEZnUy8vRTV2MFJQUERnNHlNdUZy?=
 =?utf-8?B?aVRQUE41RzlnQ0ZGN3NqajhIWERId3ZqWlNlRTNBRlJmUktyUVJwOE1tbGZC?=
 =?utf-8?B?dXFBdW9wa2RGSnJqYURvNkpRNTViQ25YMmQ1YUlEcEt2SVJESi9wNjh4UkR2?=
 =?utf-8?B?V3dJdjlxV2N5dENXUC83dmxJS2FuUEhsZ1ZoOW4yemdmZUNTK05wbEluQzBT?=
 =?utf-8?B?RlVLMkVobVl3d1BXSlZoY1gweGtqVUJZTGxlTjdUc0hkNmoyWHdTWVc4MGRN?=
 =?utf-8?B?V2tCRW9SMWx4YURLa1hEMEVYSHRyYWdGNFdRVkhGRjlwU1psTkhKcHZ6S1BK?=
 =?utf-8?B?VW9OVEpGUGxvNmQ0VndwUWU5cldHMmZnKzlIQ1RqWVZsVFM0VUdqZFBWclpx?=
 =?utf-8?B?WGg1VXJnSmJNVnVQNkhtc1VnVExKMW9rMW1rTyttMzNoQ1pFdXBuck9ZMktG?=
 =?utf-8?B?Q2JuMzBOM1lRZGFJUFJGdmE4RUtwRjNyYTdFRnliYnJlMStEVWs0UzIreWlu?=
 =?utf-8?B?UEE5dkU1KzNFemhlUDhhSDk2OWFLYjdyaWR6NEtMcVAzN0l1UUFyVFhrWmJO?=
 =?utf-8?B?VEg5MkF1N2N2dzdBTGkyanFaUXhCN0g1L1BCSmN1QS9CczZMbmZrNTRlbUwx?=
 =?utf-8?B?TnFsYlEzV0U2bTVHVmY4V1dtY2xZaEExcFFwZ3VQNDNxSHI1VkhTMGZjeUxa?=
 =?utf-8?B?NHFiSmp5R3NuSHZwVjV4MEZIUk1DcXVCZWltSlFPZEZnclF0bzVkRFVPbngz?=
 =?utf-8?B?VVhuNy9QZWpNdG93MUJoQk5MMUMvaGhxODdROFd6Z3F2YVNXSEdyaUdRYzUv?=
 =?utf-8?B?dWh6MUhPdE0xRlBQTmZNTWp5YitpSE5SN0dZRnl5UjFqL2Z4bW1xVjZGdXFw?=
 =?utf-8?B?YnhHdUg2R1Z4Qmh6T1k4cjc3djRSYTltcVhpd0w1SERWTU9xNXpYbzR5RnhY?=
 =?utf-8?B?VTE5N1M1cS9qQXMrZldaL0s0SXQyYmtsQkxQUXEzMW1CQnpXd3hKOXhjUERz?=
 =?utf-8?B?Rm9kMjZJQ3NLakMraVRJMzVtVlhHblBNMlBXOGgwQkwrd096Z1l2M0xjTWRy?=
 =?utf-8?B?Wlp1V2x6K08zaTAvdFNOcW1pSkNvZDV0TWdsbVRNemppdHZjdURmQ3RZdDJZ?=
 =?utf-8?B?K2Qydm9RVDlsbU40d241Ti9hYXVCbDlVUWhHT21sR2c3c2s5SGJUOTNxWDRR?=
 =?utf-8?Q?nGzQZitKisw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjlmNWMrS2tkZk0wUG50ZHU4MWNlekYyem0vOGQ4Y3E0eGVBSzdhV0lVWk0r?=
 =?utf-8?B?dXZ1OEVCSXljUmdpcjRJanRzZ2M1NTI5TW5pR0NTM2VNb2ZUaUlZMXFNbTFU?=
 =?utf-8?B?eDlSbzNwMFdiUnVpYmtTZ0tGRW5lSmZUSHhURVdCQ3dodzlXOG1lVEovNXV5?=
 =?utf-8?B?VFRjRDRBNDVRUTRXeE1DMGtzS2NZRkRWbEtqTWZrTmNSZG5aSFJYdzJOc1Ru?=
 =?utf-8?B?U3NjdjhneTl3R2hETnVJRXFnMmZTMjVSTFlZVHdWdXV3Nk8wanRwRGRvVDIr?=
 =?utf-8?B?eWtOS21ud3hHT29WNmhsT3BvN0lDMmJuNTNiZFF2L3o1b0R2eUVCbC9PakQv?=
 =?utf-8?B?dGFDeWlUWnlwbHp0SWdSSmJNckovNTh6cjJxUnhBa3dQamZtMWVON2VSbm0v?=
 =?utf-8?B?Q1A0UTFmLzhoZlNCMTlsVHdpRllZSHpqUUpjb1dhQWpNcjc1K05nRGI1YlBY?=
 =?utf-8?B?ZnhPdEgwZDF3eGIxVWFFUnUwTnViaGdnVGdYa0l3YmxRMXovSHBWV2hqaDRE?=
 =?utf-8?B?YjZ1VEtCQWptZDYvQkdzdVRTenhOZkdGNm1wbkRPWTZ5Tm55RWlZU1UyNjJr?=
 =?utf-8?B?R1hpWlZDR3AxTTZ1WjNuTXgvWGtrVU9KWXNhVWE4YkwyVEFhb3RLSjlHTDdF?=
 =?utf-8?B?a3c1eVFwU0lSVTF5aUJvNjA1RzVNZlFGWXZXekJCT1hTd0ZyOFljODdmUzRC?=
 =?utf-8?B?Q0t6R0VrUkFoNWtuektvcEhzTnQvbjhCOUU4aGExSDlBSThnbTVJUzE4UkJk?=
 =?utf-8?B?UGJOc2tSRGVlQ1g5SjZlYzhvOHI1YjAxajZxYzJtZmlobTNRd25kSWYzS0dy?=
 =?utf-8?B?UWd1RXN4SmxNdzRQdi9uVGpxVEFSMTl3UWs0R21WRHord3RoUm4rcTNaYlFk?=
 =?utf-8?B?enh2czAwOHV3QytkZkdLaFpkenlobGoxRUVMbDBZWGpaRTFmYmE2MDdMLys5?=
 =?utf-8?B?ek5VTlBGdVhrdW5wUDZIZHJobUNHRnhZNXlTaFVnRzlRdmdVYWdxa0M4cVdm?=
 =?utf-8?B?Wnk3ZjlQME5aK25SN21mVjJoRjdGU2RIaGlUamdVQ1o1UnlZbENVZlFnY0wx?=
 =?utf-8?B?RUpUR05mN2JBK1l3cmlNYllSTkJUREpFQ0lBN013MHA1OEFRL2F6bmF2d290?=
 =?utf-8?B?eXBZa1R5YkxiZGlleWxlR1VvNEF2UVhmN05xVFd0ZTFqNDJHamY1SUZIcHp3?=
 =?utf-8?B?Q3dCZmZITzliRFBzUTBqSmFUTFVlNzBNTyt4WjB6YzYzN0NvZmUvUnJJN1lD?=
 =?utf-8?B?MWVVaFUwRkVMS0xJcklmYWNRblVDSzB2SnJ1NFVwRGlWVlVvankyK0kwc1Rq?=
 =?utf-8?B?VU81aXJ2MWt6TFowaVc5bEE1VW9KNmlBYlJCVm1qUHJzZkdhQ3hlbnlVckRu?=
 =?utf-8?B?SkZPalVFc3RPY0ZvNDRST0hsRjZ1VDV3YnVTNFhsU1JWOGROcWZXRk9KSCtw?=
 =?utf-8?B?QXVOaTR2anpBd2NYQ3kvcXZ1c1hUZ3RzS21qUzRkRmlMS2pJaERETGxmU0Ex?=
 =?utf-8?B?aGFaUmFoSkhGSTdmMHI4YVdZekwyU0RxK3VqbjBuQWhscDVXQ0lMUVU2ZkRU?=
 =?utf-8?B?TlFidlY2cW9jZHdJeVNoT2FERFI1WWJNb044MkhoVmRoSEUvWGFXa3VuTTRu?=
 =?utf-8?B?WEp5VmVMdmlNaFlCMGNOMFA0UmE0a3o0SDRxbFFpbWNyVHNmaysxUmcwcUtm?=
 =?utf-8?B?MFlyRWkwV05FVlhFaUtpQ2ZFM3ZyTExrSi9NNm1YTWtsOVZoQ1NEMjQzUzl3?=
 =?utf-8?B?UWRnVTZ0ckJZdkc3ZXljL0haZVJoMitLOFR5QU5GMnhrT08vNjR2VTdPeXpq?=
 =?utf-8?B?ZW1DYWpJTWJlWUNoRDZ5TlR0Wkg4ZmU1bEorcDljbHRWR2grVE5tZHQ1aks1?=
 =?utf-8?B?YUxDZmZsU0FicFRjUCtrLzF5clNzZzkrMGNRMGF5dUFCdWVORExhc1RxMGNF?=
 =?utf-8?B?N2NzVEQzOWwyd0ZOTXVXczg3SjY1dEMzTTR1amVzZlBpQkZOMTN0c3pnNHo3?=
 =?utf-8?B?V0hjd1ZIaUNNeTJkOVN5Qms4OHgwOG1mT2FIWlQyUzVEWVN0d1ZSZi90Vjho?=
 =?utf-8?B?WHVLTTY3Z3V6M3orR2pEZmRTQlNNTmd2OHFnNHYvamd4OHVyaEFwUTV5czBB?=
 =?utf-8?Q?MmBzn6R9665vAZZbtgbbTsQul?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51eb6dc-bfdb-49f2-4f59-08dda931c607
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 21:48:59.8905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mzS4n977Y8KXnUy6v3X1af3sx4RS8xWdvWUW9F3kxG8FMxlW9Qr9QBeXRM/Mrl2gcAXw3zXTQ6/KqA0lOineQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9478



On 6/11/2025 1:56 PM, Uladzislau Rezki (Sony) wrote:
> Automatically enable the rcu_normal_wake_from_gp parameter on
> systems with a small number of CPUs. The activation threshold
> is set to 16 CPUs.
> 
> This helps to reduce a latency of normal synchronize_rcu() API
> by waking up GP-waiters earlier and decoupling synchronize_rcu()
> callers from regular callback handling.
> 
> A benchmark running 64 parallel jobs(system with 64 CPUs) invoking
> synchronize_rcu() demonstrates a notable latency reduction with the
> setting enabled.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Just one nit below:

> 
> Latency distribution (microseconds):
> 
> <default>
>  0      - 9999   : 1
>  10000  - 19999  : 4
>  20000  - 29999  : 399
>  30000  - 39999  : 3197
>  40000  - 49999  : 10428
>  50000  - 59999  : 17363
>  60000  - 69999  : 15529
>  70000  - 79999  : 9287
>  80000  - 89999  : 4249
>  90000  - 99999  : 1915
>  100000 - 109999 : 922
>  110000 - 119999 : 390
>  120000 - 129999 : 187
>  ...
> <default>
> 
> <rcu_normal_wake_from_gp>
>  0      - 9999  : 1
>  10000  - 19999 : 234
>  20000  - 29999 : 6678
>  30000  - 39999 : 33463
>  40000  - 49999 : 20669
>  50000  - 59999 : 2766
>  60000  - 69999 : 183
>  ...
> <rcu_normal_wake_from_gp>
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e8a4b720d7d2..b88ceb35cebd 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1625,8 +1625,10 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
>  	atomic_set_release(&sr_wn->inuse, 0);
>  }
>  
> -/* Disabled by default. */
> -static int rcu_normal_wake_from_gp;
> +/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> +#define WAKE_FROM_GP_CPU_THRESHOLD 16
> +
> +static int rcu_normal_wake_from_gp = -1;
>  module_param(rcu_normal_wake_from_gp, int, 0644);
>  static struct workqueue_struct *sync_wq;
>  
> @@ -3239,7 +3241,7 @@ static void synchronize_rcu_normal(void)
>  
>  	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
>  
> -	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
> +	if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
>  		wait_rcu_gp(call_rcu_hurry);
>  		goto trace_complete_out;
>  	}
> @@ -4843,6 +4845,12 @@ void __init rcu_init(void)
>  	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
>  	WARN_ON(!sync_wq);
>  
> +	/* Respect if explicitly disabled via a boot parameter. */
> +	if (rcu_normal_wake_from_gp < 0) {
> +		if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
> +			rcu_normal_wake_from_gp = 1;
> +	}

nit: better to just do:

	if (rcu_normal_wake_from_gp < 0 &&
	    num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
 		rcu_normal_wake_from_gp = 1;
	}

> +
>  	/* Fill in default value for rcutree.qovld boot parameter. */
>  	/* -After- the rcu_node ->lock fields are initialized! */
>  	if (qovld < 0)

