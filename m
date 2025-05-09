Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E579215060;
	Fri,  9 May 2025 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813433; cv=fail; b=Txk+ujqdjP+uNDaKbp+hOzS7QReQHT9bpNxpUbj/PFf3veBslZNcVl3VbwZHOMYibYUm3krYqNw6wwM1DNGdFfnLXbPCJfCY3Vz3NvujyB11/7VcFlKA0YcpdtwcRkb46dYXVXwuaU92DtgKXaAQOWQOzFWq1lwmOuzApaFfYbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813433; c=relaxed/simple;
	bh=54k2+xjN97EmnTOWbLVz9DFDIlzDuflq5kqSF4+qPpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b6+AbQSucrGFZcPrKJJFQER5PSSilnzSRxZg31ODUXjs+YA9ik1RC4edfHp750jRg+vaTdzGswG7fvHYziIgKQbGfZ83mn2CwcxBV62ikbhuRkutK+zDQMeobDC4wigJC6w4O1JSWLbdG11YwPGifrtrvir6a42FAM4dx4ZOBBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bxb74nOy; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bxb74nOy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0iaM8KZiMY8wVf9f51Av7N11npJvgf9lAFhOsyQgiLHl5kHGARoEsE++Ff/xkMDejy0U2JO8lMxR+kq5YCbzO9cOrMpByy+whyWO1zt0IQgo79Su6nefnqe2L7GZ1K5CBEqM3v8ddUrZFCyueABnG7Mx3EzUXCskpD2I/PmlnWqEJ1JGPetOSpoVk6L0hZz9463G1OkkkKtd6/LO23NppFbj37b/Sp0HL7CP4OJNo/YgdHH3UPyasJRs3inlXKR7e0A+2+iIYVjCuBxx8uxNCPSowXelpYp1ZVvqBJt/KBAFBR/OD4iU2lQU4HQ2R4ElxSBIMczS9JDlJ085y+oNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDL0MiM6noglK5jkN2UOb+O/DDKUXXnu/m8Zz17RcLc=;
 b=J6Mn0BRodKFR5xH/lS7tBJDhaeh6hiBrxBPSGeFCokafR8G5yOBJh7TrlZhtoYcfmPxz+LXFWe/0O4h5ftbs/nxbdqNynDnbS/BNBhLoaA9UhCdTaG3WoHGuw828/cVNz1uy8yxGJK+4toCS47x9aDREOj4I0ZH7TIfBahLGfB54y4flgHD+C5cIm+Xb8rnCVLFUhUq+KHBa1GVuXsdTGkm2zaHVgFx/mTbomT8mNZDqWQ1G5Wdmys74Y/yCdlcOJkGdshHf4855RyAuBql1GoMuxhhcPXVFu/FoPYbUuLHq22zOKQgebCGQkqhnDQzPM4tl2+s8zhQafcN3w4FRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDL0MiM6noglK5jkN2UOb+O/DDKUXXnu/m8Zz17RcLc=;
 b=Bxb74nOyOcxIN+tgC0FPRW4zbLdlETFm7U4hZ1UGINfhO43Ondk7uEX+yzPSgfOd5CJwOm37PbhrHcLbEBHrMMQ6IuiDx5xA5RIfcOBbIyih027qWEU5bayvqF+YUDnK5HzuQyqskA3QVAJLRSf5g06mYad/mWxT6GC7Kz4bBYAbyBVcu1ereOh1Hws7ETAnpDGdZV0v+CeWjPr8hqzWlMngfnJt6QNfmvka2GRBOPkZ7kq1gnoEtyJp36Sxs+GAMI1r26Wy5rGnQ++VbeNeS8ePzGdTRI04UU8Ny2vkFwwcdkT1dPaLjLFEwIQrPaW2/2M/rt3l4RPLsPYS6J1W2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 17:57:08 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.035; Fri, 9 May 2025
 17:57:08 +0000
