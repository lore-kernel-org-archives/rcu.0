Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D724E005;
	Wed,  5 Mar 2025 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189067; cv=fail; b=AU+7ChFbg+RnPudS7gyAka8zVRpalfc9SHeUSeEq9ooZYIeovTNprch+pICqCA7BX7ievLzsZIOjIm/6aDlJl4JbceoaBuxh+rvYliAp+qM27P+BHnNAHvwj0xm6JHEVyad8VQeL/Zz+5I48hEsblwbp4GnfVNH1qElJIcNglkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189067; c=relaxed/simple;
	bh=50/9ulM93bQxQooj3nT2sW2hWf5Dwf6xj1aSH5iijYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V5TR6AVxRRIglz6/8SzDxDKlbqPji+e6FpbAiqqjZlXalsX75WSrtpu//V7FbSulatoKufaFLwnr6W4D7x9tKyHluZ8sRroJ3wKiXYp1V3llDTStSfqF3I9oPbXS7NfjylI9RdRlsyN4xwq+tjJU9uN/bUh9NBxM1oZ6I9gHCR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ssoZ8OW6; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ssoZ8OW6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA74czR780RA8iOVX9jxq3Xy6FsHzZlGB/mxicjWAeemitaAcy6/q+42AMh32zTAUbtAEbnQsI49pZMtjeq4Vx2AHNO1moRewYkiLV2z2ztTsCD02oni1x8lGGkbE5T7P5rxlqy5UvLsEniUMx34jbdq2dA3S06U1LOvp42Gyz2VnWVQ2j2FXtWUa6Sg6KH1GNGOMJ3yGbMzLlIgHYaCHjpHwFgVQci16SG76/+zWzhDR9Txn8AhKO+kQ65Bxd9MSFEOX/tTJOg/NxOYeKnn61cCpD/3RTzKz2ou4gmq7TFqkQqRt24GJfdo+mf3O1PtIYTUHyjgSvY9Q2zUdA1Q7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfieN+0q1CMVipfBhV57myq78ibfmMLy4AkyNuj4gXM=;
 b=hLCK1EhAlHB8j4cZSRA95cJ9Oa12ap323LjaqQO0NoQSOywtkNW7G9BUFJCQmBUdXQkVtcVLLx6eS+J2bBSSF7fDLvZaRwkaRPLu9ajVLc2w6ZFeJU/LrqMd1fQ3JvBs2aszgUFJsrSr1uQgZHnKBEfsEsBvYQsErVaE482lzJqkC16tzHwY/ZZl+8bORl/UVcKQYyO7Xoxz0FTKZSLEjORJgggH6M882ceVYitMaqi28EqgSklfCVmqat8B2v8BSy/WlKLFGoJTseGuBjjzEWb/Kh1VrmzH/1Fpx0W3sh5gwsyYNDyJLHdLjYzdh06n+uNi4f7Iit7V5ZHxW5lY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfieN+0q1CMVipfBhV57myq78ibfmMLy4AkyNuj4gXM=;
 b=ssoZ8OW681GzYIN0YqRVsrlYXhQo1pbEQcai+BB+fGTxOYgSj8aTWdLGDOWMIn7qFn6JLclfVXtwPD7Y5OwICYOeB4VGVLJGCYk1Bh9vRLBMhjK97mTDX83l6ulEtD5HFwnLdOUJsN7ciEEw9ebinX6+JYW9FTNYgACwJ7Uiz/d3JipVQVNSiaFmEV1e+ljSTM/yf095E60tgruQ45NayTrxOk8ltKUNQsSyqsU+Y+uAOs5smei2yHmDdNhwTe0R5fKWUSR4iR7ei3PhGQzG+MlSpclnQip7drZrmHwx/nODNzf0iNU63kISi6P24SP97JyTMThzRtZ6bp9MQT6OoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 15:37:41 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 15:37:40 +0000
