Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021105.outbound.protection.outlook.com [52.101.95.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9B33C186;
	Sun, 18 Jan 2026 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768750789; cv=fail; b=QKCaERu6fQcqDUBCVDVzmpDcJH3SFVRU1q0mR/5dnZLG9BARAcjEld2Hfgz+dbWuhV6nx0c4OPbimlAzOg/1IFGDu3XSB6cSN09EIbBbWlG7Ncjumj9Hd3RxeiNegpHV+5VsOXA0JAy14qF02b4ZvQScmXJCTiIC4EQKGs5zRAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768750789; c=relaxed/simple;
	bh=hl5ZHWiVIaJrI5LgxUqoQH2GZCiMS9HfZ4Gq9Y/qq9I=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=OL7vbPEOxzLLiyMPJrBQyvDUe+r2Z4wlkFJAEDMyAMuHIQMw+Vv/dXne8quKfbl6YfVt1dnoMi63Iqgs7KdBh6jGbnen4G+5wl5LfbdWLJWP2SybFZqPWBUzqQM/LEc0easUSXOG1ksHAZBUO8dueRUCPtFJUuX6untozU8ITbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SSDaqS7G; arc=fail smtp.client-ip=52.101.95.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SSDaqS7G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on//+gM/LWdcsCoxUifD1084aWHuXJqlZxFkYrpq3eL/5e6c9VKr1xY+u5l98hon3eeNaQLgtq/62M2RiGawzRQAMCvjeYy59uome7/L9hJFPXBFiXjFOmgRlZW0mHret5J65tOKK5arhpZX8GqOFKuNYYA3599nbEYg7OiVh/wjkAYKRom9Lac+4f6oRgj7eCI1+rBvyQPD0R1FWnfbhGfK9QaMTYtriFuPZt1lalBAujw38OXte6rnhUhnpR/cgXgsloc7RP5dZ5IbeMgq2BBUGa5V4ZXsyIW/0zu7iI4mdCHpwQwS8fmJLlQkSeKDDB6WDQC+TF9wJzzXaBQX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0fbjbHpKURtXtI7ggruh9TzeJRQQZ18sAJJfzEr2Sw=;
 b=De+u+8LkuQ8rkSM48/CBFi9DUTju+Eat56IiIuHxomGz9r8xlYbsKH7Vt8XhkSaZo4zdyKUmISChcCOi7OjTWA4YGckQfepP/Y21UVQ98RICmLq+C+9sgSZgdTovJXbY9+AFP4phQM561pBqdCdQJrG1N28aHvAfBeoG1C+2q7CY5yOrShrDGY+DtFY/RVULk+ltGM+/I5+znsL8/0z/DL8MegKTwT/Sr9NJhTxLJ9zKJDGGvCqD10GV0jiYjoVUM8TVn1ygWvDDl+biqoXPXrakl7Gt+TsVw943M7oeGoMG5XlZfXhdKjBN+WyaxOLYMS807AoY23gCELOmjoGzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0fbjbHpKURtXtI7ggruh9TzeJRQQZ18sAJJfzEr2Sw=;
 b=SSDaqS7GVBpdCCdYt2pc83s5qEO7m4Sum1CURqCVsr5415ZyZnMJTgJoUn3kbfvo2Z5I4kEc6pX4htQh/JHiThq278qqvwDoNZef8xXiyDVht4zoQuJu15vCb8U/iqPnhCh97LO2fN/1pinN2egRk55j1z8cZwJ6yS+q2Rn4tRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2811.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 15:39:41 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.010; Sun, 18 Jan 2026
 15:39:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Jan 2026 15:39:40 +0000
Message-Id: <DFRTTN1T431A.2BLP8QZY02E6Q@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 4/5] rust: sync: atomic: Add Atomic<*mut T> support
X-Mailer: aerc 0.21.0
References: <20260117122243.24404-1-boqun.feng@gmail.com>
 <20260117122243.24404-5-boqun.feng@gmail.com>
 <DFR0Z3KHYS62.37Y0R286DPTUQ@garyguo.net> <aWxfV4Y3fnNR0Kje@tardis-2.local>