Message-ID: <45dc2f1e-112e-4973-909e-c65a387c35bf@nvidia.com>
Date: Fri, 9 May 2025 13:57:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Make rcutorture safe(r) for arm64
To: paulmck@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
References: <da86a280-f402-499f-a4ba-df626ca4c748@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <da86a280-f402-499f-a4ba-df626ca4c748@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::28) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d5bde1-7a3d-4c01-dba1-08dd8f22ea97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjJUTlNBbSszSW5sRlRFZzNOQnVBT05vTmNCMHZsa0JvdEdCak1OZEtraXhE?=
 =?utf-8?B?eWNlaUd5UEYraURUdnVIUmpaUVk2aVd2WU9lRXFFTW1ydWs0aHN0K2ZRRnU4?=
 =?utf-8?B?Yzk3cW1ldm9meDBvMGdKRkQ1cFZhVVBJdUR1dW1VSnNMRnROTDd5dXVYTk94?=
 =?utf-8?B?U01BL1ZuSStrc2NXMlJXSy9Fajl1OVlHYk10elRxbE5iQ1kyNThrZTlHUmZL?=
 =?utf-8?B?anJ6R2t4Yno4WE92eHUxcEZ3dWR6bXlGcTM5RkRXbVhnZEtPRDBwcHJtQ0VJ?=
 =?utf-8?B?c2NWSjJSdjluN2xjNC93cXVVa1dDb3BWbUFiSFRkbkFtVWNXZXVWQWk2OUl2?=
 =?utf-8?B?aG5BdXUxclMwK2pkL1VQYTI0VXFtekEyUVZLdjN6NzgxYnEyUlhCTTc0TUF3?=
 =?utf-8?B?cmVRVGZhOHduWDlpeHNTQXBUZDdweEpjemhhRm9RTG5kQjhpaXYwZk1hQkR0?=
 =?utf-8?B?dDF1dytlZTdEcUdxeGpEVVpLTy9nY3UreThuOVJ0TkFGU2xZNzFHTWhscFpV?=
 =?utf-8?B?ZktsdVE1UjFGNTdsVmMwNHhRcWwvRkp3QXNxeTBPdkhuVnNUT004TUNTWHc0?=
 =?utf-8?B?YlE2MGxaaVdIR3B1TTY1d28xS0RvSUs0TnRlZC9rRFRPUlFMM2Ywek53Y1k3?=
 =?utf-8?B?OFNEUVozZlR2WTZOU3VKVStRV3FsSDhWem1HN1R1TjYrM2FvWFJNM1RYaUVJ?=
 =?utf-8?B?eTFuZS9wWmNuWUNPc09EbUNwVXhqdnplQ1pJMTJ2RVlvNTZQcHpJTXhiWUNp?=
 =?utf-8?B?QUtTcFNkZjV6cjhYMTFZZFdvTXpoQkVXK0N6RXFjNDJ0NXljVzZ2VGYzSDRj?=
 =?utf-8?B?WHJRTUFuVm0yM2pmcE9zTGVLKzNsbHJZUk5ReWdOUzU5SVpZSFhTaEQ3VktN?=
 =?utf-8?B?OXVkdFNobTRQWjJZWmJRZlF3MzFMYUE5Ni84Nm16cGtzWGwyKzE3RG5sOGli?=
 =?utf-8?B?cDIxd1d4Z2pMWTdDbFVBbC80aDY4Q0V1ODV1T0VxQnI4SGwyWGFIVk5DSVJ2?=
 =?utf-8?B?a0VQa2VXSkdwRDllNzZJRlB5cWFsUE8vTGdCdEJpV0h0ODlwQTZVY1Y3SkJT?=
 =?utf-8?B?elBkclIvaGQ2N0tUQk53QUdWK0F1ODNvaTUwcWdXZ0U3VVVFWHV3SDE2cy9I?=
 =?utf-8?B?ZEpUNHNZRGRKbGNiY0FMUVNtUlptMnltTUVWR2ludmRZdWY4S3ltbStqUnpq?=
 =?utf-8?B?a0JOa2labXhsM3YyUUZ3N1pYZzVvT0lrNkdoalNTQkNtcktBRkJVa0lTRmJ1?=
 =?utf-8?B?cjFGT0RwbWJzQVRsbmJZQUFxVjhGSzBTZm9Fd3VWekR3cnowSDRYa09hUUo5?=
 =?utf-8?B?ZHpOMzJiNVZ5Y1dmTFArVjd5SEZPYTdyMCtLSVNHckxGTk1xcjZVeXRwcGlW?=
 =?utf-8?B?Yk0xWE5VM1g3ZllJTUNtTlkrSE9uZzVKcHpCMnIxS2lFRHlYTE9KMkN0Rndr?=
 =?utf-8?B?c2RpMFdBSHcvd3F2ZytodEE0TG1TbEN5Z0QvQzNtOGtyQ01pRFNqTFdTaXV0?=
 =?utf-8?B?SDJMZWlMSERJMGNHR0RPMHVGeWYvT3ZwTHlqSXplY2QrRGJQamQ0OUlab1c2?=
 =?utf-8?B?Qk1HUFNUdzNhMW1QL21JZUdycHVwMXdMdUhWYlZPNVVlcmZucFBSSFZHUFhX?=
 =?utf-8?B?SzI4empJck11ZzR6UzJaOGNtUGc2TnMwTGVzQk5ONjFIL1JPemkzSWIrNisr?=
 =?utf-8?B?ZTlmWmZ3UjljTUxoZDVsREZERUs2VnpMaE1uT1RrdGlxeXVBcHhIWGZjUy9Z?=
 =?utf-8?B?NHNaQ1FhamRQd3FacmdiTFJ1YTdwL1RzMEVWc1dZelpWeTQzQnFHZHVlb3Bv?=
 =?utf-8?B?WGU0djhuZ1I5NjJjL3VmUzRsZTNlVDJaTXdMVkdzU2xGOWwyRlJNVW1nSmpY?=
 =?utf-8?B?MjJlWGgrbVg5S1pyUkwzYnB4dDVtbVQwT1lFdEx6bFRWY2srOC9qUWoxVXVX?=
 =?utf-8?Q?YWAKAf2Lw5o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UldRbkR0ZXFJanVZckk5Q2dOR2d4dkhibDlHQXdVNDRnMUd3d2xxY05TQ3Iy?=
 =?utf-8?B?d3VuT1lsSkZVQWZ4OVlQMlo1WEFDQ0VVNXYzMFFrZ2x6dDlFOXZlcndQamNQ?=
 =?utf-8?B?cC9PakZjdElGc3czbkcvZEt5ZkhwT2FBMzk5RFZicGg0Y25YYkNaaDE0T215?=
 =?utf-8?B?RWFNcExOQUNSY29zNzVqQVlaWk4yeVAwTElXbys4R20wUnN1YldEWHNwM3M3?=
 =?utf-8?B?OWlBQVVHQUNPV2hsV0VwOUdXQThiWk92YnpDTHZJTDNFeHVsdWhFZHdyZHNo?=
 =?utf-8?B?WFc0eURGajZPZ2haVHJETURFUGpaN0J0QUZDeFNyRlF4dVIweC9rNTROWkVk?=
 =?utf-8?B?aGJISjVJOHNlai9QWndzUE1leFJUMlA5MFpveUR5OW81d2EwMGlzSDl6OGRx?=
 =?utf-8?B?N1BPQVo0VldpcVNQazlJc05QcjBhMHdSQVU5ZUZ3aFZrb3dhT2wvQy9kRW43?=
 =?utf-8?B?cWIyVG5MR0F0MHNQWUpkMVpyZG5qN0ZVdnlJODJ2SDVHMEZrYVNZR0RWdHRT?=
 =?utf-8?B?Y1NpTDhpSEFvNEtuaG9JNTk5NjlwbmNndmxXa1VEN0dNS0tlRGVCL2NFQWxv?=
 =?utf-8?B?a21DKzk3bVFnRWUyQi9OVlNUWTk3aWY5aExQZngzeExFUURoM1I0Vy82TFJN?=
 =?utf-8?B?UGU0WXZjazVZcDViUDRnVnlrWDdKaFdYd0VzczBjdDJZSGN1UlFINmxhMHp6?=
 =?utf-8?B?K1A5OWtPWVFpdC9KL1NWc01xcXhkVGZsTGFIUTNTb1B5QjU3aGFTcUYyb3kr?=
 =?utf-8?B?M3RxVGg3b0xaRzZkMkM3V2cyTTJjOG15TmpTSkpIK0hKTytMRExNYUlka2E5?=
 =?utf-8?B?am1ldU5LU0o1d05ZNmRmOEk1VXE5eEJuQ0dmSzVoY0trMHA5WEloTHh2Y1or?=
 =?utf-8?B?L0FySWJvS2ZBY3M2dC9qZ01tL3BjcDZaWm5iL1hHbXRoaHAxcW9BT055ZzBR?=
 =?utf-8?B?cmRWZGZZZnhYeDc5SkdJYkhabzR5aW1ORnJsNHo4ZXFtL1l1UVFiTjRsWlZq?=
 =?utf-8?B?aU9ZRkRINnNzSVpZdmF3UUNCSEZVVWZsMkFYcTJMaU42eGVBOVpTeFdVVTlJ?=
 =?utf-8?B?WVovZ29ZRnN6Z3RMZGlHOFFGaEtYYkFnV2xYbGcyellUU1ZSOEV6M3c2OFFY?=
 =?utf-8?B?ekNRNWQvWU5JcldoVmg2ZURVelRiSmVSWEhuVzVkemZBVEpYZjl1TXlTNHZL?=
 =?utf-8?B?TEpUWnM4RlhDamd5RFAwbkx5Q0FCTWxPaXhDM3pqRm9yQzF1K0pqQzBsbXRT?=
 =?utf-8?B?eGZyMGNlS2VtNVdGWk5QVGdBSUIrdnFXejkxbDk4eTE4MWl2bkgveHc2M013?=
 =?utf-8?B?NUpsVkU3TnZtbmd5dVREOTN3NUprUzlMQml3WE5hbGZkV3NIVUwyaUpGYmky?=
 =?utf-8?B?ejFMaXZTM3o3NjR0cXNCeE56cTB6clVxaDZ5MDJXSjA1Ym55bytud1U1bmxC?=
 =?utf-8?B?d2Rpd1Zxd2tyUjRjSXJWY251Z3FpbEUxcXlrTGtXWDd5VmdoM0d3RkJBcjF5?=
 =?utf-8?B?Y0pWU3djc3RKQjBWOWVOY2xCbkdxOEVYcmhBYnh4V0NmaDRYQ3pkMDdaaTZo?=
 =?utf-8?B?bnRZVHBjUGNZcmhLTTlJczR1alNYV2ZEK0RuMVRVTnErdnNGK0N1ZUtIVDVT?=
 =?utf-8?B?RW5IUVBuZGRjb245YUN3NStEbEVNRWdRRGJTckkrZ243VUdoaENCNnR4QnIv?=
 =?utf-8?B?WDdkVjZhSEk4VktXVk13dkFtbWthOTF5K1R6NU8vYmZJRERvYlJ4VnRSUlk0?=
 =?utf-8?B?NWFKaDQ0MVVDdWIwRFlLN0dQc2pPUUwyZ29QUWZmL1A2dFI0dGNueVNEZ25t?=
 =?utf-8?B?TXJ1dkFndlJXaWkxWFhoZm52T0lGT0FSWTc4YWFEcTZLaFN3eU9SMmRSdkw5?=
 =?utf-8?B?dkRYdnplMGMwV2NIN2MrZFY3eUQ1d0orK043ZnJHZ1BieGFCUkZJY2NYYkFM?=
 =?utf-8?B?cmJOS1VmcDNWYTJjcnFQQkU5MlV3LzB3Um5xdU54cTg3UFB5ZVRuT3BNTDFp?=
 =?utf-8?B?amJiY21NOXBLYjA3RTNiWEZLa2JQQjhJUnczNE9PeDJLSUZML1RSMXUvYmdB?=
 =?utf-8?B?WTNDSGJQQnVZN0JkYlZaVm84TS9RS2ZHbERkSlEyZnNINDYzR1ZQdG4wUDVm?=
 =?utf-8?B?SGxDU29tT2o2ZEQ3NGVhUXhHelMvZitTbW1hZEhrdW9GcW5LbWtMUHJ1Qnh3?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d5bde1-7a3d-4c01-dba1-08dd8f22ea97
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 17:57:08.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n404Lkeo46MaBMbkwzbwjxIkv6jxxyULwR7d6IZLQytzaW68g64DR9RxyjCnrvroZnrMjK8DYJ1SEDpFt+6LPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807



On 5/8/2025 7:42 PM, Paul E. McKenney wrote:
> Hello!
> 
> This series makes a few small updates to make rcutorture run better
> on arm64 servers.  Remaining issues include TREE07 .config issues
> that are addressed by Mark Rutland's porting of PREEMPT_LAZY to arm64
> and by upcoming work to handle the fact that arm64 kernels cannot be
> built with CONFIG_SMP=n.  In the meantime, the CONFIG_SMP=n issue can
> be worked around by explictly specifying the TREE01, TREE02, TREE03,
> TREE04, TREE05, TREE07, SRCU-L, SRCU-N, SRCU-P, TASKS01, TASKS03, RUDE01,
> TRACE01, and TRACE02 scenarios, preferably in a script.  (But if you
> want typing practice, don't let me stand in your way!)
> 
> 1.	Check for "Call trace:" as well as "Call Trace:".
> 
> 2.	Reduce TREE01 CPU overcommit.
> 
> 3.	Remove MAXSMP and CPUMASK_OFFSTACK from TREE01.
> 
Tested-by: Joel Fernandes <joelagnelf@nvidia.com>

Applied for 6.16, thanks!

 - Joel

