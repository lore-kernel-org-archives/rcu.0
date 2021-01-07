Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09702C433DB
	for <rcu@archiver.kernel.org>; Thu,  7 Jan 2021 13:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CD42335A
	for <rcu@archiver.kernel.org>; Thu,  7 Jan 2021 13:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhAGNBN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Jan 2021 08:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbhAGNBM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Jan 2021 08:01:12 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ECEC0612F4;
        Thu,  7 Jan 2021 05:00:32 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o13so14391379lfr.3;
        Thu, 07 Jan 2021 05:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TkASo//sn8i/yW+hfEBNYyiHN5qe/cjtYlxBSTVQkd4=;
        b=nAYEvj9xsyoM+/zGhAyeNbgVtKbKe6QYggwtTcD8l6ZDhOclHyd4qFoiqXnv1cxiJl
         AVf+WqSJkth0BXs5Tq/ViKOeDFewMaZCFDHsnDNWMaK8qfdWpdm/mx88ScZa/RxBNcnQ
         /e7eMAVfN3MqtKa8rebK9PNs5ghqndoefx4D0TP/q0oxrncFRX8rnsAZFdEX6ICpjv0q
         K0T/3IgkMeDhUTeC1q8pl3dfMd8owCu7Pbi55g/MLyjx9XQdaumuBbYr1lBpBLXOEFmN
         dMIyWvmbYXWTWuhRFA7dQk2jGkrDvdZ8u2C1vZTsZ50NAplGPVQnlXPbJzWg8r8GOUUy
         r60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TkASo//sn8i/yW+hfEBNYyiHN5qe/cjtYlxBSTVQkd4=;
        b=PynYM4/RehY+6YghEuM9OcVSIGCStcSXa6kTIRrhQCwQUpAhCr3Z9nFtCIl3b+KR6U
         CArb26goKt7wA7KE2ZgQAA4fM4OnPutkmosZjwsD8C2D/UggRsFwnj5jDMtGE2fJZkdf
         oGDRj/HaCZ2qIELHEZ5m8K2n9NvQehsdeIvkFea0PnkfJkzprO1xkIfV47330q0R7HM8
         ij33XA71ZuiWGRmiYMWBnl5JLNuQY2ThAgWRlBsoP3Maudox35BtcDYgRiGVDMza/Phu
         Helv7l1U92UGRIFLQmFr0IYeg/Fb2HEtw9LShSrm+fqfvFenJHtuSWYmEaTAR7DmQBHf
         gGKw==
X-Gm-Message-State: AOAM532MBL5jSg5AaSxeKEg4GygSfUNM8r8xCiB8qF6R1tipnxQX/RTp
        ebEbULwMx4Mf3mExcQ+ehcw=
