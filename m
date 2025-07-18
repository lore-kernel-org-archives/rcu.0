Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CC1E98E3;
	Fri, 18 Jul 2025 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831781; cv=fail; b=d+M1KpazkbD1OZWGhPyhxHPhMJisQKr5fLY4FKDlQf2rveFS0O5zdhdtiSJPzVssHTR9jUQxEGA7bYp8vlXZL75FTW/9VC0s1mexonV2Egy4d7WVvqKUQPTWUCud61DaoJjUP5TyPPCUXOoY9c/ESjBIY2juDi/7GlD87ZTXqd0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831781; c=relaxed/simple;
	bh=dbHmX42L1wDyIkflEA7A5KieCuJDB1j6Zqm60Q51mBw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FiMJ4ItbUaFDNRZC8qZWmtMxrh9OpHBjBBKnj07BpDHwXY8PKDYleKcRmG7ggyyIbKnryUbBTjLUAwy4kJoy3s/TYo+shYvE1L804dk03Cxq1L/R1Pu+RkDy9j8cEsic/wIOpK4gJ43R2+gYBmwx3wqmj+qN52v5J2FGek12ECQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FsEnoKsE; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FsEnoKsE; arc=fail smtp.client-ip=52.101.70.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FsEnoKsE";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FsEnoKsE"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dBIzYPKzcwG61RkCq1CvIscgkNajaJ4JBJEYO+iPAWqMnuiODmdn16QESmnnmp0OVFlSlOQsEjgNt+EhEz03V2IZDilQoudMpRZQimccyJ6Xcbkd5A9O+3ulxI1kBu44q4Sdah3dGwWPM4+eOe0FZMO1EyQ9VCNuLkyr4JyP7mgwut4Rd9gYncoGRXHZsG8VqF9EXy8C2Hd/0VBnzKu2vwON63lUXqan1f6S6sD1yekXn5lkujCgQ60ctoJMkAetE5BBtDUMzxOJmPPwhGw4U4eDaC6nqI2vD9t99HHEj6ICXyStH7SxCHYa4Kzo5y9k+9nFv7loz5ud5L9lcjWMgQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1Ti42N6RecnF2+opjoLfkHvf1lg1LovsfH3dEEb37A=;
 b=IsOKw+/1t/OEzT4PNV7oqfa3dXiyJ+md19b4m7V0vGAiPnhzKOfswA75TP3KYdz9cy/Bm1j4yNuTXZxw1G20+qt5DGm5IkkYbJ44sOZSxro9YBREd+SSGjpxfJvKbp7g5cDiNdkMQSzJPsW76UCZbL5BXAkCqYN5YxVf3sOaTy6eLeKh6HzLP2vBetOnVJB8050VySrJ3nqHOjsn2r4bRmPz/ABn0Cltk81cU4b64VmXS3zaUMC8hGfhwzgF0N+neeswM8na1elxIzmQDqPF8K4Pp828ux4eF95gJwaS5W2bLe6NROctAsVrwwhuFCwGaB33I0Hv2ERUUbf8lqQf4Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.dev smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1Ti42N6RecnF2+opjoLfkHvf1lg1LovsfH3dEEb37A=;
 b=FsEnoKsEAeLhKXpLcSGJrvlNf57GeKlqZ+YiiUbWSyi/aUG3cLCDyL7OzmmKl/UeObY0tTot3RO16Wu5knFHd+5/rDPbBZhpmi1GPwGChNG1zOYFE7FsaDFz992VyIExRxP4+QSHyqRihvpRO009bUQL4y2xOds12EP1uVFQi3E=
