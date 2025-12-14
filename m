Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A91274FE3
	for <rcu@vger.kernel.org>; Sun, 14 Dec 2025 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765694264; cv=fail; b=bnPM0Qa0vOBZz55qbf5NkfSuozKAgAav+svroStOplRWThFPp8nDsmF8NuYD5LPs2FhjIaQJtZbFEpOvmmEgvzJtFpV4RdbBh+ICnLdAwTuaY/h1jTC26ritAURZ0m53Q5OrObWhvAPjtaye2V9gWZgaXfXGmitj4wuGXxS7Iy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765694264; c=relaxed/simple;
	bh=Eul6eoaq13kLLxsBpj0/vqOzqCdu6oX78PFPquaGBYg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K6K9Plh6d3rKw0LzCoDnW4uZzPFhz1Le8dmQOqvHy0fsXP4I0mNNcvZJBytjsgshw/N0/z1yXptpdZ84IPBNXBUEynX5aaQwEMa/ebmVnMkXWjezJLVrmkZajrI9i6F/Zm5cvZdW7tiqyZMp4nE/MuLvJ32BiJKTnPG519cR9OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xnm60i0z; arc=fail smtp.client-ip=52.101.85.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xnm60i0z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGxD6H4e+pnsfV/R0J2dEJluGWiyjR+ADAr92EOMNvKn5PsxMuv/7G2DAkY2y8/5DWSm6eK1EwWBglvp4LypUZmXRPLFTLq9DpvmHPqxzQz++HJbZM8tpHaw1bkwRA7kd7kC9S/tMUYWnIR2ORWixlU05R/a4Mtrw0RMhaz6av+eZKqfELQb465e1kco+6fRtvHlCTR9V98CQeiC7VZ8cSCCG6NCpmc2H1ZfMuijz4B6Vfj2ArEQgNivv5fGs3AU1Vc3buiGK4xWuasrq/ond/8BxUGhsIgPA7fZGKHoei/aaUJaUWpsq5Rejz9KYDKG7CgIkjfMJkMhcZpGSeT7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eul6eoaq13kLLxsBpj0/vqOzqCdu6oX78PFPquaGBYg=;
 b=brPQLyezcNflX1sCHcXDuCYyP5PaZKAvu/0EsJVXbfjQjyO8zzufiJhZtzOOAJFRQY29z2xuNUB2Rm+ST3wA1+2Gqg9kFSPCiof/3/F9tEhQLC47JEephogEclOvm1LrFwqTwYOPwiQUltbILwzeCSS31Zd4ZumjFz77/ERxrdZVR6m0TsjMSq6lP+i0TDUIXVhdv91JQuClWbY0q1qK6shkaP4Ac5R+Nv49tsvfeiWqIEw3Qf7Y0fZklRpHIXP9VW+5ez0iWw2mJwgSSPzgttUy5nVE7MW9zFGWJLVNNUr6AUvrzeMIdWqjSohWnw39cxoi/30D5VcqnJNWNpsbpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eul6eoaq13kLLxsBpj0/vqOzqCdu6oX78PFPquaGBYg=;
 b=Xnm60i0zaSfzXtFDhZua/6aJRotQt67+QbnAw//kY9XoKfDM5tldunUKG13I13mdv32/BIXF8nkCl1hgg5no1OSrbFoZvIO6Kb9DFgnUEapvE0sK0Av/guCO6oShOaYUF1nrw0GlM5IqmrSlzNeNa4uVIxTmoojzdJ2LBVb8MBgh+RAbYXTSXeiQbMO1MvgDadp1GVYJ3Mqtazr5bDzd/q+SKH92n2A4kABRvCZteU+z5KNBweutBNBXEaZxrWHAabFxW1Y7cOgC9ib2qYFGswjXOo6Kctggdly9qRDshANqq5bhn+Szr8D8ElAatk3Zr1jaA9yxDv48k8oQTeqafQ==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sun, 14 Dec
 2025 06:37:39 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9412.011; Sun, 14 Dec 2025
 06:37:38 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: "paulmck@kernel.org" <paulmck@kernel.org>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "roman.gushchin@linux.dev"
	<roman.gushchin@linux.dev>
