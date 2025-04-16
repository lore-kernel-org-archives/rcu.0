Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D1381C4;
	Wed, 16 Apr 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744802367; cv=fail; b=akjk3k6mHnIgEqCX4Q08J1FbQs+Goj9cHBgf7XoKtDsVffXwwkwzRVH7vjqsNHn+GFUjbEp9Y/8xgAe8nGtUa+WpjwbFxlfwp0zylib35jCo6JubGAReV5cfCCdM0KOt7pVk2V9UrjADoICspL0O1Qjwow9j+Tgdcq6OEvfSOM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744802367; c=relaxed/simple;
	bh=otd5w9dYE0aH8e3PJiWExeig2nt76E9chjGnvO+pE+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tl28BFg3CjYmj8VyeQN5sGRjAwHyLIgq5+N+5t+Jff6i7pcZNkNu13TrpffiEldllYXQhzzlbfwLqdxSgVYSMyJLvgf6QXKZ1/WR55KS/nDBndQpA3Z7BCIDMw/Q5udyJEY5mo92xorwjwtZwiwIaoeO6XUTXefKQAc3qth1vn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZcatWq/; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZcatWq/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bo92ji+bXJCV95q/6ldb7G8eFhJ23mciUzJVHafHLCxDQt710MYtFILRT/jpbR0ahBdXwPj+MerFeEchK4h5O0IPCymUEn++HV9Aky0/wFO4JkqcD4TV863/y3VGnvNIShHuR7gsxKHgYLp/WZh80c/vnR34FTwumDWWKyVz2g3L1Odt4mQpJPBJTgQkw7l3XPlGuyx9HhquMzFQCalpoo/GlD1gkhtBSfRrD7LQeX7fozxfODBd93xCS6ItwkoPc/PksQnvKe5rR6327vnwmXCrP8umUY9x8wKjkBjHn+pmufYs0BJYI5KywendblHXmBJcVc98GPqfxCEkNl9gHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otd5w9dYE0aH8e3PJiWExeig2nt76E9chjGnvO+pE+E=;
 b=Kfb53TbwHdVsZCu8t4bENwftRp+w8J43FNmZkRnqkyhsGr0cL3GkwuijZXPodh32VAmpm4WaG79SkXQr2cCfkFSJvXQCEt1o1Gqu8e/CRfnzpUaQEq3+8lSpa8qq27EY8pHzWYpdQJ6k6gXQbDiVRz/WQDGJ3MjhLpVmAyq9l+mI0MVChlTJT5UKCDn+GH/IqhLxvF2PpDbXUKEdD1eLwkYLJusS3jqAOjNi/8SvG65/zlS25VGPcrTRpPhrK9T6KDTMdr9ucAJ+giXYLBxrAAbrz3qtxqBoqHmOE7/k13qCDmsOToWvdOt+hAKDKxoXPvAO2Z9QL04JXV10Al0Ocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otd5w9dYE0aH8e3PJiWExeig2nt76E9chjGnvO+pE+E=;
 b=JZcatWq/mkFsOxlbQoTfCvuyUoSsaXxAaYKDue9gWcu1KCJA5RjfkjH7quBZy600aK1Q4UB+UXj74dZCD+ZYw7FGjR6GEnLXmk0i3/KEtFpFvenq2JYO/JsSgNVoHiHmgt4XGkSvDcptSLhHEh1pESSBpjy109FkJSYCuvvDv4Zfsz2387lWJekJsrXZfMt+YwIUqyMDP9ksRwUEo3+TOLCKpZY/k4rmKnNBeZ5ejdapU3+xm9+MaE+ozHAbItkd0KY+TYzjq/9n+C96sjqgkytISNzvoCPtQU8pzwHx4WRXJhQvvnuF/Z4DMQFaSAAt+lq3U+QPdqIC78HuE/IptQ==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 11:19:23 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 11:19:22 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
	<neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Davidlohr Bueso
	<dave@stgolabs.net>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] rcutorture: Perform more frequent testing of
 ->gpwrap
Thread-Topic: [PATCH v3 1/2] rcutorture: Perform more frequent testing of
 ->gpwrap
