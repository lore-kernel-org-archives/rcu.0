Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F456EEB57A
	for <rcu@archiver.kernel.org>; Sat,  9 Sep 2023 00:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjIIAKw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Sep 2023 20:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjIIAKv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Sep 2023 20:10:51 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8757133
        for <rcu@vger.kernel.org>; Fri,  8 Sep 2023 17:10:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68c0d886ea0so2268139b3a.2
        for <rcu@vger.kernel.org>; Fri, 08 Sep 2023 17:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694218246; x=1694823046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXRgg4Cd9JoAnX2OGvZKIPLL7dbERwK3wqoFSn2ttvk=;
        b=gGVCEuUCtXXKa8Ymmiug7qxxQkSnbfGTv/h8Umukq4CivaH+0t3BlHdmmcPjUhLYvN
         YaZvX7uPRRwJ0m+lAvpC0LSVdKz7/Z3xzAvqBvqKC7y4juwYPjjZQB2b22q93Gcdf0eq
         RbnEeKcIVTCYxBz7Is3FhG7+ViJcDsHwiSUCOX/1RPmuxv14MyyKvg9fmdGhhGKL4qYn
         5D+h/y5nBMGt4mKyO3jNGYrrSDWfR3+jF612FzcNEMkFm07531CCO5VnuatNsqs0wENy
         6GDLNxCDcfLkGOWWXRHtqtaqwgkbOot3u0/ud8ImbgAOsKZyl9gQJ4e0UM6n4Tt78Pf1
         Mlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694218246; x=1694823046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXRgg4Cd9JoAnX2OGvZKIPLL7dbERwK3wqoFSn2ttvk=;
        b=NkTKb5FBNTrKr3H4c2SeMiy5IMsJxXSyZRXamk5Q7kVqZBrrB2qmYjyzJuVGdBFlA5
         a0lScSm7MlPRgSe48NI5A0kUypBCACXSQ4aoqweAU5D3ZC2myRrh3WMLePBpXmxCu0Ek
         O/3e8GB3PV9BRP42icxYoZQWmAEcgsEi8M+YgSt2WMBrUwmUqZwX0oNNgJ73cIjBneFJ
         ERzm4BfPZyW0+xUUXpxEi+9Kny5yWo1ss3WpSXsY7QGS+Vj8H/9GYUIAO6tqMao2f60w
         3fB4h0hSxQpcMLdKftwX/19fjycvSqerZ0Goigg3g5m7itF6lKOnyH8yLv73QRULSgKJ
         AWvA==
X-Gm-Message-State: AOJu0YwuGMsOxA1NHkr/AuZym51vRyBReDkb4Q/UmOaNDHw6PXkgkc7s
        jFmwLF90YJxLpQ1VteF9LSd+9/vr1RlIL6sSYa66skJ9kxi5rQ==
X-Google-Smtp-Source: AGHT+IFol84E++Quad499asRIYInXU2kx4/NSa49IWyjou/7pLAa4jWVJmTnDwxejvLg76j4JUfNrjOe/qI0WMHFA00=
X-Received: by 2002:a05:6a21:a103:b0:14e:b4d5:782e with SMTP id
 aq3-20020a056a21a10300b0014eb4d5782emr4131002pzc.29.1694218245987; Fri, 08
 Sep 2023 17:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJWu+ooLBjAhZbHa+64egmh53-n7qc_o+PvsfSt2hzQNrVhdqw@mail.gmail.com>
 <208d035b-a411-40d0-bb5e-59deb6a785e6@paulmck-laptop> <CAABZP2yFk=boa6UypsccRKr2TGpJq+a1odmibKNDHVNRz6c1-Q@mail.gmail.com>
 <CAABZP2wntT5=rdQpf+BeqmjfiBvtHpT=L5B8uWCd6q8e3aKQOA@mail.gmail.com>
In-Reply-To: <CAABZP2wntT5=rdQpf+BeqmjfiBvtHpT=L5B8uWCd6q8e3aKQOA@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sat, 9 Sep 2023 08:10:35 +0800
Message-ID: <CAABZP2zdndfw99MDA-L=i62sHiZ9XCCXDrCMxFsrzakZiVmyBw@mail.gmail.com>
Subject: Re: [BUG] TREE04 hang on 6.5.y stable: Writer stall state RTWS_COND_SYNC_FULL
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Sep 9, 2023 at 7:33=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.com> w=
rote:
>
> On Fri, Sep 8, 2023 at 6:28=E2=80=AFPM Zhouyi Zhou <zhouzhouyi@gmail.com>=
 wrote:
> >
> > On Fri, Sep 8, 2023 at 1:59=E2=80=AFAM Paul E. McKenney <paulmck@kernel=
.org> wrote:
> > >
> > > On Thu, Sep 07, 2023 at 09:17:15AM -0400, Joel Fernandes wrote:
> > > > Hi,
> > > > Just started seeing this on 6.5 stable. It is new and first occurre=
nce:
> > > >
> > > > TREE04 no success message, 234 successful version messages
> > > >  [033mWARNING:  [mTREE04 GP HANG at 14 torture stat 2
> > > > [   38.371120] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1253
> > > > f0x0 ->state 0x2 cpu 6
> > > > [   38.388342] Call Trace:
> > > > [   53.741039] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g3637
> > > > f0x2 ->state 0x2 cpu 6
> > > > [   69.093462] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g5501
> > > > f0x0 ->state 0x2 cpu 6
> > > > [   84.450028] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1050=
5
> > > > f0x0 ->state 0x2 cpu 6
> > > > [   99.815871] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1378=
1
> > > > f0x0 ->state 0x2 cpu 6
> > > > [  115.166476] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1654=
4
> > > > f0x0 ->state 0x2 cpu 6
> > > > [  130.550116] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1894=
1
> > > > f0x0 ->state 0x2 cpu 6
> > > > [..]
> > > >
> > > > All logs:
> > > > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6=
.5.y/17/artifact/tools/testing/selftests/rcutorture/res/2023.09.07-04.10.25=
/TREE04/
> > >
> > > Huh.  Does this happen for you in v6.5 mainline?
> > Hi, I am started torture.sh in a kvm environment (with nested kvm
> > enable) in my Intel  i7-1165G7 laptop, which can be examined at
> > runtime:
> > http://154.220.3.120:8080/test/linux-stable/tools/testing/selftests/rcu=
torture/res/2023.09.08-10.23.47-torture/
> again I can't reproduce the bug in my environment, I will try it more tim=
es.
besides my laptop, I also started the test on PPC vm of Open Source
lab of Oregon State University:
http://140.211.169.189/stable/linux/tools/testing/selftests/rcutorture/res/=
2023.09.09-00.07.55-torture/
> the git head is  3766ec12cf89
>
> System stability is a profound knowledge, there is too much for me to
> learn from the community.
> Thanks
> Zhouyi
> >
> > Hope I can be of some beneficial
> > Thanks
> > Zhouyi
> > >
> > > Both the code under test (full-state polled grace periods) and the
> > > rcutorture test code are fairly new, so there is some reason for gene=
ral
> > > suspicion.  ;-)
> > >
> > >                                                         Thanx, Paul
