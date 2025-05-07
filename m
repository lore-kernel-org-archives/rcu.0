Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1E1D54D1;
	Wed,  7 May 2025 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746636740; cv=fail; b=mC5lKNUwxlYb8NVf9GBhi0VZCguth5CtoylCZKXX8zmBIb0BZF4sCzOC2f/brfuiXjTB6JwxO6Hf8+/BN9qdPN18HgUfpjutNDoB0HqKHbt4aFN3SyPNY2huahr99TWPsPbqrU6k2NZ1vr9b7i0goWu8rVyxewBJuzJXYqMNtQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746636740; c=relaxed/simple;
	bh=6IGNl7CIDJK80IeoLw2Rn9rOGPJstRuM9+gCQZsxybI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UlBcKqVZLtLfOvdXzSberCh79oDb0HkMbt2wuraPoO6dgmQZ8h32u6J4c8F3RENxIp76Bq+cr823L7JcQLGARrySeY2XTFzAxcVhPCDbNDNTjjs0oZbdGeux2kmukm1hS2n2/k4N0jEozYjMvH1j5Yyq3L6nVN2HcMF3zMmyoPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tHFPsQQR; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tHFPsQQR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzYYsPL2Aehzxu47UaZBDqCvHeGUyu94Xtzcl3HnnKJmx/tgLMGffqtaxGv/SkPuiT5jR6gXragN/fmMztwRwLiCZIhbe2Jb9snG+fHI+t2CvmgvpEo/fAjUbIa9KQhNl38Qa4qxITB9WExP+QtTNo5TIviDB7oy17vFLHqWO6hD9ymxB3/R2RhkFo+ulR+M3ArroOk/nbfV/9K4bjU//LXQ0/Xa1qDMRyStUgLGkZHP90Niybiw7XzSKpjnnqIEOFacvjdsyXzZrE4yB9W1Yfg70l1U/xFuLfDndIRqYL+KFcCNbmc+egeChnO5Cp7U8WOBFdkctsx7lcK8mZ2/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9Bc6pVpDVbBhezVBYpX/nn35Bn2A4ntrDeqPR0uqkA=;
 b=WbjJv+uFrc8ce0WmQ4A7/5HwXi0awgPphCO8wic4U+Otn9Yv9l+mradqk/mFuE4U4exxpTMb/ZpghtVeFc4yy4Zu64BHOVy/L+wMOKr3sBl9HC+PWGVt4aDDoa47XjLAs4HSBZmoPcZK4eACIhq4zW58cFffIG70fafPmQ2ZRi7yQgPodT2mr9iDF3vii2Nk68gqkykZHvbTMrw72Gpm6KhsSRJNzpzR6AMb41yAV5nxk6ItcGkn+W1Bj70MMjGVC2+KQhmwmyPtOAetOLiPEHXNg1XJ/TknZqtplTDelCDYRrNunamdpDOsI4Z4ME0xSHertCZQm0nD4EvvXLwAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9Bc6pVpDVbBhezVBYpX/nn35Bn2A4ntrDeqPR0uqkA=;
 b=tHFPsQQRcd0+Uw/uXIKO27wJNpXFsji8eYlEll5ngaHXqIAmGiKINFUNtWihLlM+AwHq+nnTjxEE2TUBptcwSh+ZM0rRmTO0ovYV713RlixHTk3qvV1ajizeM755vQ9rEljnWPqmDnbM76FLZTBveqru6X7F3wwzXoXoiGX255FGASXK3k4rjiUjoExcSWgftuA+3m79zQQ0ygW7vKyRymQw+37Xx6gws/c6LKBB8NRy+aJgFZZLQ4OYJkrc0qv3WjxOv8rm47zg1oW54FRG6p8ahobUC7KSVR5DJZOE45rDcbB0zvcMTigTS7ttMwn+uDQxK622eJkcN6H0438jYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.35; Wed, 7 May 2025 16:52:09 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.021; Wed, 7 May 2025
 16:52:07 +0000
