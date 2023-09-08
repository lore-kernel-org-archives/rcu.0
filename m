Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC85EE8001
	for <rcu@archiver.kernel.org>; Fri,  8 Sep 2023 13:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbjIHNxt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Sep 2023 09:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjIHNxs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Sep 2023 09:53:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61E11BF6
        for <rcu@vger.kernel.org>; Fri,  8 Sep 2023 06:53:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so34495241fa.3
        for <rcu@vger.kernel.org>; Fri, 08 Sep 2023 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694181221; x=1694786021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sk5RLnrnvhNAIkRA+BMVhrpIi3v+xSod2h+zzv+FwRU=;
        b=E6FTV/ARJc1sPI9xs3Qz7wXyJCizcsvUj/Wqt9MiNd/8fi3EG1YvRDeDLltZ+AFy1K
         Z2KENS9zv9mjSmuhv8Jws2d5an3r72iIMpyLeTY1bbe2u+HXIJIYitAqHBv2CLTd6PJh
         VYW+0TSsh+ibTgejXdch2PBNU9ufU3gNCksdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694181221; x=1694786021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sk5RLnrnvhNAIkRA+BMVhrpIi3v+xSod2h+zzv+FwRU=;
        b=HvCKYglQ4zCmDqOoSUd70o8RKu0k0nKp77tgrXM+K6GVuWp/mRrjrcD1k/tMk7PcRd
         8C9suL+nebe7zECRcBG6Dq1givrL7/gCFCZMbLSdiZLtB2oDmUcOZwestPjMSvblwoux
         z76YL3zspmxV+/R+5Ho7Xk10o2pXABqGJu/cWiOMFh4xrsZKxTDSUBn220mCtqDotdpN
         jeUIXcwxZ5zs+401CeWyr1XszWP+E7esb9Kl1XQ2G0y/UWfNyCzNKEVdZerg2zvTAzZP
         zWZlGgir7Dx8unaaFITE1dnRds2hUXIAh+ECW6VBcBMqblqrCd98aNAZ/ewF16cMuTpl
         7RdQ==
X-Gm-Message-State: AOJu0YwSjns1H5zYxcNe1v4rn4gGVmRAtseIb3MnK5U8KBcJmGtdUJe7
        XkvAM4xrw142Etxwf7EqGaDvtPMfCWjrCYWlvADCsg==
X-Google-Smtp-Source: AGHT+IEIHTIzxn4/TggJPFsx2XF99VqeSdnxqqoXJAUrJV1HapjE/VT2B66m9pwyvnmkKIa4qoDwrI1qc7nClGYo53s=
X-Received: by 2002:a2e:86c4:0:b0:2bd:beb:4aca with SMTP id
 n4-20020a2e86c4000000b002bd0beb4acamr1950228ljj.13.1694181220873; Fri, 08 Sep
 2023 06:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230908033047.2537010-1-joel@joelfernandes.org> <df66924b-d484-457f-8c79-21aadc4c13ec@paulmck-laptop>
In-Reply-To: <df66924b-d484-457f-8c79-21aadc4c13ec@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Sep 2023 09:53:30 -0400
Message-ID: <CAEXW_YTjDM9LWKiupgOXwfsz7RnNT24UEQ=RZB+3n1VdJRNqvw@mail.gmail.com>
Subject: Re: [PATCH v2] rcu/torture: Improve badness extraction from console logs
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 8, 2023 at 8:08=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Fri, Sep 08, 2023 at 03:30:46AM +0000, Joel Fernandes (Google) wrote:
> > Currently console.log.diags contains an output like follows:
> > [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 rcu_t=
asks_trace_pregp_step+0x4a/0x50
> > [ 2457.542385] Call Trace:
> >
> > This is not very useful and easier access to the call trace is desired.
> > Improve the script by extracting more lines after each grep match.
> > Provide a summary in the beginning like before, but also include detail=
s
> > below. Limit the total number of issues to a maximum of 10. And limit
> > the lines included after each issue to a maximum of 20.
>
> Much better!
>
> The above commit log would be better something as follows:

Looks good to me, I will update it to use your version, thanks.

> ------------------------------------------------------------------------
>
> Plus please see one simplification below.
>
>                                                         Thanx, Paul
>
> > With these changes the output becomes:
> >
> > Issues found:
> > Line 6228: [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h=
:1061 rcu_tasks_trace_pregp_step+0x4a/0x50
> > Line 6245: [ 2457.542385] Call Trace:
> >
[...]
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > v1->v2: Limit number of issues reported and include summary on the top.
> >
> >  .../rcutorture/bin/console-badness.sh         | 42 ++++++++++++++++++-
> >  1 file changed, 41 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh =
b/tools/testing/selftests/rcutorture/bin/console-badness.sh
> > index aad51e7c0183..2612a4931723 100755
> > --- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
> > @@ -9,10 +9,50 @@
> >  # Copyright (C) 2020 Facebook, Inc.
> >  #
> >  # Authors: Paul E. McKenney <paulmck@kernel.org>
> > +INPUT_DATA=3D$(< /dev/stdin)
>
> Long runs can have extremely large console.log files, which might not
> play well with shell variables.  So this really needs to go into a file.

Thanks a lot for this feedback. Just for completeness -- it is the
grepped lines (containing bad strings) that go into a shell variable,
not the whole file. That can still be quite large so your suggestion
is well taken and I will make the changes as you suggested!

[...]
> One issue here is that if a number of badness strings occur in console.lo=
g
> in quick succession, there will be overlapping output, as in a given line
> from console.log might be printed many times.  For example, "WARNING"
> is often almost immediately followed by "Call Trace".
>
> In that case, is there a nice way to print the lines starting with the
> line containing "WARNING" though the 20 lines following "Call Trace"?

Yes, maybe I can coalesce them somehow since we do have the line
numbers. Thanks for the suggestion! I did notice that too but now that
you mention, I will improve on that.

Will post another version soon, thanks!

 - Joel
