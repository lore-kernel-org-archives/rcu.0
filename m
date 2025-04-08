Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81012459C5;
	Tue,  8 Apr 2025 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744143491; cv=fail; b=ML+7XZHt40OKHUiNiXISFFHLxaYwjpRLRPAoFOTqVfR54oF0JhFuru8SNo6/1dmXL2IrwUp3E/7nQZoA3LVu5DxfQC/XlBPxJqu8GYiuZYTE+TPbA/l+NkQBAyu7bq+3QSEyQZlsphct2Re23BlwYFAOQQJZnDcRxBFkd80VErA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744143491; c=relaxed/simple;
	bh=HpJ8mTobXGfGgvgvWVHMwBE0tqDUEHuY2YSSVbBdBWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUOJPqEgGhNXEOKHOjJBAP0czDOtaKcBcQTxLL23PWs0rbdayP908R1fiYz/QQUhD2W0nTrvyuIafCVc5rb4BmExmJytU6nFft/G9GhYHY9nW9Hr9koYwYzhI00JBZT6L1GRVa8S/mBH9ZAwq2UbhCrHcuNn7oBHcsn62TfjuJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XmFjTh+V; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XmFjTh+V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQGr+sIiKJE2Uv1JqKI8DngIham2z85i8JC/QGDq+StVKTwVpc6XLt0HC18VWu/IXK6RwL4W7q4Fi1DayTGY/HOyz7wVOaQ7Y24clPRNfvAYqeZCd6LOAydUr+qGEApjmRD395DXxZursKpZ0MM7P+9UoFSn0HrbmIYvEuqPu3RpkHCsLCpNud4gSJ8znhXL7uxgfB7FzFoyOrnEJViZkBn656rT9bohx72Q8ubJA7NL6z+6musnrpZkMv5eGH2FfWQn/RdFA/REBX9t51LAAo9n6uSZvSsIUreV7NjNNPepsSAqTOrYgAJF65TRtzeBdj7IwnzD5w/Zjcl4Og4Vzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sip5TXDgb9EpeG/5zxzq9qdY1+fIh3apJIDn7CyWvFA=;
 b=J3Snv5Tug8JFg73y4b/zOLPcySSdVlZlOp6vksQxBU4F5HVh1qt8slu81f0zb4AnEhj0Frda9ZBlKnP0v0rxTHLkEnABeiYTEyXTjBBaaN1ZP6dfn3jEUGXrucwkZEGz3bMX/88ciMbE0iqRrorh+KhlLhe1vqe5ZsP3XxpQdQcVbeiltmQzpQhPokzvgDVmeZ2fpmHaz2MQ6paEBTdQw8af0QfGRffs5/bzPkRS+T0f35/p1ogYItDVFyd6fhymfFiU5lL/IrljalVSlAMt+va/6D5qnKmmXpqBYnQn/rv9oBJNBxeweVlPFrVKko5D5xByKpFNzQqd15Z5H5PYOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sip5TXDgb9EpeG/5zxzq9qdY1+fIh3apJIDn7CyWvFA=;
 b=XmFjTh+Vb9s4h2it5XW8Ht6eUL9jeZ9m9IZ3HvagC8XJcmeOpHUnO/i6vUI3vawUNQqDtO3u846WSlijhPZDrH4D2jJIepS0EUDYgKMC8siii/gY2tixnrQSSTJJInxleiKBBeQo1HkmNAnCCJGWX273LPRsTgc1c2Cbawp8Q+RmwfE/7e+vgcB5sHq/+elTasKVpb0aPdEmiI12c+sXZ9jshZ7++GNiSvRa5wap/9dw7yx6V0lj1Doekf0U71LDfc3fOHcPgmgJm8hPE93hoTb2TENuHtUfdeGA8RaKcX2CH8rchh6w5JU5K9PlRVV8JeZ+VZ5Gh4pBZz1VUAOcbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 20:18:07 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8583.045; Tue, 8 Apr 2025
 20:18:07 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu <rcu@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@meta.com>, rostedt <rostedt@goodmis.org>
