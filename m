Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF84253F00;
	Wed, 26 Mar 2025 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743029419; cv=fail; b=FOe68e72OJW74N9jnwNJVWzvzIugq8lEEOtuhH7xOsCMJzT5iRDn2YeRMi38jttcCsUTV5t7uyL4y01plYongoFtlmREgSB9+Rs2XLC/0Zb3eQ8DQ6v7hjDLjQhtBNxPHw3yVfs/2JLP/YYGak87S/clH46jZvJKoKVwYUigV4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743029419; c=relaxed/simple;
	bh=e/R2wxKx/KCKaeMAc98SZU60JMNgZNMvZ17vk+F2evM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g8RX70+w1Ys/bU0uMcNixpKYiJ3jBbZtTiU1PI/DgTzKEbhLgFhhy85Zt4EvptyyiYu3eMH3gur3yw4ecSTOZeRbcAZ0FN68sZ2I4gQYdM3QhzLDgnLNgZbDh/6iSmju6+Dl5WQRbB+KRZSWS3S1Go2UEycguU3JM9F1B8ijNo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qRSqGDMG; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qRSqGDMG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTJCv89VbqH59Bqju7HDDhZiFsjJmFQjw2DcNDEiTsmrmuw0SVVm3aCuOq9penEVik6rY2DPfJs28s4aqGcQS2kWyOrVzMo1MUwONo7XbsCAtJ5/MU0Cth+Xlx0BY3j1JceTQjwP2PWAoW9+1V+KKlc2mt0Mk+2Jor/FPQXA2VTUC9PsWexkOmwIOKqb0vJpKpQcp9VPfgif+ah1+tiOdocNrvlf+CcJuqOtsGfuzkRLwE3EASbbbbuu2bL5ibRZjzzkPE+sWMDKW3kzaxNVS2IMHjAxr1GAF4BjVGrYlSVzpsd7yOiwEJwRHSGXd1SZ8B/kel9x+0b9JyrQ/Nb2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/R2wxKx/KCKaeMAc98SZU60JMNgZNMvZ17vk+F2evM=;
 b=q8RuOFEgWYO4icZMwr6XBUXdPDPBQUgtblXoj9VWErDBECT7THuaQI4r+UHjArR0LyJXrqmtPtaBieTPsKnEHBXAsDcFPPu/ZXIdCOEZRXCn1ydxkHtxv+80gKCNagKV77o9CTZcZ0ocSq5velZqxK9dvMyDT928U9xEQd1N5ScCpiU/9Bhwpx7bfHpYOkuzptClexcYW+VlyioxGFBqD+/pNVjBEmF9UnUCISW9EE+en0nYiKSg2N+co04Fnz+nmoKN/Ze9dYes5Tgu3j1fOgbLCGCN7P2ndTloWHjii7y1ky4s3HKG2itifHFo4yEFvzXQe5luUDqMRxIpcaSMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/R2wxKx/KCKaeMAc98SZU60JMNgZNMvZ17vk+F2evM=;
 b=qRSqGDMGcd+qjaN/5NWS1e+k7cchaZqUdfdeZm0s2hQhZIyK2RYD+37xcOJB0cSV8a/rex15lU6hVHnmGEi7K5dyYY21/X8BULD8NcmXTD/YTzIwHoxObYmu5tJYfTQ8xeol+pGT1B0lVoQrfct/Hw/QCja+zMHVNgKAJ4Gp4pPJ/MP0+9wjEFGNOdAV6TUKFFM6PhVdAdxS/y2n9y4/9sPWTb8P/bPkK9Bm626RlrUZbhf1kmpbSGwmt2XrxeE4dgsghREl3l8sFu5EuqnlZvxtWK6sBcfD7ARd5+/kdnyl/eoQbVjCvged4hw+8yYH5c/QDO6AkvvCkQs+EcK1YQ==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 26 Mar
 2025 22:50:14 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 22:50:14 +0000
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
Subject: Re: [PATCH 2/3] rcu: Add warning to ensure rcu_seq_done_exact() is
 working
