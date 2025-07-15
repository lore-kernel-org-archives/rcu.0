Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2090.outbound.protection.outlook.com [40.107.116.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48426F462;
	Tue, 15 Jul 2025 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609252; cv=fail; b=lWnbgRs5OAoCQjT9+Z5hZiN4wFl19UR0VpBGJfaSJmDUR6sy1+HW36i/aZET2rjwUlbDdSEuDxxYb33h7npclSxoEmw72o7M0GoPw5SR4M5+xlBOk4X3qpWgsauFE3m1nzK7ZNmFkzLAqiWmIPMn8bpDcmNkeoR2SuOkb6i6sps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609252; c=relaxed/simple;
	bh=NptfobOHoeRYJryGftDRuJ7P84PnUMaZ2wZ1u2S6LrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZvjGzjtf8ziz27B0xPlFrbn6I3b50dK2mT6CuvLWipzAiAzb9Hg3f0PlUJesEdyMb//XTbEzDD0e5U5OH9sN4yUaYJPq//+5K4ki4Ht6TCJfXbcjDRGhTZzkTmruhfbQofe3O4Tg4XI7QYsnmOoX7hwfyuEYi4fQaf6l0WDYut8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=KcYzZvER; arc=fail smtp.client-ip=40.107.116.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KcYzZvER"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+IVq3Y7Pb2qfNGZmy4uOklBwIhwoTtAXEGfOjChmXF8qWaRPpoC/+zYR3kRYf39w+2xp4bjLvuiYGPJOJFJ15SGDX2KsJycttJSF2aNQBDQCPQ29OrlpI4VQv17mhkKA6gMU67CPJBFA67sipzsWtZ3shKio38nb9WV6qa8tgS5OeRhzVT/OmaRObUtchSnXRr6Kp9BsVkwk0ND6PkJD6GyW52S5DlN6N4kEC2qbM6th572eTyrVl3UTY/WcQH8cTwEi7DIqRrrnmK2f7FsbNmmbE4y7CQcHbC/NRFxhhUtHGPsQBZlodJnpJ6nusUHJOsxqDfJShv0LavT/bICBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvFdvD0qaKQnVuzAwDn8uqdDSZBVDQmMPyRt2BxvBsY=;
 b=E93buULOgbAVsWcvT9n+6Fzo7XFLrMZx+PILcLu4lXX5JgdZe6SQGxcHh+mouKo4XL2LFtomOTFbKN1p/4P8oVPjTnsgKNbIvBJ8jPkL5Y8QvmyxbAu+Rmw0r/213sz4FY0VYFGX8TaGWggiSP/a7dbT4WWqCvGFblpqU5dx03Ozfg4rmplHAPfJuHodpdVj3i+BPg8spRdmJEdbe8YiEznGaPoKIOuw29SfL2m9kkXVaVZ5ZqEIpd+6CfUzGgPFUHV9jYMO9mNj+QiXhkPa8avr47gMR4sRCil5g6j3GOebBN2DBAeSh71aud7c2dBtyqaOPLGNZNxEzChkV7mqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvFdvD0qaKQnVuzAwDn8uqdDSZBVDQmMPyRt2BxvBsY=;
 b=KcYzZvERyIcencrif8jYe6OSQ2162BxAt9GwK8h99RJ9u74AebX0q9KrGcOTZ4weHZmwzZGshFRb17GGa76e4cV90fe5IKwEAQ4dSaFm+lgeOu/PfUbHdzcS624pwby8z/c/pSwqjXDJoApayHm/GRBwg7flFZnjX0afyOyRuKKjgNkS+i9gWdLJjRzrpmZ+wtUrN/QnFFlyfqFMsRMpKF0okdKr3STElJODj8AJmkLtVis4bYO3fHEIAU1Y4LxuAMveoDBY1uXjKLEXjGsDRyspY1086lxaEZFRKLQdKyWS/6PaPaaOc8wW7SzWMAygGsMZBUruDa0Rb+1TUn61kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8830.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 19:54:04 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 19:54:04 +0000
Message-ID: <2bc2c9cd-f1bf-4c9a-b722-256561082854@efficios.com>
Date: Tue, 15 Jul 2025 15:54:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
To: paulmck@kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
References: <20250620084334.Zb8O2SwS@linutronix.de>
 <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
 <20250623104941.WxOQtAmV@linutronix.de>
 <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::28) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: b05fb12a-8f50-48df-0308-08ddc3d95a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aC9ZajRYbThlT2FGamhNS0JOSWx5dVlhSkJuaFpJbFI0WUlJeCtYSElCeE5M?=
 =?utf-8?B?eE5BbHZydkVVK28zS3V4S1dpQlpGNCs2VnpKbmZ2TnMzSENLR0ZYMlVBb1dN?=
 =?utf-8?B?dzZaOW5sRlpqKy9hZEMza00zOGlnVXZNWXJBcVVDRWlwR1ZlckJPeEJrMmkz?=
 =?utf-8?B?S1ZjWFBKNkZRKzZVcTJNci9BRXY0Z2c3NlhnaFY0TE1BQnljUWQzQVlWSmho?=
 =?utf-8?B?dzFJMVRyVlZKQmgwbGpLUkhIMENDeGh0WHZSaXdQVFAvcmFkV3l3UW9mejIz?=
 =?utf-8?B?aTBrdWNLOVBLNmNNeU1vSEJMdDBBd3hUanlvYmEwZDdMK25Ed3FTeUp2QXVz?=
 =?utf-8?B?Z09sV2xhNXJEZVkzQU0ybG5wWlBVaU45VnVvZHZNSGtvbExZcWMvemgvaDZS?=
 =?utf-8?B?U1ZuaHlRVHlmQzdjMlphMUI1ZDJYWGJLdlZrZVFoNlJGR3lPMjBWNlhtdDA2?=
 =?utf-8?B?M0QxQ1VxQnBzSFFPTWRrM1RSQU1zcWkramk2a3F4V0NuZm50MTVXMjBhK25M?=
 =?utf-8?B?dHB5bG1qZGRBUFdmcUtBTWg4cnZreVhHM0pRMFQ5MUY1QUMwQXUvcmloMHdC?=
 =?utf-8?B?MVRXQ25kdW5VdlhOU0p4c3JCK3luT3l1WFdvMU93SHFTeFBRMU1rMGpzTFFU?=
 =?utf-8?B?SFVSQy9ldURyN0hnUEJHUkZ0bnY1ZThJUnBrRjkzYlFiREY1cTlyQnhNc3pt?=
 =?utf-8?B?MTZTK3BVODc0V1NXcWZheVVHejNwR0NUbnBNZDdYbEVpVFBjV1huUE9iWTVC?=
 =?utf-8?B?VlV6dU8wMENvQjF3RmlkZ0VLR3VyeGlpQTRrc0JhU3FpejN5cTJ0TlcrUEFa?=
 =?utf-8?B?MXZxdjJ0dHFRbnRwSVlITTBHWkVrRVJIZU85T09EM1FwRlEyZ0M0UFN1bHMz?=
 =?utf-8?B?ZlhkNTB1aW5XWStDWFZ1VXF3ajZwMDhNbit6SjQ3Uis5Nm9tOE1zYXpHeW41?=
 =?utf-8?B?WkJqUE8wcmJrcTNEb1lldDZMV3lJcDlGYlc0SHF5SHBESHRDTmxmeVVCTkRG?=
 =?utf-8?B?UEN4TzJ2Z1MrQjVscE92bHU3UUt2ci9UUm5pdE12S1ZoK2xrRE9VUlNSVW9x?=
 =?utf-8?B?Z3d5N2FOSUNTR0tLL3FqeGZPekYxSzRvQ1ZNLzFlaVF1TVRGT0FmUlFCdE5T?=
 =?utf-8?B?MWdhOXRPb2NYWXE5QVhsSjBpUVNSVW80d01YU2VXdmsyZkdBUUhSMzhWUHVV?=
 =?utf-8?B?aUg2UFZ2NXJvdFFDdHU5T0FVMGJNaFBDMWVIOUJaVytOSHNXYnJNd2o0NURC?=
 =?utf-8?B?K0NVYlU0aVF2M1J4TXFxcXNPMWlqMkdacVJuWXpFN1BFT2lZc3VxczdPdW1W?=
 =?utf-8?B?S2U1VHUxUEFsakFhZVZhdGxhcFE2TjBMOGxVdXlQK1NBSDBjb2RlNUtxdjcx?=
 =?utf-8?B?Q0dTVmxMZmRZQXk5OUt4SHI2eTZydDA0Zm82Ykp4bUtlc0VldnBTMTRDL1o5?=
 =?utf-8?B?WGE3RkY2RlczUDNtVTRwenlhblZQZkZPNTVaQ0NXSWYvNG0zWk11TElLS0Yz?=
 =?utf-8?B?WlJmNThvQ2k2WDNCeWRFSFI1eTJ4V3BmOVRMZHRwNTkyd1l1NUg2dUd6Y0lN?=
 =?utf-8?B?Y2wxeHFmVXJ6VFp1Y3JiUTRNU0FVUjF4SW94VE5BQjFOQ2htRlVWd0txRGZS?=
 =?utf-8?B?UVJwTExtZ0N0RVl3eHRncFV2dVpmZW1IaUpndEdtYW8xQmNDd0pGZVNGYWxW?=
 =?utf-8?B?N2JBejlweU1jRVhUTGRycXIzdm9YOGFaZFBHZVlFT3FuRzVKZEV6dTlzTVRZ?=
 =?utf-8?B?L2RKeXhlbkwxQ2VSdUpkU2J3ZFphR29pbWlBTS9TWUFLazJZSWR5UkxaWjBy?=
 =?utf-8?Q?W5JLr56ofzbKoWlVMQD9HkeUiNOWYur2xIYq4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXhtWW5kMVdJdmlONG9QTmltZ1U4TEhyWkhSR01ScFh4M21JdElkV1pwZ2pX?=
 =?utf-8?B?cGpuZ1VyYnhmY1lLQXYyenVIMzlmYzFyRlVkcytMaUFFMlFBK3VvcTh5VTF0?=
 =?utf-8?B?VTdDcWRzbGZZSFVCM2MrVG1hQms3YWI1UW5OU2NVbENHY09kZkNwZTk4Zmgv?=
 =?utf-8?B?M3E3aWVneENYSmVSeTBGS3I0a292TzVtYk11NXM5WlVlcHN3dGpwM0ZjRGls?=
 =?utf-8?B?UTdpd3FCS21ieTYwemp6enp0bTJyRjNESjhzYnZTaVpzSGRuWkhldk9DWElD?=
 =?utf-8?B?UVZacjRyTUt2bDdoTE00UVFnalpqL3NPbDBnL080UVBvaVlFSmlQeDhjaHhm?=
 =?utf-8?B?VXM2TUlJa3VwTGw0aG9uNk9iU2c0QWR3TWlyWkVjcUl1blNMK1I2MDdRdndT?=
 =?utf-8?B?UUN3UHZnMEtjbCtiVi9vekxTc2gxV0FwNVVqSGhsczVWNnJmdm5MUFhjalRh?=
 =?utf-8?B?Ym1iRGtiMi9zOEVIS2Y1SkVsOVVoVXNKVDBJSVFkVHNsL2g5UmpnenpFVzdv?=
 =?utf-8?B?NWhzaWp0ZnNkRDBmdG9IT2MzYy9NS3lCalFYTTdZVkdTSkNnS1RDRk94eTlI?=
 =?utf-8?B?VysxbVVWQjI0ZVgxUGxMdWJuQTYxcHpCa3V4ZDlMZVM5TUZJUEhaLzFJQXRy?=
 =?utf-8?B?WmhSRmRWcXdHM2JqbEZGM1VjeEtYK2VEOXRjR09XZTlCZERVSUU2ZnhYTity?=
 =?utf-8?B?MFpNRy9LTW9zYmI4UGRFRDA0bGkwcWJqWU5wM3Z3TW5OajRuLys0cU1OTHVx?=
 =?utf-8?B?Rzgyc3NzMHpIakdKWEwvRzVuMEpqdnZlbUVYQ052MHRxRjJ0MHhBVWdUdjhQ?=
 =?utf-8?B?ekpsUWU4U2c3UldHNCt5NnlUUjAvd08za25aa2VHQmNQNlFTYWZaR1IzYXFj?=
 =?utf-8?B?eHF5WUdNc1drZmJNMFc4U2owNEhyRGh1eGpUN0NQSU13WnJ1N01zcHN2c0hB?=
 =?utf-8?B?MWlxN2paWHYyZ2tOT0c1WDFWUE5LQ0x4Q0w1VktCY0Q2QTRmeVFtOTBwNkNQ?=
 =?utf-8?B?dFlnYnJlZTBBMWYrdzhweisyVXh0aTFzdG1HclYzdDNCWjNiMWZ6Tjg4dkgr?=
 =?utf-8?B?amVraFNzNzJMbFpWZy9SbHh0WGJ3RlN4NGYzWDJoUGRPN25ZODc0MmpITmFQ?=
 =?utf-8?B?VGcyeWF6Mi91MWg1L1JoUzRnckYzNHQybmc3ZFVBcXFCUHZTTHRkeENnNkF1?=
 =?utf-8?B?OWo1TXArT3ZlQTVacWhBWnp6cDlKaFVuTFBQMUoydXdldHlyRUFzRGhGV3oz?=
 =?utf-8?B?TjYzZ0lxR1c1aVFiT0JRdWw2bVJFdVVCQjdyZStkY3I0MVhLbCsyMTB3TWlq?=
 =?utf-8?B?YnNtLzdLR1NIbC9WTjI0K1M3OWxmdGZ3STJhYm9tS0ZxNmtSQTdjc1g0d2xD?=
 =?utf-8?B?S3BMUTRPM2JFdThUeXk4dmUxRHRXN1F4L09WdUFyMmphL2c0TVFCWlgrQTZr?=
 =?utf-8?B?YnJpaHNNZHZDZXhHRDJnUFlTU2VUZnFTVHFqbGgxNkVGUmcwcHhSenJiR0l3?=
 =?utf-8?B?NHJHTENHZFEvV2k4RS95YmRjc3g2QW0rS3ZuaU1Hazk0Q3YycE9wRWRpeE93?=
 =?utf-8?B?aENLMlpUWUNJbytuSFJWK28zSHZGZjhMTDdDSGY4SGtzOW5IdVk1S0tmZ3hM?=
 =?utf-8?B?Unp3Tk9oRXRnK3NSdmQ4SCs1NFVIdXFpSVh1OVl1TWdRNkhCZ0F6eVNDWTR3?=
 =?utf-8?B?a1B2M1F3amRsTGk1QnRkWkhvLzhMNTRnQ2tTR244ckplSUZySFNnY0tsbDRM?=
 =?utf-8?B?RDZGdkxlQ1pKNUNFSE95dDAyM01NME1YRnJlb0w3b1R6dXNSQVc1UWFpSVhk?=
 =?utf-8?B?VDdaR3ZDUnlGblBvT1B5Y0pxY1oxL0Fyb2JsaDMvbmI2OU1FaG5ZYUFCbEp2?=
 =?utf-8?B?ZWhhWW44dXVEL2l4Qy9QQXJjdXVlcnZkaDk2enRneEZROTU5VkY3WklJT2xy?=
 =?utf-8?B?dVBCdWg2d2JrQ1cyTERITEUxdEh3RXE4Tm15Q3NSTlc0SEJTV21yRCtOdlNo?=
 =?utf-8?B?NEh5d3lIYTVKRkhFM1BUam1vby9sSVRsN0xzalk2eHRNdGpqN3VUNWdLTXlT?=
 =?utf-8?B?RCsyS25sN3F2cFFqc3RBWUdyU29JVDJtNDkwcDdhMlJQSXNzdkQyMDVocnZx?=
 =?utf-8?B?YWxNeVE5d0hIRndiSU85VnFKS1c3SXpCU2lCR2x3Wk9uTE1Cb2lDU0FCQkww?=
 =?utf-8?Q?tsNDFK5AqaZsmLa/oGyiADk=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05fb12a-8f50-48df-0308-08ddc3d95a1e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:54:04.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elPR0m9+vQSRNzjFl1WPsBj4jpJ08mqsxKEf3w7Dr6B8FiryEDHGldvNVS+zV92H35EOXB7XceLWRgRWBdmkzpwERRHKi8BuaY4CDoxK8Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8830