Message-ID: <ac5d37e5-c209-465b-8f2c-b09a2ff6fb07@nvidia.com>
Date: Wed, 5 Mar 2025 10:37:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
To: Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Cheung Wall <zzqq0103.hey@gmail.com>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <20250303001507.GA3994772@joelnvbox> <Z8ZyMaUhXMIxX7WE@tardis>
 <Z8bbary51FZ2TsUA@pc636> <Z8bcUsZ9IpRi1QoP@pc636>
 <qlqvu355hs2vbj4tkfercqfpdynd7ezjg4uhg22hd6223yqh7w@4zp6haxokdpc>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <qlqvu355hs2vbj4tkfercqfpdynd7ezjg4uhg22hd6223yqh7w@4zp6haxokdpc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:208:236::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b90dedd-782d-4c99-ce39-08dd5bfbaa0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnVxb2xMdjM5ZXlDdUVPd2taQVJITzlnaTlCUjJYbU9ZQjZ6MlBMNnpQYkMw?=
 =?utf-8?B?Y2s1SkZuRm0yaUdjNlAvY3NoWGViVVErbVZ2a0E5Y211ZE5XL3cxNS8vRGpt?=
 =?utf-8?B?UytKWGs5RUVhQk4wVjBwd2F6QjJzeHpuMTY4eVFoYUFyaGtHeWgxaTdEOE83?=
 =?utf-8?B?bm1Tc29yUVhiRkRzc1dneEFBRjVxbEJ2Uzc3UVdHWTVJZ1pWa1RZNkdNUWF6?=
 =?utf-8?B?TzNVdkdoUHVoQmtIQ3gzbTFiMkx0a2xoRlZ5SnZQVmg2UmJtVVM2aUcvWjBZ?=
 =?utf-8?B?R1VHdkZVZ1FvaDlUWGh1aFhwcUR4M2FNQzVwQmlKZERTVEhNdTJNdHFKdmUw?=
 =?utf-8?B?K0pib3lLSlBZUmc2UCtnUXFaWmkramFBaVhyUEt6SWU5UlZkZjk2Z1B0TUNn?=
 =?utf-8?B?UW0zNTREY2lpaC9jRzdjYTZEb0lqNGwvUXBKYUg2bUFpbmhGV2oyT3ljOVBs?=
 =?utf-8?B?VXg3WXExRFVET2FGRmZHc1p0K3VwOTM2VlZxeGVnSXJ6VW1MNU5rcWxzU2tN?=
 =?utf-8?B?TXorc3ZsbExIVHpIc1Z2c0pSMCtCcHN6Ky9zVXdLM2QzSGRpalJUTWJJMEVw?=
 =?utf-8?B?c0tZZUJWZmNMNWdvellsc1Uwd3Ayc1Y4QjViQmtRUGRLWFlsZlcrdVVxbWxa?=
 =?utf-8?B?aUh4NHBaSG1GR0tLQm04clRBdVN4NVVWSjRKR1piaDlIMm5qRVNnVVppZVNJ?=
 =?utf-8?B?ZWZCc1UxbC9BeHpYTDJ4STgxREtmUWFQdzZrWWpsSU5jMVdnWmZ4QTNkeEph?=
 =?utf-8?B?MHFMeVRzL0JPcHFMVWhPNHgrYlNqMkNmNVVyampyODJYS3hpdmJOSzhyWkpU?=
 =?utf-8?B?WTFlSFowbVhsbExoUFZTWnppa1U5NkV3aVltUWo3M1RRRTY1cWVCODZBM0dx?=
 =?utf-8?B?c3ZrTUtDUTliNEtxYTZFYlNKbVNZcjVXNjh2Vk9RNmZQbXlzL2ZSOHRBc3VC?=
 =?utf-8?B?NUs4UldSUVA0dkt5b2ZWNlg0SC9ObUlrWnAwRUdhUjFOamV1dldJcFc4TENG?=
 =?utf-8?B?U1NybyszZkpUZTRYMFBjSUdyOFozMDU3S3JGb05FUE92dXMvOGhLUmJ4UGFC?=
 =?utf-8?B?N2RCZnV6WXJYVWxGNkdSMC9VeVlXS3RKMGRHWTFWRExobXIzNysvMDFoTmRo?=
 =?utf-8?B?M2xPd2ZXR2tseHJkdGlxai8wV1g5WC9iWXN1cEg1dUtvUFhPYmlpQllIOXQ3?=
 =?utf-8?B?bGlRNFpxVDBrM04rcVkxaFVYelJzZE1pZ2FZaEtHT3lWT2szR1p2clJ1Tko5?=
 =?utf-8?B?aWpXQnMxbzBYRkh6amRaaG1ocFJtUzJQTHlDTTYwR2NBbWxpbzJKSVdKcFNs?=
 =?utf-8?B?RzFqcWc1VWhtYUM2MFpUWW5CRWpMdTlpTnBiUHF0M2NVcW9WM0E5ME5sVGtP?=
 =?utf-8?B?TjkyZmRnNVJaOHBLQmtYWm5RZkFJRmFxUnpROTBCZmtHZmd0ZFM3VHA2RTkw?=
 =?utf-8?B?cCs2SGVVQ1lyNmZwZ0FhWHA3L3RuR1Yzc1d6eFhpMXVmcUE3TXdxQ0J2NGJa?=
 =?utf-8?B?R3cvZVlTa3crMzF4VDdub0pMZ2NCVThPVVpnWUNEZUU3ZUMraWk0dzdYSEw1?=
 =?utf-8?B?RmhSd2pUaEpkWndhT1FLbDJ5NzYxZjVUeWNTZFNqQmJkTVl3RWg3NXdpQU1Y?=
 =?utf-8?B?bXJtemNmaDdhMC95eEJBWFNleEZqMyszUWw3cHJZN3lyQlA4QWpqUDlSUTBF?=
 =?utf-8?B?elRiYkdUMFNQL2l3OGFmUGFHZWs3Z1cxU2xoM0NIZzA5UlF6U0ZjYzVvWXVs?=
 =?utf-8?B?VUNMaWZMekY3SktLaTRNdGNycE1GU1IwTmVMa3U5OFFkcWVOV0RvVHg3bGw3?=
 =?utf-8?B?dFpuSzZzeXBCVmxhZ2ROZWdpeCtVVi9EZ25sRDBXZ3Y2OG9zTG9LUmJqeVlI?=
 =?utf-8?Q?EhovMedYSzXSF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzU3QnVrM3VhVHByUlY0NWJoY0p2NmRySDZXRjBma2I3ZTRaOFlyckZFNHV0?=
 =?utf-8?B?TSt5NGdQR3VUT0hlNnRFaVBEVlBBY0UzdUROYzllakdGQ2Q4UUYzemhNNHhN?=
 =?utf-8?B?VTd0a2RxZitiSTg2Yi9qOUdKdU5HUVpOZFVCaDJiMkFCcE1jNmRyNkxobWti?=
 =?utf-8?B?eWJzaExESkEwaHFsQXFXejc4bFl0M3E5M3BmcG1qRklFQjNUWW5ITFdvaWZM?=
 =?utf-8?B?K1ZWQlo1K2xxVXVkUHJLVEVickZLM0EyTzdoZWlub0tPMTFNV0lnUDVvclNM?=
 =?utf-8?B?aTN0N0xZckROdWI3SDZ6bWs4b2FRR011ZWI5Y2N1cVhOWXBJN3BzNWplSytJ?=
 =?utf-8?B?MjNsVk0rNGJ5RVR4dlhrTFZjL3hGbFArQmlOeTNsclhWdmptWHVkV09pZUpG?=
 =?utf-8?B?L09QM056d3FROXdLSlZtOUx1cGZ3dnBOT0d1a29JcG5RL2VxNXh4U2xzZWt0?=
 =?utf-8?B?UThjSkFJSTdvcDR6Z3h1OHpKdGxnZlNubHRLOG90eGIwL2ZQMVlqNFkrWDRH?=
 =?utf-8?B?c24vNFdQNGh5dnF2Q24yL1dhWUV0d1pWMVZJN055MlRIUG1Tc1ZlK0ZkUVBp?=
 =?utf-8?B?U203UWpzYkNlTlhIL3pUSmdZVGkwWDhPYWV6UXE1ak0yc1kyUVpkQnJCRXoz?=
 =?utf-8?B?MFZjT1FzMVVTTlVRRUgzSm11LzFZZ1JsdStIMWRoZCttbk9iZlhEaTJ0elow?=
 =?utf-8?B?eFB1V3hwY1BSMlpMU1k3TDJYQmhpdGg5MWpkTEJkYVgzWFM1d29OUHFxa3Fw?=
 =?utf-8?B?MmdPNkovZFdNNXJGQ0FuYnI4Z3I1aFYyTGNVWSswZlZuMHZZa2J5TU9YQU00?=
 =?utf-8?B?cUR0SFpWVjlBMy9OWnBwUHhkMDBYSHV3bVFrNyszSzRjQ0hyNWwxQzFLRkll?=
 =?utf-8?B?VW44bndwTVVnUmJBVVV3cGg5UERWR1BpMEZkcGRCd2dUb3VaYW4ybUZ2aXVp?=
 =?utf-8?B?dGQxb2VaMmRuN0JPc1oySG54OGMwL2VWUlFtWlBXd0h6T2ZrdTFtMTB4NVR3?=
 =?utf-8?B?UVBUNXVnRGs2eSs0eElUYWVuM3ZORVQyNDFvdjJjUzlDNzVjUEE2NkozeStk?=
 =?utf-8?B?YkdmZ0pPZHphN2N1djM1VCtPZXNzdmhFK21Ra1FzQTdTZkUyb1ExSVFkYmRU?=
 =?utf-8?B?WUdKMWpPMDV6LzlGSVY4QlhpNGlHMlBHUlpaMUVEbk5ROG9ZSXhKRzIwZVV2?=
 =?utf-8?B?cjA3SDFwQzlQTkRIZFJ0Z0ViYnh2NkFjL2ZvK1BONjJSTjJobXNxRXVEY2k5?=
 =?utf-8?B?SDEvWWpyWkM5RW1OUlBwYTFudWY4d0RtWHVzZDhkYXNScXBEdmdzM1RVU2Vt?=
 =?utf-8?B?WlpQaXEvVWRJYk5EckhWbUhlUTUzbXNYSG1TMGxoUlhROUdLenkyWmtXMHpB?=
 =?utf-8?B?YmliZnB4dmRHbE1aTmdyREUvRkFoc21lQXh2ZlNwbDNwT0NJZjZXd2JlY3By?=
 =?utf-8?B?NkVKeXNDTE5wSjZZbGFPQWlTVHVJREZTWlFCdytFa0lKZDROSVBzMm9IaWFX?=
 =?utf-8?B?VFVjL05sOEhvVzlhVDJpRy82NnhGeHFpc2tvdGs5eTN5U1lYdFBYL2F2TExZ?=
 =?utf-8?B?TlpmSUtYRkI3dWxHNnBLS0dwL2ZRYXh3cXNHeUxZN04rV2FHT3AvTm0vMXNz?=
 =?utf-8?B?MHppMHlTQytOdlN1MzRaTGtGMUc2QmRad2l1S1J6WXFSZkdJVFlGLzJLa2RT?=
 =?utf-8?B?eFRBK3VEOERwc1BWOC9DM0JrczU4V0QwMVhPeHNpRFhtMk1TdEMwZm1KdDRt?=
 =?utf-8?B?d1E2ZEJBTnppVURkK0FmT0N0ajlVWDdnWW15alluUEl5VFkxWVExQkY0VzNN?=
 =?utf-8?B?OEhLU1lWdzJsaE9KRjBuSGhOaUI1Yk8zWnppUHprcTBFdVYvR2phS0R0eWpk?=
 =?utf-8?B?WVRsVVVWZVFuclJZamhVVTdSbTVKaUJ0Y0JLVWpjOTNzZHVOY3hMVGM4WWNO?=
 =?utf-8?B?R280bE1hMVd2RGl1R3luQ2ZsZ1QyM0dBNVo2Y0p5K3liV0xPbVYra2RZSnE1?=
 =?utf-8?B?WkxyZHp1cnROa1BBSU9PWEdPeHhWalVJSkZBL3hTbjkyd3EzYi9sREVpeEJa?=
 =?utf-8?B?cmpJeTdSTHB0K04xUFBTWm1Dc2lIbWRjNk1BK2pNZ2dxZytrcWQxcjBPMUZL?=
 =?utf-8?Q?/OPd6Z+b6Z9hNLjyPRFvzNh4o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b90dedd-782d-4c99-ce39-08dd5bfbaa0e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 15:37:40.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+Pl4epxipd4BJxY5th6uC6wM2+77Y9Z9H+zn4cpLKjCRPggaQk5dujATCedGdC2aos64BMHXtmHx9t1Nx4JwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618



