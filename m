Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD62FD7B8;
	Fri, 28 Nov 2025 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320392; cv=fail; b=Ody8q2w1+Gu7tC5S5Y/UZh4G/5f13pICCBmdvK41PgGMnBG7h8X1AyCzgNeWD1zp364wSj/wKi7NUW8elTUK0fX2v19hlFYNU1lsMTrE9RvUDV8H2ioQShYYpal065N6mGvky9A7EJ6OM1RbFtXIZ9DRXNe8NSrowN6EeJzqze4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320392; c=relaxed/simple;
	bh=Pr1uzoyt058Z6/0DynYIcrviDLe2TcAkCJ3LA9HXcL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fe8Jbxps/5GxCkK8ugeNkq8DWHwSLpVsK7keeH/bE5DZJLf0xdNw3fNVcMbFmWqh0Oqt0vEh8g+GIeeNegNjPJo+hT9mBZop33mDdUME1v9uZbhZ7okAGAcpSb0xjJNyES1IfEGBdI/U93YMxoLsqh4Tl++qNaAadqM4TLxX6CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VDtfR0uq; arc=fail smtp.client-ip=52.101.48.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VDtfR0uq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpwP9IywB8nVT7Vl0W6kH+gfERiD53FKn9J1ubSWaTtbN+lejYMast7LquQ0Zn/u2eACc5zB2RlQq7sAMOxP0CpLZbHw1aERvKamEKq3ismpWl9SzyUDleHsaE+0hNKcRs5dKvSDyicCKd6Pzf65HzZjkXNDzv2GFjUvP3TDtmi5/HzNsg/G8SxDefOJGQx7DsTZk8S1FisIwkICre/IzozEaLctf5qSircRflKRX8McSYWSid2WmaG1fHRmmLQAQ+3ilowu2Qhi4oWCL9FhlS5VZ19hgqXcsQSpk5LqKcH2maaMTRPQ8dYsO8oOH8oUEaNNfpB68dRW+vVuofMSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nUthk21QCH5xhcefetuT31DLXClQC41vNRDRO9+LsI=;
 b=HfOJFHs2oOIh8Lr7McM6mr3znwL4lsvgEydRQwNZ1oWnoUXnlaMiYww//UhxYRynyu0CJwevr62aGdC20nN8SQmo4C9SbbhdOhjBOdISrAiPSUIkNiNQTRQ5vH/3wCj0Jbny0aVHaDRkU0QP3ApMmGAKWCzywToXktSfa1k5VHA1PEq/7J+YtjqBHG+bBEfgdb2bHArtXdV6WQR08UM5c9exsc7umrHfeJP0xk/ZiES3EorHJZHPgkjilDQi2xxBTlwGLWmQNMQLL1E/64+Bzmu1lm/PtbTyHSiNRSE97gcu3gL9JldG/YK+bOSrwtyOGwn8FFaUA+L8VSIfkERzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nUthk21QCH5xhcefetuT31DLXClQC41vNRDRO9+LsI=;
 b=VDtfR0uqcsK72BgTQmlzd1VvOEA3eVHQKYThHaloYdw6Ta2KVKshedB6/NCxoAWf34/oMiicqUzL+lk4DpULvWWlXkgVMsapjuTXIPRa6Jh8NuJ3NR1mAZ/itZnL3oPAqmeiXVIY3yYaxAE5Qp9M2H7Ols+1PgORMDzFi2zG7lqqWSyySeFiX44D1TiGoR5lSti4BPRb5CIjq21VzW0+TAv4NFgf4wi8lUMITSgBsqXbMKFK7Y7uNPl5HpN6+RzxL/Njvi+jxrYjZqAzcbMofRzWicbeg5GqYaeDF/aoMTKNlwL/0CM/IrHVQR/S88QZnaxtjm6qXv0at/HOthLNLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com (2603:10b6:61f:fc00::629) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Fri, 28 Nov
 2025 08:59:45 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 08:59:45 +0000
Message-ID: <8dd08cb4-b7a4-49c8-be16-fc6443daab05@nvidia.com>
Date: Fri, 28 Nov 2025 08:59:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu()
 operations
