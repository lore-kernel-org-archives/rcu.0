Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135717DFE7;
	Sun,  6 Jul 2025 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751827063; cv=fail; b=h2jJOZkS6K48AidXYV+quWt14o+b1BiQFcvkv4tgaNQtgOxJGxDrcfMx9136PgmO4Etp6zU/aiNSuucOIMakk6462VRfSf09npiGa7Tsm4zhHXjZxvslPxqdCPWlhyFTC3c6hB3vFCVUWSlNgjoezAkaKcpkmQkoSOWKXqDzGdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751827063; c=relaxed/simple;
	bh=X8BtwDPccfnF9eJZznjczjXAT9Pz44EWh7esKTcpiak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p6oykTO8oWCG+yuBwV0gnNRXgNx7hshp396TexH+64NQLSheFXRFFOOjP7q+ebdO0VjqTEaKVqs9CqTBOgxyaMfz1weS0NQ7mJEFPByjungnEpX/ConyqULCZrP3EMKivdAbGghitQaoOFQH69JKrrPaTKyu/w7cYNyaxqPzsfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o7CeeGjH; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o7CeeGjH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvC4YJC1M/r4JF2NY4/2y7lQrSocZLMQen9vWhIuJSGZAfmfKwF0OFp6+7xjxu1GYzCQidh4mtakZJsjPrby8Mor7wmS0mCWkvE/zgv4dj/R88iU9NLohZju2tIxMIw4gEwvdnbPy9N/4slVMRzSc+TNV4lN2s4H4csP+jBAh5+0IDWuBbBXuTcJKKeUbr+OoUc7uKEpe9rFo1m9e3MZLEAoC8dzOrAXRNDK25aXgEruq5gn+KrYXb9/fKkNkaIfoyRpTMpJur5JFsokervx9ba9Jya5PkiyseDm4NTOe8w0ZOzYI/r7LlTOmtVUvI7TlMxWAI9tQw/WvUAKrAeDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8BtwDPccfnF9eJZznjczjXAT9Pz44EWh7esKTcpiak=;
 b=i9rHszoNGIP9n38lxDIkfmUVFUGVxM7c8RkpzEY7rvc/x9aYiUW0Sj6Hi1rNQc5b2nF9grd3JeWeiJsP7zPw4w53XTNMl2MknjwKW/cI2xkAP2d79jxFTQwToFjyHTc5WcYXDNaPavU83VBEaIGobLpiKgagmk0GqDKz3TmIvmiJ1esMCBY2jxclM1zIZL6dIptsRthDHNASy103exLY9YxzOUR2OiSPq0dUELe/rV8EhmoFMAjj0YtxashXXQrH5JUdWkr4eyfMcFS4IMH87o5zqHqdh1ThNtF8H1cisMplTXLPf400ctAnNv6fegYmRK2Am5ChQJZ6WFInBeWptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8BtwDPccfnF9eJZznjczjXAT9Pz44EWh7esKTcpiak=;
 b=o7CeeGjH5dd9S5PFLiwjoRL+sodF2P9fmarnIyKk/H6EUG+KnLr1IyMrA1yVy20ZVhlou2eOoWypkFIn4zsxHSfaw11LL3iQLsnx8u22kvFL1KBTUx7W/Mrf19ZRBHlAvQRtUh61tF2SwOnZqIdIsizZxznqQXUinpXHrQLMfX8iFr1JfAKe+6EAQT6n3COiy0WDDa6SiwUWfUtq2ib+WG2+qwCASH5dVEBr2EL8nDflL9NKJxAeE4btI3tdnKkGXpb4p2XaTbFYZD5axk8lj31kFQa2XXIKUxI+66AKLef7ItVdflmfmPECw8iSzPMydjwQGnKE+0brFlk19FhmmQ==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Sun, 6 Jul
 2025 18:37:37 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Sun, 6 Jul 2025
 18:37:37 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
	<neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] rcu: Fix rcu_read_unlock() deadloop due to IRQ
 work
Thread-Topic: [PATCH RFC 1/3] rcu: Fix rcu_read_unlock() deadloop due to IRQ
 work
