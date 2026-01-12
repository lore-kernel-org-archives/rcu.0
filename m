Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0BA29DB88;
	Mon, 12 Jan 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227650; cv=fail; b=QboEitXDX6xueFHlg24MQC+x1SHSiP6G7q91VGCjOX1FbVUyuV9V6OlL9tgFnBHZR4p5VWaKrkPCHU+Ca7mISmb203s3C+j20BnwZHpZqMunKw5ONQ95zhL79TQQSaXnnm0auwW8SFsE4b0WMcNQuyZjwGqE80kOWcDyhbq2rNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227650; c=relaxed/simple;
	bh=AWMoLyorX43qH3dHmsB00pSsgCFnjl0AWe/Bt33PMog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tPWIFQW4MYysvbN868UWOlKakpVb3hYpgQuQdxHB50VURpPZsoJBjNzKqtzN8OO2K9hiGZ8aTOv4la2SqeEGrqb3KN+rc0yO2WTsWs6jE65Fq8oN3E1SPPAr60O3nykFzxlGiz+TCPzNdocCcaFLGhx57w9ZpxpYbEaVX6faTyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qN5FGWqJ; arc=fail smtp.client-ip=40.107.208.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qN5FGWqJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7vhjZLhbwHCuzczGAJ7EErexd3DytTR0MIdRd6/mQd0+dGqWwFL9qrhNoMb3VMQRRS3uvPZA/CSIgQ/6XYO163dTkKdOlDs7K10UOvGgFKNRBdPnQvLSFAByHXX800G1wfMW60UNMblfa7Jab+cD+6RrQqa2wDQWBihXuvffTm/JOW1X6L4UB72WZBc3Y8kzblHbtaZrCefvYp671X8emxoIEtyRNRv2coOSX5OhCEdkonl6J573GwauPOhveyuHqs/KrRLWtvGO78iutZm1bHB+h2X7dEc/MLHNfewN5Dn2Qamm+ZWcs/crHOMgb6sOkUqhZ3WySnN3TcfMsa/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWMoLyorX43qH3dHmsB00pSsgCFnjl0AWe/Bt33PMog=;
 b=m2b/RL0ZEfyUcqpU+UU7xQuKc7dPZLOqsezEQy0vnyVqTSFur92Lf3ejTmj+SjPd6zfqX47FMFBucrg7/zvawsslvWi7bJ4R/z/k3PG8IDP6XfqUEjoriDli9oItjywBCeIe7z3/Rrysh5fROaYllsANX29Cg4mdYzGNeSCO1HNiaiAF4KlYFT6JmW1MJ4jK0gp1aKadI2091TSwTHsdl4gCHFYosGQsmDjnpHpVQgVZosmR5EvQaI7C3rEUqyfqhnI8cXiS0iBY5+N9NDgYPWMli70BbtgBs9y1I1QyZyVdnqKYiSl//k4t5zuiONZBvTfDFjtBRUpLMWrH5kGFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWMoLyorX43qH3dHmsB00pSsgCFnjl0AWe/Bt33PMog=;
 b=qN5FGWqJFiVPLeHyXx4Tr5dARat2nhoFgl5WSaPBsY8IF4peSmS6hOwmPtmuVR0OE+zcU6H/ttYiYHhzmmm7WruOZiFwSfeLzGLvHTYbMjmwAD/PgxAnaxAr/ytknn+lDx3N3Utvq0E7r9RfyxgplyLMl5U1ekT1eqMClgwKLqRgZpZQpLjlHsN6Ezs1ueNccGZst4HVhA7ERt/A13x1mAxJ+nPefig8CsbjHBS9Rzie7AN7BaE8O2JoxE8mHqvxRN13/+ZJoUJrfOZd8iNHowhbDQnRsLtziGinwsMQfYEwGwgZRZCtktApnDXlfE1Gzf7kYhcXg5h08JRMQOrr5Q==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 14:20:44 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 14:20:44 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