To: Vlastimil Babka <vbabka@suse.cz>, Daniel Gomez <da.gomez@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-modules@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>
 <0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org>
 <e988eff6-1287-425e-a06c-805af5bbf262@nvidia.com>
 <cec33567-57cd-44fb-be9b-1bc86f9b30bd@suse.cz>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <cec33567-57cd-44fb-be9b-1bc86f9b30bd@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0551.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::19) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: db5b2a19-581b-4c37-56d4-08de2e5c79f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFpPd1N1Y05yZHNQa1NzemNUbUt1MFBKQUx0aUdoTjFzcnErbjRYQS9rQSt4?=
 =?utf-8?B?WjJDWVFETy9yYlhlUUNaclVRS3B4NkZ2UTdFcE5QZG1aTXQ4ZnR2dHFVTTRs?=
 =?utf-8?B?Sk03WjF3WmlNeHI2UkZ1L25xMnNUMUlPbFJVS2pCa0xWYUVsRHJ4dEJyWThu?=
 =?utf-8?B?UERvbEtJMExIM0lxVDIySWV0bFpKYnMvRHlxdXBtd1R6cmc0S3BxU0F4ekl0?=
 =?utf-8?B?MUdkMjRRVy9xcGRTRWxwMmJjY2M2R1F0a2JyS3BPelQza1NWU21uRmhuVVVD?=
 =?utf-8?B?Qzd6SHdQTUluVHNXZUI0UTMyVWlWV09xVkhxa0Q0U2pCaFlZV21ucUhZZ1Y0?=
 =?utf-8?B?VnJ1eEJ0TGhrRFJqOU5XNlY5czhzNU8xaGt6bExxbE1NSmM1V3FORU5QT253?=
 =?utf-8?B?RzlUVS9ya2JQWnR3eWpCZTZ1UGxXSWE4ZmV5S0JWeThZR2pCNkxIV0pEdGo3?=
 =?utf-8?B?cTUwbjAvbnp6aDZ3eVdxS2tmVnF3NmJlTTVqQkJKR01hNjRXcjlYa1l1QTRk?=
 =?utf-8?B?ZmVwSmpsankyRHdMcVVlbGtwZUUvU2ZBalBjMXRNNU1yMk9oMExVcmNiWklG?=
 =?utf-8?B?aWZkRk1Sd2EzLzFDZ1ZlMDd4NU1ILzFncG1Vd21kUWxzVmhoZnBxejJldlBC?=
 =?utf-8?B?alhFMkhZVTRNZWJWaFlOd1ZuMGJkcUR5VldvYzAxQVlhM3pWTElLaGFSQnI2?=
 =?utf-8?B?TGxzeEZna01XOTRDOE9QSCtTTEVoUHJENVdkYzljNjk5UGlSOUN1UTYycHVV?=
 =?utf-8?B?UWZSYngyK3dNZTZoeGMvUGpRTE1qNXRaL3pUejRwbGZvOG4wekc2UGw3UTBm?=
 =?utf-8?B?eUdCL1FIbnkrRlFYSWZNYUxIazZWVmg2Tm1hVld6dEtqOWtGTzVGQ1lnZWZv?=
 =?utf-8?B?TjY0Zmt1QnhCdWl4MlZSRXlhYXFMeCtrUWhXSGtqaHdqMjZ2bFliM1FMZURk?=
 =?utf-8?B?eE8zcDFnYVRkQk9zWUFDMnFBdUZ2M3lucFQwOVp5d2l6MVJnMmc1YmpIa2Ry?=
 =?utf-8?B?Z3NxbnlPaXRGNE14aW1hcGMxMVB3UGVVYjZPSldVTWZiclQ4dVBTZGJKa3c0?=
 =?utf-8?B?ejZaL2VQTFBraHo4bDVyU2lodWdwYWdVUURSa2FRNkxTaW1kK1g5cTJsNnRB?=
 =?utf-8?B?SkVXRGlROGlWUDFVTEV4SjYxbm5oYnNXc1pzR1ZaOWR3NUlZUDlaWmlyU2Ur?=
 =?utf-8?B?WmtHdU1uTllxamJQNkFXV0ZOanhneGQwSWRoai96L01yRXNFVmxmRkoyMk0r?=
 =?utf-8?B?SFVRY2RoTlhBVUFobFQram5XTE1GU3ZBSjNJYi9zMVdUWmhPVXExS2szSG5L?=
 =?utf-8?B?UFpLemNJWHI5TFNSRkZ4Wk9pZ3pTSlUrTm9LMll4alN4cVpBMHREWVJDMytV?=
 =?utf-8?B?M1NOVnFSMWpGS0NSak92NU9JR0p5Q0hsUHNEUlczaER1Z3pZSS8xQW9ybGFK?=
 =?utf-8?B?TTQyeENRMVNVSjlraDFDQW9jVVhzTlk5eXBLb3UxeHRaSnlndkY1K2xZaHhi?=
 =?utf-8?B?amN5VC9qUEQ3eVRsR1JOTTBqTGJ0dzRzVWhkUVBYbTNLTFNuK3JyUElEMzNa?=
 =?utf-8?B?aTY4QmNWVExrQXlnWUZVaEJaOFZFTy8wUXQ4eUJXR2FyYlZINkdIS1lVZEJ3?=
 =?utf-8?B?b0FFam9WSjJKbldINC9KYzdBMHJqRHhPcGgvRXl5TUtoVXZIMXZsajdGNXdU?=
 =?utf-8?B?OTg5K3pNZFQzTXVwOGNJZ2lRRVAraFJaQmgrSERIVWRxZVZjOXBQMjAzWktE?=
 =?utf-8?B?STQ5K090V2ZTRHRYRGNZdGJpYmhWaTVZbkdWMFViZWtoVE9ITlRBVVhmZGZT?=
 =?utf-8?B?UEVzRmNxTGMyYzVpZkptVllXV1JBMkhwbjhyUjBUZ3Nuajc2N1hqSE5BQUFt?=
 =?utf-8?B?d2hqaWc0dE1hWG1FcnhqMkFCaFFUTjhXL2xya2d2dTZ0bDEzc0hlSGMzMEha?=
 =?utf-8?Q?pTcoCGIOqmu+WiqyQ41X8SBRxopDc+UX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUFWc3NTdWFneld5ZlluYjY4aW1nN2JGVXcyeUVlS3NNaXVFUTlSZTJ4VWlj?=
 =?utf-8?B?SEdPSWNCRXdQN0k5d2F3b1laMVJuQ0JRbW44a290dy85ZHpXZXU0Rjd5OFFR?=
 =?utf-8?B?UE9mSFBUNGx1SlVIblpBV21oY21vQVNPZjJoOUlXTFBBWFc2SWdwVE9ISDFI?=
 =?utf-8?B?ZlhyVzl4UDNsRElPYk9CSXZoaEZQaFZNSG94b3RNT0dmeitLTkVQRnptSE1E?=
 =?utf-8?B?ZGZBNzlBcStiR2FtSld5NC9zcGE2czBYQURPRG5HK0VRYVA3V0hxZzJuT1Fp?=
 =?utf-8?B?b1F5dk1xcXFhbGRZTFJsaWZwOElMUTJGQjk2UDZCWEw1OU1sRkQvZ256NDh3?=
 =?utf-8?B?S0lTRVpaaGJSMzRGN2ExODFVMkdvM3REekJXZFRkN3pQcmRZMXNHRlFFd3NR?=
 =?utf-8?B?cjcrejd2eHFrYlh1MmM3ZEluMGdnNSsxenpGWUFwTEs4ZTJiME1EaFVYUm5u?=
 =?utf-8?B?RnNnM2JNMEJnQkN2T1F6cW5xWmtGVHEvUzFMY0NCL0NaR3luZEdvZWZ1UnVV?=
 =?utf-8?B?S1htUGQvalpDTDVNVHVkWVpWTDNMK2YwSWh0eXlJOGlXMHVZNmFxUXQ5SkdM?=
 =?utf-8?B?Yy9SMUg0LzNLdHBjWENuMVJKVEZxSTZNTnIwRHo4N3RSaS9WTVJFZnBpR1ZB?=
 =?utf-8?B?S1QwUCs1NnF0UjNyZkZ2NlFSMUZRM3dzK2tyTW1vb1N0MTNxWDJhOEFIckt3?=
 =?utf-8?B?djNYc0IwaGRvTXZTd3IwT041eVUxOFZRdnpvMWsyQzZNUnBzQnp6V0hHSnVS?=
 =?utf-8?B?VVJpNWJBd2c3NUdHM1BMWDg3NVh4dkVkeWI4OE5WbkcrZHJqZTk4aG0rYjMw?=
 =?utf-8?B?VFJ5eXhkYmRBa2w5Q1BhOE9KVWpneW8xa0I5Q2haZEpUdHhzUTYvTGVoOUVX?=
 =?utf-8?B?U3RiQ3JsZ1RrekhNZ2o5eHVwUFdOZFVBNHRMMFJ6ZGcweDhqZ0hlcFdSamd6?=
 =?utf-8?B?REprenk0cG5BU3E0MG1VL3JJVlJyZFhmM3Vqc2hEODNJa01zY3Z0aExyZGZs?=
 =?utf-8?B?MFh5cDZNSTVzdHBHNFEzWTk5dmVTeUdCaWFIUHBYTEpNa3RxMExKMXZXZTlN?=
 =?utf-8?B?MzdKU0FGd29tSGxhWm83UVg0eXZmTFVtWDVaeVBTWktwQ0U0TkVvQVhwSnpP?=
 =?utf-8?B?MmY0d2ZBai92dlpySVVnVkZoS2F1VlJrS0NsZEtWS2FFWHJpb3pSajFucWRj?=
 =?utf-8?B?bkZ4REZiTGJnemtCUnJOVS9tN05JUVJxMVBTNndYTXhuaE82VnJKTUhJa0p5?=
 =?utf-8?B?bytZczViSVdSbEdYRk1jUjZBOWV1aGcvT2JZZHNlSTVQWjJwWmk3cVZ5K3o5?=
 =?utf-8?B?cFN5UW43enZyNllFL3NJL2pSeXBZaGxSUFNnOHhsMXpnUmlGTWkzZi8vdUlm?=
 =?utf-8?B?OUVPYi9yU2pZMWJvZFp0dVBuNFhQaGc1aURYZkNJNU5iS20wRUl4NVkwWWNn?=
 =?utf-8?B?dnVvbE52U0dpMEFGSkNJYWttYzYvdHFKUzZFL0xZcFJKU0ZRRDhQQ29rSTEy?=
 =?utf-8?B?d3NrdE9XQ1krSE5uMVU0d25ES2pUVUwwVVIxaForcVpBY1ZBUExtZjZrTkZw?=
 =?utf-8?B?NUhaczJDaDEwYmhvL3Z5TGNMMnpQTjIwNHBWTnp6ZTU1V254RXp6NHRndk5U?=
 =?utf-8?B?cXh2cEcwdGlvOVZ1c1pObTNiMTFyWWpEK0dwYTZWWkpaVjgySk9vUTBSR2JN?=
 =?utf-8?B?T0RybUQ2SEpVcFJyM2lFMTIzdGFCeVEvclNVcXc3cXhiZjM1SzNCbm1WdDR5?=
 =?utf-8?B?Z2V2aTdVQ1NPL3VkQ0ZSaXdwaHhWWGVVWkdRZDZYTEh4enAvaHpqdTd6VkxH?=
 =?utf-8?B?RmNLNDFwdllxbVB3VUhUbnBJWDkrNFU4SW1DdFFRaElVSjlKMW5pQTlPQk9r?=
 =?utf-8?B?N09naVQ5QnV0S1FJZTQzTC9MeXprSXEzQndZVjl2UGJOMFlzcnQ5bVNldzJr?=
 =?utf-8?B?b25EbWtRTENkanBpZy81SExscCtjRVJYcHFQdVBwTXNka3dldk9UYVNrb3ZJ?=
 =?utf-8?B?c1EwNzJWYXJiRmVxTFVjUHphakYvM29nSmdkN2NXKzR4MWc3NlNoMVFPVEow?=
 =?utf-8?B?TXczQXVBdWkwQk1jMDBySVliQ2FKSXZEeVZWc3VNTGJJcnZYYVN0a1BqODNS?=
 =?utf-8?B?b1ZEYXJkbDg5Wjh1aktJTjRUVVBFK0puN3JGRW1IMk9Oa3JWTGErR1ArUWps?=
 =?utf-8?Q?YiOKhBdHeaHXj6tQMwLP929CWmy2AcFfUp0SA61Ke5Y3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5b2a19-581b-4c37-56d4-08de2e5c79f6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 08:59:45.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jSFmd3Uz8394KvIbKMzlv0+oG3+Q4ZW/zwzAgU3nSnxpfdFiqadRVdjbfAjfqEnvbAFOBreWSCNzascpjGQxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2


