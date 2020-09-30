Return-Path: <SRS0=4XKx=DI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C22FC4727F
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 14:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D874920780
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 14:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbgJAOu7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Oct 2020 10:50:59 -0400
Received: from smtprelay0218.hostedemail.com ([216.40.44.218]:38140 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732207AbgJAOu7 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 1 Oct 2020 10:50:59 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 1E9C4181200F0
        for <rcu@vger.kernel.org>; Wed, 30 Sep 2020 18:57:05 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B102C2C9D;
        Wed, 30 Sep 2020 18:57:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soap41_0b0aa1027195
X-Filterd-Recvd-Size: 2464
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Sep 2020 18:57:01 +0000 (UTC)
Message-ID: <133589afbe999347454dfcc46ae782897bf9e3a2.camel@perches.com>
Subject: Re: [PATCH v2] srcu: avoid escaped section names
From:   Joe Perches <joe@perches.com>
To:     sedat.dilek@gmail.com, Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Date:   Wed, 30 Sep 2020 11:57:00 -0700
In-Reply-To: <CA+icZUVgfnVQ1=zjUGhGKnJAs9g3Q06sWN3ffNdrfZMZLCEkbA@mail.gmail.com>
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
         <20200929192549.501516-1-ndesaulniers@google.com>
         <CA+icZUVgfnVQ1=zjUGhGKnJAs9g3Q06sWN3ffNdrfZMZLCEkbA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 2020-09-30 at 18:41 +0200, Sedat Dilek wrote:
> On Tue, Sep 29, 2020 at 9:25 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> > The stringification operator, `#`, in the preprocessor escapes strings.
> > For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> > they treat section names that contain \".
> > 
> > The portable solution is to not use a string literal with the
> > preprocessor stringification operator.
> > 
> > Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> > Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Puh, remember one year ago an overnight bisecting to catch the root
> cause for "escaped section names".
> 
> The two patches I see - this here and "export.h: fix section name for
> CONFIG_TRIM_UNUSED_KSYMS for Clang" were new cases?
> 
> Do we have a check-script to catch/avoid such cases (Joe Perches?)?

Try the script that removes #S from #define __section(S)

https://lore.kernel.org/lkml/0e582a7f5144a33f465978d97701f9b3dcc377f3.camel@perches.com/

