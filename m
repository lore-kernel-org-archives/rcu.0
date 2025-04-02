Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784E4C92;
	Wed,  2 Apr 2025 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743605140; cv=fail; b=MmV0t0q5EJ2xlQZl8Np9dmMpSPcdQDYXZdwW1gaAgDYYN5AVjzDNtW5nsVhwaAym2M0kYbhDarpOTVISq/RxznYCLSMKU/eSwW7Q9zNv6WO+7E6HuG3Pqgd89ERcs7NUotBJRxJVMxV7ZdNxJB2T/oL2TYeo0sm89+1VqBJIGdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743605140; c=relaxed/simple;
	bh=o6gSGpRtxQnoZp32J4CXlXKbhzYckR2ULtJ5T4uJW6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VPqYHNnIyjMeNMA7jGlBU/AykPSmTnp0TgaODXoOWUu9vuncCub1iyOg8/nOTLN9LW9EhVKZcE2xBFoAf2bpFizKkLXtw0GwvM70+mRm4/JhAzbjNJs1kmdIzLzUHdRarGFPz0MngDdQiBLodHC8mWn3yzZqca+mg3AIdhrW1Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NDpJuE/+; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NDpJuE/+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6LsAVVq5FtXh94syonVUEmtxgsRgXH8DPvaXrF9yBJy/5QXFlV1t8R9BVYR17tlp3EY6/UQkzvzphRIb7Sf1v0N3HA82MRl7j+4fdUH9TszcBs0y1N6rf79PwZ7/JOkZNGQ6Jvqcf/XBRDZ/p128QXZPpC+nmsRKDW9kFd7sW3zoIof8pNRhy2vuXOZwcLsy8oSPulKnDoG4izlHR5/f2Dwqtj6uhozqVUMhVCqC0mczCTzbeEo2RHZgcpHCxyXrbM1dYDjLrx4jArtIh0xLZevE7TjlVgRIQ/M4GMmyoQ4Iq8X7azQcwWpJmgzYCemFiiORZaDELFg1gQ5PVKreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1DlzpKP3w1MYv7ZvZO/V2CDR4hCRgzgFRrBelZbLag=;
 b=JQE51YeLBUVWFhhP73zvEmbNCHwIMruP7mIVn7nLtSQs5F0VJCHNzICcB4iai2Y+uNmE7ShiL0EAo/arwhbynsGoz4y93iCWPivbrpviBlJhj2EUWa2egYolkoutWegN6XIy0nAIefdofLYPNeVwmu5iyzaSchO8rIHuWBEEp2UHE91PupgNqAla10MpEREWQrRo2Ba0VM434Hv7ncdHk35vV9ptZni598B9oEa0S0VOpExOebift/Z+rIMegZSzm0QGq/XRj5msWiMTLyLfuTen+3YVZ/TnapujZiOuMM/c+CEDTIPVqoqEff47L/lHzCvJ7huc0vHhV9/ko00lQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1DlzpKP3w1MYv7ZvZO/V2CDR4hCRgzgFRrBelZbLag=;
 b=NDpJuE/+KezRuw70QyHJ25rM/xWNimvWMonCcAH7pagdvEs3Bui3ojyx2HGDUwuObAxfSYLRCcfMJZTYhHx4Y840ZGPYb/p/sVwd21XRbYHy5xhXgmggTE1+VcJXtjskJniIul/25g75+/sY4b6XTiNuuQ/XoNaG0R0oLyM+axY3ROH76I3GBN+3oGb+dd/FRntvLtoPOetiZdNunqyOyuIb3+oh4prSGdCmCc47IE2upA7epXGEqsuKasMNCnMk8Rcp2AIBE5H1ocosBxIPyxkVWj5D7eA5tl0ilXIVaoMNm3rJOIYgHqni6PWJRJLvox67hQWyN0/It+sJkTmJeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 14:45:35 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 14:45:35 +0000
