Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC71C5D5E;
	Sun, 11 Oct 2026 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791677773; cv=fail; b=uj0HMKNomRtZT/7vlI+vy959MUV1hADCfLmAHIQTixDnijxMenBEyRVeHFLUHxIyqSWB57rNduQvqUb6Df852o7utvQ8xsJzgd9HaDQKAsTY3UsJGZ+c5mvpeSryxV3D/EfCc/iyTlJUcbKwgsEXghqVqzBwrnUfMOjlFdE2YH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791677773; c=relaxed/simple;
	bh=zEpnPzvYJG1ujj3ygoT1FwmVEn+31Gcth50OFEoG2vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dSK8AtPsAn+OMgFMa+JSWLkuI0aTzJCCsfAg7AqILar0/pLSVwDaz0bqDWH7cBMCb/ZCqR5/zYwe/NPq3zXEGESGa8wQE1rFYkF6EfFhSzZCeYFMJps4sHKF3UHf/jNKstk1AaVQtCsNP7UXkcA60R4qHZjtiZKbaZfRUUjgm5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CjlJRlB2; arc=fail smtp.client-ip=52.101.61.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CjlJRlB2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AARLVDih1TjClX8XdAbu2IHPnbDi1jxVYLkAoitMCGw0SMVwJIGCi3rwPw6iKHFRm6pS9hhDN8mQvfJHcmgmhAyVrbJNHTUS4adbL0dz8/M1XCqTWcCWMvm8xMCLOwvDf+AYzyEZKVBC7MWQesadIfFe/26rXMOuG1xkmp8rvjjcbpu2BC2AgmYuDIS9l5qwFK78Z0JiaEa4ZQH7LXkUgzwDNJEyBPWvC5awEQOhBqUAyi9tngAWzt/pIaSUqqKUGudv6uALs5j6fFY+VXnYVFHzobEDwYngLA3asIfi3g2lSw8o3dt7yBft+G0aZGcu1/UEbdzVv3UYS0R7PVgeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHBd13PZIl+BZGLDCcecw8dHY0+nMzTqNfVkTSupGMU=;
 b=OsodpLaRKPFMF1Dl4cPSmjLxyWXM/qziT/EQvHHrriwaE38wAe71p0wsIxbxtB456tr3YQtdBfecK4a4krg3RazGcZa1rEHs4gn525Kz68GiPD7xwfGvGJ6ZN7Z95tImD9nMbP73sslZFmgCRRo58UarRxmvw02Ddok4bqiYB3q/q1J/wn7oSa49lY0npwi//XVFWiODw7wXqjruALFs2SaJb01CeRLIp3O8kw3T35FuX6WE4s60YOYzwjqQlT1mrHHd0kglqvAEJNKz3ujN5vxe/k1yCsMqxrf0j9BPn6PDoR7iifcabj1WHBR8VDWVOJini7WQ4RKInW1mmT3+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHBd13PZIl+BZGLDCcecw8dHY0+nMzTqNfVkTSupGMU=;
 b=CjlJRlB2TZclQWBFP8Swlo8m89TdBcwsyWBTa2J2au6M7hlVH8s7vDlwk5T+y/LmVsxWmZR8d94qsS0LWU6DMTAIxG6pqGFew045gJNjT00AugytouT7c7xtk/Xjosjg20XQwWhd3Jk7tKRq5CDjjZUfNzqdc2x5HUgqBdNWcHofK0B3Tell4N3FKQPEQTH9GYTKvSFJN1OwpVu2fGpgVsXocdUPoGCEzlm4S6gAqCc8Ko+wx0SOidxlBj4rlssGIF5MrFDEZbC8xdERs6lj9gEZLuCsr7njynTeyqHh14kzNmzhez5U3M5VBy5bkpjKblvyeUU1Qega4fftODUYdg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.18; Sun, 11 Oct 2026 00:15:26 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 00:15:26 +0000
