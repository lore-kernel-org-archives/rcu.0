Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4369119580A;
	Fri,  9 Aug 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212414; cv=fail; b=nX6ImQLEQCBbDjVkEBFAzYctw3ToayZ9ioTNOoT9+h5fil8PhYeXNh2ZU/PJHfvwXstLaRkR1Y4iJ2jD/4ycdf9jFld4dJ9y+on4TY7TBMdDxAONzqCzDBrt++i/Sd7Y9YrbYcSovY55Rro5iMcG/3TmQRdBzzjFIAiQJHNxfrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212414; c=relaxed/simple;
	bh=oz7l/m29L/9e84f3QGJneuCEL2zgo5WYc6YxH2KsLTY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PIrk1GoHz8aCJd7uZUWnNv1/iJec89QMaH/2ss0vl7NrgaY8dcsdF+Skj44+t1JKaj+o7C5jtAaUrsW+q1/emotNsZgnEnWdAOpomxspfURHAqp8JO0Z/sjl++HZFWrw7i5g4ze5d+1bQsJOvIBK+4fgGpV46gsB79PkWxqs0hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=RHOGF280; arc=fail smtp.client-ip=40.107.247.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="RHOGF280"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lM/9Ru5Lo+AG07Ez4RIe0BI3LfZ061vD+FM2p/CMo1C4XVNryYjGZjKexW2sovLwQ3zquwlvi3yfo2zj2ddb3wIkbPDpvyaOGB4MTgLZhfWEILnFd7U109ZkvNZbm96IJm5VMbzM7HXQEqLVL/cc9C0nGb9z7Lx5pZnr+XQNf0TBWyAzKmbUcA5vThZiYaIqE/9gj7b8e/2zQvzufEMaSUv3tOCNtjX0Pfx7A8tIrxVfEqAPqNCAf2qPa2iynKxlJqYWqyizr4nLu274cwyQE+Ax+m2poNKxgXvB0cK1TiQtYa4366HpN4/uLluNgY80Ak0WxS/fMf+YSocaCOBYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn9frKcqPinMB7KOqoXh2qe5zdr30r8xbXrzy5HJGB0=;
 b=hVdOOZukYH9gisBSq9VgAdQN1+EkL4PIGfqBCA02vqsMSyqvrEaDafuoq1A1QmEgKoDwzefT9B/sGPT3nLiEMuo/QJ+htBvUtVESOq3EyTbvYMpiUBwhaFDIlc1V9z4rH1detqOVHIR739qxQSngVBWvan+F7xg2nt0vv769HpkWzjfSB/ynNnGI+Lkh9FjmPGUQIo38T+ZvRvjuYPqHiNSlElVUCMrLDcQ2ekSl/DDocdarz4jbrsWg4wl+BZ1VWAy644RoslVZul9ik1XOz6FWiN0RrFY6R+8PjCaDSxi7jL2zNKj7Gv+L+5LoEj9udiXfHRSc3ewGMRs4lYD0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn9frKcqPinMB7KOqoXh2qe5zdr30r8xbXrzy5HJGB0=;
 b=RHOGF280s+JJ77fB2+q4Z+8AAedpf+F+HFw7oJw8WaWjsP7n6t+OYuFUPLZ3cQQw5y6dkU+GlizXS+ZbgbZZdKClh/SBjKb8M6EnYUdb4CFHvH349z/FIbovnHYSRbKM7oIcTYNI3SbBOf6Lji6BEIOR/p1vn+JK183beOB3kBBIHRkoYQvSdYlURNZ6B9tY0P1wEMv3Mb/rBmHUPMI+dIjkIOk15BrVqjB2351WQ8575ZGdNNOKjo4U7JgpBCKIFVcGhD8LV3LgWrq1d10YMjxm51+ouLGOgK5+OhxsBcVphcrvuDW99a2yiwRxn3zVOY6KJqtcsxw7YTPjQ2n+GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by AM0PR07MB6259.eurprd07.prod.outlook.com (2603:10a6:20b:145::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 14:06:49 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%5]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 14:06:48 +0000
