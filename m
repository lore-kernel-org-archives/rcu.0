Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC605136349;
	Sat,  5 Jul 2025 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751748118; cv=fail; b=hgd7DuxWbiwnX0Ep/cb7pbYifB5U50yhHMRbIbDYKbwQmm5ji04BxT82x44D2SEX33YSPnFDHkVPFMAbDwPsR9uC2dt5k728yyUIY+06J9tE0LrlJ/3S0itdyeBdeSiaqOXr/QJGzYjMAsNwQXFp36BNtOpXPryb2o7vQh9kCSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751748118; c=relaxed/simple;
	bh=U5KWgpyzhUMVpVEHb4Zr+HQQtHDAo9fLi4z8pq1dawE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aRSeb7/bVrtZs5Jcbx72ce88vrcdQCInw9aI/BG7rjJMc5kEd6D+ohJEVlSzMKzdDtCdtoR3Llj4AuPyXTTOSEyWW4HWQBoSKy+iiO8kBLYguX+rlG0g11D4jMbWDHVVCRT4PI6aWXXOhzctecoA3ATB7rEvLwUhoEiuLf7T7jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XmUC3GdX; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XmUC3GdX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QctgSm18Fmg3SagXuWmixY8wILqkruyPaSWWOLUFwMWJHcHPx0srxbB14VQoZkyvGQ6aGkR80PliMy5ObTJroHe0GIiANQKKJ+tETPpGEEcx2O94yHhMsnxqO6BhZ6ONEcukagPcC6h4s0ES1WIbpJxctoGqOpYM8UBuQPLozXKUbBTLVwPwIcFGScclCWNegJhkNgLXIJyjO25Y0grOIacCoit2JNzuPi8z5YVNbSMYFldjS8gdIK4Z+ctkug9qJIkpROABJuBnBJmwgntxg+2NwCHQ9+AGYsykmuglnuQdAiV7WICZfpTP4YcnMwy7YFEGbdpM0Uk0+85REHTmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SF7OnRAOpRnFUOs7a1OkjwLWti+zM6IcPdNT8+9rby0=;
 b=P4QbSbly643S+CJ9id/NLfy3aj8fNOBc/gAECX0+agNau8ghoCvx5E0f0uyi495dGSoctKtNsxq1J/pupMKKS/RqBO9EnRCZg2AN1QLzrxX7/+ZzsRgssEGhoIgMfch74feo1R41U4SmrhzsrJccluKuEnbvT9F40vqQwatfSKVg6v3HniIjjWgUvOF8MUi+32e5iQOano5roUrk27XUGfRjDlMIJOccQFwFZVyMz+KNoupRx+knU5bsaLimbAKbqPBJZhkeFkgeyS13tL5lukYVZHaQMDDjn+F0YXilaG6/Ohg8UR7+wInNtX8uguxflrVS7JBG8nG5QcTrnDDTRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF7OnRAOpRnFUOs7a1OkjwLWti+zM6IcPdNT8+9rby0=;
 b=XmUC3GdXcuzItDdfikr91LkD3SL1ULtskbmW0uScXqg03VL2qtWP7A0+tJAVvgXrSlUYoJIUCzUUhkTyQKCXzM7YwGF/XlIJikl80Aqz599EsjZrDqRcJLuUiGmw6FWVCjCb+0w56DN//r8XFQpetdpvSnhL2P4FIagnv3/J2FhkKIpBrS2lj7nHJMnigdBctEilm0DViykfU+Ht2mtq6TEm2t9cGzhhaEeDn3uv0WKhMghpoPDUkJzANUCm5RU4qxUMT9JKL8e96juTQpIT0xDtCCDxZivmvEMNt6eT7n5j6fLnizn5ZQ0LocLqFVlGBz59eOZpi199FUnFyDLTaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Sat, 5 Jul
 2025 20:41:54 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Sat, 5 Jul 2025
 20:41:54 +0000
Message-ID: <b27302ca-c8fc-4d5c-ac3f-1de957d0f707@nvidia.com>
Date: Sat, 5 Jul 2025 16:41:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] rcu: Fix rcu_read_unlock() deadloop due to IRQ
 work
