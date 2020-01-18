Return-Path: <SRS0=UQpt=3H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5EEC33CB1
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 12:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C1A2072E
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 12:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqq9MNpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgARMBA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Jan 2020 07:01:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45658 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgARMBA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 18 Jan 2020 07:01:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so29150474ljc.12;
        Sat, 18 Jan 2020 04:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VZj/+gTBYwih9w8p4CHvebReTfIMgw1NYGMhYLwgkjY=;
        b=Pqq9MNpc0mluCwwOKD2lqGkoDdsfpynn/xg1au7LAGAye67z/NsqeDuVDGrcgalaI+
         1OJYIYI/gtNkMK0cXvjAbF0QIEZgRsp6QxGRh6ZCTYAEvW2TFkFump0n2TCHIBrXfr/k
         EMfOxTDDaI0UZJHqQ1S+ONMQzww2ZXeLjJ0tnG5a9e2X7DJohIM1DcaF9jM6hgpBfwIl
         ROzG7rWE9ooOijOZ6yY0FnRajbAP0mt90NVoNkoD0LlBj2Gj8aA/AF2fYNTziMnVcrHH
         Li6pdXZr8DtBv4szeYINZobelo9rvUS7ac/qCHLI+VcilZnOh3LtdxxX2EmqJExrgQVz
         UrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VZj/+gTBYwih9w8p4CHvebReTfIMgw1NYGMhYLwgkjY=;
        b=LlAVNZ/+wSNPesJEakXNRg9RImGfYrjE3ffpt4aiJFkb+SbyXc6PQLzdxIVONiqs2l
         cncj7okWAu7nLfxIokkipRlKmNpsonOsv8Rl711Va+kJLjPJUXYk1gECRgcCNZ0oPtEw
         ZGni8xZOdPUJeRU8yV4QNiSN7yhZO8KvORMXEVJfKP1wtfV8Tt0QQ0yHm6NgZYQ7cqZR
         1unlB+EBmmwK71UQqUBAB6ZyQ0FRpo7728NG+ipnHdJVLzpJ6+PcUat2esFqPotdSpgl
         53O6oC7BrGRVAPiPZ3ghs706bHFcQ7hV8SP0z+fjsGKF4zDkEmUD30iY5lAsOpYL89IJ
         9RnQ==
X-Gm-Message-State: APjAAAU6uG3QGx7pSksSQ8YaE7JvhKVE0wz3LIXNjJt8kWF2qfgxnmid
        db5ptKylS4tzrHuVR1nQQurWSITMZ3E6bw==
X-Google-Smtp-Source: APXvYqwosEdFwVQMSXRQKZbO5XfS6GRjYRqsw50BWyzXGZLANGfEw3N0Lwq9GnaTiEvN3WzmbZvk+g==
X-Received: by 2002:a2e:8053:: with SMTP id p19mr7936544ljg.263.1579348857779;
        Sat, 18 Jan 2020 04:00:57 -0800 (PST)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id m8sm13500659lfp.4.2020.01.18.04.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 04:00:57 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 18 Jan 2020 13:00:49 +0100
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, urezki@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] rcuperf: Add support to vary the slab object sizes
Message-ID: <20200118120049.GA10134@pc636>
References: <20200115224225.246061-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115224225.246061-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Joel.

> This patch varies the allocated size of objects to be more realistic in
> comparison to production workloads.
> 
> Cc: urezki@gmail.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
>  kernel/rcu/rcuperf.c | 48 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index da94b89cd531..1fd0cc72022e 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -87,6 +87,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
>  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
>  torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
> +torture_param(bool, kfree_vary_obj_size, 0, "Vary the kfree_rcu object size");
>  
>  static char *perf_type = "rcu";
>  module_param(perf_type, charp, 0444);
> @@ -599,17 +600,29 @@ static int kfree_nrealthreads;
>  static atomic_t n_kfree_perf_thread_started;
>  static atomic_t n_kfree_perf_thread_ended;
>  
> -struct kfree_obj {
> -	char kfree_obj[8];
> -	struct rcu_head rh;
> -};
> +/*
> + * Define a kfree_obj with size as the @size parameter + the size of rcu_head
> + * (rcu_head is 16 bytes on 64-bit arch).
> + */
> +#define DEFINE_KFREE_OBJ(size)	\
> +struct kfree_obj_ ## size {	\
> +	char kfree_obj[size];	\
> +	struct rcu_head rh;	\
> +}
> +
> +/* This should goto the right sized slabs on both 32-bit and 64-bit arch */
> +DEFINE_KFREE_OBJ(16); // goes on kmalloc-32 slab
> +DEFINE_KFREE_OBJ(32); // goes on kmalloc-64 slab
> +DEFINE_KFREE_OBJ(64); // goes on kmalloc-96 slab
> +DEFINE_KFREE_OBJ(96); // goes on kmalloc-128 slab
>  
>  static int
>  kfree_perf_thread(void *arg)
>  {
>  	int i, loop = 0;
>  	long me = (long)arg;
> -	struct kfree_obj *alloc_ptr;
> +	void *alloc_ptr;
> +
>  	u64 start_time, end_time;
>  
>  	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> @@ -627,11 +640,32 @@ kfree_perf_thread(void *arg)
>  
>  	do {
>  		for (i = 0; i < kfree_alloc_num; i++) {
> -			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> +			int kfree_type = i % 4;
> +
> +			// Allocate only kfree_obj_16 if rcuperf.kfree_vary_obj_size not passed.
> +			if (!kfree_vary_obj_size)
> +				kfree_type = 0;
> +
> +			if (kfree_type == 0)
> +				alloc_ptr = kmalloc(sizeof(struct kfree_obj_16), GFP_KERNEL);
> +			else if (kfree_type == 1)
> +				alloc_ptr = kmalloc(sizeof(struct kfree_obj_32), GFP_KERNEL);
> +			else if (kfree_type == 2)
> +				alloc_ptr = kmalloc(sizeof(struct kfree_obj_64), GFP_KERNEL);
> +			else
> +				alloc_ptr = kmalloc(sizeof(struct kfree_obj_96),  GFP_KERNEL);
> +
>  			if (!alloc_ptr)
>  				return -ENOMEM;
>  
> -			kfree_rcu(alloc_ptr, rh);
> +			if (kfree_type == 0)
> +				kfree_rcu((struct kfree_obj_16 *)alloc_ptr, rh);
> +			else if (kfree_type == 1)
> +				kfree_rcu((struct kfree_obj_32 *)alloc_ptr, rh);
> +			else if (kfree_type == 2)
> +				kfree_rcu((struct kfree_obj_64 *)alloc_ptr, rh);
> +			else
> +				kfree_rcu((struct kfree_obj_96 *)alloc_ptr, rh);
>  		}
>  
>  		cond_resched();
> -- 
> 2.25.0.rc1.283.g88dfdc4193-goog
> 

Good point and patch!

Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki

