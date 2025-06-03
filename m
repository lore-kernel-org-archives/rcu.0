Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F6197A6C;
	Tue,  3 Jun 2025 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977186; cv=fail; b=LeMwSnK/j3dk76weGY87tt+v3ke1SzFGSXUlJUgRF5bI6RA72iqpCCFhi5anac8xeuI0knR7wJeEfYQ3QNaJMzN868iXK0SWSxu7l0WtjoBAUPR2L3lBVB0WRHB1YZpSBJhfEL2GoOIW5JfyS+jgmOIoAzReNy/Eqt8eNtRfWFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977186; c=relaxed/simple;
	bh=Bw103j5V/qNchvvIawYHz/MuNxGmtOjyHRaydKKpAkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZZC17yBHfNJC2PV7gJuAc6Xhe6WyMILYg1sr7cawrXP4CeV2pSTynE1y93O19XVlP7jT9mU8XPilF2KAhYLFECGFap6OCDY4G2buuGwY9SviDVWnmcBsd4q/INDTGrgX5ZJaPZP3peZyUv8Ng/ajsEfMZMF7uLnrTErw6OO729w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Liudc2Hd; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Liudc2Hd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q34i9zgw2z/JE0HtPbf/dy1qYLfAoUXlnFbmnXE/UA73qT/lx8l80Qb5LNSWOWMz79RxGH+H50SoyFm2AcUUcN7VSLQcayLsM7Ud6duVyCM0TIKYV+hu8Ss93DysLRqSvmlC/nqDr7vf39hC+33ytFploT7Pn4fKxljoQPZrPmzCk6BKf9gZImsWJgNQc9F7ASlLf1m07li1XP2G6i5YtXK3zMo2nVmRU9NBbHGfU8Mc2mQrlO2epeNYHSVW4ZCn2ILI6Ii7Mv9cJJqVwm7iO3QYA0JA6EIjv4cxW+XY9XqOtmUzd/svJZcXh3aIP7T/3HF9KUPYudLiBTeLWke6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FmcAv2rDZsQMdjuXhUuUgLEow/GjU0k9BmoKNuifzE=;
 b=zR21IDkOSzpg4XncZWpaQy4Zl0J4301/imTe/iBSjRZTS4HI58h8pW3VgnyA3OhsGAI6WqCunkrMhPLEZeFa82QTaJ9BD0kkSzmywkFuZmjDQZD6YT+OCzUajMdlPZdFRjgn/6v6WYw+4e12C7YKqVfAw5429w5ZqqTgQvkk4OAvvw6iCuBI2NV+qFAT7EETWz5FtSP+AWl3TFBP07WHN4Hp1LFR2mLODuH2L3Fq1z1/VzdO1KZmRBf4n2qQuo2ipXxPSMLJdLsNzsyf5DzE4dv85eGtD76bEJh8UC5MWf8vwL8bxfqWx75U8WOhvgMtZIzQeEm06jUreM3b2L64eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FmcAv2rDZsQMdjuXhUuUgLEow/GjU0k9BmoKNuifzE=;
 b=Liudc2Hd/m5OovzICFNypTjzsMgi5gRcHCfzcKpD7AGWe7AM+gf+nrcyLffHzOK5mN2bZpND+ukjpWkTTGIHgJ+0/7DhvEZYMd6DVg3J8sMav/2IY/rCla53ui830FX7AVVPmRCb2IPb+9zIArvwBraEjUD9S5/nlYpigkFT/NHVGtGC63Qb4vIlih1LfeIzZIyVMXz/VGWIw9MOpe1hCTZexasl9uP30hxUo4WP1unDNoBPLoiIWYZS0w23q9qt9R5gJrIDUkk4JSWu+Wv4gg8+TJKM0dFD80bYrT0tE4sJPg+bVqkdufTxVxflFt7ZcESJ+ej4Bo4y89gFOTUqJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 18:59:41 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8769.025; Tue, 3 Jun 2025
 18:59:41 +0000
