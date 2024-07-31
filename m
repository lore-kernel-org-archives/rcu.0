Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120316D33D
	for <rcu@vger.kernel.org>; Wed, 31 Jul 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463304; cv=none; b=b/nPH2w9YZqqj4ZGwlJH3cdxaYjBR7iLYNas12zq9+PCd/WZCi+AW9O/p/tIDNlFpKa55fZqI98NuUgJ9TEkBBat4oeEXE/hW3VnhhaK4Zr2gTogpslMvqn8hznApUKq4SRvo5KTFdrhQ5M3hflpM74bdz2u6H2bleTaqLrOeA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463304; c=relaxed/simple;
	bh=zBm2f+SS38Gn4v+LakfBmHXjnr6PaCiZjBFBfwoYREw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=aZjfJ9pxwTC3/DvwisJ3KHHQknsKlMr2X+xqbQy9gpneNy2gf628StVkJRC2rqRpZxL9If/DMi+bwqk4mV16pvI9j0is04ol8ItuVYQ+FrSO7AhAcT9WW6/ifLQ8ajk77O/o8UcPuNPbat47BKvcq5h2IRRWseaL0wWYAprNpco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iv4Vrwwz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iv4Vrwwz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722463300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZ9SG54DFMY9Tr+tAWopvPhBT8szwOL1za2ZdMexQWQ=;
	b=Iv4VrwwzAlOisXdTX8ljaxYo0MbiONSrR9beMtiasnw4XzXeug2/WHQxV88iw5rtem5olR
	w8oH4RBL3VdSXRRlg8VcCAsNwC8P55Y7ENfn3n3KqMjWKCjzflYCJ0CA/EtawSkReHddbj
	ukw2p+GfT0r+9UGi9M/nROVSVD2ivjg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-i6PlyDv_OFyNHQmhrqbVNA-1; Wed, 31 Jul 2024 18:01:32 -0400
X-MC-Unique: i6PlyDv_OFyNHQmhrqbVNA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f87561de0so937049139f.1
        for <rcu@vger.kernel.org>; Wed, 31 Jul 2024 15:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722463292; x=1723068092;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ9SG54DFMY9Tr+tAWopvPhBT8szwOL1za2ZdMexQWQ=;
        b=kAF3OV9CdUmXGaaB7QQUeBmNj9QOmQCvgkdJ5e/rUx6qId6507oAsowquXIQVsCa3x
         pWTFCm4XFe/2bpgrEd4IUM/Z55Rof4N1xULwNlZp5IMGi8NCUzk9yAW2c62FrViXw0lC
         OuPBog3j/emKkqAaDW1Gk47wLVzM4Ir22CF1Kvu82/k5aGH3zR5VSIsB+NxaQhCqhsQj
         fuzNfNvJzpe70/+kFWKgWDRZFq8r7N6ELBGpKKczjg0Je3bdaT5o9XPlXKRxIq+P7RzJ
         EGnc7p+o/M44SZzDQg2Fyh2hAjRHatZ0x8fxN7oD8mbPqgJpPoeRlwVIaOhoX1pMYkKG
         C0UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKLAuo3WopWQtB3TpdTczid3cjP4hspSu8QBel5r+z0TVCtgIECHGMz4h0sCYQeiJSaUWXbykvDzZGkS/rJnSbTRzr
X-Gm-Message-State: AOJu0YzzIgugtQIzJ6hCrvh1ajP3BByppQw848ONbpz/z5SBZ4r/2xAe
	PnEMMum4T2WFtdNqIb7r4wmWhUB7hLvkvTkARz6Z691fin8Lenw9GR2Anlb6UxGEPoTCbCHZJXF
	8RzpkNCcfbnXheGVDi9LdNdD2YklBrHnYQECCYKZ0WvOmLWowYw==
X-Received: by 2002:a05:6602:3fce:b0:81f:9826:19ff with SMTP id ca18e2360f4ac-81fcc10762amr72765139f.9.1722463292085;
        Wed, 31 Jul 2024 15:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMzgE5kLoDFOdYOYdfEb9PV9w7LV6j92I0/pC3+GswmQQOWJ2wi+iHtqU6Et8UzM/GyaGfeg==
