Return-Path: <SRS0=nBXm=AA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F01C433E1
	for <rcu@archiver.kernel.org>; Fri, 19 Jun 2020 15:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE46420809
	for <rcu@archiver.kernel.org>; Fri, 19 Jun 2020 15:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo6wL5xA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393519AbgFSPrE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403875AbgFSPq5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Jun 2020 11:46:57 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361E9C06174E;
        Fri, 19 Jun 2020 08:46:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so12034751ljc.8;
        Fri, 19 Jun 2020 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2aeO2u4RtaCPo8nCEgw4qCFKUHWK0LPFLeoI2aW5HPQ=;
        b=jo6wL5xA6o2oH5Qfa/Iq4GtVdDCLwHsr8D1YOa8ko3zROJAiMn/5bGOz6il/WVub71
         sgkOp5yYot9p6XVr6ItkoFtBdxyEetxbA3qJ1aBlqE2UyowCwErx9g0KfuWMbY02+zCX
         aM+An3sSPzlrRJKkObwEk0GKPbwYYeV7uPOaOrHOU1v72UV0PV1J2xb1Xtsf0Foiurn9
         s2mqi/EQ+kM1jYqerwtJhJjsCnpn8C5AZSkHmrKrILzE4485907xY8fZdWSZSHer0v2e
         SdSy4vj6XHFIPnVV0DS9bk7+A//zYOx/0mWh5yCkAjb3CrfOopT/l/KkiUuTU+ywyy4q
         PODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2aeO2u4RtaCPo8nCEgw4qCFKUHWK0LPFLeoI2aW5HPQ=;
        b=QPHpONugUZc1W7DQy9TX/pi/KmaSmhlbHBrGcFYrfQj8pdmMgw0OspnnORGq0u91qa
         NJCnRMDCcuB6jXvgrjkWzdkH6dG7xppvH+KuPZuffVALD8iMIIYeRh7QXYNDEdcXpVDz
         4EghiQSD5UXbZJ1+I/NTttGPv8QB03fKXIXb6KQyKmEBNCogrW25wXzEuiU6b1vF+ERE
         NjbkgXlIGfFU8WX6rtj3PF4p3CNxfRGqQ9UikZsmJlJrgC2Cc8Fb4ZNCMgK4xl0f+Dv+
         ixSMqC1kahW+x6+YpYofnBOZkEdwxCk83GnDGbMKdlyNvMCtJqxAKBas7MVUhrKgZFwy
         TDcQ==
X-Gm-Message-State: AOAM530NABG6kjVibXNlGSC9gP6cPxwhMQ5F657oUBMVztUaF0haF20f
        rstWC6uPBW6Ldr+w/zOPby8=
X-Google-Smtp-Source: ABdhPJwUhOSSv9Ni5UNYPTcQgeNwmvJEp3WKGXZARh2sfgnjRmYeeL7JRfK5VaDXWSsF2HWXIUVk1w==
X-Received: by 2002:a2e:9a55:: with SMTP id k21mr2282446ljj.340.1592581615594;
        Fri, 19 Jun 2020 08:46:55 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id f24sm1222442ljk.125.2020.06.19.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 08:46:54 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 19 Jun 2020 17:46:52 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200619154652.GA19990@pc636>
References: <20200618005214.GN8681@bombadil.infradead.org>
 <20200618031823.GQ2723@paulmck-ThinkPad-P72>
 <20200618173520.GC14613@pc636>
 <20200618175719.GT2723@paulmck-ThinkPad-P72>
 <20200618183448.GA15136@pc636>
 <20200618190359.GU2723@paulmck-ThinkPad-P72>
 <20200618203557.GB16976@pc636>
 <20200618203821.GU8681@bombadil.infradead.org>
 <20200618211709.GA17263@pc636>
 <20200618213427.GV2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618213427.GV2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 02:34:27PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 18, 2020 at 11:17:09PM +0200, Uladzislau Rezki wrote:
> > > > <snip>
> > > >     trace_rcu_invoke_kfree_bulk_callback(
> > > >         rcu_state.name, bkvhead[i]->nr_records,
> > > >             bkvhead[i]->records);
> > > >     if (i == 0)
> > > >         kfree_bulk(bkvhead[i]->nr_records,
> > > >             bkvhead[i]->records);
> > > >     else
> > > >         vfree_bulk(bkvhead[i]->nr_records,
> > > >             bkvhead[i]->records);
> > > > <snip>
> > > > 
> > > > Matthew, what is your thought?
> > > 
> > > That was my thinking too.  If we had a kvfree_bulk(), I would expect it to
> > > handle a mixture of vfree and kfree, but you've segregated them already.
> > > So I think this is better.
> > >
> > Yes, the segregation is done. Having vfree_bulk() is enough then.
> > We are on the same page :)
> 
> Very good.  When does kfree_rcu() and friends move out of kernel/rcu?
> 
Do you mean to move the whole logic of kfree_rcu() from top to down to mm/?

Thanks!

--
Vlad Rezki
