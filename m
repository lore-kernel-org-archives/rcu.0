Return-Path: <SRS0=HuQd=5F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7ABC4332B
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 15:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2399620782
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 15:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GeHU0qas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCTPml (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:42:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34357 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgCTPml (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Mar 2020 11:42:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id 10so5278042qtp.1
        for <rcu@vger.kernel.org>; Fri, 20 Mar 2020 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g19Z0AL+oVzZVOxsXjEEVkUP9hXqPLhiX7vvspZjbqI=;
        b=GeHU0qasNum+zVdPSku/i6ICaKR+0jlY9lNkWGfDEY88SDquDjyClFQj4YeHsCmstA
         JPJXOINAfSjzPx0s5sdkQ1RajQHqnwgfL5lpolECr6wGfFDEnlYmzqLJy9MqQnJMHR1m
         c9L6IoIscpHJ/Te5V7E9jmNwn1b3B2ZtbTtgZoYTeZ4j/SyefmoT1qyZIgnNrI15266K
         QB0OvKfeegfWue3ITp0q4NhEyJDFfJuZia5tyIvDf8vGEFp5sPmeOZE+KIvQQwYJFC4r
         yyezUkMhxMaILYd1XNLpNuATIaCIg0r6/J3qsOMblXgqTuHg045DnnzdRYva/r9hUjmm
         UjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g19Z0AL+oVzZVOxsXjEEVkUP9hXqPLhiX7vvspZjbqI=;
        b=oGsVpfhbMUPzcLLPD81K/b6yKW5piNk53m57GOX2RWiYh1494hp4UHC0GPFafVYyA3
         qcbEYYxgzu0p3Xwjwqyjmno8VqnF9AVdwTjqXvbMKlWPd56Ft6uGQtsrvi8pzKw96K6s
         JpzMKUe6EiGzOn/CQB1OtLCf99z1W6JUFODs9EXHnJEd5upje6igrn40aFXaRx9SR2Y8
         ioU7jCBNMcEzai7DJFEVQG4bUe2tq47tgtv123fwT7xi/9benUoV35phJv0vj/nBKX5d
         HZ4B580RcY9NDjOS8nHTEX/RjNXmA83kGjAnzExy7Vfk/YwycDJPs7MfLWEhN9O5LQ3O
         FRyQ==
X-Gm-Message-State: ANhLgQ1TnAZfBfzs3oCKToqw+zo5CBCLsn0cleT6m7WxRNfYeR2AGvvw
        FjdPuXXuP6ZcpMNUM4HkfOwB7YWK0JABbItC15GZ3g==
X-Google-Smtp-Source: ADFU+vsrnn9HPcrtgg6UFQhymtJaLKpvGdgNd/d3WOK1WBTFnJHRkmZg7jpdDN5mXDrdEDsRekV1NLmgwILxGkOxBwI=
X-Received: by 2002:aed:2591:: with SMTP id x17mr8919616qtc.380.1584718959600;
 Fri, 20 Mar 2020 08:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ae2ab305a123f146@google.com> <CACT4Y+a_d=5TNZth0dPov0B7tB5T9bAzWXBj1HjhXdn-=0KOOg@mail.gmail.com>
 <20200318214109.GV3199@paulmck-ThinkPad-P72> <CACT4Y+ZhP_Qu+WZ4t2dLjd__H+rUKCTRCNoghvW9Uf3QQYRcNg@mail.gmail.com>
 <20200320130822.GF4650@kadam>
In-Reply-To: <20200320130822.GF4650@kadam>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Mar 2020 16:42:28 +0100
Message-ID: <CACT4Y+aCAYdYx9QPLUVdAOzhvYSA-n_wASaqAD8OUTioiHgsQQ@mail.gmail.com>
Subject: Re: linux-next build error (8)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        syzbot <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 20, 2020 at 2:11 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Mar 19, 2020 at 08:13:35AM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> > On Wed, Mar 18, 2020 at 10:41 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Wed, Mar 18, 2020 at 09:54:07PM +0100, Dmitry Vyukov wrote:
> > > > On Wed, Mar 18, 2020 at 5:57 PM syzbot
> > > > <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    47780d78 Add linux-next specific files for 20200318
> > > > > git tree:       linux-next
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14228745e00000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=b68b7b89ad96c62a
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=792dec47d693ccdc05a0
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > >
> > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > Reported-by: syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com
> > > > >
> > > > > kernel/rcu/tasks.h:1070:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_qs'?
> > > >
> > > > +rcu maintainers
> > >
> > > The kbuild test robot beat you to it, and apologies for the hassle.
> > > Fixed in -rcu on current "dev" branch.
> >
> > If the kernel dev process would only have a way to avoid dups from all
> > test systems...
>
> We could make a mailing list for recording it, and then just grep the
> mailbox for the file and function.

As far as I understand Paul was already aware of the breakage and both
reports. Also how do we make all kernel testing out there to respect
this new list?....

> Or we could just assume that kbuild is going to find almost all the
> build errors.

Paul mentioned that they don't sometimes ("but they seem to sometimes
get too far behind for me to
be willing to wait that long"). Lots of people mentioned this on the
last LPC as well. It's not completely transparent and not part of the
kernel project to rely on it (how do we add new configs? how do we
urgently repair it? etc).