Thread-Index: AQHb7ezotqaW6OUXdUS0eWlQJfYbUrQlVUWAgAABeYCAAAOBAIAAE/7N
Date: Sun, 6 Jul 2025 18:37:37 +0000
Message-ID: <21C49D47-6B82-405F-972F-1A0C66698520@nvidia.com>
References: <20250705203918.4149863-1-joelagnelf@nvidia.com>
 <960035c6-c5f3-4c31-bd0f-f57d79b040f4@paulmck-laptop>
 <40f98744-2289-4695-aa6a-4019913920d3@nvidia.com>
 <89ac8409-fe62-486b-a10d-35494095b6a2@paulmck-laptop>
In-Reply-To: <89ac8409-fe62-486b-a10d-35494095b6a2@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|CY5PR12MB6384:EE_
x-ms-office365-filtering-correlation-id: e01529f4-e9fb-496d-2ae6-08ddbcbc2e77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUs5Y1U3YkVlVkI1N2E4bnBlc2RiMW15cU41YWcwT2JaUlk3U1puMEVuWDRT?=
 =?utf-8?B?OFJmRmRjaGc4WlBHM3hkOW43aDdGdWV2Ni95UGw4N3JmR1dTano1TWRHQ2Ro?=
 =?utf-8?B?bWJSVTVMQlhUNmx1RGJDazJFcFhMZkFnOXFIVjlDYm9GUHpXSDdGMmZCbUxu?=
 =?utf-8?B?NWJ3WWZHVXNUYlpMVmFiNDNNb21leXJrY2lqbXdqLy9sWjROdW9tMTlwWkxB?=
 =?utf-8?B?NFlKVTdwUHcxU0E3ajI3dkJueGFkcm5jY29LUDlFZnljSEVybzJ0U0tZTE5F?=
 =?utf-8?B?M3gySi8zL1kwdUErSTNEYnZCM0g0a2ExMCtXaDhSemR2TTR1cFU0Ukd1RUc0?=
 =?utf-8?B?SDlkamprWWpuSWZLUVJTV0l4ZUMrQUJnallLZStrR2JuK1J5enp1VTRZUjEx?=
 =?utf-8?B?dzB2Uld0V0lRakVWNy80aEVZeHdYbVhyTlFNdThOcC9IWUVaVDdNajk4a1lu?=
 =?utf-8?B?SndtaWlXeGpwSUpTQjBKc250UktOcXFCbld1ZENxVk5oNTRuclhKNlg3Y2JG?=
 =?utf-8?B?WExVaWx4eXFJMVZyMU1KMG1uVDZBMkxSN0xOeDAwdVZPTThyd25mMDVhV1Iv?=
 =?utf-8?B?aFB2S3ZTVE5DVTVkTWk1Q21YejRxZ1NieTFicE1saW9iOW9IOElwSGs4TFo0?=
 =?utf-8?B?ZzlEUnNPczh1bUdLM210R0Y0VUNybHRrcjJkWjM5dy9VSFNtWlNqQmFOQzJw?=
 =?utf-8?B?TmVIYjNvd25wRGV1ZHN1TW9QRS91UFRzWjh4UVhhaXhvSkM0cmhwN3gxTVVO?=
 =?utf-8?B?bHJoaE9vQkF0ZkxtUCt1Y2g5NXpIb2NyNTVFYWZEVGM4UGZvdTlSRVZ2M2l5?=
 =?utf-8?B?R2w4K2k2enNpVnJhOHM0MUN4QjhjaU9yVVNVVFY2dUdsRkVqWFhxSWVLRVlO?=
 =?utf-8?B?anVaRnBKcHh4ZzhkVDdYbFVITFdNYzE5SDNKeFdaaHZXaGpqZHlscE9LcE9V?=
 =?utf-8?B?TXRBQ0JqdUdTKy81bHRvQ25WL1ZXUmI5bjdIT3dPSmQvVHc1QVdhbldvWWt6?=
 =?utf-8?B?dXFONW5xTWUvL2VXQ2VpVE9aVmg1SDQ2SjhFSkZBaFpOS3dFa1VNdU14Tlh0?=
 =?utf-8?B?WEZ1L29adFVIQUk3RlQ2ZmJtWlNuMm9wRmxnRnlvanh4Mnh2SWtoRm5oc1BU?=
 =?utf-8?B?WTk2eTQyNENkMGI4ZGFQcHQ0Ry9yaGQ2ck1ndWZRMEQ4UEJJY2dwYkZjajA4?=
 =?utf-8?B?VmxvcXBhc0xiRmhxR2gycE03ME9mOU05d0FWeWJVWUhIKzltaXh4YTlhdEp4?=
 =?utf-8?B?dlI5RmxUait1UUlWaDN5L1lEdWEvWEVaUGNlSHBNQ01GN0ZUZmlNdU9aL20z?=
 =?utf-8?B?K2dpQUlibkd6RWR0NTNmU3VFRGkzVUxZQ2J5ckxHeFduWEFpUE9RSVYyWjNC?=
 =?utf-8?B?N2lHZ3F5ZUswRVRJL09mckIrTnFxSEg4UmRha3VEWTZid0llWHFGTHJrd284?=
 =?utf-8?B?NWR4WG1NL1RSZnhHSlR5ZkpQMzdzTW9QZERuc20wM1ByVDROZ1I1ZGY4MjlT?=
 =?utf-8?B?Y0RHaXVOZGdtU1hENFVNaGUzUWZOMG9MdTc5dGw0SFVleHFkL3Z0ZVk3ZmdW?=
 =?utf-8?B?V0kyRTBqZmRBQ1FEa2x3a0t1T1h4eU9JQ1FMcWJwNFFaRWdyMVIxR1JGQWdv?=
 =?utf-8?B?a3YvQ0ZHSlNyMi9ZT1NwSGNGdURraE05dHhyRDhBLzVtQ0lidFJFYXZWRlFE?=
 =?utf-8?B?WGhybVgzcEg4ZGFVcERFcE5EMWxHMkZDWVo1MWx0V2lCVjZIaU4xbjdhTEFV?=
 =?utf-8?B?ZU1uRHZaUUczT0JGOXVLVzFEN2ZXZ1FBMU5ER0V6TjZLT3lBdFFGNzVRSzJn?=
 =?utf-8?B?aUlLZ2R0U2g0aTJEbkdRejIxUm5Jc0RNdDBrby93REpURjg5elpJZnlnUTg0?=
 =?utf-8?B?YjNUNXVtK3dqOHRlN0tyenJJVmZIMllQdUZ4bTNsOUY3RDlOYW9WMGVmVENs?=
 =?utf-8?B?eUhVTC90ZDhwRGUyMVRQNVkwNDRZSFM5Smx5enplZC9EZkpOWDAzMUFyZmh1?=
 =?utf-8?B?d0hlOW9CalBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzJsK1MrVVhzb1FucGs5T2ovRHV1WGRSQjNud1lqTlA1aGtuVXRvYTM5Mmg2?=
 =?utf-8?B?TnpRSEQ0enVySGR6QzdYYUVEZGlBY0ozMlg3NFp2cnpCM09uQzAvZHYvWHNS?=
 =?utf-8?B?dWpobFBqTHNEaUVmRmVCd3ZSenFtN3BuK2dsOXFuRFpNN1RCTVlJK3gzcGpw?=
 =?utf-8?B?aUhqNlJFWFZBbEdXMnJnMXRLdmh3d2hXSlJlS1MvekUxL0ZQY01zTnRmbVFP?=
 =?utf-8?B?M0w1UUZ4VzBvZXNESHRLdm4wZWZ0YWZlanlhYTdXbWlTbVRPdXBZa3NtVzAy?=
 =?utf-8?B?TlEvcFZON3pxeDcyTlN5cU50NW5UcGplRWdJYWlGZ092YnZvZW9EVnRjeVow?=
 =?utf-8?B?U3dKREFVb2wwNU9XSEd6ZG5od2V2TXU3WTJIL1REb0UvQTNwamdYeFJrelIv?=
 =?utf-8?B?RCt6TVV0aE81WmlFMmRqbWk2SzJMSU9YNHI2OFJ5WVhLR1FHaVZZZGxtQmlW?=
 =?utf-8?B?dk9uY2M3TGx0UWxiMEZWdkZzcVlGNTNCODZMWTlEQnQxaUdWbFNYTWZGOVFq?=
 =?utf-8?B?V3JhQVVseEpqbDJTaGF4ZmNpakNlMzlVRDdvMEJIRllNUDN2SHlTcTkwOFhY?=
 =?utf-8?B?RkdyK09zbTlZVklxKzE5N202YVA5dzZPWXVZSDhaTFMxelZxQzRlZ3Y2VEgy?=
 =?utf-8?B?QzNhZHR1UHN0TTZabnN6cXE5d3RBUDNFcm5pUFp1S2Vvdi83THByby90MjVz?=
 =?utf-8?B?Wk1hM1RHcXdOc2RTeUQ3SmFSN0F6V3QzNDQ3M1ZDT0o4Vk1Zb284SWV2MTZY?=
 =?utf-8?B?QXVPYmpvenYrQ1hhWnMxQm9mcHpyS1F5dXl5eUZ6MXZnbnY0d1lvMm9LZ0RF?=
 =?utf-8?B?Z0tPY2ZuajB2eG1ZTlQ4Ynd5SzFMZ3pabVk3RG51aTFCRGNnQnVxY1NYTVJB?=
 =?utf-8?B?Y0NmU0EvQVpDZzlaQTNTZG9NR3d6dTkyT0UrQTRXbXNPTDJrK3dqRk15UEF5?=
 =?utf-8?B?TXRxVFFod0ZJQmFxZkwvYUpBWGVVTHZYREpGT1ZyVjkzaEtlUEVhMVcweXhR?=
 =?utf-8?B?RWJONWk1bHhldlNORDBFTkpURGhsMGx3bmxJNEhkMjRrYnBLUFhRSVhSTUV5?=
 =?utf-8?B?a1l4dGNyd09sa3lvbzBIQXVoTEY0YjNWUXhLVVUySTRJNjRqYVdmaC82TGwv?=
 =?utf-8?B?R3hzSzh6VFB4ZG9uRk5tMkNkaWducDBjYUpoMW54Y3dpMlRVVTRqZTRrRzlJ?=
 =?utf-8?B?dUNKTnY2Zzh1K3JmcnNWaS9vbDJjRjZZbENpR3FhaStKc0g3cjFhNXp6emZX?=
 =?utf-8?B?NEJlZVB2Q3YzUHQ1V3kvejNMaEFGR2RCc0ZmRUNBS2ErVk5ISGtIRjRRRTZ3?=
 =?utf-8?B?RFhIdHhZMkM2aHhKRkxZVlZWUE5DTzVQckdPakdiaXhLSDh6ZjY2dmFSN2VQ?=
 =?utf-8?B?Tm9ScUllS2FVbThMS05WanlmZ1hHQnI5UGpFYUxTUWRleDR6dGVBT2NaQ0hl?=
 =?utf-8?B?TlVsOVcwS095bDI4VnpjSUFTMVc1Ym5Rd0tQSVd4YitHVGIzWnlvMUU1WmdC?=
 =?utf-8?B?bm0zdm0wUTFjOFE0ZUViTHZ3YVl6TUwvNWJPS3FHaUhlUGVkSWlESDUwcUlx?=
 =?utf-8?B?b3pJdW5ZRUJ0RzVBdU9BV2gxQ1FNZTF4dWlzYlo1b3ozL243emxZMC8xMEZi?=
 =?utf-8?B?RW0yTEUwUjNLOTFLMmlGVkFHb2E5YmxYNE1zcXM4dE1zd1JZdTh4S3MwQUli?=
 =?utf-8?B?MGgxV3JYUWZmazJRRXl5SzJLWVZiSEc4a0lXUEI5eXFQRml4Z0NydHJ5YkQ4?=
 =?utf-8?B?UmRjVjEvTFcxYWY4anZXL1NIdGZtZDQ3dkpJZEVySGpXVUE2Qlp1QzFYaGVQ?=
 =?utf-8?B?R1dWVnVxY0JnMWZQYlhJUVJKcjhZbEsyMlZLaThBTWMzTmIzSnNyTmxuNy9l?=
 =?utf-8?B?ZUxiWUJuUXY1U3JjaHU5cU93WFJxWENxZitDVmhaVlVaUGU0Zm05NndaRHgr?=
 =?utf-8?B?K0VVY0NOVUUvMWZlN1FOTm5qaFV0ZndTTmhFN2NQRWx5dDNYQ0pVVTRBMHZl?=
 =?utf-8?B?U1VqT2R0K2RLSk9iRTFIOGhjUGs5WUNnTStjWTd1UGgxQ3lNZG9lNU5zNUln?=
 =?utf-8?B?bEtyOGducVhvWHBycFFXK3RSM3l5dGtid3BrS2JkQnlCQ1hJUFdEVjdlc294?=
 =?utf-8?Q?7u1qylWZhZfkVvfiki5esZH2P?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e01529f4-e9fb-496d-2ae6-08ddbcbc2e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2025 18:37:37.5439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HrnD8Khur5k2ZyXiWRznEy941WdDTYoL5vMZD8YIkYGIshllsi2c0vtquyFIcbasXetke22ITBO5V7v8WK8rNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384

