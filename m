Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792714840;
	b=QmUlqseway6f9fVbjzPprvrZY1Vst57MsgJa0UyPJiPr4KJWFuy6EefVQkm/lXiPUO3J
	 gV13UNNcVNXrg+PwXM3YBgnkTozpMBKcv8xxL/OUoEBaCaQ8/bG0OeRAu+3vHcseTn4Be
	 Ya5gDeYX2cNnS301H5X5VSGaVhIoXstVk2jrY2kTEj8AKqcOBvA/5M56OdCuRO8j+TGX0
	 ZzotW7Zk75C0kj7GqFFQnu2Kede0CugL2Ob0gVIlh28Tdpc/VrAv4UYaH7qMofnYGrBbu
	 go39MDDvLN2khdw3PXWSq9NpAGMLiUOrPuMHsOQUCCcCvgzqFGmi7Q5X+NaTARgliDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714840;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=dn28aPdH9sSEmY+dSpbuXzww0WcE1SD8KK55GOwzkJw=;
	b=uFuZQrPN+ctZfX8/+yPhQVpkm4lOwu41q+mt/9oQfa70MqUrEBSVAG6CvGLNdvcx1Llc
	 N53uKnTeseJDkON5zDHy1WjRm+0TxoxtsVdxhrN82fNaY8YmUunQRHq0UGeM4K/QClJO0
	 3dWHg+vxaC9UQf57VYjIaFjx/1ysbKXKCeN8o8tXMrlxsFL6PXo8Iw2AkfXK3Kx0IQEsy
	 SvvYiovV2C3pDkFPv7UIpODWvIxF7pA8FSm9jZul3npa0ZfRs7H3I1ewY5JDhiDGzLoos
	 eaMGj1LxMdBtUwkNgvxnaJO8ARuvN4w0kEVKGkiNJ3g9pD1WsVVHbvIRDe/c122ltpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=J0rwCPda;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.17
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F9606A31A;
	Fri, 23 Oct 2026 00:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F3F9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=J0rwCPda
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoFUXj4kAHqNHol5WkoftkXIHdmtmN7v1v1QN46EcrKzSbktmOIyJJ4J36rIHrIC0lsfSChcN5GLORle+v0OarnzYVvIJxFQukUmDFz4GYmHNFT0OSvsauSvcv+HbHoTF9YxIl3fIYFN+hmSgVhWMKdfQgz1c1MdlAKF3qA9dY3+2ttK1bkswvZfGbl+wKT/Gtpx8Zb1z+UWLnfwqrtB77Lp1192G8daULqH4HAoEeN3OioxTPmPLGcTKKjT/VDBTkRIav2bbpX+G6jGNo/AO7bGkJoSv6ITlOweiqBPR2PiDnjk/RzAvxrJkWE4tNe9TZcXHFl8zRfbefD4fhDZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn28aPdH9sSEmY+dSpbuXzww0WcE1SD8KK55GOwzkJw=;
 b=LngsL1MX87eLyHjh0o2bxeCV/il+TgtHW99gSSu9lfSNabGqaAk3Wn+zNGs55IYLXrB9qzmeGvTXFWA7LUAW/7Z0rNAeokqMW+pWRS2tCDWUlXRFZSyt+TZvkZ6hGp3e1ujEaDqKUAq8WJkOj3UEiIzIdwQ6FAfw54tL45PkQHBh4Z/zAHYpsPHfsOhY4MZV3PfJf9NK3fma7ktvmMPi1povNV+0lACzqaFba1PNsvjmnrFoC5zKB1L0KmjwAjtoMutNUiyhYPQaQYwQU+/gCv6Ps/E2p6XcQq5EkBTIsNKt2wuGbStMxu6hdZoXZrlwfEJLNM0PHLQlUGTfye/47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn28aPdH9sSEmY+dSpbuXzww0WcE1SD8KK55GOwzkJw=;
 b=J0rwCPdaoU7fqn6VC2WAv7sG2vmDmchbeYE7XGidlAnZVhVC2fSD5MPC2zzTyFgU0BLQ3awDtxznUCQKyi6hoOvB1EAjH1GWNl6DoHGWmvGyD7bDKMFFGDl8/UsRwSq6WmMPWCJ/aZQdkB9YAObpMjABgWUh6eXowmexn4iZslQVK3gS+oqsWDafPgu8cXtDRiOkwUOvLxgRlDe2a/yp1VtIPGC/lsbyjp+2p6NeU0EdVtRL+5BNykzTygC2xjZ+X73n+H44hrwi10ngGITe0o8rOGGyygWsAwG6Yw/rcfQLDsCThlijXRXPzdsfKEqdQGq3X6/cCesVtZcep3WdBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 00:19:58 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 00:19:57 +0000
Date: Thu, 22 Oct 2026 20:19:55 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 07/21] srcutree: Disable preemption across
 synchronize_srcu_atomic()
