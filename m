Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E08173355
	for <rcu@vger.kernel.org>; Tue,  6 Aug 2024 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924570; cv=none; b=Z7XwX96fgyLMn5tOUIIK0+/vSYfngMJ4cxlqiDiA41ZzhKoDS93fKemqom9KQr7KneS1cmn7n4iZjBdIV8U6DNyHny8xJT+73AAE8B1wEAoNjDjFylFSKyk2niM9WxzWG9SmV740J2/6ovxMF8t3KqSAU7GVITtA2PH1dtQhaHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924570; c=relaxed/simple;
	bh=ZsefIYStrGDb9k8xax2Vyy8z1RQ3FSStZHl5YNa9OPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=TLav8H2nzB8VywGUqO503onu9Rxtxs9WUtNSsgTJe4aCLnsZA+i/Jl/qtMHet4U3BN7Fxflw1bijF8xq2HwXaJ39BiKImggOqJIaGPcf+2wN+Dk9YFEvFcpPN4tay3MP+ui3YbmBEkCQJDGCguXXRyJWAYmhkI1ag1dUoHIp5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhcXKv1W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhcXKv1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722924567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4SFTgS3RSxMXnR79gxMgVDPeEdFnu+n/zpjK6NCgI6U=;
	b=RhcXKv1Wgjl2ew1qFd9X+r228qxlLOTNKAFTaAkVh6Z3tkjo5bBTqhVVT7MP31BNV2IdR9
	4WScEGngeTTq4d9fnVitaMgmUcx+PR5K3oPoNcyxJCNRf3vD+E69Kx729dBTcJOCwpuwHL
	snWcAcXjozPIJvAV0SFqEw3zHO93WZ0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-JfrThn2GNNCzqja2cpGrog-1; Tue, 06 Aug 2024 02:09:24 -0400
X-MC-Unique: JfrThn2GNNCzqja2cpGrog-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso659667a12.1
        for <rcu@vger.kernel.org>; Mon, 05 Aug 2024 23:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722924563; x=1723529363;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SFTgS3RSxMXnR79gxMgVDPeEdFnu+n/zpjK6NCgI6U=;
        b=Zq5bq0XDopZQeWGWHimaWLsF3qrb/ZNGMz/s7OjLfg71ctlZwxXuIAbLYL46VJjXB2
         HoHvlCFoQdhM5IT9yhdYCunonnGXzqvmnDVFtQzL0R9w9sZ9l2DaNHrxlZmDwd2fw4oc
         /Lxy+hxqVtHfZsZn309lkNKTxm0lfI1tqwLJJo4sIeJpM1fLx5iik4z6cKiyQ+lRUKuB
         0lZT0FNE35BLALIHR8tGJ1FobOzpZLzgM900Av7Bit4oxElx8KWTn9PIQxVKstNCUuWN
         53vvYi3w1yKmPCqolfhZo4616MyzpCwRS1cs5ddWcG1dm8g33UWCDdYy/2wDr2Na0CY+
         qQTg==
X-Forwarded-Encrypted: i=1; AJvYcCXCIdz0+r3DzmA1gMOPTaiosZPqz9V4REHgFA32dXENUGIaeZjPoOMI70XkO3+LCyv3Cxn8nuI3+SHw5gi03W4iPsw8
X-Gm-Message-State: AOJu0YxJvlx+zpr1lbVRvy1Bp5mep8a5aC5QpTFrcPl8XKCuMrMUJmxo
	I0lHGMpanXd3WMtmHnOq73anlAxUum9Q0dMUSx5OPJV//FubumxXzoBpm8Z8UKMWT6/1Lm3++EE
	lk0YImVylhT6ieN/MBMlDqSPR5vh8w+NijLeReBrvuGbWSBi4Uw==
X-Received: by 2002:a05:6a21:a4c1:b0:1c4:dae8:c72f with SMTP id adf61e73a8af0-1c699559d86mr13937334637.19.1722924563213;
        Mon, 05 Aug 2024 23:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFAB4iDFaLVVFzQSknryXyAqbAibTwTchg6n6ZX0voJ3rtXiQO8ekPM1EV6qpN/RcplUFTmQ==
X-Received: by 2002:a05:6a21:a4c1:b0:1c4:dae8:c72f with SMTP id adf61e73a8af0-1c699559d86mr13937320637.19.1722924562815;
        Mon, 05 Aug 2024 23:09:22 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:431:c7ed:e5a3:54cb:9e69:eacc:b949])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec3eb7bsm6387179b3a.48.2024.08.05.23.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 23:09:22 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: neeraj.upadhyay@kernel.org
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	mingo@kernel.org,
	peterz@infradead.org,
	paulmck@kernel.org,
	imran.f.khan@oracle.com,
	riel@surriel.com,
	tglx@linutronix.de
