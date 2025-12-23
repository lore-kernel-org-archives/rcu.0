Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DAD4502A;
	Tue, 23 Dec 2025 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766451424; cv=fail; b=PV5Vqss5+e4NaGAruo6kkcg3QVI4jDAn4p1oozHEdST6igPVACDtn3h7bisG5UZUUcAnKbeizFPN80DPmrW7vgP2oOYw4tes3SDYdeaW66k7GKvdvqT3WAKqumIQAU8ClinfaVI6JFCYcg62i0TbYyEy7z3xjM7w21ITNNYq4oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766451424; c=relaxed/simple;
	bh=QLT4r/X6vcmyBWaqu1xpSwrh0eEZ4SCAXy4ToVHBoJY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MulHCDGUELRsrlznY/MvvdsYeBA5jUO78fi2yuyBFk4Wc/lfEwilyt3pQmq8GJCtCQ67ZlCcj9xEoU6GbzhEwJpPctHuf8EEuQSlRp6oJwdb8C9TwJytEcsbRxgo47cFGsam03vqCVe1H+vLYIlvAwZtAzmKNDIUsJF75Ooh4b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aZ9Gb/LQ; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aZ9Gb/LQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWcAzrtnZhGLYwDDC/AwoPvyaN6yaWSDMyZrz2wsFjvoQF/SpPpDwTKSG4Mcpm7tbVTWlGP4un+IXeRQHLcgISmknaylm9U2Xjo5Cdj0SpvFMoKc6xrhtidSkgCQXbwFdk8xAWguhl984koqV852nyYG1ycTTiWicCwHMLxD53FTylHd10baj5V3kBQYgCTt2rkj33CClvnlSbcmgnFiRgNiKsE28prTt8ZLE3289+lAJZ+2OHHNWDEyZF7/yaRGn/NYpcmxSnIIa2xY1cndPGTfeY0dCJ+jr0lQ1sQJVKGC7kJdTPuX9mIX8dWfOvDaNcxzZ/Z/9tgmv3Bm+qwlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YzquvHVHuFkHd4oelkszO3AJ4EmrBtophqtMj0Xg2M=;
 b=SGTqmVpiAmOkbyuXm0MspMNljn22dr0lbhfeRc7SQX7i1UzTz4Z95sOQTMgMUrXHzMZfmPwUXXkaR11JZXtw+tE3YdsWuF7IDpfC4jcnRZEL2/hz4hPDASFfKh8ON0JAFs/LKTwiUJTzR/CUkZmwuRMyT4OlbTfUEgHI/IEid2PLZRYD/AbKK7kdG94uPr7Xr4R1pCtoma+yGAxJJrpLFNTiioQlBcBMHnlHpOvtl9TJZFKccqKzX9N2+7L3qxJR78UAgwo4tAkUZlB25PK7SbJIy7NTJOd1tMi2Cj3oNftbgh+iaXJcvnXZM0whnge9MNbC00Lx5yBvQ1Hb9unThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YzquvHVHuFkHd4oelkszO3AJ4EmrBtophqtMj0Xg2M=;
 b=aZ9Gb/LQ6oPUR7HhY8wuwScePG549Hr7/Vv5RDMb2lyl4WX1LAacnnFD7ConqG+XF+tNH9SUzAVeqPGnk3SPySJrhhnVDPWNcPK3B/eYkS0fMYc4+SWt+93gnOMAla/1HOw+/IFwKrjDKGGjPs4pd7lCaG/5DLtek9GUFFkRMguexsqP8BOpkCzwqy26c8lwXphVoMfGAva5jV8KLvrrQivPbQC54nrMROv0LFEQayrieuyd/4thYVZEYhSHCZOoQRs8cMf4v9mCqYDvJ4LdnjUSn2dRLAeGzhNE2XWNQO+gszxbmRL1QNGZPVlSKbrHmXFUNoN//nnfObrxmnU+Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 00:56:59 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 00:56:59 +0000
Message-ID: <5720d304-deaf-439a-be8d-aa6e850f22a2@nvidia.com>
Date: Mon, 22 Dec 2025 19:57:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] srcu: Use suitable gfp_flags for the
 init_srcu_struct_nodes()
