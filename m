Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916B8C3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 16:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71AF120746
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 16:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB7fNAz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgEDQ4f (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 12:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbgEDQ4e (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 May 2020 12:56:34 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E238C061A0E;
        Mon,  4 May 2020 09:56:34 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a9so4994212lfb.8;
        Mon, 04 May 2020 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uq7Cp9sRzO17hCXg+U38cDHiVk9tcoMKEdlR/VPmBCA=;
        b=WB7fNAz7ezTp/EIxVo9weanA4wgM5W+Ik6gzOwV1XRS6yZuIjkezO6aJeK7bxe22Fk
         rjL49+fRdQZv0itvLwP+/nUzdiwrdtUV6PTc70cyu0avMZO36CZPeIBVIqf0gZe5laIv
         xDH9JMsspY1KpfqgDGbosG6TIjW5TMb1HqyTiuB4bIMPv0nsjyOxFCIh3PeTHF/73NtJ
         mq7Ay5vCk9uiOyJpDPe/71Yqmgr1eAMjQHHjDJ/OAaIF4jVDDjVWNSkjQpAmDpyquedd
         XQIOwu+Nfm3SVDbWZ2dXPAYdJ4CRx5BZH3ie8uGHfYh6/MA/IHTkESuSaloDqAaciVws
         nlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uq7Cp9sRzO17hCXg+U38cDHiVk9tcoMKEdlR/VPmBCA=;
        b=DSK68eUE4pYBYmNYGghmxLTy2MUTw4CyiKOY4Vpa0eTuotCAOiLZnQPoeehIuovyw4
         Jh2gQkR8jpakyKP1CqBo1YZi/qfqoi4h29nqCBfo7Rn1gjRqOtiAzcxnlv+UGVHqdMyJ
         SeLwdoSZcAAYEC4z+w62eyTF5oVPx5xG0Gw6uT1+1DF+p4mFJNrB+wFgcal1RA28Jds4
         +66hsFTBtw1EncwvEi4KfnnNk7uJ+ohmbvpwCHjwMocjUzMLnZtGF0p0pvGD4ifazEm2
         pNlgiwUbRBRo+eQr9puVw7U3rrixHkkmEEdnQPU8vwIMw67N1fn9HvkBdLW6u48Mp3Qt
         cJWg==
X-Gm-Message-State: AGi0PuYuiDDNSHoYAD0SG7OAOkHhWnilonSn4fCNVeyfgE7Q4AjN1pUm
        niP85OTnHxTD7BScqPSO/JRP4/dciEvK/Q==
X-Google-Smtp-Source: APiQypJIYOGRdt0a6sPjl66fJSqZJTkezZ3Epnp3pIhYCU2UkMwickRewOFI8jnorrTODAWiTk7xuQ==
X-Received: by 2002:a19:7418:: with SMTP id v24mr5524146lfe.15.1588611392880;
        Mon, 04 May 2020 09:56:32 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id h22sm8680500ljb.65.2020.05.04.09.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 09:56:32 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 May 2020 18:56:29 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 19/24] rcu/tree: Support reclaim for head-less object
Message-ID: <20200504165629.GA20257@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-20-urezki@gmail.com>
 <20200501223909.GF7560@paulmck-ThinkPad-P72>
 <20200504001258.GD197097@google.com>
 <20200504002855.GF2869@paulmck-ThinkPad-P72>
 <20200504003237.GD212435@google.com>
 <20200504142153.GG17577@pc636>
 <20200504153147.GL2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504153147.GL2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > 
> > For single argument we can drop the lock before the entry to the page
> > allocator. Because it follows might_sleep() anotation we avoid of having
> > a situation when spinlock(rt mutex) is taken from any atomic context.
> > 
> > Since the lock is dropped the current context can be interrupted by
> > an IRQ which in its turn can also call kvfree_rcu() on current CPU.
> > In that case it must be double argument(single is not allowed) kvfree_rcu()
> > call. For PREEMPT_RT if no cache everything is reverted to rcu_head usage,
> > i.e. the entry to page allocator is bypassed.
> > 
> > It can be addressed as a separate patch and send out later on if we
> > are on the same page.
> > 
> > Paul, Joel what are your opinions?
> 
> I strongly prefer that it be removed from the series.  I do understand
> that this is a bit more hassle right now, but this does help avoid
> confusion in the future, plus perhaps also avoiding issues with future
> bisections.
> 
We have already decided to get rid of it, i mean small allocations(dynamic
rcu_head attaching). I will exclude it from next patch-set version. 

--
Vlad Rezki
