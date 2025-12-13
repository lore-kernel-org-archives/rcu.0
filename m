Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5B146A66;
	Sat, 13 Dec 2025 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765652546; cv=fail; b=fv3V08ut9X2HzY0DUcSYoXwqCoPFg7j+fPKzkCYYBBmIIdVLLG3JIBijBpf5DGOjWWe+CnYsXXqSapvb9Mi1LGMujHjI+z7YbSsDkYzEsSur98dJi3l8kDhAFsc3ujq0KO/RwuMAXN/frMGtYyhdn4VN4hY/8B7Iz0bWREPTI7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765652546; c=relaxed/simple;
	bh=ZcrjsykbZCAXuBtTGa/SWQH95q/yxuhyA5GibZjA+NE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QOkRUFMlycZ8+y/69uDbxp8lz6pTCmO9WxmZZwFMk3gnLEQu5XHzj5PqFQrEIIJdZp3wtMlAchsyxhI12+5A2WMTcuySio3PVaUnpTa4rqMF6Dq8Yecfuke7S3vykKOZuL8kfBANBlLi+FQYnTMTbOaRkKSO2HyPp0Imwkqt0zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ntZEkfop; arc=fail smtp.client-ip=52.101.193.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ntZEkfop"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM3cmdebJRMlYRheQjDHUIzPwvGRCb1A21Y65ZD/V4QMI1VEJB2Hn8OAikG6ZAVXxk08SbR9Ls5w5etzaQ/uFM517g42Md7IMwDSmi1sP0zYdE6+vMux7fePm5x/v8VaRa/1rdK7igY1W2s6QeP20gbTwVUcqr/Xqn/LNXcf70PUTVSBAPkCBVInRUv0kcLdbPYzEp3ulO+TNWVwJyWK36byVW8X/1ukqmxYKfG6wylAEOXl/pSY/VV6YCbA6HDSXLUwf1LP3PCCaqahYA1n1bwpSXmKFZmCKEsHcp67q6ryHdiU9IEV3c9Hwj8Au1AD1d3NqhcBqkipnMstemxCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcrjsykbZCAXuBtTGa/SWQH95q/yxuhyA5GibZjA+NE=;
 b=BZl+03xgwc5mXV2VNJ7zUHJQJspM0nI9I9J5t1F4wFyodJ0VS44wxpHQTtDZcC0ajB24taUxDRwG/8Dmmyq2ecqsV7+fRBmsrCetjK0Vae2BkZqQiTYdM8SuKzjlOlWSMAv8XiIqFhg2aep5wDp6Uvl+rN7umEBOemh2+1gWJI+jq3sVo/ijTy7/8bkZgeKt0XWllx4ONrcfd6HkKCty9zkap+3zvoyso3zH/HtPjwt1+vSF3zd+fDTw0rKMyJy9Jrvlg1GDQmi8y1r5Z9+SYOzIWYarSWeZMX/1WnpZ8bG0zQhcFK+VOTWtpV50QIZR/3xoyP3RA5i36O767AzyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcrjsykbZCAXuBtTGa/SWQH95q/yxuhyA5GibZjA+NE=;
 b=ntZEkfopurAtAcff9UGInTn2ohiDVuY9cbKK3lh9RTtDkdPebCQIh8IV6qLYyB+xBK/cGu8S3kU4+giqojVFJ3C9V/BTYB//7EtStzuW8E0FXmTcX36kmEPhi8ZC+3M+kCdSg06dzyhS9Rl17UTXg5VunDg/GkiUkd7VXGBsxmDY8YcyZLKlVqNKixmn+eNdqnSia/1686zjGttOIS+cc1njfsL5xTVRDIC74RE52+HZ4tZqKOqu+oCP9lPVmciMYr253EyjSfZxrJhqPM34a2PaTfeeC5pUEEiMSA3wrPcy3d7as6IM2VvvZadsZngD/jrXCtlwadyYFgvUS3G3zQ==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB6161.namprd12.prod.outlook.com (2603:10b6:208:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 19:02:22 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9412.011; Sat, 13 Dec 2025
 19:02:22 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
CC: "paulmck@kernel.org" <paulmck@kernel.org>, "frederic@kernel.org"
	<frederic@kernel.org>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"qiang.zhang@linux.dev" <qiang.zhang@linux.dev>
Subject: Re: [PATCH] srcu: Use suitable gfp_flags for the
 init_srcu_struct_nodes()
Thread-Topic: [PATCH] srcu: Use suitable gfp_flags for the
 init_srcu_struct_nodes()
