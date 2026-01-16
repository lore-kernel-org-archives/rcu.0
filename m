Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74328392C42;
	Fri, 16 Jan 2026 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574707; cv=fail; b=erN6rE1RMZghJ92lsD+9khB5L5GPvrSRZamRkQNEFG/tNXTOXOBvgjrd6xNB6PccsnNkBvbHPhIa0MC5TzV5kLvkDgtkEBfxTyZqBCw1SNVC/xMZeLDonQRH7vUv7nm5GyX1w2ivcC5Sm34pLsUDpXDeyrrPXUay6Yh5lra0Txk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574707; c=relaxed/simple;
	bh=IjGGEw5OxXsTY74z7Osc3aTHdEcGeQpI0J2LSeCKjbM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=SFfI4hAf5yk46pb/32Jgm785KNrUycp9BD2L7wi1Iowx17sYrvKePGA5Gz0eKPRA6WhbKV77JK3PPAGht/4uEUwLs8YK+jm1rUBICo5z9S2EAHItZcjMt+GgV6LTMKj7Ggoel7fuY5mnYDyfVT/uT9BCF0D4Hgbc53Q1cOb+ykw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hld/qsG3; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hld/qsG3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMnlgJ/ehmmhjNYsEJ4F7Q6sq/dgYwXoKDvIX5T/toLKwoki/EHaV/gbJEw7nyS2RGd6mSYXqvb3BSCVmW4BO8Pdw+NDpUAlaCjw3JATuqP4TRNYE6ysh4v/8lRdcMCBO5QhcBsVneiyXa1kUJ4yY+qIWGqUCNEzZyOE8IeVi9+ccBWYvTFfufJzBjSEH309VOlr5dZ2h8L04hQB8ZFRwLB6bdY22j3lE/yJzYG0Z5NYxCOaLxVIPS07kBaZCRBzqY3RYnySAUjBnPZnR19Y+FbfdkLjWy7/q5/+Dg5/++UvTcmputgaMfLBmew2VaKG5WJiFlHbah4YLTwaKnxbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbTLemivPeyNb3wdjiyRPQxPqAyoEFxjumYdsOEY2RM=;
 b=KpHh8soJ7pJ4LK+QGRen9Ej2iFrWvWdSpDgmLo0aXOiLt+pZ76idHeh9dAIAiLy1kkZndDGKkqpDuT51QlZO3Ck6zvcK0CXeAZmbqQbZw8i9lGWvAfNrezebpMV5pmfA94q2AWATvyqqMcVXu23G92Yf0+RlN0XJc+AbeYAI79qd6A0qzrQTdHjUDIFQxnu/LOBbH+iAXHAFQ2hhohWLeZ3vpgxprqNb+KPraAHaaezvb1lZ8h/VSk5f86ZrGLM7hjtpUATHPg9IdOet+K/ucvkVsgHjiGZbMl7s8jPZXaUK5KYrWjBqPzZV4ZmQqiHV0WjMs5NC6tWLHymwtKbsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbTLemivPeyNb3wdjiyRPQxPqAyoEFxjumYdsOEY2RM=;
 b=Hld/qsG3SptHPq49EIPzB8sYGV/VYYwm0vVolC+ycMCQSjGkEx80GD8bbWlYrwgaQjL6p0jTHgr7qFpSyrytIDODM3NqGFSej2YpsKQBZM95T9WbvclXp0Yq9tXjc+NabwLzdk+JZKTJLJMxspk/txQnRTJHbBJc9fs7KraXfJ1aJrRUi8hKR8utQo9/AnPeZoes9HmVAbDgGEWebSvsrQZcuseii5bXBGxjTrPQsDB5/cBpoMl75DeS9rViIHp4NTNcu98GfxPLasSB33j7D1QwX2Hq98henLpnc8l3IkQ90QROrtp4CN6r7DomSmEIieaJDLAd0oyv1N5KeJn24Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 14:45:02 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 14:45:02 +0000
