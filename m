Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700DFC43331
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 15:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AC52072E
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 15:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="us2gR1fE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgC3PaE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:30:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33977 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgC3PaD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 Mar 2020 11:30:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10so18314915ljn.1;
        Mon, 30 Mar 2020 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cq26ZWZgsMRlQvotSIdZaVx4Pdp3fvhPVBSTmjGmY1o=;
        b=us2gR1fEwH/wJobb6qxke9Tm73Hq2On8K7uBBO3dc1zpx8Hhbe+SD8JGHqg0dc8Ih+
         fC24nCRxwiv///kX9y4AtLjrQgsyDs5/nDLucuSrZjRZCpteU1H6vvKIqORoDLupu8Ma
         QDIhviKZBDiCp4i1plnA1P+9hDBVPkG32nYpDHIcJsrG4EsrMH47FQSKYKCepGl16nFL
         8zLqh15VyjwcoQGZZXr6InB/fvFE7Abr20gF3Psn6qvyzjWlqR8ht9nQwhQCTEGIuuqm
         A7shdtqWeQ7YrI8+WTWgRDkdy+JIK1MPH097vckCWJQuV51LwFXe3Ir3WDAIivjkxRmE
         4NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cq26ZWZgsMRlQvotSIdZaVx4Pdp3fvhPVBSTmjGmY1o=;
        b=A9Ygw1URvu9GT/mjYe8yu/N659Ko8Ehss+QR3+8z6/Bp5PM0/tyc4SOwZf4R2WPkjO
         yk7nLrJ1OvGFf9jW6CmTipUiVAQFIwmo3kDd6vk7O8hNqoyK17nZ9Lz+HJHxHa1N3I5j
         YWw36k1RbIG4vL2KlSUqMyzxPsV97TA4JcxWz3+JeK66rFuR7IyWNR/D4K0CZdg9ycO6
         e2lfMwFSpxMW0G0nsnQ7QcbyfbpaAcOTyfveHl+NFRANNsT8IZUYxlV5CYhizVa25H9/
         HRQdsZJjCoIMJUx8/quKUsLwxu8Y54/lveNf7emFIysop4WIgTblrGoJjowfmmB/tFOe
         xhow==
X-Gm-Message-State: AGi0PuaLiUTu5e+VYz85bNOEikqNkRQD1DR7nGyoPsn1hAeJSX1o3bHz
        98XDGRd7WtZqKJEPicswVG4=
X-Google-Smtp-Source: APiQypJbSW4LONyeiim8HyIOCs0IlQRLUHPsXnht8+KfKoRCETSGy8qf60cDhOSsnuAv9xHJNUH3YQ==
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr7532189ljo.152.1585582200798;
        Mon, 30 Mar 2020 08:30:00 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id v19sm9117066lfg.9.2020.03.30.08.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:30:00 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 30 Mar 2020 17:29:51 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 10/18] rcu/tree: Maintain separate array for vmalloc ptrs
Message-ID: <20200330152951.GA2553@pc636>
References: <20200330023248.164994-11-joel@joelfernandes.org>
 <202003301715.9gMSa9Ca%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003301715.9gMSa9Ca%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Joel.

Sent out the patch fixing build error.

--
Vlad Rezki