Message-ID: <d276472b-3b1f-4d93-89a6-2e2081f403a6@nvidia.com>
Date: Wed, 2 Apr 2025 10:45:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/12]
To: paulmck@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ea1806-a28d-4331-988d-08dd71f506bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWpCcW9FdHFpRFdGa0VnT203SlhQa2lWd3VZRmFBZFZXakIvRmtWaWhqVHM5?=
 =?utf-8?B?YkFZSlBiV2tad3BrRVdhOWs1OWlhMjFXMWM3Sm1tU0hZMFVjQy9CZmhqZHBa?=
 =?utf-8?B?dG96ZU00d2J0VmNGN3hyNHd0aG9Kdk1KM2xYM1pJK2JsQVNWcUtOTURKdnhX?=
 =?utf-8?B?VWZzRDE1dVMrMjh0VlBhZzNzWnN3YzdqTkpDSGRCZWtodHdsUVNDNnFKdlM4?=
 =?utf-8?B?L2Rrb0prSEFyNkRZV1NqN1pIa0JLOGtXMXVvT2g2akJidkd4aXR2dndzMERI?=
 =?utf-8?B?Y0RESjZLRi9UN0xBa2l5QmxvVDQwU0UrdjBaZERKSDNObzVRMmdXN0t3RHNs?=
 =?utf-8?B?QkpiWXkvMkkyQzk3Yk5JdEg2eUNSdFJORHk4Zzl3WFErNnlxVHN3VlJDK0Fz?=
 =?utf-8?B?Zkc1WDdLRGVkdzZ3K0xQN2VWQWhzTXN1QXVmZ3g1MGljVkhjQ3I5c1ArMU5M?=
 =?utf-8?B?VEZVWVZEdkxBbWFDbW0yaDZmQ2NDSG1Hc3VKWWc3MlMwMWpjVStzOWlocjJF?=
 =?utf-8?B?d0QxWmkvN0FiWTlXaFdWSU92Z1V3cFBQTkZhTnRPTEw2NFo0dHNsS0Qrb2dH?=
 =?utf-8?B?RnY5RUxLN3RXallnWXZmUUhWN2VSMTg2ZGIwcTg1a0loNEtpNklieUdKYWRK?=
 =?utf-8?B?eE9yZVBQTHorUk5iSVpGOC8zOGQ5Zk11K2pBejBrU0dsKzR5cU00MlZoRXNw?=
 =?utf-8?B?b2FzK2dCVnlhdS9pdlU5YTRyTnBpV2ZrNmRLN3JTZXlNY3RKWGRmNVRObXRq?=
 =?utf-8?B?ckl2WkZsaUk0ZGNDQzgyWEpWT2FhWDIrbWE0b2cyMUFpUVB2aTlUNHNKVUxq?=
 =?utf-8?B?dFdwZDRBZCtlS29mNHBQZkV1bVI1ektHQlFkVExqY2t0dUJPdkFpQUlpdm9J?=
 =?utf-8?B?UWZZYTRPV2daTFR6KzgvaHE1aitaNWVkQkhDUXh0MkdTbFhua2xienhoWjZK?=
 =?utf-8?B?c0RrdXA5dEZpeEZWcXVCOG9vamdtRU1QV2FvR21zdnVFVVM5R01XaEYxWkhK?=
 =?utf-8?B?YUUva2VsOUVSWWpPVE1OK3hkZSs4N2F0cS9EbERNekFCSjNPWFlaaVdkWlBr?=
 =?utf-8?B?KzFtYjdrbTQyZSthQmNjcThCcUNBZWRGM0pmY25vbGlsQkVETDZsRXI2Q0Nn?=
 =?utf-8?B?OS9YZTYzY0hxNVU4d0lxZTZhb0JHcXVlOE5SbEYxdTJHWlZDUkZFL3N4ZlRU?=
 =?utf-8?B?RTQrVy8zTGd0eXhDdHpzVWZWMDduUXUyL251UmNyYStUbXc3cCtFdUNodFRk?=
 =?utf-8?B?andvNmlFZ29jZEhSVUxCZlVocDF3ZTYxc2o4Y0xoMnU1djAvN1lFaUg4dFZp?=
 =?utf-8?B?T09oelpNVUU1VEVJSW1jc2Fmd3JCV1FaQjQ5dU1yREgzS1lwcVFwQWg2aGo1?=
 =?utf-8?B?NzBJeVVOR3JEb0NBdWc1NW92aUlIbVU1M3BKTWwvSjhrTVhPT0ZBb1MyQzNx?=
 =?utf-8?B?d1JvUHBFKzg0VCtsQzdLWVh6d2g0eXpydlk1TjhWbWEwWlhPcUZXZG5mMVJR?=
 =?utf-8?B?UjRRK0R2MW1WREUzTkxLTUswYUNLYVRLQjQyZlRUSGc1RFZRZzB6UDJjYUNn?=
 =?utf-8?B?M09KSlZIVXgxVDF1em9rNnh3RjAwSkNQV0lmM0JMQno5M3hLQmdCQVllR1BE?=
 =?utf-8?B?eldZREdVZWs3RjhIdjZYUk1kVGJKWE1WOTVGb2NKMXNaVStBejRrcXVHRzQ2?=
 =?utf-8?B?RVNIMVJYWldsUTdOanN0b0ZJaEdUclhmUENhOXFsTnVxOGlQK0ZZVXgvTTEz?=
 =?utf-8?B?cUVrMms1MjdITS9FVzhPR1dkeGs3WFZBSFF3Q3BVcUZ0aVVVam9nKzZRT040?=
 =?utf-8?B?UXV1aHdVM0xZR25tNmtjWVJWZkVaUForU3VGenZNMlJwZjdLYUtoQlhKN1Iw?=
 =?utf-8?Q?GzeZYb0zFB+Q9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWFXY0lqWkdaNWZJQTRwSFhlb3hNakZwYVArbStYanp3clpFK2h2aEFDN3hZ?=
 =?utf-8?B?RlJyb0lMNnQ1bURrMVQrZmdnRjltaWNuZXo2THJXTG1jckZJZTE1ZElWQUxO?=
 =?utf-8?B?ckZiRnpuUmRGdTdJdWZ0MTJlRmtqUzhjQ1c3SG5ydy9yRFdUNjI1REhOeE9Q?=
 =?utf-8?B?YjRteU5QRmQ4ek8zSjJ5R3h5UmVRUGo0TWpiaTM5NGRUbHdtOTFQK0dpRnF0?=
 =?utf-8?B?ZzlKNFErSk11MjFrNWdvejdFYjYxeDJ0MzRubml5dU9jY1B1L3NSdkdlbXBk?=
 =?utf-8?B?Zm5PZ2ZoQTNhQkZQcS9KdXkzdi9kYlFjOW0ybjhzTlhvbE1vNndtdkhVMmlK?=
 =?utf-8?B?VWFBeXFVZFdSMXFZVDd3N0gxendrTFQ5Sk9nODlIUk9xM09JSkdnWHdMNzBR?=
 =?utf-8?B?TWRMWTdwbW1GRnBDb3NOYmFreElXRnpGTnI3L2t2WFpZdEtyYVFHWDBqZXhG?=
 =?utf-8?B?cFZlQjZtQXZ4b2NzOS94M2ZkdDJrQldhRy9CM1NKdWYxa2dvdXhPdkcwNVQ4?=
 =?utf-8?B?UTdqT2IwSHJXQnZiZUZDak95N1NIVVlWMisza3JWYXZ3NHRPcFVVbGdocnBG?=
 =?utf-8?B?TjczenhBL0FtK2Y4dWZOWlNuSURMdSs5SVlqZFNHMGFZdTZIeW42Y2srWWFK?=
 =?utf-8?B?c1VPclFCUEw4ZkI5Ly95OXkvRllOUGZMa2UydVJ2YTRaN2VPMlRQQmdwdmpH?=
 =?utf-8?B?RHNkcTlFTDd6cjdmUloyWVNqTlpINHpjVGw5eDlPdElhWmdiOWNicVhjZStQ?=
 =?utf-8?B?ditxakR2dzR3bGp4T3hKempiVXlOdjYyMlo4S2lOWUxwRko2dFZLelB5WXI3?=
 =?utf-8?B?TXA2S2FYTjcwMURmOER0T0dTcGF4RHd4R2pLaFVaT0ZyRFFzRlZZUEp1T0FF?=
 =?utf-8?B?dVBaTE1WN0ZsZWxZSHB0VzI2aEV3U3JranMvMSthYUUzN1pPVG1oZ09lMjF4?=
 =?utf-8?B?VXYzQmhJbWw4MGVSMkhwS1Z6QzBiU2dSYTZJdU12ZTRQZThNK2lqRllKZzln?=
 =?utf-8?B?YUJoMzZlbWZzanBncEFFODFrSXdYSFdGMlFRa2c0UitjNkE2dENGUEwzdXFm?=
 =?utf-8?B?c2dyRENtSXRtczF4NjA1MlI3WUEzd2NmakxoM0xXV2Q3dUJ0QmFrNE8zQ2w4?=
 =?utf-8?B?dzBxN004YkxYYUZaeFZCQnF0Y1EzeWNIOGUzdHprQjd0bFBSSWlMaWE2UzhJ?=
 =?utf-8?B?eDdnMHp0NDFKNjNzOVVQaHJRRTRBK2VUQWRIZURkMExxaS9qNkZqT1M3YjJx?=
 =?utf-8?B?NVpUcHN2K2cyMytmS25vdW1wTlgxTVpqamdpcUhXcGVlQnRRRHVrSmN3KzNY?=
 =?utf-8?B?ZGJGQitWSHZWa3pKVzBTV0F3MWN1ZmlsTW5IUXJmZFh5eERwRG1VQ3cwTDJT?=
 =?utf-8?B?UjVpRlluQ0xOVnE2N1dQbVpINGtVODZHU1A0K0RYT2FZd293d0szQmc0SmZW?=
 =?utf-8?B?S3VWcFhvZk1Ubm1RL2RtZWM2aTZDVGlwL1RHNWtXUGYwSVY2ZUlQelJrTm9E?=
 =?utf-8?B?VVlWakNab2pITlNRRHNRVlBNQkd2bXVGNXo1MnJkUTR3MzJvY05ZSnAxNHcv?=
 =?utf-8?B?OXM0b095djhjcEVYbXkvWk5CMllQRk5Xd1huLzNRM3NtNmtFWWRlM3JmSmty?=
 =?utf-8?B?ZTFZWFlwM3dETXEwL3VXU1BUamo1WGdvanY2WVBWS3FZVHlRR1dvb3k1Q1NR?=
 =?utf-8?B?UWFrMUdyWkkvYTJFc09YOURTNXhnSkR1NUp3RURBTkhON2FYc1puZXduRmVD?=
 =?utf-8?B?cXEyR08zY1J0bExQYU1wL056Tkk4YXZvNnp1MmZaU1pETnllR1lVYnpOQWJZ?=
 =?utf-8?B?UDBSMHdiek8rOEpkQzF5b3EwN0Nsb1VjdFhOY3ZXRXBzTHZWa1U0NE01Yy8z?=
 =?utf-8?B?c0dTS1A0ZnFHUm9LeEVpNVN4aVl4SWJxWm5HYXE2QkwzM2JlbVdBcVdTWGxr?=
 =?utf-8?B?NnZkUElxakZsS09kdm41VXdkMms0ckZ2WHQ0OVFjZXY2RSsvSnIxLy9BdkJK?=
 =?utf-8?B?Q0dmTkZ3NmZvN2FDUUVOS0xYbkhnZkx0dWF6bHh4YVRjNWtZNW9DWXV2VC9a?=
 =?utf-8?B?anlZZHZ3Mk10LzVGMGZxTVdwWE5DM3VTT2dxcld5TUE0MlZLT0ZoU0lYdm5m?=
 =?utf-8?B?Uko5aUlqODE0aDZvbWFiQXNHclp5NVh2ajFwc3VLQ1YwRmF6UXQvR09uR1dZ?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ea1806-a28d-4331-988d-08dd71f506bb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 14:45:35.5619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTnTvY4IL+iEyS3jc8tb6DiLNyVIClG8VUoJp/HVURLBmXSM+675r4dtWIlm+/eV5zPfjLc2bGOT3auT5bVt7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836

