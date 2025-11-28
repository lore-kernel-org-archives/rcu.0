Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B663F29E0E6;
	Fri, 28 Nov 2025 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320261; cv=fail; b=O4wzxY7uQ+mlHzAUGLueGWpXCfFe92yFlR3tVdZgb8Fnt9gnGCb+s0xTWS4LUWsthjg4/HsH9lHS7fb2VvNGYBM7BCNcmBwwvuFvYxt4cJ/IH+Dr0xSlOn4dLt02wF6T8faI36eQEZS9m5KE5ngBBozUTXje28gq6rm1BUjCTlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320261; c=relaxed/simple;
	bh=51dbARaI8uIuFRmD0g5YKGCFRQZF/fXF80jY3mGkQGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XvHTDC2hrgw0zKpXNODSGI8Xl9w+r/uHpf2wK/5R+NNLTpswcoB1+mI5PPC8xxZG+k2xfS1gm++Zy4+JLkuyacHDDbeoIMKLGbIahaqSBI3rAhOkW7zGEpxVhoA/+DnPMRS3jwpapVKSNCftFiBEceun+4OKdnddXVNaTxVd6tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SG6aNptw; arc=fail smtp.client-ip=52.101.193.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SG6aNptw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbQNPx+sZtIlGM978Ky7NcaGk6997D5w57NKgF8fsjSWzCxWAXq3LQxkJSwTmZSHE6R5TxccHXPfkAP9AArUxs9UxmdSAz5bFBl2TAMnpuGj6PemfEl32GBh5MydAxNjAqiw/MhtwT4+YX83/holhbhVkTbU/DADXjHkO3+ThhkBJlsssbZ3w+pv1lr60bxmIgS7CTRDwspftLMDNUxchTGWyFUXFrSarFPhMydzhyQWGcYykaZrano5MYEW72h8fnfg1urQFXQgEbNahh9Sc0vIfVy7+DQIujCpNUR7rbQuNPCQzwnMgBUzbm+3d51zsmmXR+CqypEH2neKlmQexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1haSm82u0cDFD0ojdncpatZ4ruISdLbQoBAS3fwaS8=;
 b=PiArZE2B2mcO9T8PjpviZ8BHBRw+UFT5FR3ehTqOQdkATFZeu4qXhqYzu11E+zEF3nETG/kN3kPmQIERcOsgjLymeoIKRlHi7LIvu2yaE2nBBeajH2zzOC7Ll+S0//t24hlNUyPEiUcRe2IyAe9TmlMUlUfuGYJisyiLS7TyvukZSxqvk43ERfkZQ8fw4VbXV94LRHYDM5AJq/x+sEab/dhMGk20oNEEYsoSgcBl3htR1c30BX3fCwGjwpopharGW2ZFh1HwTWvrbkXC5MI5u0ruA2yMNTpgfZd5PwHawptsvjwgil4RWV2EDagNFxZr0Lx9v3WOqWAtwMJtesw0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1haSm82u0cDFD0ojdncpatZ4ruISdLbQoBAS3fwaS8=;
 b=SG6aNptwEdWTSSRv/zSmsifxQjON6VljkfOP7ZjrtFuLHUf3B7kBQXGNUOCHVzpxyAlCIeCqa6wf91qW5KfH28RGwadfp/oZXUf/XuePQeSFuXPVPzFVpfHGMzF/0gZo5mAu92UPlefSWzkqnuPfn4qcPZFkMyaMJT55fXEOC6i5Q3y4bxdqGD9I3JHiIadEotmlz0+4dKxpyIjbKZL/nGBmmyWrMnFgrD1xrCCKBpCs+28qdQFczPzEds4njJXzcM+xBm8BUCb02KjUO5LzL4cMpVgNkJ6EdfVIwymVWCIi8CHDwTlg2wnQgXF7e30wwh0sfqChupSzItjx4xb3+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com (2603:10b6:61f:fc00::629) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Fri, 28 Nov
 2025 08:57:36 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 08:57:36 +0000