Subject: Re: [v2,05/12] rcutorture: Add tests for SRCU up/down reader primitives
Date: Tue, 08 Apr 2025 20:18:05 -0000
Message-ID: <174414348524.117.7223153072511748144@patchwork.local>
In-Reply-To: <20250331210314.590622-5-paulmck@kernel.org>
References: <20250331210314.590622-5-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BN9PR03CA0964.namprd03.prod.outlook.com
 (2603:10b6:408:109::9) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: e88ecfa4-260d-484a-a53d-08dd76da799f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WStvMGpTTUMvT0NpTUhVL0hNbmFsd0pqZmsvTVQ4aFRERUFJNmJQc1A0Nysw?=
 =?utf-8?B?byt1dkhhWlR6eW8wZkRsZEpFaHkxcWwvNTM2YktNSG93cUdKT0VrMUFTNWNO?=
 =?utf-8?B?MVdOVm1FaC9LeFFxODhwR2NKRGtPbU4ydmhrSHBUT0Y0K3NUU1Q4a0tDM00z?=
 =?utf-8?B?Y0VUTWhuQVMyb053dE5CNXpBRTVWYmlBdUpzWGdaM2t3bHR3YnVqalNSUUc0?=
 =?utf-8?B?K3RZOEFyK1hueUk4TXd0aGtLWkFZOXlpRHV6UXB2OTdpTVU4MFdxV1JxUkVC?=
 =?utf-8?B?UlA2S2FXR2xMdytpa0JBNk1xWnhubStFRnhJd0Y1Z3V0VVExUEtpbUpJMVRX?=
 =?utf-8?B?TjNjWkxxSnF6dXQzemhCQ1pUbXZuV3lBcmQ4NW0xYTZwWGtlcTc2UEh6Nit0?=
 =?utf-8?B?VzlLL1ppQ1lRWi9WLzExcmd0bEVtc3ppRjQxeFdxc3ZwWmJtbmpOVmVwdllj?=
 =?utf-8?B?N0NvcllBTUJteUlISFVSNWlwRmlXd1IrVEVXc1gzNWZVUnpLaHIyelh1Y3Yw?=
 =?utf-8?B?MG1ibzhHTkdWUVM3MDRKRU9PbjdQZWJMUFBaYmFxMy9IVW9WNTBVZ1U0RTZP?=
 =?utf-8?B?bFZoQllhMTR2eDJJT0pnQUtxZzRJdmVlb0IxRjBSdUFQZXVGVXpNMm9XOUg3?=
 =?utf-8?B?RGU1SFoyZlRiT1JQTkE4U1p3ekVjQm4vYkpTY3ExTWlmMDBsQWJFMEpSNVNV?=
 =?utf-8?B?Y2x3bFhTM1FmQWxIMHQvV0FkZGk4bEhzeUhZb3Y5QmQ3emxoZ3pEQmI2U0hV?=
 =?utf-8?B?eTlCYTdlbFoxUVZ4OUtHMHRuYVFpKzR2L1M1eHBqTHRNam1OMWdZWGM3eGlz?=
 =?utf-8?B?K00xZG4vdmpqZzVoMHZZZ2FaazJwK3VzSTZHWnI0cDV5VCs1VC9NTW0vRW1J?=
 =?utf-8?B?YUxxVS9BV1ZzcGxpTVZWTEI2YUtmbnJWUnhxdEg3WnlJR2JaRUtZa2ZPdGM5?=
 =?utf-8?B?aFhYZUpFVWlRaTBKbWFEK29xaUlpaGdPRHJvLzhPYmNDWWhwbUprQWpSbTk0?=
 =?utf-8?B?elJ0RzBPWUxPMVVDazBtUTh2RlNOQ2lGbUJkaDB1RXJBKzFaeVVMdUk0S3FD?=
 =?utf-8?B?Tm0wZHBFYis3VWh0cndGcExYYlVMRDVVMmlsd1lnUnVpQW9QaFBpUWRGbVht?=
 =?utf-8?B?bndEQnhjaFd6U2tBejRhMW84SWxVRDFmTFZ3aFJIVDJRWWJQcmhURUlJekNT?=
 =?utf-8?B?R0w1Sk9kYXJKem9OOGtDRTIwLzk3MWhtY24xYkQ2dEJkeTdtdFpKYVlhMzdL?=
 =?utf-8?B?VG5jcHZEbi8xN0xrMUljMFVtS2M3MDdPYUs5RlAvY1p3NWJ5ZUhSY3BxM2Zs?=
 =?utf-8?B?VEl0VzJtZXN0RGx6V0s5K0FJWlYvNkpJcXlnVHZvOGZFd1dYWGlldkVHTE14?=
 =?utf-8?B?TkNGUk1Qdms0Umo0THdpdGx3YkV0akxJRDhXRW1jNVBLNUY1Rm14WE1GeHBR?=
 =?utf-8?B?MGNDbHBLdW9NNm5lL3A4TmNuRlJjVWQxTUMyYjBWSGxhUVJ4dHhrOFVGcTNo?=
 =?utf-8?B?MUR6Z1ZzMGx6aVlWSEd6SUd1dFh2UGplalBQaTFZRlloSGlaVlhucFpZcG1m?=
 =?utf-8?B?b25ENGszY2V0TzR5MWdFSzBMa241elNFcWNzSGNRRmtWeEMvZjB4ODBNdFJi?=
 =?utf-8?B?c0tBYktBYWVJVzR6VEpiaWlOU1BkLyt0c0NsQVVUb1ZXZTVMMlAvRUZVRzgz?=
 =?utf-8?B?c01jeC9XSzk4ZmY3WUlLN2VwWTZ2QlNvSGdleC9jTmNiWnM3L0VMMDhYa2VE?=
 =?utf-8?B?eGVZdGJTV1AyZHk5OUdYelRPbHMwYVpzSWhDTFlnVVliNlFUNlZwQmRMUUp1?=
 =?utf-8?B?cHY5S1BTTE0wbjZ6TU85SFc3cWdnZlJHZFJRL0N5M29qZnEyNmhpa2FQTXFa?=
 =?utf-8?Q?6F/XsNIBqZgDr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlB1MnM5QkRjRmZpb01LWFRFNWl6MTY0MXBwY2FjVGxNUGJMVzF6S2NpTkdt?=
 =?utf-8?B?dkxoSXhsaWNvaDdrd3RjMndLSFFEVGoyTnphZC9ZNXBwa2Y0REVVT2RNUTEy?=
 =?utf-8?B?ZXJROE1UWGhKb2dwQzgrUWF4SWhUUTNDQ3ErQlMyN2FHYU8wTDI0cjhYb2o1?=
 =?utf-8?B?NEFvd1d3L3lxMVBEZzN1N2RsNEF3d3RjcjI2TXphTTFoQVJ0cVpKdmI2N2hH?=
 =?utf-8?B?bGRGYUFKODlNeVFvK2VQSitWZGh5KzBYenpBbXlEMDZFNXVnU3hhU0g3bm40?=
 =?utf-8?B?Qm5WV3A3YkhOeDB6NlhDdG5VbHFSdE0vaFFzV09ycTBXaTNTMXh4V3UxRENi?=
 =?utf-8?B?WVFwVGxtb3h3NDRYcTFwdVVUSUFyT2cvZjl1MlVlZ1Zad1RzcU1sYy9COXdE?=
 =?utf-8?B?V29HUW9kNjlURnNOMy9XNkFHWU91WWdQTkFTRERLL3dKS2pPcWFMSFlrREI1?=
 =?utf-8?B?cHFremFaemcyNFhMV2ZyMmY4M1c3dVZtTHc4Tk5IZThFN25mYmNrRTk3UlFT?=
 =?utf-8?B?TjJTcEhldTBoTUFCKzNEWlFneGd2UGRDODdkbWd4RWZWdVdySnBWbi9qVUlo?=
 =?utf-8?B?bEt2Mm1zTGpONlN2Q0U5eCtEMmliV01TbFRITGhwcUlWeHJMcGJ3RjdUcVJC?=
 =?utf-8?B?VjhJNFlHSytCcUxVUHljajRKeTBBL2piR2hLd2pjVElicUtMRGFWUkErRElh?=
 =?utf-8?B?MTVUWlVBeFd6U2U2eklXVFVQS3BqQi81cWpieTFhYnhTeGVCd1BVSSs2SDho?=
 =?utf-8?B?blJvTUFURXRDUUZxNXlmVkxEOWpYWmlFTklVNE9OYTNKZFcxOHVEL1MwZkQ2?=
 =?utf-8?B?VDBqa0hCZ0lSb010UnY3VmFQamNBcUFnc2tjMkZCZDNPT2hnaTE0aWNmcDdn?=
 =?utf-8?B?RVlJZ1JHR0RrQVU2TXRLa1hDK295YmZuM09rYnd6WkVwdSt2bEZrY0ZHSkJq?=
 =?utf-8?B?ZXQyc2RsVkRYUkRDckJmUHdHMllVNUpEd3dRYU1MZmNFcUFPYjJreVluWFdx?=
 =?utf-8?B?K3FSTzJHOFJ6S013cW5NaG5sL2ZVYlpUdzlZZzUrbEJFbzUzYU5VS3g0STNF?=
 =?utf-8?B?d1dob2pJeklpOWxVdWJyRTd2TGNDdXhDSE5iZStLK0pSVGRGbkhvODJsMzlH?=
 =?utf-8?B?cVdwYnlib3FsZEthTEx3MDZJSHRIOHhHL0o1TkIremd5V1FISjkyOElONmNm?=
 =?utf-8?B?SXl5M205UVBiN2ZTdW9BaFQvblJ1U0VYRHVmRnZERVB6SjBxd3VUL3dJaWRl?=
 =?utf-8?B?WFBTQXBQL1lFcEtiMWVydFV0clFKOUhKamp5RzIrMjdITFV0bGZlVmFvTVRT?=
 =?utf-8?B?MlVzTm1UWkVXTVE5RG1CSkZqU2dHWlQ1QWRDUFplTnpLSUhER1R2bjQvSjJV?=
 =?utf-8?B?U1pxZE04cTM4M05USC9zUE8ySjZkRzJ3VzJ1bC9SVXBvbjJKWEM0M0kvMm02?=
 =?utf-8?B?aXl6ckRlSkoxdFpIZ1pRQmZ1My8ydDBQOFJqUmdtKzJ2NDgwVE9yVkU1RmNi?=
 =?utf-8?B?ZytPLzYrckgzSUptN25CbjVsZFVrMDRTSkFBNk9hZWR0WVQ4VzlDLzk2T0lO?=
 =?utf-8?B?cDZic2JSS3dIaVVKZ0R1YXdGcmRRaFl6dzY3MTc3MUIyYkowak1VM3k1UFhU?=
 =?utf-8?B?bnZmak8rVWx6VWdxTGlLN2tKMmJ4WDkrbjZIazdFSTNuWUhNd0lDa1NkdDRF?=
 =?utf-8?B?WVdTWUdiYzdUb3JjOXNHYUpkMXNBS3hTaVhQVlcvSlcrVkhHWlNmTlVQQ2g3?=
 =?utf-8?B?T1N3WDY0YUdHVTJSWGV5SlNndURYd203cm4raXZEVkRvWGlZVXgvZjV4eEFP?=
 =?utf-8?B?MFVVWjRSQXBXK2IwaEtDTDdBWkZ1M3NzWkxHZXZkSXUyR0h6R3dDNmZWaUxS?=
 =?utf-8?B?ZXVXK2NIeWtpbUlSU25RK0JnZVdVRzVYRElFTFhNM0dkcWljbm12M0lqd0pa?=
 =?utf-8?B?YUNVbFdrcTFtaDIyRUxETkkxWVRhTzFVcERsbGFLNXVEYXpKeEswSEVjdkZK?=
 =?utf-8?B?c3ZMWGhDbCtvMjc1aDh6Um11Y0JvOGx6OVoreWNqZ2F2RDlGeERieHVoNXpW?=
 =?utf-8?B?Mlk1SkttdysxQ09iWEs2NEo0WW1nZENhTmdEWlBBRDVDczF3anRHOVZsRHFa?=
 =?utf-8?Q?BpYGQnTcC9ZBIPtrlKbhkzfUB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88ecfa4-260d-484a-a53d-08dd76da799f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 20:18:07.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWW6JU/1wAaY0TEM3RzotoWbyFGqK+xD0BHwpWguCyzwyLov7Zjkv6YItD42DOQhf/kh1mnbynNaWQITzVR83Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129

