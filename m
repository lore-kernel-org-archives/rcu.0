Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39E1A2545;
	Thu,  3 Jul 2025 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556934; cv=none; b=To+AxnU3XckSfgCCPEguJZbP4X7RCmso0bWjv50yOJmcVk3G7kiaDH1ZxhSa2MfqVoxKvLD07Xz1EDKHdpIS0wxuC6EupAGSTMd5WHyWo5acVLbCEbkO4z6MvwjCFIvXcWUCrdAcj18VOpDzQi9wAqCmCRIuHGh6chP7kfIrAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556934; c=relaxed/simple;
	bh=UtCa3jB4C4oSboU0agdlHowTc/IyYRcfGLghBrAu76A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xor6l3PpsfSiJkqvnPhUjcqV8/YMNIJbDJOjxL21VKAdFH7lzBzPNjyJJTYUnwxyl84aD6Aw9tEeKCCayLHThaTqF3UbefUCF6PrOw/jz5Fvv52tFZTqvLeAFHqAGG9GP7RHbErO+js5I/iA4Dg6kZ2jeh/nU7mz2n5nc82Pbh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DH4mTVxE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH4mTVxE"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55502821bd2so43420e87.2;
        Thu, 03 Jul 2025 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751556927; x=1752161727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=75uNOQCVeQVcxppeehQYWLee6QMQRVMuSxhhZo8FTjE=;
        b=DH4mTVxE3J9aRpDeyPhfIsDr2fDVE4WAzWPvfi41j0pZCqHaH/+Nu0oLmvlIyp7txu
         6XKjC3j/xmXQs8n4wLCg++BJaqPr9g29oyCGa2eKgnborb5yZRTEmCNfgowyQdwsIBIb
         sekZEbuPtYudxOSJxuTknPDAvd51EwaSaudOepGju49fyCFi7rcVBo3a2o91smp2mGj5
         1TmSAerEHwWO0F2uRbTvE7vsa8fNcceT4jbxFHUeBo3uy8evHlR3CfnPvNme5vVs9DnA
         iiYtFOD84tM/VMi4HFeI9UU4PqzGINtazIE7m5/MFHM6U29lxS3/dMXOblV5CDrhQ4HI
         /57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751556927; x=1752161727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75uNOQCVeQVcxppeehQYWLee6QMQRVMuSxhhZo8FTjE=;
        b=UGvEFIcRgfzS6GaA8NrkOgQ3+cFEMEnkNumMwq9k+penkUD/1dpAwwnS1AD5cUeUOh
         BSSIxTga7Nx6SNwIiL5toQKClaG1dIpxwKf5WVbyAGtv/ayD/odol8bbIHCrRY4NW2p8
         PL6L5R4ch0T9MnCWX0AiPQoxfB8iQQBoIOOT3n8InxfQN0LNd9jkxmcI+56+adzY922T
         wspvdtxR5O2r1pEmaO7aWixn4pYbULZRGNByByekFsWR5dZ2meIixEufBnnQzYR0CemL
         nlh/cwWY5TUceLqMKTmgDZgkTTpwhJ8BGZIlAD00koodmpx3jZJ3/O5WViaBz1Q+asgJ
         opww==
X-Forwarded-Encrypted: i=1; AJvYcCW1iAo/OguT6HAH/vtTSUUjE1ZrVfSRy5s0qG8OrWkN7dZgOTJnkojDRrVxA7fFRQOLu7DA@vger.kernel.org, AJvYcCWnoNzWFbsvSll3+N3Fo2AE2bSVXRJR99DcHRBtM4U/Dc3/ksBYaM2LDzv3mUH0IioM1YuU2Ut5WWuCNAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxd/mRgz2y05rpBefP2GV429Y2qSf2ZhUThiqOk0LXxSYH0JtQ
	8xYCyJZaURPlvvc+H+DhAMnETm3AwVdRxsMQcFRDaoU5k9NLD4pG3CEV
