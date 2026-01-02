Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8423FF1;
	Fri,  2 Jan 2026 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767322776; cv=fail; b=Djr5Gr1a8vQLkQ+rqhCAP+0bbO8H8+rHWeMnw30Ip8NHMJYeAdt3G03c8GM5zOqUMQjQJDCldwZbiEjPn9fgNiMhRip8VyONsREWDSlbTE68bbfX4Rg+RTdZfA06vTXvnLqjJyeqIro/vt1JsiJqXb/bdBz80tzyN+6WFcCwb5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767322776; c=relaxed/simple;
	bh=9Ic8eMA2KUszqpwDc2NghuYK+DYydCWEoFYvSnD3gYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gwDWVCz0Plu/LiZrYnYvgapS5K/E6MJMVxYhb4ZyRc//amloa19fLysanhVmA2XUKqR7Az/O7hVkKoWbN17OdmsxmB/V85npizIZ6uMmspI8mFjJtlRg4LCp0INHtkiSOgFh5hjzygShTsDnAgMZ4TZqUhnKdDuIIW+j7mUsO6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g24E1E6t; arc=fail smtp.client-ip=52.101.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g24E1E6t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldgDxnJ16mW/U6XNeT8Gqqd6nUFlNFK913cWQRYTsDeWDdbYoK0hsa6/3wlLMqny+FCZ0EAcrI3MwQfjgusJNJ/3WoUiz4W3HNRihLEGjQDyFt+0b7dqBYFSvQpZe2ttnUl3AXpuefJZX5ikZR4fhlx0cmz4v/spNnVPIVmmgwfj9iTfHcWPdtutq3yov34652mDURk+tT1irU2jse4OmwFXXPG51/xzl9bxbyR1Cn/cGixQrdKZ/XZNrcCHr6kSj2qtPJN0dVixyXuos9L1KURqcoGu6OJLiGNErJfi3tTo6Km0j1xYPbiYPpwYIrpvciolD7ZbUdVBQ0c0olBtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyvcWFEoJnnJKcbdBpPQAJqaLj0ZlgZpNKHlwEjQW1Y=;
 b=ULWskn+1Me+stIMZW3hxxqyEl6SyDQlj11GNeLN2xMmwAaYULIDW7bRPhCjkLpatfiEV9XwUH66HKamAusIDKKbwLV4+D4g536rjYeWrDu6dHxsJa9/1ZEqSPgayCiR3SDzzTbqnprWhHbQyT1ebVX/o4u3cKmu90kMtxSIHUR+HEWjk7exsZJ9/tJgLct2ZVTEfdzxecUVzlY1fB7yGWKRdIRM//HXaYg5R3Hkpj/65u4cV208yL8KWeAqY+yPyIASkBy93grxaYMRDdS2pUp7pXc6i9bgVFaNoA/qFyJyYlOmqb0U/J5i4QSWbjBE4rF3cdWcQqV+yaXv41AF4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyvcWFEoJnnJKcbdBpPQAJqaLj0ZlgZpNKHlwEjQW1Y=;
 b=g24E1E6tzWbmt/nKom8K+vR1O2pydle8VsobRFlYHMlNRRJ4qUNGozQHD+fG0ufMDe3HSgHoKv9piBYZptw5g92d/gU2IFtTeqQ2PkYoHpC+nijx5iHlhMwknOaZc3Gc1qixeMDYnChgbOCAKCbZdFOn+MQzAuxlTiq5M04ci/0JDeLaRMIaUw43FL51Jqp8rFf9zNUP/mmPdU+Vtc44IK5ynB4itEzl69GLVvocnZUhwRqTZ+vV9ClGW1YsJR82EYIt8pAOVziuQdkLiYrXcnZmvi+LR0jLjLchF4ybXegac5gj4w+EvoySM/SF67Feyj6hbCGSyrtWNX6fqP9SnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 02:59:30 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 02:59:29 +0000