To: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
References: <20250705203918.4149863-1-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250705203918.4149863-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0067.prod.exchangelabs.com
 (2603:10b6:208:25::44) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f062942-da7f-4614-fe44-08ddbc0460a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cThaRnhuRElDT1AzMFJzejFFM2lnQmxDcndYWkxTT2FUbEpvbmN2SUlheGFp?=
 =?utf-8?B?ZktHU0UwcUVoZWwzM1lsYTFDdmEvYlhETC9TWmI5eG8xU2R2MkwzbVFReC9s?=
 =?utf-8?B?cEZFQ3MxR01JbTQwTDRSdFkxdnhDcy9GcnZuUWxzOXdWZ0xJazlJQWpDdURQ?=
 =?utf-8?B?SWZrZ0dtRTYyRVRXZWM5Sk0xWmVxR1dmUCt5cDFXcGdKS25yb09obk5veWF0?=
 =?utf-8?B?YjNaYUIxWTBwL3U2dDZOYTRlWFErYU8zNzQ3YURvVmFOM29tczJMQ1BFTHRG?=
 =?utf-8?B?S0ZqUXdNQlE4dS92TllWNS84OXoxSkNVRkQvaituZlA0UC9SaENnOFBHNWRC?=
 =?utf-8?B?MC9SYlJidzdodExVR0I5SzNjeG5RcTFqNzlzUk5tWENheXdreFhjcTZ3dXJK?=
 =?utf-8?B?RmxaaDVLT3BteWkwcGNCQ3lia0pXNzVCMnFKeGU3ajJNYWpNYWZUdmg1RktW?=
 =?utf-8?B?RlpLRFhPdEFoblMwRlhUcFFtOTNrS1F4Z0ZtdUlyTkdvY2NoNlVnQTVzMEpI?=
 =?utf-8?B?QlRVdnl0ajhPRUJoVkZ3WnJoQXZrSktHVThsUGJEanMxSXBWOW93V2dvT2tx?=
 =?utf-8?B?WVR2OTg1bEt6bjNWbnVJTE5jUFdlTUJLOTJYSERCNXlTMDNra29LUU05L0lW?=
 =?utf-8?B?Qy94RDdtM1JPSi9DV0N2QThVK2JuUGVEdzRHMXZQWU9RSytSODY1RFBwdVdN?=
 =?utf-8?B?TUZoZjF4OFVnN2JDMDhMVVZrOUNZdERXQWUxT3pRNkV2QUNGOEY1Zy9Sa243?=
 =?utf-8?B?L0ZPdFFKTERIZUJOY3M5akE4TEN2K1dHTWI3SU56aTNnZXY4SzJ2L2J1aExr?=
 =?utf-8?B?RUZCQVIrY0E1d29WWFA4UXJsMG9NeHFpVGRrdEd4VUYyV1dBcElzenFuTElx?=
 =?utf-8?B?QjN2ZzVHWUN2a2k3bVRzQlg4d2JLRWNyR3FZYzNTWGdFOGNTQXEyNDZSeFkx?=
 =?utf-8?B?bmF2VjJCeTl1U0ZJTVVURE1LbjB0OVRlKzhJa0QzTmU3anVkTXowUUJUemxZ?=
 =?utf-8?B?bjIzUTNPWnc1aDl4aVAwZzJRczZ5OWszNG9jUk9kV0RpSDF3cjRSNmNQQlc3?=
 =?utf-8?B?QWIyb0xScWJJUnBHSjB4OE8rcm15R2NUNWdVMGx0akxsbkwzOWE5ekdjUnM3?=
 =?utf-8?B?WWRIbi9mc1pzd3VhMHl2RXFFQkVKUzJZc25NZVdCYi9IU004aTlLamd5Q3J1?=
 =?utf-8?B?ZU9NdmJZOSt5c0VKaGtiblBVMG9JUUhzdURkSXZXczFtbGVJWFp1dHBOZHly?=
 =?utf-8?B?VGlHd1ppNEFXYVp6OWQrRFlMdUJnWlE0UmdJY3JWTHZ6UG9qcTh4NkdKR203?=
 =?utf-8?B?UXlmNGpOcDN6VllrSXJnMXBQVk8zbUVRdHBVTnN6QXFnRHFuNWNUMm5hemdq?=
 =?utf-8?B?Mm5pYUpoeWVDL2tSaFJTU2JGT3Jia3ZTVFhJcUZFYktrdC91M0dLbWE1dWpO?=
 =?utf-8?B?Zmp0M2Y5cmRBZUlGczQzQkpibGppZjI0cE44OExvN3gwK0YvMEwyUTQrYUdM?=
 =?utf-8?B?YU92M3pyRzEvdFh4QmpzNDdRR0M2dmNGSjMyRW14b3E1VEt5NGVrazNrQXZK?=
 =?utf-8?B?R1ZIY1JUWVg2N3d6U25mWll4aDExUXJteXZsZSttaFc4ZHY2WlhnT2ZOVWdZ?=
 =?utf-8?B?N0NnazFoNk9lUUppY2xNTFJxMjFDQmlBL3dFczdpVVhwQVd5VSs3Z1dWQm5C?=
 =?utf-8?B?OFVXRk84aHZIOTNVSklCbzBoK2F1S0laV2VCRE5BdktQYURnQTJLNWtMTzRn?=
 =?utf-8?B?U2J3T2loV1VVTjRaRzhobTgwWDd0aERHWnY1SXNUeWN1ZDBjc1pSdnFlTDZn?=
 =?utf-8?B?c0pWZFdWVWJvRkZPaEdFUnpkU0o1aEpHWDdINjhtNjhmYUI2UWp0WTlYbE1E?=
 =?utf-8?B?NWM2dXNMSHpHcXo4ZUluVEJYN0pGemM0T20wTU9HMCtNVWd2MGFxdUhuR2s4?=
 =?utf-8?B?MXorRGJpU0Jjc2xoVENKV29JRVYwOGlTRHo5bDZtWXhnYzA1TU4rVW56Q2t6?=
 =?utf-8?B?WG1UcTA3TmJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjYxaUNmU0Z0ckNVa2dyRkZmODJPMHg3cjZxTzE3ZXc5SklrdDNncXZwUjNz?=
 =?utf-8?B?WCtDWTJHbWdySWZra3JCV0Viczl3elM1blhyOGllR2VrQ3hLOUgvakVSZUNN?=
 =?utf-8?B?R3FWbWFxeEx1b0laWitINFF1VlJaV3NuMGsydzZnamR1dzRoa2gvYk5qLzNN?=
 =?utf-8?B?YmliaXYrMm9HeUlwZ3hKR3psRVczamlnZXRPY05ZSTYwTUVmVkJ6a1NWaG9C?=
 =?utf-8?B?L3hPbDYvNzF3NkRmTGNxSC9iTkZFbEtxS2pRNGtaY2tSK1FHSVl5UzdlRlI2?=
 =?utf-8?B?NFVGQjlhTjBMSjZUbEJTaXBaZk4xbkovOVF5MUdhaTZFdEc3ZVpCNFhETTJq?=
 =?utf-8?B?SFY5cmNJT0tIeWFGV1NxblFQanBKa2l3V0JNVDl3VVkyM1UxZUJPQmZ5bEUw?=
 =?utf-8?B?dWJLVCtUMWZZdURWNFN5cnhzYnFJdWdHUDJIbTV5clFVaU44TFVmaXlLN3Fz?=
 =?utf-8?B?SnpBWkliZE1mazBSOE05YWh5ZmdQVkpzcnlUczdoamJURndQMW9mU1N3Q0J5?=
 =?utf-8?B?Q3J0RDU2a1poT3QySWVzcjhCK0FUVW5XUFQybUhCcURKNy9UNVRJeGtBcE1C?=
 =?utf-8?B?bFJWRE5xNlZOQnB4SVk5dFdPNXludDRrWEkwNW5NamVzNzk5Y1lwL3NsaDdm?=
 =?utf-8?B?YTNJbnpDNG5FYjZpNzNHMEN4R3pHS3d0WHZXTE0wUlBJT3V1N3RDQ1g4QzdZ?=
 =?utf-8?B?NEoxWUJ1RjYwbFp1RllDSVI3WEhITTdkQUdDRWNXYm0xN2tBMldaMVBvSzBZ?=
 =?utf-8?B?OERONWpkd0pzOGtBNnRBNmJUOGFVblRERFZKYXd1UXFoTmZNWEVtTytaWW5Y?=
 =?utf-8?B?a0FXVE83RmV0eU1FSTQvZWtTY3FEUWlBenpqazNXLzFtVVN1K0w5dHpjQW9T?=
 =?utf-8?B?RGlCQkdpR2h6V2VQdHQ2M0NtRkl0WDJSMHlabkk3YzJucE9hMkU0UWxTS1M4?=
 =?utf-8?B?bzRyVXp4Q2tISUZPTDEwb1UwYWdlUVBjNFVzSGRZZzZOdERIYmR1YStibWRY?=
 =?utf-8?B?dHNCczlqYkF4TkZCVEIvZXZSbXl5Z3FPbCt2MXdrVGJrc2FZS3I5KzZSSlJo?=
 =?utf-8?B?Smd4Wk5aUjN0V2lKdW9IS093dVJLclIxN1BtL2d5dWk4Rm9MNk5SdjVMK1VQ?=
 =?utf-8?B?WStYZ2RmeWF1eDZBZmlRMzJtemVhUnZKdHlmRU1sWE1GZVF0bHZRam9IazFr?=
 =?utf-8?B?a0pocWYzVXRha3VKcW0rN2hPTnAzRlU4Tmo1cHcxbk5XdXh6M2RudXMwKzE1?=
 =?utf-8?B?M2RnTTNjVzREQ2wwUk1lQ1IwRG0yQkZwc3g1K3pXcWswS0lQTWdJQ3d6TEhv?=
 =?utf-8?B?SjVWQjhncVh2M1c1YzBVamU2RUsvNW5INmdmWHhhUmo4dFZZa3NyMHJmdmZX?=
 =?utf-8?B?ZHczSi9FYjdjYSt6Qi9VUFg3SUJtT05uamhUZmZUUDFZTnlsbC9tUTVqeWhv?=
 =?utf-8?B?WFZwbWJVNmt0TXppY2svRnh0MFlhSUdwdHVaUkQ4NUd4SFlMcDRLdm5TUnM3?=
 =?utf-8?B?TUpaNXhYQ0EyRmFyS0d4ZVkvTVVPNlIxc3FGNm5OUzVpeWJWU2tkdUFDOXdR?=
 =?utf-8?B?RkNvcmJYYW9RbUR5VXZpczRUU29hYWN5YlB5QzNxM3Qwcy9NSVp5cVlVTWRo?=
 =?utf-8?B?SThpY2JoUEhsSHFyRXVUSlhXSVo0UGRnTUh6eFVBV0dQSHRqSGoxSzBMUkJR?=
 =?utf-8?B?RHJQd0dpS3pJRXZkRzRkaUtSN2R4N3Blb3VMTERFYjNMZjJ2WjNUUUhTZWtG?=
 =?utf-8?B?WDliMldQaVR0MktBT2M0MndOWjI4dDFmZlluMzVjUnFFUHJ5WkYrQ0pSWTFN?=
 =?utf-8?B?M1doOTJOVWJqdVQzQkFDZ2JYNU01UGhMZkxnZkltU1FKNkl3R0RBU2d2RDg1?=
 =?utf-8?B?M1R1UHl3QW5VQ1IzczJuS1E0ckNOakNqSkZWcG5HODJZVktRWjV4cXdSVnV4?=
 =?utf-8?B?YzluYll6UmlYaEZwTUIvWnRqeFF4aGx5YzBaS0pMOEYxdGhoRzJzRUpURGRV?=
 =?utf-8?B?ejlUd3RBN24zeWxqenNUNWlRcmljMDBYUHk2K3Q1M3RPVTJPQXdVbVUxWFJr?=
 =?utf-8?B?VzNyYzNFZVdkdzM4MHBQbEErYkdvdWpLSjJhdkdabFdmZzFKVVRyNXJFNk96?=
 =?utf-8?B?ZFZSNS9JM1VDbWhqR2tYNkdUZ3pFQStDK29PbjgxRmNHRHAybEI0Z1l4Q2tX?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f062942-da7f-4614-fe44-08ddbc0460a8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 20:41:54.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amaU2GsQc6t6+72uJcPe1KWzxNXhPSaWuSfcitsf2rLtmCbIJUcyAt/U24pVteH4/QonyX2d1r5v/9lnDFSYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

