Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3613D521;
	Thu, 24 Jul 2025 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325412; cv=fail; b=iG9t+nep38+wenY4B+IJwQwdEqTqiqPFdRtY2jQO6L+ESGGlYsGvhFtkqRfaqs6TV5wNMzBlqtY60s8HV4wdY+RX0Sp26Uk7ePyi34MvCq2T3zL8UZT6Zf/s041YULdaVZf4tjuF6qbCOPMm9+EgHWlCAksSvJK/5+u1n7E/SMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325412; c=relaxed/simple;
	bh=12fdF0r99wq6kJnEwTGVPoeS9i/7SwxQBp7df07K2tc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CGhsDBkWzJ0idIrNCvS9heKyVTcx0mLZFMPOQvrtm23VoTRjlFW2owFSJdfyuHuUcBrsD9avOIs1UWonXDhAk0CDs5CaPoiNVBybda+fmo91YdChU3C3tHoAF4vZU/wgSzzOv7/9UaEcAxfI8ZbvjWjn9+6YbpWav8ydI7FHD7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GfG1jWQn; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=lN6BN3CE; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GfG1jWQn";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="lN6BN3CE"
X-UUID: e65cae08683811f08b7dc59d57013e23-20250724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=12fdF0r99wq6kJnEwTGVPoeS9i/7SwxQBp7df07K2tc=;
	b=GfG1jWQnLvNK0y8JtkC6j6Twd/wQm7gcTvFyr6n4YPYPR9m+VKDbitdt92gQhhHT9ilKrRwg5QUrAA6imtMMG0k3usIAW8uWqKmer6IbK/oYb/0NI/FhdGV4BDjd1ze3Pew1iVUOynDfsIN3kYo7uE+TdZWD2mvjiiRP8mv1N1Q=;
X-CID-CACHE: Type:Local,Time:202507241050+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:d117316b-0e0e-413a-b597-337e251b3325,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:846f3050-93b9-417a-b51d-915a29f1620f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e65cae08683811f08b7dc59d57013e23-20250724
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1665129360; Thu, 24 Jul 2025 10:50:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 24 Jul 2025 10:50:01 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 24 Jul 2025 10:50:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOlw4Llvw9oCRwi/hjKGtVWcYRbgPTeT1BFIuErdNNyfMU77xGLY5tMC2he/tEkjbzVvgUd5U8/dlfOWZhiIJdJZ2nIV2eTd+uBGQ4kWk8EqpFbvQokZ8xwGi31T54JBOmKWI40/FwZiB8DkNJS81FoZ0ECaSYEb3mWJ/JCLlJfNOPJgWAZWX0Iuh69BlbzAZoHCrYgtwN2NlmRCrde6SEBtzTJ0ONJTwnqZwHZaqkDjeu/1U+oMU4H4PftRVcSgA3HCZ/zb6rY5+SOsQQmlDFvweFbk7xfZsC1zzpi8bVzJHpLIEw9R6zp3W54iyVCUIx1N+TEXwORfs0OIVZwuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12fdF0r99wq6kJnEwTGVPoeS9i/7SwxQBp7df07K2tc=;
 b=nqwNXzZXHHoh5QE1W9blZjvvEbH/H6uahLVal1p8NaX4lKowJyYwXVEqzfyUHqFSLTrc2kEERJFdilrENybrm3qc3dcBw5xZw11daufe0GgArRyCle9S910XiHdzE6lWHuy88nMI6p2Ks+YLmf8nWKyeTJWmAeuzGGQtU01bmlyEmsBJ0HQZpesRipIRG43Q+ZYTKZE6OXsPhTa/c5xmG8CPd2T0DMs0AKvxTN3RVpx1sSFKGB4OGA1E23mRnhZKB4W9Vu3LgwoV3mGrJpHGGJxx4tfxaIHXynB4tMNwtTCgcC+xJ6fN4dVD1B571Vq5mfOw2Ja39/sMQMRtnCZ75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12fdF0r99wq6kJnEwTGVPoeS9i/7SwxQBp7df07K2tc=;
 b=lN6BN3CE5wj3Q/iv0XJWLl9ValIIj2/d4LuZtL7ZlSKfLEfIgrxi0rBL4lPveuYr9blDWoUifXASM+CcD+c76TOnA/kyZ+walsVG3+HM5hVzDpzwROc1KR0ZNFPqtFfv0L8GOz+lJwOvVO39vBh9brR/+ba0ebe8IkMDBlrEM/U=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by TYZPR03MB7932.apcprd03.prod.outlook.com (2603:1096:400:44d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 02:50:00 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350%3]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 02:49:59 +0000
From: =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>
To: "frederic@kernel.org" <frederic@kernel.org>, "joelagnelf@nvidia.com"
	<joelagnelf@nvidia.com>
CC: "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	=?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>, "josh@joshtriplett.org"
	<josh@joshtriplett.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	=?utf-8?B?TG9ycnkgTHVvICjnvZfno4op?= <Lorry.Luo@mediatek.com>,
	"weiyangyang@vivo.com" <weiyangyang@vivo.com>,
	=?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"urezki@gmail.com" <urezki@gmail.com>, "qiang.zhang@linux.dev"
	<qiang.zhang@linux.dev>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, wsd_upstream
	<wsd_upstream@mediatek.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, "joel@joelfernandes.org" <joel@joelfernandes.org>
Subject: Re: [PATCH] rcu: Fix delayed execution of hurry callbacks
Thread-Topic: [PATCH] rcu: Fix delayed execution of hurry callbacks
Thread-Index: AQHb9t9raNmcFZGwikqNUlcFsD7Q4rQ2UWAAgAFIgICACDWIAIAAziIA
Date: Thu, 24 Jul 2025 02:49:59 +0000
Message-ID: <f7fce1ac56b908d49bf75359dd679d6664b648bf.camel@mediatek.com>
References: <20250717055341.246468-1-Tze-nan.Wu@mediatek.com>
	 <aHj79rtgLm-7tT9E@localhost.localdomain>
	 <2c69ead1047ff7b7671b8b577fe69884870f66fd.camel@mediatek.com>
	 <092ec583-9ad4-4d37-8dad-6008267a56a3@nvidia.com>