Message-ID: <e7db3fd5-9c2d-4d63-850d-dbbc1900d13c@nvidia.com>
Date: Thu, 1 Jan 2026 21:59:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] jiffies_till_first_fqs off by 1
To: paulmck@kernel.org
Cc: rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>
References: <1efce983-639b-430d-a613-03baef81c416@nvidia.com>
 <2f95e414-7d0e-4e2a-9656-25abf84c27ec@paulmck-laptop>
 <20251224020619.GA1297269@joelbox2>
 <b6bd973d-3cc6-4174-aaae-f3d67d8ccca1@paulmck-laptop>
 <20251226021559.GA949635@joelbox2>
 <cc710326-1b49-4892-9805-a197d48d202f@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <cc710326-1b49-4892-9805-a197d48d202f@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF00013DF9.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:c) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e1eab7-bb74-4226-0698-08de49aaf2a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXhBbWY0eWt4Q3A1TFpraDBDS3djaktCUUVNVEJjMU5rM3NGMjNEZVYvMEd1?=
 =?utf-8?B?cm5rUHBYV2tDVnluQ2h3RXhvcWxVUFdaQVMwS3J5NHFnaGkxd0c0NHYyZWxP?=
 =?utf-8?B?QlplM24xTGtDdFlPdHJ6T1VPQjhibDJVMXE3TlJBZVl4dHdxQUE0czZWODhY?=
 =?utf-8?B?UitweDlxTWtaaEJRV2pKWkxmNUwxR1JBekZuWnp1K3FNTDFZdDk3QjNNWlQv?=
 =?utf-8?B?OVdtUFBaM2dqTlRCNTFMeFYrREVUYnNrVWlnN2pWbk9id0k3SDZYL2UxZEJh?=
 =?utf-8?B?QXhTYTJXR09icmhpUTBUeUFIVitWYWJZZTBnTTNnV3NwdVFpR1F5T1RWRmdL?=
 =?utf-8?B?bjNrOU1kZlNjZ1J0ZnBzd3IrQjExenBLVW9qSldVbmpFRkVUc0JrNlkyeDZy?=
 =?utf-8?B?RXlyTzdncm1NUDhzdnVPZVpEU2Z0MzBhdnBlM0oyL1ovTUxPUGZtOGk1bm5x?=
 =?utf-8?B?cjVyVkdvQzM2ZWlzRVRTVjRmMUFxUkJ1VmJJa3Y1MGFpV2EyRGdSYTRFbEZL?=
 =?utf-8?B?Z1ZhbjFGdmZnQmZzOUVtWHU3am5oNzZxQXRHMVh2YVRGdnBjaWVHNXMxL2hV?=
 =?utf-8?B?bzFsRVZhMTJJbGNjUnN2OHgxY2M2K0Exa0Y1VG5XUHNhODhQWCt1Rld6RGw4?=
 =?utf-8?B?NW53dDY3ZE03Z0x2WnllRHJCS2dqeUlZWTh3TkVVYVgzRU9kZGJVcnFXcXRq?=
 =?utf-8?B?dnVQQUUrKzRrM3Vpejh1N2xiUkRoSjRSelZMNm55V29xWjJIaHlpNGZLTi9M?=
 =?utf-8?B?VEhhckt5MHpiSnF2SmZzMHhpWUtkY2cyZnE4U3ZlbmdCWnhkMTZuc0pNNXc3?=
 =?utf-8?B?RTFJeGYvNlF2WnVTYjhZLzkzcmJqQjVxdnY1UjU3VWFYQ2VoV3NpVkh4MHRo?=
 =?utf-8?B?ZS9TaUJvcktJa3BlMktuRDJTYmxiSDdvakUxbVZZZGJhQWRhUU5qMVgrRmZM?=
 =?utf-8?B?SHFmaU5MbHpJbWh6UGU1SHpmZ2lTV24veUNDK2xIR3BIbXlzblhjQ09zdGZs?=
 =?utf-8?B?UGx6NGVvckFZc3hpaDFxQXk1MlZpWElkQmdvNzE2emFJbkJJQnRoWExxSmRy?=
 =?utf-8?B?ZkdVSGthYUVISUM0aEpqNUlPSEN5TnliWlloV01rcG8xbTlUODA4Q2tMY1lJ?=
 =?utf-8?B?eEZXc2w2UU1ic0JRZm42L0RLUngwOXl4SEF3VE8rS3NoaWRVeFpyR0R2YU1F?=
 =?utf-8?B?SXlnKzEwOXVJeHd0QStLdUdLeFRTK1ZVSFNzWGw3eWp0MGZhRHBmOHUwWmlS?=
 =?utf-8?B?M2s4U0tleFdFZXBrUXZqRUFRbXlIWnhLSHBCMkp1SU8zK0FHanBTRjJNRUp1?=
 =?utf-8?B?cDNhTmtURGpXK3NEUXl6ZkY0c3FVY0dDS1F5OUgyZU5vdVZvUUxrVXFNV0lT?=
 =?utf-8?B?OXVPKzVUWml4MzZhMjJQNjNsbWZBMVJGQ21hNFRwVE5CdWRtdnNWaUxocTFl?=
 =?utf-8?B?TUxzTXA1QnNMSnJVNld1VXZHSmdQaXdSUEt4U210ekpLaG8rd0IvYWRYZm9j?=
 =?utf-8?B?a0dOaFQxbHZIYnNIT0hyTUgrT0dLVGlRcmVDRzg5bG5WY2VPV0Vrb3JMUHJL?=
 =?utf-8?B?MUt5czFKVlh0djcxZ09nUWFSc2N4SithbGRtT3JxTUZVQmpSKzQ3RG45RXRz?=
 =?utf-8?B?Q3REWi9OOThCelFHdlVHRzlxNUtKNENqeFRadk1Qd2t3ZlBPWUs0WjhaUVl4?=
 =?utf-8?B?eXlRQ3BTVHUvVytETFZ6Tmc3UnJSQzYrOEtmVVhpaFc2M3JramVGcWZMRmJD?=
 =?utf-8?B?RDBuVWdrYnExY0NOUFc0YTFpeHVlRmpXck9rbDFwY2NLUHJwR0RJZEtMNkdQ?=
 =?utf-8?B?MUpibW80VmxNalFrdERMdjlvb0kzcTdaNzZiU09sYXMwT0U2OTlHVjBMUVlO?=
 =?utf-8?B?dnhsc1g0MzRQcm1nY0gvMlNrMkphcXZpVkhNanZraFpXbmpqMWpBeERYT2RJ?=
 =?utf-8?Q?pupvPq4E1D9eNxe9zSvbhKfSRBd94rKc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emhUZzJRcDVzMGRNOEhzVyt5U3EzMUc5cE80dFpvWjBlbkFjcnoyQW81SW5h?=
 =?utf-8?B?M1J4SS96WmNBaVRWSTdtQkE5OVZqWUNHRVJJR2Qwb0J2bzY3VnVZWjFoSi8w?=
 =?utf-8?B?MUJrazR3TEoyV1doS1F1dkM1WVBndzRtZ3F4czZRd0VXeWFvRDZOK2tPR1Iw?=
 =?utf-8?B?NkRHVVpESWs2OUtxajQ0Z1VRQzAySDdNOE95ekYyM0tJeGpSemNUMmV6ZXkx?=
 =?utf-8?B?NkNxSlRWY0luMWsrb04vRGlnbW9WY1lLazhNd1QrZGkrSXQrVFpTdDFjb1J2?=
 =?utf-8?B?cFdPVGlpUFhGd3BaZWFqT3JlUTJIZlJJeEczOXdPNjB0bjFxcEFCR1RrYjZs?=
 =?utf-8?B?YW01V3FTcjd6NFRQdHpjZzgvTmpaQUpyTUg2dnJoSjJNSENQUUpEQkRKQTd4?=
 =?utf-8?B?NUs0NEZhTDJJK1JJWlZJamxudHJBN040Y3pwQTBGc0V2MzhkakFiN05zNytV?=
 =?utf-8?B?MVMyb1lkN3k3S1pVOVV5SW1oeXRTWmJrMktjQ2JDMTRWd0lLdEF0RUVLK1lM?=
 =?utf-8?B?Q0tvd25QeS8zTW9iZHlEQmk4YVZkQ2FGT2ZmZHVXTzFsU010ekNZcEtYUU40?=
 =?utf-8?B?eVdMRHpKVVZ1QUxRMFFwYkJ0VjhZRUU1c2RiSVA1ODFXbGVDaHkybUNSTVVX?=
 =?utf-8?B?amZJOUN0Tkt5emUyZFg3RjZqQkVONUdjZGI4UGRYR21Ldk1Tb1BlMU5qbFQx?=
 =?utf-8?B?MTRXbWJpL2tzSmhhWG51czBlTmpyTE9nWWlRSy9LOTJWZ0YxbUJCR1FHWmhS?=
 =?utf-8?B?cWcwR1BqYWpob0NBeGJSTzliSldBSnZnTWtPS0l0UGd5RG9qaWMrS0NFYzNI?=
 =?utf-8?B?eDBYQ2tHdG1uZDY5K1cyYTZTK2owMlcxZVdVSTBhRlhJaE04dTBrOHRKYVhY?=
 =?utf-8?B?NkJZRWlMQmZMaVBTSmFHTGI0VTkvUUprT0JjaDFQcm8rOENQcHRWR29KOFJQ?=
 =?utf-8?B?eHJpRGkwbmFrdGp2YjIzR3VjY1VzZXI1Rldva2dXVGtjaDg0R1IvOWhaQjZx?=
 =?utf-8?B?aktWcHN3cmN4eThVRk1qenhsZFo2dW4xUWdWVFdpTnpzeTNFMjByOVlBS0x2?=
 =?utf-8?B?ZERNYnZTQ2kzRnRFYm05RVhCLzZPMElGeHdTdkoxOUkyVGE0SzA5S1A2Zzgz?=
 =?utf-8?B?QmpMbW03OXgxMXFiSzlKdm9RMUs1eUhlN2lnMUhpenVmMXRidEVOL0FqTjFi?=
 =?utf-8?B?MURKN0FLQWNNaG9wcTRDSFpkbC9kTWdiY0dQMFk4eGVJY1QxbkJMSHNrQUZy?=
 =?utf-8?B?QmpJSHlFUHRENGx1ZzhFcGR1bXpMY055Vlk1My9PL0dJa1dFZnZmd3E2VURa?=
 =?utf-8?B?WEx6TWJKb1VmcnBSc0JxU2hlTExVNFJlUTI1WFd4ZjBjTTBGVEF2R3g1UGg0?=
 =?utf-8?B?SmRSUzhSNVFqd296aXlYOUgvV1ZZN0tpMXFWR0ZZbkpMWjFRQkxYbnkrcjhk?=
 =?utf-8?B?Q2lkVWNGMHVqbUVSOWJnaGVSdllkdHZmOEpQTTlsQ1hvemxtdDRTNzdMeHpv?=
 =?utf-8?B?RFdMbFdoWHUremF4cTJaMU4wZStrWE1FUkd6cFFBcmZpU1NOZlp4T01SR1Fm?=
 =?utf-8?B?MEJXTTNOcjkyK1crZjIzTjVXSTZuc2dsZW9vZXgwNFQrMGV1cUZ4dXVBZ0hK?=
 =?utf-8?B?S09OZWJXVGpBeWRWemNZYlhjRTNFTTZSZFBYdERFMVBTZFQ1a2NVZm1zc2o3?=
 =?utf-8?B?RThSWTdQQm1RcTA0TTNkNEFvYkhmVlI0dWV1dFhkMm94MSt4L0wyNklxVWlz?=
 =?utf-8?B?VmFuaW9wQVRGd0NDc2d0MllqQktUaHNZR00wUFBteHR1U2gwSnI0VTh1VVNN?=
 =?utf-8?B?VUc5MDZtb3dxd2pTRk5HQ2N3VzkrRTg4OEdXT0NqRzl0eGtqSWdoZzVENXFn?=
 =?utf-8?B?WHVxSkJndHliN2NpQTNWRmtiMHhCV0RHaDlFZzZEd0UwSlVmRFY3MC9yTVVl?=
 =?utf-8?B?L3JhWlM5TWdEb2I5VURMak80TWRJVFhwYzlHQm5YN1N4S0NJRG8yVmRRcCtT?=
 =?utf-8?B?RVpKMU5qK1FtU2VZdkp6Y1Y4UmYrZ0dUOGFLUFVoOHY2cCt5SFkvK2xOMEdQ?=
 =?utf-8?B?Q095N3YyNjVGL3poQ3pERTlMRTltalJFTmRNTnE4aUU1dWxSK2pmV2xOK0V3?=
 =?utf-8?B?STU2YWFyaXNhZnlMNXNtbEZVRURWeFlvY1F6OFlpWEZCQTVTTmE4OFdtME8z?=
 =?utf-8?B?U1FSdDZ1NzJaandSMW54b0tGSStSVTFSRCsxdXA4RXptQkpuNkxTVElHNmY3?=
 =?utf-8?B?Y3Y2Mmd3Y09JNWc3RWtJNVkzc0p0d1JkNFhla1pJZzJKd0pFTjVINzdMd0Rt?=
 =?utf-8?B?R2VRVWlrMkdVNWVKL3NzWngzUnhDVDBkMDJuTjU2dmx0emhpZnVtdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e1eab7-bb74-4226-0698-08de49aaf2a2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 02:59:29.8674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgkHkUXbkZoLcMz0o9D6EVb+1ReXM8dRi4WrQqjqlK7bvv0HUMp41GP5GxasF0T3KVpJc5j/YBD9/VTmaHcsRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498