On 2025-07-11 13:05, Paul E. McKenney wrote:
> On Fri, Jul 11, 2025 at 09:46:25AM -0400, Mathieu Desnoyers wrote:
>> On 2025-07-09 14:33, Paul E. McKenney wrote:
>>> On Wed, Jul 09, 2025 at 10:31:14AM -0400, Mathieu Desnoyers wrote:
[...]
>>>
>>> Joel's patch, which is currently slated for the upcoming merge window,
>>> should take care of the endless-IRQ-work recursion problem.  So the
>>> main remaining issue is how rcu_read_unlock_special() should go about
>>> safely invoking raise_softirq_irqoff() and irq_work_queue_on() when in
>>> notrace mode.
>>
>> Are those two functions only needed from the outermost rcu_read_unlock
>> within a thread ? If yes, then keeping track of nesting level and
>> preventing those calls in nested contexts (per thread) should work.
> 
> You lost me on this one.
> 
> Yes, these are invoked only by the outermost rcu_read_unlock{,_notrace}().
> And we already have a nexting counter, current->rcu_read_lock_nesting.

But AFAIU those are invoked after decrementing the nesting counter,
right ? So any instrumentation call done within those functions may
end up doing a read-side critical section again.

> 
> However...
> 
> If the tracing invokes an outermost rcu_read_unlock{,_notrace}(), then in
> some contexts we absolutely need to invoke the raise_softirq_irqoff()
> and irq_work_queue_on() functions, both of which are notrace functions.