X-Google-Smtp-Source: ABdhPJwOT9CXhrkxhoUs6YE1a7Zt7DFxjgk6IVzpGCZWQkhic0Gin0Hker1vWT4VlMnxh50M4QxRqg==
X-Received: by 2002:a05:651c:1047:: with SMTP id x7mr4384446ljm.114.1610024430533;
        Thu, 07 Jan 2021 05:00:30 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t4sm1132328lff.260.2021.01.07.05.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:00:29 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 7 Jan 2021 14:00:28 +0100
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: kerneldoc warnings since commit 538fc2ee870a3 ("rcu: Introduce
 kfree_rcu() single-argument macro")
Message-ID: <20210107130028.GA1874@pc638.lan>
References: <CAKXUXMygqbupE_6CK92=PwLw4DjnSuo9-+6iHs_DrZeZ55iRKg@mail.gmail.com>
 <20210105131441.GA2457@pc638.lan>
 <20210105145659.GD17086@paulmck-ThinkPad-P72>
 <20210105162919.GA1800@pc638.lan>
 <CAKXUXMx6mjMz=RejEpL-VZQYp8MTkpU=9qMgvKAVsnpqGqkFkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMx6mjMz=RejEpL-VZQYp8MTkpU=9qMgvKAVsnpqGqkFkw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> On Tue, Jan 5, 2021 at 5:29 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Tue, Jan 05, 2021 at 06:56:59AM -0800, Paul E. McKenney wrote:
> > > On Tue, Jan 05, 2021 at 02:14:41PM +0100, Uladzislau Rezki wrote:
> > > > Dear, Lukas.
> > > >
> > > > > Dear Uladzislau,
> > > > >
> > > > > in commit 538fc2ee870a3 ("rcu: Introduce kfree_rcu() single-argument
> > > > > macro"), you have refactored the kfree_rcu macro.
> > > > >
> > > > > Since then, make htmldocs warns:
> > > > >
> > > > > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > > > > 'ptr' description in 'kfree_rcu'
> > > > > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > > > > 'rhf' description in 'kfree_rcu'
> > > > >
> > > > > As you deleted the two arguments in the macro definition, kerneldoc
> > > > > cannot resolve the argument names in the macro's kerneldoc
> > > > > documentation anymore and warns about that.
> > > > >
> > > > > Probably, it is best to just turn the formal kerneldoc references to
> > > > > the two arguments, which are not used in the macro definition anymore,
> > > > > simply into two informal references in the documentation.
> > > > >
> > > > Thanks for your suggestion. I am not sure if htmldocs supports something
> > > > like "__maybe_unused", but tend to say that it does not. See below the
> > > > patch:
> > > >
> > > > <snip>
> > > > >From 65ecc7c58810c963c02e0596ce2e5758c54ef55d Mon Sep 17 00:00:00 2001
> > > > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > > > Date: Tue, 5 Jan 2021 13:23:30 +0100
> > > > Subject: [PATCH] rcu: fix kerneldoc warnings
> > > >
> > > > After refactoring of the kfree_rcu(), it becomes possible to use
> > > > the macro with one or two arguments. From the other hand, in the
> > > > description there are two arguments in the macro definition expected.
> > > > That is why the "htmldocs" emits a warning about it:
> > > >
> > > > <snip>
> > > > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > > > 'ptr' description in 'kfree_rcu'
> > > > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > > > 'rhf' description in 'kfree_rcu'
> > > > <snip>
> > > >
> > > > Fix it by converting two parameters into informal references in the
> > > > macro description.
> > > >
> > > > Fixes: 3d3d9ff077a9 ("rcu: Introduce kfree_rcu() single-argument macro")
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  include/linux/rcupdate.h | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > index ebd8dcca4997..e678ce7f5ca2 100644
> > > > --- a/include/linux/rcupdate.h
> > > > +++ b/include/linux/rcupdate.h
> > > > @@ -854,8 +854,8 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
> > > >
> > > >  /**
> > > >   * kfree_rcu() - kfree an object after a grace period.
> > > > - * @ptr: pointer to kfree for both single- and double-argument invocations.
> > > > - * @rhf: the name of the struct rcu_head within the type of @ptr,
> > > > + * ptr: pointer to kfree for both single- and double-argument invocations.
> > > > + * rhf: the name of the struct rcu_head within the type of ptr,
> > > >   *       but only for double-argument invocations.
> > > >   *
> > > >   * Many rcu callbacks functions just call kfree() on the base structure.
> > > > --
> > > > 2.20.1
> > > > <snip>
> > > >
> > > > Paul, does it work for you?
> > >
> > > If it works for the documentation generation, then it works for me.  ;-)
> > >
> > OK. Then we need the patch to be reviewed by the documentation generation :)
> >
> > Dear, linux-doc folk!
> >
> > Could you please review the patch that is in question?
> >
> 
> I think you can shorten the feedback loop.
> IMHO, the documentation is as comprehensible as before and it makes a
> warning go away (getting us back to the zero-documentation-warnings
> state).
> 
> Just send out your patch with linux-doc as CC and if there is no
> complaint within a few days, Paul will pick it up and it is all good.
> 
Yep, this is what i was going to do it if no any feedback.

Thanks.

--
Vlad Rezki
