Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411EF1B040B;
	Wed, 26 Mar 2025 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028980; cv=fail; b=MtWiwfoRvfEAVyk8uGJ4+iWeM/bq4Q60nFaGTWjQb9yPXuO3Xyinn01+drZkN/eQlsFAhPxZsHtQg0gDQATj8MkC/EtMhjj6F8LSVT6zJ0GESHMBjHrKY2qqrwWn7MRfxF9wDpK/bIab/wxAyQ0qVe8Jp3dIjg0uKjs2Ttjb608=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028980; c=relaxed/simple;
	bh=nQgAWNb55dI9ViAmxLyc0bUI6zjxF9sxekSRwgDBF1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V2MH5WAMAU2vvZgqsDhPpehaF7T2dq3hLLOcpDPdB7MvqR5SssINHlOtn5pM/E+tPjjxSoroQNl1i5vg3Z3tckMgrumAX6uQQyQj1lE7I0MWWu6qHVArZgX1S8jah8sHIe1RLJHXJnqHBrR4uMFzcS3bLPIutQwk2iWKkLazYJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T7EoXIpt; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T7EoXIpt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Di9cBcihkVuQaT9E6iEy0aYhcgQfhTj807RzO/caPa73E/O+lMHVmvRgL8QJkW2lAP5aBqMm7B8eQYC8yFWC5K5IpCCmsNLiS0h5ZQwzLIaJJUAsE66h6Zwg+nyt5/vmwk7su/NDYA3Wxnce4UKVeFk/eq8JxDwBHgByX21yzvDXUWaG4jTX+MGh6DxRdoTuXIr7Oqk5kzJ6F3UI0mC08kdezUjFKv99KzGThjwjO4Zz5RAbhOTkt1EO8zdwIjtjE8xRTe+anf9Nsviwx1Z4+8yOjK3pqNIFJ8b4Dh4mZhMtDacSqm8itzfDtxgzLjczk+ubyeBi9XT0RHsBMH6SaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQgAWNb55dI9ViAmxLyc0bUI6zjxF9sxekSRwgDBF1c=;
 b=Z04k8TJg3sLW47NMnfiDD3j0nB4nxui113C+pYaIEGF/wBjKYnFyYsfvhDyDTA3/Xoebw9wtwjZ3vveX73AjiScMnPkBVxuAvJRE6NX7zd3bqtsEjfRAV/IYUDXV3MZ5JgAb75HCV2qFZEp9dr6fej8fu5hv3Hn7dOO6KUGRLn9nPVqs+Dh2pAyrwH9TqqztaKdmDcMFiyRTrLRkSY0B1gW+zhRTwXFs6wiO6LZ/QEhwXj9AU5ZdYwrcE7teXWboMKKQfEfv/acDq3QNYqaPpqBPqtSV/079axDfspi5AC7atZ8O0Ya+Gs7O+Wd47PjtMCxKyCgOf5sggrkzbHfqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQgAWNb55dI9ViAmxLyc0bUI6zjxF9sxekSRwgDBF1c=;
 b=T7EoXIptazEFPm7E4WjlRxbSvIhbqSbgfQqmLLs9KoCWDjrMenmBhKcJgZCWr85ULWwC7cLkIYhMzUUjDmXfxxdALVUtubzCgUl2iFkPUgfU/jZW3AQypHebBGqOLrQWYEiquGIPgGkfsyxms2mnuvxSxIprRVDkFoY0V9u9V1VaWKGtdp1bh1KiAQiJZl2QMqMeUUI03kqNU6aVRdgQ5vW6U92FKqf0+JkFLF7m8l7OpkUZD/0plPm6or1IvymKsp7OEX6NgDm40mrr/iBvNIHDsVxM/ENGwbBnv+8jPQax+Po+hNEmvcXObM9jHhKD6cfRtXSABnhRWcR6gCS/ug==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 22:42:52 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 22:42:52 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
	<neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/3] rcu: Replace magic number with meaningful constant in
 rcu_seq_done_exact()
Thread-Topic: [PATCH 1/3] rcu: Replace magic number with meaningful constant
 in rcu_seq_done_exact()