On 27/11/2025 13:18, Vlastimil Babka wrote:
> On 11/27/25 12:38, Jon Hunter wrote:
>>
>>
>> On 31/10/2025 21:32, Daniel Gomez wrote:
>>>
>>>
>>> On 10/09/2025 10.01, Vlastimil Babka wrote:
>>>
>>> Hi Vlastimil,
>>>
>>> This patch increases kmod selftest (stress module loader) runtime by about
>>> ~50-60%, from ~200s to ~300s total execution time. My tested kernel has
>>> CONFIG_KVFREE_RCU_BATCHED enabled. Any idea or suggestions on what might be
>>> causing this, or how to address it?
>>>
>>
>> I have been looking into a regression for Linux v6.18-rc where time
>> taken to run some internal graphics tests on our Tegra234 device has
>> increased from around 35% causing the tests to timeout. Bisect is
>> pointing to this commit and I also see we have CONFIG_KVFREE_RCU_BATCHED=y.
> 
> Do the tegra tests involve (frequent) module unloads too, then? Or calling
> kmem_cache_destroy() somewhere?

In this specific case I am not running the tegra-tests but we have a 
internal testsuite of GPU related tests. I don't believe that believe 
this is unloading any modules. I can take a look next week to see if 
kmem_cache_destroy() is getting called somewhere when these tests run.

Thanks
Jon

-- 
nvpublic

