Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31D1C1F27;
	Mon, 11 Nov 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346386; cv=fail; b=XSH1ub89aPFkhsLKX4MowVPayLAGtLDTmAEgfqILiXInBa+SqmdQcVQ+qu4PRhhofY1H07nCWn05mp7rADGat0gGAmWq5GTww9sqhueIUhYJ985p+5Su6qghjwLXbALesGfFYmihq92pDUiE9GPsa8sskW1ntBy1SELAvINR0V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346386; c=relaxed/simple;
	bh=9PakEyKiaYxwfDVi6sDroV46EdddBUY/fEMY08pgAho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H3LSply0/JvrCMI6FIOlB8fuIR3FmGTh/Xok1oy8VO55nLF2D1L5MrwuuTHnoAT3WuupQ9B4vrYxb0mxa8mkR+SskOGs1GaizZehI+T000nshvTisL6Aw9Hvi7/AU+LZlze0AovqphKApC2BQNlNTB14xxqoPvfrPHNdVDoHLAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mX+Flk/H; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mX+Flk/H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA8hOlShsPw6QzTk+h+5fTCaxL6xcBzitdHLXRIB/Aspka257OiXmlRRikAfk0AggHvdUNa3p161WeBDMiy9ywqpIS0KmB/CWXrH2gmxqZrJ2hjmnzEMI/UlG/cfOxNOKSAOZMGdpoy4o1EHodykbXNLheWnLi1ATJcUQxf6BinbWjbybrReZcjmGy78mkJl1+HDQgiFKAQIDKCXLE+fxCpOJbUQ7VjrnxV8ZBzz8VnTptqlILrpb40QyURSJOjBesJwgOtop1IA7rk8ebE0tL8J9GQj58cAe7aI5jLmY5+ZKWs0B0rGoNnPwTU8vRhOaG9DC7Wn61D3URDtLgF4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dggPHqSfitqMf8x9Gd23z656EMm8ZVS6hcKtE/gdXEo=;
 b=fi9zFY2pqUe7qgn4we7up5/3SiZHY6nGBAaPhdQ8D/1L7K14i3mf3+B/feZr2j5HRid3WKxf4OoBaRevOyWG7D0FqiAxU4+4axOwaf2xJffqO3i8IUqaYD1icv9jP6wSzLMmowAqbWz3CQR/Y3F4gO3SFAyRH8sji1rLSGCIaOkM7EF5HnYgWM46HGGWSIgzSaC9a3l5se9XuJ9cw/Rd8sHm/Ieq2j27XXS5sLLX9b0yRa8lSEjako0YQiWvwJcVm8V6+uLApPh7U/KKhDwiEGlZUvuWwVr7AXozY36VAZED1lQVV2XwXgyviYFrcQvJx9Hz/MK9CA30b/BEhiv0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dggPHqSfitqMf8x9Gd23z656EMm8ZVS6hcKtE/gdXEo=;
 b=mX+Flk/H0o6J//KJ7Q1ex3IKK1+ZjQJ61Yp4RUbdPUy7idzOUMBvDSOdZkUSAafkbAl+8Pgpih5cB3EXGFIAbHz6j57zTJjTQ1ZE9ba+gQeHIXAyFVr4mZXtM9L4KAHQHvH57Za/7m/EhqiVYKcT/a16VMXlJTGbNnTX8WlXEuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.29; Mon, 11 Nov 2024 17:33:02 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 17:33:02 +0000
