Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563863612EE;
	Mon, 13 Apr 2026 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776108245; cv=fail; b=JaHQwK8C5na78Rn4uAkmYgDDSyyYhOKvaVaEwg/gZfUU83sNyeWcaq+8iWCVZ7RHcMFbXrVn5n24U9bfNZXZq5FeriTlY/y+F+hP/FsbLXjM9xhYEexDg8PnUHTIiKKHbnp7NDBVPA7FzH+8qT99lLu/XLX/PT6YZUaClfkZ+X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776108245; c=relaxed/simple;
	bh=OnAplS0FjlKzKvBSxtXbLHxbWmgxFdHzTXl7tsoK2N4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PPynhmkF1CwY4aIPTcSOBA4UHoPSJxXXwCH79f88s1ikmyXotA6x5a3lsTxdhIv98KM+aKi8UY9yOZnBdd+dIz29BF0PYWo18fu4jXoNTImw2oB5SoXBHHJHRED0rTtFL0RaV3tzhVBqyUg/i3fnz+vTt9ZXbRMK5IO006gS4Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bjHnJCru; arc=fail smtp.client-ip=52.101.48.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bjHnJCru"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRyyIOBr9rCG7z70n6uDuGtA1XJDw3eWl+oE2H6oj8ZzthSb+wNkRNYaEdapDIWmBBpWdWxpfx7+TQ23pjjZC55y9RWlPMhvEvlG+0bufdzowTDkMuSgxTc6706cwrv4gu7YM4fjPNh1PQC8YH1FRntsRqzfk9NpIFl4p6JJlAfkfKBaK1QS4h3jNwqdqqx+2P2tq58qpAmoLpNZVIkaOE/WMzKyc2OXM8kPLOmYVRmZkQUL/NXWkL+NMI8r62fgMiInhxv6QVEhiXWsG+yshk44ZzhKWNQHB+1s61ljlmKvpIryGNx2g/DgOvLo+OxvTU2NFk4u/vobXXkCY97KaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYb5bxT6MB/ePjQL2YwYt/t8g+v+L55SKPMxAkPng5c=;
 b=XoNyINCbsgNqrn2uEHJ/IK6qlIjScxDB/QWp/vSvJQz/FE40NUB9fd6qiJF/buaVU68w/NhExXqU3gvsDSLfUXt3TMghUgDqlxKlz91Y2drUwwI4vi8NrPy8FPLnHlei39Ma/T99CNePekUocGZoxS2ZYMpD/bMKIRvPy8vk8eRG/1UDPK86aPPjrobR4K9jkOv25PXMFUhWH7zjKKmTyvKNMAJgX4SKa5AmnfsntlydNReqPOXQmukvnhzUroqgxAn7ja7od2es9o3StGzCFczCHVp6KaxKV80MYhspalEgdnbKIgjWtSP8+FFeCD356NufolvsXcfAgdNqDjuOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYb5bxT6MB/ePjQL2YwYt/t8g+v+L55SKPMxAkPng5c=;
 b=bjHnJCruQ89oBRNh/Ck3jw2ruxg+dOv+dv3q79o+I4QkXRysrium1YNE0rYI9IDlVldUqVV6ZBuOC363ST7s6HmrYmi63OP7NDGvwYw3TJAje6JBpfeGAfGXOGmracCr+2bmGkJwX/iJipOKTmq4xFiW2kfEfU2o7I2+JtlQoim8wgXf5PSomptPLpQZBdQHSmvFS8/CGgOo2If+BoSRjBZUX4gAB+bruTi0cn+JdtIm7zo+MNtUokgp5fdMEw7vOyMw69aMZnWvknr+Smte1YKmLtvSrRtWzsCwqfJM2B4O28xESf5hsa6uemWpultNr76wDaFY1euUbrg9I5xLbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 19:23:59 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Mon, 13 Apr 2026
 19:23:59 +0000