Message-ID: <70e3482b-3181-446c-b3bd-db590008123e@nvidia.com>
Date: Wed, 7 May 2025 12:52:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu/nocb: Add Safe checks for access offloaded rdp
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Zqiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
 neeraj.upadhyay@kernel.org, joel@joelfernandes.org, urezki@gmail.com,
 boqun.feng@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-2-qiang.zhang1211@gmail.com>
 <b242ab38-c488-450c-9735-11e1b666106c@nvidia.com>
 <aBuK29q6nuhTgHIq@localhost.localdomain>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aBuK29q6nuhTgHIq@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:208:23d::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0cb3a7-d466-45f8-6826-08dd8d87809f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlhBNnVJS1JQNCthanNSQjkyK1JNU0hpNks5NUo1NkdtdW92Z0wvYW9Mc3A0?=
 =?utf-8?B?OFV5UnAvYVRLaUVFMmhDS1VMbitXeE0rcjI1cWxaUDRqQlNySmdFQjdFUUFH?=
 =?utf-8?B?bmowRWFUK2k1Z3BVZnVtQUZOcWw3czdhbmluYnd3MFBRV2FiUUVKdUZ4ZTVx?=
 =?utf-8?B?QThuOGh1Q21TbE5WWGNUKzFNeWJvRnF4d25BdVZaVjhTeEViR3hXaEJENUVi?=
 =?utf-8?B?czlxK0pVQXBlZEllbVExWlRqUnBITm9BL090RDZsQkpadWRub295K1IwS053?=
 =?utf-8?B?eFg0RGNnZFlLalhwRjFXYTVqQ3VKVGhJNWw2anZqYmRGU01GWERZejl2QlNZ?=
 =?utf-8?B?ZFExNFhrZzltaWxuZnRNMXFSWldkSStTc1pyUUh4V0NuVUNldEJidnkzS1Nz?=
 =?utf-8?B?Q3Vvd3p2NHVKamFBN2I0QXNhZlhUQmxCRjdNRUNneFA0aC83ZHBxQTdDc1pr?=
 =?utf-8?B?b1ljWHBkZzF2OGYxUE9vL0lpajA1THNZdFZCNkVuM3JwTWU3R2xRcUNGNTIx?=
 =?utf-8?B?eUJwWmV0YXJ4eDVQWmt2OVhSU29XN0RNSjhpNHdwdkpVT05obEpMMXNYa21C?=
 =?utf-8?B?ZzBIdVNjR2ZXdHpTNmNhWXRRbUtaVDBBaEFlN2syWUhWQk1tanIyV2xiNW5Z?=
 =?utf-8?B?dzJOS0VyYkxkM2QwM3R0K2plME1sWGNXa0RaNmswd1Uza09YaWtIMmhSMHRM?=
 =?utf-8?B?azQxT1ZBcWVFakh0b3RTUW9CbHFJbFZVeE9HUmJLa2FkSWl1SFVINkNKZGhs?=
 =?utf-8?B?MVdOVjVja2VaWDhQdDJTUVdXUG91dXI5eC9POVlDVVNHckZSdzBWcHpzcG9n?=
 =?utf-8?B?QWVudmZZaTZ4MVY3Rndrdnpma1UyL09kWklUeUl2TzBZbGR1UGtuY1ZOS3Ez?=
 =?utf-8?B?Q25ONXg2UTdxM2Q0WVpUTmtQSStDWGFoNFlrKzBwY0U4K1dHcHRWNWFVekN1?=
 =?utf-8?B?R04yekZ2N2lQM1pWbExWMnZyb0RYUDliVUtNQ2lvR2dnT3QrNnNPNnNXdmgy?=
 =?utf-8?B?a0JVek5JUnUrN2dyOUdrYkdyNGI2cS9pQk9HSmFJR0pUc0Q0NU91cUVTbXdh?=
 =?utf-8?B?U0FPMENPeHZOT0o2dmo0cHFxMjlNZE1mN3pibEUwNFFreHRGaFBlRjczN1pu?=
 =?utf-8?B?SjRCcTBCNGpWTVBYbUhscFEyUGZhaHNhWlFFcnhFMzkzRzhtelIvS08zbFc3?=
 =?utf-8?B?S2ZlQU4wb3FtWEZxQlBDN0cxeGgzZjBVdUpkQ2h1YVNjZ2FkRWs2cnhibDJ3?=
 =?utf-8?B?cnY5YUVqbGlSNmpZdHVmbzMzR21lWkZ2eTRZN09HNk4wQzRUd0s5d29RdlUz?=
 =?utf-8?B?ajNWanYyTEFiZ0JUV0xzWjFnNWZ1SnUvenpNRFhPd2ZPL1V1V3NJRzA3N2tl?=
 =?utf-8?B?OERrOGRtQWxyQjJQdjQ2MGNGbmpJZjJjeU02dW9hdlhzMWJWNERwWlh0SnNj?=
 =?utf-8?B?cjg3VEl0Zy9YdDAvTkNwYzYwV0xUQWlsdVBaa3pGN0JVVVlxQ1U1VTNsblBO?=
 =?utf-8?B?SlpqMFp6V3BreEUvSXhWU2Y2N0dlZEVUeWV4NHBaYXdFdlU0YlViZFRRT3Fr?=
 =?utf-8?B?a2dVbTROdlJrM3dyQWNlOFFld2JZTVdWY2w0cmVGMzNDZDZxNFRHSW9WdEh5?=
 =?utf-8?B?bkRyL1BrYlJYY2VQa0toNjhLdlFNMjlxWnA5RUY1T3UzcWlmRjNON0VxUk1u?=
 =?utf-8?B?K21sdlNqSFk3NUF2UlpBOFdjV3pvSERNbU10VWFXakFTOEt1OC9wOURrVXVG?=
 =?utf-8?B?TlphNWwzUUZqMnVHciswY0dVa0Nadi81NVVvVklPWjR2ZGV3R1J3RGZaMjBR?=
 =?utf-8?B?cGc2MmpMSStaRVREUFd5czN3cGtYb3dVTStqMFRwMksvbURkeFNJMzdUMFBD?=
 =?utf-8?B?bzhQL3RqSmhEbjA2bjlWSHZqTFdhMlpXWUQvNHBWbDR5eFA1dWdQcWxtNEpv?=
 =?utf-8?Q?KCtCIkvcJ/k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzdRbjNFOWNoS3M3MUZ5ZUJUc3krL1R2dm9CRno5VVpZc1F4R1FEU1dhSWl4?=
 =?utf-8?B?cm90cTBaaVdhZjNVSHBaZ3U4RmRkOFkvZ0VqNTNHMXoyQ2drZjh2UlpEVnFa?=
 =?utf-8?B?N21QUVhoZDVrUTV5Tk5Fdi80cUJuTXJWMzl4ZG9veVFwaWVKRkVzbTlKRVZ2?=
 =?utf-8?B?NzdDQTNYMHhGWnhnN3NKcjI1YmFXcmZ6ZE54djhNMGh5cG1pVEg0a3UwYjZ6?=
 =?utf-8?B?dFUyOVhqUU4rRTBtb1RoNDhnT2VxSHdCNVlYM0hHbDZHcHpReklQRFBYd3dm?=
 =?utf-8?B?ZjNUM25YVmtGZCtvUmZwd1R5M2JGcmNxTGpZZE5Nc0dGNFQ4eU1kb2c2R2Iy?=
 =?utf-8?B?V1ZZT1dzSU5vMFhYdjhUVTB6d3RhQ0tjekVMRUwya1pJM2oyYmd2bXp2aktS?=
 =?utf-8?B?NkpLQkU2c25UejFUWGZDQXJmRFNNbE9JNVJ6eXp2ODBVWmtKeTZIMUFFN21n?=
 =?utf-8?B?Vm96T2xnWUFzek16aEJRcjRrMmlmbmZBRzJibjVXNDdtTURicTZIK1FYN21G?=
 =?utf-8?B?R2pwd0lxemVNOUNBNGhMSEkzSUVuVmlhbGRRLzhtekFFVVRpcTZRemNzMTNR?=
 =?utf-8?B?ODNCNEU4T05pbVlsWTQyODZyVWJ5d0lwbG1CRHdSVk9EU2hDbC90M0VBWWI2?=
 =?utf-8?B?K1dJMzZESGIrQXh5WkxqUzZzNVRxbHVCbEh2dVkxM1VQbm4yTXBVSEhEOEFT?=
 =?utf-8?B?MUVLLzhlbmY1QUlSdm5YRkpibElmWWloMXJvajlmLytUZWkrVHNzKy81eDhI?=
 =?utf-8?B?TE5mZkdQL2RjclZVZ2hCeUxzQkpuWFFLamI0NTYxTUNoOVAyZFpZaTlGeU55?=
 =?utf-8?B?MzdGa3ZDRVFaaFRTT0lNa2t1Qk0rdmNab1QzU2Q5VW9JTnduZG1sbE53OTlZ?=
 =?utf-8?B?WVlsSTJzdStUVXlWR0hXVXhZckxaVTVITURHWFY4K3pEbkFpUTVadzBuM2hz?=
 =?utf-8?B?UEZMY0RKWFZ5SjNxRGF1M0xhTXl6Y1YxVlhvd2syMnl1K1RvUThrYmpVMWVo?=
 =?utf-8?B?bVVuUkpTaHJNbXlvQWxBRzlxYTZCeDA3b3EzVitWZ2o4WmtuMUpBVWprOWxn?=
 =?utf-8?B?TjhERlk1KzJ2YUJwTmNrS2hOdG51WDJuS2hHU3FrZDYrT0JieU8rWjdBcDB4?=
 =?utf-8?B?YU9xaDEyd3d2QmUxYW5sdEExa3dTa2RPU2pWOG02enBqWnQ2V3hXWFRudWNW?=
 =?utf-8?B?eXRvV09MbG51WnRKb0FCTnUvVXNMZFQyT3RUZkFTMVJjSDEyNFlmR3lHdmFj?=
 =?utf-8?B?ZjZuSFdGV3JSZnZEdkkrVGU0eUlQYkhwcTJQZ3JpNFp6Nm5vKy9JUEJBWGxu?=
 =?utf-8?B?ZXd6RStmZDNhWmtPUStINkZHbG9yVVF6QTBINGZlV3RiSEZ3ZERSaWhRT1JO?=
 =?utf-8?B?V2NEcU1JaXZDMGl4bHNhaThCbUh4M2VxblhiS3dWNWsyRWdjNncxejY1WFJy?=
 =?utf-8?B?aEE5MU8vQ2YrS0VsdERORDJseGJ0WXVna242Z2V3QUpFQ1VDb0pWaFB2WmVo?=
 =?utf-8?B?bTN2bGdJRW9Tczcrekk3SlZxdDhVaGpSb3ZnZExSSnh3TnJFRmpFc1hQb21T?=
 =?utf-8?B?TkdFMVBrSkk3UHpuTVZlZ2ZhbnV1NU5qV1VUb2hXMFVIaXMzeXp3SXFBUUI5?=
 =?utf-8?B?ckp3NnRRK1NnNDFpdnRBbUlSWHlndEp0U1VoVVJNR0FFUnA2OXBFWkdKUXdC?=
 =?utf-8?B?Wk5HdVZGWkdpVG03bThaRUJYMlg3VEo3SllvU0FrMDg3VFJyZ0FielpMOTBP?=
 =?utf-8?B?Z1FMQ2VuRFBKZlBZREFUcDNGcXV6SVoydEsvQmNYN2M5dU5oVHMrZkVsejIz?=
 =?utf-8?B?bjJ6MmlLdGJKaTBPQyt5WmpEV1cyZ2JCclIwd01Od1dtWFR0eWdLeDRaVEFC?=
 =?utf-8?B?emRmYmZuTmh5QTJUR3RHMUdwMTRiYTdaeEpXYkdDZW5aRUxtUzVIMysvUG5j?=
 =?utf-8?B?U0lvRHV3M3pFZllkYm1rakxQdlExSW1IbVJCdjFiWG0vVkU0aDhTeERVeUo4?=
 =?utf-8?B?QS9pcjZ3NXFlV0Z3aVVvK3dHM2FYcUJTT0V2aWxrWElYdy9kRWtTQ0h0cW5B?=
 =?utf-8?B?Sm9nMnU0T2JLN2dvdW9tKzdEQ0VLTlJUN3ZKWEh2TXpLTGZNVDVjb21wS1Ju?=
 =?utf-8?Q?//OyXHp55/76CaiJtjNpKaVIv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0cb3a7-d466-45f8-6826-08dd8d87809f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 16:52:07.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHDOSAphqyrgosP3nu1xY1UchrYHecWwa7NpKNpfcSG7xR6VuOXO8oJy4ahjOijqSYVXkOQ7d212CMyDBSccIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389