Date: Sat, 10 Oct 2026 20:15:23 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	urezki@gmail.com, boqun@kernel.org, kunwu.chan@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: Update recent SRCU API additions to whatisRCU.rst
Message-ID: <20261011001523.GA2491714@joelbox>
References: <20261010102813.25460-1-qiang.zhang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010102813.25460-1-qiang.zhang@linux.dev>
X-ClientProxiedBy: BL1PR13CA0328.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::33) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CY5PR12MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 473340be-5081-47b4-e1d7-08df272cbfd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|18002099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2tkVeCBbnTCrOkJGYtdFkqWgIl7UFUV7EKuGAqKudrtsGR23CQrubT4NFxb5a4Kw1UsphjRcffnjkwAdaIFcG+LIOnsW6p4A0ip6f7+LL4BL4eNtGM4k/SZ3aySiNpwP9Xre3LL6POi956xJTRyMU99XPxmupiYAK42eVRwMfkJoAoUnuEJbRSXxUrci9/Y+H5/wIldfqTtC6WsJqTjyRNbhowoHzOW6jrNx6gpn4wmzjzgtxmyQDM1+IBsO5KH4dLKqsg4q4zk5eYQ+JeIW82md16esgm3hXXmE6xV0BW+MGNu0yQag4qLz9s3axZ7ky+1OVqVyeRjRRwi74JwZ6lMl3J6fjGORtTHW2AYFY3zInEWdfuklLKe1jdCF9ze7I/3+CMsLGWeri1MoQ6sULT4ZL8cQwqyoRp+AwSR96mG0pinEcbfflu205LVoWyfkgcq3z7o4MBDeZ+jOR31lTCp9ubDJxzgvYWLrdL4t5AEMATC441I99k7nff/rsM9SRaboNU3m/KqjaWzmcrHzLnrxaChoHFMZ2pyjXuwKOR4Bv4YnIOZwXRFkoy88jXgZA04c3zoRhS7UbMehWUhEcmSVIlDM7mQ9L7W+GzmCv2z52n9W7IgCCI1ZYGF3KdwgJdZM8BVA1MUUN3GCRR2jsiTCVcVcqqYwhrbuWHYTiIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zSXabRhn8PCqwVTgXOIXi4UrEp9LrECBHh3wVFwq5GpHX0sq7R0opNBQZqcp?=
 =?us-ascii?Q?Ph41b9r5SnfvC67o1shFsuBBX2e/lZN/CYizgz5M3UEWS5Lxacyr1QyuKBZq?=
 =?us-ascii?Q?UF+NID5b2tdc2pfioG44sFeF6bY5qCpSpkQdAOLUAO13ahwD9HYs04ymstIR?=
 =?us-ascii?Q?t4zgeLm4ItcXxTn70rjX9IxSWzZBx8GH2eeRfXeX44erRU1zEYJFLgnzXl3d?=
 =?us-ascii?Q?UZneVFu1VTxhPNzsqrmcv16invFyxq4q9kE4ICNPX6bBGewT2kpK/EXaUqCN?=
 =?us-ascii?Q?ITp2RZ3w64Bsz1HwePnRAGiV5+/OqjoXZtPkkP5KuWPZ5cEkeEMdzmmJtI9G?=
 =?us-ascii?Q?ahiNsj5OrlN96pIDj35KAT4eAXhIYYsAzNOJ9q7fpo17M/ZcJQYBrKqpS/g4?=
 =?us-ascii?Q?QRQv832HX0tpD97HuNZ/enX/p5Cj3kHsfViBq/LlnSYU961guu7bzRN1XYFJ?=
 =?us-ascii?Q?tJVX2iqtfNXdn2fw31EqTohZtBLd6Tt0jdUvCJIIc4qX5n2cfe35Ko800p/x?=
 =?us-ascii?Q?PBXMbLn4S5rrJI3P5blZN5izl12RAgI7qtw0NUlcX5Qz7CWLc3agp17Piy5n?=
 =?us-ascii?Q?YvM8tgFG2qero7p7vi1rIrFLngAZR4vs/OD4EwGjtkXLkBVDIHXZ3HUp7H2f?=
 =?us-ascii?Q?CaiRWBmzGP6a1GrN+JpCXECy3Y4oyfJesfpyCPxehiYIFGrucqPLW95jKutQ?=
 =?us-ascii?Q?3FZY8+9G5WvmbGumx1SVx3cWJS8qosdUzU9bDypMpxcOXBtEA4sFooCgDWcV?=
 =?us-ascii?Q?9D5zp2COIF2jnXA7SoLCTK58h9WYn622UPYGtL67+jJk8qVXjKpAswFZn8aB?=
 =?us-ascii?Q?chsIBjpygo4heR/0pnB4Xr+xYzK9euIPVEiVxZSu5DjNuvLQftNtZfMUki0m?=
 =?us-ascii?Q?6sVnV6lAEaHNRxOnNDR/4gTfuT+OEzYmv8Fputyc85g0nkxD12zlbFChWzN+?=
 =?us-ascii?Q?eMaBBgs3BL4zYS9Dcu/sARuC/zoWrjAJNy0NgBdi1FyHwIyUXkD0+hyTprQQ?=
 =?us-ascii?Q?DMYXUm10r6S+YNbuHGfn7N2+bJQdgjK7wCdK0WjO9F+kvyQgKLeDXdzw3wK3?=
 =?us-ascii?Q?YcO0jTf63B7kIxkaF5lUopaeF4VNDhdJdZwm0bZhJREpdcQ+Fnwfy02gfqwg?=
 =?us-ascii?Q?Iu9KkIBj+49BR5nK7PutTVcpP02sn9RQLmA0vTBG8xAn5nneHxv9qF/1Q6Z8?=
 =?us-ascii?Q?SlRPHzgrJedluXZV8zOZkIMe75J7/MCjSiNATppNgm0VN5ikAqBHD18f3+1N?=
 =?us-ascii?Q?q9AjZ3LvKWbAbMVaT86vURkLv/Fhu+JwNTbeIvpwGTn1aStR4/XEAcRTp30c?=
 =?us-ascii?Q?Ahfedvpxv4aZHtnIniwhklDSS6JhEh544pr4vcGeNudmArYNA5poyn15TPnn?=
 =?us-ascii?Q?RMy9D+6GE4IQSJ7/I9AnZvI3L7VPzhqwVZwacKlytQI6kfJCoaH+66FvgRnv?=
 =?us-ascii?Q?xdPEcQxm9Du4rnFastIk6ESZiNYu1F5jYNAAA7SXZJGCXt3hJs739Oy+2TKU?=
 =?us-ascii?Q?kfJ6yg0J6vMFOEqdmUiOPgFlGTUiSl9uILVV5cZZttf31a3Z/KVSD6Sr9jfc?=
 =?us-ascii?Q?9kk78hXBpxa3FkUSSUqIJEwdjHDegbTaZ9teXmATMeB9p4BaPG1PQ1SUGsja?=
 =?us-ascii?Q?Vib4USvKH8qhBN16p9ivCZckGqCcWZZXC0tMVpp/Ww5utcvXJ0fmMzvv/FTO?=
 =?us-ascii?Q?r67Tx6To7g1ncaaAt/aSWKNQw9sg+IE877Hk8POifOUm5AFC7Ffkub4FYoF5?=
 =?us-ascii?Q?ksf9DwX2kg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473340be-5081-47b4-e1d7-08df272cbfd7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 00:15:26.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QV7zCpS4wJBxapkB8ug6kHrQmyaI2+E2qrDNBoK22g+QPftQmcG0Ck1gKCFmbKKPl8y+jClqYgegcxA5+VCag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298