> Hi "Joel,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on rcu/dev]
> [also build test ERROR on rcu/rcu/next next-20200327]
> [cannot apply to linus/master linux/master v5.6]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Joel-Fernandes-Google/kfree_rcu-improvements-for-rcu-dev/20200330-113719
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> config: mips-randconfig-a001-20200330 (attached as .config)
> compiler: mips64el-linux-gcc (GCC) 5.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=5.5.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/rcu/tree.c: In function 'kfree_rcu_work':
> >> kernel/rcu/tree.c:2946:4: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]
>        vfree(bvhead->records[i]);
>        ^
>    cc1: some warnings being treated as errors
> 
> vim +/vfree +2946 kernel/rcu/tree.c
> 
>   2884	
>   2885	/*
>   2886	 * This function is invoked in workqueue context after a grace period.
>   2887	 * It frees all the objects queued on ->bhead_free or ->head_free.
>   2888	 */
>   2889	static void kfree_rcu_work(struct work_struct *work)
>   2890	{
>   2891		unsigned long flags;
>   2892		struct kvfree_rcu_bulk_data *bkhead, *bknext;
>   2893		struct kvfree_rcu_bulk_data *bvhead, *bvnext;
>   2894		struct rcu_head *head, *next;
>   2895		struct kfree_rcu_cpu *krcp;
>   2896		struct kfree_rcu_cpu_work *krwp;
>   2897		int i;
>   2898	
>   2899		krwp = container_of(to_rcu_work(work),
>   2900					struct kfree_rcu_cpu_work, rcu_work);
>   2901	
>   2902		krcp = krwp->krcp;
>   2903		spin_lock_irqsave(&krcp->lock, flags);
>   2904		/* Channel 1. */
>   2905		bkhead = krwp->bkvhead_free[0];
>   2906		krwp->bkvhead_free[0] = NULL;
>   2907	
>   2908		/* Channel 2. */
>   2909		bvhead = krwp->bkvhead_free[1];
>   2910		krwp->bkvhead_free[1] = NULL;
>   2911	
>   2912		/* Channel 3. */
>   2913		head = krwp->head_free;
>   2914		krwp->head_free = NULL;
>   2915		spin_unlock_irqrestore(&krcp->lock, flags);
>   2916	
>   2917		/* kmalloc()/kfree() channel. */
>   2918		for (; bkhead; bkhead = bknext) {
>   2919			bknext = bkhead->next;
>   2920	
>   2921			debug_rcu_bhead_unqueue(bkhead);
>   2922	
>   2923			rcu_lock_acquire(&rcu_callback_map);
>   2924			trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
>   2925				bkhead->nr_records, bkhead->records);
>   2926	
>   2927			kfree_bulk(bkhead->nr_records, bkhead->records);
>   2928			rcu_lock_release(&rcu_callback_map);
>   2929	
>   2930			if (cmpxchg(&krcp->bkvcache[0], NULL, bkhead))
>   2931				free_page((unsigned long) bkhead);
>   2932	
>   2933			cond_resched_tasks_rcu_qs();
>   2934		}
>   2935	
>   2936		/* vmalloc()/vfree() channel. */
>   2937		for (; bvhead; bvhead = bvnext) {
>   2938			bvnext = bvhead->next;
>   2939	
>   2940			debug_rcu_bhead_unqueue(bvhead);
>   2941	
>   2942			rcu_lock_acquire(&rcu_callback_map);
>   2943			for (i = 0; i < bvhead->nr_records; i++) {
>   2944				trace_rcu_invoke_kvfree_callback(rcu_state.name,
>   2945					(struct rcu_head *) bvhead->records[i], 0);
> > 2946				vfree(bvhead->records[i]);
>   2947			}
>   2948			rcu_lock_release(&rcu_callback_map);
>   2949	
>   2950			if (cmpxchg(&krcp->bkvcache[1], NULL, bvhead))
>   2951				free_page((unsigned long) bvhead);
>   2952	
>   2953			cond_resched_tasks_rcu_qs();
>   2954		}
>   2955	
>   2956		/*
>   2957		 * This path covers emergency case only due to high
>   2958		 * memory pressure also means low memory condition,
>   2959		 * when we could not allocate a bulk array.
>   2960		 *
>   2961		 * Under that condition an object is queued to the
>   2962		 * list instead.
>   2963		 */
>   2964		for (; head; head = next) {
>   2965			unsigned long offset = (unsigned long)head->func;
>   2966			void *ptr = (void *)head - offset;
>   2967	
>   2968			next = head->next;
>   2969			debug_rcu_head_unqueue((struct rcu_head *)ptr);
>   2970			rcu_lock_acquire(&rcu_callback_map);
>   2971			trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
>   2972	
>   2973			if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
>   2974				kvfree(ptr);
>   2975	
>   2976			rcu_lock_release(&rcu_callback_map);
>   2977			cond_resched_tasks_rcu_qs();
>   2978		}
>   2979	}
>   2980	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


