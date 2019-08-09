Return-Path: <SRS0=m0PJ=WF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A022C31E40
	for <rcu@archiver.kernel.org>; Fri,  9 Aug 2019 16:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3AF2089E
	for <rcu@archiver.kernel.org>; Fri,  9 Aug 2019 16:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="H/q/ugKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfHIQB6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:01:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39894 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfHIQB6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Aug 2019 12:01:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so42294454pfn.6
        for <rcu@vger.kernel.org>; Fri, 09 Aug 2019 09:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EJofCy10+ue86sg1A2uKbxKGA2M2r3ITuaKGVekYLUE=;
        b=H/q/ugKAoht1NpDQKPRvER3aJJehZtVzYkxFFgO8EZ4+hijI4cmuiYt5KDxsQ52cIb
         RJRdeBBzq/mfL4wSUUXMuKB3HyvtoO0/swAqi+axZ07ENli7Pag6fG+9gK/4dCReIE/3
         iWobwX0iZnins6B/8VMXPaxprcydn8UfUXmJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EJofCy10+ue86sg1A2uKbxKGA2M2r3ITuaKGVekYLUE=;
        b=lU8egCkr7kCmx3i39ye20L5N0luq9DPINh7yopjbu6UrSVNQ2H+jmW4Jm9HY/FhWk6
         sMrDOcMbH/ZcSDXYOvvUK9qzj6nGw6cST2F3fHiuh5VkAzWyaAueJxB+5PtOPa4q+nQv
         41VS7WD37vUbrY6woZrKP9p7Q6gyKQgRpigpLJI/3ulU3CHOTS0ZzQyQRJx13PsbXX4L
         NRUa/QPG1n498i+Pwt5oOObiJ2/X9LeI9n5voQy00jfdX8G7e89D+W7a3EVG3I6fHcTt
         6kl/IZWRm+M6LBUp4MGPTFyrYd2fGm9O9lWEJqN5tJ4UzCKExY+h06iByTVk1jIOjzsZ
         urLQ==
X-Gm-Message-State: APjAAAXeopMwa8+L2TRFbg5OyBh0eDhML9Wi2G9lRx3B56wRR+RBRKBW
        HJLGr1y7ds4L9NLjb2XHfIjR/Q==
X-Google-Smtp-Source: APXvYqyWk3OhHFqwSsJVydZLOZpED4wbK4RYVOXEg2EOVUCuMco1/20JxEBi/yg//UhIHIdoKdvyvw==
X-Received: by 2002:a62:e716:: with SMTP id s22mr22138885pfh.250.1565366517325;
        Fri, 09 Aug 2019 09:01:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o95sm5331501pjb.4.2019.08.09.09.01.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 09:01:56 -0700 (PDT)
Date:   Fri, 9 Aug 2019 12:01:55 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com,
        byungchul.park@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 2/2] rcuperf: Add kfree_rcu performance Tests
Message-ID: <20190809160155.GA221383@google.com>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806212041.118146-2-joel@joelfernandes.org>
 <20190807002915.GV28441@linux.ibm.com>
 <20190807102213.GD169551@google.com>
 <20190807175657.GF28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807175657.GF28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 07, 2019 at 10:56:57AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 07, 2019 at 06:22:13AM -0400, Joel Fernandes wrote:
> > On Tue, Aug 06, 2019 at 05:29:15PM -0700, Paul E. McKenney wrote:
> > > On Tue, Aug 06, 2019 at 05:20:41PM -0400, Joel Fernandes (Google) wrote:
> > > > This test runs kfree_rcu in a loop to measure performance of the new
> > > > kfree_rcu, with and without patch.
> > > > 
> > > > To see improvement, run with boot parameters:
> > > > rcuperf.kfree_loops=2000 rcuperf.kfree_alloc_num=100 rcuperf.perf_type=kfree
> > > > 
> > > > Without patch, test runs in 6.9 seconds.
> > > > With patch, test runs in 6.1 seconds (+13% improvement)
> > > > 
> > > > If it is desired to run the test but with the traditional (non-batched)
> > > > kfree_rcu, for example to compare results, then you could pass along the
> > > > rcuperf.kfree_no_batch=1 boot parameter.
> > > 
> > > You lost me on this one.  You ran two runs, with rcuperf.kfree_no_batch=1
> > > and without?  Or you ran this patch both with and without the earlier
> > > patch, and could have run with the patch and rcuperf.kfree_no_batch=1?
> > 
> > I always run the rcutorture test with patch because the patch doesn't really
> > do anything if rcuperf.kfree_no_batch=0. This parameter is added so that in
> > the future folks can compare effect of non-batching with that of the
> > batching. However, I can also remove the patch itself and run this test
> > again.
> > 
> > > If the latter, it would be good to try all three.
> > 
> > Ok, sure.
> 
> Very good!  And please make the commit log more clear.  ;-)

Sure will do :)

> > > > +	long me = (long)arg;
> > > > +	struct kfree_obj **alloc_ptrs;
> > > > +	u64 start_time, end_time;
> > > > +
> > > > +	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> > > > +	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> > > > +	set_user_nice(current, MAX_NICE);
> > > > +	atomic_inc(&n_kfree_perf_thread_started);
> > > > +
> > > > +	alloc_ptrs = (struct kfree_obj **)kmalloc(sizeof(struct kfree_obj *) * kfree_alloc_num,
> > > > +						  GFP_KERNEL);
> > > > +	if (!alloc_ptrs)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	start_time = ktime_get_mono_fast_ns();
> > > 
> > > Don't you want to announce that you started here rather than above in
> > > order to avoid (admittedly slight) measurement inaccuracies?
> > 
> > I did not follow, are you referring to the measurement inaccuracy related to
> > the "kfree_perf_thread task started" string print?  Or, are you saying that
> > ktime_get_mono_fast_ns() has to start earlier than over here?
> 
> I am referring to the atomic_inc().

Oh yes, great catch. I will increment closer to the test's actual start.
thanks!

> > (I will reply to the rest of the comments below in a bit, I am going to a
> > hospital now to visit a sick relative and will be back a bit later.)
> 
> Ouch!!!  I hope that goes as well as it possibly can!  And please don't
> neglect your relative on RCU's account!!!

Thanks! it went quite well and now I am back to work ;-)

 - Joel

