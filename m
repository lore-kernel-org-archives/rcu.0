Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA878C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 18:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE01207E8
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 18:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfZ+mV1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgFRSex (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730653AbgFRSex (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 14:34:53 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F96C06174E;
        Thu, 18 Jun 2020 11:34:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t74so4088373lff.2;
        Thu, 18 Jun 2020 11:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gv0LjjUrQkCQWJP6/3zOSB7ve/Wys452D65ekHlTB94=;
        b=RfZ+mV1yxnNYOPAxLVJmwYaLdVMQ7pXh5SR/B86DdT6WsHt5FzX/KUjmEHSXFgrAnO
         TFOMaW8Rdy8WCChz08i/Ii9YTxl8H2xafs2YIXNC3qmkGcCE+OfMZY+APFgyujxgTEoC
         Tf/ktbPePSI6UHiDkF0m2q542Dtic1woZ5mfl4oOTRc7Sq7q5VbPT7UHwccrbtBUrcP9
         n6KnEifDu/Ri2NVbU+vohE7T64HxiqQJLWxH8daXK2NOZjB4bMwe+Rpza3wKcQaGxGiR
         PiIlihQDTzd4R2BXzLtfQ7UoImF0/hCvoA4uL8zf+4KvonpWDhcS6WZl5QBz432AITw1
         ymRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gv0LjjUrQkCQWJP6/3zOSB7ve/Wys452D65ekHlTB94=;
        b=LUwV2HvyQqtUQ26JlPcMwjNB05U8YDxyMgnh0QFe7MrZvIpCI3HxRuvxm6BK8FOztS
         PdGy0NAIvZzE7jJHG0B4Il3KoG87sHKZkzduGjWQmW6rIHr3CRKLmPAdRjXUaDwXLdGR
         Dxby7WohzXl8K30TC4FYwhXfe70cQW15Xpu+Bs1DmYbLw0VYtOYA98mpbv4kFU0QbEAd
         V1cUC7Kwc5U08WfGiAAhQjiUT8QTPQZqqp459qE3OxhQgT8Tp3fL5bpM17y+D+b6JxCj
         etQ8k/naLjUEA0HkYgoSSVKf0ekuMKEh1JdsaeSAPBF3dNGJQpmqq6C0zIVFxSNskUjL
         Y55Q==
X-Gm-Message-State: AOAM530m5n8Z/CbiJdPOGfZRVyNIlwrqU0iYUn21v4vEoFGUuWilCkRe
        z74VeYpAwyjmX+hpNcDHK3I=
X-Google-Smtp-Source: ABdhPJzp8dVNQyuS7FXPMgAmvsheR5wu2JOMKlnEtzuj17yMDsLqHd6i16PlGUAtaRP59H30c7jywQ==
X-Received: by 2002:a19:8253:: with SMTP id e80mr3136304lfd.199.1592505291079;
        Thu, 18 Jun 2020 11:34:51 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 11sm908156lfz.78.2020.06.18.11.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 11:34:50 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 18 Jun 2020 20:34:48 +0200
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
Message-ID: <20200618183448.GA15136@pc636>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618005214.GN8681@bombadil.infradead.org>
 <20200618031823.GQ2723@paulmck-ThinkPad-P72>
 <20200618173520.GC14613@pc636>
 <20200618175719.GT2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618175719.GT2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > > 
> > > I suspect that he would like to keep the tracing.
> > > 
> > > It might be worth trying the branches, given that they would be constant
> > > and indexed by "i".  The compiler might well remove the indirection.
> > > 
> > > The compiler guys brag about doing so, which of course might or might
> > > not have any correlation to a given compiler actually doing so.  :-/
> > > 
> > > Having a vfree_bulk() might well be useful, but I would feel more
> > > confidence in that if there were other callers of kfree_bulk().
> > >
> > Hmm... I think replacing that with vfree_bulk() is a good idea though.
> 
> In other words, get rid of kfree_bulk() in favor of vfree_bulk()?
> 
kfree_bulk() does not understand vmalloc memory. vfree_bulk() should
be implemented to release vmalloc's pointers. On i high level it will
be used the same way as kfree_bulk() but for vmalloc ptrs. only.

> > > But again, either way, future work as far as this series is concerned.
> > > 
> > What do you mean: is concerned?
> 
> Apologies for the strange English.  How about this?
> 
> "This series is OK as is.  Any comments above did not prevent me from
> taking these patches, but instead discuss possible future work."
> 
That is perfectly clear to me :)

> > We are planning to implement kfree_rcu() to be integrated directly into
> > SLAB: SLAB, SLUB, SLOB. So, there are plenty of future work :)
>
> And I am glad that this is still the goal.  ;-)
>
:)

--
Vlad Rezki