On 3/4/2025 9:54 PM, Boqun Feng wrote:
> On Tue, Mar 04, 2025 at 11:56:18AM +0100, Uladzislau Rezki wrote:
>> On Tue, Mar 04, 2025 at 11:52:26AM +0100, Uladzislau Rezki wrote:
>>>>> Did I get that right?
>>>>>
>>>>
>>>> Other than I'm unable to follow what do you mean "WH has not been
>>>> injected, so nothing to wait on", maybe because I am missing some
>>>> terminology from you ;-) I think it's a good analysis, thank you!
>>>>
>>>>> I think this is a real bug AFAICS, hoping all the memory barriers are in
>>>>> place to make sure the code reordering also correctly orders the accesses.
>>>>> I'll double check that.
>>>>>
>>>>> I also feel its 'theoretical', because as long as rcu_gp_init() and
>>>>> rcu_gp_cleanup() are properly ordered WRT pre-existing readers, then
>>>>> synchronize_rcu_normal() still waits for pre-existing readers even though its
>>>>> a bit confused about the value of the cookies.
>>>>>
>>>>> For the fix,
>>>>> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>
>>>>> (If possible, include a Link: to my (this) post so that the sequence of
>>>>> events is further clarified.)
>>>>>
>>>>
>>>> Will add the tag (with the email you really want ;-)) and a link to this
>>>> email to the patch. Thanks!
>>>>
>>>
>>> CPU_1:                                | CPU_2:
>>>   # Increase a seq-number             |
>>>   rcu_seq_start(&rcu_state.gp_seq);   |
>>>                                       | add_client() {
>>> 				      |   # Record a gp-sec state 
>>> 				      |   get_state_synchronize_rcu_full(&rs.oldstate);
>>>                                       | }
>>>                                       |
>>>                                       | rcu_sr_normal_gp_init() {
>>> 				      |   add a dummy-wait-head;
>>> 				      | }
>>>
>>>
>>> A client has been added with already updated gp-sec number, i.e.
>>> "oldstate" would refer to this GP, not to previous. A poll_state_synchronize_rcu_full()
>>> will complain because this GP is not passed, it will on a next iteration.
>>>
>>> This is how i see this.
>>>
>> Updated the plain-text, removed tabs:
>>
>> CPU_1:                                 | CPU_2:
>>    # Increase a seq-number             |
>>    rcu_seq_start(&rcu_state.gp_seq);   |
>>                                        | add_client() {
>>                                        |   # Record a gp-sec state 
>>                                        |   get_state_synchronize_rcu_full(&rs.oldstate);
>>                                        | }
>>                                        |
>>                                        | rcu_sr_normal_gp_init() {
>>                                        |   add a dummy-wait-head;
>>                                        | }
>>
> 
> Thank you. I added links from you and Joel as the detailed explanation
> to the commit log, and the comment I proposed[1].
> 
> [1]: https://lore.kernel.org/rcu/Z8SnhS_LnzN_wvxr@tardis/
> 

Yep, I am in line with Vlad's explanation as well, and add links to both
explanations sounds perfect, thanks!


 - Joel