Thread-Index: AQHbqim8Mlc+1hmRL0iW2El5fQSVPrOdOIuAgAYQhoCAAiz8gIAAuG37
Date: Wed, 16 Apr 2025 11:19:22 +0000
Message-ID: <8603B8C7-DE79-4362-BE60-DE95ABE015BE@nvidia.com>
References: <20250410150329.3807285-1-joelagnelf@nvidia.com>
 <20250410150329.3807285-2-joelagnelf@nvidia.com>
 <11caaa93-7acf-417c-9223-1b14a76310b2@paulmck-laptop>
 <5ee46103-caef-46ac-8660-4b9f4bb5e4f0@nvidia.com>
 <587e21be-9595-4625-b929-0e8b4a215a43@paulmck-laptop>
In-Reply-To: <587e21be-9595-4625-b929-0e8b4a215a43@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|BL4PR12MB9505:EE_
x-ms-office365-filtering-correlation-id: 9896cde3-6098-4ce4-bf42-08dd7cd889af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0EvZXhZRjlrM2ZQcWpRYXdMYkRjczBmUlNqbnY3LzBzbWZMOGxib1o3aHRn?=
 =?utf-8?B?c2VrYU1EeU4rMHpkeU5vdVhUODRWWHlpVmlBN0xxd3Q3QWhuYlhNcHdTTjlv?=
 =?utf-8?B?bEJ1VUJ3enV3WEdYQ3BvVDYyUHNTeHBiY2VyS240WGIvVUlXRHhoN1M2Z24x?=
 =?utf-8?B?S3pDb292MStrMlJMbThlSWhvMkhlYXRSWFVSaVcvRkpKRG9nejdMZU91RmVn?=
 =?utf-8?B?ZVY2RGFKdFJ2SmMwV1VUM0RqOHdMTmI0YnlqcGJENWFwM1NoMFFSLzd0OWFt?=
 =?utf-8?B?OVBkSEpxZEZPUngrUGl6UzVoWXpDQlZiVVZVYTZRRTg5WS9iQ0k5RnRqOSt2?=
 =?utf-8?B?dDdUYktRbDZPWiswK0Yxa25EVk55ZittYjFtQVVmUDh2VDhRdzNUWlkyUHhN?=
 =?utf-8?B?TWdUVUxjQkh5YXptaU8vZ2pIbVBxV29uQWdoWDNHS2pFMDU4enR5alBBT0RW?=
 =?utf-8?B?cVU5YWdrNzA4bkNiNFVkRnBvNjBkcFF4MG5vRS8rRFl1aFdSbUNmV2pMVks4?=
 =?utf-8?B?Yy9mRUt0RDFYb1lqUmZlZktxYnYyRnp0RVpFbzRZVWlKUUhuSjl1dDJ6L24v?=
 =?utf-8?B?eXBkUHVHZ29aSkF6RmlPNWpJYXJKeFpGWjdpcHdnQXhBWHZXT09va3Rtbk9W?=
 =?utf-8?B?ck9PdWpJM2xvcXpxejF3aWNIQlBnMlJ1Ty9sa1N3VVhkOEg0SU4wNU9NVk9H?=
 =?utf-8?B?OXZTM1FLeDVUdHR4bnhUV1J5bms3V1Bub2tRTzUvZVA3bEt5MHFGTXNLT1B5?=
 =?utf-8?B?am1WcWpLVEErM3pTRi9KT0ZjVnFlSzRIWFlsWjF1TkdCVEJCL3MyZE4xTmZU?=
 =?utf-8?B?VUcrOFFHUmt4UElUT2VLWVYxbEVIeUdQMk5sVUhvRTNiem92bWdYR3drWjRo?=
 =?utf-8?B?NHp5aUI2QmFHcTV1S2xiNmc2MDhvL0NVeXo0dDFnanh5ZEplTFo5ZFczTVdn?=
 =?utf-8?B?QXF4UThGME16TzNtNTQ0QS9TNlc2QWtwL2UwaEVhUi8yRm1zOHpLaGRYc2lw?=
 =?utf-8?B?TUo2bi9YS1U1aElGT3JPaVAwdXZJV2Q5MDVoSi8vRnFLVEo3ZnJhRThrYkFX?=
 =?utf-8?B?b2h6eEg5VHR2NFJsV2k4eitNeUVPZUwyZGxhVVF6TXdsUWpublBSUUgwQ2Vu?=
 =?utf-8?B?QzlpQWx3bW13SDFITjNnNytkQzFNUFdlekFVUWlnMmhlZWpjN2tKcGFOYmFV?=
 =?utf-8?B?SUkraGVMQUx1VnZZNG4xNnRZUCtmYUFwSjJZMXlEMjFVMzBZYTVBeUJPMlpm?=
 =?utf-8?B?SzlkZXdvSkJDYmZ2QVNLVnBOUG9EWG1ldzd1b2FIdEJJalFheEtkUmp0WXIr?=
 =?utf-8?B?MWxGaXpTTitMUGJOUllXRXNsbFYrQTdHWUVZanE0R29DcENuVEJlZDlRSUk4?=
 =?utf-8?B?ZDZ5UWlCUERoWmRWUlVwbUxwYzllNEFOQUR1N3RiK3lzYjhhS3QzaFFWMldh?=
 =?utf-8?B?VFJPaVhIOStlU3VnR3BzbENxZkpsMjc4U0lsQ1J4YWRHbWlYZjlYNlM3b2R2?=
 =?utf-8?B?NzNaSHFjdmM0Q2kxdE5od282THBzd0U1ejNDUEdNcUhvc1lWKzBtR3lXSVFv?=
 =?utf-8?B?TkoyckNnY0lIZTE2dThJS25SY3hOUm9JaEs4L2p6ai9tZlVxYU5UemtFOU5r?=
 =?utf-8?B?Q2ZEcUd4YjlZOXhML3RqeUttK2tFS1VhMW52WFh6SWRqcWJ6QU1uT1I4aUVn?=
 =?utf-8?B?QU4rUnVKQUdDa041NXQrRUVDMDVRQ0pvMGd1ZVJaREZuZGxvR2czQUR5WEVq?=
 =?utf-8?B?V1hNSWlFSzR6Q29mMXlMd1hDSjFLSmd5YjVRejdCSEdxTG1yWlBWMW5DaWs1?=
 =?utf-8?B?RHFjK1V2eExyLzJWR3V3Z0lTRTMrK1BzZXRRQitISk9rL0VKbzJMWlkrM2x3?=
 =?utf-8?B?M1pTWHpZMmN1bVZNZzBxN0dqaXhQTVdnQWp0TVhsZy9UZENJSU1pSmVoTTRq?=
 =?utf-8?B?Yit0RXBQcVZvM0ZYZFN5T2lHTVJnVXFrQUhsSytDbzRkZ2tVbkt1Wkk1bWtS?=
 =?utf-8?Q?Gg5/42aClh8anNONDopi8HH1VE7+nw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDBGUTF2RkQ4TmVVdFdqMjRCYVhhTVhzSUdXY0JTb0ExUGZlUkdKWlB0NUlO?=
 =?utf-8?B?QVl2VmFZMEk5K0RjUTZJcFpLVGVZNmlpY20yR2h5c05HVXUzMTR5WUxQYmxO?=
 =?utf-8?B?SG5qdTRPMGwrWk1nZ3BDUktsVy82TjA4USsvRW0wT2ZtcEp0T1BGZ2lQZXBL?=
 =?utf-8?B?cDNCMzAzVmZDWHovMzlBM28zVXdQaGVYZFRmMTZING5DT1ZJRm1oN2Z2N2tU?=
 =?utf-8?B?dlJzTndIdE4rZkxoQlQzaXZsdDEzcHZCYy9OWFpPVXFkUm5vakZaVkp6TnlD?=
 =?utf-8?B?YmxSaHREVXpJaS9yMllBbzk0TytNVVhicXNKR3RvN1ZLNkFCU2hHMUNRZmhC?=
 =?utf-8?B?ODFMR3lHeWxKK01qc0Qyd3BBbzk1TWl5alRPSUR5bFpmZ3RCNC9KR1QyZUJK?=
 =?utf-8?B?Q2d5cmVsNlhTTWRvMFR1OTV0TWZ5Z2VWM0lPTjZDUytIRitvSWcyOUVnWkFj?=
 =?utf-8?B?N29jcDBwZzNibFFXU2VGbnZ2bnVqajA2WnBwNmJmMCtkaDVpTGp4d2lOQ2ZP?=
 =?utf-8?B?VzZoRDVvRGJxNXRvb0xyUHZNS21UYjFEYXA3OHgyNUlZa1ZXV2lqbWZ0azJC?=
 =?utf-8?B?TFlQMk1aNmw1SW1BVEVXaXc2RXErUmRVeHl4eWJvMjZTVDk4S1Z5YUxXTlFr?=
 =?utf-8?B?ZmJXbkJ1bWR1ZWx6b3M2QWNITU5odjFOSEFwNVhPZE5lSWI3VjZhMzdMbjNR?=
 =?utf-8?B?Vjk2MHBRUGVVM012MFZBOG8zRmpzQWhlTlh3WXpHU1ZSaFRjRWxac2REdVFx?=
 =?utf-8?B?bGkwdmVpUzU3VVptTjN0VmlmMGIrYzA3ZE9WWDVsemx5WU82TGFqdWs0VC96?=
 =?utf-8?B?MGFsaDRmWTdZOGZCQldHTTlOTUFSS2l0SDNWU1UwUTFGd2xVU0JTUFpSbFNF?=
 =?utf-8?B?ZHhmNEtQUjAvSXBsbmtMY3hOd3R1a3NzWlU5V3FqTWlEdFYrTmhNY01pV3hC?=
 =?utf-8?B?YmtEeHRKaE5YRjNDVTFZUkMrQmdWam1XK1N2MGZmQUVjem5PcUdrOFNVV2Rm?=
 =?utf-8?B?d1psUHQ5NFg0Z05KMTdVdFhsZmcvRDVMQityNmNXSVdKVXZQMWdnOUZGOVZG?=
 =?utf-8?B?L2tUNVNiRFFENVZUQURoL2R3NVhrdHNNdksrQ21tZGM4MXpncmpOTjZEZkVO?=
 =?utf-8?B?b2tJUEdUT2N5TWp3bDVOYkVlc2hlUjBrVDJPWnZOa0huU0FDZm5sckNkbUVD?=
 =?utf-8?B?UXNLcjU5SndjZ2FMK1lqKzJWMWZNdmhFcVdQOFNFYnk3MXl6U01mRTFrdW9j?=
 =?utf-8?B?TExXMEowZGFDQlpTemZvYkhZTGJmSHA2T0gybkxiZkRvUUZ2Z2h1cUZBQjFR?=
 =?utf-8?B?dFQxRHRoTnpOZmVZaW1lTVlzem1QdkNvWnRsOEltTUhFck41aTB1MVp2TDdN?=
 =?utf-8?B?a0tUelFUOG1NQzBibHVZbVZ5eGxxL2h2UmlPRS9vSHAxTkgxcFU5RzYwcG1z?=
 =?utf-8?B?WnNFTitnbk5veVFrUGRYWDZuaGhBMUN6amg4a3VrRWRCWlgrekluV1FnbWdm?=
 =?utf-8?B?OTU3di80R3J3SkQzbXFrMXRYb09hbVd5bjFOOFpxZUVkOU5DVlJxVzQ1MGEz?=
 =?utf-8?B?ZU1iRVRnUGVhZEhqYlAyelBTWkIvSUF1OXBqR2dveTc5cjR1QlBuMmdtT1hD?=
 =?utf-8?B?SGZNSTZIRlJTMWhWUndkekhVNFJZNXh1S25ZNHJOejdzU1hEOFZqWGZVMnFr?=
 =?utf-8?B?bFNMYkhtZU16a3NjcVRKQ2pYa0pNTWg5YmFNRExXUzdOWmFDMU44ajlyUzZj?=
 =?utf-8?B?bkFaNldWQTlqZEZnYzVBR2xaWVBhVG5zcjFrT2QwYWRkZ0l5Y0pHWDZaVm9I?=
 =?utf-8?B?cjhoUEwvYXVyYmlldjZUc3dZamlwbVkzbFFzNzRCL0l2a0FSazVyaE5Wdndv?=
 =?utf-8?B?YlZFSEFreWJVYlhvRENvWG05M1hNL091SncrRnpQNENsdXoyeXZ4SGRNTE1O?=
 =?utf-8?B?amVNUUM4cmd4ZXZPeTEyQmFBT080M1hrQ3VuUTBVUkwxalY1OGkrc0xCa0Ry?=
 =?utf-8?B?bkpJZlo2RWU5VDNXWDAxN1AvOHBLMW83WmxaUUFzckVpYWR2RTFVVCtMUXFX?=
 =?utf-8?B?S0c3a0oraCtTVW41UEVKRXZrMlJGMDRCQVlMSHAxTlV2VEd2RmR5YktUaTA0?=
 =?utf-8?Q?q26fuGFq3T/sjkcfIE1fYdEMw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9896cde3-6098-4ce4-bf42-08dd7cd889af
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 11:19:22.0664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdXN0zGjb9nTgoHHqlpSpMNBN/tJpSngSucr26V5cVRRjckC7xON/nQl2rWNCCBGWhAH2NSTCQ29zHNuohex3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505

