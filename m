Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A412853ED;
	Thu, 10 Apr 2025 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292939; cv=fail; b=VF7Rj6SUnYsZH406S0huMTBfP51YQTTG3rG93zHO6ac1CdyoHWXLYKttsyMnMbu7krrSN8qv3PnvXXvUb3unOlXuPkOkom42OW729LQY1ceFIY6xP9x0PUzDS4uPwnGr8pXco8Y+wGGCdZCgLYffnG+UOUug89ndmznYaFTphUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292939; c=relaxed/simple;
	bh=RO+xIZnx+zqKTHbkyZH1QgkeqcUir7JF7XKDhDB1Ii4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CzWYuI22HRd7U827g5pYctXRcXNCwAb35WkuSFVOC36Q3TgqF3/guVd8zQkhR+iFlFlnyjlB75IPzglWPVpTadPHNLSDB2kMMHqa2MiXqhj4D327armJphBY9qE9LkIuR5FjjE2ax95suuycjZuUwak9svJxSKdxTjTnPoD1I2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ETkm9d9O; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ETkm9d9O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6pLDQt02yoV1QTF+ofF8eHI9bfmQqzYmyttOBwRAaKEZyIxRILS5WQqbVlcqrkcHAW/XSzZMQWr757lnFKxHCVIOeTdpyrCBM3y2whUJ2ZLrYngDi7mfr4KgTxh9jXAGu4g/uX8CgJqINcdYx0dojPwu9N98SAHrFk+HOsDhmSGstcV1VIZSLvdpLZF+5BX4dWhb9tHB3/rLbby6P9UMK2SouH4M2h22Oim70hYnR3DGlXulJPe1x4TP2C1vpbsH6a3cnPRjvO7dUAC1p6KtZGUUDu6xkFeQzD445B3F5HWot9VcB4JuDw3Dcy+VhE7lMQPM+23uupZpNDgVPgOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEbkpVdUFnvETZZMu4Mfi13kGM0ak9a6fU315xM5Zpk=;
 b=OA+6zGt3t+3NI4RmC1Z2OYwY/O9mviht6zWY+DWB9leGCMYGjOI8NiyZ1JsqfPR6ofpMQaMBfh1SHpb5SlkiJ447yLDyo150JpVur6uJ/p1LOtwRQrvMODnV1s5oqDXetawY+JBE3l/+1cgwOtlr1OsX7XbXvqxRE8LGr3ingukk4UDhJ4l0c61Bl9H58WUeVIuncvGlSa+np0CJ1WNT6ZL6JA6k2x2mZlgpNJutLbmLdV6jOY+3MNABbxi+djLuyeGWjXYNQfWPAGyHa/7JXt8Xp1yOPAl/+hJv4ZlzbUjPb/R0u68gcMAiEBGuUj2uBg6nGCUpMpcwT/NgDdUMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEbkpVdUFnvETZZMu4Mfi13kGM0ak9a6fU315xM5Zpk=;
 b=ETkm9d9O61F61gstbKy4ikX+hCGg1grFypI+SfjofrLt98E2mSOTAWmT5MxmKKn696+taTvUmNem7y95GWgqEvyV8eYBiOytSVIfYuIj22ujzpJ9hmT60oBzWItb8YLfuqSXe94WFxUviFa01qk55kpKItUeIaxJqFzDcLG0HdQkJSyqqnBKry9Yjf6/a5rbLHOsLQyFKHqvN3aJvVEY//mgTY7wNbYdxGwgF1laqwTyRoh+HC3HOzwmzykUXhdej+mFMgwBznAU5WqAoeYgcnQYAJXj7MCAuz5B4u54L8vw484l+DMrBqVAcG4KwePA0/pe0C2oXZYSC5MO7fSwlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA0PPF8CAB220A1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 13:48:53 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 13:48:53 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, rcu <rcu@vger.kernel.org>