Thread-Topic: [PATCH 2/3] rcu: Add warning to ensure rcu_seq_done_exact() is
 working
Thread-Index: AQHbnN57Vm1jhnQst0ir5AflSQ1F4rOGBWCAgAADwkk=
Date: Wed, 26 Mar 2025 22:50:13 +0000
Message-ID: <E9D67C85-37FD-4BA7-990D-2BA2ED7E5963@nvidia.com>
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-3-joelagnelf@nvidia.com>
 <4a40eba2-ebd3-42a8-a25f-b7a0ff94256b@paulmck-laptop>
In-Reply-To: <4a40eba2-ebd3-42a8-a25f-b7a0ff94256b@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|SN7PR12MB7273:EE_
x-ms-office365-filtering-correlation-id: e8123bcb-5a8a-494c-2941-08dd6cb89244
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z0gwV2t0NDJyMUFpL1crdTJWbkhZakVYKy8zbjdaV3FmTzE1SGpCczNkUG9x?=
 =?utf-8?B?TG5ibTUzVDloZ21FcUJpYjZmZy9pRWJ1NGd5R3l3QkEvQ0pHL2xBYXJzd3Bz?=
 =?utf-8?B?eUtteVVlaDZTb1Z5TFFnR2ZmSmg4TEc2NytLM1lmc1BPSlVxeUxnbVBmUlpB?=
 =?utf-8?B?QUF1NUluK0dZeDhnQ0FicFBQZE5GUUd6QlZybEpzTG1KOVJLbjZIQjdGRTNv?=
 =?utf-8?B?bi93Z0J3TEc5Ym1DbkJtRGovYTV0ZVV6MktCYjQyU1ExNG80UWRZc0hUdmQy?=
 =?utf-8?B?ekFqYmxaTUNSOVByOE9ISWxTSGpZdG1nd0xnaU5JckZkelcvYytiSjFJSTR1?=
 =?utf-8?B?dXF4UmpsSkZJNTFMTTE2eXFQcEtEdG0wR2dSTkVPK1NyRC95QmlIQ0Y1ZkVp?=
 =?utf-8?B?RmFJclE5Q3RhRkxXbDZnclZBbHJ2OFordFpObEIyaFlBYjJ6VVpUN2FQUnpt?=
 =?utf-8?B?ZWw5azZPSmNqZXh2QU5hMnNUeXFSaDI1ZlE4ZGRMckRCM1gwMFpubWRzbHJI?=
 =?utf-8?B?YndWZHg1ZXc4NWNQc2ZwRXBic2lLUW9LajhOMlQ0SFJlbk9ya1NtUmpEUXU1?=
 =?utf-8?B?cjNVaStKU2F0ZnQzaUdGUi92ZXVrdS9sUVZ2SEJTaG44cmpDRGw2MU8zd3pp?=
 =?utf-8?B?M2ZMWTdMZFdPcU5ScCtPVmI5aFg3YkxqRVFqUDQ0b0h5V09HRkhqaDhLK2xL?=
 =?utf-8?B?LzQwazBJRGJxVWVjZkV3dE1uUFF0U3R5RHAzeVNxOC9QM2Jza25yaUc3VGFm?=
 =?utf-8?B?QlVwT2NXdDJHZHNhaVBGbnJaK1E0M0NMWWl2UHFQdnZEcnBOdkdkSFMyV29k?=
 =?utf-8?B?V3NOdDgvTGZ4T3B3ZGl4OEdqWEp1WkNTTjlnYlhUdkFwN2tMUGtCM2twb2ky?=
 =?utf-8?B?aWZ5N244RW5EeThlVC84eEp0TGpUYTlYVURyTmI1T2c1RUVJU1VydHNZUW9r?=
 =?utf-8?B?OVdXSktzNi9ST0RERUszcDZjakw2WC9VbUJkVHh2YjVHdDdmcmg2cXhMMmIr?=
 =?utf-8?B?Znk5TXZXKy9MYnV6VVh2M3RwTUMvVkpDY2Ezci9BTms0UlQxZS9qUmRoRVBm?=
 =?utf-8?B?Z0s2NGcvakU1VEZpSm9LVkdCV2xRRnpyd1AxOVRqMGZvQjdYV2grYUkwVGdV?=
 =?utf-8?B?azJ0bnpGdDJwdklEamVCdmRFRlYrdnJlTXNxM09MOWZmMjQ3ZGtLUFdpZ0dB?=
 =?utf-8?B?SU1PdGVLdGRudnFWaFJnZ1FHMGhLMG1iM3hEb3VqL2pYT0hNb2JyNXRvS2Jj?=
 =?utf-8?B?M3R6ay9wWHRIN0YxYW9uQVp2ZkdyZDBQSkU5ajUyeFVIRnVnK1RCTWwyUkhJ?=
 =?utf-8?B?d1VmQWJ1VDlOSWxHSjdUV0tRNlJBakpmcmpxdG4ybWJVRldBMWwwTnNEMm5r?=
 =?utf-8?B?NW5sRlRUMVVPSVZCUExrS3NVYzZ6Wkp0eUplU2FMSHNzOUM0QVRCZXYwUnAw?=
 =?utf-8?B?MzQrQ3BzZHh4bDc2TEtjRVF4SHQxd3Z5K1JZaEhzNHYzM04xUlpQMFJJdEZO?=
 =?utf-8?B?azBybnJiMk5rTThKSFZoa1AzcjdmZVhRMlRYVFd3cllCT0ZVL0g1ZjNiclZ5?=
 =?utf-8?B?am85S3VQWUoyU2Z5TEJpVmQwejhDK3hMbGxQZEJ2Y1lVUkh0MlRaQ3NzZ0xT?=
 =?utf-8?B?K3c3emVrM2VLWUJWbE9sR21TeHFZelpOYWkvSmRZbCtod1QvTU5BNmhuNzVm?=
 =?utf-8?B?OUI4Tytmc2hsaTlYT2thSkd4YXEwMDh3NFpxUlNpZzRvQzROMkJQNlVTVnc2?=
 =?utf-8?B?ZGhNa3NRc1lnUXRzdGpQVFdqOGZpekYvdUNic0RFQnNwN2FJMW9GWVZMT0Zl?=
 =?utf-8?B?VDRIYmJscHdVMCtZMjBTcmtaRmpzOGcxYWt6WUhhcG5POTdCeTQ2cVNMS093?=
 =?utf-8?B?RS9GaktpdWZyYnFEYUdKZi9SV3ZiUktIOGsvSE9aNlRMOHBjK3kwZVFwK2Zj?=
 =?utf-8?Q?ojB/CsWUtpJAtUW8FRWW1Wgfwy/WNOOa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFJ5RTBlK1owK09lT2MzdEQ5bjY3ZzRoNkJ5bTlYTitFVjR4NWJCSWVCMzVu?=
 =?utf-8?B?R3ZxZE9ZKzQ3VXNvckEvNyt0M3VSYzgxcFlXSm1XY2hkMHBXL3N5WTlaUEhO?=
 =?utf-8?B?WFRDcWlNS3pnTHFUamw3Um92V0dXSjNJK0tqWkRNTE1qWXRseVZ5aXo4akJs?=
 =?utf-8?B?Q2RheDZKZWF5ZWkzRVd3V3pZRCtiU2pmTFROZUdwWkdDVWFxTnVXcFNNckVi?=
 =?utf-8?B?TnVJamVlcWk0ZzBUVVRlV0Zyd3VXdTYxUTFSekRrM0JIL1lBcjY5eVdEVCtm?=
 =?utf-8?B?VE5nWTF3SFJOdkFTQkJOWmxYYTJ3bGJLY0JFaXZWek1ZSEtjYmVPTW5XVTB5?=
 =?utf-8?B?QkRDTUhaa2NrcmFiS2dKeUtGWno3K290RVF2bFUwMEkvek1CU05pSy9LR1NW?=
 =?utf-8?B?aXpFVFo1RU9YM1NJY3J3QzdGQTJVdGhYVlB2NlkyQTF3UmhMK3NJdkpibm54?=
 =?utf-8?B?Q1puZjl6YjJueHpyUi8xUkgzVGRmeDBITjh2TFk3QzlDRU05eEVaaVdRbGov?=
 =?utf-8?B?dTBOakxNRTV3azRVbG5PbE04SWIySHVqN0tzQzRQa1NsbmszU0xNVEYxRzEx?=
 =?utf-8?B?SnpaWmE2RVVLaDVlUmZoWEMreUNJWWM2ZFloRFZ4RTNhQWs4K2FwdTNOWmFQ?=
 =?utf-8?B?bERCQXhWU1ppZGpjWStPblpGYjZ3NktDZkpzQmlGU2NWRktMVk1LQXJDU3Jz?=
 =?utf-8?B?akg5QTR5cG9obkdXNjhlRFdhMUNPWFp0OXI2SHljdlRXQnE1RlBuanpaMVhI?=
 =?utf-8?B?UldyUmpFY1VSdTNsUjFJNTJyVE1JVi9pdE50bnFBcWtaVjFDMnMxOHFBNnhX?=
 =?utf-8?B?Q3pMWFpGVENmVzJRMkQvMC9wWlpBcU1PZzJHMEozN29HNTlhOWxpUlFMTCtD?=
 =?utf-8?B?dUdnNktlWVVLSnZiZWR0UHE3aDdReGplYjloR3puR1V4TWNiMElrODYzdjUy?=
 =?utf-8?B?ci8wQTN6UENXS3l2MG5sdUc5bVdSbmpGTUpmRk50YUM3a1poUklKQjB0dlpx?=
 =?utf-8?B?SGVISGhFcml1OVhYQXlsQmEzWTdQeHQybHAwRU9SWnZ5U3JJbE8yYjJyZDdH?=
 =?utf-8?B?QW5HakJ2VTZlUDdvWGVtWnB5WW9oWmZFdVhlV2dJMitUelg1RzVQUEVFVnBq?=
 =?utf-8?B?ODltNHVGR3MvTElpblhycTZsMkFFWFpoR2VHdUFPYjFNVDhRc3FzVWVZb3NE?=
 =?utf-8?B?dWs3UzhyRGtNZjVyL2hZSGEvWXZaWmdlQ0d4ckNrYXNZTkNJN2V4LzFFak5E?=
 =?utf-8?B?M1E4SmdiQUl0eFk1MThvUk4xWDZ1dzVLYURWSkJKQ0tUTDVyRHdqVnNNcUc2?=
 =?utf-8?B?L3JKWm1kSmxDZEVOQnZHQ1p2dHJacEtFMXlnOWQxRW9ERVZaWHBFVHhoQU5T?=
 =?utf-8?B?YVJSL2FSR3gxb2lrek5hYXhIYm1ZazlDTzdKY2dRcytZVXo3UWtsenBPeHpy?=
 =?utf-8?B?S0VHOUIxT1Vtd1kzenFvenk1d3doeHMzbjVlS1VaSDRvQnJQNGFmWTR3SWho?=
 =?utf-8?B?dnlBRlQwSkI4cldiT1RWaGl1RDBRVVNVb2l1YzNCNGdXWnFsOUE3VjhOWFJk?=
 =?utf-8?B?TDIydGZVc0pTUHJaWGQvZHhacDgzMGVGOGRuSnA1YXlsNUJBU2llYU1zVnFJ?=
 =?utf-8?B?b3lzTnQwU2pSNk5WaGgveDUxNG01NDBwQWpUNnRxUVZlZDFIOHZIRkdlU2tX?=
 =?utf-8?B?a3NKMHlzYUZjSEl1NHRjYVJqNHVCNGlYQm1mamJXM3ZlSkdXbXhOaTBYeHN4?=
 =?utf-8?B?eTVEOTg2eU54ekd5L1c0Qm1lYzdUZStsdUF1RHhBc0xMcFMvYmpSK09vNHVz?=
 =?utf-8?B?WHNpTWpXZW9RWVNCOTZWWEJNMmVwTlRKVTIraEhxZzh4Zi82M21qejA1aG9z?=
 =?utf-8?B?eEg5MTNSVHEzdzlpQUZsd1RqSUZlYjVvb0hVZTA5bERmVzJWcnNMenpPVHZG?=
 =?utf-8?B?ZDYycEJncWN1UldUSTRHdHBxbjhIVU5SZ1ovellyOGl6SVJyNXVtV3p3bFo5?=
 =?utf-8?B?RUtTc1hjSnRqRU5GNzYya1ZiZ1pPY3IycGhyM2M2Tyt2RVRISVdlUThDQzcz?=
 =?utf-8?B?YnN4TUp3Uzl5NkJCcDZSc2ZmVXlsQWQvQ3ZNeEt2Rzd3MnNWZEhZNHBCWk5U?=
 =?utf-8?Q?i8ogzz/s9q7q8ZPhr0GNlJ9Ss?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8123bcb-5a8a-494c-2941-08dd6cb89244
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 22:50:13.9588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZzC+7XdEe8+arckePRthOP0LD12rNc2YjVCFSkJm9z1dtUpPM1clpaGBqaONWHjepLlKV7Smqmh1OwuaCMTEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273

