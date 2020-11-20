Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266E0C56201
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 14:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BD22224C
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 14:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTlyczda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgKTOoT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 09:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgKTOoS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 09:44:18 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719A5C0617A7
        for <rcu@vger.kernel.org>; Fri, 20 Nov 2020 06:44:18 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id a13so9067294qkl.4
        for <rcu@vger.kernel.org>; Fri, 20 Nov 2020 06:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1CYOETxY2mWhhteoELoIdcbW6dqQyY7MF0yoQEntsU=;
        b=RTlyczdaOkh7geh5ZkV5GWqqUHxPFzM+/EHAond4ShJYOtFveN+sTMYTYpHgQ3qw9r
         4OCkjKwSJHsceu0+nXK8loM3AVTBFS75aQPAYKdJgOphR7CRICAABfzh2r1lr150wYko
         R+D3NyVAow6YMlcGvxOKbs41nuzOmhP+RWkQl7DrCHEGm0KGA0pr2pCv4AUF32psYd2Q
         MUv4Hz7kJrHs6Vr4QMJoQ57rfNDvVFd+jOm23dB4GkMajSHqjOrHjWK+/6LejpwZb2E8
         moGMGJMG9qiVmJOXe8kK1nAw7nH/ygEbeVvJccO1/wiK3Q7q4IPkor735omM5ig5how2
         iifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1CYOETxY2mWhhteoELoIdcbW6dqQyY7MF0yoQEntsU=;
        b=ntIJXBWkQwJOXMTctfNKmETJ3jvdKSCsFRrrvjm9CGh4NumyM+cz8v6MeUClNSeaOZ
         MdRIyms/bXfiGfCnWVIWL2tpHYFomz0aO9gxw4BoDkQbyFuH0Ulk5qa/AaGfUkvrvSuk
         mnUDfGmPKA5HEmR7n4S401MV3+jIRcVhKpAQuXASvhI5daj/iY+1/OY5htX1qA3Z5njF
         roLRpnI51YUxD1uCob2mQZLTpQvvah5JhLrytI0hK5XfcxZUU/lChkJKhNRYd/s+RhC8
         i8W4GgDIAVzxhn6MTFDApKVhy+lyMzXTjHolIFb5YVtjbEAnSJl7WgMr9BoL1SXW7EnZ
         6i1w==
X-Gm-Message-State: AOAM5306kbyyi7+1Hg99+pguGxjYCCMqO5ma1s1aqLxaTAcS/gSPt+3w
        ld/UTD7wrc6Q+wBsg2HreCdTwRJH6ezRnLG8nBy5TA==
X-Google-Smtp-Source: ABdhPJwZrlT2iMbWNY1ZMJAir2bIhu343U9ppzqmXLgR+ajdYkR5kBk2dzPNIsC8Na83xEoHeqe293oVTudB3x2YG5E=
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr17381328qkm.231.1605883457341;
 Fri, 20 Nov 2020 06:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20201118035309.19144-1-qiang.zhang@windriver.com>
 <20201119214934.GC1437@paulmck-ThinkPad-P72> <CACT4Y+bas5xfc-+W+wkpbx6Lw=9dsKv=ha83=hs1pytjfK+drg@mail.gmail.com>
 <20201120143440.GF1437@paulmck-ThinkPad-P72>
In-Reply-To: <20201120143440.GF1437@paulmck-ThinkPad-P72>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Nov 2020 15:44:04 +0100
Message-ID: <CACT4Y+ZNBRaVOK4zjv7WyyJKeS54OL8212EtjQHshYDeOVmCGQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: kasan: record and print kvfree_call_rcu call stack
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Zhang, Qiang" <qiang.zhang@windriver.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 20, 2020 at 3:34 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Nov 20, 2020 at 09:51:15AM +0100, Dmitry Vyukov wrote:
> > On Thu, Nov 19, 2020 at 10:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Wed, Nov 18, 2020 at 11:53:09AM +0800, qiang.zhang@windriver.com wrote:
> > > > From: Zqiang <qiang.zhang@windriver.com>
> > > >
> > > > Add kasan_record_aux_stack function for kvfree_call_rcu function to
> > > > record call stacks.
> > > >
> > > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > >
> > > Thank you, but this does not apply on the "dev" branch of the -rcu tree.
> > > See file:///home/git/kernel.org/rcutodo.html for more info.
> > >
> > > Adding others on CC who might have feedback on the general approach.
> > >
> > >                                                         Thanx, Paul
> > >
> > > > ---
> > > >  kernel/rcu/tree.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index da3414522285..a252b2f0208d 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3506,7 +3506,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >               success = true;
> > > >               goto unlock_return;
> > > >       }
> > > > -
> > > > +     kasan_record_aux_stack(ptr);
> > > >       success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> > > >       if (!success) {
> > > >               run_page_cache_worker(krcp);
> >
> > kvfree_call_rcu is intended to free objects, right? If so this is:
>
> True, but mightn't there still be RCU readers referencing this object for
> some time, as in up to the point that the RCU grace period ends?  If so,
> won't adding this cause KASAN to incorrectly complain about those readers?
>
> Or am I missing something here?

kvfree_call_rcu does not check anything, not poison the object for
future accesses (it is also called in call_rcu which does not
necessarily free the object).
It just notes the current stack to provide in reports later.
The problem is that the free stack is pointless for objects freed by
rcu. In such cases we want call_rcu/kvfree_call_rcu stack in
use-after-free reports.
