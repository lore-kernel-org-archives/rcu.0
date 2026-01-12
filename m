Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BC62C029C;
	Mon, 12 Jan 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234194; cv=fail; b=e5b7X2cE6EAjaUmILN6I5Y8uNAZpc9IRkSxou6RCW0dkxuHxxbjbeVg9aBH9monyz2v/CRi+rXoK7qZMJuVm3zoA/w7K7b0S5jS4zPrblJdZODOzjAVw6kmbXcGufvLiTwoDz/gPCFzvFKT4fVn5NU7V9FZuTHysmz2O48phFno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234194; c=relaxed/simple;
	bh=AF8YfD8UFOEE7AI/5/bQAHSlGfUpHPSlbF7c+MZRD00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=enOyhf7ZcpgMZ6G6KMYmBEJPCm9xwWv6DZM9lrVr20FKVc3Gsh+ntuC9UyEft17aA2fADJ5cQbFEBwvg/OouoRtnBIBOaSoCC1/5vEW27RH5Z5BJhuxjg/bx45fv1KIFvoPN5u9DrNgxz5kULDTzCl+Mqs7lRs+Y1/tLwl4HcP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q7wtFxsY; arc=fail smtp.client-ip=40.93.195.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q7wtFxsY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqnEsdJ4IiB1ADw0OaNHlk3alglTtfI7f/paTALj4H9iKPzdF+0wFtkZZUTtFQkuu5KDwWxGhP1a7FcQgpZPx7FndcIjmwzQkVl3fCwKr/uETZdXRvaLAPmcrD4dgrMYOS18xfN2hlYsm0l4sVenWS4DkUryY2EXyJ8sreoXfcZaXNiH31tRgPLIppmUOHDJ3PsBilb3RR+RwWRT1EGu2JZD11Tn1xxzOphyOIqkwovtVYEur/qInJ/hMTbc0tWsvYiDsEQD0AEuVgnORX0wYfoBUUMjKyw/QDS3A6Th+V6ny9gXPgYvyN63PI5p4JytdC/D3IRMPTRcGuejLS8vHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF8YfD8UFOEE7AI/5/bQAHSlGfUpHPSlbF7c+MZRD00=;
 b=B6tJqvOrWwK3FF6AVtJ5NJtSEXofWIefvj71dwnj4iaF+s5DTvdZMXuvq66ALD2HbXuMo9AS5R0W0yNSjSZ1yeo+xEzLUl7d52TwBvI6wfltaQMnV/29HnAkBBzoY9e1i9L3LBBBQdCaITAeV1fE2Tcz3wy84R+2HliaAkAX/JlZ0l+cL7bEL+lYEM6eqHuya/LaBCHHSEopymtEznh7zsKlH4JVvZUXIU6rzkkAXJBOXkR6mvU2B5nCJvyN0Ih6PysbBLAytX0QGZdCuLxN2RNcslNmdO5D2e8FTaQURmxwBcCChw6cZ8XHa6PpRlnZiY8qMR1ECXKSZbktxBZjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF8YfD8UFOEE7AI/5/bQAHSlGfUpHPSlbF7c+MZRD00=;
 b=q7wtFxsYdaJF1ZzVI9FwGExkiAwmQTAr+brsO9QjPGGfJ7e0ELDs+EX3oBls/7N+U+dulueKlkO3Ggvh6gGrQ5uAw+TqvqPmGF8sM/WtD5sL1QVAbmpjDGr1RHBLJTesiXUExrg7MW7K+QmN0GwptiQK3m1+9f3+bPREL7TQDNBhCF7LxKCSnEQ82iwCwUKjsb5HgmvQIRsEnpmd2f4qeTezdUA+nNiB7MAIKswWwz3vll4pgMjenOrWSjJecE4DzPmGOBwAvKqKjuPhYtVjAglFHbbB1QNmALo3ftD8vn2v5ckw4Yy1ehKzEasyYqLvM5b/ZNtvzG2X28zCYA3e0Q==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 16:09:49 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 16:09:49 +0000
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
Thread-Index: AQHcg6gSQ2wH1CXqL0ua+MpkTxEkB7VOT2cAgAAgEQCAAA83gIAANcGI
Date: Mon, 12 Jan 2026 16:09:49 +0000
Message-ID: <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636> <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan>
In-Reply-To: <aWTvtVGe8un5xtTn@milan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|PH0PR12MB7814:EE_
x-ms-office365-filtering-correlation-id: 2825b028-646d-40e8-0b86-08de51f50318
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0pIQW1USmlLMkpPSXFyaldxeVplOWFXS1orbmhFRzZtTnNXZEpHbWpiOG5m?=
 =?utf-8?B?SWZMN293WlZyWEM2MDNnczluOHNuWkMwUWhJMVBZMDNGaTNFd045WE1BelF3?=
 =?utf-8?B?ZnBUanRIOW9zejExOHFYRzBrRXExQlJ6M0tOdkRPTEdGZ1lRVUpha0I0NS9p?=
 =?utf-8?B?NFdMKy84Y2RlM25Jd2tlSk1kSTU5VVVuZkk4SGNaYUh4K2RObjVDai9MSS8w?=
 =?utf-8?B?SjNUeEhjaXZLYkpRTDlzRytUNjR2ZU1rSmN4YThHcEwzQTVJNXZaNHpVT2E5?=
 =?utf-8?B?YUp3TEhDY3V2aFQxYUVTcmFNZUMyVzdBdnlZZm9KNmQyMERzaElpVXhSNEVt?=
 =?utf-8?B?enBFdm5sMVM3ZnBka2xpWTFod3g2Rysra1RNdDNqOVh2cFhTTzd5djN6bkVD?=
 =?utf-8?B?THBic0tYZlplL0VaUVordVYyYUMvTXJ0eG4yeldoZzg4eGNDbTRrZ09BZHVD?=
 =?utf-8?B?TVZQd01MdVB2ckNVK3ZVT3pyOEg2UnAwd1VnWjljQzVSdGZESExhNStDcmFQ?=
 =?utf-8?B?TkVCMzMzQXQvQU5PQ3ZFYVdLc0V1dEFuYkJrVU4yY3Fncy9VMzFSZ2wwZGtj?=
 =?utf-8?B?K2NYRkorSHJZOGZrb3lVUFRvTkdMS1dHSEsxZ1dxSkN6QUMzZVRFSEhsdVZ6?=
 =?utf-8?B?SzdlRkNrT3NGbno5L2dFbHJnYVlLcmhyekFSZVlRNE1rVjhtdGsyVll4dC9D?=
 =?utf-8?B?YUh6N0ZvUmVWTmx4b1VsSUp5Uk9JaCtUd1ZjSkJTd0xuNWdrcGpHaVVoa29B?=
 =?utf-8?B?TGFheWZvSFRVNWYzOHZTdVk3RnlENGhrTjNudmJ1bFN0Tk9aOEgwM1hVNlM5?=
 =?utf-8?B?Q2JEZ0pkcnRRY21sdndWU3BWckp3K21mbDJJdllSWXhxbUg0Q3ZYdlE4cG9r?=
 =?utf-8?B?MHNrOERoTEU5TVJLVGVxN3ZteUo1YzdUV2dYQXVhWVRWUFlWL3hUb25zT2dW?=
 =?utf-8?B?SFpsNFcxNVNtMkpqYmJNRGlYaVVhWEZacDM5YkVKVUR2MDVIb0tGTkxOdzAx?=
 =?utf-8?B?ZVZaakNhcFF0MzFDZVVOaTEvVSswTGJIZVJqYWtaWWd4blZBbEJqTXJQZ0JG?=
 =?utf-8?B?Q3U1eTdoMng5K0RyK0UzMHVhOGVwcHI4TXFYcFM1T2p4c3hMREp4V3FCMGI2?=
 =?utf-8?B?Rjd3d25lalR0MjRXdmFhdElUR0ZzdWttMWlmOXJwVUNwZktwRUxUaGRvWDZ5?=
 =?utf-8?B?NlJWSFR6eXNPRWJJem4zODhobXQ1RHh3dzFQNTYzdndzNTBrYVpXZFhaV3gr?=
 =?utf-8?B?Z21nRTUydGx2cHN6a0w3YVdkcXduQU4wV1hsUDgxU09VTVh2aFU5YkhXR01r?=
 =?utf-8?B?NS90bS8vMER4N2duUXZFNFFzS1JaUnJneXVGSHV6MWI0ZWt1WmhKd1lLSHh5?=
 =?utf-8?B?eXJxQ0JraWRPNmJjdHB4UzFaQUx3V0IxM2l3TnNIV2c4c2gxblI1ZVhRUzlP?=
 =?utf-8?B?ZHFrQUJMd1ByVTgrNHRUbU1YWmxocythMHBqY2t6MVgzZ3B5Uk80K1ZXMkFj?=
 =?utf-8?B?R1hmUGxVQmJHZVZhT0EzckdNc25sQnAwOC9ZMVYxTXdtQ3RlVVEyUSthSnBk?=
 =?utf-8?B?SzRMamgyR05SSXJFODlxSXJXSDcyTzArME02dHExdTZMZHNjTzhEWG5jVDBW?=
 =?utf-8?B?R0VOOTZqNVQ1OE5raTlETStnbW5mcHo2MUpYVHMvbUJsalJOU0RnZS9lNTlh?=
 =?utf-8?B?NmtYWmp3TVZZOVF3UkRBaWVtandsWW03R2JwV3NVOEVnU0dpQ095NUVia1B1?=
 =?utf-8?B?UHNqb21lQm01S3R4YklrTmdIMnBQWFF0djcvL3FNRmc0ZGZqSEM0dFZTNTh0?=
 =?utf-8?B?bXpMczhVWG1DS0M5Qi9WZ0lndmlmREw0SWxxaXNnZFVDZExhaC92TlR5Znpw?=
 =?utf-8?B?WUpZc1F5cE94MndIVnltc1dFZzg5OWtOSytrdWlqVHo4WEYvWG9XaDI5ZmNP?=
 =?utf-8?B?bkszN2U3YnJXbFRGcktNRkxUVU5DNU5jcldERTQ4VTRMM2h1ZFFMYWMzUzdD?=
 =?utf-8?B?eWpIUmM2QWQ5MkxaMHRpTVlmZDBFRnkwRzBkUVlleFlTLzJhRE1Nb2ZJbjgr?=
 =?utf-8?Q?Ji5v3x?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUdpL2ZzQjFqK240WXlXNDZLUHREZy9BYTF0Mm5ZcENoRUx1ZTZXZktWa3dR?=
 =?utf-8?B?NFZnTXZvVWpXazQzRW8yWDlNQTNZTzlZK0RrVFB5aXdCWUViWEVGN2xoYVlT?=
 =?utf-8?B?U2R3S041RDlhdG5lditMdUN6Q0lXaEUyTGQ0RWtqYjNHamRXOXJBeklYS3F3?=
 =?utf-8?B?M2h5L1lINlZrTFJJTkhIVGIxRzMzSHozVG5NSFI4OFZFQjlpV0w4alk3RTJW?=
 =?utf-8?B?WU0zYmlzcEE4VzFJTVZPc0NXVTF2a2ZRazZTSU9tMG9jU051WlRtZnFtaXdM?=
 =?utf-8?B?djlTa1ptU21jOUx5MXM3ajZMQjBXYSs3YUxIWDhIbTRyQVVtaFNxcXJtSVJl?=
 =?utf-8?B?aUlyYzdPOHZHQXV4SmVLb1hnVGxWejJGd3d2V1puNUhycVRENElwbzk5OXdM?=
 =?utf-8?B?b1picFZOQ1pubERXVWJtU3huVTc0THAwSE9JTWhzUDdsKzZiZnMxZDJhOXky?=
 =?utf-8?B?cG04K0ZYVnJUdHFNRjlZVzk5M3Z6SGZCWExPZ1VVQzJvbGhlNnRzUlNEZG1n?=
 =?utf-8?B?VGpWU0dTalF4Uy9JRjRod01ZQzRQbjlCcU8vZktwc1BHVEFEcXRTY3BWekFy?=
 =?utf-8?B?ekJkNy90eW05d0tCYk5IZ0dsMytNMFp0eWsyWEFIcWMwT00yUEFyUEhETzdl?=
 =?utf-8?B?bVNuUUdTT0hkcDFWNEs3L2JjcWhrM2hXUlNHM3UvVlVIMFdzdVlvaHB0TDhz?=
 =?utf-8?B?SnZYQ2l3elZQZDd3NHZncTd3ZkJlVUIvREptMXI2dVZOaUQxU2cxeW16SEgy?=
 =?utf-8?B?WDFpME9pU1lKOXdORFhXQlRYQlBQZzZiWVhFKzVMTGFSTGxLNzhJU3JUa0RY?=
 =?utf-8?B?M2RsN2cxTXZURTcwaWx5UFBQNHJaRkY5ZHJaZXZubWxhdCtoYU9GR25FZFd6?=
 =?utf-8?B?WGY2ZWppc0s5UUxQdWRrSzI3amljMkxYYUZuaE56aDlQNVpKbkZYQVkyRFlo?=
 =?utf-8?B?OURUTWFRWnh4QjJxS256MTBqdzh1R0ltZ0ovZWtvZ3RTTzQ2UURaQjU4R2Ev?=
 =?utf-8?B?Zmg1T1N5R0I5enlQVzlCNkJnSHBtVFBZaGxSaEUxdWxwdDdyeDRFU25LenNR?=
 =?utf-8?B?ZWpoeFpnbkIzYzBLTEs4SmVUajRvNlFtdUx5QU95TVdpU0J4MnI0cnhhU3dz?=
 =?utf-8?B?amtpbXZPTTJLOXQvd0lLZkVhaFQ3L1VZVkgzMldiQ3FBRGxnMGYralNJOUdN?=
 =?utf-8?B?aU9XbXhmcWVGbjFuVXN3Y09yeEtXeStyRUszMlZWZFNkT0wrZ3hhUFhVMENj?=
 =?utf-8?B?NW8rUTQ2TFh1cy9VRkUwTS81YU10RlllQXVubVRScHhqbzhycUdxaC8vOHZT?=
 =?utf-8?B?RVdxVDBhU1lNM2FXclU1VTBUMXo5cjcrMk0yUmhXQ1BHNGR3WTUxRGc1ZnUr?=
 =?utf-8?B?a09Ld0dzRWZRZkpKRFRnVjY5Ykd0TWZ1enFIejNKcFcyTjVLL3hRb2QyUUdo?=
 =?utf-8?B?YUlIUDh5dWEwd1VaUWNNNG9rNitzUVl4YS9VM2tTVWVYaWNFQ013UVFzZWhv?=
 =?utf-8?B?dThsd1J4eEswZjFMLzNZWCtXWXQ5OXFudGI3NG1hSllBWDdMQjhqVVZNVmxo?=
 =?utf-8?B?cGNkYWZRWTJ6U1dFRVk5ZWc4WXFJaGdvSkJidWl1K0dnWVVaejNkcmg3Q3hJ?=
 =?utf-8?B?ZnFtQi8zdXpZVXcvYkZmMi9XU3p4YzhnZlp4TmFnejlWL1NlWXF5RVFlY0gx?=
 =?utf-8?B?VU9JWmFqbEtheDBEUTg3WldtZFFITVhRdDhXV2VuejFxWXJDQ1RXYktRY1lD?=
 =?utf-8?B?OFlIZXQyeVg1b1lRS09hbDFpMHVIaVZCUE9QYU1LY1Qzd0lsWVA1T0JSWFpp?=
 =?utf-8?B?aDBPem04OFRrMHF2eVBqd1RNUzJ0REkrUjRlOWx6Z2RQbHF5Y054T200eVdp?=
 =?utf-8?B?QitSWWJqenFjalBFWFQ5KzRncDB1QTI2Wnh6dkw0QXRIMnBYaW51ZHl2U25h?=
 =?utf-8?B?ZFpMTnVqTmhldml6cUtvS3ZCSlowSllGeTFRNDNEZzFGWmc4aUxmc2Y3UHhG?=
 =?utf-8?B?VlZNSVd6bHI1V0VLQnhLb1hWOGZxeTVYTDRRbk1BZTN6NlRaVUc0TWo5anEy?=
 =?utf-8?B?YzBnUHFHNTEvS0t4bDhkNHU0aEVFbExiU0JidDEwMkFNd0gyK29JTU1KeVN1?=
 =?utf-8?B?bmpndVJLdVBObll5THVzUExyK3Q0WkhLR3oyT2hFRlo0NGJ4SmhIYjRBWWZT?=
 =?utf-8?B?QStBYVhaWUdtMEdENWhWVHJEWkE3NWVNVXl1REx0S0pYd0ZoTVYwQkdzQ3JD?=
 =?utf-8?B?S3NFZzZMZmFtRzl6bURWWEQ0UjNIMFBuMFIwdUVkc1dXdFlHMmdmMmMyTE1U?=
 =?utf-8?B?Ni8zNFdUeVQwZWJTUHhtQThUaVpoZU5qWG1mWXBZckhPL0lzOHRBQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2825b028-646d-40e8-0b86-08de51f50318
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 16:09:49.3572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2jx9VxQeg6zw5OuSui/RdbvV6yCT0w1Hq6snrYGQjHlqSh+0O+WZ0eQcnk/qo8forw9QUonousnUsUtYsMoCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814

