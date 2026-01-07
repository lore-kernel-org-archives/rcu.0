Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F18329E64;
	Wed,  7 Jan 2026 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767811497; cv=fail; b=sfuDDruCjEelz51Tfy5iKHKU1048cTrqRY/CzUemdpzjxnYfXllszK72v+ZXCEKudTn7hIpKRkfA3lMASergAA7XEAiv3ybFkFDrMV/erdCROYe8kbocYfiLU/pIPG0VDCzrPx8paO9sWqjUfpPJvtTu19Mf+U40c2RrsH2VF/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767811497; c=relaxed/simple;
	bh=8b+QouKBnL34N4LGB+JNLkCeo7RIOuGXuyghTeg4aTQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=okS1bm8TwFMDtI+iFp96YW6EOXbNeA/xSb2O6G+IomDtXMDt3BH8ultpcJEIQnbZ0656fp41E2g9MYsxv+//kMzNKUH5kkVjQwlt2a3kXXkkFyTm6+0pHQhQbpDRvtuZTxAmeWNhl7pmh9gMXU/RfqNo2EZWx+Lue5xu4M9J8UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PTVsnduG; arc=fail smtp.client-ip=52.101.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PTVsnduG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSljjbnMpnLtFqWwr1vfH+GYy0U9eJ/oB67dVYZ6u3RkH8yYWClEX8Bk8HOcKi+IJ1vsxrxg7FLGa74zVR6Wq13AbHhX/HqtSdvuNM2Wx5YEM9np+lAWf9A3xy0kHJvq5G/YJ7+uwqKeHK1AicRej2jo2NAKBxDEB02AKsiAh98Lg1pCl4HwO+MpiJuU7Mk8Vf5jufEGMfsquRpSztyOMqhU7EkojMxvI5lGe4ckHKfjB4xFgOMG2bMZJ8GgHyDBnXPY0XLP4kPwQWtX2zNhcMl6POL+KV+4TLyZedPaghQpRTo8DdBAmWOL5CDK0Jt5X117fdtmWZDVNUSKd9UcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXX2viSnFDplfJMzePd341JYpBBWynhjAviTEMmlscc=;
 b=xV/BQSgc4KteVG9dlb7eg67ppRSj3B7I5vVWWi5ZxrLhkvnPUtrWbJfvfAc/WJFy/VZdcPy3jFTUYnS3AOgElQnydKhmCeuQfq9uPFzse8oRFQsCDfyvaHkx7pJv6NbYE0DdW5mKj81X6cWNvao++SMdEwT7G542eUV4g01izFNs8s7rCn1SaM83SPC/PSdaibKsgt6LuvhyT/isDJTGA6cHaXYvCgyVnqnPHHTRL4tBSOXsKo0zqxtFFEuEP6zeyHRYOO1HXh56n3SZ39I38oRXfdy52O3SeXO++XXr6UN4OJ4EJGYe/Haobci5z4582at6NUohwD5M/lqlSRlvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXX2viSnFDplfJMzePd341JYpBBWynhjAviTEMmlscc=;
 b=PTVsnduGNWN3NZ/zbaeeT8Xw95OlgS/FQ2pTwZYGqrBhE07SSJEa+ZsBN9CqohjMYy3hKhHMp+SbSC3UzXZSIphtMjI66M5VbijFeNMDuDESNrOi/UL1uyLy4UUU96+DA+B9Qs0aQb1vb3DJybx0kUq0DWtgFzpbriKQNVogtzjtjkwDCXX6FTOYufRjUV3fKEXTTzjsrnSS0vEVBApGPVjU5RmFCXghDzDU5VwWHdWifkT9DioYSPddkJUl6etB37PDKfH4Psgd4IRTTGKDeBCIXL61CDqysXDTd8Ue9X3If0VB/4DfVSRcEV3NgHrEAZtjKfMh1So8eE+Ctu78+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 18:44:45 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 18:44:45 +0000
Message-ID: <2efdfea8-5be0-4334-9906-61103888e873@nvidia.com>
Date: Wed, 7 Jan 2026 13:44:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update email address for Joel Fernandes
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, rust-for-linux <rust-for-linux@vger.kernel.org>,
 nouveau@lists.freedesktop.org, Boqun Feng <boqun.feng@gmail.com>,
 Paul E McKenney <paulmck@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Steven Rostedt <rostedt@goodmis.org>, rostedt@google.com,
 Yury Norov <yury.norov@gmail.com>
