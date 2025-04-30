Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B282620C1;
	Wed, 30 Apr 2025 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029695; cv=fail; b=tX2TWFma1fHq80K4GrBNAqbs/BtGb7+2Yoo/D7DoYrEqVwmuIXPdRGXQ4IOff6AVga1riPwkclz/rAUQlPqVRb/4TXFjLSLBGqvymzqx5eW2uIppNGseWa/aQLeyvijVJmgT7CKoS/y94h3jXOcNEXI2l9ffrzDy9S6EmhjrRhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029695; c=relaxed/simple;
	bh=9N614bpAPnVVZk19Rv9pdfdiHfxXDPQDzM5n6uok2FA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c5ErHKuZVZGUJwhsBjlSQjUjc97VdrQp/JbDOgGtyMro6v/0iYCwc6d47rhHrWiR0VfNzEMdSxGp02D3yfY0lHwKJJDAk8vZCxG/A5Cv7qJqPRKxeMpQm02bd8ckAS26O7cC/+isvTzmAcDvCRZOy+VBnt7QkTQU+h++tR6WD1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RAkCD3Oc; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RAkCD3Oc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO2mJA0ctsVYjQbssrWWA9Rua/szvpd2UDg6OUgbV693f5p5jzFVGG7iB7BstlWyNEJyDf28NRo7FvFymIZcMKi8AM70mVZGxZBCWpPNrImXYI08K2V2Wk+8lXDdWfoFQ1aI6E68yf9k7cgMpO3WRz9thng4nqejl29r0pQAQrpuDixyOIiCnAEwvmoOb3U7rb6C6g8i8kL3weQJBX8+Rw3Qcq0gE1zEfceatesRFtaGL3EITfx7fg4SsQr8kyg1Ha6Ui0NSSHM3jB0QQXQ9+zGnkjjiIx8HGi3Tvvasnigo+bKFJR13dv4BrKj+xAjwFM1yn6dsAwG6zsL5ziZv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pChhQgbgh94rUM+R11ulXKYVyFGzj0g8N87VdydUiWk=;
 b=lpV8Ox2TG4p+cANeyULUkmYtEtqZW5HwlVXLCjbS/tJCsetaSVgT3rmELWdVOGKWDmb+rm4/dR2O1G8elVKTBpZ8Zoo8aqNb4IQ7N4BQxLtPa/JksItrzaCENxbJEKEoFgLmIT5XIhThWw9IYJt1eNhqRCZbwMhH6aRw64jaHAV5s3S0Ilgai8gyMS4QM8Iy75hkztvv60jJyYvVoWDrOz6i+ElsVgYsppu+3KmKxTldX/rI9crF0/DiL9iqKaSGuzKldcktO1MA3NE860L3PPvDA+1HbVjlqa3aRKupCz93MZfTsgX/AjqL1DhL2bGgO0XUET7WGcUrxIB+UHMgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pChhQgbgh94rUM+R11ulXKYVyFGzj0g8N87VdydUiWk=;
 b=RAkCD3OcN5O0LnFr+z9cmIE1IkqyT5p80s3x+gx5N/8aQdeResmERp5RU92kYLrJl4+sHFldb7CcZmGIn2CDj6inbt+FQIE1xmV3S0b0kHGpU7kvccZHnEI6Jdf+enjRNebv9RSQnYAtGN79Z3k1UfEMruVFeMmsHNbN9TOUaX7avC26feqtD0dE+Qu9WGTQQdKiipVjIZ3DjYbBK70xxHGH35b1xGFLSh6o5lt264yjNLp1DWvGH0edFwVmOFTFX1ZAU+v6XCneiYY+yhiIwDBacmCoPPsouOeWnodEKQjXNNGAybbco1gkaaxwfnWqaTtUgOkqT7KjYJMKKlOXTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 30 Apr
 2025 16:14:49 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 16:14:49 +0000