X-Received: by 2002:a05:6602:3fce:b0:81f:9826:19ff with SMTP id ca18e2360f4ac-81fcc10762amr72757939f.9.1722463291058;
        Wed, 31 Jul 2024 15:01:31 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a803:da7:cfdf:ab65:d193:5573])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fac19c5sm79214346d6.112.2024.07.31.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:01:30 -0700 (PDT)
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
Subject: Re: [PATCH v2 3/3] locking/csd-lock: Use backoff for repeated reports of same incident
Date: Wed, 31 Jul 2024 19:01:23 -0300
Message-ID: <Zqq0M92zcR1kcuKz@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240722133735.667161-3-neeraj.upadhyay@kernel.org>
References: <20240722133559.GA667117@neeraj.linux> <20240722133735.667161-3-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 22, 2024 at 07:07:35PM +0530, neeraj.upadhyay@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> Currently, the CSD-lock diagnostics in CONFIG_CSD_LOCK_WAIT_DEBUG=y
> kernels are emitted at five-second intervals.  Although this has proven
> to be a good time interval for the first diagnostic, if the target CPU
> keeps interrupts disabled for way longer than five seconds, the ratio
> of useful new information to pointless repetition increases considerably.
> 
> Therefore, back off the time period for repeated reports of the same
> incident, increasing linearly with the number of reports and logarithmicly
> with the number of online CPUs.
> 
> [ paulmck: Apply Dan Carpenter feedback. ]
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Imran Khan <imran.f.khan@oracle.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Leonardo Bras <leobras@redhat.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> ---
>  kernel/smp.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 9385cc05de53..dfcde438ef63 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -225,7 +225,7 @@ bool csd_lock_is_stuck(void)
>   * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
>   * so waiting on other types gets much less information.
>   */
> -static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
> +static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id, unsigned long *nmessages)
>  {
>  	int cpu = -1;
>  	int cpux;
> @@ -248,7 +248,9 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>  	ts2 = sched_clock();
>  	/* How long since we last checked for a stuck CSD lock.*/
>  	ts_delta = ts2 - *ts1;
> -	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
> +	if (likely(ts_delta <= csd_lock_timeout_ns * (*nmessages + 1) *
> +			       (!*nmessages ? 1 : (ilog2(num_online_cpus()) / 2 + 1)) ||
> +		   csd_lock_timeout_ns == 0))

I think this is a nice change.

OTOH above condition is quite hard to read IMHO.

IIUC you want, for csd_lock_timeout_ns 5s, and num_online_cpus = 64
1st message: after 5s
2nd message: after 5 * 2 * (6 / 2 + 1) = 10 * 4 = 40s
3rd message: after 5 * 3 * 4 = 60s
...
Is that correct?


I think this could be achieved with:

	/* How long since we last checked for a stuck CSD lock.*/
	ts_delta = ts2 - *ts1;
+	if (*nmessages)
+		csd_lock_timeout_ns *= (*nmessages + 1) * (ilog2(num_online_cpus()) / 2 + 1)
	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
		return false;

Does that look better?

Thanks!
Leo

>  
>  	firsttime = !*bug_id;
> @@ -265,6 +267,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
>  		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), (s64)ts_delta,
>  		 cpu, csd->func, csd->info);
> +	(*nmessages)++;
>  	if (firsttime)
>  		atomic_inc(&n_csd_lock_stuck);
>  	/*
> @@ -305,12 +308,13 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>   */
>  static void __csd_lock_wait(call_single_data_t *csd)
>  {
> +	unsigned long nmessages = 0;
>  	int bug_id = 0;
>  	u64 ts0, ts1;
>  
>  	ts1 = ts0 = sched_clock();
>  	for (;;) {
> -		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
> +		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id, &nmessages))
>  			break;
>  		cpu_relax();
>  	}
> -- 
> 2.40.1
> 