Message-ID: <20261023001955.GA4134349@joelbox>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
 <20261007205924.1983367-7-paulmck@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007205924.1983367-7-paulmck@kernel.org>
X-ClientProxiedBy: BN9PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:408:f8::26) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|MW6PR12MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 38295bab-79db-4254-1a28-08df309b5eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|4143699003|10067099003|261009223027099003|261022105027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	shiHBX3U3OYF91wvT0O6EaqDd3wbrpd+PXc50Ov79BPvkLKEQUdq/s1mqxgJTqRw16v1KUMXghonpBam+FtnYh9akC4N/rJFMPd82rnDd5KZD6+xo+ofOOi1aRo+a8Qveey1/UUJJ+z2AOIYSYcs2/GmH3s0UhOgN4gs/tZTyFOtYyxnjU3eyeUVr5IJsohDUOPSdWCECUIT4d54ZTtL4qSSkdj1c4ZM79OWyHn6CZdniZUwOtkuIDFdNnSG1PBPBdR2d5f6pTCe1Bde0y9RKj/8P6YH5uvJZI0wqkFPM4UrPdZUNF8SzAw3vyska6JApDRmKsgsPznaMHEFHnHuXhmDfrZO2e+9hhgQIviLavF/u3AGE2mhm01huvNW8LptJbVQlln9IrjeW9ErwKMnLwhtLSPuiOxI6SbphcQxnZL6E+x9EfxvWpVmzqls7nQ2uZiFNtDpWjn8dL6SVmejb9iVhn9eYCvHqVnejFO/2rq7DsvYQRs/eAingKGcPuOZsgUi+fxDagQMofx9+/viNQVuUTo9HennB6RbPInE5mRJMLkNi1NRKNQ5XLCIIuYdGoQLX1qu4qOK2ZtdtebPubYVJhXv6BgRxr8uaTsvDBCPfKka1NwUMBrK0m9ZhhoDJy2awSYw7Ff0TmhlCvSgGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(261009223027099003)(261022105027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oag9mOwclW+p1zrJ6NDGnH7wgT/mb2IE6TO4MTIh4Yco1GEbW1meJshfXcTz?=
 =?us-ascii?Q?qE+apOTi+ZjIRYXbOyWf6Zqhqcwau6saYjsQvShwlTtsQPpvQQUx/yvKLcbX?=
 =?us-ascii?Q?w2/1zvKxCH9Pu2qbJUI11boFcJQtTpi9e2T1QeUKgSJa3UJG4BxBnbrUIOMd?=
 =?us-ascii?Q?Z5Vz+fJ1EShc5v9PuZOUbCJsarCyzYD3dpDpR/YpNZBjLDphTfa/aZ3Hi0RB?=
 =?us-ascii?Q?PbWle4I3KIIRhNubr6KWQYwhPsYLAA+pJ0s230E2k5PK0JmeU2XHHWpiPraW?=
 =?us-ascii?Q?bqGOOdwYcSfg5eUeQj71UTOBWSy5bShZ8+Gh7p4OTJNLhRgDpHKQE/Pf+Ul1?=
 =?us-ascii?Q?YPutBF0/M9hl6JEP9jXH/Ixw2gM4xh9oZz61R4a2Az4oeeoCosCksSL5VSht?=
 =?us-ascii?Q?YjG8YKBJq5BkIGyiyVaf0SSvccHTmSAPsYmpLk4OwTZb7/MIQKpg/eX7wBiZ?=
 =?us-ascii?Q?V/7SuEwAOUyjzz/XVlaBZQ9URtQW14uvSR825w+PROPCYNgZgYG/KV0ApNSB?=
 =?us-ascii?Q?vU+NCU6+1gOQ2sY1Wv5d9JYy6x/znDBx3PqZ0sYpmvAUPoyx2+GSsn7GlH8E?=
 =?us-ascii?Q?WCEfpVWjU8culx56fi1UvP8Qfviku9o5eyLhLU0GPbT/1+L1QhbXNOC2foLw?=
 =?us-ascii?Q?LgZo2Qk71TE7ykGRdzwvXigFULqVdSjk9oN6CfM9MsaTGyi1ZCbqi3F0mT8/?=
 =?us-ascii?Q?ESsPXbfcExiZVV7zQmrqOwNXXpGZZ33DxllsweU4K8TSVH4kKywpwW+IO/tO?=
 =?us-ascii?Q?j2J9tfaSg7EM6GAeZQCM71gVhvOWyi7uL79TcF3rRS0pmuaAQNWYFHxv0o69?=
 =?us-ascii?Q?TQsYu6kv5mc83oadk+0iNT9YFmR0FuxLQEsxykcwXcmb6fUnlMvW7UrYekxz?=
 =?us-ascii?Q?z1AinG2IBoxpswA2+V19GmqVVW7iRFqrO/puPAwyTMbP/a8z/uCy6qHDaSJV?=
 =?us-ascii?Q?VyIqzUQMZ1Y+r2/wMHlm/TkqbDQJEzQthWYiK+d4QWW/a2y2TMRt5SDwNLQJ?=
 =?us-ascii?Q?pOcgVmtzGTNw56IgLqW+S1b0p3B6Hw2d5IMHunZAAD1D38MQO/fcksB8P/KQ?=
 =?us-ascii?Q?VIEZSYMDJqGbUL7oNRONLHjerdDWZOl6XgpjyM3DjZczUUU/Q9XURWozSh4/?=
 =?us-ascii?Q?6DE0T4KfPeTItgegmXCOeYX3cr1oXnX9SLeyzs5oLMyfatrx48qCrJ0nSQIr?=
 =?us-ascii?Q?jdvgpxkEiUbdakfgVvQL142ZbniEoeXTBSP28V0zsj6VQYBFb1ukin1nXO0e?=
 =?us-ascii?Q?dV6Cu9VE+3YR81bavBEpEVmCur5TUpixMWVfMJhiaeu4+uInwUfQSQk5dGqM?=
 =?us-ascii?Q?aG5+NLXgfXE4Izrdz7z23RgNl3dQqkVtnC1bZCIIjDHi3JV52ZkFTEpwNlAB?=
 =?us-ascii?Q?ziGCGjMRCGMtnCZ8EdWgyISr+78rrq71ZL8wdp/lM3iQQsuATB4ds6KzWMPY?=
 =?us-ascii?Q?LfNDWKtXTss3AjJzmG9X2H6UFKQqIhNzOy7A2fzY3BOK4M5yPFyCLxdzue7o?=
 =?us-ascii?Q?Es4NUeBh280tNixKRAvqkxfFwjCXwu4QGsxNOFDqtbBtzHCuJ6TuijRgALU2?=
 =?us-ascii?Q?dMtYb5tgfizprXZ5PtP9OkS8q5ZNDFaXyBQFAkCQNwwefFmIrageRpwIXkPw?=
 =?us-ascii?Q?ywy2AxHnjWia+Mo6llDAsw/dsS6KSS1pXntimQBgojLTNTplG8xpMFM+eiLZ?=
 =?us-ascii?Q?ECG+6lx4g+er2NCwfYtY3bAUS26s1STSj5ssXiTm5yK9f+Bn9Yo6d7XGAWNP?=
 =?us-ascii?Q?5GtpTX4vwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38295bab-79db-4254-1a28-08df309b5eba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 00:19:57.8467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsvsyqOaZVQIoHEaxZrcG1PcxL2/LLUlXg5t0RaiJHLqrQ1TVzXP8+QfJx44cI7rcBNTlRZ55p7p+bh8eeVFiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086

Hi Paul,

On Wed, Oct 07, 2026 at 01:59:10PM -0700, Paul E. McKenney wrote:
> Because synchronize_srcu_atomic() cannot sleep, if a pair of them run
> concurrently pinned to the same CPU, it is possible that one will spin
> uselessly waiting for the other while at the same time preventing that
> other from running.  This commit therefore disables preemption to prevent
> this failure mode.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/srcutree.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 7ff45e992c011..672fb41345c91 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -2123,11 +2123,14 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
>  
>  	// Perhaps others will do our work for us.
>  	srcu_state = get_state_synchronize_srcu(ssp);
> +	preempt_disable();

Should this be upgraded to local_irq_disable()?


>  	while (atomic_read(&sup->srcu_atomic_gp_flag) ||
>  	       atomic_xchg(&sup->srcu_atomic_gp_flag, 1)) {
> +		preempt_enable();
>  		if (poll_state_synchronize_srcu(ssp, srcu_state))
>  			return;

Otherwise, it is possible that an interrupt handler comes in here while the
srcu_atomic_gp_flag is already acquired and then spins forever?

If we disabled IRQs as well, along with preempt, that might add other
problems, though, such as a reader calling smp_call_function waiting for the
IPI handler to run on this CPU which is spinning with interrupts disabled.

thanks,

Joel Fernandes





>  		cpu_relax();
> +		preempt_disable();
>  	}
>  
>  	// One last check for others doing our work for us under the lock.
> @@ -2135,6 +2138,7 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
>  	if (poll_state_synchronize_srcu(ssp, srcu_state)) {
>  		raw_spin_unlock_irq_rcu_node(sup);
>  		atomic_set(&sup->srcu_atomic_gp_flag, 0);
> +		preempt_enable();
>  		return;
>  	}
>  
> @@ -2152,6 +2156,7 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
>  	}
>  	ASSERT_EXCLUSIVE_WRITER(sup->srcu_atomic_gp_flag);
>  	atomic_set_release(&sup->srcu_atomic_gp_flag, 0);
> +	preempt_enable();
>  	non_block_end();
>  }
>  EXPORT_SYMBOL_GPL(synchronize_srcu_atomic);
> -- 
> 2.40.1
> 