Message-ID: <2c8098f0-2010-4714-97ca-7f46629d67f8@nvidia.com>
Date: Wed, 30 Apr 2025 12:14:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu/nocb: Add Safe checks for access offloaded rdp
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, paulmck@kernel.org,
 neeraj.upadhyay@kernel.org, joel@joelfernandes.org, urezki@gmail.com,
 boqun.feng@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250428095403.22889-1-qiang.zhang1211@gmail.com>
 <aA9U9QvB2t2MLuU2@pavilion.home>
 <CALm+0cW2tXM-HvzoMsNBk4DNyZ-LuUkGj5M4wVLJixSvUDP+Dw@mail.gmail.com>
 <b1d6d155-de0a-4715-9de6-45d3d9e5c9a6@nvidia.com>
 <CALm+0cUx2siBvaRYwWGsN21PC=UUUy1EqLTRe5HmRW2ECWtUWA@mail.gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <CALm+0cUx2siBvaRYwWGsN21PC=UUUy1EqLTRe5HmRW2ECWtUWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:408:112::23) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: fd12568f-9d04-45e9-1080-08dd880221d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2wySVN1dDN3bDlJcnI0Y2F3VUJPQUJsVFBUSTZDV2IxRDNCcG13UHpSVTRF?=
 =?utf-8?B?MyszemJNZllZMjVaUC9lZ0lPMW4xcURsanUzbnMvQkNRTXd2SWZKbXRMNVhn?=
 =?utf-8?B?c082L2x2eVUzdk50SWZESDhtMStLZWd1K3AwN0I4YUZ3YVJXbUZjUE1sU0lR?=
 =?utf-8?B?bnNUb04zci8rK1Q4WWpPSWc5Q1MvRzZOYmlGMHo0ZWdsUWZicnVSN0MxMHdN?=
 =?utf-8?B?ZHM5SXY0dERFMjFTcnVjUkVTSndhY2Q4dWdpdFU1ZUJxRjFTMzljYm5QWU8z?=
 =?utf-8?B?TytzMnJTOWZvajZBUjVINHhRR3ZHZk0zZndKNTVwb0RnVHA5eHZmc3p5RTFZ?=
 =?utf-8?B?MUxOcUJXeU5BcFhseDQ5ZzZVS0pQTzNWZDY0eWZrU0dGZHVRQ2xrVkZFNWN2?=
 =?utf-8?B?bzQ4NjJuMXo5SzlidFp6SnBOMUE0dVIwbEhJWkcycmt0dmV3NTUyUkdlYnFK?=
 =?utf-8?B?WkpsMzNnZlcxVDZ1YXlQRFJsS1RHTnBPaWpDY3VrMU1oc0EwSXRBdHNKSzBL?=
 =?utf-8?B?bFhCQXlkWUVtMFBXbmU1TXIzejRuNkQxbkpNdmg1REhhc0JBc0FiWlpXcU9S?=
 =?utf-8?B?bElxSFI0eHZlNWlWYXdiNXZRQ0ZpcVRUaWh6MjNXTWdLTFY4eFdIWWszemdu?=
 =?utf-8?B?U3ZpdksyaUpoeGlKbDd4N3ZvK0tPYVNEdjYwQjhvazZtYWc2K0pUMFhNc1Jt?=
 =?utf-8?B?ZXkxS0kwMDFvSXByTm1ZVnNvSVh2bXUrOElKT3JoQ1RMVGhTU2NrY2RwQnE4?=
 =?utf-8?B?NXhvcGRLUGFUdDd5MHVNc1Z1dXJJVm5peFVxUVdLbE9WN0hYOFptdnZpRk54?=
 =?utf-8?B?bjNRMlJaQlNGVjd0cDcxNGNsRkJZSVA4U09NVUJiRlBkK0c0QVl4NXJ5OXFr?=
 =?utf-8?B?OWJIVmZWS3hRNVVVY3FmalNaWDVqWHpFKzVVVVQ1dGorbkZHNE15azdvMUM0?=
 =?utf-8?B?a2x2ekxTSEVDUnk1YkkwN3JWOEJucXpFQWxxelpiT01vZklmV1Q0c0lBd1Zi?=
 =?utf-8?B?KzRXOEtjWWFoWGE0ZmZBa3RleUE0cHdtTnlYdGI3a3VHQSsyamtYVndKVmVk?=
 =?utf-8?B?NHNFaFY5VVRCUWNkRGVLTHJ0dDFiV0tVWEdjR3lMOFBiWXhVTXRLSUp3b1ly?=
 =?utf-8?B?eHYxcW9rUEdhb2JWZ2VBUE10NHl1aTBZeTB3SWlybEVYdDgrdHp5NVNFMGs3?=
 =?utf-8?B?K3FYOERzdWJiN2xXSjhiTXJRR3VyOEYrRzh2K1Y4WTJZVmFRZGNFWlhHaUU2?=
 =?utf-8?B?c0Jxc2p2TThTY1NyRC9nL0lwajdYdW9DWFpCdE1QOWhEM3QwRDdZNjRtRHAz?=
 =?utf-8?B?YmVheUQ3U2x1SkFFQU9nZEQ1bjN0bkg4MGNZWHo1YktVK1lzU0F2TGthbDR2?=
 =?utf-8?B?UEloZzJhSHQ4NDZ4TVRyU2lRWmtyWXM1eEl4cjlaSWRMSGtNWXdxKzZGcEFi?=
 =?utf-8?B?RmhYb3orOWV0WUUrY0R0T21tSktkcnpYVzVZN21lZW83QzRRdk05R29SV3px?=
 =?utf-8?B?SDR0VCtwUy9Yb2l6bXFVb3hWbU5ZNGNlSkI5dnpBZ0w1TDdSZTBjSUc5ODc4?=
 =?utf-8?B?Y24xODRoeCswT2VSYW1ZREd3M3pkaDBxT3RQSEo2U1grSUZFRXovZ3JTaTZn?=
 =?utf-8?B?cnNRT083MVN2UVRYcE9pRlF2K2w4d2UwNXc0R2FKRW83ZGNsS2oxVTFhcjZ5?=
 =?utf-8?B?L2szQjN0ZG02RE9PWE9oV0RlMUFWM2RSRG5NMXhsVithUFVEQ0FqM2drcDNa?=
 =?utf-8?B?SVNtNms1V0JXM0Fha0ZSVVhsZmlxQ1NRRlZLRjViZ2tNREhVSjQ2UnYvY0VR?=
 =?utf-8?B?dVg5VW5TZGJxODNhU0hjTC9TcStJalgvM1ROcTRZY0lSK2RCZ1FaWTVWc3dZ?=
 =?utf-8?B?M2s3WENFUjJCUVJ2S3pHWDJYYnRCbjEvQ004UXJwNkJmOEhkNGxLRzdzeXdm?=
 =?utf-8?Q?kOyPrEegWvE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmtLa3pJSFRvQ1hsbWpWc2ZoSTdiZm5ZdW93dUJockl5OGEzajRYT2J6ci9C?=
 =?utf-8?B?S1Bub3gzQndrTS9ER1FIWk96YlVFbm9NVWVkQ0o1U2R1U2IyWDV1WHpQVk9W?=
 =?utf-8?B?dVYvQkZVU2FJall4K2R4ak91cGlIdlRWa3I0NEpzaEh4SGVaMklPWU5pa2RG?=
 =?utf-8?B?UG9BZlBsZHJ2dXhPOXhaVWtuMHRrZHNyS0dFQ0lNZzRlRGNaRHBwcUpsTjU2?=
 =?utf-8?B?aGR3bHhuSSt6L1M0Z2xrYzZucVRUYWZ6N0U5ei8yZmF5QnEyNytKQ3ZZUDNp?=
 =?utf-8?B?VU5RWHNYZG44b1A5dUNRNkpUSExUNWdxY0hFRWVGMzkyNExjemRKUklFYjEx?=
 =?utf-8?B?emJkRkUwZGJla25ab0sxZWk0QmVKb3huY2hXbkgzeGdWOUFMeUhTOFozQWxs?=
 =?utf-8?B?U0xKaHowVStJY0Q4Y2dlbEsvVGhCajVyWGprREZVYVc4N1dIOGVQditiOVVT?=
 =?utf-8?B?bHhzUitLTXFPTWh6d3JBRFBGK3IzVms0SFZFV1plNE9na1QrM08xVXdDRnZM?=
 =?utf-8?B?K0xzclZsL2V4V2pwQ0pLM3V4U05PME9Id1VEODJZUFlqbGN2S0NQN1NlY2lG?=
 =?utf-8?B?YVZVQmdVaUpZL0xKVWVXaEprYk84SEliVWFKUXlOeXFENytFNE5CamxIazl4?=
 =?utf-8?B?V0tLYzdDUDJCR3Z4UElQRnV6bUJwZFUzeGxsQ042S0E0c3c5WXVSMzZKakFR?=
 =?utf-8?B?UVhMeEZuQkJqWHYvaU85YUZTUVBTWS9yNXpKblhtNy9xdUZ2d3BzeVlFNzBv?=
 =?utf-8?B?d085Y0h3K2RYMWxpbGttODkyNVNwQkNVS2dGemVpYU1OSUw3YW1kbFBqbjE2?=
 =?utf-8?B?L1VVbVdKSzZzaTVlWUpIQTFSSC9ZTGh3OGg4YUxYOGdDaWlVWG9tY25IazBI?=
 =?utf-8?B?RUFHMlYyekJ1aXNrd2Nmdkd6UVRqUHVWeWRpRlZxUHcxRlBOeFNuYkRmcVkw?=
 =?utf-8?B?SlRhQk9KQ1NqcVJ6QVNFL0pHcExoNk14R2Z0NlBodDJmN3FFMGZybmFDc2V3?=
 =?utf-8?B?T3ZUTFIvYjlIa2lZMzdJYzErZ1YxQ21TeTRhcXZxeEc3S1JnT0lwd0VRS1I2?=
 =?utf-8?B?U1RCM0d6YXlIbFhvR2hVMGFJMGRpZHh1bWROdlQ0UWtGMFUzb0lpR3U2eVRB?=
 =?utf-8?B?MU5zZG1mVERJTnlRSEpDWk42QTY3aWw5OW5zekZxOUxoYnlxNmsvdlNEYUdU?=
 =?utf-8?B?dTlxRUxxRC9HbG1oK3JVU24wUUIxZGJ2UHNVT2VoQnJObVErQWNwZmhRTHk5?=
 =?utf-8?B?cVJ6TlF2blJydzNtanMyem1zL3RZZ0lPczRScWdkZi9PYTVaRmV4Q0FDQTJG?=
 =?utf-8?B?b2F3cmdjU2JvVUMxVytIOWwwc1hiR2tianlMd3dGM2JyZGhzL1NETVRNR1da?=
 =?utf-8?B?NHZvUndKb0ZvL3R2VTRlOE9zUlAzOWNCZjRwR1Ezb2lxdHM2SVd5ZmR3VWxF?=
 =?utf-8?B?Z1FqdUxoNmVXMGpPTDlUd2ZqNDE2WXNyYWlmVWs3d25aWmlRb2x3M1A4ektI?=
 =?utf-8?B?YldxVXhrVHYrMEZZdzdGMFRpK0VURWhTWUVnS3NIK09iNkdjVEJWaGxKUXNY?=
 =?utf-8?B?VTlQajA2N1lBbE1kSVR1WEllOWxlRldWcndEVStOMW83L09Zb3FBcW9ndW9J?=
 =?utf-8?B?c1hTcFZza2NYdWY4bVlBV3hOVG96YkkyaSt3Rjcrc1hYcW9LaDlHNlpHQ0Z1?=
 =?utf-8?B?YXdFWlJZT2I2RDFYMGg1TDRRUy9veHVoTGFXckFUV0lNVGRvdC9oeHA3MDRT?=
 =?utf-8?B?SkVGUzl3M0NCMnlLMlRqMUxDSDBoVnJ2TGIvOWVYemk2UkNiRWlDdFFFeDd5?=
 =?utf-8?B?aGR6SlBTYUNwWjZYOWJ3VUZlL0ZSU3hqWUJXY291aE1TU0NZM1JuSmZzaS8v?=
 =?utf-8?B?M1JPc29PQWxiQXJMcS9RdzZyY2R2azY3cFlibE84QWVwSzJjeTNiM09ZdWxD?=
 =?utf-8?B?MUR6QjNQOUp4OXlGYXZlUlJKTnpjMkJOeUE4ZDlaUzBaTTQ5NVdiOExmSHhJ?=
 =?utf-8?B?WmFwNzladGlOa1ZxdEwxNENNSmc5cmpwbnNKdElMSSt2SG0rQzNVN2pRZzFl?=
 =?utf-8?B?eVN3NjlkNUY0MmozTlY5TVVEVnhvblNXNGkxNkhKcWo2Z2p6WGVpMUZRZ1k2?=
 =?utf-8?Q?u+rV5lz/i7k1FlU78mg94f2TV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd12568f-9d04-45e9-1080-08dd880221d1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 16:14:49.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3fWggw0MZUycLKgmVydmYMAeYuZZ9DsvP1Sjd7wPvTajZJlUTQPw2nGa/G1lCuwDTKwjNtY4CLp/DHQeaiVuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079



