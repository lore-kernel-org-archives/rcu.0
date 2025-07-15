Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2111.outbound.protection.outlook.com [40.107.116.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB10026FA62;
	Tue, 15 Jul 2025 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609374; cv=fail; b=eH55HtVQutQiamHLy5UX/buWIn8/hO/po+IsEII9gu+MDYwRvjUPZIrapg3MR8mRMCbEY2nbTSmqxfUbo/TbxHOrxCB91nLu6ZCpf9RbveC2jf1TNv0kEUvaUZZpQOHSmYJp/wymNsZEa5vrlehqfdEcCv8pvoFZ2JTtMMkX6Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609374; c=relaxed/simple;
	bh=CSu+ORD81bnsEELSbktIBQTUhhzfhMYN2IIdhHRuWGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O8Q6MHptrZ77mSaVBWZORNoapthwNe4NfXrrkQyHSAUsa0HTSa/qD+saMQoOBjcTG7s9DUc8z77oDiRtc1Aevyumbd2nmdvlX+yhEFSAYqd30Xvy2rzEs4V8IeLHiqVcxMt5ARTr4cZzuplLYM5GQFcFU/mnfZRQXWZx/umOtVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=TUZ6XCIQ; arc=fail smtp.client-ip=40.107.116.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TUZ6XCIQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTqC/eJfiwC5vmmvQpyUKXyW0OQdt3tAI8utYy1uVbRrkSVfxJBl2km/q+XDdR7z+B6vo2b11+Rn1cgJTl8Qh8tvbV/tEddnJ6t+j061ZtdyRTySetrcE1SZlu3sXGCDS8T5nbbZpYrWKK8iyRMWIF5UKSfjY4lphyLjSk9cxKOLV8+F+3g6mG/XszpctqFpnjVZtpaZRGGFyyFPmGb4fqtkuhn74i4fk3TUR3z2uILsjcKX+uUmOfZEqDccu5Wrp9SSV8zSqXjxwWRRwbK5LObnot47Hcy0lCIrjz54z/BLGeX2djl1vv2ltPv0Qkiou3EuKHNSWCFqW5T55q7c2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfFA7xcOPBPhsjnenqxQtD1MYNWLIRX0kpw2MfOZQrs=;
 b=LrbYl73JWIQM7InSz6aGnnyPZIbCONRQ7q9Ou9Kci8bpcdzfCnFjC9mfGnoN2qCInBO2bO+wfdb2qbQqSLJG8yjgo6GleSp3r6uHsYNC2gfjMK97O43i69b7GRAf8uDzfr6YYkJs544KhJWborLCQPlniYcY2151F8Q3hY7a0W+rh1jaIlhW+jexYyPXHF0vMN0ln/E/cINKBdaBTBSDTd0vdOAhQdZiyiqZqxiq5FBwAi7HM+ZXqzpvURZLVYEHASMGtnySrsYwU5ximh2jImfCAfHrEIyYfZxfWHwRvyg/Hc11xHyudAckyTwmQxMqaMw3kvlYimYJWAqQM+lIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfFA7xcOPBPhsjnenqxQtD1MYNWLIRX0kpw2MfOZQrs=;
 b=TUZ6XCIQGc+54qg4IlxIhOo4VwbnCi71Vj3qktkKaowK6Gj7gwhhx98OOKM4+y31bhT++cbsepsIOVO0ojH2WZ5bWrEjAsR6ndvlPZYmdOr+i59zFYYif0cydfBVi5/qiu4zvbuhAbVD6qypvHc3L0XPjQjIk/9aCKRld/WycHg2ve0yC7xjFETbZFG9PTeCzsIOngqRxzhBEKFEmtLhP71D3OoRc4kLWjdH+iKSN9NJqEq0AaMuiz1/MX38otkHgBaOfS9JCyaPPGHfUNoldeEHsSmDLKR8Qqk1RPTcgXAJzm34CfPu//VceuQJ+Bf+FIfVVDqtFP0Ka1ElpBttyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5965.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:59::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 19:56:08 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 19:56:08 +0000
Message-ID: <5b3558d9-9f4b-4fce-ae09-18310e1a4c22@efficios.com>
Date: Tue, 15 Jul 2025 15:56:06 -0400
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
References: <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
 <20250623104941.WxOQtAmV@linutronix.de>
 <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <ebad20d8-7b04-4c32-97a9-8ae058bdaedc@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ebad20d8-7b04-4c32-97a9-8ae058bdaedc@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0203.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::11) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 76774797-7e2c-48aa-8bae-08ddc3d9a3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vi9hQ2JkMlZvekM1NGhDalc3dXJ5eVlaeVZ4TWV5QXROZWZOV0h1T3hJaTNU?=
 =?utf-8?B?SG9iZTR6dWkvRERvTkpZR0VwVW9Bd096eTNiTGZFMzlsTTZNekZDRk5semxq?=
 =?utf-8?B?eHRnL2VTM3pDR0VvZm1wc25uYzkzRXZaQjU0SXZxQlFEZk8yaEU2RzJBT3R0?=
 =?utf-8?B?M05RelY3YUk3aEE1L0ZaRUZBUVhZOU9GbjQ1MXpRb2NQQlpSa2xHMWw3Rmx5?=
 =?utf-8?B?TGVyR2RUVmdEcER5MUQyNmJoS2dXYXlKbVJZNDBIY2tiM09pMW01WmUzQ1NV?=
 =?utf-8?B?UnBwRXpMeERhQSt5OE56ZmdtRUxxbDBDa1dpRS9xYWhIYmFLc2tjSU5zV2Mz?=
 =?utf-8?B?b3k5U1E5dlkzK1dINC9JRXBpcXRuV0VOUFFXTmZMVXIxVnVnaEV6bWhJdjZh?=
 =?utf-8?B?WFRiakFBdWNLNTlKdEwwNVNvL3ZHSk4yZHhzZHlWOURZcDN0ZUxLR25ncXMr?=
 =?utf-8?B?YVZmOUpFT2xiUHpzN0N5ZWxPdDB5ZS9Pb3RoK1R6M3YxMldTR3pNRGluRG9X?=
 =?utf-8?B?SHgvS2tuRjZjN3Rpbm8wLyt3NW13RG1OUERjUTZqYm41bEx5NDFaeEs4V2J1?=
 =?utf-8?B?cU1yZlF5RitqSUZrRGJGM2w1dnRVRG9RUFBvYWdZUTBDZ29Xc0QzWUExTVE2?=
 =?utf-8?B?aVJxR3BSSmUxRmVrNWtrN3ZQQXpINkRNVHZSbk1YS0dQcHNQRUFZeGF0K1Yr?=
 =?utf-8?B?Zzg1WUcyZFFReFhobnVWTFRDRmFhQ0p5dllLTE91Umt6dGVLTWIzaW8wNXRw?=
 =?utf-8?B?MHlZbnJJZkJSNlF6OGRzS1BvUHZTT3RwRXBJUXBQRWMwNkpaM0VLdzMvcHdl?=
 =?utf-8?B?Ny9nSUFvTXoxUGQ3R1ZSejdHUTJ6L2VkVm13a1U2OFZqRlFTVzVveDkvTzdU?=
 =?utf-8?B?Y2lOci91dkZyekJIVzlGNC9CN1NUQkRDelBYaURqWWUyMStRVW5TOEtoOU5y?=
 =?utf-8?B?NHpqRnpKLzVnMTJub0Rpb0ErdTVxK05kR0NFRUIwZnhIdGNXMk90dmV3WDds?=
 =?utf-8?B?V0QxSHJpeVFWd3lMTndESjJ4WWl2T1NHOTRYMnBZZFA5dHY5akNMZFNWeTlh?=
 =?utf-8?B?MWNFaGZWM3g1WWZOUGdVTzNKMGgvY0EvSUFqNHB2VFphbzhmN0xvOG9ncmxs?=
 =?utf-8?B?a1poTkNqSlBFRTQ0Z29iTG1iejZkbTBtYklreGo0cHZiY21xa3pCdzR0aUZl?=
 =?utf-8?B?bHN0U1l3Wmsxa1lQWmt5SElNSXFvNXhjcU9FRmZKRUM3QlRUeTdsTlV3Qm8x?=
 =?utf-8?B?N2YrTE5kaVBJQ0phVEpSRnNnTjltSjJrSnZlUzVwUDg2MTh4K0hVZWUwUEVh?=
 =?utf-8?B?SVhma2t4MmFGdDBRampuQkFKT0hBazVPNEwxR3RnanJqUVZGMSs1NExFY1Vu?=
 =?utf-8?B?eG40aXRxak5ZeXRpRjJ3U201TlNleHFIblZvRUZVd2s4d25OakNHMzY0Z0Ir?=
 =?utf-8?B?OEpaVkR3QUswai9pTDNhRXl0OU5yem15aWRKUVZNOEo1cDJ5Q1gzWEROdHFM?=
 =?utf-8?B?SlVNRUU5Z05MOWdsTjMzekVmb2JNQ3gyclZaMktLSWI0QldnajFnWmYwY1JB?=
 =?utf-8?B?aXFpZXRydDJyUlQ3bDRxN0RhTms1QlBEQWgweU43NjNocjFYa2NZV3hoK1pM?=
 =?utf-8?B?LzNZbWlWdW80Rnl2RGc5SDJhV0svQTdWYmJ6enNScFRFOTFQc0F0eHNRSk10?=
 =?utf-8?B?alRPK094NzZJNjRIK1BTOHU0R1NGR05ldDNrSExnMUdPWUlPeDEzQjBab0ZM?=
 =?utf-8?B?VHJ2MW50dTVHU3VrWWtkOFM2cDVmMFpaZDh5eTk2V3ZNMmM1a1RHYXZMWE16?=
 =?utf-8?Q?lT1XUFP9uotbSIME1ALUqCsu3SeQr98nXSnJo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU9Xd2NzT2JsZWVVNnFpcWIrTFNnZ1h0QUFGZTZRNEVXT1ZBNVkvdm5RTExr?=
 =?utf-8?B?TEVjZDBiaHVUempWNG5LWDhFbnB6ODdyTklYR3pFV1lRdXJVYmp0T0duSVZE?=
 =?utf-8?B?NUdoVEpnOTJtK3dIcjEzWG1CMVRRVTIvSGR2YVVHSlZpdHZiNHFMS0Fkb1BO?=
 =?utf-8?B?TkM4SnBYdjFIYzdQNjIrU1BOQjJVaTdjTEQ0bE1QT0c1Q0FsOU9Ba0dtTDFD?=
 =?utf-8?B?aTdjTlpKQllHUm12b3BaWWg5dHdmYnFrNE1xelcwRFJiQldlWjc3Rjg3TE9Y?=
 =?utf-8?B?VnZXY0pyMEs5eURVNkNnY3cvUE5rcUY2bmxLanJadW9kQjB3S2pKMVRMZjNl?=
 =?utf-8?B?UDdMQmVoUzRnTFNVTFJkZW1MNk56c0tSM3dLYUU3a2pXVk83SEQycGt3NDhZ?=
 =?utf-8?B?b2piajlnOXZ6dzNhREhrYjBxZmMzWlprRDl2VUkzSGMzTFZSTVQ3UzVsOWNU?=
 =?utf-8?B?dDJZZmJuQmkrby8rK3dCditwb1lJMEJtdFNrVThUY3Vab2c0VnFIQmJxVVgw?=
 =?utf-8?B?STlabmxTTEtFeVI3Rk5udDE3dSthUUZuVVhWMlFSaUZrMGJCL21IVk56bFZ0?=
 =?utf-8?B?dlR3UStLOVgrekZueUEvVmoyeEZObGt4clc4bEtxRUx0WFJ5aUxwdFp2bVov?=
 =?utf-8?B?Vzhsc1M4aHZsWEpkd256Q082cFJaRHZocW9WUlprb3d6ZjI1eThnbFVvVndq?=
 =?utf-8?B?YVp3bklGZWdRbDM3TVh5UTBBZmVQY3R1Q3FScHZFUzNNWU9lV3F3QW4zVGph?=
 =?utf-8?B?VGttelVORWozaXFMd2pTeHRhNnJ1QkdRS09MWVg3NXdEZ2E0cWczdnlLRUlw?=
 =?utf-8?B?V0RYc0w0TXoyY0JQY1BOaFRSYjFhdm1PMjk1R1BjbTZ1L3JpWjZWS3pXZ3F4?=
 =?utf-8?B?b1A0ZFh4WnJMd2tmczhWNGh6ZUUvWkdZZmk4M3dHZTBHb3g2REZqenpmYlVo?=
 =?utf-8?B?N3VUREducUlaMU5tQ1RXekZaNjdBSDZ5TC9Fd0lpek5sWXd0cGNoY3AyMVVs?=
 =?utf-8?B?c2hEU0t6ZE1hejhUaXR1cUFaZDRmUmEwaDhNejVZdXMzcENDdG9wNzYzQzBw?=
 =?utf-8?B?QmhZd1d5emZwT2JMRisrUnlndG1lT0hyVkFFVnkwTHRsbjg0dVZxN2hUWUFh?=
 =?utf-8?B?eWhjbVE5RC9nTUZ2YlRJVHhsa0RYTklBeFQyVkhLbHNLVlNLcnlLc1FGU1VO?=
 =?utf-8?B?TVpQcHBtMzNRZFpOSTJqRmt0bkdKWmV1WC9FdGJuQWlGMmRWaVRDZkpLYkkr?=
 =?utf-8?B?SnZPdXVJeXhVMGlkRUtqVG9NM3NBZEgyMUh6TEJMbUVNQ2J1dC9vamRyWWFs?=
 =?utf-8?B?WXdTcFE4aG9YcDlhK2lQS254ZVg5YWdXd0J2WEIvVzlzVDJhMFpkeHJEZ1Ju?=
 =?utf-8?B?Mk9YQmdlV3dNK2J5WVhtb3hlbDc0QTJ3ejhGaTFxUmxKZXZwOTdqNzh0Nmxa?=
 =?utf-8?B?UnRXczg2bkVpWS9FSS94VGFGZ1RpNHZ4L0J3RlY1TVMyWCt6akErUWlHRUZh?=
 =?utf-8?B?NTNxUU9JVkROQmNyaktSU1RhZzBReHl4dDZRYmJUeHIzRnRHejlnQnpLNEIv?=
 =?utf-8?B?UE9BR3RMWXRvOUxOeG9PeHNRSVlsekNJTlg0VDI0WnNaVnBUcTJiZmhFQWtE?=
 =?utf-8?B?MnFLcnVLUUlQNE1TZzF5a1A3aWJnMU9STnFHaG44RE51NWtGZEhrTnhWcGx6?=
 =?utf-8?B?UXFPTktucEU5QS9VWDZhSWFGbGZpYnlJbzZIa1pTWVlsazRLRktGZ29WalJi?=
 =?utf-8?B?L1RaVGFRT2tpSzd1Z3YwdmZkK0d1RDVIQ0xwYWg3TkcwUGxRTUNYZVBEQjc1?=
 =?utf-8?B?NUd2RUtva0FoOTlEb3hkSHBZZHNxMFh1ZDAyZXRQVGFYSzhWeitucEtuTWJn?=
 =?utf-8?B?TDBaaEhHSEF6U2crdFVVVTBMbzJLTldEMjVpcVBjNmxhV095cDBHUEpsSGpo?=
 =?utf-8?B?dExkZHFFQWlyVUVsMjJBRFpWM1Nza2NtOWwxYmdBbk85Qit5UWc1U1VZc1Mz?=
 =?utf-8?B?TDBybGdLREppcTBkSU5ERzBkRWlSV0p0Y3hKSERJeWF1UUk5RkhYS1FaZWxw?=
 =?utf-8?B?R2ZXU2ZXQmNhYWp4Ylk5blZxZ2tPKzcyNFhKWndvUmRrbktsUW9ZTEtvK0pr?=
 =?utf-8?B?REJXaDNpK05pazhweXZBc2t6cmloVmVMTmgxMDg1NFFRN0hXUmo5WThXOTkv?=
 =?utf-8?Q?Mp+7rRd2PhMiPivaSX8mzCM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76774797-7e2c-48aa-8bae-08ddc3d9a3bf
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:56:08.1021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQnykJbftAYaYAZGKRSddc2+uHoQGRA770unhl92ik1aMC4kf0UABkEa5NJbWSAWyDibC1UxYe86xbC0JfUli3pS9fcQJoLO9n0DagByK78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5965

On 2025-07-14 12:34, Paul E. McKenney wrote:
> On Fri, Jul 11, 2025 at 10:05:26AM -0700, Paul E. McKenney wrote:
>> On Fri, Jul 11, 2025 at 09:46:25AM -0400, Mathieu Desnoyers wrote:
> 
> [ . . . ]
> 
>>> AFAIU the goal here is to turn the guard(preempt_notrace)() into a
>>> guard(rcu_notrace)() because the preempt-off critical sections don't
>>> agree with BPF.
>>
>> OK, got it, thank you!
>>
>> The combination of BPF and CONFIG_PREEMPT_RT certainly has provided at
>> least its share of entertainment, that is for sure.  ;-)
> 
> Is there a similar issue with CONFIG_PREEMPT_LAZY, given that in that
> case rcu_read_unlock() maps to preempt_enable(), which also can invoke
> the scheduler?

I'll have to defer that question to someone who is more familiar than me
with the internals of CONFIG_PREEMPT_LAZY.

Thanks for your vote of confidence though! ;-)

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