DQoNCj4gT24gTWFyIDI2LCAyMDI1LCBhdCA2OjM24oCvUE0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIE1hciAyNCwgMjAyNSBh
dCAwMTowMTo1NFBNIC0wNDAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IFRoZSBwcmV2aW91
cyBwYXRjaCBpbXByb3ZlZCB0aGUgcmN1X3NlcV9kb25lX2V4YWN0KCkgZnVuY3Rpb24gYnkgYWRk
aW5nDQo+PiBhIG1lYW5pbmdmdWwgY29uc3RhbnQgZm9yIHRoZSBndWFyZGJhbmQuDQo+PiANCj4+
IEVuc3VyZSB0aGF0IHRoaXMgaXMgd29ya2luZyBmb3IgdGhlIGZ1dHVyZSBieSBhIHF1aWNrIGNo
ZWNrIGR1cmluZw0KPj4gcmN1X2dwX2luaXQoKS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogSm9l
bCBGZXJuYW5kZXMgPGpvZWxhZ25lbGZAbnZpZGlhLmNvbT4NCj4gDQo+IFRoaXMgaXMgYSBnb29k
IHRlc3QgZm9yIHRoZSBndWFyZGJhbmQgYmVpbmcgd2F5IHRvbyBzaG9ydC4NCg0KVGhhbmtzLiBM
ZXQgbWUga25vdyBpZiBJIGNvdWxkIGFkZCB5b3VyIHJldmlldyB0YWchDQoNCj4gDQo+IEFyZSB0
aGVyZSBvdGhlciB0ZXN0cyB0aGUgc2hvdWxkIGJlIHJ1biwgcG9zc2libHkgb24gYSBzZXBhcmF0
ZSBncF9zZXENCj4gdXNlZCBvbmx5IGZvciB0ZXN0aW5nPyAgU2hvdWxkIHRoZSB0ZXN0IGJlbG93
IGJlIHVuZGVyIENPTkZJR19QUk9WRV9SQ1U/DQoNClllcywgSSBjb3VsZCBtb3ZlIGl0IHRvIFBS
T1ZFIFJDVSBhbmQgaXQgc2hvdWxkIGJlIHN1ZmZpY2llbnQgZm9yIHRlc3RpbmcuDQoNClRoZSBv
dGhlciB0ZXN0IEkgd2FzIHdvcmtpbmcgb24gaXMgdG8gZm9yY2UgdGhlIGNvdW50ZXIgd3JhcHBp
bmcgYW5kIGhlbmNlIGdwd3JhcCB3aGljaCBpcyByZWxhdGVkLiANCg0KTWF5YmUgd2UgY291bGQg
YWxzbyBzb21lIHRlc3RpbmcgYXJvdW5kIGZhbHNlIG5lZ2F0aXZlcyBub3QgaGFwcGVuaW5nIHRv
byBvZnRlbiAoZm9yIGV4YW1wbGVzIHdpdGggdGhlIHJjdV9zZXFfZG9uZSgpKS4NCg0KSSB3aWxs
IGFkZCBtb3JlIHRlc3RzIGlmIEkgY29tZSBhY3Jvc3MgdXNlY2FzZXMuDQoNClRoYW5rcyENCg0K
Sm9lbA0KDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBUaGFueCwgUGF1bA0KPiAN
Cj4+IC0tLQ0KPj4ga2VybmVsL3JjdS90cmVlLmMgfCA1ICsrKysrDQo+PiAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWUu
YyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+PiBpbmRleCA2NTlmODNlNzEwNDguLjI5ZGRiY2JlYTI1
ZSAxMDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jDQo+PiArKysgYi9rZXJuZWwvcmN1
L3RyZWUuYw0KPj4gQEAgLTE3OTgsNiArMTc5OCw3IEBAIHN0YXRpYyBub2lubGluZV9mb3Jfc3Rh
Y2sgYm9vbCByY3VfZ3BfaW5pdCh2b2lkKQ0KPj4gICAgc3RydWN0IHJjdV9kYXRhICpyZHA7DQo+
PiAgICBzdHJ1Y3QgcmN1X25vZGUgKnJucCA9IHJjdV9nZXRfcm9vdCgpOw0KPj4gICAgYm9vbCBz
dGFydF9uZXdfcG9sbDsNCj4+ICsgICAgdW5zaWduZWQgbG9uZyBvbGRfZ3Bfc2VxOw0KPj4gDQo+
PiAgICBXUklURV9PTkNFKHJjdV9zdGF0ZS5ncF9hY3Rpdml0eSwgamlmZmllcyk7DQo+PiAgICBy
YXdfc3Bpbl9sb2NrX2lycV9yY3Vfbm9kZShybnApOw0KPj4gQEAgLTE4MjUsNyArMTgyNiwxMSBA
QCBzdGF0aWMgbm9pbmxpbmVfZm9yX3N0YWNrIGJvb2wgcmN1X2dwX2luaXQodm9pZCkNCj4+ICAg
ICAqLw0KPj4gICAgc3RhcnRfbmV3X3BvbGwgPSByY3Vfc3Jfbm9ybWFsX2dwX2luaXQoKTsNCj4+
ICAgIC8qIFJlY29yZCBHUCB0aW1lcyBiZWZvcmUgc3RhcnRpbmcgR1AsIGhlbmNlIHJjdV9zZXFf
c3RhcnQoKS4gKi8NCj4+ICsgICAgb2xkX2dwX3NlcSA9IHJjdV9zdGF0ZS5ncF9zZXE7DQo+PiAg
ICByY3Vfc2VxX3N0YXJ0KCZyY3Vfc3RhdGUuZ3Bfc2VxKTsNCj4+ICsgICAgLyogRW5zdXJlIHRo
YXQgcmN1X3NlcV9kb25lX2V4YWN0KCkgZ3VhcmRiYW5kIGRvZXNuJ3QgZ2l2ZSBmYWxzZSBwb3Np
dGl2ZXMuICovDQo+PiArICAgIFdBUk5fT05fT05DRShyY3Vfc2VxX2RvbmVfZXhhY3QoJm9sZF9n
cF9zZXEsIHJjdV9zZXFfc25hcCgmcmN1X3N0YXRlLmdwX3NlcSkpKTsNCj4+ICsNCj4+ICAgIEFT
U0VSVF9FWENMVVNJVkVfV1JJVEVSKHJjdV9zdGF0ZS5ncF9zZXEpOw0KPj4gICAgdHJhY2VfcmN1
X2dyYWNlX3BlcmlvZChyY3Vfc3RhdGUubmFtZSwgcmN1X3N0YXRlLmdwX3NlcSwgVFBTKCJzdGFy
dCIpKTsNCj4+ICAgIHJjdV9wb2xsX2dwX3NlcV9zdGFydCgmcmN1X3N0YXRlLmdwX3NlcV9wb2xs
ZWRfc25hcCk7DQo+PiAtLQ0KPj4gMi40My4wDQo+PiANCg==
