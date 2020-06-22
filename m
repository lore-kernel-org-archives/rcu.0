Return-Path: <SRS0=LAXB=AD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADD4C433E0
	for <rcu@archiver.kernel.org>; Mon, 22 Jun 2020 19:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2B620706
	for <rcu@archiver.kernel.org>; Mon, 22 Jun 2020 19:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLEkuxtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgFVTEO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbgFVTEO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 15:04:14 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82180C061573;
        Mon, 22 Jun 2020 12:04:13 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n24so20551004lji.10;
        Mon, 22 Jun 2020 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3+Q10qt8h6Nrtshd/+6BaS9xbma8WBq1l3GqLQ3g9zk=;
        b=PLEkuxtCGWVu8bw6YQoApNcPFROdWEnrIoL8HXnC8uHxWJKZaCSZMvJu/dpBuNPNfj
         ZiH1nSWVhdAb+AsiYQRX6cUwyTMLa31GxjGBoVxcnJdNf2ChtPAjMhuhybgRtBlbM+cO
         IXvKOvSZ2dn7CVKRCykSDEruFvXf0IVVMwF2gTOQCS+QzahGy9p+1X4LZAtaxJGRnZsx
         bEokVax2t1kSB5a+owJ1E/rO4zRZ2Xqh6TOIH/e47zGKVYvNH6IQyWRGDHZPN4sPDMt1
         NjY+LqI3c8o6hrHJ/uVJMq88OcsalNqpM3gO2A0GCxqrHp7HAbWHSl2RvLWc/7eacGYH
         hE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3+Q10qt8h6Nrtshd/+6BaS9xbma8WBq1l3GqLQ3g9zk=;
        b=qQQmUaSlXFDbnOBAzvZtMt5nYaTYvcEnO1e6HuVfsMUKRjZePba0JxCr6a8PUGyf01
         k3fnl8O8uI4QYiFsTjWlp9boxBNDrwP27XTcJeARDBs9oy6+HuGEnH63HvIboXvt3TMt
         CoX/zu39/SqOfEztX5jM8tU3KlF3sW5lzEGhQSk0qnNkOj44o5PDsvMqtH4Fm07YmdXn
         /T7EWku9ThCW4L+pD0RxSiig9gm+0o0axBWTdgDynFKXI788goku5L3kKQz9OekSs1hP
         MShZeSj5hLY+Z9gK+YeUNTx8OjNvdY8a3Z8EUn/ne+4jRPsYicjZSN1DzMIHUeaLZxyb
         yCNg==
X-Gm-Message-State: AOAM5332hurMI9fIldxgK3hK68yMVTnZAzlKMoKXELfpGQIt9tt5juqq
        gQ0yfLGcwES6sycUeUR3hKs=
X-Google-Smtp-Source: ABdhPJymrWqdaIU+iC8VNpY5u5S7OUXo2EJQGI3nm60R5cTpbsubsHBVOhanO8uqlG3MaSE8D3frSw==
X-Received: by 2002:a05:651c:149:: with SMTP id c9mr9563782ljd.441.1592852651856;
        Mon, 22 Jun 2020 12:04:11 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a17sm3639985lfo.73.2020.06.22.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:04:09 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 22 Jun 2020 21:04:06 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>, linux-mm@kvack.org
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
Message-ID: <20200622190406.GA3787@pc636>
References: <20200618173520.GC14613@pc636>
 <20200618175719.GT2723@paulmck-ThinkPad-P72>
 <20200618183448.GA15136@pc636>
 <20200618190359.GU2723@paulmck-ThinkPad-P72>
 <20200618203557.GB16976@pc636>
 <20200618203821.GU8681@bombadil.infradead.org>
 <20200618211709.GA17263@pc636>
 <20200618213427.GV2723@paulmck-ThinkPad-P72>
 <20200619154652.GA19990@pc636>
 <20200619162555.GJ2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619162555.GJ2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > > 
> > > Very good.  When does kfree_rcu() and friends move out of kernel/rcu?
> > > 
> > Do you mean to move the whole logic of kfree_rcu() from top to down to mm/?
> 
> I do mean exactly that.
> 
> That was my goal some years back when Rao Shoaib was making the first
> attempt along these lines, and it remains my goal.  After all, if this
> effort is at all successful, the coupling between kfree_rcu() with
> slab/slob/slub will become much tighter than that between kfree_rcu()
> and RCU.
> 
> There will need to be some additional RCU APIs used by kfree_rcu(),
> for example, something to tell RCU how many blocks are awaiting a
> grace period.  But these are narrow and easily defined APIs.
>
I also think that k[v]free_rcu() should reside somewhere under "mm/".
Currently they are defined as macros under "linux/rcupdate.h". So i
am not sure if definitions should stay there or moved also.

Implementation of the k[v]free_rcu() is under rcu/tree.c and for tiny
variant is under rcutiny.h. It can be moved to the mm/slab_common.c
or independent files can be created. I think, mm people should consult
what is the best way to go :)

Any thoughts on it?

Thank you!

--
Vlad Rezki
