Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4AB1D5CDE;
	Fri, 19 Dec 2025 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158691; cv=fail; b=cfZjXKfdQo1rgT3oNDQ5CEdYg2T7/TTeb4Gh9F7LmPeUcYn5Q5yfLkI67jYE3ApIt7kJ1+2fEgKyL3Z2awQe0jXUhj1IfuAlxjHFRKfjYWdQXmpaWejD0hGWLyfY7WPgqXNBgMqevVS5WllHu4ZZfmRUT+dElShZ5ShouFQtCeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158691; c=relaxed/simple;
	bh=rwjBA1JF/dr/LK2b1F2H2LZKnVw6npHXMNJ7kavtk5w=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j8L6iPCIbqwzdFsbL0S7Keux0SRHhUmbn9VeQX9uN1dXev+Kn7khIbT1S7bLqg2NYili9jQVllulQErvewySU1vgOnEfqnut2fjcUiGSdr6QALUw3ewNIb4RXxMbo/V0NI0le/rf3RJJh4QXc1jQ6WuNVO80fCYwXKuvgWpkr8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rHCyyC8K; arc=fail smtp.client-ip=40.107.209.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rHCyyC8K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1sMCrEva33aPXpeSVpiccxthnRWwcly0DgVk2ah3dPtuoeh1Hp1C77rraX+4SpycZT3UOY6q3VA8/zXY0QY33Hf95y4+xrd/0k2K/DXErlxbZSZXZpEX363tPUkTCSjOnkDoPtdYyw3CE7Qq8MWRnwcQA7lOrDYyVt9nY0wO/NBah01ofVz9rAQuTZ/xSzVfrAOfDYmfgX4bMeav2m7xx8iHM/7z6F+yYP5DnhrhHsXI5qCzrrOxkY+cfD9P03QrC9C+8JRIul94vkZ6acSbZk2P1X92XNPL3Ae3cqzrvfYQnOSM6IYsxZaVpHqjDO8N4lYj9vXmF+ZpwONxMwXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIUYiI+KDDcBj/DnA3nexIqohBa45BLI6SL6Pmf5uvY=;
 b=rI2QlObWmE2RTYNtauvfUuaGnY97eEg6aoRJLTglR+No/lDELXdgWntm090W70w/O/HU1OMv+lOroBDl1A5ncKfS43qwex25jShfl+xoexVhtrzEaUYsRXsxQsVI8uGvfLlRFfqkAE9ZcAtumNQWY5ZyLtO3ZUPhP35jD52s2kjiqiSX/j/RtBRTo9fg4J74KCevSoynwWMcN0l8cSfArvPCSsycdAM24gek9Eupa1a4CiiaVAkPh4wIFyz00tZD8TA36IcKd9mW8yA0cHtSTmXDeZ/YPwQY2f5VkWGMM2Ica1P5KOmMM5RIQkcTYkfNFwfB0FsfJ8pxycOhqSGTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIUYiI+KDDcBj/DnA3nexIqohBa45BLI6SL6Pmf5uvY=;
 b=rHCyyC8KkzMOp2cW/eWeFe2+SNTWcmxLi0YE1pgx/oAdMzBa9McHmHaX4lB4oAwH8fBBRUzT5uLz+02uka5/A0H1JYlejnFn1AiwdeehX6d1AbYS4UHPS1J13Vmi8mtFlXYzRgnaltR5G+b7gMKJL8qjHfb9vYmCw0TC5rg5t7s9Y0TD3uhUGDfxGlUE5KmL3KBAeNIGFS0F4aISNSat0g9hpWQHdjQlyab9lzDHpDyLmUoINC4YqgAMWcvRXVB0KpTI9S7Znl2CQ0FIl25dpXDp3ochiIZrEf/fpdT0LoIz1o7WbfKaIiR4A+yxlQqn7G4Kmz9J8ckSrAC5eSB1QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 15:38:06 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 15:38:06 +0000
