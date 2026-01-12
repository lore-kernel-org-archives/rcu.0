Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0CE37416A;
	Mon, 12 Jan 2026 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239390; cv=fail; b=tkGviqw14fz+eAs6PRY/SfvH2/GUxhLuWxzupyRnOn/64i85LlBFuhpQcJYpah4AnE/srOE+pTGCii41N1Lkd9nJ3W9c/Yvk32udP3DipmfiFBzk87VCzMK0JDXBOs7oVZXY+6hkQv5xLh3a9uWJnvi8GnDRI0NBQHrFRMPMtdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239390; c=relaxed/simple;
	bh=nzrx0BMedq5jco3g1UdL1N7ZdoXILYLbMv9kfySH3aQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=piqhAUSQHCWG5U82g07EdASRnLJn+gjPpGxKDJgf6US4+SfnI0tseXobgso2BmIbRe9bAVNMbZJit0nIbo1WP4MNIRQsv4gcM6X5wSZ83CHzp5bz1cYqHixEcYn7XJj0HkdaFw4yZvSH0n1583+MRBA7F2MLsGq2PN9EGrtCfFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tknnut98; arc=fail smtp.client-ip=40.107.200.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tknnut98"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDvcIYlXJT9vDkKWKvu7K+teKyPiFwqFB9rJiwfbkGZv0cAPbJ7MrzZMfa+AAm2w9H5/OAiQi2/34y+gskDTZnRrq4fMUdSNuyolc+JG80u9BzHdne+rCvdJOorU0Jefc8nlgTzweChLEb8FCPqypuHp4yfXidSuIiBTHe2NAMkCowSxjzwqXaVTeC0UsSfbWbimppB8UC6J4CYk4ms7EWCkbWJKF8SE7g2GnkftzHKlKlrjQTwlHk5jTzOBI5b/9KxkmNytHUcrmO8Cn7wHTcpjn5fQ95YKT1zXkVmUB82p9ir8EtGR9k6WxezrnUuiY2mBl+F0rzPOQFhiGIdz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzrx0BMedq5jco3g1UdL1N7ZdoXILYLbMv9kfySH3aQ=;
 b=bABRMWq0ADUwx5WAvn4/zUhw1uR3PzXss2xaG4TjGdbk6h+/CMJVAp6cBGKyDLp2tg+kW82ahjvbjkij0N0XVV/7t5zQiYChTGTPy7rZlONK2M2TguCm3rhMQXEEfFoz4Ob9ri70+4s8j1BLn1IQfRAtcP54Wzp9THMUb3el/YY2qrOGq5/lWFrkL08ZMxgdqME4P48GFFw7RCvk/hsb4ob9y/EskzVCmI2xwgWnSlWuNeC+nUL+qNSaSZIwf2PkRG5zNItmiESSKgAFLSiVRQgR1J+u7k1NuA0NUlaPLJr883kAy1jm9+VaBJte2qZb5NbPBtq2OPLhkjr2jKSS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzrx0BMedq5jco3g1UdL1N7ZdoXILYLbMv9kfySH3aQ=;
 b=Tknnut98FUc/Gzrs/YuB1M0/VS821d4xDoIsgoAuJlrtsF1xUz1mmpTNT9bTV1UXNm8kgApsHksdU7CLhvQZ4hR6M4x1NRjgLuJ/Sb37XHUtoexZmZcGU4Ou3fHR1dh3ofuqdlazo4fzYzlJ/u0VmUo1WBqgwNnN3CtRDBtu3Xf6HL7zowwN5iYMjXOYB0GNnz5YOSBNqOczJtwpw2EVQoTaSvoHi2P2VmYJPE+9aZN+OJxVokD4Uq6tJRQgeqTXtDOAgIOyjPAzp9E5m5Gonzshhh3cLtqNCYtzpEIm/3d/fNEgHAFMUcSjewQ0mZ0ELcvl1HXGLwZdTREVzuhniQ==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 12 Jan
 2026 17:36:25 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 17:36:24 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: Shrikanth Hegde <sshegde@linux.ibm.com>, Vishal Chourasia
	<vishalc@linux.ibm.com>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "frederic@kernel.org"
	<frederic@kernel.org>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "josh@joshtriplett.org"
	<josh@joshtriplett.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"srikar@linux.ibm.com" <srikar@linux.ibm.com>, Uladzislau Rezki
	<urezki@gmail.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Thread-Topic: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Thread-Index:
 AQHcg6gSQ2wH1CXqL0ua+MpkTxEkB7VOT2cAgAAgEQCAAA83gIAANcGIgAAQlICAAAedXQ==