CC: "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "frederic@kernel.org"
	<frederic@kernel.org>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "josh@joshtriplett.org"
	<josh@joshtriplett.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"urezki@gmail.com" <urezki@gmail.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "sshegde@linux.ibm.com"
	<sshegde@linux.ibm.com>, "srikar@linux.ibm.com" <srikar@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Thread-Topic: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Thread-Index: AQHcg6gSQ2wH1CXqL0ua+MpkTxEkB7VOkQWegAAE8a4=
Date: Mon, 12 Jan 2026 14:20:44 +0000
Message-ID: <804E7B47-F515-4592-B12E-84AD251EB07D@nvidia.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <1654BF46-EB82-46C0-B03D-848C22CFAB4F@nvidia.com>
In-Reply-To: <1654BF46-EB82-46C0-B03D-848C22CFAB4F@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|PH8PR12MB6795:EE_
x-ms-office365-filtering-correlation-id: 23d10d88-3463-4cf9-66d5-08de51e5c5d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDhKT3Bha0ZNb09UeXI2MnVmS2tHSzgwcVFRTHFFWXN1ZDh0dWxFbDJwMEVY?=
 =?utf-8?B?Z045aXRWOWEyNGdsR0Rha1Y3Snc2Vy9zL05SNnRKb3BkTUdtTE9nT2RteWto?=
 =?utf-8?B?WTZzdFE3d1lNYVpKUy9wOExpdlk0ZjIyNTJOcE5DaDJHcU1uT0tLcEZuaGZY?=
 =?utf-8?B?RmdCbWt5MzAzbjZveGw0MU9TejJkWkFKbm02R1pMRVpnQlBYZG0vTlZTVC9y?=
 =?utf-8?B?NktTNGI5RXEvSi91MWROK1dsaDBRYnJseUJFQUZWcEFWek5tRi9OWHU1ZFBM?=
 =?utf-8?B?TmpUSXdIbXN6T2N2YlpJeWhxTTZNUWFmUjdnK3FEaVBaVjJsdE5od2Y3ZVNB?=
 =?utf-8?B?dWwvWUpGeXM3dDJaRTlOMGVHN3U5WGlWK0laaU9NeEI0NVFERWxONXRwWEJq?=
 =?utf-8?B?Y2JrR1d0OVhQSkxHM09qVjhJVWFPaXp0Z3NTSFcycjM0TlZZYkJiM1Z1R3Z3?=
 =?utf-8?B?ekFmZXZGRytpN3NCalhuMXdPNXBhM2F5aU1kU3AwTElnbDhSUTl0UlFBN0JL?=
 =?utf-8?B?ZHRnRExuY2ZPSDJycFZaaHdLQ3IwNlpGMWJCWko1YVdhemJneU9WRTF3WFdP?=
 =?utf-8?B?dGVLemxXTXcwekdvalpqUE9Bb0VobU4vVnZBbk9xYmpzQkJCeU9nbTRtdnVV?=
 =?utf-8?B?RTdIU1Z0OVYwR2FIZmFBTlZGMUtJMGIzWlNuaUZNcGNEWlJ1Wi93Unp1bUZs?=
 =?utf-8?B?YzNwYlJRdzFiTTN5b0hSeGVSR25LUi9hN1U0eG9UYzFTK1F3bU1QakNYOGZC?=
 =?utf-8?B?ZmRGV1JFY1IyRWJrdGFVNFR0T2VjM3ZBd0FqL3ZCU09Mdjd4eE9tUHZ1S2RE?=
 =?utf-8?B?OWJva2tMbEtBak0vOHlkaWkwbVRJcnVzMjArOExxdXhGNlY0M1ZSYWZrcTBU?=
 =?utf-8?B?RTBqTEVCaGRiN0pKWHpRNEoyM2lPZ2ZvRk5QQTU2R1poajhKa1VIZkowWlRY?=
 =?utf-8?B?TXVmQXBlUk80NVZOdFI1NURhVVowSmN2SU9ZYmF0NFA2UUUwV0M4ZkFCblR0?=
 =?utf-8?B?bFJ2OUlBbHpqTmJ4Y05DR2dNcTZBV2w0aTZwa1NhVXVrclNhZGVTbktpbFNE?=
 =?utf-8?B?dHZwclpsMFF4dGRtSFduNGxZa2dkYlNHdVZkTzdyemFYOUZQbVdNNS9IQSt2?=
 =?utf-8?B?TDFxVXZvY01taU40WDBqaEl4YmpuaHBlMnJTS0dsbUZFYldibFRCQnFicnlv?=
 =?utf-8?B?R2ZhQWRIdm15alIweS9Hekd4aXNnL0NjUnRucVBqRHZiMlE3K29LM25kRy9Y?=
 =?utf-8?B?TGk2T3ZMclNYODdwR0x6VG5LbHdZOElMdDNpckQvUmdVbnBkTll4Q2k2Vzl4?=
 =?utf-8?B?c0lXalFucjlZcU5mRVNQcGFMY0xmM1BWUEVQaEVXckRZWlY2djBTdDhlN3dC?=
 =?utf-8?B?dzhlWVlOeDB6TkhpRXNmUHRSL2lUa2syeU9na1JyaDE3Z3FpY2I4cE9VU2xz?=
 =?utf-8?B?T0t6S2pXTDFqdEVNNVhEdVYxeExhRzBiMjdmY2E1NURLNFRRQVFUTGpZdDhS?=
 =?utf-8?B?dUNBNkZqTEJGQTIwRkk0OC9QS2N0NWV0cHBSZUlJL1RsMit4NkVIbWY0RE9G?=
 =?utf-8?B?OFdyRlkvaXp5OXMwMGc1UndGUnVwTzcrZitmU3l4S3kvTGtvamZIUFhCRWxW?=
 =?utf-8?B?elcwWVIvVUdmM1dXSWRhMTZOWHF2a0w1QmM1NWF2TElsR05NQ3N4QmlZOW9P?=
 =?utf-8?B?NEtadWRjRFhwRGNnQ3BFSzliWDlwazNGMDRVa3Zhd1pObVRBdlAweWhnR1hW?=
 =?utf-8?B?NktDZ2pGYTdEWGVFeENuNlNuZHpoa2lsM21RcmNmOGM4eUxVSHV4eTQ3UGll?=
 =?utf-8?B?M09TZnRpekdDWFU4aUNmR0ptVTZYZERJaGUwKzVPb3RaYnFpb25JZkE5Qk1R?=
 =?utf-8?B?K0hTUXl5d1k1cjZxdHdISlFzczlOd2NyZ29rMitDU3lOOXVkQWZIbUdrR0ZO?=
 =?utf-8?B?T1Ywbzl6UTB1VitkbW9iRllWME1IclNQcmlEYk5MOHJuV3paTEkxMWVrZWhT?=
 =?utf-8?B?UnNxZ0J2ZGQ4MHFIUVJKRjlSR3VGaUFyOTlCeHZvZy9FTkQ5Tnk4WDAxTit5?=
 =?utf-8?Q?GZyDYm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sm5iZWp1bUp4ZnBZenZtYXpSZUtVRDM4UjBEeXVFaTV3Z1I3dmVBVjUwbTVE?=
 =?utf-8?B?TEcrUlBOcEF3dy95OE15dGd4T0RzbHZqc3hlejFjL1JPVjdrYTBsZE9OWDlk?=
 =?utf-8?B?M1M5YmNWMGJISHlzRitDeVE3SUtEdjNZaFN0cEluRDdjWmhGdlhKVEM1VFlK?=
 =?utf-8?B?cDMxeDA0UjNnaUU4VktOa2RLM2dhZUluSHpFcWJXa2hHM2p3cmtTR1pRZjh5?=
 =?utf-8?B?YVhaL2JzZ0lBbVdmK1NoRDNleGlNYm4ycTlIaFgzN1A4Zy9OY3hYVTRQR1Vj?=
 =?utf-8?B?RStPY3lKdjdSK25vWU51SzRkcGZwUGZZSXppYzNhN3F4bnlFTmZxSUUrS3hR?=
 =?utf-8?B?YUFhRFhkSHhHWjFyeGV0MjNwUGI1RjZLblRFOXFJTitVQUpGQloyYUFuNk13?=
 =?utf-8?B?NFVkcVc2WXZuYUFTajl6ZEM2bWVUNVR1cldGWE01UC9iM0tuK2pmSUo4Ulhm?=
 =?utf-8?B?Mkp1ZWlNblJQM1R0ZU1MT1ZmckVrdWpkVm1oTUgxQjBWaWxlYjhVU0F6dDBo?=
 =?utf-8?B?YkYzdkNHcEZNMU9uc3lVOTBqS3ROOUtlemNDYWRGV2pza3llWHZzeDU3ekNv?=
 =?utf-8?B?T1V5WE5wUWJDSzB3VlppS0YwSUwyNjBYMzN1Nm1HVnozQWlWL2dtWDB0WEFE?=
 =?utf-8?B?S3VFQXBaZ0pEMUVnRUY5MXF0QzQ5Mm1Xcit1Nkw0UUJXalFOeHl5ZGtjcW1W?=
 =?utf-8?B?cjFtSmhTck5kK3k4ejBnM0UrdEhnblkyS01uM3VlNDlTNG5YUnJ0TDhPUHRV?=
 =?utf-8?B?a000UWpIN0hJNUxiMWdlZzcxUDM5QndFRmV0c0RKUHNwVGdsYVpuYWJmd3pI?=
 =?utf-8?B?T1Q3WFpVdGtGRXpQVkpuMzhPcEFmRXJ1NHo3WkZDVTg4SldPNGZGalpFNTZo?=
 =?utf-8?B?WFQ2MXlMV1cvRmY5TnlJNnNxT29lUlFSNCtYTHUyUmZXdlowY2NGdFlaTWVm?=
 =?utf-8?B?ZGllRlp2WktwYUo3cEtPd1gzbWdYTmljbkNyWk1JQmp3ditGdVNPT1kxbEtz?=
 =?utf-8?B?NldvcWFzY0dPUGlGUENYU3F5S3dBaCt5SjdpZFJ4TFZoV2RwK1VUYWFaMXdz?=
 =?utf-8?B?aW5TWlNRUHZpbCtFS2MrWkhSMERBV3BodUYraDhHTjRLRWl6aTA0V29wODlS?=
 =?utf-8?B?ayt6OU0vZHJURDNNUHNNQ0ZISUQwcGlwQlVyay9oTFRBSTZjRmE1ZmRKZnJ5?=
 =?utf-8?B?MUttMEpkdXhBSk9XTExXNUFmR29qSTF2VUd2KzF3bkFTVXExeS9KMmNUNGxR?=
 =?utf-8?B?WXp5dExpekV0YkRwSjR6R0FXVTdRSmM0azZZZit3bTBjc00ycFByVzRxK0xZ?=
 =?utf-8?B?VmYyME8xYzJySGYvN3ZrdnZEUmJKek1NRXczSi9pY29mMUl2cjJlUW95WHFW?=
 =?utf-8?B?bW5lOEo0cThFSnJsNGNlV2huQ21vaGp2cEtIalFVT2diTjBDY2FCWkQ0K3Ra?=
 =?utf-8?B?djU2Z28zQUhER1I5K3JRWjF6bG1yNi8xZjQ1OEM3L2liMmdmVzB6OUo2L1Bv?=
 =?utf-8?B?RjZ5aVFTUVNqTlFhOUxQRFNhc28vc2xlRldXZm9LLzJ1OFVVWEtKNHBLSjBl?=
 =?utf-8?B?NlZMY2pxbFljTThRaVNZc3MwUkZZYi9tUmJObEoxZENOOG9iRzV3ckJUL1pP?=
 =?utf-8?B?cTgxVUl2Z1JEUld3U3ZFVnphSklzYjVUWmdPZFdpcGlHWGRMajlCcEQ3UHRp?=
 =?utf-8?B?OTA4YVpkRGJGa0lzaEUyYVdmU0pTb2hwdS8ra0laeFJtU1Y3SXh5Uyt5U1dN?=
 =?utf-8?B?R21NZFFmR0dXOFJDU0lLdy9QenZuY0RBZW53aDhHY09ud1VQZlJ2TVc5cFZa?=
 =?utf-8?B?am8wMWJzOUFxQXNNVWkrUDVvcGdFZmFwMlZDZ0w0WmphTUFLai9tNXNYdzFW?=
 =?utf-8?B?aWY4ZDJueDZ4NzRDaU9EaDhna2w0dW9QZndRUE16MWhKSDhRQStReStqTDVC?=
 =?utf-8?B?dWt2eHE5UTlXQ0NGWldyZVBWdlp2NkRJVmVPeUMvY2I2Sk1aWllCSHFvR1R2?=
 =?utf-8?B?SDRyTWw3M3FycEc0K3VzWmFlKzBhUkpTZlVUOS9PVldWZjQwSk1DOW9Yejll?=
 =?utf-8?B?SUhzQVU0c0tsazhNdWI1M2cyRkhSVDg2VGcxaWZWWGI0Rm50cnBQNG9vc24x?=
 =?utf-8?B?ajhXZE5UOXVsd2ZhQnhSeitkb3FQTzAyb1J6SU5ZTGUxd0dMOWFnVkp5U3Rl?=
 =?utf-8?B?cTRqT1BNb2dvVVZ0enJUdUpSUkhkOHR1R3BEQ0hIUE9GWmdrSlA5RVJiUXJL?=
 =?utf-8?B?Q3VNZjZoZURFQlowS3RMQmNXTTl1cDlERFlvSzVtY0kxRWFKQlhaR29yMk9h?=
 =?utf-8?B?RldtSTl3R0g4azJkT1ZFdWRmZ2ZQaUFYSzd1YWhLejZzYlNjZ0xKQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d10d88-3463-4cf9-66d5-08de51e5c5d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 14:20:44.1332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhybzJ+K3k2Sg4mYF00zCYbJNtX/3KhkrwahGGhul3Gw9CJRuAFsPgBK4CCsrf3iWKPvUEDDs+ISzaNBQdXCvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795