I guess you mean "both of which are non-notrace functions", otherwise
we would not be having this discussion.

> 
> Or are you telling me that it is OK for a rcu_read_unlock_notrace()
> to directly call these non-notrace functions?

What I am getting at is that it may be OK for the outermost nesting
level of rcu_read_unlock_notrace() to call those non-notrace functions,
but only if we manage to keep track of that nesting level while those
non-notrace functions are called.

So AFAIU one issue here is that when the non-notrace functions are
called, the nesting level is back to 0 already.

> 
>>>>>> - Keep some nesting count in the task struct to prevent calling the
>>>>>>      instrumentation when nested in notrace,
>>>>>
>>>>> OK, for this one, is the idea to invoke some TBD RCU API the tracing
>>>>> exits the notrace region?  I could see that working.  But there would
>>>>> need to be a guarantee that if the notrace API was invoked, a call to
>>>>> this TBD RCU API would follow in short order.  And I suspect that
>>>>> preemption (and probably also interrupts) would need to be disabled
>>>>> across this region.
>>>>
>>>> No quite.
>>>>
>>>> What I have in mind is to try to find the most elegant way to prevent
>>>> endless recursion of the irq work issued immediately on
>>>> rcu_read_unlock_notrace without slowing down most fast paths, and
>>>> ideally without too much code duplication.
>>>>
>>>> I'm not entirely sure what would be the best approach though.
>>>
>>> Joel's patch adjusts use of the rcu_data structure's ->defer_qs_iw_pending
>>> flag, so that it is cleared not in the IRQ-work handler, but
>>> instead in rcu_preempt_deferred_qs_irqrestore().  That prevents
>>> rcu_read_unlock_special() from requeueing the IRQ-work handler until
>>> after the previous request for a quiescent state has been satisfied.
>>>
>>> So my main concern is again safely invoking raise_softirq_irqoff()
>>> and irq_work_queue_on() when in notrace mode.
>>
>> Would the nesting counter (per thread) approach suffice for your use
>> case ?
> 
> Over and above the t->rcu_read_lock_nesting that we already use?
> As in only the outermost rcu_read_unlock{,_notrace}() will invoke
> rcu_read_unlock_special().
> 
> OK, let's look at a couple of scenarios.
> 
> First, suppose that we apply Joel's patch above, and someone sets a trace
> point in task context outside of any RCU read-side critical section.
> Suppose further that this task is preempted in the tracepoint's RCU
> read-side critical section, and that RCU priority boosting is applied.
> 
> This trace point will invoke rcu_read_unlock{,_notrace}(), which
> will in turn invoke rcu_read_unlock_special(), which will in turn
> will note that preemption, interrupts, and softirqs are all enabled.
> It will therefore directly invoke rcu_preempt_deferred_qs_irqrestore(),
> a non-notrace function, which can in turn invoke all sorts of interesting
> functions involving locking, the scheduler, ...
> 
> Is this OK, or should I set some sort of tracepoint recursion flag?

