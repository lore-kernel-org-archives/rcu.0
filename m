Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870A7C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632C020890
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU3A/PvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgFRUgF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgFRUgE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 16:36:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54559C06174E;
        Thu, 18 Jun 2020 13:36:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so8949258ljo.0;
        Thu, 18 Jun 2020 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lPjzYKmFxpCIl/6k8qDfJKjGnyJ7TqaRBfjBqulm7Z0=;
        b=dU3A/PvK2RT1lFGNoK/imuUGTYCoZiSQSlHAe2kEjsR7yOIXw/jBtEK5z68u4SAPys
         HKqJqTAuPmfGh1HgFtsfJ2qnYMIra2421Hn0YdSupKq6RAlS6Bp1bzDLd/I3pUDMlMtn
         919SGgtOsJaxe/hNjTt2KH8LJ9xMQWfICRHV3BwSWP2/n2boc65Zlz1eGDsQ0WyJily3
         YxuBaTjYQaPVK0wOm0NDr3vVN08MDmG8MmUcL9avcu+HJxbDkdU8tZPhJh81nqibuosT
         I9YeAT+8dtxSMRuGHwjAr01ugkgqjL9yEIeiPU8MW2d1ff0MGG0LNLprQ6Iwh9gU0iJ/
         +BMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lPjzYKmFxpCIl/6k8qDfJKjGnyJ7TqaRBfjBqulm7Z0=;
        b=jge0pJpKMYcv3dLf4I2aAATwqXaxpZBOUa5IeZa5OeWf6YYmGZdSbXWBboeuoFslW6
         xh9geatDjAlaHcfVY25APJ3NNyR3jIkS+vUZIkmiNygK33VD8mrhTJIZr7JlGyH99m3z
         1IwYkPtiURLZIyd24HTmjOvdjubNUReAbxI04utvK1SjgYOkBZ84nKT+VL7KQLmkG+Y7
         7NO6k7y08k0G8MOnVxmBXcyXz+xJJ9k/6XUkBp0Amhz2INRrhJhcLRYvT/8QTV6YxIOq
         68ClVjmKGKZ8Q9PUXIGZYyQL8eqFji87VM+0W2AtDaF1Fb1yrojReIIjIF3onw4oOptY
         9o6g==
X-Gm-Message-State: AOAM531L5at+h2OT7NsYfpWgEXUjBANxUMwR5ublTTsdmfMWEGzGp2No
        90EyXCKtbluO3RvaLrR5aTg=
X-Google-Smtp-Source: ABdhPJxfDMzQP6gevWeG/xCkKb8cDPxM5Gw108KOF56FBjSwJiRU0LUffgkgMIt9ASDjL2bE4IiyPw==
X-Received: by 2002:a2e:96c2:: with SMTP id d2mr74290ljj.439.1592512562803;
        Thu, 18 Jun 2020 13:36:02 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id t4sm970097lfp.21.2020.06.18.13.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:35:59 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 18 Jun 2020 22:35:57 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20200618203557.GB16976@pc636>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618005214.GN8681@bombadil.infradead.org>
 <20200618031823.GQ2723@paulmck-ThinkPad-P72>
 <20200618173520.GC14613@pc636>
 <20200618175719.GT2723@paulmck-ThinkPad-P72>
 <20200618183448.GA15136@pc636>
 <20200618190359.GU2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618190359.GU2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 12:03:59PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 18, 2020 at 08:34:48PM +0200, Uladzislau Rezki wrote:
> > > > > 
> > > > > I suspect that he would like to keep the tracing.
> > > > > 
> > > > > It might be worth trying the branches, given that they would be constant
> > > > > and indexed by "i".  The compiler might well remove the indirection.
> > > > > 
> > > > > The compiler guys brag about doing so, which of course might or might
> > > > > not have any correlation to a given compiler actually doing so.  :-/
> > > > > 
> > > > > Having a vfree_bulk() might well be useful, but I would feel more
> > > > > confidence in that if there were other callers of kfree_bulk().
> > > > >
> > > > Hmm... I think replacing that with vfree_bulk() is a good idea though.
> > > 
> > > In other words, get rid of kfree_bulk() in favor of vfree_bulk()?
> > > 
> > kfree_bulk() does not understand vmalloc memory. vfree_bulk() should
> > be implemented to release vmalloc's pointers. On i high level it will
> > be used the same way as kfree_bulk() but for vmalloc ptrs. only.
> 
> Ah, I thought that you guys were proposing something that did bulk
> free of both kmalloc and vmalloc memory.
> 
I see your point. We could introduce something like:

	kvfree_bulk(slab_arra, vmalloc_array);

but i do not have a strong opinion here, even though i tend to
say that it would be odd. Having just vfree_bulk(), i think
would be enough, as a result the code will look like:

<snip>
    trace_rcu_invoke_kfree_bulk_callback(
        rcu_state.name, bkvhead[i]->nr_records,
            bkvhead[i]->records);
    if (i == 0)
        kfree_bulk(bkvhead[i]->nr_records,
            bkvhead[i]->records);
    else
        vfree_bulk(bkvhead[i]->nr_records,
            bkvhead[i]->records);
<snip>

Matthew, what is your thought?

Thanks!

--
Vlad rezki