DQoNCj4gT24gSmFuIDEyLCAyMDI2LCBhdCA3OjU34oCvQU0sIFVsYWR6aXNsYXUgUmV6a2kgPHVy
ZXpraUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g77u/SGVsbG8sIFNocmlrYW50aCENCj4gDQo+
PiANCj4+PiBPbiAxLzEyLzI2IDM6MzggUE0sIFVsYWR6aXNsYXUgUmV6a2kgd3JvdGU6DQo+Pj4g
T24gTW9uLCBKYW4gMTIsIDIwMjYgYXQgMDM6MTM6MzNQTSArMDUzMCwgVmlzaGFsIENob3VyYXNp
YSB3cm90ZToNCj4+Pj4gQnVsayBDUFUgaG90cGx1ZyBvcGVyYXRpb25z4oCUc3VjaCBhcyBzd2l0
Y2hpbmcgU01UIG1vZGVzIGFjcm9zcyBhbGwNCj4+Pj4gY29yZXPigJRyZXF1aXJlIGhvdHBsdWdn
aW5nIG11bHRpcGxlIENQVXMgaW4gcmFwaWQgc3VjY2Vzc2lvbi4gT24gbGFyZ2UNCj4+Pj4gc3lz
dGVtcywgdGhpcyBwcm9jZXNzIHRha2VzIHNpZ25pZmljYW50IHRpbWUsIGluY3JlYXNpbmcgYXMg
dGhlIG51bWJlcg0KPj4+PiBvZiBDUFVzIGdyb3dzLCBsZWFkaW5nIHRvIHN1YnN0YW50aWFsIGRl
bGF5cyBvbiBoaWdoLWNvcmUtY291bnQNCj4+Pj4gbWFjaGluZXMuIEFuYWx5c2lzIFsxXSByZXZl
YWxzIHRoYXQgdGhlIG1ham9yaXR5IG9mIHRoaXMgdGltZSBpcyBzcGVudA0KPj4+PiB3YWl0aW5n
IGZvciBzeW5jaHJvbml6ZV9yY3UoKS4NCj4+Pj4gDQo+Pj4+IEV4cGVkaXRlIHN5bmNocm9uaXpl
X3JjdSgpIGR1cmluZyB0aGUgaG90cGx1ZyBwYXRoIHRvIGFjY2VsZXJhdGUgdGhlDQo+Pj4+IG9w
ZXJhdGlvbi4gU2luY2UgQ1BVIGhvdHBsdWcgaXMgYSB1c2VyLWluaXRpYXRlZCBhZG1pbmlzdHJh
dGl2ZSB0YXNrLA0KPj4+PiBpdCBzaG91bGQgY29tcGxldGUgYXMgcXVpY2tseSBhcyBwb3NzaWJs
ZS4NCj4+Pj4gDQo+Pj4+IFBlcmZvcm1hbmNlIGRhdGEgb24gYSBQUEM2NCBzeXN0ZW0gd2l0aCA0
MDAgQ1BVczoNCj4+Pj4gDQo+Pj4+ICsgcHBjNjRfY3B1IC0tc210PTEgKFNNVDggdG8gU01UMSkN
Cj4+Pj4gQmVmb3JlOiByZWFsIDFtMTQuNzkycw0KPj4+PiBBZnRlcjogIHJlYWwgMG0wMy4yMDVz
ICAjIH4yM3ggaW1wcm92ZW1lbnQNCj4+Pj4gDQo+Pj4+ICsgcHBjNjRfY3B1IC0tc210PTggKFNN
VDEgdG8gU01UOCkNCj4+Pj4gQmVmb3JlOiByZWFsIDJtMjcuNjk1cw0KPj4+PiBBZnRlcjogIHJl
YWwgMG0wMi41MTBzICAjIH41OHggaW1wcm92ZW1lbnQNCj4+Pj4gDQo+Pj4+IEFib3ZlIG51bWJl
cnMgd2VyZSBjb2xsZWN0ZWQgb24gTGludXggNi4xOS4wLXJjNC0wMDMxMC1nNzU1YmMxMzM1ZTNi
DQo+Pj4+IA0KPj4+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzVmMmFiOGE0NGQ2
ODU3MDFmZTM2Y2RhYTgwNDJhMWFlZjIxNWQxMGQuY2FtZWxAbGludXgudm5ldC5pYm0uY29tDQo+
Pj4+IA0KPj4+IEFsc28geW91IGNhbiB0cnk6IGVjaG8gMSA+IC9zeXMvbW9kdWxlL3JjdXRyZWUv
cGFyYW1ldGVycy9yY3Vfbm9ybWFsX3dha2VfZnJvbV9ncA0KPj4+IHRvIHNwZWVkdXAgcmVndWxh
ciBzeW5jaHJvbml6ZV9yY3UoKSBjYWxsLiBCdXQgaSBhbSBub3Qgc2F5aW5nIHRoYXQgaXQgd291
bGQgYmVhdA0KPj4+IHlvdXIgImV4cGVkaXRlZCBzd2l0Y2giIGltcHJvdmVtZW50Lg0KPj4+IA0K
Pj4gDQo+PiBIaSBVbGFkemlzbGF1Lg0KPj4gDQo+PiBIYWQgYSBkaXNjdXNzaW9uIG9uIHRoaXMg
YXQgTFBDLCBoYXZpbmcgaW4ga2VybmVsIHNvbHV0aW9uIGlzIGxpa2VseQ0KPj4gYmV0dGVyIHRo
YW4gaGF2aW5nIGl0IGluIHVzZXJzcGFjZS4NCj4+IA0KPj4gLSBIYXZpbmcgaXQgaW4ga2VybmVs
IHdvdWxkIG1ha2UgaXQgd29yayBhY3Jvc3MgYWxsIGFyY2hzLiBXaHkgc2hvdWxkDQo+PiAgYW55
IHVzZXIgd2FpdCB3aGVuIG9uZSBpbml0aWF0ZXMgdGhlIGhvdHBsdWcuDQo+PiANCj4+IC0gdXNl
cnNwYWNlIHRvb2xzIGFyZSBzcHJlYWQgYWNyb3NzIHN1Y2ggYXMgY2hjcHUsIHBwYzY0X2NwdSBl
dGMuDQo+PiAgdGhvdWdoIGludGVybmFsbHkgbW9zdCBkbyAiMC8xID4gL3N5cy9kZXZpY2VzL3N5
c3RlbS9jcHUvY3B1Ti9vbmxpbmUiLg0KPj4gIFdlIHdpbGwgaGF2ZSB0byByZXBlYXQgdGhlIHNh
bWUgaW4gZWFjaCB0b29sLg0KPj4gDQo+PiAtIFRoZXJlIGlzIGFscmVhZHkgL3N5cy9rZXJuZWwv
cmN1X2V4cGVkaXRlZCB3aGljaCBpcyBiZXR0ZXIgaWYgYXQgYWxsDQo+PiAgd2UgbmVlZCB0byBm
YWxsYmFjayB0byB1c2Vyc3BhY2UuDQo+PiANCj4gU291bmRzIGdvb2QgdG8gbWUuIEkgYWdyZWUg
aXQgaXMgYmV0dGVyIHRvIGJ5cGFzcyBwYXJhbWV0ZXJzLg0KDQpBbm90aGVyIHdheSB0byBtYWtl
IGl0IGluLWtlcm5lbCB3b3VsZCBiZSB0byBtYWtlIHRoZSBSQ1Ugbm9ybWFsIHdha2UgZnJvbSBH
UCBvcHRpbWl6YXRpb24gZW5hYmxlZCBmb3IgPiAxNiBDUFVzIGJ5IGRlZmF1bHQuDQoNCkkgd2Fz
IGNvbnNpZGVyaW5nIHRoaXMsIGJ1dCBJIGRpZCBub3QgYnJpbmcgaXQgdXAgYmVjYXVzZSBJIGRp
ZCBub3Qga25vdyB0aGF0IHRoZXJlIGFyZSBsYXJnZSBzeXN0ZW1zIHRoYXQgbWlnaHQgYmVuZWZp
dCBmcm9tIGl0IHVudGlsIG5vdy4NCg0KdGhhbmtzLA0KDQogLSBKb2VsDQoNCg0KPiANCj4gLS0N
Cj4gVWxhZHppc2xhdSBSZXpraQ0K
