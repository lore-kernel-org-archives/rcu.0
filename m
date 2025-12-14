Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF55288502
	for <rcu@vger.kernel.org>; Sun, 14 Dec 2025 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765696486; cv=fail; b=ZCuS00KC5fey/woOpzfePvy4AlhywpRtYjVsKNdUUZ4wiP2XYs/CaDfB27eUXoxJq7igMEYNQpzaXnTOX7LU14NbFeq0+rVazZ7gEwXDQJ1IrEBRiUsGmsEmUoTDHmQF4fs9AGfUGjXmNmBstP4t5gxpo6dIAF87ohm1xXiXMJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765696486; c=relaxed/simple;
	bh=FJ9bxtZucy23hgyv5OKukMmXzBgI5WM55c/ruIpXuPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lc1bEBcTj42I71YtY4E/vbP24FELMh4TRlhCM8UY0asqC/2mYDuXuLRnR4OH8GBYmNtmBGxR6GVBDfMLkDNe/s9eWg3gaCLqEAwtivKgy+MyiCPHQJ4wFVNK+3GPcKzteld85a1PLWQ1CEO8P9DwmKwvDr1zf7gEhtj2KU0pyqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EDkRvxio; arc=fail smtp.client-ip=40.93.198.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EDkRvxio"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsM+DS46bIuLngdOdudEaU4I3ESFp8XwQ4fDDDx0LtdaXt+S9HAtKxJauc50F9kT8hRRaG6wVgqdZ2YCtEPV7VjZg0rcRdKJLQDNxriW/LJSwEzPXIVX8dBwwts7AWHwF+cquUdQxvehkDgAjI+aoD2V1rtW38bHOjwlJRoOAFapl6ii+smuM623AVVaHIlNbXuVuR4SwystgZkGRQA+7lSusQCmN7AoxQQ4BVUNZgohx7b4zX1BrqpglmnmnOckBYabAwjLsbmWoeL9sgET7M9Qa0SMWEmh/k76iK4eTO2lFvGzXLAuXY4TaWjlHfC8JuXb3hLFeyBe5xtuZkuRBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJ9bxtZucy23hgyv5OKukMmXzBgI5WM55c/ruIpXuPw=;
 b=qN4WA2IO+8Tj0kVAUhWwCW5Rod7q1NSyKKcR4auw6RN/9BnLI9dPrMg6MBkRVLpApg5DTHgorpQ+qMKOxVliiPZA3+ktWIwktjvhJj36UgTbMumcDDX5IJOhpoTFqb+nnZyXso0Va+ebpT7CjCvj3j8OtgKL2du6pXclleR2n8hi3BGnaifycDakrNBAdAmamONqEA/5Ex/G46tnei3rsklTiDCIUV1pBIUEEi0cOGCXY8YlBRGMv37r1YGwoHdrj0wlyfpnKfKJ0nCGjTZBzJoBlIfNy+p9eedTh0Xjb2tethsU7SxBfM/9uVHarGL23iY1kepwPpTr/K1Hu4Y6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ9bxtZucy23hgyv5OKukMmXzBgI5WM55c/ruIpXuPw=;
 b=EDkRvxiozPPW3K6f/dpW0+bjrQQr87SZDNovWD4Xj8TgYf36YCeL+1UrhVcc+pTExnxxCKYPQS/FxGcyeEkeBO5wltM6KcPNbj0F2C5RCIXuz/tpIV9dF08TkIRl68llHDshKaW5tOlW/5nhZodSO0PB2GQV1UGDnXmsFXRZBhqK7bM5cjK9y2ClmcgvNNxTNOqSv4CVR2xphaXaCmhFvzW0Kg0lKuuJqYsZMAurEb4zmlozol+uk+G6vryEVLtohcl7nJnoHvPq1KLVF+m1G69h4NTm6TKmm21XrjT2QCLt5jpik4Uag0ecCN3MSFDDXpBs7XlRDw8OmeDfkcMklA==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sun, 14 Dec
 2025 07:14:42 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9412.011; Sun, 14 Dec 2025
 07:14:42 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: "paulmck@kernel.org" <paulmck@kernel.org>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "roman.gushchin@linux.dev"
	<roman.gushchin@linux.dev>