Message-ID: <6c687f78-1a5a-4d55-95c2-c459468580ba@nvidia.com>
Date: Mon, 13 Apr 2026 15:23:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] RCU changes for v7.1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, joel@joelfernandes.org,
 agnel.joel@gmail.com, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 Gustavo Luiz Duarte <gustavold@gmail.com>
References: <1774978730.3972500.27807@nvidia.com>
 <CAHk-=whigg3hvOy7c1j1MXFy6o6CHp0g4Tc3Y-MAk+XDssHU0A@mail.gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <CAHk-=whigg3hvOy7c1j1MXFy6o6CHp0g4Tc3Y-MAk+XDssHU0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::17) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: b7792656-1888-4df5-9ff1-08de99923642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3Jm9rTn7gDZgeICHvz7XPBM0qhfrFtS0nleTwVpKXrhCelZJ0JHMfeYdrXokHx+4zccJDh0knmtsxpkL6EeOkfDkZ5zhxaL/wn6+MsHKhC0BQonwiT7GYXt853bpph+wv1Gk2VUAtNrrLXuu7qQJde/BynI9RaJT7zUSxiq44YoLT3atRcNO4e9Goj+UBjNWaRswT1CO91jPoToe20KY3J49qMW7Ut63p2T772Qzbm/f84L8fQLZG7Ym2sylskerPGC1RpTOMAXLNRt3kwhVZZys0iwxza9KYWFKmA+j82EHKN+j87a90/nB1QTtqT4L2Xt5myXA2hVtFtuia5nIM4/UwmglX9fmapGTe2o5VLrkXbPrk8Z5NJQjGM+ZrQbqjlpzkSjzKVom3DldkgtgSgbKJDgKXK+rkTpgZ64DPfPAaPVBDcA87nn+SdyYk5J2Fwv+xB4jajnQ1+85MA/PwiAmdoO6PXvBR+3UWx+LUgkuB6tpDh/Z+5ktr/rXQxyUNPqFmthMYC9zDRcYyQBKIQBXF4PI5w7y+NtaFFIpCTr0jH+anJAOpKLgwFZKAD6D9Q4Lu1UU8l8ahIfVrkX5ZTJAezxcYo92mYDRKudE761jf6A8onOIHfOLzxyc2Q0rHYrYDBu+J2l1yD5CoJUiyyRJwKQkjzI6DHN8Uz/2z0tGFMYbZdCTx6H1ucncHqh9cwBnQtLX1sr9EMeXGrRvB/pa8YlNS77pCvHORKrNmEg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU5tV1l3azVWaVFmTzFwUGdpOEo3cjN3R21NTExqbWpFWTZsL2t5aUxrQ25G?=
 =?utf-8?B?bERsRll0YWo1K3czZXYvL3ZOdTRDVlZWcGNra0hIanhvK1Y1N2FXeXRVOENl?=
 =?utf-8?B?ck4zL250eTY3UVl0V09QUGs2RmJGZGo1SFhjZFhQbWJFU0NYME5KQkE0UlpT?=
 =?utf-8?B?OHNzRHVhU0FKQ0s4N1hNcVB4MDJUdVQ2eFhjSUJmMDdaWUR1MXJCODVjbUpu?=
 =?utf-8?B?cVl1NHNvcE5lY3Q2K1ZQTFRSb0s5K1pLN0JrYzFQaXF2bFNiUUttY1liUlM0?=
 =?utf-8?B?TXhwOEVqa3UxUHY4cTNZNFZOazBMcEQvSmRDZTZ0Q2d3anpKeTNjemVEbEtC?=
 =?utf-8?B?ZUdBZENtS2FCWnNYUllBSCtSTnJsZEFBSGFhbTBYajF5UFB0cDB1K3hrbEEz?=
 =?utf-8?B?dGdYNVJ5Vi9hdHdZUEs1K0g2SGtHTzd3QjZoakFqQk9CdXRNczRnL2lWenZh?=
 =?utf-8?B?TnprMXRKYUhPbTh6V2tjM0RWM2hBRk4rRVZ4S0F3OUdpOWtoMWhjeEVjOHQ0?=
 =?utf-8?B?T1pZUXNkbThhb3VFcFduSG9Mc2VFTTNVekxjUS9zcThmbUlGQVo3TzNoL3ZM?=
 =?utf-8?B?QlhDYjd0ZXR3RmdyUGhjUkdINmJRSCtGdlM2QVYra3c4cFJYUGZVOTZWNk5w?=
 =?utf-8?B?NUZKZkJnY1lwb3h3M285enJQcDBsWm4wd2gySkJKaDZTQWxIZXp3NnV5RkJE?=
 =?utf-8?B?MG5YdHIyeUk5bmVLNmZxbG54K0xXMVJPZWVsa09hRFJqTFJpUTRWWTQ3aW9P?=
 =?utf-8?B?OHFoZEJDcXd6T2Z1K1FuOGNJNkVKZldyM0xmQS80NnBnT0Y2dDRjWUV2cVJs?=
 =?utf-8?B?REN5Kys1ZVlIZU12c1p2ckFyclA2QUUybUpuY1lJWjFyNDI4cE1neVhabkJj?=
 =?utf-8?B?NG9KZURYcVJTOHh6ZHBrenM5VHdkZkZiMGNuTjJQcjlZeW1KaHNTMUdVeXRK?=
 =?utf-8?B?UHhmS0xneE1NTVFmK0pRbk9CbXlEbm9XTGRMYzFqT0JZRVB5d2lGZVJ4RDN1?=
 =?utf-8?B?RjYyMjRTeDZpcnNGSmMzaWl6UkZVR1VQSzQ3MFJkUWZEa1JFd1VHaGV2d1FE?=
 =?utf-8?B?UXM0NzJadlFPY3hEVy9ESXpYZkRSSUtTejg3OTNnei9JR1VFRk1MY0NvSDhC?=
 =?utf-8?B?aFRLQXRqc2xkVUNtc2U0Zzl6cXJqcjMrM1g2SUJoUzRMZkI4dSs0bytKK0h4?=
 =?utf-8?B?c3VUMGdoWmpIVXAzbENTV3lpWDVEc3QrTGtOUWtxUGFlR1RSTFlrb1pvZEcr?=
 =?utf-8?B?OFIyWVhSY3JBZ0ZzRTd6d2hhWVJqT0FZV1B6RGhERGVDVis1RGhKeDB0NVB3?=
 =?utf-8?B?UlBMazFrOGphc3NRU1VWVkExUmQyUlBDN2hrRGZRbzFRT05XdmZYcXhGS1hI?=
 =?utf-8?B?K0dIOUJLb2V4aVY0RzUxQkdmT09ZUEJCNUZjZjlieDF3YWRWTFFqazk3ZXNl?=
 =?utf-8?B?a2FZaTVMUDU3eXVrQmdBWTBGbERLcGJvZ3duZVdDUVhvRmZqYmVEd3g0ZUhG?=
 =?utf-8?B?TzBuUEVYa2FnQlVnY3VpVmtCdms1RE5JNHp4bE1Ic3FXcWtRSEk5dTNXeTdp?=
 =?utf-8?B?aHpSU2NNeHk4VVRVTFgyUGNCRUVTTnR2RFJiOFo5OFJQZnJmc1hMNU56ZDlD?=
 =?utf-8?B?bDZJT1FwS0t4aU5sZEV2NGdiR2JNcDZCUjE5VU5mUEhFRlpudWZzcnU1QkFO?=
 =?utf-8?B?bFB1UHJWMnllVTMySDc3SnBTSHg4Q0xIVk9oMk85UUVpNmNnTHBKdnFHZUUr?=
 =?utf-8?B?Qm85U1BVMmhhWDlndzRTZ0k4cnB3cUR0bHdwdjlWY3hVR1pTRnJXVVk5UDRD?=
 =?utf-8?B?dW9menpUSm9DdlJ0YTcyaSt5bVh5WEpadDV5b2VjZmI2M05MOUZ2WWdPaG1v?=
 =?utf-8?B?WlJua01xakJLOTRlZDVuR1hlY2RsQUFIaVZtQW50SHBpSG1qY3ZaZVU1d0tO?=
 =?utf-8?B?WWYzdGZLM25OcDcxdnpYR2VEZnlmZzNWZVZaNCs3em0xckptNFdsMXdnUFVI?=
 =?utf-8?B?Z1dzYldJU3hyNTlBNWRMS1ZLYzVrTnMxZlhkdkpNQ2dhVEpua1Y4Y1RBRG5Z?=
 =?utf-8?B?OTlMamdzcWtibG5DMWx2VE91RS9BMWhtMHYzSEs3d2gvcDk1ZjY2QXlmb0Fa?=
 =?utf-8?B?TndZNk1ycTdrbHU2UUNvbTBzM3Z3b0ZsZXpKZTFDcE55alNzQ0llU3ArbGpo?=
 =?utf-8?B?UjhmQUxFMytHSHFHOThKalJrWnNTZXFtM2lUN1FGelI0VWZIck00aWVJRlhL?=
 =?utf-8?B?Sy9kWitjV0lCN29hc3VxVXc5ak1WV2lDUHhnNE1LL291a2VFdTJZem5xRk4r?=
 =?utf-8?B?N2NuemdMOW5hZjMydCtZdTNtNkVYd1pVaGovckJlTm5odnI2cExQZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7792656-1888-4df5-9ff1-08de99923642
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 19:23:58.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJM9klze1yhytadii0bxgJNBIqBkyl4RoBqVEIRR0A83vlTBlQ+KSR+CPddDUCBa9EQsgazIfx7du5aG5bf6oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253