References: <c5c5c0a4-249f-41b0-b5f1-87a58514b120@nvidia.com>
 <8822A0A5-CD4C-403A-A001-F4E7A351D81B@joelfernandes.org>
 <CANiq72mUCGL3f=GAYSZfMV1=NXpOjz4vsV7B3Pd-=EG8tmWC_A@mail.gmail.com>
 <39e74621-aba6-47eb-9935-0d2321c56d6d@nvidia.com>
 <CANiq72=vcYkfZtgDfSZaHY=0PMOwc+XiiJo74pciPOV7nrN6Nw@mail.gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <CANiq72=vcYkfZtgDfSZaHY=0PMOwc+XiiJo74pciPOV7nrN6Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0020.namprd22.prod.outlook.com
 (2603:10b6:208:238::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: ed625571-5c71-421b-044e-08de4e1cd3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czVTYVIwWERicHNwT1VnRUMzRVpNMW5zdEdrOXYxK004OFg3TG12UGdjcE1s?=
 =?utf-8?B?WGNhTW04Z2pJNktUUFpGM1lwTGxGdWo1MldtS081djhsYlVCZnJBNGlscXZr?=
 =?utf-8?B?NUxWdVY5elRWOHBjR0V0S2FQQXQ0bXJPZmJ2N1RSQVlkTzlORkZVYmdXVmRR?=
 =?utf-8?B?ODNFYjArZUtjN1VZMUlXZnhadjR5Uk1yQVNBb0krWnkwM0RRVzF1MTdwZzBZ?=
 =?utf-8?B?LzVSRHFGL3FTbTRXMGFibFRQQ0VxZVVVMHRjSVpZS09FSndFSFVEa1Y0dkpy?=
 =?utf-8?B?Yk5vZ3Z3b25MWHIrR1M1WnJGd3l6VmdZYzB1STZ0Wi9FUll1bENLbFpkRUkv?=
 =?utf-8?B?VXNNbUJXbTFpczlJeWducjlPNDlqeUgwWmxtblExdWM4VG5kdlFlUXR4TlpH?=
 =?utf-8?B?cmhESm5LUjVtYlo4QklFaWt4cFQzM2JPc2k5cjBxUmVzU2IzUGpSSnBCSk9v?=
 =?utf-8?B?VEgvQm9PTDhidXlReE9BTmtOcVBqbTlDdzFYVDdXaDNjR0ttOHVkUUhaWDAw?=
 =?utf-8?B?dGUwZXVEOFpwTjk3c1diY3lsa2phMldEcTE2SjJHOTZzRGEveU5NbWkwZTBX?=
 =?utf-8?B?ajFyY2x4YjZ1SzBKb3Jrelo0UlVIeFlZaWdyTWk4cGdwRWFDeFI4N085Z0FP?=
 =?utf-8?B?RXI0Z2VnazhpbEtSSjVJSUszc1dDQzNuVGtQMkdwU3EzTFc3dHNId0ZjbGlT?=
 =?utf-8?B?M0g5WTZoUXViRXRhMUNTRzZwNHBlYzlnYStwSVZkeHlKVUtvVndoWnBucEww?=
 =?utf-8?B?bytKU2MyOXVJWkt0RkVaMk5DMlVEL0NiSzlxaXBEK28rWlJnOWdEdy85U09H?=
 =?utf-8?B?dXNERU9OR09pcGU4Zld5RnFqWTRVNVVBNXlwY1Y2Z2R3UzRsODRnUjhPVkFC?=
 =?utf-8?B?OUppNTFsb1RPd1Rtb0tXOHF4MmtlRks2TzNHTk9HU05Pdlg5NkxMeGtWU010?=
 =?utf-8?B?dTJVUE1XQ0sxVVY1OUxSQ1MvSlVlWGJ2UVkxS1pOK01Xayt0SW5YQW1aenY2?=
 =?utf-8?B?TjBUR0NvdHNMQ3RmV0RvNW5BSUlpWTJSL1hwWmhNZUdkdU5oS1ZjVC9mU0ox?=
 =?utf-8?B?T3BQRE85SDVUb3p6a1g3T1poSzlRVVY1Rm5WY2xIa1lrdS9zVm9wekhmUGRB?=
 =?utf-8?B?ZFdmOHNCa2huTmdlenBob2k2dTdjWUs1ejZodDZlZmNuaEw3eC9GaUdKaVoz?=
 =?utf-8?B?QmJtMktpRjZRMWFSZXI3c3IyS1FUWldiWmVCTjJzcTBqRVBnWWp1ZTNYYWdC?=
 =?utf-8?B?RkRDU1NNQTFjT2tjckgwWWNyWklnUjVxaXdrU0MrK0UwbHkwK09Ec3dFTThl?=
 =?utf-8?B?c0V5VytHYVNrY1l3REwxaE90aUhNTXpSZ2ZxeDkzcmJWMVVpWHFpUlMrYzNo?=
 =?utf-8?B?VUxYSmZNQU1mQUxjUkdGMVZZZE1kWHJFOGdxYkF2QTR5TVV6MGUwQU9LckFG?=
 =?utf-8?B?T2RsSlY0ZW1VYjVQYmN5R3lnRUdBTmcxbHBlV05KZ2ZiSng4b1k3cFIvVkdl?=
 =?utf-8?B?RG1rUU5Ha21wQVRvYVpWWlFibzkyUnZvdnhMRkJkM0xHMjNhRWx3aWJNUS9F?=
 =?utf-8?B?N0lGN0Y5MkVQL1RKWEdWUFMyRFFpSVJQS1ZKeDBJRGhQRDRxOHRERHBqMkhx?=
 =?utf-8?B?TlI1NXM3V3NEa3FGbEZVT1lzbGNEM1RsdSt1dzFCYnR6S3MyeEFoQnFXY1A5?=
 =?utf-8?B?YzR4TVhxSXZQWjVNN2g2NndwUkRTTFhLeCsrQ2hRL2xWOEpiWUgzV1FqelZE?=
 =?utf-8?B?aDFVU2hnNmZvdUdOcTJaUTAwZlJSd3FvZTU0cTRJM1lnem5pR2J1SS9Odk5w?=
 =?utf-8?B?NkFjbndrMjJPdStKdk5xaUpiWm9LT2cxeTFvT29Ja1liWFJVdGdhWWpPOTIz?=
 =?utf-8?B?QWJ4K1lrYm5sZ21ZYWc5TkU4cHF6aGpneUhJYmt2VFBYSk5ZL2NoUGkxOHpr?=
 =?utf-8?Q?Ha0XfytSIcreuitkoEUN1rIxC2dNnR/y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aitWQU9aVE9GUGFqSWZoUDZPR1pSallJZzNTaTh2a241dzZFNnhJVVBLZUVq?=
 =?utf-8?B?Ryt1elJUdG1wNUVaZUszdnhhOTQ2U2gxaGVWMTR4SWVtMmVCR2Q0RjRQYjlI?=
 =?utf-8?B?blVPbVg1RUNrM0ZqQ01EckYyUTdSWDVsT2R4ektQdVlCTnVKWjlsZEdheWlC?=
 =?utf-8?B?QWRTdkV2ay9pUElVTGxwMTBFL3lOMlJmaGdwdVArSEVWeXVLK21wMGk4R2hJ?=
 =?utf-8?B?TTdzdy84QnF2ditFSlU2bGl6ZDNYWTRoclBTSTRNaDAxdklkOHFuek5peDBI?=
 =?utf-8?B?OGp4SkJSVkIzSXlXcHNrSTdYSm1pVE9ReitkWmlSVTR6STZxS3VOM0MvN1Bo?=
 =?utf-8?B?blQ2YVlFVVgyVWhQdnoxd1pKanprZ3hlK0Zwamp1Zi9rWFhhNHk5YUxLL0p0?=
 =?utf-8?B?QjlrWUwzY3dqamFTN3p0RTR2TnRqQ0pjTUw0ajEvM1RHTDZRTmdhaVZmYUZh?=
 =?utf-8?B?ZEwrQTR2RHg4alJ2c3B4eEVVcFluKzRjS05FM2hTcHpOeCtIMWFLMU5nN2Nq?=
 =?utf-8?B?K1puSENpdlZYVUx3a2ZQQlc5cWg4T0lyOXlZQnZWcWVZZ0NndG1SVG0xank2?=
 =?utf-8?B?Qms0bkFiRTJONGRTT1FMYloyS0laMzdmUlRLTEVUZjIzTG1IWWx0eDlTVlNI?=
 =?utf-8?B?YlVkODllSEMxKzBZK3Zpc1F0eXo2SXR0d21zamhOUWxGZzlYZmd0VWN0RFox?=
 =?utf-8?B?Z0FxN3dBeGExNDcza2lNZjNZajdmVDFscFpVTEszK3ZCdVVMeEVGNTZHQ0tv?=
 =?utf-8?B?UTJkNTgxZXpUZERnVGhoYW1SRXFwR0NjbE5KV3U2MnQ1MEJsZVFLZklvL2U0?=
 =?utf-8?B?VTVwa2xkM0x0ZW51UkZwSTNadjUrZDNEYnI5MUJvWjJud2V4RVE1NlRqUCsw?=
 =?utf-8?B?MGRWL2hHZWMwekd6OHlBbUhlVjJJWXJDZXVMdU1UaUdXQUNZZjJmUlR4YTU5?=
 =?utf-8?B?SUpqbzl6N25ZMWRnMXZmdVo1VTJoL0g3V1Robml6Zkk3NkdETjMzb29lcnhh?=
 =?utf-8?B?RE9FQzY1UHBCRFZIZVM1Q2s2MjAwbmtkRlI5YmtVUU9ldkdaR2xHTjh3bFBB?=
 =?utf-8?B?TEtOQ2JqMlJrVUQya3hWQ1RuaE42L1BSL1U4UlAyaUtVa1RCemJRcFhJMlBV?=
 =?utf-8?B?eEJPZUhKQ2V5a3hSajB0d3IrS29XK0lheHQ0UzN5VHlLbm5WZ1V4WHRCOFJW?=
 =?utf-8?B?dzg3bjFSWVJZRzBHa2JMd0JGN3JFczBIYnZjTkN6SE5lN285S2x3ZjRRemF1?=
 =?utf-8?B?djd5Yi9UZkZmbytMTkR1VEM1bzZUelorcW8ya080VkpCWFV5Yko4VVVNRjM2?=
 =?utf-8?B?VUZLc0dtLzk3cCs0V3IzcE1vQVVmQkNYZmcyT1dEMjVlTTByQ2EwT244cnFN?=
 =?utf-8?B?RDlCL1FrL2FuWkZjY2FNWDhBRnBzTGNIeGJtSE51dDVYUG91a1lMUjc3b2Rx?=
 =?utf-8?B?MGJtaXJ3SWRhVk5jLzZoMDMzd3h4NWk3dUVJT0l0bW15R29QVW9pR2dTVCtC?=
 =?utf-8?B?SFYrbjNtK2Q0bHBJcGJnQzZESFJaT1RmM3NldWNYRkdsR3ZzeWhTV2Q4OXZ3?=
 =?utf-8?B?NHNOUlFRK3NFZUFzeWN1c0VVOUcvelcxYlZqcU9EWVFwRWVQRTg2SDcxYmtT?=
 =?utf-8?B?WHFiRzFxK3o2Tk9uRWxTRzV6TGo0VGhOK0VHSDAzQWp6UnRMVTdjeEVSSjlS?=
 =?utf-8?B?S1k3Z1M1UEZ6WlRBbjJWclRkRlhTQXIzU29BSVBNZndUL1RQK1kvSHRlbnRj?=
 =?utf-8?B?Y1pjeURINng3QUk3RS9FR2FVcy9lTGIvQWJGMnlPbk9TY1BvQkpwdWo3UHpE?=
 =?utf-8?B?ZGVaMnRVRWxLclQzcXlGd0FIVk5pdUNlb0NJclh2VzdWaWwxbzNITUR1b0Fz?=
 =?utf-8?B?U3BkblBWSldRd1p5K0hlTWxFU2UvNURuTm8vTFV0Rjh6VGk1QlJLb0htazIr?=
 =?utf-8?B?TjAxNzdDcXVBU1dGWHJjeWFqaXZBMG1lOG1La2Fxc0xjM2wySXVtSGdBSyto?=
 =?utf-8?B?bklYbUgwZmd0ZC84R2VKN1NTQ1Z0NEtJem5WeS9JeE4yZ0FGb3o2dWZYUTNU?=
 =?utf-8?B?WmlNQ3pPamtmcmtkV0JTbUdsNXhySHVNejdYNWx5aUg5R3E1cGpQMjhPaTIw?=
 =?utf-8?B?VlpCVmhpcnUvbC9uMm5sZzZ6R3BLSkJDVVMrTGpta0h1MWE4MnVNNlFSUVFz?=
 =?utf-8?B?SldHa2dXMkFDM01RS0RqSDI5d1Brem15c1BjdDI4ak9HbmU4cmd4aEkzMTBF?=
 =?utf-8?B?aXBRaEhpSzNUc2JvMWtMNkpMbTVCRWliNkF2WG0rWDYwbGtyTnROZHV1cXdM?=
 =?utf-8?B?WFNDSVRkdXdiMjhJeExKRFN1RE5XTEFWNmw2bVFJSEFJWHpaQW9IZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed625571-5c71-421b-044e-08de4e1cd3ad
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 18:44:45.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SL2BiE8rlBg6Vy3pycUKJvQoevHlyEYWiGoc4vic+mlmlZJQ+qsgYgx6/VdQM9kmZjB/ogr9+OVNo6iNhREBHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648



On 1/7/2026 12:24 PM, Miguel Ojeda wrote:
> On Wed, Jan 7, 2026 at 6:20 PM Joel Fernandes <joelagnelf@nvidia.com> wrote:
> 
>> appears to be resistance to both these. I do feel fortunate to get company time
>> to work upstream, so, on this matter, I have to go with the company's
>> preferences.;-).
> 
> I suspected that given the thread... :) But happy to sign your key if
> you need it in the future, and happy new year too!

Thanks, I appreciate that! Happy New Year again.

 - Joel

