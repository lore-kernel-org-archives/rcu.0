Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A41CDFD5;
	Tue,  6 Jan 2026 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767732556; cv=fail; b=NeTrZDeri0ynX0454OvO2vsvVp5N65rzCIQObUCq3HkiWzI96gyvcyL79tM0Ij9PfcFjbtwPu2jOfaUObA8psTBvjhbiokGUfqjLuHw5YB2DtQekhtFGEB4EMx4o2JMd+7MWrP922TYdtDlu4M4Tylcpa4ATWnX/kV2sJ1EzUI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767732556; c=relaxed/simple;
	bh=eJ+ja4HVQJmL/4ulHDWEGtTOTel6hGWdX7SV953UXWg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ncEhDaqU62jXdh7Xu1VUf8TGn+BhJk3ms5UtcJj78qw4B7tlWxBJw322UIaNplV7eD7M7378oN6dwMP0n6jwhJwXmlkMgCQFxMpTR8Ge/SLIObfMG2ZLyAEbp8X9mxz46MI3JKG29YMJYxUcbNQE7jNPRE1KouiusiNFl+/U0Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V9yzp6IE; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V9yzp6IE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqocuaXmKcXBESiTakXGEDinrljSpOrBKQ/6DwaCyxGy1Sx7bWQOedxkv7lWnrr23jjJNIT1ron7cxRtWP5F0zLxYnUY3vlecNERqKoadmi4jSH8/3MRjFyV30Gfr11nSdxLiB4B7r4BYiac5k8qDUhWk0y13HDdeV0lKb9ywXrqN7sx+ZSWAYyNNbnUgdRUGkor8xXlHe53g1k/Q/EJjuh9fi+m2UzblG6f9xGKS/vYUHjXHPpH2MZtMzl19AOTbG/ySeksR5wwOSAtF1K9AR6ZFMYiZKHQ2QS8azWgQHLN+g2QH/xnHK+LQSsoADbILpSx6OJkUv1uwbJjLkQJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiemqEKYri+2pNHEKAp72ZZqZg2zMTmrT2OhlbvXu5E=;
 b=ozAGwBANtJzqV0v7TobwWtN6C45Q46Sd+eaJ/2mXUT6NLblE4UjBfREOkUiY4EL7pPpoQFHLvWi2pkzeP/6XCYKxAzfhTXqxUTYZJJozZ7Xar8VFPaa1I2aXTOcHHweqEc8fo8ls2UDSV/gSzbVpxHrZR/h7zTe3daeChXkaFT983gO0J/ptuScxtoewM0lu8rbfqUX1QC3GTaHyUmIL+mYOuwvwrc1y/0DfcseizxGYk5xHaFNMJrhTF2a2PE6l2P6GiKrsySkR4qYUwsrXd7IJ3EOvn2rLl1rPX3IjQsEEvo3t4V+AEB5se6K9Ap3zCE93HZJ+ZmLdd01T5Dp//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiemqEKYri+2pNHEKAp72ZZqZg2zMTmrT2OhlbvXu5E=;
 b=V9yzp6IEsXluEBnXeXiePQ+KhZgxF8x3SbPLjAP8RBsPD2SYzj44qUs5Fa50GO8d4mZz+zcMm9jzNR0+s+doq91/7nyGuCdwEi0NNaPjOKWcOYtoDtzIHBBRq6NN2DEM+wRfzmQ3RLS9G68c81AFryfZegD5mZviRo6hiwtDPt+Lii2jpot8/uL9elPEhfx6bTkaGxnqpaOPPpuM+K9yYNtzjPZLfgoqUAvVDyG2d8KcYvunJs/JSG25Iug7mdCCbGSG3AOr0wugC9NQu7mc3NpNo+8WPHWVp5JTxQcjTkeAoLsHSySqwbIrWdE6g49coVkQIWQU0AI9l8Qytt8eKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 20:49:10 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 20:49:09 +0000
Message-ID: <8d7b1107-ec1e-4c1d-989c-20c73af9c43c@nvidia.com>
Date: Tue, 6 Jan 2026 15:49:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/14] rcu: Reduce rnp->lock contention with per-CPU
 blocked task lists
