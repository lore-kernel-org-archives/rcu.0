Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264B01B6CE9;
	Tue, 13 Jan 2026 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314740; cv=fail; b=Roc3HEYQLMF1+eYGPVR+wYNyZFH0KROuAhHCKy/Cpn8rtXdgKRzCtog6GlRgE0GMpiDtKsE/1K+5VOw29KQg4IJDxiiqddYnA1l+uJ3t1iJ9rta6e9QuyfckD93zru5Wi06LFGTG7/PR8Y9V0SYUqXw+VQWOUt0G99/HGQfD/Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314740; c=relaxed/simple;
	bh=SHvXlnLylh9SwwRIqmipU6FCttSBDRge3R/WOIpPL5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GHoR2glh0x/DA/OfJPjjx/mmj3nHbEuBJTfZd2RQ28pvtz8BB9nZI98Ci8ssIiPzfJJaImYBitVAVAaJJI62gzeCcMd723G8LQz3IaUjU3ZUnZp12WZDme9K7ESGZn4XlHxhioZx6iYdVWnBujthorOvg0mamCiJuympnex8N/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K3+IV/0U; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K3+IV/0U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQ3HsJiD76+SCPhqIzwi1+rNY9f2Hk0KStjoLsVuIWVl/HLw92p8+3Rmj8BSrvmxoFNUbUU1pWK0ZJIOSJ7vdGEdFxqecAZgdVwU9ErjX33eb9nUCK2oAz8JJbJLZdQAT/cIdPs64vfMST6xvx8vDsrTL8wUSqZ8ZhND4+ERYmOiTSiz2QkY8r/YwgoZPMwRhlS8DPQUX0Rs/5zKEKjGnM+IdQox+tiIIz8y2nk+RAghs7yA/vJqhINS1xMvSvHQcGQ6eiBr/jOQbYFP2gO4SrZj3eEF87Ae18g4zv3G8BHjzYlN/VPozy8oivNoLUVGB9iut37QHdZNwtUQ3lrsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LokSHnbmRxSjwQLlqpQRuolqT91tFt7J2aQMvKc2tU=;
 b=zTXTFcIWSAve4lDE8YWhZo4/KoYKGWMrRfq4/b1fWBM1VdhYzTjwOPPzFlVb8EqG540D7i+fnWXdIl4D9dEgWK2tbprWpSC5y0YCjzvpn2mUrVRoP5azvoct7kesU+veOOuhUCVMhW3PM5QCVnTgoX99Yk9/7eToSiipWZZ2JQlMVQIWLcDtLPsxA7f6LSgvSOzATrH+w06zMrskaY6CYXoAeRo25qpVAxHzHgmsQ7D6Ff/3G05rdg0fFcCkCiW1g8RYQMZ730lI4Lma3UqCQOBHmRO+MpvRjYONNHkT1l2LPrWMav85mgeLtB0bF6DYf1hcNMgamFSjmHw+E1K5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LokSHnbmRxSjwQLlqpQRuolqT91tFt7J2aQMvKc2tU=;
 b=K3+IV/0UZxzp76EWJVVxxp04SpkfYt3hFjJDcgWcbrwFXaqCfi5exMRPZDH3d2TLZUoCNE7YsSJ3mPwNyVDgmvA7KMZPEjp+sUFnRLaDeYyUogtuj1qA/6amb7xcHd6AGmCJiR5ogtp/5NvjDV7bGj1mISVWubYAM0bMtjfkZAJzIAV3IcOTRSZ5rbF5ezE9uY+znNhhOUkk6cp+h/PzWuHRYnSSc4jPGIzarqqYVcRW4vpcQ9y+Hi338M6PqNnXp9uutqzBtzj82gY87+/mHDw88mXvoHjQAem5+AagQlVVubNJtD2n72ETLUMS/Em6y4dmhxgEZsVAvNwahG/sSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:32:16 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 14:32:16 +0000