On Sat, Oct 10, 2026 at 06:28:13PM +0800, Zqiang wrote:
> The commit 'dab06d6f9379 ("srcutree: Add an atomic Tree SRCU")'
> introduces some new APIs:
> 
> srcu_read_lock_atomic
> srcu_read_unlock_atomic
> synchronize_srcu_atomic
> DEFINE_SRCU_ATOMIC
> DEFINE_STATIC_SRCU_ATOMIC
> init_srcu_struct_atomic
> 
> This commit therefore update thems to whatisRCU.rst.
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Applying for 7.5.

thanks,

Joel Fernandes

> ---
>  Documentation/RCU/whatisRCU.rst | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index e6767baff2d3..75c50f2f6d79 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -1209,11 +1209,13 @@ SRCU::
>  	srcu_read_lock_nmisafe		start_poll_synchronize_srcu
>  	srcu_read_unlock_nmisafe	start_poll_synchronize_srcu_expedited
>  	srcu_read_lock_notrace		poll_state_synchronize_srcu
> -	srcu_read_unlock_notrace
> +	srcu_read_unlock_notrace	synchronize_srcu_atomic
>  	srcu_down_read
>  	srcu_up_read
>  	srcu_down_read_fast
>  	srcu_up_read_fast
> +	srcu_read_lock_atomic
> +	srcu_read_unlock_atomic
>  	guard(srcu)()
>  	scoped_guard(srcu)
>  	srcu_read_lock_held
> @@ -1229,8 +1231,11 @@ SRCU: Initialization/cleanup/ordering::
>  	DEFINE_STATIC_SRCU
>  	DEFINE_SRCU_FAST        // for srcu_read_lock_fast() and friends
>  	DEFINE_STATIC_SRCU_FAST // for srcu_read_lock_fast() and friends
> +	DEFINE_SRCU_ATOMIC
> +	DEFINE_STATIC_SRCU_ATOMIC
>  	init_srcu_struct
>  	init_srcu_struct_fast
> +	init_srcu_struct_atomic
>  	cleanup_srcu_struct
>  	smp_mb__after_srcu_read_unlock
>  
> -- 
> 2.17.1
> 
