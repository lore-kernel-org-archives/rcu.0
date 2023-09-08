Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5CDEEB570
	for <rcu@archiver.kernel.org>; Fri,  8 Sep 2023 23:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345291AbjIHXdm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243604AbjIHXdm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Sep 2023 19:33:42 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77EE133
        for <rcu@vger.kernel.org>; Fri,  8 Sep 2023 16:33:38 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so2400219b3a.2
        for <rcu@vger.kernel.org>; Fri, 08 Sep 2023 16:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694216018; x=1694820818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWt3Zew+i5UbjBt7hTAD/VXHpebXMNKr0csK+fBZ1bk=;
        b=Fgltsr5DRHnkVYioCHBin5coZcF3ST+YbXaUbjs2jIAmMAUzoMrYZiDFsNfwY2u417
         8maBaifn5AiT0wZkulvFfp6RfqhaZlvSYnJseJj90kWao59MJsOp5Ht1VailTeWG1Ydf
         ICt/xfT5b2A6/AtF4aJv9qTd6zW+c9CUjbdS/5jqgNIRBWWkkVd1Z3agize9VVQLibo1
         Ze7u7Vd3BERAY/c+fVszVh1gFus6zw5TDmx6rDwo/+oPF2m/e07enTn8QtvGY6yuKedF
         gjY8hn+0Btj7mKhxgCqIg9OlpRCfjbJB7uvUKOb9em7n0V8UPjIGMM0YU9pPGi89/CxP
         +8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694216018; x=1694820818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWt3Zew+i5UbjBt7hTAD/VXHpebXMNKr0csK+fBZ1bk=;
        b=FwonwfypYyQx/MfQy/DkVKxAE8w8tkfkStJxj0BI0PSN8yM8QkfyEV28zj9xIM6zjD
         78zgaLVexlWMqVb2VmeXqC2if3+4b4qhpQHQnvOFt5ncd0ok1damVBrta2uXPwkC2yCg
         mJxlzBWLtb5Q45n/iu+vfGRyKJ2xZdVyCZu96d9W7VzkRZqM6yMmzFszkzOJcozQl3ve
         SL/5STtbs3s82adTpih7AdvuXJhnTx6m9LoO/iynqBh76lpmW9ShDHy4cW/2otPKtHcR
         ELYs/ZE62W8Rs30F+PZ6OKtm/iZJt7c4FRqNi0Qb83vsGCoOPWiOrh/1EJRQaJAOKNEX
         do/g==
X-Gm-Message-State: AOJu0YxO9fphC+XOwaewrpjzspjwmS8CJsmvRWqw7S9rwnSIHeklCt4c
        2wQR8tTz1TWXnn5Rl/HYomVvUuQ9H/RPwCJKe44=
X-Google-Smtp-Source: AGHT+IHgCi8U6OPxGO8goraRb0igm9V8qTwbCwnkhmbcrtG13FMK90Oiz2RiFg/GchCTU22ysuXjh+LtoGebXON4Jvc=
X-Received: by 2002:a05:6a20:7fa7:b0:141:69d:8041 with SMTP id
 d39-20020a056a207fa700b00141069d8041mr5245190pzj.48.1694216017993; Fri, 08
 Sep 2023 16:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJWu+ooLBjAhZbHa+64egmh53-n7qc_o+PvsfSt2hzQNrVhdqw@mail.gmail.com>
 <208d035b-a411-40d0-bb5e-59deb6a785e6@paulmck-laptop> <CAABZP2yFk=boa6UypsccRKr2TGpJq+a1odmibKNDHVNRz6c1-Q@mail.gmail.com>
In-Reply-To: <CAABZP2yFk=boa6UypsccRKr2TGpJq+a1odmibKNDHVNRz6c1-Q@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sat, 9 Sep 2023 07:33:27 +0800
Message-ID: <CAABZP2wntT5=rdQpf+BeqmjfiBvtHpT=L5B8uWCd6q8e3aKQOA@mail.gmail.com>
Subject: Re: [BUG] TREE04 hang on 6.5.y stable: Writer stall state RTWS_COND_SYNC_FULL
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 8, 2023 at 6:28=E2=80=AFPM Zhouyi Zhou <zhouzhouyi@gmail.com> w=
rote:
>
> On Fri, Sep 8, 2023 at 1:59=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
> >
> > On Thu, Sep 07, 2023 at 09:17:15AM -0400, Joel Fernandes wrote:
> > > Hi,
> > > Just started seeing this on 6.5 stable. It is new and first occurrenc=
e:
> > >
> > > TREE04 no success message, 234 successful version messages
> > >  [033mWARNING:  [mTREE04 GP HANG at 14 torture stat 2
> > > [   38.371120] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1253
> > > f0x0 ->state 0x2 cpu 6
> > > [   38.388342] Call Trace:
> > > [   53.741039] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g3637
> > > f0x2 ->state 0x2 cpu 6
> > > [   69.093462] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g5501
> > > f0x0 ->state 0x2 cpu 6
> > > [   84.450028] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g10505
> > > f0x0 ->state 0x2 cpu 6
> > > [   99.815871] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g13781
> > > f0x0 ->state 0x2 cpu 6
> > > [  115.166476] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g16544
> > > f0x0 ->state 0x2 cpu 6
> > > [  130.550116] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g18941
> > > f0x0 ->state 0x2 cpu 6
> > > [..]
> > >
> > > All logs:
> > > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.5=
.y/17/artifact/tools/testing/selftests/rcutorture/res/2023.09.07-04.10.25/T=
REE04/
> >
> > Huh.  Does this happen for you in v6.5 mainline?
> Hi, I am started torture.sh in a kvm environment (with nested kvm
> enable) in my Intel  i7-1165G7 laptop, which can be examined at
> runtime:
> http://154.220.3.120:8080/test/linux-stable/tools/testing/selftests/rcuto=
rture/res/2023.09.08-10.23.47-torture/
again I can't reproduce the bug in my environment, I will try it more times=
.
the git head is  3766ec12cf89

System stability is a profound knowledge, there is too much for me to
learn from the community.
Thanks
Zhouyi
>
> Hope I can be of some beneficial
> Thanks
> Zhouyi
> >
> > Both the code under test (full-state polled grace periods) and the
> > rcutorture test code are fairly new, so there is some reason for genera=
l
> > suspicion.  ;-)
> >
> >                                                         Thanx, Paul