Message-ID: <6d05f9ea-fc4f-4115-a416-8e779f17e0fb@nvidia.com>
Date: Tue, 13 Jan 2026 09:32:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "frederic@kernel.org" <frederic@kernel.org>,
 "neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
 "josh@joshtriplett.org" <josh@joshtriplett.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "srikar@linux.ibm.com" <srikar@linux.ibm.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636> <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan> <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <aWUqtX2PGDOZUaDW@milan> <D5086AE0-7158-49C4-8511-47F99021B2AE@nvidia.com>
 <aWY4LQZrudJ4SB8G@pc636> <B077EC99-57EC-48B8-9B71-237A7A95DFE2@nvidia.com>
 <aWZUAhbMV_BHamr_@milan>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aWZUAhbMV_BHamr_@milan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0162.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b953f6-b7ab-4b32-c3f8-08de52b08ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW9JOUEweTZjUXlQNzFZMWdCd250ZTh5c2RqMHVsSGpHV05lcVgrWGZkamR6?=
 =?utf-8?B?VS9qQWhUVmNTQkVQNkU1bnMzK0QzRUZTKytDRWw2WGZ6Q1hUZjQ4RUh4dzgr?=
 =?utf-8?B?ZVphSkFrUS9EZzhLODhxTnlQeVpiQnJYZ1BmSG82WTc4OHJsVG5oemtTak4w?=
 =?utf-8?B?SnJsVW9qY2x2a05YZ3B3cHFVbjZtcmt2NnJKRkgxTjZ1MEVvTks5S0Y4d0xk?=
 =?utf-8?B?WTNNb254YlV4TEwvY28vQmoxV2YxbTJYNjZuVjF4ZFpGSUQ0Z1RBbTRid1Z4?=
 =?utf-8?B?dWtWY2ZZc2dINU5mbVkxRzlCZTh2Nm8rREh4bHBxMklpUkFqTFBZSlZmclpS?=
 =?utf-8?B?eS9ybVI1SU9zcm1WYXZLWjhROHlKM2VHZEUza2lBa2FhdzdmZXVhQkpyTkVp?=
 =?utf-8?B?NWlUTktWa2JncDZvZnJ6OVNDMmFMK1BGT1ZRSlpUcUthbXlKNlU3VFljbXBR?=
 =?utf-8?B?ZVZFRG1pTjZzRVRBVXdJci9wckJ5eEhGSW15SzIvaVI5bGZFRHZGVUdKbk9Z?=
 =?utf-8?B?cFNPbTNzeUFrdFhvWStwRmpaTlR0VFQzd2ZwS2pBLzA0SlZXcUI4c0RvaVJm?=
 =?utf-8?B?MlEzWEpBZkhycE1oMmQwdzIrb3VuNk9XRDYzQW0vSmtCMTk3Q1JCREZYaUdY?=
 =?utf-8?B?cm1VZ0ZnVVJRVnkwbjJJMXArbmxlZHhlcUFrS25tSVRoVGt1bWhxRnRKd2Zl?=
 =?utf-8?B?NzVOUm5Hbnd4WmtjOEF1bkdYRXZ3ZU04bmpNZEFpbjVwNVVxN1dLZ3ZhblJZ?=
 =?utf-8?B?YkhNTnZJTWlLV0tLZzNCMXR3dGczSVlzNUduLzRaeVkzOCtJOFNCSGR0YXJa?=
 =?utf-8?B?VlRSUjk2cWV3RDJnNFNrQlpqS1JGWkgxRjZtbng1ai9sL1VUYW05dktIRndF?=
 =?utf-8?B?c1BaMCtEUUdUcnd5REZOUmE2MDY3dG9lcWcwUTZ1YTZ1VTNldDRBekg1enhK?=
 =?utf-8?B?UTJOeEpFVTllalZDeEM5Q3loYk5ubmdIK0wya3hFemNXYWMvTm9SOUFRemUv?=
 =?utf-8?B?cStwODRmUGZHUjRqWDFuQ01lakJUMU9VUUhHZUNtUi9FY1ljcEpJRjFsOVZH?=
 =?utf-8?B?eW00enRNaEJLSnFHeTZlcFNDdGJtTTRKdWJxL2xpUTRlVVBRT2dGUUszNCts?=
 =?utf-8?B?S0hVWjViN0hrQ0MxMHlQQmVLMnJxLzY5cWZDTzNKOUpSQ3NWTVR2aXJaYVRq?=
 =?utf-8?B?OG9aOTF1WnQ5ZEJONjRvQ0kyK0NidHlNb29oemtnaVpOVWRCZERja09aUU1H?=
 =?utf-8?B?ZkdFVW9wSVlEdnBnWE44VFB4NXVzZy94SkplZnFmYnp6VmVQZThMZEN5eTJY?=
 =?utf-8?B?R0RETlZWODNJaXVYM1E2eDRmaHdIVTEwR2Q0L2tMSnB2TnMwWW5VTEY1WXZN?=
 =?utf-8?B?U3c2NjBsTnVydmNCUDRHUjZQY1JGVmx2YVYwbW9MQ2pCbkRheDlJSEliN3ZY?=
 =?utf-8?B?eHY5T25GZWxqck9zcUh2Zmo2N2lRWnZSV3Axcm5yaDhvc016bmx4UGUvUnpa?=
 =?utf-8?B?Yit2Z0NRWDg3YzZ3NHMyUTdoVmFJYkhOWFVhMHhMd1lndm5kVUdnNXlYN0oy?=
 =?utf-8?B?bno2UWVxVVU4SUs3VGpPNHE1dXhnaFFHb0J5TXk3RUZpZ0J5MDYra1ZiczNz?=
 =?utf-8?B?YVowc0xEekc5N05OTlJkQWU2SXJRRWlCd2toMm1xRzErM2hsRzFubzBIa0xP?=
 =?utf-8?B?NE9adXhoVVNFQWtyUThqbWswMlp0dHJLMXIyWTQ1ZnFjN2gzWmxBQVFPMXhn?=
 =?utf-8?B?OFNYQ2VFcWJWWGxpUWJnc2UreHNIVzhRSllMUVFNTEhFNm5QQTJEYmh0NUpa?=
 =?utf-8?B?MkNLUklWVE9OVmVpZUtMVk0zdWl5Z0pFSHVjUHZDMUhvVGcwUzNRSk4xQUw3?=
 =?utf-8?B?Rlg2Z21LNXZ2SHFrRWl3L1d6MFZSMUE4TWFEd1JtVkxQQmhxdUdsSXVmbDl3?=
 =?utf-8?B?UTVmTkVpdGY1WVI4WkVKTGt3aEtkYnhJY0h1cngzZzNOcVVDVVJ1U3N5Y0ZN?=
 =?utf-8?B?a1FJT0V0ZU5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWZkRC93RFhtTWtMbW5yRFFJU1h1eTJKU1JBNS9JTDMvNyt2UHFhY2VpWlpm?=
 =?utf-8?B?NHVWNTBTV2ZoWHNvbTJVeDFrOEJIaHp4Z0NnL3VGU2hPcXh2NGx0ekozZmJ2?=
 =?utf-8?B?SGhHM0R1ZlQvRithWkdiSHJBSUtZWjhTdzdyLzh4ZkVwQkZuSEI4UDZ0dXVz?=
 =?utf-8?B?ZG9pUVdaTnNmUGFSSTduUmpLTE9haGJQK0JyNFlXMGp3M0RkeVl5S1pmTG9r?=
 =?utf-8?B?NndrVGoxbU9wYzNUczBqZlRRbU1YamJzTTZ3bm1qcUpYb2xUbUNXK2hmOUZw?=
 =?utf-8?B?all0RU9NTHgycG9qOGZsdWZCdktFYWNMcTVnTlNlVlJ2YVE2d2VkSEN2VFlF?=
 =?utf-8?B?aXBHRWMrTGNPeVdhOXU5MHEzNGRWbXdDaWhrUlkvSTFDTmdCakhMZUdzTC9S?=
 =?utf-8?B?bXRNN3R3WkFWWnJWa1gxb0ZCbFkrOUpFQlUvUjBoOXRKRFVoS0k1MWpqOTBk?=
 =?utf-8?B?WEJLWmJJUTRxWE9HSVZyZVdNNW1MWSthQSt5UmZkV1lZbHRwcXY5bGlkcXBv?=
 =?utf-8?B?T0NoYlBRaGNncDRialMwODRmV1A4U1ZhUjlWUm02ZFpEWEdPMXgza2ZGSlBT?=
 =?utf-8?B?NWFIMm9QNTUxRjZNNkJaM0JLWUh0MmQrMEx1aFFFbERSOE9Pc0RONEtVc0Iv?=
 =?utf-8?B?QXV0TjlZQnhIUGZ4dUcyS2pYK3lxWDhlQnJXMkVBUFhXdW02WVltcmJ4NW1t?=
 =?utf-8?B?MHZjSEt2UEY2ZnFxYmVJd3dvRlhrMWtZRTV0YUlha3ZaT2FibHVNSzEzWGsv?=
 =?utf-8?B?VjhjU0hiN0ZvYzZUWnBibFp6aytWMTZLYXlYUHNXR1k2aFhkV3k5UEd6eXpX?=
 =?utf-8?B?Wm91NnBtOGIza1ZrbkdrUEdaclRhVm9PcXZoM2JnY1ZIcjRwc0lYREZLTXRr?=
 =?utf-8?B?V3pqSG12Tmx0WDg1eW1lQVFwSkd0WDBDSDV1bEIyYnova0RCbEpPWk9SMjNF?=
 =?utf-8?B?V1NGcC92K3NnM0JDeTh0VlI2aXVHdDJGU3dVNlVlM1BaMkJiZGJRSUhic29V?=
 =?utf-8?B?YVZONkg2SjF5NlRVUWgwUEg2YnFkbWt6dllZS28yMyswaWs4TTVaU2JXV2Ir?=
 =?utf-8?B?TG5TeHdjZXBJZng5ZnpMVGZkYmt0NjRzNllrSllnODlSU0tpNmM1QlpMWnQv?=
 =?utf-8?B?d0R1Y3pMT3BaZk96czZ3Wjc5empDaEJhSDFVVHU4SElCeWlpQ3pUN1I4ak1R?=
 =?utf-8?B?enpDZHAvckR3Y21jSS9LWFptUS9jdGtVdkdxQjE4YWlZS3BCYTZEc01Ma2Ji?=
 =?utf-8?B?aVNMbDhhdUxFQzdjWGEvVEdJR0syUklNUzF1RUN3L0Q0YjVVcys5VGxOc21G?=
 =?utf-8?B?WGkxQTRqbjh5OUVmQnR2UkdIdXJtWTZmYXY4aXZTU3ZpZUt2ajFYWlhhL0Qz?=
 =?utf-8?B?c08zZHFyQWxKVkFkdkNlQXpKTnpkamk0djhRTzIvNjFQVWtmUWRYWEsrcjha?=
 =?utf-8?B?MTBZaFNwM2VSWFdyQXhxUWVrcDFqaUZUZFltKzIzSVd5VW1vdlhNSTJlekEx?=
 =?utf-8?B?eDhOVE9abTduNmR2Z1R2cytlUkxSQjJmSUF3VGJ3Zk5KdHdUZXMwSHBIaGhQ?=
 =?utf-8?B?aGNXSE03L2czSGhJNmpzTmZCK0tRN3g2ZnEvRFdpQndMdk90S0pQYk1saTBE?=
 =?utf-8?B?a1AzZ2hyOEhhRUlYT2tOa1owV2pIamxTdDJCSTBRVU92TWgrdVhKck40T296?=
 =?utf-8?B?ZHJSNHZ1VklpRkxrVmdrUnhxdCtwN0s4YnVpUGp4WXlqalpvOUhBQXFhc0Zj?=
 =?utf-8?B?VU1iSzNqcDluSFZCSy9BQmlEMmt0TUhmdUdXdnRtWHdURzdMYlRyYlBsSXZ6?=
 =?utf-8?B?MTZmZGFidHNDUkV6ekdSbHd2OEp3RWRSUXFVMUVETEtCaGx6ZHdyYXVPbjRL?=
 =?utf-8?B?M0pwSS80a0I2S0V5emlPN1QrbTZEMEVYMFNsc3JvK3FzS29vaVN3OFNkUWdv?=
 =?utf-8?B?NHVTcngrSVI3aHNJNzR6R3JvSzA3c014cE1wZWlNZ2loNGMxY2VKUHQxK2Rj?=
 =?utf-8?B?dkdQT1RYZDhNMDBwc0RDR3NMUVpsR0Y4ekxCYWZYZWRuaU1uMUc5VGkwem5j?=
 =?utf-8?B?dW9aaitPNUNuWUxGL0FBcVFjeXNweXJWdDVoZWxHVDh1QXRjWUpzaFcweGly?=
 =?utf-8?B?MmhHUU5tZWxsSEx1MnN3NVFzWXVjczR2akxCWWNQSEFwb2hiRGY0WHI5ajBP?=
 =?utf-8?B?T0g4WERpS0cwTTIvRXhOcExYTFFJMkVvbUpSbjJWVWlTOThGZCs3R1Zad2hG?=
 =?utf-8?B?YXJzL0VOZExXY0JEMGZ3MUs4SlpGUU5DMjdBSjBXUWhOOWFPRFJuazNFZjNs?=
 =?utf-8?B?K3dqSDE2bGtnOThTTGtha0JDcmJISkl2YVJmR1J3aHdoYWlETXg0QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b953f6-b7ab-4b32-c3f8-08de52b08ce0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:32:16.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g98AOridvXKEhTdV3reyIp6ViDDxHmKIbQNLzcuMz02DzrdnC4hFprY09of89bSdgTD3tq6Nv6I8E/3aLkWrcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293