In-Reply-To: <aWxfV4Y3fnNR0Kje@tardis-2.local>
X-ClientProxiedBy: LO4P265CA0242.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2811:EE_
X-MS-Office365-Filtering-Correlation-Id: 4379798d-23df-4310-30f6-08de56a7cbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WStsV1hXMGY4R2dXWTIrc0NkSkorazdsR0dJaEdJVTE2VFJuK0tjOXZzdW1D?=
 =?utf-8?B?ekhUQW0yUXgvV0MrVituazhTWUEzd09kNlBHbE80SG0wMmI3dlU4dkZtSlds?=
 =?utf-8?B?ZCt5MXJKRDFWUE1idWVtL0JaWGJ4ZTNYUDR2dkVhSDRPOUFIamdrUk93aThV?=
 =?utf-8?B?bUtxNHh6QlRBSzBBUnRRSDRBZ2ZHbkNUb1FiQU9oQWVZTXhsRlhzU0JRQTVu?=
 =?utf-8?B?RDhCS0VTZ29xY0hMaWl5Nk1HVERPa3ZPbE40MXFuVm5GNldOMG1ta2hvcUpm?=
 =?utf-8?B?UzRjQWRCaHh1QUU3enZyb2xPTEY2VXR4MWFWeEhpNy9ONklSRTdFdGhpS0Np?=
 =?utf-8?B?MGhvV3VPL0p2T2lsRVBmYXIxRkNyaVczSnVjWmp4WStES1ZEbnF4ZVFGdkhI?=
 =?utf-8?B?em9DZ1VDckNBTDh2by9rbmpBZlgvUGpkcUhDMlN5S0RsTFVIMzFyZ0lldmVS?=
 =?utf-8?B?UHBHL05PbnpydXYzdWJ1QlFnUUkwRGhJcWdXTlV2bVVFK3NmcFd2SVVLdDlp?=
 =?utf-8?B?T20vWVh1TVFuU29IRU1zeTkzd1EwNkE2MFYzbGw3bXF4Sk1xZnZUUzlFdkgr?=
 =?utf-8?B?ZU1wQ1VaWW5zcTBIRTlURGFCMU56RHJ2K0szYnVTbzNUVGxmV2tPc2hEMHVW?=
 =?utf-8?B?R09yYWZ3dnFWaTVCVk1ybTR5VE96U2FCSmFwcmJhQWc4aVo0M3FEeVJrOTc2?=
 =?utf-8?B?L2h1MDN4b29zZ0NzQkNsUWdESFlyc1FlbXREYlhFeVBuVnJQcFc4ODhHSTlK?=
 =?utf-8?B?Yk9RUVQxa2ZuRnR5USt3a1YzWmFRa2FBRzEzQ3hNYmF4T3cwQjluTHBXZ25M?=
 =?utf-8?B?dDBZWG8vK0h3QWovT3I0U0ZBUlV4MkpuNDZTa1VzSkNpeDkxckxCTUVFREh4?=
 =?utf-8?B?Y241MkF3aURTa290cll4bnBMemVac3UvYjZhK1V6aUQ2eXRuMHFHYXpMZjdl?=
 =?utf-8?B?UTN5dU9vdHVnNXFFTndBSkdxdDlqVnNEd3JSdlZBVk80cDZNdWRKcnAyakQr?=
 =?utf-8?B?a1c4d25POW1YZU1vY0NITzVnT0dyaldEdnZqdE1aaHpQWVlJYlpDNDRDRUhi?=
 =?utf-8?B?dURVSzMvNTMxQk5JM3NBVURmZUpSV0FSYk0rZG5CUUlZdlE5L1orbzkzeUNS?=
 =?utf-8?B?a1RsVm9PUFNORUNNTkNHN2swUDd2bnBTZitiNWU4aXVZVmM3MFRzbnFnbEVV?=
 =?utf-8?B?V0g4cWtaZ01rSUZVQmRub09ReUgvWW9INUZQclBBcEt2UGxXZ2VQQ05BMllo?=
 =?utf-8?B?UnppckxpcGkyZEIwQUJVT01LV2Yva3VPNjBZV1ZwWnpLSG43MlpEWkZLelYv?=
 =?utf-8?B?eVR5RVJvcW5tNlBjeWJQNkZrVW94eXc1eEhiMnE0YVFJN05aOUtzek15R1Jx?=
 =?utf-8?B?V1ByVTh2LzhnbVIwQ210anRzaFdoRWFVNUtZY3RNTTNJSVhYOWlpQjVaWmc3?=
 =?utf-8?B?SjdWY0h2L0ExMnNsQmlGd2E3bTdnRVlBeVd1ZUU2VUMwTjJ0ZkpHcmFnbURq?=
 =?utf-8?B?bUVrclhFQ2c1ZFFZZDBPanhaUi9OVXBZMUlGRHgvSEdXL1lVRk9DRTA0MjBQ?=
 =?utf-8?B?ejhnc3FncWtyeVQyaVQ4eTUxTjNLVm5XWS9MOG5hQytMVmNsQjNQZkMrVTlw?=
 =?utf-8?B?TFh1Z0dVK0xDMEdBVTBMaWVKMkkvMUhWYjdGQ0JPU0tseUJvUTRNZTFJc2FU?=
 =?utf-8?B?VGFQbGNrSnl2Vi9CN1czeExHS3J1aDQyUTlvK0plQ1VTNHVpOTVyYXIxUzEw?=
 =?utf-8?B?T0k0MTVTOE5ZSWdtdFJMNEpxT3pmQmV4bExmSzQ4cWdQeElBdUZJOGhvVlJv?=
 =?utf-8?B?WTFBald5THlCc29hRWQ0cEljdG8zUEo5Z2ZWUVErU3dBNXhram1lbG9QNXEr?=
 =?utf-8?B?L3N4bjJIM21zR2tsYnduZ1ZaZ3pDSHc2RDBlUW9jNlUzRHliZUJ4RnRUdXhh?=
 =?utf-8?B?TjJYTkhXVi80cUJLcHBsNTVVR3JJL0wybVRDNlBoR0xtWjZPMExNalVpRVNJ?=
 =?utf-8?B?MmVsVzlIbHdxUnlwaHdjTVVlemdmN2NhYnU2dFYrZTJnRFYvTzgrSlE2M2NC?=
 =?utf-8?B?b1EwcmZXeVNUcm04V0FGY2cxd000NWZZdllHcG5LdmYwWGxyWm03Wm03bGE2?=
 =?utf-8?Q?ieZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mmo4MGF3S0Y0WmIrYmRxSVB2amE3UVExTWdHU1QvNURHb1dNN0hzbURMVHVL?=
 =?utf-8?B?REE2VXhnSFI3TElWK05JZkR5YkZFSHB1aUxjMlRmdXdsV3YxNGhjbkd6UWFu?=
 =?utf-8?B?bW1WQkR0OVlxOWRHSEM2RW9Idm54cSsrNG9WaG10Z05ZQUVHT21FcWVTVHFR?=
 =?utf-8?B?YU8wZ1JJV05GVzVTYWNPRFBtMmZENXZnWGVDWFpPS21yMDZISEp2UGlFVzNk?=
 =?utf-8?B?VGI3TUlldkM0ZFdkbUNUR1R5bHZqS1E4R0pxTUFQVnBneTUzcGpBS3FnSjIr?=
 =?utf-8?B?SjhFd2FwVnp3cEp6cDFqV2liMXRrci9nTzZuZEUwT285d2xZNENCZlloTm53?=
 =?utf-8?B?WmNDNkJGVkpRQjVEUml1R3A0VUs3enpHSThhNGhwZ003VGt2bU44a1lwRGQw?=
 =?utf-8?B?aklqak9mNzdFdlVGeGlMeW0wVGF1V3gxa0FNVWQ4bjNhaEwvRzBCMDB2SHhT?=
 =?utf-8?B?YkNUM0RsRjRQK0llbmJ2RVEzRXNRNWZCR0NDUFRyRUpZTXQ0bEZGcnB5Vy9Q?=
 =?utf-8?B?cWNzWWpwc0huUU1vMFFhaThXbGt5UVhKRm9OYm5QRW5IQ2l6OXJZQzIzTVZs?=
 =?utf-8?B?T2p6emJrOTVXYVBUVXBrcGJkbU5pOGxmdHVicU1JdzhZWUloL3pSYnMzZ2Fq?=
 =?utf-8?B?N1NhMElFVS9SdXJFQUhKSnFmeHFlWE5oa2lPUW5xdUtDTjQrTU92bUtscUsy?=
 =?utf-8?B?RERnUnRaUWx0dVZSVmZjNUU3M0c1WFZ6K0cvU3RSaWFVdEgwMEhBMFR1Z2VX?=
 =?utf-8?B?RzhzSFVNNVNOL1VqVGhZNWhaS1pCTXBiRWtSZWlwakVKeHZyN0FSYmtza24w?=
 =?utf-8?B?dEJQeS90b2pxeTJvMjlSajUxeGh4bUh5dmhKM0g4MGdYODlpMnlGVEFzZkE2?=
 =?utf-8?B?aUhsMHlESjkyd0ZGK0RKdURPSG8vQVNoenFkajlZTC9EUVdWSmdscG5QUDFu?=
 =?utf-8?B?c1VRN1NEbXlhVEpYVWZpOEplVG1UckFaQVI1NUc1YUU1NllpMkxYQkI4OTls?=
 =?utf-8?B?d1RVR21WOXNvcXZLTWdXMVVjMWhndTBkc1FEaC8wQmY1MVJYdkRQQWppamFL?=
 =?utf-8?B?TUYySkI4V0dDYlNlWW03WTRJQzFlRitrNnF6S2kxUXZqWkE2UnBCSGZOdnlC?=
 =?utf-8?B?Wkx6WmZmVmVLb3lYL2h4aDFyczMvT3dFZXZ2a28xZ3BzcHlBd2w4cEdwbG1p?=
 =?utf-8?B?YXBKQWRNYTROZjNYc1R4SmhDQkg2SWV1d2Z5bGN2R1FRd1pEKzJVUGpxWlhz?=
 =?utf-8?B?bllZQnVmNHNMYzhhZVpYQnphdHhycGhpQ2N1MTBsS3l3UnlEWW9qTWR2Nk5p?=
 =?utf-8?B?QWNsZk84SUo1SGJQZ25Ba0Q3azRQaXF6czRCTkpyMzJPZlNwcEdqQXRYdHpZ?=
 =?utf-8?B?eCtFYVA2TXdWZlBDS2JUa2xETWN4ZXE3QzBLM0N0RmpUK2RIaGo1dGJHMnJU?=
 =?utf-8?B?NGphVlpmWTNhY2E0VU5ITE5KczJ4WWhiQ2l1UC9xaVRnbm5qbmZOTDUzRFVN?=
 =?utf-8?B?dTR5V0x2WmJqTlVyYURNbys4c0luSFE4SjRWNVdYOEJGeUhVRTFSNzFaeFNB?=
 =?utf-8?B?dFc1OVl2emM1NURQcFdZLzJWbU9wZEUxQUpzVGxmNWpCOUlYU09mZDIvKzVp?=
 =?utf-8?B?ZENybTQ0bVptd1VBdURkRFVoSktOL09TNk9yZFZSL25VR2x1YnQzbGcvalo1?=
 =?utf-8?B?aUtmeEoyV3RxaVc4WlhoaGhGNnpMVlpNWHV0U0gwQitUdCt5b3RTWWZQcDVI?=
 =?utf-8?B?UkNsRkZvdmhhSEdNUWM4Q0NXNmJCRHhwVjMzVkdYWkJCNC9XYVE5TEExRWdp?=
 =?utf-8?B?NUxWd3NwNFg5VUVOZUFXbGNJRnh5WURpNWJhRlR1N2hWRzZjbWNQZXA4czNN?=
 =?utf-8?B?amtRbWlrd3VwN3dPMGR1YkJOZ3p5VSt2OHFjdXZiNzZSd1AyUUdLdlRib212?=
 =?utf-8?B?VGo4dE4wMEZVOEpYSEhqTCtyV3RLRVlIbU9tS2RXRzJQY2lJWHBRbHJxZkZB?=
 =?utf-8?B?Vml6MGtldUJNNUptTmdtMFdUZWVRaEI4Uk84Z0JqUWU3TUdhbjFOMytDQ0VX?=
 =?utf-8?B?T1hQT2hTNW5nOFJ0SEdmZVJzRmVFRUo4YVFjNWVPOTF4a2MvMDRKTVZjOUZn?=
 =?utf-8?B?dVVrUHN0SnFreVArZ0Q4TDNMdTBmWGJ3NVAyWFpIT1RzQm5rMllLVmNvNGZI?=
 =?utf-8?B?ZzBvY2NwT2V4L0JhcFRKSXlnQkJYQSs5ZDJuVlVyZ1M3NGc3Sml1TnNlbUVI?=
 =?utf-8?B?RlJjb3hNZVo2ZWFFSTZaelY0SVg1bTdUNUZGbE5xSHRYam5QSzl0VVFhcmVn?=
 =?utf-8?B?cWIzcStZOVpiWllIRld1cm5mc2laWVlBN3g0UGU4UTI4UjhWa2Y2Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4379798d-23df-4310-30f6-08de56a7cbb4
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 15:39:41.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NpWHMZdW7qW/M4u+xD8bHERYUYg/uEtGAJXHkwav7f64sXT0zFoMOJ19ae0ZbZ7hT+4VjbtyvChm8fY6j90Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2811