Date: Mon, 12 Jan 2026 17:36:24 +0000
Message-ID: <D5086AE0-7158-49C4-8511-47F99021B2AE@nvidia.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636> <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan> <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <aWUqtX2PGDOZUaDW@milan>
In-Reply-To: <aWUqtX2PGDOZUaDW@milan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|DM4PR12MB6639:EE_
x-ms-office365-filtering-correlation-id: 89342d83-f152-4f92-2d8b-08de52011b71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjFzcm04dXRpNWlWNFQ2cnBTbEtGY0tlcHgxaThad080WVd3YjRNZUZ6d2JF?=
 =?utf-8?B?VFpES01vZ2pHa3FYYy82NDgxTWRxbldMMENwMlhURzlCaEdqeG5IVFAraTFF?=
 =?utf-8?B?V0s5aEV3WS9KVVFzL2NMdFdxb21mUWZqaVZVM0FlaVFwcmE5SjNOWkJXOFoy?=
 =?utf-8?B?Z2VDWWhzRWcySHM1Ymx0aXVFZG54bFB6T1J4cDFONkRPbFYyUmhYMEVJTmd5?=
 =?utf-8?B?cWY4L0xsT29mLzI3d2MwYXlSSDBDWGlyTFdRcUd5cVF6WGxRWWxDcWxYejFM?=
 =?utf-8?B?bmcrdXZ4NzNHYTRoVXArM1FqRVVRTmxJMGY3c1BvdDdDaG9iREpoUURYZ0lk?=
 =?utf-8?B?Ym9KQVdtOVFGY0hhNW9LZkNLYkpSRmN1YVBORXNiZXpBUGh2dzFWYkFtc0ZV?=
 =?utf-8?B?YVo5ZFNFcDhHb2NwMHZSYm9JZW4vM2Y0eFo2SVVTQ01HUnB6WUhvbU0wQjhT?=
 =?utf-8?B?WENERkZ5N3ZXaFY0ZllyVDBqN0w2dEJoUUxRRjgyRlpiYzkyZ0VZYm5BWGFn?=
 =?utf-8?B?Zlk0WTZUczlCWGlQbDFvU2dXN1pqaW1ONVo4bkpKVkpxVjBpUmdaQkRwdU1U?=
 =?utf-8?B?ZzZxbnc5N2F1ak92UGF5TlQydHc1M3pzaHVadGlsK2JhRjRIQUpidG5GbnBL?=
 =?utf-8?B?eVREZ0ZqSHJ5OCtURXhaaElCNmpIRTZIVzlHdXJNcCtrUXdoVmFMUEFZc2lu?=
 =?utf-8?B?dDVZRFVvZFVON3hzMEhRWlBVOVRRVHBBWUJzd2ZvUzUwQXhFT2prWVhrK01N?=
 =?utf-8?B?OUpYR3N0R1ZHUDloSHgxR3plRTMwWEwvRjc0VkdCM2U0cWhjUlNiVXdVWEpL?=
 =?utf-8?B?K2RmSHJNakJRbG00MTlvWm93aWpBclMwZEx2U0Nkbm50RE5nZ2U3V0MvZ29a?=
 =?utf-8?B?Qy9jVTBld1paajZaSHZCNkVwQVZtbldBY2FidTk0c0ZmcWYwQVRGNGd6Y2h4?=
 =?utf-8?B?RnMrc3pOWFVKNW1RdmZ4bWhlT2wwZEgwQmxnV2JzNWtLUkZ5QlBHUkJHdlcz?=
 =?utf-8?B?SWF5TisyTTVkbmJDZFphak85cHVVeHJ2eFJjTGZaTi9McXRCdDVLa095cm1W?=
 =?utf-8?B?YzFsZXhNL2twK0dwS0pBQTQvU3BOc1lEalVuR0swTlNsSXJyeUV4RUE0ekRT?=
 =?utf-8?B?Z1B2SjcrR3h2R2FwK0d3ZzAzWVFTMlkxRmhtSkRTOEhxYVNtOU05YjFtNTNJ?=
 =?utf-8?B?ZnFsMlliOHNZWU5sOEc1MVIwK2dKWHFlWHFHV2JmVWV1TG9IWUhOV3k0MVJD?=
 =?utf-8?B?UU5nYVUzd21GUE0rZG5vcFpBZmJzdVVpWmlVemRYY2xPenJqa1hIYkxidjZ5?=
 =?utf-8?B?Ly9TU3lWcjVhMFc0NzloelF3QjA5cCtwUmhCOVNmNUQyS0xrSnQrUXFlOSt6?=
 =?utf-8?B?SnJOcGhEUHdnNDhQN3NwMDNlZkxYam8xS3dqdFhicUF1OElNZlVxZGFkTnJp?=
 =?utf-8?B?ejhIN1JESTV6RkNmVkpvcFlTeTVlYzBqWVU5eFpYV2JDK1ZMdjllMmJDeHQy?=
 =?utf-8?B?ZHZydTdhOGZRS3gvaTZpanl0ZVdaNG5UMk9kOWJFazlOWHF3NWxlZGV4V1ZM?=
 =?utf-8?B?SWpFNEQyaDliTFpFc3NMTEFUWUtxRjRjTGFaeXlpR0ZqN0w2YzJoNDJZREtT?=
 =?utf-8?B?Q2hzU2RXVE1FVTZZb2ZCOWJIQStGS0w3NnRDN3U4eHdOeEF4cFhKck5UdU11?=
 =?utf-8?B?YkxoZHQvUy8zOWhVTmF4SmlGNlA1T3IzQisrb3J3Wi82a2Mwc3lSZmZ6WDdF?=
 =?utf-8?B?SG4zRktyQzNoNm1rdndQOFFIa3ZWWWlucUI4SlFNZXJ5Y0lncWIvZHNTUFJH?=
 =?utf-8?B?RXpjRUhBalNVd3ZGU3F5UUxMMHdXSklXMUh0N1EzMTJhTUxyQVlpTmxLSzVD?=
 =?utf-8?B?eVhnY04zR1U3MUhyVlJUdnhLaGlHM2Z3TVpySUNFZUIwVFhlZWkvRWxtTllI?=
 =?utf-8?B?ZE53cXNNQzBsdGtqNWRaU1NJUTdEZ3ZHRmJhalZjYks5SVlsWmRocEtzZ01X?=
 =?utf-8?B?YmlkOEdiNXZWSFYrbkNiTmVFY1RqMGtzSmNuUERTUmVFTGZOQ05nc0REeXFT?=
 =?utf-8?Q?shNdCc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTlaYTlJbTdNQWFiYzByWXJRRVZpNTMxSldsbmFjUGpNRURuQys1ZENkZVpU?=
 =?utf-8?B?cnd0MjdGYWE4T05pUUllaVpNcTRRNGpQdXl0c2ZqbmNLclhYekZaK0s4Wmd2?=
 =?utf-8?B?Uy9sTTZNRnNmcGY5NUlqR29Ra2NKcHRhV01GQS9udCt3SlVWdU55WEppSTJU?=
 =?utf-8?B?MUZJTWNVT3Jtc0RMbldkQWUzcFkvSHNmTjR1TjhncTFueENFRDl1MXI2ekc1?=
 =?utf-8?B?YUJSRi9hbTl4MU1LMk5xL2FPR2NCT1VlY1hLTERTQzNMTHhkaVY2aVJ1Wmd0?=
 =?utf-8?B?WHZaNE50cmhTV0p1NCtUd0JGWWdTR2JwdkdRWXFUb2gwZ2dKYUMrOU9MQzlG?=
 =?utf-8?B?SlNjMmNYc2JBTTVUa0V3SEFNaENsQ3Exa0tPRkdrK1JEQlJPQWttTTF3SS9G?=
 =?utf-8?B?eVVNRHp6L0tPZVNZQ2hvQnk4eWlqOVY1VXdaV3dYOXlNRmZIU2hqWk9oRXI4?=
 =?utf-8?B?VzV2YVBOaVp1amxpa0ozMytXNmFBOTcxeWpFSWFpU2hFMUkrRXlpejRoVzFN?=
 =?utf-8?B?elpZQzFWVWk0cGhlc3YyZzRsR3hJUFFEa2dPMGtLMG11Zmh4RVZBWTZidG5O?=
 =?utf-8?B?SHRyZElJbnlST0ZYNjg3VU02SEF4SFgvdVoxVnZIc0FoalM5VnhoNnRrOUJO?=
 =?utf-8?B?QjBIS0tSbTlCTnRIZkhqajY3VlpSVXA5Zm1iK1cxRkcxQnU3ZnpFK0h0UEM5?=
 =?utf-8?B?cWxMb3VtYy85RE13dTI3VmlldE5nNzlhMjBhZmxVRGkwN29qMHRURW9henlE?=
 =?utf-8?B?SytVTDhtOVdEcFdFM2x4Y0VORDhWNWdPajVobzJxQWZUdjQ0WSsveGFhR1FZ?=
 =?utf-8?B?a2FGVHYveWd1QzdkNzRiWGc4Yi93cFdMazgrYmcranFYYjNENVZiMytzU2Qz?=
 =?utf-8?B?M2hsMk1VUnJybmhCVlVtTEZiQXN6RnQ1cEFldHhaYnpiQzZrOFFQYnJpdnFr?=
 =?utf-8?B?VHFQdDJmeTJDVG1TN21ERUphVTNuQzlPV0s0NlA4OURDanJoTU0rdjg0aTRF?=
 =?utf-8?B?OFNRZ3ViMU5XYjlxTDA5TUxBSVJicW0zYkxOeU10eVpsQjVhRzlPOGw1anFN?=
 =?utf-8?B?NUZDemJhL24wVEpab05KbTVtUUFuUmJ3WnZqUVUwK3kvTXRVMk00bElWV3I1?=
 =?utf-8?B?MUFyNkpnaStoVUlVUjVXRSs3L1UvbnJEWXJUWnNqNlpaSnpWUy8zaTM5QmRR?=
 =?utf-8?B?cUZaLy9yaXpIQmtUTG9nNFBISTB1VHgrVmFibW5wZE1WR0NBZ2xJUVplVkRl?=
 =?utf-8?B?QUcrNThSbjMwYU5Gb0NOV0VUVWwyRUZGS0haYXBZVGZTSEN3UjF0Tm8xRXYx?=
 =?utf-8?B?SCtWQU85c05aNEtXUXU1UjRTQzFuaGVsRWh0R3FVVHhDODZjQ24xT0djZnRK?=
 =?utf-8?B?amh4T0REVUVwaW1HYlNrTGhXVHV3aDhLczB5c3lnQk8zMXhmTTArZDkvZURI?=
 =?utf-8?B?Mk9PZXB0bGZpUVRBRjFrNEhONmRMMHo0TFI1eGF3bjBEdE1WYUFDcW1kZy9F?=
 =?utf-8?B?b1kwZmE5WjFoZDlMbXlyWWtkTGZPRE8vbE90SjVwUFdTaEo4Z1F0cWpGMFh0?=
 =?utf-8?B?ekJqYXRrVU5WWWtkRTVVZFozYU5Fb3NvYXdSazg0R08zWDNjYjkyaHdsM1hr?=
 =?utf-8?B?RXQyZEhwWkl5elJSNG02eC9leUlhYXBFbVVMeldVMzVEeDY0RlBDRVhuM3Vs?=
 =?utf-8?B?VjVGT2l1cGJDZXBFRWdDWlEwTmNDcTVoZkRoUTFIb0Nlbm5FbG0rclR5Rlcw?=
 =?utf-8?B?c1AwdHd4dXdjQVV0NnhNZzFRVGNjc0p0M1QzOWN6Y1J0Ykc0YVN1K3FpYThT?=
 =?utf-8?B?c0dFNHI2emg2bjFVdzc5ZGVmcCtkbDhmbnp0clJTR1REYkV5Y0xhYS9aWWVQ?=
 =?utf-8?B?dUw3MnliZG9FcGJXMWgwWHR3N05WMDdhSkdvcWF4QmNJbGxHSCtGZXlxZjdq?=
 =?utf-8?B?eVVRQzZhdk1BZlhFaWU1eVRndlA2VzkxdU5sQmpNa2dpNkU3RnFtRGx0MExE?=
 =?utf-8?B?cExDSVh0dWQ5ZDdVZ0VQcmpjN3V5WEFPZXBBRm84WmlZVGJGYytkdVpXWllB?=
 =?utf-8?B?c1diVXdPWGwrc3pxd0ZWcWFLMmcrY2tpLysrNnFyOVErZ0hMdzFkb0kwM1Bi?=
 =?utf-8?B?b21hN1FHcnJ2V0VSbGNOdDlackZJVDdzeFd5dDA3RkVqUjdYOHp1bytVczcw?=
 =?utf-8?B?aU9DTnh1QW1kRmFDdlVESkRGSjZJbis3NmxOMDNtOE51RjlQOFZVU0FrbGJB?=
 =?utf-8?B?azV1cnVjNTZFQnNHYll0YUJNL3BMVGNEMkc5Y2xGTnZTVmNsb2tIODhyTWM5?=
 =?utf-8?B?L1UxOVhkTVRuUzFGbEJlek1odXp1Wlp5Y0RBMHhZdHE0UDJDVUZYQk9LSmR2?=
 =?utf-8?Q?x/OjnpP0HmTWyulGknohD2QUPe+LOyOhqI7h8UIw72XEK?=
