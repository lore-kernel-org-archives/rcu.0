Return-Path: <SRS0=HY8l=A2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E338C433E0
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 14:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4922D2064B
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 14:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/guopJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgGOOUT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgGOOUR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jul 2020 10:20:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AA3C061755;
        Wed, 15 Jul 2020 07:20:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x9so2790012ljc.5;
        Wed, 15 Jul 2020 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cvmC5haUsj6mD/QlGqPWHxsvGR5ylAYh/s0gDOMIuPQ=;
        b=i/guopJyhuve8jzIeXmqbKMVeFCTd6qre1GGKHpxlntPlk++FNW6lCWSuBvbeWZ4cD
         pNDKiOEaMa40hjmsxXUx1N4Uhv7KQXCAxSve0V+9QWxo6RSLR42uxxBgZV8n0e/0F55W
         F7RwybcyUJsdm+8hJHZQIBi8Z6Y1QoBIyvBo8sR8t/OeYXoyc7XiSJb3rmqHJ8Gkwuqr
         opRYa8A0SMpvF1B7ovVQe4D4HwstxnPv6rjQFDLaYplYv0K80bNZA35MQNUEmeoTgiQZ
         wQNcbIVzI1HuaBv+0KrKEsIvuR4oIM6gDKX63Hik8LiXrmQFXMwzPUkGV7cf9YjJo0ij
         qodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cvmC5haUsj6mD/QlGqPWHxsvGR5ylAYh/s0gDOMIuPQ=;
        b=O4GJyrac6lNDUIrcwVIVPh8kJTrpN/kd2qNk4I8w0dkPYGfAs0boskyi4nv57sd3OW
         wxR38CyBOugf86LsR84PSBnTf7+/3RtMmgSYQn2gJqHZHNXQtktgBmTkWBz93B8/U6H3
         tRb9QI9xtop+yjqI741YIReZ8H60OjKPvn2OmDlvJ5ZiPRNVv5prNzVuNZ/K5A4jQbeV
         XtooQIN32pXNN1zHJEPlA2ybD5WM/l4QWQ1sz12PHtNX8+zrFUPyaGHuryqgvpCHxURv
         3WyDAILFPREHAlGug/nuH1zlj4kJ1ZJ0kyJ9wbbj6+fX5sPHbVuQuV5LeK89SIhYoXue
         1uVw==
X-Gm-Message-State: AOAM533R7MdUoJpxo+aBCaOK1gmS2a7fz/Ux/x3l0pFLiJZm5Zlq8+qJ
        C2SbtEMwTVGbHeS/ypSsLq8=
X-Google-Smtp-Source: ABdhPJzvlfsSM7ba1UIgmK1uKciFvQmZZhfiGnd/sNQAofgyGvZMzN/1z2mwWTrhLJhIHD07R9q57Q==
X-Received: by 2002:a2e:6806:: with SMTP id c6mr4462638lja.219.1594822814615;
        Wed, 15 Jul 2020 07:20:14 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id q13sm524522lfb.55.2020.07.15.07.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:20:11 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 15 Jul 2020 16:20:09 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200715142009.GA25196@pc636>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200715133808.GA24778@pc636>
 <20200715141622.zd2h3mnhd7ypd2fp@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715141622.zd2h3mnhd7ypd2fp@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 15, 2020 at 04:16:22PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-07-15 15:38:08 [+0200], Uladzislau Rezki wrote:
> > > As of -rc3 it should complain about printk() which is why it is still disabled by default.
> > >
> > Have you tried to trigger a "complain" you are talking about?
> 
> No, but I is wrong because a raw_spinlock_t is acquired followed by a
> spinlock_t.
>
Right. According to documentation CONFIG_PROVE_RAW_LOCK_NESTING is used
to detect raw_spinlock vs. spinlock nesting usage.

> 
> > I suspect to get some trace dump when CONFIG_PROVE_RAW_LOCK_NESTING=y.
> 
> You should get one if you haven't received any splat earlier (like from
> printk code because it only triggers once).
> 
Got it.

Thanks! 

--
Vlad Rezki