On 4/30/2025 10:57 AM, Z qiang wrote:
>>
>>
>>
>> On 4/28/2025 6:59 AM, Z qiang wrote:
>>>>
>>>> Le Mon, Apr 28, 2025 at 05:54:03PM +0800, Zqiang a écrit :
>>>>> For Preempt-RT kernel, when enable CONFIG_PROVE_RCU Kconfig,
>>>>> disable local bh in rcuc kthreads will not affect preempt_count(),
>>>>> this resulted in the following splat:
>>>>>
>>>>> WARNING: suspicious RCU usage
>>>>> kernel/rcu/tree_plugin.h:36 Unsafe read of RCU_NOCB offloaded state!
>>>>> stack backtrace:
>>>>> CPU: 0 UID: 0 PID: 22 Comm: rcuc/0
>>>>> Call Trace:
>>>>> [    0.407907]  <TASK>
>>>>> [    0.407910]  dump_stack_lvl+0xbb/0xd0
>>>>> [    0.407917]  dump_stack+0x14/0x20
>>>>> [    0.407920]  lockdep_rcu_suspicious+0x133/0x210
>>>>> [    0.407932]  rcu_rdp_is_offloaded+0x1c3/0x270
>>>>> [    0.407939]  rcu_core+0x471/0x900
>>>>> [    0.407942]  ? lockdep_hardirqs_on+0xd5/0x160
>>>>> [    0.407954]  rcu_cpu_kthread+0x25f/0x870
>>>>> [    0.407959]  ? __pfx_rcu_cpu_kthread+0x10/0x10
>>>>> [    0.407966]  smpboot_thread_fn+0x34c/0xa50
>>>>> [    0.407970]  ? trace_preempt_on+0x54/0x120
>>>>> [    0.407977]  ? __pfx_smpboot_thread_fn+0x10/0x10
>>>>> [    0.407982]  kthread+0x40e/0x840
>>>>> [    0.407990]  ? __pfx_kthread+0x10/0x10
>>>>> [    0.407994]  ? rt_spin_unlock+0x4e/0xb0
>>>>> [    0.407997]  ? rt_spin_unlock+0x4e/0xb0
>>>>> [    0.408000]  ? __pfx_kthread+0x10/0x10
>>>>> [    0.408006]  ? __pfx_kthread+0x10/0x10
>>>>> [    0.408011]  ret_from_fork+0x40/0x70
>>>>> [    0.408013]  ? __pfx_kthread+0x10/0x10
>>>>> [    0.408018]  ret_from_fork_asm+0x1a/0x30
>>>>> [    0.408042]  </TASK>
>>>>>
>>>>> Currently, triggering an rdp offloaded state change need the
>>>>> corresponding rdp's CPU goes offline, and at this time the rcuc
>>>>> kthreads has already in parking state. this means the corresponding
>>>>> rcuc kthreads can safely read offloaded state of rdp while it's
>>>>> corresponding cpu is online.
>>>>>
>>>>> This commit therefore add rdp->rcu_cpu_kthread_task check for
>>>>> Preempt-RT kernels.
>>>>>
>>>>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>>>>> ---
>>>>>  kernel/rcu/tree_plugin.h | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>>>> index 003e549f6514..fe728eded36e 100644
>>>>> --- a/kernel/rcu/tree_plugin.h
>>>>> +++ b/kernel/rcu/tree_plugin.h
>>>>> @@ -31,7 +31,9 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>>>>>                 lockdep_is_held(&rcu_state.nocb_mutex) ||
>>>>>                 (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
>>>>>                  rdp == this_cpu_ptr(&rcu_data)) ||
>>>>> -               rcu_current_is_nocb_kthread(rdp)),
>>>>> +               rcu_current_is_nocb_kthread(rdp) ||
>>>>> +               (IS_ENABLED(CONFIG_PREEMPT_RT) &&
>>>>> +                current == rdp->rcu_cpu_kthread_task)),
>>>>
>>>> Isn't it safe also on !CONFIG_PREEMPT_RT ?
>>>
>>> For !CONFIG_PREEMPT_RT and  in rcuc kthreads, it's also safe,
>>> but the following check will passed :
>>>
>>> (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
>>>           rdp == this_cpu_ptr(&rcu_data))
>>
>> I think the fact that it already passes for !PREEMPT_RT does not matter, because
>> it simplifies the code so drop the PREEMPT_RT check?
>>
>> Or will softirq_count() not work? It appears to have special casing for
>> PREEMPT_RT's local_bh_disable():
>>
>> (   ( !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) || softirq_count() )
>>    && rdp == this_cpu_ptr(&rcu_data))  )
> 
> Thank you for Joel's reply,  I also willing to accept such
> modifications and resend :) .
Thanks, I am Ok with either approach whichever you and Frederic together decide.
I can then pull this in for the v6.16 merge window once you resend, thanks!

 - Joel