To: paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
 <658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
 <f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>
 <9a6016f5-3051-4055-9fd2-05a01c0c9171@paulmck-laptop>
 <20260106151924.7acd74a4@gandalf.local.home>
 <7c860b04-5ef4-4ab7-8e73-283b5260b78c@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <7c860b04-5ef4-4ab7-8e73-283b5260b78c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV8PR12MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: 63cae143-c051-4ad8-f71d-08de4d650a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFJiRGowMHFMRDNzcW5NOEJHUHJjU3BMYXNwMS9CQXVhVWNTUEJqaTJzclNl?=
 =?utf-8?B?b2xVMHR3TFZsQ3F0ZXVXVHJEZ3E0WUhhR1hvSHVvVkFldk1QcDJkTDMvVDdY?=
 =?utf-8?B?ZG02UE5qVG5qTVhLWnlmd0dGQ1ByV1hCYWJCZkk1WEpwTld6VUtQWXpONVB0?=
 =?utf-8?B?aVpzMDhwSnJ5N1JXdGFRUjNmQ1dYUUpBL0I5V3BVOVNGRy90YisxY2I0WkxM?=
 =?utf-8?B?dmVEOFVETllQUkc1eWd6Qk8waHZ2QjRIUnBUTWJvNGJSQWRLVkxISmQwTjBh?=
 =?utf-8?B?dnJZTjJ5ZSsvNE5LL2F0Q25tZ3dxQ21TMityemVDbXZUU1lHVk1PK1lEOG1o?=
 =?utf-8?B?b24ydnF6ZENXMDdhT1N6VlRWVkRZaG1UZzY3VnlobUc5SXg1VlljSVFrVjRU?=
 =?utf-8?B?bzVFWHJmRzlRL1NKT2ZHNnhOWlMzY21TZ0Q2WlhSMUVrdFpMK1FpZ25oM0Q2?=
 =?utf-8?B?SzdEN2R4Q1huaGljaFZWZC93aHlQNElnUEpVVm4za2twQ0JsNVZkVUdyMko5?=
 =?utf-8?B?YzB1RzlBY3BXM2JqWHgweFEwMytkTGF2L3cvOUVFS3ZyaFRsK2lDQ2IrQ3pl?=
 =?utf-8?B?WWNZQlB4dG9ETXRhb3V3RndnaHhsaXVCN3dBODZPNERTRnRCN2dvdDY2Wkxh?=
 =?utf-8?B?MWJxNFdLR2YyUXRyZHRESWk1S3hnWlNwM0ZLU2NkSVcxb0ZTZlg3ZEttUDJU?=
 =?utf-8?B?OVdROFVEYXZsd2JkOElNK1FiMUZrVDh3Q3N5WTc5Z0cwWHo3Y2trVmx0ZExT?=
 =?utf-8?B?YjVyckJkZ0lFNDhpVlE1UXBXak1vTlpCV0VONHBsZTI5Q1U0M0xXM1J1eDNR?=
 =?utf-8?B?RWtQY3ZqS09hYXQxajZnaDdQWTlSZGUxNE1sUWROMDZYNGY0RWhBZmgvQ1pt?=
 =?utf-8?B?eGpickxxSU1nc3ZnRFR1WWozaDQ2SmErY3kyMlNFRWVTa1kxZlU3OHh2UkFI?=
 =?utf-8?B?L0JiU3lJZDdqMmZPbnZKM1pHSEI1eHUzVy9NQjAzT0ZJaWM3WmMxT09EZWZp?=
 =?utf-8?B?TTNYbkIremhEZXVFdzY5dng1blhtRG45UlFEWkdMSzVHdEhJWTNHR1o5Y2hp?=
 =?utf-8?B?cWQwQ21sTTNNNCs4UUxObml0R28rejNSdVY3U2dWc3hGTWY4ZVlYUWppdVpj?=
 =?utf-8?B?UVdNcytrZUZRTVR3MFoyNEtpd2R2VDFNV1hBSSt2aXc4UHNDQkU0OW0rU2dY?=
 =?utf-8?B?Nkh5OEdYRGJLQkRBc1NSNkpUMC9YRnR3U3p2OW5MUi91Zzk2MGFKMk9sRWxX?=
 =?utf-8?B?eHNOOVZsNjBoeG5lN0RmNmg1VFFHZXEzSDhoKzhwaG95NWZSNzNlWTNDSHpz?=
 =?utf-8?B?Sm8vZ1d2NDZuS01Hajh6UzNNOW9QdUZYMGZCQ2NwV1ljRHVIWm1uNk4wcGkx?=
 =?utf-8?B?N3lpbWxEMUZZYnJjekJPVTVKclNNRWxuWTI4dGl2eEhNMXh3Qktxc1JQbzNP?=
 =?utf-8?B?WUFCVEJDVVAyNEFNV1hBRHhPaWtQZ2NBamtRVjN3Q0IzTDZqWHQySU40b3RM?=
 =?utf-8?B?RmNvZXRGYjY2ekdBOExoQldZRTNINUw1cC80bklZSmdkVlNaSFZ4M1pENjFT?=
 =?utf-8?B?bzlCb3VHT0l1bTV2VzV2ME05dWdnMlJlL0pOUXhKUlRJUFVnVWNndkQwK3pK?=
 =?utf-8?B?UllxNjNZU0tnZmtCVlRFWWo2YXpNa2JwS3F5VElnOGFHa3hpNG4vYTQydlRa?=
 =?utf-8?B?WUQwOGJUUUhZbU1KWDlUMDBsWUhhU3NwZUQ1L0xrN1lDQWtoNk5CUDdLMGd6?=
 =?utf-8?B?VmlUb1JPUW1nbnorbmxic2IwdFBJMS81RE1oZlQybitzVGcwdzZLY0g3Zk83?=
 =?utf-8?B?UzByMjN6YTJnbnBwU0l2UHdQZ0lLYURyMWhuUEVMQmNaa3pWbU9FbzFNNkwr?=
 =?utf-8?B?c1ZmblJMN1VJaDBUM3l2d0RRYlNROG5sbjBlTFpRaFNzSXB0UVZZdFN4SDFv?=
 =?utf-8?Q?2ojXJ2yZ/50WWaNoMnebIyYSIR9Xz0Te?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3RJeGI5bXJSdWE3YTdZc2o3NFZYYmV6RzBNU0twZUZUQlJJZW1aS2pvMU44?=
 =?utf-8?B?aUNwbE5WUnRmQTFNTEVMc2N5djl1NjNKK2xZZzJxdEVCdmpIaDBwVWtMNFlD?=
 =?utf-8?B?aXpyQkUrZDdoK0lSZ0J2a29SQVpGc2xaK2JKYUt5TVNWTk5GT3RTa0ZxS0lW?=
 =?utf-8?B?dU1sbEtKY0IzUWN1cmNteHZmQVpGSWFkUlFhczdtNHdoOEJhL0ZMRm1RRTV3?=
 =?utf-8?B?bWN4WWhZU00rYkhtRU1UNkVjRU9tZ1NUNkhEU1ZqbnQzU21IRnpwaTRvTW1B?=
 =?utf-8?B?M0NwejlsZk0zUzhwL3gvWTV3QzE0aXE3U3ltbGVjM1dnM1pxTDMrVjc4c3ZG?=
 =?utf-8?B?aXc4aW1hOVRDK3JqelB3TnVnbXFtQnZSeVY5M1IvenNlVkQzU0NNa2Frek1h?=
 =?utf-8?B?NWlXQkhVc094d2pzOVlNY25Ya3NFbjZubzF6Nld4eExQV1dXZVZ3NUY1UVNq?=
 =?utf-8?B?Zk5qWDVhUnhSR0g0cytqRmVlYXVoZjJLamp3d0pDL1BsZ1cxRVRJcFJleFBE?=
 =?utf-8?B?UGNRalUvdFRJLzBwTHFNZi9KL2tacXBIcWo5UTM5Ump4S0NvV3BaVmtrZkhD?=
 =?utf-8?B?byt6d2x1UUFVZE45R1R6ZDFHMEFHZEZxMlQxZEU2QmpZUk9DOG05NDJkcHRP?=
 =?utf-8?B?Z0YxMWFhS25IQ2taVmdHcXpLcGtGRmY0YnpoMHF0Q1AyMTR6U1B4NFgzWmho?=
 =?utf-8?B?MHNESFNoZTVwOGhPdkt2VnM4c01uK1JSLzBSNEFUay9DWnNkMkhSRmdMRTla?=
 =?utf-8?B?b0h3SWFoYnJkblRSN0RaUVhzK0tHMUR2b2dvU1Noa0VuZ0xHc0VuM2UyT01Q?=
 =?utf-8?B?T0tWZ1ptNzBmZ2RZQXhTNERHTS9wb2taY2ZNOG00ZENIcnBvKzlLRVFaUTMw?=
 =?utf-8?B?WXJOa3pmMENRQ0UveTFIUllvT0ZVWGRRa0xHN0xmdzgwdGhhanVTeGlGdkV0?=
 =?utf-8?B?d1BWSWc0Q3hLOStHTlNUWTRmZDZ4VlRWZFlXdytzVEova0xGZnhVc05UUGN0?=
 =?utf-8?B?WENIbWFJN1FHYXpoVWtkRk91bE5FSUg0NkhuWnlzSXNrWXQ2Sk4zSmhrVkh3?=
 =?utf-8?B?OXFsdDAzWUluM1JENVZyNFR2Z3UvaVJuS0xmakNza0NPK0dzZzRaY1pqUUUw?=
 =?utf-8?B?RGd2UENVRHk4em1IWmZIVVdtZXVlMThpMzhOViticXpvRmJpczNGRXA2MGRq?=
 =?utf-8?B?Z0t5bE1NaHBEOVZtTVFKbHRBOGd4dmlsS1l3alpYYitMUUhuUmJHVVpkYW14?=
 =?utf-8?B?UDljM3h3V1ZXUUFvM21MZkl2bDlxZWF6Rk1IcjlkUkp1bUtmWDcwMEdvWTJL?=
 =?utf-8?B?NjlXSGsyOURWem0zNEozenlCNmF3UDZ4UmlzZ25ESGdoUzdNQlV2VUZHSmR4?=
 =?utf-8?B?OXdIODc4ZEJ6VHl2MURQemE0VjBkUDJKaDliQU1YQXRZR2FOcjk1bDhHR0JJ?=
 =?utf-8?B?cTVUTnVtM21YeVI2ZGQvVFpQRnZqRDJqOUUrSHROM1JiZnQzcDVsZXRTU09Y?=
 =?utf-8?B?SjY1cGI0bUp0RkJCZTg2L3AwMnQvMXMwSjZKeVJLOXNqNGpkcmRiSGROcjNr?=
 =?utf-8?B?eHR5Mm02d2RyY05TS0ZUOWZZb3dOeG9sT2ExMVh6ckxnZ0gvRU9rQ1VmVS9F?=
 =?utf-8?B?S0lJSDZYeXR2Q29UL3JIYkIrMFB3WWpnd21XdzF5anhkZE5BWHhENjNSVEh2?=
 =?utf-8?B?YlY5Lyt2R1o5OTRnVnpucUZ4U1dGejJnR3JzeTRuMWRiWDZld2srQkxCZjEz?=
 =?utf-8?B?SWMxeHFwNEdFbmp6T0R2bTN4VU1PNUNEMlYrdWYxRkM0Z2NxSXN1UlJ2S0pO?=
 =?utf-8?B?ZTZSN1l0M1NaTEYxZUZ4Q1RLMXdLKzhoU2IySXNwTUJRaDNFV2djMFpqNnVC?=
 =?utf-8?B?eTAwWnJaWXNOWldZN1FNNzVVS3Bwa0dFaWY3dHNxbFdWeFNvcmZtc3JyVnZF?=
 =?utf-8?B?SUNRNVhPcW53WWhDc1oxSWhNTXRYRlEvc0ZmZUNmU3FFNGJTQ1VVRUI1ZVN4?=
 =?utf-8?B?ZzdBdFhyb29iY1F4ZEVTY0ZyYTJOWTJKWWduQkxwS2VweUdSQWZPN1FaK3pN?=
 =?utf-8?B?cE1vU21CVTNHTTVnWm1ZbXhCSXZ1U0tvMkU2dkJGSUoxVXl0dStFRWFLZGF0?=
 =?utf-8?B?QmdzdU1kZjQ4SHhBNDR4YzMvQTRDN0xQS0VRMGU2anMyN3hTS2t4VGx5Q3cv?=
 =?utf-8?B?QldJc29qRVViU3gwVzFMRDROYndRdkpQblhxWVZRdmxBWkRkZzgwL2QrUVVs?=
 =?utf-8?B?ZVU1ZnBzZVJmcUcyVWNVNW9PTGhjOVBBRGNIVXZFWXgyZC80YkZ1VUVtUUIv?=
 =?utf-8?B?eXVQZnp6WXhWa3hrZlAySWpJZ3YxaXJWM09uVm04L2EvanpaY29mZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cae143-c051-4ad8-f71d-08de4d650a89
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 20:49:09.8324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uz/EIrhgPEzKpyzzmua03wtDrJ654ayTF1HWGSWkJpbrqln+A5A3jcNCY+iCyFlOq1PQBzB4BHgCUaxz21y0fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644



