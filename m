Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4D36073A;
	Thu, 22 Jan 2026 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769125423; cv=fail; b=BJE93JQybN8yxWP5lb3SpBwU71ru1fnBxhH0t1bfiKr4YVrUHOVN4IyZnzediMY11qyxGR3D/CNqW2oaa0CUAtTsVz6AkjFG28xU7GmE8QErsBdrdaoeis5D0vqGTw9/QU8KY6zHm28yN6rU3Tk0hgGmg/wgJObLanoCvHy4nTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769125423; c=relaxed/simple;
	bh=u482B0aOG2CF6SrQEobj0Dnxio+Kb8Y+ttkFOxLYtjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Message-ID:MIME-Version; b=TT1ujZ8dKHS13dSkkexSCei21wgbOxAxhBrQSrY9j2nAfn+0QI2f7Trfm+y/93Q9j42ykai+PiicsBgtnR+OBirgF8HQdmadK4UVdxoaTq7pUekXj9bmPfqtaDpPLuOUc3GWEa0axdldGNFgjQBdrvOAJ3OrrgVWGLnwa2x/Aro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VG6+RcET; arc=fail smtp.client-ip=52.101.62.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VG6+RcET"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnJNTMkOUKUaJbwLDnWujSxl0BlJW6iv2DWlRKbFo6ssHU9RzMIIHGA6V7KoudWfgS3OeYvTv4COmAuuqzjN09aaCnK+fXyGujzzF4M2vagQiI7n+KjioXYWYPYcKw7zO4dvsmPZRmHsEk/+qMcIglDUO4it9s63qwlvoIH5ooCM5qAegfVd8bxA4PdwzjFzHkJvhWnqiZaklcPCQ+JThMr9MJACRymkY0JHrWeyekcE9136qAHIiyrBtSg+MzdJj+WkWQLkUxTxd6YNiZc9892zxEXhJ4ZJiAbqZxq1HOqNHWXMS0C7Z5EnPas87VEoo2Al2DEYtNtI2dQ2+I7DiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzzF7YNk+MbCnvGSCKYmwvitaMlg9w/YOkPT4Xh1TtM=;
 b=rsZmX3Tg4VrUjGj55REM/UH/UUyOyi/39ajaSNjsHPp8bwqr+VISH2mrkuXYz3rlGkFxefhCmzcZupd9kkDFI5mL7VXbFq4b5jCyp4yMwdf+Qnr8Sfte+SxFyFz/oifFErf6NdXSIf3CbwgENNBfR5vCibk7A2bKObDFZxpZ1hiik2FTm422Vm/PqfTTFWh74OtIQ/06nNldC7qxkQYtlENriaPsEaAAV5qJHggZgsX6zHtKm0kg/CHgDapBO5IZqToGOhDdGBorAcpdz+Xek+HQuLz6seLSVOcMePLXGXdP+EBC5uPsp0TDB3XK36a55hBWqEEUnx3JhIiqOqfiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzzF7YNk+MbCnvGSCKYmwvitaMlg9w/YOkPT4Xh1TtM=;
 b=VG6+RcET3JtoZr/Kbjgw+PyAP134d0FiJoG8orQywbk5wcSnk1CCy78uY9vgoxptTHyz2cT5m1M+84xGD6kSD7ThQzSQSO2QE2BzI1/ZZqtqArkX8acuO/2xwJGLJbpgEg6JBy3CkhoDMSKyhv2VkbBgUuwRU+EeX3Iqkz+g01B5wLMKqEyeYHAWfJU1Z7U1VSMdFmtteY1XU6uofMk6X3+5+3zMdM5vXCr5A845n605oF1GkOHyuhYrIgwO2ScLq2DtOZRSgXFQBhnaaVVQKOKLIm7heUqBVKfw1Sw6so9rRuOW2KIBzQWbmaDEiGfgdu+Z1L8/LJiAtADLr9qo4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 23:43:33 +0000