Subject: Re: [PATCH -next v2 2/4] rcu/nocb: Add warning if no rcuog wake up attempt happened during overload
From: <joelagnelf@nvidia.com>
To: <linux-kernel@vger.kernel.org>
Cc: Paul E McKenney <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, <rcu@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>
In-Reply-To: <20260114173154.1701056-3-joelagnelf@nvidia.com>
References: <20260114173154.1701056-3-joelagnelf@nvidia.com>
Date: Fri, 16 Jan 2026 09:42:59 -0500
Message-ID: <4AD1E2C8-0947-403A-B5C9-B6BE4231D576@nvidia.com>
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BLAPR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:208:32e::35) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 70feb450-ee2b-4d91-d704-08de550dd4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXR3Qmw1T0ZyQ1RYU0FjaWJja2JFdkNIRWZXbUhLdVRwU1l1bkpOc1J3eXB1?=
 =?utf-8?B?YUdYbFJGYS9waE9DLzhNTHNNaXVndE9rL1Bzd25GRXFpWFBuTS85L2lKR2R0?=
 =?utf-8?B?STNuZWpDY2NCS0ZoQjRJZi96ZUZNOFN2cFNOWDZ0TlNiV2Y1L09XUWl2VUhU?=
 =?utf-8?B?Qk1xQisxS0tBclZIQnJsOXp3L3JlY3NybVpBZVZrak5BYWl2S3FITGtVMmpa?=
 =?utf-8?B?c2M1NHpCaXFjOGtUK0xKSUhJTStzSW1td2ZJcGIrMXMwZ3kxek1CWUpoZS9D?=
 =?utf-8?B?aDBtRGgwaDhEbFBmVk54b3lHWEo4bTlzRFJKSUM1enVZSmJrblVEVlZ5M2R3?=
 =?utf-8?B?Ky9ZeS9RWVlPdTVPSTJIMHE4bjgyTGJzVVN3QUwzQWY1QmIrZUd5MjZpUit2?=
 =?utf-8?B?T2haN1lIUEtNWmR2ZVJMbXV2MzdISkYrSFhoMTJ1T3pKNTFaZ0JqMjFQejd1?=
 =?utf-8?B?Q1hQUENxUU1DYXU5RWM0UEZVUDFValRoZy82V09uMFNCODh5MHNiL0RrdW5L?=
 =?utf-8?B?bFN3TXBXSzcvc0h3WlBmQlNOSUlycXVNcUQ5cEVmQlA4Vm9VN2NNa3pUdlZO?=
 =?utf-8?B?SFFUZElsSHJyR0FLQWc0ZHJSSWNub3FHQTB6OVNLN3grL3JlTHN1R0g1aWp5?=
 =?utf-8?B?TFJKbVlKUlZkcHdOMFlkeTMrTHkzVG5weVo3NU8yYnd2ZmQrSlU3VHlTYWdR?=
 =?utf-8?B?bVYrYTF0dGJOMUNnN1JJRWZUTkIxdGtFYmhrVXljRzV1TjlrRUtkdUJ4R0g1?=
 =?utf-8?B?THM0d1NZbUkwSVh4cnJsUmROUlFzbU11eFZKWml5aEFIT3RyN2wvdGU1WGdE?=
 =?utf-8?B?bmo1V0RLdFFvbGEzMmNtQmQ4aVpMaXM0VlU5NjdHTU5VWnIzNVR1RU5lRXY2?=
 =?utf-8?B?T1M5WjQxd2QxOTREczZpT0NLYWtuU0ZaT3Nob1kzZmxtK21WdUhKUCtMZTFP?=
 =?utf-8?B?Y0hXREZYRFdCczFWcmtxNElmV1RZOStUZ1UxaE8rNFFLVXF1ZVJ4bHBWMHl0?=
 =?utf-8?B?TnR5WTh4V1JxRDBKZGNsMTd2WkZ3clozUWlLMWdSYnY4T3Z0VDhHR0lNNHN0?=
 =?utf-8?B?b0Q2cVdNeVI2WVlLRUtYcjRWQVdVaWtTdVdzaHVIRzUrSWsrODJSZ000NWZ3?=
 =?utf-8?B?TWdIUUFUQnFEcytDYm0zWHRBYWpXSzBManBQbjlZU1laeDNEQ1FlUUdaRGtQ?=
 =?utf-8?B?ZXhzSHpDeW02RGliVWVRa2pmMlMyUEtjaWFYbGtIdFlHaTFWTnA0a2xxNkVB?=
 =?utf-8?B?aDBtSHRsakRUc1Q3VFlwekxlQ0FhSG9QQVpCZ3ZzemVMU21WQzZST3dzckFG?=
 =?utf-8?B?M3diZnU2b2dVUGJRQUdQZ25HR3hTd2lRZjl3Y0RNVnBxSnZDbXk4eksvdjJK?=
 =?utf-8?B?ZXpOWnBjQ2pKaGJlVGdpKzNTeVhMeFZvV0lDemt5VXJJOFY5OFBlRVEvWHA2?=
 =?utf-8?B?OU9MQlJDOG9IVjBncFFhZ0tnKzNrTDdYZlc0S2szMWc1RnBDYjMxZWhLTEJU?=
 =?utf-8?B?dFovZElOZlNsMllPZFJMaHFGUkFxYXdQaFVFUllyVHBMc25NemQzQkx2Z1dL?=
 =?utf-8?B?MExSMUw3eVNsU0E2bXd1d3p4SnViU2MwRk1rNmlTQ2MvOW5HenZhYUpFbXlJ?=
 =?utf-8?B?amtWT3U4blowY2VJYmM3V2RFSW91Ky85T2tNY2ZwRFFvOHNnZks1YmYzRDkw?=
 =?utf-8?B?dnNxREdEZzIyUzUvUFNkMURFUkdSRnNLdk5sOUpyZWJoNTdJL0xQbGhJRm44?=
 =?utf-8?B?a29sZ0VYWk0xVzRzeCs5VWpvVGdSdUg2cjZDTTlBdWZiNnc0eUl3SktMS3ls?=
 =?utf-8?B?bG1SS0JWRForWnc3RDFJL2VwcFNibzNOcHJSWEpTS24rMkZkM2crYVNaQ3lU?=
 =?utf-8?B?K2NUSW01VUVqZkZQajhWcDNXMTQ5ZG9XY1NWUHVvRW05Z1QzWEtaVDBtM0o0?=
 =?utf-8?B?ZGx5YSthMktQV1oyTjV0Q2oxc0VMUi9ZRG9IUHR4SWx1a0RjbzdUTXlNZTFx?=
 =?utf-8?B?bktjd1RiVzNrUWhIR0tZSS9lRlpuaFE5T04vOG1LRXNtckhlQ3NlaGcxa1VH?=
 =?utf-8?B?NUJsTnhHTi9wUGI0ZUxWUUVuWlJ3L3VHMzVHSWJ5OUx0NWVtZENVKytTSFNP?=
 =?utf-8?Q?t0bY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjM5TDVCMHFGc2JSeWJZOHpob3hLV1drOHdXZThQRVNwcE44czJuTTl1NElX?=
 =?utf-8?B?KzJscjZ3dEF3SlRLSmRzbDRucVJ2RnVkMmNBKzFPUzdSZ3YyMlZMY1RGYTl1?=
 =?utf-8?B?bUlJYmhBeUoyZUZUMEFrejd0NldYZHdrVHNmNjZuT1RmbjhYdUh3YUNKVnJX?=
 =?utf-8?B?Z0cvcmh2alNsKy9CeTd4OGRmRVgxSVRKTUZ4aFI2RmFZQjU2SGlFQzVtZ3Bn?=
 =?utf-8?B?aWYyWkZHNTZuTmJBNm80ODJrUVY4N3pWVWQ2RHFORWhtMlIwcXZwVmt4OFRP?=
 =?utf-8?B?RHA2d3FJa0ZKTDV3d0FnS0l2bUV2TjN5WGFNNm1nUTFNODBnZzFvcllRbHNR?=
 =?utf-8?B?SzJDT0k1RzVQTThEcnI2dmkrc0FSa0FqRWFMRWNCZS9aanBYdWV6WXAyZUtB?=
 =?utf-8?B?WGNsZU1EZUl4YTRmcU9Lb3J0YTlCczZnK0JjMmxwanpMakl3bko3bjBPUVpu?=
 =?utf-8?B?M3MvaStXK3BsUzZOeEl5N2QrWUgyT2RIUjRPWWJuOGZ1ci9MS2FNMHJLekVn?=
 =?utf-8?B?YmJNNVF0VVUvUXBsV2hCbVZNOXB4VVFac0tzTnV0UDZQMWxOOS9NM3BEYXpL?=
 =?utf-8?B?RWVoZTRteW80ZmlkL2ZVVm56YWQ1VXllWk13Rk9oQ2ZmdDlQdnZZdUlHQU9z?=
 =?utf-8?B?ckxuWC9PejVpbkJjSkFtU3lTbit2MTdlOUtadU9jakg0dkZaK0ExUGJlais0?=
 =?utf-8?B?OTJObkVacm1kU05RK3ZsRlM1dnpKUmVPK3N4VGF3bkY4ZlJnU2tRSjI1QnhF?=
 =?utf-8?B?SUtRNzZaUXpuN1NJQVZFdVFIN29Wc3kycncwTEpSVyswL1dTd0ZWZmJYRVEw?=
 =?utf-8?B?d3JReDRBS09PY2ZRNVBodDBWSVZFdWRGL3ZucWVud1NlcytLVDdZL3BKUlhM?=
 =?utf-8?B?cjgvOUJpVDBmazZOVVU1L3YvZjV3cFpXdStSWGVEOTFBOVpDUE5mMUlsRFRI?=
 =?utf-8?B?aFNDejlLclhMZG15akVtZ1psMTVaZGs4YkZmVXRQaGNPQlY5dlNpendPUFow?=
 =?utf-8?B?L0xaZmNKcmozTTluclB5NGl5NnJHckRDakpoWFN5V2lLa2ZoeG1KUkR0ZHl0?=
 =?utf-8?B?c1BPdEphU0hSdy9jMU5NRnRBNEdqaXJmQlVlTGRNKzdaTjhsRERPMnp1TFZ4?=
 =?utf-8?B?NHBUVVMzYzcybUphdDB6cXBaRm1hRU1CblcwcGdQSlV6cEtZRmlYUFJTVG1w?=
 =?utf-8?B?UXk4ZGd1UVBWT3ZLS0hHRDRBMzdPUGxUOERQbk5JVFM2TVFMbjQ2Y0hISW9z?=
 =?utf-8?B?elcvdzErWFRja0RqdEt5L3RuRE1KT1M3NjM3T3ZjZG4zQldmVDRIN3YvTUl0?=
 =?utf-8?B?bzJTTUtVZFR4T2ZKZWZocDlaVjFpUjlQcmN3b1NoaHJJYlBPaC9qalNrSjVi?=
 =?utf-8?B?SlZ6S0VIOUN5VHpSNEYyc0lXOVkzK25qUytDY1R2UDZKYTZTckhFeTIzUmZR?=
 =?utf-8?B?QlArOTRZNjd4OUVxalJWMVJ4WThSU1VNdWZhWXNrV3NXNVRITHYxbm5yYnNK?=
 =?utf-8?B?a0F3dVJWRnliWE9hQmNwVC80RmRxUmtjU1YwcERjTFRVSVNWRzE5UGlnTW5q?=
 =?utf-8?B?VnJBeG1DOWVCNE5tcE9MajVzWWpFU1dUZklhYWZPclhpcStsRlkycWtneW05?=
 =?utf-8?B?WlczNm9iNDUyOXRuYVc0eWpZV2M4TFk4Z2RRbzBKUW9HZ0NkTXJSOGxYYkp6?=
 =?utf-8?B?a3hlVjlNeGdGd05XWEhjNDZNbFZWWG5sTG5GNXQwR0lGdDZVOFJHNEVscGVC?=
 =?utf-8?B?TkQ0Q05EMFRsYzAxbHdpSk1EN0xaWHJsVHZIWkdkY0IwME1FejRCSElzcFc4?=
 =?utf-8?B?ZXA0MVV5WThBMFJHV282ZnRleWVoVWVHUWlFd01zd3lDVWlGZy9QYlRRSm90?=
 =?utf-8?B?eGorb3NhV2NQc2E3QU50blZTem5NMkIrMG83a0J5Y3M3MDlPUTY4NVg4RE91?=
 =?utf-8?B?c1BHZzRZZkJJbktwZ2hXUitpbEU0UStFQk5wR01RS1AxSFlycktudnNHb1o3?=
 =?utf-8?B?SmVJUVQxWVpJTjNjOThTSDNmcC8wL05OR0MvV09QbDRxZXh1b210YVhMZldZ?=
 =?utf-8?B?aStKa0R0YVE4WDRkRE1rOWxXQjlBRGpHaDNiSncyVENlSFhxQmlHY2M3T2N3?=
 =?utf-8?B?b1FIaUxid0w3UzJnVUZsS3F4Z2EySUgrZ2xoaFNJZS9TN2c4eTJJT2R5N0Vv?=
 =?utf-8?B?MXRnV0VRRlE3eHRrZEhrQVBUNjhkbktOaHFvVEFoTW5NNWZHUUFJUFBvbmtZ?=
 =?utf-8?B?VlhLdUNXc0pEcG14K3draGZGd1RUcXhxWHQ1dmJYUVVzcENhblUxUHp5ZVJY?=
 =?utf-8?B?WGVITFlGV252dWEwNTZWRlJZcUFEa1NNc2Jyb3VabjZ1MklybjhsUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70feb450-ee2b-4d91-d704-08de550dd4a6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:45:02.5878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqOpidtZMjtjJkCy+5THgUel8OHpARabgCIFr8sYFDOk7GnTTy2MrSlPHUNl+bqheIRGOGaZCOTLJkD4ubUAlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912