In-Reply-To: <092ec583-9ad4-4d37-8dad-6008267a56a3@nvidia.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|TYZPR03MB7932:EE_
x-ms-office365-filtering-correlation-id: 81080270-795d-453e-eb72-08ddca5cc7fa
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SU83UkZhK3d0YWhneTZZMW5NR0cxaTZFY0Y2K29sRzZFNXFDMjdyN0IrczhO?=
 =?utf-8?B?VEVjQUxmNjJDQ1VKQmx5MXFld1lqYXdJS0dyMmlQVUFRR1BlK2F5akx5dVFl?=
 =?utf-8?B?WElBV21OT2VOdjdGaUJ1L1hlYjlUYjd3eFUrVFBhV09kMnBoS1EyQis5Nkd6?=
 =?utf-8?B?dmVZN1c2Z1pscC9ZQjJ6eEFNUWdiblRYU3R6aThmQjJ4MCttOU8xWXc3djlV?=
 =?utf-8?B?d1UyWHMzWmRmb2ZBZHIyMDYwZ3oyM2hOdjZHSkpwN0l1RDFzNStzaXJqRTBz?=
 =?utf-8?B?WVVUTTM4Yng1TUJTQVVSM2tZUm1CUzJWWnNZR0xNY2dNdU1lelFPT0Q0U2xh?=
 =?utf-8?B?OXI2UUJJYWVYWERVeTJ3UkxTNGNTelp1UVVJSUYvTmZVZ3A3VFVUckhrNURt?=
 =?utf-8?B?OVlzOERodDRFakNxVHJSelRuQlJjZXczb0dFMHVGcG51L3Q5d3ppMXFkQkNr?=
 =?utf-8?B?UHkxUGZNZDIxMmZBbTFURHJYc2duS0dkVkd0Y0hjaElJNzRLdFBCeFlFc3JH?=
 =?utf-8?B?ZnZoNXpJV3VQcm5OMnZ2MUZPbzB2UlFlU29TNTFHb0hvYmhaL3lBVEhaSytJ?=
 =?utf-8?B?TDQyQm8xaHFXUFIwNTJxM3g2ZVdkcW5rdkJ3alE5SkF2KzN5U0c4RnEzWWFa?=
 =?utf-8?B?OFhlbllvazdKK3Y0c2l2ZXhnWVJxSkorZUlhQWtTZDZCZmlyc2hGdDdDam1j?=
 =?utf-8?B?YWZnU3BMalRrbmp0bkp4TndpZ2txK3FPRFZKWHBoQXFIUloxcEwyYnFhMWxv?=
 =?utf-8?B?MjNqQjUyd3pJU3lmMGp1SDlOZGZvMWljNE51RHNIcjdsbjVsbTZrSFBqcEQ2?=
 =?utf-8?B?clF2ZDZ5ZjVnQzR3aFE5K1NHTUYxeVBBVVR2RnI0Q3I0VDkwTTJ4NzkxODFY?=
 =?utf-8?B?b1dvY3k1SU9MSmNXcFpjVk9mS254L2JLUUFDTWUxREVpbUQvV3VPVkVIY0lN?=
 =?utf-8?B?MHNscHljVms0QVd1ZlhDQXNsbWlTbjM3NW9kbHlEL0ZadWpHTU9DYlk0VXVJ?=
 =?utf-8?B?UHNXb1pwcUlPWTdwVHV0SEJXR0NpZGdNNXZlYUkyMVJnZ0dFVVplRmJ0WHA1?=
 =?utf-8?B?b2ZTWEp6WGxxUWV4TnN6cjloaFd5QkUwN2RzQXA0ZmpYQ0ZoL0F2VFppTXV6?=
 =?utf-8?B?b3VwMTVtNnRsNWRLRTF2TDN1b1hIa0NDQ0MzUEVHMlJQR3VEcGJNRmpVbEJo?=
 =?utf-8?B?M2NHK1QwNDFCUVJ4RHhlWVFkRzRSbGZNbVRvOHlKOFFrOGVGTHNaRlduV003?=
 =?utf-8?B?Ry9OWGpLM2x1RkZFY0kveGlHT1g0MXVrM3ZraERxajJPRXVsVVMvKzhwNlpU?=
 =?utf-8?B?dm1lT2lCa1V5QmtYaENHY0tkcFk4ZytEbzJhRng4OUUyYTYyQU1yRnhHZTJF?=
 =?utf-8?B?UDcvU3BpdlZTV1pqcmNUeHBaTHZPbmM2SDJvZmVSaDNWK3RERWIyRmdQUVlr?=
 =?utf-8?B?ZW0zOGZ5K3Y4cmN5QmRpamdnekpWQWMxWWx2Y3JubDl1bkEwNFRRMXo4L3Yy?=
 =?utf-8?B?WEhBWFJBNURpTW9JUVZ5bnBXaE5VRXd4VkJySEUwemZHUjlYTmdhYmJyeUx2?=
 =?utf-8?B?YWcwMk4zbC9Jb3Q3bGEzb1p3QWhweWJINE9FdVNLNnk1ZTZKczhReVBBZHBE?=
 =?utf-8?B?UjUxTVB2c1AyZkZPSTVlM2VTRDIrNEg1aklPMUVaTXpDSHFjNUN4VlJNbVlN?=
 =?utf-8?B?ay8yQ2d4NWdsMHg2SUprQnpEeG13NTZDNDF5TUlxZUQxemZpRXh2TkUvVEJy?=
 =?utf-8?B?TEVobzFHNERQbTArcHhXNjEzSXZ3cG42b1dGbm9hMmordEZsd3diM3h2aEFJ?=
 =?utf-8?B?clVwZ05NbWg1MkV6R0RwaENlY2d2WUIwa3ZFditQWWpNQUMwNUhZQnlNVEwx?=
 =?utf-8?B?UXJmNTJsQ0hKQnZlZ2FvSkEwWkhFK2RwNjNxQkNPN0YwWkxvVjZiQytneHNM?=
 =?utf-8?B?YStPWmV4N2lsNksrbmFVYXoxUDViYjc3QVdMMEVrWkt4N3QvSmd3RTlleVYr?=
 =?utf-8?B?KzhYbGRrcUhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVNJR0ZpV0hlWWlXTDNwQXBwejgwTGt6SE83RHd4bk1ET1lhSlowakZmSGw0?=
 =?utf-8?B?dlNyTzBaMnhLbG12dnpmUUtlK0RGTEsvOUFRS05XNXFwM3NoUHZLK1VZUHhk?=
 =?utf-8?B?NjN4L2ZZT2UzRkpKZS81K1hDcFd2VHNDak9USnZGRiszYnNmU3Q2WEpmWEhx?=
 =?utf-8?B?YW9OUmRrS1RpdTd6dXZPUFRXM2Z6M2dLRFhhNjl6Wmx0QUJEQzdsbmV5aVdy?=
 =?utf-8?B?VVg0MTRVU2JSdFc3SndScUJ0THZQWllXdEQ2TUZDY3FEc05WdHNDMVFrV2ln?=
 =?utf-8?B?UWFlUldyWldlZ0pDVm1IWUxvOUZqcUpjS3ZERjdpNko4VHRMYmw3ZlI2S1o5?=
 =?utf-8?B?YSszUlpialI0VCtNU3RrdGdCYUY1UFl2V2I1WEZ4UnJyVVcyWFd0MEhNOWxG?=
 =?utf-8?B?ZDY2eS9rdk92WWZYVUd3aGZpT29zTDNkZkU4V05FRnpoSElQUFF0K2NRYTdQ?=
 =?utf-8?B?dDhyNVhsV2NEZm94U3V2dkZBQ3dyTkpkVmJodzk0TFRTNHhQcjZUUUJheGxO?=
 =?utf-8?B?NzNsUWlvb2UvTTFnUGd0aHJFbFI5d2t1c0NLN29SQnJ6N1h6SEVNRjVqS2dr?=
 =?utf-8?B?Y3JHY3NiaDNDWlZSNU5WSlA2ZG8xZlJXVytpcmpCUGhGdDdOL3dtZHJnbnEw?=
 =?utf-8?B?TTV6azc0Tkk4ODUrUHVlbDdqOGRJSmo5djQwNEVRVStpdUFkNlozRlJVT09r?=
 =?utf-8?B?Nk90Wkdna3VnZXBHYW0zellJaWtHa1lyZGdrQWdtazJiTlJINDR6U0RSSlFO?=
 =?utf-8?B?YndxbFZuRDl2WHdFVnpnQk1sYjJ5ejZRdDI0TS95am9RNkZ1OUZSMkw2cVZK?=
 =?utf-8?B?a0RQUXBqb3BkRU5MTkEzcWtDeDdSZE00dWdqWTZBL3Y1NjVRZTQ2VTdXQmtY?=
 =?utf-8?B?cWF1KzBncUVDS092VE1pbUsxQThyVDNyekx3aW1XQnRyM01vQkFubWJmWXZJ?=
 =?utf-8?B?U1l2bE54ZU13SzlmeVNONnFNSjVybDEraHV3Und2NjZBT0lwMmh2dEZaZkh4?=
 =?utf-8?B?ZDB2d0JiUDFPUnZqTUcveGFoTlRPOWV0a01ZOFpDWXpKVnJUclJaUVVxQ2I0?=
 =?utf-8?B?SUQ1blBNNlNSTWY0Sk9CS3diTERXYld0c1hKK25RK1B1L0ZraVZ6RjhiL0Jx?=
 =?utf-8?B?WEprbTRha1AwTmRXL1QrMmd1QURaZjlUQ1d5aG1ONUFsdHRmbzZRMjVtMUhW?=
 =?utf-8?B?R0w1T3FEVUVVa0FKeEEzWHpwR0F1Nzd5bFRnR3lXOW0yN0lpNTJYQ1VqR2FI?=
 =?utf-8?B?VnRkUGFaL3Q4NDA2TGorUUcycFlIc1RsNGF0QTYvYXVJb1NhTTVTWE5HRGtL?=
 =?utf-8?B?RjZ5SWtVaTdNUWlmYVY0a1AwbVhNNHdhdnlKckRBY2V0Y21KbFhpTzFFeE4x?=
 =?utf-8?B?clNvK0hmcFVUZXhZVGhBRjlPNlAxdWE4ak5DSmRGU2g5K2x2TktQNUNDS0ZO?=
 =?utf-8?B?OHRaRThjakhBVFlDMWRrbklaVjNpVG84d2ZOT0ptd0J1Mi8xNnRzUDkzWlZC?=
 =?utf-8?B?V1NOdE1yRmpnVElyQnBOalpmVUd2TDU2UGxuYTFqMG9YVmVxNE9hc3YzWm1Q?=
 =?utf-8?B?MzMrSlVkdFRucHY0OUZ6ZGVOWW0rTVpkc0w1QU9ibVhNdndkYm5FYUVFcStz?=
 =?utf-8?B?azZETFNFZEhLakp1NGQwMy9PTUlwS01pTjdZTVdZelJPSVRCbDFqUXVPTFRY?=
 =?utf-8?B?SkR2WXZLTUhudDRaTEc3aXR0NEJHTmFBQXNBdVJjeHVJd3BaeWZNd1FFZTVa?=
 =?utf-8?B?ZDNlL09PblYrVTdGckhYczZxRTdzZFh4RkxObHowZkprT00vOG52S2dPbDV1?=
 =?utf-8?B?K3Q0YURIU3F6Sms1VTgrTFVqeE1NSUwvck5HUVh6U2RQL1laRmpWb01UNk1n?=
 =?utf-8?B?T0Y5eVRqSGlmVzU3YTA2aUlyWDI4ZDhpVCtxdTlGcjNSay9sNEZma0hnS1d3?=
 =?utf-8?B?eC94c1J2MVpIU0xxUWtHOGNyTnlRTGliNW1aYkQyYmUrdXZaMW1FRFg4SDB5?=
 =?utf-8?B?bzN5c21lSVkzVTVvbU1HcStmVUxNTXltdG5CV3hiclFhejdrUFJNYlI2UkRS?=
 =?utf-8?B?R1Q2K3BicDVncEhZWGdQMmRmWEsvRXJTOGYyMmtBQm5BaTRvZnBVMmZHRzNw?=
 =?utf-8?B?UEdRWTkxYXUzU25TVWY1UG9UcUlKZ0NpZWU5WlErS3hId1RRYUl4LzB5cExT?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A162AD4835DD1C4198276C1A537FB5E1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81080270-795d-453e-eb72-08ddca5cc7fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 02:49:59.7318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mm4ha3UAohZcKu26AOyiZQF2zU0DI6X9tfaJkK1se3pyrXh452b8Ot6Z2k49JqcTFJxIYr/z0w/vpYCOVLan9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7932