Subject: Re: Handling large numbers of hazard pointers
Thread-Topic: Handling large numbers of hazard pointers
Thread-Index: AQHcbIJJolJ1KBXZHEWgN4L0FEUAXLUgbE+AgABC8y4=
Date: Sun, 14 Dec 2025 06:37:38 +0000
Message-ID: <961B6DB0-3071-41D0-9AB6-70B76C547F19@nvidia.com>
References: <77ffb53f-91fb-4bd4-96d4-e16b0e6ff0f1@paulmck-laptop>
 <091915fa-d6a9-4aba-99c6-d93d9b65e0de@efficios.com>
In-Reply-To: <091915fa-d6a9-4aba-99c6-d93d9b65e0de@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|CH3PR12MB7644:EE_
x-ms-office365-filtering-correlation-id: df203d83-00bc-4e34-f480-08de3adb4638
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUdPd3VuUmU1OTNIZ3FqczY3czdYc0Uxa0l1RWVrZXM4WmtXV2ordklIR0Mr?=
 =?utf-8?B?ZXRTSVM1L0VTU1FUR0l0RWVPUUVFR3N3YXNtS29lMkVWRHJFU2hUdUV1TE9O?=
 =?utf-8?B?YkRoUmo1YUxZMHVPYmZ3MmJldzM1SVAxVFVGNXdRVzYyNzFpTWVERzY5WFdG?=
 =?utf-8?B?ZHVsWFQ5R0N0SlI1YlZFeEtiUmR3cDRoekdyRDFXNy9od2RjOWtyVHVVci9H?=
 =?utf-8?B?OTVCcmY0RU5yZUpDeVVEWnNRdFRSS0hza3F3eW9MRVJMMkFwWGUxYmlrR3pC?=
 =?utf-8?B?TkdueFZKWjU2NGcyWlpIMHJjL0ZDMmJ1VTBKN3ZySlN1US8zdFppQmpXSzFq?=
 =?utf-8?B?ZFhUTFVZNCtrQldpVlNjK2ExS0VYK1FDYVhPSHVVSFRkTWpxR3RUNHErWTdj?=
 =?utf-8?B?TFV1R1NkU1NvaDdFN1FlRU9hL0ZGNTA0NGlIa3FMVUFURWV3d1ExaURDbm01?=
 =?utf-8?B?QXowZTFDaEFmenJVclgzN2tUeFFBUnp3SUxLL082RC9QTURweEpiZ0pOZDJk?=
 =?utf-8?B?R1hNeklFdFpGUE1XbHN3c1ZtWTVPTnlvVmFYa202eUVzdGpGM2FwL3RHSTZG?=
 =?utf-8?B?ZmRBV0VBNGs1V2wwQVVUL0JjMk9jaXRtMW9PbkhDS1FZZlJESXdyMnVQeURn?=
 =?utf-8?B?RnRvUjlMdmV1eWJCaC9zM25NNURDekRRSDVoMVdnNlM5ajBwcmg3RGRLWTRt?=
 =?utf-8?B?RXNLcDRSOU5DN3pOcE8rVHNNNVduaThTbVZKazF2TXlqWXE0VWREOHpvZ3lF?=
 =?utf-8?B?MHJsNkdKUi8ycFZKVmZveDBNaWc1UUFiWisySnVIQjFldXhXK1Q0aGhYVjRx?=
 =?utf-8?B?UmZ5cTNOVUhLdXR6SEpJbFBEK25QN3JKaSttbFU3UklpZjIvNmw1bENibU9q?=
 =?utf-8?B?MHBUbFUyVjIwbkF0aGo0YlpFL3dJTHpCeFFKN3hBU1JQWmZzcnVmcEZVMG9n?=
 =?utf-8?B?ZWNNYldPNE9tSWpGSkFTWFkrampHQWFCazM0N2IvdWNwUUlxdzhYV3BubGN6?=
 =?utf-8?B?T3QzVWRvMjZnbUo0WjU5WEZHYzVXL0hnREZ4cXRuT0w1ajQ0VUR6dkZ1bmxU?=
 =?utf-8?B?V2lMZERrYmRKTE5DNTJ2dUZ4Q3lBdE5hYVUzaE8zNXdIWWpTeVl5Q1pFdU1P?=
 =?utf-8?B?SFlERTVyT1U0NkxRTDNXQzRYSkovRmtqYTdPeFYxQzhmdXRGTUdEblhFSTA5?=
 =?utf-8?B?VXdWeWh1cVBoOFRQNTJyZlJlN1RXNlEyYmZMaThmbEZoekR5eElMOHBwTnFF?=
 =?utf-8?B?bFZYak9meTlYcUtpbWpwOVNQWHNySjZCdVAreVpZbHc3M1RsZmRKQ3FacEN2?=
 =?utf-8?B?Z0V0YzErTTByL2FYUW1iSUh2bFNNTjJFSndMQTl5WHNHUnc0MDJnMUxteHAv?=
 =?utf-8?B?eEc3bmxodnZwOGJjbFl2dThpeVp0R2tCOTRNc0ZLUnR6N0VPY0dGcnk5eU9K?=
 =?utf-8?B?TUJ3M1NzNkcvRXovNTl3ay9wTWhpVzVoU0t3N1JpU1h6MXQvQXNZRU4rWDJ6?=
 =?utf-8?B?eUdFekJhc1F4eko1YzBkS0dRRkFDVnZJMzdCaEVJWFI5KzY0cTUwM2VrZlM2?=
 =?utf-8?B?OGorKzBYSm1NMmkrWXFQMEpsQ1NVM3hNMHZZR0ZDSkJ0ZVdPeDE4YkQwSThF?=
 =?utf-8?B?UXFlN25NTnNIaUYvQ28rR1R4OGxHczc2a0d0VjV2ZTViYzdCb3hVYnRqempS?=
 =?utf-8?B?S3BLWmNmenBpOHB4UFFxN1Uvb08yUWRlVzVPYU96UDRXdm53YjM4eFF4dW1H?=
 =?utf-8?B?cDNVUVlVSXN3Z25UNWhMeTJMVENPRTduZlAydldtY1QvcGV1b1QwTmprK2tl?=
 =?utf-8?B?QkNjQ1pIaVZLV0d4cnVReFVLMTZ2WUdZMnZOK2gzQVByQUdOTXNTUVRtRk9w?=
 =?utf-8?B?bkgzKzNiMWFZMTcvcWVGK2N2c2VaR3J5RlVxdWx4Q1hUc1VzUVBUUzdmL09l?=
 =?utf-8?B?S0JFNlJoamUzSTkwRU5ScStZNHV3ODR5Zm1PSnJkRlczOFk5K3RHckRVZ1Vo?=
 =?utf-8?B?R1Fpem1GOXBwbTZia1lZUitrckU1OUtweFVzUzFUVVY3bVR2OUVRbUVWVHc0?=
 =?utf-8?Q?ssVwfa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1FXRWdvQVRSejdvQnE3OGRydjlGOVh4L1hlcGc4RG9VVno0T3g0Mm9mVmxR?=
 =?utf-8?B?QUk0TXBMZndRbGt2eENNb1FZVmVsV1lmbWtMRThWMno3aVhuQWtEMDdrVHoy?=
 =?utf-8?B?b0lkcm5ab3E5VXJoQ09ybjBqb2lER3lqaEQwdWtzRXE0aWREa1ZGdnhsVXI5?=
 =?utf-8?B?eUZkZTNaUnZwc1Nudzl3bWVBSDlKZHdRbXVEbk03aHJ4VDRKUEgxWXRCaVNN?=
 =?utf-8?B?OVc4SHRyWDg3VUpEYkV5dUxOb1dTOHQwKzJmVnJIUE5GdXpaMHdnc3ArV0tq?=
 =?utf-8?B?WGJLaUxlRWJ1K1RORXQ3NFRPZlFMYmpwZWlQdkNoY0k0VGUreWNJMS9rMDdr?=
 =?utf-8?B?c1VrV1kxWXFaTkcyYy9ONTI4VHF6M0J6MzRSUmZlUVgrcVhyUlpFNXRlR2dC?=
 =?utf-8?B?WC9obHhUS0xiWXlxQWtqQWVnRTk2eS90SDhBNHpSUUczL1lFbFkra2twWTJs?=
 =?utf-8?B?a3ZSakFlWWNIeUhtNDRpUTNQcE54U01ML2psTi93NEpwWWZsTzBwaUZJOS9T?=
 =?utf-8?B?cW0vNllpYWZJeHMyemtYU1MvWWhwMU9TTm9BUTNCMis5L0ZtcUY4dnNvdjVG?=
 =?utf-8?B?bFNscCtEQWxvSktHVlhYcld6UDVZdWlleFI2cU1KSkNkTS80VEhBeFFmbk94?=
 =?utf-8?B?YXZ0MWhhNTlTR0plWlFkZ2M5aFhoaXNlYmNkQXZJa3NuR0hVUzhRc1d2VTFI?=
 =?utf-8?B?amw5SVBKSHRxWVhjUU4rYUZvQWdzRXJkUVJzMzRaYks0dkVYWms3dEJ4WGVl?=
 =?utf-8?B?RUtkdVhXQkt1YmZseDNBcEpOa2JuOE16cmhJdFFiVWNiZWlZMzFWZ2RzQ3dS?=
 =?utf-8?B?OWk3alVDZk5RSTJrNGdxRlp4ZE9BZ1JuM0ZFeS9hRFd6Um5UMG9sSmxabzg0?=
 =?utf-8?B?YmJiOUpKYyt6eUhpdE9vbUFXYjMwZ2o2QlNSVmk4OUxFQUFhT1pVUXdVYlRW?=
 =?utf-8?B?VTZDMkhJUWs3R043UnFLd2kwZm90ek1vajlEWFR6TEFiK3QxTGxDS0NzbHoz?=
 =?utf-8?B?TnFuWEtZcTNDbmFLaDZUWHAzZTdZNldGcFBGN2ptRnhkazJ6ajk5MzI4WWdo?=
 =?utf-8?B?RFBQWjAvZkhpeFZISVJyWlYxK296MytBY2VDWHB0aElkWnhoMjZqLzJ3ZmQ0?=
 =?utf-8?B?eU1RWWV5UTdvd3ZGNVJkWGVZeEdMWHRwQXJZTGMycXUvWWxKSHB6ZmRkY2hu?=
 =?utf-8?B?Z1RuUWhXbGlBYnNhcjAzMEphMnVoTFRKdDFSWDZ3MjNKZ3cvUHpxeUlxZEVN?=
 =?utf-8?B?SExTbGtyamloR0lRL3dzdlRPTUZNQ3pHSTZBMGJ0T0dMTVQrYTM5VnNwdVdv?=
 =?utf-8?B?MlNrWTZLa1JFV24yNURsTkVCRWJ1OE1FM0tldTNqZG5Ja1lzYTJubnZCRHZE?=
 =?utf-8?B?bWlFUnVzSTRreWFIOWwrQUx1RlkraWxxd2JtQTVMOWZEOUpUSDRGc0swTXlM?=
 =?utf-8?B?aS9Dc09ScC9JaTloeGFETG1hcE9lK2c5a0xIMXdibFRESC9QQXhlQXN1d1Vq?=
 =?utf-8?B?akVjUy9YOTZ5LzVPMVIydkl1VTRzQ0xxNis2QXNNUmxSbFRPMkRBNUpva0Zj?=
 =?utf-8?B?M3lHQ0dRaWZ5RHIraWk2YUdFdGgwK0FBNHJLQXZTcmloVWZ2N2NpeXRHeFRx?=
 =?utf-8?B?TExidFFINXkyVGZ0ODVRc3F5VkFjRmdnSjJjZUFMZ09HUnNvSTl0ZzAvUlVw?=
 =?utf-8?B?WW05Vzd2VnpuUVh0Sm4vWHl0WXJFQUN1ZXdhVTJiL3VOM285b0Y2T1Jrd2Rp?=
 =?utf-8?B?WFVPRkJhcXR3ZjBKSE5saWlLQjVXRFNXZnpTYzlPRjJWd2MrVGh0Uzc5SzBZ?=
 =?utf-8?B?WVNDS1BUMzNVMHhtYWJKTTMycHF4TUtQYVV3K2FkcXVMN3cyZ0ZwUEthV0xS?=
 =?utf-8?B?UEFlYTFYcituWWVIYXVEd05xZnJwc1VQOUpoays3cUF1TmlBRFMwN0NEU01U?=
 =?utf-8?B?NlNDQmdwWjN2dWZxWWI0bzE2SzlYWEV0NWhTdDBmUmxjcmRTZEEwWHgwTFUx?=
 =?utf-8?B?ZVBVKzAwRkV0YTloQkx5ZlRPS1JwZW51ajhJbmVPK08zQWMyWUFGWU9MZU5a?=
 =?utf-8?B?SFlMRk1KTHVtb2VQNldpd0QwWTRyWmZWMTJTL2lVREx1NUtuQmFadGp1TjQv?=
 =?utf-8?Q?N89ut4MMKK/lOhUIMZMkBmN/W?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df203d83-00bc-4e34-f480-08de3adb4638
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2025 06:37:38.2993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uh//f+ODmPGQ59Od2YAqlz3RvspVby5yG/c0OGnHJ7ZmoIyrCXQE5xGIPOwTu13IS068dUImnsM6PPQOVlUN7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