Hello Paul,

On 3/31/2025 5:02 PM, Paul E. McKenney wrote:
> Hello!
> 
> The following series improves testing of SRCU-fast and SRCU up/down,
> deprecates SRCU-lite, enables torture.sh to skip non-debug testing,
> and adds testing for Rust's RCU bindings.  The Rust RCU patch is very
> much in RFC state, but I am posting it anyway for wider exposure.

I will pull these into a topic branch, thanks. Since 6.15 -rc1 is not yet out, I
will keep it in the topic/integration branch for my testing and then rebase onto
-rc1 for the linux-next testing once -rc1 is out.

Thanks!

 - Joel


> 
> 1.	Make srcu_lockdep.sh check kernel Kconfig.
> 
> 2.	Make srcu_lockdep.sh check reader-conflict handling.
> 
> 3.	Split out beginning and end from rcu_torture_one_read().
> 
> 4.	Make torture.sh --do-rt use CONFIG_PREEMPT_RT.
> 
> 5.	Add tests for SRCU up/down reader primitives.
> 
> 6.	Pull rcu_torture_updown() loop body into new function.
> 
> 7.	Comment invocations of tick_dep_set_task().
> 
> 8.	Complain if an ->up_read() is delayed more than 10 seconds.
> 
> 9.	Check for ->up_read() without matching ->down_read().
> 
> 10.	Deprecate srcu_read_lock_lite() and srcu_read_unlock_lite().
> 
> 11.	Add --do-{,no-}normal to torture.sh.
> 
> 12.	Add testing of RCU's Rust bindings to torture.sh.  (RFC)
> 
> Changes since v1:
> 
> o	Apply Z Qiang feedback.
> 
> o	Add SRCU-lite deprecation, torture.sh --do-{,no-}normal, and
> 	testing of RCU's Rust bindings.
> 
> https://lore.kernel.org/all/4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop/
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/kernel/rcu/rcutorture.c                                |  124 ++++--
>  b/scripts/checkpatch.pl                                  |    2 
>  b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh |   11 
>  b/tools/testing/selftests/rcutorture/bin/torture.sh      |   12 
>  kernel/rcu/rcutorture.c                                  |  298 ++++++++++++---
>  tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh   |   31 +
>  tools/testing/selftests/rcutorture/bin/torture.sh        |   75 +++
>  7 files changed, 457 insertions(+), 96 deletions(-)

