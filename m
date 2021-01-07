Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE7CC433E0
	for <rcu@archiver.kernel.org>; Thu,  7 Jan 2021 07:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43F823101
	for <rcu@archiver.kernel.org>; Thu,  7 Jan 2021 07:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbhAGH3K (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Jan 2021 02:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbhAGH3K (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Jan 2021 02:29:10 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEBBC0612F4;
        Wed,  6 Jan 2021 23:28:29 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e7so5839119ile.7;
        Wed, 06 Jan 2021 23:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MoGDsl5I+YcN0IWYAgAq72CINUnBVdCjNTtJbNncD7w=;
        b=ilGvzUPAd3FxIi8PwoQSwlVafV0DI/HPubH4tfYQnKe9/Vtp/uBcTfd2Mpl2MnXLSW
         IS9JBobOIWXwGdYOiVjpX7Lj671/acTDSBjcTOP6JCHVrhmAkHVC5fHQebfD0+y1kXki
         MKhS5f2OBivX8YxKSCg3b6IULevdsW2LzXNpCu0PE+xLuuIxHil5XnUWBAKJcm12l26e
         QLHvSg2zSMvfu7R+lydC4mkEZ4pJ0MCZ8d+p67HqayCXUGSIqiTiDfy75yA7vhdbaLm7
         7VUHvz4JOYRhmQ4TTHoUSdyMVv7AKDgSpllrJcMHN8picPbBaZXxNh65XamXbyEGsCrE
         /hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoGDsl5I+YcN0IWYAgAq72CINUnBVdCjNTtJbNncD7w=;
        b=L54c9BYuJUgiWQ0GUuw9VT7J2e8uM3GTEaM1mHn66DAbXllbpv2DW1N5HtbhzPRMQk
         56GcL8bGq7hQTSLEvuseTI68MQTQQhddRXCjPuA7wTbDil1k++4xfy3JIGcIxCOOCUN8
         YoRohtzc2c+Bz4BFsH5nwlxXSCEW7tLOdW9U54bfaiJEQ0luCb685laxM34RhuBb+2Fh
         wlAcZUmd7yuDJlxtrI8b4hRg8ijfpLFb9dY9Fm7FSCExFmrBFZU8Q/g2thMFQqeiKpVp
         P+SnRue8JrZDCGYtmwojEOf/bltGnnegRMkN+GCiwbW910qRPxxOUAAEovr+jDq4sR24
         KVNw==
X-Gm-Message-State: AOAM531TWC1uMR4uK2VIdFVLglYojHHtXKI94ROADdFrU0TUBrO0ah8y
        /DkhznHn842nalC3Q1J2vej+YGfAdUsOYFiSOhWOKOdJOqsDJg==
X-Google-Smtp-Source: ABdhPJzvqU70c1FAJZFHcYEV3hOlPNwntmXo6l/mav4V3BdPB03pEzNTipZhBJwUmeSeeqDVN8h3z2p5RjHNSiN5JuI=
X-Received: by 2002:a92:b652:: with SMTP id s79mr7948622ili.251.1610004509230;
 Wed, 06 Jan 2021 23:28:29 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMygqbupE_6CK92=PwLw4DjnSuo9-+6iHs_DrZeZ55iRKg@mail.gmail.com>
 <20210105131441.GA2457@pc638.lan> <20210105145659.GD17086@paulmck-ThinkPad-P72>
 <20210105162919.GA1800@pc638.lan>
In-Reply-To: <20210105162919.GA1800@pc638.lan>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 7 Jan 2021 08:28:18 +0100
Message-ID: <CAKXUXMx6mjMz=RejEpL-VZQYp8MTkpU=9qMgvKAVsnpqGqkFkw@mail.gmail.com>
Subject: Re: kerneldoc warnings since commit 538fc2ee870a3 ("rcu: Introduce
 kfree_rcu() single-argument macro")
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 5, 2021 at 5:29 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Tue, Jan 05, 2021 at 06:56:59AM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 05, 2021 at 02:14:41PM +0100, Uladzislau Rezki wrote:
> > > Dear, Lukas.
> > >
> > > > Dear Uladzislau,
> > > >
> > > > in commit 538fc2ee870a3 ("rcu: Introduce kfree_rcu() single-argument
> > > > macro"), you have refactored the kfree_rcu macro.
> > > >
> > > > Since then, make htmldocs warns:
> > > >
> > > > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > > > 'ptr' description in 'kfree_rcu'
> > > > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > > > 'rhf' description in 'kfree_rcu'
> > > >
> > > > As you deleted the two arguments in the macro definition, kerneldoc
> > > > cannot resolve the argument names in the macro's kerneldoc
> > > > documentation anymore and warns about that.
> > > >
> > > > Probably, it is best to just turn the formal kerneldoc references to
> > > > the two arguments, which are not used in the macro definition anymore,
> > > > simply into two informal references in the documentation.
> > > >
> > > Thanks for your suggestion. I am not sure if htmldocs supports something
> > > like "__maybe_unused", but tend to say that it does not. See below the
> > > patch:
> > >
> > > <snip>
> > > >From 65ecc7c58810c963c02e0596ce2e5758c54ef55d Mon Sep 17 00:00:00 2001
> > > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > > Date: Tue, 5 Jan 2021 13:23:30 +0100
> > > Subject: [PATCH] rcu: fix kerneldoc warnings
> > >
> > > After refactoring of the kfree_rcu(), it becomes possible to use
> > > the macro with one or two arguments. From the other hand, in the
> > > description there are two arguments in the macro definition expected.
> > > That is why the "htmldocs" emits a warning about it:
> > >
> > > <snip>
> > > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > > 'ptr' description in 'kfree_rcu'
> > > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > > 'rhf' description in 'kfree_rcu'
> > > <snip>
> > >
> > > Fix it by converting two parameters into informal references in the
> > > macro description.
> > >
> > > Fixes: 3d3d9ff077a9 ("rcu: Introduce kfree_rcu() single-argument macro")
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  include/linux/rcupdate.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index ebd8dcca4997..e678ce7f5ca2 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -854,8 +854,8 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
> > >
> > >  /**
> > >   * kfree_rcu() - kfree an object after a grace period.
> > > - * @ptr: pointer to kfree for both single- and double-argument invocations.
> > > - * @rhf: the name of the struct rcu_head within the type of @ptr,
> > > + * ptr: pointer to kfree for both single- and double-argument invocations.
> > > + * rhf: the name of the struct rcu_head within the type of ptr,
> > >   *       but only for double-argument invocations.
> > >   *
> > >   * Many rcu callbacks functions just call kfree() on the base structure.
> > > --
> > > 2.20.1
> > > <snip>
> > >
> > > Paul, does it work for you?
> >
> > If it works for the documentation generation, then it works for me.  ;-)
> >
> OK. Then we need the patch to be reviewed by the documentation generation :)
>
> Dear, linux-doc folk!
>
> Could you please review the patch that is in question?
>

I think you can shorten the feedback loop.
IMHO, the documentation is as comprehensible as before and it makes a
warning go away (getting us back to the zero-documentation-warnings
state).

Just send out your patch with linux-doc as CC and if there is no
complaint within a few days, Paul will pick it up and it is all good.

Lukas
