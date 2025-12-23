Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3D253340;
	Tue, 23 Dec 2025 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766453598; cv=fail; b=LCPQ27OGophBAm2cNXsXqEcbuyU2Sj4iOE2/anXAfkMnApK7I+i5pn/a6XjBKxPp8sa5EeygjJEBSE+RZFTZsw4PgtEZqj+COWTWGaEEZ3wNXFdDinH+BR7rxVdgNnxM6cFIBSaRxA0ye8Q1/DqL9rKavP4IlSOIU2XEBaP+RhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766453598; c=relaxed/simple;
	bh=Dymoj9QVQbzuuXzmRC25uTCrxqBpNGJ9PyNHlOsSquw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FGmyv/j+xR6ejVkk7AQl4t8j24Vdh15vtkGbWUkLV5+2DW1fmky7dUH4HoDcvWJT1hdW5Gb+HmQx2hwQ7BhyP6qmz7HsR7/sc6XzZPat/LeeuXp5I3PTjpEbAzVzbhFNNTkA+/zmZTtoxosd9O9AkHy5juhbLquOMAed/EN5iNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=goSY2Fye; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="goSY2Fye"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HImEttHGxCDPPEg/btP1RatA4cWsTA6RLV3Wmvo1MdPpKSFB6hkfUfNbfcDdIf7UFeBP5BgUWMApet7BFcVo+tGtk5aHUIJOugXQffkgDrdgyZJt3a+q6Il5X8FCoqiP6g2BBFVuH6zJr4sRKTPt3kWTVTGzRmG5q+712jRQ9Nw//OcL4um1jIOj2GH6OHPjPSwKBEJC9NfjKANF839fMcbCxp0P8iiQJq2NDfhS6pWQEeR2wBFe/KPRm8FhbUZ2CsfykuokbSy9NrWefG4uXer6nGZiWU5VCwwmu77bvztLsmlnxV3iRBUe2PBOT0nXzx2hl9zVEA1elu298tCYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dymoj9QVQbzuuXzmRC25uTCrxqBpNGJ9PyNHlOsSquw=;
 b=aDVzlHaYB31958pNsonhv40avsjd1j4gwVMsVJlkmF3Lrj/pMoGE4TnQbTy25NctdVBuINDD1GLk6P+hTfob0D7q7we7DlIN5hXyLrtLwCM2wNh0gZtgz3LVUB1yM/0hN9y86B2C6nrBltRgSYzbIo3X2D/malvNB/w0zaH6cy+i8j5jfmE0G/CaLZKMiyXT4jEFuZdqxxV5j3ry4Mggb2S/c4hLbGIlAhA1c6NnNE9zGMuOCDhQIpN7xsvRsgazcBL6Fi80BcQMqRNpDboO78TdJwikBmFpDQTYjGBi1n+4QK8pViTkzi/q8Fr0yH+qW8Z4lXzeJaw5Kr4krWULUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dymoj9QVQbzuuXzmRC25uTCrxqBpNGJ9PyNHlOsSquw=;
 b=goSY2FyedoUUX2VYCFWe0Hh4+DNy/up5hZdCj/jqq6yP8Hk46nO+6ibJ0Mpey/MxnDvvlDPNzXisIHRYAD7jaGdvvCLniJez/nCkEgv2vbArPKJS33noZJsA5r3Rr6w+2qDoEfUMWr1TY9HpIjJpcK3kBMWBv1FuE0//VhjG+7zqNGpFCd1yJn1T0Cv6uQCdThfk/96C+8Ts10LZF+zTEtxNxu9vdKDd7XI3LLSPM0bfbT6gLOTd9i61eRDvP9qWgL+ZxdgOhCS4kVb+vQWTYOxzzwxm9X6v6a1+77RnOTXIkbE+qNacwvnO4gf7V3HOK6lizxsRKJ+xmbOt06xO/g==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 01:33:13 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 01:33:12 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
	<neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH RFC] rcu: Reduce synchronize_rcu() latency by reporting GP
 kthread's CPU QS early
Thread-Topic: [PATCH RFC] rcu: Reduce synchronize_rcu() latency by reporting
 GP kthread's CPU QS early