Subject: Re: Handling large numbers of hazard pointers
Thread-Topic: Handling large numbers of hazard pointers
Thread-Index: AQHcbIJJolJ1KBXZHEWgN4L0FEUAXLUgbE+AgABC8y6AAApbEA==
Date: Sun, 14 Dec 2025 07:14:42 +0000
Message-ID: <207B1F17-D789-48DC-88E3-352ECF0DAF11@nvidia.com>
References: <77ffb53f-91fb-4bd4-96d4-e16b0e6ff0f1@paulmck-laptop>
 <091915fa-d6a9-4aba-99c6-d93d9b65e0de@efficios.com>
 <961B6DB0-3071-41D0-9AB6-70B76C547F19@nvidia.com>
In-Reply-To: <961B6DB0-3071-41D0-9AB6-70B76C547F19@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|MN2PR12MB4175:EE_
x-ms-office365-filtering-correlation-id: 6c062134-0f8e-4e84-f5a8-08de3ae073b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RDJndGZrSHIrNVJobTBsYnM5RFFna2o2ekhVY1kyYW1zWUxja1pyMFJ6dnlB?=
 =?utf-8?B?UzBwc3VkVDRFY2J2d0JXVUJOYVpBQTVOZWRZTmNDMWJ3akhHaUxleDBsN0do?=
 =?utf-8?B?TXpKUUdwQmU4WW40WTVrYmNqUHlJOVRpdjJ0aU1jdk5aK3pyVW9BTDNwckI2?=
 =?utf-8?B?K2prdkkxMTUxczNzTk9YV0lMUlh5c0dJbVRBakJ1MGNHdTB3bnJpNGpSSFBS?=
 =?utf-8?B?dEhGR1ZxQmFZendMUkdMSGdEWTFqcS92dUNUSUpLTWNCa1FEYjJ2TnFRczVa?=
 =?utf-8?B?bTJYZGhkeUh1UWRSdE5uSjRrSENYQlNMYWJ6Wm9CUXhVbHhna2xWYTNyU0VX?=
 =?utf-8?B?c3R3VEl3bTZXcWZyWElvazJoV3YrbWZROEZxdXFpMkNoanZ0L0Y2RlBzY2hK?=
 =?utf-8?B?MFFmdHBwZ3RvNllMU1MwL1FkemI4MTF3VnZsQ253dWN2aGhjdGZRdkFKUEpO?=
 =?utf-8?B?c1JLTUFqUjNlMlNQa3JrbUxiRU8rU01OdjRGaURJWm1zYUpoOWhzajZGNVVI?=
 =?utf-8?B?dE9BSmZQcnBCSzlPajJKTFBZUHBIamZZM21kV0ZzRVZvaXJRRkU4dFNsLzBF?=
 =?utf-8?B?QWwxbndhNjVLRit2N0IyWDUzNzBRQ3B4bmREbkxyS3dZK2F0dnNhSVlqS2Q5?=
 =?utf-8?B?MXo1MVFHdnNFUUhTOG9wN0ZBYzZIT1EvM2J3b1R2ZHlTQ25CM08yNS9vaXV1?=
 =?utf-8?B?aExQb0xwZVVTZG9FODBRK0FzY015bXF6TEFNZXczWm5naEhJYkNJaWxaL1Iy?=
 =?utf-8?B?RDlFeEw1bHRLVUtXU0xkL21qY1FucW1lVXFZWVRqSS8reXJKVUg3MlBLSlla?=
 =?utf-8?B?TjdYSFZjS3RPL0NJSDBFQVlwNVhSQkpCZkxkMU9CWHhXcGU2blVIVE5EeDFP?=
 =?utf-8?B?K2lWODlXOWFkUnQ1OVpWK2hTN3pvMzJTeTdxdzJ6dVNiNjUrYUlKOXd3MGZM?=
 =?utf-8?B?bVFsMmlENVArRDJUVWduVmJlTDJjNXNqSjhNTStjQ2FKei9qVUUvaGJvbTJH?=
 =?utf-8?B?WUliWlZ6b3VmS0J5NmpuK05MZVdBMDVBZWdHMEdCbEpRZ0EwN29Md2VTNTlw?=
 =?utf-8?B?aXAwWWs2ejMrbWdjSjRZRFRFbVJSVzJtMk1lTXVFMlFVRG1mWFdDK1FvSldR?=
 =?utf-8?B?SUoyaUNDdmlvaGJzYUlZNFN3R3ovQjkzeHUxQVdHRjUyb2svQVByaldlL0pH?=
 =?utf-8?B?eS9LeDBCLzd3V1FTUkhHQUVuMHJrbmhEYjJaU2ZiRUZaQlhsR1MzdldQM1Z5?=
 =?utf-8?B?TndLWHp3UHgzR3ZNWW9KS3BrWVA1OVFQTG42ejd6eUI1UGFMZFpoRndHUy9S?=
 =?utf-8?B?WTZ3dWRKTFhFYWJrbHhlMVhmYmZWbnJsemtwMFZMUFF5eTBFOFIzNVNUUFNG?=
 =?utf-8?B?NlJZRUpqd0NKYitPZmZ5SXlQMU12U2k1WklXamFFZ092OXlXanIyR1RRbXdu?=
 =?utf-8?B?UkRyOW9VYVpyTTNyUXUrMHAwSlJrZ2ZBZ3BGdEI4ekFya1JTK3hBR1NKS2I4?=
 =?utf-8?B?UGdVdGhCMGZPd1I5WGFhSWRway9Ra1kwR2FZSWJ2Qy92ZGJINlNKbWFhSHdn?=
 =?utf-8?B?OFp3Q3NnRDJmbENGUGZRWDdhSG1uSTUzcTRZTE5oMkN5ZzY5U08zakM2c041?=
 =?utf-8?B?dUJpb2ZXNnlKcTVMdkdWVyt0S3I4OC9JMCsxWjNpNXZmQVdoa2FoVkxTNHRl?=
 =?utf-8?B?UC8wVEF0QSt3WWN0OEt4WG5lbFMwdnpuZzh1ZU9FdytDZGV4UVlsalNzZS81?=
 =?utf-8?B?aVZKdTllaHh0Zkc3Ny9SQ2lsUFk2ZmlIYVYzRW5oQi94K2wxWUJlUGZ2dmhw?=
 =?utf-8?B?NVdpczYwdUpIdlVPWkd4ZGFJMk5ZQTRpaDFlM2NDaVp0MDcydnpGUFAvbTh4?=
 =?utf-8?B?TGRid1dtaGFJblNmeVBObmFrS2ZiR1hyV0x5Zy9HQWJqeEdYM0tzSnRseHZp?=
 =?utf-8?B?c0J3MHhyeWFNOEd0ajZpdGVVU1VZZXoybnFpcmxrNngxbHl5ZDJDc1htT3pz?=
 =?utf-8?B?OTR2UlZaaFVwYzhnY2wyeVNoaitvd1AzbTc1RFlOM0RDVU5MZDRTa01mVWIz?=
 =?utf-8?Q?8Qqzur?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1plNEtyNEpZVWkwL3VZUU9tVGxUSnA1bEdWOXlYcjFPYzBNbUw5eWZLbE9L?=
 =?utf-8?B?YXdKZFh5UEQ2Q1E4SVFGckNyS0duZlBFTmpZTEpFbCtER3VLZHpyZWhoazQ1?=
 =?utf-8?B?TFVMV1lCWXFjZWZZTEZqMGpjREdLS3UxWXdBcGhjSUx5MFB2KzdvT1k4eEpt?=
 =?utf-8?B?TDJnS0xocVVwSElHWlJtcGRRNU5scy9XVXVwTlJwY0RmN0lGTkEyMlo2Q21z?=
 =?utf-8?B?dkF6bUhlaGZGUE1oR2U2NVl6RElPSkx2aTc0NDhoSkFpME92MDlTRWdwV1F6?=
 =?utf-8?B?Y1FJSElQbjdBa0s4MlREZHBDVVJLcmxxMDh0VGgxekNxaWc2RTZPZWhjSWcy?=
 =?utf-8?B?Y09oVVloNS9hUEVFTHd6TTBmaStwUGc4b3VYczkvSko1SVZxQUs3d1Q3S0FV?=
 =?utf-8?B?d3lsTGxHYUw2dGhJSEh3dWNJQnBwWklmT0oxWE0yUjlsdXRlWUo1ckM0MkRj?=
 =?utf-8?B?MjMvWk5yRzJ2cDhoVkFRV2ZLNlRMT05vUjNjQnFRbDE1ak80Tk9JN3lreUF3?=
 =?utf-8?B?TmtTMG1KSTVUNmhQVmtVOWJHWW9SYkZ3cGk2YUtCUlFaQytUTUx5dnMyZVVp?=
 =?utf-8?B?b0dBZmZWS2JVZWxYL0lveCtvdHRFWCs4WlQzaWFVaVg4WWhyUFkxMHpJOVI0?=
 =?utf-8?B?dWJKUmxxUTZjU0FCZ3hpdnBnWWRPckRJNVhQZzQ1bU1xbW53aDhic29Zb04v?=
 =?utf-8?B?bTJyWjVXay84VmNBN280S0I5SEE0VVhlZ1k0bzJReUxkT1ZqaXg1MmQ0R2JJ?=
 =?utf-8?B?NThOd2FOYjhoUElvVXp3SFE1TWE2bmJ6RXNMR3pSVWtFbllxcmpGRzdIYlFG?=
 =?utf-8?B?QjQvdHErcitLNU5kMGRHZTBFS08vWVJPaVNRaWV6cnc5RDlIWnFKNnVtc1hV?=
 =?utf-8?B?eWhjQkZZYTN2RWQ5b3pGTlBBdWx1QUV6WGljL01nTkJIc2pTdFYzekV6aWdq?=
 =?utf-8?B?NUxHUHo4SklWTkVWcUpIL3F1ZklSOFU0cDR0R3ZTK2FOTzh0ZDU3ZCt5UkdF?=
 =?utf-8?B?UWNLQlBmTFhMOGxnRHR0SU1HZUpEUytzZmxCM2cxVDlzenQ2cFZIYldnQ3Ar?=
 =?utf-8?B?Nk5Md3NKOG9teHR1ZjJZQVptMUlPdVV6dGo2WlBGQXdMMVJhOGpOaW5kSno1?=
 =?utf-8?B?VUhhblFGZGorYkNYOE1FYnpZRUVJQWNnbklXK0lIaEhFbDdtRWlFMW1ubGRn?=
 =?utf-8?B?Yk5UT2NzNVJZTC9FR3g0bHFvcGcyenA5SE9Eb0pBR0NEZnFUMlVqY3A1cVh2?=
 =?utf-8?B?b1c5UTM5ZVYvb1dxL3kwei9XMlIzZFVZRWpLS1ZHUGRZZ2dlbGNKMlNpNThm?=
 =?utf-8?B?Y3A1TXhsNEczOW1QR29yWjAzRGZRS1NhRUU5L0UwbjVVdjdjTEN1aDkrdldR?=
 =?utf-8?B?QUwzTFpwcnJHS2tnMGVpM0VhTHJJMFc0SUhSaFkxTXBaWENsUDUrc3p4c1Zo?=
 =?utf-8?B?YXJhS1FZWThWcktiSDA2MHcwS3J4VGw2eXJVVHZjcVM3NlhFbi9xTXNzSUhP?=
 =?utf-8?B?eXZnS1phbzdUWnRaWW5RZHE5M1QzN0lMMDZsMmZQV1BqeWt6VStybVVZQzVq?=
 =?utf-8?B?Y3NYaWtFRkczZWpZNlh3QXRLcUM2N28vQUttNFlhd0k3bThkdWwrVVE1OUpn?=
 =?utf-8?B?TmNXNDFXMlRJQ1FtVlJqOG1CaGdIZjloVTR1aE5GWnAvMnoxdXhKNnFOVnpQ?=
 =?utf-8?B?V0ZnUHYwb3E2WVJwS2owTzl3SFVOZGRGM04zUUpvNk9HdDRyZElJekZCSFNE?=
 =?utf-8?B?eGc4N0hlciswdHdqemd3NTlXNkNNQjNVNnFmWlM4RWRCYXN6bnBJZHBZTnRi?=
 =?utf-8?B?SzFuMk9Fci8xNzM4YU15ZXlFWGNUeWt0SVFqZXk1ZHhMR2xkeWdDclRuT0Y3?=
 =?utf-8?B?QWJaVTUvSHY5MjBnZGhwZENHSk1sWnhhL1RZbVMxd1ZaMXNrTWxnUFlKYllu?=
 =?utf-8?B?VGRkQnNVa0hpc3dPeCticnVCRWFwRWNTZlJkb3VPLzhXd3NKVnlLeGVQS0E2?=
 =?utf-8?B?ejk3cE5TQjNISVhPejBnR3BVYVJTTGs5b1c2OS9SRjZsYTRwOGFlNHE0Ylpk?=
 =?utf-8?B?ZFh5MHhVMkhsaW1yRE9SVkdOZVpxNll4Y3plV1BiTXVZUm5ITTQ4eUVvSW92?=
 =?utf-8?Q?EV0blQSZ5Yyy0y64iswSotxIh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c062134-0f8e-4e84-f5a8-08de3ae073b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2025 07:14:42.0974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXJZd8uOY6OQLrtHnqmeVNrDNtXqBmTE2KrY0chnTV7AyeFjC6TAuKL9CMU2DXJ9vRwSgJn1QY/nBVu5O7DYjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175