On 1/1/2026 5:24 PM, Paul E. McKenney wrote:
> On Thu, Dec 25, 2025 at 09:15:59PM -0500, Joel Fernandes wrote:
>> On Thu, Dec 25, 2025 at 10:54:20AM -0800, Paul E. McKenney wrote:
>>> On Tue, Dec 23, 2025 at 09:06:19PM -0500, Joel Fernandes wrote:
>>>> Hi Paul,
>>>>
>>>> On Tue, Dec 23, 2025 at 03:53:23PM -0800, Paul E. McKenney wrote:
>>>>> On Tue, Dec 23, 2025 at 12:38:19PM -0500, Joel Fernandes wrote:
>>>>>> During studying some synchronize_rcu() latencies, I found that the
>>>>>> jiffies_till_first_fqs value passed to the timer tick subsystem does is always
>>>>>> off by one. This is natural due to calc_index() rounding up.
>>>>>>
>>>>>> For example, jiffies_till_first_fqs=3 means the "Jiffies till first FQS" delay
>>>>>> is actually 4ms. And same for the next FQS. In fact, in testing it shows it can
>>>>>> never ever be 3ms for HZ=1000. And in rare cases, it will go to 5ms probably due
>>>>>> to interrupts.
>>>>>>
>>>>>> Considering this, I think it is better to reduce the jiffies_till_first_fqs by 1
>>>>>> before passing it to the wait APIs.
>>>>>>
>>>>>> But before I wanted to send a patch, I wanted to get everyone's thoughts.
>>>>>> Considering this the RFC.
>>>>>
>>>>> Inadvertent passing of the value zero?
>>>>
>>>> This should not be an issue because at the moment, even a value of
>>>> jiffies_till_first_fqs == 0 waits for ~1 jiffie due to schedule_timeout(0).
>>>>
>>>> But you raise a good point, we should cap the minimum allowed jiffie value
>>>> for the fqs parameters to 1 so that we don't pass schedule_timeout() with
>>>> negative values when/if we do the reduce-by-one approach.
>>>
>>> There is a potential use case for jiffies_till_first_fqs=0 and no wait,
>>> which would be systems that want to scan for idle CPUs immediately after
>>> the grace period has been initialized.  Note the word "potential".  ;-)
>>
>> Sure, we could add support for that but that would be new behavior that is
>> not in the existing code.
>>
>> So jiffies_till_first_fqs=0 today, I think it is not 'working as intended'
>> because it will never not wait I think.
> 
> Agreed.
> >> So we should fix that too? Or maybe it can be a patch separate from this
>> (that I can work on). I think no harming in allowing that mode, at least it
>> will be more in line with the expected outcome.
> 
> Makes sense!  However, given that no one has complained, care is required.
> Someone might be relying on the old behavior.  (In which case an easy
> fix would be to make -1 be no waiting, though one might hope for a
> better fix.)
Some further investigations revealed that the "1 jiffie error" is actually worst
case. In the best case, it could still be closer to a jiffie. It is just the
nature of the timer wheel, since it snaps to numerical TICK_NS boundary, the
rounding error is intentionally added depending on how far along in the boundary
was the timer for the wait enqueued. If we took probability distributions, we
should be landing with a 1/2 jiffie error, though in practice I've seen it to be
3/4 jiffie error on average.

Given this, it would probably not make sense for us to do the -1 to adjust for
the error (since we don't clearly have bounds on the minimum error). We just
have to accept that we'd lose 1-2 extra jiffie per FQS loop iteration wait,
which is amplified if a grace period is already in progress. I've seen this add
upto 4 jiffies to back-to-back synchronize_rcu() latency even when there are no
readers in progress.

But I had to go down the rabbit hole and check... ;-)

thanks,

 - Joel