On Sun Jan 18, 2026 at 4:19 AM GMT, Boqun Feng wrote:
> On Sat, Jan 17, 2026 at 05:03:15PM +0000, Gary Guo wrote:
>> On Sat Jan 17, 2026 at 12:22 PM GMT, Boqun Feng wrote:
>> > Atomic pointer support is an important piece of synchronization
>> > algorithm, e.g. RCU, hence provide the support for that.
>> >
>> > Note that instead of relying on atomic_long or the implementation of
>> > `Atomic<usize>`, a new set of helpers (atomic_ptr_*) is introduced for
>> > atomic pointer specifically, this is because ptr2int casting would
>> > lose the provenance of a pointer and even though in theory there are a
>> > few tricks the provenance can be restored, it'll still be a simpler
>> > implementation if C could provide atomic pointers directly. The side
>> > effects of this approach are: we don't have the arithmetic and logical
>> > operations for pointers yet and the current implementation only works
>> > on ARCH_SUPPORTS_ATOMIC_RMW architectures, but these are implementatio=
n
>> > issues and can be added later.
>> >
>> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>>=20
>> I am happy that this is now using dedicated helpers for pointers, and no=
t going
>> through an intermediate integer which can lose provenance.
>>=20
>> Some feedbacks below, but in general LGTM.
>>=20
>> Reviewed-by: Gary Guo <gary@garyguo.net>
>>=20
>
> Thanks!
>
>> > ---
>> > diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> [...]
>> > index 4aebeacb961a..4d2a5228c2e4 100644
>> > --- a/rust/kernel/sync/atomic.rs
>> > +++ b/rust/kernel/sync/atomic.rs
>> > @@ -51,6 +51,10 @@
>> >  #[repr(transparent)]
>> >  pub struct Atomic<T: AtomicType>(AtomicRepr<T::Repr>);
>> > =20
>> > +// SAFETY: `Atomic<T>` is safe to transfer between execution contexts=
 because of the safety