Received: from DB8PR06CA0050.eurprd06.prod.outlook.com (2603:10a6:10:120::24)
 by AS8PR08MB9953.eurprd08.prod.outlook.com (2603:10a6:20b:635::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 09:42:53 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:120:cafe::81) by DB8PR06CA0050.outlook.office365.com
 (2603:10a6:10:120::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 09:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 09:42:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQ07CSAoVvMwfQ09lpLAhCWfNwlUX8zndbFGSet7HvZ3uTMtAjP9CU9pWqaXkvWglnaIG7NqpeY6ZomseCOYvMALy0dPmZx7i852ChtqlqeyXhQkqbu4TsA/dIYSjJ6qptvQ5DTDktZwnCoypZg4MxyaGt3eGgWxp4iKNmtQiPK3fgaA06xyNtTz6lNxh8libjlP0o7ZwAdEmh+zYhH8yilCCck0/YmedmRRLQCsQbCuktBD5mx/JPta4kMev+D54XI0KjWB2961Effsw3Qz5lJsp/svDk2GV2Qloqxwb7tsjeAo5gjRckFYf2fKPllyERkeqFDdNLnjNCqTInS+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1Ti42N6RecnF2+opjoLfkHvf1lg1LovsfH3dEEb37A=;
 b=h76ndhJlGemO7XPA090PUEZaAbPiA6WgLhF6AgiMa05mLOF1r9t4u59RSaiZ5Moz1uVKnUoUlFFze+JXTbI9bgPmVsyrFzoUMmbtf2NKjqE+qG1TD5pIB09N2dUHqvX/WjGVJ043sH6MxfnSSskrbH5NOrmHGWkyp7mbL66x+td2iZRmbpFC+08muo1lPLIl9svIQhN7bVGJplxFdVHqSXtdnBzJlZ2upNSY96Zafn8ljLkg81BxvVFh/Pm8ffHyy67VJS/fbZPjxvfE+hSepeVHq6Xp7Ydt7pRNn0D3ljSGe9+Zg0WmsG/T7ozHpbEoIBQVdkiin4prv3OI4Jb/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1Ti42N6RecnF2+opjoLfkHvf1lg1LovsfH3dEEb37A=;
 b=FsEnoKsEAeLhKXpLcSGJrvlNf57GeKlqZ+YiiUbWSyi/aUG3cLCDyL7OzmmKl/UeObY0tTot3RO16Wu5knFHd+5/rDPbBZhpmi1GPwGChNG1zOYFE7FsaDFz992VyIExRxP4+QSHyqRihvpRO009bUQL4y2xOds12EP1uVFQi3E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AM0PR08MB5489.eurprd08.prod.outlook.com (2603:10a6:208:18e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 09:42:20 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8943.024; Fri, 18 Jul 2025
 09:42:20 +0000
Message-ID: <fe7024ec-7950-4dcd-bea2-4a9efe91e72c@arm.com>
Date: Fri, 18 Jul 2025 15:12:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Replace (20 - PAGE_SHIFT) with common macros for
 pages<->MB conversion
To: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org
References: <20250718024134.1304745-1-ye.liu@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250718024134.1304745-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::11) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AM0PR08MB5489:EE_|DU2PEPF00028D05:EE_|AS8PR08MB9953:EE_
X-MS-Office365-Filtering-Correlation-Id: f96f3b04-01b8-41c6-6da8-08ddc5df770e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?d3dqbUxaOFhNTFBhK2tLdzdDYjBpaUJEajlidzVnT1YvbFQzSHFpVXBSdzNr?=
 =?utf-8?B?OVB2a3dGVXdlNkpiSi9GTExGU0xSSmtLSUJYVnVHQmlHL1hsdmtSb1Vrays4?=
 =?utf-8?B?Ym1QRXhnVERHdVZOaFowL3dxRUt3a3ZCV3FxekdsU0c5MElQcWdYTHFJTGpK?=
 =?utf-8?B?WlFJNzU1RE9tRUlIek9xNDY1clNpdytTYlRnOFo5ODZZaDIyODZsTFJlYzZS?=
 =?utf-8?B?M1hadHpXemxPa2FjY3Vxb0p2bEZjTXlibW0zZ0Z0UUx1cXZ3bHRVdlkwaEgv?=
 =?utf-8?B?cGc2ckdyeC8yOVhYS0NvRzZOKzRrZEVOWFJRRkdoRnlsK1c5ck5ZNjlmNjBO?=
 =?utf-8?B?RFRTUWk2ZzgySWNyakhiNzJJVHNDRXc1QzBiM3VXRTI2eHhIRWdkQWEvQUx6?=
 =?utf-8?B?UmVidEh1M3JaU2txeXRSVndYU0RpTHBnblg5VU00SDRPb3UweG9RWWZmVkh1?=
 =?utf-8?B?bDhZK2JoT0hmbGdteFh0Z01UWmVzRFZLbEdNRFVlNVpiODBXUGM0OUsvUnpm?=
 =?utf-8?B?T21ra2x2a3pOR1lBd3d6dy9HMjBMVGg5c25sZGR3RGxrNnE2amh1MzNFL3F5?=
 =?utf-8?B?NDNVWDJMdGYwaFR0aVV1NVNNRDlVVXVMTEFHZVhhck5uaUtqRjJMdmVXUlNY?=
 =?utf-8?B?WFM2bUZyR1hCbk5tSkNSeTUram1Uc3pDdHBKanNnbVYwTzFCYlBBQTA0OWlQ?=
 =?utf-8?B?L1BObW83Uk55Y0VNZ3RLN0JkOENUdHNiKzZzdElEM2NJTGdpOUNLeG1XeXQ0?=
 =?utf-8?B?QVZZeWkwNkNaOFI1NWtERTVXRnJxSjJHOHh4dVpWS3dEcGorMjhIYm1IdWJm?=
 =?utf-8?B?YTRqbEdmT2EwRmNFeGFtNHdESnF1WlUyWkZxdzh3K3FJZllkRGRrSWNaMTRm?=
 =?utf-8?B?ek9hSFIyMjVDd2RoSUd2THVoR2N4VUV1aVk4ZERUTys3dHc4N3VJOGo1QTgw?=
 =?utf-8?B?VFdpN2hmN2xVK2kxTnIvYitlWWFNSXdhaWJHZ0l2ZjhXTlRUTEtPOUFFL3VD?=
 =?utf-8?B?dXBJd3phTWo3bnNLSi9USFFyb2VMa21mVEdySVJXWmRQdzlvQ0JJY1lQa3dD?=
 =?utf-8?B?NkpPVit1NDY5RDVpMEVVY01UOHlEU20vYWVQQ2sxdGh5Q3hIQmpnSTdkUVpY?=
 =?utf-8?B?U1c3MWhia0xNQ3BFZkFSZ1NTalgvdStsd2t3MzNKWkx2YmEwc0N4dzVjb3lx?=
 =?utf-8?B?d2NDN0JiYzZsTmtOa3RFQ1paOTZjYms4Qlo3SGZXdjRPZnBQekNVTjNTaVg3?=
 =?utf-8?B?b29JbHprV1kzekZTSGt4SzI1c1h6TmJMeDlPRFNWWXFQbjNINXNsUnIyaCtl?=
 =?utf-8?B?c2xNOW10dTlJWlJldThUa1dyRjRlQm4rNlA0RjFHWFkxZFpjdDJWRmE1S0ZQ?=
 =?utf-8?B?ZkdQdVFtQkl5N3RMeDY4WTVUejcydVJBdUl4S3BobnFKclBiN1FUQmhwZ3l0?=
 =?utf-8?B?aUxQK3c0Z2E5VWFtekt2YWt3Q3BzNGJxcXZaUy9NZVQwNDVvNG1CY09DT0NN?=
 =?utf-8?B?eXhJVnJ5eWNpSVFUV0gyT1pIOFRLYXdFZm84ZC80QjE0bFlDWnpXR1dGM0c1?=
 =?utf-8?B?eVA0MzQ5ai9DZCs1clE2N3M5Ukp1dVdKMFZXRzVHME96TUIvMXBGM0w4NWVh?=
 =?utf-8?B?TmpFUExEK0lNZXY0Z25PWjI1eEh0bWwwdGNqZXphdWdmdGZEdnlFbDlwSHc5?=
 =?utf-8?B?dXdKcnppK3dJVEJNVFd2WkhFOWdTWC8rSW9pSERmeHFVM0F5VE9yVHRmRmRC?=
 =?utf-8?B?VTlMQXFCK3JvWTRWT0UwWVl0a0pBdGJJclRkWGgrbkJqUFV1dEFlTk44S1Fi?=
 =?utf-8?B?ejljUEVvazdFZ3lFQnZORm53dU5EU2x3WVNiUW16L0QvaFZScWxnVzNsRXRH?=
 =?utf-8?B?bTQyUlR6N0YrR3dmWTY4NTZHUFV3T1lLWlUrWm55N21mTjRQWHBMMk42Y2Uz?=
 =?utf-8?B?UHRrUTNjd1hCUHFNakl3TDhMdG1DRTRORldRWmExcUloWmxiQnZVTTBXbmZG?=
 =?utf-8?B?NllHQmYzVmpnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5489
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1e58d5ec-3b86-4fbe-09d2-08ddc5df639f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWNuMUI1ZUJsb0VjOFJYdE9TWVNGVHlDaXhtcTF6ZDJzQm1CR2M5bWJCTXdw?=
 =?utf-8?B?RVpqNHFVTTJPOEorb21HSldqamJXQVMzYkNhRS9vaGFFa0VJS2lUNnZFUTly?=
 =?utf-8?B?b3Bma3c4bEhpajhnSm1VeGFpNndHZmYzY3F4eVA5ZFhRWDFwVDVyMzNYOHE1?=
 =?utf-8?B?MXFMcExtOWE2b1ZpV2hWTFk1ck5jSW5mMWlhd01NV3BLS1N0V1Q5THdPcHVS?=
 =?utf-8?B?Y0duSjQrY3VDTlJiQWwvTy9xRG81M2pXQWN0eUl5V2pWU0pWUER6dU9oVU14?=
 =?utf-8?B?N2ljU2ZwaVBGWXhBb2RtcU9pZ2diSjdUODFqYTR3QjlTQTM5ZHducHZHbGNm?=
 =?utf-8?B?TnBrV05Hd3REWUk5OFBiWjIzbDNYNkNWakVyU3VYL1RIVklDZ1lFaG4wbnFF?=
 =?utf-8?B?MURyZ0krRENIcytHL1MzQ2FDZE00QUs3enNyN2dTcTMrUWlDNVduTjczcHdC?=
 =?utf-8?B?M2J4RzVESWpnY25HWk9OaWlvZm93cXozYTg2Vy94dG1CeVBuSHZyM0h1WVIv?=
 =?utf-8?B?Wld4S1hXYUtzdGhUNENTZ2pVZno4MllJQmNlcmdnSjlnbS9TYnplMURJNGtR?=
 =?utf-8?B?MjJyYzBDTlBQUlBQYzJKVEl5R01jR3Nnb2dvNmZSUXdCbStoN2RUUTNUTGdB?=
 =?utf-8?B?aUVpS0Z0V1NMWHM2Tk5VbEtDakxJa2JPQzlKRU5LV0p3S0VPRGtCbjB1ZThF?=
 =?utf-8?B?Q2doOWtnMUJDQmg3Z2FzWG5NL0xHVWFmWE5JOWVRd1dKZVhtRzVLaVJtQnNY?=
 =?utf-8?B?ZGg5ZkJSRTkya1JFNUtRTHZ5Unp6bVdzTUNRd2lmYVA1K2pkaWp5YWZGR0NB?=
 =?utf-8?B?RjJRQ3F3RTVyTWs1V3p4anRodGFyTGhLNzNsbHRxOEZCaWZuNjNReStXVWZo?=
 =?utf-8?B?MGFRcVB1OU94V09UNUZBOHI3aTBJTmFJS1NBN1pMaGZNVE1sMkhjeDM4bjZW?=
 =?utf-8?B?UXFMV0VtRlo0VlEwMnJxT3psdW5tUVlpVHZpTHRWbTBaU0VQNkZ4QUhJT2sy?=
 =?utf-8?B?UzNINW93RjNRN2w0UjF5d01iNmRsTEpRbTZFSlZNbldkcjZTRXpIOGpGc1px?=
 =?utf-8?B?VWxwT1ljU2REbkozbmk2TElLN2Y4V1BjVGkrYkk1K3JSWkdjTjIzWW1ReHQy?=
 =?utf-8?B?YmxWYjg1amZEN1FySFRIOFlTSzBVTFFjZWMyMWRzRE9xRXlEZDFnVGp3UTVN?=
 =?utf-8?B?RGt4VUJiUENBL3ZpTVpTZ1IrT0kyaTJ0N3lybVNjemM4SjAvNE80eEIwZ2RO?=
 =?utf-8?B?SVl2T1NkeDQyVVBwUC95aTY3a2lyMmtqUkQ5YXJMZ29FTU9SOFIya0h2Rngw?=
 =?utf-8?B?ditHemNyQWc0cnpTRy9EdU03SWFBRFhWNjd1dE5qTFduTkczMWZZdm9qZjlD?=
 =?utf-8?B?c25GRGlWVzFXd0dKSzFQdlpWREllTDdPVUFlZWZBRUJ4Rmh0cjZ6UzBqY1N5?=
 =?utf-8?B?SEhUODVrU3g0RTMvYnFkWFQwZ29hWWpqOGZsSjFLOEtUQjl5bGc4VStEVzVr?=
 =?utf-8?B?VGVOSnRCRTBNNzhsaXFlQTV2KzFBaGFLN1JZOGJVM2FVdUFTSEtLOUF3WURZ?=
 =?utf-8?B?TzFxRnBWeWVyTE4zSkZuMzNIK0FldEd3RGhLcTFaaUxLc1dFbCtWL3BEeEx6?=
 =?utf-8?B?TEtpVGJ4dFNjcjhtTHhaQ3RLY2doQm9kbitGbmRGb3EzRHdNUzE4a004NUJ1?=
 =?utf-8?B?Qkh1YkhmSzdLZkgzV09QQXh0N1ZHU3FPVU5tMG52L0pPcmJmTENtVlc1R2Vv?=
 =?utf-8?B?UG45L2xDbzYrc0NkR0ZSd2Q5QzYwWVI1Z3Y3Yzh0WDdPOHU5M21UdUh3R0E0?=
 =?utf-8?B?ckFuRnVFZ2tKSzY3Qlc0cStPd3pjS1U3QWdhQzU5S2U1NmpHdlZCaHhLV0VI?=
 =?utf-8?B?MVlZYTZJUHRRRmpZVHpubHBQRGVRRG1MblUyaHpJMnl5N0lOaW43UDVYZDZn?=
 =?utf-8?B?YkNUZ01lYXRLN2NaY0RyajJuRU1PUVkxalNSUHFkcFphMDBxdzhQT2dlSzhm?=
 =?utf-8?B?SGQvM0xjeWlhUU9xSkd2cVlPYjJxREZETkFGZDJ6ZlI1ZmlIcWc1aG1Qc0hD?=
 =?utf-8?B?c3A4OEd5Y0J1Z2dab2U4aDFKY0xSdU5nRHphdz09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 09:42:52.1494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f96f3b04-01b8-41c6-6da8-08ddc5df770e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9953


On 18/07/25 8:11 am, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Replace repeated (20 - PAGE_SHIFT) calculations with standard macros:
> - MB_TO_PAGES(mb)    converts MB to page count
> - PAGES_TO_MB(pages) converts pages to MB
>
> No functional change.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>   

Reviewed-by: Dev Jain <dev.jain@arm.com>