Hello, Paul,

On Tue, 8 Apr 2025 20:16:08 GMT, "Paul E. McKenney" wrote:
> This commit adds a new rcutorture.n_up_down kernel boot parameter
> that specifies the number of outstanding SRCU up/down readers, which
> begin in kthread context and end in an hrtimer handler.  There is a new
> kthread ("rcu_torture_updown") that scans an per-reader array looking
> for elements whose readers have ended.  This kthread sleeps between one
> and two milliseconds between consecutive scans.
> 
> [ paulmck: Apply kernel test robot feedback. ]
> [ paulmck: Apply Z qiang feedback. ]
> 
[...]
> +	for (i = 0; i < n_up_down; i++) {
> +		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
> +		hrtimer_init(&updownreaders[i].rtorsu_hrt, CLOCK_MONOTONIC,
> +			     HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);

This will now fail to build and needs the following: I will squash it into my
for-next branch into this patch, but let me know if you prefer to provide an
update.

    Fix build error by converting hrtimer_init to hrtimer_setup, see:
    https://lore.kernel.org/all/174384280127.31282.2714486346304643188.tip-bot2@tip-bot2/

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4f0a00a8bdee..14a22ef3b56f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2480,9 +2480,8 @@ static int rcu_torture_updown_init(void)
        }
        for (i = 0; i < n_up_down; i++) {
                init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
-               hrtimer_init(&updownreaders[i].rtorsu_hrt, CLOCK_MONOTONIC,
-                            HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
-               updownreaders[i].rtorsu_hrt.function = rcu_torture_updown_hrt;
+               hrtimer_setup(&updownreaders[i].rtorsu_hrt,
rcu_torture_updown_hrt, CLOCK_MONOTONIC,
+                             HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
                torture_random_init(&updownreaders[i].rtorsu_trs);
                init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors,
                                                &updownreaders[i].rtorsu_trs);

Thanks.