>> > +// requirement of `AtomicType`.
>> > +unsafe impl<T: AtomicType> Send for Atomic<T> {}
>> > +
>> >  // SAFETY: `Atomic<T>` is safe to share among execution contexts beca=
use all accesses are atomic.
>> >  unsafe impl<T: AtomicType> Sync for Atomic<T> {}
>> > =20
>> > @@ -68,6 +72,11 @@ unsafe impl<T: AtomicType> Sync for Atomic<T> {}
>> >  ///
>> >  /// - [`Self`] must have the same size and alignment as [`Self::Repr`=
].
>> >  /// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
>> > +/// - [`Self`] must be safe to transfer between execution contexts, i=
f it's [`Send`], this is
>> > +///   automatically satisfied. The exception is pointer types that ar=
e even though marked as
>> > +///   `!Send` (e.g. raw pointers and [`NonNull<T>`]) but requiring `u=
nsafe` to do anything
>> > +///   meaningful on them. This is because transferring pointer values=
 between execution contexts is
>> > +///   safe as long as the actual `unsafe` dereferencing is justified.
>>=20
>> I think the discussion about `Send` on pointers should be moved to the `=
impl<T>
>> AtomicType for *mut T` side.
>>=20
>
> The reason I put something here was to answer the potential question
> "why don't you require AtomicType being a subtrait of Send?", that's
> more of a question for people who read about `AtomicType`, so I figured
> we need some explanation. But I'm fine if you think we should move some
> of the comments to the impl block, or we duplicate some. Although I
> don't think the current version is worse. Considering we do:
>
>     /// - [`Self`] must have the same size and alignment as [`Self::Repr`=
].
>     /// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
>     /// - [`Self`] must be safe to transfer between execution contexts, i=
f it's [`Send`], this is
>     ///   automatically satisfied.
>
> for AtomicType, I'm not sure someone read about `AtomicType` could have
> everything they need to understand why it's not `: Send`.

Ok.

>
> [...]
>> > +// SAFETY:
>> > +//
>> > +// - `*mut T` has the same size and alignment with `*const c_void`, a=
nd is round-trip
>> > +//   transmutable to `*const c_void`.
>> > +// - `*mut T` is safe to transfer between execution contexts. See the=
 safety requirement of
>> > +//   [`AtomicType`].
>> > +unsafe impl<T: Sized> super::AtomicType for *mut T {
>> > +    type Repr =3D *const c_void;
>> > +}
>>=20
>> How about *const T?
>>=20
>
> In general I want to avoid const raw pointers since it provides very
> little extra compared to mut raw pointers. For compiler optimization,
> provenenace is more important than "const vs mut" modifier, for
> dereference, it's unsafe anyway and users need to provide reasoning
> (including knowing the provenance and other accesses may happen to the
> same address), so I feel the type difference of "*const T" vs "*mut T"
> doesn't do anything extra either.
>
> Think about it, in Rust std, there are two pointer types only maps to
> "*mut T": NonNull<T> (as_ptr() returns a `*mut T`) and AtomicPtr<T>
> (as_ptr() returns a `*mut *mut T`). And there is no type like
> NonNullConst<T> and AtomicConstPtr<T>. This is a lint to me that we may
> not need to support `*const T` in most cases.

Actually `NonNull` is internally `*const T`, because it's covariant, unlike
`*mut T` which is invariant.

Now, for atomics, it's less likely that you actually want covariance. So th=
is
difference matters less.

>
> But maybe I'm missing something? If you have a good reason, we can
> obviously add the support for `*const T`.

It just feels that it is somewhat inconsistent. There's no good motivation =
right
now. I am fine to leave it out and add when needed.

Best,
Gary