Message-ID: <16e20d68-8d19-45bd-b4a1-f2c067ca44a6@nvidia.com>
Date: Fri, 19 Dec 2025 10:38:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Fix rcu_read_unlock() deadloop due to softirq
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Yao Kai <yaokai34@huawei.com>
Cc: rcu@vger.kernel.org, liuyongqiang13@huawei.com, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, josh@joshtriplett.org,
 boqun.feng@gmail.com, urezki@gmail.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, linux-kernel@vger.kernel.org, yujiacheng3@huawei.com
References: <20251218074950.1936014-1-yaokai34@huawei.com>
 <20251219151400.GA820904@joelbox2>
Content-Language: en-US
In-Reply-To: <20251219151400.GA820904@joelbox2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::27) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: d57f9c9c-4ee6-4789-d5e6-08de3f149ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2RBQnhCQmlrbHZieEhhaElJRXBnekFicUZyVHNkWko5RTZXM2R3UkZkNWVH?=
 =?utf-8?B?V0tSRXFNOC9sV01mS2lNMm5YNW1hOVNVTFhaQllLYkU0MWxZTERvU2E1N3Ew?=
 =?utf-8?B?YWVONEwvV3laQjl1VUtqWEc2U0Y5Q3ErUlpXTkxjUUt3clEvdDRDa0pJOThC?=
 =?utf-8?B?WERTelJwSS8vVzEzMDVGOW9NU0JUMzRQT2pCSC9tTUtNTHR5RmVtZzdmbDY3?=
 =?utf-8?B?cGtnc1h5N1FzUjVwUHp4blVHWXY0Ylhpc0lHZVRpb05aVGQxYzV2RFU1MVNO?=
 =?utf-8?B?ekdyUDV3Wk44bGlQeGV5anIvcmdHSS9mNUREY1FObmw2OERtSnVpdktBWndV?=
 =?utf-8?B?UG5BTVozc1NleDVPTzRwZFczdWRpQS9TYVJSWitDNWVxWTFmT0NYTlZKZjla?=
 =?utf-8?B?VDB4ckhTZXhwdDgvSTFxVlRjUjFuN2tLb09nVVZRcFFqMm84UVV2L3QrdG1v?=
 =?utf-8?B?UHhTNDMzOFZuWk9wUDVDZkpSWFhhdlJ1b1VVU1FTNVQrYXZMNmUvQUZ1YnBp?=
 =?utf-8?B?U3k1NDROTE10SHRROVc2NjVTUXBuaDJOclFpWHlvYXFGc2lRU2RZdXNGZWtu?=
 =?utf-8?B?RnpEOCtuV1hSYUZ4WXQ3bXFKNlYwZEZtbVlhUVlPdGdTempQOVVYcUlvWFE2?=
 =?utf-8?B?RkNrNDd2TDNwWVRLSjFpNHRuWU5Qd0ZIWCsrNmtVMUVQLzFlU1hhRGFQcHJB?=
 =?utf-8?B?c0lyRUJCMFoydkRBaDJVa1ZMRzR4UDQxSmNiUlJES1BxM2NSZ0dEUjhWM1Vy?=
 =?utf-8?B?RlkvWE1iN2xUYkpHazRZb3I2ZHZUTzBLeXl3L0JkSVp4dEVmM2wycHJDT0t6?=
 =?utf-8?B?cGkxWEU4WC8yNHlCSUhOWm9TSXpkcVZGM3JmY3lUaTRtSTNwM0ttbERrWjBJ?=
 =?utf-8?B?L3dNMlErdE1oM2RMdmc5bFBFbnAwUWFOY21SWHZiMURhVk8rRUtZYTEvZUpp?=
 =?utf-8?B?SFFEcEVJNlczaWZ1akxLbytRZ0pjV2JmUGxZaVBjUUxOSy9xYXJzcjRVdlpm?=
 =?utf-8?B?d0ZtUjhTaTA4WDViMGJxUXU5ZXd5RjRlVnQxVDlpbUJvZmZHT3R5YnVlZTFa?=
 =?utf-8?B?dUh1bEl3YVpHMFlDaFMxVFdSWVpJWXNqM2N1c2t5Qng5T250dFJZZ3luK29v?=
 =?utf-8?B?Q2VEa2dTZ3cwRElZS3BseTJ1NVZFdUFQTW10SUtqdWJWZkhXWXVuczBRMXlh?=
 =?utf-8?B?NkN0U1h3MDBjZHR5TjdFQ3lhOHRNa3Vjd3NKQ3E4UkVxWTNDZ2pTaG1hL0VK?=
 =?utf-8?B?dUpwNk9uNGhhbzE5K2VrdnRzbzJKL01hVmt6QlRWQjdZNzVIQ1RCcnhDUzA5?=
 =?utf-8?B?TXp4Y0RGR0RYdXJxb3VZU2Q3cHNoNUVqcHpmbnNjTGd0amREN1E5N1ZMeGQ3?=
 =?utf-8?B?OVZGN0tyaVJNcitRRS9VM0g5eGlCY3VSWjRkN3I1cGg2M0JDejJmT0dscHNt?=
 =?utf-8?B?VUZpem5xeloxaENreGNVN29wU1d5Q1dNUFpNc1JrdXZiQm5MVzdxVjVrdEFH?=
 =?utf-8?B?NVhNWW84MHpiNHZUbEJPRTRacjk5RlByb3NaWHArbHl6MklTRWllZURraWVs?=
 =?utf-8?B?NFhwdU8xaHoxakRVYjAzSEFaU2NiM3dML2VFTXNrNnFtdHVEam9uNXFkSHN0?=
 =?utf-8?B?dWQxN0k4MjVrTDdXM3Zsc3NMYjNVa0tXYlBUR0hnMnRsbWlJQm5WUkZnQ2pP?=
 =?utf-8?B?K0VSdm1pdHg4RmQ2azIvTVJob0x4dlh2Uk1LL3hRcm5DeUN6R3VZSnNNclkr?=
 =?utf-8?B?SmFjU0dHd05jdzlveUVYYk9tTS9DcGNaSFAzYmc0ZUEzS1I0bFFkbUlyTzRP?=
 =?utf-8?B?U1pZcHhOUlRaUFp1RDIza0NmMzN4YlZQakJQbGNsM3J1Z1dWMWMzNC82NFZJ?=
 =?utf-8?B?SjRKV2MyQkdlTTFoLzY2N0k5d3BnZkJ4bDVnYTBlQlhaRGdMbndxdXlHcXA0?=
 =?utf-8?Q?C1rjnzU3C3H7mxL5XgUxuDLBVVooxZyF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjZmUlBxOEQvMURoeUgyV1VSbFBaL3hQWGViRzVSYTN6RnlvZWlBaWZ0a1VW?=
 =?utf-8?B?WlBmZ3M1STdFYy9FdHRoTUhvL2VYdlNNRnNIcDMwb3dPNCtzZ3l5ZHcrN01S?=
 =?utf-8?B?QTJRellRcWlwR1dnU2VoOGZHeHM4N1FEckd1U0paWjBQWVQrNDQ3TmxwQ1NO?=
 =?utf-8?B?ekl1ZkxnM2Y3WXVqOG5xOTVwWW9SZWQ3U2F3TTdaaG5WL3p0a1RQWGJIRm85?=
 =?utf-8?B?RkNQRGs1Q0lhOGZERzlhNENZSURZb05FREhvOTZBMThWMVVuOXp3VlpZSGtx?=
 =?utf-8?B?cjkxa2lReG02TlVHR1hCRzUvL0Z4VVkwa0FldEZzR0NlbzJSRXg2RE5UWStK?=
 =?utf-8?B?Nll4THlMSGFmSCt4MUY0UThpR3pBRURmZnpWZzJzWXcwWE54MEltVmJOeXBT?=
 =?utf-8?B?WXFUVnlrTXlZY0RvZmErQktEcnJBcndJVUhObXFLWUkwYnRHS0s2WHV6ZWVR?=
 =?utf-8?B?c2VLQzQySDFJRGtEU2paN1AvZUxaTlBVMzNmM0lJU0gza0oxc1dkdFZBZWhS?=
 =?utf-8?B?Z1luZDV0MkQ5L1VLa1JkQ2g5U1lSMzMwZE5IZ05xTzc5M1J1bUJ1UU9mM2s4?=
 =?utf-8?B?WFMvTStqTlMxb1M5WXd6UkdiWEh3Y1BHclk3QlJURmMrMkY0MHd2OHJrTG9S?=
 =?utf-8?B?VVRuUWpyZFg0RS9uVmMwMVQyWUVmTVpsVEhyR2hZSXkvRHhaWjRsamNHNWYy?=
 =?utf-8?B?bUJiQllFTHRXNVgvYXByY3VzNnhqNXJzRG45UmY5NnRCOGNURGlhV1RlTGYr?=
 =?utf-8?B?N1VhRHhZTTNzdk1WSHVSS3JaMy9TTTlvRUlJeHZ3NThpbjR4NkNTcEZ4dlV0?=
 =?utf-8?B?MDgvcFpEY1g1STd3aHBlbEE2d3czNWdoSVBJY3ZpK211Kzl0QU9kYkt6OXdi?=
 =?utf-8?B?WDI1aVRJbzZQeklqUWFWOEdsVVVMdVY0Qkd2TUNoL3V3TlZ0TGJISlRObUsz?=
 =?utf-8?B?OTk3VmNYcldVaVlUcGF0cTFUVnZiSkZra3lsV0NrNWVCK1VQdVl5N0tKQmp2?=
 =?utf-8?B?QWxpOSswOEtEUkpMWXk2cnpMODJFbzZSUEZRWFJFMVRJaTQ5Qk55bDlQcTMv?=
 =?utf-8?B?L1pxSXJCdFFEaEREZDY1ZWt5clFpa3UvRjJjcDJpOXVFdkdiZVBFZTB5cnEr?=
 =?utf-8?B?Z00zajN3akhHWCtITjVGZjJ2bFBwZ1ZsRjA0YTEzeWtEZ2VhUTl1L1pnb3VT?=
 =?utf-8?B?Q3cySVJiczhiYVIyU0oxZ3ZCc29FR0tOODhrSkZVUHB6TEw5dHRuUWpGdjZR?=
 =?utf-8?B?MTU1R0hyV3IwZnh6eTkvMXYxTXFxM2RTMWwrc3J6cTVBOGlaVkxlSXRNd3Fz?=
 =?utf-8?B?TUZmODA5YWs1bUtHbGxSVVZFRkQ4QXhtcS9DWm85OWRNQnFYVDRrNkJrUDRJ?=
 =?utf-8?B?QWNsSUtiVEd6cGtqMThqaWdyYlNDakw2RldydGRsNjhsMVBBZWJQZnU4R05R?=
 =?utf-8?B?WmJETHdrTGV1dWM1a2tjcThncmNkWDZQSzViQk5lcVNMYU9rb0xKbTB1ZHlN?=
 =?utf-8?B?ZlJUQjJ5YXltaStsbEVJMExMbUg0cDV2MDNBeXZMZmljV0lTcEZ4M2U4OE14?=
 =?utf-8?B?L3d6OVVCODBrNDVqT3h3YjBwK2lDUDY3dmtNdVNXeXFZMXZ3bmhpckZSQVlI?=
 =?utf-8?B?MHZuZkgrZVBwSms3TXE0MXZiWkh4VTdnVXgvb1BKeldSK2dNY0VneU0xdTBY?=
 =?utf-8?B?dXZSUThLMjFwelh1dE9uNzRnbUFoOGdiNHdKdGlScFNNSCtUZ0VWQ0x0M0pp?=
 =?utf-8?B?N3lzNE9PeFYxbUZwS1dINU0wT3VTdVRTc1hzQ3V0QmFqRndEelVIOVAxTSts?=
 =?utf-8?B?d3V5cjhna2JzZGl6R3F1R21pVTZzc0Z6TVQrSXdDSjlIOUNMdVhULzVkYWpm?=
 =?utf-8?B?dklMR3VjYnhYZlZNcUF2YmRpcHpaa3ozSTFKb0JtcmcwZ2cxQ2l1UmR1RTU2?=
 =?utf-8?B?Y25wUWVNWXVKa2diQ0FyeUJsMXRSdzQ0Zk1xNlFFbllFK21FVWVVc1NqYUh0?=
 =?utf-8?B?QzUwZW9yOFdjT1QvdWZmbmx1UzBrb0YxMEJzZi84NGxieUp4TTE1RUVmWEZs?=
 =?utf-8?B?bDJQZWR4ZW1vb0dtQ0dJU0oyL3FHWmd5Yk5CUE5aZ013b0RCb2RiajdnQU5o?=
 =?utf-8?B?VFZiVXZuM29aazcwRGhuUHpyTnFLZkp4K0phcFdmMkdpWGVlcXV2VVJaTUxx?=
 =?utf-8?B?RXBHZlV1MkdMZko0d1hRYXMxUnNlQ3RCd0NqaXpqcmJWOWtMLzJlVGkxUkVN?=
 =?utf-8?B?TTN6bkFZYUl0MWdJYVRmMEFEUUljSjAxQmJZMm1WeXoxRUFMWFVybXFxUGVC?=
 =?utf-8?B?MW9UOGJ0ZkNna0tsTDY1ZXlEeHprei9Wc0tlRTY1VFRTektlSlBYUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57f9c9c-4ee6-4789-d5e6-08de3f149ae2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 15:38:06.4564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaGVg316BYaw3rsm/FcWEdDk/XYydpn2YObKjMWjopL9HLv9P+DRB4d5qWEAQgmnXNupVP9ba/9KPsGv5LhATQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358



