Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF221F583D;
	Thu, 12 Jun 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749720921; cv=none; b=EW/2tnVNDNQS5pHSgazGuHdr3PLs2Bk8D1vHGfGH5hhsED4tPSxZruIAnQjMrgpn2pNhD6MXET5pAkO3DL6h3I/y382iqWnyG3SfMtxi+T6WEH0kL+73s/eM0nz8oiMky/gMbiwdZvxWl1e+1LV0A3HrEUsCYpknk6zs6pc6j+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749720921; c=relaxed/simple;
	bh=6FgB+WvGbctHgE61tfJuDhNLiJzdc+uwCPH8BFiCunc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSiaMwkgFlpmjTkKMV4Xwh1tWIl+9sGBy/K8Tw1e1MIm5nGcMxeQ2Syw8HD4PYFwPA7ilnKXPPQVT21DqJU4LsdAo9GeHXrb3/yG+NANNmDJqHEpfbJq9udyVMJGPHJxb+ChhdwHYPWKxG2rmbIXT+jE845HunMdBohoo1Lr28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFgHEJn5; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFgHEJn5"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55350d0eedeso640048e87.2;
        Thu, 12 Jun 2025 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749720916; x=1750325716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9XgOyLN+6u3eshF39lnx/D7xKZZthMQB0xJDbNgZRg=;
        b=AFgHEJn5lUKt9K0AzCuvo1Fd2ssPgwjk8b8D0yRmg63a4lupR7jJ9eEv2aaMHNcY9I
         GemvIaFKFn90zNITrCRF4+nv67fc0bm8Z2kttxk+lDptuXN/bAJoF4P28hYU/t4wwu7K
         6I+FYQKyFR8hHmYy/gzW4C0mCAYJHONK6lPn1H9B/pSa68HdRSpQMy0QKvgD2flQHPun
         K7GfF8D5eriU4Kpe+mvAxL/7jCLL3No/3KgBzbN8ioSPIYoIzt5unbA3lZAiPdyeHFlr
         aWD7ZiNLrN1LGm5WD6G4IW2eXOkgqgmjjTgfXJ/wFuiOp8P7BCMti2lhi/q8Gp8tAJAw
         s/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749720916; x=1750325716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9XgOyLN+6u3eshF39lnx/D7xKZZthMQB0xJDbNgZRg=;
        b=LPrIyeQd5ur3PkbAZG4lFF0F6tzQV7t1/aUoA01TLTuHaaa/y0xl86KkwoJJTt8NWZ
         LhZMWxPhuOCiPwbSfmGO2PX1dvImG7yAHbXYXNZBYnHQ4VsIZCBz0S7XK86u/8s4BEhs
         1hPzbcQqk8adi3OM4DrbaojvJNBFOq5VqKtSqrTuXrt5UY2EAfi9P8CeQR/6UET6sccz
         6G8yUVDNFy/3Gw5vJRczd9mS3rZGaVoseTLul7o9RGmw/xe/Xt73crI9yK8q2woylzMl
         wXcTU0DSaz4jekp6KGfw0YCZnpBCvYvW+8u9n/3XTReJxCOPw+AiKJSCUbaGJV63iS2n
         hbdw==
X-Forwarded-Encrypted: i=1; AJvYcCUx+kwgqCKY/OKFBLknv9oT8GAcLB/uftWsJNaD2jeAf2wzqOq2GBBPS7xvyi983+OVMS6x49XM3dRbDo8=@vger.kernel.org, AJvYcCWDRjOtrd3HWZS7Y5gxpgMIizCjr3SLXRZNbw3Hsk/cnEIypdRjtUha0iKHbqqYj5dd6b6Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXgcpYrP1oAhJGXmzfYxdVuWFJKrfyOyVFPjjEdj/s4rc4SyI
	Kh0h3frDO5++2lv1DKuTTmR4v/O+98VapOlTgnHDE0JXbxbOQsMoknis
X-Gm-Gg: ASbGnctLjnQWtPvEu7vmMEetHYaDvP7FAz64bzh4EKXrU2LgTtxATYRuP3ivATME1rg
	IjfX5KsFrerc8mSf1kGxCAiNlHIdqw3ATSQCkrEepHo3yxDWeXTZZdzdMlhuhQ8+vGORBnpa2wn
	zMUJQUFxn911Nu3XgdDGdOo5sVA+JG/mg0TeSqDKi8XCT7MbKH1yFqoy8fNeWKx/PHGz2Fo8elv
	BUx53iZjsmqtzNfLeKQMKcEOajfJLWJmgwrHeXwok40wBVIU8PYnVYOBdzp1cQy55Ow4AR7chHQ
	DLn5SPwJwKNM4IDCt5qpyhydRmEJ4bzCK1eFEb3T16ex3I979Lx5+5vsm6N3R4PacdtOIhI4a9O
	ymggHz5jgIag=
