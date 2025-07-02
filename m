Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA623956E;
	Wed,  2 Jul 2025 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453985; cv=fail; b=elBH2dVig+rsTd4hfbx/e7uuFWRNPqI4zLtUenydrEuPR9yTyXQYxWXZqnsEjpevC3MzkIsCI1AaQ5CQ9SzFyxkpDdDKzkXxYPSn2NTzcIYUPJHntX7iBnAZpSK08+xIm2HDwFcdd1Fw84KCO/5iMuNqqm6a/mgeNlYAQ5Sey98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453985; c=relaxed/simple;
	bh=x5O/XrYkVeb7MlarkX56QYwkez/jjWBJTwpK2aOI67A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TgtwbbrwN+N2z/voWVX9blpvMmO1xHOrcURPrwT5Oyb5b+e+X4+F0r5E7lXwF5vac/Y1bb4e+vifGRKFTebcqIweX8Rj2GLmN2C8NGfTZpearGiz76Qa6NmVjXGN823sMgS3OebxpvvqfmsUoYAPcUbG5W2El8t/oFxfIXS9Wik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N1coLZUJ; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N1coLZUJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abTqCBS43qtKAHxUhEm+h9fKwqvIRTvsN3mpNTrLlrZyFLnzhGHl6PRIUl7TCvCMox9vk1B+K2dCmOENyxtBagJZxoVg7HDtP0DM4/ZNeQsjciEDA+wwL5/H+ER7NoPRMtveR/bomJIYap0Z3YGX6yc+r7RAYpM7F3JAqBj55P3qJpL7+iCvFsqIk+qb5dG9FwZ37zc3khtEQWHdbJLOnHQVqLXNVntjsT4XGPdS7aw4p6xA2WOEYj07FryCqdXTDkZKCE80v56UyAdGIfhFG5tQUIhsexIDWy8BgHDauSe0fjJFinU1ZdINDKLWYdz9cFuoSNqMIKk/QQoUbw8BRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3a4cVrYTJ21olaMB3ShTDdy6wxCrekuhNq05xGAims=;
 b=qGE+uVYnvIZ13SbG/okfHfR6GCcgupZoqTCkHGCw1iYE2+eO2EMZHx1oTntOJgudwxQJZxgkOvKZhg24/Ix3SZvRJvDR2nkuCxwhzWsBhHOJRIaiODjK8pimuJpBQ6iZ+eXGsH+tIQtYZa7F0UqZmphfAlu/k1cm/p8OthjZBqwZJCSHGxMPa7i7xMXS0gjbddaFQLMWjxx3Yvs7ZyOXd+evrUi1/7WKJKpw9scoMB2CtDGwcpDZG0R4CGET6ZT/JOHvGk1tr9dK7L7oyu2Se3/+eKkqRj1biEHPnQHMZ1fgUxEi0iQ/LoPwAxTqNweJyHU1TDHEY2yPSvY8Fk2abQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3a4cVrYTJ21olaMB3ShTDdy6wxCrekuhNq05xGAims=;
 b=N1coLZUJe+vEKmryYQv8K4DH+lMkXGHTI+IYeIMbKFW+vyAmXlj4EkPJN8u4q6QaQAvvloel6CDt/GiekquZ2NY/svqsYybvIeM1V6CascrooUCcc7Xc/FlDAtBSYkNO35NTy2D6Wcv1sPpsE0JGNMLPho85Toc7nJJfrCIBPVBNlatp9XEynatvF/Dz3OBpRuzRxH9l4R+QedJSuQptcfEKloGi+XFCa6pjFZnOdUmo83viMzzc414YfXg+151ePzCBsVckU9qH0SkW8iXYswE3ke84JfTpZfDysIDNn7PZZGOtZc4jGQRZ+FKjXi0nwcxJ8TpyD/GDV/ADmw+KsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:59:40 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 10:59:40 +0000
Message-ID: <166bc5aa-a715-438e-8805-c74c2b5fc83b@nvidia.com>
Date: Wed, 2 Jul 2025 06:59:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
To: Qi Xi <xiqi2@huawei.com>, paulmck@kernel.org,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, ankur.a.arora@oracle.com,
 Frederic Weisbecker <frederic@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, neeraj.upadhyay@kernel.org, urezki@gmail.com,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>,
 Xie XiuQi <xiexiuqi@huawei.com>