Thread-Index: AQHcbDgmEAgtPDQTCE61yrO+bVbgcrUf7ZWz
Date: Sat, 13 Dec 2025 19:02:21 +0000
Message-ID: <2D296DB9-2F60-47B2-A48A-D490A291A0EB@nvidia.com>
References: <20251213135518.109887-1-qiang.zhang@linux.dev>
In-Reply-To: <20251213135518.109887-1-qiang.zhang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|IA1PR12MB6161:EE_
x-ms-office365-filtering-correlation-id: 54bc952d-79e3-4055-ee49-08de3a7a2554
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2w0THVVd0dIdXZUTXJCOXJVZWk0WW8xakdpaW90WWJqZmRENlN6NTdQWjdK?=
 =?utf-8?B?VXFkK054MmlWMHdUSTZEc05BN3NORDR3YnRtYytKdTJ5M056YXI0OHJEbURw?=
 =?utf-8?B?aS9WZzEwNDZFTm5TcmJ0TWpOZjN0YUJCV3VSR0Q2WjREcThzRmRsKzNGWUZq?=
 =?utf-8?B?bUVGVENpK3luY0V6Q2xwWmM2MWxnV2w4SHNiQktLS2NGUzdGcEtUbHRqM3do?=
 =?utf-8?B?Tjd6ZW1sUzhkVDhXTjN0cDBDeElCckVUUWdKczdjSHNuMG5xV3VRSjV4d2ho?=
 =?utf-8?B?dDlFRDZzRVBTbkxsdFpuS1ZCSnEzZkFQRURFaDI3OG9qVGlmWFhESk9CcGpl?=
 =?utf-8?B?eWM5dGdIL1hPOUdkbGZ3SCtaME9qc0lsczh6WXlsdHp1S2Y2RkFWYnFGOGZ2?=
 =?utf-8?B?Z1U0T3Zsci8xTVp3UDd5UmNWaHRlODRtZUV3QktVVHJtYWVOV0pzaUw3cEk2?=
 =?utf-8?B?UXhlOG9yMTRYclNRVUhlL2FxQ2pxaExRdGhWU2hMWFNIdTdhVm5vR0hGejV2?=
 =?utf-8?B?MThHTWNUeDlzd3Zrek9ia3lSYm11RXR0cHR1bmM4RFpuRzJWWTVaVm5ha3NS?=
 =?utf-8?B?NEYvUUZMc3RMUnZmdStKdzNpWjdiRlhVTmxJc3lrMXJNT3VsTkpFVmhSa0hi?=
 =?utf-8?B?VEVqQ0wrUnpNRHFRVTlqOGpaQlU5MnFHUlZvUm1JaWMyQktLOUlVWi9JaGho?=
 =?utf-8?B?M1FJR0Y5RHNPdnd4VitQbjltZVlVZnpxNVVtT1lkSE1ET3hqL0pMZGl4a25L?=
 =?utf-8?B?K3ZSSUNCNktlK0N6RzlPZWsrdlo0U2YvemR5R0NIVXcvQUNkQ1lGZTJ1ZW9r?=
 =?utf-8?B?QjVYZEZTMnBJelcxQmplTUpxSVBKWDJ4V3ZKQ0N1MEFJcnVvVkdVdjAzSHRj?=
 =?utf-8?B?YTdRWXhNazVROENoZVIwKy8ydm9JcXYwYnZqUDVFdGNIYm5NMmF3NVRuYWpB?=
 =?utf-8?B?c01SYWpZUnpUVjAzNE5wK0JrNHVRb1A1VEFBSzB2QiswTVJoMnJOb0JEaTJ2?=
 =?utf-8?B?Qll1NmcvWExQQUdDVHM2NlBWelpUU01EbG5EU2VjdVdBclI0YmNRSVp0ODh2?=
 =?utf-8?B?elJvZkI5Z3ZDbnRjL21DZTJ0TWhXL3RJR2tQTG1rSGVFTVJRUnZTM2prcVI5?=
 =?utf-8?B?TnEvRVA0K1FqL2JrbFRLellENFFxRHFpMUUxbHI1c05NWmN6cHZhbmEwR1Zm?=
 =?utf-8?B?QWxxWmJ1UUZBTHVCMCtJUE5XNnFwRktIcnVPS1V4dlpZVVIyWjA3NDhXNEM0?=
 =?utf-8?B?WUtpSWFRSnUyNUtBTXhPVXo2N0VGS3F2RkNqcnZPOWZnSWZpMkl6MGVqOWRZ?=
 =?utf-8?B?aWF3SSt0ZkxIYjdOSllMR2ZtWFR5NFQ0WmZrc1Zyc1IxdWh4RmtsSU1Fd3c2?=
 =?utf-8?B?dzZ1Qk94cEtQRTZMVzd6bTd6UDJIZGZISFYyV2gxNVZtRkZFZDNqTE1RQmNM?=
 =?utf-8?B?MXlwUVRneDFoUzZkVXFmMjlkblBhY285SHNSdW1lWGgzb0Y4SkZVOHJhTmtX?=
 =?utf-8?B?eVBqTzhMK3c0SWhzdjZSTThWbVl0cFJmTFpLUWRWS25iR2JGU2Y3aGtUajZ3?=
 =?utf-8?B?NVIrVDVYaVoxSjFCYnhuN2I1dEdSMEIwMFppNE5reVpBOFVuaDJBRnphM1hN?=
 =?utf-8?B?dzMraXBZV0VYcjRTOC95S1BqTW5IUnBRUVk4WStFZDJuY3dma0FTamhFVjEy?=
 =?utf-8?B?cVEyWkROVDhkWGJTQzNMOElGdVVZQzlYRFBrcFNvRzRYRnhoWXdPOXZvMG1Z?=
 =?utf-8?B?ZXNQOWt0WUlxQnVjMm5BWWk0TitRbkJDM0NZd0NCL0Z3Q3Jxek1rVFhWYjJx?=
 =?utf-8?B?YmpwSTlTc0R4Mi9sU1Y3bElXU3Z1dkRxNkFBcEN3ajhrYUJ2NU94cHF3cWVI?=
 =?utf-8?B?UllKU2FKTk0vTloxR3ArbFgyTUZJUjd3OC9vU3dzR3AxWFVGaDk3T1JvMGdj?=
 =?utf-8?B?Nys2b01NRmt3bU9OS1NWK0cvR0IwZGNtMGk1YWtYMXJWU1lCN2I1L1ZjRHZ0?=
 =?utf-8?B?dlVmTUFqb0ltTlRlZXdmRXFtRWM5cDJNeDhSUTU2c0xPNnhHMXBvRm5IVVVw?=
 =?utf-8?Q?nqY1ma?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVpveVlKS09lbkduZHY2enhRVmlIV2VMeDNMejdub1dOdHRtZXRWcDFyZWRz?=
 =?utf-8?B?bFdHWXFkMHFIaE9ZSFhpT2x2Q1krdEx0THlUbFdiUzE0Y1ZHRWlyL3V3UjJq?=
 =?utf-8?B?NG5JNW1yQ3VQRVpGQXlzV0pCVkpPWmtWODJSRzdtVHI3UW5lSzQ3MUxHaHlj?=
 =?utf-8?B?ZmlHNXo5OFZKanQ0ZXlJaXM4THpzMm80dnB2Tldmbk0wSlBTcHhoTVMrZTVO?=
 =?utf-8?B?UmdEZGpLMTRlTU1vS0xvTkxRMnljN2hHcWZ2OWFGKzY3aUEyQk11UHhKem8r?=
 =?utf-8?B?UUNHMjhENWZMeGsvTWxhOXh2eFlST0Qwa0dFQ01FdkJ5cHY2RERhVWIwQmRG?=
 =?utf-8?B?TDBGRUdwQzI1MnQ4blJUc3lyUzM2T1pKY2Q5SXo5M044YkNSbk4zeHplUHlU?=
 =?utf-8?B?K21nWEdyeTBzM3RQL0o3NkthSzZCd0JrWE94WEVkZ0doNWQ3NW9yenRCcGln?=
 =?utf-8?B?cDhKb01WNGtYOThsLytZelhQUXJtbUxpUWZuY2ZoYjcvRjhlWFV0Y3lydFFL?=
 =?utf-8?B?am1vQnNnZTJ2K0gyMDYrblFMQjIzeW9RU1NzSGhxTFlwQ3RJajdUUFdPVkZw?=
 =?utf-8?B?QU1RY2xDUUJ4RHUyaFZBMWlZejc2aGljVFhDR2NWYUNrRGZIMnRFMEtqaHhS?=
 =?utf-8?B?eTJtNzNUV0ZsU0xtUXRHM1JHMjh5OHB3NzJrUjF6VXZtMlFwSEJMbnJTeXNm?=
 =?utf-8?B?RlJtTllNNE9rd00zSzhlaVg4T1M5azU5dHNLc1pRcmVrQnozNkVhZjZWM3d6?=
 =?utf-8?B?OTlZV0FDSWxrTnIzUEVkVDhseDNnMGIyK1R5L3diem9wcWRvbWNkTG9KOTY3?=
 =?utf-8?B?N1VzZi9oN2NwYXEvSTZzUWxVOUZhbjJKRlVXRUl3SCtJbGhOY2lqYno0NUpu?=
 =?utf-8?B?YkM0eVA4TnNTMWpweWE3dXZjdWYrMW9XWWxGbFFmNDN0YTdQZHVFVm1UVHZO?=
 =?utf-8?B?MllnbmZZcGJuR1pWQVdjSkhKVWpxK25Mb1JwaTAvZjJIa3Jld0ltQ0xreGtB?=
 =?utf-8?B?bmFjVkdobi8zaUcxY1VzaHpLbHBjb1hBaDV2NnB6b1B5YXZjbGtISWFOS2Vl?=
 =?utf-8?B?bTNIbWZPMyt3L2pVcUQ0ZFMwcnpkb1p2ck5JTHdwUWVrSncySkhjOVdVVkNC?=
 =?utf-8?B?aHptN0dKT2E5MFlkakNmeW5CcjM2bktvQjhBZDAzUm90Tk1YK3VkTDJUR0NS?=
 =?utf-8?B?YWFvL0N2NlNiNkJBSFFtQnFGaVlXM0toU2NTWFFxSVBxNzZOVnZTRy9vaTB6?=
 =?utf-8?B?cnBVT1F0dDJDTGtVUzEvdXl0WU5SOTdvT0p0WTBhWWZMUHJmb05ObHZReFU4?=
 =?utf-8?B?dDVPVHg1RENzVWdoY053NERVd1JQODVLUkRXTks3SHBEV3lrZC9kMG5sMjdI?=
 =?utf-8?B?eGZWV29VYjNmM2NjbVNmK3ZrZTdVQkN6bE91ZC9YNjJCQ3BIMnVyK2RCRzFL?=
 =?utf-8?B?NGtIV1FLd0xFcW1MSi82bzZEWTducEtWdVJEdVNNZm02UEpSMDc2bTF2L1Ji?=
 =?utf-8?B?ZTVPaUx2S253ek9kTllOTzJCSTU5TTkzUHdrUU5mWWQ2Nm5Fblc3eGlMeTkx?=
 =?utf-8?B?a1BwM1QzSllOeGYyUzlidHFFOFVDazFFK2t5bE1tand1VEtERmRDYjB6Ny9M?=
 =?utf-8?B?dnNZUEZhV3p2UXYvdjRFVE5CU2JVSThZQlp5Sk1TSkROaXVKMDkwUkQwTC81?=
 =?utf-8?B?RFFVTmVXYzV3T0NJQkl2T29GaHJsZ1dxUVdrR3EyZkxaYW83NnExaFd4a043?=
 =?utf-8?B?ZEpWN2FtUlVaUWNRb0RLdVlSZlNEUHZUZXhRWTBxTDQ4UkxOWW5wdHBDR01R?=
 =?utf-8?B?VGN1YmZHSWhhWHZJWGRrYW9RUEx1eUhrVnJMOUZsWjh5NXlRVnlFdzhsQlpj?=
 =?utf-8?B?ZFlrYTBBVHVpaC9JNkhyUkJaWFhHSmt5dDJGRTVVQTFyZmhxT21LQ3JkUWdU?=
 =?utf-8?B?Um8zVk0vb1NQRUJPMlIzbUJvNnJkVGQyMjJId1Q2YkovcTRERzYwWlV1Z2Mw?=
 =?utf-8?B?N2ovRmZCSkgxV3V6MllTK3o1eUgwaXk0WUhoc0drUDNYSGw2d1VLNjRJRHda?=
 =?utf-8?B?aXdhUEoyMVFEN1FiZmVGSGlCY1pYSjQ0MVpYTjhjeURCTDhHRUVvSjJQeWU3?=
 =?utf-8?Q?X+FcB+W4e3ubTMSj3ssi5shA8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bc952d-79e3-4055-ee49-08de3a7a2554
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2025 19:02:21.9851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkjAaEk1r8MJSfw37m40Brb+DgbtVTl6GvXa5reV/ytue+6N73Qf79YLGXhH/uIShO+Dm4SmNcrUGKMMhqaPGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6161