To: Zqiang <qiang.zhang@linux.dev>, paulmck@kernel.org, frederic@kernel.org,
 neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251214101433.126434-1-qiang.zhang@linux.dev>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251214101433.126434-1-qiang.zhang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:208:32a::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 9823d9c7-9418-4cda-eb90-08de41be2d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVBneXF3VjlOUzMrUlNNQlhKY3lqTU15a2ltSnlxS0syVmtGZmxVSU9KMjB5?=
 =?utf-8?B?Si8vY1UyRWkyR0haQzhsNTRVNWw1Q0ZZcmxtbWYrYkpFVWxnT1Rpa2lNeTN4?=
 =?utf-8?B?VkFqZGNMQjdIbmJ1NTdqNXJIYWkvR2l2bzQxSHJwRzB5UWJadVp3aDYvSUVB?=
 =?utf-8?B?bXFXaXNTRkMrM2tOM1FZNHVYTlFOaE5pajNtSk9zVzJPRHZ0SEJvb3FDN1ZH?=
 =?utf-8?B?WER4MXIyYkNpbUVJRnRXNkxocTRyTjlHaG1ZTlJoQ1NUY2d1RkwwTUVTd0Vz?=
 =?utf-8?B?NVlmb3NneHl1YTdaaTdlcmVRa1BMVlRpdVU1cmNsZCtnOHFuRURvWGJ3Wjlt?=
 =?utf-8?B?MmE2TmVFbG4wUDNmd21oVEZVM0QyNkdyUWZ3Wm9xMXBoU01mWFI0dlhGM0pG?=
 =?utf-8?B?eHpEYS83UXY2TGEyNFAvVHB6bE5CQ0FWT1lLV1YvNE9xQzhyRjFEZU5zeUFn?=
 =?utf-8?B?bElUa05tSnc0bzdWTDVtMzA3MnlTTERGK2F5VEJJOTkxb1l4b3BBdkVDUXhp?=
 =?utf-8?B?QmlIMC9KR0dTWUZaUnBWc3hhVjZ0b0U4OGtPMzRUVUxMTmVYWU4ySGxGb2FG?=
 =?utf-8?B?V3h2KzFOdXVQbXBHMzFRY1Y5WUhiSHNQK0g4YWFYa1M1MzFWcnJKS09nNEQw?=
 =?utf-8?B?TS9sbUoyZEJ4OEs1VmkxRHpiZUhJcUY2OS92Y0tRR2Q0UjAya2lqNHcvU1ph?=
 =?utf-8?B?Y3YzYlNGN2ZkaDAzbE1NVGc2TFA4YXB2SitKTDNpeEpRWWg3MTEyenpWWi9i?=
 =?utf-8?B?eGNRaXBDM0VrRHFKSU8vblFrbzlTUXVjMU1jZ09FaDNuSFJPeWRTaW5udHhF?=
 =?utf-8?B?aWNvL2RwNHlrMmdpMkpnUGhrY2dnbUdFVnlxM2oxTE9SdllyVTNad1E2UWdJ?=
 =?utf-8?B?WGh1TzVEaDhNWUsrT3hKYm5wWGhsS3lHSDJaZGJBdXFlUWlBUUhtd0hZU2Vr?=
 =?utf-8?B?V2xybER3a1ZLanpFclE4aVU5ZzBaOThEelhpUUdXTGpRUk5ZS0ZMVnpaR1Zk?=
 =?utf-8?B?YUNra2UrUU1ObjZoK2FDcmN3TklXRkVZclZkcFRrb3hoK2cxbVJJN3ljT1dB?=
 =?utf-8?B?cHRPVm1VMGEwWWFUSGZ2Q0pSaTU4WXhMTld0S25KcUhBSlI5WkdqMjJJUWJm?=
 =?utf-8?B?R0JQYlR2Tmlpc016MS83RzNCbmQzZVhNVU0zY25YcVlRUnhrQ3hXZFN5R2Fo?=
 =?utf-8?B?OWtOOGdLZmFmWGhxTHdqckVDWHp0bmlPMkhoRnBCbG1SNUx4OGpZaHFuZDNo?=
 =?utf-8?B?cnVFQWZmeXRaSU1SY2M3THRNU3BOUE5lUWNrQVBURTUrYkpES1lYMDQxQmh6?=
 =?utf-8?B?bWRRK25CcU93ODBEYU9OakIxbEJvUzJOZkpkTEQwRG5EQ3h0SER0bGVmSWJB?=
 =?utf-8?B?Umw2Z3I1cDlQNjgyQlpkSzRKYjdPL1l1aDFrdGY2N1NLL3JhOXMyN1dOZmdP?=
 =?utf-8?B?a1lTbS9ya0NzYkIyWW9PYWJrQ3MvdXA4WSt6a0tZcTJRWkQvdWJwTWNIMmJS?=
 =?utf-8?B?cHJSNzN5N3NCSHFGVlJsYW5YZlVUMmxWZ3owbkNtTmYvRHk4dytMbCtwNzY1?=
 =?utf-8?B?cUU4Z3BaRG9PMlk2Ull3aG9XMGNjMkp1aU1jUC9veFNvVXdVZEY5TDJhcGh6?=
 =?utf-8?B?TTFoKzc3NjB2ME5SenEvVnc5ZGdNWTNaTlJFbnZpbWowTzZnVGxMVDFjRTRB?=
 =?utf-8?B?SlU3akJiYm12NEdsY1JYZWd2akpoM3IxTUtrenF2aWovWXAySWZFSW8vLzVm?=
 =?utf-8?B?ZHVYUUNzRlhJaFViUmk5QTlpeS9vQldvQ0lTb3RTbjBvM2NGNzAyeGsyV1By?=
 =?utf-8?B?N0hOcWo5V2VsZERjRE0zVjA4TTBsSUhBck1aeFRjeEVQUUV6Q0x6M0FzdmxL?=
 =?utf-8?B?Um9hYUVTTU1ZWDZwVzZ2VHJMTThMdWFuSzU0VWFWY0d6VWJpa1RuNHBFS3FH?=
 =?utf-8?Q?F4qEQ/x6FGx4fQYEQDwX82ASg32YA06c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2hFTHhvY3B0N25BT2JDbnVFVU1HbmN2dG5zNlNpZ0hGMmlRV21QNW1yejkr?=
 =?utf-8?B?TEY1dElTajlmU2xCUVZyRTRQTXdYUkl3Q3A3c1lTY0hFV2FybVI5emdtZ0s5?=
 =?utf-8?B?VzJwUnBCL2lvaE9lemhIKzgwNkhydzR5NjlrSm0yYnh5NGoxU1pQWFZDaEpa?=
 =?utf-8?B?L2tyLzkwOFBpUzVqVCtuZ1NXU2JHZjJtVGZaaVdBdVZYcUhmWkFrd056c0NC?=
 =?utf-8?B?aTdyTzljQnNsVXRpWVBxSTJIV25FbCtjNlVZdHdjcm8weTZlY092NGk5Z1Ju?=
 =?utf-8?B?S1BDckR2ZWNTRkZ2blFLYmZEa1JLOHJRQUZBTk5mMnlaY1p3ZWRhYi92b0ZM?=
 =?utf-8?B?Sm54QWdFaW9TK2F4STJBSmUweVdVVVdKMlorR2ZyeFBacTNNaFQvMGJURlRH?=
 =?utf-8?B?VTl3UTBmNzdvOVJFWk9Xek82akc5ZGl2RmJJR3UwRmRVZzlqTm5rMEM3Tmcx?=
 =?utf-8?B?RitucmNxYVdLaExCRWJXeDZNZmRvWVgzUEt1enpZbW5zU3JkdWlaVS9IN2Vz?=
 =?utf-8?B?K1lKMnBtS0I1TnIvYjhLY3BaTU9LMTJOMS9LVW1HV0tRbnJManM0RCtHN1Q3?=
 =?utf-8?B?TVROZ3krM2w2VGdXb2IrYm5CTXFWUnNFYnRLeVVvZDdoUjVjOTJUWnNZVTV4?=
 =?utf-8?B?WnhaZTNqYmpYU1gvamc2Zi9XTWY3cDFRODlHZDFGaWpPbzFrS0YwT2k1RlVS?=
 =?utf-8?B?RmZKVjFzQTZVU0RvTUVLVC9ZSjc0VHZWcGFaRHhSV1BWVEJTWXJpZ3JQLzVm?=
 =?utf-8?B?SjVLdklmb1YvQUpIZjJzdmR6ZVo3WmRjVUl2bEorMTcvUzlHa0ZIaVpxNHI3?=
 =?utf-8?B?ZWlrTi9mak1GTENER2xGZXdvNXpWSmJlZThqWFdsVkYvQWtsbWFvQkw4UXkr?=
 =?utf-8?B?RFAyR2lVdklzdFlQM0dmaUFKeTF5WmNOU3h3eUpIVlVqSkNrcWpEVUgzc0ZW?=
 =?utf-8?B?OFNCaEprTU1DcldwSmRIM01zMTBLaC91OVphb3AyNS93QTh1SGZWUG9QaEMx?=
 =?utf-8?B?ZG41Q0tpR2M3Tkw4Vi9VcFczVld4WDYyRHRnNDJwL3JnM3ZJa0JNaHdWcSs3?=
 =?utf-8?B?TTNVb2FUUHg2ZmM5WHVYOWRHblFHWWgreVd2NG5hU0tONlNXZjBDTmhOR3VY?=
 =?utf-8?B?SmYyM3V6NFZnaWd4b0FhRHAwa1dWWHFPL0NrRmhCWTV1K1dFVXdLMS9lQUti?=
 =?utf-8?B?V0dEd3JsWFRRa0tkaWU2OXJxbWpGZGtlRm4zaFFDZFprbjMxUHVtMTlUZmpO?=
 =?utf-8?B?Q0NyRnc3YXNOdjRnZzVjV1JwZTcza0RWWlgyMWR1eGtZTmNBS3BiZUJYNXB4?=
 =?utf-8?B?SXVza095Mll2d0VzbHdXeGlucTBnNnB1SW1ycUZGeHREaTE2SmYvUEVMMUdz?=
 =?utf-8?B?VTBwMmNJSVZlbHFaYm9rZHR3SGZBZ0VIVHhGTGZaT0dMYVRqTmpEMGJmVmo3?=
 =?utf-8?B?VXJiRFRKL2pjVWN5MU9McHlHbmU5dCtlekhpaTYva3NMMGUyOThsekdXRW5q?=
 =?utf-8?B?cmJ3c3NEb3V5bFllSHhmYzFkSWI3VmpHUGlFZzJsWmgzUUEyc1A0ams1d1Nk?=
 =?utf-8?B?ajhCOXVjL0kxTmdwMm9BNTNpT3hLVjhHVGw0MU5scmlIR0hGSkJMRWkvenNw?=
 =?utf-8?B?Z3lYemc0ZDdVRFRiUlplWEZCdUpNbHJra0xzN0ppUW5uYVg5R0VtYzlCdHFE?=
 =?utf-8?B?ajhXNDM4ZmhEdHMxV3ZiQWtKTWZEZTB0dmVRT1FVc05YZ2tKZWFETENFZzcx?=
 =?utf-8?B?cFVLYWtEeWgyeGNCVTBwRFlHK1BiWTJKY1pCRmlnUE8wbFIvNGVYK3ZZUXVG?=
 =?utf-8?B?YXovQnNrV2IrcUJjMnd4NkRFZ1BVNUNiNVNkeDdnRTlMZUFQOTRUT3NWRzNl?=
 =?utf-8?B?OVl1ZS9tQjdlNnNwa2FnajA0QXE3bGtzR3FPNDlvQjUrN3UxUW1CN3pPazl4?=
 =?utf-8?B?dEZwanBWRGVJWTUyOEV3TythcE1sc3VhNEtCSXFUSkxLM0VTUTE5V3g2YUIz?=
 =?utf-8?B?SnhzZmZhaFNEQnExU3BzN3lORmlrOE5aOElPdXk1UzVic2FGdkYwWTJmZk1Y?=
 =?utf-8?B?TFVpK3QxQlFKZHZhM1l2VktKK2lKbEM3YUVXaGZzemQzM01kQ1NZd3NIRGFM?=
 =?utf-8?B?KzFjN3hNWHY2THZ3ZHhpcTJSYVVWbEV6cDJDOWRncXhaT3Y2MUJCbStRVW4y?=
 =?utf-8?B?TkttVURCZUNSUlo0Z285RitwSHY5eVRHVFVMMDdPMjBrU2ZmMGZBS3FXck9I?=
 =?utf-8?B?RmhMU2lxRTF3YTJwTjd4MGxZR3BPdlBDNjlzUDhDWkYyKytXOVZEUFViYVZV?=
 =?utf-8?B?WTNnNVFNMHpIczBrTm1TMXhuemZqZ3R5cGU4M0tRaGphaXVMVGMrZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9823d9c7-9418-4cda-eb90-08de41be2d79
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 00:56:59.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faIrlk/dNYSP23yiaBwrxXKZiGmjGJIQqRLEdb3r5aImOfYFNUZorVuu+KiKbqLmwKu3iFpaMBjuiuZ1sAOXOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200

On 12/14/2025 5:14 AM, Zqiang wrote:
> For use the init_srcu_struct*() to initialized srcu structure,
> the srcu structure's->srcu_sup and sda use GFP_KERNEL flags to
> allocate memory. similarly, if set SRCU_SIZING_INIT, the
> srcu_sup's->node can still use GFP_KERNEL flags to allocate
> memory, not need to use GFP_ATOMIC flags all the time.
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Will apply and send out to the list (soon) with other patches for further review
and testing.

 - Joel

> ---
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index ea3f128de06f..c469c708fdd6 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -262,7 +262,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  	ssp->srcu_sup->srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL;
>  	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
>  	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
> -		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
> +		if (!init_srcu_struct_nodes(ssp, is_static ? GFP_ATOMIC : GFP_KERNEL))
>  			goto err_free_sda;
>  		WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
>  	}