Thread-Index: AQHbnN563M6fOz6TlUSdJJCJAFHwmbOGBGuAgAACqTI=
Date: Wed, 26 Mar 2025 22:42:52 +0000
Message-ID: <DDDD275D-1017-4189-9A8A-578021A33B4A@nvidia.com>
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-2-joelagnelf@nvidia.com>
 <eeda52c2-5397-4aad-ad01-ca04e5b0b80f@paulmck-laptop>
In-Reply-To: <eeda52c2-5397-4aad-ad01-ca04e5b0b80f@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|SA1PR12MB7101:EE_
x-ms-office365-filtering-correlation-id: 3d69c0ca-f5b8-4a38-fd9e-08dd6cb78b25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1hNS0U5YnZvMGpoTUtkMTYyb0F4TCtkNjVxVFpBVkQ2ODE0ekpPRmdrU05T?=
 =?utf-8?B?TmdXVG9XeEtGSjVnS0pNVUhldFlOL0tMbUNZTmhIRm5hdGRqVDVsbGl6R28x?=
 =?utf-8?B?bFYvUWhIdUhJODB6SDd4QnNmV29NMnlNeVlQMU9lUWdoNGwxNkJTRnhtNEhY?=
 =?utf-8?B?OVlXeE1qelNCVHBSdU4wOGVCZ3hCelNyb0FzbXJwcnFmVzZDdnFMb2VMK0Y0?=
 =?utf-8?B?WG1tMi9hMjlHU3lQZ0ZCWVB1WWs1VVdxOXdUQmVqRDJaaFZNWXp2RkI3bmhL?=
 =?utf-8?B?ZjM5NDg3M1RLRXYrNXlaeVJkTkE5Z2ZLN1h2WEFWUVlOM1NEVUlwbjE3L0VX?=
 =?utf-8?B?Q051V25CdFhKMld1MXJGcFhBV2RybXVrVGZSVVRxQzN4OTVuRVFoMG91dGZO?=
 =?utf-8?B?dWFsNnpTMUlKdHpndTU1NEdHK2lXMmdtbEQ5NitoSkFSL3Bkb0JmYUNFcUt3?=
 =?utf-8?B?YVpCYnJxOE9jRGhyRnJNWWc5cTRneW5UaURPZ2g0eHAvcTJoQkRyNVRDMnVK?=
 =?utf-8?B?UTBObnJDNlVyNWFzN1BNeFA5WFRjd1hyRFhFM2RpNnR2TW5ZQkFTYVlHQ3Jk?=
 =?utf-8?B?dDRIcVBnT1ZSRHFrTzgxSU9SUXVBNm1MdlZsVnJEOGZWNE9kVTlrbHFKcVYr?=
 =?utf-8?B?S21Xc2hiWWpmeVBvU295MnJlaDRtaDdsVjVTZ1hkSXNGV2VDcTMzRnRQRFYy?=
 =?utf-8?B?ZHJmaHhvWUNtYlY0aGF4VGxocVAxa2E4MGd0RnRtU2gvMnB0aTd4NlU3d0xq?=
 =?utf-8?B?VURkSDhzakdXMHRYUlM1cExCVk5DbGhvaEpmUjN0OGZhN25QRk9rdmRPeWIx?=
 =?utf-8?B?RWZNQlAzTXBTQW9sdTlUTjZMcEhWSDZOU25TU0NIeENqSWUxZHZlaWZBS0F2?=
 =?utf-8?B?WjZabFl3Rmt3OHh0alNzMjFJRTVOMy9SenB0c0NyQStpTndvNjE1bjlaWFRI?=
 =?utf-8?B?VmtBbTBLRnFuZ05LbjdzTFJaSCsvZVhNTlZXQnpLdzkreFIvMVB4NEZsMnlP?=
 =?utf-8?B?SHBDdjV2ckdTYmdHZlJCdXBlWEVZT0wycVAyQTRyTE5SS3BIODB0Qk13OW5l?=
 =?utf-8?B?blh2SWFzVktRNHJTTGp2Y1JmN3prZ0E2TEJGUG1KYlpDeVJzZzVrcDhDRDZ5?=
 =?utf-8?B?WW9YeU9acWwwdjg1NkFHS0JyS1gybVd1ekMyNHdyZE5LcDBpbWZ4Y05zTCto?=
 =?utf-8?B?bFZKMm5LdE5rc0c1UHJKZ29ZYWh3bUQxSUpGcFU1am1yd2Z0RWRVeEhLOGR0?=
 =?utf-8?B?aGVMcHhPSmlPZVRTWVVxaTZ4MXNRM1N0UkhrbXc5UGYzV2ZkajZTc09qSnRV?=
 =?utf-8?B?VXBaME03MVlNWS9TTloyNVFwci96ejBCRDYzb3pFTFVFSHRlN1N0aDNHTE9Q?=
 =?utf-8?B?UEVnK1hYZjhhcURpa0RwMmpXeDdWcCt5UkM2dDdJZE9TYnpkb2FobmN3Yk5S?=
 =?utf-8?B?VkR0WFNaajNPaHowL3ZTY1NFWit4MmdVemdwVEh3VElwc1RJVjRPenRJcG9t?=
 =?utf-8?B?RkxnL05EM3JvNmo5cDNhWURWc3g1RjBpUXdVZmc1ckpIdkQ5TWdqdUlXRG03?=
 =?utf-8?B?R2MvczZhemlOQ2x5bzY2czFqWGlHT292cW9odTRvaW5UMHAvTXRsRzY3N2p6?=
 =?utf-8?B?Um92b3hJQTV2cEpMZXdOUGNKbkM4Vy9EMkx1dWMyN0NKaDlnNXBlbTV2b3J6?=
 =?utf-8?B?SGljWHFJdkxPN0JKSWV6VVlOTXRzMDJqa2FiQXBPUlFZQ2owbHlyMXRVQUJq?=
 =?utf-8?B?U1J3N282WnBGbGtBK08xZ0hJUDJ6WEJoYzhJK3EvQ3hIS3NwcVJ1TnRXWlJO?=
 =?utf-8?B?ajZhaWVLWjVKTlNCT2M3eEI5MkE5eFZXWUpHY2lDb0hvSUJ3dHpxYlhEYzVQ?=
 =?utf-8?B?OVpCZFBQY0RWR3p0T2dzSkJxRlB6YVg2SmE3NWErWCtnKy9rcmJwQXk1bHk0?=
 =?utf-8?B?bWNxcVM2WllvVUQvaVZ4MHZHdjJxUzV3ak5YamVISXFGNzZoVGhYUlJVLysy?=
 =?utf-8?Q?DJdumCahdaMSabW54q89irvPu60Yr4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWJRMnpGbm5OaTdVSzNnWlFNZDhWMEZUZnhQb0p2Z0ZGNnVqbFhwbFQ1bkVW?=
 =?utf-8?B?S05VcUhnMXBYZGU1eDhQYkFlem5pSG5xSzFJWkh6c2JxVUM1OGxWVUFPZmdE?=
 =?utf-8?B?MkZoQ25kcFI0RVMwUzVsQ2tCSkZOV053cEp3MkgxUUtJUmlqd1U5ckdYUWh4?=
 =?utf-8?B?c0swTzd0NHByMDkvOGYxNVJIN3JmSWd3OUxsa3V4ZGt5emcxTmQ2bld1OHZh?=
 =?utf-8?B?dU1CUys2WmNDUkNiRTdEVEtDcnVQci9UNlpkaU9wQWFMNG9wSi9KeUNMdmJk?=
 =?utf-8?B?N1ZIMHRUV2E0bkdKdG1JMW8zYmNNQXVTdlFGWWpoWGJUUHBwQ09Kd3RDUkQy?=
 =?utf-8?B?VnF5djhQUUNRUEE5VmxhMndxNXN5UnNZQ0xBQlUxT2c4TGx2SU40WTFpckhN?=
 =?utf-8?B?bE5uUVY2U0ZCNDIyYllTL2FTTnFRcVp6a2YvdGV0Z2ZOeEVDRjltTDN3NVQ3?=
 =?utf-8?B?b2NWLzV4UnNzcjF1S3ZLaHBwNUdEY0ZtSW40N0hkcWhYQjE2bmVCQXlnOEhP?=
 =?utf-8?B?cTFVaTNsamhIS1RyU1RWaWV4YjVzRjRhRktiRjkrWUlvNDlsVi9DQmFjeStm?=
 =?utf-8?B?bGRucTFaREhWR2QzZ1BMS3VqRE90djltbmJaVEc4Y0lkZGJnb2JMdUQ5dHVp?=
 =?utf-8?B?ek8zWUtlMnltZnNJK2cwZHIvamRpNnlZVTBwcXlUL2U2WVdtZ1lWSXVHRFBY?=
 =?utf-8?B?YmtrTzlVZEM4eHFzY0xEU1J6aGNHaitnMEtKRmVSRjRXMGNBdDEwVHZiVS9U?=
 =?utf-8?B?YTVNNDMyMjdOVm9qRnJrcmZuOVFrcUxvdDllb21xcWdhMi9xSFd3TXRjTHVH?=
 =?utf-8?B?QnpnMllzeXNKa3FETlRHaGt2dE1sV3A3UzFuYlQzaGR6TngyWTg5RVhrMi84?=
 =?utf-8?B?MzRWRFhhc3Y3KzFleTFheTQyS3lRSXpVMXVYa1FHVGxUaWpkbTNXQWJ3WUs5?=
 =?utf-8?B?WWl0cHhtT3dTMVhBMlQ4dDJzbUdIY21zb2lsRWhINlVMVVhVc0ZzOVNWL0lF?=
 =?utf-8?B?NnNQY2V2am9OZHhhUzZzRmdCMEJYUGJLQ29CMnhTY3grYVpJUWtIN3h4QlJX?=
 =?utf-8?B?ajZySENNZk1yRXpjcnBYV3JyTnN0NmdQaU1aell4MGhtNkNlVGU4T0lkWHlE?=
 =?utf-8?B?dUV0YWZFaGd0VWdSbTZaSFBKM3Y1b2p6ZGJrbzFEUld6SEMvY081NGtWczdm?=
 =?utf-8?B?aGwxVVBQamdQMThoZmVoRmJWcG11c0YvTitDT0JQUlMzTXdtUWtIU3NBSnRy?=
 =?utf-8?B?c2dIeG1XdDdna284MEZlSVU0MTV0dmtXQ1RPTzZEZzhtNDBWTWZ2dlJtTE9G?=
 =?utf-8?B?MnNZNFF3YktPOFZUR2VUcmlYVnVmTlZJNy9NMmF5OXNrNUJuditwbHozeUlU?=
 =?utf-8?B?anhJcVErekFla01zZVpNd2pKa1lBWEhqcTZnZGs1Qk5ES3lVUVBldzcrWUY1?=
 =?utf-8?B?TE5saDl0N0ZKb0diMGhzZ004WGFSUXY4YVhxR2c4MDVCbEtGaDN5b21PVnpV?=
 =?utf-8?B?dUJOR0N1Z3lrY1VaTzhQVXF0UlZVMzAwZ291SThTU29LT01jcGd3eGNNeFNS?=
 =?utf-8?B?TENNdjRYV0p3WmpGbGlMNVhSQnpvM0E1YWF1UTV3SE85UnhRc1pHdnRRbDdy?=
 =?utf-8?B?OFgyQ0V5c2cyRklJZ1lvZi8wWWNDUktySHlzWEN2Mk9JdHk4TnJBbzA4N21o?=
 =?utf-8?B?dmJIa1RZL1FTNEt3L2YydHU2WndsY0d1KytjWjU0RWNIVlVJY1VuU3Nrb21Z?=
 =?utf-8?B?ZHZqWXprVDl5am1SSkhhenhJTUNLenh4Z1JETXgzeFN6eEd6OGIzY2N1dVVU?=
 =?utf-8?B?VGhMNzlqZWJQT3QzTUFMZG1qYmNFNEdWL2h5V1o1Y3hRY1h4WWZzN0pFZ0tW?=
 =?utf-8?B?TWFWcHoyOGxielkrUlV5Z2dzcm9vZmQ1aGhmMWZLSTlqUnRnRlZZQWdSU1pX?=
 =?utf-8?B?WUVVT0kyV1ZuMENPdTFjZFlLcjZLb1lOZXRiaDZwdDl6cE1aY0hGVUY5aC9q?=
 =?utf-8?B?S1NaOGhFRitrS29qbjJESzBmMFRrR2diSXdueThOQUtpVDdVUFdYV1E5L3Yz?=
 =?utf-8?B?TmF6UkpnQzhVTFlSVjJycW9Rd3FDajNjZERoeldIcllpME5SQ2JWQStDbnU2?=
 =?utf-8?Q?GGo0XuIx4GIyvX+GEX18aDkWQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d69c0ca-f5b8-4a38-fd9e-08dd6cb78b25
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 22:42:52.4746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdvwhv8AGr9wpxwyItOSNgiGWfZ4olQjeUdYu6cq284w2XX60w5bseP4aLcJLk2mbwz0E+A9fwhjKeThFj52bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101