Date: Tue, 3 Jun 2025 14:59:39 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, ankur.a.arora@oracle.com,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, neeraj.upadhyay@kernel.org,
	urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	xiqi2@huawei.com, "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
Message-ID: <20250603185939.GA1109523@joelnvbox>
References: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
 <CAEXW_YRC=f6i3KOd_uhuH=xAOCG7mW7-LwtA4+_fc8FMjfRHeg@mail.gmail.com>
 <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
X-ClientProxiedBy: BN9P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::11) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ee8cbd-9405-4cea-a286-08dda2d0cbc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUxmWWhjNzFSUkdOckVwZU5iWFNtYnVEZWVzYkZPQmczOWRSeEVLQjlxYjhG?=
 =?utf-8?B?TzgyWU40Y01HS2FtOUNEVGY2cFY2VVkxWXJDOG8zZHNZS2RuUjByWnVONXdl?=
 =?utf-8?B?aVpobDJRaGZCaXdnV01KZTBGN01aenh5cWs2M2RTUVpqWG9tbGdYZUVwQ1Zr?=
 =?utf-8?B?dWVkelFjQXBubTFCNkNJazlrRDJDTTZiUGV6ZXprVGFkYlRQUHpWOWNUa0tr?=
 =?utf-8?B?WFlvclpXUzU5UDJnbzBJYnFMQkdzOXk2d0IrYW9YRk1DQlNVTXI2ZGJMQVJM?=
 =?utf-8?B?em0zbkxZTExHSytSTHoyTjFUVjl2T2NwdmgvelVkb1BDUGFHVVo2QzlCTTc4?=
 =?utf-8?B?YW1yMDYrUFc0YlloTmo0WGRlekp6NnVhK2dZeHFEbWJrZ29oaCs1dzRIVFVG?=
 =?utf-8?B?Y3JzbVJDTE5VUkExakpIcDVOYXVNMnJGeTAwZ0VxaHA1OTJ0NzIyM0ZQUEFF?=
 =?utf-8?B?a1ZoNHNoVVBaRW9Rc29HUHFlN2tOMlp4a2gxNndnVGkxN0F5OFU1c25nUzZV?=
 =?utf-8?B?cm9URytGYkpTSm5PK1BvWTZGV1pETVA5b3IvQ1B5YnYrZVVCY0pISVVzcFVY?=
 =?utf-8?B?YW5OM0xzTDRMSlR5bU5ybFpiU2h0bU5TcUJCTUdXT0N0bExiSnpGelRWTnFp?=
 =?utf-8?B?YlkwZVVyUHRDdDkzMlRtNWgyS0FTaU9PbkV3c3RVTFJMelVYdGJ2Zmk0M1Rw?=
 =?utf-8?B?T25nSnRhVm9mRWJLU0JWbmFPTS9UdkpXVEF5RjFzbWhTSWFnQ2F2QTVHS0ZO?=
 =?utf-8?B?Y3E3RVYyazVVZURWcFJkVHJYN2ZrYzQ4V2p6YndBYk1ySGt4SEl4NlNNU0tT?=
 =?utf-8?B?WlEvU0IrYnZuaUt6K3pmT3lxK1Ixb29QVFN6eXJ5d1Z1VzY0NFdsVEppQTdB?=
 =?utf-8?B?eEZnSDVOMlJUaFptVmdoYzdEcUY0Q2tXWW4vbHFoMkRwRHYrZjc3Y08wNVBo?=
 =?utf-8?B?WTV4dXNXWE5DaUcxdjdkdGhUdEs3OUtobXFGcXZPZGFYVFdoN0c3S3Z2WkVp?=
 =?utf-8?B?NnNpRzY5Q1I2MjlMVU8zdDNQUENDdE1BbElweGwzSlBNbjdKQjIzZnJLZTgz?=
 =?utf-8?B?ZTUybTQzeWd6M1dyWDhKNnplWTBGZ2Izb0o4aVVlNk1hcitpQkJYWVlydUhY?=
 =?utf-8?B?bmFQaERaUHZIWkxZNWpvMlZiSVcwWS9iWHhYaG1PTTRzMVhvSVhEbEpMKzVQ?=
 =?utf-8?B?L25XMUlQVmh1ZmZ1V0hZUUs0V1VSOGZwbFcwcGxYdnEzNnpuYUphMVlGQ0dw?=
 =?utf-8?B?UkFOL3o1OVBOWWZlamMvUTAzN1M2ZjFUUCttMyt6VU9VZ0pIQW1MVW5LVjcz?=
 =?utf-8?B?K3lKelNsdzlIWW16MVRlVjhHMk9JNE4rWUhFTFlBdUl2eHJOZEpkYTZabGpR?=
 =?utf-8?B?eVVQMS9ZZ1liTWxSRm55OHdyL1h1dTByQk1aLzYvM3hJSTdkSjBKSWI5OG5x?=
 =?utf-8?B?b1p5S3phK2xkRVlab0ZOYnk2ZkxaM2RSTWZKZ1E1MExac1I5M25LSGlRcU4z?=
 =?utf-8?B?S3ZkVlYxblRaa2s2Q09vTTVveWIxZThoV3crTmszdktzeVRYMC90aDRtT21B?=
 =?utf-8?B?czNaaU56U1ZGZU1WY3Q3ZWxuMkpnUDhGVUhSTHVtbEJtVDIyZjhlN2gwdXo2?=
 =?utf-8?B?cGtIQ0dESmlQclVJRGs3MzlvWTlZZkZ4L3dDVzhkMlU4Rm1wOEE5RUZLYU4r?=
 =?utf-8?B?WHJrSWU3YURSTUdpKzFsWG9ueTNLSW90WmNkYnRadC96M0xIM3JBNVNITFE5?=
 =?utf-8?B?SkozWmZrUkNobE0zMzl6Wlc5cERWTnkrQWRyRnRnb0Mrdkk3UHJOeEtWQ0xY?=
 =?utf-8?B?cFRpbUs3UmZJNlkrWjNJNU5WTDRZMitJVFpNSExXQkN1dFl6dU5iN2pmbGx1?=
 =?utf-8?B?cEtrL2V0bGp6OTQzY0dqSXJ4WGJhNk1rT0VVc2lSVHBWZEpEMjB1ZjdGZTBn?=
 =?utf-8?Q?gIAmitXBPsI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1cyVElLYnU3aGZjK3Vnc01Yc1J6VkJDbWtOQVNMODNCWWJOSGdvbERLR2pP?=
 =?utf-8?B?ODVBWWNRa3FWOVd0YzFCbG5rUFVvNnk4cWw1YzBMWkdLamxBL3o4QXVobWda?=
 =?utf-8?B?S2JtbStZNjVzc2V2V2lEYlVuVDZ4OEt2d2dyeXQ1K3RKYUFqbDJZVmdZT0wv?=
 =?utf-8?B?T04vRVhTL1luUE0yQmsxb2tBcVY3V3dWZGdMMCtrdzd1cGpucUMxZ1NNSWNX?=
 =?utf-8?B?RG1IWDNDZytJZExQN1ZMckowL0ZvNTdFNWpGMVlsdmNNeWNOZnU5OE4rOUhE?=
 =?utf-8?B?NmNoUFlqak9IakJCN2hXeHp2R1hVcm5UVVgvbmJCMlZraVYrUHRXd3N5VzVI?=
 =?utf-8?B?T21iWEZYOXFvakZzVEFyaTA5OE4yaDNxNEhNMVAxcXlOUXM1dUEzWklxTFd6?=
 =?utf-8?B?WmxiakZDeVorQnBucVF6MjBocUJodGp4djRwZHJuaUZKandESVNOdkZYTXZ6?=
 =?utf-8?B?RXpxVjdLRGNVck40RUR2TGw0akhzUktnekYzN0V4dlZEcU9CWEZ2SFo5TGRk?=
 =?utf-8?B?VktJbFNaaWVKT3ZaaGI5REpKVUVubEhVbHN2M2ZiUkRFZ3ZVY0k1ODNNS01L?=
 =?utf-8?B?VUZtUVZhNFJuNk0yK1IxSDRGYmUvV3hMU2NENnpXeVY5KzZLcExURFd3REVY?=
 =?utf-8?B?cTVxVjcyTkcxY2pWckRaS1J6NmlhUFB1b0V0VXhnSW5ianhBMHJsQVRoSllM?=
 =?utf-8?B?Q2kyQjRrMVJ1YkEwYnMyNTd5d05vYXFBUEJzeVBpRXlIWmVhNktYa3NicndN?=
 =?utf-8?B?SWtLUHJES0hKZ293K0ZHLzVWVmtvSkdubnFFTTFmQ1dDT3dpZ1RxN0hRRHU1?=
 =?utf-8?B?enU5WkhnWkVEdTMxVTBvdytWOEpzRVQvcVYwd3hkQXlseEx5V085VG5oQXZE?=
 =?utf-8?B?SXg2Nk9zZDM2SFVqYlZjVmRrdnN2bUpncm9jZVVCNGsxenBiblFJTm1ZRG1o?=
 =?utf-8?B?UE1yZXc2ZDBpVFRQejZaK1RPdzljbmR4bVVpRkdMQjlCWFFOcW1BcjVPME1y?=
 =?utf-8?B?WkpQSmtNd1JSVDNGaVF1RUpyQUtDQm0yY28rTFg2LzdBUW1OczJvUXp6bkt5?=
 =?utf-8?B?UDlFb3Q2b0xuazNLZFRpWnQyL3cyZmkzUW9WM3ZvT3lEWmRDNVZCZk53dXAr?=
 =?utf-8?B?S3RpR1RQWnlLVWJrZ1hYUjlwNlRoUUZUVEJuQlpBUFRwVVJ5U1JFYS9TWSt0?=
 =?utf-8?B?SXpsZW9YSXNvWVM5MjFuMXhZdnY1ekFBV0IzVmdTODVoelBnQVhabUQ3dDRT?=
 =?utf-8?B?RzY5NVZlNFpOQmF1b2hiVk9OYTBKMGpHMmtoRVpnVlhzaGhIeWIvQ3REUEtV?=
 =?utf-8?B?cHhzam0vT2RrL0g0UktQWi82cU02TE9ja1NWakJTRit6U2tQU0Vpc21kN2h0?=
 =?utf-8?B?Z292Y1ZOWjZvZW8rSm9UeG5jc1BYTXFGam1JODFJM2Z5N3c2a1pEZE42a3o2?=
 =?utf-8?B?UWFnZkR4dlBBK2creHFJNHpYQjNZcHRxTS9HV1NoWXhOdk1JUmx3YytWQW0x?=
 =?utf-8?B?MkZFaTQzR1hPSUdBek9HNXQ2RzlIajVTR1lxand0RjFPdHRudS9VSXduZU5Y?=
 =?utf-8?B?dUc4RGVXQmF1a3VOR2hvRHJPYWJ5TW5Ra1JITVpseDJ4SFlWZ3hhd3BrTUdJ?=
 =?utf-8?B?YlZxVTBrTjRkSjdxUmFvUXEvNkJTMzF0YlA5TFZaQVZxcmJGQzhjSnlXV3ll?=
 =?utf-8?B?alFPR2RMS0JhSitQVVBwcGdyODR6TTlTV0d3VytjeFVxRFk5bG9PeGk1N3VQ?=
 =?utf-8?B?bnV2Z2pMb3ZMdFFRTDlDdnhoNXY4YjMzenRDVDhVKzdWT3hFUTRiV2xQd0dC?=
 =?utf-8?B?Z2U0RDcyVDZhNWFhdEhvSFNUelBNYVdrUXF2aVNscjVjRXE0L2RZYkpVRTNZ?=
 =?utf-8?B?Mm5DblZNR05qUW1ERXRmeVVJd0ZiOXlvelhTOGhJTWE1L25GN2NhbFRONkRj?=
 =?utf-8?B?S3FwdjdTWWtnVm5Hb3FLbnFXWGR1bFJKeEtia3R4ZXlPVzNDQlBGV0l4QzlR?=
 =?utf-8?B?N2pocjluRUpENzRsNDJSeTdray9GLys5RXhyNGNzSkE2b3UxcXlqWXhZUHZD?=
 =?utf-8?B?OXZOT3FSL2FhZ1pvRUpXTnAvYTJYMXVSVVRRZjhPWENkd2NTN3p4MUlXQXBK?=
 =?utf-8?Q?e/ZnOzYqVAcbaIzn6pLnqtzS8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ee8cbd-9405-4cea-a286-08dda2d0cbc2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 18:59:41.4048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM1tL56dlvnQsTJL24V8rH4a/4hQO+y2MJUBm4fjtCXYpstUrhCWyN/XQM3COPcJz45zhtl9guy7Yyy2vpAshg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