Subject: Re: rcutorture: Perform more frequent testing of ->gpwrap
Date: Thu, 10 Apr 2025 13:48:50 -0000
Message-ID: <174429293067.108.13577356830876647003@patchwork.local>
In-Reply-To: <93682939-6e82-43e7-8681-cc84539d9bc0@paulmck-laptop>
References: <93682939-6e82-43e7-8681-cc84539d9bc0@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BN7PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:408:20::37) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA0PPF8CAB220A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 714332f1-82ff-41d4-4ff7-08dd78366e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2RDMVV2czlkcjJPRVpsVi95UzRITDFUOUNVdml6Y2h1ZmNnanpqaVcvWGFk?=
 =?utf-8?B?Y1RuMzNDbUloaVE2ajJFYlh2eFRXRklQMCtSNnhleHV0cTZ1WHhERnBWL01k?=
 =?utf-8?B?cXYreHJPTEFHL3dWbTUrTDdwMkFuMEdSK3NJNEtUSXJhaXRLb1FmZXJWTDkz?=
 =?utf-8?B?cVFOa0VyUGdUdEw5K0VOaStOaE55eVh4dDZLMGxXclJwQ1o1M1JDQmYrNmdR?=
 =?utf-8?B?NmJHRDlRTTNkQ2lVYjR2cys3emFFeDI0YlZZdTd1aGJVNWFUTnB0bG5zQVlR?=
 =?utf-8?B?cmh0dEk4MWxZNkRTdEkzR2E5V0hOZ01ta3MvRElTUzNqUW9XSzlTeHJrQWtH?=
 =?utf-8?B?S3U5ekhNenJXSEZ5b2VleXFrRXpQOEpzMjdZdHM4OFdiRUw3c29ESnFGL09j?=
 =?utf-8?B?Y1BoQ1hrUW1mRWdOTkVYT2J6VmVWczdTTXJJcXN0SzIydU40QVlkVzdtUjZQ?=
 =?utf-8?B?M1dsRFQyL3lYSkUyNnVIQUF2VnlOdFNYYlhwWFZDZ0dWZ0t1czRRSHN4dzFJ?=
 =?utf-8?B?M0E0ODNkQVJWNlFMTU1IREFMbzJEMUo4K3N3YVRDZzg0M3M5MjZ2bmVnNWhX?=
 =?utf-8?B?eEhDSmpKeTVpSUZhK1F0UDFSbkcvU1l6MzVqeG84NkFRMThOd0doMCtEckpw?=
 =?utf-8?B?RWZtOVhXMU8wa24yaUVmQVMxR1JZaG5VbmdiZGNpUkE1YUJpaXRwVkhFUFVJ?=
 =?utf-8?B?eTBFRzUxUDdLanVheWhFS2NMWGNNT2Rkc1Zsam42aTdpQ2dGdm9OeXJQdzM1?=
 =?utf-8?B?OTl1M3pxdFhrMTRYT2VDRk9Id0RJTFRyQ2s1K3ozU0djZzVQRDM3WXZIUkty?=
 =?utf-8?B?YWovRzNiZXlLaDg4enViZzlEMkYrWkNQYzBKYXQzSncxSlM0ZGx0bFJSQ25I?=
 =?utf-8?B?TDNiLzF2Q0NXaVVtOCtOR0IzT3pZOFAvWnk5YkxtY3ZOemtvdUpZeHpzMEhP?=
 =?utf-8?B?YmNHclZFd3N5WUNFVTR4QmRuVHE4aktQNEJqUG5qaXgvekFnZlRjOXFiT0NS?=
 =?utf-8?B?MTBFbE5mclJsTEo4Vk8wVy82VWRCWFozM3k3OWdqSVZNbFIweTN3bU1sTnBq?=
 =?utf-8?B?NW5KSjc3RU5iTkZIS05yZXpsMUxpRTNzNllvSTBMRGJFaHN4WTNaa05KQ0M1?=
 =?utf-8?B?YjlkUFc0RVNra1RUR1U4c1BFTGVVQUdYVGlKYkVHTTJ3bG1PWnBsYXpXY1Bp?=
 =?utf-8?B?RDRPclhDYWF0cGU4cEkvbGRSSGc4T0RWUG9UTS9yVW9YeVZIWFBBQkVpL1Vo?=
 =?utf-8?B?Umoyc2dvSWZqL2FaUzYzQWtEaXpld1BXdWhORTFUVTFJUUtkV2lMWGRlQllx?=
 =?utf-8?B?UmRTQlJkRTlKM2doNTNZaFBuOU5LOTJvTzdXQjhaWE05VU0wNzZwdjU2bE1O?=
 =?utf-8?B?eWFFeHV4SHEveng5RWJ4WVBzTlJLYlo4L0JOa050MGJPRGVGRkFFV2ZUZlli?=
 =?utf-8?B?dnA0VytNOXJSczNveDV2UFQrd1dNNncybjU0WFBnTXJTemhmNFJKcWUrdExt?=
 =?utf-8?B?MlNsZ1YyS1M3SzhBOVRMYVNtM3cxN0VxeEQvd3VEbmNMREczYm16akV5Q0Qv?=
 =?utf-8?B?bFZVOXRzVWNCcnhwYjRjVTlwdGdTK0lUY2pvTHRCWkJ4c0h1U0VZZVJNMzNz?=
 =?utf-8?B?dEMycllob05CcktzYlRULzV4VzUxSmljSmE3clIvaFBvbmlldXMycUttdmg2?=
 =?utf-8?B?WEx1b0xXMXhMbmY5STg0ak1Ia05lSmg5N3FMeTBzSFo0STNHaXdhbXR6UWgw?=
 =?utf-8?B?ajVCYTFDSnVQVjNGK0VpL0ltZEVnS0xmZEpWUlE5U296Szd4bmZHVkZIVTdn?=
 =?utf-8?B?T1g5d2Y0T1g0anpDcWVzY0ZGczhKWGYrVDN1dVl5aVh5MlR4dVI0S2JUUjBp?=
 =?utf-8?B?cm0zSm13b2lkU2NObGN3a3FkMGpkWU15SjI0SlBwY2RVU3M5MkkzVGdpa3Qz?=
 =?utf-8?Q?HLfvnnaSNBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3JUK0RyL1pnajVxaGpYYVdDVEQya0EybU9IQ05zT0ZsaXd4MDc5MnFia3Vr?=
 =?utf-8?B?QmJPTkJZVmZ4aW8xTDN1SUxsVHVYZWdxS0dVdXdLL0czMnlLb2lISzRrODZL?=
 =?utf-8?B?SkpTaURJM1R4a1NNL1NqQzJCNnZzUXczN3laZEJGWXVRWi9SL28yd3hoM3Za?=
 =?utf-8?B?WjZ4V280eGpObWQxWTA0M1RnV3NuNDV0ZFVpZktsMTc2bUxCTEd2WGs3L3F4?=
 =?utf-8?B?TE9wcnNJN1BRc1VxMy9uWDVWbEQ4WjJ6OFdiclFUWTAwS29HbXp4WGxzQ0F4?=
 =?utf-8?B?ZXQ0Sld0d0dXYXdNWHpNblg4MlFMdG5kNXJ2dUV1L2tKaG9VdmViR1RzZk1R?=
 =?utf-8?B?VzJwaEtIalJnOHYvaDBrWkgzOVVzYmFDSVBNYXQ0d0R4cFhDWU02K0pQTUta?=
 =?utf-8?B?dGpZUWlrL0NjSFBOMmhZemNKbTVldzdYOUhabUp5MTV6d1lVN21zMEJzeDZr?=
 =?utf-8?B?UXR1c1FYNTE0OGV6WXFQdmNkRi9xY09YV1Q1TDNSRktHY3hYVTFyQ1VqZjZq?=
 =?utf-8?B?ZDl0MU9hclY2ZXhGa2hRV2Q0amcyTkxJeENJL05CMUxVUnNoTzhNRVVyL0ZH?=
 =?utf-8?B?OC9WYVhTUjdZMllyMHVINUpjR3ZyMEFDVmMwSEhOckcwazZGbHJIZ3Vab0NV?=
 =?utf-8?B?ekdCdkJUTWZzdUFOTmg1NUg0Yk1SYXMzeUZpY1d0bmlTWWZHVXJjaUdYWWxG?=
 =?utf-8?B?S1ZCc0tYUm4rc3JZQzZId0ZqQ1hDVnBMOGNSeEVNVTZKL0VJOFFGN1kzdTBv?=
 =?utf-8?B?Um9yZ0lHNXJlUGhWM2kxaklGRVduaHBNTTB6Y0hiODQ5cDdvbS84T3JNUHJE?=
 =?utf-8?B?a2U4UFFRWTF4dVBIa1hzQU00cUN6K3IyMWxndWNVajF2TzhRcVZYTzZyWjVD?=
 =?utf-8?B?WXoxRXlkR05qQUt6MzlyTTBzaGdwZEU0SE5RTjRmQmJ1cmhZVFhuWDJWSXZ4?=
 =?utf-8?B?L3JPQ0M3K05YKzA1WjZMQ1pPQVZLMk9uWEg3enN2MmExT2NEa0ZyT2ovNVFJ?=
 =?utf-8?B?V0RJUlVZalVQZElYdmEzY1RuL0FPYWliUVpyMzBxQ3dDaE8vNlcwdnFuUjlt?=
 =?utf-8?B?WUF1MGpLM2xVTkNiUVgyMTlLUEUrOWo3bGpXbnJDUkoxeXBIS3hzM3RJd29S?=
 =?utf-8?B?TENxNXV1OE12QUZIWmpJTGtvbVNrL3F5NUFlVDlNUnpPSU1iRUxlSEZwUVNB?=
 =?utf-8?B?UU4wQlllQVB6MnU0SnlmckRIdWhndmFUTEl0aXUwN0swTmtrd28wV1M0R3B0?=
 =?utf-8?B?QkgvZFhtQk9RNzhMMlM5VnVERk5RT1RRb216SmNzbDBqVDdyYTcvaXdMZzV2?=
 =?utf-8?B?M2o2ejVERjdaMVRKZFl5VWlmTDJFT24wektQbWtFSU9GRWxCNklRQVVqVzNB?=
 =?utf-8?B?R1VrRFEwTW0xQ3c3Qnh2MVI2R3JabkVWQTdRYmhTYXFYaGVMaDhOKzFXd2U2?=
 =?utf-8?B?clcyUGdTenl6YnYzaXM1byttVEI5MStqKzd1MEwxS0JYdVlZR3dMNEJ1bXVi?=
 =?utf-8?B?SExWblcyQ1Rrdk5Sdyt0VDNZazlma2dZM2N3dkV2TndEclFaQ3NHUXdFMlUw?=
 =?utf-8?B?QjZabHpWN29ha2pJSW45dzBjOGFNbnhxUnlnYWVHNERtZVRTSWZNdExGSGZk?=
 =?utf-8?B?VSs1RlFKTllES2ttK0daeG04U3RXOFhQNkNHSWNqdlZTaGNzSHV6dVJEV2Jj?=
 =?utf-8?B?V2dsdURRMzN1RWhtYjlvVTFHZk1OTXg0YXhLUFVqMTlzMWdsQ1htTkZpVGFR?=
 =?utf-8?B?Z3c1dXl0WnlJbWZPeWhrdmtCdWs0alVBOUVOQnhqa3gydmZ0aVZkYkVZQWhY?=
 =?utf-8?B?c1Zjc1kzSGZQckxwcE45YjlxOFNneTdOVlFYekFYZzBoQUtaemwxaEQ3bkhi?=
 =?utf-8?B?dk9ZMGJTZjB4VG5Wc3JNdkxwZU0zNlh1K21nQnFTeDFHazhLMkNtOTdKYkRQ?=
 =?utf-8?B?YjNjRVJRZG5ZQ0hPdHNEZVhxbi9CQXliUSsxSTEzSTQ5QzVNVEVadWN6YjZt?=
 =?utf-8?B?SGFJVnphdy9TcGdjcEttSzhodUlISDNGUzdITXJUWHYveUZZeVRCQllIMWgr?=
 =?utf-8?B?dEdxYkRHRHlhT2VYY1FkKzhoSWd3OTNtUW9CWWZTZXdZb1E1TDFBNmNzYTda?=
 =?utf-8?B?aDRBaXhlU2hpdWdlTngxWHdScnB4L1cyTHd6a2pQVHBlTTFRV0dtcGJvZzdC?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714332f1-82ff-41d4-4ff7-08dd78366e17
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 13:48:52.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uxSZxcfHuV3BvNTUg1kXyx0hwUirkzQl5tdia+F0Ppiczg+B+T/UogirIXeyZYy40Qv7gzMQxErQvRkLrohHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8CAB220A1