X-Gm-Gg: ASbGnctzO5ocr3XRWu4Q6+VzCDXd4Ow03SxD7L170E28maayyNCN+ZB0iQoCpM1jD4u
	mR2bmGUh5ATDGkHRRXtvim8CygGxwcpv/W1h23rbSsgSThi1bFB43pI0+BAhWHAPjkfbrTI6is8
	aZu6uilmva8p1hXKH78ohzHrVQUk2nPWCQtZNZuk2elFklY91Lp61mvvHyXKq5jcFzRwTZJ/Mvo
	YXRXa9TMK7YUdhAewij41JylUMvPdYZSQ9hIxirMzsp4/UaBBbXIqcb3FYdovrCKd1bZPhc5UDb
	KN/NnFTHDSqf50YV5g0w8lQffXlPFjflnQWRc/uHwZ/OXjERFdCdzXetN3TWrjuJsjiNudNFP/E
	Qy8pxDTDLSsk=
X-Google-Smtp-Source: AGHT+IG6nHD8yFt/hQHs4Z3vKYeZAtUQPwlXLSYtpuy0z+JPsoIyqSB9z3kkZ0DqpD9Q8yCxLWqJ3w==
X-Received: by 2002:a05:6512:4025:b0:553:297b:3d4e with SMTP id 2adb3069b0e04-5562efc934fmr1483048e87.52.1751556926979;
        Thu, 03 Jul 2025 08:35:26 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384a7eeasm6228e87.143.2025.07.03.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:35:26 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 3 Jul 2025 17:35:23 +0200
To: Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v3 1/2] rcu: Enable rcu_normal_wake_from_gp on small
 systems
Message-ID: <aGajO8rOu_GOnjrS@pc636>
References: <20250702145938.66459-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702145938.66459-1-urezki@gmail.com>

On Wed, Jul 02, 2025 at 04:59:36PM +0200, Uladzislau Rezki (Sony) wrote:
> Automatically enable the rcu_normal_wake_from_gp parameter on
> systems with a small number of CPUs. The activation threshold
> is set to 16 CPUs.
> 
> This helps to reduce a latency of normal synchronize_rcu() API
> by waking up GP-waiters earlier and decoupling synchronize_rcu()
> callers from regular callback handling.
> 
> A benchmark running 64 parallel jobs(system with 64 CPUs) invoking
> synchronize_rcu() demonstrates a notable latency reduction with the
> setting enabled.
> 
> Latency distribution (microseconds):
> 
> <default>
>  0      - 9999   : 1
>  10000  - 19999  : 4
>  20000  - 29999  : 399
>  30000  - 39999  : 3197
>  40000  - 49999  : 10428
>  50000  - 59999  : 17363
>  60000  - 69999  : 15529
>  70000  - 79999  : 9287
>  80000  - 89999  : 4249
>  90000  - 99999  : 1915
>  100000 - 109999 : 922
>  110000 - 119999 : 390
>  120000 - 129999 : 187
>  ...
> <default>
> 
> <rcu_normal_wake_from_gp>
>  0      - 9999  : 1
>  10000  - 19999 : 234
>  20000  - 29999 : 6678
>  30000  - 39999 : 33463
>  40000  - 49999 : 20669
>  50000  - 59999 : 2766
>  60000  - 69999 : 183
>  ...
> <rcu_normal_wake_from_gp>
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e8a4b720d7d2..b88ceb35cebd 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1625,8 +1625,10 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
>  	atomic_set_release(&sr_wn->inuse, 0);
>  }
>  
> -/* Disabled by default. */
> -static int rcu_normal_wake_from_gp;
> +/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> +#define WAKE_FROM_GP_CPU_THRESHOLD 16
> +
> +static int rcu_normal_wake_from_gp = -1;
>  module_param(rcu_normal_wake_from_gp, int, 0644);
>  static struct workqueue_struct *sync_wq;
>  
> @@ -3239,7 +3241,7 @@ static void synchronize_rcu_normal(void)
>  
>  	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
>  
> -	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
> +	if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
>  		wait_rcu_gp(call_rcu_hurry);
>  		goto trace_complete_out;
>  	}
> @@ -4843,6 +4845,12 @@ void __init rcu_init(void)
>  	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
>  	WARN_ON(!sync_wq);
>  
> +	/* Respect if explicitly disabled via a boot parameter. */
> +	if (rcu_normal_wake_from_gp < 0) {
> +		if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
> +			rcu_normal_wake_from_gp = 1;
> +	}
> +
>  	/* Fill in default value for rcutree.qovld boot parameter. */
>  	/* -After- the rcu_node ->lock fields are initialized! */
>  	if (qovld < 0)
> -- 
> 2.39.5
> 
Neeraj, are you planning to take this for next merge window?

--
Uladzislau Rezlo
