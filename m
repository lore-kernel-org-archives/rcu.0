Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E88C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3029220890
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZTh/FsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgFRUDm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgFRUDl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 16:03:41 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655DEC06174E;
        Thu, 18 Jun 2020 13:03:41 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so8790551ljh.7;
        Thu, 18 Jun 2020 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xY2HlaoZmjAUGYdihKpKBP2AgWF7hu3wdXSeYzOnmxw=;
        b=aZTh/FsJiZ5SD2HR+wSHizlouOjCpprPqkaO6K7VCoUivCKDqeLnncjaUB1vZTOpgP
         F2/DxicoJsbd3MQGD1l5dhb7Fxy4M6+G96bwagnKmLF8RhNq1Q7gPwmHNY38jxHchvM0
         wMyDeLHWCmwQPTr8CN9pj99lDo1BU2EWpNvJua5F1KqY4XrFA6NY4fI4g8piLTmAekBN
         +yMl6Nq2XiofgZ7cXsRtt6HEQ9szs9yvpBWI0G3l0Sh75qOA/Il1volU1dQOsKxnznyc
         z6ye/WJBA8e+VpAVb0rcbuGPprWnxz42B2owD8QlMMnVnzD6khNCHCusmgaVGyFKq+qt
         LGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xY2HlaoZmjAUGYdihKpKBP2AgWF7hu3wdXSeYzOnmxw=;
        b=WED+xD0n5Q9F0+mwU0rrtIvMDsqeO14G+S4WZcPAukJqZnqoERHQhhaJA9zCPU+nbj
         mXrjQJKJ5cjRzodzeAV0qANcUSLMmW0/MPZizOkjeTKYf24WBw2sNIzclsNryP8bMh9H
         CWiXlIuvsQDv9dCTNJnLoqs8P/Xgezbpo3+gQQ3KzcVDezT95CAMRkrl15w5PEoKhv/b
         clTkWnTXLwAiW69005G4tkfxOs7UN9j1Tt+0G4oQSo0WeFR9i7Pk4/r5Z/aqe5Pm0L4V
         F0wws03dJAIgGNFGmF8xMkuDIVQSK1JA6yEvmABFmzAdiCQsw5uu8xkxZiQ2tK3+syDR
         v/3A==
X-Gm-Message-State: AOAM531cKW76FoF+FC/pP8sqTjp1zGqs0U3mOAXxsL4gxIPe4cUU7RTL
        REOTGZ/llhv4IwStUYIBwLQ=
X-Google-Smtp-Source: ABdhPJwvDka/mu2unJaC+48s8sys0a9/bvBa/N3yCvh4tyOHu1/jfxDrJbZyZcwjoCv4Fg8Uh45pXw==
X-Received: by 2002:a2e:954c:: with SMTP id t12mr20653ljh.287.1592510619839;
        Thu, 18 Jun 2020 13:03:39 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s62sm472931lja.100.2020.06.18.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:03:36 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 18 Jun 2020 22:03:33 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618200333.GA16976@pc636>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618005214.GN8681@bombadil.infradead.org>
 <20200618173049.GB14613@pc636>
 <20200618173527.GR8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618173527.GR8681@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 10:35:27AM -0700, Matthew Wilcox wrote:
> On Thu, Jun 18, 2020 at 07:30:49PM +0200, Uladzislau Rezki wrote:
> > > I'd suggest:
> > > 
> > >  			rcu_lock_acquire(&rcu_callback_map);
> > > 			trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
> > > 				bkvhead[i]->nr_records, bkvhead[i]->records);
> > >  			if (i == 0) {
> > >  				kfree_bulk(bkvhead[i]->nr_records,
> > >  					bkvhead[i]->records);
> > >  			} else {
> > >  				for (j = 0; j < bkvhead[i]->nr_records; j++) {
> > >  					vfree(bkvhead[i]->records[j]);
> > >  				}
> > >  			}
> > >  			rcu_lock_release(&rcu_callback_map);
> > >
> > There are two different trace functions, one for "bulk" tracing
> > messages, and another one is per one call of kfree(), though we use 
> > to indicate vfree() call.
> > 
> > Probably we can rename it to: trace_rcu_invoke_kvfree_callback();
> > 
> > What do you think?
> 
> Works for me!
> 
OK. I will send out the patch that will rename that trace function
that makes clear that the pointer that is freed can belong to SLAB
or vmalloc.

> > > But I'd also suggest a vfree_bulk be added.  There are a few things
> > > which would be better done in bulk as part of the vfree process
> > > (we batch them up already, but i'm sure we could do better).
> > 
> > I was thinking to implement of vfree_bulk() API, but i guess it can
> > be done as future work.
> > 
> > Does that sound good?
> 
> Yes, definitely a future piece of work.
>
You have already been doing it.

Thank you, Matthew :)

--
Vlad Rezki