Thread-Index: AQHcc6NfVlNsjz3gNkCx3RPFt8r0abUubbsAgAADMiA=
Date: Tue, 23 Dec 2025 01:33:12 +0000
Message-ID: <67F2A635-B521-4D30-A60B-8DFEAFACBDF0@nvidia.com>
References: <20251223003039.59161-1-joelagnelf@nvidia.com>
 <1d184772-9d39-4c9c-a26e-d6332f630cc1@paulmck-laptop>
In-Reply-To: <1d184772-9d39-4c9c-a26e-d6332f630cc1@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|BL1PR12MB5849:EE_
x-ms-office365-filtering-correlation-id: 9792094a-e226-4391-9e7b-08de41c33ce1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnlsQW9ZWE9PMGFsT3Fmbk9jQldNbURHRVpibHFadFM0WERjSEZZNWVUck44?=
 =?utf-8?B?YXVlcG85VmlRNElJR2ZXRXNBN0c0VGRaUWZWcTNkZ2ozZFZJOWlZRmZCWFBM?=
 =?utf-8?B?OVEwMHo2Ym1ndGFhUE9wM1F3dWM4R1FRRFNKQXBMUjNVYUhxOFVYUXBSSjVZ?=
 =?utf-8?B?Mkc5Rk43ZEFDNGoycU9nbWY2cjJteFk0amZGbnlMdmxlY2ZPVi9oOTlZZzhG?=
 =?utf-8?B?MUMxV2haRk5URGVBeEJlMGtOYjhtUW5ZK2t5OEFzSXd1WkZwaEUyNFR5Vzl3?=
 =?utf-8?B?MmNncjEzN0xGWG50SDlmdzFqVnBWd2FlY0RFT1NuQXFrVTg4VGNoQXNFZzA5?=
 =?utf-8?B?WkEvSTh6QXNmUld4a2xsZGJLd3ovaE9RNTdtWXJsczBBV1Y1Y0JmR1V1Ymcw?=
 =?utf-8?B?aTFzdFFjdEs0ajF1NzE2M1hoSGtETkgzRGY2b0RTRzV3eHc0OEc0cy9qSWVB?=
 =?utf-8?B?M2YwZ3B4Rm5BcDdzQ0J3R0RCN2I3Y0NjUkFtbXcwd3dBWjZTQzVKVFIxQWlz?=
 =?utf-8?B?ckxrbHNCRitid0FrdWRGTFNUcC9IWC85eThGcVBKQzc0NEhTbTNrTHh6emtL?=
 =?utf-8?B?SGVFTjJZUUNQMGY5VmRjOGVlOUhpTEZHamtObWNLVlVmSXI5Ry95aExtckZr?=
 =?utf-8?B?c0JVWDgrT0QrWDZjanJnaG12T2M5T2RhWHhkN2xyNVZpemRUSUl3dWZoRDM2?=
 =?utf-8?B?TTlKdnpBV0lVMktKR0xoem5neHU2cU5yM0hXOVZ5RFBFU2JIbkNhd2M0Y2RT?=
 =?utf-8?B?U3ljbUM2MUpPeFh4VjNabGNpT1B0RlNtR3FjaDVJY3pHZG9OUjlaMmV6WEtG?=
 =?utf-8?B?MFVreDFlZFJGbitsOEFqZGhkZ0d6RVpicFNrcHFrS2JGbmYxZHVrREZUSmt0?=
 =?utf-8?B?a1Z0NC9jRU9DOWluVW1Oc3RRM1RSVWdORllldE5SMFNKQXZsdm0yYitTOC9Q?=
 =?utf-8?B?QWYwbGNvOEdVdlNMU2NkU09KY3VONnJub0E0NGtQYXA3RmxYRFNlbE9rSm9V?=
 =?utf-8?B?TnJjMXFxSUREYXhjbUZJcnY3eFRSWG5uNHVZVmFYK0dUQndPRkFJNTlpeUFp?=
 =?utf-8?B?V0Rqc1dZZDZiUVJ5Qlk5cVRsWnpmRlRQanFLOE1xU3BGQTFlb2xZR20zSGZ3?=
 =?utf-8?B?WkhyVlFzeW5BeExWRkFqSXFPN1Rwd3pxQnhXdUlrSW1WU2lEeGhhKzVJWHFD?=
 =?utf-8?B?UHhlV3ZWWHkrRkhQZlBMOFFQeXBEenV5QlAvdkgxWjczNTFiSWpSbWh1R0Iv?=
 =?utf-8?B?amtYQ3c3M1M1R0U2MVRMOE5GdE9KUzFLdWM2UDVHVUlXdGNBQzFiNjNUVXZk?=
 =?utf-8?B?Qm95d2U0dXZVaUxXMUN6TE4yUElTMmhsNUNOMEdPenRYY29QcUE4V1JNMmxn?=
 =?utf-8?B?NFRjTE5WeEhFNHFyNm52NWZ4RjRDc21xeUtqZGZKcUFRTjB6elBmcGc5TWp4?=
 =?utf-8?B?UHBVT3lLUllKY2RiU0M1cUU1ZzAyMGFsSjVJc1FPdjhydm5INDFJZldUT201?=
 =?utf-8?B?ME1pYzE2Ni9ZYTE2NW9lVnNIai9aMTZETWs0dFE5ODBweVFGMSs0SFBSZ0Za?=
 =?utf-8?B?SHFMRzFVd3pSaUIyK1F3bzBhYUlSb2Z5b1dIRS9rUVZpbG5ydXZ2R0lRWnpx?=
 =?utf-8?B?VFlrZW5pekNtVUNOODM2akxKMUloODBac3pISUtwTUJYUVJaVjk3OWRPaDV6?=
 =?utf-8?B?U09sVHMxVU9yeTEvRnMxeEFjRE1IZHpsMTF2eDVLbUNTczI5b211cjdIK0U0?=
 =?utf-8?B?LzhTemNwQVVXMVZtWlpYUDNNK2x2dVZxUFBwTmpna1VvN2Qzc000alhhcEZ2?=
 =?utf-8?B?bG9velNPUS9oU2toaWpMclpHS1k3YlFCN3Eyc1JYVUJJZ3VRbmo3Vzh5QXlC?=
 =?utf-8?B?L3BTNzJhTkg5dXc4aklNb21KR3poUEtuRFNGb3VBVVBaMDh4Y1NtcFdrVEE1?=
 =?utf-8?B?aTh3MXE4LyswS1FVcyt5ZFRZVkxsK3dlL2VSTzB3T2pCK3dpV2JlcGF1TlNk?=
 =?utf-8?B?QUJZR09UemYxaitlS2VjWm9SV1V6Vm1OZGptUERuOG9wZUMyN1dFVSt0clVL?=
 =?utf-8?Q?yRLdY9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yy90ZUVNOFRrMW4yRlhvWFlPRUNPQVVjRVp1MUZoQUk1NVhvVm5keldTSk5w?=
 =?utf-8?B?Uld5TWJtRkYwdEVVT2NVZ0Y1cUdBc25FeGRkVDV1RlBFL21sTWczUlZtdCts?=
 =?utf-8?B?L3dhY2RwdXRnOGQweDVsQnhLZlFDZzRIYlNxOG1PVmdlWW9nSFRNNkRtY2Z2?=
 =?utf-8?B?Wk5IOGlwSmxPaDREY01zZUhlUlZMM0ZiTkdoaStyd2gwN2l4UjFwd0hseVJJ?=
 =?utf-8?B?MXQvTXlUeXlxN1RScFVaSVBXaUl0REg5ZDhjVjJlYkZRVFBLVTRPRVFKVjMy?=
 =?utf-8?B?TTRhejZXUlBuL0RaRUkrdFJYdDYvRmN0MnBKNEgzbm1pRiszUkxleG5DZGhl?=
 =?utf-8?B?dk5Qd29RSVJ2elh2bkRBZGU1UUMxS1grYmRGZVBuVm1VelRDd3UydS9VNTFQ?=
 =?utf-8?B?U3VyTGJmUjRCNEFRR0NFa2Q2ZDVvd0huZ09TcnBnVlJ6ZVpsdkdTaEpsTlM0?=
 =?utf-8?B?bCs2Y2dlb3JkU21jc29FL1RMeGVvYXl2aGMyZzNtajJKK0NYV2s4WEt1WGpS?=
 =?utf-8?B?anljQXB3WTBJMFMzL3dlTjRJZjZSNjBUU2wzcmRGWG1vdFFDZ2kwRlY2NlBN?=
 =?utf-8?B?a3RwWnNwSzgzTU42M2JBeG00ZGtCOHB2TVBxdDMrMXJkaWQ1T3FSK0djak1X?=
 =?utf-8?B?Z1BUMkZWdmo3d1Jmem9zaGI3bzFTMnZrNUVCYVdaUlhRZUJQMktxam5EbCtI?=
 =?utf-8?B?eENHZEx1K0RXYWtwWmg0ZXowa0pRSFppbUViaTRBMVdKMzRnL0xBMmhNSUZT?=
 =?utf-8?B?bzQ4eklCMk4zZ1EzcEw3aW9ZN0VxSENscWhzNUN5ZHU1TXNad0Y2ZnhDTmNw?=
 =?utf-8?B?QmVDTG1iSHpaSW9vdk5BMVNTcldFbE1NYVlqb2haWlVMbDhRYnptU2xzME1i?=
 =?utf-8?B?OENPbEdLUVNrcUY5VExxUFUzaEl3aEliOSt2d0MwdHJmY2I3bzgxU1dBTHoy?=
 =?utf-8?B?VGdENmlHb1FObkhrVDNhTHdpekMwYkNrdlhoRVhsTW5kRXFkaVhobHJ6cGhB?=
 =?utf-8?B?bFBRZkthb3Y4QnRxYStQR3M0MGtURDZaZkxtbUJWc3lvOXprbjJCYUl0VFAr?=
 =?utf-8?B?dmt2eCtlN205Zlg1a3pPbTJuTDR0VDZBL2U3cXhyTjFVdVR4dGtrSy9BcjdO?=
 =?utf-8?B?NFphVUZrUmxqZTlvUTV4U29ncm02aFpRdGlaZWczcUs1U0NXaUVZNkY3WE8r?=
 =?utf-8?B?UkdZdlFaSExkUVpsZzZ1ZFdscGlpdlNBY3RXNXZyNnBTMjRXbGZlVkVhYjZ0?=
 =?utf-8?B?L0k1ZXhjMEFxT0hoYmtpQ01SbElJZG9UWVFxU003SGFNdzNqT1FQcHNBc2Jt?=
 =?utf-8?B?NHkreUJ0QnJFZ3JvVDFYUGFjSGYvdExJejlXT2puRS9mSElJZ1BQa216aVVk?=
 =?utf-8?B?WWFzbTVJaVlqK1VoUjBoM3hJRHpicFN3Z0hxZi9qTCtLOHFjUk5kUzlCY25j?=
 =?utf-8?B?ZlFPT0pYczlxbW9XenVIMHZMZFdmcGNObXplWEgrSkp5U0F6ZUJCM01HZUFp?=
 =?utf-8?B?eGJ4TFQza1JzeTlic2g1Yi9RMVlqaWNxbjRFRjdtSU0rQjUzcG5TV1o2bzds?=
 =?utf-8?B?TWg0UURPcWpWanhLYTFtTlVsZkxycEx1Q3dpT0MzSUJ5K2RlL1VrY3h1SEh0?=
 =?utf-8?B?NDhZSkVqSUJrOU9sRjdwdGdCWEN2R0FQbWxSNjZBTm5rK2prL1lCOWRQaGc3?=
 =?utf-8?B?ME1LZzcxWEE0QzlXcC9RY1JpNlhhQnRvRjBPbm1pOUZRLzFLdEFpWEJyZVVw?=
 =?utf-8?B?d0cvbjVCM3RVeUhncTNXTlhnQ3hicnJxZnJuWU9FL0VTcDhROEREMU5nYmpE?=
 =?utf-8?B?c0Y1K3VkcTFhL3VRaVloTENnaFFjQ3BidmlhaHRBS1RFVmdhUTcrZEFkTU84?=
 =?utf-8?B?ZmVuWW5CQngwVE1SSXNHSWZmNGppNVNJRzljZHNlK3RiOXRsTVd0Wkh2a2pj?=
 =?utf-8?B?clkzODlCSUZDZEErY2QwamZMNzBBZTVCUld2RHV4NTZmSUxLTHB4bEpVVVM5?=
 =?utf-8?B?NmtmaTB2ek92bDRHaDJWZTBvTlc5ZWJpa3FYNTVXRzNmY2k5dmpPQmI2Zk5Y?=
 =?utf-8?B?bG9GV2xzb1gvOEFvM0gySlZWeU4yT29Nanl5YmZqSFdCWFF2NFJlRFMxRzY0?=
 =?utf-8?B?aEFKWjRLdGhWbDlFQUt4UHRDeThMU0h2azl5b0pBSzJTN3hRbUUwalArWjdC?=
 =?utf-8?B?UGw1WU5LTHdMbEtLRUdEZ3hIU1k0TnJkazZ6Y05ZaUN6SUhrNGhTSlNBaEUx?=
 =?utf-8?B?SzFtWWwvRXAzSHNtclVTOGRRN2pXbWhRcjRWMm9haVdnL0RFeVlpdHBCaGpp?=
 =?utf-8?B?SzlnelduTEVKUmwzTERqa0FYOHRJWWQ5c1JQSTZaVHRYVjY3RmhnQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9792094a-e226-4391-9e7b-08de41c33ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 01:33:12.8659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekCvahHIAH3YgfrRanXI0EPQtR3PhGmBcTPQYjJ+9yD47A4mFVJuA5rIhJaAEvi72EqBBydiGqBNOCmQXg98wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849