On 4/13/2026 12:40 PM, Linus Torvalds wrote:
> On Tue, 31 Mar 2026 at 10:42, Joel Fernandes <joelagnelf@nvidia.com> wrote:
>>
>> RCU stall:
>>
>> - Add BOOTPARAM_RCU_STALL_PANIC Kconfig option to allow triggering a kernel
>>   panic on RCU stall via kernel boot parameter.
> 
> No.
> 
> Dammit, stop doing these horrible things.
> 
> I've said this a million times by now: the kernel config phase is
> probably one of the biggest pain points for random new people trying
> to build their own kernels, and we DO NOT ASK PEOPLE STUIPID THINGS.
> 
> People who want this can damn well use the sysctl or maybe some kernel
> command line option instead, and we DO NOT MAKE LIFE WORSE FOR
> EVERYBODY ELSE.
> 
> I have removed that disgusting kernel kconfig option, and I want to
> make it very clear to people that the kconfig files aren't your
> personal playgrounds: they are the most visible interface to NORMAL
> USERS that we want to encourage to build their own kernels so that
> they can participate in kernel development.

Linus, I am Ok with dropping it and thanks for doing that, no problem. sysctl
sounds like a good option to me (CC'ing the patch author, Gustavo, as well in
case they want to go this route).

Regarding boot params, I guess I would like to add - sometimes it is difficult
for people to change kernel boot params (coming from the Android world, I
remember setting boot params required changing and recompiling the bootloader,
and it was much easier to recompile the kernel than the bootloader. The
bootloader came from flash memory and required special signing processes etc).

That said, I totally agree with not polluting and complicating Kconfig
unnecessarily.

> 
> So people: next time you feel the urge to add a Kconfig option, take a
> deep breath, and look at that Kconfig file, and go "Maybe I can
> instead remove this *other* useless option instead".

Noted, though, in this case "removing the other option which is to
panic-on-stall" does not help, because not everyone will want to panic-on-stall
by default? So sysctl to turn on the feature maybe makes sense (for those who
prefer that over boot parameters).

thanks,

--
Joel Fernandes

