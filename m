Return-Path: <SRS0=Nt6M=DN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF19C41604
	for <rcu@archiver.kernel.org>; Tue,  6 Oct 2020 06:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC69205ED
	for <rcu@archiver.kernel.org>; Tue,  6 Oct 2020 06:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgJHrKjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgJFG42 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Oct 2020 02:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgJFG41 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Oct 2020 02:56:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6B3C061755;
        Mon,  5 Oct 2020 23:56:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i3so1151667pjz.4;
        Mon, 05 Oct 2020 23:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zBFfKBhYyU0BtbuXx1ytS4yKHobNdT3L7z7UjpAJros=;
        b=kgJHrKjSonX86RVyPSZeK3n/eKSf3Z5iXCkubCL03B3xjIlw1I3UVJ5Oz6oldmemu+
         6rJaL5DsTUyCupB4FYMEDWaEzoKMDYYXIQOzUgjn5hUWTJy59aH+ZNZ62Wd5BhngbW+1
         0t/iPMHM6DE34xJiMl00x6wskZr1nXO7FFDAXeHWWClyXlHaK4doUjutMC2RfUGt6v1H
         aNu6t9dcg6fA8UquACGkeYCbd8l8RxkDsn0fPe19wpct/YACSiqaDcOtAkkIYP1k3T/E
         skQ03oqS+ySD5bD1roJ9TodIimXd3IeQU7kggLi5lG4G9zbMkMHvREwF+SRpEL16PkSd
         QQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zBFfKBhYyU0BtbuXx1ytS4yKHobNdT3L7z7UjpAJros=;
        b=mq88bkJ/7vRmN2lkWxa5Lm1iog5+KphQF3TqBTKIQOB1bvmPg4P5fwYPYN4CGSNBpE
         UxKF5Nq8jW2j/AOaDC+CxCjqDuyGydPd0J5raoFdu5jKyuFjosiAIPOS8uyjtg1Z90gl
         l9i+Y/ejTLCylTUGc4XNPmr32qXoha4YKWG/xmZfNal9vvOJhQTo/q7HKCBF8O9FrFyR
         kwFZHJ13SbUtTqndl42LdAe3Ouk4XRUzXkyS3aTL00AnafXVjAFcS0a9eA06Vn1AGjME
         PH91gr53mbMbslGub6PE3Krg/8ugS5ynw2J5rrFhLdCse2YT7ozpsP5t/wq7lbzDNLex
         WLwQ==
X-Gm-Message-State: AOAM532sTB0ZLw0mt0U3XvsdbFa7uwECs5tuGedrSffQUq8+Kd+E8iKo
        Ho8PIJQNq6cgbqxAx0sL1i8=
X-Google-Smtp-Source: ABdhPJyMkxuEeZ7MXGRLAPbbNrvhXEYbnB5A9eIh229n8RdwQydJJiqZO5UUjbb6Ulu9S4QCxG/8bA==
X-Received: by 2002:a17:902:8693:b029:d3:9c6b:ca5f with SMTP id g19-20020a1709028693b02900d39c6bca5fmr1958085plo.67.1601967386593;
        Mon, 05 Oct 2020 23:56:26 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id h9sm2042609pfh.213.2020.10.05.23.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 23:56:25 -0700 (PDT)
Date:   Mon, 5 Oct 2020 23:56:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20201006065623.GA2418984@ubuntu-m3-large-x86>
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com>
 <20200930204044.GZ29330@paulmck-ThinkPad-P72>
 <CAKwvOd=nabONrWyYFK7Y06TrKBOyHHfNUiiy69VJQ2NtCpbp5Q@mail.gmail.com>
 <20201002205130.GK29330@paulmck-ThinkPad-P72>
 <CAKwvOdkPMSwQneMLFNg3ihM5zHorFy+uGvzAL7y70+hu_1q24w@mail.gmail.com>
 <CA+icZUW_z5nJ1c69JS7Nm1QknF+CH+sPkhF4g2+L=d=H-vxVgw@mail.gmail.com>
 <20201005184910.GC29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005184910.GC29330@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 05, 2020 at 11:49:10AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 05, 2020 at 08:38:42PM +0200, Sedat Dilek wrote:
> > On Mon, Oct 5, 2020 at 8:29 PM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> > >
> > > On Fri, Oct 2, 2020 at 1:51 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Wed, Sep 30, 2020 at 01:55:48PM -0700, Nick Desaulniers wrote:
> > > > > On Wed, Sep 30, 2020 at 1:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Sep 29, 2020 at 12:25:49PM -0700, Nick Desaulniers wrote:
> > > > > > > The stringification operator, `#`, in the preprocessor escapes strings.
> > > > > > > For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> > > > > > > they treat section names that contain \".
> > > > > > >
> > > > > > > The portable solution is to not use a string literal with the
> > > > > > > preprocessor stringification operator.
> > > > > > >
> > > > > > > Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> > > > > > > Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
> > > > > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > >
> > > > > > I am guessing that this needs to go up with other patches.  If so:
> > > > > >
> > > > > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > >
> > > > > > If not, let me know and I will queue it.
> > > > >
> > > > > I could have bundled them up as a series.  I think you can pick it up,
> > > > > and I'll owe you a beer?
> > > >
> > > > It is queued, thank you!
> > > >
> > > > When does it need to hit mainline?  (Your default is the v5.11 merge
> > > > window, that is, the one following the upcoming merge window.)
> > >
> > > No rush, this patch wasn't blocking any known issue, just a cleanup
> > > while I was in the neighborhood.  100 years ago, I was an Eagle scout.
> > > Pretty sure there was a motto about "leaving things better than you
> > > found them."  Thanks for help resolving the merge conflict reported in
> > > -next related to it.
> > 
> > Wasn't there a problem with your "Fixes:" tag (Fixes: *drop word
> > "commit"* commit_hashid ("...")?
> 
> Indeed there was, and I have it noted to be fixed on my next rebase.
> 
> Perhaps another reason not to rush to mainline though.  ;-)
> 
> 							Thanx, Paul

I am replying here as well so that the relevant parties are in the know
but I believe this patch should be fast tracked with a cc stable tag as
this appears to be the root cause of the issue that Nick reported a few
weeks ago:

https://lore.kernel.org/rcu/CAKwvOdm4AQhobdkKT08bjPGb15N58QN79XWxEaQt-P5Dk4+avQ@mail.gmail.com/
https://github.com/ClangBuiltLinux/linux/issues/1081

I can reproduce the issue on next-20201002 on my Raspberry Pi 4 just by
booting it up. As soon as I apply this patch, all warnings disappear. I
asked the original reporters to test if the patch resolves the issue for
them but I figured more visibility on this, the sooner. The commit
message might need to be revised if this turns out to be the case to
make it more apparent that it has a user visible issue, rather than just
a QoL fix.

Additionally, it seems like the patch is missing some reviewed by tags
from Kees, Sedat, and myself. Feel free to add a

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

as well.

Cheers,
Nathan