On 1/13/2026 9:17 AM, Uladzislau Rezki wrote:
> On Tue, Jan 13, 2026 at 12:44:10PM +0000, Joel Fernandes wrote:
>>
>>
>>> On Jan 13, 2026, at 7:19 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
>>>
>>> ﻿On Mon, Jan 12, 2026 at 05:36:24PM +0000, Joel Fernandes wrote:
>>>>
>>>>
>>>>>> On Jan 12, 2026, at 12:09 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
>>>>>
>>>>> ﻿On Mon, Jan 12, 2026 at 04:09:49PM +0000, Joel Fernandes wrote:
>>>>>>
>>>>>>
>>>>>>>> On Jan 12, 2026, at 7:57 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
>>>>>>>
>>>>>>> ﻿Hello, Shrikanth!
>>>>>>>
>>>>>>>>
>>>>>>>>> On 1/12/26 3:38 PM, Uladzislau Rezki wrote:
>>>>>>>>> On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
>>>>>>>>>> Bulk CPU hotplug operations—such as switching SMT modes across all
>>>>>>>>>> cores—require hotplugging multiple CPUs in rapid succession. On large
>>>>>>>>>> systems, this process takes significant time, increasing as the number
>>>>>>>>>> of CPUs grows, leading to substantial delays on high-core-count
>>>>>>>>>> machines. Analysis [1] reveals that the majority of this time is spent
>>>>>>>>>> waiting for synchronize_rcu().
>>>>>>>>>>
>>>>>>>>>> Expedite synchronize_rcu() during the hotplug path to accelerate the
>>>>>>>>>> operation. Since CPU hotplug is a user-initiated administrative task,
>>>>>>>>>> it should complete as quickly as possible.
>>>>>>>>>>
>>>>>>>>>> Performance data on a PPC64 system with 400 CPUs:
>>>>>>>>>>
>>>>>>>>>> + ppc64_cpu --smt=1 (SMT8 to SMT1)
>>>>>>>>>> Before: real 1m14.792s
>>>>>>>>>> After:  real 0m03.205s  # ~23x improvement
>>>>>>>>>>
>>>>>>>>>> + ppc64_cpu --smt=8 (SMT1 to SMT8)
>>>>>>>>>> Before: real 2m27.695s
>>>>>>>>>> After:  real 0m02.510s  # ~58x improvement
>>>>>>>>>>
>>>>>>>>>> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
>>>>>>>>>>
>>>>>>>>>> [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
>>>>>>>>>>
>>>>>>>>> Also you can try: echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
>>>>>>>>> to speedup regular synchronize_rcu() call. But i am not saying that it would beat
>>>>>>>>> your "expedited switch" improvement.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi Uladzislau.
>>>>>>>>
>>>>>>>> Had a discussion on this at LPC, having in kernel solution is likely
>>>>>>>> better than having it in userspace.
>>>>>>>>
>>>>>>>> - Having it in kernel would make it work across all archs. Why should
>>>>>>>> any user wait when one initiates the hotplug.
>>>>>>>>
>>>>>>>> - userspace tools are spread across such as chcpu, ppc64_cpu etc.
>>>>>>>> though internally most do "0/1 > /sys/devices/system/cpu/cpuN/online".
>>>>>>>> We will have to repeat the same in each tool.
>>>>>>>>
>>>>>>>> - There is already /sys/kernel/rcu_expedited which is better if at all
>>>>>>>> we need to fallback to userspace.
>>>>>>>>
>>>>>>> Sounds good to me. I agree it is better to bypass parameters.
>>>>>>
>>>>>> Another way to make it in-kernel would be to make the RCU normal wake from GP optimization enabled for > 16 CPUs by default.
>>>>>>
>>>>>> I was considering this, but I did not bring it up because I did not know that there are large systems that might benefit from it until now.
>>>>>>
>>>>> IMO, we can increase that threshold. 512/1024 is not a problem at all.
>>>>> But as Paul mentioned, we should consider scalability enhancement. From
>>>>> the other hand it is also probably worth to get into the state when we
>>>>> really see them :)
>>>>
>>>> Instead of pegging to number of CPUs, perhaps the optimization should be dynamic? That is, default to it unless synchronize_rcu load is high, default to the sr_normal wake-up optimization. Of course carefully considering all corner cases, adequate testing and all that ;-)
>>>>
>>> Honestly i do not see use cases when we are not up to speed to process
>>> all callbacks in time keeping in mind that it is blocking context call.
>>>
>>> How many of them should be in flight(blocked contexts) to make it starve... :)
>>> According to my last evaluation it was ~64K.
>>>
>>> Note i do not say that it should not be scaled.
>>
>> But you did not test that on large system with 1000s of CPUs right? 
>>
> No, no. I do not have access to such systems.
> 
>>
>> So the options I see are: either default to always using the optimization,
>> not just for less than 17 CPUs (what you are saying above). Or, do what I said
>> above (safer for system with 1000s of CPUs and less risky).
>>
> You mean introduce threshold and count how many nodes are in queue?

Yes.

> To me it sounds not optimal and looks like a temporary solution. 

Not more sub-optimal than the existing 16 CPU hard-coded solution I suppose.

> 
> Long term wise, it is better to split it, i mean to scale.

But the scalable solution is already there: the !synchronize_rcu_normal path,
right? And splitting the list won't help this use case anyway.

> 
> Do you know who can test it on ~1000 CPUs system? So we have some figures.

I don't have such systems either. The most I can go is ~200+ CPUs. Perhaps the
folks on this thread have such systems as they mentioned 1900+ CPU systems. They
should be happy to test.

> 
> What i have is 256 CPUs system i can test on.
Same boat. ;-)

thanks,

 - Joel

