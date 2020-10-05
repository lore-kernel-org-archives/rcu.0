Return-Path: <SRS0=BSCp=DM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF63C4363A
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 18:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B1D20B80
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601923752;
	bh=RyiEHfiF6hosv8zbGIeP+MtyKE6W2/2vsB1r59Ua2IE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=RS8bDyQ0rpLckxgFpepUC1zd89lmjUBrLqxXDpE2MT3ejcH62gGs5oEE/WOWQQngC
	 I1Jp7GNRKUct0TjIclj1+U5tEfN6hCeqFsbnoDZBeVcBrChxdqOPK+/KApI4WoZsVr
	 UAiMRJSm+w6sgD0e556YsqhGcZtq8H1xq64Cj/1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgJEStL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Oct 2020 14:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbgJEStL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Oct 2020 14:49:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6ED820853;
        Mon,  5 Oct 2020 18:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601923750;
        bh=RyiEHfiF6hosv8zbGIeP+MtyKE6W2/2vsB1r59Ua2IE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f8P0BfJ2Y3hpZROavK1XThuCq6LEYgrYxC/6puNZoiecqPb+Ijxws/vqup1whzANL
         NisRimxmmQcynu7+3AaDMvfPNiiV+onZQj6v3U27rLtBSRkIoyrWR6jaTr+3u7eDe2
         xTD+ZKLRiyKlYs5AOcz1eg9IJGeDFWRdUBbjiPt0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 558E6352301E; Mon,  5 Oct 2020 11:49:10 -0700 (PDT)
Date:   Mon, 5 Oct 2020 11:49:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] srcu: avoid escaped section names
Message-ID: <20201005184910.GC29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com>
 <20200930204044.GZ29330@paulmck-ThinkPad-P72>
 <CAKwvOd=nabONrWyYFK7Y06TrKBOyHHfNUiiy69VJQ2NtCpbp5Q@mail.gmail.com>
 <20201002205130.GK29330@paulmck-ThinkPad-P72>
 <CAKwvOdkPMSwQneMLFNg3ihM5zHorFy+uGvzAL7y70+hu_1q24w@mail.gmail.com>
 <CA+icZUW_z5nJ1c69JS7Nm1QknF+CH+sPkhF4g2+L=d=H-vxVgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUW_z5nJ1c69JS7Nm1QknF+CH+sPkhF4g2+L=d=H-vxVgw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 05, 2020 at 08:38:42PM +0200, Sedat Dilek wrote:
> On Mon, Oct 5, 2020 at 8:29 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Fri, Oct 2, 2020 at 1:51 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Wed, Sep 30, 2020 at 01:55:48PM -0700, Nick Desaulniers wrote:
> > > > On Wed, Sep 30, 2020 at 1:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Tue, Sep 29, 2020 at 12:25:49PM -0700, Nick Desaulniers wrote:
> > > > > > The stringification operator, `#`, in the preprocessor escapes strings.
> > > > > > For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> > > > > > they treat section names that contain \".
> > > > > >
> > > > > > The portable solution is to not use a string literal with the
> > > > > > preprocessor stringification operator.
> > > > > >
> > > > > > Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> > > > > > Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
> > > > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > >
> > > > > I am guessing that this needs to go up with other patches.  If so:
> > > > >
> > > > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > > > >
> > > > > If not, let me know and I will queue it.
> > > >
> > > > I could have bundled them up as a series.  I think you can pick it up,
> > > > and I'll owe you a beer?
> > >
> > > It is queued, thank you!
> > >
> > > When does it need to hit mainline?  (Your default is the v5.11 merge
> > > window, that is, the one following the upcoming merge window.)
> >
> > No rush, this patch wasn't blocking any known issue, just a cleanup
> > while I was in the neighborhood.  100 years ago, I was an Eagle scout.
> > Pretty sure there was a motto about "leaving things better than you
> > found them."  Thanks for help resolving the merge conflict reported in
> > -next related to it.
> 
> Wasn't there a problem with your "Fixes:" tag (Fixes: *drop word
> "commit"* commit_hashid ("...")?

Indeed there was, and I have it noted to be fixed on my next rebase.

Perhaps another reason not to rush to mainline though.  ;-)

							Thanx, Paul

> - Sedat -
> 
> > >
> > >
> > >                                                         Thanx, Paul
> > >
> > > > > > ---
> > > > > > Changes V1->V2:
> > > > > > * drop unrelated Kconfig changes accidentally committed in v1.
> > > > > >
> > > > > >  include/linux/srcutree.h | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > > > > index 9cfcc8a756ae..9de652f4e1bd 100644
> > > > > > --- a/include/linux/srcutree.h
> > > > > > +++ b/include/linux/srcutree.h
> > > > > > @@ -124,7 +124,7 @@ struct srcu_struct {
> > > > > >  # define __DEFINE_SRCU(name, is_static)                                      \
> > > > > >       is_static struct srcu_struct name;                              \
> > > > > >       struct srcu_struct * const __srcu_struct_##name                 \
> > > > > > -             __section("___srcu_struct_ptrs") = &name
> > > > > > +             __section(___srcu_struct_ptrs) = &name
> > > > > >  #else
> > > > > >  # define __DEFINE_SRCU(name, is_static)                                      \
> > > > > >       static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);      \
> > > > > > --
> > > > > > 2.28.0.709.gb0816b6eb0-goog
> > > > > >
> > > >
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > > ~Nick Desaulniers
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAKwvOdkPMSwQneMLFNg3ihM5zHorFy%2BuGvzAL7y70%2Bhu_1q24w%40mail.gmail.com.