> On Jan 14, 2026, at 12:32 PM, Joel Fernandes <joelagnelf@nvidia.com> wrote:
> To be sure we have no rcog wake ups that were lost, add a warning
> to cover the case where the rdp is overloaded with callbacks but
> no wake up was attempted.
> 
> [applied Frederic's adjustment to clearing of nocb_gp_handling flag]

Frederic,

Is it possible for you to do a quick review of these last few? They're mostly 
simple. It would be great if we can pick it for this upcoming merge window.

Thanks!

 - Joel 




> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
> kernel/rcu/tree.c      |  4 ++++
> kernel/rcu/tree.h      |  1 +
> kernel/rcu/tree_nocb.h | 11 ++++++++++-
> 3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 2921ffb19939..958b61be87ea 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3767,6 +3767,10 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>        debug_rcu_head_unqueue(&rdp->barrier_head);
>        rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
>    }
> +#ifdef CONFIG_RCU_NOCB_CPU
> +    /* wake_nocb implies all CBs queued before were bypass/lazy. */
> +    WARN_ON_ONCE(wake_nocb && !rdp->nocb_gp_handling);
> +#endif
>    rcu_nocb_unlock(rdp);
>    if (wake_nocb)
>        wake_nocb_gp(rdp);
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 7dfc57e9adb1..af1d065e3215 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -257,6 +257,7 @@ struct rcu_data {
>    unsigned long nocb_gp_loops;    /* # passes through wait code. */
>    struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
>    bool nocb_cb_sleep;        /* Is the nocb CB thread asleep? */
> +    bool nocb_gp_handling;        /* Is rcuog handling this rdp? */
>    struct task_struct *nocb_cb_kthread;
>    struct list_head nocb_head_rdp; /*
>                     * Head of rcu_data list in wakeup chain,
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index f525e4f7985b..acca24670a8c 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -546,6 +546,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>    lazy_len = READ_ONCE(rdp->lazy_len);
>    if (was_alldone) {
>        rdp->qlen_last_fqs_check = len;
> +        rdp->nocb_gp_handling = true;
>        rcu_nocb_unlock(rdp);
>        // Only lazy CBs in bypass list
>        if (lazy_len && bypass_len == lazy_len) {
> @@ -563,7 +564,8 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> 
>        return;
>    } else if (len > rdp->qlen_last_fqs_check + qhimark) {
> -        /* ... or if many callbacks queued. */
> +        /* Callback overload condition. */
> +        WARN_ON_ONCE(!rdp->nocb_gp_handling);
>        rdp->qlen_last_fqs_check = len;
>        j = jiffies;
>        if (j != rdp->nocb_gp_adv_time &&
> @@ -732,6 +734,12 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>            needwait_gp = true;
>            trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>                        TPS("NeedWaitGP"));
> +        } else if (!rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
> +            /*
> +             * No pending callbacks and no bypass callbacks.
> +             * The rcuog kthread is done handling this rdp.
> +             */
> +            rdp->nocb_gp_handling = false;
>        }
>        if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
>            needwake = rdp->nocb_cb_sleep;
> @@ -1254,6 +1262,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>            continue;
>        }
>        rcu_nocb_try_flush_bypass(rdp, jiffies);
> +        rdp->nocb_gp_handling = true;
>        rcu_nocb_unlock_irqrestore(rdp, flags);
>        wake_nocb_gp(rdp);
>        sc->nr_to_scan -= _count;
> --
> 2.34.1