On Fri, May 30, 2025 at 09:55:45AM +0800, Xiongfeng Wang wrote:
> Hi Joel,
> 
> On 2025/5/29 0:30, Joel Fernandes wrote:
> > On Wed, May 21, 2025 at 5:43 AM Xiongfeng Wang
> > <wangxiongfeng2@huawei.com> wrote:
> >>
> >> Hi RCU experts,
> >>
> >> When I ran syskaller in Linux 6.6 with CONFIG_PREEMPT_RCU enabled, I got
> >> the following soft lockup. The Calltrace is too long. I put it in the end.
> >> The issue can also be reproduced in the latest kernel.
> >>
> >> The issue is as follows. CPU3 is waiting for a spin_lock, which is got by CPU1.
> >> But CPU1 stuck in the following dead loop.
> >>
> >> irq_exit()
> >>   __irq_exit_rcu()
> >>     /* in_hardirq() returns false after this */
> >>     preempt_count_sub(HARDIRQ_OFFSET)
> >>     tick_irq_exit()
> >>       tick_nohz_irq_exit()
> >>             tick_nohz_stop_sched_tick()
> >>               trace_tick_stop()  /* a bpf prog is hooked on this trace point */
> >>                    __bpf_trace_tick_stop()
> >>                       bpf_trace_run2()
> >>                             rcu_read_unlock_special()
> >>                               /* will send a IPI to itself */
> >>                               irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> >>
> >> /* after interrupt is enabled again, the irq_work is called */
> >> asm_sysvec_irq_work()
> >>   sysvec_irq_work()
> >> irq_exit() /* after handled the irq_work, we again enter into irq_exit() */
> >>   __irq_exit_rcu()
> >>     ...skip...
> >>            /* we queue a irq_work again, and enter a dead loop */
> >>            irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> > 
> > This seems legitimate, Boqun and I were just talking about it. He may
> > share more thoughts but here are a few:
> > 
> > Maybe we can delay subsequent clearing of the flag in
> > rcu_preempt_deferred_qs_handler() using a timer and an exponential
> > back-off? That way we are not sending too many self-IPIs.
> > 
> > And reset the process at the end of a grace period.
> > 
> > Or just don't send subsequent self-IPIs if we just sent one for the
> > rdp. Chances are, if we did not get the scheduler's attention during
> > the first one, we may not in subsequent ones I think. Plus we do send
> > other IPIs already if the grace period was over extended (from the FQS
> > loop), maybe we can tweak that?
> 
> Thanks a lot for your reply. I think it's hard for me to fix this issue as
> above without introducing new bugs. I barely understand the RCU code. But I'm
> very glad to help test if you have any code modifiction need to. I have
> the VM and the syskaller benchmark which can reproduce the problem.

Sure, I understand. This is already incredibly valuable so thank you again.
Will request for your testing help soon. I also have a test module now which
can sort-off reproduce this. Keep you posted!

thanks,

 - Joel