Bleh, my commit message got lost, but hey this is an RFC ;-)

For context, it repairs this issue:
https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/

Will add commit message when sending non-RFC later.

thanks,

 - Joel

On 7/5/2025 4:39 PM, Joel Fernandes wrote:
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree.h        | 11 ++++++++++-
>  kernel/rcu/tree_plugin.h | 29 ++++++++++++++++++++++-------
>  2 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 3830c19cf2f6..f8f612269e6e 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -174,6 +174,15 @@ struct rcu_snap_record {
>  	unsigned long   jiffies;	/* Track jiffies value */
>  };
>  
> +/*
> + * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
> + * It can be in one of the following states:
> + * - DEFER_QS_IDLE: An IRQ work was never scheduled.
> + * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
> + */
> +#define DEFER_QS_IDLE		0
> +#define DEFER_QS_PENDING	1
> +
>  /* Per-CPU data for read-copy update. */
>  struct rcu_data {
>  	/* 1) quiescent-state and grace-period handling : */
> @@ -192,7 +201,7 @@ struct rcu_data {
>  					/*  during and after the last grace */
>  					/* period it is aware of. */
>  	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
> -	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
> +	int defer_qs_iw_pending;	/* Scheduler attention pending? */
>  	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
>  
>  	/* 2) batch handling */
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index dd1c156c1759..baf57745b42f 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  	struct rcu_node *rnp;
>  	union rcu_special special;
>  
> +	rdp = this_cpu_ptr(&rcu_data);
> +	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
> +		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
> +
>  	/*
>  	 * If RCU core is waiting for this CPU to exit its critical section,
>  	 * report the fact that it has exited.  Because irqs are disabled,
>  	 * t->rcu_read_unlock_special cannot change.
>  	 */
>  	special = t->rcu_read_unlock_special;
> -	rdp = this_cpu_ptr(&rcu_data);
>  	if (!special.s && !rdp->cpu_no_qs.b.exp) {
>  		local_irq_restore(flags);
>  		return;
> @@ -623,12 +626,24 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
>   */
>  static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  {
> -	unsigned long flags;
> -	struct rcu_data *rdp;
> +	volatile unsigned long flags;
> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> -	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
>  	local_irq_save(flags);
> -	rdp->defer_qs_iw_pending = false;
> +
> +	/*
> +	 * Requeue the IRQ work on next unlock in following situation:
> +	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
> +	 * 2. CPU enters new rcu_read_lock()
> +	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
> +	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
> +	 * 5. Deferred QS reporting does not happen.
> +	 */
> +	if (rcu_preempt_depth() > 0) {
> +		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
> +		local_irq_restore(flags);
> +		return;
> +	}
>  	local_irq_restore(flags);
>  }
>  
> @@ -675,7 +690,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			set_tsk_need_resched(current);
>  			set_preempt_need_resched();
>  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> -			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
> +			    expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING && cpu_online(rdp->cpu)) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
>  				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> @@ -685,7 +700,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  				else
>  					init_irq_work(&rdp->defer_qs_iw,
>  						      rcu_preempt_deferred_qs_handler);
> -				rdp->defer_qs_iw_pending = true;
> +				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
>  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>  			}
>  		}