Message-ID: <8c98726e-0a6f-49ac-86d9-5ced73dd8e2d@amd.com>
Date: Mon, 11 Nov 2024 23:02:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] RCU fixes for v6.13
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Uladzislau Rezki <urezki@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
References: <20241106145911.35503-1-frederic@kernel.org>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241106145911.35503-1-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 7132a954-1c1d-4ac9-9c91-08dd0276e45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3llZ1hFSWxUdk5ZR3cwNWhoQmdqbUFYQytPUUhJUTZMdXdBU0V6V3JVK0RK?=
 =?utf-8?B?ZlRseEw2UllkQm9IU3BoMWtrbkVEWDY5Q1Zia2RzY0ZZU0R1TGRrQU1aNFVW?=
 =?utf-8?B?dzFEMXVTSVZzTDR4UjJFU0dFcXhBbmhsMXREYmhJb0F3ZXV4eXpjL1VYNkI2?=
 =?utf-8?B?TDRUYUF1K0g5Z1FRcE9PS3NxbHpnOXZkUEZkeUpKU2VCNEpCY1ZWTjkxNlRM?=
 =?utf-8?B?eW1CVDhUSlJ6YkNHU2hnb1JnMCtwa3hTZjlxeDVzbVFHaVdZWUR4S2RXNzBn?=
 =?utf-8?B?a2ZqamdzZ0ppbU9rY0lRcHBLQVNHYkp4MStxVG8xTzRPdnhnNG5XQ2RlcVJK?=
 =?utf-8?B?WDl2OVU4YkI3cWhrUExKSTI2Tmt1K2s5S3QwcjBYRWdlcGVMRWhTOVEza2FP?=
 =?utf-8?B?SVQ5NzNWNThncDN0R3huR2lwTTYyT2JsWkpFaTEwUndLVHRHcWRCYlpLYkdH?=
 =?utf-8?B?Si9VMzY3Ky9HQWp6dEFkV1RMYWpIUysrazh3R09lU1dpbWh0T0NaRWxjd1RN?=
 =?utf-8?B?MTkwVldlMjJ6K1oxeWZlYXpEUUxoZmcwVWcrdlJTS05DbGdQTThXSVY4aHFJ?=
 =?utf-8?B?TjNNcDBNQlZOcXd2RTRlbkFtQlRMd0ltb0FFU0R5NWVkUEZ4aVlNV3lkUTJ2?=
 =?utf-8?B?YlRqbElxdEpoK1AyclZPQlRLYldzaENldmpVcE1yUlhlOGhibDZMU0pJUG1X?=
 =?utf-8?B?SXNEVm5Yc1Y0d1BzQjBJMUpBOHJiTXA1K1pFM2JXTEhQZ1VMdUJGNGVMMmxj?=
 =?utf-8?B?SG4rL3JJazNJMjZZL0ZQbElDUXpjNFdUOFVhcUF1SlgxNDVpSU9Qd3JJOU1Y?=
 =?utf-8?B?ait4TWZpdmloS1hkTk9xRkVNUmw2L0hicW5BZ0RjZ2VGdHhLaUZ4THdMTUtx?=
 =?utf-8?B?UlVQNSt1QXQvU3BCRWUyWVNSVmpsajlyZ1NQdVN1SlhFdUpldE5TdjJHN3Vl?=
 =?utf-8?B?cFNhMnRmUmFEODAvRS9YTE14MXZDUm1TTGduaGVEYS9pdWxMWFd3Qm9iUHNa?=
 =?utf-8?B?TEI0Szl3SVJVMzB3eTBhSy9iY1lONjJqemRZN2xlRlBUMjZoZlN3eFoyYzM2?=
 =?utf-8?B?Mkl0WEUrNU9LczM1bzl4eUdCbExxR2N6Y3JvYXVUS3BsaVBsa1lLTEY5ZW5w?=
 =?utf-8?B?a2tyUUkwcU1jeEwrYnpiZ0VYOCtPc3hGTlFUVmFrTzQyd2ZLbnZkMnFHSnZQ?=
 =?utf-8?B?cWZWWXBXTDhHWE1YeDNubzV5QVE5NHNkVEtnbFdYK0dFeGh4WmRVWklkSEw2?=
 =?utf-8?B?aC80a3IrZ0NMSDBDcG9RSXJ5ajZJWFZCYnlTQWZ4cmtwMnFWbm5waThhQjhY?=
 =?utf-8?B?SG5YZ01SUWdqRWZaUHpiamdzYjAxT0Q0MVBNNFB3aWJVODhsRFBhbkhXSktG?=
 =?utf-8?B?ZkVXajVHb2F6Q0MreUJNVUtORGV6aStoVGhMcDBCZUNYTTNpVWxDR3dXb2tL?=
 =?utf-8?B?a3loZ3dEbDgxTmRIOUF5SG9JdkRPTG1HVEFQTWxLYmRsZ1dWcmVLUTNiMnZV?=
 =?utf-8?B?STR5TkNiRUx3V1BQNHl0WUF5YjI5N2hpWWFTUkRrTUFGOUZ0SDczU0V1a29O?=
 =?utf-8?B?VnNuUXBVMDZWaWJvSHhaNkhaZzJ1c1UwdFBIY0tVRVpnNFBuUFJkVTU2NUl3?=
 =?utf-8?B?c3RSN2lGM1EwVUNSVWtwNlhXejBiRUFwaGoxa0ZLZG9TcE9ZSjJuMTJaTk1S?=
 =?utf-8?B?TFZDNDRJMnFuNitwMFBLQ24wUU5ZNDZoWXE3a3JIUVYwVEx6aUJsZG9pWEk5?=
 =?utf-8?Q?7E2YzDLXEE7pZ8IqTemd340ZSdNLNRmQPmBSzLo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVdFZnlsWmlFelRESGxPN1ZZK2ZqLzNhSDJvZGFyOS92ZTQvS1Y2OFBZM2do?=
 =?utf-8?B?OXY3UXp2NjM3SlFCNWdhVktOZG14Q0tPUE9ESE45SDB0TXRHWDdRYXNBYUVy?=
 =?utf-8?B?OHNnV1RORHh3WmRrRFFxS0dPcFg1TDlYODFCN0NNNjlROTJEcGpHckxSQlpB?=
 =?utf-8?B?STc0SDlBSjFLcTdxNEdCOE5KVDNhYTFFSFEvVUNzZDhSOVJ0WXNzQkxWT2RU?=
 =?utf-8?B?UkJ2cU9KZ0lzcjNFSUl4SjgxZXVLTTkxVlpGL2xEc2FIUGdRWTZrYzQ2UTRO?=
 =?utf-8?B?UVlCd2lYa0tmVCtBYUdWV0t0ME9PdmEzeFg4bFpSUk5WTkRlYjZWM2FOV3Q5?=
 =?utf-8?B?bzVwVW9JczlydXVTbXdRTzlTQUt2b1NJb3R2eXk0RG81U1ozTDM4WXpDeXZ1?=
 =?utf-8?B?RHQzelMzWDh3djJlUmg3TXBGa2NOalZXSUVobjdaUzk1SnFGenZhcS9wMWpq?=
 =?utf-8?B?QnZqa0xKVktKdS95MGpBMzJ1WGdkcTBEWVJJQW9lRnIwbmF2RHZudlhDNFk4?=
 =?utf-8?B?ZmhGRldZcUYrU01LUmI2QlRHUmxWOFlSVktYLzZzeVY0dWQydHFrbVBrY0tk?=
 =?utf-8?B?bmVRVDdQa2N4Wk5XUkYza00rZFRiem9RTEw4RkVGbFVTbEFqOVl4YXVUb2M2?=
 =?utf-8?B?YzVNNWcvLzgwTGxnMDhWa0hRb0VMUWpYUVoxa01kL0FLcDhIVFBKMUdlTUQ2?=
 =?utf-8?B?cnpmRDg5c0k0a3ZScllHMGYvVjBBWjMzUDNpVHhXMlJtZjFNMkN0OU9teG42?=
 =?utf-8?B?L1FCSVdUV0laNVh0STVDTmxMS2ZQK1NKSURYMFFRR0hneUN4WjlaMEs0Q2N3?=
 =?utf-8?B?anByU1NYbmNvSTF5TkhQNEN2aCt5THhqV2NDaUhJLzdqT1VwSTFGVTVtTzZo?=
 =?utf-8?B?OXJrRGQ5VGN0VTNveFF2UVBzRXAyeHBIK3IyZmtEeWd1SkdhQ2hWd2J0RnJn?=
 =?utf-8?B?WTJ1eUtnWENVWTdQdWk5dVIzdTM4NmZkVXY2ZW5ZUFhCY01ieit4dFdCaGRp?=
 =?utf-8?B?clR6NytRQStNakdwT2N4aXBCRTgzREgyb1c0Z3ByL0lMc3huUWUyVGxrM2xs?=
 =?utf-8?B?bUFzQThWN1R1QnFXR21JaDlkUGoxOHNXRXJvV2QyNjhXU0NraGVsVEI2L0tK?=
 =?utf-8?B?SHN2aGltMHlkeGJ4RHV3UHZkRjNKMmlFam1kYzR5OE1xN1VUdytlUGFiRWRq?=
 =?utf-8?B?YVFIUDRQVXVsS2hnY3c5YzVJN0tmeklpRW4yK3I5Um5nTHQyTGV3UWxhUXFH?=
 =?utf-8?B?Sks1YlpUTjQxQW5XUW9XN0tQZkNZc3d4blVzcUtnR1FGVDYxNjlvVWVDMCtq?=
 =?utf-8?B?SExpekFaRjRYa1VmRzQyR21OUm41NFBFd1JDVUNCM042RU1yZmovRmYwTGpw?=
 =?utf-8?B?OHRnKzhDdkpxM21USmt6QW91bE1kS29STnMxSGRUSWZ3dEdJdFlQaFhnNWlD?=
 =?utf-8?B?N0xsbTN4Q0dkZkRSM3JORkN3L2E2UlRxbGhDTnF4em5qQzVqVVptc2phZ0pS?=
 =?utf-8?B?ek9VdVg3bUtSNE8zcmM3REh0N1ROT2c1M3RYN3hOOHVrZUI3UmlkS29wVlFz?=
 =?utf-8?B?dnVacFRZU2hBb0h4amtmWS85QS9mQy8vdFlXeGZrUUJFMCtLRHFUTGVQcFlV?=
 =?utf-8?B?UlJWQjJpTXFad2FGelV4SjM0R25PUmExZTArbXZqNDNtS0t6U1g4dzhORjZM?=
 =?utf-8?B?K0tNaElvZklzYWtFT3JGeXUrRGFvTFUrNEVmNVFGWFBzQm9SQ1paTFhKZ3FX?=
 =?utf-8?B?dlMzaFZZSDNPT0dlZ3k3SExBZ1RLaitKVHExbXdsUTJtNFo3dThMSzhXVmY5?=
 =?utf-8?B?MW9KSXlZMDQyZzJKT3VHQ0dYbHpEVjNHREpNVll0bW5sNHFFMFhQN3kvL2Z2?=
 =?utf-8?B?KzF4VVlQRnQ4cFZoTXR5bXJCY2NvZTl0TjUreGtESENYR3A5aTRsTlRXRlRy?=
 =?utf-8?B?cEozSHc1eFV0MnB0QjM4VE44eGFGb3cxUzRMdU90Lzh5enZMWWpFRXVhMDJh?=
 =?utf-8?B?QnVReDIwVjMrdGRRWFRybWRUQzR4NzhaZXlIdnRZWC9KdXpXVzNmRHhZZlRa?=
 =?utf-8?B?UHAvUnRhRGhNdlptT2dVRXpMb0VEcUNZUzh3ckZzR1BlZ3VWK3ltOHl0LzQx?=
 =?utf-8?Q?RzDmmAM7KpgroiKuNv/Ta6MFz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7132a954-1c1d-4ac9-9c91-08dd0276e45e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:33:02.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBRQ96F7RvZBZ/dQzbKoyq6IdxDSnoN/yFH32SUljLZxksEBOaL03W/GGiv99WZqL0f6+nbCg0hAc2NHOr2spA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420