On 5/7/2025 12:31 PM, Frederic Weisbecker wrote:
> Le Wed, May 07, 2025 at 12:06:29PM -0400, Joel Fernandes a écrit :
>>
>>
>> On 5/7/2025 7:26 AM, Zqiang wrote:
>>> For built with CONFIG_PROVE_RCU=y and CONFIG_PREEMPT_RT=y kernels,
>>> Disable BH does not change the SOFTIRQ corresponding bits in
>>> preempt_count(), but change current->softirq_disable_cnt, this
>>> resulted in the following splat:
>>>
>>> WARNING: suspicious RCU usage
>>> kernel/rcu/tree_plugin.h:36 Unsafe read of RCU_NOCB offloaded state!
>>> stack backtrace:
>>> CPU: 0 UID: 0 PID: 22 Comm: rcuc/0
>>> Call Trace:
>>> [    0.407907]  <TASK>
>>> [    0.407910]  dump_stack_lvl+0xbb/0xd0
>>> [    0.407917]  dump_stack+0x14/0x20
>>> [    0.407920]  lockdep_rcu_suspicious+0x133/0x210
>>> [    0.407932]  rcu_rdp_is_offloaded+0x1c3/0x270
>>> [    0.407939]  rcu_core+0x471/0x900
>>> [    0.407942]  ? lockdep_hardirqs_on+0xd5/0x160
>>> [    0.407954]  rcu_cpu_kthread+0x25f/0x870
>>> [    0.407959]  ? __pfx_rcu_cpu_kthread+0x10/0x10
>>> [    0.407966]  smpboot_thread_fn+0x34c/0xa50
>>> [    0.407970]  ? trace_preempt_on+0x54/0x120
>>> [    0.407977]  ? __pfx_smpboot_thread_fn+0x10/0x10
>>> [    0.407982]  kthread+0x40e/0x840
>>> [    0.407990]  ? __pfx_kthread+0x10/0x10
>>> [    0.407994]  ? rt_spin_unlock+0x4e/0xb0
>>> [    0.407997]  ? rt_spin_unlock+0x4e/0xb0
>>> [    0.408000]  ? __pfx_kthread+0x10/0x10
>>> [    0.408006]  ? __pfx_kthread+0x10/0x10
>>> [    0.408011]  ret_from_fork+0x40/0x70
>>> [    0.408013]  ? __pfx_kthread+0x10/0x10
>>> [    0.408018]  ret_from_fork_asm+0x1a/0x30
>>> [    0.408042]  </TASK>
>>>
>>> Currently, triggering an rdp offloaded state change need the
>>> corresponding rdp's CPU goes offline, and at this time the rcuc
>>> kthreads has already in parking state. this means the corresponding
>>> rcuc kthreads can safely read offloaded state of rdp while it's
>>> corresponding cpu is online.
>>>
>>> This commit therefore add softirq_count() check for
>>> Preempt-RT kernels.
>>>
>>> Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
>>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>>> ---
>>>  kernel/rcu/tree_plugin.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>> index 003e549f6514..a91b2322a0cd 100644
>>> --- a/kernel/rcu/tree_plugin.h
>>> +++ b/kernel/rcu/tree_plugin.h
>>> @@ -29,7 +29,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>>>  		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
>>>  		  lockdep_is_held(&rdp->nocb_lock) ||
>>>  		  lockdep_is_held(&rcu_state.nocb_mutex) ||
>>> -		  (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
>>> +		  ((!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) || softirq_count()) &&
>>>  		   rdp == this_cpu_ptr(&rcu_data)) ||
>> This looks good to me. Frederic told me he'll further review and give final
>> green signal. Then I'll pull this particular one.
>>
>> One thing I was wondering -- it would be really nice if preemptible() itself
>> checked for softirq_count() by default. Or adding something like a
>> really_preemptible() which checks for both CONFIG_PREEMPT_COUNT and
>> softirq_count() along with preemptible().  I feel like this always comes back to
>> bite us in different ways, and not knowing atomicity complicates various code paths.
>>
>> Maybe a summer holidays project? ;)
> 
> I thought about that too but I think this is semantically incorrect.
> In PREEMPT_RT, softirqs are actually preemptible.
You are right, for this usecase it may not be that helpful. However, I do find
it odd that the caller has to check CONFIG_PREEMPT_COUNT before calling
preemptible() above, that should be implemented in the API itself.

I was more broadly referring to the recurring problem of "am I in atomic"
context or "can I be preempted" or "can I sleep", if so do this otherwise do
something else. For instance calling GFP_KERNEL vs GFP_ATOMIC in the memory
allocator. Though sleeping and preemption are perhaps separate concerns. We ran
into this during the kfree_rcu() early days as well.

IIRC we have perhaps too many APIs that do similar things like in_atomic() which
confuses everyone (I don't fully know the current state of all such APIs). Add
PREEMPT_RT to the mix, and now we have more complications. :-/

thanks,

 - Joel