x-ms-exchange-antispam-messagedata-1: UhzYLv6vBINu4A==
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89342d83-f152-4f92-2d8b-08de52011b71
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 17:36:24.1563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKpA+Sypyfmd/K0cPaGfzX9Gzp1OtGXoUsKCQpfoIdeS0YtLXf1YXQCpksgrYz4WO4ul49ap6qT9xPBgni+JFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639

DQoNCj4gT24gSmFuIDEyLCAyMDI2LCBhdCAxMjowOeKAr1BNLCBVbGFkemlzbGF1IFJlemtpIDx1
cmV6a2lAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IO+7v09uIE1vbiwgSmFuIDEyLCAyMDI2IGF0
IDA0OjA5OjQ5UE0gKzAwMDAsIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0KPj4gDQo+PiANCj4+Pj4g
T24gSmFuIDEyLCAyMDI2LCBhdCA3OjU34oCvQU0sIFVsYWR6aXNsYXUgUmV6a2kgPHVyZXpraUBn
bWFpbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IO+7v0hlbGxvLCBTaHJpa2FudGghDQo+Pj4gDQo+
Pj4+IA0KPj4+Pj4gT24gMS8xMi8yNiAzOjM4IFBNLCBVbGFkemlzbGF1IFJlemtpIHdyb3RlOg0K
Pj4+Pj4gT24gTW9uLCBKYW4gMTIsIDIwMjYgYXQgMDM6MTM6MzNQTSArMDUzMCwgVmlzaGFsIENo
b3VyYXNpYSB3cm90ZToNCj4+Pj4+PiBCdWxrIENQVSBob3RwbHVnIG9wZXJhdGlvbnPigJRzdWNo
IGFzIHN3aXRjaGluZyBTTVQgbW9kZXMgYWNyb3NzIGFsbA0KPj4+Pj4+IGNvcmVz4oCUcmVxdWly
ZSBob3RwbHVnZ2luZyBtdWx0aXBsZSBDUFVzIGluIHJhcGlkIHN1Y2Nlc3Npb24uIE9uIGxhcmdl
DQo+Pj4+Pj4gc3lzdGVtcywgdGhpcyBwcm9jZXNzIHRha2VzIHNpZ25pZmljYW50IHRpbWUsIGlu
Y3JlYXNpbmcgYXMgdGhlIG51bWJlcg0KPj4+Pj4+IG9mIENQVXMgZ3Jvd3MsIGxlYWRpbmcgdG8g
c3Vic3RhbnRpYWwgZGVsYXlzIG9uIGhpZ2gtY29yZS1jb3VudA0KPj4+Pj4+IG1hY2hpbmVzLiBB
bmFseXNpcyBbMV0gcmV2ZWFscyB0aGF0IHRoZSBtYWpvcml0eSBvZiB0aGlzIHRpbWUgaXMgc3Bl
bnQNCj4+Pj4+PiB3YWl0aW5nIGZvciBzeW5jaHJvbml6ZV9yY3UoKS4NCj4+Pj4+PiANCj4+Pj4+
PiBFeHBlZGl0ZSBzeW5jaHJvbml6ZV9yY3UoKSBkdXJpbmcgdGhlIGhvdHBsdWcgcGF0aCB0byBh
Y2NlbGVyYXRlIHRoZQ0KPj4+Pj4+IG9wZXJhdGlvbi4gU2luY2UgQ1BVIGhvdHBsdWcgaXMgYSB1
c2VyLWluaXRpYXRlZCBhZG1pbmlzdHJhdGl2ZSB0YXNrLA0KPj4+Pj4+IGl0IHNob3VsZCBjb21w
bGV0ZSBhcyBxdWlja2x5IGFzIHBvc3NpYmxlLg0KPj4+Pj4+IA0KPj4+Pj4+IFBlcmZvcm1hbmNl
IGRhdGEgb24gYSBQUEM2NCBzeXN0ZW0gd2l0aCA0MDAgQ1BVczoNCj4+Pj4+PiANCj4+Pj4+PiAr
IHBwYzY0X2NwdSAtLXNtdD0xIChTTVQ4IHRvIFNNVDEpDQo+Pj4+Pj4gQmVmb3JlOiByZWFsIDFt
MTQuNzkycw0KPj4+Pj4+IEFmdGVyOiAgcmVhbCAwbTAzLjIwNXMgICMgfjIzeCBpbXByb3ZlbWVu
dA0KPj4+Pj4+IA0KPj4+Pj4+ICsgcHBjNjRfY3B1IC0tc210PTggKFNNVDEgdG8gU01UOCkNCj4+
Pj4+PiBCZWZvcmU6IHJlYWwgMm0yNy42OTVzDQo+Pj4+Pj4gQWZ0ZXI6ICByZWFsIDBtMDIuNTEw
cyAgIyB+NTh4IGltcHJvdmVtZW50DQo+Pj4+Pj4gDQo+Pj4+Pj4gQWJvdmUgbnVtYmVycyB3ZXJl
IGNvbGxlY3RlZCBvbiBMaW51eCA2LjE5LjAtcmM0LTAwMzEwLWc3NTViYzEzMzVlM2INCj4+Pj4+
PiANCj4+Pj4+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzVmMmFiOGE0NGQ2ODU3
MDFmZTM2Y2RhYTgwNDJhMWFlZjIxNWQxMGQuY2FtZWxAbGludXgudm5ldC5pYm0uY29tDQo+Pj4+
Pj4gDQo+Pj4+PiBBbHNvIHlvdSBjYW4gdHJ5OiBlY2hvIDEgPiAvc3lzL21vZHVsZS9yY3V0cmVl
L3BhcmFtZXRlcnMvcmN1X25vcm1hbF93YWtlX2Zyb21fZ3ANCj4+Pj4+IHRvIHNwZWVkdXAgcmVn
dWxhciBzeW5jaHJvbml6ZV9yY3UoKSBjYWxsLiBCdXQgaSBhbSBub3Qgc2F5aW5nIHRoYXQgaXQg
d291bGQgYmVhdA0KPj4+Pj4geW91ciAiZXhwZWRpdGVkIHN3aXRjaCIgaW1wcm92ZW1lbnQuDQo+
Pj4+PiANCj4+Pj4gDQo+Pj4+IEhpIFVsYWR6aXNsYXUuDQo+Pj4+IA0KPj4+PiBIYWQgYSBkaXNj
dXNzaW9uIG9uIHRoaXMgYXQgTFBDLCBoYXZpbmcgaW4ga2VybmVsIHNvbHV0aW9uIGlzIGxpa2Vs
eQ0KPj4+PiBiZXR0ZXIgdGhhbiBoYXZpbmcgaXQgaW4gdXNlcnNwYWNlLg0KPj4+PiANCj4+Pj4g
LSBIYXZpbmcgaXQgaW4ga2VybmVsIHdvdWxkIG1ha2UgaXQgd29yayBhY3Jvc3MgYWxsIGFyY2hz
LiBXaHkgc2hvdWxkDQo+Pj4+IGFueSB1c2VyIHdhaXQgd2hlbiBvbmUgaW5pdGlhdGVzIHRoZSBo
b3RwbHVnLg0KPj4+PiANCj4+Pj4gLSB1c2Vyc3BhY2UgdG9vbHMgYXJlIHNwcmVhZCBhY3Jvc3Mg
c3VjaCBhcyBjaGNwdSwgcHBjNjRfY3B1IGV0Yy4NCj4+Pj4gdGhvdWdoIGludGVybmFsbHkgbW9z
dCBkbyAiMC8xID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1Ti9vbmxpbmUiLg0KPj4+PiBX
ZSB3aWxsIGhhdmUgdG8gcmVwZWF0IHRoZSBzYW1lIGluIGVhY2ggdG9vbC4NCj4+Pj4gDQo+Pj4+
IC0gVGhlcmUgaXMgYWxyZWFkeSAvc3lzL2tlcm5lbC9yY3VfZXhwZWRpdGVkIHdoaWNoIGlzIGJl
dHRlciBpZiBhdCBhbGwNCj4+Pj4gd2UgbmVlZCB0byBmYWxsYmFjayB0byB1c2Vyc3BhY2UuDQo+
Pj4+IA0KPj4+IFNvdW5kcyBnb29kIHRvIG1lLiBJIGFncmVlIGl0IGlzIGJldHRlciB0byBieXBh
c3MgcGFyYW1ldGVycy4NCj4+IA0KPj4gQW5vdGhlciB3YXkgdG8gbWFrZSBpdCBpbi1rZXJuZWwg
d291bGQgYmUgdG8gbWFrZSB0aGUgUkNVIG5vcm1hbCB3YWtlIGZyb20gR1Agb3B0aW1pemF0aW9u
IGVuYWJsZWQgZm9yID4gMTYgQ1BVcyBieSBkZWZhdWx0Lg0KPj4gDQo+PiBJIHdhcyBjb25zaWRl
cmluZyB0aGlzLCBidXQgSSBkaWQgbm90IGJyaW5nIGl0IHVwIGJlY2F1c2UgSSBkaWQgbm90IGtu
b3cgdGhhdCB0aGVyZSBhcmUgbGFyZ2Ugc3lzdGVtcyB0aGF0IG1pZ2h0IGJlbmVmaXQgZnJvbSBp
dCB1bnRpbCBub3cuDQo+PiANCj4gSU1PLCB3ZSBjYW4gaW5jcmVhc2UgdGhhdCB0aHJlc2hvbGQu
IDUxMi8xMDI0IGlzIG5vdCBhIHByb2JsZW0gYXQgYWxsLg0KPiBCdXQgYXMgUGF1bCBtZW50aW9u
ZWQsIHdlIHNob3VsZCBjb25zaWRlciBzY2FsYWJpbGl0eSBlbmhhbmNlbWVudC4gRnJvbQ0KPiB0
aGUgb3RoZXIgaGFuZCBpdCBpcyBhbHNvIHByb2JhYmx5IHdvcnRoIHRvIGdldCBpbnRvIHRoZSBz
dGF0ZSB3aGVuIHdlDQo+IHJlYWxseSBzZWUgdGhlbSA6KQ0KDQpJbnN0ZWFkIG9mIHBlZ2dpbmcg
dG8gbnVtYmVyIG9mIENQVXMsIHBlcmhhcHMgdGhlIG9wdGltaXphdGlvbiBzaG91bGQgYmUgZHlu
YW1pYz8gVGhhdCBpcywgZGVmYXVsdCB0byBpdCB1bmxlc3Mgc3luY2hyb25pemVfcmN1IGxvYWQg
aXMgaGlnaCwgZGVmYXVsdCB0byB0aGUgc3Jfbm9ybWFsIHdha2UtdXAgb3B0aW1pemF0aW9uLiBP
ZiBjb3Vyc2UgY2FyZWZ1bGx5IGNvbnNpZGVyaW5nIGFsbCBjb3JuZXIgY2FzZXMsIGFkZXF1YXRl
IHRlc3RpbmcgYW5kIGFsbCB0aGF0IDstKQ0KDQpUaGFua3MuDQoNCg0KPiANCj4gLS0NCj4gVWxh
ZHppc2xhdSBSZXpraQ0K