On 12/19/2025 10:14 AM, Joel Fernandes wrote:
> On Thu, Dec 18, 2025 at 03:49:50PM +0800, Yao Kai wrote:
>> Commit 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in
>> __rcu_read_unlock()") removes the recursion-protection code from
>> __rcu_read_unlock(). Therefore, we could invoke the deadloop in
>> raise_softirq_irqoff() with ftrace enabled as follows:
>>
>> WARNING: CPU: 0 PID: 0 at kernel/trace/trace.c:3021 __ftrace_trace_stack.constprop.0+0x172/0x180
>> Modules linked in: my_irq_work(O)
>> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G O 6.18.0-rc7-dirty #23 PREEMPT(full)
>> Tainted: [O]=OOT_MODULE
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>> RIP: 0010:__ftrace_trace_stack.constprop.0+0x172/0x180
>> RSP: 0018:ffffc900000034a8 EFLAGS: 00010002
>> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
>> RDX: 0000000000000003 RSI: ffffffff826d7b87 RDI: ffffffff826e9329
>> RBP: 0000000000090009 R08: 0000000000000005 R09: ffffffff82afbc4c
>> R10: 0000000000000008 R11: 0000000000011d7a R12: 0000000000000000
>> R13: ffff888003874100 R14: 0000000000000003 R15: ffff8880038c1054
>> FS:  0000000000000000(0000) GS:ffff8880fa8ea000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000055b31fa7f540 CR3: 00000000078f4005 CR4: 0000000000770ef0
>> PKRU: 55555554
>> Call Trace:
>>  <IRQ>
>>  trace_buffer_unlock_commit_regs+0x6d/0x220
>>  trace_event_buffer_commit+0x5c/0x260
>>  trace_event_raw_event_softirq+0x47/0x80
>>  raise_softirq_irqoff+0x6e/0xa0
>>  rcu_read_unlock_special+0xb1/0x160
>>  unwind_next_frame+0x203/0x9b0
>>  __unwind_start+0x15d/0x1c0
>>  arch_stack_walk+0x62/0xf0
>>  stack_trace_save+0x48/0x70
>>  __ftrace_trace_stack.constprop.0+0x144/0x180
>>  trace_buffer_unlock_commit_regs+0x6d/0x220
>>  trace_event_buffer_commit+0x5c/0x260
>>  trace_event_raw_event_softirq+0x47/0x80
>>  raise_softirq_irqoff+0x6e/0xa0
>>  rcu_read_unlock_special+0xb1/0x160
>>  unwind_next_frame+0x203/0x9b0
>>  __unwind_start+0x15d/0x1c0
>>  arch_stack_walk+0x62/0xf0
>>  stack_trace_save+0x48/0x70
>>  __ftrace_trace_stack.constprop.0+0x144/0x180
>>  trace_buffer_unlock_commit_regs+0x6d/0x220
>>  trace_event_buffer_commit+0x5c/0x260
>>  trace_event_raw_event_softirq+0x47/0x80
>>  raise_softirq_irqoff+0x6e/0xa0
>>  rcu_read_unlock_special+0xb1/0x160
>>  unwind_next_frame+0x203/0x9b0
>>  __unwind_start+0x15d/0x1c0
>>  arch_stack_walk+0x62/0xf0
>>  stack_trace_save+0x48/0x70
>>  __ftrace_trace_stack.constprop.0+0x144/0x180
>>  trace_buffer_unlock_commit_regs+0x6d/0x220
>>  trace_event_buffer_commit+0x5c/0x260
>>  trace_event_raw_event_softirq+0x47/0x80
>>  raise_softirq_irqoff+0x6e/0xa0
>>  rcu_read_unlock_special+0xb1/0x160
>>  __is_insn_slot_addr+0x54/0x70
>>  kernel_text_address+0x48/0xc0
>>  __kernel_text_address+0xd/0x40
>>  unwind_get_return_address+0x1e/0x40
>>  arch_stack_walk+0x9c/0xf0
>>  stack_trace_save+0x48/0x70
>>  __ftrace_trace_stack.constprop.0+0x144/0x180
>>  trace_buffer_unlock_commit_regs+0x6d/0x220
>>  trace_event_buffer_commit+0x5c/0x260
>>  trace_event_raw_event_softirq+0x47/0x80
>>  __raise_softirq_irqoff+0x61/0x80
>>  __flush_smp_call_function_queue+0x115/0x420
>>  __sysvec_call_function_single+0x17/0xb0
>>  sysvec_call_function_single+0x8c/0xc0
>>  </IRQ>
>>
>> Commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
>> fixed the infinite loop in rcu_read_unlock_special() for IRQ work by
>> setting a flag before calling irq_work_queue_on(). We fix this issue by
>> setting the same flag before calling raise_softirq_irqoff() and rename the
>> flag to defer_qs_pending for more common.
>>
>> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read_unlock()")
>> Reported-by: Tengda Wu <wutengda2@huawei.com>
>> Signed-off-by: Yao Kai <yaokai34@huawei.com>
> 
> Good change! It is the exact same pattern and both IRQ work and softirq
> raising are for deferred QS purposes.
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Could you please update the following comment in tree.h to say "An IRQ work or
softirq":

/*
 * An IRQ work (deferred_qs_iw) is used by RCU to get the scheduler's attention.
 * to report quiescent states at the soonest possible time.
 * The request can be in one of the following states:
 * - DEFER_QS_IDLE: An IRQ work is yet to be scheduled.
 * - DEFER_QS_PENDING: An IRQ work was scheduled but either not yet run, or it
 *                     ran and we still haven't reported a quiescent state.
 */
#define DEFER_QS_IDLE           0
#define DEFER_QS_PENDING        1

And resend the patch with my Review tag?

thanks,

 - Joel