DQoNCj4gT24gQXByIDE1LCAyMDI1LCBhdCA4OjE54oCvUE0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIEFwciAxNCwgMjAyNSBh
dCAxMTowNTo0NUFNIC0wNDAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IE9uIDQvMTAvMjAy
NSAyOjI5IFBNLCBQYXVsIEUuIE1jS2VubmV5IHdyb3RlOg0KPj4+PiArc3RhdGljIGludCByY3Vf
Z3B3cmFwX2xhZ19pbml0KHZvaWQpDQo+Pj4+ICt7DQo+Pj4+ICsgICAgaWYgKGdwd3JhcF9sYWdf
Y3ljbGVfbWlucyA8PSAwIHx8IGdwd3JhcF9sYWdfYWN0aXZlX21pbnMgPD0gMCkgew0KPj4+PiAr
ICAgICAgICBwcl9hbGVydCgicmN1LXRvcnR1cmU6IGxhZyB0aW1pbmcgcGFyYW1ldGVycyBtdXN0
IGJlIHBvc2l0aXZlXG4iKTsNCj4+Pj4gKyAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4gV2hl
biByY3V0b3J0dXJlIGlzIGluaXRpYXRlZCBieSBtb2Rwcm9iZSwgdGhpcyBtYWtlcyBwZXJmZWN0
IHNlbnNlLg0KPj4+IA0KPj4+IEJ1dCBpZiByY3V0b3J0dXJlIGlzIGJ1aWx0IGluLCB3ZSBoYXZl
IG90aGVyIGNob2ljZXM6ICAoMSkgRGlzYWJsZSBncHdyYXANCj4+PiB0ZXN0aW5nIGFuZCBkbyBv
dGhlciB0ZXN0aW5nIGJ1dCBzcGxhdCBzbyB0aGF0IHRoZSBib2d1cyBzY3JpcHRpbmcgY2FuDQo+
Pj4gYmUgZml4ZWQsICgyKSBGb3JjZSBkZWZhdWx0IHZhbHVlcyBhbmQgc3BsYXQgYXMgYmVmb3Jl
LCAoMykgU3BsYXQgYW5kDQo+Pj4gaGFsdCB0aGUgc3lzdGVtLg0KPj4+IA0KPj4+IFRoZSB1c3Vh
bCBhcHByb2FjaCBoYXMgYmVlbiAjMSwgYnV0IHdoYXQgbWFrZXMgc2Vuc2UgaW4gdGhpcyBjYXNl
Pw0KPj4gDQo+PiBJZiB0aGUgdXNlciBkZWxpYmVyYXRlbHkgdHJpZXMgdG8gcHJldmVudCB0aGUg
dGVzdCwgSSBhbSBPayB3aXRoICMzIHdoaWNoIEkNCj4+IGJlbGlldmUgaXMgdGhlIGN1cnJlbnQg
YmVoYXZpb3IuIEJ1dCBvdGhlcndpc2UgIzEgaXMgYWxzbyBPayB3aXRoIG1lIGJ1dCBJIGRvbid0
DQo+PiBmZWVsIHN0cm9uZ2x5IGFib3V0IGRvaW5nIHRoYXQuDQo+PiANCj4+IElmIHdlIHdhbnQg
dG8gZG8gIzMsIGl0IHdpbGwganVzdCBpbnZvbHZlIGNoYW5naW5nIHRoZSAicmV0dXJuIC1FSU5W
QUwiIHRvDQo+PiAicmV0dXJuIDAiIGJ1dCBhbHNvIG1heSBuZWVkIHRvIGJlIGRvaW5nIHNvIG9u
bHkgaWYgUkNVIHRvcnR1cmUgaXMgYSBidWlsdC1pbi4NCj4+IA0KPj4gSU1PIHRoZSBjdXJyZW50
IGJlaGF2aW9yIGlzIHJlYXNvbmFibGUgdGhhbiBhZGRpbmcgbW9yZSBjb21wbGV4aXR5IGZvciBh
bg0KPj4gdW51c3VhbCBjYXNlIGZvciBhIGJ1aWx0LWluPw0KPiANCj4gVGhlIGRhbmdlciBpcyB0
aGF0IHNvbWVvbmUgYWRqdXN0cyBhIHNjZW5hcmlvLCBhY2NpZGVudGFsbHkgZGlzYWJsZXMNCj4g
KmFsbCogLT5ncHdyYXAgdGVzdGluZyBkdXJpbmcgYnVpbHQtaW4gdGVzdHMgKGt2bS5zaCwga3Zt
LXJlbW90ZSxzaCwNCj4gYW5kIHRvcnR1cmUuc2gpLCBhbmQgbm9ib2R5IG5vdGljZXMuICBUaGlz
IGhhcyB0cmlwcGVkIG1lIHVwIGluIHRoZQ0KPiBwYXN0LCBoZW5jZSB0aGUgZXhpc3Rpbmcgc3Bs
YXRzIGluIHJjdXRvcnR1cmUsIGJ1dCBvbmx5IGZvciBydW5zIHdpdGgNCj4gYnVpbHQtaW4gcmN1
dG9ydHVyZS4NCg0KQnV0IGluIHRoZSBjb2RlIHdlIGFyZSBkaXNjdXNzaW5nLCB3ZSB3aWxsIHNw
bGF0IHdpdGggYW4gZXJyb3IgaWYgZWl0aGVyIHBhcmFtZXRlciBpcyBzZXQgdG8gMD8gIFNvcnJ5
IGlmIEkgbWlzc2VkIHNvbWV0aGluZy4NCg0KPiANCj4+IE9uIHRoZSBvdGhlciBoYW5kIGlmIHRo
ZSBpc3N1ZSBpcyB3aXRoIHByb3ZpZGluZyB0aGUgdXNlciB3aXRoIGEgd2F5IHRvIGRpc2FibGUN
Cj4+IGdwd3JhcCB0ZXN0aW5nLCB0aGF0IHNob3VsZCBJTU8gYmUgYW5vdGhlciBwYXJhbWV0ZXIg
dGhhbiBzZXR0aW5nIHRoZSBfbWlucw0KPj4gcGFyYW1ldGVycyB0byBiZSAwLiBCdXQgSSB0aGlu
ayB3ZSBtYXkgbm90IHdhbnQgdGhpcyB0ZXN0aW5nIGRpc2FibGVkIHNpbmNlIGl0DQo+PiBpcyBh
bHJlYWR5ICJzZWxmLWRpc2FibGVkIiBmb3IgdGhlIGZpcnN0IDI1IG1pdXRlcy4NCj4gDQo+IFdl
IGRvIG5lZWQgYSB3YXkgb2YgZGlzYWJsaW5nIHRoZSB0ZXN0aW5nIG9uIGxvbmcgcnVucyBmb3Ig
ZmF1bHQtaXNvbGF0aW9uDQo+IHB1cnBvc2VzLg0KDQpUaGFua3MsIEkgd2lsbCBhZGQgYW4gb3B0
aW9uIGZvciB0aGlzLg0KDQo+IA0KPiBGb3IgZXhhbXBsZSwgcmN1dG9ydHVyZS5uX3VwX2Rvd249
MCBkaXNhYmxlcyBTUkNVIHVwL2Rvd24gdGVzdGluZy4NCj4gU3BlYWtpbmcgb2Ygd2hpY2gsIEkg
YW0gYWRkaW5nIGEgc2VjdGlvbiBvbiB0aGF0IHRvcGljIHRvIHRoaXMgZG9jdW1lbnQ6DQo+IA0K
PiBodHRwczovL2RvY3MuZ29vZ2xlLmNvbS9kb2N1bWVudC9kLzFSb1lSclRzYWJkZVRYY2xkenBv
TW5wbW1DakdiSk5XdERYTjZaTnJfNEg4L2VkaXQ/dXNwPXNoYXJpbmcNCg0KTmljZSwgdGhhbmtz
LA0KDQogLSBKb2VsDQoNCg0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgVGhhbngs
IFBhdWwNCg==
