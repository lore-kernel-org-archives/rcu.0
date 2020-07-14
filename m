Return-Path: <SRS0=gxlL=AZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F61C433E2
	for <rcu@archiver.kernel.org>; Tue, 14 Jul 2020 20:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1F520720
	for <rcu@archiver.kernel.org>; Tue, 14 Jul 2020 20:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueR2z9sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgGNUGW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbgGNUGV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Jul 2020 16:06:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C0C061755;
        Tue, 14 Jul 2020 13:06:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so25139926lji.9;
        Tue, 14 Jul 2020 13:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=brd+lnnP7N/7kjGtuwt6eD5xNtDXHFwk0PXhEbeO+CQ=;
        b=ueR2z9sasgMdW408r96Eapok5hq6cc1A1CFfLChE4QDMfEFWEu3A/FKNdsJx+svLP5
         L0WAUwMTYC8dpOSwR6HoF3pXA110khYp5B9R6cZEWrjdgdlqfRc+2qeOn/LwFQiJuftK
         6+yups5yxUhtTOCriUEhfetkgDvA52O5CSXxBgs1Ax8Hvj3UKMYGVyn+0FKj8xR8718n
         /etoT6avVTORJwwDj9vHaCr4dVKUgdKZx4o/XsItYN5XTp+sLATFcI561/SVwyWUkm+4
         vavSknyUtoyTd+J0amUBrtEp7JqgsGz9VvZaCpE2fN8+r2xn9AAMD1XciOr8iSWWJgh5
         rvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=brd+lnnP7N/7kjGtuwt6eD5xNtDXHFwk0PXhEbeO+CQ=;
        b=HG7dO1jN2qkNRJQlAXdRYDxVsfs61CZOlkVOWOMICi1NJ+gtrk3YLUvOLnBgnkKv1w
         IXWZQ+53vwM9VbjPEHYBHEMt7z1uo6b9iY+IErnT1n9U3jtKgGu44BEdR/Ditz4Qi31w
         FrNXwt5bl8z6eMCkk0U0iUcoEZQxQVQykKR6tlkN8W5VW831azZxvbOKpwPqRpYh/4Hh
         ndctuSVOlZWRu0hSj/IMSD+U4Y6wL6B+Q+QL5f8PTIaTXFRGYoo5N197r0qrA5iHwkFE
         7+xUoFqKui7s2I10dyZvHxfqu4EpB2Q6XNlufVYlMbTAm8a78njiBTZtMqSVbc9Wgr98
         FOUg==
X-Gm-Message-State: AOAM530+/SIQBvYRDE/+B9UHSZ1I9Vwqmmr+PEZMEr0yIKifymHF9Gsj
        KWDvRi2v1wGvBsnDHpJXkgk=
X-Google-Smtp-Source: ABdhPJyXNFftxsjmo2IEp264PD9aXzmQ2UrUIPXD+ROCm/lAARLwDhP84FkTt6++P6BiRWAl6rZSMQ==
X-Received: by 2002:a2e:9186:: with SMTP id f6mr3252103ljg.386.1594757180081;
        Tue, 14 Jul 2020 13:06:20 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z12sm1244lfh.61.2020.07.14.13.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:06:19 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 14 Jul 2020 22:06:16 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org, arnd@arndb.de,
        elver@google.com, ethp@qq.com, frederic@kernel.org,
        jbi.octave@gmail.com, joel@joelfernandes.org,
        lihaoliang@google.com, madhuparnabhowmik10@gmail.com,
        mchehab+huawei@kernel.org, peter.enderborg@sony.com,
        rdunlap@infradead.org, richard.weiyang@linux.alibaba.com,
        urezki@gmail.com, zou_wei@huawei.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU commits for v5.9
Message-ID: <20200714200616.GA20137@pc636>
References: <20200714172701.GA31369@paulmck-ThinkPad-P72>
 <20200714181426.hhguqzrcqdubyvae@linutronix.de>
 <20200714182732.GU9247@paulmck-ThinkPad-P72>
 <20200714190253.ylqjif7frqs2rq7x@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714190253.ylqjif7frqs2rq7x@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 14, 2020 at 09:02:53PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-07-14 11:27:32 [-0700], Paul E. McKenney wrote:
> > I believe that Ulad and Joel are working on an update.
>
> I expressed multiple times that I am unhappy with the raw_spinlock_t
> which both want to keep. It is important to be future proof but at the
> same time I am not sure if they know how many in-hardirq kmalloc() or
> kfree() invocation we have as of today in PREEMPT_RT.
>
It is not about counting how many times kfree_rcu() gets called from
the hard IRQ context for RT kernel. In fact it is about breaking of
such possibility if a conversion to spinlock_t is done. Is not it?

As a result the revert would change a behavior of the API function,
that is used to accept such usage. That is a motivation.

--
Vlad Rezki