DQoNCj4gT24gSnVsIDYsIDIwMjUsIGF0IDE6MjbigK9QTSwgUGF1bCBFLiBNY0tlbm5leSA8cGF1
bG1ja0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFN1biwgSnVsIDA2LCAyMDI1IGF0
IDAxOjEzOjMxUE0gLTA0MDAsIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0KPj4+IE9uIDcvNi8yMDI1
IDE6MDggUE0sIFBhdWwgRS4gTWNLZW5uZXkgd3JvdGU6DQo+Pj4gT24gU2F0LCBKdWwgMDUsIDIw
MjUgYXQgMDQ6Mzk6MTVQTSAtMDQwMCwgSm9lbCBGZXJuYW5kZXMgd3JvdGU6DQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEpvZWwgRmVybmFuZGVzIDxqb2VsYWduZWxmQG52aWRpYS5jb20+DQo+Pj4gDQo+
Pj4gRGVmaW5pdGVseSBoZWFkZWQgaW4gdGhlIHJpZ2h0IGRpcmVjdGlvbiwgdGhvdWdoIGl0IGRv
ZXMgbmVlZCBqdXN0IGENCj4+PiBsaXR0bGUgYml0IG1vcmUgZGV0YWlsIGluIHRoZSBjb21taXQg
bG9nLiAgOy0pDQo+Pj4gDQo+Pj4gQWxzbyBhIGZldyBjb21tZW50cyBhbmQgcXVlc3Rpb25zIGlu
dGVyc3BlcnNlZCBiZWxvdy4NCj4+PiANCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBU
aGFueCwgUGF1bA0KPj4+IA0KPj4+PiAtLS0NCj4+Pj4ga2VybmVsL3JjdS90cmVlLmggICAgICAg
IHwgMTEgKysrKysrKysrKy0NCj4+Pj4ga2VybmVsL3JjdS90cmVlX3BsdWdpbi5oIHwgMjkgKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4+Pj4gMiBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNl
cnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4+PiANCj4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9yY3UvdHJlZS5oIGIva2VybmVsL3JjdS90cmVlLmgNCj4+Pj4gaW5kZXggMzgzMGMxOWNmMmY2
Li5mOGY2MTIyNjllNmUgMTAwNjQ0DQo+Pj4+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZS5oDQo+Pj4+
ICsrKyBiL2tlcm5lbC9yY3UvdHJlZS5oDQo+Pj4+IEBAIC0xNzQsNiArMTc0LDE1IEBAIHN0cnVj
dCByY3Vfc25hcF9yZWNvcmQgew0KPj4+PiAgICB1bnNpZ25lZCBsb25nICAgamlmZmllczsgICAg
LyogVHJhY2sgamlmZmllcyB2YWx1ZSAqLw0KPj4+PiB9Ow0KPj4+PiANCj4+Pj4gKy8qDQo+Pj4+
ICsgKiBUaGUgSVJRIHdvcmsgKGRlZmVycmVkX3FzX2l3KSBpcyB1c2VkIGJ5IFJDVSB0byBnZXQg
c2NoZWR1bGVyJ3MgYXR0ZW50aW9uLg0KPj4+PiArICogSXQgY2FuIGJlIGluIG9uZSBvZiB0aGUg
Zm9sbG93aW5nIHN0YXRlczoNCj4+Pj4gKyAqIC0gREVGRVJfUVNfSURMRTogQW4gSVJRIHdvcmsg
d2FzIG5ldmVyIHNjaGVkdWxlZC4NCj4+Pj4gKyAqIC0gREVGRVJfUVNfUEVORElORzogQW4gSVJR
IHdvcmsgd2FzIHNjaGVkdWxlciBidXQgbmV2ZXIgcnVuLg0KPj4+PiArICovDQo+Pj4+ICsjZGVm
aW5lIERFRkVSX1FTX0lETEUgICAgICAgIDANCj4+Pj4gKyNkZWZpbmUgREVGRVJfUVNfUEVORElO
RyAgICAxDQo+Pj4gDQo+Pj4gSGF2aW5nIG5hbWVzIGZvciB0aGUgc3RhdGVzIGlzIGdvb2QhDQo+
Pj4gDQo+Pj4+ICsNCj4+Pj4gLyogUGVyLUNQVSBkYXRhIGZvciByZWFkLWNvcHkgdXBkYXRlLiAq
Lw0KPj4+PiBzdHJ1Y3QgcmN1X2RhdGEgew0KPj4+PiAgICAvKiAxKSBxdWllc2NlbnQtc3RhdGUg
YW5kIGdyYWNlLXBlcmlvZCBoYW5kbGluZyA6ICovDQo+Pj4+IEBAIC0xOTIsNyArMjAxLDcgQEAg
c3RydWN0IHJjdV9kYXRhIHsNCj4+Pj4gICAgICAgICAgICAgICAgICAgIC8qICBkdXJpbmcgYW5k
IGFmdGVyIHRoZSBsYXN0IGdyYWNlICovDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAvKiBwZXJp
b2QgaXQgaXMgYXdhcmUgb2YuICovDQo+Pj4+ICAgIHN0cnVjdCBpcnFfd29yayBkZWZlcl9xc19p
dzsgICAgLyogT2J0YWluIGxhdGVyIHNjaGVkdWxlciBhdHRlbnRpb24uICovDQo+Pj4+IC0gICAg
Ym9vbCBkZWZlcl9xc19pd19wZW5kaW5nOyAgICAvKiBTY2hlZHVsZXIgYXR0ZW50aW9uIHBlbmRp
bmc/ICovDQo+Pj4+ICsgICAgaW50IGRlZmVyX3FzX2l3X3BlbmRpbmc7ICAgIC8qIFNjaGVkdWxl
ciBhdHRlbnRpb24gcGVuZGluZz8gKi8NCj4+Pj4gICAgc3RydWN0IHdvcmtfc3RydWN0IHN0cmlj
dF93b3JrOyAgICAvKiBTY2hlZHVsZSByZWFkZXJzIGZvciBzdHJpY3QgR1BzLiAqLw0KPj4+PiAN
Cj4+Pj4gICAgLyogMikgYmF0Y2ggaGFuZGxpbmcgKi8NCj4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9yY3UvdHJlZV9wbHVnaW4uaCBiL2tlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaA0KPj4+PiBpbmRl
eCBkZDFjMTU2YzE3NTkuLmJhZjU3NzQ1YjQyZiAxMDA2NDQNCj4+Pj4gLS0tIGEva2VybmVsL3Jj
dS90cmVlX3BsdWdpbi5oDQo+Pj4+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaA0KPj4+
PiBAQCAtNDg2LDEzICs0ODYsMTYgQEAgcmN1X3ByZWVtcHRfZGVmZXJyZWRfcXNfaXJxcmVzdG9y
ZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQsIHVuc2lnbmVkIGxvbmcgZmxhZ3MpDQo+Pj4+ICAgIHN0
cnVjdCByY3Vfbm9kZSAqcm5wOw0KPj4+PiAgICB1bmlvbiByY3Vfc3BlY2lhbCBzcGVjaWFsOw0K
Pj4+PiANCj4+Pj4gKyAgICByZHAgPSB0aGlzX2NwdV9wdHIoJnJjdV9kYXRhKTsNCj4+Pj4gKyAg
ICBpZiAocmRwLT5kZWZlcl9xc19pd19wZW5kaW5nID09IERFRkVSX1FTX1BFTkRJTkcpDQo+Pj4+
ICsgICAgICAgIHJkcC0+ZGVmZXJfcXNfaXdfcGVuZGluZyA9IERFRkVSX1FTX0lETEU7DQo+Pj4g
DQo+Pj4gR29vZCwgdGhpcyBpcyB3aGVyZSB0aGUgcmVxdWVzdCBhY3R1YWxseSBnZXRzIHNlcnZp
Y2VkLg0KPj4+IA0KPj4+PiArDQo+Pj4+ICAgIC8qDQo+Pj4+ICAgICAqIElmIFJDVSBjb3JlIGlz
IHdhaXRpbmcgZm9yIHRoaXMgQ1BVIHRvIGV4aXQgaXRzIGNyaXRpY2FsIHNlY3Rpb24sDQo+Pj4+
ICAgICAqIHJlcG9ydCB0aGUgZmFjdCB0aGF0IGl0IGhhcyBleGl0ZWQuICBCZWNhdXNlIGlycXMg
YXJlIGRpc2FibGVkLA0KPj4+PiAgICAgKiB0LT5yY3VfcmVhZF91bmxvY2tfc3BlY2lhbCBjYW5u
b3QgY2hhbmdlLg0KPj4+PiAgICAgKi8NCj4+Pj4gICAgc3BlY2lhbCA9IHQtPnJjdV9yZWFkX3Vu
bG9ja19zcGVjaWFsOw0KPj4+PiAtICAgIHJkcCA9IHRoaXNfY3B1X3B0cigmcmN1X2RhdGEpOw0K
Pj4+PiAgICBpZiAoIXNwZWNpYWwucyAmJiAhcmRwLT5jcHVfbm9fcXMuYi5leHApIHsNCj4+Pj4g
ICAgICAgIGxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4+Pj4gICAgICAgIHJldHVybjsNCj4+
Pj4gQEAgLTYyMywxMiArNjI2LDI0IEBAIG5vdHJhY2Ugdm9pZCByY3VfcHJlZW1wdF9kZWZlcnJl
ZF9xcyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQpDQo+Pj4+ICAqLw0KPj4+PiBzdGF0aWMgdm9pZCBy
Y3VfcHJlZW1wdF9kZWZlcnJlZF9xc19oYW5kbGVyKHN0cnVjdCBpcnFfd29yayAqaXdwKQ0KPj4+
PiB7DQo+Pj4+IC0gICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4+Pj4gLSAgICBzdHJ1Y3QgcmN1
X2RhdGEgKnJkcDsNCj4+Pj4gKyAgICB2b2xhdGlsZSB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPj4+
IA0KPj4+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgdGhpcyB3YW50cyB0byBiZSB2b2xhdGlsZS4N
Cj4+PiANCj4+PiBVbmxlc3MgbWF5YmUgeW91IHdhbnQgdG8gbWFrZSBzdXJlIHRoYXQgZ2RiIGNh
biBzZWUgaXQsIGluDQo+Pj4gd2hpY2ggY2FzZSwgaXMgdGhlcmUgYW4gZXhpc3RpbmcgS2NvbmZp
ZyBvcHRpb24gZm9yIHRoYXQ/ICBNYXliZQ0KPj4+IENPTkZJR19ERUJVR19JTkZPX05PTkU9bj8N
Cj4+IA0KPj4gVGhpcyBkb2VzIG5vdCBuZWVkIHRvIGJlIHZvbGF0aWxlLCBzb3JyeSBpdCB3YXMg
YW4gb2xkZXIgcmVtbmFudCAoYmFjayB3aGVuIHRoZQ0KPj4gaGFuZGxlciB3YXMgYSBOT09QIGlu
IHRoZSB2MSwgYW5kIEkgd2FzIGFmcmFpZCBvZiBjb21waWxlciBvcHRpbWl6YXRpb25zIDstKSku
DQo+PiBCdXQgaXRzIG5vIGxvbmdlciBuZWVkZWQgc28gSSBzaGFsbCBkcm9wIGl0ICh0aGUgdm9s
YXRpbGUpIDopDQo+IA0KPiBXaGV3ISAgOy0pDQo+IA0KPj4+PiArICAgIHN0cnVjdCByY3VfZGF0
YSAqcmRwID0gdGhpc19jcHVfcHRyKCZyY3VfZGF0YSk7DQo+Pj4+IA0KPj4+PiAtICAgIHJkcCA9
IGNvbnRhaW5lcl9vZihpd3AsIHN0cnVjdCByY3VfZGF0YSwgZGVmZXJfcXNfaXcpOw0KPj4+PiAg
ICBsb2NhbF9pcnFfc2F2ZShmbGFncyk7DQo+Pj4+IC0gICAgcmRwLT5kZWZlcl9xc19pd19wZW5k
aW5nID0gZmFsc2U7DQo+Pj4+ICsNCj4+Pj4gKyAgICAvKg0KPj4+PiArICAgICAqIFJlcXVldWUg
dGhlIElSUSB3b3JrIG9uIG5leHQgdW5sb2NrIGluIGZvbGxvd2luZyBzaXR1YXRpb246DQo+Pj4+
ICsgICAgICogMS4gcmN1X3JlYWRfdW5sb2NrKCkgcXVldWVzIElSUSB3b3JrIChzdGF0ZSAtPiBE
RUZFUl9RU19QRU5ESU5HKQ0KPj4+PiArICAgICAqIDIuIENQVSBlbnRlcnMgbmV3IHJjdV9yZWFk
X2xvY2soKQ0KPj4+PiArICAgICAqIDMuIElSUSB3b3JrIHJ1bnMgYnV0IGNhbm5vdCByZXBvcnQg
UVMgZHVlIHRvIHJjdV9wcmVlbXB0X2RlcHRoKCkgPiAwDQo+Pj4+ICsgICAgICogNC4gcmN1X3Jl
YWRfdW5sb2NrKCkgZG9lcyBub3QgcmUtcXVldWUgd29yayAoc3RhdGUgc3RpbGwgUEVORElORykN
Cj4+Pj4gKyAgICAgKiA1LiBEZWZlcnJlZCBRUyByZXBvcnRpbmcgZG9lcyBub3QgaGFwcGVuLg0K
Pj4+PiArICAgICAqLw0KPj4+PiArICAgIGlmIChyY3VfcHJlZW1wdF9kZXB0aCgpID4gMCkgew0K
Pj4+PiArICAgICAgICBXUklURV9PTkNFKHJkcC0+ZGVmZXJfcXNfaXdfcGVuZGluZywgREVGRVJf
UVNfSURMRSk7DQo+Pj4gDQo+Pj4gU2hvdWxkbid0IHdlIGhhdmUganVzdCB0aGlzIFdSSVRFX09O
Q0UoKSBpbiB0aGlzIHRoZW4tY2xhdXNlPw0KPj4gDQo+PiBObywgYmVjYXVzZSBpZiB3ZSBsZXQg
dGhlIElSUSB3b3JrIGhhbmRsZXIgZG8gdGhhdCBiZWZvcmUgd2UgY2FuIGV4ZWN1dGUNCj4+IHJj
dV9wcmVlbXB0X2RlZmVycmVkX3FzX2hhbmRsZXIoKSwgdGhlbiBpdCB3aWxsIGNhdXNlIGluZmlu
aXRlIHJlY3Vyc2lvbiwNCj4+IGJlY2F1c2UgYW4gUkNVIHJlYWQtc2lkZSBjcml0aWNhbCBzZWN0
aW9uIGNhbiBhZ2FpbiB0cnkgdG8gcXVldWUgdGhlIElSUSB3b3JrDQo+PiAoYmVmb3JlIGVudGVy
aW5nIHRoZSBzY2hlZHVsZXIpLiBBbHNvIHRlc3Rpbmcgc2hvd3MgZG9pbmcgdGhhdCB3aWxsIHJl
cHJvZHVjZQ0KPj4gdGhlIGhhbmcgd2UncmUgZml4aW5nLg0KPj4gDQo+PiBJIHRoaW5rIHdlIHNo
b3VsZCByZW5hbWUgZGVmZXJfcXNfaXdfcGVuZGluZyB0byBkZWZlcl9xc19wZW5kaW5nIHRvIGJl
dHRlcg0KPj4gY2xhcmlmeSB0aGF0IHdlIGFyZSB0cmFja2luZyB0aGUgIkRlZmVycmVkIFFTIiBy
ZXBvcnRpbmcgdGhhbiBpZiB0aGUgSVJRIHdvcmsNCj4+IGFjdHVhbGx5IHJhbj8NCj4gDQo+IEhl
cmUgaXMgdGhlIHBhdGNoOg0KPiANCj4gKyAgICBpZiAocmN1X3ByZWVtcHRfZGVwdGgoKSA+IDAp
IHsNCj4gKyAgICAgICAgV1JJVEVfT05DRShyZHAtPmRlZmVyX3FzX2l3X3BlbmRpbmcsIERFRkVS
X1FTX0lETEUpOw0KPiArICAgICAgICBsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7DQo+ICsgICAg
ICAgIHJldHVybjsNCj4gKyAgICB9DQo+ICAgIGxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4g
fQ0KPiANCj4gQWZ0ZXIgdGhlIFdSSVRFX09OQ0UsIHlvdSByZXN0b3JlIGludGVycnVwdHMgYW5k
IHJldHVybi4gIFdoaWNoIGlzIGFsc28NCj4gd2hhdCB3b3VsZCBoYXBwZW4gaWYgdGhlcmUgd2Fz
IG9ubHkgdGhlIFdSSVRFX09OQ0UoKSBpbiB0aGUgdGhlbi1jbGF1c2UsDQo+IGNvcnJlY3Q/DQo+
IA0KPiBPciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nIHN1YnRsZSBoZXJlPw0KDQpPaCwgdHJ1ZSEg
SSB3aWxsIGRlbGV0ZSB0aG9zZSAyIGxpbmVzIGluc2lkZSB0aGUgaWYgYmxvY2suIFRoYW5rcyEN
Cg0KIC0gSm9lbA0KDQoNCg0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgVGhhbngs
IFBhdWwNCg==