DQoNCj4gT24gSmFuIDEyLCAyMDI2LCBhdCA5OjAz4oCvQU0sIEpvZWwgRmVybmFuZGVzIDxqb2Vs
YWduZWxmQG52aWRpYS5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+IA0KPj4gT24gSmFuIDEyLCAy
MDI2LCBhdCA0OjQ04oCvQU0sIFZpc2hhbCBDaG91cmFzaWEgPHZpc2hhbGNAbGludXguaWJtLmNv
bT4gd3JvdGU6DQo+PiANCj4+IO+7v0J1bGsgQ1BVIGhvdHBsdWcgb3BlcmF0aW9uc+KAlHN1Y2gg
YXMgc3dpdGNoaW5nIFNNVCBtb2RlcyBhY3Jvc3MgYWxsDQo+PiBjb3Jlc+KAlHJlcXVpcmUgaG90
cGx1Z2dpbmcgbXVsdGlwbGUgQ1BVcyBpbiByYXBpZCBzdWNjZXNzaW9uLiBPbiBsYXJnZQ0KPj4g
c3lzdGVtcywgdGhpcyBwcm9jZXNzIHRha2VzIHNpZ25pZmljYW50IHRpbWUsIGluY3JlYXNpbmcg
YXMgdGhlIG51bWJlcg0KPj4gb2YgQ1BVcyBncm93cywgbGVhZGluZyB0byBzdWJzdGFudGlhbCBk
ZWxheXMgb24gaGlnaC1jb3JlLWNvdW50DQo+PiBtYWNoaW5lcy4gQW5hbHlzaXMgWzFdIHJldmVh
bHMgdGhhdCB0aGUgbWFqb3JpdHkgb2YgdGhpcyB0aW1lIGlzIHNwZW50DQo+PiB3YWl0aW5nIGZv
ciBzeW5jaHJvbml6ZV9yY3UoKS4NCj4+IA0KPj4gRXhwZWRpdGUgc3luY2hyb25pemVfcmN1KCkg
ZHVyaW5nIHRoZSBob3RwbHVnIHBhdGggdG8gYWNjZWxlcmF0ZSB0aGUNCj4+IG9wZXJhdGlvbi4g
U2luY2UgQ1BVIGhvdHBsdWcgaXMgYSB1c2VyLWluaXRpYXRlZCBhZG1pbmlzdHJhdGl2ZSB0YXNr
LA0KPj4gaXQgc2hvdWxkIGNvbXBsZXRlIGFzIHF1aWNrbHkgYXMgcG9zc2libGUuDQo+IA0KPiBX
aGVuIGRvZXMgdGhlIHVzZXIgaW5pdGlhdGUgdGhpcyBpbiB5b3VyIHN5c3RlbT8NCj4gDQo+IEhv
dHBsdWcgc2hvdWxkIG5vdCBiZSBoYXBwZW5pbmcgdGhhdCBvZnRlbiB0byBiZWdpbiB3aXRoLCBp
dCBpcyBhIHNsb3cgcGF0aCB0aGF0DQo+IGRlcGVuZHMgb24gdGhlIGRpc3J1cHRpdmUgc3RvcC1t
YWNoaW5lIG1lY2hhbmlzbS4NCj4gDQo+PiANCj4+IFBlcmZvcm1hbmNlIGRhdGEgb24gYSBQUEM2
NCBzeXN0ZW0gd2l0aCA0MDAgQ1BVczoNCj4+IA0KPj4gKyBwcGM2NF9jcHUgLS1zbXQ9MSAoU01U
OCB0byBTTVQxKQ0KPj4gQmVmb3JlOiByZWFsIDFtMTQuNzkycw0KPj4gQWZ0ZXI6ICByZWFsIDBt
MDMuMjA1cyAgIyB+MjN4IGltcHJvdmVtZW50DQo+PiANCj4+ICsgcHBjNjRfY3B1IC0tc210PTgg
KFNNVDEgdG8gU01UOCkNCj4+IEJlZm9yZTogcmVhbCAybTI3LjY5NXMNCj4+IEFmdGVyOiAgcmVh
bCAwbTAyLjUxMHMgICMgfjU4eCBpbXByb3ZlbWVudA0KPiANCj4gVGhpcyBkb2VzIGxvb2sgY29t
cGVsbGluZyBidXQsIENvdWxkIHlvdSBwcm92aWRlIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgaG93
IHRoaXMgd2FzIHRlc3RlZCAtIHdoYXQgZG9lcyB0aGUgcHBjIGJpbmFyeSBkbyAoaG93IG1hbnkg
aG90IHBsdWdzICwgaG93IGRvZXMgdGhlIHBlcmZvcm1hbmNlIGNoYW5nZSB3aXRoIGN5Y2xlIGNv
dW50IGV0Yyk/DQo+IA0KPiBDYW4geW91IGFsc28gcnVuIHJjdXRvcnR1cmUgdGVzdGluZz8gU29t
ZSBvZiB0aGUgc2NlbmFyaW9zIGxpa2UgVFJFRTAzIHN0cmVzcyBob3RwbHVnLg0KDQpBbHNvLCB3
aHkgbm90IGp1c3QgdXNlIHRoZSBleHBlZGl0ZSBhcGkgYXQgdGhlIGNhbGxzaXRlIHRoYXQgaXMg
c2xvdyB0aGFuIGJsYW5rZXQgZXhwZWRpdGluZyBldmVyeXRoaW5nIGJldHdlZW4gaG90cGx1ZyBs
b2NrIGFuZCB1bmxvY2suICBUaGF0IGlzIG1vcmUgc3BlY2lmaWMgZml4IHRoYW4gdGhpcyBmaXgg
d2hpY2ggYXBwbGllcyBtb3JlIGJyb2FkbHkgdG8gYWxsIG9wZXJhdGlvbnMuIEl0IGFwcGVhcnMg
dGhlIHJlcG9ydCB5b3UgcHJvdmlkZWQgZG9lcyBwcm92aWRlIHRoZSBjdWxwcml0IGNhbGxzaXRl
Lg0KDQogLSBKb2VsDQoNCiANCg0KDQo+IA0KPiB0aGFua3MsDQo+IA0KPiAtIEpvZWwNCj4gDQo+
PiANCj4+IEFib3ZlIG51bWJlcnMgd2VyZSBjb2xsZWN0ZWQgb24gTGludXggNi4xOS4wLXJjNC0w
MDMxMC1nNzU1YmMxMzM1ZTNiDQo+PiANCj4+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvNWYyYWI4YTQ0ZDY4NTcwMWZlMzZjZGFhODA0MmExYWVmMjE1ZDEwZC5jYW1lbEBsaW51eC52
bmV0LmlibS5jb20NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogVmlzaGFsIENob3VyYXNpYSA8dmlz
aGFsY0BsaW51eC5pYm0uY29tPg0KPj4gLS0tDQo+PiBpbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmgg
fCAzICsrKw0KPj4ga2VybmVsL2NwdS5jICAgICAgICAgICAgIHwgMiArKw0KPj4gMiBmaWxlcyBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvcmN1cGRhdGUuaCBiL2luY2x1ZGUvbGludXgvcmN1cGRhdGUuaA0KPj4gaW5kZXggYzViMzAw
NTRjZDAxLi4wM2MwNmNmYjJiNmQgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3JjdXBk
YXRlLmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvcmN1cGRhdGUuaA0KPj4gQEAgLTExOTIsNiAr
MTE5Miw5IEBAIHJjdV9oZWFkX2FmdGVyX2NhbGxfcmN1KHN0cnVjdCByY3VfaGVhZCAqcmhwLCBy
Y3VfY2FsbGJhY2tfdCBmKQ0KPj4gZXh0ZXJuIGludCByY3VfZXhwZWRpdGVkOw0KPj4gZXh0ZXJu
IGludCByY3Vfbm9ybWFsOw0KPj4gDQo+PiArZXh0ZXJuIHZvaWQgcmN1X2V4cGVkaXRlX2dwKHZv
aWQpOw0KPj4gK2V4dGVybiB2b2lkIHJjdV91bmV4cGVkaXRlX2dwKHZvaWQpOw0KPj4gKw0KPj4g
REVGSU5FX0xPQ0tfR1VBUkRfMChyY3UsDQo+PiAgIGRvIHsNCj4+ICAgICAgIHJjdV9yZWFkX2xv
Y2soKTsNCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvY3B1LmMgYi9rZXJuZWwvY3B1LmMNCj4+IGlu
ZGV4IDhkZjJkNzczZmUzYi4uNmIwZDQ5MWQ3M2Y0IDEwMDY0NA0KPj4gLS0tIGEva2VybmVsL2Nw
dS5jDQo+PiArKysgYi9rZXJuZWwvY3B1LmMNCj4+IEBAIC01MDYsMTIgKzUwNiwxNCBAQCBFWFBP
UlRfU1lNQk9MX0dQTChjcHVzX3JlYWRfdW5sb2NrKTsNCj4+IA0KPj4gdm9pZCBjcHVzX3dyaXRl
X2xvY2sodm9pZCkNCj4+IHsNCj4+ICsgICAgcmN1X2V4cGVkaXRlX2dwKCk7DQo+PiAgIHBlcmNw
dV9kb3duX3dyaXRlKCZjcHVfaG90cGx1Z19sb2NrKTsNCj4+IH0NCj4+IA0KPj4gdm9pZCBjcHVz
X3dyaXRlX3VubG9jayh2b2lkKQ0KPj4gew0KPj4gICBwZXJjcHVfdXBfd3JpdGUoJmNwdV9ob3Rw
bHVnX2xvY2spOw0KPj4gKyAgICByY3VfdW5leHBlZGl0ZV9ncCgpOw0KPj4gfQ0KPj4gDQo+PiB2
b2lkIGxvY2tkZXBfYXNzZXJ0X2NwdXNfaGVsZCh2b2lkKQ0KPj4gLS0NCj4+IDIuNTIuMA0KPj4g
DQo=