T24gV2VkLCAyMDI1LTA3LTIzIGF0IDEwOjMyIC0wNDAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToN
Cj4gDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IA0KPiANCj4gT24gNy8xOC8yMDI1IDU6MTAgQU0sIFR6ZS1uYW4gV3UgKOWQ
s+a+pOWNlykgd3JvdGU6DQo+ID4gT24gVGh1LCAyMDI1LTA3LTE3IGF0IDE1OjM0ICswMjAwLCBG
cmVkZXJpYyBXZWlzYmVja2VyIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6
IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gdW50
aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+
ID4gPiANCj4gPiA+IA0KPiA+ID4gTGUgVGh1LCBKdWwgMTcsIDIwMjUgYXQgMDE6NTM6MzhQTSAr
MDgwMCwgVHplLW5hbiBXdSBhIMOpY3JpdCA6DQo+ID4gPiA+IFdlIG9ic2VydmVkIGEgcmVncmVz
c2lvbiBpbiBvdXIgY3VzdG9tZXLigJlzIGVudmlyb25tZW50IGFmdGVyDQo+ID4gPiA+IGVuYWJs
aW5nDQo+ID4gPiA+IENPTkZJR19MQVpZX1JDVS4gSW4gdGhlIEFuZHJvaWQgVXBkYXRlIEVuZ2lu
ZSBzY2VuYXJpbywgd2hlcmUNCj4gPiA+ID4gaW9jdGwoKSBpcw0KPiA+ID4gPiB1c2VkIGhlYXZp
bHksIHdlIGZvdW5kIHRoYXQgY2FsbGJhY2tzIHF1ZXVlZCB2aWEgY2FsbF9yY3VfaHVycnkNCj4g
PiA+ID4gKHN1Y2ggYXMNCj4gPiA+ID4gcGVyY3B1X3JlZl9zd2l0Y2hfdG9fYXRvbWljX3JjdSkg
Y2FuIHNvbWV0aW1lcyBiZSBkZWxheWVkIGJ5IHVwDQo+ID4gPiA+IHRvDQo+ID4gPiA+IDUNCj4g
PiA+ID4gc2Vjb25kcyBiZWZvcmUgZXhlY3V0aW9uLiBUaGlzIG9jY3VycyBiZWNhdXNlIHRoZSBu
ZXcgZ3JhY2UNCj4gPiA+ID4gcGVyaW9kDQo+ID4gPiA+IGRvZXMNCj4gPiA+ID4gbm90IHN0YXJ0
IGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBwcmV2aW91cyBvbmUgY29tcGxldGVzLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gVGhlIHJvb3QgY2F1c2UgaXMgdGhhdCB0aGUgd2FrZV9ub2NiX2dwX2RlZmVyKCkg
ZnVuY3Rpb24gbm93DQo+ID4gPiA+IGNoZWNrcw0KPiA+ID4gPiAicmRwLT5ub2NiX2RlZmVyX3dh
a2V1cCIgaW5zdGVhZCBvZiAicmRwX2dwLQ0KPiA+ID4gPiA+bm9jYl9kZWZlcl93YWtldXAiLiBP
bg0KPiA+ID4gPiBDUFVzDQo+ID4gPiA+IHRoYXQgYXJlIG5vdCByY3VvZywgInJkcC0+bm9jYl9k
ZWZlcl93YWtldXAiIG1heSBhbHdheXMgYmUNCj4gPiA+ID4gUkNVX05PQ0JfV0FLRV9OT1QuIFRo
aXMgY2FuIGNhdXNlICJyZHBfZ3AtPm5vY2JfZGVmZXJfd2FrZXVwIg0KPiA+ID4gPiB0byBiZQ0K
PiA+ID4gPiBkb3duZ3JhZGVkIGFuZCB0aGUgInJkcF9ncC0+bm9jYl90aW1lciIgdG8gYmUgcG9z
dHBvbmVkIGJ5IHVwDQo+ID4gPiA+IHRvIDEwDQo+ID4gPiA+IHNlY29uZHMsIGRlbGF5aW5nIHRo
ZSBleGVjdXRpb24gb2YgaHVycnkgUkNVIGNhbGxiYWNrcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRo
ZSB0cmFjZSBsb2cgb2Ygb25lIHNjZW5hcmlvIHdlIGVuY291bnRlcmVkIGlzIGFzIGZvbGxvdzoN
Cj4gPiA+ID4gwqAgLy8gcHJldmlvdXMgR1AgZW5kcyBhdCB0aGlzIHBvaW50DQo+ID4gPiA+IMKg
IHJjdV9wcmVlbXB0wqDCoCBbMDAwXSBkLi4xLsKgwqAgMTM3LjI0MDIxMDogcmN1X2dyYWNlX3Bl
cmlvZDoNCj4gPiA+ID4gcmN1X3ByZWVtcHQgODM2OSBlbmQNCj4gPiA+ID4gwqAgcmN1X3ByZWVt
cHTCoMKgIFswMDBdIC4uLi4uwqDCoCAxMzcuMjQwMjEyOiByY3VfZ3JhY2VfcGVyaW9kOg0KPiA+
ID4gPiByY3VfcHJlZW1wdCA4MzcyIHJlcXdhaXQNCj4gPiA+ID4gwqAgLy8gY2FsbF9yY3VfaHVy
cnkgZW5xdWV1ZXMgInBlcmNwdV9yZWZfc3dpdGNoX3RvX2F0b21pY19yY3UiLA0KPiA+ID4gPiB0
aGUNCj4gPiA+ID4gY2FsbGJhY2sgd2FpdGVkIG9uIGJ5IFVwZGF0ZUVuZ2luZQ0KPiA+ID4gPiDC
oCB1cGRhdGVfZW5naW5lIFswMDJdIGQuLjEuwqDCoCAxMzcuMzAxNTkzOiBfX2NhbGxfcmN1X2Nv
bW1vbjoNCj4gPiA+ID4gd3l5Og0KPiA+ID4gPiB1bmxpa2VseSBwX3JlZiA9IDAwMDAwMDAwKioq
KioqKiouIGxhenkgPSAwDQo+ID4gPiA+IMKgIC8vIEZpcnN0USBvbiBjcHUgMiByZHBfZ3AtPm5v
Y2JfdGltZXIgaXMgc2V0IHRvIGZpcmUgYWZ0ZXIgMQ0KPiA+ID4gPiBqaWZmeSAoNG1zKQ0KPiA+
ID4gPiDCoCAvLyBhbmQgdGhlIHJkcF9ncC0+bm9jYl9kZWZlcl93YWtldXAgaXMgc2V0IHRvIFJD
VV9OT0NCX1dBS0UNCj4gPiA+ID4gwqAgdXBkYXRlX2VuZ2luZSBbMDAyXSBkLi4yLsKgwqAgMTM3
LjMwMTU5NTogcmN1X25vY2Jfd2FrZToNCj4gPiA+ID4gcmN1X3ByZWVtcHQgMiBGaXJzdFEgb24g
Y3B1MiB3aXRoIHJkcF9ncCAoY3B1MCkuDQo+ID4gPiA+IMKgIC8vIEZpcnN0QlEgZXZlbnQgb24g
Y3B1MiBkdXJpbmcgdGhlIDEgamlmZnksIG1ha2UgdGhlIHRpbWVyDQo+ID4gPiA+IHBvc3Rwb25k
IDEwIHNlY29uZHMgbGF0ZXIuDQo+ID4gPiA+IMKgIC8vIGFsc28sIHRoZSByZHBfZ3AtPm5vY2Jf
ZGVmZXJfd2FrZXVwIGlzIG92ZXJ3cml0ZSB0bw0KPiA+ID4gPiBSQ1VfTk9DQl9XQUtFX0xBWlkN
Cj4gPiA+ID4gwqAgdXBkYXRlX2VuZ2luZSBbMDAyXSBkLi4xLsKgwqAgMTM3LjMwMTYwMTogcmN1
X25vY2Jfd2FrZToNCj4gPiA+ID4gcmN1X3ByZWVtcHQgMiBXYWtlRW1wdHlJc0RlZmVycmVkDQo+
ID4gPiA+IMKgIC4uLg0KPiA+ID4gPiDCoCAuLi4NCj4gPiA+ID4gwqAgLi4uDQo+ID4gPiA+IMKg
IC8vIGJlZm9yZSB0aGUgMTAgc2Vjb25kcyB0aW1lb3V0LCBjcHUwIHJlY2VpdmVkIGFub3RoZXIN
Cj4gPiA+ID4gY2FsbF9yY3VfaHVycnkNCj4gPiA+ID4gwqAgLy8gcmVzZXQgdGhlIHRpbWVyIHRv
IGppZmZpZXMrMSBhbmQgc2V0IHRoZSB3YWtldHlwZSA9DQo+ID4gPiA+IFJDVV9OT0NCX1dBS0Uu
DQo+ID4gPiA+IMKgIGt3b3JrZXIvdTMyOjAgWzAwMF0gZC4uMi7CoMKgIDE0Mi41NTc1NjQ6IHJj
dV9ub2NiX3dha2U6DQo+ID4gPiA+IHJjdV9wcmVlbXB0IDAgRmlyc3RRDQo+ID4gPiA+IMKgIGt3
b3JrZXIvdTMyOjAgWzAwMF0gZC4uMS7CoMKgIDE0Mi41NTc1NzY6IHJjdV9ub2NiX3dha2U6DQo+
ID4gPiA+IHJjdV9wcmVlbXB0IDAgV2FrZUVtcHR5SXNEZWZlcnJlZA0KPiA+ID4gPiDCoCBrd29y
a2VyL3UzMjowIFswMDBdIGQuLjEuwqDCoCAxNDIuNTU4Mjk2OiByY3Vfbm9jYl93YWtlOg0KPiA+
ID4gPiByY3VfcHJlZW1wdCAwIFdha2VOb3QNCj4gPiA+ID4gwqAga3dvcmtlci91MzI6MCBbMDAw
XSBkLi4xLsKgwqAgMTQyLjU1ODU2MjogcmN1X25vY2Jfd2FrZToNCj4gPiA+ID4gcmN1X3ByZWVt
cHQgMCBXYWtlTm90DQo+ID4gPiA+IMKgIC8vIGlkbGUoZG9fbm9jYl9kZWZlcnJlZF93YWtldXAp
IHdha2UgcmN1b2cgZHVlIHRvIHdha2V0eXBlDQo+ID4gPiA+ID09DQo+ID4gPiA+IFJDVV9OT0NC
X1dBS0UNCj4gPiA+ID4gwqAgPGlkbGU+wqDCoMKgwqDCoMKgwqAgWzAwMF0gZC4uMS7CoMKgIDE0
Mi41NTg3ODY6IHJjdV9ub2NiX3dha2U6DQo+ID4gPiA+IHJjdV9wcmVlbXB0IDAgRG9XYWtlDQo+
ID4gPiA+IMKgIDxpZGxlPsKgwqDCoMKgwqDCoMKgIFswMDBdIGROLjEuwqDCoCAxNDIuNTU4ODM5
OiByY3Vfbm9jYl93YWtlOg0KPiA+ID4gPiByY3VfcHJlZW1wdCAwIERlZmVycmVkV2FrZQ0KPiA+
ID4gPiDCoCByY3VvZy8wwqDCoMKgwqDCoMKgIFswMDBdIC4uLi4uwqDCoCAxNDIuNTU4ODcxOiBy
Y3Vfbm9jYl93YWtlOg0KPiA+ID4gPiByY3VfcHJlZW1wdCAwIEVuZFNsZWVwDQo+ID4gPiA+IMKg
IHJjdW9nLzDCoMKgwqDCoMKgwqAgWzAwMF0gLi4uLi7CoMKgIDE0Mi41NTg4Nzc6IHJjdV9ub2Ni
X3dha2U6DQo+ID4gPiA+IHJjdV9wcmVlbXB0IDAgQ2hlY2sNCj4gPiA+ID4gwqAgLy8gZmluYWxs
eSByY3VvZyByZXF1ZXN0IGEgbmV3IEdQIGF0IHRoaXMgcG9pbnQgKDUgc2Vjb25kcw0KPiA+ID4g
PiBhZnRlcg0KPiA+ID4gPiB0aGUgRmlyc3RRIGV2ZW50KQ0KPiA+ID4gPiDCoCByY3VvZy8wwqDC
oMKgwqDCoMKgIFswMDBdIGQuLjIuwqDCoCAxNDIuNTU4ODg2OiByY3VfZ3JhY2VfcGVyaW9kOg0K
PiA+ID4gPiByY3VfcHJlZW1wdCA4MzcyIG5ld3JlcQ0KPiA+ID4gPiDCoCByY3VfcHJlZW1wdMKg
wqAgWzAwMV0gZC4uMS7CoMKgIDE0Mi41NTk0NTg6IHJjdV9ncmFjZV9wZXJpb2Q6DQo+ID4gPiA+
IHJjdV9wcmVlbXB0IDgzNzMgc3RhcnQNCj4gPiA+ID4gwqAgLi4uDQo+ID4gPiA+IMKgIHJjdV9w
cmVlbXB0wqDCoCBbMDAwXSBkLi4xLsKgwqAgMTQyLjU2NDI1ODogcmN1X2dyYWNlX3BlcmlvZDoN
Cj4gPiA+ID4gcmN1X3ByZWVtcHQgODM3MyBlbmQNCj4gPiA+ID4gwqAgcmN1b3AvMsKgwqDCoMKg
wqDCoCBbMDAwXSBELi4xLsKgwqAgMTQyLjU2NjMzNzogcmN1X2JhdGNoX3N0YXJ0Og0KPiA+ID4g
PiByY3VfcHJlZW1wdCBDQnM9MjE5IGJsPTEwDQo+ID4gPiA+IMKgIC8vIHRoZSBodXJyeSBDQiBp
cyBpbnZva2VkIGF0IHRoaXMgcG9pbnQNCj4gPiA+ID4gwqAgcmN1b3AvMsKgwqDCoMKgwqDCoCBb
MDAwXSBiLi4uLsKgwqAgMTQyLjU2NjM1MjoNCj4gPiA+ID4gYmxrX3F1ZXVlX3VzYWdlX2NvdW50
ZXJfcmVsZWFzZTogd3l5OiB3YWtldXAuIHBfcmVmID0NCj4gPiA+ID4gMDAwMDAwMDAqKioqKioq
Ki4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUgY29uZGl0aW9uIHRv
IGNoZWNrICJyZHBfZ3AtDQo+ID4gPiA+ID4gbm9jYl9kZWZlcl93YWtldXAiIGluDQo+ID4gPiA+
IHRoZSBsYXp5IHBhdGguIFRoaXMgcHJldmVudHMgYW4gYWxyZWFkeSBzY2hlZHVsZWQgInJkcF9n
cC0NCj4gPiA+ID4gPiBub2NiX3RpbWVyIg0KPiA+ID4gPiBmcm9tIGJlaW5nIHBvc3Rwb25lZCBh
bmQgYXZvaWRzIG92ZXJ3cml0aW5nICJyZHBfZ3AtDQo+ID4gPiA+ID4gbm9jYl9kZWZlcl93YWtl
dXAiDQo+ID4gPiA+IHdoZW4gaXQgaXMgbm90IFJDVV9OT0NCX1dBS0VfTk9ULg0KPiA+ID4gPiAN
Cj4gPiA+ID4gRml4ZXM6IDNjYjI3OGU3M2JlNSAoInJjdTogTWFrZSBjYWxsX3JjdSgpIGxhenkg
dG8gc2F2ZSBwb3dlciIpDQo+ID4gPiA+IENvLWRldmVsb3BlZC1ieTogQ2hlbmctanVpIFdhbmcg
PGNoZW5nLWp1aS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2hl
bmctanVpIFdhbmcgPGNoZW5nLWp1aS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gQ28tZGV2
ZWxvcGVkLWJ5OiBMb3JyeS5MdW9AbWVkaWF0ZWsuY29tDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IExvcnJ5Lkx1b0BtZWRpYXRlay5jb20NCj4gPiA+ID4gVGVzdGVkLWJ5OiB3ZWl5YW5neWFuZ0B2
aXZvLmNvbQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiB3ZWl5YW5neWFuZ0B2aXZvLmNvbQ0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBUemUtbmFuIFd1IDxUemUtbmFuLld1QG1lZGlhdGVrLmNvbT4N
Cj4gPiA+ID4gLS0tDQo+ID4gPiA+IFRoZSByZWdyZXNzaW9uIGlzIGZpcnN0IG9ic2VydmVkIGJ5
IHd5eSBpbiB0aGUgVXBkYXRlIEVuZ2luZQ0KPiA+ID4gPiBzY2VuYXJpbw0KPiA+ID4gPiB3aXRo
wqAgQ09ORklHX0xBWllfUkNVIGVuYWJsZWQuIHRoZXJlIGlzIGFuIGFkZGl0aW9uYWwgZGVsYXkg
b2YNCj4gPiA+ID4gNOKAkzUNCj4gPiA+ID4gc2Vjb25kcyBkdXJpbmcgdGhlIGhlYXZ5IGlvY3Rs
IEFQSSBjYWxsLCB3YWl0aW5nIGZvcg0KPiA+ID4gPiBwZXJjcHVfcmVmX3N3aXRjaF90b19hdG9t
aWNfcmN1IChSQ1UgaHVycnkgQ0IpIHRvIGNvbXBsZXRlLg0KPiA+ID4gPiANCj4gPiA+ID4gSW5p
dGlhbGx5LCB3ZSBzdXNwZWN0ZWQgdGhhdCB0aGUNCj4gPiA+ID4gcGVyY3B1X3JlZl9zd2l0Y2hf
dG9fYXRvbWljX3JjdQ0KPiA+ID4gPiBmdW5jdGlvbiBpdHNlbGYgd2FzIHRha2luZyB0b28gbG9u
Zy4gSG93ZXZlciwgYWZ0ZXIgZW5hYmxpbmcNCj4gPiA+ID4gc29tZQ0KPiA+ID4gPiBjdXN0b21l
IGFuZCB0aGUgZm9sbG93aW5nIHRyYWNlIGV2ZW50czogcmN1X2RvX2JhdGNoLA0KPiA+ID4gPiBy
Y3Vfbm9jYl93YWtlLCBhbmQNCj4gPiA+ID4gcmN1X2dyYWNlX3BlcmlvZC4gd2UgZm91bmQgdGhh
dCB0aGUgcm9vdCBjYXVzZSB3YXMgdGhhdCByY3VvZw0KPiA+ID4gPiB3YXMNCj4gPiA+ID4gbm90
DQo+ID4gPiA+IGJlaW5nIHdva2VuIHVwIGluIHRpbWUgdG8gcmVxdWVzdCBhIG5ldyBHUC4gVGhp
cyBsZWQgdG8gdGhlDQo+ID4gPiA+IGRlbGF5DQo+ID4gPiA+IGluDQo+ID4gPiA+IGludm9raW5n
IHRoZSBodXJyeSBSQ1UgY2FsbGJhY2sNCj4gPiA+ID4gKHBlcmNwdV9yZWZfc3dpdGNoX3RvX2F0
b21pY19yY3UpLg0KPiA+ID4gPiANCj4gPiA+ID4gRW52aXJvbm1lbnQ6DQo+ID4gPiA+IMKgIEFu
ZHJvaWQtMTYsIEtlcm5lbDogNi4xMiwgOCBDUFVzIChBUk0pDQo+ID4gPiA+IA0KPiA+ID4gPiBD
b25maWd1cmF0aW9uOg0KPiA+ID4gPiDCoCBDT05GSUdfVFJFRV9SQ1U9eQ0KPiA+ID4gPiDCoCBD
T05GSUdfUFJFRU1QVF9SQ1U9eQ0KPiA+ID4gPiDCoCBDT05GSUdfTEFaWV9SQ1U9eQ0KPiA+ID4g
PiDCoCBDT05GSUdfUkNVX05PQ0JfQ1BVPXkNCj4gPiA+ID4gwqAgQ09ORklHX1JDVV9OT0NCX0NQ
VV9ERUZBVUxUX0FMTD15DQo+ID4gPiA+IMKgIHJjdV9ub2NiX2dwX3N0cmlkZSA9IC0xIChkZWZh
dWx0IGlzIDQgZm9yIDggY29yZXMpDQo+ID4gPiA+IMKgIGppZmZpZXNfbGF6eV9mbHVzaCA9IDEw
ICogSFoNCj4gPiA+ID4gDQo+ID4gPiA+IENvbnRyaWJ1dGlvbnM6DQo+ID4gPiA+IFR6ZS1OYW4g
V3U6DQo+ID4gPiA+IENvbGxhYm9yYXRlZCB3aXRoIENoZW5nLUp1aSB0byBkaXNjdXNzIHdoaWNo
IHRyYWNlcG9pbnRzIG5lZWRlZA0KPiA+ID4gPiB0bw0KPiA+ID4gPiBiZQ0KPiA+ID4gPiBhZGRl
ZCwgam9pbnRseSBhbmFseXplZCB0aGUgdHJhY2UgbG9ncywgaWRlbnRpZmllZCB0aGUgcm9vdA0K
PiA+ID4gPiBjYXVzZSwNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IHByb3Bvc2VkIHRoaXMgdXBzdHJl
YW0gY2hhbmdlLg0KPiA+ID4gPiANCj4gPiA+ID4gQ2hlbmctSnVpIFdhbmc6DQo+ID4gPiA+IFBy
b3ZpZGVkIG1hbnkgdmFsdWFibGUgc3VnZ2VzdGlvbnMgZHVyaW5nIHRoZSBkZWJ1Z2dpbmcNCj4g
PiA+ID4gcHJvY2VzcywNCj4gPiA+ID4gcmVwZWF0ZWRseSBmb3VuZCBicmVha3Rocm91Z2hzIHdo
ZW4gd2Ugd2VyZSBzdHVjaywgYW5kIGhlbHBlZA0KPiA+ID4gPiBpZGVudGlmeQ0KPiA+ID4gPiB0
aGUgcm9vdCBjYXVzZS4NCj4gPiA+ID4gDQo+ID4gPiA+IExvcnJ5IEx1bzoNCj4gPiA+ID4gQXNz
aXN0ZWQgaW4gdmVyaWZ5aW5nIHdoZXRoZXIgcmN1LWh1cnJ5LWNhbGxiYWNrIHdhcyBleGVjdXRl
ZA0KPiA+ID4gPiB0b28NCj4gPiA+ID4gbG9uZw0KPiA+ID4gPiBvciBkZWZlcnJlZCwgc3VwcG9y
dGVkIHdpdGggdGVzdGluZywgYW5kIGhlbHBlZCB3aXRoDQo+ID4gPiA+IGNvbW11bmljYXRpb24u
DQo+ID4gPiA+IA0KPiA+ID4gPiBXZWl5YW5neWFuZzoNCj4gPiA+ID4gTWFpbiB0ZXN0ZXIgd2hv
IGRpc2NvdmVyZWQgdGhlIHJlZ3Jlc3Npb24gc2NlbmFyaW8sIGNvbmZpcm1lZA0KPiA+ID4gPiB0
aGF0DQo+ID4gPiA+IGVuYWJsaW5nIENPTkZJR19MQVpZX1JDVSBjYXVzZWQgdGhlIHJlZ3Jlc3Np
b24sIGFuZCB2ZXJpZmllZA0KPiA+ID4gPiB0aGF0DQo+ID4gPiA+IHRoaXMNCj4gPiA+ID4gcGF0
Y2ggcmVzb2x2ZXMgdGhlIGlzc3VlDQo+ID4gPiANCj4gPiA+IE5pY2UgdGVhbSB3b3JrIDotKQ0K
PiA+ID4gDQo+ID4gVGhhbmtzIDopDQo+ID4gPiA+IA0KPiA+ID4gPiBOb3RlOg0KPiA+ID4gPiBX
aXRoIG15IGxpbWl0ZWQgdW5kZXJzdGFuZGluZyBvZiBsYXp5IFJDVSwgSSBhbSBub3QgZnVsbHkN
Cj4gPiA+ID4gY29uZmlkZW50DQo+ID4gPiA+IHRoYXQNCj4gPiA+ID4gdGhpcyBpcyBhIHJlYWwg
aXNzdWUuIEluIG15IG9waW5pb24sIGh1cnJ5IGNhbGxiYWNrcyBzaG91bGQgbm90DQo+ID4gPiA+
IGJlDQo+ID4gPiA+IGRlbGF5ZWQgYnkgb3RoZXIgZXZlbnRzIHN1Y2ggYXMgZmlyc3RCUSB0cmFj
ZSBldmVudC4NCj4gPiA+ID4gSWYgbXkgdW5kZXJzdGFuZGluZyBpcyBpbmNvcnJlY3QsIEkgd291
bGQgZ3JlYXRseSBhcHByZWNpYXRlDQo+ID4gPiA+IGFueQ0KPiA+ID4gPiBndWlkYW5jZSBvciBj
bGFyaWZpY2F0aW9uIGZyb20gdGhlIG1haW50YWluZXJzLg0KPiA+ID4gDQo+ID4gPiBZb3VyIHVu
ZGVyc3RhbmRpbmcgbG9va3MgcXVpdGUgcmlnaHQhDQo+ID4gPiANCj4gPiBHbGFkIHRvIGtub3cg
SSB3YXMgb24gdGhlIHJpZ2h0IHRyYWNrLg0KPiA+IA0KPiA+ID4gUmV2aWV3ZWQtYnk6IEZyZWRl
cmljIFdlaXNiZWNrZXIgPGZyZWRlcmljQGtlcm5lbC5vcmc+DQo+ID4gPiANCj4gPiA+IFNpbmNl
IHRoZSBpc3N1ZSBpcyB0aGVyZSBmb3IgMyB5ZWFycyBub3cgYW5kIHdhcyBpbnRyb2R1Y2VkIHdp
dGgNCj4gPiA+IHRoZSBDT05GSUdfTEFaWV9SQ1UgbmV3IGZlYXR1cmUsIGl0IGNhbiBwcm9iYWJs
eSB3YWl0IGEgZmV3IHdlZWtzDQo+ID4gPiBmb3IgdGhlIG5leHQgbWVyZ2Ugd2luZG93Lg0KPiAN
Cj4gDQo+IE5pY2UsIHRoYW5rcyENCj4gDQo+IFJldmlld2VkLWJ5OiBKb2VsIEZlcm5hbmRlcyA8
am9lbGFnbmVsZkBudmlkaWEuY29tPg0KPiANCj4gSSBzdWdnZXN0IGxldCB1cyBhZGQgdGhlIEZp
eGVzIHRhZyB0b28gc28gdGhhdCBzdGFibGUgZ2V0cyBpdC4NCj4gDQo+IHRoYW5rcywNCj4gDQo+
IMKgLSBKb2VsDQo+IA0KDQpJIG5vdGljZWQgdGhhdCBJ4oCZdmUgYWxyZWFkeSBhZGRlZCB0aGUg
RklYRVM6IHRhZywgZGlkIHlvdSBtZWFuIHRoYXQgd2UNCnNob3VsZCBhbHNvIGFkZCB0aGlzIGxp
bmUgIkNDOnN0YWJsZUB2Z2VyLmtlcm5lbC5vcmciID8NCg0KSWYgdGhhdOKAmXMgdGhlIGNhc2Us
IHNob3VsZCBJIHN1Ym1pdCBhIG5ldyB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2goVjIpPw0KDQp0aGFu
a3MsDQotLQ0KVHplLU5hbiBXdQ0KDQo=
