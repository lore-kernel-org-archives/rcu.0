Return-Path: <SRS0=4XKx=DI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9ACC4727E
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 20:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB4E207FB
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 20:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNlY674Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgJAUDl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Oct 2020 16:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgJAUDl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Oct 2020 16:03:41 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104F5C0613D0;
        Thu,  1 Oct 2020 13:03:41 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 77so161470lfj.0;
        Thu, 01 Oct 2020 13:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6lIR/ee296C9XxYkgHm5Us45XR5lJuIvK5IgAyTCrlA=;
        b=aNlY674YTggcU/ssLDopDgaM5YV8/yf7/ip0U2L4i1T6Cf1JFuytdgiaxjV98DnMwv
         8hYHJju9GsRiJkjNhiyuLfY9vP+vGdda8b1tr6i8iT9jm3sBHWrKyGN1VMfIpDoQeacm
         8+CKjZxKbFipUewIBFz6hPO5UWO9AlkiabCSqS/6KBbEvkgJqNwrgl65Gv6etMA3Owfd
         RaJF+/Jm5sR+9J4DWYfDB3617aR+hz0X26TwdsTktd0EgxV2v6w1/pl+vjhkCCUEOES0
         1sNT5ULCqmUcb+a0kOQnfmKcgVtQ9NPoVxzg34wIo8VCnbkcQbIKE/7thkK7I5hjXGCQ
         4Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6lIR/ee296C9XxYkgHm5Us45XR5lJuIvK5IgAyTCrlA=;
        b=FJKBmOgd9R34914woZMVcufP3+M6M9cX2WjiJQDs8uWEk86FU5rRmEKm8/gY4Q1WUA
         +3gaOhJoimAIyTIeuBMqd5E4w2uv9Vw5nYeU8fA0d8jWvJfkfqGBRqoA/OOx/D6C9umB
         IjxkhO1Xx6X2u/4aJjeUQvZEjvbvLrwmuRsnG/xz+IYaUtZ5IOQ2K/tpi0tXX9jdZPv+
         u/zjq7iU+0fTy4slCQCVWdh7lqwDxVmN/5SzPmPSfga377AXusdPRIkRk17TG52GTmFe
         z9x4RRjb4LVXCuh9kEQ8d810JfzLuDif0uvz/dEVssmF+J0px+Iwo9lw9pqTGpOdyfa5
         qX8Q==
X-Gm-Message-State: AOAM532VLKATKiJq/B7IqTvsl6RUBYQYBYUkNg46hxbO8N1IIQzINPF8
        im2w9pFZaJhefV28wvuGa5g=
X-Google-Smtp-Source: ABdhPJybjtGv2jZJNmhMCzZ6NHUON8ZIMxH6cvUGGMjzvGsqziHXtFGOhDvLI5FJCiJYlr8NhsmVew==
X-Received: by 2002:ac2:420f:: with SMTP id y15mr2900583lfh.489.1601582619418;
        Thu, 01 Oct 2020 13:03:39 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id v17sm685561lfr.42.2020.10.01.13.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 13:03:38 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 1 Oct 2020 22:03:36 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 14/15] rcu/tree: Allocate a page when caller
 is preemptible
Message-ID: <20201001200336.GA30686@pc636>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
 <20200928233102.24265-14-paulmck@kernel.org>
 <20200929120756.GC2277@dhcp22.suse.cz>
 <20200930015327.GX29330@paulmck-ThinkPad-P72>
 <20200930084139.GN2277@dhcp22.suse.cz>
 <20200930232154.GA29330@paulmck-ThinkPad-P72>
 <20201001090220.GA22560@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001090220.GA22560@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 01, 2020 at 11:02:20AM +0200, Michal Hocko wrote:
> On Wed 30-09-20 16:21:54, Paul E. McKenney wrote:
> > On Wed, Sep 30, 2020 at 10:41:39AM +0200, Michal Hocko wrote:
> > > On Tue 29-09-20 18:53:27, Paul E. McKenney wrote:
> [...]
> > > > No argument on it being confusing, and I hope that the added header
> > > > comment helps.  But specifically, can_sleep==true is a promise by the
> > > > caller to be schedulable and not to be holding any lock/mutex/whatever
> > > > that might possibly be acquired by the memory allocator or by anything
> > > > else that the memory allocator might invoke, to your point, including
> > > > for but one example the reclaim logic.
> > > > 
> > > > The only way that can_sleep==true is if this function was invoked due
> > > > to a call to single-argument kvfree_rcu(), which must be schedulable
> > > > because its fallback is to invoke synchronize_rcu().
> > > 
> > > OK. I have to say that it is still not clear to me whether this call
> > > path can be called from the memory reclaim context. If yes then you need
> > > __GFP_NOMEMALLOC as well.
> > 
> > Right now the restriction is that single-argument (AKA can_sleep==true)
> > kvfree_rcu() cannot be invoked from memory reclaim context.
> > 
> > But would adding __GFP_NOMEMALLOC to the can_sleep==true GFP_ flags
> > allow us to remove this restriction?  If so, I will queue a separate
> > patch making this change.  The improved ease of use would be well
> > worth it, if I understand correctly (ha!!!).
> 
> It would be quite daring to claim it will be ok but it will certainly be
> less problematic. Adding the flag will not hurt in any case. As this is
> a shared called that might be called from many contexts I think it will
> be safer to have it there. The justification is that it will prevent
> consumption of memory reserves from MEMALLOC contexts.
> 
> > 
> > > [...]
> > > 
> > > > > What is the point of calling kmalloc  for a PAGE_SIZE object? Wouldn't
> > > > > using the page allocator directly be better?
> > > > 
> > > > Well, you guys gave me considerable heat about abusing internal allocator
> > > > interfaces, and kmalloc() and kfree() seem to be about as non-internal
> > > > as you can get and still be invoking the allocator.  ;-)
> > > 
> > > alloc_pages resp. __get_free_pages is a normal page allocator interface
> > > to use for page size granular allocations. kmalloc is for more fine
> > > grained allocations.
> > 
> > OK, in the short term, both work, but I have queued a separate patch
> > making this change and recording the tradeoffs.  This is not yet a
> > promise to push this patch, but it is a promise not to lose this part
> > of the picture.  Please see below.
> 
> It doesn't matter all that much. Both allocators will work. It is just a
> matter of using optimal tool for the specific purose.
> 
> > You mentioned alloc_pages().  I reverted to __get_free_pages(), but
> > alloc_pages() of course looks nicer.  What are the tradeoffs between
> > __get_free_pages() and alloc_pages()?
> 
> alloc_pages will return struct page but you need a kernel pointer. That
> is what __get_free_pages will give you (or you can call page_address
> directly).
> 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 490b638d7c241ac06cee168ccf8688bb8b872478
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Wed Sep 30 16:16:39 2020 -0700
> > 
> >     kvfree_rcu(): Switch from kmalloc/kfree to __get_free_page/free_page.
> >     
> >     The advantages of using kmalloc() and kfree() are a possible small speedup
> >     on CONFIG_SLAB=y systems, avoiding the allocation-side cast, and use of
> >     more-familiar API members.  The advantages of using __get_free_page()
> >     and free_page() are a possible reduction in fragmentation and direct
> >     access to the buddy allocator.
> >     
> >     To help settle the question as to which to use, this commit switches
> >     from kmalloc() and kfree() to __get_free_page() and free_page().
> >     
> >     Suggested-by: Michal Hocko <mhocko@suse.com>
> >     Suggested-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Yes, looks good to me. I am not entirely sure about the fragmentation
> argument. It really depends on the SL.B allocator internals. The same
> applies for the potential speed up. I would be even surprised if the
> SLAB was faster in average considering it has to use the page allocator
> as well. So to me the primary motivation would be "use the right tool
> for the purpose".
> 
As for raised a concern about fragmentation, i mostly was thinking about
that SLAbs where not designed to do an efficient allocations for sizes
which are >= than PAGE_SIZE. But it depends on three different
implementations, actually it also a good argument to switch to the page
allocator. I mean to get rid of such dependency.

Other side is, SLABs, at least SLAB and SLUB use slab-caches and sizes
which they support include up to:

<snip>
kmalloc-8k           420    420   8192    4
kmalloc-4k          1372   1392   4096    8    8 : tunables    0    0
...
<snip>

I would no be surprised that SLAB is faster than using the page allocator
in _some_ sense. If it is principle i can double check. I can explain it
just in having dynamic caching that can grow based on demand, thus there
is no need to go deeper to page allocator if the kmalloc-4k has extra
objects. But the worst case of course will be slower :)

--
Vlad Rezki