Hello, Paul,

On Thu, 10 Apr 2025 13:35:35 GMT, "Paul E. McKenney" wrote:
[...]
> > > >  kernel/rcu/rcu.h        |  4 +++
> > > >  kernel/rcu/rcutorture.c | 64 ++++++++++++++++++++++++++++++++++++++++
> > > >  kernel/rcu/tree.c       | 34 ++++++++++++++++++++--
> > > >  kernel/rcu/tree.h       |  1 +
> > > >  4 files changed, 101 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > index eed2951a4962..9a15e9701e02 100644
> > > > --- a/kernel/rcu/rcu.h
> > > > +++ b/kernel/rcu/rcu.h
> > > > @@ -572,6 +572,8 @@ void do_trace_rcu_torture_read(const char *rcutort
> > > >  			       unsigned long c_old,
> > > >  			       unsigned long c);
> > > >  void rcu_gp_set_torture_wait(int duration);
> > > > +void rcu_set_torture_ovf_lag(unsigned long lag);
> > > > +int rcu_get_gpwrap_count(int cpu);
> > > >  #else
> > > >  static inline void rcutorture_get_gp_data(int *flags, unsigned long *
> > > >  {
> > > > @@ -589,6 +591,8 @@ void do_trace_rcu_torture_read(const char *rcutort
> > > >  	do { } while (0)
> > > >  #endif
> > > >  static inline void rcu_gp_set_torture_wait(int duration) { }
> > > > +static inline void rcu_set_torture_ovf_lag(unsigned long lag) { }
> > > > +static inline int rcu_get_gpwrap_count(int cpu) { return 0; }
> > > 
> > > Very good, you did remember CONFIG_SMP=n.  And yes, I did try it.  ;-)
> > > 
> > > But shouldn't these be function pointers in rcu_torture_ops?  That way if
> > > some other flavor of RCU starts doing wrap protection for its grace-period
> > > sequence numbers, this testing can apply directly to that flavor as well.
> > 
> > These are here because 'rdp' is not accessible AFAIK from rcutorture.c.
> > I could add wrappers to these and include them as pointers the a struct as well.
> > But I think these will still stay to access rdp.
> 
> Why not just pass in the CPU number and let the pointed-to function find
> the rdp?

Great, I did this and it looks good now, will post v2 shortly.

> > > I could argue with the defaults, but I run long tests often enough that
> > > I am not worried about coverage.  As long as we remember to either run
> > > long tests or specify appropriate rcutorture.ovf_cycle_mins when messing
> > > with ->gpwrap code.
> > > 
> > > >  torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads,
> > > >  torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb st
> ate (ms)");
> > > >  torture_param(int, preempt_duration, 0, "Preemption duration (ms), ze
> > > > @@ -2629,6 +2632,7 @@ rcu_torture_stats_print(void)
> > > >  	int i;
> > > >  	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> > > >  	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> > > > +	long n_gpwraps = 0;
> > > >  	struct rcu_torture *rtcp;
> > > >  	static unsigned long rtcv_snap = ULONG_MAX;
> > > >  	static bool splatted;
> > > > @@ -2639,6 +2643,7 @@ rcu_torture_stats_print(void)
> > > >  			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
> > > >  			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
> > > >  		}
> > > > +		n_gpwraps += rcu_get_gpwrap_count(cpu);
> > > >  	}
> > > >  	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
> > > >  		if (pipesummary[i] != 0)
> > > > @@ -2672,6 +2677,7 @@ rcu_torture_stats_print(void)
> > > >  	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
> > > >  	pr_cont("nocb-toggles: %ld:%ld\n",
> > > 
> > > The "\n" on the above line needs to be deleted.
> > 
> > Ok.

Done.

> > 
> > > >  		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deofflo
> > > > +	pr_cont("gpwraps: %ld\n", n_gpwraps);
> > > >  
> > > >  	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
> > > >  	if (atomic_read(&n_rcu_torture_mberror) ||
> > > > @@ -3842,6 +3848,58 @@ static int rcu_torture_preempt(void *unused)
> > > >  
> > > >  static enum cpuhp_state rcutor_hp;
> > > >  
> > > > +static struct hrtimer ovf_lag_timer;
> > > > +static bool ovf_lag_active;
> > > 
> > > Same "ovf" naming complaint as before.
> > 
> > Ok.

Done.

> > 
> > > > +}
> > > > +
> > > > +static int rcu_torture_ovf_lag_init(void)
> > > > +{
> > > > +	if (ovf_cycle_mins <= 0 || ovf_active_mins <= 0) {
> > > > +		pr_alert("rcu-torture: lag timing parameters must be positive\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > 
> > > Why not refuse to start this portion of the test when CONFIG_SMP =n
> > > or something other than vanilla RCU?  No need to fail the test, just
> > > print something saying that this testing won't be happening.
> > 
> > Got it, will do.
> 
> Again, thank you!

I changed this to, something like:

	if (cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
		goto unwind;

So it will only test RCU flavor.

However, to your point - for TINY, we would still start the timer which will be
a NOOP.  But considering it is 5 minutes every 30 minutes, maybe that's Ok? ;-)
We could also have a ops pointer ->can_test_gpwrap_lag() which returns FALSE
for Tiny, but then it is adding more ops pointers.

thanks,

 - Joel