DQoNCj4gT24gRGVjIDIyLCAyMDI1LCBhdCA4OjIx4oCvUE0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIERlYyAyMiwgMjAyNSBh
dCAwNzozMDozOVBNIC0wNTAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IFRoZSBSQ1UgZ3Jh
Y2UgcGVyaW9kIG1lY2hhbmlzbSB1c2VzIGEgdHdvLXBoYXNlIEZRUyAoRm9yY2UgUXVpZXNjZW50
DQo+PiBTdGF0ZSkgZGVzaWduIHdoZXJlIHRoZSBmaXJzdCBGUVMgc2F2ZXMgZHludGljay1pZGxl
IHNuYXBzaG90cyBhbmQNCj4+IHRoZSBzZWNvbmQgRlFTIGNvbXBhcmVzIHRoZW0uIFRoaXMgcmVz
dWx0cyBpbiBsb25nIGFuZCB1bm5jZXNzYXJ5IGxhdGVuY3kgZm9yDQo+PiBzeW5jaHJvbml6ZV9y
Y3UoKSBvbiBpZGxlIHN5c3RlbXMgKHR3byBGUVMgd2FpdHMgb2YgfjNtcyBlYWNoIHdpdGggMTAw
MEhaKQ0KPj4gd2hlbmV2ZXIgb25lIEZRUyB3YWl0IHN1ZmZpY2VkLg0KPj4gDQo+PiBTb21lIGlu
dmVzdGlnYXRpb25zIHNob3dlZCB0aGF0IHRoZSBHUCBrdGhyZWFkJ3MgQ1BVIGlzIHRoZSBob2xk
b3V0IENQVQ0KPj4gYSBsb3Qgb2YgdGltZXMgYWZ0ZXIgdGhlIGZpcnN0IEZRUyBhcyAtIGl0IGNh
bm5vdCBiZSBkZXRlY3RlZCBhcyAiaWRsZSINCj4+IGJlY2F1c2UgaXQncyBhY3RpdmVseSBydW5u
aW5nIHRoZSBGUVMgc2NhbiBpbiB0aGUgR1Aga3RocmVhZC4NCj4+IA0KPj4gVGhlcmVmb3JlLCBh
dCB0aGUgc3RhcnQgb2YgdGhlIGZpcnN0IEZRUywgaW1tZWRpYXRlbHkgcmVwb3J0IGEgcXVpZXNj
ZW50DQo+PiBzdGF0ZSBmb3IgdGhlIEdQIGt0aHJlYWQncyBDUFUgdXNpbmcgcmN1X3FzKCkgKyBy
Y3VfcmVwb3J0X3FzX3JkcCgpLiBUaGUNCj4+IEdQIGt0aHJlYWQgY2Fubm90IGJlIGluIGFuIFJD
VSByZWFkLXNpZGUgY3JpdGljYWwgc2VjdGlvbiB3aGlsZSBydW5uaW5nDQo+PiB0aGUgRlFTIHNj
YW4sIHNvIHRoaXMgaXMgc2FmZSBhbmQgcmVzdWx0cyBpbiBzaWduaWZpY2FudCB0YWlsIGxhdGVu
Y3kNCj4+IGltcHJvdmVtZW50cy4NCj4+IA0KPj4gSSBiZW5jaG1hcmtlZCAxMDAgc3luY2hyb25p
emVfcmN1KCkgY2FsbHMsIDYgcnVucyBlYWNoIHNob3dpbmcgZ29vZCB0YWlsDQo+PiBsYXRlbmN5
IGltcHJvdmVtZW50cyBwZXIgc3luY2hyb25pemVfcmN1KCkgY2FsbCAoZGVmYXVsdCBzZXR0aW5n
cyBmb3IgZnFzDQo+PiBqaWZmaWVzKToNCj4+IA0KPj4gQmFzZWxpbmUgKHdpdGhvdXQgZml4KToN
Cj4+IHwgUnVuIHwgTWVhbiAgICAgfCBNaW4gICAgICB8IE1heCAgICAgICB8DQo+PiB8LS0tLS18
LS0tLS0tLS0tLXwtLS0tLS0tLS0tfC0tLS0tLS0tLS0tfA0KPj4gfCAxICAgfCA0LjAzNiBtcyB8
IDMuNTA5IG1zIHwgNy45NzMgbXMgIHwNCj4+IHwgMiAgIHwgNC4wNDkgbXMgfCAzLjkwNCBtcyB8
IDguMDAzIG1zICB8DQo+PiB8IDMgICB8IDQuMDMzIG1zIHwgMS4xNjAgbXMgfCAxMC4wODMgbXMg
fA0KPj4gfCA0ICAgfCAzLjk5MyBtcyB8IDMuMTQ1IG1zIHwgNC4wOTMgbXMgIHwNCj4+IHwgNSAg
IHwgMy45ODggbXMgfCAyLjY3NSBtcyB8IDQuMTIzIG1zICB8DQo+PiB8IDYgICB8IDQuMDE5IG1z
IHwgMy44OTQgbXMgfCA1Ljg0NSBtcyAgfA0KPj4gDQo+PiBXaXRoIGZpeDoNCj4+IHwgUnVuIHwg
TWVhbiAgICAgfCBNaW4gICAgICB8IE1heCAgICAgIHwNCj4+IHwtLS0tLXwtLS0tLS0tLS0tfC0t
LS0tLS0tLS18LS0tLS0tLS0tLXwNCj4+IHwgMSAgIHwgMy45OTEgbXMgfCAyLjk1MyBtcyB8IDQu
MTI1IG1zIHwNCj4+IHwgMiAgIHwgMy45OTUgbXMgfCAzLjQzOSBtcyB8IDQuMDgxIG1zIHwNCj4+
IHwgMyAgIHwgMy45ODkgbXMgfCAyLjk3NCBtcyB8IDQuMDc5IG1zIHwNCj4+IHwgNCAgIHwgMy45
OTcgbXMgfCAzLjY2NyBtcyB8IDQuMDcyIG1zIHwNCj4+IHwgNSAgIHwgNC4wMjcgbXMgfCAyLjU1
MCBtcyB8IDcuOTI4IG1zIHwNCj4+IHwgNiAgIHwgMy45ODkgbXMgfCAyLjg4NiBtcyB8IDQuMDc2
IG1zIHwNCj4+IA0KPj4gVGhlIGZpeCByZWR1Y2VzIHdvcnN0LWNhc2UgbGF0ZW5jeSBkdWUgdG8g
dGhlIHNlY29uZCBGUVMgd2FpdCBub3QNCj4+IHJ1bm5pbmcgd2hlbiBub3QgbmVlZGVkLg0KPj4g
DQo+PiBUZXN0ZWQgcmN1dG9ydHVyZSBUUkVFIGFuZCBTUkNVIGNvbmZpZ3VyYXRpb25zLg0KPj4g
DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2VsIEZlcm5hbmRlcyA8am9lbGFnbmVsZkBudmlkaWEuY29t
Pg0KPiANCj4gTmljZSByZXN1bHRzISEhDQoNClRoYW5rcyENCg0KPiANCj4gQnV0IHdoeSBub3Qg
ZG8gdGhpcyBhdCB0aGUgZW5kIG9mIHJjdV9ncF9pbml0KCk/DQoNClllcyB0aGF0IGlzIGJldHRl
ciwgSSB3aWxsIGdpdmUgdGhhdCBhIHRyeS4gVGhhbmtzLA0KDQogLSBKb2VsDQoNCg0KPiANCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgVGhhbngsIFBhdWwNCj4gDQo+PiAtLS0NCj4+IGtl
cm5lbC9yY3UvdHJlZS5jIHwgMTIgKysrKysrKysrKysrDQo+PiAxIGZpbGUgY2hhbmdlZCwgMTIg
aW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlLmMgYi9r
ZXJuZWwvcmN1L3RyZWUuYw0KPj4gaW5kZXggODI5M2JhZTFkZWMxLi5jMTE2ZWQ3NjMzZDMgMTAw
NjQ0DQo+PiAtLS0gYS9rZXJuZWwvcmN1L3RyZWUuYw0KPj4gKysrIGIva2VybmVsL3JjdS90cmVl
LmMNCj4+IEBAIC0xNjAsNiArMTYwLDcgQEAgc3RhdGljIHZvaWQgcmN1X3JlcG9ydF9xc19ybnAo
dW5zaWduZWQgbG9uZyBtYXNrLCBzdHJ1Y3QgcmN1X25vZGUgKnJucCwNCj4+ICAgICAgICAgICAg
ICAgICAgdW5zaWduZWQgbG9uZyBncHMsIHVuc2lnbmVkIGxvbmcgZmxhZ3MpOw0KPj4gc3RhdGlj
IHZvaWQgaW52b2tlX3JjdV9jb3JlKHZvaWQpOw0KPj4gc3RhdGljIHZvaWQgcmN1X3JlcG9ydF9l
eHBfcmRwKHN0cnVjdCByY3VfZGF0YSAqcmRwKTsNCj4+ICtzdGF0aWMgdm9pZCByY3VfcmVwb3J0
X3FzX3JkcChzdHJ1Y3QgcmN1X2RhdGEgKnJkcCk7DQo+PiBzdGF0aWMgdm9pZCBjaGVja19jYl9v
dmxkX2xvY2tlZChzdHJ1Y3QgcmN1X2RhdGEgKnJkcCwgc3RydWN0IHJjdV9ub2RlICpybnApOw0K
Pj4gc3RhdGljIGJvb2wgcmN1X3JkcF9pc19vZmZsb2FkZWQoc3RydWN0IHJjdV9kYXRhICpyZHAp
Ow0KPj4gc3RhdGljIGJvb2wgcmN1X3JkcF9jcHVfb25saW5lKHN0cnVjdCByY3VfZGF0YSAqcmRw
KTsNCj4+IEBAIC0yMDMyLDYgKzIwMzMsMTcgQEAgc3RhdGljIHZvaWQgcmN1X2dwX2Zxcyhib29s
IGZpcnN0X3RpbWUpDQo+PiAgICB9DQo+PiANCj4+ICAgIGlmIChmaXJzdF90aW1lKSB7DQo+PiAr
ICAgICAgICAvKg0KPj4gKyAgICAgICAgICogSW1tZWRpYXRlbHkgcmVwb3J0IFFTIGZvciB0aGUg
R1Aga3RocmVhZCdzIENQVS4gVGhlIEdQIGt0aHJlYWQNCj4+ICsgICAgICAgICAqIGNhbm5vdCBi
ZSBpbiBhbiBSQ1UgcmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb24gd2hpbGUgcnVubmluZw0KPj4g
KyAgICAgICAgICogdGhlIEZRUyBzY2FuLiBUaGlzIGVsaW1pbmF0ZXMgdGhlIG5lZWQgZm9yIGEg
c2Vjb25kIEZRUyB3YWl0DQo+PiArICAgICAgICAgKiB3aGVuIGFsbCBDUFVzIGFyZSBpZGxlLg0K
Pj4gKyAgICAgICAgICovDQo+PiArICAgICAgICBwcmVlbXB0X2Rpc2FibGUoKTsNCj4+ICsgICAg
ICAgIHJjdV9xcygpOw0KPj4gKyAgICAgICAgcmN1X3JlcG9ydF9xc19yZHAodGhpc19jcHVfcHRy
KCZyY3VfZGF0YSkpOw0KPj4gKyAgICAgICAgcHJlZW1wdF9lbmFibGUoKTsNCj4+ICsNCj4+ICAg
ICAgICAvKiBDb2xsZWN0IGR5bnRpY2staWRsZSBzbmFwc2hvdHMuICovDQo+PiAgICAgICAgZm9y
Y2VfcXNfcm5wKHJjdV93YXRjaGluZ19zbmFwX3NhdmUpOw0KPj4gICAgfSBlbHNlIHsNCj4+IC0t
DQo+PiAyLjM0LjENCj4+IA0K
