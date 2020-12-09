Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA3BC2BB40
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 19:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B54723C91
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 19:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbgLITkM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730933AbgLITkI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 14:40:08 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AE2C0613CF;
        Wed,  9 Dec 2020 11:39:28 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id f24so3773112ljk.13;
        Wed, 09 Dec 2020 11:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8MclXbccqtCWfFffMRwDtHFBUhqfix9timR/9hQkzug=;
        b=iQe2+WJtOqnh/5S+VzpQP+Wz18PqcExYKhKf+5uJiIkoDoixEnqGAH0ioN13zZIEpd
         92Ufy1Cd+lN+zEk0JXU7UHbVJA1DkX4wcOALq24uXS8KPxIZPwnnwbXvraUON+dPzUdN
         ZHT3QnU827Y5oEwwmYR6KjJImZwSsX2HOhvBYNx2MclZg7bSItg4TUFnEMzXhOlC32eG
         rLY1cGNRm0jL3qfg2dalUR9rsYDzvnHfeQF/M73/9TjAovbyKIhB61QGG69lf/MfCHuo
         ikaBduoLFVX3eiSrED8QNNxBKQPR6ui0Ie5+s1mgTMbAAguhWDvsmTV+X2lHDsP4vW6w
         Qtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8MclXbccqtCWfFffMRwDtHFBUhqfix9timR/9hQkzug=;
        b=FqaC+TBxyOgy7hSpY9LPDGUm9F9LlX9p1q2Ejh25nIvXQG2Q9hpd/03l9vRolw1BRm
         4rDvBu1iGK/4DAxiP5YJi5EhP0U6rkW1Ft3hz7bhvDj3GvoXHPlYCVo6yZwv2ZxdKlZf
         ZMmkujW5hxMeV7BLMXqKSBpvWVRlZkJzxnlJJ9PhNKoFwERLfeP9NOSUlUIIPAyguZsF
         v4jZoHXkdTHuUuJihcnaFgZg+fjNTVtaT9pZUhuAJPvuv2bPQZ/3rlIWPq8tO1Kgj8fe
         edBpFF0S6uZtbCjSwdkXOQxYl+5FHVqOcJBB8gPtoUe65XihMUaquvK7Sej0f5MdmJ1T
         Ls1g==
X-Gm-Message-State: AOAM533gH1o96mZFAxdeG1BqYCZoqcZXpvOu2xI8DMm9O2pXaoIr7Udd
        AvsgryfnXV0NvR34ZxYIqxY=
X-Google-Smtp-Source: ABdhPJx6+Y1qIoxMNcFaamDzGTQeOA7s66Agtb1YcfIVKQtyvbbn6CP1rAosVAfQmfOrFUoBFhTDBQ==
X-Received: by 2002:a2e:6c0f:: with SMTP id h15mr1696043ljc.305.1607542766736;
        Wed, 09 Dec 2020 11:39:26 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id v63sm267588lfa.89.2020.12.09.11.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:39:26 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 9 Dec 2020 20:39:24 +0100
To:     Vlastimil Babka <vbabka@suse.cz>, paulmck@kernel.org
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, iamjoonsoo.kim@lge.com,
        andrii@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 sl-b 3/5] mm: Make mem_dump_obj() handle vmalloc()
 memory
Message-ID: <20201209193924.GB5757@pc638.lan>
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-3-paulmck@kernel.org>
 <1c25ca09-ec43-df31-a5ba-476397637a53@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c25ca09-ec43-df31-a5ba-476397637a53@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 09, 2020 at 06:51:20PM +0100, Vlastimil Babka wrote:
> On 12/9/20 2:13 AM, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit adds vmalloc() support to mem_dump_obj().  Note that the
> > vmalloc_dump_obj() function combines the checking and dumping, in
> > contrast with the split between kmem_valid_obj() and kmem_dump_obj().
> > The reason for the difference is that the checking in the vmalloc()
> > case involves acquiring a global lock, and redundant acquisitions of
> > global locks should be avoided, even on not-so-fast paths.
> > 
> > Note that this change causes on-stack variables to be reported as
> > vmalloc() storage from kernel_clone() or similar, depending on the degree
> > of inlining that your compiler does.  This is likely more helpful than
> > the earlier "non-paged (local) memory".
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: <linux-mm@kvack.org>
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> ...
> 
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3431,6 +3431,18 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> >  }
> >  #endif	/* CONFIG_SMP */
> >  
> > +bool vmalloc_dump_obj(void *object)
> > +{
> > +	struct vm_struct *vm;
> > +	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> > +
> > +	vm = find_vm_area(objp);
> > +	if (!vm)
> > +		return false;
> > +	pr_cont(" vmalloc allocated at %pS\n", vm->caller);
> 
> Would it be useful to print the vm area boundaries too?
> 
Do you mean va_start/va_end information?

--
Vlad Rezki