DQoNCj4gT24gRGVjIDEzLCAyMDI1LCBhdCAxMDo1NuKAr1BNLCBacWlhbmcgPHFpYW5nLnpoYW5n
QGxpbnV4LmRldj4gd3JvdGU6DQo+IA0KPiDvu79JbiBzb21lIGtlcm5lbHMgd2hpY2ggaXMgc2V0
IGNvbnZlcnRfdG9fYmlnIHRvIFNSQ1VfU0laSU5HX0lOSVQsDQo+IGZvciB1c2UgdGhlIGluaXRf
c3JjdV9zdHJ1Y3QqKCkgdG8gaW5pdGlhbGl6ZWQgc3JjdSBzdHJ1Y3R1cmUsDQo+IHRoZSBpc19z
dGF0aWMgcGFyYW1ldGVycyBpcyBhbHdheXMgZmFsc2UsIHRoZSBtZW1vcnkgYWxsb2NhdGlvbg0K
PiBmb3Igc3JjdV9zdXAgc3RydWN0dXJlJ3MtPm5vZGUgY2FuIHVzZSBHRlBfS0VSTkVMIGZsYWdz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZy56aGFuZ0BsaW51eC5kZXY+DQo+
IC0tLQ0KPiBrZXJuZWwvcmN1L3NyY3V0cmVlLmMgfCAyICstDQo+IDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9y
Y3Uvc3JjdXRyZWUuYyBiL2tlcm5lbC9yY3Uvc3JjdXRyZWUuYw0KPiBpbmRleCBlYTNmMTI4ZGUw
NmYuLmU0NTcxYjU2OTc1MiAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3JjdS9zcmN1dHJlZS5jDQo+
ICsrKyBiL2tlcm5lbC9yY3Uvc3JjdXRyZWUuYw0KPiBAQCAtMjYyLDcgKzI2Miw3IEBAIHN0YXRp
YyBpbnQgaW5pdF9zcmN1X3N0cnVjdF9maWVsZHMoc3RydWN0IHNyY3Vfc3RydWN0ICpzc3AsIGJv
b2wgaXNfc3RhdGljKQ0KPiAgICBzc3AtPnNyY3Vfc3VwLT5zcmN1X2dwX3NlcV9uZWVkZWRfZXhw
ID0gU1JDVV9HUF9TRVFfSU5JVElBTF9WQUw7DQo+ICAgIHNzcC0+c3JjdV9zdXAtPnNyY3VfbGFz
dF9ncF9lbmQgPSBrdGltZV9nZXRfbW9ub19mYXN0X25zKCk7DQo+ICAgIGlmIChSRUFEX09OQ0Uo
c3NwLT5zcmN1X3N1cC0+c3JjdV9zaXplX3N0YXRlKSA9PSBTUkNVX1NJWkVfU01BTEwgJiYgU1JD
VV9TSVpJTkdfSVNfSU5JVCgpKSB7DQo+IC0gICAgICAgIGlmICghaW5pdF9zcmN1X3N0cnVjdF9u
b2Rlcyhzc3AsIEdGUF9BVE9NSUMpKQ0KPiArICAgICAgICBpZiAoIWluaXRfc3JjdV9zdHJ1Y3Rf
bm9kZXMoc3NwLCAhaXNfc3RhdGljID8gR0ZQX0tFUk5FTCA6IEdGUF9BVE9NSUMpKQ0KDQpOaXQ6
IHBsZWFzZSBhdm9pZCBkb3VibGUgbmVnYXRpdmVzLCBiZWNvbWVzIGEgYml0IGhhcmRlciB0byBy
ZWFkOg0KDQpJbnN0ZWFkLA0KaXNfc3RhdGljID8gR0ZQX0FUT01JQyA6IEdGUF9LRVJORUwNCg0K
SXMgaXQgYWxzbyB3b3J0aHdoaWxlIGFkZGluZyBhIG1pZ2h0X3NsZWVwKCkgaGVyZSBmb3IgYWRk
aXRpb25hbCByb2J1c3RuZXNzPw0KDQpUaGFua3MuDQoNCg0KDQo+ICAgICAgICAgICAgZ290byBl
cnJfZnJlZV9zZGE7DQo+ICAgICAgICBXUklURV9PTkNFKHNzcC0+c3JjdV9zdXAtPnNyY3Vfc2l6
ZV9zdGF0ZSwgU1JDVV9TSVpFX0JJRyk7DQo+ICAgIH0NCj4gLS0NCj4gMi40OC4xDQo+IA0KPiAN
Cg==