Or somehow modify the semantic of t->rcu_read_lock_nesting if at all
possible. Rather than decrementing it first and then if 0 invoke
a rcu_read_unlock_special, it could perhaps invoke
rcu_read_unlock_special if the nesting counter is _about to be
decremented from 1 to 0_, and then decrement to 0. This would
hopefully prevent recursion.

But I may be entirely misunderstanding the whole problem. If so,
please let me know!

And if for some reason is really needs to be decremented before
calling rcu_read_unlock_special, then we can have the following:
when exiting the outermost critical section, it could be decremented
from 2 to 1, then call rcu_read_unlock_special, after which it's
decremented to 0. The outermost read lock increment would have to
be adapted accordingly. But this would add overhead on the fast-paths,
which may be frowned upon.

The idea here is to keep tracking the fact that we are within the
execution of rcu_read_unlock_special, so it does not call it again
recursively, even though we are technically not nested within a
read-side critical section anymore.

> 
> Second, suppose that we apply Joel's patch above, and someone sets a trace
> point in task context outside of an RCU read-side critical section, but in
> an preemption-disabled region of code.  Suppose further that this code is
> delayed, perhaps due to a flurry of interrupts, so that a scheduling-clock
> interrupt sets t->rcu_read_unlock_special.b.need_qs to true.
> 
> This trace point will invoke rcu_read_unlock{,_notrace}(), which will
> note that preemption is disabled.  If rcutree.use_softirq is set and
> this task is blocking an expedited RCU grace period, it will directly
> invoke the non-notrace function raise_softirq_irqoff().  Otherwise,
> it will directly invoke the non-notrace function irq_work_queue_on().
> 
> Is this OK, or should I set some sort of tracepoint recursion flag?