References: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
 <CAEXW_YRC=f6i3KOd_uhuH=xAOCG7mW7-LwtA4+_fc8FMjfRHeg@mail.gmail.com>
 <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
 <20250603185939.GA1109523@joelnvbox>
 <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
 <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
 <c448118b-9f7e-4c29-d6b3-a66e70f7163f@huawei.com>
 <a963b475-72cd-474d-96d4-9e651fc8f857@paulmck-laptop>
 <e7354668-2573-4564-834b-44d76d983222@nvidia.com>
 <09e4d018-3db4-404e-a8f0-041cdee15a62@huawei.com>
 <279d2f06-d4f7-46e1-9678-999a2d19b710@nvidia.com>
 <506d8c4e-c317-4c85-9bcf-695596551d28@huawei.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <506d8c4e-c317-4c85-9bcf-695596551d28@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::38) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0715da-fe10-4faf-c800-08ddb9578b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmlhVEdSUHc2bWhpdnZKend3dmN6em9PYjVEUDhKNUVRSDEzai9MenRRZko2?=
 =?utf-8?B?M0VpVjI1Tm1kUjNsQkdiRnlkTzIwejJUNlBqWUUvOG91akd3ODYyQW4yV1or?=
 =?utf-8?B?VkZ5eVYwTUpUTXgwbXQ4Z01pSXk0UzVFclM4bGF5UlFrd0hqa1NjalhSVzFE?=
 =?utf-8?B?VW1GKzZqR3FlNjl5OWpYc3NwWTV0U3BtdWhwRlRJcnRHMFJMQjVOWFVZZ2lH?=
 =?utf-8?B?SStPQmxlcjRwSkQ1Ym9sL2FwSS9DUTEvTm9MWlJheDNyTlhYWGgzNlFma3hr?=
 =?utf-8?B?ZGdYRGhqRnhHVUo5anY1RHh1czRRWkoxdjdFOStuOHlCMjhYVld2cG9hdDBN?=
 =?utf-8?B?UUFLMDRrSDVEL21FQnl3NUFpLy9TMis3SzBNUmlYT0hkQjVJUVdiTlg2UDI1?=
 =?utf-8?B?cTBYZitVeHFGQnB0Yzgvei9sUmNYaUpHbVREbVgvNWpYamxGRElXNG11cGs2?=
 =?utf-8?B?WjQ4dllSR3dWbEhXczAybUdYbTFHTTY0RWxqVzRoMVZ0VFJSVVZyellhWUNR?=
 =?utf-8?B?SjY2SytTRVlGbDExdm90OTlPSHdpTHJlb3NxQy94V1hrWjlSSG16TzA4ZUY2?=
 =?utf-8?B?R1RjS2x5T2tPR1lrNnlUWml0VTRURTBDUDNPbnNSdmRHSGZ3cGlLc1lrTm5S?=
 =?utf-8?B?UDRPMTR1Nzh4TFNGWUNIMHR3YTdwVWRXblZKMmZJdlpOT2JtaHlzTVdsU214?=
 =?utf-8?B?TmRIanNaWWIrMkttekZEclNVeGdoTjY5TVBocktneXVobmtjVXRnTE9hdnhZ?=
 =?utf-8?B?MWhiUytqTk9RcWxMZUF3Vm1DeEo0cmJSTk5oNUZjUGlDOEE5eGpnNVd2NGpD?=
 =?utf-8?B?UXpVVG5kSEtOWWpSWDBoZm5BeTRRTlZDUlN0TFhLNDVhT2c3UVZ2M3RPNllm?=
 =?utf-8?B?dUZqRytvREhOdmM2Q0ZaOTh3eENHVGRmZzBiY2FDWjBiT2lweGFuSHVqWDJR?=
 =?utf-8?B?a09vRklNcTZIZUlmRlNLMzRwTytXR2dybGdBOUpEU1FaeHhYejc1b21jY3Az?=
 =?utf-8?B?S3UrRTVEaW5NSFdrdzB5TFJ1MDFvL1VRdDNseFg0YmxzMzBKOEZpSmpYbmxG?=
 =?utf-8?B?a2I5UGNwVUd5QXJjaVlpdmdxaUFKdy9ERWg0Y1gzanRSOVd5TUk4YUVKc3FH?=
 =?utf-8?B?TFE5RjE1WDl3Y05LYXVCbjdUbkZQQ2swQ3pha1hzUlQzeVNBOG81bitLdHFM?=
 =?utf-8?B?eVdRREpiWW92RmZrUitneHVVemdmK3dXUC9jdnVGQXRvVlNqYnJhaE95VXFu?=
 =?utf-8?B?endqL3hJVEJ2SjRHeTZPSTg2UG16S3JNdzFSU01rQnJ1WnRadm9qejZTUHll?=
 =?utf-8?B?dDRRT2FURUwzOUR1Tko4ZFg3d0xwdTE1elRySTNHVEV1YnN6US9CMWt2ZFNm?=
 =?utf-8?B?UVRxcHEyU3g0RWRuaHRxTkRZSDRUaFkwZ2NKR2RMZG1CZkJBZmNOMUV6WmVx?=
 =?utf-8?B?U2xtbStDc0w0enBJbzNjajhsa29mRmUzSXMyeDhQa2NHVDdKbGVla25qcGRr?=
 =?utf-8?B?SnZLZGJlTnFkbG5sQUxLL3hvcGNvM0F0akJPNldzTWYrQ0VxSEI5S29GR3B6?=
 =?utf-8?B?N3h0bGMxUjBDSDdxeVlxOU8yR2xSOGVZSzVJcE93TTlVWHVRbExOSUJkc0ZQ?=
 =?utf-8?B?MW1YUFhuUk1XVXg1TG1MNm81akVMbXNudzl6ZEFObG00S1czbUFPV2hYemR4?=
 =?utf-8?B?Mys2RjMvaWR6aytVTzhuVzk4Z2xWTFE0NFFjMzZKQUZkTVkvZDdQd1Z3YlJo?=
 =?utf-8?B?c2J0TnQ4WDJQOGVFQ3RaOUxlTmxvNVNLZHpXendhSmFka3kzMkkyNEpSV0FP?=
 =?utf-8?B?OU56YmdqYkhlcU11YzdBMDBuaDkzYnBLdnUwMWFKQTdsNld1WkNQODErbjZG?=
 =?utf-8?B?QmJNRktUVSs0VTJkTWVVRWtZME45alhRQjJUaGEyMjl6RW9zMUIyYUFSWTBT?=
 =?utf-8?Q?VYOMoWziJJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVFzbnNZNVZqdnlHdmZzTEdXSE9RZVN1c3FEYk5UdHVGRWFDR00zeFgxSmxE?=
 =?utf-8?B?MVJFZVVFc0VteGt2czh5c0tPOFBzaytMUS9paTVnYUJBd2xSMTVqbkIvSnEy?=
 =?utf-8?B?RW5tU010SVhkcjhEOGlNb0phQjNzRVdhU2pidDN2R3lMblB3SlFlMXA3ando?=
 =?utf-8?B?T2FTSlBKY2c4WitjdkRMazNHbVFGSWZGeDBVSCtJaEZVbzhFMUdzczR1RVRk?=
 =?utf-8?B?UmVHVTBYUXlaV0dDbDE2MmlqMWpPc00vSW5RNWlXTTdHcFo5Wld6eW4yQVhT?=
 =?utf-8?B?UDJBK1g3V0dKaDFlZzhjQjFMUXljREtzcXo2dUt3c2xQNmxDd3dRQ2hIT0Jk?=
 =?utf-8?B?YmRrZTIwU3p6V2JsRHpVRG9lRHNpWXhDT0pUZUtxNkhtTHl1Nmkwc3NacDJu?=
 =?utf-8?B?NWVzdlZnSUtYVVQrdkZoZE9BK3BhclFpMFQxRTdKc3BZZXpkdWFyZFQ2bDlZ?=
 =?utf-8?B?QnhxZ2NqbHVMTUxZUGhpNWdSYnYrcTdnS1FWRE9NLytJWFpuR0YrVXJBUkVu?=
 =?utf-8?B?N3N0VTl2MEtQUnlMUlVYWFUwbFAyQXllT2RUWnRqc21mdm5tdTVtVjNhL3hj?=
 =?utf-8?B?OTJ6eDFZT2JYV0Jrc1hSa09jRFVCWmJ2emd1QTc0RDJqYWlGdm0yeWYrZkRz?=
 =?utf-8?B?RC9JZURZc0I4VE9Ma2dDWlI3L3AwNjJlaDh1a3U5UlhtVithd2lMQWJUdnhm?=
 =?utf-8?B?T0lIR044UFBOa2JmRWhSU0tRYk0zMVg4MG1jZEN6NVpJQ1M2N295Tk5JTm9s?=
 =?utf-8?B?bnN4QzI0bGxuR1ZNaC8rOGZpY2lXR0ZCNnhlSXVYT1lWOThSSVcyTHgwcGJS?=
 =?utf-8?B?N2FrMkRVRnQrWVBHS00xUjN6cytQOW80b0JPWkI4bWwvK00zZXNNSmZxZGY5?=
 =?utf-8?B?dlpKUXErK3QxdURzS0VQRXNrY1Iwd2x0VWZCMUV3QUVnT1g1ZHVjMlpvM3pE?=
 =?utf-8?B?VU9nNzRNVWppdmlTbjBLWm91aHdSZVRDWGhrdWF6WWdyME1NV2VUSi9NYmtC?=
 =?utf-8?B?S2tLYXRWa1lOazVOL3NTVkxiTVV5LzNlTkdScGtXeXlhMC9Ib1ltaHV5bjJ3?=
 =?utf-8?B?S1hOMkhCS1BQdVRndW4yRHA3Y0ZDd3FIYUJqdTJyck5GdjNtL3Bvc0M1WWlu?=
 =?utf-8?B?WmVNVHdxcGVCQlBoUi9FWDlXQXQvZmp6dUNsazNuazJsZmxPeEVORWZaWU8v?=
 =?utf-8?B?NU9VYWc5OGVSOXhuZnRJU28wSFJ0ZXlRdzEzWWx5b0szM3p6UXVPK1RrcFJC?=
 =?utf-8?B?Q2xvbEhZTnprZDQ2dUp3MjNmZTQ5bWllRGQvdWE0a0RzTWJ4VFhEcS9lS2Qy?=
 =?utf-8?B?bHJ5NEIrSTRLem5jTTZ2Q3d6YVRrWGhJb1hhd3dCaFJnV2ZTR2huNXlSQmRD?=
 =?utf-8?B?OVhyaGU0UVFySHVVMlJ6S1poK2l3Y2NuU0dWRUhNaHdLSUE0VlN5SUl3cVN0?=
 =?utf-8?B?ZTk5USs0QnRXVGwwYW93cXhxaEJMamp5clB2M3I3NjQwRWVucFBJMER2cjIy?=
 =?utf-8?B?T2o5K3I4RFI0dXkvTlQya1E3UnMwSXBqOFlRK0ZNUVQvN09QOXF4OUlOWU1W?=
 =?utf-8?B?cURFRFI0KzRUMXRRcWJrbWpVZmNuNFFEM1BEWlZTbG9hVXlTdyt3RTlxZDRX?=
 =?utf-8?B?a2NDb2ROR1ZVU0s4TDZzSHFXT1BESkM2dGFMb09tNHBHRnZFM3lvSEQ0bVE2?=
 =?utf-8?B?ZmsyT0x0YndwYkVDcjlvMXZDek1qRDgyamc4dHg0dWl0cTlEYSsyZmtqL2Q0?=
 =?utf-8?B?ZVQzUlNDVTZpN0hVWWVZRWlGY2g3YUlTZFlFcjdlRUZOT2dEZ1UwcEx0aldt?=
 =?utf-8?B?eEFhcDBqWCsxc3Y2WmJqOU00UktaVm1YWGZOalZJbDhCSjdqZlBsNmkyZlRL?=
 =?utf-8?B?SVI5YTBKSXFiUUZkSEo4bXBSdEZpUGdhSWluUmUrRlhpMVdmVUczeE5ROW9O?=
 =?utf-8?B?NnpKb0g2VnlWRVpMYTFnU1VldTNLcnZIU21MK1dFNkMreUJzS1VqU0k5a2Ur?=
 =?utf-8?B?MFpzSmxiaVdqZk5sSFlkbHlvMGdqQXlKMDA4TFV4NitDN0w1ZzFackpqeFRG?=
 =?utf-8?B?V0FTdFhqT1Q0TDB6NXJGd3gxTGk3RDJEN3FDN1R4YjhlQUhKNitiaHh1cmdl?=
 =?utf-8?Q?8V+MPBVw5VSQdXuVfR5qav612?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0715da-fe10-4faf-c800-08ddb9578b19
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:59:40.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSqPz0PVoZ30e/U64c1F/TxlRjXZnHs+KyCnqnXon194+tcRGZTYrQv8wQ6qWwqXp3GZeO14qHIDalbBcVOxlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440



On 7/2/2025 5:14 AM, Qi Xi wrote:
> Hi Joel,
> 
> After applying the 2 patches, the problem still exists. Compared to the previous
> fixes which did solve the problem, the difference is ct_in_irq() in the first
> patch.
> 
> I am wondering why "nesting != CT_NESTING_IRQ_NONIDLE" is added?
> 
> 
> (previous fix: problem is solved)
> 
> +bool ct_in_irq(void)
> +{
> +    return ct_nmi_nesting() != 0;
> +}
> 
> (current fix: problem still exists)
> 
> +bool ct_in_irq(void)
> +{
> +    long nesting = ct_nmi_nesting();
> +
> +    return (nesting && nesting != CT_NESTING_IRQ_NONIDLE);
> +}

Oh gosh, thanks for spotting that! Indeed,  I had changed it to != 0 in the last
version but applied an older patch. I will fix it in the tree. Thank you again!

Neeraj, would you like this as a separate commit that you can then squash? Or
could you fix it up in your tree?

 - Joel