Subject: Re: [PATCH v2 4/3] smp: print only local CPU info when sched_clock goes backward
Date: Tue,  6 Aug 2024 03:09:11 -0300
Message-ID: <ZrG-B5JKw5rboCHX@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240724170652.809939-1-neeraj.upadhyay@kernel.org>
References: <20240722133559.GA667117@neeraj.linux> <20240724170652.809939-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 24, 2024 at 10:36:52PM +0530, neeraj.upadhyay@kernel.org wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> About 40% of all csd_lock warnings observed in our fleet appear to
> be due to sched_clock() going backward in time (usually only a little
> bit), resulting in ts0 being larger than ts2.
> 
> When the local CPU is at fault, we should print out a message reflecting
> that, rather than trying to get the remote CPU's stack trace.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> ---
>  kernel/smp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index dfcde438ef63..143ae26f96a2 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -253,6 +253,14 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>  		   csd_lock_timeout_ns == 0))
>  		return false;
>

Hello Rik,
Thanks for this contribution!
Seems a really nice bug you found here :)

Your solution seems very efficient, but I noticed a few (possible) issues here:
  
> +	if (ts0 > ts2) {
> +		/* Our own sched_clock went backward; don't blame another CPU. */
> +		ts_delta = ts0 - ts2;
> +		pr_alert("sched_clock on CPU %d went backward by %llu ns\n", raw_smp_processor_id(), ts_delta);

This ns number is not necessarely correct, since a few calls to 
csd_lock_wait_toolong() may have happened before the clock going backwards.

As an example we could have, for a 15ms backwards movement
05ms: csd: [...] waiting 5000 ns for CPU#X
10ms: csd: [...] waiting 10000 ns for CPU#X
12ms: sched_clock on CPU X went backward by 3000 ns
						^ wrong
17ms: csd: [...] waiting 5000 ns for CPU#X
			  ^reset waiting.

> +		*ts1 = ts2;

Second point here, above line just resets the counter, so we start printing 
messages again, with the wrong waiting time. (see 17ms above)

> +		return false;
> +	}
> +


Suggestion A: Save the last ts2 it succeeds, and in case of 
the clock going backwards, adjust ts0 and ts1 to the new clock.
This way the waiting time does not reset, and the backwards amount is 
correct:

########
diff --git a/kernel/smp.c b/kernel/smp.c
index aaffecdad319..e8788f7e1a78 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -213,7 +213,8 @@ static int csd_lock_wait_getcpu(call_single_data_t *csd)
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
  * so waiting on other types gets much less information.
  */
-static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
+static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 *ts0, u64 *ts1, u64 *ts_save,
+                                 int *bug_id)
 {
        int cpu = -1;
        int cpux;
@@ -233,10 +234,21 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
        }
 
        ts2 = sched_clock();
+
        /* How long since we last checked for a stuck CSD lock.*/
        ts_delta = ts2 - *ts1;
-       if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
+       if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0)) {
+               *ts_save = ts2;
                return false;
+       }
+
+       if (unlikely((s64)ts_delta < 0)) {
+		/* How much clock went backwards */
+               ts_delta = *ts_save - ts2;
+               pr_alert("sched_clock on CPU %d went backward by %llu ns\n",
+                        raw_smp_processor_id(), ts_delta);
+               *ts0 -= ts_delta;
+               *ts1 -= ts_delta;
+       }
+	*ts_save = ts2;
 
        firsttime = !*bug_id;
        if (firsttime)
@@ -248,7 +260,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
                cpux = cpu;
        cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
        /* How long since this CSD lock was stuck. */
-       ts_delta = ts2 - ts0;
+       ts_delta = ts2 - *ts0;
        pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
                 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts_delta,
                 cpu, csd->func, csd->info);
@@ -291,11 +303,11 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 static void __csd_lock_wait(call_single_data_t *csd)
 {
        int bug_id = 0;
-       u64 ts0, ts1;
+       u64 ts0, ts1, ts_s = 0;
 
        ts1 = ts0 = sched_clock();
        for (;;) {
-               if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
+               if (csd_lock_wait_toolong(csd, &ts0, &ts1, &ts_s, &bug_id))
                        break;
                cpu_relax();
        }
##########

Suggestion B: Compare to ts_save to ts2 before calculating ts_delta.
Pros: 	Much better detection of clock goin backwards
Cons: 	Overhead for the fastpath
	More detections -> more messages, which is not necessarily good.

##########
+++ b/kernel/smp.c
@@ -234,6 +234,15 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 *ts0, u64 *ts1, u
        }
 
        ts2 = sched_clock();
+       if (unlikely(*ts_save > ts2)){
+               /* How much clock went backwards */
+               ts_delta = *ts_save - ts2;
+               pr_alert("sched_clock on CPU %d went backward by %llu ns\n",
+                       raw_smp_processor_id(), ts_delta);
+               *ts0 -= ts_delta;
+               *ts1 -= ts_delta;
+       }
+       *ts_save = ts2;
 
        /* How long since we last checked for a stuck CSD lock.*/
        ts_delta = ts2 - *ts1;
##########


What do you think?

Thanks!
Leo