DQoNCj4gT24gRGVjIDE0LCAyMDI1LCBhdCAxMTozOOKAr0FNLCBNYXRoaWV1IERlc25veWVycyA8
bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToNCj4gDQo+IO+7v09uIDIwMjUt
MTItMTMgMTc6MzEsIFBhdWwgRS4gTWNLZW5uZXkgd3JvdGU6DQo+PiBIZWxsbyENCj4+IEkgZGlk
bid0IGRvIGEgZ29vZCBqb2Igb2YgYW5zd2VyaW5nIHRoZSAid2hhdCBhYm91dCBsYXJnZSBudW1i
ZXJzIG9mDQo+PiBoYXphcmQgcG9pbnRlcnMiIGF0IEJvcXVuJ3MgYW5kIG15IGhhemFyZC1wb2lu
dGVycyB0YWxrIGF0IExpbnV4IFBsdW1iZXJzDQo+PiBDb25mZXJlbmNlIHllc3RlcmRheSwgc28g
cGxlYXNlIGFsbG93IG1lIHRvIGF0IGxlYXN0IHN0YXJ0IG9uIHRoZSBwYXRoDQo+PiB0b3dhcmRz
IGZpeGluZyB0aGF0IHByb2JsZW0uDQo+PiBBbHNvLCB0aGVyZSB3ZXJlIGEgY291cGxlIG9mIHBl
b3BsZSBwYXJ0aWNpcGF0aW5nIHdob3NlIGVtYWlsIGFkZHJlc3Nlcw0KPj4gSSBkb24ndCBrbm93
LCBzbyBwbGVhc2UgZmVlbCBmcmVlIHRvIENDIHRoZW0uDQo+PiBUaGUgdHJpY2sgaXMgdGhhdCBp
biByZWFsIHdvcmtsb2FkcyB0byBkYXRlLCBhbHRob3VnaCB0aGVyZSBtaWdodCBiZQ0KPj4gbWls
bGlvbnMgb2YgaGF6YXJkIHBvaW50ZXJzLCB0aGVyZSB3aWxsIHR5cGljYWxseSBvbmx5IGJlIGEg
ZmV3IGFjdGl2ZQ0KPj4gcGVyIENQVSBhdCBhIGdpdmVuIHRpbWUuICBUaGlzIG9mIGNvdXJzZSBz
dWdnZXN0cyBhIHBlci1DUFUgZGF0YSBzdHJ1Y3R1cmUNCj4+IHRyYWNraW5nIHRoZSBhY3RpdmUg
b25lcy4gIEFsbG9jYXRpbmcgYSBoYXphcmQgcG9pbnRlciBncmFicyBhbiB1bnVzZWQgb25lDQo+
PiBmcm9tIHRoaXMgYXJyYXksIG9yLCBpZiBhbGwgZW50cmllcyBhcmUgaW4gdXNlLCB0YWtlcyBt
ZW1vcnkgcHJvdmlkZWQgYnkNCj4+IHRoZSBjYWxsZXIgYW5kIGxpbmtzIGl0IGludG8gYW4gb3Zl
cmZsb3cgbGlzdC4gIEVpdGhlciB3YXksIGl0IHJldHVybnMgYQ0KPj4gcG9pbnRlciB0byB0aGUg
aGF6YXJkIHBvaW50ZXIgdGhhdCBpcyBub3cgdmlzaWJsZSB0byB1cGRhdGVycy4gIFdoZW4gZG9u
ZSwNCj4+IHRoZSBjYWxsZXIgY2FsbHMgYSBmdW5jdGlvbiB0aGF0IG1hcmtzIHRoZSBhcnJheS1l
bnRyeSBhcyB1bnVzZWQgb3INCj4+IHJlbW92ZXMgdGhlIGVsZW1lbnQgZnJvbSB0aGUgbGlzdCwg
YXMgdGhlIGNhc2UgbWF5IGJlLiAgQmVjYXVzZSBoYXphcmQNCj4+IHBvaW50ZXJzIGNhbiBtaWdy
YXRlIGFtb25nIENQVXMsIGZ1bGwgc3luY2hyb25pemF0aW9uIGlzIHJlcXVpcmVkIHdoZW4NCj4+
IG9wZXJhdGluZyBvbiB0aGUgYXJyYXkgYW5kIHRoZSBvdmVyZmxvdyBsaXN0Lg0KPj4gQW5kIGVp
dGhlciB3YXksIHRoZSBjYWxsZXIgaXMgcmVzcG9uc2libGUgZm9yIGFsbG9jYXRpbmcgYW5kIGZy
ZWVpbmcgdGhlDQo+PiBiYWNrdXAgaGF6YXJkLXBvaW50ZXIgc3RydWN0dXJlIHRoYXQgd2lsbCBi
ZSB1c2VkIGluIGNhc2Ugb2Ygb3ZlcmZsb3cuDQo+PiBBbmQgYWxzbyBlaXRoZXIgd2F5LCB0aGUg
dXBkYXRlciBuZWVkIG9ubHkgZGVhbCB3aXRoIGhhemFyZCBwb2ludGVycw0KPj4gdGhhdCBhcmUg
Y3VycmVudGx5IGluIHVzZS4NCj4gT0ssIHNvIGxldCBtZSBzdGF0ZSBob3cgSSBzZWUgdGhlIGZ1
bmRhbWVudGFsIHByb2JsZW0geW91IGFyZSB0cnlpbmcNCj4gdG8gYWRkcmVzcywgYW5kIGRldGFp
bCBhIHBvc3NpYmxlIHNvbHV0aW9uLg0KPiANCj4gKiBQcm9ibGVtIFN0YXRlbWVudA0KPiANCj4g
QXNzdW1pbmcgd2UgZ28gZm9yIGFuIGFycmF5IG9mIGhhemFyZCBwb2ludGVyIHNsb3RzIHBlciBD
UFUgdG8gY292ZXINCj4gdGhlIGZhc3QgcGF0aCAoY29tbW9uIGNhc2UpLCB3ZSBzdGlsbCBuZWVk
IHRvIGhhbmRsZSB0aGUNCj4gb3ZlcmZsb3cgc2NlbmFyaW8sIHdoZXJlIG1vcmUgaGF6YXJkIHBv
aW50ZXJzIGFyZSBhY2Nlc3NlZA0KPiBjb25jdXJyZW50bHkgZm9yIGEgZ2l2ZW4gQ1BVIHRoYW4g
dGhlIGFycmF5IHNpemUsIGVpdGhlciBkdWUgdG8NCj4gcHJlZW1wdGlvbiwgbmVzdGVkIGludGVy
cnVwdHMsIG9yIHNpbXBseSBuZXN0ZWQgY2FsbHMuDQo+IA0KPiAqIFBvc3NpYmxlIFNvbHV0aW9u
DQo+IA0KPiBSZXF1aXJpbmcgdGhlIEhQIGNhbGxlciB0byBhbGxvY2F0ZSBiYWNrdXAgc3BhY2Ug
aXMgY2xlYXJseSBzb21ldGhpbmcNCj4gdGhhdCB3b3VsZCBjb3ZlciBhbGwgc2NlbmFyaW9zLiBN
eSB3b3JyeSBpcyB0aGF0IHRyYWNraW5nIHRoaXMgYmFja3VwDQo+IHNwYWNlIGFsbG9jYXRpb24g
bWF5IGJlIGN1bWJlcnNvbWUgZm9yIHRoZSB1c2VyLCBlc3BlY2lhbGx5IGlmIHRoaXMNCj4gcmVx
dWlyZXMgaGVhcCBhbGxvY2F0aW9uLg0KPiANCj4gV2hlcmUgdGhlIGJhY2t1cCBzcGFjZSBjYW4g
YmUgYWxsb2NhdGVkIHdpbGwgbGlrZWx5IGRlcGVuZCBvbiBob3cgbG9uZw0KPiB0aGUgSFAgd2ls
bCBiZSBhY2Nlc3NlZC4gTXkgd29ya2luZyBoeXBvdGhlc2lzIGhlcmUgKGxldCBtZSBrbm93IGlm
DQo+IEknbSB3cm9uZykgaXMgdGhhdCBhIG1vc3Qgb2YgdGhvc2UgSFAgdXNlcnMgd2lsbCBjb21w
bGV0ZSB0aGVpciBhY2Nlc3MNCj4gd2l0aGluIHRoZSBzYW1lIHN0YWNrIGZyYW1lIHdoZXJlIHRo
ZSBIUCB3YXMgYWNxdWlyZWQuIFRoaXMgaXMgdGhlDQo+IHByaW1hcnkgdXNlLWNhc2UgSSB3b3Vs
ZCBsaWtlIHRvIG1ha2Ugc3VyZSBpcyBjb252ZW5pZW50Lg0KPiANCj4gRm9yIHRoYXQgdXNlLWNh
c2UgdGhlIHVzZXJzIGNhbiBzaW1wbHkgYWxsb2NhdGUgcm9vbSBvbiB0aGVpcg0KPiBzdGFjayBm
cmFtZSBmb3IgdGhlIGJhY2t1cCBIUCBzbG90LiBUaGUgcmVxdWlyZW1lbnQgaGVyZSBpcyB0aGF0
IHRoZXkNCj4gY2xlYXIgdGhlIEhQIHNsb3QgYmVmb3JlIHRoZSBlbmQgb2YgdGhlIGN1cnJlbnQg
c3RhY2sgZnJhbWUuDQo+IElmIHRoZXJlIGlzIGVub3VnaCByb29tIGluIHRoZSBwZXItQ1BVIGFy
cmF5LCB0aGV5IHVzZSB0aGF0LCBlbHNlDQo+IHRoZXkgYWRkIHRoZSBiYWNrdXAgc2xvdCBmcm9t
IHRoZWlyIHN0YWNrIGludG8gdGhlIGJhY2t1cCBzbG90DQo+IGxpc3QuIFdoZW4gdGhleSBhcmUg
ZG9uZSwgaWYgdGhleSB1c2VkIGEgYmFja3VwIHNsb3QsIHRoZXkgbmVlZA0KPiB0byByZW1vdmUg
aXQgZnJvbSB0aGUgbGlzdC4NCj4gDQo+IFRoZXJlIGNvdWxkIHN0aWxsIGJlIHJvb20gZm9yIG1v
cmUgYWR2YW5jZWQgdXNlLWNhc2VzIHdoZXJlIHRoZQ0KPiBiYWNrdXAgc2xvdHMgYXJlIGFsbG9j
YXRlZCBvbiB0aGUgaGVhcCwgYnV0IEkgc3VzcGVjdCB0aGF0IGl0IHdvdWxkDQo+IG1ha2UgdGhl
IEFQSSB0cmlja2llciB0byB1c2UgYW5kIHNob3VsZCBiZSByZXNlcnZlZCBmb3IgdXNlLWNhc2Vz
DQo+IHRoYXQgcmVhbGx5IHJlcXVpcmUgaXQuDQo+IA0KPiBUaG91Z2h0cyA/DQoNClRoaXMgc291
bmRzIGZpbmUgdG8gbWUuIA0KDQpXZSBoYXZlIGhhZCBzaW1pbGFyIGlzc3VlcyB3aXRoIGtmcmVl
X3JjdSgpIGFuZCBydW5uaW5nIG91dCBvZiBwcmVhbGxvY2F0ZWQgbWVtb3J5IHRoZXJlIG1lYW50
IHdlIGp1c3QgdHJpZ2dlcmVkIGEgc2xvdyBwYXRoIChzeW5jaHJvbml6ZSkgYnV0IGZvciBoYXph
cmQgcHRyIEkgYW0gbm90IHN1cmUgd2hhdCBzdWNoIGEgc2xvdyBwYXRoIHdvdWxkIGJlIHNpbmNl
LCBzaW5jZSB0aGlzIHByb2JsZW0gYXBwZWFycyB0byBiZSBvbiB0aGUgcmVhZGVyIHNpZGUuDQoN
ClBlcmhhcHMgd2UgY2FuIGFsc28gcHJlIGFsbG9jYXRlIG92ZXJmbG93IG5vZGVzIGluIHRoZSBh
cGkgaXRzZWxmLCBhbmQgdGFwIGludG8gdGhhdCBpbiBjYXNlIG9mIG92ZXJmbG93PyBUaGUgdXNl
ciBuZWVkIG5vdCBwcm92aWRlIHRoZWlyIG93biBzdG9yYWdlIHRoZW4gZm9yIG92ZXJmbG93IHB1
cnBvc2VzLCBJIHRoaW5rLiBBbmQgcGVyaGFwcyB0aGlzIHByZSBhbGxvY2F0ZWQgcG9vbCBvZiBv
dmVyZmxvdyBub2RlcyBjYW4gYWxzbyBiZSBjb21tb24gdG8gYWxsIGhhenB0ciB1c2Vycy4gSWRl
YWxseSBpdCB3b3VsZCBiZSBnb29kIHRvIG5vdCBhbGwgdGhlIGFwaSB1c2VyIGRlYWwgd2l0aCBv
dmVyZmxvdyBhdCBhbGwgYW5kIGl0IHRyYW5zcGFyZW50bHkgd29ya3MgYmVoaW5kIHRoZSBzY2Vu
ZXMuDQoNCkkgdGhpbmsgd2UgbmVlZCBub3Qgd29ycnkgdG9vIG11Y2ggYWJvdXQgY2FzZXMgb2Yg
cHJlYWxsb2NhdGVkIG92ZXJmbG93IG5vZGVzIGl0c2VsZiBydW5uaW5nIG91dCBiZWNhdXNlIHRo
YXQgaXMgbm8gZGlmZmVyZW50IHRoYW4gcmVzZXJ2ZWQgbWVtb3J5IG5lZWRlZCBpbiBhdG9taWMg
Y29udGV4dCB3aGljaCBuZWVkIGEgbWluaW11bSBvZmYgYW55d2F5IHJpZ2h0PyBBbmQgd2UgaGF2
ZSBhIGJvdW5kZWQgbnVtYmVyIG9mIENQVSBhbmQgYm91bmRlZCBudW1iZXIgb2YgY29udGV4dCwg
c28gdGhlIG51bWJlciBvZiAqYWN0aXZlKiBub2RlcyByZXF1aXJlZCBhdCBhbnkgZ2l2ZW4gdGlt
ZSBzaG91bGQgYWxzbyBiZSBib3VuZGVkPw0KDQpUaG91Z2h0cz8NCg0KVGhhbmtzLg0KDQoNCg0K
DQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IE1hdGhpZXUNCj4gDQo+IC0tDQo+IE1hdGhpZXUgRGVz
bm95ZXJzDQo+IEVmZmljaU9TIEluYy4NCj4gaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tDQo+IA0K