Message-ID: <ad9c6f4d-42de-4251-ab10-579feec7e8d1@nvidia.com>
Date: Fri, 28 Nov 2025 08:57:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu()
 operations
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-modules@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>
 <0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org>
 <e988eff6-1287-425e-a06c-805af5bbf262@nvidia.com> <aShFKpqPTgqshx3s@hyeyoo>
 <aShIqdKesZqEOELK@hyeyoo>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <aShIqdKesZqEOELK@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0163.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::6) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddff685-ffcc-432f-35fc-08de2e5c2ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDNrckVoWlFDRTE3S3J1bkxwNFhxUVdoRWdNR0gzUnhFQW1lcmRydFVDS0tY?=
 =?utf-8?B?dkZZS2dTaitwazJMWEo2WjBKSUh0c095RStOTy90bktEZHorTkdhQ1NlVGJ3?=
 =?utf-8?B?dEU0dHlTTjNBRWphOFV3alZiZ0tTUllUYTZyYXl3U0JSK0lFaWxkeHpYT1M2?=
 =?utf-8?B?V1VWZ1BEdjF3UHZPUGdBWndLZUZXYnlMSHZFRnl3NlB6elJtNDQ0MlVzcyt1?=
 =?utf-8?B?WDNJZ2JWTU85RDJ1cW1xWFMvNHNkWmJGZ0pwMjZsajRnOTBFY2xNZkFkY09D?=
 =?utf-8?B?VzRYbndKNnBZTExNVUdxTzhCWUlmVnhQeTU2SFM0L2N2bm1SR3BBamtzZ3lE?=
 =?utf-8?B?a3BuZitsUTlscE50WVpPSjZ1OWJZMDkvUjlYL1BRRU9NL2hUMFFqZ0N1SUVi?=
 =?utf-8?B?Y3prNksvbk8rNkR2K09meGpURngwLzVsOTVDb1dNaTBPSGhaQzM3YXA2WWUz?=
 =?utf-8?B?V0pEcHJWZWE3L2pYdDhuemxTY3RoZG10a2dlSEFUWjFvbUs4SUY5cy95ZTJ4?=
 =?utf-8?B?UXZGZnFzZ2EvSjJ2STNMZ1dsSy9MQThqZ094SGsrOEZ2bHlYNTNyZ1BZS3BM?=
 =?utf-8?B?TE8vV0dYaGtNd3orOGZBL2xQYi9zdnZJQlArS01PYUlJaFRMUEwwdlFVRG41?=
 =?utf-8?B?SnV3TDFFb0ZrWWRNUmRwSDQxQ0IzMXVuWWYwVUUwQnZ1TFUvcUF5WkJyTk1o?=
 =?utf-8?B?eWR3Qm1GeUV6M1FSck81eVcvN0M1MXg2c092dDRLdlpxTSszaHFVWlJMQjNO?=
 =?utf-8?B?R1hyaGJlbTNEMkx5TUZxY3JubGJqWW5YbUxUbXluWlMzWU1Ib3dtVTZXOGxP?=
 =?utf-8?B?bkEvaGQyajUwSE9LN1hINWNqdCtiQ0wzTE1XOXBlNWlDTzgrMTlwYTR0dGdY?=
 =?utf-8?B?cUY2MGlZdEpxMmUzaHFDNnc3cjZoNmtzVHBJYitRby9ja0xRT2FoVUxGU2wy?=
 =?utf-8?B?eko4RDZKZkRsSllNNUNhSGJxbHhJYVJJNHJpaVNsQTFyOGdtUU5Jb0RSWHNF?=
 =?utf-8?B?YkR2SVd3WVJwcmJxMkdlWVd0UG1DKzNvd1N0eE5mMU9uN3BpWXpkZjR5Mzk4?=
 =?utf-8?B?UEJ5L2RqME1mMWJ4dE96VjR4WHROOEdWVlNEK280dENFM2xFKzJiVm1RTC9h?=
 =?utf-8?B?ZE9yZ0ZHd0JkL3Y3cFlkTDY5M2ZSL1hiMEtoMHFmamszZGg2T2ExSytNZytV?=
 =?utf-8?B?QWdHdjJ4RlpvaVBPejZQakJzVE1DVFlCOThTbkZQaHdjOW80UjR0TjFsbnRF?=
 =?utf-8?B?YnpTMWIxeVVEN0FSLzBHbzBXcGpSR3kyMWFGbytKUWhKT1laY0c0TFlUaXY4?=
 =?utf-8?B?UCtWWTRRM0RkNk5odXkydHoxdE8vUkRzZDY2NnFmVDFVcnhrNE5pK0luYWVR?=
 =?utf-8?B?UWh5UmhWeUpxNmhLeHo4OEV5M0k5VmhKZmJPUnFoMkJtZ3RSMWlCY0NKZjR3?=
 =?utf-8?B?bzgrNGhlM2VBSmxRRjlzNmtIeTJWRnhLT2J5QmxFV29aam14cGNqK1h4cGNE?=
 =?utf-8?B?aldQbjRPbmNsYjJwK1ZkRFF4ZEwxY2QvTmYrdTNzL3UrNHo1ODRoZlY0ZWRT?=
 =?utf-8?B?d3pxUFozN0ZZampZS2M2QVhZZjhqQVREYnlneXVXYUIzbkVMdFdFTHFBY2pV?=
 =?utf-8?B?UER5YlRxT0R2QVcxeG1sMzlUdUQzanZ6MlVpREsveXpNblhkQk8vdXpUN3Fn?=
 =?utf-8?B?TkhPUW5hMGdoek16U3lRY2lMUXNvME5hVStVaTVLc3lZTjlQVHAvYXFibG8z?=
 =?utf-8?B?OE83TlNOT3FxY3I4VlA1LzVBeW5BZElZdFJCajhQNk9nRDc2cVRKMS9zV2ds?=
 =?utf-8?B?K1I0R0pmNUpMLzM1TmtXODIvSUhNMGgxc0RWSkZiRVJZQjIrUlJ4eUFaQllI?=
 =?utf-8?B?OTBCaTNEdS9Fd1VOUU9kdFdiQytONDc2S05kVndJRVFyWWhtc2lkcmgxSFRN?=
 =?utf-8?Q?w9/n7oGxqO71Kv3A4jy+9KnFybEXRFGM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVcvQnpOemRKWDE0MHZzL1dZY2IvVC9HM3luQjhMUm92Y1F5WmtDZ3RRZmpC?=
 =?utf-8?B?U282Q2ZnTzIxUzBlbWRPUE9DYWdZOVRsRGtuZm51QWpSemRaQVo1S0djZXAv?=
 =?utf-8?B?Smc5ZkRWZXFWQ0hscitYUG55SmdyYlh5cDh5UUxKcVM0Q2M1OWUzb1BYeHBE?=
 =?utf-8?B?eG90blA2WUhoSDNaUEhTbC83aXFlV2sxd21ZZStPaksyRHV0ZGZRNmNKQW5r?=
 =?utf-8?B?TnFRRjdFc1lnaWpOTHZiS3pUNloxRm9FeVcrRGQ1Yk0yekRRdE1pZU0vV1Uy?=
 =?utf-8?B?cm9RWFV6MTFwNU5qTklZbHIzWk4rZ1V3bEIrLzNRTUlLcE5iVlZsdHNCR2tX?=
 =?utf-8?B?cHpqSzJQYThRK0x0bXdTZUVTVW5Qelgvd3BEWGdxZnk4RHRhQWFGUVQ2Zmdk?=
 =?utf-8?B?NXpHdy8vYWUxcWhqNnRRaStCdTdqREEvdktkb2dMNXVFTmtISlNQc0dNYk1R?=
 =?utf-8?B?MGZqbFVDM2V6NzZqQ0YxSUlPMU9CT1pMbXNuZGE2Q2dodERLVlM2dnQ4NkhZ?=
 =?utf-8?B?K2xJQmkvKy81MmQ0dnlPMDVvZEZDcHBtK3dIN3VHWDNuVkFMMGMvdXZrM2JO?=
 =?utf-8?B?Q09WbkhoYVUzcXJQYUkvT3QvVm83bmcwM2lkYnZLS1k1YnRrekZnb2Q3eWRv?=
 =?utf-8?B?SFJxSVFqWS9WSWtSUE53WEhzTmE5SVdadktwa21pMUxlcXFBczM0c1RoaEZy?=
 =?utf-8?B?MEZRN0lTd3FaRzlJRUdLWXZnVHBrV29NUk5HMlAyenc4MVNHRXVYV213Q0pu?=
 =?utf-8?B?bVB6VFdyT2MzOE1jaUJIdWI0eXlHbnFaZGdWaHJYaHRsbG9HYkJyRnJEUVJ1?=
 =?utf-8?B?Q045L1lDL0JJRXZwU2JUQjIyZmNiUzVldVhsbU5kWGovVEw2aUNvckxEeGxm?=
 =?utf-8?B?Y0Y1QVh5d1YweU15RFFUZ2hYdHRRVmlhMWVOQ2NVd1ZkbGtTNlhyNXZOczd4?=
 =?utf-8?B?NC85SGxsL05VOGNJZEdUMFA3Tm40d1packttcU9IT0ZmODdVN04wcnpTaGtC?=
 =?utf-8?B?QW5wZjRuanEzN3YvWEpWVnBidEY0bWpUZTE1ZWxTOEZGMkhmczRIVmdLVFlC?=
 =?utf-8?B?ZlFkODh0bHZuRWR1cUJxZ01CdWRVZXp5K2tlc2FwWFl5RXhkSWpmdUlweDIr?=
 =?utf-8?B?dm0rb2FwOWN0dnZSUkp6NHBreDZyZEpvUEtHQ0MvMHdRL2VyeVlLY1lIN3B5?=
 =?utf-8?B?R3c3QURlVStaZTdPbCtZLzZIN3N3d3lCSXhRMm40ZHM5NXJRUXZiTnZCZ2Fj?=
 =?utf-8?B?WlJSTVV2OXBYTGwrSWFqOEgwb1lnMmZUOWVLMHpwaWwyamdHTFRjckRlY2xU?=
 =?utf-8?B?TVorUDVXRGpYcTZWRjRJdXZXTjZRUCtWUGF2bElkVHhMOUlhVEYydDZvc0FI?=
 =?utf-8?B?SnBMMlBUQXM1Snh4SlZYTSt2QmkyS3VQRFRWcE5RQzZsaTZ0b1JYWGpQVDlm?=
 =?utf-8?B?clJiU1hWZmo5ZkR5V3FIWkFsVkpHUEw2eGtRV29aSGVidzBoNHN2cHlxcVNV?=
 =?utf-8?B?UTRLQ012djNRb1FFdGZtcnpsbm1KRThUUkhvNll0WTUzaWVmb08wRGs5RW4z?=
 =?utf-8?B?eDArOWVzQUtVSi8wWUtGTVpodTdtT01TOCs1eFJ6RVAvbEh3Ym9Wem1vdVUz?=
 =?utf-8?B?KzNoME90WlBOM0FkdnE2NkF6RldsMEhWR21ZL0NDK0NNWDNSNHJJdkgwR0dh?=
 =?utf-8?B?R0pQTmNldXhnYkZtblNiRzM1UVljOUlhekZsQ1JvK05CazlxZXRrRHFOZmdi?=
 =?utf-8?B?OFZpODhaNTBNLzd2b2kxVkhUZU42YmxzMktHVUpaQXF5d2FjaUVObkxJTURU?=
 =?utf-8?B?ejg4OEF5ZmFqdkNoczFZeXpnalZUUXQ1dGpscXk4QmhKczZHOWRERVZGRS9q?=
 =?utf-8?B?K3RrZWlzZmVHM2t0ak1PUklBQkNpUjBjZHJuOUhvOUlOS2VqK0FKKzRrN2Z0?=
 =?utf-8?B?T1pkdE5yL2NSbS9weGVMSytGL2djd1htelRUeHYrRk50blk4Ny9mdnVYbkhj?=
 =?utf-8?B?OURyYzU1RWU0NGJlQXpzQUlhU2pkQzFXUmJyRmRQQXAvS1VUUGFKZTJFVkhl?=
 =?utf-8?B?NjByT016WTNXS09nYStmcEtjZHFPTjRPSyt1UXN1SkZTWFNlM01uQ0F0OVpr?=
 =?utf-8?B?NXdtRkJZMXZYRWtsZlMzekJ2Q1ZBOGRocDk1YTBKTXFYMFJEN1BIQUlGZzdm?=
 =?utf-8?Q?EaPFWOjCbefc62iSbIG264H+eEvG47KSadHVhXafJS+s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddff685-ffcc-432f-35fc-08de2e5c2ce1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 08:57:36.0569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLgh9GowfTzN8EzSk8PHW5JBOQWCZ+LLtiMC/YzOERDUdRSmGhFp34V2EOGpJGnBZYQVKWneqwILr8C2+Upzuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2


On 27/11/2025 12:48, Harry Yoo wrote:

...

>>> I have been looking into a regression for Linux v6.18-rc where time taken to
>>> run some internal graphics tests on our Tegra234 device has increased from
>>> around 35% causing the tests to timeout. Bisect is pointing to this commit
>>> and I also see we have CONFIG_KVFREE_RCU_BATCHED=y.
>>
>> Thanks for reporting! Uh, this has been put aside while I was busy working
>> on other stuff... but now that we have two people complaining about this,
>> I'll allocate some time to investigate and improve it.
>>
>> It'll take some time though :)
> 
> By the way, how many CPUs do you have on your system, and does your
> kernel have CONFIG_CODE_TAGGING enabled?

For this device there are 12 CPUs. I don't see CONFIG_CODE_TAGGING enabled.

Thanks
Jon

-- 
nvpublic