X-Google-Smtp-Source: AGHT+IHk9tDnmNn/N3vdm9Jt5yx4W3KvwzVpgTVmppRO7QaeWoYFfo3o/bOG1TFzmwYfFr7qISL+aA==
X-Received: by 2002:a05:6512:3041:b0:553:35e6:3949 with SMTP id 2adb3069b0e04-553a55f4082mr778067e87.34.1749720916163;
        Thu, 12 Jun 2025 02:35:16 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac13f0dbsm54594e87.85.2025.06.12.02.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 02:35:15 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 12 Jun 2025 11:35:12 +0200
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 1/2] rcu: Enable rcu_normal_wake_from_gp on small
 systems
Message-ID: <aEqfUGW-8fClJDsl@pc636>
References: <20250611175658.91361-1-urezki@gmail.com>
 <af4557b3-4352-400b-a000-0a3f2014526e@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4557b3-4352-400b-a000-0a3f2014526e@nvidia.com>

On Wed, Jun 11, 2025 at 05:48:57PM -0400, Joel Fernandes wrote:
> 
> 
> On 6/11/2025 1:56 PM, Uladzislau Rezki (Sony) wrote:
> > Automatically enable the rcu_normal_wake_from_gp parameter on
> > systems with a small number of CPUs. The activation threshold
> > is set to 16 CPUs.
> > 
> > This helps to reduce a latency of normal synchronize_rcu() API
> > by waking up GP-waiters earlier and decoupling synchronize_rcu()
> > callers from regular callback handling.
> > 
> > A benchmark running 64 parallel jobs(system with 64 CPUs) invoking
> > synchronize_rcu() demonstrates a notable latency reduction with the
> > setting enabled.
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
Thank you for review!

> Just one nit below:
> 
> > 
> > Latency distribution (microseconds):
> > 
> > <default>
> >  0      - 9999   : 1
> >  10000  - 19999  : 4
> >  20000  - 29999  : 399
> >  30000  - 39999  : 3197
> >  40000  - 49999  : 10428
> >  50000  - 59999  : 17363
> >  60000  - 69999  : 15529
> >  70000  - 79999  : 9287
> >  80000  - 89999  : 4249
> >  90000  - 99999  : 1915
> >  100000 - 109999 : 922
> >  110000 - 119999 : 390
> >  120000 - 129999 : 187
> >  ...
> > <default>
> > 
> > <rcu_normal_wake_from_gp>
> >  0      - 9999  : 1
> >  10000  - 19999 : 234
> >  20000  - 29999 : 6678
> >  30000  - 39999 : 33463
> >  40000  - 49999 : 20669
> >  50000  - 59999 : 2766
> >  60000  - 69999 : 183
> >  ...
> > <rcu_normal_wake_from_gp>
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/tree.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index e8a4b720d7d2..b88ceb35cebd 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1625,8 +1625,10 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
> >  	atomic_set_release(&sr_wn->inuse, 0);
> >  }
> >  
> > -/* Disabled by default. */
> > -static int rcu_normal_wake_from_gp;
> > +/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> > +#define WAKE_FROM_GP_CPU_THRESHOLD 16
> > +
> > +static int rcu_normal_wake_from_gp = -1;
> >  module_param(rcu_normal_wake_from_gp, int, 0644);
> >  static struct workqueue_struct *sync_wq;
> >  
> > @@ -3239,7 +3241,7 @@ static void synchronize_rcu_normal(void)
> >  
> >  	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
> >  
> > -	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
> > +	if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
> >  		wait_rcu_gp(call_rcu_hurry);
> >  		goto trace_complete_out;
> >  	}
> > @@ -4843,6 +4845,12 @@ void __init rcu_init(void)
> >  	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
> >  	WARN_ON(!sync_wq);
> >  
> > +	/* Respect if explicitly disabled via a boot parameter. */
> > +	if (rcu_normal_wake_from_gp < 0) {
> > +		if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
> > +			rcu_normal_wake_from_gp = 1;
> > +	}
> 
> nit: better to just do:
> 
> 	if (rcu_normal_wake_from_gp < 0 &&
> 	    num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
>  		rcu_normal_wake_from_gp = 1;
> 	}
> 
Two lines anyway :)

--
Uladzislau Rezki

