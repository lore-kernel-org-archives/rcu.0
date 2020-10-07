Return-Path: <SRS0=by5p=DO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6067BC4363C
	for <rcu@archiver.kernel.org>; Wed,  7 Oct 2020 21:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1D720872
	for <rcu@archiver.kernel.org>; Wed,  7 Oct 2020 21:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602104705;
	bh=XuzH5blWHlB+mMmnzqx+vTR+L4nIxHQHXzopJDP9T6c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=iuQmotDKNTwyyr6Gb9D6lBxvXWkYMwnEgyUfjwhFw4KJ8I6SbbhqZAZEiAsJ/690K
	 Y6kbk/N8FZz8UK/cgwSecMpSlKh6jQIHWOeCHzD+Db+l28mahKDDb1aptAiYFMhtyc
	 M102D4p0oiy7kb/h1fNLV+0xTCyEphpoB+TobmmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgJGVFE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 7 Oct 2020 17:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgJGVFE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 7 Oct 2020 17:05:04 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D40A2083B;
        Wed,  7 Oct 2020 21:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602104703;
        bh=XuzH5blWHlB+mMmnzqx+vTR+L4nIxHQHXzopJDP9T6c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VhX4nlu/c0Wk6+Td2+6byKSsBxCZ8w0R96WYH70E77KiYjTgpMHgJQHU067CJp9o3
         aaGbtFNqeXLmxazip/eD005dAwErHTM10n11kNTT+PB98OC/iNJ5AyNUx+yzPc0uEZ
         zDJvadSUUqyVrYb9W/aLWDOMz7irNz0PSQLg8V/o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4F0763522FA4; Wed,  7 Oct 2020 14:05:03 -0700 (PDT)
Date:   Wed, 7 Oct 2020 14:05:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] srcu: avoid escaped section names
Message-ID: <20201007210503.GR29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com>
 <20200930204044.GZ29330@paulmck-ThinkPad-P72>
 <CAKwvOd=nabONrWyYFK7Y06TrKBOyHHfNUiiy69VJQ2NtCpbp5Q@mail.gmail.com>
 <20201002205130.GK29330@paulmck-ThinkPad-P72>
 <CAKwvOdkPMSwQneMLFNg3ihM5zHorFy+uGvzAL7y70+hu_1q24w@mail.gmail.com>
 <CA+icZUW_z5nJ1c69JS7Nm1QknF+CH+sPkhF4g2+L=d=H-vxVgw@mail.gmail.com>
 <20201005184910.GC29330@paulmck-ThinkPad-P72>
 <20201006065623.GA2418984@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006065623.GA2418984@ubuntu-m3-large-x86>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 05, 2020 at 11:56:23PM -0700, Nathan Chancellor wrote:
> On Mon, Oct 05, 2020 at 11:49:10AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 05, 2020 at 08:38:42PM +0200, Sedat Dilek wrote:
> > > On Mon, Oct 5, 2020 at 8:29 PM 'Nick Desaulniers' via Clang Built
> > > Linux <clang-built-linux@googlegroups.com> wrote:
> > > >
> > > > On Fri, Oct 2, 2020 at 1:51 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Wed, Sep 30, 2020 at 01:55:48PM -0700, Nick Desaulniers wrote:
> > > > > > On Wed, Sep 30, 2020 at 1:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 29, 2020 at 12:25:49PM -0700, Nick Desaulniers wrote:
> > > > > > > > The stringification operator, `#`, in the preprocessor escapes strings.
> > > > > > > > For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> > > > > > > > they treat section names that contain \".
> > > > > > > >
> > > > > > > > The portable solution is to not use a string literal with the
> > > > > > > > preprocessor stringification operator.
> > > > > > > >
> > > > > > > > Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> > > > > > > > Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
> > > > > > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > > >
> > > > > > > I am guessing that this needs to go up with other patches.  If so:
> > > > > > >
> > > > > > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > >
> > > > > > > If not, let me know and I will queue it.
> > > > > >
> > > > > > I could have bundled them up as a series.  I think you can pick it up,
> > > > > > and I'll owe you a beer?
> > > > >
> > > > > It is queued, thank you!
> > > > >
> > > > > When does it need to hit mainline?  (Your default is the v5.11 merge
> > > > > window, that is, the one following the upcoming merge window.)
> > > >
> > > > No rush, this patch wasn't blocking any known issue, just a cleanup
> > > > while I was in the neighborhood.  100 years ago, I was an Eagle scout.
> > > > Pretty sure there was a motto about "leaving things better than you
> > > > found them."  Thanks for help resolving the merge conflict reported in
> > > > -next related to it.
> > > 
> > > Wasn't there a problem with your "Fixes:" tag (Fixes: *drop word
> > > "commit"* commit_hashid ("...")?
> > 
> > Indeed there was, and I have it noted to be fixed on my next rebase.
> > 
> > Perhaps another reason not to rush to mainline though.  ;-)
> > 
> > 							Thanx, Paul
> 
> I am replying here as well so that the relevant parties are in the know
> but I believe this patch should be fast tracked with a cc stable tag as
> this appears to be the root cause of the issue that Nick reported a few
> weeks ago:
> 
> https://lore.kernel.org/rcu/CAKwvOdm4AQhobdkKT08bjPGb15N58QN79XWxEaQt-P5Dk4+avQ@mail.gmail.com/
> https://github.com/ClangBuiltLinux/linux/issues/1081
> 
> I can reproduce the issue on next-20201002 on my Raspberry Pi 4 just by
> booting it up. As soon as I apply this patch, all warnings disappear. I
> asked the original reporters to test if the patch resolves the issue for
> them but I figured more visibility on this, the sooner. The commit
> message might need to be revised if this turns out to be the case to
> make it more apparent that it has a user visible issue, rather than just
> a QoL fix.
> 
> Additionally, it seems like the patch is missing some reviewed by tags
> from Kees, Sedat, and myself. Feel free to add a
> 
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> as well.

Good catch, and apologies to all concerned!  I have removed the stray
"commit" and, based posts earlier in this thread, I have also added:

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

Thank you all!

							Thanx, Paul