On 11/6/2024 8:29 PM, Frederic Weisbecker wrote:
> Hello,
> 
> Please find below the general RCU fixes targeted for the upcoming
> merge window.
> 
> Michal Schmidt (1):
>   rcu/srcutiny: don't return before reenabling preemption
> 
> Paul E. McKenney (6):
>   doc: Add rcuog kthreads to kernel-per-CPU-kthreads.rst
>   rcu: Allow short-circuiting of synchronize_rcu_tasks_rude()
>   rcu: Permit start_poll_synchronize_rcu*() with interrupts disabled
>   rcutorture: Test start-poll primitives with interrupts disabled
>   doc: Remove kernel-parameters.txt entry for rcutorture.read_exit
>   rcu-tasks: Remove open-coded one-byte cmpxchg() emulation
> 
> Uladzislau Rezki (Sony) (1):
>   rcu/kvfree: Fix data-race in __mod_timer / kvfree_call_rcu
> 
>  .../admin-guide/kernel-parameters.txt         |  5 -----
>  .../admin-guide/kernel-per-CPU-kthreads.rst   |  2 +-
>  kernel/rcu/rcutorture.c                       | 10 +++++++++
>  kernel/rcu/srcutiny.c                         |  2 +-
>  kernel/rcu/tasks.h                            | 20 +++---------------
>  kernel/rcu/tree.c                             | 21 +++++++++++--------
>  6 files changed, 27 insertions(+), 33 deletions(-)
> 

For this series:

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>



- Neeraj

> Thanks.