Invoking instrumentation from the implementation of instrumentation
is a good recipe for endless recursion, so we'd need to check for
recursion somehow there as well AFAIU.

> 
> There are other scenarios, but they require interrupts to be disabled
> across the rcu_read_unlock{,_notrace}(), but to have been enabled somewhere
> in the just-ended RCU read-side critical section.  It does not look to
> me like tracing does this.  But I might be missing something.  If so,
> we have more scenarios to think through.  ;-)

I don't see a good use-case for that kind of scenario though. But I may
simply be lacking imagination.

> 
>>>>>> There are probably other possible approaches I am missing, each with
>>>>>> their respective trade offs.
>>>>>
>>>>> I am pretty sure that we also have some ways to go before we have the
>>>>> requirements fully laid out, for that matter.  ;-)
>>>>>
>>>>> Could you please tell me where in the current tracing code these
>>>>> rcu_read_lock_notrace()/rcu_read_unlock_notrace() calls would be placed?
>>>>
>>>> AFAIU here:
>>>>
>>>> include/linux/tracepoint.h:
>>>>
>>>> #define __DECLARE_TRACE(name, proto, args, cond, data_proto) [...]
>>>>
>>>>           static inline void __do_trace_##name(proto)                     \
>>>>           {                                                               \
>>>>                   if (cond) {                                             \
>>>>                           guard(preempt_notrace)();                       \
>>>>                           __DO_TRACE_CALL(name, TP_ARGS(args));           \
>>>>                   }                                                       \
>>>>           }                                                               \
>>>>           static inline void trace_##name(proto)                          \
>>>>           {                                                               \
>>>>                   if (static_branch_unlikely(&__tracepoint_##name.key))   \
>>>>                           __do_trace_##name(args);                        \
>>>>                   if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {             \
>>>>                           WARN_ONCE(!rcu_is_watching(),                   \
>>>>                                     "RCU not watching for tracepoint");   \
>>>>                   }                                                       \
>>>>           }
>>>>
>>>> and
>>>>
>>>> #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto) [...]
>>>>
>>>>           static inline void __do_trace_##name(proto)                     \
>>>>           {                                                               \
>>>>                   guard(rcu_tasks_trace)();                               \
>>>>                   __DO_TRACE_CALL(name, TP_ARGS(args));                   \
>>>>           }                                                               \
>>>>           static inline void trace_##name(proto)                          \
>>>>           {                                                               \
>>>>                   might_fault();                                          \
>>>>                   if (static_branch_unlikely(&__tracepoint_##name.key))   \
>>>>                           __do_trace_##name(args);                        \
>>>>                   if (IS_ENABLED(CONFIG_LOCKDEP)) {                       \
>>>>                           WARN_ONCE(!rcu_is_watching(),                   \
>>>>                                     "RCU not watching for tracepoint");   \
>>>>                   }                                                       \
>>>>           }
>>>
>>> I am not seeing a guard(rcu)() in here, only guard(preempt_notrace)()
>>> and guard(rcu_tasks_trace)().  Or is the idea to move the first to
>>> guard(rcu_notrace)() in order to improve PREEMPT_RT latency?
>>
>> AFAIU the goal here is to turn the guard(preempt_notrace)() into a
>> guard(rcu_notrace)() because the preempt-off critical sections don't
>> agree with BPF.
> 
> OK, got it, thank you!
> 
> The combination of BPF and CONFIG_PREEMPT_RT certainly has provided at
> least its share of entertainment, that is for sure.  ;-)

There is indeed no shortage of entertainment when combining those rather
distinct sets of requirements. :)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