Received: from CY5PR12MB6479.namprd12.prod.outlook.com
 ([fe80::229a:704f:1349:5056]) by CY5PR12MB6479.namprd12.prod.outlook.com
 ([fe80::229a:704f:1349:5056%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 23:43:33 +0000
Date: Thu, 22 Jan 2026 18:43:31 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload handling
In-Reply-To: <986b4f25-5fbf-45b1-8475-721bc3e95223@paulmck-laptop>
References: <20260119231223.989409-1-joelagnelf@nvidia.com> <20260119231223.989409-3-joelagnelf@nvidia.com> <986b4f25-5fbf-45b1-8475-721bc3e95223@paulmck-laptop>
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: MN2PR19CA0007.namprd19.prod.outlook.com
 (2603:10b6:208:178::20) To CY5PR12MB6479.namprd12.prod.outlook.com
 (2603:10b6:930:34::17)
Message-ID:
 <CY5PR12MB6479B3FCFF3531F26FDE7C89A397A@CY5PR12MB6479.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6479:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: b7227eaa-9b19-4813-0f3b-08de5a100d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFluVlpsbkt6a0FtamI4SWsvblQyT0ttV01ZMHU4a0RqN3BoOVpoSnYzUkZp?=
 =?utf-8?B?TUNhNFRDNkJmdjFqMEtqTWlQaGVaMEZMS0N5ZnlwbERTZ0prQk02OEZyUlUw?=
 =?utf-8?B?Ym5tUWNKdnQ0UkpIdDRuWmJBNEtDcjdNRW5hUzFTM1ZuenNnWVRITjRRaEcz?=
 =?utf-8?B?cEY5YjY2OHE2RGthcGY1aiswaUd2U3pxeGErWGtWbzFjb1psMEtKOWJFWFp0?=
 =?utf-8?B?eXB2a2ZiZ1hodVZ5RVdzdGhkTDc3Q2lYY3kvdkN0UFhLNlN2K2E3VTVKeUto?=
 =?utf-8?B?NTVJMy9WcWJFVFoyMVNBQlFEbWZldEhOS1cxSENNOHVXQlV1TWhnaU4xSkFa?=
 =?utf-8?B?VGkyMU9SL1dkTnA4VWNTd2F3anhpTllyYjJyc040REkwZ1hnNnUxY25BMjk5?=
 =?utf-8?B?TDBsd1BlcE12NlhRYldUcmMrS2FIdktsM2ZUNGRQb2xwamlkdlRZTUhFMUk0?=
 =?utf-8?B?dHVRMVI3RzZ1SUpKd1VVeFV0cGZhNWVKOVR1cE43L0JWcGtZQ3FJU3B2L1Fw?=
 =?utf-8?B?Sk9VRTFMY0kzd25YYmFvTkU4cnZPSEhzdU9RSjgrTVVwS1pzQmpRQ0wza0U4?=
 =?utf-8?B?MGtUTFh6UWdBWGZ5RWNhUVduZnlwSlF3eTNWSk84VnRPbGozbnFwY3FuNnVW?=
 =?utf-8?B?Y2d1RTYrSUJkaWJPMFVjb0hPRFJkaURDakdxLzVJZndhS0FpSVB6MzFDdGdW?=
 =?utf-8?B?Sit5cU9kT3NQb0Fpb2pBY09RYmdJc0UwNVYrOHJDeFlHVTJQNzc5elRycXJY?=
 =?utf-8?B?MEpFbWRGc1Z5eE9UaW53Z3cwaXhxYjFnU3hUQkhkdTMyVjlJZEJ2NG82VkVP?=
 =?utf-8?B?RmhoZENoSk1YTE1GSks4RktkdDhDUlRIdk15WWhlT3pFZENLai9seldZdm5L?=
 =?utf-8?B?K1JNSmFSS1JkbGliaHJGSGVUYmJaVnZQeTY1Nlk5MEszQkk5ZlRTZmpEMWxK?=
 =?utf-8?B?ajdZVWJzWlBvRmZyS2JodytnZWZpcmtBNXZmZXNNM0hlemRaWVk1Z0lpMnZ4?=
 =?utf-8?B?VFFuMEFIbWFBN1o5c3FTOTB1elpuTWw0OFBUK2U4VjhHa2xoQ3FrZDB3ZW05?=
 =?utf-8?B?MUxwU1FGZTRuMVJibFRGWTlFcFZuYTVET3hOdElRdEhLc1BTbUlWYTBnT200?=
 =?utf-8?B?VXF5YUR2eSs3ajhYK3oxR3hITis0empaZHBUQ0hYWjRoMS81MHZscDU2OWpq?=
 =?utf-8?B?NzdHOTlKSVJYUy83bDlFZmJPdXB5Nk5QQzBseCtYcE9YSnhDL0UzSktrRUpv?=
 =?utf-8?B?a0F4dU1PSXgrbXhNdkdBdkYwbEgrR29IZmg1OXNlbWwxbzlhWC9kVDkwMVUr?=
 =?utf-8?B?S1VBMFFNZnpaRzNSQ3VoNzBoMldMbm11OEwydXZldFF4UzlmcEpGV3VzaytZ?=
 =?utf-8?B?b3BLR0J5czBqaGVFUXhEeTl0cEFteERlUEZwWkF0MkZmMk90M2dLQno1UTFr?=
 =?utf-8?B?OENLWVBpNGQvWUdxVjZZMXJpOWY0c2dUSkl4YldPcmtSNHhuNng0cDM5SlFT?=
 =?utf-8?B?bHlqT05XQ2VxNDY1K3lZWkhPeWV0cnpPWnFwS0J0UHNBNExUL3lOcko2MW1Z?=
 =?utf-8?B?b0pjUlRzRGF6aXZOSmp0NnAwa2trUHJUdGF1cWVib0N5ZjFPSWJ0MHRTdU9B?=
 =?utf-8?B?aEorNHc0Wk9hWmQzWGxuTmhoaUYzT1pDVnRvYStzK2FEY3BGVUxXK3Q0V0xw?=
 =?utf-8?B?ZmZwczBMVEVaU3Vlc3FmT1NobkhSNjgxVHBQU1JWeXhDNitqM0VVYUV3dm05?=
 =?utf-8?B?dm4vN2d3SzcxMnV4MklkQWJCLzZwVnZ0dHFEbCtaNndzQ2pjeDM1UUJ1SVpj?=
 =?utf-8?B?YW92cDRsbDdGZTlzb2hMZFM1U011SEJBQU5ESkNRanNqalhtSStOSXlJRk0y?=
 =?utf-8?B?WWpIQ3ZubjJRM1F6dkpHd0Q0WmpVaUVpYkV5TWZVUkFCMHp3SCtQcGZDcFVQ?=
 =?utf-8?B?c2VVODJSOVVIOFM5NUlLSEN6S2o3VkdIMVNBbWhvaVNPRUh6S3g1OXQzSVVB?=
 =?utf-8?B?Qm9vNk1pRXlXd212cHJmaG82TkVEeUJPbTVNVHRSS2ROaFJ2THRQWS9mVElH?=
 =?utf-8?B?TFpwNjZyV3hhME9TMWJvaFExOElMUVZTWDdaRWMwRGlOd3JXdktZUFhzTjYv?=
 =?utf-8?Q?BmiI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWpFWFNYZDMxRXJtbVJidHlPcmdLeldlR25BK1gySDU1NDA1WXJ3dTA5K05o?=
 =?utf-8?B?ZWpGUWtmQ0Y2ZHlBV2hHTVVneGp6RmxEK3hoN2xFQjJScHZ4QTdhTWZuUkVo?=
 =?utf-8?B?SnpvRzN0WFJZa3hWMXdwVklEcFd3NGdqQkdqdEFRSWhIQks5OGl1V1RpR3VS?=
 =?utf-8?B?NzNkTUdlaUVFTGhLUTJvUEh3M3M2bzU3Y01ENkErMGFTS1FLOGRQVDlLcWZE?=
 =?utf-8?B?VCs5QzFtc1hONWRmWWFxVk4yd3JYRDBSVHM0R3p5QkhzeHBodVNFejYyY1RM?=
 =?utf-8?B?OEVqa1JFUE5wcndvZlg1RHp4Z2ZHZ2ZwOGFUUnpCMVVYMHlyTjUwTWNEVmR0?=
 =?utf-8?B?QnYxbjljZTAyWXhYMnAzWk5LUEpDc2h4eTRWOGtYU3lESng0WTNVcVp0aCtk?=
 =?utf-8?B?UWpENE5Tc1lPYWF1TG9UdmxwNlJBaXo2YlM4SmZ2c0xYZE1EQkJ6T1R0NHYr?=
 =?utf-8?B?TE43WURDQUZza0Z5Wmd0bFJPaTVQWGxxRmpvVDgxWkozeGJEb0t3WGFmM0hJ?=
 =?utf-8?B?NC9oSk5jdHFISUdYb2QvTWx0RlUrQ0dnNWp3dm9ETkcrN01uQVpQZmd4aUFp?=
 =?utf-8?B?QmZSN0NsVkxLVjRoeFJVTk9ldEloMGxpNWlHNjI4MHpoT244aGVCdngrZGQ3?=
 =?utf-8?B?bEJXdXVqeEt0dHVmYUI3eXM4YkUydm9PcEQrTWtTL2pQOEVqcS83THhZY0to?=
 =?utf-8?B?VjlOZldLdnNyUjJwTDdaaDc0Uy9kNlhCeHI5UmQ0ckNKbG8vMENJdVFtUEl5?=
 =?utf-8?B?dmNYVkJMMGhkVGZhemRXdnp1KzkzN1ZsbmlEL0dmN0J2VGlEaTJGbERuSWdx?=
 =?utf-8?B?Q0VZbjhxS0hKOWhnTWVIOTlGYkVSYytMRURTVStQRERvdWFaUmlnaVpsRFJ0?=
 =?utf-8?B?aHNESFVKSHB1cGhWcGJtYStXSEIxZFNiK0VsQUVoZUVMY2JWaFVJenh1VHhm?=
 =?utf-8?B?V0Fvc2tNOXl3L2dXVGk5a0Z6VHJzUFVTZ1hMd0ZxWVFOZEFWUE1heGFmOTRI?=
 =?utf-8?B?SHFDVmdQUmFwRExCanJIWFdSVTJpWStQQmU0emRzSlQ0ZFdjRndEM2VvTUpG?=
 =?utf-8?B?N2QyNWlRZjF0cGwxTTZEaTRNQkxMOEZEOHZrMGhQcEw4ejZHZkRFTU1ZVFpp?=
 =?utf-8?B?TjlBUXkyd2Noa056dFljb1FuUVZ6aUk3bHppTnBrbng1SWpBeFY0WGFoV0N4?=
 =?utf-8?B?bXNWZW1CbnRicDc4QXRUc2dOazRVREVXUFpGNSs5UFhXOUo3TjNJZ1ZoV0F4?=
 =?utf-8?B?ZjFRSVdvN2FuaUMxWklHeElwMldURXFzWDdLMXhCWEJ6OWIvdDhYQi9IRUMw?=
 =?utf-8?B?TVBGVUV1RzNuelVNYTBKUUNIRzFybXgzOGRyME9uS1JudTB6TEhmWERGK3FI?=
 =?utf-8?B?d2ZUd1AvNjBGSDdLNk1La2hGZ01yQ0lENDB4L2Y1dUN3NjFjeThaVDdWZmhO?=
 =?utf-8?B?MWNXRFdwSzVGdGJMRmJLU2RBRWNOV3VzQmxXR0hGN1FsV2NIakxkMUtYMFBn?=
 =?utf-8?B?U2p2NlR1THI1UGVEUGU3Q2NROVNkT0N6aEtjZkNiOFpPbmpsT0lDVmR1L25s?=
 =?utf-8?B?Tkg0YTFUZkJIV212ZnkxZWxXNUJyc2lhWVFTblJSNnRiRDdpeHBlaEFxUEEx?=
 =?utf-8?B?b083bnd4UkhOYmRRQk9KVG9rd3hkYWtVbmhianV5Z0lpTDJ1MCs3cUFud3VF?=
 =?utf-8?B?Ym5wU1VxaDJ6aXJtUCtoUVM4QllQa0RJbUpFSWc1cjcraUhUM3lXUW5pV3Z2?=
 =?utf-8?B?cUFBTytBclhRbUVyNlRqd2FqZ1ViazNTT012SDFRcXBJRlVwOXNjQWRVd3h1?=
 =?utf-8?B?L1dVeUdxa0p5SWJPbkk0UHgxU3lDVUh0WXRLclFxSWVRTS83WlNSRWdjNmFC?=
 =?utf-8?B?VUdVaW1SdUt0K1BOeXFobjl1NW1LdnN4Qk5EZVY1K3J5WkJUa2U3M2habEdM?=
 =?utf-8?B?clExUlF6SXBKOXdyT0pOcVJNZGhvVzNsbm84bitnalhMQU1CejVXOVhFeElv?=
 =?utf-8?B?djNKSXJQeVh5aDJJVjhxK3UxR09XeElNdlRKRTQ5Z2xtaElKYWkraHo5ZlRL?=
 =?utf-8?B?c1k2a0lTYUZOWStXRUdrVEwvbmk2bnBlMEpYRzdWU0o5Sm80ejdCRURFUUhw?=
 =?utf-8?B?dEZ3WkFuUWhpdWxUby82REZLYk9OZGNGc2FEZDJlbmJjZ0lORDFBSmkzbXp2?=
 =?utf-8?B?dExXSnRqVllSUjg5OERNcVJ1alo2OVNhdTBveDdXR0FyWjV2d1J1VzdVWDQv?=
 =?utf-8?B?ZndNS3Zkb3BLZ0FFaUVWMnVYS0QvZXFkdlE3Q2s3NGQ0MStsWlFHbUpNbml3?=
 =?utf-8?B?bnVoQVR5THk4OWJjNXI4V1E1Z3RTVmxFMy9uTDFUNm1tbkU4d0hlUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7227eaa-9b19-4813-0f3b-08de5a100d83
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 23:43:33.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4L1WDEO6DNYX//HKFIBrVT1y9IkiG6NPzsMzMzukc1wiLM5lSVgb1QhqQpsrGkbWQ6A17EKtUi8eYx23VDw4uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245

On Thu, Jan 22, 2026 at 01:55:11PM -0800, Paul E. McKenney wrote:
> On Mon, Jan 19, 2026 at 06:12:22PM -0500, Joel Fernandes wrote:
> > -	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
> > -		/* ... or if many callbacks queued. */
> > -		rdp->qlen_last_fqs_check = len;
> > -		j = jiffies;
> > -		if (j != rdp->nocb_gp_adv_time &&
> > -		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
>
> This places in cur_gp_seq not the grace period for the current callback
> (which would be unlikely to have finished), but rather the grace period
> for the oldest callback that has not yet been marked as done.  And that
> callback started some time ago, and thus might well have finished.
>
> So while this code might not have been executed in your tests, it is
> definitely not a logical contradiction.
>
> Or am I missing something subtle here?

You're right that it's not a logical contradiction - I was imprecise.
rcu_segcblist_nextgp() returns the GP for the oldest pending callback,
which could indeed have completed.

However, the question becomes: under what scenario do we need to advance
here? If that GP completed, rcuog should have already advanced those
callbacks. The only way this code path can execute is if rcuog is starved
and not running to advance them, right?

But as Frederic pointed out, even if rcuog is starved, advancing here
doesn't help - rcuog must still run anyway to wake the callback thread.
We're just duplicating work it will do when it finally gets to run.

The extensive testing (300K callback floods, hours of rcutorture) showing
zero hits confirms this window is practically unreachable. I can update the
commit message to remove the "logical contradiction" claim and focus on the
redundancy argument instead.

Would that address your concern?

-- 
Joel Fernandes