DQoNCj4gT24gRGVjIDE0LCAyMDI1LCBhdCAzOjM34oCvUE0sIEpvZWwgRmVybmFuZGVzIDxqb2Vs
YWduZWxmQG52aWRpYS5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+IA0KPj4+IE9uIERlYyAxNCwg
MjAyNSwgYXQgMTE6MzjigK9BTSwgTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJz
QGVmZmljaW9zLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4g77u/T24gMjAyNS0xMi0xMyAxNzozMSwg
UGF1bCBFLiBNY0tlbm5leSB3cm90ZToNCj4+PiBIZWxsbyENCj4+PiBJIGRpZG4ndCBkbyBhIGdv
b2Qgam9iIG9mIGFuc3dlcmluZyB0aGUgIndoYXQgYWJvdXQgbGFyZ2UgbnVtYmVycyBvZg0KPj4+
IGhhemFyZCBwb2ludGVycyIgYXQgQm9xdW4ncyBhbmQgbXkgaGF6YXJkLXBvaW50ZXJzIHRhbGsg
YXQgTGludXggUGx1bWJlcnMNCj4+PiBDb25mZXJlbmNlIHllc3RlcmRheSwgc28gcGxlYXNlIGFs
bG93IG1lIHRvIGF0IGxlYXN0IHN0YXJ0IG9uIHRoZSBwYXRoDQo+Pj4gdG93YXJkcyBmaXhpbmcg
dGhhdCBwcm9ibGVtLg0KPj4+IEFsc28sIHRoZXJlIHdlcmUgYSBjb3VwbGUgb2YgcGVvcGxlIHBh
cnRpY2lwYXRpbmcgd2hvc2UgZW1haWwgYWRkcmVzc2VzDQo+Pj4gSSBkb24ndCBrbm93LCBzbyBw
bGVhc2UgZmVlbCBmcmVlIHRvIENDIHRoZW0uDQo+Pj4gVGhlIHRyaWNrIGlzIHRoYXQgaW4gcmVh
bCB3b3JrbG9hZHMgdG8gZGF0ZSwgYWx0aG91Z2ggdGhlcmUgbWlnaHQgYmUNCj4+PiBtaWxsaW9u
cyBvZiBoYXphcmQgcG9pbnRlcnMsIHRoZXJlIHdpbGwgdHlwaWNhbGx5IG9ubHkgYmUgYSBmZXcg
YWN0aXZlDQo+Pj4gcGVyIENQVSBhdCBhIGdpdmVuIHRpbWUuICBUaGlzIG9mIGNvdXJzZSBzdWdn
ZXN0cyBhIHBlci1DUFUgZGF0YSBzdHJ1Y3R1cmUNCj4+PiB0cmFja2luZyB0aGUgYWN0aXZlIG9u
ZXMuICBBbGxvY2F0aW5nIGEgaGF6YXJkIHBvaW50ZXIgZ3JhYnMgYW4gdW51c2VkIG9uZQ0KPj4+
IGZyb20gdGhpcyBhcnJheSwgb3IsIGlmIGFsbCBlbnRyaWVzIGFyZSBpbiB1c2UsIHRha2VzIG1l
bW9yeSBwcm92aWRlZCBieQ0KPj4+IHRoZSBjYWxsZXIgYW5kIGxpbmtzIGl0IGludG8gYW4gb3Zl
cmZsb3cgbGlzdC4gIEVpdGhlciB3YXksIGl0IHJldHVybnMgYQ0KPj4+IHBvaW50ZXIgdG8gdGhl
IGhhemFyZCBwb2ludGVyIHRoYXQgaXMgbm93IHZpc2libGUgdG8gdXBkYXRlcnMuICBXaGVuIGRv
bmUsDQo+Pj4gdGhlIGNhbGxlciBjYWxscyBhIGZ1bmN0aW9uIHRoYXQgbWFya3MgdGhlIGFycmF5
LWVudHJ5IGFzIHVudXNlZCBvcg0KPj4+IHJlbW92ZXMgdGhlIGVsZW1lbnQgZnJvbSB0aGUgbGlz
dCwgYXMgdGhlIGNhc2UgbWF5IGJlLiAgQmVjYXVzZSBoYXphcmQNCj4+PiBwb2ludGVycyBjYW4g
bWlncmF0ZSBhbW9uZyBDUFVzLCBmdWxsIHN5bmNocm9uaXphdGlvbiBpcyByZXF1aXJlZCB3aGVu
DQo+Pj4gb3BlcmF0aW5nIG9uIHRoZSBhcnJheSBhbmQgdGhlIG92ZXJmbG93IGxpc3QuDQo+Pj4g
QW5kIGVpdGhlciB3YXksIHRoZSBjYWxsZXIgaXMgcmVzcG9uc2libGUgZm9yIGFsbG9jYXRpbmcg
YW5kIGZyZWVpbmcgdGhlDQo+Pj4gYmFja3VwIGhhemFyZC1wb2ludGVyIHN0cnVjdHVyZSB0aGF0
IHdpbGwgYmUgdXNlZCBpbiBjYXNlIG9mIG92ZXJmbG93Lg0KPj4+IEFuZCBhbHNvIGVpdGhlciB3
YXksIHRoZSB1cGRhdGVyIG5lZWQgb25seSBkZWFsIHdpdGggaGF6YXJkIHBvaW50ZXJzDQo+Pj4g
dGhhdCBhcmUgY3VycmVudGx5IGluIHVzZS4NCj4+IE9LLCBzbyBsZXQgbWUgc3RhdGUgaG93IEkg
c2VlIHRoZSBmdW5kYW1lbnRhbCBwcm9ibGVtIHlvdSBhcmUgdHJ5aW5nDQo+PiB0byBhZGRyZXNz
LCBhbmQgZGV0YWlsIGEgcG9zc2libGUgc29sdXRpb24uDQo+PiANCj4+ICogUHJvYmxlbSBTdGF0
ZW1lbnQNCj4+IA0KPj4gQXNzdW1pbmcgd2UgZ28gZm9yIGFuIGFycmF5IG9mIGhhemFyZCBwb2lu
dGVyIHNsb3RzIHBlciBDUFUgdG8gY292ZXINCj4+IHRoZSBmYXN0IHBhdGggKGNvbW1vbiBjYXNl
KSwgd2Ugc3RpbGwgbmVlZCB0byBoYW5kbGUgdGhlDQo+PiBvdmVyZmxvdyBzY2VuYXJpbywgd2hl
cmUgbW9yZSBoYXphcmQgcG9pbnRlcnMgYXJlIGFjY2Vzc2VkDQo+PiBjb25jdXJyZW50bHkgZm9y
IGEgZ2l2ZW4gQ1BVIHRoYW4gdGhlIGFycmF5IHNpemUsIGVpdGhlciBkdWUgdG8NCj4+IHByZWVt
cHRpb24sIG5lc3RlZCBpbnRlcnJ1cHRzLCBvciBzaW1wbHkgbmVzdGVkIGNhbGxzLg0KPj4gDQo+
PiAqIFBvc3NpYmxlIFNvbHV0aW9uDQo+PiANCj4+IFJlcXVpcmluZyB0aGUgSFAgY2FsbGVyIHRv
IGFsbG9jYXRlIGJhY2t1cCBzcGFjZSBpcyBjbGVhcmx5IHNvbWV0aGluZw0KPj4gdGhhdCB3b3Vs
ZCBjb3ZlciBhbGwgc2NlbmFyaW9zLiBNeSB3b3JyeSBpcyB0aGF0IHRyYWNraW5nIHRoaXMgYmFj
a3VwDQo+PiBzcGFjZSBhbGxvY2F0aW9uIG1heSBiZSBjdW1iZXJzb21lIGZvciB0aGUgdXNlciwg
ZXNwZWNpYWxseSBpZiB0aGlzDQo+PiByZXF1aXJlcyBoZWFwIGFsbG9jYXRpb24uDQo+PiANCj4+
IFdoZXJlIHRoZSBiYWNrdXAgc3BhY2UgY2FuIGJlIGFsbG9jYXRlZCB3aWxsIGxpa2VseSBkZXBl
bmQgb24gaG93IGxvbmcNCj4+IHRoZSBIUCB3aWxsIGJlIGFjY2Vzc2VkLiBNeSB3b3JraW5nIGh5
cG90aGVzaXMgaGVyZSAobGV0IG1lIGtub3cgaWYNCj4+IEknbSB3cm9uZykgaXMgdGhhdCBhIG1v
c3Qgb2YgdGhvc2UgSFAgdXNlcnMgd2lsbCBjb21wbGV0ZSB0aGVpciBhY2Nlc3MNCj4+IHdpdGhp
biB0aGUgc2FtZSBzdGFjayBmcmFtZSB3aGVyZSB0aGUgSFAgd2FzIGFjcXVpcmVkLiBUaGlzIGlz
IHRoZQ0KPj4gcHJpbWFyeSB1c2UtY2FzZSBJIHdvdWxkIGxpa2UgdG8gbWFrZSBzdXJlIGlzIGNv
bnZlbmllbnQuDQo+PiANCj4+IEZvciB0aGF0IHVzZS1jYXNlIHRoZSB1c2VycyBjYW4gc2ltcGx5
IGFsbG9jYXRlIHJvb20gb24gdGhlaXINCj4+IHN0YWNrIGZyYW1lIGZvciB0aGUgYmFja3VwIEhQ
IHNsb3QuIFRoZSByZXF1aXJlbWVudCBoZXJlIGlzIHRoYXQgdGhleQ0KPj4gY2xlYXIgdGhlIEhQ
IHNsb3QgYmVmb3JlIHRoZSBlbmQgb2YgdGhlIGN1cnJlbnQgc3RhY2sgZnJhbWUuDQo+PiBJZiB0
aGVyZSBpcyBlbm91Z2ggcm9vbSBpbiB0aGUgcGVyLUNQVSBhcnJheSwgdGhleSB1c2UgdGhhdCwg
ZWxzZQ0KPj4gdGhleSBhZGQgdGhlIGJhY2t1cCBzbG90IGZyb20gdGhlaXIgc3RhY2sgaW50byB0
aGUgYmFja3VwIHNsb3QNCj4+IGxpc3QuIFdoZW4gdGhleSBhcmUgZG9uZSwgaWYgdGhleSB1c2Vk
IGEgYmFja3VwIHNsb3QsIHRoZXkgbmVlZA0KPj4gdG8gcmVtb3ZlIGl0IGZyb20gdGhlIGxpc3Qu
DQo+PiANCj4+IFRoZXJlIGNvdWxkIHN0aWxsIGJlIHJvb20gZm9yIG1vcmUgYWR2YW5jZWQgdXNl
LWNhc2VzIHdoZXJlIHRoZQ0KPj4gYmFja3VwIHNsb3RzIGFyZSBhbGxvY2F0ZWQgb24gdGhlIGhl
YXAsIGJ1dCBJIHN1c3BlY3QgdGhhdCBpdCB3b3VsZA0KPj4gbWFrZSB0aGUgQVBJIHRyaWNraWVy
IHRvIHVzZSBhbmQgc2hvdWxkIGJlIHJlc2VydmVkIGZvciB1c2UtY2FzZXMNCj4+IHRoYXQgcmVh
bGx5IHJlcXVpcmUgaXQuDQo+PiANCj4+IFRob3VnaHRzID8NCj4gDQo+IFRoaXMgc291bmRzIGZp
bmUgdG8gbWUuDQo+IA0KPiBXZSBoYXZlIGhhZCBzaW1pbGFyIGlzc3VlcyB3aXRoIGtmcmVlX3Jj
dSgpIGFuZCBydW5uaW5nIG91dCBvZiBwcmVhbGxvY2F0ZWQgbWVtb3J5IHRoZXJlIG1lYW50IHdl
IGp1c3QgdHJpZ2dlcmVkIGEgc2xvdyBwYXRoIChzeW5jaHJvbml6ZSkgYnV0IGZvciBoYXphcmQg
cHRyIEkgYW0gbm90IHN1cmUgd2hhdCBzdWNoIGEgc2xvdyBwYXRoIHdvdWxkIGJlIHNpbmNlLCBz
aW5jZSB0aGlzIHByb2JsZW0gYXBwZWFycyB0byBiZSBvbiB0aGUgcmVhZGVyIHNpZGUuDQo+IA0K
PiBQZXJoYXBzIHdlIGNhbiBhbHNvIHByZSBhbGxvY2F0ZSBvdmVyZmxvdyBub2RlcyBpbiB0aGUg
YXBpIGl0c2VsZiwgYW5kIHRhcCBpbnRvIHRoYXQgaW4gY2FzZSBvZiBvdmVyZmxvdz8gVGhlIHVz
ZXIgbmVlZCBub3QgcHJvdmlkZSB0aGVpciBvd24gc3RvcmFnZSB0aGVuIGZvciBvdmVyZmxvdyBw
dXJwb3NlcywgSSB0aGluay4gQW5kIHBlcmhhcHMgdGhpcyBwcmUgYWxsb2NhdGVkIHBvb2wgb2Yg
b3ZlcmZsb3cgbm9kZXMgY2FuIGFsc28gYmUgY29tbW9uIHRvIGFsbCBoYXpwdHIgdXNlcnMuIElk
ZWFsbHkgaXQgd291bGQgYmUgZ29vZCB0byBub3QgYWxsIHRoZSBhcGkgdXNlciBkZWFsIHdpdGgg
b3ZlcmZsb3cgYXQgYWxsIGFuZCBpdCB0cmFuc3BhcmVudGx5IHdvcmtzIGJlaGluZCB0aGUgc2Nl
bmVzLg0KPiANCj4gSSB0aGluayB3ZSBuZWVkIG5vdCB3b3JyeSB0b28gbXVjaCBhYm91dCBjYXNl
cyBvZiBwcmVhbGxvY2F0ZWQgb3ZlcmZsb3cgbm9kZXMgaXRzZWxmIHJ1bm5pbmcgb3V0IGJlY2F1
c2UgdGhhdCBpcyBubyBkaWZmZXJlbnQgdGhhbiByZXNlcnZlZCBtZW1vcnkgbmVlZGVkIGluIGF0
b21pYyBjb250ZXh0IHdoaWNoIG5lZWQgYSBtaW5pbXVtIG9mZiBhbnl3YXkgcmlnaHQ/IEFuZCB3
ZSBoYXZlIGEgYm91bmRlZCBudW1iZXIgb2YgQ1BVIGFuZCBib3VuZGVkIG51bWJlciBvZiBjb250
ZXh0LCBzbyB0aGUgbnVtYmVyIG9mICphY3RpdmUqIG5vZGVzIHJlcXVpcmVkIGF0IGFueSBnaXZl
biB0aW1lIHNob3VsZCBhbHNvIGJlIGJvdW5kZWQ/DQo+IA0KPiBUaG91Z2h0cz8NCj4gDQo+IFRo
YW5rcy4NCg0KQnkgdGhlIHdheSBJIHdhbnRlZCB0byBlbXBoYXNpemUgbXkgUG9WLCB0aGF0IHJl
cXVpcmluZyBzdG9yYWdlIHByb3ZpZGVkIGJ5IHRoZSB1c2VyIHNlZW1zIHRvIG5lZ2F0ZSBvbmUg
b2YgdGhlIGJpZyBiZW5lZml0cyBvZiBoYXphcmQgcG9pbnRlcnMgSSB0aGluay4gVW5sZXNzIHRo
ZXJlIGlzIGEgc29saWQgdXNlIGNhc2UgZm9yIGl0LCB3ZSBzaG91bGQgcHJvYmFibHkgbm90IHJl
cXVpcmUgdGhlIHVzZXIgdG8gcHJvdmlkZSBzZXBhcmF0ZSBzdG9yYWdlIElNSE8gKG9yIG1ha2Ug
YWxsb2NhdGlvbiBpbnRlcm5hbCB0byB0aGUgYXBpIGFzIEkgbWVudGlvbmVkKS4NCg0KdGhhbmtz
Lg0KDQoNCg0KDQoNCj4gDQo+IA0KPiANCj4gDQo+IA0KPj4gDQo+PiBUaGFua3MsDQo+PiANCj4+
IE1hdGhpZXUNCj4+IA0KPj4gLS0NCj4+IE1hdGhpZXUgRGVzbm95ZXJzDQo+PiBFZmZpY2lPUyBJ
bmMuDQo+PiBodHRwczovL3d3dy5lZmZpY2lvcy5jb20NCj4+IA0K