DQoNCj4gT24gTWFyIDI2LCAyMDI1LCBhdCA2OjMz4oCvUE0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIE1hciAyNCwgMjAyNSBh
dCAwMTowMTo1M1BNIC0wNDAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IFRoZSByY3Vfc2Vx
X2RvbmVfZXhhY3QoKSBmdW5jdGlvbiBjaGVja3MgaWYgYSBncmFjZSBwZXJpb2QgaGFzIGNvbXBs
ZXRlZCBieQ0KPj4gY29tcGFyaW5nIHNlcXVlbmNlIG51bWJlcnMuIEl0IGluY2x1ZGVzIGEgZ3Vh
cmQgYmFuZCB0byBoYW5kbGUgc2VxdWVuY2UgbnVtYmVyDQo+PiB3cmFwYXJvdW5kLCB3aGljaCB3
YXMgcHJldmlvdXNseSBleHByZXNzZWQgdXNpbmcgdGhlIG1hZ2ljIG51bWJlciBjYWxjdWxhdGlv
bg0KPj4gJzMgKiBSQ1VfU0VRX1NUQVRFX01BU0sgKyAxJy4NCj4+IA0KPj4gVGhpcyBtYWdpYyBu
dW1iZXIgaXMgbm90IGltbWVkaWF0ZWx5IG9idmlvdXMgaW4gdGVybXMgb2Ygd2hhdCBpdCByZXBy
ZXNlbnRzLg0KPj4gDQo+PiBJbnN0ZWFkLCB0aGUgcmVhc29uIHdlIG5lZWQgdGhpcyB0aW55IGd1
YXJkYmFuZCBpcyBiZWNhdXNlIG9mIHRoZSBsYWcgYmV0d2Vlbg0KPj4gdGhlIHNldHRpbmcgb2Yg
cmN1X3N0YXRlLmdwX3NlcV9wb2xsZWQgYW5kIHJvb3Qgcm5wJ3MgZ3Bfc2VxIGluIHJjdV9ncF9p
bml0KCkuDQo+PiANCj4+IFRoaXMgZ3VhcmRiYW5kIG5lZWRzIHRvIGJlIGF0IGxlYXN0IDIgR1Bz
IHdvcnRoIG9mIGNvdW50cywgdG8gYXZvaWQgcmVjb2duaXppbmcNCj4+IHRoZSBuZXdseSBzdGFy
dGVkIEdQIGFzIGNvbXBsZXRlZCBpbW1lZGlhdGVseSwgZHVlIHRvIHRoZSBmb2xsb3dpbmcgc2Vx
dWVuY2UNCj4+IHdoaWNoIGFyaXNlcyBkdWUgdG8gdGhlIGRlbGF5IGJldHdlZW4gdXBkYXRlIG9m
IHJjdV9zdGF0ZS5ncF9zZXFfcG9sbGVkIGFuZA0KPj4gcm9vdCBybnAncyBncF9zZXE6DQo+PiAN
Cj4+IHJucC0+Z3Bfc2VxID0gcmN1X3N0YXRlLmdwX3NlcSA9IDANCj4+IA0KPj4gICAgQ1BVIDAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BVIDENCj4+ICAgIC0t
LS0tICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tLS0tDQo+PiAg
ICAvLyByY3Vfc3RhdGUuZ3Bfc2VxID0gMQ0KPj4gICAgcmN1X3NlcV9zdGFydCgmcmN1X3N0YXRl
LmdwX3NlcSkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC8vIHNuYXAgPSA4DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzbmFwID0gcmN1X3NlcV9zbmFwKCZyY3Vfc3RhdGUuZ3Bfc2VxKQ0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8g
VHdvIGZ1bGwgR1AgZGlmZmVyZW5jZXMNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJjdV9zZXFfZG9uZV9leGFjdCgmcm5wLT5ncF9zZXEsIHNu
YXApDQo+PiAgICAvLyBybnAtPmdwX3NlcSA9IDENCj4+ICAgIFdSSVRFX09OQ0Uocm5wLT5ncF9z
ZXEsIHJjdV9zdGF0ZS5ncF9zZXEpOw0KPj4gDQo+PiBUaGlzIGNhbiBoYXBwZW4gZHVlIHRvIGdl
dF9zdGF0ZV9zeW5jaHJvbml6ZV9yY3VfZnVsbCgpIHNhbXBsaW5nDQo+PiByY3Vfc3RhdGUuZ3Bf
c2VxX3BvbGxlZCwgaG93ZXZlciB0aGUgcG9sbF9zdGF0ZV9zeW5jaHJvbml6ZV9yY3VfZnVsbCgp
DQo+PiBzYW1wbGluZyB0aGUgcm9vdCBybnAncyBncF9zZXEuIFRoZSBkZWxheSBiZXR3ZWVuIHRo
ZSB1cGRhdGUgb2YgdGhlIDINCj4+IGNvdW50ZXJzIG9jY3VycyBpbiByY3VfZ3BfaW5pdCgpIGR1
cmluZyB3aGljaCB0aGUgY291bnRlcnMgYnJpZWZseSBnbw0KPj4gb3V0IG9mIHN5bmMuDQo+PiAN
Cj4+IE1ha2UgdGhlIGd1YXJkYmFuZCBleHBsaWN0bHkgMiBHUHMuIFRoaXMgaW1wcm92ZXMgY29k
ZSByZWFkYWJpbGl0eSBhbmQNCj4+IG1haW50YWluYWJpbGl0eSBieSBtYWtpbmcgdGhlIGludGVu
dCBjbGVhcmVyIGFzIHdlbGwuDQo+PiANCj4+IFN1Z2dlc3RlZC1ieTogRnJlZGVyaWMgV2Vpc2Jl
Y2tlciA8ZnJlZGVyaWNAa2VybmVsLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvZWwgRmVybmFu
ZGVzIDxqb2VsYWduZWxmQG52aWRpYS5jb20+DQo+IA0KPiBPbmUgY29uY2VybiBpcyB0aGF0IGEg
c21hbGwgZXJyb3IgYW55d2hlcmUgaW4gdGhlIGNvZGUgY291bGQgY2F1c2UgdGhpcw0KPiBtaW5p
bWFsIGd1YXJkIGJhbmQgdG8gYmUgdG9vIHNtYWxsLiAgVGhpcyBpcyBub3QgYSBwcm9ibGVtIGZv
ciBzb21lDQo+IHVzZSBjYXNlcyAocmN1X2JhcnJpZXIoKSBqdXN0IGRvZXMgYW4gZXh0cmEgb3Bl
cmF0aW9uLCBhbmQgbm9ybWFsIGdyYWNlDQo+IHBlcmlvZHMgYXJlIHByb3RlY3RlZCBmcm9tIGZv
cmV2ZXItaWRsZSBDUFVzIGJ5IC0+Z3B3cmFwKSwgYnV0IGNvdWxkIGJlDQo+IGFuIGlzc3VlIG9u
IDMyLWJpdCBzeXN0ZW1zIGZvciB1c2VyIG9mIHBvbGxlZCBSQ1UgZ3JhY2UgcGVyaW9kcy4NCg0K
Q291bGQgeW91IHByb3ZpZGUgbW9yZSBkZXRhaWxzIG9mIHRoZSB1c2VjYXNlIChzZXF1ZW5jZSBv
ZiBzdGVwcykgY2F1c2luZyBhbiBpc3N1ZSBmb3IgMzIgYml0IHBvbGxlZCBSQ1UgdXNlcnM/IEkg
YW0gbm90IGFibGUgdG8gc2VlIGhvdyB0aGlzIHBhdGNoIGNhbiBhZmZlY3QgdGhlbS4NCg0KPiAN
Cj4gSW4gY29udHJhc3QsIG1ha2luZyB0aGUgZ3VhcmQgYmFuZCBhIGJpdCBsb25nZXIgdGhhbiBp
dCBuZWVkcyB0byBiZQ0KPiBoYXMgbGl0dGxlIG9yIG5vIGRvd25zaWRlLg0KDQpNYWtpbmcgaXQg
MyBHUCBpbnN0ZWFkIG9mIDIgc2hvdWxkIGJlIG9rIHdpdGggbWUgYXMgbG9uZyBhcyB3ZSBkb2N1
bWVudCBpdCBidXQgYXQgbGVhc3QgaXQgd2lsbCBub3QgYmUgYSBtYWdpYyBudW1iZXIgYmFzZWQg
b24gYW4gZXF1YXRpb24uIEkgZmVlbCB3ZSBzaG91bGQgbm90IHB1dCByYW5kb20gbWFnaWMgbnVt
YmVycyB3aGljaCBpcyBtb3JlIGRhbmdlcm91cyBzaW5jZSBpdCBpcyBoYXJkIHRvIGV4cGxhaW4g
KGFuZCBoZW5jZSBkZWJ1ZyDigJQganVzdCBteSAyIGNlbnRzKS4NCg0KVGhhbmtzLg0KDQo+IA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBUaGFueCwgUGF1bA0KPiANCj4+IC0tLQ0KPj4g
a2VybmVsL3JjdS9yY3UuaCB8IDUgKysrKy0NCj4+IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvcmN1
LmggYi9rZXJuZWwvcmN1L3JjdS5oDQo+PiBpbmRleCBlZWQyOTUxYTQ5NjIuLjVlMWVlNTcwYmIy
NyAxMDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9yY3UvcmN1LmgNCj4+ICsrKyBiL2tlcm5lbC9yY3Uv
cmN1LmgNCj4+IEBAIC01Nyw2ICs1Nyw5IEBADQo+PiAvKiBMb3ctb3JkZXIgYml0IGRlZmluaXRp
b24gZm9yIHBvbGxlZCBncmFjZS1wZXJpb2QgQVBJcy4gKi8NCj4+ICNkZWZpbmUgUkNVX0dFVF9T
VEFURV9DT01QTEVURUQgICAgMHgxDQo+PiANCj4+ICsvKiBBIGNvbXBsZXRlIGdyYWNlIHBlcmlv
ZCBjb3VudCAqLw0KPj4gKyNkZWZpbmUgUkNVX1NFUV9HUCAoUkNVX1NFUV9TVEFURV9NQVNLICsg
MSkNCj4+ICsNCj4+IGV4dGVybiBpbnQgc3lzY3RsX3NjaGVkX3J0X3J1bnRpbWU7DQo+PiANCj4+
IC8qDQo+PiBAQCAtMTYyLDcgKzE2NSw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCByY3Vfc2VxX2Rv
bmVfZXhhY3QodW5zaWduZWQgbG9uZyAqc3AsIHVuc2lnbmVkIGxvbmcgcykNCj4+IHsNCj4+ICAg
IHVuc2lnbmVkIGxvbmcgY3VyX3MgPSBSRUFEX09OQ0UoKnNwKTsNCj4+IA0KPj4gLSAgICByZXR1
cm4gVUxPTkdfQ01QX0dFKGN1cl9zLCBzKSB8fCBVTE9OR19DTVBfTFQoY3VyX3MsIHMgLSAoMyAq
IFJDVV9TRVFfU1RBVEVfTUFTSyArIDEpKTsNCj4+ICsgICAgcmV0dXJuIFVMT05HX0NNUF9HRShj
dXJfcywgcykgfHwgVUxPTkdfQ01QX0xUKGN1cl9zLCBzIC0gKDIgKiBSQ1VfU0VRX0dQKSk7DQo+
PiB9DQo+PiANCj4+IC8qDQo+PiAtLQ0KPj4gMi40My4wDQo+PiANCg==