On 1/6/2026 3:35 PM, Paul E. McKenney wrote:
>>>> About the deferred-preemption, I believe Steven Rostedt at one point was looking
>>>> at that for VMs, but that effort stalled as Peter is concerned about doing that
>>>> would mess up the scheduler. The idea (AFAIU) is to use the rseq page to
>>>> communicate locking information between vCPU threads and the host and then let
>>>> the host avoid vCPU preemption - but the scheduler needs to do something with
>>>> that information. Otherwise, it's no use.  
>>> Has deferred preemption for userspace locking also stalled?  If not,
>>> then the scheduler's support for userspace should apply directly to
>>> guest OSes, right?
>> No, the user space deferred preemption is still moving along nicely (I
>> believe Thomas has completed most of it). The issue here is that the
>> deferred happens before going back to user space. That's a different
>> location than going back to the guest. The logic needs to be in that path
>> too.
>
> OK, got it, thank you!

There's also the challenge of sharing the locking information with the guest
even when there is *no contention*. KVM being unaware of lock critical sections
in the VM-exit path. Then after that wiring it up with the deffered preemption
infra and moving beyond the 50 micro second limits. If we VM exited and then
made a decision, I think we are easily going to blow past 50 micro seconds anyway.

But again to clarify, I didn't mean to use vCPU preemption as the driving
usecase for this.. but I ran into it when I wrote a benchmark to see how RCU
behaves in a VM.

 - Joel