Message-ID: <b0870687-5f57-4b20-9b28-fea3d4f2adbb@nokia.com>
Date: Fri, 9 Aug 2024 16:06:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <bce79497-52c5-4241-aaf6-2a95dc459041@joelfernandes.org>
 <66fdce3a-c7f6-4ef4-ab56-7c9ece0b00e2@nokia.com>
 <ZewycILled+mZhwe@shell.armlinux.org.uk>
 <20240312221440.GA29419@willie-the-truck>
 <ZfDZolTDQa76hhaS@shell.armlinux.org.uk>
 <20240313003244.GA29568@willie-the-truck>
 <ZfF4t74OD4CgVaGV@shell.armlinux.org.uk>
 <f15aea08-8daa-4994-a8f6-be0461b06539@nokia.com>
 <ZrYeRmn920CACeCa@shell.armlinux.org.uk>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <ZrYeRmn920CACeCa@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|AM0PR07MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e71fceb-2a86-4120-6278-08dcb87c825f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG9GNHllVFduVUhNTlpOSUxkS0c2MTE1TUpKQ1IvWWhhT0oyVFEzVnd3QnU1?=
 =?utf-8?B?MGFOdlRWZC9DMFBPOWhTU2ZSSmlxa0Rpb1dxSkhYT2I1MXJETHdCZndENnBk?=
 =?utf-8?B?aW5CcnY1bnMvcElJTVVPL2E0N3VFVm5vRklVSU5hRTN5SlFpa1RtYTV6YXlx?=
 =?utf-8?B?MlZUaEFzaGcrbFVQempqQzd2dHdwMHBDaHdqazhncDFYMnZxSmZxVTlKczdG?=
 =?utf-8?B?bGg1dm9aRnQycVlSWWlKVlBlSG42c1NwVjRHOVcycmFhQ0s4dk8yelFjcUpQ?=
 =?utf-8?B?TWU1ci9WWWIvZ2VUY2ZaTXJ1VWJWZllUY3pOVldkNXF6c1pHRWFtWE1NMWFT?=
 =?utf-8?B?UnJoNlNxU1JIYmFmbzhORHplTkx2YWpXUzk2YlpuUG51QlJSclIzQit0Mytu?=
 =?utf-8?B?RGk5SUl6OXVSYXFncnBOY0hURFlmSlFUaWExb3BUSHkzQ0FINHZEeTlqaVYr?=
 =?utf-8?B?M0lIZ1RuS0cwVHUzMzJxMlhvVVZwR3NhVGhWWVZ6NU9JNkJnY1h3ZklxS3hy?=
 =?utf-8?B?UmlvdTJZZGZ6Y2FNUEgyWVE5Q2lTdUI2Y1RFeHdiWTRlVWd0WXllSCtKQnlh?=
 =?utf-8?B?UXVMNTF5VmlXajRjMTB2WnprNWV0Z0x6UndjTndYcTI1Um5FZUJldjhaaEJ5?=
 =?utf-8?B?NDE2T0tCNWJ4ZE1CcG5DSzZMZTVYemk2Ty9HUW9xWjNRSkU3VW1aelFYejNp?=
 =?utf-8?B?TGtmMDBodk9yR09waWxYTG1wQnFnT1dEWnJZN2lURE51TkNZY3d0Mmhjd3g4?=
 =?utf-8?B?U1M5dm5Bb3ZRMllMQUQ0MVdsbTU0T1VuOTJ4TzlWei9iMmsrL1VoV0RMN0RH?=
 =?utf-8?B?TXVaazJxUmJNL3RPbjB3ZVREWS9QbmlRbXprakFJSGNTSkN3T004bUEyYUdI?=
 =?utf-8?B?Z3FBeUlmcE5pbFJ5aCtwTFgrZzVBQjRsSnlBTWcrS3hLMlN0S3ZBQ29QRXZE?=
 =?utf-8?B?MXFjVWgvKzE5NVhYc2cvbTQyQzdKdWxmSE5OSmJDOEQxWHFBQ214WDF1aHZE?=
 =?utf-8?B?OEZWT0FoZ2psV1hqaC9XcWY2anhkcFRuOGVIbkt6VWRFS3NMbGJmUG9sNWhw?=
 =?utf-8?B?c3ZJdjRlbmtvL2hYa1hmWkdzNllzWFlvRFYzS2E2RUNLd0xKMElLSXp0b1pn?=
 =?utf-8?B?c01YK0tRWFFiQTRkeWZ3aUNsam5OcFMySUJveU9ISHRuKzhCZ3l1L2pITFg5?=
 =?utf-8?B?c1dTQnB3K3g1NmlWR2RkbUlQY0FXaWpBVTNZSkcvSHJCVWxmZURPMnRncWtH?=
 =?utf-8?B?aGJzbHRVOUhBN05uTGkrNTNuS1g2dFVMZGtMWmRyM2NQMDZqSlRoYk9HZlAx?=
 =?utf-8?B?ZFdnNVVUVngvMUQ1T0lPRE9RRkp5ZGlYa2lrRTRoTzd3L1lwS3VZZzFncU96?=
 =?utf-8?B?T2NVdXFrQUY0eTR2TnR1SXVNZ00vZ3dLcklFa0hqSFVnMEt5S3MvV29YbVhY?=
 =?utf-8?B?Z2g2di9IbE5ad2FKQXpMa2hhZ283Vkl3OEhIcTFJTGJUQ3MvWk12cERpR2ZJ?=
 =?utf-8?B?L0hwb1RLaDNlRkI3M2ZiTzEvUjZkdGl2R3cvZUlpMEVWb0lQNW5SWnM3WWEy?=
 =?utf-8?B?QW9YYlNVbW4vcVFhbVNWSkVnV2NuTnhxa2ZKTUhYV3B4dmdyYUR2Qm1xVUty?=
 =?utf-8?B?RXQxcVc1YXdGVG5mSy9xcmVRTkhpcDB0a2VnR0VFbzc3Zlk0QzgxZDJ3UzI4?=
 =?utf-8?B?TFJ6aDBxY2YxbnlHT05kYXhFeWZqSVRNMXVXSGJlZldQTVViQWF6emYvOVpZ?=
 =?utf-8?Q?D+jEdWcoSwDsuemxR17r43jyJXECyL678iABtgx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUpJZWV2dDNIZDBvS1JsNDB5SWE1VXRxK243RXBBZFBwVXVIM3d3MzVpK3B2?=
 =?utf-8?B?dU0xVldUcnBWalU0Y1Y4Kzl6cXF4djdBeEJPWndDZWlVNjVrcUkva1hyc3ZV?=
 =?utf-8?B?blJsM3VrRWs3NHlBdWFmT2NmUldaTnc5RTNseDJzWTlsbWZqSC9pT2l1b2U5?=
 =?utf-8?B?aHdkLy9MSHU4bGdJdWVnOFhKeG5LTEMxNlJqR1lwQUd2aDdHT1I4azNWMVQ2?=
 =?utf-8?B?VFkwSTVaa0paMVR4aVYxZmtBVUhERFo2d2I5R1FLem80aUlTRjIySmtrZ2Jv?=
 =?utf-8?B?UXpvQ0hBbVlZaE1RSHB5eE81WWx5Q1c1NllBVkc0Zis1NXM1SERRN1RIYXJa?=
 =?utf-8?B?b0ZOdkQ3RVl1SVpNeGtrNXpNUytpVHl3NVJYNktYUUw3SHdjY0xGU3FVL3hq?=
 =?utf-8?B?ZGpNcUpzNjdPc0MwSEVTNDlkZDFGNit2dVdXSUJaS3R1UFh0RTNzVHRJRnZP?=
 =?utf-8?B?aWpvclJwb2g3VkpicUtvbzJBbXNKdU1UZC9MaVFPeFptWkw4enZYT3dJeWVx?=
 =?utf-8?B?Vk52MWVYVExZZ0dpVDhlOHFrVmw0RUl1NnpZNWRCYm03d3hrWmNEcldLRjNM?=
 =?utf-8?B?QkZGMEp1QWdRSDV5UXZ0WFR3aEtkV1pJUEtncTlGeExVWVQ2V3VKOWVFSmNr?=
 =?utf-8?B?SWt3bGRIdzRHSktoaFc2UVZ1RERNS1pHalNmZzYwTDZwUkVTNmNReFplY1ho?=
 =?utf-8?B?SEoyNEs5VUlJalZUekw5cC8vcnFiUGJ4SjJqdXc5QW9zL1NqZlFSWmpkdERa?=
 =?utf-8?B?UFhIUWNFREF2dWhubW9zSXBxcXQ1aGEwMUh4SkNzNi95NktkWVluSzhDU0VU?=
 =?utf-8?B?UjhxSlhDR0lxVjI2TTVxTFR5QXVuTTVvTnVyZkE5OGdzd3dJWHIwdWlRY1BY?=
 =?utf-8?B?eGp5UlNDTndHQkZ3VWcwa2N2eUZQck1TUFM1eFpmL1NROVhteTNlZTlpLzlH?=
 =?utf-8?B?UEdEN1VWeXQ3eEF0Qnl1bWV5Nmd1MWNhR0JKTkF6OVlvRVRRRUxmWXlTN2ht?=
 =?utf-8?B?YnpFU2NTRWdDd3NsM3pWREdXbExJWm9qdmJVYUIxdEFPV3JKcW5jWmRKZVRm?=
 =?utf-8?B?N0U2YnlyaXU0bDlOZkNlU1cvNUsxcUVrY25TdDByR2ZUSU5pYXpzSC8zNWJ1?=
 =?utf-8?B?bFl3TFFXeSt4SHBiclJqaXh0MDI0a3JEQXVqZHI5NVMzemNrSTFHUnJINjlr?=
 =?utf-8?B?a3J0SmVFS1hjdXR5akZRYWw3WWRuS2k5WE9FbGdxc0htbG92WHFaenByR2x1?=
 =?utf-8?B?emU4djRZMDdZTEFEbjlPQkJkdEpRd0t3cUczbVBaSmZheVFzVitTS0V6bEcr?=
 =?utf-8?B?OERrWndhZHFjbGtCRzlibWZreWs0NzN1MjYvWXNZb3N2cEFBN2JGVU50NGNO?=
 =?utf-8?B?UXY5VDRpSjlKRHI2WS9XdytaOUVpbTdOK2NHWXZpN2g2SDdCYzdYZkhhaUFw?=
 =?utf-8?B?YXZucWh0Z3BlZjQvVE9OQUFOOXg0N2dBK1BkWDArQ0tPSWJ4a2J3WGZwZHVQ?=
 =?utf-8?B?RldFV0F5V090YnY0WU1pWHAvb2tQcVB4cS9LSWg5WCtLemYwdTRtdllEdW53?=
 =?utf-8?B?cEp0TWI1S0xjMzBrcmlDYmdUTU1xWWtabThQb3lpeHFBak14MEo0NUp6eURK?=
 =?utf-8?B?Rjg5cTA2VEdWcCtaNktYN2NTUVJaQWRiYUoyanhRZll3L3NUNTBKaXUrTzFC?=
 =?utf-8?B?ZElXODFBSUpRZDBqa3d4eitOR2t1c1AzRlI1OXR2cHNhR1ZWUTQzSkRSRGdD?=
 =?utf-8?B?OXVSdzdpWm5pZVJyQW1YSDVYMTY5dXM1MVdLTE9GWTRPUW5MV2pBM1lrVHpI?=
 =?utf-8?B?WEkzYzhFVEV3SDBFNWhvVlE5U042blJtS1JlbnkvQWhkOVBHSGhNL0ZwUC9q?=
 =?utf-8?B?ZEZHanRxbW91bjg2ZXFJZHdZWjFaV211VEpBRzJTdFNQRTYzQmNEcWlXM0pN?=
 =?utf-8?B?NkJwanF0aTY4Q085aTA1TkRuOEtFYzhpeFR4UHp6NTB3Yi9qNmhCNE0vWGhW?=
 =?utf-8?B?UlJBQWhMYVRzY0VCaTNMWnRCS2FYSUFmKzBrVUxHbys3bTMxNFNndGdjeVZx?=
 =?utf-8?B?dnRObkFMUWpzU2NCWDRFd0VtMVh5MEkvekZQU0RjUEl4RWxsZW5YWlN3OUVa?=
 =?utf-8?B?N2NHMGxHMkd6cGZsYkMvUFQxeVZpSElVL05saVhBWE8xVnA1TWdZOWlFY3Ji?=
 =?utf-8?B?REZTbmhPUTRNUExnK09CdmdsNnlrTnFJT09EbjdLV0dvbUtFZ2tkSWNCOHYv?=
 =?utf-8?B?d2VTTWxiZHlpamxDcm93OExQS0V3PT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e71fceb-2a86-4120-6278-08dcb87c825f
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 14:06:48.3407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEs6uX9e6MPe3FtLJ99MoG61lJK4um6w4ZIBL+4KsaGpFX7JLzQPUgksYROTFbgOrVgsWrNz9s2stBbJwo9YHk9jxK7VMIAA6QPWKcWeU9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6259

> Highly unlikely that I'm going to have any time what so ever as I'm
> undergoing a series of operations which are affecting my eye sight
> (over the next 3/4 days, I have only one usable eye while the vision
> in the other settles post-op.) I have little idea at the moment how
> this is going to pan out, or how long I can spend in front of the
> screen.
> 
> Worst case, it could be well into September before I'm able to resume
> any serious kernel work. E.g. if the brain is unable to resolve the
> 3D imagine from both eyes next week. Then there'll be the second eye
> to be done at the earliest 30th August. Then there's waiting for the
> vision to settle in that eye. Then there's working out whether I
> need sight correction to see the screen and possibly getting a new
> set of lenses for the glasses.
> 
> So... I think it's best to count me out on being able to solve this
> problem.
> 
> Sorry.

Oh wow. I might be just a stranger from the Internet, but... I sincerely
wish you all the best for your surgery and the recovery process. It must
be very stressful as a maintainer to get bombarded with all these
requests - thank you for your great job and prioritize your health!

Kind regards,

Stefan
